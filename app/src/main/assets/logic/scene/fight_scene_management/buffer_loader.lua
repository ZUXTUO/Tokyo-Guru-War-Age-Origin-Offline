BufferLoader = Class("BufferLoader");

function BufferLoader:Init()
	self.fightScript = nil;
	self.needWait = {}; -- 需要等待有位置后再开始刷的列表
	self.groupInfo = {}; -- buff刷出信息
end

function BufferLoader:GetItemAssetFileList(out_file_list)
	if not self.fightScript or not self.fightScript.buff_group then
		return;
	end
	for k, buff_group in ipairs(self.fightScript.buff_group) do
		for kk, buff_list in ipairs(buff_group) do
			for kkk, buff in ipairs(buff_list) do
				local cfg = ConfigManager.Get(EConfigIndex.t_world_item, buff.buff_id); 
				if nil ~= cfg.model_id or 0 ~= cfg.model_id then
					local filePath = ObjectManager.GetItemModelFile(cfg.model_id);
					out_file_list[filePath] = filePath
				end
			end
		end
	end
end

function BufferLoader:OnEvent_DeleteObj(name)
	local del_pos_name;
	for group_id, group_info in pairs(self.groupInfo) do
		for k,info in pairs(group_info.buffList) do
			if info.obj == name then
				table.remove(self.groupInfo[group_id].buffList,k);
				del_pos_name = info.pos;
				break;
			end
		end
	end
	if del_pos_name then
		self:_DetectionClearRefresh(del_pos_name);
		NoticeManager.Notice(ENUM.NoticeType.DeleteBufferItem, name)
	end
end

-- 获取所有buff sceneEntity name
function BufferLoader:GetAllBuffName()
	local names = {}
	for group_id,group_info in pairs(self.groupInfo) do
		for k,info in pairs(group_info.buffList) do
			table.insert(names, info.obj)
		end
	end
	return names;
end

function BufferLoader:SetScript(script)
	self.fightScript = script;
end

function BufferLoader:OnStart()
	if self.fightScript == nil then
		return;
	end

	local group_id = 1;
	local buff_data = self:_GetBuffData(group_id);
	while(buff_data)do
		self.groupInfo[group_id] = {};
		self.groupInfo[group_id].buffList = {};
		self.groupInfo[group_id].timerid = timer.create(
			Utility.create_callback_ex(BufferLoader._NextItem, true, 0, self, group_id, 1),
			buff_data.begin_time*1000,
			1 );
		group_id = group_id+1;
		buff_data = self:_GetBuffData(group_id);
	end
end

function BufferLoader:Destroy()
	if self.groupInfo then
		for k,v in pairs(self.groupInfo) do
			if v.timerid then
				timer.stop(v.timerid);
			end
		end
	end
	self.groupInfo = nil;
end

function BufferLoader:Pause()
	if self.groupInfo then
		for k,v in pairs(self.groupInfo) do
			if v.timerid then
				timer.pause(v.timerid);
			end
		end
	end
end

function BufferLoader:Resume()
	if self.groupInfo then
		for k,v in pairs(self.groupInfo) do
			if v.timerid then
				timer.resume(v.timerid);
			end
		end
	end
end

function BufferLoader:_NextItem(group_id, cur_times)
	self.groupInfo[group_id].timerid = nil;
	self.groupInfo[group_id].cur_times = cur_times;

	local config = self:_GetBuffData(group_id);
	local list = config[cur_times] or config[#config];
	local cont = config.cont or 1;
	for i=1,cont do
		local rand = math.random();
		for k,buff in pairs(list) do
			if rand - buff.probability <= 0 then
				local point = self:_GetItemPos(config.point_list);
				if point and not self:_IsMaxNum(group_id) then
					-- 有位置且未到上限
					self:_CreateBuffer(group_id,buff.buff_id,point);
				else
					-- 已经刷满了
					-- app.log("#lhf BufferLoader#isMax");
					local del_name;
					if config.clear_old == 1 then
						-- 删除最老的
						del_name = self.groupInfo[group_id].buffList[1].obj;
					elseif config.clear_old == 2 then
						-- 随机清除
						local rand = math.random(1,#self.groupInfo[group_id].buffList);
						del_name = self.groupInfo[group_id].buffList[rand].obj;
					end
					if del_name then
						-- app.log("#lhf #del_name:"..del_name);
						FightScene.DeleteObj(del_name, 50);
						self:OnEvent_DeleteObj(del_name);
						local point = self:_GetItemPos(config.point_list);
						self:_CreateBuffer(group_id,buff.buff_id,point)
					end
				end
				break;
			end
			rand = rand - buff.probability;
		end
	end

	if not self:_IsClearRefresh(group_id) then
		self.groupInfo[group_id].timerid = timer.create(
			Utility.create_callback_ex(BufferLoader._NextItem, true, 0, self, group_id, cur_times+1 ),
			config.refresh_time*1000,
			1 );
		-- app.log("#lhf BufferLoader#continue");
	else
		self.needWait[group_id] = config.point_list;
		-- app.log("#lhf BufferLoader#stop");
	end
end

function BufferLoader:_CreateBuffer(group_id,cfg_id,point)
	local cfg = ConfigManager.Get(EConfigIndex.t_world_item, cfg_id);  
	local obj = FightScene.CreateItem(nil,cfg.model_id,1,cfg.trigger_id, cfg.effect_id, nil, cfg_id);
	obj:SetPosition(point.px, 0, point.pz);
	obj:SetRotation(point.rx, point.ry, point.rz);
	table.insert(self.groupInfo[group_id].buffList, {pos=point.obj_name,obj=obj:GetName()});

	NoticeManager.Notice(ENUM.NoticeType.CreateBufferItem, obj)
end

function BufferLoader:_IsClearRefresh(group_id)
	local config = self:_GetBuffData(group_id);
	if self:_GetItemPos(config.point_list) ~= nil 
		and not self:_IsMaxNum(group_id)
	then
		-- 如果未达到上限
		return false;
	end
	if config.clear_refresh_time == nil then
		-- 没有清理后开始计时刷新的配置
		return false;
	end
	return true;
end

-- 如果有清理后开始计时刷新的buff进行激活
function BufferLoader:_DetectionClearRefresh(del_pos_name)
	for group_id,list in pairs(self.needWait) do
		for k,pos_name in pairs(list) do
			if del_pos_name == pos_name then
				-- 恢复刷新
				local config = self:_GetBuffData(group_id);
				self.groupInfo[group_id].timerid = timer.create(
					Utility.create_callback_ex(BufferLoader._NextItem, true, 0, self, group_id, self.groupInfo[group_id].cur_times+1 ),
					config.clear_refresh_time*1000,
					1 );
				self.needWait[group_id] = nil;
				break;
			end
		end
	end
end

-- 当前组是否已经达到上限
function BufferLoader:_IsMaxNum(group_id)
	local config = self:_GetBuffData(group_id);
	if config.max_cont == nil then
		return false;
	end
	if config.max_cont > #self.groupInfo[group_id].buffList then
		return false;
	end
	return true;
end

-- 该位置是否已有buff
function BufferLoader:_PosHaveBuff(pos_name)
	for group_id,group_info in pairs(self.groupInfo) do
		for k,info in pairs(group_info.buffList) do
			if info.pos == pos_name then
				return true;
			end
		end
	end
	return false;
end

-- 获取一个随机位置
function BufferLoader:_GetItemPos(list)
	local item_list = {};
	for k,v in pairs(list) do
		if not self:_PosHaveBuff(v) then
			table.insert(item_list,v);
		end
	end
	if #item_list == 0 then
		return;
	end
	local rand = math.random(1,#item_list);
	local config = ConfigHelper.GetMapInf(FightScene.GetFightManager():GetFightMapInfoID(),EMapInfType.item)
	for i=1,#config do
		if string.find(config[i].obj_name,item_list[rand], 1, true) then
			return config[i];
		end
	end
end

-- 获取某组buff信息配置
function BufferLoader:_GetBuffData(buff_index)
	local buff_data;
	if self.fightScript then
		buff_data = self.fightScript.buff_group;
	end
	if nil == buff_data then
		return nil
	end

	return buff_data[buff_index]
end

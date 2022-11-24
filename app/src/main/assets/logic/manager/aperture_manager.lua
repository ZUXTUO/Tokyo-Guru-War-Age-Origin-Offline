--光圈管理器
--使用方式：Create 或者 CreateNotMove创建一个光圈，返回一个唯一标示，Open、Stop或者SetOpenNotMove来开关一个光圈
--当不使用时，可以视情况来DestroyMove或者DestroyNotMove光圈，如果一直不调用，光圈管理器将在退出战斗的时候销毁所有光圈
ApertureManager = Class("ApertureManager")
ApertureManager.aperture_effect = nil

ApertureManager.Enum = {
    BossFootBlue = 1700018,     -- boss脚底蓝色光圈
    BossFootRed = 1700012,      -- boss脚底红色光圈
}

function ApertureManager.GetResList()
    local effect_list = {1700011, 1700013, 1700008, 1700011, 1900006, 1700020, 1700022, 1700023,
                         1700027, 1700028, 1700029, 1700030, 1700031, 1700032, 1700034}
    local file_list = {}
    for k, v in pairs(effect_list) do
        local cfg = ConfigManager.Get(EConfigIndex.t_all_effect,v)
        if nil ~= cfg and nil ~= cfg.file then
            table.insert(file_list, cfg.file)
        end
    end
end


function ApertureManager.CreateEffect()
    ApertureManager.aperture_effect = {1,2,3,4,5,6,7,8,9};	--避免table重新哈希
    ApertureManager.aperture_effect[0] = EffectManager.createEffect(1700011)
    ApertureManager.aperture_effect[1] = EffectManager.createEffect(1700011)
    ApertureManager.aperture_effect[2] = EffectManager.createEffect(1700013)
    ApertureManager.aperture_effect[3] = EffectManager.createEffect(1700008)
    ApertureManager.aperture_effect[4] = EffectManager.createEffect(1700011)
    ApertureManager.aperture_effect[5] = EffectManager.createEffect(1700011)
    --BOSS单圆
    ApertureManager.aperture_effect[6] = EffectManager.createEffect(1700020)
    ApertureManager.aperture_effect[7] = EffectManager.createEffect(1700020)
    ApertureManager.aperture_effect[8] = EffectManager.createEffect(1700020)
    ApertureManager.aperture_effect[9] = EffectManager.createEffect(1700020)
    ApertureManager.aperture_effect[10] = EffectManager.createEffect(1700020)
    --BOSS扇形
    ApertureManager.aperture_effect[11] = EffectManager.createEffect(1700023)
    --BOSS直线
    ApertureManager.aperture_effect[12] = EffectManager.createEffect(1700022)
    --技能取消
    ApertureManager.aperture_effect[13] = EffectManager.createEffect(1700031)
    ApertureManager.aperture_effect[14] = EffectManager.createEffect(1700032)
    ApertureManager.aperture_effect[15] = EffectManager.createEffect(1700031)
    ApertureManager.aperture_effect[16] = EffectManager.createEffect(1700032)
    ApertureManager.aperture_effect[17] = EffectManager.createEffect(1700027)
    ApertureManager.aperture_effect[18] = EffectManager.createEffect(1700028)
    ApertureManager.aperture_effect[19] = EffectManager.createEffect(1700029)
    ApertureManager.aperture_effect[20] = EffectManager.createEffect(1700030)
    ApertureManager.aperture_effect[21] = EffectManager.createEffect(1700031)
    ApertureManager.aperture_effect[22] = EffectManager.createEffect(1700032)
    ApertureManager.aperture_effect[23] = EffectManager.createEffect(1700031)
    ApertureManager.aperture_effect[24] = EffectManager.createEffect(1700032)
    --90度扇形 蓝白红
    ApertureManager.aperture_effect[25] = EffectManager.createEffect(1700035)
    ApertureManager.aperture_effect[26] = EffectManager.createEffect(1700040)
    ApertureManager.aperture_effect[27] = EffectManager.createEffect(1700041)

    ApertureManager.aperture_effect[28] = EffectManager.createEffect(1700022)
    ApertureManager.aperture_effect[29] = EffectManager.createEffect(1700022)
    ApertureManager.aperture_effect[30] = EffectManager.createEffect(1700022)
    for k,v in pairs(ApertureManager.aperture_effect) do
        v:set_active(false)
    end
    ApertureManager.foot_effect = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_leadAperture).data)
    ApertureManager.foot_effect:set_active(false)
    ApertureManager.attack_target_foot_effect = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_attckAperture).data);
    ApertureManager.attack_target_foot_effect:set_active(false)
    ApertureManager.change_target_effect = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_attckAperture).data)--1700026);
    ApertureManager.change_target_effect:set_active(false);

    ApertureManager.click_effect = EffectManager.createEffect(1900006);
    ApertureManager.click_effect:set_active(false)
end

function ApertureManager.DestroyEffect()
    if ApertureManager.aperture_effect then
        for k, v in pairs(ApertureManager.aperture_effect) do
            EffectManager.deleteEffect(v:GetGID());
        end
    end
    ApertureManager.aperture_effect = nil;
    if ApertureManager.foot_effect then
        EffectManager.deleteEffect(ApertureManager.foot_effect:GetGID());
        ApertureManager.foot_effect = nil;
    end
    if ApertureManager.attack_target_foot_effect then
        EffectManager.deleteEffect(ApertureManager.attack_target_foot_effect:GetGID());
        ApertureManager.attack_target_foot_effect = nil;
    end
    if ApertureManager.change_target_effect then
        EffectManager.deleteEffect(ApertureManager.change_target_effect:GetGID());
        ApertureManager.change_target_effect = nil;
    end
    if ApertureManager.click_effect then
        EffectManager.deleteEffect(ApertureManager.click_effect:GetGID());
        ApertureManager.click_effect = nil;
    end
    --[[
    ApertureManager.aperture_effect = nil
    ApertureManager.foot_effect = nil
    ApertureManager.attack_target_foot_effect = nil
    ]]
end
function ApertureManager:Init(gid)
    self.is_show = true
    self.entity_gid = gid
    self.movelist = {};
	self.notMoveList = {};
    self.lastMovePos = {};
	self.curMoveIndex = 0;
    self.syncRTPosition = nil;
    self.apertureCreator = 0
    self.apertureType = {1,2,3,4,5,6,7,8,9};	--避免table重新哈希
    self.apertureType[0] = self:CreateNotMove(ApertureManager.aperture_effect[0])
    self.apertureType[1] = self:CreateNotMove(ApertureManager.aperture_effect[1])
    self.apertureType[2] = self:CreateNotMove(ApertureManager.aperture_effect[2])
    self.apertureType[3] = self:CreateNotMove(ApertureManager.aperture_effect[3])
    self.apertureType[4] = self:CreateNotMove(ApertureManager.aperture_effect[4])
    self.apertureType[5] = self:Create(ApertureManager.aperture_effect[5])
    --BOSS单圆
    self.apertureType[6] = self:CreateNotMove(ApertureManager.aperture_effect[6])
    self.apertureType[7] = self:CreateNotMove(ApertureManager.aperture_effect[7])
    self.apertureType[8] = self:CreateNotMove(ApertureManager.aperture_effect[8])
    self.apertureType[9] = self:CreateNotMove(ApertureManager.aperture_effect[9])
    self.apertureType[10] = self:CreateNotMove(ApertureManager.aperture_effect[10])
    --BOSS扇形
    self.apertureType[11] = self:CreateNotMove(ApertureManager.aperture_effect[11])
    --BOSS直线
    self.apertureType[12] = self:CreateNotMove(ApertureManager.aperture_effect[12])
    --技能取消特效
    self.apertureType[13] = self:CreateNotMove(ApertureManager.aperture_effect[13])
    self.apertureType[14] = self:CreateNotMove(ApertureManager.aperture_effect[14])

    self.apertureType[15] = self:CreateNotMove(ApertureManager.aperture_effect[15])
    self.apertureType[16] = self:CreateNotMove(ApertureManager.aperture_effect[16])

    self.apertureType[17] = self:CreateNotMove(ApertureManager.aperture_effect[17])
    self.apertureType[18] = self:CreateNotMove(ApertureManager.aperture_effect[18])

    self.apertureType[19] = self:CreateNotMove(ApertureManager.aperture_effect[19])
    self.apertureType[20] = self:CreateNotMove(ApertureManager.aperture_effect[20])

    self.apertureType[21] = self:CreateNotMove(ApertureManager.aperture_effect[21])
    self.apertureType[22] = self:CreateNotMove(ApertureManager.aperture_effect[22])

    self.apertureType[23] = self:Create(ApertureManager.aperture_effect[23])
    self.apertureType[24] = self:Create(ApertureManager.aperture_effect[24])
    --90度扇形 蓝白红
    self.apertureType[25] = self:CreateNotMove(ApertureManager.aperture_effect[25])
    self.apertureType[26] = self:CreateNotMove(ApertureManager.aperture_effect[26])
    self.apertureType[27] = self:CreateNotMove(ApertureManager.aperture_effect[27])

    self.apertureType[28] = self:CreateNotMove(ApertureManager.aperture_effect[28])
    self.apertureType[29] = self:CreateNotMove(ApertureManager.aperture_effect[29])
    self.apertureType[30] = self:CreateNotMove(ApertureManager.aperture_effect[30])

    self.curHeroFootEffect = self:CreateNotMove(ApertureManager.foot_effect, 1);
    --self:SetOpenNotMove(self.curHeroFootEffect, false);
    self.attackTargetFootEffect = self:CreateNotMove(ApertureManager.attack_target_foot_effect, 1);
    self.changeTargetHeadEffect = self:CreateNotMove(ApertureManager.change_target_effect, 1)
    self.clickEffect = self:CreateNotMove(ApertureManager.click_effect, 1);
    --self:SetOpenNotMove(self.attackTargetFootEffect, false);
    --for k, v in pairs(self.apertureType) do
    --	self:SetOpenNotMove(v,false);
    --end
end
---------------外部接口---------------
--创建一个可移动光圈
--id 特效id
--scale 缩放比例
--r 最大移动半径
function ApertureManager:Create(id)
    local effect = nil
    local need_del = false
    if id ~= nil then
        if type(id) == "number" then
            effect = EffectManager.createEffect(id)
            need_del = true
        else
            effect = id
        end
    end
    --effect:set_active(false)
	self.movelist[self.apertureCreator + 1] = { obj = effect, isOpen = false, needDel=need_del};
    self.apertureCreator = self.apertureCreator+1
	return self.apertureCreator;
end
--创建一个不动光圈
--id 特效id
function ApertureManager:CreateNotMove(id)
    local effect = nil
    local need_del = false
    if id ~= nil then
        if type(id) == "number" then
            effect = EffectManager.createEffect(id)
            need_del = true
        else
            effect = id
        end
    end
    --effect:set_active(false)
	self.notMoveList[self.apertureCreator + 1] = { notMove = true, obj = effect, isOpen = false, needDel=need_del, show_ref=0};
    self.apertureCreator = self.apertureCreator+1
	return self.apertureCreator;
end
--销毁一个不动光圈
--index 唯一标识
function ApertureManager:DestroyNotMove(index)
	local data = self.notMoveList[index];
	if data == nil then
		return;
	end
	data.obj:Destroy();
    self.notMoveList[index] = nil
end
--销毁一个移动光圈
--index 唯一标识
function ApertureManager:DestroyMove(index)
	local data = self.movelist[index];
	if data == nil then
		return;
	end
	data.obj:Destroy();
    self.movelist[index] = nil
end
--开关一个移动光圈
--index 唯一标识
--x,y,z 初始显示位置
--type 0=左遥杆 1=右摇杆
function ApertureManager:Open(index, x, y, z, scale, r, _type, onlyMax, dir)
	index = index or 1;
	local data = self.movelist[index]
	if data then
        data.begin_move_scale = nil
        data.record_last_pos = false
        data.type = _type;
        self.lastMoveIndex = index
		self.curMoveIndex = index;
		data.isOpen = true;
		data.beginPos = {x = x, y = y, z = z};
        data.record_pos = nil
        self.lastMovePos[index] = nil
        if self.entity_gid then
            local obj = ObjectManager.GetObjectByGID(self.entity_gid)
            if obj then
                data.record_pos = obj:GetPosition()
            end
        end
		data.obj:set_active(true);
		data.obj:set_position(x,y+0.01,z);
        data.scale = scale
        data.maxRaido = r
        if data.maxRaido and data.maxRaido ~= 1 then
            local use_ex = false
            if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
                if self.entity_gid then
                    local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                    if obj and obj:IsBoss() then
                        use_ex = true
                    end
                end
            end
            if use_ex then
                data.maxRaido = data.maxRaido + PublicStruct.Const.APERTURE_ADD_RADIUS_EX
            end
        end
        data.onlyMax = onlyMax
        if data.scale and data.scale ~= 1 then
            local use_ex = false
            if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
                if self.entity_gid then
                    local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                    if obj and obj:IsBoss() then
                        use_ex = true
                    end
                end
            end
            if use_ex then
                data.scale = data.scale + PublicStruct.Const.APERTURE_ADD_RADIUS_EX
            end
        end
        data.obj:set_local_scale(data.scale, 1, data.scale);
        
        if type(dir) == "number" then
            data.obj:set_local_rotation(0, dir, 0);
            local x, y, z = data.obj:get_forward()
            data.direct = {x = x, y = y, z = z};
        else
            data.direct = dir
            if data.direct == nil then
                if data.record_pos and (data.record_pos.x ~= x or data.record_pos.z ~= z) then
                    local dirx = x - data.record_pos.x
                    local diry = 0
                    local dirz = z - data.record_pos.z
                    dirx, diry, dirz = util.v3_normalized(dirx, diry, dirz);
                    data.direct = {x = dirx, y = diry, z = dirz};
                    data.begin_move_scale = ((x - data.record_pos.x)/data.direct.x)/(data.maxRaido-1*data.scale)


                else
                    data.direct = {x = 0, y = 0, z = 0};
                end
            end
        end
        if data.onlyMax then
            local begin_x = data.beginPos.x
            local begin_z = data.beginPos.z
            if self.entity_gid then
                local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                if obj then
                    local p = obj:GetPosition()
                    begin_x = p.x
                    begin_z = p.z
                end
            end
            x = begin_x + data.direct.x*data.maxRaido
            z = begin_z + data.direct.z*data.maxRaido
            data.obj:set_position(x, y, z);
        end
        self.syncRTPosition = nil
	end
end

function ApertureManager:SetOpenData(index, x, y, z, r, _type, onlyMax, dir)
    index = index or 1;
    local data = self.movelist[index]
    if data then
        data.beginPos = {x = x, y = y, z = z};
        data.maxRaido = r;
        data.type = _type;
        data.onlyMax = onlyMax
        if type(dir) == "number" then
            data.obj:set_local_rotation(0, dir, 0);
            local x, y, z = data.obj:get_forward()
            data.direct = {x = x, y = y, z = z};
        else
            data.direct = dir
        end
    end
end
function ApertureManager:Stop(index)
	local data = self.movelist[index]
	if data then
		if self.curMoveIndex == index then
			self.curMoveIndex = 0;
		end
        if data.record_last_pos then
            local x,y,z = data.obj:get_local_position();
            self.lastMovePos[index] = {x = x,y = y,z = z};
        else
            self.lastMovePos[index] = nil
        end
		data.isOpen = false;
		data.obj:set_active(false);
        data.direct = nil
	end
end
function ApertureManager:SetAttackAperture(enable)
    if enable then
        if not self.attackAperture then
            self.attackAperture = EffectManager.createEffect(ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_attckAperture).data);
            local obj = ObjectManager.GetObjectByGID(self.entity_gid)
            self.attackAperture:set_parent(obj:GetBindObj(3), obj)
            self.attackAperture:set_local_position(0,0,0);
            scale = PublicFunc.GetUnifiedScale(obj)
            self.attackAperture:set_local_scale(1/scale, 1, 1/scale);
        end
    end
    if self.attackAperture then
        self.attackAperture:set_active(enable);
    end
end

--开关一个不可移动光圈
--index 唯一标识
--parent 父窗口
--x,y,z 初始显示位置 相对坐标
--sx,sz 缩放比例
function ApertureManager:SetOpenNotMove(index, enable, parent, x, y, z, sx, sz, entity, reverse_dir, follow_pos, now_dir)
    local data = self.notMoveList[index];
    --app.log_warning(tostring(index).."   "..tostring(enable).."  "..tostring(parent).."  "..tostring(data).." "..debug.traceback())
    if data then
        if enable then
            x = x or 0;
			y = y or 0;
			z = z or 0;
			sx = sx or 1;
			sz = sz or 1;
            --[[if sx ~= 1 or sz ~= 1 then
                local use_ex = false
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss or FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
                    if self.entity_gid then
                        local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                        if obj and obj:IsBoss() then
                            use_ex = true
                        end
                    end
                end
                if sx ~= 1 then
                    if use_ex then
                        sx = sx + PublicStruct.Const.APERTURE_ADD_RADIUS_EX
                    --else
                    --    sx = sx + PublicStruct.Const.APERTURE_ADD_RADIUS
                    end
                end
                if sz ~= 1 then
                    if use_ex then
                        sz = sz + PublicStruct.Const.APERTURE_ADD_RADIUS_EX
                    --else
                     --   sz = sz + PublicStruct.Const.APERTURE_ADD_RADIUS
                    end
                end
            end]]
            data.last_angle = nil
			--data.obj:set_parent(parent, entity);
            data.obj:set_local_position(x, y+0.01, z);
            --[[if parent then
                local scale = 1
                if self.entity_gid then
                    local entity = ObjectManager.GetObjectByGID(self.entity_gid)
                    if entity then
                        scale = PublicFunc.GetUnifiedScale(entity)
                    end
                end
                
                data.obj:set_local_scale(sx/scale, 1, sz/scale);
            else]]
                data.obj:set_local_scale(sx, 1, sz);
                
            --end
			data.obj:set_local_rotation(0, 0, 0);
            data.follow_pos = follow_pos
            data.reverse_dir = reverse_dir
            data.show_ref = data.show_ref + 1
            if now_dir then
                if reverse_dir then
                    data.obj:set_forward(-now_dir.x, now_dir.y, -now_dir.z)
                else
                    data.obj:set_forward(now_dir.x, now_dir.y, now_dir.z)
                end
                data.have_set_dir = true
            else
                data.have_set_dir = nil
            end
		end
        if data.isOpen ~= enable then
            if not enable then
                data.show_ref = data.show_ref - 1
                if data.show_ref == 0 then
                    data.obj:set_active(enable);
                    data.isOpen = enable;
                end
            else
                data.obj:set_active(enable);
                data.isOpen = enable;
            end
    		
        end
	end
end

--判断某个光圈是否打开
--index 唯一标识
--type 0=左遥杆 1=右摇杆
function ApertureManager:IsOpen(type, index)
	index = index or self.curMoveIndex;
	if self.movelist[index] and self.movelist[index].type == type then
		return self.movelist[index].isOpen;
	else
		return false;
	end
end
function ApertureManager:IsNotMoveOpen(index)
	if self.notMoveList[index] then
		return self.notMoveList[index].isOpen;
	else
		return false;
	end
end
--获取移动光圈的位置
--index 唯一标识
function ApertureManager:GetRTPosition(index, from_controller)
    if from_controller then
        index = index or self.lastMoveIndex;
	    local data = self.movelist[index]
        if data then
            if self.lastMovePos[index] then
                return self.lastMovePos[index];
            end
            if data.onlyMax then
                local pos = {};
                pos.x = data.beginPos.x
                pos.y = data.beginPos.y
                pos.z = data.beginPos.z
                local dir = {x=0, y=0, z=1}
                if data.direct then
                    dir = data.direct
                else
                    if self.entity_gid then
                        local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                        if obj then
                            local p = obj:GetPosition()
                            pos.x = p.x
                            pos.z =p.z
                            dir = obj:GetForWard()
                        end
                    end
                end
                pos.x = pos.x + dir.x*data.maxRaido
                pos.z = pos.z + dir.z*data.maxRaido
                return pos
            end
            
            if data.obj.isActive then
    			local x,y,z = data.obj:get_local_position();
                local pos = {x = x,y = y,z = z};
                return pos
            else
                local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                if obj then
                    local target = obj:GetAttackTarget()
                    if target then
                        --[[local target_pos = target:GetPosition();
                        local cur_pos = obj:GetPosition();
                        local dis = algorthm.GetDistance(target_pos.x, target_pos.z, cur_pos.x, cur_pos.z)
                        if dis > data.maxRaido-data.scale then
                            local dx = target_pos.x - cur_pos.x
                            local dy = 0
                            local dz = target_pos.z - cur_pos.z
                            dx, dy, dz = util.v3_normalized(dx, dy, dz);
                            local pos = {}
                            pos.x = cur_pos.x + dx*(data.maxRaido-data.scale)
                            pos.y = cur_pos.y + 0.01
                            pos.z = cur_pos.z + dz*(data.maxRaido-data.scale)
                        else
                            return target_pos
                        end]]
                        return target:GetPosition();
                    end
                    return obj:GetPosition();
                end
            end
        else
            if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self.syncRTPosition then
                return self.syncRTPosition;
            else
                local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                if obj then
                    local target = obj:GetAttackTarget()
                    if target then
                        return target:GetPosition();
                    end
                    return obj:GetPosition();
                end
            end
        end
    else
        if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and self.syncRTPosition then
            return self.syncRTPosition;
        else
            local obj = ObjectManager.GetObjectByGID(self.entity_gid)
            if obj then
                local target = obj:GetAttackTarget()
                if target then
                    return target:GetPosition();
                end
                return obj:GetPosition();
            end
        end
    end
    return nil
end


-------------内部使用------------------

function ApertureManager:Finalize()
    for k, v in pairs(self.movelist) do
        if v.isOpen then
            v.show_ref = 0
            v.obj:set_active(false);
            v.isOpen = false; 
        end
        if v.needDel then
		    v.obj:Destroy();
        end
	end
	for k, v in pairs(self.notMoveList) do
        if v.isOpen then
            v.show_ref = 0
            v.obj:set_active(false);
            v.isOpen = false; 
        end

        if v.needDel then
		    v.obj:Destroy();
        end
	end
    if self.attackAperture then
        self.attackAperture:set_active(false);
        self.attackAperture:Destroy();
        self.attackAperture = nil
    end
	self.movelist = {};
	self.notMoveList = {};
    self.lastMovePos = {};
end

function ApertureManager:SetMoveAngle(angle, index)
	index = index or self.curMoveIndex;
	local data = self.movelist[index];
	if data then
		data.obj:set_local_rotation(0, angle, 0);
		local x, y, z = data.obj:get_forward()
		data.direct = {x = x, y = y, z = z};
	end
end

function ApertureManager:SetNotMoveAngle(angle, index)
	local data = self.notMoveList[index];
	if data then
        if data.reverse_dir then
		    data.obj:set_local_rotation(0, angle-180, 0);
        else
            data.obj:set_local_rotation(0, angle, 0);
        end
        data.last_angle = angle
		--[[local x,y,z = data.obj:get_rotation()
        if data.last_angle == nil then
            data.last_angle = {x = x,y = y,z = z};
        else
			data.last_angle.x = x;
			data.last_angle.y = y;
			data.last_angle.z = z;
		end]]
        --data.last_angle.x, data.last_angle.y, data.last_angle.z = data.obj:get_rotation()
	end
end

function ApertureManager:RecoverNotMoveAngle(index)
	local data = self.notMoveList[index];
	if data and data.last_angle and data.last_angle.x and data.last_angle.y and data.last_angle.z then
		data.obj:set_rotation(data.last_angle.x, data.last_angle.y, data.last_angle.z);
	end
end

function ApertureManager:UpdateNotMovePos()
    for k, v in pairs(self.notMoveList) do
        if v.isOpen and v.follow_pos and v.obj.isActive then
            local obj = ObjectManager.GetObjectByGID(self.entity_gid)
            if obj then
                local bind_pos = obj:GetBindObj(3)
                if bind_pos then
                    local x, y, z = bind_pos:get_position();
                    v.obj:set_position(x, y+0.01, z);
                    if not v.have_set_dir then
                        if v.last_angle then
                            if v.reverse_dir then
                                v.obj:set_local_rotation(0, v.last_angle-180, 0);
                            else
                                v.obj:set_local_rotation(0, v.last_angle, 0);
                            end
                        else
                            local rx, ry, rz = bind_pos:get_rotation()
                            v.obj:set_rotation(0, ry, 0);
                        end
                    end
                end
            end
        end
    end
end


function ApertureManager:MovePos(delatime)
	local data = self.movelist[self.curMoveIndex];
	if data and data.isOpen then
        --[[if self.entity_gid and data.record_pos then
            local obj = ObjectManager.GetObjectByGID(self.entity_gid)
            if obj then
                local pos = obj:GetPosition()
                if pos.x ~= data.record_pos.x or pos.z ~= data.record_pos.z then
                    local now_posx, now_posy, now_posz = data.obj:get_position()
                    local offset_x = now_posx - data.beginPos.x
                    local offset_z = now_posz - data.beginPos.z
                    data.beginPos = pos
                    data.record_pos = pos
                    data.obj:set_position(data.beginPos.x+offset_x, pos.y, data.beginPos.z+offset_z);
                end
            end
        end]]
        if not data.direct then
            return
        end
		local moveScale = GetMainUI():GetRockerMoveScale(data.type);
		--if moveScale > 0.001 then
            data.record_last_pos = true
			--local moveDis = moveScale * data.maxRaido;
			--local newX = data.beginPos.x + moveDis * data.direct.x;
			--local newY = data.beginPos.y;
			--local newZ = data.beginPos.z + moveDis * data.direct.z;
            local x, y, z = data.obj:get_position()
            if data.onlyMax then
                local begin_x = data.beginPos.x
                local begin_y = data.beginPos.y
                local begin_z = data.beginPos.z
                if self.entity_gid then
                    local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                    if obj then
                        local p = obj:GetPosition()
                        begin_x = p.x
                        begin_y = p.y + 0.01
                        begin_z = p.z
                    end
                end
                x = begin_x + data.direct.x*data.maxRaido
                y = begin_y
                z = begin_z + data.direct.z*data.maxRaido
            else
                local begin_x = data.beginPos.x
                local begin_y = data.beginPos.y
                local begin_z = data.beginPos.z
                if moveScale < 0.001 and data.begin_move_scale then
                    moveScale = data.begin_move_scale
                end
                if self.entity_gid then
                    local obj = ObjectManager.GetObjectByGID(self.entity_gid)
                    if obj then
                        local p = obj:GetPosition()
                        begin_x = p.x
                        begin_y = p.y + 0.01
                        begin_z = p.z
                    end
                end
                x = begin_x + data.direct.x*(data.maxRaido-1*data.scale)*moveScale
                y = begin_y
                z = begin_z + data.direct.z*(data.maxRaido-1*data.scale)*moveScale
            end
			local effectObj = data.obj;
			if effectObj then
				data.obj:set_local_scale(data.scale, 1, data.scale);
			end
			data.obj:set_position(x, y, z);
		--end	
	end
end

function ApertureManager:RecoverAllEffect()
    for k, v in pairs(self.movelist) do
        if v.isOpen and not v.obj.isActive then
            v.obj:set_position(v.pause_x, v.pause_y, v.pause_z)
		    v.obj:set_active(true);
        end
	end
	for k, v in pairs(self.notMoveList) do
        if v.isOpen and not v.obj.isActive then
            v.obj:set_position(v.pause_x, v.pause_y, v.pause_z)
		    v.obj:set_active(true);
        end
	end
end

function ApertureManager:PauseAllEffect()
    for k, v in pairs(self.movelist) do
        if v.isOpen then
            v.pause_x, v.pause_y, v.pause_z = v.obj:get_position()
		    v.obj:set_active(false);
        end
	end
	for k, v in pairs(self.notMoveList) do
        if v.isOpen then
            v.pause_x, v.pause_y, v.pause_z = v.obj:get_position()
		    v.obj:set_active(false);
        end
	end
end

function ApertureManager:ShowAperture(isShow)
    if self.is_show == isShow then
        return
    end
    self.is_show = isShow;
    for k, v in pairs(self.movelist) do
        if v.isOpen then
            v.obj:set_active(isShow);
        end
    end
    for k, v in pairs(self.notMoveList) do
        if v.isOpen then
            v.obj:set_active(isShow);
        end
    end
end
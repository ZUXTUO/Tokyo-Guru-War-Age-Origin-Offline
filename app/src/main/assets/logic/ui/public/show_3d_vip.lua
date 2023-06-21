Show3dVip = Class("Show3dVip");
Show3dVip.quotenum = 0;

ROLE_VIP_MODEL_ANIMA_TYPE = {
	STAND = 1,
	RANDOM = 2,
	GIVE = 3,
	UP_STAR = 4,
	UP_LEVEL_ENTER = 5,
	UP_LEVEL_EXIT = 6,
}

-- local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d.assetbundle";
local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_009.assetbundle";

function Show3dVip.GetResList()
	return {res}
end

function Show3dVip.SetAndShow(data)
    if Show3dVip.instance then
		Show3dVip.instance:UpdateData(data);
	else
		Show3dVip.instance = Show3dVip:new(data)
	end
end

function Show3dVip.SetAnimationByType( anima_type )
	if Show3dVip.instance then
		
		Show3dVip.instance:AnimatorPlay(anima_type);
	end
end

function Show3dVip.SetLoadCallBack(callback)
	local self = Show3dVip.instance
	if self then
		self.loadOkCallback = callback
		if self.role3d then
			self.role3d:SetLoadCallBack(self.loadOkCallback)
		end
	end
end

function Show3dVip.Destroy()
	-- app.log("destroy:".. debug.traceback());
	Show3dVip.quotenum = Show3dVip.quotenum -1
	--app.log("quotenum============="..tostring(Show3dVip.quotenum))
	if Show3dVip.quotenum > 0 then
		return 
	end

    if Show3dVip.instance then
        Show3dVip.instance:Hide();
        Show3dVip.instance:DestroyUi();
        Show3dVip.instance = nil;
        Show3dVip.quotenum = 0;
    end
end

function Show3dVip.GetInstance()
	return Show3dVip.instance
end

function Show3dVip.Addquote( )

	Show3dVip.quotenum = Show3dVip.quotenum + 1
	-- body
end

function Show3dVip.SetVisible(bool)
	if Show3dVip.instance then
		Show3dVip.instance:SetVisibleRole3d(bool)
	end
end

function Show3dVip:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function Show3dVip:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	if not data then return end
	self.roleData = data.roleData;
	self.role3d_ui_touch = data.role3d_ui_touch;
	self.callback = data.callback;
	self.clickRoleCallBack = data.clickRoleCallBack;
	self.animaCallBack = data.animaCallBack;
	self.sp_di = data.sp_di;
	self.describeTxt = data.describeTxt;
	self.isGray = data.isGray;
	self.model_id = data.model_id;
	if data.type == "right" then
		self.type = 3
	elseif data.type == "mid" then
		self.type = 2
	elseif data.type == "left" then
		self.type = 1
	else
		self.type = 1
	end

	self.m_is_playing = false;
	self.m_anima_time_id = 0;
end

function Show3dVip:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);

	self.bindfunc['on_anima_time_diff'] = Utility.bind_callback(self, self.on_anima_time_diff);
end

--注销回调函数
function Show3dVip:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function Show3dVip:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function Show3dVip:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function Show3dVip:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function Show3dVip:DestroyUi()
	-- app.log("destroy:".. debug.traceback());
    self:UnRegistFunc()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3d then
		self.role3d:Destroy();
		self.role3d = nil;
	end
	self.visibleRole3d = nil;
end

function Show3dVip:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function Show3dVip:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_show");
    -- self.ui3d_root = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001");
    -- self.ui3d_can_move = self.ui3d:get_child_by_name("can_move");
    -- self.ui3d_not_move = self.ui3d:get_child_by_name("not_move");
    -- local screen_width = app.get_screen_width();
    -- local screen_height = app.get_screen_height();
    -- local x = screen_width/screen_height;
    -- local offset = 1.2*(x*9/16)-1.2;
    -- self.ui3d_can_move:set_local_position(offset,0,0);
    -- self.ui3d_not_move:set_local_position(offset,0,0);

    local midObj = self.ui3d:get_child_by_name("role3d_mid")
    local leftObj = self.ui3d:get_child_by_name("role3d_left")
	app.log("[][]][]][][self.type == "..self.type);
    if self.type == 3 then
    	self.ui3d_root = leftObj:get_child_by_name("can_move")
    	leftObj:set_active(true)
    	midObj:set_active(false)
	    --local x = screen_width/screen_height;
	    --local offset = (x*9/16)-1;
	    local objCamera = leftObj:get_child_by_name("role_camera")
	    local x1, y1, z1 = objCamera:get_local_position()
	    local x, y, z = self.ui3d_root:get_local_position()
        local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)

		local newX = x1 + (x - x1)*scaleModel;
	    self.ui3d_root:set_local_position(2*x1 - newX, y * scaleModel * scaleModel, z);
    elseif self.type == 1 then
    	self.ui3d_root = leftObj:get_child_by_name("can_move")
    	leftObj:set_active(true)
    	midObj:set_active(false)
        local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)
	    
	    local objCamera = leftObj:get_child_by_name("role_camera")
	    local x1, y1, z1 = objCamera:get_local_position()
	    local x, y, z = self.ui3d_root:get_local_position()
	    -- self.ui3d_root:set_local_position(x1 + (x - x1)*scaleModel, y * scaleModel * scaleModel, z);
    elseif self.type == 2 then
    	self.ui3d_root = midObj:get_child_by_name("can_move");
        PublicFunc.SetScaleByScreenRate(self.ui3d_root)

    	leftObj:set_active(false)
    	midObj:set_active(true)
    end

    if not self.ui3d_root then return end
    --self.role3d_ui_touch = ngui.find_sprite(self.ui, "centre_other/animation/left_content/tex_people/sp_people");
    if self.model_id then
        self.role3d = Role3dVip:new({parent = self.ui3d_root,model_id = self.model_id,load_call_back= self.callback,uiSp = self.role3d_ui_touch, isGray = self.isGray, clickRoleCallBack = self.clickRoleCallBack});
    else
        self.role3d = Role3dVip:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch, clickRoleCallBack = self.clickRoleCallBack});
    end

	self.role3d:SetLoadCallBack(self.loadOkCallback)

	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
	self:LoadCurVipModelAnimas();
end

function Show3dVip:UpdateData(data)
    -- if data.roleData and self.roleid == data.roleData.number then
        --app.log("11111111111111111")
    --     return  
    -- end
	self.roleData = data.roleData
	self.isGray = data.isGray;
        
    if data.roleData then
        self.roleid = data.roleData.number; 
    else
        self.roleid = 0;
    end
        
	if self.ui3d_root == nil or self.role3d == nil then return end

	-- if self.roleData then
	-- 	local role_id = data.roleData.number;
	-- 	self.role3d:ChangeObj(role_id);
	-- 	self.role3d:SetGray(self.isGray);
	-- 	self:Show();
	-- else
	-- 	self.role3d:Destroy()
	-- 	self.role3d = Role3dVip:new({parent = self.ui3d_root,model_id = self.model_id,load_call_back= self.callback,uiSp = self.role3d_ui_touch, clickRoleCallBack = self.clickRoleCallBack});
	-- 	self.role3d:SetGray(self.isGray);
	-- end
	app.log("-------------- Show3dVip:UpdateData")
	self.model_id = data.model_id;
	app.log("-------------- Show3dVip:model_id:" .. self.model_id)
	if self.model_id then
		self.role3d:ChangeObjByModelID(self.model_id);
		-- self.role3d:SetGray(self.isGray);
		self:Show();
	else
		self.role3d:Destroy()
		self.role3d = Role3dVip:new({parent = self.ui3d_root,model_id = self.model_id,load_call_back= self.callback,uiSp = self.role3d_ui_touch, clickRoleCallBack = self.clickRoleCallBack});
		-- self.role3d:SetGray(self.isGray);
	end

	-- self.role3d:SetLoadCallBack(self.loadOkCallback)
	self:LoadCurVipModelAnimas();
	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
end

function Show3dVip:SetVisibleRole3d(bVisible)
	self.visibleRole3d = (bVisible == true)
	if self.ui3d then
		self.ui3d:set_active(self.visibleRole3d);
	end
	if self.role3d then
		self.role3d:ShowObj(self.visibleRole3d)
	end
end

function Show3dVip:LoadCurVipModelAnimas( )
	if self.model_id then
		self.m_cur_model_animas = ConfigManager.Get(EConfigIndex.t_vip_role_model_anima, self.model_id);
		self.m_cur_model_types = {};

		for k,v in pairs( self.m_cur_model_animas ) do
			if v.anima_type == ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM then
				if self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM] == nil then
					self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM] = {};
				end
				if self:CheckTime(v) then
					table.insert(self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM], v);
				end
			elseif v.anima_type == ROLE_VIP_MODEL_ANIMA_TYPE.GIVE then
				if self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM] == nil then
					self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM] = {};
				end
				table.insert(self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM], v);
				self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.GIVE] = v;
				self.m_cur_model_types[ROLE_VIP_MODEL_ANIMA_TYPE.UP_STAR] = v;
			else
				self.m_cur_model_types[v.anima_type] = v;
			end
		end
	end
end

function Show3dVip:CheckTime( v )
	local ret = true;
	if not v then
		ret = false;
	else
		if v.time_limits and v.time_limits ~= 0 and v.time_limits ~= "0" then
			local limits = v.time_limits;
			if #limits >= 2 then
				local nowTime = system.time();
        		local nowDate = os.date('*t', nowTime);
        		local startDate = limits[1];
        		local endDate = limits[2];
        		local beginTime = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=startDate.h, min=startDate.i});
				local endTime = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=endDate.h, min=endDate.i});
				if nowTime < beginTime or nowTime > endTime then
					ret = false;
				end
			end
		end
	end
	return ret;
end

function Show3dVip:GetAnimasByType( anima_type )
	return self.m_cur_model_types[anima_type];
end

function Show3dVip:AnimatorPlay( anima_type )
	app.log("AnimatorPlay:" .. tostring(self:GetAnimaIsPlaying()));
	if not self:GetAnimaIsPlaying() then
		local cur_anima = self:GetAnimasByType( anima_type );		
		if anima_type == ROLE_VIP_MODEL_ANIMA_TYPE.RANDOM then
			if cur_anima and #cur_anima and #cur_anima > 0 then
				if not self.m_random_num_anima then
					local m_random_num  = math.random(1, #cur_anima);
					self.m_random_num_anima = cur_anima[m_random_num];
				else
					local random_animas = {};
					for k,v in pairs(cur_anima) do
						if v.txt ~= self.m_random_num_anima.txt then
							table.insert(random_animas, v);
						end
					end
					local m_random_num = math.random(1, #random_animas);
					self.m_random_num_anima = random_animas[m_random_num];
				end
				cur_anima = self.m_random_num_anima;
			end
		end
		app.log("cur_anima:" .. table.tostring(cur_anima))
		if cur_anima then
			local txt = tostring(cur_anima.txt);
			if self.describeTxt then				
				if txt == "0" or txt == "nil" then
					txt = "";
				end
				self.describeTxt:set_text(txt);
			end

			self.m_anima_type = anima_type;
			self.m_is_playing = true;

			local anima_name = tostring(cur_anima.anima_name);
			local anima_frame = tonumber(cur_anima.anima_frame);
			local cv = tonumber(cur_anima.cv);

			if anima_name == "0" or anima_name == "nil" then
				anima_frame = 0;
				if cv and cv ~= 0 then
					AudioManager.Play3dAudio(cv, AudioManager.GetUiAudioSourceNode() , true, true, false, true, self.audioCallBack);
				else
					if txt ~= "" then
						anima_frame = 2;
					else
						self:on_anima_time_diff();
					end
				end
			else
				self.role3d:AnimatorPlay( anima_name );
				if cv and cv ~= 0 then
					AudioManager.Play3dAudio(cv, AudioManager.GetUiAudioSourceNode() , true, true, false, true);
				end
			end

			self.sp_di:set_active(txt ~= "");

			if self.m_anima_time_id and self.m_anima_time_id > 0 then
				timer.stop(self.m_anima_time_id);
				self.m_anima_time_id = 0;
			end
			if anima_frame > 0 then
				app.log("------------ anima_frame-time:" .. anima_frame * PublicStruct.MS_Each_Anim_Frame);
				self.m_anima_time_id = timer.create(self.bindfunc["on_anima_time_diff"], anima_frame * PublicStruct.MS_Each_Anim_Frame, 1);
			end
			
		else
			self:on_anima_time_diff();
		end		
	end
end

function Show3dVip.audioCallBack( data )
	if Show3dVip.instance then
		Show3dVip.instance:on_anima_time_diff();
	end
end

function Show3dVip:on_anima_time_diff( )
	self.m_is_playing = false;
	if self.m_anima_time_id and self.m_anima_time_id > 0 then
		timer.stop(self.m_anima_time_id);
		self.m_anima_time_id = nil;
	end
	app.log("----------- m_anima_type:" .. tostring(self.m_anima_type))
	if self.m_anima_type and self.m_anima_type == ROLE_VIP_MODEL_ANIMA_TYPE.UP_LEVEL_EXIT then
		-- self:SetVisibleRole3d(false);
	elseif self.m_anima_type and self.m_anima_type ~= ROLE_VIP_MODEL_ANIMA_TYPE.STAND then
		self:AnimatorPlay(ROLE_VIP_MODEL_ANIMA_TYPE.STAND);
	end
	if self.animaCallBack then
		Utility.CallFunc(self.animaCallBack, self.m_anima_type);
	end
end

function Show3dVip:SetAnimaIsPlaying( playing )
	app.log("---------------- playing:" )
	self.m_is_playing = playing;
end

function Show3dVip:GetAnimaIsPlaying( )
	return self.m_is_playing;
end

function Show3dVip:GetAnimaType( )
	return self.m_anima_type;
end

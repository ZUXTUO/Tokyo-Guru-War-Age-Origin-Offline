SpeakBubbleUI = Class("SpeakBubbleUI");

function SpeakBubbleUI:Init(data)
   self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_fight_speak.assetbundle";
   self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
end

function SpeakBubbleUI:RegistFunc( )
	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, SpeakBubbleUI.SetDeffTime);
	self.bindfunc["set_deff_time_loop"] = Utility.bind_callback(self, SpeakBubbleUI.set_deff_time_loop);
end

function SpeakBubbleUI:UnregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end

function SpeakBubbleUI:InitData(data)
    self.target = nil;
    self.isShow = false;
    self.bindfunc = { };
    self.name = "ui_speak_bubble";
    self.updateTimer = 0;
    self.is_showing = false;

    self.duration = 0;
    self.total_loop = 0;
    self.cur_loop = 0;
    self.loop_time = 0;
    self.loop_update_time = 0;

    self.m_set_tex = false;
end

function SpeakBubbleUI:LoadAsset( )
	OGM.GetGameObject(self.pathRes, function(gObject)
			self:InitUi(nil, gObject)
		end )
end

function SpeakBubbleUI:DestroyUi()
    if (self.ui ~= nil) then
		self.ui:set_active(false);
		self.ui = nil;
	end
	if self.gObject ~= nil then
		OGM.UnUse(self.gObject)
		self.gObject = nil;
	end
	if self.updateTimer ~= 0 then 
        timer.stop(self.updateTimer);
        self.updateTimer = 0;
    end

    if self.loop_update_time ~= 0 then
    	timer.stop(self.loop_update_time);
    	self.loop_update_time = 0;
    end

    self.is_showing = false;
    self.duration = 0;
    self.total_loop = 0;
    self.cur_loop = 0;
    self.loop_time = 0;

    self.m_set_tex = false;
    self:UnregistFunc();
end

function SpeakBubbleUI:InitUi(asset_obj, gObject)
	if gObject then
		self.ui = gObject:GetGameObject()
		self.gObject = gObject
	else
		self.ui = asset_game_object.create(asset);
	end
	self.ui:set_active(self.isShow);
	if self.parent then
		self.ui:set_parent(self.parent);
	else
		if not gObject then
			self.ui:set_parent(Root.get_root_ui_2d_fight());
		end
	end
	self.ui:set_name(tostring(self.name));
	self.ui:set_local_scale(1, 1, 1);

	self.lab_speak = ngui.find_label(self.ui, "lab");
	self.lab_speak:set_text("");

	if self.m_set_tex == false then
		self:UpdateUI();
	end

	if self._needShowSpeakByid then
		self:__SetSpeakByid(self._needShowSpeakByid)
		self._needShowSpeakByid = nil
	end
end

function SpeakBubbleUI:UpdateUI(  )
	if self.lab_speak then
		self.lab_speak:set_text(self.gs_str or "");
		self.m_set_tex = true;
	end
end

function SpeakBubbleUI:SetSpeakByid( speak_id )
	if self.ui then
		self:__SetSpeakByid(speak_id)
	else
		self._needShowSpeakByid = speak_id
	end
end

function SpeakBubbleUI:__SetSpeakByid( speak_id )
	self:SetDeffTime();

	app.log("gs_str-1:" .. tostring(speak_id));
	local speak_config_data = ConfigManager.Get(EConfigIndex.t_speak_bubble, speak_id);
	local gx_str_num = math.random(1, #speak_config_data.speak);
	local gs_str = speak_config_data.speak[gx_str_num];
	app.log("gs_str0:" .. gs_str);
	gs_str = Utility.GetRootObjByString(gs_str);
	app.log("gs_str1:" .. tostring(gs_str));
	if gs_str == nil then
		gs_str = "";
	end
	self.gs_str = gs_str;
	app.log("gs_str2:" .. gs_str);
	if speak_config_data then
		-- local labStr = speak_config_data.speak[];
		if self.lab_speak then
			app.log("---------------- self.lab_speak")
			self.lab_speak:set_text(gs_str);
			self.m_set_tex = true;
		end
		self:Show(true);
		self.is_showing = true;			

		self.duration = speak_config_data.duration;
		if speak_config_data.duration > 0 then
			self.updateTimer = timer.create(self.bindfunc["set_deff_time"],  self.duration, 1);
			-- self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 100000 , 1);
		end
		
		self.total_loop = speak_config_data.loop;
		self.cur_loop = 1;
		self.loop_time = speak_config_data.loop_time;
		app.log("self.total_loop:" .. self.total_loop .. "----- self.loop_time:" .. self.loop_time);
		if self.total_loop ~= 1 and self.loop_time > 0 then
			self.loop_update_time = timer.create(self.bindfunc["set_deff_time_loop"], self.loop_time, self.total_loop - 1);
		end
	end

end

function SpeakBubbleUI:SetDeffTime( )
	self:Show(false);
	app.log("SetDeffTime");
end

function SpeakBubbleUI:set_deff_time_loop( )
	self:Show(true);
	app.log("set_deff_time_loop:cur_loop:" .. tostring(self.cur_loop) .. "--total_loop:" .. tostring(self.total_loop))

	if self.updateTimer and self.updateTimer > 0 then
		timer.stop(self.updateTimer);
        self.updateTimer = 0;
	end
	app.log("set_deff_time_loop");
	self.updateTimer = timer.create(self.bindfunc["set_deff_time"],  self.duration, 1);
end

function SpeakBubbleUI:SetData(info)
	if (info ~= nil) then
		self.target = info;
	end
end

function SpeakBubbleUI:SetPosition( x, y, z )
	if self.ui then
		self.ui:set_position(x, y, z);
	end
end

function SpeakBubbleUI:SetLocalPosition(x, y, z)
	if self.ui then
		self.ui:set_local_position(x, y, z);
	end
end

function SpeakBubbleUI:Show(isShow)
	self.isShow = isShow;
	if (self.ui ~= nil) then
		self.ui:set_active(isShow);
	end
	self.is_showing = isShow;
	if isShow == false then
		if self.updateTimer and self.updateTimer > 0 then
			timer.stop(self.updateTimer);
	        self.updateTimer = 0;
		end
		
	end
end

function SpeakBubbleUI:GetIsShow( )
	return self.isShow;
end

TriggerStory = Class("TriggerStory", UiBaseClass);

local instance = nil;

function TriggerStory.Start(param)
	if not instance then
		instance = TriggerStory:new(param);
	end
	instance:Show();
end

function TriggerStory.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function TriggerStory.EndCallback()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

-- function TriggerStory:Restart(data)
-- 	self.param = data;
-- 	UiBaseClass.Restart(data);
-- end

function TriggerStory:RegistFunc()
    UiBaseClass.RegistFunc(self);
    
	self.bindfunc["on_display_skip"] = Utility.bind_callback(self, self.on_display_skip)
	self.bindfunc["on_skip"] = Utility.bind_callback(self, self.on_skip)

end

function TriggerStory:Init(data)
	app.log("TriggerStory-init");
	ObjectManager.EnableAllAi(false)
	CameraManager.SetFightCamera(false)

	self.param = data;
    self.pathRes = "assetbundles/prefabs/ui/loading/" .. self.param.asset_id .. ".assetbundle";
    UiBaseClass.Init(self, data);

    if self.param.audio_id then
    	if self.param.audio_id > 0 then
			AudioManager.Pause(ENUM.EAudioType._2d, true);
	    	self.audio_id = AudioManager.PlayUiAudio(self.param.audio_id);
	    end
    end
    self.btn_display_skip = ngui.find_button(self.ui, "panel_kaichang_flash/sp_mark");
    if self.btn_display_skip then
    	self.btn_display_skip:set_on_click(self.bindfunc["on_display_skip"], "MyButton.NoneAudio");
    end
    self.btn_skip = ngui.find_button(self.ui, "panel_kaichang_flash/btn_tiaoguo");
    if self.btn_skip then
	    self.btn_skip:set_active(false);
	    self.btn_skip:set_on_click(self.bindfunc["on_skip"], "MyButton.NoneAudio");
	end
end

function TriggerStory:InitData(data)
    UiBaseClass.InitData(self, data);

    self.m_click_num = 0;
    self.m_click_time = 0;
end

function TriggerStory:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_kaichang_flash");

end

function TriggerStory:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function TriggerStory:DestroyUi()
    app.log("TriggerStory-des");
	ObjectManager.EnableAllAi(true)
	CameraManager.SetFightCamera(true)

	if self.audio_id then
		--AudioManager.StopUiAudio(self.audio_id);
		AudioManager.Pause(ENUM.EAudioType._2d, false);
		AudioManager.OneStopUI(self.audio_id, false, 3000, ENUM.EAudioType.UI, self.audio_id)
		self.audio_id = nil;
	end
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end

    self.m_click_num = 0;
    self.m_click_time = 0;

    UiBaseClass.DestroyUi(self);
end

function TriggerStory:on_display_skip(  )
	if self.btn_skip then
		self.btn_skip:set_active(true);
	end
	
	if self.m_click_time == 0 then
		self.m_click_time = system.time();
	end

	self.m_click_num = self.m_click_num + 1;
	if self.m_click_num >= 5 then
		self:on_skip();
	end

	-- app.log("system.time():" .. tostring(system.time()) .. "self.m_click_time:" .. tostring(self.m_click_time));
	-- if system.time() - self.m_click_time < 1 then
		
	-- 	self.m_click_time = system.time();


	-- else
	-- 	self.m_click_num = 0;
	-- 	self.m_click_time = 0;
	-- end
	
end

function TriggerStory:on_skip( )
	self:DestroyUi();
	if instance then		
		instance = nil;
	end
end

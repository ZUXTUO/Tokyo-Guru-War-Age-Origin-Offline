EggHeroShowUI = Class("EggHeroShowUI", UiBaseClass);

function EggHeroShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/egg/ui_2604_egg.assetbundle";
    UiBaseClass.Init(self, data);
end

function EggHeroShowUI:InitData(data)

    UiBaseClass.InitData(self, data);
end

function EggHeroShowUI:Restart(data)
	
	self.awardlist = data.awardlist;
	self.curindex = data.index

	-- app.log("curindex........"..tostring(self.curindex))
	-- app.log("awardlist........"..table.tostring(self.awardlist))

    if not UiBaseClass.Restart(self, data) then

    end
end

function EggHeroShowUI:RegistFunc()
	UiBaseClass.RegistFunc(self)

	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["open_role_info"] = Utility.bind_callback(self, self.open_role_info);
	self.bindfunc["load_call_back"] = Utility.bind_callback(self, self.load_call_back)
	self.bindfunc["on_next"] = Utility.bind_callback(self, self.on_next);
	self.bindfunc["on_last"] = Utility.bind_callback(self, self.on_last);
	self.bindfunc["on_begin_animator"] = Utility.bind_callback(self, self.on_begin_animator);
	self.bindfunc["play_sound_btn"] = Utility.bind_callback(self, self.play_sound_btn);

end

function EggHeroShowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_2604_egg");

    self.closebtn = ngui.find_button(self.ui,"animation/right_top_other/btn_back")
    self.closebtn:set_on_click(self.bindfunc["on_close"]);

    self.quality = ngui.find_sprite(self.ui,"animation/left_top_other/sp_quality")
    self.attack = ngui.find_label(self.ui,"animation/left_top_other/txt")
    self.name = ngui.find_label(self.ui,"animation/down_other/lab_name")
    self.infobtn = ngui.find_button(self.ui,"animation/down_other/btn_blue")
    self.deslab = ngui.find_label(self.ui,"animation/left_top_other/txt/lab")

    self.lastbtn = ngui.find_button(self.ui,"animation/centre_other/btn_left")
    self.lastbtn:set_on_click(self.bindfunc["on_last"]);
    self.nextbtn = ngui.find_button(self.ui,"animation/centre_other/btn_right")
    self.nextbtn:set_on_click(self.bindfunc["on_next"]);

    self.cv = ngui.find_label(self.ui,"animation/down_other/lab_cv")

    self.cv_sound_btn = ngui.find_button(self.ui,"animation/down_other/sp_bugle")
    self.cv_sound_btn:set_on_click(self.bindfunc["play_sound_btn"]);

    self.hero3d = self.ui:get_child_by_name("animation/centre_other/sp_human")

    self.talkNode = self.ui:get_child_by_name("content")
    self.talkNode:set_active(false)
    self.talk_lab = ngui.find_label(self.ui,"content/lab")

    self:UpdateUi();
end

function EggHeroShowUI:UpdateUi()

	--app.log("curindex........"..tostring(self.curindex))
	local cfg = self.awardlist[self.curindex];
	self.heroinfo =  CardHuman:new({number=cfg.item_id});
	--do return end
	PublicFunc.SetAptitudeSprite(self.quality,self.heroinfo.config.aptitude, true);
	PublicFunc.SetProTypeTJ(self.attack, self.heroinfo.pro_type);
	self.name:set_text(self.heroinfo.name);
	self.deslab:set_text(self.heroinfo.config.simple_describe)
	self.infobtn:set_on_click(self.bindfunc["open_role_info"])
	self.cv:set_text(PublicFunc.GetShengyouName(self.heroinfo.model_id))

	self.cv_soud_id = PublicFunc.GetShengyouSound(self.heroinfo.model_id)

	--app.log("cv_soud_id..."..table.tostring(self.cv_soud_id))

	if self.cv_soud_id == 0 then
		self.cv_sound_btn:set_active(false)
	else
		self.cv_sound_btn:set_active(true)
	end

	local data = {
        roleData = self.heroinfo,
        callback = self.bindfunc["load_call_back"]
    }

    EggHero3d.SetAndShow(data)

end

function EggHeroShowUI:load_call_back()
	--app.log("EggHeroShowUI:load_call_back..ShowRole3d")
	self.time_id1 = timer.create(self.bindfunc["on_begin_animator"],300,1);
end

function EggHeroShowUI:on_begin_animator()
	EggHero3d.ShowRole3d()

	local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.heroinfo.model_id);
    self.get_hero_audio = nil;
	self.get_hero_audio_num = nil;
    if model_list_cfg and model_list_cfg.pokedex_get_audio_id and model_list_cfg.pokedex_get_audio_id ~= 0 and type(model_list_cfg.pokedex_get_audio_id) == "table" then
        local count = #model_list_cfg.pokedex_get_audio_id;
        local n = math.random(1,count)
        --self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.pokedex_get_audio_id[n])
        AudioManager.ChangeBackAudioVol(0.4, 100)
		local obj = AudioManager.GetUiAudioSourceNode();
		local cbdata = {}
		cbdata.end_vol = 1
		cbdata.changeTime = 100
		self.get_hero_audio, self.get_hero_audio_num = AudioManager.Play3dAudio(model_list_cfg.pokedex_get_audio_id[n], obj, true, true, true, true, AudioManager.ChangeBackAudioVolEx, cbdata);
    end

end

function EggHeroShowUI:on_close()
	uiManager:PopUi();
end

function EggHeroShowUI:open_role_info()
	local data = 
    {   info = self.heroinfo,
        isPlayer = true,
        heroDataList = {},
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

function EggHeroShowUI:on_next()
	local maxnum = #self.awardlist
	self.curindex = self.curindex + 1
	--app.log("maxnum........."..tostring(maxnum))
	if self.curindex > maxnum then
		self.curindex = maxnum
	end

	if self.curindex >= maxnum then
		self.nextbtn:set_active(false)
		self.lastbtn:set_active(true)
	else
		self.nextbtn:set_active(true)
		self.lastbtn:set_active(true)
	end

	self.talkNode:set_active(false)
	
	--local number = self.awardlist[self.curindex].item_id;
	self:UpdateUi()
end

function EggHeroShowUI:play_sound_btn(t)

	--self.get_hero_cv_audio = nil;
	self.get_hero_audio = nil;
	self.get_hero_audio_num = nil;
	if self.cv_soud_id ~= 0 and type(self.cv_soud_id) == "table" then
        local count = #self.cv_soud_id;
        local n = math.random(1,count)
        --self.get_hero_cv_audio = AudioManager.PlayUiAudio(self.cv_soud_id[n])
        AudioManager.ChangeBackAudioVol(0.4, 100)
		local obj = AudioManager.GetUiAudioSourceNode();
		local cbdata = {}
		cbdata.end_vol = 1
		cbdata.changeTime = 100
		self.get_hero_audio, self.get_hero_audio_num = AudioManager.Play3dAudio(self.cv_soud_id[n], obj, true, true, true, true, AudioManager.ChangeBackAudioVolEx, cbdata);

		self.get_hero_talk = PublicFunc.GetShengyouTalk(self.heroinfo.model_id)

        if self.get_hero_talk == 0 then
            do return end
        end

        if type(self.get_hero_talk) == "table" then
            self.talkNode:set_active(false)
            self.talkNode:set_active(true)
            self.talk_lab:set_text(gs_string_talk[self.get_hero_talk[n]])
        end

    end
end

function EggHeroShowUI:on_last()
	self.curindex = self.curindex - 1
	if self.curindex == 0 then
		self.curindex = 1;
	end
	--local number = self.awardlist[self.curindex].item_id;
	if self.curindex <= 1 then
		self.nextbtn:set_active(true)
		self.lastbtn:set_active(false)
	else
		self.nextbtn:set_active(true)
		self.lastbtn:set_active(true)
	end

	self.talkNode:set_active(false)

	self:UpdateUi()
end

function EggHeroShowUI:DestroyUi()
	EggHero3d.Destroy()

	if self.get_hero_audio and self.get_hero_audio_num then
        --AudioManager.StopUiAudio(self.get_hero_audio)
        local obj = AudioManager.GetAudio3dObject(self.get_hero_audio,self.get_hero_audio_num)
        if obj then
			AudioManager.Stop3dAudio(obj,self.get_hero_audio,self.get_hero_audio_num,true)
        end
        self.get_hero_audio = nil
        self.get_hero_audio_num = nil
    end

    -- if self.get_hero_cv_audio then
    -- 	AudioManager.StopUiAudio(self.get_hero_cv_audio)
    --     self.get_hero_cv_audio = nil
    -- end

	if self.time_id1 then
		timer.stop(self.time_id1)
		self.time_id1 = nil;
	end

	UiBaseClass.DestroyUi(self);
    
end

function EggHeroShowUI:Show()
	if UiBaseClass.Show(self) then
		local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.heroinfo.model_id);
	    self.get_hero_audio = nil;
		self.get_hero_audio_num = nil;
	    if model_list_cfg and model_list_cfg.pokedex_get_audio_id and model_list_cfg.pokedex_get_audio_id ~= 0 and type(model_list_cfg.pokedex_get_audio_id) == "table" then
	        local count = #model_list_cfg.pokedex_get_audio_id;
	        local n = math.random(1,count)
	        --self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.pokedex_get_audio_id[n])
	        AudioManager.ChangeBackAudioVol(0.4, 100)
			local obj = AudioManager.GetUiAudioSourceNode();
			local cbdata = {}
			cbdata.end_vol = 1
			cbdata.changeTime = 100
			self.get_hero_audio, self.get_hero_audio_num = AudioManager.Play3dAudio(model_list_cfg.pokedex_get_audio_id[n], obj, true, true, true, true, AudioManager.ChangeBackAudioVolEx, cbdata);
	    end
	end
end



EggGetHero = Class("EggGetHero", UiBaseClass);

-- 英雄card_human, 是否是新英雄
function EggGetHero.Start(cardInfo, isNew, description, hideCamera)
    if EggGetHero.cls == nil then
        if isNew == nil then
            isNew = false
        end
        EggGetHero.cls = uiManager:PushUi(EUI.EggGetHero, {cardInfo = cardInfo, isNew = isNew, description = description, hideCamera = hideCamera})
        EggGetHero.isFirst = true
	end
end

function EggGetHero.SetFinishCallback(callback, obj)
    if EggGetHero.cls then
        EggGetHero.cls.callbackFunc = callback
        if callback then
            EggGetHero.cls.callbackObj = obj;
        end
    else
        app.log("类未初始化 请先调用start"..debug.traceback());
    end
    
    NoticeManager.NoTeach();--取消新手教程
end

------------------------内部接口-------------------------

function EggGetHero:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/egg/ui_2602_egg.assetbundle";
    UiBaseClass.Init(self, data);
end

function EggGetHero:InitData(data)
    UiBaseClass.InitData(self, data);
end

function EggGetHero:Restart(data)
    self.cardInfo = data.cardInfo
    self.isNew = data.isNew
    self.description = data.description
    self.hideCamera = data.hideCamera

    self.loadingUIId = GLoading.Show(GLoading.EType.loading,0);
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function EggGetHero:RestartData(data)
    UiBaseClass.SetIsCallNow(self, false)
end

function EggGetHero:DestroyUi()
    EggHero3d.Destroy()
    if self.get_hero_audio and self.get_hero_audio_num then
        local obj = AudioManager.GetAudio3dObject(self.get_hero_audio,self.get_hero_audio_num)
        if obj then
            AudioManager.Stop3dAudio(obj,self.get_hero_audio,self.get_hero_audio_num,true)
        end
        self.get_hero_audio = nil
        self.get_hero_audio_num = nil
    end

    if self.get_hero_cv_audio then
        AudioManager.StopUiAudio(self.get_hero_cv_audio)
        self.get_hero_cv_audio = nil
    end
    
    UiBaseClass.DestroyUi(self)
end

function EggGetHero:on_close()
    --连协是否激活(新英雄)
    if self.isNew and EggGetHero.isFirst and self.cardInfo then
        EggGetHero.isFirst = false
        local configData = HeroContactActiveUI.GetActiveHeroContactInfo(self.cardInfo)
        if #configData > 0 then       
            HeroContactActiveUI.Start(configData)
            return
        end
    end
    uiManager:PopUi()
    if EggGetHero.cls then
        EggGetHero.cls = nil
        EggGetHero.isFirst = true
    end
    if self.callbackFunc then
        self.callbackFunc(self.callbackObj)
        self.callbackFunc = nil;
    end

    NoticeManager.Notice(ENUM.NoticeType.GetNewHeroShowBack)
end

function EggGetHero:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["load_call_back"] = Utility.bind_callback(self, self.load_call_back)
    self.bindfunc["on_share_btn"] = Utility.bind_callback(self,self.on_share_btn)
    self.bindfunc["play_sv_btn"] = Utility.bind_callback(self,self.play_sv_btn)
end

function EggGetHero:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("egg_get_hero")
    
    self.labDesc = ngui.find_label(self.ui, "animation/txt")
    self.labCountinue = ngui.find_label(self.ui, "animation/txt_go")

    self.btnShare = ngui.find_button(self.ui,"animation/btn_flaunt")
    self.btnShare:set_on_click(self.bindfunc["on_share_btn"])

    self.btnsv = ngui.find_button(self.ui,"animation/sp_bugle")
    self.btnsv:set_on_click(self.bindfunc["play_sv_btn"])

    self.btnMask = ngui.find_button(self.ui, "sp_mark")
    self.btnMask:set_on_click(self.bindfunc["on_close"])    

    --self.nodeUiEffect = self.ui:get_child_by_name("animation/zhanshitexiao")

    self.labDesc:set_active(false)
    self.labCountinue:set_active(false)
    self.btnShare:set_active(false)
    self.btnMask:set_active(false)
    self.btnsv:set_active(false)
    --self.nodeUiEffect:set_active(false)
    
    local objStars = {}
    for i=1, Const.HERO_MAX_STAR do
        objStars[i] = self.ui:get_child_by_name("cont_star"..i)
        objStars[i]:set_active(self.cardInfo.rarity >= i)
    end

    local labSoundName = ngui.find_label(self.ui, "animation/sp_name_di/lab_sound_name")
    labSoundName:set_text("CV "..PublicFunc.GetShengyouName(self.cardInfo.model_id))

    local labProAndPos = ngui.find_label(self.ui, "animation/left_top_di/txt")
    local labPos = ngui.find_label(self.ui,"animation/left_top_di/txt/lab")
    local strPro = PublicFunc.GetProTypeTxt(self.cardInfo.pro_type)
    local strPos = tostring(self.cardInfo.config.simple_describe)
    labProAndPos:set_text(strPro)
    labPos:set_text(strPos)

    local spAptitude =  ngui.find_sprite(self.ui, "animation/left_top_di/sp")
    PublicFunc.SetAptitudeSprite(spAptitude, self.cardInfo.config.aptitude, true) 

    local labHeroName =  ngui.find_label(self.ui, "animation/sp_name_di/lab_name") 
    local useName, addNum = PublicFunc.ProcessNameSplit(self.cardInfo.name )
    if addNum > 0 then
        useName = useName .."+" ..addNum
    end
    labHeroName:set_text(useName)

    self.talkNode = self.ui:get_child_by_name("content")
    self.talkNode:set_active(false)

    self.talk_lab = ngui.find_label(self.ui,"content/lab")
    --相机相互影响，导致不能显示， 临时隐藏
    --if self.hideCamera then
    TriggerFunc.HideHeroCamera()
    --end

    -- local data = {
    --     roleData = self.cardInfo,
    --     callback = self.bindfunc["load_call_back"]
    -- }
    -- EggShow3d.SetAndShow(data)

    local data = {
        roleData = self.cardInfo,
        callback = self.bindfunc["load_call_back"]
    }

    EggHero3d.SetAndShow(data)

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.RewardGetHero)
    local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.cardInfo.model_id);
    self.get_hero_audio = nil;
    self.get_hero_audio_num = nil;
    self.cv_soud_id = PublicFunc.GetShengyouSound(self.cardInfo.model_id)
    
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

function EggGetHero:play_sv_btn()

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
    
        self.get_hero_talk = PublicFunc.GetShengyouTalk(self.cardInfo.model_id)

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

function EggGetHero:load_call_back()
    GLoading.Hide(GLoading.EType.loading, self.loadingUIId);
    UiBaseClass.OnLoadedCallBack(self)

    --开门 + 模糊 + z字梯 + 英雄展示 + UI特效 + UI动画 + 其余UI显示
    --其中：英雄展示，UI特效的表现时机由程序控制
    local funcShowModel = function()
        --EggShow3d.ShowRole3d()
        EggHero3d.ShowRole3d()
    end

    local funcUiEffect = function()
        -- if self.nodeUiEffect then
        --     self.nodeUiEffect:set_active(true)
        -- end
    end

    local funcShowUiInfo = function()
        if self.labDesc and self.description then
            self.labDesc:set_active(true)
        end
        if self.labCountinue then
            self.labCountinue:set_active(true)
        end
        if self.btnShare then
            self.btnShare:set_active(true)
        end
        if self.btnMask then
            self.btnMask:set_active(true)
        end

        if self.cv_soud_id == 0 then
            self.btnsv:set_active(false)
        else
            self.btnsv:set_active(true)
        end
    end

    TimerManager.Add(funcShowModel, 100)
    TimerManager.Add(funcUiEffect, 1500)
    TimerManager.Add(funcShowUiInfo, 4000)
end

function EggGetHero:on_share_btn()
    share_ui_button.Start(2,5)
end
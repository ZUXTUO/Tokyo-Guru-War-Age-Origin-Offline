--CommonGetHero = Class("CommonGetHero", MultiResUiBaseClass);

---- 英雄card_human, 是否是新英雄
--function CommonGetHero.Start(cardInfo, isNew, description)
--    if CommonGetHero.cls == nil then
--        if isNew == nil then
--            isNew = false
--        end
--		--CommonGetHero.cls = CommonGetHero:new({cardInfo = cardInfo, isNew = isNew, description = description});
--        CommonGetHero.cls = uiManager:PushUi(EUI.CommonGetHero, {cardInfo = cardInfo, isNew = isNew, description = description})
--        CommonGetHero.isFirst = true
--	end
--end

--function CommonGetHero.SetFinishCallback(callback, obj)
--    if CommonGetHero.cls then
--        CommonGetHero.cls.callbackFunc = callback
--        if callback then
--            CommonGetHero.cls.callbackObj = obj;
--        end
--    else
--        app.log("类未初始化 请先调用start"..debug.traceback());
--    end
--end

----------------------内部接口-------------------------
--local resType = 
--{
--    Front = 1,
--    Back = 2,
--}

--local _uiText = 
--{
--    [1] = '获得角色',
--    [2] = '获得新角色',
--}

--local resPaths = 
--{
--    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_828_fight.assetbundle';
--}

--function CommonGetHero:Init(data)
--	self.pathRes = resPaths
--	MultiResUiBaseClass.Init(self, data);
--end

--function CommonGetHero:RegistFunc()
--    MultiResUiBaseClass.RegistFunc(self);

--	self.bindfunc["OnClose"] = Utility.bind_callback(self, self.OnClose);
--    self.bindfunc["Show3dLoadOk"] = Utility.bind_callback(self, self.Show3dLoadOk);
--end 

--function CommonGetHero:Show3dLoadOk()
--    self:Show()

--    local effectConfig = ConfigManager.Get(EConfigIndex.t_effect_data,19018);

--    local entityObj = Show3d.GetInstance().role3d.obj
--    if entityObj then
--        self.effectids = entityObj:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data,19018), CommonGetHero.EffectLoadOk, self, nil, nil, 0)
--    end
--end

--function CommonGetHero:EffectLoadOk()
--    --app.log("CommonGetHero:EffectLoadOk")
--end

--function CommonGetHero:OnLoadUI()
--    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
--end

--function CommonGetHero:InitedAllUI()

--    local frontui = self.uis[resPaths[resType.Front]]

--    local initData = self:GetInitData()
--    local titleLabel = ngui.find_label(frontui, 'animation_win/cont1/sp_left')
--    if initData.isNew then
--        titleLabel:set_text(_uiText[2])
--    else
--        titleLabel:set_text(_uiText[1])
--    end

--    local unUseNode = frontui:get_child_by_name("fx_ui_828_fight_huode")
--    if unUseNode then
--        unUseNode:set_active(false)
--    end

--    self.back = ngui.find_button(frontui,"btn_sure");
--	self.back:set_on_click(self.bindfunc["OnClose"]);

--    local convertLab = ngui.find_label(frontui, 'txt')
--    if initData.description then
--        convertLab:set_text(initData.description)
--    else
--        convertLab:set_active(false)
--    end

--    local cardInfo = initData.cardInfo

--    if cardInfo == nil then return end

----    local headParent = frontui:get_child_by_name('big_card_item_80')
----    self.heroSmallCardUi = SmallCardUi:new({parent = headParent, info = cardInfo,
----            stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}})

--    local titleLabel = ngui.find_label(frontui, 'lab_name')
--    titleLabel:set_text(cardInfo.name)

--    local star = cardInfo.rarity
--    local maxRarity = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_upgradeStarMaxLevel).data;
--    for i=1, maxRarity do
--        local starSp = ngui.find_sprite(frontui, 'content_star/sp_star' .. tostring(i))
--        if i > star then
--            starSp:set_sprite_name('xingxing3')
--        else
--            starSp:set_sprite_name('xingxing1')
--        end
--    end

--    local aptitudesp = ngui.find_sprite(frontui, 'sp_aptitude')
--    PublicFunc.SetAptitudeSprite(aptitudesp, cardInfo.config.aptitude, true);

--    local typesp = ngui.find_sprite(frontui, 'sp_type')
--    PublicFunc.SetProTypePic(typesp, cardInfo.pro_type, 5)


----    self.restrainbkTex = ngui.find_texture(frontui, 'txt_restrain_nature/sp_di1')
----    PublicFunc.SetRestraintTextureBk(self.restrainbkTex, cardInfo:GetRestraint());
----    local restrainsp = ngui.find_sprite(frontui, 'txt_restrain_nature/sp_di1/sp')
----    PublicFunc.SetRestraintSprite(restrainsp, cardInfo:GetRestraint(), 5)

--    local initiativeSkillKeyName = {'skill4', 'skill5', 'skill6'}
--    self.skillTexture = {}
--    for i=1,3 do
--        local texPath = ConfigManager.Get(EConfigIndex.t_skill_info,cardInfo.config.spe_skill[i][1]).small_icon;
--        self.skillTexture[i] = ngui.find_texture(frontui, 'content_skill/sp_skill_di' .. tostring(i) .. '/Texture')
--        self.skillTexture[i]:set_texture(texPath)
--    end

--    local data = 
--    {
--        roleData = cardInfo,
--        --role3d_ui_touch = self.hero3D,
--        type = "mid",
--    }
--    --app.log("3d data #########"..table.tostring(cardInfo))
--    Show3d.SetAndShow(data)
--    Show3d.SetLoadCallBack(self.bindfunc["Show3dLoadOk"])
--    AudioManager.PlayUiAudio(ENUM.EUiAudioType.RewardGetHero)
--    local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, cardInfo.model_id);
--    self.get_hero_audio = nil;
--    if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 then
--        self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id)
--    end

--    if Show3d.GetInstance().role3d == nil then
--        local entityObj = Show3d.GetInstance().role3d.obj
--        if entityObj == nil then
--            self:Hide()
--        else
--            self.effectids = entityObj:SetEffect(nil, ConfigManager.Get(EConfigIndex.t_effect_data,19018), CommonGetHero.EffectLoadOk, self, nil, nil, 0)
--        end
--    end
--end

--function CommonGetHero:DestroyUi()

--    if self.is_destroyed then
--        return
--    end

--    MultiResUiBaseClass.DestroyUi(self)

--    if self.effectids then
--        for k,gid in pairs(self.effectids) do
--            EffectManager.deleteEffect(gid)
--        end
--    end

--    if self.skillTexture then
--        for k,v in ipairs(self.skillTexture) do
--            v:Destroy()
--        end

--        self.skillTexture = nil
--    end
--    if self.restrainbkTex then
--        self.restrainbkTex:Destroy()
--        self.restrainbkTex = nil
--    end

--    Show3d.Destroy()
--    if self.get_hero_audio then
--        AudioManager.StopUiAudio(self.get_hero_audio)
--    end
--end

--function CommonGetHero:OnClose()
--    local initData = self:GetInitData() 
--    --连协是否激活(新英雄)
--    if initData.isNew and CommonGetHero.isFirst and initData.cardInfo then
--        CommonGetHero.isFirst = false
--        local configData = initData.cardInfo:GetActiveHeroContactInfo()
--        if #configData > 0 then       
--            HeroContactActiveUI.Start(configData)
--            return
--        end
--    end

--    uiManager:PopUi()
--    if CommonGetHero.cls then
--        --CommonGetHero.cls:DestroyUi()
--        CommonGetHero.cls = nil
--        CommonGetHero.isFirst = true
--    end
--    if self.callbackFunc then
--        self.callbackFunc(self.callbackObj)
--    end
--end
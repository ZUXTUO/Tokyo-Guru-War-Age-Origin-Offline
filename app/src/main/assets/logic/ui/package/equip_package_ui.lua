EquipPackageUI = Class("EquipPackageUI", MultiResUiBaseClass)

local _UIText = {
    [1] = '进化可以提升属性',
    [2] = '进化装备可提升装备成长值,能够高效提升角色战力',
    [3] = '生 命',
    [4] = '攻 击',
    [5] = '防 御',
    [6] = '材料不足',
    [7] = '金币不足',
    [8] = '当前已达最低星级',
    [9] = '等级',
    [10] = '该装备已经达到最大星级',
    [11] = '装备降星',
    [12] = '钻石不足',
    [13] = "本次降星会使装备[00FDFFFF]降低一星[-]，并返回该星级进化材料\n是否继续？\n\n\n[A09FDFFF]装备降星消耗[-]|item:3|%d",
    [14] = "确定",
    [15] = "取消",

    [16] = "所有",
    [17] = "防",
    [18] = "攻",
    [19] = "技",
    [20] = '进化可激活连协',
    [21] = '战队等级达到%d级开启',
    [22] = '战力 %s',
    [23] = "星",
    [24] = "返还的道具发至邮箱",
    [25] = "已激活连协",
    [26] = "已激活属性",
}

function EquipPackageUI:GetNavigationAdvPlane()
    return true;
end

function EquipPackageUI:ShowNavigationBar()
    return true
end

function EquipPackageUI:Show() 
    --MultiResUiBaseClass.Show(self)
    if not self.ui then
        return
    end
    self.ui:set_active(true)
    if self.chooseYekaName == "yeka1" then
        self.levelUpUI:set_active(true)
    else
        self.starUpUI:set_active(true)
    end
    self:UpdateRightPane()
    self:SetEquipExpertBtn()

    --从其它界面直接返回时刷新，更新小红点
    self:UpdateCurrEquipment()

    --动画不播放
    if self.objLevelAnimation then
        self.objLevelAnimation:set_active(false)
    end

    self:ForeachNormalEquip(function(cardInfo, item)
        local objFx = item:GetExtFx()
        if objFx then
            objFx:set_active(false)
        end
    end)
    self.fxLevel:set_active(false)

    local show3d = Show3d.GetInstance()
    if show3d then
        show3d:Show()
    end
end

function EquipPackageUI:Hide()
    MultiResUiBaseClass.Hide(self)
    
    local show3d = Show3d.GetInstance()
    if show3d then
        show3d:Hide()
    end
end

local resType = 
{
    Main = 1,
    LevelUp = 2,
    StarUp = 3, 
}

function EquipPackageUI:Init(data)
    self.pathRes = {
        [resType.Main] = "assetbundles/prefabs/ui/package/ui_604_battle.assetbundle",
        [resType.LevelUp] = "assetbundles/prefabs/ui/package/ui_604_4.assetbundle",
        [resType.StarUp] = "assetbundles/prefabs/ui/package/ui_604_3.assetbundle",
    }
    MultiResUiBaseClass.Init(self, data)
end

function EquipPackageUI:InitData(data)
    self.currEquipPos = 1;
	MultiResUiBaseClass.InitData(self, data)
    self.proTypeList = {        
        [1] = {txt = _UIText[18], type = ENUM.EProType.Gong, spName = "yx_zhanshi1"}, 
        [2] = {txt = _UIText[19], type = ENUM.EProType.Ji, spName = "yx_nengliang1"}, 
        [3] = {txt = _UIText[17], type = ENUM.EProType.Fang, spName = "yx_roudun1"},
        [4] = {txt = _UIText[16], type = ENUM.EProType.All, spName = "yx_quanbu1"}, 
    }
    self.equipPositionList = {
        ENUM.EEquipPosition.weapon,  ENUM.EEquipPosition.Armor, 
        ENUM.EEquipPosition.Trouser, ENUM.EEquipPosition.Boots, 
        ENUM.EEquipPosition.Accessories, ENUM.EEquipPosition.Helmet, 
    } 
    self.dataSource = g_dataCenter.package
    self.equipShowProp = 
    {
        {key = 'max_hp', str = _UIText[3]},
        {key = 'atk_power', str = _UIText[4]},
        {key = 'def_power', str = _UIText[5]},
    }    
end

function EquipPackageUI:Restart(data)
    self.data = data
    if self.data and self.data.eType then
        self.eType = self.data.eType;
    end
    if  self.data and self.data.equipPos ~= nil then
        self.currEquipPos = self.data.equipPos
    end

    self.isOpenTag = false
    --动画不播放
    if self.objLevelAnimation then
        self.objLevelAnimation:set_active(false)
    end

    self.equipSmallItemList = {}
    self.equipItemSpList = {}

    self.equipInfoUI = {
        smallItem = nil, name = nil, level = nil, 
        props = {
            {lbl = nil, num1 = nil, lblTop = nil, num2 = nil},
            {lbl = nil, num1 = nil, lblTop = nil, num2 = nil},
        }
    }
    self.specRarityUI = {
        isInit = false, texture1 = nil, lbl1 = nil, texture2 = nil, lbl2 = nil,
        lblHave = nil, lblDesc = nil,
        lblGold = nil,
    }

    self.equipMaterialUI = {isInit = false, smallItem = {}, objGold = nil, lblGold = nil}
    self.equipSpecMaterialUI = {isInit = false, smallItem = {}, objGold = nil, lblGold = nil}

    self.expProgressUI = {isInit = false, obj = nil, pro1 = nil, pro2 = nil, lbl = nil}

    self.chooseYekaName = "yeka1" 
    --
    self.levelUpEquipIndexList = {}
    self.rarityUpEquipIndexList = {}

    self.tipsUI = nil
    self.needPlayProAnimation = false
	if MultiResUiBaseClass.Restart(self, data) then        
	end
end

function EquipPackageUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self)
    self.bindfunc["on_choose_hero"] = Utility.bind_callback(self,self.on_choose_hero)
    self.bindfunc["update_choose_hero"] = Utility.bind_callback(self,self.update_choose_hero)
    self.bindfunc["update_ui"] = Utility.bind_callback(self,self.update_ui)

    self.bindfunc["on_yeka"] = Utility.bind_callback(self,self.on_yeka)  
    self.bindfunc["on_level_up_all"] = Utility.bind_callback(self,self.on_level_up_all) 
    self.bindfunc["on_level_up_key"] = Utility.bind_callback(self,self.on_level_up_key) 

    self.bindfunc["on_level_up"] = Utility.bind_callback(self,self.on_level_up)
    self.bindfunc["on_quick_level_up"] = Utility.bind_callback(self,self.on_quick_level_up)

    self.bindfunc["gc_equip_level_up"] = Utility.bind_callback(self,self.gc_equip_level_up)
    self.bindfunc["gc_equip_rarity_up"] = Utility.bind_callback(self,self.gc_equip_rarity_up)   
    self.bindfunc["gc_special_equip_level_up_fast"] = Utility.bind_callback(self,self.gc_special_equip_level_up_fast)  

    self.bindfunc["on_rarity_up"] = Utility.bind_callback(self,self.on_rarity_up)  
    self.bindfunc["on_rarity_up_all"] = Utility.bind_callback(self,self.on_rarity_up_all)  

    self.bindfunc["on_auto_add_material"] = Utility.bind_callback(self,self.on_auto_add_material) 
    self.bindfunc["on_add_material"] = Utility.bind_callback(self,self.on_add_material) 
    self.bindfunc["update_exp_and_material"] = Utility.bind_callback(self,self.update_exp_and_material) 

    self.bindfunc["on_click_equip"] = Utility.bind_callback(self,self.on_click_equip)   
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self,self.on_find_way_material) 
    self.bindfunc["on_click_equip_lock"] = Utility.bind_callback(self,self.on_click_equip_lock)  
    self.bindfunc["on_show_hero_info"] = Utility.bind_callback(self,self.on_show_hero_info)

    self.bindfunc["on_click_star_up_btn"] = Utility.bind_callback(self,self.on_click_star_up_btn)  
    self.bindfunc["on_click_star_down_btn"] = Utility.bind_callback(self,self.on_click_star_down_btn) 
    self.bindfunc["on_response_star_up"] = Utility.bind_callback(self,self.on_response_star_up) 
    self.bindfunc["on_response_star_down"] = Utility.bind_callback(self,self.on_response_star_down) 

    self.bindfunc["OnConfirmStarDown"] = Utility.bind_callback(self,self.OnConfirmStarDown) 

    self.bindfunc["OnClickLockStarUpTabHead"] = Utility.bind_callback(self,self.OnClickLockStarUpTabHead)

    self.bindfunc["on_update_hero_property"] = Utility.bind_callback(self,self.on_update_hero_property)
    self.bindfunc["end_play_animation"] = Utility.bind_callback(self, self.end_play_animation)
    self.bindfunc["end_play_animation2"] = Utility.bind_callback(self, self.end_play_animation2)
    self.bindfunc["on_show_equip_expert"] = Utility.bind_callback(self, self.on_show_equip_expert)
end

function EquipPackageUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_equip_level_up,self.bindfunc['gc_equip_level_up'])
    PublicFunc.msg_regist(msg_cards.gc_equip_rarity_up,self.bindfunc['gc_equip_rarity_up'])
    PublicFunc.msg_regist(msg_cards.gc_equip_star_up,self.bindfunc['on_response_star_up'])
    PublicFunc.msg_regist(msg_cards.gc_star_down,self.bindfunc['on_response_star_down'])
    PublicFunc.msg_regist(msg_cards.gc_update_role_cards, self.bindfunc['on_update_hero_property'])
    PublicFunc.msg_regist(msg_cards.gc_special_equip_level_up_fast,self.bindfunc['gc_special_equip_level_up_fast'])
end

function EquipPackageUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_equip_level_up,self.bindfunc['gc_equip_level_up'])
    PublicFunc.msg_unregist(msg_cards.gc_equip_rarity_up,self.bindfunc['gc_equip_rarity_up'])
    PublicFunc.msg_unregist(msg_cards.gc_equip_star_up,self.bindfunc['on_response_star_up'])
    PublicFunc.msg_unregist(msg_cards.gc_star_down,self.bindfunc['on_response_star_down'])
    PublicFunc.msg_unregist(msg_cards.gc_update_role_cards, self.bindfunc['on_update_hero_property'])
    PublicFunc.msg_unregist(msg_cards.gc_special_equip_level_up_fast,self.bindfunc['gc_special_equip_level_up_fast'])
end

function EquipPackageUI:OnLoadUI()
    MultiResUiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function EquipPackageUI:DestroyUi()    

    FightValueChangeUI.EnableShowChange(true)

    for k, v in pairs(self.equipSmallItemList) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    if self.get_hero_audio ~= nil then
        AudioManager.StopUiAudio(self.get_hero_audio)
        self.get_hero_audio = nil
    end
    self.equipSmallItemList = {}
    self.equipItemSpList = {}
    self.currEquipPos = 1;

    Show3d.Destroy()

    if self.equipInfoUI.smallItem then
        self.equipInfoUI.smallItem:DestroyUi()
        self.equipInfoUI.smallItem = nil
    end
    for _, v in pairs(self.equipMaterialUI.smallItem) do
        if v ~= nil then
            v:DestroyUi()
            v = nil
        end
    end

    if self.specRarityUI.texture1 ~= nil then
        self.specRarityUI.texture1:Destroy()
        self.specRarityUI.texture1 = nil
    end
    if self.specRarityUI.texture2 ~= nil then
        self.specRarityUI.texture2:Destroy()
        self.specRarityUI.texture2 = nil
    end    

    if self.starUpOldSmallItemUi then
        self.starUpOldSmallItemUi:DestroyUi()
        self.starUpOldSmallItemUi = nil
    end

    if self.starUpNewSmallItemUi then
        self.starUpNewSmallItemUi:DestroyUi()
        self.starUpNewSmallItemUi = nil
    end
    if self.starUpMaterialSmallItemUi then
        for k, v in ipairs(self.starUpMaterialSmallItemUi) do
            v:DestroyUi()
        end
        
        self.starUpMaterialSmallItemUi = nil
    end

    if self.starMaxSmallItemUi then
        self.starMaxSmallItemUi:DestroyUi()
        self.starMaxSmallItemUi = nil
    end

    if self.heroListUi then
        self.heroListUi:DestroyUi()
        self.heroListUi = nil
    end
    -- if self.roleInfo then
    --     self.roleInfo:DestroyUi();
    --     self.roleInfo = nil
    -- end

    if self.clsMaterialUi ~= nil then
        self.clsMaterialUi:DestroyUi()
        self.clsMaterialUi = nil
    end

    if self.tp then
        self.tp:Stop()
        self.tp = nil
    end
    self:RemoveAnimationTimer()

    EquipQuickLevelUpUI.End()
    UiEquipRarityUpAllResult.End()
    UiEquipExpertResult.End()

    MultiResUiBaseClass.DestroyUi(self)    
end

function EquipPackageUI:OnClickLockStarUpTabHead()
    local level = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_unlock_player_level).data
    FloatTip.Float(string.format(_UIText[21], level))
end

function EquipPackageUI:SetEquipExpertBtn()
    local isReach = CardEquipment.PlayerReachStarUpLevel()
    self.btnEquipExpert:set_active(isReach)
end

function EquipPackageUI:on_show_equip_expert()
    if self.roleData then
        EquipExpertUI.Start(self.roleData)
    end
end

function EquipPackageUI:GetUIByType(resType)
    return self.uis[self.pathRes[resType]]
end

function EquipPackageUI:InitedAllUI(asset_obj)
    local path = "centre_other/animation/"
    local tagPath = path .. "panel_list/animation/"

    self.ui = self:GetUIByType(resType.Main)
    local objParent = self.ui:get_child_by_name(path .. "right_content")
    self.levelUpUI = self:GetUIByType(resType.LevelUp)
    self.levelUpUI:set_parent(objParent)
    self.levelUpUI:set_name("cont1")

    self.starUpUI = self:GetUIByType(resType.StarUp)
    self.starUpUI:set_parent(objParent)
    self.starUpUI:set_name("cont2")

    self.spHuman = ngui.find_sprite(self.ui, path  .. "sp_human")
    self.btnEquipExpert = ngui.find_button(self.ui, path  .. "sp_equip_di")
    self.btnEquipExpert:set_on_click(self.bindfunc["on_show_equip_expert"])
    self:SetEquipExpertBtn()

    --英雄相关
    self.objHeroInfo = self.ui:get_child_by_name(path .. "cont_yingxiong_xinxi")
    self.lblHeroName = ngui.find_label(self.ui, path .. "cont_yingxiong_xinxi/lab_name")
    self.lblHeroNameNum = ngui.find_label(self.ui, path .. "cont_yingxiong_xinxi/lab_name/lab_num")

    self.lblFightValue = ngui.find_label(self.ui, path .. "cont_yingxiong_xinxi/lab_fight")
    self.btnHeroInfo = ngui.find_button(self.ui, path .. "cont_yingxiong_xinxi/btn_rule")
    self.btnHeroInfo:set_on_click(self.bindfunc["on_show_hero_info"])
    self.spAptitude = ngui.find_sprite(self.ui, path  .. "cont_yingxiong_xinxi/sp_pinjie")

    --装备
    self.objEquipmentInfo = self.ui:get_child_by_name(path .. "content")
    for i = 1, 6 do
        local item_path = path .. "content/new_small_card_item" .. i
        local obj = self.ui:get_child_by_name(item_path)
        --By:Ewing 小红点
        self.equipSmallItemList[i] = UiSmallItem:new({parent = obj, cardInfo = nil, delay = -1, parent_path = item_path, eui_id = EUI.EquipPackageUI,equip ={new_point = true, level_tip = true}})
        self.equipSmallItemList[i]:SetOnClicked(self.bindfunc["on_click_equip"], "", i)

        if i == 5 or i == 6 then
            local spLock = ngui.find_sprite(self.ui, item_path .. "/sp_mark")
            spLock:set_on_ngui_click(self.bindfunc["on_click_equip_lock"])
            spLock:set_event_value(tostring(self.equipPositionList[i]))

            local spTitle = ngui.find_sprite(self.ui, item_path .. "/sp_title")
            self.equipItemSpList[i] = {spLock = spLock, spTitle = spTitle}
        else
            local objFx = obj:get_child_by_name("fx_ui_level_up")
            objFx:set_active(false)
            self.equipSmallItemList[i]:SetExtFx(objFx)
        end
    end

    --页卡
    self.toggleYeka = {}
    for i = 1, 2 do
        self.toggleYeka["yeka" .. i] = ngui.find_toggle(self.ui, path .. "right_content/yeka/yeka" .. i)
        self.toggleYeka["yeka" .. i]:set_value(false);
        self.toggleYeka["yeka" .. i]:set_on_change(self.bindfunc['on_yeka'])
    end
    self.objRightPane = self.ui:get_child_by_name(path .. "right_content")

    local pathCont1 = path .. "right_content/cont1/"
    --升级
    self.objLevelUpPane = self.ui:get_child_by_name(path .. "right_content/cont1")

    local pathBK = pathCont1 .. "cont_tongyong/"
    self.objLevelAnimation = self.ui:get_child_by_name(pathBK .. "fx")
    self.objLevelAnimation:set_active(false)

    self.fxLevel = self.ui:get_child_by_name(pathCont1 .. "cont_tongyong/fx_level")
    self.fxLevel:set_active(false)

    if self.equipInfoUI.smallItem == nil then
        local item_path = pathBK .. "new_small_card_item"
        local obj = self.ui:get_child_by_name(item_path)
        self.equipInfoUI.smallItem  = UiSmallItem:new({parent = obj, cardInfo = nil, delay = -1, show_tip_point = false})
    end
    self.equipInfoUI.name = ngui.find_label(self.ui, pathBK .. "lab_equip_name")
    self.equipInfoUI.level = ngui.find_label(self.ui, pathBK .. "lab_num")

    for k, v in pairs(self.equipInfoUI.props) do
        local _path = pathBK .. "lab" .. k
        v.lbl = ngui.find_label(self.ui, _path)
        v.lblTop = ngui.find_label(self.ui, _path .. "/lab1")
        v.num1 = ngui.find_label(self.ui, _path .. "/lab_num1")
        --v.arrow = ngui.find_sprite(self.ui, _path .. "lab_num1/sp_jian_tou")
        v.num2 = ngui.find_label(self.ui, _path .. "/lab_num1/lab_num2")
    end

    --exp进度条
    self.expProgressUI.obj = self.ui:get_child_by_name(pathBK .. "txt_exp")
    self.spTopEffect = self.ui:get_child_by_name(pathCont1 .. "sp_art_font1")


    -----------------------------------------------------------------------------------

    self.normalUi = {
        all = self.ui:get_child_by_name(pathCont1 .. "cont_putong"),
        levelUp = self.ui:get_child_by_name(pathCont1 .. "cont_putong/cont_qianghua_shengji"),
        rarityUp = self.ui:get_child_by_name(pathCont1 .. "cont_putong/cont_shengpin"),
    }
    self.specicalUi = {
        all = self.ui:get_child_by_name(pathCont1 .. "cont_teshu"),
        levelUp = self.ui:get_child_by_name(pathCont1 .. "cont_teshu/cont_teshu_shengji"),
        rarityUp = self.ui:get_child_by_name(pathCont1 .. "cont_teshu/cont_teshu_shengpin"),
    }

    ----------------------------------普通升级--------------------------------------------

    self.normalLevelUpUI = {
        all = {
            spBtn = ngui.find_sprite(self.normalUi.levelUp, "btn_left/animation/sprite_background"),
            lblBtn = ngui.find_label(self.normalUi.levelUp, "btn_left/animation/lab"),
            spGold = ngui.find_sprite(self.normalUi.levelUp, "sp_gold_left"),
            lblGold = ngui.find_label(self.normalUi.levelUp, "sp_gold_left/lab"),
            lblDesc = ngui.find_label(self.normalUi.levelUp, "cont_xianzhi/lab1"),
        },
        key = {
            spBtn = ngui.find_sprite(self.normalUi.levelUp, "btn_yijianshengji/animation/sprite_background"),
            lblBtn = ngui.find_label(self.normalUi.levelUp, "btn_yijianshengji/animation/lab"),
            spGold = ngui.find_sprite(self.normalUi.levelUp, "sp_gold_right"),
            lblGold = ngui.find_label(self.normalUi.levelUp, "sp_gold_right/lab"),
            lblDesc = ngui.find_label(self.normalUi.levelUp, "cont_xianzhi/lab2"),
        }
    }
    local btnLevelUpAll = ngui.find_button(self.normalUi.levelUp, "btn_left")
    btnLevelUpAll:set_on_click(self.bindfunc["on_level_up_all"], "MyButton.NoneAudio")
    local btnLevelUpKey = ngui.find_button(self.normalUi.levelUp, "btn_yijianshengji")
    btnLevelUpKey:set_on_click(self.bindfunc["on_level_up_key"], "MyButton.NoneAudio")


    ----------------------------------普通升品----------------------------------

    --升品
    self.spRarityUpNormal = ngui.find_sprite(self.normalUi.rarityUp, "btn_shengpin/animation/sprite_background")
    self.lblRarityUpNormal = ngui.find_label(self.normalUi.rarityUp, "btn_shengpin/animation/lab")

    local btnRarityUpNormal = ngui.find_button(self.normalUi.rarityUp, "btn_shengpin")
    btnRarityUpNormal:set_on_click(self.bindfunc["on_rarity_up"], "MyButton.NoneAudio")


    --全部升品 
    local btnRarityUpAll = ngui.find_button(self.normalUi.rarityUp, "btn_quan_shengpin")
    btnRarityUpAll:set_on_click(self.bindfunc["on_rarity_up_all"], "MyButton.NoneAudio")


    ----------------------------------特殊升级----------------------------------

    local btnQuickLevelUp = ngui.find_button(self.specicalUi.levelUp, "cont1/btn_left")
    btnQuickLevelUp:set_on_click(self.bindfunc["on_quick_level_up"], "MyButton.NoneAudio")

    local btnAutoAdd = ngui.find_button(self.specicalUi.levelUp, "cont1/btn_center")
    local btnAutoAdd2 = ngui.find_button(self.specicalUi.levelUp, "cont2/btn_center")
    btnAutoAdd:set_on_click(self.bindfunc["on_auto_add_material"], "MyButton.NoneAudio")
    btnAutoAdd2:set_on_click(self.bindfunc["on_auto_add_material"], "MyButton.NoneAudio")

    local btnLevelUp = ngui.find_button(self.specicalUi.levelUp, "cont1/btn_right")
    local btnLevelUp2 = ngui.find_button(self.specicalUi.levelUp, "cont2/btn_right")
    btnLevelUp:set_on_click(self.bindfunc["on_level_up"], "MyButton.NoneAudio")
    btnLevelUp2:set_on_click(self.bindfunc["on_level_up"], "MyButton.NoneAudio")

    self.objSpecLevelUpCont1 = self.specicalUi.levelUp:get_child_by_name("cont1")
    self.objSpecLevelUpCont2 = self.specicalUi.levelUp:get_child_by_name("cont2")

    self.spTipSpecLv1 = ngui.find_sprite(self.specicalUi.levelUp, "cont1/btn_right/animation/sp_point")
    self.spTipSpecLv1:set_active(false)
    self.spTipSpecLv2 = ngui.find_sprite(self.specicalUi.levelUp, "cont2/btn_right/animation/sp_point")
    self.spTipSpecLv2:set_active(false)

    ----------------------------------特殊升品----------------------------------

    self.spRarityUp = ngui.find_sprite(self.specicalUi.rarityUp, "btn_shengpin/animation/sprite_background")
    self.lblRarityUp = ngui.find_label(self.specicalUi.rarityUp, "btn_shengpin/animation/lab")

    local btnRarityUp = ngui.find_button(self.specicalUi.rarityUp, "btn_shengpin")
    btnRarityUp:set_on_click(self.bindfunc["on_rarity_up"], "MyButton.NoneAudio")



    --升星
    self.objUpStarPane = self.ui:get_child_by_name("right_content/cont2")

    --新手引导定位指定功能界面
    if GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0 then
        local function_id = GuideManager.GetGuideFunctionId()
        local eType = {
            [MsgEnum.eactivity_time.eActivityTime_EquipLevel] = 1,
            [MsgEnum.eactivity_time.eActivityTime_EquipStar] = 2,
        }
        if eType[function_id] then
            self.eType = eType[function_id]
        end
    end

    if self.heroListUi == nil then
        local parentObj = self.ui:get_child_by_name("down_other/animation/panel_list_hero_item")
        local _roleNumber = nil;
        if self.data and self.data.cardNumber then
            _roleNumber = self.data.cardNumber;
        end
        self.heroListUi = CommonHeroListUI:new({
            roleNumber = _roleNumber,
            parent = parentObj,
            tipType = SmallCardUi.TipType.Equip,
            callback = {
                update_ui = self.bindfunc["update_ui"],
                update_choose_hero = self.bindfunc["update_choose_hero"],
                on_choose_hero = self.bindfunc["on_choose_hero"],
            }
        })
        self.heroListUi:UpdateUi()
    end
end

function EquipPackageUI:on_update_hero_property()
    if self.lblFightValue then
        self.lblFightValue:set_text(tostring(self.roleData:GetFightValue()))
    end
end

function EquipPackageUI:on_show_hero_info()
    -- self:ShowHeroInfoUI(true)
    -- uiManager:PushUIStack(EUI.EquipPackageUI)
    --uiManager:Show()

    -- if self.roleInfo then
    --     if self.roleData then
    --         self.roleInfo:SetInfo(self.roleData)
    --     end
    --     self.roleInfo:Show()
    -- else
    --     local data = 
    --     {
    --         info = self.roleData,
    --         isPlayer = true,
    --     }
    --     self.roleInfo = BattleRoleInfoUI:new(data);
    -- end

    local data =
    {
        info = self.roleData,
        isPlayer = true,
        heroDataList = {},
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

-- function EquipPackageUI:on_navbar_back()
--     if self.roleInfo and self.roleInfo:IsShow() then
--         self:ShowHeroInfoUI(false)
--         uiManager:PopUIStack()
-- 		uiManager:Show()

--         --选择的英雄可能已改变,手动刷新
--         self:on_choose_hero()

--         return true;
--     end
--     return false
-- end

-- function EquipPackageUI:ShowHeroInfoUI(isShow)
--     if isShow then
--         self.btnHeroInfo:set_active(false)
--         self.objEquipmentInfo:set_active(false)
--         self.objRightPane:set_active(false) 

--         if self.roleInfo then
--             if self.roleData then
--                 self.roleInfo:SetInfo(self.roleData)
--             end
--             self.roleInfo:Show()
--         else
--             local data = 
--             {
--                 parent = self.ui,
--                 info = self.roleData,
--             }
--             self.roleInfo = BattleRoleInfoUI:new(data);
--         end
--     else
--         self.btnHeroInfo:set_active(true)
--         self.objEquipmentInfo:set_active(true)
--         self.objRightPane:set_active(true) 

--         if self.roleInfo then
--             self.roleInfo:Hide();
--         end
--     end
-- end

function EquipPackageUI:InitStarUpUi()

    if self.starUpMaterialSmallItemUi then return end

    self.starUpNotFullNode = self.ui:get_child_by_name('right_content/cont2/cont_shengxing')
    self.starUpFullNode = self.ui:get_child_by_name('right_content/cont2/cont_dingji')

    -- 未达到最大星级
    self.starUpBtn = ngui.find_button(self.ui, 'right_content/cont2/cont_shengxing/btn_shengxing')
    self.starUpBtn:set_on_click(self.bindfunc["on_click_star_up_btn"],"MyButton.NoneAudio")
    -- self.starUpBtnSp = ngui.find_sprite(self.ui, 'right_content/cont2/cont_shengxing/sp')

    self.starUpOldNameLab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_equip_name1')
    local node = self.ui:get_child_by_name('right_content/cont2/cont_shengxing/top/new_small_card_item1')
    self.starUpOldSmallItemUi = UiSmallItem:new({parent = node, delay = -1, show_tip_point = false})
    self.starUpNewNameLab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_equip_name2')
    node = self.ui:get_child_by_name('right_content/cont2/cont_shengxing/top/new_small_card_item2')
    self.starUpNewSmallItemUi = UiSmallItem:new({parent = node, delay = -1, show_tip_point = false})

    self.propertyLabel = {}
    self.propertyLabel[1] = {}
    local lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_gongji')
    self.propertyLabel[1].oldNameLab = lab
    lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_gongji/lab_num1')
    self.propertyLabel[1].oldNumLab = lab
    lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_fangyu')
    self.propertyLabel[1].newNameLab = lab
    lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_fangyu/lab_num2')
    self.propertyLabel[1].newNumLab = lab

    -- self.propertyLabel[2] = {}
    -- lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_fangyu')
    -- self.propertyLabel[2].oldNameLab = lab
    -- lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_fangyu/lab_num1')
    -- self.propertyLabel[2].oldNumLab = lab
    -- -- lab = ngui.find_label(self.ui, 'right_content/cont2/cont_tongyong/lab_fangyu2')
    -- -- self.propertyLabel[2].newNameLab = lab
    -- lab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/top/lab_fangyu/lab_num2')
    -- self.propertyLabel[2].newNumLab = lab

    self.desTitleLab = ngui.find_label(self.ui, 'right_content/cont2/cont_tongyong/lab')
    self.desContentLab = ngui.find_label(self.ui, 'right_content/cont2/cont_tongyong/lab_skill')
    -- self.desTitlaBackgroundSprite = ngui.find_sprite(self.ui, "right_content/cont2/cont_tongyong/sp_line")

    self.starDownBtn = ngui.find_button(self.ui, 'right_content/cont2/cont_tongyong/btn_star')
    self.starDownBtn:set_on_click(self.bindfunc["on_click_star_down_btn"])
    self.starDownBtnSp = ngui.find_sprite(self.ui, 'right_content/cont2/cont_tongyong/btn_star/sprite_background')

    self.starUpMaterialSmallItemUi = {}
    for i = 1, 3 do
        node = self.ui:get_child_by_name('right_content/cont2/cont_shengxing/new_small_card_item' .. tostring(i))
        self.starUpMaterialSmallItemUi[i] = UiSmallItem:new({parent = node, delay = 0, is_enable_goods_tip = true, prop = {show_number = true, number_type = 2}})
    end

    self.starUpCostGoldLab = ngui.find_label(self.ui, 'right_content/cont2/cont_shengxing/sp_gold/lab')


    node = self.ui:get_child_by_name('right_content/cont2/cont_dingji/new_small_card_item')
    self.starMaxSmallItemUi = UiSmallItem:new({parent = node, delay = 400})
    self.starMaxNameLab = ngui.find_label(self.ui, 'right_content/cont2/cont_dingji/new_small_card_item/lab_equip_name')
    self.maxPropertyLabs = {}
    self.maxPropertyLabs[1] = {}
    self.maxPropertyLabs[1].nameLab = ngui.find_label(self.ui, "right_content/cont2/cont_dingji/lab_gongji")
    self.maxPropertyLabs[1].numLab =  ngui.find_label(self.ui, "right_content/cont2/cont_dingji/lab_gongji/lab_num1")
    self.maxPropertyLabs[2] = {}
    self.maxPropertyLabs[2].nameLab = ngui.find_label(self.ui, "right_content/cont2/cont_dingji/lab_fangyu")
    self.maxPropertyLabs[2].numLab =  ngui.find_label(self.ui, "right_content/cont2/cont_dingji/lab_fangyu/lab_num1")

    self.starUpNotFullAndFullLevelCommonNode = {}
    -- self.starUpNotFullAndFullLevelCommonNode[#self.starUpNotFullAndFullLevelCommonNode + 1] = self.ui:get_child_by_name("right_content/cont2/cont_tongyong/lab_gongji/sp_jian_tou")
    -- self.starUpNotFullAndFullLevelCommonNode[#self.starUpNotFullAndFullLevelCommonNode + 1] = self.ui:get_child_by_name("right_content/cont2/cont_tongyong/lab_gongji/lab_num2")
    -- self.starUpNotFullAndFullLevelCommonNode[#self.starUpNotFullAndFullLevelCommonNode + 1] = self.ui:get_child_by_name("right_content/cont2/cont_tongyong/lab_fangyu/sp_jian_tou")
    -- self.starUpNotFullAndFullLevelCommonNode[#self.starUpNotFullAndFullLevelCommonNode + 1] = self.ui:get_child_by_name("right_content/cont2/cont_tongyong/lab_fangyu/lab_num2")
end

function EquipPackageUI:UpdateUITips()
    if not AppConfig.get_enable_guide_tip() then
        return
    end
    local cardInfo = self:GetChooseEquipCardInfo()
    if not cardInfo then
        return
    end

    --升级页卡/升品按钮/升星页卡/升星按钮
    if self.tipsUI == nil then
        local contPath = "centre_other/animation/right_content/"
        self.tipsUI = {
            ["yeka_level_up"] = ngui.find_sprite(self.ui, contPath .. "yeka/yeka1/sp_point"),
            ["btn_rarity_up"] = ngui.find_sprite(self.ui, contPath .. "cont1/cont_putong/cont_shengpin/btn_shengpin/animation/sp_point"),
            ["yeka_star_up"] = ngui.find_sprite(self.ui, contPath .. "yeka/yeka2/sp_point"),
            ["btn_star_up"] = ngui.find_sprite(self.ui, contPath  .. "cont2/cont_shengxing/btn_shengxing/animation/sp_point"),
        }
    end
    --if self.chooseYekaName == 'yeka1' then
    local __flag1 = PublicFunc.ToBoolTip(cardInfo:CanLevelUp());
    local __flag2 = PublicFunc.ToBoolTip(cardInfo:CanRarityUp());
    self.tipsUI["yeka_level_up"]:set_active(__flag1 or __flag2)
    self.tipsUI["btn_rarity_up"]:set_active(__flag2)
    --else
    local __flag1 = PublicFunc.ToBoolTip(cardInfo:CanStarUp());
    self.tipsUI["yeka_star_up"]:set_active(__flag1)
    self.tipsUI["btn_star_up"]:set_active(__flag1)
    --end
end

function EquipPackageUI:on_yeka(value, name)
    if value then
        if self.isNotFirst == nil then
            self.isNotFirst = true;
        else
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
        end
        --动画不播放
        if self.objLevelAnimation then
            self.objLevelAnimation:set_active(false)
        end
        if name == "yeka1" then
            self.objLevelUpPane:set_active(true)
            self.objUpStarPane:set_active(false)
            FightValueChangeUI.EnableShowChange(true)
            self:UpdateRightLevelUpPane()
        else
            self.objLevelUpPane:set_active(false)
            self.objUpStarPane:set_active(true)
            FightValueChangeUI.EnableShowChange(false)
            self:UpdateRightStarUpPane()
        end
        self.chooseYekaName = name
    end
end

function EquipPackageUI:update_ui()
    if MultiResUiBaseClass.UpdateUi(self) then
        self:UpdateHeroEquipment()
        self:SetChooseYeka()
    end
end

function EquipPackageUI:SetChooseYeka()
    if self.roleData ~= nil then
        self.objRightPane:set_active(true)
        --其它界面转到升星
        if self.eType and self.eType == 2 and CardEquipment.PlayerReachStarUpLevel() then
            self.toggleYeka["yeka2"]:set_value(true)
            self.eType = nil;
        else
            self.toggleYeka["yeka1"]:set_value(true)
        end
        --隐藏升星页卡
        if CardEquipment.PlayerReachStarUpLevel() then
            self.toggleYeka["yeka2"]:set_active(true)
        else
            self.toggleYeka["yeka2"]:set_active(false)
        end
    else
        self.objRightPane:set_active(false)
    end
end

function EquipPackageUI:on_click_equip(t)
    local index = t.float_value
    local item = self.equipSmallItemList[index]
    if self.lastEquipItem then
        self.lastEquipItem:SetShine(false)
    end
    self.currEquipPos = index

    self.lastEquipItem = item
    item:SetShine(true)
    --app.log("equip number --- > " .. self.lastEquipItem:GetCardInfo().number)
    self:UpdateRightPane()
end

--[[点击选择英雄]]
function EquipPackageUI:on_choose_hero()
    -- if self.roleInfo and self.roleInfo:IsShow() then    
    --     if self.roleData then
    --         self.roleInfo:SetInfo(self.roleData)
    --     end
    -- else
    self:UpdateHeroEquipment()
    self:UpdateRightPane()
    --end    
end

--[[更新选中英雄]]
function EquipPackageUI:update_choose_hero(data)
    self.roleData = data
    --更新3d
    self:UpdateHero3d()
    if self.roleData ~= nil then
        if self.roleData.model_id then
            local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, self.roleData.model_id);
            if self.get_hero_audio ~= nil then
                AudioManager.StopUiAudio(self.get_hero_audio)
            end
            self.get_hero_audio = nil;
            if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
                local count = #model_list_cfg.egg_get_audio_id;
                local n = math.random(1,count)
                self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
            end
        end
        self.objHeroInfo:set_active(true)
        local nameStr, numStr = PublicFunc.FormatHeroNameAndNumber(self.roleData.name)
        self.lblHeroName:set_text(nameStr)
        self.lblHeroNameNum:set_text(numStr)

        self.lblFightValue:set_text(tostring(self.roleData:GetFightValue()))
        PublicFunc.SetAptitudeSprite(self.spAptitude, self.roleData.config.aptitude, true)
    else
        self.objHeroInfo:set_active(false)
    end
end


local __huiZhangSpriteName = {
    [ENUM.EEquipRarity.White] = "zb_daojuhuizhang1",

    [ENUM.EEquipRarity.Green] = "zb_daojuhuizhang3",
    [ENUM.EEquipRarity.Green1] = "zb_daojuhuizhang3",
    [ENUM.EEquipRarity.Green2] = "zb_daojuhuizhang3",

    [ENUM.EEquipRarity.Blue] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue1] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue2] = "zb_daojuhuizhang2",
    [ENUM.EEquipRarity.Blue3] = "zb_daojuhuizhang2",

    [ENUM.EEquipRarity.Purple] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple1] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple2] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple3] = "zb_daojuhuizhang4",
    [ENUM.EEquipRarity.Purple4] = "zb_daojuhuizhang4",

    [ENUM.EEquipRarity.Orange] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange1] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange2] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange3] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange4] = "zb_daojuhuizhang5",
    [ENUM.EEquipRarity.Orange5] = "zb_daojuhuizhang5",

    [ENUM.EEquipRarity.Red] = "zb_daojuhuizhang6",
    [ENUM.EEquipRarity.Red1] = "zb_daojuhuizhang6",
}
function EquipPackageUI:GetSpecEquipHuiZhang(rarity)
    return __huiZhangSpriteName[rarity]
end

--[[更新所有英雄装备]]
function EquipPackageUI:UpdateHeroEquipment()
    if self.roleData ~= nil then
        self.objEquipmentInfo:set_active(true)
        for k, v in pairs(self.equipSmallItemList) do
            local pos = self.equipPositionList[k]
            local dataid = self.roleData.equipment[pos]
            if dataid ~= '0' and dataid ~= 0 then
                local cardEquip = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, dataid);
                v:SetData(cardEquip)
                v:SetShine(k == self.currEquipPos)
                -------------是否加锁-----------------
                local itemSp = self.equipItemSpList[k]
                if itemSp ~= nil then
                    local type = nil
                    if self.chooseYekaName == "yeka2" then
                        type = "StarUp"
                    end
                    if cardEquip:IsEquipLock(type) then
                        itemSp.spLock:set_active(true)
                    else
                        itemSp.spLock:set_active(false)
                    end

                    itemSp.spTitle:set_sprite_name(self:GetSpecEquipHuiZhang(cardEquip.rarity))
                end
                --------------------------------------
                if k == self.currEquipPos then
                    self.lastEquipItem = v
                    --app.log("equip number ===== > " .. cardEquip.number)
                end
            else
                app.log("equip dataid = '0'")
            end
        end
    else
        self.lastEquipItem = nil
        self.objEquipmentInfo:set_active(false)
    end
end

function EquipPackageUI:on_click_equip_lock(name, x, y, go_obj, value)
    local position = tonumber(value)
    local id = nil
    if self.chooseYekaName == "yeka2" then
        if position == ENUM.EEquipPosition.Helmet then
            id = MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_helmet_unlock_player_level
        elseif position == ENUM.EEquipPosition.Accessories then
            id = MsgEnum.ediscrete_id.eDiscreteID_equip_star_up_accessories_unlock_player_level
        end
    else
        if position == ENUM.EEquipPosition.Helmet then
            id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_helmet_unlock_player_level
        elseif position == ENUM.EEquipPosition.Accessories then
            id = MsgEnum.ediscrete_id.eDiscreteID_equip_level_up_accessories_unlock_player_level
        end
    end
    local level = ConfigManager.Get(EConfigIndex.t_discrete, id).data
    FloatTip.Float(string.format(_UIText[21], level))
end

function EquipPackageUI:UpdateEquipmentByIndex(index, isUpTips)
    self:ForeachNormalEquip(function(cardInfo, item)
        if cardInfo.index == index then
            local cardData = self.dataSource:find_card(ENUM.EPackageType.Equipment, index)
            item:SetData(cardData)
            local objFx = item:GetExtFx()
            if objFx then
                objFx:set_active(false)
            end
            return false
        end
    end)
    if isUpTips then
        self:UpdateAllTips()
    end
end

--[[选中的英雄装备]]
function EquipPackageUI:UpdateCurrEquipment()
    if self.lastEquipItem ~= nil then
        local cardData = self.dataSource:find_card(ENUM.EPackageType.Equipment, self.lastEquipItem.cardInfo.index)
        self.lastEquipItem:SetData(cardData)
        local objFx = self.lastEquipItem:GetExtFx()
        if objFx then
            objFx:set_active(false)
        end

        --特殊装备辉章
        if cardData:IsSpecEquip() then
            for k, v in pairs(self.equipPositionList) do
                if v == cardData.position then
                    local itemSp = self.equipItemSpList[k]
                    if itemSp then
                        itemSp.spTitle:set_sprite_name(self:GetSpecEquipHuiZhang(cardData.rarity))
                    end
                    break
                end
            end
        end
    end
    self:UpdateAllTips()
end

function EquipPackageUI:UpdateAllTips()
    for k, v in pairs(self.equipSmallItemList) do
        v:SetEquipTips()
    end
    if self.heroListUi then
        self.heroListUi:UpdateHeroTips()
    end
end

function EquipPackageUI:GetChooseEquipCardInfo()
    if self.lastEquipItem and self.lastEquipItem:GetCardInfo() then
        return self.lastEquipItem:GetCardInfo()
    end
    return nil
end

--[[更新英雄3d]]
function EquipPackageUI:UpdateHero3d()
    local data =
    {
        roleData = self.roleData,
        role3d_ui_touch = self.spHuman,
        type = "left",
    }
    Show3d.SetAndShow(data)
end

--[[更新英雄装备]]
function EquipPackageUI:UpdateRightPane()
    if self.roleData ~= nil then
        self.objRightPane:set_active(true)
        self:on_yeka(true, self.chooseYekaName)
    else
        self.objRightPane:set_active(false)
    end
end

function EquipPackageUI:UpdateRightStarUpPane()
    if self.lastEquipItem == nil then return end

    self:InitStarUpUi()

    local cardInfo = self.lastEquipItem:GetCardInfo()

    local reachMaxStar = tostring(cardInfo.config.star_up_number) == '0'
    self:ShowStarUpNodes(reachMaxStar)

    if reachMaxStar == false then

        if ConfigManager.Get(EConfigIndex.t_equipment, cardInfo.config.star_up_number) == nil then
            return
        end

        local nxtStarCardInfo = cardInfo:CloneWithNewNumberLevelRairty(cardInfo.star_up_number, nil, nil)

        self.starUpOldNameLab:set_text(cardInfo.name)
        self.starUpNewNameLab:set_text(nxtStarCardInfo.name)

        self.starUpOldSmallItemUi:SetData(cardInfo)


        self.starUpNewSmallItemUi:SetData(nxtStarCardInfo)


        local labIndex = 1
        for k,v in pairs(self.equipShowProp) do

            if labIndex > 1 then
                break
            end

            local cur = cardInfo:GetPropertyVal(v.key)
            local nxt = nxtStarCardInfo:GetPropertyVal(v.key)

            if nxt - cur > 0 then
                local labs = self.propertyLabel[labIndex]

                labs.oldNameLab:set_text(string.format('%s:', v.str))
                labs.oldNumLab:set_text(string.format('%d', cur));
                labs.newNameLab:set_text(string.format('%s:', v.str))
                labs.newNumLab:set_text(string.format('%d', nxt));
                labIndex = labIndex + 1
                -- else
                --     app.log("value == 0 " .. tostring(v.key))
            end
        end

        -- for i=labIndex, 2 do
        --     local labs = self.propertyLabel[i]
        --     labs.oldNameLab:set_active(false)
        --     -- labs.newNameLab:set_active(false)
        -- end

        local starUpMaterial = cardInfo.config.starup_material
        local materialCount = 0
        if type(starUpMaterial) == 'table' then
            materialCount = #starUpMaterial
            self.materialNotEnough = false
        else
            self.materialNotEnough = true
            app.log('star up material config error id:' .. tostring(cardInfo.config.id))
        end
        for i=1,3 do
            if i <= materialCount then
                self.starUpMaterialSmallItemUi[i]:Show()
                local needId = starUpMaterial[i].number
                local needCount = starUpMaterial[i].count
                self.starUpMaterialSmallItemUi[i]:SetDataNumber(needId, nil)

                self.starUpMaterialSmallItemUi[i]:SetNeedCount(needCount)

                local hasCount = g_dataCenter.package:GetCountByNumber(needId)
                --app.log('id = ' .. tostring(needId) .. ' ' .. tostring(hasCount))
                if hasCount < needCount then
                    self.materialNotEnough = true
                end
            else
                self.starUpMaterialSmallItemUi[i]:Hide()
            end

        end

        local costGold = cardInfo.config.cost_gold
        local hasGold = g_dataCenter.player.gold

        self.starUpCostGoldLab:set_text(PublicFunc.NumberToStringByCfg(costGold))
        self.goldNotEnough = hasGold < costGold
        if self.goldNotEnough then
            self.starUpCostGoldLab:set_color(1, 0, 0, 1)
        else
            self.starUpCostGoldLab:set_color(1, 1, 1, 1)
        end
        --        if self.materialNotEnough or self.goldNotEnough then
        --            self.starUpBtnSp:set_color(0, 0, 0, 1)
        --        else
        --            self.starUpBtnSp:set_color(1, 1, 1, 1)
        --        end

    else

        self.starMaxSmallItemUi:SetData(cardInfo)
        self.starMaxNameLab:set_text(cardInfo.name)
        --self.starMaxLevelLab:set_text(string.format('[FFB400FF]%s[-]:\t%d', _UIText[9], cardInfo.level))
        --self.starMaxLevelLab:set_text(tostring(cardInfo.level))

        for i=1,2 do
            self.maxPropertyLabs[i].nameLab:set_active(false)
        end

        local labIndex = 1
        local firstlabs
        for k,v in pairs(self.equipShowProp) do
            local cur = cardInfo:GetPropertyVal(v.key)

            if cur > 0 then
                local labs = self.maxPropertyLabs[labIndex]
                labs.nameLab:set_active(true)

                labs.nameLab:set_text(v.str)
                labs.numLab:set_text('+' .. tostring(cur))

                if labIndex == 1 then
                    firstlabs = labs
                end

                labIndex = labIndex + 1
                -- else
                --     app.log("maxPropertyLabs == 0  " .. tostring(v.key))
            end
        end

        if labIndex == 2 then
            firstlabs.nameLab:set_position(-52, 51, 0)
        else
            firstlabs.nameLab:set_position(-178, 51, 0)
        end
    end

    local starUpTitle = _UIText[1]
    if reachMaxStar then
        starUpTitle = _UIText[26]
    end
    self.desTitleLab:set_text(starUpTitle)
    self.desContentLab:set_text(_UIText[2])
    -- self.desTitlaBackgroundSprite:set_sprite_name("zb_zhuangshi2")

    --连协配置信息
    self:UpdateContactInfo()

    if cardInfo.star < 1 then
        --self.starDownBtn:set_enable(false)
        self.starDownBtnSp:set_color(0, 0, 0, 1)
    else
        --self.starDownBtn:set_enable(true)
        self.starDownBtnSp:set_color(1, 1, 1, 1)
    end

    self:UpdateUITips()
end

function EquipPackageUI:ShowStarUpNodes(reachMaxStar)
    self.starUpFullNode:set_active(reachMaxStar)

    self.starUpNotFullNode:set_active(not reachMaxStar)


    for k,node in ipairs(self.starUpNotFullAndFullLevelCommonNode) do
        node:set_active(not reachMaxStar)
    end
end

function EquipPackageUI:on_click_star_up_btn()

    if self.materialNotEnough then
        FloatTip.Float(_UIText[6])
        return
    end
    if self.goldNotEnough then
        FloatTip.Float(_UIText[7])
        return
    end

    if self.lastEquipItem == nil then return end
    local cardInfo = self.lastEquipItem:GetCardInfo()

    self.oldFightValue = self.roleData:GetFightValue()
    if cardInfo:IsSpecEquip() then
        UiEquipExpertResult.SaveOldLevel(ENUM.EquipExpertType.SpecStar, self.roleData)
    else
        UiEquipExpertResult.SaveOldLevel(ENUM.EquipExpertType.Star, self.roleData)
    end
    FightValueChangeUI.EnableShowChange(true)
    msg_cards.cg_equip_star_up(cardInfo.index)
end

function EquipPackageUI:on_click_star_down_btn()
    if self.lastEquipItem == nil then return end
    local cardInfo = self.lastEquipItem:GetCardInfo()
    if cardInfo.star < 1 then
        FloatTip.Float(_UIText[8])
        return
    end

    --self:OnConfirmStarDown()
    local cost = self:GetStarDownCost()

    -- HintUI.SetAndShowHybrid(EHintUiType.two,_UIText[11], string.format(_UIText[13], cost),
    --     nil,{str = _UIText[14],func = self.bindfunc["OnConfirmStarDown"]}, {str = _UIText[15]});
    uiManager:PushUi(EUI.EquipStarDownConfirmUI, {cost = cost, callback = self.bindfunc["OnConfirmStarDown"] })

end

function EquipPackageUI:GetStarDownCost()

    local cardInfo = self.lastEquipItem:GetCardInfo()
    local config = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_eqip_star_down_cost)
    local cost = 0
    if config then
        local costs = config.data
        if cardInfo.star > #costs then
            cost = costs[#costs]
        else
            cost = costs[cardInfo.star] or 0
        end
    else
        app.log('star down cost config error!')
    end

    return cost
end

function EquipPackageUI:OnConfirmStarDown()
    if self.lastEquipItem == nil then return end

    if g_dataCenter.player.crystal < self:GetStarDownCost() then

        FloatTip.Float(_UIText[12])

    else
        local cardInfo = self.lastEquipItem:GetCardInfo()

        FightValueChangeUI.EnableShowChange(false)
        msg_cards.cg_star_down(cardInfo.index)
    end
end

function EquipPackageUI:on_response_star_up()
    if self.lastEquipItem == nil then return end
    local cardInfo = self.lastEquipItem:GetCardInfo()

    UiCommonPropertyChangResult.Start(cardInfo, UiCommonPropertyChangEType.EquipStarUp, self.roleData, self.oldFightValue)
    UiCommonPropertyChangResult.SetFinishCallback(EquipPackageUI.CheckEquipExpert, self)
    self:UpdateCurrEquipment()
    self:UpdateRightStarUpPane()
end

function EquipPackageUI:on_response_star_down(result, awards)
    -- CommonAward.Start(awards, CommonAwardEType.starDown)
    -- CommonAward.SetFinishCallback(EquipPackageUI.CheckDeactiveContactCallBack, self)

    --FloatTip.Float(_UIText[24])
    
    uiManager:PushUi(EUI.EquipStarDownResultUi, {awards = awards})

    self:UpdateCurrEquipment()
    self:UpdateRightStarUpPane()
end

-------------------------------------装备连协-------------------------------------

function EquipPackageUI:UpdateContactInfo()
    local descInfo = self:GetContactInfo()
    if descInfo ~= "" then
        -- self.desTitlaBackgroundSprite:set_sprite_name("zb_zhuangshi3")
        self.desContentLab:set_text(descInfo)

        local title = _UIText[20]
        if self.lastEquipItem:GetCardInfo():IsActiveEquipContact() then
            title = _UIText[25]
        end
        self.desTitleLab:set_text(title)
    end
end

function EquipPackageUI:GetContactInfo()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    local info = ""
    if cardInfo == nil or self.roleData == nil then
        return info
    end
    local contactConfig = ConfigManager.Get(EConfigIndex.t_role_contact, self.roleData.default_rarity)
    if contactConfig == nil then
        return info
    end
    for _, v in pairs(contactConfig) do
        if v.contact_type == ENUM.ContactType.EquipProp or v.contact_type == ENUM.ContactType.EquipSkill then
            local equipConfig = ConfigManager.Get(EConfigIndex.t_equipment, v.equip_number)
            --获取当前位置装备
            if cardInfo.position == equipConfig.position then
                local _name = equipConfig.star .. _UIText[23]
                if cardInfo.star >= equipConfig.star then
                    info = "[ffa127]" .. v.name .. "[-]: " .. string.format(v.des, "[ffa127]" .. _name .. "[-]")
                else
                    info = "[8b8b8b]" .. v.name .. "[-]: " .. string.format(v.des, "[8b8b8b]" .. _name .. "[-]")
                end
            end
        end
    end
    return info
end

--[[升星激活连协]]
function EquipPackageUI:CheckActiveContactCallBack()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    if cardInfo:IsActiveEquipContact() then
        app.log("==============> IsActiveEquipContact true")
    end
end

--[[降星不激活连协]]
function EquipPackageUI:CheckDeactiveContactCallBack()
    local cardInfo = self.lastEquipItem:GetCardInfo()
    if cardInfo:IsDeactiveEquipContact() then
        app.log("==============> IsDeactiveEquipContact true")
    end
end

--[[装备达人]]
function EquipPackageUI:CheckEquipExpert()
    --装备连协
    local cardInfo = self.lastEquipItem:GetCardInfo()
    local configData = EquipContactActiveUI.GetActiveEquipContactInfo(self.roleData, cardInfo.position)
    if #configData > 0 then
        EquipContactActiveUI.Start(configData, self.roleData)
    else
        UiEquipExpertResult.Start(self.roleData)
    end
end

-------------------------- 新手引导用 ----------------------------
function EquipPackageUI:GetHeroListUi()
    return self.heroListUi
end

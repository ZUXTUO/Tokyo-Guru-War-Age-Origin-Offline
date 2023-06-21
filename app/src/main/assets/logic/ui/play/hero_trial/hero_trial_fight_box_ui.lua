HeroTrialFightBoxUI = Class("HeroTrialFightBoxUI", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	-- ui/new_fight
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_838_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}


local _UIText = {
    [1] = "剩余购买次数:%s/%s",
    [2] = "钻石不足",
}

function HeroTrialFightBoxUI.GetResList()
	return {resPaths[resType.Front], resPaths[resType.Back]}
end

function HeroTrialFightBoxUI:Init(data)
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function HeroTrialFightBoxUI:RestartData(data)
    self.awards = data
    self.buyCount = 0
    self.needCost = 0
    local dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_heroTrial]
    self.buyConfig = ConfigManager.Get(EConfigIndex.t_hero_trial_fight_box_awards, dataCenter:GetFightDay())
    self.maxCount = self.buyConfig.count
    self.isBuyAgain = false
    local flagHelper = g_dataCenter.player:GetFlagHelper()
    local flagNumber = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_heroTrial) or 0
    if flagNumber == 0 then
        self.isBuyAgain = true
    end
end

function HeroTrialFightBoxUI:SetEndCallback(callback)
    self.callback = callback
end

function HeroTrialFightBoxUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_buy_again"] = Utility.bind_callback(self, self.on_btn_buy_again);
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm);
    self.bindfunc["gc_hero_trial_get_fight_box_awards"] = Utility.bind_callback(self, self.gc_hero_trial_get_fight_box_awards);
end

function HeroTrialFightBoxUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_hero_trial_get_fight_box_awards, self.bindfunc["gc_hero_trial_get_fight_box_awards"])
end

function HeroTrialFightBoxUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_hero_trial_get_fight_box_awards, self.bindfunc["gc_hero_trial_get_fight_box_awards"])
end

function HeroTrialFightBoxUI:InitedAllUI()
    self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]

    self.labBuyCount = ngui.find_label(self.frontui, "txt")
    self.nodeCrystal = self.frontui:get_child_by_name("sp_di")
    self.labCrystal = ngui.find_label(self.nodeCrystal, "lab")
    self.iconCrystal = ngui.find_texture(self.nodeCrystal, "Texture_yaoshi")
    self.btnBuyAgain = ngui.find_button(self.frontui, "btn_zai_chou")
    self.btnConfirm = ngui.find_button(self.frontui, "btn_sure")
    self.btnBuyAgain:set_on_click(self.bindfunc["on_btn_buy_again"])
    self.btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])

    self.spTreasureBox = ngui.find_sprite(self.frontui, "sp_baoxiang")
    self.grid = ngui.find_grid(self.frontui, "grid")
    self.gridList = {}
    for i=1, 6 do
        local objItem = self.frontui:get_child_by_name("kug"..i)
        local objParent = objItem:get_child_by_name("new_small_card_item")
        self.gridList[i] = {}
        self.gridList[i].objItem = objItem
        self.gridList[i].labName = ngui.find_label(objItem, "lab_word")
        self.gridList[i].uiItem = UiSmallItem:new({parent=objParent, is_enable_goods_tip = true})
        self.gridList[i].objItem:set_active(false)
    end
    
    self.iconCrystal:set_texture(ConfigManager.Get(EConfigIndex.t_item, IdConfig.Crystal).small_icon)

    local labCloseTip = ngui.find_label(self.backui, "txt")
    local spTitle = ngui.find_sprite(self.backui, "sp_art_font")
    local nodeParent = self.backui:get_child_by_name("add_content")

    labCloseTip:set_active(false)
    spTitle:set_sprite_name("js_shengli")
    self.frontui:set_parent( nodeParent )

    self:UpdateUi()
end

function HeroTrialFightBoxUI:DestroyUi()
    if self.iconCrystal then
        self.iconCrystal:Destroy()
        self.iconCrystal = nil
    end
    if self.gridList then
        for i, v in pairs(self.gridList) do
            v.uiItem:DestroyUi()
        end
        self.gridList = nil
    end
    self.buyCount = 0
    self.awards = nil
    self.buyConfig = nil
    self.callback = nil

    self.backui = nil
    self.frontui = nil
    MultiResUiBaseClass.DestroyUi(self);
end

function HeroTrialFightBoxUI:Show()
    if not self.backui then return end
    self.backui:set_local_position(0, 0, 0)
end

function HeroTrialFightBoxUI:Hide()
	if not self.backui then return end
	self.backui:set_local_position(100000, 0, 0)
end

function HeroTrialFightBoxUI:UpdateUi()
    if not MultiResUiBaseClass.UpdateUi(self) then return end

    if self.awards then
        for i, v in pairs(self.gridList) do
            local data = self.awards[i]
            if data then
                local cardInfo = PublicFunc.CreateCardInfo(data.id, data.count)
                v.objItem:set_active(true)
                v.uiItem:SetData(cardInfo)
                v.uiItem:SetCount(data.count)
                --添加稀有物品特效
                v.uiItem:SetAsReward(cardInfo.rarity >= ENUM.EItemRarity.Orange)
                v.labName:set_text(cardInfo.name)
            else
                v.objItem:set_active(false)
            end
        end

        self.spTreasureBox:set_sprite_name("klz_kaiqibaoxiang")
        self.grid:set_active(true)
        self.grid:reposition_now(true)
    else
        self.spTreasureBox:set_sprite_name("klz_guanbibaoxiang")
        self.grid:set_active(false)
    end

    if self.isBuyAgain then
        if self.buyCount == self.maxCount then
            self.labBuyCount:set_active(false)
            self.nodeCrystal:set_active(false)
            self.btnBuyAgain:set_active(false)

            local x, y, z = self.btnConfirm:get_position()
            Tween.addTween(self.btnConfirm,0.1,{position = {0,y,z}},nil,0,nil,nil,nil)
        else
            self.labBuyCount:set_text(string.format(_UIText[1], self.maxCount-self.buyCount, self.maxCount))
            self.needCost = self.buyConfig.cost[self.buyCount + 1] or 0
            self.labCrystal:set_text(tostring(self.needCost))
            if self.needCost > g_dataCenter.player.crystal then
                PublicFunc.SetUILabelRed(self.labCrystal)
            else
                PublicFunc.SetUILabelWhite(self.labCrystal)
            end
        end
    else
        self.labBuyCount:set_active(false)
        self.nodeCrystal:set_active(false)
        self.btnBuyAgain:set_active(false)
        local x, y, z = self.btnConfirm:get_position()
        self.btnConfirm:set_position(0,y,z)
    end
end

function HeroTrialFightBoxUI:on_btn_buy_again(t)
    if self.needCost > g_dataCenter.player.crystal then
        FloatTip.Float(_UIText[2])
        return
    end
    self.awards = nil
    self:UpdateUi()
    msg_activity.cg_hero_trial_get_fight_box_awards()
end

function HeroTrialFightBoxUI:on_btn_confirm(t)
    local callback = self.callback

    uiManager:PopUi()

    if callback then
        callback()
    end
end

function HeroTrialFightBoxUI:gc_hero_trial_get_fight_box_awards(awards)
    self.awards = awards
    self.buyCount = self.buyCount + 1

    local flagHelper = g_dataCenter.player:GetFlagHelper()
    local flagNumber = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_heroTrial) or 0
    if flagNumber == 0 then
        self.isBuyAgain = true
    end

    self:UpdateUi()
end

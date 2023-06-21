
EquipRecommandAndEquipUI = Class("EquipRecommandAndEquipUI", UiBaseClass);


local resPath = 'assetbundles/prefabs/ui/new_fight/ui_3401_recommend.assetbundle'

function EquipRecommandAndEquipUI:Init(data)
    self.pathRes = resPath

    UiBaseClass.Init(self, data);
end

function EquipRecommandAndEquipUI:DestroyUI()
    UiBaseClass.DestroyUi(self)

    if self.equipSmallItem then
        self.equipSmallItem:DestroyUi()
        self.equipSmallItem = nil
    end
    if self.heroSmallCard then    
        self.heroSmallCard:DestroyUi()
        self.heroSmallCard = nil
    end
end

function EquipRecommandAndEquipUI:RegistFunc() 
    UiBaseClass.RegistFunc(self)

    self.bindfunc["OnImmediateEquip"] = Utility.bind_callback(self, self.OnImmediateEquip);
    self.bindfunc["OnChangeQuipResponse"] = Utility.bind_callback(self, self.OnChangeQuipResponse);
    self.bindfunc["OnPlayDeleteEquipCard"] = Utility.bind_callback(self, self.OnPlayDeleteEquipCard);
    self.bindfunc["OnClickClose"] = Utility.bind_callback(self, self.OnClickClose);
end

function EquipRecommandAndEquipUI:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(msg_cards.gc_change_equip_on_role_ret,self.bindfunc["OnChangeQuipResponse"] )
    PublicFunc.msg_regist(msg_cards.gc_delete_equip_cards,self.bindfunc["OnPlayDeleteEquipCard"] )
end

function EquipRecommandAndEquipUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

     PublicFunc.msg_unregist(msg_cards.gc_change_equip_on_role_ret,self.bindfunc["OnChangeQuipResponse"] )
     PublicFunc.msg_unregist(msg_cards.gc_delete_equip_cards,self.bindfunc["OnPlayDeleteEquipCard"] )
end

function EquipRecommandAndEquipUI:OnPlayDeleteEquipCard(uuid)
    if self.action and self.action:GetEquipDataid() == uuid then
        self.isFinished = true
    end
end

function EquipRecommandAndEquipUI:OnClickClose()
    self.isFinished = true;
end

function EquipRecommandAndEquipUI:OnImmediateEquip()

    if self.isFinished or self.isSendedEquipRequest then
        return
    end


    local card = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, self.action:GetEquipDataid())

    if card == nil then
        self.isFinished = true
        return
    end

    msg_cards.cg_change_equip_on_role(Socket.socketServer,self.action:GetHeroDataid(), self.action:GetEquipDataid(), self.action:GetEquipPos())
    self.isSendedEquipRequest = true
end

function EquipRecommandAndEquipUI:OnChangeQuipResponse(ret, herodataid, equipDataid, pos)
    if self.action:GetHeroDataid() == herodataid and self.action:GetEquipDataid() == equipDataid and pos == self.action:GetEquipPos() then
        self.isFinished = true

        --local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, herodataid)

        --FightValueChangeUI.ShowChange(card:GetFightValue(), self.heroBeginFightValue)
    end
end

function EquipRecommandAndEquipUI:IsEnd()
    return self.isFinished
end

function EquipRecommandAndEquipUI:SetRecommendAction(action)
    self.action = action
    self:SetShowContent()
end

function EquipRecommandAndEquipUI:SetShowContent()
    if self.action == nil or self.ui == nil or self.hasShow == true then
        return
    end
    local sp = ngui.find_sprite(self.ui, 'cont2/new_small_card_item')
    local card = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, self.action:GetEquipDataid())

    if card == nil then
        self.isFinished = true
        return
    end

    self.equipSmallItem = UiSmallItem:new({obj=sp:get_game_object(), cardInfo = card});

    sp = ngui.find_sprite(self.ui, 'cont2/big_card_item_80')
    card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, self.action:GetHeroDataid())
    self.heroBeginFightValue = card:GetFightValue()
    self.heroSmallCard = SmallCardUi:new({obj=sp:get_game_object(), info=card});
    local btn = ngui.find_button(self.ui, 'cont2/btn_anniu')
    btn:set_on_click(self.bindfunc["OnImmediateEquip"])

    local label = ngui.find_label(self.ui, 'cont2/lab_title')

    local changeValue = card:GetChangeEquipFightValueChange(self.action:GetEquipDataid(), self.action:GetEquipPos())
    local str = '+'
    if changeValue < 0 then
        str = '-'
        changeValue = -changeValue
    end
    label:set_text(string.format(gs_misc['str_48'], str, changeValue))

    self.countDownLabel = ngui.find_label(self.ui, 'cont2/lab')
    self.countDownTime = ConfigManager.Get(EConfigIndex.t_discrete,83000062).data;
    self.countStartTime = app.get_time()

    local btn = ngui.find_button(self.ui, 'btn_fork')
    if btn then
        btn:set_on_click(self.bindfunc["OnClickClose"])
    end

    self.hasShow = true
end

function EquipRecommandAndEquipUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

--    local sp = ngui.find_sprite(self.ui, 'cont3')
--    sp:set_active(false)
--    sp = ngui.find_sprite(self.ui, 'cont4')
--    sp:set_active(false)
    local sp = ngui.find_sprite(self.ui, 'cont1')
    sp:set_active(false)

    self:SetShowContent()
end

function EquipRecommandAndEquipUI:Update(dt)
    if not self.countDownLabel or self.countDownTime <= 0 then
        return
    end

    local passTime = app.get_time() - self.countStartTime
    if passTime >= self.countDownTime then
        self:OnImmediateEquip()
    end

    local showTime = self.countDownTime - passTime + 1
    if self.currentShowCountDownTime ~= showTime then
        self.currentShowCountDownTime = showTime
        self.countDownLabel:set_text(string.format(gs_misc['str_47'], self.currentShowCountDownTime))
    end
end
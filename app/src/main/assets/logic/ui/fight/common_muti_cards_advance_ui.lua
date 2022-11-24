

-- CommonMutiCardsAdvanceResultUI = Class("CommonMutiCardsAdvanceResultUI", MultiResUiBaseClass)



-- -- usage: uiManager:PushUi(EUI.CommonMutiCardsAdvanceResultUI, param)
-- -- param = {card, card, card ...}




-- -------------------------------------------------

-- local resType = 
-- {
--     Front = 1,
--     Back = 2,
-- }

-- local resPaths = 
-- {
--     [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_820_fight.assetbundle',
--     [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle'
-- }

-- function CommonMutiCardsAdvanceResultUI:Init(data)
--     self.pathRes = resPaths
-- 	MultiResUiBaseClass.Init(self, data);
-- end

-- function CommonMutiCardsAdvanceResultUI:DestroyUi()
--     MultiResUiBaseClass.DestroyUi(self)

--     if self.is_destroyed then return end

-- 	if self.smallCardItems then
-- 		for k,v in pairs(self.smallCardItems) do
-- 			v:DestroyUi()
-- 		end
--         self.smallCardItems = nil
-- 	end
-- end

-- function CommonMutiCardsAdvanceResultUI:RegistFunc()
--     MultiResUiBaseClass.RegistFunc(self);
--     self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
--     self.bindfunc["OnInitItem"] = Utility.bind_callback(self,self.OnInitItem);
-- end

-- function CommonMutiCardsAdvanceResultUI:InitedAllUI()
--     local backui = self.uis[resPaths[resType.Back]]
--     local frontui = self.uis[resPaths[resType.Front]]
--     local frontParentNode = backui:get_child_by_name("add_content")
--     local wrapContent = ngui.find_wrap_content(frontui, 'wrap_content')
--     local backgroundMarkBtn = ngui.find_button(backui, "mark")
--     local oldFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_fight')
--     local newFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_num')

--     self.smallCardItems = {}

--     frontui:set_parent(frontParentNode)
--     backgroundMarkBtn:set_on_click(self.bindfunc['OnClose'], "MyButton.NoneAudio")
--     wrapContent:set_on_initialize_item(self.bindfunc["OnInitItem"])
--     local initData = self:GetInitData()
--     wrapContent:set_min_index(-#initData + 1);
--     wrapContent:set_max_index(0);
--     wrapContent:reset();
    
--     local dc = g_dataCenter.player
--     oldFightValueLabel:set_text(tostring(dc:GetOldFightValue()))
--     newFightValueLabel:set_text(tostring(dc:GetFightValue()))
-- end

-- function CommonMutiCardsAdvanceResultUI:OnClose()
--     uiManager:PopUi(EUI.CommonMutiCardsAdvanceResultUI)
-- end

-- function CommonMutiCardsAdvanceResultUI:OnInitItem(obj, b, real_id)

--     local oldAdvItemParent = obj:get_child_by_name("content1/big_card_item_80")
--     local newAdvItemParent = obj:get_child_by_name("content2/big_card_item_80")
--     local oldAdvItemNameLabel = ngui.find_label(obj, "content1/lab_name")
--     local newAdvItemNameLabel = ngui.find_label(obj, "content2/lab_name")


--     local index = math.abs(real_id) + 1;

--     local initData = self:GetInitData()
--     local card = initData[index]
--     if not card then
--         return
--     end

--     local oldCard = card:CloneWithNewNumberLevelRairty(nil, nil, card.oldRarity)

--     self.smallCardItems[#self.smallCardItems + 1] = UiSmallItem:new({parent = oldAdvItemParent, cardInfo = oldCard})
--     self.smallCardItems[#self.smallCardItems + 1] = UiSmallItem:new({parent = newAdvItemParent, cardInfo = card})
--     oldAdvItemNameLabel:set_text(oldCard.name)
--     newAdvItemNameLabel:set_text(card.name)
-- end
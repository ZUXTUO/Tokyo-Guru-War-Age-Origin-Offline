EquipStarDownResultUi = Class("EquipStarDownResultUi", UiBaseClass)

function EquipStarDownResultUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/new_fight/ui_835_fight.assetbundle"
	UiBaseClass.Init(self, data);
end

function EquipStarDownResultUi:RestartData(data)
    CommonClearing.canClose = false
end

function EquipStarDownResultUi:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
end

function EquipStarDownResultUi:OnClose()
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    uiManager:PopUi()
end

function EquipStarDownResultUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)	

    self.grid = ngui.find_grid(self.ui, "grid")
    self.itemParent = self.grid:get_game_object()
    self.closeBtn = ngui.find_button(self.ui, "sp_mark")

    self.closeBtn:set_on_click(self.bindfunc["OnClose"])
    self.uiSmallItems = {}

    local initData = self:GetInitData()
    local awards = initData.awards

    PublicFunc.ConstructCardAndSort(awards)


    for k,item in ipairs(awards) do
        local itemui
        if PropsEnum.IsRole(item.id) then
            itemui = SmallCardUi:new({parent = self.itemParent, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }})		
        else
            itemui = UiSmallItem:new({parent = self.itemParent, is_enable_goods_tip = true})
        end

        if item.cardinfo then
            itemui:SetData(item.cardinfo)
            if itemui.SetCount then
                itemui:SetCount(item.count)
            end

            item.cardinfo = nil
            item.type = nil
        else
            itemui:SetDataNumber(item.id, item.count)
        end

        table.insert(self.uiSmallItems, itemui)
    end

    self.grid:reposition_now()
end
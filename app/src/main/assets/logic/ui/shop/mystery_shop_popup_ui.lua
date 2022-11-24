
MysteryShopPopupUI = Class('MysteryShopPopupUI', UiBaseClass)

function MysteryShopPopupUI.ShowPopup()
    if MysteryShopPopupUI.instance == nil then
        MysteryShopPopupUI.instance = MysteryShopPopupUI:new()
    end
end

function MysteryShopPopupUI.Destroy()
	if MysteryShopPopupUI.instance then
		MysteryShopPopupUI.instance:DestroyUi()
		MysteryShopPopupUI.instance = nil
	end
end

------------------------------------------------------------------------------

--初始化
function MysteryShopPopupUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/ui_4202_shop.assetbundle"
	UiBaseClass.Init(self, data);
end

--初始化数据
function MysteryShopPopupUI:InitData(data)
	UiBaseClass.InitData(self, data)
end

--注册方法
function MysteryShopPopupUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)	
    self.bindfunc["go_mystery_shop"] = Utility.bind_callback(self, self.go_mystery_shop)	
end

--初始化UI
function MysteryShopPopupUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("mystery_shop_popup_ui") 
    local spMark = ngui.find_button(self.ui, "sp_mark")
    spMark:set_on_click(self.bindfunc["on_close"])

    local btnConfirm = ngui.find_button(self.ui, "centre_other/btn_txt")
    btnConfirm:set_on_click(self.bindfunc["go_mystery_shop"])
    self:Show()
end

--[[刷新UI]]
function MysteryShopPopupUI:UpdateUi(data)
    
end

function MysteryShopPopupUI:go_mystery_shop()
    self:on_close()
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.MYSTERY)
end

function MysteryShopPopupUI:on_close()
	MysteryShopPopupUI.Destroy()
end
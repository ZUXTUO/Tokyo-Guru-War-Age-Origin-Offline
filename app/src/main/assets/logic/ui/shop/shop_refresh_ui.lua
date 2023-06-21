------ 2017-2-17 界面废弃 ------

ShopRefreshUI = Class('ShopRefreshUI', UiBaseClass)

local _UIText = {
    [1] = "刷新货物",
    [2] = "钻石不足!",
}

--初始化
function ShopRefreshUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_window_shuaxin.assetbundle"
	UiBaseClass.Init(self, data);
end

--初始化数据
function ShopRefreshUI:InitData(data)
    self.data = data.popupData
	UiBaseClass.InitData(self, data)
end

function ShopRefreshUI:DestroyUi()
    if self.textCrystal then
        self.textCrystal:Destroy()
        self.textCrystal = nil
    end
    UiBaseClass.DestroyUi(self);
end

--注册方法
function ShopRefreshUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_refresh_shop"] = Utility.bind_callback(self, self.on_refresh_shop)
end

--初始化UI
function ShopRefreshUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("shop_refresh_ui") 

    local path = "center_other/animation/"

    self.lblTitle = ngui.find_label(self.ui, path .. "sp_di/lab_title")
    local btnClose = ngui.find_button(self.ui, path .. "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local content2Path = path .. "content2/"     

    local btnCancel = ngui.find_button(self.ui, content2Path .. "btn_right")
    btnCancel:set_on_click(self.bindfunc["on_close"])
    local btnRefresh = ngui.find_button(self.ui, content2Path .. "btn_left")
    btnRefresh:set_on_click(self.bindfunc["on_refresh_shop"])

    self.lblCrystal = ngui.find_label(self.ui, content2Path .. "lab")
    self.textCrystal = ngui.find_texture(self.ui, content2Path .. "sp")
    local info = ConfigManager.Get(EConfigIndex.t_item, IdConfig.Crystal)
    if info and info.small_icon then
        self.textCrystal:set_texture(info.small_icon)
    end
    
    self:SetInfo(self.data)
end

--[[显示弹窗及购买界面]]
function ShopRefreshUI:SetInfo(data)
    self.shopId = data.shopId
    self.upCrystal = data.crystal
    self.lblCrystal:set_text(tostring(self.upCrystal))
    self.lblTitle:set_text(_UIText[1])
end

function ShopRefreshUI:on_close()
	self:Hide()
end

--[[使用钻石刷新]]
function ShopRefreshUI:on_refresh_shop()
    --检查钻石
    if g_dataCenter.player.crystal < self.upCrystal then
        FloatTip.Float(_UIText[2])
        return
    end
    self:Hide()
	GLoading.Show(GLoading.EType.msg) 
    msg_shop.cg_refresh_shop(self.shopId)
end
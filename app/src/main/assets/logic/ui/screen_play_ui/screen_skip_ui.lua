--region screen_skip_ui.lua
--Author : zzc
--Date   : 2016/2/2

--endregion

ScreenSkipUI = Class('ScreenSkipUI', UiBaseClass)

-------------------------------------类方法-------------------------------------
--初始化
function ScreenSkipUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/drama/ui_702_drama.assetbundle"
	UiBaseClass.Init(self, data);
end

--注册方法
function ScreenSkipUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_skip_btn"] = Utility.bind_callback(self, self.on_skip_btn);
end 

--撤销注册方法
function ScreenSkipUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--初始化UI
function ScreenSkipUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("screen_skip_ui");

	local btnSkip = ngui.find_button(self.ui, "screen_skip_ui/btn_fork")
	btnSkip:set_on_click(self.bindfunc["on_skip_btn"])
end

-------------------------------------本地回调-------------------------------------
--跳过按钮
function ScreenSkipUI:on_skip_btn(t)
	ScreenPlay.Skip()
end

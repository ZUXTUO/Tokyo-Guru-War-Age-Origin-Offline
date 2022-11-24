GuidePlayGuideUI = Class("GuidePlayGuideUI", UiBaseClass);

local uiText = 
{
	[1] = "点击屏幕任意位置关闭"
}

local instance = nil;

function GuidePlayGuideUI.Start(data)
	if instance == nil then
		instance = GuidePlayGuideUI:new(data);
	else
		instance:RestartData(data)
		instance:UpdateUi()
	end
end

function GuidePlayGuideUI.Destroy()
	if instance then
		instance:DestroyUi();
		instance = nil;

		NoticeManager.Notice(ENUM.NoticeType.GuidePlayGuideUiBack)
	end
end

function GuidePlayGuideUI:RestartData(data)
	if data then
		self.texture_path = data[1] or ""
		self.click_delay = data[2] or 1
		self.click_enable = false

		--预加载texture资源
		UiBaseClass.PreLoadTexture(self.texture_path, Root.empty_func)
	end
end

function GuidePlayGuideUI:DestroyUi()
	if self.texture then
		self.texture:Destroy()
		self.texture = nil
	end
	TimerManager.Remove(self.ClickDelayCb)
	UiBaseClass.DestroyUi(self)
end

function GuidePlayGuideUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/playing_introduce/ui_5001_bg.assetbundle";
    UiBaseClass.Init(self, data);
end

function GuidePlayGuideUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
end

function GuidePlayGuideUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("guide_play_guide_ui")

    self.texture = ngui.find_texture(self.ui, "centre_other/texture")
	self.labCloseTips = ngui.find_label(self.ui, "txt")
	self.labCloseTips:set_text(uiText[1])
	self.labCloseTips:set_active(false)
    ngui.find_button(self.ui,"sp_mark"):set_on_click(self.bindfunc["on_click"])
	self.ui:get_child_by_name("fx_ui_5001_bg_flash"):set_active(false)

	TimerManager.Add(self.ClickDelayCb, self.click_delay * 1000, 1, self)

	self:UpdateUi()
end

function GuidePlayGuideUI:UpdateUi()
	if self.texture and self.texture_path then
		self.texture:set_texture(self.texture_path)
	end
end

function GuidePlayGuideUI:ClickDelayCb()
	self.click_enable = true
	self.labCloseTips:set_active(true)
end

function GuidePlayGuideUI:on_click()
	if not self.click_enable then return end

	GuidePlayGuideUI.Destroy()
end

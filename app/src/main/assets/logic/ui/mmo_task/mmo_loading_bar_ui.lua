--MMOLoadingBardUI 任务通用loading进度条
--Author : zzc
--Date   : 2016/4/1

MMOLoadingBardUI = Class('MMOLoadingBardUI', UiBaseClass);

function MMOLoadingBardUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/baoxiang/panel_open_box.assetbundle";
	UiBaseClass.Init(self, data);
end

function MMOLoadingBardUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.timerLoading = nil;
	self.text = "";
	self.duration = 0;
	self.callback = nil;
	self.timerInterval = 60;
end

function MMOLoadingBardUI:Restart(data)
	UiBaseClass.Restart(self, data);
end

function MMOLoadingBardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["UpdateProgress"] = Utility.bind_callback(self, MMOLoadingBardUI.UpdateProgress);
end

function MMOLoadingBardUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self)
end

function MMOLoadingBardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("loading_bar_ui");

	local path = ""

	------------------------------ 顶部 -----------------------------
	path = "centre_other"
	self.btnOpen = ngui.find_button(self.ui, path .. "/btn");
	self.btnOpen:set_active(false);

	self.buttonEnableFx = self.ui:get_child_by_name('fx_ui_panel_open_box_jiguan')
    self.buttonEnableFx:set_active(false)

	-- self.labLoading = ngui.find_label(self.ui, path.."/background/lab");
	-- self.labLoading:set_text("");

	self.progress_bar = ngui.find_progress_bar(self.ui, path .. "/background");
	self.progress_bar:set_active(false);
	self.progress_bar:set_value(0);

	self.cont = self.ui:get_child_by_name(path .. "/sp_box");
	self.cont:set_active(false)

	self:UpdateUi()
end

function MMOLoadingBardUI:StartLoading(text, duration, callback)
	self.text = text or ""
	self.duration = duration
	self.callback = callback

	self:UpdateUi()
end

function MMOLoadingBardUI:DestroyUi()
	self:ClearTimer()
	UiBaseClass.DestroyUi(self);
end


function MMOLoadingBardUI:UpdateUi()
	if self.ui == nil then return end

	if self.duration <= 0 then
		-- self.labLoading:set_active(false)
		self.progress_bar:set_active(false)
	else
		-- self.labLoading:set_active(true)
		self.progress_bar:set_active(true)
	end

	self:ClearTimer();
	self.progress_bar:set_value(0);
	-- self.labLoading:set_text(self.text);

	if self.duration > 0 then
		self.timerNowCost = 0
		self.timerLoading =  timer.create(self.bindfunc["UpdateProgress"], self.timerInterval, -1);
	end
end

function MMOLoadingBardUI:ClearTimer()
	if self.timerLoading then
		timer.stop(self.timerLoading)
		self.timerLoading = nil
	end
end

function MMOLoadingBardUI:Hide()
	self:ClearTimer()
	UiBaseClass.Hide(self)
end

function MMOLoadingBardUI:UpdateProgress()
	self.timerNowCost = self.timerNowCost + self.timerInterval;
	local value = math.min(self.timerNowCost/self.duration, 1);
	self.progress_bar:set_value(value);

	if value == 1 then
		self:ClearTimer()
		self:Hide();
		if type(self.callback) == "function" then
			self.callback()
		end
	end
end

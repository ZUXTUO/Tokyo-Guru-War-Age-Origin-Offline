CommonCountDownUI = Class("CommonCountDownUI",UiBaseClass);

function CommonCountDownUI:SetTime(time)
	self.time = time;
	if self.ui then
		self:_CountDown();
	end
end

function CommonCountDownUI:Show()
	if not UiBaseClass.Show(self) then
		return;
	end
	self:_CountDown();
end

function CommonCountDownUI:Hide()
	if not UiBaseClass.Hide(self) then return end;
	if self.timerID then
		timer.stop(self.timerID);
		self.timerID = nil;
	end
	self.time = nil;
	self.cancelCallback = nil;
end

function CommonCountDownUI:SetCancelCallback(callback)
	self.cancelCallback = callback;
end
function CommonCountDownUI:SetTitle(title)
    self.labTitle:set_text(title);
end

---------------------
function CommonCountDownUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_828_ghoul_fight.assetbundle";
    UiBaseClass.Init(self, data);
end

function CommonCountDownUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_cancel'] = Utility.bind_callback(self, self.on_cancel);
    self.bindfunc['on_time'] = Utility.bind_callback(self, self.on_time);
end

function CommonCountDownUI:InitData(data)
    UiBaseClass.InitData(self,data);
end

function CommonCountDownUI:Restart(data)
	UiBaseClass.Restart(self,data);
end

function CommonCountDownUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
	self.cancelCallback = nil;
end

function CommonCountDownUI:InitUI(obj)
    UiBaseClass.InitUI(self,obj);

    local _btnCancel = ngui.find_button(self.ui,"centre_other/animation/btn_anniu");
    _btnCancel:set_on_click(self.bindfunc["on_cancel"]);

    self.labTitle = ngui.find_label(self.ui,"centre_other/animation/txt_title");
    self.labCountDown = ngui.find_label(self.ui,"centre_other/animation/lab1");
    self.labDescribe = ngui.find_label(self.ui,"centre_other/animation/lab2");

    self.ui:set_active(false);
end

function CommonCountDownUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then return end;
    if self.time then
	    self.labCountDown:set_text("倒计时[f2ae1c] "..(self.time-self.curtime).." [-]秒");
	end
    self.labDescribe:set_text("");
end
-----------------内部函数-------------
function CommonCountDownUI:_CountDown()
	if self.time and not self.timerID then
		self.curtime = 0;
		self.timerID = timer.create(self.bindfunc["on_time"],1000,self.time);
	end
	self:UpdateUi();
end
-----------------callback-------------
function CommonCountDownUI:on_time()
	self.curtime = self.curtime + 1;
	if not self.time or self.curtime >= self.time then
		self.timerID = nil;
		self:on_cancel();
	end
	self:UpdateUi();
end
function CommonCountDownUI:on_cancel()
	if self.cancelCallback then
		Utility.CallFunc(self.cancelCallback);
	end
	self:Hide();
end

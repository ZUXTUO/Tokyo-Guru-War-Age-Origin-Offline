--region vs_match_ui.lua
--Author : zzc
--Date   : 2016/1/13

-------------------------------- 已废弃 -----------------------------


VsMatchUI = Class('VsMatchUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/fuzion/ui_2902_fuzion.assetbundle"

-- 抽取本地的文本，需要替换到配置表
_local.UIText = {
	[1] = "匹配中",
	[2] = "匹配成功",
	[3] = "倒计时 [f2ae1c]%d[-] 秒",
	[4] = "取消匹配",
}

-- 说明：公用界面，未使用UiManager管理。由调用者自己控制创建及销毁
-------------------------------------外部设置-----------------------------------
-- 设置参数：
-- callback 退出回调函数（回调参数：true匹配成功退出，false取消匹配退出请求）
-- countDown 倒计时长（秒）
-- btnStr 按钮文字
-- title  标题文字
-- content 文本
function VsMatchUI:SetData(data)
	self.callback = data.callback
	self.countDown = data.countDown
	self.btnStr = data.btnStr
	self.title = data.title
	self.content = data.content
end

-- 设置准备状态
-- true/开始播放动画准备退出界面， false/未准备完毕
function VsMatchUI:SetReady(bool)
	self.ready = bool
	self.curValue = 0

	if self.ui then
		self.progress:set_active(bool)
		self.complete:set_active(bool)
		-- self.complete2:set_active(bool)
		self.btnCancel:set_enable(not bool)

		self:UpdateUi()
	end
end

-------------------------------------类方法-------------------------------------
--初始化
function VsMatchUI:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

--重新开始
function VsMatchUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
	end
end

--初始化数据
function VsMatchUI:InitData(data)
	UiBaseClass.InitData(self, data);

	self.countDown = 0	-- 倒计时长
	self.curValue = 0	-- 进度条当前值
	self.curCount = 0	-- 当前倒计时
	self.ready = false	-- 准备完成，显示完成进度条
	self.callback = nil	-- 成功退出回调函数
end

--释放界面
function VsMatchUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    self.btnStr = nil;
	self.title = nil;
	self.content = nil;
    -- 释放texture
    -- if self.complete then
    -- 	self.complete:Destroy()
    -- 	self.complete = nil
    -- end
    -- if self.complete2 then
    -- 	self.complete2:Destroy()
    -- 	self.complete2 = nil
    -- end

    self:StopCountDownTimer()
end

--显示UI
function VsMatchUI:Show()
	if UiBaseClass.Show(self) then
		self.curCount = self.countDown
		
		self:SetReady(false)
		self:StartCountDownTimer()
	end
end

--隐藏UI
function VsMatchUI:Hide()
	if UiBaseClass.Hide(self) then
		self:StopCountDownTimer()
	end
end

--注册方法
function VsMatchUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
	self.bindfunc["on_count_down_timer"] = Utility.bind_callback(self, self.on_count_down_timer);
	Root.AddUpdate(VsMatchUI.Update, self)
end 

--撤销注册方法
function VsMatchUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
    Root.DelUpdate(VsMatchUI.Update)
end

--初始化UI
function VsMatchUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("vs_match_ui");

	local basePath = ""
	------------------------------ 中部 -----------------------------
	basePath = "centre_other/animation"
	local labTitle = ngui.find_label(self.ui, basePath .. "/title/txt_tit")
	local labTime = ngui.find_label(self.ui, basePath .. "/title/lab_time")
	local btnCancel = ngui.find_button(self.ui, basePath .. "/btn_anniu1")
	self.labCancel = ngui.find_label(self.ui, basePath .. "/btn_anniu1/lab")
	
	btnCancel:set_on_click(self.bindfunc["on_cancel_btn"])
	btnCancel:set_active(true)
	self.labCancel:set_text(_local.UIText[4])

	self.btnCancel = btnCancel
	self.labTitle = labTitle
	self.labTime = labTime

	self.complete = ngui.find_sprite(self.ui, basePath.."/texture")
	self.complete2 = ngui.find_sprite(self.ui, basePath.."/texture2")
	self.progress = ngui.find_progress_bar(self.ui, basePath.."/pro_di")
	self.complete:set_active(false)
	self.complete2:set_active(false)
	self.progress:set_active(false)
	self.progress:set_value(0)

	self:UpdateUi()

	-- 开启倒计时定时器
	--self:StartCountDownTimer()
end

-- 开始倒计时
function VsMatchUI:StartCountDownTimer()
	if self.ui then
		self.timer = timer.create(self.bindfunc["on_count_down_timer"], 1000, -1)
		self:UpdateUi()
	end
end

-- 停止倒计时
function VsMatchUI:StopCountDownTimer()
	if self.timer then
		timer.stop(self.timer)
		self.timer = nil
	end
end

--完成进度刷新（总时长2秒）
function VsMatchUI:Update(dt)
	if self.ui == nil then return end
	if not self.ready then return end
	if self.curValue >= 1 then return end

	self.curValue = self.curValue + dt / 2
	self.progress:set_value(self.curValue)

	-- 完成匹配，打开战斗loading界面
	if self.curValue >= 1 then
		self:CallbackFunc(true)
	end
end

--刷新界面
function VsMatchUI:UpdateUi()
	if self.ui == nil then return end

	-- 刷新倒计时显示 就绪模式
	if self.ready then
		self.labTitle:set_text(_local.UIText[2])
		self.labTime:set_text(string.format(_local.UIText[3], self.curCount))
	else
		if self.title then
			self.labTitle:set_text(self.title)
		else
			self.labTitle:set_text(_local.UIText[1])
		end
		if self.content then
			self.labTime:set_text(string.format(self.content, self.curCount))
		else
			self.labTime:set_text(string.format(_local.UIText[3], self.curCount))
		end
		if self.btnStr then
			self.labCancel:set_text(self.btnStr);
		else
			self.labCancel:set_text(_local.UIText[4])
		end
	end
end

--回调函数
function VsMatchUI:CallbackFunc(bool)
	if self.callback then
		if type(self.callback) == "function" then
	    	self.callback(bool)
	    elseif type(self.callback) == "string" then
	    	Utility.call_func(self.callback, bool)
	    end
	end
end
-------------------------------------本地回调-------------------------------------

--取消匹配按钮
function VsMatchUI:on_cancel_btn(t)
	self:CallbackFunc(false)
end

--倒计时回调
function VsMatchUI:on_count_down_timer()
	self.curCount = math.max(self.curCount - 1, 0)
	self:UpdateUi()

	if self.ready or self.curCount == 0 then
		self:StopCountDownTimer()
	end
end

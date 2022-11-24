GuideFloatTips = Class('GuideFloatTips',UiBaseClass);

function GuideFloatTips:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guide/guide_fight_item.assetbundle";
	UiBaseClass.Init(self, data);

	self.content = data.content
	self.parent_path = data.parent_path
	self.direction = data.direction or 1 --1234-上下左右
	self.float_type = data.float_type
end

function GuideFloatTips:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('guide_float_tips');

	if self.direction == 1 then
		self.nodeShow = self.ui:get_child_by_name("sp_top1") -- 上左
		self.nodeShow:set_local_position(0, -60, 0)
	elseif self.direction == 2 then
		self.nodeShow = self.ui:get_child_by_name("sp_top2") -- 上右
		self.nodeShow:set_local_position(0, 60, 0)
	elseif self.direction == 3 then
		self.nodeShow = self.ui:get_child_by_name("sp_down1") -- 下左
		self.nodeShow:set_local_position(0, 60, 0)
	elseif self.direction == 4 then
		self.nodeShow = self.ui:get_child_by_name("sp_down2") -- 下右
		self.nodeShow:set_local_position(0, 60, 0)
	elseif self.direction == 5 then
		self.nodeShow = self.ui:get_child_by_name("cont_left") -- 左
		self.nodeShow:set_local_position(60, 0, 0)
	elseif self.direction == 6 then
		self.nodeShow = self.ui:get_child_by_name("cont_right") -- 右
		self.nodeShow:set_local_position(-60, 0, 0)
	end

	if not self:CheckParent() then
		TimerManager.Add(self.bindfunc['on_check_timer'], 400, 10)
	end
end

function GuideFloatTips:RegistFunc()
    UiBaseClass.RegistFunc(self)
	self.bindfunc['on_check_timer'] = Utility.bind_callback(self, self.on_check_timer);
	self.bindfunc['on_hide_once'] = Utility.bind_callback(self, self.on_hide_once);
	self.bindfunc['on_hide_loop'] = Utility.bind_callback(self, self.on_hide_loop);
	self.bindfunc['on_show_loop'] = Utility.bind_callback(self, self.on_show_loop);
end

function GuideFloatTips:DestroyUi()
	TimerManager.Remove(self.bindfunc['on_check_timer'])
	TimerManager.Remove(self.bindfunc['on_hide_once'])
	TimerManager.Remove(self.bindfunc['on_hide_loop'])
	TimerManager.Remove(self.bindfunc['on_show_loop'])
	
	UiBaseClass.DestroyUi(self)
end

function GuideFloatTips:CheckParent()
	if not self.ui then return false end

	local result = false
	local objParent = GuideUI.GetSelectGameObject(self.parent_path)
	if objParent then
		self.ui:set_parent(objParent)
		self.ui:set_local_position(0,0,0)
		self.nodeShow:set_active(true)

		local lab = ngui.find_label(self.nodeShow, "lab")
		lab:set_text(self.content)

		--播放1次
		if self.float_type == 1 then
			TimerManager.Add(self.bindfunc['on_hide_once'], 3000, 1)
		--循环
		else
			TimerManager.Add(self.bindfunc['on_hide_loop'], 3000, 1)
		end
		result = true
	end
    return result
end

function GuideFloatTips:on_check_timer()
	if self:CheckParent() then
		TimerManager.Remove(self.bindfunc['on_check_timer'])
	end
end

function GuideFloatTips:on_hide_once()
	NoticeManager.Notice(ENUM.NoticeType.GetFloatTipsShowBack)
	self:Hide()
end

function GuideFloatTips:on_hide_loop()
	if not self.ui then return end

	self:Hide()
	TimerManager.Add(self.bindfunc['on_show_loop'], 1000, 1)
end

function GuideFloatTips:on_show_loop()
	if not self.ui then return end

	self:Show()
	TimerManager.Add(self.bindfunc['on_hide_loop'], 3000, 1)
end


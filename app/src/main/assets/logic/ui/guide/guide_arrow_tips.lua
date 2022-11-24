GuideArrowTips = Class('GuideArrowTips',UiBaseClass);

function GuideArrowTips:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/guide/guide_arrows_item.assetbundle";
	UiBaseClass.Init(self, data);

	self.origin = data.origin
	self.target = data.target

	-- self.distance = 0
	-- self.delt_x = 0
	-- self.delt_y = 0
end

function GuideArrowTips:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('guide_arrow_tips');

	-- self.spHand = ngui.find_sprite(self.ui, "sp_hand")
	-- self.wgArrow = ngui.find_widget(self.ui, "sp")
	-- self.objArrow = self.wgArrow:get_game_object()
	self.objArrow = self.ui:get_child_by_name("fx_xinshou_jiantou01")

	-- 放到新手引导层上面
	self.ui:set_parent(GuideUI.parentCopy)

	local wx1, wy1, wz1 = self.origin:get_position()
	local wx2, wy2, wz2 = self.target:get_position()

	local ui_camera = Root.get_ui_camera();
	local x1, y1, z1 = ui_camera:world_to_screen_point(wx1, wy1, wz1);
	local x2, y2, z2 = ui_camera:world_to_screen_point(wx2, wy2, wz2);

	local delt_x = math.floor(x2 - x1)
	local delt_y = math.floor(y2 - y1)

	local screenWidth = app.get_screen_width()
	-- 得到逻辑屏幕的距离 = 相应分辨率下的距离 * 标准缩放比
	local distance = math.ceil( math.sqrt( math.pow(delt_x,2) + math.pow(delt_y,2) ) * 1280 / screenWidth )
	local angle = math.atan(delt_y / delt_x) * 180 / math.pi

	if angle > 0 then
		angle = angle - 90
	elseif angle < 0 then
		angle = angle + 90
	end

	self.ui:set_position(wx2, wy2, 0)
	self.objArrow:set_local_rotation(0, 0, angle)
	
	-- 特效在标准分辨率1280 * 720的长度为330
	local scale = distance / 330 
	self.objArrow:set_local_scale(scale, scale, 1)
	-- self.distance = distance
	-- self.delt_x = delt_x
	-- self.delt_y = delt_y

	self:BeginMove()
end

function GuideArrowTips:RegistFunc()
    UiBaseClass.RegistFunc(self)
	self.bindfunc['BeginMove'] = Utility.bind_callback(self, self.BeginMove);
end

function GuideArrowTips:DestroyUi()
	self.origin = nil
	self.target = nil

	self:StopMove()
	TimerManager.Remove(self.bindfunc['BeginMove'])
	
	UiBaseClass.DestroyUi(self)
end

function GuideArrowTips:SetEnable(enable)
	self.enable = enable

	if self.enable then
		self.playing = false

		self:Show()
		self:BeginMove()
	else
		self:Hide()
		self:StopMove()
	end
end

function GuideArrowTips:StopMove()
	-- if self.wgArrow then
	-- 	Tween.removeTween(self.wgArrow)
	-- end
	-- if self.spHand then
	-- 	Tween.removeTween(self.spHand)
	-- end
	self.playing = false
	self.objArrow:set_active(false)
end

function GuideArrowTips:BeginMove()
	if not self.ui then return end
	if self.playing then return end

	self.playing = true
	self.objArrow:set_active(true)
	-- local completeFunc = function()
	-- 	self.playing = false
	-- 	TimerManager.Add(self.bindfunc['BeginMove'], 200)
	-- end

	-- local w, h = self.wgArrow:get_size()
	-- self.wgArrow:set_size(w, 20)
	-- Tween.addTween(self.wgArrow,0.6,{size = {w, self.distance}},nil,0,nil,nil,completeFunc)

	-- local x, y, z = 50, 20, 0
	-- self.spHand:set_position(50,20,0)
	-- Tween.addTween(self.spHand,0.6,{position = {50 + self.delt_x, 20 + self.delt_y, 0}},nil,0,nil,nil,nil)
end

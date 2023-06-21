 
UiClownPlanFightResult = Class('UiClownPlanFightResult', MultiResUiBaseClass)

 


function UiClownPlanFightResult.ShowAwardUi(data)
	app.log("UiClownPlanFightResult.ShowAwardUi")
	if nil == UiClownPlanFightResult.Inst then
		UiClownPlanFightResult.Inst = UiClownPlanFightResult:new(data)
	else
		UiClownPlanFightResult.Inst:Show(data)
	end
	UiClownPlanFightShow.DestroyUi()
end

function UiClownPlanFightResult.DestroyAwardUi()
	if UiClownPlanFightResult.Inst then
		UiClownPlanFightResult.Inst:DestroyUi()
		UiClownPlanFightResult.Inst = nil
	end
end

local resType = {
	Front = 1,
	Back = 2
}

local _uiText = 
{
	[1] = '活动结束',
	[2] = '点击屏幕任意位置关闭',
}

local resPaths = {
	[resType.Front] = "assetbundles/prefabs/ui/wanfa/clown_plan/new_fight_ui_xiao_chou3.assetbundle",
	[resType.Back] = "assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle"
}
function UiClownPlanFightResult:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data)
end

function UiClownPlanFightResult:InitData(data)
	MultiResUiBaseClass.InitData(self, data)
	self.data = data
	self.data_items = { }
end
-- 重新开始
function UiClownPlanFightResult:Restart(data)
	MultiResUiBaseClass.Restart(self, data)

	CommonClearing.canClose = false
end
-- 注册方法
function UiClownPlanFightResult:RegistFunc()
	MultiResUiBaseClass.RegistFunc(self);

	self.bindfunc["OnClose"] = Utility.bind_callback(self, self.OnClose);
end 

-- 撤销注册方法
function UiClownPlanFightResult:UnRegistFunc()
	MultiResUiBaseClass.UnRegistFunc(self);
end

-- 注册消息分发回调函数
function UiClownPlanFightResult:MsgRegist()
	MultiResUiBaseClass.MsgRegist(self);
end

-- 注销消息分发回调函数
function UiClownPlanFightResult:MsgUnRegist()
	MultiResUiBaseClass.MsgUnRegist(self);
end

 
function UiClownPlanFightResult:InitedAllUI()
	
	self.ui = self.uis[resPaths[resType.Front]]
	self.backui = self.uis[resPaths[resType.Back]]

	self.frontParentNode = self.backui:get_child_by_name("add_content")
	self.tipCloseLabel = ngui.find_label(self.backui, "txt")
	self.titleSprite= ngui.find_sprite(self.backui, "sp_art_font")
	self.txt = ngui.find_label(self.ui, "txt/lab")
	self.progressBar = ngui.find_progress_bar(self.ui, "background")
	self.lbl_damage = ngui.find_label(self.ui, "txt_reward/lab_num")
	self.sp_mark = ngui.find_button(self.backui, "mark")
	self.ui_item_grid = ngui.find_grid(self.ui, "txt_kill_reward/grid")
	self.ui_item_parent = self.ui_item_grid:get_game_object()
	self.ui_item_temp = self.ui:get_child_by_name("txt_kill_reward/grid/new_small_card_item1")
	self.ui_item_parents = {}

	self.ui:set_name("clown_fight_result")
	self.sp_mark:set_on_click(self.bindfunc["OnClose"])
	self.ui_item_temp:set_active(false)
	self.tipCloseLabel:set_text(_uiText[2])

	self:UpdateUi()
end

function UiClownPlanFightResult:Show(data)
	UiBaseClass.Show(self)
	self:UpdateUi()
end

function UiClownPlanFightResult:UpdateUi()
	if self.ui == nil then return end
	
	self.ui:set_parent(self.frontParentNode)
	self.titleSprite:set_sprite_name("js_huodongjieshu")
	self.lbl_damage:set_text(tostring(self.data.damage))
	local progress = self.data.damage/self.data.boss_max_hp
	self.txt:set_text(tostring(math.floor(progress*100).."%"))
	self.progressBar:set_value(progress)
	--self.lbl_gold:set_text(tostring(self.data.gold))	

	
	local ratio_num = 1;
	PublicFunc.ConstructCardAndSort(self.data.awards)
	for i = 1, 5 do
		local award = self.data.awards[i]
		if award then
			local itempt = self.ui_item_temp:clone()
			itempt:set_active(true)
			ratio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.xiaochoujihu, award.id);  
			app.log("item_id:" .. award.id .. "-- ratio_num:" .. ratio_num); 
			local item = UiSmallItem:new( { parent = itempt })
			--item:SetDataNumber(award.id, award.count);
			item:SetData(award.cardinfo)
			if item.SetCount then
				item:SetCount(math.floor(award.count / ratio_num));
			end
			award.cardinfo = nil
			if ratio_num > 1 then
				item:SetDouble(ratio_num);
			end
			table.insert(self.data_items, item)
			table.insert(self.ui_item_parents, itempt)
		end
	end
	self.ui_item_grid:reposition_now()

	AudioManager.Stop(nil, true)
	AudioManager.PlayUiAudio(81010000)
end 

function UiClownPlanFightResult:DestroyUi()

	if self.data_items then
		for k,item in ipairs(self.data_items) do
			item:DestroyUi()
		end
		self.data_items = nil
	end
	self.ui_item_parents = nil

	MultiResUiBaseClass.DestroyUi(self)
end

function UiClownPlanFightResult:OnClose()	

	if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

	SceneManager.PopScene(FightScene)
	UiClownPlanFightResult.DestroyAwardUi()
end
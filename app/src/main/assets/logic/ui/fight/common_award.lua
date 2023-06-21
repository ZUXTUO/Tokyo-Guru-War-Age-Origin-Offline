CommonAward = Class("CommonAward", MultiResUiBaseClass);

--------------------外部接口-------------------------
--awardsList 物品列表 ｛net_summary_item，net_summary_item，net_summary_item｝最多10个
--tType CommonAwardEType,默认CommonAwardEType.again
--desc 描述文本

CommonAwardEType = 
{
    again = 1, 			-- 获得物品
	reset = 3, 			-- 重置成功
	operatorAgain = 6,		--在结算界面再一次操作
	occupySuc = 7,		-- 占领成功
}

local _uiText=
{
	[1] = "重置返还";
	[5] = "再抽%s次";
	[8] = "点击屏幕任意位置关闭";
}


-- againOperatorParam = 
-- {
-- 	againFunc = ,
-- 	againParam = ,
-- 	againCostId = ,
-- 	againCostNum = ,
--  againCostOwn = ,
--  againType = , 1-再来1次，10-再来10次
-- }
function CommonAward.Start(awardsList, tType, desc, againOperParam, showMultiple)
	if CommonAward.cls == nil then
		CommonAward.cls = uiManager:PushUi(EUI.CommonAward, {awardsList=awardsList, tType=tType,desc = desc, againOperParam = againOperParam, showMultiple = showMultiple});
	end
end


function CommonAward.SetFinishCallback(callback, obj)
	if CommonAward.cls then
		CommonAward.cls.callbackFunc = callback;
		if CommonAward.cls.callbackFunc then
			CommonAward.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonAward.Destroy()
	if CommonAward.cls then
		--CommonAward.cls:DestroyUi();
		uiManager:RemoveUi(EUI.CommonAward)
		CommonAward.cls = nil;
	end
end

function CommonAward.OnAnimationEnd()
	local cls = CommonAward.cls
	if cls and cls.uiSmallItems then
		--添加稀有物品特效
		for k, v in pairs(cls.uiSmallItems) do
			local cardInfo = v:GetCardInfo()
			if cardInfo and cardInfo.rarity >= ENUM.EItemRarity.Orange then
				v:SetAsReward(true)
			end
		end
	end

	if GuideUI then
		GuideUI.OnUiAniEnd()
	end
end
--------------------内部接口-------------------------
local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	-- ui/new_fight
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_832_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

function CommonAward:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function CommonAward:RestartData(data)
	MultiResUiBaseClass.RestartData(self, data);
	--外部数据相关
	self.data = data;
	self.nextShowIndex = 1
	self.data.tType = self.data.tType or CommonAwardEType.again;
	CommonClearing.canClose = false
end

function CommonAward:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnDelayClose"] = Utility.bind_callback(self,self.OnDelayClose);
	self.bindfunc["ClickAgainButton"] = Utility.bind_callback(self,self.ClickAgainButton);
	self.bindfunc["BeginShow"] = Utility.bind_callback(self,self.BeginShow);
end

function CommonAward:InitedAllUI()
	local data = self.data;
	--util.begin_sample('CommonAward:InitedAllUI')
	self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]

	self.backAnimationNode = self.backui:get_child_by_name("animation")
	self.closeTipText = ngui.find_label(self.backui, "txt")
	self.frontParentNode = self.backui:get_child_by_name("add_content")
	self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")
	-- self.labMeterial = ngui.find_label(self.frontui, 'lab_title')
	-- self.MoreFiveParentNodesParent = self.frontui:get_child_by_name("scrollview/panel")
	-- self.lessFiveParentNodesParent = self.frontui:get_child_by_name("grid")
	-- self.backClickContinueLab = ngui.find_label(self.backui, 'txt')
	self.againOperatorParentNode = self.frontui:get_child_by_name('cont')
	self.againSureBtn = ngui.find_button(self.frontui, 'btn_sure')
	self.againBtn = ngui.find_button(self.frontui, 'btn_zai_chou')
	self.againLab = ngui.find_label(self.frontui, 'btn_zai_chou/animation/lab')
	self.CostItemTexture = ngui.find_texture(self.frontui, 'Texture_yaoshi')
	self.costNumLab = ngui.find_label(self.frontui, 'lab_num')
	self.closeMarkButton = ngui.find_button(self.backui, "mark")
	self.grid = ngui.find_grid(self.frontui, "grid")

	local lblMultiple = ngui.find_label(self.frontui, "lab_number")
	if data.showMultiple then
		lblMultiple:set_active(true)
		lblMultiple:set_text('[FCD901]' .. tostring(data.showMultiple) .. '[-]')
	else
		lblMultiple:set_active(false)
	end

	-- self.MoreFiveParentNodes = {}
	-- self.lessFiveParentNodes = {}
	-- for i=1, 10 do
	-- 	local node = self.frontui:get_child_by_name('scrollview/panel/grid/new_small_card_item' .. tostring(i))
	-- 	node:set_active(false)
	-- 	table.insert(self.MoreFiveParentNodes, node)
	-- end
	-- for i=1, 5 do
	-- 	local node = self.frontui:get_child_by_name('scrollview/grid/new_small_card_item' .. tostring(i))
	-- 	node:set_active(false)
	-- 	table.insert(self.lessFiveParentNodes, node)
	-- end
	self.parentNodes = {}
	for i = 1, 10 do
		local node = self.frontui:get_child_by_name("grid/new_small_card_item" .. tostring(i))
		node:set_active(false)
		table.insert(self.parentNodes, node)
	end


	-- set content
	self.frontui:set_parent(self.frontParentNode)
	self.closeTipText:set_text(_uiText[8])
	if data.tType ~= CommonAwardEType.operatorAgain then
		data.awardsList = PublicFunc.MergeNetSummeryNetList(data.awardsList)
		PublicFunc.ConstructCardAndSort(data.awardsList)
	end
	self.uiSmallItems = {}
	self.tipDelay = 0
	-- if #data.awardsList <= 5 then
	-- 	self.tipDelay = 0
	-- 	self.parentNodes = self.lessFiveParentNodes

	-- 	self.MoreFiveParentNodesParent:set_active(false)
	-- 	self.lessFiveParentNodesParent:set_active(true)
	-- else
	-- 	self.parentNodes = self.MoreFiveParentNodes
	-- 	self.MoreFiveParentNodesParent:set_active(true)
	-- 	self.lessFiveParentNodesParent:set_active(false)
	-- end

	-- self.labMeterial:set_active(false)
	self.titleSprite:set_sprite_name("js_gongxihuode")
	if data.tType == CommonAwardEType.reset then
		app.log("function is not complete!!!")
		self.titleSprite:set_sprite_name("js_chongzhichenggong")
		-- self.labMeterial:set_active(true)
		-- self.labMeterial:set_text(_uiText[1])
	elseif data.tType == CommonAwardEType.occupySuc then
		self.titleSprite:set_sprite_name("js_zhanlingchenggong")
    end

	if data.tType == CommonAwardEType.operatorAgain then
		self.againOperatorParentNode:set_active(true)
		-- self.backClickContinueLab:set_active(false)

		self.againSureBtn:set_on_click(self.bindfunc["OnDelayClose"]);
		self.againBtn:set_on_click(self.bindfunc["ClickAgainButton"]);

		local againOperParam = data.againOperParam

		if againOperParam.againCostType then
			self.againLab:set_text(string.format(_uiText[5], againOperParam.againCostType))
		end
		if againOperParam.againCostId then
			local config = ConfigManager.Get(EConfigIndex.t_item, againOperParam.againCostId)
			if config then
				self.CostItemTexture:set_texture(config.small_icon)
			end
		end
		if againOperParam.againCostNum then
			if againOperParam.againCostOwn then
				self.costNumLab:set_text(tostring(againOperParam.againCostOwn) .. "/" .. tostring(againOperParam.againCostNum))
			else
				self.costNumLab:set_text(tostring(againOperParam.againCostNum))
			end
		end

		self.closeTipText:set_active(false)
	else
		self.againOperatorParentNode:set_active(false)
		self.needWaitCloseEvent = true
		self.closeMarkButton:set_on_click(self.bindfunc["OnDelayClose"]);
	end

	-- if data.desc then
	-- 	self.labMeterial:set_text(tostring(data.desc))
	-- 	self.labMeterial:set_active(true)
	-- end

	-- local count = #data.awardsList
	-- local parentNodeTemplate = nil
	-- if count > #self.parentNodes then
	-- 	parentNodeTemplate = self.parentNodes[1]:clone()
	-- 	parentNodeTemplate:set_active(false)
	-- end
	self:UpdateUi()

	self:Hide()
	self.backAnimationNode:set_animated_speed('ui_jiesuan_win', 0)
	TimerManager.Add(self.bindfunc["BeginShow"], 1)

	--util.end_sample()
	GLoading.Show(GLoading.EType.ui)
end

function CommonAward:BeginShow()
	GLoading.Hide(GLoading.EType.ui)
	if not self.backui then return end
	--util.begin_sample('CommonAward:BeginShow')
	self:Show()
	self.backAnimationNode:set_animated_speed('ui_jiesuan_win', 1)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward);
	--util.end_sample()
end

function CommonAward:UpdateUi()

	local data = self.data
	for index = 1, 10 do
		local node = self.parentNodes[index]
		local item = data.awardsList[self.nextShowIndex]
		if item == nil then
			node:set_active(false)
		else
			self.nextShowIndex = self.nextShowIndex + 1
			node:set_active(true)

			local old = self.uiSmallItems[index]
			if PropsEnum.IsRole(item.id) then
				if not old or old.__className ~= SmallCardUi.__className then
					if old then
						old:DestroyUi()
					end
					self.uiSmallItems[index] = SmallCardUi:new({parent = node, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }})	
				end	
			else
				if not old or old.__className ~= UiSmallItem.__className then
					if old then
						old:DestroyUi()
					end
					self.uiSmallItems[index] = UiSmallItem:new({parent = node, is_enable_goods_tip = true, delay = self.tipDelay})
				end
			end
			if item.cardinfo then
				local usi = self.uiSmallItems[index]
				usi:SetData(item.cardinfo)
				if usi.SetCount then
					usi:SetCount(item.count)
				end

				item.cardinfo = nil
				item.type = nil
			else
				--app.log("#hyg# SetDataNumber")
				self.uiSmallItems[index]:SetDataNumber(item.id, item.count)
			end
			if item.double_radio and item.double_radio > 1 then
				self.uiSmallItems[index]:SetDouble(item.double_radio);
			end

			local nameLabel = ngui.find_label(node, "lab")
			local cardInfo = self.uiSmallItems[index]:GetCardInfo()
			nameLabel:set_text(cardInfo.color_name or cardInfo.name)
		end
	end
	self.grid:reposition_now()
end

function CommonAward:Show()
	if not self.backui then return end

	self.backui:set_local_position(0, 0, 0)
end

function CommonAward:Hide()
	if not self.backui then return end

	self.backui:set_local_position(100000, 0, 0)
end

function CommonAward:ClickAgainButton()

	if not CommonClearing.canClose then return end

	local data = self.data

	self:OnClose()

	if data and data.againOperParam then
		local againOperParam = data.againOperParam

		againOperParam.againFunc(againOperParam.againParam)
	end
end

function CommonAward:OnDelayClose()
	if self.needWaitCloseEvent then
		if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end
	else
		if not CommonClearing.canClose then return end
	end

	self:OnClose()
end

function CommonAward:OnClose(t)

	if self.data and self.nextShowIndex <= #self.data.awardsList then
		self:UpdateUi()
		return
	end

	self.data = nil;
	--ui相关
	CommonAward.Destroy()

	--内部变量相关
	local oldCallback = self.callbackFunc;
	local oldCallObj = self.callbackObj;
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end

	NoticeManager.Notice(ENUM.NoticeType.GetCommonAwardBack)

	return true
end

function CommonAward:DestroyUi()
	
	if self.CostItemTexture then
		self.CostItemTexture:Destroy()
	end

	if self.uiSmallItems then
		for k,v in pairs(self.uiSmallItems) do
			v:DestroyUi()
		end
		self.uiSmallItems = nil
	end

	self.backui = nil

	MultiResUiBaseClass.DestroyUi(self)
end
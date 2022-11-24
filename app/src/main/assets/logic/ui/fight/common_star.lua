CommonStar = Class("CommonStar", MultiResUiBaseClass);

--------------------外部接口-------------------------
--star通关星级
--finishConditionInfex 完成条件索引 ｛[1]=1,[3]=1｝
--conditionDes {"123","123","123"}条件总描述
function CommonStar.Start(star, finishConditionInfex, conditionDes, cards, awards, extraAwards)
	if CommonStar.cls == nil then
		CommonStar.cls = CommonStar:new({
			star=star, 
			finishConditionInfex=finishConditionInfex, 
			conditionDes=conditionDes,
			cards = cards,
			awards = awards,
			extraAwards = extraAwards,
			});
	end
end


function CommonStar.SetFinishCallback(callback, obj)
	if CommonStar.cls then
		CommonStar.cls.callbackFunc = callback;
		if CommonStar.cls.callbackFunc then
			CommonStar.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonStar.Destroy()
	if CommonStar.cls then
		CommonStar.cls:DestroyUi();
		CommonStar.cls = nil;
	end
end

--------------------内部接口-------------------------
local timerShow = 30

local resType = 
{
    Front = 1,
}

local _uiText =
{
	[1] = "点击屏幕任意位置关闭",
}

local resPaths = 
{
	[resType.Front] = 'assetbundles/prefabs/ui/level/ui_706_level.assetbundle';
}

local starAnimationName = 
{
	[1] = "ui_706_level_zaxingxing1",
	[2] = "ui_706_level_zaxingxing2",
	[3] = "ui_706_level_zaxingxing3",
}

function CommonStar:Init(data)
	self.pathRes = resPaths;
	MultiResUiBaseClass.Init(self, data);
end

function CommonStar:InitData(data)
	MultiResUiBaseClass.InitData(self, data);

end

function CommonStar:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
	self.bindfunc["TimerProgress"] = Utility.bind_callback(self,self.TimerProgress)
end

function CommonStar:InitedAllUI()

	self.ui = self.uis[resPaths[resType.Front]]
	self.animationNode = self.ui:get_child_by_name("animation")
	self.closeBtn = ngui.find_button(self.ui, "sp_mark")
	self.useTimeLabel = ngui.find_label(self.ui, "lab_time/lab_num")
	self.starNodes = {}
	for i = 1, 3 do
		local node = {}
		node.star = ngui.find_sprite(self.ui, "cont_star/sp_star" .. tostring(i))
		node.lab = ngui.find_label(self.ui, "cont_star/lab" .. tostring(i))
		--node.fx = self.ui:get_child_by_name("cont_star/sp_star" .. tostring(i) .. '/fx_ui_706_level_star')
		self.starNodes[i] = node
	end
	self.levelLabel = ngui.find_label(self.ui, "pro_di/lab_level")
	self.addExpLabel = ngui.find_label(self.ui, "pro_di/lab_num")
	self.progressBar = ngui.find_progress_bar(self.ui, "pro_di")
	self.addGoldLabel = ngui.find_label(self.ui, "sp_bk2/lab")
	self.awardNodes = {}
	for i = 1, 5 do
		local node = {}
		node.parent = self.ui:get_child_by_name("grid_award/new_small_card_item" .. tostring(i))
		self.awardNodes[i] = node
	end
	self.herosNodes = {}
	for i = 1, 3 do
		local node = {}
		node.root = self.ui:get_child_by_name("grid_hero/big_card_item_80" .. tostring(i))
		node.parent = node.root:get_child_by_name("big_card_item_80")
		node.levelUpSp = ngui.find_sprite(node.root, "sp_art_font")
		--node.addExpLabel = ngui.find_label(node.root, "lab_exp")
		--node.progressBar = ngui.find_progress_bar(node.root, "pro_di")
		self.herosNodes[i] = node
	end
	self.tipCloseLabel = ngui.find_label(self.ui, "txt")
    

	-- set content
	local data = self:GetInitData();
	local player = g_dataCenter.player
	local desData = data.conditionDes
	local indexData = data.finishConditionInfex
	local awards = data.awards
	local extraAwards = data.extraAwards
	local cards = data.cards

	self.useTimeLabel:set_text(tostring(FightScene.GetFightManager():GetFightUseTime()))
	self.tipCloseLabel:set_text(_uiText[1])
	self.needPlayStarAnimations = {}
	self.currentPlayIndex = 0
	for i = 1, 3 do
		local node = self.starNodes[i]
		node.star:set_sprite_name("js_xing2")
		if indexData[i] then
			node.lab:set_text(tostring(desData[i]))
			table.insert(self.needPlayStarAnimations, {starAnimationName[i], node.star})
		else
			node.lab:set_text(tostring(desData[i]))
			node.lab:set_color(1, 1, 1, 1)
		end
	end

	self.levelLabel:set_text(tostring(player:GetLevel()))
	self.progressAnimationData = {}
	local maxLevel = ConfigManager.GetDataCount(EConfigIndex.t_player_level)
	local addExp = player:GetDiffExp()
	self.progressBar:set_value(player:GetOldExpPro())
	if player:GetLevel() < maxLevel and addExp > 0 then
		self.addExpLabel:set_text("+" .. tostring(addExp))
		self.levelLabel:set_text(tostring(player.oldData.level))

		local aniData = {}
		local diffExp = player:GetDiffExp()
		local oldData = player.oldData
		aniData.remainAddExp = diffExp
		aniData.addRate = diffExp/timerShow
		aniData.progressBar = self.progressBar
		aniData.currExpValue = oldData.exp
		aniData.currLevelValue = oldData.level
		aniData.getMaxExp = function(level)
			local levelConfig = ConfigManager.Get(EConfigIndex.t_player_level, level);
			if levelConfig == nil then
				return nil
			end
			return levelConfig.exp
		end
		aniData.setLevel = function(level)
			if not level then
				level = player:GetLevel()
			end
			self.levelLabel:set_text(tostring(level))
		end
		aniData.getExpPro = function() return player:GetExpPro() end
		table.insert(self.progressAnimationData, aniData)
	else
		self.addExpLabel:set_active(false)
		if player:GetLevel() >= maxLevel then
			self.progressBar:set_value(1)
		end
	end

	local hurdleConfig = FightScene.GetHurdleConfig()
	local radio_num = 1;
	local goldNum = 0
	local showSmallItemUis = {}
	for k,v in ipairs(awards) do
        if PropsEnum.IsGold(v.id) then
            goldNum = goldNum + v.count
            if hurdleConfig.hurdle_type == 0 then
	            radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_normal, v.id);
	        else
	            radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_elite, v.id);
	        end
        elseif PropsEnum.IsExp(v.id) or PropsEnum.IsHeroExp(v.id) then
        else
            table.insert(showSmallItemUis, v)
        end
	end
	PublicFunc.ConstructCardAndSort(showSmallItemUis)
    local extraShowSmallItemUis = {}
    for k,v in ipairs(extraAwards) do
        if PropsEnum.IsGold(v.id) then
            goldNum = goldNum + v.count
        elseif PropsEnum.IsExp(v.id) or PropsEnum.IsHeroExp(v.id) then
        else
            table.insert(extraShowSmallItemUis, v)
        end
    end
	PublicFunc.ConstructCardAndSort(extraShowSmallItemUis)
	if radio_num > 1 then
		self.addGoldLabel:set_text(tostring(goldNum) .. " X"..tostring(radio_num))
	else
		self.addGoldLabel:set_text(tostring(goldNum))
	end

	
	self.destroyItemUI = {}
	for i,curItem in ipairs(showSmallItemUis) do
		local node = self.awardNodes[i]
		if node == nil then 
			break 
		end
		local uiItem = UiSmallItem:new({parent = node.parent})
		uiItem:SetEnablePressGoodsTips(true)
		if curItem.cardinfo then
			uiItem:SetData(curItem.cardinfo)
			uiItem:SetCount(curItem.count)
		else
			uiItem:SetDataNumber(curItem.id, curItem.count)
		end

        
        if hurdleConfig.hurdle_type == 0 then
            radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_normal, curItem.id);
        else
            radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_elite, curItem.id);
        end
        if radio_num > 1 then
            uiItem:SetDouble(radio_num);
        end

		table.insert(self.destroyItemUI, uiItem)
	end

	local showSmallItemUisCount = #showSmallItemUis;
	for i,curItem in ipairs(extraShowSmallItemUis) do
		local node = self.awardNodes[showSmallItemUisCount+i]
		if node == nil then 
			break 
		end
		local uiItem = UiSmallItem:new({parent = node.parent})
		if curItem.cardinfo then
			uiItem:SetData(curItem.cardinfo)
			uiItem:SetCount(curItem.count)
		else
			uiItem:SetDataNumber(curItem.id, curItem.count)
		end
		uiItem:SetEnablePressGoodsTips(true)
		uiItem:SetTuiJianLab("额外");

		table.insert(self.destroyItemUI, uiItem)
	end

	local cardDataIdToObj = {}
	ObjectManager.ForEachObj(
		function(name , obj)
			local card = obj:GetCardInfo()
			if card then
				cardDataIdToObj[card.index] = obj
			end
			return true
		end
	)

	for i = 1, 3 do
		local card = cards[i]
		local node = self.herosNodes[i]
		if node == nil then break end
		if card then
			local uiItem = SmallCardUi:new({parent = node.parent, info = card, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star, SmallCardUi.SType.Level}})
			table.insert(self.destroyItemUI, uiItem)

			if card.level ~= card.oldLevel then
				node.levelUpSp:set_active(true)
			else
				node.levelUpSp:set_active(false)
			end
			local diffExp = card:GetDiffHeroExp()
			
			local hero = cardDataIdToObj[card.index]
			if hero then
				uiItem:SetLifeBar(true, hero:GetHP()/hero:GetPropertyVal(ENUM.EHeroAttribute.max_hp))
			end

			--[[
			node.progressBar:set_value(card:GetOldExpPro())
			if card.level < maxLevel and diffExp > 0 then
				uiItem:SetLevel(card.oldLevel)
				node.addExpLabel:set_text("+" .. tostring(diffExp))
				local aniData = {}
				aniData.remainAddExp = diffExp
				aniData.addRate = diffExp/timerShow
				aniData.progressBar = node.progressBar
				aniData.currExpValue = card.oldExp
				aniData.currLevelValue = card.oldLevel
				aniData.getMaxExp = function (level)
					local cfLevel = CardHuman.GetLevelConfig(card.number, level, card.config)
					if cfLevel == nil then
						return nil
					end
					return cfLevel.upexp
				end
				aniData.setLevel = function(level)
					if not level then
						level = card.level
					end
					uiItem:SetLevel(level)
				end
				aniData.getExpPro = function() return card:GetExpPro() end
				table.insert(self.progressAnimationData, aniData)
			else
				node.addExpLabel:set_active(false)
				if card.level >= maxLevel then
					node.progressBar:set_value(1)
				end
			end
			]]
		else
			node.root:set_active(false)
		end

	end

	self.closeBtn:set_on_click(self.bindfunc["OnClose"])
end

function CommonStar:TimerProgress()
	local allIsFinsih = true
	for k,v in ipairs(self.progressAnimationData) do
		if v.remainAddExp > 0 then
			allIsFinsih = false
			v.currExpValue = v.currExpValue + v.addRate
			v.remainAddExp = v.remainAddExp - v.addRate

			local maxExp
			repeat
				maxExp = v.getMaxExp(v.currLevelValue)
				if maxExp == nil then
					break
				end
				if v.currExpValue > maxExp then
					v.currLevelValue = v.currLevelValue + 1
					v.currExpValue = v.currExpValue - maxExp
					v.setLevel(v.currLevelValue)
					-- AudioManager.Play3dAudio(ENUM.EUiAudioType.ExpLvup, AudioManager.GetUiAudioSourceNode(), true)
				else
					break
				end
			until false
			if maxExp then
				v.progressBar:set_value(v.currExpValue/maxExp)
			end
		end
	end

	if allIsFinsih then
		self:TimerEnd()
	end
end

function CommonStar:TimerEnd()
	TimerManager.Remove(self.bindfunc["TimerProgress"])
	-- AudioManager.StopUiAudio(self.audio_id);
	-- AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)

	for k,v in ipairs(self.progressAnimationData) do
		v.progressBar:set_value(v.getExpPro())
		v.setLevel()
	end
	self.progressAnimationData = nil
	self.progressBarAniEnd = true
end

function CommonStar:PlayNextStarAni()
	if self.animationNode == nil then return end

	self.currentPlayIndex = self.currentPlayIndex + 1
	local nameAndSprite = self.needPlayStarAnimations[self.currentPlayIndex]

	if nameAndSprite == nil then

		if #self.progressAnimationData > 0 then
			TimerManager.Add(self.bindfunc["TimerProgress"], 1, -1)
		else
			self.progressBarAniEnd = true
		end

		return 
	end
	self.animationNode:animated_play(nameAndSprite[1])
	nameAndSprite[2]:set_sprite_name("js_xing")
end

function CommonStar:OnClose(t)
	-- local control = self.uiControl;
	if not self.progressBarAniEnd then return end

	local player = g_dataCenter.player
	if type(player.IsLevelUp) == "function" and player:IsLevelUp() then
		CommonPlayerLevelup.Start(player);
		CommonPlayerLevelup.SetFinishCallback(self.callbackFunc, self.callbackObj)
	else
		if self.callbackFunc then
			self.callbackFunc(self.callbackObj);
		end
	end

	if CommonStar.cls then
		CommonStar.cls:DestroyUi();
		CommonStar.cls = nil;
	end

	NoticeManager.Notice(ENUM.NoticeType.GetCommonHurdleBack)
end

function CommonStar:DestroyUi()

	TimerManager.Remove(self.bindfunc["TimerProgress"])
    if self.destroyItemUI then
        for k,v in ipairs(self.destroyItemUI) do
            v:DestroyUi()
        end
        self.destroyItemUI = nil
    end

	MultiResUiBaseClass.DestroyUi(self);
end


----------- ui event--------------
function CommonStar.beginAniEnd()
	--app.log("#ui#CommonStar.beginAniEnd")
	CommonStar.cls:PlayNextStarAni()
end

function CommonStar.StarAniEnd()
	--app.log("#ui#CommonStar.StarAniEnd")
	CommonStar.cls:PlayNextStarAni()
end
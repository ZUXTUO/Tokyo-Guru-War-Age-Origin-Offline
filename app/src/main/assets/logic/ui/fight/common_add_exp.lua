-- CommonAddExp = Class("CommonAddExp", UiBaseClass);

-- local timerShow = 30;
-- --------------------外部接口-------------------------
-- --player 玩家类Player  我可以通过它内部存储的老经验来做表现
-- --cards 英雄表现列表,内部全是cardhuman对象｛ CardHuman, CardHuman, CardHuman｝ 我可以通过它内部存储的老经验来做表现
-- function CommonAddExp.Start(player, cards, awards, showBk, extraAwards)
-- 	if CommonAddExp.cls == nil then
-- 		CommonAddExp.cls = CommonAddExp:new({
-- 			player=player, 
-- 			cards=cards,
--             awards = awards,
-- 			showBk=showBk,
--             extraAwards = extraAwards,
-- 			});
-- 	end
-- end


-- function CommonAddExp.SetFinishCallback(callback, obj)
-- 	if CommonAddExp.cls then
-- 		CommonAddExp.cls.callbackFunc = callback;
-- 		if CommonAddExp.cls.callbackFunc then
-- 			CommonAddExp.cls.callbackObj = obj;
-- 		end
-- 	else
-- 		app.log("类未初始化 请先调用start"..debug.traceback());
-- 	end
-- end

-- function CommonAddExp.Destroy()
-- 	if CommonAddExp.cls then
-- 		CommonAddExp.cls:DestroyUi();
-- 		CommonAddExp.cls = nil;
-- 	end
-- end

-- --------------------内部接口-------------------------

-- local _uiText =
-- {
--     [1] = '角色经验:',
--     [2] = '经验+%d',
-- }

-- local moshenrenpic = "assetbundles/prefabs/ui/image/icon/head_pic/170_440/klz_moshengren.assetbundle"

-- function CommonAddExp:Init(data)
--     --ui/level  text/final_edition_new
-- 	self.pathRes = 'assetbundles/prefabs/ui/level/ui_708_level.assetbundle'
-- 	UiBaseClass.Init(self, data);
-- end

-- function CommonAddExp:InitData(data)
-- 	UiBaseClass.InitData(self, data);

--     CommonClearing.canClose = false
-- end

-- function CommonAddExp:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
--     self.bindfunc["TimerProgress"] = Utility.bind_callback(self,self.TimerProgress)
-- end

-- function CommonAddExp:InitUI(asset_obj)
-- 	UiBaseClass.InitUI(self, asset_obj)


--     self.titleLab = ngui.find_label(self.ui, 'cont_title/lab')
--     self.levelLab = ngui.find_label(self.ui, "lab_level")
--     self.playerExpProgressBar = ngui.find_progress_bar(self.ui, 'pro_di')
--     self.goldLabel = ngui.find_label(self.ui, "sp_bk/lab")
--     self.secondTileLabel = ngui.find_label(self.ui, "sp_di2/sp_title/txt")


--     self.closeBtn = ngui.find_button(self.ui, 'btn_yellow')
--     self.fightDataBtn = ngui.find_button(self.ui, 'btn_blue')

--     self.showAwardGrid = ngui.find_grid(self.ui, "grid")
--     self.gridNodeObject = self.showAwardGrid:get_game_object()
--     self.showAwardParents = {}
--     for i = 1, 10 do
--         self.showAwardParents[i] = self.gridNodeObject:get_child_by_name("new_small_card_item" .. tostring(i))
--     end

--     self.playerLevelUpFx = self.ui:get_child_by_name("sp_di1/pro_di/fx_ui_708_level_zhandui")

--     self.showHeroParents = {}
--     for i = 1, 3 do
--         local info = {} 
--         info.parent = self.ui:get_child_by_name("sp_di2/big_card_item_80" .. tostring(i))
--         info.levelNode = info.parent:get_child_by_name("sp_level_di")
--         info.expAddLabel = ngui.find_label(info.parent, "lab_exp")
--         self.showHeroParents[i] = info
--     end

--     self:UpdateUi()
-- end

-- function CommonAddExp:UpdateUi()

--     local data = self:GetInitData()
--     if data == nil or type(data.cards) ~= "table" or type(data.player) ~= "table" then return end

--     self.secondTileLabel:set_text(_uiText[1])
--     self.levelLab:set_text("LV." .. tostring(data.player:GetLevel()))

--     local reachMaxLevel = data.player:GetLevel() >= ConfigManager.GetDataCount(EConfigIndex.t_player_level)
--     if reachMaxLevel then
--         self.playerExpProgressBar:set_value(1)
--     else
--         self.playerExpAniData = {}
--         local diffExp = data.player:GetDiffExp()
--         local oldData = data.player.oldData
--         self.playerExpAniData.remainAddExp = diffExp
--         self.playerExpAniData.addRate = diffExp/timerShow
--         self.playerExpAniData.progressBar = self.playerExpProgressBar
--         self.playerExpAniData.currExpValue = oldData.exp
--         self.playerExpAniData.currLevelValue = oldData.level
--         self.playerExpAniData.playerInfo = data.player
--         self.playerExpProgressBar:set_value(data.player:GetOldExpPro())
--     end

--     local hurdleConfig = FightScene.GetHurdleConfig()
--     if hurdleConfig then
--         local hurdleGroupConfig = ConfigManager.Get(EConfigIndex.t_hurdle_group, hurdleConfig.groupid)
--         if hurdleGroupConfig then
--             self.titleLab:set_text(tostring(hurdleGroupConfig.chapter_num) .. '  ' .. tostring(hurdleGroupConfig.chapter).."  "..tostring(hurdleConfig.index))
--         end
--     end
    
--     local goldNum = 0
--     local showSmallItemUis = {}
--     for k,v in ipairs(data.awards) do
--         if PropsEnum.IsGold(v.id) then
--             goldNum = goldNum + v.count
--         elseif PropsEnum.IsExp(v.id) or PropsEnum.IsHeroExp(v.id) then
--         else
--             table.insert(showSmallItemUis, v)
--         end
--     end

--     PublicFunc.ConstructCardAndSort(showSmallItemUis)

--     local extraShowSmallItemUis = {}
--     for k,v in ipairs(data.extraAwards) do
--         if PropsEnum.IsGold(v.id) then
--             goldNum = goldNum + v.count
--         elseif PropsEnum.IsExp(v.id) or PropsEnum.IsHeroExp(v.id) then
--         else
--             table.insert(extraShowSmallItemUis, v)
--         end
--     end
--     self.goldLabel:set_text(tostring(goldNum))
--     self.destroyItemUI = {}
--     local showSmallItemUisCount = 0;
--     for i,curItem in ipairs(showSmallItemUis) do
--         local parent = self.showAwardParents[i]

--         local uiItem = UiSmallItem:new({parent = parent})
--         uiItem:SetEnablePressGoodsTips(true)
--         if curItem.cardinfo then
--             uiItem:SetData(curItem.cardinfo)
--             uiItem:SetCount(curItem.count)
--         else
--             uiItem:SetDataNumber(curItem.id, curItem.count)
--         end
--         table.insert(self.destroyItemUI, uiItem)
--         local radio_num = 1;
--         if hurdleConfig.hurdle_type == 0 then
--             radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_normal, curItem.id);
--         else
--             radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_elite, curItem.id);
--         end
--         if radio_num > 1 then
--             uiItem:SetDouble(radio_num);
--         end
--         showSmallItemUisCount = showSmallItemUisCount + 1;
--     end
--     for i,curItem in ipairs(extraShowSmallItemUis) do
--         local parent = self.showAwardParents[showSmallItemUisCount+i]

--         local uiItem = UiSmallItem:new({parent = parent})
--         uiItem:SetDataNumber(curItem.id, curItem.count)
--         uiItem:SetEnablePressGoodsTips(true)
--         uiItem:SetTuiJianLab("额外");
--         table.insert(self.destroyItemUI, uiItem)
--         -- local radio_num = 1;
--         -- if hurdleConfig.hurdle_type == 0 then
--         --     radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_normal, curItem.id);
--         -- else
--         --     radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.hurdle_elite, curItem.id);
--         -- end
--         -- if radio_num > 1 then
--         --     uiItem:SetDouble(radio_num);
--         -- end
--     end

--     self.progressBarAniData = {}
--     for i = 1, 3 do
--         local card = data.cards[i]
--         local info = self.showHeroParents[i]
--         if info == nil then break end
--         if card then
--             local uiItem = SmallCardUi:new({parent = info.parent, info = card, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star, SmallCardUi.SType.Level}})
--             table.insert(self.destroyItemUI, uiItem)

--             --app.log("#hyg# cards " .. tostring(card.name) .. ' newlevel = ' .. card.level .. ' oldlevel=' .. card.oldLevel .. ' ' .. info.levelNode:get_parent():get_name())
--             if card.level ~= card.oldLevel then
--                 info.levelNode:set_active(true)
--             else
--                 info.levelNode:set_active(false)
--             end

--             local diffExp = card:GetDiffHeroExp()
--             if diffExp > 0 then
--                 info.expAddLabel:set_text(string.format(_uiText[2], diffExp))
--             else
--                 info.expAddLabel:set_active(false)
--             end
--             uiItem:SetLifeBar(true, card:GetOldExpPro(), true, 6)

--     --     local levelUpFx = node:get_child_by_name('fx_ui_708_level_levelup_modify')
--     --     levelUpFx:set_active(false)
--     --     self:AdjustBorderFxScale(levelUpFx)

--             local aniData = {}
--             aniData.remainAddExp = diffExp
--             aniData.addRate = diffExp/timerShow
--             aniData.smallCardItem = uiItem
--             aniData.currExpValue = card.oldExp
--             aniData.currLevelValue = card.oldLevel
--             aniData.cardInfo = card
--             --aniData.levelUpFx = levelUpFx

--             self.progressBarAniData[#self.progressBarAniData + 1] = aniData
--         else
--             info.parent:set_active(false)
--         end
--     end

--     if table.get_num(self.progressBarAniData) > 0 then
--         self.audio_id = AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpLoop);
--         self.tmProgress = timer.create(self.bindfunc["TimerProgress"], 1, -1);
--     end
    
--     self.closeBtn:set_on_click(self.bindfunc["OnClose"])
--     self.fightDataBtn:set_active(false)

--     --播放战斗改变特效
--     if g_dataCenter.hurdle.showFightValue then
--         g_dataCenter.hurdle.showFightValue = false;
--         local value = g_dataCenter.hurdle.newFightValue;
--         local old_value = g_dataCenter.hurdle.oldFightValue;
--         FightValueChangeUI.ShowChange(ENUM.FightingType.Team, value, old_value)
--     end
-- end

-- -- 调整特效缩放比适应不同设备分辨率
-- function CommonAddExp:AdjustBorderFxScale(uiCont)
--     local obj = uiCont:get_child_by_name("fx_ui_708_level_levelup_modify/fx_ui_708_level_levelup_modify");
--     PublicFunc.SetScaleByScreenRate(obj:get_child_by_name("fx_ui_708_level_levelup_modify1"));
--     PublicFunc.SetScaleByScreenRate(obj:get_child_by_name("fx_ui_708_level_levelup_modify2"));
--     PublicFunc.SetScaleByScreenRate(obj:get_child_by_name("fx_ui_708_level_levelup_modify3"));
--     PublicFunc.SetScaleByScreenRate(obj:get_child_by_name("fx_ui_708_level_levelup_modify4"));
-- end

-- function CommonAddExp:OnClose(t)

-- 	if self.tmProgress then
-- 		self:TimerEnd();
-- 		return;
-- 	end

--     local data = self:GetInitData()

--     local isEnterLevelUp = false

-- 	if data and type(data.player) == "table" then

-- 		if type(data.player.IsLevelUp) == "function" and data.player:IsLevelUp() then
-- 			CommonPlayerLevelup.Start(data.player);
--             CommonPlayerLevelup.SetFinishCallback(self.callbackFunc, self.callbackObj)
--             isEnterLevelUp = true
-- 		end
-- 	end

--     if not isEnterLevelUp then
-- 	    if self.callbackFunc then
-- 		    self.callbackFunc(self.callbackObj);
-- 	    end

--         self.callbackFunc = nil
--         self.callbackObj = nil
--     end

--     CommonAddExp.Destroy()

--     NoticeManager.Notice(ENUM.NoticeType.GetCommonAddExpBack)
-- end

-- function CommonAddExp:TimerProgress()

--     if self.progressBarAniData == nil then return end

--     local allIsFinsih = true

--     for k,v in pairs(self.progressBarAniData) do
--         if v.remainAddExp > 0 then
--             allIsFinsih = false
--             v.currExpValue = v.currExpValue + v.addRate
--             v.remainAddExp = v.remainAddExp - v.addRate
--             local cfLevel = nil
--             repeat
--                 cfLevel = CardHuman.GetLevelConfig(v.cardInfo.number, v.currLevelValue, v.cardInfo.config)
--                 if cfLevel == nil then
--                     --self:OnClose()
--                     break
--                 end

--                 if v.currExpValue >= cfLevel.upexp then
--                     v.currLevelValue = v.currLevelValue + 1
--                     v.currExpValue = v.currExpValue - cfLevel.upexp
--                     if v.levelUpFx then
--                         v.levelUpFx:set_active(false)
--                         v.levelUpFx:set_active(true)
--                     end
--                     AudioManager.Play3dAudio(ENUM.EUiAudioType.ExpLvup, AudioManager.GetUiAudioSourceNode(), true)
--                 else
--                     break
--                 end

--             until false;

--             local progressValue = 1
--             if cfLevel then
--                 progressValue = v.currExpValue/cfLevel.upexp
--                 --app.log('============ ' .. tostring(v.currExpValue) .. ' ' .. tostring(v.currExpValue/cfLevel.upexp))
--             end
--             v.smallCardItem:SetLifeBar(true, progressValue)
--         end
--     end

--     if self.playerExpAniData then
--         local aniData = self.playerExpAniData
--         if aniData.remainAddExp > 0 then
--             allIsFinsih = false

--             aniData.currExpValue = aniData.currExpValue + aniData.addRate
--             aniData.remainAddExp = aniData.remainAddExp - aniData.addRate
--             local levelConfig = nil
--             repeat
--                 levelConfig = ConfigManager.Get(EConfigIndex.t_player_level,aniData.currLevelValue);
--                 if levelConfig == nil then
--                     --self:OnClose()
--                     break
--                 end

--                 if aniData.currExpValue >= levelConfig.exp then
--                     aniData.currLevelValue = aniData.currLevelValue + 1
--                     aniData.currExpValue = aniData.currExpValue - levelConfig.exp
-- 		    --AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUp)
--                     self.playerLevelUpFx:set_active(false)
--                     self.playerLevelUpFx:set_active(true)
--                 else
--                     break
--                 end
--             until false;

--             local progressValue = 1
--             if levelConfig then
--                 progressValue = aniData.currExpValue/levelConfig.exp
--             end
--             aniData.progressBar:set_value(progressValue)
--         end
--     end

--     if allIsFinsih then
--         self:TimerEnd()
--     end
-- end

-- function CommonAddExp:TimerEnd()

--     if self.tmProgress then
-- 	    AudioManager.StopUiAudio(self.audio_id);
--         AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd);
-- 	    timer.stop(self.tmProgress)
-- 	    self.tmProgress = nil;
--     end

--     if self.progressBarAniData then
--         for k,v in pairs(self.progressBarAniData) do
--             v.smallCardItem:SetLifeBar(true, v.cardInfo:GetExpPro())
--         end
--         self.progressBarAniData = nil
--     end

--     local aniData = self.playerExpAniData
--     if aniData then
--         aniData.progressBar:set_value(aniData.playerInfo:GetExpPro())
--         self.playerExpAniData = nil
--     end
-- end

-- function CommonAddExp:DestroyUi()
--     if self.destroyItemUI then
--         for k,v in ipairs(self.destroyItemUI) do
--             v:DestroyUi()
--         end
--         self.destroyItemUI = nil
--     end

--     UiBaseClass.DestroyUi(self)
-- end


ChengJianRobberyFightManager = Class("ChengJianRobberyFightManager", EmbattleAutoFightManager)


function ChengJianRobberyFightManager.InitInstance()

    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single

	EmbattleAutoFightManager.InitInstance(ChengJianRobberyFightManager)

    --ChengJianRobberyFightManager._OnResponseRobberyTimeOut = Utility.bind_callback(ChengJianRobberyFightManager, ChengJianRobberyFightManager.OnResponseRobberyTimeOut)
    --PublicFunc.msg_regist(msg_city_building.gc_robbyer_time_out, ChengJianRobberyFightManager._OnResponseRobberyTimeOut)
    ChengJianRobberyFightManager.sceneLoadComplete = false
    ChengJianRobberyFightManager.reciveRobberyTimeOut = false
    ChengJianRobberyFightManager.beginSettlement = false
    ChengJianRobberyFightManager.timeoutPopCallback = nil
    ChengJianRobberyFightManager.hasFightOver = false

	return ChengJianRobberyFightManager;
end

function ChengJianRobberyFightManager:OnResponseRobberyTimeOut()
    --app.log('ChengJianRobberyFightManager:OnResponseRobberyTimeOut')
    if self.sceneLoadComplete == false then
        self.reciveRobberyTimeOut = true
    elseif self.beginSettlement == true then
        self.reciveRobberyTimeOut = true
        local crmgr = CityRobberyMgr:GetInst()
        --crmgr:SetTipRobberyTimeOut(true)
        crmgr:ClearTarget()
    else
        self:ShowRobberyTimeOut()
    end
end

function ChengJianRobberyFightManager:GetSurviveHeroCountAndDeadHeroid(camp_flag)

    local hero_list = g_dataCenter.fight_info:GetHeroList(camp_flag)
    local count = 0
    local deadHero = {}
	for k, v in pairs(hero_list) do
		local obj = ObjectManager.GetObjectByName(v)
		if obj ~= nil then
            if obj:IsDead() then
                table.insert(deadHero, obj:GetUUID())
            else
                count = count + 1
            end
		end
	end

    local delayHeroList = g_dataCenter.fight_info:GetDelayLoadHeroList(camp_flag)
    if delayHeroList ~= nil then
        count = count + #delayHeroList
    end

    return count, deadHero
end

function ChengJianRobberyFightManager:CloseFight()
    self.fightOver = true;
    ObjectManager.EnableAllAi(false)
	AudioManager.SetAudioListenerFollowObj(false);
	AudioManager.Stop(nil, true);

    local mainui = GetMainUI()
    if mainui then
        mainui:OnFightOver()
    end
end

function ChengJianRobberyFightManager:FightOver()

    if self.hasFightOver == true then
        return;
    end

    self.hasFightOver = true;

    self:CloseFight()

    self.beginSettlement = true

    local mySurviveCount,myDeadHeroid = self:GetSurviveHeroCountAndDeadHeroid(g_dataCenter.fight_info.single_friend_flag)
    local otherSurviveCount,OtherdeadHeroid  = self:GetSurviveHeroCountAndDeadHeroid(g_dataCenter.fight_info.single_enemy_flag)

--    mySurviveCount = 3
--    otherSurviveCount = 0

    --app.log('mySurviveCount ' .. mySurviveCount .. ' otherSurviveCount ' .. otherSurviveCount)

    local crmgr = CityRobberyMgr.GetInst()
    local robbingBid = crmgr:GetIsRobbingBuildingID()

    for k,v in ipairs(myDeadHeroid) do
        crmgr:AddHasDeadHero(v)
    end
    
    self.loadingId = GLoading.Show(GLoading.EType.ui)
    if robbingBid ~= nil then
        self.callback = Utility.bind_callback(self,ChengJianRobberyFightManager.OnEndRobberyFightRet)
        --msg_city_building.cg_end_robbery_fight(robbingBid, 1, 0, self.callback)
        msg_city_building.cg_end_robbery_fight(robbingBid, mySurviveCount, otherSurviveCount, myDeadHeroid, self.callback)
    else
        app.log('robbingBid == nil' .. debug.traceback())
    end
end

ChenJianShowExtraCallBack = {
    obj = nil,
    callBack = nil,
    callBackFun = function(param)
        if param.callBack ~= nil then
            param.callBack(param.obj)
        end
    end
}

function ChengJianRobberyFightManager.OnEndRobberyFightShowSettlement(ret, sr, obj,callback)

    local crmgr = CityRobberyMgr.GetInst()
    local robbingBid = crmgr:GetIsRobbingBuildingID()

    crmgr:SetIsRobbingBuildingID(nil)

--    if extResource > 0 then
--        HintUI.SetAndShow(EHintUiType.zero, "Robbery all building,get extera resource:" .. extResource)
--        crmgr:ClearTarget()
--    end
    --sr.extraResource = 10
    if ret == 0 then 
        crmgr:AddHasRobberyBuildingID(robbingBid)
    end

    if CityRobberyMgr.GetInst():GetTargetPlayer() == nil then
        obj.timeoutPopCallback = Utility.bind_callback(obj,ChengJianRobberyFightManager.onTimeoutPopCallback)
        HintUI.SetAndShow(EHintUiType.one, gs_misc['str_15'], {str = gs_misc['ok'], func = obj.timeoutPopCallback})
        return
    end

    if ret == 0 or ret == 1 then

        local settlementData = {}
        local crmgr = CityRobberyMgr.GetInst()
        local fightHero = crmgr:GetCurrentBothSideFightHero()

        local myPlayer = g_dataCenter.player
        local myCards = {}
        local card = nil

        local targetPlayer = crmgr:GetTargetPlayer()
        local targetCards = {}
        if fightHero ~= nil then
            for k,cardIndex in ipairs(fightHero.mySide) do
                card = myPlayer.package:find_card(ENUM.EPackageType.Hero, cardIndex)
                if card ~= nil then
                    table.insert(myCards, card)
                end
            end

            for k,cardIndex in ipairs(fightHero.targetSide) do
                card = targetPlayer.package:find_card(ENUM.EPackageType.Hero, cardIndex)
                if card ~= nil then
                    table.insert(targetCards, card)
                end
            end
        end
        
        settlementData.battle = {

            battleName = gs_misc['robbery_resource_name'], 
            players = 
            {
                left = {
                    player = myPlayer,
                    cards = myCards,
                },
                right = {
                    player = targetPlayer,
                    cards = targetCards,
                },
            },
            fightResult = 
            {
                --isWin = win,
                leftCount = sr.mySideSurvive,
                rightCount = sr.otherSideSurvive,
                leftEquipSouls = nil,
                RightEquipSouls = nil,
            }
        }

        if ret == 0 then

            settlementData.battle.fightResult.isWin = true
            local windes = {}
            for i = 1,3 do
                windes[i] = string.format(gs_misc['str_37'], i)
            end
            local winResult = {}
            for i = 1,sr.star do
                winResult[i] = 1
            end

            settlementData.star = {
                star = sr.star,
                finishConditionInfex = winResult,
                conditionDes = windes,
                showTitle = true,
                isDestroy = nil,
            }

            if #sr.robberyItem > 0 then
                settlementData.awards = {
                    awardsList = {
                        --{dataid='0', id=sr.robberyItemID, count = sr.robberyItemNum}
                    },
                }
                for k,v in ipairs(sr.robberyItem) do
                    table.insert(settlementData.awards.awardsList, {dataid='0', id=v.id, count = v.count})
                end
                
            end
        else
            settlementData.battle.fightResult.isWin = false
--            settlementData.jump = {
--                jumpFunctionList = {ENUM.ELeaveType.Leave},
--                isRelive = false,
--            }
        end

        if fightHero == nil then
            settlementData.battle = nil
        end

        --if callback ~= nil then
            --CommonClearing.SetFinishCallback(callback, obj)
            CommonClearing.SetFinishCallback(function()
                
                if sr.extraResource > 0 then
                    ChenJianShowExtraCallBack.obj = obj
                    ChenJianShowExtraCallBack.callBack = callback
                    HintUI.SetAndShow(EHintUiType.one, string.format(gs_misc['str_9'], sr.extraResource),
                    {str = gs_misc['str_32'], func = Utility.create_callback(ChenJianShowExtraCallBack.callBackFun, ChenJianShowExtraCallBack)})
                else
                    if callback ~= nil then
                        callback(obj)
                    end
                end

             end)
        --end
        CommonClearing.Start(settlementData)
    end

end

function ChengJianRobberyFightManager:OnEndRobberyFightRet(ret, sr)--bid, robberySource, extResource)
    --app.log('OnEndRobberyFightRet ' .. table.tostring(sr))
    GLoading.Hide(GLoading.EType.ui, self.loadingId)

    if ret == 0 or ret == 1 then
        ChengJianRobberyFightManager.OnEndRobberyFightShowSettlement(ret, sr, self, ChengJianRobberyFightManager.OnSettlementEnd)
    elseif ret == 2 then 
        local crmgr = CityRobberyMgr.GetInst()
        self:ShowRobberyTimeOut()
        local crmgr = CityRobberyMgr:GetInst()
        crmgr:ClearTarget()
        crmgr:SetTipRobberyTimeOut(nil)
    else
        app.log('OnEndRobberyFightRet failed:' .. ret)
    end
end

function ChengJianRobberyFightManager:OnSettlementEnd()
    SceneManager.PopScene()
end

function ChengJianRobberyFightManager:Destroy()
    
    EmbattleAutoFightManager.Destroy(self)

    Utility.unbind_callback(self, self.callback)

    --PublicFunc.msg_unregist(msg_city_building.gc_robbyer_time_out, self._OnResponseRobberyTimeOut)
    --Utility.unbind_callback(self, self.OnResponseRobberyTimeOut)

    if self.timeoutPopCallback ~= nil then
        Utility.unbind_callback(self, self.timeoutPopCallback)
    end
end

function ChengJianRobberyFightManager:LoadHero()

    EmbattleAutoFightManager.LoadHero(self)

    self.sceneLoadComplete = true

    if self.reciveRobberyTimeOut == true then
        --app.log('in loading time out')
        self:ShowRobberyTimeOut()
    end
end

function ChengJianRobberyFightManager:ShowRobberyTimeOut()
    self:CloseFight()

    self.timeoutPopCallback = Utility.bind_callback(self,ChengJianRobberyFightManager.onTimeoutPopCallback)
    HintUI.SetAndShow(EHintUiType.one, gs_misc['str_15'], {str = gs_misc['ok'], func = self.timeoutPopCallback})
end

function ChengJianRobberyFightManager:onTimeoutPopCallback()
    local crmgr = CityRobberyMgr:GetInst()
    crmgr:ClearTarget()

    SceneManager.PopScene()
end

function ChengJianRobberyFightManager:Update(dt)
    CityRobberyMgr.GetInst():Update(dt)
end

function ChengJianRobberyFightManager:GetUIAssetFileList(out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTeamCanChangeRes, out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetOptionTipRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetZouMaDengRes(), out_file_list)
    FightManager.AddPreLoadRes(NewFightUiCount.GetResList(), out_file_list)
end

function ChengJianRobberyFightManager:OnUiInitFinish()
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsShowStarTip = (cf.is_show_star_tip == 1)
    GetMainUI():InitTimer()
    GetMainUI():InitTeamCanChange(false)
    GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)

    self:StartTime();
    NewFightUiCount.Start()
    GetMainUI():InitZouMaDeng()

    GetMainUI():InitTouchMoveCamera()
end
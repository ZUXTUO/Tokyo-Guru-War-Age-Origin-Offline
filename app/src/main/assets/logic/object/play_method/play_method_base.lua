script.run("logic/scene/fight_scene_management/fight_startup_inf.lua");
script.run("logic/scene/fight_scene_management/fight_type_def.lua");
PlayMethodBase = Class("PlayMethodBase");

EPlayMethodLeaveType = 
{
    success = 0,    --战斗成功退出
    failed = 1,     --战斗失败退出
    exit = 2,       --中途退出
}

function PlayMethodBase:Init(data)
	self:ClearData(data);
end

function PlayMethodBase:ClearData(data)
	--self.hurdle_id = nil;
    self:__SetLevelIndex(nil)
	self.fs = FightStartUpInf:new()
	self.extParam = nil;
	self.play_method_id = nil;
    self.timeFinishNumber = 0;
end

function PlayMethodBase:SetData(data)
    self.curtime = system.time();
    -- app.log("xxxxxxxxxxxxxxxx"..table.tostring(data));

    self.preTime = tonumber(data.preTime);
    self.nextTime = tonumber(data.nextTime);
    self.continueTime = tonumber(data.continueTime);
    self.finishNumer = data.finishNumer;
    self.preOperator = tonumber(data.preOperator);
    self.operatorInterval = tonumber(data.operatorInterval);
    if data.timeFinishNumber then
        self.timeFinishNumber = tonumber(data.timeFinishNumber);
    else
        self.timeFinishNumber = 0;
    end
    --self:ShowLogTime(self.curtime,"当前时间==");
    --self:ShowLogTime(self.preTime,"上次开启时间==");
    --self:ShowLogTime(self.nextTime,"下次开启时间==");
    --self:ShowLogTime(self.preOperator,"上次操作时间==");

end

function PlayMethodBase:ShowLogTime(time,str)
    local year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(time)
    app.log(str..year.."年"..month.."月"..day.."日"..hour.."时"..min.."分"..sec.."秒");
end


local Etype = 
{
    Error = 0,
    Open = 1,
    Close = 2,
}

function  PlayMethodBase:Analyze(curtime)
    curtime = curtime or system.time();
    if not self.preTime then
        --app.log("xxxxxxxxx");
        return Etype.Error;
    end

    if self.preTime > curtime then
        --app.log(tostring(self.preTime));
        --app.log(tostring(curtime));
        --app.log("上一次开启时间===="..tostring(self.preTime).."大于当前时间==="..tostring(curtime));
        return Etype.Error;
    end
    if self.preTime + self.continueTime >= curtime then
        --计算还有多久结束
        local overtime = self.preTime + self.continueTime - curtime;
        return Etype.Open,overtime,self.timeFinishNumber;
    elseif self.preTime + self.continueTime < curtime then
        --app.log("活动已结束");
        if curtime < self.nextTime then
            --计算活动还有多久开始
            local opentime = self.nextTime - curtime;
            return Etype.Close,opentime,self.timeFinishNumber;
        else
           -- -app.log("当前时间超过下一次开启时间");
            return Etype.Error;
        end
    end
    app.log("活动分析，未知原因错误");
    return Etype.Error;
end


function PlayMethodBase:SetPlayMethod(play_method_id)
	self.play_method_id = play_method_id;
	self.fs:SetPlayMethod(play_method_id);
end

function PlayMethodBase:SetLevelIndex(hurdle_id)
	self:__SetLevelIndex(hurdle_id)
	self.fs:SetLevelIndex(hurdle_id);
end

function PlayMethodBase:__SetLevelIndex(hurdle_id)
    --app.log("PlayMethodBase:__SetLevelIndex hurdle_id="..tostring(hurdle_id).." traceback="..debug.traceback())
    self.hurdle_id = hurdle_id
end

function PlayMethodBase:AddFightPlayer(camp_flag, player, package, player_type, team,ext)
	self.fs:AddFightPlayer(camp_flag,player,package,player_type,team,ext);
end

function PlayMethodBase:ClearFightPlayer()
    self.fs:ClearFightPlayer()
end

function PlayMethodBase:SetExtParm(param)
	self.extParam = param;
	self.fs:SetExtParm(param);
end

function PlayMethodBase:Tostring()
	local param = {};
	param[1] = tostring(self.hurdle_id);
	return param;
end

function PlayMethodBase:BeginGame(result, param)
    local hurdle_id = param[1];
	if tostring(self.hurdle_id) == tostring(hurdle_id) then
        PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
        SceneManager.PushScene(FightScene,self.fs);
    else
    	app.log("存储关卡id("..tostring(self.hurdle_id)..")与当前关卡id("..tostring(hurdle_id)..")不符。");
	end
end

function PlayMethodBase:EndGame()
	local star = FightRecord.GetStar();
	local isWin = 1;
	if star > 0 then
		isWin = 0;
	end
    local param = {FightRecord.GetLevelID(),}
	msg_activity.cg_leave_activity(self.play_method_id,isWin,param);
end

function PlayMethodBase:_GameResult(isWin, awards,  param)
    local data = {};
    if isWin == EPlayMethodLeaveType.success then
        app.log(string.format("isWin=%s,param=%s,hurdle_id=%s,",tostring(isWin),table.tostring(param),tostring(self.hurdle_id)))
        local cfHurlde = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
        local defTeam = g_dataCenter.player:GetDefTeam();
        for k, v in pairs(awards) do
            if PropsEnum.IsVaria(v.id) then
                if PropsEnum.IsExp(v.id) then
                    data.addexp = data.addexp or {};
                    data.addexp.player = g_dataCenter.player;
                elseif PropsEnum.IsHeroExp(v.id) then
                    local cf = ConfigManager.Get(EConfigIndex.t_drop_something,cfHurlde.pass_award);
                    if cf then
                        local list = {};
                        for k, v in pairs(cf) do
                            if PropsEnum.IsHeroExp(v.goods_id) then
                                data.addexp = data.addexp or {};
                                data.addexp.cards = data.addexp.cards or {};
                                --等于0是将所有英雄加经验
                                if v.param == 0 then
                                    for i = 1, #defTeam do
                                        local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[i]);
                                        if hero then
                                            table.insert(data.addexp.cards, hero);
                                        end
                                    end
                                else
                                    local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[v.param]);
                                    if hero then
                                        table.insert(data.addexp.cards, hero);
                                    end
                                end
                            end
                        end
                    end
                else
                    data.awards = data.awards or {};
                    data.awards.awardsList = data.awards.awardsList or {}
                    table.insert(data.awards.awardsList, v);    
                end
            else
                data.awards = data.awards or {};
                data.awards.awardsList = data.awards.awardsList or {}
                table.insert(data.awards.awardsList, v);
            end
        end
    else
        data.jump = 
        {
            jumpFunctionList = {ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp},
        }
    end
    return data;
end

function PlayMethodBase:GameResult(isWin, awards,  param)
    
    if isWin == EPlayMethodLeaveType.success or isWin == EPlayMethodLeaveType.failed then
        local data = self:_GameResult(isWin, awards,  param);
        CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
        CommonClearing.Start(data);
    end
end

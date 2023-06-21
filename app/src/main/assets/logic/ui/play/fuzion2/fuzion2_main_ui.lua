Fuzion2MainUI = Class("Fuzion2MainUI", UiBaseClass);

local _local = {}
_local.CountDown = 20 -- 倒计时匹配时间

function Fuzion2MainUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fuzion/ui_2901_fuzion.assetbundle";
    UiBaseClass.Init(self, data);
end

function Fuzion2MainUI:InitData(data)
    msg_daluandou2.cg_request_my_daluandou2_data()
    UiBaseClass.InitData(self, data);
end

function Fuzion2MainUI:Restart(data)
    msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_fuzion2);
    if UiBaseClass.Restart(self, data) then
    end
end

function Fuzion2MainUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_change_team"] = Utility.bind_callback(self, self.on_change_team);
    self.bindfunc["on_start"] = Utility.bind_callback(self, self.on_start);
	self.bindfunc["gc_start_match"] = Utility.bind_callback(self, self.gc_start_match);
    self.bindfunc["gc_activity_config"] = Utility.bind_callback(self, self.gc_activity_config);
    self.bindfunc["TimerUpdateCoolTime"] = Utility.bind_callback(self, self.TimerUpdateCoolTime);
    self.bindfunc["TimerUpdateActivityTime"] = Utility.bind_callback(self, self.TimerUpdateActivityTime);
end

function Fuzion2MainUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_daluandou2.gc_start_match,self.bindfunc["gc_start_match"]);
    PublicFunc.msg_regist(msg_activity.gc_activity_config,self.bindfunc["gc_activity_config"]);
end

function Fuzion2MainUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_daluandou2.gc_start_match,self.bindfunc["gc_start_match"]);
    PublicFunc.msg_unregist(msg_activity.gc_activity_config,self.bindfunc["gc_activity_config"]);
end

function Fuzion2MainUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.btnStart = ngui.find_button(self.ui,"down_other/panel/animation/btn");
    self.btnStart:set_on_click(self.bindfunc["on_start"])
    --self.redPoint = ngui.find_sprite(self.ui,"down_other/animation/btn/animation/sp_point");
    -- self.btnChangeTeam = ngui.find_button(self.ui,"centre_other/animation/btn_136x54");
    -- self.btnChangeTeam:set_on_click(self.bindfunc["on_change_team"]);

    self.labAwardTimes = ngui.find_label(self.ui,"down_other/animation/lab");
    -- self.labTime = ngui.find_label(self.ui,"centre_other/animation/sp_di/lab_time");
    self.labOpenTime = ngui.find_label(self.ui,"down_other/animation/lab_time");

    -- self.spCoolTime = ngui.find_sprite(self.ui,"down_other/animation/sp_clock");
    -- self.labCoolTime = ngui.find_label(self.ui,"down_other/animation/sp_clock/lab_time");

    self.teamUi = {};
    for i=1,3 do
        self.teamUi[i] = {};
        local obj = self.ui:get_child_by_name("centre_other/animation/cont_big_head_item/cont_big_item"..i);
        self.teamUi[i].obj = UiBigCard:new({parent=obj,
            infoType = 1,
            showStar = false,
            showLvl = false,
            showFight = false,
            useWhiteName = true});
        self.teamUi[i].obj:SetCallback(self.bindfunc["on_change_team"],i);
        self.teamUi[i].obj:SetTeamPos(i);
    --     self.teamUi[i].labFightPower = ngui.find_label(self.ui,"down_other/animation/sp_bk/cont"..i.."/lab");
    --     local obj = self.ui:get_child_by_name("down_other/animation/sp_bk/cont"..i.."/new_small_card_item");
    --     local data = {};
    --     data.parent = obj;
    --     data.stypes={
    -- 		SmallCardUi.SType.Texture,-- 头像
    -- 		SmallCardUi.SType.Level,-- 等级
    -- 		SmallCardUi.SType.Restrait,-- 克制图标
    -- 		SmallCardUi.SType.Star,-- 星级
    -- 		SmallCardUi.SType.Qh,-- 强化等级
    -- 		SmallCardUi.SType.Rarity,-- 品质
    --     };
    --     self.teamUi[i].card = SmallCardUi:new(data);
    --     self.teamUi[i].card:SetCallback(self.bindfunc["on_change_team"]);
    end

    self:UpdateUi();
    self:UpdateActivityTime();
end

function Fuzion2MainUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    local curTimes = g_dataCenter.fuzion2:GetTimes();
    local totalTimes = g_dataCenter.fuzion2.totalCnt;
    self.labAwardTimes:set_text("挑战次数: "..math.max(0, curTimes).."/"..totalTimes);
    
    -- local isShowRedPoint = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion2]:IsOpen()
    -- if self.redPoint then
    --     self.redPoint:set_active(isShowRedPoint)
    -- end

    self:UpdateTeamUI();
    self:TimerUpdateCoolTime();
end

function Fuzion2MainUI:UpdateTeamUI()
    local defTeam = g_dataCenter.player:GetTeam(ENUM.ETeamType.fuzion2) or {};
    if Utility.isEmpty(defTeam) then
    
        local _team = PublicFunc.CreateSendTeamData(ENUM.ETeamType.fuzion2, g_dataCenter.player:GetDefTeam())

        msg_team.cg_update_team_info(_team);
    else
        for i=1,3 do
            local card = g_dataCenter.package:find_card(1,defTeam[i]);
            self.teamUi[i].obj:SetData(card,ENUM.ETeamType.fuzion2);
            -- self.teamUi[i].obj:SetNumber("dld_shunxu"..i);
            -- if card then
                -- self.teamUi[i].labFightPower:set_text("战力"..card:GetFightValue());
            -- end
        end
    end
end


function Fuzion2MainUI:UpdateSceneInfo(info_type)
    if ENUM.EUPDATEINFO.team == info_type then
        self:UpdateTeamUI();
    end
end

function Fuzion2MainUI:TimerUpdateCoolTime()
    local beginTime = g_dataCenter.fuzion2:GetMyData().lastFightStartTime or 0;
    local passTime = system.time() - beginTime;
    local cfg = ConfigManager.Get(EConfigIndex.t_activity_time, MsgEnum.eactivity_time.eActivityTime_fuzion2);
    local coolTime = cfg.relative - passTime;
    if coolTime > 0 then
        -- self.spCoolTime:set_active(true);
        -- self.labCoolTime:set_text(PublicFunc.FormatLeftSeconds(coolTime,false));
        if self.coolTimeTimerId == nil then
            self.coolTimeTimerId = timer.create(self.bindfunc["TimerUpdateCoolTime"],1000,-1);
        end
    else
        -- self.spCoolTime:set_active(false);
        -- self.labCoolTime:set_text("");
        if self.coolTimeTimerId then
            timer.stop(self.coolTimeTimerId);
            self.coolTimeTimerId = nil;
        end
    end
end

function Fuzion2MainUI:UpdateActivityTime()
    if not self.ui then return end;
    local openTime = g_dataCenter.fuzion2.preTime or 0;
    local str = "";
    if openTime == 0 then
        str = "全天开放";
    else
        local year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(openTime);
        local strOpenTime = string.format("%02d:%02d",hour,min);
        local closeTime = openTime+(g_dataCenter.fuzion2.continueTime or 0);
        app.log("#lhf#continueTime:"..tostring(continueTime));
        year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(closeTime);
        local strCloseTime = string.format("%02d:%02d",hour,min);
        str = "每日"..strOpenTime.."-"..strCloseTime.."开启";
    end
    self.labOpenTime:set_text(str);

    -- self:TimerUpdateActivityTime();
end

-- function Fuzion2MainUI:TimerUpdateActivityTime()
--     local state,time = g_dataCenter.fuzion2:Analyze();
--     if state == 1 then
--         -- 开启
--         year,month,day,hour,min,sec = TimeAnalysis.ConvertToYearMonDay(time);
--         self.labTime:set_text(string.format("%02d:%02d:%02d",hour,min,sec));
--         if self.activityTimeTimerId == nil then
--             self.activityTimeTimerId = timer.create(self.bindfunc["TimerUpdateActivityTime"],1000,-1);
--         end
--     else
--         self.labTime:set_text("未开启");
--         if self.activityTimeTimerId then
--             timer.stop(self.activityTimeTimerId);
--             self.activityTimeTimerId = nil;
--         end
--     end
-- end

function Fuzion2MainUI:DestroyUi()
    if self.coolTimeTimerId then
        timer.stop(self.coolTimeTimerId);
        self.coolTimeTimerId = nil;
    end
    if self.activityTimeTimerId then
        timer.stop(self.activityTimeTimerId);
        self.activityTimeTimerId = nil;
    end
    UiBaseClass.DestroyUi(self);
end

function Fuzion2MainUI:on_change_team()
    local data = {
        teamType = ENUM.ETeamType.fuzion2,
        heroMaxNum = 3,
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function Fuzion2MainUI:on_start()
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end

    local beginTime = g_dataCenter.fuzion2:GetMyData().lastFightStartTime;
    if beginTime == nil then beginTime = 20 end
    local passTime = system.time() - beginTime;
    local cfg = ConfigManager.Get(EConfigIndex.t_activity_time, MsgEnum.eactivity_time.eActivityTime_fuzion2);
    local coolTime = cfg.relative - passTime;
    if coolTime > 0 and g_dataCenter.gmCheat:getPlayLimit() then
        FloatTip.Float("冷却中");
        return;
    end
    -- self.uix = Fuzion2RankUI:new();
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.fuzion2);
    if team and #team == 3 then
        msg_daluandou2.cg_start_match()
    else
        if Utility.getTableEntityCnt(team or {}) < 1 then
            FloatTip.Float("至少需要有1名上阵英雄");
            return;
        end
        local btn1 = {};
        btn1.str = "更换阵容";
        btn1.func = function ()
            self:on_change_team();
        end
        local btn2 = {};
        btn2.str = "继续匹配";
        btn2.func = function ()
            msg_daluandou2.cg_start_match()
        end
        HintUI.SetAndShow(2, "当前阵容未满员，是否继续? ", btn2, btn1);
    end
end

-------------------------------------网络回调-------------------------------------
-- 匹配开始确认（回调成功才打开匹配界面原因：有匹配惩罚的不一定能打开匹配界面）
function Fuzion2MainUI:gc_start_match()
	-- self.vsMatchUI:Show()
    -- uiManager:PushUi(EUI.Funzion2MatchUI);
    Fuzion2Loading.GetInstance();
end

function Fuzion2MainUI:gc_activity_config()
    self:UpdateActivityTime();
end

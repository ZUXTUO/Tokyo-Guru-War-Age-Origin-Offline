KuiKuLiYaHurdleInfoUI = Class("KuiKuLiYaHurdleInfoUI",UiBaseClass);

function KuiKuLiYaHurdleInfoUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6003_yuan_zheng.assetbundle";
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaHurdleInfoUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa;
    self.playCfg = g_dataCenter.activity[self.msgEnumId];
end

function KuiKuLiYaHurdleInfoUI:SetLevel(floor_id)
	self.floorID = floor_id;
    self.hurdleCfg = ConfigManager.Get(EConfigIndex.t_kuikuliya_hurdle_info,floor_id);
    self:UpdateUi();
end

function KuiKuLiYaHurdleInfoUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
    end
end

function KuiKuLiYaHurdleInfoUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_change_hero"] = Utility.bind_callback(self, self.on_change_hero);
    self.bindfunc["on_start"] = Utility.bind_callback(self, self.on_start);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_battle"] = Utility.bind_callback(self, self.on_battle);
end

function KuiKuLiYaHurdleInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.txtDefFightPower = ngui.find_label(self.ui, "center_other/animation/sp_bk_frame2/sp_fight/txt_fight");
    self.labDefFightPower = ngui.find_label(self.ui, "center_other/animation/sp_bk_frame2/sp_fight/lab_fight");
    self.txtCurFightPower = ngui.find_label(self.ui, "center_other/animation/sp_bk_frame1/sp_fight/txt_fight");
    self.labCurFightPower = ngui.find_label(self.ui, "center_other/animation/sp_bk_frame1/sp_fight/lab_fight");

    self.monster = {};
    for i=1,3 do
        self.monster[i] = {};
        local obj = self.ui:get_child_by_name("center_other/animation/sp_bk_frame2/big_card_item_80"..i);
        local data = {};
        data.parent = obj;
        data.stypes = 
        {
            SmallCardUi.SType.Texture,
            SmallCardUi.SType.Level,
            SmallCardUi.SType.Star,
            SmallCardUi.SType.Rarity,
            SmallCardUi.SType.Qh,
            SmallCardUi.SType.Leader,
        }
        self.monster[i].head = SmallCardUi:new({parent=obj, sgroup=2});
        local pro = obj:get_child_by_name("pro_xuetiao");
        pro:set_active(false);
        --[[local sp = obj:get_child_by_name("sp_zheng_wang");
        sp:set_active(false);--]]
    end

    self.hero = {};
    for i=1,3 do
        self.hero[i] = {};
        local obj = self.ui:get_child_by_name("center_other/animation/sp_bk_frame1/big_card_item_80"..i);
        local data = {};
        data.parent = obj;
        data.stypes = 
        {
            SmallCardUi.SType.Texture,
            SmallCardUi.SType.Level,
            SmallCardUi.SType.Star,
            SmallCardUi.SType.Rarity,
            SmallCardUi.SType.Qh,
            SmallCardUi.SType.Leader,
        }
        self.hero[i].head = SmallCardUi:new(data);
        self.hero[i].head:SetCallback(self.bindfunc["on_change_hero"]);
        local pro = obj:get_child_by_name("pro_xuetiao");
        pro:set_active(false);
        --[[local sp = obj:get_child_by_name("sp_zheng_wang");
        sp:set_active(false);--]]
    end

    local _btnStart = ngui.find_button(self.ui,"center_other/animation/cont/btn1");
    _btnStart:set_on_click(self.bindfunc["on_start"], "MyButton.NoneAudio");
    local _btnClose = ngui.find_button(self.ui,"center_other/animation/content_di_754_458/btn_cha");
    _btnClose:set_on_click(self.bindfunc["on_close"]);
    local _btnBattle = ngui.find_button(self.ui,"center_other/animation/cont/btn2");
    _btnBattle:set_on_click(self.bindfunc["on_battle"]);
    local _btnTeam = ngui.find_button(self.ui,"center_other/animation/cont/btn3");
    _btnTeam:set_on_click(self.bindfunc["on_change_hero"]);

    self:UpdateUi();
end

function KuiKuLiYaHurdleInfoUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.hurdleCfg then
        -- self.txtDefFightPower:set_text("等级:")
        self.labDefFightPower:set_text(tostring(self.hurdleCfg.def_fight_powor));
        for i=1,3 do
            local id = self.hurdleCfg["monster"..i];
            if id ~= 0 then
                self.monster[i].head:SetDataNumber(id);
            end
        end
    end

    self:UpdateTeamUI();
end

function KuiKuLiYaHurdleInfoUI:UpdateTeamUI()
    if not self.ui then
        return;
    end
    local player = g_dataCenter.player;
    local teamid = ENUM.ETeamType.kuikuliya;
    local team = player:GetTeam(teamid);
    local power = 0;
    for i=1,3 do
        if team and team[i] then
            local card = g_dataCenter.package:find_card(1,team[i]);
            self.hero[i].head:SetData(card);
            power = power + card:GetFightValue(--[[teamid]]);
        else
            self.hero[i].head:SetData(nil);
        end
    end
    self.labCurFightPower:set_text("战力:");
    self.labCurFightPower:set_text(tostring(power));
end

function KuiKuLiYaHurdleInfoUI:UpdateSceneInfo(info_type)
    if ENUM.EUPDATEINFO.team == info_type then
        self:UpdateTeamUI();
    end
end

function KuiKuLiYaHurdleInfoUI:on_change_hero(t)
    local data = {
        teamType = ENUM.ETeamType.kuikuliya,
        heroMaxNum = 3,
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function KuiKuLiYaHurdleInfoUI:on_start()
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end
    if self.isStart then return end;
    self.isStart = true;
    self.timeId = timer.create(Utility.create_callback(function ()
        self.isStart = false;
    end),1000,1);
    local fs = self.playCfg;
    local defTeam = g_dataCenter.player:GetTeam(ENUM.ETeamType.kuikuliya)
    if not Utility.isEmpty(defTeam) then
        local team_info = {};
        for k,v in pairs(defTeam) do
            team_info[k] = {};
            team_info[k].index = v;
            team_info[k].pos = k;
        end
        fs:SetLevelIndex(self.hurdleCfg.hurdle_id);
        fs:SetChallengeFloor(self.hurdleCfg.floorIndex);
        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam,{teamPos =team_info})
        fs:SetPlayMethod(self.msgEnumId);
        msg_activity.cg_enter_activity(self.msgEnumId,fs:Tostring());
    else
        FloatTip.Float("请编辑上阵队伍");
    end
end

function KuiKuLiYaHurdleInfoUI:on_close()
    uiManager:PopUi();
end

function KuiKuLiYaHurdleInfoUI:on_battle()
    --local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local heroList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    table.sort(heroList, function (a,b)
        if a:GetFightValue() > b:GetFightValue() then
            return true;
        end
        return false;
    end)

    local teamData = {}
    for k, v in pairs(heroList) do
        teamData[k] = v.index
    end
    local _team = PublicFunc.CreateSendTeamData(ENUM.ETeamType.kuikuliya, teamData)

    msg_team.cg_update_team_info(_team);
end

function KuiKuLiYaHurdleInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
    self.isStart = false;
    if self.timerid then
        timer.stop(self.timerid);
        self.timerid = nil;
    end
end

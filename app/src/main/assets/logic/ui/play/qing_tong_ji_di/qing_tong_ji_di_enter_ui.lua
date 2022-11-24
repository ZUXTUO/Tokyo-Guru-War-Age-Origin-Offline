QingTongJiDiEnterUI = Class("QingTongJiDiEnterUI", UiBaseClass);

local _local = {}
_local.UIText = {
    [1] = "第%s赛季",
    [2] = "今日剩余时间",
    [3] = "活动开启时间",
    [4] = "[A4A5E9FF]我的积分[-] [FFCC01FF]%s[-]",
    [5] = "[A4A5E9FF]我的排名[-] [FFCC01FF]%s[-]",
    [6] = "剩余奖励次数:",
    [7] = "未到活动开启时间",
    [8] = "每日%s开启",
    [9] = "虚位以待",
    [10] = "积分 [FFCC01FF]%s[-]",
}

function QingTongJiDiEnterUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4301_ghoul_3v3.assetbundle";
    UiBaseClass.Init(self, data);
end

function QingTongJiDiEnterUI:OnLoadUI()
    UiBaseClass.PreLoadUIRes(QingTongJiDi3D, Root.empty_func)
end

function QingTongJiDiEnterUI:Restart(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_threeToThree);
    msg_three_to_three.cg_three_to_three_state()
    UiBaseClass.Restart(self, data);
end

function QingTongJiDiEnterUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function QingTongJiDiEnterUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_start_btn"] = Utility.bind_callback(self, self.on_start_btn)
    self.bindfunc["on_rank_btn"] = Utility.bind_callback(self, self.on_rank_btn)
    self.bindfunc["on_award_btn"] = Utility.bind_callback(self, self.on_award_btn)
    self.bindfunc["on_shop_btn"] = Utility.bind_callback(self, self.on_shop_btn)
    self.bindfunc["gc_team_room"] = Utility.bind_callback(self, self.gc_team_room)
    self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match)
    self.bindfunc["gc_start_match"] = Utility.bind_callback(self, self.gc_start_match)
    self.bindfunc["gc_exit_not_enter_game"] = Utility.bind_callback(self, self.gc_exit_not_enter_game)
    self.bindfunc["gc_three_to_three_state"] = Utility.bind_callback(self, self.gc_three_to_three_state)
    -- self.bindfunc["gc_activity_config"] = Utility.bind_callback(self, self.gc_activity_config);
    self.bindfunc["gc_get_top_rank"] = Utility.bind_callback(self, self.gc_get_top_rank);

    -- self.bindfunc["MatchHandle"] = Utility.bind_callback(self, self.MatchHandle)
end

function QingTongJiDiEnterUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function QingTongJiDiEnterUI:MsgRegist()
    UiBaseClass.MsgRegist(self);

    PublicFunc.msg_regist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"])
    PublicFunc.msg_regist(msg_three_to_three.gc_team_room,self.bindfunc['gc_team_room']);
    PublicFunc.msg_regist(msg_three_to_three.gc_start_match,self.bindfunc['gc_start_match']);
    PublicFunc.msg_regist(msg_three_to_three.gc_exit_not_enter_game,self.bindfunc['gc_exit_not_enter_game']);
    PublicFunc.msg_regist(msg_three_to_three.gc_three_to_three_state,self.bindfunc['gc_three_to_three_state']);
    -- PublicFunc.msg_regist(msg_activity.gc_activity_config,self.bindfunc["gc_activity_config"]);
    PublicFunc.msg_regist(msg_three_to_three.gc_get_top_rank,self.bindfunc['gc_get_top_rank'])
end

function QingTongJiDiEnterUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_three_to_three.gc_cancel_match, self.bindfunc["gc_cancel_match"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_team_room,self.bindfunc['gc_team_room']);
    PublicFunc.msg_unregist(msg_three_to_three.gc_start_match,self.bindfunc['gc_start_match']);
    PublicFunc.msg_unregist(msg_three_to_three.gc_exit_not_enter_game,self.bindfunc['gc_exit_not_enter_game']);
    PublicFunc.msg_unregist(msg_three_to_three.gc_three_to_three_state,self.bindfunc['gc_three_to_three_state']);
    -- PublicFunc.msg_unregist(msg_activity.gc_activity_config,self.bindfunc["gc_activity_config"]);
    PublicFunc.msg_unregist(msg_three_to_three.gc_get_top_rank,self.bindfunc['gc_get_top_rank'])
end

function QingTongJiDiEnterUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("qtjd_enter_ui");

    local path = "top_other/animation/"
    ----------------------- 中部 ----------------------
    self.labSeasonNumber = ngui.find_label(self.ui, path.."sp_bk1/lab")
    self.labSeasonDuration = ngui.find_label(self.ui, path.."sp_bk2/lab_time")

    local btnLeft = ngui.find_button(self.ui, "btn_one")
    local btnRight = ngui.find_button(self.ui, "btn_more")
    btnLeft:set_on_click(self.bindfunc["on_start_btn"])
    btnLeft:set_event_value("single", 0)
    btnRight:set_on_click(self.bindfunc["on_start_btn"])
    btnRight:set_event_value("team", 0)


	path = "down_other/animation/"
    self.labDayCompleteCount = ngui.find_label(self.ui, path.."lab_num")
    self.labLeftTimeStr = ngui.find_label(self.ui, path.."lab_open_time")

    path = "right_top_other/animation/"
    local btnRank = ngui.find_button(self.ui, path.."btn_ranklist")
    local btnAward = ngui.find_button(self.ui, path.."btn_award")
    --local btnShop = ngui.find_button(self.ui, path.."btn_shop")
    btnRank:set_on_click(self.bindfunc["on_rank_btn"])
    btnAward:set_on_click(self.bindfunc["on_award_btn"])
    --btnShop:set_on_click(self.bindfunc["on_shop_btn"])

    path = "left_top_other/animation/"
    self.labMyScore = ngui.find_label(self.ui, path.."lab_integral")
    self.labMyRank = ngui.find_label(self.ui, path.."lab_rank")

    path = "centre_other/animation/"
    local nodeHeroInfo = {}
    nodeHeroInfo[1] = self.ui:get_child_by_name(path.."sp_centre_di")
    nodeHeroInfo[2] = self.ui:get_child_by_name(path.."sp_left_di")
    nodeHeroInfo[3] = self.ui:get_child_by_name(path.."sp_right_di")
    local spSilhouette = {}
    spSilhouette[1] = self.ui:get_child_by_name(path.."centre_human")
    spSilhouette[2] = self.ui:get_child_by_name(path.."left_human")
    spSilhouette[3] = self.ui:get_child_by_name(path.."right_human")
    self.top3Info = {}
    for i=1,3 do
        local heroInfo = {}
        heroInfo.spSilhouette = spSilhouette[i]
        heroInfo.spRank = ngui.find_sprite(nodeHeroInfo[i], "sp_rank")
        heroInfo.labName = ngui.find_label(nodeHeroInfo[i], "lab_name")
        heroInfo.labScore = ngui.find_label(nodeHeroInfo[i], "lab_score")
        heroInfo.labSpVip = ngui.find_label(nodeHeroInfo[i], "sp_v")

        if heroInfo.labSpVip then heroInfo.labSpVip:set_active(false) end

        PublicFunc.SetRank123Sprite(heroInfo.spRank, i)

        self.top3Info[i] = heroInfo
    end

    self:UpdateUi()
end

function QingTongJiDiEnterUI:DestroyUi()
    self.top3Info = nil
    QingTongJiDi3D.Destroy();
    UiBaseClass.DestroyUi(self);
end

function QingTongJiDiEnterUI:UpdateActivityTime()
    if not self.ui then return end;

end

function QingTongJiDiEnterUI:UpdateUi()
    if not self.ui then return end;

    local timeSegment = PublicFunc.GetActivityTimeSegment(MsgEnum.eactivity_time.eActivityTime_threeToThree)
    local timeSegmentStr = {}
    for i, v in ipairs(timeSegment) do
        table.insert(timeSegmentStr, string.format("%02d:%02d-%02d:%02d", v[1].h, v[1].i, v[2].h, v[2].i))
    end
    local strTime = PublicFunc.GetColorText(table.concat(timeSegmentStr, ","), nil, "FCD901")
    self.labLeftTimeStr:set_text(string.format(_local.UIText[8], strTime));
    
    local beginDate, endDate = self.dataCenter:GetSeasonDurationDate()
    self.labSeasonDuration:set_text(table.concat(beginDate, '.') .. ' - ' ..table.concat(endDate, '.'))

    self.labSeasonNumber:set_text(tostring(self.dataCenter.curSeason))
    local completeCount = math.max(0, self.dataCenter.MaxTimes - self.dataCenter:GetCurTimes())
    local strCount = string.format("%s/%s", completeCount, self.dataCenter.MaxTimes)
    if completeCount == 0 then
        strCount = PublicFunc.GetColorText(strCount, "red")
    else
        strCount = PublicFunc.GetColorText(strCount, "green")
    end
    self.labDayCompleteCount:set_text(_local.UIText[6]..strCount)

    local rank = self.dataCenter:GetRankNum()
    if rank <= 0 then rank = "--" end
    local integral = self.dataCenter:GetIntegral()
    self.labMyScore:set_text(string.format(_local.UIText[4], integral))
    self.labMyRank:set_text(string.format(_local.UIText[5], rank))

    local top3data = self.dataCenter:GetTop3Player()
    for i, v in pairs(self.top3Info) do
        if top3data[i] then
            v.spSilhouette:set_active(false)
            v.labName:set_text(top3data[i].name)
            v.labScore:set_text(string.format(_local.UIText[10], top3data[i].integral))
            -- PublicFunc.SetImageVipLevel(v.labSpVip, top3data[i].vip)
        else
            v.spSilhouette:set_active(true)
            v.labName:set_text(_local.UIText[9])
            v.labScore:set_text(string.format(_local.UIText[10], "--"))
            -- PublicFunc.SetImageVipLevel(v.labSpVip, 0)
        end
    end

    -- 更新3d
    QingTongJiDi3D.SetAndShow(top3data)
end

function QingTongJiDiEnterUI:Show()
    if UiBaseClass.Show(self) then
        local instance = QingTongJiDi3D.GetInstance()
        if instance then
            instance:Show()
        end
    end
end

function QingTongJiDiEnterUI:Hide()
    if UiBaseClass.Hide(self) then
        local instance = QingTongJiDi3D.GetInstance()
        if instance then
            instance:Hide()
        end
    end
end

function QingTongJiDiEnterUI:on_start_btn(t)
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end

    -- if self.dataCenter:GetCurState() ~= 1 then return end
    if g_dataCenter.gmCheat:getPlayLimit() and not PublicFunc.InActivityTime(MsgEnum.eactivity_time.eActivityTime_threeToThree) then
        FloatTip.Float(_local.UIText[7])
        return;
    end

    if t.string_value == "single" then
        msg_three_to_three.cg_start_match(0);
    elseif t.string_value == "team" then
        msg_three_to_three.cg_team_room(0) --开启房间
    end
end

function QingTongJiDiEnterUI:on_rank_btn(t)
    --uiManager:PushUi(EUI.QingTongJiDiRankUI)
	--RankPopPanel.popPanel(nil,RANK_TYPE.VS3TO3);
	msg_three_to_three.cg_get_top_rank()
	self.loadingId = GLoading.Show(GLoading.EType.ui);
end

function QingTongJiDiEnterUI:gc_get_top_rank(list)
    local rankList = {}
    if list then
        for i, v in ipairs(list) do
            table.insert(rankList, QTJDRankInfo:new(v))
        end
    end

    -- 数据格式转换到RankPlayer
    local viewData = {}
	local my_rank = {
		ranking = self.dataCenter:GetRankNum();
		playerid = g_dataCenter.player.playerid;
		name = g_dataCenter.player.name;
		param2 = g_dataCenter.player.vip;
		level = g_dataCenter.player.level;
		iconsid = g_dataCenter.player.image;
		score = self.dataCenter:GetIntegral();
		num = self.dataCenter:GetKillNum();
	};
    for i, v in ipairs(rankList) do
        local rankPlayer = {}
        rankPlayer.playerid = v.playerid
        rankPlayer.name = v.name
        rankPlayer.score = v.integral    --积分
        rankPlayer.ranking = v.rankNum
		rankPlayer.num = v.killNum or 0;
		rankPlayer.level = v.level or 0;
		rankPlayer.iconsid = v.image or v.roleId;
		rankPlayer.param2 = v.vip or 0;
		rankPlayer.guildName = v.guildName;
        --rankPlayer.heroCids = {v.roleId}
        if g_dataCenter.player.playerid == v.playerid then 
			my_rank.ranking = rankPlayer.ranking;
			my_rank.num = rankPlayer.num;
			my_rank.score = rankPlayer.score;
			my_rank.guildName = rankPlayer.guildName;
			my_rank.param2 = rankPlayer.param2;
		end
        table.insert(viewData, rankPlayer)
    end
	if g_dataCenter.guild.detail ~= nil and g_dataCenter.guild.detail.id ~= "0" then 
		my_rank.guildName = g_dataCenter.guild.detail.name;
	end
	viewData.my_rank = my_rank;
	
	RankPopPanel.popPanel(viewData,RANK_TYPE.VS3TO3);
	GLoading.Hide(GLoading.EType.ui, self.loadingId);
end

function QingTongJiDiEnterUI:on_award_btn(t)
    uiManager:PushUi(EUI.QingTongJiDiAwardUI);
end

function QingTongJiDiEnterUI:on_shop_btn(t)
    g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.ThreeToThree);
end

function QingTongJiDiEnterUI:gc_team_room(result, ntype, param)
    --进房间
    if ntype == 0 then
        uiManager:PushUi(EUI.QingTongJiDiRoomUI)
    end
end

function QingTongJiDiEnterUI:gc_cancel_match(result, playerid)
    -- if self.dataCenter:GetEnterType() ~= 0 then return end
end

function QingTongJiDiEnterUI:gc_start_match(result, ntype, param)
    if ntype == 0 then
        uiManager:PushUi(EUI.MobaMatchingUI)
    end
end

function QingTongJiDiEnterUI:gc_exit_not_enter_game(playeridList, restartMatch)
    if self.dataCenter:GetEnterType() ~= 0 then return end

    if restartMatch == 1 then
        uiManager:RemoveUi(EUI.MobaReadyEnterUI)
        uiManager:PushUi(EUI.MobaMatchingUI)
        
    else
        uiManager:RemoveUi(EUI.MobaReadyEnterUI)
        uiManager:RemoveUi(EUI.MobaMatchingUI)
    end
end

function QingTongJiDiEnterUI:gc_three_to_three_state()
    if self.dataCenter:GetEnterType() ~= 0 then return end
    
    self:UpdateUi()
end


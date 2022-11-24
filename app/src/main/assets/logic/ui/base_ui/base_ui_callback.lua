--故事冒险
function UiBase:on_drama()
	--AudioManager.SetBackGroundMusicVolume(0.1)
	uiManager:PushUi(EUI.UiLevel);
	uiManager:ClearStack();
end

--对战
function UiBase:on_vs()
    --uiManager:PushUi(EUI.PlayUiBattle);
	--临时屏蔽 用于日本版
	--uiManager:PushUi(EUI.HuiZhangUI);
    -- CommomPlayUI.SetIndex(1)
    uiManager:PushUi(EUI.AthleticEnterUI);
end

--组织帮派
function UiBase:on_organization()
	local openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
	-- 开启等级不足
	if openLevel > g_dataCenter.player.level then
		
	else
		-- 打开我的公会
		if g_dataCenter.guild:IsJoinedGuild() then
			uiManager:PushUi(EUI.GuildMainUI);
		-- 打开公会申请
		else
			-- 先清除老的公会列表数据
			g_dataCenter.guild.simpleList = nil
			-- 打开公会浏览列表
			uiManager:PushUi(EUI.GuildLookUI);
		end
	    uiManager:ClearStack();
	end
end

--玩法
function UiBase:on_play_method()
	--临时屏蔽 用于日本版
	-- CommomPlayUI.SetIndex(2)
    uiManager:PushUi(EUI.ChallengeEnterUI);

	-- uiManager:PushUi(EUI.PlayUi);
	-- uiManager:ClearStack();
	-- local param = {[1]=1550};
	-- local isWin = true;
	-- local system_id = MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang;
	-- msg_activity.cg_leave_activity(system_id, isWin, param)
end

--扭蛋
function UiBase:on_lottery()
	uiManager:PushUi(EUI.EggUi);
	uiManager:ClearStack();
	
end

--角色
function UiBase:on_role()
	uiManager:PushUi(EUI.HeroPackageUI);
	uiManager:ClearStack();
end

--装备
function UiBase:on_equipment()
	uiManager:PushUi(EUI.EquipPackageUI);
	uiManager:ClearStack();
end

--合成
function UiBase:on_compound()
	--self.curtime = system.time();
	--app.log("当前时间"..self.curtime);
	--app.log(table.tostring(os.date("*t",self.curtime)));
    uiManager:PushUi(EUI.EquipCompoundUI);
end

--出售
function UiBase:on_sell()
	--uiManager:PushUi(EUI.UiShiYiQuTaoFaZhan);
end

--排行榜
function UiBase:on_rank_list()
	 uiManager:PushUi(EUI.RankUI, {default=true});
	-- uiManager:ClearStack();

    --test
    
end

--好友
function UiBase:on_friend()
	--uiManager:PushUi(EUI.FriendUi);	
    --uiManager:ClearStack();
end

--邮件
function UiBase:on_mail()
	--uiManager:PushUi(EUI.FettersUI, self.roleData);
	uiManager:PushUi(EUI.MailListUI);
end

--设置
function UiBase:on_setting()
	-- if self.ui_setting then
	-- 	self.ui_setting:Show();
	-- 	self.ui_setting:UpdateUi();
	-- else
	-- 	GLoading.Show();
	-- 	self.ui_setting = UiSet:new();
	-- end
	uiManager:PushUi(EUI.UiSet);
	-- local kill = {str="啊啊啊啊", award={{id=3, count=2},{id=2, count=2},{id=4, count=2}}};
	-- local rankAward = {
	-- {name = "aaa", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} }, 
	-- {name = "bbb", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} }, 
	-- {name = "ccc", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} },
	-- {name = "ddd", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} },
	-- {name = "eee", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} },
	-- {name = "fff", award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}} }, }
	-- local ownAward = {hurtStr = "100000", rankStr = "4", image = 32000001, award = {{id=3, count=2},{id=2, count=2},{id=4, count=2}}}
	-- CommonRankAward.Start(kill, rankAward, ownAward);
	-- local defTeam = g_dataCenter.player:GetDefTeam();
	-- local roleCards = {}
	-- for i = 1, #defTeam do
	-- 	local role = g_dataCenter.package:find_card(1, defTeam[i]);
	-- 	if role then
	-- 		table.insert(roleCards, role);
	-- 	end
	-- end
	-- local data = 
	-- {
	-- 	-- battle = {
	-- 	-- 	players={
	-- 	-- 		left= {player=g_dataCenter.player, cards=roleCards},
	-- 	-- 		right= {player=g_dataCenter.player, cards=roleCards},
	-- 	-- 	},
	-- 	-- 	fightResult={
	-- 	-- 		isWin = false,
	-- 	-- 		leftCount = 1,
	-- 	-- 		rightCount = 3,
	-- 	-- 		leftEquipSouls = 1,
	-- 	-- 		rightEquipSouls = 3,
	-- 	-- 	},
	-- 	-- }
	-- 	-- star = {star = 2, finishConditionInfex={[1] = 1, [3] = 1}, conditionDes={"111", "222", "333"}, showTitle=true},
	-- 	-- addexp = {player = g_dataCenter.player, cards=roleCards},
	-- 	-- jump = {jumpFunctionList={ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipComposite, ENUM.ELeaveType.EquipLevelUp,}},
	-- 	-- awards = {awardsList={{id=2, count=3},{id=2, count=3},{id=2, count=3},}, tType=2},
	-- }
	--CommonClearing.Start(data);
	-- local data = 
	-- {
	-- 	reliveTime=10, encRelive = 100, relive = 100, encReliveAdd = 100
	-- }
	-- CommonDead.Start(data);
	--CommonRoleLevelup.Start(roleCards[1]);
	--CommonFailAward.Start({{id=2, count=3},{id=2, count=3},{id=2, count=3},}, 1);
end


--任务
function UiBase:on_task()
	--msg_dailytask.cg_request_dailytask_list();
	--msg_dailytask.cg_request_my_dailytask_info();
	--GLoading.Show();
    --uiManager:PushUi(EUI.UiDailyTask);
 --    if self.ui_daily_task then
	-- 	self.ui_daily_task:Show();
	-- 	--self.ui_daily_task:UpdateUi();
	-- else
	-- 	GLoading.Show();
	-- 	self.ui_daily_task = UiDailyTask:new();
	-- end
	uiManager:PushUi(EUI.UiDailyTask);
end

function UiBase:gc_task(vecStarRewardFlag, taskeLevel)
	--GLoading.Hide();
	uiManager:PushUi(EUI.UiDailyTask);
end

--签到
function UiBase:on_sign_in()
	--临时屏蔽 用于日本版
	uiManager:PushUi(EUI.SevenSignUi);
	uiManager:ClearStack();
end

--活动
function UiBase:on_activity()
	--临时屏蔽 用于日本版
	uiManager:PushUi(EUI.ActivityUI);
	--uiManager:ClearStack();
end

--1号卡片
function UiBase:on_card1()
	local ui = uiManager:PushUi(EUI.FormationUi2);
	uiManager:ClearStack();
end

--2号卡片
function UiBase:on_card2()
	local ui = uiManager:PushUi(EUI.FormationUi2);
	uiManager:ClearStack();
end

--3号卡片
function UiBase:on_card3()
	local ui = uiManager:PushUi(EUI.FormationUi2);
	uiManager:ClearStack();
end

--弹出右边栏按钮
function UiBase:on_more()
	--临时屏蔽 用于日本版
	if(self.is_out == false)then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.CutOut);
		self.is_out = true;
		self.anim_right_other:animated_play("xin_main1");
		self.spMore:set_active(false);
		self.spMore1:set_active(true);
		--self.rightMark:set_active(true);
	else
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.CutIn);
		self.is_out = false;
		self.anim_right_other:animated_play("xin_main2");
		self.spMore:set_active(true);
		self.spMore1:set_active(false);
		--self.rightMark:set_active(false);
	end
end

--聊天
function UiBase:on_chat()
	-- uiManager:PushUi(EUI.ChatUI);
	self.chatIsShow = true;
	if self.chatUi then
		self.chatUi:Restart();
	else
		self.chatUi = ChatUI:new();
		self.chatUi:SetHideCallback(self.bindfunc["on_chat_callback"]);
	end
end
function UiBase:get_chat()
	return self.chatUi;
end

function UiBase:on_chat_callback()
	self.chatIsShow = false;
end

--向左
function UiBase:on_left()
	if self.index ~= 1 then
		self.index = self.index - 1
	else
		self.index = 3;
	end
	
	--self.renderTexture:ChangeObj(self.roleData[self.index].number);
end

--向右
function UiBase:on_right()
	if self.index ~= 3 then
		self.index = self.index + 1
	else
		self.index = 1;
	end
	
	--self.renderTexture:ChangeObj(self.roleData[self.index].number);
end

-- 竞技场
function UiBase:on_arena(t)
	uiManager:PushUi(EUI.ArenaUI);
	uiManager:ClearStack();
end

function UiBase:on_service()
	--app.log("xxxxx");
	--app.open_url("https://www.baidu.com/");
    uiManager:PushUi(EUI.UiQuestWebView)    
end

function UiBase:on_level_up(level)
	if self.maskGo == nil then return end

	local notOpen = (ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data > level);
	self.maskGo:set_active( notOpen );
end

function UiBase:on_strong()
	-- if self.ui_develop_guide then
	-- 	self.ui_develop_guide:Show();
	-- 	--self.ui_daily_task:UpdateUi();
	-- else
	-- 	GLoading.Show();
	-- 	self.ui_develop_guide = UiDevelopGuide:new();
	-- end
	uiManager:PushUi(EUI.UiDevelopGuide);
end

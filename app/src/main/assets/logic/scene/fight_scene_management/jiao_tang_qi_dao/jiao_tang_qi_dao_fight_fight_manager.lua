JiaoTangQiDaoFightFightManager = Class("JiaoTangQiDaoFightFightManager", FightManager)
function JiaoTangQiDaoFightFightManager:InitData()
	FightManager.InitData(self)
end

function JiaoTangQiDaoFightFightManager.InitInstance()
	FightManager.InitInstance(JiaoTangQiDaoFightFightManager)
	return JiaoTangQiDaoFightFightManager
end

function JiaoTangQiDaoFightFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
end

function JiaoTangQiDaoFightFightManager:LoadUI()
	FightManager.LoadUI(self)
--
	--UiFightBaoWeiCanChang.Start()
	--FightUI.ShowRockerIcon(true)
	--FightUI.ShowHeadIcon(false)
	--FightUI.ShowAttackButtonIcon(false)
	--FightUI.ShowTeamIcon(false)

	--self.jiaotangqidao_fightui = UiJiaoTangQiDao2:new();
end

function JiaoTangQiDaoFightFightManager:OnLoadHero(entity, camp_flag)
	FightManager.OnLoadHero(self, entity)
	if camp_flag == g_dataCenter.fight_info.single_friend_flag then
		entity:SetDontReborn(true)
		entity:SetAI(104)
	else
		entity:SetDontReborn(true)

    	entity:SetConfig("view_radius", 1000)
    	entity:SetConfig("act_radius", 2000)
		entity:SetAI(100);
	end
end

function JiaoTangQiDaoFightFightManager:OnStart()
	--改变刷怪g表
	FightManager.OnStart(self)
	self:_Start()
end

function JiaoTangQiDaoFightFightManager:popScene()
	self:_UnregistFunc();

	local index = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurIndex();
	local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex(index);
	local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(index);
	local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
	local param = {};
	param[1] = tostring(heroid);
	param[2] = tostring(star);
	param[3] = tostring(pos);
	param[4] = tostring(1);
	param[5] = tostring(FightScene.GetFightManager():GetFightUseTime())
	local isWin = 1;
	if self.isWin then
		isWin = 0;
	end
	msg_activity.cg_leave_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, isWin, param);
	SceneManager.PopScene(FightScene)
end

function JiaoTangQiDaoFightFightManager:OnShowFightResultUI()
	--UiBaoWeiCanChangAward.ShowAwardUi({score = self.score})
	self.isWin = FightRecord.IsWin();
	local index = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurIndex();
	local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex(index);
	local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(index);
	local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
	--HintUI.SetAndShow(EHintUiType.zero, "输了",{func = self.bindfunc['FightOver']})
    local cardhuman = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
	local left = {player = g_dataCenter.player, cards = {cardhuman}};
	local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(star,pos);
	local enemyid = enemy_player:GetDefTeam()[1];
    local cardhuman2 = enemy_player.package:find_card(ENUM.EPackageType.Hero,enemyid);
	local right = {player = enemy_player, cards = {cardhuman2}};
	local player = {left = left,right = right};
	local fightResult;
	if self.isWin == true then
		fightResult = {isWin = self.isWin,leftCount=1,rightCount=0};
	else
		fightResult = {isWin = self.isWin,leftCount=0,rightCount=1};
	end
	--app.log("输了111");
	CommonBattle.Start("教堂祈祷", player, fightResult)
	--app.log("输了222");
	CommonBattle.SetFinishCallback(self.popScene, self);
end

function JiaoTangQiDaoFightFightManager:_Start()
	self:_RegistFunc();
end

function JiaoTangQiDaoFightFightManager:_RegistFunc()
	self.bindfunc = {};
	self.bindfunc['FightOver'] = Utility.bind_callback(self, self.FightOver);
end

function JiaoTangQiDaoFightFightManager:_UnregistFunc()
	for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end



JiaoTangQiDaoFightManager = Class("JiaoTangQiDaoFightManager", FightManager)
function JiaoTangQiDaoFightManager:InitData()
	FightManager.InitData(self)
	self.curIndex = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurIndex();
	self.enterStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex();
	self.curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);
	self.hurdleid = FightScene.GetCurHurdleID();
	self.burchhero = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.burchhero)
	self.length = #self.burchhero - 2;
	self:_RegistFunc();
	self:_MsgRegist();
	self.followHeroUsedAI = 104;
end

function JiaoTangQiDaoFightManager.InitInstance()
	FightManager.InitInstance(JiaoTangQiDaoFightManager)
	return JiaoTangQiDaoFightManager
end

function JiaoTangQiDaoFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)
	self.burchHeroPos = nil;
	g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:ClearData();
end

function JiaoTangQiDaoFightManager:GetUIAssetFileList(out_file_list)
	-- FightManager.GetUIAssetFileList(self, out_file_list)
	
	local file_list = {
		"assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1602_church_guaji.assetbundle",
	}
	for k, v in pairs(file_list) do
		out_file_list[v] = v
	end

end

function JiaoTangQiDaoFightManager:GetHeroAssetFileList(out_file_list)
	local env = FightScene.GetStartUpEnv()

	local card_human = nil;

	out_file_list[PublicStruct.Temp_Model_File] = PublicStruct.Temp_Model_File
	--app.log(">>>"..table.tostring(env));

	for k, v in pairs(env.fightTeamInfo) do
		for kk, vv in pairs(v.players) do
			for kkk, vvv in pairs(vv.hero_card_list) do
				card_human = vv.package_source:find_card(1, vvv)
				if nil ~= card_human then
                    ObjectManager.GetHeroPreloadList(card_human.number, out_file_list)
				else
					app.log("JiaoTangQiDaoFightManager:GetHeroAssetFileList nil card :"..vvv)
				end
			end
		end
	end
end

function JiaoTangQiDaoFightManager:LoadUI()
	FightManager.LoadUI(self)
--
	local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
	--app.log("isPray=="..tostring(isPray).."    curStar=="..tostring(self.curStar).."   enterStar==="..tostring(self.enterStar));
	if self.enterStar == 1 then
		FightUI.ShowRockerIcon(false)
	else
		if isPray then
			if self.curStar == self.enterStar then
				FightUI.ShowRockerIcon(false)
			else
				FightUI.ShowRockerIcon(true)
			end
		else
			FightUI.ShowRockerIcon(true)
		end
	end
	FightUI.ShowHeadIcon(false)
	FightUI.ShowAttackButtonIcon(false)
	FightUI.ShowTeamIcon(false)

	self.jiaotangqidao_fightui = UiJiaoTangQiDaoXing:new();
end

function JiaoTangQiDaoFightManager:GetHeroPos()
	if not self.burchHeroPos then
		self.burchHeroPos = {};
		for i=1,self.length+2 do
			if self.burchhero[i].obj_name == "hbp_self" then
				self.burchHeroPos[-1] = self.burchhero[i];
			else
				local num = string.sub(self.burchhero[i].obj_name,string.find(self.burchhero[i].obj_name,"_")+1,string.len(self.burchhero[i].obj_name,true));
	        	num = tonumber(num);
	        	self.burchHeroPos[num] = self.burchhero[i];
	       	end
		end
	end
end

function JiaoTangQiDaoFightManager:LoadHero()
	self:GetHeroPos();
	local env = FightScene.GetStartUpEnv()
	for camp_flag, team in pairs(env.fightTeamInfo) do
		for player_id, player_info in pairs(team.players) do
            local posIndex = player_info.ex_data.pos;
            local pos = self.burchHeroPos[posIndex];
            if not pos then
            	app.log("位置=="..tostring(posIndex).."的英雄出生点没有");
            end
			for k, v in pairs(player_info.hero_card_list) do
				if v ~= nil and 0 ~= v then
                	local other_data = {};
                	other_data.posIndex = posIndex;
    			    self:LoadSingleHero(camp_flag, player_id, player_info.package_source, v, pos, other_data);
				end
			end
		end
	end

	return true;
end

function JiaoTangQiDaoFightManager:LoadSingleHero(camp_flag, player_id, package_source, cardHuman_id, pos_inf, other_data)
	if cardHuman_id ~= nil and 0 ~= cardHuman_id then
		local hero_id = 0
		local hero_level = 1

		local cardHuman = package_source:find_card(ENUM.EPackageType.Hero, cardHuman_id)
		if lua_assert(cardHuman ~= nil, "FightManager:_LoadHero nil hero.") then
			return false
		end
		if not cardHuman then
			return false;
		end
		hero_id = cardHuman.number
		hero_level = cardHuman.level
		--hero是sceneEntity的一个对象
		local hero = FightScene.CreateNoPreLoadHero(player_id, hero_id, camp_flag, 0, hero_level, cardHuman_id, package_source)
        hero:SetPosition(pos_inf.px, pos_inf.py, pos_inf.pz)
		hero:SetBornPoint(pos_inf.px, pos_inf.py, pos_inf.pz)
		PublicFunc.UnifiedScale(hero)
		hero:DetachAllBuff();
		--app.log("hero.name=="..hero.name);
		g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetInfoByName(self.enterStar,other_data.posIndex,hero.name);
		self:OnLoadHero(hero, camp_flag);
	end
end

function JiaoTangQiDaoFightManager:OnLoadHero(entity, camp_flag)
	FightManager.OnLoadHero(self, entity)
	entity:SetAI(104)
	entity:GetHpUi():Show(false);
	if camp_flag == g_dataCenter.fight_info.single_friend_flag then
		entity.object:set_layer(PublicStruct.UnityLayer.player,false);
		g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetSelfName(entity.name);
		local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
		if isPray then
			if self.enterStar == self.curStar then
				entity:ShowHero(true);
			else
				entity:ShowHero(false);
			end
		else
			entity:ShowHero(true);
		end
	else
		entity.object:set_layer(PublicStruct.UnityLayer.npc,false);
	end
end

function JiaoTangQiDaoFightManager:LoadItem()
	if MAP_RESTORE_DEBUG then
		app.log('map_debug'..tostring(FightScene.GetCurHurdleID())..' 场上道具')
	end

	-- 先找配置ConfigManager.Get(EConfigIndex.t_hurdle_id_entity,	-- 先找配置gd_hurdle_id_entity)	-- 先找配置gd_hurdle_id_entity
	local config = ConfigHelper.GetMapInf(self:GetFightMapInfoID(),EMapInfType.item)
	-- 创建对象	
	if MAP_RESTORE_DEBUG then
		--app.log('huhu_map_debug'..tostring(FightScene.GetCurHurdleID())..' 创建对象'..table.tostring(config))
	end
	local new_item = nil
	if not config then
		return
	end
	for k, ml_v in pairs(config) do
		new_item = FightScene.CreateItem(nil, ml_v.item_modelid, ml_v.flag, ml_v.id, ml_v.item_effectid)
		if new_item then
			new_item:SetPosition(ml_v.px,ml_v.py,ml_v.pz)
			new_item:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
			new_item:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
			self:OnLoadItem(new_item,ml_v.obj_name);
		end
	end	
end

function JiaoTangQiDaoFightManager:OnLoadItem(entity, name)
	entity:SetName(name);
end

function JiaoTangQiDaoFightManager:OnCreateMonster(obj)
	--obj.object:set_layer(PublicStruct.UnityLayer.npc,false);
end

function JiaoTangQiDaoFightManager:OnStart()
	FightManager.OnStart(self)
	self:_Start()
end

function JiaoTangQiDaoFightManager:PlayRelaxAudio()
	self.lastRelaxAudioTime = system.time();
end

function JiaoTangQiDaoFightManager:OnFightOver()
	--self:OnShowFightResultUI()
	--app.log("战斗结束");
	self:_MsgUnRegist();
	self:_UnregistFunc();
	self.jiaotangqidao_fightui:Hide();
	self.jiaotangqidao_fightui:DestroyUi();
	--SceneManager.PopScene(FightScene)
end

function JiaoTangQiDaoFightManager:OnShowFightResultUI()
	--UiBaoWeiCanChangAward.ShowAwardUi({score = self.score})
end

function JiaoTangQiDaoFightManager:_Start()
	
end

function JiaoTangQiDaoFightManager:_RegistFunc()
	self.bindfunc = {};
	self.bindfunc['_DeleteHero'] = Utility.bind_callback(self, self._DeleteHero);
	self.bindfunc['_AddHero'] = Utility.bind_callback(self, self._AddHero);
end

function JiaoTangQiDaoFightManager:_UnregistFunc()
	for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function JiaoTangQiDaoFightManager:_MsgRegist()
	PublicFunc.msg_regist(msg_activity.gc_churchpray_role_leave,self.bindfunc['_DeleteHero']);
	PublicFunc.msg_regist(msg_activity.gc_churchpray_role_join,self.bindfunc['_AddHero']);
end

function JiaoTangQiDaoFightManager:_MsgUnRegist()
	PublicFunc.msg_unregist(msg_activity.gc_churchpray_role_leave,self.bindfunc['_DeleteHero']);
	PublicFunc.msg_unregist(msg_activity.gc_churchpray_role_join,self.bindfunc['_AddHero']);
end

--删除场上一个英雄
function JiaoTangQiDaoFightManager:_DeleteHero(nstar, posIndex, cardgid)
	--app.log("删除nstar=="..nstar.."   posIndex=="..posIndex);
	if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(self.curIndex) == cardgid then
		return
	end
	local obj_name = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(nstar, posIndex).otherData.heroName;
    FightScene.DeleteObj(obj_name, 0);
end

--增加一个英雄
function JiaoTangQiDaoFightManager:_AddHero(nstar, posIndex, roledata)
	--app.log("增加一个英雄nstar=="..nstar.."posIndex=="..posIndex.."还没做表现");
	--app.log("roledata=="..table.tostring(roledata));
	--app.log(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(self.curIndex));

	if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(self.curIndex) == roledata.cardGID then
		return
	end

	local player_info = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(nstar,posIndex);

	--local posIndex = player_info.ex_data.pos;
    --app.log("posIndex=="..posIndex);
    local pos = self.burchHeroPos[posIndex];
    local other_data = {};
	other_data.posIndex = posIndex;

	self:LoadSingleHero(g_dataCenter.fight_info.single_enemy_flag, player_info.playerGid, player_info.package, player_info:GetDefTeam()[1], pos, other_data)
end



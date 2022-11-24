

EmbattleFightManager = Class("EmbattleFightManager", FightManager)

function EmbattleFightManager:InitInstance()


	EmbattleFightManager._super.InitInstance(self)
end

function EmbattleFightManager:Destroy()
    
    EmbattleFightManager._super.Destroy(self)
end

function EmbattleFightManager:GetNPCAssetFileList(out_file_list)

	EmbattleFightManager._super.GetNPCAssetFileList(self,out_file_list);

	local env = FightScene.GetStartUpEnv()
	for camp_flag,team in pairs(env.fightTeamInfo) do
		for player_id,player_info in pairs(team.players) do
			local teamPos = player_info.ex_data.monsterTeamPos;
            if teamPos ~= nil then
			    for k,v in pairs(teamPos) do
				    local index = v.index;
				    local file_path = ObjectManager.GetMonsterModelFile(index);
				    out_file_list[file_path] = file_path;
			    end
            end
		end
	end
end

function EmbattleFightManager:LoadHero()
	local env = FightScene.GetStartUpEnv()
	for camp_flag,team in pairs(env.fightTeamInfo) do
		local  heroBPList = {};
		LevelMapConfigHelper.GetHeroBornPosList(camp_flag,heroBPList);
		if #heroBPList == 0 then
			break;
		end

		for player_id,player_info in pairs(team.players) do

            local teamPos = player_info.ex_data.teamPos;
		    local points = {};
		    local special = nil; -- 突袭位
		    for id,info in pairs(teamPos) do
			    for k,v in pairs(heroBPList) do
				    if v.obj_name == "hbp_"..info.pos then
					    points[info.index] = v;
					    if info.pos == 0 then
						    special = info.index;
					    end
					    break;
				    end
			    end
		    end

		    local timer_id;
			for k,v in pairs(player_info.hero_card_list) do
				if v ~= 0 then
					local pos = points[v];
					-- if special == v then
                    --     g_dataCenter.fight_info:AddDelayLoadHero(camp_flag, v)
					-- 	timer_id = timer.create(
					-- 		Utility.create_obj_callback(
					-- 			self,
					-- 			self.LoadSingleHero,
					-- 			0,
					-- 			camp_flag, player_id, player_info.package_source, v, pos
					-- 			),
					-- 		3000,
					-- 		1
					-- 		);
					-- else
		    			self:LoadSingleHero(camp_flag, player_id, player_info.package_source, v, pos);
		    		-- end
				end
			end
			self.heroTimerId = timer_id;
		end
	end
end

function EmbattleFightManager:LoadSingleHero(camp_flag, player_id, package_source, cardHuman_id, pos_inf)
	FightManager.LoadSingleHero(self, camp_flag, player_id, package_source, cardHuman_id, pos_inf);
	if self.heroTimerId then
		if FightManager.GetMyCaptain() == nil then
			g_dataCenter.player:ChangeCaptain(1)
			self:SetCameraInitPos();
		end
	end
	self.heroTimerId = nil;
end

function EmbattleFightManager:LoadMonster()

	FightManager.LoadMonster(self);

	local env = FightScene.GetStartUpEnv();
	for camp_flag,team in pairs(env.fightTeamInfo) do
		local  heroBPList = {};
		LevelMapConfigHelper.GetHeroBornPosList(camp_flag,heroBPList);
		if #heroBPList == 0 then
			break;
		end
		for player_id,player_info in pairs(team.players) do
			local teamPos = player_info.ex_data.monsterTeamPos;
			local points = {};
			local special = nil; -- 突袭位
            if teamPos ~= nil then
			    for id,info in pairs(teamPos) do
				    for k,v in pairs(heroBPList) do
					    if v.obj_name == "hbp_"..tostring(info.pos) then
						    points[id] = v;
						    if info.pos == 0 then
							    special = id;
						    end
						    break;
					    end
				    end
			    end
			    for k,v in pairs(teamPos) do
				    local pos = points[k];
				    if special == k then
					    self.monsterTimerId = timer.create(
						    Utility.create_obj_callback(
							    self,
							    self.CreateMonster,
							    v.index,
							    camp_flag,
							    pos
							    ),
						    3000,
						    1
					    );
				    else
					    self:CreateMonster(v.index,camp_flag, pos);
				    end
			    end
            end
		end
	end
end

function EmbattleFightManager.CreateSpecialMonster(id, camp_flag, pos)
	self:CreateMonster(id, camp_flag, pos);
    self.monsterTimerId = nil;
end

function EmbattleFightManager:CreateMonster(id, camp_flag, pos)
	local newmonster = FightScene.CreateMonsterAsync(nil, id, camp_flag)
	if newmonster then
		newmonster:SetPosition(pos.px,0,pos.pz)
        --TODO: kevin 临时设置怪物出生点
        newmonster:SetHomePosition(newmonster:GetPosition())
        newmonster:SetRotation(pos.rx,pos.ry,pos.rz)
        PublicFunc.UnifiedScale(newmonster)
        self:OnLoadMonster(newmonster);
    end
end
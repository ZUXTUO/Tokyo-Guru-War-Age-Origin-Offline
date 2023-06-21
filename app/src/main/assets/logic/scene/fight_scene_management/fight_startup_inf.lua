--[[
FightStartUpInf = {
	levelData = nil, --<tableItem:ConfigHelper.GetHurdleConfig(n)>	
	fightRules = nil,
	levelFightScript = nil,--<table> 战斗脚本， 每种玩法不一样

	fightTeamInfo = {
		[g_dataCenter.fight_info.single_friend_flag] = {
			--type = EFightManagerType.human,
			players = {
				[player_id ] = {
					obj  = <Class : Player> TODO: (kevin) 这里引用了对象，注意释放问题。。。。。。
					type = EFightPlayerType.human,
					name = '',
					package_source = player_s_package,
					hero_card_list = { 
						-- {uuid, }
						--id of cardhuman.
					},
				-- 	equip_card_list = {
				-- 		--cardequit list						
				-- 	}
				},

				{

				}
			}
		},
	}
}
--]]

FightStartUpInf = Class("FightStartUpInf")

function FightStartUpInf:InitData()
	self.levelData = nil
	self.fightTeamInfo = {
		[g_dataCenter.fight_info.single_friend_flag] = {
			players = {}
		},
		[g_dataCenter.fight_info.single_enemy_flag] = {
			players = {}
		}
	}
	self.ext_parm = {boss_id = 10000}
	self.play_method_id = nil;
end

function FightStartUpInf:FightStartUpInf()
	self:InitData()
end

function FightStartUpInf:SetPlayMethod(play_method_id)
	self.play_method_id = play_method_id;
end

function FightStartUpInf:SetWorldGID(world_gid)
	self.world_gid = world_gid;
end

function FightStartUpInf:GetPlayMethod()
	return self.play_method_id;
end

function FightStartUpInf:SetLevelIndex(level_index)
 	 	self.levelData = ConfigHelper.GetHurdleConfig(level_index)
	if self.levelData == nil then
		app.log("nil level_data:"..tostring(level_index));
		return false
	else
		return true
	end
end

--parms:
--
--	player_uuid:
--	player_type: <enum: EFightPlayerType>
--	hero_card_list:<table: list<GID> >
function FightStartUpInf:AddFightPlayer(camp_flag, player_obj, package--[[TODO: (kevin) 取消package, player已经包含]],
											 player_type, hero_card_list,ex_data)
	if camp_flag < EFightInfoFlag.flag_a or camp_flag > EFightInfoFlag.flag_max  
		or nil == player_obj or Utility.isEmpty(hero_card_list) then
		app.log("bad parms for FightStartUpInf:AddFightPlayer " .. debug.traceback())
		return false
	end	

	local players = self.fightTeamInfo[camp_flag].players
	local gid = player_obj:GetGID();
	if players[gid] ~= nil then
		return false
	end
	players[gid] = {obj = player_obj, type = player_type, package_source = player_obj.package, hero_card_list = hero_card_list, ex_data = ex_data}
    return true
end

function FightStartUpInf:SetHeroList(flag, player, heroList)
    local gid = player:GetGID()

    if self.fightTeamInfo ==nil or self.fightTeamInfo[flag] == nil or self.fightTeamInfo[flag].players[gid] == nil then return end

    self.fightTeamInfo[flag].players[gid].hero_card_list = heroList
end

function FightStartUpInf:ClearFightPlayer()
	self.fightTeamInfo = {
		[g_dataCenter.fight_info.single_friend_flag] = { players = {} },
		[g_dataCenter.fight_info.single_enemy_flag] = { players = {} },
	}
end

function FightStartUpInf:SetExtParm(par)
	self.ext_parm = par;
end

function FightStartUpInf:GetExtParm()
	return self.ext_parm;
end

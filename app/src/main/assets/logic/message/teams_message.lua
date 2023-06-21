-- 临时变量, 是否使用本地数据
local isLocalData = true

msg_team = msg_team or {}
--[[服务器->客户端]]
function msg_team.gc_team_list(info,def_team_id)
	--app.log("gc_team_list########"..tostring(def_team_id).."..............."..table.tostring(info))
	for k,v in pairs(info) do
		if v["teamid"] >= 0 then
			for kk,vv in pairs(v.cards) do
				local num = tonumber(vv);
				if num ~= 0 and num then
					g_dataCenter.player:AddTeam(v["teamid"], kk, vv)
				end
			end
			if v.heroLineup then
				for kk,vv in pairs(v.heroLineup) do
					local num = tonumber(vv);
					if num then
						g_dataCenter.player:AddTeamPos(v["teamid"], kk, num)
					end
				end
			end
			if v.soldierLineup then
				for kk,vv in pairs(v.soldierLineup) do
					local num = tonumber(vv);
					if num then
						g_dataCenter.player:AddSoldierPos(v["teamid"], kk, num)
					end
				end
			end
			if v.backup_cards then
				for kk,vv in pairs(v.backup_cards) do
					local num = tonumber(vv);
					if num ~= 0 and num then
						g_dataCenter.player:AddBackupTeam(v["teamid"], kk, vv)
					end
				end
			end
		end
		g_dataCenter.player:UpdateTeamHaloInfo(v["teamid"], v.halo_property, v.fight_value)
	end
	-- if def_team_id == 0 then
	-- 	g_dataCenter.player:SetDefTeam(1);
	-- else
		g_dataCenter.player:SetDefTeam(def_team_id);
	-- end
end

function msg_team.gc_update_team_info(info,ret)
    if ret ~= 0 then
    	PublicFunc.GetErrorString(ret);
    else
   	app.log("msg_team.gc_update_team_info:info->"..table.tostring(info));
    	local teamid = info["teamid"];
        -- 先清空数据，再更新。保证数据准确
		g_dataCenter.player:ClearTeam(teamid)

        for k,v in pairs(info.cards) do
            if tonumber(v) ~= 0 then
                g_dataCenter.player:AddTeam(teamid, k, v)
            else
                g_dataCenter.player:AddTeam(teamid, k, nil)
            end
        end
                
        for k,v in pairs(info.heroLineup) do
            local num = tonumber(v);
            if num then
                    g_dataCenter.player:AddTeamPos(teamid, k, num)
            end
        end
        for k,v in pairs(info.soldierLineup) do
            local num = tonumber(v);
            if num then
                    g_dataCenter.player:AddSoldierPos(teamid, k, num)
            end
        end
        
	g_dataCenter.player:UpdateTeamHaloInfo(teamid, info.halo_property, info.fight_value)
        uiManager:UpdateCurScene(ENUM.EUPDATEINFO.team);

        NoticeManager.Notice(ENUM.NoticeType.ChangeTeamSuccess, teamid)
        PublicFunc.msg_dispatch(msg_team.gc_update_team_info, info,ret);
    end
end

--[[客户端->服务器]]
function msg_team.cg_update_team_info(team)
	--[[
	if Socket.socketServer then
		if AppConfig.script_recording then
			local _team = "\
			local team = {}\
			team.teamid = "..tostring(team.teamid).."\
			team.fight_value = "..tostring(team.fight_value).."\
			team.cards = {}\n"
			for i=1, #team.cards do
				local _dataid = "\"0\""
				local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, team.cards[i])
				if card then
					_dataid = ""
					_dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
				end
				_team = _team.."team.cards["..tostring(i).."] = ".._dataid.."\n"
			end
			_team = _team.."team.heroLineup = {}\n"
			if team.heroLineup then
				for i=1, #team.heroLineup do
					_team = _team.."team.heroLineup["..i.."] = "..tostring(team.heroLineup[i]).."\n" 
				end
			end
			_team = _team.."team.soldierLineup = {}\n"
			if team.soldierLineup then
				for i=1, #team.soldierLineup do
					_team = _team.."team.soldierLineup["..i.."] = "..tostring(team.soldierLineup[i]).."\n" 
				end
			end
			_team = _team.."team.halo_property = {}\n"
			if team.halo_property then
				for i=1, #team.halo_property do
					_team = _team.."\
					team.halo_property["..i.."] = {}\
					team.halo_property["..i.."].id = "..tostring(team.halo_property[i].id).."\
					team.halo_property["..i.."].value = "..tostring(team.halo_property[i].value).."\n"
				end
			end
			_team = _team.."team.backup_cards = {}\n"
			PublicFunc.RecordingScript(_team.."nmsg_team.cg_update_team_info(robot_s, team)")
		end
		nmsg_team.cg_update_team_info(Socket.socketServer, team);
	end
	]]
end

function msg_team.cg_team_list(socket)
	if not socket then return end
	nmsg_team.cg_team_list(socket);
end

function msg_team.gc_update_team_halo_info(teamid, halo_property, fight_value)
	g_dataCenter.player:UpdateTeamHaloInfo(teamid, halo_property, fight_value)
end

function msg_team.cg_update_team_backup_cards(teamid, cards_id)
	--if not Socket.socketServer then return end
    nmsg_team.cg_update_team_backup_cards(Socket.socketServer,teamid, cards_id);
end

function msg_team.gc_update_team_backup_cards(ret, teamid, cards_id)
	if type(cards_id) ~= "table" then
		return;
	end
	if tonumber(ret) ~= 0 then
        PublicFunc.FloatErrorCode(ret, gs_string_team, "team")
        return;
    end
	for k,v in pairs(cards_id) do
		local num = tonumber(v);
		if num ~= 0 and num then
			g_dataCenter.player:AddBackupTeam(teamid, k, v)
		else
			g_dataCenter.player:AddBackupTeam(teamid, k, nil)
		end
	end
	PublicFunc.msg_dispatch(msg_team.gc_update_team_backup_cards, ret, teamid, cards_id);
end


return msg_team;

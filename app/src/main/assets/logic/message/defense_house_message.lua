-- 临时变量, 是否使用本地数据
local isLocalData = true

--“保卫喰场”相关消息
msg_defense_house = msg_defense_house or {}
--[[服务器->客户端]]
function msg_defense_house.gc_team_list(info,def_team_id)
	if info ~= nil then
		for k,v in pairs(info) do
			if v["teamid"] > 0 then
				for kk,vv in pairs(v.cards) do
					if tonumber(vv) ~= 0 then
						g_dataCenter.player:AddTeam(v["teamid"], kk, vv)
					end
				end
			end
		end
	end
	if def_team_id == 0 then
		g_dataCenter.player:SetDefTeam(1);
	else
		g_dataCenter.player:SetDefTeam(def_team_id);
	end
end

--[[客户端->服务器]]
--通知服务器，已完成保卫喰场，并告知所得分数
function msg_defense_house.cg_complete(score)
	if(isLocalData)then
		g_defense_house_local.cg_complete()
	else
		if Socket.socketServer then
			nmsg_defense_house.cg_complete(Socket.socketServer, score);
		end
	end
end

return msg_defense_house;

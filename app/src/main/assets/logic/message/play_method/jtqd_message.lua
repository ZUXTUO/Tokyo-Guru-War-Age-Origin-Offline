-- 玩法--教堂祈祷消息
-- 临时变量, 是否使用本地数据
local isLocalData = true

msg_jtqd = msg_jtqd or {};
----------------------------- 客户端到服务器 -----------------------------------
-- 请求stra_level星级的教堂所有位置的信息
function msg_jtqd.cg_get_all_pos_info(star_level)
	if(isLocalData)then
		g_msg_jtqd_local.cg_get_all_pos_info(star_level)
	else
		nmsg_jtqd.cg_get_all_pos_info(Socket.socketServer, star_level);
	end
end

-- 请求star_level星级教堂，第pos个位置的角色详细信息
function msg_jtqd.cg_get_hero_info(star_level,pos)
	if(isLocalData)then
		g_msg_jtqd_local.cg_get_hero_info()
	else
		nmsg_jtqd.cg_get_hero_info(Socket.socketServer,star_level,pos);
	end
end

----------------------------- 游戏服到客户端 -----------------------------------
--得到stra_level星级的教堂所有位置的信息
function msg_jtqd.gc_get_all_pos_info(star_level,info)
	g_dataCenter.activity[MsgEnum.eactivity_time.jiao_tang_qi_dao]:SetAllPositionInfo(star_level,info);
end

--得到star_level星级教堂，第pos个位置的角色详细信息
function msg_jtqd.gc_get_hero_info(star_level,pos,info)
	g_dataCenter.activity[MsgEnum.eactivity_time.jiao_tang_qi_dao]:SetHeroInfo(star_level,pos,info);
end

-- --
-- function msg_jtqd.gc_update_all_pos_info(star_level,info)
-- 	g_dataCenter.activity[MsgEnum.eactivity_time.jiao_tang_qi_dao]:SetAllPositionInfo(star_level,pos,info);
-- end

--
-- function msg_jtqd.gc_update_hero_info(star_level,pos,info)
-- 	g_dataCenter.activity[MsgEnum.eactivity_time.jiao_tang_qi_dao]:SetHeroInfo(star_level,pos,info);
-- end

return msg_jtqd;
msg_guild = msg_guild or {}

-- 临时变量, 是否使用本地数据
local isLocalData = true

-- 创建社团
function msg_guild.cg_create_guild(szName, nIcon, nLimitLevel, ApproveRule, szDeclaration)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_create_guild(szName, nIcon, nLimitLevel, ApproveRule)
	else
		nmsg_guild.cg_create_guild(Socket.socketServer, szName, nIcon, nLimitLevel, ApproveRule, szDeclaration)
	end
end

-- 返回创建社团
function msg_guild.gc_create_guild(result)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		PublicFunc.msg_dispatch(msg_guild.gc_create_guild)
	else
		PublicFunc.GetErrorString(result)
	end
end



-- 请求社团列表数据（取第几次的最新数据，每次取24条）
function msg_guild.cg_request_guild_list(index)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_request_guild_list(index)
	else
		if AppConfig.script_recording then
	        PublicFunc.RecordingScript("nmsg_guild.cg_request_guild_list(robot_s, "..tostring(index)..")")
	    end
		nmsg_guild.cg_request_guild_list(Socket.socketServer, index)
	end
end

-- 返回社团列表数据
-- 参考<SGuildSimpleData>
-- struct SGuildSimpleData
-- {
-- 	string guildID;
-- 	int guildLevel;
-- 	int limitJoinLevel;
-- 	int IconIndex;
-- 	string createTime;
-- 	string  szName;
-- 	string szDeclaration;
-- 	string szLeaderName;
-- 	int memberCnt;
-- }
function msg_guild.gc_request_guild_list(index, totalCnt, listData)
	GLoading.Hide(GLoading.EType.msg)
	if listData then
		g_dataCenter.guild:SetSimpleListData(index, totalCnt, listData)

		PublicFunc.msg_dispatch(msg_guild.gc_request_guild_list)
	end
end



-- 查询指定社团: searchid-ID name-名字
function msg_guild.cg_look_for_guild(searchid, name)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		--guild_data_local.cg_look_for_guild(searchid, name)
	else
		nmsg_guild.cg_look_for_guild(Socket.socketServer, searchid, name)
	end
end

-- 返回查询社团结果
function msg_guild.gc_look_for_guild(result, simpleData)
	GLoading.Hide(GLoading.EType.msg)
	if result ~= 0 then
		PublicFunc.GetErrorString(result)
	end
	PublicFunc.msg_dispatch(msg_guild.gc_look_for_guild, result, simpleData)
end



-- 申请加入社团
function msg_guild.cg_apply_join(guildID)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_apply_join(guildID)
	else
		nmsg_guild.cg_apply_join(Socket.socketServer, guildID)
	end
end

-- 返回申请加入社团结果
function msg_guild.gc_apply_join(result, guildID, cdLeftTime)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		g_dataCenter.guild:SetApplyGuildId(guildID)
		PublicFunc.msg_dispatch(msg_guild.gc_apply_join, guildID)

		--加入社团成功
		if g_dataCenter.guild:IsJoinedGuild() then
			-- 关闭当前界面
			uiManager:ClearStack()
			uiManager:PopUi()
			-- 前往社团
			local guildName = ""
			if g_dataCenter.guild.simpleList then
				for i, simple in ipairs(g_dataCenter.guild.simpleList) do
					if simple.id == guildID then
						guildName = simple.name
						break;
					end
				end
			end
			local cbfunc = function() uiManager:PushUi(EUI.GuildMainUI) end
			local content = "社团[f2ae1c]%s[-]已经同意您加入，赶紧去看看吧！"
			content = string.format(content, guildName)
			HintUI.SetAndShow(EHintUiType.one, content, {str="前往",func=cbfunc})
		end
	else
		-- 加入冷却中
		if cdLeftTime > 0 then
			FloatTip.Float(string.format("%s后可加入社团", TimeAnalysis.analysisSec_fuzzy(cdLeftTime, false, true)))
		else
			PublicFunc.GetErrorString(result)
		end
	end
end



-- 处理玩家申请消息
function msg_guild.cg_dealwith_apply_join(playerid, ntype)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_dealwith_apply_join(playerid, ntype)
	else
		nmsg_guild.cg_dealwith_apply_join(Socket.socketServer, playerid, ntype)
	end
end

-- 返回处理玩家申请结果
function msg_guild.gc_dealwith_apply_join(result, playerid, ntype)
	GLoading.Hide(GLoading.EType.msg)

	PublicFunc.GetErrorString(result)
	-- 处理报错，也需要刷新申请列表
	PublicFunc.msg_dispatch(msg_guild.gc_dealwith_apply_join)
end



-- 拉取社团数据
function msg_guild.cg_request_my_guild_data()
	--if not Socket.socketServer then return end

	if isLocalData then
		guild_data_local.cg_request_my_guild_data()
	else
		nmsg_guild.cg_request_my_guild_data(Socket.socketServer)
	end
end

-- 主动拉取社团数据 / 入会请求立即通过的会同步发一次社团数据 
-- 参考<SGuildDetailFullData>
-- struct SGuildDetailFullData
-- {
-- 	string guildID;
-- 	int guildLevel;
-- 	int limitJoinLevel;
-- 	int IconIndex;
-- 	string createTime;
-- 	string  szName;
-- 	string szDeclaration;		//公告
-- 	string szLeaderName;
-- 	int memberCnt;
-- 	int ApproveRule;			// 自动审批
-- 	int guildExp;			// 社团当前等级经验值
-- 	int activePoints;		// 社团当前活跃积分
-- 	list<SGuildMemberData> vecMember; 	//社团成员信息
-- 	list<guild_log_data>	vecLog;			//社团日志
-- }
function msg_guild.gc_sync_my_guild_data(data)
	if data then
		g_dataCenter.guild:LoadGuildDetail(data)
		PublicFunc.msg_dispatch(msg_guild.gc_sync_my_guild_data)
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Guild_Wait_Enter);
	end
	NoticeManager.Notice(ENUM.NoticeType.GuildDataChange)
end



-- 请求社团活动记录结果(0日，1周，2月)
function msg_guild.cg_request_actviity_record(ntype)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_request_actviity_record(ntype)
	else
		nmsg_guild.cg_request_actviity_record(Socket.socketServer, ntype)
	end
end

-- 返回社团活动记录结果
-- 参考<SMemberActivityRecord>
-- struct SMemberActivityRecord
-- {
-- 	string playerid;
-- 	list<int>	vecTimes;	//活动次数
-- }
function msg_guild.gc_request_actviity_record(result, ntype, listRecord)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		g_dataCenter.guild:SetMemberActivityData(ntype+1, listRecord)
		PublicFunc.msg_dispatch(msg_guild.gc_request_actviity_record)
	else
		PublicFunc.GetErrorString(result)
	end
end



-- 发送成员管理请求（0,踢人，1继承，2职位变更，3解散）
function msg_guild.cg_guild_operation(ntype, playerid, param)
	--if not Socket.socketServer then return end
	if not PublicFunc.lock_send_msg(msg_guild.cg_guild_operation, ntype) then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_guild_operation(ntype, playerid, param)
	else
		nmsg_guild.cg_guild_operation(Socket.socketServer, ntype, playerid, param)
	end
end

-- 返回成员管理变更结果（0,踢人，1继承，2职位变更，3解散）
function msg_guild.gc_guild_operation(result, ntype, playerid, param)
	PublicFunc.unlock_send_msg(msg_guild.cg_guild_operation, ntype)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		PublicFunc.msg_dispatch(msg_guild.gc_guild_operation, ntype, playerid, param)
	else
		PublicFunc.GetErrorString(result)
	end
end



-- 退出社团
function msg_guild.cg_quit_guild()
	--if not Socket.socketServer then return end
	if not PublicFunc.lock_send_msg(msg_guild.cg_quit_guild) then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_quit_guild()
	else
		nmsg_guild.cg_quit_guild(Socket.socketServer)
	end
end

-- 返回退出社团结果
function msg_guild.gc_quit_guild(result)
	PublicFunc.unlock_send_msg(msg_guild.cg_quit_guild)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		PublicFunc.msg_dispatch(msg_guild.gc_quit_guild)
	else
		PublicFunc.GetErrorString(result)
	end
end


-- 社团改名请求
function msg_guild.cg_change_guild_name(szName)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_change_guild_name()
	else
		nmsg_guild.cg_change_guild_name(Socket.socketServer, szName)
	end
end

-- 返回社团改名结果
function msg_guild.gc_change_guild_name(result, szName)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		local data = {szName=szName}
		g_dataCenter.guild.detail:UpdateData(data)
		PublicFunc.msg_dispatch(msg_guild.gc_change_guild_name, szName)

		FloatTip.Float("修改成功")
	else
		PublicFunc.GetErrorString(result)
	end
end



-- 修改社团信息（改名有单独API）
function msg_guild.cg_update_guild_config(limitJoinLevel, ApproveRule, szDeclaration, nIcon)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		guild_data_local.cg_update_guild_config()
	else
		nmsg_guild.cg_update_guild_config(Socket.socketServer, limitJoinLevel, ApproveRule, szDeclaration, nIcon)
	end
end

-- 返回修改社团信息结果
function msg_guild.gc_update_guild_config(result, limitJoinLevel, ApproveRule, szDeclaration, nIcon)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		local data = {}
		data.limitJoinLevel = limitJoinLevel
		data.ApproveRule = ApproveRule
		data.szDeclaration = szDeclaration
		data.nIcon = nIcon
		g_dataCenter.guild.detail:UpdateData(data)

		--修改成功
		FloatTip.Float("修改成功")

		PublicFunc.msg_dispatch(msg_guild.gc_update_guild_config)
	else
		PublicFunc.GetErrorString(result)
	end
end


-- Push社团成员数据变更（0,添加，1删除，2更新）
-- 参考<SGuildMemberData>
-- struct SGuildMemberData
-- {
-- 	string playerid;    //玩家唯一id <Player>
-- 	string szName;
-- 	int nLevel;
-- 	int job;			// 玩家职位
-- 	bool bOnline;		// 玩家在线状态
-- 	int activePoints;			// 玩家可用活跃积分
-- 	int activeTotalPoints;		// 玩家贡献总活跃积分
-- 	int guildMoney;					// 帮币
-- }
function msg_guild.gc_update_member_data(ntype, memberData)
	if g_dataCenter.guild.detail then
		g_dataCenter.guild.detail:UpdateMemberData(ntype, memberData)
	end
	PublicFunc.msg_dispatch(msg_guild.gc_update_member_data, ntype, memberData)
end

-- Push社团信息
-- 参考<SGuildDetailData>
-- struct SGuildDetailData
-- {
-- 	string guildID;
-- 	int guildLevel;
-- 	int limitJoinLevel;
-- 	int IconIndex;
-- 	string createTime;
-- 	string  szName;
-- 	string szDeclaration;		// 公告
-- 	string szLeaderName;
-- 	int memberCnt;
-- 	int ApproveRule;			// 自动审批
-- 	int guildExp;			// 社团当前等级经验值
-- 	int activePoints;		// 社团当前活跃积分
-- }
function msg_guild.gc_update_guild_data(guildData)
	if g_dataCenter.guild.detail then
		g_dataCenter.guild.detail:UpdateData(guildData)
	end
	PublicFunc.msg_dispatch(msg_guild.gc_update_guild_data)
end

-- Push一条社团日志
function msg_guild.gc_add_guild_log(log)
	g_dataCenter.guild:InsertLog(log)
	PublicFunc.msg_dispatch(msg_guild.gc_add_guild_log)
end

-- Push其他社团数据变更（不做更新处理，打开社团列表界面及时拉取数据）
-- 参考<SGuildSimpleData>
-- struct SGuildSimpleData
-- {
-- 	string guildID;
-- 	int guildLevel;
-- 	int limitJoinLevel;
-- 	int IconIndex;
-- 	string createTime;
-- 	string  szName;
-- 	string szDeclaration;
-- 	string szLeaderName;
-- 	int memberCnt;
-- }
-- function msg_guild.gc_update_guild_simple(data)

-- end

-- Push社团申请记录变更： 0添加，1删除
-- 参考<SApplyPlayerData>
-- struct SApplyPlayerData
-- {
-- 	string name;
-- 	string playerid;
-- 	int player_level;
-- }
function msg_guild.gc_update_apply_data(ntype, data)
	if ntype == 0 then
		g_dataCenter.guild:InsertApplyItem(data)
	elseif ntype == 1 then
		g_dataCenter.guild:RemoveApplyItem(data)
	end
	PublicFunc.msg_dispatch(msg_guild.gc_update_apply_data);
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Guild_Hall_Verify);
end

-- 同步自己申请的社团ID
function msg_guild.gc_sync_my_apply_guild(guildid)
	if guildid then
		g_dataCenter.guild:SetApplyGuildId(guildid)
	end
end

-- 同步自己申请的社团ID（服务器保证登录游戏是gc_sync_guild_base_data消息先发）
function msg_guild.gc_sync_my_guild(guildid, lastQuitTime)
	if guildid then
        local oldGuildId = g_dataCenter.guild.myGuildId
		g_dataCenter.guild:SetLastQuitTime(lastQuitTime)
		g_dataCenter.guild:SetMyGuildId(guildid)

        --语音社团聊天
        Im.handle_voice_guild(oldGuildId, guildid)

        local ownGuild = (tonumber(guildid) ~= 0)
        --游戏中加入社团成功，立即拉取1次数据，保证红点状态显示正确
        if ownGuild and g_dataCenter.guild:GetDetail() == nil then
			msg_guild.cg_request_my_guild_data();
		end

		PublicFunc.msg_dispatch(msg_guild.gc_sync_my_guild, oldGuildId, guildid)
		NoticeManager.Notice(ENUM.NoticeType.GuildDataChange, oldGuildId, guildid)
		if ownGuild then
			if g_dataCenter.guild:GetDetail() then
				GNoticeGuideTip(Gt_Enum_Wait_Notice.Guild_Wait_Enter);
			else
				-- 等到数据回了再通知小红点系统
			end
		else
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Guild_Wait_Exit);
		end
	end
end

-- 社团捐献 1 金币;2 钻石
function msg_guild.cg_guild_donate(type)
	--if not Socket.socketServer then return end

	if isLocalData then
	else
		nmsg_guild.cg_sync_guild_lab_level_info(Socket.socketServer,type)
	end
end
function msg_guild.gc_guild_donate(ret)
	if ret == 0 then
		-- g_dataCenter.guild:SetMemberActivityData(ntype+1, listRecord)
		PublicFunc.msg_dispatch(msg_guild.gc_guild_donate, ret)
	else
		PublicFunc.GetErrorString(ret)
	end
end

-- 社团捐献
function msg_guild.cg_guild_tech_donate(type)
	--if not Socket.socketServer then return end

	if isLocalData then
	else
		nmsg_guild.cg_guild_tech_donate(Socket.socketServer,type)
	end
end
function msg_guild.gc_guild_tech_donate(ret, id , addExp, addContribution, newLevelInfo)
	if ret == 0 then
		-- 仅同步社团等级变化
		if id == 0 then
			g_dataCenter.guild:UpdateGuildLevelInfo(newLevelInfo.level)
		end
		PublicFunc.msg_dispatch(msg_guild.gc_guild_tech_donate, ret, id , addExp, addContribution, newLevelInfo)
	else
		PublicFunc.GetErrorString(ret)
	end
end

-- 获取帮派等级详细
function msg_guild.cg_sync_guild_level_info()
	--if not Socket.socketServer then return end

	if isLocalData then
	else
		nmsg_guild.cg_sync_guild_level_info(Socket.socketServer)
	end
end
function msg_guild.gc_sync_guild_level_info(result, level, curExp, todayGrowExp, todayGrowContribution)
	if result == 0 then
		g_dataCenter.guild:UpdateGuildLevelInfo(level, curExp, todayGrowExp, todayGrowContribution)
		PublicFunc.msg_dispatch(msg_guild.gc_sync_guild_level_info,result, level, curExp, todayGrowExp);
	else
		PublicFunc.GetErrorString(result);
	end
end
function msg_guild.gc_sync_remain_donate_times(times)
	g_dataCenter.guild:SetDonateTimes(times);
	PublicFunc.msg_dispatch(msg_guild.gc_sync_remain_donate_times,times);
end

-- type 科技类别;  1 实验室, 2 社团BOSS
function msg_guild.cg_sync_guild_tech_level_info(type)
	--if not Socket.socketServer then return end

	if isLocalData then
	else
		nmsg_guild.cg_sync_guild_tech_level_info(Socket.socketServer,type)
	end
end
function msg_guild.gc_sync_guild_tech_level_info(result, type, levelInfo)
	if result == 0 then
		for k,v in pairs(levelInfo) do
			g_dataCenter.guild:UpdateScienceInfo(type, v.type, v.level, v.curExp);
		end
		PublicFunc.msg_dispatch(msg_guild.gc_sync_guild_tech_level_info,result, type, levelInfo);
	else
		PublicFunc.GetErrorString(result);
	end
end


function msg_guild.cg_send_guild_mail(title, content)
	GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
	nmsg_guild.cg_send_guild_mail(Socket.socketServer, title, content)
end

function msg_guild.gc_send_guild_mail(result)
	GLoading.Hide(GLoading.EType.msg)
	if result == 0 then
		PublicFunc.msg_dispatch(msg_guild.gc_send_guild_mail);
	else
		PublicFunc.GetErrorString(result)
	end
end

-- 登录游戏有社团时才会同步一次
function msg_guild.gc_sync_guild_base_data(detailData, applyCount, job)
	g_dataCenter.guild:UpdateGuildBaseData(detailData, applyCount, job)
end

-- 请求所有日志
function msg_guild.cg_request_all_log()
	--if not Socket.socketServer then return end
	nmsg_guild.cg_request_all_log(Socket.socketServer)
end
function msg_guild.gc_request_all_log(vecLog)
	g_dataCenter.guild:LoadLogData(vecLog);
	PublicFunc.msg_dispatch(msg_guild.gc_request_all_log);
end

-- 请求申请列表
function msg_guild.cg_request_all_apply_data()
	--if not Socket.socketServer then return end
	nmsg_guild.cg_request_all_apply_data(Socket.socketServer)
end
function msg_guild.gc_request_all_apply_data(vecdata)
	g_dataCenter.guild:LoadApplyData(vecdata)
	PublicFunc.msg_dispatch(msg_guild.gc_request_all_apply_data);
end
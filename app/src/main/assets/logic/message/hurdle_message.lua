
local localMode = false;
--
local EGetAwardState = 
{
	success =  0,
	packageNotEnough   =  1,
}

msg_hurdle = msg_hurdle or {};
-----------客户端到服务器--------------------
function msg_hurdle.cg_take_award(id, index)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg);
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_hurdle.cg_take_award(robot_s, "..tostring(id)..", "..tostring(index)..")")
	end
	nmsg_hurdle.cg_take_award(Socket.socketServer, id, index)
end

function msg_hurdle.cg_hurdle_fight(hurdle_id, isAutoFight)
	--if not Socket.socketServer then return end
	--GLoading.Show(GLoading.EType.msg);
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_hurdle.cg_hurdle_fight(robot_s, "..hurdle_id..", "..tostring(isAutoFight)..")")
	end
	nmsg_hurdle.cg_hurdle_fight(Socket.socketServer, hurdle_id, isAutoFight);

end


function msg_hurdle.cg_hurdle_fight_result(hurdle_id, use_time, isAutoFight, star, flags, openedBoxDropID)
	--app.log("======================over===============")
	--cj添加 弱网模式
	--Socket.Set_isSilence(false)
	Socket.IsSilence = false
	--if not Socket.socketServer then return end
	--GLoading.Show(GLoading.EType.msg);
	flags = flags or {}
    openedBoxDropID = openedBoxDropID or {}
	if isAutoFight == nil then isAutoFight = false end
    if AppConfig.script_recording then
    	local _openedBoxDropID = "local openedBoxDropID = {}\n"
    	for i=1, #openedBoxDropID do
			_openedBoxDropID = _openedBoxDropID.."openedBoxDropID["..i.."]="..tostring(openedBoxDropID[i]).."\n"
	  	end
	  	local _flags = "local flags = {}\n"
	  	for i=1, #flags do
			_flags = _flags.."flags["..i.."]="..tostring(flags[i]).."\n"
	  	end
		PublicFunc.RecordingScript(_openedBoxDropID.._flags.."nmsg_hurdle.cg_hurdle_fight_result(robot_s, "..tostring(hurdle_id)..", "..tostring(use_time)..", "..tostring(isAutoFight)..", "..tostring(star)..", flags, openedBoxDropID)")
	end
	g_dataCenter.player:SetOldFightValue(0)
	nmsg_hurdle.cg_hurdle_fight_result(Socket.socketServer, hurdle_id, use_time, isAutoFight, star, flags, openedBoxDropID);
end

function msg_hurdle.cg_hurdle_saodang(hurdle_id, times, item)
	--扫荡经验会变化 新手引导检查是否中断
	if GuideManager then
		GuideManager.CheckStopGuide()
	end

	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg);
	if AppConfig.script_recording then
		local _item = "local item = {}\n"
		for k, v in pairs(item) do
			_item = _item.."item["..tostring(k).."] = "..tostring(v).."\n"
		end
		PublicFunc.RecordingScript(_item.."nmsg_hurdle.cg_hurdle_saodang(robot_s, "..tostring(hurdle_id)..", "..tostring(times)..", _item)")
	end
	nmsg_hurdle.cg_hurdle_saodang(Socket.socketServer, hurdle_id, times, item)
end

function msg_hurdle.cg_hurlde_box(hurdle_id)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg);
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_hurdle.cg_hurlde_box(robot_s, "..tostring(hurdle_id)..")")
	end
	nmsg_hurdle.cg_hurlde_box(Socket.socketServer, hurdle_id)
end

function msg_hurdle.cg_reset_hurdle(hurdle_id)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg);
	nmsg_hurdle.cg_reset_hurdle(Socket.socketServer, hurdle_id)
end


function msg_hurdle.cg_update_fight_key_frame_info(info)
	--if not Socket.socketServer then return end
	nmsg_hurdle.cg_update_fight_key_frame_info(Socket.socketServer, info)
end

function msg_hurdle.cg_open_new_group_animation(hurdleType)
	--if not Socket.socketServer then return end
	GLoading.Show(GLoading.EType.msg);
	if AppConfig.script_recording then
		PublicFunc.RecordingScript("nmsg_hurdle.cg_open_new_group_animation(robot_s, "..tostring(hurdleType)..")")
	end
	nmsg_hurdle.cg_open_new_group_animation(Socket.socketServer, hurdleType)
end


-----------服务器到客户端--------------------
function msg_hurdle.gc_hurdle_group_info(group_id, group_anim_id)
	--app.log("最大章节..."..table.tostring(group_id))
	if(group_id == nil) then
		return nil;
	end
	g_dataCenter.hurdle:SetCurGroup(group_id, group_anim_id);
end

function msg_hurdle.gc_hurdle_group_list(hurdle_group_id,info,groupAward)
	--app.log("章节信息.."..table.tostring({hurdle_group_id,info,groupAward}));
	if(info == nil or groupAward == nil) then
		return nil;
	end
	g_dataCenter.hurdle:UpdateGroupHurdleInfo(hurdle_group_id,info,groupAward);
end

function msg_hurdle.gc_take_award(result, id, index, drop_items)
	GLoading.Hide(GLoading.EType.msg);
	local rt = PublicFunc.GetErrorString(result)
	if rt then
		g_dataCenter.hurdle:UpdateGroupAwardInfo(id, index);
		PublicFunc.msg_dispatch(msg_hurdle.gc_take_award, drop_items, id, index);
		CommonAward.Start(drop_items);
	end
end

function msg_hurdle.gc_hurdle_fight(result, hurdle_id)
	--GLoading.Hide();
	--cj添加 弱网模式
	--Socket.Set_isSilence(true)
	Socket.IsSilence = true
	app.log("start hurdle 关卡....."..app.get_time())
	local show = PublicFunc.GetErrorString(result);
	if show then
		
		msg_hurdle.hurdle_fight_id = hurdle_id
		msg_hurdle.hurdle_fight_last_pass = g_dataCenter.hurdle:IsPassHurdle(hurdle_id)

		AudioManager.Stop(nil, true);
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight)
		PublicFunc.msg_dispatch(msg_hurdle.gc_hurdle_fight, hurdle_id);
		local fs = FightStartUpInf:new()
	    local defTeam = g_dataCenter.player:GetDefTeam()
        PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
	    fs:SetLevelIndex(hurdle_id)
	    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
	    SceneManager.PushScene(FightScene,fs)
	end
end

function msg_hurdle.gc_hurdle_fight_result(result, hurdle_id, star, flags, drop_items, actEx_items)
	Socket.Set_isSilence(false)
	--app.log("....."..table.tostring({result, hurdle_id, star, drop_items}))
	--GLoading.Hide();
    -- 临时移到发消息的时候直接显示了
    -- SettlementUi.Init({});
    -- Root.get_root_ui_2d_fight():set_active(false);
    -- app.log("..."..tostring(hurdle_id).."    "..tostring(result).."   "..table.tostring(drop_items));
    local show = PublicFunc.GetErrorString(result);
    if show then
    	--中途退出 不需要作处理 因为战斗设置ui那边发了个消息后就退出了 没有等消息返回
    	if star < 0 then
    		--FightScene.ExitFightScene();
    	--失败
    	elseif star == 0 then
    		local cfHurlde = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
			local data = 
			{
				-- star = 
		  --   	{
		  --   		star = 0, 
		  --   		conditionDes = {cfHurlde.win_describe, cfHurlde.good_describe, cfHurlde.perfact_describe}, 
		  --   		showTitle = true, 
		  --   	},
		    	jump = 
		    	{
		    		jumpFunctionList = {ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp, ENUM.ELeaveType.HeroEgg},
		    	}
			}
			CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
	    	if ScreenPlay.IsRun() then
		    	ScreenPlay.SetCallback(CommonClearing.Start, data);
		    else
		    	CommonClearing.Start(data);
		    end
	    --成功
    	else

            drop_items = PublicFunc.MergeNetSummeryNetList(drop_items)

    		g_dataCenter.hurdle:UpdateHurdleStar(hurdle_id, star, flags);
	    	local cfHurlde = ConfigHelper.GetHurdleConfig(hurdle_id);
	    	local defTeam = g_dataCenter.player:GetDefTeam();
	    	local isGood = FightRecord.IsGood();
	    	local isPerfect = FightRecord.IsPerfect();
		    local data = 
		    {
		    	star = 
		    	{
		    		star = star, 
		    		finishConditionInfex = {true, isGood, isPerfect}, 
		    		conditionDes = {cfHurlde.win_describe, cfHurlde.good_describe, cfHurlde.perfact_describe}, 
		    		showTitle = true, 
		    	},
		    	addexp =
		    	 {	
		    	 	player = nil;
		    	 	cards = {};
                    awards = {};
                    extraAwards = {};
		    	 },
		    	--awards = nil,
		    	-- {
		    	-- 	awardsList = {net_summary_item，net_summary_item，net_summary_item},
		    	-- 	tType = 1,
		    	-- }
		    };
		    --app.log(tostring(hurdle_id).."........"..tostring(star).."xxxxxxxxxxxxxxx"..table.tostring(drop_items));
			local get_hero_hurdle_id = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guide_get_hero_hurdle_id).data
			if get_hero_hurdle_id == msg_hurdle.hurdle_fight_id and not msg_hurdle.hurdle_fight_last_pass then
				local heroCid = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guide_hurdle_get_hero_id).data
				data.gethero = {number=heroCid}
			end

			--无论玩家或者角色是否增加经验，界面都需要显示
			data.addexp.player = g_dataCenter.player
			for k,v in pairs(defTeam) do
				if v then
					local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v);
					if hero then
						table.insert(data.addexp.cards, hero);
					end
				end
			end

		    for k, v in pairs(drop_items) do
		    	if PropsEnum.IsVaria(v.id) then
					--[[
		    		if PropsEnum.IsExp(v.id) then
		    			--data.addexp = data.addexp or {};
		    			data.addexp.player = g_dataCenter.player;
		    		elseif PropsEnum.IsHeroExp(v.id) then
		    			local cf = ConfigManager.Get(EConfigIndex.t_drop_something,cfHurlde.pass_award);
		    			if cf then
		    				local list = {};
			    			for k, v in pairs(cf) do
			    				if PropsEnum.IsHeroExp(v.goods_id) then
			    					--data.addexp = data.addexp or {};
			    					--data.addexp.cards = data.addexp.cards or {};
			    					--等于0是将所有英雄加经验
			    					if v.param == 0 then
										for k,v in pairs(defTeam) do
											if v then
												local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v);
												if hero then
													table.insert(data.addexp.cards, hero);
												end
											end
										end
			    					else
			    						local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[v.param]);
			    						if hero then
			    							table.insert(data.addexp.cards, hero);
			    						end
			    					end
			    				end
			    			end
			    		end
			    	else
--			    		data.awards = data.awards or {};
--			    		data.awards.awardsList = data.awards.awardsList or {}
--			    		table.insert(data.awards.awardsList, v);	
		    		end
					]]
		    	else
--		    		data.awards = data.awards or {};
--		    		data.awards.awardsList = data.awards.awardsList or {}
--		    		table.insert(data.awards.awardsList, v);
		    	end

                table.insert(data.addexp.awards, v)
		    end

		    for k,v in pairs(actEx_items) do
		    	table.insert(data.addexp.extraAwards, v)
		    end

		    CommonClearing.SetFinishCallback(FightScene.ExitFightScene);
		    if ScreenPlay.IsRun() then
		    	ScreenPlay.SetCallback(CommonClearing.Start, data);
		    else
		    	CommonClearing.Start(data);
		    end
    	end
    else
    	-- 出错了，同时不在主场景就退出战斗场景回到主场景
    	if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
    		FightScene.ExitFightScene();
    	end
	end
end

function msg_hurdle.gc_hurdle_saodang(result, hurdle_id, times, needItems, realTimes, getItemsCount, drop_items, awardsEx)
	GLoading.Hide(GLoading.EType.msg);
	local info = PublicFunc.GetErrorString(result);
	if info then
		--记得关卡次数需要客户端自己加
		g_dataCenter.hurdle:AddHurdleTimes(hurdle_id, realTimes);
		PublicFunc.msg_dispatch(msg_hurdle.gc_hurdle_saodang, hurdle_id, times, needItems, realTimes, getItemsCount, drop_items, awardsEx);
	end
end

function msg_hurdle.gc_hurdle_finish_count()
	g_dataCenter.hurdle:ResetAllHurdleCount();
	PublicFunc.msg_dispatch(msg_hurdle.gc_hurdle_finish_count);
end

function msg_hurdle.gc_hurlde_box(result, hurdle_id, drop_items)
	GLoading.Hide(GLoading.EType.msg);
	local info = PublicFunc.GetErrorString(result);
	if info then
		g_dataCenter.hurdle:GetHurdleBox(hurdle_id);
		PublicFunc.msg_dispatch(msg_hurdle.gc_hurlde_box, drop_items, hurdle_id);
		CommonAward.Start(drop_items);
	end
end

function msg_hurdle.gc_reset_hurdle(result, hurdle_id)
	GLoading.Hide(GLoading.EType.msg);
	local info = PublicFunc.GetErrorString(result);
	if info then
		g_dataCenter.hurdle:ResetHurdleCount(hurdle_id);
		PublicFunc.msg_dispatch(msg_hurdle.gc_reset_hurdle, hurdle_id);
	end
end



function msg_hurdle.gc_open_new_group_animation(result, hurdleType)
	GLoading.Hide(GLoading.EType.msg);
	local info = PublicFunc.GetErrorString(result);
	if info then
		g_dataCenter.hurdle:SetGroupAnimId(hurdleType, 0);
		PublicFunc.msg_dispatch(msg_hurdle.gc_open_new_group_animation);
	end
end

--属性检测--开始
function msg_hurdle.cg_attribute_verify_start(play_method_type, hurdle_id)
	--if not Socket.socketServer then return end
	nmsg_hurdle.cg_attribute_verify_start(Socket.socketServer, play_method_type, hurdle_id)
end

--属性检测--创建英雄
function msg_hurdle.cg_attribute_verify_create_hero(play_method_type, dataid, gid)
    --if not Socket.socketServer then return end
    --[[if AppConfig.script_recording then
        local _dataid = ""
        local _gid = ""
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, dataid)
        if card then
            _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
            _gid = _gid.."g_all_role_gid["..tostring(card.all_role_cards_index).."]"
            
        end
        PublicFunc.RecordingScript("msg_hurdle.cg_attribute_verify_create_hero(robot_s, "..tostring(play_method_type)..", ".._dataid..", ".._gid..")")
    end]]
    nmsg_hurdle.cg_attribute_verify_create_hero(Socket.socketServer, play_method_type, dataid, gid)
end

--属性检测--上传属性
function msg_hurdle.cg_attribute_verify_upload(play_method_type, upload_info)
    --if not Socket.socketServer then return end
    --[[if AppConfig.script_recording then
        local _upload_info = "\
        local upload_info = {}\
        local attribute_verify_upload_info = nil\n"
        for i=1, #upload_info do
            _upload_info = _upload_info.."\
            attribute_verify_upload_info = {}\n"
            local entity = ObjectManager.GetObjectByGID(upload_info[i].gid)
            local cards_index = 0
            if entity then
                cards_index = entity.card.all_role_cards_index
            end
            _upload_info = _upload_info.."\
            attribute_verify_upload_info.gid = g_all_role_gid["..tostring(cards_index).."]\
            attribute_verify_upload_info.attribute = {}\n"
            for j=1, #upload_info[i].attribute do
                _upload_info = _upload_info.."\
                attribute_verify_upload_info.attribute["..tostring(j).."] = {}\
                attribute_verify_upload_info.attribute["..tostring(j).."].attribute_type = "..tostring(upload_info[i].attribute[j].attribute_type).."\
                attribute_verify_upload_info.attribute["..tostring(j).."].value = "..tostring(upload_info[i].attribute[j].value).."\n"
            end
            _upload_info = _upload_info.."table.insert(upload_info, attribute_verify_upload_info)\n"
        end
        PublicFunc.RecordingScript(_upload_info.."msg_hurdle.cg_attribute_verify_upload(robot_s, "..tostring(play_method_type)..", upload_info)")
    end]]

    nmsg_hurdle.cg_attribute_verify_upload(Socket.socketServer, play_method_type, upload_info)
end

--属性检测--上传属性更改
function msg_hurdle.cg_attribute_verify_change_info(play_method_type, change_info)
    --if not Socket.socketServer then return end
    --[[if AppConfig.script_recording then
        local _change_info = "local change_info = {}\n"
        for i=1, #change_info do
            _change_info = _change_info.."\
            change_info["..i.."] = {}\n"
            local entity = ObjectManager.GetObjectByGID(change_info[i].gid)
            local cards_index = 0
            if entity then
                cards_index = entity.card.all_role_cards_index
            end
            _change_info = _change_info.."\
            change_info["..i.."].gid = g_all_role_gid["..tostring(cards_index).."]\
            change_info["..i.."].scale_type = "..tostring(change_info[i].scale_type).."\
            change_info["..i.."].ability_type = "..tostring(change_info[i].ability_type).."\
            change_info["..i.."].value = "..tostring(change_info[i].value).."\
            change_info["..i.."].change = "..tostring(change_info[i].change).."\n"
        end
        PublicFunc.RecordingScript(_change_info.."msg_hurdle.cg_attribute_verify_change_info(robot_s, "..tostring(play_method_type)..", change_info)")
    end]]
    nmsg_hurdle.cg_attribute_verify_change_info(Socket.socketServer, play_method_type, change_info)
end

--属性检测--结束
function msg_hurdle.cg_attribute_verify_over()
    --if not Socket.socketServer then return end
    --[[if AppConfig.script_recording then
        PublicFunc.RecordingScript("msg_hurdle.cg_attribute_verify_over(robot_s)")
    end]]
    nmsg_hurdle.cg_attribute_verify_over(Socket.socketServer)
end

function msg_hurdle.gc_attribute_verify_error(play_method_type, hero_id)
    --app.log("属性检测出现异常 [play_method_type="..tostring(play_method_type).."][hero_id="..hero_id.."]")
end
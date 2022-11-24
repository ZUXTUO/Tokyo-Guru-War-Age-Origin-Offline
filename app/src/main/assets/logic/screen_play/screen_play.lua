-- 剧情逻辑类

ScreenPlayTalkView = {

}

function ScreenPlayTalkView.ShowTalk(content,talker_name,icon_path,audio_id,sideType,is_auto,is_skip,is_black, is_pause, is_mmo, is_last_audio)
    app.log_warning("---talker_name=",talker_name," content=",content)
    if not is_mmo then
        ScreenPlayChat.ShowTalk(
		    {side=sideType, icon_path=icon_path, dlg=content, name = talker_name, audio_id = audio_id, 
		    enable_auto = is_auto, enable_skip = is_skip, enable_black = is_black, enable_pause = is_pause, is_last_audio = is_last_audio})
    else
        ScreenPlayChatMMO.ShowTalk(
		    {side=sideType, icon_path=icon_path, dlg=content, name = talker_name, audio_id = audio_id, 
		    enable_auto = is_auto, enable_skip = is_skip, enable_black = is_black, enable_pause = is_pause, is_last_audio = is_last_audio})
    end
	
end

--[[读取配置，获取触发场景配置，和组织各种action]]
ScreenPlay = {
-- 对象在clean里面罗列
}

function ScreenPlay.Clean()
	ScreenPlay.section = {};		-- 一个个剧情章节
	ScreenPlay._cur_section = nil;	-- 当前剧情在哪个章节
	ScreenPlay._cur_action = nil;	-- 当前剧情在哪个action
	ScreenPlay._cur_playid = nil;	-- 当前剧情的配置id
	ScreenPlay.isRun = false;		-- 剧情是否在运行
	ScreenPlay.callbackFunc = nil;	-- 剧情完了的回调函数
	ScreenPlay.callbackParam = nil; -- 剧情完了的回调参数
end

function ScreenPlay.isMMoMap(hurdleid)
    if hurdleid < 20000 and hurdleid >=10000 then
        return true;
    end
   return false;
end

function ScreenPlay.LoadMMoConfig()
    for k,v in pairs(ConfigManager._GetConfigTable(EConfigIndex.t_screenplay_config)) do
        if ScreenPlay.isMMoMap(k) then
            ScreenPlay.LoadConfig(k)
        end
    end
    -- app.log("mmo总地图剧情:"..table.getall(ScreenPlay.section ))
end

--[[加载配置表]]
function ScreenPlay.LoadConfig(hurdleid)
	-- TODO 从数据中心取配置，获取登场对象名字
	local data = ConfigManager.Get(EConfigIndex.t_screenplay_config,hurdleid);
	    if data == nil then
	        return
	    end
	--剧情构造
	--｛
	--	section_sub子剧情 = ｛trigger = ｛id=xxx, des=xxx｝, action = {action_sub谈话类容，action_sub谈话类容} ｝
	--	section_sub子剧情
	--｝
	--注：action_sub = ｛actor = "aside_2", talk(类型) = "内容", audio_id=xxx, icon_path="头像路径"｝
	for i = 1, #data do
		local k = i;
		local v = data[i];
		local section_sub ={};
		section_sub.playid = v.playid;
		section_sub.trigger = {id = v.triggerid, des = 'xxxxx'};
		section_sub.playerObjs = {}
		--加载剧情对象
		ScreenPlay.LoadPlayObj(section_sub.playerObjs, v.scene_obj);
		section_sub.action = {};
		section_sub.talkCount = 0;
		section_sub.haveBossShow = false;
		local actions = ConfigManager.Get(EConfigIndex.t_screenplay_content,v.playid);
		-- 罗列action内容
		for j = 1, #actions do
			local ak = j;
			local av = actions[j];
		--for ak,av in pairs(actions) do
			local action_sub = {}
			action_sub.actor = av.actor;
			action_sub[av.actiontype] = av.action;
			action_sub.audio_id = av.audio_id;
			action_sub.icon_path = av.icon_path;
			action_sub.actor_pos = av.actor_pos;
			action_sub.is_skip = av.is_skip;
			action_sub.is_black = av.is_black;
			action_sub.is_pause = av.is_pause;
			action_sub.is_mmo = av.is_mmo == 1;
			if av.actiontype == "talk" then
				section_sub.talkCount = section_sub.talkCount + 1
				section_sub.haveBossShow = false;
			end
			if av.actiontype == "func" then
				if type(av.action) == "table" then
					if av.action[1] == "BossShow" or av.action[1] == "TriggerStory" then
						section_sub.haveBossShow = true;
					end
				end
			end
			table.insert(section_sub.action, action_sub);
		end
        
		table.insert(ScreenPlay.section, section_sub);
        --app.log("地图剧情:"..table.getall(ScreenPlay.section ).." "..table.tostring(section_sub))
	end
end

function ScreenPlay.LoadPlayObj(playerObjs, config_play_obj)
	--构建的剧情对象
	--playerObjs = 
	--{
	--	k(hero_,boss_,aside_) = {1,利世}
	--}
	for k,v in pairs(config_play_obj) do
		-- 获取hero_x系列
		local spos = string.find(k,'hero_', 1, true)
		if spos then
			local index = tonumber(string.sub(k,-spos));
			if index then
				playerObjs[k] = g_dataCenter.fight_info:GetControlHeroName(index);
			end
		end
		-- 获取boss_x系列
		spos = string.find(k,'boss_', 1, true)
		if spos then
			local index = tonumber(string.sub(k,-spos));
			if index and type(v) == type(1) then
				local obj = ObjectManager.GetObjectByNumber(v);
				if obj then
					playerObjs[k] = obj:GetConfig("name");
				else
					playerObjs[k] = "";
				end
			end
		end
		-- 旁白aside_x系列
		spos = string.find(k,'aside_', 1, true)
		if spos then
			local index = tonumber(string.sub(k,-spos));
			if index and type(v) == type({}) then
				playerObjs[k] = v;
			end
		end
	end

end

function ScreenPlay.Play(playid)
	if not ScreenPlay.section then
		return
	end

	--AudioManager.SetAudioVolume(0.5, ENUM.EAudioType._2d)
	-- 查找当前配置里面有没有关心这个触发器的，如果有，则进入对应剧情。
	for i = 1, #ScreenPlay.section do
		local v = ScreenPlay.section[i];
		if v.playid == playid then
            --玩法ID修改后需要注意
			-- if FightScene.GetCurHurdleID() == 60120002 then
			-- 	local id = v.playid - 60041000 - 1
			-- 	system.cg_add_guide_log(2000000, id)
			-- end
			NoticeManager.Notice(ENUM.NoticeType.ScreenPlayBegin, v.playid)

			ScreenPlay._cur_section = i;
			ScreenPlay._cur_action = 0;
			ScreenPlay._cur_playid = v.playid;
			ScreenPlay.NextAction()
			break;
		end
	end

	
end


-- SCREENPLAY_DEBUG = true;
--[[外部触发了某个触发器，同时通知剧情，看要不要来点剧情]]
function ScreenPlay.TriggerPlay(triggerid)
	if not ScreenPlay.section then
		return
	end

	--AudioManager.SetAudioVolume(0.5, ENUM.EAudioType._2d)

	if SCREENPLAY_DEBUG then
		--app.log('huhu_screenplay_debug 触发事件，检查有没有剧情 '..'\n'..table.tostring(ScreenPlay.section))
	end
	-- 查找当前配置里面有没有关心这个触发器的，如果有，则进入对应剧情。
	for i = 1, #ScreenPlay.section do
		local v = ScreenPlay.section[i];
		if v.trigger and v.trigger.id == triggerid then
			--玩法ID修改后需要注意
			-- if FightScene.GetCurHurdleID() == 60120002 then
			-- 	local id = v.playid - 60041000 - 1
			-- 	system.cg_add_guide_log(2000000, id)
			-- end
			NoticeManager.Notice(ENUM.NoticeType.ScreenPlayBegin, v.playid)

			ScreenPlay._cur_section = i;
			ScreenPlay._cur_action = 0;
			ScreenPlay._cur_playid = v.playid;
			ScreenPlay.NextAction()
			break;
		end
	end
end

--[[开始下一个action]]
function ScreenPlay.NextAction()
	if not ScreenPlay.section then
		return
	end
	if SCREENPLAY_DEBUG then
		--app.log('huhu_screenplay_debug NextAction '..'\n'..table.tostring(ScreenPlay))
	end
	-- TODO 根据保存的当前序号，走下一个，然后更新当前序号。
	if not ScreenPlay._cur_section then
		return
	end
    --开始第一个或者下一个动作序列
	if not ScreenPlay._cur_action or ScreenPlay._cur_action == 0 then
		ScreenPlay._cur_action = 1
	else
		ScreenPlay._cur_action = ScreenPlay._cur_action + 1
	end
	local curSection = ScreenPlay.section[ScreenPlay._cur_section];
	--判断剧情是否结束
	if ScreenPlay._cur_action > #curSection.action then
		ScreenPlay.PlayOver();
		return
	end
	ScreenPlay.DoAction(curSection.playerObjs ,curSection.action[ScreenPlay._cur_action])
end

--跳过剧情
function ScreenPlay.DoCallback()
	if type(ScreenPlay.callbackFunc) == "function" then
		ScreenPlay.callbackFunc(ScreenPlay.callbackParam);
		ScreenPlay.callbackFunc = nil;
		ScreenPlay.callbackParam = nil;
	end

	AudioManager.ChangeBackAudioVol(1, 2000)
	ScreenPlay.isJiangdi = false;
end

--[[直接传配置中的action配置]]
function ScreenPlay.DoAction(playerObjs, action_config)
	if not ScreenPlay.section then
		return
	end
	--剧情开始
	ScreenPlay.isRun = true;
	if action_config.talk then
		ScreenPlay.ActionTalk(playerObjs[action_config.actor], action_config)
		if not ScreenPlay.isJiangdi then
			ScreenPlay.isJiangdi = true
			AudioManager.ChangeBackAudioVol(0.3, 2000)
		end
	else
		ScreenPlayChat.BreakTalk()
		ScreenPlayChatMMO.BreakTalk()
		if action_config.func then
			if ScreenPlay.isJiangdi then
				ScreenPlay.isJiangdi = false
				AudioManager.ChangeBackAudioVol(1, 2000)
			end
			if SCREENPLAY_DEBUG then
				--app.log('huhu_screenplay_debug 触发FuncAction！ '..tostring(action_config.func)..'\n'..table.tostring(action_config))
			end
			if type(action_config.func) == type({}) then
				local param = {};
				for k,v in pairs(action_config.func) do
					if k ~= 1 then
						param[k] = v;
					end
				end
				TriggerFunc[action_config.func[1]](ScreenPlay.FuncOver,param);
			else
				TriggerFunc[action_config.func](ScreenPlay.FuncOver);
			end
		else
			app.log("错误剧情配置。 screenplay:"..tostring(ScreenPlay._cur_playid).." index:"..tostring(ScreenPlay._cur_action))
		end
	end
end

--[[说话，第一个是谁说话，可能是对象名字，也可能是旁白表。]]
function ScreenPlay.ActionTalk(talker,action_config)
	-- app.log_warning("action_config="..table.tostring(action_config))
	local content = action_config.talk
	local icon_path = action_config.icon_path
	local audio_id = action_config.audio_id
	local side = action_config.actor_pos
	local is_auto = (action_config.is_auto == 1)
	local is_skip = (action_config.is_skip == 1)
	local is_black = (action_config.is_black == 1)
    local is_pause = (action_config.is_pause == 0)
    local is_mmo = action_config.is_mmo;
	local pos = string.find(content, '.', 1, true)
	local sideType = EDramaSide.Left;
	if side == 2 then
		sideType = EDramaSide.Right;
	elseif side == 0 then
		sideType = EDramaSide.Center;
	end

	if pos then
		content = PublicFunc.GetStringObj(content, '.', 1, true)
	end
	if SCREENPLAY_DEBUG then
		--app.log('huhu_screenplay_debug 触发TalkAction！ '..tostring(content)..'\n'..table.tostring(talker))
	end

	local curSection = ScreenPlay.section[ScreenPlay._cur_section];
	--判断剧情是否是最后一句
	local is_last_audio = false;
	local total_length = #curSection.action-1;
	if not curSection.curTalkCount then
		curSection.curTalkCount = 0;
	end
	curSection.curTalkCount = curSection.curTalkCount + 1
	if curSection.curTalkCount >= curSection.talkCount then
		is_last_audio = true;
	end

	if curSection.haveBossShow then
		is_last_audio = false;
	end

	if talker[2] then
		ScreenPlayTalkView.ShowTalk(content, talker[2], icon_path,audio_id,sideType, is_auto, is_skip, is_black, is_pause, is_mmo, is_last_audio);
	else
		ScreenPlayTalkView.ShowTalk(content, talker, icon_path,audio_id,sideType, is_auto, is_skip, is_black, is_pause, is_mmo, is_last_audio);
	end
end

function ScreenPlay.TalkOver()
	if SCREENPLAY_DEBUG then
		app.log('huhu_screenplay_debug 触发ScreenPlay.TalkOver！ ')
	end

	ScreenPlay.NextAction();
end

function ScreenPlay.FuncOver()
	if SCREENPLAY_DEBUG then
		app.log('huhu_screenplay_debug 触发ScreenPlay.FuncOver ')
	end
	ScreenPlay.NextAction();
end

--查看剧情是否在运行
function ScreenPlay.IsRun()
	return ScreenPlay.isRun;
end
-- 设置剧情完了的回调
function ScreenPlay.SetCallback(callback, param)
	ScreenPlay.callbackFunc = callback;
	ScreenPlay.callbackParam = param;
end

-- 剧情播放完成
function ScreenPlay.PlayOver()
	ScreenPlay.isRun = false;
	ScreenPlay.DoCallback();
	ScreenPlayChat.BreakTalk()
	ScreenPlayChatMMO.BreakTalk()
	NoticeManager.Notice(ENUM.NoticeType.ScreenPlayOver, ScreenPlay._cur_playid, false)
end

-- 剧情中途跳出
function ScreenPlay.Skip()
	if ScreenPlay.isRun then
		ScreenPlay.isRun = false;
		ScreenPlay.DoCallback();
	end
	ScreenPlayChat.BreakTalk()
	ScreenPlayChatMMO.BreakTalk()
	NoticeManager.Notice(ENUM.NoticeType.ScreenPlayOver, ScreenPlay._cur_playid or 0, true)
end

function ScreenPlay.SkipChat()
	if not ScreenPlay.section then
		return
	end
	-- TODO 根据保存的当前序号，走下一个，然后更新当前序号。
	if not ScreenPlay._cur_section then
		return
	end
	local curSection;
	repeat
	    --开始第一个或者下一个动作序列
		if not ScreenPlay._cur_action or ScreenPlay._cur_action == 0 then
			ScreenPlay._cur_action = 1
		else
			ScreenPlay._cur_action = ScreenPlay._cur_action + 1
		end
		curSection = ScreenPlay.section[ScreenPlay._cur_section];
		--判断剧情是否结束
		if ScreenPlay._cur_action > #curSection.action then
			ScreenPlay.PlayOver();
			return
		end
	until curSection.action[ScreenPlay._cur_action].func
	ScreenPlay.DoAction(curSection.playerObjs ,curSection.action[ScreenPlay._cur_action])
end

function ScreenPlay.Destroy()
	TriggerFunc.entityCameraObj = nil;
	TriggerFunc.FightBossEntity = nil;
	TriggerFunc.teamHero = nil;
	TriggerFunc.bossEntity = nil;
	FightLanguageUI.SetEndCallback();
	FightLanguageUI.EndCallback();
	TriggerFunc.DeleteScreenPlayObj();
	TriggerFunc.ClearShowCache();
end

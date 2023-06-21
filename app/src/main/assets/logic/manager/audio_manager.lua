--音效管理器

-- TODO: Unity 5.3.5 Bug: 音效不能释放www, 即不能 "assetbunle.unload(false)",所以需要给音效保留assetobj.
-- 因此加载目前调用的是 ResourceLoader.LoadRawAsset
local _unity_audio_bug_fixed = false; 


AudioManager = {};

--local assetObject = {};         --资源object
local audioObject = {};			--音乐gameObject对象
local volume = {};				--音量
local muteAudio = {};           --是否静音
local pauseAudio = {};           --是否静音
local fadeOutAudioObject = {};  --需要淡出停止的音乐gameObject对象
local fadeOutUiAudioObject = {};  --需要淡出停止的Ui音乐gameObject对象

local curBackAudioVolScale = 1;
local backAudioBeginVol = 1;
local backAudioEndVol = 1;
local isEndBackAudioUpdate = false;

--[id] = {high_pass={enable=false,cutoff=0,resq=0}, low_pass={enable=false,cutoff=0,resq=0}}
local temp2dFilterSetting = {};	--过滤器配置参数（程序动态调用，使用后移除）

for k,v in pairs(ENUM.EAudioType) do
	--assetObject[v] = {};
	audioObject[v] = {};
	volume[v] = 1;
	muteAudio[v] = false;
	pauseAudio[v] = false;
end

muteAudio[ENUM.EAudioType._2d] = {};
for k,v in pairs(ENUM.EAudioPlayer) do
	muteAudio[ENUM.EAudioType._2d][v] = false;
end

AudioManager.playList = {};
AudioManager.playMode = {};
AudioManager.cur2dBgmId = nil;
AudioManager.cur2dAudioNumber = {};
AudioManager.stop2dAudioTimerId = {};
AudioManager._2dAudioSourceNode = {};
AudioManager.load_list = {};
AudioManager.stop3dAudioTimerId = {};

local load_num = 0
local loading_call_back = nil;
local bindID = 0
local BindAudioCallBack = function( callbackFunc, data)
	bindID = bindID + 1	
	local name = 'on_audio_load_bin_'..bindID
	
	local fn = function(parm1, parm2, parm3, parm4, parm5, parm6)
		--_G[name] = nil
		if data then
			return callbackFunc(data,parm1, parm2, parm3, parm4, parm5, parm6);
		else
			return callbackFunc(parm1, parm2, parm3, parm4, parm5, parm6);
		end
    end;	
    
    _G[name] = fn
	return name
end

-------------------------------------------------------------------
----------------------------外部接口-------------------------------
--作用：播放3d音效
--param：音效id，依附的obj,是否在播放时将其转换成2d音效(默认为false)
--说明：3d音效为了保证及时性，可以提前进行加载
--      未进行预加载的音效会到时候再加载
--isUnique  是否是唯一的,会覆盖上一个
function AudioManager.Play3dAudio(id, obj, convertTo2d, follow, isUnique, autoStop, cbfunction, cbdata, volScale, openEcho)
	-- do return end;

	if not obj or not id then 
		app.log("AudioManager Play3dAudio   obj or id为空");
		return
	end
	convertTo2d = convertTo2d or false;
	isUnique = isUnique or false;
	if follow == nil then
		follow = true;
	end
	if autoStop == nil then
		autoStop = true;
	end
	if volScale == nil then
		volScale = 1;
	end

	if openEcho == nil then
		openEcho = false;
	end

	--local asset3dObject = assetObject[ENUM.EAudioType._3d];
	local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
	if not cfg then
		app.log("id == "..id.." 的audio配置表没有");
		return
	end
	local path = ConfigHelper.UpdateAudioPath(cfg);
	local asset = ResourceManager.GetRes(path);
	if(asset ~= nil)then
		local audio3dObject = audioObject[ENUM.EAudioType._3d];
		if(audio3dObject[id] == nil)then
			audio3dObject[id] = {};
		end
		local numAdObj = #audio3dObject[id];
		audio3dObject[id][numAdObj+1] = asset_game_object.create(asset);
		if follow then
			audio3dObject[id][numAdObj+1]:set_parent(obj);
			audio3dObject[id][numAdObj+1]:set_local_position(0,0,0);
		else
			local x,y,z = obj:get_position();
			if x and type(x) == "number" then
				audio3dObject[id][numAdObj+1]:set_position(x,y,z);
			end
		end
		
		local audiosource = audio3dObject[id][numAdObj+1]:get_component_audio_source();
		if openEcho then
			local audioEchoFilter = audio3dObject[id][numAdObj+1]:get_component_audio_echo_filter();
			if audioEchoFilter then
				audioEchoFilter:set_active(true);
				audioEchoFilter:set_delay(480);
				audioEchoFilter:set_decayRatio(0.4);
				audioEchoFilter:set_dryMix(1);
				audioEchoFilter:set_wetMix(0.4);
			end
		end
		audiosource:set_mute(muteAudio[ENUM.EAudioType._3d]);
		local volOrgScale = 1;
		if not cfg.volScale then
			app.log_warning("id == "..id.." 的audio volscale 配置没有");
		else
			volOrgScale = cfg.volScale;
		end

		audiosource:set_volume(volume[ENUM.EAudioType._3d] * volScale * volOrgScale);
		if convertTo2d then
			audiosource:set_pan_level(0);
		else
			audiosource:set_pan_level(1);
		end
		if isUnique then
			if AudioManager.cur3dAudioId and AudioManager.cur3dAudioNumAdObj then
				local obj = AudioManager.GetAudio3dObject(AudioManager.cur3dAudioId,AudioManager.cur3dAudioNumAdObj)
				if not obj then
					app.log_warning("obj==nil,AudioManager.cur3dAudioId,AudioManager.cur3dAudioNumAdObj=="..table.tostring({AudioManager.cur3dAudioId,AudioManager.cur3dAudioNumAdObj}));
				end
				--app.log("手动停止id=="..AudioManager.cur3dAudioId);
				AudioManager.Stop3dAudio(obj,AudioManager.cur3dAudioId,AudioManager.cur3dAudioNumAdObj, true);
			end
			AudioManager.cur3dAudioId = id;
			--app.log("新id=="..id);
			AudioManager.cur3dAudioNumAdObj = numAdObj+1;
		end
		--app.log("play  id=="..tostring(id).."num=="..tostring(numAdObj+1));
		audiosource:play();
		--app.log("audiosource==="..tostring(PublicStruct.Cur_Logic_Frame));
		local length = audiosource:get_audio_clip_length()*1000;
		--app.log("length==="..tostring(length).."id=="..id.."     time="..PublicStruct.Cur_Logic_Frame);
		local data = {};
		data.assetObj_id = id;
		data.audioObj_id = numAdObj+1;
		data.isUnique = isUnique;
		if autoStop then
            data.cbfunction = cbfunction;
            data.cbdata = cbdata;
            if not AudioManager.stop3dAudioTimerId[id] then
            	AudioManager.stop3dAudioTimerId[id] = {}
            end
            local funcName = BindAudioCallBack(AudioManager.Destroy3dAudioObj,data);
			local timerId = timer.create(funcName,length,1);
			AudioManager.stop3dAudioTimerId[id][numAdObj+1] = {}
			AudioManager.stop3dAudioTimerId[id][numAdObj+1].timerId = timerId
			AudioManager.stop3dAudioTimerId[id][numAdObj+1].funcName = funcName
		end
		return id,numAdObj+1,isUnique;
	else
		AudioManager.LoadAndPlay3dAudio(id, obj, convertTo2d, follow, isUnique, autoStop, cbfunction, cbdata, volScale);
		return id,1,isUnique;
	end
end

function AudioManager.GetAudio3dObject(id,numAdObj)
	local audio3dObject = audioObject[ENUM.EAudioType._3d];
	if not audio3dObject then
		app.log_warning("1111"..table.tostring({id,numAdObj}));
		return nil;
	end

	if not audio3dObject[id] then
		app.log_warning("2222"..table.tostring({id,numAdObj}));
		return nil;
	end
	if not audio3dObject[id][numAdObj] then
		app.log_warning("3333"..table.tostring({id,numAdObj}));
		return nil;
	end
	return audio3dObject[id][numAdObj];
end


--作用：停止某一个特定的3d音效（适用于技能音效被打断时）
--param：obj：音效gameobject对象
function AudioManager.Stop3dAudio(obj,id,numAdObj,isUnique)
	ResourceLoader.ClearGroupCallBack("3daudio_"..tostring(id))
	if not obj then 
		app.log_warning("AudioManager.Stop3dAudio obj为空,id,numAdObj,isUnique=="..table.tostring({id,numAdObj,isUnique}).."   来源"..debug.traceback());
		return
	end
	local audiosource = obj:get_component_audio_source();
    if audiosource then
	    audiosource:stop();
    end
    if AudioManager.stop3dAudioTimerId[id] and AudioManager.stop3dAudioTimerId[id][numAdObj] and AudioManager.stop3dAudioTimerId[id][numAdObj].timerId and AudioManager.stop3dAudioTimerId[id][numAdObj].funcName then
    	timer.stop(AudioManager.stop3dAudioTimerId[id][numAdObj].timerId);
    	_G[AudioManager.stop3dAudioTimerId[id][numAdObj].funcName] = nil;
    	AudioManager.stop3dAudioTimerId[id][numAdObj] = nil;
    	if table.get_num(AudioManager.stop3dAudioTimerId[id]) <= 0 then
    		AudioManager.stop3dAudioTimerId[id] = nil;
    	end
    end
	if id then
		local data = {};
		data.assetObj_id = id;
		data.audioObj_id = numAdObj;
		data.isUnique = isUnique;
		AudioManager.Destroy3dAudioObj(data);
	end
end

--作用：播放UI音效
--param：音效id
--说明：3d音效为了保证及时性，可以提前进行加载
--      未进行预加载的音效会到时候再加载
function AudioManager.PlayUiAudio(id)
	--app.log("id=="..id.."    "..debug.traceback());
	--app.log("id==="..id.."   time="..PublicStruct.Cur_Logic_Frame);
	-- do return end;
	--local assetUiObject = assetObject[ENUM.EAudioType.UI];
	local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
	if not cfg then
		app.log("id == "..id.." 的audio配置表没有");
		return
	end
	local path = ConfigHelper.UpdateAudioPath(cfg)
	local asset = ResourceManager.GetRes(path);
	if(asset ~= nil)then
		local audioUiObject = audioObject[ENUM.EAudioType.UI];
		if(audioUiObject[id] == nil)then
			audioUiObject[id] = asset_game_object.create(asset);
			audioUiObject[id]:set_parent(AudioManager.GetUiAudioSourceNode());
		end
		local audiosource = audioUiObject[id]:get_component_audio_source();
		audiosource:set_mute(muteAudio[ENUM.EAudioType.UI]);
		local volOrgScale = 1;
		if not cfg.volScale then
			app.log("id == "..id.." 的audio volscale 没有");
		else
			volOrgScale = cfg.volScale;
		end
		audiosource:set_volume(volume[ENUM.EAudioType.UI] * volOrgScale);
		--audiosource:set_volume(volume[ENUM.EAudioType.UI]);
		audiosource:set_pan_level(0);
		--app.log_warning("id=="..id..debug.traceback());
		audiosource:play();
		return id;
	else
		AudioManager.LoadAndPlayUiAudio(id);
		return id;
	end
end

function AudioManager.GetAudioUiObject(id)
	local audioUiObject = audioObject[ENUM.EAudioType.UI];
	if not audioUiObject then
		return nil;
	end

	return audioUiObject[id];
end

function AudioManager.StopUiAudio(id)
	ResourceLoader.ClearGroupCallBack("audio_"..id)
	local audioObject = AudioManager.GetAudioUiObject(id);
	--app.log_warning("id==="..id.."  audioObject=="..tostring(audioObject));
	if audioObject then
		local audiosource = audioObject:get_component_audio_source();
		if audiosource then
			audiosource:stop();
		end
	end
end


--作用：播放2d音乐，即背景音乐
--param：播放列表list，播放模式playMode,使用的audioPlayer的id，默认为1
--例如：AudioManager.Play2dAudioList({[1]={id=1,loop=1},[2]={id=2,loop=-1}},ENUM.EAudioPlayMode.Order, ENUM.EAudioPlayer.p1)
--说明：loop表示该曲播放的次数，-1表示循环播放
function AudioManager.Play2dAudioList(list, playMode, audioPlayerId)
	audioPlayerId = audioPlayerId or ENUM.EAudioPlayer.p1;
	playMode = playMode or ENUM.EAudioPlayMode.Loop;
	AudioManager.playList[audioPlayerId] = list;
	AudioManager.playMode[audioPlayerId] = playMode;
	
	if(playMode == ENUM.EAudioPlayMode.Random)then
		local num = math.random(1,#list);
		AudioManager.Play2dAudio(list[num].id, list[num].loop, audioPlayerId)
		AudioManager.cur2dAudioNumber[audioPlayerId] = num;
	else
		AudioManager.Play2dAudio(list[1].id, list[1].loop, audioPlayerId)
		AudioManager.cur2dAudioNumber[audioPlayerId] = 1;
	end
end

function AudioManager.Set2dAudioFilter(id, audioPlayerId, high_pass_data, low_pass_data)
	local audio2dObject = audioObject[ENUM.EAudioType._2d]
	if audio2dObject and audio2dObject[id] then
		audioPlayerId = audioPlayerId or ENUM.EAudioPlayer.p1
		AudioManager._SetAudioFilterData(audio2dObject[id][audioPlayerId], "high_pass", high_pass_data)
		AudioManager._SetAudioFilterData(audio2dObject[id][audioPlayerId], "low_pass", low_pass_data)
	else
		--{enable=false,cutoff=0,resq=0}
		temp2dFilterSetting[id] = {high_pass=high_pass_data, low_pass=low_pass_data}
	end
end

function AudioManager._SetAudioFilterData(audio_obj, filter_type, filter_data)
	if audio_obj and filter_type and filter_data then
		if filter_type == "high_pass" then
			local audioPassFilter = audio_obj:get_component_audio_high_pass_filter()
			if audioPassFilter == nil then
				audioPassFilter = audio_obj:add_component_audio_high_pass_filter()
			end
			audio_obj:set_audio_high_pass_filter_enable(Utility.get_value(filter_data.enable, false))
			if audioPassFilter then
				audioPassFilter:set_cutoff_frequency(filter_data.cutoff or 5000.0)
				audioPassFilter:set_highpass_resonance_q(filter_data.resq or 1.0)
			end

		elseif filter_type == "low_pass" then
			local audioPassFilter = audio_obj:get_component_audio_low_pass_filter()
			if audioPassFilter == nil then
				audioPassFilter = audio_obj:add_component_audio_low_pass_filter()
			end
			audio_obj:set_audio_low_pass_filter_enable(Utility.get_value(filter_data.enable, false))
			if audioPassFilter then
				audioPassFilter:set_cutoff_frequency(filter_data.cutoff or 5000.0)
				audioPassFilter:set_lowpass_resonance_q(filter_data.resq or 1.0)
			end
		end
	end
end

--作用：音效静音
--param：enbale==true：静音
--       enbale==false：不静音
--       audioType:音效的类型，详情见EAudioType
--       audioPlayerId： 2d音效专用，用于区分背景音乐和环境音效
function AudioManager.MuteAudio(enable, audioType, audioPlayerId)
	if(not audioType)then
		for k1,v1 in pairs(audioObject) do
			if(k1 == ENUM.EAudioType.UI)then
				muteAudio[ENUM.EAudioType.UI] = enable;
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					if(audiosource)then
						audiosource:set_mute(enable);
					end
				end
			else
				if(k1 == ENUM.EAudioType._2d)then
					for k2,v2 in pairs(ENUM.EAudioPlayer) do
						muteAudio[ENUM.EAudioType._2d][v2] = enable;
					end
				elseif(k1 == ENUM.EAudioType._3d)then
					muteAudio[ENUM.EAudioType._3d] = enable;
				end
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						local audiosource = v3:get_component_audio_source();
						if(audiosource)then
							audiosource:set_mute(enable);
						end
					end
				end
			end
		end
	else
		if(audioType == ENUM.EAudioType.UI)then
			muteAudio[ENUM.EAudioType.UI] = enable;
			for k1,v1 in pairs(audioObject[audioType]) do
				local audiosource = v1:get_component_audio_source();
				if(audiosource)then
					audiosource:set_mute(enable);
				end
			end
		else
			if(audioType == ENUM.EAudioType._2d)then
				if not audioPlayerId then
					for k1,v1 in pairs(ENUM.EAudioPlayer) do
						muteAudio[ENUM.EAudioType._2d][v1] = enable;
					end
					for k1,v1 in pairs(audioObject[audioType]) do
						for k2,v2 in pairs(v1)do
							local audiosource = v2:get_component_audio_source();
							if(audiosource)then
								audiosource:set_mute(enable);
							end
						end
					end
				else
					muteAudio[ENUM.EAudioType._2d][audioPlayerId] = enable;
					for k1,v1 in pairs(audioObject[audioType]) do
						for k2,v2 in pairs(v1)do
							if k2 == audioPlayerId then
								local audiosource = v2:get_component_audio_source();
								if(audiosource)then
									audiosource:set_mute(enable);
								end
							end
						end
					end
				end
			elseif(audioType == ENUM.EAudioType._3d)then
				muteAudio[ENUM.EAudioType._3d] = enable;
				for k1,v1 in pairs(audioObject[audioType]) do
					for k2,v2 in pairs(v1)do
						local audiosource = v2:get_component_audio_source();
						if(audiosource)then
							audiosource:set_mute(enable);
						end
					end
				end
			end
			
		end
	end
end

--作用：设置音效音量大小
--param：volume在[0,1]之间
--       audioType:音效的类型，详情见EAudioType
function AudioManager.SetAudioVolume(vol, audioType)
	if(not audioType)then
		for k1,v1 in pairs(audioObject) do
			if(k1 == ENUM.EAudioType.UI)then
				volume[ENUM.EAudioType.UI] = vol;
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					if(audiosource)then
						audiosource:set_volume(vol);
					end
				end
			else
				if(k1 == ENUM.EAudioType._2d)then
					volume[ENUM.EAudioType._2d] = vol;
				elseif(k1 == ENUM.EAudioType._3d)then
					volume[ENUM.EAudioType._3d] = vol;
				end
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						local audiosource = v3:get_component_audio_source();
						if(audiosource)then
							audiosource:set_volume(vol);
						end
					end
				end
			end
		end
	else
		if(audioType == ENUM.EAudioType.UI)then
			volume[ENUM.EAudioType.UI] = vol;
			for k1,v1 in pairs(audioObject[audioType]) do
				local audiosource = v1:get_component_audio_source();
				if(audiosource)then
					audiosource:set_volume(vol);
				end
			end
		else
			if(audioType == ENUM.EAudioType._2d)then
				volume[ENUM.EAudioType._2d] = vol;
			elseif(audioType == ENUM.EAudioType._3d)then
				volume[ENUM.EAudioType._3d] = vol;
			end
			for k1,v1 in pairs(audioObject[audioType]) do
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					if(audiosource)then
						audiosource:set_volume(vol);
					end
				end
			end
		end
	end
end

--作用：停止音乐
--param：audioType为音乐的类型：详情见EAudioType，audioType为nil时，全部选择
function AudioManager.Stop(audioType, isDelay)
	--app.log("stop    111111111111111111     "..debug.traceback());
	if audioType == nil or audioType == ENUM.EAudioType._2d then
		AudioManager.cur2dBgmId = nil
	end

	if(not audioType)then
		for k1,v1 in pairs(audioObject) do
			if(k1 == ENUM.EAudioType.UI)then
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					local id = k2;
					local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
					if cfg and cfg.isDestroy then
						if cfg.isDestroy == 1 then
							if(audiosource)then
								audiosource:stop();
							end
							audioObject[k1][k2] = nil;
						end
					else
						if(audiosource)then
							audiosource:stop();
						end
						audioObject[k1][k2] = nil;
					end
					
				end
			elseif(k1 == ENUM.EAudioType._3d)then
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						if isDelay then
							AudioManager.OneStop(k2, false, 3000, ENUM.EAudioType._3d, k2, k3);
						else
							AudioManager.OneStop(k2, true, 3000, ENUM.EAudioType._3d, k2, k3);
						end
					end
				end
			elseif(k1 == ENUM.EAudioType._2d)then
				isEndBackAudioUpdate = true;
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						if(AudioManager.stop2dAudioTimerId)then
							if AudioManager.stop2dAudioTimerId[k3] and AudioManager.stop2dAudioTimerId[k3].funcName and AudioManager.stop2dAudioTimerId[k3].timerId then
								_G[AudioManager.stop2dAudioTimerId[k3].funcName] = nil;
								timer.stop(AudioManager.stop2dAudioTimerId[k3].timerId);
								AudioManager.stop2dAudioTimerId[k3] = nil;
							end
						end
						if isDelay then
							AudioManager.OneStop(k2, false, 3000, ENUM.EAudioType._2d, k2, k3);
						else
							AudioManager.OneStop(k2, true, 3000, ENUM.EAudioType._2d, k2, k3);
						end
					end
				end
			end
		end

		for k,v in pairs(AudioManager.load_list) do
			AudioManager.load_list[k] = 2;
		end
	else
		if(audioType == ENUM.EAudioType.UI)then
			for k1,v1 in pairs(audioObject[audioType]) do
				local audiosource = v1:get_component_audio_source();
				if(audiosource)then
					audiosource:stop();
				end
				audioObject[audioType][k1] = nil;
			end
		elseif(audioType == ENUM.EAudioType._3d)then
			for k1,v1 in pairs(audioObject[audioType]) do
				for k2,v2 in pairs(v1)do
					if isDelay then
						AudioManager.OneStop(k1, false, 3000, ENUM.EAudioType._3d, k1, k2);
					else
						AudioManager.OneStop(k1, true, 3000, ENUM.EAudioType._3d, k1, k2);
					end
				end
			end
		elseif(audioType == ENUM.EAudioType._2d)then
			isEndBackAudioUpdate = true;
			for k1,v1 in pairs(audioObject[audioType])do
				for k2,v2 in pairs(v1)do
					if(AudioManager.stop2dAudioTimerId)then
						if AudioManager.stop2dAudioTimerId[k2] and AudioManager.stop2dAudioTimerId[k2].funcName and AudioManager.stop2dAudioTimerId[k2].timerId then
							_G[AudioManager.stop2dAudioTimerId[k2].funcName] = nil;
							timer.stop(AudioManager.stop2dAudioTimerId[k2].timerId);
							AudioManager.stop2dAudioTimerId[k2] = nil;
						end
					end
					if isDelay then
						AudioManager.OneStop(k1, false, 3000, ENUM.EAudioType._2d, k1, k2);
					else
						AudioManager.OneStop(k1, true, 3000, ENUM.EAudioType._2d, k1, k2);
					end
				end
			end
		end
	end
end

--暂停音乐
function AudioManager.Pause(audioType, is_pause)
	if not audioType then
		pauseAudio[ENUM.EAudioType._2d] = is_pause;
		pauseAudio[ENUM.EAudioType._3d] = is_pause;
		pauseAudio[ENUM.EAudioType.UI] = is_pause;
	else
		pauseAudio[audioType] = is_pause;
	end
	if(not audioType)then
		for k1,v1 in pairs(audioObject) do
			if(k1 == ENUM.EAudioType.UI)then
				-- pauseAudio[ENUM.EAudioType.UI] = true;
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					if(audiosource)then
						if is_pause == true then
							audiosource:pause();
						else
							audiosource:unpause();
						end
					end
				end
			elseif(k1 == ENUM.EAudioType._3d)then
				-- pauseAudio[ENUM.EAudioType._3d] = true;
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						local audiosource = v3:get_component_audio_source();
						if(audiosource)then
							if is_pause == true then
								audiosource:pause();
							else
								audiosource:unpause();
							end
						end
					end
				end
			elseif(k1 == ENUM.EAudioType._2d)then
				-- pauseAudio[ENUM.EAudioType._2d] = true;
				for k2,v2 in pairs(v1)do
					for k3,v3 in pairs(v2)do
						if(AudioManager.stop2dAudioTimerId)then
							if AudioManager.stop2dAudioTimerId[k3] and AudioManager.stop2dAudioTimerId[k3].timerId then
								if is_pause then
									timer.pause(AudioManager.stop2dAudioTimerId[k3].timerId);
								else
									timer.resume(AudioManager.stop2dAudioTimerId[k3].timerId);
								end
							end
						end
						local audiosource = v3:get_component_audio_source();
						if(audiosource)then
							if is_pause == true then
								audiosource:pause();
							else
								audiosource:play();
							end
						end
					end
				end
			end
		end
	else
		if(audioType == ENUM.EAudioType.UI)then
			-- pauseAudio[ENUM.EAudioType.UI] = true;
			for k1,v1 in pairs(audioObject[audioType]) do
				local audiosource = v1:get_component_audio_source();
				if(audiosource)then
					if is_pause == true then
						audiosource:pause();
					else
						audiosource:unpause();
					end
				end
			end
		elseif(audioType == ENUM.EAudioType._3d)then
			-- pauseAudio[ENUM.EAudioType._3d] = true;
			for k1,v1 in pairs(audioObject[audioType]) do
				for k2,v2 in pairs(v1)do
					local audiosource = v2:get_component_audio_source();
					if(audiosource)then
						if is_pause == true then
							audiosource:pause();
						else
							audiosource:unpause();
						end
					end
				end
			end
		elseif(audioType == ENUM.EAudioType._2d)then
			-- pauseAudio[ENUM.EAudioType._2d] = true;
			for k2,v2 in pairs(audioObject[audioType])do
				for k3,v3 in pairs(v2)do
					if(AudioManager.stop2dAudioTimerId)then
						if AudioManager.stop2dAudioTimerId[k3] and AudioManager.stop2dAudioTimerId[k3].timerId then
							if is_pause then
								timer.pause(AudioManager.stop2dAudioTimerId[k3].timerId);
							else
								timer.resume(AudioManager.stop2dAudioTimerId[k3].timerId);
							end
						end
					end
					local audiosource = v3:get_component_audio_source();
					if(audiosource)then
						if is_pause == true then
							audiosource:pause();
						else
							audiosource:play();
						end
					end
				end
			end
		end
	end
end

--作用：释放音乐object对象
--param：audioType为音乐的类型：详情见EAudioType，audioType为nil时，全部选择
function AudioManager.Destroy(audioType, isDelay)
	AudioManager.Stop(audioType, isDelay)
	-- if(not audioType)then
	-- 	for k,v in pairs(ENUM.EAudioType) do
	-- 		--assetObject[v] = {};
	-- 		audioObject[v] = {};
	-- 	end
	-- else
	-- 	--assetObject[audioType] = {};
	-- 	audioObject[audioType] = {};
	-- end
end

function AudioManager.SetAudioListenerFollowObj(follow,obj)
	if(AudioManager.GetAudioListenerNode())then
		if(follow)then
			AudioManager.followObj = obj;
			if(not AudioManager.isUpdatingFollow)then
				Root.AddUpdate(AudioManager.AudioListenerFollowObj);
			end
			AudioManager.isUpdatingFollow = true;
		else
			AudioManager.followObj = nil;
			if(AudioManager.isUpdatingFollow)then
				Root.DelUpdate(AudioManager.AudioListenerFollowObj);
			end
			AudioManager.isUpdatingFollow = false;
		end
	end
end

function AudioManager.AudioListenerFollowObj()
	if(AudioManager.followObj ~= nil)then
		local x,y,z = AudioManager.followObj:get_position();
		if(type(x)=="number" and type(y)=="number" and type(z)=="number")then
			AudioManager.GetAudioListenerNode():set_position(x,y,z);
		end
		if(CameraManager.GetSceneCameraObj() ~= nil)then
			AudioManager.GetAudioListenerNode():set_rotation(CameraManager.GetSceneCameraObj():get_rotation());
		end
	else
		app.log("audioListener跟随对象未设置");
	end
end

---------------------------------------------------------------------
---------------------------内部调用函数------------------------------
-----加载3d音效，完成后播放---
function AudioManager.LoadAndPlay3dAudio(id, obj, convertTo2d, follow, isUnique,autoStop, cbfunction, cbdata, volScale)
	local data = {};
	data.id = id;
	data.obj = obj;
	data.convertTo2d = convertTo2d;
	data.follow = follow;
	data.isUnique = isUnique;
	data.autoStop = autoStop;
	data.cbfunction = cbfunction;
	data.cbdata = cbdata;
	data.volScale = volScale;

	local audio_path = ConfigHelper.GetAudioPath(id);
	if not audio_path then
		app.log_warning("得不到音效配置表id==="..tostring(id));
		return
	end

	if _unity_audio_bug_fixed then
	    ResourceLoader.LoadAsset(audio_path, Utility.create_callback_ex(AudioManager.on_load_and_play_3d_audio, true, 4, data), "3daudio_"..id)
	else
	    ResourceLoader.LoadRawAsset(audio_path, Utility.create_callback_ex(AudioManager.on_load_and_play_3d_audio, true, 4, data), "3daudio_"..id)
	end
end

function AudioManager.on_load_and_play_3d_audio(pid, filepath, asset_obj, error_info, data)
	--local asset3dObject = assetObject[ENUM.EAudioType._3d];
	--asset3dObject[data.id] = asset_obj;
	AudioManager.Play3dAudio(data.id, data.obj, data.convertTo2d, data.follow, data.isUnique, data.autoStop, data.cbfunction, data.cbdata, data.volScale);
end
-------------------------------

-----加载UI音效，完成后播放---
function AudioManager.LoadAndPlayUiAudio(id)
	local data = {};
	data.id = id;


	local audio_path = ConfigHelper.GetAudioPath(id);
	if not audio_path then
		app.log_warning("得不到音效配置表id==="..tostring(id));
		return
	end

	if _unity_audio_bug_fixed then
	    ResourceLoader.LoadAsset(audio_path, Utility.create_callback_ex(AudioManager.on_load_and_play_ui_audio, true, 4, data), "audio_"..id)
	else
	    ResourceLoader.LoadRawAsset(audio_path, Utility.create_callback_ex(AudioManager.on_load_and_play_ui_audio, true, 4, data), "audio_"..id)
	end
end

function AudioManager.on_load_and_play_ui_audio(pid, filepath, asset_obj, error_info, data)
	--local assetUiObject = assetObject[ENUM.EAudioType.UI];
	--assetUiObject[data.id] = asset_obj;
	local cfg = ConfigManager.Get(EConfigIndex.t_audio,data.id);
	if cfg.isDestroy == 0 then
		ResourceManager.AddPermanentReservedRes(ConfigHelper.UpdateAudioPath(cfg))
	end
	AudioManager.PlayUiAudio(data.id);
end
-------------------------------
function AudioManager.Play2dAudio(id,loop,audioPlayerId)
	-- do return end;
	--local asset2dObject = assetObject[ENUM.EAudioType._2d];
	local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
	if not cfg then
		app.log("id == "..id.." 的audio配置表没有");
		return
	end
	local path = ConfigHelper.UpdateAudioPath(cfg);
	local asset = ResourceManager.GetRes(path);
	if(asset ~= nil)then
		local audio2dObject = audioObject[ENUM.EAudioType._2d];
		if(audio2dObject[id] == nil)then
			audio2dObject[id] = {};
		end
		if(audio2dObject[id][audioPlayerId] == nil)then
			audio2dObject[id][audioPlayerId] = asset_game_object.create(asset);
			audio2dObject[id][audioPlayerId]:set_parent(AudioManager.Get2dAudioSourceNode(audioPlayerId));
		end

		if temp2dFilterSetting[id] then
			AudioManager.Set2dAudioFilter(id, audioPlayerId, temp2dFilterSetting[id].high_pass, temp2dFilterSetting[id].low_pass)
			temp2dFilterSetting[id] = nil
		end
		if audioPlayerId == ENUM.EAudioPlayer.p1 then
			AudioManager.cur2dBgmId = id
		end

		local audiosource = audio2dObject[id][audioPlayerId]:get_component_audio_source();
		audiosource:set_mute(muteAudio[ENUM.EAudioType._2d][audioPlayerId]);
		local volOrgScale = 1;
		if not cfg.volScale then
			app.log("id == "..id.." 的audio volScale 没有");
		else
			volOrgScale = cfg.volScale;
		end
		audiosource:set_volume(volume[ENUM.EAudioType._2d] * volOrgScale);
		--audiosource:set_volume(volume[ENUM.EAudioType._2d]);
		audiosource:set_pan_level(0);
		--app.log("33333333播放环境音效id=="..tostring(id).."   audioPlayerId=="..tostring(audioPlayerId).."  loop=="..tostring(loop));
		if pauseAudio[ENUM.EAudioType._2d] then
			audiosource:pause();
		else
			audiosource:play();
		end
		if(loop > 0)then
			local length = audiosource:get_audio_clip_length()*1000*loop;
			--app.log("length=="..length.."   audioPlayerId=="..tostring(audioPlayerId));
			local data = {};
			data.id = id;
			data.audioPlayerId = audioPlayerId;
			if(AudioManager.stop2dAudioTimerId == nil)then
				AudioManager.stop2dAudioTimerId = {};
			else
				if AudioManager.stop2dAudioTimerId[audioPlayerId] ~= nil and AudioManager.stop2dAudioTimerId[audioPlayerId].funcName and AudioManager.stop2dAudioTimerId[audioPlayerId].timerId then
					_G[AudioManager.stop2dAudioTimerId[audioPlayerId].funcName] = nil;
					timer.stop(AudioManager.stop2dAudioTimerId[audioPlayerId].timerId);
				end
			end
			local funcName = BindAudioCallBack(AudioManager.Stop2dAudio,data);
			local timerId = timer.create(funcName,length,1);
			AudioManager.stop2dAudioTimerId[audioPlayerId] = {}
			AudioManager.stop2dAudioTimerId[audioPlayerId].funcName = funcName;
			AudioManager.stop2dAudioTimerId[audioPlayerId].timerId = timerId;
		end
	else
		--app.log("22222222播放环境音效id=="..tostring(id).."   audioPlayerId=="..tostring(audioPlayerId));
		AudioManager.LoadAndPlay2dAudio(id,loop,audioPlayerId);
	end
end

function AudioManager.Stop2dAudio(data)
	if not data or not data.audioPlayerId or not data.id then
		return
	end
	--app.log("#lj#1")
	if AudioManager.stop2dAudioTimerId[data.audioPlayerId] and AudioManager.stop2dAudioTimerId[data.audioPlayerId].funcName and AudioManager.stop2dAudioTimerId[data.audioPlayerId].timerId then
		--app.log("#lj#2")
		_G[AudioManager.stop2dAudioTimerId[data.audioPlayerId].funcName] = nil;
		timer.stop(AudioManager.stop2dAudioTimerId[data.audioPlayerId].timerId);
		AudioManager.stop2dAudioTimerId[data.audioPlayerId] = nil;
	else
		app.log("不可能出现的东西"..table.tostring(data))
	end
	local audio2dObject = audioObject[ENUM.EAudioType._2d];
	if(audio2dObject[data.id])then
		--app.log("#lj#3")
		if(audio2dObject[data.id][data.audioPlayerId])then
			--app.log("#lj#4")
			local audiosource = audio2dObject[data.id][data.audioPlayerId]:get_component_audio_source();
			if(audiosource)then
				--app.log("#lj#5")
				audiosource:stop();
			else
				app.log("audiosource为nil");
			end
		else
			app.log("audio2dObject["..data.id.."]["..data.audioPlayerId.."]为nil");
		end
	else
		app.log("audio2dObject["..data.id.."]为nil");
	end
	
	--顺序播放
	if(AudioManager.playMode[data.audioPlayerId] == ENUM.EAudioPlayMode.Order)then
		--app.log("#lj#6")
		if(AudioManager.cur2dAudioNumber[data.audioPlayerId] == #AudioManager.playList[data.audioPlayerId])then
			--app.log("#lj#7")
			AudioManager.cur2dAudioNumber[data.audioPlayerId] = nil;
			AudioManager.playList[data.audioPlayerId] = {};
			AudioManager.playMode[data.audioPlayerId] = {};
		else
			--app.log("#lj#8")
			local list = AudioManager.playList[data.audioPlayerId];
			local num = AudioManager.cur2dAudioNumber[data.audioPlayerId] + 1;
			AudioManager.Play2dAudio(list[num].id, list[num].loop, data.audioPlayerId)
			AudioManager.cur2dAudioNumber[audioPlayerId] = num;
		end
	--列表循环
	elseif(AudioManager.playMode[data.audioPlayerId] == ENUM.EAudioPlayMode.Loop)then
		--app.log("#lj#9")
		if(AudioManager.cur2dAudioNumber[data.audioPlayerId] == #AudioManager.playList[data.audioPlayerId])then
			--app.log("#lj#10")
			local list = AudioManager.playList[data.audioPlayerId];
			local num = 1;
			AudioManager.Play2dAudio(list[num].id, list[num].loop, data.audioPlayerId)
			AudioManager.cur2dAudioNumber[data.audioPlayerId] = num;
		else
			--app.log("#lj#11")
			local list = AudioManager.playList[data.audioPlayerId];
			local num = AudioManager.cur2dAudioNumber[data.audioPlayerId] + 1;
			AudioManager.Play2dAudio(list[num].id, list[num].loop, data.audioPlayerId)
			AudioManager.cur2dAudioNumber[data.audioPlayerId] = num;
		end
	--随机播放
	elseif(AudioManager.playMode[data.audioPlayerId] == ENUM.EAudioPlayMode.Random)then
		--app.log("#lj#12")
		local list = AudioManager.playList[data.audioPlayerId];
		local num = math.random(1,#list);
		AudioManager.Play2dAudio(list[num].id, list[num].loop, data.audioPlayerId)
		AudioManager.cur2dAudioNumber[data.audioPlayerId] = num;
	end
end

-----加载2d音效，完成后播放---
function AudioManager.LoadAndPlay2dAudio(id,loop,audioPlayerId)
	local data = {};
	data.id = id;
	data.loop = loop;
	data.audioPlayerId = audioPlayerId;

	local audio_path = ConfigHelper.GetAudioPath(id)
	if not audio_path then
		app.log("得不到音效配置表id==="..tostring(id));
		return
	end

	if _unity_audio_bug_fixed then
	    ResourceLoader.LoadAsset(audio_path, {func=AudioManager.on_load_and_play_2d_audio, user_data=data}, nil)
	else
	    ResourceLoader.LoadRawAsset(audio_path, {func=AudioManager.on_load_and_play_2d_audio, user_data=data}, nil)
	end
	AudioManager.load_list[audio_path]  = 1;
end

function AudioManager.on_load_and_play_2d_audio(data, pid, filepath, asset_obj, error_info)
	local audio_path =  ConfigHelper.GetAudioPath(data.id)
	if AudioManager.load_list[audio_path] == 2 then
		return;
	end
	AudioManager.load_list[audio_path] = nil;
	--local asset2dObject = assetObject[ENUM.EAudioType._2d];
	--asset2dObject[data.id] = asset_obj;
	AudioManager.Play2dAudio(data.id,data.loop,data.audioPlayerId);
end

-------------------------------

----------------------------

function AudioManager.Get2dBgmId()
	return AudioManager.cur2dBgmId;
end

function AudioManager.GetUiAudioSourceNode()
	if(not AudioManager.uiAudioSourceNode)then
		AudioManager.uiAudioSourceNode = asset_game_object.find("audio_source_node/ui_audio_source_node");
	end
	return AudioManager.uiAudioSourceNode;
end

function AudioManager.Get2dAudioSourceNode(audioPlayerId)
	if(not AudioManager._2dAudioSourceNode[audioPlayerId])then
		AudioManager._2dAudioSourceNode[audioPlayerId] = asset_game_object.find("audio_source_node/_2d_audio_source_node_"..audioPlayerId);
	end
	return AudioManager._2dAudioSourceNode[audioPlayerId];
end

function AudioManager.GetAudioListenerNode()
	if(not AudioManager.audioListenerNode)then
		AudioManager.audioListenerNode = asset_game_object.find("audio_listener_node");
	end
	return AudioManager.audioListenerNode;
end


--在3d音效播放完成后，销毁audio object对象
function AudioManager.Destroy3dAudioObj(data)
	--app.log("data.assetObj_id"..data.assetObj_id);
	--app.log("#lj#11")
    if data.cbfunction then
    	--app.log("#lj#12")
        data.cbfunction(data.cbdata)
    end

	if(audioObject[ENUM.EAudioType._3d][data.assetObj_id])then
		--app.log("#lj#13")
		if(audioObject[ENUM.EAudioType._3d][data.assetObj_id][data.audioObj_id])then
			--app.log("#lj#14")
			local audiosource = audioObject[ENUM.EAudioType._3d][data.assetObj_id][data.audioObj_id]:get_component_audio_source();
			if(audiosource)then
				--app.log("#lj#15")
				audiosource:stop();
				audioObject[ENUM.EAudioType._3d][data.assetObj_id][data.audioObj_id] = nil;
				local timerInfo = AudioManager.stop3dAudioTimerId[data.assetObj_id]
				if timerInfo and timerInfo[data.audioObj_id] and timerInfo[data.audioObj_id].funcName then
					_G[timerInfo[data.audioObj_id].funcName] = nil;
					AudioManager.stop3dAudioTimerId[data.assetObj_id][data.audioObj_id] = nil;
					if table.get_num(AudioManager.stop3dAudioTimerId[data.assetObj_id]) <= 0 then
						AudioManager.stop3dAudioTimerId[data.assetObj_id] = nil;
					end
				end
				if data.isUnique then
					--app.log("#lj#16")
					if data.assetObj_id == AudioManager.cur3dAudioId and data.audioObj_id == AudioManager.cur3dAudioNumAdObj then
						--app.log("#lj#17")
						--app.log("自动停止id=="..AudioManager.cur3dAudioId);
						AudioManager.cur3dAudioId = nil;
						AudioManager.cur3dAudioNumAdObj = nil;
					end
				end
			end
		end
	end
end

--根据scene_entity获取音量缩放比例
function AudioManager.GetVolScaleBySceneEntity(entity)
	local volScale = 1;
	repeat
		if not entity then
			break;
		end
		if entity:GetName() == g_dataCenter.fight_info:GetCaptainName() then
			--app.log("111111==="..volScale);
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.MyCaptain).volScale;
		elseif entity:GetName() ~= g_dataCenter.fight_info:GetCaptainName() and entity:IsMyControl() then
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.MyHero).volScale;
			--app.log("222222==="..volScale);
		elseif entity:IsHero() and entity:IsEnemy() then
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.EnemyHero).volScale;
			--app.log("333333==="..volScale);
		elseif entity:IsSuper() or entity:IsSoldierClose() or entity:IsSoldierRnage() or entity:IsPatrol() then
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.Soldier).volScale;
			--app.log("444444==="..volScale);
		elseif entity:IsBoss() then
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.BOSS).volScale;
			--app.log("555555==="..volScale);
		elseif entity:IsTower() or entity:IsBasis() or entity:IsBloodPool() then
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.Tower).volScale;
			--app.log("666666==="..volScale);
		elseif entity:IsMonsterHero() then
			--app.log("777777==="..volScale);
			volScale = ConfigManager.Get(EConfigIndex.t_vol_scale,ENUM.VolScaleType.MonsterHero).volScale;
		else
			--app.log("888888");
		end
	until true
	return volScale;
end

--update
function AudioManager.Update()
	for k,v in pairs(fadeOutAudioObject) do
		local beginStopTime = v.beginStopTime;
		local fadeOutTime = v.fadeOutTime;
		local id = v.id;
		local p1 = v.p1;
		local p2 = v.p2;
		local p3 = v.p3;
		local object;
		if audioObject[p1] and audioObject[p1][p2] and audioObject[p1][p2][p3] then
			object =  audioObject[p1][p2][p3];
			local audiosource = object:get_component_audio_source();
			if not audiosource then
				--app.log("AudioManager.Update error   id=="..id.."  p1=="..p1.."  p2=="..p2.."  p3=="..p3);
				fadeOutAudioObject[k] = nil;
				audioObject[p1][p2][p3] = nil;
			else
				local deltaTime = PublicFunc.QueryDeltaTime(beginStopTime);
				if deltaTime >= fadeOutTime then
					--app.log("id==="..id.."   stop");
					audiosource:stop();
					fadeOutAudioObject[k] = nil;
					if audioObject[p1] and audioObject[p1][p2] and audioObject[p1][p2][p3] then
						audioObject[p1][p2][p3] = nil;
					end
					volume[ENUM.EAudioType._2d] = 1;
					--app.log("xxxxxxxxxxxxxxxxxxx")
				else
					local volOrgScale = 1;

					--TODO: @zouyou 能否暂存volScale , 不要在update中获取
					local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
					if not cfg or not cfg.volScale then
						app.log("id == "..id.." 的audio volScale 配置没有");
					else
						volOrgScale = cfg.volScale;
					end
					local final_scale = volume[ENUM.EAudioType._2d] * volOrgScale * (1 - deltaTime / fadeOutTime);
					--app.log("id==="..id.."   final_scale==="..final_scale.."   deltaTime=="..tostring(deltaTime).."  vol=="..tostring(volume[ENUM.EAudioType._2d]))
					audiosource:set_volume(final_scale);
				end
			end
		else
			--有可能这个音效在2秒钟之前就播完了,自己删除了,所以没有了
			--app.log("no audioObject  data=="..table.tostring({p1,p2,p3}))
			fadeOutAudioObject[k] = nil;
		end
	end
	AudioManager.UpdateBackAudio()
	AudioManager.UpdateUiAudio()
end

function AudioManager.UpdateUiAudio()
	for k,v in pairs(fadeOutUiAudioObject) do
		local beginStopTime = v.beginStopTime;
		local fadeOutTime = v.fadeOutTime;
		local id = v.id;
		local p1 = v.p1;
		local p2 = v.p2;
		local p3 = v.p3;
		local object;
		if audioObject[p1] and audioObject[p1][p2] then
			object =  audioObject[p1][p2];
			local audiosource = object:get_component_audio_source();
			if not audiosource then
				--app.log("AudioManager.Update error   id=="..id.."  p1=="..p1.."  p2=="..p2.."  p3=="..p3);
				fadeOutUiAudioObject[k] = nil;
				audioObject[p1][p2] = nil;
			else
				local deltaTime = PublicFunc.QueryDeltaTime(beginStopTime);
				if deltaTime >= fadeOutTime then
					--app.log("id==="..id.."   stop");
					audiosource:stop();
					fadeOutUiAudioObject[k] = nil;
					if audioObject[p1] and audioObject[p1][p2] then
						audioObject[p1][p2] = nil;
					end
				else
					local volOrgScale = 1;

					--TODO: @zouyou 能否暂存volScale , 不要在update中获取
					local cfg = ConfigManager.Get(EConfigIndex.t_audio,id)
					if not cfg or not cfg.volScale then
						app.log("id == "..id.." 的audio volScale 配置没有");
					else
						volOrgScale = cfg.volScale;
					end
					local final_scale = volume[ENUM.EAudioType.UI] * volOrgScale * (1 - deltaTime / fadeOutTime);
					--app.log("id==="..id.."   final_scale==="..final_scale)
					audiosource:set_volume(final_scale);
				end
			end
		else
			--有可能这个音效在2秒钟之前就播完了,自己删除了,所以没有了
			--app.log("no audioObject  data=="..table.tostring({p1,p2,p3}))
			fadeOutUiAudioObject[k] = nil;
		end
	end
end

function AudioManager.UpdateBackAudio()
	if isEndBackAudioUpdate then
		return
	end
	if curBackAudioVolScale == backAudioEndVol then
		isEndBackAudioUpdate = true;
		return
	end
	local deltaTime = PublicFunc.QueryDeltaRealTime(backAudioBeginTime);
	local volOrgScale = 1;
	local xx = volOrgScale*(backAudioBeginVol-(backAudioBeginVol-backAudioEndVol)*(deltaTime / backAudioChangeTime))
	local final_scale = volOrgScale * (backAudioBeginVol - (backAudioBeginVol-backAudioEndVol)*(deltaTime / backAudioChangeTime));
	--app.log("   final_scale==="..final_scale.."    deltaTime=="..deltaTime.."      xx=="..xx)
	if backAudioEndVol <= backAudioBeginVol then
		if final_scale <= backAudioEndVol * volOrgScale then
			--app.log("111111111111final_scale=="..final_scale);
			final_scale = backAudioEndVol;
			backAudioBeginVol = final_scale;
		end
	else
		if final_scale >= backAudioEndVol * volOrgScale then
			--app.log("222222222222final_scale=="..final_scale);
			final_scale = backAudioEndVol;
			backAudioBeginVol = final_scale;
		end
	end
	AudioManager.SetAudioVolume(final_scale, ENUM.EAudioType._2d)
	curBackAudioVolScale = final_scale;
end

--停止某个2d,3d音乐
--param:audio_object 要停止的对象
--      stopImmediately 是否立即停止,false就淡出
--      fadeOutTime 淡出时间,毫秒为单位
function AudioManager.OneStop(id, stopImmediately, fadeOutTime, p1, p2, p3)
	--app.log("onestop==="..table.tostring({id,stopImmediately, fadeOutTime, p1,p2,p3}));
	if stopImmediately == true or fadeOutTime == nil or fadeOutTime == 0 then
		if audioObject[p1] and audioObject[p1][p2] and audioObject[p1][p2][p3] then
			local audiosource = audioObject[p1][p2][p3]:get_component_audio_source();
			if(audiosource)then
				audiosource:stop();
			end
			audioObject[p1][p2][p3] = nil
		end
		return
	end
	for k,v in pairs(fadeOutAudioObject) do
		if v.id == id and v.p1 == p1 and v.p2 == p2 and v.p3 == p3 then
			return;
		end
	end
	local len = #fadeOutAudioObject;
	fadeOutAudioObject[len+1] = {};
	fadeOutAudioObject[len+1].beginStopTime = PublicFunc.QueryCurTime();
	fadeOutAudioObject[len+1].fadeOutTime = fadeOutTime;
	fadeOutAudioObject[len+1].id = id;
	fadeOutAudioObject[len+1].p1 = p1;
	fadeOutAudioObject[len+1].p2 = p2;
	fadeOutAudioObject[len+1].p3 = p3;
end

--停止某个UI音乐
--param:audio_object 要停止的对象
--      stopImmediately 是否立即停止,false就淡出
--      fadeOutTime 淡出时间,毫秒为单位
function AudioManager.OneStopUI(id, stopImmediately, fadeOutTime, p1, p2)
	--app.log("onestop==="..table.tostring({id,stopImmediately, fadeOutTime, p1,p2,p3}));
	if stopImmediately == true or fadeOutTime == nil or fadeOutTime == 0 then
		if audioObject[p1] and audioObject[p1][p2] then
			local audiosource = audioObject[p1][p2]:get_component_audio_source();
			if(audiosource)then
				audiosource:stop();
			end
			audioObject[p1][p2] = nil
		end
		return
	end
	for k,v in pairs(fadeOutUiAudioObject) do
		if v.id == id and v.p1 == p1 and v.p2 == p2 then
			return;
		end
	end
	local len = #fadeOutUiAudioObject;
	fadeOutUiAudioObject[len+1] = {};
	fadeOutUiAudioObject[len+1].beginStopTime = PublicFunc.QueryCurTime();
	fadeOutUiAudioObject[len+1].fadeOutTime = fadeOutTime;
	fadeOutUiAudioObject[len+1].id = id;
	fadeOutUiAudioObject[len+1].p1 = p1;
	fadeOutUiAudioObject[len+1].p2 = p2;
end

--渐变降低/增加背景音乐音量
--param:
--      end_vol 结束音量
--      changeTime 渐变时间,毫秒为单位
function AudioManager.ChangeBackAudioVol(end_vol, changeTime)
	if not end_vol or not changeTime then
		return
	end
	if end_vol == backAudioBeginVol then
		--return
	end
	if end_vol >=0 and end_vol <= 1 then
		isEndBackAudioUpdate = false;
		backAudioBeginVol =curBackAudioVolScale;
		backAudioEndVol = end_vol;
		backAudioBeginTime = PublicFunc.QueryCurRealTime();
		--app.log("backAudioBeginTime=="..backAudioBeginTime.."   backAudioEndVol=="..backAudioEndVol.."    backAudioBeginVol=="..backAudioBeginVol);
		backAudioChangeTime = changeTime;
	end
end

--渐变降低/增加背景音乐音量
--param:
--      end_vol 结束音量
--      changeTime 渐变时间,毫秒为单位
function AudioManager.ChangeBackAudioVolEx(data)
	if not data or not data.end_vol or not data.changeTime then
		return
	end
	local end_vol = data.end_vol;
	local changeTime = data.changeTime;
	if end_vol == backAudioBeginVol then
		--return
	end
	if end_vol >=0 and end_vol <= 1 then
		isEndBackAudioUpdate = false;
		backAudioBeginVol =curBackAudioVolScale;
		backAudioEndVol = end_vol;
		backAudioBeginTime = PublicFunc.QueryCurRealTime();
		--app.log("backAudioBeginTime=="..backAudioBeginTime.."   backAudioEndVol=="..backAudioEndVol.."    backAudioBeginVol=="..backAudioBeginVol);
		backAudioChangeTime = changeTime;
	end
end


Root.AddUpdate(AudioManager.Update);



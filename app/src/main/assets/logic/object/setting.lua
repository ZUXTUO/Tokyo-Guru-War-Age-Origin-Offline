--设置的数据中心
SettingDataCenter = Class("SettingDataCenter");
script.run("logic/manager/effect_manager.lua");
script.run("logic/manager/audio_manager.lua");
local file_path_common = "setting.data";
local file_path_player = "autoFight.data";

function SettingDataCenter:Init(data)
	self:InitData(data)
end
local default_renshuvalue = 3;
local default_quality_setting_index = 2;
function SettingDataCenter:InitData(data)
	self.musicOpen = true;   --音乐
	self.soundOpen = true;   --音效
	self.intelligenceOpen = false; -- 智能施法
	self.screenAA = true;	--抗锯齿
	self.huazhivalue = 2;	--画质
	self.manualSet = false;	--手动设置
	self.renshuvalue = default_renshuvalue;	--人数
	self.quality_setting_index = default_quality_setting_index;		--品质设置
	self.renshuvalueBySystem = {};			--系统对应玩法设置
	self.quality_setting_index_system = {};	--系统特效品质对应系统玩法
	self.autoQualityDowning = {};			--自动设置在下降
	self.recvServerSetting = false;		--是否接受过服务器的设置
	self.taskTracingTips = false; 		--任务追踪tips是否开启
    self.city_x = 0;
    self.city_y = 0;
	self.city_z = 0;

	self.is_auto_fight = {}	--是否自动战斗（每个玩家1条）

	self:LoadCommonData()
	self:LoadPlayerData()

	self:Update();
end

function SettingDataCenter:LoadCommonData()
	local file_handler = file.open(file_path_common,4);
	if not file_handler then
		return;
	end

	local aaa = file_handler:read_all_text()

--	app.log("xxxxxxx="..aaa)

	if aaa == "" then
		local t = {musicOpen=self.musicOpen,
		soundOpen=self.soundOpen,
		intelligenceOpen = self.intelligenceOpen,
		screenAA = self.screenAA,
		huazhivalue = self.huazhivalue,
		manualSet=self.manualSet,
		renshuvalue = self.renshuvalue, 
		renshuvalueBySystem = self.renshuvalueBySystem,
		quality_setting_index_system = self.quality_setting_index_system,
		city_x=self.city_x, city_y=self.city_y, city_z=self.city_z,
		quality_setting_index=self.quality_setting_index,
		autoQualityDowning = self.autoQualityDowning,
		recvServerSetting = self.recvServerSetting,
		taskTracingTips = self.taskTracingTips,
		};

		file_handler:write_string(table.tostringEx(t));
		file_handler:close();
	else
		local k = loadstring(aaa);
		if k == nil then
			--app.log("SettingDataCenter:InitData   k为nil");
		else
			--app.log("xxxxxxx"..table.tostring(k()))
			for k,v in pairs(k()) do
				self[k] = v;
			end
		end
		file_handler:close();
		--修正代码
		if type(self.autoQualityDowning) ~= "table" then
			self.autoQualityDowning = {};
		end
	end
end

function SettingDataCenter:LoadPlayerData()
	local file_handler = file.open(file_path_player,4);
	if not file_handler then
		return;
	end

	local aaa = file_handler:read_all_text()
	if aaa ~= "" then
		local k = loadstring("return "..aaa);
		if k ~= nil then
			local data = k();
			if data then
				for kk, vv in pairs(data) do
					self.is_auto_fight[kk] = vv;
				end
			end
		end
	end
	file_handler:close();
end

function SettingDataCenter:Update()
	AudioManager.MuteAudio(not self.musicOpen,ENUM.EAudioType._2d, 1);
	AudioManager.MuteAudio(not self.soundOpen,ENUM.EAudioType.UI);
	AudioManager.MuteAudio(not self.soundOpen,ENUM.EAudioType._3d);
	AudioManager.MuteAudio(not self.soundOpen,ENUM.EAudioType._2d, 2);
	GameSettings.SetEnableEffectQualityControl(false)
	GameSettings.SetEffectQualityLevel(self.huazhivalue)
	GameSettings.GetHeroRendererMaxCount(self.renshuvalue)
	util.set_quality_setting(self.quality_setting_index,true)
	camera.set_enable_aa(self.screenAA);
	self:WriteFile();
	if CameraManager ~= nil then 
		CameraManager.refreshCameraEffect();
	end 
end

--[[静音]]
function SettingDataCenter:SetMute(flag)
    if flag then
        if self.musicOpen or self.soundOpen then
            AudioManager.MuteAudio(true)  
        end 
    else 
	    self:Update()
    end
end

function SettingDataCenter:SetMusic(state)
	self.musicOpen = state;
end

function SettingDataCenter:GetMusic()
	return self.musicOpen;
end

function SettingDataCenter:SetSound(state)
	self.soundOpen = state;
end

function SettingDataCenter:GetSound()
	return self.soundOpen;
end

function SettingDataCenter:Setintell(state)
	self.intelligenceOpen = state	
end

function SettingDataCenter:Getintelligence()
	return self.intelligenceOpen	
end

function SettingDataCenter:SetscreenAA(state)
	self.screenAA = state
end
 
function SettingDataCenter:GetscreenAA()
	return self.screenAA
end

function SettingDataCenter:SetHuazhiValue(value)
	app.log("SettingDataCenter:SetHuazhiValue "..tostring(value));
	self.huazhivalue = value;
end

function SettingDataCenter:GetHuazhiValue()
	return 	self.huazhivalue
end

function SettingDataCenter:SetManualSet(manualSet)
	self.manualSet = manualSet;
	if self.manualSet then
		g_dataCenter.autoQualitySet:SetEnable(false);
	else
		if FightScene.GetPlayMethodType() == nil then
			g_dataCenter.autoQualitySet:SetEnable(true, EFightType.rgp, false);
		else
			g_dataCenter.autoQualitySet:SetEnable(true, FightScene.GetPlayMethodType(), false);
		end
	end
end

function SettingDataCenter:GetManualSet()
	return self.manualSet;
end

function SettingDataCenter:SetAutoQualityDowning(id, value)
	if self.autoQualityDowning[id] ~= value then
		self.autoQualityDowning[id] = value;
		self:WriteFile();
	end
end

function SettingDataCenter:GetAutoQualityDowning(id)
	return self.autoQualityDowning[id];
end

function SettingDataCenter:SetRenshuValue(value)
	self.renshuvalue = value	
end

function SettingDataCenter:GetRenshuValue()
	return 	self.renshuvalue
end

function SettingDataCenter:SetRenshuValueSystem(id, value)
	self.renshuvalueBySystem[id] = value;
end

function SettingDataCenter:GetRenshuValueSystem(id)
	if self.renshuvalueBySystem[id] == nil then
		return default_renshuvalue;
	end
	return self.renshuvalueBySystem[id];
end

function SettingDataCenter:SetQualitySettingIndex(index)
	self.quality_setting_index = index
end

function  SettingDataCenter:GetQualitySettingIndex( )
	return self.quality_setting_index
end

function SettingDataCenter:SetQualitySettingIndexSystem(id, index)
	self.quality_setting_index_system[id] = index;
end

function SettingDataCenter:GetQualitySettingIndexSystem(id)
	if self.quality_setting_index_system[id] == nil then
		return default_quality_setting_index;
	end
	return self.quality_setting_index_system[id];
end

function SettingDataCenter:SetRecvServerSetting(value)
	if self.recvServerSetting ~= value then
		self.recvServerSetting = value;
		self:WriteFile();
	end
end

function SettingDataCenter:GetRecvServerSetting()
	return self.recvServerSetting;
end


function SettingDataCenter:SetCityPos(x, y, z)
    local old_x = self.city_x
    local old_y = self.city_y
    local old_z = self.city_z
	self.city_x = x;
    self.city_y = y;
    self.city_z = z;
    if self.city_x ~= old_x or self.city_y ~= old_y or self.city_z ~= old_z then
        self:WriteFile()
    end
end

function SettingDataCenter:GetCityPos()
	return self.city_x, self.city_y, self.city_z;
end

function SettingDataCenter:WriteFile()
	local t = 
	{
		musicOpen = self.musicOpen,
		soundOpen = self.soundOpen,
		intelligenceOpen = self.intelligenceOpen,		
		screenAA = self.screenAA,
		huazhivalue = self.huazhivalue,
		manualSet=self.manualSet,
		renshuvalue = self.renshuvalue,
        city_x = self.city_x,
        city_y = self.city_y,
        city_z = self.city_z,
        quality_setting_index = self.quality_setting_index,
        renshuvalueBySystem = self.renshuvalueBySystem,
		quality_setting_index_system = self.quality_setting_index_system,
        autoQualityDowning = self.autoQualityDowning,
        recvServerSetting = self.recvServerSetting,
        taskTracingTips = self.taskTracingTips,
	}

	local file_handler = file.open(file_path_common,2);
	if not file_handler then
		return;
	end
	file_handler:write_string(table.tostringEx(t));
	file_handler:close();
end

function SettingDataCenter:GetFightAutoFile()
	--0 true  1 false
	local result = false;
	if g_dataCenter and g_dataCenter.player and g_dataCenter.player.playerid then
		if self.is_auto_fight[g_dataCenter.player.playerid] ~= nil then
			result = self.is_auto_fight[g_dataCenter.player.playerid];
		end
	end
	return result;
end

--关卡
function SettingDataCenter:WriteFightAutoFile(value)
	if value ~= nil then
		if g_dataCenter and g_dataCenter.player and g_dataCenter.player.playerid then
			self.is_auto_fight[g_dataCenter.player.playerid] = value;
			local file_handler = file.open(file_path_player, 4);
			file_handler:write_string( table.toFileString(self.is_auto_fight) );
			file_handler:close()
		end
	end
end

--活动自动独立控制
function SettingDataCenter:WriteFightAutoFileToMethod(id,value)
	if value ~= nil then
		local file_path_common = tostring(g_dataCenter.player:GetGID()).."_"..tostring(id)
		local file_handler = file.open(file_path_common,4)
		file_handler:write_string( "return "..tostring(value) );
		file_handler:close()
	end
end

function SettingDataCenter:GetFightMethodAutoFile(id)
	local result = false
	local file_path_common = tostring(g_dataCenter.player:GetGID()).."_"..tostring(id)
	local file_handler = file.open_read(file_path_common);
	if file_handler then
		local aaa = file_handler:read_all_text()
		if aaa ~= "" then
			local k = loadstring(aaa);
			if k ~= nil then
				result = k() or false
			end
		end
		file_handler:close(); 
	end
	
	return result
end

function SettingDataCenter:GetTaskTracingTips()
	return self.taskTracingTips;
end

function SettingDataCenter:SetTaskTracingTips(isShow)
	if self.taskTracingTips == isShow then
		return;
	end
	self.taskTracingTips = isShow;
	self:WriteFile();
end

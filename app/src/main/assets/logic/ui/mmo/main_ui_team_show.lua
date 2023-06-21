MainUITeamShow = Class("MainUITeamShow");

function MainUITeamShow:Init(data)
	self.panel_name = self._className
	self.rootNode = data.node;
	self.bindfunc = {};
	self.bindfunc["on_load_role"] = Utility.bind_callback(self, self.on_load_role);
	-- if data.model_id then
	-- 	self:ChangeRoleByModelId(data.model_id);
	-- elseif data.number then
	-- 	self:ChangeRole(data.number);
	-- end
	self:UpdateRole();
end

function MainUITeamShow:UpdateRole()
    --local teamList = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal);
    --local cfg = g_dataCenter.package:find_card(1,g_dataCenter.player:GetImage());
	local cfg = ConfigHelper.GetRole(g_dataCenter.player:GetImage());
	if cfg then
		self:ChangeRoleByModelId(cfg.model_id);
	end
    --[[if cfg then
	    self:ChangeRole(cfg.number);
	else
		app.log("队伍信息错误。teamList:"..table.tostring(teamList)..debug.traceback());
	end]]
end

function MainUITeamShow:ChangeRole(number)
	local cfg = ConfigHelper.GetRole(number);
	if cfg then
		self:ChangeRoleByModelId(cfg.model_id);
	else
		app.log("队长id错误。number:"..tostring(number)..debug.traceback());
	end
end

function MainUITeamShow:ChangeRoleByModelId(model_id)
	if model_id == self.model_id then
		local cfg = ConfigManager.Get(EConfigIndex.t_main_show_info, self.model_id);
		self:DelayPlayAni(cfg.anim_name);
		return;
	end
	if self.obj then
		self.obj:set_active(false);
		self.obj = nil;
	end
	self.model_id = model_id;
	self.path = ObjectManager.GetHighItemModelFile(model_id);
    ResourceLoader.LoadAsset(self.path, self.bindfunc['on_load_role'],self.panel_name);
end

function MainUITeamShow:on_load_role(pid, filepath, asset_obj, error_info)
	if self.path == filepath then
		self.obj = asset_game_object.create(asset_obj);
--		app.log("main_model_id:" .. self.model_id)
		local cfg = ConfigManager.Get(EConfigIndex.t_main_show_info, self.model_id);
		local parent = self.rootNode:get_child_by_name(cfg.path);
		parent:change_model_property(0);
		self.obj:set_parent(parent);
		self.obj:set_local_position(cfg.px, cfg.py, cfg.pz);
		self.obj:set_local_scale(cfg.size, cfg.size, cfg.size);
		self.obj:set_local_rotation(cfg.rx, cfg.ry, cfg.rz);
		self:DelayPlayAni(cfg.anim_name);
		self.obj:set_name("hero1");
		if GetMainUI() and GetMainUI():GetPlayerMenu() then
			local _obj = self.obj:get_child_by_name("point_top")
			GetMainUI():GetPlayerMenu():SetRoleTalkObj(_obj)
		end
	end
end

function MainUITeamShow:DelayPlayAni(anim_name)
	if self.delayTimer then
		timer.stop(self.delayTimer);
		self.delayTimer = nil;
	end
	local function on_delay_play()
		self.delayTimer = nil;
		if self.obj then
			local cfg = ConfigManager.Get(EConfigIndex.t_main_show_info, self.model_id);
			self.obj:animator_play(anim_name);
		end
	end
	self.delayTimer = timer.create(Utility.create_callback(on_delay_play),10,1);
end

function MainUITeamShow:ClickHero(name)
	if name == self.obj:get_name() then

		-------------------------------点击播放动作-------------------------------------
		--董香
		if self.model_id == 80001001 then
            if self.obj:is_animator_name(0, "mainstand") then
                if self.dongxiangObj == nil then
                    self.dongxiangObj = self.obj:get_child_by_name("zjm_dongxiang")
                end
				if self.dongxiangObj:is_animator_name(0, "stand01") then
					self.dongxiangObj:animator_play("wing_die")
				elseif self.dongxiangObj:is_animator_name(0, "wing_stand02") then
					self.dongxiangObj:animator_play("wing_born")
				end
            end

		--金木研/笛口雏实
		elseif self.model_id == 80001000 or self.model_id == 80001016 then
			if self.obj:is_animator_name(0, "mainstand") then
				local index = math.random(1, 3)
				self.obj:animator_play("mainidle0" .. index);
			end
		end
		------------------------------------------------------------------------------

		local cfg = ConfigManager.Get(EConfigIndex.t_main_show_info, self.model_id);
		if cfg.audio_id == 0 then
			return;
		end
		if type(cfg.audio_id) == "number" then
			--AudioManager.PlayUiAudio(cfg.audio_id);
			AudioManager.ChangeBackAudioVol(0.4, 100)
			local obj = AudioManager.GetUiAudioSourceNode();
			local cbdata = {}
			cbdata.end_vol = 1
			cbdata.changeTime = 100
			AudioManager.Play3dAudio(cfg.audio_id, obj, true, true, true, true, AudioManager.ChangeBackAudioVolEx, cbdata);
		elseif type(cfg.audio_id) == "table" then
			local num = math.random(1,#cfg.audio_id);
			--AudioManager.PlayUiAudio(cfg.audio_id[num]);
			AudioManager.ChangeBackAudioVol(0.4, 100)
			local obj = AudioManager.GetUiAudioSourceNode();
			local cbdata = {}
			cbdata.end_vol = 1
			cbdata.changeTime = 100
			AudioManager.Play3dAudio(cfg.audio_id[num], obj, true, true, true, true, AudioManager.ChangeBackAudioVolEx, cbdata);

			if cfg.talk_id == 0 then
				return;
			end
			if type(cfg.talk_id) == "table" then
				self:Show_Talk(cfg.audio_id[num], cfg.talk_id[num])
			end
		end
    end
end

function MainUITeamShow:Show_Talk(id, des)
    if GetMainUI():GetPlayerMenu() then
    	GetMainUI():GetPlayerMenu():onClickShowTalk(des)
    end
end

function MainUITeamShow:Destroy()
	self:UnRegistFunc();
	if self.obj then
		self.obj = nil;
		PublicFunc.ClearUserDataRef(self)
	end
    ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.delayTimer then
		timer.stop(self.delayTimer);
		self.delayTimer = nil;
	end
end

--注销回调函数
function MainUITeamShow:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
    self.bindfunc = {};
end

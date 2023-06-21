SkillShowUI = Class("SkillShowUI", UiBaseClass);

local instance = nil;

function SkillShowUI.Create()
	if not instance then
		instance = SkillShowUI:new();
	end
end

function SkillShowUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function SkillShowUI.EndCallback()
	if instance and instance:IsShow() then
		instance:PlayEnd();
		instance:Hide();
	end
end

function SkillShowUI.Destroy()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function SkillShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/panel_fight_big_recruit.assetbundle";
    UiBaseClass.Init(self, data);
end

function SkillShowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("SkillShowUI");
    self.showed = false
    self.texHead = ngui.find_texture(self.ui,"centre_other/animation/texture_human");
end

function SkillShowUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["UseSkill"] = Utility.bind_callback(self, self.UseSkill);
    self.bindfunc["DelayPause"] = Utility.bind_callback(self, self.DelayPause);
end

function SkillShowUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    NoticeManager.BeginListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc["UseSkill"]);
end

function SkillShowUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    NoticeManager.EndListen(ENUM.NoticeType.EntityUseSkill, self.bindfunc["UseSkill"]);
end

function SkillShowUI:UpdateUi(skill_id)
	if not skill_id then
		return false;
	end
	if self.texHead == nil then
		app.log_warning("SkillShowUI 未初始化。"..debug.traceback())
		return false;
	end
	local cfg = ConfigManager.Get(EConfigIndex.t_skill_info, skill_id);
	if not cfg then
		return false;
	end
	local texPath = cfg.anim_skill_icon;
	if type(texPath) ~= "string" then
		return false;
	end
	self.texHead:set_texture(texPath);
	if cfg.anim_skill_delay == nil or cfg.anim_skill_delay < 0 then
		self.delayPause = 0.2;
	else
		self.delayPause = cfg.anim_skill_delay;
	end
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.DaZhaoSlide);
	return true;
end

function SkillShowUI:DelayPause()
	PublicFunc.UnityPause();
	AudioManager.Pause(ENUM.EAudioType._3d,true)
	--AudioManager.Pause(ENUM.EAudioType._2d,true)
	self.timer_id = nil;
end

function SkillShowUI:Show()
	UiBaseClass.Show(self);
	-- PublicFunc.UnityPause();
    if self.timer_id then
    	timer.stop(self.timer_id);
    end
    if self.delayPause ~= 0 then
    	self.timer_id = timer.create(self.bindfunc["DelayPause"], self.delayPause*1000, 1);
    else
    	self:DelayPause();
    end
	if CameraManager.GetSceneCamera() then
		CameraManager.GetSceneCamera():start_qte(0.6,0.1);
	end
end

function SkillShowUI:Hide()
	UiBaseClass.Hide(self);
	PublicFunc.UnityResume();
	AudioManager.Pause(ENUM.EAudioType._3d,false)
	--AudioManager.Pause(ENUM.EAudioType._2d,false)
	if CameraManager.GetSceneCamera() then
		CameraManager.GetSceneCamera():stop_qte(0.1);
	end
end

function SkillShowUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function SkillShowUI:PlayEnd()
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end

function SkillShowUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.timer_id then
    	timer.stop(self.timer_id);
    end
end

function SkillShowUI:UseSkill(sceneEntity, skill_id)
	if not sceneEntity:IsCaptain() then
		return;
	end
	if self:UpdateUi(skill_id) then
		self:Show();
	end
end

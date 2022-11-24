HurdleCollectBoxFightManager = Class("HurdleCollectBoxFightManager", FightManager)

function HurdleCollectBoxFightManager:InitData()
	FightManager.InitData(self)
end

function HurdleCollectBoxFightManager:InitInstance()
	FightManager.InitInstance(HurdleCollectBoxFightManager)
	return HurdleCollectBoxFightManager;
end

function HurdleCollectBoxFightManager:RegistFunc()
    FightManager.RegistFunc(self);
    self.bindfunc["OnCreateBuffer"] = Utility.bind_callback(self, self.OnCreateBuffer);
    self.bindfunc["DelayCreateEffect"] = Utility.bind_callback(self, self.DelayCreateEffect);
end

function HurdleCollectBoxFightManager:MsgRegist()
    FightManager.MsgRegist(self);
    NoticeManager.BeginListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc["OnCreateBuffer"]);
end
function HurdleCollectBoxFightManager:MsgUnRegist()
    FightManager.MsgUnRegist(self);
    NoticeManager.EndListen(ENUM.NoticeType.CreateBufferItem, self.bindfunc["OnCreateBuffer"]);
end

function HurdleCollectBoxFightManager:OnEvent_OnDeleteObj(name)
    if self.effectName == name and self.effect then
        EffectManager.deleteEffect(self.effect:GetGID(),true);
        self.effect = nil;
    end
    FightManager.OnEvent_OnDeleteObj(self, name);
end

-- 重写战斗结束逻辑
function HurdleCollectBoxFightManager:FightOver(is_set_exit, is_forced_exit)
    if not is_set_exit then
    	TimerManager.Add( function ()
    		FightManager.FightOver(self, is_set_exit, is_forced_exit)
    	end, 1000);
        return;
    end
    FightManager.FightOver(self, is_set_exit, is_forced_exit)
end

function HurdleCollectBoxFightManager:OnUiInitFinish()
	local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
	local str = hurdle.tips_string;
	local time = hurdle.tips_last;

	local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsClickMove = (cf.is_click_move == 1)
    local configIsShowStarTip = (cf.is_show_star_tip == 1)
	GetMainUI():InitWorldChat()
	GetMainUI():InitZouMaDeng()
	GetMainUI():InitOptionTip(configIsShowStarTip, configIsAuto)
	GetMainUI():InitJoystick()
	GetMainUI():InitSkillInput(configIsSwitchTarget)
	GetMainUI():InitProgressBar()
	GetMainUI():InitTriggerOperator()
	GetMainUI():InitMMOFightUIClick();
    if true or pmi then
        GetMainUI():InitTeamCanChange()
    else
        GetMainUI():InitTeamCannotChange()
    end
    GetMainUI():InitHurdleCollectBoxUi();
	GetMainUI():InitTimer()

    self:CallFightStart()
end

function HurdleCollectBoxFightManager:Destroy()
    FightManager.Destroy(self);
    if self.delayCreateTimer then
        timer.stop(self.delayCreateTimer);
        self.delayCreateTimer = nil;
    end
    self.effectName = nil;
end

function HurdleCollectBoxFightManager:OnCreateBuffer(obj)
    local fight_type = FightScene.GetStartUpEnv().levelData.fight_type;
    local count = g_dataCenter.playMethodInfo:GetCount(fight_type);
    if count >= 1 then
        return;
    end
    if self.effectName == nil and self.delayCreateTimer == nil then
        self.delayCreateTimer = timer.create(self.bindfunc["DelayCreateEffect"],1000,1);
    end
end

function HurdleCollectBoxFightManager:DelayCreateEffect()
    self.delayCreateTimer = nil;
    local dis2obj = {};
    local minDis;
    local buffList = self.buffLoader:GetAllBuffName();
    local curCap = g_dataCenter.fight_info:GetCaptain();
    local CapPos = curCap:GetPosition(true);
    for _,name in pairs(buffList) do
        local obj = ObjectManager.GetObjectByName(name);
        if obj then
            local pos = obj:GetPosition(true);
            local dis = algorthm.GetDistance(CapPos.x, CapPos.z, pos.x, pos.z);
            if minDis == nil or minDis > dis then
                minDis = dis;
            end
            dis2obj[dis] = obj;
        end
    end
    self.effect = EffectManager.createEffect(1900005);
    local x,y,z = dis2obj[minDis]:GetPositionXYZ();
    self.effect:set_local_position(x,y,z);
    self.effectName = dis2obj[minDis]:GetName();
end

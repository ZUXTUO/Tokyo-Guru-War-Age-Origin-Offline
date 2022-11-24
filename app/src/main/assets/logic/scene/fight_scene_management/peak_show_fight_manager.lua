-- 巅峰展示
-- region peak_show_fight_manager.lua
-- date: 2016-10-25
-- author: zzc

PeakShowFightManager = Class("PeakShowFightManager", FightManager)

function PeakShowFightManager:InitData()
    FightManager.InitData(self)
    -- self.moveItemShowIndex = 0
    -- self.monsterWaveIndex = 0
    self.entityJimu2 = nil
    self.entityBoss1 = nil
    self.peakData = ConfigManager.Get(EConfigIndex.t_peak_data, 1)
end

function PeakShowFightManager:RegistFunc()
	FightManager.RegistFunc(self)

    self.bindfunc['OnTriggerInstanceShow'] = Utility.bind_callback(self, self.OnTriggerInstanceShow);
    -- self.bindfunc['OnTriggerCreateMonster'] = Utility.bind_callback(self, self.OnTriggerCreateMonster);
    self.bindfunc['OnTriggerPlayVideoAction'] = Utility.bind_callback(self, self.OnTriggerPlayVideoAction);
    self.bindfunc['on_skip_btn'] = Utility.bind_callback(self, self.on_skip_btn);
    NoticeManager.BeginListen(ENUM.NoticeType.TriggerShowInstance, self.bindfunc["OnTriggerInstanceShow"])
    -- NoticeManager.BeginListen(ENUM.NoticeType.TriggerCreateMonster, self.bindfunc["OnTriggerCreateMonster"])
    NoticeManager.BeginListen(ENUM.NoticeType.TriggerPlayVideoAction, self.bindfunc["OnTriggerPlayVideoAction"])
end

function PeakShowFightManager:UnRegistFunc()
    NoticeManager.EndListen(ENUM.NoticeType.TriggerShowInstance, self.bindfunc["OnTriggerInstanceShow"])
    -- NoticeManager.EndListen(ENUM.NoticeType.TriggerCreateMonster, self.bindfunc["OnTriggerCreateMonster"])
    NoticeManager.EndListen(ENUM.NoticeType.TriggerPlayVideoAction, self.bindfunc["OnTriggerPlayVideoAction"])
	FightManager.UnRegistFunc(self)
end

function PeakShowFightManager.Begin()
    FightScene.SetHideLoading(true)

    local cfg = ConfigManager.Get(EConfigIndex.t_peak_data, 1)
    local fs = FightStartUpInf:new()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
    fs:SetLevelIndex(cfg.hurdle_id);
    SceneManager.PushScene(FightScene, fs);
end

function PeakShowFightManager.InitInstance()
    app.opt_enable_net_dispatch(false);
    
	FightManager.InitInstance(PeakShowFightManager)
	return PeakShowFightManager
end

function PeakShowFightManager:ClearUpInstance()
	FightManager.ClearUpInstance(self)

    -- BlackFadeEffectUi.Destroy()
    --
    PeakHitUi.Destroy()
    PeakGuideUi.Destroy()
    
    self.peakData = nil
    self.entityJimu2 = nil
    self.entityBoss1 = nil

end

function PeakShowFightManager:SetPlayerCamera()
    local jinmu_id = self.peakData.jinmu_2 
    local boss_id = self.peakData.boss_1

    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain then
        g_dataCenter.fight_info:DeleteObj(captain:GetName())
    end


    local boss = g_dataCenter.fight_info:GetBoss(2) 
    if boss then
        self.entityBoss1 = boss
    end

    local monster_list = g_dataCenter.fight_info:GetMonsterList(1)
    for k, v in pairs(monster_list) do
        local entity = ObjectManager.GetObjectByName(v)
        if entity.config.id == jinmu_id then
            self:GenFakeHeroData(entity)
            entity:SetOwnerPlayerGID(g_dataCenter.player.playerid)
            g_dataCenter.fight_info:AddHero(entity)

            CameraManager.init_target(entity)
            CameraManager.MoveToTargetImm()
            TriggerFunc.ResetMoveCamera()

            self.entityJimu2 = entity
            break;
        end
    end

    self:SetHeroTeamAI()

    -- 切换背景音乐
    -- AudioManager.Stop(nil, true);
    -- AudioManager.Play2dAudioList({[1]={id=81000023,loop=-1}})
end

function PeakShowFightManager:GenFakeHeroData(entity)
    local cardinfo = entity:GetCardInfo()
    
    cardinfo.realRarity = ENUM.EHeroRarity.Orange3
    cardinfo.rarity = Const.HERO_MAX_STAR
    cardinfo.level = 80
    cardinfo.pro_type = ENUM.EProType.Gong
end

-- 剧情播放结束
function PeakShowFightManager:OnScreenPlayOver(playid, isSkip)
    -- 调用技能剧情
    if playid == self.peakData.taste_plot2_id then
        -- self.entityJimu2:SetAI(ENUM.EAI.MainHeroAutoFight)
        -- self.entityJimu2:LearnSkill(146, 1, nil, 10) -- 学习技能施放击退
        -- self.entityJimu2:SetCanUseSkillIndex({10})
        -- self.entityBoss1:SetCanUseSkillIndex({1})

        -- GetMainUI():Hide()

        -- CameraManager.init_target(self.entityBoss1)
		
    -- 进入场景剧情结束
    elseif playid == self.peakData.taste_plot_id then
        -- CameraManager.SetSceneCameraActive(true)

        local cbfunc = function()
            self:SetPlayerCamera()
            ScreenPlay.Play(self.peakData.taste_jimu_plot_id)
        end
        PeakHitUi.Start({callback=cbfunc})

    -- 变身剧情结束
    elseif playid == self.peakData.taste_jimu_plot_id then
        GetMainUI():Hide()
        SkillTips.EnableSkillTips(false);

        -- 改为定时20s后使用自动技能
        local autoSkillFunc = function()
            self.entityJimu2:SetAI(ENUM.EAI.MainHeroAutoFight)
            self.entityJimu2:LearnSkill(146, 1, nil, 10) -- 学习技能施放击退
            self.entityJimu2:SetCanUseSkillIndex({10})
            -- self.entityBoss1:SetCanUseSkillIndex({1})

            GetMainUI():Hide()

            CameraManager.init_target(self.entityBoss1)

            --[[完成与杰森对打]]
            SystemLog.AppStartClose(500000012);
        end

        local func = function()
            GetMainUI():Show()
            SkillTips.EnableSkillTips(false);
            ObjectManager.EnableAllAi(true)
            TimerManager.Add(autoSkillFunc, 20000, 1)
            self:RealStartFight();

            --[[手势教学操作图片]]
            SystemLog.AppStartClose(500000011);
        end
        PeakGuideUi.Start({callback= func })

        --[[变身动画播放完毕]]
        SystemLog.AppStartClose(500000010);
    end
end

function PeakShowFightManager:GetUIAssetFileList(out_file_list)
    -- FightManager.AddPreLoadRes(MMOMainUI.GetTimerRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetJoystickRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetSkillInputRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetMMOFightUIClickRes(), out_file_list)
    FightManager.AddPreLoadRes(MMOMainUI.GetTeamCanChangeRes(), out_file_list)
    FightManager.AddPreLoadRes(PeakHitUi.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(PeakGuideUi.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(BlackFadeEffectUi.GetResList(), out_file_list)
    FightManager.AddPreLoadRes(GuideUI.GetResList(), out_file_list)
    -- 临时处理：解决播视频背景音乐未关闭的问题
    -- FightManager.AddPreLoadRes("assetbundles/prefabs/sound/prefab/2d/m_pk.assetbundle", out_file_list)
end

function PeakShowFightManager:GetHeroAssetFileList(out_file_list)
    FightManager.GetHeroAssetFileList(self, out_file_list)
end

-- 不显示战斗界面
function PeakShowFightManager:OnUiInitFinish()
    -- FightManager.OnUiInitFinish(self)

    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
	local configIsAuto = cf.is_auto > 0;
	local configIsSwitchTarget = cf.is_switch_target > 0;
	local configIsClickMove = (cf.is_click_move == 1)

    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitMMOFightUIClick()
    GetMainUI():InitTeamCanChange()
    -- GetMainUI():InitTimer()

    -- self:SetSkillInputUiShow(0)

    ObjectManager.ForEachObj(function (objname,obj)
    	obj:OnFightStart()
	end)

    self:LoadFirstMovie()
end

function PeakShowFightManager:on_skip_btn()
    self:ExitPeakShow()
end

-- 重写：战斗结束有单独流程，直接退出
function PeakShowFightManager:FightOver(is_forced_exit)
end

-- 重写：去掉通用逻辑
function PeakShowFightManager:OnFightOver()
end

-- 重写：去掉过关检测条件
function PeakShowFightManager:CheckPassCondition()
end

-- 触发光圈显示
-- function PeakShowFightManager:OnTriggerInstanceShow(obj)
--     if self.moveItemShowIndex >= 2 then return end

--     self.moveItemShowIndex = self.moveItemShowIndex + 1
--     GuideManager.CheckWaitFunc( "show_region", self.moveItemShowIndex )
-- end

-- 触发刷怪
-- function PeakShowFightManager:OnTriggerCreateMonster()
--     if self.monsterWaveIndex >= 2 then return end

--     self.monsterWaveIndex = self.monsterWaveIndex + 1
--     -- self:SetSkillInputUiShow(self.monsterWaveIndex)
--     -- GuideManager.CheckWaitFunc( "create_monster", self.monsterWaveIndex )
-- end

-- 技能播放视频开始
function PeakShowFightManager:OnTriggerPlayVideoAction()
    if self.entityJimu2 then
        ObjectManager.DeleteObj(self.entityJimu2:GetName())
        self.entityJimu2 = nil
    end
    if self.entityBoss1 then
        ObjectManager.DeleteObj(self.entityBoss1:GetName())
        self.entityBoss1 = nil
    end

    SkillTips.EnableSkillTips(false);
    self:RealEndFight();
end

-- 按下了摇杆
function PeakShowFightManager:OnRockerTouchBegin()
    GuideManager.CheckHideUiFunc( "move_rocker" )
end

-- 普攻
function PeakShowFightManager:OnNormalAttack()
    GuideManager.CheckHideUiFunc( "use_skill", 1 )
end

-- 技能
function PeakShowFightManager:OnSkill(param)
    -- 1,2,3,4->加血、技能1、技能2、技能3
    local array = { [1] = 5, [2] = 2, [3] = 3, [4] = 4 }
    GuideManager.CheckHideUiFunc( "use_skill", array[param] )
end

-- 右下技能按钮面板
function PeakShowFightManager:SetSkillInputUiShow(index, bool)
    local uiSkillInput = GetMainUI():GetSkillInput()
    if uiSkillInput == nil or uiSkillInput.ui == nil then return end

    index = index or 0
    if index > 1 then
        index = 4
    end
    local btnArray = {}

    -- UI结构顺序1,2,3,4,5：普攻、加血、技能1、技能2、技能3
    -- 修改为1,3,4,5,2：普攻、技能1、技能2、技能3、加血
    btnArray[1] = ngui.find_button(uiSkillInput.ui, "btn_sp" .. 1);
    btnArray[2] = ngui.find_button(uiSkillInput.ui, "btn_sp" .. 3);
    btnArray[3] = ngui.find_button(uiSkillInput.ui, "btn_sp" .. 4);
    btnArray[4] = ngui.find_button(uiSkillInput.ui, "btn_sp" .. 5);
    btnArray[5] = ngui.find_button(uiSkillInput.ui, "btn_sp" .. 2);
    
    for i = 1, 5 do
        if i > index then
            btnArray[i]:set_active(false)
        else
            btnArray[i]:set_active(true)
            -- if i == index then
            --     btnArray[i]:set_enable(true)
            -- else
            --     btnArray[i]:set_enable(true)
            -- end
        end
    end
end

function PeakShowFightManager:ExitPeakShow()
    LocalFile.WritePrologueRecord(1)
    SceneManager.BeginPlayFirstStory()
end

function PeakShowFightManager:LoadFirstMovie()
    local finishFunc = function()
        ScreenPlay.Play(self.peakData.taste_plot_id)
        --[[完成片头动画播放]]
        SystemLog.AppStartClose(500000008);
    end

    local readyFunc = function()
        EnterShow.CallStartLoadback()
    end

    PublicFunc.MediaPlay(
        ConfigManager.Get(EConfigIndex.t_discrete, 83000078).data, 
        finishFunc, readyFunc, false, true, nil)
end

function g_peak_show_skill_callback()
    --[[与杰森对打动画播放完毕]]
    SystemLog.AppStartClose(500000013);
    
    local fightManager = FightScene.GetFightManager()
    if fightManager and fightManager.ExitPeakShow then
        -- 保持黑幕，等待一段时间，保证视频播放结束后纹理能够正常加载
        BlackFadeEffectUi.KeepBlack({callback=nil,duration=1})
        fightManager:ExitPeakShow(func)
    end
end

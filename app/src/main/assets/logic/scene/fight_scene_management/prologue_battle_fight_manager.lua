

PrologueBattleFightManager = Class('PrologueBattleFightManager' , FightManager)

function PrologueBattleFightManager.InitInstance()
    app.opt_enable_net_dispatch(false);

	FightManager.InitInstance(PrologueBattleFightManager)
	return PrologueBattleFightManager;
end

function PrologueBattleFightManager:InitData()
    FightManager.InitData(self)
    self.isguide = (FightScene.GetCurHurdleID() == 60020000)
end

function PrologueBattleFightManager:Start()
    FightManager.Start(self)
end

function PrologueBattleFightManager:RegistFunc()
	FightManager.RegistFunc(self)

    self.bindfunc['OnTriggerEffect'] = Utility.bind_callback(self, self.OnTriggerEffect);
    self.bindfunc['OnTriggerCreateMonster'] = Utility.bind_callback(self, self.OnTriggerCreateMonster);
    self.bindfunc['OnScenePlayStart'] = Utility.bind_callback(self, self.OnScenePlayStart);
    self.bindfunc['OnScenePlayOver'] = Utility.bind_callback(self, self.OnScenePlayOver);
    NoticeManager.BeginListen(ENUM.NoticeType.TriggerEffect, self.bindfunc["OnTriggerEffect"])
    NoticeManager.BeginListen(ENUM.NoticeType.TriggerCreateMonster, self.bindfunc["OnTriggerCreateMonster"])
    NoticeManager.BeginListen(ENUM.NoticeType.ScreenPlayBegin, self.bindfunc["OnScenePlayStart"])
    NoticeManager.BeginListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnScenePlayOver"])
end

function PrologueBattleFightManager:UnRegistFunc()
    NoticeManager.EndListen(ENUM.NoticeType.TriggerEffect, self.bindfunc["OnTriggerEffect"])
    NoticeManager.EndListen(ENUM.NoticeType.TriggerCreateMonster, self.bindfunc["OnTriggerCreateMonster"])
    NoticeManager.EndListen(ENUM.NoticeType.ScreenPlayBegin, self.bindfunc["OnScenePlayStart"])
    NoticeManager.EndListen(ENUM.NoticeType.ScreenPlayOver, self.bindfunc["OnScenePlayOver"])
	FightManager.UnRegistFunc(self)
end

function PrologueBattleFightManager:OnTriggerEffect(triggerid)
    -- 显示第一个光圈
    if triggerid == 290000 then
        
    -- 进入第一个光圈刷第一波怪
    elseif triggerid == 290001 then
        GuideManager.CheckWaitFunc( "create_monster", 1 )
        
    -- 第一波怪死亡刷第二波怪
    elseif triggerid == 290002 then
        GuideManager.CheckWaitFunc( "kill_monster", 1 )
        TimerManager.Add(function() 
            self:SetSkillInputUiShow(2)
            GuideManager.CheckWaitFunc( "create_monster", 2 )
        end, 2000)
        TimerManager.Add(function() GuideManager.CheckHideUiFunc( "time_over", 0 ) end, 1000)

    -- 第二波怪死亡显示第二个光圈
    elseif triggerid == 290003 then
        GuideManager.CheckWaitFunc( "kill_monster", 2 )
        -- GuideManager.CheckWaitFunc( "show_region", 2 )

    -- 进入第二个光圈刷第三波怪
    elseif triggerid == 290004 then
         self:SetSkillInputUiShow(3)
        GuideManager.CheckWaitFunc( "create_monster", 3 )

    -- 第三波怪死亡刷第四波怪
    elseif triggerid == 290005 then
        GuideManager.CheckWaitFunc( "kill_monster", 3 )
        GuideManager.CheckWaitFunc( "create_monster", 4 )

    -- 第四波怪死亡显示第三个光圈
    elseif triggerid == 290006 then
        GuideManager.CheckWaitFunc( "kill_monster", 4 )
        -- GuideManager.CheckWaitFunc( "show_region", 3 )

    -- 进入第三个光圈刷BOSS
    elseif triggerid == 290007 then

    -- BOSS血量30%触发
    elseif triggerid == 290008 then
        self:SetSkillInputUiShow(4)
        self.doneSkill3 = false
        GuideManager.CheckWaitFunc( "battle_burst", 0 )
        
    end
end

function PrologueBattleFightManager:OnScenePlayStart(playid)
    -- 修正站在触发器里面杀死第四波触发剧情新手引导不消失的bug
    if playid == 60039001 then
        GuideManager.CheckHideUiFunc( "move_joystick" )

    elseif playid == 60039012 then
        --[[与神代战斗时钢筋掉落动画开始]]
		SystemLog.AppStartClose(500000027);

    end
end

function PrologueBattleFightManager:OnScenePlayOver(playid)
    if playid == 60039001 then
        --[[BOSS出场与杰森对话结束]]
		SystemLog.AppStartClose(500000021);

    elseif playid == 60039010 then
        --[[序章0-2对话完毕]]
		SystemLog.AppStartClose(500000025);

    elseif playid == 60039011 then
        --[[神代登场完毕]]
		SystemLog.AppStartClose(500000026);

    elseif playid == 60039012 then
        --[[钢筋掉落动画结束]]
		SystemLog.AppStartClose(500000028);

    end
end

function PrologueBattleFightManager:OnTriggerCreateMonster(entity)
    if entity:IsBoss() then
        -- 替换掉血的接口
        if entity.ChangeHP then
            entity.ChangeHP_Old = entity.ChangeHP
            local replace_func = function(boss_entity, delta)
                if boss_entity:GetHP() < boss_entity:GetMaxHP() * 0.2 and not self.doneSkill3 then
                    -- 特殊处理，等待技能3释放才掉血
                else
                    return boss_entity.ChangeHP_Old(boss_entity, delta)
                end
            end
            entity.ChangeHP = replace_func
        end
    end
end

function PrologueBattleFightManager:onForcedExit()
    --g_dataCenter.CloneBattle:EndGame(true)
end

function PrologueBattleFightManager:OnShowFightResultUI()

    if 60020000 == FightScene.GetCurHurdleID() then
        --[[序章0-1结束]]
		SystemLog.AppStartClose(500000023);

        LocalFile.WritePrologueRecord(2)
        SceneManager.BeginPlaySecondStory()
    elseif 60020001 == FightScene.GetCurHurdleID() then
        LocalFile.WritePrologueRecord(3)
        EnterShow.CallStartBack()
        app.log("[[序章0-1结束]]");
        --SystemHintUI.SetAndShow(ESystemHintUIType.two, "资源文件信息为空！请重试！",
        --    { str = "是", func = Root.url_get_system_info }, { str = "否", func = Root.quit }
        --);
        SystemHintUI.SetAndShow(ESystemHintUIType.two, "是否继续新手教程？",
            { str = "是", func = NoticeManager.GetTeach },{ str = "否", func = NoticeManager.NoTeach }
        );
        SceneManager.PushMainCityScene();
        app.log("进入主城");
        GameBegin.login_bg_destroy(); 
    end
end

function PrologueBattleFightManager:GenFakeHeroData(entity)
    local cardinfo = entity:GetCardInfo()
    
    local id = cardinfo.number

    if id == 33000161 then
        cardinfo.realRarity = ENUM.EHeroRarity.Orange3
        cardinfo.rarity = Const.HERO_MAX_STAR
        cardinfo.level = 80
        cardinfo.pro_type = ENUM.EProType.Gong
    elseif id == 33000261 then
        cardinfo.realRarity = ENUM.EHeroRarity.White
        cardinfo.rarity = 1
        cardinfo.level = 1
        cardinfo.pro_type = ENUM.EProType.Gong
    end
end

function PrologueBattleFightManager:OnUiInitFinish()

    local monster_list = g_dataCenter.fight_info:GetMonsterList(1)
    
    for k, v in pairs(monster_list) do
        local entity = ObjectManager.GetObjectByName(v)
        self:GenFakeHeroData(entity)
        if entity.config.id == 33000161 or entity.config.id == 33000261 then
            entity:SetOwnerPlayerGID(g_dataCenter.player.playerid)
            g_dataCenter.fight_info:AddHero(entity)
            -- FightScene.GetStartUpEnv():SetHeroList(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, {})

            CameraManager.init_target(entity)
            CameraManager.MoveToTargetImm()

            break;
        end
    end

    self:SetHeroTeamAI()
    
    -- FightManager.OnUiInitFinish(self)
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    local configIsAuto = cf.is_auto > 0;
    local configIsSwitchTarget = cf.is_switch_target > 0;
    local configIsClickMove = (cf.is_click_move == 1)

    GetMainUI():InitJoystick()
    GetMainUI():InitSkillInput(configIsSwitchTarget)
    GetMainUI():InitMMOFightUIClick()
    GetMainUI():InitTeamCanChange()

    if self.isguide then 
        self:SetSkillInputUiShow(1)
    else
        self:SetSkillInputUiShow(2)
    end
    
    self:CallFightStart()
end

function PrologueBattleFightManager:CallFightStart()
    ObjectManager.ForEachObj(function (objname,obj)
        obj:OnFightStart()
    end)

    --没得剧情的关卡只能放在这通知剧情结束
    if not ScreenPlay.IsRun() then
        NoticeManager.Notice(ENUM.NoticeType.ScreenPlayOver, 0, true)
        self:EndScreePlay();
    else
        ScreenPlay.SetCallback(function ()
            self:EndScreePlay();
            

            if 60020000 == FightScene.GetCurHurdleID() then
                --[[序章0-1剧情动画播放完毕]]
                 SystemLog.AppStartClose(500000014);

            elseif 60020001 == FightScene.GetCurHurdleID() then
                --[[序章0-2剧情动画播放完毕]]
                SystemLog.AppStartClose(500000024);
            end
        end);
    end
end

-- 按下了摇杆
function PrologueBattleFightManager:OnRockerTouchBegin()
    GuideManager.CheckHideUiFunc( "move_joystick" )
end

-- 普攻
function PrologueBattleFightManager:OnNormalAttack()
    GuideManager.CheckHideUiFunc( "use_skill", 1 )
end

-- 技能
function PrologueBattleFightManager:OnSkill(param)
    -- 1,2,3,4->加血、技能1、技能2、技能3
    local array = { [1] = 5, [2] = 2, [3] = 3, [4] = 4 }
    local guideSkill = GuideManager.CheckHideUiFunc( "use_skill", array[param] )

    --大招释放
    if array[param] == 4 then
        self.doneSkill3 = true
        -- TimerManager.Add(function() GuideManager.CheckWaitFunc( "battle_exit", 0 ) end, 200)
    end

    if guideSkill then
        --立即清除cd
        local captain = g_dataCenter.fight_info:GetCaptain()
        if captain and captain:GetSkillByUIIndex(param) then
            GetMainUI():SkillStopCD(param)
            captain:GetSkillByUIIndex(param):ClearCD()
        end
    end
end

-- 右下技能按钮面板
function PrologueBattleFightManager:SetSkillInputUiShow(index, bool)
    
    local uiSkillInput = GetMainUI():GetSkillInput()
    if uiSkillInput == nil or uiSkillInput.ui == nil then return end

    index = index or 0
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
            if i == index then
                btnArray[i]:set_enable(true)
            else
                btnArray[i]:set_enable(true)
            end
        end
    end

    self.skillIndex = index
end

function PrologueBattleFightManager:GetEnableSkillIndex()
    return self.skillIndex or 0
end

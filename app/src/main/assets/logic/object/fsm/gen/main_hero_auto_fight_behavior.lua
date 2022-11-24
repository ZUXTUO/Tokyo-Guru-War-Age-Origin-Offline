main_hero_auto_fight_behavior = {
    {
        default = true,
        name = "patrol",
        subFSM = "actor_along_path_patrol",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_HeroDetectedMonster, 0,HFSM._funcall_, AI_OtherHeroIsAttacking, 0,}, to = "Fight"},
            {condition = {HFSM._funcall_, AI_PrepareOPenObstacle, 0,}, to = "prepareopenobstacle"},
            {condition = {HFSM._funcall_, AI_NeedToOpenObstacle, 0,}, to = "gotoOpenPos"},
        }
    },

    {
        state = "AI_State_Fight",
        name = "Fight",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_MainHeroAutoFightNeedUseAddHPSkill, 0,}, to = "addhp"},
            {condition = {HFSM._or_, HFSM._funcall_, AI_TargetIsDead, 0,HFSM._funcall_, AI_TargetIsHide, 0,}, to = "WaitSkillEnd"},
        }
    },

    {
        state = "AI_State_UseAddHPSkillOnce",
        name = "addhp",
        transitions = {
            {condition = {}, to = "Fight"},
        }
    },

    {
        name = "WaitSkillEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "ClearTargetAndCheckNextAction"},
        }
    },

    {
        name = "ClearTargetAndCheckNextAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_HeroDetectedMonster, 1,HFSM._const_immediate_, true, }, to = "Fight"},
            {condition = {HFSM._funcall_, AI_OtherHeroIsAttacking, 0,}, to = "Fight"},
            {condition = {}, to = "leaveFightState"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "leaveFightState",
        transitions = {
            {condition = {HFSM._funcall_, AI_TeamNeedRestoreHP, 0,}, to = "teamRestoreHP"},
            {condition = {}, to = "patrol"},
        }
    },

    {
        state = "AI_State_ContinueUseAddHPSkill",
        name = "teamRestoreHP",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_BeAttacked, 0,HFSM._funcall_, AI_OtherHeroIsAttacking, 0,}, to = "Fight"},
            {condition = {HFSM._funcall_, AI_TeamRestoreHPEnd, 0,}, to = "patrol"},
        }
    },

    {
        state = "AI_State_Patrol",
        name = "prepareopenobstacle",
        transitions = {
            {condition = {HFSM._not_, HFSM._funcall_, AI_PrepareOPenObstacle, 0,}, to = "patrol"},
        }
    },

    {
        state = "AI_State_GotoOpenObstaclePos",
        name = "gotoOpenPos",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "waitPlayerOpen"},
            {condition = {HFSM._not_, HFSM._funcall_, AI_NeedToOpenObstacle, 0,}, to = "patrol"},
        }
    },

    {
        state = "AI_State_ExecOpenObstacleAction",
        name = "waitPlayerOpen",
        transitions = {
            {condition = {HFSM._funcall_, AI_OpenObstacleEnd, 0,}, to = "patrol"},
        }
    },

}


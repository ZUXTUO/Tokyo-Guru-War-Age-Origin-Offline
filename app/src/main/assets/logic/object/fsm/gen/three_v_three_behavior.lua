three_v_three_behavior = {
    {
        default = true,
        name = "detectFirstAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "Fight"},
            {condition = {}, to = "patrol"},
        }
    },

    {
        state = "AI_State_MonsterFight",
        name = "Fight",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_AIHeroExecAddHPAction, 0,}, to = "addhp"},
            {condition = {HFSM._funcall_, AI_3v3HeroNeedExecEscapeAction, 0,}, to = "leavetarge1"},
            {condition = {HFSM._funcall_, AI_3v3NeedExecEatAddHPItem, 0,}, to = "leavetarge2"},
            {condition = {HFSM._funcall_, AI_HaveMoreClosedTargetThanCurrentTarget, 0,}, to = "ChangeToNextTarget"},
            {condition = {HFSM._or_, HFSM._funcall_, AI_TargetIsDead, 0,HFSM._or_, HFSM._funcall_, AI_CurrentTargetOutOfViewRange, 0,HFSM._funcall_, AI_TargetIsHide, 0,}, to = "WaitSkillEnd"},
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
        state = "AI_State_LeaveFightState",
        name = "leavetarge1",
        transitions = {
            {condition = {}, to = "RetrunMyBase"},
        }
    },

    {
        state = "AI_State_HeroReturnMyBase",
        name = "RetrunMyBase",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "stand"},
            {condition = {HFSM._funcall_, AI_FindAddHPItem, 0,}, to = "eatAddHPItem"},
        }
    },

    {
        state = "AI_State_EscapWaitHPRestoreFull",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_OnBaseAroundHasEnemy, 0,}, to = "Fight"},
            {condition = {HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "detectFirstAction"},
        }
    },

    {
        state = "AI_State_GoToEatAddHPItem",
        name = "eatAddHPItem",
        transitions = {
            {condition = {HFSM._funcall_, AI_EatAddHPItemEnd, 0,}, to = "waitEatAddHPEnd"},
        }
    },

    {
        name = "waitEatAddHPEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_3v3HeroNeedExecEscapeAction, 0,}, to = "RetrunMyBase"},
            {condition = {}, to = "detectFirstAction"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "leavetarge2",
        transitions = {
            {condition = {}, to = "eatAddHPItem"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToNextTarget",
        transitions = {
            {condition = {}, to = "Fight"},
        }
    },

    {
        name = "WaitSkillEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "FindNxtTarget"},
        }
    },

    {
        name = "FindNxtTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_FindNextTarget, 0,}, to = "Fight"},
            {condition = {}, to = "leavetarge3"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "leavetarge3",
        transitions = {
            {condition = {}, to = "patrol"},
        }
    },

    {
        stateKey = "actor_patrol_key",
        name = "patrol",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "Fight"},
        }
    },

}


robot_three_v_three_behavior = {
    {
        default = true,
        state = "AI_Sate_AddTownerAttackMeRecord",
        name = "addEventLisent",
        transitions = {
            {condition = {}, to = "detectFirstAction"},
        }
    },

    {
        name = "detectFirstAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_DetectTargetBySkillDistanceAndSkillEnable, 0,}, to = "Fight"},
            {condition = {}, to = "patrol"},
        }
    },

    {
        state = "AI_State_FightStateAndLeaveClear",
        name = "Fight",
        subFSM = "fight_object_base",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AIC_LostTargetCommonCheck, 0,HFSM._funcall_, AI_SubFSMIsEnd, 0,}, to = "detectFirstAction"},
            {condition = {HFSM._funcall_, AI_3v3NeedExecEatAddHPItem, 0,}, to = "eatAddHPItem"},
            {condition = {HFSM._funcall_, AI_HaveAddHpSkillAndNeedAndCan, 0,}, to = "useAddhp"},
            {condition = {HFSM._funcall_, AI_3v3HeroNeedExecEscapeAction, 0,}, to = "RetrunMyBase"},
            {condition = {HFSM._funcall_, AI_TownerIsAttackMe, 0,}, to = "MoveToSafePos"},
            {condition = {HFSM._funcall_, AI_EnemyIsDangous, 0,}, to = "escapeToHPPool"},
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
        state = "AI_State_HeroReturnMyBase",
        name = "RetrunMyBase",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "stand"},
        }
    },

    {
        state = "AI_State_EscapWaitHPRestoreFull",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "detectFirstAction"},
        }
    },

    {
        state = "Fight_State_Attack",
        name = "useAddhp",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "detectFirstAction"},
        }
    },

    {
        state = "AI_State_MoveToSafePosAwayOffTowner",
        name = "MoveToSafePos",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "detectFirstAction"},
        }
    },

    {
        state = "AI_State_HeroReturnMyBase",
        name = "escapeToHPPool",
        transitions = {
            {condition = {HFSM._funcall_, AI_EscapeDangousRangeHasSave, 0,}, to = "detectFirstAction"},
            {condition = {HFSM._funcall_, AI_3v3NeedExecEatAddHPItem, 0,}, to = "eatAddHPItem"},
            {condition = {HFSM._funcall_, AI_3v3HeroNeedExecEscapeAction, 0,}, to = "RetrunMyBase"},
        }
    },

    {
        stateKey = "actor_patrol_key",
        name = "patrol",
        transitions = {
            {condition = {HFSM._funcall_, AI_DetectTargetBySkillDistanceAndSkillEnable, 0,}, to = "Fight"},
            {condition = {HFSM._funcall_, AI_HaveAddHpSkillAndNeedAndCan, 0,}, to = "useAddhp"},
        }
    },

}


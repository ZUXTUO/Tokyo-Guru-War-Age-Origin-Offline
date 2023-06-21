ai_hero_fight_behavior = {
    {
        default = true,
        stateKey = "actor_patrol_key",
        name = "checkIsNeedEatItem",
        transitions = {
            {condition = {HFSM._funcall_, AI_AroundNotTarget, 0,}, to = "searchBuff"},
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "fight_behavior"},
        }
    },

    {
        name = "searchBuff",
        transitions = {
            {condition = {HFSM._funcall_, AI_SearchLatestBuffItem, 0,}, to = "eatBuffItemItem"},
            {condition = {}, to = "checkIsNeedEatItem"},
        }
    },

    {
        state = "AI_State_GoToEatBuffItem",
        name = "eatBuffItemItem",
        transitions = {
            {condition = {HFSM._funcall_, AI_EatBuffItemEnd, 0,}, to = "checkIsNeedEatItem"},
        }
    },

    {
        state = "AI_State_MonsterFight",
        name = "fight_behavior",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_LostTarget, 0,}, to = "WaitSkillEnd"},
            {condition = {HFSM._funcall_, AI_AIHeroExecAddHPAction, 0,}, to = "addhp"},
            {condition = {HFSM._funcall_, AI_HaveMoreClosedTargetThanCurrentTarget, 0,}, to = "ChangeToNextTarget"},
            {condition = {HFSM._funcall_, AI_AIHeroExecEscapeAction, 0,}, to = "leavetarge2"},
        }
    },

    {
        name = "WaitSkillEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "leavetarge1"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "leavetarge1",
        transitions = {
            {condition = {}, to = "checkIsNeedEatItem"},
        }
    },

    {
        state = "AI_State_UseAddHPSkillOnce",
        name = "addhp",
        transitions = {
            {condition = {}, to = "fight_behavior"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToNextTarget",
        transitions = {
            {condition = {}, to = "fight_behavior"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "leavetarge2",
        transitions = {
            {condition = {HFSM._funcall_, AI_SearchLatestBuffItem, 0,}, to = "eatBuffItemItem"},
            {condition = {}, to = "escape"},
        }
    },

    {
        state = "AI_State_AIHeroRandomEscape",
        name = "escape",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_MoveComplete, 0,HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "searchBuff"},
        }
    },

}


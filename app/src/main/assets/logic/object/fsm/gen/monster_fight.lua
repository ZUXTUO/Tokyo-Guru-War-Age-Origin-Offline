monster_fight = {
    {
        default = true,
        state = "AI_State_MonsterFight",
        subFSMKey = "monster_fight_key",
        name = "Fight",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "BeRepel", HFSM._const_immediate_, false, }, to = "BeRepel"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "PlayBeAttackAni", HFSM._const_immediate_, false, }, to = "PlayBeAttackAni"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Transform", HFSM._const_immediate_, false, }, to = "Transform"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Throw", HFSM._const_immediate_, false, }, to = "Throw"},
            {condition = {HFSM._funcall_, AI_BeTauntCanChangeTarget, 0,}, to = "changeTauntTarget"},
            {condition = {HFSM._or_, HFSM._funcall_, AI_TargetIsDead, 0,HFSM._or_, HFSM._funcall_, AI_CurrentTargetOutOfViewRange, 0,HFSM._funcall_, AI_TargetIsHide, 0,}, to = "WaitSkillEnd"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_MonsterIsOutofActRange, 0,}, to = "Exit"},
        }
    },

    {
        state = "AI_State_BeRepel",
        name = "BeRepel",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "BeRepel", HFSM._const_immediate_, false, }, to = "BeRepel"},
            {condition = {HFSM._funcall_, AI_RepelIsEnd, 0,}, to = "Fight"},
        }
    },

    {
        state = "AI_State_PlayBeAttackAni",
        name = "PlayBeAttackAni",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Throw", HFSM._const_immediate_, false, }, to = "Throw"},
            {condition = {HFSM._and_, HFSM._notequal_, HFSM._funcall_, AI_GetBeAttackAniType, 0,HFSM._const_immediate_, 5, HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "BeRepel", HFSM._const_immediate_, false, }, to = "BeRepel"},
            {condition = {HFSM._and_, HFSM._equal_, HFSM._funcall_, AI_GetBeAttackAniType, 0,HFSM._const_immediate_, 5, HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "PlayBeAttackAni", HFSM._const_immediate_, false, }, to = "PlayBeAttackAni"},
            {condition = {HFSM._funcall_, AI_PlayBeAttackAniIsEnd, 0,}, to = "actionDelay"},
        }
    },

    {
        state = "AI_State_Throw",
        name = "Throw",
        transitions = {
            {condition = {HFSM._funcall_, AI_ThrowStateIsEnd, 0,}, to = "actionDelay"},
        }
    },

    {
        state = "AI_State_actionOrderDelay",
        name = "actionDelay",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "Fight"},
        }
    },

    {
        state = "AI_State_Transform",
        name = "Transform",
        transitions = {
            {condition = {HFSM._funcall_, AI_TransformStateIsEnd, 0,}, to = "Fight"},
        }
    },

    {
        state = "AI_State_ChangeToTauntTarget",
        name = "changeTauntTarget",
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
            {condition = {}, to = "Exit"},
        }
    },

    {
        state = "AI_State_FightExit",
        name = "Exit",
        transitions = {
        }
    },

}


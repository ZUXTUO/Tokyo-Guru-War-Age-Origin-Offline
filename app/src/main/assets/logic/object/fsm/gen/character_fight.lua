character_fight = {
    {
        default = true,
        state = "AI_State_ClearUncontrolEvent",
        subFSMKey = "fight_attack",
        name = "Fight",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "BeRepel", HFSM._const_immediate_, false, }, to = "BeRepel"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "PlayBeAttackAni", HFSM._const_immediate_, false, }, to = "PlayBeAttackAni"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Transform", HFSM._const_immediate_, false, }, to = "Transform"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Throw", HFSM._const_immediate_, false, }, to = "Throw"},
            {condition = {HFSM._funcall_, AI_BeTauntCanChangeTarget, 0,}, to = "changeTauntTarget"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "chaos", HFSM._const_immediate_, true, }, to = "chaos"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "Fear", HFSM._const_immediate_, true, }, to = "fear"},
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
        state = "AI_State_Chaos",
        name = "chaos",
        subFSM = "character_chaos",
        transitions = {
            {condition = {HFSM._funcall_, AI_ChaosIsEnd, 0,}, to = "Fight"},
        }
    },

    {
        state = "AI_State_Fear",
        name = "fear",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "FinishFear", HFSM._const_immediate_, true, }, to = "Fight"},
        }
    },

}


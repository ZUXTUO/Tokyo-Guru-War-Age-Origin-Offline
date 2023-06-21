chown_monster = {
    {
        default = true,
        state = "AI_State_Idle",
        name = "Idle",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "EntityBeAttacked", HFSM._const_immediate_, true, }, to = "MoveToNextTarget"},
        }
    },

    {
        state = "AI_State_AIMonsterRandomEscape",
        name = "MoveToNextTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 2,HFSM._const_immediate_, true, HFSM._const_immediate_, true, }, to = "clear"},
        }
    },

    {
        state = "AI_State_Clear_BeAttackEvent",
        name = "clear",
        transitions = {
            {condition = {}, to = "Idle"},
        }
    },

}


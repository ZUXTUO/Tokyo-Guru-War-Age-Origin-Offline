charactor_continue_fight = {
    {
        default = true,
        state = "AI_State_FightStateAndLeaveClear",
        name = "fight",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_LostTarget, 0,}, to = "WaitSkillEnd"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_MonsterIsOutofActRange, 0,}, to = "Exit"},
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
            {condition = {HFSM._funcall_, AI_FindNextTarget, 0,}, to = "fight"},
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


actor_along_path_patrol_exit = {
    {
        default = true,
        state = "AI_Sate_ExitAndSetHomePosition",
        name = "setbornPosition",
        subFSM = "actor_along_path_patrol",
        transitions = {
            {condition = {HFSM._funcall_, AI_EnemyEnterWarningRange, 0,}, to = "warning"},
        }
    },

    {
        state = "AI_State_PlayWarningAction",
        name = "warning",
        transitions = {
            {condition = {HFSM._funcall_, AI_PlayWarningActionStandEnd, 0,}, to = "setbornPosition"},
        }
    },

}


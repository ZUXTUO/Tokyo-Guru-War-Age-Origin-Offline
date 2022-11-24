chown_monster_move_according_to_time = {
    {
        default = true,
        state = "AI_State_ClownInit",
        name = "Init",
        transitions = {
            {condition = {HFSM._funcall_, AI_ClownNeedMove, 0,}, to = "MoveToNextTarget"},
            {condition = {}, to = "Idle"},
        }
    },

    {
        state = "AI_Sate_ClownRandomMove",
        name = "MoveToNextTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_ClownRandomMoveIsEnd, 0,}, to = "Idle"},
        }
    },

    {
        state = "AI_State_ClownRandomStand",
        name = "Idle",
        transitions = {
            {condition = {HFSM._funcall_, AI_ClownRandomStandIsEnd, 0,}, to = "MoveToNextTarget"},
        }
    },

}


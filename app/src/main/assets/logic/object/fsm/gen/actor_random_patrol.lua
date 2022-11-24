actor_random_patrol = {
    {
        default = true,
        state = "AI_State_randomStand",
        name = "Stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_RandomStandIsEnd, 0,}, to = "Move"},
        }
    },

    {
        state = "AI_Sate_PatrolRandomMoveAroundBornPoint",
        name = "Move",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "Stand"},
        }
    },

}


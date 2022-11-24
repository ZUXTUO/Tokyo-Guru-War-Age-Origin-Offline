obstacle_roadblock = {
    {
        default = true,
        name = "step",
        transitions = {
            {condition = {}, to = "obstacle"},
        }
    },

    {
        state = "AI_State_ChangeToObstacle",
        name = "obstacle",
        transitions = {
            {condition = {}, to = "idle"},
        }
    },

    {
        name = "idle",
        transitions = {
        }
    },

}


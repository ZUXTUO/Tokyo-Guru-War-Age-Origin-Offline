ai_run_action = {
    {
        default = true,
        name = "step",
        transitions = {
            {condition = {}, to = "action"},
        }
    },

    {
        stateKey = "action_key",
        name = "action",
        transitions = {
            {condition = {}, to = "idle"},
        }
    },

    {
        state = "AI_State_CloseSelfAI",
        name = "idle",
        transitions = {
        }
    },

}


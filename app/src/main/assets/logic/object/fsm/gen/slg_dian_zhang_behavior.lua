slg_dian_zhang_behavior = {
    {
        default = true,
        name = "detectNexAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_SLGDianZhangFirstAction, 0,}, to = "idle"},
            {condition = {}, to = "tiancha"},
        }
    },

    {
        state = "AI_State_SLG_DianZhangIdle",
        name = "idle",
        transitions = {
            {condition = {HFSM._funcall_, AI_SLGDianZhangIdleIsEnd, 0,}, to = "tiancha"},
        }
    },

    {
        state = "AI_State_SLG_DianZhangTianCha",
        name = "tiancha",
        transitions = {
            {condition = {HFSM._funcall_, AI_SLGDianZhangTianChaIsEnd, 0,}, to = "idle"},
        }
    },

}


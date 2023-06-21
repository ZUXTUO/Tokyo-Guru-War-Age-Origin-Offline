droped_key = {
    {
        default = true,
        state = "AI_State_dropedKeyInit",
        name = "init",
        transitions = {
            {condition = {}, to = "waitInGroundTimeEnd"},
        }
    },

    {
        state = "AI_State_dropedKeyInGroundTime",
        name = "waitInGroundTimeEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "flyToUiIcon"},
        }
    },

    {
        state = "AI_State_dropedKeyFlyUiIcon",
        name = "flyToUiIcon",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "delSelf"},
        }
    },

    {
        name = "delSelf",
        transitions = {
        }
    },

}


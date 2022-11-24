roadblock_switch_func = {
    {
        default = true,
        state = "AI_State_roadblockSwitchInit",
        name = "init",
        transitions = {
            {condition = {}, to = "OnState"},
        }
    },

    {
        state = "AI_State_roadblockSwitchCanOperate",
        name = "OnState",
        transitions = {
            {condition = {HFSM._funcall_, AI_UseClickSwitchUI, 0,}, to = "switching"},
        }
    },

    {
        state = "AI_State_roadSwitchPlayOpen",
        name = "switching",
        transitions = {
            {condition = {HFSM._funcall_, AI_ControlObjectOpenEnd, 0,}, to = "OtherState"},
        }
    },

    {
        state = "AI_State_roadblockSwitchCanOperate",
        name = "OtherState",
        transitions = {
            {condition = {HFSM._funcall_, AI_UseClickSwitchUI, 0,}, to = "switching_two"},
        }
    },

    {
        state = "AI_State_roadblockSwitchPlayClose",
        name = "switching_two",
        transitions = {
            {condition = {HFSM._funcall_, AI_ControlObjectCloseEnd, 0,}, to = "OnState"},
        }
    },

}


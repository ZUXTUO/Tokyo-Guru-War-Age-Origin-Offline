fight_change_target_by_hatred_value = {
    {
        default = true,
        name = "fight",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_MaxHatredValueNotCurrentTarget, 0,}, to = "change"},
        }
    },

    {
        state = "AI_State_ChangeTargetToMaxHatredValueEntity",
        name = "change",
        transitions = {
            {condition = {}, to = "fight"},
        }
    },

}


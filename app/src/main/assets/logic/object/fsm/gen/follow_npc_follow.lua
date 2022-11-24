follow_npc_follow = {
    {
        default = true,
        name = "next",
        transitions = {
            {condition = {HFSM._not_, HFSM._funcall_, AI_FollowHeroOutOfCaptainAround, 0,}, to = "stand"},
            {condition = {}, to = "aroundToCaptainAround"},
        }
    },

    {
        state = "AI_State_Follow_Idle",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_FollowHeroOutOfCaptainAround, 0,}, to = "aroundToCaptainAround"},
        }
    },

    {
        state = "AI_State_Follow_NPC_Move_Captain_Around",
        name = "aroundToCaptainAround",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "stand"},
        }
    },

}


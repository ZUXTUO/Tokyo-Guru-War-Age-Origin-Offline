follow_hero = {
    {
        default = true,
        state = "AI_State_FollowHeroBeavior",
        name = "follow",
        subFSM = "character_fight",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsDead, 0,}, to = "detectDeadAction"},
            {condition = {HFSM._funcall_, AI_IsPause, 0,}, to = "checkInAir"},
        }
    },

    {
        name = "detectDeadAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_EntityInTheAir, 0,}, to = "entityDown"},
            {condition = {}, to = "Dead"},
        }
    },

    {
        state = "AI_State_EntityDropOnGround",
        name = "entityDown",
        transitions = {
            {condition = {HFSM._funcall_, AI_DropOnGroundComplete, 0,}, to = "Dead"},
        }
    },

    {
        state = "AI_State_Dead",
        name = "Dead",
        transitions = {
            {condition = {HFSM._not_, HFSM._funcall_, AI_IsDead, 0,}, to = "follow"},
        }
    },

    {
        name = "checkInAir",
        transitions = {
            {condition = {HFSM._funcall_, AI_EntityInTheAir, 0,}, to = "entityDown1"},
            {condition = {}, to = "Pause"},
        }
    },

    {
        state = "AI_State_EntityDropOnGround",
        name = "entityDown1",
        transitions = {
            {condition = {HFSM._funcall_, AI_DropOnGroundComplete, 0,}, to = "Pause"},
        }
    },

    {
        state = "AI_State_Pause",
        name = "Pause",
        transitions = {
            {condition = {HFSM._not_, HFSM._funcall_, AI_IsPause, 0,}, to = "clearResumeEvent"},
        }
    },

    {
        state = "AI_State_CleanResumeEvent",
        name = "clearResumeEvent",
        transitions = {
            {condition = {}, to = "follow"},
        }
    },

}


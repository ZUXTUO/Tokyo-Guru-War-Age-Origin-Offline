main_city_scene_virtual_hero = {
    {
        default = true,
        state = "AI_State_randomStand",
        name = "randomIdle",
        transitions = {
            {condition = {HFSM._funcall_, AI_RandomStandIsEnd, 0,}, to = "waitIdleEnd"},
        }
    },

    {
        name = "waitIdleEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_virtualHeroRandomMove, 0,}, to = "randomMove"},
            {condition = {}, to = "moveToNpc"},
        }
    },

    {
        state = "AI_Sate_PatrolRandomMove",
        name = "randomMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "randomIdle"},
        }
    },

    {
        state = "AI_State_MoveToRandomNpc",
        name = "moveToNpc",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "waitMoveToNpc"},
        }
    },

    {
        name = "waitMoveToNpc",
        transitions = {
            {condition = {HFSM._funcall_, AI_VirtualHeroRandomExit, 0,}, to = "dipacthExit"},
            {condition = {}, to = "randomIdle"},
        }
    },

    {
        state = "AI_State_fireVirtualHeroExitEvent",
        name = "dipacthExit",
        transitions = {
        }
    },

}


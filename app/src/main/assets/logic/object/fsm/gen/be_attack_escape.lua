be_attack_escape = {
    {
        default = true,
        state = "AI_State_StandTime",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_BeAttackedOnce, 0,}, to = "randomMove"},
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "randomwalk"},
        }
    },

    {
        state = "AI_Sate_PatrolRandomMoveAroundBornPoint",
        name = "randomMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "stand"},
        }
    },

    {
        state = "AI_Sate_PatrolRandomWalkAroundBornPoint",
        name = "randomwalk",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "stand"},
            {condition = {HFSM._funcall_, AI_BeAttackedOnce, 0,}, to = "randomMove"},
        }
    },

}


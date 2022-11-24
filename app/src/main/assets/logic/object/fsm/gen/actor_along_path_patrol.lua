actor_along_path_patrol = {
    {
        default = true,
        state = "AI_State_CleanNewPatrolPathEvent",
        name = "clean",
        transitions = {
            {condition = {HFSM._funcall_, AI_HasAValidPath, 0,}, to = "CalBeginPos"},
        }
    },

    {
        state = "AI_State_CalPatrolBeginPos",
        name = "CalBeginPos",
        transitions = {
            {condition = {}, to = "Move"},
        }
    },

    {
        state = "AI_Sate_PatrolAlongPathMove",
        name = "Move",
        transitions = {
            {condition = {HFSM._funcall_, AI_PatrolNeedStandTime, 0,}, to = "stand"},
            {condition = {HFSM._funcall_, AI_AlongPathEnd, 0,}, to = "Exit"},
            {condition = {HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "NEWPatrolPath", HFSM._const_immediate_, true, }, to = "resetMoveState"},
        }
    },

    {
        state = "AI_State_Idle",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_PatrolStandTimeEnd, 0,}, to = "Move"},
        }
    },

    {
        state = "AI_State_Idle",
        name = "Exit",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_IsReciveEvent, 2,HFSM._strparam_, "NEWPatrolPath", HFSM._const_immediate_, true, HFSM._funcall_, AI_IsNotMoveToPathEnd, 0,}, to = "resetMoveState"},
        }
    },

    {
        state = "AI_State_ResetAlongPathMove",
        name = "resetMoveState",
        transitions = {
            {condition = {}, to = "clean"},
        }
    },

}


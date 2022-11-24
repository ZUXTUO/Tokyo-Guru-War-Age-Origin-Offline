obstacle_gap_attacker = {
    {
        default = true,
        name = "wait",
        transitions = {
            {condition = {}, to = "setCanNotAttack"},
        }
    },

    {
        state = "AI_State_SetIsCanNotAttackAndStartPause",
        name = "setCanNotAttack",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "playerAttackBeginAni"},
        }
    },

    {
        state = "AI_State_ObstaclePlayAttackBeginAni",
        name = "playerAttackBeginAni",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_StateTimeIsEnd, 0,HFSM._funcall_, AI_ReciveSwitchOpen, 0,}, to = "changeCanBeAttackOrClose"},
        }
    },

    {
        name = "changeCanBeAttackOrClose",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsChangeCanBeAttack, 0,}, to = "cangeCanBeAttack"},
            {condition = {}, to = "playerEndAttackAni"},
        }
    },

    {
        state = "AI_State_ChangeCanBeAttack",
        name = "cangeCanBeAttack",
        transitions = {
        }
    },

    {
        state = "AI_State_ObstaclePlayAttackEndAni",
        name = "playerEndAttackAni",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "pauseAttack"},
        }
    },

    {
        state = "AI_State_ObataclePlayPauseAni",
        name = "pauseAttack",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_StateTimeIsEnd, 0,HFSM._funcall_, AI_ReciveSwitchClose, 0,}, to = "playerAttackBeginAni"},
        }
    },

}


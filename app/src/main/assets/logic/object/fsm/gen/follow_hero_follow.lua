follow_hero_follow = {
    {
        default = true,
        state = "AI_State_Move_Captain_Around",
        name = "Move2CaptainAround",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_CaptainIsNotRun, 0,HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "checkNeedRotate"},
        }
    },

    {
        name = "checkNeedRotate",
        transitions = {
            {condition = {HFSM._funcall_, AI_FollowHeroNeedRotateToCaptain, 0,}, to = "rotateToCaptain"},
            {condition = {}, to = "Idle"},
        }
    },

    {
        state = "AI_State_FollowRotateToCaptain",
        name = "rotateToCaptain",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "Idle"},
        }
    },

    {
        state = "AI_State_Follow_Idle",
        name = "Idle",
        transitions = {
            {condition = {HFSM._funcall_, AI_FollowCaptionUpdatePositionOrDir, 0,}, to = "randomWait"},
            {condition = {HFSM._funcall_, AI_HeroNeedAddHP, 0,}, to = "AddHP"},
        }
    },

    {
        state = "AI_StateMoveCaptainAroundDelay",
        name = "randomWait",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "Move2CaptainAround"},
        }
    },

    {
        state = "AI_State_ContinueUseAddHPSkill",
        name = "AddHP",
        transitions = {
            {condition = {HFSM._funcall_, AI_FollowCaptionUpdatePositionOrDir, 0,}, to = "Move2CaptainAround"},
            {condition = {HFSM._not_, HFSM._funcall_, AI_MyHPNotFull, 0,}, to = "Idle"},
        }
    },

}


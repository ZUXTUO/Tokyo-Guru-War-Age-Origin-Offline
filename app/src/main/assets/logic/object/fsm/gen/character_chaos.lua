character_chaos = {
    {
        default = true,
        name = "detectARandomTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_ChaosDetectARandomTarget, 0,}, to = "detectAttackOrChase"},
            {condition = {}, to = "randomMove"},
        }
    },

    {
        name = "detectAttackOrChase",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsTargetInAttackRange, 0,}, to = "SelectNextSkill"},
            {condition = {}, to = "moveAttackRange"},
        }
    },

    {
        state = "Fight_State_Follow_Select_Skill",
        name = "SelectNextSkill",
        transitions = {
            {condition = {HFSM._funcall_, AI_SelectSkillsucceed, 0,}, to = "Attack"},
        }
    },

    {
        state = "Fight_State_Attack",
        name = "Attack",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "continueAttackOrChangeTarget"},
        }
    },

    {
        name = "continueAttackOrChangeTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_UsedOnOrStageSkill, 0,}, to = "detectARandomTarget"},
            {condition = {}, to = "detectAttackOrChase"},
        }
    },

    {
        state = "Fight_State_MoveWithinAttackRange",
        name = "moveAttackRange",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_IsTargetInNearestAttackRange, 0,HFSM._and_, HFSM._funcall_, AI_IsTargetInAttackRange, 0,HFSM._funcall_, AI_MoveComplete, 0,}, to = "SelectNextSkill"},
        }
    },

    {
        state = "AI_State_ChaosRandomMove",
        name = "randomMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "detectARandomTarget"},
        }
    },

}


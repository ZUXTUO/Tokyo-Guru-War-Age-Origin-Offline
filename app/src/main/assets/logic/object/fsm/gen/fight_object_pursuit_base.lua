fight_object_pursuit_base = {
    {
        default = true,
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
            {condition = {HFSM._not_, HFSM._funcall_, AI_IsTargetInAttackRange, 0,}, to = "searchOtherOrChase"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_SelectSkillsucceed, 0,HFSM._funcall_, AI_LockUseSkillFreq, 0,}, to = "Attack"},
        }
    },

    {
        name = "searchOtherOrChase",
        transitions = {
            {condition = {HFSM._funcall_, AI_TargetOutOfAttackRangeAndEnterCheckOtherTargetRange, 0,}, to = "ChangeToNextTarget"},
            {condition = {}, to = "moveAttackRange"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToNextTarget",
        transitions = {
            {condition = {}, to = "detectAttackOrChase"},
        }
    },

    {
        state = "Fight_State_MoveWithinAttackRange",
        name = "moveAttackRange",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_IsTargetInNearestAttackRange, 0,HFSM._and_, HFSM._funcall_, AI_IsTargetInAttackRange, 0,HFSM._funcall_, AI_MoveComplete, 0,}, to = "SelectNextSkill"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_IsMonster, 0,HFSM._funcall_, AI_MoveComplete, 0,}, to = "randomSideMove"},
        }
    },

    {
        state = "Fight_State_RandomSideMove",
        name = "randomSideMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "moveAttackRange"},
        }
    },

    {
        state = "Fight_State_Attack",
        name = "Attack",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "skillend"},
        }
    },

    {
        name = "skillend",
        transitions = {
            {condition = {HFSM._funcall_, AI_NeedAttackMove, 0,}, to = "attackMove"},
            {condition = {}, to = "SelectNextSkill"},
        }
    },

    {
        state = "AI_State_AttackMove",
        name = "attackMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "detectAttackMoveNext"},
        }
    },

    {
        name = "detectAttackMoveNext",
        transitions = {
            {condition = {HFSM._funcall_, AI_AttackMoveContinue, 0,}, to = "attackMove"},
            {condition = {HFSM._not_, HFSM._funcall_, AI_IsTargetInAttackRange, 0,}, to = "moveAttackRange"},
            {condition = {}, to = "rotateToTarget"},
        }
    },

    {
        state = "AI_State_RotateToTarget",
        name = "rotateToTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "SelectNextSkill"},
        }
    },

}


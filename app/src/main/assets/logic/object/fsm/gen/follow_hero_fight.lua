follow_hero_fight = {
    {
        default = true,
        state = "Fight_State_Follow_Select_Skill",
        name = "SelectNextSkill",
        transitions = {
            {condition = {HFSM._and_, HFSM._not_, HFSM._funcall_, AI_TargetHPIsToLow, 0,HFSM._funcall_, AI_FollowHeroHaveAnotherBetterAttackTarget, 0,}, to = "ChangeToNextTarget"},
            {condition = {HFSM._or_, HFSM._not_, HFSM._funcall_, AI_IsTargetInAttackRange, 0,HFSM._funcall_, AI_HeroStandToOtherHeroIsTooClosed, 0,}, to = "moveAttackRange"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_SelectSkillsucceed, 0,HFSM._funcall_, AI_LockUseSkillFreq, 0,}, to = "Attack"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToNextTarget",
        transitions = {
            {condition = {}, to = "moveAttackRange"},
        }
    },

    {
        state = "Fight_State_FollowHeroMoveToAttackPosition",
        name = "moveAttackRange",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "SelectNextSkill"},
        }
    },

    {
        state = "Fight_State_Attack",
        name = "Attack",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_CancelCurrentSkill, 0,}, to = "SelectNextSkill"},
        }
    },

}


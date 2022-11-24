follow_hero_behavior = {
    {
        default = true,
        name = "follow",
        subFSM = "follow_hero_follow",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_FollowHeroCanEnterFight, 0,HFSM._or_, HFSM._funcall_, AI_captainIsAttacking, 0,HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "fight"},
        }
    },

    {
        state = "AI_State_Fight",
        subFSMKey = "follow_hero_fight",
        name = "fight",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_FollowHeroIsOutOfScreenRange, 0,}, to = "follow"},
            {condition = {HFSM._funcall_, AI_TargetIsDead, 0,}, to = "WaitSkillEnd"},
        }
    },

    {
        name = "WaitSkillEnd",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "Next"},
        }
    },

    {
        name = "Next",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "fight"},
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "CloseSkill"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "CloseSkill",
        transitions = {
            {condition = {}, to = "follow"},
        }
    },

}


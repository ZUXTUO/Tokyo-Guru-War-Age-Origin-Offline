follow_npc_behavior = {
    {
        default = true,
        state = "AI_State_Follow_NPC_Init",
        name = "init",
        transitions = {
            {condition = {}, to = "patrol"},
        }
    },

    {
        name = "patrol",
        subFSM = "follow_npc_follow",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_FollowHeroCanEnterFight, 0,HFSM._or_, HFSM._funcall_, AI_captainIsAttacking, 0,HFSM._funcall_, AI_HeroDetectedMonster, 0,}, to = "Fight"},
        }
    },

    {
        name = "Fight",
        subFSM = "charactor_continue_fight",
        transitions = {
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentSkillIsEnd, 0,HFSM._funcall_, AI_FollowHeroIsOutOfScreenRange, 0,}, to = "patrol"},
            {condition = {HFSM._funcall_, AI_SubFSMIsEnd, 0,}, to = "patrol"},
        }
    },

}


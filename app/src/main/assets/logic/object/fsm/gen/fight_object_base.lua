fight_object_base = {
    {
        default = true,
        state = "AI_State_SelectSkillByEnableAndAttackRange",
        name = "checkSkill",
        transitions = {
            {condition = {HFSM._funcall_, AI_SelectSkillsucceed, 0,}, to = "Attack"},
            {condition = {}, to = "Exit"},
        }
    },

    {
        state = "Fight_State_Attack",
        name = "Attack",
        transitions = {
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "checkSkill"},
        }
    },

    {
        state = "AI_State_FightExit",
        name = "Exit",
        transitions = {
        }
    },

}


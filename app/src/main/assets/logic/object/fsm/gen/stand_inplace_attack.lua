stand_inplace_attack = {
    {
        default = true,
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
            {condition = {HFSM._funcall_, AI_CurrentSkillIsEnd, 0,}, to = "SelectNextSkill"},
        }
    },

}


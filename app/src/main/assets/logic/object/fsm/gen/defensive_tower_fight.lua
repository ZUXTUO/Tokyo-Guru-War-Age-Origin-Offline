defensive_tower_fight = {
    {
        default = true,
        name = "checkTarget",
        transitions = {
            {condition = {HFSM._funcall_, AI_TownerFindATarget, 0,}, to = "setTarget"},
        }
    },

    {
        state = "AI_State_MonsterFight",
        name = "setTarget",
        transitions = {
            {condition = {}, to = "SelectNextSkill"},
        }
    },

    {
        state = "Fight_State_Follow_Select_Skill",
        name = "SelectNextSkill",
        transitions = {
            {condition = {HFSM._funcall_, AI_TownerLostTarget, 0,}, to = "DetectFightEndAction"},
            {condition = {HFSM._funcall_, AI_TownerIsAttackMonsterAndHasEnemyHeroAttackMyHero, 0,}, to = "ChangeToAttackThisEnemyHero"},
            {condition = {HFSM._funcall_, AI_SelectSkillsucceed, 0,}, to = "Attack"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "DetectFightEndAction",
        transitions = {
            {condition = {}, to = "end"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "end",
        transitions = {
            {condition = {}, to = "checkTarget"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToAttackThisEnemyHero",
        transitions = {
            {condition = {}, to = "SelectNextSkill"},
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


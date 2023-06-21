main_hero_fight = {
    {
        default = true,
        name = "CheckIsTaunt",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsTaunting, 0,}, to = "tauntFight"},
            {condition = {}, to = "heroFight"},
        }
    },

    {
        state = "AI_State_MainHeroEnterTaunt",
        name = "tauntFight",
        subFSM = "fight_object_pursuit_base",
        transitions = {
            {condition = {HFSM._funcall_, AI_TauntIsEnd, 0,}, to = "heroFight"},
        }
    },

    {
        state = "AI_State_MainHeroFight",
        name = "heroFight",
        transitions = {
            {condition = {HFSM._funcall_, AI_IsTaunting, 0,}, to = "tauntFight"},
        }
    },

}


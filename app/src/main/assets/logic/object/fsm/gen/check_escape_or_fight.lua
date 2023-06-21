check_escape_or_fight = {
    {
        default = true,
        state = "AI_State_EscapeCharacterInit",
        name = "nextAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_escapeCharactorNotNeedEscape, 0,}, to = "FightBehavior"},
            {condition = {}, to = "escapeBehavior"},
        }
    },

    {
        name = "FightBehavior",
        subFSM = "escape_character_behavior",
        transitions = {
            {condition = {HFSM._funcall_, AI_CheckWhetherReturnToEscape, 0,}, to = "SwitchToEscape"},
        }
    },

    {
        state = "AI_State_SwitchToEscape",
        name = "SwitchToEscape",
        transitions = {
            {condition = {}, to = "escapeBehavior"},
        }
    },

    {
        name = "escapeBehavior",
        subFSM = "escape_character_behavior",
        transitions = {
            {condition = {HFSM._funcall_, AI_CheckWhetherEnterFightAction, 0,}, to = "SwitchToFight"},
        }
    },

    {
        state = "AI_State_SwitchToFight",
        name = "SwitchToFight",
        transitions = {
            {condition = {}, to = "FightBehavior"},
        }
    },

}


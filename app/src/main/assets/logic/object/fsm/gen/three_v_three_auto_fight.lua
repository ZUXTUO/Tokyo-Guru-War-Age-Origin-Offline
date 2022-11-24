three_v_three_auto_fight = {
    {
        default = true,
        subFSMKey = "ai_hero_fight_base",
        name = "fight_behavior",
        transitions = {
            {condition = {HFSM._funcall_, AI_AIHeroExecAddHPAction, 0,}, to = "addhp"},
            {condition = {HFSM._funcall_, AI_AIHeroExecEscapeAction, 0,}, to = "detectNexAction"},
            {condition = {HFSM._funcall_, AI_HaveMoreClosedTargetThanCurrentTarget, 0,}, to = "ChangeToNextTarget"},
        }
    },

    {
        state = "AI_State_UseAddHPSkillOnce",
        name = "addhp",
        transitions = {
            {condition = {}, to = "fight_behavior"},
        }
    },

    {
        name = "detectNexAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_OtherSideHasAttackToMyBase, 0,}, to = "escape"},
            {condition = {}, to = "RetrunMyBase"},
        }
    },

    {
        state = "AI_State_AIHeroRandomEscape",
        name = "escape",
        transitions = {
            {condition = {HFSM._or_, HFSM._funcall_, AI_MoveComplete, 0,HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "fight_behavior"},
        }
    },

    {
        state = "AI_State_HeroReturnMyBase",
        name = "RetrunMyBase",
        transitions = {
            {condition = {HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "fight_behavior"},
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "stand"},
        }
    },

    {
        state = "AI_State_EscapWaitHPRestoreFull",
        name = "stand",
        transitions = {
            {condition = {HFSM._funcall_, AI_AIHeroEscapeReturnAttack, 0,}, to = "fight_behavior"},
        }
    },

    {
        state = "AI_State_ChangeToNextTarget",
        name = "ChangeToNextTarget",
        transitions = {
            {condition = {}, to = "fight_behavior"},
        }
    },

}


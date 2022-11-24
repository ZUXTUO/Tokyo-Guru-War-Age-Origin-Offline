monster_behavior = {
    {
        default = true,
        state = "AI_State_PatrolState",
        name = "patrol",
        subFSM = "character_fight",
        transitions = {
            {condition = {HFSM._and_, HFSM._not_, HFSM._funcall_, AI_IsBeControlOrOutOfControlState, 0,HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "Fight"},
        }
    },

    {
        state = "AI_State_MonsterFightBehavior",
        name = "Fight",
        subFSM = "monster_fight",
        transitions = {
            {condition = {HFSM._funcall_, AI_SubFSMIsEnd, 0,}, to = "DetectFightEndAction"},
            {condition = {HFSM._and_, HFSM._funcall_, AI_CurrentStateCanInterrupt, 0,HFSM._funcall_, AI_OverMaxBeAttackedInterval, 0,}, to = "DetectFightEndAction"},
        }
    },

    {
        state = "AI_State_LeaveFightState",
        name = "DetectFightEndAction",
        transitions = {
            {condition = {HFSM._funcall_, AI_NeedToBack2Home, 0,}, to = "Back2Home"},
            {condition = {}, to = "patrol"},
        }
    },

    {
        state = "AI_State_Back2Home",
        name = "Back2Home",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 0,}, to = "patrol"},
        }
    },

}


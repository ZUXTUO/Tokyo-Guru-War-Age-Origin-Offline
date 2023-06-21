be_escort_character_behavior = {
    {
        default = true,
        state = "AI_State_beEscortCharacterInit",
        name = "beEscortInit",
        transitions = {
            {condition = {}, to = "moveToTargetPoint"},
        }
    },

    {
        state = "AI_State_ClearDangerousEvent",
        name = "moveToTargetPoint",
        subFSM = "actor_along_path_patrol_exit",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "fightState"},
            {condition = {HFSM._funcall_, AI_BeEscortCharactorFeeldangerous, 0,}, to = "prepareFight"},
        }
    },

    {
        state = "AI_Sate_EnterAndSetHomePosition",
        subFSMKey = "fight_key",
        name = "fightState",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "fight_exit_check_key", }, to = "detectWhetherWait"},
            {condition = {HFSM._funcall_, AI_BeEscortFeelDangrousEnd, 0,}, to = "moveToTargetPoint"},
        }
    },

    {
        name = "detectWhetherWait",
        transitions = {
            {condition = {HFSM._funcall_, AI_BeEscortCharactorNeedFightEndWati, 0,}, to = "wait"},
            {condition = {}, to = "moveToTargetPoint"},
        }
    },

    {
        name = "wait",
        transitions = {
            {condition = {HFSM._funcall_, AI_StateTimeIsEnd, 0,}, to = "moveToTargetPoint"},
        }
    },

    {
        state = "AI_State_Patrol",
        name = "prepareFight",
        transitions = {
            {condition = {HFSM._funcall_, AI_BeEscortEnterFightState, 0,}, to = "fightState"},
            {condition = {HFSM._funcall_, AI_BeEscortFeelDangrousEnd, 0,}, to = "moveToTargetPoint"},
        }
    },

}


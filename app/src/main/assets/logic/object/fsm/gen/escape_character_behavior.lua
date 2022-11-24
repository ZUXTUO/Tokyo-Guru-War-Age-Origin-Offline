escape_character_behavior = {
    {
        default = true,
        name = "actionDetect",
        transitions = {
            {condition = {HFSM._funcall_, AI_escapeCharactorNotNeedEscape, 0,}, to = "checkEnemy"},
            {condition = {}, to = "escape"},
        }
    },

    {
        name = "checkEnemy",
        subFSM = "actor_stand_patrol",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "Fight"},
        }
    },

    {
        name = "Fight",
        subFSM = "charactor_continue_fight",
        transitions = {
            {condition = {HFSM._funcall_, AI_SubFSMIsEnd, 0,}, to = "checkEnemy"},
        }
    },

    {
        name = "escape",
        subFSM = "actor_along_path_patrol_exit",
        transitions = {
            {condition = {HFSM._funcall_, AI_Key, 1,HFSM._strparam_, "con_check_enemy_key", }, to = "Fight"},
        }
    },

}


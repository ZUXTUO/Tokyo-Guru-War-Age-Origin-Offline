beginning_move_along_face_direction = {
    {
        default = true,
        state = "AI_State_MoveAlongFaceDirection",
        name = "directionMove",
        transitions = {
            {condition = {HFSM._funcall_, AI_MoveComplete, 1,HFSM._const_immediate_, true, }, to = "changeNextAI"},
        }
    },

    {
        state = "AI_State_ChangeNextAI",
        name = "changeNextAI",
        transitions = {
        }
    },

}


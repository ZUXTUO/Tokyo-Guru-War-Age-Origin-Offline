--[[
region monster_normal_skill_data.lua
date: 2015-9-21
time: 19:35:6
author: Nation
编号3000-3999
]]
g_MosterNormalSkillData = {
    [3000] = { name="近战兵普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=302, bufflv=1, key=1 }
        },
    },
    [3001] = { name="机枪兵普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=301, bufflv=1, key=1 }
        },
    },
    [3002] = { name="小怪305普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=303, bufflv=1, key=1 }
        },
    },
    [3003] = { name="小怪307普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=304, bufflv=1, key=1 }
        },
    },
    [3004] = { name="小怪312普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=305, bufflv=1, key=1 }
        },
    },
    [3005] = { name="神代利世BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=103, bufflv=1 }
        },
    },
    [3006] = { name="神代利世BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=103, bufflv=2 }
        },
    },
    [3007] = { name="神代利世BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=103, bufflv=3 }
        },
    },
    [3008] = { name="西尾锦BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=102, bufflv=1 }
        },
    },
    [3009] = { name="西尾锦BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=102, bufflv=2 }
        },
    },
    [3010] = { name="西尾锦BOSS普攻3", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=102, bufflv=3 }
        },
    },
    [3011] = { name="雾岛董香BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=101, bufflv=1 }
        },
    },
    [3012] = { name="雾岛董香BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=101, bufflv=2 }
        },
    },
    [3013] = { name="雾岛董香BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=101, bufflv=3 }
        },
    },
    [3014] = { name="平子丈BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=119, bufflv=1 }
        },
    },
    [3015] = { name="平子丈BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=119, bufflv=2 }
        },
    },
    [3016] = { name="平子丈BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=119, bufflv=3 }
        },
    },
    [3017] = { name="月山习BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=108, bufflv=1 }
        },
    },
    [3018] = { name="月山习BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=108, bufflv=2 }
        },
    },
    [3019] = { name="月山习BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=108, bufflv=3 }
        },
    },
    [3020] = { name="亚门钢太郎BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=106, bufflv=1 }
        },
    },
    [3021] = { name="亚门钢太郎BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=106, bufflv=2 }
        },
    },
    [3022] = { name="亚门钢太郎BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=106, bufflv=3 }
        },
    },
    [3023] = { name="杰森BOSS普攻1", needtarget=0, combo=1, condition=24,
        effect = {
            [1] = { targettype=0, buffid=105, bufflv=1 }
        },
    },
    [3024] = { name="杰森BOSS普攻2", needtarget=0, combo=1, condition=24,
        effect = {
            [1] = { targettype=0, buffid=105, bufflv=2 }
        },
    },
    [3025] = { name="杰森BOSS普攻3", needtarget=0, combo=0, condition=24,
        effect = {
            [1] = { targettype=0, buffid=105, bufflv=3 }
        },
    },
    [3026] = { name="铃屋什造BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=138, bufflv=1 }
        },
    },
    [3027] = { name="铃屋什造BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=138, bufflv=2 }
        },
    },
    [3028] = { name="铃屋什造BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=138, bufflv=3 }
        },
    },
    [3029] = { name="独眼之枭BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=139, bufflv=1 }
        },
    },
    [3030] = { name="独眼之枭BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=139, bufflv=2 }
        },
    },
    [3031] = { name="独眼之枭BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=139, bufflv=3 }
        },
    },
    [3032] = { name="金木研BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=100, bufflv=1, key=1 }
        },
    },
    [3033] = { name="金木研BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=100, bufflv=2, key=1 }
        },
    },
    [3034] = { name="金木研BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=100, bufflv=3, key=1 }
        },
    },
    [3035] = { name="真户吴绪BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=107, bufflv=1 }
        },
    },
    [3036] = { name="真户吴绪BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=107, bufflv=2 }
        },
    },
    [3037] = { name="真户吴绪BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=107, bufflv=3 }
        },
    },
    [3038] = { name="笛口雏实BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=111, bufflv=1 }
        },
    },
    [3039] = { name="笛口雏实BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=111, bufflv=2 }
        },
    },
    [3040] = { name="笛口雏实BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=111, bufflv=3 }
        },
    },
    [3041] = { name="呗BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=140, bufflv=1 }
        },
    },
    [3042] = { name="呗BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=140, bufflv=2 }
        },
    },
    [3043] = { name="呗BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=140, bufflv=3 }
        },
    },
    [3044] = { name="太郎BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=1 }
        },
    },
    [3045] = { name="太郎BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=2 }
        },
    },
    [3046] = { name="太郎BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=3 }
        },
    },
    [3047] = { name="四方莲示BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=141, bufflv=1 }
        },
    },
    [3048] = { name="四方莲示BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=141, bufflv=2 }
        },
    },
    [3049] = { name="四方莲示BOSS普攻3", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=141, bufflv=3 }
        },
    },
    [3050] = { name="万丈数一BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=142, bufflv=1 }
        },
    },
    [3051] = { name="万丈数一BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=142, bufflv=2 }
        },
    },
    [3052] = { name="万丈数一BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=142, bufflv=3 }
        },
    },
    [3053] = { name="雾岛绚都BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=143, bufflv=1 }
        },
    },
    [3054] = { name="雾岛绚都BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=143, bufflv=2 }
        },
    },
    [3055] = { name="雾岛绚都BOSS普攻3", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=143, bufflv=3 }
        },
    },
    [3056] = { name="瓶兄BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=117, bufflv=1 }
        },
    },
    [3057] = { name="瓶兄BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=117, bufflv=2 }
        },
    },
    [3058] = { name="瓶兄BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=117, bufflv=3 }
        },
    },
    [3059] = { name="瓶弟BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=136, bufflv=1 }
        },
    },
    [3060] = { name="瓶弟BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=136, bufflv=2 }
        },
    },
    [3061] = { name="瓶弟BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=136, bufflv=3 }
        },
    },
    [3062] = { name="野吕BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=131, bufflv=1 }
        },
    },
    [3063] = { name="野吕BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=131, bufflv=2 }
        },
    },
    [3064] = { name="野吕BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=131, bufflv=3 }
        },
    },
    [3065] = { name="篠原幸纪BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=118, bufflv=1 }
        },
    },
    [3066] = { name="篠原幸纪BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=118, bufflv=2 }
        },
    },
    [3067] = { name="篠原幸纪BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=118, bufflv=3 }
        },
    },
    [3068] = { name="黑磐岩BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=120, bufflv=1 }
        },
    },
    [3069] = { name="黑磐岩BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=120, bufflv=2 }
        },
    },
    [3070] = { name="黑磐岩BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=120, bufflv=3 }
        },
    },
    [3071] = { name="安久黑奈BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=134, bufflv=1 }
        },
    },
    [3072] = { name="安久黑奈BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=134, bufflv=2 }
        },
    },
    [3073] = { name="安久黑奈BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=134, bufflv=3 }
        },
    },
    [3074] = { name="安久奈白BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=129, bufflv=1 }
        },
    },
    [3075] = { name="安久奈白BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=129, bufflv=2 }
        },
    },
    [3076] = { name="安久奈白BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=129, bufflv=3 }
        },
    },
    [3077] = { name="纳基BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=144, bufflv=1 }
        },
    },
    [3078] = { name="纳基BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=144, bufflv=2 }
        },
    },
    [3079] = { name="纳基BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=144, bufflv=3 }
        },
    },
    [3080] = { name="多多良BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=115, bufflv=1 }
        },
    },
    [3081] = { name="多多良BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=115, bufflv=2 }
        },
    },
    [3082] = { name="多多良BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=115, bufflv=3 }
        },
    },
    [3083] = { name="御坂BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=116, bufflv=1 }
        },
    },
    [3084] = { name="御坂BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=116, bufflv=2 }
        },
    },
    [3085] = { name="御坂BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=116, bufflv=3 }
        },
    },
    [3086] = { name="真户晓BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=127, bufflv=1 }
        },
    },
    [3087] = { name="真户晓BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=127, bufflv=2 }
        },
    },
    [3088] = { name="真户晓BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=127, bufflv=3 }
        },
    },
    [3089] = { name="泷泽政道BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=122, bufflv=1 }
        },
    },
    [3090] = { name="泷泽政道BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=122, bufflv=2 }
        },
    },
    [3091] = { name="泷泽政道BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=122, bufflv=3 }
        },
    },
    [3092] = { name="法寺项介BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=121, bufflv=1 }
        },
    },
    [3093] = { name="法寺项介BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=121, bufflv=2 }
        },
    },
    [3094] = { name="法寺项介BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=121, bufflv=3 }
        },
    },
    [3095] = { name="神代叉荣BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=124, bufflv=1 }
        },
    },
    [3096] = { name="神代叉荣BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=124, bufflv=2 }
        },
    },
    [3097] = { name="神代叉荣BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=124, bufflv=3 }
        },
    },
    [3098] = { name="蜈蚣金木BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=109, bufflv=1 }
        },
    },
    [3099] = { name="蜈蚣金木BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=109, bufflv=2 }
        },
    },
    [3100] = { name="蜈蚣金木BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=109, bufflv=3 }
        },
    },
    [3101] = { name="五里美乡BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=128, bufflv=1 }
        },
    },
    [3102] = { name="五里美乡BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=128, bufflv=2 }
        },
    },
    [3103] = { name="五里美乡BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=128, bufflv=3 }
        },
    },
    [3104] = { name="田中丸望元BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=126, bufflv=1 }
        },
    },
    [3105] = { name="田中丸望元BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=126, bufflv=2 }
        },
    },
    [3106] = { name="田中丸望元BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=126, bufflv=3 }
        },
    },
    [3107] = { name="钵川忠BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=130, bufflv=1 }
        },
    },
    [3108] = { name="钵川忠BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=130, bufflv=2 }
        },
    },
    [3109] = { name="钵川忠BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=130, bufflv=3 }
        },
    },
    [3110] = { name="宇井郡BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=132, bufflv=1 }
        },
    },
    [3111] = { name="宇井郡BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=132, bufflv=2 }
        },
    },
    [3112] = { name="宇井郡BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=132, bufflv=3 }
        },
    },
    [3113] = { name="有马贵将BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=123, bufflv=1 }
        },
    },
    [3114] = { name="有马贵将BOSS普攻2", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=123, bufflv=2 }
        },
    },
    [3115] = { name="有马贵将BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=123, bufflv=3 }
        },
    },
    [3116] = { name="喰种小兵327普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=306, bufflv=1 }
        },
    },
    [3117] = { name="搜查官小兵309普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=307, bufflv=1 }
        },
    },
    [3118] = { name="搜查官小兵310普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=308, bufflv=1 }
        },
    },
    -------------------------------------------------
    [3119] = { name="搜查官小兵302_1普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=309, bufflv=1 }
        },
    },
    [3120] = { name="搜查官小兵302_2普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=310, bufflv=1 }
        },
    },
    [3121] = { name="喰种小兵313普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=311, bufflv=1 }
        },
    },
    [3122] = { name="喰种小兵314普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=312, bufflv=1 }
        },
    },
    [3123] = { name="喰种小兵303普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=313, bufflv=1 }
        },
    },
    [3124] = { name="喰种小兵304普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=314, bufflv=1 }
        },
    },
    [3125] = { name="喰种小兵306普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=315, bufflv=1 }
        },
    },
    [3126] = { name="喰种小兵308普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=316, bufflv=1 }
        },
    },
    [3127] = { name="喰种小兵316普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=317, bufflv=1 }
        },
    },
    [3128] = { name="喰种小兵311普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=318, bufflv=1 }
        },
    },
    [3129] = { name="喰种小兵315普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=319, bufflv=1 }
        },
    },
    [3130] = { name="喰种小兵309普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=320, bufflv=1 }
        },
    },
    [3131] = { name="喰种小兵317普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=321, bufflv=1 }
        },
    },
    [3132] = { name="喰种小兵322普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=322, bufflv=1 }
        },
    },
    [3133] = { name="喰种小兵329普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=323, bufflv=1 }
        },
    },
    [3134] = { name="搜查官小兵301_01普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=324, bufflv=1 }
        },
    },
    [3135] = { name="搜查官小兵301_02普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=325, bufflv=1 }
        },
    },
    [3136] = { name="搜查官小兵301_03普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=326, bufflv=1 }
        },
    },
    [3137] = { name="搜查官小兵301_04普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=327, bufflv=1 }
        },
    },
    [3138] = { name="搜查官小兵301_05普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=328, bufflv=1 }
        },
    },
    [3139] = { name="搜查官小兵301_06普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=329, bufflv=1 }
        },
    },
    [3140] = { name="搜查官小兵301_07普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=330, bufflv=1 }
        },
    },
    [3141] = { name="喰种小兵310普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=331, bufflv=1 }
        },
    },
    [3142] = { name="不杀之枭BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=110, bufflv=1 }
        },
    },
    [3143] = { name="不杀之枭BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=110, bufflv=2 }
        },
    },
    [3144] = { name="不杀之枭BOSS普攻3", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=110, bufflv=3 }
        },
    },
    [3145] = { name="喰种小兵318普攻", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=332, bufflv=1 }
        },
    },
    [3146] = { name="喰种小兵328普攻", needtarget=0, combo=0, 
        effect = {
            [1] = { targettype=0, buffid=333, bufflv=1 }
        },
    },
    [3147] = { name="笛口凉子BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=112, bufflv=1 }
        },
    },
    [3148] = { name="笛口凉子BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=112, bufflv=2 }
        },
    },
    [3149] = { name="笛口凉子BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=112, bufflv=3 }
        },
    },
    [3150] = { name="楠木遥人BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=145, bufflv=1 }
        },
    },
    [3151] = { name="楠木遥人BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=145, bufflv=2 }
        },
    },
    [3152] = { name="楠木遥人BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=145, bufflv=3 }
        },
    },
    [3153] = { name="社团BOSS川村猛普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=334, bufflv=1 }
        },
    },
    [3154] = { name="社团BOSS川村猛普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=334, bufflv=2 }
        },
    },
    [3155] = { name="社团BOSS川村猛普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=334, bufflv=3 }
        },
    },
    [3156] = { name="背包金木研BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=146, bufflv=1 }
        },
    },
    [3157] = { name="背包金木研BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=146, bufflv=2 }
        },
    },
    [3158] = { name="背包金木研BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=146, bufflv=3 }
        },
    },
    [3159] = { name="白发金木研BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=147, bufflv=1 }
        },
    },
    [3160] = { name="白发金木研BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=147, bufflv=2 }
        },
    },
    [3161] = { name="白发金木研BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=147, bufflv=3 }
        },
    },
    [3162] = { name="芳村功善BOSS普攻1", needtarget=0, combo=1, 
        effect = {
            [1] = { targettype=0, buffid=337, bufflv=1 }
        },
    },
    [3163] = { name="芳村功善BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=337, bufflv=2 }
        },
    },
    [3164] = { name="芳村功善BOSS普攻3", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=337, bufflv=3 }
        },
    },
    [3165] = { name="喰种小兵301a普攻", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=338, bufflv=1 }
        },
    },
    [3166] = { name="金木研BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=100, bufflv=4, key=1 }
        },
    },
    [3167] = { name="金木研BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=100, bufflv=5, key=1 }
        },
    },
    [3168] = { name="笛口雏实BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=111, bufflv=4 }
        },
    },
    [3169] = { name="笛口雏实BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=111, bufflv=5 }
        },
    },
    [3170] = { name="西尾锦BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=102, bufflv=4 }
        },
    },
    [3171] = { name="西尾锦BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=102, bufflv=5 }
        },
    },
    [3172] = { name="雾岛董香BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=101, bufflv=4 }
        },
    },
    [3173] = { name="雾岛董香BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=101, bufflv=5 }
        },
    },
    [3174] = { name="四方莲示BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=141, bufflv=4 }
        },
    },
    [3175] = { name="四方莲示BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=141, bufflv=5 }
        },
    },
    [3176] = { name="铃屋什造BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=138, bufflv=4 }
        },
    },
    [3177] = { name="铃屋什造BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=138, bufflv=5 }
        },
    },
    [3178] = { name="雾岛绚都BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=143, bufflv=4 }
        },
    },
    [3179] = { name="雾岛绚都BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=143, bufflv=5 }
        },
    },
    [3180] = { name="杰森 暴走BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=148, bufflv=1 }
        },
    },
    [3181] = { name="杰森 暴走BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=148, bufflv=2 }
        },
    },
    [3182] = { name="杰森 暴走BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=148, bufflv=3 }
        },
    },
    [3183] = { name="杰森 暴走BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=148, bufflv=4 }
        },
    },
    [3184] = { name="杰森 暴走BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=148, bufflv=5 }
        },
    },
    [3185] = { name="安久奈白BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=129, bufflv=4 }
        },
    },
    [3186] = { name="安久奈白BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=129, bufflv=5 }
        },
    },
    [3187] = { name="亚门钢太郎BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=106, bufflv=4 }
        },
    },
    [3188] = { name="亚门钢太郎BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=106, bufflv=5 }
        },
    },
    [3189] = { name="神代利世BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=103, bufflv=4 }
        },
    }, 
    [3190] = { name="神代利世BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=103, bufflv=5 }
        },
    },
    [3191] = { name="平子丈BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=119, bufflv=4 }
        },
    },
    [3192] = { name="平子丈BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=119, bufflv=5 }
        },
    },
    [3193] = { name="五里美乡BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=128, bufflv=4 }
        },
    },
    [3194] = { name="五里美乡BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=128, bufflv=5 }
        },
    },
    [3195] = { name="白发金木研BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=147, bufflv=4 }
        },
    },
    [3196] = { name="白发金木研BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=147, bufflv=5 }
        },
    },
    [3197] = { name="真户晓BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=127, bufflv=4 }
        },
    },
    [3198] = { name="真户晓BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=127, bufflv=5 }
        },
    },
    [3199] = { name="万丈数一BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=142, bufflv=4 }
        },
    },
    [3200] = { name="万丈数一BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=142, bufflv=5 }
        },
    },
    [3201] = { name="笛口凉子BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=112, bufflv=4 }
        },
    },
    [3202] = { name="笛口凉子BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=112, bufflv=5 }
        },
    },
    [3203] = { name="纳基BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=144, bufflv=4 }
        },
    },
    [3204] = { name="纳基BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=144, bufflv=5 }
        },
    },
    [3205] = { name="宇井郡BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=132, bufflv=4 }
        },
    },
    [3206] = { name="宇井郡BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=132, bufflv=5 }
        },
    },
    [3207] = { name="瓶弟BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=136, bufflv=4 }
        },
    },
    [3208] = { name="瓶弟BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=136, bufflv=5 }
        },
    },
    [3209] = { name="泷泽政道BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=122, bufflv=4 }
        },
    },
    [3210] = { name="泷泽政道BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=122, bufflv=5 }
        },
    },
    [3211] = { name="太郎BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=4 }
        },
    },
    [3212] = { name="太郎BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=5 }
        },
    },
    [3213] = { name="村松希惠BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=1 }
        },
    },
    [3214] = { name="村松希惠BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=2 }
        },
    },
    [3215] = { name="村松希惠BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=3 }
        },
    },
    [3216] = { name="村松希惠BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=4 }
        },
    },
    [3217] = { name="村松希惠BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=133, bufflv=5 }
        },
    },
    [3218] = { name="精英怪h501（枪盾）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=339, bufflv=1 }
        },
    },
    [3219] = { name="精英怪h502（翅膀）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=340, bufflv=1 }
        },
    },
    [3220] = { name="精英怪s501（大手单赫子）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=341, bufflv=1 }
        },
    },
    [3221] = { name="精英怪s502（长臂两赫子）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=342, bufflv=1 }
        },
    },
    [3222] = { name="精英怪s503（大胖子）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=343, bufflv=1 }
        },
    },
    [3223] = { name="精英怪s504（萝莉）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=344, bufflv=1 }
        },
    },
    [3224] = { name="小兵-近战CCG普攻h401", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=345, bufflv=1 }
        },
    },
    [3225] = { name="小兵-远程CCG普攻h402", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=346, bufflv=1 }
        },
    },
    [3226] = { name="小兵-远程喰种普攻s401", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=347, bufflv=1 }
        },
    },
    [3227] = { name="小兵-近战喰种普攻s402", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=348, bufflv=1 }
        },
    },
    [3228] = { name="背包金木研BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=146, bufflv=4 }
        },
    },
    [3229] = { name="背包金木研BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=146, bufflv=5 }
        },
    },
    [3230] = { name="月山习BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=108, bufflv=4 }
        },
    },
    [3231] = { name="月山习BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=108, bufflv=5 }
        },
    },
    [3232] = { name="魔猿BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=114, bufflv=1 }
        },
    },
    [3233] = { name="魔猿BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=114, bufflv=2 }
        },
    },
    [3234] = { name="魔猿BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=114, bufflv=3 }
        },
    },
    [3235] = { name="魔猿BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=114, bufflv=4 }
        },
    },
    [3236] = { name="魔猿BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=114, bufflv=5 }
        },
    },
    [3237] = { name="钵川忠BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=130, bufflv=4 }
        },
    },
    [3238] = { name="钵川忠BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=130, bufflv=5 }
        },
    },
    [3239] = { name="真户吴绪BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=107, bufflv=4 }
        },
    },
    [3240] = { name="真户吴绪BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=107, bufflv=5 }
        },
    },
    [3241] = { name="地行甲乙BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=151, bufflv=1 }
        },
    },
    [3242] = { name="地行甲乙BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=151, bufflv=2 }
        },
    },
    [3243] = { name="地行甲乙BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=151, bufflv=3 }
        },
    },
    [3244] = { name="地行甲乙BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=151, bufflv=4 }
        },
    },
    [3245] = { name="地行甲乙BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=151, bufflv=5 }
        },
    },
    [3246] = { name="中岛康健BOSS普攻1", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=150, bufflv=1 }
        },
    },
    [3247] = { name="中岛康健BOSS普攻2", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=150, bufflv=2 }
        },
    },
    [3248] = { name="中岛康健BOSS普攻3", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=150, bufflv=3 }
        },
    },
    [3249] = { name="中岛康健BOSS普攻4", needtarget=0, combo=1,
        effect = {
            [1] = { targettype=0, buffid=150, bufflv=4 }
        },
    },
    [3250] = { name="中岛康健BOSS普攻5", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=150, bufflv=5 }
        },
    },
    [3251] = { name="精英怪s506（雪地靴背后两根赫子）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=349, bufflv=1 }
        },
    },
    [3252] = { name="精英怪s507(运动服3条赫子)普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=350, bufflv=1 }
        },
    },
    [3253] = { name="精英怪h504(背上武器罐)普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=351, bufflv=1 }
        },
    },
    [3254] = { name="精英怪h505（匕首武器）普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=352, bufflv=1 }
        },
    },
    [3255] = { name="精英怪jy_s321普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=353, bufflv=1 }
        },
    },
    [3256] = { name="精英怪jy_s325普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=354, bufflv=1 }
        },
    },
    [3257] = { name="精英怪jy_h303普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=355, bufflv=1 }
        },
    },
    [3258] = { name="精英怪jy_h503普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=356, bufflv=1 }
        },
    },
    [3259] = { name="精英怪jy_h510普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=357, bufflv=1 }
        },
    },
    [3260] = { name="精英怪jy_s508普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=358, bufflv=1 }
        },
    },
    [3261] = { name="精英怪jy_s509普攻", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=359, bufflv=1 }
        },
    },
    [3262] = { name="远程喰种普攻s337", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=360, bufflv=1 }
        },
    },
    [3263] = { name="近战喰种普攻s339", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=361, bufflv=1 }
        },
    },
    [3264] = { name="近战喰种普攻s340", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=362, bufflv=1 }
        },
    },
    [3265] = { name="近战喰种普攻s341", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=363, bufflv=1 }
        },
    },
    [3266] = { name="近战喰种普攻s320", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=364, bufflv=1 }
        },
    },
    [3267] = { name="近战喰种普攻s323", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=365, bufflv=1 }
        },
    },
    [3268] = { name="3v3炮塔", needtarget=0, combo=0,
        effect = {
            [1] = { targettype=0, buffid=366, bufflv=1 }
        },
    },
}
table.splice(g_SkillData, g_MosterNormalSkillData)
g_MosterNormalSkillData = nil
--[[endregion]]
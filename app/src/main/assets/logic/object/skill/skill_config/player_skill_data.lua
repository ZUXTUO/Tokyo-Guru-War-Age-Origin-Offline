--[[
region player_skill_data.lua
date: 2015-9-21
time: 19:31:16
author: Nation
编号1-999
]]
g_PlayerSkillData = {
    [1] = { name="金木研技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=2, bufflv=1, key=1 }
        },
    },
    [2] = { name="金木研技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=2, bufflv=2, key=1 }
        },
    },
    [3] = { name="金木研技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=2, bufflv=3, key=1 }
        },
    },
    [4] = { name="神代利世技能1", needtarget=0, combo=0, cdtype=0, manualdir=1, attention_buff={4,4},
        effect = {
            [1] = { targettype=0, buffid=4, bufflv=1, key=1 }
        },
    },
    [5] = { name="神代利世技能2", needtarget=0, combo=0, cdtype=0,manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=4, bufflv=2, key=1 }
        },
    },
    [6] = { name="神代利世技能3", needtarget=0, combo=0, cdtype=0,manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=4, bufflv=3, key=1 }
        },
    },
    [7] = { name="雾岛董香技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=5, bufflv=1, key=1 }
        },
    },
    [8] = { name="雾岛董香技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=5, bufflv=2, key=1 }
        },
    },
    [9] = { name="雾岛董香技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=5, bufflv=3, key=1 }
        },
    },
    [10] = { name="亚门钢太郎技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=7, bufflv=1, key=1 }
        },
    },
    [11] = { name="亚门钢太郎技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=7, bufflv=2, key=1 }
        },
    },
    [12] = { name="亚门钢太郎技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=7, bufflv=3, key=1 }
        },
    },
    [13] = { name="真户吴绪技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=8, bufflv=1, key=1 }
        },
    },
    [14] = { name="真户吴绪技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=8, bufflv=2, key=1 }
        },
    },
    [15] = { name="真户吴绪技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=8, bufflv=3, key=1 }
        },
    },
    [16] = { name="西尾锦技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=10, bufflv=1, key=1 }
        },
    },
    [17] = { name="西尾锦技能2", needtarget=0, combo=0, cdtype=0, ignoredir=1,
        effect = {
            [1] = { targettype=0, buffid=10, bufflv=2, key=1 }
        },
    },
    [18] = { name="西尾锦技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=10, bufflv=3, key=1 }
        },
    },
    [19] = { name="大守八云技能1", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=1,
        effect = {
            [1] = { targettype=0, buffid=15, bufflv=1, key=1 }
        },
    },
    [20] = { name="大守八云技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=15, bufflv=2, key=1 }
        },
    },
    [21] = { name="大守八云技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=15, bufflv=3, key=1 }
        },
    },
    [22] = { name="月山习技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=16, bufflv=1, key=1 },
        },
    },
    [23] = { name="月山习技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=16, bufflv=2, key=1 }
        },
    },
    [24] = { name="月山习技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=16, bufflv=3, key=1 }
        },
    },
    [25] = { name="蜈蚣金木技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=18, bufflv=1, },
        },
    },
    [26] = { name="蜈蚣金木技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=18, bufflv=2, key=1 }
        },
    },
    [27] = { name="蜈蚣金木技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=18, bufflv=3, key=1 }
        },
    },
    [28] = { name="不杀之枭技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=19, bufflv=1, key=1 },
        },
    },
    [29] = { name="不杀之枭技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=19, bufflv=2, key=1 }
        },
    },
    [30] = { name="不杀之枭技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=19, bufflv=3, key=1 }
        },
    },
    [31] = { name="笛口雏实技能1", needtarget=0, combo=0, cdtype=0,manualdir=1, 
            effect = {
            [1] = { targettype=0, buffid=20, bufflv=1, key=1 },
        },
    },
    [32] = { name="笛口雏实技能2", needtarget=0, combo=0, cdtype=0,manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=20, bufflv=2, key=1 }
        },
    },
    [33] = { name="笛口雏实技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=20, bufflv=3, key=1 }
        },
    },
    [34] = { name="笛口凉子技能1", needtarget=0, combo=0, cdtype=0,manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=21, bufflv=1, key=1 },
        },
    },
    [35] = { name="笛口凉子技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=21, bufflv=2, key=1 }
        },
    },
    [36] = { name="笛口凉子技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=21, bufflv=3, key=1 }
        },
    },
    [37] = { name="原创CCG炮形昆克技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=22, bufflv=1, key=1 },
        },
    },
    [38] = { name="原创CCG炮形昆克技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=22, bufflv=2, key=1 }
        },
    },
    [39] = { name="原创CCG炮形昆克技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=22, bufflv=3, key=1 }
        },
    },
    [40] = { name="魔猿形态技能1", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=24, bufflv=1, key=1 },
        },
    },
    [41] = { name="魔猿形态技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=24, bufflv=2, key=1 }
        },
    },
    [42] = { name="魔猿形态技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=24, bufflv=3, key=1 }
        },
    },
    [43] = { name="独眼之枭技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=25, bufflv=1, key=1 },
        },
    },
    [44] = { name="独眼之枭技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=25, bufflv=2, key=1 }
        },
    },
    [45] = { name="独眼之枭技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=25, bufflv=3, key=1 }
        },
    },
    [46] = { name="铃屋什造技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=26, bufflv=1, key=1 },
        },
    },
    [47] = { name="铃屋什造技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=26, bufflv=2, key=1 }
        },
    },
    [48] = { name="铃屋什造技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=26, bufflv=3, key=1 }
        },
    },
    [49] = { name="多多良技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=27, bufflv=1, key=1 },
        },
    },
    [50] = { name="多多良技能2", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=1, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=27, bufflv=2, key=1 }
        },
    },
    [51] = { name="多多良技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=27, bufflv=3, key=1 }
        },
    },
    [52] = { name="御坂技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=28, bufflv=1, key=1 },
        },
    },
    [53] = { name="御坂技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=28, bufflv=2, key=1 }
        },
    },
    [54] = { name="御坂技能3", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=2,
        effect = {
            [1] = { targettype=0, buffid=28, bufflv=3, key=1 }
        },
    },
    [55] = { name="瓶兄技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=29, bufflv=1, key=1 },
        },
    },
    [56] = { name="瓶兄技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=29, bufflv=2, key=1 }
        },
    },
    [57] = { name="瓶兄技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=29, bufflv=3, key=1 }
        },
    },
    [58] = { name="篠原幸纪技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=31, bufflv=1, key=1 },
        },
    },
    [59] = { name="篠原幸纪技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=31, bufflv=2, key=1 }
        },
    },
    [60] = { name="篠原幸纪技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=31, bufflv=3, key=1 }
        },
    },
    [61] = { name="平子丈技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=33, bufflv=1, key=1 },
        },
    },
    [62] = { name="平子丈技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=33, bufflv=2, key=1 }
        },
    },
    [63] = { name="平子丈技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=33, bufflv=3, key=1 }
        },
    },
    [64] = { name="黑磐岩技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=34, bufflv=1, key=1 },
        },
    },
    [65] = { name="黑磐岩技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=34, bufflv=2, key=1 }
        },
    },
    [66] = { name="黑磐岩技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=34, bufflv=3, key=1 }
        },
    },
    [67] = { name="法寺项介技能1", needtarget=0, combo=0, cdtype=0, lasthalo=1, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=35, bufflv=1, key=1 },
        },
    },
    [68] = { name="法寺项介技能2", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=1,
        effect = {
            [1] = { targettype=0, buffid=35, bufflv=2, key=1 }
        },
    },
    [69] = { name="法寺项介技能3", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=1, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=35, bufflv=3, key=1 }
        },
    },
    [70] = { name="泷泽政道技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=37, bufflv=1, key=1 },
        },
    },
    [71] = { name="泷泽政道技能2", needtarget=0, combo=0, cdtype=0, --manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=37, bufflv=2, key=1 }
        },
    },
    [72] = { name="泷泽政道技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=37, bufflv=3, key=1 }
        },
    },
    [73] = { name="有马贵将技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=38, bufflv=1, key=1 },
        },
    },
    [74] = { name="有马贵将技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=38, bufflv=2, key=1 }
        },
    },
    [75] = { name="有马贵将技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=38, bufflv=3, key=1 }
        },
    },
    [76] = { name="神代叉荣技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=39, bufflv=1, key=1 },
        },
    },
    [77] = { name="神代叉荣技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=39, bufflv=2, key=1 }
        },
    },
    [78] = { name="神代叉荣技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=39, bufflv=3, key=1 }
        },
    },
    [79] = { name="原创CCG1技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=41, bufflv=1, key=1 },
        },
    },
    [80] = { name="原创CCG1技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=41, bufflv=2, key=1 }
        },
    },
    [81] = { name="原创CCG1技能3", needtarget=0, combo=0, cdtype=1,
        effect = {
            [1] = { targettype=0, buffid=41, bufflv=3, key=1 }
        },
    },
    [82] = { name="田中丸望元技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=43, bufflv=1, key=1 },
        },
    },
    [83] = { name="田中丸望元技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=43, bufflv=2, key=1 }
        },
    },
    [84] = { name="田中丸望元技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=43, bufflv=3, key=1 }
        },
    },
    [85] = { name="真户晓技能1", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=44, bufflv=1, key=1 },
        },
    },
    [86] = { name="真户晓技能2", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=44, bufflv=2, key=1 }
        },
    },
    [87] = { name="真户晓技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=44, bufflv=3, key=1 }
        },
    },
    [88] = { name="五里美乡技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=46, bufflv=1, key=1 },
        },
    },
    [89] = { name="五里美乡技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=46, bufflv=2, key=1 }
        },
    },
    [90] = { name="五里美乡技能3", needtarget=0, combo=0, cdtype=0,manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=46, bufflv=3, key=1 }
        },
    },
    [91] = { name="安久奈白技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=47, bufflv=1, key=1 },
        },
    },
    [92] = { name="安久奈白技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=47, bufflv=2, key=1 }
        },
    },
    [93] = { name="安久奈白技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=47, bufflv=3, key=1 }
        },
    },
    [94] = { name="钵川忠技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=48, bufflv=1, key=1 },
        },
    },
    [95] = { name="钵川忠技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=48, bufflv=2, key=1 }
        },
    },
    [96] = { name="钵川忠技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=48, bufflv=3, key=1 }
        },
    },
    [97] = { name="野吕技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=49, bufflv=1, key=1 },
        },
    },
    [98] = { name="野吕技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=49, bufflv=2, key=1 }
        },
    },
    [99] = { name="野吕技能3", needtarget=0, combo=0, cdtype=0, lasthalo=1, cancel=1,
        effect = {
            [1] = { targettype=0, buffid=49, bufflv=3, key=1 }
        },
    },
    [100] = { name="宇井郡技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=50, bufflv=1, key=1 },
        },
    },
    [101] = { name="宇井郡技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=50, bufflv=2, key=1 }
        },
    },
    [102] = { name="宇井郡技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=50, bufflv=3, key=1 }
        },
    },
    [103] = { name="太郎技能1", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=51, bufflv=1, key=1 },
        },
    },
    [104] = { name="太郎技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=51, bufflv=2, key=1 }
        },
    },
    [105] = { name="太郎技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=51, bufflv=3, key=1 }
        },
    },
    [106] = { name="安久黑奈技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=52, bufflv=1, key=1 },
        },
    },
    [107] = { name="安久黑奈技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=52, bufflv=2, key=1 }
        },
    },
    [108] = { name="安久黑奈技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=52, bufflv=3, key=1 }
        },
    },
    [109] = { name="笛口亚关技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=53, bufflv=1, key=1 },
        },
    },
    [110] = { name="笛口亚关技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=53, bufflv=2, key=1 }
        },
    },
    [111] = { name="笛口亚关技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=53, bufflv=3, key=1 }
        },
    },
    [112] = { name="瓶弟技能1", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=54, bufflv=1, key=1 },
        },
    },
    [113] = { name="瓶弟技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=54, bufflv=2, key=1 }
        },
    },
    [114] = { name="瓶弟技能3", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=54, bufflv=3, key=1 }
        },
    },
    [115] = { name="原创CCG2技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=56, bufflv=1, key=1 },
        },
    },
    [116] = { name="原创CCG2技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=56, bufflv=2, key=1 }
        },
    },
    [117] = { name="原创CCG2技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=56, bufflv=3, key=1 }
        },
    },
    [118] = { name="恢复生命", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=57, bufflv=1, key=1 }
        },
    },
    [119] = { name="纳基技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=59, bufflv=1, key=1 }
        },
    },
    [120] = { name="纳基技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=59, bufflv=2, key=1 }
        },
    },
    [121] = { name="纳基技能3", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=59, bufflv=3, key=1 }
        },
    },
    [122] = { name="万丈数一技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=60, bufflv=1, key=1 }
        },
    },
    [123] = { name="万丈数一技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=60, bufflv=2, key=1 }
        },
    },
    [124] = { name="万丈数一技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=60, bufflv=3, key=1 }
        },
    },
    [125] = { name="雾岛绚都技能1", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=62, bufflv=1, key=1 },
        },
    },
    [126] = { name="雾岛绚都技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=62, bufflv=2, key=1 }
        },
    },
    [127] = { name="雾岛绚都技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=62, bufflv=3, key=1 }
        },
    },
    [131] = { name="楠木遥人技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=61, bufflv=1, key=1 },
        },
    },
    [132] = { name="楠木遥人技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=61, bufflv=2, key=1 }
        },
    },
    [133] = { name="楠木遥人技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=61, bufflv=3, key=1 }
        },
    },
    [134] = { name="呗技能1", needtarget=0, combo=0, cdtype=0, condition=38, attention_buff={63,9,63,8},
        effect = {
            [1] = { targettype=0, buffid=63, bufflv=1, key=1 },
        },
    },
    [135] = { name="呗技能2", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=63, bufflv=2, key=1 }
        },
    },
    [136] = { name="呗技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=63, bufflv=3, key=1 }
        },
    },
    [137] = { name="四方莲示技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=64, bufflv=1, key=1 },
        },
    },
    [138] = { name="四方莲示技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=64, bufflv=2, key=1 }
        },
    },
    [139] = { name="四方莲示技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=64, bufflv=3, key=1 }
        },
    },
    [140] = { name="背包金木研技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=65, bufflv=1, key=1 }
        },
    },
    [141] = { name="背包金木研技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=65, bufflv=2, key=1 }
        },
    },
    [142] = { name="背包金木研技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=65, bufflv=3, key=1 }
        },
    },
    [143] = { name="白发金木研技能1", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=66, bufflv=1, key=1 }
        },
    },
    [144] = { name="白发金木研技能2", needtarget=0, combo=0, cdtype=0, manualdir=1, 
        effect = {
            [1] = { targettype=0, buffid=66, bufflv=2, key=1 }
        },
    },
    [145] = { name="白发金木研技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=66, bufflv=3, key=1 }
        },
    },
    [146] = { name="白发金木研巅峰展示技能", needtarget=0, combo=0, cdtype=2, 
        effect = {
            [1] = { targettype=0, buffid=66, bufflv=10, key=1 }
        },
    },
    [147] = { name="杰森 暴走技能1", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=68, bufflv=1, key=1 }
        },
    },
    [148] = { name="杰森 暴走技能2", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=68, bufflv=2, key=1 }
        },
    },
    [149] = { name="杰森 暴走技能3", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=68, bufflv=3, key=1 }
        },
    },
    [150] = { name="雾岛绚都怪物用技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=62, bufflv=11, key=1 }
        },
    },
    [151] = { name="村松希惠技能1", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=69, bufflv=1, key=1 }
        },
    },
    [152] = { name="村松希惠技能2", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=69, bufflv=2, key=1 }
        },
    },
    [153] = { name="村松希惠技能3", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=69, bufflv=3, key=1 }
        },
    },
    [154] = { name="地行甲乙技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,   
        effect = {
            [1] = { targettype=0, buffid=71, bufflv=1, key=1 }
        },
    },
    [155] = { name="地行甲乙技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,   
        effect = {
            [1] = { targettype=0, buffid=71, bufflv=2, key=1 }
        },
    },
    [156] = { name="地行甲乙技能3", needtarget=0, combo=0, cdtype=0,  
        effect = {
            [1] = { targettype=0, buffid=71, bufflv=3, key=1 }
        },
    },
    [157] = { name="中岛康健技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,  
        effect = {
            [1] = { targettype=0, buffid=70, bufflv=1, key=1 }
        },
    },
    [158] = { name="中岛康健技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,  
        effect = {
            [1] = { targettype=0, buffid=70, bufflv=2, key=1 }
        },
    },
    [159] = { name="中岛康健技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,  
        effect = {
            [1] = { targettype=0, buffid=70, bufflv=3, key=1 }
        },
    },
    ----------------------------------觉醒技能------------------------------------
    [300] = { name="笛口凉子觉醒技能1", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=21, bufflv=8, key=1 },
        },
    },
    [301] = { name="西尾锦觉醒技能3", needtarget=0, combo=0, cdtype=0, ignoredir=1,
        effect = {
            [1] = { targettype=0, buffid=10, bufflv=10, key=1 }
        },
    },
    [302] = { name="安久奈白觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=47, bufflv=7, key=1 }
        },
    },
    [303] = { name="平子丈觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=33, bufflv=10, key=1 }
        },
    },
    [304] = { name="金木研觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=2, bufflv=7, key=1 }
        },
    },
    [305] = { name="真户晓觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=44, bufflv=7, key=1 }
        },
    },
    [306] = { name="雾岛董香觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=5, bufflv=6, key=1 }
        },
    },
    [307] = { name="瓶弟觉醒技能3", needtarget=0, combo=0, cdtype=0,manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=54, bufflv=5, key=1 }
        },
    },
    [308] = { name="亚门钢太郎觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=7, bufflv=5, key=1 }
        },
    },
    [309] = { name="笛口雏实觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=20, bufflv=8, key=1 }
        },
    },
    [310] = { name="铃屋什造觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=26, bufflv=11, key=1 }
        },
    },
    [311] = { name="神代利世觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=4, bufflv=3, key=1 }
        },
    },
    [312] = { name="真户吴绪觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=8, bufflv=7, key=1 }
        },
    },
    [313] = { name="雾岛绚都觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=62, bufflv=7, key=1 }
        },
    },
    [314] = { name="四方莲示觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=64, bufflv=8, key=1 }
        },
    },
    [315] = { name="白发金木研觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=66, bufflv=7, key=1 }
        },
    },
    [316] = { name="杰森 暴走觉醒技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=68, bufflv=6, key=1 }
        },
    },
    [317] = { name="宇井郡觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=50, bufflv=5, key=1 }
        },
    },
    [318] = { name="纳基觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=59, bufflv=9, key=1 }
        },
    },
    [319] = { name="月山习觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=16, bufflv=6, key=1 }
        },
    },
    [320] = { name="魔猿形态觉醒技能3", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=24, bufflv=8, key=1 }
        },
    },
    [321] = { name="钵川忠觉醒技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=48, bufflv=10, key=1 }
        },
    },
    --------------------------------关卡技能[400-499]----------------------------
    [400] = { name="击退技能", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=1235, bufflv=1, key=1 },
        },
    },
    [401] = { name="放置减速陷阱技能", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=1235, bufflv=4, key=1 },
        },
    },
    [402] = { name="放置伤害陷阱技能", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=1235, bufflv=6, key=1 },
        },
    },
    [403] = { name="放置眩晕陷阱技能", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=1235, bufflv=8, key=1 },
        },
    },
    --------------------------------战斗数据模型----------------------------------
    [500] = { name="标准模型B-安久奈白技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=80, bufflv=1, key=1 }
        },
    },
    [501] = { name="标准模型B-安久奈白技能2", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=80, bufflv=2, key=1 }
        },
    },
    [502] = { name="标准模型B-安久奈白技能3", needtarget=0, combo=0, cdtype=0, 
        effect = {
            [1] = { targettype=0, buffid=80, bufflv=3, key=1 },
        },
    },
    [503] = { name="攻B-金木研技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=81, bufflv=1, key=1 }
        },
    },
    [504] = { name="攻B-金木研技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=81, bufflv=2, key=1 }
        },
    },
    [505] = { name="攻B-金木研技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=81, bufflv=3, key=1 }
        },
    },
    [506] = { name="防B-亚门钢太郎技能1", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=82, bufflv=1, key=1 }
        },
    },
    [507] = { name="防B-亚门钢太郎技能2", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=82, bufflv=2, key=1 }
        },
    },
    [508] = { name="防B-亚门钢太郎技能3", needtarget=0, combo=0, cdtype=0,  manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=82, bufflv=3, key=1 }
        },
    },
    [509] = { name="技B-笛口雏实技能1", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=83, bufflv=1, key=1 }
        },
    },
    [510] = { name="技B-笛口雏实技能2", needtarget=0, combo=0, cdtype=0, manualdir=1,
        effect = {
            [1] = { targettype=0, buffid=83, bufflv=2, key=1 }
        },
    },
    [511] = { name="技B-笛口雏实技能3", needtarget=0, combo=0, cdtype=0,
        effect = {
            [1] = { targettype=0, buffid=83, bufflv=3, key=1 },
        },
    },
}
table.splice(g_SkillData, g_PlayerSkillData)
g_PlayerSkillData = nil
--[[endregion]]
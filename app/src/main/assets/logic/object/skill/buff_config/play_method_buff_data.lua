--[[
region play_method_buff_data.lua
date: 2015-9-18
time: 21:31:33
author: Nation
编号1000-1999
]]
g_PlayMethodBuffData = {
    [1000] = { name="小怪BUFF",
        level = {--持续时间，
            [1] = { name="冻结5秒", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, effectid=18053, rollback=true, durationtime=0, callbacktype=0, attentionaction=1 }, --眩晕特效.
                        }
                    },
                }
            },
            [2] = { name="减速5秒", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {                            --减速         值
                            [1] = { atype=3, abilityname="move_speed", scale=0.5, rollback=true }, --减少移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=10, rollback=true, durationtime=0, callbacktype=0 }, --减速特效.
                        }
                    },
                }
            },
            [3] = { name="伤血50%", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=2, persent=0.5 }, --减少50%血量
                            [2] = { atype=6, srctype=2, targettype=0, effectid=20, callbacktype=0 }, --受击特效.
                        }
                    },
                }
            },
            [4] = { name="冻结2秒", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, effectid=18053, rollback=true, durationtime=0, callbacktype=0, attentionaction=1 }, --眩晕特效.
                        }
                    },
                }
            },
			[5] = { name="boss减速3秒", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=0.6, rollback=true }, --减少移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=10, rollback=true, durationtime=0, callbacktype=0 }, --减速特效.
                        }
                    },
                }
            },
			[6] = { name="加速2秒", duration=2000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {                            --加速   固定值类型    具体值
                            [1] = {atype=41, abilityname="move_speed", valuetype=1, value=3, rollback=true}, --增加固定移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=51, rollback=true, durationtime=0, callbacktype=0 }, --加速特效.
                        }
                    },
                }
            },
			[7] = { name="加速4秒", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {                            --加速         值
                            [1] = {atype=41, abilityname="move_speed", valuetype=1, value=1, rollback=true},  --增加固定移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=51, rollback=true, durationtime=0, callbacktype=0 }, --加速特效.
                        }
                    },
                }
            },
			[8] = { name="晕眩1秒", duration=1000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, effectid=18053, rollback=true, durationtime=0, callbacktype=0, attentionaction=1 }, --眩晕特效.
                        }
                    },
                }
            },
            [9] = { name="加速5秒", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {                            --加速   固定值类型    具体值
                            [1] = {atype=41, abilityname="move_speed", valuetype=1, value=0.5, rollback=true}, --增加固定移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=51, rollback=true, durationtime=0, callbacktype=0 }, --加速特效.
                        }
                    },
                }
            },
            [10] = { name="加速5秒", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {                            --加速   固定值类型    具体值
                            [1] = {atype=41, abilityname="move_speed", valuetype=1, value=1.25, rollback=true}, --增加固定移动速度
                            [2] = { atype=6, srctype=2, targettype=0, effectid=51, rollback=true, durationtime=0, callbacktype=0 }, --加速特效.
                        }
                    },
                }
            },
        }
    },
    [1001] = { name="陷阱",
        level = {
            [1] = { name="减速陷阱", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=0.5, rollback=true }, --减少移动速度
                        }
                    },
                }
            },
            [2] = { name="冰冻陷阱", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                        }
                    },
                }
            },
            [3] = { name="定时炸弹", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=1, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=4, targettype=1, },
                        }
                    },
                }
            },
            [4] = { name="定时炸弹伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=1, persent=0.1, }, 
                        }
                    },
                }
            },
            [5] = { name="手雷", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=0.9, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=6, targettype=1, },
                        }
                    },
                }
            },
            [6] = { name="手雷伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=1, persent=0.1, }, 
                        }
                    },
                }
            },
            [7] = { name="液体/积水", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=400,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=2, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=8, targettype=1, },
                        }
                    },
                }
            },
            [8] = { name="液体/积水效果", duration=500, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=0.5, rollback=true }, --减少移动速度
                        }
                    },
                }
            },
            [9] = { name="井盖", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=1, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=10, targettype=1, },
                        }
                    },
                }
            },
            [10] = { name="井盖效果", duration=2000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
                        }
                    },
                }
            },
            [11] = { name="油桶", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=2, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=12, targettype=1, },
                        }
                    },
                }
            },
            [12] = { name="油桶效果", duration=1000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=1, persent=0.1, }, 
                        }
                    },
                }
            },
            [13] = { name="电网", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=2, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=14, targettype=1, },
                        }
                    },
                }
            },
            [14] = { name="电网效果", duration=1000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true }, 
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
                        }
                    },
                }
            },
            [15] = { name="电网", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=2, angle=360, enemy=true,},
                            [2] = { atype=5, buffid=1001, bufflv=14, targettype=1, },
                            [3] = { atype=2, srctype=1, targettype=1, radius=2, angle=360, enemy=false,},
                            [4] = { atype=5, buffid=1001, bufflv=14, targettype=1, },
                        }
                    },
                }
            },
            [16] = { name="扣当前10%", duration=0, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=2, persent=0.1 },
                        }
                    },
                },
            },
        },
    },
    [1002] = { name="冰箱怪被动BUFF",
        level = {
            [1] = { name="被动BUFF", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=11, buffid=1001, bufflv=2, targettype=3 }, --移除冰箱陷阱
                        }
                    },
                }
            },
        },
    },
    [1003] = { name="降低属性",
        level = {
            [1] = { name="降低防御", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="def_power", scale=0.8, rollback=true }, --减少防
                        }
                    },
                },
            },
        },
    },
    [1005] = { name="无敌",
        level = {
            [1] = { name="无敌", duration=-1, overlap=0, property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0, triggertype=1,
                        action = 
                        {
                            [1] = { atype=55, },
                        }
                    },
                },
            },
        },
    },
    --------[[奎库利亚begin_id:[1006]]]-----------
    -- 在文件kuikuliya_buff_data.lua中
    ------------------------------奎库利亚end_id：[1206]----------------------
    [1207] = { name="只受1点伤害",
        level = {
            [1] = { name="只受1点伤害", duration=-1, overlap=0, property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0, triggertype=1,
                        action = 
                        {
                            [1] = { atype=65, value=1 },
                        }
                    },
                },
            },
        },
    },
    [1208] = { name="3V3血包",
        level = {
            [1] = { name="恢复损失血量的50%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=246 },
                            [2] = { atype=25, type=3, value=0.5 },
                        }
                    },
                },
            },
            [2] = { name="泉水", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true, radius=3,},
                            [2] = { atype=5, bufflv=3, buffid=1208, targettype=1, },
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=false, radius=3,},
                            [4] = { atype=5, bufflv=4, buffid=1208, targettype=1, },
                        }
                    },
                },
            },
            [3] = { name="添加伤害", duration=1000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=1, persent=0.3, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18036, rollback=true, durationtime=0 },
                        },
                    },
                },
            },
            [4] = { name="加血", duration=1000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=62,
                        action = {
                            [1] = { atype=25, type=2, value=0.3, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18039, rollback=true, durationtime=0, },--
                        },
                    },
                },
            },
            [5] = { name="恢复损失血量的100%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=246 },
                            [2] = { atype=25, type=3, value=1 },
                        }
                    },
                },
            },
            [6] = { name="恢复我方全体血量50%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=6, angle=360, layer=lay_all_role, enemy=false, includeself=true, },
                            [2] = { atype=5, buffid=1208, bufflv=1, targettype=1, },
                        }
                    },
                },
            },
            [7] = { name="我方全体恢复损失血量的100%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=6, angle=360, layer=lay_all_role, enemy=false, includeself=true, },
                            [2] = { atype=5, buffid=1208, bufflv=5, targettype=1, },
                        }
                    },
                },
            },
        },
    },
    [1209] = { name="MMO复活无敌",
        level = {
            [1] = { name="无敌", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=55, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=19010, durationtime=0, rollback=true },
                        }
                    },
                },
            },
        },
    },
    [1230] = { name="大乱斗已知库BUFF",
        level = {
            [1] = { name="攻击BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, targettype=0, type=5 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=30, scale=1.25, odds=100, rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_gongji.assetbundle',
            },
            [2] = { name="防御BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=31, scale=0.75, odds=100, rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
            [3] = { name="回复BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18039, rollback=true, durationtime=0 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=25, type=2, value=0.005 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_huifu.assetbundle',
            },
            [4] = { name="觉醒BUFF", duration=0, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18049 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=67 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_juexing.assetbundle',
            },
            [5] = { name="反弹BUFF", duration=8000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=41, abilityname="rally_rate", value=0.8, valuetype=1, rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fantan.assetbundle',
            },
            [6] = { name="狂暴BUFF", duration=15000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=1.25, rollback=true }, --增加移动速度
                            [2] = { atype=41, abilityname="attack_speed", value=0.15, valuetype=1, rollback=true }, --增加攻击速度
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18038, rollback=true, durationtime=0 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_kuangbao.assetbundle',
            },
        },
    },
    [1231] = { name="大乱斗未知库BUFF",
        level = {
            [1] = { name="攻击BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, targettype=0, type=5 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=30, scale=1.5, odds=100, rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_gongji.assetbundle',
            },
            [2] = { name="防御BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=31, scale=0.5, odds=100, rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
            [3] = { name="回复BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18039, rollback=true, durationtime=0 },
                            [2] = { atype=25, type=2, value=0.15 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=25, type=2, value=0.05 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_huifu.assetbundle',
            },
            [4] = { name="损耗BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.15 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18036, rollback=true, durationtime=0 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=1, persent=0.05 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_haosun.assetbundle',
            },
            [5] = { name="虚弱BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.15 },
                            [2] = { atype=3, abilityname="def_power", scale=0.75, rollback=true },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_xuruo.assetbundle',
            },
            [6] = { name="疲劳BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.15 },
                            [2] = { atype=3, abilityname="atk_power", scale=0.75, rollback=true },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_pilao.assetbundle',
            },
            [7] = { name="嗜血BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.55 },
                            [2] = { atype=3, abilityname="move_speed", scale=1.20, rollback=true }, --增加移动速度
                            [3] = { atype=41, abilityname="attack_speed", valuetype=1, value=0.2, rollback=true }, --增加攻击速度
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18051, rollback=true, durationtime=0 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_shixie.assetbundle',
            },
            [8] = { name="重生BUFF", duration=0, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=2, value=1 },
                            [2] = { atype=21, skillid=-1 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18044 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_chongsheng.assetbundle',
            },
            [9] = { name="牺牲BUFF", duration=10000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.15 },
                            [2] = { atype=3, abilityname="def_power", scale=1.5, rollback=true },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18028 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_xisheng.assetbundle',
            },
            [10] = { name="平等BUFF", duration=0, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, includeself=true, enemy=false, layer=lay_all_role },
                            [2] = { atype=5, buffid=1232, bufflv=1, targettype=1 },
                            [3] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, enemy=true, layer=lay_all_role },
                            [4] = { atype=5, buffid=1232, bufflv=1, targettype=1 },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_chenmo.assetbundle',
            },
            [11] = { name="缓慢BUFF", duration=0, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, includeself=true, enemy=false, layer=lay_all_role },
                            [2] = { atype=5, buffid=1232, bufflv=2, targettype=1 },
                            [3] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, enemy=true, layer=lay_all_role },
                            [4] = { atype=5, buffid=1232, bufflv=2, targettype=1 },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_huanman.assetbundle',
            },
            [12] = { name="考验BUFF", duration=0, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, includeself=true, enemy=false, layer=lay_all_role },
                            [2] = { atype=5, buffid=1232, bufflv=3, targettype=1 },
                            [3] = { atype=2, usetype=1, srctype=1, targettype=1, radius=10000, angle=360, enemy=true, layer=lay_all_role },
                            [4] = { atype=5, buffid=1232, bufflv=3, targettype=1 },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18029 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_kaoyan.assetbundle',
            },
        },
    },
    [1232] = { name="大乱斗娱乐BUFF效果",
         level = {
            [1] = { name="沉默状态", duration=10000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_chenmo.assetbundle',
            },
            [2] = { name="缓慢状态", duration=15000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=0.4, rollback=true }, --减少移动速度
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_huanman.assetbundle',
            },
            [3] = { name="持续掉血状态", duration=10000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18036, rollback=true, durationtime=0 },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=4, type=1, persent=0.1 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_kaoyan.assetbundle',
            },
			[4] = { name="持续掉血状态", duration=2000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18036, rollback=true, durationtime=0 },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=4, type=1, persent=0.025 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_kaoyan.assetbundle',
            },
        },
    },
    [1233] = { name="社团战buff(自己)",
         level = {
            [1] = { name="暴击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1},
                        }
                    },
                },
            },
            [2] = { name="攻击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=1},
                        }
                    },
                },
            },
            [3] = { name="防御", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="def_power", valuetype=1},
                        }
                    },
                },
            },
        },
    },
    [1234] = { name="社团战buff(敌人)",
         level = {
            [1] = { name="暴击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1},
                        }
                    },
                },
            },
            [2] = { name="攻击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=1},
                        }
                    },
                },
            },
            [3] = { name="防御", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="def_power", valuetype=1},
                        }
                    },
                },
            },
        },
    },
    [1235] = { name="关卡玩法技能",
        level = {
            -------------------- 击退技能 ----------------------------------
            [1] = { name="击退", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=404},
                            [2] = { atype=6, srctype=6, targettype=6, effectid=18080, position=7, len=0, direct=1, directoffset=0,callbacktype=0,durationwithspeed=true},
                            [3] = { atype=5, buffid=1235, bufflv=2, targettype=1, },
                            [4] = { atype=15, },
                        },
                    },
                },
            },
            [2] = { name="击退_效果", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=0, usetime=100, direct=4, distance=2, callbacktype=0, limit=3000,},
                            [2] = { atype=5, buffid=1235, bufflv=3, targettype=0, },
                        },
                    },
                },
            },
            [3] = { name="击退_眩晕", duration=2000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
                        },
                    },
                },
            },
            -------------------- 击退技能 end----------------------------------
            -------------------- 放置减速技能 ----------------------------------
            [4] = { name="放置减速技能", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, srctype=3, },
                            [2] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=18078, rollback=true, durationtime=0, position=0,},
                            [3] = { atype=15, },
                        },
                    },
                    [2] = { activetype=2, triggertype=1, interval=300,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=405},
                            [2] = { atype=5, buffid=1235, bufflv=5, targettype=1, },
                        },
                    },
                },
            },
            [5] = { name="减速", duration=500, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=0.5, rollback=true }, 
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0},--减速特效
                        },
                    },
                },
            },
            -------------------- 放置减速技能 end----------------------------------
            -------------------- 放置伤害技能 ----------------------------------
            [6] = { name="放置伤害技能", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, srctype=3, },
                            [2] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=18055, rollback=true, durationtime=0, position=0,},
                            [3] = { atype=15, },
                        },
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=406},
                            [2] = { atype=5, buffid=1235, bufflv=7, targettype=1, },
                        },
                    },
                },
            },
            [7] = { name="伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.04, }, 
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18072, rollback=true, durationtime=0},--伤害特效
                        },
                    },
                },
            },
            -------------------- 放置伤害技能 end----------------------------------
            -------------------- 放置眩晕技能 ----------------------------------
            [8] = { name="放置眩晕技能", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, srctype=3, },
                            [2] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=18056, rollback=true, durationtime=0, position=0,},
                            [3] = { atype=15, },
                        },
                    },
                    [2] = { activetype=2, triggertype=1, interval=300,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=407},
                            [2] = { atype=5, buffid=1235, bufflv=9, targettype=1, },
                        },
                    },
                },
            },
            [9] = { name="眩晕", duration=2000, overlap=8, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, effectid=18073, rollback=true, durationtime=0, callbacktype=0, attentionaction=1 }, --眩晕特效.
                        },
                    },
                },
            },
            -------------------- 放置眩晕技能 end----------------------------------
        },
    },
    -- 玩法关卡
    [1236] = { name="伤害加成",
        level = {
            [1] = { name="伤害加成20%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=30, scale=1.2, odds=100, },
                        },
                    },
                },
            },
            [2] = { name="伤害加成30%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=30, scale=1.3, odds=100, },
                        },
                    },
                },
            },
        },
    },
    [1237] = { name="最大生命值",
        level = {
            [1] = { name="最大生命值50%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="max_hp", scale=1.5, },
                        },
                    },
                },
            },
        },
    },
    [1238] = { name="移动速度加成",
        level = {
            [1] = { name="移动速度加成20%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=1.2, },
                        },
                    },
                },
            },
        },
    },
    --1v1战斗buff

    [1239] = { name="我方角色攻击力提升N%",
        level = {
            [1] = { name="我方角色攻击力提升20%", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            -- [1] = { atype=85, targettype=0, type=5 },
                            [1] = { atype=30, scale=1.25, odds=100, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18084, rollback=true, durationtime=0 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_gongji.assetbundle',
            },
        },
    },
    [1240] = { name="反弹",
        level = {
            [1] = { name="受到伤害时反弹20%伤害", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0 },
                            [2] = { atype=97, type=7, scale=0.2 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_gongji.assetbundle',
            },
        },
    },
    [1241] = { name="加防",
        level = {
            [1] = { name="防御增加20%", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },
                            [2] = { atype=31, scale=0.8, odds=100, rollback=true },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1242] = { name="吸血",
        level = {
            [1] = { name="吸血增加20%", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },
                            [2] = { atype=97, type=6, scale=0.2 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1243] = { name="护盾",
        level = {
            [1] = { name="为我方增加吸收50000点伤害的护盾", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = {atype=47, type=1, value=50000, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18046, rollback=true, durationtime=0 },
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1244] = { name="降低防御",
        level = {
            [1] = { name="降低对方防御20%", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="def_power", scale=0.8, rollback=true }, --减少防
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1245] = { name="降低攻击",
        level = {
            [1] = { name="降低对方攻击20%", duration=-1, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="atk_power", scale=0.8, rollback=true }, --减少攻击
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1246] = { name="眩晕对手",
        level = {
            [1] = { name="眩晕对手2秒钟", duration=2000, overlap=6, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7,effect_type=2,rollback=true }, --眩晕对手
                            [2] = { atype=6, srctype=2, targettype=4, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                },
                icon = 'assetbundles/prefabs/ui/image/icon/buff/buff_fangyu.assetbundle',
            },
        },
    },
    [1247] = { name="社团BOSS无敌BUFF",
        level = {
            [1] = { name="无敌", duration=10000, overlap=0, property=bit_merge(64, 4),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=55, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=19010, durationtime=0, rollback=true },
                        }
                    },
                },
            },
        },
    },
    --1v1减益buff
    [1248] = { name="敌方角色攻击降低%",
        level = {
            [1] = { name="敌方角色攻击降低%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=6, radius=1000, enemy=true, layer=lay_all_role },
                            [2] = { atype=5, buffid=1248, bufflv=2, targettype=1, },
                        }
                    },
                },
            },
        },
    },
    [1249] = { name="保卫战 攻击加成",
        level = {
            [1] = { name="攻击加成", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=500,
                        action = {
                                                                                                                        -- 范围
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=false, radius=6, includeself=false},
                            [2] = { atype=5, bufflv=2, buffid=1249, targettype=1, },
                        }
                    },
                },
            },
            [2] = { name="攻击加成20%", duration=600, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                                                                        -- 值
                            [1] = { atype=3, abilityname="atk_power", scale=1.4, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18084, durationtime=0, rollback=true },
                        },
                    },
                },
            },
        },
    },
    [1250] = { name="大乱斗",
        level = {
            [1] = { name="恢复总血量的30%", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=246 },
                            [2] = { atype=25, type=2, value=0.3 },
                        }
                    },
                },
            },
            [2] = { name="攻击+10%", duration=-1, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                                                                        -- 值
                            [1] = { atype=3, abilityname="atk_power", scale=1.3, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18084, durationtime=0, rollback=true },
                        }
                    },
                },
            },
            [3] = { name="防御+10%", duration=-1, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                                                                        -- 值
                            [1] = { atype=3, abilityname="def_power", scale=1.3, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, durationtime=0, rollback=true },
                        }
                    },
                },
            },
        },
    },
        --1v1新增buff
    [1251] = { name="移动速度加成",
        level = {
            [1] = { name="移动速度加成20%，持续5秒", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", scale=1.2, },
                        },
                    },
                },
            },
        },
    },
}
table.splice(g_BuffData, g_PlayMethodBuffData)
g_PlayMethodBuffData = nil
--[[endregion]]
--[[
region monster_skill_buff_data.lua
date: 2015-9-18
time: 21:45:29
author: Nation
编号650-999

]]
g_MonsterSkillBuffData = {
	[650] = { name="独眼之枭BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=918, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=5, buffid=650, bufflv=4, targettype=0 },
                            [3] = { atype=5, buffid=650, bufflv=5, targettype=0 },
                            [4] = { atype=5, buffid=650, bufflv=6, targettype=0 },
                            [5] = { atype=5, buffid=650, bufflv=7, targettype=0 },
                            [6] = { atype=5, buffid=650, bufflv=8, targettype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=326, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=94, targetype=0, searchtype=1, type=0, infoindex=1, buffid=650, bufflv=10},
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=327, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=94, targetype=0, searchtype=1, type=0, infoindex=1},
                        }
                    },
                }
            },
            [4] = { name="技能1圆1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=4, randomindex=0 },
                            [2] = { atype=12, type=7, distance=2, postype=1, rollback=true }
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=700,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=280, position=5, },
                            [2] = { atype=20, delay=300 },
                            [3] = { atype=94, targetype=0, searchtype=2, radius=2, type=0, infoindex=1, buffid=650, bufflv=9},
                        }
                    },
                }
            },
            [5] = { name="技能1圆2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=4, randomindex=1 },
                            [2] = { atype=12, type=8, distance=2, postype=1, rollback=true }
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1000,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=280, position=5, },
                            [2] = { atype=20, delay=300 },
                            [3] = { atype=94, targetype=0, searchtype=2, radius=2, type=0, infoindex=1, buffid=650, bufflv=9},
                        }
                    },
                }
            },
            [6] = { name="技能1圆3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=2 },
                            [2] = { atype=12, type=9, distance=2, postype=1, rollback=true }
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1300,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=280, position=5, },
                            [2] = { atype=20, delay=300 },
                            [3] = { atype=94, targetype=0, searchtype=2, radius=2, type=0, infoindex=1, buffid=650, bufflv=9},
                        }
                    },
                }
            },
            [7] = { name="技能1圆4", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=3},
                            [2] = { atype=12, type=10, distance=2, postype=1, rollback=true }
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1600,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=280, position=5, },
                            [2] = { atype=20, delay=300 },
                            [3] = { atype=94, targetype=0, searchtype=2, radius=2, type=0, infoindex=1, buffid=650, bufflv=9},
                        }
                    },
                }
            },
            [8] = { name="技能1圆5", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=4},
                            [2] = { atype=12, type=11, distance=2, postype=1, rollback=true }
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1900,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=280, position=5, },
                            [2] = { atype=20, delay=300 },
                            [3] = { atype=94, targetype=0, searchtype=2, radius=2, type=0, infoindex=1, buffid=650, bufflv=9},
                        }
                    },
                }
            },
            [9] = { name="降低攻速+攻击力", duration=4000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=3, abilityname="atk_power", scale=0.7, rollback=true },
                            [2] = { atype=41, abilityname="attack_speed", valuetype=1, value=-0.3, rollback=true }, --增加攻击速度
                        }
                    },
                },
            },
            [10] = { name="降低防御", duration=4000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=3, abilityname="atk_power", scale=0.7, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
                        }
                    },
                },
            },
        },
    },
    [651] = { name="杰森暴走BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2), passive_detach_tigger_buff={id=651, lv=4}, ignore_anim_end={1,7},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=17019, rollback=true, durationtime=0, },--可打断特效
                            [3] = { atype=12, type=2, rollback=true },
                            [4] = { atype=1, srctype=2, targettype=4, animid=258, limit=3000, callbacktype=1 },--做动作
                            [5] = { atype=40, modelid=80001008 },--变身
                            [6] = { atype=5, buffid=651, bufflv=6, targettype=0 },
                            [7] = { atype=5, buffid=651, bufflv=2, targettype=0 },
                        }
                    },
                },
            },
            [2] = { name="冲刺", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },--查找附近目标,不能预先
                            [2] = { atype=13, buffid=651, bufflv=3, targettype=0, srctype=0, speed=16 }, --加BUFF根据距离速度算延迟
                            [3] = { atype=1, srctype=2, targettype=0, animid=266, callbacktype=0 },--做动作
                            [4] = { atype=14, targettype=0, usetime=500, direct=1, distance=7, callbacktype=0, limit=3000 },
                            [5] = { atype=15 },
                        }
                    },
                }
            },
            [3] = { name="伤害+眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                            [4] = { atype=23, targettype=1, distance=7, dirtype=2 },
                        }
                    },
                }
            },
            [4] = { name="打断眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                },
            },
            [5] = { name="技能2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=91, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=270, limit=3000, callbacktype=1 },--做动作
                        }
                    },
                },
            },
            [6] = { name="半赫者形态", duration=-1, overlap=0, property=bit_merge(64),
            },
            [7] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1, condition=60, --处于半赫者形态
                        action = {
                            [1] = { atype=86, scale=1.3, },
                        }
                    },
                    [2] = { activetype=0, triggertype=0, --condition=60, group=1,--处于半赫者形态
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=263, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=24, rollback=true },--记录伤害
                            [3] = { atype=2, usetype=0, typeindex=141 },--查找扇形目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=23, targettype=0,distance=1},
                            [6] = { atype=25, type=0, value=0.2 },--恢复生命
                        }
                    },
                },
            },
            [8] = { name="技能4", duration=0, overlap=0, property=bit_merge(64,32,16,2), passive_detach_tigger_buff={id=651, lv=4}, ignore_anim_end={1,5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=17019, rollback=true, durationtime=0, },--可打断特效
                            [3] = { atype=12, type=2, rollback=true },
                            [4] = { atype=1, srctype=2, targettype=4, animid=269, limit=3000, callbacktype=1 },--做动作
                            [5] = { atype=5, buffid=651, bufflv=2, targettype=0 },
                        }
                    },
                },
            },
        },
    },
    [652] = { name="食尸鬼小兵327BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2), ignore_anim_end={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=934, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=5, buffid=652, bufflv=2, targettype=0 },
                        }
                    },
                }
            },
            [2] = { name="光圈搜怪", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=937, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=5, buffid=652, bufflv=3, targettype=0 },
                        }
                    },
                }
            },
            [3] = { name="光圈搜怪", duration=3500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [2] = { atype=13, buffid=652, bufflv=4, targettype=0, srctype=0, speed=20 },
                        }
                    },
                }
            },
            [4] = { name="光圈伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=1, persent=0.05 }
                        }
                    },
                }
            },
        },
    },
    [653] = { name="董香BOSS",
        level = {
            [1] = { name="技能1 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64),ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true, angle=-20 },
                            [2] = { atype=12, type=12, rollback=true, angle=-7 },
                            [3] = { atype=12, type=13, rollback=true, angle=7, },
                            [4] = { atype=12, type=14, rollback=true, angle=20 },
                            [5] = { atype=1, srctype=2, targettype=4, animid=28, limit=3000, callbacktype=1 },--做动作
                            [6] = { atype=5, buffid=653, bufflv=6, targettype=0, },
                        }
                    },
                }
            },
            [2] = { name="4个羽赫", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=-20, enemy=true, },
                            [2] = { atype=13, buffid=653, bufflv=3, srctype=0, targettype=0, speed=18 },
                        }
                    },
                    [2] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=-7, enemy=true, },
                            [2] = { atype=13, buffid=653, bufflv=3, srctype=0, targettype=0, speed=18 },
                        }
                    },
                    [3] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=7, enemy=true, },
                            [2] = { atype=13, buffid=653, bufflv=3, srctype=0, targettype=0, speed=18 },
                        }
                    },
                    [4] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=23, enemy=true, },
                            [2] = { atype=13, buffid=653, bufflv=3, srctype=0, targettype=0, speed=18 },
                        }
                    },
                }
            },
            [3] = { name="羽赫伤害", duration=5500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=23, targettype=1, distance=4, limit=3000, },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 },
                        },
                    },
                }
            },
            [4] = { name="技能2 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64),ignore_anim_end={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=29, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=5, buffid=653, bufflv=7, targettype=0, },
                            -- [4] = { atype=1, srctype=2, targettype=4, animid=25, limit=3000, callbacktype=1 },--发射羽赫
                            -- [5] = { atype=2, srctype=1, targettype=4, enemy=true, },
                            -- [6] = { atype=13, buffid=653, bufflv=5, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟
                        }
                    },
                }
            },
            [5] = { name="伤害+沉默", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                   [1] = { activetype=3, triggertype=1, delay=100,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=4},--被击特效
                            [3] = { atype=7, effect_type=4, rollback=true,}, --沉默
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, attentionaction=3},--沉默特效
                            [5] = { atype=23, targettype=1, distance=4, limit=3000, },
                        },
                    },
                }
            },
            [6] = { name="技能1 攻击", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=24, limit=3000, callbacktype=1 },--发射羽赫
                            [3] = { atype=5, buffid=653, bufflv=2, targettype=0, },
                        }
                    },
                }
            },
            [7] = { name="技能2 攻击", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=25, limit=3000, callbacktype=1 },--发射羽赫
                            [3] = { atype=2, srctype=1, targettype=4, enemy=true, },
                            [4] = { atype=13, buffid=653, bufflv=5, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟
                        }
                    },
                }
            },
            [8] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=23, limit=3000, callbacktype=1 },  --先发射羽赫
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true, arraytype=0, },
                            [3] = { atype=5, buffid=653, bufflv=9, targettype=4,},
                        }
                    },
                }
            },
            [9] = { name="拷贝技能3 伤害", duration=5100, overlap=2, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=3},--被击特效
                            [3] = { atype=23, targettype=1, distance=1.5, },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2, },
                        },
                    },
                }
            },
        },
    },
    [654] = { name="神代利世BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=111, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=2, srctype=1, targettype=4, targetcnt=1, enemy=true, sorttype=0, arraytype=2 },
                            [4] = { atype=5, buffid=654, bufflv=2, targettype=0, condition=54 },
                            [5] = { atype=5, buffid=654, bufflv=7, targettype=0, condition=19 },
                        }
                    },
                }
            },
            [2] = { name="无目标情况", duration=0, overlap=0, property=bit_merge(64), ignore_anim_end={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=5, buffid=654, bufflv=4, targettype=0 },
                            [2] = { atype=1, srctype=3, targettype=4, animid=110, limit=3000, callbacktype=1,},
                            [3] = { atype=1, srctype=3, targettype=4, animid=113, limit=3000, callbacktype=1,},
                        }
                    },
                }
            },
            [3] = { name="拉扯", duration=5000, overlap=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, effectid=426, callbacktype=0 },
                            [2] = { atype=3, abilityname="atk_power", rollback=true, record=true, recordname="atk_power" },
                            [3] = { atype=3, abilityname="def_power", rollback=true, record=true, recordname="def_power" },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
                            [5] = { atype=5, buffid=654, bufflv=5, targettype=5 },
                            [6] = { atype=27, targettype=1, type=3, distance=0,},
                            [7] = { atype=14, targettype=3, usetime=150, offset=1, offsettype=0, callbacktype=1, limit=3000,},--吸引位置
                        }
                    },
                }
            },
            [4] = { name="减少属性", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="atk_power", rollback=true },
                            [2] = { atype=3, abilityname="def_power", rollback=true },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
                        },
                    },
                },
            },
            [5] = { name="增加属性", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=2, value="atk_power", rollback=true },
                            [2] = { atype=41, abilityname="def_power", valuetype=2, value="def_power", rollback=true },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0},
                        },
                    },
                },
            },
            [6] = { name="咬伤", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=426, callbacktype=0 },
                        },
                    },
                },
            },
            [7] = { name="自身咬人BUFF", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=150,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=3, targettype=4, animid=110, limit=3000, callbacktype=1,},
                            [3] = { atype=5, buffid=654, bufflv=3, targettype=6 },
                            [4] = { atype=20, delay=150 },
                            [5] = { atype=1, srctype=3, targettype=4, animid=113, limit=3000, callbacktype=1,},
                            [6] = { atype=5, buffid=654, bufflv=6, targettype=6 },
                            [7] = { atype=20, delay=150 },
                            [8] = { atype=5, buffid=654, bufflv=6, targettype=6 },
                        },
                    },
                },
            },
            [8] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=107, limit=3000, callbacktype=1 }, 
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},--
                            [4] = { atype=27, targettype=0, type=3, distance=1.5, },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=355, callbacktype=0 },
                            [6] = { atype=5, buffid=654, bufflv=9, targettype=0,},--
                        }
                    }
                }
            },
            [9] = { name="暴走 状态", duration=-1, overlap=1, property=bit_merge(64), maxoverlap=5, attention_skill=2092,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=654, bufflv=10, targettype=0, rollback=true},
                        },
                    },
                },
            },
            [10] = { name="暴走 状态特效", duration=-1, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18038, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [11] = { name="技能3", duration=0, overlap=3, property=bit_merge(64), ignore_anim_end={1,4},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=108, limit=3000, callbacktype=1,},
                            [2] = { atype=2, srctype=1, targettype=2, angle=360, radius=1, layer=lay_all_role, enemy=true },
                            [3] = { atype=95, type=0, buffid=654, bufflv=9, infoindex=2, rollback=true, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=355, callbacktype=0 },
                            [5] = { atype=6, srctype=6, targettype=0, effectid=356, callbacktype=0, position=0,},
                            [6] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [7] = { atype=27, targettype=0, type=5, },
                            [8] = { atype=11, buffid=654, bufflv=9, targettype=0, },
                        }
                    },
                }
            },
        },
    },
    [655] = { name="诗BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            -- [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [1] = { atype=2, srctype=1, targettype=3 },
                            [2] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=18057, durationtime=0, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=4, animid=935, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=5, buffid=655, bufflv=2, targettype=0, condition=55 },
                            [5] = { atype=5, buffid=655, bufflv=3, targettype=0, condition=56 },
                        }
                    },
                },
            },
            [2] = { name="目标在视野外", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=15,},
                        }
                    },
                }
            },
            [3] = { name="目标在视野内", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=936, limit=3000, callbacktype=0,},
                            [3] = { atype=14, targettype=1, callbacktype=0, speed=25, direct=1, autoforward=true, offset=1, offsettype=0, limit=3000, usetime=2000 },
                            [4] = { atype=5, buffid=655, bufflv=4, targettype=2 },
                        }
                    },
                }
            },
            [4] = { name="目标伤害+范围伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            --[1] = { atype=24, type=1, rollback=true,},
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=23, targettype=1, distance=4, limit=3000, },
                            [3] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, includeself=false, enemy=false, },
                            [4] = { atype=5, buffid=655, bufflv=5, targettype=1 },
                        }
                    },
                }
            },
            [5] = { name="伤害1", duration=0, overlap=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=23, targettype=1, distance=4, limit=3000, },
                        }
                    }
                }
            },
        },
    },
    [656] = { name="真户吴绪BOSS",
        level = {
            [1] = { name="技能1 准备", duration=0, overlap=0, property=bit_merge(2,16,32,64),ignore_anim_end={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            -- [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [1] = { atype=12, type=3, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=178, limit=3000, callbacktype=1 },--做动作
                            -- [3] = { atype=1, srctype=2, targettype=4, animid=177, limit=3000, callbacktype=1 },--开始动作
                            [3] = { atype=5, buffid=656, bufflv=12, targettype=0, }
                        }
                    },
                },
            },
            [2] = { name="子弹发射", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=150, --第1个子弹
                        action = {
                            [1] = { atype=82, scale=1.4, protype=3, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=43, callbacktype=0, durationtime=200 },
                            [3] = { atype=2, srctype=0, targettype=4, layer=lay_all_role, enemy=true, arraytype=0, },
                            [4] = { atype=5, buffid=656, bufflv=17, targettype=4 },
                            -- [5] = { atype=5, buffid=656, bufflv=3, targettype=4 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=350, --第2个子弹
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, effectid=43, direct=1, directoffset=-20, callbacktype=0, durationtime=200 },
                            [2] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=-20, layer=lay_all_role, enemy=true, arraytype=2, },
                            [3] = { atype=5, buffid=656, bufflv=17, targettype=6 },
                            -- [4] = { atype=5, buffid=656, bufflv=3, targettype=6 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=800, --第3个子弹
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, effectid=43, direct=1, directoffset=20, callbacktype=0, durationtime=200 },
                            [2] = { atype=2, srctype=0, targettype=4, direct=1, directoffset=20, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=656, bufflv=17, targettype=1 },
                            -- [4] = { atype=5, buffid=656, bufflv=3, targettype=1 },
                            [4] = { atype=5, buffid=656, bufflv=4, targettype=0, condition=57 },
                        }
                    },
                },
            },
            [3] = { name="技属性眩晕效果", duration=5000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=52,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                },
            },
            [4] = { name="降低攻击力", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="atk_power", rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0},
                        }
                    },
                },
            },
            [5] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=5, buffid=656, bufflv=6, targettype=0 },
                        }
                    },
                },
            },
            [6] = { name="第一个炸弹 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=31, scale=1.5, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=2, targettype=3, arraytype=2 },
                            [3] = { atype=32, type=1, srctype=1, targettype=3 },--记录位置和朝向
                            [4] = { atype=12, type=7, distance=2, postype=5, rollback=true },
                            [5] = { atype=1, srctype=2, targettype=4, animid=179, limit=3000, callbacktype=1 },--做动作
                            [6] = { atype=5, buffid=656, bufflv=13, targettype=0, },
                            -- [7] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            -- [8] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=1, usetime=600, limit=3000 },
                            -- [9] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=2, enemy=true },
                            -- [10] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [11] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            -- [12] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=5 },
                            -- [13] = { atype=5, buffid=656, bufflv=7, targettype=0 },
                        }
                    },
                },
            },
            [7] = { name="第二个炸弹 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=31, scale=1.5, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=1, targettype=3 },--记录位置和朝向
                            [3] = { atype=88, targettype=1 },
                            [4] = { atype=12, type=7, distance=2, postype=5, rollback=true },
                            [5] = { atype=1, srctype=2, targettype=4, animid=179, limit=3000, callbacktype=1 },--做动作
                            [6] = { atype=5, buffid=656, bufflv=14, targettype=0, },
                            -- [7] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            -- [8] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=1, usetime=600, limit=3000 },
                            -- [9] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=2, enemy=true },
                            -- [10] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [11] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            -- [12] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=5 },
                            -- [13] = { atype=5, buffid=656, bufflv=8, targettype=0 },
                        }
                    },
                },
            },
            [8] = { name="第三个炸弹 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=31, scale=1.5, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=1, targettype=3 },--记录位置和朝向
                            [3] = { atype=88, targettype=1 },
                            [4] = { atype=12, type=7, distance=2, postype=5, rollback=true },
                            [5] = { atype=1, srctype=2, targettype=4, animid=179, limit=3000, callbacktype=1 },--做动作
                            [6] = { atype=5, buffid=656, bufflv=15, targettype=0, },
                            -- [7] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            -- [8] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=1, usetime=600, limit=3000 },
                            -- [9] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=2, enemy=true },
                            -- [10] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [11] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            -- [12] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=5 },
                            -- [13] = { atype=5, buffid=656, bufflv=9, targettype=0 },
                        }
                    },
                },
            },
            [9] = { name="第四个炸弹 预备", duration=0, overlap=0, property=bit_merge(2,16,32,64), ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=31, scale=1.5, rollback=true },
                            -- [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=1, targettype=3 },--记录位置和朝向
                            [3] = { atype=88, targettype=1 },
                            [4] = { atype=12, type=7, distance=2, postype=5, rollback=true },
                            [5] = { atype=1, srctype=2, targettype=4, animid=179, limit=3000, callbacktype=1 },--做动作
                            [6] = { atype=5, buffid=656, bufflv=16, targettype=0, },
                            -- [7] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            -- [8] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=1, usetime=600, limit=3000 },
                            -- [9] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=2, enemy=true },
                            -- [10] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [11] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            -- [12] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=5 },
                            -- [13] = { atype=15 },
                        }
                    },
                },
            },
            [10] = { name="炸弹伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=277 },
                            [3] = { atype=27, targettype=1, distype=0, distance=4, height=1, type=5, dirtype=5, },
                        }
                    },
                },
            },
            [11] = { name="炸弹属性降低", duration=4000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true },
                            [2] = { atype=3, abilityname="atk_power", rollback=true },
                        }
                    },
                },
            },
            [12] = { name="技能1 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=184, limit=3000, callbacktype=1 },--开始动作
                            [3] = { atype=5, buffid=656, bufflv=2, targettype=0, }
                        }
                    },
                },
            },
            [13] = { name="第1个炸弹 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=2, usetime=600, limit=3000 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=1, enemy=true },
                            [5] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [6] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            [6] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=6, length=0, },
                            [7] = { atype=5, buffid=656, bufflv=7, targettype=0 },
                        }
                    },
                },
            },
            [14] = { name="第2个炸弹 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=2, usetime=600, limit=3000 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=1, enemy=true },
                            [5] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [6] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            [6] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=6, length=0, },
                            [7] = { atype=5, buffid=656, bufflv=8, targettype=0 },
                        }
                    },
                },
            },
            [15] = { name="第3个炸弹 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=2, usetime=600, limit=3000 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=1, enemy=true },
                            [5] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [6] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            [6] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=6, length=0, },
                            [7] = { atype=5, buffid=656, bufflv=9, targettype=0 },
                        }
                    },
                },
            },
            [16] = { name="第4个炸弹 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=183, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=6, srctype=2, targettype=0, effectid=275, callbacktype=1, targetpos=2, usetime=600, limit=3000 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=2, position=1, enemy=true },
                            [5] = { atype=5, buffid=656, bufflv=10, targettype=1 },
                            -- [6] = { atype=5, buffid=656, bufflv=11, targettype=1 },
                            [6] = { atype=6, srctype=6, targettype=0, effectid=276, callbacktype=0, position=6, length=0, },
                            [7] = { atype=15 },
                        }
                    },
                },
            },
            [17] = { name="技能1 伤害击退", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=27, targettype=1, distance=1.5, limit=3000, height=1, type=5, },
                        }
                    },
                },
            },
        },
    },
    [657] = { name="太郎BOSS",
        level = {
            [1] = { name="技能1 扔斧头", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=2, srctype=1, targettype=4, enemy=true, layer=lay_all_role, lengthtype=1 },
                            [3] = { atype=13, buffid=657, bufflv=2, targettype=0, srctype=0, speed=15, fixtime=400 },
                            [4] = { atype=1, srctype=2, targettype=4, animid=674, limit=1500, callbacktype=2 },
                            [5] = { atype=32, type=1, srctype=4, },
                            [6] = { atype=5, buffid=657, bufflv=5, targettype=0, },
                        }
                    },
                },
            },
            [2] = { name="斧头伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                        }
                    },
                },
            },
            [3] = { name="落地伤害+眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 },
                            [2] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
                            [4] = { atype=27, type=5, height=3, targettype=1, distance=4 },
                        }
                    },
                }
            },
            [4] = { name="防御降低", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="def_power", valuetype=1, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=18045, limit=3000, rollback=true, durationtime=0, },
                        }
                    },
                }
            },
            [5] = { name="技能1 预备跳", duration=0, overlap=0, property=bit_merge(2,16,32,64),ignore_anim_end={1,4},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=7, distance=5, postype=5, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=675, limit=1500, callbacktype=1 },
                            [3] = { atype=5, buffid=657, bufflv=6, targettype=0, },
                        }
                    },
                },
            },
            [6] = { name="技能1 跳", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=671, limit=3000, callbacktype=1 },
                            [2] = { atype=14, targettype=0, position=1, usetime=13*33, callbacktype=0, limit=3000,},
                            [3] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=193, position=10, },
                            [4] = { atype=2, srctype=1, targettype=1, radius=5, angle=360, enemy=true, layer=lay_all_role },
                            [5] = { atype=5, buffid=657, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=657, bufflv=4, targettype=0, condition=54, },
                        }
                    },
                },
            },
            [7] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=73, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=670, limit=3000, callbacktype=1, lock=true, rollback=true, notstand=true }, 
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=100,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role },--查找附近目标
                            [2] = { atype=5, buffid=657, bufflv=9, targettype=1 },
                        }
                    },
                },
            },
            [8] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=671, limit=3000, callbacktype=1 },
                            [2] = { atype=14, targettype=0, usetime=429, callbacktype=0, limit=3000, position=3, autoforward=true, },
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, radius=2.5, enemy=true, layer=lay_all_role, },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=195},
                            [6] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=193, position=3, },
                            [7] = { atype=27, targettype=0, distance=1.5, distype=0, height=1, type=5, },
                        }
                    },
                }
            },
            [9] = { name="技能2伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=194 },
                            [3] = { atype=5, buffid=657, bufflv=10, targettype=0 },
                            [4] = { atype=27, targettype=1, height=1, type=5, },
                        }
                    },
                }
            },
            [10] = { name="技能2降低防御", duration=4000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=1, rollback=true},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
        },
    },
    [658] = { name="社团BOSS川村猛",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=929, callbacktype=0 },--做动作
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=400,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=800,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=1200,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=1600,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                    [6] = { activetype=3, triggertype=0, delay=2000,
                        action = {
                            [1] = { atype=5, buffid=658, bufflv=2, targettype=0 },
                        }
                    },
                    [7] = { activetype=3, triggertype=0, delay=2700,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=3, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                },
            },
            [2] = { name="流星拳伤害", duration=450, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=100,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, },
                            [2] = { atype=5, buffid=1, bufflv=2, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=281 },
                        }
                    },
                },
            },
            [3] = { name="技能2", duration=0, overlap=0, property=bit_merge(64), ignore_anim_end={1,5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=12, type=2, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=0, animid=930, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=5, buffid=658, bufflv=4, targettype=0 },
                        }
                    },
                },
            },
            [4] = { name="冲刺", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=0, animid=931, callbacktype=0 },--开始动作
                            [3] = { atype=2, srctype=1, targettype=4, enemy=true, },
                            [4] = { atype=13, buffid=658, bufflv=5, targettype=0, srctype=0, speed=3.5 },
                            [5] = { atype=14, targettype=0, usetime=500, direct=1, distance=7, callbacktype=0, limit=3000 },
                            [6] = { atype=1, srctype=2, targettype=0, animid=932, callbacktype=0 },--开始动作
                        }
                    },
                },
            },
            [5] = { name="冲刺伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=282 },
                        }
                    },
                },
            },
            [6] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true },
                            [2] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=0, animid=933, limit=3000, callbacktype=1 },--开始动作
                            [4] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, },
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [6] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=283 },
                        }
                    },
                },
            },
        },
    },
    [659] = { name="喰種（苹果头）",
        level = {
            [1] = {name="技能1", duration=0, overlap=0, property=bit_merge(64, 32, 16, 2), ignore_anim_end={1,4},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=0, distance=8, rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=938, callbacktype=1, limit=3000, },
                            [3] = { atype=5, targettype=0, buffid=659, bufflv=2, },
                        },
                    },
                },
            },
            [2] = {name="技能1 范围伤害buff", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=939, callbacktype=0, },
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, radius=8,},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=274, },
                            [6] = { atype=27, targettype=0, type=5, height=1 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, radius=7,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=274, },
                            [4] = { atype=27, targettype=0, type=5, height=1 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=2000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, radius=6,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=274, },
                            [4] = { atype=27, targettype=0, type=5, height=1 },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=2500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, radius=5,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=274, },
                            [4] = { atype=27, targettype=0, type=5, height=1 },
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=3500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, radius=4,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=274, },
                            [4] = { atype=27, targettype=0, type=5, height=1 },
                        }
                    },
                },
            },
            [3] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1153, limit=3000, callbacktype=1, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distance=1.5, },
                            [4] = { atype=6, srctype=4, targettype=0, effectid=424, callbacktype=0 },
                            [5] = { atype=5, buffid=659, bufflv=5, targettype=2, },
                        }
                    },
                }
            },
            [4] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=1154, limit=3000, callbacktype=1, },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, layer=lay_all_role, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=1, type=3, distance=1.5, distype=0, },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=424, callbacktype=0 },
                        }
                    },
                }
            },
            [5] = { name="技能2 减速", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                        }
                    },
                }
            },
        },
    },
    [660] = { name="月山习boss",
        level = {
            [1] = {name="技能1 准备", duration=0, overlap=0, property=bit_merge(64, 32, 16, 2), ignore_anim_end={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=0, rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=136, callbacktype=1, limit=3000, },
                            [3] = { atype=5, buffid=660, bufflv=7, targettype=0, },
                            -- [3] = { atype=1, srctype=2, targettype=4, animid=132, callbacktype=0, },
                            -- [4] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, },
                            -- [5] = { atype=24, rollback=true},
                            -- [6] = { atype=5, buffid=660, bufflv=3, targettype=1, },
                            -- [7] = { atype=5, buffid=660, bufflv=4, targettype=0, },
                            -- [8] = { atype=5, buffid=660, bufflv=5, targettype=0, condition=54, },
                        },
                    },
                },
            },
            [2] = {name="技能2 准备", duration=0, overlap=0, property=bit_merge(64,32,16,2), passive_detach_tigger_buff={id=660, lv=6},ignore_anim_end={1,2},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=137, callbacktype=1, limit=3000, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=138, callbacktype=0, },
                            [3] = { atype=25, type=2, value=0.3, },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18039, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
            [3] = {name="技能1 降低格挡+伤害", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1,},
                            [2] = { atype=41, abilityname="parry_rate", valuetype=1, rollback=true,},
                            [3] = { atype=23, targettype=1, distance=4, limit=3000, },
                        },
                    },
                },
            },
            [4] = {name="技能1 免疫控制+伤害", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true,},
                            [2] = { atype=25, type=0, value=0.2,},
                        },
                    },
                },
            },
            [5] = {name="技能1 未命中疲劳", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="atk_power", scale=0.6, rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
            [6] = {name="技能2 打断眩晕", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
            [7] = {name="技能1 发动", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=132, callbacktype=0, },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, },
                            [3] = { atype=24, rollback=true},
                            [4] = { atype=5, buffid=660, bufflv=3, targettype=1, },
                            [5] = { atype=5, buffid=660, bufflv=4, targettype=0, },
                            [6] = { atype=5, buffid=660, bufflv=5, targettype=0, condition=54, },
                        },
                    },
                },
            },
            [8] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=133, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distance=1.5, },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=33, callbacktype=0,},
                            [6] = { atype=5, buffid=660, bufflv=9, targettype=1 },
                        }
                    },
                },
            },
            [9] = { name="技能2 降低移动速度", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0, },
                        }
                    },
                }
            },
        },
    },
    [662] = { name="瓶弟boss",
        level = {
            [1] = {name="技能1", duration=0, overlap=0, property=bit_merge(64,62,16,2), passive_detach_tigger_buff={id=662, lv=4},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, sorttype=6, targetcnt=1,},
                            [2] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=18058, rollback=true, durationtime=0 },--眩晕特效
                            [3] = { atype=1, srctype=2, targettype=4, animid=723, callbacktype=1, limit=3000, },
                            [4] = { atype=14, targettype=2, callbacktype=0, usetime=100, finaltorward=true, limit=3000,},
                            [5] = { atype=1, srctype=2, targettype=4, animid=724, callbacktype=0, },
                            [6] = { atype=5, buffid=662, bufflv=3, targettype=1, },
                        },
                    },
                },
            },
            [2] = {name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=0, rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=725, callbacktype=1, limit=3000, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=726, callbacktype=0,},
                            [4] = { atype=5, buffid=662, bufflv=5, targettype=0, },
                            [5] = { atype=5, buffid=662, bufflv=6, targettype=0, },
                        },
                    },
                },
            },
            [3] = {name="技能1 伤害+混乱", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=7, effect_type=6, rollback=true, },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
            [4] = {name="技能1 打断扣血", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=1, persent=0.1, },
                        },
                    },
                },
            },
            [5] = {name="技能2 提升速度", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=62, abilityname="attack_speed", rollback=true, },
                        },
                    },
                },
            },
            [6] = {name="技能2 能量场", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = { 
                            [1] = { atype=32, type=0,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=271,},--
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=50,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, enemy=true, layer=lay_all_role, position=2, },
                            [2] = { atype=5, buffid=662, bufflv=7, targettype=1 },--添加能量场伤害
                            [3] = { atype=5, buffid=662, bufflv=8, targettype=1 },--添加能量场恐惧
                        }
                    },
                },
            },
            [7] = {name="技能2 伤害", duration=950, overlap=4, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                        },
                    },
                },
            },
            [8] = {name="技能2 恐惧", duration=3000, overlap=5, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=3, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18059, rollback=true, durationtime=0, attentionaction=1 },
                        },
                    },
                },
            },
            [9] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=2, effectid=436, callbacktype=0, position=3, },
                            [2] = { atype=14, targettype=6, callbacktype=0, usetime=100, offset=2, offsettype=1, finaltorward=1, distance=3, limit=3000, },--瞬移到身后
                            [3] = { atype=1, srctype=2, targettype=4, animid=724, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true, radius=3 },--查找附近目标
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [6] = { atype=27, targettype=0, type=5, },
                            [7] = { atype=6, srctype=5, targettype=0, effectid=431, callbacktype=0, },
                        }
                    },
                },
            },
            [10] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=726, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true,},
                            [3] = { atype=5, buffid=662, bufflv=11, targettype=1 },
                        }
                    },
                }
            },
            [11] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=31, scale=1.4, odds=100, rollback=true, condition=76},
                            [2] = { atype=4, type=0, infoindex=1 }, --伤害
                            [3] = { atype=6, srctype=2, targettype=0, effectid=432, callbacktype=0, },
                            [4] = { atype=27, targettype=1, type=3, distance=1, },
                        }
                    },
                }
            },
        },
    },
    [661] = { name="中岛康健BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=940, callbacktype=0 },
                            [2] = { atype=5, buffid=661, bufflv=2, targettype=0, },
                            [3] = { atype=5, buffid=661, bufflv=3, targettype=0, overlap=6 },
                            [4] = { atype=5, buffid=661, bufflv=5, targettype=0, },
                            [5] = { atype=5, buffid=661, bufflv=6, targettype=0, },
                            [6] = { atype=5, buffid=661, bufflv=7, targettype=0, },
                            [7] = { atype=5, buffid=661, bufflv=8, targettype=0, },
                            [8] = { atype=5, buffid=661, bufflv=9, targettype=0, },
                            [9] = { atype=5, buffid=661, bufflv=10, targettype=0, },
                        }
                    },
                },
            },
            [2] = { name="无敌", duration=-1, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=55, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=19010, callbacktype=0, rollback=true, durationtime=0 },
                        }
                    },
                },
            },
            [3] = { name="无敌计数", duration=-1, overlap=1, property=bit_merge(64),
            },
            [4] = { name="减少无敌计数", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=11, buffid=661, bufflv=3, targettype=0, immediately=false },
                            [2] = { atype=11, buffid=661, bufflv=2, targettype=0, condition=58 },
                        }
                    },
                },
            },
            [5] = { name="小兵1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=2.5, aoffset=-40, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
            [6] = { name="小兵2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=1.9, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
            [7] = { name="小兵3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=2.5, aoffset=40, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
            [8] = { name="小兵4", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=4.5, aoffset=-20, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
            [9] = { name="小兵5", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=4.2, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
            [10] = { name="小兵6", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, offset=4.5, aoffset=20, dirtype=0 },
                            [2] = { atype=90, monsterid=31000004, postype=0, deadcreatorbuff={661,4}, groupname="zhong_dao_kang_jian_xiao_bing" },
                        }
                    },
                },
            },
        },
    },
    [663] = { name="杰森BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2), passive_detach_tigger_buff={id=651, lv=4}, ignore_anim_end={1,7},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=17019, rollback=true, durationtime=0, },--可打断特效
                            [3] = { atype=12, type=2, rollback=true },
                            [4] = { atype=1, srctype=2, targettype=4, animid=258, limit=3000, callbacktype=1 },--做动作
                            [5] = { atype=40, modelid=80001008 },--变身
                            [6] = { atype=5, buffid=663, bufflv=6, targettype=0 },
                            [7] = { atype=5, buffid=663, bufflv=2, targettype=0 },
                        }
                    },
                },
            },
            [2] = { name="冲刺", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },--查找附近目标,不能预先
                            [2] = { atype=13, buffid=663, bufflv=3, targettype=0, srctype=0, speed=16 }, --加BUFF根据距离速度算延迟
                            [3] = { atype=1, srctype=2, targettype=0, animid=1155, callbacktype=0 },--做动作
                            [4] = { atype=14, targettype=0, usetime=500, direct=1, distance=7, callbacktype=0, limit=3000 },
                            [5] = { atype=1, srctype=2, targettype=0, animid=1156, callbacktype=0 },--做动作
                            -- [5] = { atype=15 },
                        }
                    },
                }
            },
            [3] = { name="伤害+眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                            [4] = { atype=23, targettype=1, distance=7, dirtype=2 },
                        }
                    },
                }
            },
            [4] = { name="打断眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                },
            },
            [5] = { name="技能2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=91, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=259, limit=3000, callbacktype=1 },--做动作
                        }
                    },
                },
            },
            [6] = { name="半赫者形态", duration=-1, overlap=0, property=bit_merge(64),
            },
            [7] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1, condition=60, --处于半赫者形态
                        action = {
                            [1] = { atype=86, scale=1.3, },
                        }
                    },
                    [2] = { activetype=0, triggertype=0, --condition=60, group=1,--处于半赫者形态
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=258, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=24, rollback=true },--记录伤害
                            [3] = { atype=2, usetype=0, typeindex=142 },--查找扇形目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=23, targettype=0,distance=1},
                            [6] = { atype=25, type=0, value=0.2 },--恢复生命
                        }
                    },
                },
            },
            [8] = { name="新技能1", duration=0, overlap=0, property=bit_merge(64,128,256,512), passive_detach_tigger_buff={id=651, lv=4}, 
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=17019, rollback=true, durationtime=0, },--可打断特效
                            [3] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true },
                            [4] = { atype=1, srctype=2, targettype=4, animid=1350, limit=3000, callbacktype=1 },--做动作
                            [5] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },--查找附近目标,不能预先
                            [6] = { atype=13, buffid=663, bufflv=11, targettype=0, srctype=0, speed=16 }, --加BUFF根据距离速度算延迟
                            [7] = { atype=14, targettype=0, usetime=594, direct=1, distance=7, callbacktype=0, limit=3000 },
                        }
                    },
                },
            },
            [9] = { name="新技能2", duration=0, overlap=0, property=bit_merge(64,128,256,512), 
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1351, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标,不能预先
                            [4] = { atype=5, targettype=1, buffid=663, bufflv=10, },
                        }
                    },
                },
            },
            [10] = { name="新技能2 吸人", duration=0, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, }, 
                            [2] = { atype=14, targettype=3, usetime=300, offset=1, offsettype=0, callbacktype=0, limit=3000,},--吸引位置
                        }
                    },
                },
            },
            [11] = { name="新技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [2] = { atype=23, targettype=1, distance=7, dirtype=2 },
                        }
                    },
                }
            },
        },
    },
    [664] = { name="喰种精英 80005004",
        level = {
            [1] = {name="技能1", duration=0, overlap=0, property=bit_merge(64,128,256,512),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1324, callbacktype=1, limit=3000, },
                            [3] = { atype=2, srctype=1, targettype=4, width=3, enemy=true, },
                            [4] = { atype=5, targettype=1, buffid=664, bufflv=2, },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                            [6] = { atype=20, delay=33*(65-52), },
                            [7] = { atype=2, srctype=1, targettype=4, width=3, enemy=true, },
                            [8] = { atype=5, targettype=1, buffid=664, bufflv=2, },
                            [9] = { atype=23, targettype=0, distance=1.5, },
                            [10] = { atype=20, delay=33*(87-65), },
                            [11] = { atype=2, srctype=1, targettype=4, width=6, enemy=true, },
                            [12] = { atype=5, targettype=1, buffid=664, bufflv=2, },
                            [13] = { atype=23, targettype=0, distance=1.5, },
                        },
                    },
                },
            },
            [2] = {name="技能1 眩晕+伤害", duration=1000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
                            [4] = { atype=6, srctype=2, targettype=0, effectid=475, callbacktype=0 },
                        },
                    },
                },
            },
        },
    },
    [665] = { name="西尾锦Boss",
        level = {
            [1] = {name="技能1", duration=0, overlap=0, property=bit_merge(64,128,256,512),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, targettype=2, },
                            [2] = { atype=12, type=7, postype=1, rollback=true, limit=3000, hideprepared=true },
                            [3] = { atype=1, srctype=2, targettype=0, animid=1333, callbacktype=1, limit=3000, position=2, },
                            [4] = { atype=14, targettype=0, usetime=495, position=5, limit=3000, callbacktype=0, },--位移
                            [5] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=497, position=5 },--践踏特效
                            [6] = { atype=2, srctype=3, targettype=1, angle=360, enemy=true, position=2},
                            [7] = { atype=5, targettype=1, buffid=665, bufflv=2, },
                        },
                    },
                },
            },
            [2] = {name="技能1 伤害+击飞", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=27, targettype=1, distance=4, height=1, type=5, },
                        },
                    },
                },
            },
            [3] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=0 },
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true},
                            [3] = { atype=13, buffid=665, bufflv=4, targettype=0, srctype=0, speed=20 }, --加伤害BUFF根据距离速度算延迟 
                        }
                    }
                }
            },
            [4] = { name="拷贝技能1伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=1, delay=50,
                         action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=12 },--伤害特效
                            [3] = { atype=23, targettype=1, distance=1.5 },
                        }
                    }
                }
            },
        },
    },
    [666] = { name="喰种精英 80005005",
        level = {
            [1] = {name="技能1", duration=0, overlap=0, property=bit_merge(64,128,256,512),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1332, callbacktype=1, limit=3000, },
                            [3] = { atype=5, targettype=0, buffid=666, bufflv=4, rollback=true, },
                            [4] = { atype=2, srctype=1, targettype=4, enemy=true, },
                            [5] = { atype=13, buffid=666, bufflv=2, targettype=0, srctype=0, speed=16 }, --加BUFF根据距离速度算延迟
                            [6] = { atype=14, targettype=0, speed=16, distance=7, limit=3000, offsettype=0, direct=1, callbacktype=0},--位移
                            
                        },
                    },
                },
            },
            [2] = {name="技能1 眩晕+伤害", duration=1000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=23, targettype=1, distance=7, limit=3000,},--位移
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=480, },
                        },
                    },
                },
            },
            [3] = {name="技能1 地面效果", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = {activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=479, rollback=true, durationtime=0, },--眩晕特效
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=100,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, enemy=true, position=2, radius=1, },
                            [2] = { atype=5, targettype=1, buffid=666, bufflv=5, },
                        },
                    },
                },
            },
            [4] = {name="技能1 buff", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=100,
                        action = {
                            [1] = { atype=5, buffid=666, bufflv=3, targettype=0, },
                        },
                    },
                },
            },
            [5] = {name="技能1 地面伤害", duration=500, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, infoindex=2, type=0, },
                        },
                    },
                },
            },
        },
    },
    [667] = { name="精英怪jy_s321BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64), ignore_anim_end={1,8}, passive_detach_tigger_buff={id=667, lv=5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=0, postype=2, minradiusscale=30, times=1},
                            [2] = { atype=12, type=7, postype=4, posindex=1, distance=3, rollback=true, limit=3000, hideprepared=true},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1325, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=14, targettype=0, callbacktype=0, usetime=396, limit=3000, position=6, autoforward=true},
                            [5] = { atype=2, srctype=3, targettype=1, radius=3, position=5, position_offset=1, angle=360, layer=lay_all_role},
                            [6] = { atype=5, buffid=667, bufflv=2, targettype=1 },
                            [7] = { atype=20, delay=500,},
                            [8] = { atype=5, buffid=667, bufflv=3, targettype=0 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
            [3] = { name="第二次攻击", duration=0, overlap=0, property=bit_merge(512,256,128,64), ignore_anim_end={1,8}, passive_detach_tigger_buff={id=667, lv=5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=0, postype=2, minradiusscale=30, times=1},
                            [2] = { atype=12, type=7, postype=4, posindex=1, distance=3, rollback=true, limit=3000, hideprepared=true},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1325, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=14, targettype=0, callbacktype=0, usetime=396, limit=3000, position=6, autoforward=true},
                            [5] = { atype=2, srctype=3, targettype=1, radius=3, position=5, position_offset=1, angle=360, layer=lay_all_role},
                            [6] = { atype=5, buffid=667, bufflv=2, targettype=1 },
                            [7] = { atype=20, delay=500,},
                            [8] = { atype=5, buffid=667, bufflv=4, targettype=0 },
                        }
                    },
                },
            },
            [4] = { name="第三次攻击", duration=0, overlap=0, property=bit_merge(512,256,128,64), passive_detach_tigger_buff={id=667, lv=5},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=0, postype=2, minradiusscale=30, times=1},
                            [2] = { atype=12, type=7, postype=4, posindex=1, distance=3, rollback=true, limit=3000, hideprepared=true},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1345, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=14, targettype=0, callbacktype=0, usetime=396, limit=3000, position=6, autoforward=true},
                            [5] = { atype=2, srctype=3, targettype=1, radius=3, position=5, position_offset=1, angle=360, layer=lay_all_role},
                            [6] = { atype=5, buffid=667, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [5] = { name="眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
        },
    },
    [668] = { name="亚门BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1334, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=27, targettype=0, height=1, type=5,},
                            [6] = { atype=5, buffid=668, bufflv=2, targettype=0 },

                        }
                    },
                },
            },
            [2] = { name="伤害周围", duration=3200, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [3] = { atype=27, targettype=0, height=1.5, type=5 },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                        },
                    },
                },
            },
            [3] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=41, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 }, --加伤害BUFF
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=333 },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        }
                    }
                }
            },
            [4] = { name="拷贝技能3", duration=4900, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=40, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=335, rollback=true, durationtime=0 },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [3] = { atype=6, srctype=5, targettype=0, effectid=336, callbacktype=0 },
                            [4] = { atype=23, targettype=0, distance=1, },
                        },
                    },
                }
            },
        },
    },
    [669] = { name="中岛康健BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=1, postype=2, times=1,},
                            [2] = { atype=104, savetype=1, postype=0, times=4, clear=false},
                            [3] = { atype=12, type=7, distance=2, postype=6, posindex=1, rollback=true, limit=3000, hideprepared=true},
                            [4] = { atype=12, type=8, distance=2, postype=6, posindex=2, rollback=true, limit=3000, hideprepared=true},
                            [5] = { atype=12, type=9, distance=2, postype=6, posindex=3, rollback=true, limit=3000, hideprepared=true},
                            [6] = { atype=12, type=10, distance=2, postype=6, posindex=4, rollback=true, limit=3000, hideprepared=true},
                            [7] = { atype=12, type=11, distance=2, postype=6, posindex=5, rollback=true, limit=3000, hideprepared=true},
                            [8] = { atype=1, srctype=2, targettype=4, animid=1335, limit=3000, callbacktype=1 },--动作
                            [9] = { atype=5, buffid=669, bufflv=2, targettype=0 },

                        }
                    },
                },
            },
            [2] = { name="炸弹落下", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=7, distance=2, postype=6, posindex=1, rollback=true},
                            [2] = { atype=20, delay=400},
                            [3] = { atype=6, srctype=6, targettype=0, position=9, posindex=1, effectid=466, callbacktype=0 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=1,},
                            [5] = { atype=5, buffid=669, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=669, bufflv=4, targettype=1 },
                        }
                    },
                    [2] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=8, distance=2, postype=6, posindex=2, rollback=true},
                            [2] = { atype=20, delay=600},
                            [3] = { atype=6, srctype=6, targettype=0, position=9, posindex=2, effectid=466, callbacktype=0 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=2,},
                            [5] = { atype=5, buffid=669, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=669, bufflv=4, targettype=1 },
                        }
                    },
                    [3] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=9, distance=2, postype=6, posindex=3, rollback=true},
                            [2] = { atype=20, delay=700},
                            [3] = { atype=6, srctype=6, targettype=0, position=9, posindex=3, effectid=466, callbacktype=0 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=3,},
                            [5] = { atype=5, buffid=669, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=669, bufflv=4, targettype=1 },
                        }
                    },
                    [4] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=10, distance=2, postype=6, posindex=4, rollback=true},
                            [2] = { atype=20, delay=800},
                            [3] = { atype=6, srctype=6, targettype=0, position=9, posindex=4, effectid=466, callbacktype=0 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=4,},
                            [5] = { atype=5, buffid=669, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=669, bufflv=4, targettype=1 },
                        }
                    },
                    [5] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=11, distance=2, postype=6, posindex=5, rollback=true},
                            [2] = { atype=20, delay=500},
                            [3] = { atype=6, srctype=6, targettype=0, position=9, posindex=5, effectid=466, callbacktype=0 },
                            [4] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=5,},
                            [5] = { atype=5, buffid=669, bufflv=3, targettype=1 },
                            [6] = { atype=5, buffid=669, bufflv=4, targettype=1 },
                        }
                    },
                },
            },
            [3] = { name="伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        }
                    },
                },
            },  
            [4] = { name="眩晕", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                },
            },  
            [5] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=479, limit=3000, callbacktype=2, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distance=1.5, },
                        }
                    },
                }
            },
            [6] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=480, limit=3000, callbacktype=1, },
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true, arraytype=0, },
                            [3] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [5] = { atype=27, targettype=3, type=3, distance=1, },
                            [6] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*19,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [3] = { atype=27, targettype=3, type=3, distance=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*33,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [3] = { atype=27, targettype=3, type=3, distance=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        },
                    },
                }
            },
        },
    },
    [670] = { name="万丈数一BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1336, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [4] = { atype=5, buffid=670, bufflv=2, targettype=1},
                            [5] = { atype=20, delay=1500},
                            [6] = { atype=25, type=2, value=0.5 },
                            [7] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=19006,},--
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
            [3] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=690, limit=3000, callbacktype=1,},
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [4] = { atype=6, srctype=5, targettype=0, effectid=419, callbacktype=0, },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        },
                    },
                },
            },
            [4] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=692, limit=3000, callbacktype=1,},
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=670, bufflv=5, targettype=1, }, -- 添加伤害
                        },
                    },
                },
            },
            [5] = { name="拷贝技能3 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=421, },
                            [3] = { atype=23, targettype=1, distance=1.5, },
                        },
                    },
                },
            },
        },
    },
    [671] = { name="精英怪s506BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1326, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=5, buffid=671, bufflv=2, targettype=0},
                        }
                    },
                },
            },
            [2] = { name="原地旋转", duration=2700, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1},
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=300,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [2] = { atype=27, targettype=0, type=6, height=1 },
                        }
                    },
                },
            },
        },
    },
    [672] = { name="雾岛绚都BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64), ignore_anim_end={1,6},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1337, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=4, layer=lay_all_role,},
                            [4] = { atype=5, buffid=672, bufflv=2, targettype=1 },
                            [5] = { atype=20, delay=728},
                            [6] = { atype=5, buffid=672, bufflv=3, targettype=0 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=23, targettype=1, distance=2,},
                        },
                    },
                },
            },
            [3] = { name="第二击", duration=0, overlap=0, property=bit_merge(512,256,128,64), ignore_anim_end={1,7},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=16, targettype=1 },
                            [2] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1337, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=2, srctype=1, targettype=4, layer=lay_all_role,},
                            [5] = { atype=5, buffid=672, bufflv=2, targettype=1 },
                            [6] = { atype=20, delay=728},
                            [7] = { atype=5, buffid=672, bufflv=4, targettype=0 },
                        }
                    },
                },
            },
            [4] = { name="第三击", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=16, targettype=1 },
                            [2] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1343, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=2, srctype=1, targettype=4, layer=lay_all_role,},
                            [5] = { atype=5, buffid=672, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [11] = { name="拷贝怪物用技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=73, rollback=true },
                            -- [2] = { atype=6, srctype=2, targettype=0, effectid=197, limit=3000, callbacktype=0, rollback=true, durationtime=0,},
                            [1] = { atype=32, type=0, targettype=2, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=702, limit=3000, callbacktype=1, },
                            [3] = { atype=6, srctype=6, targettype=0, effectid=329, limit=3000, callbacktype=0, position=0,},
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*26,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*30,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*33,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*38,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=33*42,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=33*46,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, radius=1, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=672, bufflv=15, targettype=1, },
                            [3] = { atype=5, buffid=672, bufflv=12, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                },
            },
            [12] = { name="技能2 爆伤状态", duration=-1, overlap=8, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18079, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [13] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=703, limit=3000, callbacktype=0,},
                            [3] = { atype=2, srctype=1, targettype=4, angle=360, layer=lay_all_role, enemy=true},
                            [4] = { atype=13, buffid=672, bufflv=14, targettype=0, srctype=0, speed=10}
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=366,
                        action = {
                            [1] = { atype=54, count=3, x=1, y=1.5, z=1, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=600,
                        action = {
                            [1] = { atype=54, count=3, x=1, y=1.5, z=1, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        }
                    },
                }
            },
            [14] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=3, triggertype=0,delay=1,
                        action = {
                            [1] = { atype=61, condition=71,},
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                            [3] = { atype=27, targettype=1, dirtype=3, distance=2, distype=0, type=3 },
                            [4] = { atype=6, srctype=2, targettype=0, effectid=328, callbacktype=0 },
                            [5] = { atype=11, buffid=672, bufflv=12, targettype=0, },
                        }
                    },
                }
            },
            [15] = { name="定身+伤害", duration=500, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                            [3] = { atype=4, type=0, infoindex=1 },
                        }
                    },
                }
            },
        },
    },
    [673] = { name="精英怪jy_s325BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1327, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role},
                            [4] = { atype=5, buffid=673, bufflv=2, targettype=1 },
                            [5] = { atype=20, delay=400},
                            [6] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=5, buffid=673, bufflv=2, targettype=1 },
                            [9] = { atype=20, delay=400},
                            [10] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [12] = { atype=5, buffid=673, bufflv=2, targettype=1 },
                            [13] = { atype=20, delay=400},
                            [14] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [15] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [16] = { atype=5, buffid=673, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
        },
    },
    [674] = { name="野吕BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1338, limit=3000, callbacktype=1 },--动作
                        }
                    },
                    [2] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=2, targettype=5, offset=1.5, },
                            [2] = { atype=12, type=7, distance=1.5, postype=3, hideprepared=true, limit=3000, rollback=true},
                            [3] = { atype=20, delay=1584},
                            [4] = { atype=6, effectid=468, srctype=6, targettype=0, callbacktype=0, position=8,},
                            [5] = { atype=2, srctype=3, targettype=1, radius=1.5, angle=360, position=4, layer=lay_all_role},
                            [6] = { atype=5, buffid=674, bufflv=2, targettype=1 },
                        }
                    },
                    [3] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=2, targettype=5, offset=4.5, },
                            [2] = { atype=12, type=8, distance=1.5, postype=3, hideprepared=true, limit=3000, rollback=true},
                            [3] = { atype=20, delay=1784},
                            [4] = { atype=6, effectid=468, srctype=6, targettype=0, callbacktype=0, position=8,},
                            [5] = { atype=2, srctype=3, targettype=1, radius=1.5, angle=360, position=4, layer=lay_all_role},
                            [6] = { atype=5, buffid=674, bufflv=2, targettype=1 },
                        }
                    },
                    [4] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=2, targettype=5, offset=7.5, },
                            [2] = { atype=12, type=9, distance=1.5, postype=3, hideprepared=true, limit=3000, rollback=true},
                            [3] = { atype=20, delay=1984},
                            [4] = { atype=6, effectid=468, srctype=6, targettype=0, callbacktype=0, position=8,},
                            [5] = { atype=2, srctype=3, targettype=1, radius=1.5, angle=360, position=4, layer=lay_all_role},
                            [6] = { atype=5, buffid=674, bufflv=2, targettype=1 },
                        }
                    },
                    [5] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=2, targettype=5, offset=10.5, },
                            [2] = { atype=12, type=10, distance=1.5, postype=3, hideprepared=true, limit=3000, rollback=true},
                            [3] = { atype=20, delay=2184},
                            [4] = { atype=6, effectid=468, srctype=6, targettype=0, callbacktype=0, position=8,},
                            [5] = { atype=2, srctype=3, targettype=1, radius=1.5, angle=360, position=4, layer=lay_all_role},
                            [6] = { atype=5, buffid=674, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1.5 },
                        },
                    },
                },
            },
        },
    },
    [675] = { name="篠原幸纪BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1342, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=4, layer=lay_all_role,},
                            [4] = { atype=5, buffid=675, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
        },
    },
    [676] = { name="黑磐岩BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1346, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,},
                            [4] = { atype=5, buffid=676, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
        },
    },
    [677] = { name="精英怪h502BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=3, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1328, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                            [6] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [7] = { atype=23, targettype=0, distance=1 },
                            [8] = { atype=20, delay=396},
                            [9] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [10] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [11] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [12] = { atype=23, targettype=0, distance=1 },
                            [13] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                            [14] = { atype=20, delay=333},
                            [15] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [16] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [17] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [18] = { atype=23, targettype=0, distance=1 },
                            [19] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                            [20] = { atype=20, delay=660},
                            [21] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [22] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [23] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [24] = { atype=23, targettype=0, distance=1 },
                            [25] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                            [26] = { atype=20, delay=297},
                            [27] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [28] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [29] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [30] = { atype=23, targettype=0, distance=1 },
                            [31] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                            [32] = { atype=20, delay=333},
                            [33] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [34] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [35] = { atype=5, buffid=677, bufflv=2, targettype=1 },
                            [36] = { atype=23, targettype=0, distance=1 },
                            [37] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0,},
                        }
                    },
                },
            },
            [2] = { name="眩晕", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
        },
    },
    [678] = { name="精英怪s501BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64), passive_detach_tigger_buff={id=678, lv=3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=0, postype=2, times=1 },
                            [2] = { atype=104, savetype=0, postype=0, minradiusscale=30, times=2 },
                            [3] = { atype=12, type=7, postype=4, posindex=1, distance=3, rollback=true},
                            [4] = { atype=12, type=8, postype=4, posindex=2, distance=3, rollback=true},
                            [5] = { atype=12, type=9, postype=4, posindex=3, distance=3, rollback=true},
                            [6] = { atype=1, srctype=2, targettype=4, animid=1329, limit=3000, callbacktype=1 },--动作
                            [7] = { atype=105, postype=0, posindex=0,},
                            [8] = { atype=20, delay=100},
                            [9] = { atype=1, srctype=2, targettype=4, animid=1330, limit=3000, callbacktype=1 },--动作
                            [10] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, layer=lay_all_role},
                            [11] = { atype=5, buffid=678, bufflv=2, targettype=1 },
                            [12] = { atype=20, delay=500},
                            [13] = { atype=105, postype=0, posindex=0,},
                            [14] = { atype=20, delay=100},
                            [15] = { atype=1, srctype=2, targettype=4, animid=1330, limit=3000, callbacktype=1 },--动作
                            [16] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, layer=lay_all_role},
                            [17] = { atype=5, buffid=678, bufflv=2, targettype=1 },
                            [18] = { atype=20, delay=500},
                            [19] = { atype=105, postype=0, posindex=0,},
                            [20] = { atype=20, delay=100},
                            [21] = { atype=1, srctype=2, targettype=4, animid=1344, limit=3000, callbacktype=1 },--动作
                            [22] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, layer=lay_all_role},
                            [23] = { atype=5, buffid=678, bufflv=2, targettype=1 },
                            --[3] = { atype=2, srctype=1, targettype=4, layer=lay_all_role,},
                            --[4] = { atype=5, buffid=675, bufflv=2, targettype=1 },
                        }
                    },
                },
            },
            [2] = { name="伤害+击飞", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        },
                    },
                },
            },
            [3] = { name="眩晕", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        },
                    },
                },
            },
        },
    },
    [679] = { name="精英怪h303BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=3, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1331, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role,},
                            [4] = { atype=13, buffid=679, bufflv=2, targettype=0, srctype=0, speed=13,},
                        }
                    },
                },
            },
            [2] = { name="伤害+击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=23, targettype=1, distance=4,},
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=462,}
                        },
                    },
                },
            },
        },
    },
    [680] = { name="泷泽政道BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64), passive_detach_tigger_buff={id=680, lv=3},
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=3, rollback=true, limit=3000, hideprepared=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=1339, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role},
                            [4] = { atype=5, buffid=680, bufflv=2, targettype=1,},
                            [5] = { atype=5, buffid=680, bufflv=4, targettype=0,},
                        }
                    },
                },
            },
            [2] = { name="伤害+击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=23, targettype=1, distance=1,},
                        },
                    },
                },
            },
            [3] = { name="打断后灼烧", duration=4200, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                        },
                    },
                },
            },
            [4] = { name="火焰陷阱", duration=4200, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, srctype=2, },
                            [2] = { atype=6, srctype=6, position=5, direct=3, targettype=0, effectid=478, callbacktype=0, durationtime=0, rollback=true},
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=2, srctype=3, position=2, direct=2, targettype=1, angle=120,},
                            [2] = { atype=5, buffid=1, bufflv=2, targettype=1,},
                        },
                    },
                },
            },
            [5] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=289, limit=3000, callbacktype=2 },  --先发射
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2, },
                            [3] = { atype=23, targettype=2, distance=1.5, },
                        }
                    },
                },
            },
            [6] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=290, limit=3000, callbacktype=1 },  --先发射
                            [2] = { atype=20, delay=200, },
                            [3] = { atype=2, srctype=3, targettype=2, radius=2, angle=360, position=3, position_offset=3.7, layer=lay_all_role, enemy=true},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [5] = { atype=27, targettype=0, height=1, type=5 },
                            [6] = { atype=5, buffid=680, bufflv=7, targettype=0 },
                            [7] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=77, },
                        }
                    },
                }
            },
            [7] = { name="瓦斯雾", duration=4200, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, offset=3.7 },--记录前方位置
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=2, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=1, bufflv=2, targettype=1,},
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=77, },
                        }
                    },
                }
            },
        },
    },
    [681] = { name="地行甲乙BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=1, targettype=5 },
                            [2] = { atype=12, type=2, rollback=true,},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1340, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=14, targettype=0, direct=1, position=1, speed=15, callbacktype=2, abuffid=681, abufflv=2}
                        }
                    },
                },
            },
            [2] = { name="持续伤害", duration=4000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=23, targettype=1, distance=2, dirtype=1,},
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                        }
                    },
                },
            },
            [3] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1173, limit=3000, callbacktype=1, },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distance=1.5, },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=448, callbacktype=0 },
                        }
                    },
                }
            },
            [4] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=1174, limit=3000, callbacktype=1, },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=449, callbacktype=0 },
                            [5] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                            [6] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                }
            },
        },
    },
    [682] = { name="五里美乡BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=2 },
                            [2] = { atype=12, type=7, distance=4, rollback=true, postype=1, hideprepared=true, limit=3000, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1358, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=6, srctype=6, targettype=0, effectid=489, callbacktype=0, position=5, },
                            [5] = { atype=20, delay=400, },
                            [6] = { atype=2, srctype=3, radius=4, targettype=1, position=2, angle=360, layer=lay_all_role, enemy=true,},
                            [7] = { atype=5, buffid=682, bufflv=4, targettype=1, },
                            [8] = { atype=5, buffid=682, bufflv=2, targettype=0, },
                        }
                    },
                },
            },
            [2] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=2 },
                            [2] = { atype=12, type=7, distance=4, rollback=true, postype=1, hideprepared=true, limit=3000, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1359, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=6, srctype=6, targettype=0, effectid=489, callbacktype=0, position=5, },
                            [5] = { atype=20, delay=400, },
                            [6] = { atype=2, srctype=3, radius=4, targettype=1, position=2, angle=360, layer=lay_all_role, enemy=true,},
                            [7] = { atype=5, buffid=682, bufflv=4, targettype=1, },
                            [8] = { atype=5, buffid=682, bufflv=3, targettype=0, },
                        }
                    },
                },
            },
            [3] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=2 },
                            [2] = { atype=12, type=7, distance=4, rollback=true, postype=1, hideprepared=true, limit=3000, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1360, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=6, srctype=6, targettype=0, effectid=489, callbacktype=0, position=5, },
                            [5] = { atype=20, delay=400, },
                            [6] = { atype=2, srctype=3, radius=4, targettype=1, position=2, angle=360, layer=lay_all_role, enemy=true,},
                            [7] = { atype=5, buffid=682, bufflv=4, targettype=1, },
                        }
                    },
                },
            },
            [4] = { name="伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=490},
                            [3] = { atype=27, targettype=1, type=5, height=1 },
                        }
                    },
                },
            },
            [5] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=591, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=23, targettype=0, distance=1.5 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=408 },
                        }
                    },
                }
            },
            [6] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=593, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=5, targettype=1, radius=2.5, angle=360, includeself=true, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=23, targettype=0, distance=1, },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                            [6] = { atype=20, delay=3*33, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [8] = { atype=23, targettype=0, distance=1, },
                            [9] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                            [10] = { atype=20, delay=25*33, },
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [12] = { atype=23, targettype=0, distance=1, },
                            [13] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                        }
                    },
                },
            },
        },
    },
    [683] = { name="笛口凉子BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=104, savetype=1, postype=4, offset=4, offset_begin=2, times=4,},
                            [2] = { atype=12, type=7, distance=1, postype=6, posindex=1, hideprepared=true, limit=3000, rollback=true},
                            [3] = { atype=12, type=8, distance=1, postype=6, posindex=2, hideprepared=true, limit=3000, rollback=true},
                            [4] = { atype=12, type=9, distance=1, postype=6, posindex=3, hideprepared=true, limit=3000, rollback=true},
                            [5] = { atype=12, type=10, distance=1, postype=6, posindex=4, hideprepared=true, limit=3000, rollback=true},
                            [6] = { atype=1, srctype=2, targettype=4, animid=1361, limit=3000, callbacktype=1 },--动作
                            [7] = { atype=5, buffid=683, bufflv=2, targettype=0, },
                            [8] = { atype=20, delay=5*33},
                            [9] = { atype=5, buffid=683, bufflv=3, targettype=0, },
                            [10] = { atype=20, delay=6*33},
                            [11] = { atype=5, buffid=683, bufflv=4, targettype=0, },
                            [12] = { atype=20, delay=6*33},
                            [13] = { atype=5, buffid=683, bufflv=5, targettype=0, },
                        }
                    },
                },
            },
            [2] = { name="持续伤害", duration=1300, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=6, effectid=491, srctype=6, targettype=0, callbacktype=0, position=9, posindex=1, },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=250,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=1, layer=lay_all_role},
                            [2] = { atype=5, buffid=683, bufflv=6, targettype=1 },
                        },
                    },
                },
            },
            [3] = { name="持续伤害", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=6, effectid=491, srctype=6, targettype=0, callbacktype=0, position=9, posindex=2, },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=250,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=2, layer=lay_all_role},
                            [2] = { atype=5, buffid=683, bufflv=6, targettype=1 },
                        },
                    },
                },
            },
            [4] = { name="持续伤害", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=6, effectid=491, srctype=6, targettype=0, callbacktype=0, position=9, posindex=3, },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=250,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=3, layer=lay_all_role},
                            [2] = { atype=5, buffid=683, bufflv=6, targettype=1 },
                        },
                    },
                },
            },
            [5] = { name="持续伤害", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=6, effectid=491, srctype=6, targettype=0, callbacktype=0, position=9, posindex=4, },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=250,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=6, position_offset=4, layer=lay_all_role},
                            [2] = { atype=5, buffid=683, bufflv=6, targettype=1 },
                        },
                    },
                },
            },
            [6] = { name="伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=492, },--眩晕特效
                            [3] = { atype=27, targettype=1, type=6, height=1 },
                        },
                    },
                },
            },
            [7] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=237, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--添加治疗BUFF
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=406,},--
                            [5] = { atype=27, targettype=0, height=1, type=5, },
                        }
                    },
                }
            },
            [8] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=239, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=683, bufflv=9, targettype=1, },
                        }
                    },
                }
            },
            [9] = { name="拷贝技能3 伤害+buff", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=407,},--
                            [3] = { atype=23, targettype=1, distance=1.5, },
                            [4] = { atype=5, buffid=683, bufflv=10, targettype=0, actionodds=0.3, },
                            [5] = { atype=5, buffid=683, bufflv=11, targettype=0, actionodds=0.3, },
                            [6] = { atype=5, buffid=683, bufflv=12, targettype=0, actionodds=0.3, },
                            [7] = { atype=5, buffid=683, bufflv=13, targettype=0, actionodds=0.3, fail_buffid=683, fail_bufflv=14},
                        }
                    },
                }
            },
            [10] = { name="拷贝技能3 减益状态1", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="atk_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
            [11] = { name="拷贝技能3 减益状态2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="def_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
            [12] = { name="拷贝技能3 减益状态3", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18072, rollback=true, durationtime=0, },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2, },
                        },
                    },
                }
            },
            [13] = { name="拷贝技能3 减益状态4", duration=2000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                }
            },
            [14] = { name="拷贝技能3 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, type=8, targettype=0, },
                        }
                    }
                }
            },
        },
    },
    [684] = { name="CCG精英 80005001",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=5 },
                            [2] = { atype=12, type=2, rollback=true,},
                            [3] = { atype=1, srctype=2, targettype=4, animid=1341, limit=3000, callbacktype=1 },--动作
                            [4] = { atype=14, targettype=0, direct=1, position=5, speed=15, callbacktype=2, abuffid=684, abufflv=2}
                        }
                    },
                },
            },
            [2] = { name="持续伤害", duration=400, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [2] = { atype=27, targettype=1, distance=3, limit=3000, height=1, type=5, },
                        }
                    },
                },
            },
        },
    },
    [685] = { name="食尸鬼小兵316BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, hideprepared=true, limit=3000 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1348, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=23, distance=1, targettype=0, },
                            [6] = { atype=20, delay=1024,},
                            [7] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [8] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [9] = { atype=23, distance=1, targettype=0, },
                            [10] = { atype=20, delay=957,},
                            [11] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [12] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [13] = { atype=23, distance=1, targettype=0, },
                            [14] = { atype=20, delay=1353,},
                            [15] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [16] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [17] = { atype=23, distance=1, targettype=0, },
                        }
                    },
                },
            },
        },
    },
    [686] = { name="胖夫人BOSS",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, hideprepared=true, limit=3000, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1347, limit=5000, callbacktype=1 },--做动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [4] = { atype=5, buffid=686, bufflv=2, targettype=1},
                            [5] = { atype=20, delay=33*32, },
                            [6] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [7] = { atype=5, buffid=686, bufflv=2, targettype=1},
                            [8] = { atype=20, delay=33*29, },
                            [9] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [10] = { atype=5, buffid=686, bufflv=2, targettype=1},
                            [11] = { atype=20, delay=33*41, },
                            [12] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [13] = { atype=5, buffid=686, bufflv=2, targettype=1},
                        }
                    },
                }
            },
            [2] = { name="光圈伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=1, persent=0.05 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        }
                    },
                }
            },
        },
    },
    [687] = { name="精英怪s507",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(512,256,128,64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true, hideprepared=true, limit=3000, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1357, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=5, buffid=687, bufflv=2, targettype=0},
                        }
                    },
                }
            },
            [2] = { name="持续伤害", duration=550, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=165,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true  },
                            [2] = { atype=5, buffid=687, bufflv=3, targettype=1},
                        }
                    },
                }
            },
            [3] = { name="伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, type=5, height=1 },
                        }
                    },
                }
            },
        },
    },
    [688] = { name="有马贵将BOSS技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=2, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1352, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=94, targetype=1, dirtype=0, searchtype=1, type=0, infoindex=1, buffid=688, bufflv=16},
                            [4] = { atype=20, delay=850, },
                            [5] = { atype=5, buffid=688, bufflv=4, targettype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1355, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=5, buffid=688, bufflv=7, targettype=0 },
                            [3] = { atype=5, buffid=688, bufflv=8, targettype=0 },
                            [4] = { atype=5, buffid=688, bufflv=9, targettype=0 },
                            [5] = { atype=5, buffid=688, bufflv=10, targettype=0 },
                            [6] = { atype=5, buffid=688, bufflv=11, targettype=0 },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=12, type=0, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=1356, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=5, buffid=688, bufflv=13, targettype=0 },
                        }
                    },
                }
            },
            [4] = { name="技能1第二炮", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=88, targettype=1 },
                            [2] = { atype=12, type=2, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1352, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=94, targetype=1, dirtype=0, searchtype=1, type=0, infoindex=1, buffid=688, bufflv=16},
                            [5] = { atype=20, delay=850, },
                            [6] = { atype=5, buffid=688, bufflv=5, targettype=0 },
                        }
                    },
                }
            },
            [5] = { name="技能1第三炮", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=88, targettype=1 },
                            [2] = { atype=12, type=2, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1352, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=94, targetype=1, dirtype=0, searchtype=1, type=0, infoindex=1, buffid=688, bufflv=16},
                            [5] = { atype=20, delay=850, },
                            [6] = { atype=5, buffid=688, bufflv=6, targettype=0 },
                        }
                    },
                }
            },
            [6] = { name="技能1第四炮", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=88, targettype=1 },
                            [2] = { atype=12, type=2, rollback=true },
                            [3] = { atype=1, srctype=2, targettype=4, animid=1352, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=94, targetype=1, dirtype=0, searchtype=1, type=0, infoindex=1, buffid=688, bufflv=16},
                            [5] = { atype=20, delay=850, },
                            [6] = { atype=1, srctype=2, targettype=4, animid=1354, limit=3000, callbacktype=0 },--做动作
                        }
                    },
                }
            },
            [7] = { name="技能2圆1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=2,},
                            [2] = { atype=12, type=7, distance=1, postype=1, rollback=true },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1500,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=486, position=5, },
                            [2] = { atype=94, targetype=0, searchtype=2, radius=1, type=0, infoindex=1, buffid=688, bufflv=12},
                        }
                    },
                }
            },
            [8] = { name="技能2圆2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=32, type=0, targettype=4, randomindex=0 },
                            [2] = { atype=12, type=8, distance=1, postype=1, rollback=true },                           
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1500,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=486, position=5, },
                            [2] = { atype=94, targetype=0, searchtype=2, radius=1, type=0, infoindex=1, buffid=688, bufflv=12},
                        }
                    },
                }
            },
            [9] = { name="技能2圆3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=1 },
                            [2] = { atype=12, type=9, distance=1, postype=1, rollback=true },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1500,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=486, position=5, },
                            [2] = { atype=94, targetype=0, searchtype=2, radius=1, type=0, infoindex=1, buffid=688, bufflv=12},
                        }
                    },
                }
            },
            [10] = { name="技能2圆4", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=2},
                            [2] = { atype=12, type=10, distance=1, postype=1, rollback=true },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1500,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=486, position=5, },
                            [2] = { atype=94, targetype=0, searchtype=2, radius=1, type=0, infoindex=1, buffid=688, bufflv=12},
                        }
                    },
                }
            },
            [11] = { name="技能2圆5", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = {atype=32, type=0, targettype=4, randomindex=3},
                            [2] = { atype=12, type=11, distance=1, postype=1, rollback=true },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=1500,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=486, position=5, },
                            [2] = { atype=94, targetype=0, searchtype=2, radius=1, type=0, infoindex=1, buffid=688, bufflv=12},
                        }
                    },
                }
            },
            [12] = { name="击飞+眩晕", duration=2000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=27, targettype=1, height=1, type=5, },
                            [2] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效 
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=485, },
                        }
                    },
                },
            },
            [13] = { name="结界", duration=2800, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=94, targetype=0, searchtype=1, type=0, infoindex=1, buffid=688, bufflv=14},
                        }
                    },
                },
            },
            [14] = { name="技能3受击", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                           [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=487, },
                           [2] = { atype=5, buffid=688, bufflv=15, targettype=0 },
                           [3] = { atype=27, targettype=1, height=1, type=5,},
                        }
                    },
                },
            },
            [15] = { name="减速", duration=1000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                           [1] = { atype=3, abilityname="move_speed", rollback=true },
                        }
                    },
                },
            },
            [16] = { name="技能1受击", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                           [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=484, },
                           [2] = { atype=23, targettype=1, distance=1.5,},
                           [3] = { atype=5, buffid=688, bufflv=17, targettype=0 },
                        }
                    },
                },
            },
            [17] = { name="技能1受击", duration=2000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true }, --
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                },
            },
            
        },
    },
    [689] = { name="平子丈BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=147, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 }, --加伤害BUFF
                            [4] = { atype=6, srctype=6, targettype=0, effectid=89, callbacktype=0,},
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                }
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=146, limit=3000, callbacktype=1 },--预备动作
                            [2] = { atype=14, targettype=0, usetime=500, position=3, autoforward=true, },--位移
                            [3] = { atype=1, srctype=2, targettype=0, animid=151, limit=3000, callbacktype=1 },--跳跃动作
                            [4] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=48, position=7,len=1 },--践踏特效
                            [5] = { atype=2, srctype=1, targettype=1, radius=2.5, angle=360, layer=lay_all_role, enemy=true, includeself=false,},
                            [6] = { atype=5, buffid=689, bufflv=3, targettype=1, },
                        }
                    },
                },
            },
            [3] = { name="拷贝技能2 伤害", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=90, },
                            [3] = { atype=3, abilityname="move_speed", rollback=true,},
                            [4] = { atype=27, targettype=1, height=1, type=5, distance=1.5, distype=0, },
                        }
                    },
                }
            },
        },
    },
    [690] = { name="安久奈白BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true},
                            [2] = { atype=1, srctype=2, targettype=4, animid=758, limit=3000, callbacktype=1 }, --起始动作
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                },
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=757, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=690, bufflv=3, targettype=1},
                        }
                    },
                }
            },
            [3] = { name="拷贝技能2 伤害+降低防御", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=251 },
                            [3] = { atype=27, targettype=1, type=3, },
                            [4] = { atype=41, abilityname="def_power", valuetype=1, rollback=true, },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },--
                            [6] = { atype=23, targettype=1, distance=1.5, },
                        }
                    }
                }
            },
        },
    },
    [691] = { name="金木研BOSS技能", 
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=4, limit=3000, callbacktype=1 }, --起始动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, targettype=1, buffid=691, bufflv=5,},
                            [4] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                },
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=5, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true},
                            [3] = { atype=32, type=1 },
                            [4] = { atype=5, buffid=691, bufflv=4, targettype=1 },
                        }
                    }
                }
            },
            [3] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true, arraytype=0,},
                            [3] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=528,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=627,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=726,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=858,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=924,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                    [8] = { activetype=3, triggertype=0, delay=1056,
                        action = {
                            [1] = { atype=5, buffid=691, bufflv=6, targettype=4, },
                        },
                    },
                },
            },
            [4] = { name="击退+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=23, targettype=1, distance=1.5, dirtype=1 },
                        }
                    },
                },
            },
            [5] = { name="拷贝技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                        }
                    }
                }
            },
            [6] = { name="拷贝技能3 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid="311.316",},
                            [3] = { atype=27, targettype=1, type=3, },
                        }
                    }
                }
            },
        },
    },
    [692] = { name="钵川忠BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=603, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=90, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=692, bufflv=7, targettype=1 }, --加伤害BUFF
                        }
                    },
                }
            },
            [2] = { name="拷贝技能2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=620, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=172, callbacktype=0,},
                            [5] = { atype=23, targettype=0, distance=1.5, },
                            [6] = { atype=5, buffid=692, bufflv=8, targettype=0, },
                        }
                    },
                },
            },
            [3] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=602, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=692, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*12,
                        action = {
                            [1] = { atype=5, buffid=692, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*17,
                        action = {
                            [1] = { atype=5, buffid=692, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                }
            },
            [4] = { name="技能3 赫子碎片起始", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=5, radius=5, angle=90, enemy=true, targetcnt=1, },
                            [2] = { atype=6, effectid=170, srctype=2, targettype=6, limit=3000, callbacktype=1, },
                            [3] = { atype=5, buffid=692, bufflv=5, targettype=1, },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                            [6] = { atype=5, buffid=692, bufflv=6, targettype=1, },
                        }
                    },
                }
            },
            [5] = { name="技能3 赫子碎片弹射", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=5, radius=5, angle=360, enemy=true, targetcnt=1, },
                            [2] = { atype=6, srctype=2, targettype=6, effectid=170, limit=3000, callbacktype=1, refskill=1 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=5, buffid=692, bufflv=6, targettype=1, },
                        }
                    }
                }
            },
            [6] = { name="技能3 沉默", duration=4000, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true }, --
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                        }
                    },
                }
            },
            [7] = { name="技能1 伤害+降低攻速移速", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=3, abilityname="move_speed", rollback=true, },
                            [3] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true, },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid="255.257",},
                            [5] = { atype=23, targettype=1, distance=1.5, },
                        }
                    },
                }
            },
            [8] = { name="技能2 烟雾弹", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, },--记录位置
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=400, 
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, enemy=false, position=2, includeself=true},
                            [2] = { atype=5, buffid=692, bufflv=9, targettype=1, },
                        },
                    },
                }
            },
            [9] = { name="技能2 增加闪避", duration=500, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="dodge_rate", valuetype=1, rollback=true, },
                        },
                    },
                },
            },
        },
    },
    [693] = { name="纳基BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=307, limit=3000, callbacktype=1, },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role,enemy=true},
                            [3] = { atype=5, buffid=693, bufflv=3, targettype=1, },
                        },
                    },
                },
            },
            [2] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    -- 动作部分
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, enemy=true, layer=lay_all_role, arraytype=0},
                        },
                    },
                    [2] = { activetype=0,triggertype=0, group=1, condition=72,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=310, limit=3000, callbacktype=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=311, limit=3000, callbacktype=1, },
                        },
                    },
                    [3] = { activetype=0,triggertype=0, group=1, condition=73,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=310, limit=3000, callbacktype=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=312, limit=3000, callbacktype=1, },
                        },
                    },
                    [4] = { activetype=0,triggertype=0, group=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=309, limit=3000, callbacktype=1, },
                        },
                    },
                    -- 伤害部分
                    [5] = { activetype=0,triggertype=0, group=2, condition=72,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [5] = { atype=20, delay=8*33, },
                            [6] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                        },
                    },
                    [6] = { activetype=0,triggertype=0, group=2, condition=73,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [5] = { atype=20, delay=8*33, },
                            [6] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [7] = { atype=20, delay=23*33, },
                            [8] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                        },
                    },
                    [7] = { activetype=0,triggertype=0, group=2,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=693, bufflv=4, targettype=2, srctype=0, speed=15, },
                        },
                    },
                },
            },
            [3] = { name="暴怒伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},
                            [2] = { atype=6, srctype=2, targettype=0, effectid=135, callbacktype=0, },
                            [3] = { atype=23, targettype=1, distance=1.5, },
                        },
                    },
                },
            },
            [4] = { name="拷贝技能3 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3,triggertype=0, delay=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},--伤害
                            [2] = { atype=6, srctype=2, targettype=0, effectid=418, callbacktype=0, },
                            [3] = { atype=23, targettype=1, distance=1.5, },
                        },
                    },
                },
            },
        },
    },
    [694] = { name="宇井郡BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=613, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, layer=lay_all_role,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=127 },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                }
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=614, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=694, bufflv=4, targettype=0 },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [6] = { atype=20, delay=33*5 ,},
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [9] = { atype=20, delay=33*4 ,},
                            [10] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [11] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [12] = { atype=20, delay=33*4 ,},
                            [13] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [14] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [15] = { atype=20, delay=33*4 ,},
                            [16] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [17] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [18] = { atype=20, delay=33*10 ,},
                            [19] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [20] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=128 },
                            [21] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                },
            },
            [3] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=615, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, layer=lay_all_role,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=27, targettype=0, height=1, type=6, },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [6] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [7] = { atype=20, delay=33*13 ,},
                            [8] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [9] = { atype=27, targettype=0, height=1, type=6, },
                            [10] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [11] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [12] = { atype=20, delay=33*6 ,},
                            [13] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [14] = { atype=27, targettype=0, height=1, type=6, },
                            [15] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [16] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [17] = { atype=20, delay=33*11 ,},
                            [18] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [19] = { atype=27, targettype=0, height=1, type=6, },
                            [20] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [21] = { atype=5, buffid=694, bufflv=5, targettype=1 },
                            [22] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                }
            },
            [4] = { name="提升格挡", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="parry_rate", valuetype=1, rollback=true,},
                            -- [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0},
                        }
                    },
                }
            },
            [5] = { name="拷贝技能3 吸收防御", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=101, abilityname="def_power", abilityscale=0.03, creatorability="def_power", maxscale=0.5, recordname="yjj_skill3", rollback=true, },
                        }
                    },
                }
            },
        },
    },
    [695] = { name="真户晓BOSS技能",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=62, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=121 },
                            [5] = { atype=23, targettype=0, distance=1.5, },
                        }
                    },
                }
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=60, limit=3000, callbacktype=0 },
                            [2] = { atype=2, srctype=1, targettype=4, aroundradius=1.5, layer=lay_all_role, enemy=true},
                            [3] = { atype=13, buffid=695, bufflv=4, targettype=0, srctype=0, speed=15 }, --加BUFF根据距离速度算延迟
                            [4] = { atype=14, targettype=0, usetime=100, direct=1, distance=6, callbacktype=0, limit=3000 },
                        }
                    },
                },
            },
            [3] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=61, limit=3000, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*8,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=695, bufflv=5, targettype=1},
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*19,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=695, bufflv=5, targettype=1},
                            [3] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*26,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=695, bufflv=5, targettype=1},
                            [3] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*36,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=695, bufflv=5, targettype=1},
                            [3] = { atype=5, buffid=695, bufflv=6, targettype=1},
                            [4] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                }
            },
            [4] = { name="技能2伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=23, targettype=1, distance=1.5, },
                        }
                    },
                },
            },
            [5] = { name="技能3伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=27, targettype=1, height=1, type=6, },
                        },
                    },
                },
            },
            [6] = { name="技能3定身", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true, actionodds=0.5, fail_buffid=695, fail_bufflv=7, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1,},
                        },
                    },
                },
            },
            [7] = { name="技能3 定身失败", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, type=6, targettype=0, },
                        }
                    }
                }
            },
        }
    },
    [696] = { name="铃屋什造",
        level = {
            [1] = { name="拷贝技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=164, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },--查找附近目标
                            -- [3] = { atype=6, srctype=2, targettype=0, effectid=81, callbacktype=0, },
                            [3] = { atype=13, buffid=696, bufflv=8, targettype=0, srctype=0, speed=15, },
                        }
                    },
                }
            },
            [2] = { name="拷贝技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=168, limit=3000, callbacktype=1 },--做预备动作
                            [2] = { atype=1, srctype=2, targettype=4, animid=169, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=2, srctype=1, targettype=4, width=1.5, layer=lay_all_role, enemy=true, },--查找直线目标
                            [4] = { atype=5, buffid=696, bufflv=4, targettype=1 },
                            [5] = { atype=14, targettype=0, callbacktype=0, usetime=330, direct=1, distance=5, limit=3000, limit=3000 },--位移
                        }
                    },
                }
            },
            [3] = { name="拷贝技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=bit_merge(1,2,4,16,32,64,128,256,512), rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=167, limit=3000, callbacktype=1 },--做动作
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=300,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, layer=lay_all_role, enemy=true, },--查找附近目标
                            [2] = { atype=5, buffid=696, bufflv=9, targettype=1 },--加伤害BUFF
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=57 },--加受击特效
                            [4] = { atype=27, targettype=0, height=1, type=6 },
                            [5] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                },
            },
            [4] = { name="技能2伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=37, value=2, type=1, condition=77},
                            [2] = { atype=4, type=0, infoindex=1 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=57 },--加受击特效
                            [4] = { atype=27, targettype=1, type=3, distance=1.5, },
                        }
                    },
                }
            },
            [5] = {name="技能3击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            --[1] = { atype=27, targettype=1, distance=4, type=3},
                            [1] = { atype=14, targettype=0, usetime=100, direct=4, distance=2 },
                        }
                    },
                }
            },
            [6] = {name="被动BUFF", duration=-1, overlap=0, property=bit_merge(64,1), skillid=47,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=66, skillid=2090, bossadd=1, notbossadd=1, heroadd=1, buffid=696, bufflv=7, rollback=true },
                        }
                    },
                }
            },
            [7] = {name="减少技能1CD", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=67, cdvalue=3000, cdtype=1, },
                        }
                    },
                }
            },
            [8] = {name="技能1伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=56 },--加受击特效
                            [3] = { atype=5, buffid=696, bufflv=10, targettype=0, },
                            [4] = { atype=27, targettype=1, type=3, distance=1.5, },
                        }
                    },
                }
            },
            [9] = {name="技能3伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=38, scale=1.2, condition=44, rollback=true },
                            [1] = { atype=37, value=2, type=1, condition=77},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=0 },--加伤害BUFF
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=58 },--加受击特效
                            [4] = { atype=27, targettype=1, type=6, },
                        }
                    },
                }
            },
            [10] = {name="技能1buff", duration=5000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=435, durationtime=0, rollback=true, },
                        }
                    },
                }
            },
        },
    },
    [697] = { name="四方莲示",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=646, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=30, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=243, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distance=1.5, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=647, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=697, bufflv=3, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=244, callbacktype=0 },
                        }
                    },
                },
            },
            [3] = { name="践踏伤害 嘲讽", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=75, rollback=true, actionodds=0.5,  fail_buffid=697, fail_bufflv=4, },
                            [3] = { atype=27, type=5, targettype=1,  },
                        }
                    },
                },
            },
            [4] = { name="嘲讽失败", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, type=12, targettype=0, },
                        }
                    }
                }
            },
        },
    },
    [698] = { name="笛口雏实",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=155, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true,},
                            [3] = { atype=5, buffid=698, bufflv=3, targettype=1 }
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=156, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, srctype=1, targettype=4, width=3, layer=lay_all_role, enemy=true, arraytype=0, },
                            [3] = { atype=5, buffid=698, bufflv=4, targettype=4, },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=698, bufflv=4, targettype=4, },
                        },
                    },
                },
            },
            [3] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=253,},--
                            [3] = { atype=27, targettype=1, type=3, distance=1.5, },
                        }
                    },
                }
            },
            [4] = { name="技能2 伤害减速", duration=3000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=208,},--
                            [3] = { atype=3, abilityname="move_speed", rollback=true, },
                            [4] = { atype=27, targettype=1, type=5, },
                        }
                    },
                },
            },
        },
    },
    [699] = { name="白发金木研",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=0, usetime=200, distance=3.5, direct=7 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=960, limit=3000, callbacktype=1 }, --起始动作
                            [3] = { atype=5, buffid=66, bufflv=4, targettype=2 },
                            [4] = { atype=5, buffid=66, bufflv=5, targettype=2 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=961, limit=3000, callbacktype=1 },--践踏地面起跳
                            [2] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true }, --找范围目标
                            [3] = { atype=5, buffid=66, bufflv=6, targettype=1, },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=82, protype=1, scale=1.3, rollback=true },
                            [1] = { atype=1, srctype=2, targettype=0, animid=962, limit=3000, callbacktype=1 },--践踏地面起跳
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, layer=lay_all_role, enemy=true }, --找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=27, targettype=0, distance=1.5, distype=0, type=3, },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=294 },
                        }
                    },
                }
            },
            [4] = { name="技能1 定身+伤害", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                            [3] = { atype=4, type=0, infoindex=1 },
                        }
                    },
                }
            },
            [5] = { name="技能1 持续", duration=2500, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 },
                        }
                    },
                }
            },
            [6] = { name="技能2 伤害+减防", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=293 },
                            [3] = { atype=41, abilityname="def_power", valuetype=1, rollback=true,},       --减少物防
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
                            [5] = { atype=27, targettype=1, distance=1.5, distype=0, type=3, }
                        }
                    },
                }
            },
        },
    },
    [700] = { name="魔猿",
        level = {
            [1] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=857, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害
                            [4] = { atype=27, targettype=0, type=3, distance=1.5, },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=261, callbacktype=0, },
                            [6] = { atype=2, srctype=1, targettype=6, angle=360, enemy=false, layer=lay_all_role, includeself=true, },--查找附近目标
                            [7] = { atype=5, buffid=700, bufflv=3, targettype=1 },--加伤害
                        }
                    },
                }
            },
            [2] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=855, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=1, srctype=2, targettype=4, animid=856, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role },--查找目标
                            [4] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=1, },--加伤害BUFF
                            [5] = { atype=20, delay=33*1, },
                            [6] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=2, },--加伤害BUFF
                            [7] = { atype=20, delay=33*1, },
                            [8] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=3, },--加伤害BUFF
                            [9] = { atype=20, delay=33*1, },
                            [10] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=4, },--加伤害BUFF
                            [11] = { atype=20, delay=33*1, },
                            [12] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=5, },--加伤害BUFF
                            [13] = { atype=20, delay=33*1, },
                            [14] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=6, },--加伤害BUFF
                            [15] = { atype=20, delay=33*1, },
                            [16] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=7, },--加伤害BUFF
                            [17] = { atype=20, delay=33*1, },
                            [18] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=8, },--加伤害BUFF
                            [19] = { atype=20, delay=33*1, },
                            [20] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=9, },--加伤害BUFF
                            [21] = { atype=20, delay=33*1, },
                            [22] = { atype=5, buffid=700, bufflv=4, targettype=1, targetindex=10, },--加伤害BUFF
                        }
                    },
                }
            },
            [3] = { name="技能2 反伤", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=97, type=7, scale=0.2, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                }
            },
            [4] = { name="技能3 概率眩晕+伤害", duration=0, overlap=1, property=bit_merge(64), maxoverlap=5,
                trigger = {
                    [1] = { activetype=0, triggertype=1, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=5, buffid=24, bufflv=5, targettype=0, actionodds=0.3, fail_buffid=24, fail_bufflv=6,},
                            [3] = { atype=27, targettype=1, type=3, distance=1, },
                        },
                    },
                },
            },
            [5] = { name="技能3 眩晕", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        },
                    },
                },
            },
            [6] = { name="技能3 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, type=8, targettype=0, },
                        }
                    }
                }
            },
        },
    },
}
table.splice(g_BuffData, g_MonsterSkillBuffData)
g_MonsterSkillBuffData = nil
--[[endregion]]
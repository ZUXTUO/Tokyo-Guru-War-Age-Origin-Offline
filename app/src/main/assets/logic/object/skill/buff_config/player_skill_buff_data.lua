--[[
region player_skill_buff_data.lua
date: 2015-9-18
time: 21:39:9
author: Nation
编号从1-100
]]
g_PlayerSkillBuffData = {
    [1] = { name="伤害", 
        level = {
            [1] = { name="伤害1", duration=0, overlap=0, property=bit_merge(1),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=4, type=0, infoindex=1 }
						}
                    }
                }
            },
            [2] = { name="伤害2", duration=0, overlap=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 }
                        }
                    }
                }
            },
            [3] = { name="伤害3", duration=0, overlap=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=3 }
                        }
                    }
                }
            },
        }
    },
    [2] = { name="金木研", 
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=4, limit=3000, callbacktype=1 }, --起始动作
                            [2] = { atype=2, usetype=0, typeindex=3 },
                            -- [3] = { atype=19, enable=false, rollback=true },
                            -- [4] = { atype=17, targettype=1, srctype=0, effectid=7, buffid=2, bufflv=6, radius=4, limit=1000 },
                            [3] = { atype=5, targettype=1, buffid=2, bufflv=6,},
                            -- [4] = { atype=6, srctype=7, targettype=2, callbacktype=1, effectid=7, limit=3000, handlehit=false },
                            -- [6] = { atype=19, enable=true }, --虚影冲击
                            -- [5] = { atype=1, srctype=2, targettype=4, animid=128, limit=3000, callbacktype=0 }, --前刺动作1
						}
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=5, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=2 },
                            [3] = { atype=32,type=1 },
                            [4] = { atype=5, buffid=2, bufflv=5, targettype=1 },
						}
                    }
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=384 },
                            [3] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=528,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=627,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=726,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=858,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=924,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [8] = { activetype=3, triggertype=0, delay=1056,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                },
            },
            [4] = { name="破防", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
							[1] = { atype=41, abilityname="def_power", valuetype=1, rollback=true,},       --减少物防
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
						}
                    }
                }
            },
            [5] = { name="击退+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            --[2] = { atype=23, targettype=1, distance=1.5, dirtype=1,},--击退
                            -- [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=45 }
                        }
                    },
                },
            },
            [6] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            -- [2] = { atype=41, abilityname="def_power", valuetype=1, rollback=true }, --减少能防
                            [1] = { atype=4, type=0, infoindex=1 },
                            -- [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=23, rollback=true, durationtime=0},--饥饿特效
                            -- [5] = { atype=61, rollback=true },
                        }
                    }
                }
            },
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=1 },
                            [3] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=528,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=627,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=726,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=858,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=924,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                    [8] = { activetype=3, triggertype=0, delay=1056,
                        action = {
                            [1] = { atype=5, buffid=2, bufflv=8, targettype=4, },
                        },
                    },
                }
            },
            [8] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid="311.316",},
                        }
                    }
                }
            },
        },
    },
    [4] = { name="神代利世",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=107, limit=3000, callbacktype=1 }, 
                            [2] = { atype=2, usetype=0, typeindex=5 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},--
                            [4] = { atype=6, srctype=5, targettype=0, effectid=355, callbacktype=0 },
                            [5] = { atype=5, buffid=4, bufflv=4, targettype=0,},--
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=104, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=368, },
                            [3] = { atype=5, buffid=4, bufflv=5, targettype=4 },
						}
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*18,
                        action = {
                            [1] = { atype=5, buffid=4, bufflv=6, targettype=4 },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=3, property=bit_merge(64), ignore_anim_end={1,4},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=108, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=369, },
                            [3] = { atype=95, type=0, buffid=4, bufflv=4, infoindex=2, rollback=true, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=355, callbacktype=0 },
                            [5] = { atype=6, srctype=6, targettype=0, effectid=356, callbacktype=0, position=0,},
                            [6] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [7] = { atype=11, buffid=4, bufflv=4, targettype=0, },
                        }
                    },
                }
            },
            [4] = { name="暴走 状态", duration=-1, overlap=1, property=bit_merge(64), maxoverlap=5, attention_skill=4,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=4, bufflv=8, targettype=0, rollback=true},
                        },
                    },
                },
            },
            [5] = { name="技能2减速+伤害", duration=4000, overlap=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, effectid=354, callbacktype=0 },
                            [3] = { atype=3, abilityname="move_speed", rollback=true },
                            [4] = { atype=27, targettype=1, type=3, distance=0,},
                        },
                    },
                },
            },
            [6] = { name="技能2拉人", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=3, usetime=300, direct=1, limit=3000, offset=1.5, offsettype=0, },
                        },
                    },
                },
            },
            [7] = { name="被动技能", duration=0, overlap=0, property=bit_merge(64), skillid=4,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=4, bufflv=4, overlap=3, targettype=0,},--
                        },
                    },
                },
            },
            [8] = { name="暴走 状态特效", duration=-1, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18038, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            
        },
    },
    [5] = { name="雾岛董香",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=25, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=9 }, --找范围目标
                            [3] = { atype=13, buffid=1, bufflv=1, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=22, limit=3000, callbacktype=1 },  --先发射羽赫
                            -- [2] = { atype=67, cdvalue=3000, cdtype=1 },
                            [2] = { atype=6, srctype=1, targettype=0, callbacktype=0, effectid=1,},
                            [3] = { atype=2, usetype=0, typeindex=7 }, --找范围目标
                            [4] = { atype=13, buffid=5, bufflv=5, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=23, limit=3000, callbacktype=1 },  --先发射羽赫
                            [2] = { atype=2, usetype=0, typeindex=348 }, --找范围目标
                            [3] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                        }
                    },
                    -- [2] = { activetype=3, triggertype=0, delay=33*11,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                    -- [3] = { activetype=3, triggertype=0, delay=33*15,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                    -- [4] = { activetype=3, triggertype=0, delay=33*25,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                }
            },
            [4] = { name="技能3 伤害", duration=5100, overlap=2, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=3},--被击特效
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2, },
                        },
                    },
                }
            },
            [5] = { name="技能2伤害", duration=5000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=2},--被击特效
                            [3] = { atype=41, abilityname="def_power", rollback=true },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },--
                            -- [4] = { atype=27, targettype=1, type=3, distance=0,},
                        }
                    },
                }
            },
            [6] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64,32,16,1), peel={1,3},
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=23, limit=3000, callbacktype=1 },  --先发射羽赫
                            [2] = { atype=2, usetype=0, typeindex=329 }, --找范围目标
                            [3] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                        }
                    },
                    -- [2] = { activetype=3, triggertype=0, delay=33*11,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                    -- [3] = { activetype=3, triggertype=0, delay=33*15,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                    -- [4] = { activetype=3, triggertype=0, delay=33*25,
                    --     action = {
                    --         [1] = { atype=5, buffid=5, bufflv=4, targettype=4,},
                    --     }
                    -- },
                }
            },
        },
    },
    [7] = { name="亚门钢太郎",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=41, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=12 }, --找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 }, --加伤害BUFF
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=333 },
                            --[5] = { atype=23, targettype=0, distance=2 },
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=42, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=10 }, --找范围目标
                            [3] = { atype=5, buffid=7, bufflv=4, targettype=1 }, --加伤害BUFF
                            --[4] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=4900, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=40, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=335, rollback=true, durationtime=0 },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, typeindex=11 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [3] = { atype=6, srctype=5, targettype=0, effectid=336, callbacktype=0 },
                        },
                    },
                }
            },
            [4] = { name="技能2 伤害+概率眩晕", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
							[1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=5, buffid=7, bufflv=7, targettype=0, actionodds=0.3, fail_buffid=7, fail_bufflv=8, },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=334},
                        }
                    }
                }
            },
            [5] = { name="觉醒技能3", duration=4900, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=42, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=88, rollback=true, durationtime=0 },
                            [3] = { atype=41, abilityname="def_power", valuetype=1, rollback=true, },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0},
                            [5] = { atype=2, usetype=0, typeindex=330 }, --找范围目标
                            [6] = { atype=5, buffid=7, bufflv=6, targettype=1 }, --加伤害BUFF
                            [7] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                        }
                    },
                }
            },
            [6] = { name="觉醒嘲讽伤害", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=24},
                            [3] = { atype=75, rollback=true,},
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18043, rollback=true, durationtime=0},
                        }
                    }
                }
            },
            [7] = { name="技能2 眩晕", duration=1500, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1},--眩晕特效
                        }
                    }
                }
            },
            [8] = { name="技能2 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
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
    [8] = { name="真户吴绪",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=177, limit=3000, callbacktype=1 },--开始动作
                            [2] = { atype=2, usetype=0, typeindex=244 },--找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--添加眩晕伤害BUFF
                            [4] = { atype=6, srctype=5, targettype=0, effectid=50, callbacktype=0, },
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=180, limit=3000, callbacktype=1 },--开始动作
                            [2] = { atype=2, usetype=0, typeindex=22 },--找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=20, delay=33*8, },
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [6] = { atype=20, delay=33*4, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=20, delay=33*16, },
                            [9] = { atype=5, buffid=8, bufflv=4, targettype=1 },
                        }
                    }
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=181, limit=3000, callbacktype=1 },--开始动作
                            [2] = { atype=5, buffid=8, bufflv=6, targettype=0, }
                        }
                    },
                }
            },
            [4] = { name="技能2 概率恐惧+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 }, --伤害
                            [2] = { atype=5, buffid=8, bufflv=5, targettype=0, actionodds=0.5, fail_buffid=8, fail_bufflv=9, }, --眩晕
                        }
                    },
                }
            },
            [5] = { name="技能2 恐惧", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=3, rollback=true, }, 
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18059, rollback=true, durationtime=0,},--
                        }
                    },
                }
            },
            [6] = { name="技能3 降低正面伤害", duration=6000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=102, value=0, rollback=true, },
                            [2] = { atype=103, scale=0.7, valuetype=2, value=2, rollback=true, },
                            [3] = { atype=3, abilityname="move_speed", rollback=true, },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=200,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=27, distance=1, targettype=0, distype=0, limit=3000, type=3,},
                        }
                    },
                },
            },
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=181, limit=3000, callbacktype=1 },--开始动作
                            [2] = { atype=5, buffid=8, bufflv=8, targettype=0, }
                        }
                    },
                }
            },
            [8] = { name="觉醒技能3 降低正面伤害", duration=6000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=102, value=0, rollback=true, },
                            [2] = { atype=103, scale=0.5, valuetype=2, value=2, rollback=true, },
                            [3] = { atype=3, abilityname="move_speed", rollback=true, },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=200,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=27, distance=1, targettype=0, distype=0, limit=3000, type=3,},
                        }
                    },
                },
            },
            [9] = { name="技能2 恐惧失败", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=85, type=58, targettype=0, },
                        }
                    }
                }
            },
        },
    },
    [10] = { name="西尾锦",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=0 },
                            [2] = { atype=2, usetype=0, typeindex=24 },
                            -- [3] = { atype=5, buffid=10, bufflv=4, targettype=0, },
                            [3] = { atype=13, buffid=10, bufflv=5, targettype=0, srctype=0, speed=20 }, --加伤害BUFF根据距离速度算延迟 
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=73, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=93, limit=3000, callbacktype=1, lock=true, notstand=true, rollback=true, },
                            [3] = { atype=2, srctype=1, targettype=3 },
                            [4] = { atype=5, buffid=10, bufflv=8, targettype=0 }, --加防御
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=8, },--特效
                            -- [4] = { atype=15, } --因为没有技能动作需要设置技能完成
                        }
                    }
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=1, usetime=495, distance=4, offset=1, limit=3000, offsettype=0, direct=1 },--位移
                            [2] = { atype=1, srctype=2, targettype=0, animid=94, limit=3000, callbacktype=1 },--践踏地面起跳
                            [3] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=11, position=3 },--践踏特效
                            [4] = { atype=2, typeindex=23 }, --找范围目标
                            [5] = { atype=5, buffid=10, bufflv=6, targettype=1 },
                            [6] = { atype=5, buffid=10, bufflv=7, targettype=1,},
                        }
                    }
                }
            },
            [4] = { name="斩杀效果", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=87, hppersent=40, damagescale=1.2, rollback=true,},
                        },
                    },
                },
            },
            [5] = { name="技能1伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=1, delay=50,
                         action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=12 },--伤害特效
                            --[3] = { atype=27,targettype=1,type=3, distance=2},
                         }
                    }
                }
            },
            [6] = { name="技能2伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                         action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=12 },--伤害特效
                            --[3] = { atype=27, targettype=1, distance=0, distype=0, height=3.5, type=5 },
                         }
                    }
                }
            },
            [7] = { name="技能3 降低攻击力", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=1, rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0},
                        },
                    },
                },
            },
            [8] = { name="技能2 提升防御力", duration=4000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=41, abilityname="def_power", rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=10, rollback=true, durationtime=0},--特效
                        }
                    }
                }
            },
            [9] = { name="受到伤害加成", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=72, infoindex=1, rollback=true }, --受到西尾锦普攻伤害加成
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=9, rollback=true, durationtime=0},--伤害加成特效
                        }
                    },
                    [2] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=11, buffid=10, bufflv=8, targettype=4 },
                        }
                    },
                }
            },
            [10] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=3 },
                            [2] = { atype=5, buffid=10, bufflv=11, targettype=0 }, --加无敌BUFF
                            [3] = { atype=5, buffid=10, bufflv=9, targettype=1 }, --加伤害加成BUFF
                            [4] = { atype=15, } --因为没有技能动作需要设置技能完成
                        }
                    }
                }
            },
            [11] = { name="西尾锦觉醒无敌", duration=8000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=55, except_type=0, rollback=true }, --无敌
                            [2] = { atype=22, type=immune_all_countrol_state, rollback=true },--免疫控制
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=9, rollback=true, durationtime=0},--无敌特效
                        }
                    }
                }
            },
        },
    },
    [15] = { name="杰森",
        level = {
            [1] = { name="技能1", duration=8000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=bit_merge(64), rollback=true },--免疫击退
                            [2] = { atype=5, buffid=15, bufflv=4, targettype=0 },--加检测冲击BUFF
                            [3] = { atype=5, buffid=15, bufflv=5, targettype=0 },--加冲击伤害BUFF
                            -- [4] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [4] = { atype=15, }, --因为没有技能动作需要设置技能完成
                            [5] = { atype=5, buffid=15, bufflv=7, targettype=0 },--加半赫者形态BUFF
                            [6] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=63 },
                            [7] = { atype=52, old_id=10, new_id=266, rollback=true },
                            [8] = { atype=6, srctype=2 , targettype = 0,effectid=64, rollback=true, durationtime=0,callbacktype=0},--加跑步的特效
                            [9] = { atype=60, id=81101612, follow=true, autostop=false, rollback=true}
                            -- [10] = { atype=52, old_id=24, new_id=265, rollback=true },
						}
                    },
                    [2] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=15, lock=1 },
                            [2] = { atype=28 },
                            [3] = { atype=11, buffid=15, bufflv=4, targettype=0 },--移除检测冲击BUFF
                            [4] = { atype=11, buffid=15, bufflv=5, targettype=0 },--移除冲击伤害BUFF
                            [5] = { atype=2, typeindex=55 },--查找扇形目标
                            [6] = { atype=1, srctype=2, targettype=0, animid=267, limit=3000, callbacktype=1 },--动作
                            -- [7] = { atype=27, targettype=0, distance=0, type=5, height=3 },--击退
                            [7] = { atype=5, buffid=15, bufflv=10, targettype=0 },--加延迟移除半赫者形态BUFF
                            [8] = { atype=60, id=81101613, follow=true, autostop=true,}
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1, condition=2, --处于半赫者形态
                        action = {
                            [1] = { atype=86, scale=1.3, },
						}
                    },
                    [2] = { activetype=0, triggertype=0, condition=2, group=1,--处于半赫者形态
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=263, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=24, rollback=true },--记录伤害
                            [3] = { atype=2, usetype=0, typeindex=56 },--查找扇形目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
							[5] = { atype=23, targettype=0,distance=1},
                            [6] = { atype=25, type=0, value=0.2 },--恢复生命
						}
                    },
                    [3] = { activetype=0, triggertype=0, group=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=255, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=24, rollback=true },--记录伤害
                            [3] = { atype=2, usetype=0, typeindex=64 },--查找扇形目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=25, type=0, value=0.2 },--恢复生命
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1, condition=2, --处于半赫者形态
                        action = {
                            [1] = { atype=86, scale=1.2, },
						}
                    },
                    [2] = { activetype=0, triggertype=0, condition=2, group=1,--处于半赫者形态
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=264, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=57 },--查找附近目标
                            [3] = { atype=5, buffid=15, bufflv=8, targettype=1 },--加吸引BUFF
						}
                    },
                    [3] = { activetype=0, triggertype=0, group=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=256, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=65 },--查找附近目标
                            [3] = { atype=5, buffid=15, bufflv=8, targettype=1 },--加吸引BUFF
						}
                    },
                },
            },
            [4] = { name="检测冲击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=50,
                        action = {
    
						}
                    },
                },
            },
            [5] = { name="冲击伤害", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=500,
                        action = {
                            [1] = { atype=2, typeindex=59 },--查找扇形目标
                            [2] = { atype=5, buffid=1, bufflv=2, targettype=1 },--加伤害BUFF
						}
                    },
                },
            },
            [6] = { name="冲击后退", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=0, usetime=30, direct=4, distance=1 }, --撞飞
                            [2] = { atype=54,}
                        }
                    },
                },
            },
            [7] = { name="半赫者形态", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=40, modelid=80001008, rollback=true },--变身
                        }
                    },
                    [2] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=63 },
                        }
                    },
                },
            },
            [8] = { name="吸引", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=3, usetime=300, offset=1.5, offsettype=0 },--吸引位置
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                            -- [3] = { atype=5, buffid=15, bufflv=9, targettype = 0 }, --加吸引减速BUFF
                        }
                    },
                },
            },
            [9] = { name="吸引减速", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            [2] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true }, --减少攻击速度
                        }
                    },
                },
            },
            [10] = {name="延迟移除半赫者形态", duration=10000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=11, buffid=15, bufflv=7, targettype=0, immediately=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=63 },
                        }
                    },
                },
            },
        },
    },
    [16] = { name="月山习",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=132, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=32 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 ,},
                            [4] = { atype=6, srctype=5, targettype=0, effectid=31, callbacktype=0,},
                            [5] = { atype=20, delay=33*6, },
                            [6] = { atype=5, buffid=1, bufflv=1, targettype=1 ,},
                            [7] = { atype=6, srctype=5, targettype=0, effectid=31, callbacktype=0,},
                            [8] = { atype=20, delay=33*6, },
                            [9] = { atype=5, buffid=1, bufflv=1, targettype=1 ,},
                            [10] = { atype=6, srctype=5, targettype=0, effectid=31, callbacktype=0,},
                            [11] = { atype=5, buffid=16, bufflv=4, targettype=1, },
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=133, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=31 },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=33, callbacktype=0,},
                            [5] = { atype=5, buffid=16, bufflv=5, targettype=1 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=6, usetime=200, limit=3000, distance=6},
                            [2] = { atype=1, srctype=2, targettype=4, animid=134, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, usetype=0, typeindex=30 },--查找附近目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [5] = { atype=54, count=1, x=1, y=0.6, z=1, dis=0.1, speed=80, decay=0.3, multiply=0, },

                            [6] = { atype=20, delay=33*12, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [8] = { atype=54, count=1, x=1, y=0.6, z=1, dis=0.1, speed=80, decay=0.3, multiply=0, },

                            [9] = { atype=20, delay=33*9, },
                            [10] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [11] = { atype=54, count=2, x=1.2, y=1.5, z=1.2, dis=0.1, speed=60, decay=0.3, multiply=0, },
                            [12] = { atype=20, delay=33*9, },
                            [13] = { atype=5, buffid=1, bufflv=1, targettype=1 },
						}
                    },
                }
            },
            [4] = { name="技能1 降低防御", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="def_power", valuetype=1, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [5] = { name="技能2 降低移动速度", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0, },
                        }
                    },
                }
            },
            [6] = { name="技能3 觉醒", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=6, usetime=200, limit=3000, distance=6, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=134, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=2, usetype=0, typeindex=30 },--查找附近目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [5] = { atype=54, count=1, x=1, y=0.6, z=1, dis=0.1, speed=80, decay=0.3, multiply=0, },

                            [6] = { atype=20, delay=33*12, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [8] = { atype=54, count=1, x=1, y=0.6, z=1, dis=0.1, speed=80, decay=0.3, multiply=0, },

                            [9] = { atype=20, delay=33*9, },
                            [10] = { atype=5, buffid=1, bufflv=1, targettype=1 },--
                            [11] = { atype=54, count=2, x=1.2, y=1.5, z=1.2, dis=0.1, speed=60, decay=0.3, multiply=0, },
                            [12] = { atype=20, delay=33*9, },
                            [13] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                        }
                    },
                }
            },
        },
    },
    [18] = { name="蜈蚣金木",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=298, limit=3000, callbacktype=0 },
                            [2] = { atype=2, usetype=0, typeindex=320 },
                            [3] = { atype=13, buffid=18, bufflv=4, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟 
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=31, scale=0.8, odds=100, rollback=true },--降低受到伤害
                            [2] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [3] = { atype=6, srctype=2, targettype=0, effectid=132, callbacktype=0, },
                            [4] = { atype=15, },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=1, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=297, limit=3000, callbacktype=1 },--动作
                            [3] = { atype=1, srctype=2, targettype=4, animid=299, limit=3000, callbacktype=0 },--动作
                            [4] = { atype=2, usetype=0, typeindex=80 },--查找直线目标
                            [5] = { atype=13, buffid=1, bufflv=1, targettype=0, srctype=0, speed=5 },--根据距离加伤害
                            [6] = { atype=14, targettype=0, callbacktype=0, usetime=50, direct=1, distance=4, limit=3000 },--位移
                            [7] = { atype=13, buffid=1, bufflv=1, targettype=0, srctype=0, speed=5 },--根据距离加伤害
                            [8] = { atype=14, targettype=0, callbacktype=0, usetime=50, position=0, limit=3000, autoforward=true },--位移
                            [9] = { atype=1, srctype=2, targettype=4, animid=300, limit=3000, callbacktype=0 },--动作
                            [10] = { atype=5, buffid=18, bufflv=5, targettype=0, },
						}
                    },
                },
            },
            [4] = { name="技能1伤害", duration=0, overlap=0, property=33,
                trigger = {
                    [1] = { activetype=3, triggertype=1, delay=50,
                         action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=13 },--伤害特效
                         }
                    },
                },
            },
            [5] = { name="80%免疫所有伤害", duration=1000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                         action = {
                            [1] = { atype=55, probability=0.8, rollback=true, },
                         }
                    },
                },
            },
        },
    },
    [19] = { name="不杀之枭",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=201, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=19, bufflv=4, targettype=0, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=200, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=321 },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=6, srctype=2, targettype=6, callbacktype=0, limit=3000, effectid=60 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=19, bufflv=6, targettype=0 },--添加移动伤害BUFF
						}
                    },
                }
            },
            [4] = { name="技能1弹道", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=322 },--查找附近目标
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=50,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=7, targetindex=1, callbacktype=1, limit=3000, effectid=61 }, --弹道
                            [2] = { atype=5, buffid=19, bufflv=5, targettype=2,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, refskill=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=2,type=3},
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=120,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=7, targetindex=2, callbacktype=1, limit=3000, effectid=61 }, --弹道
                            [2] = { atype=5, buffid=19, bufflv=5, targettype=2,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, refskill=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=2,type=3},
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=190,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=7, targetindex=3, callbacktype=1, limit=3000, effectid=61 }, --弹道
                            [2] = { atype=5, buffid=19, bufflv=5, targettype=2,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, refskill=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=2,type=3},
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=260,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=7, targetindex=4, callbacktype=1, limit=3000, effectid=61 }, --弹道
                            [2] = { atype=5, buffid=19, bufflv=5, targettype=2,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, refskill=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=2,type=3},
                        }
                    },
                },
            },
            [5] = { name="不杀之枭技能3计数", duration=500, overlap=1, property=bit_merge(64), maxoverlap=4,
            },
            [6] = { name="移动伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1 },--记录朝向位置
                            [2] = { atype=5, buffid=19, bufflv=7, targettype=0,},
                            [3] = { atype=6, srctype=2, targettype=2, callbacktype=0, effectid=155, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=200,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=103, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=0,height=3,type=5},
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=700,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=103, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=0,height=3,type=5},
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=1200,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=103, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=0,height=3,type=5},
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=1700,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=103, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=0,height=3,type=5},
                        }
                    },
                    [6] = { activetype=3, triggertype=0, delay=2200,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=103, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27,triggertype=0,height=3,type=5},
                        }
                    },
                    [7] = { activetype=3, triggertype=0, delay=2700,
                        action = {
                            [1] = { atype=11, buffid=19, bufflv=5, targettype=0,},
                            [2] = { atype=6, srctype=2, targettype=2, callbacktype=0, effectid=156, position=4, speed=2, passtime=1000,direct=1,directoffset=0 },--移动特效
                            [3] = { atype=15 },
                        },
                    },
                },
            },
            [7] = { name="隐身", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=19,   enable=false, rollback=true},
                            [2] = { atype=70, search=false, rollback=true,},
                            [3] = { atype=71, enable=false, rollback=true},
                        },
                    },
                },
            },
        },
    },
    [20] = { name="笛口雏实",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=155, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=345},
                            [3] = { atype=5, buffid=20, bufflv=4, targettype=1 }
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=156, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=346 },
                            [3] = { atype=5, buffid=20, bufflv=10, targettype=4, },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=20, bufflv=10, targettype=4, },
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=157, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=62 },--搜索附近的友方
                            [3] = { atype=5, buffid=20, bufflv=5, targettype=1 },--添加治疗
                            -- [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=253 },--
						}
                    },
                }
            },
            [4] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=253,},--
                        }
                    },
                }
            },
            [5] = { name="治疗", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=1 },--恢复生命
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=321,},--
                        }
                    },
                }
            },
            [6] = { name="治疗特效", duration=1100, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18034, durationtime=0, rollback=true, },
                        }
                    },
                }
            },
            [7] = { name="加速", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [2] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true }, --增加攻击速度
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=51, rollback=true, durationtime=0},--加速特效
						}
                    },
                }
            },
            [8] = { name="觉醒技能3", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=157, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=331 },--搜索附近的友方
                            [3] = { atype=5, buffid=20, bufflv=11, targettype=1 },--添加治疗
                        }
                    },
                }
            },
            [9] = { name="觉醒治疗", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=2 },
                        }
                    },
                }
            },
            [10] = { name="技能2 伤害减速", duration=3000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=208,},--
                            [3] = { atype=3, abilityname="move_speed", rollback=true, },
                        }
                    },
                },
            },
            [11] = { name="治疗", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=1 },--恢复生命
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=321,},--
                            [3] = { atype=2, usetype=0, typeindex=332 },--搜索附近的友方
                            [4] = { atype=5, buffid=20, bufflv=9, targettype=1 },--添加治疗
                        }
                    },
                }
            },
        },
    },
    [21] = { name="笛口凉子",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=237, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=79 },--搜索附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--添加治疗BUFF
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=406,},--
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=238, limit=3000, callbacktype=1 },--做动作放弹道
                            [2] = { atype=2, usetype=0, typeindex=173 },--搜索附近目标
                            [3] = { atype=5, buffid=21, bufflv=4, targettype=1 },--添加击飞BUFF
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=239, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=88, },
                            [3] = { atype=5, buffid=21, bufflv=8, targettype=1, },
						}
                    },
                }
            },
            [4] = { name="技能2 增益状态", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=21, bufflv=5, targettype=0, actionodds=0.4, },
                            [2] = { atype=5, buffid=21, bufflv=6, targettype=0, actionodds=0.4, },
                            [3] = { atype=5, buffid=21, bufflv=7, targettype=0, actionodds=0.4, },
                        }
                    },
                }
            },
            [5] = { name="技能2 增益状态1", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="atk_power", rollback=true, },
                        }
                    },
                }
            },
            [6] = { name="技能2 增益状态2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="def_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
            [7] = { name="技能2 增益状态3", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="crit_rate", rollback=true, },
                        }
                    },
                }
            },
            [8] = { name="技能3 伤害+buff", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=407,},--
                            [3] = { atype=5, buffid=21, bufflv=9, targettype=0, actionodds=0.3, },
                            [4] = { atype=5, buffid=21, bufflv=10, targettype=0, actionodds=0.3, },
                            [5] = { atype=5, buffid=21, bufflv=11, targettype=0, actionodds=0.3, },
                            [6] = { atype=5, buffid=21, bufflv=12, targettype=0, actionodds=0.3, fail_buffid=21, fail_bufflv=13},
                        }
                    },
                }
            },
            [9] = { name="技能3 减益状态1", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="atk_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18048, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
            [10] = { name="技能3 减益状态2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="def_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },--
                        }
                    },
                }
            },
            [11] = { name="技能3 减益状态3", duration=5000, overlap=0, property=bit_merge(64),
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
            [12] = { name="技能3 减益状态4", duration=2000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                }
            },
            [13] = { name="技能3 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
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
    [22] = { name="原创CCG炮形昆克",
        level = {
            [1] = { name="技能1", duration=10000, overlap=0, property=48,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=26, durationtime=0, rollback=true },--特效
						}
                    },
                    [2] = { activetype=2, triggertype=1, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=4, angle=360, enemy=true, layer=lay_all_role },--搜索附近目标
                            [2] = { atype=5, buffid=22, bufflv=4, targettype=1 },--设置使用技能时BUFF
						}
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=36, objtype=3, value=15, times=3 },--下3次普通攻击伤害增加
                            [2] = { atype=15 }
						}
                    },
                }
            },
            [4] = { name="设置使用技能时BUFF", duration=1100, overlap=2, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=34, buffid=22, bufflv=5 },
						}
                    },
                    [2] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=34, buffid=0, bufflv=0 },
						}
                    },
                }
            },
            [5] = { name="伤害+沉默", duration=5000, overlap=0, property=33,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=7, effect_type=4, rollback=true }, --沉默
						}
                    },
                }
            },
            [6] = { name="普攻伤害增加", duration=-1, overlap=4, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=35, objtype=1, scale=1.5, times=-1, rollback=true },
						}
                    },
                }
            },
        },
    },
    [23] = { name="原创CCG炮形昆克被动BUFF",
        level = {
            [1] = { name="被动BUFF", duration=10000, overlap=0, property=48, skillid=39,
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=7, group=1,--周围400码有友方英雄
                        action = {
                            [1] = { atype=5, buffid=22, bufflv=6, targettype=0 }, --添加普攻伤害增加BUFF
                        }
                    },
                    [2] = { activetype=0, triggertype=0, group=1,--周围400码没有友方英雄
                        action = {
                            [1] = { atype=11, buffid=22, bufflv=6, immediately=true }
                        }
                    },
                }
            },
        },
    },
    [24] = { name="魔猿",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=60, id=81102207, follow=true, unique=false, autostop=true, rollback=true, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=860, lock=true, limit=3000, callbacktype=0, rollback=true, },--做动作
                            [3] = { atype=41, abilityname="def_power", valuetype=1, rollback=true, },
                            [4] = { atype=32, type=1, offset=7,},
                            [5] = { atype=2, usetype=0, typeindex=44},
                            [6] = { atype=13, targettype=0, srctype=0, speed=10, buffid=24, bufflv=4, },
                            [7] = { atype=14, targettype=0, callbacktype=0, direct=1, distance=7, speed=10, limit=3000, },
                            [8] = { atype=15, },
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=857, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=179 },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害
                            [4] = { atype=6, srctype=5, targettype=0, effectid=261, callbacktype=0, },
                            [5] = { atype=2, usetype=0, typeindex=208 },--查找附近目标
                            [6] = { atype=5, buffid=24, bufflv=5, targettype=1 },--加伤害
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=855, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=1, srctype=2, targettype=4, animid=856, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=2, usetype=0, typeindex=254 },--查找目标
                            [4] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=1, },--加伤害BUFF
                            [5] = { atype=20, delay=33*1, },
                            [6] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=2, },--加伤害BUFF
                            [7] = { atype=20, delay=33*1, },
                            [8] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=3, },--加伤害BUFF
                            [9] = { atype=20, delay=33*1, },
                            [10] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=4, },--加伤害BUFF
                            [11] = { atype=20, delay=33*1, },
                            [12] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=5, },--加伤害BUFF
                            [13] = { atype=20, delay=33*1, },
                            [14] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=6, },--加伤害BUFF
                            [15] = { atype=20, delay=33*1, },
                            [16] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=7, },--加伤害BUFF
                            [17] = { atype=20, delay=33*1, },
                            [18] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=8, },--加伤害BUFF
                            [19] = { atype=20, delay=33*1, },
                            [20] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=9, },--加伤害BUFF
                            [21] = { atype=20, delay=33*1, },
                            [22] = { atype=5, buffid=24, bufflv=6, targettype=1, targetindex=10, },--加伤害BUFF
                        }
                    },
                }
            },
            [4] = { name="技能1 击退+伤害+减速", duration=3000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=3, abilityname="move_speed", rollback=true, },
                            [3] = { atype=14, position=4, speed=10, callbacktype=0, limit=3000, }
						}
                    },
                }
            },
            [5] = { name="技能2 反伤", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=97, type=7, scale=0.2, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                }
            },
            [6] = { name="技能3 概率眩晕+伤害", duration=0, overlap=1, property=bit_merge(64), maxoverlap=5,
                trigger = {
                    [1] = { activetype=0, triggertype=1, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=5, buffid=24, bufflv=7, targettype=0, actionodds=0.3, },
                        },
                    },
                },
            },
            [7] = { name="技能3 眩晕", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        },
                    },
                },
            },
            [8] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=855, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=1, srctype=2, targettype=4, animid=856, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=2, usetype=0, typeindex=254 },--查找目标
                            [4] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=1, },--加伤害BUFF
                            [5] = { atype=20, delay=33*1, },
                            [6] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=2, },--加伤害BUFF
                            [7] = { atype=20, delay=33*1, },
                            [8] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=3, },--加伤害BUFF
                            [9] = { atype=20, delay=33*1, },
                            [10] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=4, },--加伤害BUFF
                            [11] = { atype=20, delay=33*1, },
                            [12] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=5, },--加伤害BUFF
                            [13] = { atype=20, delay=33*1, },
                            [14] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=6, },--加伤害BUFF
                            [15] = { atype=20, delay=33*1, },
                            [16] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=7, },--加伤害BUFF
                            [17] = { atype=20, delay=33*1, },
                            [18] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=8, },--加伤害BUFF
                            [19] = { atype=20, delay=33*1, },
                            [20] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=9, },--加伤害BUFF
                            [21] = { atype=20, delay=33*1, },
                            [22] = { atype=5, buffid=24, bufflv=9, targettype=1, targetindex=10, },--加伤害BUFF
                        }
                    },
                }
            },
            [9] = { name="觉醒技能3 概率眩晕+伤害", duration=0, overlap=1, property=bit_merge(64), maxoverlap=5,
                trigger = {
                    [1] = { activetype=0, triggertype=1, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=5, buffid=24, bufflv=7, targettype=0, actionodds=0.6, fail_buffid=24, fail_bufflv=10, },
                        },
                    },
                },
            },
            [10] = { name="技能3 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
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
    [25] = { name="独眼之枭",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=324, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=53 },--查找目标
                            [3] = { atype=23,targettype=0,distance=0},--击退
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=323, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=6, srctype=2, targettype=0, effectid=68, callbacktype=0, durationtime=1000 },
                            [3] = { atype=2, usetype=0, typeindex=51 },
                            [4] = { atype=27,targettype=0,distance=0, type=1},
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [6] = { atype=5, buffid=25, bufflv=4, targettype=1 },--添加高速拳标记BUFF
                            [7] = { atype=2, usetype=0, typeindex=52 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1 },--记录位置和朝向
                            [2] = { atype=1, srctype=2, targettype=4, animid=322, limit=3000, callbacktype=1 },--做动作
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=462,
                        action = {
                            [1] = { atype=5, buffid=25, bufflv=5, targettype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=759,
                        action = {
                            [1] = { atype=5, buffid=25, bufflv=5, targettype=0 },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=1570,
                        action = {
                            [1] = { atype=5, buffid=25, bufflv=5, targettype=0 },
                        }
                    },
                }
            },
            [4] = { name="减速", duration=3000, overlap=5, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true },
                        }
                    },
                }
            },
            [5] = { name="赫子攻击", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=65, position=6, length=2, durationtime=0 },--移动特效
                            [2] = { atype=2, typeindex=54 },--查找特效附近目标
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=66 },--加伤害BUFF
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=27,targettype=0,type=5,height=3,distance=0},
                            [6] = { atype=54,},
						}
                    },
                }
            }, 
        },
    },
    [26] = { name="铃屋什造",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=164, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=158 },--查找附近目标
                            -- [3] = { atype=6, srctype=2, targettype=0, effectid=81, callbacktype=0, },
                            [3] = { atype=13, buffid=26, bufflv=8, targettype=0, srctype=0, speed=15, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=168, limit=3000, callbacktype=1 },--做预备动作
                            [2] = { atype=1, srctype=2, targettype=4, animid=169, limit=3000, callbacktype=0 },--做动作
                            [3] = { atype=2, usetype=0, typeindex=46 },--查找直线目标
                            [4] = { atype=5, buffid=26, bufflv=4, targettype=1 },
                            [5] = { atype=14, targettype=0, callbacktype=0, usetime=330, direct=1, distance=5, limit=3000, limit=3000 },--位移
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=bit_merge(1,2,4,16,32,64,128,256,512), rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=167, limit=3000, callbacktype=1 },--做动作
                            -- [2] = { atype=2, usetype=0, typeindex=44 },--查找附近目标
                            -- [3] = { atype=5, buffid=26, bufflv=5, targettype=1},
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=300,
                        action = {
                            [1] = { atype=2, typeindex=45 },--查找附近目标
                            [2] = { atype=5, buffid=26, bufflv=9, targettype=1 },--加伤害BUFF
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
                            [1] = { atype=66, skillid=47, bossadd=1, notbossadd=1, heroadd=1, buffid=26, bufflv=7, rollback=true },
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
                            [3] = { atype=5, buffid=26, bufflv=10, targettype=0, },
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
            [11] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=bit_merge(1,2,4,16,32,64,128,256,512), rollback=true,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=167, limit=3000, callbacktype=1 },--做动作
                            -- [2] = { atype=2, usetype=0, typeindex=44 },--查找附近目标
                            -- [3] = { atype=5, buffid=26, bufflv=5, targettype=1},
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=350,
                        action = {
                            [1] = { atype=2, typeindex=45 },--查找附近目标
                            [2] = { atype=5, buffid=26, bufflv=9, targettype=1 },--加伤害BUFF
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=57 },--加受击特效
                            [4] = { atype=27, targettype=0, height=1, type=6 },
                        }
                    },
                }
            },
        },
    },
    [27] = { name="多多良",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=190, limit=3000, callbacktype=2, refskill=1 },
                            [2] = { atype=5, buffid=27, bufflv=4, targettype=2, maxnes=2 },
                            [3] = { atype=5, buffid=27, bufflv=5, targettype=2 },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=2000, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=115, rollback=true, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=189, limit=3000, callbacktype=1 }, --前刺动作1
                            [3] = { atype=1, srctype=2, targettype=4, animid=454, limit=3000, callbacktype=0 }, --前刺动作2
                            [4] = { atype=5, buffid=27, bufflv=6, targettype=0 }, --加制造持续范围伤害BUFF
                        }
                    },
                    [2] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=28 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=455, limit=3000, callbacktype=0 }, --前刺动作3
                            [3] = { atype=11, buffid=27, bufflv=6, targettype=0, }--移除制造持续范围伤害BUFF
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=8500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=188, limit=3000, callbacktype=1 }, --
                            [3] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [4] = { atype=3, abilityname="atk_power", rollback=true }, --增加攻击
                            [5] = { atype=6, srctype=6, targettype=0, position=3, rollback=true, effectid=114, durationtime=0, callbacktype=0, },
						}
                    },
                    [2] = { activetype=2, triggertype=1, interval=500,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, position=2, enemy=false, includeself=false, layer=lay_all_role },--查找附近目标
                            [2] = { atype=5, buffid=27, bufflv=8, targettype=1 },--添加移速+物强提高
						}
                    },
                }
            },
            [4] = { name="技能1反弹", duration=0, property=bit_merge(1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=5, radius=5, angle=360, enemy=true },
                            [2] = { atype=6, srctype=2, targettype=6, effectid=82, limit=3000, callbacktype=1, musttarget=1 },
                            [3] = { atype=5, buffid=27, bufflv=4, targettype=2 },
                            [4] = { atype=5, buffid=27, bufflv=5, targettype=2 },
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    }
                }
            },
            [5] = { name="眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                },
            },
            [6] = { name="制造持续范围伤害", duration=-1, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=450,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=120, radius=3.25, sorttype=0, layer=lay_all_role, enemy=true }, --找目标
                            [2] = { atype=5, buffid=27, bufflv=7, targettype=1 }, --加伤害BUFF
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=18.22 },
                        }
                    },
                }
            },
            [7] = { name="伤害+25%生命额外", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1, condition=9, group=1,--生命值比例小于25%
                        action = {
                            [1] = { atype=37, value=4 },--受到额外伤害
                            [2] = { atype=4, type=0, infoindex=1, }--伤害
                        }
                    },
                    [2] = { activetype=0, triggertype=1, group=1,--生命值比例大于等于25%
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, }--伤害
                        }
                    },
                }  
            },
            [8] = { name="移速+攻击提高", duration=500, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [2] = { atype=3, abilityname="atk_power", rollback=true }, --增加攻击
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=55, durationtime=0, rollback=true },--加特效  
						}
                    },
                }
            },
        },
    },
    [28] = { name="御坂",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=637, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=27, targettype=0, distance=2, distype=0, type=3 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=187 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=636, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, layer=lay_all_role },--查找附近目标
                            [3] = { atype=5, buffid=28, bufflv=4, targettype=1 },--加定身+伤害BUFF
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=3500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=189, durationtime=0, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=635, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=5, buffid=28, bufflv=5, targettype=2, rollback=true },--加抓取+伤害BUFF
						}
                    },
                    [2] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=28 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=190 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=191 },
						}
                    },
                }
            },
            [4] = { name="定身+伤害", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                            [3] = { atype=27, targettype=1, type=3 },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=188 },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=236, durationtime=0, rollback=true },
						}
                    },
                    [2] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=5, buffid=28, bufflv=6, targettype=0, },
                        },
                    },
                }
            },
            [5] = { name="抓取+伤害", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=78, type=0, rollback=true },
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
						}
                    },
                }
            },
            [6] = { name="技能2 降低移动速度", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                        },
                    },
                },
            },
        },
    },
    [29] = { name="瓶兄",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=3 },--当前目标
                            [2] = { atype=14, targettype=2, callbacktype=0, usetime=0, offset=2, offsettype=1, finaltorward=1, limit=3000, callbacktype=0 },--瞬移到身后
                            [3] = { atype=1, srctype=2, targettype=4, animid=715, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=15 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=2, effectid=158, limit=3000, callbacktype=0,},
                            [2] = { atype=1, srctype=2, targettype=4, animid=713, limit=3000, callbacktype=1 },--做动作
                            [3] = { atype=2, srctype=1, targettype=1, angle=120, enemy=true, layer=lay_all_role },--查找附近目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=27, targettype=0, distance=0, limit=3000, type=3,}
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=3000, overlap=0, property=bit_merge(64, 4),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=73, rollback=true },
                            [2] = { atype=15 },
                            [3] = { atype=76, type=0, value=1 },
						}
                    },
                }
            },
        },
    },
    [31] = { name="篠原幸纪",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,--condition=26,group=1,--如果是重击状态
                        action = {
                            -- [1] = { atype=5, buffid=31, bufflv=12, targettype=0},
                            [1] = { atype=5, buffid=31, bufflv=14, targettype=0},
                            -- [3] = { atype=11, buffid=31, bufflv=11, targettype=0},
                            -- [4] = { atype=11, buffid=31, bufflv=13, targettype=0},
                            [2] = { atype=15,}
                        }
                    },
                    -- [2] = { activetype=0, triggertype=0,group=1,
                    --     action = {
                    --         [1] = { atype=5, buffid=31, bufflv=11, targettype=0},
                    --         [2] = { atype=5, buffid=31, bufflv=13, targettype=0},
                    --         [3] = { atype=11, buffid=31, bufflv=12, targettype=0},
                    --         [4] = { atype=11, buffid=31, bufflv=14, targettype=0},
                    --         [5] = { atype=15,}
                    --     }
                    -- },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,group=1,condition=13,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=281, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, radius=5, angle=120, enemy=true, layer=lay_all_role },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=5, buffid=31, bufflv=6, targettype=1},--加眩晕BUFF
                            -- [5] = { atype=11,buffid=31, bufflv=5, targettype=0},
                            -- [6] = { atype=11,buffid=31, bufflv=8, targettype=0},
                            -- [6] = { atype=5, buffid=31, bufflv=15, targettype=0},--加延迟移除狂化状态BUFF
                        }
                    },
                    [2] = {  activetype=0, triggertype=0,group=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=274, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, srctype=1, targettype=1, radius=5, angle=120, enemy=true, layer=lay_all_role },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=5, buffid=31, bufflv=6, targettype=1},--加眩晕BUFF
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            -- [4] = { atype=11,buffid=31, bufflv=5, targettype=0},
                            -- [5] = { atype=11,buffid=31, bufflv=8, targettype=0},
                            -- [5] = { atype=5, buffid=31, bufflv=15, targettype=0},--加延迟移除狂化状态BUFF
                        },
                    },
                    -- [3] = { activetype=0, triggertype=0, condition=12, --当前是PVE模式
                    --     action = {
                    --         [1] = { atype=5, buffid=31, bufflv=7, targettype=0 },--加延迟添加狂化状态BUFF
                    --     }
                    -- },
                    -- [4] = {activetype=1, triggertype=0,
                    --     action = {
                    --         [1] = {atype=5, buffid=31, bufflv=10, targettype=0}
                    --     },
                    -- },
                },
            },
            [3] = { name="技能3", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="max_hp", rollback=true },
                            [2] = { atype=3, abilityname="def_power", rollback=true },
                            [3] = { atype=39, buffid=31, bufflv=4, rollback=true },
                            [4] = { atype=6, srctype=2,targettype=0,effectid=113, callbacktype=0,},
                            [5] = { atype=22, type=bit_merge(8), rollback=true }, --免疫嘲讽
                            [6] = { atype=40, modelid=80001027, rollback=true},
                            [7] = { atype=15 },
                            [8] = { atype=5, buffid=31, bufflv=5, rollback=true,},
                        }
                    },
                }
            },
            [4] = { name="受到伤害回复生命", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=25, type=2, value=0.1 }--恢复1%生命
                        }
                    },
                }
            },
            [5] = { name="狂化状态", duration=-1, overlap=1, property=bit_merge(64),maxoverlap=9,attention_skill=1,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=5, buffid=31, bufflv=9, targettype=0},
                        }
                    },
                    [2] = {activetype=1, triggertype=0,
                        action = {
                            -- [1] = {atype=5, buffid=31, bufflv=10, targettype=0}
                        },
                    },
                },
            },
            [6] = { name="眩晕", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1},--定身特效
                        }
                    },
                }
            },
            -- [7] = { name="延迟添加狂化状态", duration=10000, overlap=0, property=bit_merge(64),
            --     trigger = {
            --         [1] = { activetype=1, triggertype=0,
            --             action = {
            --                 [1] = { atype=5, buffid=31, bufflv=5, targettype=0, overlap=9 },--添加狂化BUFF
            --                 [2] = { atype=5, buffid=31, bufflv=8, targettype=0,},--添加狂化BUFF
            --             }
            --         },
            --     }
            -- },
            -- [8] = { name="狂化效果",duration=-1,overlap=0,property=bit_merge(64),
            --     trigger = {
            --         [1] = { activetype=0, triggertype=0,
            --             action = {
            --                 [1] = { atype=3, abilityname="phy_pene", rollback=true },
            --                 [2] = { atype=3, abilityname="energy_pene", rollback=true },
            --                 [3] = { atype=6, srctype=2,targettype=0,effectid=111, callbacktype=0,}
            --             }
            --         },
            --     }
            -- },
            -- [9] = {name="篠原幸纪变大BUFF", duration=500, overlap=0, property=bit_merge(64),
            -- trigger = {
            --         [1] = { activetype=2, triggertype=0, interval=1,
            --             action = {
            --                 [1] = { atype=33, scale=0.01, type=1}, --改变大小
            --             }
            --         },
            --     }
            -- },
            -- [10] = {name="篠原幸纪变小BUFF", duration=500, overlap=0, property=bit_merge(64), 
            -- trigger = {
            --         [1] = { activetype=2, triggertype=0, interval=1,
            --             action = {
            --                 [1] = { atype=33, scale=-0.01, type=1}, --改变大小
            --             }
            --         },
            --     }
            -- },
            -- [11] = { name="重击状态", duration=-1, overlap=1, property=bit_merge(64),
            -- },
            -- [12] = { name="普通状态", duration=-1, overlap=1, property=bit_merge(64),
            -- },
            -- [13] = { name="重击状态效果", duration=5000, overlap=1, property=bit_merge(64),
            -- trigger = {
            --         [1] = { activetype=0, triggertype=0,
            --             action = {
            --                 [1] = { atype=3, abilityname="move_speed", rollback=true },
            --                 [2] = { atype=6, srctype=2,targettype=0,effectid=109, callbacktype=0,limit=3000},
            --                 [3] = { atype=6, srctype=2, targettype=0, effectid=110, callbacktype=0, durationtime=0, rollback=true},
            --             }
            --         },
            --     }
            -- },
            [14] = { name="普通状态效果", duration=5000, overlap=1, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="energy_bloodsuck", valuetype=1, rollback=true },
                            [2] = { atype=6, srctype=2,targettype=0,effectid=107, callbacktype=0,limit=3000},
                        }
                    },
                }
            },
            -- [15] = { name="延迟移除狂化状态", duration=800, overlap=0, property=bit_merge(64),
            --     trigger = {
            --         [1] = { activetype=1, triggertype=0,
            --             action = {
            --                 [1] = { atype=11,buffid=31, bufflv=8, targettype=0},
            --             },
            --         },
            --     },
            -- },
        },
    },
    --[[[32] = { name="篠原幸纪被动BUFF",
        level = {
            [1] = { name="被动BUFF", duration=0, overlap=0, property=32, skillid=59,
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=12, group=1,--当前是PVE模式
                        action = {
                            [1] = { atype=5, buffid=31, bufflv=5, targettype=0, overlap=9 },--添加狂化BUFF
                            [2] = { atype=5, buffid=31, bufflv=8, targettype=0,},--添加狂化BUFF
                        }
                    },
                    [2] = { activetype=0, triggertype=0, group=1,--当前不是PVE模式
                        action = {
                        }
                    },
                }
            },
        }
    },]]
    [33] = { name="平子丈",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=147, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=49 }, --找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 }, --加伤害BUFF
                            [4] = { atype=6, srctype=6, targettype=0, effectid=89, callbacktype=0,},
                            -- [4] = { atype=5, buffid=33, bufflv=7, targettype=1 }, --
                            -- [5] = { atype=5, buffid=33, bufflv=8, targettype=0, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=146, limit=3000, callbacktype=1 },--预备动作
                            [2] = { atype=14, targettype=0, usetime=500, position=3, autoforward=true, },--位移
                            [3] = { atype=1, srctype=2, targettype=0, animid=151, limit=3000, callbacktype=1 },--跳跃动作
                            [4] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=48, position=7,len=1 },--践踏特效
                            -- [5] = { atype=24, type=1, rollback=true,},
                            [5] = { atype=2, usetype=0, typeindex=48 }, --找范围目标
                            [6] = { atype=5, buffid=33, bufflv=5, targettype=1, },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=33, bufflv=4, targettype=0, rollback=true },--添加激发剑气BUFF
                            [2] = { atype=1, srctype=2, targettype=4, animid=145, limit=3000, callbacktype=1 }, --前刺动作1
                            -- [3] = { atype=11,buffid=33, bufflv=4,targettype=0 },
                            [3] = { atype=2, usetype=0, typeindex=47 },--查找附近目标
                            -- [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=90 },--加受击特效
                            [4] = { atype=5, buffid=33, bufflv=6,targettype=1}, 
						}
                    },
                }
            },
            [4] = { name="激发剑气", duration=-1, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=280,
                        action = {
                            [1] = { atype=2, typeindex=50, arraytype=0 },--查找附近目标
                            [2] = { atype=27, targettype=3, height=1, type=6 },--
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=470,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=4 },--加伤害BUFF
                            [2] = { atype=6, srctype=9, targettype=0, callbacktype=0, effectid=91 },--加受击特效
                            [3] = { atype=60, id="81100017.81100020", targettype=3, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                }
            },
            [5] = { name="技能2 伤害", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=90, },
                            [3] = { atype=3, abilityname="move_speed", rollback=true,},
                            -- [3] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true,},
						}
                    },
                }
            },
            [6] = { name="技能1击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=0, usetime=100, direct=4, distance=2 },
                        }
                    },
                }
            },
            [7] = { name="技能3击退", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=27, targettype=1,distance=0,type=3},
                        }
                    },
                }
            },
            [8] = { name="增加格挡", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=41, abilityname="parry_rate", valuetype=1, rollback=true,},
                        }
                    },
                }
            },
            [9] = { name="技能2伤害+范围溅射", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },--伤害
                            -- [2] = { atype=2, usetype=0, typeindex=48 }, --找范围目标
                            -- [3] = { atype=5, buffid=33, bufflv=5, targettype=1 }, --根据距离加BUFF
                        },
                    },
                },
            },
            [10] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=33, bufflv=4, targettype=0, rollback=true, },--添加激发剑气BUFF
                            [2] = { atype=1, srctype=2, targettype=4, animid=149, limit=3000, callbacktype=1 }, --前刺动作1
                            -- [3] = { atype=11,buffid=33, bufflv=4,targettype=0 },
                            [3] = { atype=2, usetype=0, typeindex=326 },--查找附近目标
                            [4] = { atype=5, buffid=33, bufflv=6,targettype=1}, 
                        }
                    },
                }
            },
        },
    },
    [34] = { name="黑磐岩",
        level = {
            [1] = { name="技能1", duration=6000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="max_hp", rollback=true },--增加15%生命上限
                            [2] = { atype=25, type=1, value=200 },--恢复200点生命
                            [3] = { atype=15,},
                            [4] = { atype=6, srctype=2, targettype=0, limit=3000, callbacktype=0, effectid=139, rollback=true,},
						}
                    },
                    [2] = { activetype=2, triggertype=0, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=6, radius=4, enemy=false, layer=lay_all_role, includeself=false, },--查找目标
                            [2] = { atype=5, buffid=34, bufflv=4, targettype=1 },--添加伤害转移BUFF
                            
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=1, usetime=330, direct=1, distance=3, offset=1, offsettype=0 },--位移
                            [2] = { atype=1, srctype=2, targettype=4, animid=570, limit=3000, callbacktype=1 },
                            [3] = { atype=24, rollback=true },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=2 }, --根据距离加BUFF
                            [5] = { atype=25, type=0, value=0.1 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=571, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true }, --找范围目标
                            [3] = { atype=5, buffid=34, bufflv=5, targettype=1 }, --加嘲讽+伤害
						}
                    },
                }
            },
            [4] = { name="伤害转移", duration=800, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=42, persent=0.5, }--伤害转移
						}
                    },
                }
            },
            [5] = { name="嘲讽+伤害", duration=2000, overlap=2, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=75, rollback=true }, --嘲讽
                            [3] = { atype=6, srctype=2, targettype=0, limit=3000, callbacktype=0, effectid=141,},
                            [4] = { atype=6, srctype=2, targettype=0, limit=3000, callbacktype=0, effectid=145, rollback=true,},
						}
                    },
                }
            },
        },
    },
    [35] = { name="法寺项介",
        level = {
             [1] = { name="技能1", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=47, type=0, value=2, buffid=35, bufflv=11, rollback=true }, --伤害吸收
                            [2] = { atype=15},
                        }
                    },
                    [2] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=15, lock=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=563, limit=3000, callbacktype=1 }, --动作
                            [3] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role }, --找范围目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [5] = { atype=28, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=52, old_id=10, new_id=561, rollback=true },
                            [2] = { atype=15 },
						}
                    },
                    [2] = { activetype=2, triggertype=1, interval=50,
                        action = {
                            [1] = { atype=5, buffid=35, bufflv=7, targettype=0 },--加检测前方BUFF
                        }
                    },
                    [3] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=15, lock=1 },
                            [2] = { atype=48 },
                            [3] = { atype=2, srctype=1, targettype=4, length=2, width=2, targetcnt=1, sorttype=0, layer=lay_all_role, enemy=true }, --找范围目标
                            [4] = { atype=1, srctype=2, targettype=4, animid=562, limit=3000, callbacktype=0 }, --收回动作
                            [5] = { atype=5, buffid=35, bufflv=8, targettype=1 },
                            [6] = { atype=28 },
						}
                    },
                    [4] = { activetype=2, triggertype=1, interval=200,
                        action = {
                            [1] = { atype=5, buffid=35, bufflv=9, targettype=0, }, --加破坏地面buff
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=558, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role }, --找范围目标
                            [3] = { atype=5, buffid=35, bufflv=4, targettype=1 },--加吸引BUFF
                            [4] = { atype=1, srctype=2, targettype=4, animid=559, limit=5000, callbacktype=0 },--动作
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=500,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=4, angle=360, enemy=true, layer=lay_all_role }, --找范围目标
                            [2] = { atype=5, buffid=35, bufflv=4, targettype=1 },--加减速BUFF
                        }
                    },
                    [3] = { activetype=1, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=560, limit=3000, callbacktype=0 },--动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, enemy=true, layer=lay_all_role }, --找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [4] = { atype=28 },
                        }
                    }
                }
            },
            [4] = { name="吸引", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=3, usetime=1000, offset=0.5, offsettype=0, distance=1 },--吸引位置
                        }
                    },
                },
            },
            [5] = { name="减速", duration=800, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                        }
                    },
                },
            },
            -- [6] = { name="延迟加护盾", duration=8000, overlap=0, property=bit_merge(64),
            --     trigger = {
            --         [1] = { activetype=1, triggertype=0,
            --             action = {
            --                 [1] = { atype=5, buffid=36, bufflv=1, targettype=0 }, --添加护盾BUFF
            --             }
            --         },
            --     },
            -- },
            [7] = { name="检测前方", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=1, triggertype=0, condition=14,  --如果前方有敌人
                        action = {
                            [1] = { atype=11, buffid=35, bufflv=2, targettype=0 },
                        }
                    },
                },
            },
            [8] = { name="击飞+伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=27, targettype=1, distance=0, distype=0, type=5 },
                            [2] = { atype=4, type=0, infoindex=1 },
                        }
                    },
                },
            },
            [9] = { name="破坏地面buff", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, effectid=201, callbacktype=0, position=3, rollback=true, },
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=50,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=4, length=3, width=3, layer=lay_all_role, enemy=true },
                            [2] = { atype=5, buffid=35, bufflv=10, targettype=1,},
                        }
                    },
                },
            },
            [10] = { name="减速", duration=3000, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --改变移动速度
                        }
                    },
                },
            },
            [11] = { name="护盾移除", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=11, buffid=35, bufflv=3, targettype=0, },
                        }
                    },
                },
            },
        },
    },
    [37] = { name="泷泽政道",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=289, limit=3000, callbacktype=2 },  --先发射
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2, },
                            -- [3] = { atype=5, buffid=37, bufflv=6, targettype=2, },
                            -- [4] = { atype=27, type=3, targettype=2, distance=2, distype=0 },
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=290, limit=3000, callbacktype=1 },  --先发射
                            [2] = { atype=2, usetype=0, typeindex=87 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [4] = { atype=5, buffid=37, bufflv=5, targettype=0 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=77, },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=288, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=85 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, type=3, targettype=0 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=79, },
                        }
                    },
                }
            },
            [4] = { name="加眩晕+伤害BUFF", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=4, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                            [3] = { atype=4, type=0, infoindex=1 },
						}
                    },
                }
            },
            [5] = { name="瓦斯雾", duration=4200, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, offset=3.7 },--记录前方位置
                            -- [2] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=79, durationtime=0, position=5, rollback=true },--特效
    					}
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=2, typeindex=86 },--查找目标
                            [2] = { atype=5, buffid=1, bufflv=2, targettype=1,},
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=77, },
                            -- [2] = { atype=5, buffid=37, bufflv=6, targettype=1 },--加中毒BUFF
                            -- [3] = { atype=5, buffid=37, bufflv=7, targettype=1 },--加中毒特效
                        }
                    },
                }
            },
            -- [6] = { name="持续伤害", duration=6000, overlap=5, property=bit_merge(64,1),
            --     trigger = {
            --         [1] = { activetype=0, triggertype=1,
            --             action = {
            --                  [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18036, rollback=true, durationtime=0 },
            --             }
            --         },
            --         [2] = { activetype=2, triggertype=0, interval=1000, immediately=false,
            --             action = {
            --                 -- [1] = { atype=11, buffid=37, bufflv=7, targettype=0,},
            --                 [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},
            --             },
            --         },
            --     },
            -- },
        },
    },
    [38] = { name="有马贵将",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=681, limit=3000, callbacktype=1 },
                            [2] = { atype=24, rollback=true },
                            [3] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=25, type=0, value=0.5 },
                            [6] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=186,},--特效
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=680, limit=3000, callbacktype=2 },
                            -- [2] = { atype=6, srctype=2, targettype=4, callbacktype=1, effectid=184, limit=3000,},--特效
                            [2] = { atype=5, buffid=38, bufflv=4, targettype=2 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=679, limit=3000, callbacktype=1 },
                            [2] = { atype=77, rollback=true,},
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=184, rollback=true, durationtime=0, },--特效
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=183,},--特效
                        }
                    },
                }
            },
            [4] = { name="挑起砸地", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=27, targettype=1, limit=3000, distance=0, distype=0, type=5 },
                            [2] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, includeself=true, layer=lay_all_role },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=2, targettype=2, callbacktype=0, effectid=185,},--特效
						}
                    },
                }
            },
        },
    },
    [39] = { name="神代叉荣",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,-- condition=16, group=1,--如果周围4码有玩家
                        action = {
                            [1] = { atype=2, srctype=1, targettype=3, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=736, limit=3000, callbacktype=0 },
                            [3] = { atype=14, targettype=2, callbacktype=0, usetime=300, direct=1, speed=10, offset=1, offsettype=0, limit=3000, distance=3, },
                            [4] = { atype=5, buffid=39, bufflv=6, targettype=2 },
                            [5] = { atype=1, srctype=2, targettype=4, animid=738, limit=3000, callbacktype=1 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=735, limit=3000, callbacktype=0 },
                            [2] = { atype=2, srctype=1, targettype=4, length=4, width=1.5, layer=lay_all_role, enemy=true },--查找直线目标
                            [3] = { atype=13, buffid=1, bufflv=1, targettype=0, srctype=0, speed=16 },--根据距离加伤害BUFF
                            [4] = { atype=14, targettype=0, direct=1, distance=5, speed=15, usetime=300 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=734, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role },
                            [3] = { atype=5, buffid=39, bufflv=4, targettype=1 },
                        }
                    },
                }
            },
            [4] = { name="升龙拳效果", duration=420, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=150,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 }
						}
                    },
                },
            },
            [6] = { name="眩晕", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1},--定身特效
						}
                    },
                }
            },
        },
    },
    --[[[40] = { name="神代叉荣被动BUFF",
        level = {
            [1] = { name="被动BUFF1", duration=-1, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=5000,
                        action = {
                            [1] = { atype=5, buffid=39, bufflv=5, targettype=0 }
                        }
                    },
                }
            }
        }
    },]]
    [41] = { name="原创CCG1",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=0 },
                            [2] = { atype=2, srctype=1, targettype=4, length=4, width=2, layer=lay_all_role, enemy=true },
                            [3] = { atype=13, buffid=41, bufflv=4, targettype=0, srctype=0, speed=15 }, --加伤害BUFF根据距离速度算延迟 
						}
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, radius=4, angle=360, targetcnt=1, enemy=true, sorttype=1, layer=lay_all_role },
                            [2] = { atype=16, targettype=0 },
                            [3] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=1 },
                            [4] = { atype=5, buffid=41, bufflv=5, targettype=1 },--加拉扯BUFF
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=18,--如果只剩一个陷进
                        action = {
                            [1] = { atype=21 },
						}
                    },
                    [2] = { activetype=0, triggertype=0, condition=17,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=41, bufflv=7, targettype=0 },
                            [3] = { atype=11, buffid=41, bufflv=6, targettype=0, immediately=false },
						}
                    },
                }
            },
            [4] = { name="技能1伤害", duration=0, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 }
						}
                    },
                }
            },
            [5] = { name="拉扯+伤害", duration=0, overlap=0, property=33,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=3, usetime=100, offset=0.5, offsettype=0, distance=1 },--吸引位置
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                        }
                    },
                },
            },
            [6] = { name="机械陷阱计数", duration=-1, overlap=1, property=32, maxoverlap=3,
            },
            [7] = { name="机械陷阱", duration=-1, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0, offset=2 },--记录前方位置
                            [2] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=14, durationtime=0, position=5, rollback=true },--特效
    					}
                    },
                    [2] = { activetype=2, triggertype=1, interval=50,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, targetcnt=1, radius=1, angle=360, position=2, enemy=true, layer=lay_all_role },--查找目标
                            [2] = { atype=5, buffid=41, bufflv=8, targettype=1 },--加定身+持续伤害BUFF
                            [3] = { atype=11, targettype=0, condition=19 },--如果周围有人则删除自己
    					}
                    },
                }
            },
            [8] = { name="定身+持续伤害", duration=5000, overlap=0, property=33,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=25, rollback=true, durationtime=0, attentionaction=1},--定身特效
						}
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, 
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
						}
                    },
                }
            },
        },
    },
    [42] = { name="原创CCG1被动BUFF",
        level = {
            [1] = { name="被动BUFF", duration=-1, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=41, bufflv=6, targettype=0, overlap=3 },
						}
                    },
                    [2] = { activetype=2, triggertype=0, interval=5000,
                        action = {
                            [1] = { atype=5, buffid=41, bufflv=6, targettype=0 },
						}
                    },
                }
            },
        }
    },
    [43] = { name="田中丸望元",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=626, limit=3000, callbacktype=1 },
                            [2] = { atype=32, type=0, offset=3,},
                            [3] = { atype=2, srctype=3, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role,position=2, },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=2, srctype=3, targettype=1, radius=3, angle=360, enemy=false, layer=lay_all_role,position=2, includeself=true,},
                            [6] = { atype=5, buffid=43, bufflv=6, targettype=1 },
                            [7] = { atype=5, buffid=43, bufflv=6, targettype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=625, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=2, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role,targetcnt=1,},
                            [3] = { atype=5, buffid=43, bufflv=5, targettype=2 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=624, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=43, bufflv=4, targettype=0 },
						}
                    },
                }
            },
            [4] = { name="移动伤害", duration=1600, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=1 },--记录朝向位置
						}
                    },
                    [2] = { activetype=2, triggertype=0, interval=300,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=118, position=4, speed=4, passtime=500 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=1, angle=360, position=1, layer=lay_all_role, enemy=true },--查找特效附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                        }
                    },
                }
            },
            [5] = { name="定身+伤害", duration=2500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=119, rollback=true, durationtime=0, attentionaction=1},--定身特效
						}
                    },
                    [2] = { activetype=2, triggertype=1, interval=500,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                        },
                    },
                }
            },
            [6] = { name="增加攻击力", duration=4000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="atk_power",rollback=true,},
                        },
                    },
                },
            },
        },
    },
    [44] = { name="真户晓",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=62, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=84 },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=121 },

                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=60, limit=3000, callbacktype=0 },
                            [2] = { atype=2, usetype=0, typeindex=82 },--查找直线目标
                            [3] = { atype=13, buffid=44, bufflv=4, targettype=0, srctype=0, speed=15 }, --加BUFF根据距离速度算延迟
                            [4] = { atype=14, targettype=0, usetime=100, direct=1, distance=6, callbacktype=0, limit=3000 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=61, limit=3000, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*8,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=5, targettype=1},
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*19,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=5, targettype=1},
                            [3] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*26,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=5, targettype=1},
                            [3] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*36,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=5, targettype=1},
                            [3] = { atype=5, buffid=44, bufflv=6, targettype=1},
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
                        }
                    },
                },
            },
            [5] = { name="技能3伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                        },
                    },
                },
            },
            [6] = { name="技能3定身", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true, actionodds=0.5, fail_buffid=44, fail_bufflv=10, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1,},
                        },
                    },
                },
            },
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=61, limit=3000, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*8,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=8, targettype=1},
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*19,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=8, targettype=1},
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*26,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=8, targettype=1},
                        }
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*36,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true },--查找附近目标
                            [2] = { atype=5, buffid=44, bufflv=8, targettype=1},
                            [3] = { atype=5, buffid=44, bufflv=9, targettype=1},
                        }
                    },
                }
            },
            [8] = { name="觉醒技能3伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                        },
                    },
                },
            },
            [9] = { name="觉醒技能3定身", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true, actionodds=0.7, fail_buffid=44, fail_bufflv=10, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1,},
                        },
                    },
                },
            },
            [10] = { name="技能3 定身失败", duration=0, overlap=0, property=bit_merge(64,1),
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
    [46] = { name="五里美乡",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=591, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=125 },--查找附近目标
                            -- [3] = { atype=5, buffid=46, bufflv=6, targettype=1 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, type=3, targettype=0 },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=408 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=592, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=46, bufflv=4, targettype=2 },--加晶体子弹BUFF
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=593, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=126 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=27, type=3, targettype=0, },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                            [6] = { atype=20, delay=3*33, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [8] = { atype=27, type=3, targettype=0, },
                            [9] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                            [10] = { atype=20, delay=25*33, },
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [12] = { atype=27, type=3, targettype=0, },
                            [13] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=409 },
                        }
                    },
                }
            },
            [4] = { name="技能2 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=252, rollback=true, durationtime=0, },--
                            [3] = { atype=5, buffid=46, bufflv=5, targettype=0, actionodds=0.4, fail_buffid=46, fail_bufflv=7},--加眩晕BUFF
                        }
                    },
                }
            },
            [5] = { name="眩晕", duration=1500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--定身特效
						}
                    },
                }
            },
            [6] = { name="受伤状态下受到额外伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, condition=43,
                        action = {
                            [1] = { atype=37, type=1, value=1, },
                        }
                    },
                }
            },
            [7] = { name="技能2 眩晕失败", duration=0, overlap=0, property=bit_merge(64,1),
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
    [47] = { name="安久奈白",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=123 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=758, limit=3000, callbacktype=1 }, --起始动作
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            -- [4] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                            -- [5] = { atype=60, id=81200094, follow=true, unique=false, autostop=true },
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=757, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=124 },
                            [3] = { atype=5, buffid=47, bufflv=4, targettype=1},
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=3, },
                            [3] = { atype=14, targettype=0, usetime=300, position=1, offset=0, offsettype=0, direct=1, },
                            [4] = { atype=1, srctype=2, targettype=4, animid=756, limit=3000, callbacktype=1 }, --起始动作
                            [5] = { atype=2, usetype=0, typeindex=136, },
                            [6] = { atype=1, srctype=2, targettype=4, animid=760, limit=3000, callbacktype=1 }, --起始动作
                            [7] = { atype=5, buffid=47, bufflv=6, targettype=4, },
                            [8] = { atype=54, count=1, x=1.2, y=0.8, z=0.8, dis=0.1, speed=60, decay=0.3, multiply=0, },
                            [9] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=430,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=0.8, y=0.9, z=0.6, dis=0.1, speed=60, decay=0.4, multiply=0, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=530,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=630,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                    -- [5] = { activetype=3, triggertype=0, delay=730,
                    --     action = {
                    --         [1] = { atype=5, buffid=47, bufflv=6, targettype=4, },
                    --         [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                    --     },
                    -- },
                }
            },
            [4] = { name="技能2 伤害+降低防御", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=251 },
                            [3] = { atype=27, targettype=1, type=3, },
                            [4] = { atype=41, abilityname="def_power", valuetype=1, rollback=true, },
                            [5] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0 },--
                        }
                    }
                }
            },
            [5] = { name="增加吸血属性", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18051, rollback=true, durationtime=0, },
                        }
                    }
                }
            },
            [6] = { name="技能1伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=27, targettype=1, distance=0.3, type=3, limit=3000, },
                        }
                    }
                }
            },
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=3, },
                            [2] = { atype=14, targettype=1, usetime=300, distance=4, offset=0, offsettype=0, direct=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=756, limit=3000, callbacktype=1 }, --起始动作
                            [4] = { atype=2, usetype=0, typeindex=325, },
                            [5] = { atype=1, srctype=2, targettype=4, animid=760, limit=3000, callbacktype=1 }, --起始动作
                            [6] = { atype=5, buffid=47, bufflv=8, targettype=4, },
                            [7] = { atype=54, count=1, x=1.2, y=0.8, z=0.8, dis=0.1, speed=60, decay=0.3, multiply=0, },
                            [8] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=430,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=8, targettype=4, },
                            [2] = { atype=54, count=1, x=0.8, y=0.9, z=0.6, dis=0.1, speed=60, decay=0.4, multiply=0, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=530,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=8, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=630,
                        action = {
                            [1] = { atype=5, buffid=47, bufflv=8, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                }
            },
            [8] = { name="技能1伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=27, targettype=1, distance=0.6, type=3, limit=3000, },
                        }
                    }
                }
            },
        },
    },
    [48] = { name="钵川忠",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=603, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=128 }, --找范围目标
                            [3] = { atype=5, buffid=48, bufflv=7, targettype=1 }, --加伤害BUFF
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=620, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=252, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=172, callbacktype=0,},
                            [5] = { atype=5, buffid=48, bufflv=8, targettype=0, },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=602, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*12,
                        action = {
                            [1] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*17,
                        action = {
                            [1] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
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
                            [3] = { atype=5, buffid=48, bufflv=5, targettype=1, },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [5] = { atype=5, buffid=48, bufflv=6, targettype=1, },
                            -- [6] = { atype=27, type=3, targettype=1, limit=3000, },
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
                            [4] = { atype=5, buffid=48, bufflv=6, targettype=1, },
                            -- [5] = { atype=27, type=3, targettype=1, limit=3000, },
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
                            [2] = { atype=3, abilityname="move_speed", rollback=true,},
                            [3] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true, },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid="255.257",},
						}
					},
				}
			},
            [8] = { name="技能2 烟雾弹", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, },--记录位置
                            -- [2] = { atype=6, srctype=6, targettype=0, effectid=192, callbacktype=1, limit=3000, position=0, },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=400, 
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, angle=360, enemy=false, position=2, includeself=true},
                            [2] = { atype=5, buffid=48, bufflv=9, targettype=1, },
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
            [10] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=602, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*12,
                        action = {
                            [1] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                            [2] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*17,
                        action = {
                            [1] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                            [2] = { atype=5, buffid=48, bufflv=4, targettype=0 },--加赫子碎片起始
                        }
                    },
                }
            },
        },
    },
    [49] = { name="野吕",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=769, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=100, targetcnt=4, sorttype=0, layer=lay_all_role},
                            [3] = { atype=5, buffid=49, bufflv=8, targettype=1, targetindex=1, condition=39 },
                            [4] = { atype=5, buffid=49, bufflv=9, targettype=1, targetindex=2, condition=40 },
                            [5] = { atype=5, buffid=49, bufflv=10, targettype=1, targetindex=3, condition=41 },
                            [6] = { atype=5, buffid=49, bufflv=11, targettype=1, targetindex=4, condition=42 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=768, limit=3000, callbacktype=0 },
                            [2] = { atype=32, type=1 },
                            [3] = { atype=2, srctype=1, targettype=4, layer=lay_all_role, enemy=true },
                            [4] = { atype=13, buffid=49, bufflv=5, targettype=0, srctype=0, speed=25 },
                            [5] = { atype=14, targettype=0, usetime=300, direct=1, distance=8, callbacktype=0, limit=3000 },
                            [6] = { atype=1, srctype=2, targettype=0, animid=770, callbacktype=0, limit=3000 },
                            --[3] = { atype=5, buffid=49, bufflv=5, targettype=0 },
                            
                            --[5] = { atype=11, buffid=49, bufflv=5, targettype=0 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=5000, durationweak=500, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=10, rollback=true }, --加隐身BUFF
                            [2] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [3] = { atype=15 }, --因为没有技能动作需要设置技能完成
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=174 },--爆炸特效
                        }
                    },
                    [2] = { activetype=1, triggertype=0,
                        action = {
                            [1] = { atype=28 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=175 },--爆炸特效
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true }, --找范围目标
                            [4] = { atype=5, buffid=49, bufflv=4, targettype=1 }, --加BUFF
                        }
                    }
                }
            },
            [4] = { name="伤害+眩晕", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [2] = { atype=4, type=0, infoindex=1 },--加伤害BUFF
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=176 },--爆炸特效
						}
                    },
                }
            },
            [5] = { name="击退+伤害", duration=0, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=23, targettype=1, distance=2, distype=0, dirtype=1 },--击退
                        }
                    },
                },
            },
            [6] = { name="火效果", duration=5000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                        }
                    },
                    [2] = { activetype=2, triggertype=1, interval=1000,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 },--伤害
                        }
                    },
                },
            },
            [7] = { name="冰效果", duration=5000, overlap=4, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                        }
                    },
                },
            },
            [8] = { name="技能3赫子1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1, srctype=2 },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=179, callbacktype=0, direct=2 },
                            [3] = { atype=5, buffid=49, bufflv=6, targettype=0 },--火效果
                            [4] = { atype=27, targettype=1, dirtype=1, height=2, type=5, distance=2 }
					    }
                    },
                }
            },
            [9] = { name="技能3赫子2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=70,
                        action = {
                            [1] = { atype=32, type=1, srctype=2 },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=179, callbacktype=0, direct=2 },
                            [3] = { atype=5, buffid=49, bufflv=7, targettype=0 },--冰效果
                            [4] = { atype=27, targettype=1, dirtype=1, height=2, type=5, distance=2 }
					    }
                    },
                }
            },
            [10] = { name="技能3赫子3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=140,
                        action = {
                            [1] = { atype=32, type=1, srctype=2 },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=179, callbacktype=0, direct=2 },
                            [3] = { atype=5, buffid=49, bufflv=6, targettype=0 },--火效果
                            [4] = { atype=27, targettype=1, dirtype=1, height=2, type=5, distance=2 }
					    }
                    },
                }
            },
            [11] = { name="技能3赫子4", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=200,
                        action = {
                            [1] = { atype=32, type=1, srctype=2 },
                            [2] = { atype=6, srctype=2, targettype=0, effectid=179, callbacktype=0, direct=2 },
                            [3] = { atype=5, buffid=49, bufflv=7, targettype=0 },--冰效果
                            [4] = { atype=27, targettype=1, dirtype=1, height=2, type=5, distance=2 }
					    }
                    },
                }
            },
        },
    },
    [50] = { name="宇井郡",
        level = {
            [1] = { name="技能1", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=613, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=209 },--查找附近目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=127 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=614, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=129 },--查找附近目标
                            [3] = { atype=5, buffid=50, bufflv=6, targettype=0 },
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
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=615, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=210, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [5] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [6] = { atype=20, delay=33*13 ,},
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [8] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [9] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [10] = { atype=20, delay=33*6 ,},
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [12] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [13] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                            [14] = { atype=20, delay=33*11 ,},
                            [15] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [16] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            -- [14] = { atype=5, buffid=50, bufflv=4, targettype=1, condition=74,},
                            -- [15] = { atype=41, abilityname="def_power", value="yjj_skill3", valuetype=2, add_scale=0.5, },
                            -- [16] = { atype=99, name="yjj_skill3", lock=true, },
                            [17] = { atype=5, buffid=50, bufflv=7, targettype=1 },
                            [18] = { atype=60, id="81100017.81100020", targettype=2, targetindex=0, follow=false, unique=false, autostop=true, },
                        }
                    },
                }
            },
            [4] = { name="觉醒技能3 吸收防御", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=101, abilityname="def_power", abilityscale=0.05, creatorability="def_power", maxscale=0.7, recordname="yjj_skill3", rollback=true, },
						}
                    },
                }
            },
            [5] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=615, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=210, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [5] = { atype=20, delay=33*13 ,},
                            [6] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [7] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [8] = { atype=20, delay=33*6 ,},
                            [9] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [10] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            [11] = { atype=20, delay=33*11 ,},
                            [12] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [13] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=182, },
                            -- [14] = { atype=5, buffid=50, bufflv=4, targettype=1, condition=74,},
                            -- [15] = { atype=41, abilityname="def_power", value="yjj_skill3", valuetype=2, add_scale=0.5, },
                            -- [16] = { atype=99, name="yjj_skill3", lock=true, },
                            [14] = { atype=5, buffid=50, bufflv=4, targettype=1 },
                        }
                    },
                }
            },
            [6] = { name="提升格挡", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="parry_rate", valuetype=1, rollback=true,},
                            -- [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0},
                        }
                    },
                }
            },
            [7] = { name="技能3 吸收防御", duration=-1, overlap=0, property=bit_merge(64,1),
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
    [51] = { name="太郎",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=669, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=118 },
                            [3] = { atype=13, buffid=51, bufflv=4, targettype=0, srctype=0, speed=15, },
                            -- [4] = { atype=14, targettype=2, usetime=396, distance=6, direct=1 },
                            -- [5] = { atype=1, srctype=2, targettype=4, animid=671, limit=3000, callbacktype=1 },
                            -- [6] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role },
                            -- [7] = { atype=5, buffid=51, bufflv=5, targettype=1 },
                            -- [8] = { atype=1, srctype=2, targettype=4, animid=672, limit=3000, callbacktype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32),
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
                            [2] = { atype=5, buffid=51, bufflv=6, targettype=1 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=671, limit=3000, callbacktype=1 },
                            [2] = { atype=14, targettype=0, usetime=429, callbacktype=0, limit=3000, position=3, autoforward=true, },
                            [3] = { atype=2, srctype=1, targettype=1, angle=360, radius=2.5, enemy=true, layer=lay_all_role, },
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=195},
                            [6] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=193, position=3, },
                        }
                    },
                }
            },
            [4] = { name="技能1斧头伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=416}
						}
                    },
                }
            },
            [5] = { name="击飞伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0 },
                            [2] = { atype=27, targettype=1, height=2, type=5, distance=3 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=195 }
						}
                    },
                }
            },
            [6] = { name="技能2伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=194 },
                            [3] = { atype=5, buffid=51, bufflv=7, targettype=0 },
                        }
                    },
                }
            },
            [7] = { name="技能2降低防御", duration=4000, overlap=5, property=bit_merge(64,1),
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
    [52] = { name="安久黑奈",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=747, limit=3000, callbacktype=0 }, --起始动作
                            [2] = { atype=2, srctype=1, targettype=1, angle=120, targetcnt=5, sorttype=0, layer=lay_all_role, arraytype=0, enemy=true },
                            [3] = { atype=19, enable=false, rollback=true },
                            [4] = { atype=17, targettype=1, srctype=0, effectid=199, buffid=1, bufflv=1, radius=4, limit=1000, mintimes=5 },
                            [5] = { atype=6, srctype=7, targettype=2, callbacktype=1, effectid=199, limit=3000, handlehit=false },
                            [6] = { atype=19, enable=true }, 
                            [7] = { atype=15, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=73, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=4, animid=746, limit=3000, callbacktype=1, lock=true, rollback=true },
                            [3] = { atype=5, buffid=52, bufflv=7, targettype=0, },
                            --[4] = { atype=15 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true,},--免疫控制
                            [2] = { atype=55, rollback=true, },
                            [3] = { atype=6, srctype=2, targettype=2, callbacktype=0, effectid=206, limit=3000, },
                            [4] = { atype=1, srctype=2, targettype=4, animid=747, limit=3000, callbacktype=0 },
                            [5] = { atype=2, srctype=1, targettype=3 },
                            [6] = { atype=24, },
                            [7] = { atype=32, },
                            [8] = { atype=14, targettype=2, callbacktype=0, usetime=100, limit=3000, offset=0.5, offsettype=0, distance=3, },
                            [9] = { atype=5, buffid=52, bufflv=6, targettype=1, rollback=true },
                            [10] = { atype=1, srctype=2, targettype=4, animid=745, limit=3000, callbacktype=1, },
                            -- [7] = { atype=11, buffid=52, bufflv=6, targettype=1 },
                            [11] = { atype=86, scale=1.2, condition=50 },
                            [12] = { atype=5, buffid=52, bufflv=4, targettype=1, },
                            -- [3] = { atype=15 },
                        }
                    },
                }
            },
            [4] = { name="抛起砸地伤害+眩晕", duration=1000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=4, type=0, infoindex=1 },--加伤害
                            -- [2] = { atype=27, targettype=1, distance=0, distype=0, callbacktype=1, limit=5000, type=5 },
                            [1] = { atype=4, type=0, infoindex=1 },--加伤害
                            [2] = { atype=27, targettype=1, limit=3000, type=3, },
                            [3] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=3 },--眩晕特效
                            [5] = { atype=2, srctype=2, targettype=1, radius=3, angle=360, enemy=true, layer=lay_all_role, includeself=false, },--查找附近目标
                            [6] = { atype=5, buffid=52, bufflv=5, targettype=1, },
                        }
                    },
                }
            },
            [5] = { name="造成一半伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=5, persent=0.5, infoindex=1 },--加伤害BUFF
                            [2] = { atype=27, targettype=1, dirtype=2, limit=3000, distance=2, type=3 },
                        },
                    },
                },
            },
            [6] = { name="将怪物带到空中", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=78, type=1,rollback=true, },
                        },
                    },
                },
            },
            [7] = { name="隐身", duration=4000, overlap=0, property=bit_merge(64,4),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=10, rollback=true },
                            [2] = { atype=31, scale=1.3, odds=100, rollback=true },
                            [3] = { atype=76, type=0, value=1, },
                        },
                    },
                },
            },
        },
    },
    [53] = { name="笛口亚关",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=95, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, radius=4, angle=360, targetcnt=1, sorttype=2, layer=lay_all_role, enemy=true },
                            [3] = { atype=5, buffid=53, bufflv=5, targettype=1 },
                            [4] = { atype=2, srctype=1, targettype=1, radius=4, angle=360, targetcnt=1, layer=lay_all_hero, enemy=false, includeself=true },
                            [5] = { atype=5, buffid=53, bufflv=6, targettype=1 },
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=6, enemy=false },
                            [2] = { atype=5, buffid=53, bufflv=4, targettype=1 },
                            [3] = { atype=15 },
                        }
                    },
                }
            },
            [4] = { name="恢复生命", duration=0, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=25, type=1, value=10 },
						}
                    },
                }
            },
            [5] = { name="伤害+减少40%的攻击强度", duration=10000, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=3, persent=0.4, infoindex=1 },
                            [2] = { atype=3, abilityname="atk_power", record=true, recordname="record_atk_power", rollback=true },
                        }
                    },
                }
            },
            [6] = { name="增加攻击者记录的属性", duration=10000, overlap=0, property=32,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=2, value="record_atk_power" },
						}
                    },
                }
            },
        },
    },
    [54] = { name="瓶弟",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            -- [2] = { atype=14, targettype=2, callbacktype=0, usetime=100, offset=2, offsettype=1, finaltorward=1, distance=3, limit=3000, },--瞬移到身后
                            [1] = { atype=1, srctype=2, targettype=4, animid=723, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=337 },--当前目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=272, callbacktype=0, }
                            -- [4] = { atype=5, buffid=54, bufflv=9, targettype=1, }, --含有能量场标记BUFF
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=2, effectid=436, callbacktype=0, position=3, },
                            -- [2] = { atype=20, delay=300,},
                            [2] = { atype=14, targettype=6, callbacktype=0, usetime=100, offset=2, offsettype=1, finaltorward=1, distance=3, limit=3000, },--瞬移到身后
                            [3] = { atype=1, srctype=2, targettype=4, animid=724, limit=3000, callbacktype=1 },--做动作
                            [4] = { atype=2, usetype=0, typeindex=336 },--查找附近目标
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1 },--加伤害BUFF
                            [6] = { atype=6, srctype=5, targettype=0, effectid=431, callbacktype=0, },
                            -- [5] = { atype=27, targettype=0, distance=0, limit=3000, type=3,}
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=726, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=134},
                            [3] = { atype=5, buffid=54, bufflv=4, targettype=1 },
                        }
                    },
                }
            },
            [4] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=31, scale=1.4, odds=100, rollback=true, condition=76},
                            [2] = { atype=4, type=0, infoindex=1 }, --伤害
                            [3] = { atype=6, srctype=2, targettype=0, effectid=432, callbacktype=0, }
                        }
                    },
                }
            },
            [5] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64, 4),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=726, limit=3000, callbacktype=1 },--做动作
                            [2] = { atype=2, usetype=0, typeindex=134},
                            [3] = { atype=5, buffid=54, bufflv=6, targettype=1 },
                        }
                    },
                }
            },
            [6] = { name="觉醒技能3 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=31, scale=1.6, odds=100, rollback=true, condition=76},
                            [2] = { atype=4, type=0, infoindex=1 }, --伤害
                            [3] = { atype=6, srctype=2, targettype=0, effectid=432, callbacktype=0, }
                        }
                    },
                }
            }, 
        },
    },
    --[[[55] = { name="瓶弟被动BUFF",
        level = {
            [1] = { name="被动BUFF", duration=-1, overlap=0, property=bit_merge(64), skillid=112,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=54, bufflv=6, targettype=0, rollback=true },--加小能量场BUFF
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=5, buffid=54, bufflv=4, targettype=0 },--加延迟隐身BUFF
                        }
                    },
                }
            },
        }
    },]]
    [56] = { name="原创CCG2",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
						}
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
						}
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=114,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
						}
                    },
                }
            },
        },
    },
    [57] = { name="治疗伤害",
        level = {
            [1] = { name="治疗伤害", duration=5000, overlap=0, property=bit_merge(64, 8),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=246 },
						}
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=25, type=2, value=0.1 }, --恢复10%血量
                        }
                    },
                }
            },
        },
    },
    [58] = { name="种族BUFF",
        level = {
            [1] = { name="对锐属性英雄造成伤害提升6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=3, value=1.06 }, 
                        }
                    },
                }
            },
            [2] = { name="对锐属性英雄造成伤害提升15%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=3, value=1.15 }, 
                        }
                    },
                }
            },
            [3] = { name="对坚属性英雄造成伤害提升6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=2, value=1.06 }, 
                        }
                    },
                }
            },
            [4] = { name="对坚属性英雄造成伤害提升15%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=2, value=1.15 }, 
                        }
                    },
                }
            },
            [5] = { name="对疾属性英雄造成伤害提升6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=1, value=1.06 }, 
                        }
                    },
                }
            },
            [6] = { name="对疾属性英雄造成伤害提升15%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=1, value=1.15 }, 
                        }
                    },
                }
            },
            [7] = { name="对特属性英雄造成伤害提升6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=4, value=1.06 }, 
                        }
                    },
                }
            },
            [8] = { name="对特属性英雄造成伤害提升15%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=56, restraint=4, value=1.15 }, 
                        }
                    },
                }
            },
            [9] = { name="对四星以下英雄造成伤害提升6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=57, stars=4, type=0, value=1.06 }, 
                        }
                    },
                }
            },
            [10] = { name="对四星以下英雄造成伤害提升15%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=57, stars=4, type=0, value=1.15 }, 
                        }
                    },
                }
            },
            [11] = { name="受到所有物理伤害降低6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=58, type=0, value=0.94 }, 
                        }
                    },
                }
            },
            [12] = { name="受到所有物理伤害降低30%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=58, type=0, value=0.7 }, 
                        }
                    },
                }
            },
            [13] = { name="受到所有能量伤害降低6%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=58, type=1, value=0.94 }, 
                        }
                    },
                }
            },
            [14] = { name="受到所有能量伤害降低30%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=58, type=1, value=0.7 }, 
                        }
                    },
                }
            },
            [15] = { name="被控制时受到所有伤害降低28%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=1, triggertype=0,
                        action = {
                        }
                    },
                }
            },
            [16] = { name="被控制时受到所有伤害降低70%", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=1, triggertype=0,
                        action = { 
                        }
                    },
                }
            },
            [17] = { name="每12秒清除身上所有负面状态", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=12000,
                        action = {
							[1] = { atype=59 },
						}
                    },
                }
            },
            [18] = { name="每6秒清除身上所有负面状态", duration=-1, overlap=0, property=bit_merge(64), 
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=6000,
                        action = {
							[1] = { atype=59 },
						}
                    },
                }
            },
        },
    },
    [59] = { name="纳基",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=307, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=121 },
                            [3] = { atype=5, buffid=59, bufflv=5, targettype=1, },
                            -- [4] = { atype=2, srctype=2, targettype=6, radius=0, enemy=false, layer=lay_all_role, includeself=true, },
                            -- [5] = { atype=5, buffid=59, bufflv=6, targettype=1, },
                        },
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=98, hppersent=0.5, damagescale=0.5, rollback=true, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=313, limit=3000, callbacktype=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=314, limit=3000, callbacktype=0, },
                            [4] = { atype=2, usetype=0, typeindex=120 },
                            [5] = { atype=13, buffid=59, bufflv=4, targettype=0, srctype=0, speed=15, },
                            [6] = { atype=32, type=1, offset=6, },
                            [7] = { atype=14, targettype=0, usetime=13*33, direct=1, offsettype=0, offset=0, limit=3000, position=1, callbacktype=0,},
                            [8] = { atype=1, srctype=2, targettype=4, animid=315, limit=3000, callbacktype=0, },
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    -- 动作部分
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=119 },
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
                            [2] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [5] = { atype=20, delay=8*33, },
                            [6] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                        },
                    },
                    [6] = { activetype=0,triggertype=0, group=2, condition=73,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [5] = { atype=20, delay=8*33, },
                            [6] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [7] = { atype=20, delay=23*33, },
                            [8] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                        },
                    },
                    [7] = { activetype=0,triggertype=0, group=2,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                            [3] = { atype=20, delay=3*33, },
                            [4] = { atype=13, buffid=59, bufflv=8, targettype=2, srctype=0, speed=15, },
                        },
                    },
                },
            },
            [4] = { name="击退+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3,triggertype=0, delay=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},--伤害
                            [2] = { atype=27, targettype=1, distance=4, distype=0, dirtype=2, type=3 },
                            [3] = { atype=6, srctype=2, targettype=0, effectid=417, callbacktype=0, },
                            --[2] = { atype=23, targettype=1, distance=4, dirtype=2, , },--击退
                            --[2] = { atype=14, targettype=0, usetime=100, direct=6, distance=4 },
                        },
                    },
                },
            },
            [5] = { name="暴怒伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},
                            [2] = { atype=6, srctype=2, targettype=0, effectid=135, callbacktype=0, },
                            -- [2] = { atype=27, targettype=1, distance=2, type=3, limit=3000, },
                        },
                    },
                },
            },
            [6] = { name="暴怒buff", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            -- [1] = { atype=41, abilityname="energy_bloodsuck", rollback=true, },
                            -- [1] = { atype=41, abilityname="crit_rate", valuetype=1, rollback=true, },
                            [1] = { atype=6, srctype=2, targettype=0, effectid=136, durationtime=0, callbacktype=0, rollback=true, },
                        },
                    },
                },
            },
            [7] = { name="技能3伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0,triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=135, direct=1, directoffset=0, },
                            [2] = { atype=60, id=81100017, follow=true, unique=false, autostop=true, targettype=1,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=0,},
                        },
                    },
                },
            },
            [8] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3,triggertype=0, delay=1,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0,},--伤害
                            [2] = { atype=6, srctype=2, targettype=0, effectid=418, callbacktype=0, },
                            --[2] = { atype=23, targettype=1, distance=4, dirtype=2, , },--击退
                            --[2] = { atype=14, targettype=0, usetime=100, direct=6, distance=4 },
                        },
                    },
                },
            },
            [9] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    -- 动作部分
                    [1] = { activetype=0,triggertype=0, group=1, condition=72,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=310, limit=3000, callbacktype=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=311, limit=3000, callbacktype=1, },
                        },
                    },
                    [2] = { activetype=0,triggertype=0, group=1, condition=73,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=310, limit=3000, callbacktype=1, },
                            [3] = { atype=1, srctype=2, targettype=4, animid=312, limit=3000, callbacktype=1, },
                        },
                    },
                    [3] = { activetype=0,triggertype=0, group=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=308, limit=3000, callbacktype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=309, limit=3000, callbacktype=1, },
                        },
                    },
                    -- 伤害部分
                    [4] = { activetype=0,triggertype=0, group=2, condition=72,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=2, usetype=0, typeindex=241 },
                            [3] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [4] = { atype=20, delay=3*33, },
                            [5] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [6] = { atype=20, delay=8*33, },
                            [7] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                        },
                    },
                    [5] = { activetype=0,triggertype=0, group=2, condition=73,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=2, usetype=0, typeindex=242 },
                            [3] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [4] = { atype=20, delay=3*33, },
                            [5] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [6] = { atype=20, delay=8*33, },
                            [7] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [8] = { atype=20, delay=23*33, },
                            [9] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                        },
                    },
                    [6] = { activetype=0,triggertype=0, group=2,
                        action = {
                            [1] = { atype=20, delay=8*33, },
                            [2] = { atype=2, usetype=0, typeindex=240 },
                            [3] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                            [4] = { atype=20, delay=3*33, },
                            [5] = { atype=13, buffid=59, bufflv=8, targettype=0, srctype=0, speed=15, },
                        },
                    },
                },
            },
        },
    },
    [60] = { name="万丈数一",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=690, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=174},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [4] = { atype=6, srctype=5, targettype=0, effectid=419, callbacktype=0, },
                        },
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=691, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=135},
                            [3] = { atype=5, buffid=60, bufflv=4, targettype=1,},
                            [4] = { atype=5, buffid=60, bufflv=5, targettype=0, },
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=692, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=130 },
                            [3] = { atype=5, buffid=60, bufflv=6, targettype=1, }, -- 添加伤害
                        },
                    },
                },
            },
            [4] = { name="技能2 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=420, },
                        },
                    },
                },
            },
            [5] = { name="技能2 加攻击", duration=4000, overlap=0, property=bit_merge(64,8),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, valuetype=1, abilityname="atk_power", rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=137, rollback=true, durationtime=0, },--眩晕特效
                        },
                    },
                },
            },
            [6] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=421, },
                            -- [2] = { atype=27, targettype=1, distance=2, limit=3000, type=3, },
                            -- [3] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=true, includeself=false, },
                            -- [4] = { atype=5, buffid=60, bufflv=11, targettype=1, },
                        },
                    },
                },
            },
        },
    },
    [61] = { name="楠木遥人",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=800, limit=3000, callbacktype=1,},
                            [2] = { atype=5, buffid=61, bufflv=5, targettype=0,},
                            [3] = { atype=5, buffid=61, bufflv=6, targettype=0,},
                            [4] = { atype=5, buffid=61, bufflv=7, targettype=0,},
                        },
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=1, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=797, limit=3000, callbacktype=2,},
                            [2] = { atype=5, buffid=61, bufflv=4, targettype=2,},
                            [3] = { atype=1, srctype=2, targettype=4, animid=799, limit=3000, callbacktype=0,},
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1, offset=2 },--记录位置和朝向
                            [2] = { atype=1, srctype=2, targettype=4, animid=796, limit=3000, callbacktype=1 },--做动作
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=500,
                        action = {
                            [1] = { atype=5, buffid=61, bufflv=9, targettype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=700,
                        action = {
                            [1] = { atype=5, buffid=61, bufflv=10, targettype=0 },
                        }
                    },
                },
            },
            [4] = { name="拉人伤害", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=61, bufflv=13, targettype=0, },
                            [2] = { atype=14, targettype=3, usetime=300, offset=0.5, offsettype=0, callbacktype=0, limit=3000,},--吸引位置
                            [3] = { atype=11, buffid=61, bufflv=13, targettype=0, },
                            [4] = { atype=4, type=0, infoindex=1 },--伤害
                            -- [5] = { atype=41, abilityname="def_power", valuetype=1, rollback=true,},
                            [5] = { atype=6, srctype=2, targettype=0, effectid=18045, callbacktype=0, rollback=true, durationtime=0 },
                        },
                    },
                },
            },
            [5] = { name="机械陷阱1", duration=8000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, offset=3.21, aoffset=-38.5,},
                            [2] = { atype=6, srctype=6, targettype=0, effectid=154, limit=3000, callbacktype=0, durationtime=0, rollback=true, position=5, createworlditem=42 },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=10, condition=53,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=1, angle=360, targetcnt=1, enemy=true, layer=lay_all_role, position=2},
                            [2] = { atype=5, buffid=61, bufflv=8, targettype=1, condition=19,},
                            [3] = { atype=11, targettype=0, condition=19,},
                        },
                    },
                },
            },
            [6] = { name="机械陷阱2", duration=8000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, offset=3.98, aoffset=0,},
                            [2] = { atype=6, srctype=6, targettype=0, effectid=154, limit=3000, callbacktype=0, durationtime=0, rollback=true, position=5, createworlditem=42 },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=10, condition=53,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=1, angle=360, targetcnt=1, enemy=true, layer=lay_all_role, position=2},
                            [2] = { atype=5, buffid=61, bufflv=8, targettype=1, condition=19,},
                            [3] = { atype=11, targettype=0, condition=19,},
                        },
                    },
                },
            },
            [7] = { name="机械陷阱3", duration=8000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, offset=3.45, aoffset=34.8,},
                            [2] = { atype=6, srctype=6, targettype=0, effectid=154, limit=3000, callbacktype=0, durationtime=0, rollback=true, position=5, createworlditem=42},
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=10, condition=53,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, radius=1, angle=360, targetcnt=1, enemy=true, layer=lay_all_role, position=2},
                            [2] = { atype=5, buffid=61, bufflv=8, targettype=1, condition=19,},
                            [3] = { atype=11, targettype=0, condition=19,},
                        },
                    },
                },
            },
            [8] = { name="陷阱伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=0, },
                            [2] = { atype=5, buffid=61, bufflv=12, targettype=0, actionodds=0.4, sendserver=true, },
                            [3] = { atype=60, id=81102140, follow=false, autostop=true,},
                        },
                    },
                },
            },
            [9] = { name="第1个炸弹爆炸", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=205, position=6, length=0, durationtime=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true, },--查找特效附近目标
                            [3] = { atype=5, buffid=61, bufflv=11, targettype=1 },--加伤害BUFF
                            -- [5] = { atype=27,targettype=0,type=5,height=3,distance=0},
                            -- [6] = { atype=54,},
                        }
                    },
                }
            },
            [10] = { name="后面的炸弹爆炸", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=205, position=6, length=2, durationtime=0 },--移动特效
                            [2] = { atype=2, srctype=3, targettype=1, radius=2, angle=360, position=1, layer=lay_all_role, enemy=true, },--查找特效附近目标
                            [3] = { atype=5, buffid=61, bufflv=11, targettype=1 },--加伤害BUFF
                            -- [5] = { atype=27,targettype=0,type=5,height=3,distance=0},
                            -- [6] = { atype=54,},
                        }
                    },
                }
            },
            [11] = { name="添加伤害", duration=1500, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=38, scale=1.2, condition=44, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=66 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=0 },--加伤害BUFF
                        },
                    },
                },
            },
            [12] = { name="定身", duration=2000, overlap=4, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=2, effectid=151, limit=3000, callbacktype=0, },
                            [2] = { atype=6, srctype=2, targettype=2, effectid=153, limit=3000, callbacktype=0, },
                            [3] = { atype=6, srctype=2, targettype=2, effectid=152, limit=3000, callbacktype=0, durationtime=0, rollback=true,},
                            [4] = { atype=7, effect_type=1, rollback=true,},--定身
                        },
                    },
                },
            },
            [13] = { name="技能2控制状态", duration=-1, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true, },
                        },
                    },
                },
            },
        },
    },
    [62] = { name="雾岛绚都",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=701, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=317 },
                            [3] = { atype=13, buffid=62, bufflv=5, targettype=0, srctype=0, speed=25,},
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, srctype=3, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=702, limit=3000, callbacktype=1, },
                            [3] = { atype=6, srctype=6, targettype=0, effectid=329, limit=3000, callbacktype=0, position=0,},
                            [4] = { atype=60, id=81102321, follow=false, autostop=true,},
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*16,
                        action = {
                            [1] = { atype=2, typeindex=385},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*30,
                        action = {
                            [1] = { atype=2, typeindex=386},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*44,
                        action = {
                            [1] = { atype=2, typeindex=387},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*58,
                        action = {
                            [1] = { atype=2, typeindex=388},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=33*72,
                        action = {
                            [1] = { atype=2, typeindex=389},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=33*86,
                        action = {
                            [1] = { atype=2, typeindex=390},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=703, limit=3000, callbacktype=0,},
                            [3] = { atype=2, usetype=0, typeindex=316},
                            [4] = { atype=13, buffid=62, bufflv=6, targettype=0, srctype=0, speed=10}
                            --[3] = { atype=5, buffid=62, bufflv=6, targettype=1, },
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
            [4] = { name="技能2 爆伤状态", duration=-1, overlap=8, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18079, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [5] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=3, triggertype=0,delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=326, rollback=true, durationtime=0 },
                        }
                    },
                }
            },
            [6] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=3, triggertype=0,delay=1,
                        action = {
                            [1] = { atype=61, condition=71,},
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                            [3] = { atype=27, targettype=1, dirtype=3, distance=2, distype=0, type=3 },
                            [4] = { atype=6, srctype=2, targettype=0, effectid=328, callbacktype=0 },
                            [5] = { atype=11, buffid=62, bufflv=4, targettype=0, },
                        }
                    },
                }
            },
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=1 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=703, limit=3000, callbacktype=0,},
                            [3] = { atype=2, usetype=0, typeindex=334},
                            [4] = { atype=13, buffid=62, bufflv=8, targettype=0, srctype=0, speed=10}
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
            [8] = { name="觉醒伤害", duration=0, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=3, triggertype=0,delay=1,
                        action = {
                            [1] = { atype=61, condition=71,},
                            [2] = { atype=97, type=5, scale=0.2, rollback=true, condition=71, },
                            [3] = { atype=4, type=0, infoindex=1 },--伤害
                            [4] = { atype=27, targettype=1, dirtype=3, distance=2, distype=0, type=3 },
                            [5] = { atype=6, srctype=2, targettype=0, effectid=328, callbacktype=0 },
                            [6] = { atype=11, buffid=62, bufflv=4, targettype=0, },
                        }
                    },
                }
            },
            [9] = { name="加速+免疫减速定身", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --提升移动速度
                            -- [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=51, rollback=true, durationtime=0},
                            [2] = { atype=22, type=bit_merge(1, 128), rollback=true }, --免疫减速定身
                        }
                    },
                }
            },
            [10] = { name="技能1持续伤害", duration=5500, overlap=0, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000, immediately=false,
                        action = {
                            [1] = { atype=4, type=0, infoindex=2 },--伤害
                        }
                    },
                }
            },
            [10] = { name="定身", duration=1500, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=1, rollback=true }, --定身
                            -- [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18042, rollback=true, durationtime=0, attentionaction=1 },--定身特效
                        }
                    },
                }
            },
            [11] = { name="怪物用技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=73, rollback=true },
                            -- [2] = { atype=6, srctype=2, targettype=0, effectid=197, limit=3000, callbacktype=0, rollback=true, durationtime=0,},
                            [1] = { atype=32, type=0, srctype=1, },
                            [2] = { atype=1, srctype=2, targettype=4, animid=702, limit=3000, callbacktype=1, },
                            [3] = { atype=6, srctype=6, targettype=0, effectid=329, limit=3000, callbacktype=0, position=0,},
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*26,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=391},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*30,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=392},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=33*33,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=393},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=33*38,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=394},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=33*42,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=395},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=33*46,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=396},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [3] = { atype=5, buffid=62, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=327, callbacktype=0 },
                        },
                    },
                },
            },
        },
    },
    [63] = { name="呗",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=452, limit=3000, callbacktype=1,},
                            [2] = { atype=11, buffid=63, bufflv=9, targettype=0, immediately=false }, --扣一个释放数
                            [3] = { atype=5, buffid=63, bufflv=10, targettype=0 }, --加能量场释放数
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=451, limit=3000, callbacktype=1 },
                            [2] = { atype=2, srctype=1, targettype=1, angle=360, targetcnt=1, sorttype=4, enemy=false, includeself=true },
                            [3] = { atype=80, recordtimes=1 },
                            [4] = { atype=5, buffid=63, bufflv=6, targettype=1, },
					    }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=448, limit=3000, callbacktype=1,},
                            [2] = { atype=5, buffid=63, bufflv=4, targettype=2 },
                            [3] = { atype=5, buffid=1, bufflv=2, targettype=2, condition=37 },
                        }
                    },
                }
            },
            [4] = { name="眩晕+伤害", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 }, --伤害
                            [2] = { atype=7, effect_type=2, rollback=true }, --眩晕
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=2 },--眩晕特效
					    }
                    },
                }
            },
            [5] = { name="能量场效果", duration=1000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                        }
                    },
                }
            },
            [6] = { name="技能2单体恢复生命", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=1 },
                            [2] = { atype=2, srctype=1, targettype=1, radius=3, angle=360, enemy=false, includeFounder=true },
                            [3] = { atype=5, buffid=63, bufflv=7, targettype=1, },
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=202, callbacktype=0 },
                        }
                    },
                }
            },
            [7] = { name="技能2范围恢复生命", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=5, value=0.5 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=203, callbacktype=0 },
                        }
                    },
                }
            },
            [8] = {name="被动BUFF", duration=-1, overlap=0, property=bit_merge(64), skillid=136,
                trigger = {
                    [1] = { activetype=2, triggertype=1, interval=8000, immediately=false,
                        action = {
                            [1] = { atype=5, buffid=63, bufflv=9, targettype=0 }, --加能量场释放数
					    }
                    }
                }
            },
            [9] = { name="能量场释放数", duration=-1, overlap=1, property=bit_merge(64), maxoverlap=3, attention_skill=1,
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                    }
                },
            },
            [10] = { name="技能3场景BUFF", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=32, type=0 },
                            [2] = { atype=6, srctype=6, targettype=0, effectid=204, position=5, callbacktype=0 },
                        },
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=3, targettype=1, position=2, radius=3, angle=360, layer=lay_all_role, enemy=false, position=2 },
                            [2] = { atype=5, buffid=63, bufflv=11, targettype=1, },
                            [3] = { atype=2, srctype=3, targettype=1, position=2, radius=3, angle=360, layer=lay_all_role, enemy=true, position=2 },
                            [4] = { atype=5, buffid=63, bufflv=12, targettype=1, },
                        },
                    },
                },
            },
            [11] = { name="技能3恢复生命", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=203 },
                        }
                    },
                }
            },
            [12] = { name="减少物强+减速", duration=1000, overlap=2, property=bit_merge(64, 1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            [2] = { atype=3, abilityname="atk_power", rollback=true }, --减少攻击
                        }
                    },
                }
            },
        },
    },
    [64] = { name="四方莲示",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=646, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=339 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=243, callbacktype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=647, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=353 },
                            [3] = { atype=5, buffid=64, bufflv=7, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=244, callbacktype=0 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=648, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=338 },
                            [3] = { atype=5, buffid=64, bufflv=4, targettype=1, },
                        }
                    },
                }
            },
            [4] = { name="护盾", duration=6000, overlap=2, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=47, type=0, value=1, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=245, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [5] = { name="单体降低攻速+降低移速", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=27, type=3, targettype=1, distance=2, distype=0 },
                            [2] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            [3] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true }, --减少攻击速度
                            [4] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0, },
                            --[5] = { atype=2, usetype=0, typeindex=319 },
                            --[6] = { atype=5, buffid=64, bufflv=6, targettype=1, },
                        },
                    },
                },
            },
            [6] = { name="群体降低攻速+降低移速", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            [2] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true }, --减少攻击速度
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18037, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [7] = { name="践踏伤害 嘲讽", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=27, type=3, targettype=1, distance=2, distype=0 },
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=75, rollback=true, actionodds=0.5,  fail_buffid=64, fail_bufflv=9, },
                        }
                    },
                },
            },
            [8] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=648, limit=3000, callbacktype=1,},
                            [2] = { atype=2, usetype=0, typeindex=354 },
                            [3] = { atype=5, buffid=64, bufflv=4, targettype=1, },
                        }
                    },
                }
            },
            [9] = { name="嘲讽失败", duration=0, overlap=0, property=bit_merge(64),
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
    [65] = { name="背包金木研",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=954, limit=3000, callbacktype=1 }, --起始动作
                            [2] = { atype=5, buffid=65, bufflv=4, targettype=2 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64, 32),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=955, limit=3000, callbacktype=1 }, --起始动作
                            [2] = { atype=2, usetype=0, typeindex=143 },
                            [3] = { atype=30, scale=1.2, odds=100, rollback=true, condition=61 },--增加伤害
                            [4] = { atype=5, buffid=65, bufflv=5, targettype=1 },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64, 32),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=14, targettype=1, usetime=495, distance=4, offset=1, limit=3000, offsettype=0, direct=1 },--位移
                            [2] = { atype=1, srctype=2, targettype=0, animid=956, limit=3000, callbacktype=1 },--践踏地面起跳
                            [3] = { atype=6, srctype=6, targettype=0, callbacktype=0, effectid=297, position=3 },--践踏特效
                            [4] = { atype=2, usetype=0, typeindex=144 }, --找范围目标
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [6] = { atype=27, targettype=0, distance=1.5, type=3, distype=0 },
                            [7] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=296, },
                            [8] = { atype=5, buffid=65, bufflv=6, targettype=0, actionodds=0.3 },
                            [9] = { atype=5, buffid=65, bufflv=7, targettype=0, actionodds=0.7 },
                        }
                    },
                }
            },
            [4] = { name="技能1眩晕+伤害", duration=2000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true, actionodds=0.2 }, --眩晕
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, attentionaction=1 },--眩晕特效
                            [3] = { atype=4, type=0, infoindex=1 },
                        }
                    },
                },
            },
            [5] = { name="技能2击飞+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=27, targettype=1, distance=1.5, type=3, distype=0 },
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=295, },
                        }
                    },
                },
            },
            [6] = { name="技能3攻击提升", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="atk_power", valuetype=1, rollback=true },
                        }
                    },
                },
            },
            [7] = { name="技能3暴击提升", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1, rollback=true },
                        }
                    },
                },
            },
        }
    },
    [66] = { name="白发金木研",
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
                            [2] = { atype=2, usetype=0, typeindex=145 }, --找范围目标
                            [3] = { atype=5, buffid=66, bufflv=6, targettype=1, },
                        }
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=82, protype=1, scale=1.3, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=0, animid=962, limit=3000, callbacktype=1 },--践踏地面起跳
                            [3] = { atype=2, usetype=0, typeindex=146 }, --找范围目标
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=1, },
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
            [7] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=82, protype=1, scale=1.3, rollback=true },
                            [2] = { atype=1, srctype=2, targettype=0, animid=962, limit=3000, callbacktype=1 },--践踏地面起跳
                            [3] = { atype=2, usetype=0, typeindex=147 }, --找范围目标
                            [4] = { atype=5, buffid=66, bufflv=8, targettype=1, },
                            [5] = { atype=5, buffid=66, bufflv=9, targettype=0, },
                        }
                    },
                }
            },
            [8] = { name="觉醒技能3伤害 + 减防", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=294 },
                            [3] = { atype=3, abilityname="def_power", rollback=true, record=true, recordname="def_power", },       --减少物防
                        }
                    },
                }
            },
            [9] = { name="觉醒技能3加防", duration=5000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="def_power", valuetype=2, value="def_power", rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0},
                        }
                    },
                }
            },
            [10] = { name="巅峰展示技能", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true }, --免疫控制
                            [2] = { atype=1, srctype=2, targettype=4, animid=962, limit=3000, callbacktype=1 },--践踏地面起跳
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, },
                            [4] = { atype=6, srctype=4, targettype=0, callbacktype=0, effectid=294 },
                            [5] = { atype=27, targettype=2, distance=6.5, distype=0, type=3 },
                            [6] = { atype=20, delay=500 },
                            [7] = { atype=92, path="assetbundles/prefabs/video/ghoul_peakvs.mp4", callback="g_peak_show_skill_callback" },
                        }
                    },
                }
            },
        }
    },
    [67] = { name="狭间干雄",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=94, limit=3000, callbacktype=0, },
                            [2] = { atype=14, targettype=1, usetime=300, distance=6.25, offset=0, offsettype=0, direct=1, callbacktype=1, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=2, },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=94, limit=3000, callbacktype=0, },
                            [2] = { atype=2, srctype=1, targettype=1, width=2, layer=lay_all_role, enemy=true},
                            [3] = { atype=5, buffid=67, bufflv=4, targettype=1, },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=94, limit=3000, callbacktype=0, },
                            [2] = { atype=5, buffid=67, bufflv=5, targettype=0, }, 
                        }
                    },
                }
            },
            [4] = { name="技能2 伤害+攻属性降低攻击", duration=3000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=3, abilityname="atk_power", condition=66, rollback=true,},
                        },
                    },
                },
            },
            [5] = { name="技能3BUFF", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=1, angle=360, layer=lay_all_role, enemy=true},
                            [2] = { atype=5, buffid=67, bufflv=6, targettype=1 },
                            [3] = { atype=5, buffid=67, bufflv=7, targettype=0, condition=67, },
                            [4] = { atype=5, buffid=67, bufflv=7, targettype=0, condition=68, },
                            [5] = { atype=5, buffid=67, bufflv=7, targettype=0, condition=69, },
                        }
                    },
                }
            },
            [6] = { name="技能3 吸引+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=14, targettype=3, usetime=400, offset=0.5, offsettype=0, distance=1 },--吸引位置
                            [2] = { atype=4, type=0, infoindex=1 },--伤害
                        }
                    },
                },
            },
            [7] = { name="技能3 增加防御", duration=1000, overlap=1, property=bit_merge(64), maxoverlap=3,
                trigger = {
                    [1] = { activetype=0, triggertype=0, 
                        action = {
                            [1] = { atype=3, abilityname="def_power", rollback=true, },
                        },
                    },
                },
            },
        },
    },
    [68] = { name="杰森 暴走",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=263, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=355, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [4] = { atype=6, srctype=5, targettype=0, effectid=342, callbacktype=0 },
                            [5] = { atype=25, type=4, value=2, add_scale=1}
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=264, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=397, },
                            [3] = { atype=5, buffid=68, bufflv=4, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=343, callbacktype=0 },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=265, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=398, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=344, callbacktype=0 },
                            [5] = { atype=5, buffid=68, bufflv=5, targettype=0, }, 
                        }
                    },
                }
            },
            [4] = { name="技能2 伤害", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, }, 
                            [2] = { atype=14, targettype=3, usetime=300, offset=1, offsettype=0, callbacktype=0, limit=3000,},--吸引位置
                        }
                    },
                }
            },
            [5] = { name="技能3 攻击+攻速", duration=8000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="attack_speed", valuetype=1, add_scale=1, rollback=true,},
                            [2] = { atype=41, abilityname="atk_power", valuetype=1, add_scale=1, rollback=true,},
                        }
                    },
                }
            },
            [6] = { name="觉醒技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=265, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=399, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=344, callbacktype=0 },
                            [5] = { atype=5, buffid=68, bufflv=5, targettype=0, }, 
                        }
                    },
                }
            },
            [7] = { name="觉醒技能3 攻击+攻速", duration=10000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="attack_speed", rollback=true, valuetype=1, add_scale=1,},
                            [2] = { atype=41, abilityname="atk_power", rollback=true, valuetype=1, add_scale=1,},
                        }
                    },
                }
            },
        },
    },
    [69] = { name="村松希惠",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1152, limit=3000, callbacktype=1, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=6, srctype=4, targettype=0, effectid=423, callbacktype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1153, limit=3000, callbacktype=1, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=6, srctype=4, targettype=0, effectid=424, callbacktype=0 },
                            [3] = { atype=5, buffid=69, bufflv=4, targettype=2, },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=1154, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=211, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=424, callbacktype=0 },
                        }
                    },
                }
            },
            [4] = { name="技能2 减速", duration=3000, overlap=0, property=bit_merge(64),
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
    [70] = { name="中岛康健",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=479, limit=3000, callbacktype=2, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=480, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=13, },
                            [3] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [4] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*19,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*33,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=441, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=442, callbacktype=0 },
                        },
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=481, limit=3000, callbacktype=1, },
                            [2] = { atype=6, srctype=2, targettype=4, effectid=443, callbacktype=0, limit=3000,},
                            [3] = { atype=5, buffid=70, bufflv=4, targettype=0 },
                        }
                    },
                }
            },
            [4] = { name="技能3 燃烧", duration=3900, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=32, type=0, srctype=3, },--记录前方位置
                            [2] = { atype=6, srctype=6, targettype=0, effectid=444, callbacktype=1, limit=3000, position=0, },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000, 
                        action = {
                            [1] = { atype=2, typeindex=14, },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            -- [3] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=77, },
                        },
                    },
                }
            },
        },
    },
    [71] = { name="地行甲乙",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1172, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=15, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=447, callbacktype=0 },
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1173, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=249, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=448, callbacktype=0 },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=0, animid=1174, limit=3000, callbacktype=1, },
                            [2] = { atype=2, usetype=0, typeindex=250, },
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
    --------------------------------战斗数据模型----------------------------------
    [80] = { name="标准模型B-安久奈白技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=203 },
                            [2] = { atype=1, srctype=2, targettype=4, animid=758, limit=3000, callbacktype=1 }, --起始动作
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1, },
                            [4] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                            [5] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                            [6] = { atype=60, id=81200094, follow=true, unique=false, autostop=true },
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=757, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=204 },
                            [3] = { atype=5, buffid=80, bufflv=4, targettype=1},
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=22, type=immune_all_countrol_state, rollback=true },
                            [2] = { atype=32, type=1, srctype=3, },
                            [3] = { atype=14, targettype=0, usetime=300, position=1, offset=0, offsettype=0, direct=1, },
                            [4] = { atype=1, srctype=2, targettype=4, animid=756, limit=3000, callbacktype=1 }, --起始动作
                            [5] = { atype=2, usetype=0, typeindex=205, },
                            [6] = { atype=1, srctype=2, targettype=4, animid=760, limit=3000, callbacktype=1 }, --起始动作
                            [7] = { atype=5, buffid=80, bufflv=6, targettype=4, },
                            [8] = { atype=54, count=1, x=1.2, y=0.8, z=0.8, dis=0.1, speed=60, decay=0.3, multiply=0, },
                            [9] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=249 },
                        }
                    },
                    --[[[2] = { activetype=3, triggertype=0, delay=430,
                        action = {
                            [1] = { atype=5, buffid=80, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=0.8, y=0.9, z=0.6, dis=0.1, speed=60, decay=0.4, multiply=0, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=530,
                        action = {
                            [1] = { atype=5, buffid=80, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=630,
                        action = {
                            [1] = { atype=5, buffid=80, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=730,
                        action = {
                            [1] = { atype=5, buffid=80, bufflv=6, targettype=4, },
                            [2] = { atype=54, count=1, x=1.2, y=0.8, z=1.5, dis=0.1, speed=50, decay=0.3, multiply=0, },
                        },
                    },]]
                }
            },
            [4] = { name="技能2 伤害+降低防御", duration=4000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=3, triggertype=0, delay=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=251 },
                            [3] = { atype=27, targettype=1, distance=0, type=3, limit=3000, },
                            --[4] = { atype=41, abilityname="def_power", valuetype=1, rollback=true },
                        }
                    }
                }
            },
            [5] = { name="增加吸血属性", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18051, rollback=true, durationtime=0, },
                        }
                    }
                }
            },
            [6] = { name="技能1伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1, },
                            --[2] = { atype=27, targettype=1, distance=0.3, type=3, limit=3000, },
                        }
                    }
                }
            },
        },
    },
    [81] = { name="攻B-金木研赫子", 
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=4, limit=3000, callbacktype=1 }, --起始动作
                            [2] = { atype=2, usetype=0, typeindex=206 },
                            [3] = { atype=5, targettype=1, buffid=81, bufflv=6,},
                        }
                    },
                },
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=5, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=207 },
                            [3] = { atype=32, type=1 },
                            [4] = { atype=5, buffid=81, bufflv=5, targettype=1 },
                        }
                    }
                }
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=175 },
                            [3] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    --[[[2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=528,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [4] = { activetype=3, triggertype=0, delay=627,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [5] = { activetype=3, triggertype=0, delay=726,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [6] = { activetype=3, triggertype=0, delay=858,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [7] = { activetype=3, triggertype=0, delay=924,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },
                    [8] = { activetype=3, triggertype=0, delay=1056,
                        action = {
                            [1] = { atype=5, buffid=81, bufflv=7, targettype=4, },
                        },
                    },]]
                },
            },
            [4] = { name="破防", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="def_power", valuetype=1, rollback=true,},       --减少物防
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0},
                        }
                    }
                }
            },
            [5] = { name="击退+伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            --[2] = { atype=23, targettype=1, distance=1.5, dirtype=1,},--击退
                            -- [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=45 }
                        }
                    },
                },
            },
            [6] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            -- [1] = { atype=3, abilityname="move_speed", rollback=true }, --减少移动速度
                            -- [2] = { atype=41, abilityname="def_power", valuetype=1, rollback=true }, --减少能防
                            [1] = { atype=4, type=0, infoindex=1 },
                            -- [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=23, rollback=true, durationtime=0},--饥饿特效
                            -- [5] = { atype=61, rollback=true },
                        }
                    }
                }
            },
            [7] = { name="技能3 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid="311.316",},
                        }
                    }
                }
            },
        },
    },
    [82] = { name="防B-亚门钢太郎技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=41, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=176 }, --找范围目标
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 }, --加伤害BUFF
                            [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=333 },
                            --[5] = { atype=23, targettype=0, distance=2 },
                        }
                    }
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=42, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=177 }, --找范围目标
                            [3] = { atype=5, buffid=82, bufflv=4, targettype=1 }, --加伤害BUFF
                            --[4] = { atype=27, targettype=0, distance=2, type=3, limit=3000, },
                        }
                    },
                }
            },
            [3] = { name="技能3", duration=5000, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=40, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=335, rollback=true, durationtime=0 },
                        }
                    },
                    [2] = { activetype=2, triggertype=0, interval=1000,
                        action = {
                            [1] = { atype=2, typeindex=178 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1,},
                            [3] = { atype=6, srctype=5, targettype=0, effectid=336, callbacktype=0 },
                        },
                    },
                }
            },
            [4] = { name="技能2 伤害+概率眩晕", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=334},
                            --[2] = { atype=5, buffid=82, bufflv=5, targettype=0, actionodds=0.3 },
                            
                        }
                    }
                }
            },
            [5] = { name="技能2 眩晕", duration=1500, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=2, rollback=true, },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18053, rollback=true, durationtime=0, },--眩晕特效
                        }
                    }
                }
            },
        },
    },
    [83] = { name="技B-笛口雏实技能",
        level = {
            [1] = { name="技能1", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=155, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=180},
                            [3] = { atype=5, buffid=83, bufflv=4, targettype=1 }
                        }
                    },
                }
            },
            [2] = { name="技能2", duration=0, overlap=0, property=bit_merge(64,32,16),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=156, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=181 },
                            [3] = { atype=5, buffid=83, bufflv=8, targettype=4, },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=429,
                        action = {
                            [1] = { atype=5, buffid=83, bufflv=8, targettype=4, },
                        },
                    },
                },
            },
            [3] = { name="技能3", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=157, limit=3000, callbacktype=1 },--动作
                            [2] = { atype=2, usetype=0, typeindex=182 },--搜索附近的友方
                            [3] = { atype=5, buffid=83, bufflv=5, targettype=1 },--添加治疗
                            -- [4] = { atype=6, srctype=5, targettype=0, callbacktype=0, effectid=253 },--
                        }
                    },
                }
            },
            [4] = { name="技能1 伤害", duration=0, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1 },--伤害
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=253,},--
                        }
                    },
                }
            },
            [5] = { name="治疗", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=25, type=4, value=1 },--恢复生命
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=321,},--
                        }
                    },
                }
            },
            [6] = { name="治疗特效", duration=1100, overlap=5, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18034, durationtime=0, rollback=true, },
                        }
                    },
                }
            },
            [7] = { name="加速", duration=4000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=3, abilityname="move_speed", rollback=true }, --增加移动速度
                            [2] = { atype=41, abilityname="attack_speed", valuetype=1, rollback=true }, --增加攻击速度
                            [3] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=51, rollback=true, durationtime=0},--加速特效
                        }
                    },
                }
            },
            [8] = { name="技能2 伤害减速", duration=3000, overlap=0, property=bit_merge(64,1),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=4, type=0, infoindex=1,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=208,},--
                            --[3] = { atype=3, abilityname="move_speed", rollback=true, },
                        }
                    },
                },
            },
        },
    },
}
table.splice(g_BuffData, g_PlayerSkillBuffData)
g_PlayerSkillBuffData = nil
--[[endregion]]
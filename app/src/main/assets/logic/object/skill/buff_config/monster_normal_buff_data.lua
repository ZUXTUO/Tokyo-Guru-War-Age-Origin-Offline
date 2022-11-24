--[[
region monster_normal_buff_data.lua
date: 2015-9-18
time: 21:45:1
author: Nation
编号300-650
]]
g_MonsterNormalBuffData = {
    [300] = { name="伤害",
        level = {
            [1] = { name="1级伤害", duration=0, overlap=0, property=0,
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=4, type=0, infoindex=1 }
						}
                    }
                }
            }
        }
    },
    [301] = { name="机枪兵普攻",
        level = {
            [1] = { name="机枪兵普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=1,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=73, callbacktype=0 },
						}
					},
                    [2] = { activetype=3, triggertype=0, delay=50,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                    [3] = { activetype=3, triggertype=0, delay=400,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [302] = { name="近战兵普攻",
        level = {
            [1] = { name="近战兵普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=123, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [303] = { name="小怪305普攻",
        level = {
            [1] = { name="小怪305普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=207, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [304] = { name="小怪307普攻",
        level = {
            [1] = { name="小怪307普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=216, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [305] = { name="小怪312普攻",
        level = {
            [1] = { name="小怪312普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=225, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [306] = { name="喰种小兵327普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=373, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [307] = { name="搜查官小兵309普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=465, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [308] = { name="搜查官小兵310普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=474, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [309] = { name="搜查官小兵302_1普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=243, limit=3000, callbacktype=0 },
						}
					},
                    [2] = { activetype=3, triggertype=0, delay=528,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=105, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                    [3] = { activetype=3, triggertype=0, delay=628,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=105, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                    [4] = { activetype=3, triggertype=0, delay=728,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=105, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [310] = { name="搜查官小兵302_2普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=337, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [311] = { name="喰种小兵313普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=346, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [312] = { name="喰种小兵314普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=355, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [313] = { name="喰种小兵303普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=400, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [314] = { name="喰种小兵304普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=409, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [315] = { name="喰种小兵306普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=418, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [316] = { name="喰种小兵308普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=456, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [317] = { name="喰种小兵316普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=364, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [318] = { name="喰种小兵311普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=382, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [319] = { name="喰种小兵315普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=391, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [320] = { name="喰种小兵309普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=427, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [321] = { name="喰种小兵317普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=483, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [322] = { name="喰种小兵322普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=775, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [323] = { name="喰种小兵329普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=784, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [324] = { name="搜查官小兵301_01普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=492, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [325] = { name="搜查官小兵301_02普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=501, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [326] = { name="搜查官小兵301_03普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=510, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [327] = { name="搜查官小兵301_04普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=519, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [328] = { name="搜查官小兵301_05普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=528, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [329] = { name="搜查官小兵301_06普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=537, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [330] = { name="搜查官小兵301_07普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=546, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [331] = { name="喰种小兵310普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=436, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [332] = { name="喰种小兵318普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=804, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [333] = { name="喰种小兵328普攻",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=813, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
						}
					},
                }
            }
        }
    },
    [334] = { name="社团BOSS川村猛普攻",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=919, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=133,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=7 },
                            [2] = { atype=6, srctype=8, targettype=0, callbacktype=0, effectid=284 },

                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=466,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=7 },
                            [2] = { atype=6, srctype=8, targettype=0, callbacktype=0, effectid=285 },
                        }
                    },
                }
            },
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=920, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=133,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=7 },
                            [2] = { atype=6, srctype=8, targettype=0, callbacktype=0, effectid=286 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=400,
                        action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=7 },
                            [2] = { atype=6, srctype=8, targettype=0, callbacktype=0, effectid=287 },
                        }
                    },
                }
            },
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=921, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=138 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=288, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    -- [335] = { name="背包金木研BOSS普通攻击",
    --     level = {
    --         [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=116, limit=3000, callbacktype=1 },
    --                         [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
    --                     }
    --                 }
    --             }
    --         },
    --         [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=117, limit=3000, callbacktype=1 },
    --                         [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
    --                     }
    --                 }
    --             }
    --         },
    --         [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=118, limit=3000, callbacktype=1 },
    --                         [2] = { atype=2, usetype=0, typeindex=148 },
    --                         [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
    --                         [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
    --                         [5] = { atype=27, targettype=0, type=3 },
    --                     }
    --                 }
    --             }
    --         }
    --     }
    -- },
    -- [336] = { name="白发金木研BOSS普攻",
    --     level = {
    --         [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=957, limit=3000, callbacktype=1 },
    --                         [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
    --                     }
    --                 }
    --             }
    --         },
    --         [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=958, limit=3000, callbacktype=1 },
    --                         [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
    --                         [3] = { atype=20, delay=462 },
    --                         [4] = { atype=5, buffid=1, bufflv=1, targettype=2 },
    --                     }
    --                 }
    --             }
    --         },
    --         [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
    --             trigger = {
    --                 [1] = { activetype=0, triggertype=0,
    --                     action = {
    --                         [1] = { atype=1, srctype=2, targettype=4, animid=959, limit=3000, callbacktype=1 },
    --                         [2] = { atype=2, usetype=0, typeindex=149 },
    --                         [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
    --                         [4] = { atype=6, srctype=5, targettype=0, effectid=292, callbacktype=0 },
    --                         [5] = { atype=27, targettype=0, type=3 },
    --                     }
    --                 }
    --             }
    --         }
    --     }
    -- },
    [337] = { name="芳村功善BOSS普攻",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=967, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    }
                }
            },
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=968, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                        }
                    }
                }
            },
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=969, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=151 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=292, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3 },
                        }
                    }
                }
            }
        }
    },
    [338] = { name="喰种小兵301a普攻",
        level = {
            [1] = { name="喰种小兵301a普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=822, callbacktype=0, limit=3000, },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=400,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=550,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                    [4] = { activetype=3, triggertype=0, delay=700,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=6, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [339] = { name="精英怪h501（枪盾）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1050, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=218,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=400, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=219,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=400, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=220,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=400, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [340] = { name="精英怪h502（翅膀）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1059, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=221,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=222,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=223,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=401, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [341] = { name="精英怪s501（大手单赫子）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1068, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=224,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=402, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=225,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=402, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=226,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=402, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [342] = { name="精英怪s502（长臂两赫子）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1077, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=227,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=403, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=228,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=403, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=229,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=403, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [343] = { name="精英怪s503（大胖子）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1092, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=230,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=404, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=231,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=404, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=232,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=404, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [344] = { name="精英怪s504（萝莉）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1101, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=233,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=405, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=234,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=405, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=235,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=405, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [345] = { name="小兵-近战CCG普攻h401",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1110, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [346] = { name="小兵-远程CCG普攻h402",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1119, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [347] = { name="小兵-远程喰种普攻s401",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1128, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [348] = { name="小兵-近战喰种普攻s402",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1137, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [349] = { name="精英怪s506（雪地靴背后两根赫子）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1179, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=255,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=450, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*22,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=256,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=450, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*54,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=257,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=450, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [350] = { name="精英怪s507(运动服3条赫子)普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1186, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=258,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=451, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*25,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=259,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=451, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*43,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=260,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=451, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [351] = { name="精英怪h504(背上武器罐)普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1193, callbacktype=2, limit=3000, },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*30,
                        action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=453, callbacktype=1, durationwithspeed=true, limit=3000,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        },
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*65,
                    action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=453, callbacktype=1, durationwithspeed=true, limit=3000,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        },
                    },
                }
            }
        }
    },
    [352] = { name="精英怪h505（匕首武器）普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1200, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=261,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=452, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*23,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=262,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=452, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*39,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=263,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=452, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [353] = { name="精英怪jy_s321普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1207, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=264,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=457, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*34,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=265,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=457, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*57,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=266,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=457, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [354] = { name="精英怪jy_s325普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1214, callbacktype=1, limit=3000, },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=460, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*28,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=267,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=460, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*57,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=268,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=460, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [355] = { name="精英怪jy_h303普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1221, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=269,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=459, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*42,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=270,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=459, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*84,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=271,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=459, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [356] = { name="精英怪jy_h503普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1228, callbacktype=1, limit=3000, },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=456, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*16,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=272,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=456, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*34,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=273,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=456, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [357] = { name="精英怪jy_h510普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1235, callbacktype=1, limit=3000, },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=458, callbacktype=0 },
                            [4] = { atype=20, delay=33*11, },
                            [5] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                            [6] = { atype=6, srctype=5, targettype=0, effectid=458, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*31,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=274,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=458, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [358] = { name="精英怪jy_s508普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1242, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=275,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=454, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*23,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=276,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=454, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*47,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=277,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=454, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [359] = { name="精英怪jy_s509普攻",
        level = {
            [1] = { name="普攻", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1249, callbacktype=1, limit=3000, },
                            [2] = { atype=2, usetype=0, typeindex=278,},
                            [3] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=455, callbacktype=0 },
                        }
                    },
                    [2] = { activetype=3, triggertype=0, delay=33*29,
                        action = {
                            [1] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                            [2] = { atype=6, srctype=5, targettype=0, effectid=455, callbacktype=0 },
                        }
                    },
                    [3] = { activetype=3, triggertype=0, delay=33*52,
                        action = {
                            [1] = { atype=2, usetype=0, typeindex=279,},
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=1 },
                            [3] = { atype=6, srctype=5, targettype=0, effectid=455, callbacktype=0 },
                        }
                    },
                }
            }
        }
    },
    [360] = { name="小兵-远程喰种普攻s337",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1256, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [361] = { name="小兵-近战喰种普攻s339",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1264, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [362] = { name="小兵-近战喰种普攻s340",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1272, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [363] = { name="小兵-近战喰种普攻s341",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1280, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [364] = { name="小兵-近战喰种普攻s320",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1288, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [365] = { name="小兵-近战喰种普攻s323",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1296, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
    [366] = { name="3v3炮塔",
        level = {
            [1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=1, srctype=2, targettype=4, animid=1362, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=300, bufflv=1, targettype=2 },
                        }
                    },
                }
            }
        }
    },
}
table.splice(g_BuffData, g_MonsterNormalBuffData)
g_MonsterNormalBuffData = nil
--[[endregion]]
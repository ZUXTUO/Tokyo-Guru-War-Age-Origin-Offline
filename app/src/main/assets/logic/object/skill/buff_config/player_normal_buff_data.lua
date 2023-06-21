--[[
region player_normal_buff_data.lua
date: 2015-9-18
time: 21:46:16
author: Nation
编号从100-200
]]
g_PlayerNormalBuffData = {
    [100] = { name="金木研普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=4 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=2, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=76 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=3, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=33 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=11, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=343 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=308, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=3*33 },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=308, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
                            [10] = { atype=20, delay=5*33 },
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [12] = { atype=6, srctype=5, targettype=0, effectid=308, callbacktype=0 },
                            [13] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},

				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=12, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=344 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=309, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [101] = { name="雾岛董香普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=19, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=6 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=20, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=17 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=21, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=89 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=33, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=25 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=4, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=34, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=347 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=40, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [102] = { name="西尾锦普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=90, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=27 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=91, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=58 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=92, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=74 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=88, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=34 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=207, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=89, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=341 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=9, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [103] = { name="神代利世普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=101, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=370 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=348, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=102, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=371 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=349, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=103, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=372, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=350, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=6*33},
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=350, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
                            [10] = { atype=20, delay=7*33},
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [12] = { atype=6, srctype=5, targettype=0, effectid=350, callbacktype=0 },
                            [13] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1023, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=373, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=351, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1024, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=370, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=352, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    
    [105] = { name="大守八云普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0, condition=2, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=260, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
                    [2] = { activetype=0, triggertype=0, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=252, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0, condition=2, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=261, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=27, targettype=2, type=3, distype=2 },

						}
					},
                    [2] = { activetype=0, triggertype=0, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=253, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0, condition=2, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=262, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=35 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=163, callbacktype=0 },
                            -- [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
                    [2] = { activetype=0, triggertype=0, group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=254, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=36 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=163, callbacktype=0 },
                            -- [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [106] = { name="亚门钢太郎普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=37, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=75 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=38, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=106 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=39, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=366 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=49, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=367 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=331, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=50, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=29 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=332, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [107] = { name="真户吴绪普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=174, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=37 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=164, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=175, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=245 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=164, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=176, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=246 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=164, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1157, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=247 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=164, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1158, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=248 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=164, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [108] = { name="月山习普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=129, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=130, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=131, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=42 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=166, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=33*4, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=166, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1041, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=148 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=437, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1042, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=149 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=438, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=33*4, },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=438, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [109] = { name="蜈蚣金木普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,group=1,condition=32,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=301, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=69,},
                            [3] = { atype=5, buffid=1, bufflv=1,targettype=1,},
                            [4] = { atype=5, buffid=1, bufflv=2,targettype=1,},
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            -- [5] = { atype=6, srctype=2 ,targettype=0 ,effectid= ,callbacktype=0 ,condition=32,},
						}
					},
					[2] = { activetype=0, triggertype=0,group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=294, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
                            -- [5] = { atype=6, srctype=2 ,targettype=0 ,effectid= ,callbacktype=0 ,condition=32,},
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,group=1,condition=32,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=302, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=70,},
                            [3] = { atype=5, buffid=1, bufflv=1,targettype=1,},
                            [4] = { atype=5, buffid=1, bufflv=2,targettype=1,},
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            -- [5] = { atype=6, srctype=2 ,targettype=0 ,effectid= ,callbacktype=0 ,condition=32,},
						}
					},
					[2] = { activetype=0, triggertype=0,group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=295, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
                            -- [5] = { atype=6, srctype=2 ,targettype=0 ,effectid= ,callbacktype=0 ,condition=32,},
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,group=1,condition=32,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=303, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=72,},
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=5, buffid=1, bufflv=2, targettype=1,},
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
					[2] = { activetype=0, triggertype=0,group=1,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=296, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=73 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
				}
			}
		}
	},
    [110] = { name="不杀之枭普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=194, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=195, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=196, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=90 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=210, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [111] = { name="笛口雏实普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=152, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=18 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=153, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=26 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=154, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=83 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=995, callbacktype=1 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=38 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=208, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=996, callbacktype=1 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=342 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=208, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [112] = { name="笛口凉子普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=234, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=160 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=235, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=161 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=236, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=19 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=6, srctype=5, targettype=0, effectid=375, callbacktype=0 },
							[5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1043, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=20 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=376, callbacktype=0 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1044, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=21 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=377, callbacktype=0 },
						}
					}
				}
			}
		}
	},
    [113] = { name="原创CCG炮形昆克普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=90, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=91, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=92, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=91 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [114] = { name="魔猿形态普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=851, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=852, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=853, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=858, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=92 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=259, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=859, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=243 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=260, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [115] = { name="多多良普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=185, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=186, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=187, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=93 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=209, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [116] = { name="御坂普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=632, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=633, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=634, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=94 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=223, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [117] = { name="瓶兄普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=709, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=710, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=711, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=95 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=229, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [118] = { name="篠原幸纪普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					-- [1] = {	activetype=0, triggertype=0,group=1,condition=25, -- [[如果狂化buff为一层时]]
					-- 	action = {
					-- 		[1] = { atype=5, buffid=31, bufflv=2, targettype=0},
					-- 		[2] = { atype=21, skillid=59},
					-- 	},
					-- },
					[1] = { activetype=0, triggertype=0,group=1, -- [[如果狂化buff不为一层时]]
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=271, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=11, buffid=31,bufflv=5, targettype=0,immediately=false},
                            [3] = { atype=5, buffid=118, bufflv=7, targettype=0, condition=26,},
                            [4] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					-- [1] = {	activetype=0, triggertype=0,group=1,condition=25, -- [[如果狂化buff为一层时]]
					-- 	action = {
					-- 		[1] = { atype=5, buffid=31, bufflv=2, targettype=0},
					-- 		[2] = { atype=21, skillid=59},
					-- 	},
					-- },
					[1] = { activetype=0, triggertype=0,group=1, -- [[如果狂化buff不为一层时]]
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=272, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            -- [3] = { atype=11, buffid=31,bufflv=5, targettype=0,immediately=false},
                            [3] = { atype=5, buffid=118, bufflv=7, targettype=0, condition=26,},
                            [4] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					-- [1] = {	activetype=0, triggertype=0,group=1,condition=25, -- [[如果狂化buff为一层时]]
					-- 	action = {
					-- 		[1] = { atype=5, buffid=31, bufflv=2, targettype=0},
					-- 		[2] = { atype=21, skillid=59},
					-- 	},
					-- },
					[1] = { activetype=0, triggertype=0,group=1, -- [[如果狂化buff不为一层时]]
						action = {
                            [1] = { atype=5, buffid=118, bufflv=4, targettype=0 },
                            -- [2] = { atype=11, buffid=31,bufflv=5, targettype=0,immediately=false},
						}
					},
				},
			},
			[4] = { name="3段状态", duration=0,overlap=0,property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0,triggertype=0,group=1,condition=26,--[[普通状态]]
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=280, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=118,bufflv=6,targettype=0},
                            -- [4] = { atype=27, targettype=0, distance=2,limit=1000,type=5,distype=0},
                            -- [5] = { atype=5, buffid=118,bufflv=5,targettype=2},
						}
					},
					[2] = { activetype=0,triggertype=0,group=1,--[[无状态]]
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=273, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=67 },
                            [3] = { atype=5, buffid=1, bufflv=1,targettype=1 },
                            [4] = { atype=27, targettype=0, type=3 },
						},
					},
				},
			},
			-- [5] = { name="迟缓", duration=3000,overlap=5,property=bit_merge(64,32,2),
			-- 	trigger = {
			-- 		[1] = { activetype=0,triggertype=0,
			-- 			action = {
   --                          [1] = { atype=3, abilityname="move_speed", scale=0.75, rollback=true }, --减少移动速度
			-- 			},
			-- 		},
			-- 	},
			-- },
			[6] = { name="气场", duration=3000,overlap=0,property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=2,triggertype=0,interval=1000,
						action = {
                            [1] = { atype=2, usetype=0, typeindex=68 },
                            [2] = { atype=5, buffid=1, bufflv=2,targettype=1 },
                            [3] = { atype=27, targettype=0, type=3 },
						},
					},
				},
			},
			[7] = { name="1、2段状态", duration=0,overlap=0,property=bit_merge(64,32,2),
				trigger = {
					-- [1] = { activetype=0,triggertype=0,group=1,condition=26,--[[重击状态]]
					-- 	action = {
					-- 	}
					-- },
					[1] = { activetype=0,triggertype=0,--group=1,--[[普通状态]]
						action = {
                            [1] = { atype=2, usetype=0, typeindex=66},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=1},
						},
					},
				},
			},
		}
	},
    [119] = { name="平子丈普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=142, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=377 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=357, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=143, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=378 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=358, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=144, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=379, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=359, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, },
						}
					},
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1029, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=380, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=360, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1030, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=381, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=361, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [120] = { name="黑磐岩普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=566, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=567, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=568, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=96 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=218, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [121] = { name="法寺项介普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=555, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=556, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=557, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=97 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=217, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [122] = { name="泷泽政道普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=285, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=286, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
					[2] = { activetype=3, triggertype=0, delay=33*13,
						action = {
							[1] = { atype=6, srctype=2, targettype=4, effectid=78, position=7, len=0, direct=1, directoffset=0,callbacktype=1,durationwithspeed=true, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 }, 
						},
					},
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=287, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=291, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=292, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=217 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=76, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
				}
			},
		}
	},
    [123] = { name="有马贵将普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=676, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=677, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=678, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=98 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=226, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [124] = { name="神代叉荣普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=731, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=732, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=733, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=99 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=231, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [125] = { name="原创CCG1普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=90, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=91, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=92, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=100 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [126] = { name="田中丸望元普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=621, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=622, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=623, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=101 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=222, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [127] = { name="真户晓普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=55, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=127 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=56, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=131 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=57, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=163 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=2*33 },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=58, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=164 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=331, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=59, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=165 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=332, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [128] = { name="五里美乡普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=588, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=150 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=589, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=159 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=590, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=102 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=219, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1031, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=382 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=382, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1032, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=383 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=383, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [129] = { name="安久奈白普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=753, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=152 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=362, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=754, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=153 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=363, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=755, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=103 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=364, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1027, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=362, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=365, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1028, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=361, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=366, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [130] = { name="钵川忠普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=599, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=600, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=600, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=608, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=104 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=220, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=609, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=253 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=220, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [131] = { name="野吕普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=764, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=765, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=766, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=105 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=234, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [132] = { name="宇井郡普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=610, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=167 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=2, type=3, distype=2 },
							--[5] = { atype=6, srctype=5, targettype=0, effectid=237, callbacktype=0 },
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=611, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=60 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=371, callbacktype=0 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=612, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=61 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=372, callbacktype=0 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1037, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=63 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=373, callbacktype=0 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1038, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=71 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=374, callbacktype=0 },
						}
					}
				}
			}
		}
	},
    [133] = { name="太郎普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=665, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=666, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=107 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=412, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=667, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=170 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=413, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1146, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=171 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=414, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1147, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=172 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=415, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
    [134] = { name="安久黑奈普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=742, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=743, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=744, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=108 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=232, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [135] = { name="笛口亚关普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=101, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=102, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=103, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=109 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [136] = { name="瓶弟普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=720, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=168 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=721, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=169 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=722, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=77 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=230, callbacktype=0 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1033, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=78 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=384, callbacktype=0 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1034, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=81 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=385, callbacktype=0 },
							[6] = { atype=20, delay=6*33 },
							[7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[8] = { atype=27, targettype=0, type=3, distype=2 },
							[9] = { atype=6, srctype=5, targettype=0, effectid=385, callbacktype=0 },
						}
					}
				}
			}
		}
	},
    [137] = { name="原创CCG2普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=101, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=102, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=103, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=111 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [138] = { name="铃屋什造普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=161, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=154 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=300, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=162, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=155 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=301, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=163, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=40 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=165, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=993, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=156 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=165, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
                            [6] = { atype=20, delay=231 },
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=6, srctype=5, targettype=0, effectid=165, callbacktype=0 },
                            [9] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=994, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=157 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=165, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	[139] = { name="独眼之枭普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=319, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=320, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=321, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=41 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=216, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [140] = { name="呗普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=445, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=446, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=447, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=112 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=161, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [141] = { name="四方莲示普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=643, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=349 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=322, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=644, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=350 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=323, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=645, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=351 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=224, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1025, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=113 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=324, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1026, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=352 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=325, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	}, 
    [142] = { name="万丈数一普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=687, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=132 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=237, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=688, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=133 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=689, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=137 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1039, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=8 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=227, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1040, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=16 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=378, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
    [143] = { name="雾岛绚都普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=698, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=110 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=699, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=114 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=700, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=116 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1021, limit=3000, callbacktype=2 },
                            [2] = { atype=2, usetype=0, typeindex=122 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1022, callbacktype=0 },
                            [2] = { atype=2, usetype=0, typeindex=115 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
                            [5] = { atype=6, srctype=5, targettype=0, effectid=142, callbacktype=0 },
                            [6] = { atype=20, delay=6*33},
                            [7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [8] = { atype=27, targettype=0, type=3, distype=2 },
                            [9] = { atype=6, srctype=5, targettype=0, effectid=142, callbacktype=0 },
                            [10] = { atype=20, delay=6*33},
                            [11] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [12] = { atype=27, targettype=0, type=3, distype=2 },
                            [13] = { atype=6, srctype=5, targettype=0, effectid=142, callbacktype=0 },
						}
					},
				}
			}
		}
	},
    [144] = { name="纳基普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=304, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=162 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=6, srctype=5, targettype=0, effectid=237, callbacktype=0 },
							[5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
			[2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=305, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=166 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=2, type=3, distype=2 },
							--[4] = { atype=6, srctype=5, targettype=0, effectid=238, callbacktype=0 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=306, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=28 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=379, callbacktype=0 },
							[6] = { atype=20, delay=5*33 },
							[7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[8] = { atype=27, targettype=0, type=3, distype=2 },
							[9] = { atype=6, srctype=5, targettype=0, effectid=379, callbacktype=0 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1045, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=39 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=380, callbacktype=0 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1046, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=43 },
							[3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[4] = { atype=27, targettype=0, type=3, distype=2 },
							[5] = { atype=6, srctype=5, targettype=0, effectid=381, callbacktype=0 },
							[6] = { atype=20, delay=5*33 },
							[7] = { atype=5, buffid=1, bufflv=1, targettype=1 },
							[8] = { atype=27, targettype=0, type=3, distype=2 },
							[9] = { atype=6, srctype=5, targettype=0, effectid=381, callbacktype=0 },
						}
					}
				}
			}
		}
	},
	[145] = { name="楠木遥人普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=793, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=794, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=795, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=117 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=235, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	[146] = { name="背包金木研普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=116, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=139 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=433, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=117, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=236 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=434, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=118, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=237 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=299, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=114, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=238 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=410, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=115, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=239 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=411, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	[147] = { name="白发金木研普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=957, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
                            [4] = { atype=20, delay=33*11, },
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [6] = { atype=27, targettype=3, type=3, distype=2 },
						}
					},
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=958, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=959, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=140 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=292, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1035, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=402 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [4] = { atype=6, srctype=9, targettype=0, effectid=386, callbacktype=0 },
                            [5] = { atype=27, targettype=3, type=3, distype=2 },
						}
					},
					[2] = { activetype=3, triggertype=0, delay=33*8,
						action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [2] = { atype=27, targettype=3, type=3, distype=2 },
                            [3] = { atype=6, srctype=9, targettype=0, effectid=386, callbacktype=0 },
						}
					},
					[3] = { activetype=3, triggertype=0, delay=33*10,
						action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [2] = { atype=27, targettype=3, type=3, distype=2 },
                            [3] = { atype=6, srctype=9, targettype=0, effectid=386, callbacktype=0 },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1036, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=403 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [4] = { atype=6, srctype=9, targettype=0, effectid=387, callbacktype=0 },
                            [5] = { atype=27, targettype=3, type=3, distype=2 },
						}
					},
					[2] = { activetype=3, triggertype=0, delay=33*18,
						action = {
                            [1] = { atype=5, buffid=1, bufflv=1, targettype=4 },
                            [2] = { atype=27, targettype=3, type=3, distype=2 },
                            [3] = { atype=6, srctype=9, targettype=0, effectid=387, callbacktype=0 },
						}
					},
				}
			},
		}
	},
	[148] = { name="杰森 暴走普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=260, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=356 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=337, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=261, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=357 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=338, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=262, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=358 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=339, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=266, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=359 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=340, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=267, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=360 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=341, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
	[149] = { name="村松希惠普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=483, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=212 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=422, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1148, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=213 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=422, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1149, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=214 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=422, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1150, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=215 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=422, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1151, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=216 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=422, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	[150] = { name="中岛康健普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=474, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=475, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=476, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=477, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=150, bufflv=6, targettype=0 },
						}
					},
					[2] = { activetype=3, triggertype=0, delay=33*16,
						action = {
                            [1] = { atype=5, buffid=150, bufflv=7, targettype=0 },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=478, limit=3000, callbacktype=2 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [6] = { name="4段弹道1", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=440, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [7] = { name="4段弹道2", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
                            [1] = { atype=6, srctype=2, targettype=4, effectid=440, callbacktype=1, limit=3000,},
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=3, type=3, distype=2 },
                            [4] = { atype=6, srctype=9, targettype=0, effectid=387, callbacktype=0 },
						}
					}
				}
			},
		}
	},
	[151] = { name="地行甲乙普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1167, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1168, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1169, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1170, limit=3000, callbacktype=1 },
                            [2] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [3] = { atype=27, targettype=2, type=3, distype=2 },
                            [4] = { atype=20, delay=33*6, },
                            [5] = { atype=5, buffid=1, bufflv=1, targettype=2 },
                            [6] = { atype=27, targettype=3, type=3, distype=2 },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1171, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=251 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=446, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	--------------------------------战斗数据模型----------------------------------
	[180] = { name="标准模型B-安久奈白普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=753, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=188 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=362, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=754, limit=3000, callbacktype=1 },
							[2] = { atype=2, usetype=0, typeindex=189 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=363, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=755, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=190 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=364, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1027, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=191, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=365, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, },
						}
					},
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1028, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=192, },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=366, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
	[181] = { name="攻B-金木研普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=1, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=183 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=2, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=184 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=3, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=185 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=11, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=186 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=308, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					},

				}
			},
			[5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=12, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=187 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=309, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
		}
	},
	[182] = { name="防B-亚门钢太郎普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=37, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=193 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=38, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=194 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=39, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=195 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=330, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=49, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=196 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=331, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32,2),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=50, limit=3000, callbacktype=1 },
                            [2] = { atype=2, usetype=0, typeindex=197 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=332, callbacktype=0 },
                            [5] = { atype=27, targettype=2, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
	[183] = { name="技B-笛口凉子普通攻击",
		level = {
			[1] = { name="1段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=152, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=198 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [2] = { name="2段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=153, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=199 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[3] = { name="3段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=154, callbacktype=2 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=200 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
			[4] = { name="4段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=995, callbacktype=1 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=201 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=208, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			},
            [5] = { name="5段", duration=0, overlap=0, property=bit_merge(64,32),
				trigger = {
					[1] = { activetype=0, triggertype=0,
						action = {
							[1] = { atype=1, srctype=2, targettype=4, animid=996, callbacktype=1 ,limit=3000 },
							[2] = { atype=2, usetype=0, typeindex=202 },
                            [3] = { atype=5, buffid=1, bufflv=1, targettype=1 },
                            [4] = { atype=6, srctype=5, targettype=0, effectid=208, callbacktype=0 },
                            [5] = { atype=27, targettype=0, type=3, distype=2 },
						}
					}
				}
			}
		}
	},
}
table.splice(g_BuffData, g_PlayerNormalBuffData)
g_PlayerNormalBuffData = nil
--[[endregion]]
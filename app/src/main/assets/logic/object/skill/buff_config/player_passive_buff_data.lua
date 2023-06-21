--[[
region player_passive_buff_data.lua
date: 2016-6-13
time: 18:25:49
author: Nation
编号2000-2999
]]
g_PlayPassiveBuffData = {
	[2000] = { name="金木研 ", 
        level = {
            [1] = { name="金木研 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4000,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="金木研 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4001,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="金木研 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4002,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_hurt", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2001] = { name="太郎 ", 
        level = {
            [1] = { name="太郎 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4003,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="太郎 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4004,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="太郎 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4005,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="attack_speed", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2002] = { name="泷泽政道 ", 
        level = {
            [1] = { name="泷泽政道 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4006,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="泷泽政道 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4007,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="泷泽政道 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4008,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="broken_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2003] = { name="万丈数一 ", 
        level = {
            [1] = { name="万丈数一 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4009,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="万丈数一 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4010,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="万丈数一 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4011,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="parry_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2004] = { name="笛口凉子 ", 
        level = {
            [1] = { name="笛口凉子 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4012,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="笛口凉子 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4013,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="笛口凉子 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4014,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="cool_down_dec", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2005] = { name="西尾锦 ", 
        level = {
            [1] = { name="西尾锦 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4015,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="西尾锦 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4016,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="西尾锦 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4017,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="attack_speed", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2006] = { name="纳基 ", 
        level = {
            [1] = { name="纳基 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4018,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="纳基 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4019,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="纳基 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4020,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2007] = { name="五里美乡 ", 
        level = {
            [1] = { name="五里美乡 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4021,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="五里美乡 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4022,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="五里美乡 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4023,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                                [1] = { atype=41, abilityname="crit_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2008] = { name="平子丈 ", 
        level = {
            [1] = { name="平子丈 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4024,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="平子丈 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4025,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="平子丈 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4026,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="anti_crite", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2009] = { name="真户晓 ", 
        level = {
            [1] = { name="真户晓 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4027,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="真户晓 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4028,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="真户晓 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4029,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="parry_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2010] = { name="安久奈白 ", 
        level = {
            [1] = { name="安久奈白 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4030,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="安久奈白 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4031,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="安久奈白 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4032,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2011] = { name="楠木遥人 ", 
        level = {
            [1] = { name="楠木遥人 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4033,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="楠木遥人 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4034,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="楠木遥人 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4035,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="broken_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2012] = { name="雾岛董香 ", 
        level = {
            [1] = { name="雾岛董香 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4036,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="雾岛董香 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4037,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="雾岛董香 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4038,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2013] = { name="笛口雏实 ", 
        level = {
            [1] = { name="笛口雏实 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4039,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="笛口雏实 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4040,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="笛口雏实 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4041,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="cool_down_dec", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2014] = { name="铃屋什造 ", 
        level = {
            [1] = { name="铃屋什造 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4042,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="铃屋什造 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4043,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="铃屋什造 被动buff3", duration=0, overlap=0, property=bit_merge(64), skillid=4044,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=132, },
                            [2] = { atype=5, bufflv=2014, buffid=4, targettype=1, },
						}
                    },
                },
            },
            [4] = { name="铃屋什造被动buff3 提升所有英雄暴击", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_rate", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
	[2015] = { name="钵川忠 ", 
        level = {
            [1] = { name="钵川忠 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4045,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="钵川忠 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4046,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="钵川忠 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4047,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_hurt", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2016] = { name="月山习 ", 
        level = {
            [1] = { name="月山习 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4048,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="月山习 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4049,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="月山习 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4050,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2017] = { name="亚门钢太朗 ", 
        level = {
            [1] = { name="亚门钢太朗 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4051,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="亚门钢太朗 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4052,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="亚门钢太朗 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4053,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="rally_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2018] = { name="宇井郡 ", 
        level = {
            [1] = { name="宇井郡 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4054,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="宇井郡 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4055,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="宇井郡 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4056,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="anti_crite", valuetype=1, },
						}
                    },
                },
            },
        },
    },
	[2019] = { name="神代利世 ", 
        level = {
            [1] = { name="神代利世 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4057,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="神代利世 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4058,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="神代利世 被动buff3", duration=0, overlap=0, property=bit_merge(64), skillid=4059,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=2, srctype=1, targettype=133, },
                            [2] = { atype=5, bufflv=2019, buffid=4, targettype=1, },
						}
                    },
                },
            },
            [4] = { name="神代利世被动buff3 提升所有英雄暴击伤害加成", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_hurt", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
	[2020] = { name="真户吴绪 ", 
        level = {
            [1] = { name="真户吴绪 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4060,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="atk_power", valuetype=1, },
						}
                    },
                },
            },
            [2] = { name="真户吴绪 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4061,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                        	[1] = { atype=41, abilityname="max_hp", valuetype=1, },
                        	[2] = { atype=41, abilityname="def_power", valuetype=1, },
						}
                    },
                },
            },
            [3] = { name="真户吴绪 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4062,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, },
						}
                    },
                },
            },
        },
    },
    --------------------------------战斗数据模型----------------------------------
    [2500] = { name="标准模型B-安久奈白 ", 
        level = {
            [1] = { name="标准模型B-安久奈白 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4030,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="atk_power", valuetype=1, },
                        }
                    },
                },
            },
            [2] = { name="标准模型B-安久奈白 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4031,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="def_power", valuetype=1, },
                        }
                    },
                },
            },
            [3] = { name="标准模型B-安久奈白 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4032,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="bloodsuck_rate", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
    [2501] = { name="攻B-金木研 ", 
        level = {
            [1] = { name="攻B-金木研 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4000,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="atk_power", valuetype=1, },
                        }
                    },
                },
            },
            [2] = { name="攻B-金木研 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4001,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="def_power", valuetype=1, },
                        }
                    },
                },
            },
            [3] = { name="攻B-金木研 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4002,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="crit_hurt", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
    [2502] = { name="防B-亚门钢太朗 ", 
        level = {
            [1] = { name="防B-亚门钢太朗 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4051,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="atk_power", valuetype=1, },
                        }
                    },
                },
            },
            [2] = { name="防B-亚门钢太朗 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4052,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="def_power", valuetype=1, },
                        }
                    },
                },
            },
            [3] = { name="防B-亚门钢太朗 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4053,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="rally_rate", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
    [2503] = { name="技B-笛口凉子 ", 
        level = {
            [1] = { name="技B-笛口凉子 被动buff1", duration=-1, overlap=0, property=bit_merge(64), skillid=4012,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="atk_power", valuetype=1, },
                        }
                    },
                },
            },
            [2] = { name="技B-笛口凉子 被动buff2", duration=-1, overlap=0, property=bit_merge(64), skillid=4013,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="max_hp", valuetype=1, },
                            [2] = { atype=41, abilityname="def_power", valuetype=1, },
                        }
                    },
                },
            },
            [3] = { name="技B-笛口凉子 被动buff3", duration=-1, overlap=0, property=bit_merge(64), skillid=4014,
                trigger = {
                    [1] = { activetype=0, triggertype=0,
                        action = {
                            [1] = { atype=41, abilityname="cool_down_dec", valuetype=1, },
                        }
                    },
                },
            },
        },
    },
}
table.splice(g_BuffData, g_PlayPassiveBuffData)
g_PlayPassiveBuffData = nil
--[[endregion]]

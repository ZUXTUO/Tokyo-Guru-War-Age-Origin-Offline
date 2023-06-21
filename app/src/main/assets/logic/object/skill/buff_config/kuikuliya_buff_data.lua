--[[
region kuikuliya_buff_data.lua
date: 2016-11-22
author: lhf
编号1006-1206
]]
g_KuikuliyaBuffData = {
    --------[[奎库利亚]]-----------
  
    ----------------------------------------------------------------------------
    --      吸收伤害护盾
    [1101] = { name="吸收伤害",
        level = {
            [1] = { name="2000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=2000},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
	    [2] = { name="5000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=5000},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [3] = { name="8000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=8000},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [4] = { name="10000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=10000},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [5] = { name="20000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=20000},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
        },
    },

    --      己方攻击提升
    [1102] = { name="攻击提升",
        level = {
            [1] = { name="+10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=1.1},
                        },
                    },
                },
            },
	    [2] = { name="+20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=1.2},
                        },
                    },
                },
            },
        },
    },

    --      己方防御提升
    [1103] = { name="防御提升",
        level = {
            [1] = { name="+10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="def_power",scale=1.1},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [2] = { name="+20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=1.2},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },									
        },
    },

    --      反伤
    [1104] = { name="反伤",
        level = {
            [1] = { name="+10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.1},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [2] = { name="+20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.2},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },   
        },
    },

    --      己方攻击降低
    [1105] = { name="攻击降低",
        level = {
            [1] = { name="-10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=0.9},
                        },
                    },
                },
            },
	    [2] = { name="-20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=0.8},
                        },
                    },
                },
            },
        },
    },

    --      己方防御降低
    [1106] = { name="防御降低",
        level = {
            [1] = { name="-10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="def_power",scale=0.9},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [2] = { name="-20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=0.8},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },									
        },
    },

    --      己方随机X个技能无法使用
    [1107] = { name="随机技能锁定",
        level = {
            [1] = { name="1个技能都无法使用", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            --                这里设置技能位置    这里设置随机几个
                            [1] = { atype=89, skill_list={1,2,3}, num=1},
                        }
                    },
                },
            },  
            [2] = { name="2个技能都无法使用", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            --                这里设置技能位置    这里设置随机几个
                            [1] = { atype=89, skill_list={1,2,3}, num=2},
                        }
                    },
                },
            },        			
        },
    },

    --      己方开场损失X%生命值
    [1108] = { name="损失生命",
        level = {
            [1] = { name="10%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.1},
                        },
                    },
                },
            },
            [2] = { name="20%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.2},
                        },
                    },
                },
            },			
        },
    },

    --------------------------------------------------------------------------------------
    [1006] = { name="防御属性",
        level = {
            [1] = { name="-20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="def_power",scale=0.8},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [2] = { name="-40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=0.6},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [3] = { name="-60%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=0.4},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [4] = { name="-80%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=0.2},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18045, rollback=true, durationtime=0, },
                        },
                    },
                },
            },			
            [11] = { name="+20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=1.2},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },			
            [12] = { name="+40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=3,abilityname="def_power",scale=1.4},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18040, rollback=true, durationtime=0, },
                        },
                    },
                },
            },									
        },
    },
    [1007] = { name="制造伤害缩放",
        level = {
            [1] = { name="-20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                        --                  这里设置增加值
                            [1] = {atype=30,scale=0.8,odds=1},
                        },
                    },
                },
            },
            [2] = { name="+40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=30,scale=1.4,odds=1},
                        },
                    },
                },
            },
			[3] = { name="-40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=30,scale=0.6,odds=1},
                        },
                    },
                },
            },
        },
    },
    [1008] = { name="受到伤害缩放",
        level = {
            [1] = { name="+30%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                        --                  这里设置增加值
                            [1] = {atype=31,scale=1.3,odds=1},
                        },
                    },
                },
            },
            [2] = { name="+40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = 
                    { activetype=0,triggertype=1,
                        action = 
                        {
                            [1] = {atype=31,scale=1.4,odds=1},
                        },
                    },
                },
            },
        },
    },
    [1009] = { name="反伤",
        level = {
            [1] = { name="+10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.1},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [2] = { name="+15%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.15},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },			
			[3] = { name="+20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.2},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },
            [4] = { name="+30%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                            这里设置增加值
                            [1] = {atype=97,type=7,scale=0.3},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18041, rollback=true, durationtime=0, },
                        },
                    },
                },
            },   
        },
    },
    [1010] = { name="损失生命",
        level = {
            [1] = { name="10%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.1},
                        },
                    },
                },
            },
            [2] = { name="20%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.2},
                        },
                    },
                },
            },
            [3] = { name="40%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.4},
                        },
                    },
                },
            },
            [4] = { name="60%",duration=0,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                              这里设置增加值
                            [1] = {atype=4, type=1, persent=0.6},
                        },
                    },
                },
            },			
        },
    },
    [1011] = { name="攻击",
        level = {
            [1] = { name="+10%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=1.1},
                        },
                    },
                },
            },
			[2] = { name="-20%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=0.8},
                        },
                    },
                },
            },
			[3] = { name="-40%",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                                          这里设置增加值
                            [1] = {atype=3,abilityname="atk_power",scale=0.6},
                        },
                    },
                },
            },
        },
    },
    [1012] = { name="吸收伤害",
        level = {
            [1] = { name="50000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=50000},
                        },
                    },
                },
            },
			[2] = { name="100000",duration=-1,overlap=0,property=bit_merge(64),
                trigger = 
                {
                    [1] = { activetype=0,triggertype=1,
                        action = 
                        {
                        --                           这里设置值
                            [1] = {atype=47, type=1, value=100000},
                        },
                    },
                },
            },
        },
    },
    [1013] = { name="治疗效果",
        level = {
            [1] = { name="-20%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                        --                                               这里设置值
                            [1] = {atype=41,abilityname="treat_plus", valuetype=1, value=-834},
                        }
                    },
                },
            },
            [2] = { name="-40%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                        --                                               这里设置值
                            [1] = {atype=41,abilityname="treat_plus", valuetype=1, value=-1429},
                        }
                    },
                },
            },
            [3] = { name="-80%", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                        --                                               这里设置值
                            [1] = {atype=41,abilityname="treat_plus", valuetype=1, value=-2223},
                        }
                    },
                },
            },			
        },
    },
    [1014] = { name="无敌",
        level = {
            --                      这里设置时间
            [1] = { name="5s", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=55, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18046, rollback=true, durationtime=0, },
                        }
                    },
                },
            },
            [2] = { name="10s", duration=10000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=55, rollback=true },
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18046, rollback=true, durationtime=0, },
                        }
                    },
                },
            },									
        },
    },
    [1015] = { name="无法使用技能攻击",
        level = {
            --                      这里设置时间
            [1] = { name="5s", duration=5000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, },
                        }
                    },
                },
            },
            [2] = { name="10s", duration=10000, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, },
                        }
                    },
                },
            },
			[3] = { name="永久沉默", duration=-1, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            [1] = { atype=7, effect_type=4, rollback=true,},
                            [2] = { atype=6, srctype=2, targettype=0, callbacktype=0, effectid=18035, rollback=true, durationtime=0, },
                        }
                    },
                },
            },
        },
    },
    [1016] = { name="随机技能锁定",
        level = {
            [1] = { name="3个技能都无法使用", duration=0, overlap=0, property=bit_merge(64),
                trigger = {
                    [1] = { activetype=0, triggertype=1,
                        action = {
                            --                这里设置技能位置    这里设置随机几个
                            [1] = { atype=89, skill_list={1,2,3}, num=3,},
                        }
                    },
                },
            },
        },
    },
    ------------------------------奎库利亚end_id：[1206]----------------------
}
table.splice(g_BuffData, g_KuikuliyaBuffData)
g_KuikuliyaBuffData = nil
--[[endregion]]
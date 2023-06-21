g_SkillConditionData = {
    [1] = { --周围9.5米含有饥饿BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=4, lparam1=0, lparam2=2, lparam3=6, lparam4=9.5, rtype=1, rparam1=true },
                }
            }
        }
    },
    [2] = { --含有半赫者形态BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=15, lparam3=7, rtype=1, rparam1=true },
                }
            }
        }
    },
    [3] = { --含有子弹BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=8, lparam3=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [4] = { --不含有子弹BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=8, lparam3=4, rtype=1, rparam1=false },
                }
            }
        }
    },
    [5] = { --含有冲击层数大于等于3
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater_equal", ltype=6, lparam1=0, lparam2=18, lparam3=4, rtype=1, rparam1=3 },
                }
            }
        }
    },
    [6] = { --含有移动伤害BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=19, lparam3=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [7] = { --周围400码有友方英雄
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=7, lparam1=0, lparam2=4, lparam3=1, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [8] = { --含有高速拳BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=25, lparam3=7, rtype=1, rparam1=true },
                }
            }
        }
    },
    [9] = { --生命值比例小于25%
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less", ltype=8, lparam1=0, lparam2="cur_hp", lparam3=1, rtype=1, rparam1=0.25 },
                }
            }
        }
    },
    [10] = { --含有能量场标记BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=54, lparam3=7, rtype=1, rparam1=true },
                }
            }
        }
    },
    [11] = { --含有大能量场加速BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=29, lparam3=7, rtype=1, rparam1=true },
                }
            }
        }
    },
    [12] = { --当前是PVE模式
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=1, lparam1=true, rtype=1, rparam1=true },
                }
            }
        }
    },
    [13] = { --当前是狂化状态
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=31, lparam3=5, rtype=1, rparam1=true },
                }
            }
        }
    },
    [14] = { --前方1.5米有敌人
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=9, lparam1=0, lparam2=2, lparam3=2, lparam4=true, rtype=1, rparam1=0 },
                }
            }
        }  
    },
    [15] = { --技能可用数等于1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=6, lparam1=0, lparam2=39, lparam3=5, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [16] = { --周围4码有敌人
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=10, lparam1=0, lparam2=4, lparam3=360, lparam4=true, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [17] = { --具有陷进
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=41, lparam3=6, rtype=1, rparam1=true },
                }
            }
        }
    },
    [18] = { --只剩一个陷进
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=6, lparam1=0, lparam2=41, lparam3=6, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [19] = { --如果trigger第三方结果有目标
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=0, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [20] = { --是否为鞭形态
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=45, lparam3=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [21] = { --含有召唤物BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=20, lparam3=7, rtype=1, rparam1=true },
                }
            }
        }
    },
    [22] = { --不在战斗状态
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=12, lparam1=0, rtype=1, rparam1=false },
                }
            }
        }
    },
    [23] = { --铃木什造技能1超过4层
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=6, lparam1=0, lparam2=26, lparam3=7, rtype=1, rparam1=3 },
                }
            }
        }
    },
    [24] = { --不在半赫者冲撞状态
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=15, lparam3=5, rtype=1, rparam1=false },
                }
            }
        }
    },
    [25] = { --狂化层数为1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=31, lparam3=5, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [26] = { --是重击状态
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=31, lparam3=14, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [27] = { --增益buff层数为1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=20, lparam3=7, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [28] = { --增益buff层数为2
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=20, lparam3=7, rtype=1, rparam1=2 },
                }
            }
        }
    },
    [29] = { --增益buff层数为3
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=20, lparam3=7, rtype=1, rparam1=3 },
                }
            }
        }
    },
    [30] = { --拥有增益buff
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater_equal",  ltype=6, lparam1=0, lparam2=20, lparam3=11, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [31] = { --不拥有增益buff
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less",  ltype=6, lparam1=0, lparam2=20, lparam3=11, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [32] = { --拥有金木技能2
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal",  ltype=6, lparam1=0, lparam2=18, lparam3=2, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [33] = { --如果trigger第三方结果目标大于1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=13, lparam1=2, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [34] = { --有陷阱buff存储
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater_equal",  ltype=6, lparam1=0, lparam2=61, lparam3=6, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [35] = { --含有毒雾BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=37, lparam3=6, rtype=1, rparam1=true },
                }
            }
        }
    },
    [36] = { --如果trigger第三方结果有目标
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [37] = { --含有能量场效果
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=63, lparam3=5, rtype=1, rparam1=true },
                }
            }
        }
    },
    [38] = { --含有能量场释放数
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=63, lparam3=9, rtype=1, rparam1=true },
                }
            }
        }
    },
    [39] = { --如果trigger第三方结果大于0
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [40] = { --如果trigger第三方结果大于1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [41] = { --如果trigger第三方结果大于2
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=2 },
                }
            }
        }
    },
    [42] = { --如果trigger第三方结果大于3
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=3 },
                }
            }
        }
    },
    [43] = { --拥有受伤buff
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=46, lparam3=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [44] = { --生命值比例小于40%(多个人在用)
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less", ltype=8, lparam1=0, lparam2="cur_hp", lparam3=1, rtype=1, rparam1=0.4 },
                }
            }
        }
    },
    [45] = { --处于眩晕或者定身中
        node = { 
            [1] = { calc="or", 
                node = {
                    [1] = { calc="equal", ltype=14, lparam1=0, lparam2=1, rtype=1, rparam1=true },
                    [2] = { calc="equal", ltype=14, lparam1=0, lparam2=2, rtype=1, rparam1=true },
                }
            }
        }
    },
    [46] = { --如果trigger第三方结果2存活
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=15, lparam1=2, lparam2=2, rtype=1, rparam1=true },
                }
            }
        }
    },
    [47] = { --如果trigger第三方结果3存活
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=15, lparam1=2, lparam2=3, rtype=1, rparam1=true },
                }
            }
        }
    },
    [48] = { --如果trigger第三方结果4存活
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=15, lparam1=2, lparam2=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [49] = { --如果trigger第三方结果5存活
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=15, lparam1=2, lparam2=5, rtype=1, rparam1=true },
                }
            }
        }
    },
    [50] = { --如果存在奈白
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=16, lparam1=0, lparam2=30012200, rtype=1, rparam1=true },
                }
            }
        }
    },
    [51] = { --周围9.5米含有饥饿BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=4, lparam1=0, lparam2=81, lparam3=6, lparam4=9.5, rtype=1, rparam1=true },
                }
            }
        }
    },
    [52] = { --职业为技
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=17, lparam1=0, rtype=1, rparam1=3 },
                }
            }
        }
    },
    [53] = { --是否为自己控制
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=18, lparam1=0, rtype=1, rparam1=true },
                }
            }
        }
    },
    [54] = { --如果trigger第三方结果无目标
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=11, lparam1=0, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [55] = { --如果trigger第三方结果和施法者之间大于视野距离
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=19, lparam1=2, rtype=1, rparam1=PublicStruct.Const.ATTACK_VIEW_RADIUS },
                }
            }
        }
    },
    [56] = { --如果trigger第三方结果和施法者之间小于等于视野距离
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less_equal", ltype=19, lparam1=2, rtype=1, rparam1=PublicStruct.Const.ATTACK_VIEW_RADIUS },
                }
            }
        }
    },
    [57] = { --如果trigger,buff,buff_manager的第三方结果数量都为0
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=11, lparam1=2, rtype=1, rparam1=0 },
                    [2] = { calc="equal", ltype=20, lparam1=0, rtype=1, rparam1=0 },
                    [3] = { calc="equal", ltype=21, lparam1=2, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [58] = { --无敌buff计数为0
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=661, lparam3=3, rtype=1, rparam1=false },
                }
            }
        }
    },
    [59] = { --召唤小兵小于等于12个
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less_equal", ltype=22, lparam1=0, rtype=1, rparam1=12 },
                }
            }
        }
    },
    [60] = { --BOSS含有半赫者形态BUFF
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=651, lparam3=6, rtype=1, rparam1=true },
                }
            }
        }
    },
    [61] = { --如果trigger第三方结果目标大于5
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=11, lparam1=2, rtype=1, rparam1=5 },
                }
            }
        }
    },
    [62] = { --生命值比例小于100%
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less", ltype=8, lparam1=0, lparam2="cur_hp", lparam3=1, rtype=1, rparam1=1 },
                }
            }
        }
    },
    [63] = { --处于眩晕中
        node = { 
            [1] = { calc="or", 
                node = {
                    [1] = { calc="equal", ltype=14, lparam1=0, lparam2=2, rtype=1, rparam1=true },
                }
            }
        }
    },
    [64] = { --前方5m有目标
        node = { 
            [1] = { calc="or", 
                node = {
                    [1] = { calc="greater", ltype=9, lparam1=0, lparam2=2, lparam3=5, lparam4=true, rtype=1, rparam1=0, },
                }
            }
        }
    },
    [65] = { --前方5m无目标
        node = { 
            [1] = { calc="or", 
                node = {
                    [1] = { calc="less", ltype=9, lparam1=0, lparam2=2, lparam3=5, lparam4=true, rtype=1, rparam1=1},
                }
            }
        }
    },
    [66] = { -- 是否是攻属性角色
        node = {
            [1] = { calc="and",
                node = {
                    [1] = { calc="equal", ltype=8, lparam1=0, lparam2="pro_type", lparam3=0, rtype=1, rparam1=2, },
                },
            },
        },
    },
    [67] = { -- 目标数大于等于1
        node = {
            [1] = { calc="and",
                node = {
                    [1] = { calc="greater_equal", ltype=11, lparam1=2, rtype=1, rparam1=1, },
                },
            },
        },
    },
    [68] = {-- 目标数大于等于2
        node = {
            [1] = { calc="and",
                node = {
                    [1] = { calc="greater_equal", ltype=11, lparam1=2, rtype=1, rparam1=2, },
                },
            },
        },
    },
    [69] = {-- 目标数大于等于3
        node = {
            [1] = { calc="and",
                node = {
                    [1] = { calc="greater_equal", ltype=11, lparam1=2, rtype=1, rparam1=3, },
                },
            },
        },
    },
    [70] = { --如果trigger第三方结果目标大于5
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="greater", ltype=23, lparam1=0, rtype=1, rparam1=0 },
                }
            }
        }
    },
    [71] = { --有爆伤buff
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=62, lparam3=4, rtype=1, rparam1=true },
                }
            }
        }
    },
    [72] = { --队友死亡数量=1
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=24, lparam1=0, rtype=1, rparam1=1,},
                }
            }
        }
    },
    [73] = { --队友死亡数量=2
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=24, lparam1=0, rtype=1, rparam1=2,},
                }
            }
        }
    },
    [74] = { --记录值/属性值 > 0.5
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less", ltype=25, lparam1=0, lparam2="yjj_skill3", lparam3="def_power", rtype=1, rparam1=0.5,},
                }
            }
        }
    },
    [75] = { --记录值/属性值 > 0.7
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="less", ltype=25, lparam1=0, lparam2="yjj_skill3", lparam3="def_power", rtype=1, rparam1=0.7,},
                }
            }
        }
    },
    [76] = { --在技能者背后
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=26, lparam1=0, rtype=1, rparam1=false,},
                }
            }
        }
    },
    [77] = { --有技能标记
        node = { 
            [1] = { calc="and", 
                node = {
                    [1] = { calc="equal", ltype=2, lparam1=0, lparam2=26, lparam3=10, rtype=1, rparam1=true},
                }
            }
        }
    },
}

--type
--1. 取值 param1=值
--2. 检查玩家是否存在BUFF  param1=目标(0源头 1目标)  lparam2=buffid  lparam3=bufflevel
--3. 获取玩家隐身状态  param1=目标(0源头 1目标)
--4. 周围玩家是否存在BUFF  param1=目标(0源头 1目标)  lparam2=buffid  lparam3=bufflevel lparam4=距离
--5. 前方是否存在敌人 param1=目标(0源头 1目标) lparam2=angle lparam3=radius
--6. 获取玩家BUFF层数 param1=目标(0源头 1目标)  lparam2=buffid  lparam3=bufflevel
--7. 检测周围友方数量 param1=目标(0源头 1目标) lparam2=radius lparam3=objtype
--8. 检测玩家属性值 param1=目标(0源头 1目标) lparam2=属性类型 lparam3=值类型(0绝对值,1比例值)
--9. 检测玩家前方单位数量 param1=目标(0源头 1目标) lparam2=witdh lparam3=length lparam4=enemy
--10. 检测玩家周围单位数量 param1=目标(0源头 1目标) lparam2=radius lparam3=angle lparam4=enemy
--11. 检测第三方目标结果数量 param1=目标(0源头 1目标 2第三方)
--12. 检测玩家是否在战斗状态 param1=目标(0源头 1目标 2第三方)
--13. 检测_arrCallBackTarget结果数量 param1=目标(0源头 1目标 2第三方)
--14. 检测是否特殊状态 param1=目标(0源头 1目标 2第三方) lparam2=状态类型
--15. 检测_arrThirdTarget具体下标单位是否存活 param1=目标(0源头 1目标 2第三方) lparam2=下标
--16. 检测对应玩家阵容中是否存在某个英雄 param1=目标(0源头 1目标 2第三方) lparam2=英雄编号
--17. 检测职业 param1=目标(0源头 1目标 2第三方)
--18. 检查英雄是否玩家控制 param1=目标(0源头 1目标 2第三方)
--19. 检测_arrThirdTarget第一个结果和srcobj的距离 param1=目标(0源头 1目标 2第三方)
--20 检测obj.buff_manager._arrThirdTarget结果数量 param1=目标(0源头 1目标 2第三方)
--21 检测obj._buff._arrThirdTarget结果数量 param1=目标(0源头 1目标 2第三方)
--22 检测obj召唤怪物数量 param1=目标(0源头 1目标 2第三方)
--23 检测obj存储的伤害值 param1=目标(0源头 1目标 2第三方)
--24 检测英雄死亡数量 param1=目标(0源头 1目标）
--25 检测记录的数据与属性比 param1=目标(0源头 1目标）param2=记录名字 param3=属性类型
--26 检测是否在技能创建者前面 param1=目标(0源头 1目标）

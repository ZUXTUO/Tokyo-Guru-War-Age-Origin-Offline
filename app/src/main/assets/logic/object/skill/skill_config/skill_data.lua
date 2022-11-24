--[[damage参数信息
    calcutype:0=物理 1=能量
    physcale=物理伤害缩放
    energyscale=能量伤害缩放
    fixeddamage=固定伤害 
    damagestep:0=技能 1=普攻1段 2=普攻2段 3=普攻3段
    scalebyhp:1=伤害受当前血量影响
    skillrefscale:1=技能计数衰减
    scalebytime:1=时间影响伤害
    scalebybuff:1=buff影响伤害   buffid,bufflv,buffscale
    ]]
g_SkillData = {}
script.run("logic/object/skill/skill_config/player_skill_data.lua");
script.run("logic/object/skill/skill_config/player_normal_skill_data.lua");
script.run("logic/object/skill/skill_config/player_passive_skill_data.lua");
script.run("logic/object/skill/skill_config/monster_skill_data.lua");
script.run("logic/object/skill/skill_config/monster_normal_skill_data.lua");
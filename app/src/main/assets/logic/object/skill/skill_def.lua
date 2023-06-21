--[[
region skill_def.lua
date: 2015-8-3
time: 11:54:17
author: Nation
技能相关的枚举,全局变量
]]

MAX_SKILL_CNT = 15
eSkillNeedTargetType = {
    NotNeed         = PublicFunc.EnumCreator(0),
    NeedTarget      = PublicFunc.EnumCreator(),
    NeedGround      = PublicFunc.EnumCreator(),
    NeedTargetEx    = PublicFunc.EnumCreator(),--如果目标不满足也可以使用技能
}

eSkillType = {
    Normal                  = 0,--普攻
    DirectionSkill          = 1,--指向型技能
    DoubleCircleSkill       = 2,--双圆类技能
    MustTargetSkill         = 3,--必须目标技能
    ImmediatelyNoStateSkill = 4,--立即释放不改变状态的技能
    NormalSkill             = 5,--普通技能
    TripleCircleSkill       = 6,--三圆类技能
    PassiveSkill            = 7,--被动技能
    ImmediatelyStateSkill   = 8,--立即释放改变状态的技能
}

eSkillDisenableType = {
    Normal                  = 1,--普攻
    AllSkill                = 2,--所有技能
    SingleSkill             = 4,--单体技能
}

eUseSkillRst = {
    OK           = PublicFunc.EnumCreator(0),
	Illegal1     = PublicFunc.EnumCreator(),
    Illegal2     = PublicFunc.EnumCreator(),
    Illegal3     = PublicFunc.EnumCreator(),
    CD           = PublicFunc.EnumCreator(),
    NeedTarget   = PublicFunc.EnumCreator(),
    TargetDeaded = PublicFunc.EnumCreator(),
    Ignore       = PublicFunc.EnumCreator(),
    ProhibitSkill= PublicFunc.EnumCreator(),
    IsWorking    = PublicFunc.EnumCreator(),
    Expression   = PublicFunc.EnumCreator(),
    Deaded       = PublicFunc.EnumCreator(),
    Disenable    = PublicFunc.EnumCreator(),
}

eSkillTargetType = {
    Self = PublicFunc.EnumCreator(0),
    Target = PublicFunc.EnumCreator(),
}

eSkillConditionRst = {
    OK  = PublicFunc.EnumCreator(0),
}

ESkillCDType = {
    Immediately = PublicFunc.EnumCreator(0),
    WaitBuff    = PublicFunc.EnumCreator(),
    Forever     = PublicFunc.EnumCreator(),
}
lay_all_role = {PublicStruct.UnityLayer.player, PublicStruct.UnityLayer.monster}
lay_all_hero = {PublicStruct.UnityLayer.player}
lay_all_monster = {PublicStruct.UnityLayer.monster}
immune_all_countrol_state = bit_merge(1,2,4,8,16,32,64,512)
--[[endregion]]
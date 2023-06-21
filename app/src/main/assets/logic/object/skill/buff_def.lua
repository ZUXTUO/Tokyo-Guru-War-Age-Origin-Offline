--[[
region buff_def.lua
date: 2015-8-3
time: 11:55:3
author: Nation
BUFF相关的枚举和全局变量
]]
eBuffOverlapType = {
	Overlap				= 1, --同编号情况下增加重叠数
	SameAllMutex		= 2, --同编号等级覆盖
    SameAllDetach       = 3, --同编号等级移除不新增
    SameAllIgnore       = 4, --同编号等级忽略
    SameAllResetTime    = 5, --同编号等级重置时间
    SameIDMutex		    = 6, --同编号覆盖
    SameIDDetach        = 7, --同编号移除不新增
    SameIDIgnore        = 8, --同编号忽略
    SameIDResetTime     = 9, --同编号重置时间
}

eBuffGroupOverlapType = {
	SameIDMutex			= 1, --同编号超上限覆盖
    SameIDIgnore        = 2, --同编号忽略
}

eBuffGroupOverlapType = {
	SameIDMutex			= 1, --同编号超上限覆盖
    SameIDIgnore        = 2, --同编号忽略
}

eBuffPropertyType = {
    DeBuff                  = 1,    --减益BUFF
    RemoveOnMove            = 2,    --移动移除
    RemoveOnUseSkill        = 4,    --使用技能后移除
    RemoveOnHitted          = 8,    --被击后移除
    RemoveOnSilence         = 16,   --沉默后移除
    RemoveOnVertigo         = 32,   --眩晕后移除
    RemoveOnDead            = 64,   --死亡后移除
    RemovePrepareOnMove     = 128,  --准备阶段移动移除
    RemovePrepareOnSilence  = 256,  --准备阶段沉默后移除
    RemovePrepareOnVertigo  = 512,  --准备阶段眩晕后移除
}

eBuffState = {
    Attached   = PublicFunc.EnumCreator(0),
    Run        = PublicFunc.EnumCreator(),
    Detach     = PublicFunc.EnumCreator(),
    Detached   = PublicFunc.EnumCreator(),
}

eBuffActionState = {
    Begin   = PublicFunc.EnumCreator(0),
    Run     = PublicFunc.EnumCreator(),
    Over    = PublicFunc.EnumCreator(),
}

eBuffTriggerActiveType = {
	Attach		= PublicFunc.EnumCreator(0), --Buff被赋加时
	Detach		= PublicFunc.EnumCreator(), --Buff被移除时
	Interval	= PublicFunc.EnumCreator(), --每间隔一定时间 interval=间隔毫秒 immediately=是否立即执行
	Delay		= PublicFunc.EnumCreator(), --时间延迟 delay=延迟毫秒
}

eBuffActionTriggerType = {
	Sequence   = PublicFunc.EnumCreator(0),
    All        = PublicFunc.EnumCreator(),
}

ESpecialEffectType = {
    DingShen = 1,
    XuanYun = 2,
    KongJu = 3,
    ChenMo = 4,
    ZhiMang = 5,
    HunLuan = 6,
}

EImmuneStateType = {
    DingShen = 1,
    XuanYun = 2,
    KongJu = 4,
    ChaoFeng = 8,
    ChenMo = 16,
    ZhiMang = 32,
    BeAttackEffect = 64, --免疫被击效果
    MoveSpeed = 128,  --免疫减速
    HunLuan = 256,
    PassivityMove = 512,
}


eBuffAction = {
    --【同步已处理】
    RunAnimation                = PublicFunc.EnumCreator(1), --【播放动作】
        --srctype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者 4=trigger第三方结果 5=triggerCallBack结果
        --targettype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者 4=当前目标 5=trigger第三方目标
        --callbacktype 0=忽略 1=动作关键帧  2=特效碰撞回调(目标存入triggercallback)  3=特效碰撞回调(目标存入triggerthird) 
        --ignoretarget bool是否忽略target
        --animid 动作id
        --limit 超时时间(毫秒)
        --lock  锁定技能
        --ignoreref 无视计数
    --【同步已处理】
    UseThirdTarget              = PublicFunc.EnumCreator(2), --【使用第三方目标】
        --usetype    默认=技能使用者自己计算并同步,非使用者等待取值 0=使用目标配置(单机和帧同步模式下自己计算,状态同步模式下等待取值) 1=完全本地计算
        --typeindex  目标配置id
        --srctype    0=buff释放者 1=buff接受者 2=技能释放者 3=场景 4=triggercallback对象 5=默认目标 6=trigger第三方结果
        --targettype 0=清空 1=附近目标 2=瞄准点附近目标 3=默认目标 4=前方矩形范围目标
        --           5=附近计数最小的目标 6=所有英雄
        --radius     范围   
        --radiusfactor
        --angle      角度
        --targetcnt  目标数量
        --length     矩形长
        --width      矩形宽
        --lengthtype nil=照旧  1=优先判断当前目标
        --direct     nil=srctype朝向 0=buffCallBack朝向 1=当前朝向偏移 2=buff记录朝向
        --directoffset direct=1时使用 角度
        --position    0=buffCallBack位置 1=buff_manager记录位置 2=buff记录位置 3=释放者位置朝向前移 4=trigger记录的位置 5=buff记录的多位置 6=buffmanager记录的多位置
        --position_offset postion=3,5,6时使用
        --includeself 是否包含自己
        --buffid
        --bufflv
        --enemy      是否敌方(默认true)
        --sorttype   nil=不排序 0=距离最近优先 1=英雄优先距离优先 2=制造伤害量优先 3=选择目标的那个逻辑 4=血量低优先  5=距离最远有限 6=血量高有限
        --layer      查找的层
        --arraytype  nil=trigger 0=buff 1=defaultTarget 2=buffmanager
    --【同步已处理】
	ChangeAbilityScaleMultiply  = PublicFunc.EnumCreator(3), --【改变属性缩放_乘法】
        --abilityname 属性名
        --scale 改变数据
        --record true=记录
        --recordname
        --rollback_sender nil=挂接者发送 0=技能释放者发送
    --【同步已处理】
	MakeDamage	                = PublicFunc.EnumCreator(4), --【造成伤害】
        --type  0=普通计算 1=总血量的百分比  2=当前血量的百分比 3=根据目标的攻击强度来计算 4=根据技能释放者的总血量百分比 5=根据记录的伤害造成百分比伤害
        --persent 百分比
        --infoindex 伤害公式
    --【同步已处理】
    AttachBuff                  = PublicFunc.EnumCreator(5), --【挂接BUFF】
        --buffid
        --bufflv
        --maxnes 最大次数
        --targettype 0=buff接受者 1=trigger第三方结果 2=triggerCallBack结果 3=entity存的结果  4=buff第三方结果 5=技能释放者 6=buff_manager第三方结果 7=默认目标
        --overlap 重叠数 默认nil
        --targetindex 目标索引 nil=全部 0=随机
        --sendserver 是否发送给服务器
    --【同步已处理】
    RunEffect                   = PublicFunc.EnumCreator(6), --【播放特效】
        --srctype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者 4=triggerCallBack结果 5=trigger第三方结果 6=场景 7=buff第三方结果最后一个 8=默认目标 9=buff第三方结果
        --targettype 0=忽略 1=buff释放者 2=buff接受者 3=技能释放者  4=当前目标  5=默认目标 
        --           6=trigger第三方结果 7=buff第三方结果 8=buffmanager第三方结果
        --targetindex 目标索引 nil=全部 0=随机
        --callbacktype 0=忽略 1特效碰撞回调
        --effectid 动作id
        --limit 超时时间(毫秒)
        --musttarget 必须要目标
        --direct     nil=当前朝向 0=buffCallBack朝向 1=当前朝向偏移 2=使用buff_manager中存的朝向 3=使用buff中存的朝向
        --directoffset direct=1时使用 角度
        --position  0=光圈位置 1=buff接受者附近随机 2=buffCallBack位置 3=buff接受者位置 4=通过记录的位置和朝向计算(speed,passtime) 5=buff记录的位置 6=通过记录的位置和朝向计算(length) 7=buff接受者前方 8=trigger记录的位置
        --          9=记录在buffmanager的多位置 10=记录在buffmanager的位置
        --posindex  position=9时
        --len       position 为7时的偏移
        --durationtime nil=默认时间  0=循环
        --durationwithspeed true=durationtime通过特效时间，技能距离判断
        --speed     position=4时的速度
        --passtime  position=4时的耗时
        --refskill  增加技能计数
        --以下参数为碰撞特效专用
        --abuffid   碰撞后挂接的buff
        --abufflv   碰撞后挂接的buff
        --cbuff     碰撞需要检测的buff
        --checkret  检测结果bool
        --handlehit 处理击中默认为true
        --以下为弹道特效专用
        --targetpos 1=buff记录的位置
        --usetime 飞行时间
    --【同步已处理】
    SpecialEffect               = PublicFunc.EnumCreator(7), --【特殊效果】
        --effect_type 参数见ESpecialEffectType
    --【同步处理余留】
    ImmuneEnemySkill            = PublicFunc.EnumCreator(8), --【免疫敌方技能】
    --【同步处理余留】
    DamageScaleFromSkillCreator = PublicFunc.EnumCreator(9), --【受到技能释放者攻击时伤害缩放】
        --scale 改变数据
    --【同步已处理】
    Hide                        = PublicFunc.EnumCreator(10),--【隐身】
    --【同步已处理】
    DetachBuff                  = PublicFunc.EnumCreator(11),--【移除BUFF】
        --buffid
        --bufflv
        --targettype 0=buff接受者 1=trigger第三方结果 2=triggerCallBack结果 3=宿主 4=技能施放者
        --immediately 立刻删除 默认为true
    --【同步已处理】
    ShowAperture               = PublicFunc.EnumCreator(12),--【显示光圈】
        --onlycaptain 只有队长才显示
        --type  0单圆 1双圆 2指向 3伞形 4双圆单圆可以移动 5三圆 6董香专用 7-11单圆不绑定 12-15指向
        --distance
        --extradistance
        --width
        --postype 1=记录到buff的 2=buffCallBack位置 3=记录到trigger的 4=记录到BUFF的多位置 5=记录到buffmanager的 6=记录到buffmanager的多位置
        --posindex postype=4时代表下标
        --hideprepared 是否在动作准备阶段过后隐藏
        --limit 超时时间(毫秒)
        --angle 旋转角度（指向用）
    --【同步已处理】
    AttachDelayBuffWithDistance = PublicFunc.EnumCreator(13),--【根据距离挂接延迟BUFF】
        --buffid
        --bufflv
        --targettype 0=trigger第三方结果 1=triggerCallBack结果 2=buff第三方结果
        --srctype 0=buff接受者 1=buffCallBack位置
        --speed 速度
        --maxtargets nil=全部
        --fixtime 固定延迟
    --【同步处理余留】
    MovePosition                = PublicFunc.EnumCreator(14),--【移动位置】
        --targettype 0=忽略   1=当前目标 2=trigger第三方结果 3=技能释放者 4=entity存的结果 5=triggerCallBack结果 6=默认目标
        --callbacktype 0=需要回调 1=碰撞回调 2=碰撞加buff不回调
        --usetime 时间
        --direct    1=当前朝向  2=buffCallBack朝向 3=buffCallBack相反朝向 4=与技能释放者算朝向 5=通过记录的方向取反 6=技能释放者记录朝向 7=从目标朝向自己
        --distance 距离
        --offset 反方向偏移距离
        --offsettype 0=运动方向 1=目标背后
        --autoforward 自动调整朝向
        --position 0:记录的移动前的位置 1:buff_manager存的pos 2:buffCallback的pos 3:光圈位置 4:技能释放者buffmanager记录的位置 5:buff存的pos 6:buff存的多位置
        --finaltorward 最终朝向目标
        --speed 速度,优先级高于usetime
        --updatesever 更新位置到服务器,默认为true
        --limit 回调超时
        --碰撞后添加buff
        --abuffid
        --abufflv
    --【同步已处理】
    UnlockSkill                 = PublicFunc.EnumCreator(15),--【解除技能锁定】
        --lock  默认为0
    --【同步已处理】
    ChangeLockAttackTarget      = PublicFunc.EnumCreator(16),--【改变锁定目标】
        --targettype 0=trigger第三方结果 1=默认目标
    --【同步已处理】
    SequenceRunEffect           = PublicFunc.EnumCreator(17),--【按顺序播放特效并添加BUFF】
        --targettype 0=trigger第三方结果 1=buff第三方结果
        --srctype 0=场景
        --effectid
        --buffid
        --bufflv
        --radius
        --limit 超时时间(毫秒)
        --handlehit 处理击中默认为true
        --mintimes 最小次数
    FixedCamera                 = PublicFunc.EnumCreator(18),--【固定摄像机】
        --fixed 是否固定
    --【同步已处理】
    RenderEnable                = PublicFunc.EnumCreator(19),--【设置是否渲染】
        --enable 是否渲染
        --enable_hp 是否渲染血条
    --【同步已处理】
    TimeDelay                   = PublicFunc.EnumCreator(20),--【延迟】
        --delay 延迟(毫秒)
    --【同步已处理】
    StartSkillCD                = PublicFunc.EnumCreator(21),--【开始技能CD】
        --skillid  nil=本技能 -1=所有技能
    --【同步已处理】
    ImmuneState                 = PublicFunc.EnumCreator(22),--【免疫状态】
        --type 参数见EImmuneStateType
    --【同步处理余留】
    Repel                       = PublicFunc.EnumCreator(23),--【击退】
        --targettype 0=trigger第三方结果 1=buff挂接者 2=triggerCallBack结果
        --distance 距离
        --dirtype 1=buff_manager记录的朝向垂直 2=buff_manager记录的朝向
        --callbacktype nil=忽略
        --limit 时间
    --【同步处理余留】
    RecordDamage                = PublicFunc.EnumCreator(24),--【记录伤害】
        -- type   nil=存在buffOwner中  1=存在skillCreator中
    --【同步已处理】
    RecoverHP                   = PublicFunc.EnumCreator(25),--【恢复生命】
        --type  0=根据伤害总量 1=恢复绝对值 2=根据最大血量 3=根据损失血量 4=根据伤害公式计算 5=根据记录的回复量 6=先根据伤害公式计算，再根据血量损失比例增加
        --value 值
        --add_scale 提升值
    --【同步处理余留】
    ChangeAbsoluteMDamage       = PublicFunc.EnumCreator(26),--【制造额外伤害绝对值】
        --value 值
    --【同步已处理】
    BeAttackAnimation           = PublicFunc.EnumCreator(27),--【被击】
        --targettype 0=trigger第三方结果 1=buff接受者 2=triggerCallBack结果 3=buff第三方结果
        --distance 距离
        --distype 0=取distance 1=根据距离相乘 2=主控取配置
        --dirtype nil=忽略  0=反向光圈位置 1=自身buff_manager中存的朝向 2=技能释放者buff_manager中存的朝向 3=技能释放者buff_manager中存的朝向垂直 4=技能释放者buff_manager中存的反朝向 5=技能释放者buff_manager中存储位置朝向当前对象
        --callbacktype nil=忽略 1=普通回调
        --limit 超时时间
        --height 击飞高度
        --type (1左手2右手3前方5击飞6滞空击飞)
    --【同步已处理】
    RemoveRationEffect          = PublicFunc.EnumCreator(28),--【清除光环UI效果】
    ResetAttachTime             = PublicFunc.EnumCreator(29),--【重置BUFF时间】
    ChangeScaleMDamage          = PublicFunc.EnumCreator(30),--【制造额外伤害缩放值】
        --scale 值
        --odds  几率
    ChangeScaleRDamage          = PublicFunc.EnumCreator(31),--【受到额外伤害缩放值】
        --scale 值
        --odds  几率
    --【同步已处理】
    RecordTowardsAndPosition    = PublicFunc.EnumCreator(32),--【记录朝向和位置】
        --type 0=记录到buff 1=记录到buffmanager 2=记录到trigger
        --srctype nil=相对于自己位置 1=相对于目标位置 2=技能释放者的位置 3=瞄准点 4=buffCallback位置
        --targettype 1=trigger第三方结果 2=默认目标 3=buffmanager第三方结果 4=圆形范围随机 5=朝向位置
        --targetindex目标索引 nil=全部 0=随机
        --radius 半径targettype为4时
        --randomindex 随机偏移索引
        --offset 朝向偏移
        --aoffset 角度偏移
        --dirtype nil:当前朝向 0:当前朝向反方向
    --【同步已处理】
    ScaleModel                  = PublicFunc.EnumCreator(33),--【缩放模型】
        --scale 值
        --type  nil=直接设置，1=附加值
    AttachBuffWhenUseSkill      = PublicFunc.EnumCreator(34),--【使用技能时添加BUFF】
        --buffid
        --bufflv
    ChangeScaleNormalMDamage    = PublicFunc.EnumCreator(35),--【普通攻击制造额外伤害缩放值】
        --objtype 对象类型
        --scale 值
        --times 次数
    ChangeAbsoluteNormalMDamage = PublicFunc.EnumCreator(36),--【普通攻击制造额外伤害缩放值】
    DisposableAbsoluteRDamage   = PublicFunc.EnumCreator(37),--【一次性受到额外伤害绝对值】
        --value 值
        --type  0=当前生命值的比例 1=用公式(value为第几个公式) 2=直接使用
    DisposableScaleRDamage      = PublicFunc.EnumCreator(38),--【一次性受到额外伤害缩放值】
        --scale 值
    AttachBuffWhenGainDamage    = PublicFunc.EnumCreator(39),--【受到伤害时添加BUFF】
        --buffid
        --bufflv
    --【同步已处理】
    ChangeAppearance            = PublicFunc.EnumCreator(40),--【变身】
        --modelid 模型ID
    ChangeAbilityAbsolute       = PublicFunc.EnumCreator(41),--【改变属性绝对值】
        --abilityname 属性名
        --value 改变数据
        --valuetype 1=绝对值 2=技能释放者的记录项 3=先根据绝对值再根据血量损失比例增加
        --add_scale (valuetype=1)提升值 (valuetype=2)添加上限
    DamageTransfer              = PublicFunc.EnumCreator(42),--【伤害转移】
        --persent 转移比例
    RecoverHPFeedback           = PublicFunc.EnumCreator(43),--【恢复生命反馈】
        --scale 比例
    DamageRebound               = PublicFunc.EnumCreator(44),--【伤害反弹】
        --scale 比例
        --type nil=伤害反弹部分+属性 1=伤害反弹部分+公式
        --calcuabilityname  计算的属性
        --calcscale 计算的缩放
        --infoindex 伤害公式
    --Taunt                       = PublicFunc.EnumCreator(45),--【待用】
    RecordTime                  = PublicFunc.EnumCreator(46),--【记录时间】
    DamageAbsorb                = PublicFunc.EnumCreator(47),--【伤害吸收】
        --type 0=通过公式计算 1=绝对值
        --value 值
        --吸收结束后添加buff
        --buffid
        --bufflv 
    UnlockAnimation             = PublicFunc.EnumCreator(48),--【动画解锁】
    DisposableImmuneSkillDamage = PublicFunc.EnumCreator(49),--【一次性免疫技能伤害】
        --effectid 特效id，不配就不播特效
    -- SuckBlood                   = PublicFunc.EnumCreator(50),--【吸血】
        --value 百分比
    --【同步处理余留】
    CreateSummoneUnit           = PublicFunc.EnumCreator(51),--【创建召唤物】
        --obj_id 英雄id
        --position  0=光圈位置
        --maxcnt 最大数量
        --effectid 创建特效
    --【同步已处理】
    ReplaceAnimID               = PublicFunc.EnumCreator(52),--【改变攻击动作】
        --old_id 旧ID EANI
        --new_id 新AnimID skill_effect
    --【同步已处理】
    VertigoAnimID               = PublicFunc.EnumCreator(53),--【眩晕动作】
    --【同步已处理】
    ShakeCamera                 = PublicFunc.EnumCreator(54),--【震屏】
        -- count                默认2
        -- x                    默认1
        -- y                    默认3
        -- z                    默认2
        -- dis                  默认0.1
        -- speed                默认60
        -- decay                默认0.5
        -- multiply             默认0
    Invincible                  = PublicFunc.EnumCreator(55),--【无敌】
        -- except_type 排除的目标 nil=不排除 0=当前目标
        -- probability 发动概率(0~1) nil=1 
    --ScaleMDamage2RestraintType  = PublicFunc.EnumCreator(56),--【缩放对某种属性的目标的伤害】
        --restraint 属性
        --value 改变数据
    ScaleMDamage2SomeStars      = PublicFunc.EnumCreator(57),--【缩放对某种星级范围的目标的伤害】
        --stars 星数
        --type 0=小于 1大于
        --value 改变数据
    --ScaleRDamageByAttackType    = PublicFunc.EnumCreator(58),--【缩放收到某种攻击的伤害】
        --type 0=物理1=能量
        --value 改变数据
    DetachAllDebuff             = PublicFunc.EnumCreator(59),--【移除所有的负面BUFF】
    PlaySkillSound              = PublicFunc.EnumCreator(60),--【播放技能音效】
        --targettype nil=buff接受者 1=技能释放者 2=trigger第三方结果 3=buff第三方结果 
        --targetindex 目标索引 nil=全部 0=随机
        --id 音效id
        --follow true绑定 false不绑定
        --unique true=唯一
        --autostop true=自动停止 false=不自动
        --callbacktype nil=无回调 0=回调
    DisposableRDamageCrit       = PublicFunc.EnumCreator(61),--【一次性收到伤害必暴击】
    --【同步已处理】
    ChangeAbilityScaleAddition  = PublicFunc.EnumCreator(62),--【改变属性缩放_加法】
        --abilityname 属性名
        --scale 改变数据
        --record true=记录
        --recordname
        --rollback_sender nil=挂接者发送 0=技能释放者发送
    RecoverHPScale              = PublicFunc.EnumCreator(63),--【恢复生命缩放】
        --scale 改变数据
    DisposableNormalDamageScale = PublicFunc.EnumCreator(64),--【一次性普攻伤害缩放】
        --scale 缩放
    SpecifiedRDamage            = PublicFunc.EnumCreator(65),--【指定受到伤害】
        --value
    KillTargetAddBuff           = PublicFunc.EnumCreator(66),--【杀死目标后增加BUFF】
        --bossadd
        --notbossadd
        --heroadd
        --buffid
        --bufflv
        --skillid
    ClearSkillCD                = PublicFunc.EnumCreator(67),--【清除技能CD】
        --skillid
        --cdvalue nil:直接清除  其余清除指定值
        --cdtype 0:比例 1:绝对值
    LearnSkill                  = PublicFunc.EnumCreator(68),--【学习技能】
        --skill_id      新的技能id
        --skill_index   技能位置
        --ui_index      技能ui位置
        --save_cd       是否保存CD
    ClearAtteckerRecord         = PublicFunc.EnumCreator(69),--【清空攻击者标记】
    CanSearch                   = PublicFunc.EnumCreator(70),--【设置是否可被搜索】
        --search 是否可被搜索
    HPEnable                    = PublicFunc.EnumCreator(71),--【设置是否显示血条】
        --enable 是否显示血条
    AddNormalDamageFromSkillCreator = PublicFunc.EnumCreator(72),--【受到技能释放者普攻时伤害增加】
        --infoindex 公式
    EnableMoveWhenSkill         = PublicFunc.EnumCreator(73),--【技能使用过程中可以移动】
    ReboundNormalDamage         = PublicFunc.EnumCreator(74),--【反弹普通攻击】
        --scale 反弹比例
    Taunt                       = PublicFunc.EnumCreator(75),--【嘲讽】
    DisposableAbsoluteMDamage   = PublicFunc.EnumCreator(76),--【一次性制造额外伤害绝对值】
        --value 值
        --type  0=用公式(value为第几个公式)
    Immortal                    = PublicFunc.EnumCreator(77),--【不死】
    Kidnap                      = PublicFunc.EnumCreator(78),--【绑架】
        -- type 0=目标隐藏 1=目标显示跟随
    ChangeAbsoluteMNormalDamage = PublicFunc.EnumCreator(79),--【制造额外普攻伤害绝对值】
        --infoindex 公式
    RecordRecover               = PublicFunc.EnumCreator(80),--【记录治疗量】
        -- type   nil=存在buffOwner中
    UnlockAnim                  = PublicFunc.EnumCreator(81),--【解除动作锁定】
    ChangeScaleProMDamage       = PublicFunc.EnumCreator(82),--【对特定职业制造额外伤害缩放值】
        --protype  职业
        --scale 缩放
    DisposableAbsoluteMNormalDamage = PublicFunc.EnumCreator(83),--【一次性制造额外普攻伤害绝对值】
        --value 值
        --type  0=用公式(value为第几个公式)
    UpdatePos2Server            = PublicFunc.EnumCreator(84),--【同步位置给服务器】
    ShowArtisticText            = PublicFunc.EnumCreator(85),--【飘美术字】
        --type ENUM.EHeadInfoShowType
        --targettype 0=buff接受者 1=trigger第三方结果 2=triggerCallBack结果
    DisposableScaleMDamage      = PublicFunc.EnumCreator(86),--【一次性制造额外伤害缩放值】
        --scale 值
    ScaleMDamageByTargetHP      = PublicFunc.EnumCreator(87),--【目标血量小于值后伤害增加】
        --hppersent 血量百分比
        --damagescale 伤害增加值
    TowardsTarget               = PublicFunc.EnumCreator(88),--【转向目标】
        --targettype 1=默认目标
    RandomSetSkillLock            = PublicFunc.EnumCreator(89),--【随机设置几个技能cd】
        --skill_list ={}随机列表
        --cd 设置cd时间
        --num 随机个数
    CreateMonster               = PublicFunc.EnumCreator(90),--【创建怪物】
        --monsterid 怪物ID
        --postype 0:buff记录位置
        --deadcreatorbuff {0,0}死亡后给主人添加的BUFF
        --groupname 分组名字
    ImmuneFrontDamage           = PublicFunc.EnumCreator(91),--【正面伤害免疫】
    PlayVideo                   = PublicFunc.EnumCreator(92),--【播放视频】
        --path 播放路径
        --callback 
    AttachDelayBuff             = PublicFunc.EnumCreator(93),--【挂接延迟BUFF】
        --buffid
        --bufflv
        --targettype 0=trigger第三方结果 1=triggerCallBack结果 2=buff第三方结果
        --delayincrease 延迟递增
        --recorddelay   是否记录延迟
        --maxdelay 最大延迟
    ServerSearchAndCalcuDamage  = PublicFunc.EnumCreator(94),--【服务器搜怪并计算伤害】
        --targetype   0:圆 1:矩形
        --length 长度
        --width 宽度
        --radius 半径
        --searchtype  1:自身位置   2=buff记录位置
        --type  0=普通计算 1=总血量的百分比  2=当前血量的百分比 3=根据目标的攻击强度来计算 4=根据技能释放者的总血量百分比 5=根据记录的伤害造成百分比伤害
        --persent 百分比
        --infoindex 伤害公式
        --dirtype   0=当前朝向
        --附加的BUFF效果
        --buffid
        --bufflv
    CalcuExtraDamagePool = PublicFunc.EnumCreator(95),--【计算额外伤害池】
        --type 0:通过BUFF层数及公式计算并分摊成给trigger第三方结果
        --infoindex 伤害公式
        --buffid
        --bufflv
    -- DisposableScaleMCritHurt = PublicFunc.EnumCreator(96), --【一次性受到暴击伤害缩放】
        --scale 比例
    AttrFinallyCalcuAdd = PublicFunc.EnumCreator(97), --【属性计算后处理——加法】
        --type 1=闪避 2=格挡 3=暴击 4=格挡伤害 5=暴击伤害加成 6=吸血 7=反弹
        --scale 比例
    ScaleMDamageByTeamHeroHP = PublicFunc.EnumCreator(98), --【队友血量小于值后伤害增加】
        --hppersent 血量百分比
        --damagescale 伤害增加值 
    -- LockRecordName = PublicFunc.EnumCreator(99), --【锁定记录数据，不清除】
    --     --lock true=锁定不清楚数据，叠加 false=解除锁定，
    -- BackScaleRDamage           = PublicFunc.EnumCreator(100),--【背后受到伤害提升】
    --     --scale 伤害增加值
    AbsorbAbilityToCreator = PublicFunc.EnumCreator(101),  --【吸收属性】
        --abilityname 敌人属性
        --abilityscale 比例
        --creatorability 玩家属性
        --maxscale 最大值
        --recordname 记录名字
    ChangeAngularSpeed = PublicFunc.EnumCreator(102), --【改变角色旋转速度】
        --value
    ChangeFrontScaleDamage = PublicFunc.EnumCreator(103), --【受到正面伤害改变】
        --value 改变伤害值
        --valuetype 1:绝对值 2:公式
        --scale 改变伤害大小
    RecordMultiPos = PublicFunc.EnumCreator(104), --【记录多位置】
        --savetype 0:记录在BUFF 1;记录在buffmanager
        --postype 0:圆形范围随机(导航垂直检测) 1:圆形范围随机(导航移动检测) 2:目标位置 3:圆形范围随机 4:根据自身位置算偏移
        --radius 半径，默认取技能范围
        --minradiusscale 最小的半径比例 0-100
        --times:次数
        --offset 一次偏移距离 postype=4用
        --offset_begin 一次偏移距离 postype=4用
        --clear 是否清除记录 默认为清除
    SetPosition = PublicFunc.EnumCreator(105), --【瞬移】
        --postype 0:记录在BUFF的多位置
        --posindex 0:随机不重复
}
--[[endregion]]
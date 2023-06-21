--[[
region head_info_controler.lua
date: 2015-8-21
time: 21:5:56
author: Nation
]]
ENUM.EHeadResType =
{
    FightNumDy  = PublicFunc.EnumCreator(0),
    ArtisticText= PublicFunc.EnumCreator(),
    Crit = PublicFunc.EnumCreator(),
    Combo = PublicFunc.EnumCreator(),
    Max         = PublicFunc.EnumCreator() -1,
}
ENUM.EHeadInfoShowType = {
    Damage              = PublicFunc.EnumCreator(0),-- 伤害
    Crit                = PublicFunc.EnumCreator(1), -- 暴击
    Treat               = PublicFunc.EnumCreator(2), -- 回血
    GeDang              = PublicFunc.EnumCreator(3), -- 格挡
    ShanBi              = PublicFunc.EnumCreator(4), -- 闪避
    DingShenChengGong   = PublicFunc.EnumCreator(5), -- 定身成功
    DingShenShiBai      = PublicFunc.EnumCreator(6), -- 定身失败
    XuanYunChengGong    = PublicFunc.EnumCreator(7), -- 眩晕成功
    XuanYunShiBai       = PublicFunc.EnumCreator(8), -- 眩晕失败
    ChenMoChengGong     = PublicFunc.EnumCreator(9), -- 沉默成功
    ChenMoShiBai        = PublicFunc.EnumCreator(10), -- 沉默失败
    ChaoFengChengGong   = PublicFunc.EnumCreator(11), -- 嘲讽成功
    ChaoFengShiBai      = PublicFunc.EnumCreator(12), -- 嘲讽失败

    MaxHpUp             = PublicFunc.EnumCreator(13), -- 生命值提升
    MaxHpDown           = PublicFunc.EnumCreator(14), -- 生命值降低
    AtkPowerUp          = PublicFunc.EnumCreator(15), -- 攻击提升
    AtkPowerDown        = PublicFunc.EnumCreator(16), -- 攻击降低
    DefPowerUp          = PublicFunc.EnumCreator(17), -- 防御力提升
    DefPowerDown        = PublicFunc.EnumCreator(18), -- 防御力降低
    CritRateUp          = PublicFunc.EnumCreator(19), -- 暴击提升
    CritRateDown        = PublicFunc.EnumCreator(20), -- 暴击降低
    AntiCriteUp         = PublicFunc.EnumCreator(21), -- 免爆提升
    AntiCriteDown       = PublicFunc.EnumCreator(22), -- 免爆降低
    CritHurtUp          = PublicFunc.EnumCreator(23), -- 暴伤加成提升
    CritHurtDown        = PublicFunc.EnumCreator(24), -- 暴伤加成降低
    BrokenRateUp        = PublicFunc.EnumCreator(25), -- 破击提升
    BrokenRateDown      = PublicFunc.EnumCreator(26), -- 破击降低
    ParryRateUp         = PublicFunc.EnumCreator(27), -- 格挡提升
    ParryRateDown       = PublicFunc.EnumCreator(28), -- 格挡降低
    ParryPlusUp         = PublicFunc.EnumCreator(29), -- 格挡伤害提升
    ParryPlusDown       = PublicFunc.EnumCreator(30), -- 格挡伤害降低
    MoveSpeedUp         = PublicFunc.EnumCreator(31), -- 移动速度提升
    MoveSpeedDown       = PublicFunc.EnumCreator(32), -- 移动速度降低
    MoveSpeedPlusUp     = PublicFunc.EnumCreator(33), -- 移动速度加成提升
    MoveSpeedPlusDown   = PublicFunc.EnumCreator(34), -- 移动速度加成降低
    BloodsuckRateUp     = PublicFunc.EnumCreator(35), -- 吸血提升
    BloodsuckRateDown   = PublicFunc.EnumCreator(36), -- 吸血降低
    RallyRateUp         = PublicFunc.EnumCreator(37), -- 反弹提升
    RallyRateDown       = PublicFunc.EnumCreator(38), -- 反弹降低
    AttackSpeedUp       = PublicFunc.EnumCreator(39), -- 攻击速度提升
    AttackSpeedDown     = PublicFunc.EnumCreator(40), -- 攻击速度降低
    DodgeRateUp         = PublicFunc.EnumCreator(41), -- 闪避提升
    DodgeRateDown       = PublicFunc.EnumCreator(42), -- 闪避降低
    ResHpUp             = PublicFunc.EnumCreator(43), -- 生命恢复提升
    ResHpDown           = PublicFunc.EnumCreator(44), -- 生命恢复降低
    CoolDown_decUp      = PublicFunc.EnumCreator(45), -- 技能冷却缩减提升
    CoolDown_decDown    = PublicFunc.EnumCreator(46), -- 技能冷却缩减降低
    TreatPlusUp         = PublicFunc.EnumCreator(47), -- 治疗效果加成提升
    TreatPlusDown       = PublicFunc.EnumCreator(48), -- 治疗效果加成降低
    DamageUp            = PublicFunc.EnumCreator(49), -- 伤害提升
    DamageDown          = PublicFunc.EnumCreator(50), -- 伤害降低

    ImmuneDamage        = PublicFunc.EnumCreator(51), -- 免疫伤害
    ImmuneDingShen      = PublicFunc.EnumCreator(52), -- 免疫定身
    ImmuneXuanYun       = PublicFunc.EnumCreator(53), -- 免疫眩晕
    ImmuneChenMo        = PublicFunc.EnumCreator(54), -- 免疫沉默
    ImmuneChaoFeng      = PublicFunc.EnumCreator(55), -- 免疫嘲讽
    ImmuneKongJu        = PublicFunc.EnumCreator(56), -- 免疫恐惧
    KongJuChengGong     = PublicFunc.EnumCreator(57), -- 恐惧成功
    KongJuShiBai        = PublicFunc.EnumCreator(58), -- 恐惧失败

    LuckAttack          = PublicFunc.EnumCreator(59), -- 世界BOSS幸运一击
}

local head_info_res =
{
    ["assetbundles/prefabs/ui/fight/fight_num_dy.assetbundle"] = ENUM.EHeadResType.FightNumDy,
    ["assetbundles/prefabs/ui/fight/sp_fight_buff.assetbundle"] = ENUM.EHeadResType.ArtisticText,
    ["assetbundles/prefabs/ui/fight/fight_num_dy2.assetbundle"] = ENUM.EHeadResType.Combo,
    ["assetbundles/prefabs/ui/fight/fight_num_dy3.assetbundle"] = ENUM.EHeadResType.Crit,

} 

local show_type_res = 
{
    [ENUM.EHeadInfoShowType.Damage]              = {type=ENUM.EHeadResType.FightNumDy},-- 伤害
    [ENUM.EHeadInfoShowType.Crit]                = {type=ENUM.EHeadResType.FightNumDy},-- 暴击
    [ENUM.EHeadInfoShowType.Treat]               = {type=ENUM.EHeadResType.FightNumDy},-- 回血
    [ENUM.EHeadInfoShowType.GeDang]              = {type=ENUM.EHeadResType.ArtisticText},-- 格挡
    [ENUM.EHeadInfoShowType.ShanBi]              = {type=ENUM.EHeadResType.ArtisticText},-- 闪避
    [ENUM.EHeadInfoShowType.DingShenChengGong]   = {type=ENUM.EHeadResType.ArtisticText},-- 定身成功
    [ENUM.EHeadInfoShowType.DingShenShiBai]      = {type=ENUM.EHeadResType.ArtisticText},-- 定身失败
    [ENUM.EHeadInfoShowType.XuanYunChengGong]    = {type=ENUM.EHeadResType.ArtisticText},-- 眩晕成功
    [ENUM.EHeadInfoShowType.XuanYunShiBai]       = {type=ENUM.EHeadResType.ArtisticText},-- 眩晕失败
    [ENUM.EHeadInfoShowType.ChenMoChengGong]     = {type=ENUM.EHeadResType.ArtisticText},-- 沉默成功
    [ENUM.EHeadInfoShowType.ChenMoShiBai]        = {type=ENUM.EHeadResType.ArtisticText},-- 沉默失败
    [ENUM.EHeadInfoShowType.ChaoFengChengGong]   = {type=ENUM.EHeadResType.ArtisticText},-- 嘲讽成功
    [ENUM.EHeadInfoShowType.ChaoFengShiBai]      = {type=ENUM.EHeadResType.ArtisticText},-- 嘲讽失败

    [ENUM.EHeadInfoShowType.MaxHpUp]             = {type=ENUM.EHeadResType.ArtisticText},-- 生命值提升
    [ENUM.EHeadInfoShowType.MaxHpDown]           = {type=ENUM.EHeadResType.ArtisticText},-- 生命值降低
    [ENUM.EHeadInfoShowType.AtkPowerUp]          = {type=ENUM.EHeadResType.ArtisticText},-- 攻击提升
    [ENUM.EHeadInfoShowType.AtkPowerDown]        = {type=ENUM.EHeadResType.ArtisticText},-- 攻击降低
    [ENUM.EHeadInfoShowType.DefPowerUp]          = {type=ENUM.EHeadResType.ArtisticText},-- 防御力提升
    [ENUM.EHeadInfoShowType.DefPowerDown]        = {type=ENUM.EHeadResType.ArtisticText},-- 防御力降低
    [ENUM.EHeadInfoShowType.CritRateUp]          = {type=ENUM.EHeadResType.ArtisticText},-- 暴击提升
    [ENUM.EHeadInfoShowType.CritRateDown]        = {type=ENUM.EHeadResType.ArtisticText},-- 暴击降低
    [ENUM.EHeadInfoShowType.AntiCriteUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 免爆提升
    [ENUM.EHeadInfoShowType.AntiCriteDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 免爆降低
    [ENUM.EHeadInfoShowType.CritHurtUp]          = {type=ENUM.EHeadResType.ArtisticText},-- 暴伤加成提升
    [ENUM.EHeadInfoShowType.CritHurtDown]        = {type=ENUM.EHeadResType.ArtisticText},-- 暴伤加成降低
    [ENUM.EHeadInfoShowType.BrokenRateUp]        = {type=ENUM.EHeadResType.ArtisticText},-- 破击提升
    [ENUM.EHeadInfoShowType.BrokenRateDown]      = {type=ENUM.EHeadResType.ArtisticText},-- 破击降低
    [ENUM.EHeadInfoShowType.ParryRateUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 格挡提升
    [ENUM.EHeadInfoShowType.ParryRateDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 格挡降低
    [ENUM.EHeadInfoShowType.ParryPlusUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 格挡伤害提升
    [ENUM.EHeadInfoShowType.ParryPlusDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 格挡伤害降低
    [ENUM.EHeadInfoShowType.MoveSpeedUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 移动速度提升
    [ENUM.EHeadInfoShowType.MoveSpeedDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 移动速度降低
    [ENUM.EHeadInfoShowType.MoveSpeedPlusUp]     = {type=ENUM.EHeadResType.ArtisticText},-- 移动速度加成提升
    [ENUM.EHeadInfoShowType.MoveSpeedPlusDown]   = {type=ENUM.EHeadResType.ArtisticText},-- 移动速度加成降低
    [ENUM.EHeadInfoShowType.BloodsuckRateUp]     = {type=ENUM.EHeadResType.ArtisticText},-- 吸血提升
    [ENUM.EHeadInfoShowType.BloodsuckRateDown]   = {type=ENUM.EHeadResType.ArtisticText},-- 吸血降低
    [ENUM.EHeadInfoShowType.RallyRateUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 反弹提升
    [ENUM.EHeadInfoShowType.RallyRateDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 反弹降低
    [ENUM.EHeadInfoShowType.AttackSpeedUp]       = {type=ENUM.EHeadResType.ArtisticText},-- 攻击速度提升
    [ENUM.EHeadInfoShowType.AttackSpeedDown]     = {type=ENUM.EHeadResType.ArtisticText},-- 攻击速度降低
    [ENUM.EHeadInfoShowType.DodgeRateUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 闪避提升
    [ENUM.EHeadInfoShowType.DodgeRateDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 闪避降低
    [ENUM.EHeadInfoShowType.ResHpUp]             = {type=ENUM.EHeadResType.ArtisticText},-- 生命恢复提升
    [ENUM.EHeadInfoShowType.ResHpDown]           = {type=ENUM.EHeadResType.ArtisticText},-- 生命恢复降低
    [ENUM.EHeadInfoShowType.CoolDown_decUp]      = {type=ENUM.EHeadResType.ArtisticText},-- 技能冷却缩减提升
    [ENUM.EHeadInfoShowType.CoolDown_decDown]    = {type=ENUM.EHeadResType.ArtisticText},-- 技能冷却缩减降低
    [ENUM.EHeadInfoShowType.TreatPlusUp]         = {type=ENUM.EHeadResType.ArtisticText},-- 治疗效果加成提升
    [ENUM.EHeadInfoShowType.TreatPlusDown]       = {type=ENUM.EHeadResType.ArtisticText},-- 治疗效果加成降低
    [ENUM.EHeadInfoShowType.DamageUp]            = {type=ENUM.EHeadResType.ArtisticText},-- 伤害提升
    [ENUM.EHeadInfoShowType.DamageDown]          = {type=ENUM.EHeadResType.ArtisticText},-- 伤害降低

    [ENUM.EHeadInfoShowType.ImmuneDamage]        = {type=ENUM.EHeadResType.ArtisticText},-- 免疫伤害
    [ENUM.EHeadInfoShowType.ImmuneDingShen]      = {type=ENUM.EHeadResType.ArtisticText},-- 免疫定身
    [ENUM.EHeadInfoShowType.ImmuneXuanYun]       = {type=ENUM.EHeadResType.ArtisticText},-- 免疫眩晕
    [ENUM.EHeadInfoShowType.ImmuneChenMo]        = {type=ENUM.EHeadResType.ArtisticText},-- 免疫沉默
    [ENUM.EHeadInfoShowType.ImmuneChaoFeng]      = {type=ENUM.EHeadResType.ArtisticText},-- 免疫嘲讽
    [ENUM.EHeadInfoShowType.ImmuneKongJu]        = {type=ENUM.EHeadResType.ArtisticText},-- 免疫嘲讽
    [ENUM.EHeadInfoShowType.KongJuChengGong]     = {type=ENUM.EHeadResType.ArtisticText},-- 免疫嘲讽
    [ENUM.EHeadInfoShowType.KongJuShiBai]        = {type=ENUM.EHeadResType.ArtisticText},-- 免疫嘲讽
    [ENUM.EHeadInfoShowType.LuckAttack]          = {type=ENUM.EHeadResType.ArtisticText},-- 世界BOSS幸运一击
}

HeadInfoControler = Class("HeadInfoControler")

HeadInfoControler._infoRes = { }

HeadInfoControler.ObjPool = { }

HeadInfoControler.hit_combo = 0

---------------------------------------全局函数---------------------------------------
function HeadInfoControler.LoadRes()
    local OnLoaded = function(user_data, pid, fpath, asset_obj, error_info)
        HeadInfoControler._infoRes[head_info_res[fpath]] = asset_obj
        -- app.log("OnLoaded:"..fpath)
    end
    for k, v in pairs(head_info_res) do
        HeadInfoControler.ObjPool[v] = {}
        ResourceLoader.LoadAsset(k, { func = OnLoaded }, nil)
    end
end

 
local HeadInfoCfg = nil;
---------------------------------------成员函数---------------------------------------
function HeadInfoControler:Init(entity)
    self.obj = entity
    -- 飙血对象
    --[[self.hud_obj = nil
    self._showList = { }
    self._showLayer = { }
    self.fight_num_list = { }
    self.bind_pos = nil]]
    self.showType = 1;
    local startUpInf = FightScene.GetStartUpEnv();
    if startUpInf and startUpInf.levelData then
        local cfg = ConfigManager.Get(EConfigIndex.t_fight_type, startUpInf.levelData.fight_type);
        if cfg then
            self.showType = cfg.font_type;
        end
    end

    self.WaitShow = { }
    self.ShowingNum = {}
    self.Showing = { }
    self.ShowTypeEnum = {};
    if HeadInfoCfg == nil then
        HeadInfoCfg = ConfigManager._GetConfigTable(EConfigIndex.t_head_info);
    end
    for k, v in pairs(ENUM.EHeadInfoShowType) do
        self.WaitShow[v] = Queue:new()
        self.ShowingNum[k] = {[true]=0,[false]=0}
        self.Showing[v] = {}
    end   
end

-- 获取当前正在展示的对象数量
function HeadInfoControler:GetShowingNum(show_type)
    return self.ShowingNum[show_type]
end

function HeadInfoControler:GetNextWaitShow(show_type)
    --if type(self.WaitShow[show_type]) ~= type { } then return end
    if self.WaitShow[show_type]:len() > 0 then
        return self.WaitShow[show_type]:pop()
    end
    return nil
    --return next(self.WaitShow[show_type])
end

function HeadInfoControler:CreateFightNumObj(resType)
    -- 生成一个放在频幕外的资源,资源中就设定好
    -- 避免同时生成多个，调用逻辑中处理
    local obj = asset_game_object.create(HeadInfoControler._infoRes[resType]);
    --obj:set_parent(Root.get_root_ui());
    obj:set_parent(Root.get_root_ui_2d_fight());
    obj:set_local_scale(1, 1, 1)
    local result = { }
    local suc = false
    for i = 0, 10 do
        if obj ~= nil then
            if resType == ENUM.EHeadResType.FightNumDy then
                local lbl = ngui.find_label(obj, "Hud/" .. tostring(i) .. "/Label")
                if lbl then
                    local animator_go = lbl:get_parent()
                    lbl:set_text("")
                   -- obj:set_local_position(999,999,0)
                    if animator_go then
                        -- 元素初始化
                        local fight_num = { f_obj = obj, f_a_go = animator_go, f_label = lbl, f_showing = false, start_time = nil }
                        table.insert(result, fight_num)
                        -- 只要创建成功一个说明成功
                        if not suc then
                            suc = true
                        end
                    end
                end
            elseif resType == ENUM.EHeadResType.ArtisticText then
                local sp = ngui.find_sprite(obj, "hud/" .. tostring(i) .. "/sp")
                if sp then
                    sp:set_sprite_name("")
                    local animator_go = sp:get_parent()
                    --obj:set_local_position(999,999,0)
                    if animator_go then
                        -- 元素初始化
                        local fight_num = { f_obj = obj, f_a_go = animator_go, f_sp = sp, f_showing = false, start_time = nil }
                        table.insert(result, fight_num)
                        -- 只要创建成功一个说明成功
                        if not suc then
                            suc = true
                        end
                    end
                end            
            end
        end
    end
    return result, suc
end

function HeadInfoControler:GetFightNumObj(resType)
    -- 检查与创建资源
    local num = table.get_num(HeadInfoControler.ObjPool[resType])
    local result = nil
    if HeadInfoControler.ObjPool[resType] and num > 1 then
        -- 倒着拿，此处应当有一个快速查找算法
        for i = num, 1, -1 do
            result = HeadInfoControler.ObjPool[resType][num]
            if result then
                table.remove(HeadInfoControler.ObjPool[resType], num)
                return result
            end
        end
    end
    -- 创建一坨
    local old_num = table.get_num(HeadInfoControler.ObjPool[resType])
    local f_nums, suc = self:CreateFightNumObj(resType);
    -- 新创建直接拿第一个
    if true == suc then
        for k, v in pairs(f_nums) do
            table.insert(HeadInfoControler.ObjPool[resType], v)
        end
        result = HeadInfoControler.ObjPool[resType][old_num + 1]
        HeadInfoControler.ObjPool[resType][old_num + 1] = nil
        return result
    else
        app.log_warning("HeadInfoControler:GetFightNumObj error")
    end

end



-- @param sType ENUM.EHeadInfoShowType
-- @param is_skill boolean 是否是技能攻击  
function HeadInfoControler:ShowDyHp(hp, sType,is_skill)
    self.ShowTypeEnum[sType] = (self.ShowTypeEnum[sType] or 0) + 1;
    self.WaitShow[sType]:push({ hp = hp ,is_skill = is_skill})
    --table.insert(self.WaitShow[sType],{ hp = hp ,is_skill = is_skill} )
    --TODO ewing 
    --等出技能攻击和普通攻击效果
end

--获取暴击资源
function HeadInfoControler.GetCritObjData()
    if HeadInfoControler.crit_obj_data == nil then
        local obj = asset_game_object.create(HeadInfoControler._infoRes[ENUM.EHeadResType.Crit]);
        obj:set_parent(Root.get_root_ui_2d_fight());
        obj:set_local_scale(1, 1, 1)
        HeadInfoControler.crit_obj_data = { obj = obj, gameObject = obj:get_child_by_name("Hud/0"), sprite = ngui.find_sprite(obj,"sp") }
        app.log("create critobjdata")
    end
    return HeadInfoControler.crit_obj_data
end


function HeadInfoControler.ShowCombo()
    -- if HeadInfoControler.combo_obj_data == nil then
    --     local obj = asset_game_object.create(HeadInfoControler._infoRes[ENUM.EHeadResType.Combo]);
    --     obj:set_parent(Root.get_root_ui_2d_fight());
    --     obj:set_local_scale(1, 1, 1)        
    --     HeadInfoControler.combo_obj_data = { obj=obj, gameObject = obj:get_child_by_name("Hud/0"), Label = ngui.find_label(obj,"Label"), lbl_num1 = ngui.find_label(obj,"Hud/0/lbl_num1"),lbl_num2 = ngui.find_label(obj,"Hud/0/lbl_num2"),lbl_num3 = ngui.find_label(obj,"Hud/0/lbl_num3") }            
    --     app.log("create ShowCombo")
    -- end
    -- HeadInfoControler.hit_combo = HeadInfoControler.hit_combo + 1
    -- if HeadInfoControler.hit_combo > 999 then
    --     HeadInfoControler.hit_combo = 999
    -- end
    -- local n3 = math.floor(HeadInfoControler.hit_combo/100%10)
    -- local n2 = math.floor(HeadInfoControler.hit_combo/10%10)
    -- local n1 = math.floor(HeadInfoControler.hit_combo%10)
    -- --app.log(string.format("hit_combo=%s,n3=%s,n2=%s,n1=%s,",tostring(HeadInfoControler.hit_combo),tostring(n3),tostring(n2),tostring(n1)))
    
   

    -- local count = HeadInfoControler.hit_combo
    -- if count > 0 and count <10 then
    --     HeadInfoControler.combo_obj_data.lbl_num3:set_text(tostring(PublicFunc.NumberToArtString(n1,"/b")))
    --     HeadInfoControler.combo_obj_data.lbl_num2:set_text("")
    --     HeadInfoControler.combo_obj_data.lbl_num1:set_text("")
    -- elseif count >=10 and count <100 then
    --     HeadInfoControler.combo_obj_data.lbl_num3:set_text(tostring(PublicFunc.NumberToArtString(n2,"/b")))
    --     HeadInfoControler.combo_obj_data.lbl_num2:set_text(tostring(PublicFunc.NumberToArtString(n1,"/b")))
    --     HeadInfoControler.combo_obj_data.lbl_num1:set_text("")
    -- elseif count >=100  then
    --     HeadInfoControler.combo_obj_data.lbl_num3:set_text(tostring(PublicFunc.NumberToArtString(n3,"/b")))
    --     HeadInfoControler.combo_obj_data.lbl_num2:set_text(tostring(PublicFunc.NumberToArtString(n2,"/b")))
    --     HeadInfoControler.combo_obj_data.lbl_num1:set_text(tostring(PublicFunc.NumberToArtString(n1,"/b")))
    -- end
    -- if HeadInfoControler.hit_combo ==1 then
    --     HeadInfoControler.combo_obj_data.Label:set_text("命中")
    -- end
    -- HeadInfoControler.combo_obj_data.gameObject:animator_play("fight_num_dy2") 
    -- do return end

    -- if n3 > 0 then
    --     HeadInfoControler.combo_obj_data.lbl_num3:set_text(tostring(PublicFunc.NumberToArtString(n3,"/b")))
    -- else
    --     HeadInfoControler.combo_obj_data.lbl_num3:set_text("")
    -- end
    -- if n2 > 0 or n3 >0  then
    --     HeadInfoControler.combo_obj_data.lbl_num2:set_text(tostring(PublicFunc.NumberToArtString(n2,"/b")))
    -- else
    --     HeadInfoControler.combo_obj_data.lbl_num2:set_text("")
    -- end
    -- if n1 > 0 or n2 > 0 or n3>0 then
    --     HeadInfoControler.combo_obj_data.lbl_num1:set_text(tostring(PublicFunc.NumberToArtString(n1,"/b")))
    -- else
    --     HeadInfoControler.combo_obj_data.lbl_num1:set_text("")
    -- end
    -- if HeadInfoControler.hit_combo ==1 then
    --     HeadInfoControler.combo_obj_data.Label:set_text("命中")
    -- end
    -- HeadInfoControler.combo_obj_data.gameObject:animator_play("fight_num_dy2")    
end

function HeadInfoControler.show_combo_end()
    app.log("HeadInfoControler.show_combo_end")
    if HeadInfoControler.combo_obj_data then
        HeadInfoControler.hit_combo = 0
         HeadInfoControler.combo_obj_data.lbl_num3:set_text("")
         HeadInfoControler.combo_obj_data.lbl_num2:set_text("")
         HeadInfoControler.combo_obj_data.lbl_num1:set_text("")
         HeadInfoControler.combo_obj_data.Label:set_text("")
    end
end

function HeadInfoControler:GetCfg(str_type, is_enemy)
    local cfg = HeadInfoCfg[str_type]
    local camp = is_enemy and 1 or 0;
    if not cfg then
         -- app.log("#lhf#HeadInfoControler get error type:"..tostring(str_type)); 
         return nil;
    end
    for k,v in pairs(cfg) do
        if v.camp == camp then
            return v;
        end
    end
    return nil;
end

function HeadInfoControler:GetMaxNum(cfg, str_type, is_enemy)
    -- local cfg = self:GetCfg(str_type, is_enemy);
    return cfg.max_num;
end

function HeadInfoControler:GetCurNum(str_type, is_enemy)
    if self.ShowingNum[str_type] then
        return self.ShowingNum[str_type][is_enemy] or 0;
    end
    return 0;
end

function HeadInfoControler:AddCurNum(str_type, is_enemy)
    if type(self.ShowingNum) == "table" then
        self.ShowingNum[str_type] = {};
    end
    self.ShowingNum[str_type][is_enemy] = (self.ShowingNum[str_type][is_enemy] or 0) + 1;
end

function HeadInfoControler:DelCurNum(str_type, is_enemy)
    if type(self.ShowingNum) == "table" then
        self.ShowingNum[str_type] = {};
    end
    self.ShowingNum[str_type][is_enemy] = (self.ShowingNum[str_type][is_enemy] or 0) - 1;
end

function HeadInfoControler:OnTick()

    -- local num  = table.get_num(self.Showing)
    for k, v in pairs(ENUM.EHeadInfoShowType) do 
        repeat
            if not self.ShowTypeEnum[v] or self.ShowTypeEnum[v] <= 0 then
                break;
            end
            local is_enemy = self.obj:IsEnemy()
            local cfg = self:GetCfg(k, is_enemy);
            if not cfg then
                break;
            end
            if self:GetCurNum(k, is_enemy) < self:GetMaxNum(cfg, k, is_enemy) then
                local  nv = self:GetNextWaitShow(v)
                self.ShowTypeEnum[v] = self.ShowTypeEnum[v] - 1;
                if not nv then
                    break;
                end
                local _f_obj = self:GetFightNumObj(show_type_res[v].type)
                if not _f_obj then
                    app.log_warning("生成资源飘血资源失败");
                    break;
                end
                -- 计数显示
                --self.WaitShow[v][nk] = nil
                local artHp = tostring(nv.hp)
                local x, y, z = self:GetRolePos()
                local font_size = cfg.font_size;
                local _animation_name = cfg.animation_name
                local rx = math.random(cfg.random_x[1],cfg.random_x[2])/ 90.0;
                local ry = math.random(cfg.random_y[1],cfg.random_y[2])/ 90.0;

                if show_type_res[v].type == ENUM.EHeadResType.FightNumDy then
                    if cfg.ex_name ~= 0 then
                        artHp = PublicFunc.NumberToArtString(nv.hp,cfg.ex_name);
                    end
                    _f_obj.f_label:set_active(true)
                    _f_obj.f_label:set_font_size(font_size)
                    _f_obj.f_label:set_text(artHp)
                elseif show_type_res[v].type == ENUM.EHeadResType.ArtisticText then
                    _f_obj.f_sp:set_active(true)
                    local sprite_name = cfg.sprite_name;
                     -- app.log("#lhf#k:"..tostring(k));
                    if sprite_name == 0 then
                        _f_obj.f_sp:set_sprite_name("");
                    else
                        _f_obj.f_sp:set_sprite_name(sprite_name);
                    end
                end
                _f_obj.f_showing = true
                _f_obj.start_time = PublicFunc.QueryCurTime();
                _f_obj.f_a_go:set_position(x + rx, y + ry, 0)
                _f_obj.f_a_go:animator_play(_animation_name)
                table.insert(self.Showing[v], _f_obj)
                -- 显示计数
                self:AddCurNum(k, self.obj:IsEnemy())
            else
                self.WaitShow[v]:clear();
                self.ShowTypeEnum[v] = nil;
                 -- app.log_warning("超出上限" .. self.obj:GetName() .. "  " .. tostring(self:GetShowingNum()) .. "  " .. tostring(curTime))
            end
        until true;
    end


    -- 检查播放完毕
    for type_str, type_id in pairs(ENUM.EHeadInfoShowType) do
        for k, v in pairs(self.Showing[type_id]) do
            local cfg = self:GetCfg(type_str, self.obj:IsEnemy());
            if PublicFunc.QueryDeltaTime(v.start_time) >= cfg.remove_time then
                self:DelCurNum(type_str, self.obj:IsEnemy())
                -- app.log("#lhf#飘完一个" .. self.obj:GetName() .. "  " .. tostring(self.ShowingNum))
                local new_obj = v
                new_obj.f_showing = false;
                if show_type_res[type_id].type == ENUM.EHeadResType.ArtisticText then
                    new_obj.f_sp:set_active(false)
                else
                    new_obj.f_label:set_active(false)
                end

                --new_obj.f_a_go:set_position(-1000, 0, 0)
                --new_obj.f_a_go:set_animator_culling_mode(2)
                table.insert(HeadInfoControler.ObjPool[show_type_res[type_id].type], new_obj)
                self.Showing[type_id][k] = nil
                -- 显示计数
            end
        end
    end
    --    if self.hud_obj then
    --        local x, y, z = self:GetRolePos()
    --        --        obj:set_position(x, y, 0)
    --        self.hud_obj.hud:set_position(x, y, 0)
    --    end
end

---------------------------------------外部接口---------------------------------------
-- 删除来不及显示的飘血
function HeadInfoControler:RemoveNotShow()
    for k, v in pairs(ENUM.EHeadInfoShowType) do
        local waitShowNum = table.get_num(self.WaitShow[v])
        local cfg = self:GetCfg(k, self.obj:IsEnemy());
        if waitShowNum > cfg.max_num then
            local num = waitShowNum - cfg.max_num
            for i = 1, num do
                self.WaitShow[v][i] = nil
            end
        end
    end
end

function HeadInfoControler:ShowInfo(type)

end

function HeadInfoControler:ShowHP(hp, bCrit,is_skill)
    -- 移除富于飘血
    --self:RemoveNotShow()
    --TODO:test ewing
    --bCrit = true
    --hp = math.abs(hp)    


    local sType = ENUM.EHeadInfoShowType.Damage
    if nil ~= bCrit and true == bCrit then
        sType = ENUM.EHeadInfoShowType.Crit
    elseif hp > 0 then
        sType = ENUM.EHeadInfoShowType.Treat
    end
    --TODO test
    -- local random_crit = math.random(1,2)
    -- bCrit = random_crit == 1
    -- local random_stype = math.random(1,4)
    -- sType =  random_stype


    self:ShowDyHp(hp, sType,is_skill)
end

function HeadInfoControler:ShowArtisticText(type)
     -- app.log("#lhf#type:"..tostring(type));
    self.ShowTypeEnum[type] = (self.ShowTypeEnum[type] or 0) + 1;
    self.WaitShow[type]:push({})
end

function HeadInfoControler:ShowCrit()
    local asset = HeadInfoControler._infoRes[ENUM.EHeadResType.Crit]
    if asset == nil then
        app.log_warning("缺少暴击资源")
        return
    end
 
end

 

function HeadInfoControler:ClearWaitShow()
    self.WaitShow = { }
end


function HeadInfoControler:Finalize()
    self.WaitShow = { } 
end

HeadInfoControler.Direction = {
    Left = 0,
    Center = 1,
    Right = 2,
}

function HeadInfoControler:GetRolePos()
    local fight_camera = CameraManager.GetSceneCamera();
    if fight_camera == nil then
        return 0, 0, 0;
    end
    local ui_camera = Root.get_ui_camera();  
    local pos = self.obj:GetBindPosition(1)
    local x, y, z = pos.x, pos.y, pos.z
    local direction_r = HeadInfoControler.Center
    local v_x,v_y,v_z = fight_camera:world_to_viewport_point(x,y,z)

    if v_x < 0.5 then
        direction_r = HeadInfoControler.Direction.Left
    elseif v_x == 0.5 then
        direction_r = HeadInfoControler.Direction.Center
    else
        direction_r = HeadInfoControler.Direction.Right
    end

    local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);    
    --view_y = view_y - 30;
    local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
    return ui_x, ui_y, ui_z,direction_r;
end

function HeadInfoControler.DestroyPart()
    app.log("HeadInfoControler.DestroyPart")
    HeadInfoControler.hit_combo = 0;
    if  HeadInfoControler.combo_obj_data ~= nil then
        HeadInfoControler.combo_obj_data.obj:set_active(false)
        HeadInfoControler.combo_obj_data.obj:destroy_object()
        --HeadInfoControler.combo_obj_data.obj:destroy_all()
        HeadInfoControler.combo_obj_data = nil
    end
    if HeadInfoControler.crit_obj_data ~= nil then
        HeadInfoControler.crit_obj_data.obj:set_active(false)
        HeadInfoControler.crit_obj_data.obj:destroy_object()
        --HeadInfoControler.crit_obj_data.obj:destroy_all()
        HeadInfoControler.crit_obj_data.obj = nil
        HeadInfoControler.crit_obj_data.gameObject = nil
        HeadInfoControler.crit_obj_data.sprite = nil
        HeadInfoControler.crit_obj_data = nil 
    end
end

-- 根据配置判断是否需要飘字
function HeadInfoControler:Check(attacker)
    local selfflg = false;
    if self.showType == 1 then
        selfflg = self.obj:IsCaptain();
    elseif self.showType == 2 then
        selfflg = self.obj:IsMyControl();
    elseif self.showType == 0 then
        selfflg = true;
    end
    local enemyflg = false;
    if attacker then
        if self.showType == 1 then
            enemyflg = attacker:IsCaptain();
        elseif self.showType == 2 then
            enemyflg = attacker:IsMyControl();
        elseif self.showType == 0 then
            enemyflg = true;
        end
    end
    return selfflg or enemyflg;
end


--[[ endregion ]]
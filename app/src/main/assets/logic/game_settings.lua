-- game runtime settings
--[[
    1.   25人 普攻50 技能15 品质高
    2.   20人 普攻50 技能12 品质中
    3.   15人 普攻50 技能8 品质低
]]

GameSettings = {
    -- 画面参数
    enable_effect_quality_control = true;-- [特效品质控制]
    effect_quality_level = 3;-- 1:low, 2:middle, 3:hgih
    enable_effect_count_control = true;-- [特效数量控制]
    effect_max_count = 1;-- 0: EffectManager根据FPS设定， > 0: 强制设定。	
    normal_effect_max_count = 50;-- 普通攻击最大特效数量
    skill_effect_max_count = 12;-- 技能最大特效数量
    hited_effect_max_count = 5;-- 受击特大数量
    hero_renderer_max_count = 20;-- 英雄模型显示数量
    hero_renderer_radius = 6;-- 范围值
    enable_intelligence_control = true; --智能施法开关控制
}

-- 品质开关
function GameSettings.SetEnableEffectQualityControl(value)
    GameSettings.enable_effect_quality_control = value
end

function GameSettings.GetEnableEffectQualityControl()
    return GameSettings.enable_effect_quality_control
end

function GameSettings.SetEnableEffectCountControl(value)
    GameSettings.enable_effect_count_control = value
end

function GameSettings.GetEnableEffectCountControl()
    return GameSettings.enable_effect_count_control
end

function GameSettings.SetEffectQualityLevel(value)
    GameSettings.effect_quality_level = value
    if GameSettings.GetEnableEffectQualityControl() then
        EffectManager.SetEffectQualityLevel(GameSettings.effect_quality_level)
    end
end

function GameSettings.GetEffectQualityLevel()
    return GameSettings.effect_quality_level
end

function GameSettings.SetEffectMaxCount(value)
    GameSettings.effect_max_count = value
    if GameSettings.enable_effect_count_control then
        if GameSettings.effect_max_count > 0 then
            EffectManager.SetMaxActiveEffectEntityCnt(GameSettings.effect_max_count);
        end
    end
end
   
function GameSettings.SetNormalAttackEffectMaxCount(value)
    GameSettings.normal_effect_max_count = value
end
    
function GameSettings.SetSkillAttackEffectMaxCount(value)
    GameSettings.skill_effect_max_count = value
end

function GameSettings.GetEffectMaxCount()
    return GameSettings.effect_max_count
end

function GameSettings.GetNormalEffectMaxCount()
    return GameSettings.normal_effect_max_count
end

function GameSettings.GetSkillEffectMaxCount()
    return GameSettings.skill_effect_max_count
end

function GameSettings.GetHitedEffectMaxCount()
    return GameSettings.hited_effect_max_count;
end

function GameSettings.SetHitedEffectMaxCount(value)
    GameSettings.hited_effect_max_count = value
end

function GameSettings.SetHeroRendererMaxCount(value)
    GameSettings.hero_renderer_max_count = value
end

function GameSettings.GetHeroRendererMaxCount()
    return GameSettings.hero_renderer_max_count
end

function GameSettings.GetHeroRendererRadius()
    return GameSettings.hero_renderer_radius
end

function GameSettings.SetIntelligenceOpen(value)
     GameSettings.enable_intelligence_control = value
end

function GameSettings.GetIntelligenceOpen()
    return  GameSettings.enable_intelligence_control
end
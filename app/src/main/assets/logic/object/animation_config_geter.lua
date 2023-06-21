
local defaultAnimationFrameNum = 
{
    [EANI.up] = 6;
    [EANI.dangling] = 6;
    [EANI.down] = 7;
    [EANI.getup] = 24;
    [EANI.repel] = 27;
}


function g_get_animation_config(obj, aniID)
    -- local cfg = g_get_skill_effect_by_modeid(obj.config.model_id, aniID)
    local cfg = ConfigHelper.GetSkillEffectByModelId(obj.config.model_id, aniID)
    if cfg == nil then
        -- TODO: kevin 配置问题导致输出太多，暂时屏蔽 
        -- app.log_warning('aniid=' .. aniID .. 'model id:'.. obj.config.model_id .. ' config==nil objname:' .. obj:GetName().. " "..debug.traceback())
    else
        -- if type(cfg.frame_event) ~= 'table' then
        --     app.log_warning('aniid=' .. aniID .. ' config frame_event error objname:' .. obj:GetName())
        -- end
    end

    if type(cfg) ~= 'table' or type(cfg.frame_event) ~= 'table' then

        -- TODO: kevin 配置问题导致输出太多，暂时屏蔽 
        -- app.log_warning('_ai_get_skill_ani_cfg return defalut!')

        local f = defaultAnimationFrameNum[aniID]
        if f == nil then
            f = 20
        end

        cfg = {frame_event = {{f = f, e="temp"}}, action_id = aniID}
    end
    return cfg
end



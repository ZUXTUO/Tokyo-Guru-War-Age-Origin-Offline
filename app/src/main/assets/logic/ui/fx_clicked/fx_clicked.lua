-- 全屏点击特效,目前是在游戏开始后加载
FxClicked = {
    effect_id = 1700017,
    -- 特效
    enable = true
}

function FxClicked.Start()
   -- FxClicked.LoadAsset()
    touch.set_on_begin("gScreenTouchBegin")
end

function FxClicked.LoadAsset()
    if not FxClicked.fx_effect then
        FxClicked.fx_effect = EffectManager.createEffect(1700017)
        FxClicked.fx_effect:set_active(false)
    end
end  

function FxClicked.SetEnable(value)
    FxClicked.enable = value
end

function FxClicked.OnClicked(x, y, z)
    if FxClicked.enable  and app.get_time_scale() and app.get_time_scale() > 0 and EffectManager.placeHolderRes ~= nil then
        local camera = Root.get_ui_camera()
        if camera then
            local effect = EffectManager.createEffect(FxClicked.effect_id, 0.20)
            local x, y, z = camera:screen_to_world_point(x, y, z)
            effect:set_position(x, y, z)
            -- app.log(string.format("x=%s,y=%s,z=%s", x, y, z))
        end
    end
end

function gScreenTouchBegin(...)
    if GuideManager and GuideManager.IsGuideRuning() then
        GuideManager.OnScreenTouchBegin(...)
    end
    FxClicked.OnClicked(...)
end
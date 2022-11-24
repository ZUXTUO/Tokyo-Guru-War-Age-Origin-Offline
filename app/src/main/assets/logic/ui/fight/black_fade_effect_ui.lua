-- BlackFadeEffectUi 淡入淡出黑幕效果
-- author: zzc
-- create: 2016-11-15

BlackFadeEffectUi = Class('BlackFadeEffectUi', UiBaseClass);

local res = 'assetbundles/prefabs/ui/public/panel_screen_lock.assetbundle';
local _FadeType = {
    fadeIn = 1,
    fadeOut = 2,
    keepBlack = 3,
    keepVedioBg = 4,
}

function BlackFadeEffectUi.GetResList()
    return {res}
end

--[[
    {
        callback = ... -- 完成回调
        duration = ... -- 持续时间(ms)
    }
--]]

function BlackFadeEffectUi.FadeIn(data)
    if BlackFadeEffectUi.cls == nil then
        BlackFadeEffectUi.cls = BlackFadeEffectUi:new()
    end
    BlackFadeEffectUi.cls:SetData(data, _FadeType.fadeIn)
end

function BlackFadeEffectUi.FadeOut(data)
    if BlackFadeEffectUi.cls == nil then
        BlackFadeEffectUi.cls = BlackFadeEffectUi:new()
    end
    BlackFadeEffectUi.cls:SetData(data, _FadeType.fadeOut)
end

function BlackFadeEffectUi.KeepBlack(data)
    if BlackFadeEffectUi.cls == nil then
        BlackFadeEffectUi.cls = BlackFadeEffectUi:new()
    end
    BlackFadeEffectUi.cls:SetData(data, _FadeType.keepBlack)
end

function BlackFadeEffectUi.KeepVedioBg(data)
    if BlackFadeEffectUi.cls == nil then
        BlackFadeEffectUi.cls = BlackFadeEffectUi:new()
    end
    BlackFadeEffectUi.cls:SetData(data, _FadeType.keepVedioBg)
end

function BlackFadeEffectUi.Destroy()
    if BlackFadeEffectUi.cls then
        BlackFadeEffectUi.cls:DestroyUi()
        BlackFadeEffectUi.cls = nil
    end
end

function BlackFadeEffectUi.IsDestroy()
    return BlackFadeEffectUi.cls == nil
end

------------------------------- 内部接口-------------------------------

function BlackFadeEffectUi:Init(data)
    self.pathRes = res
    self.spFileName = "ban"
    UiBaseClass.Init(self, data);
end

function BlackFadeEffectUi:InitData(data)
	UiBaseClass.InitData(self, data);
end

function BlackFadeEffectUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("fade_effect_ui");

    self.sp = ngui.find_sprite(self.ui, "ui_screen_lock")
    self.sp:set_sprite_name(self.spFileName)
    self.sp:get_game_object():set_collider_enable(false) -- 关闭点击 会导致渐变混乱
    self.widget = ngui.find_widget(self.ui, "texture")
    self.texture = ngui.find_texture(self.ui, "texture")
    self.lab = ngui.find_label(self.ui,"lab");
    self.texture:set_active(false)

    if self.playing == false then
        self:tween()
    end
end

function BlackFadeEffectUi:DestroyUi()
    if self.texture then
        self.texture:Destroy()
        self.texture = nil
    end
    self.callback = nil
    self.playing = nil
    self.sp = nil
    UiBaseClass.DestroyUi(self)
end

function BlackFadeEffectUi:tween()
    self.playing = true
    local startAlpha = 0
    local endAlpha = 0
    local obj = self.sp
    if self.type == _FadeType.fadeIn then
        startAlpha = 0
        endAlpha = 1
    elseif self.type == _FadeType.fadeOut then
        startAlpha = 1
        endAlpha = 0
    elseif self.type == _FadeType.keepBlack then
        startAlpha = 1
        endAlpha = 1
    elseif self.type == _FadeType.keepVedioBg then
        startAlpha = 1
        endAlpha = 1

        obj = self.texture
    end

    self.lab:set_text(self.text)
    -- 增加淡入效果
    if self.text and #self.text > 0 and self.textFade then
        self.lab:set_color(1,1,1,0)
        Tween.addTween(self.lab,1,{color = {1,1,1,1}},nil,0,nil,nil,nil)
    end
    if self.sp == obj then
        self.sp:set_active(true)
        self.texture:set_active(false)

        self.sp:set_color(1,1,1,startAlpha)
        Tween.addTween(obj,self.duration,{color = {1,1,1,endAlpha}},nil,0,nil,nil,self.callback)
    elseif self.texture == obj then
        self.sp:set_active(false)
        self.texture:set_active(true)

        self.texture:set_texture(self.texturefile)

        local r = app.get_screen_height() / app.get_screen_width()
        local h = 1280 * r
        local w = h * 16 / 9
        self.widget:set_size(w, h)
        TimerManager.Add(self.callback, self.duration, 1)
    end
end

function BlackFadeEffectUi:SetData(data, type)
    self.type = type
    self.callback = data.callback
    self.duration = data.duration or 1
    self.texturefile = data.texturefile
    self.text = data.text or ""
    self.textFade = data.textfade
    self.playing = false

    -- 缓动
    if self.ui then
        self:tween()
	end
end

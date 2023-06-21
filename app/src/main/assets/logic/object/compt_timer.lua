
ComptTimer = Class("ComptTimer")

function ComptTimer:ComptTimer(entity)
    self.sc = entity
end

function ComptTimer:Finalize()
    self:Clear()
end

function ComptTimer:Clear()
    if self.bindFunc then
        for k,v in pairs(self.bindFunc) do
            if v ~= nil then
                if TimerManager then
                    TimerManager.Remove(v)
                end
                Utility.unbind_callback(self, v);
            end
        end
    end
end

function ComptTimer:RegistFunc()
    if self.bindFunc == nil then
        self.bindFunc = {}
        self.bindFunc['trigger'] = Utility.bind_callback(self, self.trigger);
        self.bindFunc['play_animation_end'] = Utility.bind_callback(self, self.play_animation_end);
    end
end

--[[启动]]
function ComptTimer:Start(param)
    if TRIGGER_DEBUG then
        app.log('trigger_debug Start param = ' .. tostring(param) .. '  ' .. self.sc:GetName())
    end
    self:RegistFunc()

    --倒计时 + 触发中(0.2)
    local _inter = param.delayTime + 0.2
    TimerManager.Add(self.bindFunc["trigger"], _inter * 1000, 1)

    --倒计时 + 动画 + 延后时间
    _inter = param.delayTime + param.aniTime + 0.5
    TimerManager.Add(self.bindFunc["play_animation_end"], _inter * 1000, 1)

    self.sc:AnimatorPlay("die")
end

function ComptTimer:trigger()
    if TRIGGER_DEBUG then
        app.log('trigger_debug ComptTimer:trigger ')
    end
    ComptItem.AttachBuff(self.sc)
end

function ComptTimer:play_animation_end()
    if self.sc.triggerObj then
        self.sc.triggerObj:RemoveTrigger()
    end
end

ComptGrenade = Class("ComptGrenade")

function ComptGrenade:ComptGrenade(entity)
    self.sc = entity
end

function ComptGrenade:Finalize()
    self:Clear()
    if TRIGGER_DEBUG then
        app.log('ComptGrenade:Finalize ')
    end
end

function ComptGrenade:Clear()
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

function ComptGrenade:RegistFunc()
    if self.bindFunc == nil then
        self.bindFunc = {}
        self.bindFunc['explode'] = Utility.bind_callback(self, self.explode);
        self.bindFunc['play_animation_end'] = Utility.bind_callback(self, self.play_animation_end);
    end
end


--[[启动定时炸弹]]
function ComptGrenade:Start(param)
    if TRIGGER_DEBUG then
        app.log('trigger_debug Start param = ' .. tostring(param) .. '  ' .. self.sc:GetName())
    end
    self:RegistFunc()

    --倒计时 + 爆炸中(0.2)
    local _inter = param.delayTime + 0.2
    TimerManager.Add(self.bindFunc["explode"], _inter * 1000, 1)

    --倒计时 + 爆炸时间(1) + 延后时间
    _inter = param.delayTime + param.aniTime + 0.5
    TimerManager.Add(self.bindFunc["play_animation_end"], _inter * 1000, 1)

    self.sc:AnimatorPlay("die")
end

function ComptGrenade:explode()
    if TRIGGER_DEBUG then
        app.log('trigger_debug explode() ')
    end
    ComptItem.AttachBuff(self.sc)
end

function ComptGrenade:play_animation_end()
    if self.sc then
        ObjectManager.DeleteObj(self.sc:GetName())
    end
end


MainUiCaptainRebornTip = Class('MainUiCaptainRebornTip', UiBaseClass)

--ui/new_fight
local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_dead.assetbundle"

function MainUiCaptainRebornTip:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUiCaptainRebornTip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.countDownTimeLabel = ngui.find_label(self.ui, "lab_time")

    self:Hide()
end

function MainUiCaptainRebornTip:OnDead(name, time)

    if name ~= g_dataCenter.fight_info:GetCaptainName() or time <= 0 then return end
    self.countDownEndTime = system.time() + time
    self.captainName = name
    self:Show()
    self:Update(0)
end

function MainUiCaptainRebornTip:Update(dt)
    if self.countDownEndTime then
        local st = self.countDownEndTime - system.time()
        local showTime = math.max(math.floor(st), 1)
        if showTime ~= self.currShowTime then
            self.countDownTimeLabel:set_text(tostring(showTime))
            self.currShowTime = showTime
        end

        if st <= 1 then
            local obj = GetObj(self.captainName)
            if obj then
                local cur_blood = obj:GetPropertyVal('cur_hp');
                if cur_blood > 0 then
                    self:CountDownEnd()
                end
            end
        elseif st <= 0 then
            self:CountDownEnd()
        end

    end
end

function MainUiCaptainRebornTip:CountDownEnd()
    self:Hide()

    self.countDownEndTime = nil
    self.currShowTime = nil
end

function MainUiCaptainRebornTip:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnDead'] = Utility.bind_callback(self, self.OnDead)
end

function MainUiCaptainRebornTip:MsgRegist()
    PublicFunc.msg_regist(SceneEntity.CheckReborn, self.bindfunc['OnDead'])
end

function MainUiCaptainRebornTip:MsgUnRegist()
    PublicFunc.msg_unregist(SceneEntity.CheckReborn, self.bindfunc['OnDead'])
end



FightValueChangeUI = Class("FightValueChangeUI" , UiBaseClass)

--[[
    type = ENUM.FightingType.Team. 显示战队战斗力  
    type = ENUM.FightingType.Role. 显示角色战斗力
]]

function FightValueChangeUI.ShowChange(type, newValue, oldValue)
    if newValue == nil or oldValue == nil then
        app.log('FightValueChangeUI.ShowChange ' .. ' ' .. tostring(newValue) .. ' ' .. tostring(oldValue) .. ' ' .. debug.traceback())
        return
    end
    local data = {type = type, new = newValue, old = oldValue}
    if FightValueChangeUI.Inst == nil then
        FightValueChangeUI.Inst = FightValueChangeUI:new(data)
    else
        FightValueChangeUI.Inst:_ShowChange(data)
    end
end

function FightValueChangeUI.EnableShowChange(is)
    if FightValueChangeUI.Inst == nil then
        FightValueChangeUI.Inst = FightValueChangeUI:new()
    end

    return FightValueChangeUI.Inst:_EnableShowChange(is)
end

-- ui/new_fight
local resPath = 'assetbundles/prefabs/ui/new_fight/ui_3402_recommend.assetbundle'

local _uiText = 
{
    [1] = '角色战力';
    [2] = '战队战力';    
}

local _spName = {
    [ENUM.FightingType.Team] = _uiText[2],
    [ENUM.FightingType.Role] = _uiText[1],
}

local animationTime = 1.4 --s

function FightValueChangeUI:Init(data)
    self.pathRes = resPath
    self.data = data
    self.__enableShowChange = true
    UiBaseClass.Init(self, data);
end

function FightValueChangeUI:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['ClearChangeQueue'] = Utility.bind_callback(self, self.ClearChangeQueue);
    --self.bindfunc['UpdateTimer'] = Utility.bind_callback(self, self.UpdateTimer);
    self.bindfunc['_ShowChangeImpl'] = Utility.bind_callback(self, self._ShowChangeImpl);
end

function FightValueChangeUI:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(UiManager.PushUi, self.bindfunc['ClearChangeQueue'])
    PublicFunc.msg_regist(UiManager.PopUi, self.bindfunc['ClearChangeQueue'])
end

function FightValueChangeUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(UiManager.PushUi, self.bindfunc['ClearChangeQueue'])
    PublicFunc.msg_unregist(UiManager.PopUi, self.bindfunc['ClearChangeQueue'])
end

function FightValueChangeUI:ClearChangeQueue()
    --app.log('FightValueChangeUI:ClearChangeQueue')
    self:StopCurrent()
end

function FightValueChangeUI:StopCurrent()

    if not self.IsRun then return end

    self:Hide()
    self.IsRun = false
    self.currentChange = nil

    self.step = 4
end

function FightValueChangeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.fightValueTypeText = ngui.find_label(self.ui, 'lab_fight')
    self.plusLabel = ngui.find_label(self.ui, 'lab_num1')
    self.plusLabel:set_active(true)
    self.minusLabel = ngui.find_label(self.ui, 'lab_num2')
    self.minusLabel:set_active(false)

    self.showNumLabel = ngui.find_label(self.ui, 'lab_font')

    TimerManager.Add(self.bindfunc['_ShowChangeImpl'], 20, -1)

    self.lastShowChangeImplTime = app.get_time()

    self:Hide()
    self:_ShowChange(self.data)
end

function FightValueChangeUI:DestroyUi()
    UiBaseClass.DestroyUi(self)

    self:StopCurrent()
    TimerManager.Remove(self.bindfunc['_ShowChangeImpl'])
end

function FightValueChangeUI:_EnableShowChange(is)
    local old =  self.__enableShowChange
    self.__enableShowChange = is

    return old
end

function FightValueChangeUI:_ShowChange(data)

    if not data or not self.__enableShowChange then
        return
    end

    self.__waitShowChangeData = data
end

function FightValueChangeUI:_ShowChangeImpl()
    local now = app.get_time()
    local dt = now - self.lastShowChangeImplTime
    self.lastShowChangeImplTime = now

    if self.__waitShowChangeData ~= nil then
        self:StopCurrent()
        self:ShowNextChange()
    end

    if self.IsRun then
        self.hasUseTime = self.hasUseTime + dt
        local t = self.hasUseTime/animationTime
        if t > 1 then
            t = 1
        end
        t = Transitions.easeOut(t)

        local nowValue = self.currentChange.old + math.floor(self.totalChange * t)
        self.showNumLabel:set_text(self:FightValueToStr(nowValue))

        if t >= 1 then
            self:StopCurrent()
        end
    end
end

function FightValueChangeUI:FightValueToStr(fv)
    local str = string.format(self.fightValueFormatStr, fv)
    return str
end

function FightValueChangeUI:ShowNextChange()
    if self.ui == nil or self.IsRun == true then
        return
    end

    self.currentChange = self.__waitShowChangeData
    self.__waitShowChangeData = nil

    local maxLen = math.max(tostring(self.currentChange.new):len(), tostring(self.currentChange.old):len())
    self.fightValueFormatStr = "%" .. tostring(maxLen) .. "d"

    self.totalChange = self.currentChange.new - self.currentChange.old
    if self.totalChange == 0 then
        return
    elseif self.totalChange > 0 then
        self.plusLabel:set_active(true)
        self.plusLabel:set_text(string.format("+%d", self.totalChange))
    else

        self.plusLabel:set_active(false)

        --self.minusLabel:set_active(true)
        --self.minusLabel:set_text(string.format("%d", self.totalChange))
    end

    PublicFunc.msg_dispatch('PlayerFightValueChange')

    self:Show()
    self.IsRun = true
    -- self.step = 1
    self.hasUseTime = 0

    self.fightValueTypeText:set_text(_spName[self.currentChange.type])
    self.showNumLabel:set_text(self:FightValueToStr(self.currentChange.old))
end
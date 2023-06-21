
ChatFightSelectBuffUI = Class("ChatFightSelectBuffUI", UiBaseClass)


local _UIText = {
    [1] = "拖动效果至右侧槽位，\n只能给一个角色哦!"
}
local _CountDown = 30
local _heroDrag = "heroDrag"
local _buffDrag = "buffDrag"

function ChatFightSelectBuffUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/chat_fight/ui_5406_yuezhan.assetbundle"
    UiBaseClass.Init(self, data)
end

function ChatFightSelectBuffUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightSelectBuffUI:Restart(data)
    self.fightData = g_dataCenter.chatFight:GetStartFightData()
    local myPid = g_dataCenter.player:GetGID()
    self.roleList = g_dataCenter.chatFight:GetRoleListByPlayerId(myPid)
    self.pressBuffPos = nil

    self.buffIndex = nil
    self.buffId = nil
    self.startSec = _CountDown

    self.cardDataCache = {}

    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightSelectBuffUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_btn_confirm"] = Utility.bind_callback(self, self.on_btn_confirm)
    self.bindfunc["on_press_buff"] = Utility.bind_callback(self, self.on_press_buff)

    self.bindfunc["on_drag_start_buff"] = Utility.bind_callback(self, self.on_drag_start_buff)
    self.bindfunc["on_drag_end_buff"] = Utility.bind_callback(self, self.on_drag_end_buff)
    self.bindfunc["on_drag_move_buff"] = Utility.bind_callback(self, self.on_drag_move_buff)
    self.bindfunc["update_time"] = Utility.bind_callback(self, self.update_time)

    self.bindfunc["on_drag_start_hero"] = Utility.bind_callback(self, self.on_drag_start_hero)
    self.bindfunc["on_drag_end_hero"] = Utility.bind_callback(self, self.on_drag_end_hero)
    self.bindfunc["on_drag_move_hero"] = Utility.bind_callback(self, self.on_drag_move_hero)

    self.bindfunc["on_drag_start_right_buff"] = Utility.bind_callback(self, self.on_drag_start_right_buff)
    self.bindfunc["on_press_right_buff"] = Utility.bind_callback(self, self.on_press_right_buff)
    self.bindfunc["on_drag_move_right_buff"] = Utility.bind_callback(self, self.on_drag_move_right_buff)
end

function ChatFightSelectBuffUI:DestroyUi()
    if self.popUpUi then
        if self.popUpUi.textBuff then
            self.popUpUi.textBuff:Destroy()
            self.popUpUi.textBuff = nil
        end
    end

    if self.textBuff1 then
        self.textBuff1:Destroy()
        self.textBuff1 = nil
    end
    if self.textBuff2 then
        self.textBuff2:Destroy()
        self.textBuff2 = nil
    end

    for k, v in pairs(self.heroList) do
        if v.textBuff then
            v.textBuff:Destroy()
            v.textBuff = nil
        end
        if v.bigCard then
            v.bigCard:DestroyUi()
            v.bigCard = nil
        end
    end

    if self.bigCardClone then
        self.bigCardClone:DestroyUi()
        self.bigCardClone = nil
    end
    TimerManager.Remove(self.bindfunc["update_time"])
    UiBaseClass.DestroyUi(self)
end

function ChatFightSelectBuffUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "center_other/animation/"

    self.lblCountDown = ngui.find_label(self.ui, path .. "sp_biaoti/txt/lab_time")

    self.popUpUi = {
        objCont = self.ui:get_child_by_name(path .. "left/cont"),
        lblBuffName = ngui.find_label(self.ui, path .. "left/cont/lab_2"),
        lblBuffDesc = ngui.find_label(self.ui, path .. "left/cont/lab_1"),
        textBuff = ngui.find_texture(self.ui, path .. "left/cont/texture_buff"),
    }
    self.popUpUi.objCont:set_active(false)

    local lblBuffDescDown = ngui.find_label(self.ui, path .. "left/sp_black/lab")
    lblBuffDescDown:set_text(_UIText[1])
    self.textBuff1 = ngui.find_texture(self.ui, path .. "left/sp_black/btn_1/animation/texture_buff1")
    self.textBuff2 = ngui.find_texture(self.ui, path .. "left/sp_black/btn_2/animation/texture_buff2")
    self.fxBuff = {
        [1] = self.ui:get_child_by_name(path .. "left/sp_black/fx_ui_5406_chose1"),
        [2] = self.ui:get_child_by_name(path .. "left/sp_black/fx_ui_5406_chose2")
    }

    local btnBuff1 = ngui.find_button(self.ui, path .. "left/sp_black/btn_1")
    btnBuff1:set_on_ngui_press(self.bindfunc["on_press_buff"])

    btnBuff1:set_on_dragdrop_start(self.bindfunc["on_drag_start_buff"])
    btnBuff1:set_on_dragdrop_release(self.bindfunc["on_drag_end_buff"])
    btnBuff1:set_on_ngui_drag_move(self.bindfunc["on_drag_move_buff"])
    btnBuff1:set_is_dragdrop_clone(true);
    btnBuff1:set_is_hide_clone(false);

    local btnBuff2 = ngui.find_button(self.ui, path .. "left/sp_black/btn_2")
    btnBuff2:set_on_ngui_press(self.bindfunc["on_press_buff"])

    btnBuff2:set_on_dragdrop_start(self.bindfunc["on_drag_start_buff"])
    btnBuff2:set_on_dragdrop_release(self.bindfunc["on_drag_end_buff"])
    btnBuff2:set_on_ngui_drag_move(self.bindfunc["on_drag_move_buff"])
    btnBuff2:set_is_dragdrop_clone(true);
    btnBuff2:set_is_hide_clone(false);

    self.btnConfirm = ngui.find_button(self.ui, path .. "right/btn_yellow")
    self.btnConfirm:set_on_click(self.bindfunc["on_btn_confirm"])
    self.lblEnemySelect = ngui.find_label(self.ui, path .. "right/lab_difang")
    self.lblEnemySelect:set_active(false)

    self.heroList = {}
    for i = 1,3 do
        local tPath = path .. 'right/cont_list/list' .. i .. '/'
        local obj = self.ui:get_child_by_name(tPath .. "cont_big_item")
        local bigCard = UiBigCard:new({
            parent = obj,
            infoType = 1,
            showAddButton = false,
            showStar = false,
            showLvl = false,
            showFight = false,
            useWhiteName = true,
        })
        bigCard:SetTeamPos(-1)
        bigCard:SetName(_heroDrag .. '_' .. i)
        bigCard:SetDragStart(self.bindfunc["on_drag_start_hero"])
        bigCard:SetDragRelease(self.bindfunc["on_drag_end_hero"])
        bigCard:SetDragMove(self.bindfunc["on_drag_move_hero"])
        bigCard:SetDragClone(true)
        bigCard:SetHideClone(true)

        local btnBuff = ngui.find_button(self.ui, tPath .. "sp_xuanren/texture_buff")
        btnBuff:set_on_ngui_press(self.bindfunc["on_press_right_buff"])

        btnBuff:set_on_dragdrop_start(self.bindfunc["on_drag_start_right_buff"])
        btnBuff:set_on_ngui_drag_move(self.bindfunc["on_drag_move_right_buff"])
        btnBuff:set_on_dragdrop_release(self.bindfunc["on_drag_end_buff"])
        btnBuff:set_is_dragdrop_clone(true);
        btnBuff:set_is_hide_clone(false);

        local textBuff = ngui.find_texture(self.ui, tPath .. "sp_xuanren/texture_buff")
        local fx = self.ui:get_child_by_name(tPath .. "fx_ui_5406_chose1")
        fx:set_active(false)

        textBuff:set_name(_buffDrag.. '_' .. i)
        self.heroList[i] = {
            bigCard = bigCard,
            textBuff = textBuff,
            objFx = fx,
            objList = self.ui:get_child_by_name(path .. 'right/cont_list/list' .. i)
        }
    end


    self.objList4 = self.ui:get_child_by_name(path .. 'right/cont_list/list4')
    self.objList4:set_active(false)
    local obj = self.ui:get_child_by_name(path .. 'right/cont_list/list4/cont_big_item')
    self.bigCardClone = UiBigCard:new({
        parent = obj,
        infoType = 1,
        showAddButton = false,
        showStar = false,
        showLvl = false,
        showFight = false,
        useWhiteName = true,
    })
    self.bigCardClone:EnableClick(false)

    local fxGuide1 = self.ui:get_child_by_name(path .. "left/sp_black/fx_ui_5406_yindao1")
    fxGuide1:set_active(false)
    fxGuide1:set_active(true)
    self.fxGuide2 = self.ui:get_child_by_name(path .. "left/sp_black/fx_ui_5406_yindao2")

    TimerManager.Add(self.bindfunc["update_time"], 1000, _CountDown)
    self:UpdateUI()
end

function ChatFightSelectBuffUI:update_time()
    self.startSec = self.startSec - 1
    if self.startSec >= 0 then
        self.lblCountDown:set_text("00:" .. string.format("%02d", self.startSec))
        if self.startSec == 0 then
            if self.buffIndex and self.buffId then
                --若已选中但未点确认
                --self:on_btn_confirm()
            end
        end
        if self.buffIndex == nil then
            self.fxGuide2:set_active(false)
            self.fxGuide2:set_active(true)
        else
            self.fxGuide2:set_active(false)
        end
    end
end

function ChatFightSelectBuffUI:UpdateUI()
    local cfg = self:GetBuffCfg(1)
    self.textBuff1:set_texture(cfg.icon)
    cfg = self:GetBuffCfg(2)
    self.textBuff2:set_texture(cfg.icon)

    self:UpdateHero()
end

function ChatFightSelectBuffUI:UpdateHero()
    for k, ui in pairs(self.heroList) do
        local cardNumber = self.roleList[k].cardNumber
        local cardData = self:GetCardDataFromCache(cardNumber)
        ui.bigCard:SetData(cardData, 1)
    end
end

function ChatFightSelectBuffUI:GetBuffCfg(pos)
    local buffId = self.fightData.buffData[pos].buffId
    local cfg = ConfigManager.Get(EConfigIndex.t_chat_1v1_buff, buffId)
    return cfg
end

function ChatFightSelectBuffUI:GetCardDataFromCache(number)
    if self.cardDataCache[number] == nil then
        self.cardDataCache[number] = CardHuman:new({number = number, isNotCalProperty = true})
    end
    return self.cardDataCache[number]
end

------------------------------------------------------------------------------------

function ChatFightSelectBuffUI:_getBuffPos(name)
    if name == "btn_1" then
        return 1
    else
        return 2
    end
end

function ChatFightSelectBuffUI:_getStartBuffPos()
    if self.buffId then
        for k, v in pairs(self.fightData.buffData) do
            if v.buffId == self.buffId then
                return k
            end
        end
    end
    return nil
end

function ChatFightSelectBuffUI:_getCurrPos()
    if self.buffIndex then
        return self.buffIndex + 1
    end
    return nil
end

function ChatFightSelectBuffUI:on_press_buff(name, state, x, y, go_obj)
    if state then
        for _, fx in pairs(self.fxBuff) do
            fx:set_active(false)
        end
        self.popUpUi.objCont:set_active(true)
        local pos = self:_getBuffPos(name)
        local cfg = self:GetBuffCfg(pos)
        self.popUpUi.lblBuffName:set_text(cfg.name or '')
        self.popUpUi.lblBuffDesc:set_text(cfg.desc or '')
        self.popUpUi.textBuff:set_texture(cfg.icon)
    else
        self.popUpUi.objCont:set_active(false)
    end
    for _, ui in pairs(self.heroList) do
        ui.objFx:set_active(state)
    end
end

function ChatFightSelectBuffUI:on_drag_start_buff(src)
    local str = string.gsub(src:get_name(), "%(Clone%)", "")
    self.startBuffPos = self:_getBuffPos(str)
    for _, ui in pairs(self.heroList) do
        ui.objFx:set_active(true)
    end
end

function ChatFightSelectBuffUI:on_drag_move_buff()
    for _, ui in pairs(self.heroList) do
        ui.objFx:set_active(true)
    end
    self.popUpUi.objCont:set_active(true)
end

function ChatFightSelectBuffUI:on_drag_end_buff(src, tar)
    for _, ui in pairs(self.heroList) do
        ui.objFx:set_active(false)
    end
    self.popUpUi.objCont:set_active(false)

    local str = Utility.lua_string_split(tar:get_name(), '_')
    if str[1] ~= _buffDrag then
        return
    end

    if self.startBuffPos then
        local tarPos = tonumber(str[2])
        local name = _buffDrag .. '_' .. tarPos

        for k, v in pairs(self.heroList) do
            if v.textBuff:get_name() == name then
                local cfg = self:GetBuffCfg(self.startBuffPos)
                v.textBuff:set_texture(cfg.icon)
            else
                v.textBuff:clear_texture()
            end
        end
        --self.buffIndex = self.roleList[tarPos].index
        self.buffIndex = tarPos - 1
        self.buffId = self.fightData.buffData[self.startBuffPos].buffId
        self:on_btn_confirm()
    end
    self.startBuffPos = nil
end

function ChatFightSelectBuffUI:on_drag_start_right_buff(src)
    if self.buffIndex == nil or self.buffId == nil then
        return
    end
    local str = string.gsub(src:get_name(), "%(Clone%)", "")
    str = Utility.lua_string_split(str, '_')
    if str[1] ~= _buffDrag then
        return
    end
    self.__sPos = tonumber(str[2])
    if self:_getCurrPos() == self.__sPos then
        self.startBuffPos = self:_getStartBuffPos()
        for k, ui in pairs(self.heroList) do
            ui.objFx:set_active(k ~= self.__sPos)
        end
    end
end

function ChatFightSelectBuffUI:on_press_right_buff(name, state, x, y, go_obj)
    if self.buffIndex == nil or self.buffId == nil then
        return
    end

    local str = Utility.lua_string_split(name, '_')
    if str[1] ~= _buffDrag then
        return
    end
    self.__sPos = tonumber(str[2])
    if state then
        if self.__sPos ~= self:_getCurrPos() then
            return
        end
    end
    for k, ui in pairs(self.heroList) do
        if state then
            ui.objFx:set_active(k ~= self.__sPos)
        else
            ui.objFx:set_active(state)
        end
    end
end

function ChatFightSelectBuffUI:on_drag_move_right_buff()
    if self.buffIndex == nil or self.buffId == nil then
        return
    end
    if self:_getCurrPos() == self.__sPos then
        for k, ui in pairs(self.heroList) do
            ui.objFx:set_active(k ~= self.__sPos)
        end
    end
end

------------------------------------------------------------------------------------

function ChatFightSelectBuffUI:on_drag_start_hero(src)
    local str = string.gsub(src:get_name(), "%(Clone%)", "")
    str = Utility.lua_string_split(str, '_')
    if str[1] ~= _heroDrag then
        return
    end
    self.startHeroPos = tonumber(str[2])
    local cardNumber = self.roleList[self.startHeroPos].cardNumber
    local cardData = self:GetCardDataFromCache(cardNumber)
    self.bigCardClone:SetData(cardData, 1)
    self.objList4:set_active(true)
end

function ChatFightSelectBuffUI:on_drag_end_hero(src, tar)
    self.objList4:set_active(false)
    local str = Utility.lua_string_split(tar:get_name(), '_')
    if str[1] ~= _heroDrag then
        return
    end
    local tarPos = tonumber(str[2])

    if self.startHeroPos then
        --交换
        local temp = self.roleList[self.startHeroPos]
        self.roleList[self.startHeroPos] = self.roleList[tarPos]
        self.roleList[tarPos] = temp
        self:UpdateHero()
    end
    self.startHeroPos = nil

    self:on_btn_confirm()
end

function ChatFightSelectBuffUI:on_drag_move_hero(name, x, y, goObj)
    local x, y, z = Root.get_ui_camera():screen_to_world_point(x, y, 0)
    self.objList4:set_position(x, y, 0)
end

function ChatFightSelectBuffUI:on_btn_confirm(t)
    local paraList = {}
    for k, v in pairs(self.roleList) do
        paraList[k] = v.index
    end
    if self.buffIndex == nil or self.buffId == nil then
        return
    end
    paraList[4] = self.buffIndex
    paraList[5] = self.buffId

    msg_1v1.cg_select_choose(self.fightData.roomId, ENUM.ChatFightSelectState.Buff, paraList, t~= nil)

    if t ~= nil then
        self.lblEnemySelect:set_active(true)
        self.btnConfirm:set_active(false)
    end
end
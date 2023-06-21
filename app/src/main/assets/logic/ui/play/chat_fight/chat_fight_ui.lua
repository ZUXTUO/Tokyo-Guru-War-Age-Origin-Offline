
ChatFightUI = Class("ChatFightUI", UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/new_fight_yue_zhan.assetbundle";

function ChatFightUI.GetResList()
    return {res}
end

function ChatFightUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function ChatFightUI:InitData(data)
    self.flags = {g_dataCenter.fight_info.single_friend_flag, g_dataCenter.fight_info.single_enemy_flag}
    self.dt = 0
    UiBaseClass.InitData(self, data)
end

function ChatFightUI:Restart(data)
    self.cardDataCache = {}
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["gc_chat_1v1_round_end"] = Utility.bind_callback(self, self.gc_chat_1v1_round_end)
    self.bindfunc["show_round_ui"] = Utility.bind_callback(self, self.show_round_ui)
    self.bindfunc["screen_play"] = Utility.bind_callback(self, self.screen_play)
end

function ChatFightUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_fight.gc_chat_1v1_round_end, self.bindfunc['screen_play'])
end

function ChatFightUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_fight.gc_chat_1v1_round_end, self.bindfunc['screen_play'])
end

function ChatFightUI:DestroyUi()
    if self.smallCardLeft then
        self.smallCardLeft:DestroyUi()
        self.smallCardLeft = nil
    end
    if self.textBuffLeft then
        self.textBuffLeft:Destroy()
        self.textBuffLeft = nil
    end

    if self.smallCardRight then
        self.smallCardRight:DestroyUi()
        self.smallCardRight = nil
    end
    if self.textBuffRight then
        self.textBuffRight:Destroy()
        self.textBuffRight = nil
    end

    for _, v in pairs(self.allHero) do
        for _, hero in pairs(v) do
            if hero.smallCard then
                hero.smallCard:DestroyUi()
                hero.smallCard = nil
            end
            if hero.textBuff then
                hero.textBuff:Destroy()
                hero.textBuff = nil
            end
        end
    end
    TimerManager.Remove(self.bindfunc["show_round_ui"])
    TimerManager.Remove(self.bindfunc["gc_chat_1v1_round_end"])
    UiBaseClass.DestroyUi(self)
end

function ChatFightUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
        local path = "centre_other/"

        local _obj = self.ui:get_child_by_name(path .. "left_big_card_item")
        self.smallCardLeft = SmallCardUi:new({parent = _obj,
            stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity }
        })
        self.textBuffLeft = ngui.find_texture(_obj, "texture_buff")

        _obj = self.ui:get_child_by_name(path .. "right_big_card_item")
        self.smallCardRight = SmallCardUi:new({parent = _obj,
            stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity }
        })
        self.textBuffRight = ngui.find_texture(_obj, "texture_buff")

        self.lblCountDown = ngui.find_label(self.ui, path .. "lab_time")
        self.proList = {}
        self.proList[1] = ngui.find_progress_bar(self.ui, path .. "pro_di_blue")
        self.proList[2] = ngui.find_progress_bar(self.ui, path .. "pro_di_red")

        self.allHero = {}
        local headPath = {"grid_left_head", "grid_right_head"}
        for k, v in pairs(headPath) do
            local heroList = {}
            for i = 1, 2 do
                local _path = path .. v .. '/cont_head' .. i .. '/'
                local _obj = self.ui:get_child_by_name(_path .. "big_card_item_80")
                heroList[i] = {
                    spFrame = ngui.find_sprite(self.ui, _path .. "sp_kuang"),
                    spGou = ngui.find_sprite(self.ui, _path .. "sp_gou"),
                    smallCard = SmallCardUi:new({parent = _obj,
                        stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Aptitude, SmallCardUi.SType.Rarity }
                    }),
                    textBuff = ngui.find_texture(self.ui, _path .. "texture_buff")
                }
            end
            self.allHero[k] = heroList
        end

    self:UpdateUI()
    local currRound =  g_dataCenter.chatFight:GetCurrRound()
    TimerManager.Add(self.bindfunc["show_round_ui"], 1500, 1, currRound)
end

function ChatFightUI:show_round_ui(round)
    ChatFightRoundUI.Start(round)
    self:UpdateUI()
    --初始血量
    for k, v in pairs(self.proList) do
        v:set_value(1)
    end
end

function ChatFightUI:screen_play(round)
    --先通知对象over
    local ret = g_dataCenter.chatFight:GetResult(round,  g_dataCenter.player:GetGID())
    if ret == ENUM.ChatFightResult.Success then
        ObjectManager.OnFightOver(true)
    elseif ret == ENUM.ChatFightResult.Fail then
        ObjectManager.OnFightOver(false)
    else
        ObjectManager.OnFightOver(true)
    end
    --然后通知uiover
    if not ScreenPlay.IsRun() then
        TimerManager.Add(self.bindfunc["gc_chat_1v1_round_end"], 400, 1, round)
    else
        ScreenPlay.SetCallback(function ()
            TimerManager.Add(self.bindfunc["gc_chat_1v1_round_end"], 400, 1, round)
        end);
    end
end

function ChatFightUI:gc_chat_1v1_round_end(round)
    local ret = g_dataCenter.chatFight:GetResult(round,  g_dataCenter.player:GetGID())
    if ret == ENUM.ChatFightResult.Success then
        CommonKuikuliyaWinUI.Start()
        --血量置空
        self.proList[2]:set_value(0)
    elseif ret == ENUM.ChatFightResult.Fail then
        CommonZuozhanshibai.Start()
        self.proList[1]:set_value(0)
    else
        CommonFightDrawUI.Start()
    end
    --第一轮，第二轮结束
    if round == 1 or round == 2 then
        TimerManager.Add(self.bindfunc["show_round_ui"], 2500, 1, round + 1)
    end
end

function ChatFightUI:UpdateUI()
    local currRound =  g_dataCenter.chatFight:GetCurrRound()

    local roleList = g_dataCenter.chatFight:GetFightRoleList()
    local __data = roleList[1][currRound]
    local number = __data.number
    self.smallCardLeft:SetData(self:GetCardDataFromCache(number))
    self:SetBuffIcon(self.textBuffLeft, __data.buffId)

    __data = roleList[2][currRound]
    number = __data.number
    self.smallCardRight:SetData(self:GetCardDataFromCache(number))
    self:SetBuffIcon(self.textBuffRight, __data.buffId)

    for i = 1, 2 do
        local heroListUI = self.allHero[i]
        local _list = self:GetHeroNumberList(currRound, roleList[i])
        for j = 1, 2 do
            local item = heroListUI[j]
            item.smallCard:SetData(self:GetCardDataFromCache(_list[j].number))
            self:SetBuffIcon(item.textBuff, _list[j].buffId)

            item.spFrame:set_active(false)
            item.spGou:set_active(false)
            if currRound == 1 then

            elseif currRound == 2 then
                --第一个英雄
                if j == 1 then
                    self:SetHeroKillInfo(item, _list[j].result)
                end
            elseif currRound == 3 then
                self:SetHeroKillInfo(item, _list[j].result)
            end
        end
    end
end

function ChatFightUI:SetHeroKillInfo(item, result)
    item.spFrame:set_active(true)
    item.spGou:set_active(true)
    item.smallCard:SetGray(true)

    if result == ENUM.ChatFightResult.Success then
        item.spFrame:set_sprite_name("zd_yuezhan_kuang2")
        item.spGou:set_sprite_name("zd_yuezhan_gou")
    elseif result == ENUM.ChatFightResult.Fail then
        item.spFrame:set_sprite_name("zd_yuezhan_kuang1")
        item.spGou:set_sprite_name("zd_yuezhan_cha")
    else
        item.spFrame:set_sprite_name("zd_yuezhan_kuang3")
        item.spGou:set_sprite_name("zd_yuezhan_pingju")
    end
end

function ChatFightUI:SetBuffIcon(textBuff, buffId)
    if buffId then
        textBuff:set_active(true)
        local cfg = ConfigManager.Get(EConfigIndex.t_chat_1v1_buff, buffId)
        textBuff:set_texture(cfg.icon)
    else
        textBuff:set_active(false)
    end
end

function ChatFightUI:GetHeroNumberList(currRound, list)
    local temp = {}
    for k, v in pairs(list) do
        if currRound ~= k then
            table.insert(temp, v)
        end
    end
    return temp
end

function ChatFightUI:GetCardDataFromCache(number)
    if self.cardDataCache[number] == nil then
        self.cardDataCache[number] = CardHuman:new({number = number, isNotCalProperty = true})
        --头像设置为金色
        self.cardDataCache[number].realRarity = ENUM.EHeroRarity.Orange
    end
    return self.cardDataCache[number]
end

function ChatFightUI:UpdatePro()
    if self.proList == nil then
        return
    end
    for i = 1, 2 do
        local names = g_dataCenter.fight_info:GetHeroList(self.flags[i])
        for _, name in pairs(names) do
            local obj = ObjectManager.GetObjectByName(name)
            if obj then
                local max = obj:GetPropertyVal('max_hp')
                local cur = obj:GetPropertyVal('cur_hp')
                if obj:GetOwnerPlayerGID() == g_dataCenter.player:GetGID() then
                    self.proList[1]:set_value(cur / max)
                else
                    self.proList[2]:set_value(cur / max)
                end
            end
        end
    end
end

function ChatFightUI:UpdateTimer()
    if self.lblCountDown then
        local time = FightManager.GetFightTime()
        self.lblCountDown:set_text(tostring(time))
    end
end

function ChatFightUI:Update(dt)
    if self.ui == nil then return end
    self.dt = self.dt + dt
    if self.dt >= 1 then
        self.dt = 0
        self:UpdateTimer()
    end
    self:UpdatePro()
end
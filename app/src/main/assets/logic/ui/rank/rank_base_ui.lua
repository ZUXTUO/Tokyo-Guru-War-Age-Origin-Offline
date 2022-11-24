-- 玩法排行榜界面基础类
RankBaseUI = Class('RankBaseUI', UiBaseClass);

local _UIText = {
    ["champion_index"]  = "第%s界",
    ["tips_nodata"]     = "没有排行数据",
    ["tips_loading"]    = "正在加载...",

    ["my_fight_value"]  = "当前战斗力[FFB400]%s[-]",
	["my_floor_level"]  = "当前最高层数[FFB400]%s[-]",
	["my_point_value"]  = "当前积分[FFB400]%s[-]",
	["my_rank_index"]   = "我的排名[FFB400]%s[-]",

    ["fight_value"]     = "战斗力 [FFB400]%s[-]",
    ["team_level"]      = "战队等级 [FFB400]%s[-]",
    ["floor_level"]     = "最高层数 [FFB400]%s[-]",
    ["integral"]        = "积分 [FFB400]%s[-]",

    ["arena_name"]      = "竞技场",
    ["qtjd_name"]       = "攻防战",
    ["fuzion_name"]     = "大乱斗",
    ["ultimate_name"]   = "极限挑战",
}

RankBaseUI.ERankType = {
    Arena       = 1,    --竞技场
    Qtjd        = 2,    --3V3
    Fuzion      = 3,    --大乱斗
    Ultimate    = 4,    --极限挑战
}

-- 设置某个视图参数
-- index            页签组索引
-- data             对应视图数据
function RankBaseUI:SetViewData(index, data)
    if not index or not data then return end
    self:UpdateViewData(index, data)
    self:UpdateUi(index)
end

-- 设置视图回调函数
-- viewCallback     回调函数更新视图数据（选填，配合SetViewData使用）
function RankBaseUI:SetViewCallback(viewCallback)
    self.viewCallback = viewCallback
end

-- 设置视图组数据
-- viewGroupData    视图数据 (必填)
-- {
--     {
--         --排行榜数据 (选填, 可在viewCallback回调时设置排行数据)
--         {
--             playerid     =, (必填)
--             playerName   =, (必填)
--             value        =, (必填 不同玩法有不同的值，可能是战斗力/积分/爬塔层数/战队等级)
--             ranking      =, (必填)
--             heroCids     =, (必填, 英雄配置id, 1个或3个id参数格式为{xxx,xxx,xxx})

--             -- championIdx  =, (选填, 历史冠军'第X界')
--         },
--         ...

--         text_group   = {} -- 底部5个文本组
--         text_value   = {} -- 底部5个文本组对应的值
--         view_name    = "" -- 视图页签显示名字
--         view_type    = 1 -- 视图类型 1通用排行（默认） 2历史冠军排行
--         team_type    = 1 -- 玩法阵型枚举值
--         rank_type    = 1 -- 玩法排行榜类型 参见:RankBaseUI.ERankType
--     },
--     ...
-- }
function RankBaseUI:SetViewGroupData(viewGroupData)
    self.viewGroupData = viewGroupData
end

function RankBaseUI:IsInitGroupData()
    return self.viewGroupData ~= nil
end

function RankBaseUI:LoadDataViewName(viewGroupData)
    for i, viewData in ipairs(viewGroupData) do
        local rank_type = viewData.rank_type

        --竞技场
        if rank_type == RankBaseUI.ERankType.Arena then
            viewData.view_name = _UIText["arena_name"]
        --极限挑战
        elseif rank_type == RankBaseUI.ERankType.Ultimate then
            viewData.view_name = _UIText["ultimate_name"]
        --3V3
        elseif rank_type == RankBaseUI.ERankType.Qtjd then
            viewData.view_name = _UIText["qtjd_name"]
        --大乱斗
        elseif rank_type == RankBaseUI.ERankType.Fuzion then
            viewData.view_name = _UIText["fuzion_name"]
        end
    end
end

function RankBaseUI:LoadDataTextGroup(viewData)
    local rank_type = viewData.rank_type

    if viewData.text_group == nil then
        viewData.text_group = {}
        --竞技场
        if rank_type == RankBaseUI.ERankType.Arena then
            table.insert(viewData.text_group, _UIText["my_fight_value"])
            table.insert(viewData.text_group, _UIText["my_rank_index"])
        --极限挑战
        elseif rank_type == RankBaseUI.ERankType.Ultimate then
            table.insert(viewData.text_group, _UIText["my_floor_level"])
            table.insert(viewData.text_group, _UIText["my_rank_index"])
        --3V3
        elseif rank_type == RankBaseUI.ERankType.Qtjd then
            table.insert(viewData.text_group, _UIText["my_rank_index"])
            table.insert(viewData.text_group, _UIText["my_point_value"])
        --大乱斗
        elseif rank_type == RankBaseUI.ERankType.Fuzion then
            table.insert(viewData.text_group, _UIText["my_point_value"])
            table.insert(viewData.text_group, _UIText["my_rank_index"])
        end
    end

    if viewData.team_type == nil then
        viewData.team_type = ENUM.ETeamType.normal
        --竞技场
        if rank_type == RankBaseUI.ERankType.Arena then
            viewData.team_type = ENUM.ETeamType.arena
        --极限挑战
        elseif rank_type == RankBaseUI.ERankType.Ultimate then
            viewData.team_type = ENUM.ETeamType.normal
        --3V3
        elseif rank_type == RankBaseUI.ERankType.Qtjd then
            viewData.team_type = ENUM.ETeamType.normal
        --大乱斗
        elseif rank_type == RankBaseUI.ERankType.Fuzion then
            viewData.team_type = ENUM.ETeamType.normal
        end
    end

	if viewData.text_value == nil then
        viewData.text_value = {}
    end

    if viewData.view_type == nil then
        viewData.view_type = 1
    end

    return viewData
end

function RankBaseUI:GetTextValue(rank_type, value)
    local str = _UIText["integral"]

    --竞技场
    if rank_type == RankBaseUI.ERankType.Arena then
        str = _UIText["fight_value"]
    --极限挑战
    elseif rank_type == RankBaseUI.ERankType.Ultimate then
        str = _UIText["floor_level"]
    --3V3
    elseif rank_type == RankBaseUI.ERankType.Qtjd then
        str = _UIText["integral"]
    --大乱斗
    elseif rank_type == RankBaseUI.ERankType.Fuzion then
        str = _UIText["integral"]
    end

    return string.format(str, value)
end

function RankBaseUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/rank/ui_401_rank.assetbundle";
    UiBaseClass.Init(self, data);
end

function RankBaseUI:Restart(data)
    UiBaseClass.Restart(self, data)
end

function RankBaseUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.curIndex = 0
    self.curViewData = nil
    self.viewGroupData = nil
end

function RankBaseUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["btn_item_click"] = Utility.bind_callback(self, RankBaseUI.btn_item_click);
    self.bindfunc["on_tab_change"] = Utility.bind_callback(self, RankBaseUI.on_tab_change)
    self.bindfunc["on_player_btn"] = Utility.bind_callback(self, self.on_player_btn)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item)
end

function RankBaseUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("rank_Ui");

    self.labGroup = {}
    self.tabGroup = {}
    self.items = {}
    self.curIndex = 1

    local path = "center_other/animation/content/"
    self.labGroup[1] = ngui.find_label(self.ui, path.."lab1")
    self.labGroup[2] = ngui.find_label(self.ui, path.."lab2")
    self.labGroup[3] = ngui.find_label(self.ui, path.."lab3")
    self.labGroup[4] = ngui.find_label(self.ui, path.."lab4")
    self.labGroup[5] = ngui.find_label(self.ui, path.."lab")

    path = "center_other/animation/cont/"
    self.tabBaseObj = self.ui:get_child_by_name(path.."yeka1")
    self.tabBaseObj:set_active(false)

    path = "center_other/animation/scroll_view1/panel_list/"
    self.scrollView = ngui.find_scroll_view(self.ui, path)
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    path = "center_other/animation/scroll_view1/"
    self.labContentTips = ngui.find_label(self.ui, path..'txt')

    self:LoadTabGroup()
    self:LoadRankView()
    self:UpdateUi()
end

function RankBaseUI:ResetWrapContent()
    local viewData = self.curViewData or {}
    self.wrapContent:set_min_index(1 - #viewData)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
end

function RankBaseUI:LoadTabGroup()
    if not self.viewGroupData then return end

    self:LoadDataViewName(self.viewGroupData)

    for i, viewData in ipairs(self.viewGroupData) do
        local name = tostring(i)
        self.tabGroup[i] = {}
        self.tabGroup[i].self = self.tabBaseObj:clone()
        self.tabGroup[i].self:set_name( name )
        self.tabGroup[i].self:set_active(true)
        
        self.tabGroup[i].toggle = ngui.find_toggle(self.tabGroup[i].self, name)
        self.tabGroup[i].spRed = ngui.find_sprite(self.tabGroup[i].self, "sp_prompt")
        self.tabGroup[i].labName = ngui.find_label(self.tabGroup[i].self, "lab")
       
        --TODO 暂时隐藏红点
        self.tabGroup[i].spRed:set_active(false)
        self.tabGroup[i].toggle:set_on_change(self.bindfunc["on_tab_change"])
        self.tabGroup[i].labName:set_text(viewData.view_name or "")
    end
end

function RankBaseUI:LoadRankView()
    if not self.viewGroupData then return end

    local viewData = self.viewGroupData[self.curIndex]
    if viewData.isinit == nil then
        self:LoadDataTextGroup(viewData)
        viewData.isinit = true
    end
    if viewData.loaddata == nil and #viewData > 0 then
        viewData.loaddata = true
    end
    --没有排行数据，向服务器发请求
    if viewData.loaddata == nil and self.viewCallback then
        Utility.CallFunc(self.viewCallback, self.curIndex, viewData.rank_type)
    end

    self.curViewData = viewData
    self:ResetWrapContent()
end

function RankBaseUI:UpdateViewData(index, viewData)
    if not self.ui then return end

    local oldViewData = self.viewGroupData[index]
    if oldViewData and oldViewData.isinit then
        viewData.rank_type = viewData.rank_type or oldViewData.rank_type
        viewData.text_group = viewData.text_group or oldViewData.text_group
        viewData.text_value = viewData.text_value or oldViewData.text_value
        viewData.view_type = viewData.view_type or oldViewData.view_type
        viewData.team_type = viewData.team_type or oldViewData.team_type
        viewData.isinit = oldViewData.isinit
        viewData.loaddata = true
    elseif viewData.isinit == nil then
        self:LoadDataTextGroup(viewData)
        viewData.isinit = true
        viewData.loaddata = true
    end

    self.viewGroupData[index] = viewData
    if index == self.curIndex then
        self.curViewData = viewData
    end

    self:ResetWrapContent()
end

function RankBaseUI:UpdateUi(index)
    if not self.ui then return end
    if index and index ~= self.curIndex then return end

    if self.curViewData then
        for i=1, 5 do
            local format = self.curViewData.text_group[i]
            local value = self.curViewData.text_value[i]
            local str = ""
            if format and value then
                str = string.format(format, value)
            end
            self.labGroup[i]:set_text(str)
        end

        if self.curViewData.loaddata then
            if self.curViewData[1] == nil then
                self.labContentTips:set_active(true)
                self.labContentTips:set_text(_UIText["tips_nodata"])
            else
                self.labContentTips:set_active(false)
            end
        else
            self.labContentTips:set_active(true)
            self.labContentTips:set_text(_UIText["tips_loading"])
        end
    end
end

function RankBaseUI:DestroyUi()
    self.curIndex = 0
    self.curViewData = nil
    self.tabGroup = nil
    self.labGroup = nil
    self.tabGroupData = nil
    self.viewGroupData = nil

    if self.items then
        for k, item in pairs(self.items) do
            for i, card in ipairs(item) do
                card:DestroyUi()
            end
        end
        self.items = nil
    end

    UiBaseClass.DestroyUi(self);
end

function RankBaseUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;

    local item = self.items[b]
    if not item then
        local objNode1 = obj:get_child_by_name("cont1")
        local objNode2 = obj:get_child_by_name("cont2")
        
        item = {}
        item.objNode1 = objNode1
        item.objNode2 = objNode2
        item.labChampionidx = ngui.find_label(objNode2, "sp_win/lab")
        item.spRank123 = ngui.find_sprite(objNode1, "sp_win")
        item.labRankOther = ngui.find_label(objNode1, "lab")
        item.spRankOther = ngui.find_sprite(objNode1, "lab/sp_win_diban")
        item.spPlayerMe = ngui.find_sprite(obj, "sp_bk/sp_myself")
        item.btnPlayer = ngui.find_button(obj, "btn_name")
        item.labPlayer = ngui.find_label(obj, "btn_name/lab_name")
        item.labLevel = ngui.find_label(obj, "sp_bk/lab_id")
        item.labFight = ngui.find_label(obj, "sp_bk/lab_fight")
        item.labId = ngui.find_label(obj, "lab_id")
        local objNode3 = obj:get_child_by_name("content_skill")
        -- item.labKillNum = ngui.find_label(objNode3, "sp_skill/lab")
        -- item.labDeadNum = ngui.find_label(objNode3, "sp_die/lab")

        --隐藏无用的
        if item.labId then item.labId:set_active(false) end
        if objNode3 then objNode3:set_active(false) end

        item.cards = {}
        for i=1, 3 do
            local objCard = obj:get_child_by_name("big_card_item_80"..i)
            item.cards[i] = SmallCardUi:new({parent = objCard, sgroup = 2})
            item.cards[i]:Hide()
        end

        self.items[b] = item
    end

    local viewData = self.curViewData or {}
    local data = viewData[index]
    if data then
        if viewData.view_type == 1 then
            item.objNode1:set_active(true)
            item.objNode2:set_active(false)
        elseif viewData.view_type == 2 then
            item.objNode1:set_active(false)
            item.objNode2:set_active(true)
        end

        if data.ranking > 0 and data.ranking < 4 then
            item.spRank123:set_active(true)
            item.labRankOther:set_active(false)
            PublicFunc.SetRank123Sprite(item.spRank123, data.ranking)
        else
            item.spRank123:set_active(false)
            item.labRankOther:set_active(true)
            item.labRankOther:set_text(tostring(data.ranking))
        end

        if data.playerid == g_dataCenter.player.playerid then
            item.spPlayerMe:set_active(true)
            item.btnPlayer:set_active(false)
        else
            item.spPlayerMe:set_active(false)
            item.btnPlayer:set_active(true)
            item.labPlayer:set_text(data.playerName)
            item.btnPlayer:reset_on_click()
            item.btnPlayer:set_on_click(self.bindfunc["on_player_btn"])
            item.btnPlayer:set_event_value(data.playerid, 0)
        end

        local valueStr = self:GetTextValue(viewData.rank_type, data.value)
        item.labFight:set_text(valueStr)

        local heroCnt = data.heroCids and #data.heroCids or 0
        if heroCnt == 0 then
            for i, card in ipairs(item.cards) do
                card:Hide()
            end
        elseif heroCnt == 1 then
            for i, card in ipairs(item.cards) do
                if i == 2 then
                    card:Show()
                    local info = PublicFunc.CreateCardInfo(data.heroCids[1])
                    card:SetData(info)
                else
                    card:Hide()
                end
            end
        else
            for i, card in ipairs(item.cards) do
                local info = PublicFunc.CreateCardInfo(data.heroCids[i] or 0)
                if info then
                    card:Show()
                    card:SetData(info)
                else
                    card:Hide()
                end
            end
        end

        if data.championIdx then
            self.labChampionidx:set_text(tostring(data.championIdx))
        end
    end
end

function RankBaseUI:on_player_btn(t)
    local playerid = t.string_value
    local teamType = self.curViewData.team_type
    OtherPlayerPanel.ShowPlayer(playerid, teamType)
end

function RankBaseUI:on_tab_change(value, name)
    if value then
        local index = tonumber(name)
        if index == self.curIndex then return end

        self.curIndex = index
        self:LoadRankView()
        self:UpdateUi()
    end
end

return RankBaseUI

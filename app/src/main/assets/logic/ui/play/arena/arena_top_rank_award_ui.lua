ArenaTopRankAwardUI = Class("ArenaTopRankAwardUI", UiBaseClass)

local _local = {}
_local.UIText = {
    [1] = "%s名好友在此",
}


function ArenaTopRankAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4407_jjc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaTopRankAwardUI:InitData(data)
	UiBaseClass.InitData(self, data);

    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    self.topConfig = {}
    local climb_reward = ConfigManager._GetConfigTable(EConfigIndex.t_arena_climb_reward)
    local reverse_order = function (A, B)
        if A == nil or B == nil then return false end
        return A > B
    end
    for k, v in pairs_key(climb_reward, reverse_order) do
        table.insert(self.topConfig, v)
    end

end

function ArenaTopRankAwardUI:Restart(data)
	UiBaseClass.Restart(self, data);
    msg_activity.cg_arena_request_climb_reward_data()
end

function ArenaTopRankAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['on_drag_start'] = Utility.bind_callback(self, self.on_drag_start)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self,self.on_btn_close)
    self.bindfunc['on_btn_get_award'] = Utility.bind_callback(self, self.on_btn_get_award)
    self.bindfunc['on_chick_friend'] = Utility.bind_callback(self, self.on_chick_friend)
    self.bindfunc['on_init_item'] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc['gc_arena_get_climb_reward'] = Utility.bind_callback(self, self.gc_arena_get_climb_reward)
    self.bindfunc['gc_arena_request_climb_reward_data'] = Utility.bind_callback(self, self.gc_arena_request_climb_reward_data)
end

function ArenaTopRankAwardUI:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_activity.gc_arena_get_climb_reward, self.bindfunc["gc_arena_get_climb_reward"])
    PublicFunc.msg_regist(msg_activity.gc_arena_request_climb_reward_data, self.bindfunc["gc_arena_request_climb_reward_data"])
end

function ArenaTopRankAwardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_activity.gc_arena_get_climb_reward, self.bindfunc["gc_arena_get_climb_reward"])
    PublicFunc.msg_unregist(msg_activity.gc_arena_request_climb_reward_data, self.bindfunc["gc_arena_request_climb_reward_data"])
end


function ArenaTopRankAwardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_top_rank_award");

    self.items = {}
    self.uiTotalItems = {}
    self.friendList = {} 
    self.moveUpdateSize = 0
    local friend_list = g_dataCenter.friend.friend_list
    if friend_list then
        for i, friend in pairs(friend_list) do
            local top_rank = friend.arena_history_top_rank or 0
            if top_rank > 0 then
                for j, data in pairs(self.topConfig) do
                    local lastData = self.topConfig[j+1]
                    if top_rank <= data.rank_index and (lastData == nil or top_rank > lastData.rank_index) then
                        if not self.friendList[j] then
                            self.friendList[j] = {}
                        end
                        table.insert(self.friendList[j], friend)
                        break;
                    end
                end
            end
        end
    end

    local path = "centre_other/animation/content/"

    self.labTopRank = ngui.find_label(self.ui, path.."sp_art_font1/sp_font_lab")
    for i=1, 4 do
        local objItem = self.ui:get_child_by_name(path.."cont_grid/big_card_item_80"..i)
        self.uiTotalItems[i] = UiSmallItem:new({parent=objItem})
        self.uiTotalItems[i]:SetEnablePressGoodsTips(true)
    end
     
    self.btn_close = ngui.find_button(self.ui, "btn_cha")
    self.btn_close:set_on_click(self.bindfunc["on_btn_close"])
    
    path = "centre_other/animation/content/scroll_view/"
    self.svList = ngui.find_scroll_view(self.ui, path.."panel_list")
    self.wcList = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
    self.wcList:set_on_initialize_item(self.bindfunc["on_init_item"])
    self.svList:set_on_drag_started(self.bindfunc['on_drag_start'])
    
    self:ResetList()
    self:UpdateUi()
end

function ArenaTopRankAwardUI:DestroyUi()
    if self.uiTotalItems then
        for i, uiItem in pairs(self.uiTotalItems) do
            uiItem:DestroyUi()
        end
        self.uiTotalItems = nil
    end
    if self.items then
        for i, item in pairs(self.items) do
            for i, uiItem in pairs(item.uiItems) do
                uiItem:DestroyUi()
            end
            item.uiCardFriend:DestroyUi()
        end
        self.items = nil
    end
    
    UiBaseClass.DestroyUi(self);
end

function ArenaTopRankAwardUI:ResetList()
    if not self.wcList or not self.svList then return end
    
    self.offset = 0
    local historyTopRank = self.dataCenter:GetMyHistoryTopRank()
    local flag = self.dataCenter:GetReceivedTopRewardFlag()
    if historyTopRank > 0 then
        local index = 0
        for i, v in ipairs(self.topConfig) do
            if historyTopRank <= v.rank_index and not flag[v.rank_index] then
                index = i
                break;
            elseif historyTopRank > v.rank_index then
                index = i - 1
                break;
            end
        end
        if index > 0 then
            if index + 4 >= #self.topConfig then
                self.offset = #self.topConfig - 4
            else
                self.offset = index - 1
            end
        end
    end

    self.wcList:set_min_index(0 - self.offset);
	self.wcList:set_max_index(#self.topConfig - 1 - self.offset);
	self.wcList:reset()
    self.svList:reset_position()
end

function ArenaTopRankAwardUI:MoveUpdateOffset()
    local offset = 0
    local historyTopRank = self.dataCenter:GetMyHistoryTopRank()
    local flag = self.dataCenter:GetReceivedTopRewardFlag()
    if historyTopRank > 0 then
        local index = 0
        for i, v in ipairs(self.topConfig) do
            if historyTopRank <= v.rank_index and not flag[v.rank_index] then
                index = i
                break;
            elseif historyTopRank > v.rank_index then
                index = i - 1
                break;
            end
        end
        if index > 0 then
            if index + 4 >= #self.topConfig then
                offset = #self.topConfig - 4
            else
                offset = index - 1
            end
        end
    end

    if offset > self.offset then
        local x, y, z = self.svList:get_position()
        local itemSize = self.wcList:get_item_size()
        local curCount = math.max(0, -x/itemSize) + self.offset
        if curCount < offset then
            self.moveUpdateSize = math.ceil((offset - curCount) * itemSize)
        end
    end
end

function ArenaTopRankAwardUI:UpdateList()
    if not self.ui then return end

    local flag = self.dataCenter:GetReceivedTopRewardFlag()
    for b, item in pairs(self.items) do
        self:LoadItem(item, item.index)
    end
end

function ArenaTopRankAwardUI:UpdateUi()
    if not self.ui then return end

    local showRank = self.dataCenter:GetMyRank()
    -- 特殊规则说明：20000以后都显示假排名
    if showRank > 20000 then
        showRank = self.dataCenter.maskRank
    else
        showRank = self.dataCenter:GetMyHistoryTopRank()
    end
    self.labTopRank:set_text(tostring(showRank))

    local total = {}
    local flag = self.dataCenter:GetReceivedTopRewardFlag()

    --刷新总收益
    for i, data in pairs(self.topConfig) do
        if flag[data.rank_index] then
            local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something, data.dropid) or {};
            for i, v in pairs(drop_list) do
                if v.goods_show_number > 0 then
                    if total[v.goods_show_number] == nil then
                        total[v.goods_show_number] = 0
                    end
                    total[v.goods_show_number] = total[v.goods_show_number] + v.goods_number
                end
            end
        end
    end
    
    local index = 0
    local totalSortData = {}
    for id, count in pairs_key(total) do
        index = index + 1
        totalSortData[index] = {id=id, count=count}
    end

    for i, uiItem in ipairs(self.uiTotalItems) do
        if totalSortData[i] then
            uiItem:Show()
            uiItem:SetDataNumber(totalSortData[i].id, totalSortData[i].count)
        else
            uiItem:Hide()
        end
    end
end

function ArenaTopRankAwardUI:LoadItem(item, index)
    item.index = index
    local data = self.topConfig[index]
    if data then
        item.node2:set_active(true)
        item.node3:set_active(true)
        item.node4:set_active(true)
        item.labRank:set_active(true)
        item.labHead:set_active(true)

        item.labRank:set_text(tostring(data.rank_index))

        local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something, data.dropid) or {}
        for i=1, 4 do
            local drop_data = drop_list[i]
            if drop_data and drop_data.goods_show_number > 0 then
                item.uiItems[i]:Show(true)
                item.uiItems[i]:SetDataNumber(drop_data.goods_show_number, drop_data.goods_number)
            else
                item.uiItems[i]:Hide(false)
            end
        end

        local historyTopRank = self.dataCenter:GetMyHistoryTopRank()
        local canGet = false
        -- 已领取
        if self.dataCenter:GetReceivedTopRewardFlag()[data.rank_index] then
            item.spReceived:set_active(true)
            item.fxCanReceive:set_active(false)
        -- 未领取
        elseif historyTopRank > 0 and historyTopRank <= data.rank_index then
            item.spReceived:set_active(false)
            item.fxCanReceive:set_active(true)
            canGet = true
        -- 未达到
        else
            item.spReceived:set_active(false)
            item.fxCanReceive:set_active(false)
        end

        item.btnItem:set_event_value(tostring(canGet), data.rank_index)

        -- 当前好友
        if self.friendList[index] then
            -- local callParam = {rank=data.rank_index, friends=self.friendList[index]}
            -- if #self.friendList[index] > 1 then
            --     item.labFriendCnt:set_text(string.format(_local.UIText[1], #self.friendList[index]))
            -- else
            --     item.labFriendCnt:set_text("")
            -- end
            item.labFriendCnt:set_text(string.format(_local.UIText[1], #self.friendList[index]))
            item.labFriendName:set_text(self.friendList[index][1].name)
            item.uiCardFriend:SetVipLevel(self.friendList[index][1].vip_level)
            item.uiCardFriend:SetRoleId(self.friendList[index][1].image)
            item.nodeHaveFriend:set_active(true)
            item.labNoFriend:set_active(false)
            item.btnFriend:set_event_value(tostring(data.rank_index),index)
            item.btnFriend:get_game_object():set_collider_enable(not canGet)
        else
            item.nodeHaveFriend:set_active(false)
            item.labNoFriend:set_active(true)
        end
    else
        item.node2:set_active(false)
        item.node3:set_active(false)
        item.node4:set_active(false)
        item.labRank:set_active(false)
        item.labHead:set_active(false)
    end
end

function ArenaTopRankAwardUI:Update(dt)
    if UiBaseClass.Update(self, dt) then
        if self.moveUpdateSize > 0 then
            local curSize = math.min(30, self.moveUpdateSize)
            self.svList:move_relative(-curSize, 0, 0)
            self.moveUpdateSize = self.moveUpdateSize - curSize
        end
    end
end

function ArenaTopRankAwardUI:on_drag_start()
    self.moveUpdateSize = 0
end

function ArenaTopRankAwardUI:on_btn_get_award(t)
    if t.string_value == "true" then
        msg_activity.cg_arena_get_climb_reward(t.float_value)
    end
end

function ArenaTopRankAwardUI:on_chick_friend(t)
    local callParam = {rank=tonumber(t.string_value), friends=self.friendList[t.float_value]}
    uiManager:PushUi(EUI.ArenaAchieveRankFriendUI, callParam)
end

function ArenaTopRankAwardUI:on_init_item(obj, b, real_id)
	-- local index = math.abs(real_id) + 1;
    local index = math.abs(real_id + self.offset) + 1

    local item = self.items[b]
    if not item then
        item = {}
        
        local objName = obj:get_name()
        item.node2 = obj:get_child_by_name(objName.."/cont1")
        item.node3 = obj:get_child_by_name(objName.."/grid")
        item.node4 = obj:get_child_by_name(objName.."/cont_stat")

        item.labRank = ngui.find_label(obj, objName.."/lab")
        item.labHead = ngui.find_label(obj, objName.."/txt")
        
        local objParent = item.node2:get_child_by_name("sp_head_di_item")
        if not item.uiCardFriend then
            item.uiCardFriend = UiPlayerHead:new({parent=objParent})
        end
        item.btnFriend = ngui.find_button(item.node2, "btn_empty")
        item.btnFriend:set_on_click(self.bindfunc["on_chick_friend"])

        item.labFriendName = ngui.find_label(item.node2, "txt")
        item.labFriendCnt = ngui.find_label(item.node2, "lab")
        item.labNoFriend = ngui.find_label(obj, "lab_wu")

        item.spReceived = ngui.find_sprite(item.node4, "sp_art_font1") 
        item.btnItem = ngui.find_button(item.node4, "btn_empty")
        item.fxCanReceive = obj:get_child_by_name("fx_ui_4407_jjc_kelingqu")
        
        item.uiItemsTable = ngui.find_table(obj, "grid")
        item.uiItems = {}
        for i=1, 4 do
            local objItem = obj:get_child_by_name("new_small_card_item"..i)
            item.uiItems[i] = UiSmallItem:new({parent=objItem})
            item.uiItems[i]:SetEnablePressGoodsTips(true)
        end

        item.btnItem:set_on_click(self.bindfunc["on_btn_get_award"])

        item.nodeHaveFriend = item.node2

        self.items[b] = item
    end

    self:LoadItem(item, index)
end

function ArenaTopRankAwardUI:gc_arena_get_climb_reward(index, rewardList)
    --app.log("rewardList:"..table.tostring(rewardList))
    CommonAward.Start(rewardList)
    self:UpdateList()
    self:UpdateUi()
    self:MoveUpdateOffset()
end

function ArenaTopRankAwardUI:gc_arena_request_climb_reward_data()
    self:ResetList()
    self:UpdateUi()
end

function ArenaTopRankAwardUI:on_btn_close()
    uiManager:PopUi()
end

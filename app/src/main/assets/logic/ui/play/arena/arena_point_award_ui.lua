ArenaPointAwardUI = Class("ArenaPointAwardUI", UiBaseClass)

local _local = {}
_local.UIText = {
    [1] = "每场竞技场战斗可获得[fde517]2[-]积分，每天[fde517]%d:%02d[-]重置",
    [2] = "[ffa127]胜利:[-]  积分+2",
    [3] = "[ffa127]失败:[-]  积分+2",
    [4] = "没有可领取的奖励",    
    [5] = "当前积分 [00FF73]%s[-]",
}

function ArenaPointAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4403_jjc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaPointAwardUI:InitData(data)
	UiBaseClass.InitData(self, data);

    self.resetTime = ConfigManager.Get(EConfigIndex.t_activity_time, MsgEnum.eactivity_time.eActivityTime_arena).reset_time;
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena];
    self.pointConfig = ConfigManager._GetConfigTable(EConfigIndex.t_arena_day_point_reward)
    
    self.configShowEffect = {}
    local configEffect = ConfigManager.Get(EConfigIndex.t_discrete, 83000212).data
    if type(configEffect) == "table" then
        for k, v in pairs(configEffect) do
            self.configShowEffect[v] = true
        end
    end
end

function ArenaPointAwardUI:Restart(data)
	UiBaseClass.Restart(self, data);
end

function ArenaPointAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)
    self.bindfunc['on_move_offset'] = Utility.bind_callback(self, self.on_move_offset)
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc['on_btn_get_all'] = Utility.bind_callback(self, self.on_btn_get_all)
    self.bindfunc['on_btn_item'] = Utility.bind_callback(self, self.on_btn_item)
    self.bindfunc['on_init_item'] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc['on_arena_get_day_point_reward'] = Utility.bind_callback(self, self.on_arena_get_day_point_reward)
end

function ArenaPointAwardUI:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_activity.gc_arena_get_day_point_reward, self.bindfunc["on_arena_get_day_point_reward"])
end

function ArenaPointAwardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_activity.gc_arena_get_day_point_reward, self.bindfunc["on_arena_get_day_point_reward"])
end

function ArenaPointAwardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_point_award");

    self.items = {}
    self.moveUpdateSize = 0

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, "btn_cha")
    local btnGetAll = ngui.find_button(self.ui, path.."btn1")
    local labPoint = ngui.find_label(self.ui, path.."lab_num")

    btnClose:set_on_click(self.bindfunc["on_btn_close"])
    btnGetAll:set_on_click(self.bindfunc["on_btn_get_all"])

    path = "centre_other/animation/scroll_view/"
    self.svList = ngui.find_scroll_view(self.ui, path.."panel_list")
    self.wcList = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
    self.wcList:set_on_initialize_item(self.bindfunc["on_init_item"])
    self.svList:set_on_drag_started(self.bindfunc['on_drag_start'])

    self.wcList:set_min_index(1 - (#self.pointConfig + 1));
	self.wcList:set_max_index(0);
	self.wcList:reset()

    labPoint:set_text(string.format(_local.UIText[5], self.dataCenter:GetPoints()))

    self:MoveStartOffset()
end

function ArenaPointAwardUI:DestroyUi()
    self.moveUpdateSize = 0
    if self.moveTimer then
        timer.stop(self.moveTimer)
        self.moveTimer = nil
    end
    if self.items then
        for i, item in pairs(self.items) do
            for j, uiItem in pairs(item.uiItems) do
                uiItem:DestroyUi()
            end
        end
        self.items = nil
    end
    UiBaseClass.DestroyUi(self);
end

function ArenaPointAwardUI:MoveStartOffset()
    self.offset = 0
    local myPoint = self.dataCenter:GetPoints()
    if myPoint > 0 then
        local index = 0
        for i, v in ipairs(self.pointConfig) do
            if myPoint >= v.need_point and not self.dataCenter:IsReceivePointReward(i) then
                index = i
                break;
            elseif myPoint < v.need_point then
                index = i - 1
                break;
            end
        end
        if index > 0 then
            -- if index + 4 >= #self.pointConfig then
            --     self.offset = #self.pointConfig - 4
            -- else
            --     self.offset = index
            -- end
            self.offset = index
        end
    end

    if self.offset > 0 then
        if self.offset > #self.pointConfig - 4 then
            self.offset = #self.pointConfig - 3
        end
        self.moveTimer = timer.create(self.bindfunc["on_move_offset"], 60, self.offset)
    end
end

function ArenaPointAwardUI:MoveUpdateOffset()
    local offset = 0
    local myPoint = self.dataCenter:GetPoints()
    if myPoint > 0 then
        local index = 0
        for i, v in ipairs(self.pointConfig) do
            if myPoint >= v.need_point and not self.dataCenter:IsReceivePointReward(i) then
                index = i
                break;
            elseif myPoint < v.need_point then
                index = i - 1
                break;
            end
        end
        if index > 0 then
            offset = index
        end
    end

    if offset > 0 then
        if offset > #self.pointConfig - 4 then
            offset = #self.pointConfig - 3
        end
        local x, y, z = self.svList:get_position()
        local itemSize = self.wcList:get_item_size()
        local curCount = math.max(0, y/itemSize)
        if curCount < offset then
            self.moveUpdateSize = math.ceil((offset - curCount) * itemSize)
        end
    end
end

function ArenaPointAwardUI:UpdateList()
    if not self.ui then return end

    for b, item in pairs(self.items) do
        self:LoadItem(item, item.index)
    end
end

function ArenaPointAwardUI:LoadItem(item, index)
    item.index = index
    if index == 0 then
        item.btnGet:set_active(false)
        item.node1:set_active(true)
        item.node2:set_active(false)
        item.labPoint:set_text("0")

        item.labRule:set_text(string.format(_local.UIText[1], self.resetTime.h, self.resetTime.i))
        -- item.labWin:set_text(_local.UIText[2])
        -- item.labLose:set_text(_local.UIText[3])
        
        local data = self.pointConfig[1]
        if data and (self.dataCenter:IsReceivePointReward(1) or self.dataCenter:GetPoints() >= data.need_point) then
            item.spPointBg:set_sprite_name("jjc_liubianxing")
            item.spLineBottom:set_sprite_name("jjc_lianjietiao")
        else
            item.spPointBg:set_sprite_name("jjc_liubianxingan")
            item.spLineBottom:set_sprite_name("jjc_lianjietiao2")
        end
    else
        item.node1:set_active(false)
        item.node2:set_active(true)
    
        local data = self.pointConfig[index]
        if data then
            item.labPoint:set_text(tostring(data.need_point))

            local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something, data.dropid) or {}
            for i, uiItem in pairs(item.uiItems) do
                local fxItem = item.fxItems[i]
                fxItem:set_active(false)
                if drop_list[i] then
                    uiItem:Show()
                    uiItem:SetDataNumber(drop_list[i].goods_show_number, drop_list[i].goods_number)
                    if self.configShowEffect[drop_list[i].goods_show_number] then
                        fxItem:set_active(true)
                    end
                else
                    uiItem:Hide()
                end
            end

            -- 已领取
            if self.dataCenter:IsReceivePointReward(index) then
                item.btnGet:set_active(false)
                item.spState:set_sprite_name("qd_yilingqu")
                item.spState:set_active(true)
                item.spLineBottom:set_sprite_name("jjc_lianjietiao")
                item.spPointBg:set_sprite_name("jjc_liubianxing")
            -- 未领取
            elseif self.dataCenter:GetPoints() >= data.need_point then
                item.btnGet:set_active(true)
                item.spGet:set_sprite_name("ty_anniu3")
                item.labGet:set_color(151/255, 57/255, 0, 1)
                -- item.spState:set_sprite_name("jjc_kelingqu")
                item.spState:set_active(false)
                item.spLineBottom:set_sprite_name("jjc_lianjietiao")
                item.spPointBg:set_sprite_name("jjc_liubianxing")
            -- 未达成
            else
                item.btnGet:set_active(true)
                item.spGet:set_sprite_name("ty_anniu5")
                item.labGet:set_color(1, 1, 1, 1)
                -- item.spState:set_sprite_name("weidacheng")
                item.spState:set_active(false)
                item.spLineBottom:set_sprite_name("jjc_lianjietiao2")
                item.spPointBg:set_sprite_name("jjc_liubianxingan")
            end
        end
        local is_last = #self.pointConfig == index
        if is_last then 
            item.spLineBottom:set_active(false)
        else
            item.spLineBottom:set_active(true)
        end
    end
end

function ArenaPointAwardUI:Update(dt)
    if UiBaseClass.Update(self, dt) then
        if self.moveUpdateSize > 0 then
            local curSize = math.min(30, self.moveUpdateSize)
            self.svList:move_relative(0, curSize, 0)
            self.moveUpdateSize = self.moveUpdateSize - curSize
        end
    end
end

function ArenaPointAwardUI:on_drag_start()
    self.moveUpdateSize = 0
end

function ArenaPointAwardUI:on_move_offset()
    if not self.svList then return end

    local moveCount = (self.offset > 4) and (self.offset - 4) or self.offset
    self.offset = self.offset - moveCount
    if moveCount > 0 then
        local itemSize = self.wcList:get_item_size()
        local moveSize = moveCount * itemSize
        self.svList:move_relative(0, moveSize, 0)
    else
        timer.stop(self.moveTimer)
        self.moveTimer = nil
    end
end

function ArenaPointAwardUI:on_btn_close()
    uiManager:PopUi()
end

function ArenaPointAwardUI:on_btn_get_all()
    local curPoint = self.dataCenter:GetPoints()
    for k, v in pairs(self.pointConfig) do
        if not self.dataCenter:IsReceivePointReward(k) and curPoint >= v.need_point then
            msg_activity.cg_arena_get_day_point_reward(0)
            return;
        end
    end

    -- 无可领取奖励
    FloatTip.Float(_local.UIText[4])
end

function ArenaPointAwardUI:on_btn_item(t)
    local index = t.float_value
    if index > 0 then
        msg_activity.cg_arena_get_day_point_reward(index)
    end
end

function ArenaPointAwardUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 0; -- 从0开始（显示积分获得规则）

    local item = self.items[b]
    if not item then
        item = {}
        item.btnGet = ngui.find_button(obj, "btn_get")
        item.spGet = ngui.find_sprite(obj, "btn_get/animation/sp")
        item.labGet = ngui.find_label(obj, "btn_get/animation/lab")
        item.spPointBg = ngui.find_sprite(obj, "sp_liang")
        item.labPoint = ngui.find_label(obj, "sp_liang/lab")
        item.spLineBottom = ngui.find_sprite(obj, "sp_liang/sp_line_liang")

        item.node1 = obj:get_child_by_name("cont1")
        item.node2 = obj:get_child_by_name("cont2")
        item.labRule = ngui.find_label(item.node1, "lab")
        -- item.labWin = ngui.find_label(item.node1, "cont_win/lab_t")
        -- item.labLose = ngui.find_label(item.node1, "cont_lose/lab_t")
        
        item.spState = ngui.find_sprite(item.node2, "sp_art_font")

        local objItems = {}
        objItems[1] = item.node2:get_child_by_name("cont_grid/new_small_card_item1")
        objItems[2] = item.node2:get_child_by_name("cont_grid/new_small_card_item2")
        objItems[3] = item.node2:get_child_by_name("cont_grid/new_small_card_item3")
        objItems[4] = item.node2:get_child_by_name("cont_grid/new_small_card_item4")
        item.uiItems = {}
        item.fxItems = {}
        for i=1, 4 do
            item.uiItems[i] = UiSmallItem:new({parent=objItems[i]})
            item.uiItems[i]:SetEnablePressGoodsTips(true)
            item.fxItems[i] = objItems[i]:get_child_by_name("fx_checkin_month_right")
        end

        item.btnGet:set_on_click(self.bindfunc["on_btn_item"])

        self.items[b] = item
    end

    item.btnGet:set_event_value("", index)

    self:LoadItem(item, index)
end

function ArenaPointAwardUI:on_arena_get_day_point_reward(index, rewardList)
    CommonAward.Start(rewardList)
    self:UpdateList()
    self:MoveUpdateOffset()
end

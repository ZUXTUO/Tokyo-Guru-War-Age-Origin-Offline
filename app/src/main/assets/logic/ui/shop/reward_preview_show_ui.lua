-- 奖励预览界面


RewardPreviewShowUI = Class("RewardPreviewShowUI", UiBaseClass)

local _UIText = {
    [1] = "装备",
    [2] = "道具",
}

local _MaxCount = 5 --行最大数

function RewardPreviewShowUI:SetFuncId(funcId)    
    self.funcId = funcId
    self:UpdateItemDataGroup()
    self:UpdateUi();
end

function RewardPreviewShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_jiangli_yulan.assetbundle"
    self.funcId = data --预览的功能id
    self.tabIndex = 1  --默认装备页签
    self.lastPosX = 0
    
    self:UpdateItemDataGroup()
    
	UiBaseClass.Init(self, data);
end

function RewardPreviewShowUI:Restart(data)
    self:UpdateItemDataGroup()
    UiBaseClass.Restart(self, data)
end

function RewardPreviewShowUI:DestroyUi()
    if self.itemGrids then
        for k, v in pairs(self.itemGrids) do
            for kk, vv in pairs(v) do
                vv.uiItem:DestroyUi()
            end
        end
        self.itemGrids = nil
    end

    self.itemDataGroup = nil
    self.moveTargetX = nil
    self.isMoving = false
    self.lastPosX = 0

    UiBaseClass.DestroyUi(self);
end

function RewardPreviewShowUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["on_left_page"] = Utility.bind_callback(self, self.on_left_page)
    self.bindfunc["on_right_page"] = Utility.bind_callback(self, self.on_right_page)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_select_tab"] = Utility.bind_callback(self, self.on_select_tab)
    self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)
end

function RewardPreviewShowUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_reward_preview_show')

    self.itemGrids = {}

    local btnClose = ngui.find_button(self.ui, "centre_other/animation/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])

    local path = "centre_other/animation/yeka/"
    --------------------------- 页卡 ---------------------------
    --1装备，2道具
    for i=1, 2 do
        local nodeTab = self.ui:get_child_by_name(path.."yeka"..i)
        local btnTab = ngui.find_button(nodeTab, nodeTab:get_name())
        btnTab:set_event_value("", i)
        btnTab:set_on_click(self.bindfunc["on_select_tab"], "MyButton.Flag")

        local labTab = ngui.find_label(nodeTab, "lab")
        local labTab1 = ngui.find_label(nodeTab, "lab_hui")
        labTab:set_text(_UIText[i])
        labTab1:set_text(_UIText[i])
    end
    
    path = "centre_other/animation/scroll_view/"
    --------------------------- 内容 ---------------------------
    self.scrollView = ngui.find_scroll_view(self.ui, path.."panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.scrollView:set_on_drag_started(self.bindfunc['on_drag_start'])
    self.wrapItemWidth = self.wrapContent:get_item_size()

    self.btnLeft = ngui.find_button(self.ui, "centre_other/animation/btn_left")
    self.btnRight = ngui.find_button(self.ui, "centre_other/animation/btn_right")
    self.btnLeft:set_on_click(self.bindfunc["on_left_page"])
    self.btnRight:set_on_click(self.bindfunc["on_right_page"])


    self:UpdateUi();
end

function RewardPreviewShowUI:UpdateItemDataGroup()
    local config = ConfigManager.Get(EConfigIndex.t_reward_preview_show, self.funcId)
    if config then
        local idGroup = nil
        for k, v in pairs(config) do
            if v.show_type == self.tabIndex then
                idGroup = v.id_group
                break;
            end
        end
        self.itemDataGroup = {}
        for i, v in ipairs(idGroup) do
            local cardInfo = PublicFunc.CreateCardInfo(v)
            table.insert(self.itemDataGroup, cardInfo)
        end
    else
        app.log("奖励预览配置未找到："..tostring(self.funcId))
    end
end

function RewardPreviewShowUI:UpdateUi()
    if not self.ui then return end

    local count = #self.itemDataGroup
    self.wrapContent:set_min_index(0);
    self.wrapContent:set_max_index(math.ceil(count / 2) - 1)
    self.wrapContent:reset()
    self.scrollView:reset_position()

end

function RewardPreviewShowUI:Update(dt)
    if UiBaseClass.Update(self, dt) and self.itemDataGroup then
        -- 更新左右箭头按钮
        local x, y, z = self.scrollView:get_position()
        local cols = math.ceil(#self.itemDataGroup / 2)
        if cols > _MaxCount then
            if x > -self.wrapItemWidth * 0.5 then
                self.btnLeft:set_active(false)
                self.btnRight:set_active(true)
            elseif x < -self.wrapItemWidth * (cols - _MaxCount - 0.5) then
                self.btnLeft:set_active(true)
                self.btnRight:set_active(false)
            else
                self.btnLeft:set_active(true)
                self.btnRight:set_active(true)
            end
        else
            self.btnLeft:set_active(false)
            self.btnRight:set_active(false)
        end

        if self.moveTargetX then
            local moveX = 0
            if self.moveTargetX > x then
                moveX = math.min(30, self.moveTargetX - x)
            elseif self.moveTargetX < x then
                moveX = -math.min(30, x - self.moveTargetX)
            end
            if math.abs(self.moveTargetX - x) <= 30 then
                self.moveTargetX = nil
            end
            self.scrollView:move_relative(moveX, y, z)
        end

        self.isMoving = (self.lastPosX ~= x)
        self.lastPosX = x
    end
end

function RewardPreviewShowUI:on_drag_start()
    self.moveTargetX = nil
end

function RewardPreviewShowUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1
    
    local itemGrids = self.itemGrids[b]
    if itemGrids == nil then
        itemGrids = {}
        local childs = obj:get_childs()
        for i=1, 2 do
            itemGrids[i] = {}
            itemGrids[i].name = ngui.find_label(childs[i], "lab_name")
            itemGrids[i].sp = ngui.find_sprite(childs[i], "sp1")
            itemGrids[i].uiItem = UiSmallItem:new( { parent = childs[i]:get_child_by_name("new_small_card_item"), prop = {show_number=false} })
            itemGrids[i].uiItem:SetEnablePressGoodsTips(true)
            itemGrids[i].uiItem:ClearOnClicked()
        end
        self.itemGrids[b] = itemGrids
    end
    
    for i=1, 2 do
        local pos = index * 2 + i
        local data = self.itemDataGroup[pos]
        if data then
            itemGrids[i].name:set_active(true)
            itemGrids[i].sp:set_active(true)
            itemGrids[i].uiItem:Show()

            itemGrids[i].name:set_text(data.color_name)
            itemGrids[i].uiItem:SetData(data)
        else
            itemGrids[i].name:set_active(false)
            itemGrids[i].sp:set_active(false)
            itemGrids[i].uiItem:Hide()
        end
    end 
end

function RewardPreviewShowUI:on_select_tab(t)
    local index = t.float_value
    if self.tabIndex == index then return end

    self.tabIndex = index
    self:UpdateItemDataGroup()
    self:UpdateUi()
end

function RewardPreviewShowUI:on_btn_close()
    uiManager:PopUi()
end

function RewardPreviewShowUI:on_left_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(#self.itemDataGroup / 2)
    local totalPage = math.ceil(cols / _MaxCount)
    local curPage = 0
    if x < 0 then
        local absX = -x
        curPage = math.floor(absX / (_MaxCount * self.wrapItemWidth))
        -- 在分页交界一定范围认为可以翻页
        if math.mod(absX, (_MaxCount*self.wrapItemWidth)) < 10 then
            curPage = math.max(0, curPage - 1)
        end
    end
    
    self.moveTargetX = -self.wrapItemWidth * _MaxCount * curPage 
end

function RewardPreviewShowUI:on_right_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(#self.itemDataGroup / 2)
    local totalPage = math.ceil(cols / _MaxCount)
    local curPage = 0
    if x < 0 then
        local absX = -x
        curPage = math.floor(absX / (_MaxCount * self.wrapItemWidth))
        -- 在分页交界一定范围认为可以翻页
        if _MaxCount*self.wrapItemWidth - math.mod(absX, (_MaxCount*self.wrapItemWidth)) < 10 then
            curPage = math.min(totalPage - 1, curPage + 1)
        end
    end
    self.moveTargetX = -self.wrapItemWidth * _MaxCount * (curPage + 1)
end

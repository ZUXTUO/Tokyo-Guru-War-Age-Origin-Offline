
EquipFragExchangeUI = Class("EquipFragExchangeUI", UiBaseClass)

local _local = {}
_local.UIText = {
    [1] = "碎片兑换",
    [2] = "每购买一次，获得一个装备碎片。",

}

local _MaxCount = 3

function EquipFragExchangeUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop_equipbox.assetbundle"
	UiBaseClass.Init(self, data);
end

function EquipFragExchangeUI:Restart(data)
    self.lastPosX = 0
    self.CfgExchange = ConfigManager._GetConfigTable(EConfigIndex.t_niudan_equip_exchange)
	UiBaseClass.Restart(self, data)
end

function EquipFragExchangeUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function EquipFragExchangeUI:DestroyUi()
    if self.clsBuyBatch then
        self.clsBuyBatch:DestroyUi()
        self.clsBuyBatch = nil
    end
    if self.itemGroups then
        for k, itemGroup in pairs(self.itemGroups) do
            for i, item in ipairs(itemGroup) do
                item.card:DestroyUi()
            end
        end
        self.itemGroups = nil
    end
    UiBaseClass.DestroyUi(self)

    self.moveTargetX = nil
    self.isMoving = false
    self.lastPosX = 0
end

function EquipFragExchangeUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close_btn"] = Utility.bind_callback(self, self.on_close_btn)    
    self.bindfunc["on_item_click"] = Utility.bind_callback(self, self.on_item_click)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_buy_callback"] = Utility.bind_callback(self, self.on_buy_callback)

    self.bindfunc["on_left_page"] = Utility.bind_callback(self, self.on_left_page)  
    self.bindfunc["on_right_page"] = Utility.bind_callback(self, self.on_right_page) 
    self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)

    self.bindfunc["gc_niudan_exchange_equip"] = Utility.bind_callback(self, self.gc_niudan_exchange_equip)
end

function EquipFragExchangeUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_niudan_exchange_equip,self.bindfunc['gc_niudan_exchange_equip']);
end

function EquipFragExchangeUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_exchange_equip,self.bindfunc['gc_niudan_exchange_equip']);
end

--初始化UI
function EquipFragExchangeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)	
	self.ui:set_name("equip_box_frag_ui")

    self.itemGroups = {}
    
    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close_btn"])

    local path = "centre_other/animation/"
    self.labFragNum = ngui.find_label(self.ui, path .. "lab")
    self.btnLeft = ngui.find_button(self.ui, path .. "btn_left")
    self.btnRight = ngui.find_button(self.ui, path .. "btn_right")
    self.btnLeft:set_on_click(self.bindfunc["on_left_page"])
    self.btnRight:set_on_click(self.bindfunc["on_right_page"])

    path = "centre_other/animation/scroll_view/"
    self.scrollView = ngui.find_scroll_view(self.ui, path.."panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.wrapItemWidth = self.wrapContent:get_item_size()

    self:LoadWrapList()
    self:UpdateUi()
end

function EquipFragExchangeUI:Show()
    if UiBaseClass.Show(self) then
        self:UpdateUi()
    end
end

function EquipFragExchangeUI:UpdateUi(dt)
    if self.ui == nil then return end

    --碎片数量
    local fragCount = PropsEnum.GetValue(IdConfig.EquipDebris)
    self.labFragNum:set_text(PublicFunc.NumberToStringByCfg(fragCount))
end

function EquipFragExchangeUI:Update(dt)
    if UiBaseClass.Update(self, dt) then
        -- 更新左右箭头按钮
        local x, y, z = self.scrollView:get_position()
        local cols = math.ceil(#self.CfgExchange / 2)
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

function EquipFragExchangeUI:on_drag_start()
    self.moveTargetX = nil
end

function EquipFragExchangeUI:on_left_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(#self.CfgExchange / 2)
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

function EquipFragExchangeUI:on_right_page(t)
    if self.isMoving then return end

    local x, y, z = self.scrollView:get_position()
    local cols = math.ceil(#self.CfgExchange / 2)
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

function EquipFragExchangeUI:on_close_btn()
    uiManager:PopUi()
end

function EquipFragExchangeUI:on_item_click(t)
    local data = self.CfgExchange[t.float_value]
    if data then
        if self.clsBuyBatch == nil then
            self.clsBuyBatch = BuyBatchUi:new()
        end

        local info = {}
        info.itemId = data.equip_ID
        info.costCount = data.need_ships
        info.costId = IdConfig.EquipDebris
        self.clsBuyBatch:Show()
        self.clsBuyBatch:SetData(info)
        self.clsBuyBatch:SetCallback(self.bindfunc["on_buy_callback"], data)
    end
end

function EquipFragExchangeUI:on_buy_callback(data, result)
    if data and result then
        msg_activity.cg_niudan_exchange_equip(data.index, result.totalCount)
    end
end

function EquipFragExchangeUI:LoadWrapList()
    if not self.ui then return end

    self.wrapContent:set_min_index(0)
    self.wrapContent:set_max_index(math.ceil(#self.CfgExchange / 2) - 1)
    self.wrapContent:reset()
end

function EquipFragExchangeUI:LoadItem(index, item)
    local data = self.CfgExchange[index]
    if data then
        item.self:set_active(true)
        item.btn:set_event_value("", index)
        item.cost:set_text(""..data.need_ships)
        local info = PublicFunc.CreateCardInfo(data.equip_ID)
        item.name:set_text(info.color_name)
        item.card:SetData(info)
        item.card:SetOnClicked(self.bindfunc["on_item_click"], "", index)
    else 
        item.self:set_active(false)
    end
end

function EquipFragExchangeUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1

    local itemGroup = self.itemGroups[b]
    if not itemGroup then
        itemGroup = {}
        for i=1, 2 do
            local nodeName = string.format("cont"..i)
            local objNode = obj:get_child_by_name(nodeName)
            itemGroup[i] = {}
            itemGroup[i].self = objNode
            itemGroup[i].btn = ngui.find_button(objNode, objNode:get_name())
            itemGroup[i].cost = ngui.find_label(objNode, "btn2/lab")
            itemGroup[i].name = ngui.find_label(objNode, "lab_name")
            itemGroup[i].btn:set_on_click(self.bindfunc["on_item_click"])

            local objParent = objNode:get_child_by_name("new_small_card_item")
            itemGroup[i].card = UiSmallItem:new({parent=objParent, prop={show_number=false}, delay=500})
            itemGroup[i].card:SetEnablePressGoodsTips(true)
        end
        self.itemGroups[b] = itemGroup
    end 

    for i, item in ipairs(itemGroup) do
        self:LoadItem((index-1)*2 + i, item)
    end
end

function EquipFragExchangeUI:gc_niudan_exchange_equip(result, index, count)
	local data = self.CfgExchange[index]
	CommonAward.Start({{id=data.equip_ID, count=count or 1},},1);
	self:UpdateUi();
end


EquipSelectMatirialUI = Class("EquipSelectMatirialUI", UiBaseClass)

local _MAX_NUM = 4

function EquipSelectMatirialUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_604_1.assetbundle"    
    UiBaseClass.Init(self, data)
end

function EquipSelectMatirialUI:InitData(data)
	UiBaseClass.InitData(self, data)
    self.data = {}
    self.smallItemUi = {}
    self.itemsBox = {}
    --选中的下标(最多四个)
    self.selPos = {}
    
    self.allMark = false
end

function EquipSelectMatirialUI:Restart(data)    
	if UiBaseClass.Restart(self, data) then        
	end
end

function EquipSelectMatirialUI:RegistFunc()
    UiBaseClass.RegistFunc(self)    
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_confirm"] = Utility.bind_callback(self, self.on_confirm) 
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)  
    self.bindfunc["on_select"] = Utility.bind_callback(self, self.on_select) 
end

function EquipSelectMatirialUI:MsgRegist()
    UiBaseClass.MsgRegist(self);  
end

function EquipSelectMatirialUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
end

function EquipSelectMatirialUI:DestroyUi()
    for _, items in pairs(self.smallItemUi) do
        for _, it in pairs(items) do
            if it then
                it:DestroyUi();
                it = nil;
            end
	    end
	end
    UiBaseClass.DestroyUi(self)
end

function EquipSelectMatirialUI:on_close()
    self:Hide()
end

function EquipSelectMatirialUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("equip_select_material")

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    local btnConfirm = ngui.find_button(self.ui, path .. "btn2")
    btnConfirm:set_on_click(self.bindfunc["on_confirm"])

    self.lblCount = ngui.find_label(self.ui, path .. "txt_cailiao/lab_num")

    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self:Hide()
end

function EquipSelectMatirialUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1        
    for i = 1, 2 do 
        local objItem = obj:get_child_by_name("content" .. i)
        local pos = index * 2 + i
        local data = self.data[pos]
        if data ~= nil then
            objItem:set_active(true)
            self:SetItemData(objItem, data, pos, row, i)
        else
            objItem:set_active(false)
        end
    end
end

function EquipSelectMatirialUI:SetItemData(item, data, pos, row, i)
    local btnSel = ngui.find_button(item, 'yeka')
    btnSel:reset_on_click()
    btnSel:set_on_click(self.bindfunc["on_select"])
    btnSel:set_event_value("", pos)     
    
    if self.itemsBox[row] == nil then
        self.itemsBox[row] = {}
    end 
    if self.itemsBox[row][i] == nil then
        local objYeka = item:get_child_by_name("yeka")
        local spShine = ngui.find_sprite(item, "yeka/sp_gou")
        local spMark = ngui.find_sprite(item, "sp_mark")
        self.itemsBox[row][i] = {pos = pos, shine = spShine, frame = objYeka, mark = spMark}
    end
    self.itemsBox[row][i].pos = pos
    self.itemsBox[row][i].shine:set_active(self:HaveSel(pos))

    local have = self:HaveMark(pos)
    self.itemsBox[row][i].frame:set_active(not have)
    self.itemsBox[row][i].mark:set_active(have)
    
    local lblName = ngui.find_label(item, "lab")
    lblName:set_text(data.name)

    local lblExp = ngui.find_label(item, "lab_num")
    lblExp:set_text("+" ..data.exp)    

    local sItem = item:get_child_by_name('new_small_card_item') 
    if self.smallItemUi[row] == nil then
        self.smallItemUi[row] = {}
    end
    local itemUi = self.smallItemUi[row][i]  
    if itemUi == nil then   
        itemUi = UiSmallItem:new({obj = nil, parent = sItem, cardInfo = nil, delay = -1})          
        self.smallItemUi[row][i] = itemUi
    end  
    itemUi:SetDataNumber(data.number, 1)    
end


function EquipSelectMatirialUI:UpdateUi()
    local count = #self.data
    app.log('-----> count = ' .. count)
    self.wrapContent:set_min_index(- math.ceil(count / 2) + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 

    self.lblCount:set_text("[00FF73]" .. #self.selPos .. '[-]' .. "/4")
end

function EquipSelectMatirialUI:UpdateData(data, material, callback)
    self.selPos = {}
    --设置选中
    if material then
        for k,v in pairs(material) do
            for pos, vv in pairs(data) do
                if v.number == vv.number then
                    if not self:HaveSel(pos) then
                        table.insert(self.selPos, pos)
                        break
                    end
                end
            end
        end
    end    
    self.callback = callback
    self.allMark = false
    self.data = data
    self:UpdateUi()
end

--[[选中]]
function EquipSelectMatirialUI:on_select(t)
    local pos = t.float_value
    local box = self:FindItemBox(pos)
    if box == nil then
        return
    end
    if self:HaveSel(pos) then
        --取消选中
        box.shine:set_active(false)
        self:DelSel(pos)
    else
        if #self.selPos <= _MAX_NUM - 1 then
            --选中
            box.shine:set_active(true)
            table.insert(self.selPos, pos)
        end
    end
    --更新所有遮罩
    self:UpdateAllMark() 
    self.lblCount:set_text("[00FF73]" .. #self.selPos .. '[-]' .. "/4")
end

function EquipSelectMatirialUI:HaveSel(pos)
    for k, v in pairs(self.selPos) do
        if pos == v then
            return true
        end
    end
    return false
end

function EquipSelectMatirialUI:DelSel(pos)
    for i = #self.selPos, 1 , -1 do
        if self.selPos[i] == pos then
            table.remove(self.selPos, i)
            break
        end
    end
end

function EquipSelectMatirialUI:FindItemBox(pos)
    for k, v in pairs(self.itemsBox) do
        for kk, vv in pairs(v) do
            if vv.pos == pos then
                return vv
            end
        end
    end
    return nil
end

function EquipSelectMatirialUI:HaveMark(pos)
    if #self.selPos ~= _MAX_NUM then
        return false
    else
        if self:HaveSel(pos) then
            return false
        end
    end
    return true
end

function EquipSelectMatirialUI:UpdateAllMark()
    if #self.selPos == _MAX_NUM then
        --添加遮罩
        --self.allMark = true
        for k, v in pairs(self.itemsBox) do
            for kk, vv in pairs(v) do
                if not self:HaveSel(vv.pos) then
                    vv.mark:set_active(true)
                    vv.frame:set_active(false)
                end
            end
        end
    else
        --取消遮罩
        --if self.allMark then
            --self.allMark = false
            for k, v in pairs(self.itemsBox) do
                for kk, vv in pairs(v) do
                    vv.mark:set_active(false)
                    vv.frame:set_active(true)
                end
            end
        --end
    end
end

--[[确认]]
function EquipSelectMatirialUI:on_confirm()    
    if self.callback then
        local material = {}
        for k, v in pairs(self.selPos) do 
            material[k] = self.data[v]
        end
		if type(self.callback) == "function" then
	    	self.callback(material)
	    elseif type(self.callback) == "string" then
	    	Utility.call_func(self.callback, material)
	    end
        self:Hide()
	end
end
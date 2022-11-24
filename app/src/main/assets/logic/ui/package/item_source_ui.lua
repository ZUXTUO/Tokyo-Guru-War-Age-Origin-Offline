ItemSourceUI = Class('ItemSourceUI', UiBaseClass)

local resPath = 'assetbundles/prefabs/ui/bag/ui_3202_bag.assetbundle'

function ItemSourceUI:Init(data)
    self.pathRes = resPath

    UiBaseClass.Init(self, data);
end

function ItemSourceUI:Restart(data)
    self:ClearData()
    UiBaseClass.Restart(self, data)
end

function ItemSourceUI:ClearData()
    self._sourceid = nil
end

function ItemSourceUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
    self:ClearData()
end

function ItemSourceUI:RegistFunc() 
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnClose'] = Utility.bind_callback(self, self.OnClose);
    self.bindfunc['OnInitItem'] = Utility.bind_callback(self, self.OnInitItem);
    self.bindfunc['OnClickItem'] = Utility.bind_callback(self, self.OnClickItem);
end

function ItemSourceUI:OnClose()
    uiManager:PopUi()
end

function ItemSourceUI:OnInitItem(obj, b, real_id)
    local index = math.abs(real_id) + 1

    local source = self.itemSource[index]
    if not source then
        return
    end

    local lab = ngui.find_label(obj, 'lab1')
    lab:set_text(tostring(gs_item_source_name[source.name]))
    lab = ngui.find_label(obj, 'lab2')
    lab:set_text(tostring(gs_item_source_des[source.des]))

    local btn = ngui.find_button(obj, obj:get_name())
    btn:reset_on_click()
    btn:set_event_value('', source.gotoid)
    btn:set_on_click(self.bindfunc['OnClickItem'])
end

function ItemSourceUI:OnClickItem(param)
    EnterSystemFunction(param.float_value)
end

function ItemSourceUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    local btn = ngui.find_button(self.ui, 'btn_fork')
    btn:set_on_click(self.bindfunc['OnClose'])

    self.wrapContent = ngui.find_wrap_content(self.ui, 'wrap_content')
    self.wrapContent:set_on_initialize_item(self.bindfunc['OnInitItem'])

    if self._sourceid then
        self:_SetSourceID(self._sourceid)
    end
end

function ItemSourceUI:SetSourceID(sourceid)
    if self.ui then
        self:_SetSourceID(sourceid)
    else
        self._sourceid = sourceid
    end
end

function ItemSourceUI:_SetSourceID(sourceid)
    --app.log('1111111111 ' .. tostring(sourceid))

    self.itemSource = ConfigManager.Get(EConfigIndex.t_item_source,sourceid)
    if self.itemSource == nil then
        uiManager:PopUi()
        return
    end

    self.wrapContent:set_min_index(-#self.itemSource + 1)
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
end
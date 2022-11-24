
MainUITriggerOperator = Class('MainUITriggerOperator', UiBaseClass)

local res = "assetbundles/prefabs/ui/wanfa/baoxiang/panel_open_box.assetbundle"

ETriggeUIOperatorType = 
{
    UseItem = 1,
    PostEvent = 2,
}

function MainUITriggerOperator.GetResList()
    return {res}
end

function MainUITriggerOperator:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUITriggerOperator:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name('MainUITriggerOperator')

    local node = self.ui:get_child_by_name("background")
    node:set_active(false)

    node = self.ui:get_child_by_name("sp_box")
    if node then
        node:set_active(false)
    end

    self.button = ngui.find_button(self.ui, "btn")
    self.button:set_on_click(self.bindfunc['OnClick'])
    self.buttonGameObject = self.button:get_game_object()

    self.buttonEnableFx = self.buttonGameObject:get_child_by_name('fx_ui_panel_open_box_jiguan')
    self.buttonEnableFx:set_active(false)
    
    self.openFx = self.ui:get_child_by_name("fx_ui_btn_kaiqi")
    self.openFx:set_local_position(self:GetIconWorldPosition())
    self.openFx:set_active(true)
    self.openFx:set_active(false)

    self.buttonSprite = ngui.find_sprite(self.ui, 'btn/sp')
    -- self.objGuideTips = self.ui:get_child_by_name("centre_other/animation/sp_down_arrow");
    -- self.objGuideTips:set_active(false);
    

    self._hasShow = false
    self._enableClick = false

    self:UpdateUi()
end

function MainUITriggerOperator:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnClick'] = Utility.bind_callback(self, self.OnClick);
    self.bindfunc['OpenFxEnd'] = Utility.bind_callback(self, self.OpenFxEnd);
end

function MainUITriggerOperator:OnClick()

    -- use item
    if self._enableClick and self._hasShow then

        if self._operatorType == ETriggeUIOperatorType.UseItem then
            self._hasShow = false
            self._enableClick = false
            NoticeManager.Notice(ENUM.NoticeType.PlayerUseItem, self._operatorParam)
        elseif self._operatorType == ETriggeUIOperatorType.PostEvent then
            local instanceName = self._operatorParam[1]
            app.log('----------------------- ' .. tostring(instanceName))
            local objs = PublicFunc.GetObjectByInstanceName(instanceName)
            for k,entity in ipairs(objs) do
                --app.log('MainUITriggerOperator:OnClick ' .. entity:GetName())
                entity:PostEvent(AIEvent.UserHasOperatedUI)
            end
        end
        self:UpdateUi()
    end
end

function MainUITriggerOperator:ShowOperatorUI(isPickUp)
    --app.log("ShowOperatorUI " .. debug.traceback())
    self._hasShow = true

    self._isPickUp = isPickUp

    self:UpdateUi()
end

function MainUITriggerOperator:HideOperatorUI()
    --app.log("HideOperatorUI")
    self._hasShow = false

    self:UpdateUi()
end

function MainUITriggerOperator:EnableOperatorUI(operatorParam, type)
    self._enableClick = true
    self._operatorParam = operatorParam
    self._operatorType = type
    self:UpdateUi()
end

function MainUITriggerOperator:SetButtonIcon(iconName)
    self.buttonSprite:set_sprite_name(iconName)
end

function MainUITriggerOperator:DisableOperatorUI()
    self._enableClick = false
    self._operatorParam = nil
    self:UpdateUi()
end

function MainUITriggerOperator:UpdateUi()

    if self.button == nil then
        --app.log("MainUITriggerOperator::UpdateUi " .. debug.traceback())
        return
    end

    if self._hasShow then
        if self._isPickUp then
            TimerManager.Add(self.bindfunc['OpenFxEnd'], 300, 1)
        else
            self.button:set_active(true)
        end
    else
        self.button:set_active(false)
    end

    if self._hasShow then
        if self._enableClick then
            self.button:set_enable(true)
            self.buttonSprite:set_color(1, 1, 1, 1)
            self.buttonEnableFx:set_active(true)
        else
            self.button:set_enable(false)
            self.buttonSprite:set_color(0, 0, 0, 1)
            self.buttonEnableFx:set_active(false)

            if self._isPickUp then
                self.openFx:set_active(false)
                self.openFx:set_active(true)
            end
        end
    end
end

function MainUITriggerOperator:OpenFxEnd()
    self.button:set_active(true)

    self._isPickUp = false
end

function MainUITriggerOperator:GetIconWorldPosition()
    local x,y,z = 0,0,0
    local x,y,z = self.buttonGameObject:get_local_position()
    return x,y,z
end

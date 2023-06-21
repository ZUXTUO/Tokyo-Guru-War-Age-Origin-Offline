
MultiResUiBaseClass = Class('MultiResUiBaseClass', UiBaseClass);

function MultiResUiBaseClass:___LoadUI()
    if type(self.pathRes) == 'table' then

        self.uis = {}

        self.allResloaded = false

        for k,path in pairs(self.pathRes) do
            ResourceLoader.LoadAsset(path, self.bindfunc['on_main_ui_loaded'], self.panel_name);
        end
        
    end
end

function MultiResUiBaseClass:on_main_ui_loaded(pid, filepath, asset_obj, error_info)
    if table.is_contains(self.pathRes, filepath) then

        self:InitOneUI(asset_obj, filepath)

        if table.get_num(self.uis) == table.get_num(self.pathRes) then
            for k,v in pairs(self.uis) do
                v:set_active(true)
            end
            
            if self.showLock then
                g_ScreenLockUI.Hide()
            end

            self.allResloaded = true

            self:InitedAllUI()
            GLoading.Hide(GLoading.EType.loading, self.__loadingUIId);

            if self.loadedCallBack then
                self.loadedCallBack() 
                self.loadedCallBack = nil
            end
        end
    end
end

function MultiResUiBaseClass:InitOneUI(asset_obj, filepath)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_active(false)
    self.uis[filepath] = self.ui
    
    self.ui = nil -- 具体哪个是self.ui需要继承者自己指定
end

--需继承者覆盖的方法，MultiResUiBaseClass本身并未指定self.ui，实现时需要注意
function MultiResUiBaseClass:InitedAllUI()
end

function MultiResUiBaseClass:SetLoadedCallback(cb)
    if self.allResloaded then
        cb()
    else
        self.loadedCallBack = cb;
    end
end

function MultiResUiBaseClass:IsAllResLoaded()
    return self.allResloaded
end

function MultiResUiBaseClass:Show()
    if not self.allResloaded then return false end

    for k,v in pairs(self.uis) do
        v:set_active(true)
    end
    
    return true    
end

function MultiResUiBaseClass:Hide()
    if not self.allResloaded then return false end

    for k,v in pairs(self.uis) do
        v:set_active(false)
    end
    
    return true    
end

function MultiResUiBaseClass:DestroyUi()
    if self.is_destroyed then
        return
    end
    self.is_destroyed = true
    self._initData = nil
    self.allResloaded = false
    if self.uis then
        for k,v in pairs(self.uis) do
            v:set_active(false)
            v:set_parent(nil)
        end
        
        self.uis = nil
        PublicFunc.ClearUserDataRef(self)
    end
    self:MsgUnRegist();
    self:UnRegistFunc();
    ResourceLoader.ClearGroupCallBack(self.panel_name)
    self.ui = nil

    if self.showLock then
        g_ScreenLockUI.Hide()
    end
end

--帧更新
function MultiResUiBaseClass:Update(dt)
	if not self.allResloaded then
		return false
	end
    return true;
end

function MultiResUiBaseClass:UpdateUi()
    if not self.allResloaded then
		return false
	end
    return true;
end
UiBaseClass = Class('UiBaseClass');
UiBaseClass.showSceneCamera = false;
--------------------------------------------------

function UiBaseClass.PreLoadUIRes(ui_class, call_back)
    if nil ~= ui_class and ui_class.GetResList ~= nil and type(ui_class.GetResList) == "function" then
        local res_list = ui_class.GetResList()
        for k, v in pairs(res_list) do
            ResourceLoader.LoadAsset(v, call_back, v);
        end

        return res_list;
    end

    return nil
end

function UiBaseClass.PreLoadTexture(texture_file, call_back)
    if nil ~= texture_file and type(texture_file) == 'string' then
        ResourceLoader.LoadTexture(texture_file, call_back);
        return true;
    end

    return false;
end

--初始化
function UiBaseClass:Init(data)
    self.showed = true
    self.panel_name = self._className
    self.load_res_cnt = 0
    self:InitData(data);
    self:Restart(data);
end

--重新开始
function UiBaseClass:Restart(data)
    if self.ui then
        return false;
    end

    self.loadedCallBack = nil
    self.isCallNow = true
    self.showed = true;    
    self._isLoadAsset = false;

    self._initData = data
    self.is_destroyed = false
    self:RegistFunc();
    self:MsgRegist();
    self:RestartData(data)
    self:LoadUI();
    return true;
end

--设置重入数据 -- InitData()之后, LoadUI()之前
function UiBaseClass:RestartData(data)
    --根据需要重写该函数
end

function UiBaseClass:GetInitData()
    return self._initData
end

function UiBaseClass:SetInitData(data)
    self._initData = data
end

--初始化数据
function UiBaseClass:InitData(data)
    self.ui = nil;
    self.bindfunc = {};
    self.showLock = true;
end

--析构函数
function UiBaseClass:DestroyUi(is_pop)
    if self.is_destroyed then
        return
    end
    self.is_destroyed = true
    self._initData = nil
    if self.ui and self._isLoadAsset then
        self._isLoadAsset = false;
        self.ui:set_active(false)
        self.ui:set_parent(nil)
        self.ui = nil
    end
    PublicFunc.ClearUserDataRef(self)
    self:MsgUnRegist();
    self:UnRegistFunc();
    ResourceLoader.ClearGroupCallBack(self.panel_name)
    if self.showLock then
        g_ScreenLockUI.Hide()
    end
end

--显示ui
function UiBaseClass:Show()
    self.showed = true
    if not self.ui then
        return false;
    end
    self.ui:set_active(true);
    return true;
end


function UiBaseClass:IsShow()
     if not self.ui then
         return false;
     end
    -- return self.ui:get_active();

    return self.showed
end
--隐藏ui
function UiBaseClass:Hide()
    self.showed = false
    if not self.ui then
        return false;
    end
    self.ui:set_active(false);
    return true;
end

--注册回调函数
function UiBaseClass:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
    self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
end

--注销回调函数
function UiBaseClass:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

--注册消息分发回调函数
function UiBaseClass:MsgRegist()
end

--注销消息分发回调函数
function UiBaseClass:MsgUnRegist()
end

--加载UI
function UiBaseClass:LoadUI()

    if type(self._initData) == 'table' and self._initData.uiNode then
        self.ui = self._initData.uiNode
        self:InitUIUseExistNode()
        return
    end

    if self.ui or not self.pathRes then
        return false;
    end
    
    if app.get_time_scale() > 0 then
        if self.showLock then
            g_ScreenLockUI.Show()
        end
    end
    --app.log("加载资源 "..self.panel_name.." "..debug.traceback())
    self:OnLoadUI()
    self:___LoadUI()
    return true;
end


function UiBaseClass:OnLoadUI()
    SkillTips.EnableSkillTips(false);
end

--加载函数
function UiBaseClass:___LoadUI()
    self.__loadingUIId = GLoading.Show(GLoading.EType.loading);
    ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_main_ui_loaded'], self.panel_name);
    self.load_res_cnt = self.load_res_cnt + 1
end

function UiBaseClass:InitUIUseExistNode()
    GLoading.Hide(GLoading.EType.loading, self.__loadingUIId);
end

--初始化UI
function UiBaseClass:InitUI(asset_obj)
    app.log("loading界面隐藏");
    if asset_obj then
        self.ui = asset_game_object.create(asset_obj);
    end
    local parent = nil
    if type(self._initData) == 'table' and self._initData.parent ~= nil then
        parent = self._initData.parent
    else
        parent = Root.get_root_ui_2d()
    end
    local sx,sy,sz
    if type(self._initData) == 'table' and self._initData.scale ~= nil then
        sx = self._initData.scale.x
        sy = self._initData.scale.y
        sz = self._initData.scale.z
    else
        sx,sy,sz = Utility.SetUIAdaptation()
    end
    self.ui:set_parent(parent)
    self.ui:set_local_scale(sx,sy,sz);
    self.ui:set_local_position(0,0,0); 

    --恢复Copy资源原始名字
    local copy_name = self.ui:get_name()
    local name, count = string.gsub(copy_name, "%(Clone%)", "")
    if count > 0 then
        self.ui:set_name(string.gsub(name, "res_obj_", ""))
    end
end

function UiBaseClass:GetParent()
    if self.ui == nil then return Root.get_root_ui_2d() end

    return self.ui:get_parent()
end

function UiBaseClass:SetParent(parent)
    if self.ui == nil then return end

    self.ui:set_parent(parent)
end

function UiBaseClass:SetLoadedCallback(cb)
    if self:IsLoaded() then
        cb()
    else
        self.loadedCallBack = cb;
    end
end

function UiBaseClass:SetIsCallNow(v)
    self.isCallNow = v
end

function UiBaseClass:IsMainResLoaded()
    return self.ui ~= nil
end

function UiBaseClass:IsExtraResLoaded()
    return true;
end

function UiBaseClass:IsLoaded()
    return self:IsMainResLoaded() and self:IsExtraResLoaded()
end


--资源加载回调
function UiBaseClass:on_main_ui_loaded(pid, filepath, asset_obj, error_info)

    -- app.log("加载完成 "..self.panel_name)

    if filepath == self.pathRes then
        if asset_obj == nil and self.load_res_cnt < 5 then
            timer.create(self.bindfunc['load_main_ui'], 100, 1);
            return
        end
        
        if self.showLock then
            g_ScreenLockUI.Hide()
        end
        self._isLoadAsset = true;
        self:InitUI(asset_obj)
        GLoading.Hide(GLoading.EType.loading, self.__loadingUIId);

        if self.ui then
            self.ui:set_active(self.showed)
        end

        if self.isCallNow then
            self:OnLoadedCallBack()
        end
    end

    -- if CameraManager.GetSceneCameraObj() and SceneManager.GetCurrentScene() == mainCityScene then
    --     if CameraManager.GetSceneCameraObj():get_active() ~= UiBaseClass.showSceneCamera then
    --         CameraManager.GetSceneCameraObj():set_active(UiBaseClass.showSceneCamera);
    --     end
    -- end
end

function UiBaseClass:OnLoadedCallBack()
    if self.loadedCallBack then
        -- local function delay()
            self.loadedCallBack() 
            self.loadedCallBack = nil
        -- end
        -- timer.create(Utility.create_callback(delay),100,1);
    end
end

--帧更新
function UiBaseClass:Update(dt)
	if not self.ui then
		return false
	end
    return true;
end

function UiBaseClass:UpdateUi()
    if not self.ui then
		return false
	end
    return true;
end
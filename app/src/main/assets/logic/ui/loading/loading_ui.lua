Loading = Class('Loading')

-------------------------------------local声明-------------------------------------
local uuid = 0;
-------------------------------------类方法-------------------------------------
--初始化
function Loading:Init(data)
	app.log("初始化Load");
	self.pathRes = "assetbundles/prefabs/ui/loading/panel_loading.assetbundle"
	--UiBaseClass.Init(self,data);
	self.panel_name = self._className
	app.log("初始化数据");
    self:InitData(data);
    self:Restart(data);
end

function Loading:Restart(data)
	if self.ui then
		app.log("UI有误");
        return false;
    end
    self.is_destroyed = false
	app.log("注册方法");
    self:RegistFunc();
	app.log("注册消息分发回调函数");
    self:MsgRegist();
	app.log("加载资源");
    self:LoadUI();
    return true;
end

--初始化数据
function Loading:InitData(data)
	self.ui = nil;
    self.bindfunc = {};
	--确保内部不会报错
	if type(data) ~= "table" then
		app.log("data重置");
		data = {}
	end
	self.back = nil
	self.loading = nil
	self.canClick = true;
	self.type = data.type or ENUM.ELoadingType.Single
	self.scale = data.scale or ENUM.ELoadingScale.Middle
	self.parent = data.parent
	self.showTimer = {};
	self.timeout = {};
	self._timeoutTraceback = {};
end

--释放界面
function Loading:DestroyUi()
	if self.is_destroyed then
        return
    end
    self.is_destroyed = true
    if self.ui then
        self.ui:set_active(false)
        self.ui:set_parent(nil)
        self.ui = nil
    end
    self:MsgUnRegist();
    self:UnRegistFunc();
    ResourceLoader.ClearGroupCallBack(self.panel_name)

	self.canClick = true;
	self.parent = nil;
	self.back = nil
	self.loading = nil
	self.isLoading = false;
	self.showTimer = nil
	self.timeout = nil
	self._timeoutTraceback = {};
end

function Loading:IsShow()
    if not self.ui then
        return false;
    end
    return self.ui:get_active();
end

--显示
function Loading:Show(delay, auto_close_time, can_click)
    if not self.ui then
        return false;
    end
    self.ui:set_active(true);

    if self.canClick then
    	self:SetClick(can_click);
    end

    --auto_close_time = auto_close_time or 50000;
	auto_close_time = 50;
	uuid = uuid + 1;

	if delay and delay ~= 0 then
		self.showTimer[uuid] = timer.create(
			Utility.create_obj_callback(self,self.on_delay_show,0,uuid),
			delay, 1)
		if not self.isLoading then
		    self.loading:set_active(false);
		end
	else
		self.loading:set_active(true)
		self.isLoading = true;
		app.log("#lhf#show true no delay."..tostring(uuid));
	end
	
	self.timeout[uuid] = timer.create(
		Utility.create_obj_callback(self,self.on_time_out,0,uuid),
		auto_close_time, 1);
	app.log("超时响应消息输出："..tostring(self.timeout[uuid]));
	self._timeoutTraceback[uuid] = debug.traceback();
	return uuid;
end

--隐藏
function Loading:Hide(uuid)
    if not self.ui then
        return false;
    end

    if uuid then
		self.showTimer[uuid] = nil;
		if self.timeout[uuid] then
			timer.stop(self.timeout[uuid]);
		end
		self.timeout[uuid] = nil;
		self._timeoutTraceback[uuid] = nil;
	else
	    for k,v in pairs(self.showTimer) do
	    	timer.stop(v);
	    end
	    for k,v in pairs(self.timeout) do
	    	timer.stop(v);
	    end
	    self.showTimer = {};
	    self.timeout = {};
	    self._timeoutTraceback = {};
	end
	if Utility.isEmpty(self.timeout) then
		-- app.log("#lhf#hide true");
		self:SetClick(true);
		self.ui:set_active(false);
		self.loading:set_active(false)
		self.isLoading = false;
	end
end

--注册方法
function Loading:RegistFunc()
	self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['on_guide_camera_change'] = Utility.bind_callback(self, self.on_guide_camera_change);
end

--撤销注册方法
function Loading:UnRegistFunc()
	for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

--注册消息分发回调函数
function Loading:MsgRegist()
	NoticeManager.BeginListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
end

--注销消息分发回调函数
function Loading:MsgUnRegist()
	NoticeManager.EndListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
end

--加载资源
function Loading:LoadUI()
	if self.ui or not self.pathRes then
        return false;
    end
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_main_ui_loaded'], self.panel_name);
    return true;
end

--资源加载回调
function Loading:on_main_ui_loaded(pid, filepath, asset_obj, error_info)
    if filepath == self.pathRes then
        self:InitUI(asset_obj)
    end
end

--初始化界面
function Loading:InitUI(asset_obj)
	self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d())
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0); 

	self.ui:set_name("loading_ui")
	self.back = ngui.find_sprite(self.ui, "loading_ui/mark")
	self.back:set_color(1, 1, 1, 1/256);
	-- self.back:set_active(false);
	self.loading = self.ui:get_child_by_name("loading_ui/loading")
	self.isLoading = false;

	--self.lab = ngui.find_label(self.ui, "lab");
	--self.lab:set_text("");

	--存储new后马上调用接口的一些参数设置
	if self.parent then
		self:SetParent(self.parent)
	end
	if self.type then
		self:SetType(self.type)
	end
	if self.scale then
		self:SetScale(self.scale)
	end
	self:SetClick(self.canClick)
	--根据外部定义默认显示与否
	if self.show then
		self:Show();
	else
		self:Hide()								--默认隐藏	
	end

	if GuideUI and GuideUI.IsShow() then
		self:set_guide_layer(true)
	end
end

-------------------------------------接口-------------------------------------
--设置parent
function Loading:SetParent(parent)
	self.parent = parent
	if parent and self.ui then
		self.ui:set_parent(parent)
		self.ui:set_local_scale(1, 1, 1)
	end
end

--设置loading类型
function Loading:SetType(eType)
	self.type = eType
	if self.ui then
		--设置类型
		if self.type == ENUM.ELoadingType.Single then
			--self.back:set_active(false)
			self:SetScale(ENUM.ELoadingScale.Middle)			--单一Loading 默认大小 中
		elseif self.type == ENUM.ELoadingType.FullScreen then
			--self.back:set_active(true)
			self:SetScale(ENUM.ELoadingScale.Big)				--全屏Loading 默认大小 大
		end
	else
		if self.type == ENUM.ELoadingType.Single then
			self.scale = ENUM.ELoadingScale.Middle				--单一Loading 默认大小 中
		elseif self.type == ENUM.ELoadingType.FullScreen then
			self.scale = ENUM.ELoadingScale.Big					--全屏Loading 默认大小 大
		end
	end
end

--设置loading大小
function Loading:SetScale(eScale)
	if self.ui then
		for k,v in pairs(ENUM.ELoadingScale) do
			if eScale == v then
				self.scale = eScale
				--设置大小
				if self.scale == ENUM.ELoadingScale.Small then
					self.loading:set_local_scale(0.5, 0.5, 1)
				elseif self.scale == ENUM.ELoadingScale.Middle then
					self.loading:set_local_scale(1, 1, 1)
				elseif self.scale == ENUM.ELoadingScale.Big then
					self.loading:set_local_scale(2, 2, 1)
				end
			end
		end
	end
end

function Loading:SetClick(can_click)
	self.canClick = can_click;
	if self.ui then
		self.back:set_active(not self.canClick);
	end
end

-- 延时显示遮罩，菊花
function Loading:on_delay_show(uuid)
	if not self.showTimer[uuid] then
		return;
	end
	self.showTimer[uuid] = nil;
	if self.ui then
		--self.back:set_color(1, 1, 1, 1)
		self.loading:set_active(true)
		self.isLoading = true;
		self:SetClick(false);
		-- app.log("#lhf#show true:"..tostring(uuid));
	end
end

-- 超时自动关闭
function Loading:on_time_out(uuid)
	self.timeout[uuid] = nil;
	app.log("#lhf#Loading time_out!!!!:"..tostring(self._timeoutTraceback[uuid]));
	self:Hide(uuid)
end

function Loading:on_guide_camera_change(value)
	if self.noticeValue ~= value then
		self.noticeValue = value

		self:set_guide_layer(value)
	end
end

function Loading:set_guide_layer(value)
	if self.ui then
		if value then
			self.ui:set_layer(PublicStruct.UnityLayer.guide, true)
		else
			self.ui:set_layer(PublicStruct.UnityLayer.ngui, true)
		end
	end
end

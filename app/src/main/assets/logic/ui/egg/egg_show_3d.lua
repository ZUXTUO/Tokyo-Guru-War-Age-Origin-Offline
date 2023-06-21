EggShow3d = Class("EggShow3d");

local __res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_003_2.assetbundle";


function EggShow3d.SetAndShow(data)
    if EggShow3d.instance == nil then
        EggShow3d.instance = EggShow3d:new(data)
	end
end

function EggShow3d.Destroy()
    if EggShow3d.instance then
        EggShow3d.instance:DestroyUi();
        EggShow3d.instance = nil;
    end
end

function EggShow3d.GetInstance()
	return EggShow3d.instance
end

function EggShow3d.ShowRole3d()
	if EggShow3d.instance then
        EggShow3d.instance:ActiveObj()
    end
end

-------------------------------------------------------------------------------

function EggShow3d:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(__res);
end

function EggShow3d:InitData(data)
	self.pathRes = __res;
	self.bindfunc = {};
	if not data then return end

	self.roleData = data.roleData;
	--self.role3d_ui_touch = data.role3d_ui_touch;
	self.callback = data.callback;
end

function EggShow3d:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_load_role_3d'] = Utility.bind_callback(self, self.on_load_role_3d);
end

--注销回调函数
function EggShow3d:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function EggShow3d:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function EggShow3d:DestroyUi()
    self:UnRegistFunc()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3d then
		self.role3d:Destroy();
		self.role3d = nil;
	end 
end

function EggShow3d:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function EggShow3d:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("egg_show_3d");
    
    self.ui3d_root = self.ui3d:get_child_by_name("role3d_mid/can_move")
    if not self.ui3d_root then return end
    local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)

    self.objDoor = self.ui3d:get_child_by_name("role3d_mid/F_juesezhanshi_014")
    self.objDoor:set_animator_enable(false)

    if self.roleData then
        self.role3d = Role3d:new({
            parent = self.ui3d_root, 
            role_id = self.roleData.number, 
            load_call_back = self.bindfunc['on_load_role_3d'],
            --uiSp = self.role3d_ui_touch,
            is_active = false,
        });
   end
end

function EggShow3d:on_load_role_3d()
    if self.objDoor then
        self.objDoor:set_animator_enable(true)
        self.objDoor:animator_play("open")
    end
    if self.callback then
        --下一帧回调，修正立即回调instance未赋值的bug
        TimerManager.Add(self.callback, 10)
    end
end

function EggShow3d:ActiveObj()
	if self.role3d then
		self.role3d:ActiveObj()
	end
end

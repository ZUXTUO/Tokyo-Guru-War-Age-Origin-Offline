EggHero3d = Class("EggHero3d");

local __res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_005.assetbundle";


function EggHero3d.SetAndShow(data)
    if EggHero3d.instance == nil then
        app.log("EggHero3d.instance---------------------------")
        EggHero3d.instance = EggHero3d:new(data)
	else
        EggHero3d.instance:UpdateData(data);
    end
end

function EggHero3d.Destroy()
    if EggHero3d.instance then
        EggHero3d.instance:DestroyUi();
        EggHero3d.instance = nil;
    end
end

function EggHero3d.GetInstance()
	return EggHero3d.instance
end

function EggHero3d.ShowRole3d()
	if EggHero3d.instance then
        EggHero3d.instance:ActiveObj()
    end
end

-------------------------------------------------------------------------------

function EggHero3d:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(__res);
end

function EggHero3d:InitData(data)
	self.pathRes = __res;
	self.bindfunc = {};
	if not data then return end

	self.roleData = data.roleData;
	--self.role3d_ui_touch = data.role3d_ui_touch;
	self.callback = data.callback;
end

function EggHero3d:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_load_role_3d'] = Utility.bind_callback(self, self.on_load_role_3d);
end

--注销回调函数
function EggHero3d:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function EggHero3d:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function EggHero3d:DestroyUi()
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

function EggHero3d:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function EggHero3d:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("egg_hero_3d");
    
    self.ui3d_root = self.ui3d:get_child_by_name("SceneCreator/posRole")
    if not self.ui3d_root then return end
    local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)

    -- self.objfx = self.ui3d:get_child_by_name("role3d_mid/F_juesezhanshi_014")
    -- self.objfx:set_animator_enable(false)

    if self.roleData then
        app.log("roleData is nil---------------------------")
        self.role3d = Role3d:new({
            parent = self.ui3d_root, 
            role_id = self.roleData.number, 
            iseggshow = true,
            is_active = false,
            load_call_back = self.bindfunc['on_load_role_3d'],
        });
    end

    app.log("roleData is role 3d---------------------------"..tostring(self.role3d))
end

function EggHero3d:on_load_role_3d()
    -- if self.objfx then
    --     self.objfx:set_animator_enable(true)
    --     self.objfx:animator_play("play")
    -- end

    if self.callback then
        --app.log("on_load_role_3d..callback")
        Utility.CallFunc(self.callback)
    end
end

function EggHero3d:UpdateData(data)
    self.roleData = data.roleData;
    --self.role3d_ui_touch = data.role3d_ui_touch;
    self.callback = data.callback;
        
    if data.roleData then
        self.roleid = data.roleData.number; 
    else
        self.roleid = 0;
    end
        
    if self.ui3d_root == nil or self.role3d == nil then return end

    if self.roleData then
        local role_id = data.roleData.number;
        self.role3d:ChangeObj(role_id);
        --self.role3d:SetGray(self.isGray);
        --self:Show();
    else
        self.role3d:Destroy()
        self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback});
    end

    self.role3d:SetLoadCallBack(self.callback)
end

function EggHero3d:ActiveObj()
    app.log("EggHero3d:ActiveObj1"..tostring(self.role3d))
	if self.role3d then
        app.log("EggHero3d:ActiveObj2")
		self.role3d:ActiveObj()
	end
end

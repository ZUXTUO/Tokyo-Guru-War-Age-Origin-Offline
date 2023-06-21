--region screen_lock_ui.lua
--author : zzc
--date   : 2015/12/04

------------------------------------- 外部函数接口 -------------------------------------
--- 对象1 ---
g_ScreenLockUI = {}

-- 游戏初始化构造实例对象
function g_ScreenLockUI.Create()
    if not g_ScreenLockUI.instance then
        g_ScreenLockUI.instance = ScreenLockUI:new('1');
    end
end

function g_ScreenLockUI.Destroy()
    if g_ScreenLockUI.instance then
        g_ScreenLockUI.instance:DestroyUi();
        g_ScreenLockUI.instance = nil;
    end
end

-- 显示
function g_ScreenLockUI.Show()
    if g_ScreenLockUI.instance then
        g_ScreenLockUI.instance:Show();
    end
end

function g_ScreenLockUI.IsShow()
    if g_ScreenLockUI.instance then
        return g_ScreenLockUI.instance:IsShow();
    end
    return false
end

function g_ScreenLockUI.Hide()
    if g_ScreenLockUI.instance then
        g_ScreenLockUI.instance:Hide();
    end
end


--- 对象2 新手引导专用 ---
g_GuideLockUI = {}

-- 游戏初始化构造实例对象
function g_GuideLockUI.Create()
    if not g_GuideLockUI.instance then
        g_GuideLockUI.instance = ScreenLockUI:new('2');
    end
end

function g_GuideLockUI.Destroy()
    if g_GuideLockUI.instance then
        g_GuideLockUI.instance:DestroyUi();
        g_GuideLockUI.instance = nil;
    end
end

-- 显示
function g_GuideLockUI.Show()
    if g_GuideLockUI.instance then
        g_GuideLockUI.instance:Show();
    end
end

function g_GuideLockUI.Hide()
    if g_GuideLockUI.instance then
        g_GuideLockUI.instance:Hide();
    end
end


--- 对象3 其他独立界面使用 ---
g_SingleLockUI = {}

-- 游戏初始化构造实例对象
function g_SingleLockUI.Create()
    if not g_SingleLockUI.instance then
        g_SingleLockUI.instance = ScreenLockUI:new('3');
    end
end

function g_SingleLockUI.Destroy()
    if g_SingleLockUI.instance then
        g_SingleLockUI.instance:DestroyUi();
        g_SingleLockUI.instance = nil;
    end
end

-- 显示
function g_SingleLockUI.Show()
    if g_SingleLockUI.instance then
        g_SingleLockUI.instance:Show();
    end
end

function g_SingleLockUI.Hide()
    if g_SingleLockUI.instance then
        g_SingleLockUI.instance:Hide();
    end
end



--- 全屏锁定UI ---
ScreenLockUI = Class('GuildLookUI')

-------------------------------------local声明-------------------------------------

local _local = {};
_local.pathRes = 'assetbundles/prefabs/ui/public/panel_screen_lock.assetbundle';

------------------------------- 内部接口，不要继承UiBaseClass -------------------------------

--初始化
function ScreenLockUI:Init(data)
	self.name = data or ""
	self.ui = nil;
    self.showed = false;

    self:RegistFunc()

    --加载UI
    ResourceLoader.LoadAsset(_local.pathRes, self.bindfunc['on_loaded']);
end

--注册回调函数
function ScreenLockUI:RegistFunc()
	self.bindfunc = {};
    self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function ScreenLockUI:UnRegistFunc()
	Utility.unbind_callback(self, "on_loaded");
	self.bindfunc = {}
end

--资源加载完成
function ScreenLockUI:on_loaded(pid, filepath, asset_obj, error_info)
    if filepath == _local.pathRes then
    	self:InitUI(asset_obj);
    end
end

--初始化UI
function ScreenLockUI:InitUI(asset_obj)
	self.ui = asset_game_object.create(asset_obj);

	self.ui:set_parent(Root.get_root_ui());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("screen_lock_" .. self.name);

    local objCollider = self.ui:get_child_by_name("ui_screen_lock")
    objCollider:set_active(true)
	
	self.ui:set_active(self.showed)
end

--显示UI
function ScreenLockUI:Show()
	self.showed = true
	if self.ui then
		self.ui:set_active(true)
	end
end

--隐藏UI
function ScreenLockUI:Hide()
	self.showed = false
	if self.ui then
        self.ui:set_active(false)
    end
end

--是否显示
function ScreenLockUI:IsShow()
	return self.showed
end

--释放界面
function ScreenLockUI:Destroy()
	self:Hide()

	self.ui = nil;
	self:UnRegistFunc();
end


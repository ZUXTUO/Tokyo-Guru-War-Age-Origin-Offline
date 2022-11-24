CommonLeave = Class("CommonLeave", MultiResUiBaseClass);
--------------------外部接口-------------------------
--jumpFunctionList跳转功能	{ENUM.ELeaveType, ENUM.ELeaveType, ENUM.ELeaveType}
function CommonLeave.Start(jumpFunctionList, isRelive)
	if CommonLeave.cls == nil then
		CommonLeave.cls = CommonLeave:new({
			jumpFunctionList=jumpFunctionList, 
			isRelive=isRelive, 
			});
	end
end


function CommonLeave.SetFinishCallback(callback, obj)
	if CommonLeave.cls then
		CommonLeave.cls.callbackFunc = callback;
		if CommonLeave.cls.callbackFunc then
			CommonLeave.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonLeave.Destroy()
	if CommonLeave.cls then
		CommonLeave.cls:DestroyUi();
		CommonLeave.cls = nil;
	end
end

--------------------内部接口-------------------------
local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/level/ui_707_level.assetbundle'
}

local _UIText = 
{
    [1] = '点击屏幕任意位置关闭',
}

function CommonLeave:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end
local leaveTypeToUi = {};
local levelTypeToUiParam = {}
local leaveTypeToUiText = {};
local levelTypeToUiIcon = {};
local levelTypeToActivityid = {};
function CommonLeave:InitData(data)
	MultiResUiBaseClass.InitData(self, data);
	--外部数据相关
	self.data = data;
	--ui相关
	self.uiControl = {};
	--内部变量相关
	leaveTypeToUi[ENUM.ELeaveType.PlayerLevelUp] = EUI.BattleUI;
	leaveTypeToUi[ENUM.ELeaveType.EquipLevelUp] = EUI.EquipPackageUI;
	--leaveTypeToUi[ENUM.ELeaveType.EquipComposite] = EUI.EquipCompoundUI;
    leaveTypeToUi[ENUM.ELeaveType.HeroEgg] = EUI.EggHeroUi;

    levelTypeToActivityid[ENUM.ELeaveType.PlayerLevelUp] = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeLevel;
    levelTypeToActivityid[ENUM.ELeaveType.EquipLevelUp] = MsgEnum.eactivity_time.eActivityTime_EquipLevel;
    levelTypeToActivityid[ENUM.ELeaveType.HeroEgg] = MsgEnum.eactivity_time.eActivityTime_Recruit;

	levelTypeToUiParam[ENUM.ELeaveType.PlayerLevelUp] = {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeLevel}
	
	leaveTypeToUiText[ENUM.ELeaveType.PlayerLevelUp] = "提升角色等级";
	leaveTypeToUiText[ENUM.ELeaveType.EquipLevelUp] = "提升装备等级";
	--leaveTypeToUiText[ENUM.ELeaveType.EquipComposite] = "装备合成";
    leaveTypeToUiText[ENUM.ELeaveType.HeroEgg] = "强力角色招募"

	levelTypeToUiIcon[ENUM.ELeaveType.PlayerLevelUp] = "assetbundles/prefabs/ui/image/icon/fan_xiang_yin_dao/fxyd_juese.assetbundle";
	levelTypeToUiIcon[ENUM.ELeaveType.EquipLevelUp] = "assetbundles/prefabs/ui/image/icon/fan_xiang_yin_dao/fxyd_zhuangbei.assetbundle";
    levelTypeToUiIcon[ENUM.ELeaveType.HeroEgg] = "assetbundles/prefabs/ui/image/icon/fan_xiang_yin_dao/fxyd_zhaomu.assetbundle";

	CommonClearing.canClose = false
end

function CommonLeave:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
end

function CommonLeave:InitedAllUI()

    self.ui = self.uis[resPaths[resType.Front]]
	self.tipCloseLabel = ngui.find_label(self.ui, "txt")

	local control = self.uiControl;
	--升级方式
	control.objOdd = self.ui:get_child_by_name("animation/grid");
	control.gridOdd = ngui.find_grid(control.objOdd, control.objOdd:get_name());
	--control.objEven = self.ui:get_child_by_name("content_2");
	control.listOdd = {};
	control.listEven = {};
	for i = 1, 3 do
		control.listOdd[i] = {};
		control.listOdd[i].objRoot = control.objOdd:get_child_by_name("sp_bk"..i);
		control.listOdd[i].btnRoot = ngui.find_button(control.listOdd[i].objRoot, "sp_bk"..i);
		control.listOdd[i].btnRoot:set_on_click(self.bindfunc["OnClose"]);
		control.listOdd[i].labName = ngui.find_label(control.listOdd[i].objRoot, "lab1");
		control.listOdd[i].textureIcon = ngui.find_texture(control.listOdd[i].objRoot, "Texture");
	end
	local btn = ngui.find_button(self.ui, "sp_mark");
	btn:set_event_value(tostring(ENUM.ELeaveType.Leave), 0);
	btn:set_on_click(self.bindfunc["OnClose"]);
	self.tipCloseLabel:set_text(_UIText[1])
	self:UpdateUi();

	CommonClearing.OnUiLoadFinish(ECommonEnd.eCommonEnd_jump);
end

function CommonLeave:UpdateUi()
	if not MultiResUiBaseClass.UpdateUi(self) then
		return;
	end
	AudioManager.Stop(nil, true);
	AudioManager.PlayUiAudio(81010001)
	--app.log(table.tostring(self));
	local data = self.data;
	local control = self.uiControl;

    local controlData = control.listOdd

	local jfl = data.jumpFunctionList;
	local activityid = nil;
	--更新功能
	for i = 1, 3 do
		if controlData and controlData[i] then
			if i <= #jfl and jfl[i] >= ENUM.ELeaveType.PlayerLevelUp then
				activityid = levelTypeToActivityid[jfl[i]];
				if not activityid or PublicFunc.FuncIsOpen(activityid) then
					controlData[i].objRoot:set_active(true);
					controlData[i].btnRoot:set_event_value(tostring(jfl[i]), 0);
					controlData[i].labName:set_text(tostring(leaveTypeToUiText[jfl[i]]));
					controlData[i].textureIcon:set_texture(levelTypeToUiIcon[jfl[i]])
				else
					controlData[i].objRoot:set_active(false);
				end
			else
				controlData[i].objRoot:set_active(false);
			end
		end
	end
	control.gridOdd:reposition_now();
end

function CommonLeave:OnClose(t)

	if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

	--外部数据相关
	local isRelive = self.data.isRelive;
	for k, v in pairs(self.data) do
		self.data[k] = nil;
	end

	if self.uiControl then
		local items = self.uiControl.listOdd
		for k, item in pairs(items) do
			item.textureIcon:Destroy()
		end
	end

	self.data = nil;
	--ui相关
	if CommonLeave.cls then
		CommonLeave.cls:DestroyUi();
		CommonLeave.cls = nil;
	end
	self.uiControl = nil;
	--向主界面push一个ui
	self:PushUi(t.string_value);
	--内部变量相关
	local oldCallback = self.callbackFunc;
	local oldCallObj = self.callbackObj;
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
	end
	if oldCallback == self.callbackFunc and oldCallObj == self.callbackObj then
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end

end

function CommonLeave:PushUi(strLeaveType)
	local leaveType = tonumber(strLeaveType);
	if leaveType >= ENUM.ELeaveType.PlayerLevelUp then
		--app.log(tostring(leaveTypeToUi[leaveType]))
        local uiMgr = FightScene.GetCurrentUpSceneUIMgr()
        if uiMgr then
			local uiid = leaveTypeToUi[leaveType]
            local ui = uiMgr:PushUi(uiid, levelTypeToUiParam[leaveType]);
        end
	end
end

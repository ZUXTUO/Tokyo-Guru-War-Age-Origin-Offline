CommonDead = Class("CommonDead", UiBaseClass);

--------------------外部接口-------------------------
--info = {reliveTime=10, relive = 100, title=""}
function CommonDead.Start(info)
	if CommonDead.cls == nil then
		CommonDead.cls = CommonDead:new(info);
		GetMainUI():FilterReliveInfo(true)
	end
end


function CommonDead.SetFinishCallback(callback, obj)
	if CommonDead.cls then
		CommonDead.cls.callbackFunc = callback;
		if CommonDead.cls.callbackFunc then
			CommonDead.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonDead.SetRelive(callback, obj)
	if CommonDead.cls then
		CommonDead.cls.callbackRelive = callback;
		if CommonDead.cls.callbackRelive then
			CommonDead.cls.callbackReliveObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonDead.SetLeave(callback, obj)
	if CommonDead.cls then
		CommonDead.cls.callbackLeave = callback;
		if CommonDead.cls.callbackLeave then
			CommonDead.cls.callbackLeaveObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonDead.Destroy()
	if CommonDead.cls then
		GetMainUI():FilterReliveInfo(false)
		CommonDead.cls:DestroyUi();
		CommonDead.cls = nil;
	end
end

--------------------内部接口-------------------------

local pathRes = "assetbundles/prefabs/ui/new_fight/ui_823_fight.assetbundle";

function CommonDead:Init(data)
	self.pathRes = pathRes
	UiBaseClass.Init(self, data);
end

function CommonDead:InitData(data)
	UiBaseClass.InitData(self, data);
	--外部数据相关
	self.data = data;
	--ui相关
	self.uiControl = {};
	--内部变量相关
	self.callbackFunc = nil
	self.callbackObj = nil
	self.callbackRelive = nil
	self.callbackReliveObj = nil
	self.tmTimer = nil;
        self.autoTimer = nil;
end

function CommonDead:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnSureLeave"] = Utility.bind_callback(self,self.OnSureLeave);
    self.bindfunc["OnRelive"] = Utility.bind_callback(self,self.OnRelive);
    self.bindfunc["OnUpdateTimer"] = Utility.bind_callback(self,self.OnUpdateTimer);
    self.bindfunc["OnLeave"] = Utility.bind_callback(self,self.OnLeave);
    self.bindfunc["OnSetAutoRelive"] = Utility.bind_callback( self, self.OnSetAutoRelive );
    self.bindfunc["OnAutoRelive"] = Utility.bind_callback( self, self.OnAutoRelive );
end

function CommonDead:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("CommonDead");

	local control = self.uiControl;

    --倒计时
    --control.lab_title = ngui.find_label(self.ui, "centre_other/txt_title");
	control.labTimer = ngui.find_label(self.ui, "centre_other/lab_time");
	--离开
	control.btnLeave = ngui.find_button(self.ui, "centre_other/animation/btn_leave");
	if self.data.leaveConfirm == false then
		control.btnLeave:set_on_click(self.bindfunc["OnLeave"]);
	else
		control.btnLeave:set_on_click(self.bindfunc["OnSureLeave"]);
	end
	--复活
	control.objRelive = self.ui:get_child_by_name("centre_other/cont");
	control.labRelive = ngui.find_label(control.objRelive, "lab");
	control.btnRelive = ngui.find_button(control.objRelive, "sp_safety");
	control.btnRelive:set_on_click(self.bindfunc["OnRelive"]);
    control.spCrystal = ngui.find_sprite( self.ui, "centre_other/cont/sp_crystal" );
    control.crystalShowObj = self.ui:get_child_by_name("centre_other/cont/content");
    control.labFreeRelive = ngui.find_label(control.objRelive, "lab_num");
    control.toggleAuto = ngui.find_toggle( self.ui, "centre_other/sp_toggle_di" );
    if control.toggleAuto then 
        control.toggleAuto:set_on_change( self.bindfunc["OnSetAutoRelive"] );
        if self.data.fightType and self.data.fightType == 1 then
	        control.toggleAuto:set_active( true )
	        control.toggleAuto:set_value( g_dataCenter.guildBoss.isAutoRelive );
		else
			control.toggleAuto:set_active(false)
	    end
    end
    --fy添加，如果是社团boss战的话就显示勾选的选项
        
        
	self:UpdateUi();
end

function CommonDead:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return;
	end
	--app.log(table.tostring(self));
	local data = self.data;
	local control = self.uiControl;
	--复活时间
	if type(data.reliveTime) == "number" then

		control.labTimer:set_active(true);
		local m = math.floor(data.reliveTime / 60);
		local s = data.reliveTime - m * 60;
		control.labTimer:set_text(string.format("%02d:%02d", m, s));
		data.reliveTime = data.reliveTime - 1;
		if self.tmTimer == nil then
			self.tmTimer = timer.create(self.bindfunc["OnUpdateTimer"], 1000, -1);
		end
                
                --添加自动复活相关内容fy
                if g_dataCenter.guildBoss.isAutoRelive then
                    self.isAutoTimer = timer.create( self.bindfunc["OnAutoRelive"], 2000, 1 );
                end
	else
		control.labTimer:set_active(false);
	end
        local freeRelive = 0;
        if self.data.fightType and self.data.fightType == 1 then
            freeRelive = ConfigManager.Get( EConfigIndex.t_guild_boss_free_relive_times, g_dataCenter.guildBoss.curFreeReliveCountLevel ).param1 - g_dataCenter.guildBoss.haveReliveTimes;
       	end
        
        local txt = "剩余免费复活次数:"..tostring( freeRelive );

        
	--复活
	
        
    if freeRelive > 0 then
    	control.crystalShowObj:set_active(false);
    	control.labFreeRelive:set_active(true);
    	control.labFreeRelive:set_text( txt );
        --control.labRelive:set_text( txt );
        --control.spCrystal:set_active( false );
    else
    	control.crystalShowObj:set_active(true);
    	control.labFreeRelive:set_active(false);
        --control.spCrystal:set_active( true );
        if data.relive and data.relive > 0 then
			control.labRelive:set_text(tostring(data.relive));
		else
			control.labRelive:set_text("本次免费");
		end
    end
        
	--[[if data.title then
		control.lab_title:set_active(true);
		control.lab_title:set_text(tostring(data.title));
	else
		control.lab_title:set_active(false);
	end]]
end

function CommonDead:DestroyUi()
	UiBaseClass.DestroyUi(self)
	--外部数据相关
	if self.data then
		for k, v in pairs(self.data) do
			self.data[k] = nil;
		end
		self.data = nil;
	end
	self.uiControl = nil;
	--内部变量相关
	if self.tmTimer then
		timer.stop(self.tmTimer);
		self.tmTimer = nil;
	end
        
        if self.autoTimer and self.autoTimer > 0 then
            timer.stop( self.autoTimer );
            self.autoTimer = nil;
        end
    local hint_content = HintUI.GetCurShowContent()
    if hint_content == "暂时离开后会退出战场。\n活动未结束前可以再次参加，是否离开？" then
    	HintUI.Close()
    end
end

function CommonDead:OnRelive(t)
	--特殊情况先回调 因为这可能牵扯到衔接动画
	local oldCallback = self.callbackRelive;
	local oldCallObj = self.callbackReliveObj;
	if oldCallback then
		oldCallback(oldCallObj);
	end
	-- if oldCallback == self.callbackRelive and oldCallObj == self.callbackReliveObj then
	-- 	self.callbackRelive = nil;
	-- 	self.callbackReliveObj = nil;
	-- end
	-- CommonDead.Destroy();
end

function CommonDead:OnLeave(t)
	--特殊情况先回调 因为这可能牵扯到衔接动画
	local oldCallback = self.callbackLeave;
	local oldCallObj = self.callbackLeaveObj;
	if oldCallback then
		oldCallback(oldCallObj);
	end
	if oldCallback == self.callbackLeave and oldCallObj == self.callbackLeaveObj then
		self.callbackLeave = nil;
		self.callbackLeaveObj = nil;
	end
	CommonDead.Destroy();
end

function CommonDead:OnSureLeave(t)
	local btn1 = {str = "否",};
	local btn2 = {str = "是",func = self.bindfunc["OnLeave"]}
	HintUI.SetAndShow(EHintUiType.two, "暂时离开后会退出战场。\n活动未结束前可以再次参加，是否离开？", btn2, btn1);
end

function CommonDead:OnTimeEnd()
	--特殊情况先回调 因为这可能牵扯到衔接动画
	local oldCallback = self.callbackFunc;
	local oldCallObj = self.callbackObj;
	if oldCallback then
		oldCallback(oldCallObj);
	end
	if oldCallback == self.callbackFunc and oldCallObj == self.callbackObj then
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end
	CommonDead.Destroy();
end

function CommonDead:OnUpdateTimer()
	local data = self.data;
	local control = self.uiControl;
	if type(data.reliveTime) == "number" then
		local m = math.floor(data.reliveTime / 60);
		local s = data.reliveTime - m * 60;
		control.labTimer:set_text(string.format("%02d:%02d", m, s));
		data.reliveTime = data.reliveTime - 1;
		if data.reliveTime < 0 then
			timer.stop(self.tmTimer);
			self.tmTimer = nil;
			self:OnTimeEnd();
		-- else
		-- 	local m = math.floor(data.reliveTime / 60);
		-- 	local s = data.reliveTime - m * 60;
		-- 	control.labTimer:set_text(string.format("%02d:%02d", m, s));
		-- 	data.reliveTime = data.reliveTime - 1;
                    if self.autoTimer and self.autoTimer > 0 then
                        timer.stop( self.autoTimer );
                        self.autoTimer = nil;
                    end
		end
	end
end

--设置是否自动复活
function CommonDead:OnSetAutoRelive( value, name )
    if self.data.fightType and self.data.fightType == 1 then
        g_dataCenter.guildBoss:SetAutoRelive( value );
    end
    if not value then
        if self.autoTimer and self.autoTimer > 0 then
            timer.stop( self.autoTimer );
            self.autoTimer = 0;
        end
    end
end

function CommonDead:OnAutoRelive( timerID )
    self.isAutoTimer = nil;
    --判断是否能原地复活，免费次数或者钻石数量
    local isCanAutoRelive = true;
    local cf = ConfigManager.Get( EConfigIndex.t_guild_boss, g_dataCenter.guildBoss.curRoundIndex );
    if cf then
        local num = PropsEnum.GetValue( IdConfig.Crystal );
        if not g_dataCenter.guildBoss:GetIsCanFreeRelive() and num < cf.crystal_relive_cost then
            isCanAutoRelive = false;
        end
    else
        isCanAutoRelive = false;
    end
    if isCanAutoRelive then
        if self.tmTimer then
           timer.stop( self.tmTimer );
           self.tmTimer = nil;
        end
        self:OnRelive();
    else
        --关闭自动复活
        g_dataCenter.guildBoss:SetAutoRelive( false );
    end
end

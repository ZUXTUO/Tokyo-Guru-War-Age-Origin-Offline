AdvFuncButton = Class('AdvFuncButton',UiBaseClass);
--重新开始
function AdvFuncButton:Restart(data)
    --app.log("AdvFuncButton:Restart");
    UiBaseClass.Restart(self, data);
end

AdvFuncButton.isShow = false;

function AdvFuncButton:InitData(data)
    --app.log("AdvFuncButton:InitData");
    UiBaseClass.InitData(self, data);
	self.playerlevel = g_dataCenter.player.level;
    self.msg = nil;
	self.camera = Root.get_ui_camera();
	self.cfgAreaOpenLevel = ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_Area).open_level

	if not AppConfig.get_enable_guide() then
		AdvFuncButton.CheckChangeArea()
	end
end

function AdvFuncButton:RegistFunc()
	--app.log("AdvFuncButton:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['click_to_open'] = Utility.bind_callback(self, AdvFuncButton.click_to_open);
	self.bindfunc['on_player_level_change'] = Utility.bind_callback(self, AdvFuncButton.on_player_level_change);
	self.bindfunc['on_ui_scene_change'] = Utility.bind_callback(self, AdvFuncButton.on_ui_scene_change);
	self.bindfunc['on_press_button'] = Utility.bind_callback(self, AdvFuncButton.on_press_button);
	self.bindfunc['OnUiManagerRestart'] = Utility.bind_callback(self, AdvFuncButton.OnUiManagerRestart);
	self.bindfunc['OnPushUi'] = Utility.bind_callback(self, AdvFuncButton.OnPushUi);
end

function AdvFuncButton:on_press_button(name,isStart,x,y,obj)
	if isStart == true then 
		Tween.addTween(self.vs.spdi:get_game_object(),0.1,{["local_scale"] = {1.1,1.1,1.1}});
	else 
		Tween.addTween(self.vs.spdi:get_game_object(),0.1,{["local_scale"] = {1,1,1}});
	end
end 

function AdvFuncButton:click_to_open(name,x,y,obj,string_value)
	--app.log("click_to_open");
	Tween.addTween(self.vs.spdi:get_game_object(),0.1,{["local_scale"] = {1,1,1}});
	AdvFuncPanel.ShowAdvanceFunction();
end 

function AdvFuncButton:flyEffect(position)
	local distance = g_distance({x = 0,y = 0},position);
	local startAngle = 0;
	if position.x == 0 then 
		if position.y > 0 then 
			startAngle = math.pi/2;
		elseif position.y < 0 then 
			startAngle = -math.pi/2;
		else
			startAngle = 0; 
		end 
	else
		if position.x > 0 then 
			startAngle = math.atan(position.y/position.x);
		else 
			startAngle = math.atan(position.y/position.x) + math.pi;
		end
	end 
	local flyEffects = self.flyEffects or {};
	local startAngles = self.startAngles or {};
	self.flyEffects = flyEffects;
	self.startAngles = startAngles;
	local tobj = self.tobj or {};
	tobj.effectValue = 0;
	function tobj:get_pid()
		self.pid = self.pid or "t"..tostring(math.random(1000000,9999999));
		--app.log("TOBJ PID = "..self.pid);
		return self.pid;
	end 
    local ids = FightScene.CreateEffect(position, ConfigManager.Get(EConfigIndex.t_effect_data,19016), nil, nil, nil, nil, 0, nil, nil, nil)
    for k,id in pairs(ids) do
        flyEffects[id] = EffectManager.GetEffect(id);
        flyEffects[id]:set_parent(self.ui);
		startAngles[id] = startAngle;
		local effObj = flyEffects[id]:getNode();
		effObj:set_layer(PublicStruct.UnityLayer.ngui, true);
    end
    if flyEffects then
        for k,effect in pairs(flyEffects) do
            effect:set_active(true);
        end
		local onOver = function()
			--app.log("onOver");
			for k,v in pairs(flyEffects) do 
				v:set_active(false);
			end
			if AdvFuncPanel.instance == nil then 
				AdvFuncPanel.ShowAdvanceFunction(true);
			end
			self.startAngles = nil;
			self.flyEffects = nil;
			self.tobj = nil;
		end 
		local onUpdate = function()
			for k,v in pairs(flyEffects) do 
				local angle = startAngles[k] + math.pi * tobj.effectValue;
				local px = math.cos(angle) * distance * (1 - tobj.effectValue);
				local py = math.sin(angle) * distance * (1 - tobj.effectValue);
				v:set_local_position(px,py,0);
			end
		end
		if self.tobj == nil then 
			Tween.addTween(tobj,2,{effectValue = 1},Transitions.EASE_OUT_BACK,0,nil,onUpdate,onOver)
		end 
    end
	self.tobj = tobj;
end

function AdvFuncButton:on_player_level_change() 
	if self.playerlevel == nil then 
		self:UpdateUi();
	else 
		if self.playerlevel ~= g_dataCenter.player.level then 
			self:UpdateUi();
		end
	end
end 

function AdvFuncButton:on_ui_scene_change(scene_id)
	--app.log("scene_change : "..tostring(scene_id));
	if scene_id == EUI.MMOMainUI and uiManager:GetUICount() == 1 then 
		self:UpdateUi();
	elseif AdvFuncButton.isInFunctionTipProgress == true then 
		--app.log("deleteAdvShow");
		g_SingleLockUI.Hide();
		Tween.removeTween(self.tobj);
		self.flyEffects = self.flyEffects or {};
		for k,v in pairs(self.flyEffects) do 
			v:set_active(false);
		end 
		self.startAngles = nil;
		self.flyEffects = nil;
		self.tobj = nil;
		if AdvFuncPanel.instance ~= nil then 
			AdvFuncPanel.instance:DestroyUi();
		end 
		AdvFuncButton.isInFunctionTipProgress = false;
		g_dataCenter.player.advOldLevel = g_dataCenter.player.level - 1;
	end
end 

function AdvFuncButton.initConfig()
	local cf = ConfigManager._GetConfigTable(EConfigIndex.t_play_vs_data);
	AdvFuncButton.allFuncConfig = cf;
	AdvFuncButton.openCfs = {};
	local temp = {};
	
	local allActivityTimeCf = ConfigManager._GetConfigTable(EConfigIndex.t_activity_time);
	
	for k,v in pairs(allActivityTimeCf) do 
		if v.open == 1 then 
			table.insert(temp,v);
		end
	end 
	allActivityTimeCf = temp;
	temp = {};
	local allPlayUiListCf = ConfigManager._GetConfigTable(EConfigIndex.t_play_ui_list);
	local allPlayVsListCf = ConfigManager._GetConfigTable(EConfigIndex.t_vs_ui_list);
	local allPlayDuelListCf = ConfigManager._GetConfigTable(EConfigIndex.t_duel_ui_list);
	local allClanListCf = ConfigManager._GetConfigTable(EConfigIndex.t_clan_list);
	for k,v in pairs(cf) do 
		if v.notice_level and v.notice_level ~= 0 and v.open_level < 1000 then 
			table.insert(temp,v);
			v.menu_button_id = v.id;
			for kk,vv in pairs(allPlayUiListCf) do 
				if vv.id == v.id then 
					v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Playing;
					break;
				end
			end
			for kk,vv in pairs(allActivityTimeCf) do 
				if vv.id == v.id then 
					v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Playing;
					break;
				end
			end
			for kk,vv in pairs(allPlayVsListCf) do 
				if vv.id == v.id then 
					v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Fight;
				end
			end
			for kk,vv in pairs(allPlayDuelListCf) do
				if vv.id == v.id then
					v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Duel;
				end
			end
			for kk,vv in pairs(allClanListCf) do 
				if vv.id == v.id then 
					v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Battle;
				end
			end
			if v.id == MsgEnum.eactivity_time.eActivityTime_EliteLevel then 
				v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Adventure;
			end
			--装备升级
			if v.id == MsgEnum.eactivity_time.eActivityTime_EquipLevel then 
				v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Hero;
			end
			--装备升星
			if v.id == MsgEnum.eactivity_time.eActivityTime_EquipStar then 
				v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Hero;
			end
			--神秘商店
			if v.id == MsgEnum.eactivity_time.eActivityTime_ShopMystery then 
				v.menu_button_id = MsgEnum.eactivity_time.eActivityTime_Shop;
			end
		end 
	end 
	function comps(a,b)
		return a.notice_level < b.notice_level
	end
	table.sort(temp,comps);
	AdvFuncButton.allFuncConfig = temp;
	--[[local str = ""
	for k,v in pairs(temp) do 
		str = str.."##功能名："..v.name.."\t预告等级："..tostring(v.notice_level).."\t开启等级："..tostring(v.open_level).."\t##\n";
	end 
	app.log(str);--]]
	AdvFuncButton.advCf = {};
	for k,v in pairs(AdvFuncButton.allFuncConfig) do 
		local i = 0;
		for i = v.notice_level,v.open_level-1 do 
			AdvFuncButton.advCf[i] = v;
		end
	end
	--[[local str = ""
	for k,v in pairs(AdvFuncButton.advCf) do 
		str = str.."##等级:\t"..tostring(k).."，预告功能:\t"..tostring(v.name).."##\n";
	end 
	app.log(str);--]]
	for k,v in pairs(AdvFuncButton.allFuncConfig) do 
		AdvFuncButton.openCfs[v.open_level] = v;
	end
end 

function AdvFuncButton:UpdateUi()
	self.playerlevel = g_dataCenter.player.level;
	local cf = AdvFuncButton.advCf[self.playerlevel];
	local mainUI = GetMainUI();
	local curScene = uiManager:GetCurScene();
	if mainUI == curScene then 
		local openCf = AdvFuncButton.openCfs[self.playerlevel];
		if openCf ~= nil then 
			local advOldLevel = g_dataCenter.player.advOldLevel;
			if advOldLevel ~= self.playerlevel then 
				AdvFuncButton.isInFunctionTipProgress = true;
				g_dataCenter.player.advOldLevel = g_dataCenter.player.level;
				self:flyEffect({x=self.effX,y=self.effY,z=self.effZ});
				self:flyEffect({x=-self.effX,y=self.effY,z=self.effZ});
				self:flyEffect({x=0,y=self.effX,z=self.effZ});
				self:flyEffect({x=0,y=-self.effX,z=self.effZ});
				AudioManager.PlayUiAudio(81200043);
				g_SingleLockUI.Show();
				--oldData.level = g_dataCenter.player.level;
			end
		end 
	end 
	if cf ~= nil then 
		self.currentCf = cf;
		AdvFuncPanel.showCf = cf;
		self.vs.labOpenLevel:set_text(tostring(cf.open_level).."级开启");
		if file.exist(tostring(cf.icon_path)) then 
			self.vs.iconTexture:set_texture(tostring(cf.icon_path));
		end 
		--self.vs.title:set_sprite_name(tostring(cf.title_path));
        self.vs.labTitle:set_text(cf.name)
		self.vs.centre_other:set_active(true);
		AdvFuncButton.isShow = true;
	else 
		self.vs.centre_other:set_active(false);
		AdvFuncButton.isShow = false;
	end
	PublicFunc.msg_dispatch("showAdvFuncPanel",AdvFuncButton.isShow);
end 

function AdvFuncButton.onTimeOver()
	if AdvFuncButton.current ~= nil then
		AdvFuncButton.current.ui:set_active(false);
	end
end 

function AdvFuncButton:InitUI(asset_obj)
	AdvFuncButton.instance = self;
	--app.log("AdvFuncButton:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	AdvFuncButton.current = self;
    self.ui:set_name('AdvFuncButton');
    self.vs = {};
    self.vs.centre_other = ngui.find_widget(self.ui,"centre_other");
    self.vs.iconTexture = ngui.find_texture(self.ui,"centre_other/sp_di/texture");
    --self.vs.title = ngui.find_sprite(self.ui,"centre_other/sp_di/sp_art_font");
    self.vs.labTitle = ngui.find_label(self.ui,"centre_other/sp_di/lab");
    self.vs.labOpenLevel = ngui.find_label(self.ui,"centre_other/sp_di/lab_level")	
	self.vs.spdi = ngui.find_button(self.ui,"centre_other/sp_di");
	self.vs.spdi:set_on_ngui_click(self.bindfunc['click_to_open']);
	self.vs.spdi:set_on_ngui_press(self.bindfunc['on_press_button']);
	self.effX,self.effY,self.effZ = PublicFunc.GetUiScreenPos(self.vs.iconTexture);
	--self.vs.iconTexture:set_parent(self.vs.spdi:get_game_object());
	self:UpdateUi();
end

function AdvFuncButton:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/advfuncnotice/ui_4802_function.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function AdvFuncButton:DestroyUi()
	AdvFuncButton.instance = nil;
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
end

--显示ui
function AdvFuncButton:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function AdvFuncButton:Hide()
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function AdvFuncButton:MsgRegist()
    UiBaseClass.MsgRegist(self);

	PublicFunc.msg_regist(player.gc_update_player_exp_level,self.bindfunc['on_player_level_change']);
	PublicFunc.msg_regist(UiManager.SetStackSize,self.bindfunc['on_ui_scene_change']);
	PublicFunc.msg_regist(UiManager.PopUi,self.bindfunc['on_ui_scene_change']);
	NoticeManager.BeginListen(ENUM.NoticeType.UiManagerRestart, self.bindfunc['OnUiManagerRestart'])
	NoticeManager.BeginListen(ENUM.NoticeType.PushUi, self.bindfunc['OnPushUi'])
end

--注销消息分发回调函数
function AdvFuncButton:MsgUnRegist()
	PublicFunc.msg_unregist(player.gc_update_player_exp_level,self.bindfunc['on_player_level_change']);
	PublicFunc.msg_unregist(UiManager.SetStackSize,self.bindfunc['on_ui_scene_change']);
	PublicFunc.msg_unregist(UiManager.PopUi,self.bindfunc['on_ui_scene_change']);
	NoticeManager.EndListen(ENUM.NoticeType.UiManagerRestart, self.bindfunc['OnUiManagerRestart'])
	NoticeManager.EndListen(ENUM.NoticeType.PushUi, self.bindfunc['OnPushUi'])

    UiBaseClass.MsgUnRegist(self);
end

-------------------------- 新手引导用 ----------------------------
function AdvFuncButton:OnUiManagerRestart(scene_id)
	if not AppConfig.get_enable_guide() then
		AdvFuncButton.CheckChangeArea()
	end
end

function AdvFuncButton:OnPushUi(scene_id, scene)
	if not AppConfig.get_enable_guide() then
		if scene_id == EUI.MMOMainUI then
			local playType = FightScene.GetPlayMethodType()
			local isMainCity = playType == MsgEnum.eactivity_time.eActivityTime_MainCity
			if isMainCity then
				AdvFuncButton.CheckChangeArea()
			end
		end
	end
	self:on_ui_scene_change(scene_id)
end

function AdvFuncButton.CheckChangeArea()
	do return true end;
	local result = false
	local ownCountryId = tonumber(g_dataCenter.player.country_id)
	local cfgAreaOpenLevel = ConfigManager.Get(EConfigIndex.t_play_vs_data, MsgEnum.eactivity_time.eActivityTime_Area).open_level
	if ownCountryId == 0 and g_dataCenter.player.level >= cfgAreaOpenLevel then
		uiManager:PushUi(EUI.ChangeAreaUi);
		result = true
	end
	return result
end
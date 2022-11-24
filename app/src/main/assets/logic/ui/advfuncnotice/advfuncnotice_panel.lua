AdvFuncPanel = Class('AdvFuncPanel',UiBaseClass);
------------外部接口--------------
--[[弹出功能预告面板]]
function AdvFuncPanel.ShowAdvanceFunction(isOpen)
	if isOpen == true then 
		AdvFuncPanel.openCf = AdvFuncButton.openCfs[g_dataCenter.player.level];
		if AdvFuncPanel.openCf ~= nil then 
			AdvFuncPanel.instance = AdvFuncPanel:new(isOpen);
		end
		NoticeManager.Notice(ENUM.NoticeType.AdvFuncAutoOpen, AdvFuncPanel.openCf.id, AdvFuncPanel.openCf.open_level)
	else 
		AdvFuncPanel.instance = AdvFuncPanel:new(isOpen);
	end 
end

function  AdvFuncPanel.ShowAdvance( showCf )
	if showCf == nil or type(showCf)~= "table" then
		return
	end
	AdvFuncPanel.showCf = showCf
	if AdvFuncPanel.instance == nil then 
		AdvFuncPanel.instance = AdvFuncPanel:new(isOpen);		 
	else 
		AdvFuncPanel.instance:UpdateUi()
	end
end

--重新开始
function AdvFuncPanel:Restart(data)
    --app.log("AdvFuncPanel:Restart");
    UiBaseClass.Restart(self, data);
	self.isOpen = data or false;
end

function AdvFuncPanel:InitData(data)
    --app.log("AdvFuncPanel:InitData");
    UiBaseClass.InitData(self, data);
	self.isOpen = data or false;
end

function AdvFuncPanel:RegistFunc()
	--app.log("AdvFuncPanel:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_btn_close_click'] = Utility.bind_callback(self,self.on_btn_close_click);
end

function AdvFuncPanel:UpdateUi()
	g_SingleLockUI:Hide()
	if AdvFuncPanel.showCf ~= nil then 
		local cf = AdvFuncPanel.showCf;
		if self.isOpen == true then 
			cf = AdvFuncPanel.openCf;
		end 
		if file.exist(tostring(cf.icon_path)) then 
			self.vs.icon:set_texture(tostring(cf.icon_path));
		end 
		--self.vs.title:set_sprite_name(tostring(cf.title_path));
        self.vs.labTitle:set_text(cf.name);
		self.vs.desc1:set_text("");
		self.vs.desc2:set_text("");
		if cf.desc1 ~= 0 then 
			self.vs.desc1:set_text(tostring(cf.desc1));	
		end
		if cf.desc2 ~= 0 then 
			self.vs.desc2:set_text(tostring(cf.desc2));
		end 
	end 
end 

function AdvFuncPanel:InitUI(asset_obj)
	--app.log("AdvFuncPanel:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('advfuncpanel');
    self.vs = {};
    self.vs.centre_other = ngui.find_widget(self.ui,"centre_other");
    self.vs.icon = ngui.find_texture(self.ui,"centre_other/sp_title/texture_human");
    self.vs.labTitle = ngui.find_label(self.ui,"centre_other/sp_title/lab");
	self.vs.desc1 = ngui.find_label(self.ui,"centre_other/sp_title/lab_describe1");
	self.vs.desc2 = ngui.find_label(self.ui,"centre_other/sp_title/lab_describe2");
	self.vs.bgMask = ngui.find_button(self.ui,"sp_mark");
	self.vs.bgMask:set_on_ngui_click(self.bindfunc['on_btn_close_click']);
	self:UpdateUi();
end

function AdvFuncPanel:on_btn_close_click()
	--app.log("AdvFuncPanel:Hide()");
	self:Hide();
	self:DestroyUi();
	if self.isOpen == true then 
		local button = MainUIPlayerMenu.instance:getButton(AdvFuncPanel.openCf.menu_button_id);
		if button == nil then 
			button = MainUIPlayerMenu.Get3dSceneBtnObj(AdvFuncPanel.openCf.menu_button_id);
		end 
		if button == nil then 
			button = MainUIPlayerMenu.Get3dSceneBtnObj(AdvFuncPanel.openCf.id);
		end
		if button ~= nil then 
			self:flyEffectToMainUiButton(button);
			NoticeManager.Notice(ENUM.NoticeType.AdvFuncEffectBegin, AdvFuncPanel.openCf.id)
			g_SingleLockUI.Show();
		else
			-- if g_dataCenter.player.level >=17 and tonumber(g_dataCenter.player.country_id) == 0 then 
			-- 	uiManager:PushUi(EUI.ChangeAreaUi);
			-- end 

			-- 必须要通知新手引导，否则会卡住
			TimerManager.Add(function()
				g_SingleLockUI.Hide();
				NoticeManager.Notice(ENUM.NoticeType.AdvFuncEffectEnd,AdvFuncPanel.openCf.id);
			end, 200, 1)
		end
	end
end

function AdvFuncPanel:flyEffectToMainUiButton(targetButton)
	local flyEffects = {};
	local tobj = {};
	tobj.effectValue = 0;
	local lx,ly,lz;
	local sx,sy,sz;
	if targetButton.get_game_object ~= nil then
		lx,ly,lz = targetButton:get_game_object():get_local_position();
		sx,sy,sz = targetButton:get_game_object():get_parent():get_local_position();
	else 
		lx,ly,lz = targetButton:get_local_position();
		sx,sy,sz = targetButton:get_parent():get_local_position();
	end 
	local tx,ty,tz = PublicFunc.GetUiScreenPos(targetButton);
	--app.log("tx,ty,tz : "..table.tostring({tx,ty,tz}));
	function tobj:get_pid()
		self.pid = self.pid or "t"..tostring(math.random(1000000,9999999));
		return self.pid;
	end 
	local ids = FightScene.CreateEffect({x=0,y=0,z=0}, ConfigManager.Get(EConfigIndex.t_effect_data,19016), nil, nil, nil, nil, 0, nil, nil, nil)
    for k,id in pairs(ids) do
        flyEffects[id] = EffectManager.GetEffect(id);
        flyEffects[id]:set_parent(MainUIPlayerMenu.instance.ui);
    end
    if flyEffects then
		for k,effect in pairs(flyEffects) do
            effect:set_active(true);
        end
	end
	local function onOver()
		if flyEffects then 
			for k,effect in pairs(flyEffects) do
				effect:set_active(false);
			end
		end 
		local btnObj;
		if targetButton.get_game_object ~= nil then 
			btnObj = targetButton:get_game_object();
		else
			btnObj = targetButton;
		end 
		local over = function()
			-- if g_dataCenter.player.level >=17 and tonumber(g_dataCenter.player.country_id) == 0 then 
			-- 	uiManager:PushUi(EUI.ChangeAreaUi);
			-- end 
			Tween.addTween(btnObj,0.2,{["local_scale"] = {1,1,1}},nil,0,nil,nil,
				function() 
					g_SingleLockUI.Hide();
					NoticeManager.Notice(ENUM.NoticeType.AdvFuncEffectEnd,AdvFuncPanel.openCf.id);
				end
			);
		end
		Tween.addTween(btnObj,0.5,{["local_scale"] = {1.2,1.2,1.2}},Transitions.EASE_OUT_BOUNCE,0,nil,nil,over);
	end 
	local function onUpdate()
		if flyEffects then 
			local toP= g_interpolate({x = 0,y = 0},{x = tx,y = ty},tobj.effectValue);
			for k,effect in pairs(flyEffects) do
				effect:set_local_position(toP.x,toP.y,0)
			end
		end 
	end
	Tween.addTween(tobj,1,{effectValue = 1},Transitions.EASE_IN_OUT,0,nil,onUpdate,onOver);
end 

function AdvFuncPanel:Init(data)
	--app.log("AdvFuncPanel:Init");
    self.pathRes = "assetbundles/prefabs/ui/advfuncnotice/ui_4801_function.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function AdvFuncPanel:DestroyUi()
	--app.log("AdvFuncPanel:DestroyUi");
    self.vs = nil;
	AdvFuncPanel.instance = nil;
	AdvFuncButton.isInFunctionTipProgress = false;
    UiBaseClass.DestroyUi(self);
end

--显示ui
function AdvFuncPanel:Show()
	--app.log("AdvFuncPanel:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function AdvFuncPanel:Hide()
	--app.log("AdvFuncPanel:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function AdvFuncPanel:MsgRegist()
	--app.log("AdvFuncPanel:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function AdvFuncPanel:MsgUnRegist()
	--app.log("AdvFuncPanel:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
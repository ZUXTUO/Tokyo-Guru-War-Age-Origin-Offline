TrialBuffList = Class('TrialBuffList',UiBaseClass)

function TrialBuffList.popPanel()
	TrialBuffList.instance = TrialBuffList:new();
end 

--重新开始
function TrialBuffList:Restart(data)
    ----app.log("TrialBuffList:Restart");
    UiBaseClass.Restart(self, data);
end

function TrialBuffList:InitData(data)
    ----app.log("TrialBuffList:InitData");
    UiBaseClass.InitData(self, data);
end

function TrialBuffList:RegistFunc()
	----app.log("TrialBuffList:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
end

function TrialBuffList:InitUI(asset_obj)
	--app.log("TrialBuffList:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialBuffList');
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"center_other/animation/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.grid = ngui.find_grid(self.ui,"center_other/animation/sco_view/panel/grid");
	self.vs.labModule = ngui.find_label(self.ui,"center_other/animation/grid/lab1");
	self:UpdateUi();
end

function TrialBuffList:UpdateUi()
	local buffIdList = g_dataCenter.trial.allInfo.buff_info;
	local len = #buffIdList;
	if len == 0 then 
		self.vs.labModule:set_active(false);
	else 
		for i = 1,len do 
			local id = buffIdList[i];
			local cf = ConfigManager.Get(EConfigIndex.t_expedition_trial_buff,id);
			local name = gs_string_property_name[cf.type];
			local lab = nil;
			if i == 1 then
				lab = self.vs.labModule;
			else 
				lab = self.vs.labModule:clone();
			end
			lab:set_text(tostring(i)..":"..name);
			lab:set_overflow(2);
			local labNum = ngui.find_label(lab:get_game_object(),"lab_num");
			labNum:set_text("提高"..tostring(cf.effect*100).."%");
			self.vs["lab"..tostring(i)] = lab;
			lab:set_parent(self.vs.grid:get_game_object());
		end
	end 
end 

function TrialBuffList:onCloseClick()
	self:Hide();
	self:DestroyUi();
end 

function TrialBuffList:Init(data)
	--app.log("TrialBuffList:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6004_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

function TrialBuffList.Destroy()
	if TrialBuffList.instance ~= nil then 
		TrialBuffList.instance:Hide();
		TrialBuffList.instance:DestroyUi();
	end
end 
--析构函数
function TrialBuffList:DestroyUi()
	--app.log("TrialBuffList:DestroyUi");
	if self.vs ~= nil then 
		self.vs = nil;
	end 
	TrialBuffList.instance = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function TrialBuffList:Show()
	--app.log("TrialBuffList:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialBuffList:Hide()
	--app.log("TrialBuffList:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TrialBuffList:MsgRegist()
	--app.log("TrialBuffList:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TrialBuffList:MsgUnRegist()
	--app.log("TrialBuffList:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
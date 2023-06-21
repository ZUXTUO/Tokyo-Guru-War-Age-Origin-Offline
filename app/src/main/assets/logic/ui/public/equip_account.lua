--装备结算界面
EquipAccount = Class("EquipAccount", UiBaseClass);
----------------------外部接口---------------------------------
--显示装备结算界面
--例子：
function EquipAccount.SetAndShow(title,data,callback)
	if EquipAccount.instance then
		EquipAccount.instance:SetInfo(title,data,callback)
	else
		EquipAccount.instance = EquipAccount:new({title=title,data=data,callback=callback});
	end
end

function EquipAccount.Destroy()
	if EquipAccount.instance then
		EquipAccount.instance:DestroyUi();
		EquipAccount.instance = nil;
	end
end

-------------------------内部接口------------------------------
function EquipAccount:InitData(data)
	UiBaseClass.InitData(self, data);
   
	self.title = data.title;
	self.data = data.data;
	self.callback = data.callback;
end

function EquipAccount:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/ui_610_equip_account.assetbundle";
	UiBaseClass.InitData(self, data);
end

function EquipAccount:Restart(data)
	UiBaseClass.Restart(self, data)
end

function EquipAccount:RegistFunc()
	UiBaseClass.RegistFunc(self);
    
	self.bindfunc["on_space_click"] = Utility.bind_callback(self, EquipAccount.on_space_click)
	self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, EquipAccount.init_item_wrap_content)
end

function EquipAccount:UnregistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function EquipAccount:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_equip_account");
	
	--do return end
	self.btnBk = ngui.find_button(self.ui,"sp_mark");
	self.btnBk:set_on_click(self.bindfunc["on_space_click"]);
	
	self.lab_title = ngui.find_label(self.ui,"top_other/lab");
	
	self.wrap_content = ngui.find_wrap_content(self.ui, 'centre_other/sp_bk/scroview/scrollview_nature/wrap_content');
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
	
	self:SetInfo(self.title,self.data,self.callback);
end

function EquipAccount:on_space_click()
	self:Hide();
	
	if(self.funcSpace ~= nil)then
		_G[self.funcSpace]();
	end
end

function EquipAccount:init_item_wrap_content(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local lab_nature = ngui.find_label(obj, "lab_nature");
	local lab_preview = ngui.find_label(obj, "lab_preview");
	lab_nature:set_text(self.data[index].labLeft);
	lab_preview:set_text(self.data[index].labRight);
end

function EquipAccount:SetInfo(title,data,callback)
	if self.ui then
		self.title = title;
		self.data = data;
		if callback then
			self.funcSpace = callback;
		end
		
		self.lab_title:set_text(self.title);
		
		local cnt = #self.data;
		self.wrap_content:set_min_index(-cnt+1);
		self.wrap_content:set_max_index(0);
		self.wrap_content:reset();
		self:Show();
	end
end

function EquipAccount:Show()
	UiBaseClass.Show(self)
end

function EquipAccount:Hide()
	UiBaseClass.Hide(self)

	self.funcSpace = nil;
end

function EquipAccount:DestroyUi()
    UiBaseClass.DestroyUi(self);

	self.funcSpace = nil;
end

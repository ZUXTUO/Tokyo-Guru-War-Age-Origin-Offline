UiGm = Class('UiGm', UiBaseClass);

function UiGm:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/test/ui_gm.assetbundle";
	UiBaseClass.Init(self, data);
end

function UiGm:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function UiGm:InitData(data)
	UiBaseClass.InitData(self, data);
	self.id_change = false;
	self.num_change = false;
end

function UiGm:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function UiGm:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_click"] = Utility.bind_callback(self, UiGm.on_btn_click)
	self.bindfunc["on_change_id"] = Utility.bind_callback(self, UiGm.on_change_id)
	self.bindfunc["on_change_num"] = Utility.bind_callback(self, UiGm.on_change_num)
    self.bindfunc["on_change_pl"] = Utility.bind_callback(self, UiGm.on_change_pl)
    self.bindfunc["on_hp_convert"] = Utility.bind_callback(self, UiGm.on_hp_convert)
end

function UiGm:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function UiGm:LoadUI()
	if UiBaseClass.LoadUI(self) then
	--todo 
	end
end

function UiGm:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_gm");
	--do return end
	
	---------------------按钮及回调事件绑定------------------------
	---------左边6个按钮--------
	--
	self.btn_add = ngui.find_button(self.ui,"btn_add");
	self.btn_add:set_on_click(self.bindfunc["on_btn_click"]);

	self.input_id = ngui.find_input(self.ui,"input_id");
	self.input_id:set_on_change(self.bindfunc["on_change_id"])
	self.lab_id = ngui.find_label(self.ui,"input_id/lab_input");

	self.input_num = ngui.find_input(self.ui,"input_num");
	self.input_num:set_on_change(self.bindfunc["on_change_num"])
	self.lab_num = ngui.find_label(self.ui,"input_num/lab_input");

    -- 玩法限制按钮
    self.btn_limit = ngui.find_button(self.ui,"btn_limit/sp");
    self.btn_limit:reset_on_click()
	self.btn_limit:set_on_click(self.bindfunc["on_change_pl"]);
    self.toggle_limit = ngui.find_toggle(self.ui,"btn_limit/sp");
    self.toggle_limit:set_value(g_dataCenter.gmCheat:getPlayLimit() == false)
	self.btn_hpConvert = ngui.find_button(self.ui,"btn");
	self.btn_hpConvert:reset_on_click()
	self.btn_hpConvert:set_on_click(self.bindfunc['on_hp_convert']);		--2016-8-23刘相敬添加体力兑换按钮
	self:UpdateUi();
end

function UiGm:UpdateUi()
	if UiBaseClass.UpdateUi(self) then
	    self.lab_num:set_text("请输入道具个数");
		self.lab_id:set_text("请输入道具id"); 
	end
end


function UiGm:on_change_id()
	self.id_change = true;
end

function UiGm:on_change_num()
	self.num_change = true;
end

function UiGm:on_hp_convert()
	HpExchange.popPanel();
	self:Hide();
	self:DestroyUi();
end 

function UiGm:on_change_pl(t)   
    -- 取消限制
    if g_dataCenter.gmCheat:getPlayLimit() == true then
        system.cg_gm_cmd("ignore 1")
    -- 恢复限制      
    else
        system.cg_gm_cmd("ignore 0")  
    end
    g_dataCenter.gmCheat:changePlayLimit()
end

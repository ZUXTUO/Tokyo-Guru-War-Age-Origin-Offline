UiShiYiQuTaoFaZhan = Class("UiShiYiQuTaoFaZhan", UiBaseClass);

function UiShiYiQuTaoFaZhan:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/shi_yi_qu_tao_fa_zhan/ui_1901_kill_war.assetbundle";
	UiBaseClass.Init(self, data);
end

function UiShiYiQuTaoFaZhan:InitData(data)
	UiBaseClass.InitData(self, data);
end

function UiShiYiQuTaoFaZhan:Restart(data)
	if UiBaseClass.Restart(self, data) then
	end
end

function UiShiYiQuTaoFaZhan:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function UiShiYiQuTaoFaZhan:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_rule"] = Utility.bind_callback(self,self.on_rule);
    self.bindfunc["on_reduce_difficulty"] = Utility.bind_callback(self,self.on_reduce_difficulty);
    self.bindfunc["on_shop"] = Utility.bind_callback(self,self.on_shop);
    self.bindfunc["on_sweep"] = Utility.bind_callback(self,self.on_sweep);
    self.bindfunc["on_reset"] = Utility.bind_callback(self,self.on_reset);
end

function UiShiYiQuTaoFaZhan:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name("ui_1901_kill_war");

    --do return end
	
    ---------------------图片--------------------------------------
    --标题
    self.spTitle = ngui.find_sprite(self.ui, "top_other/panel/sp_title2");
    self.spFog = {};
    self.spFog[1] = ngui.find_sprite(self.ui, "centre_other/scrollview/panel/sp_fog1");
    self.spFog[2] = ngui.find_sprite(self.ui, "centre_other/scrollview/panel/sp_fog2");
    self.spFog[3] = ngui.find_sprite(self.ui, "centre_other/scrollview/panel/sp_fog3");

    --每一关人物头像
    self.spHuman = {};
    for i=1,12 do
        self.spHuman[i] = ngui.find_sprite(self.ui, "centre_other/scrollview/panel/cont_icon_"..i.."/btn_icon/sp_human");
    end


    ----------------------------文字-------------------------------
    self.lab_remain_num = ngui.find_label(self.ui, "donw_other/sp_title/lab_num");

	---------------------按钮及回调事件绑定------------------------
    --查看规则
    self.btnRule = ngui.find_button(self.ui, "top_other/panel/btn");
    self.btnRule:set_on_click(self.bindfunc["on_rule"]);

	--降低难度
	self.btnReduceDifficulty = ngui.find_button(self.ui,"donw_other/btn1");
	self.btnReduceDifficulty:set_on_click(self.bindfunc["on_reduce_difficulty"]);

    --商店
    self.btnShop = ngui.find_button(self.ui,"donw_other/btn2");
    self.btnShop:set_on_click(self.bindfunc["on_shop"]);

    --扫荡
    self.btnSweep = ngui.find_button(self.ui,"donw_other/btn3");
    self.btnSweep:set_on_click(self.bindfunc["on_sweep"]);

    --重置
    self.btnReset = ngui.find_button(self.ui,"donw_other/btn4");
    self.btnReset:set_on_click(self.bindfunc["on_reset"]);

    --每一都关的头像
    self.btnIcon = {};
    --每一关的箱子
    self.btnBox = {};

    for i=1,12 do
        self.btnIcon[i] = ngui.find_button(self.ui, "centre_other/scrollview/panel/cont_icon_"..i.."/btn_icon");
        self.btnBox[i] = ngui.find_button(self.ui, "centre_other/scrollview/panel/cont_box_"..i.."/btn_box");
    end

    self.panel = ngui.find_panel(self.ui, "centre_other/panel");
    self.panel:set_active(false);

    self:UpdateUi();

end

function UiShiYiQuTaoFaZhan:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
	--todo 
	end
end


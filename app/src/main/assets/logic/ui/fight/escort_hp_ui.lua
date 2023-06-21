EscortHpUI = Class("EscortHpUI", UiBaseClass)

function EscortHpUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_boss.assetbundle";
    UiBaseClass.Init(self, data);
end

function EscortHpUI:InitData(data)
	self.target_entity = data;
    UiBaseClass.InitData(self, data);

    self.m_cur_hp = 0;
    self.updateTimer = 0;
end

function EscortHpUI:Restart( data )
	self.target_entity = data;
	UiBaseClass.Restart(self, data)	

	
end

function EscortHpUI:DestroyUi()
    
   self.m_cur_hp = 0;

   if self.updateTimer ~= 0 then 
       timer.stop(self.updateTimer);
       self.updateTimer = 0;
   end

   UiBaseClass.DestroyUi(self);
end

function EscortHpUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["set_deff_time"] = Utility.bind_callback(self, self.SetDeffTime);
	
end

function EscortHpUI:MsgRegist()
	
end

function EscortHpUI:MsgUnRegist()
 
end

function EscortHpUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_parent(Root.get_root_ui_2d_fight());
	self.ui:set_name("escort_hp_ui");

	self.animation_cont  = self.ui:get_child_by_name("centre_other/animation/animation_cont");
	if self.animation_cont then
		self.animation_cont:set_active(false);
	end	

	self.m_animation_cont_lab = ngui.find_label(self.ui, "centre_other/animation/animation_cont/lab");
	self.m_animation_cont_lab:set_text(self.target_entity.card.name .. "正在遭到攻击");

	self.sp_bk  = self.ui:get_child_by_name("centre_other/animation/sp_bk");
	self.sp_bk:set_active(false)
	--self.lab_name = ngui.find_label(self.ui, "centre_other/animation/sp_bk/lab")
	-- if self.lab_name then
	-- 	self.lab_name:set_text(self.target_entity.card.name);
	-- end
	--self.sp_hp_bar = ngui.find_progress_bar(self.ui, "centre_other/animation/sp_bk/background");
	-- if self.sp_bk then
	-- 	self.sp_bk:set_active(false);
	-- end	
	self.fx_new_fight_ui_boss_xue = self.ui:get_child_by_name("animation/fx_new_fight_ui_boss_xue");
	self.fx_new_fight_ui_boss_xue:set_active(false);

	local optionTipCom = GetMainUI():GetOptionTipUI()
	if optionTipCom then
		optionTipCom:ShowEscortInfo(self.target_entity.card.name)
	end
end

function EscortHpUI:UpdateBlood( )
	-- app.log("------------ blood:");
	local target = self.target_entity;
	if self.target_entity then
		local pro = self.target_entity:GetPropertyVal('cur_hp') / self.target_entity:GetPropertyVal('max_hp');
		if pro < 0.001 then
			pro = 0;
		end
		-- app.log("------------ blood:" .. tostring(pro));
		-- if self.sp_hp_bar then
		-- 	self.sp_hp_bar:set_value(pro);
		-- end
		local optionTipCom = GetMainUI():GetOptionTipUI()
		if optionTipCom then
			optionTipCom:UpdateEscortHpProgress(pro)
		end
	end

	self:SetAttackAnimation();
end

function EscortHpUI:SetAttackAnimation( )
	local temp_cur_hp = self.target_entity:GetPropertyVal('cur_hp');
	if self.m_cur_hp == 0 then
		self.m_cur_hp = temp_cur_hp;
	end
	if temp_cur_hp < self.m_cur_hp and self.updateTimer == 0 then
		self.updateTimer = timer.create(self.bindfunc["set_deff_time"], 5000 , 1);

		self.animation_cont:set_active(true);
		self.animation_cont:animated_play("new_fight_ui_boss");

		--self.fx_new_fight_ui_boss_xue:set_active(true);
	end

end

function EscortHpUI:SetDeffTime( )
	if self.updateTimer and self.updateTimer > 0 then
		timer.stop(self.updateTimer);
        self.updateTimer = 0;
        self.m_cur_hp = self.target_entity:GetPropertyVal('cur_hp');
        --self.fx_new_fight_ui_boss_xue:set_active(false);
	end
end
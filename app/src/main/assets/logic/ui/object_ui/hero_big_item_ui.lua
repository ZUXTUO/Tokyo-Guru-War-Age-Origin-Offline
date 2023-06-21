HeroBigItemUI = Class("HeroBigItemUI", UiBaseClass);

function HeroBigItemUI:Init(data)
	UiBaseClass.Init(self,data);
end

function HeroBigItemUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.ui = data.obj;
    self.roleData = data.role_data;
end

function HeroBigItemUI:SetData(data)
	self.roleData = data;
	self:UpdateUi();
end

function HeroBigItemUI:SetNumber(number_name)
	self.spNumberName = number_name;
	self:UpdateUi();
end

function HeroBigItemUI:SetClickCallback(func,param)
    self.funcClickCallback = func;
    self.funcClickParam = param;
end

function HeroBigItemUI:Restart(data)
    self._initData = data
    self.is_destroyed = false
    self:RegistFunc();
    self:MsgRegist();
    self:RestartData(data)
    self:InitUI();
end

function HeroBigItemUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
end

function HeroBigItemUI:InitUI()
	if not self.ui then return end;

    self.btn = ngui.find_button(self.ui,self.ui:get_name());
    self.btn:set_on_click(self.bindfunc["on_click"]);

	self.root = self.ui:get_child_by_name("cont");
	self.objAdd = self.ui:get_child_by_name("sp_add");

	self.texHead = ngui.find_texture(self.ui,"cont/Texture");
	self.spNumber = ngui.find_sprite(self.ui,"cont/sp_number");
	self.labLevel = ngui.find_label(self.ui,"cont/lab_level");
	self.labFightValue = ngui.find_label(self.ui,"cont/lab_fight");
	self.objStar = self.ui:get_child_by_name("cont/cont_star");
	self.star = {};
	for i=1,Const.HERO_MAX_STAR do
		self.star[i] = {};
		self.star[i].star = ngui.find_sprite(self.ui,"cont/cont_star/sp_star"..i);
	end

    self:UpdateUi();
end

function HeroBigItemUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.roleData then
    	self.root:set_active(true);
    	self.objAdd:set_active(false);
    	if self.spNumberName then
    		self.spNumber:set_sprite_name(self.spNumberName);
    	else
    		self.spNumber:set_sprite_name("");
    	end
    	self.labFightValue:set_text(tostring(self.roleData:GetFightValue()));
    	self.labLevel:set_text("Lv."..tostring(self.roleData.level));
    	for i=1,Const.HERO_MAX_STAR do
    		if self.star[i].star then
	    		if i <= self.roleData.rarity then
	    			self.star[i].star:set_active(true);
	    		else
	    			self.star[i].star:set_active(false);
	    		end
	    	end
    	end
    	self.texHead:set_texture(self.roleData.config.icon300);
    else
    	self.root:set_active(false);
    	self.objAdd:set_active(true);
    end
end

function HeroBigItemUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function HeroBigItemUI:on_click()
    Utility.CallFunc(self.funcClickCallback,self.roleData, self.funcClickParam);
end
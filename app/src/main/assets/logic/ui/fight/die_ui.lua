DieUi = Class("DieUi", UiBaseClass);
function DieUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/combat_action/ui_die.assetbundle";
	UiBaseClass.Init(self, data);
end

function DieUi:InitData(data)
	UiBaseClass.InitData(self, data);
	--名字
	self.name = "DieUi";
	--数据
	self.data = nil;
	--动画名字
	self.animStr  = '';
	--父类
	self.father   = nil;
	--动画状态
	self.anim_state = nil;
end

function DieUi:DestroyUi()
	if(self.ui ~= nil) then
		self.ui:set_active(false);
	end
    UiBaseClass.DestroyUi(self);
end

function DieUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

function DieUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	if(self.father ~= nil) then
		self:SetParent(self.father);
	end
	
	self.deadSpr = ngui.find_sprite(self.ui, "sp_back2/sp_dead");
	self.headSpr = ngui.find_sprite(self.ui, "sp_back2/sp_touxiang");
	self.nameLbl = ngui.find_label (self.ui, "sp_back2/lab_name");
	self.progress= ngui.find_slider(self.ui, "sp_back2");
	self.animtor = asset_game_object.find(self.ui:get_name());
	
	if(self.animStr ~= '') then
		self:PlayAnimation(self.animStr);
	end
end

function DieUi:SetParent(parent)
	self.father = parent;
	if(parent ~= nil and self.ui ~= nil)then
		local x,y,z = self.ui:get_position();
		self.ui:set_parent(self.father);
		self.ui:set_local_scale(Utility.SetUIAdaptation());
		self.ui:set_local_position(x,y,z);
	end
end

--设置所有数据
function DieUi:SetData(info)
	if(info ~= nil)then
		self.data = info;
		if(self.ui == nil)then return end;
		self:UpdateUi();
	end
end

--更新所有数据
function DieUi:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
	    if self.data ~= nil then
		    local data = self.data;
		    --数据更新
	    end
	end
end

--播放动画
function DieUi:PlayAnimation(name)
	self.animStr = name;
	if(self.ui == nil) then return; end;
	self.animtor:animator_play(name);
end

--动画回调
function DieUi.cartoonFinish(obj,eventParm)
	local result = eventParm;
	if(result == nil) then return; end;
	if(result == 'ui_die_move_down') then
		self:PlayAnimation('New State');
		app.log_warning('ui_die_move_down is over');
	elseif(result == 'ui_die_out') then
		self:PlayAnimation('New State');
		app.log_warning('ui_die_out is over');
	elseif(result == 'ui_die_wiggle') then
		app.log_warning('ui_die_wiggle is over');
	elseif(result == 'ui_die_in') then
		app.log_warning('ui_die_in is over');
	elseif(result == 'ui_die_move_scale_down') then
		app.log_warning('ui_die_move_scale_down is over');
	else
	end
end
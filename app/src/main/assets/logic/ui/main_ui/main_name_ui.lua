MainNameUi = Class("MainNameUi", UiBaseClass);
local res_type = 
{
	npc = 1,
	hero = 2,
}
function MainNameUi:Init(data)
	self:SetData(data);
	if data and data.type == res_type.npc then
    	self.pathRes = 'assetbundles/prefabs/ui/main/sp_zjm_lab_npc.assetbundle';
   	elseif data and data.type == res_type.hero then
    	self.pathRes = 'assetbundles/prefabs/ui/main/sp_zjm_lab_hero.assetbundle';
    else
    	app.log("MainNameUi:Init  类型没传对")
    end
    UiBaseClass.Init(self, data);
end
function MainNameUi:InitData(data)
	UiBaseClass.InitData(self, data);
	self.isShow = true;
	self.isScale = false;
end

function MainNameUi:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
		
	end
end

function MainNameUi:SetIsShow(isShow)
	self.isShow = isShow;
end

function MainNameUi:Hide()
	UiBaseClass.Hide(self)
end

function MainNameUi:DestroyUi()
	UiBaseClass.DestroyUi(self);
end

function MainNameUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--初始化ui
function MainNameUi:InitUI(asset_obj)
	--UiBaseClass.InitUI(self, asset)
	self.ui = asset_game_object.create(asset_obj);
    --self.ui:set_parent(Root.get_root_ui_2d_fight())
    self.ui:set_parent(Show3dText.GetCameraObj());
    self.ui:set_local_position(0,0,0); 
    self.ui:set_layer(PublicStruct.UnityLayer.ui3d,true);
    local fightCameraObj = CameraManager.GetSceneCameraObj();
    if fightCameraObj then
    	local rx,ry,rz = fightCameraObj:get_local_rotation();
    	self.ui:set_local_rotation(rx,ry,rz);
    end
	self.ui:set_name("mian_name_ui");
	self.ui:set_active(false);

	if not self.type then return end

	if self.type == res_type.hero then
		self:InitHeroUi();
    	self.ui:set_local_scale(2,2,2);
	elseif self.type == res_type.npc then
		self:InitNpcUi();
    	self.ui:set_local_scale(4,4,4);
	else
		app.log("MainNameUi:InitUI  类型没传对")
	end
	
	self:UpdateUi();
end

function MainNameUi:InitHeroUi()
	if not self.ui or self.type ~= res_type.hero then return end
	self.lab_name = ngui.find_label(self.ui, "lab_name");
	self.lab_guild = ngui.find_label(self.ui, "lab_guild");
	self.lab_vip = ngui.find_label(self.ui, "lab_vip");
	self.sp_vip = ngui.find_sprite(self.ui, "sp_vip");
end

function MainNameUi:InitNpcUi()
	if not self.ui or self.type ~= res_type.npc then return end
	self.lab_name = ngui.find_label(self.ui, "lab");
end

function MainNameUi:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end
	if not self.type then return end

	if self.type == res_type.hero then
		self:UpdateHeroUi();
	elseif self.type == res_type.npc then
		self:UpdateNpcUi();
	else
		app.log("MainNameUi:UpdateUi  类型没传对")
	end
end

function MainNameUi:UpdateHeroUi()
	if not self.ui then return end
	if self.type ~= res_type.hero then return end
	if self.name then
		self.lab_name:set_text(self.name);
	else
		self.lab_name:set_active(false);
	end
	if self.guild then
		self.lab_guild:set_text("<"..self.guild..">");
	else
		self.lab_guild:set_active(false);
	end
	if self.vip_level then
		self.lab_vip:set_text(tostring(self.vip_level));
		if self.vip_level > 0 then
			-- self.sp_vip:set_active(true);
			-- self.lab_vip:set_active(true);
			self.sp_vip:set_active(false);
			self.lab_vip:set_active(false);
		else
			self.sp_vip:set_active(false);
			self.lab_vip:set_active(false);
		end
	else
		--self.lab_vip:set_text("0");
		self.sp_vip:set_active(false);
		self.lab_vip:set_active(false);
	end
end

function MainNameUi:UpdateNpcUi()
	if not self.ui then return end
	if self.type ~= res_type.npc then return end
	if not self.name then return end

	self.lab_name:set_text("["..self.name.."]");
end

function MainNameUi:SetData(data)
	self.type = data.type;
	if self.type == res_type.hero then
		self.name = data.name;
		self.guild = data.guild;
		self.vip_level = data.vip_level;
	elseif self.type == res_type.npc then
		self.name = data.name;
	else
		app.log("MainNameUi:UpdateUi  类型没传对")
	end
end

function MainNameUi:SetPosition(x,y,z)
	if not self.ui then return end
	if not self.isScale then
		self.ui:set_active(self.isShow);
	end
	self.ui:set_position(x,y,z)
end

function MainNameUi:SetScale(x,y,z)
	if not self.ui then return end
	if x > 1 then
		x = 1;
	end
	if y > 1 then
		y = 1;
	end

	if x < 0.3 or y < 0.3 then
		self.ui:set_active(false);
	else
		self.ui:set_active(self.isShow);
	end
	if self.isScale then
		self.ui:set_local_scale(x,y,z)
	else
		self.ui:set_local_scale(1,1,1)
	end
end

function MainNameUi:OpenScale(isScale)
	self.isScale = isScale;
end

return MainNameUi;
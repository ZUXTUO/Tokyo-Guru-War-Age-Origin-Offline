UiEquipForgeEquipList = Class('UiEquipForgeEquipList', UiBaseClass);

--初始化
function UiEquipForgeEquipList:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/equip_forge/ui_3103_forge.assetbundle';
    UiBaseClass.Init(self, data);
end

--重新开始
function UiEquipForgeEquipList:Restart(data)
    if data and type(data) == "table" then
        self.material_equip_result = data.material_equip_result;
        self.lab_title = data.lab_title;
        self.parent_class = data.parent_class;
    end
    self.texture_equip = {};
    self.scd_human = {};
    self.lab_equip_name = {};
    self.lab_level = {};
    self.sp_letter = {};
    self.sp_star = {};
    self.sp_shine_equip_list = {};
    self.obj_human = {};
    self.sp_equip_frame = {};
    self.texture_equip = {};
    self.btn = {};
    if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
	end
end

--初始化数据
function UiEquipForgeEquipList:InitData(data)
    UiBaseClass.InitData(self, data);
end

--析构函数
function UiEquipForgeEquipList:DestroyUi()
    UiBaseClass.DestroyUi(self);
    for k,v in pairs(self.texture_equip) do
        v:Destroy();
        self.texture_equip[k] = nil;
    end
    for k,v in pairs(self.scd_human) do
        v:DestroyUi();
        self.scd_human[k] = nil;
    end
    self.texture_equip = {};
    self.scd_human = {};
    self.lab_equip_name = {};
    self.lab_level = {};
    self.sp_letter = {};
    self.sp_star = {};
    self.sp_shine_equip_list = {};
    self.obj_human = {};
    self.sp_equip_frame = {};
    self.texture_equip = {};
    self.btn = {};
end

--注册回调函数
function UiEquipForgeEquipList:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['on_chose_equip'] = Utility.bind_callback(self,self.on_chose_equip);
    self.bindfunc['on_btn_close_list'] = Utility.bind_callback(self,self.on_btn_close_list);
    self.bindfunc['init_item_wrap_content_list'] = Utility.bind_callback(self,self.init_item_wrap_content_list);
end

--注册消息分发回调函数
function UiEquipForgeEquipList:MsgRegist()
	UiBaseClass.RegistFunc(self);
end

--注销消息分发回调函数
function UiEquipForgeEquipList:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
end

--寻找ngui对象
function UiEquipForgeEquipList:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ui_equip_forge_equip_list');

	-- do return end
    -- self.panel_equip_list = ngui.find_panel(self.ui, "ui_3102_forge");
    -- self.panel_equip_list:set_active(false);

    self.btn_close_list = ngui.find_button(self.ui, "centre_otehr/animation/content/btn_fork");
    self.btn_close_list:set_on_click(self.bindfunc["on_btn_close_list"]);

    self.btn_filter = ngui.find_button(self.ui, "centre_otehr/animation/content/btn_screen");
    self.btn_filter:set_active(false);

    self.scroll_view_list = ngui.find_scroll_view(self.ui, "centre_otehr/animation/content/panel_list");
    self.wrap_content_list = ngui.find_wrap_content(self.ui, "centre_otehr/animation/content/panel_list/wrap_content");
    self.wrap_content_list:set_on_initialize_item(self.bindfunc['init_item_wrap_content_list']);

    self.lab_title_list = ngui.find_label(self.ui, "centre_otehr/animation/content/txt_title");

    self:UpdateUi();
end

function UiEquipForgeEquipList:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end

    self.lab_title_list:set_text(self.lab_title);

    self.wrap_content_list:set_min_index(-#self.material_equip_result+1);
    self.wrap_content_list:set_max_index(0);
    self.wrap_content_list:reset();
    self.scroll_view_list:reset_position();
end

--------------------------------------------装备列表
function UiEquipForgeEquipList.Sortfunction(a,b)
    if a.star > b.star then
        return false;
    elseif a.star < b.star then
        return true;
    end
    if a.level > b.level then
        return false;
    elseif a.level < b.level then
        return true;
    end
    if tonumber(a.roleid) ~= 0 and tonumber(b.roleid) == 0 then
        return false;
    elseif tonumber(a.roleid) == 0 and tonumber(b.roleid) ~= 0 then
        return true;
    end
    if a.number > b.number then
        return false;
    end
    return false;
end

function UiEquipForgeEquipList:init_item_wrap_content_list(obj,b,real_id)
    local index = math.abs(real_id)+1;
    if not self.material_equip_result then return end
    local equip_info = self.material_equip_result[index];
    if not equip_info then return end
    if not self.lab_equip_name[b] then
        self.lab_equip_name[b] = ngui.find_label(obj, "lab_equip_name");
    end
    if not self.lab_level[b] then
        self.lab_level[b] = ngui.find_label(obj, "lab_level");
    end
    if not self.sp_letter[b] then
        self.sp_letter[b] = ngui.find_sprite(obj, "sp_letter");
    end
    if not self.sp_star[b] then
        self.sp_star[b] = {};
        for i=1,5 do
            self.sp_star[b][i] = ngui.find_sprite(obj, "star/star_di"..i.."/sp_star");
        end
    end
    if not self.sp_shine_equip_list[b] then
        self.sp_shine_equip_list[b] = ngui.find_sprite(obj, "sp_shine");
    end
    self.sp_shine_equip_list[b]:set_active(false);
    if not self.obj_human[b] then
        self.obj_human[b] = ngui.find_button(obj, "sp_human_di"):get_game_object();
    end
    if not self.sp_equip_frame[b] then
        self.sp_equip_frame[b] = ngui.find_sprite(obj, "sp_touxiangkuang/sp_frame");
    end
    PublicFunc.SetIconFrameSprite(self.sp_equip_frame[b],equip_info.rarity)
    if not self.texture_equip[b] then
        self.texture_equip[b] = ngui.find_texture(obj, "sp_touxiangkuang/sp_equip");
    end
    self.texture_equip[b]:set_texture(equip_info.small_icon);
    PublicFunc.SetEquipRaritySprite(self.sp_letter[b],equip_info.rarity);
    self.lab_equip_name[b]:set_text(tostring(equip_info.name));
    self.lab_level[b]:set_text("Lv."..tostring(equip_info.level));
    for i=1,5 do
        self.sp_star[b][i]:set_active(i <= equip_info.star);
    end
    if equip_info.roleid ~= 0 and equip_info.roleid ~= "0" then
        local human_info = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, equip_info.roleid)
        if not self.scd_human[b] then
            self.scd_human[b] = SmallCardUi:new({ obj = self.obj_human[b], info = human_info });
        else
            self.scd_human[b]:SetData(human_info);
        end
        self.obj_human[b]:set_active(true);
    else
        self.obj_human[b]:set_active(false);
    end
    if not self.btn[b] then
        self.btn[b] = ngui.find_button(obj, "sp_di");
    end
    self.btn[b]:reset_on_click();
    self.btn[b]:set_event_value("", index);
    self.btn[b]:set_on_click(self.bindfunc["on_chose_equip"]);
end

function UiEquipForgeEquipList:ShowNavigationBar()
    return false
end

function UiEquipForgeEquipList:on_chose_equip(t)
    local index = t.float_value;
    self.parent_class.chose_materials_uuid[self.parent_class.chose_materials_index] = self.material_equip_result[index].index;
    self.parent_class.chose_materials_cardinfo[self.parent_class.chose_materials_index] = self.material_equip_result[index];
    --self.panel_equip_list:set_active(false);
    self.parent_class:UpdateHaveRecipe();
    uiManager:PopUi();
end

function UiEquipForgeEquipList:on_btn_close_list()
    uiManager:PopUi();
end

UiEquipForge = Class('UiEquipForge', UiBaseClass);

--初始化
function UiEquipForge:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/equip_forge/ui_3101_forge.assetbundle';
    UiBaseClass.Init(self, data);
end

--重新开始
function UiEquipForge:Restart(data)
    self.return_equip = nil;
    self.return_gold = nil;
    self.return_stone = nil;
    if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
	end
end

--初始化数据
function UiEquipForge:InitData(data)
    UiBaseClass.InitData(self, data);
	--self.cardInfo = nil;
    self.sim = {};
    self.sim_equip_left = {};
    self.recipe_list = {};
    self.material_equip_result = nil;
    self.chose_recipe_id = nil;        --选择的图样的id
    self.chose_recipe_index = 1;       --默认选择第一个图样
    self.chose_materials_uuid = {};    --选择的材料
    -- self.texture_equip = {};
    -- self.scd_human = {};
    self.item_use_count = {};          --已经使用了的item(强化石之类)的个数
    self.is_enough_item = {};
    self.chose_materials_cardinfo = {};

    self.frame_left = {};
    self.lab_name = {};
    self.obj_equip = {};
    self.btn = {};
end

--析构函数
function UiEquipForge:DestroyUi()
    UiBaseClass.DestroyUi(self);
    for k,v in pairs(self.sim) do
        v:DestroyUi();
        self.sim[k] = nil;
    end
    for k,v in pairs(self.sim_equip_left) do
        v:DestroyUi();
        self.sim_equip_left[k] = nil;
    end
    self.recipe_list = {};
    self.material_equip_result = nil;
    self.chose_recipe_id = nil;        --选择的图样的id
    self.chose_recipe_index = 1;       --默认选择第一个图样
    self.chose_materials_uuid = {};    --选择的材料
    -- for k,v in pairs(self.texture_equip) do
    --     v:Destroy();
    --     self.texture_equip[k] = nil;
    -- end
    -- for k,v in pairs(self.scd_human) do
    --     v:DestroyUi();
    --     self.scd_human[k] = nil;
    -- end
    if self.sim_final then
        self.sim_final:DestroyUi();
        self.sim_final = nil;
    end
    if self.sim_recipe then
        self.sim_recipe:DestroyUi();
        self.sim_recipe = nil;
    end
    if self.sim_center then
        self.sim_center:DestroyUi();
        self.sim_center = nil;
    end
    self.item_use_count = {};
    self.is_enough_item = {};
    self.chose_materials_cardinfo = {};
    self.return_equip = nil;
    self.return_gold = nil;
    self.return_stone = nil;

    self.frame_left = {};
    self.lab_name = {};
    self.obj_equip = {};
    self.btn = {};
end

--注册回调函数
function UiEquipForge:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['on_rule'] = Utility.bind_callback(self,self.on_rule);
    self.bindfunc['on_sure'] = Utility.bind_callback(self,self.on_sure);
    self.bindfunc['on_sure_gray'] = Utility.bind_callback(self,self.on_sure_gray);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self,self.init_item_wrap_content);
    self.bindfunc['on_chose_recipe'] = Utility.bind_callback(self,self.on_chose_recipe);
    self.bindfunc['on_chose_material'] = Utility.bind_callback(self,self.on_chose_material);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self,self.on_btn_close);

    self.bindfunc['gc_casting_ret'] = Utility.bind_callback(self,self.gc_casting_ret);
	self.bindfunc['gc_casting_result_select'] = Utility.bind_callback(self,self.gc_casting_result_select);
end

--注册消息分发回调函数
function UiEquipForge:MsgRegist()
	UiBaseClass.RegistFunc(self);
    PublicFunc.msg_regist(msg_cards.gc_casting_ret,self.bindfunc['gc_casting_ret']);--锻造
    PublicFunc.msg_regist(msg_cards.gc_casting_result_select,self.bindfunc['gc_casting_result_select']);--重铸
end

--注销消息分发回调函数
function UiEquipForge:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_casting_ret,self.bindfunc['gc_casting_ret']);
    PublicFunc.msg_unregist(msg_cards.gc_casting_result_select,self.bindfunc['gc_casting_result_select']);
end

--寻找ngui对象
function UiEquipForge:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_equip_forge');

	--do return end
    -----------------
    ---------------------------------------上方
    self.btn_rule = ngui.find_button(self.ui, "center_other/animation/content/btn_anniu")
    self.btn_rule:set_on_click(self.bindfunc["on_rule"]);

    self.btn_close = ngui.find_button(self.ui, "center_other/animation/content/btn_fork")
    self.btn_close:set_on_click(self.bindfunc["on_btn_close"]);

    ---------------------------------------左
    self.scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/content/cont_left/panel_list");
    self.wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/content/cont_left/panel_list/wrap_cont");
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);

    self.lab_no_recipe_left = ngui.find_label(self.ui, "center_other/animation/content/cont_left/sp_di_left/lab");

    ---------------------------------------中
    self.obj_equip_preview = ngui.find_sprite(self.ui, "center_other/animation/content/cont_center/cont1/new_small_card_item"):get_game_object();
    self.lab_equip_preview = ngui.find_label(self.ui, "center_other/animation/content/cont_center/cont1/lab_word1");
    self.lab_equip_preview_describe = ngui.find_label(self.ui, "center_other/animation/content/cont_center/cont1/lab_word2");
    self.lab_no_recipe_center = ngui.find_label(self.ui, "center_other/animation/content/cont_center/sp_di/lab");
    self.cont_center = self.ui:get_child_by_name("center_other/animation/content/cont_center/cont1");

    ---------------------------------------右
    self.obj_equip_final = ngui.find_sprite(self.ui, "center_other/animation/content/cont_right/cont1/new_small_card_item1"):get_game_object();
    --图样
    self.obj_equip_recipe = ngui.find_sprite(self.ui, "center_other/animation/content/cont_right/cont2/new_small_card_item1"):get_game_object();
    self.obj_material = {};
    self.btn_material = {};
    self.lab_material_no_enough = {};
    self.lab_add = {};
    self.lab_count = {};
    for i=1,5 do
        self.obj_material[i] = ngui.find_sprite(self.ui, "center_other/animation/content/cont_right/cont"..(2+i).."/new_small_card_item1"):get_game_object();
        self.btn_material[i] = ngui.find_button(self.ui, "center_other/animation/content/cont_right/cont"..(2+i).."/new_small_card_item1/sp_back");
        self.lab_material_no_enough[i] = ngui.find_label(self.ui, "center_other/animation/content/cont_right/cont"..(2+i).."/lab_red");
        self.lab_add[i] = ngui.find_label(self.ui, "center_other/animation/content/cont_right/cont"..(2+i).."/lab_dian_ji");
        self.lab_count[i] = ngui.find_label(self.ui, "center_other/animation/content/cont_right/content/cont"..(2+i).."/new_small_card_item1/sp_back/lab");
        self.btn_material[i]:set_event_value("", i);
        self.btn_material[i]:set_on_click(self.bindfunc["on_chose_material"]);
    end

    self.lab_gold = ngui.find_label(self.ui, "center_other/animation/content/cont_right/content/lab");

    self.btn_sure = ngui.find_button(self.ui, "center_other/animation/content/cont_right/content/btn_anniu");
    self.btn_sure:set_on_click(self.bindfunc["on_sure"]);

    self.btn_sure_gray = ngui.find_button(self.ui, "center_other/animation/content/cont_right/sp_di_right/cont0/btn_anniu");
    self.btn_sure_gray:set_on_click(self.bindfunc["on_sure_gray"]);

    self.cont_right = self.ui:get_child_by_name("center_other/animation/content/cont_right/content");
    self.sp_line_5 = ngui.find_sprite(self.ui, "center_other/animation/content/cont_right/content/cont_line/sp_line5");
    self.sp_di_5 = ngui.find_sprite(self.ui, "center_other/animation/content/cont_right/sp_di_right/cont0/sp_di5");

    self:UpdateUi();
end

function UiEquipForge:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end
    --self.lab_no_recipe_center:set_text("未选择图样");
    self.recipe_list = g_dataCenter.package:GetAllRecipe();
    --app.log("xx"..table.tostring(self.recipe_list));
    if #self.recipe_list == 0 then
        self:UpdateNoRecipe();
    else
        self:UpdateHaveRecipe();
    end

    self.wrap_content:set_min_index(-#self.recipe_list+1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
end

--一个图样都没有时
function UiEquipForge:UpdateNoRecipe()
	self.scroll_view:set_active(false);
	self.lab_no_recipe_left:set_active(true);
	self.cont_center:set_active(false);
	self.lab_no_recipe_center:set_active(true);
	self.cont_right:set_active(false);
    self.btn_sure:set_active(false);
    self.btn_sure_gray:set_active(true);
end

--有图样时
function UiEquipForge:UpdateHaveRecipe()
    self.item_use_count = {};
    self.scroll_view:set_active(true);
    self.lab_no_recipe_left:set_active(false);
    self.btn_sure:set_active(true);
    self.btn_sure_gray:set_active(false);
    if not self.chose_recipe_index then
        self.cont_center:set_active(false);
        self.lab_no_recipe_center:set_active(true);
        self.cont_right:set_active(false);
        return
    end
    self.chose_recipe_id = self.recipe_list[self.chose_recipe_index].number;

	
	self.cont_center:set_active(true);
	self.lab_no_recipe_center:set_active(false);
	self.cont_right:set_active(true);



    local cfg_recipe = ConfigManager.Get(EConfigIndex.t_item_casting,self.chose_recipe_id);
    if not cfg_recipe then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_item_casting");
        return
    end
    self.lab_gold:set_text(tostring(cfg_recipe.gold));
    local preview_id = cfg_recipe.preview_id;
    local preview_info;
    if PropsEnum.IsEquip(preview_id) then
        preview_info = CardEquipment:new({number = preview_id});
        self.lab_equip_preview_describe:set_text(preview_info.describe);
    elseif PropsEnum.IsItem(preview_id) then
        preview_info = CardProp:new({number = preview_id});
        self.lab_equip_preview_describe:set_text(preview_info.description);
    else
        app.log("UiEquipForge:UpdateHaveRecipe   图样预览物品id不对id=="..tostring(preview_id));
    end
    if self.sim_center then
        self.sim_center:DestroyUi();
    end
    self.sim_center = UiSmallItem:new({obj=self.obj_equip_preview,cardInfo = preview_info});
    self.sim_center:SetLabNum(false)
    self.lab_equip_preview:set_text(preview_info.name);

    if self.sim_final then
        self.sim_final:DestroyUi();
    end
    self.sim_final = UiSmallItem:new({obj=self.obj_equip_final,cardInfo = preview_info});
    self.sim_final:SetLabNum(false)
    local cfg_imte_recipe = ConfigManager.Get(EConfigIndex.t_item,self.chose_recipe_id);
    if not cfg_imte_recipe then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_get_item");
        return
    end
    local recipe_info = CardProp:new({number = self.chose_recipe_id});
    if self.sim_recipe then
        self.sim_recipe:DestroyUi();
    end
    self.sim_recipe = UiSmallItem:new({obj=self.obj_equip_recipe,cardInfo = recipe_info});
    self.sim_recipe:SetLabNum(false)
    local cfg = ConfigManager.Get(EConfigIndex.t_casting_material,self.chose_recipe_id);
    if not cfg then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_get_casting_material");
        return
    end
    local material_count = 0;
    for k,v in pairs(cfg) do
        material_count = material_count + 1;
    end
    if material_count == 4 then
        self.obj_material[3]:set_active(false);
        self.sp_line_5:set_active(false);
        self.sp_di_5:set_active(false);
        self.lab_material_no_enough[3]:set_active(false);
        self.lab_add[3]:set_active(false);
        self:SetMaterialDisplay(1, 1);
        self:SetMaterialDisplay(2, 2);
        self:SetMaterialDisplay(4, 3);
        self:SetMaterialDisplay(5, 4);
    elseif material_count == 5 then
        self.obj_material[3]:set_active(true);
        self.sp_line_5:set_active(true);
        self.sp_di_5:set_active(true);
        self.lab_material_no_enough[3]:set_active(true);
        self.lab_add[3]:set_active(true);
        for i=1,5 do
            self:SetMaterialDisplay(i, i);
        end
    else
        app.log("打造系统配置出错，图样所需材料少于4"..tostring(self.chose_recipe_id));
    end
end

--obj_index:ui上从左到右，第几个装备框       material_index：第几个材料
function UiEquipForge:SetMaterialDisplay(obj_index, material_index)
    local cfg_all = ConfigManager.Get(EConfigIndex.t_casting_material,self.chose_recipe_id);
    if not cfg_all then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_get_casting_material");
        return
    end
    local cfg = cfg_all[material_index];
    if not cfg then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_get_casting_material".."的第index=="..tostring(material_index));
        return
    end
    if self.sim[obj_index] then
        self.sim[obj_index]:DestroyUi();
    end
    if self.chose_materials_uuid[material_index] then
        local uuid = self.chose_materials_uuid[material_index];
        local equip_info = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment,uuid);
        if equip_info then
            self.sim[obj_index] = UiSmallItem:new({obj=self.obj_material[obj_index], cardInfo = equip_info ,delay = 400});
            self.lab_count[obj_index]:set_active(false);
            self.lab_material_no_enough[obj_index]:set_active(false);
            self.lab_add[obj_index]:set_active(false);
            return
        end
    end
    local material_info = CardProp:new({number = cfg.item_id});
    self.sim[obj_index] = UiSmallItem:new({obj=self.obj_material[obj_index], cardInfo = material_info ,delay = 400});
    self.lab_count[obj_index]:set_active(true);
    local rarity = cfg.rarity;
    --不是装备
    if rarity == 0 then
        local material_id = cfg.item_id;
        if not self.item_use_count[material_id] then
            self.item_use_count[material_id] = 0;
        end
        local count = g_dataCenter.package:find_count(ENUM.EPackageType.Item, material_id);
        count = count - self.item_use_count[material_id];
        if count < 0 then
            count = 0;
        end

        local need_count = cfg.count;
        --不足
        if count < need_count then
            self.sim[obj_index]:SetMark(true);
            self.lab_material_no_enough[obj_index]:set_active(true);
            self.lab_count[obj_index]:set_text("[FF0000]"..tostring(count).."[-]/"..tostring(need_count));
            self.is_enough_item[obj_index] = false;
            self.chose_materials_uuid[material_index] = nil;
            self.chose_materials_cardinfo[material_index] = nil;
        --足够
        else
            self.chose_materials_uuid[material_index] = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,material_id).index
            self.chose_materials_cardinfo[material_index] = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,material_id);
            --self.item_use_count[material_id] = self.item_use_count[material_id] + need_count;
            self.lab_material_no_enough[obj_index]:set_active(false);
            self.lab_count[obj_index]:set_text("[00FF2B]"..tostring(need_count).."[-]/"..tostring(need_count));
            self.is_enough_item[obj_index] = true;
        end
        self.item_use_count[material_id] = self.item_use_count[material_id] + need_count;
        self.lab_add[obj_index]:set_active(false);
    --装备
    else
        local need_count = cfg.count;
        local pos = cfg.position;
        local equip_list_result = g_dataCenter.package:GetEquipByRarityAndPos(rarity, pos, self.chose_materials_uuid);
        local count = #equip_list_result;

        if count < need_count then
            self.sim[obj_index]:SetMark(true);
            self.lab_material_no_enough[obj_index]:set_active(true);
            self.lab_add[obj_index]:set_active(false);
            self.lab_count[obj_index]:set_text("[FF0000]"..tostring(count).."[-]/"..tostring(need_count));
        else
            self.lab_material_no_enough[obj_index]:set_active(false);
            self.lab_add[obj_index]:set_active(true);
            self.lab_count[obj_index]:set_text("[00FF2B]"..tostring(count).."[-]/"..tostring(need_count));
        end
    end
end

--
function UiEquipForge:init_item_wrap_content(obj,b,real_id)
	local index = math.abs(real_id)+1;
    if not self.recipe_list then return end
    local recipe_info = self.recipe_list[index];
    if not recipe_info then return end
    if not self.frame_left[b] then
    	self.frame_left[b] = ngui.find_sprite(obj, "sp_frame");
    end
    if not self.lab_name[b] then
        self.lab_name[b] = ngui.find_label(obj, "lab_word");
    end
    if not self.obj_equip[b] then
        self.obj_equip[b] = obj:get_child_by_name("new_small_card_item");
    end
    if self.sim_equip_left[index] == nil then
        self.sim_equip_left[index] = UiSmallItem:new({obj=self.obj_equip[b], cardInfo = recipe_info});
    else
        self.sim_equip_left[index]:SetData(recipe_info);
    end
    self.sim_equip_left[index]:SetLabNum(false)
    if self.chose_recipe_index and self.chose_recipe_index == index then
        self.frame_left[b]:set_active(true);
        self.chose_recipe_b = b;
    else
        self.frame_left[b]:set_active(false);
    end
    self.lab_name[b]:set_text(recipe_info.name);
    if not self.btn[b] then
        self.btn[b] = ngui.find_button(obj, obj:get_name());
    end
    self.btn[b]:reset_on_click();
    self.btn[b]:set_event_value(tostring(b),index);
    self.btn[b]:set_on_click(self.bindfunc["on_chose_recipe"]);
end

function UiEquipForge:ShowNavigationBar()
    return false
end

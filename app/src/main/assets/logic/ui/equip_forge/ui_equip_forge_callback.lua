--规则说明
function UiEquipForge:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.EquipForge)
end

--关闭
function UiEquipForge:on_btn_close()
	uiManager:PopUi();
end

function UiEquipForge:on_chose_recipe(t)
	local index = t.float_value;
    local b = tonumber(t.string_value);
	if self.chose_recipe_index and index == self.chose_recipe_index then
		return;
	end
	if self.chose_recipe_b then
		self.frame_left[self.chose_recipe_b]:set_active(false);
	end
	self.chose_recipe_index = index;
    self.chose_recipe_b = b;
	self.frame_left[self.chose_recipe_b]:set_active(true);
	self.chose_materials_uuid = {};
    self.chose_materials_cardinfo = {};
    self.item_use_count = {};
    self.is_enough_item = {};
	self:UpdateHaveRecipe();
end

function UiEquipForge:on_chose_material(t)
	local index = t.float_value;
	local cfg_all = ConfigManager.Get(EConfigIndex.t_casting_material,self.chose_recipe_id);
    if not cfg_all then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_casting_material");
        return
    end
	local material_count = 0;
    for k,v in pairs(cfg_all) do
        material_count = material_count + 1;
    end
    if material_count == 4 then
    	if index >= 4 then
    		index = index - 1;
    	end
    end
    local cfg = cfg_all[index];
    if not cfg then return end
    --装备
    if cfg.rarity ~= 0 then
    	local need_count = cfg.count;
        local pos = cfg.position;
        --app.log("index=="..index.."  pos=="..pos.."   rarity=="..cfg.rarity);
        local equip_list_result = g_dataCenter.package:GetEquipByRarityAndPos(cfg.rarity, pos, self.chose_materials_uuid);
        local count = #equip_list_result;
        --app.log("筛选的装备列表"..table.tostring(equip_list_result,1));

        --不足
        if count < need_count then
            HintUI.SetAndShow(EHintUiType.zero, "材料不足，无法打造");
        else
            self.material_equip_result = PublicFunc.GetEquipment(pos,UiEquipForge.Sortfunction,nil,nil,nil,nil,nil,cfg.rarity,self.chose_materials_uuid);
      --       self.panel_equip_list:set_active(true);
      --       local cardinfo = CardProp:new({number = cfg.item_id});
      --       self.lab_title_list:set_text("装备列表("..cardinfo.name..")");
      --       self.wrap_content_list:set_min_index(-#self.material_equip_result+1);
		    -- self.wrap_content_list:set_max_index(0);
		    -- self.wrap_content_list:reset();
      --       self.scroll_view_list:reset_position();
            local item_name = ConfigManager.Get(EConfigIndex.t_item,cfg.item_id).name;
            uiManager:PushUi(EUI.UiEquipForgeEquipList,{material_equip_result=self.material_equip_result, lab_title = "装备列表("..item_name..")", parent_class = self});
        end
    --强化石之类
    else
        --不足
        if not self.is_enough_item[index] then
            HintUI.SetAndShow(EHintUiType.zero, "材料不足，无法打造");
        --足够
        else
            
        end
    end
    self.chose_materials_index = index;
end

-- function UiEquipForge:on_chose_equip(t)
-- 	local index = t.float_value;
-- 	self.chose_materials_uuid[self.chose_materials_index] = self.material_equip_result[index].index;
--     self.chose_materials_cardinfo[self.chose_materials_index] = self.material_equip_result[index];
-- 	self.panel_equip_list:set_active(false);
-- 	self:UpdateHaveRecipe();
-- end

-- function UiEquipForge:on_btn_close_list()
--     self.panel_equip_list:set_active(false);
-- end

function UiEquipForge:on_sure()
	local cfg_all = ConfigManager.Get(EConfigIndex.t_casting_material,self.chose_recipe_id);
    if not cfg_all then
        app.log("id=="..tostring(self.chose_recipe_id).."的图样没有配置t_get_casting_material");
        return
    end
	local material_count = 0;
    for k,v in pairs(cfg_all) do
        material_count = material_count + 1;
    end
    if material_count ~= 4 and material_count ~= 5 then
        app.log("打造系统配置出错，图样所需材料少于4    id=="..tostring(self.chose_recipe_id).."  count="..material_count);
        return
    end
    local enough = true;
    for i=1,material_count do
        if not self.chose_materials_uuid[i] then
            enough = false;
        end
    end
    if not enough then
    	HintUI.SetAndShow(EHintUiType.zero, "材料不足，无法打造");
    else
        local chose_recipe = self.recipe_list[self.chose_recipe_index]
        if not chose_recipe then return end
        local casting_drawing =
        {
            dataid = chose_recipe.index,
            id = chose_recipe.number,
            count = 1,
        };
        local materials = {};
        for i=1,material_count do
            local cfg = cfg_all[i];
            materials[i] = 
            {
                dataid = self.chose_materials_uuid[i],
                id = self.chose_materials_cardinfo[i].number,
                count = cfg.count,
            }
        end
        --app.log("casting_drawing=="..table.tostring(casting_drawing));
        --app.log("materials=="..table.tostring(materials));
        msg_cards.cg_casting(casting_drawing, materials)
    end
end

function UiEquipForge:on_sure_gray()
	HintUI.SetAndShow(EHintUiType.zero, "没有图样");
end

--锻造结果
function UiEquipForge:gc_casting_ret(result, items)
	if type(items) ~= "table" then return end
    self.chose_recipe_index = 1;
    self.chose_materials_uuid = {};
    self.chose_materials_cardinfo = {};
    self.item_use_count = {};
    self.is_enough_item = {};
    self:UpdateUi();
    for k,v in pairs(items) do
        local id = v.id;
        if PropsEnum.IsEquip(id) then
            self.return_equip = v;
        elseif PropsEnum.IsGold(id) then
            self.return_gold = v;
        elseif PropsEnum.IsItem(id) then
            self.return_stone = v;
        end
    end
    if not self.return_equip then
        CommonAward.Start({[1]=self.return_stone}, 7)
        return
    end

    CommonAward.Start({[1]=self.return_equip}, 3)
    if self.return_gold ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnGold, self)
    elseif self.return_gold == nil and self.return_stone ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnStone, self)
    end
    self.return_equip = nil;
end

function UiEquipForge:ShowReturnGold()
    CommonAward.Start({[1]=self.return_gold}, 6)
    if self.return_stone ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnStone, self)
    end
    self.return_gold = nil;
end

function UiEquipForge:ShowReturnStone()
    CommonAward.Start({[1]=self.return_stone}, 6)
    self.return_stone = nil;
end

--重铸结果
function UiEquipForge:gc_casting_result_select(id, level)
    --app.log("id=="..id.."   level=="..level);

    local data = 
    {
        old_equip_info = self.chose_materials_cardinfo[1],
        new_equip_info = CardEquipment:new({number = id,level = level});
        --new_equip_info = self.chose_materials_cardinfo[2];
    }
    uiManager:PushUi(EUI.UiEquipForgeChoseEquip, data);
    self.chose_recipe_index = 1;
    self.chose_materials_uuid = {};
    self.chose_materials_cardinfo = {};
    self.item_use_count = {};
    self.is_enough_item = {};
    self:UpdateUi();
end




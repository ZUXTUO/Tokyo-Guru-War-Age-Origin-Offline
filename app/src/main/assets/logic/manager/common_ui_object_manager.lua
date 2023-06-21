CommonUiObjectManager = 
{
	is_ready = false,
	is_enable = true,
}

local this = CommonUiObjectManager;

local pathRes = {}
pathRes.smallcard = "assetbundles/prefabs/ui/public/big_card_item_80.assetbundle";
pathRes.smallitem = "assetbundles/prefabs/ui/public/new_small_card_item.assetbundle";
pathRes.maskitem = "assetbundles/prefabs/ui/public/mask_item.assetbundle";

local CommonUiConfig = 
{
	--small card
	{
		--插入节点的父节点名
		mask_parent = "sp_back";
		--基础节点之外可隐藏的
		mask_list = {
			"contail_qh",		--1. 强化星级
			"right_top",		--2. 红点/推荐
			"pro_xuetiao",		--3. 血条
			"fx_checkin_month",	--4. 流光特效
		};
		max_ref = 100;
	},
	--small item
	{
		--基础节点之外可隐藏的
		mask_list = {
			"prop",				--1. 道具
			"equip",			--2. 装备
			"sp_check",			--3. 勾选框
			"fx_checkin_month",	--4. 流光特效
			"sp_tishi",			--5. 小红点
			"sp_tuijian",		--6. 推荐
		};
		max_ref = 120;
	},
}

ECommonUi_Type = 
{
	SmallCard = 1,
	SmallItem = 2,
}

function CommonUiObjectManager.IsEnable()
	return this.is_enable
end

function CommonUiObjectManager.InitData()
	if this.is_ready then return end

	this.common_ui_data = {}
	for name, i in pairs(ECommonUi_Type) do
		this.common_ui_data[i] = {
			info_list={}, free_list={}, used_list={}, call_count=0}
	end

	this.CreateBaseObject()

	this.is_ready = true
end

function CommonUiObjectManager.Destroy()
	if not this.is_ready then return end

	this.is_ready = false

	this.common_ui_data = nil
end

function CommonUiObjectManager.CreateObject( type )
	if not this.is_ready then return end

	local common_ui_data = this.common_ui_data[ type ]
	local object, index = next(common_ui_data.free_list)
	if object == nil then
		object = common_ui_data.base_list.object:clone()
		local add_node = object
		local mask_parent = CommonUiConfig[ type ].mask_parent
		if mask_parent then
			add_node = object:get_child_by_name(mask_parent)
		end
		table.insert( common_ui_data.info_list, 
			{object=object, add_node=add_node, used=true, mask=0} )
		common_ui_data.used_list[object] = #common_ui_data.info_list
	else
		local data = common_ui_data.info_list[index]
		common_ui_data.free_list[data.object] = nil
		common_ui_data.used_list[data.object] = index
		data.used = true
	end
	-- app.log("=== CreateCommonUiObject["..type.."].length === "..#common_ui_data.info_list)

	common_ui_data.call_count = common_ui_data.call_count + 1
	if common_ui_data.call_count % 1000 == 0 then
		this.AutoRelease( common_ui_data, type )
	end

	return object
end

function CommonUiObjectManager.RemoveObject( type, object )
	if not this.is_ready then return end

	local common_ui_data = this.common_ui_data[ type ]
	local index = common_ui_data.used_list[object]
	if index then
		common_ui_data.free_list[object] = index
		common_ui_data.used_list[object] = nil
		common_ui_data.info_list[index].used = false

		this.ResetBaseComponent(common_ui_data.info_list[index], type)
	end
	-- app.log("=== RemoveCommonUiObject["..type.."].used === "..table.get_num(common_ui_data.used_list))

	object:set_parent(Root.root_ui_2d_pool)
	-- object:set_active(false)
end

function CommonUiObjectManager.AutoRelease( common_ui_data, type )
	do return end --暂时屏蔽
	common_ui_data = common_ui_data or this.common_ui_data[ type ]
	local release_count = #common_ui_data.info_list - CommonUiConfig[ type ].max_ref
	if release_count > 0 then
		this.PrintTestLog()

		local free_index_list = {}
		for object, index in pairs(common_ui_data.free_list) do
			table.insert(free_index_list, index)
		end 
		if release_count > #free_index_list then
			app.log("CommonUiObject["..type.."] 对象池使用超过上限 "..CommonUiConfig[ type ].max_ref)
		end
		table.sort(free_index_list, function(a, b) return a > b end)
		for k, index in pairs_key(free_index_list) do
			local data = common_ui_data.info_list[index]
			common_ui_data.free_list[data.object] = nil
			common_ui_data.info_list[index] = nil
			release_count = release_count - 1
			if release_count == 0 then
				break
			end
		end
	end
end

function CommonUiObjectManager.ClearObject()
	if not this.is_ready then return end

	for k, v in pairs(this.common_ui_data) do
		v.info_list = {}
		v.free_list = {}
		v.used_list = {}
		v.call_count = 0
	end
end

function CommonUiObjectManager.CreateBaseObject()
	ResourceLoader.LoadAsset(pathRes.smallcard, this.on_loaded, "small_ui_base")
	ResourceLoader.LoadAsset(pathRes.smallitem, this.on_loaded, "small_ui_base")
end

function CommonUiObjectManager.GetCommonUiType(filepath)
	if filepath == pathRes.smallcard then
		return ECommonUi_Type.SmallCard
	elseif filepath == pathRes.smallitem then
		return ECommonUi_Type.SmallItem
	elseif filepath == pathRes.maskitem then
		return ECommonUi_Type.MaskItem
	end
end

function CommonUiObjectManager.on_loaded(pid, filepath, asset_obj, error_info)
	local base_object = asset_game_object.create(asset_obj)
	base_object:set_parent(ResourceManager.res_object_pool_node)

	local type = this.GetCommonUiType(filepath)
	if type then
		this.common_ui_data[ type ].base_list = 
			this.CreateBaseComponent(type, base_object, CommonUiConfig[type].mask_list)
	end
end

function CommonUiObjectManager.CreateBaseComponent( type, base_object )
	local mask_list = CommonUiConfig[type].mask_list
	local mask_parent = CommonUiConfig[type].mask_parent
	local base_list = {}
	base_list.object = base_object

	if mask_list then
		for i, v in pairs(mask_list) do
			local pathNameList = {}
			if mask_parent then
				table.insert(pathNameList, mask_parent) 
			end
			table.insert(pathNameList, v)
			base_list[i]  = {}
			local component = base_object:get_child_by_name(table.concat(pathNameList, "/"))
			base_list[i].component = component
			local px, py, pz = component:get_local_position()
			base_list[i].position = {px, py, pz}
			local sx, sy, sz = component:get_local_scale()
			base_list[i].scale = {sx, sy, sz}

			base_list[i].component:set_parent(Root.root_ui_2d_pool)
		end
	end

	return base_list
end

function CommonUiObjectManager.AddMaskComponent(ui, type, obj_name)
	local obj_component = nil
	local common_ui_data = this.common_ui_data[type]
	local index = common_ui_data.used_list[ui]
	local info_data = common_ui_data.info_list[index]
	local mask_list = CommonUiConfig[ type ].mask_list
	local mask_parent = CommonUiConfig[ type ].mask_parent
	local mask_index = nil
	for i, v in pairs(mask_list) do
		if v == obj_name then
			mask_index = i
			break;
		end
	end
	if mask_index and PublicFunc.GetBitValue(info_data.mask, mask_index) == 0 then
		info_data.mask = info_data.mask + bit.bit_lshift(1, mask_index-1)
		local data = common_ui_data.base_list[mask_index]
		obj_component = data.component:clone()
		obj_component:set_name(obj_name)
		obj_component:set_parent(info_data.add_node)
		obj_component:set_local_position(data.position[1], data.position[2], data.position[3])
		obj_component:set_local_scale(data.scale[1], data.scale[2], data.scale[3])
	else
		obj_component = ui:get_child_by_name(ui:get_name().."/"..obj_name)
	end

	return obj_component
end

function CommonUiObjectManager.ResetBaseComponent(info_data, type)
	local ui_name = info_data.object:get_name()
	for i, v in pairs(CommonUiConfig[ type ].mask_list) do
		if PublicFunc.GetBitValue(info_data.mask, i) > 0 then
			local obj_component = info_data.object:get_child_by_name(ui_name.."/"..v)
			if obj_component then
				obj_component:set_active(false)
				obj_component:set_parent(nil)
			end
		end
	end
	info_data.mask = 0
end

function CommonUiObjectManager.PrintTestLog()
	if not this.is_ready then return end
	for i, common_ui_data in pairs(this.common_ui_data) do
		app.log("============== CommonUiObject["..i.."].PrintTestLog ============== ")
		app.log("info_list: "..#common_ui_data.info_list)
		app.log("free_list: "..table.tostring(common_ui_data.free_list))
		app.log("used_list: "..table.tostring(common_ui_data.used_list))
	end
end

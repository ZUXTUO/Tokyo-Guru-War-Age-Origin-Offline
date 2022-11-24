gd_string = {}
g_str = gd_string

check = {
	IsShowCheckLog = false; --[[是否打印配置表日志]]
};

local tostringex = function(v, len)
	if len == nil then len = 10 end
	local pre = string.rep("\t\t", len)
	local ret = ""
	if type(v) == "table" then
		if len <= 0 then return "\t\[ ... \]" end
		local t = ""
		for k, v1 in pairs(v) do
			t = t .. "\n\t" .. pre .. tostring(k) .. ":"
			t = t .. tostringex(v1, len - 1)
		end
		if t == "" then
			ret = ret .. pre .. "\[ \]\t\(" .. tostring(v) .. "\)"
		else
			if len > 0 then
				ret = ret .. "\t\(" .. tostring(v) .. "\)\n"
			end
			ret = ret .. pre .. "\[" .. t .. "\n" .. pre .. "\]"
		end
	else
		ret = ret .. pre .. tostring(v) .. "\t\(" .. type(v) .. "\)"
	end
	return ret;
end

-- -- 初始化配置表的方法 >> !!!!!! 已经迁移到ConfigManger了
-- function config_init_fun(t, name)
-- 	-- 配置表内每一项的值的元表
	
-- 	local lname = name or "g_xxx";
-- 	-- 配置表索引检索的元表
-- 	config_data_fun = {__index =
-- 	function(t, k)
-- 		if k==nil then
-- 			if check.IsShowCheckLog then
-- 				app.log("查询配置表错误:"..lname..",传入索引值为 nil");
-- 			end
-- 		elseif type(k)=="table" then
-- 			if check.IsShowCheckLog then
-- 				app.log("查询配置表错误:"..lname..",传入索引值为 table");
-- 			end
-- 		elseif type(k)=="function" then
-- 			if check.IsShowCheckLog then
-- 				app.log("查询配置表错误:"..lname..",传入索引值为 function");
-- 			end
-- 		elseif type(k)=="userdata" then
-- 			if check.IsShowCheckLog then
-- 				app.log("查询配置表错误:"..lname..",传入索引值为 userdata");
-- 			end
-- 		else
-- 			if check.IsShowCheckLog then
-- 				app.log("查询配置表错误:"..lname..",无此索引值:"..tostringex(k, 1));
-- 			end
-- 		end
-- 	end }
	
-- 	local config_value_fun = {
-- 		__index = function(t, k)
-- 			if k==nil then
-- 				if check.IsShowCheckLog then
-- 					app.log("查询配置表错误:"..lname..",传入的属性名称是 nil");
-- 				end
-- 			else
-- 				if check.IsShowCheckLog then
-- 					app.log("查询配置表错误:"..lname..",表中无此属性:"..k);
-- 				end
-- 			end
-- 		end }
	
-- 	setmetatable(t, config_data_fun);
	
-- 	for k,v in pairs(t) do
-- 		if type(v)=="table" then
-- 			setmetatable(v, config_value_fun);
-- 		end
-- 	end
-- end

-- --[[初始化角色配置表]]
-- function check.init_role_config()
-- 	for k,v in pairs(gd_role) do
-- 		v.level_config = _G['gd_'..v.config];
-- 		assert(v.level_config);
-- 		if v.default_rarity == 0 then
-- 			v.default_rarity = v.id;
-- 		end
-- 	end
-- end

--[[初始化装备配置表]]
-- function check.init_equip_config()
-- 	for k,v in pairs(gd_equipment) do
-- 		v.level_config = _G['gd_'..v.config]
-- 		--assert(v.level_config)
-- 		if v.default_rarity == 0 then
-- 			v.default_rarity = v.id;
-- 		end
-- 	end
-- end


-- 关卡--[[初始化道具配置表]]
function check.init_item_config() --TODO: 在role.lua加一列 ??
	local _item = ConfigManager._GetConfigTable(EConfigIndex.t_item)
	_item.roleIdToItemId = {}
	
	for k,v in pairs(_item) do
		if v.hero_number and v.hero_number ~= 0 then
			_item.roleIdToItemId[v.hero_number] = v.id;
		end
	end
end


-- --[[初始化关卡配置表]]
-- function check.init_hurdle_config()
-- 	table.splice(gd_hurdle,gd_play_method_hurdle);
-- end



--[[初始化怪物配置表]]

-- TODO: 不确定是否是 card_human中
-- function check.init_monster_property_config()
-- 	for k,v in pairs(gd_monster_property) do
-- 		v.level_config = _G['gd_'..v.config];
-- 		if v.level_config == nil then
-- 			app.log("...."..tostring(v.config))
-- 		end
-- 		assert(v.level_config);
-- 	end
-- end


--[[初始化属性显示列表]]
function check.init_property_show_config()
	local property_show = ConfigManager._GetConfigTable(EConfigIndex.t_property_show)

	property_show.showType = {};
	for k,v in pairs(property_show) do
		if type(k) == "number" then
			local mt = getmetatable(v)
			for kk, vv in pairs(mt) do
				print(kk..tostring(vv))
			end

			property_show.showType[v.show_type] = property_show.showType[v.show_type] or {};
			property_show.showType[v.show_type][k] = v;
			if property_show.showType[v.show_type].minIndex == nil or property_show.showType[v.show_type].minIndex > k then
				property_show.showType[v.show_type].minIndex = k;
			end
		end
	end
end

function bit_merge(...)
    local value = 0
    for i=1, arg['n'] do
        if bit.bit_and(value, arg[i]) == 0 then
            value = value + arg[i]
        end
    end
    return value
end

--TODO: kevin 用钩子或者 填写完整路径
-- function check.init_audio_path()
-- 	local audio = ConfigManager._GetConfigTable(EConfigIndex.t_audio)
-- 	for k,v in pairs(audio) do
-- 		v.path = "assetbundles/prefabs/sound/prefab/"..v.path;
-- 	end
-- end

-- --寻找图结构中，2点的简单路径
-- local n_l = 0;
-- local function FindGraphPath(graph, begin_id, end_id, k, path, visited, ret)
-- 	path[k] = begin_id;
-- 	visited[begin_id] = 1;
-- 	if begin_id == end_id then
-- 		--print("找到一条路径了")
-- 		n_l = n_l + 1;
-- 		ret[n_l] = {};
-- 		for i=1,#path do
-- 			ret[n_l][i] = path[i];
-- 			--app.log("路径点  n=="..n_l.."  i=="..i.."   路径=="..path[i])
-- 		end
-- 	else
-- 		local length = #graph[begin_id].link
-- 		if not length then return end
-- 		for i=1,length do
-- 			--当前遍历的节点
-- 			local cur_node = graph[begin_id].link[i].world_id;
-- 			if not visited[cur_node] then
-- 				FindGraphPath(graph, cur_node, end_id, k+1, path, visited, ret);
-- 			end
-- 		end
-- 	end
-- 	path[k] = nil;
-- 	visited[begin_id] = nil;
-- end

-- local function FindSameCountryPath(all_path)
-- 	local result_path = {};
-- 	for i=1,6 do
-- 		result_path[i] = {};
-- 		--遍历所有路径：k1为开始地图id
-- 	    for k1,path in pairs(all_path) do
-- 	    	result_path[i][k1] = {};
-- 	        --遍历每个节点：k2为结束地图id
-- 	        for k2,world in pairs(path) do
-- 	        	local temp_path = {};
-- 	        	--同一张地图
-- 	        	if k1 == k2 then
-- 	        		temp_path = all_path[k1][k2];
-- 	        		result_path[i][k1][k2] = temp_path;
-- 	        	else
-- 	        		local index = 0;
-- 	        		--遍历每一条路径：1,2,3
-- 	                for k5,v5 in pairs(world) do
-- 	                	local can_go = false;
-- 	                	--遍历每条路径的每个地图节点
-- 	                    for k6,v6 in pairs(v5) do --国家id
-- 	                    	local next_world_id = v5[k6+1];
--                 			if not next_world_id then
--                 				--已经是最后一个路径节点了
--                 				if v6 ~= k2 then
--                 					app.log("k1=="..k1.."  k2=="..k2.."的第"..k5.."条路径最后一个点id=="..v6.."不等于结束点(k2)");
--                 				end
--                 				break;
--                 			end
-- 	                    	local translation_point = _G['gd_'..tostring(v6)..'_translation_point'];
-- 	                    	if not translation_point then
-- 	                    		app.log("id== "..v6.."的地图没有传送点配置");
-- 	                    	end
-- 	                    	--遍历地图中所有的传送点
--                     		local can_go_next = false;
-- 	                    	for tp_id,tp_info in pairs(translation_point) do
-- 	                    		if can_go_next then break end;
-- 	                    		local tp_detail = ConfigManager.Get(EConfigIndex.t_translation_point,tp_id);
-- 	                    		if not tp_detail then
-- 	                    			app.log("id== "..tp_id.."的传送点没有配置");
-- 	                    		end
-- 	                    		local end_world_info = tp_detail.end_world_info;
-- 	                    		--遍历每个传送点能达到的地方
-- 	                    		for end_world_info_key,end_world_info_value in pairs(end_world_info) do
-- 	                    			if end_world_info_value.world_id == next_world_id then
-- 	                    				if not end_world_info_value.country_id or end_world_info_value.country_id == i then
-- 	                    					--这个传送点可以传送到下一个路径点
-- 	                    					can_go_next = true;
-- 	                    					break;
-- 	                    				end
-- 	                    			end
-- 	                    		end
-- 	                    	end
-- 	                    	--这个地图中没有传送点可以到达下一个路径点，不用再遍历后面的路径点了
-- 	                    	if not can_go_next then
-- 	                    		can_go = false;
-- 	                    		--app.log_warning("i=="..i.."  k1=="..k1.."  k2=="..k2.."的第"..k5.."条路径对于国家id=="..i.."的行不通");
-- 	                    		break;
-- 	                    	else
-- 	                    		can_go = true;
-- 	                    	end
-- 	                    end
-- 	                    if can_go then
-- 	                    	index = index + 1;
-- 							temp_path[index] = v5;
-- 						else
-- 							--app.log("k1=="..k1.."  k2=="..k2.."的第"..k5.."条路径对于国家id=="..i.."的行不通");
-- 	                    end
-- 	                end
-- 	                result_path[i][k1][k2] = temp_path;
-- 	        	end
-- 	        end
-- 	    end
-- 	end
-- 	return result_path
-- end

-- function check.init_map_path()
-- 	world_map_path = {};
-- 	if not ConfigManager.Get(EConfigIndex.t_world_info then return end,-- 	if not gd_world_info then return end)-- 	if not gd_world_info then return end
-- 	for k,v in pairs(gd_world_info) do
-- 		world_map_path[k] = {};
-- 		for m,n in pairs(gd_world_info) do
-- 			world_map_path[k][m] = {};
-- 			local path = {};
-- 			local visited = {};
-- 			FindGraphPath(ConfigManager.Get(EConfigIndex.t_world_info, k, m, 1, path, visited, world_map_path,k)[m]);
-- 			n_l = 0;
-- 		end
-- 	end
-- 	world_map_path = FindSameCountryPath(world_map_path);
-- end

g_preprocessed_eqip_recommend = {}
function check.init_equip_recommend()
    for type=EHeroPreferenceType.EHeroPreferenceTypeMin,EHeroPreferenceType.EHeroPreferenceTypeMax do
        -- local c = ConfigManager.Get(EConfigIndex.t_equip_recommend,type)
        local c = ConfigManager.Get(EConfigIndex.t_equip_recommend, type)
        if c then
            g_preprocessed_eqip_recommend[type] = {}
            for k,v in ipairs(c) do
                g_preprocessed_eqip_recommend[type][v.equip_id] = k
			end
		end
	end
end


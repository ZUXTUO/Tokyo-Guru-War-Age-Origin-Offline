--file: config_manager.lua
--auth: kevin
--date: 2016/6/7
--desc: config load helper...

ConfigManager = {
	loadedConfigFiles = {}, --{{table = xxx, key = xxx_key }, ...}}

	--手动全表激活
	manualActivedTable = {},

	--显示获取配置数据的失败信息
	showGetDataErrMsg = false,
}

-- alias 'CM' for ConfigManager
CM = ConfigManager
g_Config = g_Config or {}

local _show_debug = false;
local config_mem_size = 0;

local empty_meta_table = {}

local function __parse_data(t, key)
	local r = t[key]
	if type(r) == "string" then
		local str = "return " .. r
		r = loadstring(str);
		if nil ~= r then
			r = r()
		end
		t[key] = r
	end 
	return r
end

function ConfigManager.SpliceIndexName(name)
	if EConfigIndex['t_'..tostring(name)] == nil then
		if not AppConfig.get_is_numerical_version() then
			app.log("can't found index name="..tostring(name).." "..debug.traceback())
		end
	end
	return EConfigIndex['t_'..tostring(name)]
end


function ConfigManager.Get(configName, dataID)
--	util.begin_sample("config_get")

	--if dataID == nil then dataID = 0 end
	--app.log("xxx ConfigManager.Get configname="..configName.." dataID"..dataID)
	local cfg = ConfigManager.__get_config(configName)
	if nil == cfg or nil == cfg.table then
		-- util.end_sample();
		return nil
	end
    local r = __parse_data(cfg.table, dataID)
    if nil == r then
    	-- util.end_sample();
    	--app.log("configName:" .. configName .. " id: " .. dataID .. debug.traceback())
    	return nil
	end

    local mt = getmetatable(cfg.table)
    if cfg.key and mt then
    	if not cfg.type_o then
    		if not getmetatable(r) then
    			--app.log("set meta table for " .. configName)
		    	setmetatable(r, mt._query_)
		    end
	    else
	    	local has_mt = false
	    	for k, v in pairs(r) do 
	    		if getmetatable(v) then
	    			--只要有一条有了，肯定就都有了
	    			has_mt = true
	    			break;
	    		end
	    	end

	    	if not has_mt then
    			--app.log("set meta table for " .. configName)
	    		for k, v in pairs(r) do
		    		setmetatable(v, mt._query_)
	    		end
	    	end
	    end
    end

    -- TODO: Nation 特殊处理
    if configName == EConfigIndex.t_monster_property then
        SupplementResourceConfig(r)
    end


 --   util.end_sample();

	return r 
end

function ConfigManager.GetDataCount(configName)
	local cfg = ConfigManager.__get_config(configName)
	if nil ~= cfg then
		return #cfg.table
	end
end

function ConfigManager._GetConfigTable(configName)
	-- app.log("active config table :" .. configName)

	ConfigManager.__ActiveConfigTable(configName);

	local cfg = ConfigManager.__get_config(configName)


	-- local function getn(cfg)
	-- 	local cnt = 0
	-- 	for k, v in pairs(cfg) do
	-- 		cnt = cnt + 1
	-- 	end

	-- 	if cnt > 100 then
	-- 		app.log("acitve big table:" .. configName)
	-- 	end
	-- end

	-- getn(cfg.table)

	if nil ~= cfg then
		return cfg.table;
	end	
	return nil
end

function ConfigManager.__ActiveConfigTable(configName)
	if ConfigManager.manualActivedTable[configName] ~= nil then
		return true
	end

	local cfg = ConfigManager.__get_config(configName)

	if nil == cfg then
		app.log(string.format("__ActiveConfigTable failed: %s not found.", tostring(configName)));
		return false;
	end

	-- if nil == cfg.query_func then
	-- 	app.log(string.format("__ActiveConfigTable failed. %s query func is nil.", tostring(configName)));
	-- 	return false;
	-- end

    local mt = nil

    if cfg.key then
	    mt = getmetatable(cfg.table)
	end
	--app.log(configName.."....."..table.tostring(cfg.table)..debug.traceback())
	for k, v in pairs(cfg.table) do

		local r = __parse_data(cfg.table, k)
	    if cfg.key then
	    	if not cfg.type_o then
		    	setmetatable(r, mt._query_)
		    else
		    	--如果是‘o’形表， 则为每个数据设置元表
		    	for kk, vv in pairs(r) do
			    	setmetatable(vv, mt._query_)
		    	end
		    end
	    end
	end

	ConfigManager.manualActivedTable[configName] = true

	return true;
end

--添加一条配置，注意是带Key的。 ｛id =123, name = 'hahaha'｝ 而不是{123,'hahaha'}
function ConfigManager._AppendRow(configName, key, data, _show_replace_warning_msg)
	local cfg = ConfigManager.__get_config(configName)
	if nil == key or nil == data or nil == cfg or nil == cfg.table then
		app.log(string.format("_AppendRow failed. configName: %s, key:%s, data: %s", tostring(configName), tostring(key), tostring(data)) )
		return false
	end

	if nil == _show_replace_warning_msg or _show_replace_warning_msg then
		if cfg.table[key] ~= nil then
			app.log_warning(string.format("_AppendRow warning. key exists. configName: %s, key:%s, data: %s", tostring(configName), tostring(key), tostring(data)) )
		end
	end

	cfg.table[key] = data

	--为了和上面的Get接口兼容， 这里给出一个空的metatable
	if cfg.key then
    	if not cfg.type_o then
	    	setmetatable(data, empty_meta_table)
	    else
	    	for kk, vv in pairs(data) do
		    	setmetatable(vv, empty_meta_table)
	    	end
	    end
    end

	return true
end

function ConfigManager.LoadIndex()
	script.run("logic/data/__config_index__.lua");
	if nil == EConfigIndex or nil == g_ConfigDetails then
		app.log("config index file error.");
		return false;
	end
	return true;
end

function ConfigManager.LoadConfig(configName)

--	app.log("configName========"..configName)
	local loadedConfig = ConfigManager.loadedConfigFiles[configName]
	if nil ~= loadedConfig then
		return false
	end

	local cfgFileInf = g_ConfigDetails[configName]
	if nil == cfgFileInf then
		app.log("config file not found:" .. tostring(configName).. debug.traceback());
		return false 
	end

	local configFilePath = "logic/data/" .. cfgFileInf.file_name
	-- app.log_warning("load config: " .. configFilePath)

	local cur_size
	if _show_debug then
		collectgarbage("collect")
		cur_size = collectgarbage("count")
	end
	--app.log("......."..tostring(configFilePath))
	script.run(configFilePath)

	if _show_debug then
		collectgarbage("collect")
		cur_size = collectgarbage("count") - cur_size
		config_mem_size = config_mem_size + cur_size
		app.log_warning("cur cfg size:".. config_mem_size)
	end

	if cfgFileInf.table_name then
		local loadedTable = g_Config["t_"..cfgFileInf.table_name]

		if nil == loadedTable then
			app.log("config file load error:" .. configName .. ":".. table.tostring(cfgFileInf.table_name)..debug.traceback())
			return false
		end

		local is_type_o = false -- 类型为 ‘o' 或者 'q' 的表
		local loadedTableKey = g_Config["t_"..cfgFileInf.table_name .. "_key_"]
		if nil == loadedTableKey then
			loadedTableKey = g_Config["t_"..cfgFileInf.table_name .. "_sub_key_"]
			if nil ~= loadedTableKey then
				is_type_o = true;
			end
		end

		if config_init_fun ~= nil then
			config_init_fun(loadedTable, configName);
		end

		local mt = getmetatable(loadedTable)

		-- 给元表附加一个表用于每行数据的公共原表	
		local mt_4_row = {
			__index = function(t, k)
				local index = loadedTableKey[k]
				if nil == index then
					if ConfigManager.showGetDataErrMsg then
						app.log_warning(string.format("查询配置配置表数据出错:%s, 数据key:%s", tostring(configName), tostring(k)))
					end
					return nil
				end
				return rawget(t,index)
			end,
		}

		--自身的__index 用于检测非法行key
		local mt_index_func_4_self = function (t,k)
			if ConfigManager.showGetDataErrMsg then
				app.log_warning(string.format("配置表找不到数据行:%s, id:%s", tostring(configName), tostring(k)))
			end
			return nil
		end


		if nil ~= mt then
			app.log("配置表已经存在metatable:%s"..configName)
		end

		setmetatable(loadedTable, {
			__index = mt_index_func_4_self, --自己用 
			_query_= mt_4_row, --每行数据公用
			-- is_raw_data = cfgFileInf.raw_data --检测表的每行是否是字符串
			})

		ConfigManager.loadedConfigFiles[configName] = {type_o = is_type_o, table = loadedTable, key = loadedTableKey}
	else -- 没有table_name的即为lua直接拷贝的
		ConfigManager.loadedConfigFiles[configName] = true 
	end

	return true;
end

function ConfigManager.__get_config(configName)
	local cfg = ConfigManager.loadedConfigFiles[configName]
	if nil == cfg then
		ConfigManager.LoadConfig(configName);
		cfg = ConfigManager.loadedConfigFiles[configName]
	end

	return cfg;
end

function ConfigManager.ReloadConfig(configName)
	g_Config[configName] = nil;
	local configPath = EConfigIndex[configName];
	ConfigManager.loadedConfigFiles[configPath] = nil;
	ConfigManager.manualActivedTable[configPath] = nil;
	Root.script_module["logic/data/"..configPath] = nil;
end

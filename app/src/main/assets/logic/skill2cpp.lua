local cmd = 'if not exist skill_config mkdir skill_config'
os.execute(cmd)
require("lfs")
path=lfs.currentdir()
local ts = string.reverse(path)
local _, pos = string.find(ts, "\\")
local m = string.len(ts) - pos
path = string.sub(path, 0, m)
package.path = package.path..";"..path.."/ghoul_code/client/logic/?.lua"
local skill_value_field = {"id", "name", "needtarget", "manualdir", "combo", "cdtype", "cancel", "canceltime", "canrotate", "lasthalo", "ignoredir", "lesshp", "condition"}
local skill_table_field = {"targets_index", "pri_buff", "attention_buff"}
local skill_effect_field = {"buffid", "bufflv", "targettype", "key"}
local buff_value_field = {"id", "name"}
local buff_level_value_field = {"name", "duration", "durationweak", "overlap", "maxoverlap", "property", "skillid", "attention_skill", "icon"}
local buff_trigger_value_field = {"activetype", "triggertype", "delay", "interval", "immediately", "group", "condition"}
function bit_merge(...)
    local value = 0
	local handle = {}
    for i=1, arg['n'] do
        if not handle[arg[i]] then
            value = value + arg[i]
			handle[arg[i]] = 1
        end
    end
    return value
end

function table.splice(t_out, t_add)
    for k, v in pairs(t_add) do
        if t_out[k] then
        else
            t_out[k] = v
        end
    end
end

PublicFunc = {}
PublicFunc.EnumCreator = function(begin_num)
    if begin_num ~= nil then
        PublicFunc._enumIndex = begin_num
    else
        PublicFunc._enumIndex = PublicFunc._enumIndex + 1
    end
    return PublicFunc._enumIndex
end


script = {}
script.run = function(file_path)
	if string.find(file_path, "logic/") then
		file_path = string.sub(file_path, 7);
	end
	local _file_path = string.sub(file_path, 0, -5);
	require(_file_path)
end
script.run("logic/object/skill/buff_def.lua");
script.run("logic/object/skill/buff_config/buff_data.lua");
script.run("logic/object/skill/skill_config/skill_data.lua");
local max_skill_id = 0
for skillid, skilldata in pairs(g_SkillData) do
    skilldata.id = skillid
	if skilldata.id > max_skill_id then
		max_skill_id = skilldata.id
	end
end
local max_buff_id = 0
for buffid, buffdata in pairs(g_BuffData) do
    buffdata.id = buffid
	local max_level = 0
	for k, v in pairs(buffdata.level) do
		v.id = k
		if k > max_level then
			max_level = k
		end
	end
	buffdata.max_level = max_level
	if buffdata.id > max_buff_id then
		max_buff_id =buffdata.id
	end
end

local file = io.open("./skill_config/skill_data.xml", "w");
file:write("<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n");
file:write("<skillconfig>\n");
for skill_index=1, max_skill_id do
	if g_SkillData[skill_index] then
		file:write("	<skill");
		--先写值类型数据
		for k, v in pairs(skill_value_field) do
			if g_SkillData[skill_index][v] then
				file:write(" "..v.."=".."\""..tostring(g_SkillData[skill_index][v]).."\"");
			end
		end
		--再写表类型数据
		for k, v in pairs(skill_table_field) do
			if g_SkillData[skill_index][v] then
				file:write(" "..v.."=\"")
				local first = true
				for _k, _v in pairs(g_SkillData[skill_index][v]) do
					if not first then
						file:write(",")
					end
					first = false
					file:write(tostring(_v))
				end
				file:write("\"")
			end
		end
		file:write(">\n");
		--写effect字段
		if g_SkillData[skill_index].effect then
			for effect_index=1, #g_SkillData[skill_index].effect do
				local effect_data = g_SkillData[skill_index].effect[effect_index]
				file:write("		<effect");
				for k, v in pairs(skill_effect_field) do
					if effect_data[v] then
						file:write(" "..v.."=".."\""..tostring(effect_data[v]).."\"");
					end
				end
				file:write("/>\n");
			end

		end
		file:write("	</skill>\n");
	end
end
file:write("</skillconfig>");
file:close();


file = io.open("./skill_config/buff.xml", "w");
file:write("<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n");
file:write("<buffconfig>\n");
for buff_index=1, max_buff_id do
	local buff_data = g_BuffData[buff_index]
	if buff_data then
		file:write("	<buff");
		--先写值类型数据
		for k, v in pairs(buff_value_field) do
			if buff_data[v] then
				file:write(" "..v.."=".."\""..tostring(buff_data[v]).."\"");
			end
		end
		file:write(">\n");
		--写level字段
		if buff_data.level and buff_data.max_level > 0 then
			for i=1, buff_data.max_level do
				local level_data = buff_data.level[i]
				if level_data then
					file:write("		<level lv=\""..tostring(level_data.id).."\"");
					for k, v in pairs(buff_level_value_field) do
						if level_data[v] then
							file:write(" "..v.."=".."\""..tostring(level_data[v]).."\"");
						end
					end
					file:write(">\n");
					--写trigger字段
					if level_data.trigger then
						for j=1, #level_data.trigger do
							local trigger_data = level_data.trigger[j]
							if trigger_data then
								file:write("			<trigger ti=\""..tostring(j).."\"");
								for k, v in pairs(buff_trigger_value_field) do
									if trigger_data[v] then
										file:write(" "..v.."=".."\""..tostring(trigger_data[v]).."\"");
									end
								end
								file:write(">\n");
								if trigger_data.action then
									for m=1, #trigger_data.action do
										local action_data = trigger_data.action[m]
										if action_data then
											file:write("				<action");
											if action_data.atype then
												file:write(" atype=\""..tostring(action_data.atype).."\"");
											end
											for k, v in pairs(action_data) do
												if k ~= "atype" then
													file:write(" "..k.."=".."\""..tostring(v).."\"");
												end
											end
											file:write("/>\n");
										end
									end
								end
								--写action字段
								file:write("			</trigger>\n");
							end
						end
					end
					file:write("		</level>\n");
				end
			end
		end
		file:write("	</buff>\n");
	end
end
file:write("</buffconfig>");
file:close();
--[[local a = {}
for k, v in pairs(g_BuffData) do
	for i=1, #v.level do
		if v.level[i] then
			--for _k, _v in pairs(v.level[i]) do
				if v.level[i].trigger then
					for j=1, #v.level[i].trigger do
						for __k, __v in pairs(v.level[i].trigger[j]) do
							local key = tostring(__k)
							if not a[key] then
								print(key)
								a[key] = 1
							end
						end

					end
				end

			--end
		end
	end
end
]]

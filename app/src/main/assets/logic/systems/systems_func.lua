--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/4/12
-- Time: 12:08
-- To change this template use File | Settings | File Templates.
-- 系统独立方法，不受逻辑重载干扰.

systems_func = {};

--[[加载器]]
systems_func.loader_create = asset_loader.create;
--[[OBJ建立]]
systems_func.game_object_create = asset_game_object.create;
systems_func.ngui_find_button = ngui.find_button;
systems_func.ngui_find_texture = ngui.find_texture;
systems_func.texture_load = texture.load;
systems_func.ancontroller_load = ancontroller.load;



--[[位运算]]
function systems_func.BitOr(bit_mask)
	local value = 0;
	for k, v in pairs(bit_mask) do
		value = bit.bit_or(value, v)
	end
	return value
end


-- 参数:待分割的字符串,分割字符
-- 返回:子串表.(含有空串)
function systems_func.string_split(str, split_char)
	local sub_str_tab = {};

	if str == nil or str == "" then return sub_str_tab end;

	while (true) do
		local pos = string.find(str, split_char);
		if (not pos) then
			sub_str_tab[#sub_str_tab + 1] = str;
			break;
		end
		local sub_str = string.sub(str, 1, pos - 1);
		sub_str_tab[#sub_str_tab + 1] = sub_str;
		str = string.sub(str, pos + 1, #str);
	end

	return sub_str_tab;
end

--截取中英混合的UTF8字符串，endIndex可缺省
function systems_func.SubStringUTF8(str, startIndex, endIndex)
    if startIndex < 0 then
        startIndex = systems_func.SubStringGetTotalIndex(str) + startIndex + 1;
    end

    if endIndex ~= nil and endIndex < 0 then
        endIndex = systems_func.SubStringGetTotalIndex(str) + endIndex + 1;
    end

    if endIndex == nil then 
        return str:sub(systems_func.SubStringGetTrueIndex(str, startIndex));
    else
        return str:sub(systems_func.SubStringGetTrueIndex(str, startIndex), systems_func.SubStringGetTrueIndex(str, endIndex + 1) - 1);
    end
end

--拆分服务器名
function systems_func.analyzeName(str, split_char)
    local sub_str_tab = { };

    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end

--    app.log("sub_str_tab=========="..table.tostring(sub_str_tab))

    return sub_str_tab;
end

--获取中英混合UTF8字符串的真实字符数量
function systems_func.SubStringGetTotalIndex(str)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat 
        lastCount = systems_func.SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(lastCount == 0);
    return curIndex - 1;
end

function systems_func.SubStringGetTrueIndex(str, index)
    local curIndex = 0;
    local i = 1;
    local lastCount = 1;
    repeat 
        lastCount = systems_func.SubStringGetByteCount(str, i)
        i = i + lastCount;
        curIndex = curIndex + 1;
    until(curIndex >= index);
    return i - lastCount;
end

--返回当前字符实际占用的字符数
function systems_func.SubStringGetByteCount(str, index)
    local curByte = str:byte(index)
    local byteCount = 1;
    if curByte == nil then
        byteCount = 0
    elseif curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4
    end
    return byteCount;
end

-- 设置下沉混排文本：2字以上文本头数量为2，少于2字文本头数量为1
function systems_func.SetSinkText(str, lab1, lab2)
    if str == nil then return end

    local str1, str2 = nil, nil
    if systems_func.SubStringGetTotalIndex(str) > 2 then
        str1 = systems_func.SubStringUTF8(str, 1, 2)
        str2 = systems_func.SubStringUTF8(str, 3)
    else
        str1 = systems_func.SubStringUTF8(str, 1, 1)
        str2 = systems_func.SubStringUTF8(str, 2)
    end

    if lab1 then lab1:set_text(str1 or "") end
    if lab2 then lab2:set_text(str2 or "") end
end
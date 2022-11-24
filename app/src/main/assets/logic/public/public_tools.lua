--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/6
-- Time: 16:36
-- To change this template use File | Settings | File Templates.
--

PublicTools = {};


--[[打印table
	@param o 传入table
	@param t 初始层级，不用填
	用法 log(PublicTools.show_table(table))
]]--
function PublicTools.show_table(o,t)
	if o ~= nil and type(o) ~= "table" and type(o) ~= "userdata" then
		return tostring(o);
	end
	-----
	if t == nil then t = 0; end
	if o == nil then do return "nil" end end
	local tc = "";
	for i=1,t do tc = tc.."\t"; end

	local str = "\n"..tc.."{\n";
	local haveO = false;
	if type(o) == "userdata" then
		str = "userdata:"..tostring(nn);
	elseif type(o) == "table" then
		for xx,nn in pairs(o) do
			haveO = true;
			if type(nn) == "table" then
				str = str..tc..xx..":"..PublicTools.show_table(nn,t+1).."\n";
			elseif type(nn) ~= "userdata" then
				str = str..tc..xx..":"..tostring(nn).."\n";
			else
				str = str..tc..xx..":".."userdata".."\n";
			end
		end
		--if haveO == true then str = str.."\n"; end
		str = str..tc.."}";
	else
		str = tostring(o);
	end
	return str;
end

--[[复制table]]--
function PublicTools.copy_table(st)
	if st == nil then return nil end
	local tab = {};
	for k,v in pairs(st or {}) do
		if type(v) ~= "table" then
			tab[k] = v;
		else
			tab[k] = copyTable(v);
		end
	end
	return tab;
end

return PublicTools;





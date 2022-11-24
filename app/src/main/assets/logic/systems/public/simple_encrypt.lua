-----------------------------------------------------------------------------
-- 字符串简单加密（数字字母）
-----------------------------------------------------------------------------
SimpleEncrypt = {}

local _Dictionary = {
	["A"] = "d", ["B"] = "E", ["C"] = "f", ["D"] = "C", ["E"] = "1", ["F"] = "a", ["G"] = "J",
	["H"] = "k", ["I"] = "L", ["J"] = "2", ["K"] = "h", ["L"] = "G", ["M"] = "p", ["N"] = "Q",
	["O"] = "3", ["P"] = "o", ["Q"] = "N", ["R"] = "m", ["S"] = "W", ["T"] = "4", ["U"] = "y",
	["V"] = "Z", ["W"] = "v", ["X"] = "U", ["Y"] = "5", ["Z"] = "s",
	["a"] = "e", ["b"] = "F", ["c"] = "g", ["d"] = "6", ["e"] = "D", ["f"] = "c", ["g"] = "B",
	["h"] = "A", ["i"] = "7", ["j"] = "n", ["k"] = "O", ["l"] = "P", ["m"] = "l", ["n"] = "8",
	["o"] = "j", ["p"] = "I", ["q"] = "V", ["r"] = "w", ["s"] = "9", ["t"] = "Y", ["u"] = "z",
	["v"] = "u", ["w"] = "T", ["x"] = "0", ["y"] = "R", ["z"] = "q",
	["0"] = "S", ["1"] = "b", ["2"] = "i", ["3"] = "r", ["4"] = "x", ["5"] = "t", ["6"] = "H",
	["7"] = "M", ["8"] = "K", ["9"] = "X",
};

local _SortDict = {}
for k, v in pairs( _Dictionary ) do
	table.insert( _SortDict, { k = k, v = v } )
end
table.sort( _SortDict, function ( A, B )
	if A == nil or B == nil then return false end;
	return A.k < B.k;
end )
--凑足64个字符
table.insert( _SortDict, { k = "+", v = "-" } )
table.insert( _SortDict, { k = "-", v = "+" } )

local _DictKeyIndex = {}
local _DictValueIndex = {}
for i, v in ipairs( _SortDict ) do
	_DictKeyIndex[ v.k ] = i
	_DictValueIndex[ v.v ] = i
end

local _Key = {0x3, 0x5, 0x7, 0x9, 0x11}

local _CreateHeadEncrypt = function( src )
	local head_encrypt = {}
	local encrypt_index = 0
	for i=1, math.min(#src, 5) do
		encrypt_index = bit.bit_or( bit.bit_xor( _DictKeyIndex[ string.sub(src, i, i) ], _Key[i] ), 0xC0 ) - 0xC0 + 1
		table.insert( head_encrypt, _SortDict[ encrypt_index ].v )
	end
	return table.concat( head_encrypt )
end

local _CreateHeadDecrypt = function( src )
	local head_decrypt = {}
	local decrypt_index = 0
	for i=1, math.min(#src, 5) do
		decrypt_index = bit.bit_or( bit.bit_xor( _DictValueIndex[ string.sub(src, i, i) ] - 1, _Key[i] ), 0xC0 ) - 0xC0
		table.insert( head_decrypt, _SortDict[ decrypt_index ].k )
	end
	return table.concat( head_decrypt )
end

local _IteratorKey = function ( src )
	local o = {}
	local key = 0
	local head = _CreateHeadEncrypt( src )
	local char = nil
	for index = 1, #head do
		char = string.sub(head, index, index)
		key = key + string.byte(char)
		o[index] = char
	end
	for index = #head + 1, #src do
		char = string.sub(src, index, index)
		local keyIndex = _DictKeyIndex[ char ]
		if keyIndex == nil then
			o[index] = char
		else
			o[index] = _SortDict[ (keyIndex + index + key - 1) % 64 + 1 ].v
		end
	end
	local i = 0
	return function()
		i = i + 1
		return o[i] and i, o[i]
	end
end

local _IteratorValue = function ( src )
	local o = {}
	local key = 0
	local head = _CreateHeadDecrypt( src )
	local char = nil
	for index = 1, #head do
		char = string.sub(src, index, index)
		key = key + string.byte(char)
		o[index] = string.sub(head, index, index)
	end
	for index = #head + 1, #src do
		char = string.sub(src, index, index)
		local valueIndex = _DictValueIndex[ char ]
		if valueIndex == nil then
			o[index] = char
		else
			o[index] = _SortDict[ (valueIndex - 1 - key - index) % 64 + 1 ].k
		end
	end
	local i = 0
	return function()
		i = i + 1
		return o[i] and i, o[i]
	end
end

-- 加密
function SimpleEncrypt.Encode( src )
	if src == nil or src == "" then return "" end;
	local result = {};
	for i, v in _IteratorKey( src ) do
		table.insert( result, v )
	end
	return table.concat( result );
end

-- 解密
function SimpleEncrypt.Decode( src )
	if src == nil or src == "" then return "" end;
	local result = {};
	for i, v in _IteratorValue( src ) do
		table.insert( result, v )
	end
	return table.concat( result );
end

---[[ test
-- local encrypt_result = SimpleEncrypt.Encode("fda6s21Dsa45789lYkj4lnKdsl98")
-- app.log(encrypt_result)
-- app.log(SimpleEncrypt.Decode(encrypt_result))
--]]

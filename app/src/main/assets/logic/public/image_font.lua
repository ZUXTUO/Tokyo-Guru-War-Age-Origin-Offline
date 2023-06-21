
ImageFont = {};

ImageFont.Map = {
	["榜"] = "/bang1",
	["宝"] = "/bao1",
	["包"] = "/bao2",
	["备"] = "/bei1",
	["背"] = "/bei2",
	["崩"] = "/beng1",
	["场"] = "/chang1",
	["充"] = "/chong1",
	["闯"] = "/chuang1",
	["大"] = "/da1",
	["店"] = "/dian1",
	["动"] = "/dong1",
	["斗"] = "/dou1",
	["队"] = "/dui1",
	["防"] = "/fang1",
	["赋"] = "/fu1",
	["攻"] = "/gong1",
	["挂"] = "/gua1",
	["关"] = "/guan1",
	["馆"] = "/guan2",
	["行"] = "/hang1",
	["好"] = "/hao1",
	["坏"] = "/huai1",
	["活"] = "/huo1",
	["机"] = "/ji1",
	["技"] = "/ji2",
	["极"] = "/ji3",
	["鉴"] = "/jian1",
	["界"] = "/jie1",
	["经"] = "/jing1",
	["竞"] = "/jing2",
	["究"] = "/jiu1",
	["角"] = "/jue1",
	["卡"] = "/ka1",
	["科"] = "/ke1",
	["克"] = "/ke2",
	["练"] = "/lian1",
	["炼"] = "/lian2",
	["聊"] = "/liao1",
	["隆"] = "/long1",
	["乱"] = "/luan1",
	["募"] = "/mu1",
	["排"] = "/pai1",
	["任"] = "/ren1",
	["容"] = "/rong1",
	["色"] = "/se1",
	["商"] = "/shang1",
	["上"] = "/shang2",
	["社"] = "/she1",
	["世"] = "/shi1",
	["试"] = "/shi2",
	["首"] = "/shou1",
	["所"] = "/suo1",
	["特"] = "/te1",
	["天"] = "/tian1",
	["挑"] = "/tiao1",
	["厅"] = "/ting1",
	["图"] = "/tu1",
	["团"] = "/tuan1",
	["务"] = "/wu1",
	["限"] = "/xian1",
	["箱"] = "/xiang1",
	["训"] = "/xun1",
	["验"] = "/yan1",
	["研"] = "/yan2",
	["友"] = "/you1",
	["远"] = "/yuan1",
	["战"] = "/zhan1",
	["招"] = "/zhao1",
	["阵"] = "/zhen1",
	["征"] = "/zheng1",
	["制"] = "/zhi1",
	["值"] = "/zhi2",
	["装"] = "/zhuang1",
	["权"] = "/quan1",

	["3"] = "/#3",
	["B"] = "/#b",
	["·"] = "/#.",
	["I"] = "/#i",
	["O"] = "/#o",
	["P"] = "/#p",
	["S"] = "/#s",
	["V"] = "/#v",
}


ImageFont.GetCodeString = function(str)
	if type(str) ~= "string" then return str end

	local charArray = {}
    local sameCharSign = {}
    local n = 1
	local numByte = 0

    local b = str:byte(1)
    while (b) do
        if b < 128 then
			numByte = 1
        elseif b < 224 then
			numByte = 2
        elseif b < 240 then
			numByte = 3
        else
			numByte = 4
        end
		table.insert(charArray, str:sub(n, n + numByte -1))
		n = n + numByte;
        b = str:byte(n);
		--相同文字标识(标识符$)
		if b == 36 then
			sameCharSign[#charArray] = str:sub(n+1, n+1)
			n = n + 2
			b = str:byte(n)
		end
    end

	local codeString = {}
	for i, v in ipairs(charArray) do
		table.insert(codeString, ImageFont.GetCodeChar(v, sameCharSign[i]))
	end

	return table.concat(codeString);
end

ImageFont.GetCodeChar = function(ch, sign)
	local codeChar = ImageFont.Map[ch]

	if codeChar and type(codeChar) == "table" then
		codeChar = codeChar[tonumber(sign) or 1]
	end

	return codeChar or ""
end
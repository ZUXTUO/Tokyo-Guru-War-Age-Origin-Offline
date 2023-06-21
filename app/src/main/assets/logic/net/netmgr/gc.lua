local gc = {};
netmgr.gc = gc;

function gc:init()
	self.para = nil;
	self.idCode = nil;
	self.modeName = nil;
	self.isNotify = false;
	self.splitCount = 0;
	self.combinCount = 1;
end

function gc:new(name,idCode,...)
	if not name or name == "" then 
		error("----------netmgr respone call name error!!!!!");
		do return end;
	end

	--DevPrint.print("---------netmgr Server Notify Res:"..name..",idCode is :"..tostring(idCode),5);

	local o = {};
	setmetatable(o,{__index = self});
	o:init();
	o.modeName = name;
	o.para = arg;
	o.idCode = idCode;
	--�Բ���Ҫ��ֵ�Э����˵��splitCount����ֶ���û�õģ�������������
	if o.para and table.getall(o.para) > 0 then  
		o.splitCount = o.para[1];
	end
	netmgr.receive(o);
	return o;
end

function gc:getIdCode()
	return self.idCode;
end

function gc:getModeName()
	return self.modeName;
end

function gc:getPara()
	return self.para;
end


--������Ҫ��ϵĴ���
function gc:getSplitCount()
	return self.splitCount;
end

function gc:setSplitCount(value)
	if value then 
		self.splitCount = value;
	end
end

--�����Ѿ���ϵĴ���
function gc:getCombinCount()
	return self.combinCount;
end


--�Ƿ�������
function gc:isCombinComplete()
	if self.combinCount == self.splitCount then 
		return true;
	else
		return false;
	end
end

--���Э���в�֣�����Ҫ�������Э��
function gc:combination(argRes)
	if argRes and argRes.getIdCode and argRes:getIdCode() then 
		local isCombination = false;
		for k,v in pairs(self.para or {}) do
			if type(v) == "table" then 
				local sourcePara = argRes:getPara();
				local sourceTab = sourcePara[k];
				netmgr.util.concatTable(v,sourceTab);
				isCombination = true;
			end
		end
		if isCombination then 
			self.combinCount = self.combinCount + 1;
		end
	end
end

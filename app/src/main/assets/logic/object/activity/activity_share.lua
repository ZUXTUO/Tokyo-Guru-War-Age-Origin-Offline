ActivityShare = Class('ActivityShare')

function ActivityShare:Init()
	self.data = {};
	self.allsharedatalist = ConfigManager._GetConfigTable(EConfigIndex.t_share_activity);
    self.powerlist = {};
    self.lvllist = {};
    self.playerlist = {};

    self.uipowerlist = {};
    self.uilvllist = {};
    self.uiplayerlist = {};
    self:initData()

	return self
end

function ActivityShare:initData()

	--Key
    local tpowerlist = {}
    local tlvllist = {}
    local tplayerlist = {}

    --排序
    local spowerlist = {}
    local slvllist = {}
    local splayerlist = {}

    for k,v in pairs(self.allsharedatalist) do
    	if v.type == 1 then
    		tpowerlist[v.id] = v
    	elseif v.type == 2 then
    		tlvllist[v.id] = v
    	elseif v.type == 3 then
    		tplayerlist[v.id] = v
    	end
    end

    local index = 1 

    for k,v in pairs(tpowerlist) do
    	spowerlist[index] = v
    	index = index+1
    end

    local index = 1

    for k,v in pairs(tlvllist) do
    	slvllist[index] = v
    	index = index + 1
    end

    local index = 1

    for k,v in pairs(tplayerlist) do
    	splayerlist[index] = v
    	index = index + 1
    end

    local sortFunc = function(a,b)
        if a.id < b.id then
            return true
        else
        	return false
        end
    end

    --排序处理
    table.sort(spowerlist,sortFunc);
    
    for k,v in pairs(spowerlist) do
       table.insert(  self.powerlist,v )   
    end

    table.sort(slvllist,sortFunc);
    
    for k,v in pairs(slvllist) do
       table.insert(  self.lvllist,v )   
    end

    table.sort(splayerlist,sortFunc);
    
    for k,v in pairs(splayerlist) do
       table.insert(  self.playerlist,v )   
    end

    --app.log("self.powerlist============"..table.tostring(self.powerlist))

    --app.log("self.lvllist============"..table.tostring(self.lvllist))

    --app.log("self.playerlist============"..table.tostring(self.playerlist))
end

function ActivityShare:SetData(data)
	--self.data = data
	for k,v in pairs(data) do
		self.data[v.id] = v
	end

	self:setActivityState()

end

function ActivityShare:setActivityState()
	
	self.uipowerlist = {};
    self.uilvllist = {};
    self.uiplayerlist = {};

	self:setPowerlistData()
	self:setLvllistData()
	self:setPlayerlistData()
end

function ActivityShare:setPowerlistData()
	for k,v in pairs(self.powerlist) do
		table.insert(self.uipowerlist,v)
	end

end

function ActivityShare:setLvllistData()

	for k,v in pairs(self.lvllist) do
		table.insert(self.uilvllist,v)
	end

end

function ActivityShare:setPlayerlistData()

	for k,v in pairs(self.playerlist) do
		table.insert(self.uiplayerlist,v)
	end

end

function ActivityShare:SetStateToShare(id)
	if self.data[id] then
		self.data[id].state = 2
	end

end

function ActivityShare:SetStateToAward(id)
	if self.data[id] then
		self.data[id].state = 3
	end
end

function ActivityShare:GetSatte(id)
	if self.data[id] then
		return self.data[id].state
	else
		app.log("配置表错误！")
	end
end

function ActivityShare:GetProgress(id)
	if self.data[id] then
		return self.data[id].progress
	else
		app.log("配置表错误！")
	end
end

function ActivityShare:getPowerlist()
	return self.uipowerlist
end

function ActivityShare:getlvllist()
	return self.uilvllist
end

function ActivityShare:getplayerlist()
	return self.uiplayerlist
end

function ActivityShare:getAllData()
	return self.data
end
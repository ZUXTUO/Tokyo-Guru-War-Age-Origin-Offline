trainning = Class('trainning')

function trainning:Init()
    --self.trainninglist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
    --self.haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
	self.currentroleinf = nil;
        self.selectroleinfo = nil;
        self.battlelvl = {};
    return self
end

function trainning:set_currentroleinfo(info)
	self.currentroleinf  = info
end

function trainning:clear_currentroleinfo()
    self.currentroleinf = nil;
end

function trainning:get_currentroleinfo()
	return self.currentroleinf
end

function trainning:set_selectroleinfo(info)
    self.selectroleinfo = info
end

function trainning:get_selectroleinfo()
    return self.selectroleinfo
end

function trainning:set_saveBattleLvl( data )
    for k, v in pairs(data)do
        self.battlelvl[v.high] = {low = v.low,high = v.high};
    end
end

function trainning:get_BattleLvl()
   return  self.battlelvl
end

function trainning:get_Battleforgroup(group)
   return self.battlelvl[group].low
end

function trainning:set_BattleLvl(gid,newLevel)
   --app.log("battlelvl##########################"..table.tostring(self.battlelvl))--self.btaalelvl[gid] = {}
   self.battlelvl[gid] = {low=newLevel, high=gid};
   --app.log("battlelvl##########################"..table.tostring(self.battlelvl))
end

function trainning:initUIData()
    self.AllHerolist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping)
    local line = #self.AllHerolist
    self.herolist = {}
    for k,v in pairs(self.AllHerolist) do
        --app.log("vvv##########"..table.tostring(v))
        --self.herolist[k] = v
        for kk,vv in pairs(v) do
            table.insert(self.herolist,vv[2])  
        end
    end
    
    --app.log("self.herolist###############"..table.tostring(self.herolist))
    self:setHaveHerolist()
    
end

function trainning:setHaveHerolist()
    self.haveherolist = {}
    self.haveheroinfo = {}
    for k,v in pairs( self.herolist ) do
        if self:isHaveHero(v) ~= "" then
            table.insert(self.haveherolist,v)
            local cardinfo = g_dataCenter.package:find_card(1, self:isHaveHero(v));
            self.haveheroinfo[v] = cardinfo
        end
    end      

end

function trainning:isUpLvlHero(id)
    if self.haveheroinfo[id] then
        local lvl = self.haveheroinfo[id].trainingHallLevel
        local pzname = "t_training_hall_"..tostring(id)
        local expdata = ConfigManager.Get(EConfigIndex[pzname],lvl);--ConfigMananger.Get(EconfigIndex.pzname,lvl - 1)
        --app.log("expdata#####################"..tostring(expdata.exp))
        local Allexp = expdata.exp
        
        if Allexp == 0 then
            return true
        else
            return false
        end
    else
        return false 
    end
end

function trainning:isHaveHero(id)
    local card = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, id)
    if card then
        return card.index;
    end
    return "";
end

function trainning:needlvl()
    local cf = ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_Trainning);
    local lvl = g_dataCenter.player.level;
    
    if cf.open_level > lvl then
        return false 
    else
        return true
    end
end

function trainning:IsOpen()
    if not self.AllHerolist then return false end
    local line = #self.AllHerolist
    
    for i=1,line do
        local data = self.AllHerolist[i]
        local flag = true;        
        local maxline = #data
        local curi = 0
        for k,v in pairs(data) do
            local dataid = self:isHaveHero(v.heroid)
            if dataid ~= "" then
                flag = self:computitem(i)
                if flag then
                    return true
                end
            else
                flag = false;
                break;
            end
            
            curi = curi + 1
            if curi == maxline then
                return true 
            end
        end
    end
    
    return false;
end

function trainning:isTips()
    --app.log("trainning:isTips()"..table.tostring(self.AllHerolist)) 
    
    if not self.AllHerolist then return false end
    local line = #self.AllHerolist
    
    local flag = true;   
    
    for i=1,line do
        local data = self.AllHerolist[i]
             
        for k,v in pairs(data) do
            local dataid = self:isHaveHero(v.heroid)

            if dataid ~= "" then
                --app.log("dataid=============="..tostring(dataid))
                flag = self:computitem(i)
                --local maxline = self:computlineMax(i)
                
                if flag == true then
                    --flag = true;
                    --app.log("maxline=========================="..tostring(dataid))
                    return true
                end
            else
                --app.log("false==========================")
                flag = false;
            end
        end
    end
    --app.log("trainning:isTips()"..tostring(flag))
    return flag
end

function trainning:computMax(cardinfo)
    local nextplayerinfolvl = cardinfo.trainingHallLevel + 1
    local playerinfonumber = "t_training_hall_"..tostring(cardinfo.default_rarity)
    local expdatainfo = ConfigManager.Get(EConfigIndex[playerinfonumber],nextplayerinfolvl)
    local isMax = false;
    --app.log("expdatainfo========"..table.tostring(expdatainfo))
    --app.log("nextplayerinfolvl========="..tostring(nextplayerinfolvl))
    if expdatainfo then
        isMax = false;
    else
        isMax = true
    end

    return isMax
end

function trainning:computlineMax()

    local flag = true

    local index = #self.AllHerolist
    
    for i=1,index do
        local number = 0;
        local data = self.AllHerolist[i]
        local line = #data
        for k,v in pairs(data) do
            local dataid = self:isHaveHero(v.heroid)
            if dataid ~= "" then
                local cardinfo = g_dataCenter.package:find_card(1, dataid);
                local isMax = self:computMax(cardinfo)
                if isMax then
                    number = number + 1
                end
            end
        end

        if number == line then
            flag = false
        else
            --app.log("number================="..tostring(number))
           --app.log("line================="..tostring(line))
            return true
        end
    end

    return flag

end

function trainning:computitem(index)
    local addexpitemlist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_item);
    
    --local maxline = 8
    --for i=1,8 do
    --app.log("index################"..tostring(index))
    
    local currentvalue = 100+ index
        
    for k,v in pairs(addexpitemlist[currentvalue])do 
            
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,v[2]);
        --app.log("number################"..tostring(number))
        if number > 0 then
            return true
        end
    end
        
    --end
    return false
end

function trainning:computhero(index)
    local flag = false

    local data = ConfigManager.Get(EConfigIndex.t_training_hall_grouping,index)

    --app.log("data..................."..table.tostring(data))

    for k,v in pairs(data) do
        local dataid = self:isHaveHero(v.heroid)
        if dataid ~= "" then
            return true
        end
    end

    return flag
end

function trainning:computbattle( index )
    local data = self.AllHerolist[index]
    local battledata = g_dataCenter.trainning:get_BattleLvl()[index]
    if battledata == nil then
        return false
    end

    local maxlvl = battledata.low
    local flag = true;
    local maxline = #data

    local curi = 0

    for k,v in pairs(data) do
        local dataid = self:isHaveHero(v.heroid)
        if dataid ~= "" then
            local lvl = self:computLvl(dataid)
            if lvl <= maxlvl then
                flag = false
                break;
            end
        else
            flag = false;
            break;
        end
    
        curi = curi + 1
    
    end

    if curi == maxline then
        return true 
    end

    return false

end

function trainning:isUpBattle()
    --local trainningdata = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping)
    local line = #self.AllHerolist
    --app.log("line#############"..tostring(line))
    for i=1,line do
        local data = self.AllHerolist[i]
        local battledata = g_dataCenter.trainning:get_BattleLvl()[i]
        if battledata == nil then
            return false
        end
        local maxlvl = battledata.low
        
        local flag = true;
        --app.log("111111111111111111111111111111111111111"..tostring(i))
        local maxline = #data
        local curi = 0
        for k,v in pairs(data) do
            local dataid = self:isHaveHero(v.heroid)
            if dataid ~= "" then
                local lvl = self:computLvl(dataid)
                if lvl <= maxlvl then
                    flag = false
                    break;
                end
            else
                flag = false;
                break;
            end
        
            curi = curi + 1
        
        end
    
        if curi == maxline then
            return true 
        end
        
    end
    
    return false
    
end

function trainning:computLvl(dataid)
    local cardinfo = g_dataCenter.package:find_card(1, dataid);
    local lvlindex = cardinfo.trainingHallLevel
    --self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);

    local roleid = cardinfo.default_rarity
	
    for k,v in pairs( self.AllHerolist )do
	for kk,vv in pairs(v)do
	    if vv[2] == roleid then
		self.currentline = k; --行
		self.currentlinex = kk; -- 列
	    end
	end    
    end    
    
    local currentNeedexp = self.AllHerolist[self.currentline][self.currentlinex]
	
    local currentNeedexpdata = currentNeedexp.att_lv
    
    --local index = cardinfo.trainingHallLevel
    local pzname = "t_"..currentNeedexpdata
	
    local expdata = ConfigManager.Get(EConfigIndex[pzname],lvlindex);
	
    local lvl = ConfigManager.Get(EConfigIndex[pzname],lvlindex).adv_level;
    
    return lvl
end

--物品id 查找 英雄组
function trainning:computitemToHero(itemid)

    local addexpitemlist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_item);

    local group = "";

    for k,v in pairs(addexpitemlist) do
        for kk,vv in pairs(v) do
            if itemid == vv[2] then
                group = tostring(vv[1])
                break
            end
        end
    end

    local selectgroup = "";
    if group ~= "" then
        local len = string.len(group)
        selectgroup = string.sub(group, len, len)
    end
       
    return selectgroup
end


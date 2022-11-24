
------------------------- 数据对象 ---------------------------
Institute = Class("Institute");

function Institute:Init()
    self.data = { };   --所有数据
    --snIndex;			//编号
    --bool isUnLock;		//是否解锁
    --double max_hp;			//生命值
    --double max_hp_ex;			//生命值
    --double atk_power;		//攻击
    --double atk_power_ex;		//攻击
    --double def_power;		//防御
    --double def_power_ex;		//防御
    --double crit_rate;		//暴击率
    --double crit_rate_ex;		//暴击率
    --double anti_crite;		//免爆率
    --double anti_crite_ex;		//免爆率
    --double crit_hurt;		//暴击伤害加成
    --double crit_hurt_ex;		//暴击伤害加成
    --double broken_rate;		//破击率
    --double broken_rate_ex;		//破击率
    --double parry_rate;		//格挡率
    --double parry_rate_ex;		//格挡率
    --double parry_plus;		//格挡伤害加成
    --double parry_plus_ex;		//格挡伤害加成.
    self.unLockList = {};       --解锁列表
    self.isOpenflag = false;
    self.unLockCondlist = {};   --条件列表
    self.unLockIndex = 1;
    
    return self
end

function Institute:setunlockindex()
    self.unLockIndex = 1
end

function Institute:SetData(index, data)
    
    self.data[index] = data
   
    if self.data[index].isUnLock then
        self.unLockList[index] = data
        self.unLockIndex = self.unLockIndex + 1
        --app.log("unLockIndex==========33333========="..tostring(self.unLockIndex))
    else
        self:initUnLockCondition(index,data.vecUnlockInfo)
    end
    
    self.isOpenflag = true;
end

--初始化解锁条件   1,战队等级 2、关卡星数 3、角色数量 4关卡 5角色品质 5 角色星级
function Institute:initUnLockCondition(index,list)
    --app.log("index ================"..tostring(index))
    self.unLockCondlist[index] = list
    
    --app.log("unLockCondlist=========="..table.tostring(self.unLockCondlist[index]))    
end


function Institute:checkIsFinish()
    
    local flag = true
     --app.log("............."..debug.traceback())
    --app.log("unLockIndex*******=========="..tostring(self.unLockIndex))
    --app.log("............."..debug.traceback())
    --app.log("unLockCondlist=========="..table.tostring(self.unLockCondlist))
    if self.unLockCondlist[self.unLockIndex] == nil then
        return false
    end

    for k,v in pairs(self.unLockCondlist[self.unLockIndex]) do
        
        local unlockid = v.unlockid
        local infodata = ConfigManager.Get(EConfigIndex.t_yanjiusuo_unlock,unlockid)
        if infodata.unlock_type == 1 then
            flag = self:checkLvl(infodata.param1)
        elseif infodata.unlock_type == 2 then
            flag = self:checkHurStar(infodata.param1)
        elseif infodata.unlock_type == 3 then
            flag = self:checkProNum(infodata.param1)
        elseif infodata.unlock_type == 4 then
            flag = self:checkhurNum(infodata.param1)
        elseif infodata.unlock_type == 5 then
            flag = self:checkProPZ(infodata.param1,infodata.param2)
        elseif infodata.unlock_type == 6 then
            flag = self:checkProStar(infodata.param1,infodata.param2)
        end
        
        --app.log("flag=================="..tostring(flag))
        
        if flag == false then
            --app.log("unlockid=================="..tostring(unlockid))
            return false
        end
    end
    
    return flag
    
end


--检测等级
function Institute:checkLvl( lvl )
    --app.log("lvl================"..tostring(lvl))
    --app.log("currentlvl================"..tostring(g_dataCenter.player.level))
    local currentlvl = g_dataCenter.player.level
    
    if lvl <= currentlvl then
        return true
    else
        return false 
    end
    
    
end
--检测关卡星数
function Institute:checkHurStar( star )
    local HurStar = g_dataCenter.hurdle:GetTotalStarNum(-1)
    
    if star <= HurStar then
        return true
    else
        return false 
    end
    
end
--检测人物数量
function Institute:checkProNum( number )
    local havehero = g_dataCenter.package:GetCont(ENUM.EPackageType.Hero)
    
    if number <= havehero then
        return true
    else
        return false 
    end
    
end
--检测关卡
function Institute:checkhurNum(id)
    --app.log("checkhurNum================"..tostring(g_dataCenter.hurdle:IsPassHurdle(id)))
    return g_dataCenter.hurdle:IsPassHurdle(id)
end
--检测人物品质
function Institute:checkProPZ( num ,rarity)
    --realRarity
    local AllCard = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero)
    --app.log("AllCard============="..table.tostring(AllCard))
    local number = 0;
    for k,v in pairs(AllCard) do
        if v.realRarity >= rarity then
            number = number + 1
        end
    end
    
    if num <= number then
        return true
    else
        return false 
    end
end
--检测人物星级
function Institute:checkProStar( num,star )
    --rarity
    local AllCard = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero)
    local number = 0;
    
    for k,v in pairs(AllCard) do
        if v.rarity >= star then
            number = number + 1
        end
    end
    
    if num <= number then
        return true
    else
        return false 
    end
end

function Institute:GetAllData()
   return self.data 
end

function Institute:GetData(index)
   if self.data[index] then
        return self.data[index]
    end
end

function Institute:getUnlockList()
    return  self.unLockList
end

function Institute:Finalize()
    self.data = { };
    
end

function Institute:updata( index ,data )
    if self.data[index] then
        self.data[index] = data
    end
end

function Institute:unLock(index)
    if self.data[index] then
       self.data[index].isUnLock = true;
    end
    
    if self.unLockCondlist[index] then
        self.unLockCondlist[index] = nil; 
    end
    
    self.unLockIndex = index + 1
    
   --app.log("unLockIndex22222222=========="..tostring(self.unLockIndex))
   -- app.log("unLockCondlist======="..table.tostring(self.unLockCondlist))
end

function Institute:IsUnlock(index)
    if self.data[index] then
        return self.data[index].isUnLock
    else
       return false 
    end
end

function Institute:IsOpen()
    
    --app.log("self.isOpenflag##########"..tostring(self.isOpenflag))
    if self.isOpenflag then
        
        for i=1,#self.data do
        
            local data = self.data[i]
            
            local IsUnlockBtn = false
            
            if data.isUnLock then
                IsUnlockBtn = true
            else
                IsUnlockBtn = false
            end
            
            --app.log("data ##############"..table.tostring(data))
            
            local flag = true;
        
            for k,v in pairs( data.vecUnlockInfo )do
                if v.bUnlock == false then
                    flag = false;
                    --app.log("flag ##############"..tostring(flag))
                    break;
                end
            end
            
            --app.log("IsUnlockBtn ##############"..tostring(IsUnlockBtn))
            --app.log("flag ##############"..tostring(flag))
            
            if flag == true and IsUnlockBtn == false then
               return true
            end
        end
    end
    
    return false
end

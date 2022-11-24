
Marquee = Class("Marquee")

local _UIText = {
    [1] = "%s区·"
}

local Level = {
    GM_FORCE = 1,
    GM = 2,
    L1 = 3,
    L2_1 = 4,
    L2_2 = 5
}

--颜色编号
local ColorNumber = {
    [1] = "ffffff",    --白色
    [2] = "afff00",    --绿色
    [3] = "00a8ff",    --蓝色
    [4] = "7e40cd",    --紫色
    [5] = "ffcd03",    --金色
    [6] = "feb900",    --橙色
}

function Marquee:Init()
    self.bindfunc = {};
    self:registFunc()
    self.marqueeList = {}
    for _, v in pairs(Level) do
        self.marqueeList[v] = {}
    end
    self.defStartPos = 640
    self.defEndPos = - 640
    self.curMarquee = nil
    self.canMove = true
    self.marqueeInter = -1
    -- 移动距离 2.5
    self.speed = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_marqueeMoveSpeed).data           
    self.upInter = 0.02        -- 刷新间隔(秒）
    self.uiWidth = 0
end

function Marquee:registFunc()
    self.bindfunc["update"] = Utility.bind_callback(self, Marquee.update)
end

function Marquee:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

--[[初始化数据]]
function Marquee:initData(data)

    if self.ui == data.label then
        return
    end

   self.ui = data.label
   self.obj = data.label:get_game_object()
   self.parentNode = self.obj:get_parent()

   self.startPos = data.startPos or self.defStartPos
   self.endPos = data.endPos or self.defEndPos
   self.justShowHasData = data.justShowHasData

   self.ui:set_text("")
   self.mX, self.mY, self.mZ = self.obj:get_local_position()
   self:resetPos()

   self.isShow = true

   if self.justShowHasData == true then
        self:setUiActive(false)
   end
end

function Marquee:setUiActive(is)
    if not self.parentNode or self.isShow == is then return end

    self.isShow = is
    self.parentNode:set_active(is)
end

--[[开始刷新]]
function Marquee:start()
   if not TimerManager.IsRunning(self.bindfunc["update"]) then
        TimerManager.Add(self.bindfunc["update"], self.upInter * 1000, -1)
   end
end

--[[停止刷新]]
function Marquee:stop()
   TimerManager.Remove(self.bindfunc["update"])
   self.ui = nil
   self.obj = nil
end

 --[[设置为起点位置]]
function Marquee:resetPos()   
   self.mX = self.startPos
   if self.obj ~= nil then
        self.obj:set_local_position(self.mX, self.mY, self.mZ)
   end
end

--[[刷新跑马灯]]
function Marquee:update()   
    self:setMarquee()
    self:runMarquee() 
end

--[[设置跑马灯数据]]
function Marquee:setMarquee()     
    if self.curMarquee ~= nil then 
        return 
    end 
    local data = nil
    for _, list in ipairs(self.marqueeList) do
        if #list ~= 0 then
            data = list[1]
            -- 立即删除
            table.remove(self.marqueeList[data.level], 1)
            break
        end
    end
    if data ~= nil then

        if self.justShowHasData == true then
            self:setUiActive(true)
        end

        self.curMarquee = data 
        if self.ui ~= nil then   
            -- 设置内容
            self.ui:set_text(data.content)
            -- 获得内容宽度
            self.uiWidth, _ = self.ui:get_size()
        end 
    else
        if self.justShowHasData == true then
            self:setUiActive(false)
        end
    end
end

--[[让跑马灯滚动起来]]
function Marquee:runMarquee()
    if self.curMarquee == nil then return end 

    -- 单次执行完成 
    if self:move() == false then         
        -- 间隔结束
        if self:haveInter() == false then
            self.curMarquee.loop = self.curMarquee.loop - 1
            -- 所有执行结束
            if self.curMarquee.loop == 0 then 
                self.curMarquee = nil
            end
        end            
    end 
    
end

--[[移动label]]
function Marquee:move()
    if self.canMove == true then 
        self.mX = self.mX - self.speed
        if self.obj ~= nil then
            self.obj:set_local_position(self.mX, self.mY, self.mZ)
        end
        self.canMove = self.mX + self.uiWidth > self.endPos
    end
    return self.canMove 
end

--[[检查跑马灯是否有间隔]]
function Marquee:haveInter()
    if self.curMarquee.inter > 0 then
        -- 初始化
        if self.marqueeInter == -1 then 
            self.marqueeInter = self.curMarquee.inter
        end
        -- 是否是最后一次
        if self.curMarquee.loop - 1 == 0 then
            self.marqueeInter = 0
        else 
            self.marqueeInter = self.marqueeInter - self.upInter
        end
    end 
    -- 间隔结束(无间隔为-1)
    if self.marqueeInter <= 0 then
        self.marqueeInter = -1
        self.canMove = true
        self:resetPos()
        return false
    end
    return true
end

--[[添加消息]]
function Marquee:addMarquee(data)
    local temp = {}
    temp.loop = data.loopTimes
    temp.inter = data.interval
    if temp.loop == 1 then
        temp.inter = 0 
    end

    -- gm后台消息
    if data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_GM then
        -- 消息id
        temp.marqueeId = data.noticeID
        if data.bForce then
            temp.level = Level.GM_FORCE
        else 
            temp.level = Level.GM
        end
        temp.content = data.content
    -- 系统消息
    else
        --玩家数据是否返回
        if g_dataCenter.player and g_dataCenter.player.playerid ~= 0 then
        else
            return
        end

        -- 需要参数来组装消息
        --if #data.vecParm == 0 then return end
        local para = {}
        for k, v in ipairs(data.vecParm) do 
            para[k] = v
        end
        
        -- 购买月卡/成为VIP/扭蛋系统/世界宝箱1/世界宝箱2
        if data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_monthCard 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_vip
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_niudan 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemOpenCD 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemOpened 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxFreeCD 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxFreed 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemCloseCD 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_map_boss_kill    
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_go_to_kill_boss
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxOpened 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollmessage_type_power_rank 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollmessage_type_lucky_cat then
            temp.level = Level.L1  
            temp.content = self:getContentL1(data.ntype, para)

        -- 世界BOSS/帮派BOSS/帮派战(二类消息一级)
        elseif data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldBoss 
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_guildBoss
                or data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_guildWar then
            temp.level = Level.L2_1 
            local para1Str = para[1]   
            local areaName = self:GetAreaName(ntype, para)
            if areaName ~= nil then
                para1Str = areaName
            end        
            temp.content = string.format(self:getMarqueeContent(data.ntype), para1Str, para[2]) 
       
        -- 其它(二类消息二级)
        else
            temp.level = Level.L2_2
            if data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_vipOnlineTips then
                temp.content = data.content
            else
                temp.content = self:getContentL2_2(data.ntype, para)
            end    
        end
    end 
    if data.ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxOpened then
        local chat_info = {}
        chat_info.type = PublicStruct.Chat.system
        chat_info.content = temp.content
        chat_info.time = tostring(system.time())
        chat_info.sender = {}
        chat_info.sender.playerid = ""
        chat_info.sender.name = ""
        chat_info.sender.vip = 0
        chat_info.sender.image = 0
        chat_info.sender.country_id = 0
        chat_info.target = {}
        chat_info.target.playerid = ""
        chat_info.target.name = ""
        chat_info.target.vip = 0
        chat_info.target.image = 0
        chat_info.target.country_id = 0
        chat_info.ctype = PublicStruct.Chat_Type.text
        g_dataCenter.chat:add_chat(chat_info);
        PublicFunc.msg_dispatch(msg_chat.gc_add_player_chat);
    end
    self:saveMarquee(temp, data.ntype) 
    self:removeMoreMarquee(temp.level)
end


--[[保存消息]]
function Marquee:saveMarquee(temp, ntype) 
    --顺序显示 vip7.6.5....
    if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_vip 
        or nTyep == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxOpened then
        table.insert(self.marqueeList[temp.level], temp)
    else
        table.insert(self.marqueeList[temp.level], 1, temp)
    end
end

--[[删除多余消息]]
function Marquee:removeMoreMarquee(level) 
    -- 一类消息，保存20条
    if level == Level.L1 then
        if #self.marqueeList[level] > 20 then
            table.remove(self.marqueeList[level])
        end
    -- 二类消息一级，保存20条
    elseif level == Level.L2_1 then
       if #self.marqueeList[level] > 20 then
            table.remove(self.marqueeList[level])
       end
    -- 二类消息二级，保存100条    
    elseif level == Level.L2_2 then
        if #self.marqueeList[level] > 100 then
            table.remove(self.marqueeList[level])
        end
    end
end

--[[设置一级内容]]
function Marquee:getContentL1(ntype, para)
    local para1Str = para[1]
    local areaName = self:GetAreaName(ntype, para)
    if areaName ~= nil then
        para1Str = areaName
    end

    local para2Str = para[2]
    local para3Str = para[3]
    local para4Str = para[4]

    --app.log("getContentL1------->" .. tostring(para1Str) .. ' ' .. tostring(para2Str) .. ' ' .. tostring(para3Str))  
    local para1 = tonumber(para[1])  
    local para2 = tonumber(para[2])  
    local para3 = tonumber(para[3])  
    local para4 = tonumber(para[4])      

    -- 判断当前是装备还是英雄           
    if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_niudan then
	    if PropsEnum.IsEquip(para3) then

        elseif PropsEnum.IsRole(para3) then
		    local info = ConfigHelper.GetRole(para3);
            if info ~= nil and info.name ~= nil then
                para3Str = info.rarity
                para4Str = info.name
            end
        end 

    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxOpened then
        para1Str = ConfigManager.Get(EConfigIndex.t_country_info, para1).name;
        para3Str = para1Str

    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_map_boss_kill then
        --boss name
        local boss_config = ConfigManager.Get(EConfigIndex.t_map_boss, para1)
        if boss_config and boss_config.boss_id then
            local _config = ConfigManager.Get(EConfigIndex.t_monster_property,boss_config.boss_id)
            para1Str =  _config.name 
        end    
        para2Str = self:GetAreaName(ntype, para)
        para4Str = PropsEnum.GetName(para4)

    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_go_to_kill_boss then
        --boss name
        local boss_config = ConfigManager.Get(EConfigIndex.t_map_boss,para1)
        if boss_config and boss_config.boss_id then
            local _config = ConfigManager.Get(EConfigIndex.t_monster_property,boss_config.boss_id)
            para1Str =  _config.name 
        end        
        --地图名
        local _country_map_info = ConfigManager._GetConfigTable(EConfigIndex.t_country_map_info)
        -- for k,v in pairs(gd_country_map_info) do
        for k,v in pairs(_country_map_info) do
            for k1,v1 in pairs(v) do
                if v1.world_id == para2 and v1.b ~= nil then
                    para2Str = v1.b
                    break
                end
            end
        end
    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_vip then
        local vipConfig = ConfigManager.Get(EConfigIndex.t_vip_data, para3)
        para3Str = vipConfig.level ..'-' .. vipConfig.level_star
    end
    if para3Str == nil then
        para3Str = ''
    end   
    if para4Str == nil then
        para4Str = ''
    end  
    return string.format(self:getMarqueeContent(ntype), para1Str, para2Str, para3Str, para4Str) 
end

--[[设置二类二级内容]]
function Marquee:getContentL2_2(ntype, para)
    local para1Str = para[1]
    local areaName = self:GetAreaName(ntype, para)
    if areaName ~= nil then
        para1Str = areaName
    end

    local para2Str = para[2]
    local para3Str = para[3]
    local para4Str = para[4]

    local para3 = tonumber(para[3])
    local para4 = tonumber(para[4])
    local _customKey = nil
    local para5Str = ""

    if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_equipCompound
            or ntype ==  MsgEnum.emarquee_msg_type.eRollMessage_type_hero_star_up 
            or ntype ==  MsgEnum.emarquee_msg_type.eRollMessage_type_hero_rarity
            or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_equipIntensify then  
        -- 道具id
        if ntype ==  MsgEnum.emarquee_msg_type.eRollMessage_type_equipIntensify then
            --装备名称在装备品级表中
            local rarityConfig = ConfigHelper.GetEquipRarity(para3, para4)
            if rarityConfig then
                para3Str = rarityConfig.name
            end    
            --装备星级
            para4Str = para[5] - 1
            para5Str = para[5]
        else
            if PublicFunc.IdToConfig(para3) ~= nil then
                local info = PublicFunc.IdToConfig(para3)               
                if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hero_rarity then
                    --上一品级
                    local lastInfo = PublicFunc.IdToConfig(para3 - 1)
                    para3Str = lastInfo.name
                    --当前品级
                    para4Str = info.name
                    
                elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hero_star_up then
                    para3Str = info.name
                    --英雄星级
                    para4Str = info.rarity - 1
                    para5Str = info.rarity
                end
            end            
        end    
               
    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hurdle then
        if ConfigManager.Get(EConfigIndex.t_hurdle_group,para3) ~= nil then
            local hurdleConfig = ConfigManager.Get(EConfigIndex.t_hurdle_group,para3)
            para3Str = hurdleConfig.chapter_num
            para4Str = hurdleConfig.chapter
        end
    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_baoweizhan then
        -- 活动id
        if ConfigManager.Get(EConfigIndex.t_activity_time,para3) then
            para3Str = ConfigManager.Get(EConfigIndex.t_activity_time,para3).b;
        end
    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_kuikuliya then
        if para3 < 45  then
            _customKey = "_scene1"
        elseif para3 >= 45 and para3 <= 115 then
            _customKey = "_scene2"
        elseif para3 > 115 then
            _customKey = "_scene3"
        end
    end
    if para3Str == nil then
        para3Str = ''
    end
    if para4Str == nil then
        para4Str = ''
    end
    return string.format(self:getMarqueeContent(ntype, _customKey), para1Str, para2Str, para3Str, para4Str, para5Str)     
end

--[[文本内容]]
function Marquee:getMarqueeContent(ntype, _customKey) 
    if self.contentMap == nil then
        self.contentMap = {
            [MsgEnum.emarquee_msg_type.eRollMessage_type_GM] = "GM",
            -- 一类消息
            [MsgEnum.emarquee_msg_type.eRollMessage_type_monthCard] = "monthCard",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_vip] = "vip",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_niudan] = "niudan",
            [MsgEnum.emarquee_msg_type.eRollmessage_type_power_rank] = "power_rank",            
            [MsgEnum.emarquee_msg_type.eRollmessage_type_lucky_cat] = "lucky_cat",

            -- 二类消息1级
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldBoss] = "worldBoss",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_guildBoss] = "guildBoss",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_guildWar] = "guildWar",
            -- 二类消息2级
            [MsgEnum.emarquee_msg_type.eRollMessage_type_hurdle] = "hurdle",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_kuikuliya] = "kuikuliya",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_hero_star_up] = "hero_star_up",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_baoweizhan] = "baoweizhan",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_equipCompound] = "equipCompound",
            --[MsgEnum.emarquee_msg_type.eRollMessage_type_expedition] = "expedition",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_arena] = "arena",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_equipIntensify] = "equipIntensify",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_churchpray] = "churchpray",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemOpenCD] = "world_treasure_box_system_opencd",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemOpened] = "world_treasure_box_system_opened",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxFreeCD] = "world_mysterious_treasure_box_freecd",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxFreed] = "world_mysterious_treasure_box_freed",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureBoxSystemCloseCD] = "world_treasure_box_system_closecd",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_map_boss_kill] = "map_boss_kill",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_go_to_kill_boss] = "go_to_kill_boss",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_hero_rarity] = "hero_rarity_up",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldTreasureMysteriousBoxOpened] = "world_treasure_mysterious_box_opened",
            [MsgEnum.emarquee_msg_type.eRollMessage_type_worldBossKilled] = "worldBossKilled",
        }
    end
    local strKey = self.contentMap[ntype]
    if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_niudan then
        --if PropsEnum.IsRole(id) then
            strKey = strKey .. "_role"
        --elseif PropsEnum.IsEquip(id) then
        --    strKey = strKey .. "_equip"
        --end
    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_kuikuliya then
        strKey = strKey .. _customKey
    end  
    return gs_string_marquee[strKey]
end

function Marquee:GetAreaName(ntype, para)
    do return nil end

    local areaId = nil
    if ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_monthCard
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_vip 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_niudan 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_worldBoss 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_guildBoss 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_guildWar
         
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hurdle 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_kuikuliya         
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hero_star_up         
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_baoweizhan 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_equipCompound
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_expedition

        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_arena 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_equipIntensify 
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_churchpray        
        or ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_hero_rarity 
        or ntype == MsgEnum.emarquee_msg_type.eRollmessage_type_power_rank
        or ntype == MsgEnum.emarquee_msg_type.eRollmessage_type_lucky_cat  then

        areaId = para[1]

    elseif ntype == MsgEnum.emarquee_msg_type.eRollMessage_type_map_boss_kill then
        areaId = para[2]
    
    end
    if areaId == nil then
        return nil
    else
        if tonumber(areaId) == 0 then
            return ""
        else
            local config =  ConfigManager.Get(EConfigIndex.t_country_info, tonumber(areaId))
            if config then
                return config.name .. '·'
            end
        end
        return ""
    end 
end

--[[删除跑马灯]]
function Marquee:deleteMarquee(marqueeId)
    for i = #self.marqueeList[Level.GM_FORCE], 1, -1 do 
        if self.marqueeList[Level.GM_FORCE][i].marqueeId == marqueeId then
            table.remove(self.marqueeList[Level.GM_FORCE], i)
        end
    end
    for i = #self.marqueeList[Level.GM], 1, -1 do 
        if self.marqueeList[Level.GM][i].marqueeId == marqueeId then
            table.remove(self.marqueeList[Level.GM], i)
        end
    end
end

GuildWarStrongholdUI = Class('GuildWarStrongholdUI', UiBaseClass)

function GuildWarStrongholdUI.Start(nodeId)
    if GuildWarStrongholdUI.cls == nil then
        GuildWarStrongholdUI.cls = GuildWarStrongholdUI:new({nodeId = nodeId})
    else
        --撤防更新
        if g_dataCenter.guildWar:IsDefencePhase() then
            GuildWarStrongholdUI.cls:UpateStrongholdUI()
        end
    end
end

function GuildWarStrongholdUI.End()
    if GuildWarStrongholdUI.cls then
        GuildWarStrongholdUI.cls:DestroyUi()
        GuildWarStrongholdUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
    [1] = "该据点最多驻防%s个队伍",
    [2] = "战力 %s",
    [3] = "     集结令",
    [4] = "撤消集结令",
    [5] = "%s占领中......",
    [6] = "已进攻队伍数: %s/%s",
    [7] = "%s天%s小时%s分钟",
    [8] = "(已解散)",
}

function GuildWarStrongholdUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3803_guild_war_details.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarStrongholdUI:InitData(data)    
    self.nodeId = data.nodeId
    self.wrapStrongholdItem = {} 
    self.wrapFightLogItem = {}
    self.dc = g_dataCenter.guildWar
    self.maxDefenceTeamCount = self.dc:GetMaxDefenceTeamCount(self.nodeId)
    self.maxAttackTeamCount = self.dc:GetMaxAttackTeamCount(self.nodeId)
    
    self._AttackStatus = {
        Occupied = 1,       --占领中
        Defence = 2,        --显示防御信息
        CanOccupy = 3,      --可以直接占领
        MaxLimit = 4,       --达进攻上限
        NoTeamOfMy = 5,     --无队伍可进攻
        Attack = 6,         --可进攻
    }
    self.currMassTime = 0
	UiBaseClass.InitData(self, data)    
end

function GuildWarStrongholdUI:Restart()  
    self.needRequestFightLog = true  
    self.dc:ClearFightLog()
    if UiBaseClass.Restart(self, data) then        
	end  
end

function GuildWarStrongholdUI:DestroyUi()
    if self.commonInfo.textGuildIcon then
        self.commonInfo.textGuildIcon:Destroy()
        self.commonInfo.textGuildIcon = nil
    end
    for _,v in pairs(self.wrapStrongholdItem) do
        if v.playerHead then 
            v.playerHead:DestroyUi()
            v.playerHead = nil
        end
    end
    for _,v in pairs(self.wrapStrongholdItem) do
        for _, vv in pairs(v.smallCard) do
            if vv then
                vv:DestroyUi()
                vv = nil
            end
        end
    end
    self.wrapStrongholdItem = {}
	UiBaseClass.DestroyUi(self)    
end

function GuildWarStrongholdUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["on_yeka"] = Utility.bind_callback(self, self.on_yeka)
    self.bindfunc["on_btn_mass_order"] = Utility.bind_callback(self, self.on_btn_mass_order)    

    self.bindfunc["on_init_stronghold_item"] = Utility.bind_callback(self, self.on_init_stronghold_item)  
    self.bindfunc["on_init_fight_log_item"] = Utility.bind_callback(self, self.on_init_fight_log_item)  

    self.bindfunc["on_btn_team_item"] = Utility.bind_callback(self, self.on_btn_team_item)
    self.bindfunc["on_btn_defence_remove"] = Utility.bind_callback(self, self.on_btn_defence_remove)
    self.bindfunc["on_btn_defence_change_person"] = Utility.bind_callback(self, self.on_btn_defence_change_person)
    self.bindfunc["on_btn_attack"] = Utility.bind_callback(self, self.on_btn_attack)

    self.bindfunc["update_mass_order_button"] = Utility.bind_callback(self, self.update_mass_order_button)
    self.bindfunc["update_fight_log"] = Utility.bind_callback(self, self.update_fight_log)
end

function GuildWarStrongholdUI:MsgRegist()
	UiBaseClass.MsgRegist(self)  
    PublicFunc.msg_regist(msg_guild_war.gc_set_node_is_key_result, self.bindfunc['update_mass_order_button'])
    PublicFunc.msg_regist(msg_guild_war.gc_get_node_fight_log, self.bindfunc['update_fight_log'])
end

function GuildWarStrongholdUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_set_node_is_key_result, self.bindfunc['update_mass_order_button'])
    PublicFunc.msg_unregist(msg_guild_war.gc_get_node_fight_log, self.bindfunc['update_fight_log'])
end

function GuildWarStrongholdUI:on_btn_close()
    --清除临时队伍数据
    self.dc:ClearTempMyAttackTeamInfo()
    GuildWarStrongholdUI.End()
end

function GuildWarStrongholdUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_stronghold")

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "btn_close")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])
    --info
    self.commonInfo = {
        spPlace = ngui.find_sprite(self.ui, path .. "cont1/sp_place"),
        lblPlaceName = ngui.find_label(self.ui, path .. "cont1/lbl_place_name"),
        textGuildIcon = ngui.find_texture(self.ui, path .. "cont1/texture_guild_ico"),
        lblGuildName = ngui.find_label(self.ui, path .. "cont1/lbl_occ_guild_name"),
        lblTime = ngui.find_label(self.ui, path .. "cont1/lbl_occed_time")
    }
    self.massOrder = {
        btn =  ngui.find_button(self.ui, path .. "cont1/button_yellow"),
        spBg = ngui.find_sprite(self.ui, path .. "cont1/button_yellow/animation/sprite_background"),
        lbl = ngui.find_label(self.ui, path .. "cont1/button_yellow/animation/lab"),
        spIcon = ngui.find_sprite(self.ui, path .. "cont1/button_yellow/animation/sp_ico"),
    }
    self.massOrder.btn:set_on_click(self.bindfunc["on_btn_mass_order"])

    self.occupyInfo = {
        obj = self.ui:get_child_by_name(path .. "cont3"),
        lbl = ngui.find_label(self.ui, path .. "cont3/lbl_v"),
    }

    --驻防信息
    self.defenceInfo = {
        lblNum = ngui.find_label(self.ui, path .. "toggles1/cont2/lbl_team_count"),
        lblTeamInfo = ngui.find_label(self.ui, path .. "toggles1/cont2/lbl_team_t2"),
    }
    self.scrollViewStronghold = ngui.find_scroll_view(self.ui, path .. "toggles1/scrollview")
    self.wrapContentStronghold = ngui.find_wrap_content(self.ui, path .. "toggles1/scrollview/wrapcontent")
    self.wrapContentStronghold:set_on_initialize_item(self.bindfunc["on_init_stronghold_item"])

    self.scrollViewFightLog = ngui.find_scroll_view(self.ui, path .. "toggles2/scro_view/panel")
    self.wrapListFightLog = ngui.find_wrap_list(self.ui, path .. "toggles2/scro_view/panel/wrap_cont")
    self.wrapListFightLog:set_on_initialize_item(self.bindfunc["on_init_fight_log_item"])

    --tab
    self.toggle = {}
    for i = 1,2 do
        self.toggle[i] = ngui.find_toggle(self.ui, path .. "cont_toggles/toggle" .. i)
        self.toggle[i]:set_on_change(self.bindfunc["on_yeka"])
    end  
    local spToggle1 = ngui.find_sprite(self.ui, path .. "cont_toggles/toggle1/sp1")
    local spLock1 = ngui.find_sprite(self.ui, path .. "cont_toggles/toggle1/sp_lock")

    spLock1:set_active(false)
    if self.dc:IsNormalPhase() then
        spLock1:set_active(true)
        PublicFunc.SetUISpriteGray(spToggle1)
        --不能查看据点信息
        self.toggle[2]:set_value(true)
        self.toggle[1]:set_enable(false)
    else
        
        self.toggle[1]:set_enable(true)
        self.toggle[1]:set_value(true)
    end
    self.dc:ShowEmbattleUI()  
end

function GuildWarStrongholdUI:UpateStrongholdUI()
    if self.dc:IsAttackPhase() then
        self.attackStatus = self:GetAttackStatus()
    end    
    self:UpdateStrongholdInfo()
    self:UpdateTeamInfo()
end

function GuildWarStrongholdUI:on_yeka(value, name)
    if value then
        --占领中
        self.occupyInfo.obj:set_active(false)  
        if name == "toggle1" then  
            self:UpateStrongholdUI()
        else
            self:UpdateStrongholdInfo()
            self:update_fight_log()

            if self.needRequestFightLog == true then
                self.needRequestFightLog = false
                msg_guild_war.cg_get_node_fight_log(self.nodeId)
            end            
        end   
    end
end

local _interDefault = 0.6
--[[集结令]]
function GuildWarStrongholdUI:on_btn_mass_order(t)
    local appTime = app.get_time()
    if appTime - self.currMassTime <= _interDefault then
        return
    end
    self.currMassTime = appTime
    local isKey = self.dc:GetMassOrder(self.nodeId)
    if isKey == 0 then
        isKey = 1
    else
        isKey = 0
    end
    msg_guild_war.cg_set_node_is_key(self.nodeId, isKey)
end

--[[更新据点信息]]
function GuildWarStrongholdUI:UpdateStrongholdInfo()
    self.commonInfo.spPlace:set_sprite_name(self.dc:GetNodeSpriteName(self.nodeId))
    self.commonInfo.lblPlaceName:set_text(self.dc:GetStrongholdName(self.nodeId))

    local info = self.dc:GetGuildInfo(self.nodeId) 
    local name = _UIText[8]
    if info and info.guildName and info.guildName ~= "" then
        name = info.guildName
        local config = ConfigManager.Get(EConfigIndex.t_guild_icon, info.iconIndex)
        self.commonInfo.textGuildIcon:set_texture(config.icon)
    end
    self.commonInfo.lblGuildName:set_text(name)

    local timeSec = self.dc:GetOccupyStartTime(self.nodeId)
    local timeStr = ""
    local diffSec = system.time() - timeSec
   
    if diffSec > 0 then
        local day, hour, min, sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        timeStr = string.format(_UIText[7], day, hour, min)
    end
    self.commonInfo.lblTime:set_text(timeStr)

    self:update_mass_order_button()

    local _count = self.dc:GetTeamCount(self.nodeId)
    --队伍信息
    self.defenceInfo.lblTeamInfo:set_active(false)
    
    if self.dc:IsDefenceOrIntervalPhase() then
        self.defenceInfo.lblNum:set_text(_count .. "/" .. self.maxDefenceTeamCount)

        self.defenceInfo.lblTeamInfo:set_active(true)
        self.defenceInfo.lblTeamInfo:set_text(string.format(_UIText[1], self.maxDefenceTeamCount))
    else
        --当前存活的驻防数
        local alivedCount = _count - self.dc:GetTeamAllDeadCount(self.nodeId)
        self.defenceInfo.lblNum:set_text(alivedCount .. "/" .. _count)

        if not self.dc:IsMyNode(self.nodeId) then
            self.defenceInfo.lblTeamInfo:set_active(true)
             --进攻数量
            local attackCount = self.dc:GetAttackTeamCount(self.nodeId)
            self.defenceInfo.lblTeamInfo:set_text(string.format(_UIText[6], attackCount, self.maxAttackTeamCount))
        end
    end
end

--[[更新驻防队伍]]
function GuildWarStrongholdUI:UpdateTeamInfo()
    local _count = self.dc:GetTeamCount(self.nodeId)
    self.scrollViewStronghold:set_active(true)

    if self.dc:IsDefenceOrIntervalPhase() then        
        self.canAddTeam = false
        --可驻扎(驻防未到上限 / 自己队伍未达3支)
        if self.dc:IsDefencePhase() then
            if  _count < self.maxDefenceTeamCount and self.dc:GetMyTeamInfoCount() < 3 then
                _count = _count + 1
                self.canAddTeam = true        
            end
        end
        self.scrollViewStronghold:reset_position() 
        self.wrapContentStronghold:set_min_index(-_count + 1)
        self.wrapContentStronghold:set_max_index(0)
        self.wrapContentStronghold:reset()
    elseif self.dc:IsAttackPhase() then       
        if self.attackStatus == self._AttackStatus.Occupied then
            self.scrollViewStronghold:set_active(false)
            self.occupyInfo.obj:set_active(true)
            local info = self.dc:GetNodeSummary(self.nodeId)
            self.occupyInfo.lbl:set_text(string.format(_UIText[5], info.occupyGuildName))
        else
            self.canOccupy = false
            if self.attackStatus == self._AttackStatus.CanOccupy then
                 _count = _count + 1
                self.canOccupy = true 
            end
            self.scrollViewStronghold:reset_position() 
            self.wrapContentStronghold:set_min_index(-_count + 1)
            self.wrapContentStronghold:set_max_index(0)
            self.wrapContentStronghold:reset()
        end
    end    
end

--[[更新争夺记录]]
function GuildWarStrongholdUI:update_fight_log()
    local count = self.dc:GetFightLogCnt()
    --app.log('update_fight_log === > ' .. count)
    self.wrapListFightLog:set_min_index(0)
    self.wrapListFightLog:set_max_index(count - 1)
    self.wrapListFightLog:reset()
    --self.scrollViewFightLog:reset_position() 
end

function GuildWarStrongholdUI:on_init_fight_log_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1 

    if self.wrapFightLogItem[row] == nil then
        local item = {}
        item.lblTitle = ngui.find_label(obj, "sp_title/lab_time")   
        item.lblContent = ngui.find_label(obj, "lab_word")        

        self.wrapFightLogItem[row] = item
    end

    local item = self.wrapFightLogItem[row]
    local data = self.dc:GetFightLogByIndex(index)
    if data == nil then
        return
    end
    item.lblTitle:set_text(data.title)
    item.lblContent:set_text(data.content) 
end

function GuildWarStrongholdUI:update_mass_order_button()
    local isActive = false
    --仅对社长显示
    if g_dataCenter.guild:IsPresident() then
        isActive = true
    end    
    --非占领状态
    if self.dc:IsAttackPhase() then
        if self.attackStatus == self._AttackStatus.Occupied 
            or self.attackStatus == self._AttackStatus.Defence 
            or self.attackStatus == self._AttackStatus.MaxLimit then
            isActive = false             
        end
    elseif self.dc:IsIntervalPhase() or self.dc:IsNormalPhase() then
        isActive = false
    end

    self.massOrder.btn:set_active(isActive)
    if not isActive then
        return
    end
    if self.dc:IsDefenceOrIntervalPhase() then
        self.massOrder.spBg:set_sprite_name("stz_anniu_lvse")
        self.massOrder.spIcon:set_sprite_name("stz_jijieling_fangshou")        
    elseif self.dc:IsAttackPhase() then
        self.massOrder.spBg:set_sprite_name("stz_anniu_chengse")
        self.massOrder.spIcon:set_sprite_name("stz_jijieling_jingong")
    end    
    local data = self.dc:GetNodeSummary(self.nodeId)   
    --设置
    if data.isKey == 0 then
        self.massOrder.spIcon:set_active(true)    
        self.massOrder.lbl:set_text(_UIText[3])            
    --撤消
    else
        self.massOrder.spIcon:set_active(false)
        self.massOrder.lbl:set_text(_UIText[4])
    end
end


--[[进攻状态]]
function GuildWarStrongholdUI:GetAttackStatus() 
    if self.dc:IsOccupy(self.nodeId) then
        return self._AttackStatus.Occupied
    else
        if self.dc:IsMyNode(self.nodeId) then
            return self._AttackStatus.Defence
        --攻击
        else
            --无防守队伍            
            if self.dc:GetTeamCount(self.nodeId) == 0 then
                return self._AttackStatus.CanOccupy
            --达进攻上限
            elseif self.dc:GetAttackTeamCount(self.nodeId) == self.maxAttackTeamCount then
                return self._AttackStatus.MaxLimit            
            --自己无队伍
            elseif self.dc:GetMyTeamInfoCount() == 3 then
                --未进攻
                if not self.dc:IsAttackedStronghold(self.nodeId) then
                    return self._AttackStatus.NoTeamOfMy
                end
            end
            return self._AttackStatus.Attack
        end
    end    
end
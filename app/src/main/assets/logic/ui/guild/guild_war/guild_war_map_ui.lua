
GuildWarMapUI = Class('GuildWarMapUI', UiBaseClass)


local _UIText = {
    [1] = "驻守:[00ff00]%s/%s[-]",
    [2] = "驻守:%s/%s",    
    [3] = "占领中......",  
    [4] = "失守",  
    [5] = "剩余%s队",  
    [6] = "布防剩余", 
    [7] = "进攻剩余", 
    [8] = "未匹配到合适的对手", 
}

local _GuildWarMapStatus = {
    Big = 1,          --放大版
    Small = 2,        --缩小版
}

function GuildWarMapUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3801_guild_war.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarMapUI:InitData(data)    
	UiBaseClass.InitData(self, data)  
    self.dc  = g_dataCenter.guildWar
end

function GuildWarMapUI:Restart()
    self.mapStatus = _GuildWarMapStatus.Small 
    self.isFirstEntry = true  
    --加载设置  
    self:LoadSetting()
    
    self.startRefreshTime = nil
    self.onlyUpdateNodes = nil

    msg_guild_war.cg_get_buy_buff_times()
    if UiBaseClass.Restart(self, data) then        
	end  
end

function GuildWarMapUI:DestroyUi()
    self:StopTimer()
    GuildWarMyTeamUI.End()
    GuildWarTipUI.End()
    self:CloseAllPopup()
	UiBaseClass.DestroyUi(self)    
end

function GuildWarMapUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_map_status_change"] = Utility.bind_callback(self, self.on_map_status_change)
    self.bindfunc["on_click_node"] = Utility.bind_callback(self, self.on_click_node)    
    self.bindfunc["on_show_member_progress"] = Utility.bind_callback(self, self.on_show_member_progress) 
    self.bindfunc["on_show_leaderboard"] = Utility.bind_callback(self, self.on_show_leaderboard) 
    self.bindfunc["on_show_award"] = Utility.bind_callback(self, self.on_show_award) 
    self.bindfunc["on_show_buff"] = Utility.bind_callback(self, self.on_show_buff) 
    self.bindfunc["on_update"] = Utility.bind_callback(self, self.on_update)     

    self.bindfunc["gc_set_node_is_key_result"] = Utility.bind_callback(self, self.gc_set_node_is_key_result)  
    self.bindfunc["update_ui"] = Utility.bind_callback(self, self.update_ui) 
    self.bindfunc["gc_get_my_team_ret"] = Utility.bind_callback(self, self.gc_get_my_team_ret) 
    self.bindfunc["gc_direct_occupy"] = Utility.bind_callback(self, self.gc_direct_occupy) 
    
    --据点信息返回
    self.bindfunc["get_teams_ret"] = Utility.bind_callback(self, self.get_teams_ret)

    --保存阵容后通知   
    self.bindfunc["on_close_common_formation_ui"] = Utility.bind_callback(self, self.on_close_common_formation_ui)

    --点击队伍放大显示到相应接点
    self.bindfunc["show_node_positioin_zoom_in"] = Utility.bind_callback(self, self.show_node_positioin_zoom_in)

    --选择队伍取消/占领失败
    self.bindfunc["on_open_stronghold_ui"] = Utility.bind_callback(self, self.on_open_stronghold_ui) 

    self.bindfunc["on_handle_phase_tip"] = Utility.bind_callback(self, self.on_handle_phase_tip) 
    --赛季
    self.bindfunc["on_open_season_ui"] = Utility.bind_callback(self, self.on_open_season_ui)
end

function GuildWarMapUI:MsgRegist()
	UiBaseClass.MsgRegist(self)    
    PublicFunc.msg_regist(msg_guild_war.gc_get_guard_info_ret, self.bindfunc['update_ui']) 
    PublicFunc.msg_regist(msg_guild_war.gc_get_attack_info_ret, self.bindfunc['update_ui']) 

    PublicFunc.msg_regist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret'])
    PublicFunc.msg_regist(msg_guild_war.gc_set_node_is_key_result, self.bindfunc['gc_set_node_is_key_result'])
    PublicFunc.msg_regist(msg_guild_war.gc_direct_occupy, self.bindfunc['gc_direct_occupy'])
     
    --据点驻防信息返回
    PublicFunc.msg_regist(msg_guild_war.gc_get_guard_teams_ret, self.bindfunc['get_teams_ret'])
    PublicFunc.msg_regist(msg_guild_war.gc_get_attack_guard_teams_ret, self.bindfunc['get_teams_ret'])

    PublicFunc.msg_regist("guild_war_close_common_formation_ui", self.bindfunc['on_close_common_formation_ui'])
  
    --点击队伍放大显示到相应接点
    PublicFunc.msg_regist("guild_war_show_node_positioin_zoom_in", self.bindfunc['show_node_positioin_zoom_in']) 

    --选择队伍取消/直接占领失败
    PublicFunc.msg_regist("guild_war_on_open_stronghold_ui", self.bindfunc['on_open_stronghold_ui'])
    --提示
    PublicFunc.msg_regist("guild_war_on_handle_phase_tip", self.bindfunc['on_handle_phase_tip'])
    --赛季
    PublicFunc.msg_regist(msg_guild_war.gc_get_season_info_ret, self.bindfunc['on_open_season_ui'])
end

function GuildWarMapUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_get_guard_info_ret, self.bindfunc['update_ui'])
    PublicFunc.msg_unregist(msg_guild_war.gc_get_attack_info_ret, self.bindfunc['update_ui']) 

    PublicFunc.msg_unregist(msg_guild_war.gc_get_my_team_ret, self.bindfunc['gc_get_my_team_ret']) 
    PublicFunc.msg_unregist(msg_guild_war.gc_set_node_is_key_result, self.bindfunc['gc_set_node_is_key_result'])
    PublicFunc.msg_unregist(msg_guild_war.gc_direct_occupy, self.bindfunc['gc_direct_occupy'])    

    --据点驻防信息返回
    PublicFunc.msg_unregist(msg_guild_war.gc_get_guard_teams_ret, self.bindfunc['get_teams_ret'])
    PublicFunc.msg_unregist(msg_guild_war.gc_get_attack_guard_teams_ret, self.bindfunc['get_teams_ret'])    
     
    PublicFunc.msg_unregist("guild_war_close_common_formation_ui", self.bindfunc['on_close_common_formation_ui'])

    --点击队伍放大显示到相应接点
    PublicFunc.msg_unregist("guild_war_show_node_positioin_zoom_in", self.bindfunc['show_node_positioin_zoom_in'])

    --选择队伍取消/直接占领失败
    PublicFunc.msg_unregist("guild_war_on_open_stronghold_ui", self.bindfunc['on_open_stronghold_ui'])
    --提示
    PublicFunc.msg_unregist("guild_war_on_handle_phase_tip", self.bindfunc['on_handle_phase_tip'])
    --赛季
    PublicFunc.msg_unregist(msg_guild_war.gc_get_season_info_ret, self.bindfunc['on_open_season_ui'])
end

function GuildWarMapUI:btn_close()
    self:Hide()
end

function GuildWarMapUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_map")
    
    self.objTopOther = self.ui:get_child_by_name("top_other")
    self.lblPhaseContent = ngui.find_label(self.ui, "top_other/animation/panel/lab")
    
    local aniPath = "centre_other/animation/"  
    self.objMapSmall = self.ui:get_child_by_name(aniPath .. "panel_map_xiao")
    self.objMapBig = self.ui:get_child_by_name(aniPath .. "panel_map_big")
    self.scrollView = ngui.find_scroll_view(self.ui, aniPath .. "panel_map_big") 
    self.scrollViewSmall = ngui.find_scroll_view(self.ui, aniPath .. "scroll_view_map/panel_map_xiao")
        
    local _mapInfo = {
        {
            status = _GuildWarMapStatus.Small,
            path = aniPath .. "panel_map_xiao/content/", 
            objClone = nil,
        },
        {
            status = _GuildWarMapStatus.Big,
            path = aniPath .. "panel_map_big/content/", 
            objClone = nil,
        }
    }  
    self.uiMap = {}      
    for _, v in pairs(_mapInfo) do    
        self.uiMap[v.status] = {}
        for i = 1, 36 do 
            local temp = {}
            --地图块
            temp.spBlock = ngui.find_sprite(self.ui, v.path .. "cont/" .. i)
            --其它信息
            local tempCont = {}
            if v.objClone == nil then
                v.objClone = self.ui:get_child_by_name(v.path .. "content_btn/cont")
                v.objClone:set_active(false) 
            end
            local objParent = self.ui:get_child_by_name(v.path .. "content_btn/btn" .. i .."/animation")
            tempCont.obj = v.objClone:clone()            
            tempCont.obj:set_parent(objParent)  
            tempCont.obj:set_local_position(0, 0, 0)
            tempCont.obj:set_name("cont")

            tempCont.lblOccupy = ngui.find_label(tempCont.obj, "lab")
            local tempTeam = {}
            for j = 1, 3 do
                tempTeam[j] = {}
                tempTeam[j].sp = ngui.find_sprite(tempCont.obj, "content/sp_qi" .. j)
                tempTeam[j].lbl = ngui.find_label(tempCont.obj, "content/sp_qi" .. j .. "/lab")
            end   
            tempCont.team = tempTeam   
            tempCont.lblTeamInfo = ngui.find_label(tempCont.obj, "content/lab")
            tempCont.spIsKey = ngui.find_sprite(tempCont.obj, "content/sp")
            tempCont.spIsKeyIcon = ngui.find_sprite(tempCont.obj, "content/sp/sp_xx")

            --选中的特效
            if v.status == _GuildWarMapStatus.Big then
                tempCont.objChooseEffect = tempCont.obj:get_child_by_name("cont/content/fx_ui_3801_guild_war")
                tempCont.objChooseEffect:set_active(false)
            end
                   
            temp.cont = tempCont
            --按钮
            temp.btnNode = ngui.find_button(self.ui, v.path .. "content_btn/btn" .. i)
            temp.btnNode:reset_on_click()
            temp.btnNode:set_event_value("", i)
            temp.btnNode:set_on_click(self.bindfunc["on_click_node"])

            temp.spNode = ngui.find_sprite(self.ui, v.path .. "content_btn/btn" .. i .."/animation/sprite_background")  
            --animation
            temp.animation = objParent          

            self.uiMap[v.status][i] = temp
        end
    end

    local downPath = "down_other/animation/panel_btn/"  
    self.spShowMap = ngui.find_sprite(self.ui,  downPath .. "btn1/animation/sprite_background")
    --地图改变
    local btnShowMap = ngui.find_button(self.ui,  downPath .. "btn1")
    btnShowMap:set_on_click(self.bindfunc["on_map_status_change"])    
    --成员进度
    local btnMemberProgress = ngui.find_button(self.ui,  downPath .. "btn_jindu")
    btnMemberProgress:set_on_click(self.bindfunc["on_show_member_progress"])
    --排行榜
    local btnLeaderboard = ngui.find_button(self.ui,  downPath .. "btn_rank")
    btnLeaderboard:set_on_click(self.bindfunc["on_show_leaderboard"])
    --奖励
    local btnAward = ngui.find_button(self.ui,  downPath .. "btn_award")
    btnAward:set_on_click(self.bindfunc["on_show_award"])
    --buff加成
    local btnBuff = ngui.find_button(self.ui,  downPath .. "sp_down_di/cont/btn_154x62")
    btnBuff:set_on_click(self.bindfunc["on_show_buff"])

    self.lblBuffInfo = ngui.find_label(self.ui, downPath .. "sp_down_di/cont/lab")

    self.downCont1 = self.ui:get_child_by_name(downPath .. "sp_down_di/cont")
    self.downCont2 = self.ui:get_child_by_name(downPath .. "sp_down_di/lab")
    self.downCont1:set_active(false)
    self.downCont2:set_active(false)

    --更新阶段/时间
    --提示/赛季ui
    self:StartTimer()
    
    --    
    self:update_ui()

    --战斗结束，打开相应据点
    self:OpenStrongholdUI()    

    --我的队伍
    GuildWarMyTeamUI.Start()

    self.dc:ClearHistoryData()
end

function GuildWarMapUI:OpenStrongholdUI()
    if self.dc:IsAttackPhase() then
        local info = self.dc:GetFightInfo()
        if info and info.attackNodeId then
            self:RequestStrongholdData(info.attackNodeId)            
        end
    end
end

function GuildWarMapUI:on_map_status_change(t)
    if self.mapStatus == _GuildWarMapStatus.Big then 
        self.mapStatus = _GuildWarMapStatus.Small
    else
        self.mapStatus = _GuildWarMapStatus.Big
    end
    self:update_ui()
end

local _AmountSmall = {x = 0, y = (35 - (-106)) / 240}

function GuildWarMapUI:SetMapStatus()
    if self.mapStatus == _GuildWarMapStatus.Big then
        self.objMapSmall:set_active(false)
        self.objMapBig:set_active(true) 
        self.spShowMap:set_sprite_name("stz_ditu_suoxiao")
        --显示当前社团位置
        if self.isFirstEntry then
            local _nodeId = self.dc:GetMyGuildNodeId()
            if _nodeId then
                self.isFirstEntry = false
                local pos = self:GetNodeDragAmount(_nodeId)
                self.scrollView:set_drag_amount(pos.x, pos.y, 0)
            end
        end
    else
        self.objMapSmall:set_active(true)
        self.objMapBig:set_active(false)
        self.scrollViewSmall:set_drag_amount(_AmountSmall.x, _AmountSmall.y, 0)

        self.spShowMap:set_sprite_name("stz_ditu_fangda")
    end
end

function GuildWarMapUI:Update(dt)
    UiBaseClass.Update(self,dt);
    GuildWarBuffUI.Update(dt)
end

function GuildWarMapUI:update_ui(isMatch)
    self:UpdateEncourage();
    if self.onlyUpdateNodes == true then
        self.onlyUpdateNodes = nil
        self:UpdateAllNodeInfo()
    else
        self:SetMapStatus()
        self:ShowMatchInfo(isMatch)
        self:UpdateAllNodeInfo()
    end
end

function GuildWarMapUI:ShowMatchInfo(isMatch)
    self.downCont1:set_active(false)
    self.downCont2:set_active(false)

    if isMatch ~= nil and isMatch == false then  
        GuildWarTipUI.Start({
            isShowMask = true,
            str = _UIText[8],
            closeTime = -1,
        })
        self.downCont2:set_active(true)
        --右上角时间
        self.objTopOther:set_active(false)
        self:StopTimer()
    else
        self.downCont1:set_active(true)
    end
    if isMatch then
        self:ShowTipAfterRequestData()
    end
end

function GuildWarMapUI:on_click_node(t)
    if self.dc:IsBaseCamp(t.float_value) then
        return
    end
    self.clickNodeId = t.float_value
    if self.dc:IsDefenceOrIntervalPhase() then
        if self.dc:IsMyNode(self.clickNodeId) then
            self:ShowStrongholdUI()
        end
    elseif self.dc:IsAttackPhase() then
        local canOper = false
        if self.dc:IsMyNode(self.clickNodeId) then
            canOper = true
        else
            --攻击接壤的据点
            if self.dc:IsBorderOn(self.clickNodeId) then
                canOper = true
            end
        end
        if canOper then
            self:ShowStrongholdUI()
        end
    else
         self:ShowStrongholdUI()
    end
end

function GuildWarMapUI:ShowStrongholdUI()
    if self.clickNodeId == nil then
        app.log('clickNodeId is nil')
        return
    end
    self:RequestStrongholdData(self.clickNodeId)
end

function GuildWarMapUI:RequestStrongholdData(nodeId)
    if nodeId == nil then
        app.log('nodeId is nil')
        return
    end
    if self.dc:IsDefenceOrIntervalPhase() then
        msg_guild_war.cg_get_guard_teams(nodeId)
    else
        msg_guild_war.cg_get_attack_guard_teams(nodeId)
    end 
end 

function GuildWarMapUI:UpdateAllNodeInfo()
    for nodeId, item in ipairs(self.uiMap[self.mapStatus]) do
        local summaryData = self.dc:GetNodeSummary(nodeId)
        if summaryData then
            item.btnNode:set_active(true)
            --设置地图建筑
            local name = self.dc:GetNodeSpriteName(nodeId)
            item.spNode:set_sprite_name(name)

            --设置区块颜色
            local color = self.dc:GetNodeBlockColor(nodeId)
            PublicFunc.SetUiSpriteColor(item.spBlock, color.r, color.g, color.b, 1)

            --设置高亮动画
            local isLight = self.dc:ShouldHighLight(nodeId)
            if isLight then
                item.animation:animated_stop("fx_ui_3801_guild_war_tishi_2")

                item.animation:set_animated_loop("fx_ui_3801_guild_war_tishi", true)
                item.animation:animated_play("fx_ui_3801_guild_war_tishi")                
            else
                item.animation:set_animated_loop("fx_ui_3801_guild_war_tishi", false)
                item.animation:animated_stop("fx_ui_3801_guild_war_tishi")

                item.animation:animated_play("fx_ui_3801_guild_war_tishi_2")                
            end

            item.cont.obj:set_active(false)
            if item.cont.objChooseEffect then
                item.cont.objChooseEffect:set_active(false)
            end
            --更新社团名
            if self.dc:IsBaseCamp(nodeId) then
                item.cont.obj:set_active(true)
                self:UpdateBaseCampName(nodeId, item.cont) 
            else
                if self.dc:IsDefenceOrIntervalPhase() then
                    --驻守信息
                    if self.dc:IsMyNode(nodeId) then
                        item.cont.obj:set_active(true)
                        self:UpdateSingleNodeInfo(nodeId, item.cont)
                    end
                elseif self.dc:IsAttackPhase() then
                    item.cont.obj:set_active(true)
                    --显示接壤
                    local borderOn = self.dc:IsBorderOn(nodeId)
                    if borderOn then                        
                        self:UpdateSingleNodeInfo(nodeId, item.cont) 
                    end
                    --其他只显示占领状态
                    if not borderOn then
                        self:UpdateSingleNodeInfo(nodeId, item.cont, true) 
                    end
                end
            end
        else
            item.btnNode:set_active(false)
        end
    end
end

function GuildWarMapUI:UpdateBaseCampName(nodeId, cont)
    cont.lblOccupy:set_active(false)
    --队伍
    for k, v in pairs(cont.team) do 
        v.sp:set_active(false)
    end
    --社团名
    cont.lblTeamInfo:set_active(true) 
    cont.lblTeamInfo:set_text(self.dc:GetStrongholdName(nodeId))
    cont.spIsKey:set_active(false)
end

function GuildWarMapUI:UpdateSingleNodeInfo(nodeId, cont, isHide)
    self:UpdateOccupyInfo(nodeId, cont) 
    self:UpdateMyTeamFlag(nodeId, cont, isHide)    
    self:UpdateTeamCnt(nodeId, cont, isHide)    
    self:UpdateMassOrder(nodeId, cont, isHide)
end

--[[占领中]]
function GuildWarMapUI:UpdateOccupyInfo(nodeId, cont)
    if self.dc:IsDefenceOrIntervalPhase() then
        cont.lblOccupy:set_active(false)
    elseif self.dc:IsAttackPhase() then
        if self.dc:IsOccupy(nodeId) then
            cont.lblOccupy:set_active(true)
            --占领的社团颜色 
            local color = self.dc:GetOccupyGuildColor(nodeId)
            if color then
                cont.lblOccupy:set_effect_color(color.r, color.g, color.b, 1)
            end
            --失守
            if self.dc:IsMyNode(nodeId) then
                cont.lblOccupy:set_text(_UIText[4])
            --占领中
            else
                cont.lblOccupy:set_text(_UIText[3])
            end
            --不显示队伍数
            cont.lblTeamInfo:set_active(false)
        else
            cont.lblOccupy:set_active(false)
        end
    else
        cont.lblOccupy:set_active(false)
    end
end

--[[驻守xx/xx <--> 剩余xx队]]
function GuildWarMapUI:UpdateTeamCnt(nodeId, cont, isHide) 
    if isHide == true then
        cont.lblTeamInfo:set_active(false)
        return
    end 
    local data = self.dc:GetNodeSummary(nodeId)
    cont.lblTeamInfo:set_active(false)
    if self.dc:IsDefenceOrIntervalPhase() then
        local maxCount = self.dc:GetMaxDefenceTeamCount(nodeId)
        local _txt = nil
        --驻防已满或者为0时
        if data.teamNum == 0 or data.teamNum == maxCount then
            _txt = _UIText[1]
        else
            _txt = _UIText[2]
        end
        cont.lblTeamInfo:set_active(true)
        cont.lblTeamInfo:set_text(string.format(_txt, data.teamNum, maxCount))
        --cont.lblTeamInfo:set_text(tostring(nodeId))
    elseif self.dc:IsAttackPhase() then
        if not self.dc:IsOccupy(nodeId) then
            cont.lblTeamInfo:set_active(true)
            cont.lblTeamInfo:set_text(string.format(_UIText[5], data.teamNum))
        end
    end
end

--[[旗帜]]
function GuildWarMapUI:UpdateMyTeamFlag(nodeId, cont, isHide)
    if isHide == true then
        for k, v in pairs(cont.team) do 
            v.sp:set_active(false)
        end
        return
    end
    if self.dc:IsDefenceOrIntervalPhase() then
        local numbers = {}
        local _data = self.dc:GetMyTeamNumber()
        if _data[nodeId] ~= nil then
            numbers = _data[nodeId]
        end
        local cnt = #numbers
        --队伍
        if cnt == 0 then
            for k, v in pairs(cont.team) do 
                v.sp:set_active(false)
            end
        else
            for i = 1, 3 do
                local isShow = (i <= cnt)
                cont.team[i].sp:set_active(isShow)
                if isShow then
                    cont.team[i].lbl:set_text(tostring(numbers[i]))
                end
            end
        end
    else
        for k, v in pairs(cont.team) do 
            v.sp:set_active(false)
        end
    end      
end

--[[驻防令 <--> 进攻令]]
function GuildWarMapUI:UpdateMassOrder(nodeId, cont, isHide)
    if isHide == true then
        cont.spIsKeyIcon:set_active(false)
        return
    end
    local data = self.dc:GetNodeSummary(nodeId)
    if self.dc:IsDefenceOrIntervalPhase() then
        cont.spIsKeyIcon:set_sprite_name("stz_jijieling_fangshou")   
        cont.spIsKey:set_active(data.isKey == 1)
    elseif self.dc:IsAttackPhase() then
        cont.spIsKeyIcon:set_sprite_name("stz_jijieling_jingong")   
        cont.spIsKey:set_active(data.isKey == 1)
    else
        cont.spIsKeyIcon:set_active(false)
    end
end

--[[更新鼓励信息]]
function GuildWarMapUI:UpdateEncourage()
    local _BuffTimes = g_dataCenter.guildWar:GetBuffLv()[1];
    local cfg = ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1);
    local buffInfo = 
    {
        {value=cfg.crit_value*_BuffTimes[1], attrName="暴击+"},
        {value=cfg.attack_value*_BuffTimes[2], attrName="攻击+"},
        {value=cfg.defense_value*_BuffTimes[3], attrName="防御+"},
    }
    local str = "";
    for i=1,#buffInfo do
        local info = buffInfo[i];
        if info.value ~= 0 then
            str = str..info.attrName..info.value.." ";
        end
    end
    self.lblBuffInfo:set_text(str);
end


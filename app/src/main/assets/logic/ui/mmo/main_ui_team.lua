
MainUITeam = Class('MainUITeam', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/right_centre_other.assetbundle"

function MainUITeam.GetResList()
    return {res}
end

function MainUITeam:Init(data)
    self.pathRes = res
    self.role_id_head = {}
    self.dataCache = data.dataCache
    if self.dataCache.relive_list == nil then
        self.dataCache.relive_list = {}
    end
    self.relive_list = self.dataCache.relive_list

	UiBaseClass.Init(self, data);
end

function MainUITeam:Restart(data)
    UiBaseClass.Restart(self, data)

    self:ResetData()
end

function MainUITeam:ResetData()
    self.isOpen = true
    self.teamHeroProChanged = false
    self.isReborning = false
end

function MainUITeam:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnClickOpenAndClose'] = Utility.bind_callback(self, self.OnClickOpenAndClose);
    self.bindfunc['OnClickHead'] = Utility.bind_callback(self, self.OnClickHead)
    self.bindfunc['OnReboenProgressEnd'] = Utility.bind_callback(self, self.OnReboenProgressEnd)
    self.bindfunc['AbortReborn'] = Utility.bind_callback(self, self.AbortReborn)
    self.bindfunc['BeginMMORelive'] = Utility.bind_callback(self, self.BeginMMORelive)
    self.bindfunc['HeroLevelUp'] = Utility.bind_callback(self, self.HeroLevelUp)
    self.bindfunc['OnReliveFollowHero'] = Utility.bind_callback(self, self.OnReliveFollowHero)
end

--注册消息分发回调函数
function MainUITeam:MsgRegist()
    PublicFunc.msg_regist('HeroLevelUp', self.bindfunc['HeroLevelUp'])
    PublicFunc.msg_regist(world_msg.gc_begin_mmo_relive, self.bindfunc['BeginMMORelive'])
    PublicFunc.msg_regist(msg_fight.gc_relive_follow_hero_state, self.bindfunc['OnReliveFollowHero'])
end

--注销消息分发回调函数
function MainUITeam:MsgUnRegist()
    PublicFunc.msg_unregist('HeroLevelUp', self.bindfunc['HeroLevelUp'])
    PublicFunc.msg_unregist(world_msg.gc_begin_mmo_relive, self.bindfunc['BeginMMORelive'])
    PublicFunc.msg_unregist(msg_fight.gc_relive_follow_hero_state, self.bindfunc['OnReliveFollowHero'])
end

function MainUITeam:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    
    
    local btn = ngui.find_button(self.ui, 'content/sp_di')
    btn:set_on_click(self.bindfunc['OnClickOpenAndClose'])

    self.captainRoleInfo = {}
    self.captainRoleInfo.proHp = ngui.find_progress_bar(self.ui, "btn3/pro_xuetiao");
    self.captainRoleInfo.labHp = ngui.find_label(self.ui, "btn3/lab_num");
    self.captainRoleInfo.spHuman = ngui.find_sprite(self.ui, "btn3/texture_human");
    self.captainRoleInfo.spMark = ngui.find_sprite(self.ui, "btn3/people_zhezhao");
    self.captainRoleInfo.spMark:set_active(false)
    self.captainRoleInfo.levelUpFx = self.ui:get_child_by_name('btn3/fx');
    self.captainRoleInfo.levelUpFx:set_active(false)

    self.teamMemberRoleInfo = {}
    for i=1,2 do
        self.teamMemberRoleInfo[i + 1] = {}
        local roleInfo = self.teamMemberRoleInfo[i + 1]

        roleInfo.node = self.ui:get_child_by_name('cont' .. i);
        roleInfo.proHp = ngui.find_progress_bar(roleInfo.node, "sp_2");
        roleInfo.labTime = ngui.find_label(roleInfo.node, "lab");
        roleInfo.labTime:set_text('')
        roleInfo.spHuman = ngui.find_sprite(roleInfo.node, "texture_human");
        roleInfo.spMark = ngui.find_sprite(roleInfo.node, "people_zhezhao");
        roleInfo.spMark:set_active(false)
        roleInfo.levelUpFx = roleInfo.node:get_child_by_name('fx')
        roleInfo.levelUpFx:set_active(false)

        local btn = ngui.find_button(roleInfo.node, 'sp_di')
        btn:set_on_click(self.bindfunc['OnClickHead'])
    end
    
    self.clickCloseTab = self.ui:get_child_by_name('table')
    self.followTabPage = self.ui:get_child_by_name('panel_list')
    
    self.tweenPosition = ngui.find_tween_position(self.ui, 'tween')

    self:UpdateHeadData()

end

function MainUITeam:OnClickOpenAndClose()
    if self.isOpen then
        self.isOpen = false
        self.tweenPosition:play_reverse()
    else
        self.isOpen = true
        self.tweenPosition:play_foward()
    end
end

function MainUITeam:UpdateCaptainHeadData(hero)
    if hero then
        local curHp = hero:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        local value = curHp / hero:GetPropertyVal('max_hp');
        self.captainRoleInfo.proHp:set_value(value)
        self.captainRoleInfo.labHp:set_text(tostring(PublicFunc.AttrInteger(curHp)))

        PublicFunc.Set120Icon(self.captainRoleInfo.spHuman,hero:GetConfigBigIcon());
    else
        --app.log('UpdateCaptainHeadData team captain is nil')
    end
end

function MainUITeam:UpdateTeamMemberHeadData(hero, index)
    local roleInfo = self.teamMemberRoleInfo[index]
    if hero then
        roleInfo.proHp:set_active(true)
        roleInfo.spHuman:set_active(true)
        roleInfo.node:set_active(true)
        local curHp = hero:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
        local value = curHp / hero:GetPropertyVal('max_hp');
        roleInfo.proHp:set_value(value)

        PublicFunc.Set120Icon(roleInfo.spHuman,hero:GetConfigBigIcon());
    else
        
        roleInfo.proHp:set_active(false)
        roleInfo.spHuman:set_active(false)
    end
end

function MainUITeam:UpdateHeadData()
    if self.ui ==nil then
        return
    end

    for i=1,3 do
        local hero = g_dataCenter.fight_info:GetControlHero(i)
        if hero then
            self.role_id_head[hero.name] = i;
            if i == 1 then
                self:UpdateCaptainHeadData(hero)
            else
            
                self:UpdateTeamMemberHeadData(hero, i)
            end
        else
            if i == 1 then
                --app.log('captain is nil')
            else
                self:UpdateTeamMemberHeadData(nil, i)
            end
        end
    end
    
end

function MainUITeam:TeamHeroProChanged()
    -- 标记
    self.teamHeroProChanged = true
end

function MainUITeam:Update(dt)
    if self.teamHeroProChanged then
        self:UpdateHeadData()
    end

    if self.relive_list then
        for k, v in pairs(self.relive_list) do
            local role_index = self.role_id_head[k]
            if role_index then
                local roleInfo = self.teamMemberRoleInfo[role_index]

                local surplus = v.max_time -(os.time() - v.cur_time);
                if surplus < 0 then
                    if g_dataCenter.fight_info:IsInFight() then
                        roleInfo.spMark:set_active(true)
                        roleInfo.labTime:set_color(1, 1, 1, 1);
                        roleInfo.labTime:set_text("脱战复活");
                    else
                        roleInfo.spMark:set_active(false)
                        roleInfo.labTime:set_color(0, 1, 0, 1);
                        roleInfo.labTime:set_text("点击复活");
                    end
                else
                    roleInfo.labTime:set_text(tostring(math.ceil(surplus)));
                end
            end
        end
    end

    if self.isReborning == true then
        if g_dataCenter.fight_info:IsInFight() then
            --self:AbortReborn()        
        end
    end
end

function MainUITeam:RoleDead(name, relive_time)
    local index = self.role_id_head[name]
    if index == nil then
        self:UpdateHeadData()
    end
    index = self.role_id_head[name]
    if index then
         if index == 1 then
            self.captainRoleInfo.spMark:set_active(true)
            for k,v in pairs(self.teamMemberRoleInfo) do
                v.spMark:set_active(true)
            end
            self:CaptainOnDead(name)
        else
            self.teamMemberRoleInfo[index].spMark:set_active(true)

            self.relive_list[name] = { cur_time = os.time(), max_time = relive_time };
        end
    end
end

function MainUITeam:ClearReliveInfo(name)
    self.relive_list[name] = nil
    local role_index = self.role_id_head[name]
    if role_index == 1 then
        self.captainRoleInfo.spMark:set_active(false)
    else
        local roleInfo = self.teamMemberRoleInfo[role_index]
        if roleInfo then
            roleInfo.spMark:set_active(false)
            roleInfo.labTime:set_color(1, 1, 1, 1);
            roleInfo.labTime:set_text("");
        end
    end

    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain and captain:GetName() == name then
        CameraManager.MoveToTargetImm(true)
        local deadui = uiManager:FindUI(EUI.UiRevive);
        if deadui then
            deadui:Close();
        end
    end
end

function MainUITeam:OnClickHead()
    if self.isReborning == true then
        return
    end


    self.isReborning = true


    self.rebornHerosName = {}
    for i=2,3 do
        local hero = g_dataCenter.fight_info:GetControlHero(i)
        if hero then
            if hero:GetHP() <= 0 then
                table.insert(self.rebornHerosName, hero:GetName())
            end
        end
    end
    if #self.rebornHerosName <= 0 then
        return
    end
    
    local pmi = FightScene.GetStartUpEnv():GetPlayMethod();
    local captain = g_dataCenter.fight_info:GetCaptain() 
    if captain and pmi~= nil then
        msg_fight.cg_relive_follow_hero(captain:GetGID())
    end
end

function MainUITeam:OnReboenProgressEnd()
    if self.isReborning ~= true then
        return
    end

    self.isReborning = false
    self.hasShowReliveProgressBar = false

    local pmi = FightScene.GetStartUpEnv():GetPlayMethod();
    if pmi == nil then
        for i=2,3 do
            local hero = g_dataCenter.fight_info:GetControlHero(i)
            if hero then
                if hero:GetHP() <= 0 then
                    hero:Reborn()
                end
            end
        end
    end
end

function MainUITeam:AbortReborn()
    if self.isReborning ~= true then
        return
    end

    self.isReborning = false
    self.hasShowReliveProgressBar = false

    GetMainUI():ProgressBarCanelProgress()
end

function MainUITeam:OnReliveFollowHero(ret)
    if ret == 0 then
        if self.hasShowReliveProgressBar ~= true then
            GetMainUI():ProgressBarShowProgress("复活中", 10, self.bindfunc['OnReboenProgressEnd'])
            self.hasShowReliveProgressBar = true
        end
    else
        self:AbortReborn()
    end
end

function MainUITeam:CaptainOnDead(name)
    local pmi = FightScene.GetStartUpEnv():GetPlayMethod();
    if pmi ~= nil then
    else
        -- 关卡 直接干死其他跟随英雄
        for i=1, 3 do
            if g_dataCenter.fight_info.control_hero_list[i] and g_dataCenter.fight_info.control_hero_list[i] ~= name then
                local follower = ObjectManager.GetObjectByName(g_dataCenter.fight_info.control_hero_list[i])
                if follower then
                    follower:SetHP(0)
                end
            end
        end
    end
end

function MainUITeam:BeginMMORelive()
    uiManager:PushUi(EUI.UiRevive)
end

function MainUITeam:HeroLevelUp(name)
    local teamIndex = g_dataCenter.fight_info:GetControlIndex(name)
    local fxNode = nil
    if teamIndex == 1 then
        fxNode = self.captainRoleInfo.levelUpFx
    elseif teamIndex >1 and teamIndex <= 3 then
        fxNode = self.teamMemberRoleInfo[teamIndex].levelUpFx
    end

    if fxNode then
        fxNode:set_active(false)
        fxNode:set_active(true)
    end
end

function MainUITeam:OnShow()
    self:UpdateHeadData()
end

function MainUITeam:OnHide()
    if self.ui then
        self:ResetFxState()
    end
end

function MainUITeam:ResetFxState()
    self.captainRoleInfo.levelUpFx:set_active(false)
    for i=2,3 do
        self.teamMemberRoleInfo[i].levelUpFx:set_active(false);
    end
end

function LocalModeAbortReborn()
    if FightScene.GetStartUpEnv():GetPlayMethod() == nil then
        PublicFunc.msg_dispatch('AbortReborn')
    end
end
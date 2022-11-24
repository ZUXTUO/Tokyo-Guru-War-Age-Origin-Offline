
MainUITeamCanChange = Class('MainUITeamCanChange', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_jjc.assetbundle"

local uiText = 
{
    [1] = "全能值:%d"
}

function MainUITeamCanChange.GetResList()
    return {res}
end

function MainUITeamCanChange:Init(data)
    self.pathRes = res
    self.is_filter = false
    self.dataCache = data.dataCache
    if self.dataCache.relive_list == nil then
        self.dataCache.relive_list = {}
    end
    self.relive_list = self.dataCache.relive_list
    self.playLowHpEct = 30
    local boundary = ConfigManager.Get(EConfigIndex.t_discrete,83000119)
    if boundary then
        self.playLowHpEct = tostring(boundary.data)
    end
    self.playLowHpEct = self.playLowHpEct/100

    self.right_relive_list = {}

	UiBaseClass.Init(self, data);
end

function MainUITeamCanChange:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.listRole then
        for i = 1, 3 do
            local roleInfo = self.listRole[i]
            roleInfo.headSmallCard:DestroyUi()
            if allSkill then
                local allSkill = roleInfo.skillInfo.allSkill
                for k,v in ipairs(allSkill) do
                    v.texture:Destroy()
                end
            end
        end
        self.listRole = nil
    end

    if self.rightListRole then
        for i = 1, 3 do
            local roleInfo = self.rightListRole[i]
            roleInfo.headSmallCard:DestroyUi()
            local allSkill = roleInfo.skillInfo.allSkill
            if allSkill then
                for k,v in ipairs(allSkill) do
                    v.texture:Destroy()
                end
            end
        end
        self.rightListRole = nil
    end

    self.pos = nil;
    self.currentShowCaptainIndex = nil
end

function MainUITeamCanChange:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['ClickHead'] = Utility.bind_callback(self, self.ClickHead);
    self.bindfunc['OnReliveFollowHero'] = Utility.bind_callback(self, self.OnReliveFollowHero)
    self.bindfunc['OnReboenProgressEnd'] = Utility.bind_callback(self, self.OnReboenProgressEnd)
    self.bindfunc['StartSKillCD'] = Utility.bind_callback(self, self.StartSKillCD)
    self.bindfunc['StopSkillCD'] = Utility.bind_callback(self, self.StopSkillCD)
end

function MainUITeamCanChange:MsgRegist()
    PublicFunc.msg_regist(msg_fight.gc_relive_follow_hero_state, self.bindfunc['OnReliveFollowHero'])
    PublicFunc.msg_regist("start_skill_cd", self.bindfunc['StartSKillCD'])
    PublicFunc.msg_regist("stop_skill_cd", self.bindfunc['StopSkillCD'])
end

function MainUITeamCanChange:MsgUnRegist()
    PublicFunc.msg_unregist(msg_fight.gc_relive_follow_hero_state, self.bindfunc['OnReliveFollowHero'])
    PublicFunc.msg_unregist("start_skill_cd", self.bindfunc['StartSKillCD'])
    PublicFunc.msg_unregist("stop_skill_cd", self.bindfunc['StopSkillCD'])
end

function MainUITeamCanChange:OnReliveFollowHero(ret)
    if ret == 0 then
        if self.hasShowReliveProgressBar ~= true then 
            GetMainUI():ProgressBarShowProgress("复活中", 10, self.bindfunc['OnReboenProgressEnd'])
            self.hasShowReliveProgressBar = true
        end
    else
        self:AbortReborn()
    end
end

function MainUITeamCanChange:OnReboenProgressEnd()
    if self.isReborning ~= true then
        return
    end
    self.isReborning = false
    self.hasShowReliveProgressBar = false
end

function MainUITeamCanChange:AbortReborn()
    if self.isReborning ~= true then
        return
    end

    self.isReborning = false
    self.hasShowReliveProgressBar = false
    GetMainUI():ProgressBarCanelProgress()
end

function MainUITeamCanChange:ClickHead(t)
    local index = tonumber(t.string_value);

    local hero =  g_dataCenter.fight_info:GetControlHero(index)

    if hero ==nil then
        return
    end
    if hero:IsDead() then
        self.checkSelectHead = true
        if self._initData.canReborn == true and hero.can_reborn_now and not g_dataCenter.fight_info:IsInFight() then
            if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss or 
               FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
                local bHaveDead = false
                for i=1, 3 do
                    local hero = g_dataCenter.fight_info:GetControlHero(i)
                    if hero then
                        if hero:IsDead() then
                            bHaveLive = true
                            break
                        end
                    end
                end
                if bHaveLive then
                    local captain = g_dataCenter.fight_info:GetCaptain() 
                    if captain then
                        self.isReborning = true
                        msg_fight.cg_relive_follow_hero(captain:GetGID())
                    end
                end
            else
                hero:Reborn()
            end
        end
    else
        g_dataCenter.player:ChangeCaptain(index) 
    end

end

function MainUITeamCanChange:SetHeadProgressBar()

    local fightInfo = g_dataCenter.fight_info
    local captainIndex = fightInfo:GetCaptainIndex()

    --------------------------- left
    local quanneng = 0
    local isSetQuanNeng = false
    local index = 1
    while index <= 3 do
        local roleInfo = self.listRole[index]

        local name = fightInfo:GetControlHeroName(index)
        local hero = GetObj(name)
        if hero then
            if hero:GetConfigNumber() ~= roleInfo.hasShowNumber then
                roleInfo.hasShowNumber = hero:GetConfigNumber()

                if not isSetQuanNeng then
                    isSetQuanNeng = true
                    quanneng = hero:GetPropertyVal(ENUM.EHeroAttribute.quan_neng)
                end

                local nowCardInfo = roleInfo.headSmallCard:GetCardInfo()
                local cardInfo = hero:GetCardInfo()
                if cardInfo == nil then
                    if nowCardInfo == nil then
                        local data = {number=hero:GetConfigNumber(), level = hero.level}
                        cardInfo = CardHuman:new(data)
                    end
                end

                roleInfo.headSmallCard:SetData(cardInfo)
                roleInfo.proHp2:set_active(true)
                self.currentShowCaptainIndex = nil
                self.role_id_head[name] = index
                roleInfo.spMark2:set_active(false);

                self:SetSkillContent(hero, roleInfo.skillInfo)
            end
        else
            break
        end

        index = index + 1
    end

    local leftDelay = fightInfo:GetDelayLoadHeroList(fightInfo.single_friend_flag)
    if index <= 3 and #leftDelay > 0 then
        local delayIndex = 1
        while index <= 3 do
            local roleInfo = self.listRole[index]
            local gid = leftDelay[delayIndex]
            if gid  then
                if roleInfo.hasShowNumber ~= gid then
                    roleInfo.hasShowNumber = gid

                    roleInfo.headSmallCard:SetData(nil, nil, "weizhi")
                    roleInfo.proHp2:set_active(false)
                end
            else
                break
            end

            delayIndex = delayIndex + 1
            index = index + 1
        end
    end

    if index <= 3 then
        local initData = self:GetInitData()
        for i = index, 3 do
            local roleInfo = self.listRole[i]
            if roleInfo.hasShowNumber ~= 0 then
                roleInfo.hasShowNumber = 0
                roleInfo.headSmallCard:SetData(nil)
                if initData.showQuanNeng then
                    roleInfo.proHp2:set_active(false)
                else
                    roleInfo.btnHead:set_active(false)
                end
            end
        end
    end


    if self.currentShowCaptainIndex ~= captainIndex then
        for i = 1, 3 do
            local roleInfo = self.listRole[i]
            if i ==captainIndex then    
                roleInfo.proHp2ColorSp:set_sprite_name("yx_jindutiao3")
            else    
                roleInfo.proHp2ColorSp:set_sprite_name("yx_jindutiao4")
            end
        end

        self.currentShowCaptainIndex = captainIndex
    end
    if isSetQuanNeng and self.listRole.hasShowQuanNengValue ~= quanneng then
        self.listRole.hasShowQuanNengValue = quanneng
        self.listRole.quanNengLabel:set_text(string.format(uiText[1], quanneng))
    end

    -------------------------------------------------- right
    if self.rightListRole == nil then return end
    local heroList = fightInfo:GetHeroList(fightInfo.single_enemy_flag) 
    index = 1
    quanneng = 0
    isSetQuanNeng = false
    for k,v in pairs(heroList) do
        local hero = GetObj(v)
        if hero then
            if not isSetQuanNeng then
                isSetQuanNeng = true
                quanneng = hero:GetPropertyVal(ENUM.EHeroAttribute.quan_neng)
            end

            local roleInfo = self.rightListRole[index]
            if roleInfo.hasShowNumber ~= hero:GetConfigNumber() then
                roleInfo.hasShowNumber = hero:GetConfigNumber()
                roleInfo.headSmallCard:SetData(hero:GetCardInfo())
                self:SetSkillContent(hero, roleInfo.skillInfo)
                roleInfo.proHp2:set_active(true)
                self.right_role_id_head[v] = index
            end

            index = index + 1
        end
    end

    if isSetQuanNeng and self.rightListRole.hasShowQuanNengValue ~= quanneng then
        self.rightListRole.quanNengLabel:set_text(string.format(uiText[1], quanneng))
    end

    local rightDelay = fightInfo:GetDelayLoadHeroList(fightInfo.single_friend_flag)
    if index <= 3 and #rightDelay > 0 then
        local delayIndex = 1
        while index <= 3 do
            local roleInfo = self.rightListRole[index]
            local gid = rightDelay[delayIndex]
            if gid  then
                if roleInfo.hasShowNumber ~= gid then
                    roleInfo.hasShowNumber = gid

                    roleInfo.headSmallCard:SetData(nil, nil, "weizhi")
                    roleInfo.proHp2:set_active(false)
                end
            else
                break
            end

            delayIndex = delayIndex + 1
            index = index + 1
        end
    end

    for i = index, 3 do
        local roleInfo = self.rightListRole[i]
        if roleInfo.hasShowNumber ~= 0 then
            roleInfo.hasShowNumber = 0
            roleInfo.headSmallCard:SetData(nil)
            roleInfo.proHp2:set_active(false)
        end
    end
end

function MainUITeamCanChange:SetSkillContent(obj, skillInfo)
    local initData = self:GetInitData()
    if not obj or not initData.showSkillCD then return end

    skillInfo.root:set_active(true)
    skillInfo.deadLabel:set_active(false)
    for i = 1, 3 do
        local skill = obj:GetSkill(i+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX)
        local oneSkill = skillInfo.allSkill[i]
        if skill then
            local iconPath = ConfigManager.Get(EConfigIndex.t_skill_info,skill._skillData.id).small_icon
            oneSkill.texture:set_texture(iconPath)
        else
            if obj.config.spe_skill and obj.config.spe_skill[i] and obj.config.spe_skill[i][1] then
                local info = ConfigManager.Get(EConfigIndex.t_skill_info, obj.config.spe_skill[i][1])
                if info then
                    oneSkill.texture:set_texture(info.small_icon);
                end
            end
        end

        oneSkill.texture:set_color(1, 1, 1, 1)
        oneSkill.cdLabel:set_active(false)
        oneSkill.cdSp:set_active(false)
    end
end

function MainUITeamCanChange:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    if self.pos then
        self.ui:set_local_position(self.pos.x, self.pos.y, self.pos.z);
    end

    local initData = self:GetInitData()
    initData.showQuanNeng = initData.showRight
    initData.showSkillCD = initData.showRight
    -- if initData.showRight == true and initData.canReborn then
    --     initData.canReborn = false
    -- end

    local trainningIsOpen = g_dataCenter.trainning:needlvl()

    if initData.showSkillCD then
        self.skillCD = {}
    end

    self.role_id_head = {}
    self.listRole = {}
    self.listRole.root = self.ui:get_child_by_name("left_head_cont");
    self.listRole.backgroundSprite = self.listRole.root:get_child_by_name("sp_di")
    self.listRole.quanNengNode = self.listRole.root:get_child_by_name("sp_bk")
    self.listRole.quanNengLabel = ngui.find_label(self.listRole.quanNengNode, "lab")
    self.listRole.quanNengLabel:set_text(string.format(uiText[1], 0))
    if not trainningIsOpen then
        self.listRole.quanNengLabel:set_active(false)
    end
    for i = 1, 3 do
        local roleInfo = {};
        self.listRole[i] = roleInfo;
        roleInfo.objRoot = self.listRole.root:get_child_by_name("cont_black_di"..i);
        roleInfo.beAttackedTipSp = ngui.find_sprite(roleInfo.objRoot, "sp_shine")
        roleInfo.beAttackedTipSp:set_active(false)
        roleInfo.btnHead = ngui.find_button(roleInfo.objRoot, "cont_black_di"..i);
        roleInfo.toggleHead = ngui.find_toggle(roleInfo.objRoot, "cont_black_di"..i);
        if roleInfo.btnHead and initData.isOpenChange == true then
            roleInfo.btnHead:set_event_value(tostring(i), 0);
            roleInfo.btnHead:set_on_click(self.bindfunc['ClickHead']);
        end

        roleInfo.lab_hp_info = ngui.find_label(roleInfo.objRoot, "pro_xuetiao/lab");
        roleInfo.lab_hp_info:set_text("")
        roleInfo.proHp2 = ngui.find_progress_bar(roleInfo.objRoot, "pro_xuetiao");
        roleInfo.proHp2ColorSp = ngui.find_sprite(roleInfo.objRoot, "pro_xuetiao/sp")
        roleInfo.spMark2 = ngui.find_sprite(roleInfo.objRoot, "sp_mark");
        roleInfo.spMark2:set_active(false);
        roleInfo.labTime2 = ngui.find_label(roleInfo.objRoot, "lab_time");
        roleInfo.labTime2:set_color(1, 1, 1, 1);
        roleInfo.labTime2:set_text("");
        roleInfo.headParent = roleInfo.objRoot:get_child_by_name("big_card_item_80")
        roleInfo.headSmallCard = SmallCardUi:new({parent = roleInfo.headParent, stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star, SmallCardUi.SType.Rarity, SmallCardUi.SType.Qh}})
        roleInfo.headSmallCard:EnableButtonFunc(false)
        roleInfo.backgroundSprite = ngui.find_sprite(roleInfo.objRoot, "sp_black_di")
        local skillInfo = {}
        skillInfo.root = roleInfo.objRoot:get_child_by_name("sp_white_bk")
        skillInfo.root:set_active(false)
        if initData.showSkillCD then
            skillInfo.allSkill = {}
            for i = 1, 3 do
                local oneSkill = {}
                local rootPath = "Texture" .. tostring(i)
                oneSkill.texture = ngui.find_texture(skillInfo.root, rootPath)
                oneSkill.cdLabel = ngui.find_label(skillInfo.root, rootPath .. '/lab')
                oneSkill.cdSp = ngui.find_sprite(skillInfo.root, rootPath .. '/sp_black_mark')
                
                skillInfo.allSkill[i] = oneSkill
            end
            skillInfo.deadLabel = ngui.find_label(skillInfo.root, 'lab_zhenwang')
        end

        roleInfo.skillInfo = skillInfo

        if initData.isOpenChange == false then
            ngui.find_sprite(roleInfo.objRoot, 'sp_effect'):set_active(false)
        end
    end

    local rightNode = self.ui:get_child_by_name("right_head_cont");
    if initData.showRight then
        self.right_role_id_head = {}
        self.rightListRole= {}
        self.rightListRole.root = rightNode
        self.rightListRole.quanNengNode = self.rightListRole.root:get_child_by_name("sp_bk")
        self.rightListRole.quanNengLabel = ngui.find_label(self.rightListRole.quanNengNode, "lab")
        self.rightListRole.quanNengLabel:set_text(string.format(uiText[1], 0))
        if not trainningIsOpen then
             self.rightListRole.quanNengLabel:set_active(false)
        end
        for i = 1, 3 do
            local roleInfo = {}
            self.rightListRole[i] = roleInfo;
            roleInfo.objRoot = self.rightListRole.root:get_child_by_name("big_card_item_80"..i);
            roleInfo.proHp2 = ngui.find_progress_bar(roleInfo.objRoot, "pro_xuetiao");
            roleInfo.proHp2ColorSp = ngui.find_sprite(roleInfo.objRoot, "pro_xuetiao/sp")
            roleInfo.labTime2 = ngui.find_label(roleInfo.objRoot, "lab_time")
            roleInfo.labTime2:set_active(false)
            roleInfo.headParent = roleInfo.objRoot:get_child_by_name("big_card_item_80")
            roleInfo.headSmallCard = SmallCardUi:new({parent = roleInfo.headParent, stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star, SmallCardUi.SType.Rarity, SmallCardUi.SType.Qh}})

            local skillInfo = {}
            skillInfo.root = roleInfo.objRoot:get_child_by_name("sp_white_bk")
            skillInfo.root:set_active(false)
            if initData.showSkillCD then
                skillInfo.allSkill = {}
                for i = 1, 3 do
                    local oneSkill = {}
                    local rootPath = "Texture" .. tostring(i)
                    oneSkill.texture = ngui.find_texture(skillInfo.root, rootPath)
                    oneSkill.cdLabel = ngui.find_label(skillInfo.root, rootPath .. '/lab')
                    oneSkill.cdSp = ngui.find_sprite(skillInfo.root, rootPath .. '/sp_black_mark')
                    
                    skillInfo.allSkill[i] = oneSkill
                end
                skillInfo.deadLabel = ngui.find_label(skillInfo.root, 'lab_zhenwang')
            end
            
            roleInfo.skillInfo = skillInfo
        end
    else
        rightNode:set_active(false)
    end

    self.teamHeroProChanged = nil
    self:ShowQuanNengUi()
    self:UpdateHeadData()
end

function MainUITeamCanChange:ShowQuanNengUi()
    local initData = self:GetInitData()

    self.listRole.quanNengNode:set_active(initData.showQuanNeng)
    self.listRole.backgroundSprite:set_active(initData.showQuanNeng)
    for i = 1, 3 do
        self.listRole[i].backgroundSprite:set_active(not initData.showQuanNeng)
    end
end

function MainUITeamCanChange:UpdateHeadData()
    if not self.ui then
        return;
    end
    self:SetHeadProgressBar()

    for i = 1,3 do
        local hero = g_dataCenter.fight_info:GetControlHero(i)
        if hero then
            local index = self.role_id_head[hero:GetName()]
            local roleInfo = self.listRole[index];
            roleInfo.btnHead:set_active(true)
            local curHp = hero:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
            local maxHp = hero:GetPropertyVal('max_hp');
            --roleInfo.lab_hp_info:set_text(tostring(math.floor(curHp)).."/"..math.floor(maxHp))
            local value = curHp / maxHp;
            roleInfo.proHp2:set_value(value)

            if value < self.playLowHpEct and roleInfo.lastShowHPValue ~= curHp then
                roleInfo.objRoot:animated_stop("new_fight_ui_fuzion_cont_left")
                roleInfo.objRoot:animated_play("new_fight_ui_fuzion_cont_left")

                roleInfo.lastShowHPValue = curHp
            end
            --roleInfo.lab_hp_info:set_text(tostring(math.floor(curHp)).."/"..math.floor(maxHp))
        end
    end

    -- right
    if self.rightListRole then
        local heroList = g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_enemy_flag)
        for k,v in pairs(heroList) do
            local hero = GetObj(v)
            if hero then
                local index = self.right_role_id_head[v]
                local roleInfo = self.rightListRole[index]
                if roleInfo then
                    local curHp = hero:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
                    local maxHp = hero:GetPropertyVal('max_hp')
                    local value = curHp / maxHp;

                    roleInfo.proHp2:set_value(value)
                    --roleInfo.lab_hp_info:set_text(tostring(math.floor(curHp)).."/"..math.floor(maxHp))
                end
            end
        end
    end
    self.checkSelectHead = true;
end

function MainUITeamCanChange:RoleDead(name, relive_time)
    --app.log("#hyg#MainUITeamCanChange:RoleDead " .. tostring(name) .. ' ' .. tostring(relive_time) .. ' ' .. tostring(self._initData.canReborn))
    if self.role_id_head[name] then
        local roleInfo = self.listRole[self.role_id_head[name]];
        roleInfo.spMark2:set_active(true);

        if self._initData.canReborn == true and not self.is_filter then
            self.relive_list[name] = { cur_time = os.time(), max_time = relive_time };
        else
            roleInfo.labTime2:set_text("");
            roleInfo.proHp2:set_active(false)

            if self._initData.showRight then
                roleInfo.skillInfo.deadLabel:set_active(true)
            end
        end
    elseif self.rightListRole then
        local index = self.right_role_id_head[name]
        if index then
            local roleInfo = self.rightListRole[index]
            roleInfo.headSmallCard:SetGray(true)
            roleInfo.proHp2:set_active(false)

            if self._initData.canReborn and not self.is_filter then
                roleInfo.labTime2:set_active(true)
                roleInfo.labTime2:set_text("");
                
                self.right_relive_list[name] = { cur_time = os.time(), max_time = relive_time };
            else
                if self._initData.showRight then
                    roleInfo.skillInfo.deadLabel:set_active(true)
                end
            end
        end
    end

    if self._initData.showSkillCD then
        self:GrayHeroSKills(name, true)
    end
end

function MainUITeamCanChange:ClearReliveInfo(name)
    if name == nil then
        for k, v in pairs(self.relive_list) do
            self.relive_list[k] = nil
            local role_index = self.role_id_head[k]
            local roleInfo = self.listRole[role_index];
            if roleInfo then
                roleInfo.spMark2:set_active(false)
                roleInfo.labTime2:set_text("");
                roleInfo.labTime2:set_color(1, 1, 1, 1);
            end

            if self._initData.showSkillCD then
                self:GrayHeroSKills(k, false)
            end
        end

        for k,v in pairs(self.right_relive_list) do
            self.right_relive_list[k] = nil
            local index = self.right_role_id_head[k]
            local roleInfo = self.rightListRole[index]
            if roleInfo then
                roleInfo.headSmallCard:SetGray(false)
                roleInfo.proHp2:set_active(true)

                roleInfo.labTime2:set_active(false)
            end

            if self._initData.showSkillCD then
                self:GrayHeroSKills(k, false)
            end
        end
    else
        self.relive_list[name] = nil
        local role_index = self.role_id_head[name]
        local roleInfo = self.listRole[role_index];
        if roleInfo then
            roleInfo.spMark2:set_active(false)
            roleInfo.labTime2:set_text("");
            roleInfo.labTime2:set_color(1, 1, 1, 1);
        end

        if self.right_role_id_head then
            self.right_relive_list[name] = nil
            local index = self.right_role_id_head[name]
            local roleInfo = self.rightListRole[index]
            if roleInfo then
                roleInfo.headSmallCard:SetGray(false)
                roleInfo.proHp2:set_active(true)

                roleInfo.labTime2:set_active(false)
            end

            if self._initData.showSkillCD then
                self:GrayHeroSKills(name, false)
            end
        end
    end
end

function MainUITeamCanChange:Update(dt)
    for k, v in pairs(self.relive_list) do
        local role_index = self.role_id_head[k]
        if role_index then
            local roleInfo = self.listRole[role_index];
            -- 剩余时间s
            local surplus = v.max_time -(os.time() - v.cur_time);
            if surplus < 0 then
                if self.teamHeroAutoReborn then
                    roleInfo.spMark2:set_active(false)
                    roleInfo.labTime2:set_color(0, 1, 0, 1);
                    roleInfo.labTime2:set_text("");
                else
                    if g_dataCenter.fight_info:IsInFight() then
                        roleInfo.spMark2:set_active(true)
                        roleInfo.labTime2:set_color(1, 1, 1, 1);
                        roleInfo.labTime2:set_text("脱战复活");
                    else
                        roleInfo.spMark2:set_active(false)
                        roleInfo.labTime2:set_color(0, 1, 0, 1);
                        roleInfo.labTime2:set_text("点击复活");
                    end
                end
            else
                roleInfo.labTime2:set_text(tostring(math.ceil(surplus)));
            end
        end
    end

    for k,v in pairs(self.right_relive_list) do
        local index = self.right_role_id_head[k]
        if index then
            local roleInfo = self.rightListRole[index]
            local surplus = v.max_time -(os.time() - v.cur_time);
            if surplus < 0 then surplus = 0 end
            roleInfo.labTime2:set_text(tostring(math.ceil(surplus)));
        end
    end

    if self.teamHeroProChanged then
        self:UpdateHeadData()
    end

    if self.checkSelectHead == true then
        local captainIndex = g_dataCenter.fight_info:GetCaptainIndex()
        local roleInfo = self.listRole[captainIndex]
        if roleInfo and roleInfo.toggleHead:get_value() ~= true then
            roleInfo.toggleHead:set_value(true)
            self.checkSelectHead = nil
        end

    end

    if self.skillCD then
        for name,skills in pairs(self.skillCD) do
            local hasSkill = false
            for index, v in pairs(skills) do
                local oneSkill  = self:GetSkillInfo(name, index)
                if oneSkill then
                    if PublicFunc.QueryCurTime() >= v.cd_time then
                        self.skillCD[name][index] = nil
                        
                        oneSkill.cdLabel:set_active(false)
                        oneSkill.cdSp:set_active(false)
                    else
                        hasSkill = true
                        local mod_time = PublicFunc.QueryDeltaTime(v.cd_time)/1000
                        oneSkill.cdLabel:set_text(tostring(math.ceil(mod_time)))
                        oneSkill.cdSp:set_fill_amout(mod_time / v.max_time)
                    end
                end
            end

            if not hasSkill then
                self.skillCD[name] = nil
            end
        end
    end
end

function MainUITeamCanChange:GrayHeroSKills(name, isGray)
    local i = self.role_id_head[name]
    local skills = nil
    if i then
        skills = self.listRole[i].skillInfo.allSkill
    else
        i = self.right_role_id_head[name]
        if i then
            skills = self.rightListRole[i].skillInfo.allSkill
        end
    end

    if skills then
        for k,v in ipairs(skills) do
            v.cdLabel:set_active(false)
            v.cdSp:set_active(false)
            if isGray then
                v.texture:set_color(0, 0, 0, 1)
            else
                v.texture:set_color(1, 1, 1, 1)
            end
        end
    end
end

function MainUITeamCanChange:GetSkillInfo(name, index)
    local i = self.role_id_head[name]
    local oneSkill = nil
    if i then
        oneSkill = self.listRole[i].skillInfo.allSkill[index]
    else
        i = self.right_role_id_head[name]
        if i then
            oneSkill = self.rightListRole[i].skillInfo.allSkill[index]
        end
    end
    return oneSkill
end

function MainUITeamCanChange:StartSKillCD(name, index, endFrame, time)

    if not self.skillCD then return end

    -- convert to ui index
    index = index - 1
    local oneSkill  = self:GetSkillInfo(name, index)
    if not oneSkill then return end

    self.skillCD[name] = self.skillCD[name] or {}
    self.skillCD[name][index] = {cd_time = endFrame, max_time = time}
    
    oneSkill.cdLabel:set_active(true)
    oneSkill.cdSp:set_active(true)
    local mod_time = PublicFunc.QueryDeltaTime(endFrame)/1000
    oneSkill.cdSp:set_fill_amout(mod_time/time)
end

function MainUITeamCanChange:StopSkillCD(name, index)

    if not self.skillCD then return end

    -- convert to ui index
    index = index - 1
    local skills = self.skillCD[name]
    if skills and skills[index] then
        skills[index] = nil
    end
end

function MainUITeamCanChange:TeamHeroProChanged()
    -- 标记
    self.teamHeroProChanged = true
end

function MainUITeamCanChange:TeamHeroAutoReborn()
    self.teamHeroAutoReborn = true
end

function MainUITeamCanChange:SetSelectHead(index)
    local roleInfo = self.listRole[index]
    if roleInfo then
        roleInfo.toggleHead:set_value(true)
    end
end

function MainUITeamCanChange:OnShow()
    self:UpdateHeadData()
end


function MainUITeamCanChange:SetLocalPosition(x,y,z)
    if self.ui then
        self.ui:set_local_position(x, y, z);
    else
        self.pos = {x=x,y=y,z=z};
    end
end
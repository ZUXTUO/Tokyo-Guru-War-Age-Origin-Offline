QingTongJiDiHeroChoseUI = Class("QingTongJiDiHeroChoseUI", UiBaseClass);

function QingTongJiDiHeroChoseUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4303_ghoul_3v3.assetbundle"
    UiBaseClass.Init(self, data);
end

function QingTongJiDiHeroChoseUI:Restart(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    UiBaseClass.Restart(self, data);
end

function QingTongJiDiHeroChoseUI:InitData(data)
    self.maxTime = ConfigManager.Get(EConfigIndex.t_three_to_three_fight,1).select_role_time;
    
    UiBaseClass.InitData(self, data);
end

function QingTongJiDiHeroChoseUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_confirm_btn"] = Utility.bind_callback(self, self.on_confirm_btn)
    self.bindfunc["on_click_hero"] = Utility.bind_callback(self, self.on_click_hero)
    self.bindfunc["on_timer_update"] = Utility.bind_callback(self, self.on_timer_update)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["gc_select_role"] = Utility.bind_callback(self, self.gc_select_role)
    self.bindfunc["gc_update_select_role"] = Utility.bind_callback(self, self.gc_update_select_role)
end

function QingTongJiDiHeroChoseUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function QingTongJiDiHeroChoseUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_three_to_three.gc_select_role, self.bindfunc["gc_select_role"])
    PublicFunc.msg_regist(msg_three_to_three.gc_update_select_role, self.bindfunc["gc_update_select_role"])
end

function QingTongJiDiHeroChoseUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_three_to_three.gc_select_role, self.bindfunc["gc_select_role"])
    PublicFunc.msg_unregist(msg_three_to_three.gc_update_select_role, self.bindfunc["gc_update_select_role"])
end

function QingTongJiDiHeroChoseUI:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function QingTongJiDiHeroChoseUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("qtjd_hero_chose_ui");

    self.forcusIndex = 0
    self.playerVs = self.dataCenter:GetPlayerVs()
    self.heroItemList = {}

    local path = "centre_other/animation/left_content/"
    ----------------------- 左侧 ----------------------
    self.scrollView = ngui.find_scroll_view(self.ui, path.."scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path.."scroll_view/panel_list/wrap_cont")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])


    path = "centre_other/animation/right_content/"
    ----------------------- 右侧 ----------------------
    self.labTime = ngui.find_label(self.ui, path.."lab_time")
    self.pnPlayer = {}
    for i=1, 3 do
        local objNode = self.ui:get_child_by_name(path.."cont"..i)
        self.pnPlayer[i] = {}
        self.pnPlayer[i].name = ngui.find_label(objNode, "lab_name")
        local objCard = objNode:get_child_by_name("big_card_item_80")
        -- self.pnPlayer[i].card = UiPlayerHead:new({parent=objCard})
        self.pnPlayer[i].card = SmallCardUi:new({parent=objCard, stypes={1,9}})
    end

    self.btnConfirm = ngui.find_button(self.ui, path.."btn_sure")
    self.btnConfirm:set_on_click(self.bindfunc["on_confirm_btn"])


    path = "centre_other/animation/content_skill/"
    ----------------------- 中部 ----------------------
    self.pnSkill = {}
    for i=1, 3 do
        local skillBtn = ngui.find_button(self.ui, path.."btn"..i)
        local skillBtnClk = ButtonClick:new({obj = skillBtn, weakFocus=true});
        -- skillBtnClk:SetPress(self.ViewSkill, i, self);
        
        local objNode = skillBtn:get_game_object()
        self.pnSkill[i] = {}
        self.pnSkill[i].skill = ngui.find_texture(objNode, "skill")
        self.pnSkill[i].lock = ngui.find_sprite(objNode, "sp_lock")
        -- self.pnSkill[i].forcus = ngui.find_sprite(objNode, "sp_shine")
        self.pnSkill[i].self = objNode
        self.pnSkill[i].clsBClk = skillBtnClk
        -- self.pnSkill[i].forcus:set_active(false)
    end
    self.objSkill = self.ui:get_child_by_name("centre_other/animation/content_skill")
    self.objSkill:set_active(false)

    
    -- path = "centre_other/animation/content/"
    self.pnHeroInfo = self.ui:get_child_by_name("centre_other/animation/content")
    self.pnHeroInfo:set_active(false)
    self.heroName = ngui.find_label(self.pnHeroInfo, "lab_name")
    self.heroJob = ngui.find_sprite(self.pnHeroInfo, "sp_pinzhi")
    self.heroDes = ngui.find_label(self.pnHeroInfo, "lab_level")
    self.heroModel = ngui.find_sprite(self.pnHeroInfo, "sp_human")

    local myplayerid = g_dataCenter.player.playerid
    for i, v in pairs(self.playerVs) do
        if myplayerid == v.playerid and v.roleId > 0 then
            self.forcusIndex = i
            break;
        end
    end

    self:LoadAllHero()
    self:LoadHeroView()
    self:UpdateUi()

    TimerManager.Add(self.bindfunc["on_timer_update"], 1000, -1)
    self:on_timer_update();

    local id = AudioManager.Get2dBgmId()
    if id ~= ENUM.EUiAudioBGM.VsWaitingBgm then
        AudioManager.Stop(ENUM.EAudioType._2d, false)
        AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
    else
        -- AudioManager.PlayUiAudio(ENUM.EUiAudioType.VsEnterChoseHero)
    end
end

function QingTongJiDiHeroChoseUI:DestroyUi()
    if self.heroItemList then
        for b, heroItem in pairs(self.heroItemList) do
            for i, v in pairs(heroItem) do
                if type(v) == "table" then
                    v.card:DestroyUi()
                end
            end
        end
        self.heroItemList = nil
    end

    if self.pnSkill then
        for k, v in pairs(self.pnSkill) do
            v.skill:Destroy()
            delete(v.clsBClk);
        end
        self.pnSkill = nil
    end

    if self.pnPlayer then
        for k, v in pairs(self.pnPlayer) do
            v.card:DestroyUi()
        end
        self.pnPlayer = nil
    end

    if self.roleInfo then
        self.roleInfo:DestroyUi()
        self.roleInfo = nil
    end

    self.allHeroData = nil
    self.allHeroNumber = nil

    AudioManager.Stop(ENUM.EAudioType._2d, nil)
    
    TimerManager.Remove(self.bindfunc["on_timer_update"])

    self.isConfirm = nil

    Show3d.Destroy();

    UiBaseClass.DestroyUi(self);
end

function QingTongJiDiHeroChoseUI:LoadAllHero()
    self.allHeroData = {}
    self.allHeroNumber = {}
    local heroList = g_dataCenter.package:get_hero_card_table()
    for i, v in pairs(heroList) do
        if v.default_rarity then
            local config = ConfigManager.Get(EConfigIndex.t_three_to_three_role, v.default_rarity)
            if config then
                local cardInfo = PublicFunc.CreateCardInfo(config.cardNumber)
                cardInfo.level = config.cardLevel
                PublicFunc.UpdateConfigHeroInfo(cardInfo, config)

                table.insert(self.allHeroData, cardInfo)
                cardInfo.is_team = g_dataCenter.player:IsTeam(v.index)
            end
            -- test code.. 
            --local heroData = PublicFunc.CreateCardInfo(v.default_rarity)
            --table.insert(self.allHeroData, heroData)
            --heroData.is_team = g_dataCenter.player:IsTeam(v.index)
        end
    end

    --排序规则：已上阵 > 资质
    local sort_func = function( a, b )
        if a == nil or b == nil then return false end
        if a.is_team ~= b.is_team then
            return a.is_team
        end
        if a.config.aptitude ~= b.config.aptitude then
            return a.config.aptitude > b.config.aptitude
        end
        return a.number < b.number
    end

    table.sort(self.allHeroData, sort_func)

    for i, v in pairs(self.allHeroData) do
        self.allHeroNumber[v.default_rarity] = i
    end

    self.wrapContent:set_min_index(-math.ceil(#self.allHeroData/2) + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
end

function QingTongJiDiHeroChoseUI:LoadHeroView()
    local info = nil

    local heroData = self.allHeroData[self.forcusIndex]
    if heroData then
        self.pnHeroInfo:set_active(true)
        self.objSkill:set_active(true)
        --名字
        local baseConfig = ConfigHelper.GetRole(heroData.default_rarity)
        self.heroName:set_text(tostring(baseConfig.name))
        --职业
        PublicFunc.SetProTypePic(self.heroJob, heroData.pro_type, 3)
        --简介
        self.heroDes:set_text(tostring(heroData.config.simple_describe))

        for i, v in pairs(self.pnSkill) do
            if heroData.config.spe_skill and heroData.config.spe_skill ~= 0 and heroData.config.spe_skill[i] then
                local skillId = heroData.config.spe_skill[i][1]
                v.clsBClk:SetPress(self.ViewSkill, skillId, self);
                local skillcfg = ConfigManager.Get(EConfigIndex.t_skill_info,skillId)
                if skillcfg then
                    if skillcfg.small_icon ~= 0 then
                        v.skill:set_texture(skillcfg.small_icon)
                    end
                    -- 
                    v.lock:set_active(false)
                else
                    v.lock:set_active(true)
                end
            end
        end
    end

    -- 更新3d模型以及背景
    local data = 
    {
        roleData = heroData,
        role3d_ui_touch = self.heroModel,
        type = "mid",
    }
    Show3d.SetAndShow(data)
end

function QingTongJiDiHeroChoseUI:UpdateUi()
    if not self.ui then return end;

    local myplayerid = g_dataCenter.player.playerid
    local selectHero = {}
    local sureHero = {}
    local sideBase = 0
    --更新确定按钮状态
    for i, v in ipairs(self.playerVs or {}) do
        if v.playerid == myplayerid then
            if v.state == 1 then
                PublicFunc.SetButtonShowMode(self.btnConfirm, 3, "sprite_background", "lab")
                --确定离手不能再选择
                self.isConfirm = true
            else
                PublicFunc.SetButtonShowMode(self.btnConfirm, 1, "sprite_background", "lab")
            end
            if i > 3 then
                sideBase = 3
            end
        end
        if v.roleId > 0 then
            selectHero[i] = v.roleId
        end
        if v.state == 1 then
            sureHero[i] = v.roleId
        end
    end

    local sideSelectHero = {}
    local sideSureHero = {}
    for i, roleId in pairs(selectHero) do
        if (sideBase == 0 and i < 4) or (sideBase == 3 and i > 4) then
            sideSelectHero[roleId] = true
        end
    end
    for i, roleId in pairs(sureHero) do
        if (sideBase == 0 and i < 4) or (sideBase == 3 and i > 4) then
            sideSureHero[roleId] = true
        end
    end

    --更新玩家状态
    for i, v in ipairs(self.pnPlayer) do
        local player = self.playerVs[i + sideBase]
        if player then
            if player.roleId > 0 then
                local heroData = self.allHeroData[ self.allHeroNumber[player.roleId] or 0 ]
                v.card:SetData(heroData)
                v.name:set_text(player.name)
                v.card:SetBattleSpEx(player.state == 1)
            else
                v.card:SetData(nil, nil, "weizhi")
                v.name:set_text(player.name)
            end

            if player.playerid == myplayerid then
                PublicFunc.SetUILabelYellow(v.name) --显示黄色字体
            else
                PublicFunc.SetUILabelWhite(v.name)
            end
        else
            v.card:SetData(nil, nil, "weizhi")
            v.name:set_text("")
        end
    end

    --更新选择英雄状态
    for k, heroItem in pairs(self.heroItemList) do
        self:LoadItem(heroItem, heroItem.rowIndex)
    end

    --倒计时提前结束
    if self.dataCenter:GetStage() == 4 then
        TimerManager.Remove(self.bindfunc["on_timer_update"])
        self.labTime:set_text("00:00")

        if self.roleInfo then
            self.roleInfo:DestroyUi()
            self.roleInfo = nil
        end
    end
end

function QingTongJiDiHeroChoseUI:ViewSkill(x, y, state, param)
    if state == true then
        SkillTips.EnableSkillTips(true, param, 1, 100, x, y, 500);
    else
        SkillTips.EnableSkillTips(false)
    end
end

function QingTongJiDiHeroChoseUI:IsConfirmHero()
    local result = false
    if self.playerVs then
        local myplayerid = g_dataCenter.player.playerid
        for k, v in pairs(self.playerVs) do
            if v.playerid == myplayerid then
                result = (v.state == 1)
                break;
            end
        end
    end
    return result
end

function QingTongJiDiHeroChoseUI:UpdateData()

end

function QingTongJiDiHeroChoseUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local heroItem = self.heroItemList[b]
    if heroItem == nil then
        heroItem = {}
        for i=1, 2 do
            heroItem[i] = {}
            heroItem[i].self = obj:get_child_by_name("cont"..i)
            heroItem[i].labName = ngui.find_label(heroItem[i].self, "lab")
            local objParent = heroItem[i].self:get_child_by_name("big_card_item_80")
            heroItem[i].card = SmallCardUi:new({parent=objParent, stypes={1,9}})
            heroItem[i].card:SetCallback(self.bindfunc["on_click_hero"])
        end
        self.heroItemList[b] = heroItem
    end

    self:LoadItem(heroItem, index)
end

function QingTongJiDiHeroChoseUI:LoadItem(heroItem, rowIndex)
    heroItem.rowIndex = rowIndex
    for i=1, 2 do
        local realIndex = (rowIndex-1)*2 + i
        heroItem[i].index = realIndex
        local data = self.allHeroData[realIndex]
        if data then
            heroItem[i].self:set_active(true)
            --取基础角色名，不带颜色，不带品质
            local baseConfig = ConfigHelper.GetRole(data.default_rarity)
            heroItem[i].labName:set_text(tostring(baseConfig.name))
            heroItem[i].card:SetData(data)
            heroItem[i].card:SetBattleSpEx(realIndex == self.forcusIndex)
            heroItem[i].card:SetParam(tostring(realIndex))
        else
            heroItem[i].self:set_active(false)
        end
    end
end

function QingTongJiDiHeroChoseUI:on_confirm_btn()
    if not self.isConfirm and self.forcusIndex > 0 then
        msg_three_to_three.cg_sure_select_role(self.dataCenter:GetRoomId(), self.allHeroData[self.forcusIndex].default_rarity)
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Select3v3HeroSure);
    end
end

function QingTongJiDiHeroChoseUI:on_click_hero(si, info, param)
    if self.isConfirm then return end
    local index = tonumber(param)
    if self.forcusIndex == index then return end

    msg_three_to_three.cg_select_role(self.dataCenter:GetRoomId(), self.allHeroData[index].default_rarity)
end

function QingTongJiDiHeroChoseUI:on_timer_update()
    local endTime = self.dataCenter:GetStartTime() + self.maxTime
    local secs = math.max(0, endTime - system.time())
    local day, hour, min, sec = TimeAnalysis.ConvertSecToDayHourMin(secs)
    self.labTime:set_text(string.format("%02d:%02d", min, sec))
end

function QingTongJiDiHeroChoseUI:gc_select_role(result, roomId, roleid)
    if not self.ui then return end;

    for i, heroData in ipairs(self.allHeroData) do
        if heroData.default_rarity == roleid then
            self.forcusIndex = i;
            self:LoadHeroView()
            self:UpdateUi()
            break;
        end
    end
end

function QingTongJiDiHeroChoseUI:gc_update_select_role()
    if not self.ui then return end;

    self.playerVs = self.dataCenter:GetPlayerVs()
    self:UpdateUi()
end

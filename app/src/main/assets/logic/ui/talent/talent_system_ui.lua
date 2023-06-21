
TalentSystemUI = Class("TalentSystemUI", UiBaseClass)

local _UIText = {
    ["not_need_reset"] = "当前不需要重置！",
    ["reset_success_info"] = "成功重置天赋点数！",
    ["talent_tree_consume_info"] = "%s天赋已投入",
    ["unlock_condition_info"] = "[00FF73]解锁条件：[-][A2A2E2]1.战队%s级  2.前一天赋树主线投入%s点[-]",
}

function TalentSystemUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/talent/ui_4501_gift.assetbundle"
	UiBaseClass.Init(self, data);
end

function TalentSystemUI:ShowNavigationBar()
    return true
end

function TalentSystemUI:Show()
    UiBaseClass.Show(self)
    self:SetFxHuman(false)
    self.fxComprehend:set_active(false)
    self:UpdateUI()
end

function TalentSystemUI:InitData(data)
    UiBaseClass.InitData(self, data)   
    self.tSystem = g_dataCenter.talentSystem
    self.yekaList = {
        [1] = {treeId = ENUM.TalentTreeID.Comprehend, spLock = nil, spIcon = nil, spTip = nil, unlockEffects = nil, toggle = nil},
        [2] = {treeId = ENUM.TalentTreeID.DeepRepair, spLock = nil, spIcon = nil, spTip = nil, unlockEffects = nil, toggle = nil},
        [3] = {treeId = ENUM.TalentTreeID.Master, spLock = nil, spIcon = nil, spTip = nil, unlockEffects = nil, toggle = nil},
    }
    self.talentUi = {
        [1] = {treeId = ENUM.TalentTreeID.Comprehend, spName = "sp_human_lingwu", rowNum = 2, obj = nil, root = nil, map = nil},
        [2] = {treeId = ENUM.TalentTreeID.DeepRepair, spName = "sp_human_shenxiu", rowNum = 3, obj = nil, root = nil, map = nil},
        [3] = {treeId = ENUM.TalentTreeID.Master, spName = "sp_human_jingtong", rowNum = 3, obj = nil, root = nil, map = nil},
    }
    self._TipEnum = {
        [ENUM.TalentTreeID.Comprehend] = Gt_Enum.EMain_BattleTeam_TalentSystem_Comprehend,
        [ENUM.TalentTreeID.DeepRepair] = Gt_Enum.EMain_BattleTeam_TalentSystem_DeepRepair,
        [ENUM.TalentTreeID.Master] = Gt_Enum.EMain_BattleTeam_TalentSystem_Master,
    }
    self.proBgCfg = {
        [ENUM.TalentTreeID.Comprehend] = {
            {nodeName = 'weiba1', animatorName = "ui_4501_gift_weiba1"},
            {nodeName = 'weiba2', animatorName = "ui_4501_gift_weiba2"},
        },
        [ENUM.TalentTreeID.DeepRepair] = {
            {nodeName = 'weiba3', animatorName = "ui_4501_gift_weiba3"},
            {nodeName = 'weiba4', animatorName = "ui_4501_gift_weiba4"},
            {nodeName = 'weiba5', animatorName = "ui_4501_gift_weiba5"},
        },
        [ENUM.TalentTreeID.Master] = {
            {nodeName = 'weiba6', animatorName = "ui_4501_gift_weiba6"},
            {nodeName = 'weiba7', animatorName = "ui_4501_gift_weiba7"},
            {nodeName = 'weiba8', animatorName = "ui_4501_gift_weiba8"},
        },
    }
    self.yekaTreeId = {
        ["yeka1"] = ENUM.TalentTreeID.Comprehend,
        ["yeka2"] = ENUM.TalentTreeID.DeepRepair,
        ["yeka3"] = ENUM.TalentTreeID.Master,
    }
end

function TalentSystemUI:DestroyUi()
    --[[if self.textBg then
        self.textBg:Destroy()
        self.textBg = nil
    end]]

    if self.clsInfoUi then
        self.clsInfoUi:DestroyUi()
        self.clsInfoUi = nil
    end
    
    for _, ui in pairs(self.talentUi) do
        if ui.root.texture then
            ui.root.texture:Destroy()
            ui.root.texture = nil
        end
        for _, v in pairs(ui.map) do
            for _, vv in pairs(v) do       
                if  vv.texture then
                    vv.texture:Destroy()
                    vv.texture = nil
                end
            end
        end
    end
    UiBaseClass.DestroyUi(self)
end

function TalentSystemUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_select_tab"] = Utility.bind_callback(self, self.on_select_tab) 
    self.bindfunc["reset_success"] = Utility.bind_callback(self, self.reset_success)
    self.bindfunc["on_click_talent"] = Utility.bind_callback(self, self.on_click_talent)
	self.bindfunc["on_reset_message"] = Utility.bind_callback(self, self.on_reset_message) 
    self.bindfunc["on_talent_point_add"] = Utility.bind_callback(self, self.on_talent_point_add) 
    self.bindfunc["gc_talent_upgrade"] = Utility.bind_callback(self, self.gc_talent_upgrade) 
    self.bindfunc["after_close_upgrade_ui"] = Utility.bind_callback(self, self.after_close_upgrade_ui)
    self.bindfunc["on_texture_loaded"] = Utility.bind_callback(self, self.on_texture_loaded)
    self.bindfunc["set_comprehend_node"] = Utility.bind_callback(self, self.set_comprehend_node)
end

--注册消息分发回调函数
function TalentSystemUI:MsgRegist()
	UiBaseClass.MsgRegist(self)    
    PublicFunc.msg_regist(msg_talent.gc_talent_upgrade, self.bindfunc['gc_talent_upgrade']) 
    PublicFunc.msg_regist(msg_talent.gc_reset_talent, self.bindfunc['reset_success']) 
    PublicFunc.msg_regist("talent_system_after_close_upgrade_ui", self.bindfunc['after_close_upgrade_ui']) 
end

--注销消息分发回调函数
function TalentSystemUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_talent.gc_talent_upgrade, self.bindfunc['gc_talent_upgrade'])   
    PublicFunc.msg_unregist(msg_talent.gc_reset_talent, self.bindfunc['reset_success'])   
    PublicFunc.msg_unregist("talent_system_after_close_upgrade_ui", self.bindfunc['after_close_upgrade_ui']) 
end

function TalentSystemUI:Restart(data)
    self.allTalentStatus = {}
    self.showUnlockedEffects = {}

    self.currTreeId = ENUM.TalentTreeID.Comprehend
    UiBaseClass.Restart(self, data)
end

function TalentSystemUI:gc_talent_upgrade()
    self.needUp = true 
    self:UpdateUI()
end

function TalentSystemUI:after_close_upgrade_ui()
    if not self.needUp then
        return
    end
    self.needUp = false
    for _, v in pairs(self.showUnlockedEffects) do
        v:set_active(false)
        v:set_active(true)
    end
    self.showUnlockedEffects = {}
end

--初始化UI
function TalentSystemUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)	
	self.ui:set_name("talent_system_ui")  

    local aniPath = "centre_other/animation/" 

    --self.textBg = ngui.find_texture(self.ui, aniPath .. "Texture")
    --self.textBg:set_texture(ENUM.PublicBgImage.DLD)

    --页卡
    for k, v in pairs(self.yekaList) do
        local objYeka = self.ui:get_child_by_name(aniPath .. "yeka/yeka" .. k)
        v.spLock = ngui.find_sprite(objYeka, "sp_lock")
        v.spLock:set_active(false)

        v.spIcon = ngui.find_sprite(objYeka, "sp_bg/sp_icon")
        v.spBg = ngui.find_sprite(objYeka, "sp_bg")
        v.lblOrgiName = ngui.find_label(objYeka, "lab")

        v.spSelectIcon = ngui.find_sprite(objYeka, "cont_select/sp_icon")
        --v.spTip = ngui.find_sprite(objYeka, "sp_point")

        v.unlockEffects = objYeka:get_child_by_name("fx_ui_4501_gift_jiesuo")
        v.unlockEffects:set_active(false)

        local treeData = ConfigManager.Get(EConfigIndex.t_talent_tree, v.treeId)
        v.lblName = ngui.find_label(objYeka, "cont_select/lab")    
        v.lblName:set_text(treeData.name)   
        
        v.toggle = ngui.find_toggle(self.ui, aniPath .. "yeka/yeka" .. k)
        --v.toggle:set_name(tostring(v.treeId))
        v.toggle:set_on_change(self.bindfunc['on_select_tab'])    
    end  

    local cloneObj = self.ui:get_child_by_name(aniPath .. "ke_long")
    cloneObj:set_active(false)

    for _, v in pairs(self.talentUi) do
        local treePath = aniPath .. v.spName .. "/"
        v.obj = self.ui:get_child_by_name(treePath)
        --天赋根
        local objRoot = self.ui:get_child_by_name(treePath .. "item")  
        v.root = self:CloneTalentUi(cloneObj, objRoot)
        local btnTal = ngui.find_button(objRoot, "ke_long")
        btnTal:set_event_value(tostring(0), 0) 
        btnTal:set_on_click(self.bindfunc["on_click_talent"])

        --天赋ui
        local _map = {}
        for row = 1, v.rowNum do 
            _map[row] = {}
            for col = 1, 4 do 
                local obj = self.ui:get_child_by_name(treePath .. "cont" .. row .."/item" .. col)
                _map[row][col] = self:CloneTalentUi(cloneObj, obj)     
                --点击事件
                local btn = ngui.find_button(obj, "ke_long")
                btn:set_event_value(tostring(row), col) 
                btn:set_on_click(self.bindfunc["on_click_talent"])
            end
        end
        v.map = _map

    end

    local downPath = "down_other/animiation/" 

    --天赋点货币
    self.lblTalentPointCnt = ngui.find_label(self.ui, downPath .. "sp_bk/lab")
    local btnTalentPointAdd = ngui.find_button(self.ui, downPath .. "sp_bk/btn")
    btnTalentPointAdd:set_on_click(self.bindfunc["on_talent_point_add"])

    --重置天赋
    self.btnReset = ngui.find_button(self.ui, downPath .. "btn")
    self.btnReset:set_on_click(self.bindfunc["on_reset_message"])

    --self.spTreeName = ngui.find_sprite(self.ui, downPath .. "sp_tips/sp_art_font")
    --self.lblTreeDesc = ngui.find_label(self.ui, downPath .. "sp_tips/lab")
    self.lblConsumeInfo = ngui.find_label(self.ui, downPath .. "sp_tianfushu/txt")
    self.lblConsumeCnt = ngui.find_label(self.ui, downPath .. "sp_tianfushu/lab_num")

    self.objCondition = self.ui:get_child_by_name(downPath .. "sp_condition_di")  
    self.lblCondition = ngui.find_label(self.ui, downPath .. "sp_condition_di/lab_describe")

    self.proBgInfo = {}
    for k, v in pairs(self.proBgCfg) do
        for _, vv in pairs(v) do
            local _node = self.ui:get_child_by_name(vv.nodeName)
            local _hashName = asset_game_object.animator_string_to_hash(vv.animatorName)
            self.proBgInfo[vv.nodeName] = {
                node = _node,
                hashName = _hashName,
                animatorName = vv.animatorName,
            }
        end
    end

    self.fxHuman1 = self.ui:get_child_by_name(aniPath .. "texture_bg/fx_ui_4501_eye")
    self.fxHuman2 = self.ui:get_child_by_name(aniPath .. "texture_bg/fx_ui_4501_jiesuo2")
    self:SetFxHuman(false)
    self.fxComprehend =  self.ui:get_child_by_name(aniPath .. "sp_human_lingwu/fx_ui_4501_gift_show1")
    self.objComprehend = {
        [1] = self.ui:get_child_by_name(aniPath .. "sp_human_lingwu/item"),
        [2] = self.ui:get_child_by_name(aniPath .. "sp_human_lingwu/cont1"),
        [3] = self.ui:get_child_by_name(aniPath .. "sp_human_lingwu/cont2"),
    }

    self:UpdateUI()
    self:PlayComprehendEffect()
end

function TalentSystemUI:SetFxHuman(v)
    self.fxHuman1:set_active(v)
    self.fxHuman2:set_active(v)
end

function TalentSystemUI:CloneTalentUi(cloneObj, parentObj)
    local obj = cloneObj:clone()
    obj:set_parent(parentObj)
    obj:set_local_position(0, 0, 0)
    obj:set_name("ke_long")
    obj:set_active(true)
    --等级
    local _spLevel = ngui.find_sprite(obj, "sp_di")
    local _lblLevel = ngui.find_label(obj, "sp_di/lab_num")
    --满级
    local _spTopLevel = ngui.find_sprite(obj, "sp_manji")

    --加锁
    local _spLock = ngui.find_sprite(obj, "sp_clock")
    --icon
    local _texture = ngui.find_texture(obj, "texture_gift")
    --外框
    local _spEffect = ngui.find_sprite(obj, "sp_effect")

    local _unlockEffects = obj:get_child_by_name("fx_ui_4501_gift_jiesuo")
    local _levelupEffects = obj:get_child_by_name("fx_ui_4501_gift_keshengji")

    local _objAni = obj:get_child_by_name("animation")

    local ui = {
        obj = obj,
        spLevel = _spLevel,
        spTopLevel = _spTopLevel,

        lblLevel = _lblLevel,
        lock = _spLock,
        texture = _texture,
        spEffect = _spEffect,
        unlockEffects = _unlockEffects,
        levelupEffects = _levelupEffects,
        objAni = _objAni,
    }
    return ui
end

function TalentSystemUI:PlayComprehendEffect()
    self.fxComprehend:set_active(false)
    self.fxComprehend:set_active(true)
    self:set_comprehend_node(false)
    TimerManager.Add(self.bindfunc["set_comprehend_node"], 1000, 1, true)
end

function TalentSystemUI:set_comprehend_node(value)
    for k, v in pairs(self.objComprehend) do
        v:set_active(value)
    end
end

--[[天赋树切换]]
function TalentSystemUI:on_select_tab(value, name)
    if value then
        if self.yekaTreeId[name] ~= self.currTreeId then
            --app.log('---->currTreeId = ' .. id)
            self.currTreeId = self.yekaTreeId[name]
            self:UpdateUI()
            self:SetFxHuman(false)
            self:SetFxHuman(true)
            self.fxComprehend:set_active(false)
        end
    end
end

--[[重置成功]]
function TalentSystemUI:reset_success()
    self.allTalentStatus = {}
    self.showUnlockedEffects = {}

    self.yekaList[1].toggle:set_value(true)
    --必须手动刷新， 状态可能为Gt_Enum_Wait_Notice.Invalid
    for k, v in pairs(self.yekaList) do
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, self._TipEnum[v.treeId])
    end
    self:UpdateUI()
    FloatTip.Float(_UIText["reset_success_info"])
end

function TalentSystemUI:UpdateUI()
	--天赋树
    self:UpdateTalentTree()
    --天赋节点
    self:UpdateAllTalentInfo()
    --
    local totalPoint = self.tSystem:GetTotalConsumeTP()
    if totalPoint == 0 then
        PublicFunc.SetButtonShowMode(self.btnReset, 3, 'sprite_background')
    else
        PublicFunc.SetButtonShowMode(self.btnReset, 1, 'sprite_background')
    end
    --背景进度
    local pro = self:GetCurrTalentTreeProgress()
    for k, v in pairs(self.proBgCfg[self.currTreeId]) do
        local info = self.proBgInfo[v.nodeName]
        info.node:animator_play_use_hash_name(info.hashName, 0,  pro[k] / 5)
    end
end

function TalentSystemUI.OnOver(obj)
    local name = obj:get_name()
    local scene = uiManager:GetCurScene()
    local info = scene.proBgInfo[name]
    if info == nil then
        return
    end
    info.node:set_animator_speed(info.animatorName, 0)
end

function TalentSystemUI:GetCurrTalentTreeProgress()
    local pro = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }
    for _, ui in pairs(self.talentUi) do
        if ui.treeId == self.currTreeId then
            local data = self.tSystem:GetTalentMap(self.currTreeId)
            --天赋根
            local progress = self:ProcessTalentProgress(data.rootId)
            if progress == 0 then
                return pro
            else
                for i = 1, 3 do
                    pro[i] = progress
                end
            end
            --天赋其它
            for row, v in pairs(ui.map) do
                for col, vv in pairs(v) do
                    local id = nil
                    if data.mapIds[row] then
                        id = data.mapIds[row][col]
                    end
                    if id ~= nil then
                        local progress = self:ProcessTalentProgress(id)
                        pro[row] = pro[row] + progress
                        --其它还未解锁
                        if progress == 0 then
                            break
                        end
                    end
                end
            end
        end
    end
    return pro
end

function TalentSystemUI:ProcessTalentProgress(talentId)
    local data = self.tSystem:GetTalentBriefInfo(talentId)
    if data.status == ENUM.TalentStatus.Lock then
        return 0
    end
    return 1
end


local _TreeSpName = {
    [ENUM.TalentTreeID.Comprehend] = "yxtf_lingwu",
    [ENUM.TalentTreeID.DeepRepair] = "yxtf_shenxiu",
    [ENUM.TalentTreeID.Master] = "yxtf_jingtong",
}

--[[刷新天赋树]]
function TalentSystemUI:UpdateTalentTree()
    for k, v in pairs(self.yekaList) do
        local activated = self.tSystem:TalentTreeActivated(v.treeId)
        if activated then
            PublicFunc.SetUISpriteWhite(v.spBg)
            v.lblOrgiName:set_effect_type(2)

            --蓝色
            PublicFunc.SetUISpriteWhite(v.spIcon)
            --v.spLock:set_active(false)
            --v.spIcon:set_active(true)
            --v.spSelectIcon:set_active(true)
        else
            PublicFunc.SetUISpriteGray(v.spBg)
            --PublicFunc.SetUISpriteGray(v.spLock)
            v.lblOrgiName:set_effect_type(0)

            --灰色+加锁
            PublicFunc.SetUISpriteGray(v.spIcon)

            --v.spLock:set_active(true)
            --v.spIcon:set_active(false)
            --v.spSelectIcon:set_active(false)
        end

        --名字描边(选中)
       --[[ if v.treeId == self.currTreeId then
            --794616
            PublicFunc.SetUiLabelEffectColor(v.lblName, 122/255, 70/255, 22/255, 1)
        else
            if activated then
                PublicFunc.SetUILabelEffectBlue(v.lblName)
            else
                PublicFunc.SetUILabelEffectGray(v.lblName)
            end
        end ]]

        v.unlockEffects:set_active(false)

        if self.allTalentStatus[v.treeId] == nil then
            self.allTalentStatus[v.treeId] = {
                [v.treeId] = activated
            }
        else
            --解锁
            if self.allTalentStatus[v.treeId][v.treeId] == false and activated then
                self.allTalentStatus[v.treeId][v.treeId] = true
                self.showUnlockedEffects[v.treeId] = v.unlockEffects
                GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, self._TipEnum[v.treeId])
            end
        end
    end

    local config = ConfigManager.Get(EConfigIndex.t_talent_tree, self.currTreeId)
    --self.lblTreeName:set_text(config.name)
    --self.lblTreeDesc:set_text(config.des)
    --self.spTreeName:set_sprite_name(_TreeSpName[self.currTreeId])

    --消耗
    local point = self.tSystem:GetConsumeTP(self.currTreeId)
    self.lblConsumeInfo:set_text(string.format(_UIText["talent_tree_consume_info"], config.name))
    self.lblConsumeCnt:set_text(tostring(point))

    --天赋点货币
    local cnt = PropsEnum.GetValue(IdConfig.TalentPoint)
    self.lblTalentPointCnt:set_text(tostring(cnt))

    --解锁条件
    self.objCondition:set_active(false)
    if not self.tSystem:TalentTreeActivated(self.currTreeId) then
        self.objCondition:set_active(true)
        self.lblCondition:set_text(string.format(_UIText["unlock_condition_info"], config.level, config.last_add))
    end
end

--[[刷新所有天赋节点]]
function TalentSystemUI:UpdateAllTalentInfo()
    for _, ui in pairs(self.talentUi) do
        if ui.treeId == self.currTreeId then
            ui.obj:set_active(true)
            local data = self.tSystem:GetTalentMap(self.currTreeId)
            --天赋根
            self:UpdateSingleTalentInfo(data.rootId, ui.root, true)
            --天赋其它
            for row, v in pairs(ui.map) do
                for col, vv in pairs(v) do
                    local id = nil
                    if data.mapIds[row] then
                        id = data.mapIds[row][col]
                    end
                    if id ~= nil then
                        vv.obj:set_active(false)
                        self:UpdateSingleTalentInfo(id, vv)

                    --无数据时，隐藏
                    else
                        vv.obj:set_active(false)
                    end
                end
            end
        else
            ui.obj:set_active(false)
        end
    end
end

--[[刷新天赋节点]]
function TalentSystemUI:UpdateSingleTalentInfo(talentId, ui, isRoot)
    local data = self.tSystem:GetTalentBriefInfo(talentId)

    ui.lock:set_active(false)
    --ui.texture:set_color(1, 1, 1, 1)
    --ui.spEffect:set_active(isRoot == true)

    ui.texture:set_callback(self.bindfunc["on_texture_loaded"], ui.obj)
    ui.texture:set_texture(data.icon)
    ui.texture:set_active(true)

    ui.spLevel:set_active(true)
    ui.spTopLevel:set_active(false)

    ui.unlockEffects:set_active(false)
    ui.levelupEffects:set_active(false)

    if data.status == ENUM.TalentStatus.Lock then
        ui.lock:set_active(true)
        --ui.texture:set_color(0, 0, 0, 1)
        ui.texture:set_active(false)
        ui.spLevel:set_active(false)
    elseif data.status == ENUM.TalentStatus.Unlocked then
        ui.lblLevel:set_text(data.level .. "/" .. data.maxLevel)
    elseif data.status == ENUM.TalentStatus.TopLevel then
        ui.spLevel:set_active(false)
        ui.spTopLevel:set_active(true)
        --ui.lblLevel:set_text("[ffc600]" .. data.level .. "/" .. data.maxLevel .. "[-]")
    elseif data.status == ENUM.TalentStatus.LevelUp then
        ui.lblLevel:set_text("[00ff84]" ..data.level .. "/" .. data.maxLevel .. "[-]")
        ui.levelupEffects:set_active(true)
    end

    local treeId = self.tSystem:GetTreeId(talentId)
    local _status = self.allTalentStatus[treeId][talentId]
    if _status == nil then
        self.allTalentStatus[treeId][talentId] = data.status
    else
        --解锁
        if _status == ENUM.TalentStatus.Lock and data.status == ENUM.TalentStatus.Unlocked  then
            self.allTalentStatus[treeId][talentId] = ENUM.TalentStatus.Unlocked
            self.showUnlockedEffects[talentId] = ui.unlockEffects
        end
    end
end

function TalentSystemUI:on_texture_loaded(obj)
    if obj then
        obj:set_active(true)
    end
end

--[[重置天赋]]
function TalentSystemUI:on_reset_message()
	--查询天赋点
    local totalPoint = self.tSystem:GetTotalConsumeTP()
    if totalPoint == 0 then
        FloatTip.Float(_UIText["not_need_reset"])
        return
    end
    if self.clsInfoUi == nil then
        self.clsInfoUi = TalentInfoUI:new({showTalentUI = false, talentId = nil})
    else
        self.clsInfoUi:PopupResetUi()
    end
    self.clsInfoUi:Show()
end

--[[点击天赋]]
function TalentSystemUI:on_click_talent(t)
    local row = tonumber(t.string_value)
    local col = t.float_value
    local data = self.tSystem:GetTalentMap(self.currTreeId)
    local id = nil
    if row == 0 and col == 0 then
        id = data.rootId
    else
        id = data.mapIds[row][col]
    end

    self.needUp = false
    if self.clsInfoUi == nil then
        self.clsInfoUi = TalentInfoUI:new({showTalentUI = true, talentId = id})
        self.clsInfoUi:Show()
    else
        self.clsInfoUi:Show()
        self.clsInfoUi:UpdateInfo(id)
    end
end

function TalentSystemUI:on_talent_point_add(t)
    local temp = {}
    temp.item_id = IdConfig.TalentPoint
    temp.number = 1
    AcquiringWayUi.Start(temp)
end

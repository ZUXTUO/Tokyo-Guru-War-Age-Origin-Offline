
TalentInfoUI = Class("TalentInfoUI", UiBaseClass)

local _UIText = {
    ["reset_talent"] = "重置",
    ["reset_talent_info"] = "重置后返还[00FF73] %s [-]点天赋点及[00FF73] %s [-]金币消耗",
    ["lack_of_crystal"] = "钻石不足！",    
    ["talent_upgrade"] = "升级",  
    ["condition_tree_unlock"] = "[ffffff]所属天赋树解锁[-]", 
    ["condition_player_level"] = "[%s]战队等级达到%s级[-]",  
    ["condition_last_talent_level"] = "[%s]%s达到%s级(%s/%s)[-]",
    ["level_info"] = "等级%s",
    ["up_all_hero"] = "提升所有英雄",
    ["curr_all_hero"] = "所有英雄",
    ["max_hp"] = "生命",
    ["atk_power"] = "攻击",
    ["def_power"] = "防御",
    ["crit_rate"] = "暴击率",
    ["anti_crite"] = "免爆率",
    ["crit_hurt"] = "暴伤加成",
    ["broken_rate"] = "破击率",    
    ["parry_rate"] = "格挡率",
    ["parry_plus"] = "格挡伤害",    
    ["bloodsuck_rate"] = "吸血率",  
    ["dodge_rate"] = "闪避率",  
    ["cool_down_dec"] = "技能冷却缩减",  

    ["desc_up_0"] = "提升所有角色",    
    ["desc_curr_0"] = "所有角色提升", 
    ["desc_up_1"] = "提升\"攻\"类型角色",    
    ["desc_curr_1"] = "\"攻\"类型角色提升", 
    ["desc_up_2"] = "提升\"防\"类型角色",    
    ["desc_curr_2"] = "\"防\"类型角色提升", 
    ["desc_up_3"] = "提升\"技\"类型角色",    
    ["desc_curr_3"] = "\"技\"类型角色提升", 

    ["level_up_txt"] = "升级",    
    ["cancel_txt"] = "取消", 
    ["and_txt"] = "和", 
    [1] = "天赋点不足", 
    [2] = "金币不足", 
    [3] = "%s提升%s",
    [4] = "等级: ",    
    ["unlock_condition_info"] = "[%s]前一天赋树主线投入%s点",
    [5] = "【未开启】",
}

local _Status = {
    TalentReset = 1,
    TreeLock = 2,
    Lock = 3,
    LevelUp = 4,
}

function TalentInfoUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/talent/ui_4502_gift.assetbundle"
	UiBaseClass.Init(self, data);
end

function TalentInfoUI:InitData(data)
	UiBaseClass.InitData(self, data)   
    self.tSystem = g_dataCenter.talentSystem 

    self.talentId = data.talentId
    self.showTalentUI = data.showTalentUI

    self.status = nil
end

function TalentInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self)    
    if self.textHead then
        self.textHead:Destroy()
        self.textHead = nil
    end
end

function TalentInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)  
    self.bindfunc["level_up"] = Utility.bind_callback(self, self.level_up) 
    self.bindfunc["level_up_success"] = Utility.bind_callback(self, self.level_up_success)     
    self.bindfunc["on_reset_confirm"] = Utility.bind_callback(self, self.on_reset_confirm)     
end

--注册消息分发回调函数
function TalentInfoUI:MsgRegist()
	UiBaseClass.MsgRegist(self)    
    PublicFunc.msg_regist(msg_talent.gc_talent_upgrade, self.bindfunc['level_up_success'])
end

--注销消息分发回调函数
function TalentInfoUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_talent.gc_talent_upgrade, self.bindfunc['level_up_success'])
end

function TalentInfoUI:on_close()
	self:Hide()
    PublicFunc.msg_dispatch("talent_system_after_close_upgrade_ui") 
end

--初始化UI
function TalentInfoUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)	
	self.ui:set_name("talent_info_ui")

    local path = "centre_other/animation/"

    self.lblTitle = ngui.find_label(self.ui, path .."content_di_754_458/lab_title/lab_title2")
    self.posX, self.posY, self.posZ = self.ui:get_child_by_name(path .. "content1/cont3"):get_position() 
    self.spWindowBg = ngui.find_sprite(self.ui, path .. "content_di_754_458/sp_di")
    self.spWindowBg:set_sprite_name("ty_tanchuang4")
     
    local btnClose = ngui.find_button(self.ui, path .."content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])    

    self.objTalent = self.ui:get_child_by_name(path .. "content1") 
    self.objReset = self.ui:get_child_by_name(path .. "content2")     
     
    ---------------重置ui---------------
    
    --local textCrystal = ngui.find_texture(self.ui, path .. "content2/sp_bk/sp")
    --PublicFunc.SetItemTexture(textCrystal, IdConfig.Crystal)
    self.lblConsumeCrystal = ngui.find_label(self.ui, path .. "content2/sp_bk/lab")
    self.lblResetDesc = ngui.find_label(self.ui, path .. "content2/lab")

    --[[local btnResetCancel = ngui.find_button(self.ui, path .. "content2/btn_left")
    btnResetCancel:set_on_click(self.bindfunc["on_close"])
    local lblResetCancel = ngui.find_label(self.ui, path .. "content2/btn_left/animation/lab")
    lblResetCancel:set_text(_UIText["cancel_txt"])]]

    local btnResetConfirm = ngui.find_button(self.ui, path .. "content2/btn_right")
    btnResetConfirm:set_on_click(self.bindfunc["on_reset_confirm"])

    ---------------天赋ui--------------- 
    --icon
    self.textHead = ngui.find_texture(self.ui, path .. "content1/sp_bk/sp_gift")
    --name
    self.lblName = ngui.find_label(self.ui, path .. "content1/cont1/lab_name")
    self.lblDesc = ngui.find_label(self.ui, path .. "content1/cont1/lab_describe")

    self.lblNameUnlock = ngui.find_label(self.ui, path .. "content1/cont2/lab_name")
    self.lblDescUnlock = ngui.find_label(self.ui, path .. "content1/cont2/txt_describe")

    --level
    self.lblLevel = ngui.find_label(self.ui, path .. "content1/cont1/lab_level")
    --not open
    --self.lblOpen = ngui.find_label(self.ui, path .. "content1/cont_m/txt_open")

    self.objLevelUpUI = self.ui:get_child_by_name(path .. "content1/cont1")
    self.objUnlockUI = self.ui:get_child_by_name(path .. "content1/cont2")
    
    --提升描述
    local proPath = {"sp_attack_bk", "sp_defense_bk", "sp_life_bk"}
    self.propertyInfo = {}
    self.topPropertyInfo = {}
    for i = 1, 3 do
        local __pp = path .. "content1/cont1/" .. proPath[i]
        self.propertyInfo[i] ={
            obj = self.ui:get_child_by_name(__pp),
            lblName = ngui.find_label(self.ui, __pp .. '/txt'),
            objContent = self.ui:get_child_by_name(__pp .. '/content'),
            lblNum1 = ngui.find_label(self.ui, __pp .. '/content/lab_num1'),
            lblNum2 = ngui.find_label(self.ui, __pp .. '/content/lab_num2'),
            lblNum = ngui.find_label(self.ui, __pp .. '/lab_num'),
        }
        __pp = path .. "content1/cont1/nature" .. i
        self.topPropertyInfo[i] ={
            obj = self.ui:get_child_by_name(__pp),
            lblName = ngui.find_label(self.ui, __pp .. '/txt'),
            lblNum = ngui.find_label(self.ui, __pp .. '/lab_num'),
        }
    end
 
     --升级消耗(金币, 天赋点)
    self.objConsume = self.ui:get_child_by_name(path .. "content1/cont1/content1")

    --开赋点
    self.lblTalentPoint = ngui.find_label(self.objConsume, "txt_xiaohao/sp_tianfudian/lab_num")
    --金币
    self.lblGold =  ngui.find_label(self.objConsume, "txt_xiaohao/sp_gold/lab_num")

    self.btnLevelUp = ngui.find_button(self.objConsume, "btn")
    self.btnLevelUp:set_on_click(self.bindfunc["level_up"], "MyButton.NoneAudio")
    local lblLevelUp = ngui.find_label(self.objConsume, "btn/animation/sprite_background/lab")
    lblLevelUp:set_text(_UIText["level_up_txt"])

    --达满级
    self.objTopLevel = self.ui:get_child_by_name(path .. "content1/cont1/content2")
    self.topLevelEffects = self.ui:get_child_by_name(path .. "content1/cont1/content2/sp_art_font/fx_ui_604_4_dingji")

    --升级特效
    --self.objAnimation = self.ui:get_child_by_name(path .. "content1/cont3")
    --开启条件

    self.lblCondition = ngui.find_label(self.ui, path .. "content1/cont2/content/lab")

    if self.showTalentUI then
        self:UpdateInfo(self.talentId)
    else
        self:PopupResetUi()
    end    
end

function TalentInfoUI:UpdateUI(flag)
    self.objReset:set_active(false)
    self.objTalent:set_active(true)
    self.spWindowBg:set_sprite_name("ty_tanchuang4")

    self.lblTitle:set_text(_UIText["talent_upgrade"])
    local talInfo = self.tSystem:GetTalentInfo(self.talentId) 
    self.textHead:set_texture(talInfo.icon)
    
    self.objLevelUpUI:set_active(false)
    self.objUnlockUI:set_active(false)

    local upDesc = self:GetUpDesc(talInfo)
    if talInfo.level ~= nil then
        self.objLevelUpUI:set_active(true)
        
        self.lblName:set_text(talInfo.name)
        self.lblDesc:set_text(upDesc)
        self.lblLevel:set_text(PublicFunc.GetColorText(_UIText[4], "orange_yellow") 
            .. talInfo.level .. "/" .. talInfo.maxLevel)
    else
        self.objUnlockUI:set_active(true)

         self.lblNameUnlock:set_text(talInfo.name .. '  ' .. _UIText[5])
         self.lblDescUnlock:set_text(upDesc)
    end    

    self.objTopLevel:set_active(false)
    self.topLevelEffects:set_active(false)
    self.objConsume:set_active(false)

    --self.objAnimation:set_active(false)

    if self.status == _Status.TreeLock then
        self.spWindowBg:set_sprite_name("ty_tanchuang7")
        local treeId = self.tSystem:GetTreeId(self.talentId) 
        local config = ConfigManager.Get(EConfigIndex.t_talent_tree, treeId)
         --绿色
        local color = "new_green"
        if g_dataCenter.player.level < config.level then
            color = "new_purple"
        end
        local _txt = string.format(_UIText["condition_player_level"], PublicFunc.GetPreColor(color), config.level)
        color = "new_green"
        local point = self.tSystem:GetConsumeTP(treeId)
        if point < config.last_add then
            color = "new_purple"
        end
        _txt = _txt .. '\n' .. string.format(_UIText["unlock_condition_info"], PublicFunc.GetPreColor(color), config.last_add)
        self.lblCondition:set_text(_txt)

    elseif self.status == _Status.Lock then
        --绿色
        local colorLevelInfo = "new_green"
        if talInfo.needPlayerLevel > g_dataCenter.player.level then
            colorLevelInfo = "new_purple"
        end
        local _txt = string.format(_UIText["condition_player_level"], PublicFunc.GetPreColor(colorLevelInfo), talInfo.needPlayerLevel)
        --根结点无上一天赋信息
        if talInfo.lastLevel ~= nil then
            local colorTalentInfo = "new_green"
            if talInfo.needLastLevel > talInfo.lastLevel then
                colorTalentInfo = "new_purple"
            end
            _txt = _txt .. '\n' .. string.format(_UIText["condition_last_talent_level"], 
                PublicFunc.GetPreColor(colorTalentInfo), talInfo.lastName, talInfo.needLastLevel, talInfo.lastLevel, talInfo.needLastLevel)
        end
        self.lblCondition:set_text(_txt)

    elseif self.status == _Status.LevelUp then
        for _, v in pairs(self.propertyInfo) do
            v.obj:set_active(false)
        end
        for _, v in pairs(self.topPropertyInfo) do
            v.obj:set_active(false)
        end
        local data = self:GetCurrProps(talInfo)
        for k, v in pairs(data) do
            local ui = self.propertyInfo[k]
            local topUi = self.topPropertyInfo[k]
            if ui then
                if v.nextValue ~= nil then
                    ui.obj:set_active(true)
                    ui.lblNum:set_active(false)

                    ui.lblName:set_text(_UIText[v.key])
                    ui.lblNum1:set_text(tostring(v.currValue))
                    ui.lblNum2:set_text(tostring(v.nextValue))
                else
                    topUi.obj:set_active(true)
                    topUi.lblName:set_text(_UIText[v.key])
                    topUi.lblNum:set_text(tostring(v.currValue))
                end
            end
        end

        --达满级
        if talInfo.level == talInfo.maxLevel then
            self.objTopLevel:set_active(true)
            self.spWindowBg:set_sprite_name("ty_tanchuang7")
            if flag then
                self.topLevelEffects:set_active(false)
                self.topLevelEffects:set_active(true)
            end
            return
        end

        self.objConsume:set_active(true)     

        --金币不足
        self.lackGold = false
        local gold = talInfo.growConfig[talInfo.level].gold
        if gold > PropsEnum.GetValue(IdConfig.Gold) then 
            self.lackGold = true
            self.lblGold:set_text('[E54F4D]' .. gold .. '[-]')
        else
            self.lblGold:set_text('[DCDC8B]' .. gold .. '[-]')
        end
        --天赋点不足 
        self.lackTalentPoint = false
        local point = talInfo.growConfig[talInfo.level].talent_point    
        if point > PropsEnum.GetValue(IdConfig.TalentPoint) then 
            self.lackTalentPoint = true
            self.lblTalentPoint:set_text('[E54F4D]' .. point .. '[-]')
        else
            self.lblTalentPoint:set_text('[DCDC8B]' .. point .. '[-]')
        end 

        if self.lackGold or self.lackTalentPoint then   
            PublicFunc.SetButtonShowMode(self.btnLevelUp, 3, 'sprite_background') 
        else
            PublicFunc.SetButtonShowMode(self.btnLevelUp, 1, 'sprite_background')
        end
    end
end

function TalentInfoUI:GetUpDesc(talInfo)
    --已达满级
    if talInfo.level and talInfo.level == talInfo.maxLevel then
        --return ""
    end
    if talInfo.growConfig then     
        --默认等级0   
        local level = 0        
        if talInfo.level ~= nil then
            level = talInfo.level
        end
        local nextLevel = level + 1
        if level == talInfo.maxLevel then
            nextLevel = talInfo.maxLevel 
        end

        --app.log('---> up level' .. level)
        local descCont = {"max_hp", "atk_power", "def_power", "crit_rate", "anti_crite", "crit_hurt",
            "broken_rate", "parry_rate", "parry_plus", "bloodsuck_rate", "dodge_rate", "cool_down_dec"}
        local t = {}
        for _, v in pairs(descCont) do            
            if talInfo.growConfig[nextLevel] and talInfo.growConfig[nextLevel][v] ~= 0 then
                table.insert(t, _UIText[v])
            end
        end
        if t[1] and t[2] then
            return _UIText["desc_up_" .. tostring(talInfo.descType)] .. t[1] .. _UIText["and_txt"] .. t[2]
        elseif t[1] then
            return _UIText["desc_up_" .. tostring(talInfo.descType)] .. t[1]
        end
    end    
    return ""
end

function TalentInfoUI:GetCurrProps(talInfo)
    local t = {}
    if talInfo.growConfig then     
        --默认等级0  
        local level = 0        
        if talInfo.level ~= nil then
            level = talInfo.level
        end
        local nextLevel = level + 1
        --app.log('---> curr level' .. level)
        local descCont = {"max_hp", "atk_power", "def_power", "crit_rate", "anti_crite", "crit_hurt",
            "broken_rate", "parry_rate", "parry_plus", "bloodsuck_rate", "dodge_rate", "cool_down_dec"}

        self.currPropDesc = {}
        for _, v in pairs(descCont) do
            local _currValue = nil
            local _nextValue = nil
            if level == 0 and talInfo.growConfig[nextLevel][v] ~= 0 then
                _currValue = 0
            else
                if (talInfo.growConfig[level] and talInfo.growConfig[level][v] ~= 0) then
                    _currValue = PublicFunc.Round(talInfo.growConfig[level][v]) 
                end 
            end
            if talInfo.growConfig[nextLevel] and talInfo.growConfig[nextLevel][v] ~= 0 then 
                _nextValue = PublicFunc.Round(talInfo.growConfig[nextLevel][v])
            end
            if _currValue then
                table.insert(t, {key = v, currValue = _currValue, nextValue = _nextValue})
            end
            --提升属性
            if talInfo.growConfig[nextLevel] and talInfo.growConfig[nextLevel][v] ~= 0 then
                local diffValue = PublicFunc.Round(talInfo.growConfig[nextLevel][v] - talInfo.growConfig[level][v])
                table.insert(self.currPropDesc, string.format(_UIText[3], _UIText[v], diffValue))
            end 
        end
    end    
    return t
end

--[[开赋升级]]
function TalentInfoUI:level_up(t)
    if self.lackTalentPoint then 
        FloatTip.Float(_UIText[1])   
        return
    end
    if self.lackGold then
        FloatTip.Float(_UIText[2])      
        return
    end   
    msg_talent.cg_talent_upgrade(self.talentId)
end

function TalentInfoUI:level_up_success() 
    --提升动画
    for _, v in pairs(self.currPropDesc) do
        local data = {}
        data.str = v
        data.world_pos = {x = self.posX, y = self.posY, z = self.posZ}
        PopLabMgr.PushMsg(data)
    end   
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpNormal)
    self:UpdateUI(true)
end

function TalentInfoUI:SetInfo(talentId)
    self.talentId = talentId
    local treeId = self.tSystem:GetTreeId(talentId)
    --天赋树未解锁
    if not self.tSystem:TalentTreeActivated(treeId) then  
        self.status = _Status.TreeLock     
    --未激活
    elseif not self.tSystem:TalentActivated(talentId) then  
        self.status = _Status.Lock 
    --天赋升级
    else        
        self.status = _Status.LevelUp
    end
end

--[[天赋弹窗]]
function TalentInfoUI:UpdateInfo(id)
    self:SetInfo(id)
    self:UpdateUI()
end


--[[重置天赋弹窗]]
function TalentInfoUI:PopupResetUi()
    self.objReset:set_active(true)
    self.objTalent:set_active(false)
    self.spWindowBg:set_sprite_name("ty_tanchuang4")

    self.lblTitle:set_text(_UIText["reset_talent"])
    local totalPoint = self.tSystem:GetTotalConsumeTP()
    local crystal = self.tSystem:GetConsumeCrystal(totalPoint)    
    self.lblConsumeCrystal:set_text(tostring(crystal))

    local config = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_reset_talent_gold_fate)
    self.lblResetDesc:set_text(string.format(_UIText["reset_talent_info"], totalPoint, config.data .. "%"))
end

function TalentInfoUI:on_reset_confirm()
    local totalPoint = self.tSystem:GetTotalConsumeTP()
    local crystal = self.tSystem:GetConsumeCrystal(totalPoint)
    --检查钻石    
    if crystal > PropsEnum.GetValue(IdConfig.Crystal) then
        FloatTip.Float(_UIText["lack_of_crystal"])
        return
    end   
    self:Hide()
    msg_talent.cg_reset_talent()
end

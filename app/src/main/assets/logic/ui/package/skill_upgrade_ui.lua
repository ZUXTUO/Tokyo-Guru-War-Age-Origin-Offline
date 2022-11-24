SkillUpgradeUI = Class("SkillUpgradeUI", UiBaseClass);

function SkillUpgradeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_3801_skill_upgrade.assetbundle";
    UiBaseClass.Init(self, data);
end

function SkillUpgradeUI:Restart(data)
    if data then
        self.skillIndex = data.skillIndex;
        self.roleData = data.roleData;
    end
    if UiBaseClass.Restart(self, data) then
    end
end

function SkillUpgradeUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_close"] = Utility.bind_callback(self, SkillUpgradeUI.on_close);
    self.bindfunc["on_rule"] = Utility.bind_callback(self, SkillUpgradeUI.on_rule);
    self.bindfunc["on_skill_upgrade"] = Utility.bind_callback(self, SkillUpgradeUI.on_skill_upgrade);
    self.bindfunc["on_one_upgrade"] = Utility.bind_callback(self, SkillUpgradeUI.on_one_upgrade);
    self.bindfunc["gc_skill_level_up_rst"] = Utility.bind_callback(self, SkillUpgradeUI.gc_skill_level_up_rst);
end

--注册消息分发回调函数
function SkillUpgradeUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_skill_level_up_rst,self.bindfunc['gc_skill_level_up_rst']);
end

--注销消息分发回调函数
function SkillUpgradeUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_skill_level_up_rst,self.bindfunc['gc_skill_level_up_rst']);
end

function SkillUpgradeUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.control = {};
end

function SkillUpgradeUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    --先删除必要对象
    local skillInfo = self.control.skillInfo;
    if skillInfo.textureIcon then
        skillInfo.textureIcon:Destroy();
        skillInfo.textureIcon = nil;
    end
    -- self.skillIndex = nil;
    -- self.roleData = nil;
end

function SkillUpgradeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("SkillUpgradeUI");

    local btn = ngui.find_button(self.ui, "btn_fork");
    btn:set_on_click(self.bindfunc["on_close"]);
    btn = ngui.find_button(self.ui, "btn_prompt");
    btn:set_on_click(self.bindfunc["on_rule"]);


    local control = self.control;
    control.centre = {};
    local centre = control.centre;
    centre.objRoot = self.ui:get_child_by_name("centre_content");
    centre.labGold = ngui.find_label(centre.objRoot, "sp_bk1/lab");
    centre.labSkillBook = ngui.find_label(centre.objRoot, "sp_bk2/lab");
    centre.btnGold = ngui.find_button(centre.objRoot, "sp_bk1/sp_add");
    centre.btnGold:set_active(false);
    centre.btnSkillBook = ngui.find_button(centre.objRoot, "sp_bk2/sp_add");
    centre.btnSkillBook:set_active(false);
    --技能信息相关
    control.skillInfo = {};
    local skillInfo = control.skillInfo;
    skillInfo.labName = ngui.find_label(self.ui, "sp_di2/lab_skill");
    skillInfo.labDes = ngui.find_label(self.ui, "sp_di2/lab_state");
    skillInfo.textureIcon = ngui.find_texture(self.ui, "sp_di2/sp_bk/sp_human");
    skillInfo.txtCurEffect = ngui.find_label(self.ui, "sp_di3/txt");
    skillInfo.labCurEffect = ngui.find_label(self.ui, "sp_di3/lab");
    skillInfo.txtNextEffect = ngui.find_label(self.ui, "sp_di3/txt_upgrade");
    skillInfo.labNextEffect = ngui.find_label(self.ui, "sp_di3/lab_upgrade");
    -- --弹窗
    -- control.popUp = {};
    -- local popUp = control.popUp;
    -- popUp.objRoot = self.ui:get_child_by_name("panel");
    -- popUp.objRoot:set_active(false);
    --消耗
    control.consume = {};
    local consume = control.consume;
    consume.txtLevel = ngui.find_label(self.ui, "sp_di4/lab1");
    consume.spGold = ngui.find_sprite(self.ui, "sp_di4/sp_bk1");
    consume.spSkillBook = ngui.find_sprite(self.ui, "sp_di4/sp_bk2");
    consume.labLevel = ngui.find_label(self.ui, "sp_di4/lab2");
    consume.labGold = ngui.find_label(self.ui, "sp_di4/sp_bk1/lab");
    consume.labSkillBook = ngui.find_label(self.ui, "sp_di4/sp_bk2/lab");
    consume.btnSkillUpgrade = ngui.find_button(self.ui, "sp_di4/btn_skill")
    consume.btnSkillUpgrade:set_on_click(self.bindfunc["on_skill_upgrade"]);
    consume.btnOneUpgrade = ngui.find_button(self.ui, "sp_di4/btn_level_up")
    consume.btnOneUpgrade:set_on_click(self.bindfunc["on_one_upgrade"]);
    self:UpdateUi();
end

function SkillUpgradeUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then 
        return;
    end
    local learnSkill = self.roleData.learn_skill[self.skillIndex];
    local control = self.control;
    local consume = control.consume;
    local player = g_dataCenter.player;
    local skillData = ConfigManager.Get(EConfigIndex.t_skill_info,learnSkill.id);
    local skillLevelData = ConfigManager.Get(EConfigIndex.t_skill_level_info,learnSkill.id);
    local skillCurLevelData = skillLevelData[learnSkill.level];
    local skillnextLevelData = skillLevelData[learnSkill.level+1];
    local roleData = self.roleData;
    --顶部
    local centre = control.centre;
    centre.labGold:set_text(tostring(PublicFunc.NumberToStringByCfg(player.gold)));
    centre.labSkillBook:set_text(tostring(PropsEnum.GetValue(IdConfig.SkillBook)));
    --技能
    local skillInfo = control.skillInfo;
    skillInfo.labName:set_text("Lv."..tostring(learnSkill.level));
    local atk_power = roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
    local skill_introduce = SkillManager.GetSkillIntroduce(atk_power, learnSkill.id, learnSkill.level)
    skillInfo.labDes:set_text(skill_introduce);
    skillInfo.textureIcon:set_texture(skillData.small_icon);
    --技能效果
    skillInfo.labCurEffect:set_text(skill_introduce);
    if skillnextLevelData then
        consume.txtLevel:set_active(true);
        consume.spGold:set_active(true);
        consume.spSkillBook:set_active(true);
        --消耗
        consume.labLevel:set_text(tostring(skillnextLevelData.levelup_need_level).."级");
        consume.labGold:set_text(tostring(skillnextLevelData.levelup_need_gold));
        consume.labSkillBook:set_text(tostring(skillnextLevelData.levelup_need_item_num));
        --技能等级不鞥超过玩家等级
        --app.log(learnSkill.level..".."..self.roleData.level);
        if learnSkill.level >= self.roleData.level then
            consume.btnSkillUpgrade:set_enable(false);
            consume.btnOneUpgrade:set_enable(false);
        else
            consume.btnSkillUpgrade:set_enable(true);
            consume.btnOneUpgrade:set_enable(true);
        end
        --下一级技能效果
        skillInfo.txtNextEffect:set_active(true);
        skillInfo.labNextEffect:set_active(true);
        skillInfo.labNextEffect:set_text(SkillManager.GetSkillIntroduce(atk_power, learnSkill.id, learnSkill.level+1));
    else
        consume.txtLevel:set_active(false);
        consume.spGold:set_active(false);
        consume.spSkillBook:set_active(false);
        consume.btnSkillUpgrade:set_enable(false);
        consume.btnOneUpgrade:set_enable(false);
        skillInfo.txtNextEffect:set_active(false);
        skillInfo.labNextEffect:set_active(false);        
    end
    

end

function SkillUpgradeUI:on_close()
    uiManager:PopUi();
end

function SkillUpgradeUI:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.SkillUpgrade)
end

function SkillUpgradeUI.CheckUpgrade(roleData, skillIndex)
    local learnSkill = roleData.learn_skill[skillIndex];
    if not learnSkill then
        return MsgEnum.error_code.error_code_data;
    end
    local player = g_dataCenter.player;
    local skillLevelData = ConfigManager.Get(EConfigIndex.t_skill_level_info,learnSkill.id);
    local skillCurLevelData = skillLevelData[learnSkill.level + 1];
    if not skillCurLevelData then
        return MsgEnum.error_code.error_code_max_level;
    end
    if roleData.level < skillCurLevelData.levelup_need_level then
        return MsgEnum.error_code.error_code_level_low;
    end
    if player.gold < skillCurLevelData.levelup_need_gold then
        return MsgEnum.error_code.error_code_money_shortage;
    end
    local curCount = PropsEnum.GetValue(IdConfig.SkillBook);
    if curCount < skillCurLevelData.levelup_need_item_num then
        return MsgEnum.error_code.error_code_material_shortage;
    end
    --app.log(tostring(curCount)..".........."..tostring(skillCurLevelData.levelup_need_item_num))
    return MsgEnum.error_code.error_code_success;
end

function SkillUpgradeUI:CheckUpgradeTips(useAll)
    if useAll == nil then
        useAll = false;
    end
    local learnSkill = self.roleData.learn_skill[self.skillIndex];
    if not learnSkill then
        return false;
    end
    local player = g_dataCenter.player;
    local skillLevelData = ConfigManager.Get(EConfigIndex.t_skill_level_info,learnSkill.id);
    if not skillLevelData then
        return false;
    end
    --等级限制下 能升至多少级
    local addLevel = 0;
    while true do
        addLevel = addLevel + 1;
        local skillCurLevelData = skillLevelData[learnSkill.level + addLevel];
        if not skillCurLevelData then
            addLevel = addLevel - 1;
            if addLevel <= 0 then
                HintUI.SetAndShow(EHintUiType.zero, gs_misc["str_54"]);
                return false;
            end 
            break;
        end
        if self.roleData.level < skillCurLevelData.levelup_need_level then
            addLevel = addLevel - 1;
            if addLevel <= 0 then
                HintUI.SetAndShow(EHintUiType.zero, gs_misc["str_55"]);
                return false;
            end 
            break;
        end
        if not useAll then
            break;
        end
    end
    --判断金币能升到哪里
    local totalGold = 0;
    for i = 1, addLevel do
        local skillCurLevelData = skillLevelData[learnSkill.level + i];
        totalGold = totalGold + skillCurLevelData.levelup_need_gold;
        if player.gold < totalGold then
            if i == 1 then
                local func = function ()
                    uiManager:PushUi(EUI.GoldExchangeUI);
                end
                HintUI.SetAndShow(EHintUiType.zero, gs_misc["str_56"],{func = func});
                return false;
            end
            addLevel = i-1;
            break;
        end
    end
    --判断材料能升至哪
    local material = {};
    for i = 1, addLevel do
        local skillCurLevelData = skillLevelData[learnSkill.level + i];
        if skillCurLevelData.levelup_need_item_id > 0 then
            material[skillCurLevelData.levelup_need_item_id] = material[skillCurLevelData.levelup_need_item_id] or 0;
            material[skillCurLevelData.levelup_need_item_id] = material[skillCurLevelData.levelup_need_item_id] + skillCurLevelData.levelup_need_item_num
        end
        for k, v in pairs(material) do
            local curCount = PropsEnum.GetValue(k);
            if curCount < v then
                --提示使用钻石升级
                if i == 1 then
                    local costCrystal, maxLevel = self:GetUpgradeLevel(addLevel);
                    --app.log("........."..tostring(maxLevel));
                    local func = function ()
                        local curCrystal = PropsEnum.GetValue(IdConfig.Crystal);
                        if curCrystal < costCrystal then
                            local func2 = function()
                                uiManager:PushUi(EUI.StoreUI);
                            end
                            HintUI.SetAndShow(EHintUiType.two, gs_misc["str_58"],
                            {str=gs_misc["str_59"],func = func2},
                            {str=gs_misc["str_45"]});
                        else
                            msg_cards.cg_skill_level_up(self.roleData.index, learnSkill.id, useAll, true);    
                        end
                    end
                    HintUI.SetAndShow(EHintUiType.two, string.format(gs_misc["str_57"], costCrystal),{str=gs_misc["str_44"], func = func}, {str=gs_misc["str_45"],});
                    return false;
                else
                    if skillCurLevelData.levelup_need_item_id > 0 then
                        material[skillCurLevelData.levelup_need_item_id] = material[skillCurLevelData.levelup_need_item_id] - skillCurLevelData.levelup_need_item_num
                    end
                    addLevel = i - 1;
                    break;
                end
            end
        end
    end
    --app.log("........."..tostring(addLevel));
    return addLevel > 0;
end

function SkillUpgradeUI:GetUpgradeLevel(addLevel)
    local learnSkill = self.roleData.learn_skill[self.skillIndex];
    local skillLevelData = ConfigManager.Get(EConfigIndex.t_skill_level_info,learnSkill.id);
    local material = {};
    local costCrystal = 0;
    local maxLevel = 0;
    local curCrystal = PropsEnum.GetValue(IdConfig.Crystal);
    for i = 1, addLevel do
        local skillCurLevelData = skillLevelData[learnSkill.level + i];
        if skillCurLevelData.levelup_need_item_id > 0 then
            material[skillCurLevelData.levelup_need_item_id] = material[skillCurLevelData.levelup_need_item_id] or 0;
            material[skillCurLevelData.levelup_need_item_id] = material[skillCurLevelData.levelup_need_item_id] + skillCurLevelData.levelup_need_item_num
        end
        costOldCrystal = costCrystal;
        costCrystal = 0;
        for k, v in pairs(material) do
            local curCount = PropsEnum.GetValue(k);
            if curCount < v then
                local it = ConfigManager.Get(EConfigIndex.t_item,k);
                local c = (v - curCount)*it.need_crystal;
                costCrystal = costCrystal + c;
            end
        end
        if PropsEnum.GetValue(IdConfig.Crystal) < costCrystal then
            if i ~= 1 then
                costCrystal = costOldCrystal;
                maxLevel = i - 1;
            end
            break;
        end
        maxLevel = i;
    end
    return costCrystal, maxLevel;
end

function SkillUpgradeUI:on_skill_upgrade()
    local learnSkill = self.roleData.learn_skill[self.skillIndex];
    if not learnSkill then
        return;
    end
    -- if not self:CheckUpgradeTips() then
    --     return;
    -- end
    local result = SkillUpgradeUI.CheckUpgrade(self.roleData, self.skillIndex);
    if not PublicFunc.GetErrorString(result) then
        return;
    end
    msg_cards.cg_skill_level_up(self.roleData.index, learnSkill.id, false, false);
end

function SkillUpgradeUI:on_one_upgrade()
    local learnSkill = self.roleData.learn_skill[self.skillIndex];
    if not learnSkill then
        return;
    end
    -- if not self:CheckUpgradeTips(true) then
    --     return;
    -- end
    msg_cards.cg_skill_level_up(self.roleData.index, learnSkill.id, true, false);
end

function SkillUpgradeUI:gc_skill_level_up_rst()
    FloatTip.Float("升级成功")
    self:UpdateUi();
end
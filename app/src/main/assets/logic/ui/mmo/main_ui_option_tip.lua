
MainUIOptionTip = Class('MainUIOptionTip', MultiResUiBaseClass)

--local res = "assetbundles/prefabs/ui/new_fight/left_top_other.assetbundle"
local multiRes = 
{
    optionSet = "assetbundles/prefabs/ui/new_fight/right_top_other.assetbundle",
    hurdleDes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_level.assetbundle",
    escorthurdleDes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_npc.assetbundle",
} 

local normalAniName = 
{
    IN = {"fight_animation_hint_out", 180},
    OUT = {"fight_animation_hint", 0}
}

local NPCAniName = 
{
    IN = {"fight_npc_jin", 180},
    OUT = {"fight_npc_out", 0}
}

local TaskSpHeight = 
{
    52,
    78,
    111,
}

local uiText = 
{
	[1] ='[00C0FFFF]总分[-] %d',
    [2] = '[0CB1F5FF]第%d波[-]   共%d波',
}

function MainUIOptionTip.GetResList()
    local set_ui_res = FightSetUI.GetResList()
    return {multiRes.optionSet, multiRes.hurdleDes, multiRes.escortMultiRes, set_ui_res}
end

function MainUIOptionTip:Init(data)
    self.pathRes = multiRes
	MultiResUiBaseClass.Init(self, data);
end

function MainUIOptionTip:RestartData(data)
    self._showCollectProgress = false
end

function MainUIOptionTip:Restart(data)
    MultiResUiBaseClass.Restart(self, data)

    FightSetUI.Start();
end

function MainUIOptionTip:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self)

    FightSetUI.Hide()
    self.pos = nil;
end

function MainUIOptionTip:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self)

    self.bindfunc['onSetting'] = Utility.bind_callback(self, self.onSetting);
    self.bindfunc['ClickTaskTracing'] = Utility.bind_callback(self, self.ClickTaskTracing);
    self.bindfunc['ClickTrusteeship'] = Utility.bind_callback(self, self.ClickTrusteeship);
end

function MainUIOptionTip:SetAutoBtn(is)
    if self.tgAuto2 then
        self.tgAuto2:set_value(is)
    else
        self.isAuto = is;
    end
end

function MainUIOptionTip:InitedAllUI(asset_obj)

    local mainui = GetMainUI()

    local setui = self.uis[multiRes.optionSet]
    local desui = self.uis[multiRes.hurdleDes]

    self.settingAndAutoBtnParentNode = setui:get_child_by_name("cont")
    if self.pos then
        self.settingAndAutoBtnParentNode:set_local_position(self.pos.x, self.pos.y, self.pos.z);
    end

    self.uis[multiRes.escorthurdleDes]:set_active(false)
    desui:set_active(false)

    self.animationName = normalAniName

    if self.useNpcResource then
        desui = self.uis[multiRes.escorthurdleDes]
        self.animationName = NPCAniName
    end

    desui:set_active(true)

    self.ui = setui

    setui:set_parent(mainui.rightTopNode)
    desui:set_parent(mainui.leftTopNode)

    local btn = ngui.find_button(setui, 'btn_left_sp')
    btn:set_on_click(self.bindfunc['onSetting'])

    self.objTask = desui
    self.animationNode = desui:get_child_by_name("animation_hint")
    self.spArrows = desui:get_child_by_name("sp_arrows") --ngui.find_sprite(desui, "sp_arrows");
    self.spArrows:set_local_rotation(0, 0, self.animationName.OUT[2]);
    self.grid = ngui.find_grid(desui, "grid");
    self.labTask = {}
    for i = 1, 3 do
        self.labTask["labTask"..i] = ngui.find_label(desui, "lab_hit"..i);
        self.labTask["spStar"..i] = ngui.find_sprite(desui, "sp_star"..i);
    end
    self.btnOut = ngui.find_button(desui, "btn_empty");
    self.btnOut:set_on_click(self.bindfunc['ClickTaskTracing']);
    self.isOut = false;

    self:setTaskTracting()

    if self._initData.showTip == false then
        self.objTask:set_active(false)
    end

    --自动战斗相关
    self.animObj =setui:get_child_by_name("yeka_auto/animation");
    self.animObj:set_active(false);
    local node = setui:get_child_by_name('yeka_auto')
    if self._initData.openAuto == true then
        --查看硬性条件满足不  不满足的话 依然不能开启自动战斗
        local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_hurdleAutoFightOpenHurdleId);
        if cf then
            --if g_dataCenter.hurdle:IsPassHurdle(cf.data) or FightScene.GetLevelID() == cf.data then
            if g_dataCenter.player.level >= cf.data then
                self.tgAuto2 = ngui.find_toggle(node, 'sp');
                self.tgAuto2:set_on_change(self.bindfunc['ClickTrusteeship'])
                --self:setAutoFightMode()
            else
                node:set_active(false);
            end
        else
            node:set_active(false);
        end
    else
        node:set_active(false)
    end
    if self.isAuto ~= nil then
        if self.tgAuto2 then
            self.tgAuto2:set_value(self.isAuto);
        end
        self.isAuto = nil;
    end

    self.collectProgressBar = ngui.find_progress_bar(desui, "pro_di")
    self.collectNumLabel = ngui.find_label(desui, "pro_di/lab")
    self.collectProgressBar:set_active(self._showCollectProgress)

    self.monsterWaveDesLabel = ngui.find_label(desui, "lab_describe")

    self.escortHpProgressBar = self.collectProgressBar
    self.escortNameLabel = self.collectNumLabel

    self.gaoSuJuJiInfoNode = desui:get_child_by_name("cont")
    if self.gaoSuJuJiInfoNode then
        self.gaoSuJuJiScoreLabel = ngui.find_label(self.gaoSuJuJiInfoNode, "txt_score")
        self.gaoSuJuJiKillLabel = ngui.find_label(self.gaoSuJuJiInfoNode, "lab_kill")
        self.gaoSuJuJiEscapeLabel = ngui.find_label(self.gaoSuJuJiInfoNode, "lab_escape")
    end

    if self.currentCollect then
        self:UpdateCollectProgress(self.currentCollect, self.totalCollect)
    end

    if self.useNpcResource then
        if self.showMonsterWave then
            self.collectProgressBar:set_active(false)
            self.monsterWaveDesLabel:set_active(true)

            self:UpdateMonsterWaveInfo(self.curMonsterWave, self.totalMonsterWave)
        else
            self.collectProgressBar:set_active(true)
            self.monsterWaveDesLabel:set_active(false)

            self.escortHpProgressBar:set_active(true)
            self.escortNameLabel:set_text(tostring(self.escortHurdleNpcName));
        end
    end

    self:InitGaoSuJuJiNode()
end

function MainUIOptionTip:ShowCollectProgress()
    self._showCollectProgress = true
    if self.collectProgressBar then
        self.collectProgressBar:set_active(true)
    end
end

function MainUIOptionTip:UpdateCollectProgress(cur, total)

    self.currentCollect = cur
    self.totalCollect = total

    if self.ui then
        local pro = cur/total
        local str = string.format("%d/%d", cur, total)
        self.collectProgressBar:set_value(pro)
        self.collectNumLabel:set_text(str)
    end
end

function MainUIOptionTip:ShowMonsterWaveInfo(total)
    self.useNpcResource = true
    self.showMonsterWave = true

    self.curMonsterWave = 0
    self.totalMonsterWave = total or 0
    if self.ui then
        self:InitedAllUI()
    end
end

function MainUIOptionTip:UpdateMonsterWaveInfo(cur, total)
    if self.monsterWaveDesLabel == nil then return end

    self.monsterWaveDesLabel:set_text(string.format(uiText[2], cur, total))
end

function MainUIOptionTip:ShowEscortInfo(npcName)
    self.useNpcResource = true
    self.escortHurdleNpcName = npcName

    if self.ui then
        self:InitedAllUI()
    end
end

function MainUIOptionTip:UpdateEscortHpProgress(hpProgress)
    if self.escortHpProgressBar then
        self.escortHpProgressBar:set_value(hpProgress)
    end
end

function MainUIOptionTip:InitGaoSuJuJiNode()
    if self.gaoSuJuJiInfoNode == nil then return end

    if self._showGaoSuJuJiInfo then
        self.gaoSuJuJiInfoNode:set_active(true)
        self:UpdateGaoSuJuJiInfo(0, 0, 0)
    else
        self.gaoSuJuJiInfoNode:set_active(false)
    end
end

function MainUIOptionTip:ShowGaoSuJuJiInfo()
    self._showGaoSuJuJiInfo = true

    self:InitGaoSuJuJiNode()
end

function MainUIOptionTip:UpdateGaoSuJuJiInfo(score, kill, escape)
    if self.gaoSuJuJiInfoNode == nil then return end

    self.gaoSuJuJiScoreLabel:set_text(string.format(uiText[1], score))
    self.gaoSuJuJiKillLabel:set_text(tostring(kill))
    self.gaoSuJuJiEscapeLabel:set_text(tostring(escape))
end

function MainUIOptionTip:ClickTrusteeship(t)

    --app.log("ClickTrusteeship==========="..tostring(t))
    GetMainUI():UpdateTouchTime()

    if t then
        g_dataCenter.autoPathFinding:StopPathFind();
    end
    if self.isFirst == nil then
        self.isFirst = 1
    else
        --只对关卡做打点记录
        local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
        local groupid = hurdle.groupid
        if groupid > 0 then
            --app.log("ClickTrusteeship"..tostring(t))
            g_dataCenter.setting:WriteFightAutoFile(t)
        else
            local startUpInf = FightScene.GetStartUpEnv()
            local typeid = startUpInf.levelData.fight_type
            local method_name = ""
            -- if typeid >= 60110000 and typeid <= 60110100 then
            --     method_name = "jxtz_isAuto"
            -- else
            method_name = "method"..tostring(typeid)
            -- end
            g_dataCenter.setting:WriteFightAutoFileToMethod(method_name,t)
        end
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
    end

    --if FightScene.GetPlayMethodType() == nil and self.animObj then
    if self.animObj then
        self.animObj:set_active(t);
    end

    ObjectManager.ChangeCaptainFightMode(t)
end

-- 设置任务追踪面板
function MainUIOptionTip:setTaskTracting()
    --类型
    local pmType = FightScene.GetPlayMethodType()
    --如果不是关卡
    -- if pmType ~= nil then
    --     return;
    -- end
    local condi_str = FightCondition.GetHurdleCondiDes(FightScene.GetCurHurdleID());
    if condi_str == nil or (condi_str[1] == 0 and condi_str[2] == 0 and condi_str[3] == 0)then
        self.objTask:set_active(false);
        return;
    end
    self.objTask:set_active(true);
    self.strCondition = {};
    for i = 1, 3 do
        if condi_str[i] and condi_str[i] ~= 0 then
            self.labTask["labTask"..i]:set_active(true);
            self.strCondition[i] = tostring(condi_str[i]);
            self.labTask["labTask"..i]:set_text(self.strCondition[i]);
            --self.labTask["spStar"..i]:set_color(1, 1, 1, 1);
            --self.labTask["spStar"..i]:set_active(pmType == nil);
        else
            self.labTask["labTask"..i]:set_active(false);
        end
    end
    self.grid:reposition_now();
    --self.spArrows:set_active(pmType ~= nil);
end

function MainUIOptionTip:ClickTaskTracing(t)
    --AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);

    self:SetTaskTracing(not self.isOut);
    g_dataCenter.setting:SetTaskTracingTips(self.isOut);
end

function MainUIOptionTip:SetTaskTracing(isOut)

    if self.isOut == isOut then
        return;
    end
    
    self.isOut = isOut;
    if isOut then
        -- app.log("#hyg# ClickTaskTracing in")
        local name = self.animationName.IN
        self.animationNode:animated_play(name[1]);
        self.spArrows:set_local_rotation(0, 0, name[2]);
    else
        -- app.log("#hyg# ClickTaskTracing out")
        local name = self.animationName.OUT
        self.animationNode:animated_play(name[1]);
        self.spArrows:set_local_rotation(0, 0, name[2]);
    end

    self.playAnimBeginTime = app.get_time()
end

-- 更改任务显示
function MainUIOptionTip:setTaskComplete(num, flag)
    --类型
    local pmType = FightScene.GetPlayMethodType()
    --没有条件
    if self.strCondition == nil or self.strCondition[num] == nil then
        return;
    end

    if not self.labTask["labTask"..num] then
        return;
    end

    local str = self.strCondition[num];
    if flag then
        str = '[00ff00]' .. str .. '[-]';
    end
    self.labTask["labTask"..num]:set_text(str);
    if flag then
        self.labTask["spStar"..num]:set_sprite_name("xingxing1");
    else
        self.labTask["spStar"..num]:set_sprite_name("xingxing3");
    end
end

function MainUIOptionTip:onSetting()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        AudioManager.ChangeBackAudioVol(0.3, 2000)
        PublicFunc.UnityPause()
    end

    FightSetUI.Show()
end

function MainUIOptionTip:SetLocalPosition(x,y,z)
    if self.ui then
        self.settingAndAutoBtnParentNode:set_local_position(x, y, z);
    else
        self.pos = {x=x,y=y,z=z};
    end
end

function MainUIOptionTip:OnShow()
    self:SetTaskTracing(g_dataCenter.setting:GetTaskTracingTips());
end

function MainUIOptionTip:OnHide()
    if self.playAnimBeginTime and  app.get_time() - self.playAnimBeginTime < 0.1 then
        self.isOut = nil
    end
end
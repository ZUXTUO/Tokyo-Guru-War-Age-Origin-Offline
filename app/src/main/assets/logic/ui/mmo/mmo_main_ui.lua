


local first_show_verbose_menu = true

MMOMainUI = Class('MMOMainUI', UiBaseClass)

local function __GetUIResList(ui)
    local cls = ui.cls
    if nil ~= cls then
        if nil == cls.GetResList or type(cls.GetResList) ~= 'function' then
            app.log_warning("class:"..tostring(cls._className).." has no function named 'GetResList'")
            return;
        end
        return cls.GetResList();
    end

    return nil
end

function MainUiFirstShowVerbosUi(show)
    first_show_verbose_menu = show
end
 
function GetMainUI()
    local ui = uiManager:FindUI(EUI.MMOMainUI)
    if ui == nil then
        app.log_warning("Main ui not init finished")
    end
    return ui
end

local fightResPath = "assetbundles/prefabs/ui/new_fight/xin_main.assetbundle"
local mainCityResPath = "assetbundles/prefabs/ui/new_fight/right_other_animation.assetbundle"

function MMOMainUI:Init(data)

    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_MainCity then
        self.pathRes = mainCityResPath
    else
        self.pathRes = fightResPath
    end

	UiBaseClass.Init(self, data);
   -- ResourceManager.AddReservedRes(self.pathRes)
    self.left_move_dis = 0
    self.right_move_dis = 0
    self.left_dis_check = 300
    self.right_dis_check = 90
end

function MMOMainUI:GetFirstHideVerboseMenu()
    return self.showVerboseMenu
end

function MMOMainUI:Restart(data)
    self:ResetData()

    UiBaseClass.Restart(self, data)
end

function MMOMainUI:ResetData()

    self.components = {}
    self.leaveTime = self.leaveTime or 0;

    self.initConponentTimer = nil
    self.teamComponent = nil

    self.showVerboseMenu = first_show_verbose_menu
end

function MMOMainUI:DestroyUi()

    if not self.ui then
        return
    end
--    app.log("MMOMainUI:DestroyUi"..debug.traceback())
    self:DestroySceneEffect();
    UiBaseClass.DestroyUi(self)

    self.isHideBossBlood = false;

    for k,v in pairs(self.components) do
        v:DestroyUi()
    end
    self.components = nil

    RecommendMgr.Inst():Stop()

    if self.initConponentTimer then
        timer.stop(self.initConponentTimer)
        self.initConponentTimer = nil
    end
end

function MMOMainUI:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['PushUi'] = Utility.bind_callback(self, self.PushUi)
end

function MMOMainUI:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(UiManager.PushUi, self.bindfunc['PushUi'])
end

function MMOMainUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(UiManager.PushUi, self.bindfunc['PushUi'])
end

function MMOMainUI:PushUi(uiid)
    if uiid ~= EUI.MMOMainUI then
        --app.log("MMOMainUI:PushUi " .. tostring(uiid))
        first_show_verbose_menu = true
        self.showVerboseMenu = true
    end
end

function MMOMainUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.leftTopNode = self.ui:get_child_by_name('left_top')
    self.rightTopNode = self.ui:get_child_by_name('right_top')
    self.leftDownNode = self.ui:get_child_by_name('left_down')
    self.rightDownNode = self.ui:get_child_by_name('right_down')
    self.centerNode = self.ui:get_child_by_name('centre')
    self.rightCenterNode = self.ui:get_child_by_name('right_centre')
    self.leftCenterNode = self.ui:get_child_by_name('left_centre')
    self.topNode = self.ui:get_child_by_name('top');

    self.downNode = self.ui:get_child_by_name('down');

    -- self.talkNode = self.ui:get_child_by_name("centre/content")
    -- self.talkNode:set_active(false)
    --Root.get_root_ui_2d_fight():set_active(true);

    -- next frame call
    self.initConponentTimer = timer.create(Utility.create_callback(self.InitComponents, self), 20, 1)
 
    self:InitSceneEffect(true);    
end

function MMOMainUI:InitComponents()
    timer.stop(self.initConponentTimer)
    self.initConponentTimer = nil

    self:InitPlayGuideUI();

    FightScene.GetFightManager():InitMainUiComponent();
	FightScene.GetFightManager():StandardUILayout()
end

function MMOMainUI:InitPlayGuideUI()
    local startUpInf = FightScene.GetStartUpEnv()
    local res = startUpInf.levelData.play_guide_res;
    local cfg = startUpInf.levelData.play_guide_cfg;
    local fight_type = startUpInf.levelData.fight_type;
    if cfg and cfg ~= 0 and PlayGuideUI.CheckPlay(cfg, fight_type) then
        PlayGuideUI.SetParam(res);
    end
end

function MMOMainUI:IsLoaded()
    local isld = true
    for k,v in pairs(self.components) do
        if not v:IsLoaded() then
            isld = false
            break
        end
    end

    return isld and UiBaseClass.IsLoaded(self)
end

function MMOMainUI:Show(ui, hp)
    if not self.ui then
        return
    end

    if ui == 1 or ui == nil then
        UiBaseClass.Show(self)
        self:OnShow()
    end
    if hp == 1 or hp == nil then
        Root.get_root_ui_2d_fight():set_active(true);
    end
end

function MMOMainUI:Hide(ui, hp)
    if not self.ui then
        return
    end
    
    if ui == 1 or ui == nil then
        UiBaseClass.Hide(self)
        self:OnHide();
    end
    if hp == 1 or hp == nil then
        Root.get_root_ui_2d_fight():set_active(false);
    end

end

function MMOMainUI:SetLeaveTime()
    self.leaveTime = os.time();
end

function MMOMainUI:Update(dt)
    for k,v in pairs(self.components) do
        if v:IsShow() and v.Update then
            v:Update(dt)
        end
    end

end

function MMOMainUI:ShowNavigationBar()
    return false
end

function MMOMainUI:OnFightOver()
    local obj = FightManager.GetMyCaptain();
    if nil ~= obj then
        obj:KeepNormalAttack(false);
        obj.stopAttack = true
        obj:SetState(ESTATE.Stand);
        obj:SetHandleState(EHandleState.Idle)
        obj.can_combo = false
    end
    SkillTips.EnableSkillTips(false);
    self:Hide()
    FightSetUI.Hide()
end

function MMOMainUI:SkillStartCd(index, endFrame, time)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:SkillStartCd(index, endFrame, time)
    end
end

function MMOMainUI:SkillStopCD(index)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:SkillStopCD(index)
    end
end

function MMOMainUI:ReFillCD(obj)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:ReFillCD(obj)
    end
end

function MMOMainUI:ReFillRationEffect(obj)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:ReFillRationEffect(obj)
    end
end

function MMOMainUI:UpdateSkillIcon(obj)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:UpdateSkillIcon(obj)
    end
end

function MMOMainUI:ClearSkillRefInfo()
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:ClearSkillRefInfo();
    end
end

function MMOMainUI:UpdateSkillOverlap(obj)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:UpdateSkillOverlap(obj)
    end
end

function MMOMainUI:EnableRationEffect(index, enable)
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:EnableRationEffect(index, enable)
    end
end

function MMOMainUI:CheckFightState()
    local com = self:GetComponent(EMMOMainUICOM.MainUISkillInput)
    if com and com:IsShow() then
        com:CheckFightState()
    end
end

function MMOMainUI:SetAutoBtn(is)
    local com = self:GetComponent(EMMOMainUICOM.MainUIOptionTip)
    if com then
        com:SetAutoBtn(is)
    end
end

function MMOMainUI:UpdateTouchTime()
    local com = self:GetComponent(EMMOMainUICOM.MainUIJoystick)
    if com and com:IsShow() then
        com:UpdateTouchTime()
    end
end

function MMOMainUI:UpdateHeadData()

    --app.log("MMOMainUI:UpdateHeadData================")
    if self.teamComponent and self.teamComponent:IsShow() then
        self.teamComponent:UpdateHeadData()
    end
end

function MMOMainUI:TeamHeroProChanged()
    if self.teamComponent and self.teamComponent:IsShow() then
        self.teamComponent:TeamHeroProChanged()
    end
end

function MMOMainUI:TeamHeroAutoReborn()
    if self.teamComponent and self.teamComponent.TeamHeroAutoReborn then
        self.teamComponent:TeamHeroAutoReborn()
    end
end

function MMOMainUI:SetSelectHead(index)

    if self.teamComponent and self.teamComponent:IsShow() and self.teamComponent.SetSelectHead then
        self.teamComponent:SetSelectHead(index)
    end
end

function MMOMainUI:SetLeftMoveDis(dis)
    self.left_move_dis = dis
end

function MMOMainUI:SetRightMoveDis(dis)
    self.right_move_dis = dis
end
--·µ»ØÒ¡¸ËÒÆ¶¯¾àÀë±È
function MMOMainUI:GetRockerMoveScale(type)
    if type == 0 then
        return self.left_move_dis / self.left_dis_check;
    else
        return self.right_move_dis / self.right_dis_check;
    end
end

function MMOMainUI:AddComponent(ecom, param)
    if type(self.components) ~= 'table' then
        app.log("MMOMainUI::AddComponent self.components == nil " .. debug.traceback() )
    end
    local com = self.components[ecom.name]
    if com == nil then
        com = ecom.cls:new(param)
        self.components[ecom.name] = com
    end
    return com
end


function MMOMainUI:RemoveComponent(ecom)
    if type(self.components) ~= 'table' then
        app.log("MMOMainUI::AddComponent self.components == nil " .. debug.traceback() )
    end
    local com = self.components[ecom.name]
    if com then
        com:DestroyUi();
        self.components[ecom.name] = nil;
    end
end

function MMOMainUI:GetComponent(ecom)
    if ecom == nil then
        app.log('xx== ' .. debug.traceback())
    end
    local com = nil
    if self.components then
        com = self.components[ecom.name]
    end
    return com
end

function MMOMainUI:AttachComponent(component)

    local ci = component.componentInfo
    if ci == nil then return end
    
    local ecom = ci.comInfo
    local parent = ci.parent

    component:SetParent(parent)
    component.componentInfo = nil
    self.components[ecom.name] = component
end

function MMOMainUI:DetachComponent(ecom)
    if self.components == nil then return end

    local com = self.components[ecom.name]

    if com then

        com.componentInfo = {comInfo = ecom, parent = com:GetParent()}
        com:SetParent(Root.get_root_ui_2d())
        self.components[ecom.name] = nil
    end

    return com
end

function MMOMainUI:needGuideTip()
    return self:GetComponent(EMMOMainUICOM.MainUIPlayerMenu) ~= nil
end

function MMOMainUI:InitPlayerMenu()

    if self:GetComponent(EMMOMainUICOM.MainUIPlayerMenu) ~= nil then
        return
    end

    self.MainUIPlayerMenuDataCache = self.MainUIPlayerMenuDataCache or {}
    self:AddComponent(EMMOMainUICOM.MainUIPlayerMenu, {uiNode = self.ui, scale = {x=1,y=1,z=1}, dataCache = self.MainUIPlayerMenuDataCache} )

end

function MMOMainUI.GetPlayerMenuRes()
   return __GetUIResList(EMMOMainUICOM.MainUIPlayerMenu);
end

function MMOMainUI:GetPlayerMenu()
    return self:GetComponent(EMMOMainUICOM.MainUIPlayerMenu)
end

function MMOMainUI:InitJoystick()
    --local node = ngui.find_panel(self.ui, 'down_other'):get_game_object()
    local data = {parent = self.leftDownNode, scale = {x=1,y=1,z=1}}
    self:AddComponent(EMMOMainUICOM.MainUIJoystick, data )
end

function MMOMainUI:GetJoystick()
    return self:GetComponent(EMMOMainUICOM.MainUIJoystick)
end

function MMOMainUI.GetJoystickRes()
   return __GetUIResList(EMMOMainUICOM.MainUIJoystick);
end

function MMOMainUI:InitSkillInput(openSwitchTarget)
    if openSwitchTarget == nil then
        openSwitchTarget = false
    end
    --local node = ngui.find_panel(self.ui, 'down_other'):get_game_object()
    local data = {parent = self.rightDownNode, openSwitch = openSwitchTarget, scale = {x=1,y=1,z=1}}
    self:AddComponent(EMMOMainUICOM.MainUISkillInput, data )
end

function MMOMainUI.GetSkillInputRes()
   return __GetUIResList(EMMOMainUICOM.MainUISkillInput);
end

function MMOMainUI:GetSkillInput()
    return self:GetComponent(EMMOMainUICOM.MainUISkillInput)
end

function MMOMainUI:InitTeamCannotChange()
end


function MMOMainUI:InitTeamCanChange(isOpenChangeCaption, canReborn, showRight)
    if self.teamComponent then return end

    if isOpenChangeCaption == nil then
        isOpenChangeCaption = true
    end
    if canReborn == nil then
        canReborn = true
    end

    if showRight == nil then
        showRight = false
    end

    self.main_ui_team_data_can_change = self.main_ui_team_data_can_change or {}
    self.teamComponent = self:AddComponent(EMMOMainUICOM.MainUITeamCanChange, {parent = self.rightTopNode, isOpenChange = isOpenChangeCaption, showRight = showRight, canReborn = canReborn, dataCache = self.main_ui_team_data_can_change, scale = {x=1,y=1,z=1}} )
end

function MMOMainUI.GetTeamCanChangeRes()
   return __GetUIResList(EMMOMainUICOM.MainUITeamCanChange);
end


function MMOMainUI:GetTeamCanChange()
    return self:GetComponent(EMMOMainUICOM.MainUITeamCanChange)
end

function MMOMainUI:RoleDead(name, relive_time)

    if self.teamComponent and self.teamComponent:IsShow() then
        self.teamComponent:RoleDead(name, relive_time)
    end
end

function MMOMainUI:ClearReliveInfo(name)
    if self.teamComponent and self.teamComponent.ClearReliveInfo and self.teamComponent:IsShow() then
        self.teamComponent:ClearReliveInfo(name)
    end
end

function MMOMainUI:FilterReliveInfo(is_filter)
    if self.teamComponent then
        if is_filter and self.teamComponent.ClearReliveInfo then
            self.teamComponent:ClearReliveInfo(nil)
        end
        self.teamComponent.is_filter = is_filter
    end
end

function MMOMainUI:InitMMOTaskTrackUI()
    self:AddComponent(EMMOMainUICOM.MMOTaskTrackUI, {parent = self.leftCenterNode, scale = {x=1,y=1,z=1}} )
end

function MMOMainUI.GetMMOTaskTrackUIRes()
   return __GetUIResList(EMMOMainUICOM.MMOTaskTrackUI);
end

function MMOMainUI:GetMMOTaskTrackUI()
    return self:GetComponent(EMMOMainUICOM.MMOTaskTrackUI)
end

function MMOMainUI:InitTaskLoadingBarUI()
    self:AddComponent(EMMOMainUICOM.MMOLoadingBardUI, {parent = self.ui, scale = {x=1,y=1,z=1}})
end

function MMOMainUI.GetTaskLoadingBarUIRes()
   return __GetUIResList(EMMOMainUICOM.MMOLoadingBardUI);
end

function MMOMainUI:GetTaskLoadingBarUI()
    return self:GetComponent(EMMOMainUICOM.MMOLoadingBardUI)
end

function MMOMainUI:InitOptionTip(isShowTip, openAuto)
    if isShowTip == nil then
        isShowTip = true;
    end

    if openAuto == nil then
        openAuto = true;
    end
    
    local com = self:GetComponent(EMMOMainUICOM.MainUIOptionTip)
    if com ~= nil then
        app.log('please InitOptionTip before InitMinimap')
        return
    end

    
    self:AddComponent(EMMOMainUICOM.MainUIOptionTip, {parent = self.leftTopNode, openAuto = openAuto, showTip = isShowTip, scale = {x=1,y=1,z=1}} )
end

function MMOMainUI:GetOptionTipUI()
    return self:GetComponent(EMMOMainUICOM.MainUIOptionTip)
end

function MMOMainUI.GetOptionTipRes()
   return __GetUIResList(EMMOMainUICOM.MainUIOptionTip);
end

function MMOMainUI:setTaskComplete(num, flag)
    local com = self:GetComponent(EMMOMainUICOM.MainUIOptionTip)
    if com and com:IsShow() then
        com:setTaskComplete(num, flag)
    end
end

-----------------通用boss血条------------------------
--  tType=1         类型 1为雕像血条 2为boss血条
--  name=""         对象的名字
--  once=false      只可以控制一次显示隐藏
function MMOMainUI:InitBosshp(tType, name, once)
    if self.isHideBossBlood then
        return;
    end

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiBosshp)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiBosshp,{
            parent = self.topNode,
            tType = tType,
            name = name,
            once = once
            })
    else
        com:SetShowObj(tType, name);
        com:ShowBlood(true);
    end
end

function MMOMainUI.GetBosshpRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiBosshp);
end

function MMOMainUI:GetBosshp()
    return self:GetComponent(EMMOMainUICOM.NewFightUiBosshp)
end

function MMOMainUI:HideBossBlood(isHide)
    self.isHideBossBlood = isHide;
    if GetMainUI():GetBosshp() then
        GetMainUI():GetBosshp():HideBossBlood(isHide);
    end
end

---------------------世界boss-------------------------
function MMOMainUI:InitWorldBoss()

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiWorldBoss)

    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiWorldBoss ,{parent = self.downNode, scale = {x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI.GetWorldBossRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiWorldBoss);
end

function MMOMainUI:GetWorldBoss()
    return self:GetComponent(EMMOMainUICOM.NewFightUiWorldBoss)
end

---------------------中原宝箱-------------------------
function MMOMainUI:InitWorldTreasureBox()
    
    local com = self:GetComponent(EMMOMainUICOM.WorldTreasureBoxMainUI)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.WorldTreasureBoxMainUI, {parent = self.ui, scale = {x=1,y=1,z=1}})
    else
        com:Show()
    end
end

function MMOMainUI.GetWorldTreasureBoxRes()
   return __GetUIResList(EMMOMainUICOM.WorldTreasureBoxMainUI);
end

function MMOMainUI:GetWorldTreasureBox()
    return self:GetComponent(EMMOMainUICOM.WorldTreasureBoxMainUI)
end

---------------------下方通用提示-------------------
function MMOMainUI:InitTips(str, time)

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiTip)

    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiTip, {
            parent = self.ui,
            str = str,
            time = time,
            });
    else
        com:ShowTips(str, time);
    end
end

function MMOMainUI.GetTipsRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiTip);
end

-----------------------更新小地图------------------
--tType 1显示最靠右的地图 2显示旁边靠左点的地图
--ratation 旋转的度数
function MMOMainUI:InitMinimap(data)

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiMinimap)

    if com == nil then
        local data = data or {}
        data.parent = self.leftTopNode
        data.scale = {x=1,y=1,z=1}

        self:AddComponent(EMMOMainUICOM.NewFightUiMinimap, data);
    else
        com:Show();
    end
end

function MMOMainUI.GetMinimapRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiMinimap);
end


function MMOMainUI:GetMinimap()
    return self:GetComponent(EMMOMainUICOM.NewFightUiMinimap)
end

-----------------------排行榜-----------------------
--  rankinfo = {{name="",damage=0},{name="",demage=0}}  排行榜信息 必须是排好序的排行榜
--  rankPlaces = 1  自己当前上榜排名
--  demage = 1000   你自己的伤害
function MMOMainUI:InitRank(rankinfo, rankPlaces, demage)

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiRank)

    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiRank, 
            {
            parent = self.leftTopNode,
            rankinfo = rankinfo,
            rankPlaces = rankPlaces,
            demage = demage,
            });
    else
        com:Show();
    end
end

function MMOMainUI.GetRankRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiRank);
end

function MMOMainUI:GetRank()
    return self:GetComponent(EMMOMainUICOM.NewFightUiRank)
end

-----------------------世界boss排行榜-----------------------
--  rankinfo = {{name="",damage=0},{name="",demage=0}}  排行榜信息 必须是排好序的排行榜
--  rankPlaces = 1  自己当前上榜排名
--  demage = 1000   你自己的伤害
function MMOMainUI:InitWorldBossRank(rankinfo, rankPlaces, demage, singleDamage)

    local com = self:GetComponent(EMMOMainUICOM.WorldBossFightRankUI)

    if com == nil then
        self:AddComponent(EMMOMainUICOM.WorldBossFightRankUI, 
            {
            parent = self.leftTopNode,
            rankinfo = rankinfo,
            rankPlaces = rankPlaces,
            demage = demage,
            singleDamage = singleDamage,
            });
    else
        com:Show();
    end
end

function MMOMainUI.GetWorldBossRankRes()
   return __GetUIResList(EMMOMainUICOM.WorldBossFightRankUI);
end

function MMOMainUI:GetWorldBossRank()
    return self:GetComponent(EMMOMainUICOM.WorldBossFightRankUI)
end
----------------------聊天约战--------------------------

function MMOMainUI:InitChatFight()
    local com = self:GetComponent(EMMOMainUICOM.ChatFightUI)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.ChatFightUI, {parent = self.ui, scale = {x=1,y=1,z=1} });
    else
        com:Show();
    end
end

function MMOMainUI:GetChatFight()
    return self:GetComponent(EMMOMainUICOM.ChatFightUI)
end

function MMOMainUI.GetChatFightRes()
    return __GetUIResList(EMMOMainUICOM.ChatFightUI);
end

----------------------战斗提示怪位置功能--------------------------

function MMOMainUI:InitFightMonsterGuide()
    local com = self:GetComponent(EMMOMainUICOM.FightMonsterGuide)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.FightMonsterGuide, {parent = self.ui});
    else
        com:Show();
    end
end

function MMOMainUI:GetFightMonsterGuide()
    return self:GetComponent(EMMOMainUICOM.FightMonsterGuide)
end

function MMOMainUI.GetFightMonsterGuideRes()
    return __GetUIResList(EMMOMainUICOM.FightMonsterGuide);
end

---------------------3v3-------------------------
function MMOMainUI:InitThreeToThree(killCnt, deadCnt, getSoul, loseSoul)

    local com = self:GetComponent(EMMOMainUICOM.QingTongJiDiFightUI)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.QingTongJiDiFightUI, {parent = self.topNode, scale = {x=1,y=1,z=1}, killCnt=killCnt or 0, deadCnt=deadCnt or 0, getSoul=getSoul or 0, loseSoul=loseSoul or 0});
    else
        com:Show();
    end
end

function MMOMainUI:GetThreeToThree()
    return self:GetComponent(EMMOMainUICOM.QingTongJiDiFightUI)
end

function MMOMainUI.GetThreeToThreeRes()
   return __GetUIResList(EMMOMainUICOM.QingTongJiDiFightUI);
end

function MMOMainUI:InitThreeHumanKillDetail()
    self:AddComponent(EMMOMainUICOM.ThreeHumanKillDetailUi, {parent = self.rightTopNode, scale = {x=1,y=1,z=1}});
end

function MMOMainUI:InitMobaFightTips()
    self:AddComponent(EMMOMainUICOM.MobaFightTipsUi, {parent = self.ui, scale = {x=1,y=1,z=1}});
end

function MMOMainUI:GetMobaFightTips()
    return self:GetComponent(EMMOMainUICOM.MobaFightTipsUi)
end

function MMOMainUI:GetMobaFightTipsRes()
    return __GetUIResList(EMMOMainUICOM.MobaFightTipsUi)
end

---------------------------手指滑动移动镜头------------------------------------
function MMOMainUI:InitTouchMoveCamera()
    self:AddComponent(EMMOMainUICOM.NewFightUITouchMoveCamera, {parent = self.ui, scale = {x=1,y=1,z=1}});
end

function MMOMainUI:GetTouchMoveCamera()
    return self:GetComponent(EMMOMainUICOM.NewFightUITouchMoveCamera)
end

function MMOMainUI.GetTouchMoveCameraRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUITouchMoveCamera);
end

-----------------------时间-----------------------
function MMOMainUI:InitTimer()
    local com = self:GetComponent(EMMOMainUICOM.NewFightUiTimer)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiTimer, 
            {
            parent = self.rightTopNode,
            });
    else
        com:Show();
    end
end

function MMOMainUI.GetTimerRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiTimer);
end

-------------------------------走马灯-----------------------------------------
function MMOMainUI:InitZouMaDeng()
    self:AddComponent(EMMOMainUICOM.NewFightUIZouMaDeng, {parent = self.ui, scale = {x=1,y=1,z=1}});
end
-------------------------------功能预告---------------------------------------
function MMOMainUI:InitAdvFuncNotice()
	AdvFuncButton.initConfig();
	self:AddComponent(EMMOMainUICOM.NewFightUIAdvFuncNotice,{parent = self.ui, scale = {x=1,y=1,z=1}})
end 

function MMOMainUI.GetZouMaDengRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUIZouMaDeng);
end

-----------------通用tips------------------------
function MMOMainUI:InitDescription(str, time)
    local com = self:GetComponent(EMMOMainUICOM.NewFightUiDescription)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiDescription,
        {
            parent = self.ui,
            str = str,
            time = time,
            }
        )
    else
        com:Show()
    end
end

function MMOMainUI.GetDescriptionRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiDescription);
end

-------------------------主界面聊天-----------------------
function MMOMainUI:InitMainChat()
    self:AddComponent(EMMOMainUICOM.MainUIChat,{uiNode = self.ui, parent = self.ui, scale = {x=1,y=1,z=1}})
end

-------------------------战斗聊天-----------------------
function MMOMainUI:InitWorldChat()
    self:AddComponent(EMMOMainUICOM.NewFightUIWorldChat,{parent = self.downNode, scale = {x=1,y=1,z=1}})
end

function MMOMainUI.GetWorldChatRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUIWorldChat);
end

-----------------------玩法任务情况-----------------------
function MMOMainUI:InitTask(data)

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiTask)
    if com == nil then
        data = data or {};
        data.parent = self.ui;
        self:AddComponent(EMMOMainUICOM.NewFightUiTask, data)
    else
        com:Show()
    end
end

function MMOMainUI.GetTaskRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiTask);
end

function MMOMainUI:GetTask()
    return self:GetComponent(EMMOMainUICOM.NewFightUiTask)
end

---------------------大乱斗-------------------------
function MMOMainUI:InitFuzion()
    local com = self:GetComponent(EMMOMainUICOM.FuzionFightUI)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.FuzionFightUI,{parent = self.ui, scale = {x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI.GetFuzionRes()
   return __GetUIResList(EMMOMainUICOM.FuzionFightUI);
end

---------------------(10人)大乱斗-------------------------
function MMOMainUI:InitFuzion2()
    local com = self:GetComponent(EMMOMainUICOM.Fuzion2FightUI)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.Fuzion2FightUI,{parent = self.ui, scale = {x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI.GetFuzion2Res()
   return __GetUIResList(EMMOMainUICOM.Fuzion2FightUI);
end
---------------------进度条-------------------------
function MMOMainUI:InitProgressBar()
    self:AddComponent(EMMOMainUICOM.MainUIProgressBar,{parent = self.ui, scale = {x=1,y=1,z=1}});
end

function MMOMainUI.GetProgressBarRes()
   return __GetUIResList(EMMOMainUICOM.MainUIProgressBar);
end

-- 显示文本,时间(秒),进度结束回调
function MMOMainUI:ProgressBarShowProgress(str, totalTime, callback)
    local com = self:GetComponent(EMMOMainUICOM.MainUIProgressBar)

    if com then
        com:ProgressBarShowProgress(str, totalTime, callback)
    end
end
function MMOMainUI:ProgressBarCanelProgress()
    local com = self:GetComponent(EMMOMainUICOM.MainUIProgressBar)

    if com then
        com:ProgressBarCanelProgress()
    end
end

function MMOMainUI:InitMMOFightUIClick(is_open_click_move)
    if is_open_click_move == nil then
        is_open_click_move = false
    end
    self:AddComponent(EMMOMainUICOM.MMOFightUIClick,{parent = self.ui, scale = {x=1,y=1,z=1}, is_open_click_move=is_open_click_move});
end

function MMOMainUI.GetMMOFightUIClickRes()
   return __GetUIResList(EMMOMainUICOM.MMOFightUIClick);
end

function MMOMainUI:InitRecommender()
    --RecommendMgr.Inst():Start()
end

function MMOMainUI:InitTeamUpgrade()
    --self:AddComponent(EMMOMainUICOM.MainUITeamUpgrade,{parent = self.ui, scale = {x=1,y=1,z=1}});
end

function MMOMainUI.GetTeamUpgradeRes()
   return __GetUIResList(EMMOMainUICOM.MainUITeamUpgrade);
end
-------------敌方血条------------------------
function MMOMainUI:InitEnemyHp()
    local com = self:GetComponent(EMMOMainUICOM.MainUIEnemyHp)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.MainUIEnemyHp,{parent = self.ui, scale = {x=1,y=1,z=1}});
    else
        com:Show()
    end
end

function MMOMainUI.GetEnemyHpRes()
   return __GetUIResList(EMMOMainUICOM.MainUIEnemyHp);
end

function MMOMainUI:GetEnemyHp()
    return self:GetComponent(EMMOMainUICOM.MainUIEnemyHp)
end
----------------------------------------------


function MMOMainUI:InitAutoPathFindingUI()
    self:AddComponent(EMMOMainUICOM.MainUIAutoPathFinding,{parent = self.ui, scale = {x=1,y=1,z=1}});
end

function MMOMainUI.GetAutoPathFindingUIRes()
    return __GetUIResList(EMMOMainUICOM.MainUIAutoPathFinding);
end

function MMOMainUI:InitPlayerHead()
    --self:AddComponent(EMMOMainUICOM.MainUIPlayerHead, {parent = self.leftTopNode, scale = {x=1,y=1,z=1}})
end

function MMOMainUI:InitTeamJustShow()
    self:AddComponent(EMMOMainUICOM.MainUITeamJustShow, {parent = self.leftTopNode, scale = {x=1,y=1,z=1}})
end

function MMOMainUI:InitMMOPosExp(data)
    data = data or {}
    data.parent = self.leftTopNode
    self:AddComponent(EMMOMainUICOM.MainUIMMOPosExp, data)
end

function MMOMainUI.GetMMOPosExpRes()
    return __GetUIResList(EMMOMainUICOM.MainUIMMOPosExp);
end

--fy添加用于固定心跳同步血条的方法
function MMOMainUI:InitBossHeartHP( bossConfigID, lv )
    local com = self:GetComponent(EMMOMainUICOM.NewBossHPHeartSyncUI)
    local max_hp = 100;
    local cur_hp = 100;
    local name = "None";
    local level = 1;
    local monsterCfg = ConfigManager.Get(EConfigIndex.t_monster_property,bossConfigID);
    if monsterCfg then
        name = monsterCfg.name;
        max_hp = monsterCfg.max_hp;
        cur_hp = monsterCfg.max_hp;
        level = lv or monsterCfg.level;
    end
    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewBossHPHeartSyncUI,{
            parent = self.topNode,
            configID = bossConfigID,
            bossData = { configID = bossConfigID, max_hp = max_hp, cur_hp = cur_hp, name = name, level = level },
            });
    end
end

function MMOMainUI:GetBossHeartHP()
    return self:GetComponent(EMMOMainUICOM.NewBossHPHeartSyncUI);
end
---------------------观战模式文字-------------------------
function MMOMainUI:InitViewer()
    local com = self:GetComponent(EMMOMainUICOM.Viewer)
    if com == nil then
        self:AddComponent(EMMOMainUICOM.Viewer,{parent = self.ui, scale = {x=1,y=1,z=1}});
    else
        com:Show();
    end
end
-----------------------社团boss--------------------
function MMOMainUI:InitGuildBoss()

    local com = self:GetComponent(EMMOMainUICOM.NewFightUiGuildBoss)

    if com == nil then
        self:AddComponent(EMMOMainUICOM.NewFightUiGuildBoss ,{parent = self.ui, scale = {x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI.GetViewer()
   return __GetUIResList(EMMOMainUICOM.Viewer);
end

function MMOMainUI.GetGuildBossRes()
   return __GetUIResList(EMMOMainUICOM.NewFightUiGuildBoss);
end

----------------------大乱斗上击杀排名显示-----------
function MMOMainUI:InitFightFuzionTop()
    local com = self:GetComponent(EMMOMainUICOM.FightFuzionTopUI);
    if com == nil then
        self:AddComponent(EMMOMainUICOM.FightFuzionTopUI, {parent=self.ui, scale={x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI:GetFightFuzionTop()
   return self:GetComponent(EMMOMainUICOM.FightFuzionTopUI);
end


---------------------- 显示波数-------------------
function MMOMainUI:InitShowFightWave()
    self:AddComponent(EMMOMainUICOM.MainUIShowFightWave, {parent = self.ui} )
end

function MMOMainUI.GetShowFightWaveRes()
    return __GetUIResList(EMMOMainUICOM.MainUIShowFightWave);
end

---------------------- 触发器UI -----------------
function MMOMainUI:InitTriggerOperator()
    self:AddComponent(EMMOMainUICOM.MainUITriggerOperator, {parent = self.ui} )
end
---------------------极限挑战buffUI-------------------------
function MMOMainUI:InitKuiKuLiYaFightBuffUI(hurdle_id)
    local com = self:GetComponent(EMMOMainUICOM.KuiKuLiYaFightBuffUI)
    if com == nil then
        com = self:AddComponent(EMMOMainUICOM.KuiKuLiYaFightBuffUI, {parent = self.topNode, scale = {x=1,y=1,z=1}, });
    end
    com:Show(hurdle_id);
end

--------------私有函数--------------
function MMOMainUI:OnShow()
    for k,v in pairs(self.components) do
        if v.OnShow then
            v:OnShow()
        end
    end
    local isFirst = nil;
    if os.time() - self.leaveTime > 30 then
        isFirst = true;
    end
    self:InitSceneEffect(isFirst);
end

function MMOMainUI:OnHide()
    for k,v in pairs(self.components) do
        if v:IsShow() and v.OnHide then
            v:OnHide()
        end
    end
end
---------------------------------场景效果---------------------------------------------------
function MMOMainUI:InitSceneEffect(isFirst)
    if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
        return;
    end
    --self:UpdateSceneLight();
    --self:UpdateSceneMoon();
    --self:UpdateSceneRole(isFirst);
    --self:UpdateSceneBell();
end
function MMOMainUI:UpdateSceneLight()
    --------------------------楼灯--------------------------------
    if self.listPos == nil then
        self.listPos = {};
        self.listPos.objRoot = asset_game_object.find("point_light");
        local childCount = self.listPos.objRoot:get_child_count();
        for i = 0, childCount-1 do
            self.listPos[i] = self.listPos.objRoot:get_child_by_index(i);
        end 
    end
    if self.listLight == nil then
        self.listLight = {};
        self.listLight.objRoot = asset_game_object.find("fx_denglujiemian_light");
        local childCount = self.listLight.objRoot:get_child_count();
        for i = 0, childCount-1 do
            self.listLight[i] = self.listLight.objRoot:get_child_by_index(i);
            self.listLight[i]:set_active(false);
        end
    end
    self.emptyCloneLight = self.cloneLight;
    self.cloneLight = {};
    --遍历位置
    --随机出到底几盏灯亮  +1是因为从0开始的
    local index = math.random(1, #self.listPos + 1);
    local listIndex = {};
    for i = 0, #self.listPos do
        table.insert(listIndex, i);
    end
    while index > 0 do
        local openIndex = math.random(1, #listIndex);
        local realIndex = listIndex[openIndex];
        --取一种颜色的灯
        local lightIndex = math.random(0, #self.listLight);
        self.cloneLight[lightIndex] = self.cloneLight[lightIndex] or {};
        local obj = nil;
        --得到显示灯的对象
        if self.emptyCloneLight and self.emptyCloneLight[lightIndex] and #self.emptyCloneLight[lightIndex] > 0 then
            obj = self.emptyCloneLight[lightIndex][1];
            table.insert(self.cloneLight[lightIndex], self.emptyCloneLight[lightIndex][1]);
            table.remove(self.emptyCloneLight[lightIndex], 1);
        else
            obj = self.listLight[lightIndex]:clone();
            table.insert(self.cloneLight[lightIndex], obj);
        end 
        --设置父节点以及显示
        obj:set_parent(self.listPos[realIndex]);
        obj:set_local_position(0, 0, 0);
        obj:set_local_scale(1, 1, 1);
        obj:set_active(true);
        --删除一个显示了的位置
        table.remove(listIndex, openIndex);
        index = index - 1;
    end
    --隐藏池里面的灯
    if self.emptyCloneLight then
        for k, v in pairs(self.emptyCloneLight) do
            for m, n in pairs(v) do
                n:set_active(false);
            end
        end
    end
end
function MMOMainUI:UpdateSceneMoon()
    --------------------月亮-----------------
    if self.listMoonPos == nil then
        self.listMoonPos = {};
        self.listMoonPos.objRoot = asset_game_object.find("point_moon");
        local childCount = self.listMoonPos.objRoot:get_child_count();
        for i = 0, childCount-1 do
            self.listMoonPos[i] = self.listMoonPos.objRoot:get_child_by_index(i);
        end 
    end
    if self.cloneMoon == nil then
        self.cloneMoon = asset_game_object.find("moon");
    end
    local moonPosIndex = math.random(0, #self.listMoonPos);
    self.cloneMoon:set_parent(self.listMoonPos[moonPosIndex]);
    self.cloneMoon:set_local_position(0, 0, 0);
    self.cloneMoon:set_local_scale(1, 1, 1);
    self.cloneMoon:set_active(true);
end
local RoleModelList = 
{
    "assetbundles/prefabs/character/zjm_jinmu/zjm_jinmu_fbx.assetbundle",
    "assetbundles/prefabs/character/zjm_heinainaibai/zjm_heinainaibai_fbx.assetbundle",
    "assetbundles/prefabs/character/zjm_dongxiang/zjm_dongxiang_fbx.assetbundle",
}
local AnimationName = 
{
    "in",
    "stand01",
    "stand02",
    "idle01",
    "idle02",
    "out",
}
local ChangeAnim = 
{
    "t_idle01",
    "t_idle02",
    "t_out",
}
--isFirst 是否是需要重新初始化
--isSpe 是否是离场
function MMOMainUI:UpdateSceneRole(isFirst, isSpe)
    if isFirst then
        local curSelect = nil;
        if self.curSelect then
            curSelect = self.curSelect.selectIndex;
            self.curSelect.obj:set_active(false);
            self.curSelect.obj = nil;
            self.curSelect = nil;
        end
        local newSelect = math.random(1, #RoleModelList);
        --董香需要特殊处理  不能接离场动作
        while (isSpe and newSelect == 3) or newSelect == curSelect do
            newSelect = newSelect + 1;
            if newSelect > #RoleModelList then
                newSelect = 1;
            end
        end
        --非离场的时候需要一个个英雄出来
        if not isSpe then
            self.alreadyShowRole = self.alreadyShowRole or {};
            if #self.alreadyShowRole == #RoleModelList then
                self.alreadyShowRole = {};
            end
            while self.alreadyShowRole[newSelect] do
                newSelect = newSelect + 1;
                if newSelect > #RoleModelList then
                    newSelect = 1;
                end
            end
            self.alreadyShowRole[newSelect] = 1;
        end
        ResourceLoader.LoadAsset(RoleModelList[newSelect], function(pid, fpath, asset_obj, error_info)
                self.curSelect = self.curSelect or {};
                self.curSelect.obj = asset_game_object.create(asset_obj);
                -- local c =  asset_game_object.find("login_background");
                -- if c then
                --     self.curSelect.obj:set_parent(c);
                -- end
                self.curSelect.obj:set_local_position(0, 0, 0);
                self.curSelect.obj:set_local_scale(1, 1, 1);
                self.curSelect.obj:set_active(true);
                self.curSelect.selectIndex = newSelect;
            end)
    end
    
end

function MMOMainUI:UpdateSceneBell()
    if self.objBell == nil then
        self.objBell = asset_game_object.find("F_denglujiemian_building003");
    end
end
function MMOMainUI:ClickSceneRole(name,x,y,game_obj)
    --用来防止场景出来正在加载钟的时候  ui就已经掉了更新操作以至于self.objBell找不到   
    self:UpdateSceneBell();
    --钟点击处理
    if self.objBell then
        local bit_table = {};
        bit_table[1]=PublicStruct.UnityLayer.npc;
        local layer_mask = PublicFunc.GetBitLShift(bit_table);
        local result, hitinfo = util.raycase_out_object(x,y,2000,layer_mask);
        if result then
            if self.objBell:is_animator_name(0, "denglujiemian_zhong") then
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.Bell);
                self.objBell:set_animator_string_trigger("t_idle01");    
            end
            return;
        end
    end
    --董香需要特殊处理
    if self.curSelect.selectIndex == 3 then
        if self.curSelect.nextClickAnim == nil or self.curSelect.obj:is_animator_name(0, self.curSelect.nextClickAnim) then
            local bit_table = {}
            bit_table[1]=PublicStruct.UnityLayer.player
            local layer_mask = PublicFunc.GetBitLShift(bit_table)
            local result, hitinfo = util.raycase_out_object(x,y,2000,layer_mask);
            if result == true then
                if self.curSelect.obj:is_animator_name(0, AnimationName[3]) then
                    --翅膀出现
                    self.curSelect.obj:set_animator_string_trigger(ChangeAnim[2]);
                    self.curSelect.nextClickAnim = AnimationName[2];
                    AudioManager.PlayUiAudio(81200034)
                else
                    --翅膀消失
                    self.curSelect.obj:set_animator_string_trigger(ChangeAnim[1]);
                    self.curSelect.nextClickAnim = AnimationName[3];
                    AudioManager.PlayUiAudio(81200033)
                end
            end
        end
        return;
    end
    --不能重复点击播动画
    if self.curSelect.nextClickAnim == nil or self.curSelect.obj:is_animator_name(0, self.curSelect.nextClickAnim) then
        local bit_table = {}
        bit_table[1]=PublicStruct.UnityLayer.player
        local layer_mask = PublicFunc.GetBitLShift(bit_table)
        local result, hitinfo = util.raycase_out_object(x,y,2000,layer_mask);
        if result == true then
            if self.curSelect.obj:is_animator_name(0, AnimationName[3]) then
                self.curSelect.obj:set_animator_string_trigger(ChangeAnim[2]);
                self.curSelect.nextClickAnim = AnimationName[2];
                if self.curSelect.selectIndex == 1 then
                    AudioManager.PlayUiAudio(81200036)
                end
            --当前在离开状态不处理点击事件
            elseif self.curSelect.obj:is_animator_name(0, AnimationName[2]) then
                --如果第一次点击播放休闲  后面点击 休闲和离场随机播放
                if self.curSelect.firstClick == nil then
                    self.curSelect.firstClick = true;
                    self.curSelect.obj:set_animator_string_trigger(ChangeAnim[1]);
                    self.curSelect.nextClickAnim = AnimationName[3]
                    if self.curSelect.selectIndex == 1 then
                        AudioManager.PlayUiAudio(81200035)
                    end
                else
                    local isOut = math.random(1, 100);
                    if isOut > 50 then
                        self.curSelect.obj:set_animator_string_trigger(ChangeAnim[3]);
                        self.curSelect.nextClickAnim = AnimationName[6]
                        if self.curSelect.selectIndex == 1 then
                            AudioManager.PlayUiAudio(81200084)
                        end
                    else
                        self.curSelect.obj:set_animator_string_trigger(ChangeAnim[1]);
                        self.curSelect.nextClickAnim = AnimationName[3];
                        if self.curSelect.selectIndex == 1 then
                            AudioManager.PlayUiAudio(81200035)
                        end
                    end
                end
            end
        end
    end
end

function MMOMainUI:DestroySceneEffect()
    self.listPos = nil;
    self.listLight = nil;
    if self.cloneLight then
        for k, v in pairs(self.cloneLight) do
            self.cloneLight[k] = nil;
        end
        self.cloneLight = nil;
    end
    if self.emptyCloneLight then
        for k, v in pairs(self.emptyCloneLight) do
            for m, n in pairs(v) do
                v[m] = nil;
            end
        end
        self.emptyCloneLight = nil;
    end
    self.listMoonPos = nil;
    self.cloneMoon = nil;
    if self.curSelect then
        self.curSelect.obj:set_active(false);
        self.curSelect.obj = nil;
        self.curSelect = nil;
    end
end

function MMOMainUI.OnLeave()
    GetMainUI():UpdateSceneRole(true, true);
end

----------------------大乱斗上击杀排行榜显示-----------
function MMOMainUI:InitFightFuzionRank()
    local com = self:GetComponent(EMMOMainUICOM.Fuzion2FightRankUI);
    if com == nil then
        self:AddComponent(EMMOMainUICOM.Fuzion2FightRankUI, {parent=self.leftTopNode, scale={x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI:GetFightFuzionRank()
   return self:GetComponent(EMMOMainUICOM.Fuzion2FightRankUI);
end

----------------------大乱斗上头像显示-----------
function MMOMainUI:InitTeamFuzion2()
    local com = self:GetComponent(EMMOMainUICOM.Fuzion2TeamUI);
    if com == nil then
        self:AddComponent(EMMOMainUICOM.Fuzion2TeamUI, {parent=self.ui, scale={x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI:GetTeamFuzion2()
   return self:GetComponent(EMMOMainUICOM.Fuzion2TeamUI);
end

--MainUiFirstShowVerbosUi(false)
----------------------关卡采集界面-----------
function MMOMainUI:InitHurdleCollectBoxUi()
    local com = self:GetComponent(EMMOMainUICOM.HurdleCollectBoxUi);
    if com == nil then
        self:AddComponent(EMMOMainUICOM.HurdleCollectBoxUi, {parent=self.ui, scale={x=1,y=1,z=1}});
    else
        com:Show();
    end
end

function MMOMainUI:GetHurdleCollectBoxUi()
   return self:GetComponent(EMMOMainUICOM.HurdleCollectBoxUi);
end

-- 主角复活倒计时
function MMOMainUI:InitCaptainRebornTip()
    self:AddComponent(EMMOMainUICOM.MainUiCaptainRebornTip, {parent = self.ui})
end
-- -------------------关卡通关提示-------------
-- function MMOMainUI:InitHurdlePassTip()
--     local com = self:GetComponent(EMMOMainUICOM.HurdlePassTip);
--     if com == nil then
--         self:AddComponent(EMMOMainUICOM.HurdlePassTip, {parent=self.ui, scale={x=1,y=1,z=1}});
--     else
--         com:Show();
--     end
-- end

-- function MMOMainUI:GetHurdlePassTip()
--    return self:GetComponent(EMMOMainUICOM.HurdlePassTip);
-- end
------------------------------------------

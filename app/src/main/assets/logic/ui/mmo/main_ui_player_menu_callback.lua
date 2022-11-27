
local _UIText = {
    [1] = "级",
    [2] = "是否取消所有申请?"
}
local _totalLayer = 11

function MainUIPlayerMenu:OnClickApBtn()
    uiManager:GetNavigationBarUi():on_ap()
end

function MainUIPlayerMenu:OnClickCrystalBtn()
    uiManager:GetNavigationBarUi():on_crystal()
end

function MainUIPlayerMenu:OnClickGoldBtn()
    uiManager:GetNavigationBarUi():on_gold()
end


-- 战队
function MainUIPlayerMenu:OnClickBattle()
    --uiManager:PushUi(EUI.FormationUi2);
    -- g_dataCenter.worldBoss:FightResult({"劳伦特糖糖"},{"劳伦特糖糖","劳伦特糖糖"},
    --     {
    --     {id=2,dataid='',count=60000,},
    --     {id=20000065,dataid='',count=1,},
    --     {id=20000004,dataid='',count=5,},
    --     {id=20000005,dataid='',count=4,},})
    --CommonAward.Start({{id=20000009,count=1000},{id=20000022,count=1000},{id=20000012,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},{id=2,count=1000},});
    -- local temp = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    -- temp:SetFightResult({
    --     winFlag=1,
    --     players={
    --     {roleId=30001002, kill=7,level=2,name='狂小萝莉',dead=7},
    --     {roleId=30001002, kill=1,level=1,name='真不该五十年',dead=9},
    --     {roleId=30001042, kill=1,level=1,name='贝亚特小宇宙',dead=9},
    --     {roleId=30001002, kill=4,level=2,name='碎语芒果',dead=10},
    --     {roleId=30001012, kill=6,level=1,name='藏心暖色系',dead=13},
    --     {roleId=30001002, kill=1,level=1,name='伊迪萨木头',dead=10},}
    --     }, {{id=2, count=11708}});
    -- temp:EndGame();
    uiManager:PushUi(EUI.ClanUI);
end

-- 英雄
function MainUIPlayerMenu:OnClickHero()
    uiManager:PushUi(EUI.HeroPackageUI);
end

-- 背包
function MainUIPlayerMenu:OnClickBag()
    uiManager:PushUi(EUI.PackageUi);
end

-- 公会
function MainUIPlayerMenu:OnClickGuide()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Guild)
end

-- 排行榜
function MainUIPlayerMenu:OnClickRank()
    uiManager:PushUi(EUI.RankUI, {default=true}); --TODO 排行榜需求变更待修改
end

-- 好友
function MainUIPlayerMenu:OnClickFriend()
    uiManager:PushUi(EUI.FriendUi);
end

-- 区域
function MainUIPlayerMenu:OnClickArea()
	uiManager:PushUi(EUI.AreaMainUI);
end 

-- 变强
function MainUIPlayerMenu:OnClickStrong()
    uiManager:PushUi(EUI.UiDevelopGuide);
end

-- 合成
function MainUIPlayerMenu:OnClickCompound()
    uiManager:PushUi(EUI.EquipCompoundUI);
    -- local defTeam = g_dataCenter.player:GetDefTeam();
    -- local roleCards = {}
    -- for i = 1, #defTeam do
    --  local role = g_dataCenter.package:find_card(1, defTeam[i]);
    --  if role then
    --      table.insert(roleCards, role);
    --  end
    -- end
    -- local data = 
    -- {
    --      battle = {
    --       players={
    --           left= {player=g_dataCenter.player, cards=roleCards},
    --           right= {player=g_dataCenter.player, cards=roleCards},
    --       },
    --       fightResult={
    --           isWin = false,
    --           leftCount = 1,
    --           rightCount = 3,
    --           leftEquipSouls = 1,
    --           rightEquipSouls = 3,
    --       },
    --      },
    --      star = {star = 2, finishConditionInfex={[1] = 1, [3] = 1}, conditionDes={"111", "222", "333"}, showTitle=true},
    --      addexp = {player = g_dataCenter.player, cards=roleCards},
    --      jump = {jumpFunctionList={ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipComposite, ENUM.ELeaveType.EquipLevelUp,}},
    --      awards = {awardsList={{id=2, count=3},{id=2, count=3},{id=2, count=3},}, tType=2},
    -- }
    -- CommonClearing.Start(data);
end

-- 打造
function MainUIPlayerMenu:OnClickForge()
    uiManager:PushUi(EUI.UiEquipForge);
end

-- 武装
function MainUIPlayerMenu:OnClickArms()
    uiManager:PushUi(EUI.EquipPackageUI);
end

-- 设置
function MainUIPlayerMenu:OnClickSet()
    uiManager:PushUi(EUI.UiSet);
end

-- 冒险
function MainUIPlayerMenu:OnDrama()
    local npcid = ConfigHelper.GetNpcIdBySystemid(MsgEnum.eactivity_time.eActivityTime_Adventure);
    local npc = ObjectManager.GetObjectByNumber(npcid);
    if npc and FightScene.GetFightManager() 
        and FightScene.GetFightManager().MoveCaptainToNpc then
        FightScene.GetFightManager():MoveCaptainToNpc(npc);
    else
        EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Adventure)
    end
end

-- 玩法
function MainUIPlayerMenu:OnClickPlay()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Playing)
end

-- 对战
function MainUIPlayerMenu:OnClickFight()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Fight)
end

--[[主界面对决]]
function MainUIPlayerMenu:OnClickDuel()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Duel)
end

-- 招募
function MainUIPlayerMenu:OnClickRecruit()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Recruit)
end

-- 任务
function MainUIPlayerMenu:OnClickMission()
    uiManager:PushUi(EUI.UiDailyTask);
end

-- 装备库
function MainUIPlayerMenu:OnClickEquip()
    EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Equip)
end

-- 首充
function MainUIPlayerMenu:OnClickFirst()
    app.log("MainUIPlayerMenu:OnClickFirst")
    uiManager:PushUi(EUI.UiFirstRecharge);
end

-- 贩卖机
function MainUIPlayerMenu:OnClickVendingMachine()
    uiManager:PushUi(EUI.VendingMachineUI)
end

-- 活动
function MainUIPlayerMenu:OnClickActivity()
    --GetMainUI():GetSkillInput():UseSkill(0, 0, true, 2)
    --GetMainUI():GetSkillInput():DragSkill(734, 27, 2)
    uiManager:PushUi(EUI.ActivityUI);
end

-- 商城
function MainUIPlayerMenu:OnClickStore()
    app.log("MainUIPlayerMenu:OnClickStore")
    uiManager:PushUi(EUI.StoreUI);
end

-- 福利
function MainUIPlayerMenu:OnClickWelfare()
    app.log("MainUIPlayerMenu:OnClickWelfare")
end

-- function MainUIPlayerMenu:againFunc()
--     app.log("MainUIPlayerMenu:againFunc")
-- end

-- 邮箱
function MainUIPlayerMenu:OnClickMail()
    uiManager:PushUi(EUI.MailListUI);
    --self.seeui = SeeAssertBundleUI:new()

    -- CommonAward.Start({{id = 2, count = 100},
    -- {id = 3, count = 100},
    -- {id = 4, count = 100},
    -- {id = 5, count = 100},
    -- {id = 6, count = 100},
    -- {id = 7, count = 100},
    -- {id = 8, count = 100},
    -- {id = 9, count = 100},
    -- {id = 10, count = 100},
    -- {id = 11, count = 100},
    -- {id = 12, count = 100},
    -- {id = 13, count = 100},
    -- }, CommonAwardEType.operatorAgain, nil, {againFunc =MainUIPlayerMenu.againFunc, againParam = self, againCostId = 2, againCostNum = 5656 })

--    local defTeam = g_dataCenter.player:GetDefTeam()
--    local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])
--    UiHeroStarUpAnimation.SetAndShow( { roleData = card });
--    local defTeam = g_dataCenter.player:GetDefTeam()
--    CommonGetHero.Start(defTeam[1])

--    local data = 
--    {
--        star = 
--        {
--            star = 2, 
--            finishConditionInfex = {true, true, false}, 
--            conditionDes = {'条件一sdfsdf', '条件二xxxxxxx', '条件三'}, 
--            showTitle = true,
--        },
--        addexp =
--        {
--            player = g_dataCenter.player,
--            cards = 
--            {

--            }
--        },


--        awards = 
--        {
--            awardsList = {{id=2, count = 2}, {id=3, count = 1}}
--        },

--		    jump = 
--		    {
--		    	jumpFunctionList = {ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipLevelUp},
--		    }

--    }
    --UiHeroStarUpAnimation.SetAndShow({roleData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])})
--    local defTeam = g_dataCenter.player:GetDefTeam();
--    for i=1,2 do
--        local hero = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[i]);
--        table.insert(data.addexp.cards, hero)
--    end
    
    --CommonClearing.Start(data);

--    CommonAwardWroldBoss.Start(1234, 3, {{id=2, count=5}, {id=1, count=50}, {id=3, count=1}, {id=1, count=50}, {id=2, count=5}},
--    {{id=3, count=1},  {id=1, count=50}, {id=2, count=5}, {id=1, count=50}, {id=2, count=5}}

--    )

--    CommonPlayerLevelup.Start(
--        {
--            oldData = {level = 10},
--            level = 15
--        }
--    )


    --CommonAwardGuildBoss.Start(3432, 3, {{id = 2, count = 200}}, {{id = 2, count = 200}}, {{id = 2, count = 200}})
end

-- 签到
function MainUIPlayerMenu:OnClickSign()
    uiManager:PushUi(EUI.SevenSignUi);
    -- uiManager:PushUi(EUI.SevenSignUiSignin);
end

-- 充值
function MainUIPlayerMenu:OnClickRecharge()
    uiManager:PushUi(EUI.StoreUI)
end

-- 小地图
function MainUIPlayerMenu:OnClickMap()
    uiManager:PushUi(EUI.UiMap);
end

function MainUIPlayerMenu:OnClickVip()
    uiManager:PushUi(EUI.StoreUI, "vip")
end

function MainUIPlayerMenu:OnClickInvite()
    local inviteList = g_dataCenter.player.inviteList or {}
    local invite = table.remove(inviteList, 1)
    if invite then
        local cbfunc1 = function ()
            player.cg_invite_state(0, invite)
        end
        local cbfunc2 = function ()
            player.cg_invite_state(1, invite)
        end
        local eVsName = {
            [0] = "3V3攻防战",
        }
        local content = "玩家[FFB400FF]%s[-]邀请您参加%s"
        content = string.format(content, invite.name, eVsName[invite.nType] or "")
        HintUI.SetAndShow(EHintUiType.two, content,
            {str = "接受", func = cbfunc1},
            {str = "拒绝", func = cbfunc2});

        self:UpdateUi()
    end
end

function MainUIPlayerMenu:gc_get_invite(info)
    self:UpdateUi()
end

--签到
function MainUIPlayerMenu:OnClickEverydaySign()
    app.log('MainUIPlayerMenu:OnClickEverydaySign')
    uiManager:PushUi(EUI.MonthSignUi);
    -- uiManager:PushUi(EUI.SevenSignUi);
end

--七日
function MainUIPlayerMenu:OnClickSevenSign()
    app.log('MainUIPlayerMenu:OnClickSign')
    uiManager:PushUi(EUI.SevenSignUi);
end

--七日
function MainUIPlayerMenu:OnClickSevenSign_back()
    app.log('MainUIPlayerMenu:OnClickSign_back')
    uiManager:PushUi(EUI.SevenSignBackUi);
end

--礼包
function MainUIPlayerMenu:OnClickGiftBag()
    app.log('MainUIPlayerMenu:OnClickGiftBag')
    -- uiManager:PushUi(EUI.VipPrivilegeUI, 0);
    uiManager:PushUi(EUI.VipPackingUI);
end
-- 一元购
function MainUIPlayerMenu:OnClickBuy1( )
    app.log('MainUIPlayerMenu:OnClickBuy1')
    uiManager:PushUi(EUI.UiBuy1);
end

-- 一元购
function MainUIPlayerMenu:onPowerRank( )
    app.log('MainUIPlayerMenu:onPowerRank')
    uiManager:PushUi(EUI.PowerRankUI);
end
-- 招财猫
function MainUIPlayerMenu:onLuckyCat( )
    app.log('MainUIPlayerMenu:onLuckyCat')
    uiManager:PushUi(EUI.LuckyCatUI);
end
--整容
function MainUIPlayerMenu:OnClickTeam()
    uiManager:PushUi(EUI.FormationUi2);
end

--登录送礼
function MainUIPlayerMenu:OnClickLonginGift()
    app.log("MainUIPlayerMenu:OnClickLonginGift");
    uiManager:PushUi(EUI.LoginRewardUI);
end

function MainUIPlayerMenu:OnClickLimitBuy()
    uiManager:PushUi(EUI.ActivityStoreUI)
end

-----------------------------------------------------------------------------------------------------
function MainUIPlayerMenu:gc_change_activity_time(activityid)
    if not self:IsShow() then
        return
    end
    self:ShowUnLockedMenuItem()

    self:__CheckActivityTime(activityid)
end

function MainUIPlayerMenu:gc_pause_activity()
    if not self:IsShow() then
        return
    end
    self:ShowUnLockedMenuItem()
end

function MainUIPlayerMenu:gc_init_activity_state(activity_state_list)
    if not self:IsShow() then
        return
    end
    self:ShowUnLockedMenuItem()

    for k,v in pairs(activity_state_list) do
        local activityid = tonumber(v.activity_id)
        if activityid == ENUM.Activity.activityType_score_hero or activityid == ENUM.Activity.activityType_golden_egg then
            self:__CheckActivityTime(activityid)
        end
    end
end


function MainUIPlayerMenu:__CheckActivityTime(activityId)
    local activityIdFunc = {
        [ENUM.Activity.activityType_score_hero] = self.bindfunc['activity_end_time_score_hero'],
        [ENUM.Activity.activityType_golden_egg] = self.bindfunc['activity_end_time_golden_egg'],
    }
    local func = activityIdFunc[activityId]
    if func == nil then
        --app.log('func == nil' .. debug.traceback())
        return
    end

    local activityEndTime = nil
    local config = g_dataCenter.activityReward:GetActivityTimeForActivityID(activityId)
    if config then
        activityEndTime = config.e_time
    else
        return
    end
    local diff = activityEndTime - system.time()
    if diff > 0 then
        TimerManager.Add(func, diff * 1000, 1)
    end
end

function MainUIPlayerMenu:activity_end_time_score_hero()
    if not self:IsShow() then
        return
    end
    self:ShowUnLockedMenuItem()
end

function MainUIPlayerMenu:activity_end_time_golden_egg()
    if not self:IsShow() then
        return
    end
    self:ShowUnLockedMenuItem()
end

-----------------------------------------------------------------------------------------------------

function MainUIPlayerMenu:OnClickScoreHero()
    uiManager:PushUi(EUI.ScoreHeroUI)
    g_dataCenter.activityReward:SetFirstOpenScoreHero(false)
end

function MainUIPlayerMenu:HandleScoreHeroTip()
    if not AppConfig.get_enable_guide_tip() then
        return
    end
    if self.spPointScoreHero == nil then
        return
    end
    local isActive = g_dataCenter.activityReward:IsShowScoreHeroTip()
    self.spPointScoreHero:set_active(isActive)
end

-----------------------------------------------------------------------------------------------------

function MainUIPlayerMenu:OnClickGoldenEgg()
    uiManager:PushUi(EUI.GoldenEggUI)
    g_dataCenter.activityReward:SetFirstOpenGoldenEgg(false)
end

function MainUIPlayerMenu:HandleGoldenEggTip()
    if not AppConfig.get_enable_guide_tip() then
        return
    end
    if self.spPointGoldenEgg == nil then
        return
    end
    local isActive = g_dataCenter.activityReward:IsShowGoldenEggTip()
    self.spPointGoldenEgg:set_active(isActive)
end

-----------------------------------------------------------------------------------------------------

function MainUIPlayerMenu:UpdateBtnPositioin()
    --更新ui位置
    for k, v in pairs(self.objBtnAdjustList) do
        if self.objBtnList[k] then
            local isSuc, rx, ry, rz = self:SceneWorldPosToUIWorldPos(self.sceneCamera3D, self.objBtnList[k]:get_position())
            if isSuc then
                v:set_position(rx, ry, rz)
            end
        end
    end
    if self.objTalk and self.talkNode then
        local isSuc, rx, ry, rz = self:SceneWorldPosToUIWorldPos(self.sceneCamera3D, self.objTalk:get_position())
        if isSuc then
            self.talkNode:set_position(rx + 0.55, ry - 0.1, rz)
        end
    end
end

function MainUIPlayerMenu:SceneWorldPosToUIWorldPos(sceneCamera, x, y, z)
    local uiCamera = Root.get_ui_camera();
    local isSuc, ux, uy, uz = false, 0, 0, 0
    if sceneCamera ~= nil and uiCamera ~= nil then
        local sx, sy, sz = sceneCamera:world_to_screen_point(x, y, z)
        ux, uy, uz = uiCamera:screen_to_world_point(sx, sy, 0);
        isSuc = true
    else
        app.log('camera == nil or ui_camera == nil')
    end
    return isSuc, ux, uy, uz
end


----------------------------------------主界面场景-----------------------------------

function MainUIPlayerMenu.GetUiNode(id)
    if MainUIPlayerMenu.idToUiNode == nil then
        MainUIPlayerMenu.idToUiNode = {}
    end
    return MainUIPlayerMenu.idToUiNode[id]
end

local _lightConfigData = {
    [1] = MsgEnum.eactivity_time.eActivityTime_Friend,
    [2] = MsgEnum.eactivity_time.eActivityTime_Activity,
    [3] = MsgEnum.eactivity_time.eActivityTime_Rank,
    [4] = nil,
    [5] = nil,
}

local _guideboardConfigData = {
    [1] = MsgEnum.eactivity_time.eActivityTime_Shop,
    [2] = MsgEnum.eactivity_time.eActivityTime_Rank,
    [3] = MsgEnum.eactivity_time.eActivityTime_Guild,
}

--local _ui = nil

function MainUIPlayerMenu:Init3dSceneUi()
	app.log("直接尝试前往主界面");
	--_ui = asset_game_object.find("p_zhuejiemian");
	--if _ui == nil then 
	--	app.log("空物体创建");
	--	local emobj = ResourceManager.GetResourceObject("assetbundles/prefabs/empty.assetbundle");
	--	_ui = asset_game_object.create(emobj);
	--	if _ui == nil then 
	--		_ui = ResourceLoader.LoadAsset("assetbundles/prefabs/empty.assetbundle");
	--	end
	--	--_ui:set_local_scale(1,1,1);
	--	--_ui:set_name("p_zhuejiemian");
	--end
    local main3dScene = asset_game_object.find("p_zhuejiemian")
    --local main3dScene = _ui
    self.objMoveLayer = {1,2,3,4,5,6,7,8,9}
    for i = 1, _totalLayer do
        self.objMoveLayer[i] = main3dScene:get_child_by_name("layer00" .. i)
    end
    local _x, _y, _z = self:GetLocalPositionByLayer(1)
    self.initPosX = _x

    --灯
    --[[self.objLight = {}
    for i = 1, 5 do
        self.objLight[i] = {
            ui = main3dScene:get_child_by_name("layer002/f_zhujiemian_deng/main_menu_deng00" .. i),
            bgUi = main3dScene:get_child_by_name("layer002/f_zhujiemian_deng002/main_menu_deng00" .. i)
        }
    end ]]
    --路牌
    self.objGuideboard = {}
    for i = 1, 3 do
        self.objGuideboard[i] = {
            ui = main3dScene:get_child_by_name("layer003/f_zhujiemian_lupai/main_menu_lupai00" .. i),
            --bgUi = main3dScene:get_child_by_name("layer003/f_zhujiemian_lupai002/main_menu_lupai00" .. i)
        }
        local unlockId = _guideboardConfigData[i]
        MainUIPlayerMenu.idToUiNode[unlockId] = self.objGuideboard[i].ui:get_child_by_name('f_zhuijiemian_tishi00' .. i .. '_001')
        MainUIPlayerMenu.idToUiNode[unlockId]:set_active(false)
    end

    --猫
    self.objCat = main3dScene:get_child_by_name("p_zhuejiemian/layer006/f_zhuijiemian_gongneng002")
    MainUIPlayerMenu.idToUiNode[MsgEnum.eactivity_time.eActivityTime_Task] = self.objCat:get_child_by_name('f_zhujiemian_renwu/f_zhuijiemian_tishi004')
    MainUIPlayerMenu.idToUiNode[MsgEnum.eactivity_time.eActivityTime_Task]:set_active(false)

    local spClickMask = ngui.find_sprite(self.ui, "Sprite");
    spClickMask:set_on_ngui_click(self.bindfunc['on_click_scene_object']);
    spClickMask:set_active(FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_MainCity);
    spClickMask:set_on_ngui_press(self.bindfunc['on_touch_begin'])
    spClickMask:set_on_ngui_drag_move(self.bindfunc['on_touch_move'])

    --按钮
    self.objBtnList = {}
    for i = 1, 5 do
        self.objBtnList[i] = main3dScene:get_child_by_name("zjm_btn00" .. i)
    end
    self.sceneCamera3D = camera.find_by_name("p_zhuejiemian/login_background_camera")
    self.TeamShow = MainUITeamShow:new({node=main3dScene})
end


function MainUIPlayerMenu:Update3dSceneUi()
    --[[for i = 1, 5 do
        local unlockId = _lightConfigData[i] 
        local isOpen = false
        if unlockId then
            isOpen = PublicFunc.FuncIsOpen(unlockId)
        end 
        self.objLight[i].ui:set_active(isOpen) 
        self.objLight[i].bgUi:set_active(not isOpen) 
    end]]
    for i = 1, 3 do
        local unlockId = _guideboardConfigData[i]
        local isOpen = false
        if unlockId then
            if unlockId == MsgEnum.eactivity_time.eActivityTime_Shop then
                isOpen = g_dataCenter.shopInfo:IsSomeShopEnabled()
            else
                isOpen = PublicFunc.FuncIsOpen(unlockId)
            end
        end
        self.objGuideboard[i].ui:set_active(isOpen)
        --self.objGuideboard[i].bgUi:set_active(not isOpen)
    end
    local isOpen = PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_Task)
    self.objCat:set_active(isOpen)
    self:UpdateBtnPositioin()
end

local _limitMaxX = 18
local _limitMinX = -30
local _touchMulti = 0.03
local _layerPos = {}
local _touchMoveXList = {}

function MainUIPlayerMenu:on_touch_begin(name, state, x, y, goObj)
    if GuideManager.GetSceneFunctionId() > 0 then
        return
    end

    if state == true then
        self.touchBeginX = x
        --初始位置
        for i = 1, _totalLayer do
            local _x, _y, _z = self:GetLocalPositionByLayer(i)
            _layerPos[i] = {x = _x, y = _y, z = _z}
        end
        local pos = _layerPos[1]
        self.layer1X, self.layer1Y, self.layer1Z = pos.x , pos.y, pos.z
        _touchMoveXList = {}
    else
        self.touchBeginX = nil
        --边界拉回
        local x,y,z = self:GetLocalPositionByLayer(1)
        if x > _limitMaxX then
            self:AddTweenAnimation(0.3, _limitMaxX)
        elseif x < _limitMinX then
            self:AddTweenAnimation(0.3, _limitMinX)
        else
            local count =  #_touchMoveXList
            if count > 1 then
                local dx = _touchMoveXList[count] - _touchMoveXList[count-1]
                local targetX = x - dx * _touchMulti * 5
                if targetX > _limitMaxX then
                    targetX = _limitMaxX
                elseif targetX < _limitMinX then
                    targetX = _limitMinX
                end
                self:AddTweenAnimation(0.5, targetX)
            end
        end
    end
end

function MainUIPlayerMenu:on_touch_move(name, x, y, goObj)
    if GuideManager.GetSceneFunctionId() > 0 then
        return
    end

    if self.touchBeginX == nil then
        return
    end
    table.insert(_touchMoveXList, x)
    if #_touchMoveXList > 3 then
        table.remove(_touchMoveXList, 1)
    end
    local targetX = self.layer1X + (self.touchBeginX - x) * _touchMulti
    --边界逼近及缓动
    if targetX >= _limitMaxX then
        targetX = math.atan(targetX - _limitMaxX) * 0.8/(math.pi * 0.5) + _limitMaxX
    elseif targetX <= _limitMinX then
        targetX = -math.atan(_limitMinX - targetX) * 0.8/(math.pi * 0.5) + _limitMinX
    end
    self:AddTweenAnimation(0.15, targetX)
end

function MainUIPlayerMenu:AddTweenAnimation(time, targetX)
    if targetX == nil or self.layer1Y == nil or self.layer1Z == nil then
        return
    end
    Tween.addTween(self.objMoveLayer[1], time,
    {["local_position"] = {targetX, self.layer1Y, self.layer1Z}}, Transitions.EASE_OUT, 0, nil, self.bindfunc['on_tween_update']);
end

function MainUIPlayerMenu:GetLocalPositionByLayer(layer)
    return self.objMoveLayer[layer]:get_local_position()
end

local _moveRatio = {
    [1] = 1,
    [2] = 1,
    [3] = 1,

    [4] = 0.9,
    [5] = 0.8,
    [6] = 0.67,
    [7] = 0.58,
    [8] = 0.58,

    [9] = 0.5,
    [10] = 0.45,
    [11] = 0.03,
}
function MainUIPlayerMenu:on_tween_update()
    local x, y, z = self:GetLocalPositionByLayer(1)
    local diffX = x - self.layer1X
    for i = 2, _totalLayer do
        local pos = _layerPos[i]
        self.objMoveLayer[i]:set_local_position(pos.x + diffX * _moveRatio[i], pos.y, pos.z)
    end
    self:UpdateBtnPositioin()
end

local _objectConfigData = {
    --商店
    ["main_menu_lupai001"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Shop,
        func = function()
            if g_dataCenter.shopInfo:CheckShopIsEnabled(ENUM.ShopID.MYSTERY) then
                g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.MYSTERY)
                return
            end
            g_dataCenter.shopInfo:OpenShop()
        end
    },
    --排行
    ["main_menu_lupai002"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Rank,
        func = function()
            uiManager:PushUi(EUI.RankUI, {default=true})
        end
    },
    --社团
    ["main_menu_lupai003"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Guild,
        func = function()
            EnterSystemFunction(MsgEnum.eactivity_time.eActivityTime_Guild)
        end
    },
    --任务
    ["f_zhuijiemian_gongneng002"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Task,
        func = function()
            uiManager:PushUi(EUI.UiDailyTask)
        end
    },
    --阵容
    ["main_menu_zhenrong"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Team,
        func = function()
            uiManager:PushUi(EUI.FormationUi2)
        end
    },
    --阵容
    ["main_menu_zhenrong"] = {
        id = MsgEnum.eactivity_time.eActivityTime_Team,
        func = function()
            uiManager:PushUi(EUI.FormationUi2)
        end
    },
}

function MainUIPlayerMenu:on_click_scene_object(name, x, y, game_obj)
    local bit_table = {}
    bit_table[1] = PublicStruct.UnityLayer.Default
    local layer_mask = PublicFunc.GetBitLShift(bit_table);
    local result, hitinfo = util.raycase_out_object(x, y, 2000, layer_mask)
    if result then
        local name = hitinfo.name
        local data = _objectConfigData[name]
        if data then
            if not GuideManager.IsGuideRuning() or GuideManager.GetSceneFunctionId() == data.id then
                --hitinfo.game_object:animated_stop(name)
                hitinfo.game_object:animated_play(name)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn)
                --if data.id == MsgEnum.eactivity_time.eActivityTime_Team then
                    --self.TeamShow:ClickHero("hero1");
                --end
            end
        end
        --点击英雄
    else
        if not GuideManager.IsGuideRuning() or GuideManager.GetSceneFunctionId() == MsgEnum.eactivity_time.eActivityTime_Team then
            bit_table[1] = PublicStruct.UnityLayer.player
            local layer_mask = PublicFunc.GetBitLShift(bit_table);
            local result, hitinfo = util.raycase_out_object(x, y, 2000, layer_mask)
            if result then
                self.TeamShow:ClickHero(hitinfo.name);
                --AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn)
                --uiManager:PushUi(EUI.FormationUi2)
                --NoticeManager.Notice(ENUM.NoticeType.MainSceneBtnClick, MsgEnum.eactivity_time.eActivityTime_Team)
            end
        end
    end
end

function MainUIPlayerMenu.OnOver(obj)
    local name = obj:get_name()
    local data = _objectConfigData[name]
    if data then
        data.func()
        --data.id 通知一下新手引导处理
        NoticeManager.Notice(ENUM.NoticeType.MainSceneBtnClick, data.id)
    end
end

function MainUIPlayerMenu.Get3dSceneBtnObj(id)
    if GetMainUI() == nil or GetMainUI():GetPlayerMenu() == nil then
        return nil
    end
    local ui = GetMainUI():GetPlayerMenu()
    if ui.objSceneBtn ~= nil then
        PublicFunc.msg_dispatch("MainUIPlayerMenu-->on_move_camera")
        return ui.objSceneBtn[id]
    end
    return nil
end

function MainUIPlayerMenu:on_move_camera()
    if self.objMoveLayer == nil or self.initPosX == nil then
        return
    end
    local x, y, z = self:GetLocalPositionByLayer(1)
    if x ~= self.initPosX then
        self:AddTweenAnimation(0.3, self.initPosX)
    end
end

-------------------------------------英雄头像-------------------------------

function MainUIPlayerMenu:InitPlayerUI()
    local leftTopPath = 'left_top/'
    self.allContentNode = self.ui:get_child_by_name("left_top")

    self.playerNameLabel = ngui.find_label(self.ui, leftTopPath .. 'sp_di/lab_name')
    self.playerNameLabel:set_text(tostring(g_dataCenter.player.name))

    self.vipNode = ngui.find_sprite(self.ui, leftTopPath .. 'sp_head_di/sp_vip')
    self.vipNodeNum = ngui.find_sprite(self.ui, leftTopPath .. 'sp_head_di/sp_vip_num')

    --self.vipLabel = ngui.find_label(self.ui, 'sp_di/lab')
    --self.vipBackSp = ngui.find_sprite(self.ui, 'sp_bk')
    self.fightValueLabel = ngui.find_label(self.ui, leftTopPath .. 'sp_di/txt_fight/lab_fight')
    self.levelLabel = ngui.find_label(self.ui, leftTopPath .. 'sp_di/lab_lv')


    local btn = ngui.find_button(self.ui, leftTopPath .. 'sp_head_di')
    btn:set_on_click(self.bindfunc['OnClickPlayerHead'])
    self.textureHead = ngui.find_texture(self.ui, leftTopPath .. 'sp_head_di/Texture')

    --local headParent = self.ui:get_child_by_name(leftTopPath .. 'sp_di/sp_head_di_item')
    --self.headUiItem = UiPlayerHead:new({parent = headParent, showBorder = false})
    --self.headUiItem:SetCallback(self.OnClickPlayerHead, self)
    -- self.headTexture = ngui.find_texture(self.ui, 'texture_human')
end

function MainUIPlayerMenu:UpdatePlayerUi()
    if self.ui == nil then return end
    if g_dataCenter.player.vip < 1 then
        self.vipNode:set_active(false)
        self.vipNodeNum:set_active(false)
        --self.vipBackSp:set_active(false)
    else
        self.vipNode:set_active(false)
        self.vipNodeNum:set_active(false)
        -- self.vipNodeNum:set_sprite_name("zjm_vip" .. g_dataCenter.player.vip)
        --self.vipBackSp:set_active(true)
        --self.vipLabel:set_text(tostring(g_dataCenter.player.vip))
    end

    self.fightValueLabel:set_text(tostring(g_dataCenter.player:GetFightValue()))
    self.levelLabel:set_text(tostring(g_dataCenter.player.level) .. _UIText[1])

    self.playerNameLabel:set_text(tostring(g_dataCenter.player.name))

    local roleid = nil
    local cf = ConfigHelper.GetRole(g_dataCenter.player.image);
    if cf then
        roleid = g_dataCenter.player.image
    else
        --[[
        local defTeam = g_dataCenter.player:GetDefTeam()
        local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])
        if cardInfo then
            roleid = cardInfo.number
        end
        ]]
    end

    local cfg = PublicFunc.GetHeroHeadCfg(roleid)
    if cfg and cfg.icon106 then
        self.textureHead:set_texture(cfg.icon106);
    end
    --self.headUiItem:SetRoleId(roleid)
    self:ShowVerbosContent(GetMainUI():GetFirstHideVerboseMenu())
end

function MainUIPlayerMenu:OnClickPlayerHead()
    --app.log('MainUIPlayerHead:OnClickPlayerHead')
    uiManager:PushUi(EUI.UiSet);
    --uiManager:PushUi(EUI.MaskMain);
end

function MainUIPlayerMenu:ShowVerbosContent(is)
    if self.verbosIsShow == is then
        return
    end
    self.verbosIsShow = is
    self.allContentNode:set_active(self.verbosIsShow)
end

------------------------------------------------------------------------

function MainUIPlayerMenu:InitChatFightUI()
    self.btnChatFightRequest = ngui.find_button(self.ui, 'left_top/btn_duel')
    self.btnChatFightRequest:set_on_click(self.bindfunc['on_chat_fight_request'])
    self.btnChatFightCancel = ngui.find_button(self.ui, 'left_top/btn_cha')
    self.btnChatFightCancel:set_on_click(self.bindfunc['on_chat_fight_cancel'])

    TimerManager.Add(self.bindfunc['check_chat_fight_request'], 1000, -1)
    self.isShowReqUI = nil
    self.curHaveRequest = false

    self.btnChatFightRequest:set_active(false)
    self.btnChatFightCancel:set_active(false)
end

function MainUIPlayerMenu:check_chat_fight_request()
    if not self:IsShow() then
        return
    end
    local _isShow = g_dataCenter.chatFight:HaveRequest(false)
    if self.isShowReqUI ~= _isShow then
        self.isShowReqUI = _isShow
        self.btnChatFightRequest:set_active(_isShow)
        self.btnChatFightCancel:set_active(_isShow)
    end

    --约战申请
    local flag = g_dataCenter.chatFight:HaveRequest(true)
    if flag then
        if self.otherActivityCnt <= 2 then
            self:HandleActivityPane()
        end
        self.lastTimeCall = false
    else
        if not self.lastTimeCall then
            self.lastTimeCall = true
            self:HandleActivityPane()
        end
    end
    --更新请求小红点
    if  flag ~= self.curHaveRequest then
        self.curHaveRequest = flag
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Chat_Fight_Request)
    end
end

function MainUIPlayerMenu:on_chat_fight_request()
    uiManager:PushUi(EUI.ChatFightRequestUI, {isFight = false})
end

function MainUIPlayerMenu:on_chat_fight_cancel()
    local _func = function()
        msg_1v1.cg_cancel_challenge(0)
    end
    HintUI.SetAndShow(EHintUiType.two, _UIText[2],  {str="确定", func = _func}, {str="取消"});
end
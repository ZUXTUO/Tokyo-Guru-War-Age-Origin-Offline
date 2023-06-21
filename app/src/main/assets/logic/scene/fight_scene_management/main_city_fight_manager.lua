

MainCityFightManager = Class('MainCityFightManager' , FightManager)

local MAX_ROBOT_COUNT = 15;

function MainCityFightManager.InitInstance()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
	FightManager.InitInstance(MainCityFightManager)
	return MainCityFightManager;
end

function MainCityFightManager:AddResourceLoad(gli)
    ResourceLoader.AddNetwork(gli,PlayerDataLoader)
end

function MainCityFightManager:OnUiInitFinish()

    GetMainUI():InitMainChat()
	GetMainUI():InitAdvFuncNotice();
    GetMainUI():InitZouMaDeng()
    --GetMainUI():InitJoystick()

    GetMainUI():InitPlayerMenu()
    --GetMainUI():InitPlayerHead()
    --GetMainUI():InitTeamJustShow()

    --GetMainUI():InitMMOFightUIClick()
	
	EmergencyAnnouncement.ShowUI();
    self:HandleChatUIPosition()

    ResourceManager.AddPermanentReservedRes(UiBigCard.GetRes()) -- 添加公用组件资源加载
    ResourceManager.AddPermanentReservedRes(GuideUI.GetResList()) -- 添加新手引导资源

    --第一次进入主界面，仅保留下面基础菜单显示
    if GuideManager.CheckFirstGuide() then
        MainUiFirstShowVerbosUi(false)
    else
        GuideManager.CheckAdventureAnimationBefore20Level()
    end

    --app.log("RealName============="..tostring(g_dataCenter.player:GetIsRealNameAuth()))


    --function isrename()
        --app.log("UserCenter.get_web_realname()..."..UserCenter.get_web_realname())
    --    if UserCenter.get_web_realname() ~= 0  then
    --        if g_dataCenter.player:GetRUnGameTIme() >= 3 then
    --            LoginReNameUI.Show(1)
    --        end
    --    end
    --end

    --进行实名认证判断
    --进入游戏开始计录天数
    Socket.isLogin = false;
    local id = UserCenter.get_accountid()
    PlayerEnterUITimesCurDay.RunGame(id)
    --app.log("2222222222222222222222")
    --UserCenter.check_realname(isrename);

    if GameBegin and GameBegin.login_bg_destroy then
        GameBegin.login_bg_destroy()
    end
    
end

function MainCityFightManager:UpdateRealNameAuthButton()

    -- if not UserCenter.check_realname() then
    --     UserCenter.get_realname_auth()
    -- end

    -- local value = UserCenter.get_web_realname()
    -- app.log("UpdateRealNameAuthButton:"..tostring(value))
    -- if value == -1 then
    --     UserCenter.get_realname_auth()
    -- elseif value == 0 then
    --     --self.btn_realname_auth:set_active(false)
    -- elseif value == 1 then
    --     --self.btn_realname_auth:set_active(true)
    -- end
    -- --self.leftGrid:reposition_now()
end

function MainCityFightManager:HandleChatUIPosition()
    --[[local ctChat = GetMainUI():GetComponent(EMMOMainUICOM.MainUIChat);
    if ctChat then
        if AdvFuncButton.isShow then
            ctChat:SetLocalPosition(0, -320, 0)
        else
            ctChat:SetLocalPosition(0, -270, 0)
        end
    end]]
end

function MainCityFightManager:GetNPCAssetFileList(out_file_list)
    FightManager.GetNPCAssetFileList(self, out_file_list)

    local config = ConfigHelper.GetMapInf(FightScene.GetCurHurdleID(),EMapInfType.npc)
	if not config then
		return
	end

    local filepath = nil;
    for k,ml_v in pairs(config) do
        filepath = ObjectManager.GetNpcModelFile(ml_v.id)
        out_file_list[filepath] = filepath
    end
    
end

function MainCityFightManager:LoadSceneObject()
	--[[self:LoadHero()
    self:LoadNPC()--]]
	self:LoadUI()
end

function MainCityFightManager:LoadNPC()
    local config = ConfigHelper.GetMapInf(FightScene.GetCurHurdleID(),EMapInfType.npc)
	if not config then
		return
	end

    self.npcsPosition = {}

    for k,ml_v in pairs(config) do
        local npc = FightScene.CreateNPCAsync(ml_v.id, 1)
        if npc then
            npc:SetPosition(ml_v.px, ml_v.py, ml_v.pz)
            npc:SetRotation(ml_v.rx,ml_v.ry,ml_v.rz)
            --npc:SetScale(ml_v.sx,ml_v.sy,ml_v.sz)
			PublicFunc.UnifiedScale(npc, ml_v.sx, ml_v.sy, ml_v.sz)
            table.insert(self.npcsPosition, npc:GetPosition(true, true))
        end
    end
    
    --app.log('all npc postion ===================== ' .. table.tostring(self.npcsPosition))
end

function MainCityFightManager:MoveCaptainToNpc(npc)
    if not npc then return  end

    local pos = npc:GetPosition()
    if not  pos then return end
    local captain = g_dataCenter.fight_info:GetCaptain()
    if not captain then return end
    self:SetMovePos(pos.x, pos.y, pos.z)
    self.__eneterSystemID = tonumber(npc:GetConfig("systemid"))
    captain:SetHandleState(EHandleState.MMOMove)
end

function MainCityFightManager:SetNpcID(id)
	self.npcID = id;
end

function MainCityFightManager:SetMovePos(x,y,z)
	self.move_x,self.move_y,self.move_z = x,y,z
end

function MainCityFightManager:GetMovePos()
	return self.move_x,self.move_y,self.move_z;
end

function MainCityFightManager:TouchNpc()
    
    if self.__eneterSystemID and self.__eneterSystemID > 0 then
        EnterSystemFunction(self.__eneterSystemID);
    end

    local captain = g_dataCenter.fight_info:GetCaptain()
    if not captain then return end
    captain:SetHandleState(EHandleState.Manual)
end

function MainCityFightManager:Start()
    self.last_save_pos_time = PublicFunc.QueryCurTime();
    FightManager.Start(self)

    self.hero_born_pos = {};
    LevelMapConfigHelper.GetHeroBornPosList(EFightInfoFlag.flag_a, self.hero_born_pos)
    
    self.otherHeros = {}
    self.lastRequestOtherHeroTime = 0

    if not g_dataCenter.send_first_enter_game_complete then
        g_dataCenter.send_first_enter_game_complete = true
        timer.create("player.cg_first_enter_game_complete", 1000, 1);
    end

    util.media_player_destory() -- 主城释放视频组件

    Show3dText.SetShow(false);
end

function MainCityFightManager:RegistFunc()
    FightManager.RegistFunc(self)

    self.bindfunc['AddHero'] = Utility.bind_callback(self, self.AddHero)
    self.bindfunc['DeleteHero'] = Utility.bind_callback(self, self.DeleteHero)
    self.bindfunc['OnUpdateTeam'] = Utility.bind_callback(self, self.OnUpdateTeam)
    self.bindfunc['OnPushUi'] = Utility.bind_callback(self, self.OnPushUi)
    self.bindfunc['HandleChatUIPosition'] = Utility.bind_callback(self, self.HandleChatUIPosition)
    self.bindfunc['gc_check_realname_auth'] = Utility.bind_callback(self,self.UpdateRealNameAuthButton)
end

function MainCityFightManager:MsgRegist()
    PublicFunc.msg_regist(world_msg.gc_request_hall_mock_player,self.bindfunc['AddHero']);
    PublicFunc.msg_regist('mainCityVirtualHeroExit',self.bindfunc['DeleteHero']);
    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam']);
    PublicFunc.msg_regist(UiManager.PushUi, self.bindfunc['OnPushUi']);
    PublicFunc.msg_regist("showAdvFuncPanel", self.bindfunc['HandleChatUIPosition']);
    --PublicFunc.msg_regist(player.gc_check_realname_auth,self.bindfunc['gc_check_realname_auth'])
end
function MainCityFightManager:MsgUnRegist()
    PublicFunc.msg_unregist(world_msg.gc_request_hall_mock_player,self.bindfunc['AddHero']);
    PublicFunc.msg_unregist('mainCityVirtualHeroExit',self.bindfunc['DeleteHero']);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam'])
    PublicFunc.msg_unregist(UiManager.PushUi, self.bindfunc['OnPushUi']);
    PublicFunc.msg_unregist("showAdvFuncPanel", self.bindfunc['HandleChatUIPosition']);
    --PublicFunc.msg_unregist(player.gc_check_realname_auth, self.bindfunc['gc_check_realname_auth'])
end

function MainCityFightManager:AddHero(vecMockPlayer)
    for k,v in pairs(vecMockPlayer) do
        local hero_name = ObjectManager.GetObjectName(OBJECT_TYPE.HERO, g_dataCenter.fight_info.single_friend_flag, v.cardgid);
        if table.index_of(self.otherHeros, hero_name) > 0 then
            --world_msg.cg_request_hall_mock_player(1)
        else
            if #self.otherHeros >= MAX_ROBOT_COUNT then return end
            
            local hbp = self.hero_born_pos;
            if #hbp == 0 then return end
            local n = math.random(1,#hbp);
            local p = {};
            p.x,p.y,p.z = hbp[n].px,hbp[n].py,hbp[n].pz;
            local x,y,z = self:_GetRandomPos(p, {x=hbp[n].rx,y=hbp[n].ry,z=hbp[n].rz}, {x=hbp[n].sx,y=hbp[n].sy,z=hbp[n].sz});
            x,y,z = 30, 10, 10;
            local temp_package = Package:new();
            temp_package:AddCard(ENUM.EPackageType.Hero, {dataid = v.cardgid,number = v.heroID});
            local hero = FightScene.CreateNoPreLoadHero(v.player_gid, v.heroID, g_dataCenter.fight_info.single_friend_flag, 0, 1, v.cardgid, temp_package)
            if not hero then return end
            hero:SetPosition(x, y, z)
			PublicFunc.UnifiedScale(hero)
            hero:GetHpUi():Show(false)
            --hero:SetCountryID()

            hero:SetAI(119)
            hero:SetPatrolMovePath(table.copy(self.npcsPosition))

            hero:InitMainNameUi();

            table.insert(self.otherHeros, hero:GetName())
        end
    end
    
end

function MainCityFightManager:OnLoadHero(entity)
    entity:GetHpUi():Show(false)

    entity:SetCountryID(g_dataCenter.player.country_id) 

    entity:SetCaptain(true);

    entity:InitMainNameUi();
    self.currentShowHeroName = entity:GetName()

    local oldPos = MainCityFightManager.lastExitPostion
    if oldPos then
        entity:SetPosition(oldPos.x, oldPos.y, oldPos.z)
    else
        local x, y, z = g_dataCenter.setting:GetCityPos()
        if (x and (x ~= 0)) or (y and (y ~= 0)) or (z and (z ~= 0)) then
            entity:SetPosition(x, y+0.2, z, false, true)
        end
    end
    PublicFunc.UnifiedScale(entity)
end

function MainCityFightManager:DeleteHero(name)
    --app.log('MainCityFightManager:DeleteHero ' .. tostring(name))
    FightScene.DeleteObj(name, 10)
    local index = table.index_of(self.otherHeros, name)
    if index > 0 then
        table.remove(self.otherHeros, index)
    end
end

function MainCityFightManager:OnUpdateTeam(info,ret)
    local currentEntity = ObjectManager.GetObjectByName(self.currentShowHeroName)
    local nowCaptainHeroUUID = g_dataCenter.player:GetDefTeam()[1]
    local teamid = info["teamid"];
    if currentEntity == nil or 
        (tostring(teamid) == tostring(ENUM.ETeamType.normal) and currentEntity:GetUUID() ~= nowCaptainHeroUUID) then

        g_dataCenter.fight_info:SetCaptain(nil)
		if currentEntity == nil then 
			do return end;
		end
        MainCityFightManager.lastExitPostion = currentEntity:GetPosition()
        g_dataCenter.setting:SetCityPos(MainCityFightManager.lastExitPostion.x, MainCityFightManager.lastExitPostion.y, MainCityFightManager.lastExitPostion.z)

        FightScene.DeleteObj(self.currentShowHeroName, 0)

        local campFlag = g_dataCenter.fight_info.single_friend_flag
        local heroBPList = {}
        LevelMapConfigHelper.GetHeroBornPosList(campFlag, heroBPList)
        self:LoadSingleHero(campFlag, g_dataCenter.player:GetGID(), g_dataCenter.package, nowCaptainHeroUUID, heroBPList[1])

        g_dataCenter.player:ChangeCaptain(1)

        FightScene.GetStartUpEnv():SetHeroList(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, {nowCaptainHeroUUID})
    end
end

function MainCityFightManager:Update()
    if self.last_save_pos_time and PublicFunc.QueryDeltaTime(self.last_save_pos_time) > 5000 then
        local captain = g_dataCenter.fight_info:GetCaptain()
        if captain then
            local pos = captain:GetPosition()
            g_dataCenter.setting:SetCityPos(pos.x, pos.y, pos.z)
        end
        self.last_save_pos_time = PublicFunc.QueryCurTime();
    end
    if not self.lastRequestOtherHeroTime then return end

    local now = PublicFunc.QueryCurTime();
    self.lastRequestOtherHeroTime = self.lastRequestOtherHeroTime or now


-- -- 暂时屏蔽其他玩家
--     if PublicFunc.QueryDeltaTime(self.lastRequestOtherHeroTime) > 5000 then
--         local hasCount = #self.otherHeros
--         if hasCount < MAX_ROBOT_COUNT then
--             world_msg.cg_request_hall_mock_player(MAX_ROBOT_COUNT - hasCount)
--         end

--         self.lastRequestOtherHeroTime = now
--     end
end

function MainCityFightManager:_GetRandomPos(pos,rot,scale)
	local x0,y0,z0; --随机区域中心坐标
	local x1,y1,z1; --未旋转之前的坐标
	local x,y,z;    --旋转后的坐标
	x0 = pos.x;
	y0 = pos.y;
	z0 = pos.z;

	local x_offset = (math.random()-0.5)*scale.x;
	local z_offset = (math.random()-0.5)*scale.z;
	x1 = x0 + x_offset;
	y1 = y0;
	z1 = z0 + z_offset;

	local quaternion = {};
	quaternion.x, quaternion.y, quaternion.z, quaternion.w = util.quaternion_euler(rot.x,rot.y,rot.z);
	x,y,z = util.quaternion_multiply_v3(quaternion.x, quaternion.y, quaternion.z, quaternion.w, x_offset, 0, z_offset);
	x = x + x0;
	y = y + y0;
	z = z + z0;

	return x,y,z;
end

function MainCityFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)

    MainCityFightManager.pre_load_file_list = MainCityFightManager.pre_load_file_list  or {
        --     --一些一级界面
        -- 战队
        -- "assetbundles/prefabs/ui/zhandui/ui_4601_zhandui.assetbundle",
        -- 角色
        -- "assetbundles/prefabs/ui/package/ui_602_5.assetbundle",
        -- 装备
        -- "assetbundles/prefabs/map/045_juesezhanshi/role3d_002.assetbundle",
        -- "assetbundles/prefabs/ui/package/ui_604_battle.assetbundle",
        -- 招募
        -- "assetbundles/prefabs/ui/egg/ui_2601_egg.assetbundle",
        -- "assetbundles/prefabs/ui/new_fight/content_jiesuan_hero1.assetbundle",
        -- "assetbundles/prefabs/ui/egg/ui_2602_egg.assetbundle",
        
        -- 商店
        -- "assetbundles/prefabs/ui/shop/panel_exchange.assetbundle",
        -- "assetbundles/prefabs/ui/shop/equip_box_item.assetbundle",
        --社团3d背景
        -- "assetbundles/prefabs/map/057_shetuanzhujiemian/70000057_shetuanzhujiemian.assetbundle",

        -- 背包        
        --"assetbundles/prefabs/ui/bag/ui_3201_bag.assetbundle",
        --社团 
        --"assetbundles/prefabs/ui/guild/ui_2800_guild_bg.assetbundle",
        --排行
        --"assetbundles/prefabs/ui/rank/ui_402_rank.assetbundle",
        -- 好友
        -- "assetbundles/prefabs/ui/friend/ui_007_friend.assetbundle",
        -- 闯关
        "assetbundles/prefabs/ui/level/ui_701_level.assetbundle",
        "assetbundles/prefabs/ui/level/level_line_item.assetbundle",
        -- 竞技
        -- "assetbundles/prefabs/ui/wanfa/ui_game_play.assetbundle",
        -- 邮箱
        --"assetbundles/prefabs/ui/mail/ui_301_mail.assetbundle",
        --签到
        --"assetbundles/prefabs/ui/sign/ui_200_checkin_month.assetbundle",
        -- 任务        
        --"assetbundles/prefabs/ui/mmo_task/ui_3306_task.assetbundle",
        
        --活动
        --"assetbundles/prefabs/ui/award/ui_1104_award.assetbundle", 
            --"assetbundles/prefabs/ui/award/ui_1106_award.assetbundle",

        --充值        
        -- "assetbundles/prefabs/ui/shop/ui_4201_recharge.assetbundle",
        -- 首充        
        -- "assetbundles/prefabs/ui/first_recharge/ui_3601_first_recharge.assetbundle",
        --聊天
        -- "assetbundles/prefabs/ui/chat/ui_501_chat_left.assetbundle",
        -- "assetbundles/prefabs/ui/new_fight/new_fight_ui_zjm_chat.assetbundle",

        -- 阵容
        -- "assetbundles/prefabs/map/045_juesezhanshi/role3d_001.assetbundle",
        -- "assetbundles/prefabs/ui/zhenrong/ui_602_4.assetbundle",
        "assetbundles/prefabs/ui/public/panel_list_hero_item.assetbundle",
        -- "assetbundles/prefabs/ui/public/panel_list_zr_item.assetbundle",


        --导航条
        "assetbundles/prefabs/ui/main/nav_and_back.assetbundle",

        --主界面左侧
        --"assetbundles/prefabs/ui/new_fight/left_top_other_zjm.assetbundle",
        --"assetbundles/prefabs/ui/new_fight/left_top_other_fight.assetbundle",

        --主界面右侧ui  
        -- "assetbundles/prefabs/ui/new_fight/right_other_animation.assetbundle",

        --??
        -- "assetbundles/prefabs/ui/new_fight/right_down_other.assetbundle",
        --
        -- "assetbundles/prefabs/ui/fight/fight_num_dy.assetbundle",
        -- "assetbundles/prefabs/ui/fight/sp_fight_buff.assetbundle",

        --一些特效

        --主城摄像机
        -- "assetbundles/prefabs/scenecamera/s001_scenecamera_01.assetbundle",


        --common misc
        -- "assetbundles/prefabs/ui/loading/panel_loading.assetbundle",


        --一些二级界面
        --查看角色
        -- "assetbundles/prefabs/ui/package/ui_602.assetbundle",
        -- "assetbundles/prefabs/ui/package/ui_602_level_up.assetbundle",

        --关卡挑战 临时放到这里加载耗时长需要优化
        "assetbundles/prefabs/ui/level/ui_705_level.assetbundle",

        "assetbundles/prefabs/ui/loading/ui_loading_normal.assetbundle",

        --公用组件
        "assetbundles/prefabs/ui/public/cont_big_item.assetbundle",
        -- "assetbundles/prefabs/ui/public/big_card_item_80.assetbundle",
        -- "assetbundles/prefabs/ui/public/new_small_card_item.assetbundle",
        
        --过场动画资源预加载，主要是大乱斗不预加载显示会有问题
        "assetbundles/prefabs/ui/loading/panel_transitions.assetbundle",
    }
    
    for k, v in ipairs(MainCityFightManager.pre_load_file_list) do
        out_file_list[v] = v
    end

    -- 新手引导
    for k, v in pairs(GuideUI.GetResList()) do
        out_file_list[v] = v
    end
end

function MainCityFightManager:GetOtherAssetFileList(out_file_list)
    FightManager.GetOtherAssetFileList(self, out_file_list)
    -- local otherList = {
    --     "assetbundles/prefabs/character/zjm_jinmu/zjm_jinmu_fbx.assetbundle",
    --     "assetbundles/prefabs/character/zjm_heinainaibai/zjm_heinainaibai_fbx.assetbundle",
    --     "assetbundles/prefabs/character/zjm_dongxiang/zjm_dongxiang_fbx.assetbundle",
    -- }
    -- for k, v in pairs(otherList) do
    --     out_file_list[v] = v;
    -- end
end

function MainCityFightManager:OnBeginDestroy()
    
    local captain = g_dataCenter.fight_info:GetCaptain()
    if captain then
        MainCityFightManager.lastExitPostion = captain:GetPosition()
        g_dataCenter.setting:SetCityPos(MainCityFightManager.lastExitPostion.x, MainCityFightManager.lastExitPostion.y, MainCityFightManager.lastExitPostion.z)
    end
    g_dataCenter.player:SetCurCtrlHero(nil)
end

function MainCityFightManager:OnPushUi()
    local captain = g_dataCenter.fight_info:GetCaptain()
    if not captain then return end
    captain:SetHandleState(EHandleState.Manual)
end
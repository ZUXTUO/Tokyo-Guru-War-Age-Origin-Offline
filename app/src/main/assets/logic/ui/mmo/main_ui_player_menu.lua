
MainUIPlayerMenu = Class('MainUIPlayerMenu', UiBaseClass)

local menuPos =
{
    BottomRight = 1,
}

local _UIText = {
    [1] = "小贩到货",
    [2] = "世界首领",
    [3] = "世界宝箱",
    [4] = "社团首领",
    [5] = "3V3",
    [6] = '约战',
}


function MainUIPlayerMenu:Init(data)
	MainUIPlayerMenu.instance = self;
    --self.pathRes = res

    self.reLayoutCount = 0
    self.dataCache = data.dataCache
--    if self.dataCache.bottomRightIsOpen == nil then
--        self.dataCache.bottomRightIsOpen = false
--    end

	UiBaseClass.Init(self, data);
end

function MainUIPlayerMenu:Restart(data)
    self:ResetData()
    self.isInitActivityPane = false
    self.isRightTopMenuUnfold = true
    self.isDownMenuUnfold = true
    MainUIPlayerMenu.idToUiNode = {}
    self.touchBeginX = nil

    self.otherActivityCnt = 0
    UiBaseClass.Restart(self, data)
end

function MainUIPlayerMenu:ResetData()
    self.leftButtonIsOpen = true
end

function MainUIPlayerMenu:DestroyUi()
    self.reLayoutCount = 0
	MainUIPlayerMenu.instance = nil;
    if self.textureHead then
        self.textureHead:Destroy()
        self.textureHead = nil
    end
    if self.activityItem then
        for _, v in pairs(self.activityItem) do
            if v.texture then
                v.texture:Destroy()
                v.texture = nil
            end
        end
    end
    if self.TeamShow then
        self.TeamShow:Destroy();
        self.TeamShow = nil;
    end
    --[[if self.headUiItem then
        self.headUiItem:DestroyUi()
        self.headUiItem = nil
    end]]
    if self.textureHead then
        self.textureHead:Destroy()
        self.textureHead = nil
    end
    MainUIPlayerMenu.idToUiNode = {}

    TimerManager.Remove(self.bindfunc['activity_end_time_score_hero'])
    TimerManager.Remove(self.bindfunc['check_chat_fight_request'])
    TimerManager.Remove(self.bindfunc['activity_end_time_golden_egg'])

    UiBaseClass.DestroyUi(self)
end

function MainUIPlayerMenu:RegistFunc()
    UiBaseClass.RegistFunc(self)

--    self.bindfunc['OnClickHead'] = Utility.bind_callback(self, self.OnClickHead);
--    self.bindfunc['OnClickRightMenuBtn'] = Utility.bind_callback(self, self.OnClickRightMenuBtn);
    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);

    self.bindfunc['OnClickBattle'] = Utility.bind_callback(self, self.OnClickBattle);
    self.bindfunc['OnClickHero'] = Utility.bind_callback(self, self.OnClickHero);
    self.bindfunc['OnClickBag'] = Utility.bind_callback(self, self.OnClickBag);
    self.bindfunc['OnClickGuide'] = Utility.bind_callback(self, self.OnClickGuide);
    self.bindfunc['OnClickRank'] = Utility.bind_callback(self, self.OnClickRank);
    self.bindfunc['OnClickFriend'] = Utility.bind_callback(self, self.OnClickFriend);
    self.bindfunc['OnClickArea'] = Utility.bind_callback(self, self.OnClickArea);
    self.bindfunc['OnClickStrong'] = Utility.bind_callback(self, self.OnClickStrong);
    self.bindfunc['OnClickCompound'] = Utility.bind_callback(self, self.OnClickCompound);
    self.bindfunc['OnClickForge'] = Utility.bind_callback(self, self.OnClickForge);
    self.bindfunc['OnClickArms'] = Utility.bind_callback(self, self.OnClickArms);
    self.bindfunc['OnClickSet'] = Utility.bind_callback(self, self.OnClickSet);
    self.bindfunc['OnDrama'] = Utility.bind_callback(self, self.OnDrama);
    self.bindfunc['OnClickPlay'] = Utility.bind_callback(self, self.OnClickPlay);
    self.bindfunc['OnClickFight'] = Utility.bind_callback(self, self.OnClickFight);
    self.bindfunc['OnClickRecruit'] = Utility.bind_callback(self, self.OnClickRecruit);
    self.bindfunc['OnClickMission'] = Utility.bind_callback(self, self.OnClickMission);
    self.bindfunc['OnClickEquip'] = Utility.bind_callback(self, self.OnClickEquip);
    self.bindfunc['OnClickTeam'] = Utility.bind_callback(self, self.OnClickTeam);
    self.bindfunc['OnClickLonginGift'] = Utility.bind_callback(self, self.OnClickLonginGift);

    self.bindfunc['OnClickFirst'] = Utility.bind_callback(self, self.OnClickFirst);
    self.bindfunc['OnClickActivity'] = Utility.bind_callback(self, self.OnClickActivity);
    self.bindfunc['OnClickStore'] = Utility.bind_callback(self, self.OnClickStore);
    self.bindfunc['OnClickWelfare'] = Utility.bind_callback(self, self.OnClickWelfare);
    self.bindfunc['OnClickMail'] = Utility.bind_callback(self, self.OnClickMail);
    self.bindfunc['OnClickSign'] = Utility.bind_callback(self, self.OnClickSign);
    self.bindfunc['OnClickRecharge'] = Utility.bind_callback(self, self.OnClickRecharge);
    self.bindfunc['OnClickVendingMachine'] = Utility.bind_callback(self, self.OnClickVendingMachine);

    self.bindfunc['OnClickMap'] = Utility.bind_callback(self, self.OnClickMap);

    self.bindfunc['OnClickVip'] = Utility.bind_callback(self, self.OnClickVip);

--    self.bindfunc["OnClickTimeLimitBtn"] = Utility.bind_callback(self, self.OnClickTimeLimitBtn);

    --商店
    self.bindfunc["OnClickShop"] = Utility.bind_callback(self, self.OnClickShop);
    self.bindfunc['OnClickInvite'] = Utility.bind_callback(self, self.OnClickInvite);
    self.bindfunc['gc_get_invite'] = Utility.bind_callback(self, self.gc_get_invite);

    self.bindfunc['OnClickEverydaySign'] = Utility.bind_callback(self, self.OnClickEverydaySign);
    self.bindfunc['OnClickGiftBag'] = Utility.bind_callback(self, self.OnClickGiftBag);
    self.bindfunc['OnClickSevenSign'] = Utility.bind_callback(self, self.OnClickSevenSign);
    self.bindfunc['OnClickSevenSign_back'] = Utility.bind_callback(self, self.OnClickSevenSign_back);
    self.bindfunc['OnClickBuy1'] = Utility.bind_callback(self, self.OnClickBuy1);
    self.bindfunc["onPowerRank"] = Utility.bind_callback(self, self.onPowerRank);
    self.bindfunc["onLuckyCat"] = Utility.bind_callback(self, self.onLuckyCat);

    self.bindfunc['OnClickApBtn'] = Utility.bind_callback(self, self.OnClickApBtn);
    self.bindfunc['OnClickCrystalBtn'] = Utility.bind_callback(self, self.OnClickCrystalBtn);
    self.bindfunc['OnClickGoldBtn'] = Utility.bind_callback(self, self.OnClickGoldBtn);
    self.bindfunc['OnBtnRealNameAuthClick'] = Utility.bind_callback(self,self.OnBtnRealNameAuthClick)

    --self.bindfunc['OnClickBottomRightOpenBtn'] = Utility.bind_callback(self, self.OnClickBottomRightOpenBtn);
    self.bindfunc['OnClickBottomRightCloseBtn'] = Utility.bind_callback(self, self.OnClickBottomRightCloseBtn);
    self.bindfunc['handle_shop_bubble'] = Utility.bind_callback(self, self.handle_shop_bubble);
    self.bindfunc['gc_update_get_friend_ap_times'] = Utility.bind_callback(self, self.gc_update_get_friend_ap_times);
    self.bindfunc['gc_update_friend'] = Utility.bind_callback(self, self.gc_update_friend);
    self.bindfunc['gc_add_friend_apply'] = Utility.bind_callback(self, self.gc_add_friend_apply);
    self.bindfunc['gc_check_realname_auth'] = Utility.bind_callback(self,self.UpdateRealNameAuthButton)

    self.bindfunc['OnClickSceneRole'] = Utility.bind_callback(self,self.OnClickSceneRole);

    self.bindfunc['HandleActivityPane'] = Utility.bind_callback(self,self.HandleActivityPane);
    self.bindfunc['on_goto_activity'] = Utility.bind_callback(self,self.on_goto_activity);

    self.bindfunc['on_touch_begin'] = Utility.bind_callback(self,self.on_touch_begin);
    self.bindfunc['on_touch_move'] = Utility.bind_callback(self,self.on_touch_move);
    self.bindfunc['on_tween_update'] = Utility.bind_callback(self,self.on_tween_update);
    self.bindfunc['on_click_scene_object'] = Utility.bind_callback(self,self.on_click_scene_object);

    self.bindfunc['on_btn_right_top_arrow'] = Utility.bind_callback(self,self.on_btn_right_top_arrow);
    self.bindfunc['on_btn_down_arrow'] = Utility.bind_callback(self,self.on_btn_down_arrow)

    self.bindfunc['UpdatePlayerUi'] = Utility.bind_callback(self, self.UpdatePlayerUi);
    self.bindfunc['OnClickPlayerHead'] = Utility.bind_callback(self, self.OnClickPlayerHead);
    self.bindfunc['on_move_camera'] = Utility.bind_callback(self, self.on_move_camera);

    self.bindfunc['OnClickScoreHero'] = Utility.bind_callback(self, self.OnClickScoreHero);
    self.bindfunc['OnClickLimitBuy'] = Utility.bind_callback(self, self.OnClickLimitBuy);
    self.bindfunc['activity_end_time_score_hero'] = Utility.bind_callback(self, self.activity_end_time_score_hero);
    self.bindfunc['gc_init_activity_state'] = Utility.bind_callback(self, self.gc_init_activity_state);
    self.bindfunc['gc_pause_activity'] = Utility.bind_callback(self, self.gc_pause_activity);
    self.bindfunc['gc_change_activity_time'] = Utility.bind_callback(self, self.gc_change_activity_time);

    self.bindfunc['check_chat_fight_request'] = Utility.bind_callback(self, self.check_chat_fight_request)
    self.bindfunc['on_chat_fight_request'] = Utility.bind_callback(self, self.on_chat_fight_request)
    self.bindfunc['on_chat_fight_cancel'] = Utility.bind_callback(self, self.on_chat_fight_cancel)
    self.bindfunc['OnClickDuel'] = Utility.bind_callback(self, self.OnClickDuel)

    self.bindfunc['OnClickGoldenEgg'] = Utility.bind_callback(self, self.OnClickGoldenEgg)
    self.bindfunc['activity_end_time_golden_egg'] = Utility.bind_callback(self, self.activity_end_time_golden_egg);

    self.bindfunc['onClickHideTalk'] = Utility.bind_callback(self,self.onClickHideTalk)
 end

function MainUIPlayerMenu:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(player.gc_update_player_gold_crystal, self.bindfunc['UpdateUi'])
    PublicFunc.msg_regist(player.gc_update_player_ap_bp, self.bindfunc['UpdateUi'])
    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])

    PublicFunc.msg_regist(player.gc_first_recharge_flag, self.bindfunc['UpdateUi'])
    --PublicFunc.msg_regist(player.gc_get_invite, self.bindfunc['gc_get_invite'])

    PublicFunc.msg_regist(msg_shop.mystery_shop_open, self.bindfunc['handle_shop_bubble'])
    PublicFunc.msg_regist(msg_shop.mystery_shop_close, self.bindfunc['handle_shop_bubble'])

    PublicFunc.msg_regist(msg_activity.gc_check_is_buy_1, self.bindfunc['UpdateUi']);
    PublicFunc.msg_regist(player.gc_update_get_friend_ap_times, self.bindfunc['gc_update_get_friend_ap_times'])
    PublicFunc.msg_regist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend'])
    PublicFunc.msg_regist(msg_friend.gc_add_friend_apply, self.bindfunc['gc_add_friend_apply'])
    PublicFunc.msg_regist(msg_sign_in.gc_set_point, self.bindfunc['UpdateUi'])

    PublicFunc.msg_regist(player.gc_check_realname_auth,self.bindfunc['gc_check_realname_auth'])

    -- PublicFunc.msg_regist(msg_world_boss.gc_sync_world_boss_state, self.bindfunc['HandleActivityPane'])
    PublicFunc.msg_regist(msg_world_treasure_box.gc_sync_world_treasure_box_state, self.bindfunc['HandleActivityPane'])
    -- PublicFunc.msg_regist(msg_guild_boss.gc_sync_guild_boss_state, self.bindfunc['HandleActivityPane'])
    PublicFunc.msg_regist("_ActivityStateUpdate-->3V3", self.bindfunc['HandleActivityPane'])

    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_regist(player.gc_update_player_vip_info, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_regist('PlayerFightValueChange', self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_regist(player.gc_change_player_image, self.bindfunc['UpdatePlayerUi']);
    PublicFunc.msg_regist(player.gc_change_name, self.bindfunc['UpdatePlayerUi']);
    PublicFunc.msg_regist("MainUIPlayerMenu-->on_move_camera", self.bindfunc['on_move_camera']);

    PublicFunc.msg_regist("msg_activity.gc_init_activity_state", self.bindfunc['gc_init_activity_state']);
    PublicFunc.msg_regist("msg_activity.gc_pause_activity", self.bindfunc['gc_pause_activity']);
    PublicFunc.msg_regist("msg_activity.gc_change_activity_time", self.bindfunc['gc_change_activity_time']);
end

--Ã—Â¢ÃÃºÃÃ»ÃÂ¢Â·Ã–Â·Â¢Â»Ã˜ÂµÃ·ÂºÂ¯ÃŠÃ½
function MainUIPlayerMenu:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(player.gc_update_player_gold_crystal, self.bindfunc['UpdateUi'])
    PublicFunc.msg_unregist(player.gc_update_player_ap_bp, self.bindfunc['UpdateUi'])
    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])

    PublicFunc.msg_unregist(player.gc_first_recharge_flag, self.bindfunc['UpdateUi'])
    --PublicFunc.msg_unregist(player.gc_get_invite, self.bindfunc['gc_get_invite'])
    PublicFunc.msg_unregist(msg_shop.mystery_shop_open, self.bindfunc['handle_shop_bubble'])
    PublicFunc.msg_unregist(msg_shop.mystery_shop_close, self.bindfunc['handle_shop_bubble'])

    PublicFunc.msg_unregist(msg_activity.gc_check_is_buy_1, self.bindfunc['UpdateUi']);

    PublicFunc.msg_unregist(player.gc_update_get_friend_ap_times, self.bindfunc['gc_update_get_friend_ap_times'])
    PublicFunc.msg_unregist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend'])
    PublicFunc.msg_unregist(msg_friend.gc_add_friend_apply, self.bindfunc['gc_add_friend_apply'])
    PublicFunc.msg_unregist(msg_sign_in.gc_set_point, self.bindfunc['UpdateUi'])
    PublicFunc.msg_unregist(player.gc_check_realname_auth, self.bindfunc['gc_check_realname_auth'])

    -- PublicFunc.msg_unregist(msg_world_boss.gc_sync_world_boss_state, self.bindfunc['HandleActivityPane'])
    PublicFunc.msg_unregist(msg_world_treasure_box.gc_sync_world_treasure_box_state, self.bindfunc['HandleActivityPane'])
    -- PublicFunc.msg_unregist(msg_guild_boss.gc_sync_guild_boss_state, self.bindfunc['HandleActivityPane'])
    PublicFunc.msg_unregist("_ActivityStateUpdate-->3V3", self.bindfunc['HandleActivityPane'])

    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_unregist(player.gc_update_player_vip_info, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_unregist('PlayerFightValueChange', self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_unregist(player.gc_change_player_image, self.bindfunc['UpdatePlayerUi']);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_unregist(player.gc_change_name, self.bindfunc['UpdatePlayerUi'])
    PublicFunc.msg_unregist("MainUIPlayerMenu-->on_move_camera", self.bindfunc['on_move_camera']);

    PublicFunc.msg_unregist("msg_activity.gc_init_activity_state", self.bindfunc['gc_init_activity_state']);
    PublicFunc.msg_unregist("msg_activity.gc_pause_activity", self.bindfunc['gc_pause_activity']);
    PublicFunc.msg_unregist("msg_activity.gc_change_activity_time", self.bindfunc['gc_change_activity_time']);
end

function MainUIPlayerMenu:IsLeftMenuOpen()
    return false
end

function MainUIPlayerMenu:IsRightMenuOpen()
    return false
end

function MainUIPlayerMenu:getButton(id)
	local buttonData = self.buttonData[id];
	local button = nil;
	if buttonData then 
		button = buttonData.btn;
	end 
	return button;
end 

function MainUIPlayerMenu:InitButtonData()
    self.buttonData = self.buttonData or
    {
        --下右
        [MsgEnum.eactivity_time.eActivityTime_Battle] = {path='btn_zhandui', callback = self.bindfunc['OnClickBattle'], unlockid = MsgEnum.eactivity_time.eActivityTime_Battle, pos = menuPos.BottomRight, audioType = "MyButton.MainUiDown"},
        
        [MsgEnum.eactivity_time.eActivityTime_Hero] = {path='btn_jiaose', callback = self.bindfunc['OnClickHero'], unlockid = MsgEnum.eactivity_time.eActivityTime_Hero, pos = menuPos.BottomRight, audioType = "MyButton.MainUiDown"},

        [MsgEnum.eactivity_time.eActivityTime_Recruit] = {path='btn_zhaomu', callback = self.bindfunc['OnClickRecruit'], unlockid = MsgEnum.eactivity_time.eActivityTime_Recruit, pos = menuPos.BottomRight, audioType = "MyButton.MainUiDown"},

        [MsgEnum.eactivity_time.eActivityTime_Shop] = {path='btn_shop', callback = self.bindfunc['OnClickShop'], unlockid = MsgEnum.eactivity_time.eActivityTime_Shop, spec = true,  pos = menuPos.BottomRight, audioType = "MyButton.MainUiDown"},

        [MsgEnum.eactivity_time.eActivityTime_bag] = {path='btn_bag', callback = self.bindfunc['OnClickBag'], unlockid = MsgEnum.eactivity_time.eActivityTime_bag, pos = menuPos.BottomRight, audioType = "MyButton.MainUiDown"},

        [MsgEnum.eactivity_time.eActivityTime_Guild] = {path='btn_guild', callback = self.bindfunc['OnClickGuide'], unlockid = MsgEnum.eactivity_time.eActivityTime_Guild, pos = menuPos.BottomRight, spec = true, audioType = "MyButton.MainUiDown"},

       [MsgEnum.eactivity_time.eActivityTime_Rank] = {path='btn_rank', callback = self.bindfunc['OnClickRank'], unlockid = MsgEnum.eactivity_time.eActivityTime_Rank, pos = menuPos.BottomRight, spec = true, audioType = "MyButton.MainUiRight"},

       [MsgEnum.eactivity_time.eActivityTime_Friend] = {path='btn_friend', callback = self.bindfunc['OnClickFriend'], unlockid = MsgEnum.eactivity_time.eActivityTime_Friend, pos = menuPos.BottomRight, audioType = nil},
		
        --[MsgEnum.eactivity_time.eActivityTime_Area] = {path='btn_area', callback = self.bindfunc['OnClickArea'], unlockid = MsgEnum.eactivity_time.eActivityTime_Area, pos = menuPos.BottomRight},
       [MsgEnum.eactivity_time.eActivityTime_Team] = {path='btn_zhenrong', callback = self.bindfunc['OnClickTeam'], unlockid = MsgEnum.eactivity_time.eActivityTime_Team, pos = menuPos.BottomRight, spec = true,  audioType = "MyButton.MainUiDown"},

       [MsgEnum.eactivity_time.eActivityTime_Playing] = {path='btn_challenge', callback = self.bindfunc['OnClickPlay'], unlockid = MsgEnum.eactivity_time.eActivityTime_Playing, audioType = "MyButton.MainUiDown"},
        
       [MsgEnum.eactivity_time.eActivityTime_Fight] = {path='btn_pvp', callback = self.bindfunc['OnClickFight'], unlockid = MsgEnum.eactivity_time.eActivityTime_Fight, audioType = "MyButton.MainUiDown"},
       [MsgEnum.eactivity_time.eActivityTime_Duel] = {path='btn_duijue', callback = self.bindfunc['OnClickDuel'], unlockid = MsgEnum.eactivity_time.eActivityTime_Duel, audioType = "MyButton.MainUiDown"},

        --上右
        [MsgEnum.eactivity_time.eActivityTime_FirsetRecharge] = {path='btn_first', callback = self.bindfunc['OnClickFirst'], unlockid = MsgEnum.eactivity_time.eActivityTime_FirsetRecharge, spec = true, audioType = "MyButton.MainUiRight"},       

        [MsgEnum.eactivity_time.eActivityTime_Recharge] = {path='btn_recharge', callback = self.bindfunc['OnClickRecharge'], unlockid = MsgEnum.eactivity_time.eActivityTime_Recharge, spec = true, audioType = "MyButton.MainUiRight"},

        [MsgEnum.eactivity_time.eActivityTime_Activity] = {path='btn_activity', callback = self.bindfunc['OnClickActivity'], unlockid = MsgEnum.eactivity_time.eActivityTime_Activity, audioType = "MyButton.MainUiRight"},

        [MsgEnum.eactivity_time.eActivityTime_Task] = {path='btn_task', callback = self.bindfunc['OnClickMission'], unlockid = MsgEnum.eactivity_time.eActivityTime_Task,  spec = true, audioType = "MyButton.MainUiRight"},

        [MsgEnum.eactivity_time.eActivityTime_checkinMonth] = {path='btn_sign', callback = self.bindfunc['OnClickEverydaySign'], unlockid = MsgEnum.eactivity_time.eActivityTime_checkinMonth, audioType = "MyButton.MainUiRight"},
        
        -- [MsgEnum.eactivity_time.eActivityTime_checkinMonth] = {path='btn_qitian', callback = self.bindfunc['OnClickSevenSign'], unlockid = MsgEnum.eactivity_time.eActivityTime_Sign_in},

        [MsgEnum.eactivity_time.eActivityTime_Mail] = {path='btn_message', callback = self.bindfunc['OnClickMail'], unlockid = MsgEnum.eactivity_time.eActivityTime_Mail, audioType = nil},
        
        --右上
        [MsgEnum.eactivity_time.eActivityTime_GiftBag] = {path='btn_vip_libao', callback = self.bindfunc['OnClickGiftBag'], unlockid = MsgEnum.eactivity_time.eActivityTime_GiftBag, audioType = "MyButton.MainUiRight"},
        
        [MsgEnum.eactivity_time.eActivityTime_Sign_in] = {path='btn_qitian', callback = self.bindfunc['OnClickSevenSign'], unlockid = MsgEnum.eactivity_time.eActivityTime_Sign_in, audioType = "MyButton.MainUiRight"},
        
        -- [MsgEnum.eactivity_time.eActivityTime_buy1] = {path='btn_yiyuangou', callback = self.bindfunc['OnClickBuy1'], unlockid = MsgEnum.eactivity_time.eActivityTime_buy1},

        [MsgEnum.eactivity_time.eActivityTime_Adventure] = {path='btn_chuangguan', callback = self.bindfunc['OnDrama'], unlockid = MsgEnum.eactivity_time.eActivityTime_Adventure, audioType = "MyButton.MainUiDown"},
                
        [MsgEnum.eactivity_time.eActivityTime_LoginGift] = {path='btn_denglulibao', callback = self.bindfunc['OnClickLonginGift'], unlockid = MsgEnum.eactivity_time.eActivityTime_LoginGift, audioType = "MyButton.MainUiRight"},
        [MsgEnum.eactivity_time.eActivityTime_ScoreHero] = {path='btn_jifenjuese', callback = self.bindfunc['OnClickScoreHero'], unlockid = MsgEnum.eactivity_time.eActivityTime_ScoreHero, audioType = "MyButton.MainUiRight"},
        [MsgEnum.eactivity_time.eActivityTime_limit_buy] = {path='grid2/btn_jifenjuese', callback = self.bindfunc['OnClickLimitBuy'], unlockid = MsgEnum.eactivity_time.eActivityTime_limit_buy, audioType = "MyButton.MainUiRight"},

        [MsgEnum.eactivity_time.eActivityTime_GoldenEgg] = {path='btn_jiuba', callback = self.bindfunc['OnClickGoldenEgg'], unlockid = MsgEnum.eactivity_time.eActivityTime_GoldenEgg, audioType = "MyButton.MainUiRight"},
        [MsgEnum.eactivity_time.eActivityTime_vending_machine] = {path='btn_fanmaiji', callback = self.bindfunc['OnClickVendingMachine'], unlockid = MsgEnum.eactivity_time.eActivityTime_vending_machine, audioType = "MyButton.MainUiRight"},       
    }
end

function MainUIPlayerMenu:InitUIUseExistNode()
    UiBaseClass.InitUIUseExistNode(self)
    --BY:Ewing 小提示用到具体的名字，请不要随意修改
    self.ui:set_name("right_other_animation")

    self:InitButtonData()

    local rightTopPath = "right_top/animation/"

    local apAddBtn = ngui.find_button(self.ui, rightTopPath .. 'btn_tili/btn_1')
    apAddBtn:set_on_click(self.bindfunc['OnClickApBtn'])
    self.apLabel = ngui.find_label(self.ui, rightTopPath ..'btn_tili/lab')

    local crystalBtn = ngui.find_button(self.ui, rightTopPath ..'btn_crystal/btn_1')
    crystalBtn:set_on_click(self.bindfunc['OnClickCrystalBtn'])
    self.crystalLabel = ngui.find_label(self.ui, rightTopPath ..'btn_crystal/lab')

    local goldBtn = ngui.find_button(self.ui, rightTopPath ..'btn_gold/btn_1')
    goldBtn:set_on_click(self.bindfunc['OnClickGoldBtn'])
    self.goldLabel = ngui.find_label(self.ui, rightTopPath ..'btn_gold/lab')

    self.nowTimeLabel = ngui.find_label(self.ui, 'left_top/sp_clock/lab_num')

    local rightBtnPath = rightTopPath .. 'grid/'
    local rightBtnPath2 = rightTopPath ..'grid2/'
    self.gridRightTop = ngui.find_grid(self.ui, rightTopPath .. 'grid')
    self.gridRightTop2 = ngui.find_grid(self.ui, rightTopPath .. 'grid2')

    self.btn_libao = ngui.find_button(self.ui, rightBtnPath .. "btn_vip_libao");
    --[[local vip_libao_sp = ngui.find_sprite(self.ui, rightBtnPath .. "btn_vip_libao/animation/sp");
    if vip_libao_sp then
        vip_libao_sp:set_active(true);
    end]]

    self.btn_qitian = ngui.find_button(self.ui, rightBtnPath .. "btn_qitian");
    self.btn_qitian_back = ngui.find_button(self.ui, rightTopPath .. "grid2/btn_festival");
    if self.btn_qitian_back then        
        self.btn_qitian_back:set_on_click(self.bindfunc["OnClickSevenSign_back"], "MyButton.MainUiRight")
    end

    --self.btn_yiyuangou = ngui.find_button(self.ui, rightBtnPath .. "btn_yiyuangou");
    --self.btn_yiyuangou:set_on_click(self.bindfunc["OnClickBuy1"], "MyButton.MainUiRight");

    self.btn_denglulibao = ngui.find_button(self.ui, rightBtnPath .. "btn_denglulibao");

    --对话框
    self.talkNode = self.ui:get_child_by_name("centre/content")
    self.talkNode:set_active(false)
    self.talklabe = ngui.find_label(self.ui,"centre/content/lab")

    self.btnScoreHero = ngui.find_button(self.ui, rightBtnPath .. "btn_jifenjuese");
    self.spPointScoreHero = ngui.find_sprite(self.ui, rightBtnPath .. "btn_jifenjuese/animation/sp_point");
    self.spPointScoreHero:set_active(false)
    self:__CheckActivityTime(ENUM.Activity.activityType_score_hero)

    self.btnGoldenEgg = ngui.find_button(self.ui, rightBtnPath2 .. "btn_jiuba");
    self.spPointGoldenEgg = ngui.find_sprite(self.ui, rightBtnPath2 .. "btn_jiuba/animation/sp_point");
    self.spPointGoldenEgg:set_active(false)
    self:__CheckActivityTime(ENUM.Activity.activityType_golden_egg)

    self.btn_power_rank = ngui.find_button(self.ui, rightBtnPath .. "btn_zhanlipaihang");
    if self.btn_power_rank then
        self.btn_power_rank:set_on_click(self.bindfunc["onPowerRank"], "MyButton.MainUiRight");
    end

    self.btn_lucky_cat = ngui.find_button(self.ui, rightBtnPath .. "btn_zhaocaimao");
    if self.btn_lucky_cat then
        self.btn_lucky_cat:set_on_click(self.bindfunc["onLuckyCat"], "MyButton.MainUiRight");
    end

    self.bottomRightGrid = ngui.find_grid(self.ui, 'down/grid')


    self.btn_xianshigou = ngui.find_button(self.ui,rightBtnPath2.."btn_jifenjuese");
    self.btnVendingMachine = ngui.find_button(self.ui, rightBtnPath2 .. "btn_fanmaiji")

    local downPath = "down/animation/"
    local downPathGrid = "down/animation/grid/"

    self.btn_challenge_sp_art_font2 = ngui.find_sprite(self.ui, downPathGrid .."btn_challenge/animation/sp_hint");

    self.btn_pvp_sp_art_font2 = ngui.find_sprite(self.ui, downPathGrid .. "btn_pvp/animation/sp_hint");
    self.adventureFingerNode = self.ui:get_child_by_name("btn_chuangguan/guide_hand_item")

    self.spHurdleExtraActivity = self.ui:get_child_by_name(downPath .. "btn_chuangguan/animation/sp_hint");
    --self.labHurdleExtraActivity = ngui.find_label(self.ui, downPath .. "btn_chuangguan/animation/sp_hint/lab");

    --需要调整位置的按钮
    self.objBtnAdjustList = {}
    self.objSceneBtn = {}
    local _showBtnData = {
        [1] = {id = MsgEnum.eactivity_time.eActivityTime_Shop, },
        [2] = {id = MsgEnum.eactivity_time.eActivityTime_Guild, },
        [3] = {id = MsgEnum.eactivity_time.eActivityTime_Rank, },
        [4] = {id = MsgEnum.eactivity_time.eActivityTime_Task,},
        [5] = {id = MsgEnum.eactivity_time.eActivityTime_Team, },
    }
    for i = 1, 5 do
        local obj =  self.ui:get_child_by_name("centre/btn" .. i)
        self.objBtnAdjustList[i] = obj

        local data = _showBtnData[i]
        self.objSceneBtn[data.id] = obj

        local objPoint = obj:get_child_by_name('sp_point')
        if objPoint then
            objPoint:set_active(false)
        end
        local path =  self.buttonData[data.id].path
        obj:set_name(path)
    end
    --self.ui:get_child_by_name("centre"):set_active(false)

    local btn
    for k,data in pairs(self.buttonData) do
        if not data.spec then
            btn = ngui.find_button(self.ui, data.path)
            if not btn then
                app.log("not found "..data.path)
            end
            btn:set_on_click(data.callback, data.audioType)
            data.btn = btn
            --data.guildeUI = ngui.find_panel(self.ui, data.path .. '/panel_fx')
        end
    end

    --[[local shop_data = self.buttonData[MsgEnum.eactivity_time.eActivityTime_Shop]
    self.btnShop = ngui.find_button(self.ui, shop_data.path)
    self.btnShop:set_on_click(shop_data.callback, shop_data.audioType)

    self.spShopBubble = ngui.find_sprite(self.ui, shop_data.path .. "/sp_hint")
    local lblShopBubble = ngui.find_label(self.ui, shop_data.path .. "/sp_hint/lab")
    lblShopBubble:set_text(_UIText[1])
    -- self.spShopBubble:set_sprite_name("zjm_hd_xiaofandaohuo")
    self:handle_shop_bubble()]]

    --Ê×³äÌØÊâ´¦Àí
    local data = self.buttonData[MsgEnum.eactivity_time.eActivityTime_FirsetRecharge]
    self.btn_first =  ngui.find_button(self.ui, data.path)
    self.btn_first:set_on_click(data.callback, data.audioType)

    --self.btn_first_guildeui = ngui.find_panel(self.ui, data.path .. '/panel_fx')
    data = self.buttonData[MsgEnum.eactivity_time.eActivityTime_Recharge]
    self.btn_recharge =  ngui.find_button(self.ui, data.path)
    self.btn_recharge:set_on_click(self.bindfunc['OnClickRecharge'], data.audioType)
    self.objGridCont = self.ui:get_child_by_name(rightBtnPath .. "cont")

    --self.btn_recharge_guildeui = ngui.find_panel(self.ui, 'btn_store/panel_fx')

    --[[self.btn_realname_auth = ngui.find_button(self.ui,"btn_shimingzi")
    self.btn_realname_auth:set_active(false)
    self.btn_realname_auth:set_on_click(self.bindfunc['OnBtnRealNameAuthClick'])]]

    --    self.LeftAlwaysShowNode = self.ui:get_child_by_name('left_other/left/grid2')

    --local unknownSprite = ngui.find_sprite(self.ui, "sp_frame")
    --unknownSprite:set_active(false)   

    self.aniRightTop = self.ui:get_child_by_name('right_top/animation')
    self.aniDown = self.ui:get_child_by_name('down/animation')

    local btnRightTopArrow = ngui.find_button(self.ui, rightTopPath .. 'btn_arrows')
    btnRightTopArrow:set_on_click(self.bindfunc['on_btn_right_top_arrow'])
    self.objRightTopArrow = btnRightTopArrow:get_game_object()
    self.objRightTopArrow:set_local_rotation(0, 180, 0)

    local btnDownArrow = ngui.find_button(self.ui, downPath .. 'btn_arrows')
    btnDownArrow:set_on_click(self.bindfunc['on_btn_down_arrow'])
    self.objDownArrow = btnDownArrow:get_game_object()
    self.objDownArrow:set_local_rotation(0, 0, 0)

    self:InitChatFightUI()
    self:InitPlayerUI()
    self:Init3dSceneUi()

    self:ShowAdventureFingerNode(self.showAdventureFinger)

    --TODO：实名认证按钮
    --self:UpdateRealNameAuthButton()

    if not GetMainUI():GetFirstHideVerboseMenu() then
        --self:ShowVerbosMenu(false)
    end

    self:UpdateUi()
    GNoticeGuideTipUiUpdate(EUI.MMOMainUI)

    --是否显示好感商店
    msg_shop.cg_shop_item_info(ENUM.ShopID.VIP)
end

function MainUIPlayerMenu:SetRoleTalkObj(obj)
    self.objTalk = obj
end

function MainUIPlayerMenu:onClickShowTalk(des)
    if self.delayTimer then
        timer.stop(self.delayTimer)
        self.delayTimer = nil
    end
    if self.talkNode then
        self.talklabe:set_text(gs_string_talk[des])
        self.talkNode:set_active(true)
        --app.log("des.........."..tostring(gs_string_talk[des]))
        self.delayTimer = timer.create(self.bindfunc["onClickHideTalk"],2500,1);
    end
end

function MainUIPlayerMenu:onClickHideTalk()
    self.talkNode:set_active(false)
end

function MainUIPlayerMenu:on_btn_right_top_arrow()
    if self.isRightTopMenuUnfold then
        self.aniRightTop:animated_play("right_other_animation_right_top_in")
        self.objRightTopArrow:set_local_rotation(0, 0, 0)
    else
        self.aniRightTop:animated_play("right_other_animation_right_top_out")
        self.objRightTopArrow:set_local_rotation(0, 180, 0)
    end
    self.isRightTopMenuUnfold = not self.isRightTopMenuUnfold
end

function MainUIPlayerMenu:on_btn_down_arrow()
    if self.isDownMenuUnfold then
        self.aniDown:animated_play("right_other_animation_down_in")
        self.objDownArrow:set_local_rotation(0, 180, 0)
    else
        self.aniDown:animated_play("right_other_animation_down_out")
        self.objDownArrow:set_local_rotation(0, 0, 0)
    end
    self.isDownMenuUnfold = not self.isDownMenuUnfold
end

--[[
    id为activity_time中id
    世界BOSS
    世界宝箱
    社团BOSS
    3V3
]]
local __activityId = {
    World_Boss = 60054016,
    World_Treasure_Box = 60055127,
    Guild_Boss = 60054017,
    Three_To_Three = 60054021,
    One_Vs_One = 60055128,
}
local __allActivty = {
    --[1] = {id = __activityId.World_Boss, name = _UIText[2], activity_id = MsgEnum.eactivity_time.eActivityTime_WorldBoss},
    [1] = {id = __activityId.World_Treasure_Box, name = _UIText[3], activity_id = MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox},
    --[1] = {id = __activityId.Guild_Boss, name = _UIText[4], activity_id = MsgEnum.eactivity_time.eActivityTime_GuildBoss},
    [2] = {id = __activityId.Three_To_Three, name = _UIText[5], activity_id = MsgEnum.eactivity_time.eActivityTime_threeToThree},
    [3] = {id = __activityId.One_Vs_One, name = _UIText[6], activity_id = MsgEnum.eactivity_time.eActivityTime_1v1},
}

--[[活动开启引导]]
function MainUIPlayerMenu:HandleActivityPane()
    if not self:IsShow() then
        return
    end
    local objClone = self.ui:get_child_by_name("left_top/grid_function/Texture1")
    objClone:set_active(false)
    if self.activityItem then
        for _, v in pairs(self.activityItem) do
            v.obj:set_active(false)
        end
    end

    if not self:SomeActivityIsOpen() then
        return
    end
    if not self.isInitActivityPane then
        self.isInitActivityPane = true

        self.gridActivity = ngui.find_grid(self.ui, 'left_top/grid_function')
        self.activityItem = {}
        local objClone = self.ui:get_child_by_name("left_top/grid_function/Texture1")
        objClone:set_active(false)
        local objGrid = self.gridActivity:get_game_object()

        for i = 1, 3 do
            local temp = {}
            temp.obj = objClone:clone()
            temp.obj:set_parent(objGrid)
            temp.obj:set_name('item' .. i)

            temp.btn = ngui.find_button(temp.obj, temp.obj:get_name())
            temp.btn:set_on_click(self.bindfunc["on_goto_activity"])
            temp.texture = ngui.find_texture(temp.obj, temp.obj:get_name())
            temp.lblName = ngui.find_label(temp.obj, "lab")

            temp.spBg = ngui.find_sprite(temp.obj, "sp_bk")
            temp.lblCnt = ngui.find_label(temp.obj, "sp_bk/lab_num")
            self.activityItem[i] = temp
        end

        --按优先级排序, 最多显示三个
        for _, v in pairs(__allActivty) do
            v.order = ConfigManager.Get(EConfigIndex.t_activity_time, v.id).guide_order
        end
        table.sort(__allActivty, function(a, b)
            return a.order < b.order
        end)
    end

    local dataList = {}
    self.otherActivityCnt = 0
    for _, v in ipairs(__allActivty) do
        if self:CheckActivityIsOpen(v.id) then
            table.insert(dataList, v)
            --
            if v.id ~= __activityId.One_Vs_One then
                self.otherActivityCnt = self.otherActivityCnt + 1
            end
            if #dataList == 3 then
                break
            end
        end
    end
    --app.log('===================>dataList =  ' .. table.tostring(dataList) .. '    ' .. debug.traceback())

    for k, v in pairs(self.activityItem) do
        local data = dataList[k]
        if data ~= nil then
            v.obj:set_active(true)
            local textPath = ConfigManager.Get(EConfigIndex.t_activity_time, data.id).guide_icon
            if textPath and tonumber(textPath) ~= 0 then
                v.texture:set_texture(textPath)
            end
            v.lblName:set_text(data.name)
            v.btn:set_event_value(tostring(data.activity_id), data.activity_id)

            if data.id == __activityId.One_Vs_One then
                v.spBg:set_active(true)
                local cnt = g_dataCenter.chatFight:GetRequestCnt(true)
                v.lblCnt:set_text(tostring(cnt))
            else
                v.spBg:set_active(false)
            end
        else
            v.obj:set_active(false)
        end
    end
    self.gridActivity:reposition_now()
end

function MainUIPlayerMenu:SomeActivityIsOpen()
    for _, v in pairs(__allActivty) do
        if self:CheckActivityIsOpen(v.id) then
            return true
        end
    end
    return false
end

function MainUIPlayerMenu:CheckActivityIsOpen(id)
    if not self:__ActivityConfigIsOpen(id) then
        return false
    end

    if id == __activityId.World_Boss then
        return g_dataCenter.worldBoss:IsOpen() == Gt_Enum_Wait_Notice.Success

    elseif id == __activityId.World_Treasure_Box then
        return g_dataCenter.worldTreasureBox:IsOpen() == Gt_Enum_Wait_Notice.Success

    elseif id == __activityId.Guild_Boss then
        return g_dataCenter.guildBoss:IsOpen() == Gt_Enum_Wait_Notice.Success

    elseif id == __activityId.Three_To_Three then
        --等级
        if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_threeToThree) then
            return false
        end
        if g_dataCenter.gmCheat:noPlayLimit()  then
            return true
        end
        local inTime, intervalTime = PublicFunc.InActivityTimeEx(MsgEnum.eactivity_time.eActivityTime_threeToThree)
        return inTime

    elseif id == __activityId.One_Vs_One then
        return g_dataCenter.chatFight:HaveRequest(true)

    end
    return false
end

function MainUIPlayerMenu:on_goto_activity(t)
    local activity_id = tonumber(t.string_value)
    if activity_id == MsgEnum.eactivity_time.eActivityTime_1v1 then
        uiManager:PushUi(EUI.ChatFightRequestUI, {isFight = true})
    else
        SystemEnterFunc[activity_id]()
    end
end

function MainUIPlayerMenu:__ActivityConfigIsOpen(id)
    local isOpen = ConfigManager.Get(EConfigIndex.t_activity_time, id).guide_is_open
    return isOpen == 1
end


function MainUIPlayerMenu:ShowVerbosMenu(show)
    self.verbosIsShow = show
    self.ui:get_child_by_name("left_top"):set_active(show)
    self.ui:get_child_by_name("right_top/grid1"):set_active(show)
    self.ui:get_child_by_name("right_top/grid2"):set_active(show)
end

function MainUIPlayerMenu:UpdateRealNameAuthButton()

    local value = g_dataCenter.player:GetIsRealNameAuth()
    app.log("UpdateRealNameAuthButton:"..tostring(value))
    if value == -1 then
        UserCenter.get_realname_auth()
    elseif value == 0 then
        --self.btn_realname_auth:set_active(false)
    elseif value == 1 then
        --self.btn_realname_auth:set_active(true)
    end
    --self.leftGrid:reposition_now()
end

function MainUIPlayerMenu:handle_shop_bubble()
    if self.spShopBubble == nil then
        return
    end
    local enabled = g_dataCenter.shopInfo:CheckShopIsEnabled(ENUM.ShopID.MYSTERY)
    self.spShopBubble:set_active(enabled)
end

function MainUIPlayerMenu:OnClickShop(param)
    if g_dataCenter.shopInfo:CheckShopIsEnabled(ENUM.ShopID.MYSTERY) then
        g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.MYSTERY)
        return
    end
    g_dataCenter.shopInfo:OpenShop()
end

function MainUIPlayerMenu:SetGuildeUIActive(id, is)

    if id == MsgEnum.eactivity_time.eActivityTime_FirsetRecharge then
        --self.btn_first_guildeui:set_active(true)
    else
        local data = self.buttonData[id]
        if data and data.guildeUI then
            data.guildeUI:set_active(is)
        end
    end
end

function MainUIPlayerMenu:ShowUnLockedMenuItem()
    local level = g_dataCenter.player.level
    self.BottomRightHideCount = 0
    for k,data in pairs(self.buttonData) do
        if not data.spec then
            if not PublicFunc.FuncIsOpen(data.unlockid)
            --or data.hide == true
            then
                data.btn:set_active(false)
                if data.pos == menuPos.BottomRight then
                    self.BottomRightHideCount = self.BottomRightHideCount + 1
                end
            else
                data.btn:set_active(true)
            end
        end
    end

    --self.buttonData[MsgEnum.eactivity_time.eActivityTime_Arm].btn:set_active(false)

    --商店是否显示
    --[[if self.btnShop then
        if g_dataCenter.shopInfo:IsSomeShopEnabled() then
            self.btnShop:set_active(true)
        else
            self.btnShop:set_active(false)
            self.BottomRightHideCount = self.BottomRightHideCount + 1
        end
    end]]

    -- vip礼包
    -- self.btn_libao:set_active(VipPrivilegeUI.GetIsVipGift());


    -- 一元购
    --self.btn_yiyuangou:set_active(g_dataCenter.activityReward:GetBuy1State() == 1);
    -- self.btn_qitian:set_active(true);

    --开服7天乐
    self.btn_qitian:set_active(g_dataCenter.signin:GetIsOpen() and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_Sign_in));
    -- 节日七天乐
    if self.btn_qitian_back then
        self.btn_qitian_back:set_active(g_dataCenter.signin:GetIsOpen_back());
    end

    --贩卖机
    self.btnVendingMachine:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_vending_machine)
    -- and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_vending_machine)
    )
    -- self.btnVendingMachine:set_active(true) -- Test


    -- 登录送礼
    self.btn_denglulibao:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_login_award)
    and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_LoginGift)
    );
    --战斗力排行
    if self.btn_power_rank then
        self.btn_power_rank:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_power_rank) and SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_PowerRank));
        --self.btn_power_rank:set_active(false);
    end
    -- 招财猫
    if self.btn_lucky_cat then
        self.btn_lucky_cat:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_lucky_cat));
    end

    --积分英雄
    local isShow = g_dataCenter.activityReward:IsShowScoreHero()
    self.btnScoreHero:set_active(isShow);
    if isShow then
        self:HandleScoreHeroTip()
    end

    --砸金蛋
    local isShow = g_dataCenter.activityReward:IsShowGoldenEgg()
    self.btnGoldenEgg:set_active(isShow);
    if isShow then
        self:HandleGoldenEggTip()
    end

    if self.spHurdleExtraActivity then
        self.spHurdleExtraActivity:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_hurdle_extra_produce));
    end

    if self.btn_challenge_sp_art_font2 then
        g_dataCenter.activityReward:SetChallengeSpriteName(self.btn_challenge_sp_art_font2);
    end
    if self.btn_pvp_sp_art_font2 then
        g_dataCenter.activityReward:SetPvpSpriteName(self.btn_pvp_sp_art_font2);
    end

    if self.btn_xianshigou then
        local activity_open = g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_limit_buy)
        local level_open = SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_limit_buy)
        self.btn_xianshigou:set_active(activity_open and level_open);
    end

    self.gridRightTop:reposition_now()
    self.gridRightTop2:reposition_now()
    self.bottomRightGrid:reposition_now()

    self.reLayoutCount = 1
end

function MainUIPlayerMenu:UpdateUi()
    if self.ui == nil then return end

    local dis = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_apMax)
    local ap = PublicFunc.NumberToStringByCfg(g_dataCenter.player.ap)

    --local vipCf = g_dataCenter.player:GetVipData();
    local apmax = PublicFunc.NumberToStringByCfg(g_dataCenter.player:GetMaxAP())
    self.apLabel:set_text(ap.."/"..apmax);
    self.goldLabel:set_text(PublicFunc.NumberToStringByCfg(g_dataCenter.player.gold));
    self.crystalLabel:set_text(tostring(g_dataCenter.player.crystal));

    local isOpen = SystemEnterFunc.IsOpenFunc(MsgEnum.eactivity_time.eActivityTime_FirsetRecharge)
    local firstRechargeType = g_dataCenter.player:GetFirstRechargeType();
    if firstRechargeType and firstRechargeType == ENUM.ETypeFirstRecharge.haveGet then
        self.btn_first:set_active(false);
        self.btn_recharge:set_active(isOpen);
    else
        self.btn_first:set_active(isOpen);
        self.btn_recharge:set_active(false);
    end
    self.objGridCont:set_active(isOpen)

    self:ShowUnLockedMenuItem()
    self:HandleActivityPane()
    self:Update3dSceneUi()
    self:UpdatePlayerUi()
end

function MainUIPlayerMenu:gc_update_get_friend_ap_times()
end

function MainUIPlayerMenu:gc_update_friend()
end

function MainUIPlayerMenu:gc_add_friend_apply()
end

function MainUIPlayerMenu:Update(dt)

    local time = system.time()
    if self.lastUiTime ~= time then
        self.lastUiTime = time
        local formatTime = os.date("%H:%M",time)
        self.nowTimeLabel:set_text(tostring(formatTime))
    end

    if self.reLayoutCount == 1 then
        self.reLayoutCount = 2
    end
end

--[[实名认证按钮]]
function MainUIPlayerMenu:OnBtnRealNameAuthClick()
    --TODO 打开网页
    UiAnn.Start(UiAnn.Type.RealNameAuth,nil,UserCenter.check_realname_auth)
end

function MainUIPlayerMenu:OnClickSceneRole(name,x,y,game_obj)
    GetMainUI():ClickSceneRole(name,x,y,game_obj);
end
-------------------------- 新手引导用 ----------------------------
-- reposition_now异步执行，直接按照ui路径取出来的组件位置可能不对
function MainUIPlayerMenu:GetBtnUiByName(btn_name)
    if self.ui and self.reLayoutCount == 2 then
        return self.ui:get_child_by_name(tostring(btn_name))
    end
end


function MainUIPlayerMenu:OnShow()
    self.TeamShow:UpdateRole();
    self:ShowUnLockedMenuItem()
    self:HandleActivityPane()
    self:Update3dSceneUi()
    self:UpdatePlayerUi()

    if GetMainUI():GetFirstHideVerboseMenu() and not self.verbosIsShow then
        --self:ShowVerbosMenu(true)
        self.leftButtonIsOpen = true;
    end
    self:ShowVerbosContent(GetMainUI():GetFirstHideVerboseMenu())

    self.isRightTopMenuUnfold = true
    self.isDownMenuUnfold = true

    self.objRightTopArrow:set_local_rotation(0, 180, 0)
    self.objDownArrow:set_local_rotation(0, 0, 0)
end

function MainUIPlayerMenu:GetLeftCenterMenuBtnIsOpen()
    return self.leftButtonIsOpen
end

function MainUIPlayerMenu:ShowAdventureFingerNode(bool)
    self.showAdventureFinger = Utility.get_value(bool, false)

    if self.adventureFingerNode then
        self.adventureFingerNode:set_active(self.showAdventureFinger)
    end
end
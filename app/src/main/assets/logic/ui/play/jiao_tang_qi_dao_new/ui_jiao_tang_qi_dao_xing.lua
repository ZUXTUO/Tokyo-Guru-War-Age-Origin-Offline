UiJiaoTangQiDaoXing = Class('UiJiaoTangQiDaoXing',UiBaseClass);

--初始化
function UiJiaoTangQiDaoXing:Init()
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1602_church_guaji.assetbundle';
    UiBaseClass.Init(self);
    -- self:InitData();
    -- self:Restart();
end

--重新开始
function UiJiaoTangQiDaoXing:Restart()
    UiBaseClass.Restart(self);
    -- if self.ui then
    --     return;
    -- end
    -- self:RegistFunc();
    -- self:MsgRegist();
    -- self:InitUi();
    msg_activity.cg_churchpray_request_myslef_info();
end

--初始化数据
function UiJiaoTangQiDaoXing:InitData()
    UiBaseClass.InitData(self);
    -- self.ui = nil;
    -- self.bindfunc = {};
    self.obj_hook_clone = {};
    self.sp_hook_clone = {};
    self.obj_chanllenge_clone = {};
    self.sp_chanllenge_clone = {};
end

--析构函数
function UiJiaoTangQiDaoXing:DestroyUi()
    UiBaseClass.DestroyUi(self);
    Root.DelUpdate(self.Update);
    --self.ui = nil;
    if self.ui_info then
        self.ui_info:DestroyUi()
        self.ui_info = nil;
    end
    if self.texture_hero then
        self.texture_hero:Destroy();
        self.texture_hero = nil;
    end
    if self.timer_ani then
        timer.stop(self.timer_ani);
        self.timer_ani = nil;
    end
    --self:MsgUnRegist();
    --self:UnregistFunc();
end

--显示ui
function UiJiaoTangQiDaoXing:Show()
    UiBaseClass.Show(self);
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(true);
end

--隐藏ui
function UiJiaoTangQiDaoXing:Hide()
    UiBaseClass.Hide(self);
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(false);
end

--注册回调函数
function UiJiaoTangQiDaoXing:RegistFunc()
    UiBaseClass.RegistFunc(self);
    --self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_btn_exit'] = Utility.bind_callback(self,self.on_btn_exit);
    self.bindfunc['on_btn_challenge'] = Utility.bind_callback(self,self.on_btn_challenge);
    self.bindfunc['on_btn_check'] = Utility.bind_callback(self,self.on_btn_check);
    self.bindfunc['on_btn_chat'] = Utility.bind_callback(self,self.on_btn_chat);
    self.bindfunc['on_btn_add_friend'] = Utility.bind_callback(self,self.on_btn_add_friend);
    self.bindfunc['on_btn_speedup'] = Utility.bind_callback(self,self.on_btn_speedup);
    self.bindfunc['on_btn_get'] = Utility.bind_callback(self,self.on_btn_get);
    self.bindfunc['on_btn_buy'] = Utility.bind_callback(self,self.on_btn_buy);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self,self.on_btn_close);
    self.bindfunc['on_btn_back'] = Utility.bind_callback(self,self.on_btn_back);
    self.bindfunc['on_btn_back2'] = Utility.bind_callback(self,self.on_btn_back2);
    self.bindfunc['on_btn_hook'] = Utility.bind_callback(self,self.on_btn_hook);
    self.bindfunc['on_player_info'] = Utility.bind_callback(self,self.on_player_info);
    self.bindfunc['on_rule'] = Utility.bind_callback(self,self.on_rule);

    self.bindfunc['gc_btn_speedup'] = Utility.bind_callback(self,self.gc_btn_speedup);
    self.bindfunc['gc_btn_get'] = Utility.bind_callback(self,self.gc_btn_get);
    self.bindfunc['gc_btn_get_card_info'] = Utility.bind_callback(self,self.gc_btn_get_card_info);
    self.bindfunc['gc_btn_leave_activity'] = Utility.bind_callback(self,self.gc_btn_leave_activity);
    self.bindfunc['gc_btn_buy'] = Utility.bind_callback(self,self.gc_btn_buy);
    --self.bindfunc['gc_btn_exit'] = Utility.bind_callback(self,self.gc_btn_exit);
    self.bindfunc['gc_del_hero'] = Utility.bind_callback(self,self.gc_del_hero);
    self.bindfunc['gc_add_hero'] = Utility.bind_callback(self,self.gc_add_hero);
    self.bindfunc['gc_churchpray_sync_myself_info'] = Utility.bind_callback(self,self.gc_churchpray_sync_myself_info);
    --self.bindfunc['gc_churchpray_set_card'] = Utility.bind_callback(self,self.gc_churchpray_set_card);
    self.bindfunc['gc_leave_activity'] = Utility.bind_callback(self,self.gc_leave_activity);

    self.bindfunc['on_sure_buy'] = Utility.bind_callback(self,self.on_sure_buy);
    self.bindfunc['GetReward'] = Utility.bind_callback(self,self.GetReward);
    self.bindfunc['SpeedUp'] = Utility.bind_callback(self,self.SpeedUp);
    self.bindfunc['after_get_hook'] = Utility.bind_callback(self,self.after_get_hook);  --领取奖励后，直接挂机
    self.bindfunc['after_get_challenge'] = Utility.bind_callback(self,self.after_get_challenge);  --领取奖励后，挑战
    self.bindfunc['gc_kick_out_church'] = Utility.bind_callback(self,self.gc_kick_out_church);  --被人踢出教堂
    self.bindfunc['gc_next_day_church_reset'] = Utility.bind_callback(self,self.gc_next_day_church_reset);  --跨天
    self.bindfunc['gc_church_time_over'] = Utility.bind_callback(self,self.gc_church_time_over);  --时间用尽
    --self.bindfunc['gc_churchpray_enter_church'] = Utility.bind_callback(self,self.gc_churchpray_enter_church);  --请求教堂数据
    self.bindfunc["HideTips"] = Utility.bind_callback(self,self.HideTips);  --请求教堂数据
    self.bindfunc["success_ani"] = Utility.bind_callback(self,self.success_ani);  --请求教堂数据
    self.bindfunc["vip_too_low"] = Utility.bind_callback(self,self.vip_too_low);  --请求教堂数据
    self.bindfunc["buy_number_max"] = Utility.bind_callback(self,self.buy_number_max);  --请求教堂数据
end

--注销回调函数
function UiJiaoTangQiDaoXing:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
    -- for k,v in pairs(self.bindfunc) do
    --     if v ~= nil then
    --         Utility.unbind_callback(self, v);
    --     end
    -- end
end

function UiJiaoTangQiDaoXing:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_btn_speedup']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_btn_get']);
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_request_card_info,self.bindfunc['gc_btn_get_card_info']);
    --PublicFunc.msg_regist(msg_activity.gc_leave_activity,self.bindfunc['gc_btn_leave_activity']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_times,self.bindfunc['gc_btn_buy']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_churchpray_sync_myself_info']);
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_btn_exit']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_role_leave,self.bindfunc['gc_del_hero']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_role_join,self.bindfunc['gc_add_hero']);
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_set_card,self.bindfunc['gc_churchpray_set_card']);
    --PublicFunc.msg_regist(msg_activity.gc_leave_activity,self.bindfunc['gc_leave_activity']);
    PublicFunc.msg_regist(msg_activity.gc_kick_out_church,self.bindfunc['gc_kick_out_church']);
    PublicFunc.msg_regist(msg_activity.gc_next_day_church_reset,self.bindfunc['gc_next_day_church_reset']);
    PublicFunc.msg_regist(msg_activity.gc_church_time_over,self.bindfunc['gc_church_time_over']);
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_enter_church,self.bindfunc['gc_churchpray_enter_church']);
end

function UiJiaoTangQiDaoXing:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_btn_speedup']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_btn_get']);
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_request_card_info,self.bindfunc['gc_btn_get_card_info']);
    --PublicFunc.msg_unregist(msg_activity.gc_leave_activity,self.bindfunc['gc_btn_leave_activity']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_times,self.bindfunc['gc_btn_buy']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_churchpray_sync_myself_info']);
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_btn_exit']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_role_leave,self.bindfunc['gc_del_hero']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_role_join,self.bindfunc['gc_add_hero']);
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_set_card,self.bindfunc['gc_churchpray_set_card']);
    --PublicFunc.msg_unregist(msg_activity.gc_leave_activity,self.bindfunc['gc_leave_activity']);
    PublicFunc.msg_unregist(msg_activity.gc_kick_out_church,self.bindfunc['gc_kick_out_church']);
    PublicFunc.msg_unregist(msg_activity.gc_next_day_church_reset,self.bindfunc['gc_next_day_church_reset']);
    PublicFunc.msg_unregist(msg_activity.gc_church_time_over,self.bindfunc['gc_church_time_over']);
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_enter_church,self.bindfunc['gc_churchpray_enter_church']);
end

--初始化UI
function UiJiaoTangQiDaoXing:LoadUI()
    UiBaseClass.LoadUI(self);
end

-- --资源加载回调
-- function UiJiaoTangQiDaoXing:on_loaded(pid, filepath, asset_obj, error_info)
--     if filepath == pathRes.UiJiaoTangQiDaoXing then
--         self:FindNguiObject(asset_obj);
--     end
-- end

--寻找ngui对象
function UiJiaoTangQiDaoXing:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
    --self.ui = asset_game_object.create(obj);
    self.ui:set_parent(Root.get_root_ui_2d_fight());
    self.ui:set_local_scale(1,1,1);
    self.ui:set_name('ui_1602_church_guaji');

    --do return end
    -----------------
    --寻找sprite

    --寻找texture
    --self.texture_hero = ngui.find_texture(self.ui, "center_other/animation/container_player/btn_under1/sp_under/texture_head1");
    --寻找content
    self.ani_begin_guaji = ngui.find_sprite(self.ui, "top_other/animation1"):get_game_object();
    self.ani_begin_guaji:set_active(false);
    self.cont_award_boss = ngui.find_sprite(self.ui, "down_other/animation/sp_bg1");
    self.cont_award_other = ngui.find_sprite(self.ui, "down_other/animation/sp_bg2");
    --self.cont_down = ngui.find_widget(self.ui, "down_other");
    --寻找button
    self.btn_exit = ngui.find_button(self.ui, 'top_other/btn_back');
    self.btn_exit:set_on_click(self.bindfunc['on_btn_exit']);

    --self.btn_speedup = ngui.find_button(self.ui, 'down_other/animation/container_speedup/btn_speedup');
    --self.btn_speedup:set_on_click(self.bindfunc['on_btn_speedup']);

    self.btn_getexp = ngui.find_button(self.ui, 'down_other/animation/btn_getexp');
    self.btn_getexp:set_on_click(self.bindfunc['on_btn_get']);

    self.btn_buy = ngui.find_button(self.ui, 'down_other/animation/btn_1');
    self.btn_buy:set_on_click(self.bindfunc['on_btn_buy']);
    self.btn_buy:set_active(false);

    self.btn_buy_gray = ngui.find_button(self.ui, 'down_other/animation/btn_2');
    self.btn_buy_gray:set_active(false);

    self.btn_background = ngui.find_button(self.ui, 'widget_back');
    self.btn_background:set_on_ngui_click(self.bindfunc['on_btn_back']);
    self.btn_background:set_on_ngui_drag_start(self.bindfunc['on_btn_back2']);

    self.btn_hook = ngui.find_button(self.ui, 'down_other/animation/btn_hook');
    self.btn_hook:set_active(false);
    self.btn_hook:set_event_value("",0);
    self.btn_hook:set_on_click(self.bindfunc['on_btn_hook']);

    self.btn_grab_pos = ngui.find_button(self.ui, 'down_other/animation/btn3');
    self.btn_grab_pos:set_on_click(self.bindfunc['on_player_info']);
    
    --寻找label
    --self.lab_guajizhong = ngui.find_label(self.ui, "center_other/animation/container_player/btn_under1/sp_under/lab");
    --self.lab_title = ngui.find_label(self.ui, "top_other/animation/sp_titlebackground/lab_title");
    self.lab_award_boss = ngui.find_label(self.ui, "down_other/animation/sp_bg1/lab_otherexp");
    self.lab_award_other = ngui.find_label(self.ui, "down_other/animation/sp_bg2/lab_otherexp");
    self.txt_other = ngui.find_label(self.ui, "down_other/animation/sp_bg2/lab_other");
    --self.lab_name = ngui.find_label(self.ui, "center_other/animation/container_player/lab_playername");
    --self.lab_level = ngui.find_label(self.ui, "center_other/animation/container_player/lab_level");

    self.lab_num_challenge = ngui.find_label(self.ui, "down_other/animation/txt");
    --self.lab_num_canbuy = ngui.find_label(self.ui, "down_other/animation/container_buy/lab_num_canbuy");

    self.lab_num_time = ngui.find_label(self.ui, "top_other/sp_clock/lab_time");
    --self.lab_cost = ngui.find_label(self.ui, "down_other/animation/container_speedup/sp_background/txt_speedup");

    self.lab_num_exp = ngui.find_label(self.ui, "down_other/animation/sp_bg3/lab_otherexp");

    self.sp_hook = ngui.find_button(self.ui, "center_other/animation/sp_gua_ji");
    self.sp_hook:set_active(false);
    self.sp_chanllenge = ngui.find_button(self.ui, "center_other/animation/sp_qiang_duo");
    self.sp_chanllenge:set_active(false);
    self.sp_chanllenge_img = ngui.find_sprite(self.ui, "center_other/animation/sp");
    self.sp_chanllenge_img:set_active(false);

    self.panel_tips = ngui.find_panel(self.ui, "panel_tips");
    self.panel_tips:set_active(false);

    self.lab_red = ngui.find_label(self.ui, "panel_tips/centre_other/content/lab_red");
    self.lab_tips = ngui.find_label(self.ui, "panel_tips/centre_other/content/txt");
    self.btn_mark = ngui.find_button(self.ui, "panel_tips/sp_mark");
    self.btn_sure = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_sure");
    self.btn_sure:set_on_click(self.bindfunc["GetReward"]);
    self.btn_no = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_no");
    self.btn_no:set_on_click(self.bindfunc["HideTips"]);

    local btnRule = ngui.find_button(self.ui, "top_other/btn_rule");
    btnRule:set_on_click(self.bindfunc["on_rule"]);
    --寻找wrap_content
    --寻找progress_bar
    self:SetBaseInfo();
    self:GetBurchHeroPos();
    self:CreateBtnHook();
    --self:CreateExtraDisPlay();
    --self:ShowEffect();
    self:UpdateUi();
    CameraManager.EnterTouchMoveMode(nil, self.btn_background, false, true)
    Root.AddUpdate(self.Update,self);
end

function UiJiaoTangQiDaoXing:GetBurchHeroPos()
    self.burchHeroPos = {};
    for i=1,self.length+2 do
        if self.burchhero[i].obj_name == "hbp_self" then
            self.burchHeroPos[-1] = self.burchhero[i];
        else
            local num = string.sub(self.burchhero[i].obj_name,string.find(self.burchhero[i].obj_name,"_")+1,string.len(self.burchhero[i].obj_name,true));
            num = tonumber(num);
            --app.log("num=="..num);
            self.burchHeroPos[num] = self.burchhero[i];
        end
    end
end

function UiJiaoTangQiDaoXing:SetBaseInfo()
    self.curIndex = 1;
    self.enterStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex();
    self.curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);
    self.curHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    -- if not self.curHeroID then
    --     self.curHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1)
    -- end
    self.curCardhuman = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,self.curHeroID);
    self.hurdle_id = ConfigManager.Get(EConfigIndex.t_jiao_tang_qi_dao_hurdle,self.enterStar).level;
    self.burchhero = ConfigHelper.GetMapInf(self.hurdle_id,EMapInfType.burchhero)
    self.length = #self.burchhero - 2;
end

function UiJiaoTangQiDaoXing:UpdateUi()
    UiBaseClass.UpdateUi(self)
    if not self.ui then return end
    -- self.curHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    -- if not self.curHeroID then
    --     self.curHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1)
    -- end
    self.curCardhuman = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,self.curHeroID);
    self.curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);
    local isPray = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(self.curIndex);
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local guaji_heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
    --app.log("isPray=="..tostring(isPray).."  tempHeroID=="..tostring(tempHeroID));

    local have_vacancy = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:CheckVacancy(self.enterStar);
    self.begin_time = system.time();
    self.last_time = system.time();
    --self:SetTitle();

    if self.enterStar == 1 then
        self.btn_grab_pos:set_active(false);
    else
        self.btn_grab_pos:set_active(true);
    end

    --加速所需钻石
    --self.lab_cost:set_text(tostring(ConfigManager.Get(EConfigIndex.t_church_pray_quick,self.enterStar).cost));
    local vip_level = g_dataCenter.player.vip;
    --剩余挑战次数
    local haveChallengedNumber = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetNumber();   --今日已挑战次数
    local thirdPartChallengeTimes = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetThirdPartChallengeTimes() or 0; --第三方挑战次数
    if not g_dataCenter.player:GetVipData() then
        app.log("vip_level=="..vip_level.."的配置表vip_data没有");
    end
    local vipTimes = g_dataCenter.player:GetVipData().churchpray_free_times;
    local dayChallengedNumber = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao).number_restriction.d; --今日可挑战次数
    local remainChallengeNumber;
    if dayChallengedNumber + vipTimes >= haveChallengedNumber then
        remainChallengeNumber = dayChallengedNumber + vipTimes + thirdPartChallengeTimes - haveChallengedNumber;   --剩余挑战次数
    else
        remainChallengeNumber = thirdPartChallengeTimes;
    end
    self.lab_num_challenge:set_text("可挑战次数:"..tostring(remainChallengeNumber));
    --可购买挑战次数
    local vipLevel = g_dataCenter.player.vip;
    -- if vipLevel == 0 then
    --     self.btn_buy:set_active(false);
    --     self.btn_buy_gray:set_active(true);
    --     self.btn_buy_gray:reset_on_click();
    --     self.btn_buy_gray:set_on_click(self.bindfunc['vip_too_low']);
    --     --self.lab_num_canbuy:set_text("0");
    -- else
    --     local canBuyChallengeNumber = ConfigManager.Get(EConfigIndex.t_vip_data,vipLevel).churchpray_buy_times or 0;   --vip今日可购买次数
    --     local remainCanBuyChallengeNumber = (canBuyChallengeNumber - g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetBuyChallengeTimes()) or 0;  --今日剩余可购买次数
    --     if remainCanBuyChallengeNumber <= 0 then
    --         remainCanBuyChallengeNumber = 0;
    --         self.btn_buy:set_active(false);
    --         self.btn_buy_gray:set_active(true);
    --         self.btn_buy_gray:reset_on_click();
    --         self.btn_buy_gray:set_on_click(self.bindfunc['buy_number_max']);
    --     else
    --         self.btn_buy:set_active(true);
    --         self.btn_buy_gray:set_active(false);
    --     end
    --     --self.lab_num_canbuy:set_text(tostring(remainCanBuyChallengeNumber));
    -- end
    --位置经验显示
    local exp_boos;
    local level = g_dataCenter.player.level;
    self.cont_award_boss:set_active(false);
    if self.enterStar ~= 1 then
        exp_boos = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(self.enterStar)];
        self.cont_award_boss:set_active(true);
        self.lab_award_boss:set_text(PublicFunc.NumberToStringByCfg(exp_boos)..PublicFunc.GetWord("jiaotangqidao_25"));
    end
    local exp_normal = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(self.enterStar)];
    self.lab_award_other:set_text(PublicFunc.NumberToStringByCfg(exp_normal)..PublicFunc.GetWord("jiaotangqidao_25"));
    
    local cardhuman = self.curCardhuman;
    local path_small_icon = cardhuman.small_icon;
    if path_small_icon and path_small_icon ~= 0 then
        --self.texture_hero:set_texture(path_small_icon);
        --item_manager.texturePadding(self.texture_hero,path_small_icon)
    end
    --self.lab_guajizhong:set_active(false);

    local left_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetLeftTime(1);
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(left_time);
    self.lab_num_time:set_text(string.format("%02d",hour)..":"..string.format("%02d",min)..":"..string.format("%02d",sec));
    local old_pray_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetPrayKeepTime(1);
    local total_exp = self:GetLocalTotalExp(old_pray_time,1);
    if total_exp > 0 then
        self.btn_getexp:set_enable(true);
    else
        self.btn_getexp:set_enable(false);
    end
    self.lab_num_exp:set_text(PublicFunc.NumberToStringByCfg(total_exp));







    if self.enterStar == 1 then
        --正在挂机
        if isPray then
            --换人了
            if tempHeroID ~= guaji_heroid then
                --有空位
                if have_vacancy then
                    --挂机按钮出现
                    self.btn_hook:set_active(true);
                    --self.cont_down:set_active(false);
                --没空位
                else
                    --挂机按钮不出现
                    self.btn_hook:set_active(false);
                    --self.cont_down:set_active(false);
                end
            --没换
            else
                --挂机教堂==进入教堂
                if self.curStar == self.enterStar then
                    self.btn_hook:set_active(false);
                    --self.cont_down:set_active(true);
                    --self.lab_guajizhong:set_active(true);
                --挂机教堂~=进入教堂
                else
                    if have_vacancy then
                        self.btn_hook:set_active(true);
                        --self.cont_down:set_active(false);
                    else
                        self.btn_hook:set_active(true);
                        --self.cont_down:set_active(false);
                    end
                end
            end
        --没挂机
        else
            if have_vacancy then
                self.btn_hook:set_active(true);
                --self.cont_down:set_active(false);
            else
                self.btn_hook:set_active(false);
                --self.cont_down:set_active(false);
            end
        end
    else
        self.btn_hook:set_active(false);
        --self.cont_down:set_active(false);
    end
end

function UiJiaoTangQiDaoXing:Update()
    if not self.ui then return end
    if self.enterStar ~= 1 then
        self:SetHookBtn();
    end

    if not g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(1) then return end
    local cur_time = system.time();
    if not self.last_time or self.last_time == cur_time then return end

    local pray_time = cur_time - self.begin_time;

    local left_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetLeftTime(1);
    local real_left_time = left_time - pray_time;
    if real_left_time < 0 then
        self.last_time = cur_time;
        return
    end
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(real_left_time);
    self.lab_num_time:set_text(string.format("%02d",hour)..":"..string.format("%02d",min)..":"..string.format("%02d",sec));

    local old_pray_time = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetPrayKeepTime(1);
    local total_exp = self:GetLocalTotalExp(pray_time+old_pray_time,1);
    if total_exp > 0 then
        self.btn_getexp:set_enable(true);
    else
        self.btn_getexp:set_enable(false);
    end
    self.lab_num_exp:set_text(PublicFunc.NumberToStringByCfg(total_exp));

    self.last_time = cur_time;

end

function UiJiaoTangQiDaoXing:SetTitle()
    -- local jiaotang_number = self.enterStar;
    -- if jiaotang_number == 1 then
    --     self.lab_title:set_text("一星教堂");
    -- elseif jiaotang_number == 2 then
    --     self.lab_title:set_text("二星教堂");
    -- elseif jiaotang_number == 3 then
    --     self.lab_title:set_text("三星教堂");
    -- elseif jiaotang_number == 4 then
    --     self.lab_title:set_text("四星教堂");
    -- elseif jiaotang_number == 5 then
    --     self.lab_title:set_text("五星教堂");
    -- end
end

function UiJiaoTangQiDaoXing:GetLocalTotalExp(prayKeepTime,index)
    local star = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(index);
    local level = g_dataCenter.player.level;
    local exp_boos;
    if star ~= 1 then
        exp_boos = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["boss_exp_reward"..tostring(star)];
    end
    local exp_normal = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)["normal_exp_reward"..tostring(star)];
    local exp = nil;
    --boss位置
    if star == 0 then
        exp = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].expPool[index] + g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].yesterdayExp[index];
    elseif star ~= 1 and g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].churchPosIndex[index] == 0 then
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(prayKeepTime);
        exp = math.floor(tonumber(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].yesterdayExp[index]) + prayKeepTime*(exp_boos)/3600);
    --其他位置
    else
        exp = math.floor(tonumber(g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao].yesterdayExp[index]) + prayKeepTime*exp_normal/3600);
    end
    return exp;
end

--删除房间某一位置玩家
function UiJiaoTangQiDaoXing:gc_del_hero(nstar, posIndex, cardgid)
    if nstar == 1 then
        --app.log("1星房间有人删除，不做处理");
        return;
    end
    --self.effect_no_body[posIndex]:set_active(true);
    --self.effect_have_body[posIndex]:set_active(false);
end

--增加房间某一位置玩家
function UiJiaoTangQiDaoXing:gc_add_hero(nstar, posIndex, roledata)
    if nstar == 1 then
        --app.log("1星房间有人加入，不做处理");
        return;
    end
    --self.effect_no_body[posIndex]:set_active(false);
    --self.effect_have_body[posIndex]:set_active(true);
end

function UiJiaoTangQiDaoXing:gc_kick_out_church(playerName, nchurchStar)
    local str = string.format(PublicFunc.GetWord("jiaotangqidao_4"), tostring(playerName), tonumber(nchurchStar));
    HintUI.SetAndShow(EHintUiType.zero, str);
end

function UiJiaoTangQiDaoXing:gc_next_day_church_reset()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_5"));
end

function UiJiaoTangQiDaoXing:gc_church_time_over()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_6"));
end

function UiJiaoTangQiDaoXing:CreateBtnHook()
    for i=0,self.length do
        local position = self.burchHeroPos[i];
        if not self.obj_hook_clone[i] then
            self.obj_hook_clone[i] = self.sp_hook:get_game_object():clone();
            self.obj_hook_clone[i]:set_name("sp_hook_"..i);
            self.sp_hook_clone[i] = ngui.find_button(self.obj_hook_clone[i], self.obj_hook_clone[i]:get_name());
            self.sp_hook_clone[i]:set_active(false);
            self.sp_hook_clone[i]:set_event_value("",i);
            self.sp_hook_clone[i]:set_on_click(self.bindfunc['on_btn_hook']);

            self.obj_chanllenge_clone[i] = self.sp_chanllenge:get_game_object():clone();
            self.obj_chanllenge_clone[i]:set_name("sp_chanllenge_"..i);
            self.sp_chanllenge_clone[i] = ngui.find_button(self.obj_chanllenge_clone[i], self.obj_chanllenge_clone[i]:get_name());
            self.sp_chanllenge_clone[i]:set_active(false);
            self.sp_chanllenge_clone[i]:set_active(false);
            self.sp_chanllenge_clone[i]:set_event_value("",i);
            self.sp_chanllenge_clone[i]:set_on_click(self.bindfunc['on_btn_hook']);
            --self.lab_hook_clone[i] = ngui.find_label(self.obj_hook_clone[i], "btn_hook_"..i.."/lab");
            --self.btn_hook_clone[i]:set_event_value("",i);
            --self.btn_hook_clone[i]:set_on_click(self.bindfunc['on_btn_hook']);
        end
    end
end

function UiJiaoTangQiDaoXing:SetHookBtn()
    local fight_camera = CameraManager.GetSceneCamera();
    if not fight_camera then
        app.log_warning("UiJiaoTangQiDaoXing:SetHookBtn()   没有战斗相机");
        return
    end
    local ui_camera = Root.get_ui_camera();
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    for i=0, self.length do
        local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(self.enterStar,i);
        local position = self.burchHeroPos[i];
        local px,py,pz = position.px,position.py,position.pz;
        local view_x, view_y, view_z = fight_camera:world_to_screen_point(px,py,pz);
        local ui_x, ui_y, ui_z = ui_camera:screen_to_world_point(view_x, view_y, view_z);
        self.obj_hook_clone[i]:set_position(ui_x, ui_y -0.25, 0);
        self.obj_chanllenge_clone[i]:set_position(ui_x, ui_y -0.25, 0);
        self.obj_hook_clone[i]:set_active(true);
        self.obj_chanllenge_clone[i]:set_active(true);
        if enemy_player then
            --self.obj_hook_clone[i]:set_active(true);
            local defTeam = enemy_player:GetDefTeam()
            local enemyID = defTeam[1];
            if enemyID == heroid then   --教堂中所有人中，有当前选择的人
                self.obj_hook_clone[i]:set_active(false);
                self.obj_chanllenge_clone[i]:set_active(false);
            else
                self.obj_hook_clone[i]:set_active(false);
                self.obj_chanllenge_clone[i]:set_active(true);
            end
        else
            self.obj_hook_clone[i]:set_active(true);
            self.obj_chanllenge_clone[i]:set_active(false);
        end
    end
end

function UiJiaoTangQiDaoXing:PlaySuccessAni()
    self.ani_begin_guaji:set_active(true);
    self.ani_begin_guaji:animator_play("panel_jiesuan_item_animation1");
    --self.timer_ani = timer.create(self.bindfunc['success_ani'],1000,1);
end

function UiJiaoTangQiDaoXing:success_ani()
    self.ani_begin_guaji:set_active(false);
    self.timer_ani = nil;
end


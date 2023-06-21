UiJiaoTangQiDaoMain = Class('UiJiaoTangQiDaoMain', UiBaseClass);

--初始化
function UiJiaoTangQiDaoMain:Init()
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1601_church_pray.assetbundle';
    UiBaseClass.Init(self);
    -- self:InitData();
    -- self:Restart();
end

--重新开始
function UiJiaoTangQiDaoMain:Restart()
    UiBaseClass.Restart(self);
    -- if self.ui then
    --     return;
    -- end
    -- self:RegistFunc();
    -- self:MsgRegist();
    -- self:InitUi();
    msg_activity.cg_request_all_church_pray_info()
    msg_activity.cg_churchpray_request_myslef_info();
end

--初始化数据
function UiJiaoTangQiDaoMain:InitData()
    UiBaseClass.InitData(self);
    -- self.ui = nil;
    -- self.bindfunc = {};
    self.curIndex = 1;
    -- self.texture_human = {};
    --self.is_show_dlg = false;
end

--析构函数
function UiJiaoTangQiDaoMain:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.node_hero then
        self.node_hero:DestroyUi();
        self.node_hero = nil;
    end
    if self.node_human then
        for k,v in pairs(self.node_human) do
            v:DestroyUi();
        end
        self.node_human = nil;
    end
    -- if self.texture_chose_human then
    --     self.texture_chose_human:Destroy();
    --     self.texture_chose_human = nil;
    -- end

    -- for k,v in pairs(self.texture_human) do
    --     v:Destroy();
    --     self.texture_human[k] = nil;
    -- end
end

--注册回调函数
function UiJiaoTangQiDaoMain:RegistFunc()
    UiBaseClass.RegistFunc(self);
    --self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_change_hero'] = Utility.bind_callback(self,self.on_change_hero);
    self.bindfunc['on_change_equip'] = Utility.bind_callback(self,self.on_change_equip);
    self.bindfunc['on_btn_enter'] = Utility.bind_callback(self,self.on_btn_enter);
    self.bindfunc['on_speed_up'] = Utility.bind_callback(self,self.on_speed_up);
    self.bindfunc['on_get_reward'] = Utility.bind_callback(self,self.on_get_reward);
    self.bindfunc['on_fight_report'] = Utility.bind_callback(self,self.on_fight_report);
    self.bindfunc['on_rule'] = Utility.bind_callback(self,self.on_rule);
    self.bindfunc['on_show_dlg'] = Utility.bind_callback(self,self.on_show_dlg);
    self.bindfunc['on_hide_dlg'] = Utility.bind_callback(self,self.on_hide_dlg);
    self.bindfunc['gc_fight_report'] = Utility.bind_callback(self,self.gc_fight_report);
    self.bindfunc['gc_btn_enter'] = Utility.bind_callback(self,self.gc_btn_enter);
    self.bindfunc['gc_speed_up'] = Utility.bind_callback(self,self.gc_speed_up);
    self.bindfunc['gc_get_reward'] = Utility.bind_callback(self,self.gc_get_reward);
    self.bindfunc['GetReward'] = Utility.bind_callback(self,self.GetReward);
    self.bindfunc['SpeedUp'] = Utility.bind_callback(self,self.SpeedUp);
    self.bindfunc['gc_churchpray_sync_myself_info'] = Utility.bind_callback(self,self.gc_churchpray_sync_myself_info);
    self.bindfunc['gc_kick_out_church'] = Utility.bind_callback(self,self.gc_kick_out_church);
    self.bindfunc['gc_next_day_church_reset'] = Utility.bind_callback(self,self.gc_next_day_church_reset);
    self.bindfunc['gc_church_time_over'] = Utility.bind_callback(self,self.gc_church_time_over);
    self.bindfunc['on_sure'] = Utility.bind_callback(self,self.on_sure);
    -- self.bindfunc['on_cancel'] = Utility.bind_callback(self,self.on_cancel);
    self.bindfunc['ChoseHero'] = Utility.bind_callback(self,self.ChoseHero);
end

function UiJiaoTangQiDaoMain:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_enter_church,self.bindfunc['gc_btn_enter']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_get_reward']);
    PublicFunc.msg_regist(msg_activity.gc_request_church_fight_record,self.bindfunc['gc_fight_report']);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_churchpray_sync_myself_info']);
    PublicFunc.msg_regist(msg_activity.gc_kick_out_church,self.bindfunc['gc_kick_out_church']);
    PublicFunc.msg_regist(msg_activity.gc_next_day_church_reset,self.bindfunc['gc_next_day_church_reset']);
    PublicFunc.msg_regist(msg_activity.gc_church_time_over,self.bindfunc['gc_church_time_over']);
end

function UiJiaoTangQiDaoMain:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_enter_church,self.bindfunc['gc_btn_enter']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_get_reward']);
    PublicFunc.msg_unregist(msg_activity.gc_request_church_fight_record,self.bindfunc['gc_fight_report']);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_churchpray_sync_myself_info']);
    PublicFunc.msg_unregist(msg_activity.gc_kick_out_church,self.bindfunc['gc_kick_out_church']);
    PublicFunc.msg_unregist(msg_activity.gc_next_day_church_reset,self.bindfunc['gc_next_day_church_reset']);
    PublicFunc.msg_unregist(msg_activity.gc_church_time_over,self.bindfunc['gc_church_time_over']);
end

--初始化UI
function UiJiaoTangQiDaoMain:LoadUI()
    UiBaseClass.LoadUI(self);
end

--寻找ngui对象
function UiJiaoTangQiDaoMain:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
    self.ui:set_name('ui_1601_jiao_tang_qi_dao');
    --self.begin_time = system.time();
    --system.ShowLogTime(self.begin_time,"当前时间==");
    --do return end
    -----------------
    self.btn_fight_report = ngui.find_button(self.ui, "down_other/animation/btn_ranklist");
    self.btn_fight_report:set_on_click(self.bindfunc['on_fight_report']);

    -- self.btn_rule = ngui.find_button(self.ui, "top_other/animation/panel/btn_rule");
    -- self.btn_rule:set_on_click(self.bindfunc['on_rule']);

    self.sp_effect = {};
    self.btn_jiaotang = {};
    self.node_human = {};
    self.content_human = {};
    self.lab_people_num = {};
    -- self.lab_click_enter = {};

    for i=1,5 do
        self.sp_effect[i] = ngui.find_sprite(self.ui, "centre_other/animation/grid/cont"..i.."/sp_kejinru");
        self.btn_jiaotang[i] = ngui.find_button(self.ui, "centre_other/animation/grid/cont"..i.."/sp_di");
        self.btn_jiaotang[i]:set_event_value("",i);
        self.btn_jiaotang[i]:set_on_click(self.bindfunc['on_show_dlg']);
        local obj = self.ui:get_child_by_name("centre_other/animation/grid/cont"..i.."/sp_mark/big_card_item_80");
        self.node_human[i] = SmallCardUi:new({parent=obj,sgroup=2});
        self.content_human[i] = self.ui:get_child_by_name("centre_other/animation/grid/cont"..i.."/sp_mark");
        self.lab_people_num[i] = ngui.find_label(self.ui, "centre_other/animation/grid/cont"..i.."/sp_bk/lab_num");
        -- self.lab_click_enter[i] = ngui.find_label(self.ui, "centre_other/animation/grid/cont"..i.."/lab_dian_ji");
    end

    self.lab_time = ngui.find_label(self.ui, "content_qidaozhong/content_speed/lab_exp");
    self.lab_exp = ngui.find_label(self.ui, "content_qidaozhong/content_get/lab_exp");

    --self.btn_speed = ngui.find_button(self.ui, "content_qidaozhong/content_speed/btn_get");
    --self.btn_speed:set_on_click(self.bindfunc["on_speed_up"]);

    --self.btn_get = ngui.find_button(self.ui, "content_qidaozhong/content_get/btn_get");
    --self.btn_get:set_on_click(self.bindfunc["on_get_reward"]);

    --self.content_change_hero = ngui.find_panel(self.ui, "panel_tips");
    --self.content_change_hero:set_active(false);

    -- self.btn_mark = ngui.find_button(self.ui, "panel_tips/sp_mark");
    --self.btn_mark:set_on_click(self.bindfunc["on_hide_dlg"]);
    --self.btn_close = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_close");
    --self.btn_close:set_on_click(self.bindfunc["on_hide_dlg"]);

    --self.btn_sure = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_sure");
    --self.btn_sure:set_on_click(self.bindfunc['on_btn_enter']);

    --self.btn_change_hero = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_herochange");
    --self.btn_change_hero:set_on_click(self.bindfunc['on_change_hero']);

    self.btn_change_hero = ngui.find_button(self.ui, "centre_other/animation/content/btn1");
    self.btn_change_hero:set_on_click(self.bindfunc['on_change_hero']);
    self.lab_change_hero = ngui.find_label(self.ui, "centre_other/animation/content/btn1/animation/lab");

    local obj = self.ui:get_child_by_name("centre_other/animation/content/big_card_item_80");
    self.node_hero = SmallCardUi:new({parent=obj,sgroup=2});
    self.lab_hero_name = ngui.find_label(self.ui,"centre_other/animation/content/lab_name");
    -- self.btn_hero = ngui.find_button(self.ui, "centre_other/animation/cont1/content/human1/sp_di");
    -- self.btn_hero:set_on_click(self.bindfunc['on_change_equip']);

    --self.txt_fight_value = ngui.find_label(self.ui, "panel_tips/centre_other/content/txt_zhan_li");
    --self.lab_fight_value = ngui.find_label(self.ui, "panel_tips/centre_other/content/lab_zhan_li");
    -- self.texture_chose_human = ngui.find_texture(self.ui, "centre_other/animation/cont1/content/human1/sp_human");
    -- self.sp_add = ngui.find_sprite(self.ui, "centre_other/animation/cont1/content/human1/sp_add");

    -- self.panel_tips = ngui.find_panel(self.ui, "panel_tips");
    -- self.panel_tips:set_active(false);
    -- self.btn_sure = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_sure");
    -- self.btn_sure:set_on_click(self.bindfunc['on_sure']);
    -- self.btn_cancel = ngui.find_button(self.ui, "panel_tips/centre_other/content/btn_no");
    -- self.btn_cancel:set_on_click(self.bindfunc['on_cancel']);
    -- self.lab_panel_tips = ngui.find_label(self.ui, "panel_tips/centre_other/content/txt");

    self:UpdateUi();
    --Root.AddUpdate(self.Update, self);
end

function UiJiaoTangQiDaoMain:UpdateUi()
    UiBaseClass.UpdateUi(self);
    if not self.ui then return end
    for i=1,5 do
        self.sp_effect[i]:set_active(false);
        self.content_human[i]:set_active(false);
        -- self.lab_click_enter[i]:set_active(true);
        if i==1 then
            self.lab_people_num[i]:set_text(PublicFunc.GetWord("jiaotangqidao_1"));
        else
            local have_people = info:GetAllChurchInfo(i);
            local all_people = ConfigManager.Get(EConfigIndex.t_church_pos_data,i).poscnt;
            if have_people > all_people then
                have_people = all_people;
            end
            self.lab_people_num[i]:set_text(tostring(have_people).."/"..tostring(all_people));
        end
    end

    local total_exp = info:GetTotalExp(1);
    if total_exp > 0 then
        --self.btn_get:set_enable(true);
    else
        --self.btn_get:set_enable(false);
    end
    self.lab_exp:set_text(PublicFunc.NumberToStringByCfg(total_exp));

    local left_time = info:GetLeftTime(1);
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(left_time);
    self.lab_time:set_text(string.format("%02d",hour)..":"..string.format("%02d",min)..":"..string.format("%02d",sec));
    self.begin_time = system.time();
    self.last_time = system.time();

    --self.content_change_hero:set_active(false);
    local tempHeroId = info:GetTempChoseHero();

    --正在祈祷中
    if info:GetIsPray(1) then
        --self.btn_speed:set_enable(true);
        local number_jiaotang = info:GetCurJiaoTangIndex(1);
        self.sp_effect[number_jiaotang]:set_active(true);
        self.content_human[number_jiaotang]:set_active(true);
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,info:GetQidaoHero(1))
        -- local path = nil;
        if card then
            -- path = card.small_icon;
            self.node_human[number_jiaotang]:SetData(card);
        else
            app.log("没找到卡片");
            return;
        end
        -- if path and path ~= 0 then
            -- self.texture_human[number_jiaotang]:set_texture(path);
            --item_manager.texturePadding(self.texture_human[number_jiaotang],path)
        -- end
        -- self.lab_click_enter[number_jiaotang]:set_active(false);
    --没在祈祷中
    else
        --self.btn_speed:set_enable(false);
    end

    -- if self.is_show_dlg then
    --     self.content_change_hero:set_active(true);
    --     self.is_show_dlg = false;
    -- else
    --     self.content_change_hero:set_active(false);
    -- end
    --有临时选择的英雄
    if tempHeroId then
        -- self.texture_chose_human:set_active(true);
        --self.lab_fight_value:set_active(true);
        --self.txt_fight_value:set_active(true);
        --self.btn_change_hero:set_active(true);
        self.lab_change_hero:set_text(PublicFunc.GetWord("jiaotangqidao_2"));
        -- self.sp_add:set_active(false);
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,tempHeroId);
        if not card then
            app.log("没找到卡片");
            return
        end
        self.node_hero:SetData(card);
        self.lab_hero_name:set_text(card.name);
        -- self.texture_chose_human:set_texture(card.small_icon);
        --item_manager.texturePadding(self.texture_chose_human,card.small_icon);
        --local fight_value = card:GetFightValue();
        --self.lab_fight_value:set_text(tostring(fight_value));
        --self.btn_sure:set_enable(true);
    else
        if info:GetQidaoHero(1) and info:GetQidaoHero(1) ~= "0" then
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,info:GetQidaoHero(1))
            -- local path = nil;
            if card then
                -- path = card.small_icon;
            else
                app.log("没找到卡片");
                return;
            end
            -- if path and path ~= 0 then
                if not tempHeroId then
                    self.node_hero:SetData(card);
                    self.lab_hero_name:set_text(card.name);
                    -- self.texture_chose_human:set_texture(path);
                    --item_manager.texturePadding(self.texture_chose_human,path);
                end
            -- end
            -- self.texture_chose_human:set_active(true);
            --self.lab_fight_value:set_active(true);
            --self.txt_fight_value:set_active(true);
            --self.btn_change_hero:set_active(true);
            self.lab_change_hero:set_text(PublicFunc.GetWord("jiaotangqidao_2"));
            -- self.sp_add:set_active(false);
            -- local fight_value = card:GetFightValue();
            -- self.lab_fight_value:set_text(tostring(fight_value));
            -- self.btn_sure:set_enable(true);
        else
            self.node_hero:SetData(nil);
            self.lab_hero_name:set_text("");
            -- self.texture_chose_human:set_active(false);
            -- self.lab_fight_value:set_active(false);
            -- self.txt_fight_value:set_active(false);
            --self.btn_change_hero:set_active(false);
            self.lab_change_hero:set_text(PublicFunc.GetWord("jiaotangqidao_3"));
            -- self.sp_add:set_active(true);
            --self.btn_sure:set_enable(false);
        end
    end
end

function UiJiaoTangQiDaoMain:Update()
    if not self.ui then return end
    if not info:GetIsPray(1) then return end
    local cur_time = system.time();
    if not self.last_time or self.last_time == cur_time then return end

    local pray_time = cur_time - self.begin_time;

    local left_time = info:GetLeftTime(1);
    local real_left_time = left_time - pray_time;
    if real_left_time < 0 then
        self.last_time = cur_time;
        return
    end
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(real_left_time);
    self.lab_time:set_text(string.format("%02d",hour)..":"..string.format("%02d",min)..":"..string.format("%02d",sec));

    local old_pray_time = info:GetPrayKeepTime(1);
    local total_exp = self:GetLocalTotalExp(pray_time+old_pray_time,1);
    if total_exp > 0 then
        --self.btn_get:set_enable(true);
    else
        --self.btn_get:set_enable(false);
    end
    self.lab_exp:set_text(PublicFunc.NumberToStringByCfg(total_exp));

    self.last_time = cur_time;
end

function UiJiaoTangQiDaoMain:GetLocalTotalExp(prayKeepTime,index)
    local star = info:GetCurJiaoTangIndex(index);
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

function UiJiaoTangQiDaoMain:on_fight_report()
    msg_activity.cg_request_church_fight_record()
end

function UiJiaoTangQiDaoMain:gc_fight_report(vecFightRecordData)
    uiManager:PushUi(EUI.UiJiaoTangQiDaoReport)
end

function UiJiaoTangQiDaoMain:gc_churchpray_sync_myself_info(buyChallengeTimes, thirdPartChallengeTimes, myPoslist)
    self:UpdateUi();
end

function UiJiaoTangQiDaoMain:gc_kick_out_church(playerName, nchurchStar)
    local str = string.format(PublicFunc.GetWord("jiaotangqidao_4"),tostring(playerName),tonumber(nchurchStar));
    HintUI.SetAndShow(EHintUiType.zero, str);
end

function UiJiaoTangQiDaoMain:gc_next_day_church_reset()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_5"));
end

function UiJiaoTangQiDaoMain:gc_church_time_over()
    HintUI.SetAndShow(EHintUiType.zero, PublicFunc.GetWord("jiaotangqidao_6"));
end

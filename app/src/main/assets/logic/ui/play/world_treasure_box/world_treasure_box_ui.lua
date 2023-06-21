--[[
region world_treasure_box_ui.lua
date: 2016-7-19
time: 11:0:45
author: Nation
]]

WorldTreasureBoxUI = Class('WorldTreasureBoxUI',UiBaseClass);
--------------------------------------------------
--初始化
function WorldTreasureBoxUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/baoxiang/ui_3901_word_box.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function WorldTreasureBoxUI:InitData(data)
    self.str_open_time = ""
    local world_treasure_cfg = ConfigManager._GetConfigTable(EConfigIndex.t_world_treasure_box)
    if world_treasure_cfg then
        local str_open_time = ""
        for k,v in pairs(world_treasure_cfg) do
            local begin_hour = v.hour
            local begin_min = v.min
            local end_hour = begin_hour
            local end_min = begin_min
            local pass_hour = math.floor(v.last_time / 3600)
            local pass_min = math.floor((v.last_time - pass_hour*3600)/60)
            end_hour = end_hour + pass_hour
            end_min = end_min + pass_min
            if end_min >= 59 then
                end_hour = end_hour+1
                end_min = end_min-60
            end
            local begin_time = PublicFunc.FormatTime(begin_hour, begin_min)
            local end_time = PublicFunc.FormatTime(end_hour, end_min)
            if k ~= 1 then
                str_open_time = str_open_time..","
            end
            str_open_time = str_open_time.."每周"
            local str_week_day = ""
            for i=1, #v.weekday do
                if str_week_day ~= "" then
                    str_week_day = str_week_day.."、"
                end
                if v.weekday[i] == 1 then
                    str_week_day = str_week_day.."一"
                elseif v.weekday[i] == 2 then
                    str_week_day = str_week_day.."二"
                elseif v.weekday[i] == 3 then
                    str_week_day = str_week_day.."三"
                elseif v.weekday[i] == 4 then
                    str_week_day = str_week_day.."四"
                elseif v.weekday[i] == 5 then
                    str_week_day = str_week_day.."五"
                elseif v.weekday[i] == 6 then
                    str_week_day = str_week_day.."六"
                elseif v.weekday[i] == 0 then
                    str_week_day = str_week_day.."日"
                end
            end
            local optimized, ret_str = PublicFunc.OptimizingWeekday(str_week_day)
            if optimized then
                str_week_day = ret_str
            end
            str_open_time = str_open_time..str_week_day
            str_open_time = str_open_time.."[FFC000FF]"
            str_open_time = str_open_time..begin_time.."~"..end_time.."[-]"
        end
        str_open_time = str_open_time.."开启"
        self.str_open_time = str_open_time
    end
    UiBaseClass.InitData(self, data);
end

--重新开始
function WorldTreasureBoxUI:Restart(data)
    self:Clear()
    msg_world_treasure_box.cg_request_point_rank()
    if g_dataCenter.worldTreasureBox:IsOpen() then
        msg_world_treasure_box.cg_request_world_treasure_box_num()
    end
    
    UiBaseClass.Restart(self, data);
end

--析构函数
function WorldTreasureBoxUI:DestroyUi()
    self:Clear()
    UiBaseClass.DestroyUi(self);
end

--注册回调函数
function WorldTreasureBoxUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_change_team"] = Utility.bind_callback(self, self.on_btn_change_team);
    self.bindfunc["on_btn_enter_system"] = Utility.bind_callback(self, self.on_btn_enter_system);
    self.bindfunc["gc_sync_world_treasure_box_state"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_state);
    self.bindfunc["gc_sync_world_treasure_box_point_rank"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_point_rank);
    self.bindfunc["on_backup"] = Utility.bind_callback(self, self.on_backup);
end

--注册消息分发回调函数
function WorldTreasureBoxUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_fight.gc_sync_world_treasure_box_point_rank, self.bindfunc['gc_sync_world_treasure_box_point_rank']);
    PublicFunc.msg_regist(msg_world_treasure_box.gc_sync_world_treasure_box_state, self.bindfunc['gc_sync_world_treasure_box_state']);
end

--注销消息分发回调函数
function WorldTreasureBoxUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_fight.gc_sync_world_treasure_box_point_rank, self.bindfunc['gc_sync_world_treasure_box_point_rank']);
    PublicFunc.msg_unregist(msg_world_treasure_box.gc_sync_world_treasure_box_state, self.bindfunc['gc_sync_world_treasure_box_state']);
end

function WorldTreasureBoxUI:Clear()
    --self.lab_count_down_type = nil
    --self.lab_count_down_time = nil
    self.rank_info = {}
    --self.star_info = {}
    self.head_info = nil
    self.lab_rank_info_type = nil
    self.btn_change_team = nil
    self.btn_enter_system = nil
    self.spr_enter_system_bk = nil
    self.lab_hero_name = nil
    self.lab_hero_fight_value = nil
    self.lab_open_time = nil
    self.box_num_obj = nil
    self.big_box_num = nil
    self.small_box_num = nil
    --self.sp_new = nil
    self.objHeroIcon = nil
    self.heroIcon = nil
end

--寻找ngui对象
function WorldTreasureBoxUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d())
    self.ui:set_local_scale(1,1,1)
    self.ui:set_local_position(0,0,0)
    self.ui:set_name("ui_world_treasure_box");

    --self.lab_count_down_type = ngui.find_label(self.ui, "centre_other/animation/sp_di/txt");
    --self.lab_count_down_time = ngui.find_label(self.ui, "centre_other/animation/sp_di/lab");
    for i=1, 3 do
        self.rank_info[i] = {}
        self.rank_info[i].content_lab = self.ui:get_child_by_name("centre_other/animation/content/content"..i.."/cont");
        self.rank_info[i].lab_not_rank = ngui.find_label(self.ui, "centre_other/animation/content/content"..i.."/txt");
        self.rank_info[i].lab_country_name = ngui.find_label(self.ui, "centre_other/animation/content/content"..i.."/cont/lab");
        self.rank_info[i].lab_points = ngui.find_label(self.ui, "centre_other/animation/content/content"..i.."/cont/lab_num");
        self.rank_info[i].spr_mysterious_box = ngui.find_sprite(self.ui, "centre_other/animation/content/content"..i.."/sp_arrows");
    end

    self.btn_change_team = ngui.find_button(self.ui, "centre_other/animation/content/sp_bk/btn");
    self.btn_change_team:set_on_click(self.bindfunc["on_btn_change_team"]);
    self.btn_enter_system = ngui.find_button(self.ui, "down_other/animation/btn2");
    self.btn_enter_system:set_on_click(self.bindfunc["on_btn_enter_system"]);
    self.spr_enter_system_bk = ngui.find_sprite(self.ui, "down_other/animation/btn2/animation/sp");
    self.lab_enter_system = ngui.find_label(self.ui, "down_other/animation/btn2/animation/lab");
    self.lab_hero_name = ngui.find_label(self.ui, "centre_other/animation/content/sp_bk/cont/lab_name");

    self.objHeroIcon = self.ui:get_child_by_name('centre_other/animation/content/sp_bk/big_card_item_80')

    self.lab_hero_fight_value = ngui.find_label(self.ui, "centre_other/animation/content/sp_bk/cont/sp_fight/lab_fight");
    --[[for i=1, PublicStruct.Const.HERO_MAX_STAR do
        self.star_info[i] = ngui.find_sprite(self.ui, "centre_other/animation/content/sp_bk/cont/content_star/sp_star"..i);
    end]]
    self.lab_open_time = ngui.find_label(self.ui, "down_other/animation/txt_title");
    self.lab_open_time:set_text(self.str_open_time)
    self.lab_rank_info_type = ngui.find_label(self.ui, "centre_other/animation/content/sp_di2/lab_art_font")
    self.box_num_obj = self.ui:get_child_by_name("down_other/animation/cont")
    self.big_box_num = ngui.find_label(self.ui, "down_other/animation/cont/lab1");
    self.small_box_num = ngui.find_label(self.ui, "down_other/animation/cont/lab2");
    --self.sp_new = ngui.find_sprite( self.ui, "down_other/animation/sp_point" );
    local _btnBackup = ngui.find_button(self.ui,"down_other/animation/btn_zhuzhen");
    _btnBackup:set_on_click(self.bindfunc["on_backup"]);
	self:UpdateUi();
end

--刷新界面
function WorldTreasureBoxUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then 
        return 
    end
    if g_dataCenter.worldTreasureBox:IsOpen() then
        --self.lab_count_down_type:set_text(tostring(gs_string_world_treasure_box["close_count_down"]))
        self.spr_enter_system_bk:set_color(1, 1, 1, 1)
        self.lab_enter_system:set_effect_color(174/255, 65/255, 40/255, 1);
        --self.lab_rank_info_type:set_text("实时战报")
        self.box_num_obj:set_active(true)
        local small_cnt, big_cnt = g_dataCenter.worldTreasureBox:GetTreasureBoxNum();
        self.big_box_num:set_text(tostring(big_cnt))
        self.small_box_num:set_text(tostring(small_cnt))
    else
        --self.lab_count_down_type:set_text(tostring(gs_string_world_treasure_box["open_count_down"]))
        self.spr_enter_system_bk:set_color(0, 0, 0, 1)
        self.lab_enter_system:set_effect_color(139/255, 139/255, 139/255, 1);
        --self.lab_rank_info_type:set_text("历史战报")
        self.box_num_obj:set_active(false)
    end
    local have_rank = false
    for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
        if g_dataCenter.worldTreasureBox.rank_info[i] and g_dataCenter.worldTreasureBox.rank_info[i].points > 0 then
            have_rank = true
        end
    end
    for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
        if g_dataCenter.worldTreasureBox.rank_info[i] and have_rank then
            local name = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.worldTreasureBox.rank_info[i].country_id).name;
            self.rank_info[i].lab_country_name:set_text(tostring(name))
            self.rank_info[i].lab_points:set_text(tostring(g_dataCenter.worldTreasureBox.rank_info[i].points))
            self.rank_info[i].spr_mysterious_box:set_active(g_dataCenter.worldTreasureBox.open_mysterious_box_country == g_dataCenter.worldTreasureBox.rank_info[i].country_id)
            self.rank_info[i].content_lab:set_active(true)
            self.rank_info[i].lab_not_rank:set_active(false)
        else 
            self.rank_info[i].content_lab:set_active(false)
            self.rank_info[i].lab_not_rank:set_active(true)
            self.rank_info[i].lab_country_name:set_text("")
            self.rank_info[i].lab_points:set_text("")
            self.rank_info[i].spr_mysterious_box:set_active(false)
        end
    end
    local team = g_dataCenter.player:GetTeam(ENUM.ETeamType.world_treasure_box)
    local card_data_id
    if team and #team ~= 0 then
        card_data_id = team[1]
    else
        local defTeam = g_dataCenter.player:GetDefTeam();
        local team = 
        {
            teamid = ENUM.ETeamType.world_treasure_box,
            cards = {defTeam[1]},
        }
        card_data_id = defTeam[1]
        msg_team.cg_update_team_info(team);
    end
    local human = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, card_data_id);
    if human then
        self.lab_hero_name:set_text(tostring(human.name))
        if self.heroIcon then
            self.heroIcon = nil
        end
        local info = CardHuman:new({number = human.number, level = human.level, count = 1});
        self.heroIcon = SmallCardUi:new({parent = self.objHeroIcon, info = info,
            stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity,SmallCardUi.SType.Leader,SmallCardUi.SType.Star }})
        self.lab_hero_fight_value:set_text(tostring(human:GetFightValue()))
        --[[for i=1, PublicStruct.Const.HERO_MAX_STAR do
            if self.star_info[i] then
                if i <= human.rarity then
                    self.star_info[i]:set_sprite_name("xingxing1")
                else
                    self.star_info[i]:set_sprite_name("xingxing3")
                end
            end
        end]]
    end
    --if self.sp_new then
    --    self.sp_new:set_active(g_dataCenter.worldTreasureBox:IsOpen())
    --end
end

function WorldTreasureBoxUI:Update(dt)
    if not UiBaseClass.Update(self, dt) then 
        return 
    end
    if g_dataCenter.worldTreasureBox.system_state then
        local left_second = g_dataCenter.worldTreasureBox.system_state.left_time
        local pass_time = PublicFunc.QueryDeltaTime(g_dataCenter.worldTreasureBox.system_state.left_time_start)
        left_second = left_second - pass_time/1000
        left_second = math.max(0, left_second)
        local time = PublicFunc.FormatLeftSeconds(left_second)
        --self.lab_count_down_time:set_text(tostring(time))
    end
end

function WorldTreasureBoxUI:gc_sync_world_treasure_box_point_rank()
    self:UpdateUi()
end

function WorldTreasureBoxUI:gc_sync_world_treasure_box_state()
    self:UpdateUi()
end

function WorldTreasureBoxUI:on_btn_change_team()
    local data = {
        teamType = ENUM.ETeamType.world_treasure_box,
        heroMaxNum = 1,
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function WorldTreasureBoxUI:on_btn_enter_system()
    if g_dataCenter.worldTreasureBox:IsOpen() then
        if not g_dataCenter.worldTreasureBox:CheckBattle() then
            HintUI.SetAndShow(EHintUiType.two, 
                "有可助阵角色未助阵，选择助阵角色可大大提升阵容属性！是否确认作战开始？",
                {
                    str = "确定",
                    func = function ()
                        msg_world_treasure_box.cg_enter_world_treasure_box()
                    end
                },
                {
                    str = "取消",
                }
                )
            return;
        end
        msg_world_treasure_box.cg_enter_world_treasure_box()
    else
        FloatTip.Float("活动未开启")
    end
end
function WorldTreasureBoxUI:on_backup()
    uiManager:PushUi(EUI.WorldBossBackupSystemUI,{teamType = ENUM.ETeamType.world_treasure_box})
end
--[[endregion]]
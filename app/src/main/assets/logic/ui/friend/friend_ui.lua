--[[
region friend_ui.lua
date: 2016-7-12
time: 16:34:15
author: Nation
]]
FriendUI = Class('FriendUI', UiBaseClass);
FriendUI.Show_Type_Friend_List = 1
FriendUI.Show_Type_Search_Friend = 2
FriendUI.Show_Type_Friend_Apply = 3
FriendUI.Show_Type_Blacklist = 4
FriendUI.max_get_friend_ap_times = 0

function FriendUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/friend/ui_007_friend.assetbundle";
    self.temp_call_back_func = {}
    self.last_send_search = 0
    UiBaseClass.Init(self, data);
    if FriendUI.max_get_friend_ap_times == 0 then
        local max_get_friend_ap_times = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day)
        if max_get_friend_ap_times then
            FriendUI.max_get_friend_ap_times = max_get_friend_ap_times.data
        end
    end
end

function FriendUI:Clear()
    self.ui_grop = {}
    self.ui_grop[FriendUI.Show_Type_Friend_List] = {}
    self.ui_grop[FriendUI.Show_Type_Search_Friend] = {}
    self.ui_grop[FriendUI.Show_Type_Friend_Apply] = {}
    self.ui_grop[FriendUI.Show_Type_Blacklist] = {}
    self.cur_show_wrap_content = {}
    self.wrap_content_member = {}
    self.wrap_content_member[FriendUI.Show_Type_Friend_List] = {}
    self.wrap_content_member[FriendUI.Show_Type_Search_Friend] = {}
    self.wrap_content_member[FriendUI.Show_Type_Friend_Apply] = {}
    self.wrap_content_member[FriendUI.Show_Type_Blacklist] = {}

    self.input_search_info = nil
    self.is_delete_mode = false
    self.is_system_recommend = false
    self.wait_del_friends = {}
    --self.scroll_view = nil
    --self.wrap_content = nil
    self.ui_toggle_friend_list = nil
    self.ui_toggle_search_friend = nil
    self.ui_toggle_friend_apply = nil
    self.ui_toggle_blacklist = nil
    for k,v in pairs(self.temp_call_back_func) do
        Utility.unbind_callback(self, k);
    end
end

function FriendUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function FriendUI:Restart(data)
    self:Clear()
    self.curShowType = FriendUI.Show_Type_Friend_List
    UiBaseClass.Restart(self, data);
    if not g_dataCenter.friend.is_request_data then
        --msg_friend.cg_request_friend_list()
        --msg_friend.cg_request_friend_apply_list()
        --msg_friend.cg_request_blacklist_list()
        g_dataCenter.friend.is_request_data = true
    end
end

function FriendUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_search"] = Utility.bind_callback(self, self.on_btn_search);
    self.bindfunc["on_btn_del_friend"] = Utility.bind_callback(self, self.on_btn_del_friend);
    self.bindfunc["on_btn_get_all_ap"] = Utility.bind_callback(self, self.on_btn_get_all_ap);
    self.bindfunc["on_btn_give_all_ap"] = Utility.bind_callback(self, self.on_btn_give_all_ap);
    self.bindfunc["on_btn_apply_all"] = Utility.bind_callback(self, self.on_btn_apply_all);
    self.bindfunc["on_btn_update_search_info"] = Utility.bind_callback(self, self.on_btn_update_search_info);
    self.bindfunc["on_btn_remove_all_blacklist"] = Utility.bind_callback(self, self.on_btn_remove_all_blacklist);
    self.bindfunc["on_btn_agree_all_apply"] = Utility.bind_callback(self, self.on_btn_agree_all_apply);
    self.bindfunc["on_btn_refuse_all_apply"] = Utility.bind_callback(self, self.on_btn_refuse_all_apply);
    self.bindfunc["on_toggle_friend_list_change"] = Utility.bind_callback(self, self.on_toggle_friend_list_change);
    self.bindfunc["on_toggle_friend_apply_change"] = Utility.bind_callback(self, self.on_toggle_friend_apply_change);
    self.bindfunc["on_toggle_search_friend_change"] = Utility.bind_callback(self, self.on_toggle_search_friend_change);
    self.bindfunc["on_toggle_blacklist_change"] = Utility.bind_callback(self, self.on_toggle_blacklist_change);
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc["on_btn_send_apply"] = Utility.bind_callback(self, self.on_btn_send_apply);
    self.bindfunc["on_btn_sure_del_friend"] = Utility.bind_callback(self, self.on_btn_sure_del_friend);
    self.bindfunc["on_btn_cancel_del_friend"] = Utility.bind_callback(self, self.on_btn_cancel_del_friend);


    self.bindfunc["gc_sync_friend_list"] = Utility.bind_callback(self, self.gc_sync_friend_list);
    self.bindfunc["gc_sync_search_add_friend_list"] = Utility.bind_callback(self, self.gc_sync_search_add_friend_list);
    self.bindfunc["gc_apply_friend_rst"] = Utility.bind_callback(self, self.gc_apply_friend_rst);
    self.bindfunc["gc_update_friend"] = Utility.bind_callback(self, self.gc_update_friend);
    self.bindfunc["gc_get_friend_ap_rst"] = Utility.bind_callback(self, self.gc_get_friend_ap_rst);
    self.bindfunc["gc_del_friend"] = Utility.bind_callback(self, self.gc_del_friend);
    self.bindfunc["gc_sync_friend_apply_list"] = Utility.bind_callback(self, self.gc_sync_friend_apply_list);
    self.bindfunc["gc_add_friend"] = Utility.bind_callback(self, self.gc_add_friend);
    self.bindfunc['gc_add_friend_apply'] = Utility.bind_callback(self, self.gc_add_friend_apply);
    self.bindfunc['gc_del_friend_apply'] = Utility.bind_callback(self, self.gc_del_friend_apply);
    self.bindfunc['gc_sync_blacklist_list'] = Utility.bind_callback(self, self.gc_sync_blacklist_list); 
    self.bindfunc['gc_add_blacklist'] = Utility.bind_callback(self, self.gc_add_blacklist); 
    self.bindfunc['gc_del_blacklist'] = Utility.bind_callback(self, self.gc_del_blacklist); 
    self.bindfunc['gc_clear_friend_oper_state'] = Utility.bind_callback(self, self.gc_clear_friend_oper_state); 
    self.bindfunc['gc_give_all_friend_ap_rst'] = Utility.bind_callback(self, self.gc_give_all_friend_ap_rst);
    self.bindfunc['gc_update_get_friend_ap_times'] = Utility.bind_callback(self, self.gc_update_get_friend_ap_times);
    self.bindfunc['gc_update_friend_fight_value'] = Utility.bind_callback(self, self.gc_update_friend_fight_value);


    self.bindfunc['PushUi'] = Utility.bind_callback(self, self.PushUi);
end

function FriendUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist("sync_all_friend", self.bindfunc['gc_sync_friend_list']);
    PublicFunc.msg_regist("sync_all_apply", self.bindfunc['gc_sync_friend_apply_list']);
    PublicFunc.msg_regist("sync_all_blacklist", self.bindfunc['gc_sync_blacklist_list']);
    PublicFunc.msg_regist(msg_friend.gc_sync_search_add_friend_list, self.bindfunc['gc_sync_search_add_friend_list']);
    PublicFunc.msg_regist(msg_friend.gc_apply_friend_rst, self.bindfunc['gc_apply_friend_rst']);
    PublicFunc.msg_regist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_regist(msg_friend.gc_get_friend_ap_rst, self.bindfunc['gc_get_friend_ap_rst']);
    PublicFunc.msg_regist(msg_friend.gc_del_friend, self.bindfunc['gc_del_friend']);
    PublicFunc.msg_regist(msg_friend.gc_add_friend, self.bindfunc['gc_add_friend']);
    PublicFunc.msg_regist(msg_friend.gc_add_friend_apply, self.bindfunc['gc_add_friend_apply']);
    PublicFunc.msg_regist(msg_friend.gc_del_friend_apply, self.bindfunc['gc_del_friend_apply']);
    PublicFunc.msg_regist(msg_friend.gc_add_blacklist, self.bindfunc['gc_add_blacklist']);
    PublicFunc.msg_regist(msg_friend.gc_del_blacklist, self.bindfunc['gc_del_blacklist']);
    PublicFunc.msg_regist(msg_friend.gc_clear_friend_oper_state, self.bindfunc['gc_clear_friend_oper_state']);
    PublicFunc.msg_regist(msg_friend.gc_give_all_friend_ap_rst, self.bindfunc['gc_give_all_friend_ap_rst']);
    PublicFunc.msg_regist(msg_friend.gc_update_friend_fight_value, self.bindfunc['gc_update_friend_fight_value']);
    PublicFunc.msg_regist(player.gc_update_get_friend_ap_times, self.bindfunc['gc_update_get_friend_ap_times']);
    PublicFunc.msg_regist(UiManager.PushUi, self.bindfunc['PushUi']);
end

function FriendUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist("sync_all_friend",self.bindfunc['gc_sync_friend_list']);
    PublicFunc.msg_unregist("sync_all_apply", self.bindfunc['gc_sync_friend_apply_list']);
    PublicFunc.msg_unregist("sync_all_blacklist", self.bindfunc['gc_sync_blacklist_list']);
    PublicFunc.msg_unregist(msg_friend.gc_sync_search_add_friend_list, self.bindfunc['gc_sync_search_add_friend_list']);
    PublicFunc.msg_unregist(msg_friend.gc_apply_friend_rst, self.bindfunc['gc_apply_friend_rst']);
    PublicFunc.msg_unregist(msg_friend.gc_update_friend, self.bindfunc['gc_update_friend']);
    PublicFunc.msg_unregist(msg_friend.gc_del_friend, self.bindfunc['gc_del_friend']);
    PublicFunc.msg_unregist(msg_friend.gc_add_friend, self.bindfunc['gc_add_friend']);
    PublicFunc.msg_unregist(msg_friend.gc_add_friend_apply, self.bindfunc['gc_add_friend_apply']);
    PublicFunc.msg_unregist(msg_friend.gc_del_friend_apply, self.bindfunc['gc_del_friend_apply']);
    PublicFunc.msg_unregist(msg_friend.gc_add_blacklist, self.bindfunc['gc_add_blacklist']);
    PublicFunc.msg_unregist(msg_friend.gc_del_blacklist, self.bindfunc['gc_del_blacklist']);
    PublicFunc.msg_unregist(msg_friend.gc_clear_friend_oper_state, self.bindfunc['gc_clear_friend_oper_state']);
    PublicFunc.msg_unregist(msg_friend.gc_give_all_friend_ap_rst, self.bindfunc['gc_give_all_friend_ap_rst']);
    PublicFunc.msg_unregist(player.gc_update_get_friend_ap_times, self.bindfunc['gc_update_get_friend_ap_times']);
    PublicFunc.msg_unregist(UiManager.PushUi, self.bindfunc['PushUi']);
    PublicFunc.msg_unregist(msg_friend.gc_get_friend_ap_rst, self.bindfunc['gc_get_friend_ap_rst']);
    PublicFunc.msg_unregist(msg_friend.gc_update_friend_fight_value, self.bindfunc['gc_update_friend_fight_value']);
end

function FriendUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d())
	self.ui:set_local_scale(1,1,1)
    self.ui:set_local_position(0,0,0)
	self.ui:set_name("friend_ui")
    --好友列表界面---
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_del_friend = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/btn1");
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_del_friend:set_on_click(self.bindfunc["on_btn_del_friend"]);

    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/btn2");
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_on_click(self.bindfunc["on_btn_get_all_ap"]);

    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/btn3");
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_on_click(self.bindfunc["on_btn_give_all_ap"]);

    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/btn5");
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_on_click(self.bindfunc["on_btn_sure_del_friend"]);

    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/btn4");
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_on_click(self.bindfunc["on_btn_cancel_del_friend"]);
    self.ui_grop[FriendUI.Show_Type_Friend_List].spr_sp = ngui.find_sprite(self.ui, "center_other/animation/sp_di/sp_down_di/sp_xin");
    self.ui_grop[FriendUI.Show_Type_Friend_List].lab_sp_last = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_right");
    self.ui_grop[FriendUI.Show_Type_Friend_List].lab_new_sp_last = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/lab_num");
    self.ui_grop[FriendUI.Show_Type_Friend_List].lab_friend_num = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_left");
    self.ui_grop[FriendUI.Show_Type_Friend_List].scroll_view_obj = self.ui:get_child_by_name("center_other/animation/sp_di/sp_down_di/friendlist/scroll_view");
    self.ui_grop[FriendUI.Show_Type_Friend_List].scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/scroll_view/panel_list");
    self.ui_grop[FriendUI.Show_Type_Friend_List].wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/scroll_view/panel_list/wrap_content");
    self.ui_grop[FriendUI.Show_Type_Friend_List].wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    self.ui_grop[FriendUI.Show_Type_Friend_List].lab_ap_can_get = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_down_di/friendlist/lab_keling");
    self.ui_grop[FriendUI.Show_Type_Friend_List].lab_ap_can_get:set_text(gs_string_friend["sp_can_get"])

    --好友添加界面--
    self.ui_grop[FriendUI.Show_Type_Search_Friend].input_search_info = ngui.find_input(self.ui, "center_other/animation/sp_di/sp_top_di/input_account")

    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_search = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_top_di/btn1");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_search:set_on_click(self.bindfunc["on_btn_search"]);
    self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_my_uuid = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/txt");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_apply_all = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/btn1");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_apply_all:set_on_click(self.bindfunc["on_btn_apply_all"]);
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_update_search_info = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/btn2");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_update_search_info:set_on_click(self.bindfunc["on_btn_update_search_info"]);
    self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/btn2/animation/lab");
    
    self.ui_grop[FriendUI.Show_Type_Search_Friend].spr_search = ngui.find_sprite(self.ui, "center_other/animation/sp_di/sp_top_di/sp_find");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_system_recommend = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/lab_find");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].spr_system_recommend = ngui.find_sprite(self.ui, "center_other/animation/sp_di/sp_top_di/sp_sanjiao");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].scroll_view_obj = self.ui:get_child_by_name("center_other/animation/sp_di/sp_down_di/add_friend/scroll_view");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/scroll_view/panel_list");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/sp_di/sp_down_di/add_friend/scroll_view/panel_list/wrap_content");
    self.ui_grop[FriendUI.Show_Type_Search_Friend].wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);

    --黑名单界面--
    self.ui_grop[FriendUI.Show_Type_Blacklist].lab_blacklist_num = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_right");
    self.ui_grop[FriendUI.Show_Type_Blacklist].btn_remove_all_blacklist = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/blacklist/btn1");
    self.ui_grop[FriendUI.Show_Type_Blacklist].btn_remove_all_blacklist:set_on_click(self.bindfunc["on_btn_remove_all_blacklist"]);
    self.ui_grop[FriendUI.Show_Type_Blacklist].lab_friend_num = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_left");
    self.ui_grop[FriendUI.Show_Type_Blacklist].scroll_view_obj = self.ui:get_child_by_name("center_other/animation/sp_di/sp_down_di/blacklist/scroll_view");
    self.ui_grop[FriendUI.Show_Type_Blacklist].scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/sp_down_di/blacklist/scroll_view/panel_list");
    self.ui_grop[FriendUI.Show_Type_Blacklist].wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/sp_di/sp_down_di/blacklist/scroll_view/panel_list/wrap_content");
    self.ui_grop[FriendUI.Show_Type_Blacklist].wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    --好友申请界面--
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].lab_apply_num = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_right");

    self.ui_grop[FriendUI.Show_Type_Friend_Apply].btn_agree_all_apply = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/apply_friend/btn1");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].btn_agree_all_apply:set_on_click(self.bindfunc["on_btn_agree_all_apply"]);

    self.ui_grop[FriendUI.Show_Type_Friend_Apply].btn_refuse_all_apply = ngui.find_button(self.ui, "center_other/animation/sp_di/sp_down_di/apply_friend/btn2");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].btn_refuse_all_apply:set_on_click(self.bindfunc["on_btn_refuse_all_apply"]);

    self.ui_grop[FriendUI.Show_Type_Friend_Apply].lab_friend_num = ngui.find_label(self.ui, "center_other/animation/sp_di/sp_top_di/txt_left");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].scroll_view_obj = self.ui:get_child_by_name("center_other/animation/sp_di/sp_down_di/apply_friend/scroll_view");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/sp_down_di/apply_friend/scroll_view/panel_list");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/sp_di/sp_down_di/apply_friend/scroll_view/panel_list/wrap_content");
    self.ui_grop[FriendUI.Show_Type_Friend_Apply].wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    --公用界面--
    --self.scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/scroll_view/panel_list");
    --self.wrap_content = ngui.find_wrap_content(self.ui, "center_other/animation/sp_di/scroll_view/panel_list/wrap_content");
    --self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    self.spr_no = self.ui:get_child_by_name("center_other/animation/sp_di/content")
    self.lab_no = ngui.find_label(self.ui, "center_other/animation/sp_di/content/sp_qipao/lab");
    self.ui_toggle_friend_list = ngui.find_toggle(self.ui, "center_other/animation/sp_di/cont_yeka/yeka1");
    self.ui_toggle_friend_list:set_on_change(self.bindfunc["on_toggle_friend_list_change"]);
    self.ui_toggle_search_friend = ngui.find_toggle(self.ui, "center_other/animation/sp_di/cont_yeka/yeka2");
    self.ui_toggle_search_friend:set_on_change(self.bindfunc["on_toggle_search_friend_change"]);
    self.ui_toggle_friend_apply = ngui.find_toggle(self.ui, "center_other/animation/sp_di/cont_yeka/yeka3");
    self.ui_toggle_friend_apply:set_on_change(self.bindfunc["on_toggle_friend_apply_change"]);
    self.ui_toggle_blacklist = ngui.find_toggle(self.ui, "center_other/animation/sp_di/cont_yeka/yeka4");
    self.ui_toggle_blacklist:set_on_change(self.bindfunc["on_toggle_blacklist_change"]);
    msg_friend.cg_request_update_friend_fight_value()
    self:OnSetShowType()
    self:UpdateUi()

    --直接打开好友邀请
    local initData = self:GetInitData()
    if initData and initData.invite then
        TimerManager.Add(function () 
            if self.ui_toggle_search_friend then
                self.ui_toggle_search_friend:set_value(true) 
            end
        end, 30)
    end
end

function FriendUI:Update(dt)
    if not UiBaseClass.Update(self, dt) then
        return
    end
    if self.last_send_search and self.last_send_search ~= 0 then
        local pass = PublicFunc.QueryDeltaTime(self.last_send_search)
        if pass < 5000 then
            local left_seconds = (5000-pass)/1000
            left_seconds = math.ceil(left_seconds)
            self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button:set_text(tostring(left_seconds).."s")
        else
            self.last_send_search = 0
            self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_update_search_info:set_enable(true)
            self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button:set_effect_color(151/255, 57/255, 0, 1)
            self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button:set_text("换一批")
        end
    end
    
end

function FriendUI:DestroyUi()
    self:Clear()
    UiBaseClass.DestroyUi(self);
end

function FriendUI:UpdateUIInfo()
    if not self.ui then
        return
    end
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        self.cur_show_wrap_content = {}
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-g_dataCenter.friend:GetFriendCnt()+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        self.ui_grop[self.curShowType].wrap_content:reset();
        self.ui_grop[self.curShowType].scroll_view:reset_position();
        local friend_cnt = g_dataCenter.friend:GetFriendCnt()
        if friend_cnt > 0 then
            self.ui_grop[self.curShowType].btn_del_friend:set_active(true)
            self.ui_grop[self.curShowType].btn_get_all_ap:set_active(true)
            self.ui_grop[self.curShowType].btn_give_all_ap:set_active(true)
        else
            self.ui_grop[self.curShowType].btn_del_friend:set_active(false)
            self.ui_grop[self.curShowType].btn_get_all_ap:set_active(false)
            self.ui_grop[self.curShowType].btn_give_all_ap:set_active(false)
        end
        self.lab_no:set_text(gs_string_friend['no_friend'])
        self.spr_no:set_active(friend_cnt==0)
        self.ui_grop[self.curShowType].lab_friend_num:set_text(string.format(gs_string_friend["friend_num"], friend_cnt))
        --self.ui_grop[self.curShowType].lab_sp_last:set_text(gs_string_friend["sp_can_get"]..g_dataCenter.player:LastCanGetFriendAP())
        self.ui_grop[self.curShowType].lab_sp_last:set_active(false)

        --local max_times = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day).data
        --local ap_value = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_each_time).data
        --local sp_text = tostring(g_dataCenter.player:LastCanGetFriendAP()).."/"..(max_times*ap_value)
        self.ui_grop[self.curShowType].lab_new_sp_last:set_text(tostring(g_dataCenter.player:LastCanGetFriendAP()))
    elseif self.curShowType == FriendUI.Show_Type_Search_Friend then
        self.cur_show_wrap_content = {}
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-g_dataCenter.friend:GetSearchAddFriendCnt()+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        self.ui_grop[self.curShowType].wrap_content:reset();
        self.ui_grop[self.curShowType].scroll_view:reset_position();
        self.ui_grop[self.curShowType].lab_my_uuid:set_text(gs_string_friend["my_uuid"]..g_dataCenter.player.show_playerid)
        self.spr_no:set_active(false)
    elseif self.curShowType == FriendUI.Show_Type_Friend_Apply then
        self.cur_show_wrap_content = {}
        local apply_cnt = g_dataCenter.friend:GetFriendApplyCnt()
        if apply_cnt > 0 then
            self.ui_grop[self.curShowType].btn_agree_all_apply:set_active(true)
            self.ui_grop[self.curShowType].btn_refuse_all_apply:set_active(true)
        else
            self.ui_grop[self.curShowType].btn_agree_all_apply:set_active(false)
            self.ui_grop[self.curShowType].btn_refuse_all_apply:set_active(false)
        end
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-apply_cnt+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        self.ui_grop[self.curShowType].wrap_content:reset();
        self.ui_grop[self.curShowType].scroll_view:reset_position();
        self.lab_no:set_text(gs_string_friend['no_apply'])
        self.spr_no:set_active(apply_cnt==0)
        self.ui_grop[self.curShowType].lab_apply_num:set_text(gs_string_friend["friend_apply_num"]..apply_cnt)
        self.ui_grop[self.curShowType].lab_friend_num:set_text(string.format(gs_string_friend["friend_num"], g_dataCenter.friend:GetFriendCnt()))
    elseif self.curShowType == FriendUI.Show_Type_Blacklist then
        self.cur_show_wrap_content = {}
        local blacklist_cnt = g_dataCenter.friend:GetBlacklistCnt()
        if blacklist_cnt > 0 then
            self.ui_grop[self.curShowType].btn_remove_all_blacklist:set_active(true)
        else
            self.ui_grop[self.curShowType].btn_remove_all_blacklist:set_active(false)
        end
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-blacklist_cnt+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        self.ui_grop[self.curShowType].wrap_content:reset();
        self.ui_grop[self.curShowType].scroll_view:reset_position();
        self.lab_no:set_text(gs_string_friend['no_blacklist'])
        self.spr_no:set_active(blacklist_cnt==0)
        self.ui_grop[self.curShowType].lab_blacklist_num:set_text(gs_string_friend["blacklist_num"]..blacklist_cnt)
        self.ui_grop[self.curShowType].lab_friend_num:set_text(string.format(gs_string_friend["friend_num"], g_dataCenter.friend:GetFriendCnt()))
    end
end

function FriendUI:PushUi()
end
function FriendUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return false;
    end
    return true
end

function FriendUI:on_btn_search()
    local info = self.ui_grop[FriendUI.Show_Type_Search_Friend].input_search_info:get_value()
    if info == "" then
        if PublicFunc.QueryDeltaTime(self.last_send_search) < 5000 then
            FloatTip.Float(gs_string_friend["search_is_cd"])
            return
        end
        self.last_send_search = PublicFunc.QueryCurTime()
    end
    msg_friend.cg_search_add_friend_list(info)
    g_dataCenter.friend:ClearSearchFriendData()
   --self:OnSetShowType()
end

function FriendUI:on_btn_del_friend()
    if self.is_delete_mode or (g_dataCenter.friend:GetFriendCnt()==0) then
        return
    end
    self.is_delete_mode = true
    for k, v in pairs(self.cur_show_wrap_content) do
        local friendData = g_dataCenter.friend:GetFriendDataByIndex(v.index)
        self:UpdateFriendShow(v.ui, friendData)
    end
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_active(false)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_active(false)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_active(true)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_active(true)
    self.wait_del_friends = {}
end

function FriendUI:on_btn_get_all_ap()
    local max_can_get_ap_times = 0
    local max_can_get_ap_times_cfg = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_get_friend_ap_times_each_day)
    if max_can_get_ap_times_cfg then
        max_can_get_ap_times = max_can_get_ap_times_cfg.data
    end
    if g_dataCenter.player.get_friend_ap_times >= max_can_get_ap_times then
        FloatTip.Float(gs_string_friend["get_ap_max_times"])
    else
        local vecPlayerGID = {}
        g_dataCenter.friend:GetAllCanGetAPFriend(vecPlayerGID)
        if #vecPlayerGID == 0 then
            FloatTip.Float(gs_string_friend["all_friend_allready_get_ap"])
        else
            local max_ap = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_max_ap_save).data
            if g_dataCenter.player:GetAP() >= max_ap then
                FloatTip.Float(gs_string_friend["max_ap"])
                return
            end
            msg_friend.cg_get_all_friend_ap()
        end
    end
end

function FriendUI:on_btn_give_all_ap()
    local vecPlayerGID = {}
    g_dataCenter.friend:GetAllCanGiveAPFriend(vecPlayerGID)
    if #vecPlayerGID == 0 then
        FloatTip.Float(gs_string_friend["all_friend_allready_give_ap"])
    else
        msg_friend.cg_give_all_friend_ap()
    end
end

function FriendUI:on_btn_apply_all()
    local vecApply = {}
    g_dataCenter.friend:GetAllSearchAddFriendPlayerGID(vecApply)
    if #vecApply == 0 then
        FloatTip.Float(gs_string_friend["no_player_can_apply"])
        return
    end
    msg_friend.cg_apply_friend(vecApply)
end

function FriendUI:on_btn_update_search_info()
    if PublicFunc.QueryDeltaTime(self.last_send_search) < 5000 then
        FloatTip.Float(gs_string_friend["search_is_cd"])
        return
    end
    self.ui_grop[FriendUI.Show_Type_Search_Friend].btn_update_search_info:set_enable(false)
    self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button:set_effect_color(0.5,0.5,0.5,1)
    self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_search_button:set_text("5s")
    self.last_send_search = PublicFunc.QueryCurTime()
    msg_friend.cg_search_add_friend_list("")

end

function FriendUI:on_btn_remove_all_blacklist()
    local vecBlacklist = {}
    g_dataCenter.friend:GetAllBlacklistPlayerGID(vecBlacklist)
    if #vecBlacklist > 0 then
        msg_friend.cg_del_black_list(vecBlacklist)
    end
end

function FriendUI:on_btn_agree_all_apply()
    local vecPlayerGID = {}
    g_dataCenter.friend:GetAllApplyPlayerGID(vecPlayerGID)
    if #vecPlayerGID > 0 then
        msg_friend.cg_handle_friend_apply(vecPlayerGID, true)
    end
end

function FriendUI:on_btn_refuse_all_apply()
    local vecPlayerGID = {}
    g_dataCenter.friend:GetAllApplyPlayerGID(vecPlayerGID)
    if #vecPlayerGID > 0 then
        msg_friend.cg_handle_friend_apply(vecPlayerGID, false)
    end
end

function FriendUI:OnSetShowType()
    for k, v in pairs(self.ui_grop) do
        for _k, _v in pairs(self.ui_grop[k]) do
            if k ~= self.curShowType then
                _v:set_active(false);
            end
        end
    end
    for k, v in pairs(self.ui_grop) do
        for _k, _v in pairs(self.ui_grop[k]) do
            if k == self.curShowType then
                _v:set_active(true);
            end
        end
    end
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        if self.is_delete_mode then
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_active(false)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_active(false)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_active(true)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_active(true)
        else
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_active(true)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_active(true)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_active(false)
            self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_active(false)
        end
    elseif self.curShowType == FriendUI.Show_Type_Search_Friend then
        if self.is_system_recommend then
            self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_system_recommend:set_active(true)
            --self.ui_grop[FriendUI.Show_Type_Search_Friend].spr_system_recommend:set_active(true)
        else
            self.ui_grop[FriendUI.Show_Type_Search_Friend].lab_system_recommend:set_active(false)
            --self.ui_grop[FriendUI.Show_Type_Search_Friend].spr_system_recommend:set_active(false)
        end
    elseif self.curShowType == FriendUI.Show_Type_Friend_Apply then
    elseif self.curShowType == FriendUI.Show_Type_Blacklist then
    end
    if self.curShowType ~= FriendUI.Show_Type_Friend_List then
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.ui.check_select_del then
                v.ui.check_select_del:set_value(false)
            end
        end
    end
    self:UpdateUIInfo()
end

function FriendUI:on_toggle_friend_list_change()
    if self.ui_toggle_friend_list:get_value() and self.curShowType ~= FriendUI.Show_Type_Friend_List then
        msg_friend.cg_request_update_friend_fight_value()
        self.curShowType = FriendUI.Show_Type_Friend_List
        self.is_delete_mode = false
        self:OnSetShowType()
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
    end
end

function FriendUI:on_toggle_friend_apply_change()
    if self.ui_toggle_friend_apply:get_value() and self.curShowType ~= FriendUI.Show_Type_Friend_Apply then
        g_dataCenter.friend:SetHaveNewApplay(false);
        self.curShowType = FriendUI.Show_Type_Friend_Apply
        self:OnSetShowType()
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
    end
end

function FriendUI:on_toggle_search_friend_change()
    if self.ui_toggle_search_friend:get_value() and self.curShowType ~= FriendUI.Show_Type_Search_Friend then
        self.curShowType = FriendUI.Show_Type_Search_Friend
        if not self.is_system_recommend  then
            msg_friend.cg_search_add_friend_list("")
        end
        self:OnSetShowType()
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
    end
end

function FriendUI:on_toggle_blacklist_change()
    if self.ui_toggle_blacklist:get_value() and self.curShowType ~= FriendUI.Show_Type_Blacklist then
        self.curShowType = FriendUI.Show_Type_Blacklist
        self:OnSetShowType()
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
    end
end

function FriendUI:on_btn_send_apply(params)
    local vecApply = {}
    vecApply[1] = params.string_value
    msg_friend.cg_apply_friend(vecApply)
end

function FriendUI:on_btn_sure_del_friend()
    local cnt = table.get_num(self.wait_del_friends)
    if cnt > 0 then
        local btn1 = {str = gs_string_friend["confirm"], 
            func = function()
                local vecDel = {}
                for k, v in pairs(self.wait_del_friends) do
                    table.insert(vecDel, k)
                end
                msg_friend.cg_del_friend(vecDel)
                self.is_delete_mode = false
                for k, v in pairs(self.cur_show_wrap_content) do
                    if v.ui.check_select_del then
                        v.ui.check_select_del:set_value(false)
                    end
                    local friendData = g_dataCenter.friend:GetFriendDataByIndex(v.index)
                    self:UpdateFriendShow(v.ui, friendData)
                end
                self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_active(true)
                self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_active(true)
                self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_active(false)
                self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_active(false)
                self.wait_del_friends = {}
            end
        };
        local btn2 = {str = gs_string_friend["cancel"]};
        HintUI.SetAndShow(EHintUiType.two, string.format(gs_string_friend["ask_del_friend"], cnt), btn1, btn2)
    else
        HintUI.SetAndShow(EHintUiType.one, string.format(gs_string_friend["need_select_del_friend"]), {str = "确定"})
    end
end

function FriendUI:on_btn_cancel_del_friend()
    self.wait_del_friends = {}
    self.is_delete_mode = false
    for k, v in pairs(self.cur_show_wrap_content) do
        if v.ui.check_select_del then
            v.ui.check_select_del:set_value(false)
        end
        local friendData = g_dataCenter.friend:GetFriendDataByIndex(v.index)
        self:UpdateFriendShow(v.ui, friendData)
    end
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_get_all_ap:set_active(true)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_give_all_ap:set_active(true)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_sure_del_friend:set_active(false)
    self.ui_grop[FriendUI.Show_Type_Friend_List].btn_cancel_del_friend:set_active(false)
end


function FriendUI:on_check_del(check_obj, player_gid)
    if check_obj:get_value() then
        self.wait_del_friends[player_gid] = 1
    else
        self.wait_del_friends[player_gid] = nil
    end
end

function FriendUI:on_give_ap(player_gid)
    local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(player_gid)
    if friend_data and bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.Give) ~= 0 then
        FloatTip.Float(gs_string_friend["friend_allready_give_ap"])
        return
    end
    msg_friend.cg_give_friend_ap(player_gid)
end

function FriendUI:on_get_ap(player_gid)
    local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(player_gid)
    if friend_data then
        if bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.BeGive) == 0 then
            FloatTip.Float(gs_string_friend["friend_no_get_me_ap"])
            return
        elseif bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.Get) ~= 0 then
            FloatTip.Float(gs_string_friend["friend_allready_get_ap"])
            return
        end
    end
    local max_ap = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_max_ap_save).data
    if g_dataCenter.player:GetAP() >= max_ap then
        FloatTip.Float(gs_string_friend["max_ap"])
        return
    end
    if g_dataCenter.player.get_friend_ap_times >= FriendUI.max_get_friend_ap_times then
        FloatTip.Float(gs_string_friend["get_ap_max_times"])
        return
    end
    msg_friend.cg_get_friend_ap(player_gid)
end

function FriendUI:on_friend_info(player_gid)
    uiManager:PushUi(EUI.FriendInfoUI, player_gid);
end

function FriendUI:on_refuse_apply(player_gid)
    local vecPlayerGID = {}
    vecPlayerGID[1] = player_gid
    msg_friend.cg_handle_friend_apply(vecPlayerGID, false)
end

function FriendUI:on_agree_apply(player_gid)
    local vecPlayerGID = {}
    vecPlayerGID[1] = player_gid
    msg_friend.cg_handle_friend_apply(vecPlayerGID, true)
end

function FriendUI:on_del_blacklist(player_gid)
    local vecPlayerGID = {}
    vecPlayerGID[1] = player_gid
    msg_friend.cg_del_black_list(vecPlayerGID)
end

function FriendUI:gc_sync_friend_list()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        self:UpdateUIInfo()
    end
end

function FriendUI:gc_sync_friend_apply_list()
    if self.curShowType == FriendUI.Show_Type_Friend_Apply then
        self:UpdateUIInfo()
    end
end

function FriendUI:gc_sync_blacklist_list()
    if self.curShowType == FriendUI.Show_Type_Blacklist then
        self:UpdateUIInfo()
    end
end

function FriendUI:gc_add_friend()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        local friend_cnt = g_dataCenter.friend:GetFriendCnt()
        self.spr_no:set_active(friend_cnt==0)
        --[[local have = false
        for k, v in pairs(self.cur_show_wrap_content) do
            have = true
            local friendData = g_dataCenter.friend:GetFriendDataByIndex(v.index)
            self:UpdateFriendShow(v.ui, friendData)
        end
        if not have then
            self:OnSetShowType()
        end]]
        self:OnSetShowType()
    elseif self.curShowType == FriendUI.Show_Type_Friend_Apply then
        self:OnSetShowType()
    end
end

function FriendUI:gc_update_friend_fight_value()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        self:OnSetShowType()
    end
end

function FriendUI:gc_add_friend_apply()
    if self.curShowType == FriendUI.Show_Type_Friend_Apply then
        local apply_cnt = g_dataCenter.friend:GetFriendApplyCnt()
        self.spr_no:set_active(apply_cnt==0)
        local have = false
        for k, v in pairs(self.cur_show_wrap_content) do
            have = true
            local applyData = g_dataCenter.friend:GetFriendApplyByIndex(v.index)
            self:UpdateFriendApplyShow(v.ui, applyData)
        end
        g_dataCenter.friend:SetHaveNewApplay(false);
        if not have then
            self:OnSetShowType()
        end
    else
    end
end

function FriendUI:gc_add_blacklist()
    if self.curShowType == FriendUI.Show_Type_Blacklist then
        local blacklist_cnt = g_dataCenter.friend:GetBlacklistCnt()
        self.spr_no:set_active(blacklist_cnt==0)
        local have = false
        for k, v in pairs(self.cur_show_wrap_content) do
            have = true
            local blacklistData = g_dataCenter.friend:GetBlacklistIndex(v.index)
            self:UpdateBlacklistShow(v.ui, blacklistData)
        end
        if not have then
            self:OnSetShowType()
        end
    end
end

function FriendUI:gc_del_blacklist()
    if self.curShowType == FriendUI.Show_Type_Blacklist then
        local blacklist_cnt = g_dataCenter.friend:GetBlacklistCnt();
        self.spr_no:set_active(blacklist_cnt==0)
        self.ui_grop[FriendUI.Show_Type_Blacklist].lab_blacklist_num:set_text(gs_string_friend["blacklist_num"]..blacklist_cnt)
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-blacklist_cnt+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        local max_index = 0
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.index > max_index then
                max_index = v.index
            end
        end
        if max_index > blacklist_cnt then
            self.ui_grop[self.curShowType].wrap_content:reset();
            self.ui_grop[self.curShowType].scroll_view:reset_position();
        else
            for k, v in pairs(self.cur_show_wrap_content) do
                local blacklistData = g_dataCenter.friend:GetBlacklistIndex(v.index)
                self:UpdateBlacklistShow(v.ui, blacklistData)
            end
        end
    end
end



function FriendUI:gc_sync_search_add_friend_list(type)
    self.is_system_recommend = (type == 0)
    if self.curShowType == FriendUI.Show_Type_Search_Friend then
        self:OnSetShowType()
    end
end

function FriendUI:gc_apply_friend_rst()
    if self.curShowType == FriendUI.Show_Type_Search_Friend then
        for k, v in pairs(self.cur_show_wrap_content) do
            local searchData = g_dataCenter.friend:GetSearchAddFriendByPlayerGID(k)
            if searchData then
                if searchData.is_send then
                    v.ui.spr_allready_apply_or_give:set_active(true)
                    v.ui.spr_allready_apply_or_give:set_sprite_name("hy_yishengqing")
                    if v.ui.btn_send_apply then
                        v.ui.btn_send_apply:set_active(false)
                    end
                end
            end
        end
    end
end


function FriendUI:UpdateFriendShow(wrap_content, friend_data)
    if wrap_content.friend_list_content then
        wrap_content.friend_list_content:set_active(true)
    end
    if wrap_content.search_friend_content then
        wrap_content.search_friend_content:set_active(false)
    end
    if wrap_content.blacklist_content then
        wrap_content.blacklist_content:set_active(false)
    end
    if wrap_content.apply_friend_content then
        wrap_content.apply_friend_content:set_active(false)
    end
    if wrap_content.btn_send_apply then
        wrap_content.btn_send_apply:set_active(false)
    end
    if friend_data then
        if wrap_content.obj_select_del then
            wrap_content.obj_select_del:set_active(self.is_delete_mode)
        end
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.ui == wrap_content then
                self.cur_show_wrap_content[k] = nil
                break
            end
        end
        if wrap_content.lab_guild then
            if friend_data.guild_name and friend_data.guild_name ~= "" then
                wrap_content.lab_guild:set_text("社团："..friend_data.guild_name)
            else
                wrap_content.lab_guild:set_text("")
            end
        end
        if friend_data.online then
            wrap_content.lab_zaixian:set_text("[5AFF00]在线[-]")
            --wrap_content.spr_di:set_color(1, 1, 1, 1)
            wrap_content.head_info:SetGray(false)
        else
            local offline_time = friend_data.offline_seconds or 0
            offline_time = offline_time + math.floor(PublicFunc.QueryDeltaTime(friend_data.update_time)*0.001)
            local info = ""
            if offline_time >= 86400 then
                info = math.floor(offline_time/86400).."天"
            elseif offline_time >= 3600 then
                info = math.floor(offline_time/3600).."小时"
            elseif offline_time >= 60 then
                info = math.floor(offline_time/60).."分钟"
            else
                info = offline_time.."秒"
            end
            wrap_content.lab_zaixian:set_text("[C6C6C6]离线"..info.."[-]")
            --wrap_content.spr_di:set_color(0, 0, 0, 1)
            wrap_content.head_info:SetGray(true)
        end
        self.cur_show_wrap_content[friend_data.friend_gid] = {ui=wrap_content, index=g_dataCenter.friend:GetFriendIndex(friend_data.friend_gid)}
        wrap_content.head_info:SetRoleId(friend_data.image)
        wrap_content.head_info:SetVipLevel(friend_data.vip_level)
        wrap_content.lab_name:set_text(friend_data.name)
        wrap_content.lab_level:set_text("[FCD901]" .. friend_data.level.."[-][A2A2E2]级[-]")
        wrap_content.lab_fight_value:set_text(tostring(friend_data.fight_value))
        if self.is_delete_mode then
            if wrap_content.check_select_del then
                local check_func = Utility.create_callback_ex(self.on_check_del, false, 0, self, wrap_content.check_select_del, friend_data.friend_gid)
                self.temp_call_back_func[check_func] = 1
                wrap_content.check_select_del:set_on_change(check_func);
                if self.wait_del_friends[friend_data.friend_gid] then
                    wrap_content.check_select_del:set_value(true)
                else
                    wrap_content.check_select_del:set_value(false)
                end
            end
            if wrap_content.btn_give then
                wrap_content.btn_give:set_active(false)
            end
            wrap_content.spr_allready_apply_or_give:set_active(false)
            if wrap_content.btn_get then
                wrap_content.btn_get:set_active(false)
            end
            if wrap_content.btn_friend_info then
                wrap_content.btn_friend_info:set_enable(false)
            end
        else
            local isGive = (bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.Give) ~= 0)
            if wrap_content.btn_give then
                wrap_content.btn_give:set_active(not isGive)
            end
            if not isGive then
                if wrap_content.btn_give then
                    local click_func = Utility.create_callback_ex(self.on_give_ap, false, 0, self, friend_data.friend_gid)
                    self.temp_call_back_func[click_func] = 1
                    wrap_content.btn_give:set_on_ngui_click(click_func)
                end
            end
            wrap_content.spr_allready_apply_or_give:set_sprite_name("hy_yizengsong")
            wrap_content.spr_allready_apply_or_give:set_active(isGive)
            local canGet = (g_dataCenter.player.get_friend_ap_times < FriendUI.max_get_friend_ap_times)
            if canGet then
                canGet = ((bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.BeGive) ~= 0) and (bit.bit_and(friend_data.oper_state, ENUM.FriendOperState.Get) == 0))
            end
            if wrap_content.btn_get then
                wrap_content.btn_get:set_active(canGet)
            end
            if canGet then
                local click_func = Utility.create_callback_ex(self.on_get_ap, false, 0, self, friend_data.friend_gid)
                self.temp_call_back_func[click_func] = 1
                if wrap_content.btn_get then
                    wrap_content.btn_get:set_on_ngui_click(click_func)
                end
            end
            if wrap_content.btn_friend_info then
                wrap_content.btn_friend_info:set_enable(true)
                local click_func = Utility.create_callback_ex(self.on_friend_info, false, 0, self, friend_data.friend_gid)
                self.temp_call_back_func[click_func] = 1
                wrap_content.btn_friend_info:set_on_ngui_click(click_func)
            end
            
        end
    else
        --[[for k, v in pairs(wrap_content) do
            if v.set_active then
                v:set_active(false)
            end
        end]]
    end
end

function FriendUI:UpdateFriendSearchShow(wrap_content, search_data)
    if wrap_content.friend_list_content then
        wrap_content.friend_list_content:set_active(false)
    end
    if wrap_content.search_friend_content then
        wrap_content.search_friend_content:set_active(true)
    end
    if wrap_content.blacklist_content then
        wrap_content.blacklist_content:set_active(false)
    end
    if wrap_content.apply_friend_content then
        wrap_content.apply_friend_content:set_active(false)
    end
    wrap_content.spr_allready_apply_or_give:set_active(false)
    if wrap_content.btn_friend_info then
        wrap_content.btn_friend_info:set_enable(false)
    end
    --wrap_content.spr_di:set_color(1, 1, 1, 1)
    if search_data then
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.ui == wrap_content then
                self.cur_show_wrap_content[k] = nil
                break
            end
        end
        self.cur_show_wrap_content[search_data.player_gid] = {ui=wrap_content, index=g_dataCenter.friend:GetFriendApplyIndex(search_data.player_gid)}
        wrap_content.head_info:SetRoleId(search_data.image)
        wrap_content.head_info:SetVipLevel(search_data.vip_level)
        wrap_content.lab_name:set_text(search_data.name)
        wrap_content.lab_level:set_text("[FCD901]" .. search_data.level.."[-][A2A2E2]级[-]")
        wrap_content.lab_fight_value:set_text(tostring(search_data.fight_value))
        if search_data.is_send then
            wrap_content.spr_allready_apply_or_give:set_sprite_name("hy_yishengqing")
            wrap_content.spr_allready_apply_or_give:set_active(true)
            if wrap_content.btn_send_apply then
                wrap_content.btn_send_apply:set_active(false)
            end
        else
            wrap_content.spr_allready_apply_or_give:set_active(false)
            if wrap_content.btn_send_apply then
                wrap_content.btn_send_apply:set_active(true)
                wrap_content.btn_send_apply:set_event_value(search_data.player_gid, 0);
            end
        end
    else
        --[[for k, v in pairs(wrap_content) do
            if v.set_active then
                v:set_active(false)
            end
        end]]
    end
end

function FriendUI:UpdateFriendApplyShow(wrap_content, apply_data)
    if wrap_content.friend_list_content then
        wrap_content.friend_list_content:set_active(false)
    end
    if wrap_content.search_friend_content then
        wrap_content.search_friend_content:set_active(false)
    end
    if wrap_content.blacklist_content then
        wrap_content.blacklist_content:set_active(false)
    end
    if wrap_content.apply_friend_content then
        wrap_content.apply_friend_content:set_active(true)
    end
    if wrap_content.spr_allready_apply_or_give then
        wrap_content.spr_allready_apply_or_give:set_active(false)
    end
    if wrap_content.btn_send_apply then
        wrap_content.btn_send_apply:set_active(false)
    end
    if wrap_content.obj_select_del then
        wrap_content.obj_select_del:set_active(false)
    end
    if wrap_content.btn_get then
        wrap_content.btn_get:set_active(false)
    end
    if wrap_content.btn_give then
        wrap_content.btn_give:set_active(false)
    end
    if wrap_content.btn_friend_info then
        wrap_content.btn_friend_info:set_enable(false)
    end
    --wrap_content.spr_di:set_color(1, 1, 1, 1)
    if apply_data then
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.ui == wrap_content then
                self.cur_show_wrap_content[k] = nil
                break
            end
        end
        self.cur_show_wrap_content[apply_data.player_gid] = {ui=wrap_content, index=g_dataCenter.friend:GetFriendApplyIndex(apply_data.player_gid)}
        wrap_content.head_info:SetRoleId(apply_data.image)
        wrap_content.head_info:SetVipLevel(apply_data.vip_level)
        wrap_content.lab_name:set_text(apply_data.name)
        wrap_content.lab_level:set_text("[FCD901]" .. apply_data.level.."[-][A2A2E2]级[-]")
        wrap_content.lab_fight_value:set_text(tostring(apply_data.fight_value))
        if wrap_content.btn_refuse then
            local click_func = Utility.create_callback_ex(self.on_refuse_apply, false, 0, self, apply_data.player_gid)
            self.temp_call_back_func[click_func] = 1
            wrap_content.btn_refuse:set_on_ngui_click(click_func)
        end
        if wrap_content.btn_agree then
            click_func = Utility.create_callback_ex(self.on_agree_apply, false, 0, self, apply_data.player_gid)
            self.temp_call_back_func[click_func] = 1
            wrap_content.btn_agree:set_on_ngui_click(click_func)
        end
    else
        --[[for k, v in pairs(wrap_content) do
            if v.set_active then
                v:set_active(false)
            end
        end]]
    end
end

function FriendUI:UpdateBlacklistShow(wrap_content, blacklist_data)
    if wrap_content.friend_list_content then
        wrap_content.friend_list_content:set_active(false)
    end
    if wrap_content.search_friend_content then
        wrap_content.search_friend_content:set_active(false)
    end
    if wrap_content.blacklist_content then
        wrap_content.blacklist_content:set_active(true)
    end
    if wrap_content.apply_friend_content then
        wrap_content.apply_friend_content:set_active(false)
    end
    if wrap_content.spr_allready_apply_or_give then
        wrap_content.spr_allready_apply_or_give:set_active(false)
    end
    if wrap_content.btn_send_apply then
        wrap_content.btn_send_apply:set_active(false)
    end
    if wrap_content.obj_select_del then
        wrap_content.obj_select_del:set_active(false)
    end
    if wrap_content.btn_get then
        wrap_content.btn_get:set_active(false)
    end
    if wrap_content.btn_give then
        wrap_content.btn_give:set_active(false)
    end
    if wrap_content.btn_friend_info then
        wrap_content.btn_friend_info:set_enable(false)
    end
    --wrap_content.spr_di:set_color(1, 1, 1, 1)
    if blacklist_data then
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.ui == wrap_content then
                self.cur_show_wrap_content[k] = nil
                break
            end
        end
        self.cur_show_wrap_content[blacklist_data.player_gid] = {ui=wrap_content, index=g_dataCenter.friend:GetBlacklistIndex(blacklist_data.player_gid)}
        wrap_content.head_info:SetRoleId(blacklist_data.image)
        wrap_content.head_info:SetVipLevel(blacklist_data.vip_level)
        wrap_content.lab_name:set_text(blacklist_data.name)
        wrap_content.lab_level:set_text("[FCD901]" .. blacklist_data.level.."[-][A2A2E2]级[-]")
        wrap_content.lab_fight_value:set_text(tostring(blacklist_data.fight_value))
        if wrap_content.btn_del_blacklist then
            local click_func = Utility.create_callback_ex(self.on_del_blacklist, false, 0, self, blacklist_data.player_gid)
            self.temp_call_back_func[click_func] = 1
            wrap_content.btn_del_blacklist:set_on_ngui_click(click_func)
        end
    else
        --[[for k, v in pairs(wrap_content) do
            if v.set_active then
                v:set_active(false)
            end
        end]]
    end
end


function FriendUI:gc_update_friend()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        for k, v in pairs(self.cur_show_wrap_content) do
            local friendData = g_dataCenter.friend:GetFriendDataByPlayerGID(k)
            self:UpdateFriendShow(v.ui, friendData)
        end
    end
end

function FriendUI:gc_give_all_friend_ap_rst()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        for k, v in pairs(self.cur_show_wrap_content) do
            local friendData = g_dataCenter.friend:GetFriendDataByPlayerGID(k)
            self:UpdateFriendShow(v.ui, friendData)
        end
    end
end

function FriendUI:gc_update_get_friend_ap_times()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        self.ui_grop[self.curShowType].lab_new_sp_last:set_text(tostring(g_dataCenter.player:LastCanGetFriendAP()))
    end
end

function FriendUI:gc_get_friend_ap_rst()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        self.ui_grop[self.curShowType].lab_new_sp_last:set_text(tostring(g_dataCenter.player:LastCanGetFriendAP()))
    end
end

function FriendUI:gc_clear_friend_oper_state()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        for k, v in pairs(self.cur_show_wrap_content) do
            local friendData = g_dataCenter.friend:GetFriendDataByPlayerGID(k)
            self:UpdateFriendShow(v.ui, friendData)
        end
    end
end

function FriendUI:gc_del_friend()
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        local friend_cnt = g_dataCenter.friend:GetFriendCnt()
        self.spr_no:set_active(friend_cnt==0)
        self.ui_grop[self.curShowType].lab_friend_num:set_text(string.format(gs_string_friend["friend_num"], g_dataCenter.friend:GetFriendCnt()))
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-friend_cnt+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        local max_index = 0
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.index > max_index then
                max_index = v.index
            end
        end
        if max_index > friend_cnt then
            self.ui_grop[self.curShowType].wrap_content:reset();
            self.ui_grop[self.curShowType].scroll_view:reset_position();
        else
            for k, v in pairs(self.cur_show_wrap_content) do
                local friendData = g_dataCenter.friend:GetFriendDataByIndex(v.index)
                self:UpdateFriendShow(v.ui, friendData)
            end
        end
    end
end

function FriendUI:gc_del_friend_apply()
    if self.curShowType == FriendUI.Show_Type_Friend_Apply then
        local apply_cnt = g_dataCenter.friend:GetFriendApplyCnt()
        self.spr_no:set_active(apply_cnt==0)
        self.ui_grop[FriendUI.Show_Type_Friend_Apply].lab_apply_num:set_text(gs_string_friend["friend_apply_num"]..apply_cnt)
        self.ui_grop[self.curShowType].wrap_content:set_min_index(-apply_cnt+1);
        self.ui_grop[self.curShowType].wrap_content:set_max_index(0);
        local max_index = 0
        for k, v in pairs(self.cur_show_wrap_content) do
            if v.index > max_index then
                max_index = v.index
            end
        end
        if max_index > apply_cnt then
            self.ui_grop[self.curShowType].wrap_content:reset();
            self.ui_grop[self.curShowType].scroll_view:reset_position();
        else
            for k, v in pairs(self.cur_show_wrap_content) do
                local applyData = g_dataCenter.friend:GetFriendApplyByIndex(v.index)
                self:UpdateFriendApplyShow(v.ui, applyData)
            end
        end
    end
end


function FriendUI:init_item_wrap_content(obj, b, real_id)
    real_id = math.abs(real_id)+1
    local index = ""..b
    if not self.wrap_content_member[self.curShowType][index] then
        obj:set_name(index)
        self.wrap_content_member[self.curShowType][index] = {}
        self.wrap_content_member[self.curShowType][index].lab_name = ngui.find_label(obj, "lab_name");
        self.wrap_content_member[self.curShowType][index].lab_level = ngui.find_label(obj, "lab_level");
        self.wrap_content_member[self.curShowType][index].lab_fight_value = ngui.find_label(obj, "sp_fight/lab_fight");
        self.wrap_content_member[self.curShowType][index].spr_allready_apply_or_give = ngui.find_sprite(obj, "sp_art_font");
        local sp_head_di_item = obj:get_child_by_name("sp_head_di_item");
        self.wrap_content_member[self.curShowType][index].head_info = UiPlayerHead:new({parent=sp_head_di_item})

        self.wrap_content_member[self.curShowType][index].lab_zaixian = ngui.find_label(obj, "lab_zaixian");
        self.wrap_content_member[self.curShowType][index].lab_guild = ngui.find_label(obj, "lab_shetuan");
        self.wrap_content_member[self.curShowType][index].btn_send_apply = ngui.find_button(obj, "add_friend/btn");
        if self.wrap_content_member[self.curShowType][index].btn_send_apply then
            self.wrap_content_member[self.curShowType][index].btn_send_apply:set_on_click(self.bindfunc["on_btn_send_apply"]);
        end
        --self.wrap_content_member[self.curShowType][index].spr_di = ngui.find_sprite(obj, "sp_di");
        --self.wrap_content_member[self.curShowType][index].lab_vip = ngui.find_label(obj, "lab_vip");
        
        self.wrap_content_member[self.curShowType][index].friend_list_content = obj:get_child_by_name("friendlist")
        self.wrap_content_member[self.curShowType][index].search_friend_content = obj:get_child_by_name("add_friend")
        self.wrap_content_member[self.curShowType][index].blacklist_content = obj:get_child_by_name("blacklist")
        self.wrap_content_member[self.curShowType][index].apply_friend_content = obj:get_child_by_name("apply_friend")
        self.wrap_content_member[self.curShowType][index].obj_select_del = obj:get_child_by_name("friendlist/cont1")
        self.wrap_content_member[self.curShowType][index].check_select_del = ngui.find_toggle(obj, "friendlist/cont1/sp_frame");
        self.wrap_content_member[self.curShowType][index].btn_get = ngui.find_button(obj, "friendlist/cont2/btn1");
        self.wrap_content_member[self.curShowType][index].btn_give = ngui.find_button(obj, "friendlist/cont2/btn2");
        self.wrap_content_member[self.curShowType][index].btn_refuse = ngui.find_button(obj, "apply_friend/btn1");
        self.wrap_content_member[self.curShowType][index].btn_agree = ngui.find_button(obj, "apply_friend/btn2");
        self.wrap_content_member[self.curShowType][index].btn_del_blacklist = ngui.find_button(obj, "blacklist/btn1");
        self.wrap_content_member[self.curShowType][index].btn_friend_info = ngui.find_button(obj, obj:get_name());
        
    end
    if self.curShowType == FriendUI.Show_Type_Friend_List then
        local friendData = g_dataCenter.friend:GetFriendDataByIndex(real_id)
        self:UpdateFriendShow(self.wrap_content_member[self.curShowType][index], friendData)
    elseif self.curShowType == FriendUI.Show_Type_Search_Friend then
        local searchData = g_dataCenter.friend:GetSearchAddFriendByIndex(real_id)
        self:UpdateFriendSearchShow(self.wrap_content_member[self.curShowType][index], searchData)
    elseif self.curShowType == FriendUI.Show_Type_Friend_Apply then
        local applyData = g_dataCenter.friend:GetFriendApplyByIndex(real_id)
        self:UpdateFriendApplyShow(self.wrap_content_member[self.curShowType][index], applyData)
    elseif self.curShowType == FriendUI.Show_Type_Blacklist then
        local blacklistData = g_dataCenter.friend:GetBlacklistByIndex(real_id)
        self:UpdateBlacklistShow(self.wrap_content_member[self.curShowType][index], blacklistData)
    end
end

--[[endregion]]
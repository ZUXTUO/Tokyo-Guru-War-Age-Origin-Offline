--日常任务ui
UiDevelopGuide = Class('UiDevelopGuide',UiBaseClass);
--------------------------------------------------

--初始化
function UiDevelopGuide:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/develop_guide/ui_3001_strong.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function UiDevelopGuide:InitData(data)
    UiBaseClass.InitData(self, data);
    self.tag_index = 1;
    self.sp_not_chose = {};
    self.sp_chose = {};
    --self.sp_arrow = {};
end

--重新开始
function UiDevelopGuide:Restart(data)
    UiBaseClass.Restart(self, data);
end

--析构函数
function UiDevelopGuide:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function UiDevelopGuide:Show()
    UiBaseClass.Show(self);
end

--注册回调函数
function UiDevelopGuide:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['init_item_wrap_content_left'] = Utility.bind_callback(self, self.init_item_wrap_content_left);
    self.bindfunc['init_item_wrap_content_right'] = Utility.bind_callback(self, self.init_item_wrap_content_right);
    self.bindfunc['on_btn_goto'] = Utility.bind_callback(self, self.on_btn_goto);
    self.bindfunc['on_btn_tag'] = Utility.bind_callback(self, self.on_btn_tag);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close);
end

--注册消息分发回调函数
function UiDevelopGuide:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiDevelopGuide:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--初始化UI
function UiDevelopGuide:LoadUI()
    UiBaseClass.LoadUI(self);
end

--寻找ngui对象
function UiDevelopGuide:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ui_3001_strong');
    --do return end

    self.scroll_view_left = ngui.find_scroll_view(self.ui, 'center_other/animation/panel_left_yeka');
    self.wrap_content_left = ngui.find_wrap_content(self.ui, 'center_other/animation/panel_left_yeka/warp_content');
    self.wrap_content_left:set_on_initialize_item(self.bindfunc['init_item_wrap_content_left']);

    self.scroll_view_right = ngui.find_scroll_view(self.ui, 'center_other/animation/cont_right/right_panel_list');
    self.wrap_content_right = ngui.find_wrap_content(self.ui, 'center_other/animation/cont_right/right_panel_list/wrap_content');
    self.wrap_content_right:set_on_initialize_item(self.bindfunc['init_item_wrap_content_right']);

    self.lab_fight_value = ngui.find_label(self.ui, "center_other/animation/cont_top/lab_fight");
    self.lab_level = ngui.find_label(self.ui, "center_other/animation/cont_top/txt_fight1");
    self.lab_recom_fight_value = ngui.find_label(self.ui, "center_other/animation/cont_top/lab_fight1");

    self.btn_mark = ngui.find_button(self.ui, "sp_mark");
    self.btn_mark:set_on_click(self.bindfunc['on_btn_close']);

    self.btn_close = ngui.find_button(self.ui, "center_other/animation/btn_fork");
    self.btn_close:set_on_click(self.bindfunc['on_btn_close']);

    -- self.btn_arrow_left = ngui.find_button(self.ui, "center_other/animation/panel/btn_down_arrows");
    -- self.btn_arrow_left:set_active(false);
    -- self.btn_arrow_right = ngui.find_button(self.ui, "center_other/animation/panel/btn_down_arrows2");
    -- self.btn_arrow_right:set_active(false);

	self:UpdateUi();
end

--刷新界面
function UiDevelopGuide:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end

    SystemEnterFunc.SetClearStack(false)
    local vip = 0;
    local level = g_dataCenter.player.level;
    local my_fight_value = g_dataCenter.player:GetFightValue();
    local recommend_fight_value = ConfigManager.Get(EConfigIndex.t_recommend_fight_value,level).fight_value;

    self.lab_fight_value:set_text(tostring(my_fight_value));
    self.lab_level:set_text("Lv"..tostring(level).."推荐战斗力:");
    self.lab_recom_fight_value:set_text(tostring(recommend_fight_value));
    self.lab_level:set_active(false);
    self.lab_recom_fight_value:set_active(false);


    local cnt_left = 0;
    cnt_left = ConfigManager.GetDataCount(EConfigIndex.t_develop_guide_ui_list);
    
    self.wrap_content_left:set_min_index(-cnt_left+1);
    self.wrap_content_left:set_max_index(0);
    self.wrap_content_left:reset();
    self.scroll_view_left:reset_position();

    self:UpdateRight();

    
end

function UiDevelopGuide:UpdateRight()
--     self.show_list = {};

--     local vip = 0;
--     local level = g_dataCenter.player.level;

--     local right_list = ConfigManager.Get(EConfigIndex.t_develop_guide_ui_list,self.tag_index);
--     if not right_list then return end

--     local cnt_right = 0;

--     for k,v in pairs(right_list) do
--         local system_id = v.system_id;
--         local open_vip_level = ConfigManager.Get(EConfigIndex.t_develop_guide_data,system_id).open_vip_level;
--         local open_level = ConfigManager.Get(EConfigIndex.t_develop_guide_data,system_id).open_level;
--         if level >= open_level and vip >= open_vip_level then
--             cnt_right = cnt_right + 1;
--             self.show_list[cnt_right] = v;
--         end
--     end
--     self.wrap_content_right:set_min_index(-cnt_right+1);
--     self.wrap_content_right:set_max_index(0);
--     self.wrap_content_right:reset();
--     self.scroll_view_right:reset_position();
end

function UiDevelopGuide:init_item_wrap_content_left(obj,b,real_id)
    local index = math.abs(real_id) + 1;

    local btn = ngui.find_button(obj, obj:get_name());
    self.sp_not_chose[index] = ngui.find_sprite(obj, obj:get_name().."/sp");
    self.sp_chose[index] = ngui.find_sprite(obj, obj:get_name().."/sp_di");
    --local sp_point = ngui.find_sprite(obj, "sp_point");
    local lab = ngui.find_label(obj, obj:get_name().."/lab");
    --self.sp_arrow[index] = ngui.find_sprite(obj, "sp_arrows");

    if self.tag_index == index then
        --self.sp_not_chose[index]:set_active(false);
        self.sp_chose[index]:set_active(true);
        --self.sp_arrow[index]:set_active(true);
    else
        --self.sp_not_chose[index]:set_active(true);
        self.sp_chose[index]:set_active(false);
        --self.sp_arrow[index]:set_active(false);
    end
    --sp_point:set_active(false);
    local right_list = ConfigManager.Get(EConfigIndex.t_develop_guide_ui_list,index);
    
    lab:set_text(tostring(gs_string_develop_guide[right_list[1].name]));
    btn:reset_on_click();
    btn:set_event_value("", index);
    btn:set_on_click(self.bindfunc["on_btn_tag"]);
    
end

function UiDevelopGuide:init_item_wrap_content_right(obj,b,real_id)
    local index = math.abs(real_id) + 1;

    local lab_name = ngui.find_label(obj, "lab");
    local lab_describe = ngui.find_label(obj, "lab2");
    local btn = ngui.find_button(obj, "btn");

    local right_list = self.show_list;
    if not right_list[index] then return end;
    lab_name:set_text(tostring(gs_string_develop_guide[right_list[index].system_name]));
    lab_describe:set_text(tostring(gs_string_develop_guide[right_list[index].system_describe]));

    local system_id = right_list[index].system_id;

    btn:reset_on_click();
    btn:set_event_value("", system_id);
    btn:set_on_click(self.bindfunc["on_btn_goto"]);
end

function UiDevelopGuide:on_btn_goto(t)
    local index = t.float_value;
    --self:Hide();
    uiManager:PopUi();
end

function UiDevelopGuide:on_btn_close()
    --self:Hide();
    uiManager:PopUi();
end

function UiDevelopGuide:on_btn_tag(t)
    local index = t.float_value;
    if index == self.tag_index then return end;
    --self.sp_arrow[self.tag_index]:set_active(false);
    --self.sp_not_chose[self.tag_index]:set_active(true);
    self.sp_chose[self.tag_index]:set_active(false);

    self.tag_index = index;
    --self.sp_arrow[self.tag_index]:set_active(true);
    --self.sp_not_chose[self.tag_index]:set_active(false);
    self.sp_chose[self.tag_index]:set_active(true);
    self:UpdateRight();
end


function UiDevelopGuide:ShowNavigationBar()
    return false
end
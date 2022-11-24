MainUI = Class('MainUI', UiBaseClass);
local last_x = 0;
local last_y = 0;
local last_angle = 0
local max_dis_check = 300;
local max_dis = 70;
-- 圆底的半径
local di_radio = 116;

local right_top_ani = 
{
    [true] = "right_other_1",
    [false] = "right_other_2",
}

local right_down_ani = 
{
    [true] = "right_down_other_1",
    [false] = "right_down_other_2",
}

local right_down_spname = 
{
    [true] = "zhujiemian_anniu3",
    [false] = "zhujiemian_anniu2",
}


local _local = { }
_local.UIText = {
    [1] = "级开启",-- XX级开启
}

function MainUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/main/xin_main.assetbundle";
	UiBaseClass.Init(self, data);
end

function MainUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
        Root.get_root_ui_2d_fight():set_active(true);
	end
    if CameraManager.GetSceneCameraObj() then
        CameraManager.GetSceneCameraObj():set_active(true);
    end
    UiBaseClass.showSceneCamera = true;
end

function MainUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.scard = {};
    self.roleData = {};
    self.show_right_top = true;
    self.show_right_down = false;
    self.old_hero_id = g_dataCenter.player:GetDefTeam()[1];
end

function MainUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    Root.get_root_ui_2d_fight():set_active(false);
    for k,v in pairs(self.scard) do
        self.scard[k]:DestroyUi();
        self.scard[k] = nil;
    end
    UiBaseClass.showSceneCamera = false;
    self:DestroyWorldChat();
    RecommendMgr.Inst():Stop()
end

function MainUI:Show()
    if UiBaseClass.Show(self) then
        --[[if self.old_hero_id ~= g_dataCenter.player:GetDefTeam()[1] then
            self.old_hero_id = g_dataCenter.player:GetDefTeam()[1];
            mainCityScene:ChangeCaptain();
        end]]
        Root.get_root_ui_2d_fight():set_active(true);
        self:UpdateUi();
	end
    UiBaseClass.showSceneCamera = true;
    if CameraManager.GetSceneCameraObj() then
        CameraManager.GetSceneCameraObj():set_active(UiBaseClass.showSceneCamera);
    end

    RecommendMgr.Inst():Start()
end

function MainUI:Hide()
    if UiBaseClass.Hide(self) then
        Root.get_root_ui_2d_fight():set_active(false);
	end
    UiBaseClass.showSceneCamera = false;
    self:HideWorldChat();

    RecommendMgr.Inst():Stop()
end

function MainUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    --左上
    self.bindfunc["on_sign"] = Utility.bind_callback(self, self.on_sign)
    self.bindfunc["on_task"] = Utility.bind_callback(self, self.on_task)
    self.bindfunc["on_activity"] = Utility.bind_callback(self, self.on_activity)
    self.bindfunc["on_service"] = Utility.bind_callback(self, self.on_service)
    --左中
    self.bindfunc["on_card_human"] = Utility.bind_callback(self, self.on_card_human)
    --左下
    self.bindfunc["on_touch_begin"] = Utility.bind_callback(self, self.on_touch_begin)
    self.bindfunc["on_touch_move"] = Utility.bind_callback(self, self.on_touch_move)
    --右上
    self.bindfunc["on_right_top"] = Utility.bind_callback(self, self.on_right_top)
    self.bindfunc["on_drama"] = Utility.bind_callback(self, self.on_drama)
    self.bindfunc["on_play_method"] = Utility.bind_callback(self, self.on_play_method)
    self.bindfunc["on_vs"] = Utility.bind_callback(self, self.on_vs)
    self.bindfunc["on_organization"] = Utility.bind_callback(self, self.on_organization)
    self.bindfunc["on_egg"] = Utility.bind_callback(self, self.on_egg)
    --右下
    self.bindfunc["on_right_down"] = Utility.bind_callback(self, self.on_right_down)
    self.bindfunc["on_role"] = Utility.bind_callback(self, self.on_role)
    self.bindfunc["on_equipment"] = Utility.bind_callback(self, self.on_equipment)
    self.bindfunc["on_friend"] = Utility.bind_callback(self, self.on_friend)
    self.bindfunc["on_mail"] = Utility.bind_callback(self, self.on_mail)
    self.bindfunc["on_compound"] = Utility.bind_callback(self, self.on_compound)
    self.bindfunc["on_set"] = Utility.bind_callback(self, self.on_set)
    self.bindfunc["on_sell"] = Utility.bind_callback(self, self.on_sell)
    self.bindfunc["on_rank_list"] = Utility.bind_callback(self, self.on_rank_list)
    self.bindfunc["on_strong"] = Utility.bind_callback(self, self.on_strong)
    --中
    self.bindfunc["on_touch_screen"] = Utility.bind_callback(self, self.on_touch_screen)
end

function MainUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function MainUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function MainUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
end

--加载UI
function MainUI:LoadUI()
	if UiBaseClass.LoadUI(self) then
	--todo
	end
end

--初始化UI
function MainUI:InitUI(asset_obj)
	--UiBaseClass.InitUI(self, asset_obj);
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d())
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0);
	self.ui:set_name("main_ui");

	--右上角
    self.panel_right_top = ngui.find_panel(self.ui, "right_other/animation/panel_list");
    --self.panel_right_top:set_active(self.show_right_top);

    self.obj_ani_right_top = ngui.find_sprite(self.ui, "right_other/animation"):get_game_object();
    self.obj_ani_right_top:animator_play(right_top_ani[self.show_right_top]);

	self.btn_right_top = ngui.find_button(self.ui, "right_other/animation/btn_arrows");
    self.btn_right_top:set_on_click(self.bindfunc['on_right_top']);
    self.sp_tip_right_top = ngui.find_sprite(self.ui, "right_other/animation/btn_arrows/sp_point");
    self.sp_tip_right_top:set_active(false);
    self.sp_arrow_up = ngui.find_sprite(self.ui, "right_other/animation/btn_arrows/sp_arrows");
    self.sp_arrow_up:set_active(not self.show_right_top);
    self.sp_arrow_down = ngui.find_sprite(self.ui, "right_other/animation/btn_arrows/sp_arrows_down");
    self.sp_arrow_down:set_active(self.show_right_top);

	self.btn_drama = ngui.find_button(self.ui, "right_other/animation/panel_list/btn_drama");
    self.btn_drama:set_on_click(self.bindfunc['on_drama']);
    self.sp_tip_drama = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_drama/sp1");
    self.sp_tip_drama:set_active(false);

	self.btn_play_method = ngui.find_button(self.ui, "right_other/animation/panel_list/btn_play_method");
    self.btn_play_method:set_on_click(self.bindfunc['on_play_method']);
    self.sp_tip_play_method = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_play_method/sp1");
    self.sp_tip_play_method:set_active(false);

	self.btn_vs = ngui.find_button(self.ui, "right_other/animation/panel_list/btn_vs");
    self.btn_vs:set_on_click(self.bindfunc['on_vs']);
    self.sp_tip_vs = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_vs/sp1");
    self.sp_tip_vs:set_active(false);

	self.btn_organization = ngui.find_button(self.ui, "right_other/animation/panel_list/btn_organization");
    self.btn_organization:set_on_click(self.bindfunc['on_organization']);
    self.sp_tip_organization = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_organization/sp1");
    self.sp_tip_organization:set_active(false);
    self.lab_org_open_level = ngui.find_label(self.ui, "right_other/animation/panel_list/btn_organization/txt");
    self.sp_organization = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_organization/sp_drama");
    self.txt_organization = ngui.find_label(self.ui, "right_other/animation/panel_list/btn_organization/lab");

	self.btn_egg = ngui.find_button(self.ui, "right_other/animation/panel_list/btn_egg");
    self.btn_egg:set_on_click(self.bindfunc['on_egg']);
    self.sp_tip_egg = ngui.find_sprite(self.ui, "right_other/animation/panel_list/btn_egg/sp1");
    self.sp_tip_egg:set_active(false);

	--右下角
    self.panel_right_down = ngui.find_sprite(self.ui, "right_down_other/animation/right");
    --self.panel_right_down:set_active(self.show_right_down);

    self.obj_ani_right_down = asset_game_object.find("uiroot/ui_2d/main_ui/right_down_other/animation");
    self.obj_ani_right_down:animator_play(right_down_ani[self.show_right_down]);

    self.btn_right_down = ngui.find_button(self.ui, "right_down_other/animation/btn_toggle");
    self.btn_right_down:set_on_click(self.bindfunc['on_right_down']);
    self.sp_tip_right_down = ngui.find_sprite(self.ui, "right_down_other/animation/btn_toggle/sp_point");
    self.sp_tip_right_down:set_active(false);
    self.sp_right_down = ngui.find_sprite(self.ui, "right_down_other/animation/btn_toggle/sp_toggle");
    self.sp_right_down:set_sprite_name(right_down_spname[self.show_right_down]);

    self.btn_role = ngui.find_button(self.ui, "right_down_other/animation/right/btn_role");
    self.btn_role:set_on_click(self.bindfunc['on_role']);
    self.sp_tip_role = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_role/sp_point");
    self.sp_tip_role:set_active(false);

    self.btn_equipment = ngui.find_button(self.ui, "right_down_other/animation/right/btn_equipment");
    self.btn_equipment:set_on_click(self.bindfunc['on_equipment']);
    self.sp_tip_equipment = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_equipment/sp_point");
    self.sp_tip_equipment:set_active(false);

    self.btn_friend = ngui.find_button(self.ui, "right_down_other/animation/right2/btn_friend");
    self.btn_friend:set_on_click(self.bindfunc['on_friend']);
    --self.btn_friend:set_enable(false);
    self.sp_tip_friend = ngui.find_sprite(self.ui, "right_down_other/animation/right2/btn_friend/sp_point");
    self.sp_tip_friend:set_active(false);

    self.btn_mail = ngui.find_button(self.ui, "right_down_other/animation/right2/btn_mail");
    self.btn_mail:set_on_click(self.bindfunc['on_mail']);
    self.sp_tip_mail = ngui.find_sprite(self.ui, "right_down_other/animation/right2/btn_mail/sp_point");
    self.sp_tip_mail:set_active(false);

    self.btn_compound = ngui.find_button(self.ui, "right_down_other/animation/right/btn_compound");
    self.btn_compound:set_on_click(self.bindfunc['on_compound']);
    self.sp_tip_compound = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_compound/sp_point");
    self.sp_tip_compound:set_active(false);

    self.btn_set = ngui.find_button(self.ui, "right_down_other/animation/right2/btn_set");
    self.btn_set:set_on_click(self.bindfunc['on_set']);
    self.sp_tip_set = ngui.find_sprite(self.ui, "right_down_other/animation/right2/btn_set/sp_point");
    self.sp_tip_set:set_active(false);

    self.btn_sell = ngui.find_button(self.ui, "right_down_other/animation/right/btn_sell");
    self.btn_sell:set_on_click(self.bindfunc['on_sell']);
    --self.btn_sell:set_enable(false);
    
    self.sp_tip_sell = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_sell/sp_point");
    self.sp_tip_sell:set_active(false);

    self.btn_rank_list = ngui.find_button(self.ui, "right_down_other/animation/right/btn_rank_list");
    self.btn_rank_list:set_on_click(self.bindfunc['on_rank_list']);
    self.sp_tip_rank_list = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_rank_list/sp_point");
    self.sp_tip_rank_list:set_active(false);

    self.btn_strong = ngui.find_button(self.ui, "right_down_other/animation/right/btn_strong");
    self.btn_strong:set_on_click(self.bindfunc['on_strong']);
    self.sp_tip_strong = ngui.find_sprite(self.ui, "right_down_other/animation/right/btn_strong/sp_point");
    self.sp_tip_strong:set_active(false);

	--左上
    self.btn_sign = ngui.find_button(self.ui, "left_top_other/animation/btn_sign");
    self.btn_sign:set_on_click(self.bindfunc['on_sign']);
    self.sp_tip_sign = ngui.find_sprite(self.ui, "left_top_other/animation/btn_sign/sp");
    self.sp_tip_sign:set_active(false);

    self.btn_task = ngui.find_button(self.ui, "left_top_other/animation/btn_task");
    self.btn_task:set_on_click(self.bindfunc['on_task']);
    self.sp_tip_task = ngui.find_sprite(self.ui, "left_top_other/animation/btn_task/sp");
    self.sp_tip_task:set_active(false);

    self.btn_activity = ngui.find_button(self.ui, "left_top_other/animation/btn_activity");
    self.btn_activity:set_on_click(self.bindfunc['on_activity']);
    self.sp_tip_activity = ngui.find_sprite(self.ui, "left_top_other/animation/btn_activity/sp");
    self.sp_tip_activity:set_active(false);

    self.btn_service = ngui.find_button(self.ui, "left_top_other/animation/btn_service");
    self.btn_service:set_on_click(self.bindfunc['on_service']);     
    self.sp_tip_service = ngui.find_sprite(self.ui, "left_top_other/animation/btn_service/sp");
    self.sp_tip_service:set_active(false);

	--左中
	self.obj_human = {};
	for i=1,3 do
		self.obj_human[i] = ngui.find_button(self.ui, "left_centre_other/animation/head"..i.."/animation/big_card_item"):get_game_object();
	end

	--左下
	self.widget_rock = ngui.find_widget(self.ui, "left_touch_ui_bk");
    self.sp_rock = ngui.find_sprite(self.ui, "left_touch_ui_bk/left_touch_ui");
    self.sp_rock:set_on_ngui_press(self.bindfunc["on_touch_begin"]);
    self.sp_rock:set_on_ngui_drag_move(self.bindfunc["on_touch_move"]);
    self.sp_rock_di = ngui.find_sprite(self.ui, "left_touch_ui_bk/left_touch_ui/sp_di");

    --中
    self.btn_mark = ngui.find_button(self.ui, self.ui:get_name().."/btn_mark");
    self.btn_mark:set_on_ngui_click(self.bindfunc['on_touch_screen']);

    self:InitWorldChat();

    self:UpdateUi()

    --[[为了显示小红点提示，在主界面来请求数据]]
    -- 7日签到，月签到数据
    msg_checkin.cg_get_checkin_info()
    -- 请求活动状态
    msg_activity.cg_activity_request_state()
    -- 登录数据
    msg_activity.cg_login_request_my_data()
    -- 闯关数据
    msg_activity.cg_hurdle_request_my_data()
    -- 升级奖励
    LevelUpReward.GetInstance():RequestInitData()

    --推荐系统
    RecommendMgr.Inst():Start()
end

function MainUI:Update(dt)
    UiBaseClass.Update(self);
    self:UpdateWorldChat(dt);

    RecommendMgr.Inst():Update(dt)
end

function MainUI:UpdateUi()
	if not self.ui then return end
    local openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
    self.lab_org_open_level:set_text(openLevel .. _local.UIText[1]);

    local isOpen =(openLevel <= g_dataCenter.player.level);

    if isOpen then
        self.lab_org_open_level:set_active(false);
        self.sp_organization:set_color(1,1,1,1);
        self.txt_organization:set_color(1,1,1,1);
    else
        self.lab_org_open_level:set_active(true);
        self.sp_organization:set_color(0.3,0.3,0.3,1);
        self.txt_organization:set_color(0.3,0.3,0.3,1);
    end

    self.my_captain = g_dataCenter.fight_info:GetCaptain()
	local curTeam = g_dataCenter.player:GetDefTeam();
    for i = 1, 3 do
        if (curTeam ~= nil) then
            if (curTeam[i]) then
                local cardinfo = g_dataCenter.package:find_card(1, curTeam[i]);
                if (cardinfo ~= nil) then
                    self.roleData[i] = g_dataCenter.package:find_card_for_num(1, cardinfo.number);
                    if not self.scard[i] then
                        self.scard[i] = SmallCardUi:new( { obj = self.obj_human[i], info = cardinfo, res_group=self.panel_name });
                        self.scard[i]:SetCallback(self.bindfunc["on_card_human"])
                        self.scard[i]:SetTeamPosIcon(i);
                    else
                        self.scard[i]:SetData(cardinfo,self.obj_human[i]);
                    end
                else
                    if not self.scard[i] then
                        self.scard[i] = SmallCardUi:new( { obj = self.obj_human[i], res_group=self.panel_name });
                        self.scard[i]:SetCallback(self.bindfunc["on_card_human"])
                        self.scard[i]:SetAddIcon(true);
                    else
                        self.scard[i]:SetData(nil,self.obj_human[i]);
                        self.scard[i]:SetAddIcon(true);
                    end
                end
            else
                if not self.scard[i] then
                        self.scard[i] = SmallCardUi:new( { obj = self.obj_human[i], res_group=self.panel_name });
                        self.scard[i]:SetCallback(self.bindfunc["on_card_human"])
                        self.scard[i]:SetAddIcon(true);
                    else
                        self.scard[i]:SetData(nil,self.obj_human[i]);
                        self.scard[i]:SetAddIcon(true);
                    end
            end
        else
            app.log("当前队伍为空");
        end
    end 
end

-------------------------聊天-----------------------
function MainUI:InitWorldChat()
    if self.globalChat == nil then
        self.globalChat = NewFightUIWorldChat:new();
        self.globalChat:SetParent(self.ui);
    end
end
function MainUI:UpdateWorldChat(dt)
    if self.globalChat ~= nil then
        self.globalChat:Update(dt)
    end
end
function MainUI:DestroyWorldChat()
    if self.globalChat then
        self.globalChat:DestroyUi();
        self.globalChat = nil;
    end
end
function MainUI:HideWorldChat()
    if self.globalChat then
        --self.globalChat:HideChat();
    end
end

-------------------------左上-------------------------------
function MainUI:on_sign()
    mainCityScene:StopCaptain();
    uiManager:PushUi(EUI.SevenSignUi);
end

function MainUI:on_task()
    mainCityScene:StopCaptain();
    uiManager:PushUi(EUI.UiDailyTask);
end

function MainUI:on_activity()
    mainCityScene:StopCaptain();
    uiManager:PushUi(EUI.ActivityUI);
end

function MainUI:on_service()
    mainCityScene:StopCaptain();
    --uiManager:PushUi(EUI.UiQuestWebView)
    UiAnn.Start(UiAnn.Type.KeFu)
end
------------------------左中----------------------------------
function MainUI:on_card_human(t)
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.FormationUi2);
end
------------------------左下----------------------------------
--摇杆touch_begin
function MainUI:on_touch_begin(name, state, x, y, goObj)
    self.curPressCount = self.curPressCount or 0;
    if state == true then
        self.curPressCount = self.curPressCount + 1;
        if self.curPressCount ~= 1 then
            self.curPressCount = 0
            return;
        end
    else
        self.curPressCount = self.curPressCount - 1;
        if self.curPressCount ~= 0 then
            self.curPressCount = 0
            return;
        end
    end

    --local leftBottom = FightUI.ui_control.listLeftBottom;
    --FightUI.CheckToManualWay()

    if state == true then
        local bMove = false;
        last_x = x;
        last_y = y;
        last_angle = 0;
        local camera = Root.get_ui_camera();
        if camera then
            local screenWidth = app.get_screen_width();
            local autoDi = screenWidth / 1280 * di_radio;
            local autoRightDi = screenWidth / 1280 * 262;
            local autoTopDi = screenWidth / 1280 * 234;
            --最左边
            if last_x - autoDi < 0 then
                bMove = true;
                last_x = autoDi;
            end
            --最右边
            if last_x > autoRightDi then
                bMove = true;
                last_x = autoRightDi;
            end
            --最下边
            if last_y - autoDi < 0 then
                bMove = true;
                last_y = autoDi;
            end
            --最上边
            if last_y > autoTopDi then
                bMove = true;
                last_y = autoTopDi;
            end

            local sp_x, sp_y, sp_z = camera:screen_to_world_point(last_x, last_y, 0);
            self.sp_rock:get_game_object():set_position(sp_x, sp_y, 0);
        end
        -- if FightUI.touchBeginCallbackFunc then
        --     FightUI.touchBeginCallbackFunc(FightUI.touchBeginCallbackData);
        -- end

        -- 通知战斗管理器，按下了摇杆
        -- if FightScene.GetFightManager().OnRockerTouchBegin then
        --     FightScene.GetFightManager():OnRockerTouchBegin()
        -- end
        --点下后需要直接移动
        if bMove then
            self:on_touch_move(name, x, y, goObj)
        end
    else
        self.sp_rock:set_position(0, 0, 0);
        self.sp_rock_di:set_position(0, 0, 0);

        self.RockerMoveDis = 0;

        --local obj = FightManager.GetMyCaptain();
        local obj = g_dataCenter.fight_info:GetCaptain()
        if obj then
            local pos = obj:GetPosition();
            obj:SetHandleState(EHandleState.Manual);
        end

    end
end

--得到个摇杆点位的角度差
function MainUI:GetAngleFormTowTouchMove(lastX, lastY, x, y)
   local move_x = x - last_x;
   local move_y = y - last_y;
   local angle = math.atan2(move_y, move_x) * 180 / math.pi;
   return angle
end

--摇杆touch_move
function MainUI:on_touch_move(name, x, y, goObj)
    --local leftBottom = FightUI.ui_control.listLeftBottom;
    local move_x = x - last_x;
    local move_y = y - last_y;
    local dis = math.sqrt(move_x * move_x + move_y * move_y);
    local screenWidth = app.get_screen_width();
    dis = screenWidth / 1280 * dis;
    if dis > max_dis_check then
        dis = max_dis_check;
    end
    self.RockerMoveDis = dis;
    if dis > max_dis then
        dis = max_dis;
    end
    local angle = math.atan2(move_y, move_x) * 180 / math.pi;
--        if FightUI.is_trusteeship then
--            FightUI.ClickTrusteeship();
--        end
        last_angle = angle;

        local obj = g_dataCenter.fight_info:GetCaptain()
        if obj then
            local cameraObj = CameraManager.GetSceneCameraObj();
            if cameraObj then
                local angle_x, angle_y, angle_z = cameraObj:get_local_rotation()

                local new_angle = -angle + (angle_y + 90);
                -- if obj.aperture_manager:IsOpen(0) then
                --     obj:SetRotation(0, new_angle, 0)
                --     obj.aperture_manager:SetMoveAngle(new_angle);
                -- else
                    local eulerX,eulerY,eulerZ,eulerW = util.quaternion_euler(0, new_angle, 0);
                    local forwardX,forwardY,fowardZ = util.quaternion_multiply_v3(eulerX,eulerY,eulerZ,eulerW, 0, 0, 1);
                    if obj.canSkillRotate then
                        obj:SetSlowRotation(new_angle);
                    else
                        -- if FightUI.GetAngleFormTowTouchMove(lastX, lastY, x, y) > 36 then--如果角度达到了，就立即更新发送时间
                        --     --app.log("角度達到")
                        --     --obj.last_send_move_time = 0
                        -- end
                        obj:SetNewRotation(new_angle);
                        local pos = {x=forwardX, y = forwardY, z = fowardZ};
                        PublicStruct.RoleForward = pos;
                        self.nTouchMoveX = x--记录操作杆的位置
                        self.nTouchMoveY = y
                        if not obj:IsBeControlOrOutOfControlState() then
                            obj:SetHandleState(EHandleState.Move)
                        end
                    end
                --end
            else
                app.log("FightUI: Camera error.")
            end
        end

    -- end
    -- 摇杆中间图片的位置
    local sp_x, sp_y = math.cos(angle * math.pi / 180), math.sin(angle * math.pi / 180);
    sp_x = sp_x * dis;
    sp_y = sp_y * dis;
    if self.sp_rock_di then
        self.sp_rock_di:set_position(sp_x, sp_y, 0);
    end
end
---------------------------------右上------------------------------------

function MainUI:on_right_top()
    self.show_right_top = not self.show_right_top;
    self.obj_ani_right_top:animator_play(right_top_ani[self.show_right_top]);
    self.sp_arrow_up:set_active(not self.show_right_top);
    self.sp_arrow_down:set_active(self.show_right_top);

    if self.show_right_down == true and self.show_right_top == true then
        self.show_right_down = false;
        self.obj_ani_right_down:animator_play(right_down_ani[self.show_right_down]);
        self.sp_right_down:set_sprite_name(right_down_spname[self.show_right_down]);

        PublicFunc.msg_dispatch("MainCitySceneRightDownMenuOpenAndCloseEvent", self.show_right_down)
    end
end

function MainUI:on_drama()
    --mainCityScene:MoveCaptainToNpc(ENUM.SystemID.LevelAdventure);
    -- uiManager:PushUi(EUI.UiLevel);
    -- uiManager:ClearStack();
end

function MainUI:on_play_method()
    --mainCityScene:MoveCaptainToNpc(ENUM.SystemID.PlayMethod);
    -- CommomPlayUI.SetIndex(2)
    -- uiManager:PushUi(EUI.ChallengeEnterUI);
end

function MainUI:on_vs()
    --mainCityScene:MoveCaptainToNpc(ENUM.SystemID.VsUi);
    -- CommomPlayUI.SetIndex(1)
    -- uiManager:PushUi(EUI.AthleticEnterUI);

    -- local kill = {str='下一个香瓜成功击杀了世界boss,获得击杀奖励',award={{id=20000005, count=1}, {id=20000004, count=1}},};
    -- local rankAward = {{name='下一个香瓜成功击杀了世界boss,获得击杀奖励',award={{id=20000005, count=1}, {id=20000004, count=2}},}}
    -- local ownAward = {hurtStr = '你造成了1000点伤害', rankStr='排名为[F4A04E]1[-]', image=32000000, award={{id=2, count=10000}, {id=4, count=10}, {id=20000004, count=3}, {id=20000005, count=2}}};
    -- CommonRankAward.Start(kill, rankAward, ownAward);
end

function MainUI:on_organization()
    --mainCityScene:MoveCaptainToNpc(ENUM.SystemID.Organization);
    -- local openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
    -- -- 开启等级不足
    -- if openLevel > g_dataCenter.player.level then
        
    -- else
    --     -- 打开我的公会
    --     if g_dataCenter.guild:IsJoinedGuild() then
    --         uiManager:PushUi(EUI.GuildMainUI);
    --     -- 打开公会申请
    --     else
    --         -- 先清除老的公会列表数据
    --         g_dataCenter.guild.simpleList = nil
    --         -- 打开公会浏览列表
    --         uiManager:PushUi(EUI.GuildLookUI);
    --     end
    --     uiManager:ClearStack();
    -- end
end

function MainUI:on_egg()
    --mainCityScene:MoveCaptainToNpc(ENUM.SystemID.EggHero);
    --uiManager:PushUi(EUI.EggUi);
end

-----------------------------右下--------------------------------
function MainUI:on_right_down()
    self.show_right_down = not self.show_right_down;
    self.obj_ani_right_down:animator_play(right_down_ani[self.show_right_down]);
    self.sp_right_down:set_sprite_name(right_down_spname[self.show_right_down]);

    PublicFunc.msg_dispatch("MainCitySceneRightDownMenuOpenAndCloseEvent", self.show_right_down)

    if self.show_right_down == true and self.show_right_top == true then
        self.show_right_top = false;
        self.obj_ani_right_top:animator_play(right_top_ani[self.show_right_top]);
        self.sp_arrow_up:set_active(not self.show_right_top);
        self.sp_arrow_down:set_active(self.show_right_top);
    end
end

function MainUI:GetShowRightDown()
    return self.show_right_down
end

function MainUI:on_role()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.HeroPackageUI);
    
end

function MainUI:on_equipment()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.EquipPackageUI);
end

function MainUI:on_friend()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.UiEquipForge);
end

function MainUI:on_mail()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.MailUi);
end

function MainUI:on_compound()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.EquipCompoundUI);
end

function MainUI:on_set()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.UiSet);
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
    --  -- battle = {
    --  --  players={
    --  --      left= {player=g_dataCenter.player, cards=roleCards},
    --  --      right= {player=g_dataCenter.player, cards=roleCards},
    --  --  },
    --  --  fightResult={
    --  --      isWin = false,
    --  --      leftCount = 1,
    --  --      rightCount = 3,
    --  --      leftEquipSouls = 1,
    --  --      rightEquipSouls = 3,
    --  --  },
    --  -- }
    --  -- star = {star = 2, finishConditionInfex={[1] = 1, [3] = 1}, conditionDes={"111", "222", "333"}, showTitle=true},
    --  -- addexp = {player = g_dataCenter.player, cards=roleCards},
    --  -- jump = {jumpFunctionList={ENUM.ELeaveType.PlayerLevelUp, ENUM.ELeaveType.EquipComposite, ENUM.ELeaveType.EquipLevelUp,}},
    --  -- awards = {awardsList={{id=2, count=3},{id=2, count=3},{id=2, count=3},}, tType=2},
    -- }
    --CommonClearing.Start(data);
end

local n = 0;
function MainUI:on_sell()
    mainCityScene:StopCaptain()
    --world_msg.cg_test_enter_world(1);
    -- local xx = 
    -- {
    --     dataid = "1231234",
    --     number = 20000042,
    --     count = 1,
    -- }
    -- msg_cards.gc_add_item_cards(xx)

    uiManager:PushUi(EUI.PackageUi)
end

-- local m = 0;
function MainUI:on_rank_list()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.RankUI, {default=true});
    -- m = m + 1;
    -- local data = 
    -- {
    --     str = "优先级==2 按下第"..m.."次",
    --     priority = 2,
    --     number = 20000006,
    -- }
    -- UiRollMsg.PushMsg(data)
end

function MainUI:on_strong()
    mainCityScene:StopCaptain()
    uiManager:PushUi(EUI.UiDevelopGuide);
end

--------------------------------------------------------------------
function MainUI:on_touch_screen(name,x,y,game_obj)
    local layer_mask = PublicFunc.GetBitLShift({[1]=PublicStruct.UnityLayer.npc});
    local result, hitinfo = util.raycase_out_object(x,y,200,layer_mask);
    if result == true then
        local name = hitinfo.game_object:get_name();
        local info = mainCityScene:GetNpcInfoByName(name);
        if not info then return end
        local my_captain = g_dataCenter.fight_info:GetCaptain();
        local my_pos = my_captain:GetPosition(false);
        local x,y,z = hitinfo.game_object:get_position();
        local dis = algorthm.GetDistance(my_pos.x, my_pos.z, x, z);
        --if dis <= 2 then
            --mainCityScene:StopCaptain();
            --mainCityScene:SetEnterSystemID(info.system_id)
            --mainCityScene:TouchMainCityNpc();
            mainCityScene:MoveCaptainToNpc(info.system_id);
            self.my_captain:SetNavFlag(true, false)
            local _found,px,py,pz;
            _found, px, py, pz = util.get_navmesh_sampleposition(x,y,z,10);
            if _found then
                local xx = self.my_captain.navMeshAgent:calculate_path(px, py, pz);
                -- app.log("xxxxxxx"..table.tostring(xx));
            end
        --end
    end
end

return MainUI;



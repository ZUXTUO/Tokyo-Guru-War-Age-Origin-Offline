

MainUIJoystick = Class('MainUIJoystick', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/left_touch_ui_bk.assetbundle"

-- 圆底的半径
local di_radio = 116;
local joystickArrowInitAngle = 45;

function MainUIJoystick.GetResList()
    return {res}
end

function MainUIJoystick:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUIJoystick:InitData(data)
    UiBaseClass.InitData(self, data)

    self.max_dis = 70
end

function MainUIJoystick:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name("main_ui_joystick")

    self.joystickSp = ngui.find_sprite(self.ui, 'left_touch_ui')
    self.joystickSp:set_on_ngui_press(self.bindfunc['TouchBegin'])
    self.joystickSp:set_on_ngui_drag_move(self.bindfunc['TouchMove'])
    self.joystickArrowObj = self.ui:get_child_by_name('sp_arrows')
    self.joystickArrowObj:set_active(false)
    local pos = {}
    pos.x,pos.y,pos.z = self.joystickSp:get_position()
    self.joystickSpOriginPosition = pos
    self.joystickObj = self.joystickSp:get_game_object()

    self.centerMoveCircleSp = ngui.find_sprite(self.joystickObj, 'sp_di')
    self.centerMoveCircleObj = self.centerMoveCircleSp:get_game_object()
end

function MainUIJoystick:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['TouchBegin'] = Utility.bind_callback(self, self.TouchBegin)
    self.bindfunc['TouchMove'] = Utility.bind_callback(self, self.TouchMove)

    self.bindfunc['PushUi'] = Utility.bind_callback(self, self.PushUi)
end

function MainUIJoystick:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(UiManager.PushUi, self.bindfunc['PushUi'])
end

function MainUIJoystick:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(UiManager.PushUi, self.bindfunc['PushUi'])
end

function MainUIJoystick:PushUi()
    if self.ui and self.touch_move_begin == true then
        
        self:TouchBegin(nil, false)

        self.touch_move_begin = false
    end
end

function MainUIJoystick:TouchBegin(name, state, x, y, goObj)
    if not self.ui then return end;
    --当前按钮按下的的状态的数量
    self.curPressCount = self.curPressCount or 0;
    if state == true then
        self.curPressCount = self.curPressCount + 1;
        if self.curPressCount ~= 1 then
            self.curPressCount = 0
            app.log('press down num errro')
            return
        end
    else
        self.curPressCount = self.curPressCount - 1;
        if self.curPressCount ~= 0 then
            self.curPressCount = 0
            app.log('press up num errro')
            return
        end
    end

    self:UpdateTouchTime()
    g_dataCenter.player:CheckToManualWay()

    if state == true then
        local bMove = false;
        self.touch_move_begin = true;
        self.last_x = x;
        self.last_y = y;
        self.last_angle = 0;
        local camera = Root.get_ui_camera();
        if camera then
            local screenWidth = app.get_screen_width();
            local autoDi = screenWidth / 1280 * di_radio;
            local autoRightDi = screenWidth / 1280 * 262;
            local autoTopDi = screenWidth / 1280 * 234;
            --最左边
            if self.last_x - autoDi < 0 then
                bMove = true;
                self.last_x = autoDi;
            end
            --最右边
            if self.last_x > autoRightDi then
                bMove = true;
                self.last_x = autoRightDi;
            end
            --最下边
            if self.last_y - autoDi < 0 then
                bMove = true;
                self.last_y = autoDi;
            end
            --最上边
            if self.last_y > autoTopDi then
                bMove = true;
                self.last_y = autoTopDi;
            end
            local sp_x, sp_y, sp_z = camera:screen_to_world_point(self.last_x, self.last_y, 0);
            self.joystickObj:set_position(sp_x, sp_y, 0);
        end
--        if FightUI.touchBeginCallbackFunc then
--            FightUI.touchBeginCallbackFunc(FightUI.touchBeginCallbackData);
--        end

        -- 通知战斗管理器，按下了摇杆
        if FightScene.GetFightManager().OnRockerTouchBegin then
            FightScene.GetFightManager():OnRockerTouchBegin()
        end
        --点下后需要直接移动
        if bMove then
            --app.log('TouchBegin bMove')
            self:TouchMove(name, x, y, goObj)
        else
            --app.log('TouchBegin not bMove')
        end
        self.joystickArrowObj:set_active(true)
    else
        self.touch_move_begin = false
        self.joystickSp:set_position(self.joystickSpOriginPosition.x, self.joystickSpOriginPosition.y, 0)
        self.centerMoveCircleSp:set_position(0, 0, 0)

        GetMainUI():SetLeftMoveDis(0)
        self.joystickArrowObj:set_active(false)
        local obj = FightManager.GetMyCaptain();
        if obj then
            --[[if obj.real_use_normal_attack and obj.keepNormalAttack then
                return
            end]]
            local pos = obj:GetPosition();
            obj:SetHandleState(EHandleState.Manual);
            g_dataCenter.autoPathFinding:StopPathFind();
            if obj.real_use_normal_attack and obj.keepNormalAttack then
                GetMainUI():GetSkillInput():NormalAttack(nil, false, 950,60, nil, -1, nil)
                GetMainUI():GetSkillInput():NormalAttack(nil, true, 950,60, nil, -1, nil)
            end
        end
    end
end

function MainUIJoystick:GetAngleFormTowTouchMove(lastX, lastY, x, y)

   local angle = math.atan2(y, x) * 180 / math.pi;

   local angle2 = math.atan2(lastY, lastX) * 180 / math.pi;

   local num = math.abs(angle-angle2)
   --app.log_warning("摇杆点位的角度差:".." "..angle.." "..angle2.." "..num)
   return num
end

function MainUIJoystick:TouchMove(name, x, y, goObj)
    if self.touch_move_begin ~= true then 
        --app.log('TouchMove return 1')
        return 
    end
    if not self.ui then return end;
    local move_x = x - self.last_x;
    local move_y = y - self.last_y;
    local dis = math.sqrt(move_x * move_x + move_y * move_y);
    local screenWidth = app.get_screen_width();
    dis = screenWidth / 1280 * dis;

    local mainui = GetMainUI()
    if dis > mainui.left_dis_check then
        dis = mainui.left_dis_check
    end
    mainui:SetLeftMoveDis(dis)
    if dis > self.max_dis then
        dis = self.max_dis;
    end
    self:UpdateTouchTime()
    local angle = math.atan2(move_y, move_x) * 180 / math.pi;
    local obj = FightManager.GetMyCaptain()
    if obj then
        local cameraObj = CameraManager.GetSceneCameraObj();
        if cameraObj then
            local angle_x, angle_y, angle_z = cameraObj:get_local_rotation()
            local new_angle = -angle + (angle_y + 90);
            if obj.aperture_manager and obj.aperture_manager:IsOpen(0) then
                obj:SetRotation(0, new_angle, 0)
                obj.aperture_manager:SetMoveAngle(new_angle);
            else
                local eulerX,eulerY,eulerZ,eulerW = util.quaternion_euler(0, new_angle, 0);
                local forwardX,forwardY,fowardZ = util.quaternion_multiply_v3(eulerX,eulerY,eulerZ,eulerW, 0, 0, 1);
                if obj.canSkillRotate then
                    obj:SetSlowRotation(new_angle);
                else
                        
                    obj:SetNewRotation(new_angle);
                    local pos = {x=forwardX, y = forwardY, z = fowardZ};
                    if PublicStruct.RoleForward == nil then
                        PublicStruct.RoleForward = pos;
                    end
                    if self:GetAngleFormTowTouchMove(pos.x, pos.z, PublicStruct.RoleForward.x, PublicStruct.RoleForward.z) > 3 then
                        --app.log_warning("角度达到 pos="..table.tostring(pos))
                        --obj.last_send_move_time = 0
                        PublicStruct.RoleForward = pos;

                    end
                    if not obj:IsBeControlOrOutOfControlState() --[[and (not obj.keepNormalAttack or not obj.real_use_normal_attack)]] then
                        --app.log('TouchMove SetHandleState')
                        obj:SetHandleState(EHandleState.Move)
                    else
                        --app.log('TouchMove IsBeControlOrOutOfControlState='..tostring(obj:IsBeControlOrOutOfControlState()).." keepNormalAttack="..tostring(obj.keepNormalAttack).." real_use_normal_attack="..tostring(obj.real_use_normal_attack))
                    end
                end
            end
        else
            app.log("FightUI: Camera error.")
        end
    end

    local sp_x, sp_y = math.cos(angle * math.pi / 180), math.sin(angle * math.pi / 180);
    sp_x = sp_x * dis;
    sp_y = sp_y * dis;
    self.centerMoveCircleSp:set_position(sp_x, sp_y, 0);
    self.joystickArrowObj:set_local_rotation(0, 0, angle - joystickArrowInitAngle);
end

function MainUIJoystick:UpdateTouchTime()
    self.touchMoveTime = os.time();
end

function MainUIJoystick:Update(dt)

    local isOpen,autoTime = FightScene.GetFightManager():IsOpenTimeAuto()
    if isOpen then
        self.touchMoveTime = self.touchMoveTime or os.time();
        local obj = FightManager.GetMyCaptain()
        if not g_dataCenter.player:CaptionIsAutoFight() then
            if os.time() - self.touchMoveTime > autoTime then
                g_dataCenter.player:ChangeFightMode(true)
            end
        end
    end
end

function MainUIJoystick:DestroyUi()
    if self.ui then
        self.ui:set_active(false);
        self.ui = nil
    end
    
    self.joystickSp = nil
    self.joystickSp = nil
    self.joystickObj = nil
    self.centerMoveCircleSp = nil
    self.centerMoveCircleObj =  nil
    UiBaseClass.DestroyUi(self);
end

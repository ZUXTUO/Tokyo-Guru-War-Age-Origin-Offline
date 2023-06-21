--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/19
-- Time: 10:49
-- To change this template use File | Settings | File Templates.
--
script.run "logic/object/fight_event.lua"
--[[层级]]
local LayerList_new = {
	PublicStruct.UnityLayer.water,
--	PublicStruct.UnityLayer.player,
}
local LayerList_Payer = {
    PublicStruct.UnityLayer.monster,
    PublicStruct.UnityLayer.player,
}

TouchManager = {
    maxMove = 50;
    moveNum = 0;

    is_player = false;

    arrow_assetLoader = nil;
    arrow_assetObj = nil;
    arrowGameobjList = { };--[[ 箭头集合 ]]

    --[[ 手势监控 ]]
    touch_assetObj = nil;
    touch_obj = nil;
    touch_ngui_obj = nil;

    barrier_obj = nil;--[[ 跳跃的栅栏 ]]
    barrier = nil;--[[ 跳跃的栅栏 ]]

    --[[ 射线碰撞对像 ]]
    hitList = { };

    touch_begin_x = 0;
    touch_begin_y = 0;

    touch_angle_x = 0;
    touch_angle_y = 0;

    updateCheckTime = 0;
}

function TouchManager.Update(deltaTime)
    TouchManager.updateCheckTime = TouchManager.updateCheckTime + deltaTime
    if deltaTime < 0.3 then -- 0.3s 处理一次
        return
    end
    TouchManager.updateCheckTime = 0;

    TouchManager.TimeMove();
end

function TouchManager.Destroy()
    TouchManager.arrow_assetLoader = nil;
    TouchManager.arrow_assetObj = nil;
    TouchManager.moveNum = 0;
    --[[ 清除箭头 ]]
    for i = 1, table.getn(TouchManager.arrowGameobjList) do
        TouchManager.arrowGameobjList[i].obj:set_active(false);
        TouchManager.arrowGameobjList[i].obj = nil;
    end
    TouchManager.arrowGameobjList = { };
    --[[ 箭头集合 ]]

    TouchManager.barrierLoader = nil;
    TouchManager.barrier_obj = nil;
    --[[ 跳跃的栅栏 ]]
    TouchManager.barrier = nil;
    --[[ 跳跃的栅栏 ]]

    --[[ 手势监控 ]]
    TouchManager.touch_assetObj = nil;
    if TouchManager.touch_obj ~= nil then
        TouchManager.touch_obj:set_active(false);
    end
    TouchManager.touch_obj = nil;
    TouchManager.touch_ngui_obj = nil;
    Root.DelUpdate(TouchManager.TimeMove);
end

--[[初始化 TouchUI]]
function TouchManager.Init()
    --[[ UI手势监控 ]]
    ResourceLoader.LoadAsset("assetbundles/prefabs/ui/fight/ui_fight_touch.assetbundle", TouchManager.touchLoadedCallBack, nil)
    Root.AddUpdate(TouchManager.TimeMove)
end

function TouchManager.touchLoadedCallBack(pid, fpath, asset_obj, error_info)
    TouchManager.touch_assetObj = asset_obj;
    TouchManager.touch_obj = asset_game_object.create(asset_obj);

    --[[ 触摸层 ]]
    TouchManager.touch_ngui_obj = ngui.find_sprite(TouchManager.touch_obj, "ui_fight_touch_sprite");
    TouchManager.touch_ngui_obj:set_on_ngui_press("TouchManager.OnTouchBegin");
    TouchManager.touch_ngui_obj:set_on_ngui_drag_move("TouchManager.OnTouchMove");
    TouchManager.CloseTouch();
	-- TouchManager.touch_ngui_obj:set_on_ngui_drag_end("TouchManager.OnTouchEnd");

end

function TouchManager.OnTouchBegin(name,istouch,x,y)
	app.log("begin"..tostring(istouch));

	local role = FightManager.GetMyCaptain( );
	if not role then
		return
	end
    if istouch then
        TouchManager.CheckClick(x,y,role);
        --[[移动]]
        TouchManager.is_touch = true;
    else
        TouchManager.is_touch = false;
    end
end

function TouchManager.GetMovePos()
    return TouchManager.move_x, TouchManager.move_y, TouchManager.move_z;
end

function TouchManager.SetMovePos(x,y,z)
    TouchManager.move_x, TouchManager.move_y, TouchManager.move_z = x,y,z;
end

function TouchManager.OnTouchMove(name,x,y)
    local role = FightManager.GetMyCaptain( );
    if not role then
        return;
    end
    local attack = role:GetAttackTarget()
    if attack then
        return;
    end
    TouchManager.CheckClick(x,y,role);
end
function TouchManager.TimeMove()
    if TouchManager.is_touch then
        local role = FightManager.GetMyCaptain( );
        if not role then
            return;
        end
        local attack = role:GetAttackTarget()
        if attack then
            return;
        end
        local x, y = TouchManager.touch_begin_x, TouchManager.touch_begin_y;
        TouchManager.CheckClick(x,y,role);
    end
end
function TouchManager.OnTouchEnd(name,x,y)
	role.object:set_capsule_collider_enable(true);
end

function TouchManager.OpenTouch( )
	if TouchManager.touch_ngui_obj ~= nil then
		TouchManager.touch_ngui_obj:set_active(true);
	end
end
function TouchManager.CloseTouch( )
	if TouchManager.touch_ngui_obj ~= nil then
		TouchManager.touch_ngui_obj:set_active(false);
	end
end


function TouchManager.CheckClick(x, y, role)
    local attack = nil;
    local layerMask = PublicFunc.GetBitLShift(LayerList_Payer);
    TouchManager.touch_begin_x = x;
    TouchManager.touch_begin_y = y;
    local result_obj, hit = util.raycase_out_object(x,y,100,layerMask);
    if result_obj then
        local click_role = ObjectManager.GetObjectByName(hit.game_object:get_name());
        if click_role and click_role:IsEnemy() then
            attack = click_role;
        end
    end
    if attack then
        role.stopAttack = false;
        role:KeepNormalAttack(true);
        role:SetAttackTarget(attack);
        role:SetHandleState(EHandleState.Attack);
    else
        local layerMask = PublicFunc.GetBitLShift(LayerList_new);
        local result,dx,dy,dz = util.raycase_out_screen(x,y,100,layerMask);
        if result then
            TouchManager.move_x = dx;
            TouchManager.move_y = dy;
            TouchManager.move_z = dz;
            role:SetHandleState(EHandleState.ClickMove);
        end
    end
end

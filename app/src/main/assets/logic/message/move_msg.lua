msg_move = msg_move or {}
function msg_move.gc_move_logic(gid,sx,sy,dx,dy)
    local obj = ObjectManager.GetObjectByGID(gid)
    if nil == obj then
        --app.log("move_msg.gc_move obj:"..gid.." not found.");
        return
    end

    if obj:IsMyControl() or obj:IsAIAgent() then
        return
    end
    --app.log("rcv move msg: player"..obj:GetName().." "..sx.." "..sy.." "..dx.." "..dy.." ");

    local path_start = {x=sx, y=sy}
    local path_next1 = {x=dx, y=dy}
    path_start.x = path_start.x*PublicStruct.Coordinate_Scale_Decimal
    path_start.y = path_start.y*PublicStruct.Coordinate_Scale_Decimal
    path_next1.x = path_next1.x*PublicStruct.Coordinate_Scale_Decimal
    path_next1.y = path_next1.y*PublicStruct.Coordinate_Scale_Decimal
    -- app.log(string.format("rcv obj move. name: %s from pos: %f, %f to %f, %f", obj:GetName(), path_start.x, path_start.y,
    --     path_next1.x, path_next1.y)) 

    --TODO: kevin 各种检测

    local captain = g_dataCenter.fight_info:GetCaptain();
    if nil ~= captain and obj:GetOwnerPlayerGID() == captain:GetGID() then
        app.log("local player moves. msg ignored.")
    else
        local pos = path_next1;
        pos.x = pos.x;
        pos.y = pos.y;
        local bFixMove = false
        if not obj:IsMyControl() and not obj:IsAIAgent() then
            local _pos = obj:GetPosition();
            local dis = algorthm.GetDistance(_pos.x, _pos.z, path_start.x, path_start.y);
            if dis > 1.5 then
                bFixMove = true
                obj.fix_move = {x=_pos.x, y=_pos.z}
                obj:SetDestination(path_start.x, 0, path_start.y)
                if obj.navMeshAgent then
                    obj.navMeshAgent:set_speed(obj.speed_from_server*1.5)
                end
            end
        end
        if not bFixMove then
            if obj.fix_move then
                obj.fix_move = nil
                if obj.navMeshAgent then
                    obj.navMeshAgent:set_speed(obj.speed_from_server)
                end
            end
            obj:SetDestination(pos.x, 0,  pos.y)    
        end
        obj:SetState(ESTATE.Run)
    end
end

function msg_move.gc_move_multi(msg_list)
    -- app.log("gc_move_multi. cnt:"..table.getn(msg_list))
    for i=1,table.getn(msg_list) do
        local msg = msg_list[i]
        if msg then
            msg_move.gc_move_logic(msg.gid, msg.x, msg.y, msg.dx, msg.dy)
        end
    end
end
function msg_move.gc_move_10_logic(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4,
     id5,  x5,  y5,  dx5,  dy5,
     id6,  x6,  y6,  dx6,  dy6, 
     id7,  x7,  y7,  dx7,  dy7,
     id8,  x8,  y8,  dx8,  dy8,
     id9,  x9,  y9,  dx9,  dy9)


    if cnt > 0 then
        msg_move.gc_move_logic(id0, x0, y0, dx0, dy0);
    end
    if cnt > 1 then
        msg_move.gc_move_logic(id, x1, y1, dx1, dy1);
    end
    if cnt > 2 then
        msg_move.gc_move_logic(id2, x2, y2, dx2, dy2);
    end
    if cnt > 3 then
        msg_move.gc_move_logic(id3, x3, y3, dx3, dy3);
    end
    if cnt > 4 then
        msg_move.gc_move_logic(id4, x4, y4, dx4, dy4);
    end
    if cnt > 5 then
        msg_move.gc_move_logic(id5, x5, y5, dx5, dy5);
    end
    if cnt > 6 then
        msg_move.gc_move_logic(id6, x6, y6, dx6, dy6);
    end
    if cnt > 7 then
        msg_move.gc_move_logic(id7, x7, y7, dx7, dy7);
    end
    if cnt > 8 then
        msg_move.gc_move_logic(id8, x8, y8, dx8, dy8);
    end
    if cnt > 9 then
        msg_move.gc_move_logic(id9, x9, y9, dx9, dy9);
    end
end

function msg_move.gc_move_10(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4,
     id5,  x5,  y5,  dx5,  dy5,
     id6,  x6,  y6,  dx6,  dy6, 
     id7,  x7,  y7,  dx7,  dy7,
     id8,  x8,  y8,  dx8,  dy8,
     id9,  x9,  y9,  dx9,  dy9)

    util.begin_sample("cnt_"..cnt);
    -- app.log("gc_move_10 rcv batch move msg. cnt:"..cnt)
    util.end_sample();

    msg_move.gc_move_10_logic(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4,
     id5,  x5,  y5,  dx5,  dy5,
     id6,  x6,  y6,  dx6,  dy6, 
     id7,  x7,  y7,  dx7,  dy7,
     id8,  x8,  y8,  dx8,  dy8,
     id9,  x9,  y9,  dx9,  dy9)
    
end

function msg_move.gc_move_7(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4,
     id5,  x5,  y5,  dx5,  dy5,
     id6,  x6,  y6,  dx6,  dy6)
    
    util.begin_sample("cnt_"..cnt);
    -- app.log("gc_move_7 rcv batch move msg. cnt:"..cnt)
    util.end_sample();

    msg_move.gc_move_10_logic(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4,
     id5,  x5,  y5,  dx5,  dy5,
     id6,  x6,  y6,  dx6,  dy6)
end

function msg_move.gc_move_5(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4)
    
    util.begin_sample("cnt_"..cnt);
    -- app.log("gc_move_5 rcv batch move msg. cnt:"..cnt)
    util.end_sample();

    msg_move.gc_move_10_logic(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2,
     id3,  x3,  y3,  dx3,  dy3,
     id4,  x4,  y4,  dx4,  dy4)
end

function msg_move.gc_move_3(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2)

    util.begin_sample("cnt_"..cnt);
    -- app.log("gc_move_3 rcv batch move msg. cnt:"..cnt)
    util.end_sample();

    msg_move.gc_move_10_logic(cnt, id0,  x0,  y0,  dx0,  dy0,
     id1,  x1,  y1,  dx1,  dy1,
     id2,  x2,  y2,  dx2,  dy2)
end

function msg_move.gc_move(gid,sx,sy,dx,dy)
    util.begin_sample("cnt_"..1);
    -- app.log("gc_move_1 rcv batch move msg. cnt:"..1)
    util.end_sample();
	msg_move.gc_move_logic(gid,sx,sy,dx,dy)
end

function msg_move.gc_set_position_logic(gid, x, y, stand)
    -- body
    -- app.log("gc_set_postion:");
    local obj = ObjectManager.GetObjectByGID(gid)
    if nil == obj then
        return
    end
    -- app.log("gc_set_postion:"..gid.." "..x.." "..y);
    local posX = x*PublicStruct.Coordinate_Scale_Decimal
    local posY = y*PublicStruct.Coordinate_Scale_Decimal
    local pos = obj:GetPosition()
    local dis = algorthm.GetDistance(pos.x, pos.z, posX, posY);
    --app.log_warning("gc_set_postion:"..gid.." "..posX.." "..posY.." "..pos.x.." "..pos.z.." "..dis.." "..stand);

    --不包含自己，就不处理 是否站立（低一位）是否包含自己（低二位）
    if stand == 1 or stand == 0 then
        if obj:IsMyControl() or obj:IsAIAgent() then
            return
        end
    end
    --[[if dis < 0.7 then
        app.log(debug.traceback())
        return
    end]]
    if dis > 3 then
        obj:SetPosition(posX, 2,  posY, true, true)
        if stand then
            obj:SetState(ESTATE.Stand)
        end
    else
        if stand == 1 or stand == 3 then
            if not obj:IsMyControl() and  not obj:IsAIAgent() then
                if not obj:IsInPosMove()  then
                    if obj:IsSkillInWorking() or (not obj.lastSkillComplete) or obj:GetAniCtrler():IsInSkillAnim() then
                        obj:SetPosition(posX, 2,  posY, true, true)
                    else
                        if dis < 0.7 then
                            obj:SetState(ESTATE.Stand)
                        else
                            obj:SetDestination(posX, 2, posY)
                            obj:SetState(ESTATE.Run)
                        end
                    end
                end
            end
        end
    end
end

--正常的设置坐标协议
function msg_move.gc_set_position(gid, x, y, stand)
    -- body
    msg_move.gc_set_position_logic(gid, x, y, stand)
end

--包含多人的设置坐标协议
function msg_move.gc_set_position_multi(msg_list)
    -- app.log("gc_set_position_multi. cnt:"..table.getn(msg_list))
    for i=1,table.getn(msg_list) do
        local msg = msg_list[i]
        if msg then
            msg_move.gc_set_position_logic(msg.gid, msg.x, msg.y, msg.stand)
        end
    end
end

--------------------------------------------------------------
function msg_move.cg_move(gid,sx,sy,dx,dy)
    --if not Socket.socketServer then return end
    --app.log_warning("msg_move.cg_move time="..PublicFunc.QueryCurTime())
    nmsg_move.cg_move(Socket.socketServer, gid,sx,sy,dx,dy)
end

function msg_move.cg_move_multi(gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
    --if not Socket.socketServer then return end
    if dx2 == nil then
        dx2 = 9999
    end
    if dy2 == nil then
        dy2 = 9999
    end
    if dx3 == nil then
        dx3 = 9999
    end
    if dy3 == nil then
        dy3 = 9999
    end
    --app.log_warning("msg_move.cg_move_multi time="..PublicFunc.QueryCurTime())
    nmsg_move.cg_move_multi(Socket.socketServer, gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
end

function msg_move.cg_request_real_position(gid)
    --if not Socket.socketServer then return end
    nmsg_move.cg_request_real_position(Socket.socketServer, gid)
end

function msg_move.cg_stand(gid, x, y)
    --if not Socket.socketServer then return end
    nmsg_move.cg_stand(Socket.socketServer, gid, x, y)
end

function msg_move.cg_translate_position(gid, x, y)
    --if not Socket.socketServer then return end
    --app.log("gid="..gid.." "..debug.traceback())
    nmsg_move.cg_translate_position(Socket.socketServer, gid, x, y)
end

function msg_move.cg_move_home(gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
    --if not Socket.socketServer then return end
    if dx2 == nil then
        dx2 = 9999
    end
    if dy2 == nil then
        dy2 = 9999
    end
    if dx3 == nil then
        dx3 = 9999
    end
    if dy3 == nil then
        dy3 = 9999
    end
    nmsg_move.cg_move_home(Socket.socketServer, gid,sx,sy,dx1,dy1,dx2,dy2,dx3,dy3)
end
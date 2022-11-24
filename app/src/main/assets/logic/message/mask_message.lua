msg_mask = msg_mask or { }

msg_mask.last_rarity_mask_id = 0;
msg_mask.last_star_mask_id = 0;

-- function msg_mask.cg_get_mask_info()
--     --if not Socket.socketServer then return end
--     nmsg_mask.cg_get_mask_info(Socket.socketServer);
        
-- end

function msg_mask.cg_eat_mask_exp(index, id, count)
    --if not Socket.socketServer then return end
	nmsg_mask.cg_eat_mask_exp(Socket.socketServer,index ,id,count)
    
end


function msg_mask.cg_upgrade_mask(index)
    --if not Socket.socketServer then return end
	nmsg_mask.cg_upgrade_mask(Socket.socketServer,index )
    
end

function msg_mask.cg_mask_rarity_up(index,number)
    --if not Socket.socketServer then return end
	nmsg_mask.cg_mask_rarity_up( Socket.socketServer,index )
    msg_mask.last_rarity_mask_id = number
end


function msg_mask.cg_mask_star_up( index ,number)
    --if not Socket.socketServer then return end
	nmsg_mask.cg_mask_star_up( Socket.socketServer,index )
    msg_mask.last_star_mask_id = number
end


-- 返回数据
function msg_mask.gc_get_mask_info( list )
--    app.log("msg_mask.gc_get_mask_info")
    g_dataCenter.maskitem:InitMaskInfo(list)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Item_Mask)
end


function msg_mask.gc_eat_mask_exp( result,index, id,count)

    app.log("gc_eat_mask_exp.."..tostring(result))

    local show = PublicFunc.GetErrorString(result);
    if show then
        
    end
end


function msg_mask.gc_upgrade_mask( result,index )
    local show = PublicFunc.GetErrorString(result);
    if show then
        --刷新mask_info 界面的等级
        local obj = uiManager:FindUI(EUI.MaskMainInfo)
        obj:one_play_fx()
    end
end


function msg_mask.gc_mask_rarity_up(result,index)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        local data = {index =index,id = msg_mask.last_rarity_mask_id }
        uiManager:PushUi(EUI.MaskRarityUpWnd,data);
    end
end

function msg_mask.gc_mask_star_up(result,index)
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        local data = {index =index,id = msg_mask.last_star_mask_id }
        uiManager:PushUi(EUI.MaskStarUpWnd,data);
    end
end

function msg_mask.gc_update_mask_info(maskinfo)
    app.log("gc_update_mask_info.."..table.tostring(maskinfo))
    g_dataCenter.maskitem:updata_mask_info(maskinfo)
    PublicFunc.msg_dispatch(msg_mask.gc_update_mask_info,maskinfo)  
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Item_Mask)
end


return msg_mask;

msg_laboratory = msg_laboratory or { }
-- 请求所有研究数据
function msg_laboratory.cg_request_all_laboratory_data()
    --if not Socket.socketServer then return end
        nmsg_laboratory.cg_request_all_laboratory_data(Socket.socketServer);
        
end
--解锁
function msg_laboratory.cg_unLock_laboratory(index)
    --if not Socket.socketServer then return end
	nmsg_laboratory.cg_unLock_laboratory(Socket.socketServer,index )
    
end
--请求升级bten为是否为十连
function msg_laboratory.cg_train(index ,type ,bten)
    --if not Socket.socketServer then return end
	nmsg_laboratory.cg_train( Socket.socketServer,index ,type ,bten )
end
--是否保存
function msg_laboratory.cg_save(index,bsave)
    --if not Socket.socketServer then return end
	nmsg_laboratory.cg_save( Socket.socketServer,index ,bsave )
end

-- 返回所有研究数据
function msg_laboratory.gc_sync_all_laboratory_data(laboratory_data)    
    --local show = PublicFunc.GetErrorString(result);
    --if show then
    g_dataCenter.Institute:setunlockindex()
    if laboratory_data then
        for k,v in pairs(laboratory_data)do
            g_dataCenter.Institute:SetData(v.nIndex,v)
        end
    else
       app.log("laboratory_data is nil") 
    end
    
    PublicFunc.msg_dispatch(msg_laboratory.gc_sync_all_laboratory_data)
    --end
end

--更新研究数据
function msg_laboratory.gc_update_laboratory_data(laboratory_data)
    --app.log("gc_update_laboratory_data############"..table.tostring(laboratory_data))
    --for k,v in pairs(laboratory_data) do
    g_dataCenter.Institute:updata(laboratory_data.nIndex,laboratory_data)  
    --end
    --PublicFunc.msg_dispatch(msg_laboratory.gc_unLock_laboratory)
end

function msg_laboratory.gc_unLock_laboratory( result,index )
    local show = PublicFunc.GetErrorString(result);
    if show then
        g_dataCenter.Institute:unLock( index )
        PublicFunc.msg_dispatch(msg_laboratory.gc_unLock_laboratory)
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Institute_Unlock);
    end
end
--返回升级
function msg_laboratory.gc_train(result,index,type,bten)
    --app.log("#################gc_traingc_train#######################")
    
    local show = PublicFunc.GetErrorString(result);
    if show then
        --g_dataCenter.Institute:NoticeUI() -- 成功后通知UI
        --PublicFunc.msg_dispatch(msg_laboratory.gc_train)
        PublicFunc.msg_dispatch(msg_laboratory.gc_train)
    end
end
--返回保存
function msg_laboratory.gc_save(result,index,bSave)
    --app.log("#################gc_save#######################")
    --PublicFunc.msg_dispatch(msg_laboratory.gc_save)
    local show = PublicFunc.GetErrorString(result);
    if show then
        --g_dataCenter.Institute:NoticeUI() -- 成功后通知UI
        --PublicFunc.msg_dispatch(msg_laboratory.gc_save)
        PublicFunc.msg_dispatch(msg_laboratory.gc_save)
    end
end

return msg_laboratory;

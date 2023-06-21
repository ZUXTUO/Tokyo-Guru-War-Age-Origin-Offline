msg_xunzhaolishi = msg_xunzhaolishi or {}

--请求自己数据
function msg_xunzhaolishi.cg_request_my_data()
    app.log("cg_request_my_data######################")
    --if not Socket.socketServer then return end
        nmsg_xunzhaolishi.cg_request_my_data(Socket.socketServer);
end

--请求记录数据
function msg_xunzhaolishi.cg_request_report()
    
    --if not Socket.socketServer then return end
        nmsg_xunzhaolishi.cg_request_report(Socket.socketServer);
    
end

--开始 or 复位
function msg_xunzhaolishi.cg_reset()
    
    --if not Socket.socketServer then return end
        nmsg_xunzhaolishi.cg_reset(Socket.socketServer);
        
end

--选取第几个坑
function msg_xunzhaolishi.cg_open(index)
    --if not Socket.socketServer then return end
        nmsg_xunzhaolishi.cg_open(Socket.socketServer,index);
end

function msg_xunzhaolishi.gc_request_my_data(joinTimes,VecOpenData,vecAllItem)
    --app.log("joinTimes######################################"..tostring(joinTimes))
    --app.log("gc_request_my_data######### VecOpenData #######"..table.tostring(VecOpenData))
    --app.log("gc_request_my_data######### vecAllItem #######"..table.tostring(vecAllItem))
    g_dataCenter.GuildFindLs:Init()
    g_dataCenter.GuildFindLs:setNumber(joinTimes)
    g_dataCenter.GuildFindLs:setOpenData(VecOpenData)
    g_dataCenter.GuildFindLs:setAllData(vecAllItem)
    
    PublicFunc.msg_dispatch(msg_xunzhaolishi.gc_request_my_data)
    
end

function msg_xunzhaolishi.gc_request_report(reportlist)
    --app.log("gc_request_report########### vecAllItem #####"..table.tostring(reportlist))
    g_dataCenter.GuildFindLs:addReport(reportlist)
    PublicFunc.msg_dispatch(msg_xunzhaolishi.gc_request_report,reportlist)
end

--返回复位
function msg_xunzhaolishi.gc_reset(result,vecAllItem)
    --app.log("gc_reset########### vecAllItem #####"..table.tostring(vecAllItem))
    local show = PublicFunc.GetErrorString(result);
    if show then
        --g_dataCenter.GuildFindLs:addNumber()
        g_dataCenter.GuildFindLs:setAllData(vecAllItem)
        PublicFunc.msg_dispatch(msg_xunzhaolishi.gc_reset)
    end
end

function msg_xunzhaolishi.gc_open(result,index,item)
    
    local show = PublicFunc.GetErrorString(result);
    --app.log("gc_open######################"..tostring(result))
    
      -- g_dataCenter.GuildFindLs:addReport(index,item)
    PublicFunc.msg_dispatch(msg_xunzhaolishi.gc_open,index,item,result)
    


end

return msg_xunzhaolishi;
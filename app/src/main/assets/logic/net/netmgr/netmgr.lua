local net = {};
netmgr = net;
net.isInit = false;

net.basicDataIsOk = true;
net.isReconnect = false;

net.timeOutReq = nil;

function net.init()
	if net.isInit then
	    do return end;
	end
	net.isInit = true; 
	net.cgQueue  = {};
	net.seqnumlist = {};
    net.currentcg = nil;
    net.currentid = nil;
    net.currentseq_num = nil;
	net.gcNotifyQueue = {};
	net.reconnectDelete = {};
	net.havesendmsg = false;
	--net.processTimeId = timer.create("netmgr.process",60,-1)
        
    net.processPingTimeId = nil;
    net.ProcessUITimeId = nil;
    
    net.MaxExt_data = {};
end

function net.on_send( client, msg_id, ... )
    --if idCode > 0 then
        --if net.currentcg then
        --local idCode = cg.idCode
        --app.log("##############onsend cg.idCode...."..tostring(idCode))

        --Èç¹û˜ËÖ¾é_†¢£¬„t²»ÔÊÔSƒÉ´Î°lËÍÏàÍ¬µÄ…f×h
        --net.havesendlist[idCode] = true
        --end
    --end
end


function net.send(cg,idCode,msg_id)
   
    --net.currentcg = cg
    
    --local idCode = cg.idCode
   
    if cg then
        if net.cgQueue[idCode] == nil then
            if cg:getAlone() then
                for k,v in pairs(net.cgQueue) do
                    if v:getCall() == cg:getCall() then
                        app.log("chongfu xiangtong xie yi")
                        break;
                    end
                end
            else
                --app.log("============NetMgr.add####################"..tostring(idCode))
                net.cgQueue[idCode] =  cg
                table.insert(net.seqnumlist,idCode)
                
                net.HidePingUITime()
                if GuideManager and GuideManager.IsGuideRuning() and Socket.guide_care_msg_id[msg_id] then
                    GLoading.Show(GLoading.EType.msg)
                    if NoticeManager then
                        NoticeManager.Notice(ENUM.NoticeType.GuideCareMsgSend, msg_id)
                    end
                elseif not Socket.IsShowDialog then
                    if not Socket.IsSilence and not Socket.silence_msg_id[msg_id] then
                        GLoading.Show(GLoading.EType.msg,nil,nil,true)
                    end
                end
                --net.havesendlist[idCode] = true
                --net.havesendlist[idCode] = msg_id
            end
        end
    
        --app.log("send.seqnumlist........"..table.tostring(net.seqnumlist))
    end
    
    
         
end

function net.setSendMsgState( value )
    net.havesendmsg = value
end

function net.getSendMsgState()
    return  net.havesendmsg   
end

function net.receive(seq_num)
    if seq_num then
        if net.cgQueue[seq_num] then
            
            local index = 1;
            
            for k,v in pairs(net.seqnumlist) do
                if v == seq_num then
                    index = k
                    break;
                end   
            end   
            
            --app.log("========receive=====index:.."..tostring(index))
            
            --net.havesendlist[seq_num] = false
            
            table.remove(net.seqnumlist,index)

            local msg_id = net.cgQueue[seq_num]:getCall()
            if not Socket.silence_msg_id[msg_id] then
                app.log_warning("net.receive loading "..tostring(msg_id))
                GLoading.Hide(GLoading.EType.msg)
            end
            if Socket.guide_care_msg_id[msg_id] then
                if NoticeManager then
                    NoticeManager.Notice(ENUM.NoticeType.GuideCareMsgReceive, msg_id)
                end
            end

            net.cgQueue[seq_num] = nil;        
        end
    end
    
   --app.log("receive.seqnumlist........"..table.tostring(net.seqnumlist))
end

function net.registercg(msgid,ext_data)
    
    --if not net.isCanNotifyQueue(ext_data) then
    
    --app.log("net.gcNotifyQueue:"..tostring(ext_data))
    
    -- TODO: 
    --table.insert(net.gcNotifyQueue,{msg_id = msgid, ext_data = ext_data})
    
    --app.log("NotifyQueuelist==========="..table.tostring(net.getgcNotifyQueue()))
    
    net.MaxExt_data[msgid] = ext_data
end

function net.getgcNotifyQueue()
    return  net.gcNotifyQueue
end

function net.isCanNotifyQueues( msgid,idcode )
    --if idcode < net.MaxExt_data then
    --    return true
    --else
    --    return false 
    --end
    
    if net.MaxExt_data[msgid] then
        if net.MaxExt_data[msgid] > idcode then
            return true
        else
            return false 
        end
    else
        return false 
    end
    
end

function net.isCanNotifyQueue( idCode )
    for k,v in pairs(net.gcNotifyQueue) do
        if v.ext_data == idCode then
            return true
        end
    end
    
    return false
end

function net.process(p)
    --app.log("==============net.process======================")
    --do return end
    --
    ----ÍøÂç¶Ï¿ª ²»´¦Àí
    --if g_net_is_disconnect then
    --    do return end
    --end
    --
    --if Socket.m_is_reconnecting then
    --    --Èç¹ûÕýÔÚÖØÁ¬ Ôò²»×ö²Ù×÷
    --    --app.log("====Socket.m_is_reconnecting==="..tostring(Socket.m_is_reconnecting))
    --else
        
        --for i=1,#net.seqnumlist do
        --    --app.log("#net.seqnumlist"..table.tostring(net.seqnumlist[i]))
        --    if net.seqnumlist[i] then
        --        local cg = net.cgQueue[net.seqnumlist[i]]
        --        if cg then
        --            if net.havesendlist[net.seqnumlist[i]] then
        --                --app.log("havesendlist############### True")
        --                --ÕýÔÚ·¢ËÍµÄÐ­Òé ²»ÖØÐÂ·¢ËÍ
        --            else
        --                cg:send()
        --            end
        --        end
        --    end
        --end
    --end
    
    
    
end

function net.reconnectDel ()
    --net.processTimeId = timer.create("netmgr.process",60,-1)
    
    --Èç¹ûÓÐ¹æÔòµÄ»° Òª×öÒ»¸ö¹æÔòµÄÌØÊâ´¦Àí
    
    
    for i=1,#net.seqnumlist do
        --app.log("#net.seqnumlist"..table.tostring(net.seqnumlist[i]))
        if net.seqnumlist[i] then
            local cg = net.cgQueue[net.seqnumlist[i]]
            if cg then
                --if net.havesendlist[net.seqnumlist[i]] then
                    --app.log("havesendlist############### True")
                    --ÕýÔÚ·¢ËÍµÄÐ­Òé ²»ÖØÐÂ·¢ËÍ
                --else
                cg:send()
                --end
            end
        end
    end
    
    
end

function net.ShowPingUITime()
    
    if net.processPingTimeId == nil then
        net.processPingTimeId = timer.create("net.ShowLoadingUi", 5000, 1);
    end
end

function net.ShowLoadingUi()
    GLoading.Show(GLoading.EType.msg)  
end

function net.HideLoadingUi()
    GLoading.Hide(GLoading.EType.msg)  
end

function net.HidePingUITime()
    
    if net.processPingTimeId then
        
        timer.stop(net.processPingTimeId);
        net.processPingTimeId = nil;
        net.HideLoadingUi()
    end
end

function net.ShowProcessUITime()
    net.HidePingUITime()
    
    if net.ProcessUITimeId == nil then
        
    end
end

function net.HideProcessUITime()
    if net.ProcessUITimeId then
        timer.stop(net.ProcessUITimeId);
        net.ProcessUITimeId = nil;  
    end
end

function net.reconnectDelCombinRes(idCode)
	net.resQueue[idCode] = nil;
end

-- -- 100 - 200, > 3000
function net.IsBlacklist(msgid)
    
    if msgid > 3000 or (msgid >= 100 and msgid <= 200) then
        return false
    end
    
    return true 
end

function net.getMaxPriority ()
	local req = nil;
	local priority = 0;
	for k,v in pairs(net.reqQueue) do
		if priority == 0 or v:getPriority() < priority then
			req = v;
			priority = v:getPriority();
		end

	end

	return req;
end

function net.isHaveSend(sendName)
	local isHave = false;
	for k,v in pairs(net.reqQueue) do
		local name = v:getCall();
		if sendName == name then 
			isHave = true;
			break;
		end
	end
	return isHave;
end


function net.getTimeOutReq()
	net.timeOutReq  = net.getMaxPriority();
	return net.timeOutReq ;
end


function net.setTimeOutReq(value)
	net.timeOutReq = value;
end

function net.completeReconnect()
    g_reconnect.m_isShowHideMask = false;
    netmgr.isReconnect = false;
end


function net.clear()
    net.seqnumlist = {};
	net.isInit = false; 
	net.reqQueue  = {};
	net.resQueue = {};
	--net.resNotifyQueue = {};
	net.reconnectDelete = {};
	net.sendPriorty = 1;
	--gtime.stop(net.processTimeId)
	--net.timeOutReq = nil;

    net.MaxExt_data = {};
end


net.init();

--网络管理--请求对象
local cg = {};
netmgr.cg = cg;

function cg:init(call,para,idCode,rule)
    --网络连接引用
    self.client = Socket.socketServer;
    --唯一标识符
    self.idCode = idCode;
    --发送id，字符串类型
    self.call = call;
    --发送参数
    self.para = para;
    --接受的gc的规则
    self.rule = rule;
    --发送时间，用来做超时判断
    self.sendTime = 0;
    --发送优先级，默认以逻辑层发送次序从先到后
    self.priority = 0;
    --是否允许发送
    self.isSend = true;
    --是否返回的gc已经通知逻辑层
    self.isNotify = false;
    --是否超时过
    self.isTimeout = false;

    self.highAuth = nil;

    self.isShowMask = true;

    --是否允许下个发送协议为相同的协议  默认false为可以发送
    self.isAlone = false;
    
    --是否允许收到服务器主动推送的协议后，再向服务器发送一条确认协议 默认false为不发送
    self.isRecall = false;

    --重连后需要等待的数据
    -- 0 全部数据   9 只等待角色缓存数据  1 宠物数据   2 背包数据   3 仓库数据   4 时装数据   5 礼物箱数据  6  好友数据
    self.waitData = 0;

    --协议返回时，是否是拆分成多条返回的
    self.isNeedSplit = false;
    
    --self.idCode = 1;
	
end

--【call 请求的协议id，必须参数】
--【para 传递的参数，如果没有设置为空，如果有，则以table的形式传递】
--【highAuth 高优先级的协议，则优先处理,需要的优先级越高，highAuth越大】
--【rule 断线重连规则，为空的话，则为默认规则】
function cg:new(call,para,idCode,highAuth,rule)

	if not call and type(call) ~= "function" then 
		 log.error("----------netmgr request call para error!!!!!");
		 do return end;
	end
	if para and type(para) ~= "table" then 
		 log.error("-----------netmgr request para para error!!!!!");
		 do return end;
	end

	local o = {};
	setmetatable(o,{__index = self});
	para = para or {};
	rule = rule --or netmgr.rule:new();
	o:init(call,para,idCode,rule);
	o.highAuth = highAuth;
	return o;
end


--【协议发送】
function cg:send()

	--网络套接字为空，不发送协议
	self.client = Socket.get_socketgame();
	
	if not self.client then 
		app.log("--------------- netmgr req client is nil !!!!");
	end
        
        app.log("resend msg id:...."..self.call)
        app.log("resend msg ExtData:...."..self.idCode)
        netmgr.setSendMsgState(true)
        gnet.set_next_ext_data(self.client,self.idCode)
        --gnet.send(self.client,self.call,unpack(self.para))
        netmgr.setSendMsgState(false)
        
--	if self.call and self.call ~= "" and self.isSend then 
--            --loadstring 只能访问全局变量
--            --self.isSend = false;
--            netmgrSendClient = self.client;
--            netmgrSendPara = {};
--            
--            local sendMenthodStr = self.call.."(netmgrSendClient";
--            for i,v in ipairs(self.para) do
--                netmgrSendPara[i] = v;
--                sendMenthodStr = sendMenthodStr..",netmgrSendPara["..i.."]";
--            end
--            sendMenthodStr = sendMenthodStr..")";
--            
--            local function checkInGameReconnect(methodStr)
--                --=发送协议
--                local sendMethod = loadstring(methodStr);
--                
--                if sendMethod then
--                    local idCode = Socket.genIdCode()
--                    --app.log("idCode ==============="..tostring(self.idCode))                    
--                    gnet.set_next_ext_data(Socket.socketServer,self.idCode)
--                    sendMethod();
--                    --netmgr.on_send(self)
--                end	
--            end
--
--            --发送协议
--            --checkInGameReconnect(sendMenthodStr)
--            app.log("---------netmgr send cg:"..sendMenthodStr);
--            Socket.checkReqMessageToServer(checkInGameReconnect,sendMenthodStr)
--
--	end
end

function cg:setIdCode(value)
    
end


function cg:getIdCode()
        
end

function cg:getPriority()
	return self.priority;
end

function cg:setPriority(value)
	if value then 
		self.priority = value;
	end
end

function cg:getRule()
	return self.rule;
end

function cg:setSendTime(time)
	if time then 
		self.sendTime = time;
	end
end

function cg:getSendTime()
	return self.sendTime;
end

function cg:setIsSend(bool)
	if bool ~= nil then 
		self.isSend = bool;
	end
end

function cg:getIsSend()
	return self.isSend;
end

function cg:setIsNotify(bool)
	if bool ~= nil then 
		self.isNotify = bool;
	end
end

function cg:getIsNotify()
	return self.isNotify;
end

--【设置参数】
function cg:setPara(para)
	if not para or table.getall(para) then 
		do return end;
	end
	self.para = para;
end

--【设置规则】
function cg:setRule(rule)
	if not rule then 
		self.rule = rule;
	end
end

function cg:setIsTimeOut(bool)
	if bool ~= nil then 
		self.isTimeout = bool
	end
end

function cg:getIsTimeOut()
	return self.isTimeout;
end

function cg:reSetClient()
	self.client = yt_g_fGetClient();
end

function cg:getHighAuth()
	return self.highAuth;
end

function cg:setShowMask(bool)
	if bool ~= nil then 
		self.isShowMask = bool;
	end
end

function cg:getShowMask()
	return self.isShowMask;
end


function cg:getAlone()
	return self.isAlone;
end

function cg:setAlone(bool)
	if bool ~= nil then 
		self.isAlone = bool;
	end
end

function cg:getCall()
	return self.call;
end

function cg:setWaitData(value)
    if value then 
        self.waitData = value;
    end
end

function cg:getWaitData()
    return self.waitData;
end

function cg:setIsNeedSplit(value)
	if value then 
		self.isNeedSplit = value;
	end
end

function cg:getIsNeedSplit()
	return self.isNeedSplit;
end


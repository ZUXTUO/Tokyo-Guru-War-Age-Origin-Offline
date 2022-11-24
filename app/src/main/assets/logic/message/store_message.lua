msg_store = msg_store or {}

-- 临时变量, 是否使用本地数据
local isLocalData = true

msg_store.pay_id_call_back = nil;--[[得到支付ID回调]]
function msg_store.cg_get_pay_id(call_back)
	if msg_store.pay_id_call_back ~= nil then return false end;
	if type(call_back) == "function" then
		msg_store.pay_id_call_back = call_back;
		--[[MSG]]
		return true;
	else
		return false;
	end
end

function msg_store.gc_get_pay_id(result,id)
	if msg_store.pay_id_call_back ~= nil then
		msg_store.pay_id_call_back(id);
	end
end

--请求商城信息
function msg_store.cg_request_store_data()
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		gc_sync_store_data.cg()
	else
		--if not Socket.socketServer then return end
		if AppConfig.script_recording then
			PublicFunc.RecordingScript("nmsg_store.cg_request_store_data(robot_s)")
		end
		nmsg_store.cg_request_store_data(Socket.socketServer)
	end
end

--购买物品
function msg_store.cg_buy_store_goods(index, id, num, price, discount,appId,serverId,accountId,charId,payType,secondType,bill,ext)
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		-- No
	else
		--if not Socket.socketServer then return end
		nmsg_store.cg_buy_store_goods(Socket.socketServer, index, id, num, price, discount,appId,serverId,accountId,charId,payType,secondType,bill,ext);
	end
end

--领取VIP奖励
function msg_store.cg_get_vip_rewards(level, crystalNum)
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		-- No
	else
		--if not Socket.socketServer then return end
		nmsg_store.cg_get_vip_rewards(Socket.socketServer, level, crystalNum)
	end
end

--兑换码兑换东西
function msg_store.cg_redeem_item(redeem_code)
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		-- No
	else
		--if not Socket.socketServer then return end
		nmsg_store.cg_redeem_item(Socket.socketServer, redeem_code)
	end
end

--同步商城信息
function msg_store.gc_sync_store_data(rebateData, listInfo)
	GLoading.Hide(GLoading.EType.msg)
	g_dataCenter.store:SetStoreDataList(listInfo);

	-- app.log("msg_store.gc_sync_store_data>"..table.tostring(listInfo));

	PublicFunc.msg_dispatch(msg_store.gc_sync_store_data, rebateData, storeCardList);

	--[[IAP]]
	if iap then
		iap.init();
	end
end

--[[	//腾讯SDK操作：查询余额  type:"qq" or "wx",
	//loop:0：单次调用  1：2分钟内间隔15秒调用]]
function msg_store.cg_tencent_balance(loop, type, openId, openkey, pf, pfKey)
	if loop == nil or type == nil or openId == nil or openkey == nil or pf == nil or pfKey == nil then return end;
	nmsg_store.cg_tencent_balance(Socket.socketServer, loop, type, openId, openkey, pf, pfKey);
end

--[[	//腾讯SDK操作：扣除游戏币 type:"qq" or "wx"
	//amt：扣游戏币数量，amt不能为0。
	//order_id自定义订单号]]
function msg_store.cg_tencent_pay(amt, order_id, type, openId, openkey, pf, pfKey)
	if amt == nil or amt == 0 or order_id == nil or type == nil or openId == nil or openkey == nil or pf == nil or pfKey == nil then return end;
	nmsg_store.cg_tencent_pay(Socket.socketServer, amt, order_id, type, openId, openkey, pf, pfKey);
end

--[[//腾讯SDK操作：查询余额 返回]]
function msg_store.gc_tencent_balance(rst)
	app.log("腾讯SDK操作：查询余额 返回="..rst);
	if PublicFunc.GetErrorString(rst) then
	end
end
--[[//腾讯SDK操作：扣除游戏币 返回]]
function msg_store.gc_tencent_pay(rst,msg,money,orderid)
	app.log("腾讯SDK操作：扣除游戏币 返回="..rst);
	if PublicFunc.GetErrorString(rst) then
	end

	if rst == 1004 then
		HintUI.SetAndShow(EHintUiType.two,"余额不足！请进行充值！",
			{str = "充值", func = UserCenter.r_pay_id_call_back},{str = "取消", func = Root.empty_func});
		return;
	end

	if rst == 1018 then
		HintUI.SetAndShow(EHintUiType.two,"登陆校验失败！重新登陆！",
			{str = "是", func = GameBegin.usercenter_logout_callback},{str = "否", func = Root.empty_func});
		return;
	end

	if rst == 0 then
		UserCenter.tencent_pay_call_back(rst,msg,money,orderid);
	end
end

--[[IAP
-- 	//ios: state：状态2购买完成，key：索引，productid：物品ID，id：苹果订单ID，receipt：订单串
	cg_iap_ios_pay(int state,string key, string productid,string id, string receipt);
-- ]]
function msg_store.cg_iap_ios_pay(state,key, productid,id, receipt)
	app.log("msg_store.cg_iap_ios_pay key ="..key..",id="..id);
	nmsg_store.cg_iap_ios_pay(Socket.socketServer,state, key, productid, id, receipt);
end




--购买物品返回
function msg_store.gc_buy_store_goods_rst(ret)
	GLoading.Hide(GLoading.EType.msg);
	if PublicFunc.GetErrorString(ret) then
		PublicFunc.msg_dispatch(msg_store.gc_buy_store_goods_rst)
	end
	--临时处理：重新拉一次数据
	msg_store.cg_request_store_data()
end

--支付单号
function msg_store.gc_push_pay_order(buy_order_id, json_str)
	UserCenter.pay_id_call_back(buy_order_id,json_str);
end

--删除物品
function msg_store.gc_del_store_goods(index)
	g_dataCenter.store:DeleleStoreData(index)
	PublicFunc.msg_dispatch(msg_store.gc_del_store_goods, index)
end

--领取VIP奖励
function msg_store.gc_get_vip_rewards_rst(ret, level)
	GLoading.Hide(GLoading.EType.msg)
	if PublicFunc.GetErrorString(ret) then
		PublicFunc.msg_dispatch(msg_store.gc_get_vip_rewards_rst, level)
	end
end

--兑换码兑换返回
function msg_store.gc_redeem_item_ret(result, redeem_code, items, redeem_name)
	GLoading.Hide(GLoading.EType.msg)
    --app.log('redeem_code:' .. tostring(redeem_code))
    --app.log('get items:' .. table.tostring(items))
    --app.log('redeem_name:' .. tostring(redeem_name))
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return;
    else
    	PublicFunc.msg_dispatch(msg_store.gc_redeem_item_ret, result, redeem_code, items, redeem_name);
    end
end

--[[	//IOS订单返回 ios: state：0完成，key：索引，productid：物品ID，id：苹果订单ID，
	gc_iap_ios_pay(int state,string key, string productid,string id);]]
function msg_store.gc_iap_ios_pay(state,key, productid,id)
	app.log("msg_store.gc_iap_ios_pay, state="..state..",key = "..key..",productid="..productid..",id="..id);
end

--[[//IAP
	//IOS:消耗已经加过钱的订单:KEY与ID都是客户端传上去的，原样返回，IOS：两个值，android只有ID
	gc_iap_pruchase(string key,string id);]]
function msg_store.gc_iap_pruchase(key,id)
	app.log("msg_store.gc_iap_pruchase key="..key..",id="..id);
	if iap then
		iap.consume(id,key);
	end
end

return msg_store

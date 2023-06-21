--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/8/10
-- Time: 14:54
-- To change this template use File | Settings | File Templates.
--

iap = {
	is_first_buy_callback = true;--[[是不是第一次购买]]
	is_init = false;--[[是否初始化成功]]
	is_can_buy = false;--[[是否能购买]]
	is_request_products = false;--[[是否初始化商品例表 android因为不需要初始化默认为true]]
	is_get_products = false;--[[是否能得到商品例表信息]]

	--[[服务器只有index id，IAP是用string,所以需要自己组装一次]]
	id_title_ios = "com.digitalsky.ghoul.cn.gold_";
	id_title_android = "";

	--[[数据]]
	--[[商品ID LIST
		{
			[1] = "com.digitalsky.ghoul.cn.gold_1";
			[2] = "com.digitalsky.ghoul.cn.gold_2";
		}
	-- ]]
	products_id_list = {};

	--[[订单：购买完成或失败
	{
		-- 1:正在交易。这状态发生在，刚提交购买，设备正在与apple服务器通讯过程中。
		-- 2:购买完成。此状态指当前交易完成，这时需要把收据(spay_transaction.receipt)发送到服务器上面做验证。
		-- 3:购买失败。需要提示用户
		-- 4:restored。游戏中可不理会此值，指产品需要恢复。

		state = 2;
		errorinfo = "";
		key = "123"; --有可能这个值变了，但其他值都与另一个定单重复！ 需要特定处理。
		productId = "com.digitalsky.ghoul.cn.gold_1";
		id = "1000000000123123";
		errorCode = -1;
		productQuantity = 1;
		receipt = "asdfkljasldfjlasjldfjasljd";
	}
	-- ]]
	pruchase_data = {};

	--[[商品信息
		{
			currency_unit = "CNY";
			identifier = "com.digitalsky.ghoul.cn.gold_1";
			title = "钻石";
			price = 648;
			description = "6480钻石，内含6480钻石";
		}
	-- ]]
	products_info_data = {};

--[[
		{
			[1] = "com.digitalsky.ghoul.cn.gold_1";
			[2] = "com.digitalsky.ghoul.cn.gold_2";
		}
-- ]]
	products_valid_data = {};
	products_not_valid_data = {};
};

--[[设置ID LIST]]
function iap.set_id_list()
	if not g_dataCenter then
		app.log("g_dataCenter = nil");
		return false;
	end
	if not g_dataCenter.store then
		app.log("g_dataCenter.store = nil")
		return false;
	end
	local t_temp = g_dataCenter.store:GetPayDataList();
	if type(t_temp) == "table" then
		iap.products_id_list = {};
		for i=1,table.getn(t_temp) do
			--[[服务器只有index id，IAP是用string,所以需要自己组装一次]]
			if Root.get_os_type() == 8 then
				local temp = {};
				temp.index = t_temp[i];
				temp.fullname = iap.id_title_ios..t_temp[i];
				table.insert(iap.products_id_list,temp);
			else
				local temp = {};
				temp.index = t_temp[i];
				temp.fullname = iap.id_title_android..t_temp[i];
				table.insert(iap.products_id_list,temp);
			end
		end
		return true;
	end
	return false;
end

function iap.init()
	--[[是不是APPSTORE]]
	if not AppConfig.get_check_appstore() then
		app.log("can not usr iap!");
		return;
	end

	--[[如果连例表都没有就直接KO]]
	if not iap.set_id_list() then return end;

	spay.set_on_init("iap.init_call_back");
	spay.set_on_get_pruchase("iap.get_pruchase_call_back");
	spay.set_on_buy("iap.on_buy_call_back");
	spay.set_on_response_products("iap.response_products_call_back");

	--[[android特别处理]]
	if Root.get_os_type() == 11 then
		iap.is_request_products = true;
		iap.is_get_products = true;
	end

	--[[init]]
	if not iap.is_init then
		--[[不多次初始化，没有测试过多次初始化，所以先做这个设定]]
		spay.init_spay();
	end
end

--[[IAP系统是否准备OK，通过才可以购买物品]]
function iap.check()
	if iap.is_init and iap.is_can_buy and iap.is_request_products and iap.is_get_products then
		return true;
	else
		return false;
	end
end

--[[查看这个物品是否可以购买]]
function iap.check_porducts_id(id)
	if id == nil then return false end;
	app.log("@@@@@==check_porducts_id==="..id);

	do return true end;

	for k,v in pairs(iap.products_id_list) do
		if tostring(v.index) == tostring(id) then
			if Root.get_os_type() == 8 then
				app.log(v.index.."==@@@@@@@=="..v.fullname);
				--[[IOS]]
				for i,j in pairs(iap.products_valid_data) do
					app.log(j..">>>>>>>"..v.fullname);
					if tostring(j) == tostring(v.fullname) then
						app.log("有这个物品");
						return true;
					end
				end
				return false;
			else
				--[[android]]
				return true;
			end
			break;
		end
	end
	return false;
end

--[[得到全名]]
function iap.get_fullname(id)
	if id == nil then return "" end
	local fullname = "";
	for k,v in pairs(iap.products_id_list) do
		if tostring(v.index) == tostring(id) then
			fullname = v.fullname;
		end
	end
	return fullname;
end

--[[购买]]
function iap.buy(id,cb)
	if iap.check_porducts_id(id) then
		app.log("check_porducts_id  OK");
		local fullname = iap.get_fullname(id);
		if fullname ~= "" then
			spay.buy(fullname);
		end
	end
end

--[[得到有效的物品ID]]
function iap.get_products_valid_data()
	return iap.products_valid_data;
end
--[[得到有效的无效物品ID]]
function iap.get_products_not_valid_data()
	return iap.products_not_valid_data;
end

--[[消耗掉订单:IOS：两个值，android只有ID]]
function iap.consume(id,key)
	app.log("iap consume:"..key..">>>"..id);
	if id == nil or id == "" then return end;
	if key == nil then
		--[[andriod]]
		spay.consume(tostring(id));
	else
		--[[IOS]]
		spay.consume(tostring(id),tostring(key));
	end
end




-----------------------------------------------------内部方法----------------------------------------------------


function iap.init_call_back(b)
	if b then
		iap.is_init = true;--[[初始化成功]]
		if spay.can_payment() then
			iap.is_can_buy = true;--[[是否能购买]]
			--[[初始化商品例表]]
			iap.request_products();
		else
			iap.is_can_buy = false;
		end
	else
		iap.is_init = false;
	end
end

--[[初始化商品例表ID]]
function iap.request_products()
	if Root.get_os_type() ~= 8 then return end;
	local temp = "";
	for i=1, table.getn(iap.products_id_list) do
		if i == 1 then
			temp = iap.products_id_list[i].fullname;
		else
			temp = temp.."|@|"..iap.products_id_list[i].fullname;
		end
	end
	app.log("iap request_products="..temp);
	spay.request_products(temp);
end
--[[初始化商品例表CB，返回的是JSON]]
function iap.response_products_call_back(s_json)
	app.log("iap response_products_call_back="..s_json);

	iap.is_request_products = true;
	--[[
		--初始化商品例表
		{
			"valid" = {
				[1] = "com.digitalsky.ghoul.cn.gold_1";
				[2] = "com.digitalsky.ghoul.cn.gold_2";
			};
			"not_valid" = {
				[1] = "com.digitalsky.ghoul.cn.gold_1";
				[2] = "com.digitalsky.ghoul.cn.gold_2";
			};
		}
	-- ]]
	iap.products_valid_data = {};
	iap.products_not_valid_data = {};

	local temp_table = UserCenter.unpack(s_json);

	if temp_table.valid ~= nil then
		for i=1,table.getn(temp_table.valid) do
			table.insert(iap.products_valid_data,temp_table.valid[i]);
		end
	end

	if temp_table.not_valid ~= nil then
		for i=1,table.getn(temp_table.not_valid) do
			table.insert(iap.products_not_valid_data,temp_table.not_valid[i]);
		end
	end

	app.log("iap products_valid_data="..table.tostring(iap.products_valid_data));
	app.log("iap not_valid="..table.tostring(iap.products_not_valid_data));
end

--[[得到订单]]
function iap.get_purchase()
	if Root.get_os_type() == 8 then
		spay.get_purchase();
	end
end

--[[得到商品信息]]
function iap.get_products()
	if Root.get_os_type() == 8 then
		iap.is_get_products = true;
		iap.products_info_data = {};
		iap.products_info_data = spay.get_products();

		app.log("iap response_products_call_back="..table.tostring(t));
		--[[商品信息
            {
                currency_unit = "CNY";
                identifier = "com.digitalsky.ghoul.cn.gold_1";
                title = "钻石";
                price = 648;
                description = "6480钻石，内含6480钻石";
            }
        -- ]]
	end
end

--[[得到订单回调]]
function iap.get_pruchase_call_back(t)
	app.log("iap get_pruchase_call_back="..table.tostring(t));
	--[[
		--未处理购买完成的定单例表
		{
			-- 1:正在交易。这状态发生在，刚提交购买，设备正在与apple服务器通讯过程中。
			-- 2:购买完成。此状态指当前交易完成，这时需要把收据(spay_transaction.receipt)发送到服务器上面做验证。
			-- 3:购买失败。需要提示用户
			-- 4:restored。游戏中可不理会此值，指产品需要恢复。

			state = 2;
			errorinfo = "";
			key = "123";
			productId = "com.digitalsky.ghoul.cn.gold_1";
			id = "1000000000123123";
			errorCode = -1;
			productQuantity = 1;
			receipt = "asdfkljasldfjlasjldfjasljd";
		}
	-- ]]
	iap.pruchase_data = t;


--	--[[测试代码]]
--	if table.getn(iap.pruchase_data) > 0 then
--		app.log("订单数量大于0条，清理！")
--		for k,v in pairs(iap.pruchase_data) do
--			--[[消耗掉订单:IOS：两个值，android只有ID]]
--			iap.consume(tostring(v.id),tostring(v.key));
--		end
--	end

	--[[只保留标示为2的购买完成的订单,其他单子直接向APPSTORE处理掉]]
	for k,v in pairs(iap.pruchase_data) do
		if v.state ~= 2 then
			app.log(v.state..">>>>>无效");
			--[[向服务器进行验证:有效的订单信息  让服务器进行日志记录]]
			msg_store.cg_iap_ios_pay(v.state, tostring(v.key), tostring(v.productId), tostring(v.id), tostring(v.receipt));
			--[[消耗掉订单:IOS：两个值，android只有ID]]
			iap.consume(tostring(v.id),tostring(v.key));
		else
			app.log(v.state..">>>>>有效");
			--[[是不是公司平台SDK]]
			if AppConfig.get_check_digisky() then
				--[[公司支付信息]]
				UserCenter.digisky_ios_pay_goon(tostring(v.productId),tostring(v.id),tostring(v.key),tostring(v.receipt));
			else
				--[[向服务器进行验证]]
				msg_store.cg_iap_ios_pay(v.state, tostring(v.key), tostring(v.productId), tostring(v.id), tostring(v.receipt));
			end
		end
	end

		--[[测试代码]]
	if table.getn(iap.pruchase_data) >= 3 then
		app.log("订单数量大于3条，清理！");
		for k,v in pairs(iap.pruchase_data) do
			--[[消耗掉订单:IOS：两个值，android只有ID]]
			iap.consume(tostring(v.id),tostring(v.key));
		end
	end

end

--[[购买回调]]
function iap.on_buy_call_back(t)
	app.log(tostring(iap.is_first_buy_callback).."=iap on_buy_call_back="..table.tostring(t));
	if iap.is_first_buy_callback then
		iap.is_first_buy_callback  = false;
		--[[不处理，调用查订单来处理。]]
		app.log("第一次初始化，主动获取订单进行处理。");
		iap.get_purchase();
		return;
	end

	--[[

		--购买定单例表
		{
			-- 1:正在交易。这状态发生在，刚提交购买，设备正在与apple服务器通讯过程中。
			-- 2:购买完成。此状态指当前交易完成，这时需要把收据(spay_transaction.receipt)发送到服务器上面做验证。
			-- 3:购买失败。需要提示用户
			-- 4:restored。游戏中可不理会此值，指产品需要恢复。
			state = 1;
			productQuantity = 1;
			key = "123";
			productId = "com.digitalsky.ghoul.cn.gold_1";
			errorCode = -1;
		}

		--购买完成定单例表，INIT时会主动调用一次
		{
			-- 1:正在交易。这状态发生在，刚提交购买，设备正在与apple服务器通讯过程中。
			-- 2:购买完成。此状态指当前交易完成，这时需要把收据(spay_transaction.receipt)发送到服务器上面做验证。
			-- 3:购买失败。需要提示用户
			-- 4:restored。游戏中可不理会此值，指产品需要恢复。
			state = 2;--购买完成
			productQuantity = 1;
			key = "123";
			productId = "com.digitalsky.ghoul.cn.gold_1";
			id = "1000000000123123";
			errorCode = -1;
			receipt = "asdfkljasldfjlasjldfjasljd";
		}

		{
			-- 1:正在交易。这状态发生在，刚提交购买，设备正在与apple服务器通讯过程中。
			-- 2:购买完成。此状态指当前交易完成，这时需要把收据(spay_transaction.receipt)发送到服务器上面做验证。
			-- 3:购买失败。需要提示用户
			-- 4:restored。游戏中可不理会此值，指产品需要恢复。
			state = 3;
			errorInfo = "无法连接到iTunes Store";
			key = "123";
			productId = "com.digitalsky.ghoul.cn.gold_1";
			id = "1000000000123123";
			errorCode = -1;
			productQuantity = 1;
		}

	-- ]]

	--[[正常购买物品的订单处理]]
	for k,v in pairs(t) do
		app.log(k.."=订单信息="..table.tostring(v));

		--[[错误订单直接不处理]]
		if v.state == 1 or v.state == 4 then
			app.log(v.state..">>>>>不处理");
			return;
		end

		if v.state == 2 then
			app.log(v.state..">>>>>有效");
			--[[是不是公司平台SDK]]
			if AppConfig.get_check_digisky() then
				UserCenter.digisky_ios_pay_goon(tostring(v.productId),tostring(v.id),tostring(v.key),tostring(v.receipt));
			else
				--[[向服务器进行验证:有效的订单信息]]
				msg_store.cg_iap_ios_pay(v.state, tostring(v.key), tostring(v.productId), tostring(v.id), tostring(v.receipt));
			end
		elseif v.state == 3 then
			app.log(v.state..">>>>>无效");
			--[[向服务器进行验证:把错误信息也提交上去,让服务器进行日志记录]]
			msg_store.cg_iap_ios_pay(v.state, tostring(v.key), tostring(v.productId), tostring(v.id), "");
			--[[直接让APPSTORE消耗掉订单]]
			--[[消耗掉订单:IOS：两个值，android只有ID]]
			iap.consume(v.id,v.key);
		end

	end

end
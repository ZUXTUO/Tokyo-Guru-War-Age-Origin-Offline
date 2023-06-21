
StoreUI = Class('StoreUI', UiBaseClass)

function StoreUI.OnAnimationChangeBanner( )
	if StoreUI.cls then
		StoreUI.cls:ChangeBanner();
	end
end

local _animas = {
	[1] = "ui_4201_recharge_texture_effect1";
	[2] = "ui_4201_recharge_texture_effect2";
	[3] = "ui_4201_recharge_texture_effect3";
}

-------------------------------------local声明-------------------------------------
local _local = {}
_local.pathStroeUI = "assetbundles/prefabs/ui/shop/ui_4201_recharge.assetbundle";
_local.click_index = 0;--[[买的物品ID]]
_local.click_data = nil;--[[买的物品信息]]

_local.UIText = {
	[1] = "充值",--废弃
	[2] = "再充值",	-- 用了 美术字--废弃
	[3] = "升级到",	-- 用了 美术字--废弃
	[4] = "钻石",		-- 用了 美术字
	[5] = "VIP特权",	-- 用了 美术字--废弃
	[6] = "达到VIP%s时可以领取",--废弃
	[7] = "领取",--废弃
	[8] = "已领取",--废弃
	[9] = "¥",
	[10] = "[00ff00](%s/30)[-] ",--废弃
	[11] = "活动期间前充值返利%s%%，充值额度越高收益越高，是否购买？",	--废弃
	[12] = "额外赠送",
	[13] = "[973900FF]%d[-][000000FF]/%d[-]"--废弃
}

_local.TagName = {
	[ ENUM.EStoreCardMark.Recommend ] = "推荐",
	[ ENUM.EStoreCardMark.Abate ] = "打折",
	[ ENUM.EStoreCardMark.Hot ] = "热销",
	[ ENUM.EStoreCardMark.Quota ] = "限购",
	[ ENUM.EStoreCardMark.Interval ] = "限时",
}

--返回VIP等级的领取情况(true/false 已领取/未领取)
local function _GetVipRewardsState(level)
	return bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, level)) > 0
end

-------------------------------------外部调用-------------------------------------


-------------------------------------类方法-------------------------------------
--初始化
function StoreUI:Init(data)
	self.pathRes = _local.pathStroeUI
	UiBaseClass.Init(self, data);
end

--重新加载
function StoreUI:Restart(data)
	if data == "vip" then
		self.openVip = true;
	else
		self.selIndex = tonumber(data)
		self.openVip = false;
	end

	if data == "replace" then
		self.isReplaced = true
	end

	UiBaseClass.Restart(self, data)
end

--初始化数据
function StoreUI:InitData()
	UiBaseClass.InitData(self, data);

	if not StoreUI.cls then
		StoreUI.cls = self;
	end

	-- 取得最大VIP等级
	self.maxLevel = 0
	for i = 1, 100 do
		if ConfigManager.Get(EConfigIndex.t_vip_data,i) then self.maxLevel = i
		else break
		end
	end

	self.m_banner_timer = 0;
end

--注册方法
function StoreUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_vip_btn"] = Utility.bind_callback(self, self.on_vip_btn)
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_item_click"] = Utility.bind_callback(self, self.on_item_click)
	self.bindfunc["pay"] = Utility.bind_callback(self, self.pay)
	self.bindfunc["pay_back"] = Utility.bind_callback(self, self.pay_back)
	self.bindfunc["on_update_data"] = Utility.bind_callback(self, self.on_update_data)
	self.bindfunc["on_update_item_list"] = Utility.bind_callback(self, self.on_update_item_list)
	self.bindfunc["on_change_banner"] = Utility.bind_callback(self, self.on_change_banner)
end

--取消注册
function StoreUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function StoreUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_store.gc_del_store_goods, self.bindfunc["on_update_data"])
	PublicFunc.msg_regist(msg_store.gc_buy_store_goods_rst, self.bindfunc["on_update_data"])
	PublicFunc.msg_regist(msg_store.gc_sync_store_data, self.bindfunc["on_update_item_list"])
	PublicFunc.msg_regist(player.gc_update_player_store_card_info, self.bindfunc["on_update_data"])
end

--注销消息分发回调函数
function StoreUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_store.gc_del_store_goods, self.bindfunc["on_update_data"])
	PublicFunc.msg_unregist(msg_store.gc_buy_store_goods_rst, self.bindfunc["on_update_data"])
	PublicFunc.msg_unregist(msg_store.gc_sync_store_data, self.bindfunc["on_update_item_list"])
	PublicFunc.msg_unregist(player.gc_update_player_store_card_info, self.bindfunc["on_update_data"])
end

--初始化UI
function StoreUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("store_ui")

	self.storeCardList = g_dataCenter.store:GetStoreList(true)
	self.crystallItem = {}
	self.itemList = {}

	if self.isReplaced then
		self.pageIndex = self.pageIndex or 1
	else
		self.pageIndex = 1
	end
	self.isReplaced = nil
	
	self:InitControls()
	
	self:UpdateUi()

	--直接打开vip特权界面
	if self.openVip then
		uiManager:PushUi(EUI.VipPackingUI);
		-- uiManager:ReplaceUi(EUI.VipPrivilegeUI, math.max(1, g_dataCenter.player.vip))
	end
end

-- 初始化引用组件
function StoreUI:InitControls()
	if self.ui == nil then return end

	local path = 'center_other/animation/'
	local vipBtn = ngui.find_button(self.ui, path.."btn_chongzhi")
	vipBtn:set_on_click(self.bindfunc["on_vip_btn"])
	
	-- self.nodeCont1 = self.ui:get_child_by_name(path.."cont1")
	-- self.nodeCont2 = self.ui:get_child_by_name(path.."cont2")

	--VIP进度条
	-- self.vipProgress = ngui.find_progress_bar(self.nodeCont1, "pro_di")
	--VIP进度文字
	-- self.vipProgressText = ngui.find_label(self.nodeCont1, "pro_di/lab")
	--VIP当前等级
	-- self.vipLevelNow = ngui.find_label(self.nodeCont1, "sp_vip");
	--VIP下一等级
	-- self.vipLevelNext = ngui.find_label(self.nodeCont1, "content/lab_vip")
	--"升级到"
	-- self.vipText1 = ngui.find_label(self.nodeCont1, "content/txt1")
	--"还需要"
	-- self.vipText2 = ngui.find_label(self.nodeCont1, "content/txt2")
	--钻石数量
	-- self.vipText3 = ngui.find_label(self.nodeCont1, "content/txt2/lab")

	self.banner_anima = self.ui:get_child_by_name("center_other/animation/sp_effect_di/animation");
	self.m_cur_des_index = 1;
	-- self.big_title_txt = ngui.find_label(self.ui, "center_other/animation/sp_effect_di/animation/txt");
	self.tittle_info_txt = ngui.find_label(self.ui, "center_other/animation/sp_effect_di/animation/txt_money");
	self:UpdateBanner();

	self.m_banner_timer = timer.create(self.bindfunc["on_change_banner"], 5000, -1);
	self:on_change_banner()

	path = "center_other/animation/scroll_view/"
	self.scrollView = ngui.find_scroll_view(self.ui, path.."panel_list")
	self.wrapContent = ngui.find_wrap_content(self.ui, path.."panel_list/wrap_content")
	self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"]);

	local count = math.ceil(#self.storeCardList / 3)
	self.wrapContent:set_min_index(1-count);
    self.wrapContent:set_max_index(0);
    self.wrapContent:reset();
end

function StoreUI:on_change_banner(  )
	-- self.banner_anima:animated_play("ui_4201_recharge_texture_effect_chuxian");
	-- self.banner_anima:animated_play("ui_4201_recharge_texture_effect_xiaoshi");
	self.banner_anima:animated_play(_animas[math.random(1, #_animas)]);

end

function StoreUI:ChangeBanner( )
	if not self.m_big_des then
		self.m_big_des = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_store_big_title).data;
	end	
	self.m_cur_des_index = self.m_cur_des_index + 1;
	if self.m_big_des then
		if self.m_cur_des_index > #self.m_big_des then
			self.m_cur_des_index = 1;
		end
	end
	self:UpdateBanner();
end

function StoreUI:UpdateBanner( )
	-- if self.big_title_txt then
	-- 	self.big_title_txt:set_text("")
	-- 	if not self.m_big_des then
	-- 		self.m_big_des = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_store_big_title).data;
	-- 	end	
	-- 	if self.m_big_des and self.m_big_des[self.m_cur_des_index] then
	-- 		self.big_title_txt:set_text(tostring(self.m_big_des[self.m_cur_des_index]) or "");
	-- 	end
	-- end

	if self.tittle_info_txt then
		self.tittle_info_txt:set_text("");
		if not self.m_info_des then
			self.m_info_des = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_vip_store_title_info).data;	
		end
		if self.m_info_des and self.m_info_des[self.m_cur_des_index] then
			self.tittle_info_txt:set_text(tostring(self.m_info_des[self.m_cur_des_index]) or "");
		end
	end
end

--刷新界面
function StoreUI:UpdateUi()
	if self.ui == nil then return end

	local gplayer = g_dataCenter.player
	
	-- 已达到最大VIP等级
	if gplayer.vip == self.maxLevel then
		-- self.nodeCont1:set_active(false)
		-- self.nodeCont2:set_active(true)

		-- local maxVipText = ngui.find_label(self.nodeCont2, "sp_vip")
		-- PublicFunc.SetImageVipLevel(maxVipText, self.maxLevel)

		-- local config1 = ConfigManager.Get(EConfigIndex.t_vip_data, gplayer.vip)
		-- local config1 = g_dataCenter.player:GetVipData();
		-- local config2 = ConfigManager.Get(EConfigIndex.t_vip_data, gplayer.vip-1)
		-- local config2 = g_dataCenter.player:GetUpVipData();
		-- local maxLvNeedExp = config1.need_exp
		-- if maxLvNeedExp == 0 then
		-- 	maxLvNeedExp = config2.need_exp
		-- end
		-- self.vipProgress:set_value(gplayer.vipexp / maxLvNeedExp)
		-- self.vipProgressText:set_text(string.format(_local.UIText[13], gplayer.vipexp, maxLvNeedExp))
	else
		-- self.nodeCont1:set_active(true)
		-- self.nodeCont2:set_active(false)
		-- PublicFunc.SetImageVipLevel(self.vipLevelNow, gplayer.vip, true)
		-- self.vipLevelNext:set_text("V"..tostring(gplayer.vip+1))
		
		-- local config = ConfigManager.Get(EConfigIndex.t_vip_data,gplayer.vip)
		-- self.vipText3:set_text(tostring(config.need_exp - gplayer.vipexp))
		-- self.vipProgress:set_value(gplayer.vipexp / config.need_exp)
		-- self.vipProgressText:set_text(string.format(_local.UIText[13], gplayer.vipexp, config.need_exp))
	end
end

--显示界面
function StoreUI:Show()
	UiBaseClass.Show(self)
end

--隐藏界面
function StoreUI:Hide()
	UiBaseClass.Hide(self)
end

--销毁数据
function StoreUI:DestroyUi()
	self.isReplaced = nil
	self.itemList = nil

	if self.m_banner_timer and self.m_banner_timer > 0 then
		timer.stop(self.m_banner_timer);
		self.m_banner_timer = 0;
	end

	UiBaseClass.DestroyUi(self);
	StoreUI.cls = nil;
end

function StoreUI:on_update_item_list()
	self.storeCardList = g_dataCenter.store:GetStoreList()
	app.log("=== zzc on_update_item_list "..table.tostring(self.storeCardList))
	if self.itemList == nil then return end
	for k, v in pairs(self.itemList) do
		for kk, vv in pairs(v) do
			self:LoadItem(vv, vv.index)
		end
	end
end

function StoreUI:LoadItem(item, index)
	local data = self.storeCardList[index]
	if data and data.type ~= 3 then
		item.self:set_active(true)

		-- 商城物品icon路径
		item.spIcon:set_sprite_name(data.icon)
		-- 打折后的真实价格
		local realPrice = math.floor(data.price * data.discount / 100)
		item.labPrice:set_text(_local.UIText[9]..(realPrice/100)) -- 价格改成以分计
		item.labNumber:set_text(tostring(data.num).._local.UIText[4])

		local tag = data.tag
		local showDouble = false
		-- 非首次购买的推荐标签隐藏
		if data.buy_num == 0 and data.type == ENUM.EStoreCardType.CrystalItem then
			showDouble = true
		end

		if showDouble then
			-- item.labDouble:set_text(_local.UIText[12]..data.num)
			-- item.labDouble:set_active(true)
			item.spDouble:set_active(true)
			item.nodeExtra:set_active(true)
			item.labExtra:set_text(_local.UIText[12]..tostring(data.num).._local.UIText[4])
		else
			-- item.labDouble:set_active(false)
			item.spDouble:set_active(false)
			item.nodeExtra:set_active(false)
		end

		if tag > ENUM.EStoreCardMark.Null then
			-- item.tagName:set_text(_local.TagName[tag])
		else
			-- item.tagSprite:set_active(false)
		end

		item.btn:set_event_value("", index)
	else
		item.self:set_active(false)
	end
end

-------------------------------------本地回调-------------------------------------

function StoreUI:on_init_item(obj, b, real_id)

	for i=1, 3 do
		local index = math.abs(real_id)*3+i

		if self.itemList[b] == nil then
			self.itemList[b] = {}
		end
		if self.itemList[b][i] == nil then
			self.itemList[b][i] = {}
		end
		local item = self.itemList[b][i]
		
		if not next(item) then
			-- local item = {}
			item.self = obj:get_child_by_name("cont"..i)
			item.btn = ngui.find_button(item.self, item.self:get_name())
			item.labNumber = ngui.find_label(item.self, "lab")
			item.labPrice = ngui.find_label(item.self, "lab_num")
			item.spIcon	= ngui.find_sprite(item.self, "sp_icon")
			item.nodeExtra = item.self:get_child_by_name("sp_bk")
			item.labExtra = ngui.find_label(item.nodeExtra, "lab_gem")
			-- item.labDouble = ngui.find_label(item.self, "lab_xiangou")
			item.spDouble = ngui.find_sprite(item.self, "sp_di")
			item.btn:set_on_click(self.bindfunc['on_item_click'])
		end

		item.index = index

		self:LoadItem(item, index)
	end
end

--点击VIP按钮
function StoreUI:on_vip_btn()
	self.isReplaced = true
	uiManager:PushUi(EUI.VipPackingUI);
	-- uiManager:ReplaceUi(EUI.VipPrivilegeUI, "replace")
end

--点击商品项
function StoreUI:on_item_click(t)
	local index = t.float_value
	--[[存下购买对像]]
	_local.click_index = index;
	_local.click_data = self.storeCardList[index];

	--[[申请PAY]]
	self:pay();
end

--[[申请PAY]]
function StoreUI:pay()
	app.log("申请PAY");
	UserCenter.pay(_local.click_data.index,
		_local.click_data.id,
		_local.click_data.num,
		_local.click_data.price,
		_local.click_data.name,
		_local.click_data.discount,
		self.bindfunc["pay_back"]);
end

--[[购买回调:0与-1之外的值就是仅仅取消菊花]]
function StoreUI:pay_back(state)
	g_ScreenLockUI.Hide();
	GLoading.Hide(GLoading.EType.msg);

	if state == "0" then
		HintUI.SetAndShow(EHintUiType.zero, "充值成功");
	elseif state == "-1" then
        HintUI.SetAndShow(EHintUiType.zero, "充值失败");
	end
end

function StoreUI:ShowNavigationBar()
    return true
end

-------------------------------------网络回调-------------------------------------
-- 充值商品数据更新
function StoreUI:on_update_data()
	self:UpdateUi()
end

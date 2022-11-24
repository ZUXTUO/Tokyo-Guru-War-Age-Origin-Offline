--region vip_privilege_ui.lua
--Author : zzc
--Date   : 2016/5/20

VipPrivilegeUI = Class('VipPrivilegeUI', UiBaseClass)

VipPrivilegeUI.is_red_point = true;

VipPrivilegeUI.GetIsVipGift = function ( )
	local result = false;
	
	for i=1, g_dataCenter.player.vip do
		local isGet = bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, i)) > 0;
		if isGet == false then
			result = true;
			break;
		end
	end
	
	return result;
end

-------------------------------------local声明-------------------------------------
local _local = {}
_local.UIText = {
	[1] = "达到VIP%s时可以购买",
	[2] = "购买",
	[3] = "已购买",
	[4] = "尊贵特权",
	[5] = "超值大礼包",
	[6] = "[973900FF]%d[-][000000FF]/%d[-]",
	[7] = "充值"
}

--返回VIP等级的领取情况(true/false 已领取/未领取)
local function _GetVipRewardsState(level)
	return bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, level)) > 0
end

-------------------------------------外部调用-------------------------------------

-------------------------------------类方法-------------------------------------
--初始化
function VipPrivilegeUI:Init(data)
	
	self.pathRes = "assetbundles/prefabs/ui/shop/panel_shop.assetbundle";
	UiBaseClass.Init(self, data);

end

--重新加载
function VipPrivilegeUI:Restart(data)
	if data == "replace" then
		self.m_push_type = math.max(1, g_dataCenter.player.vip);
	else
		self.m_push_type = tonumber(data);
	end

	UiBaseClass.Restart(self, data);
end

--初始化数据
function VipPrivilegeUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

--注册方法
function VipPrivilegeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["on_vip_left_btn"] = Utility.bind_callback(self, self.on_vip_left_btn)
	self.bindfunc["on_vip_right_btn"] = Utility.bind_callback(self, self.on_vip_right_btn)
	self.bindfunc["on_vip_item_btn"] = Utility.bind_callback(self, self.on_vip_item_btn)
	self.bindfunc["on_vip_award_btn"] = Utility.bind_callback(self, self.on_vip_award_btn)
	self.bindfunc["on_vip_change"] = Utility.bind_callback(self, self.on_vip_change)
	self.bindfunc["get_vip_rewards"] = Utility.bind_callback(self, self.get_vip_rewards)

	self.bindfunc["go_to_store"] = Utility.bind_callback(self, self.go_to_store);
	self.bindfunc["on_vip_no"] = Utility.bind_callback(self, self.on_vip_no);
end

--取消注册
function VipPrivilegeUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function VipPrivilegeUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	NoticeManager.BeginListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"]);
	PublicFunc.msg_regist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--注销消息分发回调函数
function VipPrivilegeUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	NoticeManager.EndListen(ENUM.NoticeType.VipDataChange, self.bindfunc["on_vip_change"]);
	PublicFunc.msg_unregist(msg_store.gc_get_vip_rewards_rst, self.bindfunc["get_vip_rewards"])
end

--初始化UI
function VipPrivilegeUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_name("vip_privilege_ui")

	self.vipList = {}
	
	if self.m_push_type and self.m_push_type == 0 then
		for i=1, g_dataCenter.player.vip do
			local isGet = bit.bit_and(g_dataCenter.player.vip_reward_flag, bit.bit_lshift(1, i)) > 0;
			if isGet == false then
				self.curVipIndex = i;
				break;
			end
		end
	elseif self.m_push_type and self.m_push_type ~= 0 then
		self.curVipIndex = self.m_push_type;
	else
		self.curVipIndex = math.max(1, g_dataCenter.player.vip);
	end

	-- app.log("initui--curVipIndex = " .. self.curVipIndex);
	-- 取得最大VIP等级
	self.maxLevel = 0
	for i = 1, 100 do
		if ConfigManager.Get(EConfigIndex.t_vip_data,i) then self.maxLevel = i
		else break
		end
	end

	VipPrivilegeUI.is_red_point = false;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_VipGiftPack);
	
	self:InitControls()
	
	self:UpdateUi()
end

--初始化引用组件
function VipPrivilegeUI:InitControls()
	if self.ui == nil then return end
	
	-- vip提升后重置清除
	self:ClearAwardsItem()

	local path = 'vip_privilege_ui/center_other/animation/'

	self.cont1 = self.ui:get_child_by_name("center_other/animation/cont1");
	self.cont2 = self.ui:get_child_by_name("center_other/animation/cont2");
	--VIP进度条
	self.vipProgress = ngui.find_progress_bar(self.cont1, "pro_di")
	--VIP进度文字
	self.vipProgressText = ngui.find_label(self.cont1, "pro_di/lab")
	--VIP当前等级
	self.vipLevelNow = ngui.find_label(self.cont1, "sp_vip");
	--VIP下一等级
	self.vipLevelNext = ngui.find_label(self.cont1, "content/lab_vip")
	--钻石数量
	self.vipText3 = ngui.find_label(self.cont1, "content/txt2/lab")
	--钻石图片
	self.vipCrystal = ngui.find_sprite(self.cont1, "content/txt2/sp_hongshuijing");

	self.vipLevelMax = ngui.find_label(self.cont2, "sp_vip")

	--原价
	self.priceText = ngui.find_label(self.ui, path .. "content/cont3/txt1/lab");
	--打折价
	self.discountPriceText = ngui.find_label(self.ui, path .. "content/cont3/txt2/lab");

	--grid标题2
	self.lab_title = ngui.find_label(self.ui, path .. "content/cont1/sp_vip/txt"); 
	-- 超值大礼包
	self.vipLevelTitle = ngui.find_label(self.ui, path .. "content/cont2/sp_vip/txt");

	self.lblVip1 = ngui.find_label(self.ui, path .. "content/cont1/sp_vip");
	self.lblVip2 = ngui.find_label(self.ui, path .. "content/cont2/sp_vip");

	local vipBtnLeft = ngui.find_button(self.ui, path.."btn_left_arrows")
	local vipBtnRight = ngui.find_button(self.ui, path.."btn_right_arrows")
	vipBtnLeft:set_on_click(self.bindfunc["on_vip_left_btn"])
	vipBtnRight:set_on_click(self.bindfunc["on_vip_right_btn"])


	self.vipDesGrid = ngui.find_grid(self.ui, path.."content/scroll_view/panel/grid")
	self.vipDesItems = {}
	local gridObj = self.vipDesGrid:get_game_object()
	for i = 1, 20 do
		local itemName = string.format("cont1 (%d)", i - 1)
		local itemObj = gridObj:get_child_by_name(itemName)
		if itemObj then
			self.vipDesItems[i] = {}
			self.vipDesItems[i].self = itemObj
			self.vipDesItems[i].sp = ngui.find_sprite(itemObj,  "sp_rhombus")
			self.vipDesItems[i].lab = ngui.find_label(itemObj, "lab")
		end
	end

	self.btn_chongzhi = ngui.find_button(self.ui, path .. "btn_chongzhi");
	self.btn_chongzhi:set_on_click(self.bindfunc["go_to_store"]);
	self.btn_chongzhi_lab = ngui.find_label(self.ui, path .. "btn_chongzhi/animation/lab");
	self.btn_chongzhi_lab:set_text(_local.UIText[7]);

	self.sp_art_font = ngui.find_sprite(self.ui, path .. "content/sp_art_font");
	self.sp_art_font:set_active(false);
	
	self.btnVipAward = ngui.find_button(self.ui, path.."btn_buy")
	self.labVipAward = ngui.find_label(self.ui, path.."btn_buy/animation/lab")
	self.btnVipAward_bg = ngui.find_sprite(self.ui, path .. "btn_buy/sprite_background");
	local awards = {}
	local carditem = nil;
	for i = 1, 4 do
		awards[i] = {}
		awards[i].self = self.ui:get_child_by_name(path.."content/cont4/new_small_card_item"..i);
		carditem = CardProp:new({number = 1});
		awards[i].item = UiSmallItem:new({parent=awards[i].self, cardInfo = carditem, res_group=self.panel_name})
	end

	self.awards = awards
	
	-- self.btnVipAward:set_on_click(self.bindfunc["on_vip_award_btn"])
	self.labVipAward:set_text("")
end

--更新Vip特权页面
function VipPrivilegeUI:UpdateUi()
	if self.ui == nil then return end

	local gplayer = g_dataCenter.player
	local config = ConfigManager.Get(EConfigIndex.t_vip_data,gplayer.vip)
	local vip_config_all = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);

	local cVipExp = 0;
	local nVipExp = 0;
	local last_config = nil;
	if gplayer.vip < #vip_config_all then
		cVipExp = gplayer.vipexp;
		nVipExp = config.need_exp;
	else
		last_config = vip_config_all[gplayer.vip - 1];
		nVipExp = last_config.need_exp;
		if gplayer.vipexp <= last_config.need_exp then
			cVipExp = gplayer.vipexp;
		else
			cVipExp = last_config.need_exp;
		end
	end
	
	self.vipText3:set_text(tostring(config.need_exp - gplayer.vipexp))

	self.vipProgress:set_value(cVipExp / nVipExp);
	self.vipProgressText:set_text(string.format(_local.UIText[6], cVipExp, nVipExp));

	-- 已达到最大VIP等级
	if gplayer.vip == self.maxLevel then
		self.vipLevelNext:set_active(false)
		self.vipText3:set_active(false)
		self.vipCrystal:set_active(false)

		self.cont1:set_active(false);
		self.cont2:set_active(true);
		PublicFunc.SetImageVipLevel(self.vipLevelMax, self.maxLevel, true);
	else
		self.vipLevelNext:set_active(true)
		self.vipLevelNext:set_text("V"..tostring(gplayer.vip+1))
		self.vipText3:set_active(true)
		self.vipCrystal:set_active(true)

		self.cont1:set_active(true);
		self.cont2:set_active(false);
		PublicFunc.SetImageVipLevel(self.vipLevelNow, gplayer.vip, true);
	end

	PublicFunc.SetImageVipLevel(self.lblVip1, self.curVipIndex, true);
	PublicFunc.SetImageVipLevel(self.lblVip2, self.curVipIndex, true);

	local vipConfig = ConfigManager.Get(EConfigIndex.t_vip_data,self.curVipIndex)

	self.priceText:set_text(tostring(vipConfig.price));
	self.discountPriceText:set_text(tostring(vipConfig.discount_price));
	self.lab_title:set_text(_local.UIText[4]);
	self.vipLevelTitle:set_text(_local.UIText[5]);

	-- 初始化VIP描述信息
	local strArray = Utility.lua_string_split(vipConfig.des, "\n")

	for i, item in pairs(self.vipDesItems) do
		if i > #strArray then
			item.sp:set_active(false)
			item.lab:set_text("")
			item.self:set_active(false)
		else
			item.sp:set_active(true)
			item.lab:set_text(strArray[i])
			item.self:set_active(true)
		end
	end

	-- 未达到VIP等级给出文字提示
	if gplayer.vip < self.curVipIndex then
		self.labVipAward:set_text("购买");
		self.btnVipAward:set_enable(true);
		self.btnVipAward:set_active(true);
		self.btnVipAward:reset_on_click();
		self.btnVipAward:set_on_click(self.bindfunc["on_vip_no"]);
		-- self.btnVipAward_bg:set_sprite_name("anniu5");
		-- self.btnVipAward:set_sprite_names("anniu5");
		self.sp_art_font:set_active(false);
	else
		self.btnVipAward:set_active(true)
		if vipConfig.rewards == 0 then
			self.btnVipAward:set_active(false)
			self.labVipAward:set_text("")
		-- 已领取
		elseif _GetVipRewardsState(self.curVipIndex) then
			self.btnVipAward:set_enable(false)
			self.btnVipAward:set_active(false);
			self.labVipAward:set_text(_local.UIText[3])
			self.sp_art_font:set_active(true);
		-- 未领取
		else
			self.btnVipAward:set_enable(true)
			-- self.btnVipAward:set_sprite_names("anniu12");
			self.labVipAward:set_text(_local.UIText[2])
			
			self.btnVipAward:set_on_click(self.bindfunc["on_vip_award_btn"])
			self.sp_art_font:set_active(false);
		end
	end

	local data = {}
	local award = nil
	local config = nil
	local cardInfo = nil
	local cardType = nil
	--容错处理
	if vipConfig.rewards and vipConfig.rewards ~= 0 then data = vipConfig.rewards end

	for i = 1, 4 do
		award = data[i]
		if award then
			config = ConfigManager.Get(EConfigIndex.t_item,award.id)
			cardInfo, cardType = PublicFunc.CreateCardInfo(award.id, award.num)
			self.awards[i].self:set_active(true)
			self.awards[i].item:SetData(cardInfo)
			self.awards[i].item:SetCount(award.num);

			-- UI组件限制了只能是物品
			local id = award.id;
			local numFlag = true
			local name = ""
			self.awards[i].item:SetLabNum(true)
			if PropsEnum.IsEquip(id) then
				config = ConfigManager.Get(EConfigIndex.t_equipment,id);
				name = config.name;
			elseif PropsEnum.IsItem(id) then
				config = ConfigManager.Get(EConfigIndex.t_item,id);
				name = config.name;
			-- 杂项类，货币经验等
			elseif PropsEnum.IsVaria(id) then
				config = ConfigManager.Get(EConfigIndex.t_item,id)
				-- 数量显示到文本中
				if award.num > 0 then
					numFlag = true;
					name = award.num .. config.name;
				else
					name = config.name;
				end
			-- error：配置了错误的物品类型
			else
				name = tostring(id)
			end

			-- self.awards[i].item:SetLabNum(numFlag)
			-- self.awards[i].item:SetNumberStr(tostring(award.num));
		else
			self.awards[i].self:set_active(false)
		end
	end
end

--显示界面
function VipPrivilegeUI:Show()
	UiBaseClass.Show(self)
end

--隐藏界面
function VipPrivilegeUI:Hide()
	UiBaseClass.Hide(self)
end

--销毁数据
function VipPrivilegeUI:DestroyUi()
	UiBaseClass.DestroyUi(self);

	self:ClearAwardsItem()
end

function VipPrivilegeUI:ClearAwardsItem()
	if self.awards then
		for i, v in pairs(self.awards) do
			v.item:DestroyUi()
		end
		self.awards = nil
	end
end

-------------------------------------本地回调-------------------------------------
--vip发生变化（经验）
function VipPrivilegeUI:on_vip_change()
	-- self.curVipIndex = math.max(1, g_dataCenter.player.vip);
	-- app.log("on_vip_change: == " .. self.curVipIndex);
	--更新VIP信息
	self:UpdateUi()
end

--点击左侧按钮
function VipPrivilegeUI:on_vip_left_btn()
	self.curVipIndex = math.max(1, self.curVipIndex - 1)
	-- app.log("on_vip_left_btn: == " .. self.curVipIndex);
	self:UpdateUi()
end

--点击右侧按钮
function VipPrivilegeUI:on_vip_right_btn()
	self.curVipIndex = math.min(self.maxLevel, self.curVipIndex + 1)
	-- app.log("on_vip_right_btn: == " .. self.curVipIndex);
	self:UpdateUi()
end

--点击领取按钮
function VipPrivilegeUI:on_vip_award_btn()
	local vipConfig = ConfigManager.Get(EConfigIndex.t_vip_data,self.curVipIndex)
	if g_dataCenter.player.crystal >= vipConfig.discount_price then
	-- if g_dataCenter.player.crystal >= 20 then
    	msg_store.cg_get_vip_rewards(self.curVipIndex, vipConfig.discount_price);
    else
    	HintUI.SetAndShowNew(EHintUiType.two, "钻石不足", "钻石不足！是否前往充值？", nil, {str = "立即前往",func = self["go_to_store"]}, {str = "否",func = nil}, btn3Data, btn4Data)
		-- type = EHintUiType.two
		-- title = "钻石不足"
		-- content = "钻石不足！是否前往充值？"
		-- btnSpace = nil
		-- btn1Data = {str = "立即前往",func = XXXX}
		-- btn2Data = {str = "否",func = XXXX}
    end
end

function VipPrivilegeUI:go_to_store( )
	-- uiManager:PushUi(EUI.StoreUI);
	uiManager:ReplaceUi(EUI.StoreUI, "replace")
end

--点击VIP特权列表项
function VipPrivilegeUI:on_vip_item_btn(t)
	self.curVipIndex = t.float_value
	-- app.log("----------- on_vip_item_btn:" .. self.curVipIndex);
	-- 刷新列表项选中状态
	for name, index in pairs(self.vipList) do
		local obj = asset_game_object.find("store_ui/centre_other2/sp_frame_left/panel_yeka/wrap_content/" .. name)
		local spSelect = ngui.find_sprite(obj, "sp_di_purple")
		spSelect:set_active(index == self.curVipIndex)
	end

	self:UpdateUi()
end

function VipPrivilegeUI:ShowNavigationBar()
    return true
end

function VipPrivilegeUI:on_vip_no( t )
	FloatTip.Float("好感度不足");
end

-------------------------------------网络回调-------------------------------------

--领取了VIP奖励
function VipPrivilegeUI:get_vip_rewards(level)

	--展示获得奖励
	local data = ConfigManager.Get(EConfigIndex.t_vip_data,level).rewards
	if data == 0 then return end

	local award = {};
	for i, v in ipairs(data) do
		table.insert(award, {id=v.id, count=v.num or 0})
	end
	CommonAward.Start(award)
	-- app.log("curVipIndex = " .. self.curVipIndex);
	--刷新VIP页面
	self:UpdateUi()
end

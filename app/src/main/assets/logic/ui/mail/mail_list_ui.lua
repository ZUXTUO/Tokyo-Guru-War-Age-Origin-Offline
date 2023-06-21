
MailListUI = Class('MailListUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
-- 抽取本地的文本，需要替换到配置表
local _UIText = {
	[1] = "没有可以领取的邮件",
	[2] = "来自：",
	[3] = "日期：", --已废弃
	[4] = "当前无邮件",
}

--使用本地变量简化代码
--返回数据中心的邮件数据
local function _GetSystemMailByIndex(i)
	return g_dataCenter.mail:GetSystemMailByIndex(i)
end

local function _GetSystemMailDetailByIndex(i)
	return _GetSystemMailByIndex(i).mailDetail
end
-------------------------------------类方法-------------------------------------
--初始化
function MailListUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/mail/ui_301_mail.assetbundle"
	UiBaseClass.Init(self, data);
end

--重新开始
function MailListUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
	end
end

--初始化数据
function MailListUI:InitData(data)
	UiBaseClass.InitData(self, data);
	self.mailIndex = nil				--当前邮件下标
end

--释放界面
function MailListUI:DestroyUi()
	self.needResetList = nil
	self.listCount = nil

	if self.items then
		for b, item in pairs(self.items) do
			item.uiItem:DestroyUi()
			if type(item.uiCard) == "table" then
				item.uiCard:DestroyUi()
			end
			for i, giftItem in ipairs(item.uiGiftItems) do
				if type(giftItem) == "table" then
					giftItem:DestroyUi()
				end
			end
			for i, giftCard in ipairs(item.uiGiftCards) do
				if type(giftCard) == "table" then
					giftCard:DestroyUi()
				end
			end
		end
		self.items = nil
	end

	self.enhanceSV = nil

    UiBaseClass.DestroyUi(self);
end

--显示UI
function MailListUI:Show()
	if UiBaseClass.Show(self) then
		--清理同步删除的邮件
		if g_dataCenter.mail:UpdateDeletedMail() then
			g_dataCenter.mail:SortMailList()
			self.needResetList = true
			self:UpdateUi()
		end
	end
end

--隐藏UI
function MailListUI:Hide()
	if UiBaseClass.Hide(self) then
	end
end

--注册方法
function MailListUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["one_key_take_all"] = Utility.bind_callback(self, self.one_key_take_all)
	self.bindfunc["check_more_mail"] = Utility.bind_callback(self, self.check_more_mail)
	self.bindfunc["on_mail_item"] = Utility.bind_callback(self, self.on_mail_item)
	self.bindfunc["on_btn_get_gift"] = Utility.bind_callback(self, self.on_btn_get_gift)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["init_mail_item"] = Utility.bind_callback(self, self.init_mail_item)
	self.bindfunc["on_mail_data"] = Utility.bind_callback(self, self.on_mail_data)
	self.bindfunc["gc_take_accessory"] = Utility.bind_callback(self, self.gc_take_accessory)
	self.bindfunc["gc_take_all_accessory"] = Utility.bind_callback(self, self.gc_take_all_accessory)
end 

--注册消息分发回调函数
function MailListUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_mail.gc_get_maildata, self.bindfunc["on_mail_data"])
	PublicFunc.msg_regist(msg_mail.gc_delete_mail, self.bindfunc["on_mail_data"])
	PublicFunc.msg_regist(msg_mail.gc_new_mail, self.bindfunc["on_mail_data"])
	PublicFunc.msg_regist(msg_mail.gc_take_accessory, self.bindfunc["gc_take_accessory"])
	PublicFunc.msg_regist(msg_mail.gc_take_all_accessory, self.bindfunc["gc_take_all_accessory"])
end

--注销消息分发回调函数
function MailListUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_mail.gc_get_maildata, self.bindfunc["on_mail_data"])
	PublicFunc.msg_unregist(msg_mail.gc_delete_mail, self.bindfunc["on_mail_data"])
	PublicFunc.msg_unregist(msg_mail.gc_new_mail, self.bindfunc["on_mail_data"])
	PublicFunc.msg_unregist(msg_mail.gc_take_accessory, self.bindfunc["gc_take_accessory"])
	PublicFunc.msg_unregist(msg_mail.gc_take_all_accessory, self.bindfunc["gc_take_all_accessory"])
end

--初始化UI
function MailListUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("mail_list");

	self.items = {}
	self.listCount = 0

	local path = "centre_other/animation/"
	self.btnOneKeyReceive = ngui.find_button(self.ui, path.."btn1")
	local btnClose = ngui.find_button(self.ui, path.."btn_cha")

	self.btnOneKeyReceive:set_on_click(self.bindfunc["one_key_take_all"])
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	self.nodeNoMailTips = self.ui:get_child_by_name(path.."sp_bk")

	path = "centre_other/animation/scroll_view/"
	self.scrollView = ngui.find_scroll_view(self.ui, path.."panel_list")
	self.enhanceSV = ngui.find_enchance_scroll_view(self.ui, path.."panel_list")
	self.enhanceSV:set_on_initialize_item(self.bindfunc['init_mail_item']);

	--首次打开界面，拉取邮件列表
	if not g_dataCenter.mail:IsPulledMailList() then
		g_dataCenter.mail:ClearMailList()
		msg_mail.cg_get_maildata()

		self.enhanceSV:set_maxNum(0);
		self.enhanceSV:set_dynamic(true)
	else
		g_dataCenter.mail:SortMailList() --对已有邮件排序
		self.needResetList = true
	end

	self:UpdateUi()
end

function MailListUI:UpdateUi()
	if self.needResetList then
		self.needResetList = nil
		self:ResetMailList()
	else
		self:UpdateMailList()
	end

	--一键领取
	if g_dataCenter.mail:GetSystemMailUnreceiveGiftCount() > 0 then
		self.btnOneKeyReceive:set_active(true)
	else
		self.btnOneKeyReceive:set_active(false)
	end
	
	--无邮件提示
	if not g_dataCenter.mail:IsPulledMailList() or g_dataCenter.mail.systemMailCount == 0 then
		self.nodeNoMailTips:set_active(true)
	else
		self.nodeNoMailTips:set_active(false)
	end
end

--刷新邮件列表
function MailListUI:UpdateMailList()
	if not self.ui then return end

	for b, item in pairs(self.items) do
		-- 找到当前初始化的列表项进行刷新
		self:LoadItem(item, item.index)
	end
end

-- 更新邮件列表项
function MailListUI:LoadItem( item, index )
	item.index = index
	local data = _GetSystemMailByIndex(index)
	if data then
		item.content:set_active(true)
		item.labLoading:set_active(false)

	    item.btn:set_event_value("", index)
	    item.btnGiftTake:set_event_value(tostring(data.id), 0)
		-- 邮件标题
		item.title:set_text(data.title)
		-- 发件人
		item.from:set_text(_UIText[2]..data.senderName)
		-- 发件日期
		local t = os.date("*t", data.createDate)
		item.time:set_text(string.format("%s/%s/%s", t.year, t.month, t.day))

		if data.isGift == false then
			item.btnGiftTake:set_active(false)
			item.spGiftTaken:set_active(false)

			item.spRead:set_active(data.isRead)
			item.spUnread:set_active(not data.isRead)
		else
			item.spRead:set_active(false)
			item.spUnread:set_active(false)

			item.btnGiftTake:set_active(data.isGift == true)
			item.spGiftTaken:set_active(data.isGift == nil)
		end

		if data.showGiftId > 0 then
			-- 附件道具图标
			-- item.uiItem:SetDataNumber(data.showGiftId)

			local cardInfo, cardType = PublicFunc.CreateCardInfo(data.showGiftId)
			if cardType == ENUM.EPackageType.Hero then
				if type(item.uiCard) ~= "table" then
					item.uiCard = SmallCardUi:new({ parent = item.uiCard, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }, info = cardInfo })
				else
					item.uiCard:SetData(cardInfo)
					item.uiCard:Show()
				end
				item.uiItem:Hide()

			else
				item.uiItem:SetData(cardInfo)
				item.uiItem:Show()
				if type(item.uiCard) == "table" then
					item.uiCard:Hide()
				end
			end
		else
			-- 显示默认图标
			-- item.uiItem:SetDataNumber(IdConfig.MailIcon)

			item.uiItem:SetDataNumber(IdConfig.MailIcon)
			item.uiItem:Show()
			if type(item.uiCard) == "table" then
				item.uiCard:Hide()
			end
		end

		item.labGiftTitle:set_active( #data.showGiftList > 0 )

		for i=1, #item.uiGiftItems do
			local giftItem = item.uiGiftItems[i]
			local giftCard = item.uiGiftCards[i]
			if i <= #data.showGiftList then
				local dataGift = data.showGiftList[i]
				if PropsEnum.IsRole(dataGift.number) then
					item.uiGiftItems[i] = self:SetGiftItemData(giftItem, nil)
					item.uiGiftCards[i] = self:SetGiftCardData(giftCard, dataGift)
				else
					item.uiGiftItems[i] = self:SetGiftItemData(giftItem, dataGift)
					item.uiGiftCards[i] = self:SetGiftCardData(giftCard, nil)
				end
			else
				item.uiGiftItems[i] = self:SetGiftItemData(giftItem, nil)
				item.uiGiftCards[i] = self:SetGiftItemData(giftCard, nil)
			end
		end
	else
		item.content:set_active(false)
		item.labLoading:set_active(true)

		timer.create(self.bindfunc["check_more_mail"], 1, 1)
	end
end

function MailListUI:SetGiftItemData(giftItem, data)
	if data and type(giftItem) == "userdata" then
		giftItem = UiSmallItem:new({parent=giftItem})
	end

	if data then
		giftItem:SetDataNumber(data.number, data.count)
		giftItem:Show()
	elseif type(giftItem) == "table" then
		giftItem:Hide()
	end

	return giftItem
end

function MailListUI:SetGiftCardData(giftCard, data)
	if data and type(giftCard) == "userdata" then
		giftCard = SmallCardUi:new({ parent = giftCard, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star } })
	end

	if data then
		giftCard:SetDataNumber(data.number, data.count)
		giftCard:Show()
	elseif type(giftCard) == "table" then
		giftCard:Hide()
	end

	return giftCard
end

--重置邮件列表（根据返回的邮件list,生成对应的List界面）
function MailListUI:ResetMailList()
	if not self.ui then return end

	local totalCount = g_dataCenter.mail.systemMailCount
	local haveCount = #g_dataCenter.mail.systemMailList

	self.enhanceSV:set_maxNum(totalCount);
	self.enhanceSV:refresh_list()

	if haveCount < totalCount then
		self.enhanceSV:set_dynamic(true)
	else
		self.enhanceSV:set_dynamic(false)
	end
end

-------------------------------------本地回调-------------------------------------

function MailListUI:check_more_mail()
	if not g_dataCenter.mail:IsPulledMailList() then return end

	local totalCount = g_dataCenter.mail.systemMailCount
	local haveCount = #g_dataCenter.mail.systemMailList
	if totalCount > haveCount then
		msg_mail.cg_get_maildata()
	end
end

--初始化邮件列表
function MailListUI:init_mail_item(obj, index)
	local item = self.items[obj:get_instance_id()]
	if not item then
		item = {}

		item.btn = ngui.find_button(obj, obj:get_name())
		item.content = obj:get_child_by_name("content")
		item.labLoading = ngui.find_label(obj, obj:get_name().."/lab")
		item.title = ngui.find_label(item.content, "lab_name")
		item.time = ngui.find_label(item.content, "lab_time")
		item.from = ngui.find_label(item.content, "lab_fajian_ren")
		item.spRead = ngui.find_sprite(item.content, "sp_art_font1")
		item.spUnread = ngui.find_sprite(item.content, "sp_art_font2")
		item.spGiftTaken = ngui.find_sprite(item.content, "sp_art_font3")
		item.btnGiftTake = ngui.find_button(item.content, "btn_get")
		item.labGiftTitle = ngui.find_label(item.content, "txt_jiangli")

		-- item.defaultIcon = ngui.find_sprite(item.content, "content/sp")
		local objParent = item.content:get_child_by_name("new_small_card_item")
		item.uiItem = UiSmallItem:new({parent=objParent, prop={show_number=false}})
		item.uiCard = objParent
		item.uiGiftItems = {} --存储父节点 或者 smallitem
		item.uiGiftCards = {} --英雄卡片
		local objGiftCont = item.content:get_child_by_name("cont_item")
		for i=1, 10 do
			objParent = objGiftCont:get_child_by_name("new_small_card_item"..i)
			if objParent then
				table.insert(item.uiGiftItems, objParent)
				table.insert(item.uiGiftCards, objParent)
			else
				break;
			end
		end

		item.btn:set_on_click(self.bindfunc["on_mail_item"])
		item.btnGiftTake:set_on_click(self.bindfunc["on_btn_get_gift"])

		self.items[obj:get_instance_id()] = item
	end

	self:LoadItem(item, index)
end

--点击某个邮件列表项
function MailListUI:on_mail_item(t)

	self.mailIndex = t.float_value
	local mail = _GetSystemMailByIndex(self.mailIndex)
	--邮件列表中是否有此邮件
	if mail then
		-- 非附件邮件
		if mail.isGift == false then
			uiManager:PushUi(EUI.MailViewUI, mail.id)
		-- 附件邮件
		else
			uiManager:PushUi(EUI.MailGiftViewUI, mail.id)
		end
	end

	self:UpdateUi()
end

function MailListUI:on_btn_get_gift(t)
	msg_mail.cg_take_accessory(t.string_value)
end

--点击遮罩返回或关闭
function MailListUI:on_btn_close()
	uiManager:PopUi()
end


function MailListUI:one_key_take_all()
	if g_dataCenter.mail:GetSystemMailUnreceiveGiftCount() > 0 then
		msg_mail.cg_take_all_accessory()
	else
		FloatTip.Float(_UIText[1])
	end
end

-------------------------------------网络回调-------------------------------------
--取邮件列表回调
function MailListUI:on_mail_data()
	self.needResetList = true
	self:UpdateUi()
end

--领取单个邮件附件
function MailListUI:gc_take_accessory(mailId, gifts)
	if uiManager:GetCurScene() ~= self then return end

	local award = Mail.GetMailGiftList(gifts)
	if #award > 0 then
		CommonAward.Start(award)
	end

	--清理同步删除的邮件
	if g_dataCenter.mail:UpdateDeletedMail() then
		g_dataCenter.mail:SortMailList()
		self.needResetList = true
	end
	
	self:UpdateUi()
end

--一键领取回调
function MailListUI:gc_take_all_accessory(gifts)
	local award = Mail.GetMailGiftList(gifts)
	if #award > 0 then
		CommonAward.Start(award)
	end

	if not g_dataCenter.mail:IsPulledMailList() then
		g_dataCenter.mail:ClearMailList()
		msg_mail.cg_get_maildata()

		-- 邮件数据回来后会刷新界面，这里去掉重复刷新列表操作，优化界面显示
		-- self.enhanceSV:set_maxNum(0);
		-- self.enhanceSV:set_dynamic(true)
	else
		g_dataCenter.mail:SortMailList() --对已有邮件排序
		self.needResetList = true

		self:UpdateUi()
	end
end


MailGiftViewUI = Class('MailGiftViewUI', UiBaseClass)

-------------------------------------local声明-------------------------------------

--使用本地变量简化代码
--返回数据中心的邮件数据
local function _GetSystemMailById(id)
	return g_dataCenter.mail:GetSystemMailById(id)
end

local function _GetSystemMailDetailById(id)
	return (_GetSystemMailById(id) or {}).mailDetail
end

-------------------------------------类方法-------------------------------------
function MailGiftViewUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/mail/ui_302_mail.assetbundle"
	UiBaseClass.Init(self, data);
end

function MailGiftViewUI:Restart(data)
	self.mailId = data
    UiBaseClass.Restart(self, data)

	-- 拉取详细信息
	if _GetSystemMailDetailById(self.mailId).isDetail == false then
		msg_mail.cg_mail_detail(self.mailId)
	end
end

function MailGiftViewUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function MailGiftViewUI:DestroyUi()
	self.scrollView = nil
	self.wcGiftList = nil

	if self.items then
		for i, item in ipairs(self.items) do
			if item.uiCard then
				item.uiCard:DestroyUi()
			end
		end
		self.items = nil
	end

    UiBaseClass.DestroyUi(self);
end

function MailGiftViewUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_get_gift"] = Utility.bind_callback(self, self.on_btn_get_gift)
	self.bindfunc["init_gift_item"] = Utility.bind_callback(self, self.init_gift_item)
	self.bindfunc["on_mail_detail"] = Utility.bind_callback(self, self.on_mail_detail)
	self.bindfunc["gc_take_accessory"] = Utility.bind_callback(self, self.gc_take_accessory)
end 

function MailGiftViewUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_mail.gc_mail_detail, self.bindfunc["on_mail_detail"])
	PublicFunc.msg_regist(msg_mail.gc_take_accessory, self.bindfunc["gc_take_accessory"])
end

function MailGiftViewUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_mail.gc_mail_detail, self.bindfunc["on_mail_detail"])
	PublicFunc.msg_unregist(msg_mail.gc_take_accessory, self.bindfunc["gc_take_accessory"])
end

function MailGiftViewUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("mail_gift_view");

	self.giftList = {}
	self.items = {}

	local path = "centre_other/animation/"
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	self.btnGet = ngui.find_button(self.ui, path.."btn_get")
	self.spReceived = ngui.find_sprite(self.ui, path.."sp_art_font")

	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	self.btnGet:set_on_click(self.bindfunc["on_btn_get_gift"])

	local labTitle = ngui.find_label(self.ui, path.."lab_title")
	local labFrom =  ngui.find_label(self.ui, path.."scroll_view1/cont/lab_name")
	local labTime =  ngui.find_label(self.ui, path.."scroll_view1/cont/lab_time")
	self.labContent = ngui.find_label(self.ui, path.."scroll_view1/panel_list/lab")

	self.scrollView = ngui.find_scroll_view(self.ui, path.."scroll_view2/panel_list")
	self.wcGiftList = ngui.find_wrap_content(self.ui, path.."scroll_view2/panel_list/wrap_cont")
	self.wcGiftList:set_on_initialize_item(self.bindfunc["init_gift_item"])

	local mail = _GetSystemMailById(self.mailId)
	labTitle:set_text(mail.title)
	labFrom:set_text(mail.senderName)
	local t = os.date("*t", mail.createDate)
	labTime:set_text(string.format("%s/%s/%s", t.year, t.month, t.day))

	self:ResetWrapContent()
	self:UpdateUi()
end

function MailGiftViewUI:UpdateUi()
	if not self.ui then return end

	local mail = _GetSystemMailById(self.mailId)
	-- 附件已领
	if mail.isGift == nil then
		self.spReceived:set_active(true)
		self.btnGet:set_active(false)
	-- 附件未领
	else
		self.spReceived:set_active(false)
		self.btnGet:set_active(true)
	end
	
	local mailDetail = _GetSystemMailDetailById(self.mailId)
	self.labContent:set_text(mailDetail.mailContent)
end

function MailGiftViewUI:ResetWrapContent()
	if not self.ui then return end

	local mailDetail = _GetSystemMailDetailById(self.mailId)
	self.giftList = mailDetail:GetMailGiftList()
	
	self.wcGiftList:set_min_index(1 - #self.giftList)
	self.wcGiftList:set_max_index(0)
	self.wcGiftList:reset()
end

-------------------------------------本地回调-------------------------------------
function MailGiftViewUI:init_gift_item(obj,b,real_id)
	local index = math.abs(real_id) + 1;

	local item = self.items[b]
	if not item then
		item = {}
		self.items[b] = item
	end

	local data = self.giftList[index]
	if data then
		if item.uiCard then
			item.uiCard:Hide()
			item.uiCard:DestroyUi()
		end

		local objParent = obj:get_child_by_name(obj:get_name())
		local cardInfo, cardType = PublicFunc.CreateCardInfo(data.number)
		if cardType == ENUM.EPackageType.Hero then
			item.uiCard = SmallCardUi:new({ parent = objParent, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }, info = cardInfo })
		else
			item.uiCard = UiSmallItem:new({ parent = objParent, cardInfo = cardInfo })
			item.uiCard:SetCount(data.count)
		end
	end
end

function MailGiftViewUI:on_btn_close(t)
	-- local mail = _GetSystemMailById(self.mailId)
	-- if mail and mail.isGift == nil and mail.delDate == 0 then
	-- 	-- msg_mail.cg_delete_mail(mail.id) --领取附件后服务器主动删除
	-- end
	uiManager:PopUi()
end

function MailGiftViewUI:on_btn_get_gift()
	if self.mailId then
		-- 领取成功后再删除邮件
		msg_mail.cg_take_accessory(self.mailId)
	end
end

-------------------------------------网络回调-------------------------------------
--邮件奖励展示回调
function MailGiftViewUI:gc_take_accessory(mailId, gifts)
	local award = Mail.GetMailGiftList(gifts)
	if #award > 0 then
		CommonAward.Start(award)
	end

	self:UpdateUi()
end

--取邮件详细信息回调
function MailGiftViewUI:on_mail_detail(mailId)
	if self.mailId ~= mailId then return end

	self:ResetWrapContent()
	self:UpdateUi()
end

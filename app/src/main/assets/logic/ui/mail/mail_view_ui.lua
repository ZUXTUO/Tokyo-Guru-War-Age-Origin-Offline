
MailViewUI = Class('MailViewUI', UiBaseClass)

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
function MailViewUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/mail/ui_302_mail.assetbundle"
	UiBaseClass.Init(self, data);
end

function MailViewUI:Restart(data)
	self.mailId = data
    UiBaseClass.Restart(self, data)

	-- 拉取详细信息
	if _GetSystemMailDetailById(self.mailId).isDetail == false then
		msg_mail.cg_mail_detail(self.mailId)
	end
end

function MailViewUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function MailViewUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function MailViewUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_mail_detail"] = Utility.bind_callback(self, self.on_mail_detail)
end 

function MailViewUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_mail.gc_mail_detail, self.bindfunc["on_mail_detail"])
end

function MailViewUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_mail.gc_mail_detail, self.bindfunc["on_mail_detail"])
end

function MailViewUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("mail_view");

	local path = "centre_other/animation/"
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	local btnConfirm = ngui.find_button(self.ui, path.."btn_get")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	btnConfirm:set_on_click(self.bindfunc["on_btn_close"])

	--共用资源需要修改的
	local labConfirm = ngui.find_label(self.ui, path.."btn_get/animation/lab")
	labConfirm:set_text("确定")
	local spReceived = ngui.find_sprite(self.ui, path.."sp_art_font")
	spReceived:set_active(false)

	local labTitle = ngui.find_label(self.ui, path.."lab_title")
	local labFrom =  ngui.find_label(self.ui, path.."scroll_view1/cont/lab_name")
	local labTime =  ngui.find_label(self.ui, path.."scroll_view1/cont/lab_time")
	self.labContent = ngui.find_label(self.ui, path.."scroll_view1/panel_list/lab")



	local mail = _GetSystemMailById(self.mailId)
	labTitle:set_text(mail.title)
	labFrom:set_text(mail.senderName)
	local t = os.date("*t", mail.createDate)
	labTime:set_text(string.format("%s/%s/%s", t.year, t.month, t.day))

	self:UpdateUi()
end

function MailViewUI:UpdateUi()
	if not self.ui then return end

	local mailDetail = _GetSystemMailDetailById(self.mailId)
	self.labContent:set_text(mailDetail.mailContent)
end

-------------------------------------本地回调-------------------------------------
function MailViewUI:on_btn_close(t)
	local mail = _GetSystemMailById(self.mailId)
	if mail.delDate == 0 then
		--直接删除本地数据（服务器同步删除）
		--msg_mail.cg_delete_mail(mail.id)
	end
	uiManager:PopUi()
end

-------------------------------------网络回调-------------------------------------
--取邮件详细信息回调
function MailViewUI:on_mail_detail(mailId)
	if self.mailId ~= mailId then return end

	self:UpdateUi()
end

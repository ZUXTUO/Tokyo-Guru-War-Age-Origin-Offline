msg_mail = msg_mail or {}

-- 临时变量, 是否使用本地数据
local isLocalData = true

-- 申请邮件数据(服务器自动返回下一页数据)
function msg_mail.cg_get_maildata()
	if not PublicFunc.lock_send_msg(msg_mail.cg_get_maildata) then return end
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		gc_get_maildata.cg()
	else
		--if not Socket.socketServer then return end
		if AppConfig.script_recording then
	        PublicFunc.RecordingScript("nmsg_mail.cg_get_maildata(robot_s)")
	    end
		nmsg_mail.cg_get_maildata(Socket.socketServer)
	end
end

-- 返回邮件列表数据
function msg_mail.gc_get_maildata(result, mails, mailcount)
	PublicFunc.unlock_send_msg(msg_mail.cg_get_maildata)
	isLock = false
	GLoading.Hide(GLoading.EType.msg)
	local success = PublicFunc.GetErrorString(result);
	if success then
		g_dataCenter.mail:SetPulledMailList(true)
		g_dataCenter.mail:SetSystemMailCount(mailcount)

		for i, v in ipairs(mails or {}) do
			g_dataCenter.mail:AddSystemMail( v )
		end
		PublicFunc.msg_dispatch(msg_mail.gc_get_maildata)
	end
end

-- 获取邮件详情
function msg_mail.cg_mail_detail(mail_dataid)
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		gc_mail_detail.cg(mail_dataid)
	else
		--if not Socket.socketServer then return end
		nmsg_mail.cg_mail_detail(Socket.socketServer, mail_dataid)
	end
end

-- 返回邮件详情
function msg_mail.gc_mail_detail(result, mail_dataid, mail_detail)
	GLoading.Hide(GLoading.EType.msg)
	local success = PublicFunc.GetErrorString(result);
	if success then
		for i, v in ipairs(g_dataCenter.mail.systemMailList) do
			if v.id == mail_dataid then
				-- v.mailDetail:SetCardHumanList(mail_detail.accessory.role_dataidlist)
				-- v.mailDetail:SetCardEquipmentList(mail_detail.accessory.equip_dataidlist)
				-- v.mailDetail:SetCardPropList(mail_detail.accessory.item_dataidlist)
				v.mailDetail:SetMailGiftList(v.showGiftList) --附件在简信里
				v.mailDetail:SetMailContent(mail_detail.content)
				v.mailDetail:IsDetail(true)

				--不带附件邮件查看详情之后标记为已读
				if v.isGift == false and not v.isRead then
					v:SetIsRead(true)
					-- 未读邮件数-1
					g_dataCenter.mail:AddMailUnreadCount(false)
				end
				break
			end
		end

		PublicFunc.msg_dispatch(msg_mail.gc_mail_detail, mail_dataid)
	end
end

-- 领取附件
function msg_mail.cg_take_accessory(mail_dataid)
	GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		gc_take_accessory.cg(mail_dataid)
	else
		--if not Socket.socketServer then return end
		nmsg_mail.cg_take_accessory(Socket.socketServer, mail_dataid)
	end
end

-- 领取附件
function msg_mail.gc_take_accessory(result, mail_dataid, gifts)
	GLoading.Hide(GLoading.EType.msg)
	local success = PublicFunc.GetErrorString(result);
	if success then
		local mail = g_dataCenter.mail:GetSystemMailById(mail_dataid)
		if mail then
			if mail.isGift then
				mail:SetIsGift(nil)
				g_dataCenter.mail:AddMailUnreceiveGiftCount(false)
			end
			if not mail.isRead then
				mail:SetIsRead(true)
				g_dataCenter.mail:AddMailUnreadCount(false)
			end
		end
		-- 更新数据之前，展示获得奖励
		PublicFunc.msg_dispatch(msg_mail.gc_take_accessory, mail_dataid, gifts)
	end
end

-- 主动删除已读邮件（按确定按钮删除）
function msg_mail.cg_delete_mail(mail_dataid)
	--GLoading.Show(GLoading.EType.msg)
	if isLocalData then
		gc_delete_mail.cg()
	else
		--if not Socket.socketServer then return end
		nmsg_mail.cg_delete_mail(Socket.socketServer, mail_dataid)
	end
end

-- 主动删除邮件消息
function msg_mail.gc_delete_mail(result, mail_dataid)
	--GLoading.Hide()
	local success = PublicFunc.GetErrorString(result)
	if success then
		local deleteMail = g_dataCenter.mail:RemoveSystemMailById(mail_dataid);
		if deleteMail and not deleteMail.isRead then
			g_dataCenter.mail:AddMailUnreadCount(false)
		end
		g_dataCenter.mail:SetSystemMailCount(
			math.max(0, g_dataCenter.mail:GetSystemMailCount() - 1))

		PublicFunc.msg_dispatch(msg_mail.gc_delete_mail)
	end
end

-- 一键领取
function msg_mail.cg_take_all_accessory()
	GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
	nmsg_mail.cg_take_all_accessory(Socket.socketServer)
end

-- 一键领取结果
function msg_mail.gc_take_all_accessory(result, gifts)
	GLoading.Hide(GLoading.EType.msg)
	local success = PublicFunc.GetErrorString(result)
	if success then
		--更新附件邮件的读取状态（服务器不会发删除消息，客户端需要同步计数）
		g_dataCenter.mail:UpdateMailReadState()
		g_dataCenter.mail:SetPulledMailList(false)
		PublicFunc.msg_dispatch(msg_mail.gc_take_all_accessory, gifts)
	end
end

-- Push新邮件
function msg_mail.gc_new_mail(mail)
	if mail then
		g_dataCenter.mail:AddSystemMail( mail, true )
		g_dataCenter.mail:SetSystemMailCount(g_dataCenter.mail:GetSystemMailCount() + 1)
		g_dataCenter.mail:AddMailUnreadCount(true)

		if mail.have_acc == 1 then
			g_dataCenter.mail:AddMailUnreceiveGiftCount(true)
		end	

		PublicFunc.msg_dispatch(msg_mail.gc_new_mail)
	end
end

-- Push过期邮件删除消息
function msg_mail.gc_system_delete_mail(mail_dataid)
	if mail_dataid then
		local deleteMail = g_dataCenter.mail:RemoveSystemMailById(mail_dataid);
		if deleteMail then
			if not deleteMail.isRead then
				g_dataCenter.mail:AddMailUnreadCount(false)
			end
			if deleteMail.isGift then
				g_dataCenter.mail:AddMailUnreceiveGiftCount(false)
			end
		end
		g_dataCenter.mail:SetSystemMailCount(
			math.max(0, g_dataCenter.mail:GetSystemMailCount() - 1))
	end
end

-- 进游戏通知一次，后面改变需要客户端自行维护(一键领取服务器会同步)
function msg_mail.gc_notify_unread_mail(unread, unreceive_acc)
	g_dataCenter.mail:SetSystemMailUnreadCount(unread)
	g_dataCenter.mail:SetSystemMailUnreceiveGiftCount(unreceive_acc)
end

Mail = Class('Mail')

function Mail:Init()
	self.tempMailId = {}				--辅助保存已有邮件Id
	self.systemMailList = {}			--系统邮件列表<SystemMail>
	self.systemMailCount = 0			--系统邮件总数
	self.systemMailUnreadCount = 0		--系统邮件未读总数
	self.systemMailUnreceiveGiftCount = 0	--系统邮件未领取附件总数

	--self.playerMailList = {}			--玩家邮件列表<PlayerMail>
	--self.playerMailCount = 0			--玩家邮件总数

	self.pulledMailList = false;			-- 是否已经拉取过邮件列表

	return self
end


function Mail.GetMailGiftList(mail_accessory)
	local gifts = {}
	if mail_accessory then
		for i, v in ipairs(mail_accessory.role_dataidlist) do
			table.insert(gifts, {dataid=v.dataid,id=v.number,count=v.count or 1})
		end
		for i, v in ipairs(mail_accessory.equip_dataidlist) do
			table.insert(gifts, {dataid=v.dataid,id=v.number,count=v.count or 1})
		end

		--合并道具类
		local props = {}
		for i, v in ipairs(mail_accessory.item_dataidlist) do
			if props[v.number] == nil then
				props[v.number] = 0
			end
			props[v.number] = props[v.number] + v.count
		end
		for number, count in pairs(props) do
			table.insert(gifts, {dataid=0,id=number,count=count})
		end
	end
	return gifts
end

-------------------------------------接口-------------------------------------
--设置邮件列表初始化
function Mail:SetPulledMailList(flag)
	self.pulledMailList = flag
end

--重置邮件列表
function Mail:ClearMailList()
	self.systemMailList = {}
	self.tempMailId = {}
end

--是否已经初始化邮件列表
function Mail:IsPulledMailList()
	return self.pulledMailList
end

--更新已经删除的邮件
function Mail:UpdateDeletedMail()
	local result = false
	local count = #self.systemMailList
	for i = count, 1, -1 do 
		local mail = self.systemMailList[i]
		if mail.delDate == 0 and (mail.isGift == nil or (mail.isGift == false and mail.isRead == true)) then
			table.remove(self.systemMailList, i)
			self.tempMailId[mail.id] = nil
			result = true
		end
	end
	return result
end

--打开邮件界面之前重排序
function Mail:SortMailList()
	table.sort(self.systemMailList, function(A, B)
		if A == nil or B == nil then return false end
		if A.isRead ~= B.isRead then return not A.isRead end
		if A.showPriority ~= B.showPriority then return A.showPriority > B.showPriority end
		return A.createDate > B.createDate
	end)

	self.tempMailId = {}
	for i, v in pairs(self.systemMailList) do
		self.tempMailId[v.id] = i
	end
end

--更新邮件一键领取后的状态(服务器会同步一次未读未领邮件数量)
function Mail:UpdateMailReadState()
	for i, v in pairs(self.systemMailList) do
		--权重不为0的邮件不能一键领取
		if v.showPriority == 0 and v.isGift == true then
			v:SetIsGift(nil)
			-- self:SetSystemMailUnreceiveGiftCount(
			-- 		math.max(0, g_dataCenter.mail:GetSystemMailUnreceiveGiftCount() - 1))

			if not v.isRead then
				v:SetIsRead(true)
				-- self:SetSystemMailUnreadCount(
				-- 	math.max(0, g_dataCenter.mail:GetSystemMailUnreadCount() - 1))
			end
		end
	end
end

--加入邮件
function Mail:AddSystemMail(mail, new)
	if not self.pulledMailList then return end

	if mail then
		for i, v in pairs(self.systemMailList) do
			if v.id == mail.dataid then
				return;
			end
		end
		systemMail = SystemMail:new(mail)
		--更新邮件（服务器可能发送重复邮件）
		if self.tempMailId[systemMail.id] then
			local index = self.tempMailId[systemMail.id]
			self.systemMailList[index] = systemMail
		else
			if new then
				table.insert(self.systemMailList, 1, systemMail)
				self.tempMailId[systemMail.id] = 1
			else
				table.insert(self.systemMailList, systemMail)
				self.tempMailId[systemMail.id] = #self.systemMailList
			end
		end
	end
end

--按下标删除邮件
function Mail:RemoveSystemMailByIndex(i)
	if not self.pulledMailList then return end
	if i and i <= #self.systemMailList then
		self.tempMailId[self.systemMailList[i].id] = nil
		return table.remove(self.systemMailList, i)
	end
end

--按Id删除邮件
function Mail:RemoveSystemMailById(id)
	if not self.pulledMailList then return end
	if id then
		for i, v in ipairs(self.systemMailList) do
			if v.id == id then
				self.tempMailId[id] = nil
				return table.remove(self.systemMailList, i)
			end
		end
	end
end

--返回一封系统邮件
function Mail:GetSystemMailByIndex(i)
	if i then
		local result = nil
		if i > 0 and i <= #self.systemMailList then
			result = self.systemMailList[i]
		end
		return result
	end
end

--返回一封系统邮件
function Mail:GetSystemMailById(id)
	if id then
		for i, v in ipairs(self.systemMailList) do
			if v.id == id then
				return v
			end
		end
	end
end

--设置系统邮件数量
function Mail:SetSystemMailCount(i)
	if i then
		self.systemMailCount = tonumber(i)
	end
end

--得到系统邮件数量
function Mail:GetSystemMailCount()
	return self.systemMailCount
end

--设置系统邮件未读数量
function Mail:SetSystemMailUnreadCount(i)
	if i then
		self.systemMailUnreadCount = tonumber(i)
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Mail);
	end
end

--设置系统邮件未领取附件邮件数量
function Mail:SetSystemMailUnreceiveGiftCount(i)
	if i then
		self.systemMailUnreceiveGiftCount = tonumber(i)
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Mail);
	end
end

--得到系统邮件未读数量
function Mail:GetSystemMailUnreadCount()
	return self.systemMailUnreadCount
end

--得到系统邮件未领附件邮件数量
function Mail:GetSystemMailUnreceiveGiftCount()
	return self.systemMailUnreceiveGiftCount
end

--增减未领取附件邮件数量
function Mail:AddMailUnreceiveGiftCount(isAdd)
	if isAdd then
		self.systemMailUnreceiveGiftCount = self.systemMailUnreceiveGiftCount + 1
	else
		self.systemMailUnreceiveGiftCount = math.max(0, self.systemMailUnreceiveGiftCount-1)
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Mail);
end

--增减未领取附件邮件数量
function Mail:AddMailUnreadCount(isAdd)
	if isAdd then
		self.systemMailUnreadCount = self.systemMailUnreadCount + 1
	else
		self.systemMailUnreadCount = math.max(0, self.systemMailUnreadCount - 1)
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Mail);
end

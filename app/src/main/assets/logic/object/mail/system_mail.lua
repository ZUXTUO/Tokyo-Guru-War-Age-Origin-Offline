-- struct mail_net
-- {
-- 	string dataid;				// 唯一id
-- 	string sender_name;			// 发送者id
-- 	int8 type;					// 邮件类型
-- 	string title;				// 邮件标题
-- 	int8 have_acc;				// 有没有附件
-- 	int8 is_read;				// 是否已读
-- 	string create_date;			// 创建日期
-- 	string del_date;			// 什么时间删除，如果是没读过的邮件，则保存看了之后多少秒后删。
-- };

SystemMail = Class('SystemMail')

function SystemMail:Init(data)
	self.id = data.dataid									--ID
	self.title = data.title									--标题
	self.createDate = tonumber(data.create_date) or 0		--创建时间
	self.delDate = tonumber(data.del_date) or 0				--删除时间	
	self.isGift = Utility.to_bool(data.have_acc)			--是否有附件（true/false/nil 有/无/已领取）

	-- isGift == nil 表示附件已领取
	if data.is_take_accessory == 1 then self.isGift = nil end

	self.isRead = Utility.to_bool(data.is_read)				--是否已读
	self.senderName = data.sender_name						--发送者名字
	self.mailDetail = SystemMailDetail:new()				--邮件详情<SystemMailDetail>

	-- self.showGiftId = data.icon or 0						--显示附件道具id
	self.showPriority = data.priority or 0					--显示优先级（值大的排到前面）

	--附件原数据
	self.accessory = data.accessory or {}
	self.showGiftList = {}
	if data.accessory then
		for i, v in ipairs(data.accessory.role_dataidlist) do
			table.insert(self.showGiftList, v)
		end
		for i, v in ipairs(data.accessory.equip_dataidlist) do
			table.insert(self.showGiftList, v)
		end

		--附件排序
		local item_dataidlist = data.accessory.item_dataidlist
		table.sort(item_dataidlist, function (A, B)
			if A == nil or B == nil then return false end
			local Acfg = ConfigManager.Get(EConfigIndex.t_item, A.number)
			local Bcfg = ConfigManager.Get(EConfigIndex.t_item, B.number)
			return Acfg.sort_number > Bcfg.sort_number;
		end)
		for i, v in ipairs(item_dataidlist) do
			table.insert(self.showGiftList, v)
		end
	end

	if #self.showGiftList > 0 then
		self.showGiftId = self.showGiftList[1].number
	else
		self.showGiftId = data.icon or 0
	end

	return self
end

--变更已读状态
function SystemMail:SetIsRead(bool)
	self.isRead = bool
end

--变更奖励状态
function SystemMail:SetIsGift(bool)
	self.isGift = bool
end

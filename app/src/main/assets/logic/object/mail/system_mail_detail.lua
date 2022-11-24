-- list<cards_role_net> role_dataidlist, 
-- list<cards_equip_net> equip_dataidlist, 
-- list<cards_item_net> item_dataidlist, 
-- list<mail_accessory> acclist, 
-- string content, 
-- string del_date, 
-- int8 ret


SystemMailDetail = Class('SystemMailDetail')

function SystemMailDetail:Init()

	self.cardHumanList = {}							--角色列表<CardHuman>
	self.cardEquipmentList = {}						--装备列表<CardEquipment>
	self.cardPropList = {}							--道具列表<CardProp>
	self.mailContent = ""							--邮件内容
	self.isDetail = false							--是否已取得邮件详情

	return self
end

-- function SystemMailDetail:ClearAccessory()
-- 	self.cardHumanList = {}
-- 	self.cardEquipmentList = {}
-- 	self.cardPropList = {}
-- end

-- function SystemMailDetail:SetCardHumanList(data)
-- 	if data then
-- 		self.cardHumanList = {}
-- 		for i,v in ipairs(data) do
-- 			local _cardHuman = CardHuman:new(v)
-- 			table.insert(self.cardHumanList, _cardHuman)
-- 		end
-- 	end
-- end

-- function SystemMailDetail:SetCardEquipmentList(data)
-- 	if data then
-- 		self.cardEquipmentList = {}
-- 		for i,v in ipairs(data) do
-- 			local _cardEquipment = CardEquipment:new(v)
-- 			table.insert(self.cardEquipmentList, _cardEquipment)
-- 		end
-- 	end
-- end

-- function SystemMailDetail:SetCardPropList(data)
-- 	if data then
-- 		self.cardPropList = {}
-- 		for i,v in ipairs(data) do
-- 			local _cardProp = CardProp:new(v)
-- 			table.insert(self.cardPropList, _cardProp)
-- 		end
-- 	end
-- end

function SystemMailDetail:SetMailGiftList(showGiftList)
	self.showGiftList = showGiftList
end

function SystemMailDetail:SetMailContent(content)
	self.mailContent = tostring(content)
end

function SystemMailDetail:IsDetail(bool)
	if bool then
		self.isDetail = true
	else
		self.isDetail = false
	end
end

function SystemMailDetail:GetMailGiftList()
	-- local gifts = {}
	-- for i, v in ipairs(self.cardHumanList) do
	-- 	table.insert(gifts, v)
	-- end
	-- for i, v in ipairs(self.cardEquipmentList) do
	-- 	table.insert(gifts, v)
	-- end
	-- for i, v in ipairs(self.cardPropList) do
	-- 	table.insert(gifts, v)
	-- end

	-- return gifts
	return self.showGiftList or table.empty()
end

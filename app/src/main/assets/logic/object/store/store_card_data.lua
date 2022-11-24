StoreCardData = Class('StoreCardData')

function StoreCardData:Init()
	self.index = nil	--索引
	self.name = nil		--名字
	self.type = nil		--商品类型
	self.id = nil		--商品id
	self.num = nil		--商品数量
	self.icon = nil		--图标
	self.describe = nil	--商品描述
	self.price = nil	--现实货币
	self.discount = nil --折扣（1-100）
	self.tag = nil		--标记
	self.buy_num = nil	--已购买商品次数
	self.buy_times_limit = nil --购买次数限制
end

function StoreCardData:SetData(data)
	if data then
		self.index = data.index
		self.name = data.name
		--self.type = data.type
		self.id = data.id
		self.num = data.num
		self.price = data.price
		self.discount = data.discount
		self.icon = data.icon
		self.describe = data.describe
		self.tag = data.tag
		self.buy_num = data.buy_num or 0
		self.buy_times_limit = data.buy_times_limit
		self.type = data.type
	end
end

function StoreCardData:Update(data)
	if data then
		if data.index then self.index = data.index end
		if data.name then self.name = data.name end
		--if data.type then self.type = data.type end
		if data.id then self.id = data.id end
		if data.num then self.num = data.num end
		if data.price then self.price = data.price end
		if data.discount then self.discount = data.discount end
		if data.icon then self.icon = data.icon end
		if data.describe then self.describe = data.describe end
		if data.tag then self.tag = data.tag end
		if data.buy_num then self.buy_num = data.buy_num end
		if data.buy_times_limit then self.buy_times_limit = data.buy_times_limit end
	end
end

return StoreCardData
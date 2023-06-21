-- require 'Class'

local property = 
{
	--index 唯一id
	--number 编号
	--count 数量
	--name 名字
	--small_icon 小图标
	--category 道具所属类别 参见ENUM.EItemCategory
	--overlap 最大堆叠数
	--scriptid 脚本id
	--description 道具描述
	--sell_price 出售价格
	--exchange_data 兑换信息
	--sort_number 
}
CardProp = Class("CardProp", nil, property);

function CardProp:Init(data)
	self:initData(data);
end

function CardProp:initData(data)
	self.index = data.dataid;					--唯一编号
	self.number = data.number;					--道具唯一编号
	self.count = data.count or 0;					--数量
	-- if not data.count then
	-- 	self.count = g_dataCenter.package:GetCountByNumber(self.number)
	-- end
	
	
	
	--属性，读取配置表
	self.config = ConfigManager.Get(EConfigIndex.t_item,self.number);
	local config = self.config
	if config then
		self.name = config.name or "";	

		self.small_icon = config.small_icon or "";
		self.category = config.category or ENUM.EItemCategory.Empty;
        self.package_category = config.package_category or 0;
		self.overlap = config.overlap or self.count;
		self.scriptid = config.scriptid or 0;
		self.description = config.description or "";
		self.rarity = config.rarity or 0;
        self.exp = config.exp or 0;
		self.sell_price = config.sell_price or 0;
		self.exchange_data = ConfigManager.Get(EConfigIndex.t_item_exchange,self.number) or nil
		self.sort_number = config.sort_number or 0
		self.description_ex = config.description_ex
		local color_str  = PublicFunc.GetItemRarityColor(self.rarity)			
		self.color_name = "[" .. color_str .. "]" ..self.name.."[-]"	
	else
		app.log_warning("读取道具配置失败  number="..tostring(self.number).."   debug="..debug.traceback());
	end
end


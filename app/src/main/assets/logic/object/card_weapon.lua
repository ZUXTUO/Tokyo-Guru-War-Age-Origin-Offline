CardWeapon = Class("CardWeapon")

CardWeapon.ETeamType = {
	None = 0,
	Leader = 1,
	Member1 = 2,
	Member2 = 3,
};

CardWeapon.EMaxLevel = {
	[0] = 15,
	[1] = 30,
	[2] = 45,
	[3] = 60,
	[4] = 80,
	[5] = 99,
};

function CardWeapon:Init(data)
	self:initData(data);
    self:registFunc();
end

function CardWeapon:registFunc()

end

function CardWeapon:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function CardWeapon:initData(data)
    self.bindfunc={};
	
	self.index = data.index;					--唯一编号
	self.order = data.order;					--入手顺序
	self.number = data.number;					--编号
	self.level = data.level;					--等级
	self.awake = data.awake;					--觉醒次数
	self.break_through = data.break_through;	--界限突破次数
	self.cur_exp = data.cur_exp;				--当前经验
	self.check = data.check;					--是否已经查看
	self.composite_protect = data.composite_protect;		--合成保护
	self.lock = data.lock;						--锁定卡牌
	self.belongHuman = nil;        --所属人物卡片index(外部传入)
	self.skill1Level = data.skill1Level;        --必杀技等级
	self.skill2Level = data.skill2Level;        --支援技等级
	
	--属性，读取配置表
	self.name = ConfigManager.Get(EConfigIndex.t_weapon,self.number).name					--武器名字
	self.weaponType = ConfigManager.Get(EConfigIndex.t_weapon,self.number).weaponType;    --武器攻击类型：范围，反射
	self.rare = ConfigManager.Get(EConfigIndex.t_weapon,self.number).rarity;				--武器稀有度
	self.skill1 = ConfigManager.Get(EConfigIndex.t_weapon,self.number).skill1;            --必杀技
	self.skill2 = ConfigManager.Get(EConfigIndex.t_weapon,self.number).skill2;            --支援技
	self.breakEffect = {};
	for i = 1,5 do
		self.breakEffect[i] = ConfigManager.Get(EConfigIndex.t_weapon,self.number)["breakEffect"..i];  --界限突破效果
	end
	if (self.break_through > self.rare) then
		self.break_through = self.rare;
	end

	self:UpdateInfo(self);
	
end

function CardWeapon:AddExp(exp)   --增加经验
	self.cur_exp = self.cur_exp + exp;
	if(self.cur_exp + exp >= self.upexp and self.level < self.maxLevel)then   --如果当前等级小于最大等级  并且经验超过所需经验
		self.level = self.level + 1;
		self.cur_exp = self.cur_exp - self.upexp;
		self:UpdateInfo(self);
	elseif(self.cur_exp + exp >= self.upexp and self.level >= self.maxLevel)then --如果当前等级大于等于最大等级
		self.cur_exp = self.upexp;
	end
end


function CardWeapon:UpdateInfo(out)
	out.addHP = _G["gd_weapon_"..out.number][out.level].addHP;	    --增加生命值
	out.addATK = _G["gd_weapon_"..out.number][out.level].addATK;	--增加攻击力
	out.addSpeed = _G["gd_weapon_"..out.number][out.level].addSpeed;     --增加速度
	out.addDefence = _G["gd_weapon_"..out.number][out.level].addDefence; --增加防御力
	out.control = _G["gd_weapon_"..out.number][out.level].control; --所需武器掌控力
	out.upexp = _G["gd_weapon_"..out.number][out.level].upexp;     --升级所需经验
	out.price = _G["gd_weapon_"..out.number][out.level].price;     --卖出价格
	
	out.maxLevel = CardWeapon.EMaxLevel[self.break_through];           --最大等级
end





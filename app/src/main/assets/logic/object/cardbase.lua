-- require 'Class'
CardBase = Class("CardBase");

--卡牌稀有度
CardBase.E_cardRare = {
	n = 1,
	r = 2,
	sr = 3,
	ssr = 4,
};

--卡牌类型
CardBase.E_cardType = {
	kong = 0,
	jian = 1,
	ji = 2,
	rui = 3,
	te = 4,
	weapon = 5,
};

--卡牌攻击类型
CardBase.E_cardAttackType = {
	gedou = 1,
	fanshe = 2,
	guanchuan = 3,
	sheji = 4,
	fanwei = 5,
};

CardBase.E_cardRace = {
	human = 1,
	ghoul = 2,
};

function CardBase:Init(data)
	self:InitData(data)
    self:initUI();
end

function CardBase:InitData(data)
	--唯一标识,需要外部传入
	self.index = data.index;					--唯一编号
	self.order = data.order;					--入手顺序
	self.number = data.number;					--编号
	self.level = data.level;					--等级
	self.awake = data.awake;					--觉醒次数
	self.break_through = data.break_through;	--界限突破次数
	self.cur_exp = data.cur_exp;				--当前经验
	self.type = data.type;						--类型
	self.check = data.check;					--是否已经查看
	self.composite_protect = data.composite_protect;		--合成保护
	self.lock = data.lock;						--锁定卡牌
	self.name = data.name;
	self.leadPower = data.leadPower;
	self.hp = data.hp;
	self.attack = data.attack;
	self.speed = data.speed;
	self.attackType = data.attackType;
	self.rare = data.rare;
	self.price = data.price;
	self.race = data.race;
    self.team = data.team;
	
end

function CardBase:initUI()
	
end

function CardBase:initBigCard(cardObj)
	if(self.rare == CardBase.E_cardRare.n)then
		local sp_type = ngui.find_sprite(cardObj, "sp_card_type" );
		local lab_num = ngui.find_label(cardObj, "lab_num" );
		local sp_card_awake1 = ngui.find_sprite(cardObj, "sp_card_awake1" );
		
		if(self.type == CardBase.E_cardType.jian)then
			sp_type:set_sprite_name("diban1_1");
		elseif(self.type == CardBase.E_cardType.ji)then
			sp_type:set_sprite_name("diban2_3");
		elseif(self.type == CardBase.E_cardType.rui)then
			sp_type:set_sprite_name("diban3_1");
		elseif(self.type == CardBase.E_cardType.te)then
			sp_type:set_sprite_name("diban4_4");
		end
		lab_num:set_text("No."..tostring(self.number));
		if(self.break_through == 0)then
			sp_card_awake1:set_active(false);
		else
			sp_card_awake1:set_active(true);
		end
	
	elseif(self.rare == CardBase.E_cardRare.r)then
		local sp_type = ngui.find_sprite(cardObj, "sp_card_type" );
		local lab_num = ngui.find_label(cardObj, "lab_num" );
		local sp_card_awake1 = ngui.find_sprite(cardObj, "sp_card_awake1" );
		local sp_card_awake2 = ngui.find_sprite(cardObj, "sp_card_awake2" );
		
		if(self.type == CardBase.E_cardType.jian)then
			sp_type:set_sprite_name("diban1_1");
		elseif(self.type == CardBase.E_cardType.ji)then
			sp_type:set_sprite_name("diban2_3");
		elseif(self.type == CardBase.E_cardType.rui)then
			sp_type:set_sprite_name("diban3_1");
		elseif(self.type == CardBase.E_cardType.te)then
			sp_type:set_sprite_name("diban4_4");
		end
		
		lab_num:set_text("No."..tostring(self.number));
		if(self.break_through == 0)then
			sp_card_awake1:set_active(false);
			sp_card_awake2:set_active(false);
		elseif(self.break_through == 1)then
			sp_card_awake1:set_active(true);
			sp_card_awake2:set_active(false);
		elseif(self.break_through >= 2)then
			sp_card_awake1:set_active(true);
			sp_card_awake2:set_active(true);
		end
	
	elseif(self.rare == CardBase.E_cardRare.sr)then
		local sp_type = ngui.find_sprite(cardObj, "sp_card_type" );
		local lab_num = ngui.find_label(cardObj, "lab_num" );
		local sp_SR_star1 = ngui.find_sprite(cardObj, "sp_card_awake1" );
		local sp_SR_star2 = ngui.find_sprite(cardObj, "sp_card_awake2" );
		local sp_SR_star3 = ngui.find_sprite(cardObj, "sp_card_awake3" );
		
		if(self.type == CardBase.E_cardType.jian)then
			sp_type:set_sprite_name("diban1_1");
		elseif(self.type == CardBase.E_cardType.ji)then
			sp_type:set_sprite_name("diban2_3");
		elseif(self.type == CardBase.E_cardType.rui)then
			sp_type:set_sprite_name("diban3_1");
		elseif(self.type == CardBase.E_cardType.te)then
			sp_type:set_sprite_name("diban4_4");
		end
		
		lab_num:set_text("No."..tostring(self.number));
		if(self.break_through == 0)then
			sp_SR_star1:set_active(false);
			sp_SR_star2:set_active(false);
			sp_SR_star3:set_active(false);
		elseif(self.break_through == 1)then
			sp_SR_star1:set_active(true);
			sp_SR_star2:set_active(false);
			sp_SR_star3:set_active(false);
		elseif(self.break_through == 2)then
			sp_SR_star1:set_active(true);
			sp_SR_star2:set_active(true);
			sp_SR_star3:set_active(false);
		elseif(self.break_through >= 3)then
			sp_SR_star1:set_active(true);
			sp_SR_star2:set_active(true);
			sp_SR_star3:set_active(true);
		end
	
	elseif(self.rare == CardBase.E_cardRare.ssr)then
		local sp_type = ngui.find_sprite(cardObj, "sp_card_type" );
		local lab_num = ngui.find_label(cardObj, "lab_num" );
		local sp_SSR_star1 = ngui.find_sprite(cardObj, "sp_card_awake1" );
		local sp_SSR_star2 = ngui.find_sprite(cardObj, "sp_card_awake2" );
		local sp_SSR_star3 = ngui.find_sprite(cardObj, "sp_card_awake3" );
		local sp_SSR_star4 = ngui.find_sprite(cardObj, "sp_card_awake4" );
		
		if(self.type == CardBase.E_cardType.jian)then
			sp_type:set_sprite_name("diban1_1");
		elseif(self.type == CardBase.E_cardType.ji)then
			sp_type:set_sprite_name("diban2_3");
		elseif(self.type == CardBase.E_cardType.rui)then
			sp_type:set_sprite_name("diban3_1");
		elseif(self.type == CardBase.E_cardType.te)then
			sp_type:set_sprite_name("diban4_4");
		end
		
		lab_num:set_text("No."..tostring(self.number));
		if(self.break_through == 0)then
			sp_SSR_star1:set_active(false);
			sp_SSR_star2:set_active(false);
			sp_SSR_star3:set_active(false);
			sp_SSR_star4:set_active(false);
		elseif(self.break_through == 1)then
			sp_SSR_star1:set_active(true);
			sp_SSR_star2:set_active(false);
			sp_SSR_star3:set_active(false);
			sp_SSR_star4:set_active(false);
		elseif(self.break_through == 2)then
			sp_SSR_star1:set_active(true);
			sp_SSR_star2:set_active(true);
			sp_SSR_star3:set_active(false);
			sp_SSR_star4:set_active(false);
		elseif(self.break_through == 3)then
			sp_SSR_star1:set_active(true);
			sp_SSR_star2:set_active(true);
			sp_SSR_star3:set_active(true);
			sp_SSR_star4:set_active(false);
		elseif(self.break_through == 4)then
			sp_SSR_star1:set_active(true);
			sp_SSR_star2:set_active(true);
			sp_SSR_star3:set_active(true);
			sp_SSR_star4:set_active(true);
		end
	
	end
end

function CardBase:initSmallCard(cardObj)
	self.item = cardObj;
	self.sp_new = ngui.find_sprite(cardObj, "new" );
	self.sp_N = ngui.find_sprite(cardObj, "N" );
	self.sp_N_star1 = ngui.find_sprite(cardObj, "N/sp_star1" );
	self.sp_R = ngui.find_sprite(cardObj, "R" );
	self.sp_R_star1 = ngui.find_sprite(cardObj, "R/sp_star1" );
	self.sp_R_star2 = ngui.find_sprite(cardObj, "R/sp_star2" );
	self.sp_SR = ngui.find_sprite(cardObj, "SR" );
	self.sp_SR_star1 = ngui.find_sprite(cardObj, "SR/sp_star1" );
	self.sp_SR_star2 = ngui.find_sprite(cardObj, "SR/sp_star2" );
	self.sp_SR_star3 = ngui.find_sprite(cardObj, "SR/sp_star3" );
	self.sp_SSR = ngui.find_sprite(cardObj, "SSR" );
	self.sp_SSR_star1 = ngui.find_sprite(cardObj, "SSR/sp_star1" );
	self.sp_SSR_star2 = ngui.find_sprite(cardObj, "SSR/sp_star2" );
	self.sp_SSR_star3 = ngui.find_sprite(cardObj, "SSR/sp_star3" );
	self.sp_SSR_star4 = ngui.find_sprite(cardObj, "SSR/sp_star4" );
	self.sp_type = ngui.find_sprite(cardObj, "type" );
	self.sp_rare = ngui.find_sprite(cardObj, "rare" );
	self.sp_equip = ngui.find_sprite(cardObj, "equip" );
	self.sp_team = ngui.find_sprite(cardObj, "team" );
    if self.team ~= CardHuman.ETeamType.None then
        self.sp_team:set_active(true);
        local sp = ngui.find_sprite(cardObj,"team/leader");
        if self.team == CardHuman.ETeamType.Leader then
            self.sp_team:set_sprite_name("lingxing2");
            sp:set_sprite_name("L");
        elseif self.team == CardHuman.ETeamType.Member1 then
            self.sp_team:set_sprite_name("lingxing3");
            sp:set_sprite_name("M1");
        elseif self.team == CardHuman.ETeamType.Member2 then
            self.sp_team:set_sprite_name("lingxing4");
            sp:set_sprite_name("M2");
        end
    else
        self.sp_team:set_active(false);
    end
	self.sp_leader = ngui.find_sprite(cardObj, "leader" );
	self.lab_level = ngui.find_label(cardObj, "label_number" );
	
	if(self.check == 0)then
		self.sp_new:set_active(false);
	else
		self.sp_new:set_active(true);
	end
	self.sp_equip:set_active(false);
	if(self.rare == CardBase.E_cardRare.n)then
		self.sp_N:set_active(true);
		self.sp_R:set_active(false);
		self.sp_SR:set_active(false);
		self.sp_SSR:set_active(false);
		self.sp_rare:set_sprite_name("diban1_3");
		if(self.break_through == 0)then
			self.sp_N_star1:set_active(false);
		else
			self.sp_N_star1:set_active(true);
		end
	elseif(self.rare == CardBase.E_cardRare.r)then
		self.sp_N:set_active(false);
		self.sp_R:set_active(true);
		self.sp_SR:set_active(false);
		self.sp_SSR:set_active(false);
		self.sp_rare:set_sprite_name("diban2_4");
		if(self.break_through == 0)then
			self.sp_R_star1:set_active(false);
			self.sp_R_star2:set_active(false);
		elseif(self.break_through == 1)then
			self.sp_R_star1:set_active(true);
			self.sp_R_star2:set_active(false);
		elseif(self.break_through >= 2)then
			self.sp_R_star1:set_active(true);
			self.sp_R_star2:set_active(true);
		end
	elseif(self.rare == CardBase.E_cardRare.sr)then
		self.sp_N:set_active(false);
		self.sp_R:set_active(false);
		self.sp_SR:set_active(true);
		self.sp_SSR:set_active(false);
		self.sp_rare:set_sprite_name("diban3_2");
		if(self.break_through == 0)then
			self.sp_SR_star1:set_active(false);
			self.sp_SR_star2:set_active(false);
			self.sp_SR_star3:set_active(false);
		elseif(self.break_through == 1)then
			self.sp_SR_star1:set_active(true);
			self.sp_SR_star2:set_active(false);
			self.sp_SR_star3:set_active(false);
		elseif(self.break_through == 2)then
			self.sp_SR_star1:set_active(true);
			self.sp_SR_star2:set_active(true);
			self.sp_SR_star3:set_active(false);
		elseif(self.break_through >= 3)then
			self.sp_SR_star1:set_active(true);
			self.sp_SR_star2:set_active(true);
			self.sp_SR_star3:set_active(true);
		end
	elseif(self.rare == CardBase.E_cardRare.ssr)then
		self.sp_N:set_active(false);
		self.sp_R:set_active(false);
		self.sp_SR:set_active(false);
		self.sp_SSR:set_active(true);
		self.sp_rare:set_sprite_name("diban4_2");
		if(self.break_through == 0)then
			self.sp_SSR_star1:set_active(false);
			self.sp_SSR_star2:set_active(false);
			self.sp_SSR_star3:set_active(false);
			self.sp_SSR_star4:set_active(false);
		elseif(self.break_through == 1)then
			self.sp_SSR_star1:set_active(true);
			self.sp_SSR_star2:set_active(false);
			self.sp_SSR_star3:set_active(false);
			self.sp_SSR_star4:set_active(false);
		elseif(self.break_through == 2)then
			self.sp_SSR_star1:set_active(true);
			self.sp_SSR_star2:set_active(true);
			self.sp_SSR_star3:set_active(false);
			self.sp_SSR_star4:set_active(false);
		elseif(self.break_through == 3)then
			self.sp_SSR_star1:set_active(true);
			self.sp_SSR_star2:set_active(true);
			self.sp_SSR_star3:set_active(true);
			self.sp_SSR_star4:set_active(false);
		elseif(self.break_through == 4)then
			self.sp_SSR_star1:set_active(true);
			self.sp_SSR_star2:set_active(true);
			self.sp_SSR_star3:set_active(true);
			self.sp_SSR_star4:set_active(true);
		end
	end
	
	if(self.type == CardBase.E_cardType.jian)then
		self.sp_type:set_sprite_name("diban1_1");
	elseif(self.type == CardBase.E_cardType.ji)then
		self.sp_type:set_sprite_name("diban2_3");
	elseif(self.type == CardBase.E_cardType.rui)then
		self.sp_type:set_sprite_name("diban3_1");
	elseif(self.type == CardBase.E_cardType.te)then
		self.sp_type:set_sprite_name("diban4_4");
	end
	
	--self.lab_level:set_text(tostring(self.level));
	
end

function CardBase:AddExp(exp)

end


return CardBase;

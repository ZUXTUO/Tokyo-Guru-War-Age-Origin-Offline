local path_res =
{
    ui = "assetbundles/prefabs/ui/fight/ui_803_fight.assetbundle",
}
-- ui数据
local m_PlayerExp = nil;
local m_HeroExp = nil;
local m_timeCount = 1;
local expTimer  = nil;
local m_timerloop = 100;
local m_timerTime = 0.5;
local m_PlayerUpExp = 5000; 
local m_PlayerCurExp = 500;
local m_DropItem  = nil;
local m_cardInfo  = {};
local m_heroLevel = {};
local m_oldHeroLevel = {};
local m_isLevelUp = {};
local m_data = nil;
local m_Callback = nil;

-- ui控件
local ui = nil;
local spRole = nil;
local btnNext = nil;
local nodeExp = nil;
local nodePlayerUp = nil;
local nodeHeroUp   = nil;
local animator     = nil;

--经验界面
local heroRoot = {};
local heroName = {};
local heroExp  = {};
local heroLevel= {};
local heroCard = {};
local heroValue = {};
local heroProExp  = {{},{},{},{}};
local heroHeadObj = {};
--玩家升级界面
local spPlayerLevel_1 = nil;
local spPlayerLevel_2 = nil;
local strengthRoot = nil;
local spStrength = nil;
local labStrength = nil;

local moneyRoot = nil;
local spMoney = nil;
local labMoney = nil;

local equipRoot = nil;
local spEquipLevel = nil;
local labEquipLevel = nil;

local attributeRoot = nil;
local spAddAttribute = nil;
local labAddAttribute = nil;

local labPlayerName = nil;

--卡牌升级界面
local spHeroLevel_1 = nil;
local spHeroLevel_2 = nil;
local labHeroName = nil;

local labHeroList = {};
local labHeroAddList = {};

local heroUpdateCount = 0;
local heroProList = {};
local heroTimer  = nil;

FightExpUi = Class("FightExpUi");

--显示经验界面需要传入data.playerExp 玩家获得经验 data.heroExp 卡牌获得经验
--显示奖励物品界面需要传入data.items 格式为{{id = 30000001,num = 1},{id = 30000002,num = 1}}
function FightExpUi.Init(data)
    FightExpUi.InitData(data);
    FightExpUi.LoadAsset();
end

function FightExpUi.InitData(data)
   m_data = data;
   m_PlayerExp = m_data.playerExp or 5500;
   m_HeroExp   = m_data.heroExp or {};
   m_DropItem  = m_data.dropItem;
   m_Callback  = data.callback;
end

function FightExpUi.LoadAsset()
	if ui == nil then
        ResourceLoader.LoadAsset(path_res.ui, FightExpUi.on_loaded);
	end
end

function FightExpUi.DestoryUi()
	if(ui ~= nil) then
		m_data     = nil;
		m_Callback = nil;
		m_DropItem = nil;
		m_cardInfo = {};
		m_heroLevel= {};
		m_oldHeroLevel = {};
		m_isLevelUp= {}
		heroRoot = {};
		heroName = {};
		heroExp  = {};
		heroLevel= {};
		heroValue= {};
		heroProExp  = {{},{},{},{}};
		heroHeadObj = {};
		if expTimer then
			timer.stop(expTimer);
			expTimer = nil;
		end
		heroProList = {};
		if heroTimer then
			timer.stop(heroTimer);
			heroTimer = nil;
		end
		for k,v in pairs(heroCard) do
			v:DestroyUi();
		end
		heroCard = {};
		ui:set_active(false);
		ui = nil;
	end
end

function FightExpUi.on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == path_res.ui then
		FightExpUi.InitUi(asset_obj);
	end
end

function FightExpUi.InitUi(obj)
    local _ui = asset_game_object.create(obj);
    _ui:set_parent(Root.get_root_ui_2d());
    _ui:set_local_scale(Utility.SetUIAdaptation());
    _ui:set_name("fight_exp_ui");
    ui = _ui;
	--公用
	spRole = ngui.find_sprite(_ui,"fight_exp_ui/animation/sp_head");
	btnNext = ngui.find_button(_ui,"fight_exp_ui/animation/sp_mark");
	nodeExp = asset_game_object.find("fight_exp_ui/animation/bk1");
	nodePlayerUp = asset_game_object.find("fight_exp_ui/animation/bk2");
	nodeHeroUp   = asset_game_object.find("fight_exp_ui/animation/bk3");
	animator     = asset_game_object.find("fight_exp_ui/animation");
	btnNext:set_on_click("FightExpUi.on_next_click");
	
	local defTeam = g_dataCenter.player:GetDefTeam();
	--经验界面
	for i = 1,4 do
		heroRoot[i] = asset_game_object.find("fight_exp_ui/animation/bk1/hero"..i);
		heroHeadObj[i] = asset_game_object.find("fight_exp_ui/animation/bk1/hero"..i.."/small_card1");
		heroExp[i]  = ngui.find_label(_ui,"fight_exp_ui/animation/bk1/hero"..i.."/hero/lab_exp");
		heroName[i] = ngui.find_label(_ui,"fight_exp_ui/animation/bk1/hero"..i.."/hero/lab_name");
		heroLevel[i]= ngui.find_label(_ui,"fight_exp_ui/animation/bk1/hero"..i.."/hero/lab_level");
		heroProExp[i][1] = ngui.find_progress_bar(_ui,"fight_exp_ui/animation/bk1/hero"..i.."/hp/pro_hp2");
		heroProExp[i][2] = ngui.find_progress_bar(_ui,"fight_exp_ui/animation/bk1/hero"..i.."/hp/pro_hp1");
		if i >= 2 and i <= (#defTeam + 1) then
			heroRoot[i]:set_active(true);
			-- heroCard[i] = SmallCardUi:new({obj=heroHeadObj[i]});
			-- heroCard[i]:SetParent(heroRoot[i]);
			-- heroCard[i].ui:set_local_scale(0.65,0.65,0.65);
			-- heroCard[i]:SetPosition(-5,110,0);
		--如果队伍里只有不到3人
		elseif i > (#defTeam + 1) then
			heroRoot[i]:set_active(false);
		else
			heroRoot[i]:set_active(true);
		end
	end
	--玩家升级界面
	spPlayerLevel_1 = ngui.find_sprite(_ui,"fight_exp_ui/animation/bk2/hero/num/num1");
	spPlayerLevel_2 = ngui.find_sprite(_ui,"fight_exp_ui/animation/bk2/hero/num/num2");
	strengthRoot = asset_game_object.find("fight_exp_ui/animation/bk2/hero/ap")
	spStrength      = ngui.find_sprite(strengthRoot,"icon1");
	labStrength     = ngui.find_label(strengthRoot,"lab1");

	moneyRoot = asset_game_object.find("fight_exp_ui/animation/bk2/hero/gold");
	spMoney 	    = ngui.find_sprite(moneyRoot,"icon2");
	labMoney 	    = ngui.find_label(moneyRoot,"lab2");

	equipRoot = asset_game_object.find("fight_exp_ui/animation/bk2/hero/equip");
	spEquipLevel    = ngui.find_sprite(equipRoot,"icon3");
	labEquipLevel   = ngui.find_label(equipRoot,"lab3");

	attributeRoot = asset_game_object.find("fight_exp_ui/animation/bk2/hero/tower");
	spAddAttribute  = ngui.find_sprite(attributeRoot,"icon4");
	labAddAttribute = ngui.find_label(attributeRoot,"lab4");

	labPlayerName   = ngui.find_label(_ui,"fight_exp_ui/animation/bk2/hero/lab_name");
	

	--卡牌升级界面
	spHeroLevel_1 = ngui.find_sprite(_ui,"fight_exp_ui/animation/bk3/hero/num/num1");
	spHeroLevel_2 = ngui.find_sprite(_ui,"fight_exp_ui/animation/bk3/hero/num/num2");
	labHeroName   = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/lab_name");


	labHeroList[1] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/life/lab");
	labHeroAddList[1] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/life/lab1");
	labHeroList[2]  = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/goto1/lab");
	labHeroAddList[2]  = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/goto1/lab1");
	labHeroList[3] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/goto2/lab");
	labHeroAddList[3] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/goto2/lab1");
	labHeroList[4] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/defense1/lab");
	labHeroAddList[4] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/defense1/lab1");
	labHeroList[5] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/defense2/lab");
	labHeroAddList[5] = ngui.find_label(_ui,"fight_exp_ui/animation/bk3/hero/defense2/lab1");
	
	FightExpUi.playExp();
end

-- 我方英雄
function FightExpUi.playExp()
	nodePlayerUp:set_active(false);
	nodeHeroUp:set_active(false);
	
	--我方玩家
	heroExp[1]:set_text('+'..tostring(m_PlayerExp));
	heroName[1]:set_text(g_dataCenter.player.name);
	heroLevel[1]:set_text(tostring(g_dataCenter.player.oldData.level));
	heroValue[1] = g_dataCenter.player:GetOldExpPro();
	m_heroLevel[1] = g_dataCenter.player.oldData.level;
	m_oldHeroLevel[1] = m_heroLevel[1];
	heroProExp[1][1]:set_value(heroValue[1]);
	heroProExp[1][2]:set_value(heroValue[1]);
	m_isLevelUp[1] = g_dataCenter.player:IsLevelUp();
	--我方卡牌 从2开始
	local defTeam = g_dataCenter.player:GetDefTeam()
	for i = 2,4 do
		if heroCard[i] and m_HeroExp[i-1] then
			heroRoot[i]:set_active(true);
			local uuid = defTeam[i-1];
			local cardInfo = g_dataCenter.package:find_card(1, uuid);
			if cardInfo then
				m_cardInfo[i] = cardInfo;
				m_heroLevel[i]= cardInfo.oldLevel;
				m_oldHeroLevel[i] = m_heroLevel[i];
				heroExp[i]:set_text('+'..tostring(m_HeroExp[i-1]));
				heroCard[i]:SetData(cardInfo);
				heroName[i]:set_text(cardInfo.name);
				heroLevel[i]:set_text(tostring(cardInfo.oldLevel));
				heroValue[i] = cardInfo:GetOldExpPro();
				heroProExp[i][1]:set_value(heroValue[i]);
				heroProExp[i][2]:set_value(heroValue[i]);
				m_isLevelUp[i] = cardInfo:IsLevelUp();
			end
		else
			heroRoot[i]:set_active(false);
		end
	end
	m_timeCount = 0;
	expTimer = timer.create("FightExpUi.on_timer",m_timerTime,-1);
	animator:animator_play("ui_803_fight");
end

function FightExpUi.playPlayerUp()
	nodeExp:set_active(false);
	nodePlayerUp:set_active(true);
	nodeHeroUp:set_active(false);
	labPlayerName:set_text(g_dataCenter.player.name);
	animator:animator_play("ui_803_fight");

	local cf = ConfigManager.Get(EConfigIndex.t_player_level,m_heroLevel[1]);
	if cf then
		local posX,posY = strengthRoot:get_local_position();
		local fixDis = 61;
		if cf.ap ~= 0 then
			strengthRoot:set_local_position(posX, posY, 0);
			posY = posY - fixDis;
			strengthRoot:set_active(true);
			local text = gAllString.Ap.."+"..tostring(cf.ap);
			labStrength:set_text(text);

		else
			strengthRoot:set_active(false);
		end
		if cf.add_gold ~= 0 then
			moneyRoot:set_local_position(posX, posY, 0);
			posY = posY - fixDis;
			moneyRoot:set_active(true);
			local text = "+"..tostring(cf.add_gold)..gAllString.Gold;
			labMoney:set_text(text);
		else
			moneyRoot:set_active(false);
		end
		if cf.add_equip_level ~= 0 then
			equipRoot:set_local_position(posX, posY, 0);
			posY = posY - fixDis;
			equipRoot:set_active(true);
			local text = gAllString.EquipMaxLevel.."+"..tostring(cf.add_equip_level);
			labEquipLevel:set_text(text);
		else
			equipRoot:set_active(false);
		end
		local addProperty = false;
		for i = 1, 5 do
			if cf["add_property_"..i] ~= 0 then
				addProperty = true;
				break;
			end
		end
		if addProperty then
			attributeRoot:set_local_position(posX, posY, 0);
			posY = posY - fixDis;
			attributeRoot:set_active(true);
			local text = gAllString.PlayerPro;
			labAddAttribute:set_text(text);
		else
			attributeRoot:set_active(false);
		end

		if m_heroLevel[1] < 10 then
			spPlayerLevel_1:set_active(true);
			spPlayerLevel_2:set_active(false);
			spPlayerLevel_1:set_position(0, 0, 0);
			spPlayerLevel_1:set_sprite_name("yidadaoji"..tostring(m_heroLevel[1]));
		else
			spPlayerLevel_1:set_active(true);
			spPlayerLevel_2:set_active(true);
			spPlayerLevel_1:set_position(20, 0, 0);
			spPlayerLevel_2:set_position(-30, 0, 0);
			local one = m_heroLevel[1] % 10;
			local two = math.floor(m_heroLevel[1] / 10);
			spPlayerLevel_1:set_sprite_name("yidadaoji"..tostring(one));
			spPlayerLevel_2:set_sprite_name("yidadaoji"..tostring(two));
		end
	end
	animator:animator_play("ui_803_fight");
end

local indexToConfig = 
{
	"max_hp",
	"phy_at_power",
	"energy_at_power",
	"phy_def_power",
	"energy_def_power",
};

function FightExpUi.playHeroUp(index)
	nodeExp:set_active(false);
	nodePlayerUp:set_active(false);
	nodeHeroUp:set_active(true);
	
	labHeroName:set_text(m_cardInfo[index].name);
	animator:animator_play("ui_803_fight");

	if m_heroLevel[index] < 10 then
		spHeroLevel_1:set_active(true);
		spHeroLevel_2:set_active(false);
		spHeroLevel_1:set_position(10, 0, 0);
		spHeroLevel_1:set_sprite_name("yidadaoji"..tostring(m_heroLevel[index]));
	else
		spHeroLevel_1:set_active(true);
		spHeroLevel_2:set_active(true);
		spHeroLevel_1:set_position(35, 0, 0);
		spHeroLevel_2:set_position(-15, 0, 0);
		local one = m_heroLevel[index] % 10;
		local two = math.floor(m_heroLevel[index] / 10);
		spHeroLevel_1:set_sprite_name("yidadaoji"..tostring(one));
		spHeroLevel_2:set_sprite_name("yidadaoji"..tostring(two));
	end
	if heroCard[index] then
		local oldCf = CardHuman.GetLevelConfig(heroCard[index].cardInfo.number, m_oldHeroLevel[index], heroCard[index].cardInfo.config);
		--app.log("来了    "..table.tostring(oldCf));
		for i = 1, 5 do
			labHeroList[i]:set_text(tostring(oldCf[indexToConfig[i]]));
			labHeroAddList[i]:set_text("");
		end
		local newCf = CardHuman.GetLevelConfig(heroCard[index].cardInfo.number, m_heroLevel[index], heroCard[index].cardInfo..config);
		--app.log(tostring(m_heroLevel[index]).."   来了2    "..table.tostring(newCf));
		heroProList.curIndex = index;
		heroProList[index] = {}
		local data = heroProList[index];
		data.add = {};
		local maxNumber = 0;
		for i = 1, 5 do
			data[i] = newCf[indexToConfig[i]] - oldCf[indexToConfig[i]];
			data.add[i] = 0;
			maxNumber = maxNumber + data[i];
		end
		
		data.addValue = maxNumber / m_timerloop;
		--app.log("最大数量   "..tostring(maxNumber).."   addValue="..tostring(data.addValue));
		data.curAddIndex = 1;

		heroUpdateCount = 0;
		heroTimer = timer.create("FightExpUi.UpdateHeroUp", m_timerTime, -1);
	end

	
	animator:animator_play("ui_803_fight");
end

function FightExpUi.UpdateHeroUp()
	if heroUpdateCount <= m_timerloop then
		local data = heroProList[heroProList.curIndex];
		local curIndex = data.curAddIndex;
		if curIndex < 6 and labHeroAddList[curIndex] and data[curIndex] and data.add[curIndex] then
			--app.log("index ="..tostring(curIndex).."     count="..tostring(heroUpdateCount));
			data.add[curIndex] = data.add[curIndex] + data.addValue;
			if data.add[curIndex] >= data[curIndex] then
				local temp = data.add[curIndex] - data[curIndex];
				data.add[curIndex] = data[curIndex];
				labHeroAddList[curIndex]:set_text("+"..tostring(math.ceil(data.add[curIndex])));

				curIndex = curIndex + 1;
				while data.add[curIndex] and temp > 0 do
					data.add[curIndex] = data.add[curIndex] + temp;
					if data.add[curIndex] > data[curIndex] then
						temp = data.add[curIndex] - data[curIndex];
						data.add[curIndex] = data[curIndex];
						labHeroAddList[curIndex]:set_text("+"..tostring(math.ceil(data.add[curIndex])));	
						curIndex = curIndex + 1;
					else
						labHeroAddList[curIndex]:set_text("+"..tostring(math.ceil(data.add[curIndex])));	
						break;
					end
				end
				data.curAddIndex = curIndex;
				--app.log("curAddIndex = "..tostring(data.curAddIndex));
			else
				labHeroAddList[curIndex]:set_text("+"..tostring(math.ceil(data.add[curIndex])));	
			end
			
		end
	else
		if heroTimer then
			timer.stop(heroTimer);
			heroTimer = nil;
		end
	end
	heroUpdateCount = heroUpdateCount + 1;
end

function FightExpUi.ContinueHeroUp()
	if heroTimer then
		timer.stop(heroTimer);
		heroTimer = nil;
	end
	local data = heroProList[heroProList.curIndex];
	if data then
		for i = 1, 5 do
			data.add[i] = data[i];
			labHeroAddList[i]:set_text("+"..tostring(data.add[i]))
		end
		data.curAddIndex = 6;
	else
		app.log("点击后获取英雄索引失败   index="..tostring(heroProList.curIndex));
	end
	
end

function FightExpUi.on_timer()
	if m_timeCount <= m_timerloop then
		if m_timeCount == 0 then
			--animator:animator_play("ui_803_fight");
		end
		for i = 1,4 do
			if heroCard[i] and m_HeroExp[i-1] then
				local roleUp = CardHuman.GetLevelConfig(heroCard[i].cardInfo.number, m_heroLevel[i], heroCard[i].cardInfo.config);
				if roleUp then
					local maxExp = roleUp.upexp;
					heroValue[i] = heroValue[i] + (m_HeroExp[i-1] / m_timerloop)/maxExp;
				end
				heroProExp[i][2]:set_value(heroValue[i]);
				FightExpUi.levelUp(i);
			elseif i == 1 then
				local cf = ConfigManager.Get(EConfigIndex.t_player_level,m_heroLevel[i]);
				local maxExp = cf.exp;
				heroValue[i] = heroValue[i] + (m_PlayerExp / m_timerloop)/maxExp;
				heroProExp[i][2]:set_value(heroValue[i]);
				FightExpUi.levelUp(i);
			end	
		end 
	else
		if expTimer then
			timer.stop(expTimer);
			expTimer = nil;
		end
	end
	m_timeCount = m_timeCount + 1;
end

function FightExpUi.levelUp(index)
	if heroValue[index] < 1 then 
		return; 
	end
	heroValue[index] = 0;
	m_heroLevel[index] = m_heroLevel[index] + 1;
	heroProExp[index][1]:set_value(0);
	heroLevel[index]:set_text(tostring(m_heroLevel[index])); 
end

function FightExpUi.countExp()
	if expTimer then 
		animator:animator_play("ui_803_fight_null");
		timer.stop(expTimer);
		expTimer = nil;
	end
	for i = 1,4 do
		if heroCard[i] then
			--还原成最原始状态
			local info = heroCard[i].cardInfo;
			if info then
				m_HeroExp         = info.cur_exp or 3200;
				m_heroLevel[i]	  = info.level;
				heroValue[i] = info:GetExpPro();
			end
			
			heroLevel[i]:set_text(tostring(m_heroLevel[i])); 
			heroProExp[i][2]:set_value(heroValue[i]);
			if m_isLevelUp[i] then
				heroProExp[i][1]:set_value(0);
			end
		elseif i == 1 then
			local data = g_dataCenter.player;
			m_PlayerExp     = data.exp or 5500;
			m_heroLevel[i]  = data.level;
			heroValue[i] = g_dataCenter.player:GetExpPro();

			heroLevel[i]:set_text(tostring(m_heroLevel[i])); 
			heroProExp[i][2]:set_value(heroValue[i]);
			if m_isLevelUp[i] then
				heroProExp[i][1]:set_value(0);
			end
		end
	end	
end

function FightExpUi.on_next_click()
	if expTimer then 
		FightExpUi.countExp();
		return;
	end
	if heroTimer then
		FightExpUi.ContinueHeroUp();
		return;
	end
	
	for k,v in pairs(m_isLevelUp) do
		--if v == true then
			if m_isLevelUp[k] then
				if k == 1 then
					FightExpUi.playPlayerUp();
				else
					FightExpUi.playHeroUp(k);
				end
				m_isLevelUp[k] = nil;
				return;
			end
		--end
	end
	-- TODO 临时去掉给奖励
	-- if m_DropItem and #m_DropItem ~= 0 then
	-- 	local data = {};
	-- 	data.dropItem  = m_DropItem;
	-- 	data.callback = m_Callback;
	-- 	FightAwardUi.Init(data);
	-- else
		if m_Callback then
			m_Callback();
		end
	-- end
	ui:set_active(false);
	FightExpUi.DestoryUi();
end

function FightExpUi.callBack(obj,eventParm)
	if animator then
		animator:animator_play("ui_803_fight_null");
	end
end
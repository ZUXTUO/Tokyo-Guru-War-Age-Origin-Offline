
Egg = Class("Egg");

function Egg:HasFreeHero()
	local timeNow = system.time();
	return  (self.freeHeroTimes > 0 and self.heroCdTime < timeNow) or
			(self.freeHeroTimesGold > 0 and self.heroCdTimeGold < timeNow);
end

function Egg:HasFreeEquip()
	return 0 ~= self.freeEquipTimes;
end

function Egg:gc_hero_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes)
	self.freeHeroTimes = byfreeTime;
	self.useOnceHeroTimes = useOnceTimes or 0;
	self.useTenHeroTimes = userTenTimes or 0;
	self.heroTodayDiscountTimes = todayDiscountTimes;
	self.heroCdTime = system.time() + CDLeftTime;
	self.curHeroTimes = (useOnceTimes+1)%self.mustGetHeroCnt;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Enlist_2_crystal);
end

function Egg:gc_hero_info_gold(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
	self.freeHeroTimesGold = byfreeTime;
	self.useOnceHeroTimesGold = useOnceTimes or 0;
	self.useTenHeroTimesGold = userTenTimes or 0;
	self.heroCdTimeGold = system.time() + CDLeftTime;
	self.curHeroTimesGold = (useOnceTimes+1)%self.mustGetHeroCntGold;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Enlist_2_gold);
	app.log("-------------- useOnceTimes:" .. useOnceTimes);
	if CDLeftTime > 0 then
		TimerManager.Add(function ()
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Enlist_2_gold);
		end, CDLeftTime*1000, 1);
	end
end

function Egg:gc_hunxia_state(nIndex)
	self.hunxiaGroupId = nIndex;
end

function Egg:GetHunxiaGroupId()
	return self.hunxiaGroupId;
end

function Egg:gc_equip_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
	self.freeEquipTimes = byfreeTime;
	self.useOnceEquipTimes = useOnceTimes or 0;
	self.useTenEquipTimes = userTenTimes or 0;
	self.curEquipTimes = (useOnceTimes+1)%self.mustGetEquipCnt;

	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_Shop_OpenFirstBtn)
end

function Egg:surplusMustGetEquipCnt()
	return self.mustGetEquipCnt-self.curEquipTimes;
end

function Egg:surplusMustGetHeroCnt()
	return self.mustGetHeroCnt-self.curHeroTimes;
end

function Egg:surplusMustGetHeroCntGold( )
	return self.mustGetHeroCntGold-self.curHeroTimesGold;
end

function Egg:GetUseHeroTenCnt()
	return self.useTenHeroTimes;
end

-- 查询装备宝箱红点提示
-- function Egg:IsEquipTips()
-- 	if self.freeEquipTimes > 0 or PropsEnum.GetValue(IdConfig.EquipBoxKey) > 0 then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

function Egg:Init()
	self.mustGetEquipCnt = 10;
	self.mustGetHeroCnt = 10;
	self.mustGetHeroCntGold = 10;
	self.freeEquipTimes = 0;
	self.freeHeroTimes = 0;
	self.freeHeroTimesGold = 0;
	self.curEquipTimes = 0;
	self.curHeroTimes = 0;
	self.curHeroTimesGold = 0;
	self.useOnceEquipTimes = 0;
	self.useOnceHeroTimes = 0;
	self.useTenHeroTimes = 0;
	self.useOnceHeroTimesGold = 0;
end

function Egg:Finalize()
	self.freeEquipTimes = 0;
	self.freeHeroTimes = 0;
	self.freeHeroTimesGold = 0;
end


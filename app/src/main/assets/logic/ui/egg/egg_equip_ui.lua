EggEquipUi = Class('EggEquipUi', UiBaseClass);
function EggEquipUi:Init(data)
	self.pathRes = "assetbundles/prefabs/text/obt/ui_2601_egg_equip.assetbundle";
	UiBaseClass.Init(self, data);
end

function EggEquipUi:InitData(data)
	UiBaseClass.InitData(self, data);
	self.equipTimeId = nil;
	self.freeEquipTimes = 0;
	self.equipCD = 0;
	-- self.isDraging = false;
	-- self.begin_egg_type = 0;
end

function EggEquipUi:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_equip_time"] = Utility.bind_callback(self,EggEquipUi.on_equip_time);
	self.bindfunc["on_back"] = Utility.bind_callback(self,EggEquipUi.on_back);
	self.bindfunc["on_rule"] = Utility.bind_callback(self,EggEquipUi.on_rule);

	self.bindfunc["on_equip_1"] = Utility.bind_callback(self,EggEquipUi.on_equip_1);
	self.bindfunc["on_equip_10"] = Utility.bind_callback(self,EggEquipUi.on_equip_10);

	self.bindfunc["on_exchange_equip"] = Utility.bind_callback(self,EggEquipUi.on_exchange_equip);

	self.bindfunc["gc_equip_info"] = Utility.bind_callback(self,EggEquipUi.gc_equip_info);
	self.bindfunc["gc_use"] = Utility.bind_callback(self,EggEquipUi.gc_use);
end

function EggEquipUi:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_niudan_sync_equip_info,self.bindfunc['gc_equip_info']);
    PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
end

function EggEquipUi:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_sync_equip_info,self.bindfunc['gc_equip_info']);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
end

function EggEquipUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("egg_equip_ui")
	
	-- local _btnBack = ngui.find_button(self.ui,"top_other/animation/Panel/btn_rule");
	-- _btnBack:set_on_click(self.bindfunc["on_rule"]);


	-- local _btnRule = ngui.find_button(self.ui,"btn_rule[6]");
	-- local _btnExchange = ngui.find_button(self.ui,"");

	-- self.proEquip = {};

	---------------equip-------------
	local equip = self.ui:get_child_by_name("equip");
	--self.btnEquipRule = ngui.find_button(self.ui,"btn_rule");
	--self.nodeEquip = ngui.find_sprite(equip,equip:get_name());
	-- self.proEquip = ngui.find_progress_bar(equip, "/content/sp_di/pro_di");
	--self.lab_soul_equip = ngui.find_label(equip, "content/sp_di/lab");
	self.btn_exchange_equip = ngui.find_button(self.ui, "btn_exchange");
	self.btn_exchange_equip:set_on_click(self.bindfunc["on_exchange_equip"]);
	--self.btnEquipRule:set_event_value("",ENUM.ERuleDesType.ZhuangBeiKu);
	--self.btnEquipRule:set_on_click(self.bindfunc["on_rule"]);

	self.btnGetEquip10 = ngui.find_button(self.ui,"btn_2");
	self.btnGetEquip10:set_on_click(self.bindfunc["on_equip_10"]);
	self.labGetEquip10Num = ngui.find_label(self.ui,"sp_bk2/lab");
	--self.labGetEquip10Text = ngui.find_label(self.nodeEquipBtn10,"lab[55]");

	self.btnGetEquip1 = ngui.find_button(self.ui,"btn_1");
	self.btnGetEquip1:set_on_click(self.bindfunc["on_equip_1"]);
	self.labGetEquip1Num = ngui.find_label(self.ui,"sp_bk1/lab");
	self.labGetEquip1Text = ngui.find_label(self.ui,"sp_black/lab");
	self.nodeEquipCost = ngui.find_sprite(self.ui,"sp_bk1/sp");
	self.labEquipCost = ngui.find_label(self.ui,"sp_bk1/lab1");
	self.labEquipCnt = ngui.find_label(self.ui,"left_content/txt");

	self:UpdateUi();
end

function EggEquipUi:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return;
	end
	self:UpdateTime();

	local level = g_dataCenter.player:GetLevel();
	local vip = g_dataCenter.player:GetVipData();
	local dis = 1;
	if vip then
		if vip.niudan_dis then
			dis = vip.niudan_dis;
		end
	end
	self.labGetEquip10Num:set_text("x"..ConfigManager.Get(EConfigIndex.t_niudan_cost,2).ten_cost*dis);
	self.labEquipCost:set_text("x"..ConfigManager.Get(EConfigIndex.t_niudan_cost,2).once_cost*dis)

	--local max = ConfigManager.Get(EConfigIndex.t_discrete,83000040).data or 1;
	--local cur = PropsEnum.GetValue(IdConfig.EquipDebris) or 0;
	--self.lab_soul_equip:set_text(tostring(cur));
	local equipCnt = g_dataCenter.egg:surplusMustGetEquipCnt();
	if equipCnt == 10 then
		self.labEquipCnt:set_text("本次必得紫色装备");
	else
		self.labEquipCnt:set_text(equipCnt.."次后必得紫色装备");
	end
	-- local pro = cur/max;
	-- self.proEquip:set_value(pro);
end

function EggEquipUi:UpdateTime()
	if not self.ui then return end
	if self.freeEquipTimes <= 0 then
		local str = "[ff0000]"..self:_GetTime(self.equipCD).."[-]后免费抽取";
		self.labGetEquip1Text:set_active(true);
		self.labGetEquip1Text:set_text(str);
		self.labGetEquip1Num:set_active(false);
		self.nodeEquipCost:set_active(true);
        self.labEquipCost:set_active(true);
	else
		self.labGetEquip1Text:set_active(false);
		self.labGetEquip1Num:set_active(true);
		self.nodeEquipCost:set_active(false);
        self.labEquipCost:set_active(false);
	end
end

function EggEquipUi:on_equip_1()
	msg_activity.cg_niudan_use(ENUM.NiuDanType.Equip,false);
end

function EggEquipUi:on_equip_10()
	msg_activity.cg_niudan_use(ENUM.NiuDanType.Equip,true);
end

function EggEquipUi:on_exchange_equip()
	--uiManager:PushUi(EUI.EggEquipExchangeUI);
	-- HintUI.SetAndShow(0,"兑换商店暂未开放");
	-- self.begin_egg_type = 1;
end

function EggEquipUi:on_equip_time()
	self.equipCD = self.equipCD - 1;
	if self.equipCD <= 0 then
		timer.stop(self.equipTimeId);	
		self.equipTimeId = nil;
	end
	self:UpdateTime();
end

function EggEquipUi:on_back()
	uiManager:PopUi();
end

function EggEquipUi:gc_equip_info(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
	self.equipCD = CDLeftTime;
	self.freeEquipTimes = byfreeTime;
	if byfreeTime <= 0 then
		if self.equipTimeId then
			timer.stop(self.equipTimeId);	
		end
		self.equipTimeId = timer.create(self.bindfunc["on_equip_time"],1000,-1);
	end
	self:UpdateTime();
end

function EggEquipUi:gc_use(result, egg_type, bTen, vecReward,vecItem)
	if tonumber(egg_type) == ENUM.NiuDanType.Equip then
		-- 装备
		if bTen then
			--CommonAward.Start(vecReward,1,10,true);
			EggEquipGetTen.Start({vecReward = vecReward})
			EggEquipGetTen.SetCallback(self.on_equip_10, self, self.UpdateUi, self)
		else
			EggEquipGetOne.Start({vecReward = vecReward})
			EggEquipGetOne.SetCallback(self.on_equip_1, self, self.UpdateUi, self)
			--CommonAward.Start(vecReward,1,0,true);
		end
		--CommonAward.SetDeployCallback(EggEquipUi.Deploy, self, {type=egg_type,bTen=bTen,});
	end
	-- self:UpdateUi();
    -- app.log(table.tostring({result,type,bTen, vecReward}))
end

function EggEquipUi:on_rule(t)
	UiRuleDes.Start(t.float_value);
end

function EggEquipUi:Deploy(param)
	if param.bTen then
		EggEquipUi:on_equip_10();
	else
		EggEquipUi:on_equip_1();
	end
end

function EggEquipUi:_GetTime(sec)
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(sec);
	local str;
	if tonumber(day) ~= 0 then
		str = string.format("%d天 %02d:%02d:%02d",tonumber(day),tonumber(hour),tonumber(min),tonumber(sec));
		-- str = day.."澶?"..hour..":"..min..":"..sec;
	else
		str = string.format("%02d:%02d:%02d",tonumber(hour),tonumber(min),tonumber(sec));
		-- str = hour..":"..min..":"..sec;
	end
	return str;
end


function EggEquipUi:DestroyUi()
	UiBaseClass.DestroyUi(self);
    -- self.begin_egg_type = 0;
    self.btnGetEquip1 = nil;
    if self.equipTimeId then
    	timer.stop(self.equipTimeId );
    	self.equipTimeId = nil;
    end
end

function EggEquipUi:Restart(data)
	if UiBaseClass.Restart(self, data) then
    	msg_activity.cg_niudan_request_equip_info();
	end
end

function EggEquipUi:Show()
	UiBaseClass.Show(self);
	self:UpdateUi();
end


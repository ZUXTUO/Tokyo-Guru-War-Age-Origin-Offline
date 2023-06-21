EggHeroUi = Class("EggHeroUi", UiBaseClass);

local uiText = 
{
    [1] = '成功购买%d次，赠送以上道具',
    [2] = '此角色已经拥有,自动转化为%s*%d,可用于升星和潜能强化。',
}

function EggHeroUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/egg/ui_2601_egg.assetbundle";
    self.EEggHeroSubUi =
    {
        [ENUM.NiuDanType.Gold] = EUI.EggHeroSubUiGold,
        [ENUM.NiuDanType.Hero] = EUI.EggHeroSubUiCrystal,
        [ENUM.NiuDanType.Vip] = EUI.EggHeroSubUiVip,
    }
    UiBaseClass.Init(self, data);
end

function EggHeroUi:InitData(data)
    self.heroGoldTimeId = nil;
    self.heroCrystalTimeId = nil;
    self.vipGroup = g_dataCenter.egg:GetHunxiaGroupId();
    self.hasVipActive = false;
    self.vipCD = 0;
    self.cont = {};
    UiBaseClass.InitData(self, data);
end

function EggHeroUi:Restart(data)
    self.contState = 
    {
        [ENUM.NiuDanType.Gold] = false,
        [ENUM.NiuDanType.Hero] = false,
        [ENUM.NiuDanType.Vip] = false,
    };
    self.heroGoldCD = (g_dataCenter.egg.heroCdTimeGold or 0) - system.time();
    self.freeGoldTimes = g_dataCenter.egg.freeHeroTimesGold or 0;
    self.heroCrystalCD = (g_dataCenter.egg.heroCdTime or 0) - system.time();
    self.freeCrystalTimes = g_dataCenter.egg.freeHeroTimes or 0;
    self.todayDiscountTimes = g_dataCenter.egg.heroTodayDiscountTimes or 0;
    if not UiBaseClass.Restart(self, data) then
        return;
    end
    -- msg_activity.cg_niudan_request_role_info();
end

function EggHeroUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
    self.bindfunc["gc_hero_info_gold"] = Utility.bind_callback(self,EggHeroUi.gc_hero_info_gold);
    self.bindfunc["gc_hero_info_crystal"] = Utility.bind_callback(self,EggHeroUi.gc_hero_info_crystal);
    self.bindfunc["on_hero_time_gold"] = Utility.bind_callback(self, self.on_hero_time_gold);
    self.bindfunc["on_hero_time_crystal"] = Utility.bind_callback(self, self.on_hero_time_crystal);
    self.bindfunc["on_hero_time_vip"] = Utility.bind_callback(self, self.on_hero_time_vip);
    self.bindfunc["on_change_tog"] = Utility.bind_callback(self, self.on_change_tog);
    self.bindfunc["on_buy_1"] = Utility.bind_callback(self, self.on_buy_1);
    self.bindfunc["on_buy_10"] = Utility.bind_callback(self, self.on_buy_10);
    self.bindfunc["gc_use"] = Utility.bind_callback(self,self.gc_use);
    self.bindfunc["on_open_tujian"] = Utility.bind_callback(self,self.on_open_tujian);
end

function EggHeroUi:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
    PublicFunc.msg_regist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
    PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
end

function EggHeroUi:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_sync_gold_niudan_role_info,self.bindfunc['gc_hero_info_gold']);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_sync_role_info,self.bindfunc['gc_hero_info_crystal']);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_use']);
end

function EggHeroUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("EggHeroUi");

    self:UpdateUi();
end

function EggHeroUi:InitGoldItem(obj,index)
    if self.cont[index] then
        return;
    end
    local cont = {};
    self.cont[index] = cont;
    --------------------------
    cont.obj1 = obj:get_child_by_name("cont1");
    cont.labCost = ngui.find_label(obj,"cont1/sp_di/content1/lab");
    cont.labTime = ngui.find_label(obj,"cont1/sp_di/content2/sp_clock/lab");
    cont.objTime = obj:get_child_by_name("cont1/sp_di/content2/sp_clock");
    cont.labTimes = ngui.find_label(obj,"cont1/sp_di/content2/lab_time");
    cont.objTimeRoot = obj:get_child_by_name("cont1/sp_di/content2");
    cont.btn = ngui.find_button(obj,"cont1/btn_empty");
    cont.btn:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btn:set_event_value("",ENUM.NiuDanType.Gold);
    cont.fx1 = obj:get_child_by_name("cont1/fx_zhaomu_biankuang");
    cont.fx1:set_active(false);
    -------------------
    cont.obj2 = obj:get_child_by_name("cont2");
    cont.btnBack = ngui.find_button(obj,"cont2/btn_back");
    cont.btnBack:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btnBack:set_event_value("",ENUM.NiuDanType.Gold);
    cont.btnBuy1 = ngui.find_button(obj,"cont2/btn1");
    cont.btnBuy1:set_on_click(self.bindfunc["on_buy_1"]);
    cont.btnBuy1:set_event_value("",ENUM.NiuDanType.Gold);
    cont.btnBuy10 = ngui.find_button(obj,"cont2/btn10");
    cont.btnBuy10:set_on_click(self.bindfunc["on_buy_10"]);
    cont.btnBuy10:set_event_value("",ENUM.NiuDanType.Gold);
    cont.labCost10 = ngui.find_label(obj,"cont2/content_di2/lab");
    cont.labCost1 = ngui.find_label(obj,"cont2/content_di/lab");
    cont.labFreeTime = ngui.find_label(obj,"cont2/sp1/txt");
    cont.labDes = ngui.find_label(obj,"cont2/lab_describe");
    cont.fx2 = obj:get_child_by_name("cont2/fx_zhaomu_biankuang");
    cont.fx2:set_active(false);

    cont.btnTujian = ngui.find_button(obj,"cont2/btn_tujian_di")
    -- cont.btnTujian:set_active(false)
    cont.btnTujian:set_on_click(self.bindfunc["on_open_tujian"]);
    cont.btnTujian:set_event_value("", ENUM.NiuDanType.Gold);
    -----------
    -- cont.fx = obj:get_child_by_name("fx_zhaomu_biankuang");

    self:AdjustBorderFxScale(cont.obj1);
    self:AdjustBorderFxScale(cont.obj2);
end

function EggHeroUi:InitCrystalItem(obj,index)
    if self.cont[index] then
        return;
    end
    local cont = {};
    self.cont[index] = cont;
    --------------------------
    cont.obj1 = obj:get_child_by_name("cont1");
    cont.labCost = ngui.find_label(obj,"cont1/sp_di/content1/lab");
    cont.labTime = ngui.find_label(obj,"cont1/sp_di/content2/sp_clock/lab");
    cont.objTime = obj:get_child_by_name("cont1/sp_di/content2/sp_clock");
    cont.labTimes = ngui.find_label(obj,"cont1/sp_di/content2/lab_time");
    cont.objTimeRoot = obj:get_child_by_name("cont1/sp_di/content2");
    cont.btn = ngui.find_button(obj,"cont1/btn_empty");
    cont.btn:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btn:set_event_value("",ENUM.NiuDanType.Hero);
    cont.fx1 = obj:get_child_by_name("cont1/fx_zhaomu_biankuang");
    cont.fx1:set_active(false);
    cont.spQuan1 = ngui.find_sprite(obj,"cont1/sp_di/content1/sp");
    cont.spDiscount1 = ngui.find_sprite(obj,"cont1/sp_discount");
    cont.labDiscount1 = ngui.find_label(obj,"cont1/sp_discount/txt_discount");
    cont.spZhekou1 = ngui.find_sprite(obj,"cont1/content1/sp_line");
    cont.spZhekou1:set_active(false);
    cont.labZheKou1 = ngui.find_label(obj,"cont1/content1/sp_line/lab");
    -------------------
    cont.obj2 = obj:get_child_by_name("cont2");
    cont.btnBack = ngui.find_button(obj,"cont2/btn_back");
    cont.btnBack:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btnBack:set_event_value("",ENUM.NiuDanType.Hero);
    cont.btnBuy1 = ngui.find_button(obj,"cont2/btn1");
    cont.btnBuy1:set_on_click(self.bindfunc["on_buy_1"]);
    cont.btnBuy1:set_event_value("",ENUM.NiuDanType.Hero);
    cont.btnBuy10 = ngui.find_button(obj,"cont2/btn10");
    cont.btnBuy10:set_on_click(self.bindfunc["on_buy_10"]);
    cont.btnBuy10:set_event_value("",ENUM.NiuDanType.Hero);
    cont.labCost10 = ngui.find_label(obj,"cont2/content_di2/lab");
    cont.labCost1 = ngui.find_label(obj,"cont2/content_di/lab");
    cont.labFreeTime = ngui.find_label(obj,"cont2/sp1/txt");
    cont.labDes = ngui.find_label(obj,"cont2/lab_describe");
    cont.labTips10 = ngui.find_label(obj,"cont2/sp2/txt");
    cont.spQuan2 = ngui.find_sprite(obj,"cont2/content_di/sp");
    cont.spQuan3 = ngui.find_sprite(obj,"cont2/content_di2/sp");
    cont.fx2 = obj:get_child_by_name("cont2/fx_zhaomu_biankuang");
    cont.fx2:set_active(false);
    cont.spZhekou2 = ngui.find_sprite(obj,"cont2/content_di/sp_line");
    cont.spZhekou2:set_active(false);
    cont.labZheKou2 = ngui.find_label(obj,"cont2/content_di/sp_line/lab");
    cont.spDiscount2 = ngui.find_sprite(obj,"cont2/sp_discount");
    cont.labDiscount2 = ngui.find_label(obj,"cont2/sp_discount/txt_discount");

    cont.btnTujian = ngui.find_button(obj,"cont2/btn_tujian_di")
    -- cont.btnTujian:set_active(false)
    cont.btnTujian:set_on_click(self.bindfunc["on_open_tujian"]);
    cont.btnTujian:set_event_value("", ENUM.NiuDanType.Hero);

    self:AdjustBorderFxScale(cont.obj1);
    self:AdjustBorderFxScale(cont.obj2);
end

function EggHeroUi:InitVipItem(obj,index)
    if self.cont[index] then
        return;
    end
    local cont = {};
    self.cont[index] = cont;
    --------------------------
    cont.obj1 = obj:get_child_by_name("cont1");
    cont.labCost = ngui.find_label(obj,"cont1/sp_di/content1/lab");
    cont.labTime = ngui.find_label(obj,"cont1/sp_di/content2/sp_clock/lab");
    cont.objTime = obj:get_child_by_name("cont1/sp_di/content2/sp_clock");
    cont.labTimes = ngui.find_label(obj,"cont1/sp_di/content2/lab_time");
    cont.labTimes:set_text("");
    cont.objTimeRoot = obj:get_child_by_name("cont1/sp_di/content2");
    cont.btn = ngui.find_button(obj,"cont1/btn_empty");
    cont.btn:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btn:set_event_value("",ENUM.NiuDanType.Vip);
    cont.fx1 = obj:get_child_by_name("cont1/fx_zhaomu_biankuang");
    cont.fx1:set_active(false);
    -------------------
    cont.obj2 = obj:get_child_by_name("cont2");
    cont.btnBack = ngui.find_button(obj,"cont2/btn_back");
    cont.btnBack:set_on_click(self.bindfunc["on_change_tog"]);
    cont.btnBack:set_event_value("",ENUM.NiuDanType.Vip);
    cont.btnBuy1 = ngui.find_button(obj,"cont2/btn1");
    cont.btnBuy1:set_on_click(self.bindfunc["on_buy_1"]);
    cont.btnBuy1:set_event_value("",ENUM.NiuDanType.Vip);
    cont.btnBuy10 = ngui.find_button(obj,"cont2/btn10");
    cont.btnBuy10:set_on_click(self.bindfunc["on_buy_10"]);
    cont.btnBuy10:set_event_value("",ENUM.NiuDanType.Vip);
    cont.labCost10 = ngui.find_label(obj,"cont2/content_di2/lab");
    cont.labCost1 = ngui.find_label(obj,"cont2/content_di/lab");
    cont.labFreeTime = ngui.find_label(obj,"cont2/sp1/txt");
    cont.fx2 = obj:get_child_by_name("cont2/fx_zhaomu_biankuang");
    cont.fx2:set_active(false);
    
    cont.btnTujian = ngui.find_button(obj,"cont2/btn_tujian_di")
    -- cont.btnTujian:set_active(false)
    cont.btnTujian:set_on_click(self.bindfunc["on_open_tujian"]);
    cont.btnTujian:set_event_value("", ENUM.NiuDanType.Vip);

    self:AdjustBorderFxScale(cont.obj1);
    self:AdjustBorderFxScale(cont.obj2);
end

-- 调整特效缩放比适应不同设备分辨率
function EggHeroUi:AdjustBorderFxScale(uiCont)
    local obj = uiCont:get_child_by_name("fx_zhaomu_biankuang/fx_zhaomu_biankuang");
    PublicFunc.SetScaleByScreenRate(obj);
end

function EggHeroUi:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    self:CheckVipActivity();

    if self.hasVipActive then
        local cont1 = self.ui:get_child_by_name("animation/grid");
        cont1:set_active(true);
        local cont2 = self.ui:get_child_by_name("animation/cont");
        cont2:set_active(false);
        local obj = cont1:get_child_by_name("left_di");
        self:InitGoldItem(obj,1);
        local obj = cont1:get_child_by_name("centre_di");
        self:InitCrystalItem(obj,2);
        local obj = cont1:get_child_by_name("right_di");
        self:InitVipItem(obj,3);
    else
        local cont1 = self.ui:get_child_by_name("animation/grid");
        cont1:set_active(false);
        local cont2 = self.ui:get_child_by_name("animation/cont");
        cont2:set_active(true);
        local obj = cont2:get_child_by_name("left_di");
        self:InitGoldItem(obj,1);
        local obj = cont2:get_child_by_name("centre_di");
        self:InitCrystalItem(obj,2);
    end
    self:StopGoldTimer();
    if self.heroGoldCD > 0 then
        self.heroGoldTimeId = timer.create(self.bindfunc["on_hero_time_gold"],1000,-1);
    end
    self:StopCrystalTimer();
    if self.heroCrystalCD > 0 then
        self.heroCrystalTimeId = timer.create(self.bindfunc["on_hero_time_crystal"],1000,-1);
    end
    
    if self.hasVipActive then
        self:UpdateGoldItem(1);
        self:UpdateGoldItemByTime(1);
        self:UpdateCrystalItem(2);
        self:UpdateCrystalItemByTime(2);
        self:UpdateVipItem(3);
        self:UpdateVipItemByTime(3);
    else
        self:UpdateGoldItem(1);
        self:UpdateGoldItemByTime(1);
        self:UpdateCrystalItem(2);
        self:UpdateCrystalItemByTime(2);
    end
end

function EggHeroUi:UpdateCont()
    if self.EggType == ENUM.NiuDanType.Gold then
        self:UpdateGoldItem(1);
        self:UpdateGoldItemByTime(1);
    elseif self.EggType == ENUM.NiuDanType.Hero then
        self:UpdateCrystalItem(2);
        self:UpdateCrystalItemByTime(2);
    elseif self.EggType == ENUM.NiuDanType.Vip then
        self:UpdateVipItem(3);
        self:UpdateVipItemByTime(3);
    end
end

function EggHeroUi:CheckVipActivity()
    if self.vipGroup then
        local activeid = ENUM.Activity.activityType_niudan_hunxia;
        local activityCfg = g_dataCenter.activityReward:GetActivityTimeForActivityID(activeid);
        if activityCfg then
            if self.vipGroup == 0 then
                self.vipGroup = activityCfg.extra_num;
            end
            self.vipCD = activityCfg.e_time-system.time();
            local cfg = ConfigManager.Get(EConfigIndex.t_hunxia_other_drop,self.vipGroup);
            if cfg and cfg.vip_level and cfg.vip_level <= g_dataCenter.player:GetVip() then
                self.hasVipActive = g_dataCenter.activityReward:GetActivityIsOpenByActivityid(activeid);
                self:StopVipTimer();
                if self.vipCD > 0 then
                    self.heroVipTimeId = timer.create(self.bindfunc["on_hero_time_vip"],1000,-1);
                end
            end
        end
    end
end

function EggHeroUi:UpdateGoldItem(index, fx)
    if not self.ui then return end;
    local cont = self.cont[index];
    local cost10 = EggHeroUi.GetCost(ENUM.NiuDanType.Gold, false)
    cont.labCost10:set_text(tostring(cost10));
    cont.obj1:set_active(not self.contState[ENUM.NiuDanType.Gold]);
    cont.obj2:set_active(self.contState[ENUM.NiuDanType.Gold]);
    local heroOnceRestCntGold = g_dataCenter.egg:surplusMustGetHeroCntGold();
    if heroOnceRestCntGold == 10 then
        cont.labDes:set_text("[FC68E3FF]本次[-][00C0FFFF]必得角色碎片[-]");
    else
        cont.labDes:set_text("[FC68E3FF]"..heroOnceRestCntGold.."次[-][00C0FFFF]后必得角色碎片[-]");
    end
    if not fx then return end
    cont.fx1:set_active(not self.contState[ENUM.NiuDanType.Gold]);
    cont.fx2:set_active(self.contState[ENUM.NiuDanType.Gold]);
end
function EggHeroUi:UpdateGoldItemByTime(index)
    if not self.ui then return end;
    local cont = self.cont[index];
    local cost1 = EggHeroUi.GetCost(ENUM.NiuDanType.Gold, true);
    if self.heroGoldCD > 0 then
        local cdTime = PublicFunc.FormatLeftSecondsEx(self.heroGoldCD,true);
        cont.labTime:set_text(cdTime);
        cont.labFreeTime:set_text(cdTime.."后免费抽取");
        cont.labTimes:set_text("");
        cont.objTime:set_active(true);
        cont.labCost:set_text(tostring(cost1));
        cont.labCost1:set_text(tostring(cost1))
        cont.objTimeRoot:set_active(true);
    elseif self.freeGoldTimes > 0 then
        local maxTimes = ConfigManager.Get(EConfigIndex.t_discrete, 83000070).data;
        local curTimes = self.freeGoldTimes;
        cont.objTime:set_active(false);
        cont.labTimes:set_text("免费次数"..curTimes.."/"..maxTimes);
        cont.labTime:set_text("");
        cont.labFreeTime:set_text("[00C0FFFF]免费次数:[-][5AFF00FF]"..curTimes.."/"..maxTimes.."[-]")
        cont.labCost:set_text("免费");
        cont.labCost1:set_text("免费")
        cont.objTimeRoot:set_active(true);
    else
        cont.objTime:set_active(false);
        cont.labTimes:set_text("");
        cont.labFreeTime:set_text("");
        cont.labCost:set_text(tostring(cost1));
        cont.labCost1:set_text(tostring(cost1))
        cont.objTimeRoot:set_active(false);
    end
end

function EggHeroUi:UpdateCrystalItem(index, fx)
    if not self.ui then return end;
    local cont = self.cont[index];
    local num = g_dataCenter.package:GetCountByNumber(IdConfig.EggHeroCrystal);
    local cost10 = EggHeroUi.GetCost(ENUM.NiuDanType.Hero, false)
    if num >= 10 then
        cont.spQuan3:set_sprite_name("yingxiongchoujiangquan");
        cont.labCost10:set_text(tostring(num).."/10");
    else
        cont.spQuan3:set_sprite_name("hongzuanshi1");
        cont.labCost10:set_text(tostring(cost10));
    end
    cont.obj1:set_active(not self.contState[ENUM.NiuDanType.Hero]);
    cont.obj2:set_active(self.contState[ENUM.NiuDanType.Hero]);
    local heroOnceRestCnt = g_dataCenter.egg:surplusMustGetHeroCnt();
    if heroOnceRestCnt == 10 then
        cont.labDes:set_text("[FC68E3FF]本次[-][00C0FFFF]必得角色[-]");
    else
        cont.labDes:set_text("[FC68E3FF]"..heroOnceRestCnt.."次[-][00C0FFFF]后必得角色[-]");
    end
    local useHeroTenCnt = g_dataCenter.egg:GetUseHeroTenCnt();
    if useHeroTenCnt == 0 then
        cont.labTips10:set_text("必得[-][FC68E3FF]3星[-][00C0FFFF]及以上角色[-]");
    else
        cont.labTips10:set_text("[FC68E3FF]10次[-][00C0FFFF]必得角色[-]");
    end

    if not fx then return end;
    cont.fx1:set_active(not self.contState[ENUM.NiuDanType.Hero]);
    cont.fx2:set_active(self.contState[ENUM.NiuDanType.Hero]);
end
function EggHeroUi:UpdateCrystalItemByTime(index)
    if not self.ui then return end;
    local cont = self.cont[index];
    local cost1 = EggHeroUi.GetCost(ENUM.NiuDanType.Hero, true);

    local num = g_dataCenter.package:GetCountByNumber(IdConfig.EggHeroCrystal);
    if self.heroCrystalCD > 0 then
        local cdTime = PublicFunc.FormatLeftSecondsEx(self.heroCrystalCD,true);
        cont.labTime:set_text(cdTime);
        cont.labFreeTime:set_text(cdTime.."后免费抽取");
        cont.labTimes:set_text("");
        cont.objTime:set_active(true);
        if num > 0 then
            cont.spQuan1:set_sprite_name("yingxiongchoujiangquan");
            cont.spQuan2:set_sprite_name("yingxiongchoujiangquan");
            cont.labCost:set_text(tostring(num).."/1");
            cont.labCost1:set_text(tostring(num).."/1")
            cont.spZhekou1:set_active(false);
            cont.spZhekou2:set_active(false);
            cont.spDiscount1:set_active(false);
            cont.spDiscount2:set_active(false);
        else
            cont.spQuan1:set_sprite_name("hongzuanshi1");
            cont.spQuan2:set_sprite_name("hongzuanshi1");
            cont.labCost:set_text(tostring(cost1));
            cont.labCost1:set_text(tostring(cost1))
            local activeid = ENUM.Activity.activityType_niudan_discount;
            local is_activity, discountNum, limitTimes = g_dataCenter.activityReward:GetBoxDiscount(activeid);
            if is_activity and limitTimes > self.todayDiscountTimes then
                cont.spZhekou2:set_active(true);
                cont.labZheKou2:set_text(tostring(math.ceil(cost1*discountNum/100)));
                cont.spZhekou1:set_active(true);
                cont.labZheKou1:set_text(tostring(math.ceil(cost1*discountNum/100)));
                cont.spDiscount1:set_active(true);
                cont.labDiscount1:set_text(tostring(discountNum/10).."折");
                cont.spDiscount2:set_active(true);
                cont.labDiscount2:set_text(tostring(discountNum/10).."折");
            else
                cont.spZhekou1:set_active(false);
                cont.spZhekou2:set_active(false);
                cont.spDiscount1:set_active(false);
                cont.spDiscount2:set_active(false);
            end
        end
        cont.objTimeRoot:set_active(true);
    elseif self.freeCrystalTimes > 0 then
        local curTimes = self.freeCrystalTimes;
        cont.labTimes:set_text("免费次数"..curTimes.."次");
        cont.objTime:set_active(false);
        cont.labTime:set_text("");
        cont.labFreeTime:set_text("[00C0FFFF]免费次数:[-][5AFF00FF]"..curTimes.."次")
        cont.labCost:set_text("免费");
        cont.labCost1:set_text("免费")
        cont.objTimeRoot:set_active(true);
        cont.spZhekou1:set_active(false);
        cont.spZhekou2:set_active(false);
        cont.spDiscount1:set_active(false);
        cont.spDiscount2:set_active(false);
    else
        cont.objTime:set_active(false);
        cont.labTimes:set_text("");
        cont.labFreeTime:set_text("");
        if num > 0 then
            cont.spQuan1:set_sprite_name("yingxiongchoujiangquan");
            cont.spQuan2:set_sprite_name("yingxiongchoujiangquan");
            cont.labCost:set_text(tostring(num).."/1");
            cont.labCost1:set_text(tostring(num).."/1")
        else
            cont.spQuan1:set_sprite_name("hongzuanshi1");
            cont.spQuan2:set_sprite_name("hongzuanshi1");
            cont.labCost:set_text(tostring(cost1));
            cont.labCost1:set_text(tostring(cost1))
        end
        cont.objTimeRoot:set_active(false);
        cont.spZhekou1:set_active(false);
        cont.spZhekou2:set_active(false);
        cont.spDiscount1:set_active(false);
        cont.spDiscount2:set_active(false);
    end
end

function EggHeroUi:UpdateVipItem(index, fx)
    if not self.ui then return end;
    local cont = self.cont[index];
    local cost10 = EggHeroUi.GetCost(ENUM.NiuDanType.Vip, false)
    cont.labCost10:set_text(tostring(cost10));
    cont.obj1:set_active(not self.contState[ENUM.NiuDanType.Vip]);
    cont.obj2:set_active(self.contState[ENUM.NiuDanType.Vip]);
    if not fx then return end;
    cont.fx1:set_active(not self.contState[ENUM.NiuDanType.Vip]);
    cont.fx2:set_active(self.contState[ENUM.NiuDanType.Vip]);
end
function EggHeroUi:UpdateVipItemByTime(index)
    if not self.ui then return end;
    local cont = self.cont[index];
    local cost1 = EggHeroUi.GetCost(ENUM.NiuDanType.Vip, true);
    if self.vipCD > 0 then
        cont.labTime:set_text(PublicFunc.FormatLeftSecondsEx(self.vipCD,true));
        cont.labCost:set_text(tostring(cost1));
        cont.labCost1:set_text(tostring(cost1))
        cont.objTimeRoot:set_active(true);
    -- elseif self.freeVipTimes > 0 then
    --     local curTimes = self.freeVipTimes;
    --     cont.labTime:set_text("免费次数"..curTimes.."次");
    --     cont.labCost:set_text("免费");
    --     cont.labCost1:set_text("免费")
    --     cont.objTimeRoot:set_active(true);
    else
        cont.labTime:set_text("");
        cont.labCost:set_text(tostring(cost1));
        cont.labCost1:set_text(tostring(cost1))
        cont.objTimeRoot:set_active(false);
    end
end

function EggHeroUi:DestroyUi()
    self.isGuide = nil
    if self.bkui then
        self.bkui:set_active(false);
        self.bkui = nil;
    end
    UiBaseClass.DestroyUi(self);
    self:StopGoldTimer();
    self:StopCrystalTimer();
    self:StopVipTimer();
    self.cont = {};
end

function EggHeroUi:Hide()
    UiBaseClass.Hide(self);
    for k,v in pairs(self.cont) do
        v.fx1:set_active(false);
        v.fx2:set_active(false);
    end
end

function EggHeroUi.GetCost(type, isOne)
    local vipLevel = g_dataCenter.player:GetVip();
    
    local vip = g_dataCenter.player:GetVipData();
    local dis = 1;
    if vip then
        if vip.niudan_dis then
            dis = vip.niudan_dis;
        end
    end

    local config = ConfigManager.Get(EConfigIndex.t_niudan_cost, type);
    local colnumName
    if isOne then
        colnumName = "once_cost"
    else
        colnumName = "ten_cost"
    end

    return config[colnumName] * dis
end

function EggHeroUi:StopGoldTimer()
    if self.heroGoldTimeId then
        timer.stop(self.heroGoldTimeId );
        self.heroGoldTimeId = nil;
    end
end

function EggHeroUi:StopCrystalTimer()
    if self.heroCrystalTimeId then
        timer.stop(self.heroCrystalTimeId );
        self.heroCrystalTimeId = nil;
    end
end

function EggHeroUi:StopVipTimer()
    if self.heroVipTimeId then
        timer.stop(self.heroVipTimeId );
        self.heroVipTimeId = nil;
    end
end

function EggHeroUi:on_hero_time_gold()
    self.heroGoldCD = math.max(0, self.heroGoldCD - 1);
    if self.heroGoldCD <= 0 then
        self:StopGoldTimer();
    end
    self:UpdateGoldItemByTime(1);
end

function EggHeroUi:on_hero_time_crystal()
    self.heroCrystalCD = math.max(0, self.heroCrystalCD - 1);
    if self.heroCrystalCD <= 0 then
        self:StopCrystalTimer();
    end
    self:UpdateCrystalItemByTime(2);
end

function EggHeroUi:on_hero_time_vip()
    self.vipCD = math.max(0, self.vipCD - 1);
    if self.vipCD <= 0 then
        self:StopVipTimer();
    end
    self:UpdateVipItemByTime(3);
end

function EggHeroUi:on_open_tujian(t)
    uiManager:PushUi(EUI.EggAwardShowUI, t.float_value);
end

function EggHeroUi:on_click(t)
    uiManager:PushUi(self.EEggHeroSubUi[t.float_value]);
end

function EggHeroUi:on_change_tog(t)
    local togType = t.float_value;
    self.contState[togType] = not self.contState[togType];
    if togType == ENUM.NiuDanType.Gold then
        self:UpdateGoldItem(1, true);
    elseif togType == ENUM.NiuDanType.Hero then
        self:UpdateCrystalItem(2, true);
    elseif togType == ENUM.NiuDanType.Vip then
        self:UpdateVipItem(3, true);
    end
end

function EggHeroUi:on_buy_1(t)
    app.log("开始抽卡");
    local buyType;
    if t then
        buyType = t.float_value;
    else
        buyType = self.EggType;
    end
    --if g_dataCenter.egg.useOnceHeroTimes == 0 and GuideManager.IsGuideRuning() then
        self.isGuide = true
        --local heroCid = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_guide_first_egg_hero_id).data -- 第一个英雄

        local heroCid = 30005000;
        if g_dataCenter.egg.useOnceHeroTimes == 0 then
            app.log("第一次抽卡，释放假扭蛋");
            g_dataCenter.egg.useOnceHeroTimes = 1;
            heroCid = 30005000;
        else
            local num = math.random(1,46);
            if num == 1 then
                heroCid = 30001000;
            elseif num == 2 then
                heroCid = 30002000;
            elseif num == 3 then
                heroCid = 30003000;
            elseif num == 4 then
                heroCid = 30004000;
            elseif num == 5 then
                heroCid = 30005000;
            elseif num == 6 then
                heroCid = 30006000;
            elseif num == 7 then
                heroCid = 30007000;
            elseif num == 8 then
                heroCid = 30008000;
            elseif num == 9 then
                heroCid = 30009000;
            elseif num == 10 then
                heroCid = 30010000;
            elseif num == 11 then
                heroCid = 30011000;
            elseif num == 12 then
                heroCid = 30012000;
            elseif num == 13 then
                heroCid = 30013000;
            elseif num == 14 then
                heroCid = 30014000;
            elseif num == 15 then
                heroCid = 30015000;
            elseif num == 16 then
                heroCid = 30016000;
            elseif num == 17 then
                heroCid = 30017000;
            elseif num == 18 then
                heroCid = 30018000;
            elseif num == 19 then
                heroCid = 30019000;
            elseif num == 20 then
                heroCid = 30020000;
            elseif num == 21 then
                heroCid = 30021000;
            elseif num == 22 then
                heroCid = 30022000;
            elseif num == 23 then
                heroCid = 30023000;
            elseif num == 24 then
                heroCid = 30024000;
            elseif num == 25 then
                heroCid = 30025000;
            elseif num == 26 then
                heroCid = 30026000;
            elseif num == 27 then
                heroCid = 30027000;
            elseif num == 28 then
                heroCid = 30028000;
            elseif num == 29 then
                heroCid = 30029000;
            elseif num == 30 then
                heroCid = 30030000;
            elseif num == 31 then
                heroCid = 30040000;
            elseif num == 32 then
                heroCid = 30053000;
            elseif num == 33 then
                heroCid = 30054000;
            elseif num == 34 then
                heroCid = 30057000;
            elseif num == 35 then
                heroCid = 30058000;
            elseif num == 36 then
                heroCid = 30059000;
            elseif num == 37 then
                heroCid = 30060000;
            end
        end
                --heroCid = 30042000;
                --heroCid = 30043000;
                --heroCid = 30044000;
                --heroCid = 30045000;
                --heroCid = 30046000;
                --heroCid = 30047000;
                --heroCid = 30031000;
                --heroCid = 30032000;
                --heroCid = 30033000;
                --heroCid = 30037000;
                --heroCid = 30038000;
                --heroCid = 30049000;
                --heroCid = 30055000;
                --heroCid = 30051000;
                --heroCid = 30048000;
                --heroCid = 30050000;
                --heroCid = 30052000;
                --heroCid = 30036000;
                --heroCid = 30034000;
                --heroCid = 30056000;
                --heroCid = 30035000;
                --heroCid = 30041000;
                --heroCid = 30039000;

        EggHeroUi:GetAllHeroOnPackage();

        local hero = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero, heroCid)
        --if hero and LocalFile.GetHeroEggRecord(hero.index) == false then
            -- LocalFile.WriteHeroEggRecord(hero.index)
            NoticeManager.Notice(ENUM.NoticeType.NiuDanSuccess, 0, false)
            local rewardData = {{id=heroCid, dataid="", count=1}}
            self.vecReward = rewardData
            self.vecItem = rewardData
            self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 1)
            local ch = CardHuman:new({number = heroCid, level=1});
            self.EggType = ENUM.NiuDanType.Hero;
            EggGetHero.Start(ch, true, nil)
            EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)
            return
        --end
    --end

    self:BuyEgg(buyType, false);
end

function EggHeroUi:on_buy_10(t)
    --[[
    local buyType;
    if t then
        buyType = t.float_value;
    else
        buyType = self.EggType;
    end
    self:BuyEgg(buyType, true);
    --]]
    SystemHintUI.SetAndShow(ESystemHintUIType.two, "暂时还不能十连，先单抽吧",
        { str = "是", func = EggHeroUi.out_Log },{ str = "否", func = EggHeroUi.out_Log }
    );
end

function EggHeroUi:GetAllHeroOnPackage()
    local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All)
    for k,v in pairs(roleStatesList) do 
        g_dataCenter.package:AddCard(ENUM.EPackageType.Hero, v);
    end 
end

function EggHeroUi:out_Log()
    app.log("十连取消");
end

function EggHeroUi:BuyEgg(buyType, isTen)
    local costItemNum = EggHeroUi.GetCost(buyType, not isTen)
    if buyType == ENUM.NiuDanType.Hero and not isTen then
        local activeid = ENUM.Activity.activityType_niudan_discount;
        local is_activity, discountNum, limitTimes = g_dataCenter.activityReward:GetBoxDiscount(activeid);
        if is_activity and limitTimes > self.todayDiscountTimes then
            costItemNum = costItemNum * discountNum / 100;
            costItemNum = math.ceil(costItemNum);
        end
    end

    repeat
        if buyType == ENUM.NiuDanType.Gold then
            if self.heroGoldCD <= 0 and self.freeGoldTimes > 0 then
                break;
            end
            local curNum = g_dataCenter.player.gold;
            if curNum < costItemNum then
                FloatTip.Float("金币不足");
                return;
            end
            break;
        end
        local curNum = g_dataCenter.player.red_crystal;
        local freeNum = g_dataCenter.package:GetCountByNumber(IdConfig.EggHeroCrystal);
        if buyType == ENUM.NiuDanType.Hero then
            if isTen and freeNum >= 10 then
                break;
            end
            if not isTen then
                if freeNum > 0 then
                    break;
                end
                if self.freeCrystalTimes > 0 then
                    break;
                end
            end
        end
    
        if curNum < costItemNum then
            HintUI.SetAndShow(EHintUiType.two, "当前红钻不足，是否前往兑换?",
                    {str = "是", func = 
                        function ()
                            uiManager:PushUi(EUI.ExchangeRedCrystalUI,{needcast = costItemNum - curNum}); 
                        end},
                    {str = "否"}
                );
            return;
        end
    until true;
    msg_activity.cg_niudan_use(buyType,isTen);
end

function EggHeroUi:GetCostIdAndNum(type, times)
    local id = IdConfig.Gold
    local num = 0
    local own = nil
    if times == 1 then
        num = EggHeroUi.GetCost(type, true)
    else
        num = EggHeroUi.GetCost(type, false)
    end
    if type ==  ENUM.NiuDanType.Hero then
        local count = g_dataCenter.package:GetCountByNumber(IdConfig.EggHeroCrystal)
        if count >= times then
            id = IdConfig.EggHeroCrystal
            num = times
            own = count
        else
            id = IdConfig.RedCrystal
        end
    end
    return id, num, own
end

function EggHeroUi:gc_use(result, egg_type, bTen, vecReward, vecItem)
    self.EggType = egg_type
    if bTen then
        --把必出英雄随机到一个位置
        if egg_type ~= ENUM.NiuDanType.Vip then
            local randomPos = math.random(1, #vecReward)
            local first = vecReward[1]
            table.remove(vecReward, 1)
            table.insert(vecReward, randomPos, first)
            first = vecItem[1]
            table.remove(vecItem, 1)
            table.insert(vecItem, randomPos, first)
        end

        local costId, num, own = self:GetCostIdAndNum(egg_type, 10)
        if egg_type == ENUM.NiuDanType.Gold then
            local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 10)

            EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = num, costItemId = costId, costItemOwn = own, description = des})
            EggHeroGetTen.SetCallback(self.on_buy_10, self,self.UpdateCont,self);
        elseif egg_type == ENUM.NiuDanType.Hero then
            local des = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 10)

            EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = num, costItemId = costId, costItemOwn = own, description = des})
            EggHeroGetTen.SetCallback(self.on_buy_10, self,self.UpdateCont,self);
        elseif egg_type == ENUM.NiuDanType.Vip then
            EggHunXiaAwardUI.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, false), description = des});
            EggHunXiaAwardUI.SetCallback(self.on_buy_10, self,self.UpdateCont,self);
        end
    else
        if egg_type == ENUM.NiuDanType.Vip then
            EggHunXiaAwardUI.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = EggHeroUi.GetCost(self.EggType, true), description = des});
            EggHunXiaAwardUI.SetCallback(self.on_buy_1, self,self.UpdateCont,self);
            return;
        end
        if vecReward[1] then
            app.log("gc_niudan_use " .. table.tostring(vecReward[1]))
            self.showGetItemsDescription = nil
            if egg_type == ENUM.NiuDanType.Gold then
                self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_gold_niudan_fix_reward, 1)
            elseif egg_type == ENUM.NiuDanType.Hero then
                self.showGetItemsDescription = self:GetDesString(MsgEnum.ediscrete_id.eDiscreteID_crystal_niudan_fix_reward, 1)
            end
            self.vecReward = vecReward
            self.vecItem = vecItem
            if PropsEnum.IsRole(vecReward[1].id) then
                local ch = CardHuman:new({number = vecReward[1].id, level=1});
                local isNow = vecReward[1].id == vecItem[1].id
                local heroDes = nil
                if not isNow then
                    local itemConfig = ConfigManager.Get(EConfigIndex.t_item, vecItem[1].id)
                    local name = itemConfig.name
                    heroDes = string.format(uiText[2], tostring(name), vecItem[1].count)
                end
                EggGetHero.Start(ch, isNow, heroDes)
                EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)
            else
                self:ShowGetHeroEnd()
            end
        else
            app.log("奖励列表为空:"..table.tostring(vecReward));
            self:UpdateCont();
        end
    end
end

function EggHeroUi:ShowGetHeroEnd()
    if not self.EggType then return end

    local costId, costNum, own = self:GetCostIdAndNum(self.EggType, 1)
    
    -- 新手引导首次扭蛋不消耗次数，免费次数还在
    if self.isGuide then
        costNum = 0
        self.isGuide = nil
    end

    if self.EggType == ENUM.NiuDanType.Hero then
        local activeid = ENUM.Activity.activityType_niudan_discount;
        local is_activity, discountNum, limitTimes = g_dataCenter.activityReward:GetBoxDiscount(activeid);
        if is_activity and limitTimes > self.todayDiscountTimes then
            costNum = costNum * discountNum / 100;
            costNum = math.ceil(costNum);
        end
    end

    EggHeroGetOne.Start({vecReward = self.vecReward, vecItem = self.vecItem, description = self.showGetItemsDescription
        ,costItemId = costId, costItemNum = costNum,  costItemOwn = own
        });
    EggHeroGetOne.SetCallback(self.on_buy_1, self,self.UpdateCont,self);

    self.vecReward = nil
    self.vecItem = nil
    self.showGetItemsDescription = nil
end

function EggHeroUi:GetDesString(discreteid, factor)
    -- local des = nil
    -- local expItemData = ConfigManager.Get(EConfigIndex.t_discrete,discreteid).data[1];
    -- if expItemData then
    --     local itemConfig = ConfigManager.Get(EConfigIndex.t_item, expItemData.number);
    --     if itemConfig then
    --         des = string.format(uiText[1], itemConfig.name, expItemData.count * factor)
    --     end
    -- end
    -- return des
    return string.format(uiText[1], factor)
end


function EggHeroUi:gc_hero_info_gold(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes)
    self.heroGoldCD = CDLeftTime;
    self.freeGoldTimes = byfreeTime;
    self:StopGoldTimer();
    if self.heroGoldCD > 0 then
        self.heroGoldTimeId = timer.create(self.bindfunc["on_hero_time_gold"],1000,-1);
    end
    self:UpdateGoldItem(1);
    self:UpdateGoldItemByTime(1);
end

function EggHeroUi:gc_hero_info_crystal(byfreeTime,CDLeftTime,useOnceTimes,userTenTimes,todayDiscountTimes)
    self.heroCrystalCD = CDLeftTime;
    self.freeCrystalTimes = byfreeTime;
    self.todayDiscountTimes = todayDiscountTimes;
    self:StopCrystalTimer();
    if self.heroCrystalCD > 0 then
        self.heroCrystalTimeId = timer.create(self.bindfunc["on_hero_time_crystal"],1000,-1);
    end
    self:UpdateCrystalItem(2);
    self:UpdateCrystalItemByTime(2);
end

---------------新手引导接口函数-----------
function EggHeroUi:GetItemObjByIndex(index)
    if self.cont and self.cont[index] then 
        return self.cont[index].btn:get_game_object()
    end
end
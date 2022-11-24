SpExchange = Class('SpExchange',UiBaseClass)

function SpExchange.popPanel()
	SpExchange.instance = SpExchange:new();
end 

--重新开始
function SpExchange:Restart(data)
    ----app.log("SpExchange:Restart");
    UiBaseClass.Restart(self, data);
end

function SpExchange:InitData(data)
    ----app.log("SpExchange:InitData");
    UiBaseClass.InitData(self, data);
end

function SpExchange:RegistFunc()
	----app.log("SpExchange:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
    self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
    self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
    self.bindfunc['onExchangeClick'] = Utility.bind_callback(self, self.onExchangeClick);
    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
    self.bindfunc['setTimeData'] = Utility.bind_callback(self, self.setTimeData);
end

function SpExchange:InitUI(asset_obj)
	--app.log("SpExchange:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
        self.ui:set_name('SpExchange');
    local down = self.ui:get_child_by_name("centre_other/animation/sp_bk");
    down:set_active(false);
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"btn_cha");
	self.vs.title = ngui.find_label(self.ui,"lab_title");
	self.vs.bgTexture = ngui.find_texture(self.ui,"centre_other/animation/texture");
	--self.vs.spLabel = ngui.find_sprite(self.ui,"centre_other/animation/texture/sp_art_font");
	-- self.vs.bgLab1 = ngui.find_label(self.ui,"centre_other/animation/texture/txt");
    self.vs.vipLevel = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v")
    self.vs.vipLevel_star = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v2")
    self.vs.bgLab1 = ngui.find_label(self.ui,"centre_other/animation/texture/txt_haogan");

	self.vs.bgLab2 = ngui.find_label(self.ui,"centre_other/animation/texture/lab2");
	self.vs.labNumPay = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk1/lab");
	self.vs.labNumGet = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk2/lab");
	-- self.vs.labDesc = ngui.find_label(self.ui,"centre_other/animation/cont/lab_name");
	self.vs.labTimes = ngui.find_label(self.ui,"centre_other/animation/cont/lab");
	self.vs.btnExchange = ngui.find_button(self.ui,"centre_other/animation/btn");
	self.vs.icon = ngui.find_sprite(self.ui,"centre_other/animation/cont/sp_bk2/sp");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.btnExchange:set_on_click(self.bindfunc['onExchangeClick']);
        --双倍
        self.vs.doubleLab = self.ui:get_child_by_name("centre_other/animation/sp_di2")
        self.vs.doubleLab:set_active(false)
	self:UpdateUi();
end

function SpExchange:UpdateUi()

	if self.curAp ~= nil then 
		desAp = g_dataCenter.player.churchVigor - self.curAp;
		FloatTip.Float("兑换获得精力："..tostring(desAp));
	end
        
    if self.timeid then
        timer.stop(self.timeid);
        self.timeid = nil;
    end
    
    local cfList = ConfigManager._GetConfigTable(EConfigIndex.t_church_pray_buy_vigor_cost);
    --local allcount = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)
	self.curAp = tonumber(g_dataCenter.player.churchVigor)--g_dataCenter.player.ap;
	
        local curTimes = g_dataCenter.ChurchBot:get_buy_vigor_number()--g_dataCenter.player:GetFlagHelper():GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_apBuyTimes) or 0;
        self.curTimes = curTimes;
	--local maxTimes = #cfList--ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip).ex_can_buy_ap_times;
    local maxTimes = 0;
    local vip_data = g_dataCenter.player:GetVipData();
    if vip_data then
        maxTimes = vip_data.can_buy_vigor_times;
    end
	self.maxTimes = maxTimes;
	-- local cf = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip+1);
    local cf = g_dataCenter.player:GetNextVipData();
	if cf ~= nil then 
		local nextVipMaxTimes = cf.can_buy_vigor_times;
		-- self.vs.bgLab1:set_text("[FCD901FF]好感度"..tostring(cf.level).."[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
        self.vs.vipLevel:set_text(tostring(cf.level));
        self.vs.vipLevel_star:set_text('-'..tostring(cf.level_star));
        self.vs.bgLab1:set_text("[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
	else
		-- self.vs.bgLab1:set_text("[FCD901FF]好感度"..tostring(vip_data.level).."[-]可购买[FCD901FF]"..tostring(maxTimes).."次[-]");
        self.vs.vipLevel:set_text(tostring(cf.level));
        self.vs.vipLevel_star:set_text('-'..tostring(cf.level_star));
        self.vs.bgLab1:set_text("[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
	end 
	self.cost = 0;
	self.get = 0;
	for k,v in pairs(cfList) do 
		if v.times == curTimes then 
			self.cost = v.cost;
			self.get = v.vigor;
		end
	end
	self.vs.icon:set_sprite_name("dh_huoli");
	self.vs.labNumPay:set_text(tostring(self.cost));
	self.vs.labNumGet:set_text(tostring(self.get));
        
        local recovery_time = tonumber(g_dataCenter.ChurchBot:get_last_vigor_time())
        local recovery_sp_time = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000127).data)
        local allcount = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)
        local now_time = system.time()
        
        local cast_time = now_time - recovery_time
        --local t1,t2 = math.modf(30/10);
        local need_time = 0
        if cast_time <= recovery_sp_time then
            need_time = recovery_sp_time - cast_time
        else
            local t1,t2 = math.modf( cast_time/recovery_sp_time)
            if t1 > 1 then
                need_time = recovery_sp_time*t1 - cast_time
            else
                need_time = recovery_sp_time*2 - cast_time
            end
        end
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(need_time);
	--self.shengyutimelab:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
        --app.log("cast_time###############"..tostring(cast_time))
        --app.log("need_time###############"..tostring(need_time))
        
        local alltime = (allcount-self.curAp)*recovery_sp_time - cast_time
        
        local aday,ahour,amin,asec = TimeAnalysis.ConvertSecToDayHourMin(alltime);
        
	if maxTimes - curTimes > 0 then 
		self.vs.labTimes:set_text("今日剩余次数：[FCC205FF]"..tostring(curTimes).."/"..tostring(maxTimes));
	else 
		self.vs.labTimes:set_text("今日剩余次数：[FF0000FF]"..tostring(curTimes).."/"..tostring(maxTimes));
	end
        
        if allcount <= self.curAp then
            -- self.vs.labDesc:set_text("[FCC205FF]精力已满[-]");
        else
            --self.vs.labDesc:set_text("[FCC205FF]【"..string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec).."】后获得一点精力\n【"..string.format("%02d:", ahour) .. string.format("%02d:", amin) .. string.format("%02d", asec).."】后恢复全部精力");
            --self.timeid = timer.create(self.bindfunc["setTimeData"] ,1000,-1)
        end
	--self.vs.spLabel:set_sprite_name("tldh_tili");
	self.vs.bgLab2:set_text("精力！");
	self.vs.bgTexture:set_texture("assetbundles/prefabs/ui/image/backgroud/jin_bi_dui_huan/tldh_xuanchuantu.assetbundle");
	self.vs.title:set_text("精力");
end

function SpExchange:setTimeData()
    
    local allcount = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)
    self.curAp = tonumber(g_dataCenter.player.churchVigor)--g_dataCenter.player.ap;
    
    local recovery_time = tonumber(g_dataCenter.ChurchBot:get_last_vigor_time())
    local recovery_sp_time = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000127).data)
    --local allcount = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)
    local now_time = system.time()
    
    local cast_time = now_time - recovery_time
    --local t1,t2 = math.modf(30/10);
    local need_time = 0
    if cast_time <= recovery_sp_time then
        need_time = recovery_sp_time - cast_time
    else
        local t1,t2 = math.modf( cast_time/recovery_sp_time)
        if t1 > 1 then
            need_time = recovery_sp_time*t1 - cast_time
        else
            need_time = recovery_sp_time*2 - cast_time
        end
    end
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(need_time);
    --self.shengyutimelab:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
    --app.log("cast_time###############"..tostring(cast_time))
    --app.log("need_time###############"..tostring(need_time))
    
    local alltime = (allcount-self.curAp)*recovery_sp_time - cast_time
    
    local aday,ahour,amin,asec = TimeAnalysis.ConvertSecToDayHourMin(alltime);
    
    if allcount <= self.curAp then
        self.vs.labDesc:set_text("[FCC205FF]精力已满[-]");
        if self.timeid then
            timer.stop(self.timeid);
            self.timeid = nil;
        end
    else
        --self.vs.labDesc:set_text("[FCC205FF]【"..string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec).."】后获得一点精力\n【"..string.format("%02d:", ahour) .. string.format("%02d:", amin) .. string.format("%02d", asec).."】后恢复全部精力");
        --self.timeid = timer.create(self.bindfunc["setTimeData"] ,1000,-1)
    end
end

function SpExchange:onExchangeClick()
    
    local allcount = tonumber(ConfigManager.Get(EConfigIndex.t_discrete,83000128).data)
    if allcount <= self.curAp then
        FloatTip.Float("精力已满，无需兑换！");
        do return end
    end
    
    
	if self.curTimes < self.maxTimes then 
		local crystal = g_dataCenter.player.crystal;
		if crystal >= self.cost then 
			msg_activity.cg_buy_churchpray_vigor();
		else 
			--FloatTip.Float("钻石不足");
			HintUI.SetAndShowNew(EHintUiType.two,
			"充值",
			"您的剩余钻石数量不足\n是否前往充值？",
			nil,
			{str = "确定",func = function()
				self:Hide();
				self:DestroyUi();
				uiManager:PushUi(EUI.StoreUI);
			end },
			{str = "取消",func = function()
				self:Hide();
				self:DestroyUi();
			end});
		end
	else 
		if self.cost == 0 and self.get == 0 then 
			FloatTip.Float("今日兑换次数耗尽，请明日再进行兑换");
		else 
			FloatTip.Float("今日兑换次数耗尽，请明日再进行兑换");
		end 
	end
end 

function SpExchange:onCloseClick()
    
        if self.timeid then
            timer.stop(self.timeid);
            self.timeid = nil;
        end
        
	self:Hide();
	self:DestroyUi();
end 

function SpExchange:Init(data)
	--app.log("SpExchange:Init");
    self.pathRes = "assetbundles/prefabs/ui/package/ui_3701_gold_exchange.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function SpExchange:DestroyUi()
	--app.log("SpExchange:DestroyUi");
	if self.vs ~= nil then 
        if self.vs.bgTexture then
			self.vs.bgTexture:Destroy()
		end
		self.vs = nil;
	end 
	SpExchange.instance = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function SpExchange:Show()
	--app.log("SpExchange:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function SpExchange:Hide()
	--app.log("SpExchange:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function SpExchange:MsgRegist()
	--app.log("SpExchange:MsgRegist");
	--PublicFunc.msg_regist("player.gc_ap_buy",self.bindfunc['UpdateUi']);
        PublicFunc.msg_regist(msg_activity.gc_buy_churchpray_vigor,self.bindfunc['UpdateUi']);
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function SpExchange:MsgUnRegist()
	--app.log("SpExchange:MsgUnRegist");
	--PublicFunc.msg_unregist("player.gc_ap_buy",self.bindfunc['UpdateUi']);
        PublicFunc.msg_unregist(msg_activity.gc_buy_churchpray_vigor,self.bindfunc['UpdateUi']);
    UiBaseClass.MsgUnRegist(self);
end
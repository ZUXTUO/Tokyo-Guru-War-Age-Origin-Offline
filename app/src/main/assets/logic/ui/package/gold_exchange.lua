--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

local _UIText = {
    [1] = "前%d次兑换[fed440]金币双倍[-]",
    [2] = "使用少量钻石兑换大量金币，有概率暴击",
    [3] = "金币",
    [4] = "金币！",
    [5] = "暴击",
}

GoldExchangeUI = Class("GoldExchangeUI", UiBaseClass);
function GoldExchangeUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_3701_gold_exchange.assetbundle"
    UiBaseClass.Init(self, data);
end

function GoldExchangeUI:Restart(data)
    self.wrapContentItem = {}
    self.exchangeLogData = {} 

    if UiBaseClass.Restart(self, data) then
        --todo 各自额外的逻辑
        --self:UpdateText()
    end
end

function GoldExchangeUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

	self.bindfunc["on_click_buy"] = Utility.bind_callback(self, GoldExchangeUI.on_click_buy);
    self.bindfunc["gc_exchange_gold"] = Utility.bind_callback(self, GoldExchangeUI.gc_exchange_gold);
    self.bindfunc["on_click_close"] = Utility.bind_callback(self, GoldExchangeUI.on_click_close);
    self.bindfunc["on_crit_effect_loaded"] = Utility.bind_callback(self, GoldExchangeUI.on_crit_effect_loaded);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    
end

function GoldExchangeUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function GoldExchangeUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.exchangeTimes = 0;
    self.msgEnumId = MsgEnum.eactivity_time.eActivityTime_exchangeGold
end

function GoldExchangeUI:DestroyUi()
    if self.critEffect then
        self.critEffect = nil
    end
    if self.bgTexture then
        self.bgTexture:Destroy()
        self.bgTexture = nil
    end
    UiBaseClass.DestroyUi(self);    
end

function GoldExchangeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name("ui_3701_gold_exchange");
    
    
    self.costCrystal = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk1/lab");
    self.goldGet = ngui.find_label(self.ui,"centre_other/animation/cont/sp_bk2/lab");
    self.leftTimes = ngui.find_label(self.ui,"centre_other/animation/cont/lab");
    local spGold = ngui.find_sprite(self.ui,"centre_other/animation/cont/sp_bk2/sp");
    spGold:set_sprite_name("dh_jinbi")
    
    local btn1 = ngui.find_button(self.ui,"centre_other/animation/btn");
    btn1:set_on_click(self.bindfunc["on_click_buy"]);
	
    local btnClose = ngui.find_button(self.ui,"btn_cha");
    btnClose:set_on_click(self.bindfunc["on_click_close"]);
	-- self.bgLab = ngui.find_label(self.ui,"centre_other/animation/texture/txt");

    self.vipLevel = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v")
    self.vipLevel_star = ngui.find_label(self.ui, "centre_other/animation/texture/sp_v/lab_v2")
    self.bgLab = ngui.find_label(self.ui,"centre_other/animation/texture/txt_haogan");

    self.title = ngui.find_label(self.ui, "lab_title")
    self.bigWords = ngui.find_label(self.ui, "centre_other/animation/texture/lab2")
    self.bgTexture = ngui.find_texture(self.ui, "centre_other/animation/texture")
    -- self.labDesc = ngui.find_label(self.ui, "centre_other/animation/cont/lab_name")    

    self.double_ui = self.ui:get_child_by_name("centre_other/animation/sp_di2");
    self.double_ui_lab = ngui.find_label(self.ui, "centre_other/animation/sp_di2/lab");
    self.double_ui:set_active(false);
	self.btnExchangeBg = ngui.find_sprite(self.ui,"centre_other/animation/btn/animation/sprite_background");
	self.btnExchangeLab = ngui.find_label(self.ui,"centre_other/animation/btn/animation/lab");
	self.btnExchangeLabr,self.btnExchangeLabg,self.btnExchangeLabb,self.btnExchangeLaba = self.btnExchangeLab:get_color();
	self.btnExchange = ngui.find_button(self.ui,"centre_other/animation/btn");
	self.btnExchange:set_enable_tween_color(false);
    local bkPath = "centre_other/animation/sp_bk"
    self.objDownPane = self.ui:get_child_by_name(bkPath);
    self.scrollView = ngui.find_scroll_view(self.ui, bkPath .. "/scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, bkPath .. "/scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self.canGetGold = self:GetExchangeGold()    

    self:UpdateUi()
end

--注册消息分发回调函数
function GoldExchangeUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_exchange_gold,self.bindfunc['gc_exchange_gold']);
end

function GoldExchangeUI:UpdateDownPane()
    local count = #self.exchangeLogData
    if count == 0 then
        self.objDownPane:set_active(false)
    else
        self.objDownPane:set_active(true)
        self.wrapContent:set_min_index(- count + 1);
        self.wrapContent:set_max_index(0)
        self.wrapContent:reset()
        self.scrollView:reset_position() 
    end
end

function GoldExchangeUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1    

    if self.wrapContentItem[row] == nil then 
        local item = {}
        item.lblCrystal = ngui.find_label(obj, "sp_di/lab")
        item.lblGold = ngui.find_label(obj, "sp_2/lab")
        item.lblDouble = ngui.find_label(obj, "lab_double")
        self.wrapContentItem[row] = item
    end

    local item = self.wrapContentItem[row]
    local data = self.exchangeLogData[index]
    item.lblCrystal:set_text(tostring(data.crystal))
    item.lblGold:set_text(tostring(data.gold))
    
    if data.isCrit or data.isDouble then
        item.lblDouble:set_active(true)
        local txt = ''
        if data.isCrit then
            txt = txt .. _UIText[5]
        end
        if data.isDouble then
            txt = txt .. ' x2'
        end
        item.lblDouble:set_text(txt)
    else
        item.lblDouble:set_active(false)
    end
end

function GoldExchangeUI:gc_exchange_gold(goldCnt)
    --上次钻石
    local _crystal = self.NowCost
    local _isCrit = false
    local _isDouble = false

    self:UpdateText();
    --app.log('============>>>' .. goldCnt .. ' ' .. self.canGetGold)

    if goldCnt > self.canGetGold then
        self:ShowCrit();
        _isCrit = true
    end
    
    GWriteGoldExchange(goldCnt);

    local radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.gold_exchange, 2);
    local limit = g_dataCenter.activityReward:GetDoubleLimitNum(ENUM.Double.gold_exchange);
    if radio_num > 1 and self.exchangeTimes <= limit then
        _isDouble = true
        goldCnt = goldCnt * radio_num
    end

    local data = {
        crystal = _crystal,
        gold = goldCnt,
        isCrit = _isCrit,
        isDouble = _isDouble
    }
    table.insert(self.exchangeLogData, 1, data)
    
    self:UpdateDownPane()

end
--注销消息分发回调函数
function GoldExchangeUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_exchange_gold,self.bindfunc['gc_exchange_gold']);
end


--[[点击购买]]
function GoldExchangeUI:on_click_buy()
    FloatTip.Float("已充满");
    --[[
	if self.totaltimes > self.exchangeTimes then 
		local crystal = g_dataCenter.player.crystal;
		if crystal >= self.NowCost then 
				msg_activity.cg_exchange_gold()
		else
			HintUI.SetAndShowNew(EHintUiType.two,
			"充值",
			"您的剩余钻石数量不足\n是否前往充值？",
			nil,
			{str = "确定",func = function()
				uiManager:PushUi(EUI.StoreUI);
			end },
			{str = "取消",func = function()
				uiManager:PopUi(EUI.GoldExchangeUI)
			end});
		end 
	else 
		FloatTip.Float("今日兑换次数耗尽，请明日再进行兑换");
	end
    ]]
end

function GoldExchangeUI:on_click_close()
    uiManager:PopUi()
end

function GoldExchangeUI:UpdateText()
    if self.ui == nil then
        return
    end
   
    self.goldGet:set_text(tostring(self.canGetGold))
    local cost = self:GetExchangeCystal()
    
    self.costCrystal:set_text(""..cost)
    local viplevel = g_dataCenter.player.vip
    local totaltimes = ConfigManager.Get(EConfigIndex.t_activity_time, self.msgEnumId).number_restriction.d
	local vip_data = g_dataCenter.player:GetVipData();
    if vip_data then
        totaltimes = totaltimes + vip_data.ex_exchange_gold_times;
    end
	self.totaltimes = totaltimes;
    -- local cf = ConfigManager.Get(EConfigIndex.t_vip_data,g_dataCenter.player.vip+1);
    local cf = g_dataCenter.player:GetNextVipData();
	if cf ~= nil then 
		local nextVipMaxTimes = cf.ex_exchange_gold_times;
		-- self.bgLab:set_text("[FCD901FF]好感度"..tostring(cf.level).."[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
        self.vipLevel:set_text(tostring(cf.level));
        self.vipLevel_star:set_text('-'..tostring(cf.level_star));
        self.bgLab:set_text("[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
	else
		-- self.bgLab:set_text("[FCD901FF]好感度"..tostring(vip_data.level).."[-]可购买[FCD901FF]"..tostring(totaltimes).."次[-]");
        self.vipLevel:set_text(tostring(cf.level));
        self.vipLevel_star:set_text('-'..tostring(cf.level_star));
        self.bgLab:set_text("[-]可购买[FCD901FF]"..tostring(nextVipMaxTimes).."次[-]");
	end 
    if self.exchangeTimes >= totaltimes then
        self.leftTimes:set_text("今日兑换次数：[FDE517]"..self.exchangeTimes.."/"..totaltimes .. '[-]')
		self.btnExchangeBg:set_color(0,0,0,1);
		self.btnExchangeLab:set_color(1,1,1,1);
    else
        self.leftTimes:set_text("今日兑换次数：[FDE517]"..self.exchangeTimes.."/"..totaltimes .. '[-]')
		self.btnExchangeBg:set_color(1,1,1,1);
		self.btnExchangeLab:set_color(self.btnExchangeLabr,self.btnExchangeLabg,self.btnExchangeLabb,self.btnExchangeLaba);
    end
    
    local radio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.gold_exchange, 2);
    local limit = g_dataCenter.activityReward:GetDoubleLimitNum(ENUM.Double.gold_exchange);
    if radio_num > 1 and self.exchangeTimes < limit then
        self.double_ui:set_active(true);
        self.double_ui_lab:set_text(string.format(_UIText[1], (limit - self.exchangeTimes)));
    else
        self.double_ui:set_active(false);
    end

    -- self.labDesc:set_text(_UIText[2])
    self.title:set_text(_UIText[3])
    self.bigWords:set_text(_UIText[4])

    self.bgTexture:set_texture("assetbundles/prefabs/ui/image/backgroud/jin_bi_dui_huan/jbdh_xuanchuantu.assetbundle")
end

function GoldExchangeUI:GetExchangeGold()
    --[[
    local  level = g_dataCenter.player.level;
    local dropid = ConfigManager.Get(EConfigIndex.t_exchange_gold,level).drop_id;
    local dropdata = ConfigManager.Get(EConfigIndex.t_drop_something,dropid)
    local vipData = g_dataCenter.player:GetVipData();
    return math.floor(dropdata[1].goods_number * vipData.money_add_reward_ex)
    ]]
    return GameInfoForThis.Gold
end

function GoldExchangeUI:GetExchangeCystal()
    --[[
    local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(self.msgEnumId);
	number = number or "d=0";
	self.exchangeTimes = PublicFunc.GetActivityCont(number,"d");
    local maxConfigIndex = ConfigManager.GetDataCount(EConfigIndex.t_exchange_gold_cost) 
    local cost = 0
    if self.exchangeTimes+1<= maxConfigIndex then
        cost = ConfigManager.Get(EConfigIndex.t_exchange_gold_cost,self.exchangeTimes+1).cost
    else
        cost = ConfigManager.Get(EConfigIndex.t_exchange_gold_cost,maxConfigIndex).cost
    end
    self.NowCost = cost
    return cost 
    ]]
    return GameInfoForThis.Crystal
end

function GoldExchangeUI:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
        self:UpdateText()
        self:UpdateDownPane()
    end
end

function GoldExchangeUI:on_crit_effect_loaded(pid, filepath, asset_obj, error_info)
    if asset_obj then
        self.critEffect = asset_game_object.create(asset_obj);
        self.critEffect:set_parent(self.ui)
        self.critEffect:set_local_scale(1,1,1);
        self.critEffect:set_local_position(0,0,0); 
        self:ShowEffect()
    end
end

function GoldExchangeUI:ShowEffect()
    if self.critEffect then
        self.critEffect:set_active(false)
        self.critEffect:set_active(true)
    end 
end

function GoldExchangeUI:ShowCrit(args)
    if self.critEffect == nil then
        ResourceLoader.LoadAsset("assetbundles/prefabs/ui/package/sp_crit.assetbundle", self.bindfunc['on_crit_effect_loaded']);
    else
        self:ShowEffect()
    end
end

--endregion

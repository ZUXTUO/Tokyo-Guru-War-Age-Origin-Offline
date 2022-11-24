--region fuzion_main_ui.lua
--Author : zzc
--Date   : 2016/1/13

--endregion

-------------------------------- 已废弃 -----------------------------


FuzionMainUI = Class('FuzionMainUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/fuzion/ui_2901_fuzion.assetbundle"

-- 抽取本地的文本，需要替换到配置表
_local.UIText = {
	[1] = "大乱斗",
	[2] = "",
	[3] = "",
	[4] = "",
	[5] = "第%d赛季",
	[6] = "剩余奖励次数",
	[7] = "",
	[8] = "下一场无奖励",
	[9] = "作战开始",
	[10] = "每日[1da1d8]%s[-]开启",
}

_local.StartTime = {weekday=6, hour=3}		-- 周六凌晨3点重置活动

-------------------------------------类方法-------------------------------------
--初始化
function FuzionMainUI:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

--重新开始
function FuzionMainUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    	-- 重置匹配玩家数据
    	g_dataCenter.fuzion:ResetPlayer()
	end
end

--初始化数据
function FuzionMainUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

--释放界面
function FuzionMainUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    self:ClearTimer();

    -- 退出界面后清除临时数据，保证数据的及时性
    g_dataCenter.fuzion:SetRankList(nil)
    --g_dataCenter.fuzion:SetChampionList(nil)	-- 历史数据不清除
end

--显示UI
function FuzionMainUI:Show()
	if UiBaseClass.Show(self) then
		self:UpdateUi()
	end
end

--注册方法
function FuzionMainUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
    self.bindfunc["on_exchange_btn"] = Utility.bind_callback(self, self.on_exchange_btn);
    self.bindfunc["on_start_btn"] = Utility.bind_callback(self, self.on_start_btn);
    self.bindfunc["on_rank_btn"] = Utility.bind_callback(self, self.on_rank_btn);
    self.bindfunc["on_get_my_data"] = Utility.bind_callback(self, self.on_get_my_data);
    self.bindfunc["on_timer_over"] = Utility.bind_callback(self, self.on_timer_over);
    self.bindfunc["on_gc_activity_config"] = Utility.bind_callback(self, self.on_gc_activity_config);
end 

--撤销注册方法
function FuzionMainUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function FuzionMainUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_activity.gc_activity_config, self.bindfunc["on_gc_activity_config"]);
	PublicFunc.msg_regist(msg_daluandou.gc_sync_my_daluandou_data, self.bindfunc["on_get_my_data"]);
end

--注销消息分发回调函数
function FuzionMainUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_activity.gc_activity_config, self.bindfunc["on_gc_activity_config"]);
	PublicFunc.msg_unregist(msg_daluandou.gc_sync_my_daluandou_data, self.bindfunc["on_get_my_data"]);
end

--初始化UI
function FuzionMainUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("fuzion_main_ui");

	local path = "centre_other/animation/content1/"
	------------------------------ 顶部 -----------------------------
	local labHead = ngui.find_label(self.ui, path.."lab_title")
	local labTime = ngui.find_label(self.ui, path.."lab_time1")
	local labTodayCnt = ngui.find_label(self.ui, path.."lab_num")
	local labTodayHead = ngui.find_label(self.ui, path.."txt")

	path = "centre_other/animation/content2/"
	------------------------------ 中部 -----------------------------
	local labPartDes1 = ngui.find_label(self.ui, path.."cont1/txt1")
	local labPartDes2 = ngui.find_label(self.ui, path.."cont2/txt1")
	local labPartDes3 = ngui.find_label(self.ui, path.."cont3/txt1")

	path = "down_other/animation/"
	------------------------------ 底部 -----------------------------
	local btnRank = ngui.find_button(self.ui, path.."btn_ranklist")
	local btnStart = ngui.find_button(self.ui, path.."btn2")
	local spStart = ngui.find_sprite(self.ui, path.."btn2/animation/sprite_background")
	local labStart = ngui.find_label(self.ui, path.."btn2/animation/lab")

	btnRank:set_on_click(self.bindfunc["on_rank_btn"])
	btnStart:set_on_click(self.bindfunc["on_start_btn"])
	labHead:set_text(string.format(_local.UIText[5], 1))
	labTodayHead:set_text(_local.UIText[6])
	labStart:set_text(_local.UIText[9])

	self.labHead = labHead
	self.labTime = labTime
	self.labTodayCnt = labTodayCnt

	self.myData = nil
	--首次打开界面，拉取信息
	if not g_dataCenter.fuzion.isInitMyData then
		msg_daluandou.cg_request_my_daluandou_data()
	else
		self.myData = g_dataCenter.fuzion:GetMyData()
	end

	self:UpdateUi()
end

--刷新界面
function FuzionMainUI:UpdateUi()
    app.log("**********************isshowredpoint:"..tostring(isShowRedPoint))
	if self.ui == nil then return end
	if self.myData == nil then return end

	self:ClearTimer();

	local curtime = math.floor(system.time());
	local result,time,timeFinishNumber = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_fuzion]:Analyze(curtime);

    result = 1 --改为24小时全天开放
	--开启中
	if result == 1 then
		PublicFunc.SetUISpriteWhite(self.spStart)
	--未开启
	else
		PublicFunc.SetUISpriteGray(self.spStart)
	end
	self.state = result;
    
	if time then
		self.timerid = timer.create(self.bindfunc["on_timer_over"], time * 1000, 1);
	end

	local fightsoul = g_dataCenter.package:find_count(ENUM.EPackageType.Item, IdConfig.FightSoul);
	-- self.labPoint:set_text(tostring(self.myData.point)) -- 积分不显示了哇?
	self.labHead:set_text(string.format(_local.UIText[5], self.myData.season))
	local s1, s2 = self:GetDateRange()
	self.labTime:set_text(s1 .. " ~ " .. s2)
	self.labTodayCnt:set_text(string.format("%s/%s", math.max(0, g_dataCenter.fuzion.totalCnt - self.myData.fightcnt), g_dataCenter.fuzion.totalCnt))
end

-- 重新获取一下活动状态
function FuzionMainUI:SendMsg()
	msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_fuzion);
end

function FuzionMainUI:GetDayTimeRange()
	local result = "";
	local config = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_fuzion)
	if type(config.start_time) == "table" then
		local timeSeg = {}
		local duration = config.continue_time;
		local h = math.floor(duration / 3600)
		local m =  math.floor((duration - h * 3600) / 60)
		for i, v in ipairs(config.start_time) do
			local str = string.format("%02d:%02d-%02d:%02d", v.h, v.i, v.h+h, v.i+m);
			table.insert(timeSeg, str);
		end
		if #timeSeg > 1 then
			result = table.concat(timeSeg, ",");
		else
			result = table.concat(timeSeg, "");
		end
	end
	return result;
end

-- 获取日期范围
function FuzionMainUI:GetDateRange()
	local time = system.time()
	local date = os.date('*t', time)
	local weekday = date['wday'] - 1
	local hour = date['hour']
	local dayDelt = weekday - _local.StartTime.weekday
	local hourDelt = hour - _local.StartTime.hour
	local time1 = 0
	-- 当前周结束
	if weekday < _local.StartTime.weekday or 
		(weekday == _local.StartTime.weekday and hour < _local.StartTime.hour) then
		time1 = time - (7 + weekday - _local.StartTime.weekday) * 24 * 3600
	-- 下一周结束
	else
		time1 = time - (weekday - _local.StartTime.weekday) * 24 * 3600
	end

	local time2 = time1 + 7 * 24 * 3600

	return Utility.getUsualTime(time1, "%Y-%m-%d"), Utility.getUsualTime(time2, "%Y-%m-%d")
end

function FuzionMainUI:ClearTimer()
	if self.timerid then
    	timer.stop(self.timerid);
    	self.timerid = nil;
	end
end

-------------------------------------本地回调-------------------------------------
--定时时间到
function FuzionMainUI:on_timer_over(t)
	self:SendMsg()
end

--兑换按钮
function FuzionMainUI:on_exchange_btn(t)
	g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.FUZION)
end

--点击开始按钮
function FuzionMainUI:on_start_btn(t)
    --玩法限制作弊(大乱斗)
    if g_dataCenter.gmCheat:noPlayLimit() then
        uiManager:PushUi(EUI.FuzionHeroUI)	    
    else
        if self.state == 1 then
		    uiManager:PushUi(EUI.FuzionHeroUI)
	    end
    end
end

--点击排行榜按钮
function FuzionMainUI:on_rank_btn(t)
	uiManager:PushUi(EUI.FuzionRankUI)
end


-------------------------------------网络回调-------------------------------------
function FuzionMainUI:on_gc_activity_config(result, system_id, cf)
	if system_id ~= MsgEnum.eactivity_time.eActivityTime_fuzion then return end
	self:UpdateUi()
end

function FuzionMainUI:on_get_my_data(t)
	self.myData = g_dataCenter.fuzion:GetMyData()
	self:UpdateUi()
end

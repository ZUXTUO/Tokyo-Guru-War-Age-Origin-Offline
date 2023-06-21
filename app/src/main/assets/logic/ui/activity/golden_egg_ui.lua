
GoldenEggUI = Class("GoldenEggUI", UiBaseClass)

local resPath = "assetbundles/prefabs/ui/award/ui_1143_award.assetbundle";

local _UIText = {
    [1] = "活动倒计时:[FFF000]%s天%02d:%02d:%02d[-]",
    [2] = "品鉴券不足，不能鉴赏美酒",
    [3] = "钻石不足，不能鉴赏美酒",
    [4] = "每累计充值[FFF000]%s元[-]可获得1张品鉴券，每3次品鉴券必中1次[FFF000FF]10倍钻石[-]赠送。",
    [5] = "这是一个空酒杯",
}

local _AnimationName = {
    Empty = "ui_1143_award_dizuo_empty",
    Drink = "ui_1143_award_dizuo_drink",
    Reset = "ui_1143_award_dizuo_in",
}

function GoldenEggUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function GoldenEggUI:Restart()
    self.dtAdd = 0
    local config = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_golden_egg)
    if config then
        self.activityEndTime = config.e_time
    else
        app.log('获取砸金蛋活动时间失败' .. debug.traceback())
        return
    end

    self.readyToClose = false

    -- 移动距离 2.5
    self.speed = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_marqueeMoveSpeed).data
    self.upInter = 0.02        -- 刷新间隔(秒）
    self.marqueeList = {}
    self.currMarquee = nil
    self.startPos = 207
    self.endPos = -207

    self.isShowMarquee = nil

    self.isPlayAnimation = false
    if UiBaseClass.Restart(self, data) then
    end
end

function GoldenEggUI:Show()
    self:update_ui()
    UiBaseClass.Show(self)
end

function GoldenEggUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule)
    self.bindfunc["on_recharge"] = Utility.bind_callback(self, self.on_recharge)
    self.bindfunc["update_marquee"] = Utility.bind_callback(self, self.update_marquee)
    self.bindfunc["update_ui"] = Utility.bind_callback(self, self.update_ui)
    self.bindfunc["on_drink"] = Utility.bind_callback(self, self.on_drink)
    self.bindfunc["gc_golden_egg_use"] = Utility.bind_callback(self, self.gc_golden_egg_use)
end

function GoldenEggUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist("msg_activity.gc_pause_activity.spec", self.bindfunc['on_close']);
    PublicFunc.msg_regist(msg_activity.gc_sync_my_golden_egg_data, self.bindfunc['update_ui'])
    PublicFunc.msg_regist(msg_activity.gc_golden_egg_use, self.bindfunc['gc_golden_egg_use'])
end

function GoldenEggUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist("msg_activity.gc_pause_activity.spec", self.bindfunc['on_close']);
    PublicFunc.msg_unregist(msg_activity.gc_sync_my_golden_egg_data, self.bindfunc['update_ui'])
    PublicFunc.msg_unregist(msg_activity.gc_golden_egg_use, self.bindfunc['gc_golden_egg_use'])
end

function GoldenEggUI:DestroyUi()
    TimerManager.Remove(self.bindfunc["update_marquee"])
    UiBaseClass.DestroyUi(self);
end

function GoldenEggUI:on_close()
    uiManager:PopUi()
end

function GoldenEggUI:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.GoldenEgg)
end

function GoldenEggUI:on_recharge()
    uiManager:PushUi(EUI.StoreUI)
end

function GoldenEggUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("golden_egg_ui")

    local aniPath = "centre_other/animation/"
    local topPath = aniPath .. "texture1/"
    local cupPath = aniPath .. "cont/"
    local downPath = aniPath .. "down/"

    local btnClose = ngui.find_button(self.ui, topPath .. "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    local btnRule = ngui.find_button(self.ui, topPath .. "btn_xiangqing")
    btnRule:set_on_click(self.bindfunc["on_rule"])
    self.lblTime = ngui.find_label(self.ui, topPath .. "lab1")
    self:CountDown()

    --跑马灯
    self.spMarquee = ngui.find_sprite(self.ui, topPath .. "sp_bar")
    self.spMarquee:set_active(false)
    self.lblMarquee = ngui.find_label(self.ui, topPath .. "sp_bar/lab")
    self.objMarquee = self.lblMarquee:get_game_object()
    self.mX, self.mY, self.mZ = self.objMarquee:get_local_position()


    self.objCups = {}
    for i = 1, 3 do
        local btnCup = ngui.find_button(self.ui, cupPath .. "sp_dizuo" .. i .. "/cont/sp_kongbai")
        btnCup:set_on_click(self.bindfunc["on_drink"])
        btnCup:set_event_value("", i)
        self.objCups[i] = self.ui:get_child_by_name(cupPath .. "sp_dizuo" .. i .. "/cont")
    end

    --
    local lblDesc =  ngui.find_label(self.ui, downPath .. "lab")
    local yuan = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_golden_egg_ticket_yuan).data
    lblDesc:set_text(string.format(_UIText[4], yuan))

    self.lblConsumeTicket =  ngui.find_label(self.ui, downPath .. "txt1/sp_chuizi1/lab_num")
    self.lblConsumeDiamond =  ngui.find_label(self.ui, downPath .. "txt1/sp_chuizi2/lab_num")

    self.lblMyTicket =  ngui.find_label(self.ui, downPath .. "txt2/lab_num")
    self.lblGetDiamond =  ngui.find_label(self.ui, downPath .. "txt3/lab_num")
    self.lblCanGetTicket =  ngui.find_label(self.ui, downPath .. "txt4/lab_num")

    local btnRecharge = ngui.find_button(self.ui, downPath .. "btn_yellow")
    btnRecharge:set_on_click(self.bindfunc["on_recharge"])

    TimerManager.Add(self.bindfunc["update_marquee"], self.upInter * 1000, -1)
    self:update_ui()

    for i = 1, 3 do
        local isGet = g_dataCenter.activityReward:IsGetGoldenEgg(i)
        if isGet then
            self:PlayAnimation(i, _AnimationName.Empty)
        end
    end
end

function GoldenEggUI:update_ui()
    local _ticket, _diamond = g_dataCenter.activityReward:GetGoldenEggConsume()
    self.lblConsumeTicket:set_text(tostring(_ticket))
    self.lblConsumeDiamond:set_text(tostring(_diamond))

    local data = g_dataCenter.activityReward:GetGoldenEggData()
    self.lblMyTicket:set_text(tostring(data.ticket))
    self.lblGetDiamond:set_text(tostring(data.todayProfit))
    self.lblCanGetTicket:set_text(tostring(data.canGetTicket))
end

function GoldenEggUI:gc_golden_egg_use(index)
    --是否全部重置
    if g_dataCenter.activityReward:NeedReset() then
        for i = 1, 3 do
            self:PlayAnimation(i, _AnimationName.Reset)
        end
    else
        self:PlayAnimation(index, _AnimationName.Empty)
    end
end

function GoldenEggUI:CountDown()
    if self.lblTime == nil or self.activityEndTime == nil then
        return
    end
    local diffSec = self.activityEndTime - system.time()
    if diffSec > 0 then
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        self.lblTime:set_text(string.format(_UIText[1], day,hour,min,sec))
    else
        --活动结束关闭
        if not self.readyToClose then
            self.readyToClose = true
            self:on_close()
        end
    end
end

function GoldenEggUI:Update(dt)
    self.dtAdd = self.dtAdd + dt
    if self.dtAdd >= 1 then
        self.dtAdd = 0
        self:CountDown()
    end
end

--[[开始刷新]]
function GoldenEggUI:update_marquee()
    self:SetMarquee()
    self:RunMarquee()
end

function GoldenEggUI:SetMarquee()
    if self.currMarquee ~= nil then
        return
    end
    self.currMarquee = g_dataCenter.activityReward:GetMarquee()
    local _isShow = false
    if self.currMarquee then
        -- 设置内容
        self.lblMarquee:set_text(self.currMarquee)
        -- 获得内容宽度
        self.uiWidth, _ = self.lblMarquee:get_size()
        _isShow = true
    end
    if self.isShowMarquee ~= _isShow then
        self.isShowMarquee = _isShow
        self.spMarquee:set_active(_isShow)
    end
end

function GoldenEggUI:RunMarquee()
    if self.currMarquee == nil then
        return
    end
    self.mX = self.mX - self.speed
    self.objMarquee:set_local_position(self.mX, self.mY, self.mZ)
    if self.mX + self.uiWidth <= self.endPos then
        self.mX = self.startPos
        self.objMarquee:set_local_position(self.mX, self.mY, self.mZ)
        self.currMarquee = nil
    end
end

function GoldenEggUI:on_drink(t)
    local index = t.float_value
    if self.isPlayAnimation then
        return
    end
    if g_dataCenter.activityReward:IsGetGoldenEgg(index) then
        FloatTip.Float(_UIText[5])
        return
    end

    local _ticket, _diamond = g_dataCenter.activityReward:GetGoldenEggConsume()
    local data = g_dataCenter.activityReward:GetGoldenEggData()
    if _ticket > data.ticket then
        FloatTip.Float(_UIText[2])
        return
    end
    if _diamond > PropsEnum.GetValue(IdConfig.Crystal) then
        FloatTip.Float(_UIText[3])
        return
    end
    self:PlayAnimation(index, _AnimationName.Drink)
    AudioManager.PlayUiAudio(81200230)
end

function GoldenEggUI:PlayAnimation(index, name)
    if self.objCups[index] then
        if name ~= _AnimationName.Empty then
            self.isPlayAnimation = true
            self.playIndex = index
        end
        self.objCups[index]:animated_play(name)
    end
end

function GoldenEggUI.OnOver(obj, name)
    local scene = uiManager:GetCurScene()
    if scene and scene.isPlayAnimation ~= nil then
        scene.isPlayAnimation = false
        if name == "drink" then
            msg_activity.cg_golden_egg_use(scene.playIndex)
        end
    end
end



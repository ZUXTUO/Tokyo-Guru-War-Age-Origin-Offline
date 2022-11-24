PeakHitUi = Class('PeakHitUi', UiBaseClass);

local res = "assetbundles/prefabs/ui/new_fight/panel_peakedness_show.assetbundle";

function PeakHitUi.GetResList()
    return {res}
end

function PeakHitUi.Start(data)
    if PeakHitUi.Instance == nil then
        PeakHitUi.Instance = PeakHitUi:new()
        Root.AddUpdate(PeakHitUi.Update, PeakHitUi.Instance)
    end
    PeakHitUi.Instance:SetData(data)
end

function PeakHitUi.Destroy()
    if PeakHitUi.Instance then
        Root.DelUpdate(PeakHitUi.Update, PeakHitUi.Instance)
        PeakHitUi.Instance:DestroyUi()
        PeakHitUi.Instance = nil
    end
end

function PeakHitUi:SetData(data)
    if data then
        self.callback = data.callback
    end
end

--初始化
function PeakHitUi:Init()
    self.pathRes = res

    self.cacheHitFx = {}
    self.firstClick = false
    self.reduceTime = 0
    self.curTouchEndTime = 0
    self.curTouchBeginTime = 0
    self.lastTouchEndTime = 0
    self.curHitValue = 0
    self.groupHitCount = 0
    self.totalHitCount = 0
    self.maxCount = 20
    self.speedArray = {1, 1.2, 1.5, 1.8} -- 对应点击频率 1/s, 2/s, 3/s, 4/s
    self.speedIndex = 1
    self.lastSpeedIndex = 1
    self.aniIndex = 0
    self.aniObj = nil
    self.aniNameArray = {"zhengzha01","zhengzha02","zhengzha03","zhengzha04","zhengzha05"}
    self.aniCount = #self.aniNameArray
    self.aniNameArray[0] = "stand"

    UiBaseClass.Init(self)
end

function PeakHitUi:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['on_talk_over'] = Utility.bind_callback(self, self.on_talk_over)
    self.bindfunc['on_btn_hit'] = Utility.bind_callback(self, self.on_btn_hit)
end

function PeakHitUi:DestroyUi()
    self.aniObj = nil
    self.callback = nil
    self.firstClick = false
    self:ClearHitFx()
    UiBaseClass.DestroyUi(self);
end

--初始化UI
function PeakHitUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("peak_hit_ui")

    local path = "down_other/animation/"
    self.btn = ngui.find_button(self.ui, path.."btn")
    self.labTips = ngui.find_label(self.ui, path.."lab")
    self.labSound = ngui.find_label(self.ui, path.."lab_xx")
    self.pro = ngui.find_progress_bar(self.ui, path.."pro_di")
    self.spHand = ngui.find_sprite(self.ui, path.."sp")

    self.btn:set_on_ngui_press(self.bindfunc["on_btn_hit"])
    self.pro:set_value(0)

    self.fxProEnd = self.ui:get_child_by_name("pro_di/sp/fx_ui_panel_peakedness_show_jindutiao")
    self.fxBtnHit = self.ui:get_child_by_name("btn/fx_ui_panel_peakedness_show_press_1")
    self.fxBtnEnd = self.ui:get_child_by_name("btn/fx_ui_panel_peakedness_show_press_2")

    -- self.fxProEnd:set_active(false)
    -- self.fxBtnHit:set_active(false)
    -- self.fxBtnEnd:set_active(false)

    -- 显示对话文字，隐藏其他的
    self.btn:set_active(false)
    self.labTips:set_active(false)
    self.labSound:set_active(true)
    self.pro:set_active(false)
    self.spHand:set_active(false)

    local fbxObj = TriggerFunc.GetScreenPlayObj("jinmu_bianshen") -- 板凳金木
    self.aniObj = fbxObj:get_child_by_name("jinmu_bianshen01_fbx")

    -- 播放金木语音 - '无法原谅'
    AudioManager.PlayUiAudio(81200074)
    TimerManager.Add(self.bindfunc["on_talk_over"], 2000, 1)
end

function PeakHitUi:on_talk_over()
    if not self.ui then return end
    self.btn:set_active(true)
    self.labTips:set_active(true)
    self.labSound:set_active(false)
    self.pro:set_active(true)
    self.spHand:set_active(true)
end

function PeakHitUi:on_btn_hit(name, state, x, y, goObj)
    if not self.ui then return end
    if self.totalHitCount > self.maxCount then return end

    --释放
    if state == false then
        self.reduceTime = 0
        self.totalHitCount = self.totalHitCount + 1
        self.groupHitCount = self.groupHitCount + 1

        self.curTouchEndTime = app.get_real_time()
        local rate = self.groupHitCount / (self.curTouchEndTime - self.lastTouchEndTime)
        self.speedIndex = self:GetSpeedIndex(rate)

        if self.groupHitCount == 1 then
            self.lastTouchEndTime = self.curTouchEndTime
        end

        if self.totalHitCount == self.maxCount then
            self.fxBtnEnd:set_active(false)
            self.fxBtnEnd:set_active(true)

            self.fxProEnd:set_active(false)
            self.fxProEnd:set_active(true)
        end

    --点击特效
    else
        self.curTouchBeginTime = app.get_real_time()
        if not self.firstClick then
            self.spHand:set_active(false)
            self.firstClick = true
        end
        -- self.fxBtnHit:set_active(false)
        -- self.fxBtnHit:set_active(true)
        
        self:InsertHitFx()
    end
end

--clone特效要加入到缓存池，否则GC后会报错
function PeakHitUi:InsertHitFx()
    if not self.fxBtnHit then return end

    local unUseCache = nil
    -- 从缓存池查找到可用特效
    for i, v in pairs(self.cacheHitFx) do
        if not v.used then
            v.used = true
            v.time = app.get_real_time()
            v.obj:set_active(true)
            v.obj:set_local_position(0, 0, 0)

            unUseCache = v
            break;
        end
    end

    -- 克隆一个新的特效放到缓存池（池子大小为20）
    if not unUseCache and #self.cacheHitFx < 20 then
        table.insert(self.cacheHitFx, {obj=self.fxBtnHit:clone(), time=app.get_real_time()})
        local unUseCache = self.cacheHitFx[ #self.cacheHitFx ]
        unUseCache.obj:set_active(true)
        unUseCache.used = true
    end
end

function PeakHitUi:RemoveHitFx()
    local now_time = app.get_real_time()
    for i, v in pairs(self.cacheHitFx) do
        if v.used and v.time < now_time - 1.5 then
            v.used = nil
            v.obj:set_active(false)
            v.obj:set_local_position(99999, -99999, 99999)
        end
    end
end

function PeakHitUi:ClearHitFx()
    if self.cacheHitFx then
        for i, v in pairs(self.cacheHitFx) do
            if v.used then
                v.used = nil
                v.obj:set_active(false)
                v.obj:set_local_position(99999, -99999, 99999)
            end
        end
        self.cacheHitFx = nil
    end
end

function PeakHitUi:GetSpeedIndex(rate)
    return Utility.get_in_range_number( math.floor(rate), 1, #self.speedArray );
end

function PeakHitUi:SetAniIndex(index)
    if self.aniIndex ~= index then
        self.aniIndex = index
        self.aniObj:animator_play(self.aniNameArray[index])
        if index >0 and index <6 then
            AudioManager.PlayUiAudio(81200036+index)
        end
    end
end

function PeakHitUi:Update()
    if not self or not self.ui then return end
    if self.curTouchBeginTime == 0 then return end
    if self.completeHit then return end

    self:RemoveHitFx()

    local need_return = false
    local now = app.get_real_time()
    if now - self.curTouchBeginTime > 0.6 then 
        --等待当前动作播完回到待机状态
        if self.aniIndex > 0 then
            self.reduceTime = now
            -- self:SetAniIndex(0)
            self.groupHitCount = 0
            self.speedIndex = 1
            self.aniObj:set_animator_speed("", self.speedArray[self.speedIndex])
        end
        if self.curHitValue > 0 then
            self.curHitValue = math.max(self.curHitValue - 0.01, 0)
            self.pro:set_value(self.curHitValue)
            self.totalHitCount = math.floor(self.curHitValue * self.maxCount)
        end
        return
    end
    
    if self.aniIndex == 0 then
        self:SetAniIndex(1)
    end

    if self.curHitValue ~= self.totalHitCount / self.maxCount then
        if self.totalHitCount / self.maxCount - self.curHitValue > 0 then
            self.curHitValue = math.min(1, self.curHitValue + math.min(self.totalHitCount / self.maxCount - self.curHitValue, 0.01))
        else
            self.curHitValue = math.max(0, self.curHitValue - math.min(self.curHitValue - self.totalHitCount / self.maxCount, 0.01))
        end
        self.pro:set_value(self.curHitValue)
    end

    if self.curHitValue == 1 then
        self.completeHit = true
        self.btn:set_active(false)

        -- 预留进度条完成特效播放时间
        TimerManager.Add(function()
            if self.ui then self.ui:set_active(false) end
        end, 500, 1)

        --[[挣脱锁链]]
        SystemLog.AppStartClose(500000009);
    end

    if self.totalHitCount >= self.maxCount then
        if self.aniIndex == 0 then
            self:SetAniIndex(self.aniCount)
        end
        self.speedIndex = 1
        self.aniObj:set_animator_speed("", self.speedArray[self.speedIndex])
        return
    end

    --动画变速
    if self.speedIndex ~= self.lastSpeedIndex then
        self.lastSpeedIndex = self.speedIndex
        self.aniObj:set_animator_speed("", self.speedArray[self.speedIndex])
    end
end

function ShapeshiftCallback(obj, value)
    if PeakHitUi.Instance then
        local self = PeakHitUi.Instance
        value = tonumber(value) or 0
        if value > 0 then
            if self.reduceTime > 0 then
                self:SetAniIndex(0)
            else
                -- 挣扎动画结束，触发一下变身动画剧情
                if value == self.aniCount then
                    if self.completeHit then
                        if self.callback then
                            self.callback()
                        end
                        PeakHitUi.Destroy()
                    else
                        self:SetAniIndex(value - 1)
                    end
                else
                    self:SetAniIndex(value + 1)
                end
            end
        end
    end
end
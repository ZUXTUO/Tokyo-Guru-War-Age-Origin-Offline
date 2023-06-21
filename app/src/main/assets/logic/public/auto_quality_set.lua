AutoQualitySet = Class('AutoQualitySet')

--开始记录实时FPS的延迟时间
local gDelayEnaleTime = 5;
--多久记录一次的时间间隔  单位毫秒
local gCalFrameCountTime = 200;
--多久进行一次设置的时间间隔
local gCheckTime = 5;
--降级升级区分fps
local gAvgFps = 18;
--取几次条件不满足来降级
local gDownCount = 2;

function AutoQualitySet:Clear(id)
    --开始准备记录fps的时间
    self.startCalFrameCountTime = 0;
    --记录的总fps，以及数量    用做计算平均fps
    self.totalFps = 0;
    self.calCount = 0;
    --上次设置画质的时间
    self.lastCheck = 0;
    --当前特效多少、以及特效品质
    if g_dataCenter.setting then
        self.curQuality = g_dataCenter.setting:GetRenshuValueSystem(id);
        self.curQualityIndex = g_dataCenter.setting:GetQualitySettingIndexSystem(id);
        --标识是否已经开始降级不在提升
        self.bDowning = g_dataCenter.setting:GetAutoQualityDowning(id);
    else
        self.curQuality = 3;
        self.curQualityIndex = 2;
        self.bDowning = false;
    end
    --关卡逻辑需要每个关卡重新计算
    if id == MsgEnum.eactivity_time.eActivityTime_Adventure then
        self.bDowning = false;
    end
    --开关接口
    self.enable = false;
    --设置开启检测的开始时间
    self.startEnableTime = 0;
    --当前降级个数
    self.downCount = 0;
    --当前玩法id
    self.systemId = id or 0;
end


function AutoQualitySet:Init()
    self:Clear();

    Root.AddUpdate(AutoQualitySet.Update, self);

end

function AutoQualitySet:SetEnable(enable, id, notSend)
    app.log("AutoQualitySet:SetEnable "..tostring(enable).." "..tostring(id).." "..tostring(notSend));
    --手动设置过将不在自动设置
    if g_dataCenter.setting:GetManualSet() then
        return;
    end
    if notSend == nil then
        notSend = true;
    end
    self:Clear(id);

    if enable then
        self.startEnableTime = os.clock();
        self:UpdateProperty(notSend);
    end
end

function AutoQualitySet:UpdateProperty(notSend)
    local avgfps = 0;
    if self.calCount ~= 0 then
        avgfps = self.totalFps / self.calCount;
    end
    local tempInfo = {notSend=notSend, 
    avg_fps=avgfps, 
    totalFps = self.totalFps,
    calCount = self.calCount,
    curQuality=self.curQuality, 
    curQualityIndex=self.curQualityIndex,
    systemId = self.systemId,
    }
    -- app.log("AutoQualitySet:UpdateProperty "..table.tostring(tempInfo)..debug.traceback());
    g_dataCenter.setting:SetRenshuValueSystem(self.systemId, self.curQuality);
    g_dataCenter.setting:SetQualitySettingIndexSystem(self.systemId, self.curQualityIndex);
    g_dataCenter.setting:SetHuazhiValue(self.curQuality, false);
    g_dataCenter.setting:SetQualitySettingIndex(self.curQualityIndex);
    g_dataCenter.setting:Update();
    if not notSend then
        local info = {}
        local str_device_model = util.get_devicemodel();
        str_device_model = string.gsub(str_device_model, " ","_");
        info.device_model = str_device_model;
        info.device_unique_identifier = util.get_deviceuniqueidentifier();
        info.avg_fps = avgfps;
        info.effect_level = self.curQuality;
        info.system_id = self.systemId
        msg_client_log.cg_record_auto_set_effect(info);
    end
end



function AutoQualitySet:Update()
    if g_dataCenter.setting:GetManualSet() then
        return;
    end
    local curTime = os.clock();
    --延迟开放检测
    if self.startEnableTime ~= 0 and curTime - self.startEnableTime > gDelayEnaleTime then
        self.startEnableTime = 0;
        self.enable = true;
        self.startCalFrameCountTime = curTime;
        self.lastCheck = curTime;
    end
    if not self.enable then
        return;
    end
    --定时取fps
    if (curTime - self.startCalFrameCountTime)*1000 >= gCalFrameCountTime then
        self.startCalFrameCountTime = curTime;
        local fps = app.get_frame_count();
        self.totalFps = self.totalFps + fps;
        self.calCount = self.calCount + 1;
    end
    --取平均值做检测逻辑
    if curTime - self.lastCheck > gCheckTime then
        self.lastCheck = curTime;
        local avgfps = self.totalFps / self.calCount;
        if avgfps > gAvgFps then
            --未下降   等级不等于最高   就执行等级上升逻辑
            if not self.bDowning and self.curQuality ~= 3 then
                self.curQuality = self.curQuality + 1;
                self.curQualityIndex = self.curQualityIndex + 1;
                self:UpdateProperty();
            end
        else
            self.downCount = self.downCount + 1;
            if self.downCount >= gDownCount then
                self.downCount = 0;
                self.bDowning = true;
                g_dataCenter.setting:SetAutoQualityDowning(self.systemId, self.bDowning);
                if self.curQuality ~= 1 then
                    self.curQuality = self.curQuality - 1;
                    self.curQualityIndex = self.curQualityIndex - 1;
                    self:UpdateProperty();
                end
            end
        end
        self.totalFps = 0;
        self.calCount = 0;
    end
end

function AutoQualitySet:RecvServerAutoEffect(lv)
    if type(lv) ~= "table" then
        app.log("服务器获取初始自动设置特效等级错误 "..tostring(lv))
        return;
    end
    --临时特殊处理  因为在进游戏之前如果降了的话   进游戏后就不能升高了
    self.bDowning = false;
    for k, v in pairs(lv) do
        g_dataCenter.setting:SetRenshuValueSystem(v.system_id, v.effect_level);
        g_dataCenter.setting:SetQualitySettingIndexSystem(v.system_id, v.effect_level-1);
        g_dataCenter.setting:SetAutoQualityDowning(v.system_id, self.bDowning);
    end
    self:UpdateProperty(true)
end
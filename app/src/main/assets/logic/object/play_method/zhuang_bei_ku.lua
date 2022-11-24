ZhuangBeiKu = Class("ZhuangBeiKu",PlayMethodBase)

function ZhuangBeiKu:ClearData(data)
	self._super.ClearData(self,data);
--@@^^$$ 	-- local cfg = g_get_activity_time(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu).number_restriction;
	-- local cfg = ConfigManager.Get(EConfigIndex.t_activity_time,MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu).number_restriction;
	local cfg = ConfigManager.Get(EConfigIndex.t_activity_time, MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu).number_restriction;

	self.MaxNumber = cfg.d or 5;
	self.finishNumber = 0;
end

function ZhuangBeiKu:GetNumber()
	local number = g_dataCenter.player:GetFlagHelper():GetStringFlag(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu);
	number = number or "d=0";
	self.finishNumber = PublicFunc.GetActivityCont(number,"d") or 0;

    -- 玩法限制作弊 (英雄历练 -- 最大开启次数)
    if g_dataCenter.gmCheat:noPlayLimit() then
        return self.MaxNumber, self.MaxNumber;
    end

	return self.MaxNumber-self.finishNumber, self.MaxNumber;
end

function ZhuangBeiKu:IsOpen()
--@@^^$$ 	return g_get_play_vs_data(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu).open_level < g_dataCenter.player.level
	return ConfigManager.Get(EConfigIndex.t_play_vs_data,MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu).open_level < g_dataCenter.player.level
		and (self:GetNumber() ~= 0);
end

TongLinZhiHunDuiHuan = Class("TongLinZhiHunDuiHuan",PlayMethodBase)

function TongLinZhiHunDuiHuan:TongLinZhiHunDuiHuan(data)
	--最大可兑换通灵之魂数量
	self.maxChangeCount = 0;
end

function TongLinZhiHunDuiHuan:IsHaveData()
	return self.finishNumer ~= nil;
end

function TongLinZhiHunDuiHuan:SetData(data)
	self._super.SetData(self, data);
	self.maxChangeCount = tonumber(PublicFunc.GetActivityCont(self.finishNumer, "d")) or 0;
end
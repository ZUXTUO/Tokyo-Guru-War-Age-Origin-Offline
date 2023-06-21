BatchBuyAction = Class("BatchBuyAction", PackageBatchAction);

local _UIText = {
	["str_title"] = "批量",
	["str_buy"] = "购买",
}

local Instance = nil;

-------------------------- 外部接口 --------------------------
function BatchBuyAction.ShowAction(data)
	if Instance == nil then
		Instance = BatchBuyAction:new(data)
	else
		Instance:SetData(data)
	end
	
	if nil == Instance.info then
		app.log("BatchBuyAction.ShowAction:data error")
		Instance:OnBtnCloseClicked()
		return
	end

	if Instance.ui ~=nil then
		Instance:UpdateUi()		
		Instance:Show()
	end
end

function BatchBuyAction:SetData(data)
	self.info = data.info 
	self.current_number = 1
	self.max_number = data.max_number
	self.callback = data.callback
end

function BatchBuyAction:UpdateActionTypeUi()
	self.nodeSaleCont:set_active(false)
	self.nodeUseCont:set_active(true)
	self.lbl_title:set_text(_UIText["str_title"])
	self.lbl_title2:set_text(_UIText["str_buy"])
	self.lbl_btn_action:set_text(_UIText["str_buy"])
end

function BatchBuyAction:OnBtnActionClicked(t)
	Utility.CallFunc(self.callback, self.info, self.current_number);
	self:Hide()
end

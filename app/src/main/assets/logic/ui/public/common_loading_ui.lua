CommonLoadingUI = Class("CommonLoadingUI", UiBaseClass);

function CommonLoadingUI:BeginLoading(data)
end

function CommonLoadingUI:UpdatePercent(playerid, percent)
end

function CommonLoadingUI:End()
	self:DestroyUi();
end
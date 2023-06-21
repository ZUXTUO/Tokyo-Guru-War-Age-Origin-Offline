CommonBuy = {}
---------------------------------外部接口-------------------------------------
--curTimes 当前次数
--maxTimes 最大次数
--costCrystal 花费钻石
--goodCount 获得物品数量
--goodStr 获得物品的名字
--limitStr 达到上限的字符串
--sureCallBack 确认购买的回调
function CommonBuy.Show(curTimes, maxTimes, costCrystal, goodCount, goodStr, limitStr, sureCallBack)
	if curTimes < maxTimes then
		CommonBuy.costCrystal = costCrystal;
		CommonBuy.sureCallBack = sureCallBack;

		local btn1 = {str = gs_misc['str_44'], func=CommonBuy.OnSureBuy};
		local btn2 = {str = gs_misc['str_45']};
		local str1 = string.format(gs_misc['str_38'], costCrystal, goodCount, goodStr);
		local str2 = string.format(gs_misc['str_39'], curTimes, maxTimes);
		HintUI.SetTwoAndShow(EHintUiType.two, str1, str2, btn1, btn2);
	else
		local btn1 = {str = gs_misc['str_44']};
		HintUI.SetAndShow(EHintUiType.one, limitStr, btn1);
	end
end
---------------------------------内部接口--------------------------------------
function CommonBuy.OnSureBuy()
	local curPlayer = g_dataCenter.player;
	if curPlayer.crystal < CommonBuy.costCrystal then
		local btn1 = {str = gs_misc['str_44'], func=CommonBuy.OnGoShop};
		local btn2 = {str = gs_misc['str_45']};
		HintUI.SetAndShow(EHintUiType.one, gs_misc['str_41'], btn1, btn2);
	else
		Utility.CallFunc(CommonBuy.sureCallBack);
	end
end

function CommonBuy.OnGoShop()
	uiManager:PushUi(EUI.StoreUI);
end
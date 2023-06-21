CommonClearing = {}

--------------------外部接口-------------------------
ECommonEnd = 
{
	eCommonEnd_battle = 1,
	eCommonEnd_star = 2,
	eCommonEnd_addexp = 3,
	eCommonEnd_awards = 4,
	eCommonEnd_jump = 5,
}
--data 闯关结构
--{
--	battle = {}			内容参见common_battle.lua 对战界面 不要可以不传
--	star = {},			内容参见common_star.lua 弹星界面 不要可以不传
--	addexp = {}			内容参见common_add_exp.lua 加经验界面 不要可以不传
--	awards = {}			内容参见common_award.lua 获得物品界面 不要可以不传
--	jump = {}			内容参见common_leave.lua 失败的跳转功能  不要可以不传
--}
function CommonClearing.Start(data)
	if not CommonClearing.runing then
		CommonClearing.runing = true;
		CommonClearing.Init(data);
		CommonClearing.UpdateUi();
	end
end

function CommonClearing.SetFinishCallback(callback, obj)
	CommonClearing.callbackFunc = callback;
	if CommonClearing.callbackFunc then
		CommonClearing.callbackObj = obj;
	end
end

--------------------内部接口-------------------------
function CommonClearing.Init(data)
	--外部数据相关
	CommonClearing.data = data;
	--内部变量
	CommonClearing.runed = {};
end

function CommonClearing.UpdateUi()
	local data = CommonClearing.data;
	if data then
		--对战界面
		if type(data.battle) == "table" and CommonClearing.runed[1] == nil then
			-- app.log('============  data.battle.players:'..table.tostring(data.battle.players))
			CommonBattle.Start(data.battle.battleName, data.battle.players, data.battle.fightResult);
			CommonBattle.SetFinishCallback(CommonClearing.FinishCallback, 1);
			return;
		else
			CommonClearing.runed[1] = 1;
		end
		--弹星界面
		local isDestroy = not (type(data.addexp) == "table");
		if type(data.star) == "table" and type(data.addexp) == "table" and CommonClearing.runed[2] == nil then
			CommonStar.Start(data.star.star, data.star.finishConditionInfex, data.star.conditionDes, data.addexp.cards, data.addexp.awards, data.addexp.extraAwards)
			CommonStar.SetFinishCallback(CommonClearing.FinishCallback, 2);
			--AudioManager.PlayUiAudio(81010000)
			return;
		else
			CommonClearing.runed[2] = 1;
		end
		-- --加经验界面
		-- if type(data.addexp) == "table" and CommonClearing.runed[3] == nil then
		-- 	CommonAddExp.Start(data.addexp.player, data.addexp.cards, data.addexp.awards, data.addexp.showBk, data.addexp.extraAwards);
		-- 	CommonAddExp.SetFinishCallback(CommonClearing.FinishCallback, 3);
		-- 	return;
		-- else
		-- 	CommonClearing.runed[3] = 1;
		-- end
		--奖励界面
		if type(data.awards) == "table" and CommonClearing.runed[4] == nil then
			CommonAward.Start(data.awards.awardsList, data.awards.tType, data.awards.btnDeploy, data.awards.btnShare);
			CommonAward.SetFinishCallback(CommonClearing.FinishCallback, 4);
			return;
		else
			CommonClearing.runed[4] = 1;
		end
		--获得英雄
		if type(data.gethero) == "table" and CommonClearing.runed[5] == nil then
			local cardInfo = CardHuman:new({number = data.gethero.number, level=1});
			EggGetHero.Start(cardInfo, true, nil, true);
			EggGetHero.SetFinishCallback(CommonClearing.FinishCallback, 5);
			return;
		else
			CommonClearing.runed[5] = 1;
		end
		--失败跳转界面
		if type(data.jump) == "table" and CommonClearing.runed[6] == nil then
			CommonLeave.Start(data.jump.jumpFunctionList, data.jump.isRelive);
			CommonLeave.SetFinishCallback(CommonClearing.FinishCallback, 6);
			--AudioManager.PlayUiAudio(81010001)
			return;
		else
			CommonClearing.runed[6] = 1;
		end
		CommonClearing.FinishCallback(6);
	end
end

function CommonClearing.FinishCallback(index)
	CommonClearing.runed[index] = 1;
	-- 由于弹星界面 和 加经验公用一个底 所以需要外部删除
	if index == 3 then
		CommonStar.Destroy();
	end
	--全部结束
	if #CommonClearing.runed >= 6 then
		CommonClearing.OnClose();
	else
		CommonClearing.UpdateUi();
	end
end

function CommonClearing.OnClose(t)
	--特殊情况先回调 因为这可能牵扯到衔接动画
	local oldCallback = CommonClearing.callbackFunc;
	local oldCallObj = CommonClearing.callbackObj;
	if CommonClearing.callbackFunc then
		if type(CommonClearing.data.jump) ~= "table" then
			-- 如果不是失败跳转界面，就触发
			ObjectManager.SnapshootForeachObj(function (objname,obj)
				obj:OnFinishClearingTrigger()
				end)
		end
		if ScreenPlay.IsRun() then
	    	ScreenPlay.SetCallback(function ()
	    		oldCallback(oldCallObj);
	    	end);
	    else	
			oldCallback(oldCallObj);
	    end
	end
	if oldCallback == CommonClearing.callbackFunc and oldCallObj == CommonClearing.callbackObj then
		CommonClearing.callbackFunc = nil;
		CommonClearing.callbackObj = nil;
	end
	--内部变量
	CommonClearing.runed = nil;
	CommonClearing.runing = nil;
end

function CommonClearing.OnUiLoadFinish(tType)
	if CommonClearing.runing then
		-- if CameraManager.GetSceneCameraObj() then
		-- 	CameraManager.GetSceneCameraObj():set_active(false);
		-- end
	end
end

function CommonClearing.CanClose()
	CommonClearing.canClose = true;
	CommonClearing.reciCanCloseTime = app.get_time()
	PublicFunc.msg_dispatch(CommonClearing.CanClose);
end
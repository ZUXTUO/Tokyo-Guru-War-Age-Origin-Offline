--[[安卓按键监控]]

BackKey = {};

function BackKey.Init() 
    BackKey.updateTimer = nil;
    BackKey.resetData();
    -- 启动update
    BackKey.startUpdate();
end

function BackKey.resetData()
    BackKey.readyToExit = false;
    BackKey.clickCount = 0;
end

function BackKey.startTimer()
   if BackKey.updateTimer == nil then 
        BackKey.updateTimer = timer.create("BackKey.checkClickTwice", 1 * 1000 , 1);
   end
end

function BackKey.stopTimer()
   if BackKey.updateTimer ~= nil then 
        timer.stop(BackKey.updateTimer);
        BackKey.updateTimer = nil;
   end
end

--[[是否点击返回键两次]]
function BackKey.checkClickTwice()
    BackKey.stopTimer();
    if BackKey.clickCount >= 2 then
        --[[先看SDK有没有退出界面]]
        if not user_center.sdk_exit() then
	        BackKey.stopUpdate();
	        BackKey.resetData();
	        BackKey.showUI();
        end
	    BackKey.resetData();
    else 
        BackKey.resetData();
    end
end

function BackKey.showUI()
    SystemHintUI.SetAndShowNew(ESystemHintUIType.two, '提示', '您确认要退出游戏吗? ', 
        {str = "", func = BackKey.exitNo}, {str = "是", func = BackKey.exitYes}, {str = "否", func = BackKey.exitNo});
    -- 隐藏新手引导
    -- if GuideManager ~= nil then
    --     GuideManager.SetHideMode(true)
    -- end
end

--[[退出游戏]]
function BackKey.exitYes()
    util.quit();
end

--[[恢复]]
function BackKey.exitNo()
    BackKey.startUpdate();
    -- 显示新手引导
    -- if GuideManager ~= nil then
    --     GuideManager.SetHideMode(false)
    -- end
end

--[检测用户是否点击back键]]
function BackKey.update(t)
    local yes = util.click_back_key();
    if yes == true then
        BackKey.clickCount = BackKey.clickCount + 1;
    end
    if BackKey.readyToExit == false and BackKey.clickCount >= 1 then 
        BackKey.readyToExit = true;
        BackKey:startTimer();
    end
end

function BackKey:startUpdate()
    Root.AddUpdate(BackKey.update, BackKey);
end

function BackKey:stopUpdate()
    Root.DelUpdate(BackKey.update, BackKey);
end
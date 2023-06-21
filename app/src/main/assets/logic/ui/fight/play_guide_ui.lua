PlayGuideUI = Class("PlayGuideUI", UiBaseClass);


local uiText = 
{
	[1] = "点击屏幕任意位置关闭"
}

local instance = nil;

local CheckFunc = {};
-- 强制显示
CheckFunc[1] = function(type, param)
	return true;
end
-- 少于进入次数显示，param=次数
CheckFunc[2] = function(type, param)
	local count = g_dataCenter.playMethodInfo:GetCount(type);
	-- app.log("PlayGuideUI CheckFunc count:"..count.." param:"..param);
	if count <= param then
		return true;
	else
		return false;
	end
end
-- 少于天数显示，param=天数
CheckFunc[3] = function(type, param)
	local day = g_dataCenter.PlayMethodInfo:GetOpenDay(type);
	-- app.log("PlayGuideUI CheckFunc day:"..day.." param:"..param);
	if day <= param then
		return true;
	else
		return false;
	end
end

function PlayGuideUI.ShowUI(callback)
	if instance then
		instance:SetCallback(callback);
		instance:Show();
		return true;
	end
	return false;
end

function PlayGuideUI.SetParam(res)
	if not instance then
		instance = PlayGuideUI:new();
		instance:Hide();
	end
	instance:SetData(res);
end

function PlayGuideUI.Destroy()
	if instance then
		instance:DestroyUi();
		instance = nil;
	end
end

function PlayGuideUI.CheckPlay(cfg, fight_type)
	local func = CheckFunc[cfg.type];
	return func(fight_type, cfg.param);
end

function PlayGuideUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/playing_introduce/ui_5001_bg.assetbundle";
    self.delayClick = 0.5;
    local cfg = ConfigManager.Get(EConfigIndex.t_discrete,83000197);
    if cfg then
    	self.delayClick = cfg.data;
    end
    UiBaseClass.Init(self, data);
end

function PlayGuideUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
    self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded);
end

function PlayGuideUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("PlayGuideUI");

    self.tex = ngui.find_texture(self.ui,"centre_other/texture");
    if self.guideRes then
    	self.tex:set_texture(self.guideRes);
    end
	self.tipCloseLabel = ngui.find_label(self.ui, "txt")
	self.tipCloseLabel:set_text(uiText[1])
    local btn = ngui.find_button(self.ui,"sp_mark");
	btn:set_on_click(self.bindfunc["on_click"]);
end

function PlayGuideUI:on_click()
	if self.timerId and self.timerId > app.get_real_time() - self.delayClick then
		return;
	end
	if self.clickCallback then
		Utility.CallFunc(self.clickCallback);
	end
	PublicFunc.UnityResume();
	PlayGuideUI.Destroy();
end

-- function PlayGuideUI:on_loaded(pid, filepath, asset_obj, error_info)
-- 	if self.guideRes == filepath then
--         self.guideObj = asset_game_object.create(asset_obj);
--         self.guideObj:set_parent(self.bindNode);
--         self.guideObj:set_position(0,0,0);
--         self.guideObj:set_local_scale(1,1,1);
--         if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
--         	PublicFunc.UnityPause()
--         end
-- 	end
-- end

function PlayGuideUI:Show()
	if self.guideRes then
		UiBaseClass.Show(self);
        if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync then
        	PublicFunc.UnityPause()
        	self.timerId = app.get_real_time();
        end
	end
end

function PlayGuideUI:SetData(res)
	self.guideRes = res
	if self.ui then
		self.tex:set_texture(res);
	end
end

function PlayGuideUI:SetCallback(callback)
	self.clickCallback = callback;
end

FightStartUI = Class("FightStartUI", UiBaseClass);

local instance = nil;
local res = "assetbundles/prefabs/ui/level/panel_start_fight.assetbundle";

-- data = {
-- need_pause = 是否需要暂停游戏    
--}
function FightStartUI.Show(data)
	if instance == nil then
        data = data or {};
        if data.need_pause then
            PublicFunc.UnityPause()
        end
		instance = FightStartUI:new();
        instance.needPause = data.need_pause;
	end
end

function FightStartUI.SetEndCallback(func, param)
	if instance then
		instance:SetCallback(func,param);
	end
end

function FightStartUI.EndCallback()
   if instance then
       instance:DestroyUi();
       instance = nil;

       NoticeManager.Notice(ENUM.NoticeType.FightStartEnd)
   end
end

function FightStartUI.GetResList()
    return {res};
end

function FightStartUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function FightStartUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function FightStartUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function FightStartUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("panel_start_fight");

    -- self.lab = ngui.find_label(self.ui,"centre_other/animation/lab");
    -- self.labTitle = ngui.find_label(self.ui,"centre_other/animation/sp_di/lab");
    self:UpdateUi();
end

function FightStartUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.FightCountDown);

    -- local hurdle = ConfigHelper.GetHurdleConfig(FightScene.GetLevelID());
    -- local str = hurdle.tips_string;
    -- if str ~= 0 then
    --     self.lab:set_text(str);
    -- end
    -- if FightScene.GetPlayMethodType() == nil then
    --     self.labTitle:set_text(tostring(hurdle.index).." "..tostring(hurdle.name));
    -- else
    --     self.labTitle:set_text("");
    -- end
end

function FightStartUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function FightStartUI:DestroyUi()
    if self.needPause then
        PublicFunc.UnityResume();
    end
    if self.funcCallback then
    	Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end

    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.Single then
        local frame_info = {}
        frame_info.type = ENUM.FightKeyFrameType.TimerStart
        frame_info.integer_params = {}
        frame_info.string_params = {}
        frame_info.float_params = {}
        FightKeyFrameInfo.AddKeyInfo(frame_info)
    end

    UiBaseClass.DestroyUi(self);
end
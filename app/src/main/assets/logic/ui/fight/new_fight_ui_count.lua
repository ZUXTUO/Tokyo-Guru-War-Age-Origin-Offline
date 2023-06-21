NewFightUiCount = Class('NewFightUiCount', UiBaseClass);

local res = "assetbundles/prefabs/ui/fight/new_fight_ui_count_down.assetbundle";

function NewFightUiCount.GetResList()
    return {res}
end

function NewFightUiCount.Start(data)
    if NewFightUiCount.Instance == nil then
        data = data or {};
        if data.need_pause == nil or data.need_pause then
            PublicFunc.UnityPause()
        end
        NewFightUiCount.Instance = NewFightUiCount:new();
        NewFightUiCount.Instance.needPause = data.need_pause;
    end
end

function NewFightUiCount.Destroy()
    if NewFightUiCount.Instance then
        NewFightUiCount.Instance:DestroyUi();
        if NewFightUiCount.Instance.needPause == nil or NewFightUiCount.Instance.needPause then
            PublicFunc.UnityResume();
        end
        NewFightUiCount.Instance = nil;
    end
end

function NewFightUiCount.OnEnd()
    NewFightUiCount.Destroy()
end

--初始化
function NewFightUiCount:Init()
    self.pathRes = res;
    UiBaseClass.Init(self);
end

--初始化UI
function NewFightUiCount:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("new_fight_ui_count_down");
end

function NewFightUiCount:DestroyUi()
    if self.ui then
        self.ui:set_active(false);
        self.ui = nil;
    end
    UiBaseClass.DestroyUi(self);
end




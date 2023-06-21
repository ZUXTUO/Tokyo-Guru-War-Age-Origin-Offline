HurdlePassTip = Class("HurdlePassTip", UiBaseClass);
local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_jxtz_monster.assetbundle"

function HurdlePassTip.GetResList()
    return {res}
end

local instance = nil;
function HurdlePassTip.Start(param)
    if not instance then
        instance = HurdlePassTip:new();
    else
        instance:Hide();
    end
    instance:Show(param);
end

function HurdlePassTip.SetEndCallback(func, param)
    if instance then
        instance:SetCallback(func,param);
    end
end

function HurdlePassTip.EndCallback()
    if instance then
        instance:DestroyUi();
        instance = nil;
    end
end

function HurdlePassTip:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function HurdlePassTip:InitData(data)
    UiBaseClass.InitData(self, data);
end

function HurdlePassTip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("HurdlePassTip");

    self.lab = {};
    for i=1,3 do
        self.lab[i] = ngui.find_label(self.ui,"animation/cont/lab"..i);
    end

    self:UpdateUi();
end

function HurdlePassTip:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    if self.strInfo then
        for i=1,3 do
            self.lab[i]:set_text(tostring(self.strInfo[i] or ""));
        end
    end
end

function HurdlePassTip:Show(param)
    self.strInfo = param.des;
    if UiBaseClass.Show(self) then
        self:UpdateUi();
    end
end

function HurdlePassTip:SetCallback(func, param)
    self.funcCallback = func;
    self.funcCallbackParam = param;
end

function HurdlePassTip:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.funcCallback then
        Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
    end
end
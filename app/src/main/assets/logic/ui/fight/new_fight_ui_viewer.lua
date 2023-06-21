NewFightUiViewer = Class("NewFightUiViewer", UiBaseClass);

function NewFightUiViewer:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_viewer.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiViewer:InitData(data)
    UiBaseClass.InitData(self, data);
    self.parent = data.parent;
end

function NewFightUiViewer:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("new_fight_ui_viewer");
    if self.parent then
        self.ui:set_parent(self.parent);
    end
    local lab2 = ngui.find_label(self.ui,"lab2");
    lab2:set_active(false);

    self:UpdateUi();
end

function NewFightUiViewer:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
end

function NewFightUiViewer:DestroyUi()
    UiBaseClass.DestroyUi(self);
end 
UiLevelNewGroup = Class('UiLevelNewGroup', UiBaseClass);


local resPaths = 'assetbundles/prefabs/ui/level/ui_709_level.assetbundle';
function UiLevelNewGroup.Start(data)
    if UiLevelNewGroup.cls == nil then
        UiLevelNewGroup.cls = UiLevelNewGroup:new(data);
    end
end

function UiLevelNewGroup.Destroy()
   if UiLevelNewGroup.cls then
        UiLevelNewGroup.cls:DestroyUi();
        UiLevelNewGroup.cls = nil;
    end 

    if GuideManager then
        GuideManager.CheckConditionFunc("condition_passed_section_ani")
    end
end

function UiLevelNewGroup.IsPlaying()
    return UiLevelNewGroup.cls ~= nil
end

function UiLevelNewGroup:Init(data)
    self.pathRes = resPaths
    UiBaseClass.Init(self, data);
end

function UiLevelNewGroup:InitData(data)
    UiBaseClass.InitData(self, data);
    self.groupid = data;
end

function UiLevelNewGroup:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.labContent = ngui.find_label(self.ui, "sp_bk/lab")    

    self:UpdateUi();
end

function UiLevelNewGroup:UpdateUi()
    local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, self.groupid);
    if not cf then
        return;
    end
    AudioManager.PlayUiAudio(81200116)
    self.labContent:set_text(tostring(cf.chapter_num).." "..tostring(cf.chapter));
end

function UiLevelNewGroup:DestroyUi()
    if self.ui then
        self.ui:set_active(false);
        self.ui = nil;
    end
end

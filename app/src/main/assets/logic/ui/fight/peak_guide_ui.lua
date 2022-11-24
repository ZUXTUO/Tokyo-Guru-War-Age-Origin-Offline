PeakGuideUi = Class('PeakGuideUi', UiBaseClass);

local res = "assetbundles/prefabs/ui/new_fight/panel_peakedness.assetbundle";

function PeakGuideUi.GetResList()
    return {res}
end

function PeakGuideUi.Start(data)
    if PeakGuideUi.Instance == nil then
        PeakGuideUi.Instance = PeakGuideUi:new()
    end
    PeakGuideUi.Instance:SetData(data)
end

function PeakGuideUi.Destroy()
    if PeakGuideUi.Instance then
        PeakGuideUi.Instance:DestroyUi()
        PeakGuideUi.Instance = nil
    end
end

function PeakGuideUi:SetData(data)
    if data then
        self.callback = data.callback
    end
end

--初始化
function PeakGuideUi:Init()
    self.pathRes = res
    self.enableClick = false

    UiBaseClass.Init(self)
end

function PeakGuideUi:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['on_click_exit'] = Utility.bind_callback(self, self.on_click_exit)
end

function PeakGuideUi:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--初始化UI
function PeakGuideUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("peak_guide_ui")

    local btnMask = ngui.find_button(self.ui, "sp_mark")
    btnMask:set_on_click(self.bindfunc["on_click_exit"],"MyButton.NoneAudio")
    -- local lab = ngui.find_label(self.ui, "centre_other/animation/lab")
    -- lab:set_active(false)

    local func = function()
        self.enableClick = true
        -- lab:set_active(true)
    end

    TimerManager.Add(func, 1000, 1)
end

function PeakGuideUi:on_click_exit()
    if self.enableClick then
        if self.callback then
            self.callback()
        end
        PeakGuideUi.Destroy()
    end
end


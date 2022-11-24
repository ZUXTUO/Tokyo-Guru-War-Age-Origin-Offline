
MainUIProgressBar = Class('MainUIProgressBar', UiBaseClass)

local res = "assetbundles/prefabs/ui/wanfa/baoxiang/panel_open_box.assetbundle"

function MainUIProgressBar.GetResList()
    return {res}
end

function MainUIProgressBar:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUIProgressBar:ResetData()
    self.isProgressing = false
end

function MainUIProgressBar:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name('MainUIProgressBar')

    local btn = ngui.find_button(self.ui, 'btn')
    btn:set_active(false)

	self.buttonEnableFx = self.ui:get_child_by_name('fx_ui_panel_open_box_jiguan')
    self.buttonEnableFx:set_active(false)

    self.progressBar = ngui.find_progress_bar(self.ui, "background")
    self.progressBarLab = ngui.find_label(self.ui, 'background/lab')
    
    self:Hide()

    local node = self.ui:get_child_by_name('sp_box')
    if node then
        node:set_active(false)
    end
end

function MainUIProgressBar:ProgressBarShowProgress(str, totalTime, callback)
    if self.ui == nil or self.isProgressing == true then
        return
    end

    self:Show()
    -- if str == nil or str == '' then
    --     self.progressBarLab:set_active(false)
    -- else
    --     self.progressBarLab:set_active(true)

    --     self.progressBarLab:set_text(tostring(str))
    -- end

    self.isProgressing = true
    self.progressBeginTime = app.get_time()
    self.progressBarProg = 0
    self.progressBar:set_value(self.progressBarProg)
    self.totalTime = totalTime
    self.finishCallback = callback
end

function MainUIProgressBar:ProgressBarCanelProgress()
    if self.ui == nil or self.isProgressing == false then
        return
    end

    self.isProgressing = false
    self:Hide();
end

function MainUIProgressBar:Update(dt)
    if self.isProgressing == true then
        local psssTime = app.get_time() - self.progressBeginTime

        local prog = psssTime / self.totalTime
        if prog > 1 then
            prog = 1
        end
        if prog ~= self.progressBarProg then
            self.progressBarProg = prog
            self.progressBar:set_value(prog)
        end

        if prog == 1 then
            self.isProgressing = false
            self:Hide();

            Utility.call_func(self.finishCallback)
        end
    end
end

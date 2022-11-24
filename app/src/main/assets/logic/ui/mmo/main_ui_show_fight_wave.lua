
MainUIShowFightWave = Class('MainUIShowFightWave', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/ui_805_fight.assetbundle"

local _uiText = 
{
    [1] = '第%d波',
    [2] = '共%d波',
}

function MainUIShowFightWave.GetResList()
    return {res}
end

function MainUIShowFightWave:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUIShowFightWave:InitData(data)
    UiBaseClass.InitData(self, data);
    self.curWave = 0
    self.totalWave = 0
end

function MainUIShowFightWave:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.currentWaveLabel = ngui.find_label(self.ui, 'txt_score')
    self.totalWaveLabel = ngui.find_label(self.ui, 'lab_score')

    self:UpdateWave(self.curWave, self.totalWave)
end

function MainUIShowFightWave:UpdateWave(cur, total)

    if self.ui then
        self.currentWaveLabel:set_text(string.format(_uiText[1] , cur))
        self.totalWaveLabel:set_text(string.format(_uiText[2] , total))
    else
        self.curWave = cur
        self.totalWave = total
    end
end
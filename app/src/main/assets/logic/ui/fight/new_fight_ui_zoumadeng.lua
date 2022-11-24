
NewFightUIZouMaDeng = Class('NewFightUIZouMaDeng', UiBaseClass)

local resPath = 'assetbundles/prefabs/ui/fight/new_fight_ui_zoumadeng.assetbundle'

-- test msg_chat.gc_marquee({ntype = 1, loopTimes = 1, interval = 0, content = '', vecParm = {'����1'}})

function NewFightUIZouMaDeng.GetResList()
    return {resPath}
end

function NewFightUIZouMaDeng:Init(data)
    self.pathRes = resPath;
    UiBaseClass.Init(self, data);
end

function NewFightUIZouMaDeng:InitData(data)
    UiBaseClass.InitData(self, data);
    self.showLock = false;
end


function NewFightUIZouMaDeng:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    --self.ui:set_local_scale(1, 1, 1)

    local data = {}
    data.justShowHasData = true
    data.label = ngui.find_label(self.ui, 'lab')
    local panel = ngui.find_panel(self.ui, 'panel')
    local x,y,z = panel:get_position()
    local panelw = 624
    data.startPos = x + math.floor(panelw/2)
    data.endPos = x - math.floor(panelw/2)
    --msg_chat.cg_marquee()
    self.data = data

    self:OnShow()
end

function NewFightUIZouMaDeng:DestroyUi()
    g_dataCenter.marquee:stop()
    UiBaseClass.DestroyUi(self)
end

function NewFightUIZouMaDeng:OnShow()
    if self.ui then
        g_dataCenter.marquee:initData(self.data)
        g_dataCenter.marquee:start()
    end
end
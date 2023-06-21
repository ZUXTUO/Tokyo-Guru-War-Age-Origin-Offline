
ChatFightRoundUI = Class("ChatFightRoundUI", UiBaseClass)

function ChatFightRoundUI.Start(round)
    if ChatFightRoundUI.cls == nil then
        ChatFightRoundUI.cls = ChatFightRoundUI:new({round = round})
    end
end

function ChatFightRoundUI.End()
    if ChatFightRoundUI.cls then
        ChatFightRoundUI.cls:DestroyUi()
        ChatFightRoundUI.cls = nil
    end
end

local res = "assetbundles/prefabs/ui/new_fight/panel_start_huihe.assetbundle";

function ChatFightRoundUI.GetResList()
    return {res}
end

function ChatFightRoundUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function ChatFightRoundUI:InitData(data)
    UiBaseClass.InitData(self, data)
end

function ChatFightRoundUI:Restart(data)
    self.round = data.round
    if UiBaseClass.Restart(self, data) then
    end
end

function ChatFightRoundUI:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function ChatFightRoundUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    local path = "centre_other/animation"

    local spFont = ngui.find_sprite(self.ui, path .. "/sp_art_font")
    local spName = "zd_huihe_" .. self.round
    spFont:set_sprite_name(spName)
end

function ChatFightRoundUI.OnOver()
    ChatFightRoundUI.End()
end
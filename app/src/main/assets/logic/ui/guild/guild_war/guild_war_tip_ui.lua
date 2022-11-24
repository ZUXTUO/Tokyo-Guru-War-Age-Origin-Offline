
GuildWarTipUI = Class('GuildWarTipUI', UiBaseClass)

--[[
    data = {
        isShowMask = xx
        str = xx
        closeTime = xx
    }
]]
function GuildWarTipUI.Start(data)
    if GuildWarTipUI.cls == nil then
        GuildWarTipUI.cls = GuildWarTipUI:new(data)
    end
end

function GuildWarTipUI.End()
    if GuildWarTipUI.cls then
        GuildWarTipUI.cls:DestroyUi()
        GuildWarTipUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

function GuildWarTipUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3810_guild_war.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarTipUI:InitData(data)
	UiBaseClass.InitData(self, data)    
    self.data = data
end

function GuildWarTipUI:DestroyUi()    
	UiBaseClass.DestroyUi(self)    
end

function GuildWarTipUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
    self.bindfunc['on_close'] = Utility.bind_callback(self, self.on_close)
end

function GuildWarTipUI:on_close()
    TimerManager.Remove(self.bindfunc["on_close"])
    GuildWarTipUI.End()
end

function GuildWarTipUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_tip")
    
    local spMask = ngui.find_sprite(self.ui, "sp_mark")
    spMask:set_active(self.data.isShowMask)
    local lblTxt = ngui.find_label(self.ui, "centre_other/animation/txt2")
    lblTxt:set_text(tostring(self.data.str))

    if self.data.closeTime ~= -1 then
        if not TimerManager.IsRunning(self.bindfunc["on_close"]) then
            TimerManager.Add(self.bindfunc["on_close"], self.data.closeTime  * 1000, 1)
        end
    end
end
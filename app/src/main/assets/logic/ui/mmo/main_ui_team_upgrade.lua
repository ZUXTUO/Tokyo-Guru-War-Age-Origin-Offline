
MainUITeamUpgrade = Class('MainUITeamUpgrade', UiBaseClass)

local resPath = 'assetbundles/prefabs/ui/new_fight/ui_4001_team_upgrade.assetbundle'

function MainUITeamUpgrade.GetResList()
    return {resPath}
end

function MainUITeamUpgrade:Init(data)
    self.pathRes = resPath

    UiBaseClass.Init(self, data);
end

function MainUITeamUpgrade:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnTeamUpgrade'] = Utility.bind_callback(self, self.OnTeamUpgrade);
end

function MainUITeamUpgrade:MsgRegist()
    PublicFunc.msg_regist('TeamUpgrade', self.bindfunc['OnTeamUpgrade'])
end

function MainUITeamUpgrade:MsgUnRegist()
    PublicFunc.msg_unregist('TeamUpgrade', self.bindfunc['OnTeamUpgrade'])
end

function MainUITeamUpgrade:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.tweenPosition = ngui.find_tween_scale(self.ui, 'center_other/annimation')
    self.tweenAlphaGo = self.tweenPosition:get_game_object()

    self.spdiTweenAlphaGo = self.ui:get_child_by_name('center_other/sp_di')

    local sp = ngui.find_sprite(self.ui, 'sp_effect')
    sp:set_active(false)

    self:Hide()
end

function MainUITeamUpgrade:OnTeamUpgrade(oldLevel, newLevel)
    
    if newLevel <= oldLevel then
        return
    end

    self.ui:set_active(true)
    local label = ngui.find_label(self.ui, 'cont1/lab_art_num')
    label:set_text(tostring(oldLevel))

    label = ngui.find_label(self.ui, 'cont1/lab_art_num1')
    label:set_text(tostring(newLevel))

    local str = string.format('+%d', newLevel - oldLevel)
    label = ngui.find_label(self.ui, 'cont2/lab_num')
    label:set_text(str)
    label = ngui.find_label(self.ui, 'cont2/lab_num1')
    label:set_text(str)

    self.tweenPosition:reset_to_begining()
    self.tweenPosition:play_foward()
    util.temp_tween_alpha_replay_forward(self.tweenAlphaGo)
    util.temp_tween_alpha_replay_forward(self.spdiTweenAlphaGo)

    self.showBeginTime = app.get_time()
end

function MainUITeamUpgrade:Update(dt)

    if self.showBeginTime and app.get_time() - self.showBeginTime >= 3 then
        self.ui:set_active(false)
        self.showBeginTime = nil
    end
end

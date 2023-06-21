
MainUITeamJustShow = Class('MainUITeamJustShow', UiBaseClass)


local res = "assetbundles/prefabs/ui/new_fight/left_top_other_zjm.assetbundle"

function MainUITeamJustShow:Init(data)
    self.pathRes = res

    UiBaseClass.Init(self, data);
end

function MainUITeamJustShow:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function MainUITeamJustShow:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.headIconSprite = {}
    for i = 1,3 do
        self.headIconSprite[i] = {}

        local parentPath = 'sp_head_di' .. i
        local btn = ngui.find_button(self.ui, parentPath)
        btn:set_on_click(self.bindfunc['OnClickTeamHead'])
        local node = btn:get_game_object()
        self.headIconSprite[i].node = node

        local sp = ngui.find_sprite(node, 'sp_human')
        self.headIconSprite[i].sp = sp
        self.headIconSprite[i].addSp = ngui.find_sprite(node, 'sp_add')
    end
    
    self:UpdateUi()
end

function MainUITeamJustShow:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnUpdateTeam'] = Utility.bind_callback(self, self.OnUpdateTeam)

    self.bindfunc['OnClickTeamHead'] = Utility.bind_callback(self, self.OnClickTeamHead)
end

function MainUITeamJustShow:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam'])
end

function MainUITeamJustShow:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['OnUpdateTeam'])

end

function MainUITeamJustShow:UpdateUi()

    if self.ui == nil then return end

    self:UpdateHeadData()
end

function MainUITeamJustShow:UpdateHeadData()
    local defTeam = g_dataCenter.player:GetDefTeam()
    for i = 1,3 do
        local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[i])
        if cardInfo then
            local his = self.headIconSprite[i]
            if his.addSp then
                his.addSp:set_active(false)
            end
            PublicFunc.Set120Icon(his.sp, cardInfo.small_icon);
        else
            local his = self.headIconSprite[i]
            if his.addSp then
                his.addSp:set_active(true)
            end
            his.sp:set_sprite_name('gq_touxiang0')
        end
    end
end

function MainUITeamJustShow:OnUpdateTeam(info, ret)
    if self.ui == nil then return end

    local teamid = info["teamid"];
    if tostring(teamid) == tostring(ENUM.ETeamType.normal) then
        self:UpdateHeadData()
    end
end

function MainUITeamJustShow:OnClickTeamHead()
    uiManager:PushUi(EUI.FormationUi2);
end
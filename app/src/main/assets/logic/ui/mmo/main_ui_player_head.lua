
--MainUIPlayerHead = Class('MainUIPlayerHead', UiBaseClass)

--local res = "assetbundles/prefabs/ui/new_fight/left_top_other_fight.assetbundle"

--local _UIText = {
--    [1] = '级'
--}

--function MainUIPlayerHead:Init(data)
--    self.pathRes = res

--    UiBaseClass.Init(self, data);
--end

--function MainUIPlayerHead:DestroyUi()
--    UiBaseClass.DestroyUi(self)

--    if self.headUiItem then
--        self.headUiItem:DestroyUi()
--        self.headUiItem = nil
--    end
--    -- if self.headTexture then
--    --     self.headTexture:Destroy()
--    -- end
--end

--function MainUIPlayerHead:InitUI(asset_obj)
--    UiBaseClass.InitUI(self, asset_obj)


--    self.allContentNode = ngui.find_sprite(self.ui, "sp_di")

--    self.playerNameLabel = ngui.find_label(self.ui, 'lab_name')
--    self.playerNameLabel:set_text(tostring(g_dataCenter.player.name))

--    self.vipNode = ngui.find_sprite(self.ui, 'sp_di/sp_vip')
--    --self.vipLabel = ngui.find_label(self.ui, 'sp_di/lab')
--    --self.vipBackSp = ngui.find_sprite(self.ui, 'sp_bk')
--    self.fightValueLabel = ngui.find_label(self.ui, 'txt_fight/lab_fight')
--    self.levelLabel = ngui.find_label(self.ui, 'lab_lv')


--    local btn = ngui.find_button(self.ui, 'sp_di')
--    btn:set_on_click(self.bindfunc['OnClickPlayerHead'])

--    local headParent = self.ui:get_child_by_name('sp_di/sp_head_di_item')
--    self.headUiItem = UiPlayerHead:new({parent = headParent, showBorder = false})
--    self.headUiItem:SetCallback(self.OnClickPlayerHead, self)
--    -- self.headTexture = ngui.find_texture(self.ui, 'texture_human')

--    self:UpdateUi()
--end

--function MainUIPlayerHead:UpdateUi()
--    if self.ui == nil then return end
--    if g_dataCenter.player.vip < 1 then
--        self.vipNode:set_active(false)
--        --self.vipBackSp:set_active(false)
--    else
--        self.vipNode:set_active(true)
--        self.vipNode:set_sprite_name("zjm_" .. g_dataCenter.player.vip)
--        --self.vipBackSp:set_active(true)
--        --self.vipLabel:set_text(tostring(g_dataCenter.player.vip))
--    end    

--    self.fightValueLabel:set_text(tostring(g_dataCenter.player:GetFightValue()))
--    self.levelLabel:set_text(tostring(g_dataCenter.player.level) .. _UIText[1])

--    self.playerNameLabel:set_text(tostring(g_dataCenter.player.name))

--    local roleid = nil
--    local cf = ConfigHelper.GetRole(g_dataCenter.player.image);
--    if cf then
--        roleid = g_dataCenter.player.image
--    else
--        local defTeam = g_dataCenter.player:GetDefTeam()
--        local cardInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, defTeam[1])
--        if cardInfo then
--		    roleid = cardInfo.number
--	    end 
--    end

--    -- local config = ConfigHelper.GetRole(roleid)
--    -- if config then
--    --     self.headTexture:set_texture(config.icon90);
--    -- end
--	self.headUiItem:SetRoleId(roleid)

--    self:ShowVerbosContent(GetMainUI():GetFirstHideVerboseMenu())
--end

--function MainUIPlayerHead:RegistFunc()
--    UiBaseClass.RegistFunc(self)

--    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
--    self.bindfunc['OnClickPlayerHead'] = Utility.bind_callback(self, self.OnClickPlayerHead);
--	self.bindfunc['OnPlayerHeadChange'] = Utility.bind_callback(self, self.OnPlayerHeadChange);
--end

--function MainUIPlayerHead:OnPlayerHeadChange()
--    self:UpdateUi()
--end 

--function MainUIPlayerHead:MsgRegist()
--    UiBaseClass.MsgRegist(self)

--    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_regist(player.gc_update_player_vip_info, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_regist(msg_team.gc_update_team_info, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_regist('PlayerFightValueChange', self.bindfunc['UpdateUi'])
--    PublicFunc.msg_regist(player.gc_change_player_image, self.bindfunc['OnPlayerHeadChange']);
--    PublicFunc.msg_regist(player.gc_change_name, self.bindfunc['UpdateUi']);	
--end

--function MainUIPlayerHead:MsgUnRegist()
--    UiBaseClass.MsgUnRegist(self)

--    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_unregist(player.gc_update_player_vip_info, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_unregist('PlayerFightValueChange', self.bindfunc['UpdateUi'])
--    PublicFunc.msg_unregist(player.gc_change_player_image, self.bindfunc['OnPlayerHeadChange']);
--    PublicFunc.msg_unregist(msg_team.gc_update_team_info, self.bindfunc['UpdateUi'])
--    PublicFunc.msg_unregist(msg_team.gc_change_name, self.bindfunc['UpdateUi'])
--end


--function MainUIPlayerHead:OnClickPlayerHead()
--    app.log('MainUIPlayerHead:OnClickPlayerHead')
--    uiManager:PushUi(EUI.UiSet);
--    --msg_clone_fight.cg_get_challenge_hero()
--    --msg_clone_fight.cg_get_team_info()

--    --uiManager:PushUi(EUI.GuildFindLsUI);
--    --uiManager:PushUi(EUI.InstituteUI);
--    --uiManager:PushUi(EUI.ChurchBotMain);

--    --ChurchBotLoad.Start()
--end

--function MainUIPlayerHead:OnShow()
--    self:ShowVerbosContent(GetMainUI():GetFirstHideVerboseMenu())
--end

--function MainUIPlayerHead:ShowVerbosContent(is)

--    if self.verbosIsShow == is then
--        return
--    end

--    self.verbosIsShow = is

--    self.allContentNode:set_active(self.verbosIsShow)
--end
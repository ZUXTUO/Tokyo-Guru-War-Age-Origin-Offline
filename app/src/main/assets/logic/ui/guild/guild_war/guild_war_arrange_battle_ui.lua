-- GuildWarArrangeBattleUI = Class("GuildWarArrangeBattleUI", ArrangeBattleUI);


-- function GuildWarArrangeBattleUI:InitData(data)
--     ArrangeBattleUI.InitData(self, data)
--     self.dc = g_dataCenter.guildWar
-- end

-- function GuildWarArrangeBattleUI:RegistFunc()
-- 	ArrangeBattleUI.RegistFunc(self)
-- 	self.bindfunc["on_guild_war_arrange_battle_ui_close"] = Utility.bind_callback(self, self.on_guild_war_arrange_battle_ui_close)
-- end

-- function GuildWarArrangeBattleUI:MsgRegist()
-- 	ArrangeBattleUI.MsgRegist(self)    
--     PublicFunc.msg_regist(msg_guild_war.gc_change_team_pos, self.bindfunc['on_guild_war_arrange_battle_ui_close'])
-- end

-- function GuildWarArrangeBattleUI:MsgUnRegist()
-- 	ArrangeBattleUI.MsgUnRegist(self)
--     PublicFunc.msg_unregist(msg_guild_war.gc_change_team_pos, self.bindfunc['on_guild_war_arrange_battle_ui_close'])
-- end

-- function GuildWarArrangeBattleUI:on_close()
--     local teamType = self.dc:GetEmbattleTeamType()
--     local currHeroPos = {}
--     if self.Team then
--         for pos, v in pairs(self.Team) do
--             if v[1] == 1 then
--                 currHeroPos[v[2]] = pos
--             end
--         end
--     end
--     local _heroIdPos = {}
--     local heros = self.dc:GetMyTeamInfoHerosById(teamType)
--     if heros ~= nil then
--         for k, v in ipairs(heros) do
--            table.insert(_heroIdPos, {dataid = v.dataid, pos = currHeroPos[k]})
--         end
--     end
--     --app.log(table.tostring(_heroIdPos))
--     if self.dc:IsTempAttackData(teamType) then
--         self.dc:SetTempMyAttackTeamInfo(_heroIdPos)
--         uiManager:PopUi()
--     else
--         msg_guild_war.cg_change_team_pos(teamType, _heroIdPos)
--     end
-- end

-- function GuildWarArrangeBattleUI:on_guild_war_arrange_battle_ui_close()
--     uiManager:PopUi()
-- end
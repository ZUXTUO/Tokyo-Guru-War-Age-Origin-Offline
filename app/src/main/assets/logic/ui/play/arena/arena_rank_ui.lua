-- ArenaRankUI = Class("ArenaRankUI",RankBaseUI)

-- function ArenaRankUI:RegistFunc()
--     RankBaseUI.RegistFunc(self)
--     self.bindfunc['on_gc_arena_sync_player_list'] = Utility.bind_callback(self, self.on_gc_arena_sync_player_list)
--     self.bindfunc['on_view_callback'] = Utility.bind_callback(self, self.on_view_callback)
-- end

-- function ArenaRankUI:MsgRegist()
--     RankBaseUI.MsgRegist(self)
--     PublicFunc.msg_regist(msg_activity.gc_arena_sync_player_list, self.bindfunc["on_gc_arena_sync_player_list"])
-- end

-- function ArenaRankUI:MsgUnRegist()
--     RankBaseUI.MsgUnRegist(self)
--     PublicFunc.msg_unregist(msg_activity.gc_arena_sync_player_list, self.bindfunc["on_gc_arena_sync_player_list"])
-- end

-- function ArenaRankUI:RestartData(data)
--     self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_arena]
--     self.viewDataList = {}
    
--     if not RankBaseUI.IsInitGroupData(self) then
--         local viewGroupData = {{}}
--         viewGroupData[1].rank_type = RankBaseUI.ERankType.Arena
--         -- 1战斗力 2排名
--         local fightValue = 0
--         if self.dataCenter.myArenaPlayer then
--             for i, v in ipairs(self.dataCenter.myArenaPlayer.heroCards) do
--                 fightValue = fightValue + CardHuman:new(v):GetFightValue()
--             end
--         end
--         viewGroupData[1].text_value = 
--             {fightValue, self.dataCenter.rank}
--         RankBaseUI.SetViewGroupData(self, viewGroupData)
--         RankBaseUI.SetViewCallback(self, self.bindfunc["on_view_callback"])
--     end
-- 	RankBaseUI.RestartData(self,data)
-- end

-- function ArenaRankUI:DestroyUi()
--     self.dataCenter = nil
--     self.viewDataList = nil
--     RankBaseUI.DestroyUi(self)
-- end

-- function ArenaRankUI:on_gc_arena_sync_player_list(ntype, list)
--     if ntype ~= 2 then return end

--     local rankList = {}
--     if list then
--         for i, v in ipairs(list) do
--             table.insert(rankList, ArenaPlayer:new(v))
--         end
--     end

--     -- 数据格式转换到RankPlayer
--     for i, v in ipairs(rankList) do
--         local rankPlayer = {}
--         rankPlayer.playerid = v.playerid
--         rankPlayer.playerName = v.name
--         rankPlayer.value = v.fightPoint    --战斗力
--         rankPlayer.ranking = v.rank
--         rankPlayer.heroCids = {}

--         for j, card in ipairs(v.heroCards) do
--             table.insert(rankPlayer.heroCids, card.number)
--         end
        
--         self.viewDataList[v.rank] = rankPlayer
--         -- table.insert(self.viewDataList, rankPlayer)
--     end

--     if self.viewDataList[1] then
--         self:SetViewData(1, self.viewDataList)
--     end
-- end

-- function ArenaRankUI:on_view_callback(index, rank_type)
--     if index == 1 then
--         msg_activity.cg_arena_request_player_list(2);
--     end
-- end

KuiKuLiYaRankUI = Class("KuiKuLiYaRankUI",RankBaseUI)

function KuiKuLiYaRankUI:RegistFunc()
    RankBaseUI.RegistFunc(self)
    self.bindfunc['gc_sync_kuikuliya_top_list'] = Utility.bind_callback(self, self.gc_sync_kuikuliya_top_list)
    self.bindfunc['on_view_callback'] = Utility.bind_callback(self, self.on_view_callback)
end

function KuiKuLiYaRankUI:MsgRegist()
    RankBaseUI.MsgRegist(self)
    PublicFunc.msg_regist(msg_activity.gc_sync_kuikuliya_top_list,self.bindfunc['gc_sync_kuikuliya_top_list'])
end

function KuiKuLiYaRankUI:MsgUnRegist()
    RankBaseUI.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_activity.gc_sync_kuikuliya_top_list,self.bindfunc['gc_sync_kuikuliya_top_list'])
end

function KuiKuLiYaRankUI:RestartData(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa]
    
    if not RankBaseUI.IsInitGroupData(self) then
        local viewGroupData = {{}}
        viewGroupData[1].rank_type = RankBaseUI.ERankType.Ultimate
        -- 1层数 2排名
        viewGroupData[1].text_value = 
            {self.dataCenter:GetOpenFloor(),self.dataCenter:GetMyRank()}
        RankBaseUI.SetViewGroupData(self, viewGroupData)
        RankBaseUI.SetViewCallback(self, self.bindfunc["on_view_callback"])
    end
    RankBaseUI.RestartData(self,data)
end

function KuiKuLiYaRankUI:DestroyUi()
    self.dataCenter = nil
    self.rankList = nil
    RankBaseUI.DestroyUi(self)
end

--每一次拉取10条, 全部取完后显示
function KuiKuLiYaRankUI:gc_sync_kuikuliya_top_list(result, beginIndex, list)
    self.rankList = self.rankList or {}
    if list then
        for i, v in ipairs(list) do
            table.insert(self.rankList, KklyRankPlayer:new(v))
        end
    end

    if result == 0 then
        msg_activity.cg_request_kuikuliya_top_list(beginIndex + 10)
    elseif result == 1 then
        -- 数据格式转换到RankPlayer
        local viewData = {}
        for i, v in ipairs(self.rankList) do
            local rankPlayer = {}
            rankPlayer.playerid = v.playerid
            rankPlayer.playerName = v.playerName
            rankPlayer.value = v.point    --积分
            rankPlayer.ranking = v.ranking
            rankPlayer.heroCids = {}

            for j, card in ipairs(v.heroCards) do
                table.insert(rankPlayer.heroCids, card.number)
            end
            
            table.insert(viewData, rankPlayer)
        end

        self:SetViewData(1, viewData)
    end
end

function KuiKuLiYaRankUI:on_view_callback(index, rank_type)
    if index == 1 then
        msg_activity.cg_request_kuikuliya_top_list(1)
    end
end

FuzionRankUI = Class("FuzionRankUI",RankBaseUI)

function FuzionRankUI:RegistFunc()
    RankBaseUI.RegistFunc(self)
    self.bindfunc['on_get_rank_list'] = Utility.bind_callback(self, self.on_get_rank_list)
    -- self.bindfunc["on_get_champion_list"] = Utility.bind_callback(self, self.on_get_champion_list)
    self.bindfunc['on_view_callback'] = Utility.bind_callback(self, self.on_view_callback)
end

function FuzionRankUI:MsgRegist()
    RankBaseUI.MsgRegist(self)
    PublicFunc.msg_regist(msg_daluandou.gc_request_top_rank, self.bindfunc["on_get_rank_list"])
    -- PublicFunc.msg_regist(msg_daluandou.gc_request_champion_list, self.bindfunc["on_get_champion_list"])
end

function FuzionRankUI:MsgUnRegist()
    RankBaseUI.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_daluandou.gc_request_top_rank, self.bindfunc["on_get_rank_list"])
    -- PublicFunc.msg_unregist(msg_daluandou.gc_request_champion_list, self.bindfunc["on_get_champion_list"])
end

function FuzionRankUI:RestartData(data)
    self.dataCenter = g_dataCenter.fuzion
    
    if not RankBaseUI.IsInitGroupData(self) then
        local viewGroupData = {{}}
        viewGroupData[1].rank_type = RankBaseUI.ERankType.Fuzion
        -- 1积分 2排名
        local myData = self.dataCenter:GetMyData()
        viewGroupData[1].text_value = {myData.point, myData.rank}
        RankBaseUI.SetViewGroupData(self, viewGroupData)
        RankBaseUI.SetViewCallback(self, self.bindfunc["on_view_callback"])
    end
	RankBaseUI.RestartData(self,data)
end

function FuzionRankUI:DestroyUi()
    self.dataCenter = nil
    RankBaseUI.DestroyUi(self)
end

function FuzionRankUI:on_get_rank_list()
    local rankList = self.dataCenter.rankList

    -- 数据格式转换到RankPlayer
    local viewData = {}
    for i, v in ipairs(rankList) do
        local rankPlayer = {}
        rankPlayer.playerid = v.playerid
        rankPlayer.playerName = v.name
        rankPlayer.value = v.point    --积分
        rankPlayer.ranking = v.rank
        rankPlayer.heroCids = {v.herocid}
        
        table.insert(viewData, rankPlayer)
    end

    self:SetViewData(1, viewData)
end

function FuzionRankUI:on_get_champion_list()
    --历史冠军排行 废弃
end

function FuzionRankUI:on_view_callback(index, rank_type)
    if index == 1 then
        msg_daluandou.cg_request_top_rank()
    end
end

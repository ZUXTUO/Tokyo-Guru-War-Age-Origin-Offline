QingTongJiDiRankUI = Class("QingTongJiDiRankUI",RankBaseUI)

function QingTongJiDiRankUI:RegistFunc()
    RankBaseUI.RegistFunc(self)
    self.bindfunc['gc_get_top_rank'] = Utility.bind_callback(self, self.gc_get_top_rank)
    self.bindfunc['on_view_callback'] = Utility.bind_callback(self, self.on_view_callback)
end

function QingTongJiDiRankUI:MsgRegist()
    RankBaseUI.MsgRegist(self)
    PublicFunc.msg_regist(msg_three_to_three.gc_get_top_rank,self.bindfunc['gc_get_top_rank'])
end

function QingTongJiDiRankUI:MsgUnRegist()
    RankBaseUI.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_three_to_three.gc_get_top_rank,self.bindfunc['gc_get_top_rank'])
end

function QingTongJiDiRankUI:RestartData(data)
    self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
    
    if not RankBaseUI.IsInitGroupData(self) then
        local viewGroupData = {{}}
        viewGroupData[1].rank_type = RankBaseUI.ERankType.Qtjd
        -- 1排名 2积分
        viewGroupData[1].text_value = 
            {self.dataCenter:GetRankNum(),self.dataCenter:GetIntegral()}
        RankBaseUI.SetViewGroupData(self, viewGroupData)
        RankBaseUI.SetViewCallback(self, self.bindfunc["on_view_callback"])
    end
	RankBaseUI.RestartData(self,data)
end

function QingTongJiDiRankUI:DestroyUi()
    self.dataCenter = nil
    RankBaseUI.DestroyUi(self)
end

function QingTongJiDiRankUI:gc_get_top_rank(list)
    local rankList = {}
    if list then
        for i, v in ipairs(list) do
            table.insert(rankList, QTJDRankInfo:new(v))
        end
    end

    -- 数据格式转换到RankPlayer
    local viewData = {}
    for i, v in ipairs(rankList) do
        local rankPlayer = {}
        rankPlayer.playerid = v.playerid
        rankPlayer.playerName = v.name
        rankPlayer.value = v.integral    --积分
        rankPlayer.ranking = v.rankNum
        rankPlayer.heroCids = {v.roleId}
        
        table.insert(viewData, rankPlayer)
    end

    self:SetViewData(1, viewData)
end

function QingTongJiDiRankUI:on_view_callback(index, rank_type)
    if index == 1 then
        msg_three_to_three.cg_get_top_rank()
    end
end

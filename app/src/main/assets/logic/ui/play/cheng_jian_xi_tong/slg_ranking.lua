


SLGRanking = Class("SLGRanking", RankingListUI)



function SLGRanking:RegistFunc()
    RankingListUI.RegistFunc(self)
    self.bindfunc["onGCGetRankingListRet"]	   = Utility.bind_callback(self, SLGRanking.onGCGetRankingListRet)
    self.bindfunc["OnClickRuleBtn"]	   = Utility.bind_callback(self, SLGRanking.OnClickRuleBtn)
end

function SLGRanking:MsgRegist()
    RankingListUI.MsgRegist(self);
    PublicFunc.msg_regist(msg_city_building.gc_get_ranking_list_ret, self.bindfunc["onGCGetRankingListRet"])
end

function SLGRanking:MsgUnRegist()
    RankingListUI.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_city_building.gc_get_ranking_list_ret, self.bindfunc["onGCGetRankingListRet"])
end

function SLGRanking:onGCGetRankingListRet(ret, rankingList)
    app.log('lsdfjlasjdf---------ret ' .. tostring(app.get_time() - self.begintime))
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
    if ret == 0 then
        --app.log(table.tostring(rankingList))

        for k,v in pairs(rankingList) do
            if v.playerid == g_dataCenter.player:GetPlayerID() then
                self:SetMyRankingInfo(v)
                break;
            end
        end

        self:SetRankingList(self.wrapContent, rankingList)
    else
        HintUI.SetAndShow(EHintUiType.zero, 'ranking list ret error:' .. ret)
    end
end

function SLGRanking:InitUI(obj)
	RankingListUI.InitUI(self, obj)

--    local btn = ngui.find_button(self.ui, 'btn_rule')
--    btn:set_on_click(self.bindfunc["OnClickRuleBtn"])

    self.showText = gs_misc['str_28'];
    
    local label = ngui.find_label(self.ui, 'cont1/txt_rank')
    label:set_text('')

    self.teamType = ENUM.ETeamType.city_building_teaching_build;
    self.loadingId = GLoading.Show(GLoading.EType.ui);
    msg_city_building.cg_get_ranking_list()
    self.begintime = app.get_time()
end

function SLGRanking:OnClickRuleBtn()
    UiRuleDes.Start(ENUM.ERuleDesType.XiaoYuanJianShe)
end

function SLGRanking:SetMyRankingInfo(data)

    local txt = gs_misc['area_ranking_num']
    if data.ranking > 50 then
        txt = gs_misc['area_ranking_num_no_on_the_list']
    end

    local label = ngui.find_label(self.ui, 'cont1/txt_rank')
    label:set_text(string.format(txt, data.ranking))
end
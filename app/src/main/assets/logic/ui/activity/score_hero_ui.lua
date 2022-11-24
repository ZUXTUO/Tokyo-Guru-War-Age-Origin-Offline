
ScoreHeroUI = Class("ScoreHeroUI", UiBaseClass)

local resPath = "assetbundles/prefabs/ui/award/ui_1139_award.assetbundle";

local _UIText = {
    [1] = "%02d:%02d:%02d",
    [2] = "第%s名",
    [3] = "未上榜",
    [4] = "免费",

    [5] = '成功购买%d次，赠送以上道具',
    [6] = '此角色已经拥有,自动转化为%s*%d,可用于升星和潜能强化。',
}

function ScoreHeroUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function ScoreHeroUI:Restart()
    self.boxList = {}
    self.wrapContentItemAward = {}
    self.wrapContentItemScore = {}

    self.dtAdd = 0
    local config = g_dataCenter.activityReward:GetActivityTimeForActivityID(ENUM.Activity.activityType_score_hero)
    if config then
        self.activityEndTime = config.e_time
    else
        app.log('获取积分英雄活动时间失败' .. debug.traceback())
        return
    end

    self.rankColor = {
        [1] = "[FFF000]",
        [2] = "[FE3CF2]",
        [3] = "[00F6FF]",
    }

    self.rankDataCfg = ConfigManager._GetConfigTable(EConfigIndex.t_score_hero_rank_reward)
    --积分宝箱
    self.boxRewardCfg = ConfigManager._GetConfigTable(EConfigIndex.t_score_hero_box_reward)
    --英雄列表
    self.scoreHeroCfg = ConfigManager._GetConfigTable(EConfigIndex.t_score_hero_list)
    self.currHeroIndex = 1
    self.maxHeroIndex = #self.scoreHeroCfg

    self.costCfg = ConfigManager.Get(EConfigIndex.t_niudan_cost, ENUM.NiuDanType.Score)

    self.readyToClose = false
    if UiBaseClass.Restart(self, data) then
    end
end

function ScoreHeroUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_show_hero_info"] = Utility.bind_callback(self, self.on_show_hero_info)
    self.bindfunc["on_buy_once"] = Utility.bind_callback(self, self.on_buy_once)
    self.bindfunc["on_buy_ten"] = Utility.bind_callback(self, self.on_buy_ten)

    self.bindfunc["on_click_left_arrow"] = Utility.bind_callback(self, self.on_click_left_arrow)
    self.bindfunc["on_click_right_arrow"] = Utility.bind_callback(self, self.on_click_right_arrow)
    self.bindfunc["on_show_award"] = Utility.bind_callback(self, self.on_show_award)
    self.bindfunc["on_rule"] = Utility.bind_callback(self, self.on_rule)

    self.bindfunc["on_init_award_item"] = Utility.bind_callback(self, self.on_init_award_item)
    self.bindfunc["on_init_score_item"] = Utility.bind_callback(self, self.on_init_score_item)
    self.bindfunc["on_click_box"] = Utility.bind_callback(self, self.on_click_box)

    self.bindfunc["gc_request_score_hero_rankList"] = Utility.bind_callback(self, self.gc_request_score_hero_rankList)
    self.bindfunc["gc_sync_score_hero_data"] = Utility.bind_callback(self, self.gc_sync_score_hero_data)
    self.bindfunc["gc_niudan_use"] = Utility.bind_callback(self, self.gc_niudan_use)
    self.bindfunc["gc_score_hero_get_box_reward"] = Utility.bind_callback(self, self.gc_score_hero_get_box_reward)
end

function ScoreHeroUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_sync_score_hero_data, self.bindfunc["gc_sync_score_hero_data"]);
    PublicFunc.msg_regist(msg_activity.gc_request_score_hero_rankList, self.bindfunc["gc_request_score_hero_rankList"]);

    PublicFunc.msg_regist(msg_activity.gc_niudan_use,self.bindfunc['gc_niudan_use']);
    PublicFunc.msg_regist(msg_activity.gc_score_hero_get_box_reward,self.bindfunc['gc_score_hero_get_box_reward']);
    PublicFunc.msg_regist("msg_activity.gc_pause_activity.spec", self.bindfunc['on_close']);

    PublicFunc.msg_regist(player.gc_exchange_red_crystal, self.bindfunc["gc_sync_score_hero_data"]);
end

function ScoreHeroUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_sync_score_hero_data, self.bindfunc["gc_sync_score_hero_data"]);
    PublicFunc.msg_unregist(msg_activity.gc_request_score_hero_rankList, self.bindfunc["gc_request_score_hero_rankList"]);

    PublicFunc.msg_unregist(msg_activity.gc_niudan_use,self.bindfunc['gc_niudan_use']);
    PublicFunc.msg_unregist(msg_activity.gc_score_hero_get_box_reward,self.bindfunc['gc_score_hero_get_box_reward']);
    PublicFunc.msg_unregist("msg_activity.gc_pause_activity.spec", self.bindfunc['on_close']);

    PublicFunc.msg_unregist(player.gc_exchange_red_crystal, self.bindfunc["gc_sync_score_hero_data"]);
end

function ScoreHeroUI:DestroyUi()
    for _, v in pairs(self.wrapContentItemAward) do
        for _, vv in pairs(v.cards) do
            if vv.smallItem then
                vv.smallItem:DestroyUi()
                vv.smallItem = nil
            end
            if vv.smallCard then
                vv.smallCard:DestroyUi()
                vv.smallCard = nil
            end
        end
    end
    self.wrapContentItemAward = {}
    ScoreBoxWindowUI.End()

    if self.textBg then
        self.textBg:Destroy()
        self.textBg = nil
    end
    UiBaseClass.DestroyUi(self);
end

function ScoreHeroUI:on_close()
    uiManager:PopUi();
end

function ScoreHeroUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("score_hero_ui")

    local aniPath = "centre_other/animation/"
    local topPath = aniPath .. 'top/'
    local centerPath = aniPath .. 'center/'
    local downPath = aniPath .. 'down/'

    local btnClose = ngui.find_button(self.ui, topPath .. "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])
    self.lblDay = ngui.find_label(self.ui, topPath .. "lab_day")
    self.lblTime = ngui.find_label(self.ui, topPath .. "txt/lab3")

    --排行奖励
    self.awardRank = {
        scrollView = ngui.find_scroll_view(self.ui, centerPath .. 'sp_title1/sco_view'),
        wrapContent = ngui.find_wrap_content(self.ui, centerPath .. 'sp_title1/sco_view/wrap_cont'),
    }
    self.awardRank.wrapContent:set_on_initialize_item(self.bindfunc["on_init_award_item"])

    --活动积分排行榜
    self.scoreRank = {
        scrollView = ngui.find_scroll_view(self.ui, centerPath .. 'sp_title2/sco_view'),
        wrapContent = ngui.find_wrap_content(self.ui, centerPath .. 'sp_title2/sco_view/wrap_cont'),
    }
    self.scoreRank.wrapContent:set_on_initialize_item(self.bindfunc["on_init_score_item"])

    self.textBg = ngui.find_texture(self.ui, centerPath .. "texture")

    local btnBuyOnce = ngui.find_button(self.ui, centerPath .. "texture/btn1")
    btnBuyOnce:set_on_click(self.bindfunc["on_buy_once"])
    local btnBuyTen = ngui.find_button(self.ui, centerPath .. "texture/btn2")
    btnBuyTen:set_on_click(self.bindfunc["on_buy_ten"])
    local btnHeroInfo = ngui.find_button(self.ui, centerPath .. "texture/btn_xiangxi")
    btnHeroInfo:set_on_click(self.bindfunc["on_show_hero_info"])

    self.btnLeftArrow = ngui.find_button(self.ui, centerPath .. "texture/btn_left_arrows")
    self.btnLeftArrow:set_on_click(self.bindfunc["on_click_left_arrow"])
    self.btnRightArrow = ngui.find_button(self.ui, centerPath .. "texture/btn_right_arrows")
    self.btnRightArrow:set_on_click(self.bindfunc["on_click_right_arrow"])

    local btnShowAward = ngui.find_button(self.ui, centerPath .. "texture/btn_bule")
    btnShowAward:set_on_click(self.bindfunc["on_show_award"])

    local btnRule = ngui.find_button(self.ui, centerPath .. "texture/btn_shuoming")
    btnRule:set_on_click(self.bindfunc["on_rule"])

    self.lblBuyOnceCost = ngui.find_label(self.ui, centerPath .. "texture/btn1/lab2")
    local lblBuyTenCost = ngui.find_label(self.ui, centerPath .. "texture/btn2/lab2")
    lblBuyTenCost:set_text(tostring(self.costCfg.ten_cost))

    self.myInfo = {
        lblRank = ngui.find_label(self.ui, downPath .. "txt1/lab_paiming"),
        lblScore = ngui.find_label(self.ui, downPath .. "txt2/lab_paiming"),
        lblRedCrystal = ngui.find_label(self.ui, downPath .. "txt3/lab_paiming"),
    }

    --积分
    self.proScoreBar = ngui.find_progress_bar(self.ui, downPath .. "sco_bar")

    local gridBox = ngui.find_grid(self.ui, downPath .. "cont_box")
    local objCloneItem = self.ui:get_child_by_name(downPath .. "cont_box/btn_box1")
    objCloneItem:set_active(false)
    for i = 1, 7 do
        local temp = {}
        temp.obj = objCloneItem:clone()
        temp.obj:set_name('box_' .. i)
        temp.obj:set_active(true)

        temp.spBox = ngui.find_sprite(temp.obj, "sp")
        temp.lblScore = ngui.find_label(temp.obj, "lab_num")
        temp.spPoint = ngui.find_sprite(temp.obj, "sp/sp_point")
        temp.spPoint:set_active(false)

        local btnBox = ngui.find_button(temp.obj, temp.obj:get_name())
        btnBox:set_on_click(self.bindfunc["on_click_box"])
        btnBox:set_event_value("", i)
        self.boxList[i] = temp
    end

    self:CountDown()
    self:SetHeroBg()
    self.awardRank.wrapContent:set_min_index(- #self.rankDataCfg + 1)
    self.awardRank.wrapContent:set_max_index(0)
    self.awardRank.wrapContent:reset()
    self.awardRank.scrollView:reset_position()

    msg_activity.cg_requset_score_hero_data()
    msg_activity.cg_request_score_hero_rankList()

    self:Hide()
end

function ScoreHeroUI:gc_sync_score_hero_data()
    self.scoreData = g_dataCenter.activityReward:GetScoreHeroData()
    if self.scoreData.freeTimes ~= 0 then
        self.lblBuyOnceCost:set_text(_UIText[4])
    else
        self.lblBuyOnceCost:set_text(tostring(self.costCfg.once_cost))
    end

    if self.scoreData.myRank == -1 or self.scoreData.myScore == 0 then
        self.myInfo.lblRank:set_text(_UIText[3])
    else
        self.myInfo.lblRank:set_text(tostring(self.scoreData.myRank))
    end
    self.myInfo.lblScore:set_text(tostring(self.scoreData.myScore))
    self.myInfo.lblRedCrystal:set_text(tostring(PropsEnum.GetValue(IdConfig.RedCrystal)))
    self:UpdateScoreBox()
end

function ScoreHeroUI:gc_request_score_hero_rankList()
    if not self:IsShow() then
        self:Show()
    end
    self.rankList = g_dataCenter.activityReward:GetScoreHeroRankList()
    self.scoreRank.wrapContent:set_min_index(- #self.rankList + 1)
    self.scoreRank.wrapContent:set_max_index(0)
    self.scoreRank.wrapContent:reset()
    self.scoreRank.scrollView:reset_position()

    self:UpdateScoreBox()
end

function ScoreHeroUI:gc_score_hero_get_box_reward()
    self:UpdateScoreBox()
end

--[[积分宝箱]]
function ScoreHeroUI:UpdateScoreBox()
    local maxScore = 1
    for index, v in ipairs(self.boxList) do
        local data = self.boxRewardCfg[index]
        if data then
            v.obj:set_active(true)
            v.lblScore:set_text(tostring(data.need_score))

            local status = g_dataCenter.activityReward:GetScoreBoxStatus(index, data.need_score)
            if status ==  ENUM.ScoreBoxStatus.Geted then
                v.spBox:set_sprite_name("gq_baoxiang1_2")
            else
                v.spBox:set_sprite_name("gq_baoxiang1")
            end
            if status == ENUM.ScoreBoxStatus.CanGet then
                v.spPoint:set_active(true)
                v.obj:animated_play("ui_701_level_down_btnbox_sp")
            else
                v.spPoint:set_active(false)
                v.obj:animated_stop("ui_701_level_down_btnbox_sp")
            end

            if data.need_score > maxScore then
                maxScore = data.need_score
            end
        else
            v.obj:set_active(false)
        end
    end
    self.proScoreBar:set_value(self.scoreData.myScore / maxScore)
end

function ScoreHeroUI:on_init_award_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1

    if self.wrapContentItemAward[row] == nil then
        local item = {}
        item.lblRank= ngui.find_label(obj, "lab_paiming")
        item.cards = {}
        for i = 1,3 do
            local temp = {}
            temp.obj = obj:get_child_by_name("new_small_card_item" .. i)
            temp.smallCard = nil
            temp.smallItem = nil
            item.cards[i] = temp
        end
        self.wrapContentItemAward[row] = item
    end

    local data = self.rankDataCfg[index]
    if data == nil then
        app.log('data is nil!')
        return
    end

    local item = self.wrapContentItemAward[row]

    local rankTxt = ''
    if data.level_low == data.level_hight then
        rankTxt = data.level_low
    else
        rankTxt = data.level_low .. '-' .. data.level_hight
    end
    item.lblRank:set_text(string.format(_UIText[2], self:FormatText(rankTxt, index)))

    for i = 1, 3 do
        local _node = item.cards[i]
        local _cfg = data.reward[i]
        if _cfg then
            _node.obj:set_active(true)
            if PropsEnum.IsRole(_cfg.item_id) then
                if _node.smallCard == nil then
                    _node.smallCard = SmallCardUi:new({parent = _node.obj,
                        stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }})
                end
                local cardInfo = g_dataCenter.package:find_card_for_num(1, _cfg.item_id)
                if cardInfo == nil then
                    cardInfo = CardHuman:new({number = _cfg.item_id, isNotCalProperty = true})
                end
                _node.smallCard:SetData(cardInfo)
            else
                if _node.smallItem == nil then
                    _node.smallItem = UiSmallItem:new({parent = _node.obj, is_enable_goods_tip = true, delay = 200})
                end
                _node.smallItem:SetDataNumber(_cfg.item_id, _cfg.item_num)
            end
        else
            _node.obj:set_active(false)
        end
    end
end

function ScoreHeroUI:on_init_score_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1

    if self.wrapContentItemScore[row] == nil then
        local item = {}
        item.lblRank= ngui.find_label(obj, "lab_paiming")
        item.lblName = ngui.find_label(obj, "lab_name")
        item.lblScore = ngui.find_label(obj, "lab_num")
        self.wrapContentItemScore[row] = item
    end

    local item = self.wrapContentItemScore[row]
    local data = self.rankList[index]
    if data == nil then
        return
    end

    item.lblRank:set_text(string.format(_UIText[2], self:FormatText(data.rankIndex, index)))
    item.lblName:set_text(self:FormatText(data.playerName, index))
    item.lblScore:set_text(self:FormatText(data.scorePoint, index))
end

function ScoreHeroUI:FormatText(txt, rank)
    if self.rankColor[rank] then
        return self.rankColor[rank] .. txt .. '[-]'
    end
    return tostring(txt)
end

function ScoreHeroUI:GetCostRedCrystal(isTen)
    local currRedCrystal = PropsEnum.GetValue(IdConfig.RedCrystal)
    if isTen then
        return self.costCfg.ten_cost, currRedCrystal
    else
        if self.scoreData.freeTimes == 0 then
            return self.costCfg.once_cost, currRedCrystal
        end
        return 0, currRedCrystal
    end
end

function ScoreHeroUI:CheckCondition(isTen)
    local cost, curr = self:GetCostRedCrystal(isTen)
    if cost > curr then
        HintUI.SetAndShow(EHintUiType.two, "当前红钻不足，是否前往兑换?",
        {str = "是", func =
        function ()
            uiManager:PushUi(EUI.ExchangeRedCrystalUI,{needcast = cost - curr});
        end},
        {str = "否"}
        );
        return false
    end
    return true
end

function ScoreHeroUI:on_buy_once()
    if self:CheckCondition(false) then
        msg_activity.cg_niudan_use(ENUM.NiuDanType.Score,false);
    end
end

function ScoreHeroUI:on_buy_ten()
    if self:CheckCondition(true) then
        msg_activity.cg_niudan_use(ENUM.NiuDanType.Score,true);
    end
end

function ScoreHeroUI:SetHeroBg()
    local textPath = nil
    if self.scoreHeroCfg[self.currHeroIndex] then
        textPath = self.scoreHeroCfg[self.currHeroIndex].tex_path
    end
    if textPath then
        self.textBg:set_texture(textPath)
    end
    --箭头
    self.btnLeftArrow:set_active(self.currHeroIndex > 1)
    self.btnRightArrow:set_active(self.currHeroIndex < self.maxHeroIndex)
end

function ScoreHeroUI:on_click_left_arrow()
    self.currHeroIndex = self.currHeroIndex - 1
    if self.currHeroIndex < 1 then
        self.currHeroIndex = 1
    end
    self:SetHeroBg()
end

function ScoreHeroUI:on_click_right_arrow()
    self.currHeroIndex = self.currHeroIndex + 1
    if self.currHeroIndex > self.maxHeroIndex then
        self.currHeroIndex = self.maxHeroIndex
    end
    self:SetHeroBg()
end

function ScoreHeroUI:on_show_award()
    uiManager:PushUi(EUI.EggAwardShowUI, ENUM.NiuDanType.Score)
end

function ScoreHeroUI:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.ScoreHero)
end

function ScoreHeroUI:on_show_hero_info()
    if self.scoreHeroCfg[self.currHeroIndex] then
        local number = self.scoreHeroCfg[self.currHeroIndex].role_number
        RecruitDetalUI:new(number)
    end
end

function ScoreHeroUI:on_click_box(t)
    local index = t.float_value
    local status = g_dataCenter.activityReward:GetScoreBoxStatus(index, self.boxRewardCfg[index].need_score)
    if status == ENUM.ScoreBoxStatus.CanGet then
        msg_activity.cg_score_hero_get_box_reward(index)
    else
        ScoreBoxWindowUI.Start(index)
    end
end

function ScoreHeroUI:CountDown()
    if self.lblDay == nil or self.lblTime == nil or self.activityEndTime == nil then
        return
    end
    local diffSec = self.activityEndTime - system.time()
    if diffSec > 0 then
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(diffSec)
        self.lblDay:set_text(tostring(day))
        self.lblTime:set_text(string.format(_UIText[1], hour,min,sec))
    else
        --活动结束关闭
        if not self.readyToClose then
            self.readyToClose = true
            self:on_close()
        end
    end
end

function ScoreHeroUI:Update(dt)
    self.dtAdd = self.dtAdd + dt
    if self.dtAdd >= 1 then
        self.dtAdd = 0
        self:CountDown()
    end
end

function ScoreHeroUI:gc_niudan_use(result, egg_type, bTen, vecReward, vecItem)
    if bTen then
        --把必出英雄随机到一个位置
        --if egg_type ~= ENUM.NiuDanType.Vip then
        local randomPos = math.random(1, #vecReward)
        local first = vecReward[1]
        table.remove(vecReward, 1)
        table.insert(vecReward, randomPos, first)
        first = vecItem[1]
        table.remove(vecItem, 1)
        table.insert(vecItem, randomPos, first)
        --end

        local cost, curr = self:GetCostRedCrystal(true)
        EggHeroGetTen.Start({vecReward = vecReward, vecItem = vecItem, costItemNum = cost,
            costItemId = IdConfig.RedCrystal, costItemOwn = curr, description = string.format(_UIText[5], 10)})
        EggHeroGetTen.SetCallback(self.on_buy_ten, self)
    else
        if vecReward[1] then
            app.log("gc_niudan_use " .. table.tostring(vecReward[1]))

            self.vecReward = vecReward
            self.vecItem = vecItem

            if PropsEnum.IsRole(vecReward[1].id) then
                local ch = CardHuman:new({number = vecReward[1].id, level=1});
                local isNow = vecReward[1].id == vecItem[1].id
                local heroDes = nil
                if not isNow then
                    local itemConfig = ConfigManager.Get(EConfigIndex.t_item, vecItem[1].id)
                    local name = itemConfig.name
                    heroDes = string.format(_UIText[6], tostring(name), vecItem[1].count)
                end
                EggGetHero.Start(ch, isNow, heroDes)
                EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)
            else
                self:ShowGetHeroEnd()
            end
        else
            app.log("奖励列表为空:" .. table.tostring(vecReward));
        end
    end
end

function ScoreHeroUI:ShowGetHeroEnd()
    local cost, curr = self:GetCostRedCrystal(false)
    EggHeroGetOne.Start({vecReward = self.vecReward, vecItem = self.vecItem, description = string.format(_UIText[5], 1),
        costItemId = IdConfig.RedCrystal, costItemNum = cost,  costItemOwn = curr
    })
    EggHeroGetOne.SetCallback(self.on_buy_once, self);
end
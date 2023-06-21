
ScoreBoxWindowUI = Class("ScoreBoxWindowUI", UiBaseClass)

local resPath = "assetbundles/prefabs/ui/award/ui_1140_award.assetbundle";

function ScoreBoxWindowUI.Start(index)
    if ScoreBoxWindowUI.cls == nil then
        ScoreBoxWindowUI.cls = ScoreBoxWindowUI:new(index)
    end
end

function ScoreBoxWindowUI.End()
    if ScoreBoxWindowUI.cls then
        ScoreBoxWindowUI.cls:DestroyUi()
        ScoreBoxWindowUI.cls = nil
    end
end

----------------------------------------------------------------------------

function ScoreBoxWindowUI:Init(data)
    self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function ScoreBoxWindowUI:Restart(data)
    self.smallItem = {}
    self.index = data
    if UiBaseClass.Restart(self, data) then
    end
end

function ScoreBoxWindowUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
end

function ScoreBoxWindowUI:DestroyUi()
    for k, v in pairs(self.smallItem) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    self.smallItem = nil
    UiBaseClass.DestroyUi(self);
end

function ScoreBoxWindowUI:on_close()
    ScoreBoxWindowUI.End()
end

function ScoreBoxWindowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("score_box_window_ui")

    local aniPath = "centre_other/animation/"
    local btnClose = ngui.find_button(self.ui, aniPath .. "content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    local lblScore = ngui.find_label(self.ui, aniPath .. "cont1/lab_num")
    for i = 1, 4 do
        local _node = self.ui:get_child_by_name(aniPath .. "cont1/new_small_card_item" .. i)
        self.smallItem[i] = UiSmallItem:new({parent = _node, is_enable_goods_tip = true, delay = 200})
    end
    local spGet = ngui.find_sprite(self.ui, aniPath .. "cont1/sp_yiling")

    ------------------------

    local scoreData = g_dataCenter.activityReward:GetScoreHeroData()
    local cfg = ConfigManager.Get(EConfigIndex.t_score_hero_box_reward, self.index)
    lblScore:set_text(scoreData.myScore .. '/' .. cfg.need_score)

    local dropData = ConfigManager.Get(EConfigIndex.t_drop_something, cfg.dropid)
    for k, v in pairs(self.smallItem) do
        local data = dropData[k]
        if data then
            v:Show()
            v:SetDataNumber(data.goods_id, data.goods_number)
        else
            v:Hide()
        end
    end

    local isGet = g_dataCenter.activityReward:CheckScoreBoxIsGet(self.index)
    spGet:set_active(isGet)
end

SelectRoleUi = Class('SelectRoleUi', UiBaseClass)

local _UIText = {
    [1] = "队伍为空",
}
function SelectRoleUi.popPanel(activityid, selectDiffIndex, challengeCall)

    if SelectRoleUi.hasHeroTypeAddProp(activityid,selectDiffIndex) == false then
        _G[challengeCall](selectDiffIndex);
        return
    end

    if SelectRoleUi.instance  == nil then
        local data = {
            activityid = activityid;
            diffIndex = selectDiffIndex;
            challengeCall = challengeCall;
            }
        SelectRoleUi.instance = uiManager:PushUi(EUI.SelectRoleUi, data)
    end
end 

function SelectRoleUi.ClosePanel()
    if SelectRoleUi.instance then
        uiManager:PopUi()
        SelectRoleUi.instance = nil
    end
end

function SelectRoleUi.hasHeroTypeAddProp(activityid, diffIndex)
    local dataCenter = g_dataCenter.activity[activityid]

    if dataCenter.GetHurdleID == nil then return false end

    local hurdleid = dataCenter:GetHurdleID(diffIndex)
    local addPropConfig = ConfigManager.Get(EConfigIndex.t_hero_type_add_prop, hurdleid)

    local has = addPropConfig ~= nil

    if has then
        local teamid = dataCenter:GetTeamID()
        local team = g_dataCenter.player:GetTeam(teamid)
        if table.get_num(team) < 1 then
            local defTeam = g_dataCenter.player:GetDefTeam()
            msg_team.cg_update_team_info({teamid = teamid, cards = defTeam})
        end
    end

    return has
end

--初始化
function SelectRoleUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/level_activity/ui_7103_award_level.assetbundle"
	UiBaseClass.Init(self, data);
end


function SelectRoleUi:DestroyUi()

    self:RemoveCheckShowUiTime()
    if self.texturebg then
        self.texturebg:Destroy()
        self.texturebg = nil
    end
    if self.showTeamNode then
        for i = 1, 3 do
            self.showTeamNode[i].smallCard:DestroyUi();
        end
        self.showTeamNode = nil;
    end
    UiBaseClass.DestroyUi(self);
end

--注册方法
function SelectRoleUi:RegistFunc()
	UiBaseClass.RegistFunc(self)

    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose)
    self.bindfunc["OnClickChallenge"] = Utility.bind_callback(self,self.OnClickChallenge)
    self.bindfunc["OnClickLineUp"] = Utility.bind_callback(self,self.OnClickLineUp)
    self.bindfunc["OnTeamUpdate"] = Utility.bind_callback(self,self.OnTeamUpdate)
    self.bindfunc["CheckShowUi"] = Utility.bind_callback(self, self.CheckShowUi)
end

function SelectRoleUi:OnClose()
    SelectRoleUi.ClosePanel()
end

function SelectRoleUi:OnClickChallenge()
    local team = g_dataCenter.player:GetTeam(self.teamid)
    local teamMemberCount = table.get_num(team)
    if teamMemberCount < 1 then
        FloatTip.Float(_UIText[1])
        return
    end

    self:BeginChallenge()
end

function SelectRoleUi:OnClickLineUp()

    if self.teamid == nil then return end
    local initData = self:GetInitData()
    local _hurdleid = self.dataCenter:GetHurdleID(initData.diffIndex)

    local data = {
        teamType = self.teamid,
        heroMaxNum = 3,
        --proAddHurdleid = _hurdleid,
        saveCallback = self.bindfunc['OnTeamUpdate']
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function SelectRoleUi:OnTeamUpdate()
    self:UpdateUi()
end

function SelectRoleUi:BeginChallenge()

    local initData = self:GetInitData()
    _G[initData.challengeCall](initData.diffIndex);

    SelectRoleUi.ClosePanel()
    DifficultSelect.ClosePanel()
end

--初始化UI
function SelectRoleUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("SelectRoleUi")
    self.closebtn = ngui.find_button(self.ui,"btn_cha")
    self.beginbtn = ngui.find_button(self.ui,"btn1")            --挑战按钮
    self.changeteambtn = ngui.find_button(self.ui,"btn3")       --调整队伍
    self.toplab = ngui.find_label(self.ui,"lab_tips")  --头顶文字说明
    self.fightvaluelab = ngui.find_label(self.ui,"sp_fight/lab_fight") --战力文字
    self.texturebg = ngui.find_texture(self.ui,"cont_vs")
    self.showTeamNode = {}
    for i = 1, 3 do
        local info = {}
        local node = self.ui:get_child_by_name("big_card_item_80" .. tostring(i))
        local lab = ngui.find_label(node, 'lab_num')
        info.node = node
        info.label = lab
        info.smallCard = SmallCardUi:new({parent = node, stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star, SmallCardUi.SType.Qh}})

        lab:set_active(false)
        self.showTeamNode[i] = info
    end

    self.toplab:set_active(false)
    self.changeteambtn:set_on_click(self.bindfunc["OnClickLineUp"])
    self.beginbtn:set_on_click(self.bindfunc["OnClickChallenge"])
    self.closebtn:set_on_click(self.bindfunc["OnClose"])





    local initData = self:GetInitData()
    self.dataCenter = g_dataCenter.activity[initData.activityid]
    self.teamid = self.dataCenter:GetTeamID()
    local team = g_dataCenter.player:GetTeam(self.teamid)

    --self:Hide()
    if table.get_num(team) < 1 then
        self:Hide()

        self.checkShowUi = true
        self.loadingId = GLoading.Show(GLoading.EType.ui)
        TimerManager.Add(self.bindfunc["CheckShowUi"], 300, -1)
    else
        self:UpdateUi()
    end
end

function SelectRoleUi:RemoveCheckShowUiTime()
    if self.checkShowUi then
        TimerManager.Remove(self.bindfunc["CheckShowUi"])

        GLoading.Hide(GLoading.EType.ui, self.loadingId)
        self.checkShowUi = nil
    end
end

function SelectRoleUi:CheckShowUi()
    if self.checkShowUi then
        if table.get_num(g_dataCenter.player:GetTeam(self.teamid)) > 0 then
            self:RemoveCheckShowUiTime()

            self:Show()
            self:UpdateUi()
        end
    end
end

--刷新
function SelectRoleUi:UpdateUi()

    if self.teamid == nil then return end

    local initData = self:GetInitData()
    local hurdleid = self.dataCenter:GetHurdleID(initData.diffIndex)
    local addPropConfig = ConfigManager.Get(EConfigIndex.t_hero_type_add_prop,hurdleid)

    local topStr = ''
    for k,v in ipairs(addPropConfig) do
        if topStr ~= '' then
            topStr = topStr .. '\n'
        end

        topStr = topStr .. v.des
    end
    -- self.toplab:set_text(topStr)

    local backgoundTexture = addPropConfig[1].backgound
    if backgoundTexture ~= nil and backgoundTexture ~= 0 then
        self.texturebg:set_texture(backgoundTexture)
    end

    local team = g_dataCenter.player:GetTeam(self.teamid)

    local fightvalue = 0
    local heros = {}
    if team then
        for k,v in pairs(team) do
            local card =  g_dataCenter.package:find_card(ENUM.EPackageType.Hero, v);
            if card then
                fightvalue = fightvalue + card:GetFightValue()
                table.insert(heros, card);
            end
        end
    end
    fightvalue = PublicFunc.AttrInteger(fightvalue)
    self.fightvaluelab:set_text(tostring(fightvalue))

    for i = 1, 3 do
        local info = self.showTeamNode[i]
        local hero = heros[i]
        if hero then
            -- info.label:set_active(true)
            info.smallCard:SetData(hero)

            -- DJZJ-4388 删除需求
            -- local str = self:GetHeroAddPropStr(addPropConfig, hero)
            -- if str then
            --     info.label:set_active(true)
            --     info.label:set_text(self:GetHeroAddPropStr(addPropConfig, hero))
            --     info.smallCard:SetRecommend(true)
            -- else
            --     info.label:set_active(false)
            --     info.smallCard:SetRecommend(false)
            -- end
        else
            -- info.label:set_active(false)
            info.smallCard:SetData(nil)
        end
    end
end

function SelectRoleUi:GetHeroAddPropStr(addPropConfig, card)
    local str = nil
    for k,v in ipairs(addPropConfig) do
        --app.log("#hyg# v.prop_type " .. tostring(v.prop_type) .. ' ' .. tostring(v.prop_value) .. ' ' .. tostring(card.config[v.prop_type]))
        if card.config[v.prop_type] == v.prop_value then
            if str == nil then
                str = v.hero_des
            else
                str = str .. '\n' .. v.hero_des
            end
        end
    end
    return str
end


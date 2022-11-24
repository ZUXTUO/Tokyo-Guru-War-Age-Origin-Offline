
RankingListUI = Class("RankingListUI", UiBaseClass)

local topThreeIcon = 
{
    [1] = 'sjb_diyi1',
    [2] = 'sjb_dier1',
    [3] = 'sjb_disan1'
}

function RankingListUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/rank/ui_402_rank.assetbundle"
    UiBaseClass.Init(self, data);
end


function RankingListUI:Restart(data)
    UiBaseClass.Restart(self, data)
end


function RankingListUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.headTextures = {}
end


function RankingListUI:Show()
    UiBaseClass.Show(self)
end

function RankingListUI:Hide()
    UiBaseClass.Hide(self)
end


function RankingListUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self:DestroyTexture()
end

function RankingListUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_name("slg_ui_402_rank");
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_local_position(0,0,0);

--    self.objTop = self.ui:get_child_by_name("top_other");
--    self.labTitle = ngui.find_label(self.objTop, "lab_title");

--    self.objFraction = self.ui:get_child_by_name("content_hint");
--    self.listFraction = {};
--    for i = 1, 3 do
--        self.listFraction[i] = {};
--        local list = self.listFraction[i];
--        list.objRoot = self.objFraction:get_child_by_name("content"..i);
--        list.txtFraction = ngui.find_label(list.objRoot, "txt1");
--        list.labNotFraction = ngui.find_label(list.objRoot, "txt_rank");
--        list.labRank = ngui.find_label(list.objRoot, "txt3");
--        list.labFraction = ngui.find_label(list.objRoot, "lab");
--        list.objRoot:set_active(false);
--    end
    self.wrapContent = ngui.find_wrap_content(self.ui, 'wrap_content')
    self.wrapContent:set_active(false)
    self.wrapContent:set_on_initialize_item(self.bindfunc["InitItem"])

    self.showText = "战斗力";
    self.teamType = ENUM.ETeamType.normal;

    local btn = ngui.find_button(self.ui, 'btn_fork')
    btn:set_on_click(self.bindfunc["OnClose"])
    btn = ngui.find_button(self.ui, 'smak')
    btn:set_on_click(self.bindfunc["OnClose"])

    self:UpdateUi();
end

function RankingListUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

	self.bindfunc["OnClickShowPlayerInfo"]	   = Utility.bind_callback(self, RankingListUI.OnClickShowPlayerInfo)
    self.bindfunc["InitItem"]   = Utility.bind_callback(self, RankingListUI.InitItem)
    self.bindfunc["OnClose"]   = Utility.bind_callback(self, RankingListUI.OnClose)
end

function RankingListUI:OnClose()
    uiManager:PopUi()
end

function RankingListUI:OnClickShowPlayerInfo(param)
    if self:IsUseView() then
        app.log('xyz ' .. param.string_value)
--        local ui = uiManager:PushUi(EUI.FormationUiNoHomeBtn, 1);
--        ui:SetPlayerGID(param.string_value,self.teamType);  
        OtherPlayerPanel.ShowPlayer(param.string_value,self.teamType)  
    end
end

function RankingListUI:InitItem(obj, b, realID)
    local dataIndex = math.abs(realID) + 1
    local data = self.rankingList[dataIndex]
    if data == nil then
        app.log_warning('ranking data error!')
    end
    
    local sp
    local label
    if data.ranking < 4 then
        sp = ngui.find_sprite(obj, 'sp_rank1')
        sp:set_active(true)
        sp:set_sprite_name(topThreeIcon[data.ranking])
        sp = ngui.find_sprite(obj, 'sp_rank2')
        sp:set_active(false)   
    else
        sp = ngui.find_sprite(obj, 'sp_rank1')
        sp:set_active(false)
        sp = ngui.find_sprite(obj, 'sp_rank2')
        sp:set_active(true)
        label = ngui.find_label(obj, 'sp_rank2/lab')
        label:set_text(tostring(data.ranking))
    end 

    label = ngui.find_label(obj, 'lab_name')
    label:set_text(data.player_name)

    local btn = ngui.find_button(obj, 'lab_name')
    btn:reset_on_click()
    btn:set_event_value(data.playerid, 0)
    btn:set_on_click(self.bindfunc["OnClickShowPlayerInfo"])

--    label = ngui.find_label(obj, 'txt_id/lab_num2')
--    label:set_text(tostring(data.playerid))

    label = ngui.find_label(obj, 'lab_rank3')
    label:set_text(string.format("%s: %d", tostring(self.showText), data.score))

--    label = ngui.find_label(obj, 'txt_rank3/lab_num')
--    label:set_text(tostring(data.score))

    local rowName = obj:get_name()
    self.headTextures[rowName] = self.headTextures[rowName] or {}
    for i = 1, 3 do
        local headParentNodeName = 'head ('.. i - 1 .. ')'
        local headParentObj = obj:get_child_by_name( headParentNodeName)
        if data.herosid[i] then
            headParentObj:set_active(true)

            local cardInfo = CardHuman:new({number=data.herosid[i]})
            local hasSmallCardItem = self.headTextures[rowName][headParentNodeName]
            if hasSmallCardItem == nil then
                hasSmallCardItem = SmallCardUi:new({parent=headParentObj, info = cardInfo});  

                self.headTextures[rowName][headParentNodeName] = hasSmallCardItem
            else
                hasSmallCardItem:SetData(cardInfo)
            end
            hasSmallCardItem:ShowOnlyPic()
            hasSmallCardItem:SetScale(80/120)
        else
            headParentObj:set_active(false)
        end
    end

    local sp = ngui.find_sprite(obj, 'sp_line')
    if data.playerid == g_dataCenter.player:GetPlayerID() then
        sp:set_active(true)
    else
        sp:set_active(false)
    end
end

function RankingListUI:setDefalut()
    if self.itemName == nil then
        self.itemName = 'item_rank (%d)'
    end

    if self.itemBeginIndex == nil then
        self.itemBeginIndex = 0
    end

    if self.itemEndIndex == nil then
        self.itemEndIndex = 50
    end
end

-- grideNode 列举节点
-- rankingList 排行榜数据列表
    -- 数据结构参考 ranking_list_item
        -- playerid
        -- player_name
        -- score
        -- ranking
        -- herosid

function RankingListUI:SetRankingList(wrapContent, rankingList)
    
    self:setDefalut()

    if type(rankingList) == 'table' and #rankingList > 0 then
        self.rankingList = rankingList
    else
        self.rankingList = nil
        return
    end
    
    wrapContent:set_active(true)
    wrapContent:set_max_index(0)
    wrapContent:set_min_index(-#rankingList + 1)
    wrapContent:reset()
end

function RankingListUI:DestroyTexture()
    
    for k,v in pairs(self.headTextures) do
        for k,tex in pairs(v) do
            tex:DestroyUi()
        end
        
    end
    self.headTextures = {}
end

function RankingListUI:UpdateUi()
    UiBaseClass.UpdateUi(self)
end

function RankingListUI:IsUseView()
    return true;
end
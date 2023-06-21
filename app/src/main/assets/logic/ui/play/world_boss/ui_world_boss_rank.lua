--fy:2016-6-17重新写了这个排行查看的功能，没有必要继承那个排行的ui类了，

UiWorldBossRank = Class("UiWorldBossRank", UiBaseClass );

local topThreeIcon = 
{
    [1] = 'sjb_diyi1',
    [2] = 'sjb_dier1',
    [3] = 'sjb_disan1',
    [4] = "sjb_diban1"
}

function UiWorldBossRank:Init(data)
    --self.pathRes = "assetbundles/prefabs/ui/rank/ui_402_rank.assetbundle"
    --fy:新的世界boss排行功能界面资源路径更改
    self.pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3002_world_boss.assetbundle";
    UiBaseClass.Init(self, data);
end


function UiWorldBossRank:Restart(data)
    UiBaseClass.Restart(self, data)
end


function UiWorldBossRank:InitData(data)
    UiBaseClass.InitData(self, data);

    self.headTextures = {}
    self.itemIconList = {};
    self.rankPlayerData = {};
end


function UiWorldBossRank:Show()
    UiBaseClass.Show(self)
end

function UiWorldBossRank:Hide()
    UiBaseClass.Hide(self)
end


function UiWorldBossRank:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self:DestroyTexture()
    self:DestroyItemIcon();
end

function UiWorldBossRank:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_name("ui_world_boss_rank");
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
    --self.wrapContent = ngui.find_wrap_content(self.ui, 'wrap_content')
    --self.wrapContent:set_active(true)
    --self.wrapContent:set_on_initialize_item(self.bindfunc["InitItem"])
    --local btn = ngui.find_button(self.ui, 'btn_fork')
    --btn:set_on_click(self.bindfunc["OnClose"])
    --btn = ngui.find_button(self.ui, 'smak')
    --btn:set_on_click(self.bindfunc["OnClose"])
    --self.showText = "战斗力";
    self.teamType = ENUM.ETeamType.normal;
    
    --击杀boss的ui控件对象fy:2016-6-17
    self.wrapContent = ngui.find_wrap_content( self.ui, 'wrap_content' );
    self.wrapContent:set_active( false );
    self.wrapContent:set_max_index( 0 );
    self.wrapContent:set_on_initialize_item( self.bindfunc["InitItem"] );
    
    self.objPlayerRankText = self.ui:get_child_by_name( "sp_bk2" );
    self.labPlayerRankText = ngui.find_label( self.objPlayerRankText, "txt" );
    self.objKillBossItem = self.ui:get_child_by_name( "content" );
    
    local btn = ngui.find_button( self.ui, "btn_cha" );
    btn:set_on_click( self.bindfunc["OnClose"] );

    self:UpdateUi();
end

function UiWorldBossRank:RegistFunc()
    UiBaseClass.RegistFunc(self);

	self.bindfunc["OnClickShowPlayerInfo"]	   = Utility.bind_callback(self, UiWorldBossRank.OnClickShowPlayerInfo)
    self.bindfunc["InitItem"]   = Utility.bind_callback(self, UiWorldBossRank.InitItem)
    self.bindfunc["OnClose"]   = Utility.bind_callback(self, UiWorldBossRank.OnClose)
end

function UiWorldBossRank:OnClose()
    uiManager:PopUi()
end

function UiWorldBossRank:OnClickShowPlayerInfo(param)
    --if self:IsUseView() then
        local ui = uiManager:PushUi(EUI.FormationUiNoHomeBtn, 1);
        ui:SetPlayerGID(self.rankPlayerData[param],self.teamType);    
    --end
end

function UiWorldBossRank:InitItem(obj, b, realID)
    local dataIndex = math.abs(realID) + 1
    local data = self.rankingList[dataIndex]
    if data == nil then
        app.log_warning('ranking data error!')
    end
    
    local sp
    local label
    if data.ranking < 4 then
	sp = ngui.find_sprite( obj, "sp" );
	sp:set_active( true );
	sp:set_sprite_name( topThreeIcon[data.ranking] );
	sp = ngui.find_sprite( obj, "sp_win_diban" );
	sp:set_active( false );
    else
	sp = ngui.find_sprite( obj, "sp" );
	sp:set_active( false );
	sp = ngui.find_sprite( obj, "sp_win_diban" );
	sp:set_active( true );
	label = ngui.find_label( obj, "sp_win_diban/lab" );
	label:set_text( tostring( data.ranking ) );
    end 
    
    local selfSP = ngui.find_sprite( obj, "sp_effect" );
    label = ngui.find_label(obj, 'lab_name');
    if label ~= nil then
        label:set_name( "lab_name"..dataIndex );
    else
        label = ngui.find_label( obj, "lab_name"..dataIndex );
    end
    if g_dataCenter.player.playerid ~= data.playerid then
	label:set_active( true );
	label:set_text( data.player_name );
	selfSP:set_active( false );
    else
	selfSP:set_active( true );
	label:set_active( false );
    end
    self.rankPlayerData[label:get_name()] = data.playerid;
    label:set_on_ngui_click(self.bindfunc["OnClickShowPlayerInfo"]);


    local rowName = obj:get_name()
    self.headTextures[rowName] = self.headTextures[rowName] or {}
    --讲item对象管理起来，在该主UI销毁的时候"assetbundles/prefabs/text/obt/ui_3001_world_boss.assetbundle"
    local rankCfg = ConfigManager.Get(EConfigIndex.t_world_boss_rank_reward,data.ranking);
    for i = 1, 3 do
	if rankCfg["reward"..i] > 0 then
	    --奖励物品添加
	    local parentItem = obj:get_child_by_name( "new_small_card_item"..tostring( i ) );
	    local card_prop = CardProp:new( { number = rankCfg["reward"..i], count = rankCfg["reward_cnt"..i] } );
	    local smallItemIcon = UiSmallItem:new({obj = nil, parent = parentItem, cardInfo = card_prop, delay = 200, load_callback = function(cls)
                cls:SetCount(cls.cardInfo.count)
                end});
	    table.insert( self.itemIconList, smallItemIcon );
	end
    end

end

function UiWorldBossRank:setDefalut()
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

function UiWorldBossRank:SetRankingList(wrapContent, rankingList, killerData )
    
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
    
    --击杀对象的显示
    --self.objKillBossItem = self.ui:get_child_by_name( "content" );
    local nameLabel = ngui.find_label( self.objKillBossItem, "lab_name" );
    if killerData then
        if killerData.isKilled == 0 then
            nameLabel:set_text( "本轮boss未被击杀" );
        else
            nameLabel:set_text( killerData.name );
        end
    else
        nameLabel:set_text( "本轮boss未被击杀" );
    end
    local rankCfg = ConfigManager.Get(EConfigIndex.t_world_boss,1);
    --击杀奖励物品
    local parentItem = self.objKillBossItem:get_child_by_name( "new_small_card_item1" );
    local card_prop = CardProp:new( { number = rankCfg["kill_reward1"], count = rankCfg["kill_reward_cnt1"] } );
    local smallItemIcon = UiSmallItem:new({obj = nil, parent = parentItem, cardInfo = card_prop, delay = 200});
    table.insert( self.itemIconList, smallItemIcon );
    --查看击杀数据，如果没有击杀的话需要显示没有被击杀
end

function UiWorldBossRank:DestroyTexture()
    
    for k,v in pairs(self.headTextures) do
        for k,tex in pairs(v) do
            tex:DestroyUi()
        end
        
    end
    self.headTextures = {}
end

function UiWorldBossRank:DestroyItemIcon()
    for k, item in pairs( self.itemIconList ) do
	item:DestroyUi();
    end
    
    self.itemIconList = {};
end

function UiWorldBossRank:UpdateUi()
    UiBaseClass.UpdateUi(self)
    
    --添加显示世界boss排行榜显示fy:2016-6-17
    local dataCenter = g_dataCenter.worldBoss;
    if dataCenter.lastRankInfo == nil then
	return;
    end
    self.showText = "伤害";
    --self.labTitle:set_text("世界BOSS");
    --标题
    --local list = self.listFraction[3];
    --list.objRoot:set_active(true);
    --循环表
    local curRank = 0;
    local rankingList = {}
    for i = 1, 5 do
            if dataCenter.lastRankInfo[i] == nil then
                break;
            end
	    if dataCenter.lastRankInfo[i].playerid == g_dataCenter.player.playerid then
		    curRank = i;
	    end
	    rankingList[i] = {};
	    rankingList[i].playerid = dataCenter.lastRankInfo[i].playerid;
	    rankingList[i].player_name = dataCenter.lastRankInfo[i].name;
	    rankingList[i].score = dataCenter.lastRankInfo[i].damage;
	    rankingList[i].herosid = {dataCenter.lastRankInfo[i].image};
	    rankingList[i].ranking = i;
    end
    if curRank > 0 then
	    self.labPlayerRankText:set_text("你当前排名:"..tostring(curRank));
    else
	    self.labPlayerRankText:set_text("你当前未上榜，请再接再厉！");
    end

    self:SetRankingList( self.wrapContent, rankingList, dataCenter.killInfo[1] );
end



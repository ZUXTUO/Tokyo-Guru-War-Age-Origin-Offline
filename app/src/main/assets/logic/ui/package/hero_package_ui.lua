HeroPackageUI = Class("HeroPackageUI", UiBaseClass)

local AttrIconBG =
{
    [ENUM.ERestraint.Empty] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_ji.assetbundle",			--空
    [ENUM.ERestraint.Edge] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_rui.assetbundle",			--锐
    [ENUM.ERestraint.Solid] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_jian.assetbundle",			--坚
    [ENUM.ERestraint.Fast] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_ji.assetbundle",			--疾
    [ENUM.ERestraint.Unusual] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_te.assetbundle",		--特
    [ENUM.ERestraint.MaxValue] = "assetbundles/prefabs/ui/image/icon/skill/90_90/jineng_ji.assetbundle", 	        --最大值
};

local AttrIconSP =
{
    [ENUM.ERestraint.Empty] = "jineng_rui1",			--空
    [ENUM.ERestraint.Edge] = "jineng_rui1",			--锐
    [ENUM.ERestraint.Solid] = "jineng_jian1",			--坚
    [ENUM.ERestraint.Fast] = "jineng_ji1",			--疾
    [ENUM.ERestraint.Unusual] = "jineng_te1",		--特
    [ENUM.ERestraint.MaxValue] = "jineng_rui1", 	        --最大值
};

--[[local AttrNameBG =
{
    [ENUM.EHeroRarity.White] = "yx_shutiao_bai",
    [ENUM.EHeroRarity.Green] = "yx_shutiao_lv",
    [ENUM.EHeroRarity.Green1] = "yx_shutiao_lv",
    [ENUM.EHeroRarity.Blue] = "yx_shutiao_lan",
    [ENUM.EHeroRarity.Blue1] = "yx_shutiao_lan",
    [ENUM.EHeroRarity.Blue2] = "yx_shutiao_lan",
    [ENUM.EHeroRarity.Purple] = "yx_shutiao_zi",
    [ENUM.EHeroRarity.Purple1] = "yx_shutiao_zi",
    [ENUM.EHeroRarity.Purple2] = "yx_shutiao_zi",
    [ENUM.EHeroRarity.Purple3] = "yx_shutiao_zi",
    [ENUM.EHeroRarity.Gold] = "yx_shutiao_jin",
    [ENUM.EHeroRarity.Gold1] = "yx_shutiao_jin",
    [ENUM.EHeroRarity.Gold2] = "yx_shutiao_jin",
    [ENUM.EHeroRarity.Gold3] = "yx_shutiao_jin",
    [ENUM.EHeroRarity.Gold4] = "yx_shutiao_jin",
    [ENUM.EHeroRarity.Orange] = "yx_shutiao_cheng",
    [ENUM.EHeroRarity.Orange1] = "yx_shutiao_cheng",
    [ENUM.EHeroRarity.Orange2] = "yx_shutiao_cheng",
    [ENUM.EHeroRarity.Orange3] = "yx_shutiao_cheng",
    [ENUM.EHeroRarity.Orange4] = "yx_shutiao_cheng",
    [ENUM.EHeroRarity.Orange5] = "yx_shutiao_cheng",
}]]

function HeroPackageUI:Init(data)
    self.reLayoutCount = 0
    self.movePage = nil
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_5.assetbundle"
    UiBaseClass.Init(self, data);
end

function HeroPackageUI:Restart(data)
    self.gotoId = data and data.gotoId --跳转指定英雄
    self.loadingUIId = GLoading.Show(GLoading.EType.loading,0);
    if UiBaseClass.Restart(self, data) then
        --todo 各自额外的逻辑
    end
end

function HeroPackageUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_click_card"] = Utility.bind_callback(self, self.on_click_card);
    self.bindfunc["on_click_tab"] = Utility.bind_callback(self, self.on_click_tab);
    self.bindfunc["init_item"] = Utility.bind_callback(self, self.init_item);
    self.bindfunc["on_change_show"] = Utility.bind_callback(self, self.on_change_show);
    self.bindfunc["on_formation"] = Utility.bind_callback(self, self.on_formation);
    self.bindfunc['UpdatePackageMsg'] = Utility.bind_callback(self, self.UpdatePackageMsg);
    self.bindfunc["on_click_card_equip"] = Utility.bind_callback(self, self.on_click_card_equip);
    self.bindfunc["on_click_card_head"] = Utility.bind_callback(self, self.on_click_card_head);
    self.bindfunc["onListPanelResize"] = Utility.bind_callback(self, self.onListPanelResize);
end

function HeroPackageUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function HeroPackageUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_soul_exchange_hero,self.bindfunc['UpdatePackageMsg']);
end

function HeroPackageUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_soul_exchange_hero,self.bindfunc['UpdatePackageMsg']);
end

function HeroPackageUI:InitData(data)
    UiBaseClass.InitData(self, data);

    -- self.poplist = nil;
    self.curHeroType = ENUM.EProType.All;
    self.curShowType = ENUM.EShowHeroType.All;
    self.grid = nil;
    self.col = 1;
    self.teams = {};
    self.herolist = {};
    self.haveInfoList = {};
    self.nothaveInfoList = {};
    self.cardlist = {};

    self.card = {};
end

function HeroPackageUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    
    self.reLayoutCount = 0
    self.movePage = nil
    self.gotoId = nil
    self._onListPanelResize = nil
    -- self.poplist = nil;
    self.curHeroType = ENUM.EProType.All;
    self.curShowType = ENUM.EShowHeroType.All;
    self.grid = nil;
    self.herolist = {};
    -- self.showlist = {};
    for k,v in pairs(self.cardlist) do
        v:Destroy();
    end
    for k,v in pairs(self.haveList) do
        if v.item then
            v.item:Destroy();
            v.item = nil;
        end
    end
    for k,v in pairs(self.nothaveList) do
        if v.item then
            v.item:Destroy();
            v.item = nil;
        end
    end
    self.teams = {};
    self.cardlist = {};
    self.card = {};
    --self.humanPool:Destroy();
end

function HeroPackageUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("ui_602_5");
	if #self.teams == 0 then
		self.teams = g_dataCenter.player:GetDefTeam()
	end

	self.haveGrid = ngui.find_grid(self.ui,"center_other/animation/sco_view/panel/top/grid1");
	self.haveSp = ngui.find_sprite(self.ui,"center_other/animation/sco_view/panel/top");
	self.scPanel = ngui.find_panel(self.ui,"center_other/animation/sco_view/panel");
	self.scPanel:set_onResize(self.bindfunc["onListPanelResize"]);
    self.scrollview = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel");
	self.nothaveGrid = ngui.find_grid(self.ui,"center_other/animation/sco_view/panel/grid2");
	self.nothaveSp = ngui.find_sprite(self.ui,"center_other/animation/sco_view/panel/grid2");
	self.haveList = {};
	self.haveList[0] = {};
	self.haveList[0].obj = self.ui:get_child_by_name("center_other/animation/sco_view/panel/top/grid1/content1");
	self.haveList[0].obj:set_active(false);

	self.nothaveList = {};
	self.nothaveList[0] = {};
	self.nothaveList[0].obj = self.ui:get_child_by_name("center_other/animation/sco_view/panel/grid2/content1");
	self.nothaveList[0].obj:set_active(false);

	local btn1 = ngui.find_button(self.ui,"top_other/animation/yeka/yeka_all");
	btn1:set_event_value("",ENUM.EProType.All);
	btn1:set_on_click(self.bindfunc["on_click_tab"],"MyButton.Flag");
	local btn2 = ngui.find_button(self.ui,"top_other/animation/yeka/yeka_defense");
	btn2:set_event_value("",ENUM.EProType.Fang);
	btn2:set_on_click(self.bindfunc["on_click_tab"],"MyButton.Flag");
	local btn3 = ngui.find_button(self.ui,"top_other/animation/yeka/yeka_attack");
	btn3:set_event_value("",ENUM.EProType.Gong);
	btn3:set_on_click(self.bindfunc["on_click_tab"],"MyButton.Flag");
	local btn4 = ngui.find_button(self.ui,"top_other/animation/yeka/yeka_skill");
	btn4:set_event_value("",ENUM.EProType.Ji);
	btn4:set_on_click(self.bindfunc["on_click_tab"],"MyButton.Flag");

	self:UpdatePackage(self.curShowType,true);

    if self.gotoId then
        self:MoveToId(self.gotoId)
    end
    GLoading.Hide(GLoading.EType.loading, self.loadingUIId);
end

function HeroPackageUI:onListPanelResize()
	local w,h,clipw,cliph = self.scPanel:get_size();
	local sw,sh = self.haveSp:get_size();
	local px,py,pz = self.scPanel:get_position();
	local sx,sy,sz = self.haveSp:get_position();
	app.log(table.tostring({w = w,h = h,clipw = clipw,cliph = cliph,sw = sw,sh = sh,px = px,py = py,pz = pz,sx = sx,sy = sy,sz = sz}));
	self.haveSp:set_position(sx,(cliph/2),sz);

    self._onListPanelResize = true
end 

-- function HeroPackageUI:init_item(obj,b,real_id)
--     local id = math.abs(real_id)+1;
--     local spPoint = ngui.find_sprite( obj, "sp_point" );
--     if spPoint then
--         spPoint:set_active( false );
--     end
--     if self.showlist[id] then
--         obj:set_active(true);
--         if self.cardlist[b] == nil then
--             self.cardlist[b] = HeroPackageItemUI:new({obj=obj});
--             self.cardlist[b]:SetOnClick(self.bindfunc["on_click_card"]);
--         end
--         self.cardlist[b]:SetInfo(self.showlist[id]);
--         self.cardlist[b]:SetBlack(self.showlist[id].index == 0);
--         self.cardlist[b]:SetIsTeam(false);
--         for i=1,3 do
--             if self.teams and self.teams[i] == self.showlist[id].index
--                 then
--                 self.cardlist[b]:SetIsTeam(true);
--                 break;
--             end
--         end
--         --fy:设置克制属性显示
--         local objRestraint = obj:get_child_by_name( "texture_di" );
--         local texRestraint = ngui.find_texture( obj, "texture_di" )
--         local spRestraint = ngui.find_sprite( objRestraint, "sp_art_font" );
--         texRestraint:set_texture( AttrIconBG[self.showlist[id].restraint] );
--         spRestraint:set_sprite_name( AttrIconSP[self.showlist[id].restraint] );
--         --fy:品质带来名字背景条设置
--         local spNameBG = ngui.find_sprite( obj, "sp" );
        
--     else
--         obj:set_active(false);
--     end
-- end

function HeroPackageUI:init_have_item(obj, b, real_index)
    local index = real_index;
    local info = self.haveList[index].info;
    local item = self.haveList[index].item;
    if not item then
        item = HeroPackageItemUI:new({obj=obj});
        item:SetOnClick(self.bindfunc["on_click_card"]);
        item:SetOnClickEquip(self.bindfunc["on_click_card_equip"]);
        item:SetOnClickHead(self.bindfunc["on_click_card_head"]);
        self.haveList[index].item = item;
    end
    if info then
        item:SetInfo(info);
        item:SetBlack(info.index == 0);
        item:SetIsTeam(false);
        for i=1,3 do
            if self.teams and self.teams[i] == info.index then
                item:SetIsTeam(true);
                break;
            end
        end
    end
end

function HeroPackageUI:init_nothave_item(obj, b, real_index)
    local index = real_index;
    local info = self.nothaveList[index].info;
    local item = self.nothaveList[index].item;
    if not item then
        item = HeroPackageItemUI:new({obj=obj});
        item:SetOnClick(self.bindfunc["on_click_card"]);
        item:SetOnClickEquip(self.bindfunc["on_click_card_equip"]);
        item:SetOnClickHead(self.bindfunc["on_click_card_head"]);
        self.nothaveList[index].item = item;
    end
    if info then
        item:SetInfo(info);
        item:SetBlack(info.index == 0);
        item:SetIsTeam(false);
    end
end
--[[点选英雄]]
function HeroPackageUI:on_click_card(obj,cardinfo)
    app.log( "当前卡片的英魂物品id:"..cardinfo.config.hero_soul_item_id );
    if cardinfo.index ~= 0 then
        uiManager:PushUi(EUI.BattleUI,{cardInfo = cardinfo,is_player = true});
        --uiManager:GetCurScene():SetRoleNumber(cardinfo.number,true);
        return;
    end
    local tempData = g_dataCenter.package:GetCountByNumber(cardinfo.config.hero_soul_item_id);
    --app.log("当前英雄碎片 number is:"..tempData);
    --app.log( "当前卡片的 data id is:"..cardinfo.index );
    if tempData >= cardinfo.config.get_soul then
        -- TODO: 兑换英雄
        app.log("兑换英雄,英雄卡片的id是:"..cardinfo.number);
        GLoading.Show(GLoading.EType.msg);
        msg_cards.cg_soul_exchange_hero(cardinfo.number);
    else
        -- TODO: 获取途径
        --app.log("获取途径:");
        local data = {};
        data.item_id = cardinfo.config.hero_soul_item_id;
        data.number = cardinfo.config.get_soul;
        AcquiringWayUi.Start(data);
    end
end

function HeroPackageUI:on_click_card_equip(obj,cardInfo)
    uiManager:PushUi(EUI.EquipPackageUI, {cardNumber = cardInfo.number})
end

function HeroPackageUI:on_click_card_head(obj,cardInfo)
    local data = 
    {   
        info = cardInfo,
        isPlayer = true,
        heroDataList = self.showList,
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

--[[切换显示英雄职业]]
function HeroPackageUI:on_click_tab(t)
    self:UpdateCardList(t.float_value);
end

--[[切换显示是否拥有英雄]]
function HeroPackageUI:on_change_show(value)
    self:UpdatePackage(value);
end

function HeroPackageUI:on_formation()
    uiManager:PushUi(EUI.FormationUi2)
end

--[[更新背包]]
function HeroPackageUI:UpdatePackage(show_type,is_refresh)
    if self.curShowType == show_type and not is_refresh then return end;
    self.curShowType = show_type;
    --self.herolist = PublicFunc.GetAllHero(show_type);
    self.herolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    self:UpdateCardList(self.curHeroType,true);
end

function HeroPackageUI:UpdatePackageMsg( dataid,ret )
    self:UpdatePackage(self.curShowType,true);
end

function HeroPackageUI:Show()
    UiBaseClass.Show(self);
    --local haveList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    if #haveList ~= #self.haveList then
        self:UpdatePackage(self.curShowType,true);
    else
        for k,v in pairs(self.haveList) do
            self:init_have_item(v.obj,k,k);
        end
        self.haveGrid:reposition_now();
        for k,v in pairs(self.nothaveList) do
            self:init_nothave_item(v.obj,k,k);
        end
        self.nothaveGrid:reposition_now();
    end
end

--[[更新显示列表]]
function HeroPackageUI:UpdateCardList(hero_type,is_refresh)
    if self.curHeroType == hero_type and not is_refresh then return end;
    self.curHeroType = hero_type;
    for k,v in pairs(self.haveList) do
        v.obj:set_active(false);
    end
    for k,v in pairs(self.nothaveList) do
        v.obj:set_active(false);
    end
    self.showList = {};
    local haveList = {};
    local nothaveList = {};
    for i=1,#self.herolist do
        if hero_type == ENUM.EProType.All 
            or hero_type == self.herolist[i].pro_type then
            if self.herolist[i].index ~= 0 or 
                g_dataCenter.package:GetCountByNumber(self.herolist[i].config.hero_soul_item_id) >= self.herolist[i].config.get_soul
                then
                table.insert(haveList,self.herolist[i]);
            else
                table.insert(nothaveList,self.herolist[i]);
            end
        end
    end

    local last_obj;
    for i=1,#haveList do
        if not self.haveList[i] then
            self.haveList[i] = {};
            self.haveList[i].obj = self.haveList[0].obj:clone();
            self.haveList[i].obj:set_name("content"..i)
        end
        self.haveList[i].obj:set_active(true);
        self.haveList[i].info = haveList[i];
        table.insert(self.showList, haveList[i]);
        last_obj = self.haveList[i].obj;
        self:init_have_item(self.haveList[i].obj,i,i);
    end
    self.haveGrid:reposition_now();
    self.haveSp:set_height(138*math.ceil(#haveList/2));

    for i=1,#nothaveList do
        if not self.nothaveList[i] then
            self.nothaveList[i] = {};
            self.nothaveList[i].obj = self.nothaveList[0].obj:clone();
            self.nothaveList[i].obj:set_name("content"..i)
        end
        self.nothaveList[i].obj:set_active(true);
        self.nothaveList[i].info = nothaveList[i];
        table.insert(self.showList, nothaveList[i]);
        self:init_nothave_item(self.nothaveList[i].obj,i,i);
    end
    self.nothaveGrid:reposition_now();
    self.scrollview:reset_position();

    self.reLayoutCount = 1
end

function HeroPackageUI:Update(dt)
    if self.reLayoutCount == 1 then
        self.reLayoutCount = 2
    end
end

-- function HeroPackageUI:UpdateUi()
--     if UiBaseClass.UpdateUi(self) then
--         self:UpdatePackage(self.curShowType,true);
--     end
-- end

function HeroPackageUI:MoveToId(id)
    if self.movePage or not self.haveGrid then return end

    local index = 1
    for i, heroData in pairs(self.haveList) do
        if heroData.info and heroData.info.default_rarity == id then
            index = i
            break;
        end
    end

    self.movePage = math.floor((index - 1)/2) * self.haveGrid:get_cell_height()
    if self.movePage > 0 then
        self.scrollview:move_relative(0, self.movePage, 0)
    end
end

------------------------ 新手引导接口函数 -----------------------
function HeroPackageUI:GetHeroListUiByIndex(index, type)
    if self.reLayoutCount ~= 2 then return end
    -- if self._onListPanelResize ~= true then return end

    local heroData = self.haveList[index]
    if heroData and heroData.item then
        -- 获取整个item
        if nil == type then
            return heroData.item.ui
        -- 获取item上面的按钮
        else
            return heroData.item:GetBtnUiByType(type)
        end
    end
end

function HeroPackageUI:GetHeroListUiById(id, type)
    if self.reLayoutCount ~= 2 then return end
    -- if self._onListPanelResize ~= true then return end

    if self.movePage == nil then
        self:MoveToId(id)
        self.reLayoutCount = 1 --等待下一帧move位置准备好
    end

    for i, heroData in pairs(self.haveList) do
        if heroData.info and heroData.info.default_rarity == id then
            return self:GetHeroListUiByIndex(i, type)
        end
    end
end
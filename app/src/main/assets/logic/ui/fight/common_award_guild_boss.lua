--fileName:ui/fight/common_award_guild_boss.lua
--desc:社团boss结算界面显示
--code by:fengyu
--date:2016-8-11

CommonAwardGuildBoss = Class( "CommonAwardGuildBoss", MultiResUiBaseClass );

local instance = nil;

-- //awardType 1:击杀结算 2:时间限制 主动退出 全部死亡 3:每日更新
function CommonAwardGuildBoss.Start(awardType, boss_index, is_first_pass, is_killer, damage)
    local bossList = ConfigManager._GetConfigTable(EConfigIndex.t_guild_boss_monster);
    local _damage = damage;
    local _rank = g_dataCenter.guildBoss.curMyMyRank+1;

    local _awardType = 1;
    local _title = 1;
    local _reward = {};
    if awardType == 1 or awardType == 3 then
        if is_first_pass and is_killer and #bossList == boss_index then
            _awardType = 8;
            _reward[1] = bossList[boss_index].first_pass_reward;
            _reward[2] = bossList[boss_index].kill_reward;
            _reward[3] = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
            _title = 1;
        elseif is_first_pass and #bossList == boss_index then
            _awardType = 7;
            _reward[1] = bossList[boss_index].first_pass_reward;
            _reward[2] = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
            _title = 1;
        elseif is_killer and #bossList == boss_index then
            _awardType = 5;
            _reward[1] = bossList[boss_index].kill_reward;
            _reward[2] = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
            _title = 1;
        elseif is_first_pass and is_killer then
            _awardType = 6;
            _reward[1] = bossList[boss_index].kill_reward;
            _reward[2] = bossList[boss_index].first_pass_reward;
            _title = 2;
        elseif is_killer then
            _awardType = 2;
            _reward[1] = bossList[boss_index].kill_reward;
            _title = 2;
        elseif is_first_pass then
            _awardType = 3;
            _reward[1] = bossList[boss_index].first_pass_reward;
            _title = 2;
        elseif #bossList == boss_index then
            _awardType = 4;
            _reward[1] = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
            _title = 1;
        else
            _awardType = 1;
            _title = 2;
        end
    elseif awardType == 2 then
        _awardType = 4;
        _reward[1] = ConfigManager.Get(EConfigIndex.t_guild_boss_system,1).play_reward;
        _title = 1;
    end
    if _damage == 0 then
        if _awardType == 4 then
            _awardType = 1;
        elseif _awardType == 5 then
            _awardType = 2;
        elseif _awardType == 7 then
            _awardType = 3;
        elseif _awardType == 8 then
            _awardType = 6;
        end
    end

    if instance == nil then
        instance = CommonAwardGuildBoss:new(
            {
                title = _title,
                awardType = _awardType,
                damage = _damage,
                rankNum = _rank,
                reward1 = _reward[1],
                reward2 = _reward[2],
                reward3 = _reward[3],
            }
        );
    end
end

function CommonAwardGuildBoss.SetFinishCallback( callback, obj )
    if instance then
        instance.callbackFunc = callback;
        if instance.callbackFunc then
            instance.callbackObj = obj;
        end
    end
end

local resType = 
{
    Back = 0,
    Front1 = 1, -- 无
    Front2 = 2, -- 首杀
    Front3 = 3, -- 首通
    Front4 = 4, -- 参与
    Front5 = 5, -- 参与+首杀
    Front6 = 6, -- 首杀+首通
    Front7 = 7, -- 参与+首通
    Front8 = 8, -- 参与+首杀+首通
}

local ETitleName = 
{
    [1] = "js_zhandoujieshu",
    [2] = "js_jishachenggong",
}

local resPaths = 
{
    [resType.Front1] = 'assetbundles/prefabs/ui/new_fight/ui_829_fight.assetbundle';
    [resType.Front2] = 'assetbundles/prefabs/ui/new_fight/ui_829_fight.assetbundle';
    [resType.Front3] = 'assetbundles/prefabs/ui/new_fight/ui_829_fight.assetbundle';
    [resType.Front4] = 'assetbundles/prefabs/ui/new_fight/ui_829_fight.assetbundle';
    [resType.Front5] = 'assetbundles/prefabs/ui/new_fight/ui_836_fight.assetbundle';
    [resType.Front6] = 'assetbundles/prefabs/ui/new_fight/ui_836_fight.assetbundle';
    [resType.Front7] = 'assetbundles/prefabs/ui/new_fight/ui_836_fight.assetbundle';
    [resType.Front8] = 'assetbundles/prefabs/ui/new_fight/ui_837_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local uiString = 
{
    [1] = '最后一击';
    [2] = '首通奖励';
    [3] = '参与奖励';
}


function CommonAwardGuildBoss:Restart( data )
    self.pathRes = 
    {
        resPaths[data.awardType],
        resPaths[resType.Back]
    };
    MultiResUiBaseClass.Restart( self, data );
end

function CommonAwardGuildBoss:DestroyUi()
    if self.listAward1 then
        for k,v in pairs(self.listAward1) do
            v:DestroyUi();
        end
        self.listAward1 =nil;
    end
    if self.listAward2 then
        for k,v in pairs(self.listAward2) do
            v:DestroyUi();
        end
        self.listAward2 =nil;
    end
    if self.listAward3 then
        for k,v in pairs(self.listAward3) do
            v:DestroyUi();
        end
        self.listAward3 =nil;
    end
    MultiResUiBaseClass.DestroyUi( self );
end

function CommonAwardGuildBoss:RegistFunc()
    MultiResUiBaseClass.RegistFunc( self );
    self.bindfunc["on_confirm_click"] = Utility.bind_callback( self, CommonAwardGuildBoss.on_confirm_click );
end

function CommonAwardGuildBoss:on_confirm_click()
    self:DestroyUi();
    instance = nil;
    
    if self.callbackFunc then
        self.callbackFunc( self.callbackObj );
    end
end

function CommonAwardGuildBoss:InitedAllUI()
    local data = self:GetInitData();

    local backui = self.uis[resPaths[resType.Back]];
    local frontParentNode = backui:get_child_by_name("add_content")

    self.spTitle = ngui.find_sprite(backui, 'sp_art_font')

    local frontui = self.uis[resPaths[data.awardType]];
    frontui:set_parent( frontParentNode );

    local btn = ngui.find_button( backui, 'mark' );
    btn:set_on_click( self.bindfunc["on_confirm_click"] );

    self.grid = ngui.find_grid(frontui,"grid");

    self.labDamage = ngui.find_label(frontui,"sp_point1/lab_num");
    self.labRank = ngui.find_label(frontui,"sp_point2/lab_rank");
    local obj = frontui:get_child_by_name("sp_point2/sp_arrows");
    obj:set_active(false);
    local obj = frontui:get_child_by_name("sp_point2/lab_num");
    obj:set_active(false);

    self.objList1 = frontui:get_child_by_name("sp_point3");
    self.labAwardType1 = ngui.find_label(frontui,"sp_point3/txt");
    self.listAward1 = {};
    for i=1,5 do 
        local obj = frontui:get_child_by_name("sp_point3/new_small_card_item"..i);
        self.listAward1[i] = UiSmallItem:new({parent=obj});
        self.listAward1[i]:Hide();
    end
    self.listAward2 = {};
    self.labAwardType2 = ngui.find_label(frontui,"sp_point4/txt");
    for i=1,5 do 
        local obj = frontui:get_child_by_name("sp_point4/new_small_card_item"..i);
        if obj then
            self.listAward2[i] = UiSmallItem:new({parent=obj});
            self.listAward2[i]:Hide();
        end
    end
    self.listAward3 = {};
    for i=1,5 do 
        local obj = frontui:get_child_by_name("sp_point5/new_small_card_item"..i);
        if obj then
            self.listAward3[i] = UiSmallItem:new({parent=obj});
            self.listAward3[i]:Hide();
        end
    end
    self:UpdateUi();
end

function CommonAwardGuildBoss:UpdateUi()
    local data = self:GetInitData();
    if data.awardType == 2 then
        self.labAwardType1:set_text(uiString[1]);
    elseif data.awardType == 3 then
        self.labAwardType1:set_text(uiString[2]);
    elseif data.awardType == 4 then
        self.labAwardType1:set_text(uiString[3]);
    elseif data.awardType == 5 then
        self.labAwardType1:set_text(uiString[1]);
        self.labAwardType2:set_text(uiString[3]);
    elseif data.awardType == 6 then
        self.labAwardType1:set_text(uiString[1]);
        self.labAwardType2:set_text(uiString[2]);
    elseif data.awardType == 7 then
        self.labAwardType1:set_text(uiString[2]);
        self.labAwardType2:set_text(uiString[3]);
    elseif data.awardType == 1 then
        self.objList1:set_active(false);
        self.grid:reposition_now();
    end

    self.spTitle:set_sprite_name(ETitleName[data.title]);

    -- self.labKillPro:set_text(tostring(data.killPor*100).."%");
    self.labDamage:set_text(tostring(data.damage));
    if data.rankNum == 0 then
        self.labRank:set_text("未上榜");
    else
        self.labRank:set_text(tostring(data.rankNum));
    end

    for k,award in ipairs(data.reward1 or {}) do
        if self.listAward1[k] then
            self.listAward1[k]:Show();
            self.listAward1[k]:SetDataNumber(award.id, award.num);
        end
    end

    for k,award in ipairs(data.reward2 or {}) do
        if self.listAward2[k] then
            self.listAward2[k]:Show();
            self.listAward2[k]:SetDataNumber(award.id, award.num);
        end
    end

    for k,award in ipairs(data.reward3 or {}) do
        if self.listAward3[k] then
            self.listAward3[k]:Show();
            self.listAward3[k]:SetDataNumber(award.id, award.num);
        end
    end
end

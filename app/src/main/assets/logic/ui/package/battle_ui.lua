BattleUI = Class("BattleUI", UiBaseClass);

local ECultivate = 
{
    -- Attr = 60055126,
    RarityUp = 62002001, --升品
    StarUp = 62002002,  -- 升星
    Skill = 62002003,   --技能升级
    LevelUp = 62002004, --升级
    -- LianXie = 60055131,
    -- Restraint = 62002006,   --克制
    Breakthrough = 62002007,    --突破
}

local ECultivateOpentype = 
{
    PlayerLevel = 1,--战队等级 
    HeroLevel = 2,  --英雄等级 
    HeroStar = 3,   --英雄星级 
    HeroRarity = 4, --英雄品质
    HeroBreakthrough = 5, --英雄突破
}

local CultivateFunc = {};
CultivateFunc[ECultivateOpentype.PlayerLevel] = function (param, player, role_data)
    if player:GetLevel() >= param[1] then
        return false;
    else
        return true;
    end
end
CultivateFunc[ECultivateOpentype.HeroLevel] = function (param, player, role_data)
    if role_data.level >= param[1] then
        return false;
    else
        return true;
    end
end
CultivateFunc[ECultivateOpentype.HeroStar] = function (param, player, role_data)
    if role_data.config.rarity >= param[1] then
        return false;
    else
        return true;
    end
end
CultivateFunc[ECultivateOpentype.HeroRarity] = function (param, player, role_data)
    if role_data.config.real_rarity >= param[1] then
        return false;
    else
        return true;
    end
end

--fy添加用于突破界限的函数调用
CultivateFunc[ECultivateOpentype.HeroBreakthrough] = function( param, player, role_data)
    return true;
end

local CultivatePointFunc = {}
CultivatePointFunc[ECultivate.RarityUp] = function( roleData )
    return PublicFunc.ToBoolTip( roleData:CanRarityUp() )
end
CultivatePointFunc[ECultivate.StarUp] = function( roleData )
    return PublicFunc.ToBoolTip( roleData:CanStarUp() )
end
CultivatePointFunc[ECultivate.Skill] = function( roleData )
    return PublicFunc.ToBoolTip( roleData:CanSkillLevel() )
end
CultivatePointFunc[ECultivate.LevelUp] = function( roleData )
    return roleData:FormationCanLevelUp()
end
CultivatePointFunc[ECultivate.Breakthrough] = function( roleData )
    return false
end

-- 功能id大小排序 升级-升星-升品-技能-克制-突破
local funcTable = {
    ECultivate.RarityUp, ECultivate.LevelUp, ECultivate.StarUp, ECultivate.Skill, ECultivate.Breakthrough,
}
 
function BattleUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602.assetbundle";
    self.HeroCultivateCfg = ConfigManager._GetConfigTable(EConfigIndex.t_play_vs_data);
    UiBaseClass.Init(self, data);
end

function BattleUI:Restart(data)
    if data then
        app.log("restart  "..tostring(data.defToggle))
        self.curToggle = data.defToggle
        self.roleData = data.cardInfo;
        self.isPlayer = data.is_player;
    end
    self.curToggle = self.curToggle or ECultivate.RarityUp
    if UiBaseClass.Restart(self, data) then
        self.canChangeHero = true;
    end
end

function BattleUI:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end


function BattleUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_back"] = Utility.bind_callback(self, BattleUI.on_back);
    self.bindfunc["on_break_through"] = Utility.bind_callback(self, BattleUI.on_break_through);
    self.bindfunc["on_load_obj_end"] = Utility.bind_callback(self, BattleUI.on_load_obj_end);
    self.bindfunc["UpdateSceneInfo"] = Utility.bind_callback(self, BattleUI.UpdateSceneInfo);
    self.bindfunc["UpdateRoleInfo"] = Utility.bind_callback(self, BattleUI.UpdateRoleInfo);
    self.bindfunc["gc_hero_rarity_up"] = Utility.bind_callback(self, BattleUI.gc_hero_rarity_up);

    self.bindfunc["on_value_change_attr"] = Utility.bind_callback(self, BattleUI.on_value_change_attr);
    --fy
    self.bindfunc["on_value_change_breakthrough"] = Utility.bind_callback(self, BattleUI.on_value_change_breakthrough);
    self.bindfunc["on_value_change_up_star"] = Utility.bind_callback(self, BattleUI.on_value_change_up_star);
    self.bindfunc["on_value_change_up_rarity"] = Utility.bind_callback(self, BattleUI.on_value_change_up_rarity);
    self.bindfunc["on_value_change_level_up"] = Utility.bind_callback(self, BattleUI.on_value_change_level_up)
    self.bindfunc["on_value_change_skill"] = Utility.bind_callback(self, BattleUI.on_value_change_skill);
    self.bindfunc["on_value_change_restraint"] = Utility.bind_callback(self, BattleUI.on_value_change_restraint);
    self.bindfunc["on_value_change_contact"] = Utility.bind_callback(self, BattleUI.on_value_change_contact);

    self.bindfunc["on_click_disable_restraint_btn"] = Utility.bind_callback(self, BattleUI.on_click_disable_restraint_btn);
    self.bindfunc["on_cultivate_lock_click"] = Utility.bind_callback(self, BattleUI.on_cultivate_lock_click);

    self.bindfunc["update_choose_hero"] = Utility.bind_callback(self,self.update_choose_hero)
    self.bindfunc["UpdateUi"] = Utility.bind_callback(self,self.UpdateUi)
end

-- 注册消息分发回调函数
function BattleUI:MsgRegist()
    PublicFunc.msg_regist(msg_cards.gc_eat_exp, self.bindfunc["UpdateSceneInfo"])
    PublicFunc.msg_regist(msg_cards.gc_change_souls, self.bindfunc['UpdateSceneInfo']);
    PublicFunc.msg_regist(msg_cards.gc_hero_star_up, self.bindfunc['UpdateSceneInfo']);
    PublicFunc.msg_regist(msg_cards.gc_hero_rarity_up_ret,self.bindfunc['gc_hero_rarity_up'])
    PublicFunc.msg_regist(msg_cards.gc_neidan_upgrade,self.bindfunc['UpdateSceneInfo'])
    PublicFunc.msg_regist(msg_cards.gc_change_role_card_property,self.bindfunc["UpdateRoleInfo"]);
    PublicFunc.msg_regist(msg_cards.gc_update_role_card_fight_value,self.bindfunc["UpdateRoleInfo"]);
    PublicFunc.msg_regist(msg_cards.gc_update_role_cards,self.bindfunc["UpdateSceneInfo"]);
    PublicFunc.msg_regist(msg_cards.gc_eat_exps, self.bindfunc['UpdateUi'])

    --升级小红点更新
    PublicFunc.msg_regist(player.gc_buy_item, self.bindfunc["UpdateSceneInfo"])
end

-- 注销消息分发回调函数
function BattleUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_cards.gc_eat_exp, self.bindfunc["UpdateSceneInfo"])
    PublicFunc.msg_unregist(msg_cards.gc_change_souls, self.bindfunc['UpdateSceneInfo']);
    PublicFunc.msg_unregist(msg_cards.gc_hero_star_up, self.bindfunc['UpdateSceneInfo']);
    PublicFunc.msg_unregist(msg_cards.gc_hero_rarity_up_ret,self.bindfunc['gc_hero_rarity_up'])
    PublicFunc.msg_unregist(msg_cards.gc_change_role_card_property,self.bindfunc["UpdateRoleInfo"]);
    PublicFunc.msg_unregist(msg_cards.gc_neidan_upgrade,self.bindfunc["UpdateSceneInfo"])
    PublicFunc.msg_unregist(msg_cards.gc_update_role_card_fight_value,self.bindfunc["UpdateRoleInfo"]);
    PublicFunc.msg_unregist(msg_cards.gc_update_role_cards,self.bindfunc["UpdateSceneInfo"]);
    PublicFunc.msg_unregist(msg_cards.gc_eat_exps, self.bindfunc['UpdateUi'])

    PublicFunc.msg_unregist(player.gc_buy_item, self.bindfunc["UpdateSceneInfo"])
end

function BattleUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.star = { };
    self.imgHead = nil;
    self.proExp = nil;
    -- self.txtLevel = nil;
    self.name = nil;
    self.canChangeHero = true;

    -- 实例化Loading模块
    self.get_count_up = 0;
    self.player =  g_dataCenter.player;
    self.package =  g_dataCenter.package;
    self.team = self.player:GetDefTeam();

end

function BattleUI:DestroyUi(is_pop)
    UiBaseClass.DestroyUi(self);
    if self.ui then
        self.ui:set_active(false)
        self.ui = nil
    end
    if self.get_hero_audio ~= nil then
        AudioManager.StopUiAudio(self.get_hero_audio)
        self.get_hero_audio = nil
    end
    if is_pop then
        self.curToggle = nil;
    end
    self.star = { };
    self.imgHead = nil;
    self.proExp = nil;
    -- self.txtLevel = nil;
    -- self.defaultToggle = nil;
    self.toggle = nil;
    if self.equipList then
        self.equipList:DestroyUi();
        self.equipList = nil
    end
    if self.equipInfo then
        self.equipInfo:DestroyUi();
        self.equipInfo = nil
    end
    -- if self.roleInfo then
    --     self.roleInfo:DestroyUi();
    --     self.roleInfo = nil
    -- end
    if self.upStar then
        self.upStar:DestroyUi();
        self.upStar = nil
    end
    if self.upRarity then
        self.upRarity:DestroyUi();
        self.upRarity= nil
    end
    if self.skill then
        self.skill:DestroyUi();
        self.skill = nil
    end
    if self.herocontactui then
        self.herocontactui:DestroyUi()
        self.herocontactui = nil
    end
    if self.clsUpexp then
        self.clsUpexp:DestroyUi();
        self.clsUpexp = nil
    end
    if self.restrainui then
        self.restrainui:DestroyUi()
        self.restrainui = nil
    end
    
    if self.breakthroughtui then
        self.breakthroughtui:DestroyUi();
        self.breakthroughtui = nil;
    end
    if self.heroListUi then
        self.heroListUi:DestroyUi()
        self.heroListUi = nil
    end
    if self.nLvUpEffectTimeid then
        timer.stop(self.nLvUpEffectTimeid);
        self.nLvUpEffectTimeid = nil;
    end
    Show3d.Destroy();
end

function BattleUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("battle_ui")
    -- self.loading:SetParent(self.ui)

    self.name = ngui.find_label(self.ui, "left_other/animation/cont/lab_name");
    self.nameNum = ngui.find_label(self.ui, "left_other/animation/cont/lab_num");

    self.labFightPower = ngui.find_label(self.ui, "left_other/animation/cont/sp_fight/lab_fight");
    self.spAptitude = ngui.find_sprite(self.ui,"left_other/animation/cont/sp_pinjie");

    for i = 1, Const.HERO_MAX_STAR do
        self.star[i] = ngui.find_sprite(self.ui, "centre_other/animation/cont/sp_star" .. i);
    end

    self.spNotHaveHero = ngui.find_sprite(self.ui, "left_other/animation/sp_bk");
    self.labNotHaveHero = ngui.find_label(self.ui, "left_other/animation/sp_bk/lab");

    self.role3d_ui_touch = ngui.find_sprite(self.ui, "left_other/animation/sp_human");

    self.leftTipContentNode = self.ui:get_child_by_name('content')
    if self.leftTipContentNode then self.leftTipContentNode:set_active(false) end

    self.objLeft = self.ui:get_child_by_name("right_other");
    self.objRightRoot = self.ui:get_child_by_name("animation/right_other/animation");
    self.btnAttr = ngui.find_button(self.ui,"left_other/animation/cont/btn_rule");
    self.btnAttr:set_on_ngui_click(self.bindfunc["on_value_change_attr"]);
    self.toggle = {};
    self.toggle[ECultivate.RarityUp] =  {};
    self.toggle[ECultivate.RarityUp].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka1");
    self.toggle[ECultivate.RarityUp].toggle:set_on_change(self.bindfunc["on_value_change_up_rarity"]);
    self.toggle[ECultivate.RarityUp].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka1/sp_clock");
    self.toggle[ECultivate.RarityUp].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka1");
    self.toggle[ECultivate.RarityUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.RarityUp].btn:set_event_value(tostring(ECultivate.RarityUp),0);
    self.toggle[ECultivate.RarityUp].spPoint = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka1/sp_point");
    self.toggle[ECultivate.RarityUp].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka1/sp1");
    self.toggle[ECultivate.RarityUp].sp:set_active(true);
    self.toggle[ECultivate.RarityUp].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka1/lab");
    self.toggle[ECultivate.RarityUp].spNormal = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka1/sp");

    self.toggle[ECultivate.StarUp] =  {};
    self.toggle[ECultivate.StarUp].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka3");
    self.toggle[ECultivate.StarUp].toggle:set_on_change(self.bindfunc["on_value_change_up_star"]);
    self.toggle[ECultivate.StarUp].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka3/sp_clock");
    self.toggle[ECultivate.StarUp].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka3");
    self.toggle[ECultivate.StarUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.StarUp].btn:set_event_value(tostring(ECultivate.StarUp), 0);
    self.toggle[ECultivate.StarUp].spPoint = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka3/sp_point");
    self.toggle[ECultivate.StarUp].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka3/sp1");
    self.toggle[ECultivate.StarUp].sp:set_active(true);
    self.toggle[ECultivate.StarUp].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka3/lab");
    self.toggle[ECultivate.StarUp].spNormal = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka3/sp");

    self.toggle[ECultivate.Skill] =  {};
    self.toggle[ECultivate.Skill].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka4");
    self.toggle[ECultivate.Skill].toggle:set_on_change(self.bindfunc["on_value_change_skill"]);
    self.toggle[ECultivate.Skill].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka4/sp_clock");
    self.toggle[ECultivate.Skill].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka4");
    self.toggle[ECultivate.Skill].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.Skill].btn:set_event_value(tostring(ECultivate.Skill), 0);
    self.toggle[ECultivate.Skill].spPoint = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka4/sp_point");
    self.toggle[ECultivate.Skill].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka4/sp1");
    self.toggle[ECultivate.Skill].sp:set_active(true);
    self.toggle[ECultivate.Skill].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka4/lab");
    self.toggle[ECultivate.Skill].spNormal = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka4/sp");

    self.toggle[ECultivate.LevelUp] =  {};
    self.toggle[ECultivate.LevelUp].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka2");
    self.toggle[ECultivate.LevelUp].toggle:set_on_change(self.bindfunc["on_value_change_level_up"]);
    self.toggle[ECultivate.LevelUp].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka2/sp_clock");
    self.toggle[ECultivate.LevelUp].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka2");
    self.toggle[ECultivate.LevelUp].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.LevelUp].btn:set_event_value(tostring(ECultivate.LevelUp), 0);
    self.toggle[ECultivate.LevelUp].spPoint = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka2/sp_point");
    self.toggle[ECultivate.LevelUp].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka2/sp1");
    self.toggle[ECultivate.LevelUp].sp:set_active(true);
    self.toggle[ECultivate.LevelUp].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka2/lab");
    self.toggle[ECultivate.LevelUp].spNormal = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka2/sp");

    -- self.toggle[ECultivate.Restraint] = {};
    -- self.toggle[ECultivate.Restraint].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka5");
    -- self.toggle[ECultivate.Restraint].toggle:set_on_change(self.bindfunc["on_value_change_restraint"]);
    -- self.toggle[ECultivate.Restraint].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka5/sp_clock");
    -- self.toggle[ECultivate.Restraint].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka5");
    -- self.toggle[ECultivate.Restraint].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"]);
    -- self.toggle[ECultivate.Restraint].btn:set_event_value(tostring(ECultivate.Restraint),0);
    -- self.toggle[ECultivate.Restraint].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka5/sp1");
    -- self.toggle[ECultivate.Restraint].sp:set_active(true);
    -- self.toggle[ECultivate.Restraint].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka5/lab");

    self.toggle[ECultivate.Breakthrough] = {};
    self.toggle[ECultivate.Breakthrough].toggle = ngui.find_toggle(self.ui, "right_other/animation/cont/yeka5");
    self.toggle[ECultivate.Breakthrough].toggle:set_on_change(self.bindfunc["on_value_change_breakthrough"]);
    self.toggle[ECultivate.Breakthrough].spLock = ngui.find_sprite(self.ui, "right_other/animation/cont/yeka5/sp_clock");
    self.toggle[ECultivate.Breakthrough].btn = ngui.find_button(self.ui, "right_other/animation/cont/yeka5");
    self.toggle[ECultivate.Breakthrough].btn:set_on_click(self.bindfunc["on_cultivate_lock_click"],"MyButton.Flag");
    self.toggle[ECultivate.Breakthrough].btn:set_event_value(tostring(ECultivate.Breakthrough), 0);
    self.toggle[ECultivate.Breakthrough].spPoint = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka5/sp_point");
    self.toggle[ECultivate.Breakthrough].sp = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka5/sp1");
    self.toggle[ECultivate.Breakthrough].sp:set_active(true);
    self.toggle[ECultivate.Breakthrough].lab = ngui.find_label(self.ui,"right_other/animation/cont/yeka5/lab");
    self.toggle[ECultivate.Breakthrough].spNormal = ngui.find_sprite(self.ui,"right_other/animation/cont/yeka5/sp");

    -- self.toggleGrid = ngui.find_grid(self.ui,"right_other/animation/scroll_view/panel/grid")
	self.heroListParent = self.ui:get_child_by_name("down_other/animation");
    -- self.toggle_scroll_view =  ngui.find_scroll_view(self.ui, "right_other/animation/scroll_view/panel")

    self.leftBtn = {};
    for i=1,3 do
        self.leftBtn[i] = {};
        self.leftBtn[i].btn = ngui.find_button(self.ui,"left_other/animation/cont1/btn_bk"..i);
        self.leftBtn[i].spPoint = ngui.find_sprite(self.ui,"left_other/animation/cont1/btn_bk"..i.."/animation/sp_point");
        self.leftBtn[i].sp = ngui.find_sprite(self.ui,"left_other/animation/cont1/btn_bk"..i.."/animation/sp_lianxie");
        self.leftBtn[i].lab = ngui.find_label(self.ui,"left_other/animation/cont1/btn_bk"..i.."/animation/txt");
    end

    if not self.roleData then
        local uuid = g_dataCenter.player:GetDefTeam()[1]
        local card = g_dataCenter.package:find_card(1,uuid);
        self.roleData = card
        --self:SetRoleNumber(card.number);
    end


    if self.heroListUi == nil then
        self.heroListUi = CommonHeroListUI:new({
            parent = self.heroListParent,
            tipType = SmallCardUi.TipType.Role,
            roleNumber = self.roleData.number,
            callback = {
                update_choose_hero = self.bindfunc["update_choose_hero"],
            }
        })
        --重复调用
        -- if self.roleData then
        --     self.heroListUi:SetRoleNumber(self.roleData.number);
        --     self.heroListUi:UpdateUi();
        -- end
    end 
   
    --重复调用 在self.heroListUi的Update_choose_hero回调中会调用了。
    --self:UpdateSceneInfo();

    --新手引导定位指定功能界面
   

    if (GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0) then
        local funcId = GuideManager.GetGuideFunctionId()
        self:SetToggle(funcId)
    end
    
    -- 取出索引
    local guideIndex, totalIndex = 0, 0
    local level = g_dataCenter.player:GetLevel();
    for i, v in ipairs(funcTable) do 
        local cfg = self.HeroCultivateCfg[v];
        if cfg.open_level <= level then
            totalIndex = totalIndex + 1
            if self.curToggle == v then
                guideIndex = totalIndex
            end
        end
    end

    -- 每一页能显示3个，移动选中页签到可视范围
    -- if guideIndex > 0 and totalIndex > 0 then
    --     local cellWidth = self.toggleGrid:get_cell_width()
    --     local moveIndex = math.max(0, math.min(guideIndex - 1, totalIndex - 3))
    --     self.toggle_scroll_view:move_relative( 0 - moveIndex * cellWidth, 0, 0 )
    -- end


    self.heroListUi:UpdateUi()

    Show3d.Addquote()
end

function BattleUI:SetToggleScrollViewActive(active)
    if self.toggle_scroll_view then
        self.toggle_scroll_view:set_active(active)
    end
end

function BattleUI:UpdateTogget()
    local level = self.player:GetLevel();
    local toggleId = self.curToggle;

    for k,v in pairs(ECultivate) do 
        local cfg = self.HeroCultivateCfg[v];
        local isShow = cfg.open_level <= level;
        self.toggle[v].toggle:set_active(isShow);
        -- self.toggle[v].lab:set_text(tostring(cfg.name));

        if isShow then
            local isLock = CultivateFunc[cfg.open_type](cfg.param, self.player, self.roleData);
            if cfg.open_type ~= ECultivateOpentype.PlayerLevel then
                isLock = false;
            end
            self.toggle[v].toggle:set_enable(not isLock);
            -- self.toggle[v].sp:set_active(not isLock);
            if self.toggle[v].spLock then
                self.toggle[v].spLock:set_active(isLock);
            end
            if v == toggleId then
                app.log("1UpdateTogget"..tostring(toggleId))                 
                if not isLock then
                    app.log("2UpdateTogget "..tostring(Root.GetFrameCount()))
                    self.toggle[v].toggle:set_start_active(true)
                    -- self.toggle[v].toggle:set_value(true);

                    -- 延迟1帧执行才生效
                    -- TimerManager.Add( function()
                    --     if self.toggle then
                    --         self.toggle[toggleId].toggle:set_value(true);
                    --     end
                    -- end, 1, 1)

                    app.log("3UpdateTogget "..tostring(Root.GetFrameCount()))  
                else
                    self:on_cultivate_lock_click({string_value=v});
                end
            else
                self.toggle[v].toggle:set_start_active(false)
            end
        end
    end


    local startItem, endItem, curItem = nil, nil, nil
    for i, v in ipairs(funcTable) do
        local cfg = self.HeroCultivateCfg[v];
        if cfg.open_level <= level then
            curItem = self.toggle[v]
            if startItem == nil then
                startItem = curItem
            else
                endItem = curItem
                curItem.sp:set_sprite_name("ty_anniu8")
                curItem.spNormal:set_sprite_name("ty_anniu9")
            end
        end
    end
    if startItem then
        startItem.sp:set_sprite_name("ty_anniu1")
        startItem.spNormal:set_sprite_name("ty_anniu2")
    end
    if endItem then
        endItem.sp:set_sprite_name("ty_anniu6")
        endItem.spNormal:set_sprite_name("ty_anniu7")
    end

    -- self.toggleGrid:reposition_now();
    self:UpdateLeftButton();
end

local ELeftBtnType = 
{
    [1] = {sp="yx_lianxie",name="连协",sys_id=-1,func="on_value_change_contact"},
    [2] = {sp="yx_kezhi",name="克制",sys_id=62002006,func="on_value_change_restraint"},
    [3] = {sp="yx_chongsheng",name="重生",sys_id=-1,func=""},
}

function BattleUI:UpdateLeftButton()
    local level = self.player:GetLevel();
    for i=1,3 do
        local cont = self.leftBtn[i];
        cont.sp:set_sprite_name(ELeftBtnType[i].sp);
        cont.lab:set_text(ELeftBtnType[i].name);
        cont.btn:reset_on_click();
        if ELeftBtnType[i].sys_id > 0 then
            local cfg = self.HeroCultivateCfg[ELeftBtnType[i].sys_id];
            local isShow = cfg.open_level <= level;
            cont.btn:set_active(isShow);
            if isShow then
                local isLock = CultivateFunc[cfg.open_type](cfg.param, self.player, self.roleData);
                if cfg.open_type ~= ECultivateOpentype.PlayerLevel then
                    isLock = false;
                end
                if isLock then
                    cont.btn:set_on_click(self.bindfunc["on_cultivate_lock_click"]);
                    cont.btn:set_event_value(tostring(ELeftBtnType[i].sys_id),0);
                else
                    cont.btn:set_on_click(self.bindfunc[ELeftBtnType[i].func]);
                end
            end
        else
            if self.bindfunc[ELeftBtnType[i].func] then
                cont.btn:set_active(true);
                cont.btn:set_on_click(self.bindfunc[ELeftBtnType[i].func]);
            else
                cont.btn:set_active(false);
            end
        end
    end
end

function BattleUI:gc_hero_rarity_up()
    self:UpdateSceneInfo()
    UiCommonPropertyChangResult.Start(self.roleData, UiCommonPropertyChangEType.HeroRarityUp)
end

-- function BattleUI:Update(dt)
--     if self.needUpdateToggle ~= nil then
--         self.needUpdateToggle = self.needUpdateToggle + 1
--         if self.needUpdateToggle > 1 then
--             --self:UpdateTogget()
--             self.needUpdateToggle = nil
--             self.defaultToggle = nil
--         end
--     end
-- end

function BattleUI:Update3dHero()
    local data =
    {
        roleData = self.roleData,
        role3d_ui_touch = self.role3d_ui_touch,
        callback = self.bindfunc["on_load_obj_end"],
    }

    Show3d.SetAndShow(data)
end

function BattleUI:UpdateRoleInfo()
    -- for i = 1, Const.HERO_MAX_STAR do
    --     if self.roleData.rarity >= i then
    --         self.star[i]:set_active(true);
    --     else
    --         self.star[i]:set_active(false);
    --     end
    -- end
    -- self.txtLevel:set_text("Lv." .. tostring(self.roleData.level));
    local nameStr, numStr = PublicFunc.FormatHeroNameAndNumber(self.roleData.name)
    self.name:set_text(nameStr)
    self.nameNum:set_text(numStr)

    self.labFightPower:set_text(""..tostring(self.roleData:GetFightValue(--[[ENUM.ETeamType.normal]])));
    PublicFunc.SetAptitudeSprite(self.spAptitude,self.roleData.config.aptitude, true);
end

function BattleUI:UpdateSceneInfo(result)
     --app.log("xxxxxx:" .. table.tostring(result))
    if self.ui and self.roleData then
        self:UpdateTogget();
        --self.defaultToggle = nil
        --self.needUpdateToggle = 0;
        -- self.loading:Hide()

        self:UpdateRoleInfo();

        if self.equipInfo then
            self.equipInfo:UpdateSceneInfo(result);
        end
        if self.skill then
            self.skill:UpdateSceneInfo(result);
        end
        -- if self.roleInfo then
        --     self.roleInfo:SetInfo(self.roleData, self.isPlayer);
        -- end
        if self.upRarity then
            self.upRarity:SetInfo(self.roleData, self.isPlayer);
        end 

        if self.isPlayer then
        else
        end
        if self.roleData.index ~= 0 then
            self.spNotHaveHero:set_active(false);
        else
            if self.roleData.config.access_way and self.roleData.config.access_way ~= 0 then
                self.labNotHaveHero:set_text(self.roleData.config.access_way);
            else
                app.log_warning(tostring(self.roleData.number) .. " role表中没有找到access_way属性配置");
            end
            self.spNotHaveHero:set_active(true);
        end

        -- if self.restraintToggle:get_value() == false then
        --     if self.roleData.rarity < 4 then
        --         self:EnableToggle(self.restraintToggle, self.restraintToggleDisablesp1, self.restraintToggleDisablesp2, false)
        --     else
        --         self:EnableToggle(self.restraintToggle, self.restraintToggleDisablesp1, self.restraintToggleDisablesp2, true)
        --     end
        -- end
			
        --英雄列表头像
        if self.heroListUi then
            self.heroListUi:UpdateCurrHero()
            self.heroListUi:UpdateHeroTips()
        end

        --功能内部小红点逻辑
        local level = self.player:GetLevel();
        for k,v in pairs(ECultivate) do 
            local cfg = self.HeroCultivateCfg[v];
            local isShow = cfg.open_level <= level;
            if isShow then
                local isLock = CultivateFunc[cfg.open_type](cfg.param, self.player, self.roleData);
                if cfg.open_type ~= ECultivateOpentype.PlayerLevel then
                    isLock = false;
                end
                if isLock then
                    self.toggle[v].spPoint:set_active(false)
                else
                    self.toggle[v].spPoint:set_active(CultivatePointFunc[v](self.roleData))
                end
            end
        end
        --克制小红点
        local cfg = self.HeroCultivateCfg[ELeftBtnType[2].sys_id];
        local isShow = cfg.open_level <= level;
        if isShow then
            self.leftBtn[2].spPoint:set_active(PublicFunc.ToBoolTip( self.roleData:CanUpRestrain() ))
        end
    end
end

function BattleUI:UpdateSubInfo()
    if not self.ui or not self.roleData then return end

    if self.equipList then
        self.equipList:SetInfo(self.roleData);
    end
    if self.equipInfo then
        self.equipInfo:SetInfo(self.roleData, self.isPlayer, self.package);
    end
    if self.skill then
        self.skill:SetInfo(self.roleData, self.isPlayer, self.package);
    end
    if self.upStar then
        self.upStar:SetInfo(self.roleData, self.isPlayer);
    end 
    if self.clsUpexp then
        -- app.log("ready setUpExp info "..table.tostring(self.roleData))
        self.clsUpexp:SetInfo(self.roleData, self.isPlayer)
    end
	
	if self.breakthroughtui then
		--app.log("###############################################"..debug.traceback())
--		self.breakthroughtui:UpdateStageDisp()
		self.breakthroughtui:SetInfo(self.roleData)
	end

    if self.restrainui then
        self.restrainui:SetInfo(self.roleData, self.isPlayer)
    end
end


function BattleUI:SetRoleNumber(role_number, is_player, package, player)
    self.player = player or g_dataCenter.player;
    self.package = package or g_dataCenter.package;
    self.team = team or self.player:GetDefTeam();
    self.isPlayer = is_player;
    --self:ChangeHero(role_number);

    -- self:UpdateHeroInfo();
    if self.heroListUi then
        self.heroListUi:SetRoleNumber(role_number);
        self.heroListUi:UpdateUi()
    end
end

function BattleUI:ChangeHero(role_number)
    app.log("BattleUI:ChangeHero"..debug.traceback())
    self.roleData = self.package:find_card_for_num(1, role_number);
    self.roleData = self.roleData or CardHuman:new( { number = role_number, level = 1, cur_exp = 0 });
    if not self.isPlayer then
        if self.equipList then
            self.equipList:DestroyUi();
            self.equipList = nil;
        end
    end
	app.log("role_number is ########"..tostring(role_number))
    self:UpdateSubInfo()
    self:UpdateSceneInfo()
    self:Update3dHero()
end

function BattleUI:on_back()
    -- self:SetToggleScrollViewActive(true)
    self:on_value_change_level_up(true);
    self.objLeft:set_active(true);
    self.toggle[ECultivate.RarityUp].toggle:set_value(true)
end

--[[打开突破]]
function BattleUI:on_break_through(t)
    if not self.isPlayer then
        return;
    end
    do 
        HintUI.SetAndShow(EHintUiType.zero, "暂未开启");
        return
    end
    if self.roleData == nil or self.roleData.index == 0 then
        HintUI.SetAndShow(EHintUiType.zero, "未获得此英雄");
        return;
    else
        -- local ret, lv = BreakThroughUI.IsHeroOpenBreak(self.roleData);
        -- if not ret then
        --     HintUI.SetAndShow(EHintUiType.zero, string.format("英雄达到%s级开启", lv));
        --     return;
        -- end
    end
    uiManager:PushUi(EUI.BreakThroughUI, self.roleData);
end

function BattleUI:on_load_obj_end()
    self.canChangeHero = true;
end

function BattleUI:GetChoseEquip()
    if self.equipInfo then
        return self.equipInfo:GetChoseEquip();
    else
        return false;
    end
end

function BattleUI:on_value_change_attr(value)


        local data = 
        {
            info = self.roleData,
            isPlayer = true,
            heroDataList = {},
        }

        uiManager:PushUi(EUI.BattleRoleInfoUI,data)

    
end

function BattleUI:on_value_change_up_star(value)
    app.log("BattleUI:on_value_change_up_star "..tostring(value) )
    if value then       
        self.curToggle = ECultivate.StarUp;
        if self.upStar then
            self.upStar:Show();
        else
            local data = 
            {
                parent=self.objRightRoot,
                info = self.roleData,
                -- callback = self.bindfunc["on_back"],
                isPlayer = self.isPlayer,
            }
            self.upStar = HeroStarUpNew:new(data);
			
        end
        -- self:on_value_change_attr();
    else
        if self.upStar then
            self.upStar:Hide();
        end
        -- if UiHeroQnqh.Inst then
        --     UiHeroQnqh.Inst:Hide()
        -- end
    end
end


function BattleUI:on_value_change_up_rarity(value)
    if value then
        self.curToggle = ECultivate.RarityUp;
        if self.upRarity then
            self.upRarity:Show()
            self.upRarity:SetInfo(self.roleData, self.isPlayer)
        else
            local data = 
            {
                parent = self.objRightRoot,
                info = self.roleData,
                isPlayer = self.isPlayer,
            }
            self.upRarity = HeroRarityUp:new(data);
        end
        --self:on_value_change_attr();        
    else
        if self.upRarity then
            self.upRarity:Hide();
        end
    end
end

function BattleUI:on_value_change_level_up(value)
    if value then
        self.curToggle = ECultivate.LevelUp;
         local data = {
            parent = self.objRightRoot,
            info = self.roleData,
            isPlayer = self.isPlayer,
            --battle_cls = self,               
        }

        if self.clsUpexp == nil then
            self.clsUpexp = RoleUpexpUI:new(data)        
        else  
            self.clsUpexp:Show(data)          
        end
        --self:on_value_change_attr();        
    else
        if self.clsUpexp then             
             self.clsUpexp:Hide()
        end
    end
end

function BattleUI:UpdateUi()
    -- 返回界面时更新一次数据
    self:UpdateSubInfo()
    self:UpdateSceneInfo()
end

function BattleUI:on_value_change_skill(value)
    if value then
        self.curToggle = ECultivate.Skill;
        if self.skill then
            self.skill:Show();
        else
            local data = 
            {
                parent=self.objRightRoot,
                info = self.roleData,
                -- callback = self.bindfunc["on_back"],
                package = self.package,
                isPlayer = self.isPlayer,
            }
            self.skill = BattleSkillUI:new(data);
        end
        --self:on_value_change_attr();        
    else
        if self.skill then
            self.skill:Hide();
        end
    end
end

function BattleUI:on_value_change_restraint(value)
    if value then
        if self.leftTipContentNode then self.leftTipContentNode:set_active(false) end
        -- if self.restrainui then
        --     self.restrainui:Show()
        -- else

            local data = 
            {
                parent=self.objRightRoot,
                info = self.roleData,
                isPlayer = self.isPlayer,
            }

            self.restrainui = PropertyRestraintUi:new(data)
        --end
        --self:on_value_change_attr();

    else
        if self.restrainui then
            self.restrainui:DestroyUi()
            self.restrainui = nil
        end
        
        -- if self.roleData.rarity < 4 then
        --     self:EnableToggle(self.restraintToggle, self.restraintToggleDisablesp1, self.restraintToggleDisablesp2, false)
        -- else
        --     self:EnableToggle(self.restraintToggle, self.restraintToggleDisablesp1, self.restraintToggleDisablesp2, true)
        -- end     
    end
end

function BattleUI:on_value_change_contact(value)
    if value then
        if self.herocontactui then
            self.herocontactui:Show()
            self.herocontactui:SetInfo(self.roleData, self.isPlayer)
        else
            local data = 
            {
                -- parent = self.ui,
                info = self.roleData,
                isPlayer = self.isPlayer,
            }
            self.herocontactui = HeroContactUI:new(data);
        end
    else
        if self.herocontactui then
            self.herocontactui:Hide()
        end
    end
end

function BattleUI:on_value_change_breakthrough(value)
    if value then
        self.curToggle = ECultivate.Breakthrough;
        if self.breakthroughtui then
            self.breakthroughtui:Show( self.roleData );
        else
            local data = {
                    parent = self.objRightRoot,
                    info = self.roleData,
            };
            self.breakthroughtui = BreakThroughUI:new(data);
        end
        --;
        
    else
        if self.breakthroughtui then
            self.breakthroughtui:Hide();
        end
    end
end

function BattleUI:on_cultivate_lock_click(t)
    local tipStr = nil
    local index = tonumber(t.string_value);
    if self.roleData then
        --app.log("...."..tostring(t.string_value)..debug.traceback())
        local cfg = self.HeroCultivateCfg[index];
        if cfg.open_type == ECultivateOpentype.PlayerLevel then
            local isLock = CultivateFunc[cfg.open_type](cfg.param, self.player, self.roleData);
            if isLock then
                tipStr = self.HeroCultivateCfg[index].unlock_des;
            end
        end
    end
    if tipStr then
        FloatTip.Float(tipStr)
    end
    if index == 7 then
        local itemList = {};
        for i = 1, 4 do
            local id = i;
            local num = i * 3;
            table.insert( itemList, {item_id = id, item_num = num} );
        end
        msg_cards.cg_breakthrough(Socket.socketServer, self.roleData.index, itemList, 1);
    end
end

function BattleUI:SetToggle(toggle_id)
    self.curToggle = toggle_id;
end

function BattleUI:update_choose_hero(roleData)
    self:ChangeHero(roleData.number);
    PopLabMgr.ClearMsg()
    if roleData and roleData.model_id then
        local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, roleData.model_id);
        if self.get_hero_audio ~= nil then
            AudioManager.StopUiAudio(self.get_hero_audio)
        end
        self.get_hero_audio = nil;
        if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
            local count = #model_list_cfg.egg_get_audio_id;
            local n = math.random(1,count)
            self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
        end
    end
    -- self:on_back();
end

function BattleUI:PlayLevelUpEffect()
    if self.isPlayLvUpEffect then
        return;
    end
    self.isPlayLvUpEffect = true;
    local function callback()
        self.isPlayLvUpEffect = false;
        self.nLvUpEffectTimeid = nil;
    end
    self.nLvUpEffectTimeid = timer.create(Utility.create_callback(callback),1500,1);
    local pos = {};
    pos.x,pos.y,pos.z = Show3d.GetInstance().ui3d_root:get_position();
    FightScene.CreateEffect(pos, ConfigManager.Get(EConfigIndex.t_effect_data,19017));
end

-------------------------- 新手引导用 ----------------------------
function BattleUI:GetHeroListUi()
    return self.heroListUi
end
function BattleUI:GetToggleBtnUi(func_id)
    if self.toggle and self.toggle[func_id] then
        return self.toggle[func_id].btn:get_game_object()
    end
end


function BattleUI:NotifyStarUpState(state)
    app.log("ddd"..debug.traceback())
    if self.upStar then
        if state then
            self.upStar:ShowEx()
        else
            self.upStar:HideEx()
        end
    end
end
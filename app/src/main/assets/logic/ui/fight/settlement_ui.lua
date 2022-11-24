local path_res =
{
    ui = "assetbundles/prefabs/ui/combat_settlement/ui_064_combat_new.assetbundle",
    level_up_card = "assetbundles/prefabs/ui/main/ui_100_main.assetbundle",
    level_up_player = "",
}
local m_StarNum = 0;
local m_DropItem = {};
local m_HurdleId = 10001;
local m_timerloop = 100;
local m_timerTime = 0.5;
local m_curExp = 100;
local m_getExp = 100;
local m_maxExp = 400;
local m_exp = m_curExp;
local m_getGold = 5000;
local m_Gold = 0;
local m_timerCnt = 0;
local cur_anim_id = 1;

-- ui控件
local ui = nil;
local labTitleName = nil;
local labPowerNum = nil;
local spTimes = nil;
local labTimesNum = nil;
local btnChallenge = nil;
local btnMopup = nil;
local btnBack = nil;
-- lose
local nodeLose = nil;
local btnLevelUp = nil;
local btnStar = nil;
local btnNiudan = nil;
-- win
local nodeWin = nil;
local star = {};
local items = {};
local spClear = nil;
local labGoldNum = nil;
local labGetExp = nil;
local labSurplusExp = nil;
local proExp = nil;

SettlementUi = Class("SettlementUi");

function SettlementUi.Init(data)
    SettlementUi.InitData(data);
    SettlementUi.LoadAsset();
end

function SettlementUi.InitData(data)
    m_StarNum = data.star or 3;
    m_DropItem = data.items or {[1]=CardProp:new({number=2000001}),[2]=CardProp:new({number=2000003})};
    m_HurdleId = data.id or 10001;
    m_curExp = 100;
    m_getExp = 100;
    m_maxExp = 400;
    m_exp = m_curExp;
    m_getGold = 5000;
    m_Gold = 0;
    m_timerCnt = 0;
    cur_anim_id = 1;
end

function SettlementUi.LoadAsset()
	if ui == nil then
        ResourceLoader.LoadAsset(path_res.ui, SettlementUi.on_loaded);
	end
end

function SettlementUi.DestoryUi()
	if(ui ~= nil) then
		ui:set_active(false);
		ui = nil;
	end
end

function SettlementUi.on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == path_res.ui then
		app.log( '战斗结算 load 完成 '..filepath )  
		SettlementUi.InitUi(asset_obj);
    elseif filepath == path_res.level_up_card then
        SettlementUi.InitLevelCardUi(asset_obj);
    elseif filepath == path_res.level_up_player then
        SettlementUi.InitLevelPlayerUi(asset_obj);
	end
end

function SettlementUi.InitUi(obj)
    local _ui = asset_game_object.create(obj);
    _ui:set_parent(Root.get_root_ui_2d());
    _ui:set_local_scale(Utility.SetUIAdaptation());
    _ui:set_name("settlement");
    ui = _ui;

    labTitleName = ngui.find_label(_ui,"top_other/txt_name");
    labPowerNum = ngui.find_label(_ui,"top_other/sp_left_di/lab_left_num");
    spTimes = ngui.find_sprite(_ui,"top_other/sp_right_di");
    labTimesNum = ngui.find_label(_ui,"top_other/sp_right_di/lab_right_num");

    -- lose 
    nodeLose = ngui.find_sprite(_ui,"centre_other/lost");
    btnLevelUp = ngui.find_button(_ui,"centre_other/lost/sp_back3/txt_prop/sp_rise_level_di");
    btnStar = ngui.find_button(_ui,"centre_other/lost/sp_back3/txt_prop/sp_rise_star_di");
    btnNiudan = ngui.find_button(_ui,"centre_other/lost/sp_back3/txt_prop/sp_niudan_di");
    -- lose end
    
    -- win
    nodeWin = ngui.find_sprite(_ui,"centre_other/clear_top");
    for i=1,3 do
        star[i] = ngui.find_sprite(_ui,"centre_other/clear_top/clear_centre/sp_star_di"..i.."/star"..i);
    end
    for i=1,5 do
        if m_DropItem[i] then
            items[i] = {};
            local cardobj = ngui.find_button(_ui,"centre_other/clear_top/sp_back3/Sprite/small_card"..i):get_game_object();
            items[i].card = SmallCardUi:new({info=m_DropItem[i], obj=cardobj, res_group=nil});
            items[i].anim = ngui.find_sprite(_ui,"centre_other/clear_top/sp_back3/Sprite/small_card"..i.."/sp_back");
            items[i].anim:set_active(false);
            items[i].obj = items[i].anim:get_game_object();
            items[i].fx = ngui.find_sprite(_ui,"centre_other/clear_top/sp_back3/Sprite/small_card"..i.."/fx");
            items[i].lab = ngui.find_label(_ui,"centre_other/clear_top/sp_back3/Sprite/lab_num"..i);
            items[i].lab:set_text("x1");
            items[i].lab:set_active(false);
        else
            local cardobj = ngui.find_button(_ui,"centre_other/clear_top/sp_back3/Sprite/small_card"..i);
            cardobj:set_active(false);
            local lab = ngui.find_label(_ui,"centre_other/clear_top/sp_back3/Sprite/lab_num"..i);
            lab:set_active(false);
        end
    end
    spClear = ngui.find_sprite(_ui,"centre_other/clear_top/clear_centre/sp_clear");
    labGoldNum = ngui.find_label(_ui,"centre_other/clear_top/sp_back1/lab_num");
    labGetExp = ngui.find_label(_ui,"centre_other/clear_top/sp_back2/lab_num");
    labSurplusExp = ngui.find_label(_ui,"centre_other/clear_top/sp_back2/lab_next_exp");
    proExp = ngui.find_progress_bar(_ui,"centre_other/clear_top/sp_back2/pro_exp");
    -- win end
    
    btnChallenge = ngui.find_button(_ui,"down_other/btn_challenge");
    btnMopup = ngui.find_button(_ui,"down_other/btn_mopup");
    btnBack = ngui.find_button(_ui,"down_other/btn_return");
    btnBack:set_on_click("SettlementUi.on_back");
    
    SettlementUi.UpdateUi();
end

function SettlementUi.UpdateUi()
    local hurdleCfg = ConfigManager.Get(EConfigIndex.t_hurdle, m_HurdleId)
    labTitleName:set_text(hurdleCfg.name);
    -- lose
    if m_StarNum == 0 then
        nodeLose:set_active(true);
        nodeWin:set_active(false);
        btnChallenge:set_active(false);
        btnMopup:set_active(false);
    -- win
    else
        nodeLose:set_active(false);
        nodeWin:set_active(true);
        -- "clear" sp
        if m_StarNum ~= 3 then
            spClear:set_active(false);
            btnChallenge:set_active(false);
            btnMopup:set_active(false);
        else
            spClear:set_active(true);
            btnChallenge:set_active(false);
            btnMopup:set_active(false);
        end
        -- star sp
        for i=1,3 do
            if i <= m_StarNum then
                star[i]:set_active(true);
            else
                star[i]:set_active(false);
            end
        end
        labGetExp:set_text(tostring(m_getExp));
        timer.create("SettlementUi.on_timer",m_timerTime,m_timerloop);
    end
    ui:animator_play("ui_064_combat_new");
    items[1].anim:set_active(true);
    items[1].obj:animator_play("small_card1");
end

function SettlementUi.on_timer()
    m_timerCnt = m_timerCnt + 1;
    if m_timerCnt < m_timerloop then
        m_exp = m_exp + m_getExp/m_timerloop;
        m_Gold = m_Gold + math.ceil(m_getGold/m_timerloop);
    else
        m_exp = m_curExp + m_getExp;
        m_Gold = m_getGold;
    end
    -- 经验条
    local value = m_exp/m_maxExp;
    proExp:set_value(value);

    -- 剩余经验数
    labSurplusExp:set_text(tostring(math.ceil(m_maxExp-m_exp)));

    -- 金币数
    labGoldNum:set_text(tostring(m_Gold));
end

function SettlementUi.on_back()
    SceneManager.PopScene(FightScene);
end

function SettlementUi.play_star(obj,id)
    -- app.log('huhu_debug SettlementUi.play_star'..table.tostring(items)..'\n'..tostring(cur_anim_id))
    items[cur_anim_id].fx:set_active(true);
end

function SettlementUi.play_next(obj,id)
    if items[cur_anim_id] then
        items[cur_anim_id].lab:set_active(true);
    else
        app.log_warning("找不到对应id"..tostring(cur_anim_id));
    end
    cur_anim_id = cur_anim_id + 1;
    if items[cur_anim_id] then
        items[cur_anim_id].anim:set_active(true);
        items[cur_anim_id].obj:animator_play("small_card1")
    end
end

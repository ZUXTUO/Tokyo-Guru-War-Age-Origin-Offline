local path_res =
{
    ui = "assetbundles/prefabs/ui/fight/ui_801_fight.assetbundle",
}
local m_StarNum = 0;
local m_HurdleId = 10001;
local m_PlayerExp = nil;
local m_DropItem = nil;
local m_HeroExp = {};
local m_Data = nil;
local m_Callback = nil;

-- ui控件
local ui = nil;
local spResult_1 = nil;
local spResult_2 = nil;
local spRecord   = nil;
local labExp     = nil;
local txtExp     = nil;
local labTime    = nil;
local txtTime    = nil;
local btnBack    = nil;
local animator   = nil;
-- lose
local nodeLose  = nil;
local btnRevive = nil;
local btnLeave  = nil;
local labRevive = nil;
-- win
local nodeWin = nil;
local star = {};
local labCondition = {};
local labSatisfy   = {};

FightResultUi = Class("FightResultUi");

--显示胜利界面需要传入data.star 代表当前关卡几星 data.copyId代表当前关卡得id号
--显示经验界面需要传入data.playerExp 玩家获得经验 data.heroExp 卡牌获得经验
--显示奖励物品界面需要传入data.items 格式为{{id = 30000001,num = 1},{id = 30000002,num = 1}}
function FightResultUi.Init(data)
    FightResultUi.InitData(data);
    FightResultUi.LoadAsset();
end

function FightResultUi.InitData(data)
	m_Data = data;
    m_StarNum   = m_Data.star or 3;
	m_HurdleId  = m_Data.copyId or 60001001;
    m_DropItem  = m_Data.items;
	m_PlayerExp = m_Data.playerExp;
	m_Callback  = data.callback;
	for i = 1, 3 do
		local info = data["hero"..tostring(i).."Exp"];
		if info then
			m_HeroExp[i] = info;
		end
	end
end

function FightResultUi.LoadAsset()
	if ui == nil then
        ResourceLoader.LoadAsset(path_res.ui, FightResultUi.on_loaded);
	end
end

function FightResultUi.DestoryUi()
	if(ui ~= nil) then
		m_PlayerExp = nil;
		m_DropItem = nil;
		m_HeroExp = {};
		m_Data = nil;
		m_Callback = nil;
		star = {};
		labCondition = {};
		labSatisfy   = {};
		ui:set_active(false);
		ui = nil;
	end
end

function FightResultUi.on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == path_res.ui then
		FightResultUi.InitUi(asset_obj);
	end
end

function FightResultUi.InitUi(obj)
    local _ui = asset_game_object.create(obj);
    _ui:set_parent(Root.get_root_ui_2d());
    _ui:set_local_scale(Utility.SetUIAdaptation());
    _ui:set_name("fight_result_ui");
    ui = _ui;

	spResult_1 = ngui.find_sprite(_ui,"fight_result_ui/sp/top_other/fight/sp_word1");
	spResult_2 = ngui.find_sprite(_ui,"fight_result_ui/sp/top_other/fight/sp_word2");
	spRecord   = ngui.find_sprite(_ui,"fight_result_ui/sp/top_other/sp_record");
	labExp     = ngui.find_label(_ui,"fight_result_ui/sp/top_other/lab_exp");
	txtExp     = ngui.find_label(_ui,"fight_result_ui/sp/top_other/txt_exp");
	labTime    = ngui.find_label(_ui,"fight_result_ui/sp/top_other/lab_time");
	txtTime    = ngui.find_label(_ui,"fight_result_ui/sp/top_other/txt_time");
	btnBack    = ngui.find_button(_ui,"fight_result_ui/sp");
    btnBack:set_on_click("FightResultUi.on_back");
	
    -- lose 
    nodeLose  = ngui.find_sprite(_ui,"fight_result_ui/sp/centre_other/sp_di2");
    btnRevive = ngui.find_button(_ui,"fight_result_ui/sp/centre_other/sp_di2/btn_revive");
    btnLeave  = ngui.find_button(_ui,"fight_result_ui/sp/centre_other/sp_di2/btn_leave");
    labRevive = ngui.find_label(_ui,"fight_result_ui/sp/centre_other/sp_di2/btn_revive/lab_num");
	btnRevive:set_on_click("FightResultUi.on_revive");
	btnRevive:set_on_click("FightResultUi.on_leave");
	-- lose end
    
    -- win
	animator= asset_game_object.find("fight_result_ui/sp");
    nodeWin = ngui.find_sprite(_ui,"fight_result_ui/centre_other/sp_di1");
    for i=1,3 do
        star[i] = ngui.find_sprite(_ui,"fight_result_ui/sp/centre_other/sp_di1/star/sp_star"..i.."/star");
		labSatisfy[i]   = ngui.find_label(_ui,"fight_result_ui/sp/centre_other/sp_di1/lab_"..i);
		labCondition[i] = ngui.find_label(_ui,"fight_result_ui/sp/centre_other/sp_di1/txt"..i);
    end
    -- win end
      
    FightResultUi.SetData();
end

function FightResultUi.SetData()
    if m_StarNum == 0 then
		spResult_1:set_sprite_name("zuozhan2");
		spResult_2:set_sprite_name("shibai");
        nodeWin:set_active(false);
		nodeLose:set_active(true);
		animator:animator_play("ui_801_fight_top_sp2");
    else
		spResult_1:set_sprite_name("zuozhan1");
		spResult_2:set_sprite_name("chenggong");
        nodeWin:set_active(true);
		nodeLose:set_active(false);
		local copyData = ConfigHelper.GetHurdleConfig(m_HurdleId);
		if not copyData then return; end;
		local conditionStr = FightCondition.GetHurdleCondiDes(m_HurdleId);
        for i=1,3 do
			local condition;
			if i == 1 then
				condition = copyData.win_condition;
			elseif i == 2 then
				condition = copyData.good_condition;
			elseif i == 3 then
				condition = copyData.perfact_condition;
			end
			local satisfy = true;
			if(condition == 0) then return nil; end;
			for k,v in pairs (condition) do
				if not FightCondition.Check(k,v,1) then
					satisfy = false;
				end
			end
			if conditionStr[i] then
				labCondition[i]:set_text(conditionStr[i]);
			end
			if satisfy then 
				labSatisfy[i]:set_text("完成");
			else 
				labSatisfy[i]:set_text("未完成");
			end
			
            if i <= m_StarNum then
                star[i]:set_active(true);
            else
                star[i]:set_active(false);
            end
        end
		
		animator:animator_play("ui_801_fight_top_sp1");
    end
end

function FightResultUi.callback(obj,eventParm)
	local str = tostring(eventParm);
	str = string.sub(str,-1,-1);
	if m_StarNum <= tonumber(str) or str == '0' then
		animator:animator_play("ui_801_fight_top_null");
	end
end

function FightResultUi.on_back()
	if m_PlayerExp or not Utility.isEmpty(m_HeroExp) then
		local data = {};
		data.playerExp = m_PlayerExp;
		data.heroExp   = m_HeroExp;
		data.dropItem  = m_DropItem;
		data.callback  = m_Callback;
		FightExpUi.Init(data);
	-- TODO 临时去掉给奖励
	-- elseif m_DropItem then
	-- 	local data = {};
	-- 	data.dropItem  = m_DropItem;
	-- 	data.callback  = m_Callback;
	-- 	FightAwardUi.Init(data);
	else
		if m_Callback then
			m_Callback();
		end
	end
	ui:set_active(false);
	FightResultUi.DestoryUi();
end

function FightResultUi.on_revive()
	
end

function FightResultUi.on_leave()
	ui:set_active(false);
	FightResultUi.DestoryUi();
	SceneManager.PopScene(FightScene);
end
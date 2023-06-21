local path_res =
{
    ui = "assetbundles/prefabs/ui/fight/ui_802_fight.assetbundle",
}
local m_DropItem = {};
local m_index = 1;
local m_Callback = nil;

-- ui控件
local ui = nil;
local card = nil;
local labName = nil;
local btnNext = nil;
local animator = nil;

FightAwardUi = Class("FightAwardUi");

--显示奖励物品界面需要传入data.items 格式为{{id = 30000001,num = 1},{id = 30000002,num = 1}}
function FightAwardUi.Init(data)
    FightAwardUi.InitData(data);
    FightAwardUi.LoadAsset();
end

function FightAwardUi.InitData(data)
    m_DropItem =  data.dropItem;
    m_Callback = data.callback;
end

function FightAwardUi.LoadAsset()
	if ui == nil then
        ResourceLoader.LoadAsset(path_res.ui, FightAwardUi.on_loaded);
	end
end

function FightAwardUi.DestoryUi()
	if(ui ~= nil) then
		m_index = 1;
		m_Callback = nil;
		card:DestroyUi();
		ui:set_active(false);
		ui = nil;
	end
end

function FightAwardUi.on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == path_res.ui then
		FightAwardUi.InitUi(asset_obj);
	end
end

function FightAwardUi.InitUi(obj)
    local _ui = asset_game_object.create(obj);
    _ui:set_parent(Root.get_root_ui_2d());
    _ui:set_local_scale(Utility.SetUIAdaptation());
    _ui:set_name("fight_award_ui");
    ui = _ui;
	
	btnNext = ngui.find_button(_ui,"fight_award_ui/sp");
	labName = ngui.find_label(_ui,"fight_award_ui/sp/centre_other/sp_bk/lab");
	
	animator = asset_game_object.find("fight_award_ui/sp");
	local go = asset_game_object.find("fight_award_ui/sp/centre_other/sp_bk/di/article");
	card = SmallCardUi:new({res_group=nil});
	card:SetParent(go);
    
	btnNext:set_on_click("FightAwardUi.on_next_click");
	FightAwardUi.PlayCartoon()
end

function FightAwardUi.PlayCartoon()
	if m_DropItem[m_index] then
		FightAwardUi.SetCardData(m_DropItem[m_index].id,m_DropItem[m_index].num);
	end
end

function FightAwardUi.SetCardData(id,num)
	local itemID   = id;
	local countNum = num or 1;
	local cardData;
	if(PropsEnum.IsRole(itemID))then
		cardData = CardHuman:new({number = itemID,level = 1})
	elseif(PropsEnum.IsEquip(itemID))then
		cardData = CardEquipment:new({number = itemID})
	elseif(PropsEnum.IsItem(itemID))then
		cardData = CardProp:new({number = itemID,count = countNum})
	else
		cardData = CardProp:new({number = itemID,count = countNum})
	end
	card:SetData(cardData);
	labName:set_text(cardData.name..' X'..tostring(countNum));
	animator:animator_play("ui_802_fight");
end

function FightAwardUi.on_next_click()
	m_index = m_index + 1;
	if m_DropItem[m_index] then
		FightAwardUi.PlayCartoon();
		return;
	end
	ui:set_active(false);
	if m_Callback then
		m_Callback();	
	end
	FightAwardUi.DestoryUi();
end

function FightAwardUi.callBack(obj,eventParm)
	if animator then
		animator:animator_play("ui_802_fight_null");
	end
end
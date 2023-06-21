msg_cards = msg_cards or {}
-- 临时变量, 是否使用本地数据
local isLocalData = true; 
------------------------------------------------[[服务器->客户端]]
local _gc_role_finish = true;
local _gc_equip_finish = true;
local _gc_prop_finish = true;
local _role_equip_finish_flag = 0;

-- 内部可以用this指向，简化代码
local this = msg_cards;

--[[增加了一个外部更改是否使用本地数据的接口]]
function msg_cards.SetCardsLocalFlag(flag)
    isLocalData = flag
end


-- TODO: kevin 把玩家和卡的初始化放入loading阶段完成
g_delay_process_card_msg = false;
g_first_hero_card_msg = {}
g_first_equip_card_msg = {}
g_first_item_card_msg = {}

function msg_cards.gc_role_cards_list(info, finish)
    if g_delay_process_card_msg then
        table.insert(g_first_hero_card_msg, {info=info, finish=finish});
        return;
    end

	if(_gc_role_finish == true)then
        g_dataCenter.package:ClearPackage(1);
	end
	for k,v in pairs(info) do
        local card = g_dataCenter.package:AddCard(ENUM.EPackageType.Hero,v);
        if card then
			app.log("增加角色卡片 dataid="..tostring(card.index))
            card.all_role_cards_index = PublicStruct.Role_Cards_Index
            PublicStruct.Role_Cards_Index = PublicStruct.Role_Cards_Index + 1
        end
	end
	_gc_role_finish = finish;
    if _gc_role_finish then
        uiManager:UpdateCurScene(ENUM.EUPDATEINFO.role);
    end
    --app.log("role......"..tostring(finish));
    if finish then
        _role_equip_finish_flag = _role_equip_finish_flag + 1
        msg_cards.check_role_equip_finish()
    end
end

function msg_cards.gc_equip_cards_list(info, finish)
    if g_delay_process_card_msg then
        table.insert(g_first_equip_card_msg, {info=info, finish = finish});
        return;
    end

	if(_gc_equip_finish == true)then
        g_dataCenter.package:ClearPackage(2);
	end
	for k,v in pairs(info) do
        g_dataCenter.package:AddCard(ENUM.EPackageType.Equipment,v);
--		app.log_warning("增加装备卡片 dataid="..tostring(v.index).." 归属角色dataid"..v.roleid)
	end
	_gc_equip_finish = finish;
    if _gc_equip_finish then
        uiManager:UpdateCurScene(ENUM.EUPDATEINFO.equip);
    end
    --app.log("equip......"..tostring(finish));
    if finish then
        _role_equip_finish_flag = _role_equip_finish_flag + 1
        msg_cards.check_role_equip_finish()
    end
end

--角色属性在背包所有数据到来过后需要重新计算一下属性
function msg_cards.check_role_equip_finish()
    if _role_equip_finish_flag == 2 then
        --app.log("计算属性")
        g_dataCenter.package:SetInitDataFlag(true)
        g_dataCenter.package:CalAllHeroProperty();
        _role_equip_finish_flag = 0
    end
end

function msg_cards.gc_item_cards_list(info, finish)
    if g_delay_process_card_msg then
        table.insert(g_first_item_card_msg, {info=info, finish=finish});
        return;
    end

	if(_gc_prop_finish == true)then
        g_dataCenter.package:ClearPackage(3);
	end
	for k,v in pairs(info) do
        g_dataCenter.package:AddCard(ENUM.EPackageType.Item,v);
		app.log_warning("增加道具卡片 dataid="..tostring(v.dataid))
	end
	_gc_prop_finish = finish;
    if _gc_prop_finish then
        uiManager:UpdateCurScene(ENUM.EUPDATEINFO.item );
        g_dataCenter.trainning:initUIData()
    end
end

function msg_cards.gc_change_equip_on_role_ret(ret,role_card_dataid,equip_card_dataid,equip_pos)
    if ret ~= MsgEnum.error_code.error_code_success then
        PublicFunc.GetErrorString(ret);
    else
        local human = g_dataCenter.package:find_card(1,role_card_dataid); 
        if human == nil then
            app.log("没有找到人物卡牌.card id:"..role_card_dataid);
            return ;
        end
        local equip = g_dataCenter.package:find_card(2,equip_card_dataid);
        if equip == nil then
            app.log("没有找到装备卡牌.Card id:"..equip_card_dataid);
            return ;
        end
        if equip.roleid and tonumber(equip.roleid) ~= 0 then
            app.log("该装备已经有人穿戴");
            local old_human = g_dataCenter.package:find_card(1,equip.roleid);
            old_human:TakeOffEquipByDataid(equip_card_dataid);
        end
        local old_equip_dataid = human:ChangeEquip(equip_pos, equip_card_dataid);
        if old_equip_dataid and tonumber(old_equip_dataid) ~= 0 then
            app.log("去掉旧装备拥有者属性");
            local old_equip = g_dataCenter.package:find_card(2,old_equip_dataid);
            old_equip:SetHaveRole(0);
        end
        equip:SetHaveRole(role_card_dataid);

        uiManager:UpdateCurScene();
        
        NoticeManager.Notice(ENUM.NoticeType.ChangeEquipSuccess)
    end

    PublicFunc.msg_dispatch(msg_cards.gc_change_equip_on_role_ret, ret, role_card_dataid,equip_card_dataid,equip_pos )
end

function msg_cards.gc_add_role_cards(info)
    local card = g_dataCenter.package:AddCard(ENUM.EPackageType.Hero,info);
    if card then
        card.all_role_cards_index = PublicStruct.Role_Cards_Index
        PublicStruct.Role_Cards_Index = PublicStruct.Role_Cards_Index + 1
		app.log_warning("增加角色卡片 dataid="..tostring(card.index))
    end
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Hero_Add);
end

function msg_cards.gc_soul_exchange_hero(dataid,ret)
    if ret == 0 then
        GLoading.Hide(GLoading.EType.msg);
        local cardInfo = g_dataCenter.package:find_card(1,dataid);
        EggGetHero.Start(cardInfo, true);
        PublicFunc.msg_dispatch(msg_cards.gc_soul_exchange_hero);
     else
        PublicFunc.GetErrorString(ret);
     end

end

function msg_cards.gc_add_equip_cards(info)
    g_dataCenter.package:AddCard(ENUM.EPackageType.Equipment,info);
--	app.log_warning("增加装备卡片 dataid="..tostring(info.index).." 归属角色dataid"..info.roleid)
    PublicFunc.msg_dispatch(msg_cards.gc_add_equip_cards)
end
function msg_cards.gc_add_item_cards(info)
    g_dataCenter.package:AddCard(ENUM.EPackageType.Item,info);
	app.log_warning("增加道具卡片 dataid="..tostring(info.dataid))
    PublicFunc.msg_dispatch(msg_cards.gc_add_item_cards, info)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Item_Add);
end

function msg_cards.gc_update_role_cards(info)
    local is_in_normal = g_dataCenter.player:IsTeam(info.dataid, ENUM.ETeamType.normal)
    local old_fight_value = nil
    local new_fight_value = nil
    if not is_in_normal then
        local old_card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, info.dataid)
        if old_card then
            old_fight_value = old_card:GetFightValue()
        end
    end
    g_dataCenter.package:UpdateCard(ENUM.EPackageType.Hero, info.dataid, info)
    if not is_in_normal then
        local new_card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, info.dataid)
        if new_card then
            new_fight_value = new_card:GetFightValue()
        end
        if new_fight_value and old_fight_value and old_fight_value ~= new_fight_value then
            FightValueChangeUI.ShowChange(ENUM.FightingType.Role, new_fight_value, old_fight_value)
        end
    end
    PublicFunc.msg_dispatch(msg_cards.gc_update_role_cards,info)
end

function msg_cards.gc_update_equip_cards(info)
    g_dataCenter.package:UpdateCard(ENUM.EPackageType.Equipment, info.dataid, info);
end

function msg_cards.gc_update_item_cards(info)
    g_dataCenter.package:UpdateCard(ENUM.EPackageType.Item, info.dataid, info);
    PublicFunc.msg_dispatch(msg_cards.gc_update_item_cards, info)
end

function msg_cards.gc_delete_role_cards(uuid)
    g_dataCenter.package:DeletCard(ENUM.EPackageType.Hero, uuid);
end
function msg_cards.gc_delete_equip_cards(uuid)
    g_dataCenter.package:DeletCard(ENUM.EPackageType.Equipment, uuid);
    PublicFunc.msg_dispatch(msg_cards.gc_delete_equip_cards, uuid)
end
function msg_cards.gc_delete_item_cards(uuid)
    g_dataCenter.package:DeletCard(ENUM.EPackageType.Item, uuid);
    PublicFunc.msg_dispatch(msg_cards.gc_delete_item_cards, uuid)
end


function msg_cards.gc_sell_cards( role_dataidlist,  equip_dataidlist,  item_dataidlist, ret)
    if ret ~= 0 then
        app.log("delete card error");
    end
    for k,v in pairs(role_dataidlist) do
        g_dataCenter.package:DeletCard(1,v,1);
    end
    for k,v in pairs(equip_dataidlist) do
        g_dataCenter.package:DeletCard(2,v,1);
    end
    for k,v in pairs(item_dataidlist) do
        g_dataCenter.package:DeletCard(3,v.dataid,v.count);
    end
    uiManager:UpdateCurScene();
end



function msg_cards.gc_takeoff_equip_on_role(role_card_dataid,equip_pos,ret)
    if ret ~= 0 then
        PublicFunc.GetErrorString(ret);
        return;
    end
	local role = g_dataCenter.package:find_card(1,role_card_dataid);
    local equip_id = role:TakeOffEquip(equip_pos);
    local equip = g_dataCenter.package:find_card(2,equip_id);
    equip:SetHaveRole(0);

    --FightValueChangeUI.ShowChange(new_fight_value, old_fight_value);

    uiManager:UpdateCurScene();
end

function msg_cards.gc_change_souls(result)
    --uiManager:UpdateCurScene(result);
    if result == MsgEnum.error_code.error_code_success then
        PublicFunc.msg_dispatch(msg_cards.gc_change_souls, result, awards);
    else
        app.log("xxxxx:msg_cards.gc_change_souls:"..tostring(result))
        PublicFunc.GetErrorString(result);
    end
end

function msg_cards.gc_equip_star_up(result)

    PublicFunc.unlock_send_msg(msg_cards.cg_equip_star_up, 'msg_cards.cg_equip_star_up')

	if result == MsgEnum.error_code.error_code_success then
        PublicFunc.msg_dispatch(msg_cards.gc_equip_star_up, result);
	else
		PublicFunc.GetErrorString(result, true);
	end
    --app.log('gc_equip_star_up ' .. tostring(result) .. ' ' .. table.tostring(awards))
end

function msg_cards.gc_equip_level_up(result, byfast, level, index, byAll)
    GLoading.Hide(GLoading.EType.msg)
	--if PublicFunc.GetErrorString(result) == false then
        --return
    --end
    PublicFunc.msg_dispatch(msg_cards.gc_equip_level_up, result, byfast, level, index, byAll)
end

function msg_cards.gc_special_equip_level_up_fast(result, equip_uuid, curLevel)
    GLoading.Hide(GLoading.EType.msg)
	if PublicFunc.GetErrorString(result) == false then
        return
    end
    PublicFunc.msg_dispatch(msg_cards.gc_special_equip_level_up_fast)
end

function msg_cards.gc_equip_rarity_up(result, index, byAll)
    GLoading.Hide(GLoading.EType.msg)
--	if PublicFunc.GetErrorString(result) == false then
--        return;
--    end
    PublicFunc.msg_dispatch(msg_cards.gc_equip_rarity_up, result, index, byAll)
end

function msg_cards.gc_add_neidan_point(result)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_add_neidan_point)
end

function msg_cards.gc_wash_neidan_point(result)
    GLoading.Hide(GLoading.EType.msg)
	if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_wash_neidan_point)
end

function msg_cards.gc_eat_exp(result)
    --GLoading.Hide(GLoading.EType.msg)
    PublicFunc.GetErrorString(result);
    -- 请求失败，界面升级经验数据回退
    PublicFunc.msg_dispatch(msg_cards.gc_eat_exp, result)
end

function msg_cards.gc_eat_exps(result)
    GLoading.Hide(GLoading.EType.msg)
	if PublicFunc.GetErrorString(result) == false then
        return
    end
    PublicFunc.msg_dispatch(msg_cards.gc_eat_exps)
end

function msg_cards.gc_breakthrough(role_card_dataid, stageIndex, upgradeLevel, cur_exp, result)
    GLoading.Hide(GLoading.EType.msg)
    PublicFunc.msg_dispatch(msg_cards.gc_breakthrough, role_card_dataid, stageIndex, upgradeLevel, cur_exp, result );
end

--function msg_cards.gc_breakthrough_return(result)
--    GLoading.Hide(GLoading.EType.msg)
--    if PublicFunc.GetErrorString(result) == false then
--        return;
--    end
--    PublicFunc.msg_dispatch(msg_cards.gc_breakthrough_return)
--end

--锻造结果
function msg_cards.gc_casting_ret(result, items)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_casting_ret, result, items)
end

--重铸 选择是否用新装备
function msg_cards.gc_casting_result_select(id, level)
    GLoading.Hide(GLoading.EType.msg)
    PublicFunc.msg_dispatch(msg_cards.gc_casting_result_select, id, level)
end

--重铸 选择结果
function msg_cards.gc_casting_result_select_ret(result, items)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_casting_result_select_ret, result, items)
end
-- 升级技能
function msg_cards.gc_skill_level_up_rst(result)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_skill_level_up_rst, result);
end

--英雄升星(count代表升几星)
function msg_cards.gc_hero_star_up(result)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        g_SingleLockUI.Hide()
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_hero_star_up, result);
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Hero_StarUp);
end

--[[英雄升品返回]]
function msg_cards.gc_hero_rarity_up_ret(result, role_dataid)
    GLoading.Hide(GLoading.EType.msg)
    if PublicFunc.GetErrorString(result) == false then
        return;
    end
    PublicFunc.msg_dispatch(msg_cards.gc_hero_rarity_up_ret, result)
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Hero_RarityUp);
end

---------------------------------------------------------------------[[客户端->服务器]]
--请求卡牌列表
--type 0 代表全部列表 1 角色卡牌 2 装备卡牌 3 道具卡牌
function msg_cards.cg_cards_list(socket,card_type)
    if isLocalData then
        gc_package_data.cg();
    else
        if not socket then return end
        nmsg_cards.cg_cards_list(socket,card_type);
    end
end

--申请换装
function msg_cards.cg_change_equip_on_role(socket,role_card_dataid,equip_card_dataid,equip_pos)
    if isLocalData then
        msg_cards.gc_change_equip_on_role_ret(MsgEnum.error_code.error_code_success,role_card_dataid,equip_card_dataid,equip_pos)
    else
        app.log_warning("人物:"..role_card_dataid.." 装备："..equip_card_dataid.." 位置："..tostring(equip_pos));
        if not socket then return end
        nmsg_cards.cg_change_equip_on_role(socket,role_card_dataid,equip_card_dataid,equip_pos);
    end
end

-- 出售道具
function msg_cards.cg_sell_cards(socket,role_dataidlist,equip_dataidlist,item_dataidlist)
    if not socket then return end
    nmsg_cards.cg_sell_cards(socket,role_dataidlist,equip_dataidlist,item_dataidlist);
end

function msg_cards.cg_takeoff_equip_on_role(socket,role_card_dataid,equip_pos)
    nmsg_cards.cg_takeoff_equip_on_role(socket,role_card_dataid,equip_pos)
end
--通灵之魂兑换英魂
function msg_cards.cg_change_souls(socket, uuid, count)
    if isLocalData then
        msg_cards.gc_change_souls(MsgEnum.error_code.error_code_success);
    else
        if not socket then return end
        nmsg_cards.cg_change_souls(socket,uuid,count)
    end
end

--[[
    装备升级(byfast 是否是一键升级 0不是，1是；useitem 特殊装备升级的填充材料  )
]]
function msg_cards.cg_equip_level_up(equip_uuid, byfast, useItem, isAll)
    GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _equip_uuid = "local equip_uuid = nil\n"
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, equip_uuid)
        if card then
            _equip_uuid = _equip_uuid.."\
            for k,v in pairs(g_all_equip_cards) do\
                if v.number == "..tostring(card.number).." then\
                    equip_uuid = v.dataid\
                    break\
                end\
            end\n"
        end
        local _useItem = "\
        local useItem = {}\
        local card = nil\n"
        for i=1, #useItem do
            _useItem = _useItem.."\
            useItem["..i.."] = {}\
            useItem["..i.."].id = "..tostring(useItem[i].id).."\
            useItem["..i.."].count = "..tostring(useItem[i].count).."\n"
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Item, useItem[i].dataid)
            if card then
                _useItem = _useItem.."\
                card = nil\
                for k,v in pairs(g_all_item_cards) do\
                    if v.number == "..tostring(card.number).." then\
                        card = v\
                        break\
                    end\
                end\
                useItem["..i.."].dataid = card.dataid\n"
            end
        end
        PublicFunc.RecordingScript(_equip_uuid.._useItem.."nmsg_cards.cg_equip_level_up(robot_s, equip_uuid, "..tostring(byfast)..", useItem, "..tostring(isAll)..")")
    end
	nmsg_cards.cg_equip_level_up(Socket.socketServer, equip_uuid, byfast, useItem, isAll)
end

function msg_cards.cg_special_equip_level_up_fast(equip_uuid, targetLevel, useExpItem)
    GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
    nmsg_cards.cg_special_equip_level_up_fast(Socket.socketServer, equip_uuid, targetLevel, useExpItem)
end

--[[装备升品]]
function msg_cards.cg_equip_rarity_up(equip_uuid, isAll)
    GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _equip_uuid = "local equip_uuid = nil\n"
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, equip_uuid)
        if card then
            _equip_uuid = _equip_uuid.."\
            for k,v in pairs(g_all_equip_cards) do\
                if v.number == "..tostring(card.number).." then\
                    equip_uuid = v.dataid\
                    break\
                end\
            end\n"
        end
        PublicFunc.RecordingScript(_equip_uuid.."nmsg_cards.cg_equip_rarity_up(robot_s, equip_uuid, "..tostring(isAll)..")")
    end
	nmsg_cards.cg_equip_rarity_up(Socket.socketServer, equip_uuid, isAll)
end


--装备升星
function msg_cards.cg_equip_star_up(equip_uuid)
	if isLocalData then
		app.log("本地数据，暂时没做");
	else
        --if not Socket.socketServer then return end
        if not PublicFunc.lock_send_msg(msg_cards.cg_equip_star_up, 'msg_cards.cg_equip_star_up') then return end
        
		nmsg_cards.cg_equip_star_up(Socket.socketServer, equip_uuid);
	end
end

function msg_cards.cg_star_down(equip_uuid)
    --if not Socket.socketServer then return end
    if not PublicFunc.lock_send_msg(msg_cards.cg_star_down, 'msg_cards.cg_star_down') then return end

    --app.log("msg_cards.cg_star_down " .. debug.traceback());

    nmsg_cards.cg_star_down(Socket.socketServer, equip_uuid)
end

function msg_cards.gc_star_down(result, awards)
    PublicFunc.unlock_send_msg(msg_cards.cg_star_down, 'msg_cards.cg_star_down') 

    if result == MsgEnum.error_code.error_code_success then
        PublicFunc.msg_dispatch(msg_cards.gc_star_down, result, awards)
    else
        PublicFunc.GetErrorString(result, true);
    end

    --app.log('gc_star_down ' .. tostring(result) .. ' ' .. table.tostring(awards))
end

-- 添加细胞强化属性点
function msg_cards.cg_add_neidan_point(socket, uuid, points)
    GLoading.Show(GLoading.EType.msg);
	if isLocalData then
		msg_cards.gc_add_neidan_point(MsgEnum.error_code.error_code_success);
	else
        if not socket then return end
		nmsg_cards.cg_add_neidan_point(socket, uuid, points);
	end
end

-- 细胞强化属性洗点重置
function msg_cards.cg_wash_neidan_point(socket, uuid)
    GLoading.Show(GLoading.EType.msg);
	if isLocalData then
		msg_cards.gc_wash_neidan_point(MsgEnum.error_code.error_code_success);
	else
        if not socket then return end
		nmsg_cards.cg_wash_neidan_point(socket, uuid);
	end
end

-- 吃药升级英雄经验值
function msg_cards.cg_eat_exp(socket, uuid, itemId, count)
    --GLoading.Show(GLoading.EType.msg);
	if isLocalData then
		msg_cards.gc_eat_exp(MsgEnum.error_code.error_code_success);
	else
        if not socket then return end
        if AppConfig.script_recording then
            local _dataid = ""
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, uuid)
            if card then
                _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
            end
            PublicFunc.RecordingScript("nmsg_cards.cg_eat_exp(robot_s, "..tostring(_dataid)..", "..tostring(itemId)..", "..tostring(count)..")")
        end
		nmsg_cards.cg_eat_exp(socket, uuid, itemId, count);
	end
end

function msg_cards.cg_eat_exps(uuid, targetLevel, item_cards)
    GLoading.Show(GLoading.EType.msg)
	--if not Socket.socketServer then return end
    nmsg_cards.cg_eat_exps(Socket.socketServer, uuid, targetLevel, item_cards)
end

function msg_cards.cg_equip_composite(equips, compositeCallback)
    nmsg_cards._compositeCallback = compositeCallback
    --if not Socket.socketServer then return end
    nmsg_cards.cg_equip_composite(Socket.socketServer, equips);
end

function msg_cards.gc_equip_composite(result, equips)
	if nmsg_cards._compositeCallback ~= nil and _G[nmsg_cards._compositeCallback] ~= nil then
        _G[nmsg_cards._compositeCallback](result, equips)
    end
end

-- 突破升级，2016-7-13，fy重新
function msg_cards.cg_breakthrough(socket, role_dataid, itemList, breakthrough_stage)
    GLoading.Show(GLoading.EType.msg);
    nmsg_cards.cg_breakthrough( socket, role_dataid, itemList, breakthrough_stage );
end

-- 突破返还,重新制作已经没有突破返还的说法了fy
--function msg_cards.cg_breakthrough_return(socket, role_uuid)
--	GLoading.Show(GLoading.EType.msg);
--	if isLocalData then
--		msg_cards.cg_breakthrough_return(MsgEnum.error_code.error_code_success);
--	else
--        if not socket then return end
--		nmsg_cards.cg_breakthrough_return(socket, role_uuid);
--	end
--end

--锻造  casting_drawing:图样  items：所需材料  
-- {
--     string dataid;
--     int id;
--     int count;
-- }
function msg_cards.cg_casting(casting_drawing, items)
    GLoading.Show(GLoading.EType.msg);
    if isLocalData then
        app.log("msg_cards.cg_casting暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_cards.cg_casting(Socket.socketServer, casting_drawing, items);
    end
end

--玩家选择重铸结果：param: select 1 保留旧装备, 2 要新装备
function msg_cards.cg_casting_result_select(select)
    GLoading.Show(GLoading.EType.msg);
    if isLocalData then
        app.log("msg_cards.cg_casting_result_select暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_cards.cg_casting_result_select(Socket.socketServer, select);
    end
end

function msg_cards.cg_soul_exchange_hero(heronumber)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        PublicFunc.RecordingScript("nmsg_cards.cg_soul_exchange_hero(robot_s, "..tostring(heronumber)..")")
    end
    nmsg_cards.cg_soul_exchange_hero(Socket.socketServer, heronumber);
end
-- 升级技能
-- param: up_all true一键升级， false升一级
function msg_cards.cg_skill_level_up(role_dataid, skill_id )
    GLoading.Show(GLoading.EType.msg);
    if isLocalData then
        app.log("msg_cards.cg_hero_star_up暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        if AppConfig.script_recording then
            local _dataid = "nil"
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
            if card then
                _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
            end
            PublicFunc.RecordingScript("nmsg_cards.cg_skill_level_up(robot_s, "..tostring(_dataid)..", "..tostring(skill_id)..")")
        end
        nmsg_cards.cg_skill_level_up(Socket.socketServer, role_dataid, skill_id);
    end
end
function msg_cards.cg_passive_property_level_up(role_dataid, id)
    GLoading.Show(GLoading.EType.msg);
    if isLocalData then
        app.log("msg_cards.cg_passive_property_level_up暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_cards.cg_passive_property_level_up(Socket.socketServer, role_dataid, id);
    end
end
function msg_cards.cg_halo_property_level_up(role_dataid)
    GLoading.Show(GLoading.EType.msg);
    if isLocalData then
        app.log("msg_cards.cg_passive_property_level_up暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        nmsg_cards.cg_halo_property_level_up(Socket.socketServer, role_dataid);
    end
end

--英雄升星(count代表升几星)
function msg_cards.cg_hero_star_up(role_dataid, count)
    if isLocalData then
        app.log("msg_cards.cg_hero_star_up暂时没做单机模式");
    else
        --if not Socket.socketServer then return end
        GLoading.Show(GLoading.EType.msg);
        g_SingleLockUI.Show()

        if AppConfig.script_recording then
            local _dataid = ""
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
            if card then
                _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
            end
            PublicFunc.RecordingScript("nmsg_cards.cg_hero_star_up(robot_s, ".._dataid..", "..tostring(count)..")")
        end
        nmsg_cards.cg_hero_star_up(Socket.socketServer, role_dataid, count);
    end
end

--[[
    英雄升品
    string role_dataid, list<net_summary_item> materials
]]
function msg_cards.cg_hero_rarity_up(role_dataid, materials)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg);
    if AppConfig.script_recording then
        local _dataid = ""
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
        if card then
            _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
        end
        local _materials = "\
        local materials = {}\
        local card = nil\n"
        for i=1, #materials do
            _materials = _materials.."\
            materials["..i.."] = {}\
            materials["..i.."].id = "..tostring(materials[i].id).."\
            materials["..i.."].count = "..tostring(materials[i].count).."\n"
            local card = g_dataCenter.package:find_card(ENUM.EPackageType.Item, materials[i].dataid)
            if card then
                _materials = _materials.."\
                card = nil\
                for k,v in pairs(g_all_item_cards) do\
                    if v.number == "..tostring(card.number).." then\
                        card = v\
                        break\
                    end\
                end\
                materials["..i.."].dataid = card.dataid\n"
            end
        end
        PublicFunc.RecordingScript(_materials.."nmsg_cards.cg_hero_rarity_up(robot_s, ".._dataid..", materials)")
    end
    nmsg_cards.cg_hero_rarity_up(Socket.socketServer, role_dataid, materials);
end

--解锁属性克制
function msg_cards.cg_restrain_unlock(role_dataid, id)
    --if not Socket.socketServer then return end

    nmsg_cards.cg_restrain_unlock(Socket.socketServer, role_dataid, id)
end
function msg_cards.gc_restrain_unlock(result, role_dataid, id)
    -- app.log("zzc gc_restrain_unlock "..table.tostring({result, role_dataid, id}))
    if PublicFunc.GetErrorString(result) then
        local roleInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
        if roleInfo then
            roleInfo:UnlockRestrainValid(id)
        end
        PublicFunc.msg_dispatch(msg_cards.gc_restrain_unlock, role_dataid, id)
    end
end

--属性克制升级
function msg_cards.cg_restrain_upgrade(role_dataid, id)
    --if not Socket.socketServer then return end
    if not PublicFunc.lock_send_msg(msg_cards.cg_restrain_upgrade, tostring(role_dataid)) then return end

    nmsg_cards.cg_restrain_upgrade(Socket.socketServer, role_dataid, id)
end
function msg_cards.gc_restrain_upgrade(result, role_dataid, id)
    -- app.log("zzc gc_restrain_upgrade "..table.tostring({result, role_dataid, id}))
    PublicFunc.unlock_send_msg(msg_cards.cg_restrain_upgrade, tostring(role_dataid))
    if PublicFunc.GetErrorString(result) then
        -- local roleInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
        -- if roleInfo then
            --此处更新不走gc_update_role_cards消息 --又改成走更新gc_update_role_cards消息了(⊙﹏⊙)b
            -- roleInfo:UpgradeRestrainValid(id)
        -- end
        PublicFunc.msg_dispatch(msg_cards.gc_restrain_upgrade, role_dataid, id)
    end
end

--重置属性克制 id 0重置所有 非0为具体点
function msg_cards.cg_restrain_reset(role_dataid, id)
    --if not Socket.socketServer then return end

    nmsg_cards.cg_restrain_reset(Socket.socketServer, role_dataid, id)
end
function msg_cards.gc_restrain_reset(result, role_dataid, id, costBack)
    -- app.log("zzc gc_restrain_reset "..table.tostring({result, role_dataid, id, costBack}))
    if PublicFunc.GetErrorString(result) then
        local roleInfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
        if roleInfo then
            --此处更新不走gc_update_role_cards消息
            roleInfo:ResetRestrainValid(id)
        end
        PublicFunc.msg_dispatch(msg_cards.gc_restrain_reset, role_dataid, id, costBack)
    end
end


function msg_cards.cg_neidan_upgrade(role_dataid,ntype)
    if not Socket.socketServer  then return end
    nmsg_cards.cg_neidan_upgrade(Socket.socketServer,role_dataid,ntype)
end

function msg_cards.gc_neidan_upgrade(result)
    local isSuccess,errorStr = PublicFunc.GetErrorString(result,true)
    if isSuccess then
         PublicFunc.msg_dispatch(msg_cards.gc_neidan_upgrade,result)   
    else
        app.log('neidan_upgrade error:' .. errorStr)
    end
end


function msg_cards.cg_item_sell(dataId,count)
    if not Socket.socketServer  then return end
    nmsg_cards.cg_item_sell(Socket.socketServer,dataId,count)
end


function msg_cards.gc_item_sell(result,price)
    --app.log("msg_cards.gc_sell_item result="..tostring(result).." price="..price)
    local isSuccess,errorStr = PublicFunc.GetErrorString(result,true)
    if isSuccess then
        PublicFunc.msg_dispatch(msg_cards.gc_item_sell,result,price)
    else
        app.log('gc_item_sell error:' .. errorStr)
    end
end

function msg_cards.cg_item_exchange(dataId,count)
    if not Socket.socketServer  then return end
    --app.log(string.format("nmsg_cards.cg_item_exchange dataId=%s count=%s",tostring(dataId),tostring(count)))
    nmsg_cards.cg_item_exchange(Socket.socketServer,dataId,count)
end

--发送请求激活英雄图鉴
function msg_cards.cg_illumstration_active(dataId)
    if not Socket.socketServer  then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_cards.cg_illumstration_active(Socket.socketServer,dataId)
end

--发送提升英雄图鉴
function msg_cards.cg_illumstration_update(dataId)
    if not Socket.socketServer  then return end
    GLoading.Show(GLoading.EType.msg);
    nmsg_cards.cg_illumstration_update(Socket.socketServer,dataId)
end

function msg_cards.gc_item_exchange(result,items)
    --[[
    {
      1=table: 0000000056103390{
        id=20000001
        dataid=''
        count=1
      }
    }
    ]]
    --app.log("msg_cards.gc_item_exchange result="..tostring(result).." items="..table.tostring(items))
    local isSuccess,errorStr = PublicFunc.GetErrorString(result,true)
    if isSuccess then
        local new_items = {}
        for k,v in pairs(items) do
            if v.id ~= 0 then
                local n_item = nil
                for nk,nv in pairs(new_items) do
                    if nv.id == v.id then
                        n_item = nv
                        n_item.count =  n_item.count+v.count          
                        new_items[nk] =     n_item     
                        break
                    end
                end
                if n_item == nil then
                    table.insert(new_items,v)
                end
                -- local n_item = new_items[v.id]
                -- if n_item then
                --     new_items[v.id].count = n_item.count + v.count
                -- else
                --     new_items[v.id] = v
                -- end
            end
      

        end
        --app.log("msg_cards.gc_item_exchange result="..tostring(result).." items="..table.tostring(new_items))
            PublicFunc.msg_dispatch(msg_cards.gc_item_sell,result,new_items)
    else
            app.log('gc_item_exchange error:' .. errorStr)
    end
end

function msg_cards.gc_illumstration_active(dataid,illum_number,ret)
    PublicFunc.msg_dispatch(msg_cards.gc_illumstration_active,dataid,illum_number,ret);
    GLoading.Hide(GLoading.EType.msg);
end

function msg_cards.gc_illumstration_update(dataid,illum_number,ret)
    PublicFunc.msg_dispatch(msg_cards.gc_illumstration_update,dataid,illum_number,ret);
    GLoading.Hide(GLoading.EType.msg);
end

function msg_cards.cg_use_training_hall_item(role_dataid,item_dataid,number)
    --do return end
    --if not Socket.socketServer then return end
        nmsg_cards.cg_use_training_hall_item(Socket.socketServer,role_dataid,item_dataid,number);
end

function msg_cards.gc_use_training_hall_item(result,role_dataid)
    local show = PublicFunc.GetErrorString(result);
    if show then
        --app.log("user Item updata###########################"..tostring(role_dataid))
        PublicFunc.msg_dispatch(msg_cards.gc_use_training_hall_item,role_dataid)
    end
end

function msg_cards.cg_training_hall_hero_advance(role_dataid)
     --if not Socket.socketServer then return end
        nmsg_cards.cg_training_hall_hero_advance(Socket.socketServer,role_dataid);
end

function msg_cards.gc_training_hall_hero_advance(result,role_dataid)
    local show = PublicFunc.GetErrorString(result);
    if show then
        --app.log("Lvl hero###########################"..tostring(role_dataid))
        
        PublicFunc.msg_dispatch(msg_cards.gc_training_hall_hero_advance,role_dataid)
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_daren);
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.Emain_BattleTeam_trainning_info_daren)
    end
end

function msg_cards.gc_change_role_card_property(role_dataid, property, show_fight_value)
--    local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid);
--    if role and role.property then
--         local addFightValue = 0
--         for i=1, #property do
--             local oldValue = role.property[property[i].id + ENUM.min_property_id]
--             oldValue = oldValue or 0
--             role.property[property[i].id + ENUM.min_property_id] = property[i].value
--             local ratio = ConfigManager.Get(EConfigIndex.t_fight_value, 2)[ENUM.EHeroAttributeKey [property[i].id + ENUM.min_property_id]]
--             if ratio then
--                 addFightValue = addFightValue + ((property[i].value-oldValue) * ratio)
--             end
--         end
--         role:UpdateFightValue()
--         if addFightValue ~= 0 and show_fight_value then
--             local new_fight_value = role:GetFightValue()
--             FightValueChangeUI.ShowChange(ENUM.FightingType.Role, new_fight_value, new_fight_value-addFightValue)
--         end
--    end
--    PublicFunc.msg_dispatch(msg_cards.gc_change_role_card_property, role_dataid, property)
end

function msg_cards.cg_set_card_play_method_cur_hp(role_dataid, type, hp)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _dataid = ""
        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid)
        if card then
            _dataid = _dataid.."g_all_role_cards["..tostring(card.all_role_cards_index).."].dataid"
        end
        PublicFunc.RecordingScript("nmsg_cards.cg_set_card_play_method_cur_hp(robot_s, "..tostring(_dataid)..", "..tostring(type)..", "..tostring(hp)..")")
    end
    nmsg_cards.cg_set_card_play_method_cur_hp(Socket.socketServer,role_dataid, type, hp);
end

function msg_cards.gc_sync_card_play_method_cur_hp(role_dataid, type, hp)
    local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid);
    if role then
        role:SetPlayMethodCurHP(type, hp, false)
    end
end

function msg_cards.gc_show_role_card_fight_value_change(role_dataid, new_fight_value)
    --[[local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid);
    if role then
        local old_value = role:GetFightValue()
        FightValueChangeUI.ShowChange(ENUM.FightingType.Role, new_fight_value, old_value)
    end
    PublicFunc.msg_dispatch(msg_cards.gc_show_role_card_fight_value_change)]]
end

function msg_cards.gc_update_role_card_fight_value(role_dataid, fight_value)
    --[[local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, role_dataid);
    if role then
        role.fight_value = fight_value
    end
    PublicFunc.msg_dispatch(msg_cards.gc_update_role_card_fight_value)]]
end

function msg_cards.gc_update_role_cards_property(cards)
    for i=1, #cards do
        local role = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, cards[i].dataid);
        if role and role.property then
            for k, v in pairs(ENUM.EHeroAttribute) do
                role.property[v] = 0;
            end
            for j=1, #cards[i].property do
                role.property[cards[i].property[j].id + ENUM.min_property_id] = cards[i].property[j].value
            end
            role.fight_value = cards[i].fight_value
        end
    end
end

function msg_cards.cg_one_key_skill_level(role_dataid, skills)
    --if not Socket.socketServer then return end;
    nmsg_cards.cg_one_key_skill_level(Socket.socketServer, role_dataid, skills)
end

function msg_cards.gc_one_key_skill_level(result, role_dataid, skills)
    PublicFunc.msg_dispatch(msg_cards.gc_one_key_skill_level, result, role_dataid, skills)
    uiManager:UpdateCurScene();
end
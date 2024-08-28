PropsEnum = {}

function PropsEnum.IsExp(id)
	if id == IdConfig.Exp then
		return true;
	else
		return false;
	end
end
function PropsEnum.IsHeroExp(id)
	if id == IdConfig.HeroExp then
		return true;
	else
		return false;
	end
end
function PropsEnum.IsGold(id)
	if not id then
		app.log('调用PropsEnum.IsGold id 是空的，调用堆栈：'..debug.traceback())
	end
	if id == IdConfig.Gold then
		return true;
	else
		return false;
	end
end
 

function PropsEnum.IsImprovedGems(id)
    if not id then
        app.log('调用PropsEnum.IsImprovedGems id 是空的，调用堆栈：'..debug.traceback())
    end

    if id == IdConfig.ImprovedGemsA or id == IdConfig.ImprovedGemsS or id == IdConfig.ImprovedGemsSS then
        return true;
    else
        return false
    end
end
function PropsEnum.IsRole(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsRole id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.RoleMin = tonumber(IdConfig.RoleMin)
	if IdConfig.RoleMin == nil then
		IdConfig.RoleMin = 1
	end

	IdConfig.RoleMax = tonumber(IdConfig.RoleMax)
	if IdConfig.RoleMax == nil then
		IdConfig.RoleMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.RoleMin and id <= IdConfig.RoleMax then
		return true;
	else
		return false;
	end
end

function PropsEnum.IsRoleSoul(id)
	if id and type(id) == "number" then

		IdConfig.RoleSoulMin = tonumber(IdConfig.RoleSoulMin)
		if IdConfig.RoleSoulMin == nil then
			IdConfig.RoleSoulMin = 1
		end
	
		IdConfig.RoleSoulMax = tonumber(IdConfig.RoleSoulMax)
		if IdConfig.RoleSoulMax == nil then
			IdConfig.RoleSoulMax = 3
		end

		return id >= IdConfig.RoleSoulMin and id <= IdConfig.RoleSoulMax 
	end
	return false
end

function PropsEnum.IsSpecMonster(id)
   	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsSpecMonster id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.SpecMonsterMin = tonumber(IdConfig.SpecMonsterMin)
	if IdConfig.SpecMonsterMin == nil then
		IdConfig.SpecMonsterMin = 1
	end

	IdConfig.SpecMonsterMax = tonumber(IdConfig.SpecMonsterMax)
	if IdConfig.SpecMonsterMax == nil then
		IdConfig.SpecMonsterMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.SpecMonsterMin and id <= IdConfig.SpecMonsterMax then
		return true;
	else
		return false;
	end
end

function PropsEnum.IsMonster(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsMonster id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.MonsterMin = tonumber(IdConfig.MonsterMin)
	if IdConfig.MonsterMin == nil then
		IdConfig.MonsterMin = 1
	end

	IdConfig.MonsterMax = tonumber(IdConfig.MonsterMax)
	if IdConfig.MonsterMax == nil then
		IdConfig.MonsterMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.MonsterMin and id <= IdConfig.MonsterMax  then
		return true;
	else
		return false;
	end
end

function PropsEnum.IsNPC(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsNPC id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.NPCMin = tonumber(IdConfig.NPCMin)
	if IdConfig.NPCMin == nil then
		IdConfig.NPCMin = 1
	end

	IdConfig.NPCMax = tonumber(IdConfig.NPCMax)
	if IdConfig.NPCMax == nil then
		IdConfig.NPCMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.NPCMin and id <= IdConfig.NPCMax then
		return true;
	else
		return false;
	end
end

function PropsEnum.IsMMONPC(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsNPC id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.MMONPCMin = tonumber(IdConfig.MMONPCMin)
	if IdConfig.MMONPCMin == nil then
		IdConfig.MMONPCMin = 1
	end

	IdConfig.MMONPCMax = tonumber(IdConfig.MMONPCMax)
	if IdConfig.MMONPCMax == nil then
		IdConfig.MMONPCMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.MMONPCMin and id <= IdConfig.MMONPCMax then
		return true;
	else
		return false;
	end
end

function PropsEnum.IsEquip(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsEquip id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.EquipMin = tonumber(IdConfig.EquipMin)
	if IdConfig.EquipMin == nil then
		IdConfig.EquipMin = 1
	end

	IdConfig.EquipMax = tonumber(IdConfig.EquipMax)
	if IdConfig.EquipMax == nil then
		IdConfig.EquipMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.EquipMin and id <= IdConfig.EquipMax then
		return true;
	else
		return false;
	end
end
function PropsEnum.IsItem(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsItem id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.ItemMin = tonumber(IdConfig.ItemMin)
	if IdConfig.ItemMin == nil then
		IdConfig.ItemMin = 1
	end

	IdConfig.ItemMax = tonumber(IdConfig.ItemMax)
	if IdConfig.ItemMax == nil then
		IdConfig.ItemMax = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id >= IdConfig.ItemMin and id <= IdConfig.ItemMax then
		return true;
	else
		return false;
	end
end
function PropsEnum.IsVaria(id)
	if type(id) ~= "number" then
		app.log('调用PropsEnum.IsVaria id 是空的，调用堆栈：'..debug.traceback())
	end
    if id == nil then
        return false
    end

	IdConfig.MaxVaria = tonumber(IdConfig.MaxVaria)
	if IdConfig.MaxVaria == nil then
		IdConfig.MaxVaria = 3
	end

	id = tonumber(id)
	if id == nil then
		id = 1
	end

	if id < IdConfig.MaxVaria and id > 0 then
		return true;
	else
		return false;
	end
end
function PropsEnum.GetItemType(id)
    if type(id) ~= "number" then
        app.log('调用PropsEnum.GetItemType id 是空的，调用堆栈：'..debug.traceback())
    end

    if PropsEnum.IsItem(id) then
        return ENUM.EPackageType.Item
    elseif PropsEnum.IsEquip(id) then
        return ENUM.EPackageType.Equipment
    elseif PropsEnum.IsRole(id) then
        return ENUM.EPackageType.Hero
    end

    return 0
end

-- 获取玩家身上某种道具的数量
function PropsEnum.GetValue(number)
	if number == IdConfig.Exp then
		return tonumber(g_dataCenter.player.exp);
	elseif number == IdConfig.Gold then
		return tonumber(g_dataCenter.player.gold);
	elseif number == IdConfig.Crystal then
		return tonumber(g_dataCenter.player.crystal);
	elseif number == IdConfig.RedCrystal then
		return tonumber(g_dataCenter.player.red_crystal);
	elseif number == IdConfig.Ap then
		return tonumber(g_dataCenter.player.ap);
	elseif number == IdConfig.Bp then
		return g_dataCenter.player.bp;
	elseif number == IdConfig.HeroTrialTicket then
		return g_dataCenter.player.heroTrialTicket;
	elseif number == IdConfig.ChurchBotCoin then
		return tonumber(g_dataCenter.player.churchVigor)
	elseif PropsEnum.IsRole(number) then
		return g_dataCenter.package:find_count(ENUM.EPackageType.Hero, number);
	elseif PropsEnum.IsEquip(number) then
		return g_dataCenter.package:find_count(ENUM.EPackageType.Equipment, number);
	elseif PropsEnum.IsItem(number) then
		return g_dataCenter.package:find_count(ENUM.EPackageType.Item, number);
	end
end
-- 获取唯一ID与number获取制定道具信息
function PropsEnum.GetInfo(dataId, number)
	if PropsEnum.IsRole(number) then
		return g_dataCenter.package:find_card(ENUM.EPackageType.Hero, dataId);
	elseif PropsEnum.IsEquip(number) then
		return g_dataCenter.package:find_card(ENUM.EPackageType.Equipment, dataId);
	elseif PropsEnum.IsItem(number) then
		return g_dataCenter.package:find_card(ENUM.EPackageType.Item, dataId);
	end
end

-- 获取一个显示编号
function PropsEnum.GetShowNumber(number)
	return 0;
end
-- 获取某个编号新旧之间的差值
function PropsEnum.GetDiffNumber(number, param)
	if number == IdConfig.Exp then
		return g_dataCenter.player:GetDiffExp();
	elseif number == IdConfig.HeroExp then
		return g_dataCenter.player:GetDiffHeroExp(param);
	end
end

-- 返回某物品的名字
function PropsEnum.GetName(number)
	if PropsEnum.IsRole(number) then
		return ConfigHelper.GetRole(number).name;
	elseif PropsEnum.IsEquip(number) then
		return ConfigManager.Get(EConfigIndex.t_equipment,number).name;
	elseif PropsEnum.IsItem(number) or PropsEnum.IsVaria(number) then
		return ConfigManager.Get(EConfigIndex.t_item,number).name;
	else
		return ""
	end
end
--金币不足的检测提示
function PropsEnum.CheckGold(count, showDlg)
	if PropsEnum.GetValue(IdConfig.Gold) < count then
		if showDlg then
			local func = function ()
				uiManager:PushUi(EUI.GoldExchangeUI);
			end
			HintUI.SetAndShow(EHintUiType.zero, "你的金币不够",{func = func});
		end
		return false;
	end
	return true;
end
--获取配置表
function PropsEnum.GetConfig(id)
	if PropsEnum.IsRole(id) then
		return ConfigHelper.GetRole(id)
    elseif PropsEnum.IsMonster(id) then
		return ConfigManager.Get(EConfigIndex.t_monster_property, id);
	elseif PropsEnum.IsEquip(id) then
		return ConfigManager.Get(EConfigIndex.t_equipment, id);
	elseif PropsEnum.IsItem(id) or PropsEnum.IsVaria(id) then
		return ConfigManager.Get(EConfigIndex.t_item, id);
    elseif PropsEnum.IsNPC(id) then
		return ConfigManager.Get(EConfigIndex.t_npc, id);
    end
end
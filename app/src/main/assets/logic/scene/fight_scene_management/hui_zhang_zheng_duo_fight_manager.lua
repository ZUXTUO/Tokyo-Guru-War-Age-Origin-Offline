--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2015/8/27
-- Time: 10:26
-- To change this template use File | Settings | File Templates.
--


HuiZhangZhengDuoFightManager = Class("HuiZhangZhengDuoFightManager", FightManager)

local _bout_sp_list = {
	[1] = "huihe1";--[[第一回合 SP名字]]
	[2] = "huihe2";--[[第二回合 SP名字]]
	[3] = "huihe3";--[[第三回合 SP名字]]
};

function HuiZhangZhengDuoFightManager:InitData()
	FightManager.InitData(self);
end

function HuiZhangZhengDuoFightManager:unregistFunc()
	for k,v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v);
		end
	end
end

function HuiZhangZhengDuoFightManager:LoadUI()
	FightManager.LoadUI(self);
	if(self.ui == nil)then
		self.bindfunc = {};
		self.bindfunc["on_loaded"] = Utility.bind_callback(self, HuiZhangZhengDuoFightManager.on_loaded);--[[UI加载回调]]
		self.bindfunc["HideUI"] = Utility.bind_callback(self, HuiZhangZhengDuoFightManager.HideUI);--[[消失回调]]
        ResourceLoader.LoadAsset("assetbundles/prefabs/ui/fight/ui_fight_bout.assetbundle", self.bindfunc["on_loaded"], nil)
	end
end

function HuiZhangZhengDuoFightManager:on_loaded(pid, filepath, asset_obj, error_info)
	self.ui = asset_game_object.create(asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_fight_bout");
	self.bout_ui = ngui.find_sprite(self.ui, "heng/sp_di/sp");
	self:ShowUI(1);
end

function HuiZhangZhengDuoFightManager:ShowUI(n_list)
	if self.ui ~= nil then
		local index_temp = _bout_sp_list[n_list];
		if index_temp ~= nil then
			self.bout_ui:set_sprite_name(index_temp);--[[默认为第一回合]]
			self.ui:set_active(true);
			timer.create(self.bindfunc["HideUI"], 800, 1);
		end
	end
end

function HuiZhangZhengDuoFightManager:HideUI()
	if self.ui ~= nil then
		self.ui:set_active(false);
	end
end

function HuiZhangZhengDuoFightManager:InitInstance()
	FightManager:InitInstance()
	return HuiZhangZhengDuoFightManager;
end

function HuiZhangZhengDuoFightManager:Restart()
	app.log("重置");
	FightManager.Restart(self);
end

function HuiZhangZhengDuoFightManager:OnEvent_ObjDead(killer, target)
	--[[调用父级]]
	FightManager.OnEvent_ObjDead(self, killer, target);
	--[[全死完]]
	if table.getn(g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_friend_flag)) <= 0 then
		FightRecord.killingBillBoard[g_dataCenter.fight_info.single_enemy_flag].winNum = FightRecord.killingBillBoard[g_dataCenter.fight_info.single_enemy_flag].winNum + 1;
		self:ShowUI(FightRecord.killingBillBoard[g_dataCenter.fight_info.single_enemy_flag].winNum + 1);
		app.log("自己赢，回合数为="..tostring(FightRecord.killingBillBoard[g_dataCenter.fight_info.single_enemy_flag].winNum));
		--[[重新开始]]
		self:Restart();
	elseif table.getn(g_dataCenter.fight_info:GetHeroList(g_dataCenter.fight_info.single_enemy_flag)) <= 0 then
		FightRecord.killingBillBoard[g_dataCenter.fight_info.single_friend_flag].winNum = FightRecord.killingBillBoard[g_dataCenter.fight_info.single_friend_flag].winNum + 1;
		self:ShowUI(FightRecord.killingBillBoard[g_dataCenter.fight_info.single_friend_flag].winNum + 1);
		app.log("对方赢，回合数为="..tostring(FightRecord.killingBillBoard[g_dataCenter.fight_info.single_friend_flag].winNum));
		--[[重新开始]]
		self:Restart();
	end
end

function HuiZhangZhengDuoFightManager:FightOver()
	FightManager.FightOver(self);
	if self.ui ~= nil then
		self.ui:set_active(false);
	end
	self.ui = nil;
	self:unregistFunc();
end


local top_object_ui =
{

}

TopObjectUi = Class("TopObjectUi", nil, top_object_ui);

local hpBigRes = "assetbundles/prefabs/ui/fight/panel_big_hero.assetbundle";
local opt_smallRes = "assetbundles/prefabs/ui/fight/panel_smallhp.assetbundle"
local hpBigBossRes = "assetbundles/prefabs/ui/fight/panel_bighp_boss.assetbundle";
local npcNameRes = "assetbundles/prefabs/ui/main/sp_zjm_lab_npc.assetbundle";

--[[data =
{
	type  -- 1:big 2:small 3:boss 4:npc
}]]
function TopObjectUi:Init(data)
	self.restraintCfg = ConfigManager.Get(EConfigIndex.t_play_vs_data, 62002006);
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
end
function TopObjectUi:InitData(data)
	-- 根对象
	if data.type == 1 then
		self.name = "sp_bighp_di";
		self.bkName = self.name;
	elseif data.type == 2 then
		self.name = "sp_smallhp_di";
		self.bkName = self.name;
	elseif data.type == 3 then
		self.name = "sp_bighp_boss_di";
		self.bkName = self.name;
	elseif data.type == 4 then
		self.name = "npc_name";
		self.bkName = self.name;
	end
	self.isDestroy = false;
	self.ui = nil;
	-- 血条类型
	self.bloodType = data.type;
	-- 数据
	self.target = nil;
	-- 绑定函数
	self.bindfunc = { };
	-- ui控件
	self.ui_control =
	{
		-- 血条相关
		sp_bk_hp = nil,
		pro_hp = nil,
		pro_hp_bk = nil,
		sp_hp = nil,
		spr_property = nil,
		spr_property_bk = nil,
	};
	-- 是否显示
	self.isShow = false;
	self.isShowHP = false;
	self.isShowName = false;
end

function TopObjectUi:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, TopObjectUi.on_loaded)
end
function TopObjectUi:UnregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end

function TopObjectUi:LoadAsset()
	if self.bloodType == 1 then
		--ResourceLoader.LoadAsset(hpBigRes, self.bindfunc["on_loaded"]);
		OGM.GetGameObject(hpBigRes, function(gObject)
			self:InitUi(nil, gObject)
		end )
	elseif self.bloodType == 2 then
		OGM.GetGameObject(opt_smallRes, function(gObject)
			self:InitUi(nil, gObject)
		end )
	elseif self.bloodType == 3 then
		--ResourceLoader.LoadAsset(hpBigBossRes, self.bindfunc["on_loaded"]);
		OGM.GetGameObject(hpBigBossRes, function(gObject)
			self:InitUi(nil, gObject)
		end )
	elseif self.bloodType == 4 then
		ResourceLoader.LoadAsset(npcNameRes, self.bindfunc["on_loaded"]);
	end
end

function TopObjectUi:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == hpBigRes then
		self:InitUi(asset_obj);
	elseif filepath == hpBigBossRes then
		self:InitUi(asset_obj);
	elseif filepath == npcNameRes then
		self:InitUi(asset_obj);
	end
end

function TopObjectUi:Destroy()
	self.isDestroy = true;
	self:UnregistFunc();
	if (self.ui ~= nil) then
		self.ui:set_active(false);
		self.ui = nil;
	end
	if self.gObject ~= nil then
		OGM.UnUse(self.gObject)
		self.gObject = nil;

		-- if self.ui_control then
		-- 	if self.ui_control.sp_bk_hp then
		-- 		self.ui_control.sp_bk_hp:set_depth(self.oldBkDepth)
		-- 	end
		-- 	if self.ui_control.sp_hp then
		-- 		self.ui_control.sp_hp:set_depth(self.oldHpDepth);
		-- 	end
		-- 	if self.ui_control.sp_hp_bk then
		-- 		self.ui_control.sp_hp_bk:set_depth(self.oldHpBkDepth);
		-- 	end
		-- end
	end
end
-- 初始化ui
function TopObjectUi:InitUi(asset, gObject)
	if self.isDestroy then
		if gObject then
			gObject:SetActive(false);
			OGM.UnUse(gObject);
		end
		return;
	end
	if gObject then
		self.ui = gObject:GetGameObject()
		self.gObject = gObject
	else
		self.ui = asset_game_object.create(asset);
	end
	self.ui:set_active(self.isShow);
	if self.parent then
		self.ui:set_parent(self.parent);
	else
		if not gObject then
			self.ui:set_parent(Root.get_root_ui_2d_fight());
		end
	end
	self.ui:set_name(tostring(self.name));
	self.ui:set_local_scale(1, 1, 1);

	if self.bloodType == 4 then
		-- 金色!-'r_tanhao1'
		-- 灰色!-'r_tanhao2'
		-- 金色?-'r_wenhao1'
		-- 灰色?-'r_wenhao2'
		self.sp_npc_task = ngui.find_sprite(self.ui, "sp");
		self:SetNpcTaskState(self.npc_state);

		self.lab_npc_name = ngui.find_label(self.ui, "lab");
		self:SetNpcName(self.npc_name);
		self:UpdateUi();
		return
	end

	self.ui_control.hp_node = self.ui:get_child_by_name("cont")
	self.ui_control.hp_node:set_active(self.isShowHP)

	self.ui_control.sp_bk_hp = ngui.find_sprite(self.ui, self.bkName);
	self.oldBkDepth = self.ui_control.sp_bk_hp:get_depth();
	self.ui_control.pro_hp = ngui.find_progress_bar(self.ui, "sp_hp");
	self.ui_control.pro_hp_bk = ngui.find_progress_bar(self.ui, "sp_hp1");
	if self.ui_control.pro_hp_bk ~= nil then 
		self.ui_control.pro_hp_bk:set_active(false);
	end
	self.ui_control.sp_hp = ngui.find_sprite(self.ui, "sp_hp");
	self.oldHpDepth = self.ui_control.sp_hp:get_depth();
	-- self.ui_control.sp_hp:set_parent(Root.get_root_ui_2d_fight());
	self.ui_control.sp_hp_bk = ngui.find_sprite(self.ui, "sp_hp1");
	if self.ui_control.sp_hp_bk then
		self.oldHpBkDepth = self.ui_control.sp_hp_bk:get_depth();
	end

	self.ui_control.labNode = self.ui:get_child_by_name("cont_lab")
	self.ui_control.labNode:set_active(false)
	self.ui_control.labName = ngui.find_label(self.ui, "lab_sh");
	self.ui_control.labNameBoldItalic = ngui.find_label(self.ui, "lab");
	if self.labName and self.isShowName then
		self:SetName(self.isShowName, self.labName, self.labType);
	end
	--self.ui_control.spr_property = ngui.find_sprite(self.ui, "sp_di1/sp");
	self.ui_control.spr_property_bk = ngui.find_sprite(self.ui, 'sp_di1')

	self.hurdleCfg = FightScene.GetHurdleConfig();
	self:UpdateUi();
end

function TopObjectUi:CheckIsShow()
	if self.isShowHP or self.isShowName then
		if not self.isShow then
			self:Show(true)
		end
	else
		if self.isShow then
			self:Show(false)
		end
	end
end

function TopObjectUi:Show(isShow)

	if self.isShow == isShow then return end
	self.isShow = isShow;
	if (self.ui ~= nil) then
		self.ui:set_active(isShow);
	end
end

function TopObjectUi:IsShow()
	return self.isShow;
end

function TopObjectUi:ShowHP(isShowHP)
	
	if self.isShowHP == isShowHP then return end

	self.isShowHP = isShowHP

	if self.ui_control.hp_node then
		self.ui_control.hp_node:set_active(isShowHP)
	end

	self:CheckIsShow()
end

function TopObjectUi:IsShowHP()
	return self.isShowHP
end

-- 设置所有数据
function TopObjectUi:SetData(info)
	if (info ~= nil) then
		self.target = info;
		if self.ui then
			self:UpdateUi();
		end
	end
end
-- 更新所有数据
function TopObjectUi:UpdateUi()
	if self.target ~= nil and self.ui then
		if self.bloodType == 4 then

			return
		end
		local target = self.target;
		-- 血条背景
		-- 如果是boss则不改变血条背景
		-- if self.bloodType ~= 3 then
		local oldBkDepth = self.oldBkDepth;
		local oldHpDepth = self.oldHpDepth;
		local oldHpBkDepth = self.oldHpBkDepth;
		-- 我方
		if not target:IsEnemy() then
			local name;
			-- 玩家自己的队伍
			if target:IsMyControl() then
				-- 全自动战斗没有操作者
				if nil == g_dataCenter.fight_info:GetCaptainIndex() then
					self.ui:set_local_scale(1, 1, 1);
					name = "xuetiao10_cs";
				-- 操作者自己
				elseif target == FightManager.GetMyCaptain() then
					self.ui:set_local_scale(1, 1, 1);
					name = "xuetiao10_cs";
					oldBkDepth = 150;
					oldHpBkDepth = 151;
					oldHpDepth = 152;					
				-- 其他英雄
				else
					self.ui:set_local_scale(0.75, 0.75, 1);
					name = "xuetiao9";
				end

			-- 我方的其他人
			else
				self.ui:set_local_scale(0.75, 0.75, 1);
				name = "xuetiao9";
			end

			self.ui_control.sp_hp:set_sprite_name(name)
			if self.ui_control.sp_hp_bk then
				self.ui_control.sp_hp_bk:set_sprite_name(name);
			end
		elseif self.bloodType == 2 then
			self.ui_control.sp_hp:set_sprite_name("xuetiao_x1")
			if self.ui_control.sp_hp_bk then
				self.ui_control.sp_hp_bk:set_sprite_name("xuetiao_x1");
			end
		else
			self.ui_control.sp_hp:set_sprite_name("xuetiao_boss")
			if self.ui_control.sp_hp_bk then
				self.ui_control.sp_hp_bk:set_sprite_name("xuetiao_boss");
			end
		end

		-- self.ui_control.sp_bk_hp:set_depth(oldBkDepth);
		-- self.ui_control.sp_hp:set_depth(oldHpDepth);	
		-- if self.ui_control.sp_hp_bk then
		-- 	self.ui_control.sp_hp_bk:set_depth(oldHpBkDepth);
		-- end
		--如果是怪判断怪是否配置了克制属性 配了就显示
		if self.ui_control.spr_property_bk  then
			local restraint = 0;
			if self.restraintCfg.open_type == 1 then
				if type(self.restraintCfg.param) == "table" and self.restraintCfg.param[1] <= g_dataCenter.player:GetLevel() then
					restraint = target.config.restraint or 0;
				end
			end
			PublicFunc.SetRestraintSpriteBk(self.ui_control.spr_property_bk, restraint);
			--PublicFunc.SetRestraintSprite(self.ui_control.spr_property, restraint);
		end
		self:UpdateBlood();
	end
end
-- 更新血条渐近效果
function TopObjectUi:UpdateBlood()
	if not self.ui then
		return
	end
	if self.bloodType == 4 then
		return
	end
	local target = self.target;
	-- 血条
	local pro = target:GetPropertyVal('cur_hp') / target:GetPropertyVal('max_hp');
	if pro < 0.001 then
		pro = 0;
	end
	if not target:IsBoss() and not target:IsHero()
		and not target:IsSuper()
		and (self.hurdleCfg.show_blood == nil or self.hurdleCfg.show_blood == 0) then
		if pro == 1 then
			self.ui_control.hp_node:set_active(false);
		else
			self.ui_control.hp_node:set_active(self.isShowHP);
		end
	end
	self.ui_control.pro_hp:set_value(pro);
	--if self.ui_control.pro_hp_bk then
		--self.ui_control.pro_hp_bk:set_active(false)
		--local cur_pro = self.ui_control.pro_hp_bk:get_value();
		--if pro < cur_pro then
		--	self.ui_control.pro_hp_bk:set_value(cur_pro - 1 * app.get_delta_time());
		--else
		--	self.ui_control.pro_hp_bk:set_value(pro);
		--end
	--end
end
-- 設置位置
function TopObjectUi:SetPosition(x, y, z)
	if self.ui then
		-- local xA, xB = math.modf(x);
		-- xB = math.floor(xB * 10000 + 0.5) / 10000;
		-- local yA, yB = math.modf(y);
		-- yB = math.floor(yB * 10000 + 0.5) / 10000;
		self.ui:set_position(x, y, z);
		-- self.ui_control.sp_hp:get_game_object():set_position(x, y, z);
	end
end
-- 設置位置
function TopObjectUi:SetLocalPosition(x, y, z)
	if self.ui then
		self.ui:set_local_position(x, y, z);
		-- self.ui_control.sp_hp:set_position(x, y, z);
	end
end
-- 设置角色名字
-- ty 1 普通,2 粗斜体
function TopObjectUi:SetName(isShow, name, ty)
	if type(name) == "number" then
		self.labName = ""
	else
		self.labName = name;	
	end
	self.labType = ty or 1
	self.isShowName = isShow;
	if self.ui_control and self.ui_control.labName then
		if self.isShowName then
			self.ui_control.labNode:set_active(true)
			if self.labType == 2 then
				self.ui_control.labName:set_active(false)
				self.ui_control.labNameBoldItalic:set_active(true)

				self.ui_control.labNameBoldItalic:set_text(self.labName)
			else
				self.ui_control.labName:set_active(true)
				self.ui_control.labNameBoldItalic:set_active(false)
				
				self.ui_control.labName:set_text(self.labName)
			end
		else
			self.ui_control.labNode:set_active(false)
		end
	end

	self:CheckIsShow()
end

function TopObjectUi:OnlyShowName(isShow, name)
	if not self.ui then return end;
	if not self.ui_control then return end
	-- self.ui_control.sp_bk_hp:set_active(true);
	-- self.ui_control.sp_bk_hp:set_sprite_name("123x123");
	-- self.ui_control.sp_hp:set_active(false);
	-- if self.ui_control.sp_hp_bk then
	-- 	self.ui_control.sp_hp_bk:set_active(false);
	-- end
	self:ShowHP(false)

	self:SetName(isShow, name);
end

function TopObjectUi:SetNpcName(name)
	self.npc_name = name;
	if self.lab_npc_name then
		self.lab_npc_name:set_active(self.npc_name ~= nil);
		self.lab_npc_name:set_text(name or "");
	end
end

function TopObjectUi:SetNpcTaskState(state)
	self.npc_state = state;
	if self.sp_npc_task then
		-- 金色!-'r_tanhao1'
		-- 灰色!-'r_tanhao2'
		-- 金色?-'r_wenhao1'
		-- 灰色?-'r_wenhao2'
		if state == -1 then
			self.sp_npc_task:set_sprite_name("r_tanhao1")
		elseif state == 0 then
			self.sp_npc_task:set_sprite_name("r_wenhao2")
		elseif state == 1 then
			self.sp_npc_task:set_sprite_name("r_wenhao1")
			-- 失败
		elseif state == 2 then
			self.sp_npc_task:set_sprite_name("r_wenhao2")
		else
			self.sp_npc_task:set_sprite_name("")
		end
		self.sp_npc_task:set_active(state ~= nil)
	end
end


function TopObjectUi:set_parent(parent)
	self.parent = parent;
	if self.ui then
		self.ui:set_parent(parent);
	end
end
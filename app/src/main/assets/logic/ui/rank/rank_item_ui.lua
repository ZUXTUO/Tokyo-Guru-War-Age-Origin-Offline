RankItemUi = Class('RankItemUi', UiBaseClass);
local rankName = {'战斗力','等级','战斗力','关卡','金币','帮派','成就点',}
function RankItemUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/rank/item_rank.assetbundle";
	UiBaseClass.Init(self, data);
end

function RankItemUi:Restart(data)
	UiBaseClass.Restart(self, data)
end

function RankItemUi:InitData(data)
	UiBaseClass.InitData(self, data);

	self.index     = data;
	self.parent    = nil;
	self.cardTable = {};
end

function RankItemUi:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc["btn_role1_click"] = Utility.bind_callback(self, RankItemUi.btn_role1_click);
	self.bindfunc["btn_role2_click"] = Utility.bind_callback(self, RankItemUi.btn_role2_click);
end

function RankItemUi:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

function RankItemUi:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_name('rank_item'..tostring(self.index));
	self:SetParent(self.parent);
	
	self.go_type_1  = asset_game_object.find(self.ui:get_name().."/bk/fight2");
	self.go_type_2  = asset_game_object.find(self.ui:get_name().."/bk/fight");
	self.go_star    = asset_game_object.find(self.ui:get_name().."/bk/fight2/txt_fight/sp_star");
	self.go_back    = asset_game_object.find(self.ui:get_name().."/bk/contain_head/sp_head");
	self.go_name    = asset_game_object.find(self.ui:get_name().."/bk/fight2/txt_fight/lab_fight");
	
	self.go_rank_1  = asset_game_object.find(self.ui:get_name().."/bk/contain_head/sp_di");
	self.go_rank_2  = asset_game_object.find(self.ui:get_name().."/bk/contain_head/sp_num1");
	self.go_rank_3  = asset_game_object.find(self.ui:get_name().."/bk/contain_head/sp_num2");
	self.spr_rank_1 = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/contain_head/sp_di");
	self.spr_rank_2 = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/contain_head/sp_num1");
	self.spr_rank_3 = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/contain_head/sp_num2");
	
	self.btn_role_1 = ngui.find_button(self.ui,self.ui:get_name().."/bk/fight2/btn_name");
	self.lab_name  = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight2/txt_fight/lab_fight");
	self.lab_value = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight2/txt_fight/lab_num");
	self.lab_roleName_1 = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight2/btn_name/label_last_time");
	self.cardTable[1] = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/fight2/head1/sp_touxiang");
	self.cardTable[2] = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/fight2/head2/sp_touxiang");
	self.cardTable[3] = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/fight2/head3/sp_touxiang");
	
	self.spr_icon  = ngui.find_sprite(self.ui,self.ui:get_name().."/bk/fight/stouxiang/sp_touxiang");
	self.btn_role_2 = ngui.find_button(self.ui,self.ui:get_name().."/bk/fight/btn_name");
	self.lab_id    = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight/lab_id");
	self.lab_score = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight/lab_num");
	self.lab_roleName_2 = ngui.find_label(self.ui,self.ui:get_name().."/bk/fight/btn_name/label_last_time");
	
	self.btn_role_1:set_on_click(self.bindfunc["btn_role1_click"]);
	self.btn_role_2:set_on_click(self.bindfunc["btn_role2_click"]);
	
	self.go_type_2:set_active(false);
	self:SetRankIndex(self.index);
end

function RankItemUi:btn_role1_click()

end

function RankItemUi:btn_role2_click()

end

function RankItemUi:SetRankIndex(index)
	local str = tostring(index);
	self.go_rank_1:set_active(false);
	self.go_rank_2:set_active(false);
	self.go_rank_3:set_active(false);
	self.go_back:set_active(false);
	if index > 0 and index <= 3 then
		self.go_rank_1:set_active(true);
		self.go_back:set_active(true);
		self.spr_rank_1:set_sprite_name('rank'..str);
	elseif index > 3 and index<= 9 then
		self.go_rank_2:set_active(true);
		self.go_rank_2:set_local_position(0,0,0);
		self.go_back:set_active(true);
		self.spr_rank_2:set_sprite_name('paiming'..str);
	elseif index >9 then
		if index == 10 then
			self.go_back:set_active(true);
		end
		self.go_rank_2:set_active(true);
		self.go_rank_2:set_local_position(-14,0,0);
		self.go_rank_3:set_active(true);
		local n = str.sub(str,1,1);
		local m = str.sub(str,-1,-1);
		self.spr_rank_2:set_sprite_name('paiming'..n);
		self.spr_rank_3:set_sprite_name('paiming'..m);
	else
		return;
	end
end

function RankItemUi:SetRankTypeVisble(index)
	self.lab_name:set_text(rankName[index]);
	if index == RankEnum.RANK_TYPE.FACTION then
		self.go_type_2:set_active(true);
		self.go_type_1:set_active(false);
		self.go_name:set_active(true);
	elseif index == RankEnum.RANK_TYPE.GATES then
		self.go_type_1:set_active(true);
		self.go_type_2:set_active(false);
		self.go_star:set_active(true);
		self.go_name:set_active(false);
	else 
		self.go_type_1:set_active(true);
		self.go_type_2:set_active(false);
		self.go_star:set_active(false);
		self.go_name:set_active(true);
	end
end

function RankItemUi:SetData(flagType,data)
	if flagType == RankEnum.RANK_TYPE.FACTION then
		self.lab_id:set_text(tostring(data.cards.factionId))
		self.lab_score:set_text(tostring(data.value));
		--帮派与帮派名图标只能通过帮派ID去找  目前没得
	else
		self.lab_roleName_1:set_text(data.cards.name);
		if flagType == RankEnum.RANK_TYPE.GATES then
			self.lab_value:set_text(tostring(' X'..data.value));
		else
			self.lab_value:set_text(tostring(data.value));
		end
		local length = table.getn(self.cardTable);
		for i = 1, length do
			if data.cards.teamCards[i] then
				local number =  data.cards.teamCards[i];
				if ConfigHelper.GetRole(number) then
					local spr = FightEnum.KILL_HEAD[ConfigHelper.GetRole(number).model_id];
					if spr then
						self.cardTable[i]:set_sprite_name(spr);
					else
						self.cardTable[i]:set_sprite_name("touxiang1");
					end
				end
			end
		end	
	end
end

function RankItemUi:SetParent(parent)
    if parent then
        if self.ui ~= nil then
            self.ui:set_parent(parent);
            self.ui:set_local_scale(Utility.SetUIAdaptation());
            self.ui:set_local_position(0,0,0);
        else
            self.parent = parent;
        end
    end
end

function RankItemUi:Show()
	UiBaseClass.Show(self)
end

function RankItemUi:Hide()
	UiBaseClass.Hide(self)
end

function RankItemUi:DestroyUi()
	UiBaseClass.DestroyUi(self);

	self.index  = nil;
	self.parent = nil;
	self.cardTable = {};
end

return RankItemUi

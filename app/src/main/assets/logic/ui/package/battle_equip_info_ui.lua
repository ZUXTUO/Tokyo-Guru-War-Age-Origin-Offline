BattleEquipInfoUI = Class("BattleEquipInfoUI",UiBaseClass);

function BattleEquipInfoUI:Init(data)
	-- self.smallPool = data.atlas;
	self.roleData = data.info;
    self.backCallback = data.callback;
    self.loading = data.loading;
    self.equipList = data.equipList;
    self.equipPos = data.pos_id;
    self.package = data.package;
    self.isPlayer = data.is_player;
    self.equipList = data.show_list;

    self.equipPanel = nil;
    self.equipPanelName = nil;
    self.equipPanelSp = nil;
    self.equipPanelAttr = nil;
    self.equipPanelQuality = nil;
    self.equipPanelLevel = nil;
    self.equipPanelStar = {};
    self.equipPanelChange = nil;
    self.equipPanelBelow  = nil;

    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_battle_1.assetbundle";
    UiBaseClass.Init(self, data);
end 

function BattleEquipInfoUI:SetInfo(info,is_player,package)
 	self.roleData = info;
 	self.isPlayer = is_player;
 	self.package = package;
 	self:UpdateInfo();
end

function BattleEquipInfoUI:Show(pos_id)
	if UiBaseClass.Show(self) and self.roleData then
		self.equipPos = pos_id;
		self.equipPanelChange:set_event_value("",pos_id);
		self.equipPanelBelow:set_event_value("",pos_id);
		-- self.ui:set_active(true);
		self:UpdateInfo();
	end
end

function BattleEquipInfoUI:Hide()
    UiBaseClass.Hide(self);
    -- self.ui:set_active(false);
	-- if self.equipList then
	-- 	self.equipList:Hide();
	-- end
end

function BattleEquipInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_below_equip"] = Utility.bind_callback(self, BattleEquipInfoUI.on_below_equip);
    self.bindfunc["on_equip"] = Utility.bind_callback(self, BattleEquipInfoUI.on_equip);
    self.bindfunc["on_level_up"] = Utility.bind_callback(self, BattleEquipInfoUI.on_level_up);
    self.bindfunc["on_up_star"] = Utility.bind_callback(self, BattleEquipInfoUI.on_up_star);
	self.bindfunc["gc_level_up"] = Utility.bind_callback(self, BattleEquipInfoUI.gc_level_up);
	self.bindfunc["on_close"] = Utility.bind_callback(self, BattleEquipInfoUI.on_close);
end

--注册消息分发回调函数
function BattleEquipInfoUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_equip_level_up,self.bindfunc['gc_level_up']);
end

--注销消息分发回调函数
function BattleEquipInfoUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_equip_level_up,self.bindfunc['gc_level_up']);
end

function BattleEquipInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self,asset_obj);
    self.ui:set_name("battle_equip_info_ui")

    local path = "ui_602_battle";
    -- self.ui = ngui.find_sprite(self.rootui,path);
    self.equipPanelSp = ngui.find_texture(self.ui,path.."/sp_bk/sp_icon");
    self.equipPanelFrame = ngui.find_sprite(self.ui,path.."/sp_bk/sp_frame");
    self.equipPanelName = ngui.find_label(self.ui,path.."/lab_equip_name");
    self.equipPanelAttr = ngui.find_label(self.ui,path.."/scroview/scrollview_nature/lab_attack");
    self.equipPanelRarity = ngui.find_sprite(self.ui,path.."/sp");
    self.equipPanelLevel = ngui.find_label(self.ui,path.."/lab_lv");
    for i=1,5 do
        self.equipPanelStar[i] = ngui.find_sprite(self.ui,path.."/star/sp_star_di"..i.."/star");
    end
    --升级
    self.btnLevelUp = ngui.find_button(self.ui,path.."/btn2");
    self.btnLevelUp:set_on_click(self.bindfunc["on_level_up"]);
    --升星
    self.btnUpStar = ngui.find_button(self.ui,path.."/btn1");
    self.btnUpStar:set_on_click(self.bindfunc["on_up_star"]);
    --更换
    self.equipPanelChange = ngui.find_button(self.ui,path.."/btn4");
    self.equipPanelChange:reset_on_click();
    self.equipPanelChange:set_on_click(self.bindfunc["on_equip"]);
    --卸下
    self.equipPanelBelow = ngui.find_button(self.ui,path.."/btn3");
    self.equipPanelBelow:reset_on_click();
    self.equipPanelBelow:set_on_click(self.bindfunc["on_below_equip"]);
    local _btnClose = ngui.find_button(self.ui,path.."/btn_close");
    _btnClose:set_on_click(self.bindfunc["on_close"]);
    if self.equipPos then
        self:Show(self.equipPos);
    end
end

function BattleEquipInfoUI:on_level_up()
    if self.equipInfo then
		--uiManager:PushUi(EUI.UiEquipLevelUp, {cardInfo = self.equipInfo});
       	--uiManager:GetCurScene():SetData({cardInfo = self.equipInfo});
    end
end

function BattleEquipInfoUI:on_up_star()
    if self.equipInfo then
		uiManager:PushUi(EUI.UiEquipStarUp, {cardInfo = self.equipInfo});
       	--uiManager:GetCurScene():SetData({cardInfo = self.equipInfo});
    end
end

function BattleEquipInfoUI:on_below_equip(t)
    msg_cards.cg_takeoff_equip_on_role(Socket.socketServer,self.roleData.index,t.float_value);
    if self.backCallback then
        _G[self.backCallback]();
    end
end

function BattleEquipInfoUI:on_equip(t)
	-- self.rootui:set_active(false);
	if self.equipList then
		_G[self.equipList](t);
	end
end

function BattleEquipInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
	-- if self.equipList then
	-- 	self.equipList:DestroyUi();
	-- end
	
	-- self.smallPool = nil;
	self.roleData = nil;
    self.backCallback = nil;
    self.loading = nil;
    self.equipList = nil;
	-- self.rootui = nil;
    self.equipPanel = nil;
    self.equipPanelName = nil;
    if self.equipPanelSp then
        self.equipPanelSp:Destroy();
        self.equipPanelSp = nil;
    end
    self.equipPanelAttr = nil;
    self.equipPanelQuality = nil;
    self.equipPanelLevel = nil;
    self.equipPanelStar = {};
    self.equipPanelChange = nil;
    self.equipPanelBelow  = nil;
    self.equipPos = nil;
end

function BattleEquipInfoUI:UpdateSceneInfo(result)
	self:UpdateInfo();
end

function BattleEquipInfoUI:UpdateInfo()
	if self.ui and self.roleData and self.equipPos and self.package then
		self.equipInfo = self.package:find_card(2,self.roleData.equipment[self.equipPos]);
		if self.equipInfo then
            self.equipPanelSp:set_texture(self.equipInfo.config.small_icon);
			PublicFunc.SetIconFrameSprite(self.equipPanelFrame,self.equipInfo.rarity);
			for i=1,5 do
				if i > self.equipInfo.star then
					self.equipPanelStar[i]:set_active(false);
				else
					self.equipPanelStar[i]:set_active(true);
				end
			end
			local attrs = self.equipInfo:GetDeltaProperty();
			local str = "";
			for i=1,#attrs do
				local value = attrs[i].value;
				local key = attrs[i].key;
				if value > 0 then
					str = str.."+"..value..attrs[i].showUnit.." "..gs_string_property_name[key].."\n";
				else
					str = str..value..attrs[i].showUnit.." "..gs_string_property_name[key].."\n";
				end
			end
			self.equipPanelAttr:set_text(str);
			self.equipPanelName:set_text(self.equipInfo.name);
			self.equipPanelLevel:set_text(string.format("Lv.%s",tostring(self.equipInfo.level)));
			PublicFunc.SetEquipRaritySprite(self.equipPanelRarity,self.equipInfo.rarity);
			if self.equipInfo.rarity >= ENUM.EEquipRarity.Blue and self.equipInfo.star < 5 then
	    		self.btnUpStar:set_enable(true);
	    	else
	    		self.btnUpStar:set_enable(false);
	    	end
		end
		if self.isPlayer then
			self.btnLevelUp:set_active(true);
			self.btnUpStar:set_active(true);
			self.equipPanelChange:set_active(true);
			self.equipPanelBelow:set_active(true);
		else
			self.btnLevelUp:set_active(false);
			self.btnUpStar:set_active(false);
			self.equipPanelChange:set_active(false);
			self.equipPanelBelow:set_active(false);
		end
	end
end

function BattleEquipInfoUI:GetChoseEquip()
    return self.equipInfo;
end

function BattleEquipInfoUI:on_close()
	if self.backCallback then
        _G[self.backCallback]();
    end
end

function BattleEquipInfoUI:gc_level_up(result)
	self:UpdateSceneInfo();
end

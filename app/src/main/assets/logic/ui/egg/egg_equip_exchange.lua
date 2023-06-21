EggEquipExchangeUI = Class("EggEquipExchangeUI",UiBaseClass );

--初始化
function EggEquipExchangeUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/egg/ui_906_debris_equip.assetbundle";
	UiBaseClass.Init(self, data);
end

function EggEquipExchangeUI:InitData()
	UiBaseClass.InitData(self)
	self.col = 4;
end

--重新开始
function EggEquipExchangeUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
	end
end

--析构函数
function EggEquipExchangeUI:DestroyUi()
	self.equipListGrid = nil;
	if self.equipInfo and self.equipInfo.sp then
		self.equipInfo.sp:Destroy();
		self.equipInfo.sp = nil;
	end
	self.equipInfo = nil;
	self.equipListScroll = nil;
	self.choseInfo = nil;
	self.choseObj = nil;
	if self.temp then
		for k,v in pairs(self.temp) do 
			self.temp[k]:Destroy();
			self.temp[k] = nil;
		end
		self.temp = nil;
	end
	UiBaseClass.DestroyUi(self);
end
--注册回调函数
function EggEquipExchangeUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_exchange"] = Utility.bind_callback(self,self.on_exchange);
	self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item);
	self.bindfunc["on_init_attr"] = Utility.bind_callback(self,self.on_init_attr);
	self.bindfunc["on_chose"] = Utility.bind_callback(self,self.on_chose);
	self.bindfunc["gc_niudan_exchange_equip"] = Utility.bind_callback(self,self.gc_niudan_exchange_equip);
end
--注册消息分发回调函数
function EggEquipExchangeUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_niudan_exchange_equip,self.bindfunc['gc_niudan_exchange_equip']);
end

--注销消息分发回调函数
function EggEquipExchangeUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_niudan_exchange_equip,self.bindfunc['gc_niudan_exchange_equip']);
end

--寻找ngui对象
function EggEquipExchangeUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());

    self.labDebris = ngui.find_label(self.ui,"top_other/animation/sp_di/lab_num");
    local _btnRule = ngui.find_button(self.ui,"top_other/animation/btn_rule");
    _btnRule:set_active(false);

    self.equipInfo = {};
    self.equipInfo.name = ngui.find_label(self.ui,"center_other/left_content/cont/lab_equip_name");
    self.equipInfo.sp = ngui.find_texture(self.ui,"center_other/left_content/cont/sp_touxiangkuang/sp_equip");
    self.equipInfo.sp_frame = ngui.find_sprite(self.ui,"center_other/left_content/cont/sp_touxiangkuang/sp_frame");
    self.equipInfo.star = {};
    self.equipInfo.allStar = ngui.find_sprite(self.ui,"center_other/left_content/cont/star");
    for i=1,5 do 
    	self.equipInfo.star[i] = ngui.find_sprite(self.ui,"center_other/left_content/cont/star/star_di"..i.."/sp_star");
    end
    self.equipInfo.letter = ngui.find_sprite(self.ui,"center_other/left_content/cont/sp_letter");
    self.equipInfo.level = ngui.find_label(self.ui,"center_other/left_content/cont/lab_level");
    self.equipInfo.cost = ngui.find_label(self.ui,"center_other/left_content/lab");
    self.equipInfo.attrGrid = ngui.find_wrap_content(self.ui,"center_other/animation/left_content/scroview/scrollview_nature1/wrap_content");
    self.equipInfo.attrGrid:set_on_initialize_item(self.bindfunc["on_init_attr"]);
    self.equipInfo.attrScroll = ngui.find_scroll_view(self.ui,"center_other/animation/left_content/scroview/scrollview_nature1");

    self.equipInfo.labDes = ngui.find_label(self.ui,"center_other/animation/left_content/scroview/scrollview_nature2/lab_nature");
    self.equipInfo.desScroll = ngui.find_scroll_view(self.ui,"center_other/animation/left_content/scroview/scrollview_nature2");
    self.equipInfo.starRoot = self.ui:get_child_by_name("center_other/animation/left_content/cont/star");
    self.equipInfo.labLetter = ngui.find_label(self.ui,"center_other/animation/left_content/cont/txt_jibie");
    self.equipInfo.labAttr = ngui.find_label(self.ui,"center_other/animation/left_content/scroview/txt");

    local _btn = ngui.find_button(self.ui,"center_other/animation/left_content/btn_exchange");
    _btn:set_on_click(self.bindfunc["on_exchange"]);

    self.equipListGrid = ngui.find_wrap_content(self.ui,"center_other/animation/right_content/scroview/scrollview_nature/warp_content");
    self.equipListGrid:set_on_initialize_item(self.bindfunc["on_init_item"])
    self.equipListScroll = ngui.find_scroll_view(self.ui,"center_other/animation/right_content/scroview/scrollview_nature");

	self:UpdateUi();
end

--刷新界面
function EggEquipExchangeUI:UpdateUi(dt)
	if not self.ui then
		return;
	end
	local num = g_dataCenter.package:find_count(ENUM.EPackageType.Item,20000025);
	self.labDebris:set_text(tostring(num));
 	local equip_num = ConfigManager.GetDataCount(EConfigIndex.t_niudan_equip_exchange);
	self.equipListGrid:set_min_index(-math.ceil(equip_num/self.col)+1);
	self.equipListGrid:set_max_index(0);
	self.equipListGrid:reset();
	self.equipListScroll:reset_position();
end

function EggEquipExchangeUI:UpdateEquipInfo()
	if not self.ui then
		return
	end
	if self.choseInfo then
		if PropsEnum.IsEquip(self.choseInfo.equip_ID) then
			local equip_cfg = CardEquipment:new({number=self.choseInfo.equip_ID,});
			self.equipInfo.name:set_text(equip_cfg.name);
			-- item_manager.texturePadding(self.equipInfo.sp,equip_cfg.small_icon)
			self.equipInfo.sp:set_texture(equip_cfg.small_icon);
			self.equipInfo.sp:set_active(true);
			PublicFunc.SetIconFrameSprite(self.equipInfo.sp_frame,equip_cfg.rarity);
			PublicFunc.SetEquipRaritySprite(self.equipInfo.letter,equip_cfg.rarity);
			self.equipInfo.level:set_text("");
			self.equipInfo.allStar:set_active(true);
			for i=1,5 do
				if equip_cfg.star >= i then
					self.equipInfo.star[i]:set_active(true);
				else
					self.equipInfo.star[i]:set_active(false);
				end
			end
			self.equipInfo.cost:set_text(tostring(self.choseInfo.need_ships));
			self.equipInfo.attrGrid:set_active(true);
			self.equipDiffAttr = equip_cfg:GetDeltaProperty(); 
			-- for k,v in pairs(ENUM.EHeroAttribute) do
			-- 	local attr = equip_cfg:GetPropertyVal(v);
			-- 	if attr and attr ~= 0 then
			-- 		table.insert(self.equipDiffAttr,{v,attr});
			-- 	end
			-- end
			self.equipInfo.attrGrid:set_active(true);
			self.equipInfo.attrGrid:set_min_index(-#self.equipDiffAttr+1);
			self.equipInfo.attrGrid:set_max_index(0);
			self.equipInfo.attrGrid:reset();
			self.equipInfo.attrScroll:reset_position();
			self.equipInfo.desScroll:set_active(false);
			self.equipInfo.starRoot:set_active(true);
			self.equipInfo.labLetter:set_active(true);
			self.equipInfo.labAttr:set_active(true);
			return;
		end
		if PropsEnum.IsItem(self.choseInfo.equip_ID) then
			local equip_cfg = CardProp:new({number=self.choseInfo.equip_ID,});
			self.equipInfo.name:set_text(equip_cfg.name);
			-- item_manager.texturePadding(self.equipInfo.sp,equip_cfg.small_icon)
			self.equipInfo.sp:set_texture(equip_cfg.small_icon);
			self.equipInfo.sp:set_active(true);
			PublicFunc.SetIconFrameSprite(self.equipInfo.sp_frame,equip_cfg.rarity);
			self.equipInfo.letter:set_sprite_name("");
			self.equipInfo.labDes:set_text(equip_cfg.description);
			self.equipInfo.level:set_text("");
			self.equipInfo.allStar:set_active(false);
			self.equipInfo.cost:set_text(tostring(self.choseInfo.need_ships));
			self.equipInfo.attrGrid:set_active(false);
			self.equipInfo.desScroll:set_active(true);
			self.equipInfo.starRoot:set_active(false);
			self.equipInfo.labLetter:set_active(false);
			self.equipInfo.labAttr:set_active(false);
			return;
		end
	end
	self.equipInfo.name:set_text("");
	self.equipInfo.level:set_text("");
	self.equipInfo.sp:set_active(false);
	self.equipInfo.letter:set_sprite_name("");
	self.equipInfo.allStar:set_active(false);
	self.equipInfo.cost:set_text("");
	self.equipInfo.attrGrid:set_active(false);
end

function EggEquipExchangeUI:on_exchange()
	msg_activity.cg_niudan_exchange_equip(self.choseInfo.index);
end

function EggEquipExchangeUI:on_chose(t)
	local id = t.float_value;
	if self.choseInfo then
		self.choseObj:set_active(false);
	end
	self.choseObj = self.equipObjList[id];
	self.choseObj:set_active(true);
	self.choseInfo = ConfigManager.Get(EConfigIndex.t_niudan_equip_exchange,id);
	self:UpdateEquipInfo();
end

function EggEquipExchangeUI:on_init_item(obj,b,real_id)
	for i=1,self.col do
		local id = math.abs(real_id)*self.col+i;
		local cfg = ConfigManager.Get(EConfigIndex.t_niudan_equip_exchange,id);

		local _btn = ngui.find_button(obj,"small_card_item"..i.."/sp_back");
		if cfg then
			_btn:set_active(true);
			_btn:reset_on_click();
			_btn:set_event_value("",id);
			_btn:set_on_click(self.bindfunc["on_chose"]);
			local equip_cfg = PublicFunc.IdToConfig(cfg.equip_ID);
			local _spFrame = ngui.find_sprite(obj,"small_card_item"..i.."/sp_back/sp_frame");
			PublicFunc.SetIconFrameSprite(_spFrame,equip_cfg.rarity);
			self.temp = self.temp or {};
			self.temp[id] = ngui.find_texture(obj,"small_card_item"..i.."/sp_back/human/texture");
			self.temp[id]:set_texture(equip_cfg.small_icon);
			local sp_mark = ngui.find_sprite(obj,"small_card_item"..i.."/sp_back/sp_mark");
			sp_mark:set_active(false);
			local _spFrameBule = ngui.find_sprite(obj,"small_card_item"..i.."/sp_back/human/sp_shine");
			_spFrameBule:set_active(false);
			local lab_num = ngui.find_label(obj,"small_card_item"..i.."/sp_back/lab");
			lab_num:set_active(false);
			self.equipObjList = self.equipObjList or {};
			self.equipObjList[id] = _spFrameBule;
			if not self.choseInfo
			or (self.choseInfo and self.choseInfo.equip_ID == cfg.equip_ID) then
				self:on_chose({float_value=id});
			end
		else
			_btn:set_active(false);
		end
	end
end

function EggEquipExchangeUI:on_init_attr(obj,b,real_id)
	local _labName = ngui.find_label(obj,"lab_nature");
    -- local _labAttr = ngui.find_label(obj,"lab2");
    local _index = math.abs(real_id)+1;
    if self.equipDiffAttr then
	    local _attr = self.equipDiffAttr[_index];
	    if _attr then
	        _labName:set_text(_attr.value.._attr.showUnit.." "..gs_string_property_name[_attr.key]);
	        -- _labAttr:set_text(_attr.value.._attr.showUnit);
	    end
	end
end

function EggEquipExchangeUI:gc_niudan_exchange_equip(result,index)
	if tonumber(result) ~= 0 then
		PublicFunc.GetErrorString(result)
		--HintUI.SetAndShow(EHintUiType.zero,PublicFunc.GetErrorString(result));
		return;
	end
	local cfg = ConfigManager.Get(EConfigIndex.t_niudan_equip_exchange,index);
	CommonAward.Start({{id=cfg.equip_ID,count=1},},1);
	self:UpdateUi();
end

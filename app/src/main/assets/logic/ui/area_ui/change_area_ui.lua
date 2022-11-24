ChangeAreaUi = Class('ChangeAreaUi', UiBaseClass);

--重新开始
function ChangeAreaUi:Restart(data)
    UiBaseClass.Restart(self, data);
	ChangeAreaUi.areaData = {
		[1] = {
			id = 1;
			name = ConfigManager.Get(EConfigIndex.t_country_info,1).name,
			art_font_name = "cj_1qu1",
			qibao_sprite_name = "xq_qibiaohong",
			--texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_01qu.assetbundle"
            item_sprite_name = "xq_01qu"
		},
		[2] = {
			id = 2;
			name = ConfigManager.Get(EConfigIndex.t_country_info,2).name,
			art_font_name = "cj_11qu1",
			qibao_sprite_name = "xq_qibiaolan",
			--texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_11qu.assetbundle"
            item_sprite_name = "xq_11qu"
		},
		[3] = {
			id = 3;
			name = ConfigManager.Get(EConfigIndex.t_country_info,3).name,
			art_font_name = "cj_20qu1",
			qibao_sprite_name = "xq_qibiaozi",
			--texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_20qu.assetbundle"
            item_sprite_name = "xq_20qu"
		}
	}
end

function ChangeAreaUi:InitData(data)
    UiBaseClass.InitData(self, data);
	--[[ChangeAreaUi.areaData = {
		[1] = {
			id = 1;
			name = ConfigManager.Get(EConfigIndex.t_country_info,1).name,
			art_font_name = "cj_1qu1",
			qibao_sprite_name = "xq_qibiaohong",
			texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_01qu.assetbundle"
		},
		[2] = {
			id = 2;
			name = ConfigManager.Get(EConfigIndex.t_country_info,2).name,
			art_font_name = "cj_11qu1",
			qibao_sprite_name = "xq_qibiaolan",
			texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_11qu.assetbundle"
		},
		[3] = {
			id = 3;
			name = ConfigManager.Get(EConfigIndex.t_country_info,3).name,
			art_font_name = "cj_20qu1",
			qibao_sprite_name = "xq_qibiaozi",
			texturePath = "assetbundles/prefabs/ui/image/backgroud/xuanze_quyu/xq_20qu.assetbundle"
		}
	}]]
end

function ChangeAreaUi:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickSelect'] = Utility.bind_callback(self, self.onClickSelect);
	self.bindfunc['updateItem'] = Utility.bind_callback(self, self.updateItem);
	self.bindfunc['on_list_stop'] = Utility.bind_callback(self, self.on_list_stop);
	self.bindfunc['onClickCard'] = Utility.bind_callback(self, self.onClickCard);
	self.bindfunc['on_list_move_start'] = Utility.bind_callback(self, self.on_list_move_start);
	self.bindfunc['on_gc_select_country'] = Utility.bind_callback(self, self.on_gc_select_country);
end

function ChangeAreaUi:MsgRegist()
	PublicFunc.msg_regist(player.gc_select_country, self.bindfunc['on_gc_select_country'])
end

function ChangeAreaUi:MsgUnRegist()
	PublicFunc.msg_unregist(player.gc_select_country, self.bindfunc['on_gc_select_country'])
end

function ChangeAreaUi:InitUI(asset_obj)
	app.log("ChangeAreaUi:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	ChangeAreaUi.instance = self;
    self.ui:set_name('ChangeAreaUi');
    self.vs = {};
	--self.vs.bg = ngui.find_texture(self.ui,"texture_bk");
	--self.vs.bg:set_texture(ENUM.PublicBgImage.DLD);
	self.vs.enchanceSV = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/panel_scoll_view");
	self.vs.enchanceSV:set_on_initialize_item(self.bindfunc['updateItem']);
	self.vs.enchanceSV:set_on_stop_move(self.bindfunc['on_list_stop']);
	self.vs.enchanceSV:set_on_start_move(self.bindfunc['on_list_move_start']);
	self.vs.btnSelect = ngui.find_button(self.ui,"centre_other/animation/btn_select");
	self.vs.btnSelect:set_on_click(self.bindfunc['onClickSelect']);
	self.vs.enchanceSV:set_maxNum(3);
	self.vs.enchanceSV:set_index(1);
	self.vs.labDesc = ngui.find_label(self.ui,"centre_other/animation/cont/lab");
	self.curArea = ChangeAreaUi.areaData[1];
	local index = math.random(1, #ChangeAreaUi.areaData)
	self.vs.enchanceSV:set_showIndex(index)
	self:on_list_stop(index);
end


function ChangeAreaUi:Init(data)
	app.log("ChangeAreaUi:Init");
    self.pathRes = "assetbundles/prefabs/ui/area/ui_8006_xuan_ze_quyu.assetbundle";
	UiBaseClass.Init(self, data);
end

function ChangeAreaUi:updateItem(obj,index)
	self.areaCardList = self.areaCardList or {};
	local pid = obj:get_instance_id();
	self.areaCardList[pid] = self.areaCardList[pid] or self:createItem(obj);
	local data = ChangeAreaUi.areaData[index];
	if data ~= nil then 
		self.areaCardList[pid]:setData(data,index);
	end 
end 

function ChangeAreaUi:createItem(obj)
	local item = {};
	--item.tex = ngui.find_texture(obj,"texture");
    item.spItem = ngui.find_sprite(obj,"texture");
	item.baseItem = ngui.find_button(obj,obj:get_name());
	item.baseItem:set_on_ngui_click(self.bindfunc['onClickCard']);
	item.shineSp = ngui.find_sprite(obj,"sp_shine");
	item.nameLab = ngui.find_label(obj,"lab");
	--item.qibiao = ngui.find_sprite(obj,"sp_bk");
	function item:setData(data,index)
		if ChangeAreaUi.instance ~= nil then 
			local pself = ChangeAreaUi.instance;
			pself.indexObjList = pself.indexObjList or {};
			pself.indexObjList[index] = self;
		end
		--item.tex:set_texture(data.texturePath);
        item.spItem:set_sprite_name(data.item_sprite_name);
		item.baseItem:set_name(tostring(index));
		item.nameLab:set_text(data.name);
		--item.qibiao:set_sprite_name(data.qibao_sprite_name);
		item:setUnselect();
	end
	function item:setSelect()
		self.shineSp:set_active(true);
	end
	function item:setUnselect()
		self.shineSp:set_active(false);
	end
	return item;
end 

function ChangeAreaUi:onClickCard(name)
	local index = tonumber(name);
	self.vs.enchanceSV:tween_to_index(index);
end 

function ChangeAreaUi:on_list_stop(index)
	self.curArea = ChangeAreaUi.areaData[index];
	self.indexObjList = self.indexObjList or {};
	if self.indexObjList[index] ~= nil then 		
		if self.curSelectItem ~= nil then 
			self.curSelectItem:setUnselect();
		end 
		self.curSelectItem = self.indexObjList[index];
		self.indexObjList[index]:setSelect();
	end
	--FloatTip.Float("选择大区  "..self.curArea.name);
	self.vs.labDesc:set_text("选择大区  "..self.curArea.name);
end 

function ChangeAreaUi:on_list_move_start()
	if self.curSelectItem ~= nil then 
		self.curSelectItem:setUnselect();
		self.curSelectItem = nil;
	end
end 

function ChangeAreaUi:on_gc_select_country(areaid)
	FloatTip.Float("选择了"..tostring(self.curArea.name));	
	uiManager:PopUi();
end 

function ChangeAreaUi:onClickSelect()
	if self.curArea == nil then
		FloatTip.Float("还未选择区域");
		return
	end
	player.cg_select_country(self.curArea.id);
end 

--析构函数
function ChangeAreaUi:DestroyUi()
	ChangeAreaUi.instance = nil;
	self.curSelectItem = nil;
	self.indexObjList = nil;
	self.areaCardList = nil;

	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
end

--显示ui
function ChangeAreaUi:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function ChangeAreaUi:Hide()
    UiBaseClass.Hide(self);
end

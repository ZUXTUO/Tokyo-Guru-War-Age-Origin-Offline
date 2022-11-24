EggAwardShowUI = Class("EggAwardShowUI", UiBaseClass);

local _Text = 
{
	[1] = "道具",
	[2] = "角色",
}

function EggAwardShowUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/egg/ui_2605_egg.assetbundle";
    UiBaseClass.Init(self, data);
end

function EggAwardShowUI:InitData(data)
	self.listAward = {};
	self.listAwardSort = {};
	for k,v in pairs(ENUM.NiuDanType) do
		local cont = {};
		local contSort = {};
		local cfg = ConfigManager.Get(EConfigIndex.t_niudan_drop_show, v);
		for _,info in ipairs(cfg or {}) do
			cont[info.item_type] = cont[info.item_type] or {};
			table.insert(cont[info.item_type], info);
			if table.index_of(contSort, info.item_type) == -1 then
				table.insert(contSort, info.item_type);
			end
		end
		self.listAward[v] = cont;
		self.listAwardSort[v] = contSort;
	end
	app.log("listAwardSort...."..table.tostring(self.listAwardSort))
    UiBaseClass.InitData(self, data);
end

function EggAwardShowUI:Restart(data)
	self.showType = data;

	app.log("showType================"..tostring(self.showType))

    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function EggAwardShowUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_change_tog"] = Utility.bind_callback(self, self.on_change_tog);
    self.bindfunc["on_click_hero"] = Utility.bind_callback(self, self.on_click_hero);
    --self.bindfunc["on_next"] = Utility.bind_callback(self, self.on_next);
	--self.bindfunc["on_last"] = Utility.bind_callback(self, self.on_last);
	--self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
	self.bindfunc["on_hero"] = Utility.bind_callback(self, self.on_hero);
	self.bindfunc["on_item"] = Utility.bind_callback(self, self.on_item);

	self.bindfunc["on_btn_left"] = Utility.bind_callback(self, self.on_btn_left);
    self.bindfunc["on_btn_right"] = Utility.bind_callback(self, self.on_btn_right);
    self.bindfunc["on_start_pos"] = Utility.bind_callback(self, self.on_start_pos);
    self.bindfunc["on_end_pos"] = Utility.bind_callback(self, self.on_end_pos);
    self.bindfunc["on_stop_move"] = Utility.bind_callback(self, self.on_stop_move);
    self.bindfunc['on_select_role'] = Utility.bind_callback(self, self.on_select_role);
end

function EggAwardShowUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_2605_egg");

    --do return end
 --    self.contYeKa = {};
 --    for i=1,2 do
 --    	local cont = {};
	--     local obj = self.ui:get_child_by_name("centre_other/animation/yeka/yeka"..i); 
	--     cont.obj = obj;
	--     cont.lab1 = ngui.find_label(obj,"lab");
	--     cont.lab2 = ngui.find_label(obj,"lab_hui");
	--     cont.toggle = ngui.find_button(obj,obj:get_name());
	--     cont.toggle:set_on_click(self.bindfunc["on_change_tog"]);
	--     cont.toggle:set_event_value("", i);
	--     self.contYeKa[i] = cont;
	-- end

	self.role_btn = ngui.find_button(self.ui,"centre_other/animation/cont_yeka/animation/yeka_putong_liang")
	self.role_btn_sp = ngui.find_sprite(self.ui,"centre_other/animation/cont_yeka/animation/yeka_putong_liang/sp")
	self.role_btn:set_on_click(self.bindfunc["on_change_tog"]);
	self.role_btn:set_event_value("", 1);

	self.item_btn = ngui.find_button(self.ui,"centre_other/animation/cont_yeka/animation/yela_jingying_an")
	self.item_btn_sp = ngui.find_sprite(self.ui,"centre_other/animation/cont_yeka/animation/yela_jingying_an/sp")
	self.item_btn:set_on_click(self.bindfunc["on_change_tog"]);
	self.item_btn:set_event_value("", 2);

	self.button_animation = self.ui:get_child_by_name("centre_other/animation/cont_yeka/animation")

	self.btnNext = ngui.find_button(self.ui,"centre_other/animation/btn_right");
	self.btnNext:set_on_click(self.bindfunc["on_btn_left"]);
	self.btnLast = ngui.find_button(self.ui,"centre_other/animation/btn_left");
	self.btnLast:set_on_click(self.bindfunc["on_btn_right"]);

	--角色
	self.cont1 = {};
	local obj = self.ui:get_child_by_name("centre_other/animation/panel_list1");
	self.cont1.obj = obj
	
	-- self.cont1.texHuman = ngui.find_texture(obj,"texture_huamn");
	-- self.cont1.objTex = obj:get_child_by_name("texture_human");

	-- self.cont1.spAptitude = ngui.find_sprite(obj,"sp_quality");
	-- -- self.cont1.labDes = ngui.find_label(obj,"lab1");
	-- self.cont1.labName = ngui.find_label(obj,"lab_name");
	-- self.cont1.spProType = ngui.find_sprite(obj,"sp_shuxing");
	self.cont1.scrollView = ngui.find_enchance_scroll_view(obj,"panel_list1");
	-- self.cont1.wrapCont = ngui.find_wrap_content(obj,"panel_list1/panel_list/wrap_content");
	
	self.cont1.scrollView:set_on_initialize_item(self.bindfunc["on_hero"]);
	self.cont1.scrollView:set_on_stop_move(self.bindfunc["on_stop_move"]);
	self.cont1.scrollView:set_on_outstart(self.bindfunc["on_start_pos"]);
    self.cont1.scrollView:set_on_outend(self.bindfunc["on_end_pos"]);

	self.cont1.scrollView:set_maxNum(0);
    self.cont1.scrollView:refresh_list()

	--物品
	self.cont2 = {};
	local obj = self.ui:get_child_by_name("centre_other/animation/panel_list2");
	self.cont2.obj = obj
	self.cont2.scrollView = ngui.find_enchance_scroll_view(obj,"panel_list2");
	-- self.cont2.wrapCont = ngui.find_wrap_content(obj,"panel_list2/panel_list/wrap_content");
	self.cont2.scrollView:set_on_initialize_item(self.bindfunc["on_item"]);
	self.cont2.scrollView:set_on_stop_move(self.bindfunc["on_stop_move"]);
	self.cont2.scrollView:set_on_outstart(self.bindfunc["on_start_pos"]);
    self.cont2.scrollView:set_on_outend(self.bindfunc["on_end_pos"]);


	self.cont2.scrollView:set_maxNum(0);
    self.cont2.scrollView:refresh_list()

	-- local btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha");
	-- btnClose:set_on_click(self.bindfunc["on_close"]);

    self:UpdateUi();
end

function EggAwardShowUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    local sort = self.listAwardSort[self.showType];
    -- for k,cont in ipairs(self.contYeKa) do
    -- 	local itemType = sort[k];
    -- 	if itemType then
	   --  	cont.obj:set_active(true);
	   --  	cont.lab1:set_text(_Text[itemType]);
	   --  	cont.lab2:set_text(_Text[itemType]);
	   --  else
	   --  	cont.obj:set_active(false);
	   --  end
    -- end
    self.contHero = {};
	self.contItem = {}
	self.selectItem = nil;
	self.curIndex = 1;
    self:on_change_tog({float_value=1});

    --self:set_button()
end

function EggAwardShowUI:set_button()
	--0 角色  2 物品
	if self.showType == 0 then
		self.role_btn_sp:set_sprite_name("zhaomu_yeqian4")
		self.item_btn_sp:set_sprite_name("zhaomu_yeqian1")
	elseif self.showType == 2 then
		self.role_btn_sp:set_sprite_name("zhaomu_yeqian2")
		self.item_btn_sp:set_sprite_name("zhaomu_yeqian3")
	end
end

function EggAwardShowUI:DestroyUi()

	UiBaseClass.DestroyUi(self);


	--do return end
	self.selectItem = nil;
	self.curIndex = 1;

	self.curitemtype = nil;
    -- for k,v in pairs(self.contHero) do
    -- 	v.card:DestroyUi();
    -- end
    self.contHero = {};
    for k,v in pairs(self.contItem) do
		--app.log("v......."..table.tostring(v))
    	--for kk,vv in pairs(v.child) do
    		--app.log("vv......."..table.tostring(vv))
	    	v.child.card1:DestroyUi();
	    	v.child.card2:DestroyUi();
	    --end
    end
    self.contItem = {};
    if self.cont1.texHuman then
	    self.cont1.texHuman:Destroy();
	    self.cont1.texHuman = nil;
	end

	if self.cont1.scrollView then
		self.cont1.scrollView:destroy_object();
		self.cont1.scrollView = nil;
	end

	if self.cont2.scrollView then
		self.cont2.scrollView:destroy_object();
		self.cont2.scrollView = nil;
	end
    
end
--------------------------------------------
function EggAwardShowUI:UpdateRole()
	self.cont1.obj:set_active(true);
	self.cont2.obj:set_active(false);

	if not Utility.isEmpty(self.contHero) then
		return;
	end
	self.itemnum = #self.listAward[self.showType][2];
	-- self.cont1.wrapCont:set_min_index(0);
	-- self.cont1.wrapCont:set_max_index(num-1);
	-- self.cont1.wrapCont:reset();
	-- self.cont1.scrollView:reset_position();

	self._StopMoveIndex = 1;
    self.cont1.scrollView:set_index(self._StopMoveIndex)
    self:on_stop_move(self._StopMoveIndex)

	self.cont1.scrollView:set_maxNum(self.itemnum);
    self.cont1.scrollView:refresh_list();
    
end

function EggAwardShowUI:UpdateRoleUI(card_info, index)
	-- self.cont1.texBk
	-- self.cont1.texHuman:ChangeObj(card_info.number)
	local list = self.listAward[self.showType][2];
	local id = list[index].item_id;
	local cfg = ConfigManager.Get(EConfigIndex.t_niudan_drop_show_role, id);
	if cfg == nil then
		return;
	end
	if cfg.tex_path and cfg.tex_path ~= 0 then
		self.cont1.texHuman:set_active(true);
		self.cont1.texHuman:set_texture(cfg.tex_path);
		self.cont1.objTex:set_local_position(cfg.px,cfg.py,0);
		self.cont1.objTex:set_local_scale(cfg.sx,cfg.sy,1);
	else
		self.cont1.texHuman:set_active(false);
	end
	PublicFunc.SetAptitudeSprite(self.cont1.spAptitude, card_info.config.aptitude, true);
	--self.cont1.labDes:set_text(card_info.config.simple_describe);
	self.cont1.labName:set_text(card_info.name);
	PublicFunc.SetProTypePic(self.cont1.spProType, card_info.pro_type);

	-- if index == 1 then
	-- 	self.btnLast:set_active(false);
	-- else
	-- 	self.btnLast:set_active(true);
	-- end
	-- if index == #list then
	-- 	self.btnNext:set_active(false);
	-- else
	-- 	self.btnNext:set_active(true);
	-- end
end
--[[初始化角色的列表]]
function EggAwardShowUI:init_hero(obj)
    local cont = {}
    cont.obj = obj;
    --cont.card = SmallCardUi:new({parent=obj,stypes = {1,5,6,9}});
    --cont.card:SetCallback(self.bindfunc["on_click_hero"]);
    cont.texture_huamn = ngui.find_texture(obj,"texture_huamn")
    cont.sp_quality = ngui.find_sprite(obj,"sp_quality_di/sp_quality")
    cont.sp_shuxing = ngui.find_sprite(obj,"sp_shuxing")
    cont.lab_name = ngui.find_label(obj,"sp_name_di/lab_name")
    cont.sp_art_font = ngui.find_sprite(obj,"sp_art_font")
    cont.sp_art_font:set_active(false)
    cont.fx = obj:get_child_by_name("fx_ui_2605_egg")
    cont.sp_di = ngui.find_sprite(obj,"sp_name_di")
    cont.button = ngui.find_button(obj,obj:get_name())
    return cont;
end

function EggAwardShowUI:update_hero(cont, index)
	--app.log("update_hero....."..table.tostring(cont))
	local cfg = self.listAward[self.showType][2][index];
	-- cont.card:SetDataNumber(cfg.item_id);
	-- cont.card:SetParam(index)
	-- if self.curIndex == index then
	-- 	self:on_click_hero(cont.card, cont.card:GetCardInfo(), index);sp_name_di
	-- end
	local roleinfo = CardHuman:new({number=cfg.item_id});
	app.log("index......"..tostring(index))

	if cfg then
		cont.texture_huamn:set_texture(roleinfo.icon300)
		PublicFunc.SetAptitudeSprite(cont.sp_quality,roleinfo.config.aptitude, true);
		PublicFunc.SetProTypeFont(cont.sp_shuxing, roleinfo.pro_type);
		cont.lab_name:set_text(roleinfo.name);
		cont.button:set_on_ngui_click(self.bindfunc['on_select_role']);
		cont.button:set_name(tostring(index))
		if cfg.rare == 1 then
			cont.sp_di:set_sprite_name("zhaomu_tujian_di5")
			cont.sp_art_font:set_active(true)
			cont.fx:set_active(true)
		else
			cont.sp_di:set_sprite_name("zhaomu_tujian_di4")
			cont.sp_art_font:set_active(false)
			cont.fx:set_active(false)
		end
	end
end

function EggAwardShowUI:on_select_role(name)
	local index = tonumber(name);
	local cfg = self.listAward[self.showType][2][index];
	local roleinfo = CardHuman:new({number=cfg.item_id});
	local awardlist = self.listAward[self.showType][2]
	app.log("on_select_role...."..tostring(index))
	local data = {
					awardlist = awardlist;
					index = index
					}
	uiManager:PushUi(EUI.EggHeroShowUI,data);
end

function EggAwardShowUI:on_click_hero(obj, card_info, param)
	if self.selectItem then
		self.selectItem:ChoseItem(false);
	end
	self.curIndex = param;
	self.selectItem = obj;
	if obj then
		obj:ChoseItem(true);
	end
	self:UpdateRoleUI(card_info, param);
end

function EggAwardShowUI:UpdateItem()
	self.cont1.obj:set_active(false);
	self.cont2.obj:set_active(true);

	local allnum = #self.listAward[self.showType][1];
	--app.log("allitem//////"..table.tostring(self.listAward[self.showType][1]))

	--app.log("allnum..........."..tostring(allnum))
	-- self.cont2.wrapCont:set_min_index(0);
	-- self.cont2.wrapCont:set_max_index(math.ceil(num/2) - 1)
	-- self.cont2.wrapCont:reset();
	-- self.cont2.scrollView:reset_position();
	self.itemnum = math.ceil(allnum/2)
	--app.log("number---------------"..tostring(self.itemnum))
	
    self._StopMoveIndex = 1;
    self.cont2.scrollView:set_index(self._StopMoveIndex)
    self:on_stop_move(self._StopMoveIndex)

    self.cont2.scrollView:set_maxNum(self.itemnum);
	self.cont2.scrollView:refresh_list();
    -- self.cont2.scrollView:set_on_stop_move(self.bindfunc["on_stop_move"]);
    -- self.cont2.scrollView:set_on_outstart(self.bindfunc["on_start_pos"]);
    -- self.cont2.scrollView:set_on_outend(self.bindfunc["on_end_pos"]);
    
    

end
--[[初始化道具的列表]]
function EggAwardShowUI:init_item(obj)
	--app.log("init_item...index.."..tostring(index))
    local cont = {}
    cont.obj = obj;
    cont.child = {};
    --for i=1, 6 do
    local child = {};
    child.obj1 = obj:get_child_by_name("sp_di1");
    local node = child.obj1:get_child_by_name("new_small_card_item");
    child.card1 = UiSmallItem:new({parent=node});
    child.card1:SetShowNumber(false);
    child.card1:SetEnablePressGoodsTips(true);
    child.name1 = ngui.find_label(child.obj1,"lab_name");
	--
	child.obj2 = obj:get_child_by_name("sp_di2");
	local node = child.obj2:get_child_by_name("new_small_card_item");
    child.card2 = UiSmallItem:new({parent=node});
    child.card2:SetShowNumber(false);
    child.card2:SetEnablePressGoodsTips(true);
    child.name2 = ngui.find_label(child.obj2,"lab_name");

    cont.child = child;

    return cont;
end

function EggAwardShowUI:update_item(cont, index)
	local list = self.listAward[self.showType][1];
	--do return end
	-- for i=1, 5 do
	-- 	local child_index = (index-1)*5 + i;
	-- 	local cfg = list[child_index];
	-- 	local child = cont.child[i];
	-- 	if cfg then
	-- 		child.obj:set_active(true);
	-- 		child.card:SetDataNumber(cfg.item_id);
	-- 		child.name:set_text(child.card:GetCardInfo().name);
	-- 	else
	-- 		child.obj:set_active(false);
	-- 	end
	-- end
	--app.log("cont=========child====="..table.tostring(cont.child))
	--app.log("cont=========obj====="..table.tostring(cont.obj))
	index = (math.ceil(index/5)-1)*5+index;
	--app.log("index："..tostring(index))
	local child = cont.child;
	local cfg = list[index]
	if cfg then
		child.obj1:set_active(true)
		child.card1:SetDataNumber(cfg.item_id);
		child.name1:set_text(child.card1:GetCardInfo().name);
	else
		child.obj1:set_active(false)
	end

	local child_index = 5+index
	local cfg = list[child_index]
	--app.log("child_index:"..tostring(child_index))	
	if cfg then
		child.obj2:set_active(true)
		child.card2:SetDataNumber(cfg.item_id);
		child.name2:set_text(child.card2:GetCardInfo().name);
	else
		child.obj2:set_active(false)
	end
end
--------------------------------------------
function EggAwardShowUI:on_change_tog(t)
	local index = t.float_value;
	--app.log("on_change_tog...index:"..tostring(index))
	
	self.itemType = self.listAwardSort[self.showType][index];
	--app.log("on_change_tog...itemType:"..tostring(self.itemType))
	if self.itemType == 1 then
		--app.log("11111111111111111111111111111111111")
		-- 道具

		self.item_btn_sp:set_depth(310)

		--self:set_itembutton()
		if self.itemType == self.curitemtype then
			do return end
		end
		self.button_animation:animated_play("jiao_se")
		self:UpdateItem();
		self.curitemtype = 1;
	elseif self.itemType == 2 then
		--app.log("2222222222222222222222222222222222222")
		-- 角色
		--self:set_rolebutton()

		self.item_btn_sp:set_depth(309)

		if self.itemType == self.curitemtype then
			do return end
		end
		self.button_animation:animated_play("dao_ju")
		self:UpdateRole();
		self.curitemtype = 2;
	end

	if index == 1 then
		if self.itemType == 1 then
			self.role_btn_sp:set_sprite_name("")
		end
	end

end

function EggAwardShowUI:on_next()
	local cont = nil;
	for k,v in pairs(self.contHero) do
		if v.index == self.curIndex + 1 then
			cont = v;
		end
	end
	if cont then
		self:on_click_hero(cont.card, cont.card:GetCardInfo(), self.curIndex+1);
	else
		local number = self.listAward[self.showType][2][self.curIndex + 1].item_id;
		self:on_click_hero(nil, CardHuman:new({number=number}), self.curIndex+1);
	end
end

function EggAwardShowUI:on_last()
	local cont = nil;
	for k,v in pairs(self.contHero) do
		if v.index == self.curIndex - 1 then
			cont = v;
		end
	end
	if cont then
		self:on_click_hero(cont.card, cont.card:GetCardInfo(), self.curIndex-1);
	else
		local number = self.listAward[self.showType][2][self.curIndex - 1].item_id;
		self:on_click_hero(nil, CardHuman:new({number=number}), self.curIndex-1);
	end
end

function EggAwardShowUI:on_close()
	uiManager:PopUi();
end

function EggAwardShowUI:on_hero(obj, index)
    --local index = math.abs(real_id)+1;
    -- if Utility.isEmpty(self.contHero[b]) then
    --     self.contHero[b] = self:init_hero(obj)
    -- end
    -- self.contHero[b].index = index;
    -- local row = obj:get_instance_id();
    --app.log("on_hero....obj."..table.tostring(obj))
    --self:update_hero(self.contHero[b], index);

    local b = obj:get_instance_id();
    if Utility.isEmpty(self.contHero[b]) then
        self.contHero[b] = self:init_hero(obj)
    end
    self:update_hero(self.contHero[b], index);
    --self.contHero[b]:SetCallback(self.bindfunc['on_select_role']);
end

function EggAwardShowUI:on_item(obj, index)
    --local index = math.abs(real_id)+1;
    -- app.log("on_item....."..tostring(index))
    -- --do return end

    -- if Utility.isEmpty(self.contItem[b]) then
    --     self.contItem[b] = self:init_item(obj,index)
    -- end
    --self:update_item(self.contItem[b], index);
    -- local row = obj:get_instance_id();
    -- local list = self.listAward[self.showType][1];
    -- app.log("on_item......list"..table.tostring(list))
    -- app.log("obj-name....."..obj:get_name())

    local b = obj:get_instance_id();
    if Utility.isEmpty(self.contItem[b]) then
        self.contItem[b] = self:init_item(obj)
    end
    self:update_item(self.contItem[b], index);
end

function EggAwardShowUI:on_btn_right()

    local index = self._StopMoveIndex - 5
    if index < 1 then
        index = 1
    end
    if self.itemType == 2 then
    	self.cont1.scrollView:tween_to_index(index)
    else
    	self.cont2.scrollView:tween_to_index(index)
    end
end

function EggAwardShowUI:on_btn_left()
    local index = self._StopMoveIndex + 5
    if index > self.itemnum then
        index = self.itemnum
    end
    if self.itemType == 2 then
    	self.cont1.scrollView:tween_to_index(index)
    else
 		self.cont2.scrollView:tween_to_index(index)
 	end
end

function EggAwardShowUI:on_start_pos(isStart)
	--app.log("on_start_pos"..tostring(isStart))
    self.btnLast:set_active(not isStart);
end

function EggAwardShowUI:on_end_pos(isEnd)
	--app.log("on_end_pos"..tostring(isEnd))
    self.btnNext:set_active(not isEnd);
end

function EggAwardShowUI:on_stop_move(index)
	--app.log("_StopMoveIndex"..tostring(index))
    self._StopMoveIndex = index
end


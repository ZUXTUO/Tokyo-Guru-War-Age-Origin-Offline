ShareUI = Class("ShareUI", UiBaseClass);

function ShareUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_8004_share.assetbundle";
    UiBaseClass.Init(self, data);
end

function ShareUI:InitData(data)
    UiBaseClass.InitData(self, data);
    --self.allsharedatalist = ConfigManager._GetConfigTable(EConfigIndex.t_share_activity);
    
    self.currentpage = 1;
    
    self.powerlist = {};
    self.lvllist = {};
    self.playerlist = {};
end

function ShareUI:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ShareUI:DestroyUi()

    UiBaseClass.DestroyUi(self);
end

function ShareUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change);
	self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content);
	self.bindfunc["open_share_ui"] = Utility.bind_callback(self, self.open_share_ui);
	self.bindfunc["get_share_award"] = Utility.bind_callback(self,self.get_share_award)
	self.bindfunc["updatainfo"] = Utility.bind_callback(self,self.updatainfo)
end

function ShareUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_share_activity_state, self.bindfunc["updatainfo"])
    PublicFunc.msg_regist(msg_activity.gc_share_activity_complete, self.bindfunc["updatainfo"])
    PublicFunc.msg_regist(msg_activity.gc_share_activity_get_award, self.bindfunc["updatainfo"])
end

function ShareUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_share_activity_state, self.bindfunc["updatainfo"])
    PublicFunc.msg_regist(msg_activity.gc_share_activity_complete, self.bindfunc["updatainfo"])
    PublicFunc.msg_regist(msg_activity.gc_share_activity_get_award, self.bindfunc["updatainfo"])
end

function ShareUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("ShareUI");
	self.gridtab = ngui.find_grid(self.ui,"center_other/animation/yeka")
	self.yekaList = {}
	for i=1,3 do
		self.yekaList[i] = ngui.find_toggle(self.ui,"center_other/animation/yeka/yeka"..i)
		self.yekaList[i]:set_on_change(self.bindfunc["on_toggle_change"])
	end

	self.itemlist = {}

	self.scroll_view = ngui.find_scroll_view(self.ui,"center_other/animation/sco_view/panel")
	self.wrap_content = ngui.find_wrap_content(self.ui,"center_other/animation/sco_view/panel/wrap_content")
	self.wrap_content:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);

	self.wrap_content:set_min_index(0);
    self.wrap_content:set_max_index(-1);
    self.wrap_content:reset();
    msg_activity.cg_share_activity_state()
end

function ShareUI:on_toggle_change(value,name)
	--app.log("value============"..tostring(value).." name----------------"..tostring(name))
	if value == true and name == "yeka1" then
		self.currentpage =1;
		local num = table.getall(self.powerlist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	elseif value == true and name == "yeka2" then
		self.currentpage = 2;
		local num = table.getall(self.lvllist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	elseif value == true and name == "yeka3" then
		self.currentpage =3;
		local num = table.getall(self.playerlist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	end
	
end

function ShareUI:updatainfo()

    -- self.powerlist = g_dataCenter.activityShare:getPowerlist();
    -- self.lvllist = g_dataCenter.activityShare:getlvllist();
    -- self.playerlist = g_dataCenter.activityShare:getplayerlist();
  	local ttpowerlist = {}
  	local ttlvllist = {}
  	local ttplayerlist = {}

    self.powerlist = {};
    self.lvllist = {};
    self.playerlist = {};

    local tpowerlist = g_dataCenter.activityShare:getPowerlist();
    local tlvllist = g_dataCenter.activityShare:getlvllist();
    local tplayerlist = g_dataCenter.activityShare:getplayerlist();
    local allinfodata = g_dataCenter.activityShare:getAllData();

    if allinfodata == nil then
    	app.log("没有接收到服务器的活动分享数据！")
    	do return end
    end

    for k,v in ipairs(tpowerlist) do
    	if allinfodata[v.id].state ~= 3 then
    		table.insert(self.powerlist,v)
    	else
    		table.insert(ttpowerlist,v)
    	end
    end

    for k,v in ipairs(ttpowerlist) do
    	table.insert(self.powerlist,v)
    end
    -----------------------------------------------
    for k,v in ipairs(tlvllist) do
    	if allinfodata[v.id].state ~= 3 then
    		table.insert(self.lvllist,v)
    	else
    		table.insert(ttlvllist,v)
    	end
    end

    for k,v in ipairs(ttlvllist) do
    	table.insert(self.lvllist,v)
    end
    -------------------------------------------------
    for k,v in ipairs(tplayerlist) do
    	if allinfodata[v.id].state ~= 3 then
    		table.insert(self.playerlist,v)
    	else
    		table.insert(ttplayerlist,v)
    	end
    end

    for k,v in ipairs(ttplayerlist) do
    	table.insert(self.playerlist,v)
    end

    -- local sortFunc = function(a,b)
    	
    -- 	if allinfodata[a.id].state == allinfodata[b.id].state then
    -- 		return false
    -- 	else
    -- 		if a.id < b.id then
    -- 			return true
    -- 		else
    -- 			return false
    -- 		end
    -- 	end

    -- 	if allinfodata[a.id].state == 3 or allinfodata[b.id].state == 3 then
    -- 		return false
    -- 	else
    -- 		if a.id < b.id then
    -- 			return true
    -- 		else
    -- 			return false
    -- 		end
    -- 	end

    	
    -- end

    -- table.sort(tpowerlist,sortFunc);
    
    -- for k,v in pairs(tpowerlist) do
    --    table.insert(  self.powerlist,v )   
    -- end

    -- table.sort(tlvllist,sortFunc);
    
    -- for k,v in pairs(tlvllist) do
    --    table.insert(  self.lvllist,v )   
    -- end

    -- table.sort(tplayerlist,sortFunc);
    
    -- for k,v in pairs(tplayerlist) do
    --    table.insert(  self.playerlist,v )   
    -- end


	if self.currentpage == 1 then
		local num = table.getall(self.powerlist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	elseif self.currentpage == 2 then
		local num = table.getall(self.lvllist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	elseif self.currentpage == 3 then
		local num = table.getall(self.playerlist)
		--app.log("#self.powerlist"..tostring(num))
		self.wrap_content:set_min_index(-num+1);
	    self.wrap_content:set_max_index(0);
	    self.wrap_content:reset();
    	self.scroll_view:reset_position();
	end
	--排序
end

function ShareUI:init_item_wrap_content(obj, b, real_id)
	
	local index = math.abs(real_id) + 1;
	local index_b = math.abs(b) + 1;
	
	app.log("index    "..tostring(index))
	--app.log("index_b    "..tostring(index_b))

	local title_lab = ngui.find_label(obj,"lab")
	local lab_progress = ngui.find_label(obj,"lab_progress")

	local shareBtn = ngui.find_button(obj,"btn1")
	shareBtn:reset_on_click()
	shareBtn:set_on_click(self.bindfunc["open_share_ui"])

	local getBtn = ngui.find_button(obj,"btn2")
	getBtn:reset_on_click()
	getBtn:set_on_click(self.bindfunc["get_share_award"])

	local ylqBtn = ngui.find_sprite(obj,"sp_yilingqu")
	ylqBtn:set_active(false)

	local titeltext = ""
	local progresstext = ""
	local awarditemlist = {}
	local key = 0
	if self.currentpage == 1 then
		local data = self.powerlist[index]
		--app.log("data    "..table.tostring(data))
		titeltext = data.des
		progresstext = data.need
		awarditemlist = data.item
		key = data.id
		local fightvalue = g_dataCenter.activityShare:GetProgress(key)
		-- if fightvalue >= progresstext then
		-- 	fightvalue = progresstext
		-- end
		lab_progress:set_text(tostring(fightvalue).."/"..tostring(progresstext))

	elseif self.currentpage == 2 then
		local data = self.lvllist[index]
		--app.log("data    "..table.tostring(data))
		titeltext = data.des
		progresstext = data.need
		awarditemlist = data.item
		key = data.id
		local lvl = g_dataCenter.activityShare:GetProgress(key)
		-- if lvl >= progresstext then
		-- 	lvl = progresstext
		-- end
		lab_progress:set_text(tostring(lvl).."/"..tostring(progresstext))
	elseif self.currentpage == 3 then
		local data = self.playerlist[index]
		--app.log("data    "..table.tostring(data))
		titeltext = data.des
		progresstext = data.need
		awarditemlist = data.item
		key = data.id
		--local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have); 
		local haveheronumber = g_dataCenter.activityShare:GetProgress(key)
		-- if haveheronumber >= progresstext then
		-- 	haveheronumber = progresstext
		-- end
		lab_progress:set_text(tostring(haveheronumber).."/"..tostring(progresstext))
	end

	local flag = g_dataCenter.activityShare:GetSatte(key)  --0 没有达到条件 1 达到条件 2 没有领取奖励 3 已领取奖励
	
	--app.log("flag-==========="..tostring(flag))

	if flag == 0 then
		shareBtn:set_active(true)
		PublicFunc.SetButtonShowMode(shareBtn,3)
		shareBtn:set_enable(false)
		getBtn:set_active(false)
		ylqBtn:set_active(false)
	elseif flag == 1 then
		shareBtn:set_active(true)
		PublicFunc.SetButtonShowMode(shareBtn,1)
		shareBtn:set_enable(true)
		getBtn:set_active(false)
		ylqBtn:set_active(false)
	elseif flag == 2 then
		shareBtn:set_active(false)
		getBtn:set_active(true)
		PublicFunc.SetButtonShowMode(getBtn,1)
		ylqBtn:set_active(false)
	elseif flag == 3 then
		shareBtn:set_active(false)
		getBtn:set_active(false)
		ylqBtn:set_active(true)
	end

	title_lab:set_text(titeltext)
	
	--do return end
	if self.itemlist[index_b] == nil then
		self.itemlist[index_b] = {};
	end

	for i=1,3 do
		local small_card_item = obj:get_child_by_name("grid/new_small_card_item"..i)
		if awarditemlist[i] then
			small_card_item:set_active(true)
			local carditem = CardProp:new({number = awarditemlist[i].item_id, count = awarditemlist[i].item_num});
			
			if self.itemlist[index_b][i] == nil then
				self.itemlist[index_b][i] = UiSmallItem:new({parent = small_card_item, cardInfo = carditem});
				self.itemlist[index_b][i]:SetCount(awarditemlist[i].item_num)
			else
				self.itemlist[index_b][i]:SetData(carditem);
				self.itemlist[index_b][i]:SetCount(awarditemlist[i].item_num)
			end
		else
			small_card_item:set_active(false)
		end
	end
	
	shareBtn:set_event_value("",key)
	getBtn:set_event_value("",key)
end

function ShareUI:open_share_ui(t)
	local index = t.float_value;
	--app.log("open_share_ui index======="..tostring(index))
	msg_activity.cg_share_activity_complete(index)
	uiManager:PushUi(EUI.ShareUIActivity,self.currentpage);

end

function ShareUI:get_share_award(t)
	local index = t.float_value;
	--app.log("get_share_award index======="..tostring(index))
	msg_activity.cg_share_activity_get_award(index)
end

function ShareUI:Show()
	--app.log("ShareUIshow======================")
	if UiBaseClass.Show(self) then
		--app.log("ShareUIshow======================11111")
		if self.currentpage == 1 then
			self.yekaList[1]:set_value(true)
			self.yekaList[2]:set_value(false)
			self.yekaList[3]:set_value(false)
		elseif self.currentpage == 2 then
			self.yekaList[1]:set_value(false)
			self.yekaList[2]:set_value(true)
			self.yekaList[3]:set_value(false)
		elseif self.currentpage == 3 then
			self.yekaList[1]:set_value(false)
			self.yekaList[2]:set_value(false)
			self.yekaList[3]:set_value(true)
		end
	end
end
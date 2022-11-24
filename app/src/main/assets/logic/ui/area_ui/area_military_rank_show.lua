AreaMilitaryRankShow = Class('AreaMilitaryRankShow', UiBaseClass);

function AreaMilitaryRankShow.popPanel()
	AreaMilitaryRankShow.instance = AreaMilitaryRankShow:new();
end 

--重新开始
function AreaMilitaryRankShow:Restart(data)
    --app.log("AreaMilitaryRankShow:Restart");
    UiBaseClass.Restart(self, data);
end

function AreaMilitaryRankShow:InitData(data)
    --app.log("AreaMilitaryRankShow:InitData");
    UiBaseClass.InitData(self, data);
end

function AreaMilitaryRankShow:RegistFunc()
	--app.log("AreaMilitaryRankShow:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickMask'] = Utility.bind_callback(self, self.onClickMask);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
end

function AreaMilitaryRankShow:InitUI(asset_obj)
	app.log("AreaMilitaryRankShow:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('AreaMilitaryRankShow');
    self.vs = {};
	self.vs.scrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/scro_view/panel");
	self.vs.wrapContent = ngui.find_wrap_content(self.ui,"centre_other/animation/scro_view/panel/wrap_content");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onClickMask'])
	self.vs.wrapContent:set_on_initialize_item(self.bindfunc["init_item"]);
	self.vs.wrapContent:set_min_index(-math.ceil(#AreaMilitaryRank.cfMilitaryRank/2) + 1)
    self.vs.wrapContent:set_max_index(0)
    self.vs.wrapContent:reset() 
	self.vs.scrollView:reset_position();
end

function AreaMilitaryRankShow:init_item(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local data1 = AreaMilitaryRank.cfMilitaryRank[index];
	local data2 = AreaMilitaryRank.cfMilitaryRank[index+math.floor(#AreaMilitaryRank.cfMilitaryRank/2)];
	self.itemList = self.itemList or {};
	local pid = obj:get_instance_id();
	self.itemList[pid] = self.itemList[pid] or self:createRankListItem(obj);
	local item = self.itemList[pid];
	if data1 == nil then 
		return;
	end
	item:setData(data1,data2,index); 
end 

function AreaMilitaryRankShow:createRankListItem(obj)
	local item = {};
	item.spItem1 = ngui.find_sprite(obj,"sp_ badge1");
	item.spItem2 = ngui.find_sprite(obj,"sp_ badge2");
	item.lab1 = ngui.find_label(obj,"sp_ badge1/lab");
	item.lab2 = ngui.find_label(obj,"sp_ badge2/lab");
	function item:setData(data1,data2,index)
		
		if data1 ~= nil then 
			self.lab1:set_text(data1.military_rank_name..":[8AF529FF]"..tostring(data1.upgrade_need_exploit).."[-]");
			self.spItem1:set_active(true);
		else 
			self.spItem1:set_active(false);
		end
		if data2 ~= nil then 
			self.lab2:set_text(data2.military_rank_name..":[8AF529FF]"..tostring(data2.upgrade_need_exploit).."[-]");
			self.spItem2:set_active(true);
		else 
			self.spItem2:set_active(false);
		end
	end
	return item;
end 

function AreaMilitaryRankShow:onClickMask()
	self:Hide();
	self:DestroyUi();
end 

function AreaMilitaryRankShow:Init(data)
	app.log("AreaMilitaryRankShow:Init");
    self.pathRes = "assetbundles/prefabs/ui/area/ui_8003_xuan_ze_quyu.assetbundle";
	UiBaseClass.Init(self, data);
end

function AreaMilitaryRankShow.destroy()
	if AreaMilitaryRankShow.instance ~= nil then 
		AreaMilitaryRankShow.instance:Hide();
		AreaMilitaryRankShow.instance:DestroyUi();
	end
end 

--析构函数
function AreaMilitaryRankShow:DestroyUi()
	app.log("AreaMilitaryRankShow:DestroyUi");
	AreaMilitaryRankShow.instance = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
end

--显示ui
function AreaMilitaryRankShow:Show()
	app.log("AreaMilitaryRankShow:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function AreaMilitaryRankShow:Hide()
	app.log("AreaMilitaryRankShow:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function AreaMilitaryRankShow:MsgRegist()
	app.log("AreaMilitaryRankShow:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function AreaMilitaryRankShow:MsgUnRegist()
	app.log("AreaMilitaryRankShow:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
AreaMilitaryRank = Class('AreaMilitaryRank', UiBaseClass);

function AreaMilitaryRank.popPanel(rankDatas)
	if rankDatas == nil then 
		rankDatas = {};
		for i = 1,40 do 
			table.insert(rankDatas,AreaMilitaryRank.DataCreator(i));
		end
		rankDatas.my_rank = rankDatas[math.random(1,40)];
	end
	AreaMilitaryRank.instance = AreaMilitaryRank:new(rankDatas);
end 

--重新开始
function AreaMilitaryRank:Restart(data)
    --app.log("AreaMilitaryRank:Restart");
    UiBaseClass.Restart(self, data);
	self.rankDatas = data;
	if AreaMilitaryRank.cfMilitaryRank == nil then 
		local cfMilitaryRank = ConfigManager._GetConfigTable(EConfigIndex.t_military_rank);
		AreaMilitaryRank.cfMilitaryRank = cfMilitaryRank;
	end 
end

function AreaMilitaryRank:InitData(data)
    --app.log("AreaMilitaryRank:InitData");
    UiBaseClass.InitData(self, data);
	self.rankDatas = data;
	if AreaMilitaryRank.cfMilitaryRank == nil then 
		local cfMilitaryRank = ConfigManager._GetConfigTable(EConfigIndex.t_military_rank);
		AreaMilitaryRank.cfMilitaryRank = cfMilitaryRank;
	end 
end

function AreaMilitaryRank:RegistFunc()
	--app.log("AreaMilitaryRank:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_click_close_btn'] = Utility.bind_callback(self, self.on_click_close_btn);
	self.bindfunc['on_rank_data_get'] = Utility.bind_callback(self, self.on_rank_data_get);
	self.bindfunc['on_click_more_rank_button'] = Utility.bind_callback(self, self.on_click_more_rank_button);
	self.bindfunc['on_click_get_reward'] = Utility.bind_callback(self, self.on_click_get_reward);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
	self.bindfunc['onUpgradeMilitaryRank'] = Utility.bind_callback(self, self.onUpgradeMilitaryRank);
	self.bindfunc['gotMilitaryRankReward'] = Utility.bind_callback(self, self.gotMilitaryRankReward);
	self.bindfunc['onClickItem'] = Utility.bind_callback(self, self.onClickItem);
end

function AreaMilitaryRank:InitUI(asset_obj)
	app.log("AreaMilitaryRank:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name('AreaMilitaryRank');
    self.vs = {};
	self.vs.title = ngui.find_label(self.ui,"centre_other/animation/cont_bg/lbl_title");
	self.vs.rankIconRoom = ngui.find_texture(self.ui,"centre_other/animation/cont_left/new_small_card_item");
	self.vs.labRankName = ngui.find_label(self.ui,"centre_other/animation/cont_left/lbl_guild_name");
	self.vs.labCurrentExploit = ngui.find_label(self.ui,"centre_other/animation/cont_left/txt_gong_xun/lbl_1");
	self.vs.labHistroyExploit = ngui.find_label(self.ui,"centre_other/animation/cont_left/txt_gong_xun/lbl_2");
	self.vs.labTodayExploit= ngui.find_label(self.ui,"centre_other/animation/cont_left/txt_gong_xun/lbl_3");
	self.vs.labCurrentExploit:set_text("当前功勋:[05ED3FFF]"..tostring(g_dataCenter.area.curExploit).."[-]");
	self.vs.labHistroyExploit:set_text("累积功勋:[05ED3FFF]"..tostring(g_dataCenter.area.totalExploit).."[-]");
	self.vs.labTodayExploit:set_text("今日功勋:[05ED3FFF]"..tostring(g_dataCenter.area.todayExploit).."[-]");
	self.vs.labRankUpgrade = ngui.find_label(self.ui,"centre_other/animation/cont_left/txt_jun_xian/lbl_1");
	self.vs.btnMoreRank = ngui.find_button(self.ui,"centre_other/animation/cont_left/txt_jun_xian/btn");
	--self.vs.btnRankText = ngui.find_label(self.ui,"centre_other/animation/cont_left/btn/animation/lbl");
	self.vs.rewardShow1 = self.ui:get_child_by_name("centre_other/animation/cont_left/txt_jiang_li/new_small_card_item1")
	self.vs.rewardShow2 = self.ui:get_child_by_name("centre_other/animation/cont_left/txt_jiang_li/new_small_card_item2")
	self.vs.btnGetReward = ngui.find_button(self.ui,"centre_other/animation/cont_left/txt_jiang_li/btn")
	self.vs.labGetReward = ngui.find_label(self.ui,"centre_other/animation/cont_left/txt_jiang_li/btn/animation/lbl");
	self.vs.btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['on_click_close_btn'])
	self.vs.btnMoreRank:set_on_click(self.bindfunc['on_click_more_rank_button']);
	self.vs.btnGetReward:set_on_click(self.bindfunc['on_click_get_reward']);
	self.vs.selfInfoNumRank = ngui.find_label(self.ui,"centre_other/animation/cont1/cont1/lbl_rank");
	self.vs.selfInfoFirstRank = ngui.find_sprite(self.ui,"centre_other/animation/cont1/cont1/sp_rank_icon");
	self.vs.selfInfoNoRank = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_norl");
	self.vs.myChenghao = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_damage_value");
	self.vs.myChenghao:set_active(false);
	self.vs.myName = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lab_name");
	self.vs.myRank = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_level");
	self.vs.myExploit = ngui.find_label(self.ui,"centre_other/animation/cont1/cont2/lbl_num");
	self.vs.scrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view");
	self.vs.wrapContent = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view/wrap_content");
	self.vs.scrollView:reset_position();
	self.vs.wrapContent:set_on_initialize_item(self.bindfunc["init_item"]);
	self.vs.wrapContent:reset();
	if self.rankDatas ~= nil then 
		self:UpdateUi();
	end 
end

function AreaMilitaryRank:init_item(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local data = self.rankDatas[index];
	if data == nil then 
		do return end;
	end
	self.rankItemList = self.rankItemList or {};
	local pid = obj:get_instance_id();
	self.rankItemList[pid] = self.rankItemList[pid] or self:createRankListItem(obj);
	local rankItem = self.rankItemList[pid];
	if data == nil then 
		return;
	end
	rankItem:setData(data,index); 
end 

function AreaMilitaryRank:createRankListItem(obj)
	local rankItem = {};
	rankItem.infoBg = ngui.find_sprite(obj,"sp_bg");
	rankItem.infoNumRank = ngui.find_label(obj,"cont1/lbl_rank");
	rankItem.infoFirstRank = ngui.find_sprite(obj,"cont1/sp_rank_icon");
	rankItem.infoSpSelf = ngui.find_sprite(obj,"cont1/sp_self");
	rankItem.name = ngui.find_label(obj,"cont2/lab_name");
	rankItem.chengHao = ngui.find_label(obj,"cont2/lbl_damage_value");
	rankItem.chengHao:set_active(false);
	rankItem.exploit_num = ngui.find_label(obj,"cont2/lbl_num");
	rankItem.military_rank = ngui.find_label(obj,"cont2/lbl_level");
	rankItem.touchSp = ngui.find_sprite(obj,"touchSp");
	rankItem.touchSp:set_on_ngui_click(self.bindfunc["onClickItem"]);
	function rankItem:setData(data,index)
		self.data = data;
		if self.data.id ~= g_dataCenter.player.playerid then 
			self.infoSpSelf:set_active(false);
		end
		--app.log("data : "..table.tostring(data));
		AreaMilitaryRank.initRankItemRanking(self,self.data.ranking);
		self.touchSp:set_name(tostring(index));
		self.name:set_text(self.data.name);
		self.exploit_num:set_text(tostring(self.data.param3));
		local cf = AreaMilitaryRank.cfMilitaryRank[self.data.ranking_num];
		if cf ~= nil then 
			self.military_rank:set_text(cf.military_rank_name);
		else 
			cf = AreaMilitaryRank.cfMilitaryRank[1];
			self.military_rank:set_text(cf.military_rank_name);
		end
	end
	return rankItem;
end 

function AreaMilitaryRank:onClickItem(name)
	local index = tonumber(name);
	if self.rankDatas[index] ~= nil then 
		OtherPlayerPanel.ShowPlayer(self.rankDatas[index].id,true);
	end
end 

function AreaMilitaryRank.initRankItemRanking(rankItem,rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(false);
		do return end;
	end 
	if rankNum == 1 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming1")
	elseif rankNum == 2 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming2")
	elseif rankNum == 3 then 
		rankItem.infoNumRank:set_active(false);
		rankItem.infoFirstRank:set_active(true);
		rankItem.infoFirstRank:set_sprite_name("phb_paiming3")
	else
		rankItem.infoFirstRank:set_active(false);
		rankItem.infoNumRank:set_active(true);
		rankItem.infoNumRank:set_text(tostring(rankNum));
		rankItem.infoFirstRank:set_sprite_name("phb_paiming4")
	end
end 

function AreaMilitaryRank:on_click_close_btn()
	self:Hide();
	self:DestroyUi();
end 

function AreaMilitaryRank.DataCreator(index) 
	if index > 2001 then 
		do return end 
	end
	local data = {
		ranking = index;
		id = math.random(1000,9999);
		name = tostring(RankList.tempName[math.random(1,#RankList.tempName)])..tostring(RankList.tempName[math.random(1,#RankList.tempName)]);
		param3 = 99999-index*1000;
		ranking_num = 13;
		level = 1+40-index;
		iconsid = math.random(1,10);
	}
	return data;
end 

function AreaMilitaryRank:on_rank_data_get(rankDatas)
	--self.rankDatas = rankDatas;
	--self:UpdateUi();
end 

function AreaMilitaryRank:UpdateUi()
	local cfMilitaryRank = AreaMilitaryRank.cfMilitaryRank;
	local cf = cfMilitaryRank[g_dataCenter.area.curMilitaryRank]
	local needExploit = 99999999999999; 
	if cf ~= nil then 
		needExploit = cfMilitaryRank[g_dataCenter.area.curMilitaryRank].upgrade_need_exploit;
	end 
	self.needExploit = needExploit;
	local curExploit = g_dataCenter.area.totalExploit;
	local nextRank = cfMilitaryRank[g_dataCenter.area.curMilitaryRank+1];
	if cf ~= nil then 
		self.vs.labRankName:set_text(cf.military_rank_name);
	else
		self.vs.labRankName:set_text(cfMilitaryRank[#cfMilitaryRank].military_rank_name); 
		cf = cfMilitaryRank[#cfMilitaryRank];
	end 
	if nextRank == nil then 
		self.vs.labRankUpgrade:set_text("已达最高军衔");
		self.needExploit = 9999999999999999;
	else 
		if curExploit > needExploit then 
			self.vs.labRankUpgrade:set_text(nextRank.military_rank_name..":[05ED3FFF]"..tostring(curExploit).."/"..tostring(needExploit).."[-]");
		else 
			self.vs.labRankUpgrade:set_text(nextRank.military_rank_name..":[FF0000FF]"..tostring(curExploit).."/"..tostring(needExploit).."[-]");
		end
	end
	self.vs.wrapContent:set_min_index(-#self.rankDatas + 1)
    self.vs.wrapContent:set_max_index(0)
    self.vs.wrapContent:reset() 
	self.vs.scrollView:reset_position();
	local my_rank = self.rankDatas.my_rank;
	self:SetSelfRankNum(my_rank.ranking);
	self.vs.myRank:set_text(cf.military_rank_name);
	self.vs.myExploit:set_text(tostring(my_rank.param3));
	self.vs.myName:set_text(tostring(my_rank.name));
	self.myRankCf = cfMilitaryRank[g_dataCenter.area.curMilitaryRank];
	local drops = ConfigManager.Get(EConfigIndex.t_drop_something,self.myRankCf.day_reward_dropid);
	for k,v in pairs(drops) do 
		if k <= 2 then 
			local data = {
				parent = self.vs["rewardShow"..tostring(k)];
				}
			if self["itemCard"..tostring(k)] == nil then 
				self["itemCard"..tostring(k)] = UiSmallItem:new(data);
				self["itemCard"..tostring(k)]:SetDataNumber(v.goods_id,v.goods_number);
			else 
				self["itemCard"..tostring(k)]:SetDataNumber(v.goods_id,v.goods_number);
			end
		end
	end
	if g_dataCenter.area.bGetDayReward == 1 then 
		self.vs.btnGetReward:set_enable(false);
		self.vs.labGetReward:set_text("已领取");
	else 
		self.vs.btnGetReward:set_enable(true);
		self.vs.labGetReward:set_text("领取");
	end
end 

function AreaMilitaryRank:SetSelfRankNum(rankNum)
	if rankNum == nil or rankNum == 0 or rankNum > 2000 then 
		self.vs.selfInfoNumRank:set_active(false);
		self.vs.selfInfoFirstRank:set_active(false);
		self.vs.selfInfoNoRank:set_active(true);
	elseif rankNum <= 3 then 
		self.vs.selfInfoNoRank:set_active(false);
		self.vs.selfInfoNumRank:set_active(false); 
		self.vs.selfInfoFirstRank:set_active(true);
		if rankNum == 1 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming1")
		elseif rankNum == 2 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming2")
		elseif rankNum == 3 then 
			self.vs.selfInfoFirstRank:set_sprite_name("phb_paiming3")
		end
	else
		self.vs.selfInfoNoRank:set_active(false);
		self.vs.selfInfoNumRank:set_active(true);
		self.vs.selfInfoNumRank:set_text(tostring(rankNum));
		self.vs.selfInfoFirstRank:set_active(false);
	end
end 

function AreaMilitaryRank:on_click_more_rank_button()
	if g_dataCenter.area.totalExploit < self.needExploit then 
		AreaMilitaryRankShow.popPanel();
	else 
		g_dataCenter.area:toUpgradeMilitaryRank();
	end
end 

function AreaMilitaryRank:onUpgradeMilitaryRank()
	self:UpdateUi();
end 

function AreaMilitaryRank:gotMilitaryRankReward()
	self:UpdateUi();
end 

function AreaMilitaryRank:on_click_get_reward()
	g_dataCenter.area:getMilitaryRankReward()
end 

function AreaMilitaryRank:Init(data)
	app.log("AreaMilitaryRank:Init");
    self.pathRes = "assetbundles/prefabs/ui/area/ui_8004_xuan_ze_quyu.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function AreaMilitaryRank:DestroyUi()
	app.log("AreaMilitaryRank:DestroyUi");
	AreaMilitaryRankShow.destroy();
	AreaMilitaryRank.instance = nil;
	if self.itemCard1 then 
		self.itemCard1:DestroyUi();
	end 
	if self.itemCard2 then 
		self.itemCard2:DestroyUi();
	end 
	self.rankDatas = nil;
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function AreaMilitaryRank:Show()
	app.log("AreaMilitaryRank:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function AreaMilitaryRank:Hide()
	app.log("AreaMilitaryRank:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function AreaMilitaryRank:MsgRegist()
	app.log("AreaMilitaryRank:MsgRegist");
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(Area.upgradeMilitaryRank,self.bindfunc['onUpgradeMilitaryRank']);
	PublicFunc.msg_regist("gotMilitaryRankReward",self.bindfunc['gotMilitaryRankReward']);
end

--注销消息分发回调函数
function AreaMilitaryRank:MsgUnRegist()
	app.log("AreaMilitaryRank:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(Area.upgradeMilitaryRank,self.bindfunc['onUpgradeMilitaryRank']);
	PublicFunc.msg_unregist("gotMilitaryRankReward",self.bindfunc['gotMilitaryRankReward']);
end
--[[
	TrialRecoverRole 远征试炼buff购买界面中回血buff调用的选择英雄的界面
	界面中显示规则为损血比例大的角色排在前面，满血和死亡角色排在最后
	如果没有角色可以回血，会弹出提示没有角色需要恢复体力
]]

TrialRecoverRole = Class('TrialRecoverRole', UiBaseClass);

function TrialRecoverRole.PopPanel(levelid,buffIndex)
	TrialRecoverRole.levelid = levelid;
	TrialRecoverRole.buffIndex = buffIndex;
	TrialRecoverRole.instance = TrialRecoverRole:new();
end 

--重新开始
function TrialRecoverRole:Restart(data)
    app.log("TrialRecoverRole:Restart");
    UiBaseClass.Restart(self, data);
end

function TrialRecoverRole:InitData(data)
    app.log("TrialRecoverRole:InitData");
    UiBaseClass.InitData(self, data);
	--local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have)
	local roleStatesList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All)
	TrialRecoverRole.SortRoleByHpPercent(roleStatesList);
	self.allRoleList = roleStatesList;
end


function TrialRecoverRole.SortRoleByHpPercent(tb)
	local tmp = nil;
	for i = 1,#tb do 
		for j = i,#tb do 
			local a = tb[i];
			local b = tb[j];
			local maxhpa = a:GetPropertyVal("max_hp");
			local maxhpb = b:GetPropertyVal("max_hp");
			local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
			local curhpa = a:GetPlayMethodCurHP(hpType);
			local curhpb = b:GetPlayMethodCurHP(hpType);
			local curhpb = b.expedition_trial_hp;
			if curhpa == nil then 
				curhpa = maxhpa;
			end
			if curhpb == nil then 
				curhpb = maxhpb;
			end
			if curhpa == 0 then 
				curhpa = 2*maxhpa;
			end 
			if curhpb == 0 then 
				curhpb = 2*maxhpb;
			end 
			pa = curhpa/maxhpa;
			pb = curhpb/maxhpb;
			if pa > pb then 
				tmp = tb[i];
				tb[i] = tb[j];
				tb[j] = tmp;
			end
		end
	end
	
end 

function TrialRecoverRole:RegistFunc()
	--app.log("TrialRecoverRole:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onCloseClick'] = Utility.bind_callback(self, self.onCloseClick);
	self.bindfunc['onPressItem'] = Utility.bind_callback(self, self.onPressItem);
	self.bindfunc['init_item'] = Utility.bind_callback(self, self.init_item);
	self.bindfunc['onClickItem'] = Utility.bind_callback(self, self.onClickItem);
	self.bindfunc['onRecoverOk'] = Utility.bind_callback(self, self.onRecoverOk);
end

function TrialRecoverRole:InitUI(asset_obj)
	app.log("TrialRecoverRole:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TrialRecoverRole');
    self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"center_other/animation/content_di_1004_564/btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['onCloseClick']);
	self.vs.scrollView = ngui.find_scroll_view(self.ui,"center_other/animation/panel");
	self.vs.wrapContent = ngui.find_wrap_content(self.ui,"center_other/animation/panel/wrap_content");
	self.vs.wrapContent:set_on_initialize_item(self.bindfunc["init_item"]);
	--self.vs.wrapContent:reset();
	self:UpdateUi();
end

function TrialRecoverRole:init_item(obj,b,real_id)
	local index = math.abs(real_id)+1;
	local data1 = self.allRoleList[index*2-1];
	local data2 = self.allRoleList[index*2];
	self.rankItemList = self.rankItemList or {};
	local pid = obj:get_instance_id();
	self.rankItemList[pid] = self.rankItemList[pid] or self:createListItem(obj);
	local rankItem = self.rankItemList[pid];
	if data1 == nil then 
		return;
	end
	rankItem:setData(data1,data2,index); 
end 

function TrialRecoverRole:createListItem(obj)
	local item = {};
	item.spTouch1 = ngui.find_sprite(obj,"sp1")
	item.spTouch2 = ngui.find_sprite(obj,"sp2")
	item.name1 = ngui.find_label(obj,"sp1/name");
	item.name2 = ngui.find_label(obj,"sp2/name");
	item.fightValue1 = ngui.find_label(obj,"sp1/sp_fight/lab_fight");
	item.fightValue2 = ngui.find_label(obj,"sp2/sp_fight/lab_fight");
	item.hpBar1 = ngui.find_progress_bar(obj,"sp1/sco_bar");
	item.hpBar2 = ngui.find_progress_bar(obj,"sp2/sco_bar");
	item.hpBarBg1 = ngui.find_sprite(obj,"sp1/sco_bar/sp_fore");	
	item.hpBarBg2 = ngui.find_sprite(obj,"sp2/sco_bar/sp_fore");
	item.cardRoom1 = obj:get_child_by_name("sp1/cardRoom");
	item.cardRoom2 = obj:get_child_by_name("sp2/cardRoom");
	item.fightIcon1 = ngui.find_sprite(obj,"sp1/sp_fight");
	item.fightIcon2 = ngui.find_sprite(obj,"sp2/sp_fight");
	--item.mask1 = ngui.find_sprite(obj,"sp1/sp_smak");
	--item.mask2 = ngui.find_sprite(obj,"sp2/sp_smak");
	--item.spTouch1:set_on_ngui_press(self.bindfunc['onPressItem']);
	--item.spTouch2:set_on_ngui_press(self.bindfunc['onPressItem']);
	--item.spTouch1:set_on_ngui_click(self.bindfunc['onClickItem']);
	--item.spTouch2:set_on_ngui_click(self.bindfunc['onClickItem']);
	item.zhengwang1 = ngui.find_sprite(obj,"sp1/sp_zhangwang")
	item.zhengwang2 = ngui.find_sprite(obj,"sp2/sp_zhangwang")
	item.btnSelect1 = ngui.find_button(obj,"sp1/btn_join");
	item.btnSelect2 = ngui.find_button(obj,"sp2/btn_join");
	item.btnSelect1:set_on_ngui_click(self.bindfunc['onClickItem']);
	item.btnSelect2:set_on_ngui_click(self.bindfunc['onClickItem']);
	item.spBtn1 = ngui.find_sprite(obj,"sp1/btn_join/animation/sp")
	item.spBtn2 = ngui.find_sprite(obj,"sp2/btn_join/animation/sp")
	function item:setData(data1,data2,index)
		self.btnSelect1:set_name(index.."|-1");
		self.btnSelect2:set_name(index.."|0");
		if self.card1 == nil then self.card1 = SmallCardUi:new({parent = self.cardRoom1,stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Restrait,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Rarity}}); end 
		if self.card2 == nil then self.card2 = SmallCardUi:new({parent = self.cardRoom2,stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Restrait,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Rarity}}); end
		self.data1 = data1;
		self.data2 = data2;
		self.index = index;
		if data1 ~= nil then 
			self.spTouch1:set_active(true); 
			local maxhp = data1:GetPropertyVal("max_hp");
			local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
			local curhp = data1:GetPlayMethodCurHP(hpType);
			if curhp == nil then 
				curhp = maxhp;
			end
			self.hpBar1:set_value(curhp/maxhp);
			self.hpBar1Value = curhp/maxhp;
			self.fightValue1:set_text(tostring(data1:GetFightValue()));
			--app.log("data1 : "..table.tostring(data1));
			self.name1:set_text(data1.name or "--");
			self.card1:SetData(data1);
			if curhp == 0 or curhp == maxhp then 
				--self.mask1:set_active(true);
				self.spTouch1:set_color(0,0,0,1);
				self.spBtn1:set_color(0,0,0,1);
				self.hpBarBg1:set_color(0,0,0,1);
				self.fightValue1:set_color(1,1,1,1);
				self.fightIcon1:set_color(0,0,0,1);
				self.btnSelect1:set_enable(false);
				self.card1:SetGray(true);
				if curhp == 0 then 
					self.zhengwang1:set_active(true);
					self.card1:SetDead(true);
				else
					self.zhengwang1:set_active(false); 
					self.card1:SetDead(false);
				end 
			else 
				self.spTouch1:set_color(1,1,1,1);
				self.card1:SetDead(false);
				self.spBtn1:set_color(1,1,1,1);
				self.hpBarBg1:set_color(1,1,1,1);
				self.fightValue1:set_color(0.988,0.85,0,1);
				self.fightIcon1:set_color(1,1,1,1);
				self.btnSelect1:set_enable(true);
				self.card1:SetGray(false);
				self.zhengwang1:set_active(false); 
				--self.mask1:set_active(false);
			end
		else
			self.spTouch1:set_active(false); 
		end 
		if data2 ~= nil then 
			self.spTouch2:set_active(true); 
			local maxhp = data2:GetPropertyVal("max_hp");
			local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
			local curhp = data2:GetPlayMethodCurHP(hpType);
			if curhp == nil then 
				curhp = maxhp;
			end
			self.hpBar2:set_value(curhp/maxhp);
			self.hpBar2Value = curhp/maxhp;
			self.fightValue2:set_text(tostring(data2:GetFightValue()));
			--app.log("data2 : "..table.tostring(data2));
			self.name2:set_text(data2.name or "--");
			self.card2:SetData(data2);
			if curhp == 0 or curhp == maxhp then 
				--self.mask2:set_active(true);
				self.spTouch2:set_color(0,0,0,1);
				self.spBtn2:set_color(0,0,0,1);
				self.hpBarBg2:set_color(0,0,0,1);
				self.fightValue2:set_color(1,1,1,1);
				self.fightIcon2:set_color(0,0,0,1);
				self.btnSelect2:set_enable(false);
				self.card2:SetGray(true);
				if curhp == 0 then 
					self.zhengwang2:set_active(true);
					self.card2:SetDead(true);
				else 
					self.zhengwang2:set_active(false);
					self.card2:SetDead(false);
				end
			else 
				self.card2:SetDead(false);
				self.spTouch2:set_color(1,1,1,1);
				self.spBtn2:set_color(1,1,1,1);
				self.hpBarBg2:set_color(1,1,1,1);
				self.fightValue2:set_color(0.988,0.85,0,1);
				self.fightIcon2:set_color(1,1,1,1);
				self.btnSelect2:set_enable(true);
				self.card2:SetGray(false);
				self.zhengwang2:set_active(false);
				--self.mask2:set_active(false);
			end
		else
			self.spTouch2:set_active(false); 
		end
	end
	return item;
end 

function TrialRecoverRole:UpdateUi()
	app.log("wrap_content min index = "..tostring(-math.ceil(#self.allRoleList/2) + 1))
	self.vs.wrapContent:set_min_index(-math.ceil(#self.allRoleList/2) + 1)
    self.vs.wrapContent:set_max_index(0)
    self.vs.wrapContent:reset() 
	self.vs.scrollView:reset_position();
end 

function TrialRecoverRole:onPressItem(name, state, x, y, go_obj)	
	if state == true then 
		Tween.addTween(go_obj,0.1,{["local_scale"] = {0.9,0.9,0.9}},Transitions.EASE_OUT);
	else 
		Tween.addTween(go_obj,0.1,{["local_scale"] = {1,1,1}},Transitions.EASE_IN);
	end
end 

function TrialRecoverRole:onClickItem(name)
	local strList = string.split(name,"|");
	local index,pindex = tonumber(strList[1]),tonumber(strList[2]);
	local data = self.allRoleList[index*2+pindex]
	self.clickIndex = index;
	self.clickPindex = pindex;
	self.clickData = data;
	for k,v in pairs(self.rankItemList) do 
		if index == v.index then 
			self.clickItem = v;
			if pindex == -1 then 
				self.clickHpBar = self.clickItem.hpBar1;
				self.hpBarValue = self.clickItem.hpBar1Value;
			elseif pindex == 0 then 
				self.clickHpBar = self.clickItem.hpBar2;
				self.hpBarValue = self.clickItem.hpBar2Value;
			end
			break;
		end
	end 
	local maxhp = data:GetPropertyVal("max_hp");
	local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
	local curhp = data:GetPlayMethodCurHP(hpType);
	if curhp == nil then 
		curhp = maxhp;
	end
	if curhp == maxhp then 
		FloatTip.Float("该角色生命值已满无需恢复");
	elseif curhp == 0 then 
		FloatTip.Float("该角色已阵亡，不能恢复生命值");
	else 
		--FloatTip.Float("正在恢复角色生命值");
		self.loadingId = GLoading.Show(GLoading.EType.ui);
		g_dataCenter.trial:buy_buff(TrialRecoverRole.levelid,TrialRecoverRole.buffIndex,data.index);
	end
end 

function TrialRecoverRole:onRecoverOk()
	FloatTip.Float("角色生命值已恢复");
	local maxhp = self.clickData:GetPropertyVal("max_hp");
	local hpType = ENUM.RoleCardPlayMethodHPType.ExpeditionTrial;
	local curhp = self.clickData:GetPlayMethodCurHP(hpType);
	local valueNew = curhp/maxhp;
	local obj = {};
	obj.pid = "TrialRecoverRoleTweenHp";
	obj.value = self.hpBarValue;
	obj.get_pid = function()
		return obj.pid;
	end
	local function onUpdate()
		if self.clickHpBar ~= nil then 
			self.clickHpBar:set_value(obj.value);	
		end 
	end 
	local function onOver()
		GLoading.Hide(GLoading.EType.ui, self.loadingId);
		self:Hide();
		self:DestroyUi();
	end
	Tween.addTween(obj,0.6,{value = valueNew},Transitions.EASE_IN_OUT,0,nil,onUpdate,onOver);
	--self:Hide();
	--self:DestroyUi();
end 

function TrialRecoverRole:onCloseClick()
	self:Hide();
	self:DestroyUi();
end 

function TrialRecoverRole:Init(data)
	app.log("TrialRecoverRole:Init");
    self.pathRes = "assetbundles/prefabs/ui/expedition_trial/ui_6004_yuan_zheng.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function TrialRecoverRole:DestroyUi()
	TrialRecoverRole.instance = nil;
	app.log("TrialRecoverRole:DestroyUi");
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
end

--显示ui
function TrialRecoverRole:Show()
	app.log("TrialRecoverRole:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TrialRecoverRole:Hide()
	app.log("TrialRecoverRole:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TrialRecoverRole:MsgRegist()
	app.log("TrialRecoverRole:MsgRegist");
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist("trial.serverBuffList",self.bindfunc['onRecoverOk']);
end

--注销消息分发回调函数
function TrialRecoverRole:MsgUnRegist()
	app.log("TrialRecoverRole:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist("trial.serverBuffList",self.bindfunc['onRecoverOk']);
end
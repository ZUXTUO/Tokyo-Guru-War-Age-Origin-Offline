ChangeHeadPanel = Class('ChangeHeadPanel',UiBaseClass);

local _MaxCount = 6


------------外部接口--------------
--[[弹出更换玩家头像面板]]
function ChangeHeadPanel.ShowUI()
	ChangeHeadPanel.instance = ChangeHeadPanel:new();
end

--重新开始
function ChangeHeadPanel:Restart(data)
    app.log("ChangeHeadPanel:Restart");
    UiBaseClass.Restart(self, data);
end

function ChangeHeadPanel:InitData(data)
    app.log("ChangeHeadPanel:InitData");
    UiBaseClass.InitData(self, data);
    self.msg = nil;
end

function ChangeHeadPanel:RegistFunc()
	app.log("ChangeHeadPanel:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_btn_close_click'] = Utility.bind_callback(self,self.on_btn_close_click);
	self.bindfunc['on_unlock_head_click'] = Utility.bind_callback(self,self.on_unlock_head_click);
	self.bindfunc['on_yeka1_click'] = Utility.bind_callback(self,self.on_yeka1_click);
	self.bindfunc['on_yeka2_click'] = Utility.bind_callback(self,self.on_yeka2_click);
	self.bindfunc['on_locked_Head_touch'] = Utility.bind_callback(self,self.on_locked_Head_touch);
end

--msg_friend.cg_look_other_player(player_gid,team_type);

function ChangeHeadPanel:initAllHeads()
	self.vipdata = g_dataCenter.player:GetVipData();
	self.allHead = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
	self.normalLockedHeadList = {};
	self.normalUnlockHeadList = {};
	for k,v in pairs(self.allHead) do
		local smallcard = UiPlayerHead:new({roleId = v.number ,info = v,vip = self.vipdata.level,vipstar=self.vipdata.level_star})
		if v.index == 0 then 
			table.insert(self.normalLockedHeadList,smallcard);
		else 
			table.insert(self.normalUnlockHeadList,smallcard);
		end
	end

	--self.vipUnlockHeadList = {}
	--self.vipLockedHeadList = {}
	--ChangeHeadPanel.InitConfig();
	--[[if self.vipdata.level > 0 then 
		local checkedModelIDs = {};
		for i = 1,#ChangeHeadPanel.vipConfig do 
			local headConfig = ConfigManager.Get(EConfigIndex.t_vip_role_model_anima, ChangeHeadPanel.vipConfig[i].model_id)[1];
			if checkedModelIDs[headConfig.small_icon] == nil then 
				if ChangeHeadPanel.vipConfig[i].level <= self.vipdata.level then 
					if tonumber(ChangeHeadPanel.vipConfig[i].model_id) ~= nil then 
						local smallcard = UiPlayerHead:new({roleId = tonumber(ChangeHeadPanel.vipConfig[i].model_id) ,vip = self.vipdata.level})
						table.insert(self.vipUnlockHeadList,smallcard);
					end
				else 
					if tonumber(ChangeHeadPanel.vipConfig[i].model_id) ~= nil then 
						local smallcard = UiPlayerHead:new({roleId = tonumber(ChangeHeadPanel.vipConfig[i].model_id) ,vip = self.vipdata.level})
						table.insert(self.vipLockedHeadList,smallcard);
					end
				end
				checkedModelIDs[headConfig.small_icon] = 1;
			end 
		end
	end --]]
	
	if self.vs ~= nil then 
		self:UpdateUi();
	end 
end

function ChangeHeadPanel:UpdateUi()
	if self.lastState ~= self.state then 
		self.lastState = self.state;
		if self.roomList ~= nil then 
			for k,v in pairs(self.lockedHeadList) do 
				v:SetParent(nil);
				v:Hide();
			end
			for k,v in pairs(self.unlockHeadList) do 
				v:SetParent(nil);
				v:Hide();
			end 
			for k,v in pairs(self.roomList) do 
				v:set_active(false);
				v:set_parent(nil);
			end
		end 
		self.lockedHeadList = self.normalLockedHeadList;
		self.unlockHeadList = self.normalUnlockHeadList;
		--[[if self.state == 0 then 
			
		elseif self.state == 1 then  
			self.lockedHeadList = self.vipLockedHeadList;
			self.unlockHeadList = self.vipUnlockHeadList;
		end --]]
		local i = 0;
		local row,col = 0,0;
		--app.log("grid cell width = "..tostring(self.vs.unlockGrid:get_cell_width()));
		--app.log("grid cell height = "..tostring(self.vs.unlockGrid:get_cell_height()));
		local cellHeight = self.vs.unlockGrid:get_cell_height();
		local unlockParent = self.vs.unlockGrid:get_game_object();
		local lockedParent = self.vs.lockedGrid:get_game_object();
		self.roomList = {};
		for i = 1,#self.unlockHeadList do 
			row = math.floor((i-1)/_MaxCount)+1;
			col = (i-1)%_MaxCount + 1;
			local room = self.vs.unlockRoom1:clone();
			room:set_active(true);
			room:set_parent(unlockParent)
			table.insert(self.roomList,room);
			self.unlockHeadList[i]:SetParent(room);
			self.unlockHeadList[i]:Show();
			self.unlockHeadList[i]:SetCallback(self.bindfunc['on_unlock_head_click'],self.unlockHeadList[i].data.roleId);
			--self.unlockHeadList[i]:SetPosition(self["pux"..tostring(col)],self.puy + (row-1)*74,self.puz)
		end
		local w,h = self.vs.unlockWidget:get_size();
		self.vs.unlockWidget:set_size(w,cellHeight * (row - 1));
		i = 0;
		if #self.lockedHeadList == 0 then 
			row = 1;
		else
			for i = 1,#self.lockedHeadList do 
				row = math.floor((i-1)/_MaxCount)+1;
				col = (i-1)%_MaxCount + 1;
				local room = self.vs.lockedRoom1:clone();
				room:set_active(true);
				room:set_parent(lockedParent);
				table.insert(self.roomList,room);
				self.lockedHeadList[i]:SetParent(room);
				self.lockedHeadList[i]:Show();
				self.lockedHeadList[i]:SetGray(true);
				self.lockedHeadList[i]:SetCallback(self.bindfunc['on_locked_Head_touch'],self.lockedHeadList[i].data.roleId);
				--self.lockedHeadList[i]:SetPosition(self["plx"..tostring(col)],self.ply + (row-1)*74,self.plz)
			end
		end 
		self.vs.lockedBg:set_height(cellHeight * (row - 1) + 10);
		self.vs.scrollView:reset_position();
		self.vs.unlockGrid:reposition_now();
		self.vs.lockedGrid:reposition_now();
		self.vs.unlockGrid:set_active(false);
		self.vs.unlockGrid:set_active(true);
		self.vs.lockedGrid:set_active(false);
		self.vs.lockedGrid:set_active(true);
	end 
end 

function ChangeHeadPanel:InitUI(asset_obj)
	app.log("ChangeHeadPanel:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('changeHeadPanel');
    self.vs = {};
	self.vs.panel = ngui.find_panel(self.ui,self.ui:get_name());
	self.vs.panel:set_depth(3000);
	self.vs.mask = ngui.find_sprite(self.ui,"sp_mark");
	self.vs.closeBtn = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha");
	self.vs.closeBtn:set_on_click(self.bindfunc['on_btn_close_click']);
	self.vs.scrollView = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view/panel_list");
	self.vs.scrollViewPanel = ngui.find_panel(self.ui,"centre_other/animation/scroll_view/panel_list");
	self.vs.scrollViewPanel:set_depth(3004);
	
	self.vs.unlockSprite = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont1/grid1");
	self.vs.unlockGrid = ngui.find_grid(self.ui,"centre_other/animation/scroll_view/panel_list/cont1/grid1");
	self.vs.unlockWidget = ngui.find_widget(self.ui,"centre_other/animation/scroll_view/panel_list/cont1/grid1");
	self.vs.unlockRoom1 = self.vs.unlockSprite:get_game_object():get_child_by_name("sp_head_di_item");
	self.vs.unlockBg = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont1/grid1");

	self.vs.yekaNormalHeads = ngui.find_button(self.ui,"centre_other/animation/yeka/yeka1");
	self.vs.yekaVipHeads = ngui.find_button(self.ui,"centre_other/animation/yeka/yeka2");
	self.vs.sp_bar = ngui.find_sprite(self.ui,"centre_other/animation/sp_bar");
	if self.vs.yekaVipHeads then 
		self.vs.yekaVipHeads:set_active(false);
	end
	if self.vs.yekaNormalHeads then 
		self.vs.yekaNormalHeads:set_active(false);
	end
	if self.vs.sp_bar then 
		self.vs.sp_bar:set_active(false);
	end
	--self.vs.yekaNormalHeads:set_on_click(self.bindfunc["on_yeka1_click"]);
	--self.vs.yekaVipHeads:set_on_click(self.bindfunc["on_yeka2_click"]);
	
	self.vs.lockedSprite = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/grid1");
	self.vs.lockedGrid = ngui.find_grid(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/grid1");
	self.vs.lockedWidget = ngui.find_widget(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/grid1");
	self.vs.lockedRoom1 = self.vs.lockedSprite:get_game_object():get_child_by_name("sp_head_di_item");
	self.vs.lockedBg = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/grid1");
	
	self.initW,self.initH = self.vs.unlockBg:get_size();
	self.vs.unlockTitle = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont1/sp_title");
	self.vs.lockedTitle = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/sp_title");
	self.vs.lockedTitlelab = ngui.find_label(self.ui,"centre_other/animation/scroll_view/panel_list/cont2/sp_title/txt_title");
	self.vs.lockedTitlelab:set_text("未解锁头像")
	self.vs.unlockRoom1:set_parent(nil);
	self.vs.lockedRoom1:set_parent(nil);

	self.vs.unlockRoom1:set_active(false);
	self.vs.lockedRoom1:set_active(false);
	self.state = 0;
	
	self:initAllHeads();
end

function ChangeHeadPanel.InitConfig()
	if ChangeHeadPanel.vipConfig == nil then 
		local vipCf = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
		ChangeHeadPanel.vipConfig = {};
		for i = 1,#vipCf do 
			table.insert(ChangeHeadPanel.vipConfig,vipCf[i]);
		end
	end 
end 

function ChangeHeadPanel:on_btn_close_click()
	app.log("ChangeHeadPanel:Hide()");
	self:Hide();
	self:DestroyUi();
	ChangeHeadPanel.instance = nil;
end

function ChangeHeadPanel:on_unlock_head_click(roleId)
	app.log("当前点击英雄ID = "..tostring(roleId));
	--[[
	if not Socket.socketServer then 
		return 
	end
	]]
    --    nplayer.cg_change_player_image(Socket.socketServer,roleId);
	player.gc_change_player_image(0, roleId);
	self:Hide();
	self:DestroyUi();
	ChangeHeadPanel.instance = nil;
end 

function ChangeHeadPanel:on_yeka1_click()
	self.state = 0;
	self:UpdateUi();
end 

function ChangeHeadPanel:on_yeka2_click()
	self.state = 1;
	self:UpdateUi();
end

function ChangeHeadPanel:on_locked_Head_touch(roleId)
	if self.state == 0 then 
		HeadUnlockTip.ShowUI(roleId);
	elseif self.state == 1 then  
		FloatTip.Float("培养和董香的好感可以解锁更多专属头像哦");
	end
end 

function ChangeHeadPanel:Init(data)
	app.log("ChangeHeadPanel:Init");
    self.pathRes = "assetbundles/prefabs/ui/playerhead/ui_min_head.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function ChangeHeadPanel:DestroyUi()
	app.log("ChangeHeadPanel:DestroyUi");
    self.vs = nil;
	for k,v in pairs(self.roomList) do 
		v:destroy_object();
	end
	for k,v in pairs(self.normalLockedHeadList) do 
		v:DestroyUi();
	end
	for k,v in pairs(self.normalUnlockHeadList) do 
		v:DestroyUi();
	end
	--[[for k,v in pairs(self.vipLockedHeadList) do 
		v:DestroyUi();
	end
	for k,v in pairs(self.vipUnlockHeadList) do 
		v:DestroyUi();
	end--]]
	self.roomList = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function ChangeHeadPanel:Show()
	app.log("ChangeHeadPanel:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function ChangeHeadPanel:Hide()
	app.log("ChangeHeadPanel:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function ChangeHeadPanel:MsgRegist()
	app.log("ChangeHeadPanel:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function ChangeHeadPanel:MsgUnRegist()
	app.log("ChangeHeadPanel:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
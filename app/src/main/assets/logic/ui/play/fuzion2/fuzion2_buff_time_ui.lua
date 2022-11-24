Fuzion2TimeObj = Class("Fuzion2TimeObj");

function Fuzion2TimeObj:Init(data)
	self.ui = data;    
	self.lab = ngui.find_label(self.ui,"animation/lab");
	self.pro = ngui.find_sprite(self.ui,"animation/sp_effect");
	self.beginTime = 0;
end

function Fuzion2TimeObj:SetData(cfg)
	self.cfg = cfg;
end

function Fuzion2TimeObj:UpdateInfo(daluandou2_refresh_data)
	local refreshTime = tonumber(daluandou2_refresh_data.refreshTime);
	self.beginTime = refreshTime;
	if refreshTime == 0 or system.time() > refreshTime then
		self:set_active(false);
	else
		self:set_active(true);


		local miniMap = GetMainUI():GetMinimap()
		if miniMap then
			local type = nil
			if self.cfg.world_itemid then
				type = EMapEntityType.EBuff
			else
				type = EMapEntityType.ESoldier
			end
			miniMap:AddPositionEntity(self.cfg, type, refreshTime - system.time(), true)
		end
	end
	self:Update();
end

function Fuzion2TimeObj:Update()
	local curTime = system.time();
	if curTime >= self.beginTime then
		self:set_active(false);
	else
		self:set_active(true);
		local maxTime = self.cfg.refresh_time;
		local time = self.beginTime - curTime;
		self.lab:set_text(tostring(time));
		self.pro:set_fill_amout(time/maxTime);

		local camera = CameraManager.GetSceneCamera();
        local view_x, view_y, view_z = camera:world_to_screen_point(self.cfg.x,0,self.cfg.y);
        local ui_x, ui_y, ui_z = Root.get_ui_camera():screen_to_world_point(view_x, view_y, view_z);
        self.ui:set_position(ui_x, ui_y, 0);
	end
end

function Fuzion2TimeObj:DestroyUi()
	self.ui = nil;
	self.lab = nil;
	self.pro = nil;
	PublicFunc.ClearUserDataRef(self)
end

function Fuzion2TimeObj:set_active(isShow)
	if self.isShow == isShow then
		return;
	end
	self.isShow = isShow;
	if self.ui then
		self.ui:set_active(isShow);
	end
end

------------------------------------------------------------------------------
Fuzion2BuffTimesUI = Class("Fuzion2BuffTimesUI", UiBaseClass);

function Fuzion2BuffTimesUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_pour_time.assetbundle";
    UiBaseClass.Init(self, data);
end

function Fuzion2BuffTimesUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_daluandou2_sync_refresh_buff_monster_data"] = Utility.bind_callback(self, self.gc_daluandou2_sync_refresh_buff_monster_data);
end

function Fuzion2BuffTimesUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_fight.gc_daluandou2_sync_refresh_buff_monster_data,self.bindfunc["gc_daluandou2_sync_refresh_buff_monster_data"]);
end

function Fuzion2BuffTimesUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_fight.gc_daluandou2_sync_refresh_buff_monster_data,self.bindfunc["gc_daluandou2_sync_refresh_buff_monster_data"]);
end

function Fuzion2BuffTimesUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("new_fight_ui_pour_time");

    self.pool = ObjectPool:new({obj=self.ui,class=Fuzion2TimeObj})

    self.listObjBuff = {};
    self:initBuff();
    self.listObjMonster = {};
    self:initMonster();
    self:Hide();
end

function Fuzion2BuffTimesUI:initBuff()
	local cfgEnum = EConfigIndex.t_daluandou2_buffer_refresh_position
	local buffCfgNum = ConfigManager.GetDataCount(cfgEnum);
	for i=1,buffCfgNum do
		local cfg = ConfigManager.Get(cfgEnum,i);
		local worldCfg = ConfigManager.Get(EConfigIndex.t_world_item, cfg.world_itemid);
		local obj = self.pool:GetObject();
		cfg.refresh_time = worldCfg.refresh_time;
		obj:SetData(cfg);
		table.insert(self.listObjBuff,obj);
	end
end

function Fuzion2BuffTimesUI:initMonster()
	local cfgEnum = EConfigIndex.t_daluandou2_monster_refresh_position
	local monsnterCfgNum = ConfigManager.GetDataCount(cfgEnum);
	for i=1,monsnterCfgNum do
		local cfg = ConfigManager.Get(cfgEnum,i);
		local obj = self.pool:GetObject();
		obj:SetData(cfg);
		table.insert(self.listObjMonster,obj);
	end
end

function Fuzion2BuffTimesUI:Update(dt)
	if not self.ui then
		return;
	end
	for k,obj in pairs(self.listObjBuff) do
		obj:Update();
	end
	for k,obj in pairs(self.listObjMonster) do
		obj:Update();
	end
end

function Fuzion2BuffTimesUI:DestroyUi()
	for k,obj in pairs(self.listObjBuff) do
		self.pool:DestroyObject(obj);
	end
	self.listObjBuff = {};
	for k,obj in pairs(self.listObjMonster) do
		self.pool:DestroyObject(obj);
	end
	self.listObjMonster = {};
    self.pool:Destroy();
    UiBaseClass.DestroyUi(self);
end

function Fuzion2BuffTimesUI:gc_daluandou2_sync_refresh_buff_monster_data(vecRefreshData)
	for k,v in pairs(vecRefreshData) do
		if v.ntype == 0 then
			local obj = self.listObjMonster[v.configID];
			if obj then
				obj:UpdateInfo(v);
			end
		elseif v.ntype == 1 then
			local obj = self.listObjBuff[v.configID];
			if obj then
				obj:UpdateInfo(v);
			end
		end
	end
end

UiLevelLoadingNew = Class('UiLevelLoadingNew', UiBaseClass);

ETypeLoading =
{
	normal = 0,
	vs = 1,
	vs3 = 3,
	daluandou = 4,
	daluandou2 = 5,
	prologue = 6, -- 序章loading隐藏显示，用黑幕替换
}

local _UIText = {
    [1] = "等级: ",
    [2] = "战力: "
}

local _temp_loaded_texture = nil -- 缓存1张texture
local _temp_texture_index = 0	-- 缓存texture的序号
local _temp_texture_used = false -- 缓存texture使用情况
local _total_texture_count = 0	-- 随机texture总数量
local _next_texture_path = nil  -- 指定下一张texture

local _local = { }
_local.pathRes = "assetbundles/prefabs/ui/loading/ui_loading_normal.assetbundle";
_local.pathRes_vs = "assetbundles/prefabs/ui/loading/ui_loading_vs.assetbundle";
-- _local.pathRes_3v3       = "assetbundles/prefabs/ui/loading/ui_loading_3v3.assetbundle";
_local.pathRes_3v3 = "assetbundles/prefabs/ui/loading/ui_loading_vs.assetbundle";
_local.pathRes_daluandou = "assetbundles/prefabs/ui/loading/ui_loading_daluandou.assetbundle";
-- _local.pathRes_daluandou2 = "assetbundles/prefabs/ui/loading/ui_loading_daluandou.assetbundle";
_local.resMoshenrenpic = "assetbundles/prefabs/ui/image/icon/head_pic/170_440/klz_moshengren.assetbundle"
----------------------外部接口----------------------------

function UiLevelLoadingNew.GetLoadingRes(type_loading)
	local pathRes = _local.pathRes
	if type_loading == ETypeLoading.vs then
		pathRes = _local.pathRes_vs
	elseif type_loading == ETypeLoading.vs3 then
		pathRes = _local.pathRes_3v3
	elseif type_loading == ETypeLoading.daluandou then
		pathRes = _local.pathRes_daluandou -- 4人大乱斗已废弃
	-- elseif type_loading == ETypeLoading.daluandou2 then
	-- 	pathRes = _local.pathRes_daluandou2
	end

	return pathRes
end

-- -- 巅峰展示资源加载loading
-- function UiLevelLoadingNew.LoadPeakShowTexture(cbfunc)
-- 	UiLevelLoadingNew.load_peak_cbfunc = cbfunc
-- 	_next_texture_path = "assetbundles/prefabs/ui/image/backgroud/logo/loading1.assetbundle"
-- 	local cur_texture_path = "assetbundles/prefabs/ui/image/backgroud/logo/loading.assetbundle"
-- 	ResourceLoader.LoadTexture(cur_texture_path, UiLevelLoadingNew.OnLoadPeakTexture)
-- end

-- function UiLevelLoadingNew.OnLoadPeakTexture(pid, fpath, texture_obj, error_info)
-- 	_temp_loaded_texture = texture_obj:GetObject()

-- 	if UiLevelLoadingNew.load_peak_cbfunc then
-- 		UiLevelLoadingNew.load_peak_cbfunc()
-- 		UiLevelLoadingNew.load_peak_cbfunc = nil
-- 	end
-- end

-- 加载一张缓存texture
function UiLevelLoadingNew.InitTempTexture(isFirstEnterImage)
	
	local totalCount = ConfigManager.GetDataCount(EConfigIndex.t_loading_background)
	local randomIndex = math.random(1, totalCount)
	_total_texture_count = totalCount
	_temp_texture_index = randomIndex

	if isFirstEnterImage then
		UiLevelLoadingNew._LoadNextTexture("assetbundles/prefabs/ui/image/senceload/loading_tu9.assetbundle")
	else
		UiLevelLoadingNew._LoadNextTexture()
	end
end

function UiLevelLoadingNew._LoadNextTexture(next_texture_path)
	-- 若无指定背景，则取配置中的下一张进行预加载
	if not next_texture_path then
		_temp_texture_index = _temp_texture_index + 1
		if _temp_texture_index > _total_texture_count then
			_temp_texture_index = 1
		end

		local cfg_table = ConfigManager._GetConfigTable(EConfigIndex.t_loading_background)
		next_texture_path = cfg_table[_temp_texture_index].path
	end
	
	ResourceLoader.LoadTexture(next_texture_path, UiLevelLoadingNew.OnLoadTempTexture)
end

function UiLevelLoadingNew.OnLoadTempTexture(pid, fpath, texture_obj, error_info)
	_temp_loaded_texture = texture_obj:GetObject()
	_temp_texture_used = false
end

function UiLevelLoadingNew.SetAndShow(data)
	if not UiLevelLoadingNew.instance then
		UiLevelLoadingNew.instance = UiLevelLoadingNew:new(data);
	else
		UiLevelLoadingNew.instance:Show(data)
	end
end

function UiLevelLoadingNew.SetProgressBar(value)
	if UiLevelLoadingNew.instance then
		UiLevelLoadingNew.instance:SetProgress(value);
		if UiLevelLoadingNew.instance.type_loading == ETypeLoading.daluandou2 then
			-- UiLevelLoadingNew.instance:UpdateDaLuanDou2State();
			if UiLevelLoadingNew.instance.curLoading then
				UiLevelLoadingNew.instance.curLoading:UpdatePercent(playerid, percent)
			end
		end
	end
end

function UiLevelLoadingNew.Destroy(clearCacheRes)
	if UiLevelLoadingNew.instance then
		-- 缓存下一张背景资源
		if not clearCacheRes and _temp_texture_used and UiLevelLoadingNew.instance.texture then
			UiLevelLoadingNew._LoadNextTexture(_next_texture_path)
			_next_texture_path = nil
		end

		UiLevelLoadingNew.instance:Hide();
		UiLevelLoadingNew.instance:ClearData();
		--UiLevelLoadingNew.instance:DestroyUi();
		--UiLevelLoadingNew.instance = nil;
	end

	--释放所有缓存资源
	if clearCacheRes then
		_temp_loaded_texture = nil
		_next_texture_path = nil
		
		if UiLevelLoadingNew.instance then
			UiLevelLoadingNew.instance:DestroyUi();
			UiLevelLoadingNew.instance = nil
		end
	end
end

function UiLevelLoadingNew.HideInstance()
	if UiLevelLoadingNew.instance then
		UiLevelLoadingNew.instance:Hide();
	end
end

function UiLevelLoadingNew.PreLoadAssets(load_type)	
end

--------------------------内部接口---------------------------------

function UiLevelLoadingNew:SetTempTexture()
	if not self.texture then
 		self.texture = ngui.find_texture(self.ui,"normal_loading/texture")
 	end
 	
 	if self.texture and _temp_loaded_texture then
 		self.texture:SetTexture(_temp_loaded_texture)
	 	_temp_texture_used = true
 	end
end

-- 初始化
function UiLevelLoadingNew:Init(data)
	self.pathRes = _local.pathRes;
	self.start_load_time = app.get_time();

	self.pathRes = _local.pathRes;
	
	UiBaseClass.Init(self, data);
end

-- 重新开始
function UiLevelLoadingNew:Restart()
	UiBaseClass.Restart(self, nil)
end

-- 初始化数据
function UiLevelLoadingNew:InitData(data)
	UiBaseClass.InitData(self, data);

	self:SetData(data);
end


function  UiLevelLoadingNew:ClearData(  )
	self.player = nil;
	self.player_name = nil;
	self.player_count = nil;
	self.cardhuman = nil;
	self.cardhuman_count = nil;
	if self.texture then
		self.texture:Destroy()
		self.texture = nil
	end
	if self.type_loading == ETypeLoading.vs then
		if not self.ui_vs then return end
		local vs = self.cont_vs;
		if vs.big_card_item then
			for i = 1, 2 do
				for j = 1, 3 do
					if vs.big_card_item[i][j] then
						vs.big_card_item[i][j]:DestroyUi();
					end
				end
				if vs.cont_title[i].uiPlayerHead then
					vs.cont_title[i].uiPlayerHead:DestroyUi()
					vs.cont_title[i].uiPlayerHead = nil
				end
			end
			vs.big_card_item = nil
		end
		
		self.cont_vs = nil
		self.ui_vs:set_active(false)
		self.ui_vs = nil

	elseif self.type_loading == ETypeLoading.vs3 then
		if not self.ui_3v3 then return end
		local vs3 = self.cont_3v3;
		if vs3.big_card_item then
			for i = 1, 2 do
				for j = 1, 3 do
					if vs3.big_card_item[i][j] then
						vs3.big_card_item[i][j]:DestroyUi();
					end
				end
			end
			vs3.big_card_item = nil;
		end
		self.cont_3v3 = nil
		self.ui_3v3:set_active(false)
		self.ui_3v3 = nil

	elseif self.type_loading == ETypeLoading.daluandou then
		if not self.ui_daluandou then return end
		local dld = self.cont_daluandou;
		if dld.small_card then
			for i = 1, 4 do
				if dld.small_card[i] then
					dld.small_card[i]:DestroyUi();
				end
			end
			dld.small_card = nil;
		end
		
		self.cont_daluandou = nil
		self.ui_daluandou:set_active(false)
		self.ui_daluandou = nil
	end
	if self.curLoading then
		self.curLoading:End();
		self.curLoading = nil;
	end
end

-- 析构函数
function UiLevelLoadingNew:DestroyUi()
	self:ClearData()

	self.normal = nil
	self.public = nil
	self.normal_loading = nil

	UiBaseClass.DestroyUi(self);
	--    ResourceManager.DelRes(self.pathRes);
end

-- 显示ui
function UiLevelLoadingNew:Show(data)
	if data then
		self:SetData(data)
		self:InitUI()
	end
	
	UiBaseClass.Show(self)
end

-- 隐藏ui
function UiLevelLoadingNew:Hide()
	UiBaseClass.Hide(self)
	if self.curLoading then
		self.curLoading:End();
		self.curLoading = nil;
	end
end

-- 注册回调函数
function UiLevelLoadingNew:RegistFunc()
	UiBaseClass.RegistFunc(self);

	self.bindfunc['on_load_vs'] = Utility.bind_callback(self, self.on_load_vs);
	self.bindfunc['on_load_3v3'] = Utility.bind_callback(self, self.on_load_3v3);
	self.bindfunc['on_load_daluandou'] = Utility.bind_callback(self, self.on_load_daluandou);
	-- self.bindfunc['on_load_daluandou2'] = Utility.bind_callback(self, self.on_load_daluandou2);
	self.bindfunc["gc_load_state"] = Utility.bind_callback(self, self.gc_load_state);
end

-- 注销回调函数
function UiLevelLoadingNew:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

-- 注册消息分发回调函数
function UiLevelLoadingNew:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(world_msg.gc_load_state, self.bindfunc["gc_load_state"]);
end

-- 注销消息分发回调函数
function UiLevelLoadingNew:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(world_msg.gc_load_state, self.bindfunc["gc_load_state"]);
end

-- 加载UI
function UiLevelLoadingNew:LoadUI()
	UiBaseClass.LoadUI(self);
end

function UiLevelLoadingNew:on_load_vs(pid, filepath, asset_obj, error_info)
	if filepath == _local.pathRes_vs then
		self:InitVsUi(asset_obj)
        self:UpdateUi()
	end
end

function UiLevelLoadingNew:on_load_3v3(pid, filepath, asset_obj, error_info)
	if filepath == _local.pathRes_3v3 then
		self:Init3v3Ui(asset_obj)
        self:UpdateUi()
	end
end

function UiLevelLoadingNew:on_load_daluandou(pid, filepath, asset_obj, error_info)
	if filepath == _local.pathRes_daluandou then
		self:InitDaLuanDouUi(asset_obj)
        self:UpdateUi()
	end
end

function UiLevelLoadingNew:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	
	self.ui:set_name('ui_level_loading');
	self.normal_loading = self.ui:get_child_by_name("normal_loading")
	self.normal_loading:set_active(false)
  
	if self.type_loading == ETypeLoading.normal then
		 self:InitNormalUi()
         self:UpdateUi()
	elseif self.type_loading == ETypeLoading.vs then
		ResourceLoader.LoadAsset(_local.pathRes_vs, self.bindfunc['on_load_vs'], self.panel_name);
	elseif self.type_loading == ETypeLoading.vs3 then
		ResourceLoader.LoadAsset(_local.pathRes_3v3, self.bindfunc['on_load_3v3'], self.panel_name);
	elseif self.type_loading == ETypeLoading.daluandou then
		self:HideNormal()
		ResourceLoader.LoadAsset(_local.pathRes_daluandou, self.bindfunc['on_load_daluandou'], self.panel_name);
	elseif self.type_loading == ETypeLoading.daluandou2 then
		self:HideNormal()
		-- ResourceLoader.LoadAsset(_local.pathRes_daluandou2, self.bindfunc['on_load_daluandou2'], self.panel_name);
	end

	--self:UpdateUi();
end

function UiLevelLoadingNew:InitNormalUi(asset_obj)
	if not self.ui then return end
	self.normal_loading = self.ui:get_child_by_name("normal_loading")
	self.texture = ngui.find_texture(self.ui, "normal_loading/texture");


	self.normal_loading:set_active(true)
	------------------------------关卡部分--------------------------------
	self.normal = { }

	self.normal.pro_bar = ngui.find_progress_bar(self.normal_loading, "down_other/progress_bar");
	self.normal.lab_hint = ngui.find_label(self.normal_loading, "down_other/progress_bar/progress_font_label");
end

function UiLevelLoadingNew:HideNormal(  )
	if self.normal_loading then
		self.normal_loading:set_active(false)
	end
end

function UiLevelLoadingNew:InitVsUi(asset_obj)
	if not self.ui then return end
	-- app.log("UiLevelLoadingNew:InitVsUi")

    self.ui_vs = asset_game_object.create(asset_obj);
	self.ui_vs:set_parent(Root.get_root_ui_2d())
    self.ui_vs:set_name("ui_loading_vs")
	self.ui_vs:set_local_scale(1, 1, 1);
	self.ui_vs:set_local_position(0, 0, 0);

	self.cont_vs = { };
	local vs = self.cont_vs;
	vs.obj_card = { };
	vs.cont_title = { };
	-- local path = "centre_other/animation/"
	local objNode = nil
	for i = 1, 2 do
		vs.obj_card[i] = { };
		vs.cont_title[i] = { };
		if i == 1 then
			objNode = self.ui_vs:get_child_by_name("cont_left")
		else
			objNode = self.ui_vs:get_child_by_name("cont_right")
		end
		for j = 1, 3 do
			vs.obj_card[i][j] = objNode:get_child_by_name("cont_big_item" .. j);
		end
		objNode = self.ui_vs:get_child_by_name("sp_title_" .. i)
		vs.cont_title[i].lab_name = ngui.find_label(objNode, "lab_name")
		vs.cont_title[i].lab_level = ngui.find_label(objNode, "lab_level")
		vs.cont_title[i].lab_fight_value = ngui.find_label(objNode, "lab_fighting")
		vs.cont_title[i].objPlayerHead = objNode:get_child_by_name("sp_head_di_item")
	end
end

function UiLevelLoadingNew:Init3v3Ui(asset_obj)
	if not self.ui then return end

	self.ui_3v3 = asset_game_object.create(asset_obj);
	self.ui_3v3:set_parent(Root.get_root_ui_2d())
    self.ui_3v3:set_name("ui_loading_vs_3v3")
	self.ui_3v3:set_local_scale(1, 1, 1);
	self.ui_3v3:set_local_position(0, 0, 0);

	self.cont_3v3 = { };
	local vs3 = self.cont_3v3;
	vs3.obj_card = { };

	local objNode = nil
	for i = 1, 2 do
		vs3.obj_card[i] = { };
		if i == 1 then
			objNode = self.ui_3v3:get_child_by_name("cont_left")
		else
			objNode = self.ui_3v3:get_child_by_name("cont_right")
		end
		for j = 1, 3 do
			vs3.obj_card[i][j] = objNode:get_child_by_name("cont_big_item" .. j);
		end
		-- 隐藏多余内容
		 objNode = self.ui_3v3:get_child_by_name("sp_title_" .. i)
		 objNode:set_active(false)
	end
end

function UiLevelLoadingNew:InitDaLuanDouUi(asset_obj)
	if not self.ui then return end
	self.ui_daluandou = asset_game_object.create(asset_obj);
	self.ui_daluandou:set_parent(Root.get_root_ui_2d())
    self.ui_daluandou:set_name("ui_loading_daluandou")
	self.ui_daluandou:set_local_scale(1, 1, 1);
	self.ui_daluandou:set_local_position(0, 0, 0);
end

function UiLevelLoadingNew:UpdateUi()
	if not self.ui then return end

	UiSceneChange.HideInstace()
	if self.type_loading == ETypeLoading.normal then
		self:UpdateNormalUi();
	elseif self.type_loading == ETypeLoading.vs then
		self:UpdateVsUi();
	elseif self.type_loading == ETypeLoading.vs3 then
		self:Update3v3Ui();
	elseif self.type_loading == ETypeLoading.daluandou then
		self:UpdateDaLuanDouUi();
	end
end

function UiLevelLoadingNew:UpdateNormalUi()
	if not self.ui then
		return false
	end

	local n = math.random(1, #gs_loading_tips);
	local txt = gs_loading_tips[n] or ''
	self.normal.lab_hint:set_text(txt);
	self.normal.lab_hint:set_active(true);
	self.normal_loading:set_active(true);

	self:SetTempTexture()
end

function UiLevelLoadingNew:UpdateVsUi()
	if not self.ui or not self.ui_vs then
		return false
	end

	--local path = "assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing.assetbundle";
	--self.texture:set_texture(path);
	if not self.data_vs then return end;
	local info = self.data_vs;
	local vs = self.cont_vs;
	vs.big_card_item = { };
	for i = 1, 2 do
		vs.big_card_item[i] = { };
		if info.player~=nil then
			vs.cont_title[i].lab_name:set_text(tostring(info.player[i].name))
			vs.cont_title[i].lab_level:set_text(_UIText[1] .. tostring(info.player[i].level))
			vs.cont_title[i].lab_fight_value:set_text(_UIText[2] ..tostring(info.fight_value[i]))
			vs.cont_title[i].uiPlayerHead = UiPlayerHead:new( { parent = vs.cont_title[i].objPlayerHead, roleId = info.player[i].image })
		end
		for j = 1, 3 do
			local obj_card = vs.obj_card[i][j];
			if j > info.cardhuman_count[i] then
				vs.big_card_item[i][j] = UiBigCard:new({parent = obj_card,teamType=info.teamType,infoType=1,camp = i,showAddButton = false})
			else
				local cardinfo = info.cardhuman[i][j];
				vs.big_card_item[i][j] = UiBigCard:new({parent = obj_card,info=cardinfo,teamType=info.teamType,infoType=1,showPro=true,camp = i})
			end
		end
	end
end

function UiLevelLoadingNew:Update3v3Ui()
	if not self.ui or not self.ui_3v3 then
		return false
	end
	-- app.log("UiLevelLoadingNew:Update3v3Ui")
	--local path = "assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing.assetbundle";
	--self.texture:set_texture(path);

	if not self.data_3v3 then return end;
	local info = self.data_3v3;
	local vs3 = self.cont_3v3;
	vs3.big_card_item = { };
	for i = 1, 2 do
		vs3.big_card_item[i] = { };
		for j = 1, 3 do
			local obj_card = vs3.obj_card[i][j];
			local cardinfo = info.cardhuman[i][j];
			vs3.big_card_item[i][j] = UiBigCard:new({parent = obj_card,info=cardinfo,teamType=ENUM.ETeamType.unknow,infoType=3,showPro=true,camp = i,playerName =info.player_name[i][j]})
		end
	end
end

function UiLevelLoadingNew:UpdateDaLuanDouUi()
	if not self.ui or not self.ui_daluandou then
		return false
	end
	--local path = "assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing.assetbundle";
	--self.texture:set_texture(path);

	--self.normal_loading:set_active(false);

	if not self.data_daluandou then return end;
	local info = self.data_daluandou;

	self.cont_daluandou = { };
	local dld = self.cont_daluandou;
	dld.lab_hint = ngui.find_label(self.ui_daluandou, "centre_other/animation/txt_title");
	dld.lab_hint:set_active(false);
	dld.small_card = { }
	for i = 1, 4 do
		local objNode = self.ui_daluandou:get_child_by_name("sp_di" .. i)
		local lab_name = ngui.find_label(objNode, "lab_name")
		local lab_level = ngui.find_label(objNode, "lab_level")
		local lab_fight_value = ngui.find_label(objNode, "cont/lab")
		local sp_pro = ngui.find_sprite(objNode, "sp_di/sp_zhiye")
		local sp_qua = ngui.find_sprite(objNode, "sp_di/sp_zizhi")
		local sp_card = objNode:get_child_by_name("big_card_item_80");

		local cardinfo = info.cardhuman[i];
		lab_name:set_text(tostring(info.player_name[i]));
		lab_level:set_text(tostring(cardinfo.level));
		lab_fight_value:set_text(tostring(cardinfo:GetFightValue()));
		PublicFunc.SetProTypePic(sp_pro, cardinfo.config.pro_type, 3);
		PublicFunc.SetAptitudeSprite(sp_qua, cardinfo.config.aptitude);
		dld.small_card[i] = SmallCardUi:new( { parent = sp_card, info = cardinfo, sgroup = 3 });
		local sp_star = nil
		for n = 1, Const.HERO_MAX_STAR do
			sp_star = ngui.find_sprite(objNode, "content/sp_star" .. n)
			if sp_star then
				local value = n <= cardinfo.rarity
				if value then
					-- sp_star:set_sprite_name("xingxing1")
					sp_star:set_active(true)
				else
					-- sp_star:set_sprite_name("xingxing3")
					sp_star:set_active(false)
				end
			end
		end
	end

	local n = math.random(1, #gs_loading_tips);
	dld.lab_hint:set_text(gs_loading_tips[n]);
	dld.lab_hint:set_active(true);
end

function UiLevelLoadingNew:SetProgress(value)
	-- do return end
	if self.normal and self.normal.pro_bar then
		self.normal.pro_bar:set_value(value);
	end
end

function UiLevelLoadingNew:SetData(data)
	self.type_loading = data.type_loading;
	self.peak_loading = data.peak_loading;
	-- app.log("UiLevelLoadingNew:SetData self.type_loading= "..tostring(self.type_loading))
	if self.type_loading == ETypeLoading.normal then

	elseif self.type_loading == ETypeLoading.vs then
		self:SetVSData(data);
	elseif self.type_loading == ETypeLoading.vs3 then
		self:Set3v3Data(data);
	elseif self.type_loading == ETypeLoading.daluandou then
		self:SetDaLuanDouData(data);
	elseif self.type_loading == ETypeLoading.daluandou2 then
		self.curLoading = Fuzion2Loading.GetInstance();
	end
	if self.curLoading then
		self.curLoading:BeginLoading(data)
	end
end

function UiLevelLoadingNew:gc_load_state(playerid, percent)
	if self.type_loading == ETypeLoading.daluandou2 then
		-- self:UpdateDaLuanDou2State(playerid, percent);
		if self.curLoading then
			self.curLoading:UpdatePercent(playerid, percent)
		end
	end
end

-- data = {[1] = {player = xxx, cardinfo = {[1] = cardinfo1,[2] = cardinfo2, [3] = cardinfo3}}, [2] = {}}
function UiLevelLoadingNew:SetVSData(data)
	if self.type_loading ~= ETypeLoading.vs then return end

	self.data_vs = { };
	local info = self.data_vs;
	info.player = { };
	info.cardhuman = { };
	info.cardhuman_count = { };
	info.fight_value = { };

	local playType = FightScene.GetPlayMethodType()
	local teamType = ENUM.ETeamType.normal
	if playType == MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao then
		teamType = ENUM.ETeamType.unknow
	elseif playType == MsgEnum.eactivity_time.eActivityTime_arena then
		teamType = ENUM.ETeamType.arena
	end
	info.teamType = teamType
	for i = 1, 2 do
		if data[i] then
			info.player[i] = data[i].player;
			info.cardhuman_count[i] = 0;
			if data[i].cardinfo then
				info.cardhuman[i] = { };
				info.fight_value[i] = 0;
				for k, v in pairs(data[i].cardinfo) do
					info.cardhuman_count[i] = info.cardhuman_count[i] + 1;
					info.cardhuman[i][k] = v;
					info.fight_value[i] = info.fight_value[i] + v:GetFightValue(--[[teamType]]);
				end
			end
			-- 使用服务器的队伍战斗力
			-- if data[i].player.fight_value then
			-- 	info.fight_value[i] = data[i].player.fight_value
			-- end
		end
	end
end

-- data = {[1] = {[1] = {name=xxx,cardinfo=xxx},[2] = {},[3] = {}}, [2] = {} }
function UiLevelLoadingNew:Set3v3Data(data)
	if self.type_loading ~= ETypeLoading.vs3 then return end

	self.data_3v3 = { };
	local info = self.data_3v3;
	info.player_name = { };
	info.cardhuman = { };
	info.player_count = { };
	for i = 1, 2 do
		if data[i] then
			info.player_name[i] = { };
			info.cardhuman[i] = { };
			info.player_count[i] = 0;
			for j = 1, 3 do
				if data[i][j] then
					info.player_name[i][j] = data[i][j].name;
					info.cardhuman[i][j] = data[i][j].cardinfo;
					info.player_count[i] = info.player_count[i] + 1;
				end
			end
		end
	end
end

-- data = {[1] = {name = xxx,cardinfo = yyy},[2] = {},[3] = {}, [4] = {}}
function UiLevelLoadingNew:SetDaLuanDouData(data)
	if self.type_loading ~= ETypeLoading.daluandou then return end 
	self.data_daluandou = { };
	local info = self.data_daluandou;
	info.player_name = { };
	info.cardhuman = { };
	info.player_count = 0;
	for i = 1, 4 do
		if data[i] then
			info.player_name[i] = data[i].name;
			info.cardhuman[i] = data[i].cardinfo;
			info.player_count = info.player_count + 1;
		end
	end
end

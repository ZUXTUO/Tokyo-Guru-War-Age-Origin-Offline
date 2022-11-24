SmallCardUi = Class("SmallCardUi");

function SmallCardUi.SetAtlas120(atlas)
	if atlas then
		-- if not SmallCardUi.humanAtlas120 then

		-- TODO: kevin resoucrobject
		-- SmallCardUi.humanAtlas120 = ngui_atlas.create_by_asset(atlas,true);
		SmallCardUi.humanAtlas120 = ngui_atlas.create_by_asset(atlas:GetObject(), true);

		local obj = SmallCardUi.humanAtlas120:get_game_object();
		asset_game_object.dont_destroy_onload(obj);
		-- end
	else
		SmallCardUi.humanAtlas120 = nil;
	end
end

local pathRes = { };
pathRes.smallcard = "assetbundles/prefabs/ui/public/big_card_item_80.assetbundle";

--小红点类型
SmallCardUi.TipType = {
    NotShow = 1,    --不显示
    Role = 2,       --角色
	Restraint = 3,  --克制属性
    Equip = 4,      --装备
    Skill = 5,		--技能
    illumstration = 6,  --图鉴
}

SmallCardUi.SType = {
	-- 头像
	Texture = 1,
	-- 等级
	Level = 2,
	-- 队长
	Leader = 3,
	-- 小红点
	New = 4,
	-- 克制图标
	Restrait = 5,
	-- 星级
	Star = 6,
	-- 强化等级
	Qh = 7,
	-- 上阵图标
	Battle = 8,
	-- 品质
	Rarity = 9,
	-- 玩家头像（不表示品质）
	Player = 10,
	-- 资质
	Aptitude = 11,
}

SmallCardUi.SGroupTyps = {
	[1] =
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 等级
		SmallCardUi.SType.Level,
		-- 队长
		SmallCardUi.SType.Leader,
		-- 小红点
		SmallCardUi.SType.New,
		-- 克制图标
		SmallCardUi.SType.Restrait,
		-- 星级
		SmallCardUi.SType.Star,
		-- 强化等级
		SmallCardUi.SType.Qh,
		-- 上阵图标
		SmallCardUi.SType.Battle,
		-- 品质
		SmallCardUi.SType.Rarity,

	},
	[2] =
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 品质
		SmallCardUi.SType.Player,
	},
	[3] =
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 品质
		SmallCardUi.SType.Rarity,
		-- 强化等级
		SmallCardUi.SType.Qh,
	},
	[4] = -- 显示其他玩家的英雄
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 等级
		SmallCardUi.SType.Level,
		-- 星级
		SmallCardUi.SType.Star,
		-- 品质
		SmallCardUi.SType.Rarity,
		-- 强化等级
		SmallCardUi.SType.Qh,
	},
	[5] =	--显示除小红点以外的东西
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 等级
		SmallCardUi.SType.Level,
		-- 队长
		SmallCardUi.SType.Leader,
		-- 克制图标
		SmallCardUi.SType.Restrait,
		-- 星级
		SmallCardUi.SType.Star,
		-- 强化等级
		SmallCardUi.SType.Qh,
		-- 上阵图标
		SmallCardUi.SType.Battle,
		-- 品质
		SmallCardUi.SType.Rarity,
	},
	[6] =	--显示除小红点和上阵图标以外的东西
	{
		-- 头像
		SmallCardUi.SType.Texture,
		-- 等级
		SmallCardUi.SType.Level,
		-- 队长
		SmallCardUi.SType.Leader,
		-- 克制图标
		SmallCardUi.SType.Restrait,
		-- 星级
		SmallCardUi.SType.Star,
		-- 强化等级
		SmallCardUi.SType.Qh,
		-- 品质
		SmallCardUi.SType.Rarity,
	},
}
--[[
	parent = nil,
	info = nil,             --CardHuman
	uis = {
		--外部传入节点
		lbl_level = nil,    --等级                    暂时不支持(有需要再加)
		sp_leader = nil，   --队长                    暂时不支持(有需要再加)
		sp_new = nil,       --小红点                  暂时不支持(有需要再加)
		sp_restrait = nil,  --克制图标                暂时不支持(有需要再加)
		sp_stars = {},      -- 星级                   暂时不支持(有需要再加)
		sp_qhs =  {},       -- 强化等级               暂时不支持(有需要再加)
		sp_is_battle = {},  -- 上阵图标               暂时不支持(有需要再加)
		sp_shine = nil,     -- 选中框                 已支持
	},
	stypes = {              --用于控制需要显示的项，
		--注意：设置了sgroup，将失效

	},
	gray = {
		value = false, --是否灰色状态
		showLevel = false, -- 灰色状态下显示等级，与SmallCardUi.SType.Level共同决定
		on_clicked = nil, -- 灰色时点击事件           暂时不支持(有需要再加)
	}
	sgroup = 1,--配置了sgroup，stypes将失效
	team_id = nil,--如果有上阵功则填当前队伍
	enable_clicked = function() end, --启用点击回调
	disable_clicked = function() end,--禁用点击回调
    as_reward --奖励英雄(头像紫色 + 物效)
]]
function SmallCardUi:initData(data)
	self.ui = nil;
	self.bindfunc = { };
	self.cardInfo = data.info;
	--if not data.info then
		--app.log_warning("SmallCardUi:initData data.info is nil,traceback:" .. debug.traceback())
	--end
	if data.sgroup then
		self.stypes = SmallCardUi.SGroupTyps[data.sgroup]
	else
		self.stypes = data.stypes;
	end
	self.team_id = data.team_id
	self.uis = data.uis or { }
	self.name = nil;
	self.parent = data.parent or nil;
	self.point = { };
	-- ui控件
	self.btnRoot = nil;
	self.lbl_level = nil;
	self.spMark = nil;
	self.textureHeadIco = nil;
	self.spStar = { };


	-- 回调函数的额外参数
	self.externalCall = nil;
	self.callParam = nil;
	-- 半透明遮罩是否显示
	self.markVisble = false;
	-- 是否可点击
	self.canClick = true;
	-- 是否显示图标
	self.showIcon = false;
	-- 是否显示禁用图标
	self.showDisableIcon = false;
	-- 灰色状态
	self.gray = gray or {
		value = false,
		showLevel = false,
		on_clicked = nil,
	}
	self.isShine = data.isShine or false;
    --小红点类型
    self.tipType = data.tipType or SmallCardUi.TipType.Role;
    --手动刷新小红点
	self.customUpdateTip = data.customUpdateTip or false
	self.isShow = Utility.get_value(data.isShow, true)

	self.upFrame = Utility.get_value(data.upFrame, true)

	-- 拖拽功能信息
	self.dragInfo = { };
	if data.res_group then
		self.res_group = data.res_group
	end
	self.scale = 1;
    self.asReward = data.as_reward or false

    self.clickBtn = data.clickBtn or nil

    self.enableButtonFunction = true
    if data.enableButtonFunction ~= nil then
        self.enableButtonFunction = data.enableButtonFunction
    end
end


function SmallCardUi:HasSType(stype)
	if not self.stypes or type(self.stypes) ~= "table" then
		return false
	end
	for k, v in pairs(self.stypes) do
		if v == stype then
			return true
		end
	end
	return false
end

function SmallCardUi:Init(data)
	self.res_group = self._className
	data = data or { };
	self:initData(data)
	self:registFunc();
	self:initUI();
end

function SmallCardUi:registFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, SmallCardUi.on_loaded)
	self.bindfunc["on_click"] = Utility.bind_callback(self, SmallCardUi.on_click)
	self.bindfunc["on_drag_start"] = Utility.bind_callback(self, SmallCardUi.on_drag_start)
	self.bindfunc["on_drag_release"] = Utility.bind_callback(self, SmallCardUi.on_drag_release)
	self.bindfunc["on_drag_move"] = Utility.bind_callback(self, SmallCardUi.on_drag_move)
	self.bindfunc["on_press"] = Utility.bind_callback(self, SmallCardUi.on_press);
end

function SmallCardUi:unregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end

function SmallCardUi:SetDead(value)
	if self.sp_dead ~= nil then 
		if value == true then 
			self.sp_dead:set_active(true);
		else 
			self.sp_dead:set_active(false);
		end
	end 
end 
--ADD:2017-5-11日BY:刘相敬 用于替换SmallCardUi的血条样式
function SmallCardUi:replaceLifeBar(newLifeBar)
	if newLifeBar == null then 
		return;
	end 
	if not self:IsLoadSlotUiData("pro_xuetiao") then
		self.slot_data.pro_xuetiao.proLifeBar = newLifeBar
		self.slot_data.pro_xuetiao.obj = newLifeBar:get_game_object()
	elseif self.slot_data.pro_xuetiao.proLifeBar ~= newLifeBar then
		self.slot_data.pro_xuetiao.proLifeBar:set_active(false)
		self.slot_data.pro_xuetiao.proLifeBar = newLifeBar
		self.slot_data.pro_xuetiao.obj = newLifeBar:get_game_object()
	end
	-- if self.proLifeBar == nil then 
	-- 	self.proLifeBar = newLifeBar;
	-- elseif self.proLifeBar ~= newLifeBar then 
	-- 	self.proLifeBar:set_active(false);
	-- 	self.proLifeBar = newLifeBar;
	-- end 
end 

function SmallCardUi:SetLifeBar(isActive, value, moveDown, moveLen)
	local slot_pro_xuetiao = self:GetSlotUiData("pro_xuetiao")
    if slot_pro_xuetiao.proLifeBar == nil then
        return
    end
    slot_pro_xuetiao.proLifeBar:set_active(isActive)
    if not isActive then
        return
    end
    slot_pro_xuetiao.proLifeBar:set_value(value)
	if moveDown then 
		moveLen = moveLen or 20
	end
end 

function SmallCardUi:SetFormationIcon(value)
    if self.sp_on_team == nil then
        return
    end
    self.sp_on_team:set_active(value)
end 

function SmallCardUi:initUI()
	if self.ui == nil then
		if CommonUiObjectManager.IsEnable() then
			self.ui = CommonUiObjectManager.CreateObject( ECommonUi_Type.SmallCard )
			self:setName("small_card_ui");
			self:SetParent(self.parent);
			self:SetScale(self.scale);
			self:SetPosition(self.point.x, self.point.y, self.point.z);
			self:InitSmallCardUi(self.ui);
			
			if self.loadedCallBack then
				Utility.CallFunc(self.loadedCallBack, self.loadedCallParam)
				self.loadedCallBack = nil
				self.loadedCallParam = nil
			end
		else
			ResourceLoader.LoadAsset(pathRes.smallcard, self.bindfunc["on_loaded"], self.res_group);
		end
	end
end

function SmallCardUi:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes.smallcard then
		self.ui = asset_game_object.create(asset_obj);
		self:setName("small_card_ui");
		self:SetParent(self.parent);
		self:SetScale(self.scale);
		self:SetPosition(self.point.x, self.point.y, self.point.z);
		self:InitSmallCardUi(self.ui);

		if self.loadedCallBack then
			Utility.CallFunc(self.loadedCallBack, self.loadedCallParam)
			self.loadedCallBack = nil
			self.loadedCallParam = nil
		end
	end
end

function SmallCardUi:SetLoadedCallback(cb, param)
	if self.ui then
		Utility.CallFunc(cb, param)
	else
		self.loadedCallBack = cb
		self.loadedCallParam = param
	end
end

function SmallCardUi:setName(name)
	if name then
		if self.ui then
			self.name = name;
			self.ui:set_name(name);
		else
			self.name = name;
		end
	end
end

function SmallCardUi:GetName()
	return self.name
end

-- 是否灰色状态
function SmallCardUi:IsGray()
	if not self.gray or type(self.gray) ~= "table" then
		return false
	end
	return self.gray.value
end

-- 是否灰色状态下显示等级
function SmallCardUi:IsGrayShowLevel()
	if type(self.gray) == "table" and self.gray.value == true and self.gray.showLevel == false then
		return false
	end
	return true
end

function SmallCardUi:SetGray(value, showLevel, on_clicked)

	if self.gray.value == value then
		return
	end

	self.gray.value = value
	self.showLevel = Utility.get_value(showLevel, false)
	self.gray.on_clicked = on_clicked
	--self:UpdateUi()
    if self.ui then
		if self.gray.value then
			util.set_all_widget_color(self.ui, true, false, 0, 0, 0, 1)
		else
			util.set_all_widget_color(self.ui, true, false, 1, 1, 1, 1)
		end
    end

	self:SetLevel()
end

function SmallCardUi:HasData()
	return (self.cardInfo ~= nil and self.cardInfo.rarity ~= nil)
end

function SmallCardUi:hideSelectFrame()
	--app.log("||||hideSelectFrame:"..tostring(self));
	self.isShine = false;
	self:ChoseItem(self.isShine);
end 

function SmallCardUi:showSelectFrame()
	--app.log("||||showSelectFrame:"..tostring(self));
	self.isShine = true;
	self:ChoseItem(self.isShine);
end 

function SmallCardUi:EnableButtonFunc(is)
	self.enableButtonFunction = is
	if self.origBtnRoot then
		self.origBtnRoot:set_active(self.enableButtonFunction)
	end
end

function SmallCardUi:LoadSlotContailQh(obj)
	self.slot_data.contail_qh.obj = obj
	local spQhs = {}
	for i = 1, Const.HERO_QH_LEVEL do
		spQhs[i] = ngui.find_sprite(obj, "sp" .. i)
	end
	self.slot_data.contail_qh.spQhs = spQhs
	self.slot_data.contail_qh.grid_contail_qh = ngui.find_grid(obj, "contail_qh")
	self.slot_data.contail_qh.go_contail_qh = obj
end

function SmallCardUi:LoadSlotRightTop(obj)
	self.slot_data.right_top.obj = obj
	self.slot_data.right_top.sp_new = ngui.find_sprite(obj, "sp_new")
	self.slot_data.right_top.spRecommend = ngui.find_sprite(obj, "sp_tuijian")
	self.slot_data.right_top.txtRecommend = ngui.find_label(obj, "sp_tuijian/lab")
end

function SmallCardUi:LoadSlotProXuetiao(obj)
	self.slot_data.pro_xuetiao.obj = obj
	self.slot_data.pro_xuetiao.proLifeBar = ngui.find_progress_bar(obj, "pro_xuetiao")
end

function SmallCardUi:LoadSlotFxCheckinMonth(obj)
	self.slot_data.fx_checkin_month.obj = obj
	self.slot_data.fx_checkin_month.objCommonEffect = obj
	local commonEffect = obj:get_child_by_name("fx_checkin_month/fx_checkin_month")
	self.slot_data.fx_checkin_month.commonEffect = commonEffect
	self.slot_data.fx_checkin_month.isParentInitScale = false
end

function SmallCardUi:InitSlotUiData()
	-- 按需加载的节点
	self.slot_data = {}
	self.slot_data.contail_qh = {load_func=self.LoadSlotContailQh}
	self.slot_data.right_top = {load_func=self.LoadSlotRightTop}
	self.slot_data.pro_xuetiao = {load_func=self.LoadSlotProXuetiao}
	self.slot_data.fx_checkin_month = {load_func=self.LoadSlotFxCheckinMonth}

	if not CommonUiObjectManager.IsEnable() then
		for name, data in pairs(self.slot_data) do
			local obj = self.ui:get_child_by_name("sp_back/"..name)
			data.load_func(self, obj)
		end
	end
end

function SmallCardUi:DestroySlotUiData()
	self.slot_data = nil
end

function SmallCardUi:GetSlotUiData(name)
	local data = self.slot_data[name]
	if data and data.obj == nil then
		data.load_func(self, 
			CommonUiObjectManager.AddMaskComponent(self.ui, ECommonUi_Type.SmallCard, name))
	end
	return data
end

function SmallCardUi:IsLoadSlotUiData(name)
	local data = self.slot_data[name]
	return data.obj ~= nil
end

function SmallCardUi:InitSmallCardUi(obj)
	self:InitSlotUiData()

    self.origBtnRoot = ngui.find_button(self.ui, "sp_back1")
	self.btnRoot = self.clickBtn or self.origBtnRoot;

	self.btnRoot:reset_on_click();
	self.btnRoot:set_on_click(self.bindfunc["on_click"], "MyButton.NoneAudio");
	self.sp_dead = ngui.find_sprite(self.ui, "sp_art_font");
	self.sp_back = ngui.find_sprite(self.ui,"sp_back");
	self.lbl_level = ngui.find_label(self.ui, "sp_back/human/lab_level");
	self.sp_left_leader = ngui.find_sprite(self.ui, "sp_back/human/sp_left_leader")

	-- 选中框外部赋值
	self.sp_shine = self.uis.sp_shine or ngui.find_sprite(self.ui, "sp_back/human/sp_shine");
	if self.uis.sp_shine then
		local sp_shine = ngui.find_sprite(self.ui, "sp_back/human/sp_shine")
		if sp_shine then
			sp_shine:set_active(false)
		end
	end
	self.spMark = ngui.find_sprite(self.ui, "sp_back/sp_mark");
	self.btn_add = ngui.find_sprite(self.ui, "sp_back/sp_mark");
	self.sp_add = ngui.find_sprite(self.ui, "sp_back/sp_mark/sp_add")

	self.textureHeadIco = ngui.find_sprite(self.ui, "sp_back/human/text_human");
	-- 属性克制
	-- self.sp_restraint = ngui.find_sprite(self.ui, "sp_back/right_top/lbl_pro")
	-- 排行？
	-- self.spState = ngui.find_sprite(self.ui, "sp_back/right_top/sp_fight")
	-- self.labState = ngui.find_label(self.ui, "sp_back/right_top/sp_fight/lab");
	-- 上阵
	self.sp_on_team = ngui.find_sprite(self.ui, "sp_back/sp")
    --资质
    self.spAptitude = ngui.find_sprite(self.ui, "sp_back/sp_s")


	self.go_contain_star = self.ui:get_child_by_name("sp_back/human/contain_star");

	for i = 1, Const.HERO_MAX_STAR do
		self.spStar[i] = ngui.find_sprite(self.go_contain_star, "sp_star" .. i);
	end

	-- 重置状态
	if self.btn_add then self.btn_add:set_active(false) end
	if self.sp_restraint then self.sp_restraint:set_active(false) end
	if self.spState then self.spState:set_active(false) end
	if self.sp_on_team then self.sp_on_team:set_active(false) end
	if self.go_contain_star then self.go_contain_star:set_active(false) end
	if self.spAptitude then self.spAptitude:set_active(false) end
	if self.sp_dead then self.sp_dead:set_active(false) end

	--bug 重置为正常颜色，其它使用此组件时，可能已经将其设为灰色
	util.set_all_widget_color(self.ui, true, false, 1, 1, 1, 1)
	self.ui:set_active(self.isShow)
	
	if self.isShow then
		self:UpdateUi();

		if self.showOnlyPic == true then
			self:ShowOnlyPic()
		end
	end
end

local _spDefaultHeadName = "weizhi"
local spBkName =
{
	[0] = "touxiangbeijing1",    
    [1] = "touxiangbeijing1",
    [2] = "touxiangbeijing2",
    [3] = "touxiangbeijing3",
    [4] = "touxiangbeijing4",
    [5] = "touxiangbeijing5",
    [6] = "touxiangbeijing6",
}


function SmallCardUi:UpdateUi()
	if not self.ui then return end

	-- 设置头像
	self:SetHeadTexture()
	-- 设置等级
	self:SetLevel()
	-- 设置Leader
	self:SetLeader()
	-- 设置fight
	-- 设置属性克制
	self:SetRestraint()
	-- 设置New
    if not self.customUpdateTip and (self.cardInfo and self.cardInfo.index ~= nil and self.cardInfo.index ~= 0) then
	    self:SetSpNew()
    end
	-- 设置上阵
	self:SetBattleSp()
	-- 设置星级
	self:SetStar()
	-- 设置潜能强化
	self:SetQh()
	-- 设置品级
	self:SetRarity()
	-- 设置资质
	self:SetAptitude()
	-- 设置玩家边框
	self:SetPlayerFrame()
	-- 设置选中框
	self:ChoseItem(self.isShine);
	-- 设置遮罩
	self:SetTranslucent(self.markVisble);
	-- 添加图标
	self:SetAddIcon(false);
	--    self:SetTeamPosIcon(self.team_pos, self.team_lab);

    --作为奖励
    self:SetAsReward()
	self:SetDragStart(self.dragInfo.callbackStart);
	self:SetDragRelease(self.dragInfo.callbackRelease);
	self:SetDragMove(self.dragInfo.callbackMove);
	self:SetDragRestriction(self.dragInfo.restriction);
	self:SetDragIsClone(self.dragInfo.isClone);

	self:EnableButtonFunc(self.enableButtonFunction)
end

function SmallCardUi:AddRarityEffect(ef)
    self.objRarityEffect = ef
    if self.objRarityEffect == nil then
        return
    end
    local info = PublicFunc.GetRarityInfo(self.cardInfo.realRarity)
	if info then
        --app.log('=================>>info.level =  ' .. tostring(info.level))
		local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
        if info.level == 0 then
            slot_fx_checkin_month.objCommonEffect:set_active(true)
        else
            slot_fx_checkin_month.objCommonEffect:set_active(false)
			local slot_contail_qh = self:GetSlotUiData("contail_qh")
            local sp_qh = slot_contail_qh.spQhs[info.level]
		    if sp_qh then
                self._rarityEffect = self.objRarityEffect:clone() 
                self._rarityEffect:set_parent(sp_qh:get_game_object()) 
                self._rarityEffect:set_local_position(0, 0, 0)
                self._rarityEffect:set_active(false)
                self._rarityEffect:set_active(true)
		    end
        end
	end
	self:CheckParentInitScale()
end

function SmallCardUi:SetAsReward(v)
    if v ~= nil then
        self.asReward = v
    end
	local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
    if slot_fx_checkin_month.objCommonEffect then
        if self.asReward then
			if self.upFrame then
				--头像框设为紫色
				if self.sp_back then
					local info = PublicFunc.GetRarityInfo(ENUM.EHeroRarity.Purple)
					self.sp_back:set_sprite_name(info.headBg.."k")
				end
			end
            slot_fx_checkin_month.objCommonEffect:set_active(true)
        else
            slot_fx_checkin_month.objCommonEffect:set_active(false)
        end
    end	
	self:CheckParentInitScale()
end

function SmallCardUi:CheckParentInitScale()
	if self.parent == nil then return end

	local slot_fx_checkin_month = self:GetSlotUiData("fx_checkin_month")
	if slot_fx_checkin_month.commonEffect and not slot_fx_checkin_month.isParentInitScale then
		slot_fx_checkin_month.isParentInitScale = true
		local x, y, z = slot_fx_checkin_month.commonEffect:get_local_scale();
		local px, py, pz = self.parent:get_local_scale();
		slot_fx_checkin_month.commonEffect:set_local_scale(px*x, py*y, py*z);
	end
end

-- function SmallCardUi:SetRewardEffectScale(x, y, z)
--     if self.rewardEffect then
--         self.rewardEffect:set_local_scale(x, y, z)
--     end
-- end

function SmallCardUi:SetHeadTexture()
	local hasType = self:HasSType(SmallCardUi.SType.Texture)
	if self.textureHeadIco then
		if hasType then
			if self:HasData() then
				local icon_value = self.cardInfo.small_icon
				if icon_value and icon_value ~= 0 then
					PublicFunc.Set120Icon(self.textureHeadIco, icon_value);
				end
			elseif self.small_icon then
				local icon_value = self.small_icon
				PublicFunc.Set120Icon(self.textureHeadIco, icon_value);
			else
				PublicFunc.Set120Icon(self.textureHeadIco, _spDefaultHeadName);
			end
		else
			PublicFunc.Set120Icon(self.textureHeadIco, _spDefaultHeadName);
		end

		if self:IsGray() then
			PublicFunc.SetUISpriteGray(self.textureHeadIco)
		else
			PublicFunc.SetUISpriteWhite(self.textureHeadIco)
		end
	end
end

-- 设置品级
function SmallCardUi:SetRarity()
	local hasType = self:HasSType(SmallCardUi.SType.Rarity)
	-- TODO:品级数据
	if self.sp_back then
		if hasType then
			local info = nil
			if self:HasData() then
				info = PublicFunc.GetRarityInfo(self.cardInfo.realRarity)				
			else
				info = PublicFunc.GetRarityInfo(0)		
			end

			self.sp_back:set_sprite_name(info.headBg.."k")

			if self:IsGray() then
				PublicFunc.SetUISpriteGray(self.sp_back)
			else
				PublicFunc.SetUISpriteWhite(self.sp_back)
			end
		end


	end
end

function SmallCardUi:SetRarityOrange()
	if self.sp_back then
		local info = PublicFunc.GetRarityInfo(ENUM.EHeroRarity.Orange)
		self.sp_back:set_sprite_name(info.headBg.."k")
	end
end

function SmallCardUi:SetTrainningRarity(rarity)
	local hasType = self:HasSType(SmallCardUi.SType.Rarity)
	-- TODO:品级数据
	if self.sp_back then
		if hasType then
			self.sp_back:set_sprite_name(rarity)
		end
	end

end

-- 玩家边框（不表示品质，使用白色品质做底）
function SmallCardUi:SetPlayerFrame()
	if not self.sp_back then return end

	local hasType = self:HasSType(SmallCardUi.SType.Rarity)
	if not hasType then
		hasType = self:HasSType(SmallCardUi.SType.Player)
		if hasType then
			local info = PublicFunc.GetRarityInfo(ENUM.EHeroRarity.White)
			self.sp_back:set_sprite_name(info.headBg.."k")
			if self:IsGray() then
				PublicFunc.SetUISpriteGray(self.sp_back)
			else
				PublicFunc.SetUISpriteWhite(self.sp_back)
			end
		end
	end
end

-- 设置星级
function SmallCardUi:SetStar()
	local hasType = self:HasSType(SmallCardUi.SType.Star)
	if self.go_contain_star then
		self.go_contain_star:set_active(hasType)
	end
	if hasType then
		if type(self.spStar) == "table" and self:HasData() then
			for i = 1, Const.HERO_MAX_STAR do
				local sp_star = self.spStar[i]
				if sp_star then
					if i <= self.cardInfo.rarity then
						-- sp_star:set_sprite_name("xingxing1")
						sp_star:set_active(true)
					else
						-- sp_star:set_sprite_name("xingxing3")
						sp_star:set_active(false)
					end

					if self:IsGray() then
						PublicFunc.SetUISpriteGray(sp_star)
					else
						PublicFunc.SetUISpriteWhite(sp_star)
					end
				end
			end
		else
			for i = 1, Const.HERO_MAX_STAR do
				if self.spStar[i] then
					self.spStar[i]:set_active(false);
				end
			end
		end
	end

end

-- 设置英雄等级点点
function SmallCardUi:SetQh()
	local hasType = self:HasSType(SmallCardUi.SType.Qh)
	local slot_contail_qh = self:GetSlotUiData("contail_qh")
	if slot_contail_qh.go_contail_qh then
		slot_contail_qh.go_contail_qh:set_active(hasType)
	end
	-- TODO:当前潜能强化等级
	if hasType and type(slot_contail_qh.spQhs) == "table" and self:HasData() then
		local info = PublicFunc.GetRarityInfo(self.cardInfo.realRarity)
		for i = 1, Const.HERO_QH_LEVEL do
			local sp_qh = slot_contail_qh.spQhs[i]
			if sp_qh then
				sp_qh:set_active(i <= info.level)

				sp_qh:set_sprite_name(info.rarityName)
				
				if self:IsGray() then
					PublicFunc.SetUISpriteGray(sp_qh)
				else
					PublicFunc.SetUISpriteWhite(sp_qh)
				end
			end
		end        
        slot_contail_qh.grid_contail_qh:reposition_now()
	else
		for i = 1, Const.HERO_QH_LEVEL do
			local sp_qh = slot_contail_qh.spQhs[i]
			if sp_qh then
				sp_qh:set_active(false);
			end
		end
	end
end

-- 设置上阵
function SmallCardUi:SetBattleSp()
	local hasType = self:HasSType(SmallCardUi.SType.Battle)
	if self.sp_on_team then
		if self:HasData() and hasType then
			self.sp_on_team:set_active(g_dataCenter.player:IsTeam(self.cardInfo.index, self.team_id))

			if self:IsGray() then
				PublicFunc.SetUISpriteGray(self.sp_on_team)
			else
				PublicFunc.SetUISpriteWhite(self.sp_on_team)
			end
		else
			self.sp_on_team:set_active(false)
		end


		-- self.sp_on_team:set_active(hasType)
	end
end

function SmallCardUi:SetBattleSpEx(value)
	if type(value) ~= "boolean" then return end
	local hasType = true -- self:HasSType(SmallCardUi.SType.Battle) 去掉限制
	if self.sp_on_team and hasType then
		self.sp_on_team:set_active(value)
	end
end

-- 设置资质图片
function SmallCardUi:SetAptitude()
	local hasType = self:HasSType(SmallCardUi.SType.Aptitude)
	if self.spAptitude then
		if self:HasData() and hasType then
			self.spAptitude:set_active(true)
			PublicFunc.SetAptitudeSprite(self.spAptitude, self.cardInfo.config.aptitude)
			if self:IsGray() then
				PublicFunc.SetUISpriteGray(self.spAptitude)
			else
				PublicFunc.SetUISpriteWhite(self.spAptitude)
			end
		else
			self.spAptitude:set_active(false)
		end
	end
end

function SmallCardUi:SetClick(can_click)
	self.canClick = can_click;
	if self.cardInfo then
		if self.cardInfo.lockType then
			self.canClick = false;
		end
	end
end

function SmallCardUi:GetCardInfo()
	return self.cardInfo
end

function SmallCardUi:SetData(info, obj, small_icon)
	self.cardInfo = info;
	self.small_icon = small_icon;

	if (self.ui == nil) then
		return
	end

	self:UpdateUi();
end

function SmallCardUi:SetDataNumber(number, count)
	local info = CardHuman:new( { number = number, count = count });
	self:SetData(info);
end

function SmallCardUi:SetParent(parent)
	if parent then
		if self.ui ~= nil then
			self.ui:set_parent(parent);
			self.ui:set_local_scale(Utility.SetUIAdaptation());
			self.ui:set_local_position(0, 0, 0);
		else
			self.parent = parent;
		end
	end
end

function SmallCardUi:ChoseItem(is_chose)
	if self.sp_shine then
		self.sp_shine:set_active(is_chose);
	end
end




function SmallCardUi:SetPosition(x, y, z)
	x = x or 0;
	y = y or 0;
	z = z or 0;
	if self.ui ~= nil then
		self.ui:set_local_position(x, y, z);
	else
		self.point = { x = x, y = y, z = z };
	end
end

function SmallCardUi:SetParam(param)
	self.callParam = param;
end

function SmallCardUi:GetParam()
	return self.callParam;
end

function SmallCardUi:SetCallback(func)
	self.externalCall = func;
end

function SmallCardUi:SetAlwaysReponseClick(b)
	self.alwaysReponseClick = b
end

function SmallCardUi:on_click(t)
	if (self.externalCall and self.canClick) or self.alwaysReponseClick == true then
		if not self:IsGray() then
			AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
		end
		Utility.CallFunc(self.externalCall, self, self.cardInfo, self.callParam);
	end
end

function SmallCardUi:Show()
	self.isShow = true
	if (self.ui ~= nil) then
		self.ui:set_active(true);
	end
end
function SmallCardUi:Hide()
	self.isShow = false
	if (self.ui ~= nil) then
		self.ui:set_active(false);
	end
end
-- 设置半透明遮罩
function SmallCardUi:SetTranslucent(show_mask)
	self.markVisble = Utility.get_value(show_mask, false);
	if self.spMark then
		self.spMark:set_active(self.markVisble);
	end
end

-- 设置等级
function SmallCardUi:SetLevel(level)
	if self.lbl_level then
		local hasType = self:HasSType(SmallCardUi.SType.Level)
		local showLevel = self:IsGrayShowLevel()
		self.lbl_level:set_active(hasType and showLevel)
		if hasType then
			local level_value = ""
			if nil ~= level then
				level_value = level
			else
				if self:HasData() then
					level_value = self.cardInfo.level
				end
			end
			self.lbl_level:set_text(tostring(level_value))
			-- app.log("SmallCardUi:SetLevel:"..tostring(level_value)..debug.traceback())
		end
	end
end
-- 设置leader信息
function SmallCardUi:SetLeader()
	local hasType = self:HasSType(SmallCardUi.SType.Leader)
	if self.sp_left_leader then
		if hasType and self:HasData() then
			self.sp_left_leader:set_active(true)
            PublicFunc.SetProTypeFont(self.sp_left_leader, self.cardInfo.pro_type)

			if self:IsGray() then
				PublicFunc.SetUISpriteGray(self.sp_left_leader)
			else
				PublicFunc.SetUISpriteWhite(self.sp_left_leader)
			end
		else
			self.sp_left_leader:set_active(false)
		end

	end
	-- TODO:设置sprite_name
end

function SmallCardUi:SetRecommend(isShow)
--[[
	-- 策划确定头像没有限时推荐功能
	-- 推荐和守护之心显示会冲突
	local slot_right_top = self:GetSlotUiData("right_top")
    if slot_right_top.spRecommend then
        slot_right_top.spRecommend:set_active(isShow)
		if isShow then
			slot_right_top.spRecommend:set_sprite_name("ty_tuijianjiaobiao")
			slot_right_top.txtRecommend:set_text("推荐")
			slot_right_top.txtRecommend:set_effect_color(151/255, 57/255, 0/255, 1)
		end
    end
	]]
end

function SmallCardUi:SetGuardHeart(isShow)
	local slot_right_top = self:GetSlotUiData("right_top")
    if slot_right_top.spRecommend then
        slot_right_top.spRecommend:set_active(isShow)
		if isShow then
			slot_right_top.spRecommend:set_sprite_name("ty_tuijianjiaobiao2")
			slot_right_top.txtRecommend:set_text("守护")
			slot_right_top.txtRecommend:set_effect_color(3/255, 38/255, 39/255, 1)
		end
    end
end

-- 设置小提示图标
function SmallCardUi:SetSpNew(isShow)
    if self.cardInfo == nil then
        return
    end
	local slot_right_top = self:GetSlotUiData("right_top")
    if isShow == nil then 
        local hasType = self:HasSType(SmallCardUi.SType.New)
        if not hasType then
	        slot_right_top.sp_new:set_active(false)
        else
            local state = false
            if self.tipType == SmallCardUi.TipType.Role then
                state = self.cardInfo:CanPowerUp()

            elseif self.tipType == SmallCardUi.TipType.Restraint then
				state = PublicFunc.ToBoolTip( self.cardInfo:CanUpRestrain() )

            elseif self.tipType == SmallCardUi.TipType.Equip then
				state = PublicFunc.ToBoolTip( self.cardInfo:CanLevelUpAnyEquip() ) or
						PublicFunc.ToBoolTip( self.cardInfo:CanStarUpAnyEquip() )
            elseif  self.tipType == SmallCardUi.TipType.Skill then
				state = PublicFunc.ToBoolTip( self.cardInfo:CanSkillLevel() )
			elseif self.tipType == SmallCardUi.TipType.illumstration then
				state = self.cardInfo:CanUpdateIllumstrationState()
            end
	        slot_right_top.sp_new:set_active(state) 

            if self:IsGray() then
		        PublicFunc.SetUISpriteGray(slot_right_top.sp_new)
	        else
		        PublicFunc.SetUISpriteWhite(slot_right_top.sp_new)
	        end
        end
    else 
		if isShow == true then 
			slot_right_top.sp_new:set_active(true)
		else 
			slot_right_top.sp_new:set_active(false)
		end
	end
end

-- 设置属性克制
function SmallCardUi:SetRestraint()
	local hasType = self:HasSType(SmallCardUi.SType.Restrait)
	if self.sp_restraint then
		self.sp_restraint:set_active(hasType)

		if hasType and self.sp_restraint and self:HasData() and type(self.cardInfo.restraint) == type(0) then
			PublicFunc.SetRestraintSpriteForSmallCard(self.sp_restraint, self.cardInfo.restraint)
		else
			self.sp_restraint:set_sprite_name("");
		end

		if self:IsGray() then
			PublicFunc.SetUISpriteGray(self.sp_restraint)
		else
			PublicFunc.SetUISpriteWhite(self.sp_restraint)
		end
	end
end


-- team_pos TODO 未实现
function SmallCardUi:SetTeamPosIcon(team_pos, lab)
	-- app.log("xxxxx:SmallCardUi:SetTeamPosIcon " .. tostring(team_pos) .. "   " .. tostring(lab) .. "  ")
	do return end
	self.showIcon =(team_pos ~= 0 and team_pos ~= nil);
	self.team_pos = team_pos;
	self.team_lab = lab;
	if type(team_pos) == "number" then
		if self.spState then
			self.spState:set_sprite_name(EteamPicName[team_pos]);
			self.spState:set_active(self.showIcon);
		end
		if team_pos == 4 then
			if self.spLockBlue then
				self.spLockBlue:set_active(true);
				if self.labLockBlue then
					self.labLockBlue:set_text("替补");
				end
			end
		else
			if self.spLockBlue then
				self.spLockBlue:set_active(false);
			end
		end
		if team_pos == 5 then
			if self.labState and lab then
				self.labState:set_text(lab);
				self.labState:set_active(true);
			end
		else
			if self.labState then
				self.labState:set_active(false);
			end
		end
	else

	end
end

-- 设置禁用图标
function SmallCardUi:SetDisableIcon(visible)
	self.showDisableIcon = visible;
	if self.spLock then
		self.spLock:set_active(visible);
	end
end

-- 设置添加图标按钮 TODO:英雄头像也有这个功能？？？？
function SmallCardUi:SetAddIcon(visible)
	self.showAddIcon = visible;
	if self.btn_add then
		self.btn_add:set_active(visible);
	end
end

function SmallCardUi:SetAddIconDisactive()
	if self.sp_add then
		self.sp_add:set_active(false);
	end
end

-- 隐藏所有仅显示图片
function SmallCardUi:ShowOnlyPic()
	self.showOnlyPic = true
	if self.ui then
		self.stypes = { SmallCardUi.SType.Texture, SmallCardUi.SType.Player }
		self:UpdateUi()
	end
end

function SmallCardUi:DestroyUi()
	self:DestroySlotUiData()

	if self.ui then
		if CommonUiObjectManager.IsEnable() then
			CommonUiObjectManager.RemoveObject( ECommonUi_Type.SmallCard, self.ui )
		else
			self.ui:set_active(false)
		end
		self.ui = nil
	end
	self:unregistFunc();
	

	PublicFunc.ClearUserDataRef(self, 1)
	-- ResourceLoader.ClearGroupCallBack(self.res_group)
end

function SmallCardUi:SetScale(scale)
	self.scale = scale;
	if self.ui then
		self.ui:set_local_scale(scale, scale, scale);
	end
end

function SmallCardUi:SetSGroup( group_data )
	if  type(group_data) == "number" then
		self.stypes = SmallCardUi.SGroupTyps[group_data]
	else
		if type( group_data ) == "table" then
			self.stypes = group_data;
		else
			app.log( "SmallCardUi设置参数错误 SetSGroup" );
		end
	end
	self:UpdateUi()
end



-- 设置拖拽回调
function SmallCardUi:SetDragStart(func)
	self.dragInfo.callbackStart = func;
	if self.ui and func then
		self.btnRoot:set_on_dragdrop_start(self.bindfunc["on_drag_start"]);
	end
end
function SmallCardUi:SetDragRelease(func)
	self.dragInfo.callbackRelease = func;
	if self.ui and func then
		self.btnRoot:set_on_dragdrop_release(self.bindfunc["on_drag_release"]);
	end
end
-- 设置按压回调
function SmallCardUi:SetPressCall(func,paramObj)
	self.pressCall = func;
	self.pressParamObj = paramObj;
	if self.ui and func then
		self.btnRoot:set_on_ngui_press(self.bindfunc["on_press"]);
	end
end 
function SmallCardUi:SetDragMove(func)
	self.dragInfo.callbackMove = func;
	if self.ui and func then
		self.btnRoot:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
	end
end
function SmallCardUi:SetDragRestriction(restriction_type)
	self.dragInfo.restriction = restriction_type;
	if self.ui and restriction_type then
		self.btnRoot:set_dragdrop_restriction(restriction_type);
	end
end
function SmallCardUi:SetDragIsClone(is_clone)
	self.dragInfo.isClone = is_clone;
	if self.ui and is_clone ~= nil then
		self.btnRoot:set_is_dragdrop_clone(is_clone);
	end
end
function SmallCardUi:on_drag_start(src)
	if self.dragInfo.callbackStart and self.canClick then
		Utility.CallFunc(self.dragInfo.callbackStart, src, self, self.cardInfo);
	end
end
function SmallCardUi:on_drag_release(src, tar)
	if self.dragInfo.callbackRelease and self.canClick then
		Utility.CallFunc(self.dragInfo.callbackRelease, src, tar, self, self.cardInfo);
	end
end
function SmallCardUi:on_drag_move(name, x, y, go_obj)
	if self.dragInfo.callbackMove and self.canClick then
		Utility.CallFunc(self.dragInfo.callbackMove, name, x, y, go_obj);
	end
end
function SmallCardUi:on_press(name,state,x,y,go_obj)
	if self.pressCall then 
		Utility.CallFunc(self.pressCall,self.pressParamObj:get_name(),state,x, y, self.pressParamObj);
	end
end

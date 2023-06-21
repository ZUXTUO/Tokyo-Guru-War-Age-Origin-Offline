UiBigCard = Class("UiBigCard");

local default_texture = "assetbundles/prefabs/ui/image/icon/head_pic/170_440/klz_moshengren.assetbundle";
local res = "assetbundles/prefabs/ui/public/cont_big_item.assetbundle";

local _UIText = {
    [1] = '[FCD901]%s[-]级'
}

function UiBigCard.GetRes()
	return {res}
end

-- 设置加载完成回调
function UiBigCard:SetLoadedCallback(cb, param)
	if self.ui then
		Utility.CallFunc(cb, param)
	else
		self.loadedCallBack = cb
		self.loadedCallParam = param
	end
end
-- 卡牌信息
function UiBigCard:SetData(info, team_type, obj)
	self.cardInfo = info;
	self.teamType = team_type;
	if obj then
		self.ui = obj;
		self:InitBigCardUi(obj);
	end
	if self.ui then
		self:UpdateUi();
	end
end
function UiBigCard:SetDataNumber(number, team_type, obj)
	local info = CardHuman:new( { number = number, count = count });
	self:SetData(info, team_type, obj);
end
-- 玩家名字(仅限于infoType为23有效)
function UiBigCard:SetPlayerName(name)
	self.playerName = name;
	if self.ui then
		for i=2,3 do
			if self.cont[i].labPlayerName then
				if self.playerName then
					self.cont[i].labPlayerName:set_text(self.playerName);
				else
					self.cont[i].labPlayerName:set_text("");
				end
			end
			if i == 3 then
				self.cont[3].nodeMatching:set_active(false)
				--玩家本人名字
				if self.playerName == g_dataCenter.player:GetName() then
					PublicFunc.SetUILabelYellow(self.cont[3].labPlayerName) --显示黄色字体
				else
					PublicFunc.SetUILabelWhite(self.cont[3].labPlayerName)
				end
			end
		end
	end
end
-- 设置是否显示“匹配中...”
function UiBigCard:ShowMatching(bool)
	if self.ui then
		self.cont[3].nodeMatching:set_active(bool)
	end
end
-- 空时是否显示添加按钮
function UiBigCard:SetShowAddButton(isShow)

	if self.showAddButton == isShow then
		return
	end

	self.showAddButton = isShow

	if self.spAdd then
		self.spAdd:set_active(isShow)
	end
end
-- 设置血条（仅限于infoType为1有效）
function UiBigCard:SetBloodPro(blood_pro)
	
end
-- 显示状态（仅限于infoType为2有效）
function UiBigCard:SetFightPro(fightPro)
	self.fightPro = fightPro;
	if self.ui then
		self.cont[2].labFightPro:set_text(tostring(self.fightPro));
	end
end
-- 设置边框品质颜色
function UiBigCard:SetFrame()
	--TODO 待策划确认
end
-- 设置阵营边框（1蓝2红）
function UiBigCard:SetCamp(camp)
	-- self.camp = camp or 1;
	-- if self.ui then
	-- 	if self.camp == 1 then
	-- 		self.spFrame:set_active(false);
	-- 	else
	-- 		self.spFrame:set_active(true);
	-- 	end
	-- end
end
-- 设置变灰
function UiBigCard:SetGray(is_gray)
	self.isGray = Utility.get_value(is_gray, true);
	if self.ui then
		if self.isGray then
			util.set_all_widget_color(self.ui, true, false, 0, 0, 0, 1)
			PublicFunc.SetUILabelGray(self.cont[1].labLv)
			PublicFunc.SetUILabelGray(self.cont[1].txtFight)
			PublicFunc.SetUILabelGray(self.cont[1].labFightValue)
		else
			util.set_all_widget_color(self.ui, true, false, 1, 1, 1, 1)
			PublicFunc.SetUILabelWhite(self.cont[1].labLv) 
			PublicFunc.SetUILabelWhite(self.cont[1].txtFight) 
			PublicFunc.SetUILabelWhite(self.cont[1].labFightValue) 
			self:NeedShowCardName(self.showCardName);
		end
    end
end
-- 是否显示（攻防技）
function UiBigCard:SetProType(showPro)
	if showPro ~= nil then
		self.showPro = showPro;
	else
		self.showPro = true;
	end
	if self.ui then
		self.spPro:set_active(self.showPro);
	end
end
-- 设置队伍位置信息（-1无，0队长，123显示123）
function UiBigCard:SetTeamPos(pos)
	self.teamPos = pos;
	if self.ui then
		if self.teamPos == 0 then
			self.spLeader:set_active(true);
			self.spTeamPosNum:set_active(false);
		elseif self.teamPos == 1 then
			self.spLeader:set_active(false);
			self.spTeamPosNum:set_active(true);
			self.spTeamPosNum:set_sprite_name("tx_chuchang_d1");
		elseif self.teamPos == 2 then
			self.spLeader:set_active(false);
			self.spTeamPosNum:set_active(true);
			self.spTeamPosNum:set_sprite_name("tx_chuchang_d2");
		elseif self.teamPos == 3 then
			self.spLeader:set_active(false);
			self.spTeamPosNum:set_active(true);
			self.spTeamPosNum:set_sprite_name("tx_chuchang_d3");
		else
			self.spLeader:set_active(false);
			self.spTeamPosNum:set_active(false);
		end
	end
end
-- 显示类型（1~4个类型）
-- 1, --> 普通，燃烧
-- 2, --> 3v3
-- 2, --> 克隆战
-- 3, --> 只有一个lab的
-- 4, --> 自己
function UiBigCard:SetInfoType(info_type)
	self.infoType = info_type;
	self:UpdateUi()
end

--显示红点
function UiBigCard:SetSpNew(show)
    if self.redpoits then
        self.redpoits:set_active(show)
    end
end

-- 是否显示卡片名字
function UiBigCard:NeedShowCardName(show)
	if show == nil then
		self.showCardName = true;
	else
		self.showCardName = show;
	end
	if self.ui and self.cardInfo then
		local name = self.cardInfo.name
		if self.useWhiteName then
			name = PublicFunc.ProcessNameSplit(name)
		end
		self.cont[1].labName:set_text(name);
		self.cont[2].labName:set_text(name);
	end
end

function UiBigCard:SetParent(parent)
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

function UiBigCard:SetScale(scale)
	self.scale = scale or 1;
	if self.ui then
		self.ui:set_local_scale(self.scale, self.scale, self.scale);
	end
end

function UiBigCard:SetPosition(x, y, z)
	x = x or 0;
	y = y or 0;
	z = z or 0;
	if self.ui ~= nil then
		self.ui:set_local_position(x, y, z);
	else
		self.point = { x = x, y = y, z = z };
	end
end
-- 设置节点名字
function UiBigCard:SetObjName(name)
	if name then
		if self.ui then
			self.objName = name;
			self.ui:set_name(name);
		else
			self.objName = name;
		end
	end
end
function UiBigCard:GetObjName()
	return self.name
end
-- 设置点击回调
function UiBigCard:SetCallback(func)
	self.externalCall = func;
end
function UiBigCard:SetParam(param)
	self.callParam = param;
end
function UiBigCard:GetParam()
	return self.callParam;
end

function UiBigCard:EnableClick(bool)
	self.enableClick = bool
	if self.btn then
		if self.enableClick then
			self.btn:get_game_object():set_collider_enable(true)
		else
			self.btn:get_game_object():set_collider_enable(false)
		end
	end
end


function UiBigCard:Show()
	self.isShow = true
	if (self.ui ~= nil) then
		self.ui:set_active(true);
	end
end
function UiBigCard:Hide()
	self.isShow = false
	if (self.ui ~= nil) then
		self.ui:set_active(false);
	end
end
---------------------------------------------------
function UiBigCard:Init(data)
	self.res_group = self._className
	data = data or { };
	self:InitData(data)
	self:RegistFunc();
	self:InitUI(data.obj);
end

function UiBigCard:InitData(data)
	self.bindfunc = {};
	self.parent = data.parent;
	self.cardInfo = data.info;				-- 卡牌信息
	self.showCardName = data.showCardName;	-- 是否显示卡片名字
	self.playerName = data.playerName;		-- 玩家名字(仅限于infoType为234有效)
	self.teamType = data.teamType or ENUM.ETeamType.normal; -- 战队类型（用于计算战力）
	self.infoType = data.infoType or 1;		-- 显示类型（1~4个类型）
	self.blood = data.blood;				-- 设置血条（仅限于infoType为1有效）
	self.fightPro = data.fightPro or 0;		-- 显示状态（仅限于infoType为2有效）
	self.camp = data.camp or 1;				-- 设置阵营边框（1蓝2红）
	self.showPro = data.showPro;			-- 是否显示（攻防技）
	self.teamPos = data.teamPos or -1;		-- 设置队伍位置信息（-1无，0队长，123显示123）
	self.enableClick = Utility.get_value(data.enableClick, true);
	self.showAddButton = Utility.get_value(data.showAddButton, true);				--空白是是否显示添加按钮
	self.isGray = Utility.get_value(data.is_gray, false);				--设置灰色
	self.showAptitude = Utility.get_value(data.showAptitude, true);
	self.showStar = Utility.get_value(data.showStar, true);
	self.showLvl = Utility.get_value(data.showLvl, true);
	self.showFight = Utility.get_value(data.showFight, true);
	self.useWhiteName = Utility.get_value(data.useWhiteName, false);

	self.dragInfo = {}
end

function UiBigCard:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, self.on_loaded)
	self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click)

	self.bindfunc["on_drag_start"] = Utility.bind_callback(self, self.on_drag_start)
	self.bindfunc["on_drag_release"] = Utility.bind_callback(self, self.on_drag_release)
    self.bindfunc["on_drag_move"] = Utility.bind_callback(self, self.on_drag_move)
end

function UiBigCard:UnregistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end

function UiBigCard:InitUI(obj)
	if (self.ui == nil) then
		if obj then
			self.ui = obj;
			self:InitBigCardUi(obj);
		else
			self.res = res;
			ResourceLoader.LoadAsset(self.res, self.bindfunc["on_loaded"], self.res_group);
		end
	end
end

function UiBigCard:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.res then
		self.ui = asset_game_object.create(asset_obj);
		self:SetObjName("big_card_ui");
		self:SetParent(self.parent);
		self:SetScale(self.scale);
		if self.point then
			self:SetPosition(self.point.x, self.point.y, self.point.z);
		end
		self:InitBigCardUi(self.ui);

		if self.loadedCallBack then
			Utility.CallFunc(self.loadedCallBack, self.loadedCallParam)
			self.loadedCallBack = nil
			self.loadedCallParam = nil
		end
	end
end

function UiBigCard:InitBigCardUi(obj)
	self.texHead = ngui.find_texture(self.ui,"sp_bk1/texture_huamn");
	self.spFrame = ngui.find_sprite(self.ui,"sp_frame");
	self.spFrame:set_active(false) -- TODO 边框规则待未给出，暂时隐藏
	self.spAdd = ngui.find_sprite(self.ui,"sp_bk1/sp_add_mark");
	self.spPro = ngui.find_sprite(self.ui,"sp_bk1/cont/sp_shuxing");
	self.spLeader = ngui.find_sprite(self.ui,"sp_bk1/cont/sp_duizhang");
	self.spTeamPosNum = ngui.find_sprite(self.ui,"sp_bk1/cont/sp_chuchang");
	
	self.btn = ngui.find_button(self.ui,self.ui:get_name());
    self.btn:set_on_click(self.bindfunc["on_click"]);

    --红点
    self.redpoits = ngui.find_sprite(self.ui,"sp_bk1/cont/sp_point")
    --推荐
    self.spRecommend = ngui.find_sprite(self.ui,"sp_bk1/sp_tuijian")
    self.spRecommend:set_active(false)

	self.cont = {};
	---- 1, --> 普通，燃烧
	local obj = self.ui:get_child_by_name("sp_bk1/cont/content1");
	self.cont[1] = {};
	self.cont[1].root = obj
	self.cont[1].nodeLv = obj:get_child_by_name("sp_level")
	self.cont[1].nodeLv:set_active(self.showLvl)
	self.cont[1].labLv = ngui.find_label(obj,"lab_level");

    self.cont[1].spFight = ngui.find_sprite(obj,"sp_fight");
	self.cont[1].spFight:set_active(self.showFight)

	self.cont[1].txtFight = ngui.find_label(obj, "sp_fight/txt_fight")
	self.cont[1].labFightValue = ngui.find_label(obj,"sp_fight/lab_fight");
	self.cont[1].spAptitude = ngui.find_sprite(obj,"sp_art_font");
    self.cont[1].spAptitude:set_active(self.showAptitude)

	self.cont[1].labName = ngui.find_label(obj,"lab_name");

	local _objStar = obj:get_child_by_name("cont_star")
	_objStar:set_active(self.showStar)
	if self.showStar then
		self.cont[1].star = {};
		for i=1,Const.HERO_MAX_STAR do
			self.cont[1].star[i] = ngui.find_sprite(obj,"cont_star/sp_star"..i);
		end
		self.gridStar = ngui.find_grid(obj, "cont_star")
	end
	-- 2, --> 克隆战
	obj = self.ui:get_child_by_name("sp_bk1/cont/content2");
	self.cont[2] = {};
	self.cont[2].root = obj;
	self.cont[2].labPlayerName = ngui.find_label(obj,"lab");
	self.cont[2].labName = ngui.find_label(obj,"lab_name");
	self.cont[2].labFightPro = ngui.find_label(obj,"sp_white_bk/txt");

	-- 3, --> 只有一个lab的
	obj = self.ui:get_child_by_name("sp_bk1/cont/content3");
	self.cont[3] = {};
	self.cont[3].root = obj;
	self.cont[3].labPlayerName = ngui.find_label(obj,"lab_name");
	self.cont[3].nodeMatching = obj:get_child_by_name("sp_arrosw");

	-- 4, --> 自己
	obj = self.ui:get_child_by_name("sp_bk1/cont/content4");
	self.cont[4] = {};
	self.cont[4].root = obj;
	
	self:UpdateUi();
end

function UiBigCard:UpdateUi()
	if not self.ui then return end;

	self:SetTeamPos(self.teamPos);
	self:SetPlayerName(self.playerName);
	-- self:SetCamp(self.camp);
	self:SetGray(self.isGray);

	if self.cardInfo then
		self:SetProType(self.showPro);
		self:NeedShowCardName(self.showCardName);
		self:SetCont(self.infoType);
		self.texHead:set_texture(self.cardInfo.config.icon300)
		PublicFunc.SetProTypeFont(self.spPro, self.cardInfo.pro_type);
        self.cont[1].labLv:set_text(string.format(_UIText[1], self.cardInfo.level))
		self.cont[1].labFightValue:set_text('[FCD901]' .. tostring(self.cardInfo:GetFightValue(--[[self.teamType]])) .. '[-]');
        if self.showAptitude then
		    PublicFunc.SetAptitudeSprite(self.cont[1].spAptitude,self.cardInfo.config.aptitude, true);
        end
		if self.showStar then
			for i=1,Const.HERO_MAX_STAR do
				if i <= self.cardInfo.rarity then
					self.cont[1].star[i]:set_active(true);
				else
					self.cont[1].star[i]:set_active(false);
				end
			end
			self.gridStar:reposition_now()
		end
		self.spAdd:set_active(false);
	else
		self.spPro:set_active(false);
		if self.infoType == 3 then
			self:SetCont(3);
		else
			self:SetCont(0);
		end
		self.texHead:set_texture(default_texture);
		self.spAdd:set_active(self.showAddButton);
	end

	if self.infoType == 1 then
		self:SetBloodPro(self.blood);
		
	elseif self.infoType == 2 then
		self:SetFightPro(self.fightPro);

	elseif self.infoType == 3 then
		if not self.cardInfo then
			self.spAdd:set_active(false);
		end     
	end
        
	self:EnableClick(self.enableClick)
end

function UiBigCard:SetRecommend(isShow)
    if self.spRecommend then
        self.spRecommend:set_active(isShow)
    end
end

function UiBigCard:SetCont(index)
	for i=1,4 do
		if i == index then
			self.cont[i].root:set_active(true);
		else
			self.cont[i].root:set_active(false);
		end
	end
end

--规则不一致，设置图片名字
function UiBigCard:SetFrameSpName(name)
	if self.spFrame and name then
		self.spFrame:set_sprite_name(name)
		self.spFrame:set_active(true)
	end
end

function UiBigCard:HideContent1SomeUi(isShow)
    if self.cont[1] == nil then
        return
    end
	self.cont[1].nodeLv:set_active(isShow)
	self.cont[1].spFight:set_active(isShow)
	--self.cont[1].labName:set_active(isShow)
end

function UiBigCard:DestroyUi()
	if self.ui then
		self.ui:set_active(false);
		self.ui = nil;
	end
	self:UnregistFunc();
	PublicFunc.ClearUserDataRef(self, 1)
end

function UiBigCard:on_click(t)
	if self.externalCall then
		Utility.CallFunc(self.externalCall, self, self.cardInfo, self.callParam);
	end
end

-----------------------------------------------

function UiBigCard:SetName(name)
	if self.ui and self.btn then
		self.btn:set_name(tostring(name))
	end
end

function UiBigCard:SetDragClone(value)
	if self.ui and self.btn then
		self.btn:set_is_dragdrop_clone(value)
	end
end

function UiBigCard:SetHideClone(value)
	if self.ui and self.btn then
		self.btn:set_is_hide_clone(value)
	end
end

function UiBigCard:SetDragStart(func)
	self.dragInfo.callbackStart = func;
	if self.ui and func then
		self.btn:set_on_dragdrop_start(self.bindfunc["on_drag_start"]);
	end
end

function UiBigCard:SetDragRelease(func)
	self.dragInfo.callbackRelease = func;
	if self.ui and func then
		self.btn:set_on_dragdrop_release(self.bindfunc["on_drag_release"]);
	end
end

function UiBigCard:SetDragMove(func)
    self.dragInfo.callbackMove = func;
    if self.ui and func then
        self.btn:set_on_ngui_drag_move(self.bindfunc["on_drag_move"]);
    end
end

-----------------------------------------------------------------------

function UiBigCard:on_drag_start(src)
	if self.dragInfo.callbackStart then
		Utility.CallFunc(self.dragInfo.callbackStart, src);
	end
end

function UiBigCard:on_drag_release(src, tar)
	if self.dragInfo.callbackRelease then
		Utility.CallFunc(self.dragInfo.callbackRelease, src, tar);
	end
end

function UiBigCard:on_drag_move(name, x, y, goObj)
    if self.dragInfo.callbackMove then
        Utility.CallFunc(self.dragInfo.callbackMove, name, x, y, goObj);
    end
end
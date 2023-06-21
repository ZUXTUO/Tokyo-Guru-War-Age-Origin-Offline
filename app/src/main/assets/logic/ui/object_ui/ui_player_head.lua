UiPlayerHead = Class("UiPlayerHead")

local _pathRes = "assetbundles/prefabs/ui/public/sp_head_di_item.assetbundle"
local default_head_name = "assetbundles/prefabs/ui/image/icon/head_pic/90_90/wenhao_y.assetbundle"

--[[ 初始数据格式
	{
		parent = 父节点对象（必要参数）
		roleId = 角色Id（可选参数）
		icon = 头像路径（可选参数）
		vip = vip等级（可选参数）

		-- bg = 背景样式（暂无）
		-- border = 边框样式（暂无）
	}
--]]
function UiPlayerHead:InitData(data)
	self.ui = nil
	self.bindfunc = {}

	self.data = data or {}
	self.parent = data.parent
	self._showed = true
end

function UiPlayerHead:Init(data)
	self:InitData(data)
	self:RegistFunc()
	self:LoadUI()
end

function UiPlayerHead:RegistFunc()
	self.bindfunc["on_loaded"] = Utility.bind_callback(self, UiPlayerHead.on_loaded)
	self.bindfunc["on_click"] = Utility.bind_callback(self, UiPlayerHead.on_click)
	self.bindfunc["on_press"] = Utility.bind_callback(self, UiPlayerHead.on_press)
end

function UiPlayerHead:UnRegistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end

function UiPlayerHead:LoadUI()
	ResourceLoader.LoadAsset(_pathRes, self.bindfunc["on_loaded"], self._className)
end

function UiPlayerHead:SetParent(parent)
	self.ui:set_parent(parent)
	self.ui:set_local_scale(1, 1, 1)
	self.ui:set_local_position(0, 0, 0)
end 

function UiPlayerHead:InitUI(asset_obj)
	self.ui = asset_game_object.create(asset_obj)
	if self.parent then
		self.ui:set_parent(self.parent)
	end
	self.ui:set_name("ui_player_head")
	self.ui:set_local_scale(1, 1, 1)
	self.ui:set_local_position(0, 0, 0)
	if self.data.initPos then 
		self.ui:set_local_position(self.data.initPos[1],self.data.initPos[2],self.data.initPos[3])
	end 
	-- self.headBg = ngui.find_sprite(self.ui, "sp_head_di")
	self.headIcon = ngui.find_texture(self.ui, "texture_human")
	self.headBorder = ngui.find_sprite(self.ui, "sp_frame")
	self.vipFrame = ngui.find_sprite(self.ui,"sp_effect_frame");
	-- self.speHeadBorder = ngui.find_sprite(self.ui, "sp_fuzion_frame")
	self.spVipBg = ngui.find_sprite(self.ui, "sp_vip_di")
	self.labVip = ngui.find_label(self.ui, "sp_vip")

	self.btn = ngui.find_button(self.ui,"ui_player_head");
	self.btn:set_on_ngui_click(self.bindfunc["on_click"])
	self.ui:set_active(self._showed)

	self:SetInitData(self.data);
end

function UiPlayerHead:SetInitData(data)
	if data.roleId then
		if data.roleId == 0 then 
			self._icon = default_head_name;
		else 
			local config = ConfigHelper.GetRole(data.roleId);
			if config == nil then 
				local cfg = ConfigManager.Get(EConfigIndex.t_vip_role_model_anima, data.roleId);
				if cfg ~= nil and cfg[1] ~= nil then 
					self._icon = cfg[1].small_icon;
				else 
					app.log("roldId : "..tostring(data.roleId).."头像配置找不到");
					self._icon = default_head_name;
				end
			else 
				self._icon = config.icon90
			end 
		end 
	end
	self.data = data;
	self._vip = data.vip or 0;
	self._vipstar = data.vipstar or 0;
	self._icon = self._icon or data.icon or default_head_name
	-- self._bg = self._bg or data.bg
	-- self._border = self._border or data.border
	self._showSpeBorder = Utility.get_value(self._showSpeBorder or data.showSpeBorder, false)
	self._showBorder = Utility.get_value(self._showBorder or data.showBorder, true)
	self:UpdateUi()
end

function UiPlayerHead:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == _pathRes then
		self:InitUI(asset_obj)
	end
end

function UiPlayerHead:UpdateUi()
	if not self.ui then return end

	-- 设置头像
	self:SetHeadIcon(self._icon)
	-- 设置背景样式
	-- self:SetHeadBg(self._bg)
	-- 设置外框样式
	-- self:SetHeadBorder(self._border)
	-- 设置外框
	self:ShowHeadBorder(self._showBorder)
	-- 设置大乱斗特殊外框
	self:ShowSpeHeadBorder(self._showSpeBorder)
	-- 设置vip
	self:SetVipLevel(self._vip,self._vipstar)

	if self._gray ~= nil then
		self:SetGray(self._gray)
	end
end

function UiPlayerHead:SetRoleId(roleId)
	if roleId == 0 then 
		self:SetHeadIcon(default_head_name)
	else 
		local config = ConfigHelper.GetRole(roleId)
		if config == nil then 
			local cfg = ConfigManager.Get(EConfigIndex.t_vip_role_model_anima, roleId);
			if cfg ~= nil and cfg[1] ~= nil then 
				self:SetHeadIcon(cfg[1].small_icon);
			else 
				app.log("roleId:"..tostring(roleId).."头像找不到");		
			end 
		else
			if type(config.icon90) ~= "string" then
				app.log("icon error, roleid="..tostring(roleId).." "..debug.traceback())
			end
			self:SetHeadIcon(config.icon90)
		end 
	end 
end

function UiPlayerHead:SetVipLevel(vipLv)
	self._vip = vipLv or 0
	--if self.spVipBg and self.labVip then
	if self.vipFrame then 
		if self._vip > 0 then 
			self.vipFrame:set_active(true);
			local vipdata = g_dataCenter.player:GetVipDataByLevel( self._vip)
			if vipdata then
				self.vipFrame:set_sprite_name(vipdata.head_frame);
			end
		else
			self.vipFrame:set_active(false);
		end
	end 

	if self.spVipBg then
		self.spVipBg:set_active(false);
	end	
	if self.labVip then
		self.labVip:set_active(false)
	end
		--[[if self._vip > 0 then
			self.spVipBg:set_active(true)
			PublicFunc.SetImageVipLevel(self.labVip, self._vip)
		else
			self.spVipBg:set_active(false)
			self.labVip:set_active(false)
		end--]]
	--end
end

function UiPlayerHead:SetHeadIcon(icon)
	self._icon = icon
	
	if not self.headIcon then return end

	-- 英雄头像
	self.headIcon:set_texture(self._icon)
end

-- function UiPlayerHead:SetHeadBg(bg)
-- 	self._bg = bg
-- 	if not self.headBg then return end
-- 	-- TODO 暂无背景图需求
-- end

-- function UiPlayerHead:SetHeadBorder(border)
-- 	self._border = border
-- 	if not self.headBorder then return end
-- 	-- TODO 暂无外框样式需求
-- end

function UiPlayerHead:ShowHeadBorder(bool)
	self._showBorder = Utility.get_value(bool, false)
	if self.headBorder then
		self.headBorder:set_active(self._showBorder)
	end
end

--大乱斗调用接口（显示特殊头像框）
function UiPlayerHead:ShowSpeHeadBorder(bool)
	self._showSpeBorder = Utility.get_value(bool, false)
	-- if self.speHeadBorder then
	-- 	self.speHeadBorder:set_active(self._showSpeBorder)
	-- end
end

function UiPlayerHead:SetGray(gray)
	if self.ui then
		if gray then
			PublicFunc.SetUISpriteGray(self.headIcon)
			-- PublicFunc.SetUISpriteGray(self.headBg)
			PublicFunc.SetUISpriteGray(self.headBorder)
		else
			PublicFunc.SetUISpriteWhite(self.headIcon)
			-- PublicFunc.SetUISpriteWhite(self.headBg)
			PublicFunc.SetUISpriteWhite(self.headBorder)
		end
		self._gray = nil
	else
		self._gray = gray
	end
end

function UiPlayerHead:SetCallback(func, param)
	self.callback = func
	self.callparam = param
end

function UiPlayerHead:SetPressCall(func,paramObj)
	self.pressCall = func;
	self.pressParamObj = paramObj;
	if self.btn and func then
		self.btn:set_on_ngui_press(self.bindfunc["on_press"]);
	end
end 

function UiPlayerHead:on_click()
	if self.callback then
		Utility.CallFunc(self.callback, self.callparam)
	end
end

function UiPlayerHead:on_press(name,state,x,y,go_obj)
	if self.pressCall then 
		Utility.CallFunc(self.pressCall,self.pressParamObj:get_name(),state,x, y, self.pressParamObj);
	end
end 

function UiPlayerHead:Show()
	self._showed = true
	if (self.ui ~= nil) then
		self.ui:set_active(true);
	end
end

function UiPlayerHead:Hide()
	self._showed = false
	if (self.ui ~= nil) then
		self.ui:set_active(false);
	end
end

function UiPlayerHead:DestroyUi()
	self:UnRegistFunc();
	if self.ui then
		self.ui:set_active(false)
		self.ui:set_parent(nil)
		self.ui = nil
	end

	if self.headIcon then
		self.headIcon:Destroy()
		self.headIcon = nil
	end

	self.data = nil
	self.callback = nil
	self.callparam = nil
end

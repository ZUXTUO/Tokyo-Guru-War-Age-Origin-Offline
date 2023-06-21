--region guild_set_icon_ui.lua
--author : zzc
--date   : 2016/07/20

-- 徽章选择界面
GuildSetIconUI = Class('GuildSetIconUI', UiBaseClass)

local _ICON_COL_NUM = 5

-------------------------------------类方法-------------------------------------
function GuildSetIconUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/ui_2803_guild_icon.assetbundle"
	UiBaseClass.Init(self, data);
end

function GuildSetIconUI:Restart(data)
	if data then
		self.selectIcon = data.iconIndex or 0
		self.callback = data.callback
	end
    UiBaseClass.Restart(self, data)
end

function GuildSetIconUI:InitData(data)
	UiBaseClass.InitData(self, data);
	self.selectIcon = 0
end

function GuildSetIconUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	
	self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
	self.bindfunc["on_item_click"] = Utility.bind_callback(self, self.on_item_click)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
end

function GuildSetIconUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_icon");

	self.itemGroups = {}

	local mask = self.ui:get_child_by_name("ui_guild_icon/sp_mark")
	mask:set_on_click(self.bindfunc["on_btn_close"])

	local path = "centre_other/animation/"
	------------------------------ 设置信息 -----------------------------
	local btnClose = ngui.find_button(self.ui, "btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])
	self.svIcon = ngui.find_scroll_view(self.ui, path.."panel_window")
	self.wcIcon = ngui.find_wrap_content(self.ui, path.."panel_window/wrap_cont")
	self.wcIcon:set_on_initialize_item(self.bindfunc["on_init_item"])
	
	local totalCnt = ConfigManager.GetDataCount(EConfigIndex.t_guild_icon)
	self.wcIcon:set_min_index(1 - math.ceil(totalCnt/_ICON_COL_NUM))
    self.wcIcon:set_max_index(0);
	self.wcIcon:reset();
end

function GuildSetIconUI:DestroyUi()
	self.selectIcon = 0
	self.callback = nil
	-- 释放texture
	if self.itemGroups then
		for i, v in pairs(self.itemGroups) do
			for j, item in pairs(v) do
				item.icon:Destroy()
			end
		end
		self.itemGroups = nil
	end

	UiBaseClass.DestroyUi(self);
end

function GuildSetIconUI:LoadItemIcon(item, index)
	local config = ConfigManager.Get(EConfigIndex.t_guild_icon, index)
	if config then
		item.self:set_active(true)
		item.icon:set_active(true)
		item.icon:set_texture(config.icon)
		-- item.select:set_active(self.selectIcon == index)
		item.btn:set_on_click(self.bindfunc["on_item_click"])
		item.btn:set_event_value("", index)
	else
		item.self:set_active(false)
		item.icon:set_active(false)
		-- item.select:set_active(false)
		item.btn:reset_on_click()
	end
end

-------------------------------------本地回调-------------------------------------
function GuildSetIconUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1

	local itemGroup = self.itemGroups[b]
    if not itemGroup then
		itemGroup = {}
		for i=1, _ICON_COL_NUM do
			local objItem =  obj:get_child_by_name("frame"..i)
			itemGroup[i] = {}
			itemGroup[i].self = objItem
			itemGroup[i].btn = ngui.find_button(objItem, objItem:get_name())
			itemGroup[i].icon = ngui.find_texture(objItem, "texture")
			-- itemGroup[i].select = ngui.find_sprite(objItem, "sp_shine")
		end
		self.itemGroups[b] = itemGroup
	end

	for i=1, _ICON_COL_NUM do
		local itemIndex = (index - 1) * _ICON_COL_NUM + i
		self:LoadItemIcon(itemGroup[i], itemIndex)
	end
end

-- 选中某项
function GuildSetIconUI:on_item_click(t)
	local index = t.float_value
	if self.callback then
		Utility.CallFunc(self.callback, index)
		self.callback = nil
	end
	uiManager:PopUi()
end

function GuildSetIconUI:on_btn_close()
	uiManager:PopUi()
end

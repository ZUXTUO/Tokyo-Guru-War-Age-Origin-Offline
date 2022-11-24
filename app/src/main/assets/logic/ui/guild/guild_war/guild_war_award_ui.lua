
GuildWarAwardUI = Class('GuildWarAwardUI', UiBaseClass)

GuildWarAwardUI.Data = nil

function GuildWarAwardUI.Start()
	if GuildWarAwardUI.cls == nil then
		GuildWarAwardUI.cls = GuildWarAwardUI:new()
	end
end

function GuildWarAwardUI.End()
	if GuildWarAwardUI.cls then
		GuildWarAwardUI.cls:DestroyUi()
		GuildWarAwardUI.cls = nil
	end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
	["rank"] = "社团战第%s名",
	[2] = "第%s名",
	[3] = "社团当前段位:",
	[4] = "社团当前排名:",
	[5] = "每日 21:00 通过邮件发送奖励",
	[6] = "未参战",
	[7] = "第%s赛季 社团奖励",
}

function GuildWarAwardUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3804_guild_war_award.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarAwardUI:InitData(data)
	self.wrapItem = { }
	self.gc = g_dataCenter.guildWar
	self.cfg_data = {
		dan = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_dan),
		dan_awards = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_dan_awards),
		daily_awards = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_daily_awards)
	}
	-- local dan_awards = {}
	-- local index = 1
	-- for k,v in pairs(self.cfg_data.dan_awards) do
	-- 	v.index = index
	-- 	table.insert(dan_awards,v)
	-- 	index = index + 1
	-- end
	-- self.cfg_data.dan_awards = dan_awards
	--app.log("GuildWarAwardUI:InitData:" .. table.tostring(self.cfg_data))
	-- 1段位奖励 2每日奖励
	self.selected_type = 1

	UiBaseClass.InitData(self, data)
end

 

function GuildWarAwardUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_yeka"] = Utility.bind_callback(self, self.on_yeka)
	self.bindfunc["on_item_clicked"] = Utility.bind_callback(self,self.on_item_clicked)

	self.bindfunc["on_init_item_dan"] = Utility.bind_callback(self, self.on_init_item_dan)
	self.bindfunc["on_init_item_daily"] = Utility.bind_callback(self, self.on_init_item_daily)
	self.bindfunc["gc_awards"]=  Utility.bind_callback(self,self.gc_awards)
end

function GuildWarAwardUI:on_btn_close()
	GuildWarAwardUI.End()
end

function GuildWarAwardUI:on_item_clicked(t)
	local dan_id = t.float_value
	local awards_id = GuildWarAwardUI.Data.danAwardsId
	 
	self.rank_detail_cls = GuildWarRankDetail:new({awards_id=awards_id,dan_id=dan_id}) 
end


function GuildWarAwardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_award")

	local path = "centre_other/animation/"

	local btnClose = ngui.find_button(self.ui, path .. "btn_close")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	self.sp_rank_icon = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_ico")
	self.lbl_rank = ngui.find_label(self.ui,"centre_other/animation/cont1/lbl_v")

	self.ui_data = {
		dan = { },
		daily = { },
	}

	self.lbl_curr_tit = ngui.find_label(self.ui,path.."cont1/lbl_t")
	self.lbl_award_time = ngui.find_label(self.ui,path.."cont1/lbl_t2")
	self.lbl_title = ngui.find_label(self.ui,path.."cont_Bg/lbl_title")
	local season_data = self.gc:GetSeasonInfo()
	if eason_data then
		self.lbl_title:set_text(string.format(_UIText[7],eason_data.season))		
	else
		self.lbl_title:set_text("")		
	end
	self.lbl_award_time:set_text(_UIText[5])
	self.ui_data.dan.scrollView = ngui.find_scroll_view(self.ui, path .. "cont_objs/obj1/scroll_view")
	self.ui_data.dan.wrapContent = ngui.find_wrap_content(self.ui, path .. "cont_objs/obj1/scroll_view/wrap_content")
	self.ui_data.dan.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item_dan"])
	self.ui_data.dan.wrapContent:set_max_index(0)
	self.ui_data.dan.wrapItem = self.ui:get_child_by_name(path .. "cont_objs/obj1/scroll_view/wrap_content/item")


	self.ui_data.daily.scrollView = ngui.find_scroll_view(self.ui, path .. "cont_objs/obj2/scroll_view")
	self.ui_data.daily.wrapContent = ngui.find_wrap_content(self.ui, path .. "cont_objs/obj2/scroll_view/wrap_content")
	self.ui_data.daily.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item_daily"])
	self.ui_data.daily.wrapContent:set_max_index(0)
	self.ui_data.daily.wrapItem = self.ui:get_child_by_name(path .. "cont_objs/obj1/scroll_view/wrap_content/item")

	for i = 1, 2 do
		local toggle = ngui.find_toggle(self.ui, path .. "cont_toggles/toggle" .. i)
		toggle:set_on_change(self.bindfunc["on_yeka"])
	end
end

function GuildWarAwardUI:on_yeka(value, name)
	if value then
		if name == "toggle1" then
			self.selected_type = 1
			
		else
			self.selected_type = 2
			
		end
		self:UpdateUi()
	end
end

function GuildWarAwardUI:UpdateDanAward()
	app.log("UpdateDanAward")
	self.lbl_curr_tit:set_text(_UIText[3])
	if GuildWarAwardUI.Data  == nil then
		msg_guild_war.cg_awards()
	else
		self.dan_awards_data = self:GetDanAwards(GuildWarAwardUI.Data.danAwardsId)
		--app.log("dan_awards_data "..tostring(table.get_num(self.dan_awards_data))..table.tostring(self.dan_awards_data))
		self.ui_data.dan.wrapContent:set_min_index(-(table.get_num(self.dan_awards_data)) + 1)
		self.ui_data.dan.wrapContent:reset()
		self.ui_data.dan.scrollView:reset_position()

	    dan_data =self:GetDanRowData(GuildWarAwardUI.Data.integeral)

		--dan_data = self:GetDanRowData(500)
		--app.log("dan_data："..table.tostring(dan_data))
		if dan_data then
			self.sp_rank_icon:set_sprite_name(dan_data.icon)
			if GuildWarAwardUI.Data.integeralRank ~= -1 then
				self.lbl_rank:set_text(dan_data.name.." "..string.format(_UIText[2],GuildWarAwardUI.Data.integeralRank))
			else
				self.lbl_rank:set_text(dan_data.name)
			end
		end
	end

end

function GuildWarAwardUI:UpdateDailyAward()
	--app.log("UpdateDailyAward")
	self.lbl_curr_tit:set_text(_UIText[4])
	self.ui_data.daily.wrapContent:set_min_index(-(table.get_num(self.cfg_data.daily_awards)) + 1)
	self.ui_data.daily.wrapContent:reset()
	self.ui_data.daily.scrollView:reset_position()
	if GuildWarAwardUI.Data then
		self.sp_rank_icon:set_sprite_name("")
		if GuildWarAwardUI.Data.dailyRank == -1 then
			self.lbl_rank:set_text(_UIText[6])
		else
			self.lbl_rank:set_text(string.format(_UIText[2],GuildWarAwardUI.Data.dailyRank))
		end
	end
end

function GuildWarAwardUI:UpdateUi()
	local dan_data = {}
	if self.selected_type  == 1 then		 
		self:UpdateDanAward()	
	else
		self:UpdateDailyAward()	
	end
end

function GuildWarAwardUI:on_init_item_dan(obj, b, real_id)
	local index = math.abs(b)
	local row =  math.abs(real_id) + 1--math.abs(b) + 1
	local data = self.dan_awards_data[row]

	if nil == self.wrapItem[self.selected_type] then
		self.wrapItem[self.selected_type] = { }
	end
	local item = self.wrapItem[self.selected_type][index]

	if nil == item then
		item = { }
		item.sp_rank_icon = ngui.find_sprite(obj, "cont1/sp_rank_icon")
		item.lbl_rank = ngui.find_label(obj, "cont2/lbl_rank")
		item.button = ngui.find_button(obj,"sp_bg")
		item.button:reset_on_click()
		item.button:set_on_click(self.bindfunc["on_item_clicked"])		 
		item.item_objs = { }
		item.smallItems = { }
		for i = 1, 5 do
			item.item_objs[i] = obj:get_child_by_name("cont3/new_small_card_item" .. i)
		end
		self.wrapItem[self.selected_type][index] = item
	end
	item.button:set_event_value("",data.dan_id)
	--app.log(" dan.dan_id ="..tostring(data.dan_id))
	local dan_data = ConfigManager.Get(EConfigIndex.t_guild_war_dan, data.dan_id)
	item.sp_rank_icon:set_sprite_name(dan_data.icon)
	item.lbl_rank:set_text(dan_data.name)
	local awards = data.awards
	for i = 1, 5 do
		local c_data = awards[i]
		if c_data then
			if not item.smallItems[i] then
				item.smallItems[i] = UiSmallItem:new( { parent = item.item_objs[i] ,prop = {show_number=false}})
			end
			item.smallItems[i]:SetDataNumber(c_data.id)
		end
	end
end


function GuildWarAwardUI:on_init_item_daily(obj, b, real_id)
	local index = math.abs(real_id)
	local row = math.abs(b) + 1
	local data = self.cfg_data.daily_awards[row]

	if nil == self.wrapItem[self.selected_type] then
		self.wrapItem[self.selected_type] = { }
	end
	local item = self.wrapItem[self.selected_type][index]


	if nil == item then
		item = { }
		item.sp_rank_icon = ngui.find_sprite(obj, "cont1/sp_rank_icon")
		item.lbl_rank = ngui.find_label(obj, "cont2/lbl_rank")
		item.item_objs = { }
		item.smallItems = { }
		for i = 1, 4 do
			item.item_objs[i] = obj:get_child_by_name("cont3/new_small_card_item" .. i)
		end
		self.wrapItem[self.selected_type][index] = item
	end 
	PublicFunc.SetRank123Sprite(item.sp_rank_icon, row) 
	item.lbl_rank:set_text(string.format(_UIText.rank,tostring(row)))
	local awards = data.awards
	for i = 1, 4 do
		local c_data = nil
		
		if i < 4 then
			c_data = awards[i]
		else
			c_data = data.awards_ex
		end

		if c_data then
			if not item.smallItem then
				item.smallItems[i] = UiSmallItem:new( { parent = item.item_objs[i] })
			end
			item.smallItems[i]:SetDataNumber(c_data.id, c_data.count)
		end
	end
end

function GuildWarAwardUI:DestroyUi()
	for k,v in pairs(self.wrapItem) do
		if k and v then
			for k1,v1 in pairs(v) do
				if v1 and v1.item and v1.item.smallItems then
					for k2,v2 in pairs(v1.item.smallItems) do
						v2:DestroyUi()
					end
				end
			end
		end
	end

	self.wrapItem = {}
	self.rank_detail_cls = nil
	GuildWarAwardUI.Data = nil
	UiBaseClass.DestroyUi(self)
end

function GuildWarAwardUI:MsgRegist()
    PublicFunc.msg_regist(msg_guild_war.gc_awards, self.bindfunc['gc_awards'])
end

function GuildWarAwardUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_guild_war.gc_awards, self.bindfunc['gc_awards'])
end

function GuildWarAwardUI:gc_awards(info)
	--app.log("GuildWarAwardUI:gc_awards:"..table.tostring(info))
	GuildWarAwardUI.Data = info
	self:UpdateUi()
end

function GuildWarAwardUI:GetDanAwards(danAwardsId)
	if not danAwardsId then return nil end	
	local result = {}
	local data = self.cfg_data.dan_awards
	if data then
		local dan_data = data[danAwardsId]
		if dan_data then
			local tempIds = {}
			for k,v in pairs(dan_data) do
				if tempIds[v.dan_id] == nil then 
					table.insert(result,v)
					tempIds[v.dan_id] = 1
				end
			end
		end
	end

	--app.log("GuildWarAwardUI:GetDanAwards "..table.tostring(result))
	return result
end

function GuildWarAwardUI:GetDanRowData(integeral)
	if integeral then
		for k,v in pairs(self.cfg_data.dan) do
			if integeral >= v.start_integral and integeral <= v.end_integral then
				return v
			end
		end
	end
	return nil	 
end
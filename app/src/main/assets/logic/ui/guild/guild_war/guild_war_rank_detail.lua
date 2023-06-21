GuildWarRankDetail = Class("GuildWarRankDetail",UiBaseClass)
 
 
---------------------------------------华丽的分隔线--------------------------------------

local _UiText = {
	[1] = "%s~%s名",
	[2] = "%s及以下"
}
 

function GuildWarRankDetail:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3811_guild_war_rank.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarRankDetail:InitData(data)
	self.awards_id = data.awards_id
	self.dan_id = data.dan_id
	self.data = {}
	self.wrapItem = { }

	self.cfg_data = {
		dan = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_dan),
		dan_awards = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_dan_awards),
		daily_awards = ConfigManager._GetConfigTable(EConfigIndex.t_guild_war_daily_awards)
	}
	self:_SetData()
	-- local dan_awards = {}
	-- local index = 1
	-- for k,v in pairs(self.cfg_data.dan_awards) do
	-- 	v.index = index
	-- 	table.insert(dan_awards,v)
	-- 	index = index + 1
	-- end
	-- self.cfg_data.dan_awards = dan_awards
	-- 1段位奖励 2每日奖励

	UiBaseClass.InitData(self, data)
end

function GuildWarRankDetail:_SetData()
	self.data = {}
	if self.dan_id and self.awards_id then
		local dan_data = self.cfg_data.dan_awards[self.awards_id]
		if dan_data then
			for k,v in spairs(dan_data,
				function(t,a,b)
					if t and t[a] and t[b] then
						return t[b].show_id >= t[a].show_id
					else
						return false
					end
				end) 
		    do
				if v.dan_id == self.dan_id then
					table.insert(self.data,v)
				end
			end
		else
			app.log("not found dan data")
		end
	end
end

function GuildWarRankDetail:DestroyUi()
	UiBaseClass.DestroyUi(self)
end

function GuildWarRankDetail:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item)
 
end

function GuildWarRankDetail:on_btn_close()
	self:DestroyUi()
end

function GuildWarRankDetail:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_rank_detail")
 
	local btnClose = ngui.find_button(self.ui, "centre_other/animation/btn_cha")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])
 
 

	self.scrollView = ngui.find_scroll_view(self.ui, "centre_other/animation/scroll_view/panel_list")
	self.wrapContent = ngui.find_wrap_content(self.ui, "centre_other/animation/scroll_view/panel_list/wrap_cont")
	self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])
	self:UpdateUi()
end


function GuildWarRankDetail:SetData(awardsId,dan_id)
	self.awards_id = awardsId
	self.dan_id = dan_id
	self:_SetData()
end

 

function GuildWarRankDetail:UpdateUi()
 	self.wrapContent:set_max_index(0)
	self.wrapContent:set_min_index(-table.getn(self.data)+1)
	self.wrapContent:reset()
end

function GuildWarRankDetail:on_init_item(obj, b, real_id)
	local index = math.abs(real_id)
	local row = math.abs(b) + 1
	
	local item = self.wrapItem[row]

	if nil == item then
		item = { }
		item.sp_rank_icon = ngui.find_sprite(obj, "sp_rank")
		item.lbl_rank = ngui.find_label(obj, "lab_num")
		item.item_objs = { }
		item.smallItems = { }
		for i = 1, 4 do
			item.item_objs[i] = obj:get_child_by_name("new_small_card_item" .. i)
		end
		self.wrapItem[row] = item
	end

	--local dan_data = ConfigManager.Get(EConfigIndex.t_guild_war_dan, self.dan_id)
	--item.sp_rank_icon:set_sprite_name(dan_data.icon)
	--item.lbl_rank:set_text(dan_data.name)
	--if not dan_data then return end
	
	--app.log("idi"..table.tostring(self.data))
	local data = self.data[row]
	local awards = data.awards
	self:SetRank ( item.sp_rank_icon , item.lbl_rank , data.rank_start , data.rank_end )
	for i = 1, 4 do
		local c_data = awards[i]
		if c_data then
			if not item.smallItem then
				item.smallItems[i] = UiSmallItem:new( { parent = item.item_objs[i] })
			end
			item.smallItems[i]:SetDataNumber(c_data.id, c_data.count)
		end
	end
end

function GuildWarRankDetail:SetRank(sp,lbl,rank_start,rank_end)
	if rank_start == rank_end and rank_start <= 3 then
		lbl:set_active(false)
		sp:set_active(true)
		sp:set_sprite_name("sjboss_paiming"..tostring(rank_start))
	else
		lbl:set_active(true)
		sp:set_active(false)
		 
		if rank_end == 0 then
			lbl:set_text(string.format(_UiText[2],rank_start))
		else
			lbl:set_text(string.format(_UiText[1],rank_start,rank_end))
		end
		
	end
end
 
function GuildWarRankDetail:DestroyUi()
	if self.wrapItem then
		for k,v in pairs(self.wrapItem) do
			if v.item and v.item.smallItems then
				for k1, v1 in pairs(v.item.smallItems) do
					v161:DestroyUi()
				end
			end
		end
	end
	self.wrapItem = {}
	UiBaseClass.DestroyUi(self)
end
 
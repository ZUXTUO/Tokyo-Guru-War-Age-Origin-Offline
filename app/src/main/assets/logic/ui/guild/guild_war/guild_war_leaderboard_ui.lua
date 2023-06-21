
GuildWarLeaderboardUI = Class('GuildWarLeaderboardUI', UiBaseClass)
GuildWarLeaderboardUI.RankData = { }
local rankListType = MsgEnum.ERankingListType
function GuildWarLeaderboardUI.Start()
	if GuildWarLeaderboardUI.cls == nil then
		GuildWarLeaderboardUI.cls = GuildWarLeaderboardUI:new()
	end
end

function GuildWarLeaderboardUI.End()
	if GuildWarLeaderboardUI.cls then
		GuildWarLeaderboardUI.cls:DestroyUi()
		GuildWarLeaderboardUI.cls = nil
	end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
	[1] = "等级：",
	[2] = "社团：",
	[3] = "无",
	[4] = "段位",
	[5] = "赛季积分",
	[6] = "胜利次数",
	[7] = "参与次数"
}

function GuildWarLeaderboardUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3802_guild_war_rank.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarLeaderboardUI:InitData(data)
	self.wrapGuildItem = { }
	self.wrapPersonItem = { }
	UiBaseClass.InitData(self, data)
end

function GuildWarLeaderboardUI:DestroyUi()
	UiBaseClass.DestroyUi(self)
	GuildWarLeaderboardUI.RankData = {}
end

function GuildWarLeaderboardUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
	self.bindfunc["on_btn_show_detail"] = Utility.bind_callback(self, self.on_btn_show_detail)
	self.bindfunc["on_yeka"] = Utility.bind_callback(self, self.on_yeka)

	self.bindfunc["on_init_guild_item"] = Utility.bind_callback(self, self.on_init_guild_item)
	self.bindfunc["on_gc_rank"] = Utility.bind_callback(self, self.on_gc_rank)
end
-- 注册消息分发回调函数
function GuildWarLeaderboardUI:MsgRegist()
	PublicFunc.msg_regist(msg_rank.gc_rank, self.bindfunc["on_gc_rank"])

end

-- 注销消息分发回调函数
function GuildWarLeaderboardUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_rank.gc_rank, self.bindfunc["on_gc_rank"])
end
function GuildWarLeaderboardUI:on_btn_close()
	GuildWarLeaderboardUI.End()
end

function GuildWarLeaderboardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_leaderboard")

	local path = "centre_other/animation/"

	local btnClose = ngui.find_button(self.ui, path .. "btn_close")
	btnClose:set_on_click(self.bindfunc["on_btn_close"])

	-- 左边信息
	self.leftPane = {
		go_head = self.ui:get_child_by_name(path.."texture_di/sp_head_di_item"),
		texture_guild_icon = ngui.find_texture(self.ui,path .. "texture_di/texture_guild"),
		lblGuildName = ngui.find_label(self.ui,path .. "texture_di/lab_guild"),
		lblGuildLevel = ngui.find_label(self.ui,path .. "texture_di/lab_level"),
		lblGuildMasterName = ngui.find_label(self.ui,path .. "texture_di/lab_name"),
	}
	local btnShowDetail = ngui.find_button(self.ui, path .. "texture_di/btn")
	btnShowDetail:set_on_click(self.bindfunc["on_btn_show_detail"])
	self.go_cont = self.ui:get_child_by_name(path.."cont")
	self.sp_cat = ngui.find_sprite(self.ui,path.."sp_cat")

	self.lbl_tit1 = ngui.find_label(self.ui,path.."cont/cont_title/txt3")
	self.lbl_tit2 = ngui.find_label(self.ui,path.."cont/cont_title/txt4")
	self.scrollViewGuild = ngui.find_scroll_view(self.ui, path .. "cont/scroll_view/panel_list")
	self.wrapContentGuild = ngui.find_wrap_content(self.ui, path .. "cont/scroll_view/panel_list/wrap_content")
	self.wrapContentGuild:set_on_initialize_item(self.bindfunc["on_init_guild_item"])
	self.wrapContentGuild:set_max_index(0)

 
	-- tab
	for i = 1, 2 do
		local toggle = ngui.find_toggle(self.ui, path .. "yeka/yeka" .. i)
		toggle:set_on_change(self.bindfunc["on_yeka"])
	end

    self.selfUi = {}
    local obj = self.ui:get_child_by_name("cont/content")
    local item = {}
    item.sp_rank = ngui.find_sprite(obj,"sp_win") 			 --1-3图标
	item.lbl_rank = ngui.find_label(obj,"lab")				 --3-n排名信息
	item.sp_self = ngui.find_sprite(obj,"sp_art_font1")     --自己图标
	item.sp_self:set_active(false)
	item.sp_no_rank = ngui.find_sprite(obj,"sp_art_font2")  --未上榜图标
			
	item.sp_dan = ngui.find_sprite(obj,"sp_grading")         --社团段位
	item.lbl_dan = ngui.find_label(obj,"sp_grading/lab_grading") --社团段位

	item.lbl_score = ngui.find_label(obj,"lab_num")		  -- 参与次数（个人）
	item.lbl_fighting = ngui.find_label(obj,"lab_fighting") --积分

	item.go_container1 = obj:get_child_by_name("container1")
    item.lbl_player_name = ngui.find_label(item.go_container1,"lab_name")
    item.lbl_player_name_ex = ngui.find_label(item.go_container1,"lab_chenghao")
    item.sp_vip = ngui.find_sprite(item.go_container1,"sp_art_font")
    item.lbl_vip = ngui.find_label(item.go_container1,"sp_art_font/lab_num")

    item.go_container2 = obj:get_child_by_name("container2")
    item.texture_guild = ngui.find_texture(item.go_container2,"texture_guild")
    item.lbl_guild_name = ngui.find_label(item.go_container2,"lab_name")
    item.lbl_guild_level = ngui.find_label(item.go_container2,"lab_lv")
    self.selfUi = item

end

function GuildWarLeaderboardUI:on_btn_show_detail(t)
	local data =  self:GetFirstGuildData()
	if data  then
		if self.current_selected_type == rankListType.ERankingListType_GuildWarScore then
			OtherGuildPanel.ShowGuildbyId(data.id,1,data.ranking)
		else
			OtherPlayerPanel.ShowPlayer(data.id,ENUM.ETeamType.normal,nil,false)
		end		
	end
end

function GuildWarLeaderboardUI:on_yeka(value, name)
	if value then
		if name == "yeka1" then
			self:UpdateGuildLeaderboard()
		else
			self:UpdatePersonLeaderboard()
		end
	end
end

--[[ 更新社团排行 ]]
function GuildWarLeaderboardUI:UpdateGuildLeaderboard()
	app.log('UpdateGuildLeaderboard')
	self.current_selected_type = rankListType.ERankingListType_GuildWarScore
	-- 更新自己
	if nil == GuildWarLeaderboardUI.RankData[self.current_selected_type] then
		msg_rank.cg_rank(self.current_selected_type, 10)
	else
		self:_UpdateWrapContent()
		self:UpdateSelfUI(self.current_selected_type)
		self:UpdateFirstUI(self.current_selected_type)
	end
	self:_UpdateLblTitle()
end

--[[ 更新个人排行 ]]
function GuildWarLeaderboardUI:UpdatePersonLeaderboard(nodeId)
	app.log('UpdatePersonLeaderboard')
	self.current_selected_type = rankListType.ERankingListType_GuildWarJoinTimes
	-- 更新自己
	if nil == GuildWarLeaderboardUI.RankData[self.current_selected_type] then
		msg_rank.cg_rank(self.current_selected_type, 10)
	else
		self:_UpdateWrapContent()
		self:UpdateSelfUI(self.current_selected_type)
		self:UpdateFirstUI(self.current_selected_type)
	end
	self:_UpdateLblTitle()
end

function GuildWarLeaderboardUI:_UpdateWrapContent()
	self.scrollViewGuild:reset_position()
	local count = (table.getn(GuildWarLeaderboardUI.RankData[self.current_selected_type].ranklist))
	if count > 0 then
		self.go_cont:set_active(true)
		self.sp_cat:set_active(false)
		self.wrapContentGuild:set_min_index(1 - count)
		self.wrapContentGuild:reset()
	else		
		self.go_cont:set_active(false)
		self.sp_cat:set_active(true)
		self.wrapContentGuild:set_min_index(0)
		self.wrapContentGuild:reset()		
	end
end

function GuildWarLeaderboardUI:_UpdateLblTitle()
	if self.current_selected_type == rankListType.ERankingListType_GuildWarScore then
		self.lbl_tit1:set_text(_UIText[4])
		self.lbl_tit2:set_text(_UIText[5])
	else
		self.lbl_tit1:set_text(_UIText[6])
		self.lbl_tit2:set_text(_UIText[7])
	end
end

function GuildWarLeaderboardUI:SetRank(sp, lbl,sp_no, number)
	if number <= 3 and number > 0 then
		sp_no:set_active(false)
		lbl:set_active(false)
		sp:set_active(true)
		sp:set_sprite_name("phb_paiming" .. tostring(number))
	else
		if number > 100 or number == -1 then
			lbl:set_active(false)
			sp:set_active(false)
			sp_no:set_active(true)
		else
			sp:set_active(false)
			lbl:set_text(tostring(number))
			sp_no:set_active(false)
			lbl:set_active(true)
		end
	end

end
 

function GuildWarLeaderboardUI:on_init_guild_item(obj, b, real_id)
	local row = math.abs(real_id) + 1
	--local row = math.abs(b) + 1
	--app.log("on_init_guild_item "..tostring(row))
	if self.wrapPersonItem[row] == nil then
		local item = { }		
		item.sp_rank = ngui.find_sprite(obj,"sp_win") 			 --1-3图标
		item.lbl_rank = ngui.find_label(obj,"lab")				 --3-n排名信息
		item.sp_self = ngui.find_sprite(obj,"sp_art_font1")     --自己图标
		item.sp_self:set_active(false)
		item.sp_no_rank = ngui.find_sprite(obj,"sp_art_font2")  --未上榜图标
 			
		item.sp_dan = ngui.find_sprite(obj,"sp_grading")         --社团段位
		item.lbl_dan = ngui.find_label(obj,"sp_grading/lab_grading") --社团段位

		item.lbl_score = ngui.find_label(obj,"lab_num")		  -- 参与次数（个人）
		item.lbl_fighting = ngui.find_label(obj,"lab_fighting") --积分

		item.go_container1 = obj:get_child_by_name("container1")
	    item.lbl_player_name = ngui.find_label(item.go_container1,"lab_name")
	    item.lbl_player_name_ex = ngui.find_label(item.go_container1,"lab_chenghao")
	    item.sp_vip = ngui.find_sprite(item.go_container1,"sp_art_font")
	    item.lbl_vip = ngui.find_label(item.go_container1,"sp_art_font/lab_num")

	    item.go_container2 = obj:get_child_by_name("container2")
	    item.texture_guild = ngui.find_texture(item.go_container2,"texture_guild")
	    item.lbl_guild_name = ngui.find_label(item.go_container2,"lab_name")
	    item.lbl_guild_level = ngui.find_label(item.go_container2,"lab_lv")


		self.wrapPersonItem[row] = item
	end

	local item = self.wrapPersonItem[row]
	local eType = self.current_selected_type
	local row_data = GuildWarLeaderboardUI.RankData[eType].ranklist[row]
	if not row_data then return end
 	self:SetRank(item.sp_rank, item.lbl_rank,item.sp_no_rank, row_data.ranking)

 	if eType == rankListType.ERankingListType_GuildWarScore then -- 社团 		
 		item.go_container1:set_active(false) 	
 		item.lbl_score:set_active(false)
 		item.go_container2:set_active(true)
 		item.sp_dan:set_active(true)
 		local dan_data = ConfigManager.Get(EConfigIndex.t_guild_war_dan, row_data.param2)		 
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon, row_data.iconsid[1]).icon;
		item.texture_guild:set_texture(iconPath)
		item.lbl_guild_name:set_text(row_data.name)
		item.lbl_guild_level:set_text("LV."..tostring(row_data.level))
		item.lbl_fighting:set_text(tostring(row_data.ranking_num))

		if dan_data then
			item.sp_dan:set_sprite_name(dan_data.icon)
			item.lbl_dan:set_text(dan_data.name)
		end

			--[[
            id 公会id
            ranking 排名
            ranking_num 积分
            name 名字
            level 等级
            icons 帮派头像
            param2 段位
        ]]

 	else
 		item.go_container2:set_active(false)
 		item.lbl_score:set_active(true)
 		item.go_container1:set_active(true)  		
 		item.sp_dan:set_active(false)

 		--[[
            id 玩家id
            ranking 排名
            ranking_num vip等级
            param2 胜利场次
            param3 参与场次
            name 名字
            level 等级

        ]]
        item.lbl_player_name:set_text(row_data.name)
        item.lbl_player_name_ex:set_text("TODO:称号")
        item.lbl_score:set_text(tostring(row_data.param2))
        item.lbl_fighting:set_text(tostring(row_data.param3))
        item.lbl_vip:set_text(tostring(row_data.ranking_num))
 	end
end


function GuildWarLeaderboardUI:on_gc_rank(rank_type, my_rank, ranklist)
	GuildWarLeaderboardUI.RankData[rank_type] = { my_rank = my_rank, ranklist = ranklist }
	--app.log("xxxxxxxxxxxxx"..table.tostring(GuildWarLeaderboardUI.RankData[rank_type]))
	if rank_type == rankListType.ERankingListType_GuildWarScore then
		self:UpdateGuildLeaderboard()

		--[[
            id 公会id
            ranking 排名
            ranking_num 积分
            name 名字
            level 等级
            icons 帮派头像
            param2 段位
        ]]

	elseif rank_type == rankListType.ERankingListType_GuildWarJoinTimes then
		self:UpdatePersonLeaderboard()
		--[[
            id 玩家id
            ranking 排名
            param2 胜利场次
            param3 参与场次
            name 名字
            level 等级
        ]]
	end
	self:UpdateSelfUI(rank_type)
	--app.log("rankdata " .. table.tostring(GuildWarLeaderboardUI.RankData))
end

function GuildWarLeaderboardUI:GetFirstGuildData()
	local data =  GuildWarLeaderboardUI.RankData[self.current_selected_type]
	if data and data.ranklist then
		data = data.ranklist[1]
	end
	return data
end

function GuildWarLeaderboardUI:UpdateFirstUI() 
	local data = self:GetFirstGuildData() 
	if data then
		
		if self.current_selected_type == rankListType.ERankingListType_GuildWarScore then
			local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon, data.iconsid[1]).icon;
			self.leftPane.go_head:set_active(false)
			self.leftPane.texture_guild_icon:set_active(true)
			self.leftPane.texture_guild_icon:set_texture(iconPath)
		else
			self.leftPane.go_head:set_active(true)
			self.leftPane.texture_guild_icon:set_active(false)
			self.leftPane.head_info = UiPlayerHead:new({parent=self.leftPane.go_head});
			self.leftPane.head_info:SetRoleId(tonumber(data.iconsid[1]));
		end
		 
		self.leftPane.lblGuildName:set_text(_UIText[2]..data.name)
		self.leftPane.lblGuildLevel:set_text(_UIText[1]..tostring(data.level))
		self.leftPane.lblGuildMasterName:set_text(data.addition_name)
	else
		self.leftPane.go_head:set_active(false)
		self.leftPane.texture_guild_icon:set_active(false)
		self.leftPane.lblGuildName:set_text(_UIText[3])
		self.leftPane.lblGuildLevel:set_text(_UIText[3])
		self.leftPane.lblGuildMasterName:set_text(_UIText[3])
	end
end


function GuildWarLeaderboardUI:UpdateSelfUI(eType)
	local item = self.selfUi
	local eType = self.current_selected_type
	local row_data = GuildWarLeaderboardUI.RankData[eType].my_rank
	if not row_data then return end
 	self:SetRank(item.sp_rank, item.lbl_rank,item.sp_no_rank, row_data.ranking)

 	if eType == rankListType.ERankingListType_GuildWarScore then -- 社团 		
 		item.go_container1:set_active(false) 	
 		item.lbl_score:set_active(false)
 		item.go_container2:set_active(true)
 		item.sp_dan:set_active(true)
 		local dan_data = ConfigManager.Get(EConfigIndex.t_guild_war_dan, row_data.param2)		 
		local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon, row_data.iconsid[1]).icon;
		item.texture_guild:set_texture(iconPath)
		item.lbl_guild_name:set_text(row_data.name)
		item.lbl_guild_level:set_text("LV."..tostring(row_data.level))
		item.lbl_fighting:set_text(tostring(row_data.ranking_num))

		if dan_data then
			item.sp_dan:set_sprite_name(dan_data.icon)
			item.lbl_dan:set_text(dan_data.name)
		end
 
 	else
 		item.go_container2:set_active(false)
 		item.lbl_score:set_active(true)
 		item.go_container1:set_active(true)  		
 		item.sp_dan:set_active(false)

 		--未上榜特殊处理
 		if row_data.ranking == -1 then
 			row_data.name = g_dataCenter.player.name
 			row_data.ranking_num = g_dataCenter.player.vip
 		end
  		
        item.lbl_player_name:set_text(row_data.name)
        item.lbl_player_name_ex:set_text("TODO:称号")
        item.lbl_score:set_text(tostring(row_data.param2))
        item.lbl_fighting:set_text(tostring(row_data.param3))
        item.lbl_vip:set_text(tostring(row_data.ranking_num)) 
 	end
end

--[[
region world_treasure_box_main_ui.lua
date: 2016-7-19
time: 11:3:27
author: Nation
]]

WorldTreasureBoxMainUI = Class("WorldTreasureBoxMainUI", UiBaseClass);
local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_box.assetbundle"


function WorldTreasureBoxMainUI.GetResList()
    return {res}
end

function WorldTreasureBoxMainUI:Init(data)
	self.pathRes = res
	UiBaseClass.Init(self, data);
	
end

function WorldTreasureBoxMainUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function WorldTreasureBoxMainUI:Restart(data)
	self:Clear();
	UiBaseClass.Restart(self, data);
end

function WorldTreasureBoxMainUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_open"] = Utility.bind_callback(self, self.on_btn_open);

	self.bindfunc["on_gc_sync_single_player_flag"] = Utility.bind_callback(self, self.on_gc_sync_single_player_flag);
	
	self.bindfunc["gc_trigger_world_item_delay"] = Utility.bind_callback(self, self.gc_trigger_world_item_delay);
	self.bindfunc["gc_break_trigger_world_item_delay"] = Utility.bind_callback(self, self.gc_break_trigger_world_item_delay);
	self.bindfunc["gc_success_trigger_world_delay_item"] = Utility.bind_callback(self, self.gc_success_trigger_world_delay_item);

	self.bindfunc["gc_sync_world_treasure_box_num"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_num);
	self.bindfunc["gc_sync_world_treasure_box_next_step_box_born_cd"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_next_step_box_born_cd);
	self.bindfunc["gc_sync_mysterious_treasure_box_info"] = Utility.bind_callback(self, self.gc_sync_mysterious_treasure_box_info);
	self.bindfunc["gc_sync_world_treasure_box_point_rank"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_point_rank);
	self.bindfunc["gc_sync_world_treasure_box_player_info"] = Utility.bind_callback(self, self.gc_sync_world_treasure_box_player_info);
	self.bindfunc["on_btn_show_rank"] = Utility.bind_callback(self, self.on_btn_show_rank);
	self.bindfunc["btn_goto_mysterious_box"] = Utility.bind_callback(self, self.btn_goto_mysterious_box);
end

function WorldTreasureBoxMainUI:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self)
end

--注册消息分发回调函数
function WorldTreasureBoxMainUI:MsgRegist()
	UiBaseClass.MsgRegist(self)
	PublicFunc.msg_regist(player.gc_sync_single_player_flag, self.bindfunc["on_gc_sync_single_player_flag"])
	
	PublicFunc.msg_regist(msg_fight.gc_trigger_world_item_delay,self.bindfunc["gc_trigger_world_item_delay"]);
	PublicFunc.msg_regist(msg_fight.gc_break_trigger_world_item_delay,self.bindfunc["gc_break_trigger_world_item_delay"]);
	PublicFunc.msg_regist(msg_fight.gc_success_trigger_world_delay_item,self.bindfunc["gc_success_trigger_world_delay_item"]);

	PublicFunc.msg_regist(msg_fight.gc_sync_world_treasure_box_num,self.bindfunc["gc_sync_world_treasure_box_num"]);
	PublicFunc.msg_regist(msg_fight.gc_sync_world_treasure_box_next_step_box_born_cd,self.bindfunc["gc_sync_world_treasure_box_next_step_box_born_cd"]);
	PublicFunc.msg_regist(msg_fight.gc_sync_mysterious_treasure_box_info,self.bindfunc["gc_sync_mysterious_treasure_box_info"]);
	PublicFunc.msg_regist(msg_fight.gc_sync_world_treasure_box_point_rank,self.bindfunc["gc_sync_world_treasure_box_point_rank"]);
	PublicFunc.msg_regist(msg_fight.gc_sync_world_treasure_box_player_info,self.bindfunc["gc_sync_world_treasure_box_player_info"]);
end

--注销消息分发回调函数
function WorldTreasureBoxMainUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self)
	PublicFunc.msg_unregist(player.gc_sync_single_player_flag, self.bindfunc["on_gc_sync_single_player_flag"])
	
	PublicFunc.msg_unregist(msg_fight.gc_trigger_world_item_delay,self.bindfunc["gc_trigger_world_item_delay"]);
	PublicFunc.msg_unregist(msg_fight.gc_break_trigger_world_item_delay,self.bindfunc["gc_break_trigger_world_item_delay"]);
	PublicFunc.msg_unregist(msg_fight.gc_success_trigger_world_delay_item,self.bindfunc["gc_success_trigger_world_delay_item"]);

	PublicFunc.msg_unregist(msg_fight.gc_sync_world_treasure_box_num,self.bindfunc["gc_sync_world_treasure_box_num"]);
	PublicFunc.msg_unregist(msg_fight.gc_sync_world_treasure_box_next_step_box_born_cd,self.bindfunc["gc_sync_world_treasure_box_next_step_box_born_cd"]);
	PublicFunc.msg_unregist(msg_fight.gc_sync_mysterious_treasure_box_info,self.bindfunc["gc_sync_mysterious_treasure_box_info"]);
	PublicFunc.msg_unregist(msg_fight.gc_sync_world_treasure_box_point_rank,self.bindfunc["gc_sync_world_treasure_box_point_rank"]);
	PublicFunc.msg_unregist(msg_fight.gc_sync_world_treasure_box_player_info,self.bindfunc["gc_sync_world_treasure_box_player_info"]);
end

function WorldTreasureBoxMainUI:Clear()
	self.opening = false;
	self.canopen = {};
	self.beginOpenTime = nil
	self.beginItemGID = 0

	self.btnOpen = nil
	self.progress_bar = nil
	self.lab_small_box_cnt = nil
	self.lab_big_box_cnt = nil
	self.mysterious_treasure_box_obj = nil
	self.rank_info = nil
	self.lab_my_small_box_cnt = nil
	self.lab_my_big_box_cnt = nil
	self.lab_my_points = nil
	self.lab_my_kill_num = nil
	self.is_show_rank = false
	self.btn_show_rank = nil
	self.ani_show_rank = nil
	self.lab_next_step_box = nil
end

function WorldTreasureBoxMainUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d())
	self.ui:set_local_scale(1,1,1)
    self.ui:set_local_position(0,0,0)
	self.ui:set_name("ui_world_treasure_main");

	self.btnOpen = ngui.find_button(self.ui, "centre_other/btn");
	if self.btnOpen then
		self.btnOpen:set_on_click(self.bindfunc["on_btn_open"]);
		self.btnOpen:set_active(false);
	end

	self.progress_bar = ngui.find_progress_bar(self.ui, "centre_other/pro_xuetiao");
	if self.progress_bar then
		self.progress_bar:set_active(false);
		self.progress_bar:set_value(0);
	end
	self.lab_big_box_cnt = ngui.find_label(self.ui, "centre_other/sp_left_di/lab1");
	self.lab_small_box_cnt = ngui.find_label(self.ui, "centre_other/sp_left_di/lab2");
	self.mysterious_treasure_box_obj = self.ui:get_child_by_name("centre_other/sp_bk")
	self.lab_mysterious_free_cd =  ngui.find_label(self.ui, "centre_other/sp_bk/lab2");
	self.rank_info = {}
	for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
		self.rank_info[i] = {}
		self.rank_info[i].lab_country_name = ngui.find_label(self.ui, "centre_other/sp_di/content2/cont"..i.."/lab2");
		self.rank_info[i].lab_points = ngui.find_label(self.ui, "centre_other/sp_di/content2/cont"..i.."/lab3");
	end

	self.lab_my_big_box_cnt = ngui.find_label(self.ui, "centre_other/sp_di/content1/cont1/sp_box1/lab");
	self.lab_my_small_box_cnt = ngui.find_label(self.ui, "centre_other/sp_di/content1/cont1/sp_box2/lab");
	self.lab_my_points = ngui.find_label(self.ui, "centre_other/sp_di/content1/cont2/txt1/lab");
	self.lab_my_kill_num = ngui.find_label(self.ui, "centre_other/sp_di/content1/cont2/txt2/lab");
	self.lab_next_step_box = ngui.find_label(self.ui, "centre_other/sp_di/sp_right_di/txt_time");
	self.ani_show_rank = self.ui:get_child_by_name("centre_other/sp_di")
	self.btn_show_rank = ngui.find_button(self.ui, "centre_other/sp_di/content1/btn_empty")
	self.btn_show_rank:set_on_click(self.bindfunc["on_btn_show_rank"]);
	self.spr_btn_show_rank = ngui.find_sprite(self.ui, "centre_other/sp_di/content1/sp_arrows");
	self.btn_goto_mysterious_box = ngui.find_button(self.ui, "centre_other/sp_bk");
	self.btn_goto_mysterious_box:set_on_click(self.bindfunc["btn_goto_mysterious_box"]);
	self:UpdateUi()
end


function WorldTreasureBoxMainUI:DestroyUi()
	self:Clear();
	UiBaseClass.DestroyUi(self);
end


function WorldTreasureBoxMainUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end
	self:__UpdateTreasureBoxNumUI();
    self:__UpdateMysteriousTreasureBoxUI();
    self:__UpdateRankInfoUI();
    self:__UpdateMyInfo();
    self:__UpdateNextStepTreasureBoxInfo();
end

function WorldTreasureBoxMainUI:__UpdateRankInfoUI()
	for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
        if g_dataCenter.worldTreasureBox.rank_info[i] then
            local name = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.worldTreasureBox.rank_info[i].country_id).name;
            self.rank_info[i].lab_country_name:set_text(tostring(name))
            self.rank_info[i].lab_points:set_text(tostring(g_dataCenter.worldTreasureBox.rank_info[i].points))
        else
            self.rank_info[i].lab_country_name:set_text("")
            self.rank_info[i].lab_points:set_text("")
        end
    end
end

function WorldTreasureBoxMainUI:__UpdateTreasureBoxNumUI()
	local small_cnt, big_cnt = g_dataCenter.worldTreasureBox:GetTreasureBoxNum();
    if self.lab_small_box_cnt then
    	self.lab_small_box_cnt:set_text(tostring(small_cnt));
    end
    if self.lab_big_box_cnt then
    	self.lab_big_box_cnt:set_text(tostring(big_cnt));
    end
end

function WorldTreasureBoxMainUI:__UpdateMysteriousTreasureBoxUI()
	if g_dataCenter.worldTreasureBox.mysterious_treasure_box_info then
    	self.mysterious_treasure_box_obj:set_active(true)
    else
    	self.mysterious_treasure_box_obj:set_active(false)
    end
end

function WorldTreasureBoxMainUI:__UpdateMyInfo()
	if g_dataCenter.worldTreasureBox.my_report then
		self.lab_my_small_box_cnt:set_text(tostring(g_dataCenter.worldTreasureBox.my_report.open_small_box_cnt))
		self.lab_my_big_box_cnt:set_text(tostring(g_dataCenter.worldTreasureBox.my_report.open_big_box_cnt))
		self.lab_my_kill_num:set_text(tostring(g_dataCenter.worldTreasureBox.my_report.kill_enemy_cnt))
		self.lab_my_points:set_text(tostring(g_dataCenter.worldTreasureBox.my_report.points))
	else
		self.lab_my_small_box_cnt:set_text("0")
		self.lab_my_big_box_cnt:set_text("0")
		self.lab_my_kill_num:set_text("0")
		self.lab_my_points:set_text("0")
	end
end

function WorldTreasureBoxMainUI:__UpdateNextStepTreasureBoxInfo()
	if g_dataCenter.worldTreasureBox.next_step_box_born_cd then
		if g_dataCenter.worldTreasureBox.next_step_box_born_cd == 0 then
			self.lab_next_step_box:set_text("宝箱已全部刷出")
		else
			local left_second = g_dataCenter.worldTreasureBox.next_step_box_born_cd
	        local pass_time = PublicFunc.QueryDeltaTime(g_dataCenter.worldTreasureBox.next_step_box_born_cd_start)
	        left_second = left_second - pass_time/1000
	        left_second = math.max(0, left_second)
	        local time = PublicFunc.FormatLeftSeconds(left_second)
	       	self.lab_next_step_box:set_text("下波宝箱刷新: "..tostring(time))
		end
   	else
   		self.lab_next_step_box:set_text("下波宝箱刷新: 00:00:00")
	end

end

function WorldTreasureBoxMainUI:Update(dt)
	if not UiBaseClass.Update(self, dt) then
		return false
	end
	if self.beginOpenTime and self.progress_bar then
		local nNum = PublicFunc.QueryDeltaTime(self.beginOpenTime)/self.nTimeNeedCost;
		self.progress_bar:set_value(nNum);
	end
	if g_dataCenter.worldTreasureBox.mysterious_treasure_box_info then
    	local left_second = g_dataCenter.worldTreasureBox.mysterious_treasure_box_info.cd
        local pass_time = PublicFunc.QueryDeltaTime(g_dataCenter.worldTreasureBox.mysterious_treasure_box_info.cd_start)
        left_second = left_second - pass_time/1000
        left_second = math.max(0, left_second)
        local time = PublicFunc.FormatLeftSeconds(left_second)
        self.lab_mysterious_free_cd:set_text("剩余[ff0000]"..tostring(time).."[-]可开启")
    end
    self:__UpdateNextStepTreasureBoxInfo()
    return true;
end

----------------------- 本地回调 ---------------------------

--取消开宝箱
function WorldTreasureBoxMainUI:on_cancel_open_treasure_box()
	if self.opening then
		self.progress_bar:set_active(false);
		self.opening = false;
		self.beginOpenTime = nil
		self.beginItemGID = 0
	end
end

function WorldTreasureBoxMainUI:on_out_treasure_box(obj)
	for i=1, #self.canopen do
		if self.canopen[i] == obj:GetGID() then
			table.remove(self.canopen, i)
		end
	end
	if #self.canopen == 0 then
		self.btnOpen:set_active(false);
		if self.opening then
			self.progress_bar:set_active(false);
			self.opening = false;
			self.beginOpenTime = nil
			self.beginItemGID = 0
		end
	end
end

function WorldTreasureBoxMainUI:on_enter_treasure_box(obj)
	local config = ConfigManager.Get(EConfigIndex.t_world_item, obj:GetConfigId())
	if config and config.player_flag ~= 0 then
		local flag = config.player_flag
		-- 采集任务玩家标记
		if g_dataCenter.player_flag[flag] and g_dataCenter.player_flag[flag] ~= 0 then
			return;
		end
	end
	if obj.is_item_open then
		return
	end
	for i=1, #self.canopen do
		if self.canopen[i] == obj:GetGID() then
			return
		end
	end
	table.insert(self.canopen, obj:GetGID())
	if #self.canopen == 1 then
		self.btnOpen:set_active(true);
	end
end

function WorldTreasureBoxMainUI:on_btn_open(t)

	if self.nHeroId == nil then
		local obj = FightManager.GetMyCaptain()
    	app.log("WorldTreasureBoxMainUI setHeroId="..obj:GetGID())
    	self.nHeroId = obj:GetGID()
	end

	if self.opening == true then
		app.log_warning("箱子开启中，不能重复点");
		return
	end

	if #self.canopen == 0 or self.canopen[1] == 0 then
		return
	end

	local obj = FightManager.GetMyCaptain()
	if obj and not obj.lastSkillComplete then
		return
	end


	app.log("on_btn_open");
	
	msg_fight.cg_trigger_world_item(self.canopen[1], self.nHeroId, true)
end

----------------------- 网络回调 ---------------------------
function WorldTreasureBoxMainUI:on_gc_sync_single_player_flag(flag)
	if flag.key ~= 0 and #self.canopen then
		if self.canopen[1] ~= 0 then
			local obj = ObjectManager.GetObjectByGID(self.canopen[1])
			if obj then
				local config = ConfigManager.Get(EConfigIndex.t_world_item, obj:GetConfigId())
				if config and config.player_flag == flag.key then
					-- 采集任务完成
					if g_dataCenter.player_flag[flag.key] and g_dataCenter.player_flag[flag.key] ~= 0 then
						self:on_out_treasure_box(obj);
						return;
					end
				end
			end
		end
	end
end

function WorldTreasureBoxMainUI:gc_trigger_world_item_delay(gid)
	local obj = ObjectManager.GetObjectByGID(gid)
	if obj and obj:IsItem() then
		self.opening = true;
		self.progress_bar:set_active(true);

		local itemData = ConfigManager.Get(EConfigIndex.t_world_item, obj:GetConfigId())
		if itemData then
			self.nTimeNeedCost = itemData.delay_time;--花费时间
		else
			app.log("宝箱模板错误")
		end
		app.log("开启宝箱模板id= "..obj:GetConfigId().." "..self.nTimeNeedCost)
		self.beginOpenTime = PublicFunc.QueryCurTime()
		self.beginItemGID = gid
	end
end

function WorldTreasureBoxMainUI:gc_break_trigger_world_item_delay(gid)
	if self.beginItemGID == gid then
		if self.progress_bar then
			self.progress_bar:set_active(false);
		end
		self.opening = false;
		self.beginOpenTime = nil
		self.beginItemGID = 0
	end
end

function WorldTreasureBoxMainUI:gc_success_trigger_world_delay_item(gid)
	if self.beginItemGID == gid then
		if self.progress_bar then
			self.progress_bar:set_active(false);
		end
		self.opening = false;
		self.beginOpenTime = nil
		self.beginItemGID = 0
	end
end

function WorldTreasureBoxMainUI:gc_sync_world_treasure_box_num()
    self:__UpdateTreasureBoxNumUI();
end

function WorldTreasureBoxMainUI:gc_sync_world_treasure_box_next_step_box_born_cd()
    self:__UpdateNextStepTreasureBoxInfo();
end

function WorldTreasureBoxMainUI:gc_sync_mysterious_treasure_box_info()
    self:__UpdateMysteriousTreasureBoxUI()
end

function WorldTreasureBoxMainUI:gc_sync_world_treasure_box_point_rank()
 	self:__UpdateRankInfoUI();
end

function WorldTreasureBoxMainUI:gc_sync_world_treasure_box_player_info()
    self:__UpdateMyInfo();
end

function WorldTreasureBoxMainUI:on_btn_show_rank()
	self.is_show_rank = not self.is_show_rank;
    if self.is_show_rank then
    	self.ani_show_rank:animated_play("panel_open_box_jin")
    	self.spr_btn_show_rank:get_game_object():set_local_rotation(0, 0, 0);
    else
    	self.ani_show_rank:animated_play("panel_open_box")
    	self.spr_btn_show_rank:get_game_object():set_local_rotation(0, 0, 180);
    end
end

function WorldTreasureBoxMainUI:btn_goto_mysterious_box()
	if g_dataCenter.worldTreasureBox.mysterious_treasure_box_info then
		local dd = 
	    {
	        my_captain = g_dataCenter.fight_info:GetCaptain(),
	        des_world_id = FightScene.GetWorldGID(),
	        cur_world_id = FightScene.GetWorldGID(),
	        des_x = g_dataCenter.worldTreasureBox.mysterious_treasure_box_info.x * PublicStruct.Coordinate_Scale_Decimal,
        	des_y = 0,
        	des_z = g_dataCenter.worldTreasureBox.mysterious_treasure_box_info.y * PublicStruct.Coordinate_Scale_Decimal,
		}			
        g_dataCenter.autoPathFinding:SetDestination(dd)
	end
end



--[[endregion]]
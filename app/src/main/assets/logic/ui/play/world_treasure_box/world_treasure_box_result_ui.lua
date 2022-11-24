--[[
region world_treasure_box_result_ui.lua
date: 2016-7-28
time: 17:44:52
author: Nation
]]
WorldTreasureBoxResultUI = Class('WorldTreasureBoxResultUI', MultiResUiBaseClass);
WorldTreasureBoxResultUI.Show_Type_Mysterious = 1
WorldTreasureBoxResultUI.Show_Type_Rank = 2
WorldTreasureBoxResultUI.Max_Mysterious_Box_Reward = 5
WorldTreasureBoxResultUI.Max_Rank_Reward = 5
local resType = 
{
    Front = 1,
    Back = 2,
}
local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_830_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}
function WorldTreasureBoxResultUI:Init(data)
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function WorldTreasureBoxResultUI:InitData(data)
	MultiResUiBaseClass.InitData(self, data);
end

--重新开始
function WorldTreasureBoxResultUI:Restart(data)
	self.is_leave = false;
    self:Clear()
    MultiResUiBaseClass.Restart(self, data);
end

function WorldTreasureBoxResultUI:DestroyUi()
    self:Clear()
    MultiResUiBaseClass.DestroyUi(self);
end

function WorldTreasureBoxResultUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_page_down"] = Utility.bind_callback(self, self.on_btn_page_down);
   	self.bindfunc["on_btn_page_up"] = Utility.bind_callback(self, self.on_btn_page_up);
    self.bindfunc["on_btn_leave"] = Utility.bind_callback(self, self.on_btn_leave);
end

function WorldTreasureBoxResultUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
end

function WorldTreasureBoxResultUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
end

function WorldTreasureBoxResultUI:Clear()
	self.show_type = nil
	self.obj_mysterious_panel = nil
	self.obj_rank_panel = nil
    self.lab_count_down = nil
    self.lab_my_small_box_cnt = nil
    self.lab_my_big_box_cnt = nil
    self.lab_my_points = nil
    self.lab_my_kill_cnt = nil
    self.btn_page_down = nil
    self.btn_page_up = nil
    self.btn_leave = nil
    self.lab_open_persen = nil
    self.lab_reward_country = nil
    self.small_card_item = nil
    self.rank_info = nil
end

function WorldTreasureBoxResultUI:InitedAllUI()
    local backui = self.uis[resPaths[resType.Back]]
    backui:set_parent(Root.get_root_ui_2d())
    local lab_timer = ngui.find_label(backui, "center_other/animation/txt")
    if lab_timer then
        lab_timer:set_active(false)
    end
    local sp_title = ngui.find_sprite(backui, "center_other/animation/sp_art_font")
    sp_title:set_sprite_name("js_huodongjieshu")
    local attachObj = backui:get_child_by_name("center_other/animation/add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(attachObj)

    self.ui:set_local_scale(1,1,1)
    self.ui:set_local_position(0,0,0)
    self.ui:set_name("ui_world_treasure_box_result");

    self.obj_mysterious_panel = self.ui:get_child_by_name("animation/cont1")
    self.obj_rank_panel = self.ui:get_child_by_name("animation/cont2")
    self.lab_count_down = ngui.find_label(self.ui, "animation/lab")
    self.lab_count_down:set_active(false)

    self.btn_page_down = ngui.find_button(self.ui, "animation/cont_bk1/btn");
    self.btn_page_down:set_on_click(self.bindfunc["on_btn_page_down"]);
    self.btn_page_up = ngui.find_button(self.ui, "animation/cont_bk2/btn1");
    self.btn_page_up:set_on_click(self.bindfunc["on_btn_page_up"]);
    self.btn_leave = ngui.find_button(self.ui, "animation/cont_bk2/btn2");
    self.btn_leave:set_on_click(self.bindfunc["on_btn_leave"]);

    self.objContentBk1 = self.ui:get_child_by_name("animation/cont_bk1")
    self.objContentBk2 = self.ui:get_child_by_name("animation/cont_bk2")
    local content_name = ""
    if g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id ~= 0 then
        content_name = "cont_bk1"
        self.objContentBk1:set_active(true)
        self.objContentBk2:set_active(false)
    else
        content_name = "cont_bk2"
        self.objContentBk1:set_active(false)
        self.objContentBk2:set_active(true)
    end
    self.lab_my_small_box_cnt = ngui.find_label(self.ui, "animation/"..content_name.."/lab1")
    self.lab_my_big_box_cnt = ngui.find_label(self.ui, "animation/"..content_name.."/lab2")
    self.lab_my_points = ngui.find_label(self.ui, "animation/"..content_name.."/lab3")
    self.lab_my_kill_cnt = ngui.find_label(self.ui, "animation/"..content_name.."/lab4")
   
    self.lab_open_persen = ngui.find_label(self.ui, "animation/cont1/lab_title2");
    self.lab_reward_country = ngui.find_label(self.ui, "animation/cont1/lab_title3");
    
    
    self.small_card_item = {}
    local world_treasure_cfg = ConfigManager.Get(EConfigIndex.t_world_treasure_box, g_dataCenter.worldTreasureBox.fight_result.round_index)
    for i=1, WorldTreasureBoxResultUI.Max_Mysterious_Box_Reward do
    	local obj = self.ui:get_child_by_name("animation/cont1/grid/new_small_card_item"..i)
        if obj then
            if i <= #g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward then
                if #g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward < WorldTreasureBoxResultUI.Max_Mysterious_Box_Reward then
                    local posx, posy, posz = obj:get_local_position()
                    local newx = posx + (WorldTreasureBoxResultUI.Max_Mysterious_Box_Reward-#g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward)*55
                    obj:set_local_position(newx, posy, posz)
                end
                self.small_card_item[i] = UiSmallItem:new({parent = obj})
            else
                obj:set_active(false)
            end      
        end
    end

    self.rank_info = {}
    for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
    	self.rank_info[i] = {}
    	self.rank_info[i].spr_mysterious = ngui.find_sprite(self.ui, "animation/cont2/content"..i.."/sp_art_font")
    	self.rank_info[i].lab_country_name = ngui.find_label(self.ui, "animation/cont2/content"..i.."/lab_name");
        self.rank_info[i].sp_rank = ngui.find_sprite(self.ui, "animation/cont2/content"..i.."/sp_phb");
    	self.rank_info[i].lab_points = ngui.find_label(self.ui, "animation/cont2/content"..i.."/lab_num");
	 	self.rank_info[i].small_card_item = {}
        local reward = nil
        if world_treasure_cfg then
            if i == 1 then
                reward = world_treasure_cfg.first_reward
            elseif i == 2 then
                reward = world_treasure_cfg.second_reward
            elseif i == 3 then
                reward = world_treasure_cfg.third_reward
            end
        end
	 	for j=1, WorldTreasureBoxResultUI.Max_Rank_Reward do

	    	local obj = self.ui:get_child_by_name("animation/cont2/content"..i.."/cont/new_small_card_item"..j)
            if obj then
                if reward and j <= #reward then
                    if #reward < WorldTreasureBoxResultUI.Max_Rank_Reward then
                        local posx, posy, posz = obj:get_local_position()
                        local newx = posx + (WorldTreasureBoxResultUI.Max_Rank_Reward-#reward)*17
                        obj:set_local_position(newx, posy, posz)
                    end
                    self.rank_info[i].small_card_item[j] = UiSmallItem:new({parent = obj})
                else
                    obj:set_active(false)
                end
            end
	    end
    end
    self.count_down_begin = PublicFunc.QueryCurTime()
    self:UpdateUi()
end

function WorldTreasureBoxResultUI:UpdateUi()
	if not MultiResUiBaseClass.UpdateUi(self) then 
        return 
    end
    if g_dataCenter.worldTreasureBox.fight_result == nil then
    	return
    end
    if self.show_type == nil then
    	if g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id ~= 0 then
			self.show_type = WorldTreasureBoxResultUI.Show_Type_Mysterious
    	else
    		self.show_type = WorldTreasureBoxResultUI.Show_Type_Rank
    	end
    end
    self.lab_my_small_box_cnt:set_text("小宝箱[FDE517]"..tostring(g_dataCenter.worldTreasureBox.my_report.open_small_box_cnt).."[-]")
    self.lab_my_big_box_cnt:set_text("大宝箱[FDE517]"..tostring(g_dataCenter.worldTreasureBox.my_report.open_big_box_cnt).."[-]")
    self.lab_my_points:set_text("积分[FDE517]"..tostring(g_dataCenter.worldTreasureBox.my_report.points).."[-]")
    self.lab_my_kill_cnt:set_text("击杀数[FDE517]"..tostring(g_dataCenter.worldTreasureBox.my_report.kill_enemy_cnt).."[-]")

    if self.show_type == WorldTreasureBoxResultUI.Show_Type_Mysterious then
    	self.obj_mysterious_panel:set_active(true)
    	self.obj_rank_panel:set_active(false)
        self.btn_page_up:set_active(false)
        self.btn_leave:set_active(false)
        self.btn_page_down:set_active(true)
    	if g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id ~= 0 then
    		local player_name = g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.name
			local country_name = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id).name;
    		self.lab_open_persen:set_text(tostring(player_name))
			self.lab_reward_country:set_text(""..country_name.."所有参与战队将获得以下奖励")

			for i=1, #g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward do
				local id = g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward[i].id
				local num = g_dataCenter.worldTreasureBox.fight_result.mysterious_country_reward[i].count
				self.small_card_item[i]:SetDataNumber(id, num)
			end
    	end
    elseif self.show_type == WorldTreasureBoxResultUI.Show_Type_Rank then
    	self.obj_mysterious_panel:set_active(false)
    	self.obj_rank_panel:set_active(true)
    	self.btn_page_up:set_active(g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id ~= 0)
        self.btn_leave:set_active(true)
        self.btn_page_down:set_active(false)
    	local world_treasure_cfg = ConfigManager.Get(EConfigIndex.t_world_treasure_box, g_dataCenter.worldTreasureBox.fight_result.round_index)
    	for i=1, PublicStruct.Const.MAX_COUNTRY_CNT do
	        if g_dataCenter.worldTreasureBox.rank_info[i] then
	            local name = ConfigManager.Get(EConfigIndex.t_country_info, g_dataCenter.worldTreasureBox.fight_result.rank_info[i].country_id).name;
	            self.rank_info[i].lab_country_name:set_text(tostring(name))
	           	self.rank_info[i].lab_points:set_text("积分[FDE517]"..tostring(g_dataCenter.worldTreasureBox.fight_result.rank_info[i].points).."[-]")
	            self.rank_info[i].spr_mysterious:set_active(g_dataCenter.worldTreasureBox.fight_result.mysterious_box_info.country_id == g_dataCenter.worldTreasureBox.rank_info[i].country_id)
	            local reward = nil
	            if i == 1 then
	            	reward = world_treasure_cfg.first_reward
	            elseif i == 2 then
	            	reward = world_treasure_cfg.second_reward
	            elseif i == 3 then
	            	reward = world_treasure_cfg.third_reward
	            end
	            for j=1, #reward do
					local id = reward[j].id
					local num = reward[j].num
					self.rank_info[i].small_card_item[j]:SetDataNumber(id, num)
				end
                self.rank_info[i].sp_rank:set_sprite_name("phb_paiming" .. i) 
	        else
	            self.rank_info[i].lab_country_name:set_text("")
	           	self.rank_info[i].lab_points:set_text("")
                self.rank_info[i].sp_rank:set_active(false)
	            self.rank_info[i].spr_mysterious:set_active(false)
	        end
	    end
    end
end

function WorldTreasureBoxResultUI:Update(dt)
    if not MultiResUiBaseClass.Update(self, dt) then 
        return 
    end
    --[[local pass_time = PublicFunc.QueryDeltaTime(self.count_down_begin)
    local left_seconds = math.floor(99 - (pass_time/1000))
    if left_seconds <= 0 and not self.is_leave then
    	self.is_leave = true
    	self:on_btn_leave()
    	return
    end
    self.lab_count_down:set_text("([ff0000]"..left_seconds.."s[-]后关闭该界面)")]]
end

function WorldTreasureBoxResultUI:on_btn_page_down()
    self.objContentBk1:set_active(false)
    self.objContentBk2:set_active(true)
    self.lab_my_small_box_cnt = ngui.find_label(self.ui, "animation/cont_bk2/lab1")
    self.lab_my_big_box_cnt = ngui.find_label(self.ui, "animation/cont_bk2/lab2")
    self.lab_my_points = ngui.find_label(self.ui, "animation/cont_bk2/lab3")
    self.lab_my_kill_cnt = ngui.find_label(self.ui, "animation/cont_bk2/lab4")

	self.show_type = WorldTreasureBoxResultUI.Show_Type_Rank
	self:UpdateUi()
end

function WorldTreasureBoxResultUI:on_btn_page_up()
    self.objContentBk1:set_active(true)
    self.objContentBk2:set_active(false)
    self.lab_my_small_box_cnt = ngui.find_label(self.ui, "animation/cont_bk1/lab1")
    self.lab_my_big_box_cnt = ngui.find_label(self.ui, "animation/cont_bk1/lab2")
    self.lab_my_points = ngui.find_label(self.ui, "animation/cont_bk1/lab3")
    self.lab_my_kill_cnt = ngui.find_label(self.ui, "animation/cont_bk1/lab4")
	self.show_type = WorldTreasureBoxResultUI.Show_Type_Mysterious
	self:UpdateUi()
end

function WorldTreasureBoxResultUI:on_btn_leave()
	--FightScene.GetFightManager():FightOver(true);
    FightScene.OnFightOver()
    FightScene.ExitFightScene();
end


--[[endregion]]
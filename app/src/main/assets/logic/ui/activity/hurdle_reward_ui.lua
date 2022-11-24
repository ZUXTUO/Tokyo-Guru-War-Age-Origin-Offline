

HurdleRewardUI = Class("HurdleRewardUI", UiBaseClass)

function HurdleRewardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1109_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function HurdleRewardUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.reward = g_dataCenter.activityReward
    self.activityId = MsgEnum.eactivity_time.eActivityTime_hurdleReward
    self.grid = nil

    self.smallItemUIs = {}
end

function HurdleRewardUI:DestroyUi()
    UiBaseClass.DestroyUi(self)	
	-- 释放资源
    if self.smallItemUIs then
        for row, rowSmallItemUIs in pairs(self.smallItemUIs) do
            for col,smallItemUI in pairs(rowSmallItemUIs) do
                if smallItemUI then
                    smallItemUI:DestroyUi()
                end
            end
        
        end
        self.smallItemUIs = nil
    end
end

function HurdleRewardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item"] = Utility.bind_callback(self, HurdleRewardUI.init_item);
    self.bindfunc["to_get_reward"] = Utility.bind_callback(self, HurdleRewardUI.to_get_reward);
    self.bindfunc["to_section"] = Utility.bind_callback(self, HurdleRewardUI.to_section);
end

function HurdleRewardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("hurdle_reward_ui");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);

    self.sp_di = ngui.find_sprite(self.ui, "hurdle_reward_ui/center_other/animation/sp_di");
    self.sp_di:set_active(false);
    self.sp_mark = ngui.find_sprite(self.ui, "hurdle_reward_ui/center_other/animation/sp_mark");
    self.sp_mark:set_active(false);
    -- self.sp_bk = ngui.find_sprite(self.ui, "hurdle_reward_ui/center_other/animation/sp_bk");
    -- self.sp_bk:set_active(false);
    
    self.contentPath = "hurdle_reward_ui/center_other/animation/content/";
    self.sp_art_font = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font");
    self.sp_art_font:set_sprite_name("hd_biaoti_chuangguan");

    self.sp_art_font1 = ngui.find_sprite(self.ui, self.contentPath .. "cont2/sp_art_font");
    if self.sp_art_font1 then
        self.sp_art_font1:set_active(false);
    end

    self.lab_title1 = ngui.find_label(self.ui, self.contentPath .. "lab_title1");
    self.lab_title1:set_text("通关挑战，惊喜不断");

    self.lab_title2 = ngui.find_label(self.ui, self.contentPath .. "lab_title2");
    self.lab_title2:set_active(false);
    self.sp_clock = ngui.find_sprite(self.ui, self.contentPath .. "sp_clock");
    self.sp_clock:set_active(false);
    self.lab_time = ngui.find_label(self.ui, self.contentPath .. "lab_time");
    self.lab_time:set_active(false);

    self.grid = ngui.find_wrap_content(self.ui,"hurdle_reward_ui/center_other/animation/panel/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);
    self.gridScrollView = ngui.find_scroll_view(self.ui, "hurdle_reward_ui/center_other/animation/panel")

    self:UpdateRewardUI()
end

function HurdleRewardUI:init_item(obj, b, real_id)
    --app.log_warning("------------" .. b .. '|' .. real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1
    if not self.ui then
        return
    end
    local reward = self.reward:getReward(self.activityId, index);
    if reward == nil then
        return 
    end

    local sp_di = ngui.find_sprite(obj, "sp_di");
    sp_di:set_active(true);

    local sp_art_font = ngui.find_sprite(obj, "sp_art_font");
    sp_art_font:set_active(false);

    local lab_num = ngui.find_label(obj, "lab_num");
    if lab_num then
        lab_num:set_active(false);
    end

    -- 获取关卡id
    local currHurdleId = g_dataCenter.hurdle:GetCurFightLevelID()
    if currHurdleId == 0 then
        app.log_warning('获取关卡id失败')
        -- return 
    end
    reward.canGet = currHurdleId > reward.hurdleid

    local hurdle_cfg = ConfigManager.Get(EConfigIndex.t_hurdle, reward.hurdleid)
    if hurdle_cfg ~= nil then 
        reward.section = hurdle_cfg.b
    else 
        reward.section = ''
    end

    
    -- 标题
    local title = ngui.find_label(obj, "lab")
    local str = string.format(gs_activity['hurdle_reward_title'], reward.section)
    title:set_text(str)
   
    local btnReward = ngui.find_button(obj, "btn1");
    local labReward = ngui.find_label(obj, "btn1/lab"); 
    local btn2 = ngui.find_button(obj, "btn2")
    if btn2 then
        btn2:set_active(false);
    end
    -- local lblForward = ngui.find_label(obj, "content/btn2/lab")
    
    btnReward:set_active(true)
    -- btnForward:set_active(false)  

    -- 不能领取则跳转
    if reward.canGet then
        labReward:set_text(gs_activity['text_3']);
        labReward:set_effect_color(174/255, 65/255, 40/255, 1);
        btnReward:set_active(true)
        btnReward:set_sprite_names("ty_anniu3")
        btnReward:reset_on_click()
        btnReward:set_on_click(self.bindfunc["to_get_reward"]);
        btnReward:set_event_value("", index)        
    else
        -- btnForward:set_active(true)
        -- lblForward:set_text(gs_activity['hurdle_reward_forward'])
        -- btnForward:reset_on_click()
        -- btnForward:set_on_click(self.bindfunc["to_section"]);
        labReward:set_text(gs_activity['hurdle_reward_forward']);
        labReward:set_effect_color(29/255, 85/255, 160/255, 1);
        btnReward:set_sprite_names("ty_anniu4")
        btnReward:reset_on_click();
        btnReward:set_on_click(self.bindfunc["to_section"]);
    end

    local needCnt = #reward.rewardItems
    local items = {}

    local pathPre = "grid/new_small_card_item"
    for i = 1, 3 do
        items[i] = obj:get_child_by_name(pathPre .. i)
        items[i]:set_active(i <= needCnt)
    end   
    local rowName = obj:get_name()
    self.smallItemUIs[rowName] = self.smallItemUIs[rowName] or {}
    -- 获取items展示内容
    for k, v in ipairs(reward.rewardItems) do
        local id = v.id
        local num = v.num
        local light = v.light

        if items[k] == nil then
            break
        end
        local newItem = items[k]
        local colName = newItem:get_name()

        local smallItemUI = self.smallItemUIs[rowName][colName]
        if smallItemUI == nil then
            smallItemUI = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil, delay = 500});
            self.smallItemUIs[rowName][colName] = smallItemUI
        end
        -- app.log(id .. "--" .. num);
        -- do return end
        smallItemUI:SetDataNumber(id, num)

--        -- 增加press事件
--        local btn = ngui.find_button(newItem, "sp_back")
--        local bc = ButtonClick:new({obj = btn})
--        bc:SetPress(GoodsTips.BCShow, {id = id, count=num});
--        -- move时关闭tips
--        btn:set_on_ngui_drag_move("GoodsTips.BCHidden")

--        -- 图标
--        if PublicFunc.IdToConfig(id) ~= nil then
--            local iconPath = PublicFunc.IdToConfig(id).small_icon;
--            if iconPath ~= nil then
--                self.textures[row][k]:set_texture(iconPath)
--            end
--        end

        -- 高亮特效
        local effect = ngui.find_sprite(newItem, "fx/sp_fx");
        effect:set_active(light == 1)

        -- 设置外框颜色
        -- local frameName = self.reward:GetIconFrame(id, num)
        -- smallItemUI:SetFrame(frameName)

--        local shine  = ngui.find_sprite(newItem, "sp_back/human/sp_shine")
--        shine:set_active(false)
--        local mark  = ngui.find_sprite(newItem, "sp_back/sp_mark")
--        mark:set_active(false)

--        -- 数量
--        label = ngui.find_label(newItem, "sp_back/lab")
--        label:set_text('x ' .. num)
    end
end

--[[跳转到关卡]]
function HurdleRewardUI:to_section(param)
    uiManager:PushUi(EUI.UiLevel);
end

--[[领取奖励]]
function HurdleRewardUI:to_get_reward(param)    
    --app.log("to_get_reward " .. param.string_value .. ' ' .. param.float_value)

    local reward = self.reward:getReward(self.activityId, param.float_value)
    if reward.canGet then
        self.loadingId = GLoading.Show(GLoading.EType.ui)
        msg_activity.cg_hurdle_get_reward(reward.index)
    end
end

--[[服务返回奖励， 展示奖励]]
function HurdleRewardUI:RewardCallBack(reward)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
        
    self:UpdateRewardUI()
    -- 弹出奖励界面
    CommonAward.Start(reward)
end

function HurdleRewardUI:UpdateRewardUI()
    --app.log_warning('------------HurdleRewardUI:UpdateRewardUI ')
    if self.grid == nil then return end
    self.grid:set_min_index(-self.reward:getRewardCount(self.activityId) + 1)
    self.grid:set_max_index(0)
    self.grid:reset()
    self.gridScrollView:reset_position()
end

function HurdleRewardUI:Update(dt)

--    local day = self.reward:GetExpiredDay()
--    if day ~= self.currentShowDay and self.time_txt_label then
--        self.time_txt_label:set_text(string.format(gs_activity['text_5'], day))
--    end
end

function HurdleRewardUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
        
    end
end
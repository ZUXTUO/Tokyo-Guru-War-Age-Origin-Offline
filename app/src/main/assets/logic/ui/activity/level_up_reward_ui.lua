

LevelUpRewardUI = Class("LevelUpRewardUI", UiBaseClass)

local LevelUpRewardMsgToStr = 
{
    [level_up_reward_ret.level_up_reward_get_ret_success] = gs_activity['text_15'],
    [level_up_reward_ret.level_up_reward_get_ret_failed] = gs_activity['text_16'],

    [level_up_reward_ret.level_up_reward_get_ret_msg_failed] = gs_activity['text_8'],
    [level_up_reward_ret.level_up_reward_get_ret_msg_have_get] = gs_activity['text_9'],
    [level_up_reward_ret.level_up_reward_get_ret_msg_activity_time_expire] = gs_activity['text_10'],
    [level_up_reward_ret.level_up_reward_get_ret_msg_level_Illegal] = gs_activity['text_11'],
    [level_up_reward_ret.level_up_reward_get_ret_msg_player_level_low] = gs_activity['text_12'],
    [level_up_reward_ret.level_up_reward_get_ret_msg_player_add_item_failed] = gs_activity['text_13'],
    [level_up_reward_ret.level_up_reward_not_find_player] = gs_activity['text_14'],
}

function LevelUpRewardUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/award/ui_1109_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function LevelUpRewardUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.reward = LevelUpReward.GetInstance()

    self.timeID = nil;

    self.pressTime = -1
    self.showItemDelyTime = 0.5
    self.showItemId = nil
    self.showItemInfoPos = nil

    self.panelOriginY = 0
    --self.progressbarIsActive = false
    self.smallItemUIs = {}

    self.currentShowDay = 0
    self.activityReward = g_dataCenter.activityReward
end

function LevelUpRewardUI:DestroyUi()
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

function LevelUpRewardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item"] = Utility.bind_callback(self, LevelUpRewardUI.init_item);
    self.bindfunc["item_clock_get"] = Utility.bind_callback(self, LevelUpRewardUI.item_clock_get);
    self.bindfunc["item_press_show_info"] = Utility.bind_callback(self, LevelUpRewardUI.item_press_show_info);
    self.bindfunc['OnItemInfoTouchMove'] = Utility.bind_callback(self, LevelUpRewardUI.OnItemInfoTouchMove);
    self.bindfunc['OnDealGetLevelRewardResponse'] = Utility.bind_callback(self, LevelUpRewardUI.OnDealGetLevelRewardResponse);
    self.bindfunc["to_section"] = Utility.bind_callback(self, LevelUpRewardUI.to_section);
end

function LevelUpRewardUI:init_item(obj,b,real_id)

    local index = math.abs(real_id)
    local row = math.abs(b) + 1
    local reward = self.reward:GetAReward(index)

    if reward == nil then
        return 
    end

    local sp_di = ngui.find_sprite(obj, "sp_di");
    sp_di:set_active(true);

    local sp_art_font = ngui.find_sprite(obj, "sp_art_font");
    sp_art_font:set_active(false);

    local title = ngui.find_label(obj, "lab")
    local str = string.format(gs_activity['text_1'], reward.level)
    title:set_text(str)

    local lab_num = ngui.find_label(obj, "lab_num");
    if g_dataCenter.player.level < reward.level then
        lab_num:set_active(true);
        lab_num:set_text(g_dataCenter.player.level .. "/" .. reward.level);
    else
        lab_num:set_active(false);
    end

    local btnReward = ngui.find_button(obj, "btn1") 
    local labReward = ngui.find_label(obj, "btn1/animation/lab");
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
        btnReward:set_active(true)
        btnReward:reset_on_click()
        btnReward:set_on_click(self.bindfunc["item_clock_get"]);
        btnReward:set_event_value("", index)        
    else
        -- btnForward:set_active(true)
        -- lblForward:set_text(gs_activity['text_2'])
        -- btnForward:reset_on_click()
        -- btnForward:set_on_click(self.bindfunc["to_section"]);
        labReward:set_text(gs_activity['text_2']);
        btnReward:reset_on_click();
        btnReward:set_on_click(self.bindfunc["to_section"]);
    end

    --if reward ~= nil then
        --itemgrid:set_min_index(0);
        --itemgrid:set_max_index(table.maxn(reward.itemsID) - 1);
    --end

    --app.log('init_item  ' .. index)
    local needCnt = #reward.itemsID
    local items = {}

    local pathPre = "grid/new_small_card_item"
    for i = 1, 3 do
        items[i] = obj:get_child_by_name(pathPre .. i)
        items[i]:set_active(i <= needCnt)
    end
    local rowName = obj:get_name()
    self.smallItemUIs[rowName] = self.smallItemUIs[rowName] or {}
    for k, v in ipairs(reward.itemsID) do
        local id = v.id
        local num = v.num
        local light = v.byLight
        --local type = PropsEnum.GetItemType(id)
        --if type > 0 then
            if items[k] == nil then
                break
            end
            local newItem = items[k]
            local colName = newItem:get_name()

            local smallItemUI = self.smallItemUIs[rowName][colName]
            if smallItemUI == nil then
                smallItemUI = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil});
                self.smallItemUIs[rowName][colName] = smallItemUI
            end
            smallItemUI:SetDataNumber(id, num)

--            -- 增加press事件
--            local btn = ngui.find_button(newItem, "sp_back")
--            local bc = ButtonClick:new({obj = btn})
--            bc:SetPress(GoodsTips.BCShow, {id = id, count=num});
--            -- move时关闭tips
--            btn:set_on_ngui_drag_move("GoodsTips.BCHidden")

--            -- 图标
--            if PublicFunc.IdToConfig(id) ~= nil then
--                local iconPath = PublicFunc.IdToConfig(id).small_icon;
--                if iconPath ~= nil then
--                    self.textures[row][k]:set_texture(iconPath)
--                end
--            end

            -- 高亮特效
            local effect = ngui.find_sprite(newItem, "fx/sp_fx");
            effect:set_active(light == 1)

            -- 设置外框颜色
            -- local frameName = self.activityReward:GetIconFrame(id, num)
            -- smallItemUI:SetFrame(frameName)
--            local frame = ngui.find_sprite(newItem, "sp_back/sp_frame")
--            self.activityReward:setIconFrame(frame, id, num)

--            local shine  = ngui.find_sprite(newItem, "sp_back/human/sp_shine")
--            shine:set_active(false)
--            local mark  = ngui.find_sprite(newItem, "sp_back/sp_mark")
--            mark:set_active(false)

--            --btn = ngui.find_button(newItem, name)
--            --btn:set_on_ngui_press(self.bindfunc["item_press_show_info"]);
--            --btn:set_on_ngui_drag_move(self.bindfunc['OnItemInfoTouchMove'])

--            label = ngui.find_label(newItem, "sp_back/lab")
--            label:set_text('x ' .. num)
        --end
    end
end

function LevelUpRewardUI:item_clock_get(param)
    
    --app.log("item_clock_getitem_clock_get " .. param.string_value .. ' ' .. param.float_value)

    local reward = self.reward:GetAReward(param.float_value)

    if reward.canGet then
        self.loadingId = GLoading.Show(GLoading.EType.ui)
        --msg_activity.client_get_level_reward(self, reward)
        self.reward:GetLevelReward(reward, self.bindfunc['OnDealGetLevelRewardResponse'])
--    else

--	    --AudioManager.SetBackGroundMusicVolume(0.1)
--	    uiManager:PushUi(EUI.UiLevel);
--	    --uiManager:ClearStack();
    end
end

--[[跳转到关卡]]
function LevelUpRewardUI:to_section(param)
    uiManager:PushUi(EUI.UiLevel);
end

function LevelUpRewardUI:item_press_show_info(name, state, ix, iy, gameObj)
    if state then
        self.pressTime = 0
        self.showItemId = tonumber(name)
        self.showItemInfoPos = {x = ix, y = iy}
    else

        self:__CloseItemInfoTip()
    end
end

function LevelUpRewardUI:__CloseItemInfoTip()
    self.pressTime = -1
    self.showItemId = nil
    GoodsTips.EnableGoodsTips(false)
end

function LevelUpRewardUI:OnItemInfoTouchMove(name,x,y)
    --app.log('LevelUpRewardUI:OnItemInfoTouchMove')
    if self.pressTime >= 0 then
        self:__CloseItemInfoTip()
    end
end

function LevelUpRewardUI:OnDealGetLevelRewardResponse(ret, msgid, reward)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
    if ret == level_up_reward_ret.level_up_reward_get_ret_success then
        --self.reward:CacheANewGet(rew)
        self:UpdateReward()

        --FightAwardUi.Init({});

--        local awardui = uiManager:PushUi(EUI.GetAward);
--        awardui:SetData(rew.itemsID)
        local awardList = {}
        for k, v in ipairs(reward.itemsID) do
            table.insert(awardList, {dataid='0', id=v.id, count = v.num})
        end
        CommonAward.Start(awardList)
    else

        local str = LevelUpRewardMsgToStr[msgid]
        if str == nil then
            str = gs_activity['text_17'] .. tostring(msgid)
        end

        HintUI.SetAndShow(EHintUiType.zero, str)
    end
end

function LevelUpRewardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	-- self.ui:set_parent(Root.get_root_ui_2d());
     self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("level_up_reward_ui");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);

--    self.uiItem = asset_game_object.create(self.loadLvelUpRewardUIItemObj);
--    self.uiItem:set_parent(self.ui);
--    self.uiItem:set_name("item");
--    self.uiItem:set_active(false)

    self.sp_di = ngui.find_sprite(self.ui, "level_up_reward_ui/center_other/animation/sp_di");
    -- self.sp_di:set_active(false);
    self.sp_mark = ngui.find_sprite(self.ui, "level_up_reward_ui/center_other/animation/sp_mark");
    -- self.sp_mark:set_active(false);
    self.sp_bk = ngui.find_sprite(self.ui, "level_up_reward_ui/center_other/animation/sp_bk");
    -- self.sp_bk:set_active(false);
    
    self.contentPath = "level_up_reward_ui/center_other/animation/content/";
    self.sp_art_font = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font");
    self.sp_art_font:set_sprite_name("hd_biaoti_shengji");

    self.lab_title1 = ngui.find_label(self.ui, self.contentPath .. "lab_title1");
    self.lab_title1:set_text("成长助力，升级有礼");

    self.lab_title2 = ngui.find_label(self.ui, self.contentPath .. "lab_title2");
    self.lab_title2:set_active(false);
    self.sp_clock = ngui.find_sprite(self.ui, self.contentPath .. "sp_clock");
    self.sp_clock:set_active(false);
    self.lab_time = ngui.find_label(self.ui, self.contentPath .. "lab_time");
    self.lab_time:set_active(false);

    self.time_txt_label = ngui.find_label(self.ui, "level_up_reward_ui/centre_other/di/lab_time")

    self.grid = ngui.find_wrap_content(self.ui,"level_up_reward_ui/center_other/animation/panel/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);

    self.gridScrollView = ngui.find_scroll_view(self.ui, "level_up_reward_ui/center_other/animation/panel")

--    self.wrapcontentPannel = ngui.find_panel(self.ui, "level_up_reward_ui/scroll")

--    local x,y,z = self.wrapcontentPannel:get_position()
--    self.panelOriginY = y

    self:UpdateReward()
    --app.log('111')
end

function LevelUpRewardUI:UpdateReward()
    if self.grid == nil then return end
    self.grid:set_min_index(-self.reward:GetRewardCount() + 1)
    self.grid:set_max_index(0)
    self.grid:reset()
    self.gridScrollView:reset_position()
    self.reward:CalHasnotGetRewardLevel()
    --if self.reward:GetRewardCount() <= 3 then
        --self.processBar:set_active(false)
        --self.progressbarIsActive = false
    --else
        --self.processBar:set_active(true)
        --self.progressbarIsActive = true
    --end
end

function LevelUpRewardUI:Update(dt)
    -- if self.pressTime >= 0 then
    --     self.pressTime = self.pressTime +  dt
    -- end

    -- if self.pressTime >= self.showItemDelyTime then
    --     GoodsTips.EnableGoodsTips(true, self.showItemId, self.showItemInfoPos.x, self.showItemInfoPos.y)
    --     self.pressTime = -1
    -- end

    --if self.progressbarIsActive then
        ----self.lastProgressBarValue
        --local x,y,z = self.wrapcontentPannel:get_position()
        --local value = 1 - (y - self.panelOriginY)/(130 * (self.reward:GetRewardCount() - 3))
        --if self.processBar:get_value() ~= value then
            --self.processBar:set_value(value)
        --end
--
    --end

--    local day = self.reward:GetExpiredDay()
--    if day ~= self.currentShowDay and self.time_txt_label then
--        self.time_txt_label:set_text(string.format(gs_activity['text_5'], day))
--    end
end

function LevelUpRewardUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
    --todo 各自额外的逻辑
    end
end


return LevelUpRewardUI


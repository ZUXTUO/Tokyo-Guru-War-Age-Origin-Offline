LoginRewardUI = Class("LoginRewardUI", UiBaseClass)

local _texture = {
    [1] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_qiridenglu/hd_kapai.assetbundle",
    [2] = "assetbundles/prefabs/ui/image/backgroud/huo_dong/huodong_qiridenglu/hd_kapai2.assetbundle"
}

function LoginRewardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1121_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function LoginRewardUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.reward = g_dataCenter.activityReward
    self.activityId = MsgEnum.eactivity_time.eActivityTime_loginReward
    self.grid = nil
    self.smallItemUIs = {}
    self.m_current_day = 0;
    self.m_current_award_day = 0;
end

function LoginRewardUI:DestroyUi()
    UiBaseClass.DestroyUi(self)	
	-- ÊÍ·Å×ÊÔ´
    if self.smallItemUIs then
        for row, rowSmallItemUIs in pairs(self.smallItemUIs) do
            for col,smallItemUIs in pairs(rowSmallItemUIs) do
                for k,v in pairs(smallItemUIs) do
                    if v then
                        v:DestroyUi()
                        v = nil;
                    end
                end
                
            end
        
        end
        self.smallItemUIs = nil
    end
    self.m_current_day = 0;

    if self.m_hero_texture then
        self.m_hero_texture:clear_texture();
        self.m_hero_texture = nil;
    end
end

function LoginRewardUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, LoginRewardUI.on_close);
    self.bindfunc["init_item"] = Utility.bind_callback(self, LoginRewardUI.init_item);
    self.bindfunc["to_get_reward"] = Utility.bind_callback(self, self.to_get_reward);
    self.bindfunc["on_click_head_detail"] = Utility.bind_callback(self, self.on_click_head_detail);
    self.bindfunc["on_click_hero_texture"] = Utility.bind_callback(self, self.on_click_hero_texture);
    -- self.bindfunc["on_check_open_role"] = Utility.bind_callback(self, self.on_check_open_role);

    self.bindfunc["gc_login_get_reward"] = Utility.bind_callback(self, self.gc_login_get_reward);
    self.bindfunc["gc_login_request_my_data"] = Utility.bind_callback(self, self.gc_login_request_my_data);
end

--注册消息分发回调函数
function LoginRewardUI:MsgRegist()
    UiBaseClass.MsgRegist(self);

    PublicFunc.msg_regist("msg_activity.gc_login_get_reward", self.bindfunc["gc_login_get_reward"]);
    PublicFunc.msg_regist("msg_activity.gc_login_request_my_data", self.bindfunc["gc_login_request_my_data"]);
   
end

--注销消息分发回调函数
function LoginRewardUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist("msg_activity.gc_login_get_reward", self.bindfunc["gc_login_get_reward"]);
    PublicFunc.msg_unregist("msg_activity.gc_login_request_my_data", self.bindfunc["gc_login_request_my_data"]);
end

function LoginRewardUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("login_reward_ui");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);

    self.sp_di = ngui.find_sprite(self.ui, "login_reward_ui/center_other/animation/sp_di");
    -- self.sp_di:set_active(false);
    self.sp_mark = ngui.find_sprite(self.ui, "login_reward_ui/center_other/animation/sp_mark");
    -- self.sp_mark:set_active(false);
    -- self.sp_bk = ngui.find_sprite(self.ui, "login_reward_ui/center_other/animation/sp_bk");
    -- self.sp_bk:set_active(false);

    self.btn_close = ngui.find_button(self.ui, "center_other/animation/content_di_1004_564/btn_cha");
    self.btn_close:set_on_click(self.bindfunc["on_close"]);
    
    self.contentPath = "login_reward_ui/center_other/animation/";
    self.sp_art_font = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font");
    -- self.sp_art_font:set_sprite_name("hd_biaoti_denglu");

    -- self.lab_title = ngui.find_label(self.ui, self.contentPath .. "sp_di/lab_title");
    -- self.lab_title:set_text("登录奖励");

    self.lab_title1 = ngui.find_label(self.ui, self.contentPath .. "texture_bk/lab");
    self.lab_title1:set_text("每日相约，好礼不停");

    -- self.lab_title2 = ngui.find_label(self.ui, self.contentPath .. "sp_art_font_jinmu/txt");
    -- self.lab_title2:set_active(false);
    -- self.sp_clock = ngui.find_sprite(self.ui, self.contentPath .. "sp_art_font/sp_time");
    -- self.sp_clock:set_active(false);
    self.lab_time = ngui.find_label(self.ui, self.contentPath .. "txt");
    self.lab_time:set_active(false);

    --self.time_txt_label = ngui.find_label(self.ui, "login_reward_ui/centre_other/di/lab_time")
    self.grid = ngui.find_wrap_content(self.ui,"login_reward_ui/center_other/animation/scro_view/panel/wrap_content");
    self.grid:set_on_initialize_item(self.bindfunc["init_item"]);
    self.grid:set_min_index(0);
    self.grid:set_max_index(-1)
    self.grid:reset()
    self.gridScrollView = ngui.find_scroll_view(self.ui, "login_reward_ui/center_other/animation/scro_view/panel");

    self.m_hero_texture = ngui.find_texture(self.ui, "center_other/animation/texture_human");
    self.m_hero_btn = ngui.find_button(self.ui, "center_other/animation/texture_human");
    self.m_hero_btn:set_on_click(self.bindfunc["on_click_hero_texture"]);


    if not g_dataCenter.activityReward:GetisLoginData() then
    	msg_activity.cg_login_request_my_data();
    else
    	self:UpdateRewardUI();
    end
    -- self:UpdateRewardUI()
end

function LoginRewardUI:init_item(obj, b, real_id)
    local index = math.abs(real_id)
    local row = math.abs(b) + 1

    local reward = self.reward:getReward(self.activityId, index);
    if reward == nil then
        return 
    end
    local sp_di = ngui.find_sprite(obj, "sp_di");
    sp_di:set_active(true);

    local sp_art_font = ngui.find_sprite(obj, "sp_yinzhang");
    sp_art_font:set_active(false);

    local lab_num = ngui.find_label(obj, "lab_shuzi");
    if lab_num then
        lab_num:set_active(false);
    end

    local txt = ngui.find_label(obj, "txt");
    txt:set_text("累计登录");
    -- ±êÌâ
    local lab_title = ngui.find_label(obj, "lab_title")
    -- local str = string.format(gs_activity['login_reward_title'], reward.days)
    lab_title:set_text(reward.days.."天");
   
    local btn = ngui.find_button(obj, "btn2")
    if btn then
        btn:set_active(false);
    end
    -- btn:set_active(false)
    btn = ngui.find_button(obj, "btn1")    
    btn:set_active(true)

    -- ²»ÄÜÁìÈ¡Ôò±ä»Ò

    if reward.isGet == 1 then
        -- btn:set_enable(false);
        btn:set_active(false);
        lab_num:set_active(false);
        sp_art_font:set_active(true);    
    elseif reward.canGet then
        btn:set_active(true);
        -- btn:set_enable(true)
        btn:reset_on_click()
        btn:set_event_value("", index)
        btn:set_on_click(self.bindfunc["to_get_reward"]);
        
        sp_art_font:set_active(false);
    elseif reward.canGet == false then
        -- btn:set_enable(false)
        btn:set_active(false);
        lab_num:set_active(true);
        lab_num:set_text(reward.c_day .. "/" .. reward.days);
        sp_art_font:set_active(false);
    end        

   

    local needCnt = #reward.rewardItems
    local items = {}

    local pathPre = "grid/new_small_card_item"
    for i = 1, 4 do
        items[i] = obj:get_child_by_name(pathPre .. i)
        items[i]:set_active(i <= needCnt)
    end

    local rowName = obj:get_name()
    self.smallItemUIs[rowName] = self.smallItemUIs[rowName] or {}
    -- »ñÈ¡itemsÕ¹Ê¾ÄÚÈÝ
	app.log("index = "..tonumber(index).." rewardItems = \n"..table.tostring(reward.rewardItems));
    for k, v in ipairs(reward.rewardItems) do
        local id = v.id
        local num = v.num
        local light = v.light

        if items[k] == nil then
            break
        end
        local newItem = items[k]
        local colName = newItem:get_name()
		local smallItemUI = nil;

        if self.smallItemUIs[rowName][colName] == nil then
            self.smallItemUIs[rowName][colName] = {};
        end

		if PropsEnum.IsItem(id) then 
            if self.smallItemUIs[rowName][colName][1] == nil then
                self.smallItemUIs[rowName][colName][1] = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil, delay = 500});
            end
            self.smallItemUIs[rowName][colName][1]:Show();
            self.smallItemUIs[rowName][colName][1]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][1]:SetEnablePressGoodsTips(true);

            if self.smallItemUIs[rowName][colName][2] then
                self.smallItemUIs[rowName][colName][2]:Hide();
            end            
		elseif PropsEnum.IsRole(id) then
            if self.smallItemUIs[rowName][colName][2] == nil then
                self.smallItemUIs[rowName][colName][2] = SmallCardUi:new({parent = newItem, info = CardHuman:new({number = tonumber(id)}), stypes = {1,6,9}});
            end
            self.smallItemUIs[rowName][colName][2]:Show();
            self.smallItemUIs[rowName][colName][2]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][2]:SetCallback(self.bindfunc["on_click_head_detail"])
            self.smallItemUIs[rowName][colName][2]:SetAsReward(true)
            -- self.smallItemUIs[rowName][colName][2]:SetRewardEffectScale(0.42, 0.42, 0.42)
            light = 0

            -- self.smallItemUIs[rowName][colName][2]:SetEnablePressGoodsTips(true);

            if self.smallItemUIs[rowName][colName][1] then
                self.smallItemUIs[rowName][colName][1]:Hide();
            end     



   --          if self.smallItemUIs[rowName][colName][2] then
   --               smallItemUI = self.smallItemUIs[rowName][colName][2]
   --          end
			-- -- if smallItemUI and  smallItemUI._className == "UiSmallItem" then 
			-- -- 	smallItemUI:DestroyUi();
			-- -- 	smallItemUI = nil;
			-- -- end
   --          if self.smallItemUIs[rowName][colName][1] then
   --              self.smallItemUIs[rowName][colName][1]:Hide();
   --          end

			-- if smallItemUI == nil then
			-- 	smallItemUI = SmallCardUi:new({parent = newItem, info = CardHuman:new({number = tonumber(id)}), stypes = {1,6,9}});
   --              smallItemUI:Show();
			-- 	self.smallItemUIs[rowName][colName][2] = smallItemUI
			-- else 
			-- 	smallItemUI:SetDataNumber(tonumber(id));
			-- end 
   --          smallItemUI:SetCallback(self.bindfunc["on_click_head_detail"])
		else	
			if self.smallItemUIs[rowName][colName][1] == nil then
                self.smallItemUIs[rowName][colName][1] = UiSmallItem:new({obj=nil, parent = newItem, cardInfo = nil, delay = 500});
            end
            self.smallItemUIs[rowName][colName][1]:Show();
            self.smallItemUIs[rowName][colName][1]:SetDataNumber(id, num);
            self.smallItemUIs[rowName][colName][1]:SetEnablePressGoodsTips(true);

            if self.smallItemUIs[rowName][colName][2] then
                self.smallItemUIs[rowName][colName][2]:Hide();
            end     
		end
        
--        -- Ôö¼ÓpressÊÂ¼þ
--        local btn = ngui.find_button(newItem, "sp_back")
--        local bc = ButtonClick:new({obj = btn})
--        bc:SetPress(GoodsTips.BCShow, {id = id, count=num});
--        -- moveÊ±¹Ø±Õtips
--        btn:set_on_ngui_drag_move("GoodsTips.BCHidden")

--        if PublicFunc.IdToConfig(id) ~= nil then
--            local iconPath = PublicFunc.IdToConfig(id).small_icon;
--            if iconPath ~= nil then
--                self.textures[row][k]:set_texture(iconPath)
--            end
--        end

        -- ¸ßÁÁÌØÐ§
        -- local effect = ngui.find_sprite(newItem, "fx/sp_fx");
        local effect = newItem:get_child_by_name("fx_checkin_month_right");
        if effect then
            effect:set_active(light == 1)
        end

--        local shine  = ngui.find_sprite(newItem, "sp_back/human/sp_shine")
--        shine:set_active(false)
--        local mark  = ngui.find_sprite(newItem, "sp_back/sp_mark")
--        mark:set_active(false)


        -- ÉèÖÃÍâ¿òÑÕÉ«
		-- if smallItemUI.SetFrame ~= nil then 
		-- 	local frameName = self.reward:GetIconFrame(id, num)
		-- 	smallItemUI:SetFrame(frameName)
		-- end 
--        -- ÉèÖÃÍâ¿òÑÕÉ«
--        local frame = ngui.find_sprite(newItem, "sp_back/sp_frame")
--        self.reward:setIconFrame(frame, id, num)

--        -- ÊýÁ¿
--        label = ngui.find_label(newItem, "sp_back/lab")
--        label:set_text('x ' .. num)
    end
end

function LoginRewardUI:on_click_head_detail( cardUI )
    app.log("--------------- 点击头像" .. tostring(cardUI.cardInfo.number));
    RecruitDetalUI:new(cardUI.cardInfo.number);
end

function LoginRewardUI:on_click_hero_texture( t )
    app.log("m_login_day:" .. self.m_login_day);
    app.log(table.tostring(self.m_role_id));
    if self.m_login_day <= 1 then
        HeroShowUI:new({role_id = self.m_role_id[1], index = 1});
    elseif self.m_login_day > 1 then
        HeroShowUI:new({role_id = self.m_role_id[2], index = 2});
    end
end

--[[ÁìÈ¡½±Àø]]
function LoginRewardUI:to_get_reward(param)    
    local reward = self.reward:getReward(self.activityId, param.float_value)
    if reward.canGet then
        self.loadingId = GLoading.Show(GLoading.EType.ui)
        self.m_current_award_day = reward.index;
        msg_activity.cg_login_get_reward(reward.index)
    end
end

--[[·þÎñ·µ»Ø½±Àø£¬ Õ¹Ê¾½±Àø]]
function LoginRewardUI:RewardCallBack(reward)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
        
    self:UpdateRewardUI()
    -- µ¯³ö½±Àø½çÃæ
    CommonAward.Start(reward);
    CommonAward.SetFinishCallback(self.on_check_open_role, self);

   
end

function LoginRewardUI:on_check_open_role( )
    app.log("self.m_login_day:" .. self.m_login_day .. " self.m_current_award_day:" .. self.m_current_award_day);

    app.log("m_role_id:" .. table.tostring(self.m_role_id));

    if self.m_login_day == 1 and self.m_current_award_day == 1 then
        HeroShowUI:new({role_id = self.m_role_id[1], index = 1});
    elseif self.m_login_day == 2 and self.m_current_award_day == 2 then
        HeroShowUI:new({role_id = self.m_role_id[2], index = 2});
    end
end

function LoginRewardUI:UpdateRewardUI()
    --app.log_warning('------------LoginRewardUI:UpdateRewardUI ')
    if self.grid == nil then return end
    self.m_current_day = self.reward:getRewardCount(self.activityId);

    local login_day = 0;
    local reward_data = nil;
    self.m_role_id = {};
    for i=0, self.m_current_day - 1 do
        reward_data = self.reward:getReward(self.activityId, i);
        if reward_data then
            if reward_data.isGet == 1 or reward_data.canGet then
                login_day = login_day + 1;            
            end
            for k, v in ipairs(reward_data.rewardItems) do
                if PropsEnum.IsRole(v.id) then
                    table.insert(self.m_role_id, v.id);
                end
            end
        end
    end
    table.sort( self.m_role_id, function ( a, b )
        return a < b;
    end )
    self.m_login_day = login_day;
    -- app.log("login_day:" .. login_day);
    if login_day <= 1 then
        self.m_hero_texture:set_texture(_texture[1]);
    else
        self.m_hero_texture:set_texture(_texture[2]);
    end




    -- app.log("----------- login_current_day:" .. self.m_current_day);
    self.grid:set_min_index(-self.reward:getRewardCount(self.activityId) + 1)
    -- self.grid:set_min_index(-7 + 1);
    self.grid:set_max_index(0)
    self.grid:reset()
    self.gridScrollView:reset_position()
end


function LoginRewardUI:Update(dt)

--    local day = self.reward:GetExpiredDay()
--    if day ~= self.currentShowDay and self.time_txt_label then
--        self.time_txt_label:set_text(string.format(gs_activity['text_5'], day))
--    end
end

function LoginRewardUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
    --todo ¸÷×Ô¶îÍâµÄÂß¼­
    end
end

function LoginRewardUI:on_close( t )
    uiManager:RemoveUi(EUI.LoginRewardUI);
end

function LoginRewardUI:gc_login_request_my_data( )
    self:UpdateRewardUI();
end

function LoginRewardUI:gc_login_get_reward( reward )
    self:RewardCallBack(reward);
end
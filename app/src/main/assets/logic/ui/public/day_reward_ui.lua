DayRewardUI = Class("DayRewardUI", UiBaseClass);

function DayRewardUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/public/panel_day_award_item.assetbundle"
    UiBaseClass.Init(self, data);
end

function DayRewardUI:InitData(data)
    UiBaseClass.InitData(self, data);
    
    self.listMax = 10;
end

function DayRewardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_click"] = Utility.bind_callback(self,self.on_click);
    self.bindfunc["on_back"] = Utility.bind_callback(self,self.on_back);
end

function DayRewardUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
	
    self._resultCallback = nil;
end

function DayRewardUI:SetRewards(reward_list,can_get)
	self.rewardList = reward_list;
    self.canGet = can_get;
    self:UpdateUi();
end

function DayRewardUI:SetResultCallback(func)
    self._resultCallback = func;
end

function DayRewardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    local _ui = self.ui;

    self.btnGet = ngui.find_button(_ui,"btn_leave");
    self.btnGet:set_on_click(self.bindfunc["on_click"]);
    self.btnGetGray = ngui.find_button(_ui,"btn_leave_gray");
    local lab = ngui.find_label(_ui,"btn_leave_gray/txt_revive");
    lab:set_text("已领取");
    self.btnGetGray:set_on_click(self.bindfunc["on_click"]);
    local _btn = ngui.find_button(_ui,"sp_mark");
    _btn:set_on_click(self.bindfunc["on_back"])
    local _btnClose = ngui.find_button(_ui,"btn_fork");
    _btnClose:set_on_click(self.bindfunc["on_back"])
    self.labRewardNum = ngui.find_label(_ui,"centre_other/animation/lab");
    -- self.rewards = {};
    -- for i=1,self.listMax do
    -- 	self.rewards[i] = {};
    -- 	local path = "panel/grid_content/item_rank"..i;
    -- 	self.rewards[i].all = ngui.find_button(_ui,path);
    -- 	self.rewards[i].name = ngui.find_label(_ui,path.."/sp_bk_di/lab_name");
    -- 	self.rewards[i].sp = ngui.find_texture(_ui,path.."/sp_bk_di/head_bk/sp_daoju");
    -- 	self.rewards[i].frame = ngui.find_sprite(_ui,path.."/sp_bk_di/head_bk/sp_frame");
    -- end
    self.odd = {};
    self.odd.root = _ui:get_child_by_name("centre_other/animation/content/odd_num");
    for i=1,3 do 
        local obj = _ui:get_child_by_name("centre_other/animation/content/odd_num/kug"..i)
        self.odd[i] = {};
        self.odd[i].obj = UiSmallItem:new({obj=obj});
        self.odd[i].lab = ngui.find_label(_ui,"centre_other/animation/content/odd_num/kug"..i.."/lab_name");
    end
    self.even = {};
    self.even.root = _ui:get_child_by_name("centre_other/animation/content/even_num");
    for i=1,4 do
        local obj = _ui:get_child_by_name("centre_other/animation/content/even_num/kug"..i)
        self.even[i] = {};
        self.even[i].obj = UiSmallItem:new({obj=obj});
        self.even[i].lab = ngui.find_label(_ui,"centre_other/animation/content/even_num/kug"..i.."/lab_name");
    end

    self:UpdateUi();
end

function DayRewardUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) or not self.rewardList then return end;
    self.btnGet:set_active(self.canGet);
    self.btnGetGray:set_active(not self.canGet);
	local num = #self.rewardList;
	self.labRewardNum:set_text("奖励道具数:"..tostring(num));

    local list = nil;
    local isOdd = num%2==1;
    if isOdd then
        list = self.odd;
    else
        list = self.even;
    end
    self.odd.root:set_active(isOdd);
    self.even.root:set_active(not isOdd);
    for i=1,4 do
        if list[i] then
            local reward = self.rewardList[i];
            if reward then
                local item = nil;
                if PropsEnum.IsEquip(reward.id) then
                    item = CardEquipment:new({number=reward.id});
                else
                    item = CardProp:new({number=reward.id,count = reward.num});
                end
                list[i].obj:SetData(item);
                list[i].lab:set_text(item.name);
            else
                list[i].obj:SetData(nil);
                list[i].lab:set_text("");
            end
        end
    end
	-- for i=1,self.listMax do
	-- 	local reward = self.rewardList[i];
	-- 	if reward then
	-- 		self.rewards[i].all:set_active(true);
	-- 		local cfg = PublicFunc.IdToConfig(reward.id);
	-- 		self.rewards[i].name:set_text(tostring(cfg.name));
 --            item_manager.texturePadding(self.rewards[i].sp,cfg.small_icon)
	-- 		--self.iconPool:SetIcon(self.rewards[i].sp,reward.id);
	-- 		PublicFunc.SetIconFrameSprite(self.rewards[i].frame,cfg.rarity)
	-- 	else
	-- 		self.rewards[i].all:set_active(false);
	-- 	end
	-- end
end

function DayRewardUI:on_click(t)
    if self.canGet then
        Utility.CallFunc(self._resultCallback);
        self:on_back();
    else
    end
end

function DayRewardUI:on_back()
	uiManager:PopUi();
end

function DayRewardUI:Restart()
	UiBaseClass.Restart(self, data)
end

function DayRewardUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function DayRewardUI:Show()
    UiBaseClass.Show(self)
end

function DayRewardUI:Hide()
    UiBaseClass.Hide(self)
end



GaoSuJuJiItemUI = Class("GaoSuJuJiItemUI");
local DiffName = {
    [1] = "tujizhan_d1",
    [2] = "tujizhan_c1",
    [3] = "tujizhan_b1",
    [4] = "tujizhan_a1",
}

function GaoSuJuJiItemUI:Init(data)
	self.ui = data.ui;
	self.index = data.index;
	-- self.iconPool = data.atlas;
	self:InitUI();
end

function GaoSuJuJiItemUI:InitUI()
	self.labTitle = ngui.find_sprite(self.ui,"sp_title");
	-- self.spChose = ngui.find_sprite(self.ui,"sp_shine");
	-- self.spChose:set_active(false);

	self.labProgress = ngui.find_label(self.ui,"cont/txt_num");
	self.spGift = ngui.find_sprite(self.ui,"cont/sp_gift");
    self.spPassChapter = ngui.find_sprite(self.ui,"cont/sp_tongguan");
    self.spLose = ngui.find_sprite(self.ui,"cont/sp_back2");
    self.spMark = ngui.find_sprite(self.ui,"cont/sp_mark");
	self.spDown = ngui.find_sprite(self.ui,"cont/sp_back1");
    self.labDownDes = ngui.find_label(self.ui,"cont/txt");
    self.spDownMark = ngui.find_sprite(self.ui,"cont/sp");
    self.labDownMark = ngui.find_label(self.ui,"cont/sp/lab");

	self.spItem = {};
	for i=1,3 do
		self.spItem[i] = {};
		self.spItem[i].sp = ngui.find_sprite(self.ui,"sp_back1/sp"..i);
		self.spItem[i].pic = ngui.find_texture(self.ui,"sp_back1/sp"..i.."/texture_human");
        self.spItem[i].frame = ngui.find_sprite(self.ui,"sp_back1/sp"..i.."/sp_frame");
        local mark = ngui.find_sprite(self.ui,"sp_back1/sp"..i.."/sp_mark");
        mark:set_active(false);
		self.spItem[i].num = ngui.find_label(self.ui,"sp_back1/sp"..i.."/lab");
	end

	self.texture = ngui.find_texture(self.ui,"Texture");

	if self.index then
		self:UpdateUi();
	end
end

function GaoSuJuJiItemUI:SetIndex(index)
    self.index = index
    self:UpdateUi();
end

function GaoSuJuJiItemUI:SetChose(isChose)
    -- self.spChose:set_active(isChose);
end

function GaoSuJuJiItemUI:UpdateUi()
    if not self.index then return end;
	local config = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,self.index);
	self.labTitle:set_sprite_name(DiffName[self.index]);
    self.texture:set_texture(config.path);

    local me = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB-1+self.index;
    local hurdle_data = g_dataCenter.activity[me];
    local isFirstPass = hurdle_data:IsFirstPass();
    self.spDownMark:set_active(false);
    self.spMark:set_active(false);
    if hurdle_data:GetFightResult() == 0 then
    -- 完成
        -- self.spGift:set_active(true);
        -- self.spGift:set_sprite_name("")
        self.labProgress:set_active(false);
        -- self.labProgress:set_text("已通关");
        self.spPassChapter:set_active(true);
        self.spLose:set_active(false);
        self.spDown:set_active(false);
        self.isShowAwards = false;
        -- self.labDownDes:set_active(true);
        -- self.labDownMark:set_active(false);
    elseif hurdle_data:GetFightResult() == 1 then
    -- 失败
        self.labProgress:set_active(false);
        -- self.labProgress:set_text("挑战失败");
        self.spPassChapter:set_active(false);
        self.spLose:set_active(true);
        -- self.spMark:set_active(false);
        self.spDown:set_active(true);
        self.isShowAwards = true;
        -- self.labDownDes:set_active(true);
        -- self.labDownMark:set_active(false);
    elseif hurdle_data:GetFightResult() == 2 then
        -- if #hurdle_data.heroList == 0 then
        -- else
        -- 未完成
            local hurdle_id = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,self.index).level;
            local hurdle = ConfigHelper.GetHurdleConfig(hurdle_id);
            -- local hurdle_fs = _G["gd_fight_script_"..tostring(hurdle.fight_script)];
            local hurdle_fs = ConfigHelper.GetFightScript(hurdle.fight_script);
            local max_wave = #hurdle_fs.monster_wave_groud;
            self.labProgress:set_active(true);
            self.labProgress:set_text("当前进度："..tostring(hurdle_data.bigWave+1).."/"..tostring(max_wave));
            self.spPassChapter:set_active(false);
            self.spLose:set_active(false);
            -- self.spMark:set_active(false);
            self.spDown:set_active(true);
            self.isShowAwards = true;
            -- self.labDownDes:set_active(true);
            -- self.labDownMark:set_active(false);
        -- end
    elseif hurdle_data:GetFightResult() == 3 then
        -- 开启
            self.labProgress:set_active(false);
            self.spPassChapter:set_active(false);
            self.spLose:set_active(false);
            -- self.spMark:set_active(false);
            self.spDown:set_active(true);
            self.isShowAwards = true;
            -- self.labDownDes:set_active(true);
            -- self.labDownMark:set_active(false);
            -- self.labProgress:set_text("未挑战");
    else 
        -- 可扫荡
    end

    -- local hurdle = ConfigHelper.GetHurdleConfig(config.level);

    if isFirstPass == nil then
        --未打过
        self.labDownDes:set_text("首次通关奖励");
        self.spMark:set_active(false);
        self.spGift:set_active(false);
        local drop_id = config.first_award
        local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
        for i=1,3 do
            local drop = drop_list[i];
            if drop and drop ~= 0 then
                self.spItem[i].sp:set_active(true);
                local info = PublicFunc.IdToConfig(drop.goods_id);
                self.spItem[i].num:set_text("x"..tostring(drop.goods_number));
                self.spItem[i].pic:set_texture(info.small_icon);
            else
                self.spItem[i].sp:set_active(false);
            end
        end
    elseif isFirstPass == 0 then
        -- 打过未领取
        self.labDownDes:set_text("首次通关奖励");
        if hurdle_data:GetFightResult() <= 1 then
            self.spGift:set_active(true);
            self.spMark:set_active(true);
            self.spDown:set_active(true);
            self.isShowAwards = true;
        else
            self.spMark:set_active(false);
            self.spGift:set_active(false);
            self.spDown:set_active(false);
            self.isShowAwards = false;
        end
        local drop_id = config.first_award
        local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
        for i=1,3 do
            local drop = drop_list[i];
            if drop and drop ~= 0 then
                self.spItem[i].sp:set_active(true);
                local info = PublicFunc.IdToConfig(drop.goods_id);
                self.spItem[i].num:set_text("x"..tostring(drop.goods_number));
                self.spItem[i].pic:set_texture(info.small_icon);
            else
                self.spItem[i].sp:set_active(false);
            end
        end
        -- self.spGift:set_sprite_name();
        -- self.spDown:set_active(true);
    elseif isFirstPass == 1 then
        self.labDownDes:set_text("今日通关奖励");
        -- 打过并领取
        self.spGift:set_active(false);
        -- self.spGift:set_sprite_name();
        -- self.spDown:set_active(true);
        local drop_id = config.bigwave_5
        local drop_list1 = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
        drop_id = config.smallwave_5
        local drop_list2 = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
        local drop_list = {};
        for i=#drop_list2,1,-1 do
            table.insert(drop_list,drop_list2[i]);
        end
        for i=#drop_list1,1,-1 do
            table.insert(drop_list,drop_list1[i]);
        end
        local num = #drop_list;
        for i=1,3 do
            local drop = drop_list[num-i+1];
            if drop and drop ~= 0 then
                self.spItem[i].sp:set_active(true);
                local info = PublicFunc.IdToConfig(drop.goods_id);
                self.spItem[i].num:set_text("x"..tostring(drop.goods_number));
                self.spItem[i].pic:set_texture(info.small_icon);
            else
                self.spItem[i].sp:set_active(false);
            end
        end
        local lv = g_dataCenter.player.vip;

        local gaosujujisweep = 0;
        local vip_data = g_dataCenter.player:GetVipData();
        if vip_data then
            gaosujujisweep = vip_data.gaosujuji_sweep;
        end

        if self.index <= gaosujujisweep then
            self.spGift:set_active(true);
            self.spMark:set_active(true);
            self.spDown:set_active(true);
            self.isShowAwards = true;
        else
            self.spGift:set_active(false);
            self.spMark:set_active(false);
            self.spDown:set_active(false);
            self.isShowAwards = false;
        end
    end

    local last_hurdle_data = g_dataCenter.activity[me-1];
    if last_hurdle_data then
        -- if last_hurdle_data:IsFirstPass() == nil then
        if last_hurdle_data:GetFightResult() ~= 0 then
            self.spMark:set_active(true);
            self.spDownMark:set_active(true);
            self.labDownMark:set_text("未开启");
        end
    end
end

function GaoSuJuJiItemUI:Show(is_show)
	self.ui:set_active(is_show);
end

function GaoSuJuJiItemUI:Destroy()
    self.ui = nil;
    self.labTitle = nil;
    if self.texture then
        self.texture:Destroy();
        self.texture  = nil;
    end
    self.labProgress = nil;
    self.spGift = nil;
    self.spPassChapter = nil;
    self.spLose = nil;
    self.spMark = nil;
    self.spDown = nil;
    self.labDownDes = nil;
    self.spDownMark = nil;
    self.labDownMark = nil;
    for k,v in pairs(self.spItem) do
        v.pic:Destroy();
        v.pic = nil;
    end
    self.spItem = nil;
end

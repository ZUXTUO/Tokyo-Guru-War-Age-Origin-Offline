
GaoSuJuJiUI = Class('GaoSuJuJiUI', UiBaseClass)


local resPath = 'assetbundles/prefabs/ui/wanfa/defense_house/ui_1001_lue_duo_wu_zi.assetbundle';

local diffSpriteName = 
{
    [1] = "tujizhan_d1",
    [2] = "tujizhan_c1",
    [3] = "tujizhan_b1",
    [4] = "tujizhan_a1",
    [5] = "tujizhan_c1",
    [6] = "tujizhan_d1",
    [7] = "tujizhan_b1",
}

local uiText = 
{
    [1] = '推倒前一难度并达到%d级';
}

function GaoSuJuJiUI:Init(data)
	self.pathRes = resPath
    UiBaseClass.Init(self, data);
end

function GaoSuJuJiUI:Restart(data)

    self.itemTextures = {}
--    self.shineSprites = {}
    self.smallItms = {}

    UiBaseClass.Restart(self, data)
end

function GaoSuJuJiUI:DestroyUi()
    UiBaseClass.DestroyUi(self)

    if self.itemTextures then
        for k,v in pairs(self.itemTextures) do
            v.tex:Destroy()
        end
        self.itemTextures = nil
    end

    if self.smallItms then
        for k,v in pairs(self.smallItms) do
            for ik,iv in pairs(v) do
                iv:DestroyUi()
            end
            
        end
        self.smallItms = nil
    end
    

--    self.shineSprites = nil

--    self.currentSelectName = nil
--    self.currentSelectIndex = nil
end

function GaoSuJuJiUI:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['OnInitItem'] = Utility.bind_callback(self, self.OnInitItem);
    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
    self.bindfunc['OnClickRuleBtn'] = Utility.bind_callback(self, self.OnClickRuleBtn);
    self.bindfunc['OnClickStartBtn'] = Utility.bind_callback(self, self.OnClickStartBtn);
--    self.bindfunc['OnClickItemBtn'] = Utility.bind_callback(self, self.OnClickItemBtn);
end

function GaoSuJuJiUI:MsgRegist()
    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
end

function GaoSuJuJiUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(player.gc_update_player_exp_level, self.bindfunc['UpdateUi'])
end

function GaoSuJuJiUI:OnClickRuleBtn()
    UiRuleDes.Start(ENUM.ERuleDesType.BaoWeiZhan)
end

function GaoSuJuJiUI:OnClickStartBtn(param)
        
        GLoading.Show(GLoading.EType.msg)
        
        local index = param.float_value

        app.log('OnClickStartBtn index == ' .. index)

        local hurdleid = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,index).level;
        local defTeam = g_dataCenter.player:GetDefTeam()

        local playid = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi
        local fs = g_dataCenter.activity[playid];
        fs:SetLevelIndex(hurdleid)
        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
        fs:SetPlayMethod(playid)

        --{关卡id,难度}
        --msg_activity.cg_enter_activity(playid , {tostring(hurdleid), tostring(index)})

--    if self.currentSelectIndex ~= nil then
--        if self.currentSelectIndex > 0 and self.currentSelectIndex < 5 then
--            local hurdleid = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,self.currentSelectIndex).level;
--            local defTeam = g_dataCenter.player:GetDefTeam()

--            local playid = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi
--            local fs = g_dataCenter.activity[playid];
--            fs:SetLevelIndex(hurdleid)
--            fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
--            fs:SetPlayMethod(playid)

--            --{关卡id,难度}
--            msg_activity.cg_enter_activity(playid , {tostring(hurdleid), tostring(self.currentSelectIndex)})
--        else
--            app.log("GaoSuJuJiUI diff index error: " .. tostring(self.currentSelectIndex))
--        end
--    else
--        HintUI.SetAndShow(EHintUiType.zero,"请选择一个难度");
--    end
end

--function GaoSuJuJiUI:OnClickItemBtn(param)

--    local diff  = param.float_value
--    if self:DiffIsOpen(diff) == false then
--        return
--    end

--    if self.currentSelectName ~= nil and self.shineSprites[self.currentSelectName] then
--        self.shineSprites[self.currentSelectName]:set_active(false)
--    end

--    local name = param.game_object:get_name()
--    self.currentSelectName = name
--    self.shineSprites[self.currentSelectName]:set_active(true)

--    self.currentSelectIndex = diff


--end

function GaoSuJuJiUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
    self.ui:set_name("ui_gao_su_ju_ji")

    self.wrapContent = ngui.find_wrap_content(self.ui, 'wrap_concent');
    self.wrapContent:set_on_initialize_item(self.bindfunc["OnInitItem"]);

--    local txt = ngui.find_label(self.ui, 'lab_title')
--    txt:set_text('保卫战')
    local txt = ngui.find_label(self.ui, 'sp_title/txt')
    txt:set_text(gs_misc['bao_wei_zhan_description'])

--    local btn = ngui.find_button(self.ui, 'btn_rule')
--    btn:set_on_click(self.bindfunc['OnClickRuleBtn'])

    self.curTimes, self.totalTimes = GaoSuJuJiSimple.GetFightTimes()

    local label = ngui.find_label(self.ui, 'sp_di/txt')
    label:set_text(string.format('今天剩余次数:%d/%d', (self.totalTimes-self.curTimes), self.totalTimes))

--    local btnNormalStart = ngui.find_button(self.ui, 'btn_start')
--    local btnGrayStart = ngui.find_button(self.ui, 'btn_start_gray')
--    if self.curTimes >= self.totalTimes then
--        btnNormalStart:set_active(false)
--        btnGrayStart:set_active(true)
--    else
--        btnNormalStart:set_active(true)
--        btnGrayStart:set_active(false)

--        btnNormalStart:set_on_click(self.bindfunc['OnClickStartBtn'])
--    end

    self:UpdateUi()
end

function GaoSuJuJiUI:UpdateUi()

    local diffCount = ConfigManager.GetDataCount(EConfigIndex.t_gao_su_ju_ji_hurdle) 

    self.wrapContent:set_min_index(0)
    self.wrapContent:set_max_index(diffCount - 1)
    self.wrapContent:reset()
end

function GaoSuJuJiUI:DiffIsOpen(diff)
    local config = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,diff);
    local openLevel = 1 --
    local hurdle = ConfigHelper.GetHurdleConfig(config.level)
    if hurdle then
        openLevel = hurdle.need_level
    end

    local preDiffPass = true
    if diff > 1 then
		preDiffPass = false;
		local flagHelper = g_dataCenter.player:GetFlagHelper();
		if flagHelper then
			local flagInfo = flagHelper:GetNumberFlag(MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi);
			--上一难度完成的话
			if flagInfo and PublicFunc.GetBitValue(flagInfo, diff-1) > 0 then
				preDiffPass = true;
			end
		end
	end

    return g_dataCenter.player:GetLevel() >= openLevel and preDiffPass, openLevel
end

function GaoSuJuJiUI:OnInitItem(obj,b,real_id)
    --app.log('GaoSuJuJiUI:OnInitItem  ' .. tostring(real_id))
    local index = math.abs(real_id) + 1
    local config = ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,index);

    local isOpen, openLevel = self:DiffIsOpen(index)
    local openNode = obj:get_child_by_name("cont")
    local closeLabel = ngui.find_label(obj, 'txt')
    local closeTitle = obj:get_child_by_name('sp_title')
    local itemName = obj:get_name()

    local cacheTex = self.itemTextures[itemName]
    local needSet = false
    if cacheTex == nil then
        cacheTex = {}
        self.itemTextures[itemName] = cacheTex
        needSet = true;
    else
        if cacheTex.path ~= config.path then
            cacheTex.tex:Destroy()
            needSet = true
        end
    end
    if needSet then
        cacheTex.path = config.path
        cacheTex.tex = ngui.find_texture(obj, "texture");
        cacheTex.tex:set_texture(config.path);
    end

    local sp = ngui.find_sprite(obj, 'sp_effect')
    local spriteName = diffSpriteName[index]
    if spriteName then
        sp:set_sprite_name(spriteName)
    end

    if isOpen then
        openNode:set_active(true)
        closeLabel:set_active(false)
        closeTitle:set_active(false)

        --设置奖励
        local sis = self.smallItms[itemName]
        if sis == nil then
            sis = {}
            self.smallItms[itemName] = sis
        end
        local award = config.win_award
        for i = 1,#award do
            local si = sis[i]

            local siParent = obj:get_child_by_name('new_small_card_item' .. tostring(i))
            siParent:set_active(true)

            if si == nil then
                if siParent ~= nil then
                    si = UiSmallItem:new({obj = nil, parent = siParent, cardInfo = nil})
                    sis[i] = si
                end
            end
            if si then
                si:SetDataNumber(award[i][1], award[i][2])
            end
        end
        
        --设置事件监听
        local btn = ngui.find_button(obj, 'btn2')
        btn:reset_on_click()
        btn:set_event_value("", index)
        btn:set_on_click(self.bindfunc['OnClickStartBtn'])

        sp:set_color(1, 1, 1, 1)
        cacheTex.tex:set_color(1, 1, 1, 1)
    else
        openNode:set_active(false)
        closeLabel:set_active(true)
        closeTitle:set_active(true)
        local lab = ngui.find_label(closeTitle, 'lab')
        lab:set_text(string.format(uiText[1], openLevel))

        sp:set_color(0, 0, 0, 1)
        cacheTex.tex:set_color(0, 0, 0, 1)

        for i=1,2 do
            local siParent = obj:get_child_by_name('new_small_card_item' .. tostring(i))
            siParent:set_active(false)
        end
    end

--    self.shineSprites[itemName] = ngui.find_sprite(obj, 'sp_shine')
--    self.shineSprites[itemName]:set_active(false)

--    local btn = ngui.find_button(obj, itemName)
--    btn:reset_on_click()
--    btn:set_event_value("", index)
--    btn:set_on_click(self.bindfunc['OnClickItemBtn'])
end

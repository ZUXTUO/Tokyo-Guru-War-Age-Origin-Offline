UiLevel = Class('UiLevel', MultiResUiBaseClass);

local max_level = 7;
local max_level_star = 3;
-- 领取章节奖励错误码
local level_award_enum =
{
    Success = 0,
    AlreadyGet = 1,
    NotCondition = 2,
    NoAward = 3,
}

g_open_level_count = 24;

--页签所对应的关卡数量以及章节奖励数量
local maxBoxCount = {[0]=3, [1]=1}
local maxHurdleCount = {[0]=7, [1]=4};
-- function UiLevel:GetNavigationTitle()
--     local title = ""
--     if self.selectTab == EHurdleType.eHurdleType_normal then
--         title = "主线关$1卡$1"
--     elseif self.selectTab == EHurdleType.eHurdleType_elite then
--         title = "精英关$2卡$2"
--     end
--     return title;
-- end
local resType = 
{
    Item = 1,
    Back = 2,
}
local resPaths = 
{
    [resType.Item] = 'assetbundles/prefabs/ui/level/level_line_item.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/level/ui_701_level.assetbundle';
}

local s_reloadPath = 
{
    "hurdle/",
    "monster_property/",
}
local s_allReloadFile = 
{

}
local function GetReloadFile()
    if s_allReloadFile[1] == nil then
        --[[
        for k, v in pairs(EConfigIndex) do
            for m, n in pairs(s_reloadPath)  do
                if string.find(v, n) then
                    table.insert(s_allReloadFile, tostring(k));
                    break;
                end
            end
        end
        --]]
    end
    return s_allReloadFile;
end

 function G_ReloadConfig()
    local t = GetReloadFile();
    -- local t = {"t_hurdle"};
    -- app.log("........"..table.tostring(t))
    for k, v in pairs(t) do
        ConfigManager.ReloadConfig(v);
    end
end


-- 初始化
function UiLevel:Init(data)
    self.pathRes = resPaths;
    MultiResUiBaseClass.Init(self, data)
end

-- 重新开始
function UiLevel:Restart(data)
    if data then
        self.goLevel = data.goLevel;
        self.goLevelChallenge = data.goLevelChallenge;
        self.goSelectTab = data.goSelectTab;
        self.goGoodsId = data.goodsId;
        self.goGoodsCount = data.goodsCount;
    end
    self.selectTab = EHurdleType.eHurdleType_normal;
    self.sectionList = {};
    --重新加载配置
    if PublicStruct.ShuZhiCeShi then
        G_ReloadConfig();
    end
    MultiResUiBaseClass.Restart(self, data)
end
-- 析构函数
function UiLevel:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self)
    if uiManager:GetNavigationBarUi() then
        uiManager:GetNavigationBarUi():SetHurdleElite(false);
    end
    self.curLevel = nil;
    self.goLevel = nil;
    self.goGoodsId = nil;
    self.goGoodsCount = nil;
    self.cloneLevelHead = nil;
    self.cloneGroupItem = nil;
    self.cloneLevelBox = nil;
    --清除texture
    -- for k,v in pairs(self.groupList) do
    --     if v.textureHead then
    --         v.textureHead:Destroy();
    --     end
    -- end
    -- self.groupList = {};
    if self.textureObj then
        self.textureObj:Destroy();
    end
    if self.allHead then
        for k, v in pairs(self.allHead) do
            if v.textureItem then
                v.textureItem:Destroy();
            end
        end
        self.allHead = nil;
    end
    if self.allFirstPassHead then
        for k, v in pairs(self.allFirstPassHead) do
            v:DestroyUi();
        end
        self.allFirstPassHead = nil;
    end
    if self.itemGroupAwards then
        self.itemGroupAwards:DestroyUi();
        self.itemGroupAwards = nil;
    end

    self.allBox = nil;
    self.allHurdleLineList = nil;
    self:ClearStarAnim();
    PublicFunc.ClearUserDataRef(self)
    --uiManager:GetNavigationBarUi():SetBkTexture('assetbundles/prefabs/ui/image/backgroud/dao_hang_tiao/dh_beijing.assetbundle')
end

-- 注册回调函数
function UiLevel:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self)
    self.bindfunc['OnClickHurdleBox'] = Utility.bind_callback(self, UiLevel.OnClickHurdleBox);
    self.bindfunc['OnClickHurdle'] = Utility.bind_callback(self, UiLevel.OnClickHurdle);
    self.bindfunc['OnClickHurldeType'] = Utility.bind_callback(self, UiLevel.OnClickHurldeType);
    self.bindfunc['OnClickGroupAwards'] = Utility.bind_callback(self, UiLevel.OnClickGroupAwards);
    -- self.bindfunc['OnInitItem'] = Utility.bind_callback(self, UiLevel.OnInitItem);
    -- self.bindfunc['OnClickGroup'] = Utility.bind_callback(self, UiLevel.OnClickGroup);
    self.bindfunc['OnEnterFight'] = Utility.bind_callback(self, UiLevel.OnEnterFight);
    self.bindfunc['OnLevelUp'] = Utility.bind_callback(self, UiLevel.OnLevelUp);
    self.bindfunc['OnToggle'] = Utility.bind_callback(self, UiLevel.OnToggle);
    self.bindfunc['OnPreGroup'] = Utility.bind_callback(self, UiLevel.OnPreGroup);
    self.bindfunc['OnNextGroup'] = Utility.bind_callback(self, UiLevel.OnNextGroup);
    self.bindfunc['UpdateLevel'] = Utility.bind_callback(self, UiLevel.UpdateLevel);
    self.bindfunc['UpdateSection'] = Utility.bind_callback(self, UiLevel.UpdateSection);
    self.bindfunc['OpenNewGroupAnimation'] = Utility.bind_callback(self, UiLevel.OpenNewGroupAnimation);
end

-- 消息注册
function UiLevel:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_hurdle.gc_hurdle_fight, self.bindfunc['OnEnterFight']);
    PublicFunc.msg_regist(msg_hurdle.gc_hurlde_box, self.bindfunc['UpdateLevel']);
    PublicFunc.msg_regist(msg_hurdle.gc_take_award, self.bindfunc['UpdateSection']);
    PublicFunc.msg_regist(msg_hurdle.gc_open_new_group_animation, self.bindfunc['OpenNewGroupAnimation']);
    NoticeManager.BeginListen(ENUM.NoticeType.PlayerLevelUp, self.bindfunc["OnLevelUp"])
end

function UiLevel:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_hurdle.gc_hurdle_fight, self.bindfunc['OnEnterFight']);
    PublicFunc.msg_unregist(msg_hurdle.gc_hurlde_box, self.bindfunc['UpdateLevel']);
    PublicFunc.msg_unregist(msg_hurdle.gc_take_award, self.bindfunc['UpdateSection']);
    PublicFunc.msg_unregist(msg_hurdle.gc_open_new_group_animation, self.bindfunc['OpenNewGroupAnimation']);
    NoticeManager.EndListen(ENUM.NoticeType.PlayerLevelUp, self.bindfunc["OnLevelUp"])
end

-- 初始化UI
function UiLevel:OnLoadUI()
    local level = g_dataCenter.hurdle;
    for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
        self.sectionList[i] = level:GetSortSection(i);
    end

    ----------------Begin:新手引导-----------------------
    if GuideManager.IsGuideRuning() then
        if GuideManager.GetGuideHurdleId() > 0 then
            self.goLevel = GuideManager.GetGuideHurdleId()
        end
    --检查有无等级触发的引导，等级触发优先执行         
    elseif not GuideManager.IsWaitBackToCity() then
        local lastPassedHurdleId = g_dataCenter.hurdle:GetMaxFightLevel(EHurdleType.eHurdleType_normal) or 0
        if lastPassedHurdleId > 0 then
            GuideManager.Trigger(GuideManager.GuideType.HurdlePassed, lastPassedHurdleId)
        end
        if not GuideManager.IsGuideRuning() then 
            lastPassedHurdleId = g_dataCenter.hurdle:GetMaxFightLevel(EHurdleType.eHurdleType_elite) or 0
            if lastPassedHurdleId > 0 then
                GuideManager.Trigger(GuideManager.GuideType.HurdlePassed, lastPassedHurdleId)
            end
        end
        if GuideManager.GetGuideHurdleId() > 0 then
            self.goLevel = GuideManager.GetGuideHurdleId()
        end
    --重叠引导，直接打点完成（HurdlePassed触发类型：目前就是首充引导）
    else
        local lastPassedHurdleId = g_dataCenter.hurdle:GetMaxFightLevel(EHurdleType.eHurdleType_normal) or 0
        if lastPassedHurdleId > 0 then
            local id = GuideManager.CheckHurdlePassed(lastPassedHurdleId)
            if id then
                GuideManager.DoneGuide({id});
            end
        end
    end
    ----------------End:新手引导-----------------------
    app.log(tostring(self.goLevel)..".."..tostring(self.goLevelChallenge)
         ..".."..tostring(self.fightLevel)..".."..tostring(self.fightSelectTab)..".."
         ..tostring(self.curLevel))
    -- 任务跳转关卡
    if self.goLevel then
        local levelInfo = ConfigHelper.GetHurdleConfig(self.goLevel);
        self.curSection = level:SectionIdToIndex(levelInfo.groupid);
        self.curLevel = self.goLevel;
        --self.selectTab = levelInfo.hurdle_type;
    --获取途径跳到打关卡界面
    elseif self.goLevelChallenge then
        local levelInfo = ConfigHelper.GetHurdleConfig(self.goLevelChallenge);
        self.curSection = level:SectionIdToIndex(levelInfo.groupid);
        self.curLevel = self.goLevelChallenge;
        --self.selectTab = levelInfo.hurdle_type;
    elseif self.goSelectTab then
        self.selectTab = self.goSelectTab;
        local curGroup = level:GetCurGroup(self.selectTab);
        self.curSection = level:SectionIdToIndex(curGroup);
        self.curLevel = level:GetCurFightLevelID(curGroup);
        self.goSelectTab = nil;
    --战斗后回来 且关卡不是最大可玩关卡
    elseif self.fightLevel then
        local levelInfo = ConfigHelper.GetHurdleConfig(self.fightLevel);
        self.curSection = level:SectionIdToIndex(levelInfo.groupid);
        self.curLevel = self.fightLevel;
        --self.selectTab = levelInfo.hurdle_type;
        self.fightLevel = nil;
        self.fightSelectTab = nil;
    --战斗后回来
    elseif self.fightSelectTab then
        self.selectTab = self.fightSelectTab;
        self.fightSelectTab = nil;
        local curGroup = level:GetCurGroup(self.selectTab);
        self.curSection = level:SectionIdToIndex(curGroup);
        self.curLevel = level:GetCurFightLevelID(curGroup);
    -- 正常进入关卡
    elseif self.curLevel == nil then
        local curGroup = level:GetCurGroup(self.selectTab);
        self.curSection = level:SectionIdToIndex(curGroup);
        self.curLevel = level:GetCurFightLevelID(curGroup);
        --app.log("........"..tostring(self.curSection).."  "..tostring(self.curLevel).." "..tostring(curGroup))
        local levelInfo = ConfigHelper.GetHurdleConfig(self.curLevel);
        if levelInfo == nil then
            app.log(
                "selectTab="..tostring(self.selectTab).." curGroup="..tostring(curGroup).." curSection="..
                tostring(self.curSection).." curLevel="..tostring(self.curLevel)..table.tostring(level.curGroup))
        end
        --self.selectTab = levelInfo.hurdle_type;
    else
        local levelInfo = ConfigHelper.GetHurdleConfig(self.curLevel);
        self.curSection = level:SectionIdToIndex(levelInfo.groupid);
        --self.selectTab = levelInfo.hurdle_type;
    end
    --[[
    if self.curSection > g_open_level_count then
        self.curSection = g_open_level_count;
        local sectionInfo = self.sectionList[self.selectTab][self.curSection];
        self.curLevel = level:GetCurFightLevelID(sectionInfo.id);
    end
    --]]
    app.log("selectTab="..tostring(self.selectTab).." curGroup="..tostring(curGroup).." curSection="..
                tostring(self.curSection).." curLevel="..tostring(self.curLevel))
    -- 先加载章节底图
    local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    local sectionConfig = ConfigManager.Get(EConfigIndex.t_hurdle_group,sectionInfo.id);
    if sectionConfig then
       MultiResUiBaseClass.PreLoadTexture(sectionConfig.bk, Root.empty_func);
    end
end

function UiLevel:GetSectionInfo()
    local hurdle = ConfigHelper.GetHurdleConfig(60001154);
    local hurdleConfig = ConfigManager.Get(EConfigIndex.t_hurdle_group,hurdle.groupid);
    return hurdleConfig
end

-- 寻找ngui对象
function UiLevel:InitedAllUI()
    self.ui = self.uis[resPaths[resType.Back]];
    self.ui:set_name('ui_701_level');
    self.ui:set_local_scale(1, 1, 1);
    --uiManager:GetNavigationBarUi():SetBkTexture('assetbundles/prefabs/ui/image/backgroud/guan_ka/gk_bg1.assetbundle')
    --章节列表
    local obj = self.ui:get_child_by_name("top_other");
    -- self.wrap_content = ngui.find_enchance_scroll_view(obj, 'panel_list');
    -- self.wrap_content:set_on_initialize_item(self.bindfunc['OnInitItem']);
    self.spGroupDi = ngui.find_sprite(obj, "sp");
    self.labGroup = ngui.find_label(obj, "lab2");
    self.labGroupContent = ngui.find_label(obj, "lab1");
    self.spGroupAwards = ngui.find_sprite(obj, "sp_liebiao");
    self.labGroupAwards = ngui.find_label(obj, "lab_jiesuo");
    self.objGroupAwards = obj:get_child_by_name("new_small_card_item");

    --克隆项目
    obj = self.ui:get_child_by_name("right_other");
    self.cloneLevelHead = ngui.find_button(obj, "level_content"):get_game_object();
    self.cloneLevelHead:set_active(false);
    self.cloneLevelBox = ngui.find_button(obj, "btn_box"):get_game_object();
    self.cloneLevelBox:set_active(false);
    --加载线路图
    obj = obj:get_child_by_name("animation");
    self.levelItem = self.uis[resPaths[resType.Item]];
    self.levelItem:set_parent(obj);
    self.levelItem:set_local_scale(1, 1, 1);
    --关卡列表
    self.hurdleTypeList = {};
    --章节奖励
    obj = self.ui:get_child_by_name("down_other");
    --活动额外掉落
    self.spExtraActivity = obj:get_child_by_name("cont2");
    self.labExtraActivity = ngui.find_label(self.spExtraActivity, "txt");
    if self.labExtraActivity then
        self.labExtraActivity:set_text("今日额外掉落活动道具");
    end

    self.groupAwardList = {};
    self.groupAwardList.objRoot = obj:get_child_by_name("cont1");
    -- self.groupAwardList["pro"] = ngui.find_progress_bar(self.groupAwardList.objRoot, "pro_bar");
    self.groupAwardList["grid"] = ngui.find_grid(self.groupAwardList.objRoot, "grid");
    self.groupAwardList["star"] = ngui.find_label(obj, "cont_star/lab");
    for i = 1, 3 do
        self.groupAwardList["boxBtn"..i] = ngui.find_button(self.groupAwardList.objRoot, "btn_box"..i);
        self.groupAwardList["boxBtn"..i]:set_on_click(self.bindfunc["OnClickGroupAwards"]);
        self.groupAwardList["boxSp"..i] = ngui.find_sprite(self.groupAwardList.objRoot, "btn_box"..i.."/sp");
        self.groupAwardList["boxStaticSp"..i] = ngui.find_sprite(self.groupAwardList.objRoot, "btn_box"..i.."/sp_box");
        self.groupAwardList["boxPoint"..i] = ngui.find_sprite(self.groupAwardList.objRoot, "btn_box"..i.."/sp/sp_point");
        self.groupAwardList["boxPoint"..i]:set_active(false);
        self.groupAwardList["boxStar"..i] = ngui.find_label(self.groupAwardList.objRoot, "btn_box"..i.."/sp_di/lab_num");
    end
    --页签
    self.panelSelect = self.ui:get_child_by_name("right_down_other");
    -- self.toggleSelect = ngui.find_toggle(self.panelSelect, "animation");
    -- self.toggleSelect:set_on_change(self.bindfunc["OnToggle"]);
    -- self.toggleFirst = true;
    self.animBtn = self.panelSelect:get_child_by_name("animation");
    if self.selectTab == EHurdleType.eHurdleType_elite then
        self.animBtn:animated_play("guanka_change");
    end
    --精英普通按钮设置初始状态
    -- self.toggleSelect:set_value(self.selectTab == EHurdleType.eHurdleType_elite);

    -- self.spDi = self.panelSelect:get_child_by_name("sp_di");
    self.btnNormal = ngui.find_button(self.animBtn, "yeka_putong_liang");
    self.btnNormal:set_event_value(tostring(EHurdleType.eHurdleType_normal), 0);
    self.btnNormal:set_on_click(self.bindfunc["OnClickHurldeType"]);
    self.btnElite = ngui.find_button(self.animBtn, "yela_jingying_an");
    self.btnElite:set_event_value(tostring(EHurdleType.eHurdleType_elite), 0);
    self.btnElite:set_on_click(self.bindfunc["OnClickHurldeType"]);
    
    self.spNormalBtn = ngui.find_sprite(self.panelSelect, "yeka_putong_liang/sp");
    self.spNormalBtnPoint = ngui.find_sprite(self.panelSelect, "yeka_putong_liang/sp_point");
    -- self.spNormalBtnWord = ngui.find_sprite(self.panelSelect, "yeka_putong_liang/sp_art_font");
    self.spEliteBtn = ngui.find_sprite(self.panelSelect, "yela_jingying_an/sp");
    self.spEliteBtnPoint = ngui.find_sprite(self.panelSelect, "yela_jingying_an/sp_point");
    -- self.spEliteBtnWord = ngui.find_sprite(self.panelSelect, "yela_jingying_an/sp_art_font");
    -- self.spEliteMark = ngui.find_sprite(self.panelSelect, "yela_jingying_an/sp_mark");
    self.spEliteEmpty = ngui.find_sprite(self.panelSelect, "sp_empty");
    self.animElite = self.panelSelect:get_child_by_name("fx_ui_701_level_fire");
    self.animElite:set_active(self.selectTab == EHurdleType.eHurdleType_elite);
    --章节变动
    obj = self.ui:get_child_by_name("centre_other");
    self.btnLeftArrow = ngui.find_button(obj, "btn_left_arrows");
    self.btnLeftArrow:set_on_click(self.bindfunc["OnPreGroup"],"MyButton.NoneAudio");
    self.btnLeftPoint = ngui.find_sprite(obj, "btn_left_arrows/animation/sp_point");
    self.btnRightArrow = ngui.find_button(obj, "btn_right_arrows");
    self.btnRightArrow:set_on_click(self.bindfunc["OnNextGroup"],"MyButton.NoneAudio");
    self.btnRightPoint = ngui.find_sprite(obj, "btn_right_arrows/animation/sp_point");

    --底图
    self.textureObj = ngui.find_texture(self.ui, "texture_bk");
    self:UpdateUi();
    if g_dataCenter.shopInfo:IsShowPopup() then
        g_dataCenter.shopInfo:SetShowPopup(false)
        MysteryShopPopupUI.ShowPopup() 
    end
end
-- 更新ui
function UiLevel:UpdateUi()
    --app.log(tostring(self.curSection)..".."..tostring(self.curLevel)..debug.traceback())
    if not MultiResUiBaseClass.UpdateUi(self) then return end
    local level = g_dataCenter.hurdle;
    --如果是要播动画的话   就发消息
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if sectionInfo.id == level:GetGroupAnimId(self.selectTab) then
        msg_hurdle.cg_open_new_group_animation(self.selectTab);
    end
    -- 章节列表
    local isOpen = level:IsEliteOpen();
    if isOpen then
        -- self.spEliteMark:set_active(false);
        self.spEliteEmpty:set_active(false);
        self.spEliteBtn:set_color(1, 1, 1, 1);
        -- self.spEliteBtnWord:set_color(1, 1, 1, 1);
    else
        -- self.spEliteMark:set_active(true);
        self.spEliteEmpty:set_active(true);
        self.spEliteBtn:set_color(0, 0, 0, 1);
        -- self.spEliteBtnWord:set_color(0, 0, 0, 1);
    end
    
    if self.selectTab == EHurdleType.eHurdleType_normal then
        self.spNormalBtn:set_sprite_name("gq_yeqian_pt1");
        self.spNormalBtn:set_depth(130);
        -- self.spNormalBtnWord:set_sprite_name("gq_yeqian_pt3");
        -- self.spNormalBtnWord:set_depth(320);
        self.spEliteBtn:set_sprite_name("gq_yeqian_jy2");
        self.spEliteBtn:set_depth(120);
        -- self.spEliteBtnWord:set_sprite_name("gq_yeqian_jy4");
        -- self.spEliteBtnWord:set_depth(310);
    else
        self.spNormalBtn:set_sprite_name("gq_yeqian_pt2");
        self.spNormalBtn:set_depth(120);
        -- self.spNormalBtnWord:set_sprite_name("gq_yeqian_pt4");
        -- self.spNormalBtnWord:set_depth(310);
        self.spEliteBtn:set_sprite_name("gq_yeqian_jy1");
        self.spEliteBtn:set_depth(130);
        -- self.spEliteBtnWord:set_sprite_name("gq_yeqian_jy3");
        -- self.spEliteBtnWord:set_depth(320);
    end

    if uiManager:GetNavigationBarUi() then
        uiManager:GetNavigationBarUi():SetHurdleElite(self.selectTab == EHurdleType.eHurdleType_elite);
    end

    if AppConfig.get_enable_guide_tip() then
        self.spNormalBtnPoint:set_active(PublicFunc.ToBoolTip(level:IsHurdleTypeNotGetBoxAwards(EHurdleType.eHurdleType_normal)));
        self.spEliteBtnPoint:set_active(PublicFunc.ToBoolTip(level:IsHurdleTypeNotGetBoxAwards(EHurdleType.eHurdleType_elite)));
    end

    if self.spExtraActivity then
        self.spExtraActivity:set_active(g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_hurdle_extra_produce));
    end

    self:UpdateSection();

end

-- 延迟在下一帧跳转下个界面
function UiLevel:Update(dt)
    MultiResUiBaseClass.Update(self,dt);
    --跳到打关卡界面
    if self.goLevelChallenge then
        self.goLevelChallenge = nil;
        self:OnClickHurdle({string_value=self.curLevel});
    end
end
-- 更新章节
function UiLevel:UpdateSection()
    if self.ui == nil then
        return;
    end
    local level = g_dataCenter.hurdle;
    local maxSection = level:SectionIdToIndex(level:GetCurGroup(self.selectTab));
    --if maxSection > g_open_level_count then
    --    maxSection = g_open_level_count;
    --end

    g_open_level_count = maxSection;
    local groupAwardList = self.groupAwardList;
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if sectionInfo == nil then
        return;
    end
    -- app.log("curSection="..tostring(self.curSection)..debug.traceback());
    -- 章节信息
    if self.selectTab == EHurdleType.eHurdleType_elite then
        -- self.spGroupDi:set_sprite_name("gq_biaoti2");
        self.labGroup:set_text(tostring(sectionInfo.chapter_num));
        self.labGroupContent:set_text(tostring(sectionInfo.chapter));
        -- self.labGroupContent:set_color(1, 0, 0, 1);
    else
        -- self.spGroupDi:set_sprite_name("gq_biaoti1");
        self.labGroup:set_text(tostring(sectionInfo.chapter_num));
        self.labGroupContent:set_text(tostring(sectionInfo.chapter));
        -- self.labGroupContent:set_color(0, 0, 1, 1);
    end
    
    -- 章节底图
    local sectionConfig = ConfigManager.Get(EConfigIndex.t_hurdle_group,sectionInfo.id);
    if sectionConfig and self.textureObj then
        self.textureObj:set_texture(sectionConfig.bk);
    end
    -- 章节奖励
    local starNumber = level:GetGroupStarNum(sectionInfo.id);
    -- app.log("id="..sectionInfo.id.."   starNumber="..starNumber);
    groupAwardList.star:set_text(tostring(starNumber))-- .. "/" .. tostring(sectionInfo.max_star));
    -- groupAwardList.pro:set_value(starNumber/sectionInfo.max_star);
    local index = 3;
    if self.selectTab == EHurdleType.eHurdleType_elite then
        index = 1;
    end
    local notGroupAwards = false;
    for i = 1, 3 do
        if i > maxBoxCount[self.selectTab] or type(sectionInfo["award"..index.."_star"]) ~= "number" or sectionInfo["award"..index.."_star"] <= 0 then
            groupAwardList["boxBtn"..i]:set_active(false);
        else
            notGroupAwards = true;
            groupAwardList["boxBtn"..i]:set_active(true);
            groupAwardList["boxBtn"..i]:set_event_value(tostring(index), 0);
            local isAlreadyGet = level:IsAlreadyGetGroupAwards(sectionInfo.id, index);
            local isCanGet = level:IsCanGetGroupAwards(sectionInfo.id, index);
            local bBoxPoint = false;
            if isAlreadyGet then
                groupAwardList["boxStaticSp"..i]:set_active(true);
                groupAwardList["boxSp"..i]:set_active(false);
                if i == 1 then
                    groupAwardList["boxStaticSp"..i]:set_sprite_name("gq_baoxiang3_2");
                else
                    groupAwardList["boxStaticSp"..i]:set_sprite_name("gq_baoxiang1_2");
                end
            elseif isCanGet then
                groupAwardList["boxStaticSp"..i]:set_active(false);
                groupAwardList["boxSp"..i]:set_active(true);
                if i == 1 then
                    groupAwardList["boxSp"..i]:set_sprite_name("gq_baoxiang3");
                else
                    groupAwardList["boxSp"..i]:set_sprite_name("gq_baoxiang1");
                end
                bBoxPoint = true;
            else
                groupAwardList["boxStaticSp"..i]:set_active(true);
                groupAwardList["boxSp"..i]:set_active(false);
                if i == 1 then
                    groupAwardList["boxStaticSp"..i]:set_sprite_name("gq_baoxiang3");
                else
                    groupAwardList["boxStaticSp"..i]:set_sprite_name("gq_baoxiang1");
                end
            end
            if AppConfig.get_enable_guide_tip() then
                groupAwardList["boxPoint"..i]:set_active(bBoxPoint);
            end
            groupAwardList["boxStar"..i]:set_text(tostring(sectionInfo["award"..index.."_star"]));
            index = index - 1;
        end
    end
    groupAwardList.grid:reposition_now();
    -- groupAwardList.pro:set_active(notGroupAwards);
    self.btnLeftArrow:set_active(self.curSection ~= 1);
    local serverMaxSection = level:GetServerCurGroup();
    --app.log(tostring(self.curSection).."...."..tostring(maxSection).."..."..tostring(serverMaxSection));
    self.btnRightArrow:set_active(self.curSection ~= serverMaxSection);

    self.curSection = 1;

    --章节提示奖励
    local showGroupAwards = false;
    local tempSection = nil;
    if maxSection == nil then
        tempSection = self.curSection + 1;
    else
        tempSection = maxSection + 1;
    end
    local temp = self.sectionList[self.selectTab][tempSection];
    while temp do
        if temp.show_group_awards ~= 0 then
            self.labGroupAwards:set_text(tostring(temp.show_gw_text));
            showGroupAwards = true;
            if self.itemGroupAwards == nil then
                self.itemGroupAwards = UiSmallItem:new({parent = self.objGroupAwards, cardInfo = nil, is_enable_goods_tip = true});
                self.itemGroupAwards:SetCommonEffectScale(0.38, 0.38, 0.38);
                self.itemGroupAwards:SetAsReward(true);
            end
            self.itemGroupAwards:SetDataNumber(temp.show_group_awards, 0);
            self.itemGroupAwards:SetShowNumber(false);
            break;
        end
        tempSection = tempSection + 1;
        temp = self.sectionList[self.selectTab][tempSection];
    end
    self.spGroupAwards:set_active(showGroupAwards);
    
    if AppConfig.get_enable_guide_tip() then
        self.btnLeftPoint:set_active(level:IsAllGroupNotGetBox(sectionInfo.id, true));
        local showHedPoint = level:IsAllGroupNotGetBox(sectionInfo.id, false);
        if not showHedPoint then
            showHedPoint = level:CheckAnimIdRedPoint(self.selectTab);
        end
        self.btnRightPoint:set_active(showHedPoint);
    end
        
    -- 关卡数据
    self:UpdateLevel();
end
local resource_type = 
{
    [0]={boxOpen="gq_baoxiang2_2", boxClose="gq_baoxiang2", animSelect="ui_701_level_content1", zb="gq_zuobiao_pt1", boxDi="gq_zuobiao_pt3", headArrow="gq_quan4"},
    [1]={boxOpen="gq_baoxiang2_2", boxClose="gq_baoxiang2", animSelect="ui_701_level_content2", zb="gq_zuobiao_jy1", boxDi="gq_zuobiao_jy3", headArrow="gq_quan5"},
}
-- 更新具体所有关卡
function UiLevel:UpdateLevel()
    if self.ui == nil then
        return;
    end
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if sectionInfo == nil then
        return;
    end
    section_id = sectionInfo.id;
    local level = g_dataCenter.hurdle;
    -- 获取当前章节所有关卡配置
    local levelAll = level:GetGroupHurdleConfigList_NoKey(section_id);
    if levelAll == nil or #levelAll <= 0 then
        return;
    end
    self:ClearHurdleLineList();
    local hurdleTypeList = self:GetHurdleLineList(section_id);
    hurdleTypeList.objRoot:set_active(true);
    -- --当前章节能打的最大关卡
    -- local maxCanHurdle = level:GetCurFightLevelID(section_id);
    -- app.log("group="..tostring(section_id).." level="..table.tostring(levelAll));
    -- 关卡数据设置
    local res = resource_type[self.selectTab];
    --self.spListDi:set_sprite_name(res.listDi);
    local playStarHurdleid, playStarIndex = level:GetPlayStarAnim();
    for i = 1, 100 do
        if not hurdleTypeList["objLevel"..i] then
            break;
        end
        if levelAll[i] == nil then
            hurdleTypeList["objLevel"..i]:set_active(false);
        else
            hurdleTypeList["objLevel"..i]:set_active(true);
            --app.log("........"..tostring(levelAll[i].hurdleid))
            local cloneLevel = hurdleTypeList["cloneLevel"..i];
            cloneLevel.btnLevel:set_event_value(tostring(levelAll[i].hurdleid), 0);

            local isCanFight = level:IsCanFight(levelAll[i].hurdleid);
            local isPass = level:IsPassHurdle(levelAll[i].hurdleid);
            --宝箱
            local cloneBox = hurdleTypeList["objBox"..i];
            -- app.log(tostring(levelAll[i].hurdleid).."  "..tostring(levelAll[i].box_dropid))
            if levelAll[i].box_dropid > 0 then
                hurdleTypeList["objBoxParent"..i]:set_active(true);
                cloneBox.btnBox:set_event_value(tostring(levelAll[i].hurdleid), 0);
                local bBoxPoint = false;
                if level:IsOpenHurdleBox(levelAll[i].hurdleid) then
                    cloneBox.spBoxStatic:set_active(true);
                    cloneBox.spBoxStatic:set_sprite_name(res.boxOpen);
                    cloneBox.spBox:set_active(false);
                elseif isPass then
                    cloneBox.spBoxStatic:set_active(false);
                    cloneBox.spBox:set_active(true);
                    bBoxPoint = true;
                else
                    cloneBox.spBoxStatic:set_active(true);
                    cloneBox.spBoxStatic:set_sprite_name(res.boxClose);
                    cloneBox.spBox:set_active(false);
                end
                cloneBox.spBoxDi:set_sprite_name(res.boxDi);
                if AppConfig.get_enable_guide_tip() then
                    cloneBox.spBoxPoint:set_active(bBoxPoint);
                end
            else
                if hurdleTypeList["objBoxParent"..i] then
                    hurdleTypeList["objBoxParent"..i]:set_active(false);
                end
            end
            if levelAll[i].hurdleid == 61002000 then
                cloneLevel.spHint:set_active(not isPass);
            else
                cloneLevel.spHint:set_active(false);
            end
            --公用部分
            cloneLevel.labIndex:set_text(tostring(levelAll[i].index));
            cloneLevel.lab2Index:set_text(tostring(levelAll[i].index));
            cloneLevel.spAdd:set_sprite_name(res.zb);
            cloneLevel.spArrow:set_sprite_name(res.headArrow);
            --星星
            if levelAll[i].show_landscape == 0 and PropsEnum.IsRole(levelAll[i].show_icon) or PropsEnum.IsMonster(levelAll[i].show_icon) then
                cloneLevel.objStar:set_active(false);
                cloneLevel.obj2Star:set_active(true);
            else
                cloneLevel.objStar:set_active(true);
                cloneLevel.obj2Star:set_active(false);
            end
            local info = level:GetHurdleByHurdleid(levelAll[i].hurdleid);
            if info then
                -- if levelAll[i].show_landscape == 0 and PropsEnum.IsRole(levelAll[i].show_icon) or PropsEnum.IsMonster(levelAll[i].show_icon) then
                --     cloneLevel.objStar:set_active(false);
                --     cloneLevel.obj2Star:set_active(true);
                -- else
                --     cloneLevel.objStar:set_active(true);
                --     cloneLevel.obj2Star:set_active(false);
                -- end
                
                if playStarHurdleid == levelAll[i].hurdleid then
                    --如果是需要播星星动画的关卡就播动画
                    self:PlayStarAnim(cloneLevel);
                else
                    for j = 1, 3 do
                        cloneLevel["spStar"..j]:set_active(false);
                        cloneLevel["sp2Star"..j]:set_active(false);
                        if j <= info.star_num then
                            cloneLevel["spFixStar"..j]:set_active(true);
                            cloneLevel["sp2FixStar"..j]:set_active(true);
                        else
                            cloneLevel["spFixStar"..j]:set_active(false);
                            cloneLevel["sp2FixStar"..j]:set_active(false);
                        end
                    end
                end
            else
                for j = 1, 3 do
                    cloneLevel["spStar"..j]:set_active(false);
                    cloneLevel["sp2Star"..j]:set_active(false);
                    
                    cloneLevel["spFixStar"..j]:set_active(false);
                    cloneLevel["sp2FixStar"..j]:set_active(false);
                end
                -- cloneLevel.objStar:set_active(false);
                -- cloneLevel.obj2Star:set_active(false);
            end
            --头像部分
            local isBoss = false;
            local showHead = nil;
            if levelAll[i].show_landscape == 0 then
                -- cloneLevel.spHead:set_active(false);
                local cf = PropsEnum.GetConfig(levelAll[i].show_icon);
                --app.log(tostring(i).."  "..tostring(levelAll[i].hurdleid).."........"..table.tostring(cf))
                if PropsEnum.IsRole(levelAll[i].show_icon) or PropsEnum.IsMonster(levelAll[i].show_icon) then
                    cloneLevel.spBk:set_active(false);
                    cloneLevel.spDi:set_active(true);
                    cloneLevel.spHead:set_sprite_name(cf.small_icon);
                    cloneLevel.spAdd:set_sprite_name("gq_zuobiao_boss1");
                    cloneLevel.spFire:set_active(not isPass and isCanFight);
                    isBoss = true;
                    showHead = cloneLevel.spHead;

                    cloneLevel.objRoot:set_local_scale(1.1, 1.1, 1);
                else
                    cloneLevel.spBk:set_active(true);
                    cloneLevel.spDi:set_active(false);
                    cloneLevel.textureItem:set_texture(cf.small_icon);
                    showHead = cloneLevel.textureItem;
                    cloneLevel.objRoot:set_local_scale(0.9, 0.9, 1);
                end
            else
                cloneLevel.spBk:set_active(true);
                cloneLevel.spDi:set_active(false);
                cloneLevel.textureItem:set_texture(levelAll[i].show_landscape);
                showHead = cloneLevel.textureItem;
                cloneLevel.objRoot:set_local_scale(0.9, 0.9, 1);
            end
            --头像首通奖励
            if not isPass and levelAll[i].show_first_pass ~= 0 then
                cloneLevel.spFirstPass:set_active(true);
                local fph = self:GetFirstPassHead(i);
                fph:SetParent(cloneLevel.objFirstPass);
                fph:Show();
                fph:SetDataNumber(levelAll[i].show_first_pass, 0);
                fph:SetShowNumber(false);
            else
                cloneLevel.spFirstPass:set_active(false);
            end
            --关卡未通过的话头像变灰
            if showHead then
                if isCanFight then
                    showHead:set_color(1, 1, 1, 1);
                else
                    showHead:set_color(0, 0, 0, 1);
                end
            end
            if isPass then
                cloneLevel.spBk:set_sprite_name("gq_quan1");
                cloneLevel.spDi:set_sprite_name("gq_kuang3");
                -- cloneLevel.arrows:set_active(false);

                -- cloneLevel.spGuangquan:set_active(false);
                -- cloneLevel.spGuangquan2:set_active(false);
                -- cloneLevel.spGuangquan3:set_active(false);
            elseif isCanFight then
                cloneLevel.spBk:set_sprite_name("gq_quan2");
                cloneLevel.spDi:set_sprite_name("gq_kuang3");
                -- cloneLevel.arrows:set_active(true);
                if isBoss then
                    cloneLevel.objRoot:animated_play("ui_701_level_content2");
                else
                    cloneLevel.objRoot:animated_play(res.animSelect);
                end
                -- cloneLevel.spGuangquan:set_active(true);
                -- cloneLevel.spGuangquan2:set_active(true);
                -- cloneLevel.spGuangquan3:set_active(true);
            else
                cloneLevel.spBk:set_sprite_name("gq_quan1");
                cloneLevel.spDi:set_sprite_name("gq_kuang1");
                -- cloneLevel.arrows:set_active(false);
                -- cloneLevel.spGuangquan:set_active(false);
                -- cloneLevel.spGuangquan2:set_active(false);
                -- cloneLevel.spGuangquan3:set_active(false);
            end
        end
    end
end


function UiLevel:OnClickHurdleBox(t)
    local hurdleid = tonumber(t.string_value);
    local level = g_dataCenter.hurdle;
    if level:IsGetHurdleBox(hurdleid) then
        msg_hurdle.cg_hurlde_box(hurdleid);
        -- uiManager:PushUi(EUI.UiLevelBox, {nType = 1, hurdleid=hurdleid})
    else
        uiManager:PushUi(EUI.UiLevelBox, {nType = 1, hurdleid=hurdleid})
    end
end

function UiLevel:OnClickHurdle(t)
    local hurdleid = tonumber(t.string_value);
    --app.log("...."..tostring(hurdleid))
    -- app.log("..."..tostring(hurdleid))
    if not g_dataCenter.hurdle:IsCanFight(hurdleid) then
        return;
    end
    self.curLevel = hurdleid;
    self:UpdateLevel();
    uiManager:PushUi(EUI.UiLevelChallenge, {hurdleid=hurdleid, goodsId=self.goGoodsId, goodsCount=self.goGoodsCount})
end

function UiLevel:OnClickHurldeType(t)
    -- local hurdleType = tonumber(t.string_value);
    -- if self.selectTab == hurdleType then
    --     return;
    -- end
    local level = g_dataCenter.hurdle;
    if not level:IsEliteOpen() then
        return;
    end
    if self.selectTab == EHurdleType.eHurdleType_normal then
        self.animBtn:animated_play("guanka_change");
        self.selectTab = EHurdleType.eHurdleType_elite;
        self.animElite:set_active(true);
    else
        self.animBtn:animated_play("guanka_change2");
        self.selectTab = EHurdleType.eHurdleType_normal;
        self.animElite:set_active(false);
    end
    local curGroup = level:GetCurGroup(self.selectTab);
    self.curSection = level:SectionIdToIndex(curGroup);
    self.curLevel = level:GetCurFightLevelID(curGroup);
    --if self.curSection > g_open_level_count then
        self.curSection = g_open_level_count;
    --end
    self:UpdateUi();

    --更新标题
    --uiManager:GetNavigationBarUi():setTitle(self:GetNavigationTitle())
end

function UiLevel:OnClickGroupAwards(t)
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if not sectionInfo then
        return;
    end
    local groupid = sectionInfo.id;
    local index = tonumber(t.string_value);
    local level = g_dataCenter.hurdle;
    if level:IsGetGroupAwards(groupid, index) then
        msg_hurdle.cg_take_award(groupid, index);
        -- uiManager:PushUi(EUI.UiLevelBox, {nType = 2, groupid=groupid, index=index})
    else
        uiManager:PushUi(EUI.UiLevelBox, {nType = 2, groupid=groupid, index=index})
    end
end

function UiLevel:OnEnterFight(hurdleid)
    local level = g_dataCenter.hurdle;
    --取最大关卡id
    local maxFightId = level:GetCurFightLevelID(level:GetCurGroup(self.selectTab));
    --如果相同则将选中关卡id设置为nil 下一次进来后重新取最新关卡
    if self.goLevel then
        -- uiManager:PopUi();
    else
        -- uiManager:PopUi();
        self.fightSelectTab = self.selectTab;
        if hurdleid ~= maxFightId then
            self.fightLevel = hurdleid;
        end
    end
end

function UiLevel:OnLevelUp()
    -- if self:IsShow() then
        CommonPlayerLevelup.Start(g_dataCenter.player);
    -- end
end

function UiLevel:OnToggle()
    if self.toggleFirst then
        self.toggleFirst = false;
        return;
    end
    local level = g_dataCenter.hurdle;
    local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_hurdleToggle);
    if cf.data == 0 then
        if not PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_EliteLevel) then
           return;
        end
    elseif not level:IsPassHurdle(cf.data) then
        return;
    end
    if self.selectTab == EHurdleType.eHurdleType_elite then
        self.selectTab = EHurdleType.eHurdleType_normal;
    else
        self.selectTab = EHurdleType.eHurdleType_elite;
    end
    local curGroup = level:GetCurGroup(self.selectTab);
    self.curSection = level:SectionIdToIndex(curGroup);
    if self.curSection > g_open_level_count then
        self.curSection = g_open_level_count;
            local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
        self.curLevel = level:GetCurFightLevelID(sectionInfo.id);
    else
        self.curLevel = level:GetCurFightLevelID(curGroup);        
    end
    self:UpdateUi();
end

function UiLevel:ClearHurdleLineList()
    if self.allHurdleLineList then
        for k, v in pairs(self.allHurdleLineList) do
            v.objRoot:set_active(false);
        end
    end
end

function UiLevel:GetHurdleLineList(section_id)
    local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, section_id);
    if not cf then
        return;
    end
    self.allHurdleLineList = self.allHurdleLineList or {};
    if not self.allHurdleLineList[section_id] then
        self.allHurdleLineList[section_id] = {};
        local allHurdleLineList =  self.allHurdleLineList[section_id];
        allHurdleLineList.objRoot = self.levelItem:get_child_by_name("level_"..cf.ui_number);
        if allHurdleLineList.objRoot == nil then
            app.log("关卡线路图配置错误.........groupid="..tostring(section_id).."  ui_number="..tostring(cf.ui_number));
        end
        --100只是为了扩展以后当一个章节有100个的时候 不用改代码
        for i = 1, 100 do
            allHurdleLineList["objLevel"..i] = allHurdleLineList.objRoot:get_child_by_name(tostring(i));
            if not allHurdleLineList["objLevel"..i] then
                break;
            end
            --关卡详细信息
            allHurdleLineList["cloneLevel"..i] = self:GetHead(i);
            allHurdleLineList["cloneLevel"..i].objRoot:set_active(true);
            allHurdleLineList["cloneLevel"..i].objRoot:set_parent(allHurdleLineList["objLevel"..i]);
            allHurdleLineList["cloneLevel"..i].objRoot:set_local_scale(1, 1, 1);
            allHurdleLineList["cloneLevel"..i].objRoot:set_local_position(0, 0, 0);
            --关卡宝箱
            allHurdleLineList["objBoxParent"..i] = allHurdleLineList["objLevel"..i]:get_child_by_name("box");
            allHurdleLineList["objBox"..i] = self:GetBox(i);
            allHurdleLineList["objBox"..i].objBox:set_active(true);
            allHurdleLineList["objBox"..i].objBox:set_parent(allHurdleLineList["objBoxParent"..i]);
            allHurdleLineList["objBox"..i].objBox:set_local_position(0, 0, 0);
            allHurdleLineList["objBox"..i].objBox:set_local_scale(1, 1, 1);
            --关卡线
            -- allHurdleLineList["spLine"..i] = {};
            -- for j = 1, 100 do
            --     allHurdleLineList["spLine"..i.."_"..j] = ngui.find_sprite(allHurdleLineList["objLevel"..i], "sp_line"..j);
            --     if not allHurdleLineList["spLine"..i.."_"..j] then
            --         break;
            --     end
            -- end
        end
    else
        local allHurdleLineList = self.allHurdleLineList[section_id];
        --需要把頭像移動回來
        for i = 1, 100 do
            if not allHurdleLineList["objLevel"..i] then
                break;
            end
            allHurdleLineList["cloneLevel"..i] = self:GetHead(i);
            allHurdleLineList["cloneLevel"..i].objRoot:set_active(true);
            allHurdleLineList["cloneLevel"..i].objRoot:set_parent(allHurdleLineList["objLevel"..i]);
            allHurdleLineList["cloneLevel"..i].objRoot:set_local_scale(1, 1, 1);
            allHurdleLineList["cloneLevel"..i].objRoot:set_local_position(0, 0, 0);
            allHurdleLineList["objBox"..i] = self:GetBox(i);
            allHurdleLineList["objBox"..i].objBox:set_active(true);
            allHurdleLineList["objBox"..i].objBox:set_parent(allHurdleLineList["objBoxParent"..i]);
            allHurdleLineList["objBox"..i].objBox:set_local_position(0, 0, 0);
            allHurdleLineList["objBox"..i].objBox:set_local_scale(1, 1, 1);
        end
    end
    return self.allHurdleLineList[section_id];
end

function UiLevel:GetHead(index)
    if self.allHead == nil then
        self.allHead = {};
    end
    if not self.allHead[index] then
        self.allHead[index] = {}
        local head = self.allHead[index];
        head.objRoot = self.cloneLevelHead:clone();
        head.objRoot:set_name("level_content");
        head.btnLevel = ngui.find_button(head.objRoot, head.objRoot:get_name());
        head.btnLevel:set_on_click(self.bindfunc['OnClickHurdle'],"MyButton.NoneAudio");
        -- head.arrows = head.objRoot:get_child_by_name("animation_arrows");
        head.objStar = head.objRoot:get_child_by_name("sp_star_di");
        head.obj2Star = head.objRoot:get_child_by_name("cont_star");
        for j = 1, 3 do
            head["objStar"..j] = head.objRoot:get_child_by_name("sp_star_di/sp_star"..j);
            head["spStar"..j] = ngui.find_sprite(head["objStar"..j], "sp_star");
            head["spStar"..j]:set_active(false);
            head["spFixStar"..j] = ngui.find_sprite(head["objStar"..j], "sp_star_x");

            head["obj2Star"..j] = head.objRoot:get_child_by_name("cont_star/sp_star"..j);
            head["sp2Star"..j] = ngui.find_sprite(head["obj2Star"..j], "sp_star");
            head["sp2Star"..j]:set_active(false);
            head["sp2FixStar"..j] = ngui.find_sprite(head["obj2Star"..j], "sp_star_x");
        end
        head.spBk = ngui.find_sprite(head.objRoot, "sp_bk");
        head.spDi = ngui.find_sprite(head.objRoot, "sp_di");
        head.spHead = ngui.find_sprite(head.objRoot, "sp_human");
        -- head.spRole = ngui.find_sprite(head.objRoot, "sp_human1");
        head.textureItem = ngui.find_texture(head.objRoot, "Texture");
        --head.fxSelect = ngui.find_sprite(head.objRoot, "sp_fx");
        head.labIndex = ngui.find_label(head.objRoot, "sp_bk/lab_level");
        head.spArrow = ngui.find_sprite(head.objRoot, "sp_arrows");
        head.lab2Index = ngui.find_label(head.objRoot, "sp_di/lab_level");
        head.spAdd = ngui.find_sprite(head.objRoot, "sp_add");
        -- head.spGuangquan = ngui.find_sprite(head.objRoot, "guangquan");
        -- head.spGuangquan2 = ngui.find_sprite(head.objRoot, "guangquan2");
        -- head.spGuangquan3 = ngui.find_sprite(head.objRoot, "guangquan3");
        head.spFire = ngui.find_sprite(head.objRoot, "fx_ui_701_level_fire1");
        head.spHint = ngui.find_sprite(head.objRoot, "sp_hint");

        head.spFirstPass = ngui.find_sprite(head.objRoot, "sp_shou_tong");
        head.objFirstPass = head.spFirstPass:get_game_object():get_child_by_name("new_small_card_item");

    end
    return self.allHead[index];
end

function UiLevel:GetBox(index)
    if self.allBox == nil then
        self.allBox = {};
    end
    if not self.allBox[index] then
        self.allBox[index] = {};
        local box = self.allBox[index];
        box.objBox = self.cloneLevelBox:clone();
        box.btnBox = ngui.find_button(box.objBox, box.objBox:get_name());
        box.btnBox:set_on_click(self.bindfunc['OnClickHurdleBox']);
        box.spBox = ngui.find_sprite(box.objBox, "sp_box1");
        box.spBoxStatic = ngui.find_sprite(box.objBox, "sp_box");
        box.spBoxPoint = ngui.find_sprite(box.objBox, "sp_point");
        box.spBoxPoint:set_active(false);
        box.spBoxDi = ngui.find_sprite(box.objBox, "sp_di");
    end
    return self.allBox[index];
end

function UiLevel:GetFirstPassHead(index)
    if self.allFirstPassHead == nil then
        self.allFirstPassHead = {};
    end
    if not self.allFirstPassHead[index] then
        self.allFirstPassHead[index] = UiSmallItem:new({parent = nil, cardInfo = nil, is_enable_goods_tip = true});
        self.allFirstPassHead[index]:Hide(false);
        self.allFirstPassHead[index]:SetCommonEffectScale(0.2, 0.2, 0.2);
        self.allFirstPassHead[index]:SetAsReward(true);
    end
    return self.allFirstPassHead[index];
end

function UiLevel:OnPreGroup()
    if self.curSection == 1 then
        return;
    end
    self.curSection = self.curSection - 1;
    self:UpdateUi();
end

function UiLevel:OnNextGroup()
    --检查下一章节的等级是否满足条件
    local sectionInfo = self.sectionList[self.selectTab][self.curSection+1];
    if not sectionInfo then
        app.log(string.format("第%d章配置表有问题", self.curSection+1));
        return;
    end
    local level = g_dataCenter.hurdle;
    if not level:IsPassGroup(self.sectionList[self.selectTab][self.curSection].id) then
        FloatTip.Float(string.format("第%d章通关后开启", self.curSection));
        return;
    end
    local playerLevel = g_dataCenter.player:GetLevel();
    local levelList = level:GetGroupHurdleConfigList_NoKey(sectionInfo.id);
    if playerLevel < levelList[1].need_level then
        FloatTip.Float(string.format("第%d章需%d级开启", self.curSection+1, levelList[1].need_level));
        return;
    end
    --精英关卡检测普通关卡是否通过
    local hurdleInfo = levelList[1];
    if self.selectTab == EHurdleType.eHurdleType_elite then
        if hurdleInfo.type_param > 0 then
            local otherInfo = level:GetHurdleByHurdleid(hurdleInfo.type_param);
            if not otherInfo then
                local cf = ConfigHelper.GetHurdleConfig(hurdleInfo.type_param);
                FloatTip.Float(string.format(gs_misc['str_53'], cf.index));
                return;
            end
        end
    end
    self.curSection = self.curSection + 1;
    self:UpdateUi();
end
--播放动画
function UiLevel:PlayStarAnim(head)
    local level = g_dataCenter.hurdle;
    local hurdleid, playIndex = level:GetPlayStarAnim();
    --初始化变量
    self.starPlayState = true;
    if self.starPlayIndex == nil then
        self.starPlayIndex = playIndex;
    end
    if self.starPlayHead == nil then
        self.starPlayHead = head;    
    end
    if self.starPlayHurdleid == nil then
        self.starPlayHurdleid = hurdleid;
    end
    --界面所有星隐藏
    for i = 1, 3 do
        if i <= self.starPlayIndex then
            head["spFixStar"..i]:set_active(true);
            head["spStar"..i]:set_active(false);
            head["sp2FixStar"..i]:set_active(true);
            head["sp2Star"..i]:set_active(false);            
        else
            head["spFixStar"..i]:set_active(false);
            head["spStar"..i]:set_active(false);
            head["sp2FixStar"..i]:set_active(false);
            head["sp2Star"..i]:set_active(false);
        end
    end
    --数据中心数据清空
    level:SetPlayStarAnim(nil, nil);
    self:PlayNextStarAnim();
end
--播放下一颗星
function UiLevel:PlayNextStarAnim()
    if not self.starPlayState then
        return;
    end
    self.starPlayIndex = self.starPlayIndex + 1;
    --播放完了
    if self.starPlayIndex > 3 then
        self:ClearStarAnim();
        return;
    end
    local level = g_dataCenter.hurdle;
    local info = level:GetHurdleByHurdleid(self.starPlayHurdleid);
    if self.starPlayIndex <= info.star_num then
        self.starPlayHead["spStar"..self.starPlayIndex]:set_active(true);
        self.starPlayHead["sp2Star"..self.starPlayIndex]:set_active(true);
    else
        self:ClearStarAnim();
    end
end
--清除动画
function UiLevel:ClearStarAnim()
    self.starPlayState = nil;
    self.starPlayIndex = nil;
    self.starPlayHead = nil;
    self.starPlayHurdleid = nil;
end
--动画回调
function UiLevel.StarAnimationFinish()
    local eu = uiManager:FindUI(EUI.UiLevel);
    if eu and eu:IsShow() then
        eu:PlayNextStarAnim();
    end
end

function UiLevel:OpenNewGroupAnimation()
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if sectionInfo == nil then
        return;
    end
    local level = g_dataCenter.hurdle;
    --新章节开启动画
    UiLevelNewGroup.Start(sectionInfo.id);
    --更新红点
    if AppConfig.get_enable_guide_tip() then
        self.btnLeftPoint:set_active(level:IsAllGroupNotGetBox(sectionInfo.id, true));
        local showHedPoint = level:IsAllGroupNotGetBox(sectionInfo.id, false);
        if not showHedPoint then
            showHedPoint = level:CheckAnimIdRedPoint(self.selectTab);
        end
        self.btnRightPoint:set_active(showHedPoint);
    end
end

------------------------------ 新手引导使用 -------------------------------
function UiLevel:GetLevelItemUi(diff_level, level_index)
    if not self.ui then return end
        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    if sectionInfo == nil then
        return;
    end
    local section_id = sectionInfo.id;
    local hurdleTypeList = self:GetHurdleLineList(section_id);
    return hurdleTypeList["cloneLevel"..tostring(level_index)].objRoot;
end

function UiLevel:GetLevelBoxUi(index)
    if not self.allHurdleLineList then return end

        local sectionInfo = UiLevel:GetSectionInfo();
    --local sectionInfo = self.sectionList[self.selectTab][self.curSection];--local sectionInfo = { id = 0, chapter_num = 1, chapter = 1, }
    local section_id = sectionInfo and sectionInfo.id or 0;
    if self.allHurdleLineList[section_id] and self.allHurdleLineList[section_id]["objBox"..index] then
        return self.allHurdleLineList[section_id]["objBox"..index].objBox
    end
end
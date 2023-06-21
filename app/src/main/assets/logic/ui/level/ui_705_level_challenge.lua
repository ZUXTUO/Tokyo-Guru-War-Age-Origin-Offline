UiLevelChallenge = Class('UiLevelChallenge', UiBaseClass);

local max_star = 3;
local max_award = 3;
-- 初始化
function UiLevelChallenge:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/level/ui_705_level.assetbundle';
    UiBaseClass.Init(self, data)
end

-- 重新开始
function UiLevelChallenge:Restart(data)
    if data then
        self.hurdleid = data.hurdleid;
        self.goodsId = data.goodsId;
        self.goodsCount = data.goodsCount;
        local hurdleInfo = ConfigHelper.GetHurdleConfig(self.hurdleid);
        if hurdleInfo == nil then
            return;
        end
        self.selectTab = hurdleInfo.hurdle_type;
    end
    UiBaseClass.Restart(self, data)
end

-- 析构函数
function UiLevelChallenge:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if self.cloneItem then
        for k, v in pairs(self.cloneItem) do
            v:DestroyUi();
        end
    end
    self.cloneItem = nil;
    if self.textureBk then
        self.textureBk:Destroy();
        self.textureBk = nil;
    end
    PublicFunc.ClearUserDataRef(self);
end

-- 注册回调函数
function UiLevelChallenge:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['OnRaidsOne'] = Utility.bind_callback(self, self.OnRaidsOne);
    self.bindfunc['OnRaidsTen'] = Utility.bind_callback(self, self.OnRaidsTen);
    self.bindfunc['OnRaidsFifty'] = Utility.bind_callback(self, self.OnRaidsFifty);
    self.bindfunc['OnStartFight'] = Utility.bind_callback(self, self.OnStartFight);
    self.bindfunc['OnReset'] = Utility.bind_callback(self, self.OnReset);
    self.bindfunc['OnRaidsResult'] = Utility.bind_callback(self, self.OnRaidsResult);
    self.bindfunc['UpdateUi'] = Utility.bind_callback(self, self.UpdateUi);
    self.bindfunc['OnExit'] = Utility.bind_callback(self, self.OnExit);
    self.bindfunc['OnEnterFight'] = Utility.bind_callback(self, self.OnEnterFight);
end


-- 注册消息分发回调函数
function UiLevelChallenge:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_hurdle.gc_hurdle_saodang, self.bindfunc['OnRaidsResult']);
    PublicFunc.msg_regist(msg_hurdle.gc_reset_hurdle, self.bindfunc['UpdateUi']);
    PublicFunc.msg_regist(msg_hurdle.gc_hurdle_fight, self.bindfunc['OnEnterFight']);
end

-- 注销消息分发回调函数
function UiLevelChallenge:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_hurdle.gc_hurdle_saodang, self.bindfunc['OnRaidsResult']);
    PublicFunc.msg_unregist(msg_hurdle.gc_reset_hurdle, self.bindfunc['UpdateUi']);
    PublicFunc.msg_unregist(msg_hurdle.gc_hurdle_fight, self.bindfunc['OnEnterFight']);
end

local level_name = 
{
    [0] = { text="普通关卡", sp="xq_qipaolv"},
    [1] = { text="精英关卡", sp="xq_qibianhong"},
}
-- 寻找ngui对象
function UiLevelChallenge:InitUI(asset_obj)
    -- 屏幕适配：锚点对齐
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_local_position(0, 0, 0);
    self.ui:set_name('ui_705_level_challenge');
    self.textureBk = ngui.find_texture(self.ui, "Texture");
    self.labTitle1 = ngui.find_label(self.ui, "content_di_1004_564/lab_title");
    self.labTitle2 = ngui.find_label(self.ui, "content_di_1004_564/lab_title/lab_title2");
    for i = 1, 3 do
        self["spPassCondition"..i] = ngui.find_sprite(self.ui, "cont"..i.."/sp_star");
        self["labPassCondition"..i] = ngui.find_label(self.ui, "cont"..i.."/lab");
    end
    self.objParent = {};
    self.cloneItem = {};
    for i = 1, 4 do
        self.objParent[i] = self.ui:get_child_by_name("new_small_card_item"..i);
    end
    self.objContent = self.ui:get_child_by_name("content3");
    self.gridObj = ngui.find_grid(self.ui, "content3");
    for i = 1, 3 do
        self["btn"..i] = ngui.find_button(self.objContent, "btn"..i);
        self["btn"..i]:reset_on_click();
        self["lab"..i] = ngui.find_label(self.objContent, "btn"..i.."/animation/lab");
        self["spLock"..i] = ngui.find_sprite(self.objContent, "btn"..i.."/animation/sp_clock");
        self["spBk"..i] = ngui.find_sprite(self.objContent, "btn"..i.."/animation/sprite_background");
    end
    if self.selectTab == EHurdleType.eHurdleType_normal then
        self.btn1:set_on_click(self.bindfunc["OnRaidsOne"]);
        self.btn2:set_on_click(self.bindfunc["OnRaidsTen"]);
        self.btn3:set_on_click(self.bindfunc["OnRaidsFifty"]);
    else
        self.btn1:set_on_click(self.bindfunc["OnReset"]);
        self.btn2:set_on_click(self.bindfunc["OnRaidsOne"]);
        self.btn3:set_on_click(self.bindfunc["OnRaidsTen"]);
    end
    -- self.btnList = {};
    -- for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
    --     self.btnList[i] = {};
    --     self.btnList[i].objRoot = self.ui:get_child_by_name("content3/cont"..(i+1));
    --     self.btnList[i].btnRaids = ngui.find_button(self.btnList[i].objRoot, "btn1");
    --     self.btnList[i].btnRaids:set_on_click(self.bindfunc["OnRaidsOne"]);
    --     self.btnList[i].labRaids = ngui.find_label(self.btnList[i].objRoot, "btn1/animation/lab");
    --     self.btnList[i].btnRaidsTen = ngui.find_button(self.btnList[i].objRoot, "btn2");
    --     self.btnList[i].btnRaidsTen:set_on_click(self.bindfunc["OnRaidsTen"]);
    --     self.btnList[i].labRaidsTen = ngui.find_label(self.btnList[i].objRoot, "btn2/animation/lab");
    --     if i == EHurdleType.eHurdleType_elite then
    --         self.btnList[i].btnReset = ngui.find_button(self.btnList[i].objRoot, "btn_chongzhi");
    --         self.btnList[i].btnReset:set_on_click(self.bindfunc['OnReset']);
    --     end
    -- end
    local btn = ngui.find_button(self.ui, "btn_cha");
    btn:set_on_click(self.bindfunc["OnExit"]);

    self.spSelect = ngui.find_sprite(self.ui, "centre_other/animation/sp");
    self.spResetCount = ngui.find_sprite(self.ui, "centre_other/animation/sp_point2");
    self.labResetCount = ngui.find_label(self.ui, "centre_other/animation/sp_point2/lab");
    self.labAp = ngui.find_label(self.ui, "centre_other/animation/sp_point1/lab_num");

    self.btnStartFight = ngui.find_button(self.ui, "centre_other/animation/btn");
    self.btnStartFight:set_on_click(self.bindfunc["OnStartFight"],"MyButton.NoneAudio");

    -- self.double_ui = self.ui:get_child_by_name("centre_other/animation/sp_di2");
    -- self.double_ui_lab = ngui.find_label(self.ui, "centre_other/animation/sp_di2/lab");
    -- self.double_ui:set_active(false);

    self:UpdateUi();
end
local raidsCount = 
{
    [0] = 10,
    [1] = 3,
}
local btnShowText = 
{
    {[0]=1, [1]="重置"},
    {[0]=10, [1]=1},
    {[0]=50, [1]=3},
}
-- 更新关卡
function UiLevelChallenge:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.Chapter);
    local hurdleInfo = ConfigHelper.GetHurdleConfig(self.hurdleid);
    local sectionInfo = ConfigManager.Get(EConfigIndex.t_hurdle_group, hurdleInfo.groupid);
    local fightCount = hurdleInfo.max_count;
    local info = g_dataCenter.hurdle:GetHurdleByHurdleid(self.hurdleid);
    if info then
        fightCount = hurdleInfo.max_count - info.period_post_times;
        if fightCount < 0 then
            fightCount = 0;
        end
    end
    self.textureBk:set_texture(hurdleInfo.chanllage_bk);
    -- self.labTitle1:set_text(string.format("%s %s %s", sectionInfo.chapter_num, hurdleInfo.name, hurdleInfo.index));
    self.labTitle1:set_text(tostring(hurdleInfo.index));
    self.labTitle2:set_text(tostring(hurdleInfo.name))
    local temp = {hurdleInfo.win_describe, hurdleInfo.good_describe, hurdleInfo.perfact_describe};
    local text = "";
    for i = 1, 3 do
        if info and info.finish_flags[i] > 0 then
            self["spPassCondition"..i]:set_color(1, 1, 1, 1);
            self["labPassCondition"..i]:set_text(temp[i]);    
        else
            self["spPassCondition"..i]:set_color(0, 0, 0, 1);
            self["labPassCondition"..i]:set_text("[8b8b8b]"..tostring(temp[i]).."[-]");    
        end
        
    end
    local dropId = 0;
    if not info and hurdleInfo.first_pass > 0 then
        dropId = hurdleInfo.first_pass;
    else 
        dropId = hurdleInfo.pass_award;
    end
    local dropItems = g_dataCenter.hurdle:GetDropByShowNumber(dropId);
    for i = 1, 4 do
        if dropItems and dropItems[i] and #dropItems[i] > 0 then
            self.objParent[i]:set_active(true);
            self:GetCloneItem(i):SetDataNumber(dropItems[i][1].goods_id, 0);
            self:GetCloneItem(i):SetShowNumber(false);
        else
            self.objParent[i]:set_active(false);
        end
    end
    local cf = nil;
    local playerLevel = g_dataCenter.player:GetLevel();
    local playerVip = g_dataCenter.player:GetVip();
    self.labAp:set_text(tostring(hurdleInfo.cost_ap));

    local str = "";
    local isActive = false;
    local checkGray = true;
    --來区分精英从2开始的索引
    local index = 0;
    for i = 1, 3 do
        if i == 1 and self.selectTab == EHurdleType.eHurdleType_elite then
            str = btnShowText[i][self.selectTab];
            isActive = fightCount == 0;
            index = 1;
            checkGray = false;
        else
            str = string.format(gs_misc['str_73'], btnShowText[i][self.selectTab]);
            local cf = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids1BtnShowLevel + self.selectTab*3 + (i - 1 - index));
            if cf.data < 0 then
                isActive = false;
                self["btn"..i]:set_active(false);
            else
                isActive = playerLevel>=cf.data;
            end
            checkGray = true;
        end
        self["lab"..i]:set_text(str);
        self["btn"..i]:set_active(isActive);
        if isActive and checkGray then
            local times = btnShowText[i][self.selectTab];
            local gray = self:CheckBtnGray(times);
            if gray then
                self["spLock"..i]:set_active(true);
                self["spBk"..i]:set_sprite_name("ty_anniu5");
                self["lab"..i]:set_color(198/255, 198/255, 198/255, 1);
            else
                self["spLock"..i]:set_active(false);
                self["spBk"..i]:set_sprite_name("ty_anniu4");
                self["lab"..i]:set_color(60/255, 75/255, 143/255, 1);
            end    
        end
    end
    self.gridObj:reposition_now();
    self.spResetCount:set_active(self.selectTab == EHurdleType.eHurdleType_elite);
    -- self.labResetCount:set_active(self.selectTab == EHurdleType.eHurdleType_elite);
    self.labResetCount:set_text(string.format(gs_misc['str_67'], fightCount, hurdleInfo.max_count))

    -- self.spSelect:set_sprite_name(level_name[self.selectTab].sp);
    self.spSelect:set_active(self.selectTab == EHurdleType.eHurdleType_elite);
    -- 双倍
    local double_type = ENUM.Activity.activityType_double_hurdle_normal;
    if self.selectTab == 1 then
        double_type = ENUM.Activity.activityType_double_hurdle_elite;
    end
    if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(double_type) then
        -- self.double_ui:set_active(true);
    end
end

function UiLevelChallenge:CheckBtnGray(times)
    local hurdleInfo = ConfigHelper.GetHurdleConfig(self.hurdleid);
    if not hurdleInfo then
        return true;
    end
    local info = g_dataCenter.hurdle:GetHurdleByHurdleid(self.hurdleid);
    if not info then
        return true;
    end
    local level = g_dataCenter.player.level;
    local vip = g_dataCenter.player.vip;
    local cfVip,cfLevel;
    if info.star_num < 3 then
        cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalNo3StarRaidsVip + hurdleInfo.hurdle_type * 2);
        cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalNo3StarRaidsLevel + hurdleInfo.hurdle_type * 2);
        --vip或者等级有限制的话
        if cfVip.data > 0 and cfLevel.data > 0 then 
            if vip < cfVip.data and level < cfLevel.data then
                return true;
            end
        elseif cfVip.data > 0 then
            if vip < cfVip.data then
                return true;
            end
        elseif cfLevel.data > 0 then
            if level < cfLevel.data then
                return true;
            end
        end
    end
    if times == 1 then
        cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids1Vip + hurdleInfo.hurdle_type * 6);
        cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids1Level + hurdleInfo.hurdle_type * 6);
    elseif times == 3 then
        cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleEliteRaids3Vip);
        cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleEliteRaids3Level);
    elseif times == 10 then
        cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids10Vip);
        cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids10Level);
    elseif times == 50 then
        cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids50Vip);
        cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
            MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids50Level);
    else
        cfVip = nil;
        cfLevel = nil;
    end
    if not cfVip or not cfLevel then
        app.log("出数据错误了 cfVip="..tostring(cfVip).." cfLevel="..tostring(cfLevel));
        return true;
    end
    if cfVip.data > 0 and cfLevel.data > 0 then
        if vip < cfVip.data and level < cfLevel.data then
            return true;
        end
    elseif cfVip.data > 0 then
        if vip < cfVip.data then
            return true;
        end
    elseif cfLevel.data > 0 then
        if level < cfLevel.data then
            return true;
        end
    end
    return false;
end


function UiLevelChallenge:GetCloneItem(index)
    if self.cloneItem[index] == nil then
        self.cloneItem[index] = UiSmallItem:new({obj = nil, parent = self.objParent[index], cardInfo = nil, is_enable_goods_tip = true});
    end
    return self.cloneItem[index];
end

function UiLevelChallenge:OnRaidsOne(t)
    if UiLevelChallenge.CheckFight(self.hurdleid, 1, UiLevelChallenge.OnRaidsOne, self, nil, self.goodsId, self.goodsCount) then
        msg_hurdle.cg_hurdle_saodang(self.hurdleid, 1, {id = self.goodsId, count=self.goodsCount});
    end
end

function UiLevelChallenge:OnRaidsTen(t)
    if UiLevelChallenge.CheckFight(self.hurdleid, raidsCount[self.selectTab], UiLevelChallenge.OnRaidsTen, self, nil, self.goodsId, self.goodsCount) then
        msg_hurdle.cg_hurdle_saodang(self.hurdleid, raidsCount[self.selectTab], {id = self.goodsId, count=self.goodsCount});
    end
end

function UiLevelChallenge:OnRaidsFifty(t)
    if UiLevelChallenge.CheckFight(self.hurdleid, 50, UiLevelChallenge.OnRaidsFifty, self, nil, self.goodsId, self.goodsCount) then
        msg_hurdle.cg_hurdle_saodang(self.hurdleid, 50, {id = self.goodsId, count=self.goodsCount});
    end
end

function UiLevelChallenge:OnStartFight(t)
    if g_dataCenter.chatFight:CheckMyRequest() then
        return
    end
    if UiLevelChallenge.CheckFight(self.hurdleid, 0, UiLevelChallenge.OnStartFight, self, nil, self.goodsId, self.goodsCount) then
        msg_hurdle.cg_hurdle_fight(self.hurdleid, PublicFunc.GetIsAuto(self.hurdleid));
    end
end

function UiLevelChallenge:OnReset(t)
    Hurdle.HurdleReset(self.hurdleid);
end

function UiLevelChallenge.CheckFight(hurdleid, raidsTimes, func, obj, param, goodsId, goodsCount)
    local hurdleInfo = ConfigHelper.GetHurdleConfig(hurdleid);
    if not hurdleInfo then
        return false;
    end
    local info = g_dataCenter.hurdle:GetHurdleByHurdleid(hurdleid);
    if g_dataCenter.player:GetLevel() < hurdleInfo.need_level then
        FloatTip.Float(string.format(gs_misc['str_68'], hurdleInfo.need_level));
        return false;
    end
    if hurdleInfo.hurdle_type == EHurdleType.eHurdleType_elite then
        if hurdleInfo.type_param > 0 then
            local otherInfo = g_dataCenter.hurdle:GetHurdleByHurdleid(hurdleInfo.type_param);
            if not otherInfo then
                local cf = ConfigHelper.GetHurdleConfig(hurdleInfo.type_param);
                FloatTip.Float(string.format(gs_misc['str_53'], cf.index));
                return false;
            end
        end
    end
    --检测扫荡次数
    if hurdleInfo.max_count > 0 and info and hurdleInfo.max_count - info.period_post_times <= 0 then
        Hurdle.HurdleReset(hurdleid, func, obj, param);
        return false;
    end
    --扫荡判断vip等级
    if raidsTimes > 0 then
        if not info then
            FloatTip.Float(gs_misc['str_74']);
            return false;
        end
        local level = g_dataCenter.player.level;
        local vip = g_dataCenter.player.vip;
        local cfVip;
        local cfLevel;
        if info.star_num < 3 then
            cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalNo3StarRaidsVip + hurdleInfo.hurdle_type * 2);
            cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalNo3StarRaidsLevel + hurdleInfo.hurdle_type * 2);
            --vip或者等级有限制的话
            if cfVip.data > 0 and cfLevel.data > 0 then 
                if vip < cfVip.data and level < cfLevel.data then
                    local cf = g_dataCenter.player:GetVipDataConfigByLevel(cfVip.data);
                    if cf then
                        FloatTip.Float(string.format(gs_misc['hurdle_1'], cf.level, cf.level_star, cfLevel.data));
                    end
                    return false;
                end
            elseif cfVip.data > 0 then
                if vip < cfVip.data then
                    local cf = g_dataCenter.player:GetVipDataConfigByLevel(cfVip.data);
                    if cf then
                        FloatTip.Float(string.format(gs_misc['hurdle_2'], cf.level, cf.level_star));
                    end
                    return false;
                end
            elseif cfLevel.data > 0 then
                if level < cfLevel.data then
                    FloatTip.Float(string.format(gs_misc['hurdle_3'], cfLevel.data));
                    return false;
                end
            end
        end

        if raidsTimes == 1 then
            cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids1Vip + hurdleInfo.hurdle_type * 6);
            cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids1Level + hurdleInfo.hurdle_type * 6);
        elseif raidsTimes == 3 then
            cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleEliteRaids3Vip);
            cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleEliteRaids3Level);
        elseif raidsTimes == 10 then
            cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids10Vip);
            cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids10Level);
        elseif raidsTimes == 50 then
            cfVip = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids50Vip);
            cfLevel = ConfigManager.Get(EConfigIndex.t_discrete, 
                MsgEnum.ediscrete_id.eDiscreteID_hurdleNormalRaids50Level);
        else
            cfVip = nil;
            cfLevel = nil;
        end
        if not cfVip or not cfLevel then
            app.log("出数据错误了 cfVip="..tostring(cfVip).." cfLevel="..tostring(cfLevel));
            return false;
        end

        if cfVip.data > 0 and cfLevel.data > 0 then
            if vip < cfVip.data and level < cfLevel.data then
                local cf = g_dataCenter.player:GetVipDataConfigByLevel(cfVip.data);
                if cf then
                    FloatTip.Float(string.format(gs_misc['hurdle_4'], cf.level, cf.level_star, cfLevel.data));
                end
                return false;
            end
        elseif cfVip.data > 0 then
            if vip < cfVip.data then
                local cf = g_dataCenter.player:GetVipDataConfigByLevel(cfVip.data);
                if cf then
                    FloatTip.Float(string.format(gs_misc['hurdle_5'], cf.level, cf.level_star));
                end
                return false;
            end
        elseif cfLevel.data > 0 then
            if level < cfLevel.data then
                FloatTip.Float(string.format(gs_misc['hurdle_6'], cfLevel.data));
                return false;
            end
        end
    end
    --检测体力
    local oneCostAp = hurdleInfo.cost_ap;
    local costAp = hurdleInfo.cost_ap;
    --修改为扫荡判断体力够不够扫荡那么多次  弹出提示
    if raidsTimes > 0 then
        oneCostAp = hurdleInfo.saodang_cost_num;
        costAp = hurdleInfo.saodang_cost_num * raidsTimes;
    end
    if g_dataCenter.player.ap < costAp then
        local realTimes = math.floor(g_dataCenter.player.ap / oneCostAp);
        if realTimes == 0 then
            HpExchange.popPanel();
        else
            HintUI.SetAndShow(EHintUiType.two, string.format(gs_misc['str_90'], realTimes), 
                {str = gs_misc['str_44'], func=function()
                    msg_hurdle.cg_hurdle_saodang(hurdleid, raidsTimes, {id = goodsId, count=goodsCount});
                end}, {str = gs_misc['str_45']});
        end
        --Player.ShowBuyAp();
        return false;
    end
    return true;
end
local maxRaidsCount = {[0] = 10, [1] = 3};
function UiLevelChallenge:OnRaidsResult(hurdle_id, times, needItems, realTimes, getItemsCount, drop_items, awardsEx)
    -- app.log(table.tostring({hurdleid=hurdle_id, 
    --     drop_items=drop_items, 
    --     awardsEx=awardsEx, 
    --     raidsTime=times, 
    --     goodsId=self.goodsId, 
    --     goodsCount=self.goodsCount}))
    if #drop_items > 0 or #awardsEx > 0 then
    	local cf = ConfigHelper.GetHurdleConfig(hurdle_id);
    	if not cf then
    	    return;
    	end
        local name = ""
        if times == 1 then
            name = gs_misc['str_84'];
        else
            name = string.format(gs_misc['str_78'], times);
        end

        -- 双倍
        local hurdle_type = ENUM.Double.hurdle_normal;
        if cf.hurdle_type == 1 then
            hurdle_type = ENUM.Double.hurdle_elite;
        end

        local raidsGetItems = {}
        local exRaidsGetItems = {}
        -- app.log("扫荡获得物品打印开始--------------------------------------------------------------")
        -- app.log("------------" ..table.tostring(drop_items))
        local str = "";
        for k,v in pairs(drop_items) do
            if v and v.awards then
                for k2, v2 in pairs(v.awards) do                    
                    if v2 ~= nil then
                        v2.radio_num = g_dataCenter.activityReward:GetDoubleByID(hurdle_type, v2.id);
                        if v2.radio_num > 1 then
                            v2.count = v2.count / v2.radio_num;
                        end
                        -- local cf = ConfigManager.Get(EConfigIndex.t_item, v2.id);
                        -- if cf then
                        --     str = string.format("%s\t%d\t%s\t%d", str, tostring(v2.id), tostring(cf.name), tostring(v2.count));
                        -- else
                        --     app.log("config error id="..tostring(v2.id));
                        -- end
                    end
                end
                -- app.log(str);
            end
            if v and v.actEx_items then
                for k1, v1 in pairs(v.actEx_items) do
                    v1.isExtraActivity = "额外";
                    table.insert(v.awards, v1);
                end
            end
        end
        -- app.log("扫荡获得物品打印结束--------------------------------------------------------------");
        
        table.insert(drop_items, {isAwardsEx=true, awards=awardsEx});
        CommonRaids.Start({
            goodsId = self.goodsId,
            goodsCount=self.goodsCount,
            getItemsCount = getItemsCount,
            realTimes = realTimes,
            drop_items=drop_items,
            callbackAgain={name=name, call=UiLevelChallenge.AgainRaids, callObj=self, param=times},
            callbackOk = {name = gs_misc['ok'], call = UiLevelChallenge.OkRaids, callObj = self, },
            })
        self:UpdateUi();
    else
        FloatTip.Float("扫荡完成");
    end
end

function UiLevelChallenge:AgainRaids(param)
    local cf = ConfigHelper.GetHurdleConfig(self.hurdleid);
    if not cf then
        return;
    end
    -- local raidsTime = param;
    -- if raidsTime ~= 1 then
    --     raidsTime = maxRaidsCount[cf.hurdle_type];
    -- end
    if UiLevelChallenge.CheckFight(self.hurdleid, param, UiLevelChallenge.AgainRaids, self, param, self.goodsId, self.goodsCount) then
        msg_hurdle.cg_hurdle_saodang(self.hurdleid, param, {id = self.goodsId, count=self.goodsCount});
    end
end

function UiLevelChallenge:OkRaids()
    uiManager:PopUi();
    --神秘商店弹窗    
    if g_dataCenter.shopInfo:IsShowPopup() then
        g_dataCenter.shopInfo:SetShowPopup(false)
        MysteryShopPopupUI.ShowPopup() 
    end
end

function UiLevelChallenge:OnExit()
    uiManager:PopUi(EUI.UiLevelChallenge);
end

function UiLevelChallenge:OnEnterFight()
    uiManager:PopUi(EUI.UiLevelChallenge);
end
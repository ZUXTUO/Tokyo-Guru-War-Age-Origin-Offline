UiJiaoTangQiDaoBeginFight = Class('UiJiaoTangQiDaoBeginFight', UiBaseClass);
local pathRes = { };
pathRes.test = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1604_church_guaji.assetbundle';
-- 点击挑战按钮后，1：不发生什么  2：挂机  3：挑战
local EAfterGetReward =
{
    none = 1,
    hook = 2,
    chanllenge = 3,
}
--------------------------------------------------
-- 初始化
function UiJiaoTangQiDaoBeginFight:Init()
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1604_church_guaji.assetbundle';
    UiBaseClass.Init(self)
    -- self:InitData();
    -- self:Restart();
end

-- 重新开始
function UiJiaoTangQiDaoBeginFight:Restart()
    UiBaseClass.Restart(self)
    -- if self.ui then
    --     return;
    -- end
    -- self:RegistFunc();
    -- self:MsgRegist();
    -- self:InitUi();
end

-- 初始化数据
function UiJiaoTangQiDaoBeginFight:InitData()
    UiBaseClass.InitData(self)
    -- self.ui = nil;
    -- self.bindfunc = {};
    self.scard = { };
end

-- 析构函数
function UiJiaoTangQiDaoBeginFight:DestroyUi()
    UiBaseClass.DestroyUi(self)
    -- self.ui = nil;
    -- self:MsgUnRegist();
    -- self:UnregistFunc();
    -- for k,v in pairs(self.texture) do
    --     v:Destroy();
    --     self.texture[k] = nil;
    -- end
    for k, v in pairs(self.scard) do
        v:DestroyUi();
        self.scard[k] = nil;
    end
end

-- 显示ui
function UiJiaoTangQiDaoBeginFight:Show()
    UiBaseClass.Show(self)
    -- self:MsgRegist();
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(true);
end

-- 隐藏ui
function UiJiaoTangQiDaoBeginFight:Hide()
    UiBaseClass.Hide(self)
    -- self:MsgUnRegist();
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(false);
end

-- 注册回调函数
function UiJiaoTangQiDaoBeginFight:RegistFunc()
    UiBaseClass.RegistFunc(self)
    -- self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_chanllenge'] = Utility.bind_callback(self, self.on_chanllenge);
    self.bindfunc['GetReward'] = Utility.bind_callback(self, self.GetReward);
    self.bindfunc['after_get_challenge'] = Utility.bind_callback(self, self.after_get_challenge);
    self.bindfunc['on_close'] = Utility.bind_callback(self, self.on_close);
    self.bindfunc['gc_btn_get'] = Utility.bind_callback(self, self.gc_btn_get);
end

-- 注销回调函数
function UiJiaoTangQiDaoBeginFight:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self)
    -- for k,v in pairs(self.bindfunc) do
    --     if v ~= nil then
    --         Utility.unbind_callback(self, v);
    --     end
    -- end
end

-- 注册消息分发回调函数
function UiJiaoTangQiDaoBeginFight:MsgRegist()
    UiBaseClass.MsgRegist(self)
    -- PublicFunc.msg_regist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_btn_get']);
end

-- 注销消息分发回调函数
function UiJiaoTangQiDaoBeginFight:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    -- PublicFunc.msg_unregist(msg_activity.gc_churchpray_reward,self.bindfunc['gc_btn_get']);
end

-- 初始化UI
function UiJiaoTangQiDaoBeginFight:LoadUI()
    UiBaseClass.LoadUI(self)
end

-- --资源加载回调
-- function UiJiaoTangQiDaoBeginFight:on_loaded(pid, filepath, asset_obj, error_info)
--     if filepath == pathRes.test then
--         self:FindNguiObject(asset_obj);
--     end
-- end

-- 寻找ngui对象
function UiJiaoTangQiDaoBeginFight:InitUI(obj)
    UiBaseClass.InitUI(self, obj)
    -- self.ui = asset_game_object.create(obj);
    self.ui:set_parent(Root.get_root_ui_2d_fight());
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_name('ui_1604_church_guaji');

    self.btn_chanllenge = ngui.find_button(self.ui, "centre_other/btn_fork");
    self.btn_chanllenge:set_on_click(self.bindfunc['on_chanllenge'], "MyButton.NoneAudio");

    self.lab_name = { };
    self.lab_fight_value = { };
    self.go_cards = { };

    for i = 1, 2 do
        local t_name = "sp_left_diban"
        if i == 2 then
            t_name = "sp_right_diban"
        end
        self.lab_name[i] = ngui.find_label(self.ui, "centre_other/content/" .. t_name .. "/lab_name");
        self.lab_fight_value[i] = ngui.find_label(self.ui, "centre_other/content/" .. t_name .. "/lab_zhan_li");
        self.go_cards[i] = self.ui:get_child_by_name("centre_other/content/" .. t_name .. "/big_card_item_80");
    end
    self.btn_close = ngui.find_button(self.ui, "centre_other/btn_cha");
    self.btn_close:set_on_click(self.bindfunc['on_close']);

    self:UpdateUi();
end

-- 刷新界面
function UiJiaoTangQiDaoBeginFight:UpdateUi()
    UiBaseClass.UpdateUi(self)
    if not self.ui then
        return
    end
    self.enterStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex();
    self.curIndex = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurIndex();
    self.curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);

    local my_name = g_dataCenter.player.name;
    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local cardhuman = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero, heroid);
    local fight_value = cardhuman:GetFightValue();
    self.lab_name[1]:set_text(my_name);
    self.lab_fight_value[1]:set_text(tostring(fight_value));
    --if not self.scard[1] then
    self.scard[1] = SmallCardUi:new( { parent = self.go_cards[1], info = cardhuman,stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Star,SmallCardUi.SType.Rarity} });
    --else
    --end
    --self.scard[1]:SetData(cardhuman, self.go_cards[1]);
    -- self.texture[1]:set_texture(cardhuman.small_icon);
    -- item_manager.texturePadding(self.texture[1],cardhuman.small_icon);


    local chanllenge_pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
    local enemy_player = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetHeroInfo(self.enterStar, chanllenge_pos);
    self.lab_name[2]:set_text(enemy_player.name);
    heroid = enemy_player:GetDefTeam()[1];
    cardhuman = enemy_player.package:find_card(ENUM.EPackageType.Hero, heroid);
    fight_value = cardhuman:GetFightValue();
    self.lab_fight_value[2]:set_text(tostring(fight_value));
   
    self.scard[2] = SmallCardUi:new( { parent = self.go_cards[2], info = cardhuman,stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Star,SmallCardUi.SType.Rarity} });
     
end

function UiJiaoTangQiDaoBeginFight:on_chanllenge(t)
    self:Hide()
    if self.enterStar == 1 then
        -- 1星教堂不能挑战
        return;
    end
    local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local level = g_dataCenter.player.level;
    local chanllenge_pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
    if not chanllenge_pos then return end
    -- 正在挂机
    if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(1) then
        local curExp;
        local enterExp;
        if chanllenge_pos == 0 then
                        enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data, level)["boss_exp_reward" .. tostring(self.enterStar)];
        else
                        enterExp = ConfigManager.Get(EConfigIndex.t_church_pray_data, level)["normal_exp_reward" .. tostring(self.enterStar)];
        end
        local curPos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetChurchPosIndex(1);
        if self.curStar == 1 then
                        curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data, level)["normal_exp_reward" .. tostring(self.curStar)];
        else
            if curPos == 0 then
                                curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data, level)["boss_exp_reward" .. tostring(self.curStar)];
            else
                                curExp = ConfigManager.Get(EConfigIndex.t_church_pray_data, level)["normal_exp_reward" .. tostring(self.curStar)];
            end
        end
        -- 判断是高级还是低级
        if enterExp >= curExp then
            FightScene.GetFightManager().jiaotangqidao_fightui:ShowTips(true, false);
            -- HintUI.SetAndShow(EHintUiType.two,"是否确认挂机并领取现有的挂机经验",{str="确认",func = self.bindfunc["GetReward"]},{str="取消"});
        else
            FightScene.GetFightManager().jiaotangqidao_fightui:ShowTips(true, true);
            -- HintUI.SetAndShow(EHintUiType.two,"您挂机的位置经验获得速度低于现有位置，是否确认挂机并领取现有的挂机经验",{str="确认",func = self.bindfunc["GetReward"]},{str="取消"});
        end
    else
        local param = { };
        param[1] = tostring(tempHeroID);
        param[2] = tostring(1);
        param[3] = tostring(1);
        param[4] = tostring(1);
        msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
    end
end

function UiJiaoTangQiDaoBeginFight:GetReward()
    msg_activity.cg_churchpray_reward(self.curIndex)
end

-- function UiJiaoTangQiDaoBeginFight:gc_btn_get(result, expReward, index, vecReward)
--     if vecReward and type(vecReward) == "table" and #vecReward ~=0 then
--         CommonAward.Start(vecReward, 1)
--         CommonAward.SetFinishCallback(self.after_get_challenge, self)
--     else
--         HintUI.SetAndShow(EHintUiType.one, "挂机时间过短，无奖励",{str="确定", func = self.bindfunc["after_get_challenge"]});
--     end
-- end

-- function UiJiaoTangQiDaoBeginFight:after_get_challenge()
--     local tempHeroID = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
--     local pos = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurChanllengePos();
--     if not pos then return end
--     local param = {};
--     param[1] = tostring(tempHeroID);
--     param[2] = tostring(self.enterStar);
--     param[3] = tostring(pos);
--     param[4] = tostring(1);
--     msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao, param)
-- end

function UiJiaoTangQiDaoBeginFight:on_close()
    self:Hide();
end
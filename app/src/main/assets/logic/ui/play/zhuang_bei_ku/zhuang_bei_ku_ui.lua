--[[ZhuangBeiKuUI = Class("ZhuangBeiKuUI",UiBaseClass);

function ZhuangBeiKuUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/equipment_base/ui_903_hero_suffering.assetbundle";
    UiBaseClass.Init(self, data);
end

function ZhuangBeiKuUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.warp = nil;
    self.labCont = nil;
    self.labName = nil;
    self.labDetailed = nil;
    self.spHead = nil;
    self.reward = {};
    self.choseItem = nil;
    self.choseInfo = nil

    self.ItemList = {};
    self.ItemObj = {};
    self.hurdle = {};
end

function ZhuangBeiKuUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,ZhuangBeiKuUI.on_init_item);
    self.bindfunc["on_rule"] = Utility.bind_callback(self,ZhuangBeiKuUI.on_rule);
    self.bindfunc["on_start"] = Utility.bind_callback(self,ZhuangBeiKuUI.on_start);
    self.bindfunc["on_chose_card"] = Utility.bind_callback(self,ZhuangBeiKuUI.on_chose_card);
    self.bindfunc["on_init_hurdle"] = Utility.bind_callback(self,ZhuangBeiKuUI.on_init_hurdle);
end

function ZhuangBeiKuUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);
	self.ui:set_name("yingxionglilian_ui");

    self.labCont = ngui.find_label(self.ui,"centre_other/animation/right_animation/Sprite/lab_surplus_num");

    self.labName = ngui.find_label(self.ui,"centre_other/animation/right_animation/Sprite/lab_name");
    self.spHead = ngui.find_sprite(self.ui,"centre_other/right_animation/Sprite/content/sp_back/text_human");
    self.spMark = ngui.find_sprite(self.ui,"centre_other/right_animation/Sprite/sp_back1/sp_mark");
    self.labDetailed = ngui.find_label(self.ui,"centre_other/right_animation/lab_human_introduce");
    self.spNeedLevel = ngui.find_sprite(self.ui,"centre_other/right_animation/Sprite/content/sp_bk");
    self.labNeedLevel = ngui.find_label(self.ui,"centre_other/right_animation/Sprite/content/sp_bk/lab");

    self.reward = {};
    for i=1,4 do
        self.reward[i] = {};
        self.reward[i].name = ngui.find_label(self.ui,"centre_other/right_animation/Sprite/sp_bk2/content/cont"..i.."/lab_name");
        local obj = self.ui:get_child_by_name("centre_other/right_animation/Sprite/sp_bk2/content/cont"..i.."/small_card_item1");
        self.reward[i].obj = UiSmallItem:new({obj=obj});
    end

    self.grid = ngui.find_wrap_content(self.ui,"centre_other/animation/left_animation/panel_list/wrap_content")
    self.grid:set_on_initialize_item(self.bindfunc["on_init_hurdle"]);
    self.scroll = ngui.find_scroll_view(self.ui,"centre_other/animation/left_animation/panel_list");

    local _btnRule = ngui.find_button(self.ui,"top_other/animation/btn_rule");
    _btnRule:set_on_click(self.bindfunc["on_rule"]);
    self.btnStart = ngui.find_button(self.ui,"centre_other/animation/right_animation/Sprite/btn_challenge");
    self.btnStart:set_on_click(self.bindfunc["on_start"], "MyButton.NoneAudio");
    self.btn2 = ngui.find_sprite(self.ui,"centre_other/animation/right_animation/Sprite/content1");
    self.btn2:set_active(false);
    local _btnStart = ngui.find_button(self.ui,"centre_other/animation/right_animation/Sprite/content1/btn_challenge")
    _btnStart:set_on_click(self.bindfunc["on_start"], "MyButton.NoneAudio");
    local _btnMopUp = ngui.find_button(self.ui,"centre_other/animation/right_animation/Sprite/content1/btn_mop_up")

    self:UpdateUi();
end

function ZhuangBeiKuUI:UpdateUi()
    UiBaseClass.UpdateUi(self)
    timer.create("zhuangbeiku_delay",100,1);
    function zhuangbeiku_delay()
        local cont = ConfigManager.GetDataCount(EConfigIndex.t_zhuang_bei_ku);
        local num = math.ceil(cont/3);
        self.grid:set_min_index(-num+1);
        self.grid:set_max_index(0);
        self.grid:reset();
        self.scroll:reset_position();
        self:UpdateSceneInfo(ENUM.EUPDATEINFO.activity);
    end
end

function ZhuangBeiKuUI:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.YingXiongLiLian)
end

function ZhuangBeiKuUI:on_start()
    local fs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu];
    local cur,max = fs:GetNumber();
    if cur > max then
        HintUI.SetAndShow(EHintUiType.zero,string.format("次数已用完",hurdle.need_level));
        return;
    end
    local hurdle_id = self.choseInfo.hurdle_id;
    local hurdle = ConfigHelper.GetHurdleConfig(hurdle_id);

    -- 玩法限制作弊 (英雄历练 -- 等级)
    local need_level = hurdle.need_level
    if g_dataCenter.gmCheat:noPlayLimit() then
        need_level = 1
    end

    if need_level <= g_dataCenter.player.level then
        FightRecord.Clear();
        local defTeam = g_dataCenter.player:GetDefTeam()
        fs:SetLevelIndex(hurdle_id);
        fs:SetPlayMethod(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu);
        fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
        msg_activity.cg_enter_activity(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu,fs:Tostring());
        AudioManager.Stop(nil, true);
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);
    else
        HintUI.SetAndShow(EHintUiType.zero,string.format("需要等级%d开启",hurdle.need_level));
    end
end

function ZhuangBeiKuUI:on_chose_card(t)
    local index = t.float_value;
    if self.choseItem then
        self.choseItem:set_active(false);
    end
    self.choseItem = self.hurdle[index].shine;
    self.choseInfo = ConfigManager.Get(EConfigIndex.t_zhuang_bei_ku,index+60051000);
    local hurdle = ConfigHelper.GetHurdleConfig(self.choseInfo.hurdle_id);
    -- if hurdle.need_level <= g_dataCenter.player.level then
    self.choseItem:set_active(true);
    -- end

    self:UpdateInfo();
end

function ZhuangBeiKuUI:UpdateInfo()
    local hurdle_id = self.choseInfo.hurdle_id;
    local hurdle = ConfigHelper.GetHurdleConfig(hurdle_id);
    self.labName:set_text(hurdle.name);
    self.labDetailed:set_text(hurdle.des);
    if g_dataCenter.player:GetLevel() >= hurdle.need_level then 
        self.spNeedLevel:set_active(false);
    else
        self.spNeedLevel:set_active(true);
        self.labNeedLevel:set_text(tostring(hurdle.need_level).."级开启挑战");
    end
    -- self.spHead:set_texture(self.choseInfo.icon120);
    PublicFunc.Set120Icon(self.spHead,self.choseInfo.icon120);
    local drop_id = hurdle.pass_award
    local drop_list = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
    for i=1,4 do
        local drop = drop_list[i];
        if drop and drop ~= 0 then
            self.reward[i].obj:Show()
            local info = PublicFunc.IdToConfig(drop.goods_id);
            self.reward[i].name:set_text(info.name);
            self.reward[i].name:set_active(true);
            if PropsEnum.IsEquip(drop.goods_id) then
                self.reward[i].obj:SetData(CardEquipment:new({number=drop.goods_id}))
            elseif PropsEnum.IsItem(drop.goods_id) or PropsEnum.IsVaria(drop.goods_id) then
                self.reward[i].obj:SetData(CardProp:new({number=drop.goods_id,count=drop.goods_number}))
            end
        else
            self.reward[i].obj:SetData(nil)
            self.reward[i].obj:Hide()
            self.reward[i].name:set_active(false);
        end
    end
end

function ZhuangBeiKuUI:UpdateSceneInfo(info_type)
    if info_type == ENUM.EUPDATEINFO.activity then
        local PlayMethodCfg = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu];
        local cur,max = PlayMethodCfg:GetNumber();
        if self.ui then
            self.labCont:set_text(tostring(cur).."/"..tostring(max));
        else
        end
    end
end

function ZhuangBeiKuUI:on_init_hurdle(obj,b,real_id)
    for i=1,3 do
        local card = ngui.find_button(obj,"big_card"..i);
        local id = math.abs(real_id)*3+i;
        local cfg = ConfigManager.Get(EConfigIndex.t_zhuang_bei_ku,id+60051000);
        card:reset_on_click();
        card:set_on_click(self.bindfunc["on_chose_card"])
        card:set_event_value("",id);
        if cfg then
            card:set_active(true);
            local hurdle_id = cfg.hurdle_id;
            local hurdle = ConfigHelper.GetHurdleConfig(hurdle_id);
            -- if self.hurdle[id] and self.hurdle[id].head then
            --     self.hurdle[id].head:Destroy();
            -- end
            self.hurdle[id] = {};
            self.hurdle[id].head = ngui.find_sprite(obj,"big_card"..i.."/content/text_human");
            self.hurdle[id].shine = ngui.find_sprite(obj,"big_card"..i.."/content/sp_shine");
            self.hurdle[id].shine:set_active(false);
            local _spNew = ngui.find_sprite(obj,"big_card"..i.."/content/sp_new");
            local _spMark = ngui.find_sprite(obj,"big_card"..i.."/content/sp_mark");
            -- local _labName = ngui.find_label(obj,"big_card"..i.."/content/sp_title/lab");

            -- self.hurdle[id].head:set_texture(cfg.icon120);
            PublicFunc.Set120Icon(self.hurdle[id].head,cfg.icon120);
            -- _labName:set_text(hurdle.name);
            if hurdle.need_level <= g_dataCenter.player.level then
                _spMark:set_active(false);
                if hurdle.need_level == g_dataCenter.player.level then
                    _spNew:set_active(true);
                else
                    _spNew:set_active(false);
                end
            else
                _spNew:set_active(false);
                _spMark:set_active(true);
            end
            if not self.choseInfo or self.choseInfo.hurdle_id == hurdle_id then
                self:on_chose_card({float_value=id});
            end
        else
            card:set_active(false);
        end
    end
end

function ZhuangBeiKuUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.choseItem = nil;
    self.choseInfo = nil;
    -- for k,v in pairs(self.hurdle) do
    --     v.head:Destroy();
    --     v.head = nil;
    -- end
    self.hurdle = {};
    -- if self.spHead then
    --     self.spHead:Destroy();
    --     self.spHead = nil;
    -- end
    if self.reward then
        for k,v in pairs(self.reward) do
            v.obj:DestroyUi();
            v.obj = nil;
        end
        self.reward = nil;
    end
    for k,v in pairs(self.ItemObj) do
        v:Destroy();
    end
end

function ZhuangBeiKuUI:Restart()
    if not UiBaseClass.Restart(self) then return end;
    msg_activity.cg_activity_config(MsgEnum.eactivity_time.eActivityTime_zhuangBeiKu);
end]]

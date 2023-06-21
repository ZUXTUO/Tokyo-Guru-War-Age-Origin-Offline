GhoulHeroUI = Class("GhoulHeroUI",UiBaseClass);

function GhoulHeroUI:Init(param)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/ghoul_assault/ui_904_develop_fight.assetbundle";
    self._super.Init(self, param);
end

function GhoulHeroUI:InitData(data)
    self._super.InitData(self, data);
    self.heroCardObj = {};
    self.TeamCardObj = {};
    self.heroList = {};
    self.humanPool = nil;
    self.teamInfo = {};
    self.isDisable = false;
    self.difficulty = 0;
    self.curShowType = ENUM.EProType.All;
end

function GhoulHeroUI:RegistFunc()
    self._super.RegistFunc(self);
    self.bindfunc["on_hero_package"] = Utility.bind_callback(self,GhoulHeroUI.on_hero_package);
    self.bindfunc["on_first_team"] = Utility.bind_callback(self,GhoulHeroUI.on_first_team);
    self.bindfunc["on_alternate_hero"] = Utility.bind_callback(self,GhoulHeroUI.on_alternate_hero);
    self.bindfunc["on_chose_hero"] = Utility.bind_callback(self,GhoulHeroUI.on_chose_hero);
    self.bindfunc["on_cannt_chose"] = Utility.bind_callback(self,GhoulHeroUI.on_cannt_chose);
    self.bindfunc["on_cancel_chose"] = Utility.bind_callback(self,GhoulHeroUI.on_cancel_chose);
    self.bindfunc["on_start"] = Utility.bind_callback(self,GhoulHeroUI.on_start);
    self.bindfunc["on_click_tab"] = Utility.bind_callback(self, GhoulHeroUI.on_click_tab);
    self.bindfunc["on_join_game"] = Utility.bind_callback(self, GhoulHeroUI.on_join_game);
end

function GhoulHeroUI:InitUI(obj)
    self._super.InitUI(self, obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ghoul_hero");

    self.warpHeroPackage = ngui.find_wrap_content(self.ui,"centre_other/scroview/scrollview_nature/warp_content");
    self.warpHeroPackage:set_on_initialize_item(self.bindfunc["on_hero_package"]);
    self.warpFirstTeam = ngui.find_wrap_content(self.ui,"centre_other/animation/right_other/panel_list1/wrap_content");
    self.warpFirstTeam:set_min_index(-2);
    self.warpFirstTeam:set_max_index(0);
    self.warpFirstTeam:set_on_initialize_item(self.bindfunc["on_first_team"]);
    self.warpFirstTeam:reset();
    -- self.warpAlternateHero = ngui.find_wrap_content(self.ui,"centre_other/animation/right_other/panel_list2/wrap_content");
    -- self.warpAlternateHero:set_min_index(-1);
    -- self.warpAlternateHero:set_max_index(0);
    -- self.warpAlternateHero:set_on_initialize_item(self.bindfunc["on_alternate_hero"]);
    -- self.warpAlternateHero:reset();
    for i=1,6 do
        local id = i+3;
        local _btn = ngui.find_button(self.ui,"right_other/panel_list2/grid/big_card_item"..i);
        local obj = _btn:get_game_object();
        self.TeamCardObj[id] = SmallCardUi:new({obj=obj});
        self.TeamCardObj[id]:SetCallback(self.bindfunc["on_cancel_chose"]);
    end
    local _btnStart = ngui.find_button(self.ui,"centre_other/animation/right_other/btn_start");
    _btnStart:set_on_click(self.bindfunc["on_start"], "MyButton.NoneAudio");

    local btn1 = ngui.find_button(self.ui,"centre_other/left_other/yeka/yeka_all/sp");
    btn1:set_event_value("",ENUM.EProType.All);
    btn1:set_on_click(self.bindfunc["on_click_tab"]);
    local btn2 = ngui.find_button(self.ui,"centre_other/left_other/yeka/yeka_meat/sp");
    btn2:set_event_value("",ENUM.EProType.Fang);
    btn2:set_on_click(self.bindfunc["on_click_tab"]);
    local btn3 = ngui.find_button(self.ui,"centre_other/left_other/yeka/yeka_warrior/sp");
    btn3:set_event_value("",ENUM.EProType.Gong);
    btn3:set_on_click(self.bindfunc["on_click_tab"]);
    local btn4 = ngui.find_button(self.ui,"centre_other/left_other/yeka/yeka_energy/sp");
    btn4:set_event_value("",ENUM.EProType.Ji);
    btn4:set_on_click(self.bindfunc["on_click_tab"]);
    --local btn5 = ngui.find_button(self.ui,"centre_other/left_other/yeka/yeka_assist/sp");
    --btn5:set_event_value("",ENUM.EProType.Aid);
    --btn5:set_on_click(self.bindfunc["on_click_tab"]);

    self:UpdatePackage();
    self:UpdateTeamInfo();
end

function GhoulHeroUI:SetDifficulty(num)
    self.difficulty = num;
    self:UpdateTeamInfo();
end

function GhoulHeroUI:on_click_tab(t)
    self.curShowType = t.float_value;
    self:UpdatePackage();
end

function GhoulHeroUI:on_hero_package(obj,b,real_id)
    for i=1,3 do
        local card = ngui.find_button(obj,"big_card_item"..i);
        local id = math.abs(real_id)*3+i;
        local pid = id;
        if self.heroList[id] then
            card:set_active(true);
            if self.heroCardObj[pid] == nil then
                self.heroCardObj[pid] = SmallCardUi:new({obj=card:get_game_object(),atlas=self.humanPool});
                self.heroCardObj[pid]:SetCallback(self.bindfunc["on_chose_hero"]);
            end
            self.heroCardObj[pid]:SetData(self.heroList[id],card:get_game_object());
            if self.isDisable then
                self.heroCardObj[pid]:SetCallback(self.bindfunc["on_cannt_chose"])
            else
                self.heroCardObj[pid]:SetCallback(self.bindfunc["on_chose_hero"]);
            end
            self.heroCardObj[pid]:SetClick(true);
            self.heroCardObj[pid]:SetTeamPosIcon(0);
            for i=1,self.teamMaxCont do
                if self.teamInfo[i] and self.heroList[id].index == self.teamInfo[i].info.index then
                    if i <= 3 then
                        self.heroCardObj[pid]:SetTeamPosIcon(i);
                    else
                        self.heroCardObj[pid]:SetTeamPosIcon(4);
                    end
                    -- self.heroCardObj[pid]:SetClick(false);
                    break;
                end
            end
            self.heroCardObj[pid]:SetTranslucent(false);
        else
            card:set_active(false);
        end
    end
end

function GhoulHeroUI:on_first_team(obj,b,real_id)
    local team = self.teamInfo;
    local id = math.abs(real_id)+1;
    local pid = id;
    local card = team[id];
    if self.TeamCardObj[pid] == nil then
        self.TeamCardObj[pid] = SmallCardUi:new({obj=obj,atlas=self.humanPool});
        self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cancel_chose"]);
    end
    if id <= self.teamMaxCont then
        -- self.TeamCardObj[pid]:SetDisableIcon(self.isDisable);
        if card then
            self.TeamCardObj[pid]:SetData(card.info,obj);
            self.TeamCardObj[pid]:SetTeamPosIcon(id);
            self.TeamCardObj[pid]:SetAddIcon(false);
        else
            self.TeamCardObj[pid]:SetData(nil,obj);
            self.TeamCardObj[pid]:SetTeamPosIcon(0);
            self.TeamCardObj[pid]:SetAddIcon(false);
        end
        if self.isDisable then
            self.TeamCardObj[pid]:SetLock(true,"已锁定");
            self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cannt_chose"]);
        else
            self.TeamCardObj[pid]:SetLock(false);
        end
    else
        local str = ConfigManager.Get(EConfigIndex.t_ghoul_assault,id).level .. "级开启"
        self.TeamCardObj[pid]:SetLock(true,str);
        self.TeamCardObj[pid]:SetClick(false);
        -- if self.isDisable then
        --     self.TeamCardObj[pid]:SetAddIcon(false);
        --     self.TeamCardObj[pid]:SetLock(true,"已锁定");
        --     -- self.TeamCardObj[pid]:SetClick(false);
        -- else
        --     -- self.TeamCardObj[pid]:SetClick(true);
        -- end
    end
    self.TeamCardObj[pid]:SetTranslucent(false);
end

function GhoulHeroUI:on_alternate_hero(obj,b,real_id)
    for i=1,3 do
        local card = ngui.find_button(obj,"big_card_item"..i);
        local id = math.abs(real_id)*3+i+3;
        local pid = id;
        local team = self.teamInfo;
        local cardinfo = team[id];
        if self.TeamCardObj[pid] == nil then
            self.TeamCardObj[pid] = SmallCardUi:new({obj=card:get_game_object(),atlas=self.humanPool});
            self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cancel_chose"]);
        end
        if id <= self.teamMaxCont then
            if cardinfo then
                self.TeamCardObj[pid]:SetData(cardinfo.info,card:get_game_object());
                self.TeamCardObj[pid]:SetTeamPosIcon(4);
                self.TeamCardObj[pid]:SetAddIcon(false);
            else
                self.TeamCardObj[pid]:SetData(nil,card:get_game_object());
                self.TeamCardObj[pid]:SetTeamPosIcon(0);
                self.TeamCardObj[pid]:SetAddIcon(false);
            end
            if self.isDisable then
                self.TeamCardObj[pid]:SetLock(true,"已锁定");
                self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cannt_chose"]);
            else
                self.TeamCardObj[pid]:SetLock(false);
            end
        else
            local str = ConfigManager.Get(EConfigIndex.t_ghoul_assault,id).level .. "级开启"
            self.TeamCardObj[pid]:SetLock(true,str);
            self.TeamCardObj[pid]:SetClick(false);
        end
        -- if self.isDisable then
        --     self.TeamCardObj[pid]:SetClick(false);
        -- else
        --     self.TeamCardObj[pid]:SetClick(true);
        -- end
        self.TeamCardObj[pid]:SetTranslucent(false);
    end
end

function GhoulHeroUI:on_chose_hero(obj,cardinfo)
    if Utility.getTableEntityCnt(self.teamInfo) < self.teamMaxCont then
        local index = -1;
        for i=1,self.teamMaxCont do
            if self.teamInfo[i] == nil then
                if index == -1 then
                    index = i;
                end
            else
                if self.teamInfo[i].info.index == cardinfo.index then
                    index = -1;
                    return ;
                end
            end
        end
        if index ~= -1 then
            local max_hp = cardinfo:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
            self.teamInfo[index] = {info=cardinfo,hp=max_hp,isDead=false};
            if index <= 3 then
                obj:SetTeamPosIcon(index);
            else
                obj:SetTeamPosIcon(4);
            end
        end
        self:UpdateAlternateHero();
        self:UpdateFirstTeam();
    else
        HintUI.SetAndShow(EHintUiType.zero,"阵容已满");
    end
end

function GhoulHeroUI:on_cannt_chose()
    HintUI.SetAndShow(EHintUiType.zero,"未通关前无法更换阵容");
end

function GhoulHeroUI:on_cancel_chose(obj,cardinfo)
    if cardinfo then
        for i=1,self.teamMaxCont do
            if self.teamInfo[i] and cardinfo.index == self.teamInfo[i].info.index then
                self.teamInfo[i] = nil;
                -- self.teamFightInfo[i] = nil;
                break;
            end
        end
        self:UpdateAlternateHero();
        self:UpdateFirstTeam();
        self.warpHeroPackage:reset();
    end
end

function GhoulHeroUI:on_start()
    local defTeam = {};
    for k,v in pairs(self.teamInfo) do
        table.insert(defTeam,v.info.index);
    end
    if #defTeam == 0 and not self.isDisable then
        HintUI.SetAndShow(EHintUiType.zero,"请选择上阵英雄");
        return;
    end
    if #defTeam ~= self.teamMaxCont and not self.isDisable then
        HintUI.SetAndShow(EHintUiType.two,"战阵未满，是否开始试炼？", {str = "确定",func = self.bindfunc["on_join_game"]},{str="取消"});
        return;
    end
    self:on_join_game();
end

function GhoulHeroUI:on_join_game()
    local me = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB-1+self.difficulty;
    local fs = g_dataCenter.activity[me];
    local defTeam = {};
    local teamFightInfo = {};
    for i=1,self.teamMaxCont do
        local card = self.teamInfo[i];
        if card then
            local max_hp = card.hp or card.info:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
            table.insert(teamFightInfo,{index=card.info.index,hp=max_hp,isDead=card.isDead});
            if not card.isDead then
                table.insert(defTeam,card.info.index);
            end
        end
    end
    fs:SetLevelIndex(ConfigManager.Get(EConfigIndex.t_gao_su_ju_ji_hurdle,self.difficulty).level);
    fs:AddFightPlayer(g_dataCenter.fight_info.single_friend_flag, g_dataCenter.player, g_dataCenter.package, EFightPlayerType.human, defTeam)
    fs:SetExtParm({team = teamFightInfo,wave_id = fs.bigWave});
    fs:SetPlayMethod(me);
    fs.fightResult = 2;
    uiManager:PopUi(nil,true);
    msg_activity.cg_save_gaosujuji_struct(me,fs:GetActivityStruct());
    msg_activity.cg_enter_activity(me,fs:Tostring());
    AudioManager.Stop(nil, true);
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);
end

function GhoulHeroUI:UpdatePackage()
    --local _pack = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local _pack = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    self.heroList = {};
    for k,v in pairs(_pack) do
        if self.curShowType == ENUM.EProType.All 
            or self.curShowType == v.pro_type then
            table.insert(self.heroList,v);
        end
    end
    self.warpHeroPackage:set_min_index(-math.ceil(#self.heroList/3)+1);
    self.warpHeroPackage:reset();
end

function GhoulHeroUI:UpdateTeamInfo()
    if not self.ui then
        return;
    end
    self.teamInfo = {};
    -- 从服务器获得列表
    local me = MsgEnum.eactivity_time.eActivityTime_gaoSuJuJiB-1+self.difficulty;
    local hurdle_data = g_dataCenter.activity[me];
    if not hurdle_data then
        return;
    end
    local teamFightInfo = hurdle_data:GetHeroList();
    --app.log_warning("get team:"..table.tostring(teamFightInfo));
    -- if hurdle_data.bigWave == 0 then
    if #teamFightInfo == 0 then
        local defTeam = g_dataCenter.player:GetDefTeam();
        for i=1,3 do
            local card = defTeam[i];
            local info = g_dataCenter.package:find_card(1,card);
            if info then
                local max_hp = info:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
                table.insert(self.teamInfo,{info=info,hp=max_hp,isDead=false});
                -- local max_hp = 10000
                -- table.insert(self.teamFightInfo,{index=info.index,hp=max_hp,isDead=false});
            end
        end
        self.isDisable = false;
    else
        for i=1,#teamFightInfo do
            local card = teamFightInfo[i]
            local info = g_dataCenter.package:find_card(1,card.index);
            table.insert(self.teamInfo,{info=info,hp=card.hp,isDead=card.isDead});
        end
        self.isDisable = true;
    end
    self:UpdateFirstTeam();
    self:UpdateAlternateHero();
end

function GhoulHeroUI:UpdateFirstTeam()
    self.warpFirstTeam:reset();
end

function GhoulHeroUI:UpdateAlternateHero()
    -- self.warpAlternateHero:reset();
    for i=1,6 do
        local id = i+3;
        local pid = id;
        local team = self.teamInfo;
        local cardinfo = team[id];
        if id <= self.teamMaxCont then
            if cardinfo then
                self.TeamCardObj[pid]:SetData(cardinfo.info);
                self.TeamCardObj[pid]:SetTeamPosIcon(4);
                self.TeamCardObj[pid]:SetAddIcon(false);
            else
                self.TeamCardObj[pid]:SetData(nil);
                self.TeamCardObj[pid]:SetTeamPosIcon(0);
                self.TeamCardObj[pid]:SetAddIcon(false);
            end
            if self.isDisable then
                self.TeamCardObj[pid]:SetLock(true,"已锁定");
                self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cannt_chose"]);
            else
                self.TeamCardObj[pid]:SetLock(false);
            end
        else
            local str = ConfigManager.Get(EConfigIndex.t_ghoul_assault,id).level .. "级开启"
            self.TeamCardObj[pid]:SetLock(true,str);
            self.TeamCardObj[pid]:SetClick(false);
        end
        -- if self.isDisable then
        --     self.TeamCardObj[pid]:SetClick(false);
        -- else
        --     self.TeamCardObj[pid]:SetClick(true);
        -- end
        self.TeamCardObj[pid]:SetTranslucent(false);
    end
end

function GhoulHeroUI:DestroyUi()
    self._super.DestroyUi(self);
    self.difficulty = 0;
    self.isDisable = false;
    self.teamInfo = {};

    if self.humanPool then
        self.humanPool:Destroy();
    end
    self.humanPool = nil;
    for k,v in pairs(self.heroCardObj) do
        v:DestroyUi();
    end
    self.heroCardObj = {};
    for k,v in pairs(self.TeamCardObj) do
        v:DestroyUi();
    end
    self.TeamCardObj = {};
end

function GhoulHeroUI:Restart()
    self.teamMaxCont = 0;
    -- for i=1,#gd_ghoul_assault do
    for i=1, ConfigManager.GetDataCount(EConfigIndex.t_ghoul_assault) do
        if ConfigManager.Get(EConfigIndex.t_ghoul_assault,i).level <= g_dataCenter.player.level then
            self.teamMaxCont = i;  --可编人物最大数量
        end
    end
    self._super.Restart(self);
end

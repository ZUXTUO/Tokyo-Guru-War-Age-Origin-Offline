SupportHeroUI= Class("SupportHeroUI",UiBaseClass);

function SupportHeroUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_2403_support.assetbundle";
    UiBaseClass.Init(self, data);
end

function SupportHeroUI:InitData(data)
    UiBaseClass.InitData(self,data);
    self.heroCardObj = {};
    self.TeamCardObj = {};
    self.heroList = {};
    self.teamInfo = {};
    self.isDisable = false;
    self.difficulty = 0;
    self.curShowType = ENUM.EProType.All;
    self.teamMaxCont = 9
end

function SupportHeroUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_hero_package"] = Utility.bind_callback(self,self.on_hero_package);
    -- self.bindfunc["on_alternate_hero"] = Utility.bind_callback(self,self.on_alternate_hero);
    self.bindfunc["on_chose_hero"] = Utility.bind_callback(self,self.on_chose_hero);
    self.bindfunc["on_cannt_chose"] = Utility.bind_callback(self,self.on_cannt_chose);
    self.bindfunc["on_cancel_chose"] = Utility.bind_callback(self,self.on_cancel_chose);
    self.bindfunc["on_sure"] = Utility.bind_callback(self,self.on_sure);
    self.bindfunc["on_reset"] = Utility.bind_callback(self,self.on_reset);
    self.bindfunc["on_click_tab"] = Utility.bind_callback(self, self.on_click_tab);
    self.bindfunc["on_join_game"] = Utility.bind_callback(self, self.on_join_game);
end

function SupportHeroUI:InitUI(obj)
    UiBaseClass.InitUI(self,obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.warpHeroPackage = ngui.find_wrap_content(self.ui,"centre_other/animation/right_content/panel_list/wrap_content");
    self.warpHeroPackage:set_on_initialize_item(self.bindfunc["on_hero_package"]);
    self.scrollHeroPackage = ngui.find_scroll_view(self.ui,"centre_other/animation/right_content/panel_list");
    -- self.warpAlternateHero = ngui.find_wrap_content(self.ui,"centre_other/animation/right_other/panel_list2/wrap_content");
    -- self.warpAlternateHero:set_min_index(-1);
    -- self.warpAlternateHero:set_max_index(0);
    -- self.warpAlternateHero:set_on_initialize_item(self.bindfunc["on_alternate_hero"]);
    -- self.warpAlternateHero:reset();
    for i=1,6 do
        local card = ngui.find_button(self.ui,"centre_other/animation/left_content/content/big_card_item"..i);
        self.TeamCardObj[i] = SmallCardUi:new({obj=card:get_game_object()});
        self.TeamCardObj[i]:SetCallback(self.bindfunc["on_cancel_chose"]);
    end

    local _btnSure = ngui.find_button(self.ui,"centre_other/animation/left_content/btn_anniu2");
    _btnSure:set_on_click(self.bindfunc["on_sure"]);
    local _btnReset = ngui.find_button(self.ui,"centre_other/animation/left_content/btn_anniu1");
    _btnReset:set_on_click(self.bindfunc["on_reset"]);

    local btn1 = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka_all/sp");
    btn1:set_event_value("",ENUM.EProType.All);
    btn1:set_on_click(self.bindfunc["on_click_tab"]);
    local btn2 = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka_meat/sp");
    btn2:set_event_value("",ENUM.EProType.Fang);
    btn2:set_on_click(self.bindfunc["on_click_tab"]);
    local btn3 = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka_warrior/sp");
    btn3:set_event_value("",ENUM.EProType.Gong);
    btn3:set_on_click(self.bindfunc["on_click_tab"]);
    local btn4 = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka_energy/sp");
    btn4:set_event_value("",ENUM.EProType.Ji);
    btn4:set_on_click(self.bindfunc["on_click_tab"]);
    --local btn5 = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka_assist/sp");
    --btn5:set_event_value("",ENUM.EProType.Aid);
    --btn5:set_on_click(self.bindfunc["on_click_tab"]);

    self:UpdatePackage();
    self:UpdateTeamInfo();
end

-- team = {{index,hp,isDead},{index,hp,isDead},};
function SupportHeroUI:SetTeam(team,is_lock,open_num)
    self.teamInfo = {};
    for i=1,#team do
        local card = team[i]
        local info = g_dataCenter.package:find_card(1,card.index);
        table.insert(self.teamInfo,{info=info,hp=card.hp,isDead=card.isDead});
    end
    self.teamMaxCont = open_num;  --可编人物最大数量
    self.isDisable = is_lock;
    self:UpdateTeamInfo();
end

function SupportHeroUI:SetSureCallback(func)
    self.sureCallback = func;
end

function SupportHeroUI:on_click_tab(t)
    self.curShowType = t.float_value;
    self:UpdatePackage();
end

function SupportHeroUI:on_hero_package(obj,b,real_id)
    for i=1,3 do
        local card = ngui.find_button(obj,"big_card_item"..i);
        local id = math.abs(real_id)*3+i;
        local pid = id;
        if self.heroList[id] then
            card:set_active(true);
            if self.heroCardObj[pid] == nil then
                self.heroCardObj[pid] = SmallCardUi:new({obj=card:get_game_object()});
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
                        self.heroCardObj[pid]:SetTranslucent(true);
                        self.heroCardObj[pid]:SetClick(false);
                    else
                        self.heroCardObj[pid]:SetTeamPosIcon(4);
                    end
                    break;
                end
            end
            self.heroCardObj[pid]:SetTranslucent(false);
        else
            card:set_active(false);
        end
    end
end

-- function SupportHeroUI:on_alternate_hero(obj,b,real_id)
--     for i=1,3 do
--         local card = ngui.find_button(obj,"big_card_item"..i);
--         local id = math.abs(real_id)*3+i+3;
--         local pid = id;
--         local team = self.teamInfo;
--         local cardinfo = team[id];
--         if self.TeamCardObj[pid] == nil then
--             self.TeamCardObj[pid] = SmallCardUi:new({obj=card:get_game_object()});
--             self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cancel_chose"]);
--         end
--         if id <= self.teamMaxCont then
--             if cardinfo then
--                 self.TeamCardObj[pid]:SetData(cardinfo.info,card:get_game_object());
--                 self.TeamCardObj[pid]:SetTeamPosIcon(4);
--                 self.TeamCardObj[pid]:SetAddIcon(false);
--             else
--                 self.TeamCardObj[pid]:SetData(nil,card:get_game_object());
--                 self.TeamCardObj[pid]:SetTeamPosIcon(0);
--                 self.TeamCardObj[pid]:SetAddIcon(true);
--             end
--             if self.isDisable then
--                 self.TeamCardObj[pid]:SetLock(true,"已锁定");
--                 self.TeamCardObj[pid]:SetCallback(self.bindfunc["on_cannt_chose"]);
--             else
--                 self.TeamCardObj[pid]:SetLock(false);
--             end
--         else
--             local str = ConfigManager.Get(EConfigIndex.t_ghoul_assault,id).level .. "级开启"
--             self.TeamCardObj[pid]:SetLock(true,str);
--             self.TeamCardObj[pid]:SetClick(false);
--         end
--         self.TeamCardObj[pid]:SetTranslucent(false);
--     end
-- end

function SupportHeroUI:on_chose_hero(obj,cardinfo)
    if Utility.getTableEntityCnt(self.teamInfo) < self.teamMaxCont then
        local index = -1;
        for i=4,self.teamMaxCont do
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
        -- self.warpAlternateHero:reset();
        self:UpdateTeamInfo();
    else
        HintUI.SetAndShow(EHintUiType.zero,"阵容已满");
    end
end

function SupportHeroUI:on_cannt_chose()
    HintUI.SetAndShow(EHintUiType.zero,"未通关前无法更换阵容");
end

function SupportHeroUI:on_cancel_chose(obj,cardinfo)
    if cardinfo then
        for i=1,self.teamMaxCont do
            if self.teamInfo[i] and cardinfo.index == self.teamInfo[i].info.index then
                self.teamInfo[i] = nil;
                break;
            end
        end
        self:UpdateTeamInfo();
        self.warpHeroPackage:reset();
        self.scrollHeroPackage:reset_position();
    end
end

function SupportHeroUI:on_sure()
    Utility.CallFunc(self.sureCallback);
    uiManager:PopUi();
end

function SupportHeroUI:on_reset()
    for i=4,self.teamMaxCont do
        self.teamInfo[i] = nil;
    end
    self:UpdateTeamInfo();
    self.warpHeroPackage:reset();
    self.scrollHeroPackage:reset_position();
end

function SupportHeroUI:UpdatePackage()
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
    self.scrollHeroPackage:reset_position();
end

function SupportHeroUI:UpdateTeamInfo()
    if not self.ui then
        return;
    end
    for i=1,6 do
        local pid = i;
        local team = self.teamInfo;
        local cardinfo = team[pid+3];
        if i <= self.teamMaxCont then
            if cardinfo then
                self.TeamCardObj[pid]:SetData(cardinfo.info);
                self.TeamCardObj[pid]:SetTeamPosIcon(4);
                self.TeamCardObj[pid]:SetAddIcon(false);
            else
                self.TeamCardObj[pid]:SetData(nil);
                self.TeamCardObj[pid]:SetTeamPosIcon(0);
                self.TeamCardObj[pid]:SetAddIcon(true);
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
        self.TeamCardObj[pid]:SetTranslucent(false);
    end
end

function SupportHeroUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.difficulty = 0;
    self.isDisable = false;
    self.teamInfo = {};

    for k,v in pairs(self.heroCardObj) do
        v:DestroyUi();
    end
    self.heroCardObj = {};
    for k,v in pairs(self.TeamCardObj) do
        v:DestroyUi();
    end
    self.TeamCardObj = {};
end

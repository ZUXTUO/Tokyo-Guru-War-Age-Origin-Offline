-- HeroChoseUI = Class("HeroChoseUI",UiBaseClass);
-- function HeroChoseUI:Init(data)
--     self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_605_hero.assetbundle";
--     UiBaseClass.Init(self, data);
-- end

-- function HeroChoseUI:RegistFunc()
--     UiBaseClass.RegistFunc(self);
--     self.bindfunc["on_click_card"] = Utility.bind_callback(self, self.on_click_card);
--     self.bindfunc["on_click_tab"] = Utility.bind_callback(self, self.on_click_tab);
--     self.bindfunc["init_item"] = Utility.bind_callback(self, self.init_item);
--     self.bindfunc["on_change_show"] = Utility.bind_callback(self, self.on_change_show);
--     self.bindfunc["on_chose_hero"] = Utility.bind_callback(self, self.on_chose_hero);
--     self.bindfunc["on_skill"] = Utility.bind_callback(self, self.on_skill);
-- end

-- function HeroChoseUI:InitData(data)
--     UiBaseClass.InitData(self,data);
--     self.poplist = nil;
--     self.humanInfo = {};
--     self.grid = nil;
--     self.texPeople = nil;
--     self.col = 3;

--     --self.renderTexture = nil;
--     self.cardlist = {};
--     self.choseItem = nil;
--     self.choseItemInfo = nil;
--     self.curHeroType = ENUM.EProType.All;
--     self.curShowType = ENUM.EShowHeroType.Have;
--     self.herolist = {};
--     self.showlist = {};
--     self.HeroPos = 1;
--     self.teams = {};
--     self.skill = {};
--     self.progressbarIsActive = false;


--     self.card = {};
-- end

-- function HeroChoseUI:OnLoadUI()
--     UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
-- end


-- -- 设置玩家队伍类型（外部接口）
-- function HeroChoseUI:SetTeamType(teamType)
--     if teamType == nil then return end
--     self.teamType = teamType;
--     self.teams = {}
--     local team = g_dataCenter.player:GetTeam(self.teamType)
--     if team then
--         for i=1, 3 do 
--             if team[i] then
--                 self.teams[i] = {};
--                 self.teams[i].info = g_dataCenter.package:find_card(1,team[i]);
--             end
--         end
--     end
-- end

-- function HeroChoseUI:DestroyUi()
--     UiBaseClass.DestroyUi(self);
--     self.poplist = nil;
--     if self.humanInfo and self.humanInfo.skill then
--         for k,v in pairs(self.humanInfo.skill) do
--             v.sp:Destroy();
--             v.sp = nil;
--         end
--     end
--     self.humanInfo = {};
--     self.grid = nil;
--     self.texPeople = nil;
--     self.asset = nil;


--     -- if self.renderTexture then
--     --     self.renderTexture:Destroy();
--     -- end
--     -- self.renderTexture = nil;
--     Show3d.Destroy();
--     for k,v in pairs(self.cardlist) do
--         for m,n in pairs(v) do
--             n:DestroyUi();
--         end
--     end
--     self.cardlist = {};
--     self.choseItem = nil;
--     self.choseItemInfo = nil;
--     self.curHeroType = ENUM.EProType.All;
--     self.curShowType = ENUM.EShowHeroType.Have;
--     self.herolist = {};
--     self.showlist = {};
--     self.teams = {};
--     self.HeroPos = 1;
--     self.teamType = nil;
--     self.card = {};
--     -- self.humanPool:Destroy();
--     -- self.skillPool:Destroy();
-- end

-- function HeroChoseUI:InitUI(asset_obj)
--     UiBaseClass.InitUI(self,asset_obj);
--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());
--     self.ui:set_name("hero_chose_ui");

--     self.humanInfo.bk = ngui.find_sprite(self.ui,"left_content/content2")
--     self.humanInfo.star = {};
--     for i=1,5 do
--         self.humanInfo.star[i] = ngui.find_sprite(self.ui,"left_content/star/star_di"..i.."/star");
--     end
--     self.humanInfo.name = ngui.find_label(self.ui,"left_content/content2/lab_name");
--     self.humanInfo.level = ngui.find_label(self.ui,"left_content/content2/lab_level");
--     self.humanInfo.type = ngui.find_label(self.ui,"centre_other/animation/left_content/animation/content2/lab_nature");
--     self.humanInfo.Restraint = ngui.find_sprite(self.ui,"centre_other/animation/left_content/animation/content2/sp_bk");
--     self.humanInfo.RestraintBk = ngui.find_sprite(self.ui,"centre_other/animation/left_content/animation/content2/sp_bk/sp");
--     self.humanInfo.spAptitude = ngui.find_sprite(self.ui,"centre_other/animation/left_content/animation/Sprite");
--     self.humanInfo.skill = {};
--     for i=1,3 do
--         self.humanInfo.skill[i] = {};
--         self.humanInfo.skill[i].sp = ngui.find_texture(self.ui,"left_content/content1/btn"..i.."/skill");
--         self.humanInfo.skill[i].chose = ngui.find_sprite(self.ui,"left_content/content1/btn"..i.."/sp_shine");
--         self.humanInfo.skill[i].chose:set_active(false);
--         self.humanInfo.skill[i].spLock = ngui.find_sprite(self.ui,"left_content/content1/btn"..i.."/sp_lock");
--         local _btnSkill = ngui.find_button(self.ui,"left_content/content1/btn"..i);
--         _btnSkill:set_event_value("",i);
--         _btnSkill:set_on_click(self.bindfunc["on_skill"]);
--     end

--     self.texPeople = self.ui:get_child_by_name("left_content/tex_people");
--     self.role3d_ui_touch = ngui.find_sprite(self.ui, "left_content/tex_people/sp_people");
--     --self.renderTexture = RenderTexture:new({texture = self.texPeople});

--     self.choseBtn = ngui.find_button(self.ui,"left_content/btn_change");
--     self.choseBtn:set_on_click(self.bindfunc["on_chose_hero"]);

--     local btn1 = ngui.find_button(self.ui,"right_top_other/yeka/yeka_all/sp");
--     btn1:set_event_value("",ENUM.EProType.All);
--     btn1:set_on_click(self.bindfunc["on_click_tab"]);
--     local btn3 = ngui.find_button(self.ui,"right_top_other/yeka/yeka_warrior/sp");
--     btn3:set_event_value("",ENUM.EProType.Gong);
--     btn3:set_on_click(self.bindfunc["on_click_tab"]);
--     local btn2 = ngui.find_button(self.ui,"right_top_other/yeka/yeka_meat/sp");
--     btn2:set_event_value("",ENUM.EProType.Fang);
--     btn2:set_on_click(self.bindfunc["on_click_tab"]);
--     local btn4 = ngui.find_button(self.ui,"right_top_other/yeka/yeka_energy/sp");
--     btn4:set_event_value("",ENUM.EProType.Ji);
--     btn4:set_on_click(self.bindfunc["on_click_tab"]);
--     --local btn5 = ngui.find_button(self.ui,"right_top_other/yeka/yeka_assist/sp");
--     --btn5:set_event_value("",ENUM.EProType.Aid);
--     --btn5:set_on_click(self.bindfunc["on_click_tab"]);

--     self.labSkill = ngui.find_label(self.ui,"left_content/lab_skill");
--     self.labSkillMark = ngui.find_sprite(self.ui,"left_content/sp_bk");

--     if #self.teams == 0 then
--         local team = g_dataCenter.player:GetTeam(self.teamType)
--         if team then
--             for i=1,3 do 
--                 if team[i] then
--                     self.teams[i] = {};
--                     self.teams[i].info = g_dataCenter.package:find_card(1,team[i]);
--                 end
--             end
--         end
--     end
--     self.scroll_view = ngui.find_scroll_view(self.ui, "centre_other/right_content/panel_list");
--     self.grid = ngui.find_wrap_content(self.ui,"centre_other/right_content/panel_list/wrap_content");
--     self.grid:set_on_initialize_item(self.bindfunc["init_item"]);

--     self:UpdatePackage(self.curShowType,true);
--     self:UpdateHeroInfo();
-- end

-- function HeroChoseUI:on_skill(t)
--     if self.choseItemInfo then
--         self.labSkill:set_active(true);
--         self.labSkillMark:set_active(true);
--         for i=1,3 do
--             self.humanInfo.skill[i].chose:set_active(false);
--         end
--         self.humanInfo.skill[t.float_value].chose:set_active(true);
--         local skill_id = self.choseItemInfo.skill[t.float_value+3];
--         local atk_power = self.choseItemInfo:GetPropertyVal(ENUM.EHeroAttribute.atk_power)
--         self.labSkill:set_text(SkillManager.GetSkillIntroduce(atk_power, skill_id, 1));
--     end
-- end

-- function HeroChoseUI:init_item(obj,b,real_id)
--     if not self.card[b] then
--         self.card[b] = {};
--     end
--     for i=1,self.col do
--         if not self.card[b][i] then
--             self.card[b][i] = obj:get_child_by_name("big_card_item"..i);
--         end
--         --local card = ngui.find_button(obj,"big_card_item"..i);
--         local id = math.abs(real_id)*self.col+i;
--         if self.showlist[id] then
--             self.card[b][i]:set_active(true);
--             if self.cardlist[b] == nil then
--                 self.cardlist[b] = {};
--             end
--             if not self.cardlist[b][i] then
--                 self.cardlist[b][i] = SmallCardUi:new({res_group=nil});
--                 self.cardlist[b][i]:SetParent(self.card[b][i]);
--                 self.cardlist[b][i]:SetCallback(self.bindfunc["on_click_card"]);
--             end
--             self.cardlist[b][i]:SetData(self.showlist[id]);
--             self:InitCard(self.cardlist[b][i],self.showlist[id]);
--         else
--             self.card[b][i]:set_active(false);
--         end
--     end
-- end

-- function HeroChoseUI:InitCard(small_card,info)
--     small_card:SetTeamPosIcon(0);
--     small_card:SetClick(info.index ~= 0);
--     small_card:SetTranslucent(info.index == 0);
--     for i=1,3 do
--         if self.teams and self.teams[i] and self.teams[i].info 
--             and self.teams[i].info.index == info.index
--         then
--             self.teams[i].obj = small_card;
--             small_card:SetTeamPosIcon(i);
--             if i ~= self.HeroPos then
--                 small_card:SetClick(false);
--                 small_card:SetTranslucent(true);
--             end
--             -- 初始选中
--             if not self.choseItemInfo and i == self.HeroPos then
--                 self:on_click_card(small_card,info);
--             end
--             break;
--         end
--     end

--     -- if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetIsPray(1) then
--     --     if info.index == g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1) then
--     --         small_card:SetLock(true,"挂机中")
--     --         small_card:SetClick(false);
--     --         return
--     --     end
--     -- end
--     if self.choseItemInfo and self.choseItemInfo.number == info.number then
--         self:on_click_card(small_card,info);
--     end
-- end

-- --[[点选英雄]]
-- function HeroChoseUI:on_click_card(obj,cardinfo)
--     if self.choseItem then
--         self.choseItem:ChoseItem(false);
--     end
--     self.choseItem = obj;
--     self.choseItemInfo = cardinfo;
--     self.choseItem:ChoseItem(true);

--     self:UpdateHeroInfo();
-- end

-- --[[切换显示英雄职业]]
-- function HeroChoseUI:on_click_tab(t)
--     self:UpdateCardList(t.float_value);
-- end

-- --[[切换显示是否拥有英雄]]
-- function HeroChoseUI:on_change_show(t)
--     self:UpdatePackage(t.string_value);
-- end

-- --[[选择英雄按钮]]
-- function HeroChoseUI:on_chose_hero()
--     local _team = 
--     {
--         ["teamid"] = self.teamType or 0,
--         cards = {},
--     }
--     -- 额外阵型数据检查（只处理上阵/更换情况）
--     if _team.teamid > ENUM.ETeamType.normal then
--         local team = g_dataCenter.player:GetTeam(_team.teamid);
--         team.heroLineup = {5,6,7}
--         team.soldierLineup = {4,12,2,10,8}
--         if team and team.heroLineup and next(team.heroLineup) then
--             local changePos = nil
--             if team[self.HeroPos] then
--                 changePos = team.heroLineup[self.HeroPos]
--             end
--             -- 找到一个空位放进去
--             if changePos == nil then
--                 local posSlot = {2, 3, 4, 6, 7, 8, 10, 11, 12}
--                 for i, pos in ipairs(posSlot) do
--                     local used = false
--                     for _, heropos in pairs(team.heroLineup) do
--                         if pos == heropos then
--                             used = true
--                             break
--                         end
--                     end
--                     for _, soldierpos in pairs(team.soldierLineup) do
--                         if pos == soldierpos then
--                             used = true
--                             break
--                         end
--                     end
--                     if not used then
--                         changePos = pos
--                         break
--                     end
--                 end
--             end
--             -- 直接修改当前数据中心阵型数据
--             _team.heroLineup = team.heroLineup
--             _team.soldierLineup = team.soldierLineup
--             -- _team.heroLineup = table.copy(team.heroLineup)
--             -- _team.soldierLineup = table.copy(team.soldierLineup)
--             if changePos then
--                 _team.heroLineup[self.HeroPos] = changePos
--             end
--         else
--             _team.heroLineup = {}
--             _team.soldierLineup = {}
--         end
--     end
--     local _curTeam = self.teams or {};
--     for i=1,3 do
--         if i == self.HeroPos then
--             _team.cards[i] = self.choseItemInfo.index;
--         else
--             if _curTeam[i] and _curTeam[i].info then
--                 _team.cards[i] = _curTeam[i].info.index;
--             else
--                 _team.cards[i] = 0;
--             end
--         end
--     end
--     msg_team.cg_update_team_info(_team);
--     uiManager:PopUi();
-- end

-- --[[更新右侧英雄信息]]
-- function HeroChoseUI:UpdateHeroInfo()
--     if not self.ui then
--         return;
--     end
--     self.labSkill:set_active(false);
--     self.labSkillMark:set_active(false);
--     if self.choseItemInfo then
--         self.choseBtn:set_active(true);
--         -- self.humanInfo.bk:set_active(true);
--         --self.renderTexture:Show(true);
--         --self.renderTexture:ChangeObj(self.choseItemInfo.number);
--         local data = 
--         {
--             roleData = self.choseItemInfo,
--             role3d_ui_touch = self.role3d_ui_touch,
--             --callback = self.bindfunc["on_load_obj_end"],
--         }
--         Show3d.SetAndShow(data)
--         self.humanInfo.name:set_text(self.choseItemInfo.name);
--         local str = gs_string_attacktype[self.choseItemInfo.config.attackType].."/"..gs_string_job[self.choseItemInfo.config.pro_type];
--         self.humanInfo.type:set_text(str);
--         self.humanInfo.level:set_text("Lv."..tostring(self.choseItemInfo.level));
--         PublicFunc.SetRestraintSprite(self.humanInfo.Restraint,self.choseItemInfo.restraint);
--         PublicFunc.SetRestraintSpriteBk(self.humanInfo.RestraintBk,self.choseItemInfo.restraint);
--         PublicFunc.SetAptitudeSprite(self.humanInfo.spAptitude,self.choseItemInfo.config.aptitude);
--         for i=1,5 do
--             if self.choseItemInfo.rarity >= i then
--                 self.humanInfo.star[i]:set_active(true);
--             else
--                 self.humanInfo.star[i]:set_active(false);
--             end
--         end
--         for i=1,3 do
--             local skill_id = self.choseItemInfo.skill[i+3];
--             local skill = ConfigManager.Get(EConfigIndex.t_skill_info,skill_id);
--             self.humanInfo.skill[i].sp:set_texture(skill.small_icon);

--             PublicFunc.SetSkillLock(self.choseItemInfo, self.humanInfo.skill[i].spLock, i + 3);
--             -- self.skillPool:SetIconByPath(self.humanInfo.skill[i].sp,skill.small_icon);
--             self.humanInfo.skill[i].chose:set_active(false);
--             self.humanInfo.skill[i].sp:set_active(true);
--         end
--     else
--         local data = 
--         {
--             role3d_ui_touch = self.role3d_ui_touch,
--             --callback = self.bindfunc["on_load_obj_end"],
--         }
--         Show3d.SetAndShow(data)
--         --self.renderTexture:Show(false)
--         self.choseBtn:set_active(false);
--         self.humanInfo.name:set_text("");
--         self.humanInfo.type:set_text("");
--         self.humanInfo.level:set_text("");
--         self.humanInfo.Restraint:set_sprite_name("");
--         self.humanInfo.RestraintBk:set_sprite_name("");
--         self.humanInfo.spAptitude:set_sprite_name("");
--         -- self.humanInfo.bk:set_active(false);
--         for i=1,5 do
--             self.humanInfo.star[i]:set_active(false);
--         end
--         for i=1,3 do
--             self.humanInfo.skill[i].sp:set_active(false);
--         end
--     end
-- end

-- --[[更新背包]]
-- function HeroChoseUI:UpdatePackage(show_type,is_refresh)
--     if self.curShowType == show_type and not is_refresh then return end;
--     self.curShowType = show_type;
--     self.herolist = PublicFunc.GetAllHero(show_type, nil,self.team_ids);
--     self:UpdateCardList(self.curHeroType,true);
-- end

-- --[[更新显示列表]]
-- function HeroChoseUI:UpdateCardList(hero_type,is_refresh)
--     if not self.ui then return end;
--     if self.curHeroType == hero_type and not is_refresh then return end;
--     self.curHeroType = hero_type;
--     self.showlist = {};
--     for i=1,#self.herolist do
--         if hero_type == ENUM.EProType.All 
--             or hero_type == self.herolist[i].pro_type then
--             table.insert(self.showlist,self.herolist[i]);
--         end
--     end
--     self.grid:set_min_index(-math.ceil(#self.showlist/self.col)+1);
--     self.grid:set_max_index(0);
--     self.grid:reset();
--     self.scroll_view:reset_position();
-- end

-- function HeroChoseUI:SetParam(hero_pos)
--     self.HeroPos = hero_pos;
--     self.choseItemInfo = nil;
--     self:UpdatePackage(self.curShowType,true);
--     self:UpdateHeroInfo();
-- end

-- --------------------  新手引导添加  ---------------------
-- function HeroChoseUI:GetCardItemUi(index)
--     if self.cardlist and self.cardlist[index] then
--         return self.cardlist[index].ui
--     end
-- end
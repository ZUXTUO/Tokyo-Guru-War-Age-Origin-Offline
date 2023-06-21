-- ArrangeBattleUI = Class("ArrangeBattleUI", UiBaseClass);

-- function ArrangeBattleUI:Init(data)
--     self.pathRes = "assetbundles/prefabs/ui/public/ui_2401_formation.assetbundle"
--     UiBaseClass.Init(self, data);
-- end

-- function ArrangeBattleUI:InitData(data)
--     UiBaseClass.InitData(self, data);
    
-- 	self.Pos = nil;
-- end

-- function ArrangeBattleUI:RegistFunc()
--     UiBaseClass.RegistFunc(self);
    
--     self.bindfunc["on_click"] = Utility.bind_callback(self,self.on_click);
--     self.bindfunc["on_close"] = Utility.bind_callback(self,self.on_close);
--     self.bindfunc["on_confirm"] = Utility.bind_callback(self,self.on_confirm);
-- end

-- function ArrangeBattleUI:DestroyUi()    
--     for k,v in pairs(self.smallCardObj) do
--         v:DestroyUi()
--     end

--     if self.Pos then
--         for k,v in pairs(self.Pos) do
--             v:DestroyUi();
--             self.Pos[k] = nil;
--         end
--     end
--     self.Pos = nil;

--     self.Team = nil;
--     if self._resultCallback then
--         Utility.CallFunc(self._resultCallback);
--         self._resultCallback = nil;
--     end
--     UiBaseClass.DestroyUi(self);
-- end

-- function ArrangeBattleUI:SetTeam(hero_list,hero_pos,team_type)
--     self.Team = self.Team or {};
--     self.teamType = team_type;

--     self.heroList = hero_list;
--     -- 不使用hero_pos, 按顺序插入位置
--     local pos = {4,8,12}
--     for i, v in ipairs(hero_list) do
--         self.Team[ pos[i] ] = {1, i}
--     end

--     self:UpdateUi();
-- end

-- function ArrangeBattleUI:SetResultCallback(func)
--     self._resultCallback = func;
-- end

-- function ArrangeBattleUI:InitUI(asset_obj)
--     UiBaseClass.InitUI(self, asset_obj)

--     self.ui:set_parent(Root.get_root_ui_2d());
--     self.ui:set_local_scale(Utility.SetUIAdaptation());

--     self.Pos = {};
--     self.smallCardObj = {}

--     for i=1,3 do
--         local obj1 = self.ui:get_child_by_name("centre_other/animation/right_content/grid/big_card_item_80"..i);
--         self.smallCardObj[i] = SmallCardUi:new({parent=obj1})
--     end

--     for i=1,3 do 
--         --for j=1,4 do
--            local index = 4*i;
--            local path = "centre_other/animation/left_content/grid/big_card_item_80"..i;
--            local obj = self.ui:get_child_by_name(path);
--            self.Pos[index] = SmallCardUi:new({parent=obj});
--            self.Pos[index]:ShowOnlyPic()
--            self.Pos[index]:SetParam(index);
--            self.Pos[index]:SetCallback(self.bindfunc["on_click"]);
--         --end
--     end

--     self.choseIndex = nil;

--     local _btnClose = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha");
--     local _btnOk = ngui.find_button(self.ui,"centre_other/animation/btn_cha")
--     _btnClose:set_on_click(self.bindfunc["on_close"]);
--     _btnOk:set_on_click(self.bindfunc["on_confirm"]);
--     if self.Team then
--         self:UpdateUi();
--     end
-- end

-- function ArrangeBattleUI:UpdateUi()
--     if UiBaseClass.UpdateUi(self) then
--         for k,v in pairs(self.Pos) do
--             self.Pos[k]:SetData(nil);
--         end

--         for k,v in pairs(self.Team or {}) do
--             if v[1] == 1 then
--                 local cfg = g_dataCenter.package:find_card(1,self.heroList[v[2]]);
--                 self.Pos[k]:SetData(cfg);
--             -- elseif v[1] == 2 then
--             --     local cfg = ConfigManager.Get(EConfigIndex.t_monster_property,self.soldierList[v[2]]);
--             --     self.Pos[k]:SetData(nil,nil,cfg.small_icon);
--             end
--         end
--     end
-- end

-- function ArrangeBattleUI:on_click(card,info,new_index)
--     -- local new_index = t.float_value;
-- 	if self.choseIndex then
--         if self.choseIndex == new_index then
--             self.Pos[self.choseIndex]:ChoseItem(false);
--             self.choseIndex = nil;
--         else
--             self.Pos[self.choseIndex]:ChoseItem(false);
--             self:ChangeHeroPos(self.choseIndex,new_index);
--             self.choseIndex = nil;
--         end
-- 	else
--         if self:HaveHero(new_index) then
--             self.choseIndex = new_index;
--             self.Pos[self.choseIndex]:ChoseItem(true);
--         end
-- 	end
-- end

-- function ArrangeBattleUI:on_close(t)
--     uiManager:PopUi();
-- end

-- function ArrangeBattleUI:on_confirm(t)
--     self:on_save();
--     -- uiManager:PopUi();
--     uiManager:SetStackSize(uiManager:GetUICount()-2) --连同上一级界面一同销毁
-- end

-- function ArrangeBattleUI:on_save()
--     local heroCards = {}
--     local _teamInfo = self.heroList
--     for i,v in ipairs(_teamInfo) do
--         table.insert(heroCards, v)
--     end
--     local hero_pos = {};
--     local monster_pos = {};
--     if self.Team then
--         for pos,v in pairs(self.Team) do
--             if v[1] == 1 then
--                 hero_pos[v[2]] = pos;
--             -- elseif v[1] ==2 then
--             --     monster_pos[v[2]] = pos;
--             end
--         end
--     end
--     local team =
--     {
--         teamid = self.teamType,
--         cards = heroCards,
--         heroLineup = hero_pos,
--         soldierLineup = monster_pos,
--     }
--     msg_team.cg_update_team_info(team);
-- end

-- function ArrangeBattleUI:HaveHero(pos_id)
--     if self.Team[pos_id] then
--         return true;
--     end
--     -- if self.soldierTeam[pos_id] then
--     --     return true;
--     -- end
--     return false;
-- end

-- function ArrangeBattleUI:ChangeHeroPos(old_pos,new_pos)
--     local buf = self.Team[old_pos];
--     self.Team[old_pos] = self.Team[new_pos];
--     self.Team[new_pos] = buf;

--     self:UpdateUi();
-- end

-- function ArrangeBattleUI:Restart(data)
-- 	UiBaseClass.Restart(self, data)
-- end

-- function ArrangeBattleUI:UnRegistFunc()
--     UiBaseClass.UnRegistFunc(self);
-- end

-- function ArrangeBattleUI:Show(scene_id)
--     UiBaseClass.Show(self)
-- end

-- function ArrangeBattleUI:Hide()
--     UiBaseClass.Hide(self)
-- end


CommonHeroListUI = Class("CommonHeroListUI", UiBaseClass)

--[[
    data = {
        isFormationUi = nil
        isRestraintUi = nil
        roleNumber = nil
        parent = nil,
        tipType = nil,
        showGuardHeartTip = nil,
        callback = {
            update_ui = nil,   
            update_choose_hero = nil,      --更新英雄回调
            on_choose_hero = nil,          --选中英雄回调
	        cancel_choose_hero = nil       --取消选中
            on_drag_begin = nil,           --开始拖拽英雄回调
            on_drag_move = nil,            --拖拽英雄回调
            on_drag_release = nil,         --结束拖拽英雄回调
        }
    }
]]

CommonHeroListUI.relatedList = {}

local _UIText = {
    [1] = "你还未拥有该英雄！"
}

function CommonHeroListUI:Init(data)
    self.isFormationUi = data.isFormationUi
    self.pathRes = "assetbundles/prefabs/ui/public/panel_list_hero_item.assetbundle" 

    self.teamType = data.teamType or ENUM.ETeamType.normal
    self.isRestraintUi = data.isRestraintUi
    self.roleNumber = data.roleNumber  --30003000 
    self.tipType = data.tipType 
	self.parent = data.parent
    self.callback = data.callback
    self.heroType = data.heroShowType or ENUM.EShowHeroType.Have;
    self.showGuardHeartTip = data.showGuardHeartTip
    UiBaseClass.Init(self, data);
end

function CommonHeroListUI:Restart(data)    
    self.itemsBox = {}    
    self.heroSmallCardList = {}
    self.heroFightPower = {}

    self.roleData = nil 
    if UiBaseClass.Restart(self, data) then        
	end
end

function CommonHeroListUI:InitData(data)
    UiBaseClass.InitData(self, data)      
end

function CommonHeroListUI:DestroyUi()
    for k, v in pairs(self.heroSmallCardList) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    self.heroSmallCardList = {}
    self.heroFightPower = {}
    self:SetRelatedList(nil)

    if self.dragCycleGroup then
        self.dragCycleGroup:destroy_object();
        self.dragCycleGroup = nil;
    end
    UiBaseClass.DestroyUi(self) 
end

function CommonHeroListUI:RegistFunc()
    UiBaseClass.RegistFunc(self)  
    self.bindfunc["loading_ui_end"] = Utility.bind_callback(self, self.loading_ui_end)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_choose_hero"] = Utility.bind_callback(self,self.on_choose_hero)
    self.bindfunc["on_drag_start_sp"] = Utility.bind_callback(self, self.on_drag_start_sp);
    self.bindfunc["on_drag_release_sp"] = Utility.bind_callback(self, self.on_drag_release_sp);
    self.bindfunc["on_ngui_drag_move"] = Utility.bind_callback(self, self.on_ngui_drag_move);

    self.bindfunc["on_btn_left"] = Utility.bind_callback(self, self.on_btn_left);
    self.bindfunc["on_btn_right"] = Utility.bind_callback(self, self.on_btn_right);
    self.bindfunc["on_start_pos"] = Utility.bind_callback(self, self.on_start_pos);
    self.bindfunc["on_end_pos"] = Utility.bind_callback(self, self.on_end_pos);
    self.bindfunc["on_stop_move"] = Utility.bind_callback(self, self.on_stop_move);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self,self.init_item_wrap_content);
end

function CommonHeroListUI:MsgRegist()
    UiBaseClass.MsgRegist(self);  
end

function CommonHeroListUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function CommonHeroListUI:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('common_hero_list_ui')

    self.btnLeftArrow = ngui.find_button(self.ui, "btn_left_arrows")
    self.btnLeftArrow:set_on_click(self.bindfunc["on_btn_left"]);
    self.btnRightArrow = ngui.find_button(self.ui, "btn_right_arrows")
    self.btnRightArrow:set_on_click(self.bindfunc["on_btn_right"]);

    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"panel_scroll_view");
    self.dragCycleGroup:set_on_stop_move(self.bindfunc["on_stop_move"]);
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
    self.dragCycleGroup:set_on_outstart(self.bindfunc["on_start_pos"]);
    self.dragCycleGroup:set_on_outend(self.bindfunc["on_end_pos"]);

    self.dragCycleGroup:set_maxNum(0);
    self.dragCycleGroup:refresh_list()
end

function CommonHeroListUI:UpdateUi(ccgType)
    if UiBaseClass.UpdateUi(self) then
        self.ccgType = ccgType
        self:UpdateHeroPackage()     
        if self.callback.update_ui then
            Utility.CallFunc(self.callback.update_ui)
        end
    end
end

--[[显示英雄列表]]
function CommonHeroListUI:init_item_wrap_content(obj, index)  
    local row = obj:get_instance_id();

    local heroData = self.heroDataList[index]
    local heroCard = self.heroSmallCardList[row]
    local fightPower = self.heroFightPower[row];
    if heroCard == nil then        
        fightPower = {
            --objDi = obj:get_child_by_name("big_card_item_80/sp_di"),
            lbl = ngui.find_label(obj, "lab"),    
        }
        fightPower.lbl:set_active(self.isFormationUi ~= nil)
        self.heroFightPower[row] = fightPower

        heroCard = SmallCardUi:new(
        {   
            parent = obj:get_child_by_name("big_card_item_80"),
            info = heroData,
            sgroup = 1,	
			isShine	= (index == self.selectedIndex),		
            tipType = self.tipType,
            customUpdateTip = true,
            clickBtn = ngui.find_button(obj, obj:get_name()),
            enableButtonFunction = false,
        }) 
        self.heroSmallCardList[row] = heroCard       
        heroCard:SetCallback(self.bindfunc["on_choose_hero"])
        heroCard:SetDragStart(self.bindfunc["on_drag_start_sp"]);
        heroCard:SetDragRelease(self.bindfunc["on_drag_release_sp"]);
        heroCard:SetDragMove(self.bindfunc["on_ngui_drag_move"]);
        heroCard:SetDragRestriction(3);
        heroCard:SetDragIsClone(true);
    end
    if self.isFormationUi then   
        fightPower.lbl:set_text("战力[FCD901]" .. tostring(heroData:GetFightValue(--[[self.teamType]])) .. '[-]')
    end
    heroCard:SetParam(index) 
    heroCard:SetData(heroData)
	heroCard:SetGray(not self:IsHave(heroData))
    heroCard:ChoseItem(index == self.selectedIndex)
    self:SetHeroTip(heroCard)

    if self.showGuardHeartTip then
        if g_dataCenter.guardHeart:IsGuardHeartHero(heroData.index) then
            heroCard:SetGuardHeart(true)
        else
            heroCard:SetGuardHeart(false)
        end
    end
end

--[[点击选择英雄]]
function CommonHeroListUI:on_choose_hero(obj, info, index) 
    app.log('---->on_choose_hero')

    --变灰不能选中
    if not self:IsHave(info) and self.ccgType == nil then
        FloatTip.Float(_UIText[1])
        return
    end
    if not self:IsRestraintOpen(info) then
        return
    end
    if self.selectedIndex == index then
        --已经选中,则取消  
        if self.isFormationUi then        
            self:CancelChooseHero(info);
        end    
        return
    end
    self.selectedIndex = index
    --选中   
    for _, heroCard in pairs(self.heroSmallCardList) do 
		heroCard:ChoseItem(heroCard:GetParam() == self.selectedIndex)
    end
    self:UpdateChooseHero(info)
    if self.callback.on_choose_hero then
        Utility.CallFunc(self.callback.on_choose_hero)
    end

    -- 同步列表选中状态
    local objList = self:GetRelatedList()
    if objList then
        objList.selectedIndex = index
        for _, heroCard in pairs(objList.heroSmallCardList) do 
            heroCard:ChoseItem(heroCard:GetParam() == objList.selectedIndex)
        end
        objList:UpdateChooseHero(objList:GetHeroInfo(info.number))
    end
end

--[[取消选择英雄]]
function CommonHeroListUI:CancelChooseHero(info) 
    self.selectedIndex = -1
    self.roleData = nil;
    --选中   
    for _, heroCard in pairs(self.heroSmallCardList) do 
        heroCard:ChoseItem(heroCard:GetParam() == self.selectedIndex)
    end
    if self.callback.cancel_choose_hero then
        Utility.CallFunc(self.callback.cancel_choose_hero,info)
    end
end

function CommonHeroListUI:GetHeroInfo(roleNumber)
    for k, v in pairs(self.heroDataList) do
        if v.number == roleNumber then
            return v
        end
    end
end

function CommonHeroListUI:UpdateChooseHero(info)
    local __update = false
    if info == nil then
        if self.roleNumber ~= nil then
            for k, v in pairs(self.heroDataList) do
                if v.number == self.roleNumber then
                    self.selectedIndex = k
                    self.roleData = v
                    break
                end
            end
        else            
            self.roleData = self.heroDataList[1]
            --无选中
            if self.isFormationUi then
                self.roleData = nil
            end
        end        
        __update = true
    else
        if info ~= self.roleData then
            self.roleData = info 
            __update = true
        end  
    end
    if __update then
        if self.callback.update_choose_hero then
            Utility.CallFunc(self.callback.update_choose_hero, self.roleData)
        end 
        --app.log('=============>number = ' .. self.roleData.number)
    end
end

function CommonHeroListUI:GetRoleData()
    return self.roleData 
end

function CommonHeroListUI:UpdateCurrHero()
    if self.roleData == nil then    
        return
    end
    for _, heroCard in pairs(self.heroSmallCardList) do 
        if heroCard:GetParam() == self.selectedIndex then
            heroCard:SetData(self.roleData)
            heroCard:ChoseItem(true)
            break
        end
    end
end

--[[更新英雄提示]]
function CommonHeroListUI:UpdateHeroTips()
    for _, v in pairs(self.heroSmallCardList) do
        self:SetHeroTip(v)
    end
end

function CommonHeroListUI:SetHeroTip(card)
    if self:IsHave(card:GetCardInfo()) then
        card:SetSpNew()
    else
        card:SetSpNew(false)
    end
end

--[[更新英雄列表]]
function CommonHeroListUI:UpdateHeroPackage()
   -- self.heroDataList = PublicFunc.GetAllHero(self.heroType, nil, nil, false) 
   self.heroDataList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All, nil, nil, false) 
    if self.ccgType ~= nil then
        local temp = {}
        for _,v in pairs(self.heroDataList) do
            if v.ccgType == self.ccgType then
                table.insert(temp, v)
            end
        end
        self.heroDataList = temp
        app.log("英雄列表："..tostring(temp));
    end

    self.selectedIndex = 1    
    --不选中
    if self.isFormationUi then
        self.selectedIndex = -1
    end

    self:UpdateChooseHero()	  

    self.heroCount = #self.heroDataList
    self.dragCycleGroup:set_maxNum(self.heroCount)
    self.dragCycleGroup:refresh_list();
    if self.selectedIndex > 0 then
        self.dragCycleGroup:set_index(self.selectedIndex)
    end
    self:on_stop_move(self.selectedIndex)    
end

function CommonHeroListUI:IsHave(cardInfo)
    --[[
    if cardInfo == nil then
        return false
    end
    if self.haveHeroList == nil then
        self.haveHeroList = {}
        local allCard = g_dataCenter.package:get_hero_card_table()
        for _, v in pairs(allCard) do
            self.haveHeroList[v.default_rarity] = 1
        end
    end
    return self.haveHeroList[cardInfo.default_rarity] ~= nil 
    ]]
    return 1
end

function CommonHeroListUI:IsRestraintOpen(cardInfo)
    --if self.isRestraintUi then
    --    return PublicFunc.IsOpenRealFunction(MsgEnum.eactivity_time.eActivityTime_Restraint, cardInfo);
    --else
        return true
    --end
end

function CommonHeroListUI:SetRoleNumber(number)
    self.roleNumber = number;
end

function CommonHeroListUI:SetRelatedList(objList)
    CommonHeroListUI.relatedList[self] = objList
end

function CommonHeroListUI:GetRelatedList()
    return CommonHeroListUI.relatedList[self]
end

function CommonHeroListUI:on_ngui_drag_move( name, x, y, go_obj )
    if self.callback.on_drag_move then
        Utility.CallFunc(self.callback.on_drag_move,  name, x, y, go_obj)
    end 
end

function CommonHeroListUI:on_drag_release_sp(src,tar,obj,info)
    self.dragCycleGroup:set_enable_drag(true);
    if self.callback.on_drag_release then
        Utility.CallFunc(self.callback.on_drag_release, src,tar,obj,info)
    end 
    self:on_choose_hero(obj,info,obj:GetParam());
    return true;
end

function CommonHeroListUI:on_drag_start_sp(src,obj,info)
    self.dragCycleGroup:set_enable_drag(false);
    if self.callback.on_drag_begin then
        Utility.CallFunc(self.callback.on_drag_begin, src,obj,info)
    end 
    if self.selectedIndex ~= obj:GetParam() then
        self:on_choose_hero(obj,info,obj:GetParam());
    end
    return true;
end

------------------------------------------------------------------


function CommonHeroListUI:on_btn_left()
    local index = self._StopMoveIndex - 7
    if index < 1 then
        index = 1
    end
    self.dragCycleGroup:tween_to_index(index)
end

function CommonHeroListUI:on_btn_right()
    local index = self._StopMoveIndex + 7
    if index > self.heroCount then
        index = self.heroCount
    end
    self.dragCycleGroup:tween_to_index(index)
end

function CommonHeroListUI:on_start_pos(isStart)
    self.btnLeftArrow:set_active(not isStart);
end

function CommonHeroListUI:on_end_pos(isEnd)
    self.btnRightArrow:set_active(not isEnd);
end

function CommonHeroListUI:on_stop_move(index)
    self._StopMoveIndex = index
end

-------------------------- 新手引导用 ----------------------------
function CommonHeroListUI:GetCardUiByIndex(index)
    if self.heroSmallCardList then
        for b, v in pairs(self.heroSmallCardList) do
            if v:GetParam() == index then
                if v.btnRoot then
                    return v.btnRoot:get_game_object()
                end
                return nil
            end
        end
    end
end

function CommonHeroListUI:GetCardUiByHeroId(id)
    if self.heroSmallCardList then
        for k, v in pairs(self.heroSmallCardList) do
            local cardInfo = v:GetCardInfo()
            if cardInfo and cardInfo.default_rarity == id then
                if v.btnRoot then
                    return v.btnRoot:get_game_object()
                end
                return nil
            end
        end
    end
end
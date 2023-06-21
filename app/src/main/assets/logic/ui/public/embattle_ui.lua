


EmbattleUI = Class("EmbattleUI", UiBaseClass)

local EUIConst = 
{
    RowShowCount = 4,
}


function EmbattleUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/slg/ui_2302_slg_university.assetbundle"
    UiBaseClass.Init(self, data);
end

function EmbattleUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.heroList = nil
    self.smallCardObj = {}

    self.selectHeroItemUI = {}

    self.selectingCardInfo = nil
    self.selectedHero = {}
    self.obj2heroIndex = {}

    self.maxEmbattleHeroCount = 3
end

function EmbattleUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
    self.bindfunc["onInitHeroWrapContent"]	   = Utility.bind_callback(self, EmbattleUI.onInitHeroWrapContent)
    self.bindfunc["onClickSmallCard"] = Utility.bind_callback(self,EmbattleUI.onClickSmallCard)
    self.bindfunc["onClickOk"] = Utility.bind_callback(self,EmbattleUI._onClickOk)
end

function EmbattleUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

-- heroList = 'pos=hero_index;[...]'
function EmbattleUI:SetSelectedHeroFromHeroList(heroList)
    self._selectedHeroList  = heroList

    self:_SetSelectedHeroFromHeroList(self._selectedHeroList)
end

function EmbattleUI:_SetSelectedHeroFromHeroList(heroList)

    if self.heroList == nil or self._selectedHeroList == nil then
        return
    end

    local heros = Utility.lua_string_split(heroList, ';')
    for k,v in ipairs(heros) do
        local pos2Hero = Utility.lua_string_split(v, '=')
        if #pos2Hero == 2 then
            local pos = tonumber(pos2Hero[1])
            if pos >=1 and pos <=9 then
                local cardinfo = self:GetCardInfoFromIndex(pos2Hero[2])
                if cardinfo ~= nil then
                    self:AddSelectedHero(pos, cardinfo)
                end
            end
        end
    end

    self._selectedHeroList = nil
end

function EmbattleUI:GetCardInfoFromIndex(index)
    for k,cardinfo in pairs(self.heroList) do
        if cardinfo.index == index then
            return cardinfo
        end
    end
end

function EmbattleUI:_onClickOk(param)
    self:onClickOk(param)
end

function EmbattleUI:onClickOk(param)

end

function EmbattleUI:onInitHeroWrapContent(obj,b,real_id)

    local wcItemName = obj:get_name()
    for i=1,4 do
        local gridItemName = string.format('big_card_item%d', i)
        local card = ngui.find_button(obj,gridItemName);
        local pid = math.abs(real_id)*4+i;
        if self.heroList[pid] then
            card:set_active(true);
            if self.smallCardObj[pid] == nil then
                self.smallCardObj[pid] = SmallCardUi:new({obj=card:get_game_object(), res_group=self.panel_name});
                self.smallCardObj[pid]:SetCallback(self.bindfunc["onClickSmallCard"])
                self.smallCardObj[pid]:SetParam('heroListItem')
            end

            local cardInfo = self.heroList[pid]
            self.smallCardObj[pid]:SetData(cardInfo,card:get_game_object());
            if self.selectingCardInfo and self.selectingCardInfo == cardInfo then
                self.smallCardObj[pid]:SetAddIcon(true)
            end

            if self:CheckCardIsSelected(cardInfo) then
                self.smallCardObj[pid]:SetDisableIcon(true)
            end

            local idName = wcItemName .. gridItemName
            local oldIndex = self.obj2heroIndex[idName]
            --app.log(idName)
            if oldIndex ~= nil and oldIndex ~= pid then
                --app.log('x ' .. oldIndex)
                self.smallCardObj[oldIndex] = nil
            end

            self.obj2heroIndex[idName] = pid
        else
            card:set_active(false);
        end
    end
end

function EmbattleUI:CheckCardIsSelected(cardInfo)
    for k,v in pairs(self.selectedHero) do
        if v == cardInfo then
            return true
        end
    end
    return false
end

function EmbattleUI:GetSmallCardFromCardInfo(cardInfo)
    for k,v in pairs(self.smallCardObj) do
        if v:GetCardInfo() == cardInfo then
            return v
        end
    end
end

function EmbattleUI:onClickSmallCard(smallCard,cardinfo, param)

    if param == 'heroListItem' then

        if self:CheckCardIsSelected(cardinfo) == true then
            return
        end

        if self.selectingCardInfo ~= nil then
            local sc = self:GetSmallCardFromCardInfo(self.selectingCardInfo)
            if sc ~= nil then
                sc:SetAddIcon(false)
            end
        end

        if cardinfo == self.selectingCardInfo then
            self.selectingCardInfo = nil
            return
        end

        self.selectingCardInfo = cardinfo
        smallCard:SetAddIcon(true)
    elseif type(param) == 'number' and param >= 1 and param <= 9 then
        if self.selectingCardInfo == nil then
            if self.selectedHero[param] ~= nil then
                local sc = self:GetSmallCardFromCardInfo(self.selectedHero[param])
                if sc ~= nil then
                    sc:SetDisableIcon(false)
                end
                self.selectedHero[param] = nil

                local item = self.selectHeroItemUI[param]
                item.smallCard:SetData(nil)
                item.smallCard:SetAddIcon(true)
            else
                HintUI.SetAndShow(EHintUiType.zero, gs_misc['please_select_hero'])
                
            end
            return
        end

        if self.selectedHero[param]==nil and  table.get_num(self.selectedHero) >= self.maxEmbattleHeroCount then
            HintUI.SetAndShow(EHintUiType.zero, gs_misc['reach_max_embattle_hero_count'])
            return
        end

        if self.selectedHero[param] ~= nil then
            local sc = self:GetSmallCardFromCardInfo(self.selectedHero[param])
            if sc ~= nil then
                sc:SetDisableIcon(false)
            end
            self.selectedHero[param] = nil
        end
        
        self.selectedHero[param] = self.selectingCardInfo
        local item = self.selectHeroItemUI[param]
        item.smallCard:SetData(self.selectedHero[param])

        local sc = self:GetSmallCardFromCardInfo(self.selectedHero[param])
        if sc~=nil then
            sc:SetDisableIcon(true)
            sc:SetAddIcon(false)
        end
        self.selectingCardInfo = nil
    end
end

function EmbattleUI:AddSelectedHero(pos, cardInfo)
    --app.log('pos:' .. pos)

    self.selectedHero[pos] = cardInfo
    local sc = self:GetSmallCardFromCardInfo(self.selectedHero[param])
    if sc ~= nil then
        sc:SetDisableIcon(true)
        sc:SetAddIcon(false)
    end

    local item = self.selectHeroItemUI[pos]
    item.smallCard:SetData(cardInfo)
end

function EmbattleUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("embattle_ui_2302_slg_university");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    self.showHeroWrapContent = ngui.find_wrap_content(self.ui, 'left_content/panel/wrap_content')
    self.showHeroWrapContent:set_max_index(0)
    self.showHeroWrapContent:set_on_initialize_item(self.bindfunc["onInitHeroWrapContent"])

    for i=1,9 do
        local ui = ngui.find_button(self.ui, string.format('right_content/sp_di1/big_card_item1 (%d)', i - 1))
        self.selectHeroItemUI[i] = {ui = ui}
    end

    local btn = ngui.find_button(self.ui, "btn_anniu")
    btn:reset_on_click()
    btn:set_on_click(self.bindfunc["onClickOk"])


    self:ResetSelectHero()

    self:UpdateHeroList()
end

function EmbattleUI:GetHeroList()
    --return PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    return PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
end

function EmbattleUI:UpdateHeroList()
    self.heroList = self:GetHeroList()

    local heroCount = #self.heroList
    --app.log('hero count ' .. heroCount)-- .. ' ' .. table.tostring(self.heroList))
    self.showHeroWrapContent:set_min_index(-(math.floor(heroCount/EUIConst.RowShowCount)))
    self.showHeroWrapContent:reset()

    if self._selectedHeroList ~= nil then
        self:_SetSelectedHeroFromHeroList(self._selectedHeroList)
    end
end

function EmbattleUI:ResetSelectHero()
    for k,v in ipairs(self.selectHeroItemUI) do
        --app.log('ResetSelectHero ' .. k .. ' ' .. v.ui:get_name())
        if v.smallCard == nil then
            v.smallCard = SmallCardUi:new({obj=v.ui:get_game_object(), res_group=self.panel_name})
            v.smallCard:SetCallback(self.bindfunc["onClickSmallCard"])
        else
            
        end

        v.smallCard:SetAddIcon(true)
        v.smallCard:SetParam(k)
        v.smallCard:SetAlwaysReponseClick(true)
    end
end

function EmbattleUI:Show()
	UiBaseClass.Show(self)
end

function EmbattleUI:Hide()
	UiBaseClass.Hide(self)
end


function EmbattleUI:DestroyUi()
    UiBaseClass.DestroyUi(self);

    for k,v in pairs(self.smallCardObj) do
        v:DestroyUi();
    end
    self.smallCardObj = {};

    for k,v in ipairs(self.selectHeroItemUI) do
        if v.smallCard ~= nil then
            v.smallCard:DestroyUi()
        end
    end
    self.selectHeroItemUI = {}
end

function EmbattleUI:Restart(data)
    UiBaseClass.Restart(self, data)
end
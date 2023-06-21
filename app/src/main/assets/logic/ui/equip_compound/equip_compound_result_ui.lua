

EquipCompoundResultUI = Class("EquipCompoundResultUI", UiBaseClass)

function EquipCompoundResultUI:Init(data)
    self.pathRes = "assetbundles/prefabs/text/ui_817_fight.assetbundle"
    UiBaseClass.Init(self, data);
end

function EquipCompoundResultUI:InitData(data)
    UiBaseClass.InitData(self, data);

    self.hasSetContent = false
    self.isSuc = nil
end

function EquipCompoundResultUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickFullScrollBtn"] = Utility.bind_callback(self, EquipCompoundResultUI.OnClickFullScrollBtn)
end

--加载UI
function EquipCompoundResultUI:LoadUI()
    if UiBaseClass.LoadUI(self) then
        self.loadingId = GLoading.Show(GLoading.EType.ui)
    end
end

function EquipCompoundResultUI:InitUI(asset_obj)
    GLoading.Hide(GLoading.EType.ui, self.loadingId)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("ui_817_fight_compound_result");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    local btn = ngui.find_button(self.ui, 'smak')
    btn:set_on_click(self.bindfunc["OnClickFullScrollBtn"])

    self:SetContent()
end

function EquipCompoundResultUI:OnClickFullScrollBtn()
    uiManager:PopUi()
end

function EquipCompoundResultUI:SetData(isSuc, items)
    self.isSuc = isSuc
    self.items = items

    self:SetContent()
end



function EquipCompoundResultUI:GetEquip(items)
    local res = {}
    for k, v in ipairs(items) do
        if not PropsEnum.IsGold(v.id) and not PropsEnum.IsImprovedGems(v.id) then
            table.insert(res, v)
        end
    end
    return res
end

function EquipCompoundResultUI:GetGolds(items)
    local res = {}
    for k, v in ipairs(items) do
        if PropsEnum.IsGold(v.id) then
            table.insert(res, v)
        end
    end
    return res;
end

function EquipCompoundResultUI:GetGems(items)
    local res = {}
    for k, v in ipairs(items) do
        if PropsEnum.IsImprovedGems(v.id) then
            table.insert(res, v)
        end
    end
    return res
end

function EquipCompoundResultUI:SetContent()
    if self.ui == nil or self.isSuc == nil or self.hasSetContent == true then
        return 
    end

    self.hasSetContent = true

    local failedNode = self.ui:get_child_by_name('choose1')
    failedNode:set_active(false)
    local successNode = self.ui:get_child_by_name('choose2')
    successNode:set_active(false)

    local doubleItemName = {'kug10', 'kug8', 'kug6', 'kug4', 'kug2', 'kug1', 'kug3', 'kug5', "kug7", "kug9"}
    local singleItemName = {'kug9', 'kug7', 'kug5', 'kug3', 'kug1', 'kug2', "kug4", 'kug6', 'kug8'}

    local showItemRootNode = nil
    local showItems = nil
    local itemNames = nil
    if self.isSuc == true then  
        successNode:set_active(true)
        local sp = successNode:get_child_by_name( "even_num")
        sp:set_active(false)
        showItemRootNode = successNode:get_child_by_name('odd_num')

        itemNames = singleItemName

        showItems = self:GetEquip(self.items)

        
        if math.min(#showItems, 10) % 2 == 0 then
            sp:set_active(true)
            showItemRootNode:set_active(false)

            showItemRootNode = sp
            itemNames = doubleItemName
        end
    else
        showItems = self.items
        failedNode:set_active(true)
        if math.min(#showItems,10) % 2 == 0 then
            local sp = ngui.find_sprite(failedNode, "odd_num")
            sp:set_active(false)
            
            showItemRootNode = failedNode:get_child_by_name('even_num')

            itemNames = doubleItemName
        else
            local sp = ngui.find_sprite(failedNode, "even_num")
            sp:set_active(false)

            showItemRootNode = failedNode:get_child_by_name('odd_num')

            itemNames = singleItemName
        end
    end

    local beginIndex = (#itemNames - #showItems)/2 + 1

    if beginIndex < 1 then
        beginIndex = 1
    end

    local itemNode = {}

    for i = 1,#itemNames do
        itemNode[i] = showItemRootNode:get_child_by_name(itemNames[i])
        itemNode[i]:set_active(false)
    end
    --app.log(table.tostring(showItems))
    local itemIndex = 1
    for i = beginIndex,beginIndex + #showItems - 1 do
        --app.log(' ' .. i .. ' ' .. #itemNode)
        if i > #itemNode then
            break;
        end

        itemNode[i]:set_active(true)
        local sp = ngui.find_sprite(showItemRootNode, itemNames[i] .. '/sp_daoju')


        local label = ngui.find_label(showItemRootNode, itemNames[i] .. '/lab_num2')
        label:set_active(false)

        label = ngui.find_label(showItemRootNode, itemNames[i] .. '/lab_word')
        local config = PublicFunc.IdToConfig(showItems[itemIndex].id)

        if config ~= nil then
            label:set_text(config.name)
        end


        itemIndex = itemIndex + 1;
    end
end


function EquipCompoundResultUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function EquipCompoundResultUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
        --todo 各自额外的逻辑
    end
end
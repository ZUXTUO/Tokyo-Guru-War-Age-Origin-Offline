HeroRarityUp = Class("HeroRarityUp", UiBaseClass)

local _UIText = {
    [1] = "生命:",
    [2] = "攻击:",
    [3] = "防御:",    
    ["hero_need_level"] = "等级达到%s级可进阶", 
    ["no_this_hero"] = "您还未获得该英雄",
    ["hero_level_not_enough"] = "英雄等级不足", 
    ["material_not_enough"] = "升品材料不足", 
    ["gold_not_enough"] = "金币不足", 
}

function HeroRarityUp:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_1.assetbundle"
	UiBaseClass.Init(self, data);
end

function HeroRarityUp:InitData(data)
    UiBaseClass.InitData(self, data)
    self.parent = data.parent
    self.roleData = data.info
    self.isPlayer = data.isPlayer 

    self.propertyUI = {}
    
    self.upConfig = {gold = nil, level = nil, material = {}}
    self.propertyValue = {}
     
    self:SetConfigData()
    self.materialUi = {} 
end

function HeroRarityUp:Restart(data)
    self.tipsUI = nil
	if UiBaseClass.Restart(self, data) then

	end
end

function HeroRarityUp:DestroyUi()
    UiBaseClass.DestroyUi(self);
    for i = 1, 4 do
        local mUi = self.materialUi[i]
        if mUi and mUi.card then
            mUi.card:DestroyUi()
            mUi.card = nil
        end
    end
    self.materialUi = nil

    if self.middleSmallCard then
        self.middleSmallCard:DestroyUi()
        self.middleSmallCard = nil
    end
    if self.leftSmallCard then
        self.leftSmallCard:DestroyUi()
        self.leftSmallCard = nil
    end
    if self.rightSmallCard then
        self.rightSmallCard:DestroyUi()
        self.rightSmallCard = nil
    end
end

function HeroRarityUp:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_rarity_up"] = Utility.bind_callback(self, self.on_rarity_up);
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self, self.on_find_way_material)
end

--注册消息分发回调函数
function HeroRarityUp:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function HeroRarityUp:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function HeroRarityUp:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_battle_rarity_up')  

    local path = "centre_other/animation/"
    local bk1Path = path .. "sp_bk1/"
    local bk2Path = path .. "sp_bk2/"
 
    self.objMiddle = self.ui:get_child_by_name(bk1Path .. "content/centre_big_card_item_80")
    self.objOther = self.ui:get_child_by_name(bk1Path .. "content/cont")

    self.middleSmallCard = SmallCardUi:new(
    {   
        parent = self.objMiddle,
        info = nil,
        tipType = SmallCardUi.TipType.NotShow,
        sgroup = 3,		
    }) 
    self.lblMiddleName = ngui.find_label(self.ui, bk1Path .. "content/centre_big_card_item_80/lab_name")


    self.leftSmallCard = SmallCardUi:new(
    {   
        parent = self.ui:get_child_by_name(bk1Path .. "content/cont/left_big_card_item_80") ,
        info = nil,
        tipType = SmallCardUi.TipType.NotShow,
        sgroup = 3,		
    }) 
    self.lblLeftName = ngui.find_label(self.ui, bk1Path .. "content/cont/left_big_card_item_80/lab_name")

    self.rightSmallCard = SmallCardUi:new(
    {   
        parent = self.ui:get_child_by_name(bk1Path .. "content/cont/right_big_card_item_80"),
        info = nil,
        tipType = SmallCardUi.TipType.NotShow,
        sgroup = 3,		
    }) 
    self.lblRightName = ngui.find_label(self.ui, bk1Path .. "content/cont/right_big_card_item_80/lab_name")
    
    for i = 1, 3 do
        local propPath = bk1Path .. "cont_nature/sp_bk" .. i
        local lblTxt = ngui.find_label(self.ui, propPath .. "/txt")
        lblTxt:set_text(_UIText[i])

        local temp = {}
        temp.lblTop = ngui.find_label(self.ui, propPath .. "/lab_num")
        temp.objContent = self.ui:get_child_by_name(propPath .. "/content")

        temp.lab1 = ngui.find_label(self.ui, propPath .. "/content/lab_num1")
        temp.lab2 = ngui.find_label(self.ui, propPath .. "/content/lab_num2")
        self.propertyUI[i] = temp
    end 

    --升品消耗
    for i = 1, 4 do
        local objMaterial = self.ui:get_child_by_name(bk2Path .. "content1/new_small_card_item" .. tostring(i))
        self.materialUi[i] = {
            card = UiSmallItem:new({obj = nil, parent = objMaterial, cardInfo = nil, is_enable_goods_tip = true, delay = 400, use_sweep_icon = true}),
            obj = objMaterial,
        }
    end

    local content2Path = bk2Path .. "content2/"
    self.lblLevelInfo = ngui.find_label(self.ui, content2Path .. "content/txt")
    self.objGold = self.ui:get_child_by_name(content2Path .. "content/sp_di2")
    self.lblGold = ngui.find_label(self.ui, content2Path .. "content/sp_di2/lab")
    local btnUpRarity = ngui.find_button(self.ui, content2Path .. "btn")
    btnUpRarity:set_on_click(self.bindfunc["on_rarity_up"], "MyButton.NoneAudio")

    self.lblTopRarityInfo = ngui.find_label(self.ui, path .. "txt_xxx")
    self.lblTopRarityInfo:set_active(false)

    self.rightContent = {
       spTitle =  ngui.find_sprite(self.ui, bk2Path .. "sp_title"),
       objContent1 = self.ui:get_child_by_name(bk2Path .. "content1"),
       objContent2 = self.ui:get_child_by_name(bk2Path .. "content2"),
       objTopEffect = self.ui:get_child_by_name(bk2Path .."sp_effect"),
    }

    self:UpdateUi();
end

function HeroRarityUp:UpdateUITips()
    if not AppConfig.get_enable_guide_tip() then
		return
	end
    if self.roleData == nil then
        return
    end
    if self.tipsUI == nil then
        local path = "centre_other/animation/"
        self.tipsUI = {
            ["btn_rarity_up"] = ngui.find_sprite(self.ui, path .. "sp_bk2/content2/btn/animation/sp_point"),
        }
    end
    local __flag1 = PublicFunc.ToBoolTip(self.roleData:CanRarityUp());
    self.tipsUI["btn_rarity_up"]:set_active(__flag1)
end

function HeroRarityUp:UpdateUi()
    if not self.roleData then return end 
    
    self.rightContent.spTitle:set_active(false)
    self.rightContent.objContent1:set_active(false)
    self.rightContent.objContent2:set_active(false)
    self.rightContent.objTopEffect:set_active(false)
    self.objMiddle:set_active(false)
    self.objOther:set_active(false)

    --已达最高品
    if self.roleData.realRarity >= ENUM.EHeroRarity.Red1 then 
        self.objMiddle:set_active(true)
        self.middleSmallCard:SetData(self.roleData)
        self.lblMiddleName:set_text(self.roleData.name)

        for k, v in pairs(self.propertyValue) do
            local ui = self.propertyUI[k]
            ui.objContent:set_active(false)
            ui.lblTop:set_active(true)
            ui.lblTop:set_text(tostring(v.currValue))
        end
        self.rightContent.objTopEffect:set_active(true)

    else
        for k, v in pairs(self.propertyValue) do
            local ui = self.propertyUI[k]
            ui.lblTop:set_active(false)
            ui.objContent:set_active(true)
            ui.lab1:set_text(tostring(v.currValue))
            ui.lab2:set_text(tostring(v.nextValue))
        end

        self.rightContent.spTitle:set_active(true)
        self.rightContent.objContent1:set_active(true)
        self.rightContent.objContent2:set_active(true)

        self.objOther:set_active(true)
        self.leftSmallCard:SetData(self.roleData)
        self.lblLeftName:set_text(self.roleData.name)
        if self.nextRoleData then
            self.rightSmallCard:SetData(self.nextRoleData)
            self.lblRightName:set_text(self.nextRoleData.name)
        end
        --升品消耗
        for i = 1, 4 do
            local mt = self.upConfig.material[i]
            local mUi = self.materialUi[i]
            if mt and mUi then
                mUi.obj:set_active(true)    
                mUi.card:ClearOnClicked() 
                mUi.card:SetDataNumber(mt.number)              
                mUi.card:SetNeedCount(mt.count) 
                mUi.card:SetNumberType(2)
                if mt.count > PropsEnum.GetValue(mt.number) then
                    mUi.card:SetBtnAddShow(true)                    
                    mUi.card:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(mt.count), mt.number)
                else
                    mUi.card:SetBtnAddShow(false)
                    mUi.card:SetOnClicked(self.bindfunc["on_find_way_material"], tostring(mt.count), mt.number)
                end 
            else                
                mUi.obj:set_active(false)
            end
        end    
    
        self.objGold:set_active(false)
        self.lblLevelInfo:set_active(false)
        --等级不足
        if self.upConfig.level > self.roleData.level then
            self.lblLevelInfo:set_active(true)
            self.lblLevelInfo:set_text(string.format(_UIText["hero_need_level"], self.upConfig.level))
        else   
            self.objGold:set_active(true)   
            --金币不足，显示为红色
            self.lblGold:set_text(PublicFunc.GetGoldStrWidthColor(self.upConfig.gold, ""))
        end        
    end

    self:UpdateUITips()
end

function HeroRarityUp:on_close(t)
    uiManager:PopUi();
end

function HeroRarityUp:on_find_way_material(t)    
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

--[[升品]]
function HeroRarityUp:on_rarity_up()
    if self.roleData.index == 0 then
        FloatTip.Float(PublicFunc.GetColorText(_UIText['no_this_hero'], "red"))
        return
    end
    if not self.isPlayer and self.isPlayer ~= nil then
        return
    end    
    --等级检查
    if self.upConfig.level > self.roleData.level then
        FloatTip.Float(PublicFunc.GetColorText(_UIText['hero_level_not_enough'], "red"))
        return
    end
    --材料不足
    for i = 1, 4 do
        local mt = self.upConfig.material[i]
        if mt then                          
            --获取玩家身上的材料数量
            local currCount = PropsEnum.GetValue(mt.number) 
            if mt.count > currCount then
                FloatTip.Float(PublicFunc.GetColorText(_UIText['material_not_enough'], "red"))
                return
            end 
        end
    end
    --金币不足
    if self.upConfig.gold > g_dataCenter.player.gold then
        FloatTip.Float(PublicFunc.GetColorText(_UIText['gold_not_enough'], "red"))
        return
    end
    self:RequestRarityUp()
end

function HeroRarityUp:RequestRarityUp()
    local materials = {}
    --查询材料数据
    for i = 1, 4 do
        local mt = self.upConfig.material[i]
        if mt then   
            local tCard = g_dataCenter.package:find_card_table_for_num(ENUM.EPackageType.Item, mt.number)  
            local card = tCard[1]          
            if card then                
                table.insert(materials, {dataid = card.index, id = card.number, count = card.count})
            end
        end
    end 
    msg_cards.cg_hero_rarity_up(self.roleData.index, materials)
end

function HeroRarityUp:SetConfigData(roleData, isPlayer)  
    app.log(" "..debug.traceback())
    if roleData or isPlayer then
        self.roleData = roleData 
        self.isPlayer = isPlayer
    end 
 
    local rarityUpNumber = nil
    if self.roleData.realRarity ~= ENUM.EHeroRarity.Red1 then 
        local number = self.roleData.number        
        if PropsEnum.IsRole(number) then
		    local config = ConfigHelper.GetRole(number)
            self.upConfig.gold = config.rarity_up_gold
            self.upConfig.level = config.rarity_up_level
            rarityUpNumber = config.rarity_up_number

            for k, v in pairs(config.rarity_up_material) do 
                self.upConfig.material[k] = {number = v[1], count = v[2]}
            end
        else
            app.log("role number is error!")
        end
        if rarityUpNumber == nil then        
            app.log("config error!")
            return
        end
    end    

    local pList = {"max_hp", "atk_power", "def_power"}
    local propertyDiff = nil
    if rarityUpNumber ~= nil then
        propertyDiff = PublicFunc.GetHeroRarityNextProperyDiff(self.roleData, rarityUpNumber, pList)
        --local roleConfig = ConfigHelper.GetRole(rarityUpNumber)
        --self.nextRealRarity = roleConfig.real_rarity
        self.nextRoleData = CardHuman:new({number = rarityUpNumber})
    end
    for k, v in ipairs(pList) do
        local temp = {}
        temp.currValue = self.roleData:GetPropertyVal(v)
        temp.nextValue = nil
        if propertyDiff then
            local _value = self.roleData:GetPropertyVal(v, false)
            temp.nextValue = PublicFunc.AttrInteger(_value + propertyDiff[v])
        end
        self.propertyValue[k] = temp
    end
end

function HeroRarityUp:SetInfo(roleData, isPlayer)    
    self:SetConfigData(roleData, isPlayer)
    self:UpdateUi();
end

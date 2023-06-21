HeroContactActiveUI = Class("HeroContactActiveUI", UiBaseClass)

function HeroContactActiveUI.Start(data, callback, obj)
    if HeroContactActiveUI.cls == nil then
		HeroContactActiveUI.cls = HeroContactActiveUI:new(data);
	end
end

function HeroContactActiveUI.GetActiveHeroContactInfo(cardInfo)
    local activeInfo = {}
    local info = cardInfo:GetHeroDefaultRarityCardInfo()

    local allConfig = ConfigManager._GetConfigTable(EConfigIndex.t_role_contact)
    for _, contactConfig in pairs(allConfig) do
        for _,_config in pairs(contactConfig) do
            if _config.contact_type == ENUM.ContactType.Hero then
                if _config.contact_role ~= 0 then 
                    local haveHero = false
                    for _, number in pairs(_config.contact_role) do
                        if number == cardInfo.default_rarity then
                            haveHero = true
                        end
                    end
                    if haveHero then
                        local isActive = true
                        local _cards = {}
                        for _, number in pairs(_config.contact_role) do
                            if info[number] == nil then
                                isActive = false
                                break                        
                            end
                            table.insert(_cards, info[number])
                        end
                        if isActive then
                            table.insert(activeInfo, {config = _config, cards = _cards})
                        end
                    end
                end
            end
        end
    end
    return activeInfo
end

----------------------------------------------------------------------------------

local _UIText = {
    [1] = "你激活了%s条连协",
    [2] = "生命增加",
    [3] = "攻击增加",
    [4] = "防御增加",
}

function HeroContactActiveUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_8.assetbundle"
	UiBaseClass.Init(self, data);
end

function HeroContactActiveUI:InitData(data)
    UiBaseClass.InitData(self, data)
    self.wrapContentMember = {}
    self.configData = data
end

function HeroContactActiveUI:DestroyUi()
    for _, item in pairs(self.wrapContentMember) do
        for i = 1, 5 do
            local contItem = item.cont[i]
            if contItem and contItem.smallCard then
                contItem.smallCard:DestroyUi()
                contItem.smallCard = nil
            end
        end        
    end
    UiBaseClass.DestroyUi(self);
end

function HeroContactActiveUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item); 
end

function HeroContactActiveUI:InitUI(obj)
    AudioManager.PlayUiAudio(81200044)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_hero_contact_active')  

    local path = "centre_other/animation/"
    local btnClose = ngui.find_button(self.ui, path .. "content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    self.lblDesc = ngui.find_label(self.ui, path .. "content/sp_bk/lab_num")
    self.scrollView = ngui.find_scroll_view(self.ui, path .. "content/scroll_view/panel_list")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "content/scroll_view/panel_list/wrap_content")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

    self:UpdateUi();
end

function HeroContactActiveUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id) + 1
    local row = math.abs(b) + 1  
    local data = self.configData[index]    
    if data == nil then return end

    if self.wrapContentMember[row] == nil then
        local item = {}
        item.lblName = ngui.find_label(obj, "sp_title/lab_name")
        item.lblName1 = ngui.find_label(obj, "sp_title/lab_name1")
        item.lblProp = ngui.find_label(obj, "txt_attack")
        item.lblProp1 = ngui.find_label(obj, "txt_attack/lab_attack")

        item.cont = {}
        for i = 1, 5 do
            local contItem = {}
            contItem.objItem = obj:get_child_by_name("cont_hero/big_card_item_80" .. i)
            contItem.smallCard = nil
            contItem.spAdd = nil
            if i ~= 1 then
                contItem.spAdd = ngui.find_sprite(obj, "cont_hero/sp_add" .. (i - 1))
            end
            item.cont[i] = contItem
        end
        self.wrapContentMember[row] = item
    end

    local item = self.wrapContentMember[row]
    PublicFunc.SetSinkText(data.config.name, item.lblName, item.lblName1)

    local desc, desc1 = self:GetPropDesc(data.config)
    item.lblProp:set_text(desc)
    item.lblProp1:set_text(desc1)

    for i = 1, 5 do
       local number = data.config.contact_role[i]
       local contItem = item.cont[i]
       if number then
            contItem.objItem:set_active(true)
            if contItem.spAdd then
                contItem.spAdd:set_active(true)
            end
            --挂载英雄头像
            if contItem.smallCard == nil then
                contItem.smallCard = SmallCardUi:new(
                {
                    parent = contItem.objItem,
                    stypes = {SmallCardUi.SType.Texture, SmallCardUi.SType.Rarity, SmallCardUi.SType.Star}	
                })
            end
            contItem.smallCard:SetData(data.cards[i])
            
       else
            contItem.objItem:set_active(false)
            if contItem.spAdd then
                contItem.spAdd:set_active(false)
            end
       end
    end    
end

function HeroContactActiveUI:GetPropDesc(config)
    local desc = ""
    local desc1 = ""
    if config.hp_per ~= 0 then
        desc = _UIText[2]
        desc1 = config.hp_per/100 .. "%"
    elseif config.attack_per ~= 0 then
        desc = _UIText[3]
        desc1 = config.attack_per/100 .. "%"
    elseif config.def_per ~= 0 then
        desc = _UIText[4]
        desc1 = config.def_per/100 .. "%"
    end
    return desc, desc1
end

function HeroContactActiveUI:UpdateUi()
    local initData = self:GetInitData()
    local count = #self.configData
    --self.lblDesc:set_text(string.format(_UIText[1], count))   
    self.lblDesc:set_text(tostring(count))

    self.wrapContent:set_min_index(- count + 1);
    self.wrapContent:set_max_index(0)
    self.wrapContent:reset()
    self.scrollView:reset_position() 
end

function HeroContactActiveUI:on_close(t)
    if HeroContactActiveUI.cls then
        HeroContactActiveUI.cls:DestroyUi()
        HeroContactActiveUI.cls = nil
    end

    NoticeManager.Notice(ENUM.NoticeType.GetContactActiveShowBack)
end
MaskRarityUp = Class("MaskRarityUp", UiBaseClass)

local title_des = {
    [1] = "生命",
    [2] = "攻击",
    [3] = "防御",

}

function MaskRarityUp:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mask/ui_902_mask.assetbundle"
	UiBaseClass.Init(self, data);
end

function MaskRarityUp:InitData(data)
    UiBaseClass.InitData(self, data)
    -- self.parent = data.parent
    -- self.roleData = data.info
    -- self.isPlayer = data.isPlayer 

    self.maskData = data.info

    self.propertyUI = {}
    
    self.upConfig = {gold = nil, level = nil, material = {}}
    self.propertyValue = {}

    self.curindex = self.maskData.index; --第几个面具
    self.hasItemNum = 1;
    --self:SetConfigData()
    self.materialUi = {} 
end

function MaskRarityUp:Restart(data)
    self.hasItemNum = 0; -- 物品个数
    
    self.haveitemnum = 0;
    
    self.haslvl = 0;     --模拟等级
    
    self.hasexp = 0;   --当前经验
    
    self.hasexpcurrent = 0;

    self.allitemnumber = 0;
    
    self.hasnextexp =0 ;  --下一级经验
	if UiBaseClass.Restart(self, data) then

	end
end

function MaskRarityUp:DestroyUi()
    UiBaseClass.DestroyUi(self);

    for k,v in pairs(self.item_use) do
        v:DestroyUi()
    end

end

function MaskRarityUp:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_rarity_up"] = Utility.bind_callback(self, self.on_rarity_up);
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self, self.on_find_way_material)
    self.bindfunc["on_use_items"] = Utility.bind_callback(self, self.on_use_items)
    self.bindfunc["on_play_fx"] = Utility.bind_callback(self, self.on_play_fx)
    self.bindfunc["upmaskinfo"] = Utility.bind_callback(self, self.upmaskinfo)
    self.bindfunc["on_use_item"] = Utility.bind_callback(self, self.on_use_item)
end

--注册消息分发回调函数
function MaskRarityUp:MsgRegist()
    --app.log("MsgRegist===========================")
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])   
end

--注销消息分发回调函数
function MaskRarityUp:MsgUnRegist()
    --app.log("MsgUnRegist===========================")
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])
end

function MaskRarityUp:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_mask_rarity_up') 

    --满级属性显示
    self.maxlvl_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_rarity_up/centre_other/animation/sp_art_font")

    self.max_pro_lab = {}
    for i=1,3 do
        self.max_pro_lab[i] = {}
        self.max_pro_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/txt")
        self.max_pro_lab[i].max_pro_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/lab_num")
    end
    
    self.maxlvl_ui:set_active(false)

    --等级
    self.ui_lvl = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/sp_di1/sp_bk/lab_level")
    --等阶
    self.ui_rarity = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/sp_di1/lab_num")

    --未满级属性显示
    self.no_maxlvl_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_rarity_up/centre_other/animation/content")

    self.no_max_pro_lab = {}

    for i=1,3 do
        self.no_max_pro_lab[i] = {}
        self.no_max_pro_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/txt")
        self.no_max_pro_lab[i].icon = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/sp_arrows")
        self.no_max_pro_lab[i].now_pro = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num1")
        self.no_max_pro_lab[i].next_pro = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num2")
    end

    --升级
    self.upBtn = ngui.find_button(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/btn_yellow")
    self.upBtn:set_on_click(self.bindfunc['on_rarity_up'])

    self.item_para = {}
    self.item_use = {}
    self.item_exp = {}
    self.item_fx = {}

    
    --app.log("castlist....."..table.tostring(castlist))

    for i=1,4 do
        self.item_para[i] = self.ui:get_child_by_name("animation/right_other/ui_mask_rarity_up/centre_other/animation/content/sp_di"..i.."/new_small_card_item"..i)
        --self.item_use[i] = UiSmallItem:new({parent = self.item_para[i], cardInfo = {},load_callback=press_call_back});
        self.item_exp[i] = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/content/sp_di"..i.."/lab_num")
        self.item_fx[i] = self.ui:get_child_by_name("animation/right_other/ui_mask_rarity_up/centre_other/animation/content/sp_di"..i.."/fx_ui_602_level_up_xiaohaocailiao")
        self.item_fx[i]:set_active(false)
    end

    self.lvl_now = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/lab_num")
    self.lvl_all = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/lab_num1")

    --经验条
    self.exp_tiao = ngui.find_progress_bar(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/pro_di")
    self.exp_tiao_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_rarity_up/centre_other/animation/pro_di/lab_num")
    self.exp_tiao_fx = self.ui:get_child_by_name("animation/right_other/ui_mask_rarity_up/centre_other/animation/pro_di/fx_ui_602_level_up")
    self.exp_tiao_fx:set_active(false)
    
    self:UpdateUi();
end


function MaskRarityUp:UpdateUi()
    local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskData.number,self.maskData.level)
    
    local lvl = lvldata[1]
    local rarity = lvldata[2]
    local maxexp = lvldata[3]

    local maskAllData = g_dataCenter.maskitem:get_mask_config(self.maskData.number)

    --app.log("maskAllData....."..table.tostring(maskAllData))

    local level_ratio = self.maskData.level - 1

    local default_max_hp = maskAllData.default_max_hp + (maskAllData.max_hp_level_factor*level_ratio)
    -- local max_hp_level_factor = maskAllData.max_hp_level_factor
    local NextHP = maskAllData.max_hp_level_factor + default_max_hp

    local default_atk_power = maskAllData.default_atk_power+(maskAllData.atk_power_level_factor*level_ratio)
    -- local atk_power_level_factor = maskAllData.atk_power_level_factor
    local NextATK = maskAllData.atk_power_level_factor + default_atk_power

    local default_def_power = maskAllData.default_def_power+(maskAllData.def_power_level_factor*level_ratio)
    -- local def_power_level_factor = maskAllData.def_power_level_factor
    local NextPOWER = maskAllData.def_power_level_factor + default_def_power

    local NowPRO = {default_max_hp,default_atk_power,default_def_power}
    local NextPRO = {NextHP,NextATK,NextPOWER}

    if maxexp > 0 then
        
        self.maxlvl_ui:set_active(false)
        self.no_maxlvl_ui:set_active(true)

        self.ui_lvl:set_text(tostring(lvl).."级")
        self.ui_rarity:set_text(tostring(rarity))
        self.exp_tiao_lab:set_text("[974D04FF]"..tostring(self.maskData.cur_exp).."[-][7463C9FF]/"..tostring(maxexp).."[-]")
        self.exp_tiao:set_value(self.maskData.cur_exp/maxexp)



        for i=1,3 do
            self.no_max_pro_lab[i].title:set_text(title_des[i])
            self.no_max_pro_lab[i].now_pro:set_text(tostring(PublicFunc.AttrInteger(NowPRO[i])))
            self.no_max_pro_lab[i].next_pro:set_text(tostring(PublicFunc.AttrInteger(NextPRO[i])))
        end

        self:set_cast_item_data()
    else
        self.maxlvl_ui:set_active(true)
        self.no_maxlvl_ui:set_active(false)
        self.ui_lvl:set_text(tostring(lvl).."级")
        self.ui_rarity:set_text(tostring(rarity))
        --self.exp_tiao_lab:set_text("[974D04FF]"..tostring(1).."[-][7463C9FF]/"..tostring(1).."[-]")
        self.exp_tiao_lab:set_text("")
        self.exp_tiao:set_value(1/1)

        for i=1,3 do
            self.max_pro_lab[i].title:set_text(title_des[i])
            self.max_pro_lab[i].max_pro_lab:set_text(tostring(PublicFunc.AttrInteger(NowPRO[i])))
        end
    end

end

function MaskRarityUp:on_close(t)
    uiManager:PopUi();
end

function MaskRarityUp:on_find_way_material(t)    
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

function MaskRarityUp:set_cast_item_data()

    --app.log("MaskRarityUp:set_cast_item_data")

    local castlist = g_dataCenter.maskitem:getcastlist(self.maskData.index)

    --app.log("castlist....."..table.tostring(castlist))

    self.itemnumber = {}

    for i=1,4 do
        local itemname = "cost_exp_id"..tostring(i)
        local card_id = castlist[itemname]

        local itemconfigdata = ConfigManager.Get(EConfigIndex.t_item,card_id)
        local addextvalue = itemconfigdata.exp
        self.item_exp[i]:set_text("Exp[00FF73FF]+"..tostring(addextvalue).."[-]")

        --app.log("card_prop_id...."..tostring(card_id))
        local card_prop = CardProp:new({number = card_id,count = 1});
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,card_id);

        self.itemnumber[i] = number
        ----------------------------
        local press_call_back = function(obj)
            
            if number > 0 then
                obj:SetOnPress(self.bindfunc["on_use_items"])
            else             
                obj:SetBtnAddShow(true)
                obj:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), card_id)
            end
            
        end
        ------------------------------
        
         if self.item_use[i] then
            --app.log("22222222222222222222222number"..tostring(number))
            if number > 0 then
                self.item_use[i]:SetBtnAddShow(false)
                self.item_use[i]:SetData(card_prop)
                --self.addexpitem[k]:SetCount(number)
                self.item_use[i]:SetOnPress(self.bindfunc["on_use_items"])
            else

                if k == self.currentitemindex then
                    self:stopTime()
                end
                
                self.item_use[i]:SetBtnAddShow(true)
                self.item_use[i]:SetData(card_prop)
                self.item_use[i]:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), card_id)
            end
            self.item_use[i]:SetCount(number)
        else
            self.item_use[i] = UiSmallItem:new({parent = self.item_para[i], cardInfo = card_prop,load_callback=press_call_back});
        end

    end
end

function MaskRarityUp:on_use_items(name, state, x, y, gameObject, obj)
    local itemparentname = obj.parent:get_name()
    
    --app.log("itemparentname.."..obj.cardInfo.number)

    self.currentitemindex = 1;
    
    if itemparentname == "new_small_card_item1" then
        self.currentitemindex = 1
    elseif itemparentname == "new_small_card_item2" then
        self.currentitemindex = 2
    elseif itemparentname == "new_small_card_item3" then
        self.currentitemindex = 3
    elseif itemparentname == "new_small_card_item4" then
        self.currentitemindex = 4
    end

    local itemdata = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,obj.cardInfo.number)

    self.item_id = obj.cardInfo.number

    --msg_mask.cg_eat_mask_exp(self.maskData.index,self.item_id,1)
    
    --do return end
    if state then


        self:on_play_fx()
        self:on_use_item()       
        
        local itemdata = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,obj.cardInfo.number)
        if itemdata then
            local itemdataid = itemdata.index
            
            self.item_id = obj.cardInfo.number
            self.item_fx[self.currentitemindex]:set_active(true)
            self.timeid = timer.create(self.bindfunc["on_use_item"],100,-1)
            self.fxtimeid = timer.create(self.bindfunc["on_play_fx"],1000,-1)
        else
            self:stopTime()
        end
    else
        
        self:stopTimes()
        if self.item_id ~= 0 then
            msg_mask.cg_eat_mask_exp(self.maskData.index,self.item_id,self.allitemnumber)
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
        end
        
        self.hasItemNum = 0; -- 物品个数
        self.haveitemnum = 0;
        
        self.allitemnumber = 0;

        self.haslvl = 0;     --模拟等级
        
        self.hasexp = 0;   --当前经验
        self.hasnextexp =0 ;  --下一级经验
        self.hasexpcurrent = 0;
        
        self.item_id = 0;
    end

end

function MaskRarityUp:on_play_fx(t)
    self.item_fx[self.currentitemindex]:set_active(false)
    self.item_fx[self.currentitemindex]:set_active(true) 
    self.exp_tiao_fx:set_active(false)
    self.exp_tiao_fx:set_active(true)
end

function MaskRarityUp:on_use_item(t)
    
    if self.item_id ~= 0 then
        --msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,1)
        self.hasItemNum = self.hasItemNum + 1
        self.haveitemnum = self.haveitemnum + 1;
        self.allitemnumber = self.allitemnumber + 1
        self:setMLData()

        AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpLoop)
    end
end

--模拟吃药
function MaskRarityUp:setMLData()
    if self.itemnumber[self.currentitemindex] >= self.hasItemNum then
        self.item_use[self.currentitemindex]:SetCount(self.itemnumber[self.currentitemindex] - self.hasItemNum )
    else
        self:stopTime()
        --app.log("self:stopTime()..allnumber"..tostring(self.itemnumber[self.currentitemindex]))
        self.item_use[self.currentitemindex]:SetBtnAddShow(true)
        if self.item_id ~= 0 then
            msg_mask.cg_eat_mask_exp(self.maskData.index,self.item_id,self.itemnumber[self.currentitemindex])
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
        end

        self.hasItemNum = 0; -- 物品个数
        self.haveitemnum = 0;

        self.allitemnumber = 0;
        
        self.haslvl = 0;     --模拟等级
        
        self.hasexp = 0;   --当前经验
        self.hasnextexp =0 ;  --下一级经验
        self.hasexpcurrent = 0;
        
        self.data_id = 0;
        self.item_id = 0;
        do return end
    end

    --当前等级
        
    local lvlindex = self.maskData.level
    
    if self.haslvl <= lvlindex then       
        self.haslvl = lvlindex
    end

    --当前经验
    local currentexp = self.maskData.cur_exp

    --物品列表
    local castlist = g_dataCenter.maskitem:getcastlist(self.maskData.index)

    local itemname = "cost_exp_id"..tostring(self.currentitemindex)
    local card_id = castlist[itemname]
    local itemconfigdata = ConfigManager.Get(EConfigIndex.t_item,card_id)
    local additemexp = itemconfigdata.exp
   
    local addallexp = additemexp*self.haveitemnum

    --当前经验
    if self.haslvl <= lvlindex then
        --app.log("111self.hasexp##################"..tostring(self.hasexp))
        self.hasexp = currentexp + addallexp
    else
        --app.log("222self.hasexp##################"..tostring(self.hasexp))
        self.hasexp = self.hasexpcurrent + addallexp
    end

    local Allexp = g_dataCenter.maskitem:get_Need_exp(self.maskData.number,self.haslvl)

    app.log("self.hasexp.........."..tostring(self.hasexp))

    --升级了
    if self.hasexp >= Allexp then
        
        app.log("upupupupupup#######################")
        self.hasexp = self.hasexp - Allexp
        self.hasexpcurrent = self.hasexp
        self.haslvl = self.haslvl + 1
        --Allexp = g_dataCenter.maskitem:get_Need_exp(self.maskData.number,self.maskData.level)
        -- if self.item_id ~= 0 then
        --     msg_mask.cg_eat_mask_exp(self.maskData.index,self.item_id,self.haveitemnum)
        -- end
        self.haveitemnum = 0;
    end

    local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskData.number,self.haslvl)
    
    local lvl = lvldata[1]
    local rarity = lvldata[2]
    local maxexp = lvldata[3]

    local maskAllData = g_dataCenter.maskitem:get_mask_config(self.maskData.number)

    local level_ratio = self.haslvl - 1

    local default_max_hp = maskAllData.default_max_hp + (maskAllData.max_hp_level_factor*level_ratio)
    
    local NextHP = maskAllData.max_hp_level_factor + default_max_hp

    local default_atk_power = maskAllData.default_atk_power+(maskAllData.atk_power_level_factor*level_ratio)
   
    local NextATK = maskAllData.atk_power_level_factor + default_atk_power

    local default_def_power = maskAllData.default_def_power+(maskAllData.def_power_level_factor*level_ratio)
   
    local NextPOWER = maskAllData.def_power_level_factor + default_def_power

    local NowPRO = {default_max_hp,default_atk_power,default_def_power}
    local NextPRO = {NextHP,NextATK,NextPOWER}

    --刷新mask_info 界面的等级
    local obj = uiManager:FindUI(EUI.MaskMainInfo)
    obj:rush_lvl(self.maskData.index,self.haslvl,self.hasexp)

    if maxexp > 0 then
        
        self.maxlvl_ui:set_active(false)
        self.no_maxlvl_ui:set_active(true)

        self.ui_lvl:set_text(tostring(lvl).."级")
        self.ui_rarity:set_text(tostring(rarity))
        self.exp_tiao_lab:set_text("[974D04FF]"..tostring(self.hasexp).."[-][7463C9FF]/"..tostring(maxexp).."[-]")
        self.exp_tiao:set_value(self.hasexp/maxexp)

        for i=1,3 do
            self.no_max_pro_lab[i].now_pro:set_text(tostring(PublicFunc.AttrInteger(NowPRO[i])))
            self.no_max_pro_lab[i].next_pro:set_text(tostring(PublicFunc.AttrInteger(NextPRO[i])))
        end

    else
        if self.item_id ~= 0 then
            msg_mask.cg_eat_mask_exp(self.maskData.index,self.item_id,self.allitemnumber)
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
        end

        self.maxlvl_ui:set_active(true)
        self.no_maxlvl_ui:set_active(false)
        self.ui_lvl:set_text(tostring(lvl).."级")
        self.ui_rarity:set_text(tostring(rarity))
        self.exp_tiao_lab:set_text("[974D04FF]"..tostring(self.hasexp).."[-][7463C9FF]/"..tostring(self.hasexp).."[-]")
        self.exp_tiao:set_value(self.hasexp/self.hasexp)

        for i=1,3 do
            self.max_pro_lab[i].max_pro_lab:set_text(tostring(PublicFunc.AttrInteger(NowPRO[i])))
        end

        self:stopTime()
    end    

end

function MaskRarityUp:stopTime()

    self.exp_tiao_fx:set_active(false)

    for i=1,4 do
        if self.item_fx[i] then
            self.item_fx[i]:set_active(false)
        end
    end
    
    if self.timeid then
        timer.stop(self.timeid)
        self.timeid = nil;
        
    end
    
    if self.fxtimeid then
        timer.stop(self.fxtimeid)
        self.fxtimeid = nil
        self.item_fx[self.currentitemindex]:set_active(false)
    end
end

function MaskRarityUp:stopTimes()

    self.exp_tiao_fx:set_active(false)
    
    if self.timeid then
        timer.stop(self.timeid)
        self.timeid = nil;
        
    end
    
    if self.fxtimeid then
        timer.stop(self.fxtimeid)
        self.fxtimeid = nil
    end
    
end

function MaskRarityUp:upmaskinfo(maskinfo)
    
    if self.curindex == maskinfo.index then

        self.maskData = maskinfo

        self:RestRarityUp()
        --pp.log("upmaskinfo------------------rarityup"..table.tostring(self.maskData))

        self:UpdateUi()
    end

end

--[[升阶]]
function MaskRarityUp:on_rarity_up()

    local flag = self:isUpMaskLvl()

    --app.log("flag-----------"..tostring(flag))

    if flag then
        msg_mask.cg_upgrade_mask(self.maskData.index)
    else
        FloatTip.Float("升级材料不够！");
    end
end

--判断玩家身上是否有升级物品

function MaskRarityUp:isUpMaskLvl()
    local flag = false
    local castlist = g_dataCenter.maskitem:getcastlist(self.maskData.index)

    for i=1,4 do
        local itemname = "cost_exp_id"..tostring(i)
        local card_id = castlist[itemname]
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,card_id);

        local lvldata = g_dataCenter.maskitem:get_show_lvl_exp(self.maskData.number,self.maskData.level)

        local maxexp = lvldata[3]

        if maskinfo == 0 then
            return false
        end

        if number > 0 then
            --经验判断
            flag = true
            return flag
        end
    end

    return flag
end

function MaskRarityUp:RestRarityUp()
    self.hasItemNum = 0; -- 物品个数
    self.haveitemnum = 0;

    self.allitemnumber = 0;
    
    self.haslvl = 0;     --模拟等级
    
    self.hasexp = 0;   --当前经验
    self.hasnextexp =0 ;  --下一级经验
    self.hasexpcurrent = 0;
    
    self.data_id = 0;
    self.item_id = 0;
end

function MaskRarityUp:SetConfigData(roleData, isPlayer)  
    
end

function MaskRarityUp:SetInfo(maskinfo)

    for i=1,4 do
        self.item_fx[i]:set_active(false)
    end 

    self.maskData = maskinfo
    self.curindex= maskinfo.index
    self:UpdateUi()
end

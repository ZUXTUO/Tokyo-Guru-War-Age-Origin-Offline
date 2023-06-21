MaskLvlUp = Class("MaskLvlUp", UiBaseClass)

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

function MaskLvlUp:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mask/ui_904_mask.assetbundle"
	UiBaseClass.Init(self, data);
end

function MaskLvlUp:InitData(data)
    UiBaseClass.InitData(self, data)
    -- self.parent = data.parent
    -- self.roleData = data.info
    -- self.isPlayer = data.isPlayer 

    self.maskData = data.info

    self.propertyUI = {}
    
    self.upConfig = {gold = nil, level = nil, material = {}}
    self.propertyValue = {}
    
    self.curindex = self.maskData.index

    --self:SetConfigData()
    self.materialUi = {} 
end

function MaskLvlUp:Restart(data)
    self.tipsUI = nil
	if UiBaseClass.Restart(self, data) then

	end
end

function MaskLvlUp:DestroyUi()
    UiBaseClass.DestroyUi(self);

    for k,v in pairs(self.up_pro_item) do
        v:DestroyUi()
    end

end

function MaskLvlUp:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_rarity_up"] = Utility.bind_callback(self, self.on_rarity_up);
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self, self.on_find_way_material)
    self.bindfunc["upmaskinfo"] = Utility.bind_callback(self, self.upmaskinfo)
end

--注册消息分发回调函数
function MaskLvlUp:MsgRegist()
    --app.log("MsgRegist===========================")
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])   
end

--注销消息分发回调函数
function MaskLvlUp:MsgUnRegist()
    --app.log("MsgUnRegist===========================")
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])
end

function MaskLvlUp:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_mask_lvl_up')  

    self.mask_prop_sp = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_line/sp_prop")
    self.mask_prop_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_line/lab_nature")

    --未满级
    self.no_max_lvl_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/content")

    --提升属性
    self.up_pro_lab = {}
    for i=1,6 do
        self.up_pro_lab[i] = {}
        self.up_pro_lab[i].obj = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont_nature/sp_bk"..i)
        self.up_pro_lab[i].obj:set_active(false)
        self.up_pro_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/txt")
        self.up_pro_lab[i].upicon = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/sp_arrows")
        self.up_pro_lab[i].nowvalue = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num1")
        self.up_pro_lab[i].nextvalue = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num2")
    end

    self.up_pro_item = {}
    self.up_pro_item_para = {}
    for i=1,3 do
        self.up_pro_item_para[i] = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/content/new_small_card_item"..i)
        
    end
    --未满足条件
    self.tiaojian_lvl_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/lab_mask")
    --满足需要金币
    self.tiaojian_ok_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont")
    self.tiaojian_ok_ui:set_active(false)
    self.tiaojian_ok_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/cont/lab")

    self.tupoBtn = ngui.find_button(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/btn")
    self.tupoBtn:set_on_click(self.bindfunc['on_rarity_up'])

    --满级
    self.max_lvl_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_art_font")

    self.max_lvl_fx = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_art_font/fx_ui_604_4_dingji")

    self.max_pro_lab = {}
    for i=1,6 do
        self.max_pro_lab[i] = {}
        self.max_pro_lab[i].obj = self.ui:get_child_by_name("animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i)
        self.max_pro_lab[i].obj:set_active(false)
        self.max_pro_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/txt")
        self.max_pro_lab[i].pro_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/lab_num")
    end

    self.max_lvl_ui:set_active(false)

    self.point = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_lvl_up/centre_other/animation/content/btn/animation/sp_point")

    self:UpdateUi();
end

function MaskLvlUp:UpdateUi()
   
    local up_rarity_data = g_dataCenter.maskitem:get_mask_config(self.maskData.number)
   
    local up_rarity_lvl = up_rarity_data.rarity_up_level
    local up_rarity_gold = up_rarity_data.rarity_up_gold
    local up_rarity_item_list = up_rarity_data.rarity_up_material

    if up_rarity_item_list ~= 0 then
        self:set_item(up_rarity_item_list)
    end

    self:set_rarity()

    self:set_pro_value()

    self:isUnlock(up_rarity_lvl,up_rarity_gold)

    if self:isUpMaskRarity() then
        self.point:set_active(true)
    else
        self.point:set_active(false)
    end

end

function MaskLvlUp:set_rarity()
    --品质
    local maskid = self.maskData.number
    local real_rarity = g_dataCenter.maskitem:get_real_rarity(maskid)
    --app.log("real_rarity......"..tostring(real_rarity))
    local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity_pz_text(real_rarity)
    --app.log("MaskLvlUp......real_rarity_ui"..table.tostring(real_rarity_ui))
    self.mask_prop_sp:set_sprite_name(real_rarity_ui[1])
    self.mask_prop_lab:set_text(real_rarity_ui[2].." "..real_rarity_ui[3])
end

function MaskLvlUp:set_pro_value()
    local data = g_dataCenter.maskitem:get_now_pro_value(self.maskData.number,self.maskData.level)
    app.log("MaskLvlUp....get_pro_value..."..table.tostring(data))

    for i=1,#data do
        if data[i].isMax then
            self.no_max_lvl_ui:set_active(false)
            self.max_lvl_ui:set_active(true)
            self:play_max_fx()
            self.max_pro_lab[i].obj:set_active(true)
            self.max_pro_lab[i].title:set_text(data[i].add_tit)
            self.max_pro_lab[i].pro_lab:set_text(tostring(data[i].now_value))
        else
            self.no_max_lvl_ui:set_active(true)
            self.max_lvl_ui:set_active(false)
            self.up_pro_lab[i].obj:set_active(true)
            self.up_pro_lab[i].title:set_text(data[i].add_tit)
            self.up_pro_lab[i].nowvalue:set_text(tostring(data[i].now_value))
            self.up_pro_lab[i].nextvalue:set_text(tostring(data[i].add_value))
        end
    end

end

function MaskLvlUp:play_max_fx()
    self.max_lvl_fx:set_active(false)
    self.max_lvl_fx:set_active(true)
end

function MaskLvlUp:isUnlock(needlvl,needgold)
    local havegold = g_dataCenter.player.gold
    local currlvl = self.maskData.level

    --app.log("havegold......."..tostring(havegold))

    --app.log("currlvl........"..tostring(currlvl))

    if (havegold >= needgold) and (currlvl >= needlvl) then
        self.tiaojian_lvl_lab:set_text("")
        self.tiaojian_ok_ui:set_active(true)
        self.tiaojian_lvl_lab:set_text("")
        self.tiaojian_ok_lab:set_text(tostring(needgold))
        --app.log("1111111111111111111111111111111")
    else
        if currlvl < needlvl then
            self.tiaojian_ok_ui:set_active(false)
            local havelvl = g_dataCenter.maskitem:get_show_lvl_exp(self.maskData.number,needlvl)
            self.tiaojian_lvl_lab:set_text("强化达到"..tostring(havelvl[1]).."级")
            --app.log("222222222222222222222222222")
            do return end
        end

        if havegold < needgold then
            self.tiaojian_ok_ui:set_active(true)
            self.tiaojian_lvl_lab:set_text("")
            self.tiaojian_ok_lab:set_text(tostring(needgold))
            --app.log("333333333333333333333333333333")
            do return end
        end 
    end

end

function MaskLvlUp:set_item(itemlist)
    for i=1,#itemlist do
        local itemid = itemlist[i][1]
        local count = itemlist[i][2]
        local card_prop = CardProp:new({number = itemid,count = count});
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

        --app.log("number=============="..tostring(number))
        ----------------------------
        local press_call_back = function(obj)
            
            if number >= count then
                --obj:SetOnPress(self.bindfunc["on_use_items"])
            else             
                obj:SetBtnAddShow(true)
                obj:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), itemid)
            end
            
        end
        ------------------------------

        if self.up_pro_item[i] then
            --app.log("22222222222222222222222number"..tostring(number))
            if number >= count then
                self.up_pro_item[i]:SetBtnAddShow(false)
                self.up_pro_item[i]:SetData(card_prop)
                --self.addexpitem[k]:SetCount(number)
                --self.item_use[i]:SetOnPress(self.bindfunc["on_use_items"])
            else                
                self.up_pro_item[i]:SetBtnAddShow(true)
                self.up_pro_item[i]:SetData(card_prop)
                self.up_pro_item[i]:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), itemid)
            end
            --self.up_pro_item[i]:SetCount(number)
            self.up_pro_item[i]:SetNumberStr(tostring(number).."/"..tostring(count))
        else
            self.up_pro_item[i] = UiSmallItem:new({parent = self.up_pro_item_para[i], cardInfo = card_prop,load_callback=press_call_back});
            self.up_pro_item[i]:SetNumberStr(tostring(number).."/"..tostring(count))
        end 
    end
end

function MaskLvlUp:on_close(t)
    uiManager:PopUi();
end

function MaskLvlUp:on_find_way_material(t)    
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

--[[升品]]
function MaskLvlUp:on_rarity_up()
    
    local flag = self:isUpMaskRarity()

    if flag then
        msg_mask.cg_mask_rarity_up(self.maskData.index,self.maskData.number)
    else
        FloatTip.Float("打磨材料不够！");
    end
end

function MaskLvlUp:isUpMaskRarity()

    local flag = false

    local havegold = g_dataCenter.player.gold
    local currlvl = self.maskData.level

    local up_rarity_data = g_dataCenter.maskitem:get_mask_config(self.maskData.number)
   
    local up_rarity_lvl = up_rarity_data.rarity_up_level
    local up_rarity_gold = up_rarity_data.rarity_up_gold
    local itemlist = up_rarity_data.rarity_up_material

    if up_rarity_lvl > currlvl then
        return false
    end

    if up_rarity_gold >= havegold then
        return false
    end

    local index = 0;

    if itemlist ~= 0 then
        for i=1,#itemlist do
            local itemid = itemlist[i][1]
            local count = itemlist[i][2]
            local card_prop = CardProp:new({number = itemid,count = count});
            local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

            if number >= count then
                index = index + 1
            end

            if index == 3 then
                return true
            end

        end
    end

    return flag

end

function MaskLvlUp:upmaskinfo(maskinfo)
    if self.curindex == maskinfo.index then
        app.log("MaskLvlUp:upmaskinfo==================="..table.tostring(maskinfo))
        self.maskData = maskinfo
        
        self:UpdateUi()
    end
end

function MaskLvlUp:SetConfigData(roleData, isPlayer)  
    
end

function MaskLvlUp:SetInfo(maskinfo)    
    self.maskData = maskinfo
    self.curindex= maskinfo.index
    self:UpdateUi()
end

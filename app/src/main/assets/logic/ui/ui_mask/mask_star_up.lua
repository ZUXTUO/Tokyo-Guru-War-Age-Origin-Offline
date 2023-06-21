MaskStarUp = Class("MaskStarUp", UiBaseClass)

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

function MaskStarUp:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/mask/ui_903_mask.assetbundle"
	UiBaseClass.Init(self, data);
end

function MaskStarUp:InitData(data)
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

function MaskStarUp:Restart(data)
    self.tipsUI = nil
	if UiBaseClass.Restart(self, data) then

	end
end

function MaskStarUp:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.up_star_item:DestroyUi()

end

function MaskStarUp:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_rarity_up"] = Utility.bind_callback(self, self.on_rarity_up);
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self, self.on_find_way_material)
    self.bindfunc["upmaskinfo"] = Utility.bind_callback(self, self.upmaskinfo)
end

--注册消息分发回调函数
function MaskStarUp:MsgRegist()
    --app.log("MsgRegist===========================")
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])   
end

--注销消息分发回调函数
function MaskStarUp:MsgUnRegist()
    --app.log("MsgUnRegist===========================")
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_mask.gc_update_mask_info, self.bindfunc["upmaskinfo"])
end
function MaskStarUp:InitUI(obj)
    UiBaseClass.InitUI(self, obj);    
    self.ui:set_name('ui_mask_star_up')  

    self.mask_star_sp = {}
    for i=1,7 do
        self.mask_star_sp[i] = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/grid/sp_prop"..i)
        self.mask_star_sp[i]:set_sprite_name("mjd_yanjing2")
    end

    --未满星
    self.no_max_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/content")

    self.no_max_lab = {}
    for i=1,6 do
        self.no_max_lab[i] = {}
        self.no_max_lab[i].obj = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/content/cont_nature/sp_bk"..i)
        self.no_max_lab[i].obj:set_active(false)
        self.no_max_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/txt")
        self.no_max_lab[i].icon = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/sp_arrows")
        self.no_max_lab[i].now_pro = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num1")
        self.no_max_lab[i].next_pro = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/cont_nature/sp_bk"..i.."/lab_num2")
    end
    --升星花费
    self.up_star_cast_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/cont/lab")

    self.up_star_item_para = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/content/new_small_card_item")
    --self.up_star_item = UiSmallItem:new({parent = self.up_star_item_para, cardInfo = card_prop,load_callback=press_call_back});

    --满星
    self.max_ui = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/sp_art_font")
    self.max_ui_fx = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/sp_art_font/fx_ui_604_4_dingji")

    self.max_pro_lab = {}
    for i=1,6 do
        self.max_pro_lab[i] = {}
        self.max_pro_lab[i].obj = self.ui:get_child_by_name("animation/right_other/ui_mask_star_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i)
        self.max_pro_lab[i].obj:set_active(false)
        self.max_pro_lab[i].title = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/txt")
        self.max_pro_lab[i].pro_lab = ngui.find_label(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/sp_art_font/cont_nature/sp_bk"..i.."/lab_num")
    end

    self.upStarBtn = ngui.find_button(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/btn")
    self.upStarBtn:set_on_click(self.bindfunc['on_rarity_up'])

    self.max_ui:set_active(false)

    self.point = ngui.find_sprite(self.ui,"animation/right_other/ui_mask_star_up/centre_other/animation/content/btn/animation/sp_point")

    self:UpdateUi();
end

function MaskStarUp:UpdateUi()

    for i=1,7 do
        self.mask_star_sp[i]:set_sprite_name("mjd_yanjing2")
    end

    local up_star_itemid = g_dataCenter.maskitem:get_mask_config(self.maskData.number).hero_soul_item_id
    local up_star_item_count = g_dataCenter.maskitem:get_mask_config(self.maskData.number).soul_count
    local up_star_gold = g_dataCenter.maskitem:get_mask_config(self.maskData.number).star_up_gold
    self.up_star_cast_lab:set_text(tostring(up_star_gold))

    self:set_pro_value()

    self:set_item(up_star_itemid,up_star_item_count)

    local star = g_dataCenter.maskitem:get_mask_config(self.maskData.number).rarity

    for i=1,star do
        self.mask_star_sp[i]:set_sprite_name("mjd_yanjing1")
    end

    if self:isUpMaskStar() then
        self.point:set_active(true)
    else
        self.point:set_active(false)
    end

end

function MaskStarUp:set_pro_value()

    local data = g_dataCenter.maskitem:get_now_pro_star_value(self.maskData.number,self.maskData.level)
    --app.log("MaskStarUp....set_pro_value..."..table.tostring(data))

    for i=1,#data do
        if data[i].isMax then
            self.no_max_ui:set_active(false)
            self.max_ui:set_active(true)
            self:play_max_fx()
            self.max_pro_lab[i].obj:set_active(true)
            self.max_pro_lab[i].title:set_text(data[i].add_tit)
            self.max_pro_lab[i].pro_lab:set_text(tostring(data[i].now_value))
        else
            self.max_ui:set_active(false)
            self.no_max_ui:set_active(true)
            self.no_max_lab[i].obj:set_active(true)
            self.no_max_lab[i].title:set_text(data[i].add_tit)
            self.no_max_lab[i].now_pro:set_text(tostring(data[i].now_value))
            self.no_max_lab[i].next_pro:set_text(tostring(data[i].add_value))
        end
    end
end

function MaskStarUp:play_max_fx()
    self.max_ui_fx:set_active(false)
    self.max_ui_fx:set_active(true)
end

function MaskStarUp:set_item(itemid,count)

    local card_prop = CardProp:new({number = itemid,count = count});
    local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

    app.log("number=============="..tostring(number).."  count ..........."..tostring(count))

    ----------------------------
    local press_call_back = function(obj)
        
        if number >= count then
            --obj:SetOnPress(self.bindfunc["on_use_items"])
        else             
            obj:SetBtnAddShow(true)
            obj:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), itemid)
        end
        
    end
    ---------------------self.up_star_item = UiSmallItem:new({parent = self.up_star_item_para, cardInfo = card_prop,load_callback=press_call_back});

    if self.up_star_item then
        --app.log("22222222222222222222222number"..tostring(number))
        if number >= count then
            self.up_star_item:SetBtnAddShow(false)
            self.up_star_item:SetData(card_prop)
        else                
            self.up_star_item:SetBtnAddShow(true)
            self.up_star_item:SetData(card_prop)
            self.up_star_item:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), itemid)
        end
        --self.up_star_item:SetCount(number)
        self.up_star_item:SetNumberStr(tostring(number).."/"..tostring(count))
    else
        self.up_star_item = UiSmallItem:new({parent = self.up_star_item_para, cardInfo = card_prop,load_callback=press_call_back});
        self.up_star_item:SetNumberStr(tostring(number).."/"..tostring(count))
    end 
end

function MaskStarUp:on_close(t)
    uiManager:PopUi();
end

function MaskStarUp:on_find_way_material(t)    
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

--[[升品]]
function MaskStarUp:on_rarity_up()

    local flag = self:isUpMaskStar()

    if flag then
        msg_mask.cg_mask_star_up( self.maskData.index,self.maskData.number )
    else
        FloatTip.Float("突破材料不够！");
    end

end

function MaskStarUp:isUpMaskStar()

     local flag = false

    local itemid = g_dataCenter.maskitem:get_mask_config(self.maskData.number).hero_soul_item_id
    local count = g_dataCenter.maskitem:get_mask_config(self.maskData.number).soul_count
    local up_star_itemid = g_dataCenter.maskitem:get_mask_config(self.maskData.number).star_up_number

    --app.log("up_star_itemid........"..tostring(up_star_itemid))

    if up_star_itemid ~= 0 then
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,itemid);

        if number >= count then
            return true
        end
    end

    return flag
end

function MaskStarUp:upmaskinfo(maskinfo)
    if self.curindex == maskinfo.index then
        self.maskData = maskinfo

        self:UpdateUi()
    end
end

function MaskStarUp:SetConfigData(roleData, isPlayer)  
    
end

function MaskStarUp:SetInfo(maskinfo)    
    self.maskData = maskinfo
    self.curindex= maskinfo.index
    self:UpdateUi()
end

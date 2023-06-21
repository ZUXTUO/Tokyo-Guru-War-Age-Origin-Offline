--fileName:break_through_preview_ui.lua
--desc:用于查看突破界限客户端升级预览
--code by:fengyu
--date:2016-7-15

BreakThroughPreviewUI = Class( "BreakThroughPreviewUI", UiBaseClass );

local _ColumnCount = 4

local GOLD_SCALE = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_breakthrough_scale).data or 1;
local attr_name =
{
    [breakthrough_key.max_hp]=ENUM.EHeroAttribute.max_hp,
    [breakthrough_key.atk_power]=ENUM.EHeroAttribute.atk_power,
    [breakthrough_key.def_power]=ENUM.EHeroAttribute.def_power,
    [breakthrough_key.crit_rate]=ENUM.EHeroAttribute.crit_rate,
    [breakthrough_key.anti_crite]=ENUM.EHeroAttribute.anti_crite,
    [breakthrough_key.crit_hurt]=ENUM.EHeroAttribute.crit_hurt,
    [breakthrough_key.broken_rate]=ENUM.EHeroAttribute.broken_rate,
    [breakthrough_key.parry_rate]=ENUM.EHeroAttribute.parry_rate,
    [breakthrough_key.parry_plus]=ENUM.EHeroAttribute.parry_plus,
};

function BreakThroughPreviewUI:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_12_1.assetbundle";
    UiBaseClass.Init( self, data );
end

function BreakThroughPreviewUI:InitData( data, sort_config_stage)
    UiBaseClass.InitData( self, data );
    self.breakthroughData = data;
    
    self.itemList = {};
    self.addItemList = {};
    self.itemGridList = {};
    self.total_break_exp = 0;
    self.attrContList = {};
    self.initItemData = false;
    self.sliderSteps = 0;
    self.selectIndex = 0;
    self.selectItem = nil;
    
    self:getBreakThroughItemData();
end

function BreakThroughPreviewUI:Restart( data )
    self.breakthroughData = data;
    self:getBreakThroughItemData();
    if UiBaseClass.Restart( self, data ) then
        --self:UpdateUi();
    end
end

function BreakThroughPreviewUI:DestroyUi()
    self:ClearItemGridList();
    if self.viewUiCard then
        self.viewUiCard:DestroyUi()
        self.viewUiCard = nil
    end
    self.breakthroughData = nil;
    self.itemList = {};
    self.addItemList = {};
    self.total_break_exp = 0;
    self.initItemData = false;
    self.attrContList = {}
    self.subItemSPList = {};
    self.sliderSteps = 0;
    self.selectIndex = 0;
    self.selectItem = nil;

    UiBaseClass.DestroyUi( self );
end

function BreakThroughPreviewUI:Show()
    if self.fx then
        self.fx:set_active(false)   
    end
    UiBaseClass.Show( self );
end

function BreakThroughPreviewUI:Hide()
    UiBaseClass.Hide( self );
end

function BreakThroughPreviewUI:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["OnClose"] = Utility.bind_callback( self, self.OnClose );
    self.bindfunc["OnUpdateBreakthrough"] = Utility.bind_callback( self, self.OnUpdateBreakthrough );
    self.bindfunc["on_btn_crystal"] = Utility.bind_callback( self, self.on_btn_crystal );
    self.bindfunc["item_update"] = Utility.bind_callback( self, self.init_wrapper_item );
    self.bindfunc['on_update_breakthrough'] = Utility.bind_callback( self, self.on_update_breakthrough);
    self.bindfunc["on_btn_item_clear"] = Utility.bind_callback( self, self.on_btn_item_clear);
    self.bindfunc["on_btn_item_click"] = Utility.bind_callback( self, self.on_btn_item_click);
    self.bindfunc["on_click_item_min"] = Utility.bind_callback( self, self.on_click_item_min);
    self.bindfunc["on_click_item_max"] = Utility.bind_callback( self, self.on_click_item_max);
    self.bindfunc["on_slider_value_change"] = Utility.bind_callback( self, self.on_slider_value_change);
end

function BreakThroughPreviewUI:MsgRegist()
    UiBaseClass.MsgRegist( self );
    PublicFunc.msg_regist(msg_cards.gc_breakthrough,self.bindfunc['on_update_breakthrough']);
end

function BreakThroughPreviewUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist( self );
    PublicFunc.msg_unregist(msg_cards.gc_breakthrough,self.bindfunc['on_update_breakthrough']);
end

function BreakThroughPreviewUI:InitUI( obj )
    UiBaseClass.InitUI( self,obj );
    self.ui:set_name( "ui_break_through_preview" );
    
    local btnClose = ngui.find_button( self.ui, "centre_other/animation/content_di_926_650/btn_cha" );
    local btnBreakthrough = ngui.find_button( self.ui, "centre_other/animation/sp_bk2/cont/btn2" );
    local btnCrystal = ngui.find_button( self.ui, "centre_other/animation/sp_bk2/cont/btn1" )

    btnClose:set_on_click( self.bindfunc["OnClose"] );
    btnBreakthrough:set_on_click( self.bindfunc["OnUpdateBreakthrough"] );
    btnCrystal:set_on_click( self.bindfunc["on_btn_crystal"] );
    
    self.objNoMaterial = self.ui:get_child_by_name( "centre_other/animation/content" );
    self.objHaveMaterial = self.ui:get_child_by_name( "centre_other/animation/sp_bk2" );
    self.labViewItemName = ngui.find_label( self.objHaveMaterial, "cont/lab_name" );
    self.labViewAddExp = ngui.find_label( self.objHaveMaterial, "cont/lab_exp" );
    self.labViewAddNum = ngui.find_label( self.objHaveMaterial, "cont/txt_yitianjia/lab_num" );
    self.labViewGoldNum = ngui.find_label( self.objHaveMaterial, "cont/sp_di2/lab" );
    self.viewUiCard = UiSmallItem:new( { parent = self.objHaveMaterial:get_child_by_name("new_small_card_item") } )

    local btnMin = ngui.find_button(self.objHaveMaterial, "cont/act/btn_red")
    local btnMax = ngui.find_button(self.objHaveMaterial, "cont/act/btn_blue")
    btnMin:set_on_click(self.bindfunc["on_click_item_min"])
    btnMax:set_on_click(self.bindfunc["on_click_item_max"])

    self.slider = ngui.find_slider(self.objHaveMaterial, "cont/act/pro_back")
    self.slider:set_on_change(self.bindfunc["on_slider_value_change"])
    
    self.scrollViewItem = ngui.find_scroll_view( self.objHaveMaterial, "scroll_view/panel_list" );
    self.wrapperItem = ngui.find_wrap_content( self.objHaveMaterial, "scroll_view/panel_list/wrap_content" );
    self.wrapperItem:set_on_initialize_item( self.bindfunc["item_update"] );
    
    local objPanelTop = self.ui:get_child_by_name("centre_other/animation/sp_bk1")
    --显示面板
    self.labCurStage = ngui.find_label( objPanelTop, "sp_bk1/lab" );
    self.spStageIcon = ngui.find_sprite( objPanelTop, "sp_bk1/sp" );
    self.labCurLvl = ngui.find_label( objPanelTop, "sp_bk1/lab_lab" );
    self.labNextLvl = ngui.find_label( objPanelTop, "sp_bk1/lab_level2" );
    self.labNextLvl:set_active( false );
    self.spNextLvlArrow = ngui.find_sprite( objPanelTop, "sp_bk1/sp_arrows" );
    self.spNextLvlArrow:set_active( false );
    self.labExpNum = ngui.find_label( objPanelTop, "sp_bk1/pro_di/lab_exp" );
    self.progressBarExp = ngui.find_progress_bar( objPanelTop, "sp_bk1/pro_di" );
    self.progressBarExpPic = ngui.find_sprite( objPanelTop, "sp_bk1/pro_di/sp" )
    self.progressBarExp2 = ngui.find_progress_bar( objPanelTop, "sp_bk1/pro_di/sp_bar2" );

    self.labTextStage = ngui.find_label(objPanelTop, "sp/lab_dengji")
    self.labTextStage:set_active(false)
    
    for i = 1, 3 do
        local objCont = objPanelTop:get_child_by_name("nature_grid/cont"..i)
        self.attrContList[i] = {}
        self.attrContList[i].obj = objCont
        self.attrContList[i].name = ngui.find_label(objCont, "txt")
        self.attrContList[i].val1 = ngui.find_label(objCont, "lab")
        self.attrContList[i].val2 = ngui.find_label(objCont, "lab_num2")
        self.attrContList[i].arrow = ngui.find_sprite(objCont, "sp_jian_tou")
    end

    self.fx = objPanelTop:get_child_by_name("sp_bk1/pro_di/fx")
    self.fx:set_active(false)
    
    -- self.usefx = self.ui:get_child_by_name("centre_other/animation/sp_bk2/scroll_view/panel_list/fx_ui_602_level_up_xiaohaocailiao")
    
    -- self.labanim = self.ui:get_child_by_name("centre_other/animation/sp_bk1")
    if #self.itemList > 0 then
        self:SetSelectIndex(1) --初始选中第一项
    end

    self:InitItemList();
    self:UpdateUi();
    self:UpdateBreakLvlDisp()
end

function BreakThroughPreviewUI:InitItemList()
    local rowNum = math.ceil((#self.itemList)/_ColumnCount);
    self.wrapperItem:set_min_index(-(rowNum-1));
    self.wrapperItem:set_max_index(0);
    self.wrapperItem:reset();
    self.scrollViewItem:reset_position();
end

function BreakThroughPreviewUI:UpdateUi()
    if not self.ui then return end

    if #self.itemList > 0 then
        self.objNoMaterial:set_active( false );
        self.objHaveMaterial:set_active( true );
    else
        self.objNoMaterial:set_active( true );
        self.objHaveMaterial:set_active( false );
    end

    --更新显示数据面板的内容
    self.labCurStage:set_text( self.breakthroughData.curStageTxt );
    self.spStageIcon:set_sprite_name( "tp_jieduan"..tostring(self.breakthroughData.stage) );
end

function BreakThroughPreviewUI:OnClose()
    uiManager:PopUi();
end

function BreakThroughPreviewUI:SetSelectIndex(index)
    self.selectIndex = index
    self.selectItem = self:GetItem(index)
end


--获取所有物品然后添加能添加突破经验的物品到物品列表中
function BreakThroughPreviewUI:getBreakThroughItemData()
    if self.initItemData then
        return;
    end
    
    local allItem =  g_dataCenter.package:GetAllItemData();
    for k, item in pairs( allItem ) do
        --local num = item.value.count;
        --local config = item.value.config;
        --local category = item.value.category; --9 is breakthrough special item
        --local exp = item.value.config.breakthrough_exp;
        if item.value.config.breakthrough_exp > 0 then
            table.insert( self.itemList, item );
            self.addItemList[#self.itemList] = 0
        end
    end
    
    sort_func = function(a, b)
        if a.value.category == 9 and b.value.category ~= 9 then
            return true;
        elseif a.value.category ~= 9 and b.value.category == 9 then
            return false;
        elseif a.value.category == 9 and b.value.category == 9 then
            return false;
        end
        if a.value.config.id < b.value.config.id then
            return true;
        elseif a.value.config.id > b.value.config.id then
            return false;
        end
        return false;
    end
    
    table.sort(self.itemList, sort_func);
    self.initItemData = true;
end

function BreakThroughPreviewUI:on_btn_crystal()
    -- TODO
end

function BreakThroughPreviewUI:OnUpdateBreakthrough()
    local itemNumber = 0;
    for k, v in pairs(self.addItemList) do
        itemNumber = itemNumber + v;
    end
    
    local needGold = GOLD_SCALE * self.total_break_exp;
    if itemNumber > 0 and needGold <= g_dataCenter.player.gold then
        local itemList = {};
        for k, v in pairs( self.addItemList ) do
            if v > 0 then
                local data = { item_id = self.itemList[k].value.config.id, item_num = v };
                table.insert(itemList, data);
            end
        end
        if #itemList > 0 then
            msg_cards.cg_breakthrough( Socket.socketServer, self.breakthroughData.dataid, itemList, self.breakthroughData.stage );
        end
    elseif not (itemNumber > 0) then
        local text = "你需要添加突破材料";
        FloatTip.Float( text );
    elseif not (needGold <= g_dataCenter.player.gold) then
        local text = "你没有足够的金币升级";
        FloatTip.Float( text );
    end
end

function BreakThroughPreviewUI:init_wrapper_item(obj, b, realIndex)
    local row_index = math.abs( realIndex ) + 1;
    local childs = obj:get_childs();

    local itemGrid = self.itemGridList[b]
    if itemGrid == nil then
        itemGrid = {}
        for i = 1, _ColumnCount do
            local child = childs[i]
            local col_index = i;
            local data_index = (row_index - 1)*_ColumnCount + i;
            itemGrid[col_index] = {}
            itemGrid[col_index].obj = child
            itemGrid[col_index].index = data_index
            itemGrid[col_index].uiCard = UiSmallItem:new( { parent=child, prop={show_number=true, number_type=3} } )
            itemGrid[col_index].isShow = nil
        end
        self.itemGridList[b] = itemGrid
    end

    for i, item in pairs(itemGrid) do
        local itemData = self.itemList[item.index];
        if itemData then
            item.isShow = true
            item.obj:set_active(true)
            item.uiCard:SetData(itemData.value)
            item.uiCard:SetOnClicked(self.bindfunc["on_btn_item_click"], "", item.index)
            item.uiCard:SetExtraShine(self.selectIndex == item.index)

            self:UpdateSelectItemCount(item, self.addItemList[item.index])

            --设置滑动条
            if self.selectIndex == item.index then
                self.selectItem = item
                self:SetSliderBar(item.index)
            end
        else
            item.isShow = false
            item.obj:set_active(false)
        end
    end
end

function BreakThroughPreviewUI:SetSliderBar(index)
    local itemData = self.itemList[index]
    if itemData then
        local cellExp = itemData.value.config.breakthrough_exp
        local count = self.addItemList[index]
        local otherExp = self.total_break_exp - cellExp * count
        local needExp = self:CalcUpLvMaxNeedExp(otherExp)
        local maxCount = math.min(math.ceil(needExp / cellExp), itemData.value.count)
        local value = maxCount > 0 and (count / maxCount) or 0
        
        self.slider:set_steps(maxCount)
        self.slider:set_value(value)
        self.sliderSteps = maxCount
    end
end

function BreakThroughPreviewUI:GetItem(index)
    for k, v in pairs(self.itemGridList) do
        for kk, item in pairs(v) do
            if item.index == index then
                return item
            end
        end
    end
end

function BreakThroughPreviewUI:CalcTotalExp()
    local total_break_exp = 0
    for k, v in pairs(self.addItemList) do
        total_break_exp = total_break_exp + self.itemList[k].value.config.breakthrough_exp * v;
    end
    return total_break_exp
end

function BreakThroughPreviewUI:on_btn_item_clear(t)
    local index = t.float_value

    --更新拖动条
    self.slider:set_value(0)
end

function BreakThroughPreviewUI:on_btn_item_click(t)
    local index = t.float_value
    if self.selectIndex == index then return end

    self:SetSelectIndex(index)

    --更新选中项
    for k, v in pairs(self.itemGridList) do
        for kk, item in pairs(v) do
            if item.isShow then
                item.uiCard:SetExtraShine( item.index == index )
            end
        end
    end

    --设置滑动条
    self:SetSliderBar(index)
    self:UpdateBreakLvlDisp()
end

function BreakThroughPreviewUI:on_click_item_min(t)
    self.slider:set_value(0)
end

function BreakThroughPreviewUI:on_click_item_max(t)
    self.slider:set_value(1)
end

function BreakThroughPreviewUI:on_slider_value_change(value)
    if self.selectIndex == 0 then return end

    local count = PublicFunc.Round(value * self.sliderSteps)

    --更新关联数据
    self.addItemList[self.selectIndex] = count
    self.total_break_exp = self:CalcTotalExp()

    --更新经验进度
	self:UpdateBreakLvlDisp()
end

function BreakThroughPreviewUI:ClearItemGridList()
    for k, v in pairs( self.itemGridList ) do
        for kk, item in pairs( v ) do
            item.uiCard:DestroyUi()
        end
    end
    self.itemGridList = {}
end

function BreakThroughPreviewUI:UpdateSelectItemCount(item, count)
    if item then
        --已添加标识
        item.uiCard:SetCloseIcon(count>0)
        --已使用数量
        item.uiCard:SetNeedCount(count)
        --道具使用完变灰
        local totalCount = self.itemList[item.index].value.count
        item.uiCard:SetGray(totalCount <= count)
    end
end

function BreakThroughPreviewUI:UpdateBreakLvlDisp()
    if not self.ui then return end

    --右侧详细
    if self.selectIndex > 0 then
        self.labViewItemName:set_text(tostring(self.itemList[self.selectIndex].value.color_name))

        local addNum = self.addItemList[self.selectIndex]
        self.labViewAddNum:set_text(tostring(addNum))
        self.labViewAddExp:set_text("可提供经验："..tostring(self.itemList[self.selectIndex].value.config.breakthrough_exp * addNum))

        local needGold = self.total_break_exp * GOLD_SCALE;
        if needGold > g_dataCenter.player.gold then
            PublicFunc.SetUILabelRed(self.labViewGoldNum)
        else
            PublicFunc.SetUILabelWhite(self.labViewGoldNum)
        end
        self.labViewGoldNum:set_text(tostring(needGold))

        self.viewUiCard:SetData(self.itemList[self.selectIndex].value)
    end

    self.labCurLvl:set_text( tostring(self.breakthroughData.curStageData.lvl) );
    local curLvl = self.breakthroughData.curStageData.lvl
    local upLvl, upCurExp, isMaxLvl = self:CalculateUpLvlAndExp( self.total_break_exp );
    if not isMaxLvl then
        if upLvl > self.breakthroughData.curStageData.lvl then
            self.labNextLvl:set_active( true );
            self.spNextLvlArrow:set_active( true );
            self.labNextLvl:set_text( tostring( upLvl ) );
            self.progressBarExpPic:set_color(1,1,1,0.6)
            --self:play_Alpha()
            -- self.labanim:set_animated_loop("ui_602_12_1",true)
            -- self.labanim:animated_play("ui_602_12_1")
        else
            self.labNextLvl:set_active( false );
            self.spNextLvlArrow:set_active( false );
            self.progressBarExpPic:set_color(1,1,1,1)
            -- self.labanim:set_animated_loop("ui_602_12_1",false)
            -- self.labanim:animated_stop("ui_602_12_1")
        end
        --设置经验条了
        -- self.progressBarExp:set_active( true );
        -- self.progressBarExp2:set_active( true );
        local curConfigExp = self.breakthroughData.configStageData[curLvl][breakthrough_key.upgrade_exp];
        local upConfigExp = self.breakthroughData.configStageData[upLvl][breakthrough_key.upgrade_exp];
        self.labExpNum:set_text( tostring(upCurExp).."/"..tostring(curConfigExp));
        local progressValue = upCurExp / upConfigExp;
        local curExpProValue = self.breakthroughData.curStageData.exp / curConfigExp;
        if progressValue > 1 then
            progressValue = 1;
        end
        self.progressBarExp2:set_value(progressValue);
        self.progressBarExp:set_value(curExpProValue);
    else
        if upLvl > curLvl then
            self.labNextLvl:set_active( true );
            self.spNextLvlArrow:set_active( true );
            self.labNextLvl:set_text( tostring( upLvl ) );
            self.progressBarExpPic:set_color(1,1,1,0.6)
            --self:play_Alpha()
            -- self.labanim:set_animated_loop("ui_602_12_1",true)
            -- self.labanim:animated_play("ui_602_12_1")
        else
            self.labNextLvl:set_active( false );
            self.spNextLvlArrow:set_active( false );
            self.progressBarExpPic:set_color(1,1,1,1)
            -- self.labanim:set_animated_loop("ui_602_12_1",false)
            -- self.labanim:animated_stop("ui_602_12_1")
        end
        -- self.progressBarExp:set_active( false );
        -- self.progressBarExp2:set_active( false );
        self.labExpNum:set_text( "经验已满" );
    end
    
    --属性显示
    self:UpdateAttrInfoDisp(curLvl, upLvl);
    --选中道具项
    self:UpdateSelectItemCount(self.selectItem, self.addItemList[self.selectIndex])
end

-- function BreakThroughPreviewUI:checkLvlCanUpdate(exp)
--     local result = true;
--     local curLvl, realExp, isMaxLvl = self:CalculateUpLvlAndExp( exp );
--     if isMaxLvl and curLvl == self.breakthroughData.curStageData.lvl then
--         local text = "已达到该阶段的最高等级";
--         FloatTip.Float( text );
--         result = false;
--     elseif isMaxLvl and curLvl == #self.breakthroughData.configStageData then
--         local text = "已达到最高等级";
--         FloatTip.Float( text );
--         result = false;
--     --预升级操作当前角色等级
--     elseif curLvl > self.breakthroughData.roleLvl then
--         local text = "提升等级不能操过角色等级";
--         FloatTip.Float( text );
--         result = false;
--     --预升级限制英雄等级没有达到
--     elseif self.breakthroughData.roleLvl < self.breakthroughData.configStageData[curLvl][breakthrough_key.hero_level] then
--         local text = "当前角色等级不足,需要提升到"..self.breakthroughData.configStageData[curLvl][breakthrough_key.hero_level].."级";
--         FloatTip.Float( text );
--         result = false;
--     end
    
--     return result, isMaxLvl;
    
-- end

function BreakThroughPreviewUI:CalculateUpLvlAndExp( exp )
    local realExp = exp + self.breakthroughData.curStageData.exp;
    local curLvl = self.breakthroughData.curStageData.lvl;
    local isMaxLvl = false;
    if self.breakthroughData.configStageData[curLvl][breakthrough_key.upgrade_exp] == 0 then
        isMaxLvl = true;
    else
        if curLvl < #self.breakthroughData.configStageData then
            while realExp >=  self.breakthroughData.configStageData[curLvl][breakthrough_key.upgrade_exp] do
                realExp = realExp - self.breakthroughData.configStageData[curLvl][breakthrough_key.upgrade_exp];
                curLvl = curLvl + 1;
                if curLvl == #self.breakthroughData.configStageData then
                    isMaxLvl = true;
                    break;
                end
            end
        else
            isMaxLvl = true;
        end
    end
    
    return curLvl, realExp, isMaxLvl;
end

function BreakThroughPreviewUI:CalcUpLvMaxNeedExp(addedExp)
    addedExp = addedExp or 0
    local curExp = self.breakthroughData.curStageData.exp;
    local curLvl = self.breakthroughData.curStageData.lvl;
    local configStageData = self.breakthroughData.configStageData

    local needTotalExp = 0
    repeat
        needTotalExp = needTotalExp + configStageData[curLvl][breakthrough_key.upgrade_exp];
        curLvl = curLvl + 1;
        if curLvl > #configStageData then
            break;
        end
    until (configStageData[curLvl][breakthrough_key.upgrade_exp] == 0)
    
    return math.max(0, needTotalExp - curExp - addedExp)
end

function BreakThroughPreviewUI:UpdateAttrInfoDisp( curLevel, upLevel )
    upLevel = upLevel or curLevel
    local lvlData1 = self.breakthroughData.configStageData[curLevel];
    local lvlData2 = self.breakthroughData.configStageData[upLevel];
    local addAttrData1 = {};
    local addAttrData2 = {};
    
    for i = breakthrough_key.max_hp, breakthrough_key.parry_plus do
        if lvlData1[i] > 0 then
            table.insert( addAttrData1, {i, lvlData1[i]} );
            table.insert( addAttrData2, {i, lvlData2[i]} );
        end
    end

    for i = 1, 3 do
        if addAttrData1[i] then
            self.attrContList[i].obj:set_active(true)
            self.attrContList[i].name:set_text(gs_string_property_name[attr_name[addAttrData1[i][1]]])
            self.attrContList[i].val1:set_text(tostring(PublicFunc.AttrInteger(addAttrData1[i][2])))
            if curLevel < upLevel then
                self.attrContList[i].val2:set_text(tostring(PublicFunc.AttrInteger(addAttrData2[i][2])))
                self.attrContList[i].arrow:set_active(true)
            else
                self.attrContList[i].val2:set_text("")
                self.attrContList[i].arrow:set_active(false)
            end
        else
            self.attrContList[i].obj:set_active(false)
        end
    end
end

function BreakThroughPreviewUI:on_update_breakthrough( role_card_dataid, stage, cur_lvl, cur_exp, result )
    if result == 0 then
        return;
    end
    self:ClearItemGridList();
    self.itemList = {};
    self.addItemList = {};
    self.itemGridList = {};
    self.total_break_exp = 0;
    self.initItemData = false;
    
    if cur_lvl >  self.breakthroughData.curStageData.lvl then
        if self.fx then
            self.fx:set_active(false)
            -- self.fx:set_active(true) -- TODO 临时隐藏，特效资源不对
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.BreakThrough)
        end
    end
    
    self.breakthroughData.curStageData.exp = cur_exp;
    self.breakthroughData.curStageData.lvl = cur_lvl;
    self:getBreakThroughItemData();
    self:InitItemList();
    self:UpdateUi();
    self:UpdateBreakLvlDisp();
end


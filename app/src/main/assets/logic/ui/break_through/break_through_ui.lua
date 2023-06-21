--	file:	break_through_ui.lua
--	author: zzc
--	create: 2015-10-19
--
--fy:2016-7-13修改，突破界限功能重新制作

BreakThroughUI = Class("BreakThroughUI", UiBaseClass);

local _UIText = {
    [1] = "阶段一",
    [2] = "阶段二",
    [3] = "阶段三",
    [4] = "阶段四",
    [5] = "阶段五",
    [6] = "阶段六",
    
    ["need_qua"] = "需要升级到%s品质后激活",
}

local stage_bg =
{
    [1] = "baoweizhan2";
    [2] = "baoweizhan2";
    [3] = "baoweizhan2";
    [4] = "baoweizhan2";
    [5] = "baoweizhan2";
    [6] = "baoweizhan2";
};
breakthrough_key = {
	level=1,
	hero_level=2,
	upgrade_exp=3,
	max_hp=4,
	atk_power=5,
	def_power=6,
	crit_rate=7,
	anti_crite=8,
	crit_hurt=9,
	broken_rate=10,
	parry_rate=11,
	parry_plus=12,
	active_number=13,
};


--gs_string_property_name[ENUM.EHeroAttribute.max_hp]
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

function BreakThroughUI:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_12.assetbundle";
    UiBaseClass.Init( self, data );
end

function BreakThroughUI:InitData( data )
    UiBaseClass.InitData( self, data );
    self.parent = data.parent;
    self.roleData = data.info;
    self.curSelectStage = 1;
    self.objStageList = {};
    self.addInfoLabel = {};
    self.curStageLvl = 0;
    self.curStageExp = 0;
    self.allStageConfigData = {};
    self.allStageData = {};     -- {{stageLvl, stageExp}}
    local function sort_by_lvl(a , b)
        if a[breakthrough_key.level] < b[breakthrough_key.level] then
            return true;
        elseif a[breakthrough_key.level] > b[breakthrough_key.level] then
            return false;
        end
        return false;
    end
    --初始化配置数据,该角色所有阶段的突破数据
    local defaultNum = self.roleData.default_rarity;
    for i = 1, 6 do
        local stageData = ConfigHelper.GetBreakthroughStageConfig( defaultNum, i );
        self.allStageConfigData[i] = {};
        for k, v in pairs( stageData ) do
            local useData = {};
            for lvlKey, lvlData in pairs( v ) do
                if lvlKey == breakthrough_key.active_number then
                    local actStr = "";
                    for key, num in pairs( lvlData ) do
                        actStr = actStr..tostring(num)..";";
                    end
                    useData[lvlKey] = actStr;
                else
                    useData[lvlKey] = lvlData;
                end
            end
            if #useData > 0 then
                table.insert(self.allStageConfigData[i], useData );
            else
                table.insert(self.allStageConfigData[i], {});
            end
        end
        table.sort(self.allStageConfigData[i],sort_by_lvl);
    end
end

function BreakThroughUI:DestroyUi()
    UiBaseClass.DestroyUi( self );
end

function BreakThroughUI:Restart( data )
    UiBaseClass.Restart( self, data );
end

function BreakThroughUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_click_break_through"] = Utility.bind_callback( self, BreakThroughUI.on_click_break_through );
    self.bindfunc["on_select_stage"] = Utility.bind_callback( self, BreakThroughUI.on_select_stage );
    self.bindfunc["on_active_breakthrough"] = Utility.bind_callback( self, BreakThroughUI.on_active_breakthrough );
    self.bindfunc['on_update_breakthrough'] = Utility.bind_callback( self, BreakThroughUI.on_update_breakthrough );
end

function BreakThroughUI:MsgRegist()
    UiBaseClass.MsgRegist( self );
    --PublicFunc.msg_regist(msg_cards.gc_update_role_cards,self.bindfunc['on_active_breakthrough']);
    PublicFunc.msg_regist(msg_cards.gc_breakthrough,self.bindfunc['on_update_breakthrough']);
end

function BreakThroughUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist( self );
    --PublicFunc.msg_unregist(msg_cards.gc_update_role_cards,self.bindfunc['on_active_breakthrough']);
    PublicFunc.msg_unregist(msg_cards.gc_breakthrough,self.bindfunc['on_update_breakthrough']);
end

function BreakThroughUI:InitUI(obj)
    UiBaseClass.InitUI( self, obj );
    self.ui:set_name( "ui_break_through" );
    
    self.breakthroughBtn = ngui.find_button( self.ui, "centre_other/animation/sp_di/btn2" );
    self.breakthroughBtn:set_on_click( self.bindfunc["on_click_break_through"] );
    self.spMaxBreak = ngui.find_sprite(self.ui, "centre_other/animation/sp_di/sp_art_font")
    self.objToUnlock = self.ui:get_child_by_name("centre_other/animation/sp_di/cont")
    self.labUnlockQua = ngui.find_label(self.objToUnlock, "lab1")
    
    for i = 1, 6 do
        local objStage = self.ui:get_child_by_name( "centre_other/animation/content/frame"..i );
        local button = ngui.find_button( objStage, "btn1" );
	    local spStage = ngui.find_sprite( objStage, "btn1/sp_tu_biao" );
        local fxSelect = objStage:get_child_by_name("fx_ui_602_12_xuanze")
        button:set_on_click(self.bindfunc["on_select_stage"]);
        button:set_event_value( "SelectStage", i );
	    spStage:set_sprite_name( "tp_jieduan"..i );
        table.insert( self.objStageList, objStage );

        if i == 1 then
            self.select_texiao = fxSelect
            fxSelect:set_active(true)
        else
            fxSelect:set_active(false)
        end
    end
    
    self.labCurStage = ngui.find_label( self.ui, "centre_other/animation/sp_di/lab" );
    self.spCurStage = ngui.find_sprite( self.ui, "centre_other/animation/sp_di/sp" );

    self.labTextStage = ngui.find_label( self.ui, "centre_other/animation/sp_di/sp/lab_dengji" )
    self.labTextStage:set_text("") --隐藏

    for i = 1, 3 do
        local objAdd = self.ui:get_child_by_name("centre_other/animation/sp_di/nature_grid/cont"..i)
        local addTitle = ngui.find_label( objAdd, "txt" );
        local addNum1 = ngui.find_label( objAdd, "lab1" );
        local addNum2 = ngui.find_label( objAdd, "lab_num2" );
        local addArrow = ngui.find_sprite( objAdd, "sp_jian_tou" )
        table.insert( self.addInfoLabel, { title=addTitle, num1=addNum1, num2=addNum2, arrow=addArrow, obj=objAdd } );
    end 
    self.objLevel = self.ui:get_child_by_name("centre_other/animation/sp_di/sp_title")
    self.labLevel1 = ngui.find_label( self.objLevel, "lab_lab" );
    self.labLevel2 = ngui.find_label( self.objLevel, "lab_level2" );
    self.spLevelArrow = ngui.find_sprite( self.objLevel, "sp_arrows" );
    
    self:UpdateUi();
    
end

function BreakThroughUI:on_click_break_through( t )
    if self.allStageData[self.curSelectStage].lvl > 0 then
        data = {};
        data.stage = self.curSelectStage;
        data.curStageData = self.allStageData[self.curSelectStage];
        data.configStageData = self.allStageConfigData[self.curSelectStage];
        data.objParent = self;
        data.curStageTxt = _UIText[self.curSelectStage];
        data.roleLvl = self.roleData.level;
        data.dataid = self.roleData.index;
        data.defaultNumber = self.roleData.default_rarity;

        uiManager:PushUi(EUI.BreakThroughPreviewUI, data);
    else
        local cardInfo = self:GetUnlockCardInfo(self.curSelectStage, 1)
        local text = string.format(_UIText["need_qua"], PublicFunc.GetHeroRarityStr(cardInfo.real_rarity))
        FloatTip.Float( text );
    end
end

function BreakThroughUI:GetUnlockCardInfo(stage, level)
    local index1 = string.find( self.allStageConfigData[stage][level][breakthrough_key.active_number], ";" );
    local cardNumber = tonumber(string.sub( self.allStageConfigData[stage][level][breakthrough_key.active_number], 1, index1 - 1  ));
    return PublicFunc.IdToConfig(cardNumber);
end

function BreakThroughUI:UpdateUi()
    if not self.ui then return end

    --首先刷新数据项
    self:UpdateStageData();
    --是否解锁刷新,升级刷新
    self:UpdateAllStageDisp();
    
    --刷新当前选择的突破阶段进行信息显示
    self:UpdategeSelectStageDisp( self.curSelectStage );
end

--刷新当前选择的的阶段数据显示
function BreakThroughUI:UpdategeSelectStageDisp( stage )
    local lvl = math.max(1, self.allStageData[stage].lvl);
    local lvlData = self.allStageConfigData[stage][lvl];
    self.labCurStage:set_text( _UIText[stage] );
    self.spCurStage:set_sprite_name( "tp_jieduan"..tostring(stage) );

    local addAttrData = {};
    for i = breakthrough_key.max_hp, breakthrough_key.parry_plus do
        if #addAttrData < 4 and lvlData[i] > 0 then
            table.insert( addAttrData, {i, lvlData[i]} );
        end
    end

    for i = 1, 3 do
        self.addInfoLabel[i].obj:set_active(addAttrData[i] ~= nil)
    end
  
    --未解锁
    if self.allStageData[stage].lvl == 0 then
        self.objLevel:set_active(true)
        self.spMaxBreak:set_active( false );
        self.breakthroughBtn:set_active( false );
        self.objToUnlock:set_active( true );

        self.labLevel1:set_text(tostring(lvl))
        self.labLevel2:set_text("")
        self.spLevelArrow:set_active(false)

        for i, v in ipairs(addAttrData) do
            self.addInfoLabel[i].title:set_text(gs_string_property_name[attr_name[v[1]]]);
            self.addInfoLabel[i].num1:set_text(tostring(PublicFunc.AttrInteger(v[2])));
            self.addInfoLabel[i].num2:set_text("");
            self.addInfoLabel[i].arrow:set_active(false)
        end

        local cardInfo = self:GetUnlockCardInfo(stage, 1)
        local txt = PublicFunc.GetHeroRarityStr(cardInfo.real_rarity)
        self.labUnlockQua:set_text(txt)
    --max
    elseif self.allStageConfigData[stage][lvl][breakthrough_key.upgrade_exp] == 0 then
        self.objLevel:set_active(false)
        self.spMaxBreak:set_active( true );
        self.breakthroughBtn:set_active( false );
        self.objToUnlock:set_active( false );

        -- self.labLevel1:set_text("")
        -- self.labLevel2:set_text("")
        -- self.spLevelArrow:set_active(false)

        for i, v in ipairs(addAttrData) do
            self.addInfoLabel[i].title:set_text(gs_string_property_name[attr_name[v[1]]]);
            self.addInfoLabel[i].num1:set_text(tostring(PublicFunc.AttrInteger(v[2])));
            self.addInfoLabel[i].num2:set_text("");
            self.addInfoLabel[i].arrow:set_active(false)
        end
    --可升级
    else
        self.objLevel:set_active(true)
        self.spMaxBreak:set_active( false );
        self.breakthroughBtn:set_active( true );
        self.objToUnlock:set_active( false );

        self.labLevel1:set_text(tostring(lvl))
        self.labLevel2:set_text(tostring(lvl+1))
        self.spLevelArrow:set_active(true)

        local nextAddAttrData = {};
        local nextLvlData = self.allStageConfigData[stage][lvl+1];
        for i = breakthrough_key.max_hp, breakthrough_key.parry_plus do
            if #nextAddAttrData < 4 and nextLvlData[i] > 0 then
                table.insert( nextAddAttrData, nextLvlData[i] );
            end
        end

        for i, v in ipairs(addAttrData) do
            self.addInfoLabel[i].title:set_text(gs_string_property_name[attr_name[v[1]]]);
            self.addInfoLabel[i].num1:set_text(tostring(PublicFunc.AttrInteger(v[2])));
            self.addInfoLabel[i].num2:set_text(tostring(PublicFunc.AttrInteger(nextAddAttrData[i])));
            self.addInfoLabel[i].arrow:set_active(true)
        end
    end
end

--刷新所有的突破阶段的显示,加锁，解锁图标等等
function BreakThroughUI:UpdateAllStageDisp()
    for i = 1, 6 do
        local spLock = ngui.find_sprite( self.objStageList[i], "sp_weijiesuo" );
        local spMaxLevel = ngui.find_sprite(self.objStageList[i], "sp_manji")
        local labLevel = ngui.find_label( self.objStageList[i], "btn1/lab_dengji" );

        local lvl = self.allStageData[i].lvl
        --未解锁
        if lvl == 0 then
            spLock:set_active( true );
            spMaxLevel:set_active( false );
            labLevel:set_text( "" );
        --max
        elseif self.allStageConfigData[self.curSelectStage][lvl][breakthrough_key.upgrade_exp] == 0 then
            spLock:set_active( false );
            spMaxLevel:set_active( true );
            labLevel:set_text( "" );
        --可升级
        else
            spLock:set_active( false );
            spMaxLevel:set_active( false );
            labLevel:set_text("等级 "..lvl)
        end
    end    
end

function BreakThroughUI:on_select_stage( t )
	self.curSelectStage = t.float_value;
	
	if self.allStageData[self.curSelectStage].lvl > 0 then
	
	    self:UpdateUi();
	    
	    local x,y,z = self.objStageList[self.curSelectStage]:get_position()
	    self.select_texiao:set_position(x,y,z)
	else
        local cardInfo = self:GetUnlockCardInfo(self.curSelectStage, 1)
        local text = string.format(_UIText["need_qua"], PublicFunc.GetHeroRarityStr(cardInfo.real_rarity))
	    FloatTip.Float( text );
	    
	    self:UpdateUi();
	    
	    local x,y,z = self.objStageList[self.curSelectStage]:get_position()
	    self.select_texiao:set_position(x,y,z)
	end
end


--判断是否能点击选择
function BreakThroughUI:checkCanSelectStage( stage )
    local result = false;
    if self.allStageData[stage].lvl > 0 then
        result = true;
    end
    
    return result;
end

function BreakThroughUI:UpdateStageData()
    for i = 1, 6 do
        local data = {}
        data.lvl = self.roleData["breakthrough"..i.."_level"]
        data.exp = self.roleData["breakthrough"..i.."_cur_exp"]
        self.allStageData[i] = data
    end
end

--激活突破的回调
function BreakThroughUI:on_active_breakthrough( card_info )
    self.roleData = card_info;
    self.curSelectStage = 1;
    self.allStageConfigData = {};
    self.allStageData = {};     -- {{stageLvl, stageExp}}
    
    --初始化配置数据,该角色所有阶段的突破数据
    local defaultNum = CardHuman.GetDefaultRarityNumber(self.roleData.number);
    for i = 1, 6 do
        local stageData = ConfigHelper.GetBreakthroughStageConfig( defaultNum, i );
        self.allStageConfigData[i] = {};
        for k, v in pairs( stageData ) do
            local useData = {};
            for lvlKey, lvlData in pairs( v ) do
                if lvlKey == breakthrough_key.active_number then
                    local actStr = "";
                    for key, num in ipairs( lvlData ) do
                        actStr = actStr..tostring(num)..";";
                    end
                    useData[lvlKey] = actStr;
                else
                    useData[lvlKey] = lvlData;
                end
            end
            if #useData > 0 then
                table.insert(self.allStageConfigData[i], useData );
            else
                table.insert(self.allStageConfigData[i], {});
            end
        end
    end

    self:UpdateUi();
end

function BreakThroughUI:updateBreakthroughData( number, stage, cur_lvl, cur_exp )
    if self.roleData.number == number and self.curSelectStage == stage then

        self.roleData["breakthrough"..stage.."_level"] = cur_lvl
        self.roleData["breakthrough"..stage.."_cur_exp"] = cur_exp

        self:UpdateUi();
    end
end

function BreakThroughUI:on_update_breakthrough( role_card_dataid, stage, cur_lvl, cur_exp, result )
    if result == 0 then
        return;
    end
    
    if self.roleData.index == role_card_dataid and self.curSelectStage == stage then

        self.roleData["breakthrough"..stage.."_level"] = cur_lvl
        self.roleData["breakthrough"..stage.."_cur_exp"] = cur_exp

        self:UpdateUi();
    end
end

function BreakThroughUI:Show(roleData)
    
    if UiBaseClass.Show(self) then
        self.roleData = roleData;
        --self.curSelectStage = 1;
        self:SetInfo(self.roleData)
    end
end


function BreakThroughUI:SetInfo(roleData)
    if roleData then
    
    if self.roleData and self.roleData == roleData then
	do return end
    end
    
    self.roleData = roleData;
    self.curSelectStage = 1;
    self.curStageLvl = 0;
    self.curStageExp = 0;
    self.allStageConfigData = {};
    self.allStageData = {};     -- {{stageLvl, stageExp}}
    
    local function sort_by_lvl(a , b)
        if a[breakthrough_key.level] < b[breakthrough_key.level] then
            return true;
        elseif a[breakthrough_key.level] > b[breakthrough_key.level] then
            return false;
        end
        return false;
    end
    --初始化配置数据,该角色所有阶段的突破数据
    local defaultNum = self.roleData.default_rarity;

    for i = 1, 6 do
        local stageData = ConfigHelper.GetBreakthroughStageConfig( defaultNum, i );
        self.allStageConfigData[i] = {};
        for k, v in pairs( stageData ) do
            local useData = {};
            for lvlKey, lvlData in pairs( v ) do
                if lvlKey == breakthrough_key.active_number then
                    local actStr = "";
                    for key, num in pairs( lvlData ) do
                        actStr = actStr..tostring(num)..";";
                    end
                        useData[lvlKey] = actStr;
                    else
                        useData[lvlKey] = lvlData;
                    end
                end
                if #useData > 0 then
                    table.insert(self.allStageConfigData[i], useData );
                else
                    table.insert(self.allStageConfigData[i], {});
                end
	        end
            table.sort(self.allStageConfigData[i],sort_by_lvl);
        end
	    self:UpdateUi();
    end
    local x,y,z = self.objStageList[self.curSelectStage]:get_position()
    self.select_texiao:set_position(x,y,z)
end
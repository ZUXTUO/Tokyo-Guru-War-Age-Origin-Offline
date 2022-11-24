
Trainningheroinfo = Class("Trainningheroinfo", UiBaseClass)


function Trainningheroinfo:Init(data)
    self.Trainningheroinfo = data
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4607_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function Trainningheroinfo:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function Trainningheroinfo:InitData(data)
    
    self.currentroleinfo = g_dataCenter.trainning:get_selectroleinfo()
    UiBaseClass.InitData(self, data)
    
    
end

function Trainningheroinfo:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainningheroinfo:DestroyUi()
    self.currentroleinfo = nil;
    UiBaseClass.DestroyUi(self);

end

function Trainningheroinfo:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_close_wnd'] = Utility.bind_callback(self, self.on_close_wnd);
end


--注册消息分发回调函数
function Trainningheroinfo:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function Trainningheroinfo:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function Trainningheroinfo:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('Trainningheroinfo');
    self.closebtn = ngui.find_button(self.ui,"center_other/animation/content_di_754_458/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_close_wnd'])
    self.uisername = ngui.find_label(self.ui,"center_other/animation/labtips")
    self.lvlname = ngui.find_label(self.ui,"center_other/animation/lab_name")
    self.righttext = ngui.find_label(self.ui,"center_other/animation/lab_text1")
    self.righttextvalue = ngui.find_label(self.ui,"center_other/animation/lab_text1/lab_num")
    self.lefttext = ngui.find_label(self.ui,"center_other/animation/lab_text2")
    self.lefttextvalue = ngui.find_label(self.ui,"center_other/animation/lab_text2/lab_num")
    
    --self.infodi = ngui.find_sprite(self.ui,"center_other/animation/lab_name/sp_name_bg1")
    self.infodi1 = ngui.find_sprite(self.ui,"center_other/animation/lab_name/sp_name_bg")
    
    -- self.bglist = {}
    -- for i=1,10 do
    --     self.bglist[i] = ngui.find_sprite(self.ui,"center_other/animation/cont_bar/sp_bar"..i)
    --     if i == 10 then
    --         self.bglist[i]:set_active(false)
    --     end
    -- end
    
    self:setData()
end

function Trainningheroinfo:on_close_wnd()
    uiManager:PopUi()
end

function Trainningheroinfo:setTitleDiColour(lvl)
    
    
    --Green =  { r=76/255,g=164/255,b=2/255,a=1},     --4ca402
    --Blue =  { r=5/255,g=98/255,b=176/255,a=1},      --0562b0
    --Purple = { r=163/255,g=0/255,b=187/255,a=1},    --a300bb
    --Red = { r=197/255,g=2/255,b=62/255,a=1},        --c5023e
    --Orange = { r=225/255,g=65/255,b=3/255,a=1},     --e14103
   
     local colorStr = ""

    if lvl == 0 then
        colorStr = "xlc_ditiao_lv"--{ r=76/255,g=164/255,b=2/255,a=1}
    elseif lvl == 1 then
        colorStr = "xlc_ditiao_lan"--{ r=5/255,g=98/255,b=176/255,a=1}
    elseif lvl == 2 then
        colorStr = "xlc_ditiao_zi"--{ r=163/255,g=0/255,b=187/255,a=1}
    elseif lvl == 3 then
        colorStr = "xlc_ditiao_hong"--{ r=197/255,g=2/255,b=62/255,a=1}   
    elseif lvl == 4 then
        colorStr  = "xlc_ditiao_huang"--{ r=225/255,g=65/255,b=3/255,a=1} 
    end
    

    --self.infodi:set_color(colorStr.r, colorStr.g, colorStr.b, colorStr.a)
    self.infodi1:set_sprite_name(colorStr)
end

function Trainningheroinfo:setData()
    
    if self.currentroleinfo == nil then
	self.currentroleinfo = g_dataCenter.trainning:get_selectroleinfo()
    end
    
    local playername = self.currentroleinfo.name
    --app.log("#############playername########"..tostring(playername))
    --local head = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.max_hp])
    --local power = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.atk_power])
    --local def = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.def_power])
    --local rate = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.crit_rate])
    --local anti_crite = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.anti_crite])
    --local crit_hurt = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.crit_hurt])
    --local broken_rate = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.broken_rate])
    --local parry_rate = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.parry_rate])
    --local parry_plus = math.floor(self.currentroleinfo.property[ENUM.EHeroAttribute.parry_plus])
    
    --app.log("cardinfo###############"..table.tostring(self.currentroleinfo))
    self.uisername:set_text(playername)

    self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
    
    local roleid = self.currentroleinfo.default_rarity
        
    for k,v in pairs( self.AllHerolist )do
	for kk,vv in pairs(v)do
            if vv[2] == roleid then
                self.currentline = k; --行
                self.currentindex = kk; -- 列
            end
        end    
    end    
    
    local currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]
        
    local currentNeedexpdata = currentNeedexp.att_lv
    
    local index = self.currentroleinfo.trainingHallLevel
    local pzname = "t_"..currentNeedexpdata
    --app.log("pzname#########"..pzname)     
    local expdata = ConfigManager.Get(EConfigIndex[pzname],index);
    --app.log("expdata#########"..table.tostring(expdata))            
    local lvl = ConfigManager.Get(EConfigIndex[pzname],index).adv_level;
    
    local groupdataname = "t_training_hall_grouping_adv_prop_"..tostring(self.currentline)
    local grouplvl = g_dataCenter.trainning:get_Battleforgroup(self.currentline)
    local groupdat = ConfigManager.Get(EConfigIndex[groupdataname],grouplvl);
    --app.log("groupdat##############"..table.tostring(groupdat))
    
    local head = 0
    local power = 0
    local def = 0
    local rate = 0
    local anti_crite = 0
    local crit_hurt = 0
    local broken_rate = 0
    local parry_rate = 0
    local parry_plus = 0
    
    local titlelvl = "t_"..currentNeedexp.att_adv
    local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
    --app.log("titledata#########"..table.tostring(titledata))        
    self.lvlname:set_text(titledata.adv_name)
    self:setTitleDiColour(lvl)
    --app.log("expdata.add_hp#############"..tostring(expdata.add_hp))

    head = PublicFunc.AttrInteger(expdata.add_hp + groupdat.add_hp)
    power =  PublicFunc.AttrInteger(expdata.atk_power + groupdat.atk_power)
    def =  PublicFunc.AttrInteger(expdata.def_power + groupdat.def_power)
    rate =  PublicFunc.AttrInteger(titledata.crit_rate + groupdat.crit_rate)
    anti_crite =  PublicFunc.AttrInteger(titledata.anti_crite + groupdat.anti_crite)
    crit_hurt =  PublicFunc.AttrInteger(titledata.crit_hurt + groupdat.crit_hurt)
    broken_rate =  PublicFunc.AttrInteger(titledata.broken_rate + groupdat.broken_rate)
    parry_rate = PublicFunc.AttrInteger( titledata.parry_rate + groupdat.parry_rate)
    parry_plus = PublicFunc.AttrInteger(titledata.parry_plus + groupdat.parry_plus)
    
    self.righttext:set_text("生命".."\n".."攻击".."\n".."防御".."\n".."暴击属性".."\n".."暴伤加成")
    self.righttextvalue:set_text(tostring(head).."\n"..tostring(power).."\n"..tostring(def).."\n"..tostring(rate).."\n"..tostring(crit_hurt))
    self.lefttext:set_text("免爆属性".."\n".."破击属性".."\n".."格挡属性".."\n".."格挡伤害")
    self.lefttextvalue:set_text(tostring(anti_crite).."\n"..tostring(broken_rate).."\n"..tostring(parry_rate).."\n"..tostring(parry_plus))
end





Trainningbattleinfo = Class("Trainningbattleinfo", UiBaseClass)


function Trainningbattleinfo:Init(data)
    self.Trainningbattleinfo = data
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4608_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function Trainningbattleinfo:Restart(data)

    if UiBaseClass.Restart(self, data) then
	--self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
	self.currentindex = 1;
	self.Theroheadlist = {};
	self:initDataShuxinglvl()
    end
end

function Trainningbattleinfo:InitData(data)
    UiBaseClass.InitData(self, data)
    self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
    self.currentindex = 1;
    self.Theroheadlist = {};
    self:initDataShuxinglvl()
end

function Trainningbattleinfo:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainningbattleinfo:DestroyUi()
    
    for k,v in pairs( self.Theroheadlist )do
	v:DestroyUi()    
    end
    
    UiBaseClass.DestroyUi(self);

end

function Trainningbattleinfo:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['on_toggle_change'] = Utility.bind_callback(self, self.on_toggle_change);
    self.bindfunc['on_close_wnd'] = Utility.bind_callback(self, self.on_close_wnd);
    self.bindfunc['init_shuxing_wrap_content'] = Utility.bind_callback(self, self.init_shuxing_wrap_content);
    self.bindfunc['on_click_uplvl_button'] = Utility.bind_callback(self, self.on_click_uplvl_button);
    self.bindfunc['upheroinfo'] = Utility.bind_callback(self, self.upheroinfo);
    self.bindfunc["on_click_ye"] = Utility.bind_callback(self,self.on_click_ye);
end


--注册消息分发回调函数
function Trainningbattleinfo:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_training_group_advance, self.bindfunc["upheroinfo"])
    
end

--注销消息分发回调函数
function Trainningbattleinfo:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_training_group_advance, self.bindfunc["upheroinfo"])
end


--初始化UI
function Trainningbattleinfo:InitUI(asset_obj)
    --app.log("###################################")
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('Trainningbattleinfo');
    
    self.closebtn = ngui.find_button(self.ui,"center_other/animation/content_di_1004_564/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_close_wnd'])
    
    self.btn = {};
    self.btntxt = {};
    self.btntxt_gray = {}
    self.btnpoit = {}
    self.btn[1] = ngui.find_toggle(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka1");
    self.btn[1]:set_on_change(self.bindfunc["on_toggle_change"])
    self.btn[1]:set_value(true)
    self.btntxt[1] = ngui.find_label(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka1/lab")
    self.btntxt_gray[1] = ngui.find_label(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka1/lab_hui")
    self.btnpoit[1] = ngui.find_sprite(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka1/sp_point")
    
    for i =2 ,8 do
    	self.btn[i] = self.btn[1]:clone()
    	self.btn[i]:set_name("yeka"..i)
    	self.btntxt[i] = ngui.find_label(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka"..i.."/lab")
        self.btntxt_gray[i] = ngui.find_label(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka"..i.."/lab_hui")
        self.btnpoit[i] = ngui.find_sprite(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka"..i.."/sp_point")
    	self.btn[i]:set_on_change(self.bindfunc["on_toggle_change"])
    	self.btn[i]:set_value(false)
    end
    
    self.herolistview = ngui.find_wrap_content(self.ui,"center_other/animation/sp_di/icon_scroll_view/panel_list/wrap_content");
    self.herolistview:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    self.scroll_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/icon_scroll_view/panel_list");
    
    self.battlelvl = ngui.find_label(self.ui,"center_other/animation/sp_di/sp_bg1/lab_level")
    
    --self.shuxinlist = ngui.find_wrap_content(self.ui,"center_other/animation/sp_di/sp_tips/info_scroll_view/panel_list/wrap_content")
    --self.shuxinlist:set_on_initialize_item(self.bindfunc['init_shuxing_wrap_content']);
    --self.scrolist_view = ngui.find_scroll_view(self.ui, "center_other/animation/sp_di/sp_tips/info_scroll_view/panel_list");
    
    self.btn_sound = {}
    for i=1,8 do
        self.btn_sound[i] = ngui.find_button(self.ui,"center_other/animation/sp_di/sco_view/panel/grid/yeka"..i)
        self.btn_sound[i]:set_on_click(self.bindfunc["on_click_ye"],"MyButton.Flag")
    end


    self.shuxinname = {}
    self.shuxinvalue = {}
    self.shuxinysvalue = {}
    
    for i=1 ,3 do
	self.shuxinname[i] = ngui.find_label(self.ui,"center_other/animation/sp_di/cont/txt"..i)
	self.shuxinysvalue[i] = ngui.find_label(self.ui,"center_other/animation/sp_di/cont/txt"..i.."/lab_num")
	self.shuxinvalue[i] = ngui.find_label(self.ui,"center_other/animation/sp_di/cont/txt"..i.."/lab")
    end
    
    self.uplvlbtn = ngui.find_button(self.ui,"center_other/animation/sp_di/btn")
    self.uplvlbtn:set_on_click(self.bindfunc['on_click_uplvl_button']);
    
    self.uplvlbtnsp = ngui.find_sprite(self.ui,"center_other/animation/sp_di/btn/animation/sp")
    self.uplvlbtntxt = ngui.find_label(self.ui,"center_other/animation/sp_di/btn/animation/lab")
    
    self.titleinfotxt = ngui.find_label(self.ui,"center_other/animation/sp_di/cont/lab_tips")
    self.battleTeamName = ngui.find_label(self.ui,"center_other/animation/sp_di/sp_bg1/lab1")

    self.upbtnpoit = ngui.find_sprite(self.ui,"center_other/animation/sp_di/btn/animation/sp_point")
    
    self:setBtnData()

    self:setPoit()
    self:rushlist()
    self:setBattleLvl()
    self:rushuplist()
    
    self:setshuxin()
end

function Trainningbattleinfo:setshuxin()
    
    --app.log("data #####################"..table.tostring(self.upshuxingList))
    for k,v in pairs(self.upshuxingList)do
	--app.log("v##############"..table.tostring(v))
	self.shuxinname[k]:set_text(v[1]..":")
	self.shuxinysvalue[k]:set_text(tostring(PublicFunc.AttrInteger(v[2])))
	self.shuxinvalue[k]:set_text(tostring(PublicFunc.AttrInteger(v[3])))
    end
    
end


function Trainningbattleinfo:on_click_ye()

end

function Trainningbattleinfo:init_item_wrap_content(obj,b,real_id)
    local item = obj:get_child_by_name("new_small_card_item")
    local jdTiao = ngui.find_progress_bar(obj,"progress_bar")
    local jdTiaoText = ngui.find_label(obj,"progress_bar/lab_word")
    
    local index = math.abs(real_id)+1;
    local data = self.AllHerolist[self.currentindex][index]
    
    local role = CardHuman:new({number=data[2], isNotCalProperty = true});
    local dataid = self:isHaveHero(data[2])
    
    local battleLvl = g_dataCenter.trainning:get_BattleLvl()[self.currentindex]
    
    if not self.Theroheadlist[b] then
	--app.log("battleLvl################"..table.tostring(battleLvl))
        if dataid ~= "" then
            local cardinfo = g_dataCenter.package:find_card(1, dataid);
	    --app.log("cardinfo #############"..tostring(cardinfo.trainingHallLevel))
            if cardinfo then
                local TheroHead = SmallCardUi:new({parent=item ,info=cardinfo,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
                TheroHead:SetParam(b);
                TheroHead:SetGray(false)
                --TheroHead:SetCallback(self.bindfunc['on_select_role']);
                self.Theroheadlist[b] = TheroHead;	
            end
	    	    
    	    local lvl = self:computLvl(dataid)
    	    --app.log("battleLvl###############"..table.tostring(battleLvl))
    	    local maxlvl = battleLvl.low + 1

            local adv_pro = "t_".."training_hall_grouping_adv_prop_"..tostring(self.currentindex)
            local adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
            local next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],nextbattlelvl);
            if next_adv_data == nil then
                maxlvl = battleLvl.low + 1
            end
            jdTiao:set_active(true)
    	    jdTiao:set_value(lvl/maxlvl)
    	    jdTiaoText:set_text(tostring(lvl).."/"..tostring(maxlvl))
        else
            local TheroHead = SmallCardUi:new({parent=item ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
            TheroHead:SetParam(b);
            TheroHead:SetGray(true)
            --TheroHead:SetCallback(self.bindfunc['on_select_role']);
            self.Theroheadlist[b] = TheroHead;
    	    local maxlvl = battleLvl.low
            jdTiao:set_active(false)
    	    jdTiao:set_value(0)
    	    --jdTiaoText:set_text("0/"..tostring(maxlvl))
    	    jdTiaoText:set_text("0/1")
        end
    else        
        if dataid ~= "" then
            local cardinfo = g_dataCenter.package:find_card(1, dataid);
            self.Theroheadlist[b]:SetData(cardinfo)
    	    self.Theroheadlist[b]:SetGray(false)
    	    local lvl = self:computLvl(dataid)
    	    local maxlvl = battleLvl.low + 1
    	    --app.log("lvl##############"..tostring(lvl))
    	    --app.log("maxlvl##############"..tostring(maxlvl))

            local adv_pro = "t_".."training_hall_grouping_adv_prop_"..tostring(self.currentindex)
            local adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
            local next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],nextbattlelvl);
            if next_adv_data == nil then
                maxlvl = battleLvl.low + 1
            end
            jdTiao:set_active(true)
    	    jdTiao:set_value(lvl/maxlvl)
    	    jdTiaoText:set_text(tostring(lvl).."/"..tostring(maxlvl))
        else
            local role = CardHuman:new({number=data[2], isNotCalProperty = true});
            self.Theroheadlist[b]:SetData(role)
    	    self.Theroheadlist[b]:SetGray(true)
    	    local maxlvl = battleLvl.low
    	    --app.log("index############"..tostring(index)..table.tostring(battleLvl[index]))
    	    jdTiao:set_value(0)
            jdTiao:set_active(false)
    	    --jdTiaoText:set_text("0/"..tostring(maxlvl))
    	    jdTiaoText:set_text("0/1")
        end
    end
    
    
    --self:setJdTiao(jdTiao,dataid)
     
end

function Trainningbattleinfo:computLvl(dataid)
    
    local cardinfo = g_dataCenter.package:find_card(1, dataid);
    local lvlindex = cardinfo.trainingHallLevel
    --self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);

    local roleid = cardinfo.default_rarity
	
    for k,v in pairs( self.AllHerolist )do
	for kk,vv in pairs(v)do
	    if vv[2] == roleid then
		self.currentline = k; --行
		self.currentlinex = kk; -- 列
	    end
	end    
    end    
    
    local currentNeedexp = self.AllHerolist[self.currentline][self.currentlinex]
	
    local currentNeedexpdata = currentNeedexp.att_lv
    
    --local index = cardinfo.trainingHallLevel
    local pzname = "t_"..currentNeedexpdata
	
    local expdata = ConfigManager.Get(EConfigIndex[pzname],lvlindex);
	
    local lvl = ConfigManager.Get(EConfigIndex[pzname],lvlindex).adv_level;
    
    return lvl

	
end

function Trainningbattleinfo:isHaveHero(id)
    
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local dataid = "";
    for k,v in pairs(haveherolist)do
	if v.default_rarity == id then
	    dataid = v.index
	end
    end
    
    return dataid
end

function Trainningbattleinfo:on_toggle_change(value,name)
    
    if name == "yeka1" and value == true then
	self.currentindex = 1;	
    elseif name == "yeka2" and value == true then
	self.currentindex = 2;	
    elseif name == "yeka3" and value == true then
	self.currentindex = 3;
    elseif name == "yeka4" and value == true then
	self.currentindex = 4;
    elseif name == "yeka5" and value == true then
	self.currentindex = 5;
    elseif name == "yeka6" and value == true then
	self.currentindex = 6;
    elseif name == "yeka7" and value == true then
	self.currentindex = 7;
    elseif name == "yeka8" and value == true then
	self.currentindex = 8;
    end
    
    --app.log("value #######"..tostring(value).." name ##########"..name.." index #################"..tostring(self.currentindex))
    self:initDataShuxinglvl()
   
    self:rushlist()
    --self:rushUpShuxing()
    self:rushuplist()
    self:setBattleLvl()
    self:setUpBtn()
    self:setshuxin()
end

function Trainningbattleinfo:setPoit()
    for i=1,8 do
        local flag = g_dataCenter.trainning:computbattle(i)
        --app.log("index ---------------"..tostring(i).."  flag ================="..tostring(flag))
        if flag then
            self.btnpoit[i]:set_active(true)
        else
            self.btnpoit[i]:set_active(false)
        end
    end
end

function Trainningbattleinfo:setUpBtn()
    --app.log("########currentindex   "..tostring(self.currentindex))    
    local data = self.AllHerolist[self.currentindex]
    local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentindex]
    local maxlvl = battledata.low
    
    local flag = true;
    
    for k,v in pairs(data) do
	local dataid = self:isHaveHero(v.heroid)
	if dataid ~= "" then
	    local lvl = self:computLvl(dataid)
	    if lvl <= maxlvl then
		flag = false
		break;
	    end
	else
	    flag = false;
	    break;
	end
    end
    
    --app.log("flag #############"..tostring(flag))
    
    if flag then
    	self.uplvlbtn:set_enable(true)
    	self.uplvlbtnsp:set_sprite_name("ty_anniu3")
        self.uplvlbtntxt:set_color(151/255,57/255,0/255,255/255)
        --app.log("11111111111111111111111111111111111")
        self.upbtnpoit:set_active(true)
    else
    	self.uplvlbtn:set_enable(false)
    	self.uplvlbtnsp:set_sprite_name("ty_anniu5")
    	self.uplvlbtntxt:set_color(255/255,255/255,255/255,255/255)
        --app.log("222222222222222222222222222222222222")
        self.upbtnpoit:set_active(false)
    end
    
end

function Trainningbattleinfo:rushlist()
    --app.log("self.currentindex#############"..tostring(self.currentindex))
    local cnt = #self.AllHerolist[self.currentindex];
    self.herolistview:set_min_index(0);
    self.herolistview:set_max_index(cnt-1);
    self.herolistview:reset();
    self.scroll_view:reset_position(); 
end


function Trainningbattleinfo:rushuplist()
    do return end
    local cnt = #self.upshuxingList;
    self.shuxinlist:set_min_index(0);
    self.shuxinlist:set_max_index(cnt-1);
    self.shuxinlist:reset();
    self.scrolist_view:reset_position(); 
end


function Trainningbattleinfo:setBtnData()
    local titedata = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping_name);--ConfigManager.Get(EConfigIndex.t_training_hall_grouping_name,index).group_name
    for k,v in pairs(titedata)do
	if self.btntxt[k] then
	   self.btntxt[k]:set_text(v.group_name)
       self.btntxt_gray[k]:set_text(v.group_name)
	   --self.btn[k]:set_active(true)
	end
	
    end
end

function Trainningbattleinfo:setBattleLvl()
    local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentindex]
    local battleLvl = battledata.low

    local nextbattlelvl = battleLvl + 1
    
    local adv_pro = "t_".."training_hall_grouping_adv_prop_"..tostring(self.currentindex)
    local adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
    local next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],nextbattlelvl);

    if next_adv_data == nil then
        self.battlelvl:set_text("等级 [FDE517FF]"..tostring(battleLvl).."[-]")
        self.titleinfotxt:set_text("已提升到最高等级！")
    else

        self.battlelvl:set_text("等级 [FDE517FF]"..tostring(battleLvl).."[-]")
        self.titleinfotxt:set_text("队伍中所有的角色都进阶"..tostring(battleLvl + 1).."次可提升：")
    end
    
   local titedata = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping_name)
    self.battleTeamName:set_text(titedata[self.currentindex].group_name)
end

function Trainningbattleinfo:init_shuxing_wrap_content(obj,b,real_id)
    --app.log("upshuxingList#########"..table.tostring(self.upshuxingList))
    --app.log(" ##########"..tostring(self.currentindex))
    local index = math.abs(real_id)+1;
    local text1 = ngui.find_label(obj,"lab1")
    local text2 = ngui.find_label(obj,"lab2")
    text1:set_text(self.upshuxingList[index][1]..tostring(PublicFunc.AttrInteger(self.upshuxingList[index][2])))
    text2:set_text(tostring(PublicFunc.AttrInteger(self.upshuxingList[index][3])))
end

function Trainningbattleinfo:rushUpShuxing()
    do return end
    local cnt = 0;
    self.shuxinlist:set_min_index(0);
    self.shuxinlist:set_max_index(cnt-1);
    self.shuxinlist:reset();
    self.scrolist_view:reset_position(); 
end

--初始化属性提升
function Trainningbattleinfo:initDataShuxinglvl()
    
    self.upshuxingList = {};
    
    local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentindex]
    --app.log("battledata###########"..tostring(battledata.low))
    local battleLvl = battledata.low
    local nextbattlelvl = battleLvl + 1
    
    local adv_pro = "t_".."training_hall_grouping_adv_prop_"..tostring(self.currentindex)
    local adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
    local next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],nextbattlelvl);
    
    --app.log("next_adv_data==========="..table.tostring(next_adv_data).."nextbattlelvl====="..tostring(nextbattlelvl))
    if next_adv_data == nil then
        --app.log("next_adv_data == nil ###########")
        next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
        --nextbattlelvl = battleLvl
        local add_hp = adv_data.add_hp
        local next_add_hp = next_adv_data.add_hp
        
        if next_add_hp > 0 then
        local tit = {"生命",add_hp,next_add_hp}
        table.insert(self.upshuxingList,tit)
        end
            
        local atk_power = adv_data.atk_power
        local next_atk_power = next_adv_data.atk_power
        
        if next_atk_power > 0 then
        local tit = {"攻击",atk_power,next_atk_power}
        table.insert(self.upshuxingList,tit)
        end
        
        local def_power = adv_data.def_power
        local next_def_power = next_adv_data.def_power
        
         if next_def_power > 0 then
        local tit = {"防御",def_power,next_def_power}
        table.insert(self.upshuxingList,tit)
        end
        
        local crit_rate = adv_data.crit_rate
        local next_crit_rate = next_adv_data.crit_rate
        
         if next_crit_rate > 0 then
        local tit = {"暴击率",crit_rate,next_crit_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local anti_crite = adv_data.anti_crite
        local next_anti_crite = next_adv_data.anti_crite
        
         if next_anti_crite > 0 then
        local tit = {"免爆率",anti_crite,next_anti_crite}
        table.insert(self.upshuxingList,tit)
        end
        
        local crit_hurt = adv_data.crit_hurt
        local next_crit_hurt = next_adv_data.crit_hurt
        
         if next_crit_hurt > 0 then
        local tit = {"暴击伤害加成",crit_hurt,next_crit_hurt}
        table.insert(self.upshuxingList,tit)
        end
        
        local broken_rate = adv_data.broken_rate
        local next_broken_rate = next_adv_data.broken_rate
        
         if next_broken_rate > 0 then
        local tit = {"破击率",broken_rate,next_broken_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local parry_rate = adv_data.parry_rate
        local next_parry_rate = next_adv_data.parry_rate
        
         if next_parry_rate > 0 then
        local tit = {"格挡率",parry_rate,next_parry_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local parry_plus = adv_data.parry_plus
        local next_parry_plus = next_adv_data.parry_plus
        
         if next_parry_plus > 0 then
        local tit = {"格挡伤害加成",parry_plus,next_parry_plus}
        table.insert(self.upshuxingList,tit)
        end


    else

        local add_hp = adv_data.add_hp
        local next_add_hp = next_adv_data.add_hp
        
        if add_hp ~= next_add_hp then
    	local tit = {"生命",add_hp,next_add_hp}
    	table.insert(self.upshuxingList,tit)
        end
            
        local atk_power = adv_data.atk_power
        local next_atk_power = next_adv_data.atk_power
        
        if atk_power ~= next_atk_power then
    	local tit = {"攻击",atk_power,next_atk_power}
    	table.insert(self.upshuxingList,tit)
        end
        
        local def_power = adv_data.def_power
        local next_def_power = next_adv_data.def_power
        
         if def_power ~= next_def_power then
    	local tit = {"防御",def_power,next_def_power}
    	table.insert(self.upshuxingList,tit)
        end
        
        local crit_rate = adv_data.crit_rate
        local next_crit_rate = next_adv_data.crit_rate
        
         if crit_rate ~= next_crit_rate then
    	local tit = {"暴击率",crit_rate,next_crit_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local anti_crite = adv_data.anti_crite
        local next_anti_crite = next_adv_data.anti_crite
        
         if anti_crite ~= next_anti_crite then
    	local tit = {"免爆率",anti_crite,next_anti_crite}
    	table.insert(self.upshuxingList,tit)
        end
        
        local crit_hurt = adv_data.crit_hurt
        local next_crit_hurt = next_adv_data.crit_hurt
        
         if crit_hurt ~= next_crit_hurt then
    	local tit = {"暴击伤害加成",crit_hurt,next_crit_hurt}
    	table.insert(self.upshuxingList,tit)
        end
        
        local broken_rate = adv_data.broken_rate
        local next_broken_rate = next_adv_data.broken_rate
        
         if broken_rate ~= next_broken_rate then
    	local tit = {"破击率",broken_rate,next_broken_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local parry_rate = adv_data.parry_rate
        local next_parry_rate = next_adv_data.parry_rate
        
         if parry_rate ~= next_parry_rate then
    	local tit = {"格挡率",parry_rate,next_parry_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local parry_plus = adv_data.parry_plus
        local next_parry_plus = next_adv_data.parry_plus
        
         if parry_plus ~= next_parry_plus then
    	local tit = {"格挡伤害加成",parry_plus,next_parry_plus}
    	table.insert(self.upshuxingList,tit)
        end
    end
    
    --app.log("upshuxinglist ###########"..table.tostring(self.upshuxingList))
    
end

function Trainningbattleinfo:on_click_uplvl_button(t)
    
    uiManager:PushUi(EUI.Trainningbattleup);
    player.cg_training_group_advance(self.currentindex)
    
end

function Trainningbattleinfo:on_close_wnd()
    uiManager:PopUi()
end

function Trainningbattleinfo:UpdateUi()
    
end

function Trainningbattleinfo:IsCanUpLvl()
    
end

function Trainningbattleinfo:upheroinfo()
    
    self:initDataShuxinglvl()
    self:rushlist()
    self:rushuplist()
    self:setBattleLvl()
    self:setUpBtn()
    self:setshuxin()
    self:setPoit()
end




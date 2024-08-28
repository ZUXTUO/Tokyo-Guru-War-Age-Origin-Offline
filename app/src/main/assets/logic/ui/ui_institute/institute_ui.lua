
InstituteUI = Class("InstituteUI", UiBaseClass)
--语言包
local _UIText = {

}

-------------------------------------外部调用-------------------------------------
function InstituteUI:ShowNavigationBar()
    return true
end


function InstituteUI:Init(data)
    self.InstituteId = data
    self.pathRes = "assetbundles/prefabs/ui/yan_jiu_suo/ui_4901_yan_jiu_suo.assetbundle"
    UiBaseClass.Init(self, data);
end

function InstituteUI:localLoadBoundAsset()
    --local BoudpathRes = "assetbundles/prefabs/ui/yjs/shengqi/ui_4902_yan_jiu_suo.assetbundle";
    local BoudpathRes = self.itemlist[self.currentIndex].bigicon
    ResourceLoader.LoadAsset(BoudpathRes, self.bindfunc['on_ui_loaded']);
end

function InstituteUI:OnLoadBoudUI(pid, filepath, asset_obj, error_info)
    --local BoudpathRes = "assetbundles/prefabs/ui/yjs/shengqi/ui_4902_yan_jiu_suo.assetbundle";
    local BoudpathRes = self.itemlist[self.currentIndex].bigicon
    if filepath == BoudpathRes then
	self:InitBoundUI(asset_obj);
    end
end

function InstituteUI:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function InstituteUI:InitData(data)
    UiBaseClass.InitData(self, data)
    
    self.local_file_name = "play_fx_index.data"
    self.local_play_fx_list = {};
    --self.itemlist = {};
    --self.pyvaluelist = {};   --后两项随即值
    self.IsUnlockBtn = false;
    self.Boundui ={};
    self.currentIndex = 1;
    self.itemlist = ConfigManager._GetConfigTable(EConfigIndex.t_yanjiusuo)
    self.instituteData = g_dataCenter.Institute:GetData(self.currentIndex)
    self.instituteunlockdata = g_dataCenter.Institute:getUnlockList()
    self.IsCanceBtn = true;   --是否能取消提升
    --app.log("=============================================================")
    app.log("self.instituteData#######################"..table.tostring(self.instituteData))
    --app.log("=============================================================")
    --app.log("self.instituteunlockdata#######################"..table.tostring(self.instituteunlockdata))
end

function InstituteUI:DestroyUi()
    self.currentIndex = 1;
    UiBaseClass.DestroyUi(self);

end

function InstituteUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_ui_loaded'] = Utility.bind_callback(self, self.OnLoadBoudUI);
    self.bindfunc['on_click_Open_button'] = Utility.bind_callback(self, self.on_click_Open_button);
    self.bindfunc['on_toggle_change'] = Utility.bind_callback(self, self.on_toggle_change);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item);
    
    self.bindfunc["on_PYOne_buttom"] = Utility.bind_callback(self,self.on_PYOne_buttom);
    self.bindfunc["on_PYTen_buttom"] = Utility.bind_callback(self,self.on_PYTen_buttom);
    
    self.bindfunc["on_chose_item"] = Utility.bind_callback(self,self.on_chose_item);
    
    self.bindfunc["on_updata_data"] = Utility.bind_callback(self,self.on_updata_data);
    self.bindfunc["on_save_btn"] = Utility.bind_callback(self,self.on_save_btn);
    self.bindfunc["on_cance_btn"] = Utility.bind_callback(self,self.on_cance_btn);
    
    self.bindfunc["on_updata_pyvalue"] = Utility.bind_callback(self,self.on_updata_pyvalue);
    self.bindfunc["on_updata_save"] = Utility.bind_callback(self,self.on_updata_save);
    
    self.bindfunc["on_unlock_showpy"] = Utility.bind_callback(self,self.on_unlock_showpy);
    
    self.bindfunc["on_find_way_material"] = Utility.bind_callback(self,self.on_find_way_material);

    self.bindfunc["on_last_button"] = Utility.bind_callback(self,self.on_last_button);

    self.bindfunc["on_next_button"] = Utility.bind_callback(self,self.on_next_button);
    
end



function InstituteUI:on_save_btn()
    --app.log("on_save_data##############################")
    msg_laboratory.cg_save(self.currentIndex,true)
    --self:showPyBtn()
end

function InstituteUI:on_find_way_material()
    local temp = {}
    temp.item_id = 20000126
    temp.number = 1
    AcquiringWayUi.Start(temp)        
end

function InstituteUI:on_cance_btn()
    if self.IsCanceBtn then
	--app.log("on_cance_data##############################")
	msg_laboratory.cg_save(self.currentIndex,false)
    else
	FloatTip.Float("不能取消提升！");
    end
    --self:showPyBtn()
end

function InstituteUI:on_PYOne_buttom()
    local pytype = self.typelvl - 1
    --app.log("onoenoeneoneoneoneoenoeneoe")
    msg_laboratory.cg_train(self.currentIndex,pytype,false)
    --self:showSaveBtn()
end

function InstituteUI:on_PYTen_buttom()
    local pytype = self.typelvl - 1
    --app.log("tententnetnentnentnentnentne")
    msg_laboratory.cg_train(self.currentIndex,pytype,true)
    --self:showSaveBtn()
end

function InstituteUI:showSaveBtn()
    self.saveBtn:set_active(true)
    self.canceBtn:set_active(false)
    self.pyOneBtn:set_active(false)
    self.pyTenBtn:set_active(false)
end

function InstituteUI:showPyBtn()
    self.saveBtn:set_active(false)
    self.canceBtn:set_active(false)
    self.pyOneBtn:set_active(true)
    self.pyTenBtn:set_active(true)
end

function InstituteUI:on_chose_item(name, x, y, go_obj,value)
                
    --app.log("t.string_value####################"..tostring(t.string_value))
    app.log("t.float_value####################"..tostring(value))
    
    local datavalue = tostring(value)
    local index = string.find(datavalue,";")
    local indexlen = string.len(value) 
    --app.log("fvalue####################"..tostring(index))
    local value1 = string.sub(datavalue,1,index-1)
    local value2 = tonumber(string.sub(datavalue,index+1,indexlen))
    --app.log("value1##############"..tostring(value1))
     --app.log("value2##############"..tostring(value2))
    --local value2 = string.sub(datavalue,)
    --do return end
    local dataNumb = g_dataCenter.Institute:GetData(tonumber(value1))
    
    if dataNumb == nil then
        dataNumb = { isUnLock = false }
    end

    local datanext = nil;
    if tonumber(value1) > 1 then
	   datanext = g_dataCenter.Institute:GetData(tonumber(value1)-1).isUnLock
    end

    self.instituteData = g_dataCenter.Institute:GetData(self.currentIndex)
    
     self:on_clear_text()       
    
    
    if dataNumb.isUnLock or datanext then
                    
        if self.currentItem then
            --local yeka2 = ngui.find_sprite(self.currentItem,"sp_yeqian2")
            --yeka2:set_active(true)
            --local sp_mark = ngui.find_sprite(self.currentItem,"sp_mark")
            --sp_mark:set_active(true)
            local yeka1 = ngui.find_sprite(self.currentItem,"sp_shine")
            yeka1:set_active(false)
        end  
	
        self.currentIndex = tonumber(value1);
    	self:ClearAndUpdataUI()
    	self:ClearBoundUI()
    	self:setTitle(value2)
    	self:initPYTitle()
    	self:showTJUI()
    	self:loadTJText()
	
        self.instituteData = g_dataCenter.Institute:GetData(self.currentIndex)
	
        if self.instituteData.isUnLock then
    	    self:updatalock()
    	    self:updatapyvalue()
    	end
    	self:set_point()
        self:updataTJItem()
        self.currentItem = self.ui:get_child_by_name("centre_other/animation/cont_tongyong/sco_view/panel/wrap_cont/child0"..value1)--self.itemlistobj[value1].root
        
        if self.currentItem then
            local yeka2 = ngui.find_sprite(self.currentItem,"sp_shine")
            yeka2:set_active(false)
            --local sp_mark = ngui.find_sprite(self.currentItem,"sp_mark")
            --if self.instituteData.isUnLock then
            --            sp_mark:set_active(false)
            --else
            --            sp_mark:set_active(true)
            --end
           local yeka1 = ngui.find_sprite(self.currentItem,"sp_shine")
            yeka1:set_active(true)
        end
         
        if self.instituteData.max_hp_ex ~= 0 or self.instituteData.atk_power_ex ~= 0 or self.instituteData.def_power_ex ~= 0 or self.instituteData.parry_plus_ex ~= 0 or self.instituteData.broken_rate_ex ~= 0 or self.instituteData.anti_crite_ex ~= 0 or self.instituteData.crit_hurt_ex ~= 0 or self.instituteData.crit_rate_ex ~= 0 or self.instituteData.parry_rate_ex ~= 0 then   
            self:on_updata_pyvalue()
            self:set_toggle_data(self.instituteData.nType)
        end

        --判断是否解锁
        local flag = true;

        local data = g_dataCenter.Institute:GetData(self.currentIndex)

        for k,v in pairs( data.vecUnlockInfo )do
            if v.bUnlock == false then
                flag = false;
                break;
            end
        end

        if flag then
            --self.OpenPeiyangBtn:set_enable(true)
            PublicFunc.SetButtonShowMode(self.OpenPeiyangBtn,1,"sprite_background","lab")
            --self.OpenPeiyangBtnLab:set_color(140/255,66/255,19/255,255/255)
        else
            PublicFunc.SetButtonShowMode(self.OpenPeiyangBtn,3,"sprite_background","lab")
            --self.OpenPeiyangBtn:set_enable(false)
            --self.OpenPeiyangBtnLab:set_color(255/255,255/255,255/255,255/255)
        end
        
    else
	   FloatTip.Float("还未解锁！");
    end
end

--设置标题
function InstituteUI:setTitle( value )
                --app.log("value################"..tostring(value))
    local item  = ConfigManager.Get(EConfigIndex.t_item,value);
    local itemname = item.name
    self:SetItemName(itemname)
end

function InstituteUI:ClearBoundUI()
    --self.Boundui[self.currentBoundindex]:set_active(false)
    self:InitBoundUI()
end

function InstituteUI:ClearAndUpdataUI()
    
end
--初始化培养后面两个属性
function InstituteUI:initPYTitle()
    self.pytitle = {
		    "暴击率",
		    "免暴率",
		    "暴伤率",
		    "破击率",
		    "格挡率",
		    "格伤率",
    }
    local data = self.itemlist[self.currentIndex]
    local titlelist = {};
    self.pyvaluelist = {};
    for k,v in pairs(data)do
	--app.log("VVVVVVVVVVVVVVVVVVVVVVVVVVVV"..tostring(v).."KKKKKKKKKKKKKKKKKK"..tostring(k))
	if v ~= 0 and k == 17 then
	    table.insert(titlelist,self.pytitle[1])
	    table.insert(self.pyvaluelist,"crit_rate")
	elseif v ~= 0 and k == 18 then
	    table.insert(titlelist,self.pytitle[2])
	    table.insert(self.pyvaluelist,"anti_crite")
	elseif v~= 0 and k == 19 then
	    table.insert(titlelist,self.pytitle[3])
	    table.insert(self.pyvaluelist,"crit_hurt")
	elseif v~= 0 and k == 20 then
	    table.insert(titlelist,self.pytitle[4])
	    table.insert(self.pyvaluelist,"broken_rate")
	elseif v~= 0 and k == 21 then
	    table.insert(titlelist,self.pytitle[5])
	    table.insert(self.pyvaluelist,"parry_rate")
	elseif v~= 0 and k == 22 then
	    table.insert(titlelist,self.pytitle[6])
	    table.insert(self.pyvaluelist,"parry_plus")
	end
    end
    --app.log("titttttle######################"..table.tostring(titlelist))
    --self:setpytitle(titlelist)
    self.ContrTitle:set_text(titlelist[1])
    self.MianKTitle:set_text(titlelist[2])
end


--注册消息分发回调函数
function InstituteUI:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_laboratory.gc_sync_all_laboratory_data, self.bindfunc["on_updata_data"])
    PublicFunc.msg_regist(msg_laboratory.gc_train, self.bindfunc["on_updata_pyvalue"])
    PublicFunc.msg_regist(msg_laboratory.gc_save, self.bindfunc["on_updata_save"])
    --PublicFunc.msg_regist(msg_laboratory.gc_save, self.bindfunc["on_unlock_showpy"])
    PublicFunc.msg_regist(msg_laboratory.gc_unLock_laboratory, self.bindfunc["on_unlock_showpy"])
    
end

--注销消息分发回调函数
function InstituteUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_laboratory.gc_sync_all_laboratory_data, self.bindfunc["on_updata_data"])
    PublicFunc.msg_unregist(msg_laboratory.gc_train, self.bindfunc["on_updata_pyvalue"])
    PublicFunc.msg_unregist(msg_laboratory.gc_save, self.bindfunc["on_updata_save"])
    --PublicFunc.msg_unregist(msg_laboratory.gc_save, self.bindfunc["on_unlock_showpy"])
    PublicFunc.msg_unregist(msg_laboratory.gc_unLock_laboratory, self.bindfunc["on_unlock_showpy"])
end

function InstituteUI:on_updata_data()
    
    --app.log("#########on_updata_data##############"..tostring(self.currentIndex))
    self.instituteData = g_dataCenter.Institute:GetData(self.currentIndex)
    self.instituteunlockdata = g_dataCenter.Institute:getUnlockList()
    self:loadTJText()
    self:updatalock()
    self:updatapyvalue()
    self:updataTJItem()
    self:updatarigtsuodata()
    self:setLine()
    --如果上次培养时 没有点确定保存，则进入游戏时的特殊处理
    --app.log("self.instituteData############"..table.tostring(self.instituteData))
    if self.instituteData.max_hp_ex ~= 0 or self.instituteData.atk_power_ex ~= 0 or self.instituteData.def_power_ex ~= 0 or self.instituteData.parry_plus_ex ~= 0 or self.instituteData.broken_rate_ex ~= 0 or self.instituteData.anti_crite_ex ~= 0 or self.instituteData.crit_hurt_ex ~= 0 or self.instituteData.crit_rate_ex ~= 0 or self.instituteData.parry_rate_ex ~= 0 then   
        self:on_updata_pyvalue()
        self:set_toggle_data(self.instituteData.nType)
    end

    --判断是否解锁
    local flag = true;

    local data = g_dataCenter.Institute:GetData(self.currentIndex)

    for k,v in pairs( data.vecUnlockInfo )do
        if v.bUnlock == false then
            flag = false;
            break;
        end
    end

    if flag then
        -- self.OpenPeiyangBtn:set_enable(true)
        -- self.OpenPeiyangBtnLab:set_color(140/255,66/255,19/255,255/255)
        PublicFunc.SetButtonShowMode(self.OpenPeiyangBtn,1,"sprite_background","lab")
    else
        -- self.OpenPeiyangBtn:set_enable(false)
        -- self.OpenPeiyangBtnLab:set_color(255/255,255/255,255/255,255/255)
        PublicFunc.SetButtonShowMode(self.OpenPeiyangBtn,3,"sprite_background","lab")
    end


end

function InstituteUI:updatarigtsuodata()
    local data = g_dataCenter.Institute:GetData(self.currentIndex)
    
    if data then
        local UnlockInfo = data.vecUnlockInfo
        if UnlockInfo then
            for k,v in pairs(UnlockInfo)do
                if v.bUnlock then
                    --app.log("unlockid is###############"..tostring(v.unlockid))
                    self:SetOpenSQJD(k)
                else
                    self:SetCloseSQJD(k)          
                end
            end
        end
    end             
end

function InstituteUI:on_unlock_showpy()
    --self:updatalock()
   self:playmovefapai()
   --self:on_updata_data()
end

--播放解锁动画
function InstituteUI:player_jiesuo_animation()
    --self.beginanim:set_animator_enable(true)
    self.beginanim:animator_play("ui_yanjiusuo_daiji")
end

function ui_yanjiusuo_change_end()

end

function InstituteUI:playmovefapai()

    function playdaiji()
        self:on_updata_data()
        self:player_jiesuo_animation()
    end

    self.peiyangview:set_active(true)
    self.beginanim:animator_play("ui_yanjiusuo_change2")
    TimerManager.Add(playdaiji, 800)

end

function ui_yanjiusuo_change2_end()
    -- local obj = uiManager:FindUI(EUI.InstituteUI)
    -- obj:on_updata_data()
    -- obj:player_jiesuo_animation()
end


--初始化UI
function InstituteUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('YJS');
    self.tiaojianview = self.ui:get_child_by_name("centre_other/animation/cont_weijihuo");  --条件界面
    self.tiaojianview:set_active(false)
    self.point = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont_right1/btn1/animation/sp_point")
    
    self.tiaojianlist = self.ui:get_child_by_name("centre_other/animation/cont_right/cont_right1/cont_list")	   --条件列表
    self.ring = {};
    self.Tlist = {};
    
    --全满
    self.quanman = self.ui:get_child_by_name("centre_other/animation/cont_jihuo/sp_manji")
    self.quanman:set_active(false)
    --未全满
    self.no_max_con1 = self.ui:get_child_by_name("centre_other/animation/cont_jihuo/cont_right2/cont1")
    self.no_max_con2 = self.ui:get_child_by_name("centre_other/animation/cont_jihuo/cont_right2/cont2")

    --开始研究特效
    self.beginfx = self.ui:get_child_by_name("centre_other/animation/cont_tongyong/cont_wuqi/fx_ui_4901_newweapon")
    self.beginfx:set_active(false)
    self.beginanim = self.ui:get_child_by_name("centre_other/animation")
    -- self.beginanim:set_animator_enable(false)
    self.beginanim:animator_play("ui_yanjiusuo_daiji")
    self.jiesuowuqifx = self.ui:get_child_by_name("centre_other/animation/cont_tongyong/cont_wuqi/fx_ui_4901_yan_jiu_suo_yanjiu")
    self.jiesuowuqifx:set_active(false)

    self.itemlistobj = {};
    self.itemlistsuo = {}
        
    for i = 1,5 do
	self.Tlist[i] = {};
	self.Tlist[i].root = self.ui:get_child_by_name("centre_other/animation/cont_weijihuo/cont_right1/cont_list/item"..i);
	self.Tlist[i].labName = ngui.find_label(self.ui,"centre_other/animation/cont_weijihuo/cont_right1/cont_list/item"..i.."/lab_word");
	self.Tlist[i].labNumb = ngui.find_label(self.ui,"centre_other/animation/cont_weijihuo/cont_right1/cont_list/item"..i.."/lab_num");
	self.Tlist[i].suo = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont_right1/cont_list/item"..i.."/sp_di3/sp_frame");
	self.Tlist[i].IsSuc = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont_right1/cont_list/item"..i.."/sp_art_font")--ngui.find_sprite(self.ui,"centre_other/animation/cont_right1/cont_list/item"..i.."/cont/sp_art_font");
	--self.Tlist[i].IsSuc:set_active(false)  --默认为锁上状态
        
    end
    --1号条件
    --self.Tlist1Text = ngui.find_label(self.tiaojianlist,"item1/lab_word")   --条件文字
    --self.Tlist1Numb = ngui.find_label(self.tiaojianlist,"item1/lab_num")    --进度
    --self.Tlist1IsOpen = ngui.find_sprite(self.tiaojianlist,"item1/sp_suo")  --是否开启
    --self.Tlist1Suc = ngui.find_sprite(self.tiaojianlist,"item1/cont/sp_art_font")	--是否达成
    
    self.OpenPeiyangBtn =  ngui.find_button(self.tiaojianview,"cont_right1/btn1")
    self.OpenPeiyangBtn:set_on_click(self.bindfunc['on_click_Open_button']);

    self.OpenPeiyangBtnLab = ngui.find_label(self.tiaojianview,"cont_right1/btn1/animation/lab")
    
    self.peiyangview = self.ui:get_child_by_name("centre_other/animation/cont_jihuo");   --培养界面
    
    self.peiyangview:set_active(false)
    --self.tiaojianview:set_active(false)
    
    --力量
    self.AttrTiao = ngui.find_progress_bar(self.peiyangview,"cont_right2/grid/bar1/pro_bar")	--进度条
    self.AttrText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar1/lab_num1")	  --进度数字
    self.AttrupText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar1/lab_num2")	  --提升数字
    self.AttrMax = ngui.find_sprite(self.peiyangview,"cont_right2/grid/bar1/sp_art_font")  --是否达到MAX
    self.AttrMax:set_active(false)
    self.AttrTiao:set_value(0)
    self.AttrupText:set_text("")
    self.AttrupText:set_active(true)
    
    --防御
    self.DefTiao = ngui.find_progress_bar(self.peiyangview,"cont_right2/grid/bar2/pro_bar")	--进度条
    self.DefText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar2/lab_num1")	  --进度数字
    self.DefupText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar2/lab_num2")	  --提升数字
    self.DefMax = ngui.find_sprite(self.peiyangview,"cont_right2/grid/bar2/sp_art_font")  --是否达到MAX
    self.DefMax:set_active(false)
    self.DefTiao:set_value(0)
    self.DefupText:set_text("")
    self.DefupText:set_active(true)
    
    --生命
    self.VitalTiao = ngui.find_progress_bar(self.peiyangview,"cont_right2/grid/bar3/pro_bar")	--进度条
    self.VitalText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar3/lab_num1")	  --进度数字
    self.VitalupText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar3/lab_num2")	  --提升数字
    self.VitalMax = ngui.find_sprite(self.peiyangview,"cont_right2/grid/bar3/sp_art_font")  --是否达到MAX
    self.VitalMax:set_active(false)
    self.VitalTiao:set_value(0)
    self.VitalupText:set_text("")
    self.VitalupText:set_active(true)
    
    --控制
    self.ContrTitle = ngui.find_label(self.peiyangview,"cont_right2/grid/bar4/txt_title1")       --标题
    self.ContrTiao = ngui.find_progress_bar(self.peiyangview,"cont_right2/grid/bar4/pro_bar")	--进度条
    self.ContrText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar4/lab_num1")	  --进度数字
    self.ContrupText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar4/lab_num2")	  --提升数字
    self.ContrMax = ngui.find_sprite(self.peiyangview,"cont_right2/grid/bar4/sp_art_font")  --是否达到MAX
    self.ContrMax:set_active(false)
    self.ContrTiao:set_value(0)
    self.ContrupText:set_text("")
    self.ContrupText:set_active(true)
    
    --免控
    self.MianKTitle = ngui.find_label(self.peiyangview,"cont_right2/grid/bar5/txt_title1")       --标题
    self.MianKTiao = ngui.find_progress_bar(self.peiyangview,"cont_right2/grid/bar5/pro_bar")	--进度条
    self.MianKText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar5/lab_num1")	  --进度数字
    self.MianKupText = ngui.find_label(self.peiyangview,"cont_right2/grid/bar5/lab_num2")	  --提升数字
    self.MianKMax = ngui.find_sprite(self.peiyangview,"cont_right2/grid/bar5/sp_art_font")  --是否达到MAX
    self.MianKMax:set_active(false)
    self.MianKTiao:set_value(0)
    self.MianKupText:set_text("")
    self.MianKupText:set_active(true)
    
    --培养1次
    self.pyOneBtn = ngui.find_button(self.peiyangview,"btn")
    self.pyOneBtn:set_on_click(self.bindfunc["on_PYOne_buttom"])
    --培养10次
    self.pyTenBtn = ngui.find_button(self.peiyangview,"btn2")
    self.pyTenBtn:set_on_click(self.bindfunc["on_PYTen_buttom"])
    
    self.saveBtn = ngui.find_button(self.peiyangview,"btn4")
    self.saveBtn:set_on_click(self.bindfunc["on_save_btn"])
    
    self.canceBtn = ngui.find_button(self.peiyangview,"btn3")
    self.canceBtn:set_on_click(self.bindfunc["on_cance_btn"])
    
    self.saveBtn:set_active(false)
    self.canceBtn:set_active(false)
    
    self.texture1 = ngui.find_texture(self.peiyangview,"cont_right2/cont2/cont/texture1") --培养的第一张texture
    self.texture2 = ngui.find_texture(self.peiyangview,"cont_right2/cont2/cont/texture2") --培养的第二张texture
    --self.texturebg2 = ngui.find_sprite(self.peiyangview,"cont2/cont/texture2/sp_bg")
    --self.texturebg2:set_active(false)
    
    self.pycailiaonumb1 = ngui.find_label(self.peiyangview,"cont2/cont/texture1/lab_num") --培养材料Numb
    self.pycailiaonumb2 = ngui.find_label(self.peiyangview,"cont2/cont/texture2/lab_num")

    self.jiandancastui = self.ui:get_child_by_name("centre_other/animation/cont_jihuo/cont_right2/cont3")
    self.chujicastlab = ngui.find_label(self.ui,"centre_other/animation/cont_jihuo/cont_right2/cont3/texture1/lab_num")
    self.chujicasttexture = ngui.find_texture(self.ui,"centre_other/animation/cont_jihuo/cont_right2/cont3/texture1")
    
    self.fuzhacastui = self.ui:get_child_by_name("centre_other/animation/cont_jihuo/cont_right2/cont2")
    self.fuzhacastui:set_active(false)
    
    self.leftview = self.ui:get_child_by_name("cont_left")    --左边界面
    
    self.title = ngui.find_label(self.ui,"centre_other/animation/cont_tongyong/cont_down/lab_name")         --神器名称
    self.yjdnumb = ngui.find_label(self.ui,"centre_other/animation/cont_tongyong/cont_down/txt_yanjiudian/lab_num")     --研究点
    --self.yjdnumb:set_text(tostring(g_dataCenter.package:GetCountByNumber(20000126)))
    
    self.yjdbtn = ngui.find_button(self.ui,"centre_other/animation/cont_tongyong/cont_down/btn1")        --研究点BTN
    self.yjdbtn:set_on_click(self.bindfunc["on_find_way_material"])
    
    self.sqrq = ngui.find_texture(self.ui,"centre_other/animation/cont_tongyong/cont_wuqi/texture_wuqi")
    
    self.chujiBtn = ngui.find_toggle(self.ui,"centre_other/animation/cont_jihuo/cont_right2/cont1/yeka/yeka1") --初级
    self.chujiBtn:set_on_change(self.bindfunc["on_toggle_change"]);
    self.chujiBtn:set_value(true)
    self.zhongjiBtn = ngui.find_toggle(self.peiyangview,"centre_other/animation/cont_jihuo/cont_right2/cont1/yeka/yeka2")	--中级
    self.zhongjiBtn:set_on_change(self.bindfunc["on_toggle_change"]);
    -- self.gaojiBtn = ngui.find_toggle(self.peiyangview,"centre_other/animation/cont_jihuo/cont_right2/cont1/yeka/yeka3")	--高级
    -- self.gaojiBtn:set_on_change(self.bindfunc["on_toggle_change"]);
    
    --self.sco_view = self.ui:get_child_by_name("sco_view")		--底部
    --列表    
    self.scroll_view = ngui.find_scroll_view(self.ui,"centre_other/animation/cont_tongyong/sco_view/panel");
    self.wrap = ngui.find_wrap_content(self.ui,"centre_other/animation/cont_tongyong/sco_view/panel/wrap_cont");
    --app.log("#####################################")
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.lastbtn = ngui.find_button(self.ui,"centre_other/animation/cont_tongyong/sco_view/btn_top")
    self.nextbtn = ngui.find_button(self.ui,"centre_other/animation/cont_tongyong/sco_view/btn_down")
    


    self.wrap:set_min_index(-#self.itemlist+1);
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scroll_view:reset_position(); 
    
    self:on_get_unlock_state()
    
    self:setyjdvalue()
    --self:localLoadBoundAsset()
    self:InitBoundUI()
    --self:InitBottomList()
    self:initPYTitle()
    --self:UpdateUi();
    msg_laboratory.cg_request_all_laboratory_data()
    --self:on_updata_data()
    
    --self.loaddatatime = timer.create(self.bindfunc["on_updata_data"],500,1)
end

function InstituteUI:UpdateUi()
    self:UpdataItemList()
    self:loadTJText()
end

function InstituteUI:show_max_ui()
    self.quanman:set_active(true)
    self.no_max_con1:set_active(false)
    self.no_max_con2:set_active(false)
    self.pyOneBtn:set_active(false)
    self.pyTenBtn:set_active(false)
    self.jiandancastui:set_active(false)
end

function InstituteUI:hide_max_ui()
    self.quanman:set_active(false)
    self.no_max_con1:set_active(true)
    self.no_max_con2:set_active(true)
    self.pyOneBtn:set_active(true)
    self.pyTenBtn:set_active(true)
    self.jiandancastui:set_active(true)
    app.log("typelvl.............."..tostring(self.typelvl))
    self:setXiaoHaoText(self.typelvl)
end

--刷 新解锁界面
function InstituteUI:updatalock()
    --app.log("updatalock################"..table.tostring(self.instituteData))
    
    local data = g_dataCenter.Institute:GetAllData()
    local number = 0
    
    for k,v in pairs(data)do
        if v.isUnLock then
            self:OpenItem(k)
            number = number + 1
        end
    end
    
    self:OpenNewItem(number + 1)
    
    if self.instituteData.isUnLock then
        self:showPYUI()
        self:OpenItem(self.currentIndex)
    else
        self:showTJUI()
    end
    
    self:set_point()
    
end

function InstituteUI:set_point()
    --红点处理
    local flag = true
    local datainfo = g_dataCenter.Institute:GetData(self.currentIndex)
    if datainfo then
        for k,v in pairs( datainfo.vecUnlockInfo )do
            if v.bUnlock == false then
                flag = false;
                break;
            end
        end          
    end
    
    local IsUnlockBtn = true
    
    if datainfo.isUnLock then
        IsUnlockBtn = true
    else
        IsUnlockBtn = false
    end
    
    if flag == true and IsUnlockBtn == false then
        self.point:set_active(true)     
    else
        self.point:set_active(false)  
    end             
end

function InstituteUI:OpenNewItem(index)
                
    if self.itemlistobj[index] then
        if self.itemlistobj[index].suo then
           self.itemlistobj[index].suo:set_active(false) 
        end
        
        if self.itemlistobj[index].suo1 then
           self.itemlistobj[index].suo1:set_active(true) 
        end
        
        if self.itemlistobj[index].icon then
            self.itemlistobj[index].icon:set_active(true)            
        end
    end
                
end

--刷新培养数值
function InstituteUI:updatapyvalue()
    local index = 0;
    local value1 = self.itemlist[self.currentIndex].atk_power[1].initial
    local value2 = self.itemlist[self.currentIndex].atk_power[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    --app.log("currentIndex ##############"..tostring(self.currentIndex))
    if self.instituteData.atk_power >= Maxvalue then
        self.AttrMax:set_active(true)
        index = index + 1
    else
        self.AttrMax:set_active(false)
    end
    self.AttrText:set_text("[974D04FF]"..tostring(tostring(PublicFunc.AttrInteger(self.instituteData.atk_power))).."[-][7463C9FF] / "..tostring(PublicFunc.AttrInteger(Maxvalue)).."[-]")
    self.AttrTiao:set_value(PublicFunc.AttrInteger(self.instituteData.atk_power)/PublicFunc.AttrInteger(Maxvalue))
    
    local value1 = self.itemlist[self.currentIndex].def_power[1].initial
    local value2 = self.itemlist[self.currentIndex].def_power[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2

    if self.instituteData.def_power >= Maxvalue then
        self.DefMax:set_active(true)
        index = index + 1
    else
        self.DefMax:set_active(false)
    end

    self.DefText:set_text("[974D04FF]"..tostring(PublicFunc.AttrInteger(self.instituteData.def_power)).."[-][7463C9FF] / "..tostring(PublicFunc.AttrInteger(Maxvalue)).."[-]")
    self.DefTiao:set_value(PublicFunc.AttrInteger(self.instituteData.def_power)/PublicFunc.AttrInteger(Maxvalue))
    
    
    local value1 = self.itemlist[self.currentIndex].max_hp[1].initial
    local value2 = self.itemlist[self.currentIndex].max_hp[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2

    if self.instituteData.max_hp >= Maxvalue then
        self.VitalMax:set_active(true)
        index = index + 1
    else
        self.VitalMax:set_active(false)
    end

    self.VitalText:set_text("[974D04FF]"..tostring(PublicFunc.AttrInteger(self.instituteData.max_hp)).."[-][7463C9FF] / "..tostring(PublicFunc.AttrInteger(Maxvalue)).."[-]")
    self.VitalTiao:set_value(PublicFunc.AttrInteger(self.instituteData.max_hp)/PublicFunc.AttrInteger(Maxvalue))
    
    local valuelist = {};
    local valueMaxlist = {};
    for k,v in pairs(self.pyvaluelist)do
    	if v == "crit_rate" then
    	    table.insert(valuelist,self.instituteData.crit_rate)
    	    local value1 = self.itemlist[self.currentIndex].crit_rate[1].initial
    	    local value2 = self.itemlist[self.currentIndex].crit_rate[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	elseif v ==  "anti_crite" then
    	    table.insert(valuelist,self.instituteData.anti_crite)
    	    local value1 = self.itemlist[self.currentIndex].anti_crite[1].initial
    	    local value2 = self.itemlist[self.currentIndex].anti_crite[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	elseif v ==  "crit_hurt" then
    	    table.insert(valuelist,self.instituteData.crit_hurt)
    	    local value1 = self.itemlist[self.currentIndex].crit_hurt[1].initial
    	    local value2 = self.itemlist[self.currentIndex].crit_hurt[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	elseif v ==  "broken_rate" then
    	    table.insert(valuelist,self.instituteData.broken_rate)
    	    local value1 = self.itemlist[self.currentIndex].broken_rate[1].initial
    	    local value2 = self.itemlist[self.currentIndex].broken_rate[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	elseif v ==  "parry_rate" then
    	    table.insert(valuelist,self.instituteData.parry_rate)
    	    local value1 = self.itemlist[self.currentIndex].parry_rate[1].initial
    	    local value2 = self.itemlist[self.currentIndex].parry_rate[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	elseif v ==  "parry_plus" then
    	    local value1 = self.itemlist[self.currentIndex].parry_plus[1].initial
    	    local value2 = self.itemlist[self.currentIndex].parry_plus[1].grow
    	    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2  
    	    table.insert(valueMaxlist,Maxvalue)
    	    table.insert(valuelist,self.instituteData.parry_plus)
    	end
    end
    
    self.ContrText:set_text("[974D04FF]"..tostring(PublicFunc.AttrInteger(valuelist[1])).."[-][7463C9FF] / "..tostring(PublicFunc.AttrInteger(valueMaxlist[1])).."[-]");

    if valuelist[1] >= valueMaxlist[1] then
        self.ContrMax:set_active(true)
        index = index + 1
    else
        self.ContrMax:set_active(false)
    end

    self.ContrTiao:set_value(PublicFunc.AttrInteger(valuelist[1])/PublicFunc.AttrInteger(valueMaxlist[1]));
    self.MianKText:set_text("[974D04FF]"..tostring(PublicFunc.AttrInteger(valuelist[2])).."[-][7463C9FF] / "..tostring(PublicFunc.AttrInteger(valueMaxlist[2])).."[-]");

    if valuelist[2] >= valueMaxlist[2] then
        self.MianKMax:set_active(true)
        index = index + 1
    else
        self.MianKMax:set_active(false)
    end

    self.MianKTiao:set_value(PublicFunc.AttrInteger(valuelist[2])/PublicFunc.AttrInteger(valueMaxlist[2]));
    
    if index == 5 then
        self:show_max_ui()
    else
        self:hide_max_ui()
    end

end

--计算防御力最大值
function InstituteUI:comput_def_power()
    --local data = g_dataCenter.Institute:GetData(self.currentIndex)
    local value1 =  self.itemlist[self.currentIndex].def_power[1].initial
    local value2 =  self.itemlist[self.currentIndex].def_power[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_atk_power()
    local value1 = self.itemlist[self.currentIndex].atk_power[1].initial
    local value2 = self.itemlist[self.currentIndex].atk_power[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_max_hp()
    local value1 = self.itemlist[self.currentIndex].max_hp[1].initial
    local value2 = self.itemlist[self.currentIndex].max_hp[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_crit_rate()
    --app.log("###########"..table.tostring(self.itemlist[self.currentIndex].crit_rate[1]))
    local value1 = self.itemlist[self.currentIndex].crit_rate[1].initial
    local value2 = self.itemlist[self.currentIndex].crit_rate[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_anti_crite()
    local value1 = self.itemlist[self.currentIndex].anti_crite[1].initial
    local value2 = self.itemlist[self.currentIndex].anti_crite[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_crit_hurt()
    local value1 = self.itemlist[self.currentIndex].crit_hurt[1].initial
    local value2 = self.itemlist[self.currentIndex].crit_hurt[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_broken_rate()
    local value1 = self.itemlist[self.currentIndex].broken_rate[1].initial
    local value2 = self.itemlist[self.currentIndex].broken_rate[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_parry_rate()
    local value1 = self.itemlist[self.currentIndex].parry_rate[1].initial
    local value2 = self.itemlist[self.currentIndex].parry_rate[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:comput_parry_plus()
    local value1 = self.itemlist[self.currentIndex].parry_plus[1].initial
    local value2 = self.itemlist[self.currentIndex].parry_plus[1].grow
    local Maxvalue =  value1 +(g_dataCenter.player.level-1)*value2
    return Maxvalue
end

function InstituteUI:getyansema(value)
	local yansema = ""
	if value > 0 then
		yansema = "[7acf0f]+"
	elseif value < 0 then
		yansema = "[ff0000]"
	elseif value == 0 then
		yansema = ""
	end
	
	return yansema
end

function InstituteUI:on_updata_pyvalue()
    local data = g_dataCenter.Institute:GetData(self.currentIndex)
    
    local Maxvalue = self:comput_atk_power()
    if data.atk_power + data.atk_power_ex >= Maxvalue then
	   self.AttrMax:set_active(true)
    else
	   self.AttrMax:set_active(false)
    	local yansema = self:getyansema(data.atk_power_ex)
    	if yansema ~= "" then
    		self.AttrupText:set_text(yansema..tostring(PublicFunc.AttrInteger(data.atk_power_ex)).."[-]")
    	else
    		self.AttrupText:set_text(tostring(PublicFunc.AttrInteger(data.atk_power_ex)))
    	end
    end
    
    local Maxvalue =  self:comput_def_power()
    
    if data.def_power + data.def_power_ex >= Maxvalue then
	   self.DefMax:set_active(true)
    else
    	self.DefMax:set_active(false)
    	local yansema = self:getyansema(data.def_power_ex)
    	if yansema ~= "" then
            self.DefupText:set_text(yansema..tostring(PublicFunc.AttrInteger(data.def_power_ex)).."[-]")
    	else
            self.DefupText:set_text(tostring(PublicFunc.AttrInteger(data.def_power_ex)))
    	end
    end
    
    local Maxvalue =  self:comput_max_hp()
    if data.max_hp + data.max_hp_ex >= Maxvalue then
	   self.VitalMax:set_active(true)
    else
    	self.VitalMax:set_active(false)
    	local yansema = self:getyansema(data.max_hp_ex)
    	if yansema ~= "" then
            self.VitalupText:set_text(yansema..tostring(PublicFunc.AttrInteger(data.max_hp_ex)).."[-]")
    	else
            self.VitalupText:set_text(tostring(PublicFunc.AttrInteger(data.max_hp_ex)))
    	end
    end
    
    local valuelist = {};
    local valueMaxlist = {};
    for k,v in pairs(self.pyvaluelist)do
        --app.log("###############################")
		if v == "crit_rate" then
			table.insert(valuelist,data.crit_rate_ex)
			local Maxvalue = self:comput_crit_rate()
			table.insert(valueMaxlist,{"crit_rate" , Maxvalue})
		elseif v ==  "anti_crite" then
			table.insert(valuelist,data.anti_crite_ex)
			local Maxvalue = self:comput_anti_crite()
			table.insert(valueMaxlist,{"anti_crite" , Maxvalue})
		elseif v ==  "crit_hurt" then
			table.insert(valuelist,data.crit_hurt_ex)
			local Maxvalue = self:comput_crit_hurt()
			table.insert(valueMaxlist,{"crit_hurt" , Maxvalue})
		elseif v ==  "broken_rate" then
			table.insert(valuelist,data.broken_rate_ex)
			local Maxvalue = self:comput_broken_rate()
			table.insert(valueMaxlist,{"broken_rate" , Maxvalue})
		elseif v ==  "parry_rate" then
			table.insert(valuelist,data.parry_rate_ex)
			local Maxvalue = self:comput_parry_rate()
			table.insert(valueMaxlist,{"parry_rate" , Maxvalue})
		elseif v ==  "parry_plus" then
			table.insert(valuelist,data.parry_plus_ex)
			local Maxvalue = self:comput_parry_plus()
			table.insert(valueMaxlist,{"parry_plus" , Maxvalue})
		end
    end
    
	local yansema = self:getyansema(valuelist[1])
	if yansema ~= "" then
        self.ContrupText:set_text(yansema..tostring(PublicFunc.AttrInteger(valuelist[1])).."[-]")
	else
        self.ContrupText:set_text(tostring(PublicFunc.AttrInteger(valuelist[1])))
	end
	
	local yansema = self:getyansema(valuelist[2])
	if yansema ~= "" then
        self.MianKupText:set_text(yansema..tostring(PublicFunc.AttrInteger(valuelist[2])).."[-]")
	else
        self.MianKupText:set_text(tostring(PublicFunc.AttrInteger(valuelist[2])))
	end
        self:IsShowMax(valueMaxlist)
    
    if data.atk_power_ex >=0 and data.def_power_ex >= 0 and data.max_hp_ex >= 0 and valuelist[1]>= 0 and valuelist[2] >=0 then
		self.IsCanceBtn = false
    else
		self.IsCanceBtn = true
    end
    
    self:showSaveBtn()
    self:setyjdvalue()
end

function InstituteUI:IsShowMax(valueMaxlist)
	local data = g_dataCenter.Institute:GetData(self.currentIndex)   
	if valueMaxlist[1][1] == "crit_rate" then
		if data.crit_rate + data.crit_rate_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end      
	elseif valueMaxlist[1][1] == "anti_crite" then
		if data.anti_crite + data.anti_crite_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end          
	elseif valueMaxlist[1][1] == "crit_hurt" then
		if data.crit_hurt + data.crit_hurt_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end          
	elseif valueMaxlist[1][1] == "broken_rate" then
		if data.broken_rate + data.broken_rate_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end        
	elseif valueMaxlist[1][1] == "parry_rate" then
		if data.parry_rate + data.parry_rate_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end        
	elseif valueMaxlist[1][1] == "parry_plus" then                
		if data.parry_plus + data.parry_plus_ex >= valueMaxlist[1][2] then
			self.ContrMax:set_active(true)
			self.ContrupText:set_text("")
		else
			self.ContrMax:set_active(false)
		end         
	end
        
	if valueMaxlist[2][1] == "crit_rate" then
		if data.crit_rate + data.crit_rate_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end      
	elseif valueMaxlist[2][1] == "anti_crite" then
		if data.anti_crite + data.anti_crite_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end          
	elseif valueMaxlist[2][1] == "crit_hurt" then
		if data.crit_hurt + data.crit_hurt_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end          
	elseif valueMaxlist[2][1] == "broken_rate" then
		if data.broken_rate + data.broken_rate_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end        
	elseif valueMaxlist[2][1] == "parry_rate" then
		if data.parry_rate + data.parry_rate_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end        
	elseif valueMaxlist[2][1] == "parry_plus" then                
		if data.parry_plus + data.parry_plus_ex >= valueMaxlist[2][2] then
			self.MianKMax:set_active(true)
			self.MianKupText:set_text("")
		else
			self.MianKMax:set_active(false)
		end         
	end             
end

function InstituteUI:on_updata_save()
    self.instituteData = g_dataCenter.Institute:GetData(self.currentIndex)

    self.AttrupText:set_text("")
    self.DefupText:set_text("")
    self.VitalupText:set_text("")
    self.ContrupText:set_text("")
    self.MianKupText:set_text("")
    self:showPyBtn()

    self:updatapyvalue()
    
    -- self.AttrMax:set_active(false)
    -- self.DefMax:set_active(false)
    -- self.VitalMax:set_active(false)
    -- self.ContrMax:set_active(false)
    -- self.MianKMax:set_active(false)
end

function InstituteUI:on_clear_text()
   self.AttrupText:set_text("")
    self.DefupText:set_text("")
    self.VitalupText:set_text("")
    self.ContrupText:set_text("")
    self.MianKupText:set_text("")
    self:showPyBtn()
    
    self.AttrMax:set_active(false)
    self.DefMax:set_active(false)
    self.VitalMax:set_active(false)
    self.ContrMax:set_active(false)
    self.MianKMax:set_active(false)             
end

function InstituteUI:showPYUI()
        
    self.peiyangview:set_active(true);
    self.tiaojianview:set_active(false);
    self.jiesuowuqifx:set_active(true)

end

function InstituteUI:showTJUI()
    self.peiyangview:set_active(false);
    self.tiaojianview:set_active(true);
    self.jiesuowuqifx:set_active(false)
end

function InstituteUI:setyjdvalue()
    self:SetYJDNumber(g_dataCenter.package:GetCountByNumber(20000126))
end

function InstituteUI:getContentText( type,data )
    
    local text = ""
    
    if type == 1 then
	   text = data
    elseif type == 2 then
	   text = data   
    elseif type == 3 then
	   text = data
    elseif type == 4 then
    	--app.log("data is#################"..tostring(data))
    	text = ConfigManager.Get(EConfigIndex.t_hurdle,tonumber(data)).b
    elseif type == 5 then
	--text = ConfigManager.Get(EConfigIndex.t_equipment_rarity_0,tonumber(data)).describe
        text = PublicFunc.GetHeroRarityStrnocolor(tonumber(data))
        --app.log("#####text #########"..tostring(text))
        --text = data
    elseif type == 6 then
        text = data
    end

    return text
end

function InstituteUI:loadTJText()
    local TiaojianData = ConfigManager.Get(EConfigIndex.t_yanjiusuo,self.currentIndex)
    local TiaojianList = TiaojianData.unlock
    local data = g_dataCenter.Institute:GetData(self.currentIndex).vecUnlockInfo
    --app.log("data #################"..table.tostring(data))
    --1战队等级达到X 2关卡得星数为X 3拥有角色数量X个 4完成关卡X 5拥有X个X品质角色 6拥有X个角色达到X星
    for k,v in pairs(TiaojianList)do
    	local TiaojianInfoData = ConfigManager.Get(EConfigIndex.t_yanjiusuo_unlock,v)
    	
    	local TiaojianInfoNumb1 = "";--TiaojianInfoData.param1;--TiaojianInfoData.conditional_value
    	local TiaojianInfoNumb2 = "";--TiaojianInfoData.param2;
        	
    	local temptext = "";
    	local TiaojianInfoText = "";
    	if TiaojianInfoNumb1 then
    	    
    	    if TiaojianInfoData.unlock_type == 5 then
    		  TiaojianInfoNumb1 = TiaojianInfoData.param1;
    	    else
    		  TiaojianInfoNumb1 = self:getContentText(TiaojianInfoData.unlock_type,TiaojianInfoData.param1);--TiaojianInfoData.conditional_value
    	    end
    	    
    	    temptext = string.gsub(TiaojianInfoData.content,"#param1",TiaojianInfoNumb1)
    	    
    	    if TiaojianInfoNumb2 then
        		if TiaojianInfoData.unlock_type == 4 then
        		    TiaojianInfoNumb2 = TiaojianInfoData.param2;
        		else
        		    TiaojianInfoNumb2 = self:getContentText(TiaojianInfoData.unlock_type,TiaojianInfoData.param2);
        		end
        		TiaojianInfoText = string.gsub(temptext,"#param2",TiaojianInfoNumb2)
    	    else
    		  TiaojianInfoText = temptext
    	    end
    	end
	   
    	if self.Tlist[k] then
            if data[k].bUnlock then
                self.Tlist[k].labName:set_text("[5aff00]"..TiaojianInfoText.."[-]")
            else
                self.Tlist[k].labName:set_text(TiaojianInfoText)
            end

    	    if TiaojianInfoData.unlock_type == 4 then
                self.Tlist[k].labNumb:set_text("")
    	    else
                self.Tlist[k].labNumb:set_text("0/"..tostring(TiaojianInfoNumb1))
    	    end
    	end
    end
end

function InstituteUI:updataTJItem()
    
    local data = g_dataCenter.Institute:GetData(self.currentIndex).vecUnlockInfo
    local TiaojianData = ConfigManager.Get(EConfigIndex.t_yanjiusuo,self.currentIndex)
    local TiaojianList = TiaojianData.unlock
    
    for k,v in pairs(TiaojianList)do
    	local TiaojianInfoData = ConfigManager.Get(EConfigIndex.t_yanjiusuo_unlock,v)    
    	local TiaojianInfoNumb1 = TiaojianInfoData.param1;--TiaojianInfoData.conditional_value
    	local TiaojianInfoNumb2 = TiaojianInfoData.param2;
    	
    	if self.Tlist[k] then
    	    --self.Tlist[k].labName:set_text(TiaojianInfoText)
    	    if TiaojianInfoData.unlock_type == 4 then
    		  self.Tlist[k].labNumb:set_text("")
    	    else
    		  self.Tlist[k].labNumb:set_text(tostring(data[k].curStep).."/"..tostring(TiaojianInfoNumb1))
    	    end
    	    
    	    if data[k].bUnlock then
        		self.Tlist[k].IsSuc:set_active(true)
        		self.Tlist[k].suo:set_active(true)
                        self.Tlist[k].labNumb:set_active(false)
        		--local text = self.Tlist[k].labName:set_color()
    	    else
        		self.Tlist[k].IsSuc:set_active(false)
        		self.Tlist[k].suo:set_active(false)
                self.Tlist[k].labNumb:set_active(true)
    	    end
    	end
    end
end

function InstituteUI:UpdataItemList()
    
    
end

function InstituteUI:on_click_Open_button()
    
    
    
    local data = g_dataCenter.Institute:GetData(self.currentIndex)
    
    if data.isUnLock then
	   self.IsUnlockBtn = true
    else
	   self.IsUnlockBtn = false
    end
    
    ----app.log("data ##############"..table.tostring(data))
    
    local flag = true;

    for k,v in pairs( data.vecUnlockInfo )do
        if v.bUnlock == false then
            flag = false;
            break;
        end
    end
    
    if flag then
    	self.peiyangview:set_active(true)
    	self.tiaojianview:set_active(false)
    	msg_laboratory.cg_unLock_laboratory(self.currentIndex)
        self.beginfx:set_active(false)
        self.beginfx:set_active(true)
    else
	   FloatTip.Float("解锁条件未达成！");
    end
end

function InstituteUI:SetYJDNumber(value)
    self.yjdnumb:set_text(tostring(value))
end

function InstituteUI:SetItemName(txt)
    self.title:set_text(txt) 
end

--始初化底部列表
function InstituteUI:on_init_item(obj, b, real_index)
    --app.log("##########################################")
    local index = math.abs(real_index)+1;
    --app.log("real_index ################"..tostring(index))
    local index = math.abs(real_index)+1;
    
    if self.itemlist[index] then
    	--app.log("self.itemid ################"..tostring(self.itemlist[index].yjs_id))
    	local card_prop = CardProp:new({number = self.itemlist[index].yjs_id,count = 1});
        --app.log("card_prop ##########"..table.tostring(card_prop))
    	self.itemlistobj[index]= {};
    	self.itemlistobj[index].root = obj;
    	self.itemlistobj[index].card =  UiSmallItem:new({parent = obj, cardInfo = card_prop});--,
        self.itemlistobj[index].card:SetLabNum(false);
        --stypes = {SmallCardUi.SType.Texture,}})
    	--self.itemlistobj[index].card:SetData(self.itemlist[index])
        self.itemlistobj[index].mark = ngui.find_sprite(obj,"sp_mark")
    	self.itemlistobj[index].suo1 = ngui.find_sprite(obj,"sp_mark/sp_suo");
        self.itemlistobj[index].suo = obj:get_child_by_name("sp_mark/sp_wenhao")
        self.itemlistobj[index].kuang = obj:get_child_by_name("sp_yeqian1")
        self.itemlistobj[index].kuang:set_active(false)
        self.itemlistobj[index].suo1:set_active(false)
        self.itemlistobj[index].di = obj:get_child_by_name("small_item_ui/sp_frame")
        self.itemlistobj[index].di:set_active(false)
        self.itemlistobj[index].icon = obj:get_child_by_name("small_item_ui/icon")
        self.itemlistobj[index].icon:set_active(false)
                    
        self.itemlistobj[index].chosebutton = ngui.find_sprite(obj,"sp_back1")
            
        --app.log("yjs_id#############"..tostring(self.itemlist[index].yjs_id))
        --app.log("index##############"..tostring(index))
        --app.log("objName#############"..tostring(obj:get_name()))
        
        --self.itemlistobj[index].chosebutton:reset_on_click()        
        self.itemlistobj[index].chosebutton:set_on_ngui_click(self.bindfunc["on_chose_item"])
        local datavalue = tostring(index)..";"..tostring(self.itemlist[index].yjs_id)
        self.itemlistobj[index].chosebutton:set_event_value(datavalue)
        --app.log("index#############"..tostring(index))
            
            
    	--self.itemlistobj[index].card:ClearOnClicked()
    	--self.itemlistobj[index].card:SetOnClicked(self.bindfunc["on_chose_item"],tostring(index),self.itemlist[index].yjs_id);
    	self.itemlistobj[index].card:SetIsOnPress(false)
    	if index == 1 then
            self.currentItem = obj
            --local yeka2 = ngui.find_sprite(self.currentItem,"sp_yeqian2")
            --yeka2:set_active(false)
            --local sp_mark = ngui.find_sprite(self.currentItem,"sp_mark")
            --sp_mark:set_active(false)
            local yeka1 = ngui.find_sprite(self.currentItem,"sp_shine")
            yeka1:set_active(true)
    	    --self.itemlistobj[index].card:SetShine(true)
    	    --self.itemlistobj[index].card:ChoseItem(true)
    	else
            local yeka1 = ngui.find_sprite(obj,"sp_shine")
            yeka1:set_active(false)
        end
	
    end
end

function InstituteUI:set_toggle_data(value)
    if value == 1 then
        self.chujiBtn:set_value(true)
        self.zhongjiBtn:set_value(false)
        --self.gaojiBtn:set_value(false)            
    elseif value == 2 then
        self.chujiBtn:set_value(false)
        self.zhongjiBtn:set_value(true)
        --self.gaojiBtn:set_value(false)     
    -- elseif value == 2 then
    --     self.chujiBtn:set_value(false)
    --     self.zhongjiBtn:set_value(false)
        --self.gaojiBtn:set_value(true)     
    end
end

function InstituteUI:on_toggle_change( value,name )
    --app.log("value is ###############"..tostring(value).."name is ############### "..name)
    
    if name == "yeka1" and value == true then
    	--app.log("11111111111111111111111111111111111111111111111111")
    	self.typelvl = 2;
	
    elseif name == "yeka2" and value == true then
    	--app.log("22222222222222222222222222222222222222222222222222")
    	self.typelvl = 3;
	
    -- elseif name == "yeka3" and value == true then
    -- 	--app.log("33333333333333333333333333333333333333333333333333")
    -- 	self.typelvl = 3;
	
    end
    
   
    self:setXiaoHaoText(self.typelvl)
    
end

--设置培养等级文字
function InstituteUI:setXiaoHaoText(lvl)
    
    --app.log("setXiaoHaoText IS ############### "..table.tostring(self.itemlist[self.currentIndex]))
    
    self.texture1:clear_texture()
    self.texture2:clear_texture()
    
    
    if lvl == 1 then

        self.jiandancastui:set_active(true)
        self.fuzhacastui:set_active(false)

        local yanjiudianicon = ConfigManager.Get(EConfigIndex.t_item,20000126).small_icon
    	self.texture1:set_texture(yanjiudianicon)
        self.chujicasttexture:set_texture(yanjiudianicon)
    	--self.texturebg2:set_active(false)
    	--self.texture2:set_texture("assetbundles/prefabs/ui/image/icon/equip_item/80_80/yanjiudian.assetbundle")
    	local numb = self.itemlist[self.currentIndex].primary_cost[1].num
    	self.pycailiaonumb1:set_text(tostring(numb))
        self.chujicastlab:set_text(tostring(numb))
    	self.pycailiaonumb2:set_text("")
    elseif lvl == 2 then

        self.jiandancastui:set_active(false)
        self.fuzhacastui:set_active(true)

        local yanjiudianicon = ConfigManager.Get(EConfigIndex.t_item,20000126).small_icon
        local jingbiicon = ConfigManager.Get(EConfigIndex.t_item,2).small_icon
    	self.texture2:set_texture(jingbiicon)
    	self.texture1:set_texture(yanjiudianicon)
    	--self.texturebg2:set_active(true)
    	local numb1 = self.itemlist[self.currentIndex].intermediate_cost[1].num
    	local numb2 = self.itemlist[self.currentIndex].intermediate_cost[2].num
    	self.pycailiaonumb1:set_text(tostring(numb1))
    	self.pycailiaonumb2:set_text(tostring(numb2))
    elseif lvl == 3 then

        self.jiandancastui:set_active(false)
        self.fuzhacastui:set_active(true)

        local yanjiudianicon = ConfigManager.Get(EConfigIndex.t_item,20000126).small_icon
        local hongshuijinicon = ConfigManager.Get(EConfigIndex.t_item,3).small_icon
    	self.texture2:set_texture(hongshuijinicon)
    	self.texture1:set_texture(yanjiudianicon)
    	--self.texturebg2:set_active(true)
    	local numb1 = self.itemlist[self.currentIndex].advanced_cost[1].num
    	local numb2 = self.itemlist[self.currentIndex].advanced_cost[2].num
    	
    	self.pycailiaonumb1:set_text(tostring(numb1))
    	self.pycailiaonumb2:set_text(tostring(numb2))
    end
    
    
end

--[[]]
--绑定神器到UI 节点
function InstituteUI:InitBoundUI( )
    
--    if self.Boundui[self.currentIndex] then
--	self.Boundui[self.currentIndex]:set_active(true)
--    else
    self.sqrq:set_texture(self.itemlist[self.currentIndex].bigicon)
	--self.Boundui[self.currentIndex] = --asset_game_object.create(asset_obj);
	--self.Boundui[self.currentIndex]:set_name("bound_UI"..self.currentIndex);
	--self.Boundui[self.currentIndex]:set_parent(self.sqrq);
	--self.Boundui[self.currentIndex]:set_local_position(0,0,0);
	--self.Boundui[self.currentIndex]:set_local_scale(1,1,1);
--    end
                
    self.currentBoundindex = self.currentIndex
    --app.log("InitBoundUI IS ############### "..tostring(self.currentIndex))centre_other/animation/cont_weijihuo/cont/ring1/sp_suo
    --神器结点
    self.line = {};
    self.jiesuofx = {};
    for i =1 ,5 do
    	self.ring[i] = {};
    	self.ring[i].root = self.ui:get_child_by_name("centre_other/animation/cont_weijihuo/cont/ring"..i)
    	self.ring[i].suo = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont/ring"..i.."/sp_suo")
    	self.ring[i].open = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont/ring"..i.."/sp_frame")
    	self.ring[i].suo:set_active(true)
        self.line[i] = ngui.find_sprite(self.ui,"centre_other/animation/cont_weijihuo/cont/sp_line"..i)
        self.jiesuofx[i] = self.ui:get_child_by_name("centre_other/animation/cont_weijihuo/cont/ring"..i.."/fx_ui_4501_gift_jiesuo")
        self.jiesuofx[i]:set_active(false)
    end
    
    --app.log("###################"..table.tostring(g_dataCenter.Institute:GetData(self.currentIndex)))
    --if self.instituteData then
    
    local data = g_dataCenter.Institute:GetData(self.currentIndex)
    
    --self.bUnlockinfo = {}
    
    if data then
        local UnlockInfo = data.vecUnlockInfo
        if UnlockInfo then
            for k,v in pairs(UnlockInfo)do
                if v.bUnlock then
                    --app.log("unlockid is###############"..tostring(v.unlockid))
                    self:SetOpenSQJD(k)
                else
                    self:SetCloseSQJD(k)           
                end
                
            end
        end
    end
    
    
    self:setTitle(self.itemlist[self.currentIndex].yjs_id)
    self:setLine() 
end

function InstituteUI:setLine()
                
    local data = g_dataCenter.Institute:GetData(self.currentIndex)

    self.bUnlockinfo = {}
    
    if data then
        local UnlockInfo = data.vecUnlockInfo
        if UnlockInfo then
            for k,v in pairs(UnlockInfo)do
                self.bUnlockinfo[k] = v.bUnlock                               
            end
        end
    end
    
    if self.bUnlockinfo[1] == true and self.bUnlockinfo[2] == true then
        self.line[1]:set_sprite_name("yjs_xian2")
    else
        self.line[1]:set_sprite_name("yjs_xian1")     
    end
    
    if self.bUnlockinfo[2] == true and self.bUnlockinfo[3] == true then
        self.line[2]:set_sprite_name("yjs_xian2")
    else
        self.line[2]:set_sprite_name("yjs_xian1")     
    end
    
    if self.bUnlockinfo[3] == true and self.bUnlockinfo[4] == true then
        self.line[3]:set_sprite_name("yjs_xian2")
    else
        self.line[3]:set_sprite_name("yjs_xian1")     
    end
    
    if self.bUnlockinfo[4] == true and self.bUnlockinfo[5] == true then
        self.line[4]:set_sprite_name("yjs_xian2")
    else
        self.line[4]:set_sprite_name("yjs_xian1")     
    end
    
    if self.bUnlockinfo[1] == true and self.bUnlockinfo[5] == true then
        self.line[5]:set_sprite_name("yjs_xian2")
    else
        self.line[5]:set_sprite_name("yjs_xian1")     
    end
   
end

--打开神器锁
function InstituteUI:OpenItem(index)
    --app.log("OpenItem##############################"..table.tostring(self.itemlistobj))
    if self.itemlistobj[index] then
    	if self.itemlistobj[index].suo then
    	   self.itemlistobj[index].suo:set_active(false)
    	end
            
        if self.itemlistobj[index].icon then
           self.itemlistobj[index].icon:set_active(true)            
        end        
            
        if self.itemlistobj[index].suo1 then
           self.itemlistobj[index].suo1:set_active(false) 
    	end

        if self.itemlistobj[index].mark then
            self.itemlistobj[index].mark:set_active(false)
        end

    end
end

--打开结点锁
function InstituteUI:SetOpenSQJD(index)
    local id = "co"..UserCenter.get_accountid().."_"..tostring(self.currentIndex)
    --app.log("self.local_play_fx_list----"..table.tostring(self.local_play_fx_list))
    if self.ring[index] then
    	self.ring[index].suo:set_active(false)
    	self.ring[index].open:set_active(true)
        if self.local_play_fx_list[id] then
            local flag = true
            for k,v in pairs(self.local_play_fx_list[id]) do
                if v.tiaojianid == index then
                    flag = false;
                    break;
                end
            end

            if flag then
                 --app.log("show2222222222222222222")
                self.jiesuofx[index]:set_active(true)
            end
        else
            --app.log("show11111111111111111111111")
            self.jiesuofx[index]:set_active(true)
        end

        self:on_save_unlock_state(index)
        --self:set_jiedianpic(index,false)
    end
end

function InstituteUI:SetCloseSQJD(index)
    if self.ring[index] then
    	self.ring[index].suo:set_active(true)
    	self.ring[index].open:set_active(false)
        self.jiesuofx[index]:set_active(false)
        --self:set_jiedianpic(index,true)
    end
end

function InstituteUI:set_jiedianpic(index,flag)
    if flag == true then
        self.ring[index].open:set_sprite_name("yjs_jiesuo"..tostring(index))        
    else
        self.ring[index].open:set_sprite_name("yjs_jiesuo"..tostring(index))         
    end
end

function InstituteUI:on_next_button(t)
    FloatTip.Float("没有更多的神器");
end

function InstituteUI:on_last_button(t)
    FloatTip.Float("没有更多的神器");
end

--存本地解锁条件特效播放
function InstituteUI:on_save_unlock_state(index)
    local id = "co"..UserCenter.get_accountid().."_"..tostring(self.currentIndex)
    if self.local_play_fx_list[id] then
        local flag = false;
        for k,v in pairs(self.local_play_fx_list[id]) do
            if v.tiaojianid == index then
                flag = true
                break;
            end
        end 

        if not flag then
            table.insert(self.local_play_fx_list[id],{tiaojianid = index})
            self:write_file()
        end
    else
        self.local_play_fx_list[id] = {}
        table.insert(self.local_play_fx_list[id],{tiaojianid = index})
        self:write_file()
    end

end

--读取解锁条件特效是否播放
function InstituteUI:on_get_unlock_state()
    local file_handler = file.open_read(self.local_file_name);
    if file_handler then
        local aaa = file_handler:read_all_text()
        if aaa ~= "" then
            local k = loadstring(aaa);
            if k ~= nil then
                self.local_play_fx_list = k() or false
            end
        end
        file_handler:close();
    end
end

function InstituteUI:write_file()

    local file_handler = file.open(self.local_file_name,4);
    if file_handler then
        file_handler:write_string(table.tostringEx(self.local_play_fx_list));
        file_handler:close();
    end

end
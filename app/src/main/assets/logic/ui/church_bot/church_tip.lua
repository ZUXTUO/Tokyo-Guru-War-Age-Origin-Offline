
ChurchBotTip = Class("ChurchBotTip", UiBaseClass)

function ChurchBotTip:GetNavigationAdvPlane()
    return true;
end

function ChurchBotTip:ShowNavigationBar()
    return true
end


-- type = 1 查找,2, 收取资源 3
function ChurchBotTip:Init(data)
    --app.log("23222222222222222"..tostring(data))
    
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1606_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
    
    
end

function ChurchBotTip:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotTip:InitData(data)
    --app.log("data==================================="..tostring(data))
    self.currentindex = data
    self.isShow = false;
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotTip:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotTip:DestroyUi()

    g_dataCenter.ChurchBot:setFinishUI(false)  

    Show3d.Destroy()
    --self.kldicon:DestroyUi()
    
    for k,v in pairs(self.team1) do
	v:DestroyUi()
    end
    
    for k,v in pairs(self.team2) do
	v:DestroyUi()
    end
    
    UiBaseClass.DestroyUi(self);

end

function ChurchBotTip:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_begin"] = Utility.bind_callback(self, self.on_begin)
    self.bindfunc["on_rest"] = Utility.bind_callback(self, self.on_rest)
    self.bindfunc["on_setFindData"] = Utility.bind_callback(self, self.on_setFindData)
    --self.bindfunc["on_show_battlelist"] = Utility.bind_callback(self, self.on_show_battlelist)
    self.bindfunc["OnPressTips"] = Utility.bind_callback(self, self.OnPressTips)
    self.bindfunc["setData"] = Utility.bind_callback(self, self.setData)
    
end


--注册消息分发回调函数
function ChurchBotTip:MsgRegist()
    UiBaseClass.MsgRegist(self);
    -- PublicFunc.msg_regist(msg_activity.gc_look_for_rival, self.bindfunc["setData"])
end

--注销消息分发回调函数
function ChurchBotTip:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    -- PublicFunc.msg_unregist(msg_activity.gc_look_for_rival, self.bindfunc["setData"])
    
end

function ChurchBotTip:getIsShow()
    return self.isShow
end

--初始化UI
function ChurchBotTip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotTip');
    
    --self.con1 = self.ui:get_child_by_name("centre_other/animation/cont1")
    --self.glodicon = ngui.find_sprite(self.ui,"centre_other/animation/cont1/sp_gold")
    --self.speedtext = ngui.find_label(self.ui,"centre_other/animation/cont1/sp_di1/txt1/lab_num")
    --self.alltext = ngui.find_label(self.ui,"centre_other/animation/cont2/sp_di1/txt2/lab_num")
    --self.timetext = ngui.find_label(self.ui,"centre_other/animation/cont2/sp_di1/txt3/lab_num")
    --合并成一个UI后 左右按钮需要隐藏
    --self.leftbtn = ngui.find_button(self.ui,"centre_other/animation/btn_left_arrows")
    --self.leftbtn:set_on_click(self.bindfunc['on_btn_left'])
    --self.leftbtn:set_active(false)
    
    --self.rightbtn = ngui.find_button(self.ui,"centre_other/animation/btn_right_arrows")
    --self.rightbtn:set_on_click(self.bindfunc['on_btn_right'])
    --self.rightbtn:set_active(false)
    --下面的 页点需要隐藏
    --self.bottomicon = {};
    --for i=1,4 do
	--self.bottomicon[i] = self.ui:get_child_by_name("down_other/animation/sp_di_down/qiye"..i)
	--self.bottomicon[i]:set_active(false) 
    --end
    
    --self.findUI = self.ui:get_child_by_name("centre_other/animation/content1")
    --self.findUI:set_active(false)
    --主界面才会用到 这点隐藏
    self.maincont2 = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di1/cont2")
    self.maincont2:set_active(false)
    
    self.downcont2 = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont2")
    self.downcont2:set_active(false)
    
    --收取资源
    self.getBtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont2/btn3")
    self.getBtn:set_active(false)
    
    self.sp_art_font_vip = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont1/sp_art_font")
    self.sp_art_font_vip:set_active(false)

    --self.battlelist = ngui.find_button(self.ui,"centre_other/animation/btn_zhan_bao")
    --self.battlelist:set_on_click(self.bindfunc['on_show_battlelist'])
    
    self.con2 = self.ui:get_child_by_name("centre_other/animation/sp_di1")
    self.titletext = ngui.find_label(self.ui,"centre_other/animation/sp_di1/txt1")
    self.con2glodtext = ngui.find_label(self.ui,"centre_other/animation/sp_di1/txt1/lab_num")
    
    self.con3 = self.ui:get_child_by_name("centre_other/animation/sp_di2")
    self.lab_name = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_name")
    self.lvl = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_dengji")
    self.quyu = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_quyu")
    self.powervalue = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/sp_fight/lab_fight")
    self.team1 = {}
    self.team2 = {}
    
    for i=1,3 do
    	local team1 = {}
    	local team2 = {}
    	team1[i] = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_duiwu2/new_small_card_item"..i)
    	--self.team1[i] = self.ui:get_child_by_name("centre_other/animation/sp_di2/lab_duiwu1/new_small_card_item"..i)
    	team2[i] = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_duiwu1/new_small_card_item"..i)
    	
    	self.team1[i] = SmallCardUi:new({parent = team1[i],
    		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
    	
    	self.team2[i] = SmallCardUi:new({parent = team2[i],
    		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
    end
    
    self.toptitel = ngui.find_label(self.ui,"centre_other/animation/sp_bar/lab_level1")
    self.sp_bar_sprite = ngui.find_sprite(self.ui,"centre_other/animation/sp_bar")
    
    self.restbtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/btn1")
    self.restbtn:set_on_click(self.bindfunc['on_rest'])
    
    self.beginbtn = ngui.find_button(self.ui,"content2/right_other/animation/sp_di2/cont1/btn2")
    self.beginbtn:set_on_click(self.bindfunc['on_begin'])
    self.beginbtn:set_active(false)
    
    --self.souqubtn = ngui.find_button(self.ui,"centre_other/animation/btn3")
    
    self.sp_human = ngui.find_sprite(self.ui,"center_other/animation/content2/sp_human")
    
    self.kldlab = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/lab_num")
    
    --local kldicon1 = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/new_small_card_item")
    self.kldicon = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/sp_kuang1")--UiSmallItem:new({parent = kldicon1,cardInfo = nil});
    --self.kldiconbtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/sp_kuang")
    --self.kldiconbtn:set_on_ngui_press(self.bindfunc['OnPressTips'])
    
    self.kldicon1 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/sp_kuang2")
    self.kldicon1:set_active(false)
    self.kldlab1 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt2/sp_kuang2/lab_num")
    --占领后奖励
    self.zhanlingtxt1 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt3/sp_kuang1/lab_num")
    self.zhanlingpic1 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt3/sp_kuang1")

    self.zhanlingtxt2 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt3/sp_kuang2/lab_num")
    self.zhanlingpic2 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt3/sp_kuang2")

    -------------
    self.findnamelab = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont1/txt1")
    
    g_dataCenter.ChurchBot:setFinishUI(true)    

    local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    local nStar =  g_dataCenter.ChurchBot:getnstar()

    --app.log("cg_look_for_rival==========================="..tostring(nStar))   
    self:on_setFindData()
    --msg_activity.cg_look_for_rival(nStar,myprayIndex)
    ChurchBotLoad.Destroy()
end

function ChurchBotTip:bound3d()
    local data = 
    {
        roleData = CardHuman:new({number=self.targPlayerGid, isNotCalProperty = true});
        role3d_ui_touch = self.sp_human,
        type = "left",
    }   
    Show3d.SetAndShow(data)
end

function ChurchBotTip:setData()
    self:on_setFindData()
end

function ChurchBotTip:on_setFindData()
    
    --app.log("2222222222222222222222222222")
    self.beginbtn:set_active(true)
    local findData = g_dataCenter.ChurchBot:getFindRoleData()
    
    --local temp = ChurchBot:getFindRoleData()
    --app.log("##################################"..table.tostring(temp.vecRoleDataTeam1))
    --app.log("##################################"..table.tostring(temp.vecRoleDataTeam2))
    
    if findData then
	--app.log("findData##########"..table.tostring(findData))
	self.targPlayerGid = findData.playerNumber
	if self.targPlayerGid > 0 then
	    self:bound3d()
	    Show3d.SetVisible(true)
	end
	
	self:computResources(findData)
	self:setUiData(findData)
    end
    
end

function ChurchBotTip:setUiData(findData)
    
    local tarLvl = findData.playerLevel
    local posIndex = findData.posIndex
    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    local Lvl = ""
    
    --app.log("nStar#####################"..tostring(nStar))
    
    if nStar == 1 then
	Lvl = "贫困区"
	self.sp_bar_sprite:set_sprite_name("ld_xindiantu1")
    elseif nStar == 2 then
	Lvl = "普通区"
	self.sp_bar_sprite:set_sprite_name("ld_xindiantu2")
    elseif nStar == 3 then
	Lvl = "富人区"
	self.sp_bar_sprite:set_sprite_name("ld_xindiantu3")
    end
    
    local team1= findData.vecRoleDataTeam1
    local team2 = findData.vecRoleDataTeam2
    
    --app.log("team1###############"..table.tostring(team1))

    local FightValue = 0;
    for k,v in pairs(team1) do
	FightValue = FightValue + v.fight_value    
    end
    
    for k,v in pairs( team2 ) do
	FightValue = FightValue + v.fight_value   
    end
    
    --app.log("FightValue#############"..tostring(FightValue))
    
    self.toptitel:set_text(Lvl)
    self.lvl:set_text("等级："..tostring(tarLvl))
    local country_name = ConfigManager.Get(EConfigIndex.t_country_info,findData.countryid).name
    self.quyu:set_text("区域："..tostring(country_name))
    self.powervalue:set_text(tostring(FightValue))
    self.lab_name:set_text(findData.szPlayerName)
    self.findnamelab:set_text("[22BEE8FF]该区域已被[-][FFDC49FF]"..findData.szPlayerName.."[-][22BEE8FF]占领[-]")
        
    self:setTeamInfo(team1,team2)

end

function ChurchBotTip:setTeamInfo(team1,team2)
    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    for i=1,3 do
	self.team1[i]:SetData(nil)
	self.team2[i]:SetData(nil)
    end
    
    
    if nStar > 2 then --3星可以添加2支队伍
	self:setTeam1(team1)
	self:setTeam2(team2)
    else
	self:setTeam1(team1)
    end
end

function ChurchBotTip:setTeam1(info)
    --app.log("vecRoleDataTeam1##########"..table.tostring(info))
    for k,v in pairs(info) do
	local cardhum = CardHuman:new(v)
	self.team2[k]:SetData(cardhum)   
    end
end

function ChurchBotTip:setTeam2(info)
    --app.log("vecRoleDataTeam2##########"..table.tostring(info))
    for k,v in pairs(info) do
	local cardhum = CardHuman:new(v)
	self.team1[k]:SetData(cardhum)   
    end
end

function ChurchBotTip:on_begin()
    --uiManager:PopUi();
    uiManager:PushUi(EUI.ChurchBotlineup);
end

--计算掠夺资源
function ChurchBotTip:computResources( findData )
    
    --改为固定奖励
    local nStar = g_dataCenter.ChurchBot:getnstar()
    app.log("nStar====================="..tostring(nStar))
    local church_rewardlist_data = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar);
    local rewardlistid = church_rewardlist_data.dropid
    app.log("rewardlistid=================="..tostring(rewardlistid))
    local droplist = ConfigManager.Get(EConfigIndex.t_drop_something,rewardlistid);
    app.log("droplist======================"..table.tostring(droplist))

    for k,v in pairs(droplist) do
        if k== 1 then
            self.kldlab:set_text(tostring(v.goods_number))
            local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
            self.kldicon:set_texture(itemicon)
        elseif k == 2 then
            self.kldlab1:set_text(tostring(v.goods_number))
            local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
            self.kldicon1:set_texture(itemicon)
            self.kldicon1:set_active(true)
        end
    end

    --do return end
    local tarLvl = findData.playerLevel
    local posIndex = findData.posIndex
    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    local church_pos_detail_data = ConfigManager.Get(EConfigIndex.t_church_pos_detail_data,nStar);
    
    local time = 0
    local itemid = 0
    local itemid1 = 0
    for k,v in pairs(church_pos_detail_data) do
	--app.log("posindex#################"..table.tostring(v.posIndex))
	if v.posIndex ==  posIndex then
	    itemid = v.resourceType1
	    --app.log("itemid#################"..tostring(itemid))
        itemid1 = v.resourceType2
	end
    end
    
    local xxname = "star"..tostring(nStar).."_resource"..tostring(itemid)
    --app.log("xxname#################"..xxname)
    --end
    
    local keyname = "resource_num_"..tostring(itemid)
    --app.log("keyname#################"..keyname)
    local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar)
    local keyid = keydata[keyname]
    --app.log("keyid#################"..tostring(keyid))
    
    self.itemid1 = keyid
    
    local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    self.zhanlingpic1:set_texture(itemicon)
    
    local level = g_dataCenter.player.level;
    local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
    local tdata = church_pos_data[xxname]
    
    --local time = findData.keepPrayTime
    --local cannumb = tdata*time/3600
    
    self.zhanlingtxt1:set_text(tostring(tdata).."/小时")

    --self.kldlab:set_text("11111")
    --self.itemcount = math.floor(cannumb/2)

    if itemid1 > 0 then
        local xxname = "star"..tostring(nStar).."_resource"..tostring(itemid1)
        --app.log("xxname#################"..xxname)
        --end
        
        local keyname = "resource_num_"..tostring(itemid1)
        --app.log("keyname#################"..keyname)
        local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar)
        local keyid = keydata[keyname]
        --app.log("keyid#################"..tostring(keyid))
        
        self.itemid2 = keyid
        
        local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
        self.zhanlingpic2:set_texture(itemicon)
        
        local level = g_dataCenter.player.level;
        local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
        local tdata = church_pos_data[xxname]
        
        --local time = findData.keepPrayTime
        --local cannumb = tdata*time/3600
        
        self.zhanlingtxt2:set_text(tostring(tdata).."/小时")

        --self.kldlab:set_text("11111")
        --self.itemcount1 = math.floor(cannumb/2)
        --self.kldicon1:set_active(true)
    end

end

function ChurchBotTip:OnPressTips(name, state, x, y, gameobj)
    
    --app.log("111111111111111111111111111111111")
    local cardInfo = nil;
    if self.itemid then
	if PropsEnum.IsEquip(self.itemid) then
	    cardInfo = CardEquipment:new( { number = self.itemid, count = 0});
	elseif PropsEnum.IsItem(self.itemid) or PropsEnum.IsVaria(self.itemid) then
	    cardInfo = CardProp:new( { number = self.itemid, count = 0 });
	elseif PropsEnum.IsRole(self.itemid) then
	    cardInfo = CardHuman:new( { number = self.itemid, count = 0 });
	end
    end
    
    if state == true then
	
	if cardInfo then
	    local worldX, worldY, worldZ = gameobj:get_position();
	    local uiCamera = Root.get_ui_camera();
	    local screenX,screenY = uiCamera:world_to_screen_point(worldX, worldY, worldZ);
	    local sizeX, sizeY = gameobj:get_box_collider_size();
	    --app.log("name="..tostring(gameobj:get_name()).." x="..tostring(screenX).." y="..tostring(screenY));
	    --默认都是上边缘
	    GoodsTips.EnableGoodsTips(true, cardInfo.number, cardInfo.count, screenX, screenY, sizeY, cardInfo.level, 1)
	end
    else
	GoodsTips.EnableGoodsTips(false)
    end
end


function ChurchBotTip:on_rest()
    
    local rest = function()
	--app.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
	--g_dataCenter.ChurchBot:setRestFind()
	local nStar = g_dataCenter.ChurchBot:getnstar()
	local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
	
	msg_activity.cg_look_for_rival(nStar,myprayIndex)
	--uiManager:PopUi();
    end
    
    local btn1 = {};
    btn1.str = "确定";
    btn1.func = rest
    
    local btn2 = {};
    btn2.str = "取消";
    
    local RefreshTimes = g_dataCenter.ChurchBot:getfindnumber()
    --app.log("RefreshTimes##########"..tostring(RefreshTimes))
    local CostMoneydata = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,RefreshTimes);
    --app.log("CostMoneydata##########"..tostring(CostMoneydata.cost))
    
    HintUI.SetAndShowHybrid(2, "重新寻找","本次重新寻找需花费：|item:2|"..tostring(CostMoneydata.cost)..".",nil,btn1,btn2);
end


function ChurchBotTip:on_select(t)
    
end

function ChurchBotTip:UpdateUi()
    
end

function ChurchBotTip:on_show_battlelist()
    uiManager:PushUi(EUI.ChurchBotBattleList);
end




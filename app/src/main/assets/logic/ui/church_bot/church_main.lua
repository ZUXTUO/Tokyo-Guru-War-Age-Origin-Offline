
ChurchBotMain = Class("ChurchBotMain", UiBaseClass)

function ChurchBotMain:GetNavigationAdvPlane()
    return true;
end

function ChurchBotMain:ShowNavigationBar()
    return true
end

function ChurchBotMain:Init(data)
    self.ChurchBotMain = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1606_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotMain:Restart(data)
    --self:bound3d()
    --app.log("Restart#########################"..tostring(data))
    if UiBaseClass.Restart(self, data) then
    	--app.log("Restart11111111111111111111")
    	self.currentpage = g_dataCenter.ChurchBot:getmyprayIndex()
    	--app.log("currentpage#############"..tostring(self.currentpage))
    end
end

function ChurchBotMain:InitData(data)
    --app.log("data==============="..tostring(data))
    --self.currentpage = data;
    UiBaseClass.InitData(self, data)

    self.UnlockList = ConfigManager._GetConfigTable(EConfigIndex.t_church_pray_open);
    self.VipUnlockList = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
    
    --self.church_pos_data = ConfigManager._GetConfigTable(EConfigIndex.t_church_pos_data);
    --self.church_pos_detail_data = ConfigManager._GetConfigTable(EConfigIndex.t_church_pos_data);
    
end

function ChurchBotMain:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotMain:DestroyUi()
    --app.log(debug.traceback())
    --self.currentpage = 1
    Show3d.Destroy()
    --self.itemicon1:DestroyUi()
    --self.itemicon2:DestroyUi()
    
    for k,v in pairs(self.team1)do
	v:DestroyUi()   
    end
    
    for k,v in pairs(self.team2)do
	v:DestroyUi()   
    end
    
    UiBaseClass.DestroyUi(self);
    
end

function ChurchBotMain:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_right"] = Utility.bind_callback(self, self.on_btn_right)
    self.bindfunc["on_btn_left"] = Utility.bind_callback(self, self.on_btn_left)
    self.bindfunc["on_btn_find"] = Utility.bind_callback(self, self.on_btn_find)
    --self.bindfunc["on_show_battlelist"] = Utility.bind_callback(self, self.on_show_battlelist)
    self.bindfunc["on_updata_ui"] = Utility.bind_callback(self, self.on_updata_ui)
    self.bindfunc["on_UnlockmyPray"] = Utility.bind_callback(self, self.on_UnlockmyPray)
    self.bindfunc["updataUnlockUI"] = Utility.bind_callback(self, self.updataUnlockUI)
    self.bindfunc["on_btn_get"] = Utility.bind_callback(self, self.on_btn_get)
    self.bindfunc["UpdataGetUI"] = Utility.bind_callback(self, self.UpdataGetUI)
    self.bindfunc["ontimeshow"] = Utility.bind_callback(self, self.ontimeshow)
    self.bindfunc["rushUI"] = Utility.bind_callback(self, self.rushUI)
    self.bindfunc["OnPressTips"] = Utility.bind_callback(self, self.OnPressTips)
    self.bindfunc["OnPressTips1"] = Utility.bind_callback(self, self.OnPressTips1)
    
end


--注册消息分发回调函数
function ChurchBotMain:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_regist(msg_activity.gc_churchpray_unlock, self.bindfunc["updataUnlockUI"])
    -- PublicFunc.msg_regist(msg_activity.gc_get_churchpray_reward, self.bindfunc["UpdataGetUI"])
end

--注销消息分发回调函数
function ChurchBotMain:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_unlock, self.bindfunc["updataUnlockUI"])
    -- PublicFunc.msg_unregist(msg_activity.gc_get_churchpray_reward, self.bindfunc["UpdataGetUI"])
end


--初始化UI
function ChurchBotMain:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotMain');
    

    --do return end
    self.connontui = {};
    
    --self.findUIHide = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di1/cont1")
    --self.findUIHide:set_active(false)
    
    --占领UI
    self.winui = self.ui:get_child_by_name("centre_other/animation/content2")
    --self.niwinui = self.ui:get_child_by_name("centre_other/animation/content1")
    
    -- for i=1,3 do   --cont1 查找界面   cont2 开启 cont3 VIP开启
    -- 	self.connontui[i] = self.ui:get_child_by_name("centre_other/animation/content1/cont"..i)
    -- 	self.connontui[i]:set_active(false)
    -- end
    -- self.connontui[1]:set_active(true)
    
    --完成挂机UI
    self.finishui = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont2")
    self.finishuiicon = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont2/sp_gold")
    self.finishui:set_active(false)
    
    --完成占领UI
    self.finishinfoui = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di1/cont1")
    self.finishinfoui:set_active(false)
    
    --占领UI 人物信息部分
    self.winplayinfoui = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont1")
    
    -- self.bottomicon = {};
    -- self.bottomsuo = {};
    -- for i=1,4 do
    -- 	self.bottomicon[i] = ngui.find_sprite(self.ui,"down_other/animation/sp_di_down/qiye"..i.."/sp_suo")
    -- 	if i > 1 then
    -- 	    self.bottomicon[i]:set_active(false) 
    -- 	end
    -- end
    
    --搜索图标
    -- self.sp_sousuoicon = ngui.find_sprite(self.ui,"centre_other/animation/content1/sp_fang_da")
    -- self.sp_sousuoicon:set_active(false)
    -- self.sp_goldicon = ngui.find_sprite(self.ui,"centre_other/animation/content1/sp_gold")
    -- self.sp_suoicon = ngui.find_sprite(self.ui,"centre_other/animation/content1/sp_suo")
    -- self.sp_suoicon:set_active(false)
    -- self.costpaylab = ngui.find_label(self.ui,"centre_other/animation/content1/lab_num")
      
    --self.sp_suo = ngui.find_sprite(self.ui,"centre_other/animation/sp_suo")
    --self.sp_suo:set_active(false)
    --查找 解锁 界面
    -- self.findUI = self.ui:get_child_by_name("centre_other/animation/content1")
    
    -- self.findbtn = ngui.find_button(self.ui,"centre_other/animation/content1/cont1/btn_seek")
    -- self.findbtn:set_on_click(self.bindfunc['on_btn_find'])
    
    --查找对手显示详情
    self.findinfo = self.ui:get_child_by_name("/cont1")
    
    -- self.sp_suobtn = ngui.find_button(self.ui,"centre_other/animation/content1/cont2/btn_open")
    -- self.sp_suobtn:set_on_click(self.bindfunc['on_UnlockmyPray'])
    
    
    --查找结果 挂机完成 占领界面
    --self.ShowUI = self.ui:get_child_by_name("centre_other/animation/content2")
    --self.ShowUI:set_active(false)
    
    
    -- self.leftbtn = ngui.find_button(self.ui,"centre_other/animation/btn_left_arrows")
    -- self.leftbtn:set_on_click(self.bindfunc['on_btn_left'])
    
    -- self.rightbtn = ngui.find_button(self.ui,"centre_other/animation/btn_right_arrows")
    -- self.rightbtn:set_on_click(self.bindfunc['on_btn_right'])
    
    --self.battlevisit = ngui.find_button(self.ui,"centre_other/animation/btn_zhan_bao")  --战报
    --self.battlevisit:set_on_click(self.bindfunc['on_show_battlelist'])
    

    self.sp_bar = self.ui:get_child_by_name("centre_other/animation/sp_bar")  --标题
    self.sp_bar_title = ngui.find_label(self.ui,"centre_other/animation/sp_bar/lab_level1")
    self.sp_bar_sprite = ngui.find_sprite(self.ui,"centre_other/animation/sp_bar")
    self.sp_bar:set_active(false)
    
    
    --查找界面
    
    --self.findpaylab = ngui.find_label(self.ui,"centre_other/animation/content1/lab_num")
    --self.findpaypic = ngui.find_label(self.ui,"centre_other/animation/content1/sp_gold")
    
    self.getbtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont2/btn3")
    self.getbtn:set_on_click(self.bindfunc['on_btn_get'])
    self.getbtn:set_active(false)
    
    --重新搜索
    self.restbtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/btn1")
    self.restbtn:set_active(false)
    
    --开始探索
    self.beginBtn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/btn2")
    self.beginBtn:set_active(false)
    
    self.shengyutimelab = ngui.find_label(self.ui,"centre_other/animation/sp_di1/cont2/txt3/lab_num")
    
    self.speedlab1 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang1/lab_num")
    self.alllab1 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang1/lab_num")
    
    --self.itemicon1 = UiSmallItem:new({parent = itemicon1,cardInfo = nil})
    --self.itemicon2 = UiSmallItem:new({parent = itemicon2,cardInfo = nil})
    self.itemicon1 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang1")
    self.itemicon2 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang2")
    self.itemicon3 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang1")
    self.itemicon4 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang2")
    
    self.itemicon1btn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang1")
    self.itemicon2btn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang2")

    self.itemicon3btn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang1")
    self.itemicon4btn = ngui.find_button(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang2")
    
    self.itemicon1btn:set_on_ngui_press(self.bindfunc['OnPressTips'])
    self.itemicon2btn:set_on_ngui_press(self.bindfunc['OnPressTips1'])
    self.itemicon3btn:set_on_ngui_press(self.bindfunc['OnPressTips'])
    self.itemicon4btn:set_on_ngui_press(self.bindfunc['OnPressTips1'])
    
    --self.winui = self.ui:get_child_by_name("centre_other/animation/cont4")
    --self.winui:set_active(false)
    ----
    self.myhuman = ngui.find_sprite(self.ui,"centre_other/animation/content2/sp_human")
    self.myname = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_name")
    self.mylvl = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_dengji")
    self.myquyu = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/lab_quyu")
    self.battlepower = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/sp_fight/lab_fight")
    
    self.vipicon = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/sp_di2/cont1/sp_art_font") --VIP
    self.vipiconLab = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di2/cont1/sp_art_font/lab_num")
    
    -- self.viplab = ngui.find_label(self.ui,"centre_other/animation/content1/cont3/lab_num")  --VIP等级

    ----新界面加的东西
    self.zhanlinicon1 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang2")
    self.zhanlinlab1 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt1/sp_kuang2/lab_num")
    self.zhanlinicon2 = ngui.find_texture(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang2")
    self.zhanlinlab2 = ngui.find_label(self.ui,"centre_other/animation/content2/right_other/animation/sp_di1/cont2/txt2/sp_kuang2/lab_num")

    self.zhanlinicon1:set_active(false)
    self.zhanlinicon2:set_active(false)
    -------- 
    self.team1 = {}
    self.team2 = {}
    
    for i = 1,3 do
	local team1 = {}
	
	local team2 = {}
	team1[i] = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/cont1/lab_duiwu2/new_small_card_item"..i)
	
	team2[i] = self.ui:get_child_by_name("centre_other/animation/content2/right_other/animation/cont1/lab_duiwu1/new_small_card_item"..i)
	
	self.team1[i] = SmallCardUi:new({parent = team1[i],
		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
	
	self.team2[i] = SmallCardUi:new({parent = team2[i],
		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
    end
    
    
    self:bound3d()
        
    --msg_activity.cg_churchpray_request_myslef_info()
    --self:setData()
    
    self:on_updata_ui()
end

function ChurchBotMain:set_yema()

    do return end
    for i=1,4 do
	self.bottomicon[i]:set_active(false) 
    end
    self.bottomicon[self.currentpage]:set_active(true) 
end

function ChurchBotMain:on_updata_ui()
    
    self.currentpage = g_dataCenter.ChurchBot:getmyprayIndex()
    app.log("currentpage============="..tostring(self.currentpage))

    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    self:set_yema()
    if self.PoslistData[self.currentpage].churchStar > 0 then
    	self.finishui:set_active(true)
    	--self.finishinfoui:set_active(true)
    	--self.connontui[1]:set_active(false)
    	self:setTimeData()
    	self:setFininshUI()
    	self:ShowWinOrFindUI(true)
    else
    	self.finishui:set_active(false)
    	--self.finishinfoui:set_active(false)
    	--self.connontui[1]:set_active(true)
    	--self.findbtn:set_active(true)
    	self:setFindUiData()
    	self.winui:set_active(false)
    	--app.log("SetVisible333333333333333333")
    	self:SetVisible(false)
    	self:IsUnlock(self.currentpage)
    	self:ShowWinOrFindUI(false)
    end
end

function ChurchBotMain:ShowWinOrFindUI(flag)
    
    if flag then
	self.winui:set_active(true)
	--self.niwinui:set_active(false)
	self.sp_bar:set_active(true)
    else
	self.winui:set_active(false)
	--self.niwinui:set_active(true)
	self.sp_bar:set_active(false)
    end
end

function ChurchBotMain:setCastUiData()
    local castid = ConfigManager.Get(EConfigIndex.t_church_pray_open,self.currentpage).cost_id
    --local castpic = ConfigManager.Get(EConfigIndex.t_item,castid).small_icon
    
    local castnum = ConfigManager.Get(EConfigIndex.t_church_pray_open,self.currentpage).cost_num
    
    if self.canOpenforvip then
	--app.log("self.canOpenforvip########"..tostring(self.canOpenforvip))
	if self.canOpenforvip >= self.currentpage then
	    if castnum == 0 then
		    self.costpaylab:set_text("免费")
	    else
		self.costpaylab:set_text(tostring(castnum))
	    end
	    --self.vipbg:set_active(true)
	    --self.viplab:set_text("开启花费")
	    self:VipShowOrHide(false)
	else
	    
	    local needvip = 0
	    
	    for k,v in ipairs(self.VipUnlockList) do
		--app.log("kkkkkkkkkkkkkkkkkkkkk"..tostring(k))
		--app.log("$#############v.churchpray_add_ore_num"..tostring(v.churchpray_add_ore_num))
		if v.churchpray_add_ore_num == self.currentpage then
		    --app.log("kkkkkkkkkkkkkkkkkk####"..tostring(k))
		    needvip = k
		    break
		end
	    end
	    
	    if needvip == 0 then
		if castnum == 0 then
		    self.costpaylab:set_text("免费")
		else
		    self.costpaylab:set_text(tostring(castnum))
		end
		--self.vipbg:set_active(true)
		--self.viplab:set_text("开启花费")
		self:VipShowOrHide(false)
		self.getbtn:set_active(false)
	    else
		self:VipShowOrHide(true)
		self.viplab:set_text("VIP"..tostring(needvip).."开启")
		--self.vipbg:set_active(false)
		self.getbtn:set_active(false)
	    end
	end
    else
	if castnum == 0 then
	    self.costpaylab:set_text("免费")
	else
	    self.costpaylab:set_text(tostring(castnum))
	end
	--self.vipbg:set_active(true)
	--self.viplab:set_text("开启花费")
	self:VipShowOrHide(false)
	self.getbtn:set_active(false)
    end
    
    --app.log("33333333333333333333333333333333333333")
    if self.PoslistData then
	if self.PoslistData[self.currentpage] then
	    if self.PoslistData[self.currentpage].bUnlock then
		--self.sp_goldicon:set_sprite_name("dh_jinbi")
	    else
		if castid == 2 then
		    --self.sp_goldicon:set_sprite_name("dh_jinbi")
		elseif castid == 3 then
		    --self.sp_goldicon:set_sprite_name("dh_hongshuijing")
		end
	    end
	end
    end
end

--VIP解锁显示或隐藏
function ChurchBotMain:VipShowOrHide(flag)

    do return end
    if flag then
    	self.connontui[2]:set_active(false)
    	self.connontui[3]:set_active(true)
    	self.sp_goldicon:set_active(false)
    	self.costpaylab:set_active(false)
    else
    	if self.PoslistData[self.currentpage].bUnlock then
    	    self.connontui[2]:set_active(false)
    	else
    	    self.connontui[2]:set_active(true)
    	end
    	self.connontui[3]:set_active(false)
    	self.sp_goldicon:set_active(true)
    	self.costpaylab:set_active(true)
    end
end

function ChurchBotMain:setTimeData()
    --设置已挂机数据
    local lasttime = self.PoslistData[self.currentpage].prayStartTime
    local nstar = self.PoslistData[self.currentpage].churchStar
    local nowtime = system.time()
    local casttime = nowtime - lasttime
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
    local shengyutime = needtime - casttime
    --local timetab = os.date("*t",shengyutime) 
    
    --app.log("shengyutime is ###############"..tostring(shengyutime))
    
    if shengyutime < 0 then
	self.shengyutimelab:set_text("00:00:00")
	self.getbtn:set_active(true)
	self.finishui:set_active(true)
	self.winplayinfoui:set_active(false)
	self:setWin(0)
	self:SetVisible(true)
    else
	local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(shengyutime);
	self.shengyutimelab:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	--self.shengyutimelab:set_text(tostring(shengyutime))
	self.getbtn:set_active(false)
	self.timeid = timer.create(self.bindfunc["ontimeshow"] ,1000,-1)
	self.finishui:set_active(false)
	self.winplayinfoui:set_active(true)
	self:setWin(1)
	self:SetVisible(true)
    end
    
    self:setFininshUI()
end

function ChurchBotMain:setWin(ntype)
    if ntype == 1 then 
	self.winui:set_active(true)
	self:setMyTeamInfo()
    else
	self.winui:set_active(false)
    end
end

function ChurchBotMain:setMyTeamInfo()
    
    for i=1,3 do
	self.team1[i]:SetData(nil)
	self.team2[i]:SetData(nil)
    end
    
    local name = g_dataCenter.player.name
    local lvl = g_dataCenter.player.level
    local quyu = g_dataCenter.player.country_id
    --local battle = 
    
    --app.log("currentpage#################"..tostring(self.currentpage))
    
    local posIndex = self.PoslistData[self.currentpage].indexID
    
    local powerValue = 0;
    
    --local temptype = ChurchBot:getteamtype(posIndex)
    local templineup = self.PoslistData[self.currentpage].vecCardGIDTeam1
    
--    app.log("posIndex#################"..tostring(posIndex))
--    
--    if posIndex == 1 then
--	templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1)
--    elseif prayindex == 2 then
--	templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1)
--    elseif prayindex == 3 then
--	templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1)
--    elseif prayindex == 4 then
--	templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1)
--    end
    
    --app.log("templineup################"..table.tostring(templineup))
    
    if templineup then
	for k,v in pairs(templineup) do
	    if v ~= "0" then
		local cardinfo = g_dataCenter.package:find_card(1, v);
		--app.log("v################"..tostring(v))
		--app.log("cardinfo################"..table.tostring(cardinfo))
		powerValue = powerValue + cardinfo:GetFightValue()
	    end
	end
    end
    --app.log("powerValue################"..tostring(powerValue))
    
    local nStar = self.PoslistData[self.currentpage].churchStar
    --app.log("nStar#############"..tostring(nStar))
    
    local Toptitle = ""
    
    if nStar == 1 then
	Toptitle = "贫困区"
        self.sp_bar_sprite:set_sprite_name("ld_xindiantu1")
    elseif nStar == 2 then
	Toptitle = "普通区"
        self.sp_bar_sprite:set_sprite_name("ld_xindiantu2")
    elseif nStar == 3 then
	Toptitle = "富人区"
        self.sp_bar_sprite:set_sprite_name("ld_xindiantu3")
    end
    
    self.sp_bar_title:set_text(Toptitle)
    
    if nStar > 2 then
	--app.log("222222222222#############"..tostring(nStar))
	local templineup2 = self.PoslistData[self.currentpage].vecCardGIDTeam2
	    
	--if posIndex == 1 then
	--    templineup2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2)
	--elseif posIndex == 2 then
	--    templineup2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2)
	--elseif posIndex == 3 then
	--    templineup2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2)
	--elseif posIndex == 4 then
	--    templineup2 = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2)
	--end 
    
	if templineup2 then
	    for k,v in pairs(templineup2) do
		local cardinfo = g_dataCenter.package:find_card(1, v);
		powerValue = powerValue + cardinfo:GetFightValue()
	    end  
	end
	
	self:setTeam2()
    end
    
    if g_dataCenter.player.vip > 0 then
	self.vipicon:set_active(true)
	self.vipiconLab:set_text(tostring(g_dataCenter.player.vip))
    else
	self.vipicon:set_active(false)
    end
    
    self.myname:set_text(name)
    self.mylvl:set_text("等级："..tostring(lvl))
    
    --app.log("quyu====================="..tostring(quyu))
    if not g_dataCenter.player.country_id then
        self.myquyu:set_text("区域：无")
    else
        if g_dataCenter.player.country_id > 0 then
            local country_name = ConfigManager.Get(EConfigIndex.t_country_info,quyu).name
            self.myquyu:set_text("区域："..tostring(country_name))
        else
            self.myquyu:set_text("区域：无")
        end
    end
    self.battlepower:set_text(tostring(powerValue))
    self:setTeam1()
    
    
end

function ChurchBotMain:bound3d()
    --app.log("bound3d##############################")
    local data = 
    {
        roleData = nil;--CardHuman:new({number=g_dataCenter.player.image, isNotCalProperty = true});
        role3d_ui_touch = self.myhuman,
        type = "left",
    }   
    Show3d.SetAndShow(data)
end

function ChurchBotMain:SetVisible(ntype)
    --app.log("currentpage#############"..tostring(self.currentpage))
    local data = {}
    if ntype == true then
	data = 
	{
	    roleData = CardHuman:new({number=g_dataCenter.player.image, isNotCalProperty = true});
	    role3d_ui_touch = self.myhuman,
	    type = "left",
	}
    else
	data = 
	{
	    roleData = nil;--CardHuman:new({number=g_dataCenter.player.image, isNotCalProperty = true});
	    role3d_ui_touch = self.myhuman,
	    type = "left",
	}
    end
    
    Show3d.SetAndShow(data)
    
end

function ChurchBotMain:setTeam1()
    
    local info = self.PoslistData[self.currentpage].vecCardGIDTeam1
    
    --app.log("info #################"..table.tostring(info))
    
    for k,v in pairs(info) do
	local cardinfo = g_dataCenter.package:find_card(1, v);
	--local cardhum = CardHuman:new(tonumber(v))
	self.team2[k]:SetData(cardinfo)   
    end
end

function ChurchBotMain:setTeam2()
    local info = self.PoslistData[self.currentpage].vecCardGIDTeam2
    --app.log("info #################"..table.tostring(info))
    for k,v in pairs(info) do
	local cardinfo = g_dataCenter.package:find_card(1, v);
	--local cardhum = CardHuman:new(tonumber(v))
	self.team1[k]:SetData(cardinfo)  
    end
end

function ChurchBotMain:ontimeshow()
    
    if self.PoslistData[self.currentpage].churchStar > 0 then
    
	local lasttime = self.PoslistData[self.currentpage].prayStartTime
	local nstar = self.PoslistData[self.currentpage].churchStar
	local nowtime = system.time()
	local casttime = nowtime - lasttime
	local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
	local shengyutime = needtime - casttime
	
	if shengyutime < 0 then
	    self.shengyutimelab:set_text("00:00:00")
	    self.getbtn:set_active(true)
	    if self.timeid then
		timer.stop(self.timeid);
		self.timeid = nil;
	    end
	    
	    --self.shengyutimelab:set_text("00:00:00")
	    --self.getbtn:set_active(true)
	    self.finishui:set_active(true)
	    self.winplayinfoui:set_active(false)
	    self:setWin(0)
	    Show3d.SetVisible(true)
	else
	    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(shengyutime);
	    self.shengyutimelab:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
	    --self.shengyutimelab:set_text(tostring(shengyutime))
	    self.getbtn:set_active(false)
	    self:setFininshUI()
	    self.finishui:set_active(false)
	    self.winplayinfoui:set_active(true)
	end
    else
	if self.timeid then
	    timer.stop(self.timeid);
	    self.timeid = nil;
	end
    end
end

function ChurchBotMain:isFinish(index)
    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    if self.PoslistData[self.currentpage].churchStar > 0 then
	self.finishui:set_active(true)
	--self.finishinfoui:set_active(true)
	--self.connontui[1]:set_active(false)
	--self.connontui[2]:set_active(false)
	self.findbtn:set_active(false)
	self:setTimeData()
	self:SetVisible(true)
	--Show3d.SetVisible(show)
    else
	--Show3d.Destroy()
	--app.log("SetVisible11111111111111111111")
	self:SetVisible(false)
	self.finishui:set_active(false)
	--self.finishinfoui:set_active(false)
	self.winui:set_active(false)
	self.findbtn:set_active(true)
	--self.connontui[1]:set_active(true)
	self:IsUnlock(index)
	
	if self.timeid then
	    timer.stop(self.timeid);
	    self.timeid = nil;
	end	
    end
        
end

function ChurchBotMain:setFininshUI( )
    
    --app.log("setFininshUI#################")
    
    local nSta = self.PoslistData[self.currentpage].churchStar
    local posindex = self.PoslistData[self.currentpage].posIndex
    local church_pos_detail_data = ConfigManager.Get(EConfigIndex.t_church_pos_detail_data,nSta);
    
    local time = 0
    local itemid = 0
    local itemid1 = 0;
    for k,v in pairs(church_pos_detail_data) do
	--app.log("posindex#################"..table.tostring(v.posIndex))
    	if v.posIndex ==  posindex then
    	    itemid = v.resourceType1
            itemid1 = v.resourceType2
    	    --app.log("itemid#################"..tostring(itemid))
            break
    	end
    end
    
    local keyname = "resource_num_"..tostring(itemid)
    --app.log("keyname#################"..keyname)
    local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta)
    local keyid = keydata[keyname]
    --app.log("keyid#################"..tostring(keyid))
    
    local keyiconname = "resource_icon_"..tostring(itemid)
    local keyicon = keydata[keyiconname]
    --app.log("keyicon#####################"..keyicon)
    if keyicon~= 0 then
	   self.finishuiicon:set_texture(keyicon)
    end
    
    local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    
    
    self.itemid = keyid
    
    self.itemicon1:set_texture(itemicon)
    self.itemicon3:set_texture(itemicon)
    --if itemid > 0 then
    local xxname = "star"..tostring(nSta).."_resource"..tostring(itemid)
    --app.log("xxname#################"..xxname)
    --end
    
    local level = g_dataCenter.player.level;
    local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
    local tdata = church_pos_data[xxname]
    --app.log("xxname#################"..tdata)
    self.speedlab1:set_text(tostring(tdata))
    
    local lasttime = self.PoslistData[self.currentpage].prayStartTime
	--local nstar = self.PoslistData[self.currentpage].churchStar
    local nowtime = system.time()
    local casttime = nowtime - lasttime
    --local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(casttime);
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta).canPrayTime;
    local shengyutime = needtime - casttime
    
    local ttdata = tdata/3600
    
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta).canPrayTime;
    local all = shengyutime*ttdata

    if itemid1 > 0 then

        local xxname1 = "star"..tostring(nSta).."_resource"..tostring(itemid1)
        local keyname1 = "resource_num_"..tostring(itemid1)
        --app.log("keyname#################"..keyname)
        local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta)
        local keyid = keydata[keyname1]
        --app.log("keyid#################"..tostring(keyid))
        self.itemid1 = keyid
        local keyiconname1 = "resource_icon_"..tostring(itemid1)
        local keyicon1 = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon--keydata[keyiconname1]
       -- app.log("keyiconname#####################"..keyiconname)

        local tdata1 = church_pos_data[xxname1]

        local ttdata1 = tdata1/3600
        --if keyicon~= 0 then
        self.zhanlinicon1:set_texture(keyicon1)
        self.zhanlinicon2:set_texture(keyicon1)
        
        self.zhanlinlab1:set_text(tostring(tdata1))

        self.zhanlinicon1:set_active(true)

        if shengyutime <= 0 then
            
            self.zhanlinlab2:set_text(tostring(math.floor(needtime*ttdata1)))

        else

            self.zhanlinlab2:set_text(tostring(math.floor(casttime*ttdata1)))
        end

        self.zhanlinicon2:set_active(true)
    end
    
    local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    
    
    self.itemid = keyid
    
    self.itemicon1:set_texture(itemicon)
    self.itemicon3:set_texture(itemicon)
    --if itemid > 0 then
    -- local xxname = "star"..tostring(nSta).."_resource"..tostring(itemid)
    -- end

    
    if shengyutime <= 0 then
    	self.alllab1:set_text(tostring(math.floor(needtime*ttdata)))
    	self.itemcount = math.floor(needtime*ttdata)
    else
    	self.alllab1:set_text(tostring(math.floor(casttime*ttdata)))
    	self.itemcount = math.floor(casttime*ttdata)
    end
    
end

function ChurchBotMain:OnPressTips(name, state, x, y, gameobj)
    
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

function ChurchBotMain:OnPressTips1(name, state, x, y, gameobj)
    
    --app.log("111111111111111111111111111111111")
    local cardInfo = nil;
    if self.itemid1 then
    if PropsEnum.IsEquip(self.itemid1) then
        cardInfo = CardEquipment:new( { number = self.itemid1, count = 0});
    elseif PropsEnum.IsItem(self.itemid1) or PropsEnum.IsVaria(self.itemid1) then
        cardInfo = CardProp:new( { number = self.itemid1, count = 0 });
    elseif PropsEnum.IsRole(self.itemid1) then
        cardInfo = CardHuman:new( { number = self.itemid1, count = 0 });
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

function ChurchBotMain:on_btn_left(t)
    
    self.bottomicon[self.currentpage]:set_active(false)
    --self.connontui[self.currentpage]:set_active(false)
    
    self.currentpage = self.currentpage - 1
    if self.currentpage < 1 then
	self.currentpage = 1
    end
        
    g_dataCenter.ChurchBot:setmyprayIndex(self.currentpage)
    
    self.bottomicon[self.currentpage]:set_active(true)
    --self.connontui[self.currentpage]:set_active(true)
    --app.log("on_btn_left#####"..tostring(self.currentpage))
    
    self:IsShowOrHideZhanLinUI(self.currentpage)
    self:IsUnlock(self.currentpage)
    self:isFinish(self.currentpage)
    
end

function ChurchBotMain:IsShowOrHideZhanLinUI(index)
    
    if self.PoslistData == nil then
	self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    end    
    
    if self.PoslistData[index].churchStar > 0 then
	self:ShowWinOrFindUI(true)
    else
	self:ShowWinOrFindUI(false)
    end
end

function ChurchBotMain:on_btn_right(t)
    
    self.bottomicon[self.currentpage]:set_active(false)
    
    self.currentpage = self.currentpage + 1
    if self.currentpage > 4 then
	self.currentpage = 4
    end
    
    g_dataCenter.ChurchBot:setmyprayIndex(self.currentpage)
    
    self.bottomicon[self.currentpage]:set_active(true)
    --app.log("on_btn_right#####"..tostring(self.currentpage))
    self:IsShowOrHideZhanLinUI(self.currentpage)
    self:IsUnlock(self.currentpage)
    self:isFinish(self.currentpage)
end

--设置底部解锁图标
function ChurchBotMain:setButtonIcon(index)
    --app.log("index##############"..tostring(index))
    --self.bottomicon[index]:set_active(false)
    
end

function ChurchBotMain:setIsUnlockUI(flag)
    do return end
    --app.log("flag###########"..tostring(flag))
    if flag then
	--self.sp_sousuoicon:set_active(true)
	--self.sp_suoicon:set_active(false)
    else
	--self.sp_sousuoicon:set_active(false)
	--self.sp_suoicon:set_active(true)
    end
end

--判断是否解锁
function ChurchBotMain:IsUnlock(index)
    
    if self.PoslistData then
	if self.PoslistData[index] then
	    if self.PoslistData[index].bUnlock then
		--app.log("111111111111111111111111111")
		--self.connontui[2]:set_active(false)
		--self.connontui[1]:set_active(true)
		self:setIsUnlockUI(true)
		--self.sp_suo:set_active(false)
	    else
		--self.connontui[2]:set_active(true)
		--self.connontui[1]:set_active(false)
		--self.sp_suo:set_active(true)
		self:setIsUnlockUI(false)
	    end
	end
    end
    
    local vip = g_dataCenter.player.vip
    if self.VipUnlockList[vip] then
	self.canOpenforvip = self.VipUnlockList[vip].churchpray_add_ore_num	    
    end
    self:setCastUiData()
    --self:setUnLockData(index)
    self:setFindUiData()
end

function ChurchBotMain:setFindUiData()
    local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
    --app.log("reshnumb#############"..tostring(reshnumb))
    if self.PoslistData[self.currentpage].bUnlock then
	local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
	self.costpaylab:set_text(tostring(findcast))
    end
end

--设置解锁条件界面
function ChurchBotMain:setUnLockData(index)
    
    
end

function ChurchBotMain:updataUnlockUI()
    --self.connontui[2]:set_active(false)
    --self.connontui[1]:set_active(true)
    self:setIsUnlockUI(true)
    self:IsUnlock(self.currentpage)
end

function ChurchBotMain:on_btn_find()
    --uiManager:PopUi();
    
    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    
    if self.PoslistData[self.currentpage].bUnlock then
	g_dataCenter.ChurchBot:setmyprayIndex(self.currentpage)
	local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
	local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
	if g_dataCenter.player.gold < findcast then
	    FloatTip.Float("金币不够！");
	    do return end    
	end
	
	uiManager:PushUi(EUI.ChurchBotSelect);
    else
	FloatTip.Float("该位置还没有解锁！");
    end
end

function ChurchBotMain:on_show_battlelist() 
    uiManager:PushUi(EUI.ChurchBotBattleList);
end

function ChurchBotMain:UpdateUi()
    
end

function ChurchBotMain:on_UnlockmyPray()
    --app.log("on_UnlockmyPray#######################"..tostring(self.canOpenforvip))
    if self.currentpage > 0 then
    	if self.canOpenforvip >= self.currentpage then
    	    msg_activity.cg_churchpray_unlock(self.currentpage)
    	else
    	    FloatTip.Float("好感度不够！");
    	end
    end
end

function ChurchBotMain:on_btn_get()
    if self.currentpage > 0 then
	--app.log("on_btn_get##########################")
	msg_activity.cg_get_churchpray_reward(self.currentpage)
    end
end

function ChurchBotMain:UpdataGetUI()
    
    local rewardlist = g_dataCenter.ChurchBot:getreward()

    -- 双倍
    for k,v in pairs(rewardlist) do
        rewardlist[k].double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.church_hook, v.id);
    end

    uiManager:PopUi();
    
    app.log("rewardlist -============="..table.tostring(rewardlist))

    CommonAward.Start(rewardlist, tType)
    
    
end

function ChurchBotMain:Show()
    if UiBaseClass.Show(self) then
	if not Show3d.GetInstance() then
	    self:bound3d()
	    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
	    --app.log("Show#######################"..tostring(self.currentpage))
	    if self.PoslistData[self.currentpage].churchStar > 0 then
		self:SetVisible(true)
	    else
		--app.log("SetVisible2222222222222222222")
		self:SetVisible(false)
	    end	
	end
    end
end


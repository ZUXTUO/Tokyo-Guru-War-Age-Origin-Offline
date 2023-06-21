
GuildFindLsUI = Class("GuildFindLsUI", UiBaseClass)


-------------------------------------外部调用-------------------------------------
function GuildFindLsUI:ShowNavigationBar()
    return true
end

function GuildFindLsUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/advfuncnotice/ui_7201_search.assetbundle"
    UiBaseClass.Init(self, data);
end

function GuildFindLsUI:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function GuildFindLsUI:InitData(data)
    self.isReset = false
    self.isFrist = true
    self.Checklist = {};
    self.isFast = false;
    
    --app.log(debug.traceback())
    self.Alldatainfo = g_dataCenter.GuildFindLs:getAllDataInfo()
    self.opendatainfo = g_dataCenter.GuildFindLs:getOpenData()
    local MaxNum = ConfigManager.Get(EConfigIndex.t_activity_time,60055126).number_restriction
    self.MaxNumber = MaxNum.d
    --app.log("self.MaxNumber###################"..table.tostring(self.MaxNumber.d))
    UiBaseClass.InitData(self, data)
    
end

function GuildFindLsUI:DestroyUi()
    for k,v in pairs(self.ui_small_item) do
	v:DestroyUi()
    end
    
    for i=1,9 do
	Tween.removeTween(self.carditem[i]);
	Tween.removeTween(self.cardleftlist[i]);
    end
    
    if self.playmovetime then
	timer.stop(self.playmovetime)
	self.playmovetime = nil;
    end

    if self.click_audio then
    	AudioManager.StopUiAudio(self.click_audio)
    	self.click_audio = nil;
    end
    
    self.isFast = false;

    self.Checklist = {};
    
    UiBaseClass.DestroyUi(self);

end

function GuildFindLsUI:RegistFunc()
    self.bindfunc['updata_ui'] = Utility.bind_callback(self, self.updata_ui);
    self.bindfunc['on_click_Open'] = Utility.bind_callback(self, self.on_click_Open);
    self.bindfunc['on_reset'] = Utility.bind_callback(self, self.on_reset);
    self.bindfunc['on_start'] = Utility.bind_callback(self, self.on_start);
    self.bindfunc['playmove'] = Utility.bind_callback(self, self.playmove);
    self.bindfunc['on_click_call'] = Utility.bind_callback(self, self.on_click_call);
    self.bindfunc['on_reset_call'] = Utility.bind_callback(self, self.on_reset_call);
    self.bindfunc['on_record'] = Utility.bind_callback(self, self.on_record);
    self.bindfunc['gotostar'] = Utility.bind_callback(self, self.gotostar);
    self.bindfunc["rushUI"] = Utility.bind_callback(self, self.rushUI);
    self.bindfunc["show_ls_info"] = Utility.bind_callback(self, self.show_ls_info);
    UiBaseClass.RegistFunc(self);
    
end


--注册消息分发回调函数
function GuildFindLsUI:MsgRegist()
    PublicFunc.msg_regist(msg_xunzhaolishi.gc_request_my_data, self.bindfunc["updata_ui"])
    PublicFunc.msg_regist(msg_xunzhaolishi.gc_open, self.bindfunc["on_click_call"])
    PublicFunc.msg_regist(msg_xunzhaolishi.gc_reset, self.bindfunc["on_reset_call"])
    
    UiBaseClass.MsgRegist(self);
   
end

--注销消息分发回调函数
function GuildFindLsUI:MsgUnRegist()
    PublicFunc.msg_unregist(msg_xunzhaolishi.gc_request_my_data, self.bindfunc["updata_ui"])
    PublicFunc.msg_unregist(msg_xunzhaolishi.gc_open, self.bindfunc["on_click_call"])
    PublicFunc.msg_unregist(msg_xunzhaolishi.gc_reset, self.bindfunc["on_reset_call"])
    UiBaseClass.MsgUnRegist(self);
        
end


--初始化UI
function GuildFindLsUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('GuildFindLsUI');
    
    self.Mark = ngui.find_sprite(self.ui,"centre_other/animation/sp_bk/sp_mark")
    self.Mark:set_on_ngui_click(self.bindfunc['gotostar'])
    
    self.btn_record = ngui.find_button(self.ui,"centre_other/animation/btn_jilu")
    self.btn_record:set_on_click(self.bindfunc['on_record'])
    self.contlab_num = ngui.find_label(self.ui,"centre_other/animation/sp_di1/lab")
    
    self.costpaydiv = self.ui:get_child_by_name("centre_other/animation/cont")
    self.costpayMflab = ngui.find_label(self.ui,"centre_other/animation/sp_di1/txt")  --免费文字
    self.costpayMflab:set_text("本次消耗免费")
    self.costpayMonyLab = ngui.find_label(self.ui,"centre_other/animation/cont/lab")  --花费
    
    self.resetbtn = ngui.find_button(self.ui,"centre_other/animation/btn_reset")
    self.resetbtn:set_on_click(self.bindfunc['on_reset'])
    --self.resetbtn:set_enable(false)
    
    self.startbtn = ngui.find_button(self.ui,"centre_other/animation/btn_start")
    self.startbtn:set_on_click(self.bindfunc['on_start'])
    self.startbtn:set_active(false)
    
    --self.resetlab = ngui.find_label(self.ui,"down_other/animiation/btn_get/animation/lab")
    
    self.grid = ngui.find_grid(self.ui,"centre_other/animation/sp_bk/grid")
    local px,py,pz = self.grid:get_position();
    
    self.playxipai = self.ui:get_child_by_name("centre_other/animation")

    self.lsinfobtn = ngui.find_button(self.ui,"left_other/aniamtion/Texture_human")
    self.lsinfobtn:set_on_click(self.bindfunc['show_ls_info'])

    self.cardlist = {}
    self.carditem = {}
    self.cardbg = {}
    self.cardleftlist = {}
    self.cardleftposlist = {}
    
    self.cardbgpos = {}
    self.ui_small_item = {}
    self.cardbgline = {}
    self.carditemtxt = {}
    
    for i=1,9 do
		self.carditem[i] = self.ui:get_child_by_name("centre_other/animation/sp_bk/grid/cont"..i.."/new_small_card_item")
		self.cardlist[i] = self.ui:get_child_by_name("centre_other/animation/sp_bk/grid/cont"..i)
		self.cardbg[i] = ngui.find_button(self.ui,"centre_other/animation/sp_bk/grid/cont"..i.."/sp_bk")
		self.cardbg[i]:set_on_click(self.bindfunc['on_click_Open'])
		self.cardbg[i]:set_event_value("",i)
		--self.cardbgline[i] = ngui.find_sprite(self.ui,"centre_other/animation/sp_bk/grid/cont"..i.."/sp_bk/sp_shine")
		self.carditemtxt[i] = ngui.find_label(self.ui,"centre_other/animation/sp_bk/grid/cont"..i.."/lab")
		
		self.cardbg[i]:set_active(false)
		
		self.cardleftlist[i] = ngui.find_sprite(self.ui,"centre_other/animation/sp_bk/sp_board"..i)
		self.cardleftposlist[i] = {}
		self.cardleftposlist[i][1],self.cardleftposlist[i][2],self.cardleftposlist[i][3] = self.cardleftlist[i]:get_position()
		
		self.cardbgpos[i] = {};
		self.cardbgpos[i][1],self.cardbgpos[i][2],self.cardbgpos[i][3] = self.cardlist[i]:get_local_position();
		self.cardbgpos[i][1] = self.cardbgpos[i][1] + px;
		self.cardbgpos[i][2] = self.cardbgpos[i][2] + py;
		self.cardbgpos[i][3] = self.cardbgpos[i][3] + pz;
	
		self.ui_small_item[i] = UiSmallItem:new({parent = self.carditem[i]});
		
		self.carditem[i]:set_active(false)
    end

    self:setGameNumber()
    msg_xunzhaolishi.cg_request_my_data()
    
end

function GuildFindLsUI:updata_ui()
    
    self.Alldatainfo = g_dataCenter.GuildFindLs:getAllDataInfo()
    self.opendatainfo = g_dataCenter.GuildFindLs:getOpenData()
    
    
    --如果已打开的 次数为0
    if #self.opendatainfo == 0 then
		self.Checklist = {}
		for i=1,9 do
			
		    local iteminfo = self.Alldatainfo[i]
		    --app.log("self.Alldatainfo[i]############"..tostring(iteminfo.id))
		    local card_prop = CardProp:new({number = iteminfo.id,count = iteminfo.count})
		    
		    self.ui_small_item[i]:SetData(card_prop)
		    self.ui_small_item[i]:SetCount(iteminfo.count)
		    self.ui_small_item[i]:SetEnablePressGoodsTips(true)
		    local itemobj = PublicFunc.IdToConfig(iteminfo.id)
		    self.carditemtxt[i]:set_text(itemobj.name)
		    

			self.carditem[i]:set_active(true)
			self:playmove()
			-- if i == 9 then
			--     self.startbtn:set_active(true) 
			-- end
		end

		self.Mark:set_active(false)
	
    else
		for i=1,9 do
		    self.carditem[i]:set_active(true)
		    self.cardbg[i]:set_active(true)
		    self.cardleftlist[i]:set_active(false)
		    self.carditem[i]:set_local_scale(1,1,1)
		end
		
		for k,v in pairs(self.opendatainfo) do
		    local ind = v.index + 1
		    if self.cardbg[ind] then
			self.cardbg[ind]:set_active(false)
			local iteminfo = v.Item
			local itemobj = PublicFunc.IdToConfig(iteminfo.id)
			--app.log("iteminfo=========="..table.tostring(itemobj))
			local card_prop = CardProp:new({number = iteminfo.id,count = iteminfo.count})
			self.ui_small_item[ind]:SetData(card_prop)
			self.ui_small_item[ind]:SetCount(iteminfo.count)
			self.ui_small_item[ind]:SetEnablePressGoodsTips(true)
			self.carditemtxt[ind]:set_text(itemobj.name)
			self.Checklist[ind-1] = true
		    end
		end
		
		self.Mark:set_active(false)
    end

    self:setGameNumber()
    self:isCoastPay()
end

function GuildFindLsUI:gotostar(name,x,y,obj,string_value)

	do return end

	if self.isFast then
		do return end
	end
	--app.log("gotostar=====================")

    self.Mark:set_active(false)
    self:setGameNumber()
    self.isFast = true


end

function g_fapai_end()

	--app.log("fapai end=======================")
	local obj = uiManager:FindUI(EUI.GuildFindLsUI)
	obj:playmovefapai()
end

function GuildFindLsUI:playmovefapai()

	if self.isFast then
		do return end
	end

	self.playxipai:animated_play("ui_7201_search_xi_pai")

	self.isFast = false

end

function g_xunzhao_xipai()
    local obj = uiManager:FindUI(EUI.GuildFindLsUI)
    
    obj:hideMask()
end

function g_xunzhao_xipaibegin()
	local obj = uiManager:FindUI(EUI.GuildFindLsUI)
	
	obj:palyxipai111()
	app.log("palyxipai111")
end

function GuildFindLsUI:palyxipai111()
	--for i=1,9 do
		--self.cardleftlist[i]:set_active(false)
	    --self.cardbg[i]:set_active(true)
	--end
	app.log("palyxipai111")
	self.startbtn:set_active(true) 
	
    self.resetbtn:set_active(false)

end

function GuildFindLsUI:playmovexipai()
	self.playxipai:animated_play("ui_7201_search_fa_pai")
	if self.click_audio then
    	AudioManager.StopUiAudio(self.click_audio)
    	self.click_audio = nil;
    end

	self.click_audio = AudioManager.PlayUiAudio(ENUM.EUiAudioType.FIndLsFaPai)
end

function GuildFindLsUI:hideMask()
    --app.log("self.Mark#######")
    self.timeid = timer.create(self.bindfunc["rushUI"],300,1)
end

function GuildFindLsUI:rushUI()

    self.resetbtn:set_enable(true)
    self.Mark:set_active(false)

    for i=1,9 do
		self.cardleftlist[i]:set_active(false)
	    --self.cardbg[i]:set_active(true)
	end

	if self.click_audio then
    	AudioManager.StopUiAudio(self.click_audio)
    	self.click_audio = nil;
    end
	
	g_SingleLockUI.Hide()
end

function choupaiend()
	local obj = uiManager:FindUI(EUI.GuildFindLsUI)
	
	obj:hidecardbg()
end

function GuildFindLsUI:hidecardbg()
	self.cardbg[self.currentindex]:set_active(false)
	self.Mark:set_active(false)
end

function GuildFindLsUI:playmove()
	self.startbtn:set_active(false) 
    self.playxipai:animated_play("ui_7201_search_tanchu")   
    --self.Mark:set_active(true) 
end

function GuildFindLsUI:setGameNumber()
    local number = g_dataCenter.GuildFindLs:getNumber()
    self.contlab_num:set_text("今日玩法次数[FCD901FF]"..tostring(number).."/"..tostring(self.MaxNumber).."[-]")
end

--判断是否免费
function GuildFindLsUI:isCoastPay()
    if #self.opendatainfo == 0 then
		self.isFrist = true
		-- self.startbtn:set_active(true)
		self.resetbtn:set_active(false)
    else
		self.isFrist = false
		self.resetbtn:set_active(true)
		--self.startbtn:set_active(false)
    end
    
    if self.isFrist then
		self.costpaydiv:set_active(false)
		self.costpayMflab:set_active(true)
    else
		self.costpaydiv:set_active(true)
		self.costpayMflab:set_active(false)
		self.currentNumber = #self.opendatainfo + 1
		if self.currentNumber > 9 then
		    self.currentNumber = 9
		end
		local payMoney = ConfigManager.Get(EConfigIndex.t_xunzhaolishi_open_cost,self.currentNumber).cost
		self.costpayMonyLab:set_text(tostring(payMoney))
    end
end

--复位
function GuildFindLsUI:on_reset()
    if self.isFrist then
		HintUI.SetAndShow(EHintUiType.zero,"还有免费次数未用,不需要刷新！");
		do return end
    end
    
    local number = g_dataCenter.GuildFindLs:getNumber()
    
    if number >= self.MaxNumber then
		--HintUI.SetAndShow(EHintUiType.zero,"今天的重置次数已用完");
		FloatTip.Float("今天的重置次数已用完");
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Guild_Find_Ls);
    else
    
		local number = g_dataCenter.GuildFindLs:getNumber()
		
		msg_xunzhaolishi.cg_reset()
	
    end
end

function GuildFindLsUI:on_start()
    
    local number = g_dataCenter.GuildFindLs:getNumber()
    
    g_dataCenter.GuildFindLs:addNumber()
    
    if number >= self.MaxNumber then
		--HintUI.SetAndShow(EHintUiType.zero,"今天的次数已用完");
		FloatTip.Float("今天的重置次数已用完");
		GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Guild_Find_Ls);
		do return end
    end
    
    self.Mark:set_active(true)
    g_SingleLockUI.Show()
    
    for i=1,9 do
	 	
		self.cardbg[i]:set_active(true)    
		
    end
	   
    self:playmovexipai()	
    
    self.startbtn:set_active(false)

    self:setGameNumber()
end

function GuildFindLsUI:BeginGame(t)
    
    self.Alldatainfo = g_dataCenter.GuildFindLs:getAllDataInfo()
    
    for i=1,9 do
		
		local iteminfo = self.Alldatainfo[i]
		--app.log("self.Alldatainfo[i]############"..tostring(iteminfo.id))
		local card_prop = CardProp:new({number = iteminfo.id,count = iteminfo.count})
		
		self.ui_small_item[i]:SetData(card_prop)
		self.ui_small_item[i]:SetEnablePressGoodsTips(true)
		self.ui_small_item[i]:SetCount(iteminfo.count)
		local itemobj = PublicFunc.IdToConfig(iteminfo.id)
		self.carditemtxt[i]:set_text(itemobj.name)

		
	 --    if i == 9 then
		--     self.startbtn:set_enable(true) 
		-- end
	    
	    --self.startbtn:set_active(true)
	    
	end

	self.startbtn:set_active(false) 

	self.resetbtn:set_active(false)

	self:playmove()
end

function GuildFindLsUI:on_click_Open(t)
      
    --self.isFrist = false

    
	local index = t.float_value;

	--app.log("on_click_Open ###################"..tostring(index))
	
	if self.Checklist[index-1] then
	
	else
	    self.Checklist[index-1] = true
	    msg_xunzhaolishi.cg_open(index-1)
	end
    
end

function GuildFindLsUI:on_click_call(index,item,result)
   	
   	--app.log("result################"..tostring(result))
    if result ~= 0 then
    	local ind = index + 1
    	--app.log("index###############"..tostring(ind))
    	self.Checklist[index] = false
    else
	    self.isFrist = false
	    local ind = index + 1
	    self.currentindex = ind
	    --self.cardbgline[ind]:set_active(false)
	    self.cardlist[ind]:animated_play("ui_7201_search_dianji")
	    self.Mark:set_active(true)
	    --self.cardbg[i]:set_active(false)
	    --local iteminfo = item.Item
	    --app.log("self.Alldatainfo[i]############"..tostring(iteminfo.id))
	    local card_prop = CardProp:new({number = item.id,count = item.count})
	    self.ui_small_item[ind]:SetData(card_prop)
	    self.ui_small_item[ind]:SetEnablePressGoodsTips(true)
	    self.ui_small_item[ind]:SetCount(item.count)
	    local itemobj = PublicFunc.IdToConfig(item.id)
	    self.carditemtxt[ind]:set_text(itemobj.name)
	    table.insert(self.opendatainfo,{index = index,Item = item})
	    self:isCoastPay()
	    if item.id == 20002025 then
			CommonAward.Start({{id = 20002025,count = item.count}}, tType)
	    else
			FloatTip.Float( "获得："..card_prop.name .."X"..tostring(item.count));
		    AudioManager.PlayUiAudio(ENUM.EUiAudioType.ShopMoney)
	    end
	end
    
    --self.Check = true
end

function GuildFindLsUI:on_reset_call()
    --app.log("on_reset_call##################")
    
    self.Mark:set_active(false)
 	self.startbtn:set_active(false)
    self.Alldatainfo = g_dataCenter.GuildFindLs:getAllDataInfo()
    self.opendatainfo = {}
    g_dataCenter.GuildFindLs:clearOpendatainfo()
    self:restcardleftlist()
    self:setGameNumber()
    self:isCoastPay()
    self:BeginGame()
    self.isFast = false;
    self.Checklist = {}
    
end

function GuildFindLsUI:restcardleftlist()
    for i=1,9 do
		self.cardleftlist[i]:set_position(self.cardleftposlist[i][1],self.cardleftposlist[i][2],self.cardleftposlist[i][3])
		self.cardbg[i]:set_active(false)
		self.cardleftlist[i]:set_active(true)
		--self.cardleftlist[i]:set_color(1,1,1,1)
    end
    
end

function GuildFindLsUI:on_record()
    uiManager:PushUi(EUI.GuildFindLsRe);
end

function GuildFindLsUI:show_ls_info()

	local isHavehero = self:isHaveHero(30025300)
	--app.log("isHavehero"..tostring(isHavehero))
	if isHavehero ~= "" then
		local lsinfo = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, isHavehero);
		--app.log("lsinfo=========="..table.tostring(lsinfo))
		local data = 
	    {   info = lsinfo,
	        isPlayer = true,
	        heroDataList = {},
	    } 

	    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
	else
		local lsinfo = CardHuman:new({number=30025300});
		local data = 
	    {   info = lsinfo,
	        isPlayer = true,
	        heroDataList = {},
	    }

	    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
	end
end

function GuildFindLsUI:isHaveHero(id)
    
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
	local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local dataid = "";
    for k,v in pairs(haveherolist)do
	if v.default_rarity == id then
	    dataid = v.index
        break;
	end
    end
        
    return dataid
end





ChurchBotBattleList = Class("ChurchBotBattleList", UiBaseClass)

function ChurchBotBattleList:Init(data)
    self.ChurchBotBattleList = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1612_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotBattleList:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotBattleList:InitData(data)
    self.currentindex = 1
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotBattleList:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotBattleList:DestroyUi()
    
    UiBaseClass.DestroyUi(self);

end

function ChurchBotBattleList:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["setData"] = Utility.bind_callback(self, self.setData)
    self.bindfunc["getfightRecord"] = Utility.bind_callback(self, self.getfightRecord)
    self.bindfunc["getfightRecordfast"] = Utility.bind_callback(self, self.getfightRecordfast)
    self.bindfunc["on_award"] = Utility.bind_callback(self, self.on_award)
    
end


--注册消息分发回调函数
function ChurchBotBattleList:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_request_church_fight_record, self.bindfunc["setData"])
    PublicFunc.msg_regist(msg_activity.gc_get_fightRecord_vigor, self.bindfunc["on_award"])
end

--注销消息分发回调函数
function ChurchBotBattleList:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_request_church_fight_record, self.bindfunc["setData"])
    PublicFunc.msg_unregist(msg_activity.gc_get_fightRecord_vigor, self.bindfunc["on_award"])
end


--初始化UI
function ChurchBotBattleList:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotBattleList');
    
    self.closebtn = ngui.find_button(self.ui,"center_other/animation/content_di_1004_564/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_btn_close'])
    
    self.getallbtn = ngui.find_button(self.ui,"center_other/animation/btn1")
    self.getallbtn:set_on_click(self.bindfunc['getfightRecordfast'])
    self.getallbtn:set_active(false)
    
    self.scroll_view = ngui.find_wrap_content(self.ui,"center_other/animation/scroll_view/panel_list/wrap_content")
    self.scroll_view:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    
    self.panel_mark = ngui.find_scroll_view(self.ui,"center_other/animation/scroll_view/panel_list")
    
    msg_activity.cg_request_church_fight_record()
    
end

function ChurchBotBattleList:setData(vecFightRecordData)
    self.battlelist = vecFightRecordData
    --app.log("battlelist##########"..table.tostring(self.battlelist));
    if self.battlelist then
	local cnt = #self.battlelist;
	
	self.scroll_view:set_min_index(-cnt+1);
	self.scroll_view:set_max_index(0);
	self.scroll_view:reset();
	self.panel_mark:reset_position();

    if cnt > 0 then
        self.getallbtn:set_active(false)
    else
        self.getallbtn:set_active(false)
    end

    end
end

function ChurchBotBattleList:init_item_wrap_content(obj,b,real_id)
    
    local index = math.abs(real_id)+1;
    
    local data = self.battlelist[index];
    
    local win = ngui.find_sprite(obj,"sp_win")
    --local lose = ngui.find_sprite(obj,"sp_lose")
    local name = ngui.find_label(obj,"lab_name")
    local lvl = ngui.find_label(obj,"lab_name/lab_level")
    local battle = ngui.find_label(obj,"sp_fight/lab_fight")
    local time = ngui.find_label(obj,"lab_time")
    
    --local headicon = ngui.find_button(obj,"sp_head_di_item")
    local headicon = obj:get_child_by_name('sp_head_di_item')
    self.headUiItem = UiPlayerHead:new({parent = headicon})
    
    --local gem = ngui.find_sprite(obj,"lab_time/sp_gem")
    --local gemnum = ngui.find_label(obj,"lab_time/sp_gem/lab")
    --local gold = ngui.find_sprite(obj,"lab_time/sp_gold")
    --local goldnum = ngui.find_label(obj,"lab_time/sp_gold/lab")
    --local power = ngui.find_sprite(obj,"lab_time/sp_power")
    --local powernum = ngui.find_label(obj,"lab_time/sp_power/lab")
    
    local itemlist = {}
    local itemnumblist = {}
    itemlist[1] = ngui.find_texture(obj,"lab_time/sp_gem")
    itemlist[2] = ngui.find_texture(obj,"lab_time/sp_gold")
    itemlist[3] = ngui.find_texture(obj,"lab_time/sp_power")
    
    itemnumblist[1] = ngui.find_label(obj,"lab_time/sp_gem/lab")
    itemnumblist[2] = ngui.find_label(obj,"lab_time/sp_gold/lab")
    itemnumblist[3] = ngui.find_label(obj,"lab_time/sp_power/lab")
    
    itemnumblist[1]:set_text("")
    itemnumblist[2]:set_text("")
    itemnumblist[3]:set_text("")
    
    for k,v in pairs(data.vecLostReward)do
    	local info = CardProp:new({number = v.id})
    	--app.log("info############"..table.tostring(info))
    	itemlist[k]:set_texture(info.config[4])
    	itemnumblist[k]:set_text(tostring(v.count))
    end
    
    local getbtn = ngui.find_button(obj,"btn1")
    getbtn:set_on_click(self.bindfunc['getfightRecord'])
    getbtn:set_event_value("", index)
    getbtn:set_active(false)
    
    if data.bDefendWin then
    	-- win:set_active(true)
    	-- lose:set_active(false)
        
        win:set_sprite_name("zb_lose")
    else
    	-- lose:set_active(true)
    	-- win:set_active(false)
        win:set_sprite_name("zb_win")
    end
    
    self.headUiItem:SetRoleId(data.enemyImage)
    
    name:set_text(data.szEnemyPlayerName)
    lvl:set_text(tostring(data.playerLevel))
    battle:set_text(tostring(data.playerFightValue))
    
    if data.bGetVigor then
	   getbtn:set_active(false)
    else
	   getbtn:set_active(true)
    end
    
    local nowtime = system.time()
    local lasttime = tonumber(data.happenTime)
    
    local casttime = nowtime - lasttime
    
    local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(casttime);
    
    if data.bDefendWin then
	time:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec).."前 偷袭了你的探索区域")
    else
	time:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec).."前 偷袭了你的探索区域并获得了")
    end
    
end

function ChurchBotBattleList:on_btn_close()
    uiManager:PopUi();
end

function ChurchBotBattleList:getfightRecord(t)
    local index = t.float_value
    local dataid = self.battlelist[index].dataid;
    if self.battlelist[index].bGetVigor then
	FloatTip.Float("已领取过精力！");
    else
	msg_activity.cg_get_fightRecord_vigor(dataid,false)
    end
end

function ChurchBotBattleList:getfightRecordfast(t)
    --local dataidlist = data
    if self.battlelist then
        local cnt = #self.battlelist;
        if cnt > 0 then
            msg_activity.cg_get_fightRecord_vigor("0",1)
        else
            FloatTip.Float("没有可领取的精力");
        end
    end
end

function ChurchBotBattleList:UpdateUi()
    
end

function ChurchBotBattleList:on_award(getVigorCnt,dataid,byFast)
    --app.log("dataid##########"..type(dataid));
    if getVigorCnt > 0 then
	local FightReport = g_dataCenter.ChurchBot:getFightReport()
	--app.log("FightReport##########"..table.tostring(FightReport));
	local TFightReportlist = {}
	for k,v in pairs( FightReport ) do
	    table.insert(TFightReportlist,v)
	end
	
	local sortFunc = function(a,b)
	    if tonumber(a.happenTime) > tonumber(b.happenTime) then
		return true
	    else
		return false 
	    end
	end
	
	--排序处理
	table.sort(TFightReportlist,sortFunc);
	local FightReportlist = {}
	for k,v in pairs(TFightReportlist)do
	    table.insert(FightReportlist,v)    
	end
    	
	self:setData(FightReportlist)
	
	local callback = function()
	    self:Show()    
	end
	
	local item = { {id=20000135,
			dataid='',
			count=getVigorCnt}}
	CommonAward.Start(item, tType)
	CommonAward.SetFinishCallback(callback,self)
	self:Hide()
    else
	FloatTip.Float( "没有可领取的精力" );
    end
end




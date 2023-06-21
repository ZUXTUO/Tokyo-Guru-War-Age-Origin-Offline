
ChurchBotSelect = Class("ChurchBotSelect", UiBaseClass)

function ChurchBotSelect:GetNavigationAdvPlane()
    return true;
end

function ChurchBotSelect:ShowNavigationBar()
    return true
end

function ChurchBotSelect:Init(data)
    self.ChurchBotSelect = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1608_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotSelect:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotSelect:InitData(data)
    self.currentindex = 1
    self.currentitem = nil;
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotSelect:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotSelect:DestroyUi()
    
    for k,v in pairs(self.star_item)do
        for kk,vv in pairs(v) do
            vv:DestroyUi()
        end
    end
    
    self.currentindex = 1
    self.currentitem = nil;
    
    UiBaseClass.DestroyUi(self);

end

function ChurchBotSelect:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)      --关闭
    self.bindfunc["on_select"] = Utility.bind_callback(self, self.on_select)      --初级点击事件
    self.bindfunc["on_begin"] = Utility.bind_callback(self, self.on_begin)      --初级点击事件
    
end


--注册消息分发回调函数
function ChurchBotSelect:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function ChurchBotSelect:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function ChurchBotSelect:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotSelect');
    self.closebtn = ngui.find_button(self.ui,"centre_other/animation/content_di_1004_564/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_btn_close'])
    --初始化奖励ITEM
    self.primaryitem = {};
    self.intermediateitem = {};
    self.senioritem = {};
    
    self.primarybtn = ngui.find_button(self.ui,"centre_other/animation/texture1")
    self.primarybtn:set_event_value("",1)
    self.primarybtn:set_on_click(self.bindfunc['on_select'])
    
    self.intermediatebtn = ngui.find_button(self.ui,"centre_other/animation/texture2")
    self.intermediatebtn:set_event_value("",2)
    self.intermediatebtn:set_on_click(self.bindfunc['on_select'])
    
    self.seniorbtn = ngui.find_button(self.ui,"centre_other/animation/texture3")
    self.seniorbtn:set_event_value("",3)
    self.seniorbtn:set_on_click(self.bindfunc['on_select'])
    
    --文字显示
    self.labtxt = ngui.find_label(self.ui,"centre_other/animation/lab")
    
    self.star_item = {};
    for i=1,5 do
    	self.primaryitem[i] = self.ui:get_child_by_name("centre_other/animation/texture1/cont/new_small_card_item"..i)
    	self.intermediateitem[i] = self.ui:get_child_by_name("centre_other/animation/texture2/cont/new_small_card_item"..i)
    	self.senioritem[i] = self.ui:get_child_by_name("centre_other/animation/texture3/cont/new_small_card_item"..i)
    end
    
    self.deslab = {};
    self.bglist = {};
    
    for i=1,3 do
    	self.bglist[i] = ngui.find_sprite(self.ui,"centre_other/animation/texture"..i.."/sp_kuang")
    	self.bglist[i]:set_active(false)
    	self.deslab[i] = ngui.find_label(self.ui,"centre_other/animation/texture"..i.."/lab_num")
    end
    
    -- self.beginbtn = ngui.find_button(self.ui,"centre_other/animation/btn1")
    -- self.beginbtn:set_on_click(self.bindfunc["on_begin"])

    -- self.costmoney = ngui.find_label(self.ui,"centre_other/animation/sp_bar/lab2")
    
    self:setData()
end

function ChurchBotSelect:setData()
    local desdata = ConfigManager._GetConfigTable(EConfigIndex.t_church_pos_data);
    
    for k,v in pairs(desdata)do
	   self.deslab[k]:set_text(tostring(v.canPrayTime/3600))
    end

    local RefreshTimes = g_dataCenter.ChurchBot:getfindnumber()

    local CostMoneydata = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,RefreshTimes);
    local castmoney = CostMoneydata.cost

    -- self.costmoney:set_text(tostring(castmoney))
    
    local level = g_dataCenter.player.level;
    local botdata = ConfigManager.Get(EConfigIndex.t_church_pray_data,level)
    
    --app.log("botdata ###################"..table.tostring(botdata))
    
    --local star1_gold = botdata.star1_gold
    --local star1_exp = botdata.star1_exp
    --local star1_crystal = botdata.star1_crystal
    --
    --local star2_gold = botdata.star2_gold
    --local star2_exp = botdata.star2_exp
    --local star2_crystal = botdata.star2_crystal
    --local star2_study_point = botdata.star2_study_point
    --
    --local star3_gold = botdata.star3_gold
    --local star3_exp = botdata.star3_exp
    --local star3_crystal = botdata.star3_crystal
    --local star3_bronze_exp = botdata.star3_bronze_exp
    --local star3_train_exp = botdata.star3_train_exp
    
    
    --self.star1_item = {};
    --local card_prop = CardProp:new({number = 2,count = 0});
    --self.star1_item[1] = UiSmallItem:new({parent = self.primaryitem[1], cardInfo = card_prop,});
    --self.star1_item[1]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 6,count = 0});
    --self.star1_item[2] = UiSmallItem:new({parent = self.primaryitem[2], cardInfo = card_prop,});
    --self.star1_item[2]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 3,count = 0});
    --self.star1_item[3] = UiSmallItem:new({parent = self.primaryitem[3], cardInfo = card_prop,});
    --self.star1_item[3]:SetShowNumber(false)
    ---------
    --self.star2_item = {};
    --local card_prop = CardProp:new({number = 2,count = 0});
    --self.star2_item[1] = UiSmallItem:new({parent = self.intermediateitem[1], cardInfo = card_prop,});
    --self.star2_item[1]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 6,count = 0});
    --self.star2_item[2] = UiSmallItem:new({parent = self.intermediateitem[2], cardInfo = card_prop,});
    --self.star2_item[2]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 3,count = 0});
    --self.star2_item[3] = UiSmallItem:new({parent = self.intermediateitem[3], cardInfo = card_prop,});
    --self.star2_item[3]:SetShowNumber(false)
    ----------
    --self.star3_item = {};
    --local card_prop = CardProp:new({number = 2,count = 0});
    --self.star3_item[1] = UiSmallItem:new({parent = self.senioritem[1], cardInfo = card_prop,});
    --self.star3_item[1]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 6,count = 0});
    --self.star3_item[2] = UiSmallItem:new({parent = self.senioritem[2], cardInfo = card_prop,});
    --self.star3_item[2]:SetShowNumber(false)
    --
    --local card_prop = CardProp:new({number = 3,count = 0});
    --self.star3_item[3] = UiSmallItem:new({parent = self.senioritem[3], cardInfo = card_prop,});
    --self.star3_item[3]:SetShowNumber(false)
    --    
    --local card_prop = CardProp:new({number = 20000126,count = 0});
    --self.star3_item[4] = UiSmallItem:new({parent = self.senioritem[4], cardInfo = card_prop,});
    --self.star3_item[4]:SetShowNumber(false)
    
    for i =1,3 do
        self:setawardlist(i)
    end
    
end

function ChurchBotSelect:on_btn_close()
    
    ChurchBotLoad.Destroy()
    uiManager:PopUi();
end

function ChurchBotSelect:on_select(t)
    --ChurchBotLoad.Start()
    local value = t.float_value
    --app.log("value #############"..tostring(value))
    
    self.currentindex = value

    local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
    local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
    if g_dataCenter.player.gold < findcast then
        FloatTip.Float("金币不够！");
        do return end    
    end
    

    local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
    --app.log("myprayIndex ###########"..tostring(myprayIndex))
    g_dataCenter.ChurchBot:setnstar(self.currentindex)
    --uiManager:PushUi(EUI.ChurchBotTip,self.currentindex);
    msg_activity.cg_look_for_rival(self.currentindex,myprayIndex)
    uiManager:PopUi()
    
    -- for i =1,3 do
    --     self:setawardlist(i)
    -- end
    
    -- local txt = ""

    -- if value == 1 then
    --     txt = "初级探索可获得奖励："
    -- elseif value == 2 then
    --     txt = "中级探索可获得奖励："
    -- elseif value == 3 then
    --     txt = "高级探索可获得奖励："
    -- end

    -- self.labtxt:set_text(txt)
    --uiManager:PopUi();
    --uiManager:PushUi(EUI.ChurchBotTip,value);
        
end

function ChurchBotSelect:setawardlist(value)
    
    -- if self.currentitem then
	   -- self.currentitem:set_active(false)
    -- end
    
    -- self.bglist[value]:set_active(true)
    -- self.currentitem  = self.bglist[value]
    
    
    local paylist = ConfigManager.Get(EConfigIndex.t_church_pos_data,value);
    --app.log("paylist###################"..table.tostring(paylist))  
    
    local list = {}
    for k,v in pairs(paylist) do
	
    	if k == 7 and v ~= 0 then
    	    table.insert(list,v)
    	end
    	
    	if k == 9 and v ~= 0 then
    	    table.insert(list,v)
    	end
    	
    	if k == 11 and v ~= 0 then
    	    table.insert(list,v)
    	end
    	
    	if k == 13 and v ~= 0 then
    	    table.insert(list,v)
    	end
    	
    	if k == 15 and v ~= 0 then
    	    table.insert(list,v)
    	end
    end
    
    --app.log("list#############"..table.tostring(list))
    
 --    for k,v in pairs(self.primaryitem)do
	-- v:set_active(false)    
 --    end    
    self.star_item[value] = {}
    if value == 1 then
	   
        for k,v in pairs(list) do
        	local card_prop = CardProp:new({number = v,count = 0});
        	if self.star_item[value][k] then
        	    self.star_item[value][k]:SetData(card_prop)
        	else
        	    self.star_item[value][k] = UiSmallItem:new({parent = self.primaryitem[k], cardInfo = card_prop,});
        	    self.star_item[value][k]:SetShowNumber(false)
        	end
        	
        	self.primaryitem[k]:set_active(true)
        end

    elseif value == 2 then
        for k,v in pairs(list) do
            local card_prop = CardProp:new({number = v,count = 0});
            if self.star_item[value][k] then
                self.star_item[value][k]:SetData(card_prop)
            else
                self.star_item[value][k] = UiSmallItem:new({parent = self.intermediateitem[k], cardInfo = card_prop,});
                self.star_item[value][k]:SetShowNumber(false)
            end
            
            self.intermediateitem[k]:set_active(true)
        end

    elseif value ==3 then
        for k,v in pairs(list) do
            local card_prop = CardProp:new({number = v,count = 0});
            if self.star_item[value][k] then
                self.star_item[value][k]:SetData(card_prop)
            else
                self.star_item[value][k] = UiSmallItem:new({parent = self.senioritem[k], cardInfo = card_prop,});
                self.star_item[value][k]:SetShowNumber(false)
            end
            
            self.senioritem[k]:set_active(true)
        end

    end
	
--	local card_prop = CardProp:new({number = 2,count = 0});
--	if self.star_item[1] then
--	    self.star_item[1]:SetData(card_prop)
--	else
--	    self.star_item[1] = UiSmallItem:new({parent = self.primaryitem[1], cardInfo = card_prop,});
--	    self.star_item[1]:SetShowNumber(false)
--	end
--		
--	local card_prop = CardProp:new({number = 6,count = 0});
--	
--	if self.star_item[2] then
--	    self.star_item[2]:SetData(card_prop)
--	else
--	    self.star_item[2] = UiSmallItem:new({parent = self.primaryitem[2], cardInfo = card_prop,});
--	    self.star_item[2]:SetShowNumber(false)
--	end
--	
--	local card_prop = CardProp:new({number = 3,count = 0});
--	
--	if self.star_item[3] then
--	    self.star_item[3]:SetData(card_prop)
--	else
--	    self.star_item[3] = UiSmallItem:new({parent = self.primaryitem[3], cardInfo = card_prop,});
--	    self.star_item[3]:SetShowNumber(false)
--	end
--	
--	self.primaryitem[1]:set_active(true)
--	self.primaryitem[2]:set_active(true)
--	self.primaryitem[3]:set_active(true)
--	
--    --elseif value == 2 then
--	local card_prop = CardProp:new({number = 2,count = 0});
--	if self.star_item[1] then
--	    self.star_item[1]:SetData(card_prop)
--	else
--	    self.star_item[1] = UiSmallItem:new({parent = self.primaryitem[1], cardInfo = card_prop,});
--	    self.star_item[1]:SetShowNumber(false)
--	end
--	
--	local card_prop = CardProp:new({number = 6,count = 0});
--	if self.star_item[2] then
--	    self.star_item[2]:SetData(card_prop)
--	else
--	    self.star_item[2] = UiSmallItem:new({parent = self.primaryitem[2], cardInfo = card_prop,});
--	    self.star_item[2]:SetShowNumber(false)
--	end
--	
--	local card_prop = CardProp:new({number = 3,count = 0});
--	if self.star_item[3] then
--	    self.star_item[3]:SetData(card_prop)
--	else
--	    self.star_item[3] = UiSmallItem:new({parent = self.primaryitem[3], cardInfo = card_prop,});
--	    self.star_item[3]:SetShowNumber(false)
--	end
--	
--	self.primaryitem[1]:set_active(true)
--	self.primaryitem[2]:set_active(true)
--	self.primaryitem[3]:set_active(true)
--	
--    --elseif value == 3 then
--	local card_prop = CardProp:new({number = 2,count = 0});
--	if self.star_item[1] then
--	    self.star_item[1]:SetData(card_prop)
--	else
--	    self.star_item[1] = UiSmallItem:new({parent = self.primaryitem[1], cardInfo = card_prop,});
--	    self.star_item[1]:SetShowNumber(false)
--	end
--	
--	local card_prop = CardProp:new({number = 6,count = 0});
--	if self.star_item[2] then
--	    self.star_item[2]:SetData(card_prop)
--	else
--	    self.star_item[2] = UiSmallItem:new({parent = self.primaryitem[2], cardInfo = card_prop,});
--	    self.star_item[2]:SetShowNumber(false)
--	end
--	
--	local card_prop = CardProp:new({number = 3,count = 0});
--	
--	if self.star_item[3] then
--	    self.star_item[3]:SetData(card_prop)
--	else
--	    self.star_item[3] = UiSmallItem:new({parent = self.primaryitem[3], cardInfo = card_prop,});
--	    self.star_item[3]:SetShowNumber(false)
--	end
--	    
--	local card_prop = CardProp:new({number = 20000126,count = 0});
--	
--	if self.star_item[4] then
--	    self.star_item[4]:SetData(card_prop)
--	else
--	    self.star_item[4] = UiSmallItem:new({parent = self.primaryitem[4], cardInfo = card_prop,});
--	    self.star_item[4]:SetShowNumber(false)
--	end
--	
--	self.primaryitem[1]:set_active(true)
--	self.primaryitem[2]:set_active(true)
--	self.primaryitem[3]:set_active(true)
--	self.primaryitem[4]:set_active(true)
--    --end
end

function ChurchBotSelect:on_begin()
    local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
    local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
    if g_dataCenter.player.gold < findcast then
        FloatTip.Float("金币不够！");
        do return end    
    end
       
    --uiManager:PopUi();
    --app.log("SelectCurrentindex ###########"..tostring(self.currentindex))
    local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
    --app.log("myprayIndex ###########"..tostring(myprayIndex))
    g_dataCenter.ChurchBot:setnstar(self.currentindex)
    --uiManager:PushUi(EUI.ChurchBotTip,self.currentindex);
    msg_activity.cg_look_for_rival(self.currentindex,myprayIndex)
    uiManager:PopUi()
end

function ChurchBotSelect:UpdateUi()
    
end

function ChurchBotSelect:Show()
    if UiBaseClass.Show(self) then
        self:setData()
    end
end




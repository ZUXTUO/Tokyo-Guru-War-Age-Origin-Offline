
TrainningMain = Class("TrainningMain", UiBaseClass)

-------------------------------------外部调用-------------------------------------
function TrainningMain:GetNavigationAdvPlane()
    return true;
end
function TrainningMain:ShowNavigationBar()
    return true
end

function TrainningMain:Init(data)
    self.TrainningMain = data
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4602_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function TrainningMain:Restart(data)
    --app.log("Restart #########################")
    
    for k,v in pairs(self.AllHerolist )do
	--app.log("kk##"..tostring(k))
	self.herolist[k] = {};
	self.Theroheadlist[k] = {};
	--self.grid[k] = {};
    end
    
    if UiBaseClass.Restart(self, data) then
	--app.log("UpdateUi #########################")
    end
end

function TrainningMain:InitData(data)
    --app.log("InitData #########################")
    
    self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);--g_dataCenter.trainning:getUIlist()
    self.AllHeroLine = #self.AllHerolist
    --app.log(" ALL Hero List #########################"..table.tostring(self.AllHerolist).."AllHeroLine ##########"..tostring(self.AllHeroLine))
    self.Theroheadlist = {};
    self.herolist = {};
    self.grid = {};
    self.currentgroup = 1;
    self.allqnvalue = 0;
    
    self.random = 0;
    --app.log(" ALL Hero List #########################"..table.tostring(self.AllHerolist[self.currentgroup]).."AllHeroLine ##########"..tostring(self.AllHeroLine))
    for k,v in pairs(self.AllHerolist )do
	--app.log("kk##"..tostring(k))
	self.herolist[k] = {};
	self.Theroheadlist[k] = {};
	--self.grid[k] = {};
    end
    
    UiBaseClass.InitData(self, data)
    
end

function TrainningMain:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function TrainningMain:DestroyUi()
    
--    for k ,v in pairs(self.Theroheadlist) do
--	for kk,vv in pairs(v)do
--	    --vv:Hide()
--	    vv:DestroyUi()
--	    vv = nil;
--	end
--    end
    self.currentgroup = 1;
    self.Theroheadlist = {};
    
    if Trainninginfotip.instance then
        Trainninginfotip.instance:DestroyUi();
	Trainninginfotip.instance = nil;
    end
    
    UiBaseClass.DestroyUi(self);

end

function TrainningMain:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_OpenDaRen'] = Utility.bind_callback(self, self.on_click_OpenDaRen);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['on_select_role'] = Utility.bind_callback(self, self.on_select_role);
    self.bindfunc['on_show_info'] = Utility.bind_callback(self, self.on_show_info);
    
    self.bindfunc['on_last_btn'] = Utility.bind_callback(self, self.on_last_btn);
    self.bindfunc['on_next_btn'] = Utility.bind_callback(self, self.on_next_btn);
    self.bindfunc['computAllQnvalue'] = Utility.bind_callback(self, self.computAllQnvalue);
    self.bindfunc['on_list_stop'] = Utility.bind_callback(self, self.on_list_stop);
    self.bindfunc['on_show_info_all'] = Utility.bind_callback(self, self.on_show_info_all);
end


--注册消息分发回调函数
function TrainningMain:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_use_training_hall_item, self.bindfunc["computAllQnvalue"])
end

--注销消息分发回调函数
function TrainningMain:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_use_training_hall_item, self.bindfunc["computAllQnvalue"])
end


--初始化UI
function TrainningMain:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('TrainningMain');

    self.xunliandarenBtn = ngui.find_button(self.ui,"centre_other/animation/btn_paihang")
    self.xunliandarenBtn:set_on_click(self.bindfunc['on_click_OpenDaRen']);
    
    self.herolistview = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/scroll_view/panel_list")
    self.herolistview:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    --self.listitem = self.ui:get_child_by_name("centre_other/animation/scroll_view/panel_list/wrap_content/item")
    
    self.scroll_view = ngui.find_scroll_view(self.ui, "centre_other/animation/scroll_view/panel_list");
    
    self.allqnvalue  = ngui.find_label(self.ui,"centre_other/animation/cont/down_tips");
    self.allqnvaluebtn  = ngui.find_button(self.ui,"centre_other/animation/cont/sp_but")

    self.lastbtn = ngui.find_button(self.ui,"centre_other/animation/btn_right")
    self.lastbtn:set_on_click(self.bindfunc['on_last_btn'])
    self.lastbtnpoint = ngui.find_sprite(self.ui,"centre_other/animation/btn_right/animation/sp_point")
    
    self.nextbtn = ngui.find_button(self.ui,"centre_other/animation/btn_left")
    self.nextbtn:set_on_click(self.bindfunc['on_next_btn'])
    self.nextbtnpoint = ngui.find_sprite(self.ui,"centre_other/animation/btn_left/animation/sp_point")
    
    self.currentyema = ngui.find_label(self.ui,"centre_other/animation/lab_fanye")
    self.currentyema:set_text("页数"..tostring(self.currentgroup).."/"..tostring(#self.AllHerolist))
    self.allqnvaluebtn:set_on_click(self.bindfunc['on_show_info_all'])
    --self.listitem:set_active(true)
    --self.herolistitem = self.ui:get_child_by_name("centre_other/animation/scroll_view/panel_list/wrap_content/item/sp_bg/grid/hero_suffering_item")
    
    self.groupnametitle = ngui.find_label(self.ui,"centre_other/animation/top_tips_sp/lab_name")
    local titedata = ConfigManager.Get(EConfigIndex.t_training_hall_grouping_name,self.currentgroup).group_name
    self.groupnametitle:set_text(titedata)
    
    self.grouplvltitle = ngui.find_label(self.ui,"centre_other/animation/top_tips_sp/lab_lv")
    --local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentgroup]
    --local battleLvl = battledata.low
    local battleLvl = 150;
    self.grouplvltitle:set_text("等级[FDE517FF]"..tostring(battleLvl).."[-]")
    
    --self.allqnvalue = ngui.find_label(self.ui,"centre_other/animation/cont/down_tips")
    
    self.fx = self.ui:get_child_by_name("centre_other/animation/texture1/fx_ui_4602_door")
    self.fx:set_active(false)

    self:computAllQnvalue()
    --self:UpdateUi()
    --self:isHaveHero()
    local cnt = #self.AllHerolist;
    --app.log("cnt##############"..tostring(cnt))
    --self.herolistview:set_min_index(0);
    self.herolistview:set_maxNum(cnt);
    self.herolistview:set_on_stop_move(self.bindfunc['on_list_stop'])
    --self.herolistview:reset();
    --self.scroll_view:reset_position(); 
    
    self:set_red_point()
end

--计算总的全能值
function TrainningMain:computAllQnvalue()
    
    local haveherolist = {}
    
    for k,v in pairs(self.AllHerolist)do
	
	for kk,vv in pairs(v)do
	    local dataid = self:isHaveHero(vv[2])
	    if dataid ~= "" then
		table.insert(haveherolist,{id = vv[2],group = vv[2]})
	    end
	end
    end
    
    --app.log("##########herolist"..table.tostring(haveherolist))
    
    self:computhaveheroqnvalue(haveherolist)
    
end

function TrainningMain:on_next_btn(t)
    self.currentgroup = self.currentgroup - 1;
    if self.currentgroup < 1 then
	self.currentgroup = 8;
    end 
    self.herolistview:tween_to_index(self.currentgroup)
    do return end
--    local allpage = #self.AllHerolist
--    if self.currentgroup == allpage then
--	do return end
--    end
--    
--    if self.currentgroup < allpage then
--	self.currentgroup = self.currentgroup +1
--    else
--	self.currentgroup = allpage
--    end
--    self:set_pagetext()
--    self:rushPagelist()
end

function TrainningMain:on_list_stop(index)
    self.currentgroup = index;
    self:set_pagetext()
end 

function TrainningMain:on_show_info_all(t)
    UiRuleDes.Start(43);
end

function TrainningMain:on_last_btn(t)
    --local allpage = #self.AllHerolist
    self.currentgroup = self.currentgroup + 1;
    if self.currentgroup > 8 then
	self.currentgroup = 1;
    end 
    self.herolistview:tween_to_index(self.currentgroup)
    do return end;
    
--    if self.currentgroup == 1 then
--	do return end
--    end
--    
--    if self.currentgroup > 1 then
--	self.currentgroup = self.currentgroup -1
--    else
--	self.currentgroup = 1
--    end
--    self:set_pagetext()
--    self:rushPagelist()
end

function TrainningMain:set_pagetext()
    self.currentyema:set_text("页数" .. tostring(self.currentgroup) .. "/" .. tostring(#self.AllHerolist))
    local titedata = ConfigManager.Get(EConfigIndex.t_training_hall_grouping_name, self.currentgroup).group_name
    self.groupnametitle:set_text(titedata)

    local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentgroup]
    local battleLvl = battledata and battledata.low or 0

    if battledata == nil then
        app.log("Warning: battledata is nil for currentgroup: " .. tostring(self.currentgroup))
        -- 设置默认的 battleLvl
        battleLvl = 1 -- 或者其他默认值
    end

    self.grouplvltitle:set_text("等级" .. tostring(battleLvl))

    self:set_red_point()
end


function TrainningMain:set_red_point()
    local nextcurrentgroup = 0

    if self.currentgroup == 8 then
        nextcurrentgroup = 1
    else
        nextcurrentgroup = self.currentgroup + 1
    end

    local lastcurrentgroup = 0

    if self.currentgroup == 1 then
        lastcurrentgroup = 8
    else
        lastcurrentgroup = self.currentgroup -1
    end

    if nextcurrentgroup == 0 then
        do return end
    end

    if lastcurrentgroup == 0 then
        do return end
    end

    local nextflag = g_dataCenter.trainning:computitem(nextcurrentgroup)
    local lastflag = g_dataCenter.trainning:computitem(lastcurrentgroup)

    local nexthave = g_dataCenter.trainning:computhero(nextcurrentgroup)
    local lasthave = g_dataCenter.trainning:computhero(lastcurrentgroup)

    -- app.log("nexthave..........."..tostring(nexthave))
    -- app.log("lasthave............"..tostring(lasthave))
    
    if nexthave then
        if nextflag then
            self.lastbtnpoint:set_active(true)
        else
            self.lastbtnpoint:set_active(false)
        end
    else
        self.lastbtnpoint:set_active(false)
    end

    if lasthave then
        if lastflag then
            self.nextbtnpoint:set_active(true)
        else
            self.nextbtnpoint:set_active(false)
        end
    else
        self.nextbtnpoint:set_active(false)
    end

end

function TrainningMain:rushPagelist()
    local cnt = #self.AllHerolist[self.currentgroup];
    --app.log("cnt##############"..tostring(cnt))
    self.herolistview:set_min_index(0);
    self.herolistview:set_max_index(cnt-1);
    self.herolistview:reset();
    self.scroll_view:reset_position();  
end

function TrainningMain:computhaveheroqnvalue(haveherolist)
    local allqnvalue = 0;
    for k,v in pairs(haveherolist)do
	local configname = "t_training_hall_"..tostring(v.group)
	----app.log("##########configname  "..tostring(configname))
	local dataid = self:isHaveHero(v.id)
	local cardinfo = g_dataCenter.package:find_card(1, dataid);
	--local lvlindex = cardinfo.trainingHallLevel
    local lvlindex = 7
	local trainningdata = ConfigManager.Get(EConfigIndex[configname],lvlindex)
	--app.log("trainningdata #######"..table.tostring(trainningdata))
	allqnvalue = allqnvalue + trainningdata.qn_power
    end
    
    self.allqnvaluetextvalue = allqnvalue;
    self.allqnvalue:set_text("战队总全能："..tostring(allqnvalue))
end

function TrainningMain:on_show_info(name, state, x, y, go_obj)
    --local addattr = ConfigManager.Get(EConfigIndex[configname],lvlindex)
    --local flag = nil;
    
    --local x,y,z = go_obj:get_position()
     
    --local px ,py ,pz= PublicFunc.GetUiWorldPosition(go_obj,"ui_2d")
    --app.log("go_obj#####################"..tostring(go_obj:get_name()))
    --app.log("px############################"..tostring(px))
    --app.log("py############################"..tostring(py))
    --app.log("z############################"..tostring(z))
    
    local data = {}
    data.x = x
    data.y = y
    data.z = self.allqnvaluebtn:get_height()
    --data.z = pz
    local adddata = ConfigManager.Get(EConfigIndex.t_discrete,83000123).data;
    local Damagedata = ConfigManager.Get(EConfigIndex.t_discrete,83000124).data;
    
    local value1 = self:GetPreciseDecimal(adddata*self.allqnvaluetextvalue,2)
    local value2 = self:GetPreciseDecimal(Damagedata*self.allqnvaluetextvalue,2)
    
    data.value = "加伤率："..value1.."%".."\n".."减伤率："..value2.."%"
    
    --data.allqnvalue = self.allqnvalue

    if state == true then
	Trainninginfotip.Start(data)
    else
	Trainninginfotip.Destroy()
    end
end

--取小数点后n位
function TrainningMain:GetPreciseDecimal(nNum, n)
    if type(nNum) ~= "number" then
        return nNum;
    end
    
    n = n or 0;
    n = math.floor(n)
    local fmt = '%.' .. n .. 'f'
    local nRet = string.format(fmt, nNum)

    return nRet;

end

function TrainningMain:createItem(obj)
    local item = {};
    item.room1 = obj:get_child_by_name("new_small_card_item1");
    item.room2 = obj:get_child_by_name("new_small_card_item2");
    item.room3 = obj:get_child_by_name("new_small_card_item3");
    item.room4 = obj:get_child_by_name("new_small_card_item4");
    item.room5 = obj:get_child_by_name("new_small_card_item5");
    item.room6 = obj:get_child_by_name("new_small_card_item6");
    item.room7 = obj:get_child_by_name("new_small_card_item7");
    item.room8 = obj:get_child_by_name("new_small_card_item8");
    item.card1 = SmallCardUi:new({parent=item.room1,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card2 = SmallCardUi:new({parent=item.room2,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card3 = SmallCardUi:new({parent=item.room3,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card4 = SmallCardUi:new({parent=item.room4,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card5 = SmallCardUi:new({parent=item.room5,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card6 = SmallCardUi:new({parent=item.room6,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card7 = SmallCardUi:new({parent=item.room7,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    item.card8 = SmallCardUi:new({parent=item.room8,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}});
    
    -- item.card1:SetInfoType(3)
    -- item.card2:SetInfoType(3)
    -- item.card3:SetInfoType(3)
    -- item.card4:SetInfoType(3)
    -- item.card5:SetInfoType(3)
    -- item.card6:SetInfoType(3)
    -- item.card7:SetInfoType(3)
    -- item.card8:SetInfoType(3)   
    
    item.card1:SetCallback(self.bindfunc['on_select_role']);
    item.card2:SetCallback(self.bindfunc['on_select_role']);
    item.card3:SetCallback(self.bindfunc['on_select_role']);
    item.card4:SetCallback(self.bindfunc['on_select_role']);
    item.card5:SetCallback(self.bindfunc['on_select_role']);
    item.card6:SetCallback(self.bindfunc['on_select_role']);
    item.card7:SetCallback(self.bindfunc['on_select_role']);
    item.card8:SetCallback(self.bindfunc['on_select_role']);
    item.trainningMain = self;
    item.grid = ngui.find_grid(obj,obj:get_name());
    
    function item:setData(data,index)
	self.data = data;
	self.index = index;
	--app.log("item.trainningMain######################"..tostring(item.trainningMain.currentgroup))
	local isCanUp = g_dataCenter.trainning:computitem(index)
	--app.log("isCanUp######################"..tostring(isCanUp))
	for i = 1,8 do
	    if data[i] == nil then
    		self["room"..i]:set_active(false);
    	--	self["card"..i]:Hide();
	    else
    		self["room"..i]:set_active(true);
    		local dataid = self.trainningMain:isHaveHero(data[i][2])
    		if dataid ~= "" then
    		    local cardinfo = g_dataCenter.package:find_card(1, dataid);

                -- 检查 cardinfo 是否为 nil
                if cardinfo == nil then
                    app.log("Warning: cardinfo is nil for dataid: " .. tostring(dataid))
                    -- 创建一个默认的 cardinfo
                    cardinfo = CardHuman:new({
                        number = data[i][2],
                        default_rarity = 1, -- 默认稀有度
                        trainingHallLevel = 1, -- 默认训练大厅等级
                        name = "默认英雄", -- 默认名称
                        -- 其他默认属性可以在这里添加
                    })
                else
                    --self["card"..i]:SetInfoType(1)
    		        self["card"..i]:SetData(cardinfo);
                    local sprite_name = PublicFunc.computitemlevlsprite(cardinfo.default_rarity,cardinfo.trainingHallLevel)

                    --app.log("sprite_name1-------------"..sprite_name)
                    --self["card"..i]:SetFrameSpName(sprite_name)
                    self["card"..i]:SetTrainningRarity(sprite_name)
    		        self["card"..i]:SetGray(false)
                    local isMax = g_dataCenter.trainning:computMax(cardinfo)

    		        if isCanUp and isMax == false then
        		    	self["card"..i]:SetSpNew(true)
    		        else
        		    	self["card"..i]:SetSpNew(false)
    		        end
                    -- app.log("cardinfo========1"..cardinfo.trainingHallLevel)
                    -- app.log("cardinfo========1rarity"..cardinfo.default_rarity)
                    local name,rarity = PublicFunc.ProcessNameSplit(cardinfo.name)
                    local playername = PublicFunc.computitemlevelName(cardinfo.default_rarity,cardinfo.trainingHallLevel,name)
                    --self["card"..i]:SetPlayerName(playername)
                end
    		else
    		    local cardinfo = CardHuman:new({number=data[i][2], isNotCalProperty = true});
    		    --self["card"..i]:SetInfoType(3)
                self["card"..i]:SetData(cardinfo);
                local sprite_name = PublicFunc.computitemlevlsprite(cardinfo.default_rarity,cardinfo.trainingHallLevel)
                --app.log("sprite_name2-------------"..sprite_name)
                --self["card"..i]:SetFrameSpName(sprite_name)
                self["card"..i]:SetTrainningRarity(sprite_name)
    		    self["card"..i]:SetGray(true)
    		    self["card"..i]:SetSpNew(false)
                -- app.log("cardinfo========2"..cardinfo.trainingHallLevel)
                -- app.log("cardinfo========2rarity"..cardinfo.default_rarity)
                local name,rarity = PublicFunc.ProcessNameSplit(cardinfo.name)
                local playername = PublicFunc.computitemlevelName(cardinfo.default_rarity,cardinfo.trainingHallLevel,name)
                --self["card"..i]:SetPlayerName(playername)
    		end

            
		--self["card"..i]:Show();
	    end 
	end
	self.grid:reposition_now();
    end
    return item;
end

function TrainningMain:init_item_wrap_content( obj,index)
    local pid = obj:get_instance_id();
    self.barList = self.barList or {};
    self.barList[pid] = self.barList[pid] or self:createItem(obj);
    
    local data = self.AllHerolist[index]--[index];
    
    --app.log("index ##################"..index)
    --app.log("data###############"..table.tostring(data))
    if data ~= nil then 
    --local dataid = self:isHaveHero(data[2])
        self.barList[pid]:setData(data,index);
    end 
end

--function TrainningMain:init_item_wrap_content( obj,index)
--    --app.log("init_item_wrap_content #########################")
--    --do return end
--    local index = math.abs(real_id)+1;
--    
--    local bb = b+1;
--    
--    local data = self.AllHerolist[self.currentgroup][index];
--    
--    --app.log("data############"..table.tostring(data))
--    
--    local dian = ngui.find_sprite(obj,"dian")
--    
--    
--    local stars = obj:get_child_by_name("xin")
--    
--    --math.randomseed(tostring(os.time()):reverse():sub(1, 6))  
--    
--    --local number = math.random(10)
--    
--    self.random = self.random + 1
--    if self.random > 3 then
--	self.random = 1
--    end
--    
--    local bg = "gq_datouxiang_d"..tostring(self.random)
--    
--    --app.log("bg##########"..obj:get_name())
--    
--    local carbg = ngui.find_sprite(obj,"sp_bg/sp_bg")
--    carbg:set_sprite_name(bg)
--    
--    local roletexture = ngui.find_texture(obj,"sp_bg/texture_huamn")
--    
--    local dataid = self:isHaveHero(data[2])
--    
--    --小红点
--    local isCanUp = g_dataCenter.trainning:computitem(self.currentgroup)
--    
--    --app.log("isCanUp#######################"..tostring(isCanUp))
--    
--    if dataid ~= "" then
--	if isCanUp then
--	    dian:set_active(true)
--	else
--	    dian:set_active(false)
--	end
--    else
--	dian:set_active(false)
--    end
--	
--    --app.log("datav2 ########"..data[2])
--    local playname = ngui.find_label(obj,"sp_bg/lab1")
--    local grade = ngui.find_sprite(obj,"sp_bg/sp_name")
--      
--    if dataid ~= "" then
--	local cardinfo = g_dataCenter.package:find_card(1, dataid);
--	--app.log("dataid####"..dataid)
--	roletexture:set_texture(cardinfo.icon300)
--	roletexture:set_color(1,1,1,1)
--	local Rarity = PublicFunc.GetHeroRarity(cardinfo.realRarity)
--	local raritystar = cardinfo.rarity
--	self:setStar(stars,raritystar)
--	
--	local playername = cardinfo.name
--	local flag = string.find(playername,"[-]")
--	--app.log("####flag #### "..tostring(flag).." playername ######"..playername)
--	if flag then
--	    playname:set_text(string.sub(playername,9))
--	else
--	    playname:set_text(cardinfo.name)
--	end
--	--local tempname = string.sub(cardinfo.name,8)
--	
--	
--	PublicFunc.SetColorByRGBStr(grade,Rarity,1)
--	carbg:set_color(1,1,1,1)
--	
--    else
--	local role = CardHuman:new({number=data[2], isNotCalProperty = true});
--	--app.log("role####"..role.icon300)
--	roletexture:set_texture(role.icon300)
--	PublicFunc.SetUISpriteGray(roletexture)
--	roletexture:set_color(0,0,0,1)
--	playname:set_text(role.name)
--	carbg:set_color(0,0,0,1)
--	--local Rarity = role.realRarity
--	grade:set_color(0,0,0,1)
--	--TheroHead:SetCallback(self.bindfunc['on_select_role']);
--	local raritystar = role.rarity
--	self:setStar(stars,raritystar)
--    end
--    
--    local checkitem = ngui.find_sprite(obj,"sp_bg/sp_but")
--    checkitem:set_on_ngui_click(self.bindfunc['on_select_role']);
--    checkitem:set_event_value(tostring(data[2]))
--	
--    --end
--     
--    --local item = obj:get_child_by_name("cont_big_item")
--    --item:set_active(false)
--    
--    --local titelname = ngui.find_label(obj,"sp_title_bg/lab_title")
--    
--    --self.grid[bb] = ngui.find_grid(obj,"sp_bg/grid")
--    
--    --self.grid[bb]:set_cell_width(105)
--    
--    
--           
----    for k,v in pairs(self.Theroheadlist[bb])do
----	 v:DestroyUi()
----	 v = nil;
----    end
----    self.Theroheadlist[bb] = {};
----    
----    for k,v in pairs(self.herolist[bb])do
----	v:set_active(false)
----	v = nil;
----    end
----    self.herolist[bb] = {};
--    
----    for i=1,8 do
----	if self.herolist[bb][i] == nil then
----	    self.herolist[bb][i] = item:clone();
----	end
----	self.herolist[bb][i]:set_parent(self.grid[bb]:get_game_object());
----	self.herolist[bb][i]:set_name("new_small_card_item" .. i);
----	if self.AllHerolist[index][i] then
----	    self.herolist[bb][i]:set_active(true)
----	else
----	    self.herolist[bb][i]:set_active(false)
----	end
----    end
----    
----    for k,v in pairs(self.AllHerolist[index])do
----	local role = CardHuman:new({number=v[2], isNotCalProperty = true});
----	local dataid = self:isHaveHero(v[2])
----	local cardinfo = g_dataCenter.package:find_card(1, dataid);
----	if self.herolist[bb][k] then
----	    if not self.Theroheadlist[bb][k] then
----		if dataid ~= "" then
----		    local TheroHead = SmallCardUi:new({parent=self.herolist[bb][k] ,info=cardinfo,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
----		    TheroHead:SetParam(k);
----		    TheroHead:SetGray(false)
----		    TheroHead:SetCallback(self.bindfunc['on_select_role']);
----		    self.Theroheadlist[bb][k] = TheroHead;
----		else
----		    local TheroHead = SmallCardUi:new({parent=self.herolist[bb][k] ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
----		    TheroHead:SetParam(k);
----		    TheroHead:SetGray(true)
----		    TheroHead:SetCallback(self.bindfunc['on_select_role']);
----		    self.Theroheadlist[bb][k] = TheroHead;  
----		end
----	    else
----		if dataid ~= "" then
----		    
----		    self.Theroheadlist[bb][k]:SetData(cardinfo)
----		else
----		    self.Theroheadlist[bb][k]:SetData(role)
----		end
----	    end	
----	end	
----    end
----   
----    
----    self.grid[bb]:reposition_now();
--    
--end

function TrainningMain:setStar(obj,num)
    local starlist = {}
    for i=1,7 do
	starlist[i] = ngui.find_sprite(obj,"xin"..i)
	if i<= num then
	    starlist[i]:set_active(true)
	else
	    starlist[i]:set_active(false)
	end
    end

end

function TrainningMain:isHaveHero(id)
    
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.ALL);
    local dataid = "";
    --app.log("haveherolist ####################"..table.tostring(haveherolist))
    for k,v in pairs(haveherolist)do
	if v.default_rarity == id then
	    dataid = v.index
	end
    end
    
    return dataid
end

function TrainningMain:on_select_role(card,info,i)
	
	--app.log("info################ "..table.tostring(info))
	--local value = tonumber(index);
    -- function open_info()
    --     uiManager:PushUi(EUI.TrainningInfo);
    -- end

	g_dataCenter.trainning:set_currentroleinfo(info)
	
    uiManager:PushUi(EUI.TrainningInfo);
    -- self.fx:set_active(true)

    -- TimerManager.Add(open_info, 800)
	
	-- do return end
	-- local dataid = self:isHaveHero(value)
	-- --app.log("dataid############### "..dataid)
	-- if dataid ~= "" then
	--     local cardinfo = g_dataCenter.package:find_card(1, dataid);
	-- --app.log("info is####################"..table.tostring(info))  
	--     g_dataCenter.trainning:set_currentroleinfo(cardinfo)
	-- else
	--     local role = CardHuman:new({number=value});
	--     --app.log("##########role  "..table.tostring(role))
	--     g_dataCenter.trainning:set_currentroleinfo(role)
	-- end
	
	--uiManager:PushUi(EUI.TrainningInfo);

end

function TrainningMain:on_click_OpenDaRen()
	uiManager:PushUi(EUI.Trainningbattleinfo);
end

function TrainningMain:UpdateUi()
    
end

function TrainningMain:Show()
    if UiBaseClass.Show(self) then
    	--app.log("TrainningMain:Show#######################")
    	--local cnt = #self.AllHerolist[self.currentgroup];
    	--self.herolistview:set_min_index(0);
    	--self.herolistview:set_max_index(cnt-1);
    	--self.herolistview:reset();
    	--self.scroll_view:reset_position();
        self.fx:set_active(false)
    	local battledata = g_dataCenter.trainning:get_BattleLvl()[self.currentgroup]
        local battleLvl = battledata.low
        self.grouplvltitle:set_text("等级"..tostring(battleLvl))
        
    	local cnt = #self.AllHerolist;
    	--app.log("cnt##############"..tostring(cnt))
    	--self.herolistview:set_min_index(0);
    	self.herolistview:refresh_list(cnt);
    end
end



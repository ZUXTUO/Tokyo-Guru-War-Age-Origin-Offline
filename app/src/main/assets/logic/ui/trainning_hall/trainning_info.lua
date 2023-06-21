
TrainningInfo = Class("TrainningInfo", UiBaseClass)

-------------------------------------外部调用-------------------------------------
function TrainningInfo:GetNavigationAdvPlane()
    return true;
end
function TrainningInfo:ShowNavigationBar()
    return true
end


function TrainningInfo:Init(data)
    self.TrainningInfo = data
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4603_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function TrainningInfo:Restart(data)
    --app.log("111111111111111111111111111111111111")
    
    self.addexpitem = {};
    self.herolist = {};
    self.Theroheadlist = {};
    self.itemlist = {};
    self.itemlisttext = {};
    
    self.hasItemNum = 0; -- 物品个数
    
    self.haveitemnum = 0;
    
    self.haslvl = 0;     --模拟等级
    
    self.hasexp = 0;   --当前经验
    
    self.hasexpcurrent = 0;
    
    self.hasnextexp =0 ;  --下一级经验
    
    self.currentroleinfo = g_dataCenter.trainning:get_currentroleinfo()
    
    if data then
        --app.log("222222222222222222222222222222222222")
        if data.group then
            --app.log("3333333333333333333333333333333333333")
            self.currentgroup = tonumber(data.group)
            --app.log("self.currentgroup-------------------"..tostring(self.currentgroup))
        end
    else
        self:InitUIData()
    end


    if UiBaseClass.Restart(self, data) then
	--app.log("2222222222222222222222222222222222222")
        
        
    end
end

function TrainningInfo:InitData(data)
    
    self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
    
    self.hasItemNum = 0; -- 物品个数
    self.haveitemnum = 0;
    self.haslvl = 0;     --模拟等级
    
    self.hasexp = 0;   --当前经验
    self.hasnextexp =0 ;  --下一级经验
    self.hasexpcurrent = 0;
    
    --self.hascurqnvalue = 0;  --当前等级全能值
    --self.hasnextqnvalue = 0; --下一级全能值
    
    UiBaseClass.InitData(self, data)
    
end

function TrainningInfo:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Showtrainning3d, Root.empty_func)
end

function TrainningInfo:DestroyUi()
    
    --app.log("destroyui##############")
    Showtrainning3d.Destroy()
    
    if self.get_hero_audio ~= nil then
        AudioManager.StopUiAudio(self.get_hero_audio)
        self.get_hero_audio = nil
    end

    self:stopTime()
    
    for k,v in pairs(self.addexpitem)do
        v:DestroyUi()
    end
    self.addexpitem = {};
    
    for k,v in pairs(self.heroitemlist) do
        v:DestroyUi()
    end
    
    --Show3d.Destroy()
    self.currentgroup = nil;
    
    
    self.topheroicon:DestroyUi()
    
    self.heroitemlist = {};
    
    --g_dataCenter.trainning:clear_currentroleinfo();
    
    self.currentroleinfo = nil;
    
    self.currentline = 0; --行
    self.currentindex = 0; -- 列
    
    UiBaseClass.DestroyUi(self);
    
    

end

function TrainningInfo:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_right'] = Utility.bind_callback(self, self.on_click_right);
    self.bindfunc['on_click_left'] = Utility.bind_callback(self, self.on_click_left);
    self.bindfunc['on_click_up'] = Utility.bind_callback(self, self.on_click_up);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['on_select_role'] = Utility.bind_callback(self, self.on_select_role);
    self.bindfunc['on_find_way_material'] = Utility.bind_callback(self, self.on_find_way_material);
    self.bindfunc['on_get_way'] = Utility.bind_callback(self, self.on_get_way);
    self.bindfunc['on_up_lvl'] = Utility.bind_callback(self, self.on_up_lvl);
    self.bindfunc['on_use_item'] = Utility.bind_callback(self, self.on_use_item);
    self.bindfunc['on_use_items'] = Utility.bind_callback(self, self.on_use_items);
    self.bindfunc['upheroinfo'] = Utility.bind_callback(self, self.upheroinfo);
    self.bindfunc['show_qn_tip'] = Utility.bind_callback(self, self.show_qn_tip);
    self.bindfunc['on_play_fx'] = Utility.bind_callback(self, self.on_play_fx);
    self.bindfunc['show_xq_tip'] = Utility.bind_callback(self, self.show_xq_tip);
    self.bindfunc["open_daren"] = Utility.bind_callback(self, self.open_daren);
end


--注册消息分发回调函数
function TrainningInfo:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_use_training_hall_item, self.bindfunc["upheroinfo"])
    PublicFunc.msg_regist(msg_cards.gc_training_hall_hero_advance, self.bindfunc["upheroinfo"])
end

--注销消息分发回调函数
function TrainningInfo:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_use_training_hall_item, self.bindfunc["upheroinfo"])
    PublicFunc.msg_unregist(msg_cards.gc_training_hall_hero_advance, self.bindfunc["upheroinfo"])
end

--选中下面人物列表点击事件
function TrainningInfo:on_select_role(card,info,i)
    --app.log("##########info ###########"..tostring(info.default_rarity))
    
    self:stopTime()
    
    if self.choseitem then
        self.choseitem:ChoseItem(false)
    end
    
    self.choseitem = card
    
    self.choseitem:ChoseItem(true)
    
    self.currentroleinfo = info
    -- self.playername:set_text(self.currentroleinfo.name)
    -- self.playernamehave:set_text(self.currentroleinfo.name)

    local name,rarity = PublicFunc.FormatHeroNameAndNumber(self.currentroleinfo.name)

    self.playername:set_text(name)
    self.playernamehave:set_text(name)

    --if rarity > 0 then
        self.playerraity:set_text(rarity)
    -- else
    --     self.playerraity:set_text("")
    -- end

    local flag = self:isHaveHero(info.default_rarity)
    
    self:setNameTitle(flag)
    
    if flag ~= "" then
        self.lvl:set_active(true)
        self.powervalue:set_active(true)
        self.powervaluelayer:set_active(true)
        self.getBtn:set_active(false)
        self.pybtn:set_active(true)
        
        self.headicon:set_active(true)
        --self.powericon:set_active(true)
        --self.deficon:set_active(true)
        
        self:setData()
    else
        self:NohaveHero()
        
    end
    
    self:setchoseRoleData(info.default_rarity)

end



--初始化UI
function TrainningInfo:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('TrainningInfo');
    self.RightBtn = ngui.find_button(self.ui,"animation/centre_other/animation/right_btn");
    self.RightBtn:set_on_click(self.bindfunc['on_click_right']);
    self.RightBtnPoint = ngui.find_sprite(self.ui,"animation/centre_other/animation/right_btn/animation/sp_point")
    self.RightBtnPoint:set_active(false)

    self.LeftBtn = ngui.find_button(self.ui,"animation/centre_other/animation/left_btn");
    self.LeftBtn:set_on_click(self.bindfunc['on_click_left']);
    self.LeftBtnPoint = ngui.find_sprite(self.ui,"animation/centre_other/animation/left_btn/animation/sp_point")
    self.LeftBtnPoint:set_active(false)

    self.powervalue = ngui.find_label(self.ui,"animation/left_other/animation/cont_yingxiong_xinxi/sp_fight/lab_fight");--战斗力
    self.titlename = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/lab_chen_hao");--称号
    self.nohaveherotitle = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/info_bg/lab_weihuode")
    self.nohaveherotitle:set_active(false)
    
    self.powervaluelayer = self.ui:get_child_by_name("animation/left_other/animation/cont_yingxiong_xinxi/sp_fight")
    
    self.lvl = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/lab_lv");  --等级
    self.heroicon = self.ui:get_child_by_name("animation/right_other/animation/right_bg/new_small_card_item")
    self.topheroicon = SmallCardUi:new({parent=self.heroicon ,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Level}});
    
    self.exptiao = ngui.find_progress_bar(self.ui,"animation/right_other/animation/right_bg/info_bg/progress_bar");--经验进度条
    self.expText = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/info_bg/progress_bar/lab_word");--经验文字
    
    self.pybtn = ngui.find_button(self.ui,"animation/right_other/animation/right_bg/info_bg/but");
    self.pybtn:set_on_click(self.bindfunc['on_click_up']);
    
    self.getBtn = ngui.find_button(self.ui,"animation/right_other/animation/right_bg/info_bg/but1");
    self.getBtn:set_on_click(self.bindfunc['on_get_way']);
    self.getBtn:set_active(false)
    
    self.useritemUI = self.ui:get_child_by_name("animation/right_other/animation/right_bg/item_list")
    
    
    self.upbtn = ngui.find_button(self.ui,"animation/right_other/animation/btn_yellow");
    self.upbtn:set_on_click(self.bindfunc['on_up_lvl']);
    self.upbtn:set_active(false)
    
    self.useitemMask = {}
    self.useitemFx = {}
    self.tishiitemFx = {}
    
    for i=1 ,3 do
        self.itemlist[i] = self.ui:get_child_by_name("animation/right_other/animation/right_bg/item_list/new_small_card_item"..i);
        self.itemlisttext[i] = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/item_list/new_small_card_item"..i.."/lab")
        self.useitemMask[i] = ngui.find_sprite(self.ui,"animation/right_other/animation/right_bg/item_list/new_small_card_item"..i.."/sp_mark")
        self.useitemMask[i]:set_active(false)
        self.useitemFx[i] = self.ui:get_child_by_name("animation/right_other/animation/right_bg/item_list/new_small_card_item"..i.."/fx_ui_602_level_up_xiaohaocailiao")
        self.tishiitemFx[i] = self.ui:get_child_by_name("animation/right_other/animation/right_bg/item_list/new_small_card_item"..i.."/fx_ui_4603_tishi")
        self.tishiitemFx[i]:set_active(false)
    end
    
    --血量升级
    self.headtext = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/info_bg/info1/lab1/lab_num");
    self.upheadtext = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/info_bg/info1/lab2");
    self.headicon = ngui.find_sprite(self.ui,"animation/right_other/animation/right_bg/info_bg/info1/sp1")
    
    self.nohaveheadtext = ngui.find_label(self.ui,"animation/right_other/animation/info2/lab1/lab_num")
    self.nohaveheadtext:set_text("0")
    self.nohaveheadtext:set_active(false)
    
    --升级提示线条和文字
    self.uplineandtxt = self.ui:get_child_by_name("animation/right_other/animation/lab_tips")
    self.uplineandtxt:set_active(false)
    
    --self.labtips = self.ui:get_child_by_name("centre_other/animation/right/right_bg/lab_tips")
    ----攻击升级
    --self.powertext =ngui.find_label(self.ui,"centre_other/animation/right/right_bg/info_bg/info2/lab1");
    --self.uppowertext = ngui.find_label(self.ui,"centre_other/animation/right/right_bg/info_bg/info2/lab2");
    --self.powericon = ngui.find_sprite(self.ui,"centre_other/animation/right/right_bg/info_bg/info2/sp1");
    --
    ----防御升级
    --self.deftext = ngui.find_label(self.ui,"centre_other/animation/right/right_bg/info_bg/info3/lab1");
    --self.updeftext = ngui.find_label(self.ui,"centre_other/animation/right/right_bg/info_bg/info3/lab2");
    --self.deficon = ngui.find_sprite(self.ui,"centre_other/animation/right/right_bg/info_bg/info3/sp1");
    
    self.trainningMaxtxt = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/lab_tips")
    self.uptradetext = ngui.find_label(self.ui,"animation/right_other/animation/lab_tips")
    self.uptradetext:set_text("")
    
    --全能值说明
    self.qnvaluebtn = ngui.find_button(self.ui,"animation/right_other/animation/right_bg/info_bg/info1")
    self.qnvlauebtnsp =  ngui.find_sprite(self.ui,"animation/right_other/animation/right_bg/info_bg/info1/sp_but")
    self.qnvaluebtn:set_on_click(self.bindfunc['show_qn_tip'])
    --3D模型
    self.hero3D = ngui.find_sprite(self.ui,"animation/left_other/animation/sp_human");
    --角色列表
    --self.playerlist = ngui.find_wrap_content(self.ui,"centre_other/animation/left/scroll_view/panel_list/wrap_content");
    --self.playerlist:set_on_initialize_item(self.bindfunc['init_item_wrap_content'])
    --self.scroll_view = ngui.find_scroll_view(self.ui, "centre_other/animation/left/scroll_view/panel_list");

    self.ruleBtn = ngui.find_button(self.ui,"animation/left_other/animation/cont_yingxiong_xinxi/btn_rule")
    self.ruleBtn:set_on_click(self.bindfunc['show_xq_tip'])
    
    self.linepic = self.ui:get_child_by_name("animation/right_other/animation/lab_tips")
        
    --self.infodi = ngui.find_sprite(self.ui,"centre_other/animation/right/right_bg/sp_11")
    self.infodi1 = ngui.find_sprite(self.ui,"animation/right_other/animation/right_bg/sp_1")
    
    self.maxbg = ngui.find_sprite(self.ui,"animation/right_other/animation/sp_art_font")
    self.maxbg:set_sprite_name("xlc_xlyddzgxj")
    self.maxbg:set_active(false)
        
    self.playerlist = {}
    self.heroitemlist = {}
    self.playerlist[1] = self.ui:get_child_by_name("animation/down_other/animation/grid/new_small_card_item1")
    --self.heroitemlist[1] = SmallCardUi:new({parent=self.playerlist[1] });
    self.playerlist[1]:set_active(false)
    
    self.downgrid = ngui.find_grid(self.ui,"animation/down_other/animation/grid")
    
    self.battledarenbtn = ngui.find_button(self.ui,"animation/top_left_other/animation/btn_paihang")
    self.battledarenbtn:set_on_click(self.bindfunc["open_daren"])

    for i=2,8 do
        self.playerlist[i] =  self.playerlist[1]:clone()
        self.playerlist[i]:set_name("new_small_card_item"..i)
        self.playerlist[i]:set_active(false)
    end
    
    for i =1,8 do
        self.heroitemlist[i] = SmallCardUi:new({parent=self.playerlist[i] ,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Level}});    
    end
    
    --角色名称
    self.playername = ngui.find_label(self.ui,"animation/left_other/animation/cont_yingxiong_xinxi/lab_name")   --没有拥有
    self.playernamehave = ngui.find_label(self.ui,"animation/left_other/animation/cont_yingxiong_xinxi/lab_name")   --已拥有
    self.playerraity = ngui.find_label(self.ui,"animation/left_other/animation/cont_yingxiong_xinxi/lab_name/lab_num")
    
    self.isHaveText = ngui.find_label(self.ui,"animation/right_other/animation/right_bg/sp_bg1/lab2")

    --生命
    self.playercurrenthp = ngui.find_label(self.ui,"animation/right_other/animation/lab_shengming/lab_num1")
    self.playercurrenthpicon = ngui.find_sprite(self.ui,"animation/right_other/animation/lab_shengming/sp_jian_tou")
    self.playernexthp = ngui.find_label(self.ui,"animation/right_other/animation/lab_shengming/lab_num2")
    --攻击
    self.playercurrentatk = ngui.find_label(self.ui,"animation/right_other/animation/lab_gongji/lab_num1")
    self.playercurrentatkicon = ngui.find_sprite(self.ui,"animation/right_other/animation/lab_gongji/sp_jian_tou")
    self.playernextatk = ngui.find_label(self.ui,"animation/right_other/animation/lab_gongji/lab_num2")
    --防御
    self.playercurrentdef = ngui.find_label(self.ui,"animation/right_other/animation/lab_fangyu/lab_num1")
    self.playerdeficon = ngui.find_sprite(self.ui,"animation/right_other/animation/lab_fangyu/sp_jian_tou")
    self.playernetxdef = ngui.find_label(self.ui,"animation/right_other/animation/lab_fangyu/lab_num2")

    self.nohaveplayerhp = ngui.find_label(self.ui,"animation/right_other/animation/lab_shengming/lab_num3")
    self.nohaveplayeratk = ngui.find_label(self.ui,"animation/right_other/animation/lab_gongji/lab_num3")
    self.nohaveplayerdef = ngui.find_label(self.ui,"animation/right_other/animation/lab_fangyu/lab_num3")

    self.nohaveplayerhp:set_text("")
    self.nohaveplayeratk:set_text("")
    self.nohaveplayerdef:set_text("")

    self.isHaveText:set_active(false)
    
    if self.currentgroup then
        if self.currentgroup ~= 0 then
            self.currentline = self.currentgroup
            self.currentindex = 1
            
            self:rushlist()
        
            self:set_currentRoleData()
        end
    else
        self:InitUIData()
        self:rushlist()
        self:bound3d()
        self:setData()
    end

    Showtrainning3d.Addquote()
end

function TrainningInfo:open_daren()
    uiManager:PushUi(EUI.Trainningbattleinfo);
end

function TrainningInfo:rushlist()
    
    
    self:set_red_point()
    --local role = CardHuman:new({number=data[2], isNotCalProperty = true});
    
    for i=1,8 do
        local data = self.AllHerolist[self.currentline][i]
        if data then
            self:set_heroData(data,i)
        else
            self.playerlist[i]:set_active(false)
        end    
    end
    
    self.downgrid:reposition_now()
    --self:InitUIData()
    --app.log("rushlist####### "..tostring(self.currentline))
    --local cnt = #self.AllHerolist[self.currentline];
    --self.playerlist:set_min_index(0);
    --self.playerlist:set_max_index(cnt-1);
    --self.playerlist:reset();
    --self.scroll_view:reset_position(); 
end

function TrainningInfo:set_red_point()
    local nextcurrentgroup = 0

    if self.currentline == 8 then
        nextcurrentgroup = 1
    else
        nextcurrentgroup = self.currentline + 1
    end

    local lastcurrentgroup = 0

    if self.currentline == 1 then
        lastcurrentgroup = 8
    else
        lastcurrentgroup = self.currentline -1
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
            self.RightBtnPoint:set_active(true)
        else
            self.RightBtnPoint:set_active(false)
        end
    else
        self.RightBtnPoint:set_active(false)
    end

    if lasthave then
        if lastflag then
            self.LeftBtnPoint:set_active(true)
        else
            self.LeftBtnPoint:set_active(false)
        end
    else
        self.LeftBtnPoint:set_active(false)
    end

end

function TrainningInfo:on_use_items(name, state, x, y, gameObject, obj)
    
    --app.log("obj #########" .. obj.parent:get_name())
    --for i=1,3 do
    --    self.useitemFx[i]:set_active(false)
    --end
    
    local itemparentname = obj.parent:get_name()
    
    self.currentitemindex = 1;
    
    if itemparentname == "new_small_card_item1" then
        self.currentitemindex = 1
    elseif itemparentname == "new_small_card_item2" then
        self.currentitemindex = 2
    elseif itemparentname == "new_small_card_item3" then
        self.currentitemindex = 3
    end    
    
    local flag = self:isHaveHero(self.currentroleinfo.default_rarity)
        
    if flag == "" then
       FloatTip.Float( "请先拥有该英雄！" );
       do return end
    end
    
    
    local itemdata = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,obj.cardInfo.number)
    if itemdata then
        local itemdataid = itemdata.index
        
        self.data_id = flag
        self.item_id = itemdataid
    end
    
    if state then
        --app.log("########################"..tostring(state))
        self:on_play_fx()
        self:on_use_item()
        
        local flag = self:isHaveHero(self.currentroleinfo.default_rarity)
        
        if flag == "" then
           FloatTip.Float( "请先拥有该英雄！" );
           do return end
        end
        
        
        local itemdata = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item,obj.cardInfo.number)
        if itemdata then
            local itemdataid = itemdata.index
            
            self.data_id = flag
            self.item_id = itemdataid
            self.useitemFx[self.currentitemindex]:set_active(true)
            self.timeid = timer.create(self.bindfunc["on_use_item"],100,-1)
            self.fxtimeid = timer.create(self.bindfunc["on_play_fx"],1000,-1)
        else
            self:stopTime()
        end
    else
        
        self:stopTimes()
        --app.log("1111111111111111111")
        if self.data_id~= "" and self.item_id ~= 0 then
            --app.log("222222222222222222222222")
            --app.log("self.hasItemNum################"..tostring(self.hasItemNum))
            msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,self.hasItemNum)
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
        end
        
        
        --app.log("clear########################")
        self.hasItemNum = 0; -- 物品个数
        self.haveitemnum = 0;
        
        self.haslvl = 0;     --模拟等级
        
        self.hasexp = 0;   --当前经验
        self.hasnextexp =0 ;  --下一级经验
        self.hasexpcurrent = 0;
        
        self.data_id = 0;
        self.item_id = 0;
    end
end

function TrainningInfo:on_play_fx(t)
    self.useitemFx[self.currentitemindex]:set_active(false)
    self.useitemFx[self.currentitemindex]:set_active(true) 
end

function TrainningInfo:on_use_item(t)
    --local temp = {}
    --app.log("####self.data_id####"..self.data_id.." ####### self.item_id @@@@@@"..tostring(self.item_id))
    --item_id = t.float_value
    --data_id = t.string_value
    --app.log("dataid###########"..tostring(data_id))
    --app.log("item_id###########"..tostring(item_id))
    --self.useitemFx[self.currentitemindex]:set_active(true) 
    
    if self.data_id~= "" and self.item_id ~= 0 then
        --msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,1)
        self.hasItemNum = self.hasItemNum + 1
        self.haveitemnum = self.haveitemnum + 1;
        self:setMLData()
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpLoop)
    end

end

function TrainningInfo:upheroinfo( id )
    --app.log("##############"..tostring(id))
    local data_id = id
    local cardinfo = g_dataCenter.package:find_card(1, data_id);
    self.currentroleinfo = cardinfo
    self:setData()
    self:rushlist()
    --self:setItemData()
end

function TrainningInfo:show_xq_tip(t)

    -- local herolist = {}

    -- for k,v in pairs(self.AllHerolist[self.currentline]) do

    --     app.log("idididididi============="..table.tostring(v))
    -- end


    -- if self.roleInfo then
    --     self.roleInfo:SetInfo(self.currentroleinfo, true,{})--, self.AllHerolist[self.currentline])
    --     self.roleInfo:Show();
    -- else
    --     local data = 
    --     {
    --         info = self.currentroleinfo,
    --         isPlayer = true,
    --         heroDataList = {},--self.AllHerolist[self.currentline], -- 传入当前列表数据
    --     }
    --     self.roleInfo = BattleRoleInfoUI:new(data);
    -- end
    local data = 
    {
        info = self.currentroleinfo,
        isPlayer = true,
        heroDataList = {},--self.AllHerolist[self.currentline], -- 传入当前列表数据
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)
end

function TrainningInfo:show_qn_tip(t)
--function TrainningInfo:show_qn_tip(name, state, x, y, go_obj)

    UiRuleDes.Start(43);
    -- local data = {}
    -- data.x = x
    -- data.y = y
    -- data.z = self.qnvlauebtnsp:get_height()
    -- data.value = ConfigManager.Get(EConfigIndex.t_discrete,83000125).b
    -- --self.textlab:set_text("加伤率："..tostring(adddata*self.Trainningmaintip).."\n".."减伤率："..tostring(Damagedata*self.Trainningmaintip))
    
    -- if state then
    --     Trainninginfotip.Start(data)
    -- else
    --     Trainninginfotip.Destroy()
    -- end
    
end

function TrainningInfo:setNameTitle(flag)
   if flag ~= "" then
        --app.log("1111111111111111111111111")
        self.playername:set_active(true)   --没有拥有
        self.playernamehave:set_active(true)  --已拥有
    else
        --app.log("2222222222222222222222222")
        self.playername:set_active(true)   --没有拥有
        self.playernamehave:set_active(true)  --已拥有
    end 
end

function TrainningInfo:setItemData()
    
    local flag = self:isHaveHero(self.currentroleinfo.default_rarity)        
    local addexpitemlist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_item);
    local currentvalue = 100+self.currentline
    
    self.itemnumber = {}
    
    for k,v in pairs(addexpitemlist[currentvalue])do
        --app.log("vvvvvvvv############"..table.tostring(v))
        local card_prop = CardProp:new({number = v[2],count = 1});
        
        local number = g_dataCenter.package:find_count(ENUM.EPackageType.Item,v[2]);
        
        self.itemnumber[k] = number
        
        --app.log("groupline=============================  "..g_dataCenter.trainning:computitemToHero(v[2]))

        local press_call_back = function(obj)
            
            if flag ~= "" then
                if number > 0 then

                    obj:SetOnPress(self.bindfunc["on_use_items"])
                    --self.tishiitemFx[k]:set_active(true)
                else
                    
                    --app.log("setItemData@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                    self:stopTime()
                    
                    obj:SetBtnAddShow(true)
                    obj:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), v[2])
                    --self.tishiitemFx[k]:set_active(false)
        
                end
            else
                obj:SetOnPress(self.bindfunc["on_use_items"])
            end
        end
        
        if self.addexpitem[k] then
            --app.log("22222222222222222222222number"..tostring(number))
            if number > 0 then
                self.addexpitem[k]:SetBtnAddShow(false)
                self.addexpitem[k]:SetData(card_prop)
                --self.addexpitem[k]:SetCount(number)
                self.addexpitem[k]:SetOnPress(self.bindfunc["on_use_items"])
                --self.tishiitemFx[k]:set_active(true)
            else
                if flag ~= "" then
                    
                    --app.log("setItemData111111111111111111111111111")
                    if k == self.currentitemindex then
                        self:stopTime()
                    end
                    
                    self.addexpitem[k]:SetBtnAddShow(true)
                    self.addexpitem[k]:SetData(card_prop)
                    self.addexpitem[k]:SetBtnAddOnClicked(self.bindfunc["on_find_way_material"], tostring(number), v[2])
                    --self.tishiitemFx[k]:set_active(false)
                else
                    --app.log("setItemData3333333333333333333333333333")
                    self.addexpitem[k]:SetBtnAddShow(false)
                    self.addexpitem[k]:SetData(card_prop)
                    --self.addexpitem[k]:SetCount(number)
                    self.addexpitem[k]:SetOnPress(self.bindfunc["on_use_items"])
                end
                --self.tishiitemFx[k]:set_active(false)
            end
            self.addexpitem[k]:SetCount(number)
        else
             
             --app.log("kkkkk222222kkkkk"..tostring(k))
            self.addexpitem[k] = UiSmallItem:new({parent = self.itemlist[k], cardInfo = card_prop,load_callback=press_call_back});
        end
        
        if flag ~= "" then
            if number > 0 then
                self.tishiitemFx[k]:set_active(false)
            else
                self.tishiitemFx[k]:set_active(false)
            end
            self.useitemMask[k]:set_active(false)
        else
            self.tishiitemFx[k]:set_active(false)
            self.useitemMask[k]:set_active(true)
        end       
                    
        self.itemlisttext[k]:set_text("训练值".."[00FF73FF]+"..tostring(v[3]).."[-]")
    end
end

function TrainningInfo:setTitleDiColour(lvl)
    
    
    --Green =  { r=76/255,g=164/255,b=2/255,a=1},     --4ca402
    --Blue =  { r=5/255,g=98/255,b=176/255,a=1},      --0562b0
    --Purple = { r=163/255,g=0/255,b=187/255,a=1},    --a300bb
    --Red = { r=197/255,g=2/255,b=62/255,a=1},        --c5023e
    --Orange = { r=225/255,g=65/255,b=3/255,a=1},     --e14103
   
    --local colorStr = {}
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

function TrainningInfo:stopTime()
    
    for i=1,3 do
        if self.useitemFx[i] then
            self.useitemFx[i]:set_active(false)
        end
    end
    
    if self.timeid then
        timer.stop(self.timeid)
        self.timeid = nil;
        
    end
    
    if self.fxtimeid then
        timer.stop(self.fxtimeid)
        self.fxtimeid = nil
        self.useitemFx[self.currentitemindex]:set_active(false)
    end
    
end

function TrainningInfo:stopTimes()
    if self.timeid then
        timer.stop(self.timeid)
        self.timeid = nil;
        
    end
    
    if self.fxtimeid then
        timer.stop(self.fxtimeid)
        self.fxtimeid = nil
        --self.useitemFx[self.currentitemindex]:set_active(false)
    end
    
end

function TrainningInfo:checklvlpoint()

    local flag = self:isHaveHero(self.currentroleinfo.default_rarity)        
    
    local lvlindex = self.currentroleinfo.trainingHallLevel
    local currentexp = self.currentroleinfo.trainingHallLevelExp

    local currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]
    
    local currentNeedexpdata = currentNeedexp.att_lv
    
    local pzname = "t_"..currentNeedexpdata

    local expdata = ConfigManager.Get(EConfigIndex[pzname],lvlindex);--ConfigMananger.Get(EconfigIndex.pzname,lvl - 1)
    
    local Allexp = expdata.exp

    --app.log("currentexp............."..tostring(currentexp).."   Allexp..............."..tostring(Allexp))
    --app.log("itemNumber ............"..table.tostring(self.itemnumber))

    if Allexp > 0 then

        local needexp = Allexp - currentexp

        local haveAllexp = 0
        for k,v in pairs(self.itemnumber) do
            if k== 1 then
                haveAllexp = haveAllexp + v*5
            elseif k== 2 then
                haveAllexp = haveAllexp + v*20
            elseif k == 3 then
                haveAllexp = haveAllexp + v*60
            end
        end

        --app.log("haveAllexp............"..tostring(haveAllexp))

        if haveAllexp >= needexp then
            return true
        else
            return false
        end
    else
        return false
    end
end

function TrainningInfo:setData()
    
    if self.currentroleinfo == nil then
        self.currentroleinfo = g_dataCenter.trainning:get_currentroleinfo()
    end
    
    self:InitUIData()

    local name,rarity = PublicFunc.FormatHeroNameAndNumber(self.currentroleinfo.name)

    self.playername:set_text(name)
    self.playernamehave:set_text(name)
    --if rarity > 0 then
        self.playerraity:set_text(rarity)
    -- else
    --     self.playerraity:set_text("")
    -- end
       
    local flag = self:isHaveHero(self.currentroleinfo.default_rarity)
        
    --app.log("flag###############"..tostring(self.currentroleinfo.default_rarity))
    self:setNameTitle(flag)
    
    self:setItemData()
    
    if flag ~= "" then

        self.nohaveplayerhp:set_text("")
        self.nohaveplayeratk:set_text("")
        self.nohaveplayerdef:set_text("")


        self.isHaveText:set_active(false)
        self.lvl:set_active(true)
        self.powervalue:set_active(true)
        self.powervaluelayer:set_active(true)
        self.titlename:set_active(true)
        self.nohaveherotitle:set_active(false)
        
        self.nohaveheadtext:set_active(false)
        
        local info = g_dataCenter.package:find_card(1, flag);
        --app.log("flag ###############"..tostring(flag))
        
        self.topheroicon:SetData(info)
        local sprite_name = PublicFunc.computitemlevlsprite(info.default_rarity,info.trainingHallLevel)
        self.topheroicon:SetTrainningRarity(sprite_name)
        
        local powerValue = self.currentroleinfo:GetFightValue()
            
        self.powervalue:set_text(tostring(powerValue))
        
        local lvlindex = self.currentroleinfo.trainingHallLevel
        local currentexp = self.currentroleinfo.trainingHallLevelExp
        
        --app.log('xxxxxxxxxxxxxx= currentexp' .. tostring(currentexp))
           
        local addexpitemlist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_item);
        local currentvalue = 100+self.currentline
                
        --经验相关t_training_hall_
       
        --app.log("#####"..tostring(self.currentline).."@@@"..tostring(self.currentindex))
       
        local currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]
        
        --app.log("currentNeedexp###############"..table.tostring(currentNeedexp))
        
        local currentNeedexpdata = currentNeedexp.att_lv
        
        local pzname = "t_"..currentNeedexpdata
        --app.log("pzname###################"..pzname)
        local expdata = ConfigManager.Get(EConfigIndex[pzname],lvlindex);--ConfigMananger.Get(EconfigIndex.pzname,lvl - 1)
        --app.log("expdata#####################"..tostring(expdata.exp))
        local Allexp = expdata.exp
        --app.log("Allexp#####################"..tostring(Allexp))
        self.exptiao:set_value(currentexp/Allexp)
        self.expText:set_text("[973900FF]"..tostring(currentexp).."[-][000000FF]/"..tostring(Allexp).."[-]")
        
        local lvl = ConfigManager.Get(EConfigIndex[pzname],lvlindex).adv_level;
        
        local show_level = ConfigManager.Get(EConfigIndex[pzname],lvlindex).show_level;
                        
        --app.log("######################"..tostring(currentexp))
        
        self.lvl:set_text("等级 [fff721]"..tostring(show_level).."[-]")
        
        
        if Allexp == 0 then
            
            self:stopTime()
            
            --self.upheadtext:set_text("")
            self.headicon:set_active(false)
            
            local expdata = ConfigManager.Get(EConfigIndex[pzname],lvlindex - 1)
            local Allexp = expdata.exp
            
            self.exptiao:set_value(Allexp/Allexp)
            self.expText:set_text("[973900FF]"..tostring(Allexp).."[-][000000FF]/"..tostring(Allexp).."[-]")
            
            self.upbtn:set_active(true)
            self.useritemUI:set_active(false)
            
            local titlelvl = "t_"..currentNeedexp.att_adv
            local prodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            local nextprodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl+1);
            --app.log("expdata#########"..table.tostring(expdata))
            
            local proname = "";
            local nextvalue = 0;
            local curValue = 0;
            if prodata and nextprodata then
                
                for k,v in pairs(nextprodata)do
                    --app.log("#########"..tostring(v))
                    if v ~= 0 then
                        if k == 2 then
                            proname = "暴击"
                            nextvalue = v--
                            curValue = prodata[2]
                        elseif k == 3 then
                            proname = "免爆"
                            nextvalue = v
                            curValue = prodata[3]
                        elseif k == 4 then
                            proname = "暴伤"
                            nextvalue = v
                            curValue = prodata[4]
                        elseif k == 5 then
                            proname = "破击"
                            nextvalue = v
                            curValue = prodata[5]
                        elseif k == 6 then
                            proname = "格挡"
                            nextvalue = v
                            curValue = prodata[6]
                        elseif k == 7 then
                            proname = "格挡伤害"
                            nextvalue = v
                            curValue = prodata[7]
                        end
                    end
                end
                
            end
            
            --app.log("nextvalue ####"..tostring(nextvalue).."### curValue ######"..tostring(curValue))
            
            self.uptradetext:set_text("进阶后 [fff721]"..proname.."[-]提升：[00FF73FF]+"..tostring(nextvalue - curValue).."[-]")
            
            --self.trainningMaxtxt:set_text("")
            
            
        else
            self.upbtn:set_active(false)
            self.headicon:set_active(true)
            self.useritemUI:set_active(true)
            self.uptradetext:set_text("")
            --self.trainningMaxtxt:set_text("长按道具可以连续升级")
            
        end
        
        local ngvalue = expdata.qn_power;

        self.playercurrentatkicon:set_active(true)
        self.playercurrenthpicon:set_active(true)
        self.playerdeficon:set_active(true)

        self.playercurrenthp:set_text(tostring(math.floor(expdata.add_hp)))
        self.playercurrentatk:set_text(tostring(math.floor(expdata.atk_power)))
        self.playercurrentdef:set_text(tostring(math.floor(expdata.def_power)))
        
        self.headtext:set_text(tostring(ngvalue))
        --self.powertext:set_text("攻击:+"..tostring(math.floor(self.currentroleinfo.cardInfo.property[ENUM.EHeroAttribute.atk_power])))
        --self.deftext:set_text("防御:+"..tostring(math.floor(self.currentroleinfo.cardInfo.property[ENUM.EHeroAttribute.def_power])))
        
        local nextlvldata = ConfigManager.Get(EConfigIndex[pzname],lvlindex+1);
        
        if nextlvldata then
        
            local upqnvalue = nextlvldata.qn_power
            --local uppower = nextlvldata.atk_power
            --local updef = nextlvldata.def_power

            self.playernexthp:set_text(tostring(math.floor(nextlvldata.add_hp)))
            self.playernextatk:set_text(tostring(math.floor(nextlvldata.atk_power)))
            self.playernetxdef:set_text(tostring(math.floor(nextlvldata.def_power)))

            if Allexp == 0 then
                self.upheadtext:set_text("")
                
            else
                self.upheadtext:set_text("  "..tostring(upqnvalue))
                
            end
            --self.uppowertext:set_text("+"..tostring(math.floor(uppower)))
            --self.updeftext:set_text("+"..tostring(math.floor(updef)))
            
            local titlelvl = "t_"..currentNeedexp.att_adv
            --app.log("###titlelvl#############"..titlelvl.."    @#"..tostring(lvl))
            local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            
            self.titlename:set_text(titledata.adv_name)
            --地盘颜色
            self:setTitleDiColour(lvl)
            --self.upbtn:set_enable(true)
            --self.upbtn:set_active(true)
            --PublicFunc.SetUISpriteWhite(self.upbtn)
            self.upbtn:set_sprite_names("ty_anniu3")
            if Allexp == 0 then
                self.trainningMaxtxt:set_active(false)
                self.linepic:set_active(false)
                
                self.uplineandtxt:set_active(true)
                
            else
                self.trainningMaxtxt:set_active(true)
                self.trainningMaxtxt:set_text("长按道具可以连续升级")
                self.linepic:set_active(true)
                
                self.uplineandtxt:set_active(false)
            end
            
            self.maxbg:set_active(false)
            self.upheadtext:set_active(true)
        else
            --self.upbtn:set_enable(false)
            --self.upbtn:set_sprite_names("anniu14")
            self.upbtn:set_active(false)
            --PublicFunc.SetUISpriteGray(self.upbtn)
            local titlelvl = "t_"..currentNeedexp.att_adv
            local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            self.titlename:set_text(titledata.adv_name)
            self.upheadtext:set_active(false)
            --self.trainningMaxtxt:set_text("已提升至最高等级")
            self.maxbg:set_active(true)
            self.linepic:set_active(true)
            self.uptradetext:set_text("")
            self.trainningMaxtxt:set_active(false)
            
            self.uplineandtxt:set_active(true)

            self.playercurrenthp:set_text("")
            self.playercurrentatk:set_text("")
            self.playercurrentdef:set_text("")

            self.playernexthp:set_text("")
            self.playernextatk:set_text("")
            self.playernetxdef:set_text("")

            self.playercurrentatkicon:set_active(false)
            self.playercurrenthpicon:set_active(false)
            self.playerdeficon:set_active(false)

            self.nohaveplayerhp:set_text(tostring(math.floor(expdata.add_hp)))
            self.nohaveplayeratk:set_text(tostring(math.floor(expdata.atk_power)))
            self.nohaveplayerdef:set_text(tostring(math.floor(expdata.def_power)))

        end
    else
        self:NohaveHero()
        --app.log("nonnonononononono#########")
        self:setchoseRoleData(self.currentroleinfo.default_rarity)        
    end

    local checkpoint = self:checklvlpoint()

    if flag ~= "" then
        for k,v in pairs(self.itemnumber) do
            if v > 0 then
                if checkpoint then
                    self.addexpitem[k]:SetTipPoint(true)
                else
                    self.addexpitem[k]:SetTipPoint(false)
                end
            else
                self.addexpitem[k]:SetTipPoint(false)
            end
        end
    else
        for i=1,3 do
            self.addexpitem[i]:SetTipPoint(false)
        end
    end
    
end

function TrainningInfo:setMLData()
    
    if self.currentroleinfo == nil then
        self.currentroleinfo = g_dataCenter.trainning:get_currentroleinfo()
    end

    self:InitUIData()
       
    local flag = self:isHaveHero(self.currentroleinfo.default_rarity)

    --物品数量操作
    --self:setItemData()
    if self.itemnumber[self.currentitemindex] >= self.hasItemNum then
        self.addexpitem[self.currentitemindex]:SetCount(self.itemnumber[self.currentitemindex] - self.hasItemNum )
    else
        self:stopTime()
        self.addexpitem[self.currentitemindex]:SetBtnAddShow(true)
        if self.data_id~= "" and self.item_id ~= 0 then
            --app.log("222222222222222222222222")
            --app.log("self.itemnumber################"..tostring(self.itemnumber[self.currentitemindex]))
            msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,self.itemnumber[self.currentitemindex])
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
        end
        
        
        --app.log("clear########################")
        self.hasItemNum = 0; -- 物品个数
        self.haveitemnum = 0;
        
        self.haslvl = 0;     --模拟等级
        
        self.hasexp = 0;   --当前经验
        self.hasnextexp =0 ;  --下一级经验
        self.hasexpcurrent = 0;
        
        self.data_id = 0;
        self.item_id = 0;
        do return end
    end
    
    if flag ~= "" then

        self.nohaveplayerhp:set_text("")
        self.nohaveplayeratk:set_text("")
        self.nohaveplayerdef:set_text("")

        self.isHaveText:set_active(false)
        self.lvl:set_active(true)
        self.powervalue:set_active(true)
        self.powervaluelayer:set_active(true)
        self.titlename:set_active(true)
        self.nohaveherotitle:set_active(false)
        
        self.nohaveheadtext:set_active(false)
        
        local info = g_dataCenter.package:find_card(1, flag);
        
        --当前等级
        
        local lvlindex = self.currentroleinfo.trainingHallLevel
        
        if self.haslvl <= lvlindex then       
            self.haslvl = lvlindex
        end
        
        --app.log("lvlindex##################"..tostring(lvlindex))
        --app.log("self.haslvl##################"..tostring(self.haslvl))
        
        --当前经验
        local currentexp = self.currentroleinfo.trainingHallLevelExp
        
           
        local addexpitemlist = ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_item);
        local currentvalue = 100+self.currentline
                
        --经验相关
        
        --物品经验
        local additemexp = 0 
        
        if self.currentitemindex == 1 then
            additemexp = 5
        elseif self.currentitemindex == 2 then
            additemexp = 20
        elseif self.currentitemindex == 3 then
            additemexp = 60
        end
        
        --增加的经验
        --app.log("self.haveitemnum###########"..tostring(self.haveitemnum))
        
        local addallexp = additemexp*self.haveitemnum
        
        --app.log("addallexp##################"..tostring(addallexp))
        
        --当前经验
        if self.haslvl <= lvlindex then
            --app.log("111self.hasexp##################"..tostring(self.hasexp))
            self.hasexp = currentexp + addallexp
        else
            --app.log("222self.hasexp##################"..tostring(self.hasexp))
            self.hasexp = self.hasexpcurrent + addallexp
        end
        
        local currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]
        
        local currentNeedexpdata = currentNeedexp.att_lv
        
        local pzname = "t_"..currentNeedexpdata
        --app.log("pzname###################"..pzname)
        local expdata = ConfigManager.Get(EConfigIndex[pzname],self.haslvl);--ConfigMananger.Get(EconfigIndex.pzname,lvl - 1)
        --app.log("expdata#####################"..tostring(expdata.exp))
        local Allexp = expdata.exp
        
        --升级了
        if self.hasexp >= Allexp then
            --app.log("upupupupupup#######################")
            self.hasexp = self.hasexp - Allexp
            self.hasexpcurrent = self.hasexp
            self.haslvl = self.haslvl + 1
            --app.log("self.haslvl##################"..tostring(self.haslvl))
            currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]
            currentNeedexpdata = currentNeedexp.att_lv
            pzname = "t_"..currentNeedexpdata
            expdata = ConfigManager.Get(EConfigIndex[pzname],self.haslvl)
            Allexp = expdata.exp
            self.haveitemnum = 0;
        end
        
        --app.log("Allexp#####################"..tostring(Allexp))
    
        self.exptiao:set_value(self.hasexp/Allexp)
        self.expText:set_text("[973900FF]"..tostring(self.hasexp).."[-][000000FF]/"..tostring(Allexp).."[-]")
        
        local lvl = ConfigManager.Get(EConfigIndex[pzname],self.haslvl).adv_level;
        
        local show_level = ConfigManager.Get(EConfigIndex[pzname],self.haslvl).show_level;
                        

        self.lvl:set_text("等级 [fff721]"..tostring(show_level).."[-]")
        
        
        if Allexp == 0 then
            
            self:stopTime()
                        
            --self.upheadtext:set_text("")
            self.headicon:set_active(false)
            
            local expdata = ConfigManager.Get(EConfigIndex[pzname],self.haslvl - 1)
            local Allexp = expdata.exp
            
            self.exptiao:set_value(Allexp/Allexp)
            self.expText:set_text("[973900FF]"..tostring(Allexp).."[-][000000FF]/"..tostring(Allexp).."[-]")
            
            self.upbtn:set_active(true)
            self.useritemUI:set_active(false)
            
            local titlelvl = "t_"..currentNeedexp.att_adv
            local prodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            local nextprodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl+1);
            --app.log("expdata#########"..table.tostring(expdata))

            
                
            local proname = "";
            local nextvalue = 0;
            local curValue = 0;
            if prodata and nextprodata then
                
                for k,v in pairs(nextprodata)do
                    --app.log("#########"..tostring(v))
                    if v ~= 0 then
                        if k == 2 then
                            proname = "暴击"
                            nextvalue = v--
                            curValue = prodata[2]
                        elseif k == 3 then
                            proname = "免爆"
                            nextvalue = v
                            curValue = prodata[3]
                        elseif k == 4 then
                            proname = "暴伤"
                            nextvalue = v
                            curValue = prodata[4]
                        elseif k == 5 then
                            proname = "破击"
                            nextvalue = v
                            curValue = prodata[5]
                        elseif k == 6 then
                            proname = "格挡"
                            nextvalue = v
                            curValue = prodata[6]
                        elseif k == 7 then
                            proname = "格挡伤害"
                            nextvalue = v
                            curValue = prodata[7]
                        end
                    end
                end
                
            end


                        
            self.uptradetext:set_text("进阶后 [fff721]"..proname.."[-]提升：[00FF73FF]+"..tostring(nextvalue - curValue).."[-]")
            
            if self.data_id~= "" and self.item_id ~= 0 then
                --app.log("self.hasItemNum################"..tostring(self.hasItemNum))
                msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,self.hasItemNum)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
            end
            
            self.hasItemNum = 0; -- 物品个数
            self.haveitemnum = 0;
            self.haslvl = 0;     --模拟等级
            
            self.hasexp = 0;   --当前经验
            self.hasnextexp =0 ;  --下一级经验
            self.hasexpcurrent = 0;
            
            
            self.data_id = 0;
            self.item_id = 0;
            
        else
            self.upbtn:set_active(false)
            self.headicon:set_active(true)
            self.useritemUI:set_active(true)
            self.uptradetext:set_text("")
      
        end
        
        local ngvalue = expdata.qn_power;
        
        self.headtext:set_text(tostring(ngvalue))
        
        local nextlvldata = ConfigManager.Get(EConfigIndex[pzname],self.haslvl+1);

        self.playercurrentatkicon:set_active(true)
        self.playercurrenthpicon:set_active(true)
        self.playerdeficon:set_active(true)


        self.playercurrenthp:set_text(tostring(math.floor(expdata.add_hp)))
        self.playercurrentatk:set_text(tostring(math.floor(expdata.atk_power)))
        self.playercurrentdef:set_text(tostring(math.floor(expdata.def_power)))

        
        if nextlvldata then
        
            local upqnvalue = nextlvldata.qn_power

            self.playernexthp:set_text(tostring(math.floor(nextlvldata.add_hp)))
            self.playernextatk:set_text(tostring(math.floor(nextlvldata.atk_power)))
            self.playernetxdef:set_text(tostring(math.floor(nextlvldata.def_power)))

            if Allexp == 0 then
                self.upheadtext:set_text("")
                
            else
                self.upheadtext:set_text("  "..tostring(upqnvalue))
                
            end
           
            local titlelvl = "t_"..currentNeedexp.att_adv
           
            local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            
            self.titlename:set_text(titledata.adv_name)

            self.upbtn:set_sprite_names("ty_anniu3")
            if Allexp == 0 then
                self.trainningMaxtxt:set_active(false)
                self.trainningMaxtxt:set_text("")
                self.linepic:set_active(false)
                self.uplineandtxt:set_active(true)
            else
                self.trainningMaxtxt:set_active(true)
                self.trainningMaxtxt:set_text("长按道具可以连续升级")
                self.linepic:set_active(true)
                self.uplineandtxt:set_active(false)
            end
            
            self.maxbg:set_active(false)
            self.upheadtext:set_active(true)
        else
            
            self:stopTime()
            
            if self.data_id~= "" and self.item_id ~= 0 then
                --app.log("self.hasItemNum################"..tostring(self.hasItemNum))
                msg_cards.cg_use_training_hall_item(self.data_id,self.item_id,self.hasItemNum)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.ExpEnd)
            end
            
            self.hasItemNum = 0; -- 物品个数
            self.haveitemnum = 0;
            self.haslvl = 0;     --模拟等级
            
            self.hasexp = 0;   --当前经验
            self.hasnextexp =0 ;  --下一级经验
            self.hasexpcurrent = 0;
            
            
            self.data_id = 0;
            self.item_id = 0;
            
            self.upbtn:set_active(false)
            
            local titlelvl = "t_"..currentNeedexp.att_adv
            local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
            self.titlename:set_text(titledata.adv_name)
            self.upheadtext:set_active(false)
            --self.trainningMaxtxt:set_text("已提升至最高等级")
            self.maxbg:set_active(true)
            self.linepic:set_active(true)
            self.uptradetext:set_text("")
            self.trainningMaxtxt:set_active(false)
            
            self.uplineandtxt:set_active(true)

            self.playercurrenthp:set_text("")
            self.playercurrentatk:set_text("")
            self.playercurrentdef:set_text("")

            self.playernexthp:set_text("")
            self.playernextatk:set_text("")
            self.playernetxdef:set_text("")

            self.playercurrentatkicon:set_active(false)
            self.playercurrenthpicon:set_active(false)
            self.playerdeficon:set_active(false)

            self.nohaveplayerhp:set_text(tostring(math.floor(expdata.add_hp)))
            self.nohaveplayeratk:set_text(tostring(math.floor(expdata.atk_power)))
            self.nohaveplayerdef:set_text(tostring(math.floor(expdata.def_power)))

        end
    else
        self:NohaveHero()
       
        self:setchoseRoleData(self.currentroleinfo.default_rarity)        
    end
    
end

--[[材料获取途径]]
function TrainningInfo:on_find_way_material(t)    
    local temp = {}
    temp.item_id = t.float_value
    temp.number = tonumber(t.string_value)
    AcquiringWayUi.Start(temp)
end

function TrainningInfo:on_get_way(t)
    
    local data = self.currentroleinfo.config
    --app.log("data#########"..tostring(data.hero_soul_item_id))
    local temp = {}
    temp.item_id = data.hero_soul_item_id
    temp.number = 1
    AcquiringWayUi.Start(temp)
end

function TrainningInfo:on_up_lvl()
    self:stopTime()
    local data = self.currentroleinfo
    local flag = self:isHaveHero(data.default_rarity)
    if flag ~= "" then
        uiManager:PushUi(EUI.Trainninguplv);
        msg_cards.cg_training_hall_hero_advance(flag)
    end
end

function TrainningInfo:set_heroData(data,index)
    --app.log("#####################index  ##"..tostring(index))
    --app.log("#####################data[2]  ##"..tostring(data[2]))
    --local index = math.abs(real_id)+1;
    --local data = self.AllHerolist[self.currentline][index]
    --local item = obj:get_child_by_name("hero_suffering_item")
    
    local role = CardHuman:new({number=data[2], isNotCalProperty = true});
    local dataid = self:isHaveHero(data[2])
    
    self.playerlist[index]:set_active(true)

    --app.log("data######################"..table.tostring(data))
    --小红点
    local isCanUp = g_dataCenter.trainning:computitem(self.currentline)
    
    --if not self.Theroheadlist[b] then    
    if dataid ~= "" then
        local cardinfo = g_dataCenter.package:find_card(1, dataid);
        if cardinfo then
            --local TheroHead = SmallCardUi:new({parent=item ,info=cardinfo,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Level}});
            --TheroHead:SetParam(b);
            self.heroitemlist[index]:SetData(cardinfo)
            self.heroitemlist[index]:SetCallback(self.bindfunc['on_select_role']);
            --self.Theroheadlist[b] = TheroHead;
            --app.log("cardinfo======"..tostring(cardinfo.trainingHallLevel))
            --app.log("number========"..tostring(cardinfo.default_rarity))
            local isMax = g_dataCenter.trainning:computMax(cardinfo)

            if isCanUp and isMax == false then
                self.heroitemlist[index]:SetSpNew(true)
            else
                self.heroitemlist[index]:SetSpNew(false)
            end
            local sprite_name = PublicFunc.computitemlevlsprite(cardinfo.default_rarity,cardinfo.trainingHallLevel)
            self.heroitemlist[index]:SetTrainningRarity(sprite_name)
            self.heroitemlist[index]:SetGray(false)
        end
    else
        --local TheroHead = SmallCardUi:new({parent=item ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Level}});
        --TheroHead:SetParam(b);
        self.heroitemlist[index]:SetData(role)
        self.heroitemlist[index]:SetGray(true)
        self.heroitemlist[index]:SetCallback(self.bindfunc['on_select_role']);
        --self.Theroheadlist[b] = TheroHead;
        self.heroitemlist[index]:SetSpNew(false)
    end
    
    if index == self.currentindex then
        self.heroitemlist[index]:ChoseItem(true)
        self.choseitem = self.heroitemlist[index]
    end    
    
    self.playerlist[index]:set_active(true)
    --else        
    --    if dataid ~= "" then
    --        local cardinfo = g_dataCenter.package:find_card(1, dataid);
    --        self.Theroheadlist[b]:SetData(cardinfo)
    --        
    --        
    --        if isCanUp then
    --            self.Theroheadlist[b]:SetSpNew(true)
    --        else
    --            self.Theroheadlist[b]:SetSpNew(false)
    --        end
    --        
    --        self.Theroheadlist[b]:SetGray(false)
    --        
    --    else
    --        local role = CardHuman:new({number=data[2], isNotCalProperty = true});
    --        self.Theroheadlist[b]:SetData(role)
    --        self.Theroheadlist[b]:SetGray(true)
    --        self.Theroheadlist[b]:SetSpNew(false)
    --    end
    --end
end

function TrainningInfo:InitUIData()
    if self.currentroleinfo == nil then
        self.currentroleinfo = g_dataCenter.trainning:get_currentroleinfo()
    end
    
    --app.log("......"..debug.traceback())
    local id = self.currentroleinfo.default_rarity
    --local line =0;
    --local index = 0;
    --app.log("###############id##################"..id)
    for k,v in pairs(self.AllHerolist)do
        for kk,vv in pairs(v)do
            if vv[2] == id then
                self.currentline = k; --行
                self.currentindex = kk; -- 列
            end
        end
    end
    
    --app.log("line##################"..tostring(self.currentline).."##index ############## "..tostring(self.currentindex))
end

function TrainningInfo:bound3d()
    local id = self.currentroleinfo.default_rarity
    local dataid = self:isHaveHero(id)

    if dataid ~= "" then

        local cardinfo = g_dataCenter.package:find_card(1, dataid);
        
    	 local data = 
        {
            roleData = cardinfo,
            role3d_ui_touch = self.hero3D,
            type = "left",
        }
        --app.log("3d data #########"..tostring(id))
        Showtrainning3d.SetAndShow(data)
        TrainningInfo:PlayHeroAudio(cardinfo)
    else
        local cardinfo = CardHuman:new({number=id, isNotCalProperty = true});

        local data = 
        {
            roleData = cardinfo,
            role3d_ui_touch = self.hero3D,
            type = "left",
        }   
        Showtrainning3d.SetAndShow(data)
        TrainningInfo:PlayHeroAudio(cardinfo)
    end

    self.show3dmode = Showtrainning3d.GetInstance()
end

function TrainningInfo:PlayHeroAudio(info)
    if info and info.model_id then
        local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, info.model_id);
        if self.get_hero_audio ~= nil then
            AudioManager.StopUiAudio(self.get_hero_audio)
        end
        self.get_hero_audio = nil;
        if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
            local count = #model_list_cfg.egg_get_audio_id;
            local n = math.random(1,count)
            --app.log("n===="..n.."   count=="..count.."    id=="..table.tostring(model_list_cfg.egg_get_audio_id))
            self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
        end
    end
end

function TrainningInfo:set_currentRoleData()
    --app.log("self.currentline##############"..tostring(self.currentline))
    local heroid = self.AllHerolist[self.currentline][1][2]
    local dataid = self:isHaveHero(heroid)
    
    self:setNameTitle(dataid)
    --app.log("##dataid####################"..dataid.." ###################"..tostring(heroid))
    if dataid ~= "" then
        self.getBtn:set_active(false)
        self.pybtn:set_active(true)
        
        self.headicon:set_active(true)
        --self.powericon:set_active(true)
        --self.deficon:set_active(true)
        
        local cardinfo = g_dataCenter.package:find_card(1, dataid);
        if cardinfo then
            local data = 
            {
                roleData = cardinfo,
                role3d_ui_touch = self.hero3D,
                type = "left",
            }   
            Showtrainning3d.SetAndShow(data)
            TrainningInfo:PlayHeroAudio(cardinfo)
        end
        self.currentroleinfo = cardinfo
        
        self:setData()
    else
        local cardinfo = CardHuman:new({number=heroid, isNotCalProperty = true});
        if cardinfo then
            local data = 
            {
                roleData = cardinfo,
                role3d_ui_touch = self.hero3D,
                type = "left",
            }   
            Showtrainning3d.SetAndShow(data)
            TrainningInfo:PlayHeroAudio(cardinfo)
        end
        --app.log("cardinfo............."..table.tostring(cardinfo))
        self.topheroicon:SetData(cardinfo)
        
        
        self.currentroleinfo = cardinfo
        --self.playername:set_text(self.currentroleinfo.name)
        --self.playernamehave:set_text(self.currentroleinfo.name)
        self:NohaveHero()

        local name,rarity = PublicFunc.FormatHeroNameAndNumber(self.currentroleinfo.name)

        self.playername:set_text(name)
        self.playernamehave:set_text(name)

        --if rarity > 0 then
            self.playerraity:set_text(rarity)
        -- else
        --     self.playerraity:set_text("")
        -- end

        --self:setitemData()
    end
    
end

function TrainningInfo:setchoseRoleData( id )
    
    --app.log("id###############"..tostring(id))
    
    local heroid = id--self.AllHerolist[self.currentline][1][2]
    local dataid = self:isHaveHero(heroid)
    if dataid ~= "" then
        local cardinfo = g_dataCenter.package:find_card(1, dataid);
        if cardinfo then
            local data = 
            {
                roleData = cardinfo,
                role3d_ui_touch = self.hero3D,
                type = "left",
            }   
            Showtrainning3d.SetAndShow(data)
            TrainningInfo:PlayHeroAudio(cardinfo)
        end
        
        --self.topheroicon:SetData(cardinfo)
        
    else
        local cardinfo = CardHuman:new({number=heroid, isNotCalProperty = true});
        if cardinfo then
            local data = 
            {
                roleData = cardinfo,
                role3d_ui_touch = self.hero3D,
                type = "left",
            }   
            Showtrainning3d.SetAndShow(data)
            TrainningInfo:PlayHeroAudio(cardinfo)
        end
        --app.log("22222222222222222222222222222222")
        self.topheroicon:SetData(cardinfo)
        
    end
    
end

function TrainningInfo:NohaveHero()

    self.nohaveplayerhp:set_text("0")
    self.nohaveplayeratk:set_text("0")
    self.nohaveplayerdef:set_text("0")

    self.playercurrenthp:set_text("")
    self.playercurrentatk:set_text("")
    self.playercurrentdef:set_text("")

    self.playercurrentatkicon:set_active(false)
    self.playercurrenthpicon:set_active(false)
    self.playerdeficon:set_active(false)

    self.playernexthp:set_text("")
    self.playernextatk:set_text("")
    self.playernetxdef:set_text("")
    
    self.exptiao:set_value(0)
    self.expText:set_text("0/0")
        
    self.nohaveherotitle:set_active(true)
    self.titlename:set_active(false)
    
    self.lvl:set_active(false)
    self.powervalue:set_active(false)
    
    self.powervaluelayer:set_active(false)
    
    self.headtext:set_text("             0")
    --self.powertext:set_text("攻击:+0")
    --self.deftext:set_text("防御:+0")
    
    self.upheadtext:set_text("")
    --self.trainningMaxtxt:set_text("")
    --self.uppowertext:set_text("+0")
    --self.updeftext:set_text("+0")
    
    self.getBtn:set_active(true)
    self.pybtn:set_active(false)
    
    self.useritemUI:set_active(true)
    self.headicon:set_active(false)
    --self.powericon:set_active(false)
    --self.deficon:set_active(false)
    self.isHaveText:set_active(true)
    self.upbtn:set_active(false)
    
    self.uptradetext:set_text("")
    
    self:setItemData()
        
    for i=1,3 do
        self.useitemMask[i]:set_active(true)     
    end

    for i=1,3 do
        self.addexpitem[i]:SetTipPoint(false)
    end
    
    self.trainningMaxtxt:set_active(true)
    self.trainningMaxtxt:set_text("长按道具可以连续升级")
    self.linepic:set_active(true)
    
    self.maxbg:set_active(false)
    
    --self.infodi:set_color( 76/255,164/255,2/255,0)
    self.infodi1:set_sprite_name( "xlc_ditiao_bai")
    
    self.nohaveheadtext:set_active(true)
    
    self.uplineandtxt:set_active(false)
    
end

function TrainningInfo:on_click_right(t)
    self:stopTime()    
    local line = self.currentline + 1
    if line > #self.AllHerolist then
        line = 1
    end
    
    self.currentline = line
    self.currentindex = 1
    
    self:rushlist()
    
    self:set_currentRoleData()
    
end

function TrainningInfo:on_click_left(t)
    self:stopTime()
    --app.log("###################on_click_left##############")
    local line = self.currentline - 1
    if line == 0 then
        line = #self.AllHerolist
    end
    
    self.currentline = line
    self.currentindex = 1
    
    self:rushlist()
    
    self:set_currentRoleData()
end

function TrainningInfo:isHaveHero(id)
    
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

function TrainningInfo:on_click_up(t)
    --app.log("#######on_click_up############")
    if self.currentroleinfo then
        --app.log("on_click_up####################"..tostring(self.currentroleinfo.name))
        g_dataCenter.trainning:set_selectroleinfo(self.currentroleinfo)
    end
    uiManager:PushUi(EUI.Trainningheroinfo);
end

function TrainningInfo:UpdateUi()
    --self:setData()
    
end

function TrainningInfo:Show()
    --app.log("TrainningInfo.Show############")
    if UiBaseClass.Show(self) then
	if not Showtrainning3d.GetInstance() then
	    self:bound3d()
        end
    end    
end

function TrainningInfo:Hide()
    --app.log("TrainningInfo.Hide############")
    if UiBaseClass.Hide(self) then
        --app.log("TrainningInfo.Hide############1")
        if self.show3dmode and self.show3dmode == Showtrainning3d.GetInstance() then
             Showtrainning3d.Destroy()
             self.show3dmode = nil
        end
    end    
end



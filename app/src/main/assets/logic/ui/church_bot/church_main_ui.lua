ChurchBotMainUi = Class("ChurchBotMainUi", UiBaseClass)

local startype = 

{
    [1] = "qyzl_jiandan",
    [2] = "qyzl_putong",
    [3] = "qyzl_kunnan",
}

local startitle = 
{   
    [1] = "ld_diban_jd",
    [2] = "ld_diban_pt",
    [3] = "ld_diban_kn",  
}

function ChurchBotMainUi:GetNavigationAdvPlane()
    return true;
end

function ChurchBotMainUi:ShowNavigationBar()
    return true
end

function ChurchBotMainUi:Init(data)
    self.ChurchBotMain = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1605_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotMainUi:Restart(data)
    --self:bound3d()
    --app.log("Restart#########################")
    if UiBaseClass.Restart(self, data) then

    end
end

function ChurchBotMainUi:InitData(data)

    self.UnlockList = ConfigManager._GetConfigTable(EConfigIndex.t_church_pray_open);
    self.VipUnlockList = ConfigManager._GetConfigTable(EConfigIndex.t_vip_data);
    self.isplayMovie = false
    --self.timeid = {};
    UiBaseClass.InitData(self, data)
end

function ChurchBotMainUi:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotMainUi:DestroyUi()

    g_dataCenter.ChurchBot:setChurchState(false)

    self.currentindex = 0
    self.currentfindData = nil;
    self.isplayMovie = false

    for k,v in pairs(self.tiaozhanhead) do
        v:DestroyUi()
    end

    if self.timeid then
        timer.stop(self.timeid);
        self.timeid = nil;
    end
    
    UiBaseClass.DestroyUi(self);
    
end

function ChurchBotMainUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_updata_ui"] = Utility.bind_callback(self, self.on_updata_ui)
    self.bindfunc["on_UnlockmyPray"] = Utility.bind_callback(self, self.on_UnlockmyPray)
    self.bindfunc["on_btn_find"] = Utility.bind_callback(self, self.on_btn_find)
    self.bindfunc["ontimeshow"] = Utility.bind_callback(self, self.ontimeshow)
    self.bindfunc["on_look_info"] = Utility.bind_callback(self,self.on_look_info)
    self.bindfunc["on_updata_ui_unlock"] = Utility.bind_callback(self,self.on_updata_ui_unlock)
    self.bindfunc["on_show_battlelist"] = Utility.bind_callback(self, self.on_show_battlelist)
    self.bindfunc["setData"] = Utility.bind_callback(self, self.setData)
    self.bindfunc["on_rest"] = Utility.bind_callback(self, self.on_rest)
    self.bindfunc["on_begin"] = Utility.bind_callback(self, self.on_begin)
    self.bindfunc["on_btn_get"] = Utility.bind_callback(self, self.on_btn_get)
    self.bindfunc["UpdataGetUI"] = Utility.bind_callback(self, self.UpdataGetUI)
end


--注册消息分发回调函数
function ChurchBotMainUi:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_regist(msg_activity.gc_churchpray_unlock, self.bindfunc["on_updata_ui_unlock"])
    PublicFunc.msg_regist(msg_activity.gc_get_churchpray_reward, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_regist(msg_activity.gc_look_for_rival, self.bindfunc["setData"])
    PublicFunc.msg_regist(msg_activity.gc_get_churchpray_reward, self.bindfunc["UpdataGetUI"])
end

--注销消息分发回调函数
function ChurchBotMainUi:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_unregist(msg_activity.gc_churchpray_unlock, self.bindfunc["on_updata_ui_unlock"])
    PublicFunc.msg_unregist(msg_activity.gc_get_churchpray_reward, self.bindfunc["on_updata_ui"])
    PublicFunc.msg_unregist(msg_activity.gc_look_for_rival, self.bindfunc["setData"])
    PublicFunc.msg_unregist(msg_activity.gc_get_churchpray_reward, self.bindfunc["UpdataGetUI"])
end


--初始化UI
function ChurchBotMainUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotMainUi');

    self.battlelist = ngui.find_button(self.ui,"centre_other/animation/btn_zhan_bao")
    self.battlelist:set_on_click(self.bindfunc['on_show_battlelist'])

    self.findui = {} -- 查找界面
    self.unlockui = {}  --解锁界面
    self.zhanlinui = {} -- 占领界面
    self.finduicastgoldtext = {}  --查找界面 查找花费

    self.unlockgoldpic = {}        --需要金币or钻石解锁图标
    self.unlockgoldtxt = {}        --需要的 数目
    self.unlockviptxt = {}         --需要VIP解锁

    self.openbtn = {}              --开启按钮
    self.findbtn = {}              --查找按钮

    self.shengyutimelab = {}          --剩余时间

    self.noFinishui = {}            --占领未完成挂机
    self.finishui = {}              --占领完成挂机
    
    self.speedlab = {}              --挂机速度
    self.speedlab1 = {}             --物品2的速度
    self.speedlab2 = {}
    self.speedline = {}

    self.alllab = {}               --物品2
    self.alllab1 = {}              --物品2

    self.lookinfobtn = {}           --查看详情
    self.getBtn = {}                --收取按钮

    self.geticon1 = {}              --掠夺物品
    self.geticon2 = {}
    self.geticon3 = {}          

    self.geticon1child = {}
    self.geticon2child = {}
    self.geticon3child = {}

    self.zhanlinicon1 = {}
    self.zhanlinicon2= {}
    self.zhanlinicon3 = {}

    self.zhanlinaward1 = {}
    self.zhanlinaward2 = {}
    self.zhanlinaward3 = {}

    self.shouqiicon1 = {}           --收取图标
    self.shouqiicon2 = {}           --收取图标

    self.shouqulab1 = {}
    self.shouqulab2 = {}

    --解锁动画
    self.unlockanima = {}

    self.tiaozhanui = {}  --挑战UI
    self.tiaozhanbtn = {} --挑战按钮
    self.genghuanbtn = {} --更换按钮
    self.tiaozhanlab1 = {} --资源1 数量
    self.tiaozhanlab2 = {} -- 资源2 数量
    self.tiaozhanlab3 = {}

    self.tiaozhanicon1 = {}  -- 图标
    self.tiaozhanicon2 = {}  --图标
    self.tiaozhanicon3 = {}

    self.tiaozhanfight = {}  --战斗力
    self.tiaozhanhead = {}
    self.tiaozhannamelab = {}

    self.tiaozhanaward1 = {}
    self.tiaozhanaward2 = {}
    self.tiaozhanaward3 = {}

    self.faxiandirenui = {}
    self.tansuoingui = {}
    self.moviefaxiandiren = {}
    self.moviefindding = {}
    self.top_right_title = {}
    self.top_title = {}
    self.tiaozhan_nandu = {}
    self.tiaozhan_title_sprite = {}


    for i=1,4 do

        self.findui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tansuo")
        self.findui[i]:set_active(false)
        self.unlockui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_weijiesuo")
        self.unlockui[i]:set_active(false)
        self.zhanlinui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling")
        self.zhanlinui[i]:set_active(false)
        self.noFinishui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling/content_chakan")
        self.finishui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling/content_shouqu")

        self.finduicastgoldtext[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tansuo/sp_bar/lab_num")

        self.unlockgoldpic[i] = ngui.find_sprite(self.ui,"centre_other/animation/item"..i.."/content_weijiesuo/sp_bar/sp_gold")
        self.unlockgoldtxt[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_weijiesuo/sp_bar/lab_num")

        self.unlockviptxt[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_weijiesuo/lab_vip")
        self.openbtn[i] = ngui.find_button(self.ui,"centre_other/animation/item"..i.."/content_weijiesuo/btn_open")
        self.openbtn[i]:set_on_click(self.bindfunc['on_UnlockmyPray'])
        self.openbtn[i]:set_event_value("",i)

        self.findbtn[i] = ngui.find_button(self.ui,"centre_other/animation/item"..i.."/content_tansuo/btn_seek")
        self.findbtn[i]:set_on_click(self.bindfunc['on_btn_find'])
        self.findbtn[i]:set_event_value("",i)

        self.shengyutimelab[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/content_chakan/sco_bar/lab_time")
        self.speedlab[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt1/lab_num")
        self.speedlab1[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt3/lab_num")
        self.speedlab1[i]:set_text("")
        self.speedlab2[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/sp_kuang/lab_num")
        self.speedline[i] = ngui.find_progress_bar(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/content_chakan/sco_bar")
        self.speedline[i]:set_value(0)

        --占领
        self.zhanlinicon1[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt1/sp_kuang1")
        self.zhanlinicon2[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt3/sp_kuang1")
        self.zhanlinicon3[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/sp_kuang")

        self.zhanlinaward1[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling/txt1")
        self.zhanlinaward2[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling/txt3")
        self.zhanlinaward3[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_yizhanling/sp_kuang")
        self.zhanlinaward3[i]:set_active(false)
        --------------------------------------------------
        --挂满
        self.shouqiicon1[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt1/sp_kuang1")
        self.shouqiicon2[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt3/sp_kuang1")

        self.shouqulab1[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt1/lab_num")
        self.shouqulab2[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/txt3/lab_num")

        self.getBtn[i] = ngui.find_button(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/content_shouqu/btn_shouqu")
        self.getBtn[i]:set_event_value("",i)
        self.getBtn[i]:set_on_click(self.bindfunc['on_btn_get'])
        self.top_right_title[i] = ngui.find_sprite(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/sp_nandu")
        self.top_title[i] = ngui.find_sprite(self.ui,"centre_other/animation/item"..i.."/content_yizhanling/sp_title")

        --解锁动画
        --self.unlockanima[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_weijiesuo/animation")
        --挑战UI
        self.tiaozhanui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tiaozhan")
        self.tiaozhanui[i]:set_active(false)

        local tiaozhanpic = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tiaozhan/sp_head_di_item")
        self.tiaozhanhead[i] = UiPlayerHead:new({parent = tiaozhanpic })--,info={},stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star,SmallCardUi.SType.Qh,SmallCardUi.SType.Level}});

        self.tiaozhannamelab[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/lab_name")

        self.tiaozhanbtn[i] = ngui.find_button(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/btn_tiaozhan")
        self.tiaozhanbtn[i]:set_event_value("",i)
        self.tiaozhanbtn[i]:set_on_click(self.bindfunc['on_begin'])
        
        self.genghuanbtn[i] = ngui.find_button(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/btn_genghuan")
        self.genghuanbtn[i]:set_event_value("",i)
        self.genghuanbtn[i]:set_on_click(self.bindfunc['on_rest'])

        self.tiaozhanaward1[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tiaozhan/sp_bar1")
        self.tiaozhanlab1[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar1/lab_num1")
        self.tiaozhanicon1[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar1/sp_kuang1")

        self.tiaozhanaward2[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tiaozhan/sp_bar2")
        self.tiaozhanlab2[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar2/lab_num1")
        self.tiaozhanicon2[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar2/sp_kuang1")
        self.tiaozhanicon2[i]:set_active(false)

        self.tiaozhanaward3[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tiaozhan/sp_bar3")
        self.tiaozhanlab3[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar3/lab_num1")
        self.tiaozhanicon3[i] = ngui.find_texture(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_bar3/sp_kuang1")
        self.tiaozhanaward3[i]:set_active(false)

        --战斗力
        self.tiaozhanfight[i] = ngui.find_label(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_fight/lab_fight")
        self.tiaozhan_nandu[i] = ngui.find_sprite(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_nandu")
        self.tiaozhan_title_sprite[i] = ngui.find_sprite(self.ui,"centre_other/animation/item"..i.."/content_tiaozhan/sp_title")
        ----------
        --发现敌人界面
        self.faxiandirenui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_faxiandiren")
        self.faxiandirenui[i]:set_active(false)
        self.moviefaxiandiren[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_faxiandiren/animation")

        --探索ing界面
        self.tansuoingui[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tansuoing")
        self.tansuoingui[i]:set_active(false)
        self.moviefindding[i] = self.ui:get_child_by_name("centre_other/animation/item"..i.."/content_tansuoing/animation")
    end

    msg_activity.cg_churchpray_request_myslef_info()
end

function ChurchBotMainUi:on_btn_get(t)

    -- local flag = g_dataCenter.ChurchBot:getChurchState()

    -- if flag then
    --     FloatTip.Float("正在占领一个区域...");
    --     do return end
    -- end

    if self.isplayMovie then

        FloatTip.Float("正在搜索中...");

    else
        local index = t.float_value
        if index > 0 then
            --app.log("on_btn_get##########################"..tostring(index))
            msg_activity.cg_get_churchpray_reward(index)
        end
    end
end

function ChurchBotMainUi:on_UnlockmyPray(t)

    local index = t.float_value;
    if index > 0 then
        if self.canOpenforvip >= index then
            local needlevel = ConfigManager.Get(EConfigIndex.t_church_pray_open,index).player_leve

            local level = g_dataCenter.player.level;

            if level < needlevel then
                FloatTip.Float(tostring(needlevel).."级开启");
            else
                msg_activity.cg_churchpray_unlock(index)
            end
            --self:playe_unlock_anima(index)
            --msg_activity.cg_churchpray_unlock(index)
        else
            FloatTip.Float("好感度不够！");
        end
    end
end

function ChurchBotMainUi:setData(index,findData)
    --app.log("open tiaozhan.....index"..tostring(index))
    self.isplayMovie = true
    self.currentindex = index
    self.currentfindData = findData

    self.findui[index]:set_active(false)
    self.unlockui[index]:set_active(false)
    self.zhanlinui[index]:set_active(false)
    self.tiaozhanui[index]:set_active(false)
    self.tansuoingui[index]:set_active(true)
    -- self:set_tiaozhanUI(index,findData)
    self:playFindMovie(index)
end

function ChurchBotMainUi:setShowData(index,findData)
    self.findui[index]:set_active(false)
    self.unlockui[index]:set_active(false)
    self.zhanlinui[index]:set_active(false)
    --self.tiaozhanui[index]:set_active(false)
    self.tansuoingui[index]:set_active(false)
    self.faxiandirenui[index]:set_active(false)
    g_dataCenter.ChurchBot:setChurchState(true)
    self.tiaozhanui[index]:set_active(true)
    self:set_tiaozhanUI(index,findData)
    self.isplayMovie = false
end

function ChurchBotMainUi:playFindMovie(index)
    --app.log("playFindMovie==========="..tostring(index))
    self.moviefindding[index]:animated_play("ui_1605_lveduo_tansuozhong")  
end

function beginfind()
    local obj = uiManager:FindUI(EUI.ChurchBotMainUi)
    local index = obj:get_currentindex()
    obj:playFaxiandiren()
end

function ChurchBotMainUi:playFaxiandiren()
    self.tansuoingui[self.currentindex]:set_active(false)
    self.faxiandirenui[self.currentindex]:set_active(true)
    self.moviefaxiandiren[self.currentindex]:animated_play("ui_1605_lveduo_faxiandiren")  
end

function endfind()
    --app.log("endfind---------------------------")
    local obj = uiManager:FindUI(EUI.ChurchBotMainUi)
    local index = obj:get_currentindex()

    obj:setFind(index)
    NoticeManager.Notice(ENUM.NoticeType.RegionSelectRivalOK);
end

function ChurchBotMainUi:setFind(index)
    self.faxiandirenui[index]:set_active(false)
    g_dataCenter.ChurchBot:setChurchState(true)
    self.tiaozhanui[index]:set_active(true)
    self:set_tiaozhanUI(index,self.currentfindData)
    self.isplayMovie = false
end

function ChurchBotMainUi:set_tiaozhanUI(index,findData)

    local tarLvl = findData.playerLevel
    local posIndex = findData.posIndex
    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    app.log("nStar================"..tostring(nStar))
    self.tiaozhan_nandu[index]:set_sprite_name(startype[nStar])
    self.tiaozhan_title_sprite[index]:set_sprite_name(startitle[nStar])

    local team1= findData.vecRoleDataTeam1
    local team2 = findData.vecRoleDataTeam2

    local FightValue = 0;
    for k,v in pairs(team1) do
        FightValue = FightValue + v.fight_value    
    end
    
    for k,v in pairs( team2 ) do
        FightValue = FightValue + v.fight_value   
    end

    --app.log("findData=========="..table.tostring(findData))
    self.tiaozhannamelab[index]:set_text(findData.szPlayerName)  --标题
    self.tiaozhanfight[index]:set_text(tostring(FightValue))
    local cardinfo = CardHuman:new({number=findData.playerNumber,level=findData.playerLevel});
    --app.log("cardinfo================="..table.tostring(findData))
    self.tiaozhanhead[index]:SetRoleId(findData.playerNumber)
    self.tiaozhanhead[index]:SetVipLevel(findData.vipLevel)
    self:computResources(index,findData)


    --更新查找花费界面
    for i=1,4 do
        local flag = self:IsUnlock(i)
        if flag then
            local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
            local myPoslist = g_dataCenter.ChurchBot:getMyPoslistData()
            
            if myPoslist[i].bUnlock then
                local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
                self.finduicastgoldtext[i]:set_text(tostring(findcast))
            end
        end
    end
end

--计算掠夺资源
function ChurchBotMainUi:computResources( index,findData )
    
    --改为固定奖励
    local nStar = g_dataCenter.ChurchBot:getnstar()
    app.log("nStar====================="..tostring(nStar))
    local church_rewardlist_data = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar);
    -- local rewardlistid = church_rewardlist_data.dropid
    -- app.log("rewardlistid=================="..tostring(rewardlistid))
    -- local droplist = ConfigManager.Get(EConfigIndex.t_drop_something,rewardlistid);
    -- app.log("droplist======================"..table.tostring(droplist))

    -- for k,v in pairs(droplist) do
    --     if k== 1 then
    --         self.tiaozhanlab1[index]:set_text(tostring(v.goods_number))
    --         local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
    --         self.tiaozhanicon1[index]:set_texture(itemicon)
    --     elseif k == 2 then
    --         self.tiaozhanlab2[index]:set_text(tostring(v.goods_number))
    --         local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
    --         self.tiaozhanicon2[index]:set_texture(itemicon)
    --         self.tiaozhanicon2[index]:set_active(true)
    --     end
    -- end

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
    --itemid1 = 0;--测试代码
    local xxname = "star"..tostring(nStar).."_resource"..tostring(itemid)
    --app.log("xxname#################"..xxname)
    --end
    
    local keyname = "resource_num_"..tostring(itemid)
    --app.log("keyname#################"..keyname)
    local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar)
    local keyid = keydata[keyname]
    --app.log("keyid#################"..tostring(keyid))
    
    --self.itemid1 = keyid
    
    local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    self.tiaozhanicon1[index]:set_texture(itemicon)
    
    local level = g_dataCenter.player.level;
    local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
    local tdata = church_pos_data[xxname]
    
    self.tiaozhanlab1[index]:set_text(tostring(tdata))

    --self.kldlab:set_text("11111")
    --self.itemcount = math.floor(cannumb/2)
    app.log("itemid1======================="..tostring(itemid1))

    if itemid1 > 0 then
        local xxname = "star"..tostring(nStar).."_resource"..tostring(itemid1)
        --app.log("xxname#################"..xxname)
        --end
        
        local keyname = "resource_num_"..tostring(itemid1)
        --app.log("keyname#################"..keyname)
        local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar)
        local keyid = keydata[keyname]
        --app.log("keyid#################"..tostring(keyid))
        
        --self.itemid2 = keyid
        
        local itemicon1 = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
        self.tiaozhanicon2[index]:set_texture(itemicon1)
        self.tiaozhanicon2[index]:set_active(true)
        
        local level = g_dataCenter.player.level;
        local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
        local tdata1 = church_pos_data[xxname]
        
        --local time = findData.keepPrayTime
        --local cannumb = tdata*time/3600
        app.log("tdata============="..tostring(tdata1))
        self.tiaozhanlab2[index]:set_text(tostring(tdata1))

        self.tiaozhanicon3[index]:set_texture(itemicon)
        self.tiaozhanlab3[index]:set_text(tostring(tdata))

        if tdata1 == 0 then
            self.tiaozhanaward3[index]:set_active(true)
            self.tiaozhanaward1[index]:set_active(false)
            self.tiaozhanaward2[index]:set_active(false)
        else
            self.tiaozhanaward3[index]:set_active(false)
            self.tiaozhanaward1[index]:set_active(true)
            self.tiaozhanaward2[index]:set_active(true)
        end
        --self.kldlab:set_text("11111")
        --self.itemcount1 = math.floor(cannumb/2)
        --self.kldicon1:set_active(true)
    else
        self.tiaozhanaward3[index]:set_active(true)
        self.tiaozhanaward1[index]:set_active(false)
        self.tiaozhanaward2[index]:set_active(false)
        self.tiaozhanicon3[index]:set_texture(itemicon)
        self.tiaozhanlab3[index]:set_text(tostring(tdata))
    end

end

function ChurchBotMainUi:on_rest(t)
    
    local rest = function()

        local nStar = g_dataCenter.ChurchBot:getnstar()
        local myprayIndex = g_dataCenter.ChurchBot:getmyprayIndex()
        
        msg_activity.cg_look_for_rival(nStar,myprayIndex)
    end
    
    local btn1 = {};
    btn1.str = "确定";
    btn1.func = rest
    
    local btn2 = {};
    btn2.str = "取消";
    
    local RefreshTimes = g_dataCenter.ChurchBot:getfindnumber()
    
    local CostMoneydata = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,RefreshTimes);
    
    HintUI.SetAndShowHybrid(2, "重新寻找","本次重新寻找需花费：|item:2|"..tostring(CostMoneydata.cost),nil,btn1,btn2);
end

function ChurchBotMainUi:on_begin()
    --uiManager:PopUi();
    uiManager:PushUi(EUI.ChurchBotlineup);
end

function ChurchBotMainUi:on_btn_find(t)

    local flag = g_dataCenter.ChurchBot:getChurchState()

    if flag then
        FloatTip.Float("正在占领一个区域...");
        do return end
    end

    if self.isplayMovie then

        FloatTip.Float("正在搜索中...");

    else

        local index = t.float_value;
        self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
        
        if self.PoslistData[index].bUnlock then
            g_dataCenter.ChurchBot:setmyprayIndex(index)
            
            uiManager:PushUi(EUI.ChurchBotSelect);
        else
            FloatTip.Float("该位置还没有解锁！");
        end
    end
end

function ChurchBotMainUi:on_updata_ui_unlock(index)
    self.currentpage = index;
    -- self:playe_unlock_anima(index)
    self:setFindUiData(index)
end

function ChurchBotMainUi:get_currentpage()
    return self.currentpage
end

function ChurchBotMainUi:get_currentindex()
    return self.currentindex
end

--动画播放完后的回调
function on_unlockchurch()
    --self:setFindUiData(i)
    --msg_activity.cg_churchpray_unlock(index)
    local obj = uiManager:FindUI(EUI.ChurchBotMainUi)
    local index = obj:get_currentpage()
    obj:setFindUiData(index)
end

function ChurchBotMainUi:playe_unlock_anima(index)
    self.unlockanima[index]:animated_play("ui_1605_lveduo_weijiesuo_kaisuo")  
end

function ChurchBotMainUi:on_updata_ui()
    --app.log("on_updata_ui===============================")

    self.PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    
    for i=1,4 do

        if self.PoslistData[i].churchStar > 0 then
            --先判断是否已挂满时间
            self:setFininshUI(i)
        else
            --先判断是否已解锁
            local flag = self:IsUnlock(i)
            if flag then
                self:setFindUiData(i)
                --self:playe_unlock_anima(i)
            else
                self:setIsUnlockUI(i)
            end
            --elf:IsUnlock(i)
        end
    end
end


function ChurchBotMainUi:setFindUiData(index)

    self.findui[index]:set_active(true)
    self.unlockui[index]:set_active(false)
    self.zhanlinui[index]:set_active(false)
    self.tiaozhanui[index]:set_active(false)

    local reshnumb = g_dataCenter.ChurchBot:getfindnumber()
    local myPoslist = g_dataCenter.ChurchBot:getMyPoslistData()
    
    if myPoslist[index].bUnlock then
        local findcast = ConfigManager.Get(EConfigIndex.t_church_pray_refresh_cost,reshnumb).cost
        self.finduicastgoldtext[index]:set_text(tostring(findcast))
    end
end

--判断是否解锁
function ChurchBotMainUi:IsUnlock(index)
    
    if self.PoslistData then
        if self.PoslistData[index] then
            if self.PoslistData[index].bUnlock then
                return true
            
            else
                return false
            end
        end
    end
    
   
end

function ChurchBotMainUi:setIsUnlockUI(index)

    self.findui[index]:set_active(false)
    self.unlockui[index]:set_active(true)
    self.zhanlinui[index]:set_active(false)

    local vip = g_dataCenter.player.vip
    if self.VipUnlockList[vip] then
        self.canOpenforvip = self.VipUnlockList[vip].churchpray_add_ore_num     
    end
    self:setCastUiData(index)

end

function ChurchBotMainUi:setCastUiData(index)
    local castid = ConfigManager.Get(EConfigIndex.t_church_pray_open,index).cost_id
    
    local castnum = ConfigManager.Get(EConfigIndex.t_church_pray_open,index).cost_num

    local needlevel = ConfigManager.Get(EConfigIndex.t_church_pray_open,index).player_leve

    local level = g_dataCenter.player.level;
    
    if self.canOpenforvip then
   
        if self.canOpenforvip >= index then

            if level >= needlevel then
                if castnum == 0 then
                    self.unlockviptxt[index]:set_active(false)
                    --self.unlockgoldpic[index]:set_active(false)
                    self.unlockgoldtxt[index]:set_text("免费")
                else
                    self.unlockviptxt[index]:set_active(false)
                    self.unlockgoldpic[index]:set_active(true)
                    self.unlockgoldtxt[index]:set_active(true)
                    self.unlockgoldtxt[index]:set_text(tostring(castnum))
                end
            else
                self.unlockviptxt[index]:set_text(tostring(needlevel).."级开启")
                self.unlockgoldpic[index]:set_active(false)
                self.unlockgoldtxt[index]:set_active(false)
                self.openbtn[index]:set_active(false)
            end
        
        else
            
            local needvip = 0
            
            for k,v in ipairs(self.VipUnlockList) do
            
                if v.churchpray_add_ore_num == index then
                    
                    needvip = k
                    break
                end
            end
            
            if needvip == 0 then
                if level >= needlevel then
                    if castnum == 0 then
                        self.unlockviptxt[index]:set_active(false)
                        --self.unlockgoldpic[index]:set_active(false)
                        self.unlockgoldtxt[index]:set_text("免费")
                    else
                        self.unlockviptxt[index]:set_active(false)
                        self.unlockgoldpic[index]:set_active(true)
                        self.unlockgoldtxt[index]:set_active(true)
                        self.unlockgoldtxt[index]:set_text(tostring(castnum))
                    end
                else
                    self.unlockviptxt[index]:set_text(tostring(needlevel).."级开启")
                    self.unlockgoldpic[index]:set_active(false)
                    self.unlockgoldtxt[index]:set_active(false)
                    self.openbtn[index]:set_active(false)
                end
            else
                --self:VipShowOrHide(true)
                self.unlockgoldpic[index]:set_active(false)
                self.unlockgoldtxt[index]:set_active(false)
                self.unlockviptxt[index]:set_active(true)
                self.unlockviptxt[index]:set_text("VIP"..tostring(needvip).."开启")
                self.openbtn[index]:set_active(false)
                --self.getbtn:set_active(false)
            end
        end
    else
       if level >= needlevel then
            if castnum == 0 then
                self.unlockviptxt[index]:set_active(false)
                --self.unlockgoldpic[index]:set_active(false)
                self.unlockgoldtxt[index]:set_text("免费")
            else
                self.unlockviptxt[index]:set_active(false)
                self.unlockgoldpic[index]:set_active(true)
                self.unlockgoldtxt[index]:set_active(true)
                self.unlockgoldtxt[index]:set_text(tostring(castnum))
            end
        else
            self.unlockviptxt[index]:set_text(tostring(needlevel).."级开启")
            self.unlockgoldpic[index]:set_active(false)
            self.unlockgoldtxt[index]:set_active(false)
            self.openbtn[index]:set_active(false)
        end

    end
    
    if self.PoslistData then
        if self.PoslistData[index] then
            if self.PoslistData[index].bUnlock then
                self.unlockgoldpic[index]:set_sprite_name("jinbi")
                --self.unlockgoldtxt[index]:set_active(true)
            else
                if castid == 2 then
                    self.unlockgoldpic[index]:set_sprite_name("jinbi")
                    --self.unlockgoldtxt[index]:set_active(true)
                elseif castid == 3 then
                    self.unlockgoldpic[index]:set_sprite_name("dh_hongshuijing")
                    --self.unlockgoldtxt[index]:set_active(true)
                end
            end
        end
    end
end


--占领界面
function ChurchBotMainUi:setFininshUI( index )
    
    self.findui[index]:set_active(false)
    self.unlockui[index]:set_active(false)
    self.zhanlinui[index]:set_active(true)

    self:setTimeData(index)

    --app.log("setFininshUI#################")
    
    local nSta = self.PoslistData[index].churchStar
    local posindex = self.PoslistData[index].posIndex
    local church_pos_detail_data = ConfigManager.Get(EConfigIndex.t_church_pos_detail_data,nSta);
    
    self.top_right_title[index]:set_sprite_name(startype[nSta])
    self.top_title[index]:set_sprite_name(startitle[nSta])

    local time = 0
    local itemid = 0
    local itemid1 = 0;
    for k,v in pairs(church_pos_detail_data) do
        --app.log("posindex#################"..table.tostring(v.posIndex))
        if v.posIndex ==  posindex then
            itemid = v.resourceType1
            itemid1 = v.resourceType2
            break;
        end
    end
    --itemid1 = 0; --测试代码
    app.log("itemid1#################"..tostring(itemid1))
    
    local keyname = "resource_num_"..tostring(itemid)
    local keyname1 = "resource_num_"..tostring(itemid1)
    app.log("keyname1=============="..keyname1)
    --app.log("keyname#################"..keyname1)
    local keydata = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta)
    local keyid = keydata[keyname]
    local keyid1 = keydata[keyname1]
    --app.log("keyid#################"..tostring(keyid))
    --app.log("keyid1#################"..tostring(keyid1))

    local keyiconname = "resource_icon_"..tostring(itemid)

    local itemicon = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    --local itemicon1 = ConfigManager.Get(EConfigIndex.t_item,keyid).small_icon
    
    local xxname = "star"..tostring(nSta).."_resource"..tostring(itemid)
    --app.log("xxname#################"..xxname)
    --end
    
    local level = g_dataCenter.player.level;
    local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
    local tdata = church_pos_data[xxname]

   -- app.log("xxname#################"..index)
    self.speedlab[index]:set_text(tostring(tdata))

    --app.log("itemicon========"..itemicon)

    self.zhanlinicon1[index]:set_texture(itemicon)

    --app.log("keyid1-----------------"..tostring(keyid1))

    local tdata1 = 0;
    local itemicon1 = ""
    if itemid1 > 0 then
        local keyiconname1 = "resource_icon_"..tostring(itemid1)
        itemicon1 = ConfigManager.Get(EConfigIndex.t_item,keyid1).small_icon
        local xxname1 = "star"..tostring(nSta).."_resource"..tostring(itemid1)
        tdata1 = church_pos_data[xxname1]
        --self.speedlab[index]:set_text(tostring(tdata))
        app.log("tdata1============="..tostring(tdata1))
        self.speedlab1[index]:set_text(tostring(tdata1))
        --app.log("itemicon1======="..itemicon1)
        self.zhanlinicon2[index]:set_texture(itemicon1)

        if tdata1 == 0 then
            self.zhanlinaward3[index]:set_active(true)
            self.zhanlinaward1[index]:set_active(false)
            self.zhanlinaward2[index]:set_active(false)
            self.speedlab2[index]:set_text(tostring(tdata))
            self.zhanlinicon3[index]:set_texture(itemicon)
        else
            self.zhanlinaward3[index]:set_active(false)
            self.zhanlinaward1[index]:set_active(true)
            self.zhanlinaward2[index]:set_active(true)
        end

        -- self.geticon1[index]:set_texture(itemicon)
        -- self.geticon2[index]:set_texture(itemicon1)
        -- self.geticon1child[index]:set_active(true)
        -- self.geticon2child[index]:set_active(true)
    else
        -- self.geticon3[index]:set_texture(itemicon)
        -- self.geticon3child[index]:set_active(true)
        self.zhanlinaward3[index]:set_active(true)
        self.zhanlinaward1[index]:set_active(false)
        self.zhanlinaward2[index]:set_active(false)
        self.speedlab2[index]:set_text(tostring(tdata))
        self.zhanlinicon3[index]:set_texture(itemicon)
    end

    local lasttime = self.PoslistData[index].prayStartTime
    --local nstar = self.PoslistData[self.currentpage].churchStar
    local nowtime = system.time()
    local casttime = nowtime - lasttime
    --local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(casttime);
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta).canPrayTime;
    local shengyutime = needtime - casttime
    
    local ttdata = tdata/3600
    
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nSta).canPrayTime;
    local all = shengyutime*ttdata
    
    if shengyutime <= 0 then
        self.shouqulab1[index]:set_text(tostring(math.floor(needtime*ttdata)))
        --self.itemcount = math.floor(needtime*ttdata)
        self.shouqiicon1[index]:set_texture(itemicon)
        if itemid1 > 0 then
            local ttdata1 = tdata1/3600
            self.shouqulab2[index]:set_text(tostring(math.floor(needtime*ttdata1)))
            self.shouqiicon2[index]:set_texture(itemicon1)
        end
    else
       -- self.alllab:set_text(tostring(math.floor(casttime*ttdata)))
       -- self.itemcount = math.floor(casttime*ttdata)
    end
    
end



function ChurchBotMainUi:setTimeData(index)
    --设置已挂机数据
    local lasttime = self.PoslistData[index].prayStartTime
    local nstar = self.PoslistData[index].churchStar
    local nowtime = system.time()
    local casttime = nowtime - lasttime
    local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
    local shengyutime = needtime - casttime
    
    -- app.log("index==============="..tostring(index))
    if shengyutime < 0 then
        -- app.log("1111111111111")
        self:ShowFinishUI(true,index)
        self.shengyutimelab[index]:set_text("00:00:00")
        self.speedline[index]:set_value(1)
    else
        self:ShowFinishUI(false,index)
        -- app.log("22222222222222")
        local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(shengyutime);
        self.speedline[index]:set_value(casttime/needtime)
        self.shengyutimelab[index]:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));
        if self.timeid == nil then
            self.timeid = timer.create(self.bindfunc["ontimeshow"] ,1000,-1)
        end
    end
    
    --self:setFininshUI()
end

function ChurchBotMainUi:ontimeshow()

    for k=1,4 do
    
        if self.PoslistData[k].churchStar > 0 then
        
            local lasttime = self.PoslistData[k].prayStartTime
            local nstar = self.PoslistData[k].churchStar
            local nowtime = system.time()
            local casttime = nowtime - lasttime
            local needtime = ConfigManager.Get(EConfigIndex.t_church_pos_data,nstar).canPrayTime;
            local shengyutime = needtime - casttime
            
            if shengyutime < 0 then
                self.shengyutimelab[k]:set_text("00:00:00")
                --self.getbtn:set_active(true)  
                self:ShowFinishUI(true,k)
                self.speedline[k]:set_value(1)
            else
                local day,hour,min,sec = TimeAnalysis.ConvertSecToDayHourMin(shengyutime);
                self.shengyutimelab[k]:set_text(string.format("%02d:", hour) .. string.format("%02d:", min) .. string.format("%02d", sec));   
                self.speedline[k]:set_value(casttime/needtime)
            end

        end
    end

end

function ChurchBotMainUi:ShowFinishUI(flag,index)
    if flag then
        self.noFinishui[index]:set_active(false)
        self.finishui[index]:set_active(true)
    else
        self.noFinishui[index]:set_active(true)
        self.finishui[index]:set_active(false)
    end
end

function ChurchBotMainUi:on_look_info(t)
    local index = t.float_value;
    --app.log("index ============="..tostring(index))
    --ChurchBotMain:setCurrentPage(index)
    --uiManager:pushUi(EUI.ChurchBotMain)
    g_dataCenter.ChurchBot:setmyprayIndex(index)
    uiManager:PushUi(EUI.ChurchBotMain);
end

function ChurchBotMainUi:UpdataGetUI()
    
    local rewardlist = g_dataCenter.ChurchBot:getreward()

    -- 双倍
    for k,v in pairs(rewardlist) do
        rewardlist[k].double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.church_hook, v.id);
    end

    self:on_updata_ui()
    
    --app.log("rewardlist -============="..table.tostring(rewardlist))

    CommonAward.Start(rewardlist, tType)
    
    
end

function ChurchBotMainUi:on_show_battlelist()
    uiManager:PushUi(EUI.ChurchBotBattleList);
end

function ChurchBotMainUi:Hide()
    if UiBaseClass.Hide(self) then
        app.log("Hide================================")
    end
end

function ChurchBotMainUi:Show()
    if UiBaseClass.Show(self) then
        app.log("Show================================")
        if self.currentfindData then
            self:setShowData(self.currentindex,self.currentfindData)
        end
    end
end
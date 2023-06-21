
ChurchBotlineup = Class("ChurchBotlineup", UiBaseClass)


function ChurchBotlineup:Init(data)
    self.ChurchBotlineup = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1606_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotlineup:Restart(data)
    self.frist = 1;
    self.isteam1read = false
    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotlineup:InitData(data)
    self.currentindex = 1
    self.isTeamline = 1
    self.frist = 1
    self.isguide = GuideManager.IsGuideRuning();   --true 开启  false 关闭
    self.team1fightvalue = 0;
    self.team2fightvalue = 0;
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotlineup:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotlineup:DestroyUi()

    for k,v in pairs(self.OthercardM1) do
        v:DestroyUi()
    end

    for k,v in pairs(self.OthercardM2) do
        v:DestroyUi()
    end

    for k,v in pairs(self.cardM1) do
        v:DestroyUi()
    end    

    for k,v in pairs(self.cardM2) do
        v:DestroyUi()
    end

    self.frist = 1
    UiBaseClass.DestroyUi(self);

end

function ChurchBotlineup:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)      --关闭
    self.bindfunc["onClickRoleCard1"] = Utility.bind_callback(self, self.onClickRoleCard1)
    self.bindfunc["onClickRoleCard2"] = Utility.bind_callback(self, self.onClickRoleCard2)
    self.bindfunc["on_team_change1"] = Utility.bind_callback(self, self.on_team_change1)
    self.bindfunc["on_team_change2"] = Utility.bind_callback(self, self.on_team_change2)
    self.bindfunc["Beginbattle"] = Utility.bind_callback(self, self.Beginbattle)
    self.bindfunc["one_on_team"] = Utility.bind_callback(self,self.one_on_team)
    
end


--注册消息分发回调函数
function ChurchBotlineup:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function ChurchBotlineup:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function ChurchBotlineup:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotlineup');

    -- self.closebtn = ngui.find_button(self.ui,"centre_other/animation/btn_cha")
    -- self.closebtn:set_on_click(self.bindfunc['on_btn_close'])
    self.toptitle = ngui.find_label(self.ui,"centre_other/animation/top_other/animation/txt1")
    self.dengjilab = ngui.find_label(self.ui,"centre_other/animation/top_other/animation/lab_level1")

    self.mynamelab = ngui.find_label(self.ui,"centre_other/animation/left_other/animation/lab_name")
    self.mylvllab = ngui.find_label(self.ui,"centre_other/animation/left_other/animation/lab_dengji")
    self.myfightlab = ngui.find_label(self.ui,"centre_other/animation/left_other/animation/sp_fight/lab_fight")

    self.team1 = self.ui:get_child_by_name("centre_other/animation/lab_duiwu1")
    self.team2 = self.ui:get_child_by_name("centre_other/animation/lab_duiwu2")
    
    self.team1role = {} --战队1选人列表
    self.team2role = {} --战队2选人列表
        
    for i=1,3 do
    	self.team1role[i] = self.ui:get_child_by_name("centre_other/animation/left_other/animation/lab_duiwu1/new_small_card_item"..i)
    	self.team2role[i] = self.ui:get_child_by_name("centre_other/animation/left_other/animation/lab_duiwu2/new_small_card_item"..i)
    end
    ---------------------------

    self.othernamelab = ngui.find_label(self.ui,"centre_other/animation/right_other/animation/lab_name")
    self.otherlvllab = ngui.find_label(self.ui,"centre_other/animation/right_other/animation/lab_dengji")
    self.otherfight = ngui.find_label(self.ui,"centre_other/animation/right_other/animation/sp_fight/lab_fight")

    self.otherteam1role = {}
    self.otherteam2role = {}

    for i=1,3 do
        self.otherteam1role[i] = self.ui:get_child_by_name("centre_other/animation/right_other/animation/lab_duiwu1/new_small_card_item"..i)
        self.otherteam2role[i] = self.ui:get_child_by_name("centre_other/animation/right_other/animation/lab_duiwu2/new_small_card_item"..i)
    end
    
    self.selectrolebtn1 = ngui.find_button(self.ui,"centre_other/animation/left_other/animation/lab_duiwu1/btn_xiazhen")
    --self.selectrolebtn1:set_active(false)
    self.selectrolebtn1:set_on_click(self.bindfunc['onClickRoleCard1']);
    
    self.selectrolebtn2 = ngui.find_button(self.ui,"centre_other/animation/left_other/animation/lab_duiwu2/btn_xiazhen")
    self.selectrolebtn2:set_on_click(self.bindfunc['onClickRoleCard2']);
    --self.selectrolebtn2:set_active(false)

    self.needvigor = ngui.find_label(self.ui,"centre_other/animation/down_other/animation/sp_bar/lab_num")

    local NeedvigorData = ConfigManager.Get(EConfigIndex.t_church_pos_data,1)
    local cos_vigor = NeedvigorData.cos_vigor

    self.needvigor:set_text(tostring(cos_vigor))
    
    self.okbtn = ngui.find_button(self.ui,"centre_other/animation/btn3")
    self.okbtn:set_on_click(self.bindfunc['Beginbattle']);
    
    self.Yijianbtn = ngui.find_button(self.ui,"centre_other/animation/btn1")
    self.Yijianbtn:set_active(false)
    self.Yijianbtn:set_on_click(self.bindfunc['one_on_team']);

    local nStar = g_dataCenter.ChurchBot:getnstar()

    if nStar > 2 then
        self.selectrolebtn2:set_active(true)
    else
        self.selectrolebtn2:set_active(false)
    end

    ----------------------------------------
    --战胜奖励
    self.zhanshenjlicon1 = ngui.find_texture(self.ui,"centre_other/animation/down_other/animation/txt1/sp_bar1/sp_kuang1")
    self.zhanshenjllab1 = ngui.find_label(self.ui,"centre_other/animation/down_other/animation/txt1/sp_bar1/lab_num")

    self.zhanshenjlicon2 = ngui.find_texture(self.ui,"centre_other/animation/down_other/animation/txt1/sp_bar2/sp_kuang1")
    self.zhanshenjllab2 = ngui.find_label(self.ui,"centre_other/animation/down_other/animation/txt1/sp_bar2/lab_num")
    --占领奖励
    self.zhanlinjlicon1 = ngui.find_texture(self.ui,"centre_other/animation/down_other/animation/txt2/sp_bar1/sp_kuang1")
    self.zhanlinjllab1 = ngui.find_label(self.ui,"centre_other/animation/down_other/animation/txt2/sp_bar1/lab_num")

    self.zhanlinjlpanle = self.ui:get_child_by_name("centre_other/animation/down_other/animation/txt2/sp_bar2")
    self.zhanlinjlicon2 = ngui.find_texture(self.ui,"centre_other/animation/down_other/animation/txt2/sp_bar2/sp_kuang1")
    self.zhanlinjllab2 = ngui.find_label(self.ui,"centre_other/animation/down_other/animation/txt2/sp_bar2/lab_num")

    self:setUiData()
    self:computResources()
    self:setBattleUI()
    self:setOtherTeam()
    
    --初始化的时候清一下队伍数据
    self:initTeam1Data()
    self:initTeam2Data()
end

function ChurchBotlineup:setUiData()
    local findData = g_dataCenter.ChurchBot:getFindRoleData()
    local tarLvl = findData.playerLevel
    local posIndex = findData.posIndex
    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    local Lvl = ""

    if nStar == 1 then
        Lvl = "贫困区"
    elseif nStar == 2 then
        Lvl = "普通区"
    -- self.dengjilab:set_sprite_name("ld_xindiantu2")
    elseif nStar == 3 then
        Lvl = "富人区"
    -- self.dengjilab:set_sprite_name("ld_xindiantu3")
    end

    self.dengjilab:set_text(Lvl)
    
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
    
    local name = g_dataCenter.player.name
    local lvl = g_dataCenter.player.level

    self.mynamelab:set_text(name)
    self.mylvllab:set_text("等级[FDE517FF]"..tostring(lvl).."[-]")
    self.myfightlab:set_text("0")
    
    self.otherlvllab:set_text("等级[FDE517FF]"..tostring(tarLvl).."[-]")
    -- local country_name = ConfigManager.Get(EConfigIndex.t_country_info,findData.countryid).name
    -- self.quyu:set_text("区域："..tostring(country_name))
    self.otherfight:set_text(tostring(FightValue))
    self.othernamelab:set_text(findData.szPlayerName)
    self.toptitle:set_text("[A4A5E9FF]该区域已被[-][FFFFFFFF]"..findData.szPlayerName.."[-][A4A5E9FF]占领[-]")
        
end

function ChurchBotlineup:setOtherTeam()
    self.OthercardM1 = {}
    self.OthercardM2 = {}
    
    for i=1,3 do
    
        self.OthercardM1[i] = SmallCardUi:new({parent = self.otherteam1role[i],
                stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
        
        --self.cardM1[i]:SetCallback(self.bindfunc['onClickRoleCard']);
        
        self.OthercardM2[i] = SmallCardUi:new({parent = self.otherteam2role[i],
                stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
        --self.cardM2[i]:SetCallback(self.bindfunc['onClickRoleCard']);
        
    end

    local findData = g_dataCenter.ChurchBot:getFindRoleData()

    local team1= findData.vecRoleDataTeam1
    local team2 = findData.vecRoleDataTeam2

    local nStar = g_dataCenter.ChurchBot:getnstar()
    
    for i=1,3 do
        self.OthercardM1[i]:SetData(nil)
        self.OthercardM2[i]:SetData(nil)
    end
    
    if nStar > 2 then --3星可以添加2支队伍
        self:setTeam1(team1)
        self:setTeam2(team2)
    else
        self:setTeam1(team1)
    end

end

function ChurchBotlineup:setTeam1( info )
    for k,v in pairs(info) do
        local cardhum = CardHuman:new(v)
        self.OthercardM1[k]:SetData(cardhum)   
    end
end

function ChurchBotlineup:setTeam2(info)
    for k,v in pairs(info) do
        local cardhum = CardHuman:new(v)
        self.OthercardM2[k]:SetData(cardhum)   
    end
end

function ChurchBotlineup:setBattleUI()
    
    self.cardM1 = {}
    self.cardM2 = {}
    
    for i=1,3 do
    
    	self.cardM1[i] = SmallCardUi:new({parent = self.team1role[i],
    		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
    	
    	--self.cardM1[i]:SetCallback(self.bindfunc['onClickRoleCard']);
    	
    	self.cardM2[i] = SmallCardUi:new({parent = self.team2role[i],
    		    stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity }});
    	--self.cardM2[i]:SetCallback(self.bindfunc['onClickRoleCard']);
    	
    	self.cardM1[i]:SetAddIcon(false);   
    	self.cardM2[i]:SetAddIcon(false);
    end
    
    --self.isguide = true
    --如果新手引导开启 则设置队伍1
    -- if self.isguide then
    --     self:set_on_guideteam()
    -- end

end

function ChurchBotlineup:on_btn_close()
    uiManager:PopUi();
end

function ChurchBotlineup:computResources()
     --改为固定奖励

    local findData = g_dataCenter.ChurchBot:getFindRoleData()
    local nStar = g_dataCenter.ChurchBot:getnstar()
    app.log("nStar====================="..tostring(nStar))
    local church_rewardlist_data = ConfigManager.Get(EConfigIndex.t_church_pos_data,nStar);
    local rewardlistid = church_rewardlist_data.dropid
    app.log("rewardlistid=================="..tostring(rewardlistid))
    local droplist = ConfigManager.Get(EConfigIndex.t_drop_something,rewardlistid);
    app.log("droplist======================"..table.tostring(droplist))

    for k,v in pairs(droplist) do
        if k== 1 then
            self.zhanshenjllab1:set_text(tostring(v.goods_number))
            local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
            self.zhanshenjlicon1:set_texture(itemicon)
        elseif k == 2 then
            self.zhanshenjllab2:set_text(tostring(v.goods_number))
            local itemicon = ConfigManager.Get(EConfigIndex.t_item,v.goods_show_number).small_icon
            self.zhanshenjlicon2:set_texture(itemicon)
            self.zhanshenjlicon2:set_active(true)
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
    itemid1 = 0; -- 测试代码
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
    self.zhanlinjlicon1:set_texture(itemicon)
    
    local level = g_dataCenter.player.level;
    local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
    local tdata = church_pos_data[xxname]
    
    --local time = findData.keepPrayTime
    --local cannumb = tdata*time/3600
    
    self.zhanlinjllab1:set_text(tostring(tdata).."/小时")

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
        self.zhanlinjlicon2:set_texture(itemicon)
        
        local level = g_dataCenter.player.level;
        local church_pos_data = ConfigManager.Get(EConfigIndex.t_church_pray_data,level);
        local tdata = church_pos_data[xxname]
        
        --local time = findData.keepPrayTime
        --local cannumb = tdata*time/3600
        
        self.zhanlinjllab2:set_text(tostring(tdata).."/小时")

        if tdata == 0 then
            self.zhanlinjlpanle:set_active(false)
        end

        --self.kldlab:set_text("11111")
        --self.itemcount1 = math.floor(cannumb/2)
        --self.kldicon1:set_active(true)
    else
        self.zhanlinjlpanle:set_active(false)
    end
end

--初始化的时候 重置队伍
function ChurchBotlineup:initTeam1Data()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()

    local teamType = g_dataCenter.ChurchBot:getteamtype(prayindex)
    app.log("initTeam1Data......."..teamType)
    local _team =
    {
        ["teamid"] = teamType or 0,
        cards = {},
    }
    msg_team.cg_update_team_info(_team)
end

function ChurchBotlineup:initTeam2Data()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()

    local teamType = g_dataCenter.ChurchBot:getteam2type(prayindex)
    app.log("initTeam2Data......."..teamType)
    local _team =
    {
        ["teamid"] = teamType or 0,
        cards = {},
    }
    msg_team.cg_update_team_info(_team)
end

function ChurchBotlineup:computRoleIsAdd()
    
    self.currentheroid = {}
    
    local team1 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2)
    local team2 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2)
    local team3 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2)
    local team4 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2)
    
    local team5 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1)
    local team6 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1)
    local team7 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1)
    local team8 =  g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1)
    
    if team1 then
	for k,v in pairs(team1) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team2 then
	for k,v in pairs(team2) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team3 then    
	for k,v in pairs(team3) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team4 then
	for k,v in pairs(team4) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team5 then
	for k,v in pairs(team5) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team6 then
	for k,v in pairs(team6) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team7 then
	for k,v in pairs(team7) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    if team8 then
	for k,v in pairs(team8) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
end

function ChurchBotlineup:onClickRoleCard1()
    --self:computRoleIsAdd()
    self.currentheroid = {}
    local PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    
    for i=1 ,4 do
	
	for k,v in pairs (PoslistData[i].vecCardGIDTeam1)do
	    table.insert(self.currentheroid,v)
	end
	
	for k,v in pairs (PoslistData[i].vecCardGIDTeam2)do
	    table.insert(self.currentheroid,v)
	end
    end
    
    self.currenttemplineup = {}
    
    if self.frist == 1 then
	   app.log("self.frist == 1")
    else
    
	local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
	--app.log("prayindex#################")
	if prayindex == 1 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2)
	elseif prayindex == 2 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2)
	elseif prayindex == 3 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2)
	elseif prayindex == 4 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2)
	end
    end

    app.log("self.currenttemplineup1"..table.tostring(self.currenttemplineup))
    
    if self.currenttemplineup then
    
	for k,v in pairs(self.currenttemplineup) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    local data = {
        teamType = self:get_team1_type(),
        heroMaxNum = 3,
        saveCallback = self.bindfunc['on_team_change1'],
	churchPray = {team = self.currentheroid,
		      showTeamHero = false,
		      }
    }
        
    self.isTeamline = 1
    --self.frist = 0;
    uiManager:PushUi(EUI.CommonFormationUI, data)

end

function ChurchBotlineup:onClickRoleCard2()
    --self:computRoleIsAdd()
    self.currentheroid = {}
    local PoslistData = g_dataCenter.ChurchBot:getMyPoslistData()
    
    for i=1 ,4 do
	for k,v in pairs (PoslistData[i].vecCardGIDTeam1)do
	    table.insert(self.currentheroid,v)
	end
	
	for k,v in pairs (PoslistData[i].vecCardGIDTeam2)do
	    table.insert(self.currentheroid,v)
	end
    end
    
    self.currenttemplineup = {}
    
    if self.frist == 1 then
	
    else
	local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
	
	if prayindex == 1 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1)
	elseif prayindex == 2 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1)
	elseif prayindex == 3 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1)
	elseif prayindex == 4 then
	    self.currenttemplineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1)
	end
    end
    
    app.log("self.currenttemplineup2########"..table.tostring(self.currenttemplineup))
    
    if self.currenttemplineup then
    
	for k,v in pairs(self.currenttemplineup) do
	    table.insert(self.currentheroid,v)    
	end
    end
    
    local data = {
        teamType = self:get_team2_type(),
        heroMaxNum = 3,
        saveCallback = self.bindfunc['on_team_change2'],
	churchPray = {team = self.currentheroid,
		      showTeamHero = false,
		      }
    }
    
    self.isTeamline = 2
    
    uiManager:PushUi(EUI.CommonFormationUI, data)

end

function ChurchBotlineup:get_team1_type()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    local teamType = nil
    
    if prayindex == 1 then
	teamType = ENUM.ETeamType.churchpray1_1
    elseif prayindex == 2 then
	teamType = ENUM.ETeamType.churchpray2_1
    elseif prayindex == 3 then
	teamType = ENUM.ETeamType.churchpray3_1
    elseif prayindex == 4 then
	teamType = ENUM.ETeamType.churchpray4_1
    end
    
    return teamType
    
end

function ChurchBotlineup:get_team2_type()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    local teamType = nil
    
    if prayindex == 1 then
	teamType = ENUM.ETeamType.churchpray1_2
    elseif prayindex == 2 then
	teamType = ENUM.ETeamType.churchpray2_2
    elseif prayindex == 3 then
	teamType = ENUM.ETeamType.churchpray3_2
    elseif prayindex == 4 then
	teamType = ENUM.ETeamType.churchpray4_2
    end
    
    return teamType
    
end

function ChurchBotlineup:on_team_change1()
    
    --self:clearteam()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    if prayindex == 1 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_1)
    elseif prayindex == 2 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_1)
    elseif prayindex == 3 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_1)
    elseif prayindex == 4 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_1)
    end 
    
    local fightVlaue = 0

    self.team1fightvalue = 0;
    
    if self.templineup then
    
    	for k,v in pairs(self.templineup) do
    	    local cardinfo = g_dataCenter.package:find_card(1, v);
    	    --if self.isTeamline == 1 then
    	    self.cardM1[k]:SetData(cardinfo)
    	    --else
    		--self.cardM2[k]:SetData(cardinfo)
    	    self.frist = 0

            fightVlaue = fightVlaue + cardinfo:GetFightValue()
    	    --end
    	end
    end

    self.team1fightvalue = fightVlaue

    self.myfightlab:set_text(tostring(self.team1fightvalue+self.team2fightvalue))

    self.isteam1read = true;
    
end

function ChurchBotlineup:on_team_change2()
    
    --self:clearteam()
    local prayindex = g_dataCenter.ChurchBot:getmyprayIndex()
    
    if prayindex == 1 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray1_2)
    elseif prayindex == 2 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray2_2)
    elseif prayindex == 3 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray3_2)
    elseif prayindex == 4 then
	self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.churchpray4_2)
    end 
    
    --self.templineup = g_dataCenter.player:GetTeam(ENUM.ETeamType.fuzion)
    --for k,v in pairs(templineup) do
    --app.log("save callback"..table.tostring(templineup))
    local fightVlaue = 0
    self.team2fightvalue = 0;
    
    if self.templineup then
    
    	for k,v in pairs(self.templineup) do
    	    local cardinfo = g_dataCenter.package:find_card(1, v);
    	    --if self.isTeamline == 1 then
    		--self.cardM1[k]:SetData(cardinfo)
    	    --else
    	    self.cardM2[k]:SetData(cardinfo)
    	    self.frist = 0
    	    --end
            fightVlaue = fightVlaue + cardinfo:GetFightValue()
    	end
    end

    self.team2fightvalue = fightVlaue

    self.myfightlab:set_text(tostring(self.team1fightvalue+self.team2fightvalue))
    
end

function ChurchBotlineup:clearteam()
   
    if self.isTeamline == 1 then
	for i = 1,3 do
	    self.cardM1[i]:SetData()	
	end
    else
	for i = 1,3 do
	    self.cardM2[i]:SetData()	
	end
    end
     
end

function ChurchBotlineup:UpdateUi()
    
end

function ChurchBotlineup:Beginbattle()
    app.log("ChurchBotlineup:Beginbattle")
    
    app.log("templineup-==========="..table.tostring(self.templineup))

    if not self.isteam1read then
        FloatTip.Float("队伍1不能为空！" );
        return 
    end

    if self.templineup then
	--uiManager:PushUi(EUI.ChurchBotRecord)
    	if #self.templineup > 0 then
    	    g_dataCenter.ChurchBot:BeginFight()
    	    uiManager:PopUi();
    	    -- uiManager:PopUi();
    	    -- uiManager:PopUi();
            --uiManager:PopUi();
    	else
    	    app.log("请选择合适的人员")
    	end
    else
    	HintUI.SetAndShow(EHintUiType.one,
    		"请选择合适的人员".."，请重试！",
    		{str = "确定"}
    	);
    end
end

--一键上阵
function ChurchBotlineup:one_on_team()
    
    local nStar = g_dataCenter.ChurchBot:getnstar()

    if nStar > 2 then

    end
end

--引导设置队伍
function ChurchBotlineup:set_on_guideteam()
    
    -- self:clearteam()
    -- self.templineup = {}
        
    -- local team1 = g_dataCenter.package:get_hero_card_table()
    
    -- if team1 then
        
    --     for i=1,3 do
    --         if team1[i] then
    --             self.cardM1[i]:SetData(team1[i])
    --             table.insert(self.templineup,team1[i].index)
    --         end
    --     end
    -- end

    -- g_dataCenter.ChurchBot:set_guideteam(self.templineup)
    
end




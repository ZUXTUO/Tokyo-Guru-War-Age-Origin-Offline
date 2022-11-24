
CloneBattleTeamUI = Class("CloneBattleTeamUI", UiBaseClass)

local __tData = {
    playName = ENUM.InvitePlayName.CloneWar,
}
-------------------------------------外部调用-------------------------------------
function CloneBattleTeamUI:ShowNavigationBar()
    return true
end


function CloneBattleTeamUI:Init(data)
    self.CloneBattleTeamUI = data
    self.pathRes = "assetbundles/prefabs/ui/clone/ui_5203_clone_wars.assetbundle"
    UiBaseClass.Init(self, data);
end

function CloneBattleTeamUI:Restart(data)
    --app.log("Restart CloneBattleTeamUI")
    if UiBaseClass.Restart(self, data) then
	
    end
end

function CloneBattleTeamUI:InitData(data)
    UiBaseClass.InitData(self, data)
    --self.rewards = ConfigManager.Get(EConfigIndex.t_discrete,83000105).data  --三人完成奖励
    self.teamlist = g_dataCenter.CloneBattle:GetTeamInfo()--{30001100,30002100,30003100};
    --self.isRushUI = true;
    

end

function CloneBattleTeamUI:DestroyUi()
    
    for k,v in pairs(self.TeamHeadObj)do
	v:DestroyUi()
    end
    
    if self.heroHeadObj then
	self.heroHeadObj:DestroyUi()
	self.BossHead = nil;
    end
    
    --self.friendlistview:DestroyUi()
    UiBaseClass.DestroyUi(self);
    
end

function CloneBattleTeamUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_Open'] = Utility.bind_callback(self, self.on_click_Open);
    self.bindfunc['on_updata_card'] = Utility.bind_callback(self, self.on_updata_card);
    self.bindfunc['on_select_role'] = Utility.bind_callback(self, self.on_select_role);
    self.bindfunc['on_leave_team'] = Utility.bind_callback(self, self.on_leave_team);
    
    self.bindfunc['on_world_invite'] = Utility.bind_callback(self, self.on_world_invite);
    self.bindfunc['on_family_invite'] = Utility.bind_callback(self, self.on_family_invite);
    self.bindfunc['on_team_notice'] = Utility.bind_callback(self, self.on_team_notice);
    
    self.bindfunc['on_Begin_Battle'] = Utility.bind_callback(self, self.on_Begin_Battle);
    self.bindfunc['on_changerhero_updata'] = Utility.bind_callback(self, self.on_changerhero_updata);    
    self.bindfunc["handle_invite_cooling"] = Utility.bind_callback(self, self.handle_invite_cooling)
    
    self.bindfunc["on_friend_invite"] = Utility.bind_callback(self, self.on_friend_invite)
    self.bindfunc["OpenBeginFightBtn"] = Utility.bind_callback(self, self.OpenBeginFightBtn)
    
end


--注册消息分发回调函数
function CloneBattleTeamUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_clone_fight.gc_update_team, self.bindfunc["on_updata_card"])
    PublicFunc.msg_regist(msg_clone_fight.gc_change_hero, self.bindfunc["on_changerhero_updata"])
    PublicFunc.msg_regist("msg_invite_colling_allback_" .. __tData.playName, self.bindfunc['handle_invite_cooling']);
end

--注销消息分发回调函数
function CloneBattleTeamUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_clone_fight.gc_update_team, self.bindfunc["on_updata_card"])
    PublicFunc.msg_unregist(msg_clone_fight.gc_change_hero, self.bindfunc["on_changerhero_updata"])
    PublicFunc.msg_regist("msg_invite_colling_allback_" .. __tData.playName, self.bindfunc['handle_invite_cooling']);
end


--初始化UI
function CloneBattleTeamUI:InitUI(asset_obj)
    
    --app.log("InitUI CloneBattleTeamUI")
    
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('CloneBattleTeamUI');
        
    self.finishuidown = self.ui:get_child_by_name("down_other/animation/cont2");  --完成挑战
    self.finishuidown:set_active(false)
    self.unfinishuidown = self.ui:get_child_by_name("down_other/animation/cont1");--未完成挑战
    
    self.isCanQuitJoin = ngui.find_button(self.ui,"down_other/animation/cont1/yeka") ;
    self.isCanQuitJoin:set_on_click(self.bindfunc['on_click_Open']);
    self.isCanQuitJoinTxt = ngui.find_label(self.ui,"down_other/animation/cont1/lab_forbid")
    self.isCanQuitJoinPic = ngui.find_sprite(self.ui,"down_other/animation/cont1/yeka/sp_cancel") ;
    
    self.beginBattleBtn = ngui.find_button(self.ui,"down_other/animation/cont1/btn_get")
    self.beginBattleBtn:set_on_click(self.bindfunc['on_Begin_Battle']);
    
    self.leaveBtn = ngui.find_button(self.ui,"down_other/animation/cont1/btn_leave")
    self.leaveBtn:set_on_click(self.bindfunc['on_leave_team'])
    
    self.worldinviteBtn = ngui.find_button(self.ui,"down_other/animation/cont1/btn_ask1")
    self.worldinviteBtn:set_on_click(self.bindfunc['on_world_invite'])
    
    self.familyinviteBtn = ngui.find_button(self.ui,"down_other/animation/cont1/btn_ask3")
    self.familyinviteBtn:set_on_click(self.bindfunc['on_family_invite'])
    
    self.familyinviteBtn2 = ngui.find_button(self.ui,"down_other/animation/cont2/btn_ask")
    self.familyinviteBtn2:set_on_click(self.bindfunc['on_team_notice'])
    self.familyinviteLab2 = ngui.find_label(self.ui,"down_other/animation/cont2/btn_ask/animation/lab")
    
    
    self.friendinviteBtn = ngui.find_button(self.ui,"down_other/animation/cont1/btn_ask2")
    self.friendinviteBtn:set_on_click(self.bindfunc['on_friend_invite'])
    
    --英雄碎片头像
    self.heroHead = self.ui:get_child_by_name("center_other/animation/content/left/cont_big_item")
    self.heroHeadObj = UiBigCard:new({parent=self.heroHead})
    --self.heroname = ngui.find_label(self.ui,"center_other/animation/content/left/sp_title/lab")
    
    self.TheroHeadList = {};
    
    local isHaveGuild = g_dataCenter.guild
    if isHaveGuild.myGuildId ~= nil and isHaveGuild.myGuildId ~= "0" then
    	self.familyinviteBtn:set_active(true)
    else
	self.familyinviteBtn:set_active(false)
    end
       
    --队伍头像
    self.TeamHead ={};
    self.TeamHeadObj = {};
    --self.teamname = {};
    --self.teamjd = {};
    --self.TeamHeadTexture = {};
    --self.TeamHeadStar = {};
    self.TeamHeadSel = {};    
    
    for i=1,3 do
	--self.TeamHead[i] = {};
	self.TeamHead[i] = self.ui:get_child_by_name("center_other/animation/content/right/cont_big_item"..i)
	self.TeamHeadObj[i] = UiBigCard:new({parent=self.TeamHead[i]})
	--self.TeamHeadTexture[i] = ngui.find_texture(self.ui,"center_other/animation/left_content/down/sp_bk"..i.."/texture_huamn")  --人物贴图
	--self.TeamHeadTexture[i]:set_active(false)
	--self.teamname[i] = {};
	--self.TeamHeadStar[i] = self.ui:get_child_by_name("center_other/animation/left_content/down/sp_bk"..i.."/cont_star")    --星级
	--self.TeamHeadStar[i]:set_active(false)
	self.TeamHeadSel[i] = ngui.find_button(self.ui,"center_other/animation/content/right/cont_big_item"..i.."/btn")    --选人按钮
	self.TeamHeadSel[i]:set_active(false)
	--self.TeamHeadSel[i] = ngui.find_button(self.ui,"center_other/animation/left_content/down/sp_bk"..i.."/btn")    --选人按钮
	--self.TeamHeadSel[i]:set_active(false)
	
	--self.teamname[i] = ngui.find_label(self.ui,"center_other/animation/left_content/down/sp_bk"..i.."/lab_name")
	--self.teamjd[i] = ngui.find_label(self.ui,"center_other/animation/left_content/down/sp_bk"..i.."/lab_num")
	--self.teamjd[i]:set_text("")
    end
        
    self.rewarditem1 = self.ui:get_child_by_name("down_other/animation/sp_di_tiao/new_small_card_item1")
    self.rewarditem2 = self.ui:get_child_by_name("down_other/animation/sp_di_tiao/new_small_card_item2")
    
    self.rewarditemNum1 = ngui.find_label(self.ui,"down_other/animation/sp_di_tiao/lab_num1")
    self.rewarditemNum2 = ngui.find_label(self.ui,"down_other/animation/sp_di_tiao/lab_num2")
    self.rewardlab = ngui.find_label(self.ui,"down_other/animation/sp_di_tiao/lab")
        
    --local friendlist = self.ui:get_child_by_name("center_other/animation/right_content")
    --end
    --self.friendlistview = CommonFriendListUI:new( {parent = friendlist, playName = ENUM.InvitePlayName.CloneWar,})
    
    self:setHeroHead()
    self:setTeamHead()
    self:set_RewardsData()
    self:setQuitJionBtn()
    self:setQuitJionBtnisShow()
    self:isFininshWar()
   
    self.spWorldInvite = ngui.find_sprite(self.ui, "down_other/animation/cont1/btn_ask1/animation/sp")
    self.lblWorldInvite = ngui.find_label(self.ui, "down_other/animation/cont1/btn_ask1/animation/lab")

    self.spGuildInvite = ngui.find_sprite(self.ui, "down_other/animation/cont1/btn_ask3/animation/sp")
    self.lblGuildInvite = ngui.find_sprite(self.ui, "down_other/animation/cont1/btn_ask3/animation/lab")

    local btnGuildInvite = ngui.find_button(self.ui, "down_other/animation/cont2/btn_ask")
    btnGuildInvite:set_active(g_dataCenter.guild:IsJoinedGuild())

    --初始化
    self:handle_invite_cooling({source == ENUM.InviteSource.World})
    self:handle_invite_cooling({source == ENUM.InviteSource.Guild})
end

function CloneBattleTeamUI:setQuitJionBtn()
    local isOpen = g_dataCenter.CloneBattle:GetQuickJoin()
    --app.log("isOpen ##################"..tostring(isOpen))
    if isOpen == 0 then
	self.isCanQuitJoinPic:set_active(false)
    else
	self.isCanQuitJoinPic:set_active(true)
    end 
end

function CloneBattleTeamUI:setQuitJionBtnisShow()
    local TeamInfo =  g_dataCenter.CloneBattle:GetTeamInfo()
    local data = TeamInfo.members
    
    local numb = 0;
    for k,v in pairs(data) do
	if g_dataCenter.player.playerid == v.playerid then
	    numb = k;
	end
    end
    if numb == 1 then
	self.isCanQuitJoin:set_active(true)
	self.isCanQuitJoinTxt:set_active(true)
    else
	self.isCanQuitJoin:set_active(false)
	self.isCanQuitJoinTxt:set_active(false)
    end
end

function CloneBattleTeamUI:isFininshWar()
    local TeamInfo =  g_dataCenter.CloneBattle:GetTeamInfo()
    local data = TeamInfo.members
    
    --app.log("data#######"..table.tostring(data))
    
    local numb = 0;
    local playernumb = 0;
    
    for k,v in pairs(data) do
	if g_dataCenter.player.playerid == v.playerid then
	    numb = v.finishTimes;
	    --app.log("isFininshWar number#####################"..tostring(numb))
	end
	
	if v.playerid ~= "" then
	    playernumb = playernumb + 1
	end
	
    end
    
    if numb == 3 then
	self.finishuidown:set_active(true)
	self.unfinishuidown:set_active(false)
    else
	self.finishuidown:set_active(false)
	self.unfinishuidown:set_active(true)
    end
    
    if playernumb > 1 then
	--app.log("11111111111111111111111")
	self.familyinviteBtn2:set_enable(true)
	self.familyinviteBtn2:set_sprite_names("ty_anniu3")
	self.familyinviteLab2:set_effect_color(174/255,65/255,40/255,255/255)
    else
	--app.log("22222222222222222222222")
	self.familyinviteBtn2:set_enable(false)
	self.familyinviteBtn2:set_sprite_names("ty_anniu5")
	self.familyinviteLab2:set_effect_color(139/255,139/255,139/255,255/255)
    end
end

function CloneBattleTeamUI:on_click_Open(t)
    --app.log("name is #########"..name.."  value is ################"..tostring(value))
    local isOpen = g_dataCenter.CloneBattle:GetQuickJoin()
    --app.log("isOpen is #########"..tostring(isOpen))
    
    if isOpen == 0 then
	msg_clone_fight.cg_allow_quick_join( 1 )
	self.isCanQuitJoinPic:set_active(true)
    else
	msg_clone_fight.cg_allow_quick_join( 0 )
	self.isCanQuitJoinPic:set_active(false)
    end
--    if name == "yeka" and value then
--	msg_clone_fight.cg_allow_quick_join( true )
--    else
--	msg_clone_fight.cg_allow_quick_join( false )
--    end
end

function CloneBattleTeamUI:on_Begin_Battle()
    --app.log( "#on_Begin_Battle####################################")
    self.beginBattleBtn:set_active(false)
    
    local data = g_dataCenter.CloneBattle:GetTeamInfo()
    
    --app.log("################data ###"..table.tostring(data.members))
    local number = 0;
    for k,v in pairs(data.members)do
	if v.playerid ~= "" then
	    number = number + 1
	end
    end
    
    local function onConfirm()
	GLoading.Show(GLoading.EType.msg)
	msg_clone_fight.cg_begin_fight()
    end
    
    local function onCan()
	self.beginBattleBtn:set_active(true)
    end
    
    if number == 3 then
	GLoading.Show(GLoading.EType.msg)
	msg_clone_fight.cg_begin_fight()
    else
	HintUI.SetAndShowNew(EHintUiType.two,"提示","人数不足，是否前往挑战?",nil,{str="确定",func = onConfirm},{str = "取消",func = onCan})
    end
    
    

    --self.anniutime = timer.create(self.bindfunc["OpenBeginFightBtn"],1000,1)
    --self:DestroyUi()
    --uiManager:PopUi()
end

function CloneBattleTeamUI:OpenBeginFightBtn()

end

function CloneBattleTeamUI:UpdateUi()
    self:setHeroHead()
    self:setTeamHead()
    self:set_RewardsData()
end

function CloneBattleTeamUI:setHeroHead()
    local data = g_dataCenter.CloneBattle:GetTeamInfo()
    local role = PublicFunc.IdToConfig(data.heroid)
    --self.heroname:set_text(role.name)
    local role = CardHuman:new({number=data.heroid, isNotCalProperty = true});
    
    self.heroHeadObj:SetData(role)
    self.heroHeadObj:SetInfoType(3)
    self.heroHeadObj:NeedShowCardName(false)
    self.heroHeadObj:SetPlayerName(role.name)
    --local texture = ngui.find_texture(self.heroHead,"texture_huamn")
    --texture:set_texture(role.icon300)
--    
--    if self.BossHead then
--	self.BossHead:SetData(role)
--    else
--	self.BossHead = SmallCardUi:new({parent=self.heroHead ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
--	self.BossHead:SetParam(1);
--    end
end

--function CloneBattleTeamUI:setTeamHead()
--    
--    self.teamlist = g_dataCenter.CloneBattle:GetTeamInfo()
--    local data = self.teamlist.members
--    --app.log("data ##################"..table.tostring(data))
--    for k,v in pairs(data) do
--	
--	local id = v.playerid
--	local dataid = v.roleCard.dataid
--	--app.log("dataid ##################"..tostring(dataid))
--	--if id then
--	local cardinfo = g_dataCenter.package:find_card(1, dataid);
--	--app.log("###########"..tostring(cardinfo.rarity))
--	--local textureBK = ngui.find_sprite(self.TeamHead[k],"sp_huamn_bk")
--	
--	if id ~= "" then
--	    if cardinfo then
--		--textureBK:set_active(false)
--		--app.log("11111111111111111111111111111111111")
--		--self.teamname[k]:set_text(v.name)
--		--self.teamjd[k]:set_text("今日完成第"..tostring(v.finishTimes).."场")
--		--self.TeamHeadTexture[k]:set_active(true)
--		--self.TeamHeadTexture[k]:set_texture(cardinfo.icon300)
--		self.TeamHeadObj[k]:SetData(cardinfo)
--		self.TeamHeadObj[k]:SetInfoType(2)
--		self.TeamHeadObj[k]:SetFightPro("今日完成第"..tostring(v.finishTimes).."场")
--		self.TeamHeadObj[k]:SetPlayerName(v.name)
--		if k == 1 then
--		    self.TeamHeadObj[k]:SetTeamPos(0)
--		end
--		--self.TheroHeadList[k] = self.TeamHeadTexture[k];
--			
--		--if v.finishTimes < 3 then
--		--self.TeamHeadSel[k]:set_active(true)
--		--self.TeamHeadSel[k]:set_event_value(cardinfo.index,0)
--		--self.TeamHeadSel[k]:set_on_click(self.bindfunc['on_select_role'])
--		--self.TheroHeadList[k]:SetCallback(self.bindfunc['on_select_role'])
--		--end
--		--self.TeamHeadTexture[k]:set_active(true)
--		--self.TeamHeadStar[k]:set_active(true)
--		--self:setStar(self.TeamHeadStar[k],cardinfo.rarity)
--		
--		if id == g_dataCenter.player.playerid then
--		    --app.log("22222222222222222222222222222222222")
--		    self.myitem = {};
--		--    self.myitemstar = {};
--		--    self.myitemsel = {};
--		    self.myitem[id] = self.TeamHeadObj[k];
--		--    self.myitemstar[id] = self.TeamHeadStar[k];
--		--    self.myitemsel[id] = self.TeamHeadSel[k];
--		    if v.v.finishTimes < 3 then
--			self.TeamHeadSel[k]:set_active(true)
--			self.TeamHeadSel[k]:set_on_click(self.bindfunc['on_select_role'])
--			self.TeamHeadSel[k]:set_event_value(cardinfo.index,0)
--		    end
--		
--		    if v.finishTimes == 3 then
--			self.TeamHeadSel[k]:set_active(false)
--		    end
--		    --    
--		    if v.finishTimes > 0 then
--			self.leaveBtn:set_enable(false)
--			self.leaveBtn:set_sprite_names("anniu14")
--			self.leaveBtn:set_active(false)
--		    else
--			self.leaveBtn:set_enable(true)
--			self.leaveBtn:set_sprite_names("anniu12")
--			self.leaveBtn:set_active(true)
--		    end
--		    
--		    
--		end
--	--    else
--	--	if id ~= "" then
--	--	    
--	--	    if id ~= g_dataCenter.player.playerid then
--			--app.log("444444444444444444444444444444"..table.tostring(v))
--			--textureBK:set_active(false)
--			--self.teamname[k]:set_text(v.name)
--			--local role = CardHuman:new(v.roleCard);
--			--self.TeamHeadSel[k]:set_active(true)
--		    --    if self.TheroHeadList[k] then
--		    --	self.TheroHeadList[k]:SetData(role)
--		    --	--app.log("333333333333333333333333333333333")
--		    --    else
--		    --	--app.log("444444444444444444444444")
--		    --	local TheroHead = SmallCardUi:new({parent=self.TeamHead[k] ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
--		    --	self.TheroHeadList[k] = TheroHead;
--		    --	TheroHead:SetParam(1);
--		    --    end
--		    
--			--self.TeamHeadTexture[k]:set_active(true)
--			--app.log("############"..role.icon300)
--		--	self.TeamHeadTexture[k]:set_texture(role.icon300)
--		--	self.TeamHeadStar[k]:set_active(true)
--		--	self:setStar(self.TeamHeadStar[k],role.rarity)
--		--	self.TeamHeadTexture[k]:set_active(true)
--		--	self.teamjd[k]:set_text("今日完成第"..tostring(v.finishTimes).."场")
--		--    end
--		--else
--		    --if self.TeamHeadTexture[k] then
--			--self.TeamHeadTexture[k]:set_texture("")
--		    --self.TeamHeadTexture[k]:set_active(false)
--		    --textureBK:set_active(true)
--		    --end
--		    --self.teamname[k]:set_text("")
--		    --self.teamjd[k]:set_text("")
--	--	end
--	--    end
--	--else
--	    --if self.TeamHeadTexture[k] then
--	    --self.TeamHeadTexture[k]:set_active(false)
--	    --textureBK:set_active(true)
--	    --self.TeamHeadSel[k]:set_active(false)
--	    --self.TeamHeadStar[k]:set_active(false)
--	    --end
--	    --self.teamname[k]:set_text("")
--	    --self.teamjd[k]:set_text("")
--	    end
--	end
--    end
--end

function CloneBattleTeamUI:setFininshNumberText(num)
    local text = ""
    
    if num == 0 then
	text = "[ff0000]未进行战斗[-]"	
    elseif num > 0 and num < 3 then
	text = "[ffa127]今日完成第"..tostring(num).."场[-]"	
    elseif num == 3 then
	text = "[7acf0f]已完成战斗[-]"	
    end
    
    return text 
end

function CloneBattleTeamUI:setTeamHead()
    
    self.teamlist = g_dataCenter.CloneBattle:GetTeamInfo()
    local data = self.teamlist.members
    --app.log("data ##################"..table.tostring(data))
    for i=1,3 do
	--app.log("data ##################"..table.tostring(data[i]))
	if data[i] then
	    local id = data[i].playerid
	    local dataid = data[i].roleCard.dataid
	    --app.log("dataid ##################"..tostring(dataid))
	    --if id then
	    local cardinfo = g_dataCenter.package:find_card(1, dataid);
	    --app.log("###########"..tostring(cardinfo.rarity))
	    --local textureBK = ngui.find_sprite(self.TeamHead[k],"sp_huamn_bk")
	    
	    if id ~= nil then
		if cardinfo then
		    --textureBK:set_active(false)
		    --app.log("11111111111111111111111111111111111")
		    
		    self.TeamHeadObj[i]:SetData(cardinfo)
		    self.TeamHeadObj[i]:SetInfoType(2)
		    local txt = self:setFininshNumberText(data[i].finishTimes)
		    self.TeamHeadObj[i]:SetFightPro(txt)
		    self.TeamHeadObj[i]:SetPlayerName(data[i].name)
		    
		    --self.teamname[k]:set_text(v.name)
		    --self.teamjd[k]:set_text("今日完成第"..tostring(v.finishTimes).."场")
		    --self.TeamHeadTexture[k]:set_active(true)
		    --self.TeamHeadTexture[k]:set_texture(cardinfo.icon300)
		    
		    if i == 1 then
			self.TeamHeadObj[i]:SetTeamPos(0)
		    end
		
		    self.TheroHeadList[i] = self.TeamHeadObj[i]--self.TeamHeadTexture[k];
			    
		    --if v.finishTimes < 3 then
		    self.TeamHeadSel[i]:set_active(true)
		    self.TeamHeadSel[i]:set_event_value(cardinfo.index,0)
		    self.TeamHeadSel[i]:set_on_click(self.bindfunc['on_select_role'])
		    --self.TheroHeadList[k]:SetCallback(self.bindfunc['on_select_role'])
		    --end
		    --self.TeamHeadTexture[k]:set_active(true)
		    --self.TeamHeadStar[k]:set_active(true)
		    --self:setStar(self.TeamHeadStar[k],cardinfo.rarity)
		    
		    if id == g_dataCenter.player.playerid then
			--app.log("22222222222222222222222222222222222")
			self.myitem = {};
			--self.myitemstar = {};
			self.myitemsel = {};
			self.myitem[id] = self.TheroHeadList[i];
			--self.myitemstar[id] = self.TeamHeadStar[k];
			self.myitemsel[id] = self.TeamHeadSel[i];
			
			if data[i].finishTimes == 3 then
			    self.TeamHeadSel[i]:set_active(false)
			end
			
			if data[i].finishTimes > 0 then
			    --self.leaveBtn:set_enable(false)
			    --self.leaveBtn:set_sprite_names("anniu14")
			    self.leaveBtn:set_active(false)
			else
			    --self.leaveBtn:set_enable(true)
			    --self.leaveBtn:set_sprite_names("anniu12")
			    self.leaveBtn:set_active(true)
			end
			
			
		    else
			
			--app.log("1111111111111111111111111111")
		    end
		else
		    if id ~= nil then
			
			if id ~= g_dataCenter.player.playerid then
			    --app.log("444444444444444444444444444444"..table.tostring(v))
			    --textureBK:set_active(false)
			    --self.teamname[k]:set_text(v.name)
			    local role = CardHuman:new(data[i].roleCard);
			    --self.TeamHeadSel[k]:set_active(true)
			--    if self.TheroHeadList[k] then
			--	self.TheroHeadList[k]:SetData(role)
			--	--app.log("333333333333333333333333333333333")
			--    else
			--	--app.log("444444444444444444444444")
			--	local TheroHead = SmallCardUi:new({parent=self.TeamHead[k] ,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
			--	self.TheroHeadList[k] = TheroHead;
			--	TheroHead:SetParam(1);
			--    end
			    
			    self.TeamHeadObj[i]:SetData(role)
			    self.TeamHeadObj[i]:SetInfoType(2)
			    local txt = self:setFininshNumberText(data[i].finishTimes)
			    self.TeamHeadObj[i]:SetFightPro(txt)
			    self.TeamHeadObj[i]:SetPlayerName(data[i].name)
			    
			    if i == 1 then
				self.TeamHeadObj[i]:SetTeamPos(0)
			    end
			    
			    --self.TeamHeadTexture[k]:set_active(true)
			    --app.log("############"..role.icon300)
			    --self.TeamHeadTexture[k]:set_texture(role.icon300)
			    --self.TeamHeadStar[k]:set_active(true)
			    --self:setStar(self.TeamHeadStar[k],role.rarity)
			    --self.TeamHeadTexture[k]:set_active(true)
			    --self.teamjd[k]:set_text("今日完成第"..tostring(v.finishTimes).."场")
			end
		    else
			--if self.TeamHeadTexture[k] then
			    --self.TeamHeadTexture[k]:set_texture("")
			--self.TeamHeadTexture[k]:set_active(false)
			--textureBK:set_active(true)
			--end
			--self.teamname[k]:set_text("")
			--self.teamjd[k]:set_text("")
			--app.log("333333333333333333333333")
			self.TeamHeadObj[i]:SetData()
			self.TeamHeadObj[i]:SetShowAddButton(false)
		    end
		end
	    else
		--if self.TeamHeadTexture[k] then
		--self.TeamHeadTexture[k]:set_active(false)
		--textureBK:set_active(true)
		--self.TeamHeadSel[k]:set_active(false)
		--self.TeamHeadStar[k]:set_active(false)
		--end
		--self.teamname[k]:set_text("")
		--self.teamjd[k]:set_text("")
		--app.log("22222222222222222222222222")
		self.TeamHeadObj[i]:SetData()
		self.TeamHeadObj[i]:SetShowAddButton(false)
	    end
	
	else
	    self.TeamHeadObj[i]:SetData()
	    self.TeamHeadObj[i]:SetShowAddButton(false)
	end
    end
end

function CloneBattleTeamUI:setStar(obj,num)
    local starlist = {}
    for i=1,7 do
	starlist[i] = ngui.find_sprite(obj,"sp_star_di"..i)
	if i<= num then
	    starlist[i]:set_active(true)
	else
	    starlist[i]:set_active(false)
	end
    end

end

--设置奖励
function CloneBattleTeamUI:set_RewardsData()
    
    local teaminfo = g_dataCenter.CloneBattle:GetTeamInfo()
    local data = teaminfo.members
    
    --app.log("#############data ############"..table.tostring(data))    
    local hero = PublicFunc.IdToConfig(teaminfo.heroid)

    --app.log("###########hero ################"..table.tostring(hero))
    local herosoulid = hero.hero_soul_item_id
    
    local number = 0;
    
    local text = ""
    
    for k,v in pairs(data)do
	if v.playerid ~= "" then
	    if v.finishTimes == 3 then
	       number =  number + 1
	    end
	end
    end
    
    local herosoul = nil;
    local rewards = nil;
    
    if number == 0 or number == 1 then --(两个人)
	herosoul =ConfigManager.Get(EConfigIndex.t_discrete,83000104).data
	rewards = ConfigManager.Get(EConfigIndex.t_discrete,83000105).data
	text = "队伍中[00ff84]2[-]人完成讨伐，将额外获得奖励"
	
    elseif number == 2 or number == 3 then		--（三个人）
	herosoul =ConfigManager.Get(EConfigIndex.t_discrete,83000112).data
	rewards = ConfigManager.Get(EConfigIndex.t_discrete,83000113).data
	text = "队伍中[00ff84]3[-]人完成讨伐，将额外获得奖励"
    end
    
    --self.rewards = ConfigManager.Get(EConfigIndex.t_discrete,83000105).data  --三人完成奖励
    self.rewardlab:set_text(text)
    
    local card_prop = CardProp:new({number = 3,count = tonumber(rewards)});
    self.ui_small_item1 = UiSmallItem:new({parent = self.rewarditem1, cardInfo = card_prop});
    self.ui_small_item1:SetLabNum(false);
    self.rewarditemNum1:set_text("x"..tostring(rewards));
    
    local card_soul = CardProp:new({number = herosoulid ,count = tonumber(herosoul)});
    self.ui_small_item2 = UiSmallItem:new({parent = self.rewarditem2, cardInfo = card_soul});
    self.ui_small_item2:SetLabNum(false);
    self.rewarditemNum2:set_text("x"..tostring(herosoul))
end

function CloneBattleTeamUI:on_changerhero_updata( roleDataId )
    --local dataid = g_dataCenter.CloneBattle:getroleDataid()
    --app.log("on_changerhero_updata"..tostring(roleDataId))
    local id = g_dataCenter.player.playerid
    if self.myitem[id] then
	--app.log("myitem #########################")
	local cardinfo = g_dataCenter.package:find_card(1, roleDataId);
	--local TheroHead = SmallCardUi:new({parent=self.myitem[id] ,info=cardinfo,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
	--TheroHead:SetParam(k);
	--TheroHead:SetCallback(self.bindfunc['on_select_role'])
	--self.myitem[id]:SetData(cardinfo)
	self.myitem[id]:SetData(cardinfo)
	--self:setStar(self.myitemstar[id],cardinfo.rarity)
	self.myitemsel[id]:set_event_value(cardinfo.index,0)
    end
end

function CloneBattleTeamUI:on_select_role(t)
    local data = {
        teamType = ENUM.ETeamType.clone_fight,
        heroMaxNum = 1,
        initList = {t.string_value}
    }
    uiManager:PushUi(EUI.CommonFormationUI, data)
end

function CloneBattleTeamUI:on_updata_card()
    self.teamlist = g_dataCenter.CloneBattle:GetTeamInfo()
    self:setTeamHead()
   --msg_clone_fight.cg_get_team_info()
end

function CloneBattleTeamUI:on_leave_team()
        
    local function onConfirm()
        msg_clone_fight.cg_exit_team()
	--self:DestroyUi()
	--uiManager:PopUi()
    end
    
    local cout = self:IsManyuan()
    
    if cout == 1 then
	HintUI.SetAndShowNew(EHintUiType.two,"提示","队伍内没有其他玩家，如退出队伍，该队伍立刻解散，是否退出？",nil,{str="确定",func = onConfirm},{str = "取消"})
    else
	HintUI.SetAndShowNew(EHintUiType.two,"提示","确定退出挑战队伍吗？",nil,{str="确定",func = onConfirm},{str = "取消"})
    end  
    
end

function CloneBattleTeamUI:IsManyuan()
    
    local cout = 0;
    
    for k,v in pairs( self.teamlist.members ) do
    	local id = v.playerid
	if id ~= "" then
	    cout = cout + 1
	end 
    end
    
    return cout
end

function CloneBattleTeamUI:on_world_invite()
    
    --self.teamlist = g_dataCenter.CloneBattle:GetTeamInfo()
    local num = self:IsManyuan()
    --app.log("num ##############"..tostring(num))
    
    if num < 3 then
	__tData.source = ENUM.InviteSource.World
	g_dataCenter.invite:SendInvite(__tData)
    else
	FloatTip.Float( "队伍已经满员" );
    end
end

function CloneBattleTeamUI:on_team_notice()
    nmsg_clone_fight.cg_notice_partener_finish_challenge( Socket.socketServer )
end

function CloneBattleTeamUI:on_family_invite()
    local num = self:IsManyuan()
    --app.log("num ##############"..tostring(num))
    
    if num < 3 then
	__tData.source = ENUM.InviteSource.Guild
	g_dataCenter.invite:SendInvite(__tData)
    else
	FloatTip.Float( "队伍已经满员" );
    end
end

--[[好友邀请]]
function CloneBattleTeamUI:on_friend_invite()
    CommonFriendListWindowUI.Start(ENUM.InvitePlayName.CloneWar)
end
    
--[[邀请冷却]]
function CloneBattleTeamUI:handle_invite_cooling(callbackData)
    if callbackData.source == ENUM.InviteSource.World then
        __tData.source = callbackData.source
        if g_dataCenter.invite:CanInvite(__tData) then 
            PublicFunc.SetUISpriteWhite(self.spWorldInvite)
            PublicFunc.SetUILabelEffectRed(self.lblWorldInvite)
        else
            PublicFunc.SetUISpriteGray(self.spWorldInvite)
            PublicFunc.SetUILabelEffectGray(self.lblWorldInvite)
        end
    elseif callbackData.source == ENUM.InviteSource.Guild then
        __tData.source = callbackData.source
        if g_dataCenter.invite:CanInvite(__tData) then 
            PublicFunc.SetUISpriteWhite(self.spGuildInvite)
            PublicFunc.SetUILabelEffectRed(self.lblGuildInvite)
        else
            PublicFunc.SetUISpriteGray(self.spGuildInvite)
            PublicFunc.SetUILabelEffectGray(self.lblGuildInvite)
        end
    end
end


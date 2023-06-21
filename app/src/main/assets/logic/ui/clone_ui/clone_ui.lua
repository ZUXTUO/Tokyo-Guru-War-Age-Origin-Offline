
CloneBattleUI = Class("CloneBattleUI", UiBaseClass)

-------------------------------------外部调用-------------------------------------
function CloneBattleUI:ShowNavigationBar()
    return true
end


function CloneBattleUI:Init(data)
    self.CloneBattleUI = data
    self.pathRes = "assetbundles/prefabs/ui/clone/ui_5202_clone_wars.assetbundle"
    UiBaseClass.Init(self, data);
end

function CloneBattleUI:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function CloneBattleUI:InitData(data)
    
    self.choseitemindex = 1;
    
    self.herolist = g_dataCenter.CloneBattle:GetHerolist() 
    --app.log("herolist############################"..table.tostring(self.herolist))
    --self.herolist = {30001100,30002100,30003100,30004000,30005100,30006200}
    UiBaseClass.InitData(self, data)
    
end

function EquipPackageUI:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function CloneBattleUI:DestroyUi()
    
    --self.hero3D:set_active(false)
    --self.hero3D = nil;
    self.choseitemindex = 1;
    Show3d.Destroy()
    UiBaseClass.DestroyUi(self);
    
end

function CloneBattleUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_CreateTeam'] = Utility.bind_callback(self, self.on_click_CreateTeam);
    self.bindfunc['on_click_QuitJoin'] = Utility.bind_callback(self, self.on_click_QuitJoin);
    self.bindfunc['on_click_Select'] = Utility.bind_callback(self, self.on_click_Select);
    self.bindfunc['on_click_Select_hero'] = Utility.bind_callback(self, self.on_click_Select_hero);
    self.bindfunc['on_click_SelectSkill'] = Utility.bind_callback(self, self.on_click_SelectSkill);
    
end


--注册消息分发回调函数
function CloneBattleUI:MsgRegist()
    UiBaseClass.MsgRegist(self); 
end

--注销消息分发回调函数
function CloneBattleUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end


--初始化UI
function CloneBattleUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('CloneBattleUI');
    
    self.createTeamBtn = ngui.find_button(self.ui,"center_other/animation/cont_right/sp_bk/btn_gread")
    self.createTeamBtnLab = ngui.find_label(self.ui,"center_other/animation/cont_right/sp_bk/btn_gread/animation/lab")
    self.createTeamBtn:set_on_click(self.bindfunc['on_click_CreateTeam']);
    self.fastjoinBtn = ngui.find_button(self.ui,"center_other/animation/cont_right/sp_bk/btn_join")
    self.fastjoinBtnLab = ngui.find_label(self.ui,"center_other/animation/cont_right/sp_bk/btn_join/animation/lab")
    self.fastjoinBtn:set_on_click(self.bindfunc['on_click_QuitJoin']);
    self.hero3D = ngui.find_sprite(self.ui,"center_other/animation/cont_left/sp_human")
    
--    self.skillicon ={};
--    self.skilliconBtn = {};
--    for i = 1 ,3 do
--	self.skillicon[i] = {};
--	self.skilliconBtn[i] = {};
--	self.skilliconBtn[i] = ngui.find_button(self.ui,"center_other/animation/cont_left/content_skill/btn"..i)
--	self.skillicon[i] = ngui.find_texture(self.ui,"center_other/animation/cont_left/content_skill/btn"..i.."/skill")
--	self.skilliconBtn[i]:set_on_ngui_press(self.bindfunc['on_click_SelectSkill'])
--	local suo = ngui.find_sprite(self.ui,"center_other/animation/cont_left/content_skill/btn"..i.."/sp_lock")
--	suo:set_active(false)
--    end
    
    self.yeka = {};
    self.heroitem = {};
    self.listRole = {};
    self.texture = {};
    self.namelist = {};
    for i=1,#self.herolist do
	self.yeka[i] = {};
	self.yeka[i] = ngui.find_button(self.ui,"center_other/animation/cont_right/yeka/yeka"..i) ;
	self.yeka[i]:set_on_click(self.bindfunc['on_click_Select']);
	app.log("self.herolist[i]"..tostring(self.herolist[i]))
	self.yeka[i]:set_event_value(tostring(i),self.herolist[i])
	self.heroitem[i] = {};
	self.heroitem[i] = self.ui:get_child_by_name("center_other/animation/cont_right/yeka/yeka"..i.."/new_small_card_item");
	self.texture[i] = {};
	self.texture[i] = ngui.find_sprite(self.ui,"center_other/animation/cont_right/yeka/yeka"..i.."/sp_gou");
	
	if i > 1 then
	    self.texture[i]:set_active(false)
    
	else
	    self.choseitem = self.texture[i]
	end
	
	local head_obj = self.heroitem[i]
	
	--local role_id = ConfigManager.Get(EConfigIndex.t_player_select_role, self.herolist[i]).role_id;  
	local role = CardHuman:new({number=self.herolist[i], isNotCalProperty = true});
	self.listRole[i] = {};
	self.listRole[i] = SmallCardUi:new({parent=head_obj,info=role,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Battle}});
	self.listRole[i]:SetParam(i);
	self.listRole[i]:SetCallback(self.bindfunc['on_click_Select_hero']);
	
	self.namelist[i] = {};
	self.namelist[i] = ngui.find_label(self.ui,"center_other/animation/cont_right/yeka/yeka"..i.."/lab_name") ;
	
	local role = PublicFunc.IdToConfig(self.herolist[i])
	
	self.namelist[i]:set_text(role.name)
    end
    
    self.uiplayername = ngui.find_label(self.ui,"center_other/animation/cont_left/sp_bk1/lab_name")
    
    self:bound3d()
    
    self:setSkillData(self.herolist[1])
    
    local role =  PublicFunc.IdToConfig(self.herolist[1])
    self.uiplayername:set_text(role.name)
    
    local flag = self:haveHero(self.herolist[1])
    
    --app.log("flag init"..flag)
    
    if flag ~= "" then
	--self.fastjoinBtn:set_enable(true)
	self.fastjoinBtn:set_sprite_names("ty_anniu3")
	--self.createTeamBtn:set_enable(true)
	self.createTeamBtn:set_sprite_names("ty_anniu4")
	self:set_label_color(true)
    else
	--self.fastjoinBtn:set_enable(false)
	self.fastjoinBtn:set_sprite_names("ty_anniu5")
	--self.createTeamBtn:set_enable(false)
	self.createTeamBtn:set_sprite_names("ty_anniu5")
	self:set_label_color(false)
    end
    
    local hasEnterUI = PlayerEnterUITimesCurDay.EnterUI("CloneBattleUI")
    
    
end

function CloneBattleUI:set_label_color(flag)
    
    if flag then
	self.createTeamBtnLab:set_effect_color(29/255,85/255,160/255,255/255)
	self.fastjoinBtnLab:set_effect_color(174/255,65/255,40/255,255/255)
    else
	self.createTeamBtnLab:set_effect_color(139/255,139/255,139/255,255/255)
	self.fastjoinBtnLab:set_effect_color(139/255,139/255,139/255,255/255)
    end
    
end

function CloneBattleUI:bound3d()
    local data = 
    {
        roleData = CardHuman:new({number=self.herolist[self.choseitemindex], isNotCalProperty = true});
        role3d_ui_touch = self.hero3D,
        type = "left",
    }   
    Show3d.SetAndShow(data)
end

function CloneBattleUI:on_click_Select(t)
    
    --app.log("on_click_Select##############"..tostring(t.float_value))
    local index = tonumber(t.string_value)
    
    if self.choseitem then
	self.choseitem:set_active(false)
    end
    
    if self.texture[index] then
	self.texture[index]:set_active(true)
	self.choseitem = self.texture[index]
    end
    
    self.choseitemindex = tonumber(t.string_value)
    
    local flag = self:haveHero(self.herolist[self.choseitemindex])
    
    --app.log("flag ####"..flag)
    local role =  PublicFunc.IdToConfig(self.herolist[self.choseitemindex])
    
    self.uiplayername:set_text(role.name)
    
    if flag ~= "" then
	--self.fastjoinBtn:set_enable(true)
	self.fastjoinBtn:set_sprite_names("ty_anniu3")
	--self.createTeamBtn:set_enable(true)
	self.createTeamBtn:set_sprite_names("ty_anniu4")
	self:set_label_color(true)
    else
	--self.fastjoinBtn:set_enable(false)
	self.fastjoinBtn:set_sprite_names("ty_anniu5")
	--self.createTeamBtn:set_enable(false)
	self.createTeamBtn:set_sprite_names("ty_anniu5")
	self:set_label_color(false)
    end
    
    self:setSkillData(self.herolist[self.choseitemindex])
        
    self:bound3d()
end

function CloneBattleUI:on_click_Select_hero(card,info,i)
    --app.log("on_click_Select_hero#############"..tostring(i))
    
    if self.choseitemindex == tonumber(i) then
	return
    end
    
    self.choseitemindex = tonumber(i);
    
    if self.choseitem then
	self.choseitem:set_active(false)
    end
            
    if self.texture[i] then
	self.texture[i]:set_active(true)
	self.choseitem = self.texture[i]
    end
    
    local role =  PublicFunc.IdToConfig(self.herolist[self.choseitemindex])
     
    --app.log("role id #############"..tostring(self.herolist[self.choseitemindex])) 
    
    local flag = self:haveHero(self.herolist[self.choseitemindex])
    
    --app.log("flag @@@@"..flag)
    
    if flag ~= "" then
	--self.fastjoinBtn:set_enable(true)
	self.fastjoinBtn:set_sprite_names("ty_anniu3")
	--self.createTeamBtn:set_enable(true)
	self.createTeamBtn:set_sprite_names("ty_anniu4")
	self:set_label_color(true)
    else
	--self.fastjoinBtn:set_enable(false)
	self.fastjoinBtn:set_sprite_names("ty_anniu5")
	--self.createTeamBtn:set_enable(false)
	self.createTeamBtn:set_sprite_names("ty_anniu5")
	self:set_label_color(false)
    end
    
    self.uiplayername:set_text(role.name)
    
    self:setSkillData(self.herolist[self.choseitemindex])
    self:bound3d()
end

function CloneBattleUI:haveHero( role )
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local dataid = "";
    for k,v in pairs(haveherolist)do
	if v.default_rarity == role then
	    dataid = v.index
	end
    end
    
    return dataid
end

function CloneBattleUI:setSkillData( index )
    do return end
    --app.log("index #####################"..tostring(index))
    --local cf = ConfigManager.Get(EConfigIndex.t_player_select_role,index);
    local role = PublicFunc.IdToConfig(index)
    
    local skillid1 = role.skill4;
    --app.log("#################################skill1   "..skillid1)
    local skillid2 = role.skill5
    --app.log("#################################skill2   "..skillid1)
    local skillid3 = role.skill6
    
    local skiliconl = ConfigManager.Get(EConfigIndex.t_skill_info,skillid1);
    local skilicon2 = ConfigManager.Get(EConfigIndex.t_skill_info,skillid2);
    local skilicon3 = ConfigManager.Get(EConfigIndex.t_skill_info,skillid3);
    
    self.skillicon[1]:set_texture(skiliconl.small_icon)
    self.skillicon[2]:set_texture(skilicon2.small_icon)
    self.skillicon[3]:set_texture(skilicon3.small_icon)
    
end

--技能TIPS
function CloneBattleUI:on_click_SelectSkill( name, state, x, y, go_obj )
    --app.log("name is#####################"..name)
    
    --local cf = nil;
    local skillid = 0;
    local skilllvl = 1;
    --local power = 0;
    
    local role = PublicFunc.IdToConfig(self.herolist[self.choseitemindex])
    local power = role.default_atk_power
    
    if state then
	if name == "btn1" then
	    skillid = role.skill4
	    --power = role.default_atk_power
	elseif name == "btn2" then
	    skillid = role.skill5
	    --power = role.default_atk_power
	elseif name == "btn3" then
	    skillid = role.skill6
	    --power = role.default_atk_power
	end
	
	SkillTips.EnableSkillTips(true, skillid, skilllvl, power, x, y, 300)
    else
	SkillTips.EnableSkillTips(false)
    end
end

function CloneBattleUI:on_click_CreateTeam()
    
    local flag = self:haveHero(self.herolist[self.choseitemindex])
    if flag ~= "" then    
   
	--local haveallhero = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have)
    local haveallhero = PublicFunc.GetAllHero(ENUM.EShowHeroType.All)
	
	local selectheroid = self.herolist[self.choseitemindex]
	msg_clone_fight.cg_create_team(self.herolist[self.choseitemindex])
	
	--uiManager:PopUi()
    else
	FloatTip.Float("请先拥有该英雄！");
    end
end

function CloneBattleUI:on_click_QuitJoin()
    local flag = self:haveHero(self.herolist[self.choseitemindex])
    if flag ~= "" then    
	msg_clone_fight.cg_quick_join( self.herolist[self.choseitemindex] )
	--uiManager:PopUi()
    else
	FloatTip.Float("请先拥有该英雄！");
    end
end

function CloneBattleUI:UpdateUi()
    self:bound3d()
end


FormationUi = Class("FormationUi",UiBaseClass);

local _UIText = {
    [1] = "[FCD901FF]%d[-]级",
    [16] = "所有",
    [17] = "防",
    [18] = "攻",
    [19] = "技",

    ["default_team"]    = "角色·阵容",
    ["arena_team"]      = "竞技场·阵容",
    ["limit_team"]      = "极限挑战·阵容",
}

function FormationUi:GetNavigationTitle()
    local title = _UIText["default_team"]
    if self.teamInfo == nil then
        title = ""
    elseif self.teamType == ENUM.ETeamType.arena then
        title = _UIText["arena_team"]
    elseif self.teamType == ENUM.ETeamType.kuikuliya then
        title = _UIText["limit_team"]
    end

    return title;
end

-- param 为 fight_back 时默认为玩家自己信息，其他情况需要调用SetPlayerGID设置玩家信息
function FormationUi:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/zhenrong/ui_602_4.assetbundle";
    UiBaseClass.Init(self, data);
end

function FormationUi:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Formation3D, Root.empty_func)
end

function FormationUi:Restart(data)
    self.teamInfo = nil;
    if self.ui == nil then
        if data == "fight_back" then
            self:SetPlayerGID(g_dataCenter.player:GetGID(),ENUM.ETeamType.normal);
        else
        end
    end
    UiBaseClass.Restart(self, param);
end

function FormationUi:SetUseArrange(is)
    self.isUseArrange = is
end

function FormationUi:SetPlayerGID(player_gid,team_type,zhengxin,soldier,hero_max_num, use_def_team)
    self.playerGID = player_gid
    self.player = nil;
    self.package = nil;
    self.teamInfo = nil;
    self.guild = nil;
    self.teamType = team_type;
    self.zhengxin = zhengxin;
    self.soildier = soldier;
    self.heroMaxNum = hero_max_num or 3;
    self.heroType = 0;
    self.use_def_team = use_def_team
    if player_gid ~= g_dataCenter.player:GetGID() then
        player.cg_look_other_player(player_gid,team_type);
        return;
    else
        self.player = g_dataCenter.player;
        self.package = g_dataCenter.package;

        if self.use_def_team then
            self.use_def_team = true
        end
        if self.use_def_team then
            self.teamType = ENUM.ETeamType.normal
        end
        local teamInfo = g_dataCenter.player:GetTeam(self.teamType)
        if teamInfo == nil  then
            if self.use_def_team == nil or self.use_def_team then
                teamInfo = g_dataCenter.player:GetTeam(ENUM.ETeamType.normal)
            else
                teamInfo = {}
            end
        end
        self.teamInfo = Utility.clone( teamInfo );
        if g_dataCenter.guild.detail then
            self.guild = g_dataCenter.guild.detail;
        end
    end
    self:UpdateUi();

    uiManager:GetNavigationBarUi():setTitle(self:GetNavigationTitle())
end

function FormationUi:SetDefTeam(team)
    self.teamInfo = team
    self:UpdateUi();
end

function FormationUi:InitData(data)
	UiBaseClass.InitData(self, data);
    -- ui控件
    self.playerHead = nil;
    self.playerLevel = nil;
    self.playerName = nil;
    self.playerFightPower = nil;
    self.playerArea = nil;
    self.playerOrg = nil;
    self.playerID = nil;
    self.curState = 1; -- 1:正常 2:选择英雄列表英雄 3:长按人物
    self.heroObj = {};
    self.Hero = {};
    self.heroMaxNum = 0;

    self.proTypeList = {
        [1] = {txt = _UIText[18], type = ENUM.EProType.Gong, spName = "yx_zhanshi1"},
        [2] = {txt = _UIText[19], type = ENUM.EProType.Ji, spName = "yx_nengliang1"},
        [3] = {txt = _UIText[17], type = ENUM.EProType.Fang, spName = "yx_roudun1"},
        [4] = {txt = _UIText[16], type = ENUM.EProType.All, spName = "yx_quanbu1"},
    }
end

function FormationUi:DestroyUi()
    if self.get_hero_audio ~= nil then
        AudioManager.StopUiAudio(self.get_hero_audio)
        self.get_hero_audio = nil
    end
    if self.guideArrowTipsUi then
        self.guideArrowTipsUi:DestroyUi()
        self.guideArrowTipsUi = nil
    end
    for k,v in pairs(self.heroObj) do
        v.obj:DestroyUi();
    end
    if self.heroListUi then
        self.heroListUi:DestroyUi()
        self.heroListUi = nil
    end
    Formation3D.Destroy();
    if self.dragEffect then
        for id,effect in pairs(self.dragEffect) do
            EffectManager.deleteEffect(id);
        end
    end
    self.save_callback = nil;
    self.dragEffect = nil;
    self.playerLevel = nil;
    self.playerName = nil;
    self.playerFightPower = nil;
    self.playerArea = nil;
    self.playerOrg = nil;
    self.playerID = nil;
    self.curState = 1; -- 1:正常 2:选择英雄列表英雄 3:长按人物
    self.heroObj = {};
    self.Hero = {};
    self.heroList = {};
    self.reLayoutCount = 0
    self.guideArrow = false

    UiBaseClass.DestroyUi(self);
end

function FormationUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["gc_look_other_player"] = Utility.bind_callback(self,FormationUi.gc_look_other_player);

    self.bindfunc["on_play_animation"] = Utility.bind_callback(self, self.on_play_animation)
    self.bindfunc["on_tag_hero"] = Utility.bind_callback(self,self.on_tag_hero);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item);
    self.bindfunc["on_chose_hero"] = Utility.bind_callback(self,self.on_chose_hero);
    self.bindfunc["on_click_sp"] = Utility.bind_callback(self,self.on_click_sp);
    self.bindfunc["on_drag_start_sp"] = Utility.bind_callback(self,self.on_drag_start_sp);
    self.bindfunc["on_drag_release_sp"] = Utility.bind_callback(self,self.on_drag_release_sp);
    self.bindfunc["on_ngui_drag_move"] = Utility.bind_callback(self,self.on_ngui_drag_move);
    self.bindfunc["on_save"] = Utility.bind_callback(self,self.on_save);
    self.bindfunc["on_update_team"] = Utility.bind_callback(self,self.on_update_team);
    self.bindfunc["on_click_info"] = Utility.bind_callback(self, self.on_click_info);
end

--注册消息分发回调函数
function FormationUi:MsgRegist()
    PublicFunc.msg_regist(player.gc_look_other_player,self.bindfunc['gc_look_other_player']);
    PublicFunc.msg_regist(msg_team.gc_update_team_info,self.bindfunc['on_update_team']);
end

--注销消息分发回调函数
function FormationUi:MsgUnRegist()
    PublicFunc.msg_unregist(player.gc_look_other_player,self.bindfunc['gc_look_other_player']);
    PublicFunc.msg_unregist(msg_team.gc_update_team_info,self.bindfunc['on_update_team']);
end

function FormationUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self,asset_obj);
    self.camera = Root.get_ui_camera();
    self.ui:set_name("formation_ui");
    local _ui = self.ui;
    self.down_other = _ui:get_child_by_name("down_other");
    self.cancelSp = _ui:get_child_by_name("down_other/animation/panel_btn/sp_btn");
    self.cancelSp:set_active(false);

    self.team = {};
    for i=1,3 do
	    self.team[i] = {};
        local nodeHeroInfo1 = _ui:get_child_by_name("centre_other/animation/content"..i);
        local nodeDragTips = _ui:get_child_by_name("down_other/animation/content"..i.."/sp_bk")
        local nodeHeroInfo2 = _ui:get_child_by_name("down_other/animation/content"..i.."/sp_di")
        
	    self.team[i].labName = ngui.find_label(nodeHeroInfo2,"lab_name");
	    self.team[i].spOcc = ngui.find_sprite(nodeHeroInfo2,"sp_pinzhi");
        self.team[i].labLevel = ngui.find_label(nodeHeroInfo2,"lab_level");
        self.team[i].labRarity = ngui.find_label(nodeHeroInfo2,"lab_zishi");
        self.team[i].spArrows = ngui.find_sprite(nodeHeroInfo1,"sp_arrows");
        self.team[i].spArrows:set_active(false);

        -- self.team[i].leader = _ui:get_child_by_name("down_other/animation/content"..i.."/sp_di/sp_leader")
        -- if i > 1 then
        --     self.team[i].leader:set_active(false);
        -- end
        
        self.team[i].labFightPower = ngui.find_label(nodeHeroInfo2, "sp_fight/lab_fight");
        --self.team[i].spPinzhi = ngui.find_sprite(nodeHeroInfo2,"sp_pinzhi");
        --self.team[i].spPinzhi:set_active(false)
	    self.team[i].star = {};
	    for j=1,Const.HERO_MAX_STAR do
	    	self.team[i].star[j] = {};
	    	self.team[i].star[j].sp = ngui.find_sprite(nodeHeroInfo2,"cont_star/sp_star"..j);
	    end

        self.team[i].nodeHeroInfo1 = nodeHeroInfo1
        self.team[i].nodeDragTips = nodeDragTips
        self.team[i].nodeHeroInfo2 = nodeHeroInfo2


        -- local btn = ngui.find_button(nodeHeroInfo2, );
        -- btn:set_on_click(self.bindfunc["on_click_info"]);
        -- btn:set_event_value("",i);

	    self.team[i].spTouch = ngui.find_sprite(_ui,"centre_other/animation/sp_human"..i);
        self.team[i].spTouch:set_on_ngui_click(self.bindfunc["on_click_sp"]);
        self.team[i].spTouch:set_event_value("",i);
        self.team[i].spTouch:set_on_dragdrop_start(self.bindfunc["on_drag_start_sp"]);
        self.team[i].spTouch:set_on_dragdrop_release(self.bindfunc["on_drag_release_sp"]);
        self.team[i].spTouch:set_on_ngui_drag_move(self.bindfunc["on_ngui_drag_move"]);
        self.team[i].spTouch:set_dragdrop_restriction(1);
        self.team[i].spTouch:set_is_dragdrop_clone(true);        
		self.team[i].spTouch:set_is_hide_clone(true);
	end

    self.team[1].spSilhouette = ngui.find_texture(_ui, "centre_other/animation/centre_human")
    self.team[2].spSilhouette = ngui.find_texture(_ui, "centre_other/animation/left_human")
    self.team[3].spSilhouette = ngui.find_texture(_ui, "centre_other/animation/right_human")

    self.labFightValue = ngui.find_label(_ui, "left_top_other/animation/sp_fight/lab_fight")

    self.nodeSeatFx = _ui:get_child_by_name("centre_other/animation/cont_fx")
    self.nodeSeatFx:set_active(false)

    if self.heroListUi == nil then
        self.heroListUi = CommonHeroListUI:new({
            parent = self.down_other,
            isFormationUi = true,
            tipType = SmallCardUi.TipType.NotShow,
            showGuardHeartTip = true,
            callback = {
                update_choose_hero = self.bindfunc["on_chose_hero"],
                cancel_choose_hero = self.bindfunc["on_chose_hero"],
                on_drag_begin = self.bindfunc["on_drag_start_sp"],
                on_drag_move = self.bindfunc["on_ngui_drag_move"],
                on_drag_release = self.bindfunc["on_drag_release_sp"],
            }
        });
        self.heroListUi:UpdateUi();
    end 

    self:UpdateUi();
    self.reLayoutCount = 1

    --上阵引导
    if self.guideArrow then
        self:SetGuideArrowEnable(true)
    end
end

function FormationUi:Update()
    if self.reLayoutCount == 1 then
        self.reLayoutCount = 2
    end
end

function FormationUi:on_navbar_back()
    local flg = self:CheckChangeTeam();
    if flg then
        self.save_callback = function () uiManager:PopUi(); end
        self:on_save();
    end
    return flg;
end

function FormationUi:on_navbar_home()
    local flg = self:CheckChangeTeam();
    if flg then
        self.save_callback = function () uiManager:SetStackSize(1) end
        self:on_save();
    end
    return flg;
end

function FormationUi:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
        self:UpdateSceneInfo();
        self.heroListUi:UpdateUi();
    end
end

function FormationUi:UpdateSceneInfo()
    if not self.ui then return end;
    if self.teamInfo == nil then return end;

    self:UpdateTeamInfo();
    self:CheckDefaultTeam();
    
    -- 检测队伍是否更改
    -- self.btnSave:set_enable(self:CheckChangeTeam());
    if self:CheckChangeTeam() then
        self:on_save();
    end

    if self.teamType == ENUM.ETeamType.arena or
        self.teamType == ENUM.ETeamType.kuikuliya or self.isUseArrange then
        -- self.btnArray:set_active(true)
    else
        -- self.btnArray:set_active(false)
    end

    -- 更新3d
    local data =
    {
        roleData = {},
        roleNum = self.heroMaxNum,
    }
    if self.package then
        for i=1,self.heroMaxNum do
            data.roleData[i] = self.package:find_card(1,self.teamInfo[i]);
        end
    end
    Formation3D.SetAndShow(data)
end

-- 检测队伍是否更改
function FormationUi:CheckChangeTeam()
    if self.teamInfo == nil then
        return false;
    end
    local flg = false;
    local defTeam = g_dataCenter.player:GetTeam(self.teamType) or {};
    for i=1,self.heroMaxNum do
        if defTeam[i] ~= self.teamInfo[i] then
            flg = true;
            break;
        end
    end
    return flg;
end

--[[更新队伍信息]]
function FormationUi:UpdateTeamInfo()
    if self.package then
        local curTeam = self.teamInfo or {};
        local teamFightValue = 0
        for i=1,3 do
            if i <= self.heroMaxNum then
                self.team[i].nodeHeroInfo1:set_active(true);
                self.team[i].nodeHeroInfo2:set_active(true);
                self.team[i].nodeDragTips:set_active(false);
                self.team[i].spSilhouette:set_active(false);
                self.team[i].spTouch:set_active(true);
                local cardinfo;
                if self.package then
                    cardinfo = self.package:find_card(1,curTeam[i]);
                end
                if cardinfo then
                    self.team[i].nodeHeroInfo1:set_active(true);
                    self.team[i].nodeHeroInfo2:set_active(true);
                    self.team[i].nodeDragTips:set_active(false);
                    self.team[i].spSilhouette:set_active(false);
                    -- self.team[i].labRarityRoot:set_active(true);
                    -- self.team[i].labKeZhiRoot:set_active(true);
                    -- local name,add_num = PublicFunc.ProcessNameSplit(cardinfo.name);
                    self.team[i].labName:set_text(tostring(cardinfo.name));
                    -- if add_num == 0 then
                    --     self.team[i].labAddNum:set_text("");
                    -- else
                    --     self.team[i].labAddNum:set_text("+"..tostring(add_num));
                    -- end
                    local fightValue = cardinfo:GetFightValue(--[[ENUM.ETeamType.normal]])
                    self.team[i].labFightPower:set_text(tostring(fightValue));
                    self.team[i].labLevel:set_text(string.format(_UIText[1],cardinfo.level));
                    PublicFunc.SetProTypePic(self.team[i].spOcc,cardinfo.pro_type, 3);
                    self.team[i].labRarity:set_text(PublicFunc.GetAptitudeText(cardinfo.config.aptitude));
                    -- self.team[i].labKeZhi:set_text(PublicFunc.GetRestraintStr(cardinfo.config.restraint));
                    for j=1,Const.HERO_MAX_STAR do
                        if self.team[i].star[j].sp then
                            if j <= cardinfo.rarity then
                                self.team[i].star[j].sp:set_active(true);
                            else
                                self.team[i].star[j].sp:set_active(false);
                            end
                        end
                    end

                    teamFightValue = teamFightValue + fightValue
                else
                    self.team[i].labName:set_text("");
                    self.team[i].spOcc:set_sprite_name("");
                    self.team[i].nodeDragTips:set_active(true);
                    self.team[i].nodeHeroInfo1:set_active(false);
                    self.team[i].nodeHeroInfo2:set_active(false);
                    self.team[i].spSilhouette:set_active(true);
                    -- self.team[i].labRarityRoot:set_active(false);
                    -- self.team[i].labKeZhiRoot:set_active(false);
                    for j=1,Const.HERO_MAX_STAR do
                        if self.team[i].star[j].sp then
                            self.team[i].star[j].sp:set_active(false);
                        end
                    end
                end
            else
                self.team[i].nodeHeroInfo1:set_active(false);
                self.team[i].nodeHeroInfo2:set_active(false);
                self.team[i].nodeDragTips:set_active(true);
                self.team[i].spSilhouette:set_active(true);
                self.team[i].spTouch:set_active(false);
            end
        end

        self.labFightValue:set_text(tostring(teamFightValue))
    else
        for i=1,3 do
            if i <= self.heroMaxNum then
                self.team[i].nodeHeroInfo1:set_active(true);
                self.team[i].nodeHeroInfo2:set_active(true);
                self.team[i].nodeDragTips:set_active(false);
                self.team[i].spSilhouette:set_active(false);
                self.team[i].spTouch:set_active(true);
                self.team[i].labName:set_text("");
                self.team[i].spOcc:set_sprite_name("");
                -- self.team[i].labRarityRoot:set_active(false);
                -- self.team[i].labKeZhiRoot:set_active(false);
                for j=1,Const.HERO_MAX_STAR do
                    if self.team[i].star[j].sp then
                        self.team[i].star[j].sp:set_active(false);
                    end
                end
            else
                self.team[i].nodeHeroInfo1:set_active(false);
                self.team[i].nodeHeroInfo2:set_active(false);
                self.team[i].nodeDragTips:set_active(true);
                self.team[i].spSilhouette:set_active(true);
                self.team[i].spTouch:set_active(false);
            end
        end

        self.labFightValue:set_text(tostring(0))
    end


end

function FormationUi:FormatColor(color_str)
    local r,g,b;
    r = string.sub(color_str,1,2);
    g = string.sub(color_str,3,4);
    b = string.sub(color_str,5,6);
    return tonumber(r,16),tonumber(g,16),tonumber(b,16)
end

--[[使用公共界面的布阵自行完善默认阵型检查]]
function FormationUi:CheckDefaultTeam()
    if self.playerGID ~= g_dataCenter.player:GetGID() then return end
    local teamid = self.teamType or 0


    -- 阵型数据不存在，构造1个默认阵型
    if g_dataCenter.player:GetTeam(teamid) == nil and self.use_def_team then
        for i, v in pairs(g_dataCenter.player:GetDefTeam()) do
            g_dataCenter.player:AddTeam(teamid, i, v)
        end

        self.teamInfo = Utility.clone( g_dataCenter.player:GetTeam(teamid) ) -- 更新阵型数据
    end
end

function FormationUi:gc_look_other_player(result,playerid,teamType,otherPlayerData)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result);
        uiManager:PopUi();
        return;
    end
    local guild = otherPlayerData.guilddata;
    local team = otherPlayerData.teamData;
    local role_cards = otherPlayerData.vecRoleData;
    local equip_cards = otherPlayerData.vecEquipData;
    local player = Player:new();
    local package = Package:new();
    player:UpdateData(otherPlayerData);
    for k,v in pairs(equip_cards) do
        if tonumber(v) ~= 0 then
            package:AddCard(ENUM.EPackageType.Equipment,v);
        end
    end
    for k,v in pairs(role_cards) do
        if tonumber(v) ~= 0 then
            package:AddCard(ENUM.EPackageType.Hero,v);
        end
    end
    package:CalAllHeroProperty();
    local teamid = 0;
    for k,v in pairs(team.cards) do
        if tonumber(v) ~= 0 then
            player:AddTeam(teamid, k, v)
        end
    end
    for k,v in pairs(team.heroLineup) do
        local num = tonumber(v);
        if num then
            player:AddTeamPos(teamid, k, num)
        end
    end
    self.player = player;
    self.package = package;
    self.teamInfo = team.cards;
    if guild and guild.szName ~= "" then
        --app.log_warning("guild:"..table.tostring(guild))
        self.guild = GuildDetail:new(guild);
    end
    self:UpdateUi();
end

function FormationUi:on_chose_hero(info)
    -- app.log("#lhf #on_chose_hero"..tostring(info).." "..tostring(self.choseHero));
    if info == self.choseHero then
        self.choseHero = nil;
        self.curState = 1;
        for i=1,self.heroMaxNum do
            self.team[i].spArrows:set_active(false);
        end
    else
        self.choseHero = info;
        self.curState = 2;
        for i=1,self.heroMaxNum do
            self.team[i].spArrows:set_active(true);
        end
    end
end

function FormationUi:on_click_sp(obj_name,is_drug)
    if self.curState == 2 then
        if self.choseHero == nil then
            return ;
        end
        local obj_num = string.gsub(obj_name, "^[^0-9]*([1-3])[^0-9]*$", "%1");
        obj_num = tonumber(obj_num);
        local isLeader = false;
        for i=1,self.heroMaxNum do
            if self.choseHero.index == self.teamInfo[i] then
                if i == 1 and i ~= obj_num then
                    isLeader = true;
                else
                    self.teamInfo[i] = nil;
                end
            end
        end
        if not isLeader then
            self.teamInfo[obj_num] = self.choseHero.index;
            AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
            local roledata = g_dataCenter.package:find_card(1,self.choseHero.index);
            if roledata and roledata.model_id then
                local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, roledata.model_id);
                if self.get_hero_audio ~= nil then
                    AudioManager.StopUiAudio(self.get_hero_audio)
                end
                self.get_hero_audio = nil;
                if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
                    local count = #model_list_cfg.egg_get_audio_id;
                    local n = math.random(1,count)
                    self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
                end
            end
        else
            FloatTip.Float("队长位置不能空缺！");
        end
        self:UpdateSceneInfo();
        if is_drug ~= true then
            self.heroListUi:CancelChooseHero(self.choseHero);
        end
    end
end

function FormationUi:on_drag_start_sp(src,obj,info)
    if not obj and not info then
        -- 拖拽阵容上的
        local src_name = src:get_name();
        local src_num = string.gsub(src_name, "^[^0-9]*([1-3])[^0-9]*$", "%1");
        app.log("相关信息：src_name:"..src_name.." src_num:"..tostring(src_num))
        src_num = tonumber(src_num);
        if self.teamInfo[src_num] ~= nil then
            self.cancelSp:set_active(true);
            Formation3D.instance:SetChoseEffect(src_num,true);
            -- 拖拽后特效显示
            self:SetDragEffect(true);
        end
    else
        -- 拖拽英雄列表上的卡片
        -- 拖拽后特效显示
        self:SetDragEffect(true);
    end
    return true;
end

function FormationUi:on_drag_release_sp(src,tar,obj,info)
    local src_name = src:get_name();
    local src_num = string.gsub(src_name, "^[^0-9]*([1-3])[^0-9]*$", "%1");
    src_num = tonumber(src_num);
    local tar_name = tar:get_name();
    local tar_num = string.gsub(tar_name, "^[^0-9]*([1-3])[^0-9]*$", "%1");
    tar_num = tonumber(tar_num);
    app.log("拖动完成：src_name:"..src_name.." src_num:"..tostring(src_num).." tar_name:"..tar_name.." tar_num:"..tostring(tar_num));

    if not obj and not info then
        -- 拖拽阵容上的
        --if self.teamInfo[src_num] == nil then
        --    return true;
        --end

        if tar_num == nil then
            if tar_name == "sp_btn" then
                if src_num ~= 1 then
                    app.log("cancel pos:"..src_num)
                    self.teamInfo[src_num] = nil;
                else
                    FloatTip.Float("队长位置不能空缺！");
                end
                self:UpdateSceneInfo();
            else
            end
        else
            app.log("change pos:"..src_num.." to "..tar_num);
            if src_num == 1 and not self.teamInfo[tar_num] or (tar_num == 1 and not self.teamInfo[src_num]) then
                FloatTip.Float("队长位置不能空缺！");
            else
                local buf = self.teamInfo[src_num];
                self.teamInfo[src_num] = self.teamInfo[tar_num]
                self.teamInfo[tar_num] = buf;
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
                local roledata = g_dataCenter.package:find_card(1,buf);
                if roledata and roledata.model_id then
                    local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, roledata.model_id);
                    if self.get_hero_audio ~= nil then
                        AudioManager.StopUiAudio(self.get_hero_audio)
                    end
                    self.get_hero_audio = nil;
                    if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
                        local count = #model_list_cfg.egg_get_audio_id;
                        local n = math.random(1,count)
                        self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
                    end
                end
            end
            self:UpdateSceneInfo();
        end
        self.cancelSp:set_active(false);
        Formation3D.instance:SetChoseEffect(src_num,false);
    else
        -- 拖拽英雄列表上的卡片
        if string.find(tar_name,"sp_human") then
            self:on_click_sp(tar_name,true);
        end
    end
    -- 拖拽后特效显示
    self:SetDragEffect(false);
    return true;
end

function FormationUi:on_save(end_callback)
    if self.teamInfo[1] == nil then
        FloatTip.Float("队长位置不能空缺！");
        return;
    end

    local _team =
    {
        ["teamid"] = self.teamType or 0,
        cards = {},
    }
    local _curTeam = self.teamInfo or {};
    for i=1,self.heroMaxNum do
        if _curTeam[i] then
            _team.cards[i] = _curTeam[i]
        else
            _team.cards[i] = "0";
        end
    end
    -- _team.heroLineup = nil
    -- _team.soldierLineup = nil;

    msg_team.cg_update_team_info(_team);

    local param_type = type(end_callback);
    if param_type == "string" or param_type == "function" then
        Utility.CallFunc(end_callback);
    end
end

function FormationUi:on_ngui_drag_move( name, x, y, go_obj )
    local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local _x,_y,_z = self.camera:screen_to_world_point(x,y,0);
    if self.dragEffect then
        for k,effect in pairs(self.dragEffect) do
            effect:set_position(_x,_y,0);
        end
    end
end

function FormationUi:SetDragEffect(isShow)
    if not self.dragEffect and isShow then
        local ids = FightScene.CreateEffect({x=0,y=0,z=0}, ConfigManager.Get(EConfigIndex.t_effect_data,19013), nil, nil, nil, nil, 0, nil, nil, nil)
        self.dragEffect = {};
        for k,id in pairs(ids) do
            self.dragEffect[id] = EffectManager.GetEffect(id);
            self.dragEffect[id]:set_parent(self.ui);
        end
    end
    if self.dragEffect then
        for k,effect in pairs(self.dragEffect) do
            effect:set_active(isShow);
        end
    end

    self.nodeSeatFx:set_active(isShow)

    --新手引导：播放引导滑动动画
    self:SetGuideArrowEnable(not isShow)
end

function FormationUi:on_update_team()
    --新手引导：重置引导箭头状态
    self:SetGuideArrow(false)

    if self.save_callback then
        Utility.CallFunc(self.save_callback);
    end
    self:UpdateSceneInfo();
    if self.heroListUi then
        self.heroListUi:UpdateUi();
    end
end

function FormationUi:on_click_info(t)
    local index = t.float_value;
    local card_index = self.teamInfo[index];
    if card_index then
        local ui = uiManager:PushUi(EUI.FormationInfoUi);
        ui:setPos(index);
    end
end

-------------------------- 新手引导用 ----------------------------
function FormationUi:GetHeroListUi()
    if self.reLayoutCount ~= 2 then return end
    return self.heroListUi
end

-- 开启滑动箭头引导效果
function FormationUi:SetGuideArrow(bool)
    self.guideArrow = bool

    if bool then
        self:SetGuideArrowEnable(true)
    else
        self:SetGuideArrowEnable(false)
    end
end

-- 控制滑动动画开启/关闭
function FormationUi:SetGuideArrowEnable(isplay)
    if not self.guideArrow then
        if self.guideArrowTipsUi then
            self.guideArrowTipsUi:SetEnable(false)
        end
        return
    end

    if self.heroListUi == nil then
        return -- 未初始化
    end
    
    -- 写死，固定从第二个英雄，上阵到第2个位置(左边)
    if self.guideArrowTipsUi == nil then
        local data = {
            origin = self.heroListUi:GetCardUiByIndex(2),
            target = self.team[2].spTouch:get_game_object(),
        }
        self.guideArrowTipsUi = GuideArrowTips:new(data)
    end
    -- 播放
    if isplay then
        self.guideArrowTipsUi:SetEnable(true)
    -- 停止
    else
        self.guideArrowTipsUi:SetEnable(false)
    end
end

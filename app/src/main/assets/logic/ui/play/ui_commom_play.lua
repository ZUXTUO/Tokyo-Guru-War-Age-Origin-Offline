CommomPlayUI = Class("CommomPlayUI", UiBaseClass);

CommomPlayUI.play = {}
CommomPlayUI.lvSort = {}
CommomPlayUI.index = 1;

function CommomPlayUI:GetNavigationTitle()
    local title = ""
    if CommomPlayUI.index == 3 then
        title = "对决"
    elseif CommomPlayUI.index == 2 then
        title = "挑战"
    elseif CommomPlayUI.index == 1 then
        title = "竞技"
        end
    return title;
end

-- index == 1 :竞技界面
-- index == 2 :挑战界面
function CommomPlayUI.SetIndex(index)
    CommomPlayUI.index = index;
end

function CommomPlayUI.GetUiId()
    if CommomPlayUI.index == 1 then
        return EUI.AthleticEnterUI;
    elseif CommomPlayUI.index == 2 then
        return EUI.ChallengeEnterUI;
    else
        return EUI.DuelEnterUI;
    end
end

function CommomPlayUI.GetUiNode(id)
    local instance = uiManager:FindUI(CommomPlayUI.GetUiId())
    if instance and instance.idToUiNode then
        return instance.idToUiNode[id];
    end
end

function CommomPlayUI.InitPlayData()
    CommomPlayUI.play[1] = {};
    CommomPlayUI.play[2] = {};
    CommomPlayUI.play[3] = {};

    -- CommomPlayUI.play[1].title = "对战";
    local _vs_ui_list = ConfigManager._GetConfigTable(EConfigIndex.t_vs_ui_list)
    for k,v in pairs(_vs_ui_list) do
        CommomPlayUI.play[1][k] = {};
        CommomPlayUI.play[1][k].id = v.id;
        CommomPlayUI.play[1][k].id_fx = v.id_fx;
    end

    -- CommomPlayUI.play[2].title = "玩法";
    local _play_ui_list = ConfigManager._GetConfigTable(EConfigIndex.t_play_ui_list)
    for k,v in pairs(_play_ui_list) do
        CommomPlayUI.play[2][k] = {};
        CommomPlayUI.play[2][k].id = v.id;
        CommomPlayUI.play[2][k].id_fx = v.id_fx;
    end

    -- CommomPlayUI.play[3].title = "对决";
    local _duel_ui_list = ConfigManager._GetConfigTable(EConfigIndex.t_duel_ui_list)
    for k,v in pairs(_duel_ui_list) do
        CommomPlayUI.play[3][k] = {};
        CommomPlayUI.play[3][k].id = v.id;
        CommomPlayUI.play[3][k].id_fx = v.id_fx;
    end

    for i,list in pairs(CommomPlayUI.play) do
        for k,info in pairs(list) do
            local activity_id = info.id;
            local cfg = ConfigManager.Get(EConfigIndex.t_play_vs_data,activity_id);
            if not cfg then
                app.log("id=="..tostring(activity_id).."的玩法没有g_get_play_vs_data配置表");
                break;
            end
            info.cfg = cfg;
        end
    end

    -- 等级排序预处理
    for id=1,3 do
        local lvSort = {};
        for i=1,#CommomPlayUI.play[id] do
            local info = CommomPlayUI.play[id][i]
            local index = #lvSort+1;
            for j=1,#lvSort do
                if info.cfg.open_level < lvSort[j].cfg.open_level then
                    index = j;
                    break;
                end
            end
            table.insert(lvSort, index, info);
        end
        CommomPlayUI.lvSort[id] = lvSort;
    end
end

function CommomPlayUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/wanfa/ui_game_play.assetbundle";
    self.activityId2GuideTipId = 
    {
        [MsgEnum.eactivity_time.eActivityTime_fuzion2] = Gt_Enum.EMain_Athletic_Fuzion,
        [MsgEnum.eactivity_time.eActivityTime_LevelActivity] = Gt_Enum.EMain_Challenge_ActivityLevel,
        [MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa] = Gt_Enum.EMain_Challenge_ActivityLevel_LimitChallenge,
        [MsgEnum.eactivity_time.eActivityTime_trial] = Gt_Enum.EMain_Challenge_ActivityLevel_ExpeditionTrial,
        [MsgEnum.eactivity_time.eActivityTime_WorldBoss] = Gt_Enum.EMain_Athletic_WorldBoss,
        [MsgEnum.eactivity_time.eActivityTime_fuzion2] = Gt_Enum.EMain_Athletic_Fuzion,
        [MsgEnum.eactivity_time.eActivityTime_threeToThree] = Gt_Enum.EMain_Athletic_3V3,
        [MsgEnum.eactivity_time.eActivityTime_arena] = Gt_Enum.EMain_Athletic_Arena,
        [MsgEnum.eactivity_time.eActivityTime_WorldTreasureBox] = Gt_Enum.EMain_Athletic_WorldBox,
        [MsgEnum.eactivity_time.eActivityTime_heroTrial] = Gt_Enum.EMain_Challenge_HeroTrial,
        [60054011] = Gt_Enum.EMain_Challenge_QYZL, -- 区域占领
    }
	UiBaseClass.Init(self, data);
end

function CommomPlayUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.listItems = {};
    self.updateStartFrame = 0 --列表更新帧标记
end

function CommomPlayUI:Restart(data)
    if #CommomPlayUI.play == 0 then
        CommomPlayUI.InitPlayData()
    end
    if tonumber(data) then
        CommomPlayUI.SetIndex(tonumber(data))
    end
    -- self.loadingUIId = GLoading.Show(GLoading.EType.loading,0);
    if UiBaseClass.Restart(self, data) then
	--todo
    end
end

function CommomPlayUI:RestartData(data)
    self.data = {}          --初始化数据
    self.preTextureRes = {} --预加载texture
    self.idToUiNode = {}
    self.indexToid = {}


    for i=1,#CommomPlayUI.play[CommomPlayUI.index] do
        local info = CommomPlayUI.play[CommomPlayUI.index][i]

        if info.cfg.texture_path and info.cfg.texture_path ~= 0 then
            self.preTextureRes[ info.cfg.texture_path ] = {index = #self.data, obj = nil}
        end

        if g_dataCenter.player.level >= info.cfg.open_level or not g_dataCenter.gmCheat:getPlayLimit() then
            table.insert(self.data,info);
        end
    end
    table.insert(self.data, CommomPlayUI.lvSort[CommomPlayUI.index][#self.data+1]);

    -- 获取初始位置
    self.curIndex = 1
    for i, v in ipairs(self.data) do
        local tipEnum = self.activityId2GuideTipId[v.id];
        if tipEnum then
            if not self.curIndex and GuideTipData.GetRedCount(tipEnum) > 0 then
                self.curIndex = i;
            end
        else
            app.log_warning("没有小红点和玩法id的映射。玩法id:"..tostring(activity_id));
        end
    end

    --新手引导处理
    if (GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0) then
        local funcId = GuideManager.GetGuideFunctionId()
        for i, info in ipairs(self.data) do
            --活动关卡项包含三个功能
            if info.id == MsgEnum.eactivity_time.eActivityTime_LevelActivity then
                if  MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang == funcId or
                    MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi == funcId or
                    MsgEnum.eactivity_time.eActivityTime_ClownPlan == funcId then
                    self.curIndex = i
                    break;
                end
            elseif info.id == funcId then
                self.curIndex = i
                break;
            end
        end
    end
end

function CommomPlayUI:OnLoadUI()
    for k, v in pairs(self.preTextureRes) do
        UiBaseClass.PreLoadTexture(k, self.bindfunc["on_texture_loaded"])
    end
end

function CommomPlayUI:on_texture_loaded(pid, fpath, texture_obj, error_info)
    if nil == self.preTextureRes then return end
    self.preTextureRes[fpath].obj = texture_obj:GetObject()

    self:LoadedTextureUpdateUi()
end

function CommomPlayUI:IsCacheTextureLoadOk()
    local result = true
    for k, v in pairs(self.preTextureRes) do
        if v.obj == nil then
            result = false
            break
        end
    end
    return result
end

function CommomPlayUI:LoadedTextureUpdateUi()
    if self:IsCacheTextureLoadOk() and self.ui then
        if self.dragCycleGroup:get_maxNum() == 0 then
            self:UpdateUi();
        end
    end
end

function CommomPlayUI:DestroyUi()
    self.data = nil
    self.preTextureRes = nil
    self.idToUiNode = nil;
    self.indexToid = nil;

    self.updateStartFrame = 0
    if self.content then
        for k,v in pairs(self.content) do
            v.texIcon:Destroy();
            if v.fx then
                EffectManager.deleteEffect(v.fx:GetGID(), true);
            end
        end
        self.content = nil;
    end

    -- if self.itemList then
    --     for k,v in pairs(self.itemList) do
    --         v.item:DestroyUi();
    --     end
    --     self.item_list = nil;
    -- end
    if self.dragCycleGroup then
        self.dragCycleGroup:destroy_object();
        self.dragCycleGroup = nil;
    end
    
    UiBaseClass.DestroyUi(self);
end

function CommomPlayUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_texture_loaded"] = Utility.bind_callback(self,self.on_texture_loaded);
	self.bindfunc["on_click_item"] = Utility.bind_callback(self,self.on_click_item);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self,self.init_item_wrap_content);
    self.bindfunc["onStopMove"] = Utility.bind_callback(self, self.onStopMove);
    -- self.bindfunc["onStartMove"] = Utility.bind_callback(self, self.onStartMove);
	self.bindfunc["onTrialRecvServerData"] = Utility.bind_callback(self, self.onTrialRecvServerData);
    self.bindfunc["onBtnRight"] = Utility.bind_callback(self, self.onBtnRight);
    self.bindfunc["onBtnLeft"] = Utility.bind_callback(self, self.onBtnLeft);   
    self.bindfunc["onStartPos"] = Utility.bind_callback(self, self.onStartPos);
    self.bindfunc["onEndPos"] = Utility.bind_callback(self, self.onEndPos);
end

function CommomPlayUI:onTrialRecvServerData()
	if self.waitb ~= nil then
		--self.content[self.waitb].sp_new:set_active(g_dataCenter.activity[self.waitId]:IsOpen());
	end
end 

function CommomPlayUI:MsgRegist()
	PublicFunc.msg_regist("trial.red_point_state",self.bindfunc["onTrialRecvServerData"]);
end

function CommomPlayUI:MsgUnRegist()
	PublicFunc.msg_unregist("trial.red_point_state",self.bindfunc["onTrialRecvServerData"]);
end

function CommomPlayUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("CommomPlayUI");

    self.content = {};
    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/panel_scoll_view");
    self.dragCycleGroup:set_on_stop_move(self.bindfunc["onStopMove"]);
    -- self.dragCycleGroup:set_on_start_move(self.bindfunc["onStartMove"]);
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["init_item_wrap_content"]);
    self.dragCycleGroup:set_on_outstart(self.bindfunc["onStartPos"]);
    self.dragCycleGroup:set_on_outend(self.bindfunc["onEndPos"]);

    self.btnArrowR = ngui.find_button(self.ui,"centre_other/animation/btn_right");
    self.btnArrowR:set_on_click(self.bindfunc["onBtnRight"],"MyButton.NoneAudio");
    self.btnArrowL = ngui.find_button(self.ui,"centre_other/animation/btn_left");
    self.btnArrowL:set_on_click(self.bindfunc["onBtnLeft"],"MyButton.NoneAudio");
    self.objArrowPointR = self.ui:get_child_by_name("centre_other/animation/panel_btn_arrows/btn_right/animation/sp_point");
    self.objArrowPointL = self.ui:get_child_by_name("centre_other/animation/panel_btn_arrows/btn_left/animation/sp_point");

    if self:IsCacheTextureLoadOk() then
        self:UpdateUi();
    else
        self.dragCycleGroup:set_maxNum(0);
        self.dragCycleGroup:refresh_list();
    end
    -- GLoading.Hide(GLoading.EType.loading, self.loadingUIId);
end

function CommomPlayUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end
    SystemEnterFunc.SetClearStack(false)

    --新手引导处理
    if (GuideManager.IsGuideRuning() and GuideManager.GetGuideFunctionId() > 0) then
        local funcId = GuideManager.GetGuideFunctionId()
        for i, info in ipairs(self.data) do
            --活动关卡项包含三个功能
            if info.id == MsgEnum.eactivity_time.eActivityTime_LevelActivity then
                if  MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang == funcId or
                    MsgEnum.eactivity_time.eActivityTime_gaoSuJuJi == funcId or
                    MsgEnum.eactivity_time.eActivityTime_ClownPlan == funcId then
                    self.curIndex = i
                    break;
                end
            elseif info.id == funcId then
                self.curIndex = i
                break;
            end
        end
    end

    self.dragCycleGroup:set_maxNum(#self.data);
	self.dragCycleGroup:refresh_list();
    if self.curIndex == nil then
        -- self:onStartMove();
        self:onStopMove(1);
    else
        -- self:onStartMove();
		self.dragCycleGroup:set_index(self.curIndex);
        self:onStopMove(self.curIndex);
    end

    self.updateStartFrame = 1
end

function CommomPlayUI:Update(dt)
    if self.updateStartFrame == 1 then
        self.updateStartFrame = 2

        -- 加载列表完成，下一帧更新小红点
        TimerManager.Add(function() GNoticeGuideTipUiUpdate(CommomPlayUI.GetUiId()) end, 1, 1)
    end
end

function CommomPlayUI:init_item_wrap_content(obj,index)
    local b = obj:get_instance_id();
    if self.content[b] == nil then
        self.content[b] = {};
        self.content[b].widgetRoot = ngui.find_widget(obj,obj:get_name());
        self.content[b].btn = ngui.find_button(obj,obj:get_name());
        self.content[b].btn:set_on_click(self.bindfunc["on_click_item"], "MyButton.NoneAudio");
        -- self.content[b].panel = ngui.find_panel(obj,obj:get_name());
        self.content[b].spTitle = ngui.find_sprite(obj,"sp_art_font");
        self.content[b].texIcon = ngui.find_texture(obj, "texture");
        -- self.content[b].spIcon = ngui.find_sprite(obj,"sp_frame");
        self.content[b].spLock = ngui.find_sprite(obj,"sp_suo");
        self.content[b].spLock:set_active(false);
        self.content[b].labLock = ngui.find_label(obj,"sp_suo/lab_level");
        -- self.content[b].spDes = ngui.find_label(obj,"lab");
        self.content[b].labDes = ngui.find_label(obj,"lab");
        self.content[b].objTime = obj:get_child_by_name("sp_clock");
        self.content[b].labTime = ngui.find_label(obj,"lab_time");
        self.content[b].objFx = obj:get_child_by_name("fx");
        self.content[b].sp_new = obj:get_child_by_name("sp_point");
	    self.content[b].sp_new:set_active(false);
        self.content[b].sp_hint = ngui.find_sprite(obj, "sp_hint");
        self.content[b].sp_hint_lab = ngui.find_sprite(obj, "sp_hint/lab");
        if self.content[b].sp_hint then
            self.content[b].sp_hint:set_active(false);
        end
        -- self.content[b].spShine = ngui.find_sprite(obj,"sp_shine");
    --    self.content[b].grid = ngui.find_grid(self.ui,"cont_four");
    --     local cont = {};
    --     for i=1,4 do
    --         cont[i] = {};
    --         cont[i].obj = obj:get_child_by_name("cont_four/new_small_card_item"..i);
    --         cont[i].item = UiSmallItem:new({parent = cont[i].obj})
    --     end
    --     self.content[b].itemList = cont;
    end
    self.listItems[index] = obj;

    local info = self.data[index]
    if not info then
        return;
    end
    local activity_id = info.id;
    if self.indexToid[b] then
        local id = self.indexToid[b];
        self.idToUiNode[id] = nil;
        self.indexToid[b] = nil;
    end
    self.indexToid[b] = info.id;
    self.idToUiNode[info.id] = self.content[b].sp_new;
    --及时刷新列表项的小红点
    GNoticeGuideTipUiUpdate(CommomPlayUI.GetUiId())

    local path = info.cfg.texture_path;
    if self.preTextureRes[path] and self.preTextureRes[path].obj then
        self.content[b].texIcon:SetTexture(self.preTextureRes[path].obj)
    end
    self.content[b].spTitle:set_sprite_name(info.cfg.title_name)

    if info.cfg.des ~= 0 then
        self.content[b].labDes:set_text(info.cfg.des);
    else
        -- self.content[b].spDes:set_active(false);
    end

    if info.cfg.desc1 and info.cfg.desc1 ~= 0 then
        self.content[b].labTime:set_text(tostring(info.cfg.desc1));
    else
        self.content[b].labTime:set_text("");
    end

    -- for i=1,4 do
    --     if cfg.item and cfg.item ~= "0" and tonumber(cfg.item) ~= 0 then
    --         if cfg.item[i] then
    --             local carditem = CardProp:new({number = tonumber(cfg.item[i].item_id)});
    --             self.content[b].itemList[i].item:SetData(carditem);
    --             self.content[b].itemList[i].item:SetLabNum(false);
    --             self.content[b].itemList[i].obj:set_active(true);
    --         else
    --             self.content[b].itemList[i].obj:set_active(false);
    --         end 
    --     else
    --         self.itemList[i].itemList[i].obj:set_active(false);
    --     end
    -- end
    -- self.content[b].grid:reposition_now();

    -- 玩法限制作弊 (校园建设/保卫战/英雄历练/教堂挂机/奎库利亚/世界boss)
    if g_dataCenter.player.level < info.cfg.open_level and g_dataCenter.gmCheat:getPlayLimit() then
        self.content[b].texIcon:set_color(0,0,0,1);
        self.content[b].labLock:set_text("Lv."..tostring(info.cfg.open_level).."开启");
        self.content[b].spLock:set_active(true);
        self.content[b].labDes:set_active(false);
        self.content[b].btn:set_event_value("", -1);
        self.content[b].objTime:set_active(false);
        self.content[b].objFx:set_active(false);
    else
        if self.content[b].fx then
            EffectManager.deleteEffect(self.content[b].fx:GetGID(), true);
            self.content[b].fx = nil;
        end
        if info.id_fx and info.id_fx ~= 0 then
            if self.content[b].fx == nil then
                self.content[b].fx = EffectManager.createEffect(info.id_fx)
            end
            self.content[b].fx:set_parent(self.content[b].objFx);
            self.content[b].fx:set_local_position(0,0,0);
            self.content[b].fx:set_local_scale(1,1,1);
            self.content[b].objFx:set_active(true);
        else
            self.content[b].objFx:set_active(false);
        end

        self.content[b].objTime:set_active(true);
        self.content[b].texIcon:set_color(1,1,1,1);
        self.content[b].spLock:set_active(false);
        self.content[b].labDes:set_active(true);
        self.content[b].btn:set_event_value("", index);
    end

    -- app.log("activity_id:" .. activity_id);
    if activity_id == MsgEnum.eactivity_time.eActivityTime_LevelActivity then
        local is_double = g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_hight_sniper) or 
            g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_defend) or
                g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_xiaochoujihua);

        if self.content[b].sp_hint then
            self.content[b].sp_hint:set_active(is_double);
        end
    end
end

function CommomPlayUI:on_click_item(t)
    local index = t.float_value;
    if index == -1 then
        return;
    end

    local npcid = ConfigHelper.GetNpcIdBySystemid(self.data[index].id);
    local npc = ObjectManager.GetObjectByNumber(npcid);
    if npcid and npc and FightScene.GetFightManager() 
        and FightScene.GetFightManager().MoveCaptainToNpc then
        FightScene.GetFightManager():MoveCaptainToNpc(npc);
        uiManager:SetStackSize(1);
    else
        local id = self.data[index].id
        SystemEnterFunc[id]();
        MyButton.MainBtn();
    end
end

-- function CommomPlayUI:onStartMove()
--     for k,v in pairs(self.content) do
--         v.spShine:set_active(false);
--     end
-- end

function CommomPlayUI:onStartPos(isStart)
    self.btnArrowL:set_active(not isStart);
end

function CommomPlayUI:onEndPos(isEnd)
    self.btnArrowR:set_active(not isEnd);
end

function CommomPlayUI:onStopMove(index)
    if self.curIndex and self.curIndex ~= index then
        MyButton.DragMenu();
    end
    self.curIndex = index;
    self:CheckArrowPoint();
end

function CommomPlayUI:CheckArrowPoint()
    local isRShow = false;
    local isLShow = false;

    for k,info in pairs(self.data) do
        local activity_id = info.id;
        local gtenum = self.activityId2GuideTipId[activity_id];
        if GuideTipData.GetRedCount(gtenum) > 0 then
            if k > self.curIndex + 2 then
                isRShow = true;
            end
            if k < self.curIndex then
                isLShow = true;
            end
        end
    end

    if isLShow then
        self.objArrowPointL:set_active(true);
    else
        self.objArrowPointL:set_active(false);
    end
    if isRShow then
        self.objArrowPointR:set_active(true);
    else
        self.objArrowPointR:set_active(false);
    end
end

function CommomPlayUI:Show()
    UiBaseClass.Show(self);
    self:UpdateUi();
end

------------------------ 新手引导接口函数 -----------------------
function CommomPlayUI:GetListItemObj(index)
    if self.updateStartFrame ~= 2 then return nil end
    if not self.listItems then return nil end
    local obj = self.listItems[index];
    if obj and obj:get_active() then
        return obj;
    end
end

function CommomPlayUI:on_navbar_back()
    self.curIndex = nil;
end

function CommomPlayUI:on_navbar_home()
    self.curIndex = nil;
end

------ 该界面不显示导航条顶部和底部 ------
function CommomPlayUI:GetNavigationTopAndDown(  )
    
end

function CommomPlayUI:onBtnRight()
    self.dragCycleGroup:tween_to_index(#self.data-2);
end

function CommomPlayUI:onBtnLeft()
    self.dragCycleGroup:tween_to_index(1);
end
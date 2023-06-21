ClanUI = Class("ClanUI", UiBaseClass);

local Playid2List = {};

function ClanUI.GetUiNode(id)
    return ClanUI.idToUiNode[id];
end

function ClanUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4601_zhandui.assetbundle";
    self.activityId2GuideTipId = 
    {
        [62001000] = Gt_Enum.EMain_BattleTeam_TalentSystem, -- 天赋
        [62001002] = Gt_Enum.Emain_BattleTeam_Institute, -- 研究所
        [62001001] = Gt_Enum.EMain_BattleTeam_Illustrations, -- 角色图鉴
        [62001005] = Gt_Enum.Emain_BattleTeam_trainning, -- 训练馆
        [62001008] = Gt_Enum.Emain_BattleTeam_MaskInfo,  --面具
        [62001007] = Gt_Enum.EMain_BattleTeam_GuardHeart,  --面具
    }
	UiBaseClass.Init(self, data);
end

function ClanUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.updateStartFrame = 0; --列表更新帧标记
    self.preTextureRes = {} --预加载texture

    local list = ConfigManager._GetConfigTable(EConfigIndex.t_clan_list);
    self.list = {};
    for i,cfgData in ipairs(list) do
        local cfg = ConfigManager.Get(EConfigIndex.t_play_vs_data,cfgData.id);
        self.list[i] = cfg;
        Playid2List[cfgData.id] = cfgData;
        if cfg.texture_path and cfg.texture_path ~= 0 then
            self.preTextureRes[ cfg.texture_path ] = {obj = nil};
        end
    end
    self.lvSort = {};
    for i=1,#self.list do
        local info = self.list[i]
        local index = #self.lvSort+1;
        for j=1,#self.lvSort do
            if info.open_level < self.lvSort[j].open_level then
                index = j;
                break;
            end
        end
        table.insert(self.lvSort, index, info);
    end
end

function ClanUI:OnLoadUI()
    for k, v in pairs(self.preTextureRes) do
        UiBaseClass.PreLoadTexture(k, self.bindfunc["on_texture_loaded"])
    end
end

function ClanUI:on_texture_loaded(pid, fpath, texture_obj, error_info)
    if nil == self.preTextureRes then return end
    self.preTextureRes[fpath].obj = texture_obj:GetObject()

    self:LoadedTextureUpdateUi()
end

function ClanUI:IsCacheTextureLoadOk()
    local result = true
    for k, v in pairs(self.preTextureRes) do
        if v.obj == nil then
            result = false
            break
        end
    end
    return result
end

function ClanUI:LoadedTextureUpdateUi()
    if self:IsCacheTextureLoadOk() and self.ui then
        if self.dragCycleGroup:get_maxNum() == 0 then
            self:UpdateUi();
        end
    end
end

function ClanUI:Restart()
    ClanUI.idToUiNode = {};
    ClanUI.indexToid = {};
    self.curIndex = 1
    -- self.loadingUIId = GLoading.Show(GLoading.EType.loading,0);
    if not UiBaseClass.Restart(self, data) then
        return;
	end
end

function ClanUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.contGrid = nil;
    ClanUI.idToUiNode = {};
    ClanUI.indexToid = {};
    if self.contWrap then
        for k,v in pairs(self.contWrap) do
            v.tex:Destroy();
            if v.fx then
                EffectManager.deleteEffect(v.fx:GetGID(),true);
            end
        end
    end
    self._guide_list_index = nil;
    self.updateStartFrame = 0;
    self.curIndex = nil;
end

function ClanUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_texture_loaded"] = Utility.bind_callback(self,self.on_texture_loaded);
	self.bindfunc["on_click_item"] = Utility.bind_callback(self,self.on_click_item);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self,self.on_init_item);
    self.bindfunc["onStopMove"] = Utility.bind_callback(self, self.onStopMove);
    self.bindfunc["onStartMove"] = Utility.bind_callback(self, self.onStartMove);
    self.bindfunc["onBtnRight"] = Utility.bind_callback(self, self.onBtnRight);
    self.bindfunc["onBtnLeft"] = Utility.bind_callback(self, self.onBtnLeft);   
    self.bindfunc["onStartPos"] = Utility.bind_callback(self, self.onStartPos);
    self.bindfunc["onEndPos"] = Utility.bind_callback(self, self.onEndPos);
end

function ClanUI:MsgRegist()
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_jiao_tang_qi_dao']);
end

function ClanUI:MsgUnRegist()
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_sync_myself_info,self.bindfunc['gc_jiao_tang_qi_dao']);
end

function ClanUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("ClanUI");

    -- self.fx = self.ui:get_child_by_name("centre_other/animation/fx");

    self.contWrap = {};
    self.Index2ContId = {};
    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/panel_scoll_view");
    self.dragCycleGroup:set_on_stop_move(self.bindfunc["onStopMove"]);
    self.dragCycleGroup:set_on_start_move(self.bindfunc["onStartMove"]);
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["on_init_item"]);
    self.dragCycleGroup:set_on_outstart(self.bindfunc["onStartPos"]);
    self.dragCycleGroup:set_on_outend(self.bindfunc["onEndPos"]);

    self.btnArrowR = ngui.find_button(self.ui,"centre_other/animation/btn_right");
    self.btnArrowR:set_on_click(self.bindfunc["onBtnRight"]);
    self.btnArrowL = ngui.find_button(self.ui,"centre_other/animation/btn_left");
    self.btnArrowL:set_on_click(self.bindfunc["onBtnLeft"]);

    self.objArrowPointR = self.ui:get_child_by_name("centre_other/animation/btn_right/animation/sp_point");
    self.objArrowPointL = self.ui:get_child_by_name("centre_other/animation/btn_left/animation/sp_point");

    if self:IsCacheTextureLoadOk() then
        self:UpdateUi();
    else
        self.dragCycleGroup:set_maxNum(0);
        self.dragCycleGroup:refresh_list();
    end  

    self.updateStartFrame = 1
end

function ClanUI:Update(dt)
    if self.updateStartFrame == 1 then
        self.updateStartFrame = 2
    end
end

function ClanUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end

    local level = g_dataCenter.player:GetLevel();
    self.showList = {};
    local flg = false
    for i,cfg in ipairs(self.list) do
        if level >= cfg.open_level then
            table.insert(self.showList,cfg);
        end
    end
    table.insert(self.showList,self.lvSort[#self.showList+1]);

    self.dragCycleGroup:set_maxNum(#self.showList);
    self.dragCycleGroup:refresh_list();
    self:onStopMove(1);
    -- GLoading.Hide(GLoading.EType.loading, self.loadingUIId);
    -- if self.curIndex then
    --     self.dragCycleGroup:tween_to_index(self.curIndex);
    -- else
    --     self.dragCycleGroup:tween_to_index(1);
    -- end
end

function ClanUI:on_init_item(obj, index)
    local b = obj:get_instance_id();
    if self.contWrap[b] == nil then
        self.contWrap[b] = {};
        self.contWrap[b].obj = obj;
        self.contWrap[b].widgetRoot = ngui.find_widget(obj,obj:get_name());
        self.contWrap[b].tex = ngui.find_texture(obj,"texture");
        self.contWrap[b].btn = ngui.find_button(obj,obj:get_name());
        self.contWrap[b].btn:set_on_click(self.bindfunc["on_click_item"], "MyButton.NoneAudio");
        self.contWrap[b].labTitle = ngui.find_sprite(obj,"sp_art_font");
        self.contWrap[b].labDes = ngui.find_label(obj,"lab");
        self.contWrap[b].spLock = obj:get_child_by_name("sp_suo");
        self.contWrap[b].labLock = ngui.find_label(obj,"sp_suo/lab_level");
        self.contWrap[b].objFx = obj:get_child_by_name("fx");
        -- self.contWrap[b].sp = ngui.find_label(obj,"lab_join");
        self.contWrap[b].spRedPoint = obj:get_child_by_name("sp_point");
        -- self.contWrap[b].spShine = ngui.find_sprite(obj,"sp_shine");
        -- self.contWrap[b].spShine:set_active(false);
        self.contWrap[b].sp_hint = ngui.find_sprite(obj, "sp_hint");
        if self.contWrap[b].sp_hint then
            self.contWrap[b].sp_hint:set_active(false);
        end 
    end
    self.Index2ContId[index] = b;
    local cont = self.contWrap[b];
    local cfg = self.showList[index];
    if cfg then
        self:_UpdateItem(cont, cfg, index);
    end
end

function ClanUI:on_click_item(t)
    local index = t.float_value;
    -- if index ~= self.curIndex then
    --     self.dragCycleGroup:tween_to_index(index);
    --     return
    -- end
    local cfg = ConfigManager.Get(EConfigIndex.t_play_vs_data,self.showList[index].id);
    if cfg.open_level > g_dataCenter.player:GetLevel() then
        FloatTip.Float("战队达到"..cfg.open_level.."级开启"..cfg.name.."功能")
    else
        SystemEnterFunc[self.showList[index].id]()
        MyButton.MainBtn();
    end
end

function ClanUI:onStartMove()
    -- self.fx:set_active(false);
    -- for k,v in pairs(self.contWrap) do
    --     v.spShine:set_active(false);
    -- end
end

function ClanUI:onStopMove(index)
    if self.curIndex and self.curIndex ~= index then
        MyButton.DragMenu();
    end
    self.curIndex = index;
    self:CheckArrowPoint();
end

function ClanUI:CheckArrowPoint()
    local isRShow = false;
    local isLShow = false;

    for k,info in pairs(self.showList) do
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

function ClanUI:_UpdateItem(cont, cfg, index)
    local b = cont.obj:get_instance_id();
    if ClanUI.indexToid[b] then
        local id = ClanUI.indexToid[b];
        ClanUI.idToUiNode[id] = nil;
        ClanUI.indexToid[b] = nil;
    end
    ClanUI.indexToid[b] = cfg.id;
    ClanUI.idToUiNode[cfg.id] = cont.spRedPoint;

    local lv = g_dataCenter.player:GetLevel();
    cont.index = index;
    cont.tex:set_texture(cfg.texture_path);
    cont.btn:set_event_value("",index);
    --cont.labTitle:set_text(cfg.name)
    --app.log("index---------------"..tostring(index))
    cont.labTitle:set_sprite_name(cfg.title_name)

    if cfg.des ~= 0 then
        cont.labDes:set_text(cfg.des);
    else
        cont.labDes:set_text("");
    end
    if lv < cfg.open_level then
        cont.tex:set_color(0,0,0,1);
        cont.labLock:set_text("Lv."..tostring(cfg.open_level).."开启");
        cont.spLock:set_active(true);
        cont.labDes:set_text("");
        -- cont.sp:set_active(false);
        cont.objFx:set_active(false);
    else
        local info = Playid2List[cfg.id];
        if cont.fx then
            EffectManager.deleteEffect(cont.fx:GetGID(),true);
        end
        if info.id_fx and info.id_fx ~= 0 then
            cont.fx = EffectManager.createEffect(info.id_fx)
            cont.fx:set_parent(cont.objFx);
            cont.fx:set_local_position(0,0,0);
            cont.fx:set_local_scale(1,1,1);
            cont.objFx:set_active(true);
        else
            cont.objFx:set_active(false);
        end

        cont.tex:set_color(1,1,1,1);
        cont.spLock:set_active(false);
        -- cont.sp:set_active(true);
    end
    --local sys_id = self.showList[index].id;
    --local is_open = ClanUI.RedPointFunc[sys_id]();
    --cont.spRedPoint:set_active(is_open);

    GNoticeGuideTipUiUpdate(EUI.ClanUI);
end

function ClanUI:onStartPos(isStart)
    self.btnArrowL:set_active(not isStart);
end

function ClanUI:onEndPos(isEnd)
    self.btnArrowR:set_active(not isEnd);
end

function ClanUI:onBtnRight()
    self.dragCycleGroup:tween_to_index(#self.showList-2);
end

function ClanUI:onBtnLeft()
    self.dragCycleGroup:tween_to_index(1);
end
-------------------------- 新手引导用 ----------------------------
function ClanUI:GetListItemBtnUiByIndex(index)
    if self.ui == nil then return end
    if self.updateStartFrame ~= 2 then return end

    for b, cont in pairs(self.contWrap) do
        if cont.index == index then
            self._guide_list_index = nil
            return cont.btn:get_game_object()
        end
    end
end
-- 与GetListItemBtnUiByIndex配合使用
function ClanUI:SetListItemBtnUiByIndex(index)
    if self.dragCycleGroup == nil then return false end
    if self._guide_list_index ~= nil then return true end

    self:onStartMove()
    self.dragCycleGroup:set_index(index)
    self:onStopMove(index)
    self._guide_list_index = index
    self.updateStartFrame = 1
    
    return true
end

------------------------- 小红点方法 -------------------------
ClanUI.RedPointFunc = {};
--角色图鉴界面
ClanUI.RedPointFunc[MsgEnum.eactivity_time.eActivityTime_RolePokedex] = function()
    --local roleList = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local roleList = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    --local have = false;
    local have = true;
    for k,cardInfo in pairs(roleList) do
        if cardInfo.index ~= 0 then 
            if cardInfo.illumstration_number == 0 then 
                have = true;
                break;
            elseif cardInfo.illumstration_number < cardInfo.rarity then 
                have = true;
                break;
            end
        end 
    end 
    return have;
end

-- 天赋界面
ClanUI.RedPointFunc[MsgEnum.eactivity_time.eActivityTime_TalentSystem] = function()
    --return g_dataCenter.talentSystem:IsShowTip()
end

-- 研究所界面
ClanUI.RedPointFunc[MsgEnum.eactivity_time.eActivityTime_GraduateSchool] = function()
    return g_dataCenter.Institute:IsOpen();
end

-- 训练场界面
ClanUI.RedPointFunc[MsgEnum.eactivity_time.eActivityTime_Trainning] = function()
    return g_dataCenter.trainning:IsOpen();
end

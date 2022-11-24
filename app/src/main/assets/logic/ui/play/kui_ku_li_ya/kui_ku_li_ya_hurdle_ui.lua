KuiKuLiYaHurdleUI = Class("KuiKuLiYaHurdleUI",UiBaseClass);

local camRes = "assetbundles/prefabs/map/055_jixiantiaozhan/70000055_jixiantiaozhan.assetbundle";

local constFloorHeight = 6; -- 楼层高
local constFloorMoveSpeed = 0.1; -- 楼层移动速度
local constPlayerMoveSpeed = 0.1; -- 玩家跑动速度
local constPlayerSize = 1.25; -- 玩家大小
local constMonsterSize = 1.25; -- 怪物大小
local constEffectSize = 1.25; -- 宝箱大小
local constTopPos = {x=0,y=440,z=0}; -- 顶部蒙板坐标
local constBottomPos = {x=0,y=-412,z=0}; -- 底部蒙板坐标

function KuiKuLiYaHurdleUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/kui_ku_li_ya/ui_4701_challenge.assetbundle";
    UiBaseClass.Init(self, data);
end

function KuiKuLiYaHurdleUI:InitData(data)
    msg_activity.cg_kuikuliya_request_all_floor_data();
    msg_activity.cg_request_kuikuliya_myself_data();
    self.defPos = {x=12.78767, y=19.59327, z=180.2481};
    self.playCfg = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_kuiKuLiYa];
    self.hurdleCfg = ConfigManager._GetConfigTable(EConfigIndex.t_kuikuliya_hurdle_info);
    UiBaseClass.InitData(self, data);
end

function KuiKuLiYaHurdleUI:Restart(data)
    self.curFloor,self.curFloorData = self.playCfg:GetCurFloor();
    self.maxArriveFloor = self.playCfg:GetOpenFloor();
    self.Floor = {};
    self.maxFloor = #self.hurdleCfg;
    self.cameraUi = Root.get_ui_camera();
    self.playerMove = 0;

    self.dlgSweepUI = nil;
    self.dlgSweepTimeUI = nil;
    self.dlgSweepOverUI = nil;

    UiBaseClass.Restart(self, data);
    ResourceLoader.LoadAsset(camRes, self.bindfunc['on_load_camera'], self.panel_name);
end

function KuiKuLiYaHurdleUI:LoadUI()
end

function KuiKuLiYaHurdleUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_load_camera"] = Utility.bind_callback(self, self.on_load_camera);
    self.bindfunc["on_btn_rank"] = Utility.bind_callback(self, self.on_btn_rank);
    self.bindfunc["on_btn_shop"] = Utility.bind_callback(self, self.on_btn_shop);
    self.bindfunc["on_btn_goods"] = Utility.bind_callback(self, self.on_btn_goods);
    self.bindfunc["on_btn_reset_sweep"] = Utility.bind_callback(self, self.on_btn_reset_sweep);
    self.bindfunc["on_btn_click_monster"] = Utility.bind_callback(self, self.on_btn_click_monster);
    self.bindfunc["on_btn_click_goods"] = Utility.bind_callback(self, self.on_btn_click_goods);
    self.bindfunc["on_click_limit"] = Utility.bind_callback(self, self.on_click_limit);
    self.bindfunc["gc_kuikuliya_get_box_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_get_box_reward);
    -- self.bindfunc["gc_reset_kuikuliya"] = Utility.bind_callback(self, self.gc_reset_kuikuliya);
    -- self.bindfunc["gc_kuikuliya_Get_saodang_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_Get_saodang_reward);
	self.bindfunc["gc_sync_kuikuliya_top_list"] = Utility.bind_callback(self, self.gc_sync_kuikuliya_top_list);
    self.bindfunc["gc_kuikuliya_get_climb_reward"] = Utility.bind_callback(self, self.gc_kuikuliya_get_climb_reward);
    self.bindfunc["gc_sync_all_floor"] = Utility.bind_callback(self, self.gc_sync_all_floor);
    self.bindfunc["gc_sync_kuikuliya_data_myself"] = Utility.bind_callback(self, self.gc_sync_kuikuliya_data_myself);
end

function KuiKuLiYaHurdleUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
    -- PublicFunc.msg_regist(msg_activity.gc_reset_kuikuliya,self.bindfunc['gc_reset_kuikuliya']);
    -- PublicFunc.msg_regist(msg_activity.gc_kuikuliya_Get_saodang_reward,self.bindfunc['gc_kuikuliya_Get_saodang_reward']);
	PublicFunc.msg_regist(msg_activity.gc_sync_kuikuliya_top_list,self.bindfunc['gc_sync_kuikuliya_top_list'])
    PublicFunc.msg_regist(msg_activity.gc_kuikuliya_get_climb_reward,self.bindfunc['gc_kuikuliya_get_climb_reward']);
    PublicFunc.msg_regist(msg_activity.gc_sync_all_floor,self.bindfunc['gc_sync_all_floor']);
    PublicFunc.msg_regist(msg_activity.gc_sync_kuikuliya_data_myself,self.bindfunc['gc_sync_kuikuliya_data_myself']);
end

--注销消息分发回调函数
function KuiKuLiYaHurdleUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_get_box_reward,self.bindfunc['gc_kuikuliya_get_box_reward']);
    -- PublicFunc.msg_unregist(msg_activity.gc_reset_kuikuliya,self.bindfunc['gc_reset_kuikuliya']);
    -- PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_Get_saodang_reward,self.bindfunc['gc_kuikuliya_Get_saodang_reward']);
	PublicFunc.msg_unregist(msg_activity.gc_sync_kuikuliya_top_list,self.bindfunc['gc_sync_kuikuliya_top_list'])
    PublicFunc.msg_unregist(msg_activity.gc_kuikuliya_get_climb_reward,self.bindfunc['gc_kuikuliya_get_climb_reward']);
    PublicFunc.msg_unregist(msg_activity.gc_sync_all_floor,self.bindfunc['gc_sync_all_floor']);
    PublicFunc.msg_unregist(msg_activity.gc_sync_kuikuliya_data_myself,self.bindfunc['gc_sync_kuikuliya_data_myself']);
end

function KuiKuLiYaHurdleUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.btnMonster = ngui.find_button(self.ui, "centre_other/animation/btn1");
    self.btnMonster:set_on_click(self.bindfunc["on_btn_click_monster"]);
    self.btnGoods = ngui.find_button(self.ui, "centre_other/animation/btn2");
    self.btnGoods:set_on_click(self.bindfunc["on_btn_click_goods"]);

    self.labTimes = ngui.find_label(self.ui, "down_other/animation/lab1/lab_num");
    -- self.spArrows = self.ui:get_child_by_name("centre_other/animation/sp_arrows");
    self.spMark1 = ngui.find_sprite(self.ui,"centre_other/animation/so_mengban1");
    self.spMark1:set_position(constTopPos.x,constTopPos.y,constTopPos.z);
    self.spMark2 = ngui.find_sprite(self.ui,"centre_other/animation/so_mengban2");
    self.spMark2:set_position(constBottomPos.x,constBottomPos.y,constBottomPos.z);

    self.pro = ngui.find_progress_bar(self.ui, "centre_other/animation/cont1/pro_di");
    local btnRank = ngui.find_button(self.ui, "top_other/animation/btn_ranklist");
    btnRank:set_on_click(self.bindfunc["on_btn_rank"]);
    --btnRank:set_active(false);
    
    local btnShop = ngui.find_button(self.ui, "top_other/animation/btn_shop");
    btnShop:set_on_click(self.bindfunc["on_btn_shop"]);
    btnShop:set_active(false)

    local btnGoods = ngui.find_button(self.ui, "top_other/animation/btn_award");
    btnGoods:set_on_click(self.bindfunc["on_btn_goods"]);
    self.spGoodsRed = ngui.find_sprite(self.ui,"top_other/animation/btn_award/animation/sp");
    self.spGoodsRed:set_active(false);
    self.btnReset = ngui.find_button(self.ui, "down_other/animation/btn2");
    self.btnReset:set_on_click(self.bindfunc["on_btn_reset_sweep"]);
    -- self.labCostBtn = ngui.find_label(self.ui, "down_other/animation/btn2/animation/lab");
    self.labCostNum = ngui.find_label(self.ui, "down_other/animation/lab2");
    self.spRed = ngui.find_sprite(self.ui,"down_other/animation/btn2/animation/sp_point");
    self.spRed:set_active(false);
    -- self.objBtnCost = self.ui:get_child_by_name("down_other/animation/btn2/animation/cont");
    self.labBtnReset = ngui.find_label(self.ui, "down_other/animation/btn2/animation/lab");
    -- self.spBtnReset = ngui.find_sprite(self.ui,"down_other/animation/btn2/animation/sp");
    local floorObj = self.ui:get_child_by_name("centre_other/animation/sp_di1");
    self.floorLabObj = ObjectPool:new({obj=floorObj});
    local objLab = self.ui:get_child_by_name("centre_other/animation/texture");
    -- self.floorLimitObj = ObjectPool:new({obj=objLab});
    self.objCanGetBox = self.ui:get_child_by_name("centre_other/animation/sp_down");
    self.objCanGetBox:set_active(false);
    self.floorLab = {};
    -- self.floorLimit = {};

    local lab = {};
    for i=1,4 do
        lab[i] = ngui.find_label(self.ui,"centre_other/animation/cont1/lab_"..i);
    end
    lab[4]:set_text(tostring(1));
    lab[3]:set_text(tostring(math.floor(self.maxFloor/3)));
    lab[2]:set_text(tostring(math.floor(self.maxFloor/3*2)));
    lab[1]:set_text(tostring(self.maxFloor));

    self.double_sp_di = self.ui:get_child_by_name("centre_other/animation/sp_di2");
    self.double_sp_di:set_active(false);
    self.double_text = ngui.find_label(self.ui, "centre_other/animation/sp_di2/lab");
    self.double_text:set_text("");
    self:UpdateSceneInfo();
end

function KuiKuLiYaHurdleUI:DestroyUi()
    if self.floorObj then
        self.floorObj:set_active(false);
        self.floorObj = nil;
    end
    Root.DelUpdate(self.Update);
    if self.Floor then
        for k,v in pairs(self.Floor) do
            self:_DeleteFloor(v);
        end
        self.Floor = nil;
    end
    if self.objFloor then
        for k,v in pairs(self.objFloor) do
            local obj = v:GetBase();
            obj:set_active(true);
            v:Destroy();
        end
        self.objFloor = nil;
    end
    if self.objFloor then
        for k,v in pairs(self.objFloor) do
            local obj = v:GetBase();
            obj:set_active(true);
            v:Destroy();
        end
        self.objFloor = nil;
    end
    -- if self.floorLimitObj then
    --     self.floorLimitObj:Destroy();
    --     self.floorLimitObj = nil;
    -- end
    if self.floorLabObj then
        self.floorLabObj:Destroy();
        self.floorLabObj = nil;
    end
    -- if self.floorObj then
    --     self.floorObj:Destroy();
    --     self.floorObj = nil;
    -- end
    if self.modelPlayer then
        self.modelPlayer:Destroy();
        self.modelPlayer = nil;
    end
    if self.dlgSweepUI then
        self.dlgSweepUI:DestroyUi();
        self.dlgSweepUI = nil;
    end
    if self.dlgSweepTimeUI then
        self.dlgSweepTimeUI:DestroyUi();
        self.dlgSweepTimeUI = nil;
    end
    if self.dlgSweepOverUI then
        self.dlgSweepOverUI:DestroyUi();
        self.dlgSweepOverUI = nil;
    end
    if self.fxArrows then
        EffectManager.deleteEffect(self.fxArrows:GetGID());
        self.fxArrows = nil;
    end
    UiBaseClass.DestroyUi(self);
end

function KuiKuLiYaHurdleUI:Hide()
    if self.floorObj then
        self.floorObj:set_active(false);
    end
    UiBaseClass.Hide(self);
end

function KuiKuLiYaHurdleUI:Show()
    if self.floorObj then
        self.floorObj:set_active(true);
    end
    UiBaseClass.Show(self);
end

function KuiKuLiYaHurdleUI:UpdateSceneInfo()
    if not self.ui or Utility.isEmpty(self.objFloor) then
        return;
    end
    if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_kuikuliya) then
        self.double_text:set_text("首次开启箱子,[fed440]奖励翻倍[-]");
        self.double_sp_di:set_active(true);
    end
    self:_UpdateBtn();
    self:_CreateAllFloor();
    self:_SetPlayer();
    self:_UpdateInfo();
    self:CheckSweepState();
end

function KuiKuLiYaHurdleUI:Update()
    if not self.ui then return end;
    local isRunningFloor = self:_UpdateFloor();
    local isRunningPlayer = self:_UpdatePlayer();
    self.isRunning = isRunningPlayer or isRunningFloor;
    if self.fxArrows then
        self.fxArrows:set_active(not self.isRunning);
    end
    self.spMark1:set_active(not isRunningFloor);
    self.spMark2:set_active(not isRunningFloor);
    self:_UpdateFloorLab();
end

-------------------private---------------
function KuiKuLiYaHurdleUI:_UpdatePlayer()
    if self.playerMove ~= 0 then
        local x,y,z = self.modelPlayer:GetLocalPosition();
        local tx,ty,tz = self.playerMoveTarget:get_local_position();
        if (x-tx)*self.playerMove < 0 then
            self.modelPlayer:SetLocalPosition(x+self.playerMove,y,z);
            return true;
        else
            self.playerMove = 0;
            self.modelPlayer:PlayAnim(EANI.stand);
            if self._movePlayerEndCallback then
                Utility.CallFunc(self._movePlayerEndCallback[1],self._movePlayerEndCallback[2]);
                self._movePlayerEndCallback = nil;
            end
            return false;
        end
    end
end

function KuiKuLiYaHurdleUI:_UpdateFloor()
    local flg = false;
    for k,v in pairs(self.Floor) do
        if v.isMove then
            if v.root then
                local x,y,z = v.root:get_position();
                if v.target.y >= y then
                    v.root:set_position(v.target.x, v.target.y, v.target.z);
                    v.isMove = false;
                else
                    v.root:set_position(x, y-constFloorMoveSpeed, z);
                end
            end
        else
            flg = true;
        end
    end
    if flg then
        if self._moveFloorEndCallback then
            Utility.CallFunc(self._moveFloorEndCallback[1],self._moveFloorEndCallback[2]);
            self._moveFloorEndCallback = nil;
        end
    end
    return not flg;
end

function KuiKuLiYaHurdleUI:_UpdateFloorLab()
    for k,v in pairs(self.Floor) do
        if not self.floorLab[k] then
            self.floorLab[k] = {};
            self.floorLab[k].root = self.floorLabObj:GetObject();
            self.floorLab[k].lab = ngui.find_label(self.floorLab[k].root,"lab_art_font");
            self.floorLab[k].labBuffDes = ngui.find_label(self.floorLab[k].root,"texture/lab");
            self.floorLab[k].texBuff = ngui.find_texture(self.floorLab[k].root,"texture");
            self.floorLab[k].objBk = self.floorLab[k].root:get_child_by_name("sp_bar");
        end
        -- if not self.floorLimit[k] then
        --     self.floorLimit[k] = {};
        --     self.floorLimit[k].root = self.floorLimitObj:GetObject();
        --     self.floorLimit[k].labLimit = ngui.find_label(self.floorLimit[k].root,"lab");
        --     self.floorLimit[k].labFloor = ngui.find_label(self.floorLimit[k].root,"lab_cen");
        --     self.floorLimit[k].btn = ngui.find_button(self.floorLimit[k].root,self.floorLimit[k].root:get_name());
        --     self.floorLimit[k].btn:set_on_click(self.bindfunc["on_click_limit"]);
        -- end
        if v.posFloor then
            local x,y,z = v.posFloor:get_position();
            x,y,z = self:_3dTo2dPos(x,y,z);
            self.floorLab[k].root:set_active(true);
            self.floorLab[k].root:set_position(x,y,0);
            local curFloor = self.curFloor+k;
            local cfg = self.hurdleCfg[curFloor];
            if cfg.buff_sp and cfg.buff_sp ~=0 and k == 0 then
                local str = "";
                if cfg.buff_name and cfg.buff_name ~= 0 then
                    str = tostring(cfg.buff_name) .. " ";
                end
                if cfg.buff_des and cfg.buff_des ~= 0 then
                    str = str .. tostring(cfg.buff_des);
                end
                self.floorLab[k].labBuffDes:set_text(str);
                self.floorLab[k].texBuff:set_texture(cfg.buff_sp);
                self.floorLab[k].texBuff:set_active(true);
                self.floorLab[k].objBk:set_active(true);
            else
                self.floorLab[k].texBuff:set_active(false);
                self.floorLab[k].labBuffDes:set_text("");
                self.floorLab[k].objBk:set_active(false);
            end
            self.floorLab[k].lab:set_text(curFloor.."层");
        else
            self.floorLab[k].root:set_active(false);
        end
        if v.fxPos and k == 0 then
            if self.fxArrows and self.fxArrows.isActive then
                self.fxArrows:set_position(v.fxPos:get_position());
            end
        end
        if v.posMonster and k == 0 then
            local x,y,z = v.posMonster:get_position();
            x,y,z = self:_3dTo2dPos(x,y,z);
            self.btnMonster:get_game_object():set_position(x,y,0);
            x,y,z = self.btnMonster:get_position();
            self.btnMonster:set_position(x,y+100,0);
        end
        if v.posGoods and k == 0 then
            local x,y,z = v.posGoods:get_position();
            x,y,z = self:_3dTo2dPos(x,y,z);
            self.btnGoods:get_game_object():set_position(x,y,0);
            x,y,z = self.btnGoods:get_position();
            self.btnGoods:set_position(x,y+100,0);
        end
        -- if v.posLimit then
        --     local x,y,z = v.posLimit:get_position();
        --     x,y,z = self:_3dTo2dPos(x,y,z);
        --     local curFloor = self.curFloor+k;
        --     local cfg = self.hurdleCfg[curFloor];
        --     if cfg.level and cfg.level > g_dataCenter.player:GetLevel() then
        --     -- if cfg.level and cfg.level > 1 then
        --         self.floorLimit[k].root:set_position(x,y,0);
        --         self.floorLimit[k].root:set_active(true);
        --         self.floorLimit[k].labLimit:set_text("等级达到[FFF000FF]"..tostring(cfg.level).."级[-]可以挑战！");
        --         self.floorLimit[k].labFloor:set_text(tostring(curFloor).."层");
        --         self.floorLimit[k].btn:set_event_value("",cfg.level);
        --     else
        --         self.floorLimit[k].root:set_active(false);
        --     end
        -- else
        --     self.floorLimit[k].root:set_active(false);
        -- end
    end
end

function KuiKuLiYaHurdleUI:_IsSweep()
    if self.maxArriveFloor >= self.curFloor then
        if self.curFloor >= self.maxFloor then
            if self.curFloorData.bPass then
                return false;
            else
                return true;
            end
        else
            if self.playCfg:IsExLimit(self.curFloor+1) then
                return false;
            else
                return true;
            end
        end
    else
        return false;
    end
end

function KuiKuLiYaHurdleUI:_UpdateBtn()
    self.maxArriveFloor = self.playCfg:GetOpenFloor();
    if self.playCfg:CanReset() or self.playCfg:CanSweep() then
        self.spRed:set_active(true);
        self.labCostNum:set_active(true);
        PublicFunc.SetButtonShowMode(self.btnReset,1);
    else
        self.spRed:set_active(false);
        self.labCostNum:set_active(false);
        PublicFunc.SetButtonShowMode(self.btnReset,3);
    end
    if self.playCfg:CanSweep() then
        self.labBtnReset:set_text("扫荡");
        self.labCostNum:set_active(false);
    else
        if self.playCfg:CanFreeReset() then
            self.labBtnReset:set_text("重置");
            self.labCostNum:set_text("0")
        else
            self.labBtnReset:set_text("重置");
            self.labCostNum:set_text(""..self.playCfg:GetBuyTimesCost())
        end
    end
    if self.playCfg:CanGetClimbReward() then
        self.spGoodsRed:set_active(true);
    else
        self.spGoodsRed:set_active(false);
    end
    if self.curFloorData.bPass and not self.curFloorData.isGetBox then
        self.objCanGetBox:set_active(true);
    else
        self.objCanGetBox:set_active(false);
    end
end

function KuiKuLiYaHurdleUI:_FindFloor()
    self.objFloor = {};
    local obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan07");
    self.objFloor[0] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan01");
    self.objFloor[1] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan02");
    self.objFloor[2] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan03");
    self.objFloor[3] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan04");
    self.objFloor[4] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan05");
    self.objFloor[5] = ObjectPool:new({obj=obj});
    obj = asset_game_object.find("70000055_jixiantiaozhan/F_jixiantiaozhan06");
    self.objFloor[6] = ObjectPool:new({obj=obj});
end

function KuiKuLiYaHurdleUI:_SetPlayer()
    local curFloor = self.Floor[0];
    local pos = nil;
    if self.curFloorData.bPass then
        pos = curFloor.posEnd;
    else
        pos = curFloor.posBorn;
    end
    if not self.modelPlayer then
        self.modelPlayer = ShowRole:new();
    end
    local team = g_dataCenter.player:GetDefTeam();
    local modelID = g_dataCenter.package:find_card(1,team[1]).model_id;
    self.modelPlayer:ChangeObjByModelID(modelID);
    self.modelPlayer:SetParent(curFloor.root);
    self.modelPlayer:SetLocalPosition(pos:get_local_position());
    self.modelPlayer:SetRotation(0, -90, 0);
    self.modelPlayer:ShowObj(true);
    self.modelPlayer:SetScale(constPlayerSize,constPlayerSize,constPlayerSize);
end

function KuiKuLiYaHurdleUI:_Update3D()
    for i=-1,2,1 do
        local info = self.hurdleCfg[self.curFloor+i];
        if self.Floor[i+1] == nil then
            self.Floor[i] = {};
            self.Floor[i].monster = ShowRole:new();
            self.Floor[i].monster:SetScale(constMonsterSize,constMonsterSize,constMonsterSize);
            if info then
                local obj = self.objFloor[info.floor_type]:GetObject();
                self.Floor[i].root = obj;
                self.Floor[i].posBorn = obj:get_child_by_name("chusheng");
                self.Floor[i].posEnd = obj:get_child_by_name("zhongdian");
                self.Floor[i].posMonster = obj:get_child_by_name("guai");
                self.Floor[i].posGoods = obj:get_child_by_name("baoxiang");
                self.Floor[i].posFloor = obj:get_child_by_name("cengshu");
                self.Floor[i].posLimit = obj:get_child_by_name("dengji");
                self.Floor[i].fxPos = obj:get_child_by_name("point_fx");
                self.Floor[i].type = info.floor_type;
                self.Floor[i].isMove = false;

                local data = self.playCfg:GetFloorData(self.curFloor+i);

                if info.monster_id ~= 0 and (not data or not data.bPass) then
                    self.Floor[i].monster:SetParent(self.Floor[i].posMonster);
                    self.Floor[i].monster:ChangeObjByModelID(info.monster_id);
                    self.Floor[i].monster:SetLocalPosition(0,0,0);
                    self.Floor[i].monster:ShowObj(true);
                else
                    self.Floor[i].monster:ShowObj(false);
                end

                if info.goods_id ~= 0 and (not data or (not data.isGetBox or not data.bPass)) then
                    if self.Floor[i].goods then
                        for id,v in pairs(self.Floor[i].goods) do
                            EffectManager.deleteEffect(id);
                        end
                    end
                    self.Floor[i].goods = {};
                    local cfg = ConfigManager.Get(EConfigIndex.t_effect_data,info.goods_id);
                    local ids = FightScene.CreateEffect({x=0,y=0,z=0}, cfg, nil, nil, nil, nil, 0, nil, nil, nil)
                    for k,id in pairs(ids) do
                        self.Floor[i].goods = {};
                        self.Floor[i].goods[id] = EffectManager.GetEffect(id);
                        self.Floor[i].goods[id]:set_parent(self.Floor[i].posGoods);
                        self.Floor[i].goods[id]:set_local_position(0,0,0);
                        self.Floor[i].goods[id]:set_local_scale(constEffectSize,constEffectSize,constEffectSize);
                    end
                    -- self.Floor[i].goods:SetParent(self.Floor[i].posGoods);
                    -- self.Floor[i].goods:ChangeObjByModelID(info.goods_id);
                    -- self.Floor[i].goods:SetLocalPosition(0,0,0);
                    -- self.Floor[i].goods:ShowObj(true);
                else
                    if self.Floor[i].goods then
                        for k,v in pairs(self.Floor[i].goods) do
                            v:set_active(false);
                        end
                    end
                    if 0 == i then
                        self.objCanGetBox:set_active(false);
                    end
                end
            else
                self.Floor[i].monster:ShowObj(false);
                if self.Floor[i].goods then
                    for k,v in pairs(self.Floor[i].goods) do
                        v:set_active(false);
                    end
                end
                self.Floor[i].type = 0;
                self.Floor[i].isMove = false;
            end
        else
            if self.Floor[i-1] == nil then
                -- self.objFloor[self.Floor[i].type]:DestroyObject(self.Floor[i].root);
                self:_DeleteFloor(self.Floor[i]);
            end
            self.Floor[i] = self.Floor[i+1];
        end
        if self.Floor[i].root then
            self.Floor[i].root:set_position(self.defPos.x,self.defPos.y+constFloorHeight*i,self.defPos.z);
        end
    end
end

function KuiKuLiYaHurdleUI:_CreateAllFloor()
    if self.Floor then
        for k,v in pairs(self.Floor) do
            self:_DeleteFloor(v);
        end
    end
    self.Floor = {};
    self:_Update3D();
end

function KuiKuLiYaHurdleUI:_DeleteFloor(floor)
    if floor.monster then
        floor.monster:Destroy();
        floor.monster = nil;
    end
    if floor.goods then
        for id,v in pairs(floor.goods) do
            EffectManager.deleteEffect(id);
        end
    end
    if floor.hero then
        floor.hero:Destroy();
        floor.hero = nil;
    end
    if floor.root then
        self.objFloor[floor.type]:DestroyObject(floor.root);
        floor.root = nil;
    end
end

function KuiKuLiYaHurdleUI:_3dTo2dPos(px,py,pz)
    if self.camera then
        local view_x, view_y, view_z = self.camera:world_to_screen_point(px,py,pz);
        local ui_x, ui_y, ui_z = self.cameraUi:screen_to_world_point(view_x, view_y, view_z);
        return ui_x, ui_y, ui_z;
    else
        app.log_warning("#KuiKuLiYaHurdleUI# self.camera 为 nil");
        return 0,0,0;
    end
end

function KuiKuLiYaHurdleUI:_UpdateInfo()
    if not self.ui then
        return;
    end
    self.pro:set_value(self.curFloor/self.maxFloor);
    local curTimes = self.playCfg:GetTimes();
    local maxTimes = self.playCfg:GetTotalTimes();
    self.labTimes:set_text(curTimes.."/"..maxTimes)
end

function KuiKuLiYaHurdleUI:_PlayNextFloor(end_callback, param)
    if self.hurdleCfg[self.curFloor+1] then
        for k,v in pairs(self.Floor) do
            v.target = {x=self.defPos.x, y=self.defPos.y+constFloorHeight*(k-1), z=self.defPos.z};
            v.isMove = true;
        end
        if end_callback then
            self._moveFloorEndCallback = {end_callback, param};
        end
    end
end

function KuiKuLiYaHurdleUI:_PlayPlayer2EndPos(end_callback, param)
    self.playerMoveTarget = self.Floor[0].posEnd;
    self.playerMove = -constPlayerMoveSpeed;
    self.modelPlayer:PlayAnim(EANI.run);
    if end_callback then
        self._movePlayerEndCallback = {end_callback, param};
    end
end

function KuiKuLiYaHurdleUI:_PlayPlayer2BornPos(end_callback, param)
    self.playerMoveTarget = self.Floor[0].posBorn;
    self.playerMove = constPlayerMoveSpeed;
    self.modelPlayer:SetRotation(0, 90, 0);
    self.modelPlayer:PlayAnim(EANI.run);
    if end_callback then
        self._movePlayerEndCallback = {end_callback, param};
    end
end
------------------callback---------------

function KuiKuLiYaHurdleUI:on_load_camera(pid, filepath, asset_obj, error_info)
    if camRes == filepath then
        self.floorObj = asset_game_object.create(asset_obj);
        self.floorObj:set_name("70000055_jixiantiaozhan")
        self.camera = camera.find_by_name("s054_scenecamera_01");
        Root.AddUpdate(self.Update,self);

        self:_FindFloor();
        self.fxArrows = EffectManager.createEffect(1800083);
        UiBaseClass.LoadUI(self);
    end
end

function KuiKuLiYaHurdleUI:on_btn_rank()
    --uiManager:PushUi(EUI.KuiKuLiYaRankUI)
	self.loadingId = GLoading.Show(GLoading.EType.ui);
	msg_activity.cg_request_kuikuliya_top_list(1)
 end
 
function KuiKuLiYaHurdleUI:gc_sync_kuikuliya_top_list(result, beginIndex, list)
	self.rankList = self.rankList or {}
    if list then
        for i, v in ipairs(list) do
            table.insert(self.rankList, KklyRankPlayer:new(v))
        end
    end
    if result == 0 then
        msg_activity.cg_request_kuikuliya_top_list(beginIndex + 10)
    elseif result == 1 then
		if #self.rankList == 0 then 
			GLoading.Hide(GLoading.EType.ui, self.loadingId);
			FloatTip.Float("当前还没有排行榜数据");
			do return end;
		end 
		--app.log("self.rankList = "..table.tostring(self.rankList));
        -- 鏁版嵁鏍煎紡杞¬鎹㈠埌RankPlayer
        local viewData = {}
		local my_rank = {
			ranking = 0;
			playerid = g_dataCenter.player.playerid;
			name = g_dataCenter.player.name;
			param2 = g_dataCenter.player.vip;
			level = g_dataCenter.player.level;
			iconsid = g_dataCenter.player.image;
			num = 0;
		};
		--app.log("KuiKuLiYa RANK "..table.tostring(self.rankList));
        for i, v in ipairs(self.rankList) do
			
            local rankPlayer = {}
            rankPlayer.playerid = v.playerid
            rankPlayer.name = v.playerName
            rankPlayer.num = v.point    --绉¯鍒
            rankPlayer.ranking = v.ranking
			rankPlayer.param2 = v.vipLevel;
			rankPlayer.guildName = v.guildName;
			rankPlayer.iconsid = v.image or 0;
			rankPlayer.level = v.playerLevel or "--";
            --[[rankPlayer.heroCids = {}

            for j, card in ipairs(v.heroCards) do
                table.insert(rankPlayer.heroCids, card.number)
            end--]]
            if g_dataCenter.player.playerid == v.playerid then 
				my_rank.ranking = rankPlayer.ranking;
				my_rank.num = rankPlayer.num;
			end 
            table.insert(viewData, rankPlayer)
        end
		if g_dataCenter.guild.detail ~= nil and g_dataCenter.guild.detail.id ~= "0" then 
			my_rank.guildName = g_dataCenter.guild.detail.name;
		else 
			my_rank.guildName = "";
		end
		viewData.my_rank = my_rank;
		RankPopPanel.popPanel(viewData,RANK_TYPE.KUIKULIYA);
		self.rankList = {};
		GLoading.Hide(GLoading.EType.ui, self.loadingId);
    end
end 

function KuiKuLiYaHurdleUI:on_btn_shop()
    g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.KKLY);
end

function KuiKuLiYaHurdleUI:on_btn_goods()
    uiManager:PushUi(EUI.KuiKuLiYaAwardUI);
end

function KuiKuLiYaHurdleUI:on_btn_reset_sweep()
    if self.isRunning then return; end
    if self.playCfg:CanSweep() then
        self:on_btn_sweep();
    else
        self:on_btn_reset();
    end
end

function KuiKuLiYaHurdleUI:on_btn_reset()
    if self.playCfg:GetCanBuyTimes() > 0 or self.playCfg:GetTimes() > 0 then
        if self.curFloorData.bPass and not self.curFloorData.isGetBox then
            FloatTip.Float("您有宝箱未领取，请先领取后再重置。");
            return;
        end
        local str = "是否重置？重置后将返回第一层";
        local title = "重置";
        local btn1 = {};
        btn1.str = "确定";
        btn1.func = function ()
            if self.playCfg:CanFreeReset() then
                msg_activity.cg_reset_kuikuliya(0);
            else
                if self.playCfg:GetBuyTimesCost() > g_dataCenter.player.crystal then
                    HintUI.SetAndShowNew(EHintUiType.two,
                    "充值",
                    "您的剩余钻石数量不足\n是否前往充值？",
                    nil,
                    {str = "确定",func = function()
                        uiManager:PushUi(EUI.StoreUI);
                    end },
                    {str = "取消"});
                else
                    msg_activity.cg_reset_kuikuliya(1);
                end
            end
        end
        local btn2 = {};
        btn2.str = "取消";
        HintUI.SetAndShowHybrid(2, title, str, nil, btn1, btn2);
    else
        local max_vip = g_dataCenter.player:GetVipMax();
        local vip_cfg = ConfigManager.Get(EConfigIndex.t_vip_data,max_vip);
        local max_vip_times = vip_cfg.kuikuliya_buy_times;
        if self.playCfg:GetVipBuyTimes() >= max_vip_times then
            FloatTip.Float("今日重置次数已用完");
        else
            HintUI.SetAndShowHybrid(2, "重置次数", 
                "今日重置次数已用完，提升董香好感度\n可增加重置次数，是否前往董香之屋？", nil, 
                {func=function ()
                    uiManager:PushUi(EUI.VipPackingUI);
                end, str="确定"}, 
                {str="取消"});
        end
    end
end

function KuiKuLiYaHurdleUI:on_btn_sweep()
    -- local str = "扫荡前"..self.maxArriveFloor.."层可以立即获得奖励";
    -- local btn1 = {};
    -- btn1.func = function ()
    --     msg_activity.cg_saodang_kuikuliya();
    -- end
    -- btn1.str = "确定"
    -- local btn2 = {};
    -- btn2.str = "取消";
    -- HintUI.SetAndShowNew(2,"扫荡",str,nil,btn1,btn2);
    if self.dlgSweepUI == nil then
        self.dlgSweepUI = KuiKuLiYaSweepDlgUI:new();
    end
    local data = 
    {
        floor = self.maxArriveFloor,
        closeCallback = function ()
            self.dlgSweepUI:DestroyUi();
            self.dlgSweepUI = nil;
            self:CheckSweepState();
        end,
        completeCallback = function ()
            self.dlgSweepUI:DestroyUi();
            self.dlgSweepUI = nil;
            self:gc_reset_kuikuliya();
        end
    }
    self.dlgSweepUI:SetData(data);
end

function KuiKuLiYaHurdleUI:CheckSweepState()
    if self.ui == nil then return end;
    local time = self.playCfg:GetSweepStartTime() or 0;
    if time == 0 then
        return;
    end
    local totalTime = 0;
    for i=self.playCfg:GetOpenFloor(),1,-1 do
        local cfg = self.hurdleCfg[i];
        totalTime = totalTime + cfg.saodang_time;
    end
    if system.time()-time < totalTime then
        if self.dlgSweepTimeUI == nil then
            self.dlgSweepTimeUI = KuiKuLiYaSweepTimeUI:new();
        end
        local data = 
        {
            closeCallback = function ()
                if self.dlgSweepTimeUI then
                    self.dlgSweepTimeUI:DestroyUi();
                    self.dlgSweepTimeUI = nil;
                end
                self:gc_reset_kuikuliya();
            end,
            timerOverCallback = function ()
                if self.dlgSweepTimeUI then
                    self.dlgSweepTimeUI:DestroyUi();
                    self.dlgSweepTimeUI = nil;
                end
                self:CheckSweepState();
            end
        }
        self.dlgSweepTimeUI:SetData(data);
        if self.dlgSweepOverUI then
            self.dlgSweepOverUI:DestroyUi();
            self.dlgSweepOverUI = nil;
        end
    else
        if self.dlgSweepOverUI == nil then
            self.dlgSweepOverUI = KuiKuLiYaSweepOverUI:new();
        end
        local data = 
        {
            closeCallback = function ()
                if self.dlgSweepOverUI then
                    self.dlgSweepOverUI:DestroyUi();
                    self.dlgSweepOverUI = nil;
                end
                self:gc_reset_kuikuliya();
            end
        }
        self.dlgSweepOverUI:SetData(data);
        if self.dlgSweepTimeUI then
            self.dlgSweepTimeUI:DestroyUi();
            self.dlgSweepTimeUI = nil;
        end
    end
end

function KuiKuLiYaHurdleUI:on_btn_click_monster()
    if self.isRunning then return ; end
    if self.playCfg:IsExLimit(self.curFloor) then
        local curFloor = self.curFloor;
        local cfg = self.hurdleCfg[curFloor];
        FloatTip.Float("等级达到"..cfg.level.."级可挑战！");
        return;
    end
    if self.playCfg:CanSweep() then
        self:on_btn_sweep();
        return;
    end
    if not self.curFloorData.bPass then
        self:_PlayPlayer2EndPos(
            function ()
                local ui = uiManager:PushUi(EUI.KuiKuLiYaHurdleInfoUI);
                ui:SetLevel(self.curFloor);
            end
            );
    end
end

function KuiKuLiYaHurdleUI:on_btn_click_goods()
    if self.isRunning then return ; end
    if self.curFloorData.bPass and not self.curFloorData.isGetBox then
        -- local ui = uiManager:PushUi(EUI.KuiKuLiYaOpenBoxUI);
        msg_activity.cg_kuikuliya_get_box_reward(0,self.curFloor,1);
        self.loadingId = GLoading.Show(GLoading.EType.ui);
    end
    -- self.playCfg:SetCnt(0,0,self.curFloor)
    -- self:_PlayPlayer2BornPos(
    --     function ()
    --         self:_PlayNextFloor(
    --             function ()
    --                 self.curFloor = self.playCfg:GetOpenFloor();
    --                 self:_Update3D();
    --                 self:_SetPlayer();
    --             end
    --             )
    --     end
    --     )
end

function KuiKuLiYaHurdleUI:on_click_limit(t)
    local level = t.float_value;
    FloatTip.Float("等级达到"..level.."级可挑战！");
end

---------------------message-------------
function KuiKuLiYaHurdleUI:gc_kuikuliya_get_box_reward(result,ntype,nfloor,openTimes,reward)
    GLoading.Hide(GLoading.EType.ui, self.loadingId);
    if ntype == 0 then
        local animfunc = function ()
            self.objCanGetBox:set_active(false);
            local _floor,_data = self.playCfg:GetCurFloor();
            if _floor <= self.maxFloor and not _data.bPass then
                self:_PlayPlayer2BornPos(
                    function ()
                        self.modelPlayer:ShowObj(false);
                        self:_PlayNextFloor(
                            function ()
                                self.curFloor,self.curFloorData = self.playCfg:GetCurFloor();
                                self:_Update3D();
                                self:_SetPlayer();
                                self:_UpdateBtn();
                                self:_UpdateInfo();
                            end
                            )
                    end
                    )
            else
                self.curFloor,self.curFloorData = self.playCfg:GetCurFloor();
            end
        end
        local callback = function ()
            uiManager:PopUi();
            animfunc();
        end
        for k,v in pairs(self.Floor[0].goods) do
            v:set_active(false);
        end
        -- 双倍
        for k,v in pairs(reward) do
            reward[k].double_radio = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.kuikuliya, v.id);
        end
        self.double_text:set_text("");
        self.double_sp_di:set_active(false);
        if g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_double_kuikuliya) then
            self.double_text:set_text("首次开启箱子,[fed440]奖励翻倍[-]");
            self.double_sp_di:set_active(true);
        end
        CommonAward.Start(reward);
        CommonAward.SetFinishCallback(
            function ()
                local cfg = self.hurdleCfg[self.curFloor];
                if cfg.byCanPayOpenBox == nil or cfg.byCanPayOpenBox == 1 then
                    local ui = uiManager:PushUi(EUI.KuiKuLiYaOpenBoxUI);
                    ui:SetFloor(self.curFloor);
                    ui:SetCallback(callback);
                else
                    Utility.CallFunc(animfunc);
                end
            end
            )
    end
end

function KuiKuLiYaHurdleUI:gc_reset_kuikuliya(result)
    self.curFloor,self.curFloorData = self.playCfg:GetCurFloor();
    self:UpdateSceneInfo();
end

-- function KuiKuLiYaHurdleUI:gc_kuikuliya_Get_saodang_reward(result,vecReward)
--     local reward = {};
--     for k,v in pairs(vecReward) do
--         reward[v.id] = (reward[v.id] or 0) + v.count;
--     end
--     vecReward = {};
--     local ratio_num = 1;
--     for id,count in pairs(reward) do
--         ratio_num = g_dataCenter.activityReward:GetDoubleByID(ENUM.Double.kuikuliya, id);         
--         vecReward[#vecReward+1] = {id=id,count=count,double_radio=ratio_num};
--     end
--     CommonAward.Start(vecReward);
--     CommonAward.SetFinishCallback(
--         function ()
--             self:gc_reset_kuikuliya();
--             local sweepBoxFloor = {};
--             for i=1,self.playCfg:GetOpenFloor() do
--                 local cfg = self.hurdleCfg[i];
--                 if cfg.byCanPayOpenBox == nil or cfg.byCanPayOpenBox == 1 then
--                     sweepBoxFloor[#sweepBoxFloor+1] = i;
--                 end
--             end
--             if #sweepBoxFloor ~= 0 then
--                 local ui = uiManager:PushUi(EUI.KuiKuLiYaSweepUI);
--             end
--         end
--         )
-- end

function KuiKuLiYaHurdleUI:gc_kuikuliya_get_climb_reward()
    self:_UpdateBtn();
end

function KuiKuLiYaHurdleUI:gc_sync_all_floor()
    self.curFloor,self.curFloorData = self.playCfg:GetCurFloor();
    self:UpdateSceneInfo();
end

function KuiKuLiYaHurdleUI:gc_sync_kuikuliya_data_myself()
    self:CheckSweepState();
end

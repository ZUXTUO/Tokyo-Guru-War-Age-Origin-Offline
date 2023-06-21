UiLevelBox = Class('UiLevelBox', UiBaseClass);

-- 初始化
function UiLevelBox:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/level/ui_703_level.assetbundle';
    UiBaseClass.Init(self, data)
end

-- 重新开始
function UiLevelBox:Restart(data)
    if data then
        self.nType = data.nType;        --奖励类型 1关卡宝箱奖励 2章节宝箱奖励
        self.hurdleid = data.hurdleid;
        self.groupid = data.groupid;
        self.index = data.index;
    end
    UiBaseClass.Restart(self, data)
end
-- 析构函数
function UiLevelBox:DestroyUi()
    if self.cloneItem then
        for k, v in pairs(self.cloneItem) do
            v:DestroyUi();
        end
        self.cloneItem = nil;
    end
    UiBaseClass.DestroyUi(self)
    PublicFunc.ClearUserDataRef(self)
end

-- 注册回调函数
function UiLevelBox:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['OnBtnClick'] = Utility.bind_callback(self, UiLevelBox.OnBtnClick);
    self.bindfunc['OnBtnClose'] = Utility.bind_callback(self, UiLevelBox.OnBtnClose);
    self.bindfunc['ShowAwards'] = Utility.bind_callback(self, UiLevelBox.ShowAwards);
end

-- 消息注册
function UiLevelBox:MsgRegist()
    UiBaseClass.MsgRegist(self)
    PublicFunc.msg_regist(msg_hurdle.gc_hurlde_box, self.bindfunc['ShowAwards']);
    PublicFunc.msg_regist(msg_hurdle.gc_take_award, self.bindfunc['ShowAwards']);
end

function UiLevelBox:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    PublicFunc.msg_unregist(msg_hurdle.gc_hurlde_box, self.bindfunc['ShowAwards']);
    PublicFunc.msg_unregist(msg_hurdle.gc_take_award, self.bindfunc['ShowAwards']);
end

-- 寻找ngui对象
function UiLevelBox:InitUI(asset_obj)
    -- 屏幕适配：锚点对齐
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_local_position(0, 0, 0);
    self.ui:set_name('ui_703_level');

    self.labTitle = ngui.find_label(self.ui, "lab_title");
    self.objContition1 = self.ui:get_child_by_name("cont1");
    self.objContition2 = self.ui:get_child_by_name("cont2");
    self.labContition1 = ngui.find_label(self.objContition1, "txt");
    self.labContition2 = ngui.find_label(self.objContition2, "lab_num");
    self.labBtn = ngui.find_label(self.ui, "btn/animation/lab");
    self.spAlreadyGet = ngui.find_sprite(self.ui, "sp_art_font");
    self.btn = ngui.find_button(self.ui, "btn");
    self.btn:set_on_click(self.bindfunc['OnBtnClick']);
    self.spBtn = ngui.find_sprite(self.ui, "btn/animation/sprite_background");
    self.grid = ngui.find_grid(self.ui, "grid");
    self.objItem = {};
    self.cloneItem = {};
    for i = 1, 4 do
        self.objItem[i] = self.ui:get_child_by_name("new_small_card_item"..i);
        self.cloneItem[i] = UiSmallItem:new({obj = nil, parent = self.objItem[i], cardInfo = nil, is_enable_goods_tip = true});
    end
    self.btnClose = ngui.find_button(self.ui, "btn_cha");
    self.btnClose:set_on_click(self.bindfunc['OnBtnClose']);
    self:UpdateUi();
end
-- 更新ui
function UiLevelBox:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    local dropId = 0;
    local alreadyGet = false;
    local canGet = false;
    local totalStar = 0;
    local maxStar = 0;
    if self.nType == 1 then
        local hurdleCf = ConfigHelper.GetHurdleConfig(self.hurdleid);
        if not hurdleCf then
            return;
        end
        dropId = hurdleCf.box_dropid;
        local info = g_dataCenter.hurdle:GetHurdleByHurdleid(self.hurdleid);
        if info then
            canGet = true;
            if info.box_state == 1 then
                alreadyGet = true;
            end
        end
        self.labTitle:set_text(gs_misc['str_60']);
        self.labContition1:set_text(string.format(gs_misc['str_62'], hurdleCf.index, hurdleCf.name));
        -- self.spContition:set_active(false);
        self.objContition1:set_active(true);
        self.objContition2:set_active(false);
    elseif self.nType == 2 then
        dropId = g_dataCenter.hurdle:GetGroupDropId(self.groupid, self.index);
        canGet, totalStar, maxStar = g_dataCenter.hurdle:IsCanGetGroupAwards(self.groupid, self.index);
        alreadyGet = g_dataCenter.hurdle:IsAlreadyGetGroupAwards(self.groupid, self.index);
        self.labTitle:set_text(gs_misc['str_61']);
        self.labContition2:set_text("[00F6FFFF]"..totalStar.."[-]/"..maxStar);
        -- self.spContition:set_active(true);
        self.objContition1:set_active(false);
        self.objContition2:set_active(true);
    end

    self.spAlreadyGet:set_active(alreadyGet);
    -- self.btn:set_active(not alreadyGet);
    self.btn:set_active(false);
    if alreadyGet then
        self.spBtn:set_color(0,0,0,1);
    else
        self.spBtn:set_color(1,1,1,1);
    end
    if alreadyGet or canGet then
        self.labBtn:set_text(gs_misc['str_64']);
    else
        self.labBtn:set_text(gs_misc['str_63']);
    end
    local cf = ConfigManager.Get(EConfigIndex.t_drop_something,dropId);
    if cf then
        for i = 1, 4 do
            if cf[i] then
                self.objItem[i]:set_active(true);
                self.cloneItem[i]:SetDataNumber(cf[i].goods_id, cf[i].goods_number);
            else
                self.objItem[i]:set_active(false);
            end
        end
        self.grid:reposition_now();
    else
        app.log("UiLevelBox dropid error "..dropId);
    end

    if alreadyGet then
        self.btnState = 1     --已领取状态
    elseif canGet then
        self.btnState = 2     --可领取状态
    else
        self.btnState = 3     --关闭状态
    end
end

function UiLevelBox:OnBtnClick(t)
    if self.btnState == 1 then
        FloatTip.Float(gs_misc['str_65']);
    elseif self.btnState == 2 then
        if self.nType == 1 then
            msg_hurdle.cg_hurlde_box(self.hurdleid);
        elseif self.nType == 2 then
            msg_hurdle.cg_take_award(self.groupid, self.index);
        end
    else
        self:OnBtnClose(t);
    end
end

function UiLevelBox:OnBtnClose(t)
    uiManager:PopUi();
end

function UiLevelBox:ShowAwards(drop_items)
   self:OnBtnClose();
end
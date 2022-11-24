UiEquipForgeChoseEquip = Class('UiEquipForgeChoseEquip', UiBaseClass);

local MAX_WAIT_TIME = 15;
--初始化
function UiEquipForgeChoseEquip:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/equip_forge/ui_3102_forge.assetbundle';
    UiBaseClass.Init(self, data);
end

--重新开始
function UiEquipForgeChoseEquip:Restart(data)
    self.chose_side_right = true;
    self.begin_time = system.time();
    self.hava_send_msg = false;
    self.return_equip = nil;
    self.return_gold = nil;
    self.return_stone = nil;
    if data then
        self.old_equip_info = data.old_equip_info;
        self.new_equip_info = data.new_equip_info;
    end
    self.lab_left = {};
    self.lab_right = {};
    if UiBaseClass.Restart(self, data) then
	--todo 各自额外的逻辑
	end
end

--初始化数据
function UiEquipForgeChoseEquip:InitData(data)
    UiBaseClass.InitData(self, data);
	--self.cardInfo = nil;
end

--析构函数
function UiEquipForgeChoseEquip:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.hava_send_msg = false;
    if self.texture_left then
        self.texture_left:Destroy();
        self.texture_left = nil;
    end
    if self.texture_right then
        self.texture_right:Destroy();
        self.texture_right = nil;
    end
    self.return_equip = nil;
    self.return_gold = nil;
    self.return_stone = nil;
    self.lab_left = {};
    self.lab_right = {};
 --    if self.sim1 then
	--     self.sim1:DestroyUi();
	--     self.sim1 = nil;
	-- end
	-- if self.sim2 then
	--     self.sim2:DestroyUi();
	--     self.sim2 = nil;
	-- end
end

--注册回调函数
function UiEquipForgeChoseEquip:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['on_sure'] = Utility.bind_callback(self,self.on_sure);
    self.bindfunc['on_btn_left'] = Utility.bind_callback(self,self.on_btn_left);
    self.bindfunc['on_btn_right'] = Utility.bind_callback(self,self.on_btn_right);
    self.bindfunc['init_item_wrap_content_left'] = Utility.bind_callback(self,self.init_item_wrap_content_left);
    self.bindfunc['init_item_wrap_content_right'] = Utility.bind_callback(self,self.init_item_wrap_content_right);
    self.bindfunc['gc_casting_result_select_ret'] = Utility.bind_callback(self,self.gc_casting_result_select_ret);
end

--注册消息分发回调函数
function UiEquipForgeChoseEquip:MsgRegist()
	UiBaseClass.RegistFunc(self);
    PublicFunc.msg_regist(msg_cards.gc_casting_result_select_ret,self.bindfunc['gc_casting_result_select_ret']);
end

--注销消息分发回调函数
function UiEquipForgeChoseEquip:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_casting_result_select_ret,self.bindfunc['gc_casting_result_select_ret']);
end

--寻找ngui对象
function UiEquipForgeChoseEquip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_equip_forge_chose_equip');

	--do return end
    ----------------
    self.btn_sure = ngui.find_button(self.ui, "centre_otehr/animation/content/btn_sure");
    self.btn_sure:set_on_click(self.bindfunc["on_sure"]);
    self.lab_sure = ngui.find_label(self.ui, "centre_otehr/animation/content/btn_sure/lab");

    -----------------------------左
    self.btn_left = ngui.find_button(self.ui, "centre_otehr/animation/content/sp_left_di");
    self.btn_left:set_on_click(self.bindfunc["on_btn_left"]);
    self.texture_left = ngui.find_texture(self.ui, "centre_otehr/animation/content/sp_left_di/sp_touxiangkuang/sp_equip");
    self.sp_frame_left = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_left_di/sp_touxiangkuang/sp_frame");
    self.lab_equip_name_left = ngui.find_label(self.ui, "centre_otehr/animation/content/sp_left_di/lab_equip_name");
    self.lab_lv_left = ngui.find_label(self.ui, "centre_otehr/animation/content/sp_left_di/lab_level");
    self.sp_letter_left = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_left_di/sp_letter");
    self.sp_star_left = {};
    for i=1,5 do
        self.sp_star_left[i] = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_left_di/star/star_di"..i.."/sp_star");
    end
    self.sp_select_left = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_left_di/sp_shine");
    self.scroll_view_left = ngui.find_scroll_view(self.ui, "centre_otehr/animation/content/sp_left_di/scroview/scrollview_nature");
    self.wrap_content_left = ngui.find_wrap_content(self.ui, "centre_otehr/animation/content/sp_left_di/scroview/scrollview_nature/wrap_content");
    self.wrap_content_left:set_on_initialize_item(self.bindfunc['init_item_wrap_content_left']);
    self.btn_scroll_mark_left = ngui.find_button(self.ui, "centre_otehr/animation/content/sp_left_di/scroview/mark");
    self.btn_scroll_mark_left:set_on_click(self.bindfunc["on_btn_left"]);

    -----------------------------右
    self.btn_right = ngui.find_button(self.ui, "centre_otehr/animation/content/sp_right_di");
    self.btn_right:set_on_click(self.bindfunc["on_btn_right"]);
    self.texture_right = ngui.find_texture(self.ui, "centre_otehr/animation/content/sp_right_di/sp_touxiangkuang/sp_equip");
    self.sp_frame_right = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_right_di/sp_touxiangkuang/sp_frame");
    self.lab_equip_name_right = ngui.find_label(self.ui, "centre_otehr/animation/content/sp_right_di/lab_equip_name");
    self.lab_lv_right = ngui.find_label(self.ui, "centre_otehr/animation/content/sp_right_di/lab_level");
    self.sp_letter_right = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_right_di/sp_letter");
    self.sp_star_right = {};
    for i=1,5 do
        self.sp_star_right[i] = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_right_di/star/star_di"..i.."/sp_star");
    end
    self.sp_select_right = ngui.find_sprite(self.ui, "centre_otehr/animation/content/sp_right_di/sp_shine");
    self.scroll_view_right = ngui.find_scroll_view(self.ui, "centre_otehr/animation/content/sp_right_di/scroview/scrollview_nature");
    self.wrap_content_right = ngui.find_wrap_content(self.ui, "centre_otehr/animation/content/sp_right_di/scroview/scrollview_nature/wrap_content");
    self.wrap_content_right:set_on_initialize_item(self.bindfunc['init_item_wrap_content_right']);
    self.btn_scroll_mark_right = ngui.find_button(self.ui, "centre_otehr/animation/content/sp_right_di/scroview/mark");
    self.btn_scroll_mark_right:set_on_click(self.bindfunc["on_btn_right"]);

    self:UpdateUi();
end

function UiEquipForgeChoseEquip:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end
    if self.chose_side_right then
        self.sp_select_left:set_active(false);
        self.sp_select_right:set_active(true);
    else
        self.sp_select_left:set_active(true);
        self.sp_select_right:set_active(false);
    end

    if not self.old_equip_info or not self.new_equip_info then return end

    local path = self.old_equip_info.small_icon;
    self.texture_left:set_texture(path);
    self.lab_equip_name_left:set_text(self.old_equip_info.name);
    self.lab_lv_left:set_text("Lv."..self.old_equip_info.level);
    PublicFunc.SetIconFrameSprite(self.sp_frame_left,self.old_equip_info.rarity)
    PublicFunc.SetEquipRaritySprite(self.sp_letter_left,self.old_equip_info.rarity);
    for i=1,5 do
        self.sp_star_left[i]:set_active(i <= self.old_equip_info.star);
    end
    self.property_left = self.old_equip_info:GetDeltaProperty();
    self.wrap_content_left:set_min_index(-#self.property_left+1);
    self.wrap_content_left:set_max_index(0);
    self.wrap_content_left:reset();

    path = self.new_equip_info.small_icon;
    self.texture_right:set_texture(path);
    self.lab_equip_name_right:set_text(self.new_equip_info.name);
    self.lab_lv_right:set_text("Lv."..self.new_equip_info.level);
    PublicFunc.SetIconFrameSprite(self.sp_frame_right,self.new_equip_info.rarity)
    PublicFunc.SetEquipRaritySprite(self.sp_letter_right,self.new_equip_info.rarity);
    for i=1,5 do
        self.sp_star_right[i]:set_active(i <= self.new_equip_info.star);
    end
    self.property_right = self.new_equip_info:GetDeltaProperty();
    self.wrap_content_right:set_min_index(-#self.property_right+1);
    self.wrap_content_right:set_max_index(0);
    self.wrap_content_right:reset();
end

function UiEquipForgeChoseEquip:Update(dt)
    if not UiBaseClass.Update(self, dt) then
        return
    end
    local cur_time = system.time();
    local sec = MAX_WAIT_TIME - (cur_time - self.begin_time);
    if sec < 0 then
        self:on_sure();
        return
    end
    self.lab_sure:set_text("确定("..sec..")");
end

--
function UiEquipForgeChoseEquip:init_item_wrap_content_left(obj,b,real_id)
	local index = math.abs(real_id)+1;
    if not self.lab_left[b] then
    	self.lab_left[b] = ngui.find_label(obj, "lab_nature");
    end
    local zhengfu = "+";
    if self.property_left[index].value >= 0 then
        zhengfu = "+";
    else
        zhengfu = "-";
    end
    self.lab_left[b]:set_text(zhengfu..self.property_left[index].value..self.property_left[index].showUnit.." "..gs_string_property_name[self.property_left[index].key]);
end

--
function UiEquipForgeChoseEquip:init_item_wrap_content_right(obj,b,real_id)
    local index = math.abs(real_id)+1;
    if not self.lab_right[b] then
        self.lab_right[b] = ngui.find_label(obj, "lab_nature");
    end
    local zhengfu = "+";
    if self.property_right[index].value >= 0 then
        zhengfu = "+";
    else
        zhengfu = "-";
    end
    self.lab_right[b]:set_text(zhengfu..self.property_right[index].value..self.property_right[index].showUnit.." "..gs_string_property_name[self.property_right[index].key]);
end

function UiEquipForgeChoseEquip:on_sure()
    if self.hava_send_msg then return end
    --新装备
    if self.chose_side_right then
        self.is_new = true;
        msg_cards.cg_casting_result_select(2)
    --老装备
    else
        self.is_new = false;
        msg_cards.cg_casting_result_select(1)
    end
    self.hava_send_msg = true;
end

function UiEquipForgeChoseEquip:on_btn_left()
    self.chose_side_right = false;
    self.sp_select_left:set_active(true);
    self.sp_select_right:set_active(false);
end

function UiEquipForgeChoseEquip:on_btn_right()
    self.chose_side_right = true;
    self.sp_select_left:set_active(false);
    self.sp_select_right:set_active(true);
end

function UiEquipForgeChoseEquip:gc_casting_result_select_ret(result, items)
    --app.log("items====="..table.tostring(items,1));
    uiManager:PopUi();
    --CommonAward.Start(items, 1)
    for k,v in pairs(items) do
        local id = v.id;
        if PropsEnum.IsEquip(id) then
            self.return_equip = v;
        elseif PropsEnum.IsGold(id) then
            self.return_gold = v;
        elseif PropsEnum.IsItem(id) then
            self.return_stone = v;
        end
    end
    if self.is_new then
        CommonAward.Start({[1]=self.return_equip}, 5)
    else
        CommonAward.Start({[1]=self.return_equip}, 4)
    end
    if self.return_gold ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnGold, self)
    elseif self.return_gold == nil and self.return_stone ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnStone, self)
    end
    self.return_equip = nil;
end

function UiEquipForgeChoseEquip:ShowReturnGold()
    CommonAward.Start({[1]=self.return_gold}, 6)
    if self.return_stone ~= nil then
        CommonAward.SetFinishCallback(self.ShowReturnStone, self)
    end
    self.return_gold = nil;
end

function UiEquipForgeChoseEquip:ShowReturnStone()
    CommonAward.Start({[1]=self.return_stone}, 6)
    self.return_stone = nil;
end

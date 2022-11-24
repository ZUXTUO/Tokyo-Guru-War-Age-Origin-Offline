UiJiaoTangQiDaoInfo = Class('UiJiaoTangQiDaoInfo', UiBaseClass);
local pathRes = {};
pathRes.test = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1603_church_guaji.assetbundle';

--------------------------------------------------
--初始化
function UiJiaoTangQiDaoInfo:Init()
    self.pathRes = 'assetbundles/prefabs/ui/wanfa/jiao_tang_qi_dao/ui_1603_church_guaji.assetbundle';
    UiBaseClass.Init(self)
    -- self:InitData();
    -- self:Restart();
end

--重新开始
function UiJiaoTangQiDaoInfo:Restart()
    UiBaseClass.Restart(self)
    -- if self.ui then
    --     return;
    -- end
    -- self:RegistFunc();
    -- self:MsgRegist();
    -- self:InitUi();
end

--初始化数据
function UiJiaoTangQiDaoInfo:InitData()
    UiBaseClass.InitData(self)
    -- self.ui = nil;
    -- self.bindfunc = {};
    --self.texture = {};
    self.scard = {};

    self.lab_name = {};
    self.lab_fight_value = {};
    self.lab_gonghui = {};
    self.lab_btn = {};
    self.btn_chanllenge = {};
    self.lab_level = {};
    self.lab_baohuzhong = {};
    self.sp_pos = {};
    self.card = {};
end

--析构函数
function UiJiaoTangQiDaoInfo:DestroyUi()
    UiBaseClass.DestroyUi(self)
    --self.ui = nil;
    if self.ui_challenge then
        self.ui_challenge:DestroyUi();
        self.ui_challenge = nil;
    end

    -- for k,v in pairs(self.texture) do
    --     v:Destroy();
    --     self.texture[k] = nil;
    -- end
    for k,v in pairs(self.scard) do
        v:DestroyUi();
        self.scard[k] = nil;
    end
    self.lab_name = {};
    self.lab_fight_value = {};
    self.lab_gonghui = {};
    self.lab_btn = {};
    self.btn_chanllenge = {};
    self.lab_level = {};
    self.lab_baohuzhong = {};
    self.sp_pos = {};
    self.card = {};
    --self:MsgUnRegist();
    --self:UnregistFunc();
end

--显示ui
function UiJiaoTangQiDaoInfo:Show()
    UiBaseClass.Show(self)
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(true);
end

--隐藏ui
function UiJiaoTangQiDaoInfo:Hide()
    UiBaseClass.Hide(self)
    -- if not self.ui then
    --     return;
    -- end
    -- self.ui:set_active(false);
end

--注册回调函数
function UiJiaoTangQiDaoInfo:RegistFunc()
    UiBaseClass.RegistFunc(self)
    --self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['init_item_wrap_content'] = Utility.bind_callback(self, self.init_item_wrap_content);
    self.bindfunc['on_chanllenge'] = Utility.bind_callback(self, self.on_chanllenge);
    self.bindfunc['on_close'] = Utility.bind_callback(self, self.on_close);
    self.bindfunc['on_in_church'] = Utility.bind_callback(self, self.on_in_church);
    self.bindfunc['on_in_other_church'] = Utility.bind_callback(self, self.on_in_other_church);
end

--注销回调函数
function UiJiaoTangQiDaoInfo:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self)
    -- for k,v in pairs(self.bindfunc) do
    --     if v ~= nil then
    --         Utility.unbind_callback(self, v);
    --     end
    -- end
end

--注册消息分发回调函数
function UiJiaoTangQiDaoInfo:MsgRegist()
    UiBaseClass.MsgRegist(self)
    --PublicFunc.msg_regist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
end

--注销消息分发回调函数
function UiJiaoTangQiDaoInfo:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self)
    --PublicFunc.msg_unregist(msg_activity.gc_churchpray_quick,self.bindfunc['gc_speed_up']);
end

--初始化UI
function UiJiaoTangQiDaoInfo:LoadUI()
    UiBaseClass.LoadUI(self)
end

-- --资源加载回调
-- function UiJiaoTangQiDaoInfo:on_loaded(pid, filepath, asset_obj, error_info)
--     if filepath == pathRes.test then
--         self:FindNguiObject(asset_obj);
--     end
-- end

--寻找ngui对象
function UiJiaoTangQiDaoInfo:InitUI(obj)
    UiBaseClass.InitUI(self, obj)
    --self.ui = asset_game_object.create(obj);
    self.ui:set_parent(Root.get_root_ui_2d_fight());
    self.ui:set_local_scale(1,1,1);
    self.ui:set_name('ui_1603_church_guaji');

    --self.lab_my_fight_value = ngui.find_label(self.ui, "sp_bk/title/lab_num");

    self.scroll_view = ngui.find_scroll_view(self.ui, "centre_other/animation/scroll_view/panel_list");
    self.wrap_content = ngui.find_wrap_content(self.ui, "centre_other/animation/scroll_view/panel_list/wrap_content");
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);

    -- self.btn_mark = ngui.find_button(self.ui, "sp_mark");
    -- self.btn_mark:set_on_click(self.bindfunc['on_close']);

    self.btn_close = ngui.find_button(self.ui, "centre_other/animation/sp_di/btn_cha");
    self.btn_close:set_on_click(self.bindfunc['on_close']);

	self:UpdateUi();
end

--刷新界面
function UiJiaoTangQiDaoInfo:UpdateUi()
    UiBaseClass.UpdateUi(self)
	if not self.ui then
		return
	end

    self.enterStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetEnterJiaoTangIndex();
    self.curIndex = 1;
    self.curStar = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetCurJiaoTangIndex(self.curIndex);
    self.allPosInfo = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetAllPositionInfo(self.enterStar);

    local heroid = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local cardhuman = g_dataCenter.player.package:find_card(ENUM.EPackageType.Hero,heroid);
    local fight_value = cardhuman:GetFightValue();
    --self.lab_my_fight_value:set_text(tostring(fight_value));


    local cnt = 0;
    self.show_player = {};
    for k,v in pairs(self.allPosInfo) do
        cnt = cnt + 1;
        self.show_player[cnt] = {};
        self.show_player[cnt].player = v;
        self.show_player[cnt].pos = k;
        local enemy_id = v:GetDefTeam()[1];
        local cardhuman_enemy = v.package:find_card(ENUM.EPackageType.Hero,enemy_id);
        self.show_player[cnt].fight_value = cardhuman_enemy:GetFightValue();
    end

    --按照战斗力排序
    table.sort(self.show_player, function(a, b) return a.fight_value > b.fight_value end);

    self.wrap_content:set_min_index(-cnt+1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();
    self.scroll_view:reset_position();
    
end

function UiJiaoTangQiDaoInfo:init_item_wrap_content(obj,b,real_id)
    local index = math.abs(real_id)+1;
    if not self.lab_name[b] then
        self.lab_name[b] = ngui.find_label(obj, "lab_name");
    end
    if not self.lab_fight_value[b] then
        self.lab_fight_value[b] = ngui.find_label(obj, "lab_fight");
    end
    if not self.lab_gonghui[b] then
        self.lab_gonghui[b] = ngui.find_label(obj, "lab_guide");
    end
    if not self.lab_btn[b] then
        self.lab_btn[b] = ngui.find_label(obj, "btn/animation/lab");
    end
    if not self.btn_chanllenge[b] then
        self.btn_chanllenge[b] = ngui.find_button(obj, "btn");
    end
    --local sp_frame = ngui.find_sprite(obj, "human/sp_frame");
    -- if self.texture[index] then
    --     self.texture[index]:Destroy();
    -- end
    

    --self.texture[index] = ngui.find_texture(obj, "human/sp_human");
    if not self.lab_level[b] then
        self.lab_level[b] = ngui.find_label(obj, "lab_level");
    end
    if not self.lab_baohuzhong[b] then
        self.lab_baohuzhong[b] = ngui.find_sprite(obj, "sp_art_font");
    end

    if not self.sp_pos[b] then
        self.sp_pos[b] = ngui.find_sprite(obj, "sp_font");
    end

    -- local sp_star = {};
    -- for i=1,5 do
    --     sp_star[i] = ngui.find_sprite(obj, "human/contain_star/sp_star"..i.."/sp");
    -- end

    if self.show_player[index].pos == 0 then
        self.lab_name[b]:set_text(self.show_player[index].player.name);
        self.sp_pos[b]:set_sprite_name("jt_zhujiao")
    else
        self.lab_name[b]:set_text(self.show_player[index].player.name);
        self.sp_pos[b]:set_sprite_name("jt_putong")
    end
    
    if self.show_player[index].player.otherData.guildName then
        self.lab_gonghui[b]:set_text(self.show_player[index].player.otherData.guildName);
    else
        self.lab_gonghui[b]:set_text("");
    end

    local heroid = self.show_player[index].player:GetDefTeam()[1];
    local cardhuman = self.show_player[index].player.package:find_card(ENUM.EPackageType.Hero,heroid);
    if not self.card[b] then
        self.card[b] = obj:get_child_by_name("big_card_item_80");
    end
    if not self.scard[index] then
        self.scard[index] = SmallCardUi:new({parent = self.card[b],stypes = {SmallCardUi.SType.Texture}, res_group=nil});
    end
    self.scard[index]:SetData(cardhuman);

    --self.texture[index]:set_texture(cardhuman.small_icon);
    --item_manager.texturePadding(texture,cardhuman.small_icon);

    if self.show_player[index].player.otherData.protectTime > 0 then
        self.lab_baohuzhong[b]:set_active(true);
    else
        self.lab_baohuzhong[b]:set_active(false);
    end

    local fight_value = cardhuman:GetFightValue();
    self.lab_fight_value[b]:set_text(tostring(fight_value));
    -- for i=1, 5 do
    --     sp_star[i]:set_active(i<=cardhuman.rarity);
    -- end
    self.lab_level[b]:set_text("Lv."..tostring(cardhuman.level));

    if heroid == g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1) then
        self.btn_chanllenge[b]:set_active(false);
    else
        self.btn_chanllenge[b]:set_active(true);
        self.btn_chanllenge[b]:reset_on_click();
        self.btn_chanllenge[b]:set_event_value("", self.show_player[index].pos);
        self.btn_chanllenge[b]:set_on_click(self.bindfunc['on_chanllenge']);
    end
end

function UiJiaoTangQiDaoInfo:on_chanllenge(t)
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetCurChanllengePos(t.float_value)
    if not self.ui_challenge then
        self.ui_challenge = UiJiaoTangQiDaoBeginFight:new();
    else
        self.ui_challenge:Show();
        self.ui_challenge:UpdateUi();
    end
    self:Hide();
end

--在其他教堂中祈祷时，点击挑战
function UiJiaoTangQiDaoInfo:on_in_other_church()
    --HintUI.SetAndShow(EHintUiType.zero, "已在"..self.curStar.."星教堂挂机，请领取后再挑战");
end

--在教堂中祈祷时，点击挑战
function UiJiaoTangQiDaoInfo:on_in_church()
    --HintUI.SetAndShow(EHintUiType.zero, "已在教堂挂机，请领取后再挑战");
end

function UiJiaoTangQiDaoInfo:on_close()
    self:Hide();
end
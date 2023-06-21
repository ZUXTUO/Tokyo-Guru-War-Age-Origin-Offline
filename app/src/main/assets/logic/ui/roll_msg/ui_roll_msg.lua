UiRollMsg = Class('UiRollMsg',UiBaseClass);
--------------------------------------------------
local msg_update_interval = 500;   --毫秒
local max_show_msg = 5;            --最多同时可显示的消息个数
local dis = 32;
local start_pos_y = 47;
local start_pos_x = 0;
local cont_pos = {};
for i=1,max_show_msg do
    cont_pos[i] = start_pos_y + (i-1) * dis;
end
----------------------外部接口
-- data = 
-- {
--     str = xxx,
--     priority = 1,   --数字越大代表优先级越高，越先显示
--     number = 1111,  --道具id
--     count = 2,      --数量
-- }
function UiRollMsg.PushMsg(data)
    if not UiRollMsg.Instance then
        UiRollMsg.Instance = UiRollMsg:new();
        UiRollMsg.Instance:PushMessage(data);
    else
        UiRollMsg.Instance:PushMessage(data);
        UiRollMsg.Instance:ShowMessage();
    end
end

function UiRollMsg.on_ani_hide_end()
    if not UiRollMsg.Instance then return end
    -- app.log("隐藏");
    local length = PublicFunc.GetTableLen(UiRollMsg.Instance.cur_show_list);
    UiRollMsg.Instance.cur_show_list[length] = nil;
end

function UiRollMsg.on_ani_move_end()
    if not UiRollMsg.Instance then return end
    -- app.log("移动完");
    UiRollMsg.Instance.ani_move_end = true;
end

--初始化
function UiRollMsg:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/roll_msg/panel_lab.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function UiRollMsg:Restart(data)
    self.ani_move_end = true;
    UiBaseClass.Restart(self, data);
end

--初始化数据
function UiRollMsg:InitData(data)
    UiBaseClass.InitData(self, data);
    self.msg_list = {};
    self.priority_list = {};
    self.show_data = nil;
    self.cur_show_list = {};   --正在屏幕上显示的列表
    self.cur_show_count = 0;   --正在屏幕上显示的总数
    self.down_count = 0;
    self.next_obj_index = 1;
    self.ani_move_end = true;
end

--析构函数
function UiRollMsg:DestroyUi()
    UiBaseClass.DestroyUi(self);
    Root.DelUpdate(self.Update, self)
end

--显示ui
function UiRollMsg:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function UiRollMsg:Hide()
    UiBaseClass.Hide(self);
end

--注册回调函数
function UiRollMsg:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_timer_callback'] = Utility.bind_callback(self, self.on_timer_callback);
end

--注册消息分发回调函数
function UiRollMsg:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiRollMsg:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--初始化UI
function UiRollMsg:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ui_roll_msg');
    self.cont = {};
    self.lab_normal = {};
    self.sp_role = {};
    self.texture_item = {};
    self.sp_bk = {};
    self.animation = {};
    for i=1,max_show_msg do
        self.cont[i] = ngui.find_sprite(self.ui, "cont_"..i);
        -- self.cont[i]:set_active(false);
        self.animation[i] = ngui.find_sprite(self.ui, "cont_"..i.."/animation");
        self.animation[i]:set_active(false);
        self.lab_normal[i] = ngui.find_label(self.ui, "cont_"..i.."/animation/lab");
        self.lab_normal[i]:set_text(i..""..i);
        self.sp_role[i] = ngui.find_sprite(self.ui, "cont_"..i.."/animation/lab/sp_role");
        self.sp_role[i]:set_active(false);
        self.texture_item[i] = ngui.find_texture(self.ui, "cont_"..i.."/animation/lab/texture");
        self.texture_item[i]:set_active(false);
        self.sp_bk[i] = ngui.find_sprite(self.ui, "cont_"..i.."/animation/lab/sp_bk");
    end
    Root.AddUpdate(self.Update, self);
    self:UpdateUi();
end

function UiRollMsg:Update(dt)
    if not UiBaseClass.Update(self, dt) then return end
    if self.ani_move_end then
        self:ShowMessage();
    end
end

function UiRollMsg:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    self.begin_time = system.time();
    self:ShowMessage();
    --self.timer_id = timer.create(self.bindfunc["on_timer_callback"], msg_update_interval, -1);
end

function UiRollMsg:ShowLabel(obj_index)
    if not self.ui then return end
    local i = obj_index;
    if self.show_data then
        local id = self.show_data.number;
        local count = self.show_data.count or 1;
        local str = self.show_data.str;
        if id then
            if PropsEnum.IsRole(id) then
                local roleConfig = ConfigHelper.GetRole(id)
                if roleConfig then
                    local path = roleConfig.small_icon;
                    PublicFunc.Set120Icon(self.sp_role[i],path);
                    self.sp_role[i]:set_active(true);
                    self.texture_item[i]:set_active(false);
                    if roleConfig.rarity then
                        local str_color = PublicFunc.GetHeroRarity(roleConfig.rarity);
                        if not str_color then 
                            str_color = "FFFFFF";
                        end
                        self.lab_normal[i]:set_text("获得:["..str_color.. "]" .. roleConfig.name.."[-]".."x"..tostring(count));
                    end
                else
                    app.log("id=="..id.."  的英雄没有配置表");
                end
            elseif PropsEnum.IsItem(id) then
                local itemConfig = ConfigManager.Get(EConfigIndex.t_item,id)
                if itemConfig then
                    local cfg = itemConfig
                    local path = cfg.small_icon;
                    if PropsEnum.IsRoleSoul(id) then
                        self.texture_item[i]:set_active(false);
                        self.sp_role[i]:set_active(false);
                        self.sp_role[i]:set_sprite_name(path)
                    else
                        if cfg.category == ENUM.EItemCategory.HeroDebris then
                            self.texture_item[i]:set_active(false);
                        else
                            self.texture_item[i]:set_texture(path);
                            self.texture_item[i]:set_active(true);
                        end
                        
                        self.sp_role[i]:set_active(false);
                    end
                    if cfg.rarity then
                        local str_color = PublicFunc.GetItemRarityColor(cfg.rarity);
                        if not str_color then 
                            str_color = "FFFFFF";
                        end
                        self.lab_normal[i]:set_text("获得:["..str_color .. "]" ..cfg.name.."[-]".."x"..tostring(count));
                    end
                else
                    app.log("id=="..id.."  的道具没有配置表");
                end
            elseif PropsEnum.IsEquip(id) then
                local equip_cfg = ConfigManager.Get(EConfigIndex.t_equipment,id)
                if equip_cfg then
                    local path = equip_cfg.small_icon;
                    self.texture_item[i]:set_texture(path);
                    self.sp_role[i]:set_active(false);
                    self.texture_item[i]:set_active(true);
                    
                    if equip_cfg.rarity then
                        local str_color = PublicFunc.GetEquipRarityColor(equip_cfg.rarity);
                        self.lab_normal[i]:set_text("获得:["..str_color .. "]" ..equip_cfg.name.."[-]".."x"..tostring(count));
                    end
                else
                    app.log("id=="..id.."  的装备没有配置表");
                end
            elseif PropsEnum.IsVaria(id) then
                local itemConfig = ConfigManager.Get(EConfigIndex.t_item,id)
                if itemConfig then
                    local path = itemConfig.small_icon;
                    self.texture_item[i]:set_texture(path);
                    self.sp_role[i]:set_active(false);
                    self.texture_item[i]:set_active(true);
                    if itemConfig.rarity then
                        local str_color = PublicFunc.GetItemRarityColor(itemConfig.rarity);
                        if not str_color then 
                            str_color = "FFFFFF";
                        end
                        self.lab_normal[i]:set_text("获得:["..str_color .. "]"..itemConfig.name.."[-]".."x"..tostring(count));
                    end
                else
                    app.log("id=="..id.."  的道具没有配置表");
                end
            else
                app.log("id=="..id.."  不是英雄不是道具不是装备");
                self.lab_normal[i]:set_text(str);
                self.sp_role[i]:set_active(false);
                self.texture_item[i]:set_active(false);
            end
        else
            self.sp_role[i]:set_active(false);
            self.texture_item[i]:set_active(false);
            self.lab_normal[i]:set_text(self.show_data.str);
        end
        self.animation[i]:set_active(true);
    else
        self.animation[i]:set_active(false);
    end
end

function UiRollMsg:on_timer_callback()
    self:ShowMessage();
end

function UiRollMsg:PushMessage(data)
    if data then
        data.priority = data.priority or 1;
        self.msg_list[data.priority] = self.msg_list[data.priority] or {};
        table.insert(self.msg_list[data.priority],data);
        self.priority_list[data.priority] = self.priority_list[data.priority] or 1;
    end
end

function UiRollMsg:ShowMessage()
    if not self.ui then return end
    if not self.ani_move_end then return end
    local show_data = nil;
    for k,v in pairs(self.priority_list) do
        if self.msg_list[k] then
            if not self.msg_list[k][1] then 
                self.msg_list[k] = nil;
                self.priority_list[k] = nil;
            else
                show_data = self.msg_list[k][1];
                table.remove(self.msg_list[k], 1);
                break;
            end
        else
            self.priority_list[k] = nil;
        end
    end
    self.show_data = show_data;
    if self.show_data then
        self:Push();
    end
end

function UiRollMsg:Push()
    if not self.ui then return end
    if not self.ani_move_end then return end
    self.ani_move_end = false;
    self.animation[self.next_obj_index]:set_active(true);
    self.animation[self.next_obj_index]:get_game_object():animated_play("roll_up");
    self:ShowLabel(self.next_obj_index);
    self.lab_normal[self.next_obj_index]:get_game_object():animated_play("roll_hide");
    --self.cont[self.next_obj_index]:get_game_object():animated_play("alpha_test");
    local length = PublicFunc.GetTableLen(self.cur_show_list)

    for i=1,length do
        self:MoveToNext(self.cur_show_list[i].obj, i+1);
    end

    for i=1,length do
        if length-i+2 >= max_show_msg then
            self.cur_show_list[length-i+2] = nil;
        else
            self.cur_show_list[length-i+2] = self.cur_show_list[length-i+1];
        end
    end
    self.cur_show_list[1] = {};
    self.cur_show_list[1].obj = self.animation[self.next_obj_index];
    self.cur_show_list[1].obj_index = self.next_obj_index;
    self.next_obj_index = Utility.getNextIndexLoop(self.next_obj_index, 1, max_show_msg, true);
end

function UiRollMsg:MoveToNext(obj, next_pos)
    if next_pos < max_show_msg then
        obj:set_position(start_pos_x,cont_pos[next_pos],0);
        obj:set_active(true);
    else
        obj:set_active(false);
    end
end


AcquiringWayUi = Class('AcquiringWayUi', UiBaseClass);

function AcquiringWayUi.Start(data)
    if AcquiringWayUi.instance then
        AcquiringWayUi.Destroy()
    end
    AcquiringWayUi.instance = AcquiringWayUi:new(data);
end

function AcquiringWayUi.Destroy()
    if AcquiringWayUi.instance then
        AcquiringWayUi.instance:DestroyUi();
        AcquiringWayUi.instance = nil;
    end
end

function AcquiringWayUi:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/acquiring_way/ui_3204_obtain_way.assetbundle";
	UiBaseClass.Init(self, data);
end

function AcquiringWayUi:InitData(data)
	UiBaseClass.InitData(self, data);
    self.item_id = data.item_id;
    self.number = data.number;
    self.Allnumber = PropsEnum.GetValue(data.item_id) ; --获取玩家身上的物品数量
    --self.Allnumber = 11;
end

function AcquiringWayUi:Restart(data)
	UiBaseClass.Restart(self, data)
end

function AcquiringWayUi:DestroyUi()
    if self.items then
		for k,v in pairs(self.items) do
			if v and v.text_icon then
				v.text_icon:Destroy()
				v.text_icon = nil
			end
		end
        self.items = nil
    end

    if self.ui_small_item then
        self.ui_small_item:DestroyUi();
        self.ui_small_item = nil;
    end

    UiBaseClass.DestroyUi(self);
end

function AcquiringWayUi:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["on_goto"] = Utility.bind_callback(self, self.on_goto)
    self.bindfunc["init_item_wrap_content"] = Utility.bind_callback(self, self.init_item_wrap_content)
end

function AcquiringWayUi:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--初始化UI
function AcquiringWayUi:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("ui_acquiring_way");

    self.items = {}

    ---------图片----------
    self.wrap_content = ngui.find_wrap_content(self.ui, 'centre_other/animation/scroll_view/panel_list/wrap_content');
    self.wrap_content:set_on_initialize_item(self.bindfunc['init_item_wrap_content']);
    
    self.btn_close = ngui.find_button(self.ui, "centre_other/animation/content_di_1004_564/btn_cha");
    self.btn_close:set_on_click(self.bindfunc["on_close"]);

    self.obj_item = self.ui:get_child_by_name("centre_other/animation/sp_bk2/new_small_card_item");
    self.lab_item_name = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/lab_name");
    self.lab_item_num = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/lab_num/lab_num1");

    self:UpdateUi();
end

local _RarityString = {
    [0] = "[ffffff]",
    [1] = "[ffffff]",
    [2] = "[00ff84]",   
    [3] = "[297fff]",    
    [4] = "[9731ff]",    
    [5] = "[ffc600]",   
    [6] = "[ff611b]",  
}

function AcquiringWayUi:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then return end
    if not self.item_id then
        app.log("AcquiringWayUi:UpdateUi的item_id为nil");
        return
    end
    --local item = g_get_item(self.item_id);
    --if not item then
    --    app.log("item_id=="..self.item_id.."的道具没有配置表");
    --    return;
    --end
    
    local item = ConfigManager.Get(EConfigIndex.t_item,self.item_id);
    if not item then
        app.log("item_id=="..self.item_id.."的道具没有配置表");
        return;
    end
    
    local acquiring_way = item.acquiring_way;  --取得物品的获取路径 list
    if not acquiring_way or type(acquiring_way) ~= "table" then
        app.log("id=="..self.item_id.."的道具，没有获取途径配置");
        return
    end
    self.acquiring_way = {};
    local TempAcquiring ={};
    
    for k,v in pairs(acquiring_way) do          
        local acquiring_way_data = ConfigManager.Get(EConfigIndex.t_acquiring_way_ui_data,v)
        if acquiring_way_data then
            local open_level = 0;
            local level = g_dataCenter.player.level; --自身等级
            --local level = 1 --自身等级
            if acquiring_way_data.destype == 1 then
                --open_level = g_get_hurdle(acquiring_way_data.system_id).need_level
                open_level = ConfigManager.Get(EConfigIndex.t_hurdle,acquiring_way_data.system_id).need_level
            else
                local data = ConfigManager.Get(EConfigIndex.t_play_vs_data,acquiring_way_data.system_id)
                open_level = data.open_level;
            end

            if level >= open_level then
                if acquiring_way_data.destype == 1 then
                    local hurdleData = g_dataCenter.hurdle;
                    local IsCanFight = hurdleData:IsCanFight( acquiring_way_data.system_id )
                    if IsCanFight then
                        table.insert(TempAcquiring,{key = v,isOpen = 1, is_recommend = acquiring_way_data.is_recommend})
                    else
                        table.insert(TempAcquiring,{key = v,isOpen = 0, is_recommend = acquiring_way_data.is_recommend})
                    end
                else
                    table.insert(TempAcquiring,{key = v,isOpen = 1, is_recommend = acquiring_way_data.is_recommend})
                end
            else
                table.insert(TempAcquiring,{key = v,isOpen = 0, is_recommend = acquiring_way_data.is_recommend})
            end
        end 
    end
    
    local sortFunc = function(a,b)
        if a.is_recommend > b.is_recommend then
            return true
        else
            if a.isOpen > b.isOpen then
                return true
            else
                return false 
            end
        end
    end
    
    --排序处理
    table.sort(TempAcquiring,sortFunc);
    
    for k,v in pairs(TempAcquiring) do
       table.insert(  self.acquiring_way,v.key )   
    end

    --app.log("self.acquiring_way=="..table.tostring(self.acquiring_way));
    local cnt = #self.acquiring_way;
    self.wrap_content:set_min_index(-cnt+1);
    self.wrap_content:set_max_index(0);
    self.wrap_content:reset();

    --local strNum = PublicFunc.GetColorText(tostring(self.Allnumber).."/"..tostring(self.number), "orange_yellow")
    local strNum = PublicFunc.GetColorText(tostring(self.Allnumber), "orange_yellow")
    self.lab_item_num:set_text(" "..strNum);
    
    local item = ConfigManager.Get(EConfigIndex.t_item,self.item_id);
    if not item then
        app.log("item_id=="..self.item_id.."的道具没有配置表");
        return;
    end
    
    local item_name = item.name;
    --item.rarity 物品 品质不同 显示颜色不同
    --local item_rarity =  g_get_item(self.item_id).rarity;
    local item_rarity = item.rarity
    --app.log("###########item_rarity###############"..tostring(item_rarity))
    self.lab_item_name:set_text(self:GetRarityStr(item_rarity,item_name));

    local card_prop = CardProp:new({number = self.item_id,count = self.number});
    self.ui_small_item = UiSmallItem:new({parent = self.obj_item, cardInfo = card_prop});
    self.ui_small_item:SetLabNum(false);
end

--物品品质

function AcquiringWayUi:GetRarityStr(rarity,name)
    if rarity == nil then
        return "[ffffff]"..name.."[-]"
    end
    return _RarityString[rarity]..name.."[-]"
end

--关闭
function AcquiringWayUi:on_close()
    AcquiringWayUi.Destroy()
end

--立即前往
function AcquiringWayUi:on_goto(t)
    --app.log("gogogogogogogogo")
    local index = t.float_value;
    local acquiring_way_data = ConfigManager.Get(EConfigIndex.t_acquiring_way_ui_data,index)
    --if index == 2000010 then --关卡
    local system_id = acquiring_way_data.system_id;

    --物殊处理首冲
    if system_id == 62000012 then
        local firstRechargeType = g_dataCenter.player:GetFirstRechargeType();

        if firstRechargeType and firstRechargeType == ENUM.ETypeFirstRecharge.haveGet then
            FloatTip.Float("已参加过首充活动！");
            do return end
        end        
    end


    if acquiring_way_data.destype == 1 then
        -- uiManager:PushUi(EUI.UiLevelChallenge, {hurdleid=system_id, goodsId=self.item_id, goodsCount=self.number})
        
        uiManager:PushUi(EUI.UiLevel, {goLevelChallenge = system_id,goodsId = self.item_id,goodsCount = self.number});
        --uiManager:PushUi(EUI.UiLevel, {goLevelChallenge = index, goodsId = self.item_id, goodsCount = self.number});
        --app.log("关卡id=="..self.goto_hurdle_id); goLevelChallenge= 关卡id, goodsId=物品id, goodsCount=需要物品数量
    else
        --活动
        --SystemEnterFunc[system_id]();
        SystemEnterFunc.AcquireEntry(system_id)
    end
    AcquiringWayUi.Destroy()

end

function AcquiringWayUi:init_item_wrap_content(obj,b,real_id)
    local index = math.abs(real_id)+1;

    local item = self.items[b]
    if item == nil then
        item = {}
        item.lab_title_name1 = ngui.find_label(obj,"sp_title/lab_title")
        item.lab_title_name2 = ngui.find_label(obj,"sp_title/lab_title/lab_title2")
        item.lab_describe = ngui.find_label(obj, "lab1");
        --item.lab_describe = ngui.find_label(obj, "lab2");
        item.lab_isopen = ngui.find_label(obj, "lab3");
        item.lab_number = ngui.find_label(obj, "lab_num");
        item.btn_goto = ngui.find_button(obj, "btn_qianwang");
        item.text_icon = ngui.find_texture(obj, obj:get_name() .. "/sp_yuan/texture_yuan");
        item.sp_yuan = ngui.find_sprite(obj, obj:get_name() .. "/sp_yuan");
        item.sp_biaoqian = ngui.find_sprite(obj, obj:get_name() .. "/sp_biaoqian");

        item.sp_head = ngui.find_sprite(obj, "sp_title")
        item.sp_body = ngui.find_sprite(obj, "sp_di")
        item.sp_arrows = ngui.find_sprite(obj, "sp_arrows")
        --item.sp_pattern = ngui.find_sprite(obj, "sp_effect")

        self.items[b] = item
    end
    
    local key = self.acquiring_way[index]
    local acquiring_way_data =  ConfigManager.Get(EConfigIndex.t_acquiring_way_ui_data,key);  --g_get_acquiring_way_ui_data(key);
    if not acquiring_way_data then
        --app.log("index=="..index);
        return
    end

	item.text_icon:set_texture(acquiring_way_data.icon)	
    --PublicFunc.SetAcquireIcon(item.sp_icon, acquiring_way_data.icon_index)
        
    --1为关卡 2为活动说明
    local desText = ""
    --if acquiring_way_data.destype == 1 then
        --desText = tostring(g_get_hurdle(acquiring_way_data.system_id).b).." "..tostring(gs_hurdle_describe[acquiring_way_data.system_describe])
    desText = tostring(gs_item_source_des[acquiring_way_data.system_describe])
    --elseif acquiring_way_data.destype == 2 then
    --    desText = tostring(gs_string_acquiring_way[acquiring_way_data.system_describe])
    --end
    
    item.lab_describe:set_text(desText);

    item.lab_title_name1:set_text(tostring(gs_item_source_name[acquiring_way_data.system_name]))
    item.lab_title_name2:set_text(tostring(gs_item_source_name[acquiring_way_data.system_name_title]))

    --是否推荐
    local flag = false
    if acquiring_way_data.is_recommend == 1 then
        flag = true
    end

    item.sp_biaoqian:set_active(flag)        
    --app.log('----->' .. table.tostring(acquiring_way_data))
    
    --判断是否为关卡(撞关次数)
    if acquiring_way_data.destype == 1 then
        --判断是否为精英关卡 0 为普通 1为精英
        --if g_get_hurdle(acquiring_way_data.system_id).hurdle_type == 0 then
        if ConfigManager.Get(EConfigIndex.t_hurdle,acquiring_way_data.system_id).hurdle_type == 0 then
            item.lab_number:set_text("")
        else
            local Numb1,Numb2 = g_dataCenter.hurdle:GetHurdleTimes(acquiring_way_data.system_id)
            
            local Numb3 = Numb2 - Numb1
            if Numb3 < 0 then
                Numb3 = 0;
            end
            item.lab_number:set_text(tostring(Numb3).."/"..tostring(Numb2))
        end
    else
        if item.lab_number then
            item.lab_number:set_text("")
        end
    end
    
    --通过等级来判断是否已开启 need_level
    local open_level = 0;
    local level = g_dataCenter.player.level; --自身等级
    --local level = 1 --自身等级
    if acquiring_way_data.destype == 1 then
        open_level = ConfigManager.Get(EConfigIndex.t_hurdle,acquiring_way_data.system_id).need_level --g_get_hurdle(acquiring_way_data.system_id).need_level
    else
        local data = ConfigManager.Get(EConfigIndex.t_play_vs_data,acquiring_way_data.system_id) --g_get_play_vs_data(acquiring_way_data.system_id);
        open_level = data.open_level;
    end
    
    local hurdleData = g_dataCenter.hurdle;
    local IsCanFight = hurdleData:IsCanFight( acquiring_way_data.system_id )
    
    if acquiring_way_data.destype == 1 then
        if level >= open_level and IsCanFight then
            item.lab_isopen:set_text("")

            local strName = tostring(gs_item_source_name[acquiring_way_data.system_name])
            --item.lab_name:set_text(PublicFunc.GetColorText(strName, "orange_yellow"));

            PublicFunc.SetItemBorderHead(item.sp_head, true)
            --PublicFunc.SetItemBorderContent(item.sp_body, true)
            PublicFunc.SetUISpriteWhite(item.sp_yuan)
            PublicFunc.SetUISpriteWhite(item.sp_biaoqian)

            PublicFunc.SetUISpriteWhite(item.text_icon)
            PublicFunc.SetUISpriteWhite(item.sp_arrows)
            -- 蓝色花纹 3C57B7FF
            item.sp_body:set_color(1,1,1,1)
            -- 文字颜色
            item.lab_title_name1:set_gradient_bottom(213/255,145/255,247/255,255/255)
            item.lab_title_name2:set_gradient_bottom(213/255,145/255,247/255,255/255)
        else
            item.btn_goto:set_active(false)
            item.lab_isopen:set_text("未开启")

            local strName = tostring(gs_item_source_name[acquiring_way_data.system_name])
            --item.lab_name:set_text(PublicFunc.GetColorText(strName, "white"));

            PublicFunc.SetItemBorderHead(item.sp_head, false)
            --PublicFunc.SetItemBorderContent(item.sp_body, false)
            PublicFunc.SetUISpriteGray(item.sp_yuan)
            PublicFunc.SetUISpriteGray(item.sp_biaoqian)

            PublicFunc.SetUISpriteGray(item.text_icon)
            PublicFunc.SetUISpriteGray(item.sp_arrows)
            -- 灰色花纹 3A3A3AFF
            item.sp_body:set_color(0,0,0,1)

            item.lab_title_name1:set_gradient_bottom(255/255,255/255,255/255,255/255)
            item.lab_title_name2:set_gradient_bottom(255/255,255/255,255/255,255/255)
        end
    else
        if level >= open_level then
            item.lab_isopen:set_text("")

            local strName = tostring(gs_item_source_name[acquiring_way_data.system_name])
            --item.lab_name:set_text(PublicFunc.GetColorText(strName, "orange_yellow"));

            PublicFunc.SetItemBorderHead(item.sp_head, true)
            --PublicFunc.SetItemBorderContent(item.sp_body, true)
            PublicFunc.SetUISpriteWhite(item.sp_yuan)
            PublicFunc.SetUISpriteWhite(item.sp_biaoqian)

            PublicFunc.SetUISpriteWhite(item.text_icon)
            PublicFunc.SetUISpriteWhite(item.sp_arrows)
            -- 蓝色花纹 3C57B7FF
            item.sp_body:set_color(1,1,1,1)
            item.lab_title_name1:set_gradient_bottom(213/255,145/255,247/255,255/255)
            item.lab_title_name2:set_gradient_bottom(213/255,145/255,247/255,255/255)
        else
            item.btn_goto:set_active(false)
            item.lab_isopen:set_text("未开启")

            local strName = tostring(gs_item_source_name[acquiring_way_data.system_name])
            --item.lab_name:set_text(PublicFunc.GetColorText(strName, "white"));

            PublicFunc.SetItemBorderHead(item.sp_head, false)
            --PublicFunc.SetItemBorderContent(item.sp_body, false)
            PublicFunc.SetUISpriteGray(item.sp_yuan)
            PublicFunc.SetUISpriteGray(item.sp_biaoqian)

            PublicFunc.SetUISpriteGray(item.text_icon)
            PublicFunc.SetUISpriteGray(item.sp_arrows)
            -- 灰色花纹 3A3A3AFF
            item.sp_body:set_color(0,0,0,1)
            item.lab_title_name1:set_gradient_bottom(255/255,255/255,255/255,255/255)
            item.lab_title_name2:set_gradient_bottom(255/255,255/255,255/255,255/255)
        end
    end
    
    
    local system_id = acquiring_way_data.system_id;
    app.log("system_id============"..tostring(system_id))
    item.btn_goto:reset_on_click();
    item.btn_goto:set_event_value("", key);
    item.btn_goto:set_on_click(self.bindfunc["on_goto"]);

end

--关卡筛选，找出最好的能掉落道具的关卡--已取消功能
function AcquiringWayUi:HurdleFilterFunc()
    local hurdleData = g_dataCenter.hurdle;
    local curGroup = hurdleData:GetCurGroup();
    if not curGroup or curGroup == 0 then
        return false;
    end
    local curLevelID = hurdleData:GetCurFightLevelID()
    local groupList = hurdleData:GetGroupList();
    local cur_ap = g_dataCenter.player.ap;
    local can_drop = false;
    local all_can_drop_level = {};
    local all_can_drop_and_sweep_level = {};
    for k, v in pairs(groupList) do
        for m, n in pairs(v) do
            local hurdle_config = g_get_hurdle(m);
            if hurdle_config then
                local cost_ap = hurdle_config.cost_ap;
                --体力不足
                if cur_ap >= cost_ap then
                    local hurdle_info = n;
                    local have_challenged_times = hurdle_info.period_post_times;
                    --挑战次数已用完
                    if have_challenged_times < hurdle_config.max_count then
                        --掉落id
                        local drop_id = hurdle_config.pass_award;
                        local drop_config = g_get_drop_something(drop_id);
                        for key,info in pairs(drop_config) do
                            if info.goods_id == self.item_id then
                                table.insert(all_can_drop_level, m);
                                can_drop = true;
                                break;
                            end
                        end

                        if hurdle_info.star_num == 3 then
                            local saodang_drop_id = hurdle_config.saodang_award;
                            local saodang_drop_config = g_get_drop_something(saodang_drop_id);
                            for key,info in pairs(saodang_drop_config) do
                                if info.goods_id == self.item_id then
                                    table.insert(all_can_drop_and_sweep_level, m);
                                    can_drop = true;
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local sortFunction = function(a, b)
        if a > b then
            return true;
        else
            return false;
        end
    end
    if can_drop then
        if #all_can_drop_and_sweep_level > 0 then
            table.sort(all_can_drop_and_sweep_level, sortFunction);
            self.goto_hurdle_id = all_can_drop_and_sweep_level[1];
        else
            table.sort(all_can_drop_level, sortFunction);
            self.goto_hurdle_id = all_can_drop_level[1];
        end
    else
        self.goto_hurdle_id = nil;
    end

    if not groupList[curGroup] or not groupList[curGroup][curLevelID] then
        if #all_can_drop_and_sweep_level == 0 then
            local hurdle_config = g_get_hurdle(curLevelID);
            local cost_ap = hurdle_config.cost_ap;
            if cur_ap >= cost_ap then
                local drop_id = hurdle_config.pass_award;
                local drop_config = g_get_drop_something(drop_id);
                for key,info in pairs(drop_config) do
                    if info.goods_id == self.item_id then
                        self.goto_hurdle_id = curLevelID;
                        can_drop = true;
                        break;
                    end
                end
            end
        end
    end

    return can_drop;
end

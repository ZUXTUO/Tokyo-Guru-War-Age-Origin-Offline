CommonRaids = Class("CommonRaids",UiBaseClass);
--扫荡数据结构
--data = 
--{
--goodsId = 0,		所需道具id
--goodsCount = 0,	所需道具数量
--getItemsCount = 0,   扫荡获得道具数量
--realTimes = 0,        真实扫荡次数
--drop_items = {
--	{isAwardsEx=true, awards={{id=1,count=1,isExtraActivity=true},{id=1,count=1},}, } 第1次扫荡  isAwardsEx是否是额外奖励
--	{isAwardsEx=true, awards={{id=1,count=1},{id=1,count=1},}, } 第2次扫荡	 isAwardsEx是否是额外奖励
--}  
--callbackAgain = {name=nil,call=nil,callObj=nil,param=nil}	再次扫荡回掉  nil默认没有这个按钮
--callbackOk = {name=nil,call=nil,callObj=nil,param=nil}	确定回掉  nil默认只是关掉此界面   注意关闭按钮也会回掉此函数
--}
function CommonRaids.Start(data)
    -- data = {drop_items={}};
    -- for i = 1, 49 do
    --     if i % 7 == 0 then
    --         table.insert(data.drop_items, {awards= {{id = 20000021, count=1},
    --             {id=2,count=i},
    --             {id=20000021,count=i},
    --             {id=2,count=i},
    --             {id=20000021,count=i},
    --             {id=2,count=i},
    --             {id=20000021,count=i},
    --             {id=2,count=i},
    --             {id=20000021,count=i},
    --             {id=2,count=i},
    --             }});
    --     else
    --         table.insert(data.drop_items, {awards= {{id = 20000021, count=1},{id=2,count=i}}});
    --     end
    -- end
    -- table.insert(data.drop_items, {isAwardsEx=true, awards= {{id = 20000021, count=1},{id=2,count=50}}});
	if CommonRaids.cls == nil then
		CommonRaids.cls = CommonRaids:new(data);
	else
		CommonRaids.cls:InitStart(data);
        CommonRaids.cls:UpdateUi();
	end
end

function CommonRaids.Destroy()
    if CommonRaids.cls ~= nil then
        CommonRaids.cls:DestroyUi()
    end
end

function CommonRaids:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/level/ui_704_level.assetbundle";
	UiBaseClass.Init(self, data);
end

function CommonRaids:InitData(data)
	UiBaseClass.InitData(self, data);
    self:InitStart(data);
end

function CommonRaids:InitStart(data)
    self.data = data;
    local function SortRairy(a, b)
        if a.isExtraActivity and not b.isExtraActivity then
            return false;
        end
        if not a.isExtraActivity and b.isExtraActivity then
            return true;
        end
        local itema = ConfigManager.Get(EConfigIndex.t_item, a.id);
        local itemb = ConfigManager.Get(EConfigIndex.t_item, b.id);
        if itema.sort_number > itemb.sort_number then
            return true;
        end
        if itema.sort_number < itemb.sort_number then
            return false;
        end
        if itema.id < itemb.id then
            return true;
        end
        return false;
    end
    for k, v in pairs(self.data.drop_items) do
        table.sort(v.awards, SortRairy);
    end
    --必须放在这  因为设置循环列表的回掉的时候会判断这个值
    self.startAnimation = true;
    self.isMoveLast = false;
end

function CommonRaids:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnSure"] = Utility.bind_callback(self,self.OnSure);
    self.bindfunc["OnAgain"] = Utility.bind_callback(self,self.OnAgain);
    self.bindfunc["OnInitItem"] = Utility.bind_callback(self,self.OnInitItem);
    self.bindfunc["OnItemMoveFinish"] = Utility.bind_callback(self,self.OnItemMoveFinish);
    self.bindfunc["OnMoveLastFinish"] = Utility.bind_callback(self,self.OnMoveLastFinish);
    self.bindfunc["OnFastMove"] = Utility.bind_callback(self,self.OnFastMove);
end
local UI_MAX_RAIDS_COUNT = 4;
local UI_MAX_AWARDS_COUNT = 14;
function CommonRaids:DestroyUi()
    UiBaseClass.DestroyUi(self);
    for k, v in pairs(self.itemList) do
        for i = 1, UI_MAX_AWARDS_COUNT do
            if v["item"..i] then
                v["item"..i]:DestroyUi();
            end
        end
    end
    self.data = nil;
    CommonRaids.cls = nil;
    Root.DelUpdate(CommonRaids.Update, self);
end

function CommonRaids:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('common_raids');

    self.btnClose = ngui.find_button(self.ui, "btn_cha");
    self.btnClose:set_on_click(self.bindfunc["OnSure"]);

    self.wrapList = ngui.find_wrap_list(self.ui, 'wrap_cont');
    self.wrapList:set_on_initialize_item(self.bindfunc['OnInitItem']);
    self.wrapList:set_on_item_move_finish(self.bindfunc['OnItemMoveFinish']);
    self.wrapList:set_on_move_last_finish(self.bindfunc['OnMoveLastFinish']);

    self.btnAgain = ngui.find_button(self.ui, "btn1");
    self.btnAgain:set_on_click(self.bindfunc['OnAgain']);
    self.labAgain = ngui.find_label(self.ui, "btn1/animation/lab");
    self.btnSure1 = ngui.find_button(self.ui, "btn2");
    self.btnSure1:set_on_click(self.bindfunc['OnSure']);
    self.labSure1 = ngui.find_label(self.ui, "btn2/animation/lab");
    -- self.btnSure2 = ngui.find_button(self.ui, "btn3");
    -- self.btnSure2:set_on_click(self.bindfunc['OnSure']);
    -- self.labSure2 = ngui.find_label(self.ui, "btn3/animation/lab");

    self.btnFastMove = ngui.find_button(self.ui, "panel/sp_mark1");
    self.btnFastMove:set_on_click(self.bindfunc["OnFastMove"]);
    local btn = ngui.find_button(self.ui, "common_raids/sp_mark");
    btn:set_active(true);
    btn:set_on_click(self.bindfunc["OnFastMove"]);

    self.itemList = {};
    for k = 1, UI_MAX_RAIDS_COUNT do
        self.itemList[k] = {}; 
        local itemList = self.itemList[k];
        local obj = self.ui:get_child_by_name("item"..k);
        itemList.objRoot = obj;
        itemList.labTitle = ngui.find_label(obj, "lab_goods");
        for j = 1, UI_MAX_AWARDS_COUNT do
            local name = string.format("new_small_card_item%d", j);
            itemList["objItem"..j] = obj:get_child_by_name(name);
            itemList["spItem"..j] = ngui.find_sprite(obj, name);
            itemList["tweenItem"..j] = ngui.find_tween_color(obj, name);
        end
    end

    self.labSaoDang = ngui.find_label(self.ui, "lab_num");

    self.popList = {};
    self.popList.objRoot = self.ui:get_child_by_name("sp_popup");
    -- self.popList.labName = ngui.find_label(self.popList.objRoot, "lab_name");
    -- self.popList.labCount = ngui.find_label(self.popList.objRoot, "lab_num1");
    -- self.popList.labGetCount = ngui.find_label(self.popList.objRoot, "lab_num2");
    self.popList.objItemParent = self.popList.objRoot:get_child_by_name("new_small_card_item");
    self.popList.item = UiSmallItem:new({parent = self.popList.objItemParent, is_enable_goods_tip = true});

    Root.AddUpdate(CommonRaids.Update, self);
    self:UpdateUi();
end

function CommonRaids:UpdateUi()
    --app.log("1..."..tostring(self.data).." "..tostring(UiBaseClass.UpdateUi(self)).." "..tostring(self.ui));
    if not UiBaseClass.UpdateUi(self) or not self.data then return end    
    local cnt = #self.data.drop_items;

    if cnt <= 0 then
        app.log("没有给道具   "..tostring(cnt));
        return;
    end
    self.labSaoDang:set_text("");
    self.wrapList:set_min_index(-cnt + 1);
    self.wrapList:set_max_index(0);
    self.wrapList:reset();
    self.btnFastMove:set_active(true);
    self.btnClose:set_active(false);
    self.btnAgain:set_active(false);
    self.btnSure1:set_active(false);
    -- self.btnSure2:set_active(false);
    self.wrapList:set_move_switch(false);
    --app.log("2..."..tostring(self.data));
    --弹出列表
    -- local goodsId = self.data.goodsId;
    -- local goodsCount = self.data.goodsCount;
    local popList = self.popList;
    popList.objRoot:set_active(false);
    -- if goodsId and goodsCount then
    --     popList.objRoot:set_active(true);
    --     popList.item:SetDataNumber(goodsId, goodsCount);
    --     popList.item:SetDouble(self.data.radio_num);
    --     -- popList.labName:set_text(popList.item.cardInfo.color_name);
    --     local curCount = PropsEnum.GetValue(goodsId);
    --     if curCount >= goodsCount then
    --         -- popList.labCount:set_text(gs_misc['str_80']);
    --     else
    --         -- popList.labCount:set_text(string.format(gs_misc['str_79'], goodsCount - curCount));
    --     end
    --     local getCount = 0;
    --     for k, v in ipairs(self.data.drop_items) do
    --         for m, n in ipairs(v.awards) do
    --             if n.id == goodsId then
    --                 getCount = getCount + n.count;
    --             end
    --         end
    --     end
    --     -- popList.labGetCount:set_text(string.format(gs_misc['str_81'], getCount));
    -- else
    --     popList.objRoot:set_active(false);
    -- end
    self:StartAnimation();
end

function CommonRaids:StartAnimation()
    self:ResetStart();
    self:PlayNextTimes();
end
function CommonRaids:ResetStart()
    CommonRaids.isPlayNextItem = false;
    --当前正在播的次数与奖励个数、item的位置
    self.playTimes = 0;
    self.playUiItem = 0;
    --先把所有的扫荡、次数隐藏起来
    for k, v in pairs(self.itemList) do
        v.objRoot:set_active(false);
        -- for j = 1, UI_MAX_AWARDS_COUNT do
        --     v["objItem"..j]:set_active(false);
        -- end
    end
end
--开始播放下一次扫荡
function CommonRaids:PlayNextTimes()
    self.playTimes = self.playTimes + 1;
    self.playUiItem = self.playUiItem + 1;
    if self.playUiItem > UI_MAX_RAIDS_COUNT then
        self.playUiItem = 1;
    end

    self.playAwards = 1;
    
    if self.data.drop_items[self.playTimes] == nil then
        self:AnimationOver();
    else
        local itemList = self.itemList[self.playUiItem];
        local data = self.data.drop_items[self.playTimes];
        local goods = data.awards[self.playAwards];
        if goods == nil then
            app.log("有奖励为空  times="..tostring(self.playTimes).." awards="..tostring(self.playAwards));
        end
        itemList.objRoot:set_active(true);
        --app.log(tostring(self.playTimes).."......."..table.tostring(data).."   "..tostring(gs_misc['str_83']))
        if data.isAwardsEx then
            itemList.labTitle:set_text(gs_misc['str_83']);
        else
            --app.log("PlayNextTimes........."..tostring(self.playTimes));
            itemList.labTitle:set_text(string.format(gs_misc['str_87'], math.abs(self.playTimes)));
        end
        for i = 1, UI_MAX_AWARDS_COUNT do
            itemList["objItem"..i]:set_active(false);
            itemList["tweenItem"..i]:reset_to_begining();
        end
        itemList["objItem"..self.playAwards]:set_active(true);
        if itemList["item"..self.playAwards] == nil then
            itemList["item"..self.playAwards] = UiSmallItem:new({parent = itemList["objItem"..self.playAwards], is_enable_goods_tip = true});
        end
        itemList["item"..self.playAwards]:SetDataNumber(goods.id, goods.count);
        itemList["item"..self.playAwards]:SetAsReward(goods.id == self.data.goodsId);
        itemList["item"..self.playAwards]:SetDouble(goods.radio_num);
        itemList["item"..self.playAwards]:SetTuiJianLab(goods.isExtraActivity);
        
        -- app.log("---------" .. table.tostring(goods));
        --这个地方需要位置对齐
        --第一个不需要对齐位置
        if self.playTimes ~= 1 then
            self.wrapList:align_pre_item(itemList.objRoot, true);
        end
        itemList["tweenItem"..self.playAwards]:play_foward();
    end
end

function CommonRaids:PlayNextItem()
    self.playAwards = self.playAwards + 1;
    local data = self.data.drop_items[self.playTimes].awards[self.playAwards];
    local itemList = self.itemList[self.playUiItem];
    if data == nil then
        --self:PlayNextTimes();
        --app.log("111.......")
        --如果是第一个则继续播放下一次的动画 否则则是执行拖动动画
        --app.log(tostring(#self.data.drop_items).."......."..tostring(self.playTimes))
        if self.playTimes == 1 then
            self:PlayNextTimes();
        elseif self.playTimes == #self.data.drop_items then
            self:AnimationOver();
        else
            local index = self.playUiItem - 1;
            if index < 1 then
                index = UI_MAX_RAIDS_COUNT;
            end
            itemList = self.itemList[index];
            self.wrapList:drag_item(itemList.objRoot, true);
        end
    else
        itemList["objItem"..self.playAwards]:set_active(true);
        itemList["spItem"..self.playAwards]:set_color(1, 1, 1, 0);
        if itemList["item"..self.playAwards] == nil then
            itemList["item"..self.playAwards] = UiSmallItem:new({parent = itemList["objItem"..self.playAwards], is_enable_goods_tip = true});
        end
        itemList["item"..self.playAwards]:SetDataNumber(data.id, data.count);
        itemList["item"..self.playAwards]:SetAsReward(data.id == self.data.goodsId);
        itemList["item"..self.playAwards]:SetDouble(data.radio_num);
        itemList["item"..self.playAwards]:SetTuiJianLab(data.isExtraActivity);
        itemList["tweenItem"..self.playAwards]:play_foward();
    end
end
--这个用来播放下一次道具的播放
function CommonRaids:Update(dt)
    if not UiBaseClass.Update(self, dt) then return end
    --播放下一个item动画
    if CommonRaids.isPlayNextItem then
        CommonRaids.isPlayNextItem = nil;
        if not self.isMoveLast then
            self:PlayNextItem();
        end
    end
end

function CommonRaids:AnimationOver()
    --app.log("......."..debug.traceback())
    self.startAnimation = false;
    self.wrapList:set_move_switch(true);
    self.btnFastMove:set_active(false);
    self.btnClose:set_active(true);
    local callAgain = self.data.callbackAgain;
    local callOk = self.data.callbackOk;
    if callAgain then
        self.btnAgain:set_active(true);
        self.btnSure1:set_active(true);
        self.labAgain:set_text(tostring(callAgain.name));
    -- else
    --     self.btnSure2:set_active(true);
    end
    if callbackOk then
        self.labSure1:set_text(tostring(callbackOk.name));
        self.labSure2:set_text(tostring(callbackOk.name));
    end
    --需要去将所有最上面的那个的数据

    NoticeManager.Notice(ENUM.NoticeType.GetHurdleRaidsShowBack)
    local goodsId = self.data.goodsId;
    local goodsCount = self.data.goodsCount;
    if goodsId then
        local popList = self.popList;
        popList.objRoot:set_active(true);
        popList.item:SetDataNumber(goodsId, 0);
        popList.item:SetDouble(self.data.radio_num);
        popList.item:SetShowNumber(false);
        local curCount = PropsEnum.GetValue(goodsId);
        if curCount >= goodsCount then
            self.labSaoDang:set_text(
                string.format(gs_misc["hurdle_7"],
                tostring(self.data.realTimes),
                tostring(self.data.getItemsCount))
                -- tostring(popList.item.cardInfo.color_name),
                -- tostring(self.data.getItemsCount))
            );    
        else
            self.labSaoDang:set_text(
                string.format(gs_misc["hurdle_8"],
                tostring(self.data.realTimes),
                -- tostring(popList.item.cardInfo.color_name),
                tostring(self.data.getItemsCount),
                tostring(goodsCount - curCount))
            );    
        end
        
    else
        self.labSaoDang:set_text("")
    end
end

function CommonRaids:OnSure()
    local call = self.data.callbackOk;
    if call and call.call then
        if call.callObj then
            call.call(call.callObj, call.param);
        else
            call.call(call.param);
        end
    end
    self:DestroyUi();
end

function CommonRaids:OnAgain()
    local call = self.data.callbackAgain;
    if call and call.call then
        if call.callObj then
            call.call(call.callObj, call.param);
        else
            call.call(call.param);
        end
    end
    --CommonRaids.Start(self.data);
end

function CommonRaids:OnInitItem(obj,b,real_id)
    --app.log(table.tostring({obj,b,real_id}));
    local totalCount = #self.data.drop_items;
    local index = totalCount + real_id;
    local data = self.data.drop_items[index];
    --app.log(tostring(index).."......."..table.tostring({obj,b,real_id})..".."..table.tostring(data))
    if not data then
        app.log("道具次数少了   "..table.tostring(self.data));
    end
    b = b + 1;
    local itemList = self.itemList[b];
    if self.startAnimation and not self.isMoveLast then
        --itemList.objRoot:set_active(false);
        return;
    else

        itemList.objRoot:set_active(true);
        if data.isAwardsEx then
            itemList.labTitle:set_text(gs_misc['str_83']);
        else
            --app.log("OnInitItem....."..tostring(index))
            itemList.labTitle:set_text(string.format(gs_misc['str_87'], index));
        end
        for i = 1, UI_MAX_AWARDS_COUNT do

            if data.awards[i] then
                itemList["objItem"..i]:set_active(true);
                if itemList["item"..i] == nil then
                    itemList["item"..i] = UiSmallItem:new({parent = itemList["objItem"..i], is_enable_goods_tip = true});
                end
                itemList["item"..i]:SetDataNumber(data.awards[i].id, data.awards[i].count);
                itemList["item"..i]:SetAsReward(data.awards[i].id == self.data.goodsId);
                itemList["item"..i]:SetDouble(data.awards[i].radio_num);
                itemList["item"..i]:SetTuiJianLab(data.awards[i].isExtraActivity);
                itemList["spItem"..i]:set_color(1, 1, 1, 1);
            else
                itemList["objItem"..i]:set_active(false);
            end
        end
    end
end

function CommonRaids:OnItemMoveFinish()
    if not self.isMoveLast then
        self:PlayNextTimes();
    end
end

function CommonRaids:OnMoveLastFinish()
    self:AnimationOver();
end

function CommonRaids:OnFastMove()
    if not self.startAnimation or self.isMoveLast then
        return;
    end
    self:InitShowUiData();
    if #self.data.drop_items > 2 then
        self.wrapList:fast_move();
    else
        self:OnMoveLastFinish();
    end
end
--将所有的数据初始化好   c#只管移动
function CommonRaids:InitShowUiData()
    if not self.startAnimation then
        return;
    end
    self.isMoveLast = true;
    --只初始化到前一个item
    local oldIndex = self.playUiItem - 1;
    if oldIndex < 1 then
        oldIndex = UI_MAX_RAIDS_COUNT;
    end
    --如果当前是第一个 则需要初始化所有的item
    if self.playUiItem == 1 then
        oldIndex = 1;
    end
    while true do
        local itemList = self.itemList[self.playUiItem];
        local data = self.data.drop_items[self.playTimes];
        if data == nil then
            --app.log("playTimes="..tostring(self.playTimes).." "..table.tostring(self.data.drop_items));
            break;
        end
        itemList.objRoot:set_active(true);
        if data.isAwardsEx then
            itemList.labTitle:set_text(gs_misc['str_83']);
        else
            --app.log("InitShowUiData........."..tostring(self.playTimes));
            itemList.labTitle:set_text(string.format(gs_misc['str_87'], math.abs(self.playTimes)));
        end
        --初始化道具
        for i = 1, UI_MAX_AWARDS_COUNT do
            if data.awards[i] then
                itemList["objItem"..i]:set_active(true);
                if itemList["item"..i] == nil then
                    itemList["item"..i] = UiSmallItem:new({parent = itemList["objItem"..i], is_enable_goods_tip = true});
                end
                itemList["item"..i]:SetDataNumber(data.awards[i].id, data.awards[i].count);
                itemList["item"..i]:SetAsReward(data.awards[i].id == self.data.goodsId);

                itemList["item"..i]:SetDouble(data.awards[i].radio_num);
                itemList["item"..i]:SetTuiJianLab(data.awards[i].isExtraActivity);
                itemList["spItem"..i]:set_color(1, 1, 1, 1);
            else
                itemList["objItem"..i]:set_active(false);
            end
        end
        --第一个不需要对齐位置
        if self.playTimes ~= 1 then--and self.playTimes <= UI_MAX_RAIDS_COUNT then
            self.wrapList:align_pre_item(itemList.objRoot, true);
        end
        self.playUiItem = self.playUiItem + 1;
        self.playTimes = self.playTimes + 1;
        if self.playUiItem > UI_MAX_RAIDS_COUNT then
            self.playUiItem = 1;
        end
        if oldIndex == self.playUiItem then
            break;
        end
    end
end

function CommonRaids.ItemFinish()
    CommonRaids.isPlayNextItem = true;
end
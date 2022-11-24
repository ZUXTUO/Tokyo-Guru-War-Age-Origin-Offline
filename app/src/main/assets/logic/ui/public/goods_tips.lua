-- require "class"

GoodsTips = 
{
	initOnce = false,
	goodsClass = nil,
	showX = 0,
	showY = 0,
}
--------------------------------外部接口--------------------------------------
--开关一个tip
--show 是否显示
--id 道具id
--x,y 显示位置 当前对象所在位置
--height 道具高度
--level 装备等级 没有可以不传
--delay 延迟时间
function GoodsTips.EnableGoodsTips(show, id, count, x, y, height, level, delay)
	GoodsTips.isShow = show;
	if show then
		--有的话先删除
		if GoodsTips.goodsClass then
			GoodsTips.goodsClass = nil;
		end
		if PropsEnum.IsEquip(id) then
			GoodsTips.goodsClass = CardEquipment:new({number = id, level = level or 1});
		elseif PropsEnum.IsItem(id) or PropsEnum.IsVaria(id) then
			GoodsTips.goodsClass = CardProp:new({number = id, count = count});
		else
			app.log_warning("id 传入错误 id="..tostring(id));
			GoodsTips.Show(false);
			return;
		end
		--获取当前屏幕宽高
		local curWidth = app.get_screen_width();
		local curHeight = app.get_screen_height();

		GoodsTips.showX = x / curWidth * 1280;
		--上边沿点
		GoodsTips.showTopY = (y + height * 0.5) / curHeight * 720;
		--下边沿点
		GoodsTips.showBottomY = (y - height * 0.5) / curHeight * 720;
		if delay == 0 or delay == nil then
			GoodsTips.Init();
		else
			if GoodsTips.timerState then
				timer.stop(GoodsTips.timerState)
			end
			GoodsTips.timerState = timer.create("GoodsTips.DelayInit", delay, 1);
		end
    else
        GoodsTips.Show(show);
	end
end

----------------------------------------------------内部使用-------------------------------------------
local pathRes = "assetbundles/prefabs/ui/public/content_tips_item.assetbundle"
function GoodsTips.Init()
	-- --设计分辨率
	-- local curWidth = 1280;
	-- local curHeight = 720;
	-- --实际分辨率
	-- local dyWidth = app.get_screen_width();
	-- local dyHeight = app.get_screen_height();
	-- --得到实际应该高度应该是多少才成比例
	-- local realHeight = curHeight * dyWidth  / curWidth
	-- --求出高度差
	-- GoodsTips.diff = (dyHeight - realHeight) * 0.5;
	if GoodsTips.initOnce == false then
		GoodsTips.initOnce = true;
		GoodsTips.LoadAsset();
	else
		GoodsTips.UpdateShow();
	end
end

function GoodsTips.DelayInit()
    if GoodsTips.isShow then
	    GoodsTips.Init();
    end
end

function GoodsTips.LoadAsset()
    ResourceLoader.LoadAsset(pathRes, GoodsTips.OnLoaded);
end

function GoodsTips.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		GoodsTips.InitUi(asset_obj)
	end
end

function GoodsTips.Destroy()
	GoodsTips.ui = nil;
	GoodsTips.initOnce = false;
	GoodsTips.goodsClass = nil;
	GoodsTips.showX = 0;
	GoodsTips.showY = 0;
	local list = GoodsTips.controlList;
	if list.spHuman then
		list.spHuman:Destroy();
		list.spHuman = nil;
	end
	if list.uiSmallItem then
		list.uiSmallItem:DestroyUi();
		list.uiSmallItem = nil;
	end
end

function GoodsTips.InitUi(asset_obj)
	GoodsTips.ui = asset_game_object.create(asset_obj);
    GoodsTips.ui:set_name("GoodsTips");
    GoodsTips.ui:set_parent(Root.get_root_ui_2d());
    GoodsTips.ui:set_local_scale(1, 1, 1);
    GoodsTips.ui:set_local_position(0, 0, 0);

    local cont_equip = GoodsTips.ui:get_child_by_name("cont_equip");
    cont_equip:set_active(true);

    GoodsTips.controlList = {};


    local list = GoodsTips.controlList;
    --头像
    list.objHead = GoodsTips.ui:get_child_by_name("cont_equip/big_card_item_80");
   	list.uiSmallItem = UiSmallItem:new({parent = list.objHead});
    
   
    list.labName = ngui.find_label(GoodsTips.ui, "cont_equip/lab_name");
    list.labEquipType = ngui.find_label(GoodsTips.ui, "lab2");
    list.labLevel = ngui.find_label(GoodsTips.ui, "cont_equip/lab_num");
    list.labContent = ngui.find_label(GoodsTips.ui, "cont_equip/lab_describe");
    --获取界面宽高
    list.spDi = ngui.find_sprite(GoodsTips.ui, "cont_equip/sp_di");
    GoodsTips.oldHalfHeight = list.spDi:get_height() * 0.5;

	GoodsTips.UpdateShow();
end

--更新显示
function GoodsTips.UpdateShow()
	local data = GoodsTips.goodsClass;
	local list = GoodsTips.controlList;
	if data == nil or GoodsTips.ui == nil then
		return;
	end
    GoodsTips.ui:set_active(GoodsTips.isShow);
	--初始头像
	-- list.uiSmallItem:SetShowNumber(data.count > 0);
	-- list.uiSmallItem:SetDataNumber(data.number, data.count);
	list.uiSmallItem:SetShowNumber(false)
	list.uiSmallItem:SetDataNumber(data.number, 0)

	--道具基础信息
	list.labName:set_text(tostring(data.color_name));
	if data.level then
		list.labLevel:set_text("等级"..tostring(data.level));
	else
		local cf = PropsEnum.GetConfig(data.number);
		if cf and cf.tips_show_own and cf.tips_show_own > 0 then
			local haveCount = PropsEnum.GetValue(data.number)
			list.labLevel:set_text("拥有"..tostring(haveCount).."个");
		else
			list.labLevel:set_text("");
		end
	end
	--属性描述以及道具描述
	if type(data.GetPropertyVal) == "function" then
		local showProperty = CardHuman.GetDefaultSHowPropertyNames();
		local str = ""
		for k, v in spairs(showProperty) do
			local addValue = data:GetPropertyVal(v)
			local propertyId = ENUM.EHeroAttribute[v];
			local tempData = ConfigManager.Get(EConfigIndex.t_property_show, k);
			str = str.."+"..tostring(addValue)..tostring(tempData.showUnit)..tostring(gs_string_property_name[propertyId]).."\n";
		end
	else
		list.labContent:set_text(tostring(data.description));
	end
	list.spDi:update_anchors();
	list.diWidth = list.spDi:get_width();
    list.diHeight = list.spDi:get_height();
	--获取当前宽高
	local curWidth = 1280;
	local halfWidth = curWidth * 0.5;
	local curHeight = 720;
	local halfHeight = curHeight * 0.5;
	local halfDiWidth = list.diWidth * 0.5;
	--设置位置
	local screenX, screenTopY, screenBottomY = GoodsTips.showX, GoodsTips.showTopY, GoodsTips.showBottomY;
	--最终显示的屏幕坐标为showScreenX，showScreenY
	local showScreenX, showScreenY = 0, 0;
	--先确定x显示位置
	--先判断左右边界是否超界
	if screenX - halfDiWidth <= 0 then
		showScreenX = halfDiWidth;
	elseif screenX + halfDiWidth >= curWidth then
		showScreenX = curWidth - halfDiWidth;
	else
		showScreenX = screenX;
	end
	--再确定y显示位置
	--先判断上方是否超边界
	--app.log(tostring(screenTopY).."."..tostring(screenBottomY).."."..tostring(list.diHeight).."."..tostring(GoodsTips.oldHalfHeight));
	if screenTopY + list.diHeight > curHeight then
		showScreenY = screenBottomY - GoodsTips.oldHalfHeight;
	else
		showScreenY = screenTopY + (list.diHeight - GoodsTips.oldHalfHeight);
	end
	
	--app.log_warning("screenX="..screenX.." screenY="..screenY.." width="..curWidth.." height="..curHeight.." showScreenX="..showScreenX.." showScreenY="..showScreenY.." diWidth="..list.diWidth.." diHeight="..list.diHeight)
	--将屏幕坐标转换为ui坐标
	local sp_x = showScreenX - halfWidth;
	local sp_y = showScreenY - halfHeight;
	GoodsTips.ui:set_local_position(sp_x,  sp_y, 0);
end

function GoodsTips.Show(show)
	if GoodsTips.ui then
		GoodsTips.ui:set_active(show);
	end
end

-- 商店测试数据
local items_fake_1 = {
    {shop_item_id = 1001, nState = 0},
    {shop_item_id = 1002, nState = 0},
    {shop_item_id = 1003, nState = 0},
    {shop_item_id = 1004, nState = 0},
    {shop_item_id = 1005, nState = 0},
}

local items_fake_2 = {
    {shop_item_id = 2001, nState = 0},
    {shop_item_id = 2002, nState = 0},
    {shop_item_id = 2003, nState = 0},
}

local rewards_fake = {
	{dataid = '0', id = 2, count = 10000},
    {dataid = '0', id = 3, count = 100}
}

shop_local = {}

-- 得到某个商店的items
function shop_local.cg_shop_item_info(shopID)
    shop_local._shopID = shopID
	shop_local._itemTimerId = timer.create("shop_local.gc_shop_item_info", 200, 1);
end

function shop_local.gc_shop_item_info()
    --timer.stop(shop_local._itemTimerId)
    shop_local._itemTimerId = nil
    if shop_local._shopID == 1 then
        msg_shop.gc_shop_item_info(0, 0, 1, shop_local._shopID, items_fake_1)
    elseif shop_local._shopID == 2 then
        msg_shop.gc_shop_item_info(0, 0, 1, shop_local._shopID, items_fake_2)
    end
end

-- 购买商品
function shop_local.cg_buy_shop_item(shopItemID)
    shop_local._shopItemID = shopItemID
	shop_local._buyTimerId = timer.create("shop_local.gc_buy_shop_item", 200, 1);
end

function shop_local.gc_buy_shop_item()
    timer.stop(shop_local._buyTimerId)
    shop_local._buyTimerId = nil
    -- 更新
    local item = nil
    for _, v in ipairs(items_fake_1) do
        if v.shop_item_id == shop_local._shopItemID then
            v.nState = 1
            item = v
            break
        end        
    end
    msg_shop.gc_buy_shop_item(0, rewards_fake[1], item)
end
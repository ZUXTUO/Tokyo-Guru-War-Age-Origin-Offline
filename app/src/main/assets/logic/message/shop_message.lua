
local isLocalData = true

msg_shop = msg_shop or {}

--[[请求商店商品数据]]
function msg_shop.cg_shop_item_info(shop_id)
    --if not Socket.socketServer then return end    
    GLoading.Show(GLoading.EType.msg)
    --设置状态
    g_dataCenter.shopInfo:SetRequestShopData(true)
    if isLocalData then
        shop_local.cg_shop_item_info(shop_id)
    else        
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_shop.cg_shop_item_info(robot_s, "..shop_id..")")
        end
        nmsg_shop.cg_shop_item_info(Socket.socketServer, shop_id)
    end
end

--[[购买商品]]
function msg_shop.cg_buy_shop_item(shop_item_id)
    --if not Socket.socketServer then return end    
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then
        shop_local.cg_buy_shop_item(shop_item_id)
    else
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_shop.cg_buy_shop_item(robot_s, "..tostring(shop_item_id)..")")
        end
        nmsg_shop.cg_buy_shop_item(Socket.socketServer, shop_item_id)
    end
end

--[[手动刷新商店]]
function msg_shop.cg_refresh_shop(shop_id)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    if isLocalData then        
    else        
        nmsg_shop.cg_refresh_shop(Socket.socketServer, shop_id)
    end
end

function msg_shop.cg_sell_item_for_sell(ids)
    --if not Socket.socketServer then return end
    if AppConfig.script_recording then
        local _ids = "local ids = {}\n"
        for k, v in pairs(ids) do
            _ids = _ids.."param["..k.."] = "..tostring(v).."\n"
        end
        PublicFunc.RecordingScript(_ids.."nmsg_shop.cg_sell_item_for_sell(robot_s, ids)")
    end
    nmsg_shop.cg_sell_item_for_sell(Socket.socketServer, ids)
end

--------------------------------- 服务器 -------------------------------------------

--[[返回商店商品数据]]
--[[struct shop_Item_info
{
	int shop_item_id;
	int nItemCanBuyTimes;		//商品剩余可以购买次数
};]]
function msg_shop.gc_shop_item_info(result, refresh_time, refreshTimes, shop_id, items)
    GLoading.Hide(GLoading.EType.msg)    
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)   
        return
    end
    --app.log('----> shop_id=' .. shop_id .. ' time= ' .. refresh_time .. 
    --    ' count=' .. refreshTimes ..  '  items=' .. table.tostring(items))

    local lastEnabled = false
    if shop_id == ENUM.ShopID.MYSTERY then
        --已加载数据
        --if g_dataCenter.shopInfo:IsLoadData(shop_id) then
            lastEnabled = g_dataCenter.shopInfo:CheckShopIsEnabled(shop_id)
        --end
    end

    g_dataCenter.shopInfo:SetShopItems(shop_id, refresh_time, items, refreshTimes)
    PublicFunc.msg_dispatch(msg_shop.gc_shop_item_info, shop_id)
    --设置状态
    g_dataCenter.shopInfo:SetRequestShopData(false)
    
    if shop_id == ENUM.ShopID.MYSTERY then  
        if lastEnabled == false then
            if g_dataCenter.shopInfo:CheckShopIsEnabled(shop_id) then
                --显示弹窗提示
                g_dataCenter.shopInfo:SetShowPopup(true)
                PublicFunc.msg_dispatch(msg_shop.mystery_shop_open)
            end
        end     
        --检查商店时间  
        msg_shop.check_mystery_shop_time(shop_id, refresh_time) 
    end
end

--[[返回购买结果]]
function msg_shop.gc_buy_shop_item(result, reward, item)
    GLoading.Hide(GLoading.EType.msg)
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    g_dataCenter.shopInfo:UpdateShopItem(item)  
    --弹出奖励界面
    --CommonAward.Start({reward})
    PublicFunc.msg_dispatch(msg_shop.gc_buy_shop_item)  
end

--[[手动刷新商店]]
function msg_shop.gc_refresh_shop_result(result, shop_id, refreshTimes)
    GLoading.Hide(GLoading.EType.msg)    
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    --不用更新次数，刷新成功会调用gc_shop_item_info（）
end

--[[启动定时器，时间结束回调]]
function msg_shop.check_mystery_shop_time(shopId, refreshTime)
    if g_dataCenter.shopInfo:CheckShopIsEnabled(shopId) then
        local durationTime = g_dataCenter.shopInfo:GetMysteryDurationTime()
        TimerManager.Add(msg_shop.mystery_shop_close, (refreshTime + durationTime - system.time()) * 1000)
    end
end

function msg_shop.mystery_shop_open()
end

--[[神秘商店关闭]]
function msg_shop.mystery_shop_close() 
    --不显示弹窗提示
    g_dataCenter.shopInfo:SetShowPopup(false)
    PublicFunc.msg_dispatch(msg_shop.mystery_shop_close)
end

function msg_shop.gc_sell_item_for_sell(result, money)
    GLoading.Hide(GLoading.EType.msg)   
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)        
        return
    end
    --弹出奖励界面
    --[[local reward = {
        dataid = 0,
        id = IdConfig.Gold,
        count = money,
    }
    CommonAward.Start({reward})]]
    PublicFunc.msg_dispatch(msg_shop.gc_sell_item_for_sell, money)
end

--[[同步上次神秘商店开启的时间]]
function msg_shop.gc_last_mystical_open_time(refresh_time)
    g_dataCenter.shopInfo:SetRefreshTime(ENUM.ShopID.MYSTERY, refresh_time)
    --检查商店时间  
    msg_shop.check_mystery_shop_time(ENUM.ShopID.MYSTERY, refresh_time) 
end
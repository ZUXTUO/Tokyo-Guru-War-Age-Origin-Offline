
--体力(或 精力 或 其他二级货币)
function NavbarUI:on_ap()
	if g_open_memory_reference_info then
		g_memory_reference_info.m_cMethods.DumpMemorySnapshotComparedFile("./", "Compared", -1, "./LuaMemRefInfo-All-[1-Before].txt", "./LuaMemRefInfo-All-[2-After].txt");
	end
	if g_open_memory_reference_info or g_open_msg_regist or g_open_bind_callback then
		return;
	end
	if self.coinCfg and self.coin_cfg_ignore ~= true then
		-- 教堂精力兑换
		if self.coinCfg.id ==  10 then
			SpExchange.popPanel();

		elseif self.coinCfg.id == IdConfig.RedCrystal then
			uiManager:PushUi(EUI.ExchangeRedCrystalUI,{needcast =0}); 

		-- 通用获取途径
		elseif self.coinCfg.get_way == true then
			AcquiringWayUi.Start({item_id=self.coinCfg.id, number=0})
		end
	else
		HpExchange.popPanel();
	end

end

--金币
function NavbarUI:on_gold()
	--pvp test 
	--world_msg.cg_test_enter_world(1);
	if g_open_memory_reference_info then
		collectgarbage("collect");
		collectgarbage("collect");
		collectgarbage("collect");
		g_memory_reference_info.m_cMethods.DumpMemorySnapshot("./", "1-Before", -1);
	end
	if g_open_msg_regist then
		app.log("g_open_msg_regist "..tostring(table.get_num(g_msg_regist)));
		g_pre_msg_regist = table.deepcopy(g_msg_regist);
	end
	if g_open_bind_callback then
		app.log("g_open_bind_callback 1  "..tostring(table.get_num(g_bind_callback_name)).."  当前内存="..tostring(collectgarbage("count")));
		if table.get_num(g_bind_callback_name) > 0 then
			g_pre_bind_callback_name = table.deepcopy(g_bind_callback_name);
			g_pre_bind_callback = table.deepcopy(g_bind_callback);
		end
	end
	if g_open_memory_reference_info or g_open_msg_regist or g_open_bind_callback then
		return;
	end
    uiManager:PushUi(EUI.GoldExchangeUI)
	
end

--钻石
function NavbarUI:on_crystal()
	if g_open_memory_reference_info then
		collectgarbage("collect");
		collectgarbage("collect");
		collectgarbage("collect");
		g_memory_reference_info.m_cMethods.DumpMemorySnapshot("./", "2-After", -1);
	end
	if g_open_msg_regist then
		app.log("g_open_msg_regist "..tostring(table.get_num(g_msg_regist)));
		for k, v in pairs(g_msg_regist) do
			if g_pre_msg_regist[k] == nil then
				app.log(tostring(k)..".."..table.tostring(v));
			else
				-- app.log(tostring(k)..".."..tostring(table.get_num(v))..".."..tostring(table.get_num(g_pre_msg_regist[k])))
				if table.get_num(v) ~= table.get_num(g_pre_msg_regist[k]) then
					app.log(tostring(k)..".."..table.tostring(v))
				end
			end
			
		end
	end
	-- g_memory_reference_info.m_cMethods.DumpMemorySnapshot("./", "2-After", -1);
	if g_open_bind_callback then
		app.log("g_open_bind_callback 2  "..tostring(table.get_num(g_bind_callback_name)).." 当前内存="..tostring(collectgarbage("count")));
		for k, v in pairs(g_bind_callback_name) do
			if table.get_num(v) ~= table.get_num(g_pre_bind_callback_name[k]) then
				app.log(tostring(k)..".."..tostring(table.get_num(v))..".."..tostring(table.get_num(g_pre_bind_callback_name[k])));
				for m, n in pairs(v) do
					app.log(tostring(k).." debug="..tostring(g_bind_callback[n]));
				end
			end
		end
	end
	if g_open_memory_reference_info or g_open_msg_regist or g_open_bind_callback then
		return;
	end
	if g_dataCenter.player:GetGmSwitch() > 0 then
		uiManager:PushUi(EUI.UiGm);
	else
		uiManager:PushUi(EUI.StoreUI)	
	end
end

--规则
function NavbarUI:on_rule(t)
	local ruleId = t.float_value
	UiRuleDes.Start(ruleId)
end

function NavbarUI:customOnBack()
	if uiManager:GetCurScene() and uiManager:GetCurScene().on_navbar_back and uiManager:GetCurScene():on_navbar_back() then
		return true;
	end

    return false
end

function NavbarUI:customOnHome()
	if uiManager:GetCurScene() and uiManager:GetCurScene().on_navbar_home and uiManager:GetCurScene():on_navbar_home() then
		return true;
	end

    return false
end

--返回
function NavbarUI:on_back()
	if self:customOnBack() then
		return;
	end
	ChatUI.HideUI()
	uiManager:PopUi();
end

--回主界面
function NavbarUI:on_home()
	if self:customOnHome() then
		return;
	end

	uiManager:SetStackSize(1)
end

-- 兑换货币数据变化
function NavbarUI:on_item_data_change(cid)
    self:UpdateCoin()
end

------------------------------------------------------------------------
local _UIText = {
	[2] = "是否取消所有申请?"
}

function NavbarUI:InitChatFightUI()
	self.btnChatFightRequest = ngui.find_button(self.topContent, 'btn_duel')
	self.btnChatFightRequest:set_on_click(self.bindfunc['on_chat_fight_request'])
	self.btnChatFightCancel = ngui.find_button(self.topContent, 'btn_cha')
	self.btnChatFightCancel:set_on_click(self.bindfunc['on_chat_fight_cancel'])

	TimerManager.Add(self.bindfunc['check_chat_fight_request'], 1000, -1)
	self.isShowReqUI = nil
	self.btnChatFightRequest:set_active(false)
	self.btnChatFightCancel:set_active(false)
end

function NavbarUI:check_chat_fight_request()
	if not self:IsShow() then
		return
	end
	local _isShow = g_dataCenter.chatFight:HaveRequest(false)
	if self.isShowReqUI ~= _isShow then
		self.isShowReqUI = _isShow
		self.btnChatFightRequest:set_active(_isShow)
		self.btnChatFightCancel:set_active(_isShow)
	end
end

function NavbarUI:on_chat_fight_request()
	uiManager:PushUi(EUI.ChatFightRequestUI, {isFight = false})
end

function NavbarUI:on_chat_fight_cancel()
	local _func = function()
		msg_1v1.cg_cancel_challenge(0)
	end
	HintUI.SetAndShow(EHintUiType.two, _UIText[2],  {str="确定", func = _func}, {str="取消"});
end
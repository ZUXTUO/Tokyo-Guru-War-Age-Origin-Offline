SevenSignUiSignin = Class('SevenSignUiSignin', UiBaseClass);
function SevenSignUiSignin:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/sign/ui_200_checkin.assetbundle";
	UiBaseClass.Init(self, data);
end

function SevenSignUiSignin:Restart()
    if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

function SevenSignUiSignin:InitData(data)
	UiBaseClass.InitData(self, data);
	self.cardTable = {};
	self.markGoTable = {};
	self.effectTimer = nil;    
    self.textures = {}
end

function SevenSignUiSignin:DestroyUi()
    UiBaseClass.DestroyUi(self);
	for i = 1,7 do
		self.markGoTable[i] = nil;
        -- 释放资源
        if self.textures[i] then
            self.textures[i]:Destroy();
            self.textures[i] = nil;
        end
	end
	if self.effectTimer then
		timer.stop(self.effectTimer);
		self.effectTimer = nil;
	end
end

function SevenSignUiSignin:Show()
	if UiBaseClass.Show(self) then
	--todo 
	end
end

function SevenSignUiSignin:Hide()
    if UiBaseClass.Hide(self) then
	    if self.effectTimer then
		    timer.stop(self.effectTimer);
		    self.effectTimer = nil;
	    end
	end
end

function SevenSignUiSignin:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc['PlayEffect']    = Utility.bind_callback(self,SevenSignUiSignin.PlayEffect);
	self.bindfunc["on_card_click"] = Utility.bind_callback(self,SevenSignUiSignin.on_card_click);
    self.bindfunc["on_close"]      = Utility.bind_callback(self,SevenSignUiSignin.on_close);
    self.bindfunc["SetDayNum"]     = Utility.bind_callback(self,SevenSignUiSignin.SetDayNum);
end

function SevenSignUiSignin:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function SevenSignUiSignin:MsgRegist()
	UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_checkin.gc_checkin_info, self.bindfunc['SetDayNum'])
    PublicFunc.msg_regist(msg_checkin.gc_checkin_ret, self.bindfunc['SetDayNum'])
end

--注销消息分发回调函数
function SevenSignUiSignin:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_checkin.gc_checkin_info, self.bindfunc['SetDayNum'])
    PublicFunc.msg_unregist(msg_checkin.gc_checkin_ret, self.bindfunc['SetDayNum'])
end

--加载UI
function SevenSignUiSignin:LoadUI()
	if UiBaseClass.LoadUI(self) then
	--todo 
	end
end

function SevenSignUiSignin:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("seven_sign_Ui_sign_in");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);
	
    self.contentPath = 'seven_sign_Ui_sign_in/centre_other/animation/content'
	self.effect = ngui.find_sprite(self.ui, self.contentPath .. "/effect");
	
	for i = 1,7 do
		local card_item = ngui.find_button(self.ui, self.contentPath .. "/sp_bk"..i);		
        card_item:set_on_click(self.bindfunc["on_card_click"]);
		card_item:set_event_value("", i);        
        self.cardTable[i] = card_item;

		self.markGoTable[i] = asset_game_object.find(self.contentPath .. "/sp_bk"..i.."/sp_bk/mark");
        self.textures[i] = ngui.find_texture(self.ui, self.contentPath .. "/sp_bk"..i.."/sp_bk/sp_article")
	end

    -- 关闭窗口
    local btnFork = ngui.find_button(self.ui, "seven_sign_Ui_sign_in/centre_other/animation/btn_fork")
    btnFork:set_on_click(self.bindfunc["on_close"])
    
    local btnClose = ngui.find_button(self.ui,"seven_sign_Ui_sign_in/sp_mark")
    btnClose:set_on_click(self.bindfunc["on_close"])

    -- 先隐藏整个界面， 数据加载后显示
    self.ui:set_active(false)

    if g_checkin.isWeekDataInit == false then
		msg_checkin.cg_get_checkin_info();
    else 
        self:SetDayNum()
    end	
end
--表示当前是第几天领取
function SevenSignUiSignin:SetDayNum()    
    if not self.ui then
        return
    end
    self.ui:set_active(true)

	local dayNum = g_checkin.week.checkDay;

	for i = 1,7 do 
		local itemID   = ConfigManager.Get(EConfigIndex.t_checkin7,g_checkin.week.checkWeek)[i*2];
		local countNum = ConfigManager.Get(EConfigIndex.t_checkin7,g_checkin.week.checkWeek)[i*2+1];

		local cardData = PublicFunc.IdToConfig(itemID);
		if nil ~= cardData then 
			local lbl_name = ngui.find_label(self.ui, self.contentPath .. "/sp_bk"..i.."/lab_num");
            -- 英雄不显示数量
            if PropsEnum.IsRole(itemID) then
			    lbl_name:set_text(cardData.name)
            else 
                lbl_name:set_text(countNum..cardData.name)
            end

            -- set icon
            self.textures[i]:set_texture(cardData.small_icon)
            
            -- 外框
            local frame = ngui.find_sprite(self.ui, self.contentPath .. "/sp_bk"..i.."/sp_bk/sp_frame");
            PublicFunc.SetIconFrame(frame, itemID, countNum)
		end;
	
		if self.markGoTable[i] then
			if(dayNum >= i) then 
				self.markGoTable[i]:set_active(true);
                self.cardTable[i]:set_enable(false);
			else 
				self.markGoTable[i]:set_active(false);
                self.cardTable[i]:set_enable(true);
			end
		end
	end
	--如果当天可以领取 播放针动画
	self.effect:get_game_object():set_active(TimeAnalysis.checkCanGetToday());
	if TimeAnalysis.checkCanGetToday() == true then
		self.effectNum = 1;
		local x,y,z;
		if self.markGoTable[dayNum+1] then x,y,z = self.markGoTable[dayNum+1]:get_parent():get_parent():get_local_position();
		else x,y,z = self.markGoTable[1]:get_parent():get_parent():get_local_position();
		end
		self.effect:get_game_object():set_local_position(x,y,z);
		if self.effectTimer == nil then
			self.effectTimer = timer.create(self.bindfunc['PlayEffect'],100,-1);
		end
	else
		self.effectNum = 1;
		if self.effectTimer then
			timer.stop(self.effectTimer);
			self.effectTimer = nil;
		end
	end
end

function SevenSignUiSignin:PlayEffect()
	local str = 'fx_seven_checkin_'..self.effectNum;
	self.effect:set_sprite_name(str);
	self.effectNum = self.effectNum + 1;
	if(self.effectNum > 16) then self.effectNum = 1 end;
end

function SevenSignUiSignin:on_card_click(t)
	--如果今天已经签到或者跳跃签到 则返回
    local day = t.float_value;
	if TimeAnalysis.checkCanGetToday() == false or day > (g_checkin.week.checkDay + 1)then 
		HintUI.SetAndShow(EHintUiType.zero, "需要连续签到至对应天数后领取");
		return;
	end;	

    local itemID    = ConfigManager.Get(EConfigIndex.t_checkin7,g_checkin.week.checkWeek)[day*2];
	local countNum = ConfigManager.Get(EConfigIndex.t_checkin7,g_checkin.week.checkWeek)[day*2+1];
    self.cardID = itemID;	
	self.count = countNum;

	--请求签到 1代表7日签到 2代表月签到
	msg_checkin.cg_checkin(CheckinEnum.CHECKIN_TYPE.SEVEN_CHECKIN);
end

function SevenSignUiSignin:on_close()
	uiManager:PopUi();
end

function SevenSignUiSignin:ShowNavigationBar()
    return false
end

return SevenSignUiSignin

--背景音乐开关按钮
function UiSet:on_music_open()
        --app.log("1111111111111111111111111111111111111");
        self.musicOpen = self.MusicBtn:get_value()
        g_dataCenter.setting:SetMusic(self.musicOpen);
        --g_dataCenter.setting:Update();
end

--3d音效开关按钮
function UiSet:on_sound_open()
        --app.log("2222222222222222222222222222222222222");
        self.soundOpen = self.SoundBtn:get_value()
	g_dataCenter.setting:SetSound(self.soundOpen);
	--g_dataCenter.setting:Update();
end

function UiSet:on_intelligence_open()
        --app.log("3333333333333333333333333333333333333333");
        self.intelligenceOpen = self.intelligenceBtn:get_value()
        g_dataCenter.setting:Setintell(self.intelligenceOpen);
        --g_dataCenter.setting:Update();
end

function UiSet:on_huazhi_change()
    local value1 = self.huazhi1:get_value()
    local value2 = self.huazhi2:get_value()
    local value3 = self.huazhi3:get_value()
    --app.log("value1 ########  "..tostring(value1).."  value2 ########  "..tostring(value2).."  value3 ########  "..tostring(value3));
    if value1 then
        g_dataCenter.setting:SetHuazhiValue(1)
    elseif value2 then
        g_dataCenter.setting:SetHuazhiValue(2)
    elseif value3 then
        g_dataCenter.setting:SetHuazhiValue(3)
    end
    
end

function UiSet:on_renshu_change()
    local value1 = self.renshu1:get_value()
    local value2 = self.renshu2:get_value()
    local value3 = self.renshu3:get_value()
    --app.log("value1 ########  "..tostring(value1).."  value2 ########  "..tostring(value2).."  value3 ########  "..tostring(value3));
    if value1 then
        g_dataCenter.setting:SetRenshuValue(1)
    elseif value2 then
        g_dataCenter.setting:SetRenshuValue(2)
    elseif value3 then
        g_dataCenter.setting:SetRenshuValue(3)
    end
end

function UiSet:on_btn_close()

	self:Hide();
        g_dataCenter.setting:WriteFile();
	uiManager:PopUi();
        g_dataCenter.setting:Update();
end

function UiSet:on_btn_logout()
        
    local function onConfirm()
        self:Hide();
	uiManager:PopUi();
	--GameBegin.usercenter_logout_callback();
    UserCenter.sdk_logout();
    end
        
    HintUI.SetAndShowNew(EHintUiType.two,"提示","确定退出游戏，返回到登陆界面吗？",nil,{str="确定",func = onConfirm},{str = "取消"})
end

function UiSet:RealName_btn()
    UiAnn.Start(UiAnn.Type.RealNameAuth,nil,UserCenter.check_realname_auth)
end

function UiSet:on_exit()
	uiManager:PushUi(EUI.LoginInGame);
end

function UiSet:on_btn_set( )
    
    FightSetUI.Show();
end
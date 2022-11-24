
SetUiReName = Class("SetUiReName", UiBaseClass)

function SetUiReName:Init(data)
    self.SetUiReName = data
    self.pathRes = "assetbundles/prefabs/ui/set_ui/ui_main_amend_name.assetbundle"
    UiBaseClass.Init(self, data);
end

function SetUiReName:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function SetUiReName:InitData(data)
    UiBaseClass.InitData(self, data)
    
    self.castpaydata = ConfigManager._GetConfigTable(EConfigIndex.t_change_name)-- ConfigManager.Get(EConfigIndex.t_change_name,country_id).name
    self.castpayMax = #self.castpaydata
    
    self.useIndex = 1;
    self.listName = {};

end

function SetUiReName:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function SetUiReName:DestroyUi()
    --SceneManager.PopScene()
    UiBaseClass.DestroyUi(self);

end

function SetUiReName:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_Close'] = Utility.bind_callback(self, self.on_click_Close);
    self.bindfunc['on_click_OK'] = Utility.bind_callback(self, self.on_click_OK);
    self.bindfunc['on_click_Roll'] = Utility.bind_callback(self, self.on_click_Roll);
    
end


--注册消息分发回调函数
function SetUiReName:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_change_name,self.bindfunc['on_click_Close']);
end

--注销消息分发回调函数
function SetUiReName:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_change_name,self.bindfunc['on_click_Close']);
end


--初始化UI
function SetUiReName:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('SetUiReName');
    self.closeBtn = ngui.find_button(self.ui,"btn_cha")
    self.closeBtn:set_on_click(self.bindfunc['on_click_Close']);
    
    self.userMoneyText = ngui.find_label(self.ui,"centre_other/animation/cont/lab")
    
    self.rollnameBtn = ngui.find_button(self.ui,"btn_saizi")
    self.rollnameBtn:set_on_click(self.bindfunc['on_click_Roll']);
    
    self.inputName = ngui.find_input(self.ui,"centre_other/animation/input_account")
    self.OkBtn = ngui.find_button(self.ui,"centre_other/animation/btn")
    self.OkBtn:set_on_click(self.bindfunc['on_click_OK']);
    
    local number = 0;
    self.currentchangenametime = g_dataCenter.player.change_name_times
    app.log("changernamenumber============="..tostring(self.currentchangenametime))
    if self.currentchangenametime + 1 >= self.castpayMax then
	   number = self.castpayMax
    else
	   number = self.currentchangenametime + 1
    end
    
    local castpay = ConfigManager.Get(EConfigIndex.t_change_name,number).cost
    self.userMoneyText:set_text(tostring(castpay))
    
    player.cg_rand_name();
end

function SetUiReName:on_click_Roll()
    --当没有本地名字可以随机后  重新去服务器请求一批
    self.listName = g_dataCenter.player:getRollNameList();
    if self.useIndex > #self.listName then
	self.useIndex = 1;
	player.cg_rand_name();
    else
	if self.ui then
	    self:SetInputName(self.listName[self.useIndex]);
	    self.useIndex = self.useIndex + 1;
	end
    end
end

function SetUiReName:SetInputName(name)
    self.inputName:set_value(tostring(name));
end

function SetUiReName:on_click_Close()
    uiManager:PopUi()
end

function SetUiReName:on_click_OK()
    local name = self.inputName:get_value();
    
    local flag = true
    if name == "" then
        flag = false
    	FloatTip.Float("名字不能为空!");
        do return end
    end
    
    local ill_str = PublicFunc.Check_illegal(name);
    --app.log("ill_str==========="..ill_str)
    if ill_str ~= "" then
        flag = false
    	FloatTip.Float("名字包含非法信息："..ill_str);
        do return end
    end

    local count = PublicFunc.GetUtf8Character(name);
   
    if count < 2 then
        flag = false
    	FloatTip.Float("名字不能少于2个字符!");
        do return end
    end

    if count > 6 then
        flag = false
    	FloatTip.Float("名字不能多于6个字符!");
        do return end
    end
    
    if flag then
        player.cg_change_name( name )
        --app.log("######################change name")
    end
end

function SetUiReName:close()
    uiManager:PopUi()
end

function SetUiReName:UpdateUi()
   
end



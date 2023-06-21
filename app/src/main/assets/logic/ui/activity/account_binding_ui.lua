AccountBindingUI = Class("AccountBindingUI", UiBaseClass);

function AccountBindingUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/award/ui_1119_award.assetbundle";
    UiBaseClass.Init(self, data);
end

function AccountBindingUI:InitData(data)
    
    self.isBinddata = UserCenter.bind_accounts
    
    self.issucbound = false 
    
    for k,v in pairs(self.isBinddata) do
	if v.acc_type then
	    if tostring(v.acc_type) == tostring(2) then
		self.issucbound = true
	    end
	end
    end
        
    UiBaseClass.InitData(self, data);

end

function AccountBindingUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function AccountBindingUI:DestroyUi()
	
	for k,v in pairs(self.awardlist) do
		v:DestroyUi()
		self.awardlist = {};
	end
	
    UiBaseClass.DestroyUi(self)	
end

function AccountBindingUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_bind"] = Utility.bind_callback(self, self.on_bind)
        self.bindfunc["on_get_awards"] = Utility.bind_callback(self, self.on_get_awards)
end

--注册消息分发回调函数
function AccountBindingUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_get_bind_awards, self.bindfunc["on_get_awards"])
    
end

--注销消息分发回调函数
function AccountBindingUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_get_bind_awards, self.bindfunc["on_get_awards"])
    
end

function AccountBindingUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d():get_child_by_name("activity_ui"));
	self.ui:set_name("account_binding");
	self.ui:set_local_scale(1,1,1);
	self.ui:set_local_position(0,0,0);
	self.awardUilist = {};
	for i=1,5 do
		self.awardUilist[i] = self.ui:get_child_by_name("account_binding/texture/grid/new_small_card_item"..i)
	end
	
	self.bindbtn = ngui.find_button(self.ui,"account_binding/texture/btn_154x62")
        self.bindtext = ngui.find_label(self.ui,"account_binding/texture/btn_154x62/animation/lab")
        --self.bindtext:set_text("领取奖励")
        --app.log("g_dataCenter.player.is_get_bind_awards#####"..tostring(g_dataCenter.player.is_get_bind_awards))
        --app.log("issucbound###################"..tostring(self.issucbound))
        
	self.bindbtn:set_on_click(self.bindfunc['on_bind'])
	
	self:setData();
end

function AccountBindingUI:setData()
        
        if self.issucbound then
            if g_dataCenter.player.is_get_bind_awards == 0 then
                self.bindtext:set_text("领取奖励")
            else
                --self.bindtext:set_text("领取奖励")
                self.bindbtn:set_active(false)
            end
        else
            self.bindtext:set_text("绑定帐号")
        end
        
	self.dropId = ConfigManager.Get(EConfigIndex.t_discrete,83000135).data;
	self.awardData = ConfigManager.Get(EConfigIndex.t_drop_something,self.dropId);
	--app.log("self.awardData##########"..table.tostring(self.awardData))
	self.awardlist = {};
	
        for k,v in pairs(self.awardData)do
		local card_prop = CardProp:new({number = v.goods_id,count = v.goods_number});
		self.awardlist[k] = UiSmallItem:new({parent = self.awardUilist[k], cardInfo = card_prop,});
		self.awardlist[k]:SetCount(v.goods_number)
	end
end

function AccountBindingUI:on_bind()
        if self.issucbound then
            --app.log("##########111111111")
            player.cg_get_bind_awards()
        else    
            uiManager:PushUi(EUI.LoginInGame);
        end
end

function AccountBindingUI:on_get_awards(list)
    
    local callback = function()
        
    end
    
    
    CommonAward.Start(list, tType)
    CommonAward.SetFinishCallback(callback,self)
end
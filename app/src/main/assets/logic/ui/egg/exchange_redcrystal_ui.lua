ExchangeRedCrystalUI = Class('ExchangeRedCrystalUI', UiBaseClass);

function ExchangeRedCrystalUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/egg/panel_exchange_ruby.assetbundle"
	UiBaseClass.Init(self, data);
    --app.log("2222222222222222222222222222222222222")
end

function ExchangeRedCrystalUI:Restart(data)

    --app.log("3333333333333333333333333333333333")
    
    if data then
        if data.needcast then
            app.log("needcast==============="..tostring(data.needcast))
            self.needcast = data.needcast
        end
    end
	
    if UiBaseClass.Restart(self, data) then
	--todo 
	end

    
end

--初始化数据
function ExchangeRedCrystalUI:InitData(data)
    UiBaseClass.InitData(self, data);
    
    self.maxExchangeNum = 10000
end

function ExchangeRedCrystalUI:DestroyUi()
    
    self.casthongzhuan = 0;
    self.needcast = 0;
    UiBaseClass.DestroyUi(self);
end

function ExchangeRedCrystalUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
    self.bindfunc["on_buy_hongzhuan"] = Utility.bind_callback(self, self.on_buy_hongzhuan)
    self.bindfunc["OnSiderValueChange"] = Utility.bind_callback(self, self.OnSiderValueChange)
    self.bindfunc["on_change_mini"] = Utility.bind_callback(self,self.on_change_mini)
    self.bindfunc["on_change_max"] = Utility.bind_callback(self,self.on_change_max)
    self.bindfunc["on_close"] = Utility.bind_callback(self,self.on_close)
end

--注册消息分发回调函数
function ExchangeRedCrystalUI:MsgRegist()
    --app.log("FloatTip:MsgRegist");
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function ExchangeRedCrystalUI:MsgUnRegist()
    --app.log("FloatTip:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
    
end


function ExchangeRedCrystalUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    --app.log("111111111111111111111111111111111111111111")
	self.ui:set_name("ExchangeRedCrystalUI");

    self.tiaoslider = ngui.find_slider(self.ui, "centre_other/animation/cont/act/pro_back")

    self.tiaoslider:set_on_change(self.bindfunc["OnSiderValueChange"])

    self.minibtnSp = ngui.find_sprite(self.ui, "centre_other/animation/cont/act/btn_red/sp_red")
    self.minibtn = ngui.find_button(self.ui,"centre_other/animation/cont/act/btn_red")
    self.minibtn:set_on_click(self.bindfunc["on_change_mini"]);
    self.maxbtnSp = ngui.find_sprite(self.ui, "centre_other/animation/cont/act/btn_blue/sp_red")
    self.maxbtn = ngui.find_button(self.ui,"centre_other/animation/cont/act/btn_blue")
    self.maxbtn:set_on_click(self.bindfunc["on_change_max"]);

    self.buybtn = ngui.find_button(self.ui,"centre_other/animation/cont/btn1")
    self.buybtn:set_on_click(self.bindfunc["on_buy_hongzhuan"]);

    self.hongzhuanlab = ngui.find_label(self.ui,"centre_other/animation/cont/content1/lab")
    self.zhuanshilab = ngui.find_label(self.ui,"centre_other/animation/cont/content2/lab")

    self.closebtn = ngui.find_button(self.ui,"centre_other/animation/content_di_754_458/btn_cha")
    self.closebtn:set_on_click(self.bindfunc["on_close"]);
	
    self:UpdateUi()
end

function ExchangeRedCrystalUI:UpdateUi()

    local cast = 0
    if self.needcast then
        cast = self.needcast
    end

    local hongzhuan = g_dataCenter.player.crystal
    --app.log("hongzhuan============="..tostring(hongzhuan))
    if hongzhuan == 0 then
        if cast == 0 then
            self.hongzhuanlab:set_text("1")
            self.zhuanshilab:set_text("1")
            self.casthongzhuan = 1
            self.tiaoslider:set_value(0)
        else
            self.hongzhuanlab:set_text(tostring(cast))
            self.zhuanshilab:set_text(tostring(cast))
            self.casthongzhuan = cast
            self.tiaoslider:set_value(cast/self.maxExchangeNum)           
        end
    else
        if cast > hongzhuan then
            if cast == 0 then
                self.hongzhuanlab:set_text("1")
                self.zhuanshilab:set_text("1")
                self.casthongzhuan = 1
                self.tiaoslider:set_value(0)
            else
                self.hongzhuanlab:set_text(tostring(cast))
                self.zhuanshilab:set_text(tostring(cast))
                local need = cast-hongzhuan
                self.casthongzhuan = need
                --app.log("hongzhuanlab==============="..tostring(hongzhuan))
                --app.log("cast======================="..tostring(cast))
                self.tiaoslider:set_value(self.needcast/self.maxExchangeNum)
            end
        else
            --app.log("cast222222==================="..tostring(cast))
            self.casthongzhuan = cast
            self.hongzhuanlab:set_text(tostring(cast))
            self.zhuanshilab:set_text(tostring(cast))
            if cast == 0 or hongzhuan == 0 then
                self.tiaoslider:set_value(0)
            else
                self.tiaoslider:set_value(self.casthongzhuan/self.maxExchangeNum)
            end
        end
    end
end

function ExchangeRedCrystalUI:on_buy_hongzhuan()

    local function showvip()
        uiManager:PushUi(EUI.StoreUI);
    end

    local Maxvalue = g_dataCenter.player.crystal
    --app.log("casthongzhuan============="..tostring(self.casthongzhuan))
    if self.casthongzhuan > 0 then
        --协议
        if self.casthongzhuan <= Maxvalue then
            player.cg_exchange_red_crystal(self.casthongzhuan);
            uiManager:PopUi();
        else
            HintUI.SetAndShow(EHintUiType.two, "当前钻石不足，是否前往购买？",
            {str = "是", func = showvip},{str = "否",}
            );
        end
    end   
end


function ExchangeRedCrystalUI:OnSiderValueChange(value)

    --app.log("value============================"..tostring(value))

    local Maxvalue = g_dataCenter.player.crystal

    if value > 0 then
        
        if self.needcast > Maxvalue then
            local count = PublicFunc.Round(value * self.maxExchangeNum)
            self.casthongzhuan = count
            if self.casthongzhuan > Maxvalue then
                self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
                self.zhuanshilab:set_text("[FF0000FF]"..tostring(self.casthongzhuan).."[-]")
            else
                self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
                self.zhuanshilab:set_text("[EBEB74FF]"..tostring(self.casthongzhuan).."[-]")
            end
        else
            local count = PublicFunc.Round(value * self.maxExchangeNum)
            
            self.casthongzhuan = count

            --app.log("casthongzhuan=================="..tostring(self.casthongzhuan))

            -- if self.casthongzhuan > Maxvalue then
            --     self.casthongzhuan = Maxvalue
            -- end
            if self.casthongzhuan > Maxvalue then
                self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
                self.zhuanshilab:set_text("[FF0000FF]"..tostring(self.casthongzhuan).."[-]")
            else
                self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
                self.zhuanshilab:set_text("[EBEB74FF]"..tostring(self.casthongzhuan).."[-]")
            end
        end
        
        
    else
        self.casthongzhuan = 1
        if self.casthongzhuan > Maxvalue then
            self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
            self.zhuanshilab:set_text("[FF0000FF]"..tostring(self.casthongzhuan).."[-]")
        else
            self.hongzhuanlab:set_text(tostring(self.casthongzhuan))
            self.zhuanshilab:set_text("[EBEB74FF]"..tostring(self.casthongzhuan).."[-]")
        end
    end


    if self.casthongzhuan <= 1 then
        self.minibtnSp:set_color(0, 0, 0, 1)
    else
        self.minibtnSp:set_color(1, 1, 1, 1)
    end

    if self.casthongzhuan >= self.maxExchangeNum then
        self.maxbtnSp:set_color(0, 0, 0, 1)
    else
        self.maxbtnSp:set_color(1, 1, 1, 1)
    end
end

function ExchangeRedCrystalUI:on_change_mini(t)
    local value = self.tiaoslider:get_value()
    if value <= 0 then return end

    value = value - 1/(self.maxExchangeNum - 1)
    self.tiaoslider:set_value(value)
    
end

function ExchangeRedCrystalUI:on_change_max(t)
    local value = self.tiaoslider:get_value()
    if value >= 1 then return end

    value = value + 1/(self.maxExchangeNum - 1)
    self.tiaoslider:set_value(value)
    
end

function ExchangeRedCrystalUI:on_close()
    uiManager:PopUi();
end

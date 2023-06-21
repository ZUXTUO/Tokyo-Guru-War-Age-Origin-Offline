
Trainninginfotip = Class("Trainninginfotip", UiBaseClass)

function Trainninginfotip.Start(data)
    if Trainninginfotip.instance then
        Trainninginfotip.instance:setInfo(data)
    else
	Trainninginfotip.instance = Trainninginfotip:new(data);
    end
end

function Trainninginfotip.Destroy()
    if Trainninginfotip.instance then
        Trainninginfotip.instance:Hide();
        --Trainninginfotip.instance = nil;
    end
end

function Trainninginfotip:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function Trainninginfotip:Hide()
    UiBaseClass.Hide(self);
end

function Trainninginfotip:setInfo(data)
    self.x = data.x
    self.y = data.y
    self.z = data.z
    self.value = data.value
    self:setData()
    self:Show();
end

function Trainninginfotip:Init(data)
    self.Trainninginfotip = data
    self.x = data.x
    self.y = data.y
    self.z = data.z
    self.value = data.value
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4609_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function Trainninginfotip:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function Trainninginfotip:InitData(data)
    UiBaseClass.InitData(self, data)

    
end

function Trainninginfotip:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainninginfotip:DestroyUi()
    
    UiBaseClass.DestroyUi(self);

end

function Trainninginfotip:RegistFunc()
    UiBaseClass.RegistFunc(self);

end


--注册消息分发回调函数
function Trainninginfotip:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function Trainninginfotip:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function Trainninginfotip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('Trainninginfotip');
    --self.ui:set_local_position(self.x,self.y,self.z)
    self.textlab = ngui.find_label(self.ui,"centre_other/animation/info1_tips/lab")
    
    
    self.spDi = ngui.find_sprite(self.ui, "centre_other/animation/info1_tips/sprite_background");
    
    
    
    self:setData()
end

function Trainninginfotip:setData()
    
    self.oldHalfHeight = self.spDi:get_height() * 0.5;
    
    --获取当前屏幕宽高
    local curWidth = app.get_screen_width();
    local curHeight = app.get_screen_height();
    
    local height = self.z

    self.showX = self.x / curWidth * 1280;
    --上边沿点
    self.showTopY = (self.y + height * 0.5) / curHeight * 720;
    --下边沿点
    self.showBottomY = (self.y - height * 0.5) / curHeight * 720;
    
    self.spDi:update_anchors();
    self.diWidth = self.spDi:get_width();
    self.diHeight = self.spDi:get_height();
	
    --获取当前宽高
    local curWidth = 1280;
    local halfWidth = curWidth * 0.5;
    local curHeight = 720;
    local halfHeight = curHeight * 0.5;
    local halfDiWidth = self.diWidth * 0.5;
    --设置位置
    local screenX, screenTopY, screenBottomY = self.showX, self.showTopY, self.showBottomY;
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
    if screenTopY + self.diHeight > curHeight then
	    showScreenY = screenBottomY - self.oldHalfHeight;
    else
	    showScreenY = screenTopY + (self.diHeight - self.oldHalfHeight);
    end
    
    --app.log_warning("screenX="..screenX.." screenY="..screenY.." width="..curWidth.." height="..curHeight.." showScreenX="..showScreenX.." showScreenY="..showScreenY.." diWidth="..list.diWidth.." diHeight="..list.diHeight)
    --将屏幕坐标转换为ui坐标
    local sp_x = showScreenX - halfWidth;
    local sp_y = showScreenY - halfHeight;
    
    self.ui:set_local_position(sp_x,  sp_y, 0);
    
    
    --app.log("text ####################"..text)
    self.textlab:set_text(self.value)--("每400点战队全能值提升加伤率1%,减伤率0.8%.仅对其它玩家英雄有效.")
end

function Trainninginfotip:UpdateUi()
    
end




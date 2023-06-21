
Trainningmaintip = Class("Trainningmaintip", UiBaseClass)

function Trainningmaintip.Start(data)
    if Trainningmaintip.instance then
        Trainningmaintip.Destroy()
    end
    Trainningmaintip.instance = Trainningmaintip:new(data);
end

function Trainningmaintip.Destroy()
    if Trainningmaintip.instance then
        Trainningmaintip.instance:DestroyUi();
        Trainningmaintip.instance = nil;
    end
end

function Trainningmaintip:Init(data)
    self.Trainningmaintip = data
    self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4610_zhandui.assetbundle"
    UiBaseClass.Init(self, data);
end

function Trainningmaintip:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function Trainningmaintip:InitData(data)
    UiBaseClass.InitData(self, data)

    
end

function Trainningmaintip:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainningmaintip:DestroyUi()
    
    UiBaseClass.DestroyUi(self);

end

function Trainningmaintip:RegistFunc()
    UiBaseClass.RegistFunc(self);

end


--注册消息分发回调函数
function Trainningmaintip:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function Trainningmaintip:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function Trainningmaintip:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('Trainningmaintip');
    self.textlab = ngui.find_label(self.ui,"centre_other/animation/right_tips/lab")
    self:setData()
end

function Trainningmaintip:setData()
    local adddata = ConfigManager.Get(EConfigIndex.t_discrete,83000123).data;
    local Damagedata = ConfigManager.Get(EConfigIndex.t_discrete,83000124).data;
    
    self.textlab:set_text("加伤率："..tostring(adddata*self.Trainningmaintip).."\n".."减伤率："..tostring(Damagedata*self.Trainningmaintip))
end

function Trainningmaintip:UpdateUi()
    
end





ChurchBotLoad = Class("ChurchBotLoad", UiBaseClass)

function ChurchBotLoad.Start(data)
    if ChurchBotLoad.instance then
        ChurchBotLoad.Destroy()
    end
    ChurchBotLoad.instance = ChurchBotLoad:new(data);
end

function ChurchBotLoad.Destroy()
    if ChurchBotLoad.instance then
        ChurchBotLoad.instance:DestroyUi();
        ChurchBotLoad.instance = nil;
    end
end

function ChurchBotLoad:Init(data)
    self.ChurchBotLoad = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1607_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotLoad:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotLoad:InitData(data)
    self.currentindex = 1
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotLoad:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotLoad:DestroyUi()
    
    UiBaseClass.DestroyUi(self);

end

function ChurchBotLoad:RegistFunc()
    UiBaseClass.RegistFunc(self);
    
    
end


--注册消息分发回调函数
function ChurchBotLoad:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function ChurchBotLoad:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function ChurchBotLoad:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotLoad');
    
end

function ChurchBotLoad:setData()
    
    
end

function ChurchBotLoad:on_btn_close()
    uiManager:PopUi();
end

function ChurchBotLoad:on_select(t)
    
end

function ChurchBotLoad:UpdateUi()
    
end




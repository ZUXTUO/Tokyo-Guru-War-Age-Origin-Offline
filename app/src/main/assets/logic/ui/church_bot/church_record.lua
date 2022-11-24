
ChurchBotRecord = Class("ChurchBotRecord", UiBaseClass)


function ChurchBotRecord:Init(data)
    self.ChurchBotRecord = data
    self.pathRes = "assetbundles/prefabs/ui/lueduo/ui_1611_lueduo.assetbundle"
    UiBaseClass.Init(self, data);
end

function ChurchBotRecord:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function ChurchBotRecord:InitData(data)
    --self.currentindex = 1
    UiBaseClass.InitData(self, data)

    
end

function ChurchBotRecord:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function ChurchBotRecord:DestroyUi()
    
    UiBaseClass.DestroyUi(self);

end

function ChurchBotRecord:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)      --关闭
    --self.bindfunc["onClickRoleCard"] = Utility.bind_callback(self, self.onClickRoleCard)
end


--注册消息分发回调函数
function ChurchBotRecord:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

--注销消息分发回调函数
function ChurchBotRecord:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end


--初始化UI
function ChurchBotRecord:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ChurchBotRecord');
    self.closebtn = ngui.find_button(self.ui,"center_other/animation/btn_cha")
    self.closebtn:set_on_click(self.bindfunc['on_btn_close'])
    
    self.mynamelist = {};
    self.myheadlist = {};
    self.mylvllist = {};
    self.myiswinlist = {};
    
    self.othernamelist = {};
    self.otherheadlist = {};
    self.otherlvllist = {};
    self.otheriswinlist = {};
    
    self.item = {};
    
    for i =1,3 do
	self.mynamelist = ngui.find_label(self.ui,"center_other/animation/list"..i.."/sp_di1/lab_name")
	self.myheadlist = self.ui:get_child_by_name("center_other/animation/list"..i.."/sp_di1/sp_head_di_item")
	self.mylvllist = ngui.find_label(self.ui,"center_other/animation/list"..i.."/sp_di1/lab_level")
	self.myiswinlist =  ngui.find_sprite(self.ui,"center_other/animation/list"..i.."/sp_di1/sp_win")
	
	self.othernamelist = ngui.find_label(self.ui,"center_other/animation/list"..i.."/sp_di2/lab_name")
	self.otherheadlist = self.ui:get_child_by_name("center_other/animation/list"..i.."/sp_di2/sp_head_di_item")
	self.otherlvllist = ngui.find_label(self.ui,"center_other/animation/list"..i.."/sp_di2/lab_level")
	self.otheriswinlist = ngui.find_sprite(self.ui,"center_other/animation/list"..i.."/sp_di2/sp_win")
	
	self.item = self.ui:get_child_by_name("center_other/animation/list"..i)
    end
    
    
    self.otherheadlist1 = {};
    
    
    
    self:setBattleUI()
    
end

function ChurchBotRecord:setBattleUI()
    
    
end

function ChurchBotRecord:on_btn_close()
    uiManager:PopUi();
end


function ChurchBotRecord:UpdateUi()
    
end




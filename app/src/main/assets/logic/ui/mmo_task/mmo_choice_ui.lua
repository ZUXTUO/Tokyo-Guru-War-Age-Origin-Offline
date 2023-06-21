MMOChoiceUI = Class("MMOChoiceUI",UiBaseClass);

---------------------------------------
-- isCenter 设置des的文本是否居中显示
-- btnList = {{lab="xxx",callback=,param=},}
function MMOChoiceUI:SetInfo(title,des,btn_list)
	self.title = title;
	self.des = des;
	self.btnInfoList = btn_list;
	self:UpdateUi();
end
---------------------------------------

--初始化
function MMOChoiceUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/mmo_task/ui_3302_task.assetbundle';
    UiBaseClass.Init(self, data);
end

function MMOChoiceUI:ShowNavigationBar()
	return false;
end

--初始化数据
function MMOChoiceUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.btnNum = 6;
end

--重新开始
function MMOChoiceUI:Restart(data)
	self.btnInfoList = {};
    UiBaseClass.Restart(self, data);
	self.title = "";
	self.des = "";
	self.isCenter = false;
end

--析构函数
function MMOChoiceUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

--注册回调函数
function MMOChoiceUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_close'] = Utility.bind_callback(self, self.on_close);
    self.bindfunc['on_click'] = Utility.bind_callback(self, self.on_click);
end

--注册消息分发回调函数
function MMOChoiceUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function MMOChoiceUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--寻找ngui对象
function MMOChoiceUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    -- self.ui:set_name('mmo_task_choice_ui');
    self.labName = ngui.find_label(self.ui,"centre_other/animation/content/lab_name");
    self.labDes = ngui.find_label(self.ui,"centre_other/animation/content/txt1");
    -- self.labCurPos = ngui.find_label(self.ui,"centre_other/animation/content/lab_area");
    local btnFork = ngui.find_button(self.ui,"sp_mark");
    btnFork:set_on_click(self.bindfunc["on_close"]);

    self.btnList = {};
    for i=1,self.btnNum do 
    	self.btnList[i] = {};
    	self.btnList[i].lab = ngui.find_label(self.ui,"centre_other/animation/content/btn"..i.."/lab");
    	self.btnList[i].btn = ngui.find_button(self.ui,"centre_other/animation/content/btn"..i);
    	self.btnList[i].btn:set_on_click(self.bindfunc["on_click"]);
    	self.btnList[i].btn:set_event_value("",i);
    end
    
	self:UpdateUi();
end

--刷新界面
function MMOChoiceUI:UpdateUi()
	if self.ui == nil then return end
	if self.title then
		self.labName:set_text(tostring(self.title));
	end
	if self.des then
		self.labDes:set_text(tostring(self.des));
		-- self.labCurPos:set_text(tostring(self.des));
	end
	-- if self.isCenter then
	-- 	self.labDes:set_active(false);
	-- 	self.labCurPos:set_active(true);
	-- else
	-- 	self.labDes:set_active(true);
	-- 	self.labCurPos:set_active(false);
	-- end
	for i=1,self.btnNum do 
		local info = self.btnInfoList[i];
		if info then
			self.btnList[i].lab:set_text(tostring(info.lab));
			self.btnList[i].btn:set_active(true);
		else
			self.btnList[i].btn:set_active(false);
		end
	end
end

function MMOChoiceUI:on_close()
	uiManager:PopUi();
end

function MMOChoiceUI:on_click(t)
	local index = t.float_value;
	local info = self.btnInfoList[index];
	if not info then
		return;
	end
	Utility.CallFunc(info.callback,info.param);
end

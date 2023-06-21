--独立的系统通用提示框，逻辑功能不要使用这个提示框
--没有按钮
--一个按钮
--两个按钮
--三个按钮
SystemHintUI = Class("SystemHintUI");

ESystemHintUIType = 
{
	zero = 0,
	one = 1,
	two = 2,
	three = 3,
	four = 4,
}

local pathRes = {};
pathRes.SystemHintUI = "assetbundles/prefabs/ui/public/system_panel_hint.assetbundle";

----------------------外部接口---------------------------------
--显示通用提示框
--例子：SystemHintUI.SetAndShow(ESystemHintUIType.three, "xxxxx", {str = "确定",func = self.bindfunc["on_organization"]},{str = "取消",func = self.bindfunc["on_organization"]},{str = "哈哈",func = self.bindfunc["on_organization"]})
-- type  窗口类型 ESystemHintUIType 
-- content 显示文字
-- btn1Data btn2Data btn3Data btn4Data =
--{
-- 	str  按钮上文字
-- 	func 按钮回调
--	param 回调参数
-- 	time 该时间后自动点击该按钮（只能有一个）
--}
function SystemHintUI.SetAndShow(type, content, btn1Data, btn2Data, btn3Data, btn4Data, notClose)
	if SystemHintUI.instance then
		SystemHintUI.instance:SetInfo(type, '', content, nil, btn1Data, btn2Data, btn3Data, btn4Data, nil, notClose)
	else
		SystemHintUI.instance = SystemHintUI:new({type = type, title = '', content = content, nil, btn1Data = btn1Data, btn2Data = btn2Data, btn3Data = btn3Data, btn4Data = btn4Data, notClose=notClose});
	end
end

function SystemHintUI.SetTwoAndShow(type, content1, content2, btn1Data, btn2Data, btn3Data,btn4Data)
	if SystemHintUI.instance then
		SystemHintUI.instance:SetInfo(type, '', content1, nil, btn1Data, btn2Data, btn3Data,btn4Data, content2)
	else
		SystemHintUI.instance = SystemHintUI:new({type = type, title = '', content = content1, content2=content2, nil, btn1Data = btn1Data, btn2Data = btn2Data, btn3Data = btn3Data,btn4Data = btn4Data});
	end
end

function SystemHintUI.SetAndShowNew(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data, btn4Data)
    --app.log(content.." "..debug.traceback())
    if SystemHintUI.instance then
		SystemHintUI.instance:SetInfo(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data, btn4Data)
	else
		SystemHintUI.instance = SystemHintUI:new({type = type, title = title, content = content, btnSpace = btnSpace, btn1Data = btn1Data, btn2Data = btn2Data, 
            btn3Data = btn3Data, btn4Data = btn4Data});
	end
end

function SystemHintUI.Instance()
    if SystemHintUI.instance == nil then
        SystemHintUI.instance = SystemHintUI:new({});
    end
end

--显示在引导层
function SystemHintUI.SetGuideMode()
    if SystemHintUI.instance then
    	SystemHintUI.instance.guide_mode = true
    end
end

function SystemHintUI.hide()
	if SystemHintUI.instance then
		SystemHintUI.instance:Hide();
	end
end

function SystemHintUI.Destroy()
	if SystemHintUI.instance then
		SystemHintUI.instance:DestroyUi();
		SystemHintUI.instance = nil;
	end
end

-------------------------内部接口------------------------------
--btn1Data = {str = "xxx",func = "callback"}
function SystemHintUI:InitData(data)
    self.ui = nil;
	self.bindfunc = {};
	
	self.type = data.type;
	self.title = data.title
	self.content = data.content;
	self.content2 = data.content2;
    self.btnSpace = data.btnSpace;
	self.btn1Data = data.btn1Data;
	self.btn2Data = data.btn2Data;
	self.btn3Data = data.btn3Data;
	self.btn4Data = data.btn4Data;
	self.notClose = data.notClose;
end

function SystemHintUI:Init(data)
    self:InitData(data)
    self:RegistFunc();

    self.noticeManager = NoticeManager
	if NoticeManager then
		NoticeManager.BeginListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
	end

    self:InitUI();
end

function SystemHintUI:RegistFunc()
    self.bindfunc["on_loaded"] = Utility.bind_callback(self, SystemHintUI.on_loaded)
	self.bindfunc["on_btn1_click"] = Utility.bind_callback(self, SystemHintUI.on_btn1_click)
	self.bindfunc["on_btn2_click"] = Utility.bind_callback(self, SystemHintUI.on_btn2_click)
	self.bindfunc["on_btn3_click"] = Utility.bind_callback(self, SystemHintUI.on_btn3_click)
	self.bindfunc["on_btn4_click"] = Utility.bind_callback(self, SystemHintUI.on_btn4_click)
	self.bindfunc["on_space_click"] = Utility.bind_callback(self, SystemHintUI.on_space_click)
	self.bindfunc["on_close_click"] = Utility.bind_callback(self, SystemHintUI.on_close_click)
	self.bindfunc["on_time"] = Utility.bind_callback(self, SystemHintUI.on_time)
	self.bindfunc["on_click_head"] = Utility.bind_callback(self, SystemHintUI.on_click_head);

	self.bindfunc['on_guide_camera_change'] = Utility.bind_callback(self, self.on_guide_camera_change);
end

function SystemHintUI:UnregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function SystemHintUI:InitUI()
	if(self.ui == nil)then
		self._asset_loader = systems_func.loader_create("SystemHintUI_loader")
		self._asset_loader:set_callback(self.bindfunc["on_loaded"])
		self._asset_loader:load(pathRes.SystemHintUI);
		self._asset_loader = nil;
	end
end

function SystemHintUI:on_loaded(pid, filepath, asset_obj, error_info)
	if(filepath == pathRes.SystemHintUI) then
		self:InitSystemHintUI(asset_obj);
	end
end

function SystemHintUI:InitSystemHintUI(obj)
	self.ui = systems_func.game_object_create(obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0)
	self.ui:set_name("system_hint_ui");
	self.ui:set_local_position(0,0,0);
	--do return end
	self.btnBk = systems_func.ngui_find_button(self.ui,"sp_mark");
	self.btnBk:set_on_click(self.bindfunc["on_space_click"]);
	self.btnCha = ngui.find_button(self.ui,"btn_cha");
	
	self.btnCha:set_on_click(self.bindfunc["on_close_click"]);
	--self.ui0 = ngui.find_sprite(self.ui,"zero");
	self.ui1 = self.ui:get_child_by_name("one");
	self.ui2 = self.ui:get_child_by_name("two");
	self.ui3 = self.ui:get_child_by_name("three");
	self.ui4 = self.ui:get_child_by_name("four");
	
	self.labTwoContent1 = ngui.find_label(self.ui,"content/cont/lab1");
	self.labTwoContent1:set_active(false);
	self.labTwoContent2 = ngui.find_label(self.ui,"content/cont/lab2");
	self.labTwoContent2:set_active(false);

	self.labContent = {};
	self.labContent[0] = ngui.find_label(self.ui,"content/lab_name");

	self.labTitle = ngui.find_label(self.ui,"lab_title");
	self.labTitle2 = ngui.find_label(self.ui,"lab_title2");
	self.bg = ngui.find_widget(self.ui,"content/Texture");
	self.btn1 = {};
	self.labBtn1 = {};
	self.btn1[1] = systems_func.ngui_find_button(self.ui,"one/btn");
	self.btn1[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.labBtn1[1] = ngui.find_label(self.ui,"one/btn/lab");
	self.btn2 = {};
	self.labBtn2 = {};
	self.btn2[1] = systems_func.ngui_find_button(self.ui,"two/btn2");
	self.btn2[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn2[2] = systems_func.ngui_find_button(self.ui,"two/btn1");
	self.btn2[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.labBtn2[1] = ngui.find_label(self.ui,"two/btn2/lab");
	self.labBtn2[2] = ngui.find_label(self.ui,"two/btn1/lab");
	self.btn3 = {};
	self.labBtn3 = {};
	self.btn3[1] = systems_func.ngui_find_button(self.ui,"three/btn1");
	self.btn3[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn3[2] = systems_func.ngui_find_button(self.ui,"three/btn2");
	self.btn3[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.btn3[3] = systems_func.ngui_find_button(self.ui,"three/btn3");
	self.btn3[3]:set_on_click(self.bindfunc["on_btn3_click"]);
	self.labBtn3[1] = ngui.find_label(self.ui,"three/btn1/lab");
	self.labBtn3[2] = ngui.find_label(self.ui,"three/btn2/lab");
	self.labBtn3[3] = ngui.find_label(self.ui,"three/btn3/lab");

	self.btn4 = {};
	self.labBtn4 = {};
	self.btn4[1] = systems_func.ngui_find_button(self.ui,"four/btn1");
	self.btn4[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn4[2] = systems_func.ngui_find_button(self.ui,"four/btn2");
	self.btn4[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.btn4[3] = systems_func.ngui_find_button(self.ui,"four/btn3");
	self.btn4[3]:set_on_click(self.bindfunc["on_btn3_click"]);
	self.btn4[4] = systems_func.ngui_find_button(self.ui,"four/btn4");
	self.btn4[4]:set_on_click(self.bindfunc["on_btn4_click"]);
	self.labBtn4[1] = ngui.find_label(self.ui,"four/btn1/lab");
	self.labBtn4[2] = ngui.find_label(self.ui,"four/btn2/lab");
	self.labBtn4[3] = ngui.find_label(self.ui,"four/btn3/lab");
	self.labBtn4[4] = ngui.find_label(self.ui,"four/btn4/lab");
    if self.type ~= nil then
	    self:SetInfo(self.type, self.title, self.content, self.btnSpace, self.btn1Data, self.btn2Data, self.btn3Data, self.btn4Data, self.content2, self.notClose);
    else
        self:Hide()
    end

    if GuideUI and GuideUI.IsShow() then
    	self:set_guide_layer(true)
    end
end

function SystemHintUI:on_btn1_click()
	if self.btn1Data.hide == nil or self.btn1Data.hide == true then 
		self:Hide();
	end 
	local func_type = type(self.funcbtn1);
	if func_type == "string" then
		_G[self.funcbtn1](self.parambtn1);
	end
	if func_type == "function" then
		self.funcbtn1(self.parambtn1);
	end
end

function SystemHintUI:on_btn2_click()
	if self.btn2Data.hide == nil or self.btn2Data.hide == true then 
		self:Hide();
	end 
	local func_type = type(self.funcbtn2);
	-- app.log_warning(tostring(self.funcbtn2).." aaaaaaaaa "..func_type);
	if func_type == "string" then
		_G[self.funcbtn2](self.parambtn2);
	end
	if func_type == "function" then
		-- app.log_warning("aaaaaaaaa");
		self.funcbtn2(self.parambtn2);
	end
end

function SystemHintUI:on_btn3_click()
	if self.btn3Data.hide == nil or self.btn3Data.hide == true then 
		self:Hide();
	end 
	local func_type = type(self.funcbtn3);
	if func_type == "string" then
		_G[self.funcbtn3](self.parambtn3);
	end
	if func_type == "function" then
		self.funcbtn3(self.parambtn3);
	end
end

function SystemHintUI:on_btn4_click()
	if self.btn4Data.hide == nil or self.btn4Data.hide == true then 
		self:Hide();
	end
	local func_type = type(self.funcbtn4);
	if func_type == "string" then
		_G[self.funcbtn4](self.parambtn4);
	end
	if func_type == "function" then
		self.funcbtn4(self.parambtn4);
	end
end

function SystemHintUI:on_space_click()
	if self.type == ESystemHintUIType.zero then
		self:Hide();
		if self.funcSpace then
			local func_type = type(self.funcSpace);
			if func_type == "string" then
				_G[self.funcSpace](self.paramSpace);
			end
			if func_type == "function" then
				self.funcSpace(self.paramSpace);
			end
		end
	end
end

function SystemHintUI:on_close_click()
	if self.type == ESystemHintUIType.zero then 
--		self:Hide();
	elseif self.type == ESystemHintUIType.one then 
--		self:Hide();
	elseif self.type == ESystemHintUIType.two then
--		self:Hide();
	elseif self.type == ESystemHintUIType.three then
--		self:Hide();
	elseif self.type == ESystemHintUIType.four then
--		self:Hide();
	end
	self:Hide();
end 

function SystemHintUI:on_time()
	self.deltaTime = self.deltaTime + 1;
	local btn = self["labBtn"..self.type];
	local info = self["btn"..self.timeBtn.."Data"];
	local time = self.time - self.deltaTime;
	btn[self.timeBtn]:set_text(tostring(info.str).."("..time.."秒)");
	if self.deltaTime >= self.time then
		timer.stop(self.timeId);
		self.timeId = nil;
		local str = self.bindfunc["on_btn"..self.timeBtn.."_click"];
		if str then
			_G[str]();
		end
	end
end

--对外接口，设置显示的提示字符串，以及“确认”和“取消”按钮的回调函数
function SystemHintUI:SetInfo(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data,btn4Data, content2, notClose)
	if self.noticeManager == nil or self.noticeManager ~= NoticeManager then
		self.noticeManager = NoticeManager
		if NoticeManager then
			NoticeManager.BeginListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
		end
	end

    if self.timeId then
        timer.stop(self.timeId);
        self.timeId = nil
    end
	if SystemHintUI.hObjList ~= nil then 
		local objList = SystemHintUI.hObjList;
		local i,j = 0,0;
		for i = 1,#objList do 
			local lineObjList = objList[i];
			for j = 1,#lineObjList do 
				lineObjList[j]:set_active(false);
				lineObjList[j]:destroy_object();
			end
		end
	end 
	SystemHintUI.hObjList = nil;
	self.type = type;
    self.title = title
	self.content = content;
	self.content2 = content2;
    self.btnSpace = btnSpace
	self.btn1Data = btn1Data;
	self.btn2Data = btn2Data;
	self.btn3Data = btn3Data;
	self.btn4Data = btn4Data;
	self.funcSpace = nil
	self.funcbtn1 = nil
	self.funcbtn2 = nil
	self.funcbtn3 = nil
	self.funcbtn4 = nil
	self.paramSpace = nil
	self.parambtn1 = nil
	self.parambtn2 = nil
	self.parambtn3 = nil
	self.parambtn4 = nil

	self.time = nil;

	if not self.ui then return end

	if self.title == nil or #self.title == 0 then
		self.labTitle:set_active(false)
		self.labTitle2:set_active(false)
	else
		self.labTitle:set_active(true)
		self.labTitle2:set_active(true)
	end

	if(btn1Data)then
		if(type == ESystemHintUIType.zero)then
			if btn1Data.func then
				self.funcSpace = btn1Data.func;
				self.paramSpace = btn1Data.param;
			end
		else
			if btn1Data.func then
				self.funcbtn1 = btn1Data.func;
				self.parambtn1 = btn1Data.param;
			end
		end
		if not self.time then
			self.time = btn1Data.time;
			self.timeBtn = 1;
		end
	end
    if(btnSpace)then
		self.funcSpace = btnSpace.func;
		self.paramSpace = btn1Data.param;
	end
	if(btn2Data)then
		self.funcbtn2 = btn2Data.func;
		self.parambtn2 = btn1Data.param;
		if not self.time then
			self.time = btn2Data.time;
			self.timeBtn = 2;
		end
	end
	if(btn3Data)then
		self.funcbtn3 = btn3Data.func;
		self.parambtn3 = btn1Data.param;
		if not self.time then
			self.time = btn3Data.time;
			self.timeBtn = 3;
		end
	end
	if(btn4Data)then
		self.funcbtn4 = btn4Data.func;
		self.parambtn4 = btn1Data.param;
		if not self.time then
			self.time = btn4Data.time;
			self.timeBtn = 4;
		end
	end
	if not self.ui then
		return;
	end
	if self.content2 then
		self.labContent[0]:set_active(false);
		self.labTwoContent1:set_active(true);
		self.labTwoContent2:set_active(true);
	else
		self.labContent[0]:set_active(true);
		self.labTwoContent1:set_active(false);
		self.labTwoContent2:set_active(false);
	end
	if type == ESystemHintUIType.zero then
		systems_func.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
		self.labContent[0]:set_text(tostring(self.content));
		self.labTwoContent1:set_text(tostring(self.content));
		self.labTwoContent2:set_text(tostring(self.content2));
	elseif type == ESystemHintUIType.one then
		systems_func.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
		self.labContent[0]:set_text(tostring(self.content));
		self.labTwoContent1:set_text(tostring(self.content));
		self.labTwoContent2:set_text(tostring(self.content2));
		if btn1Data and btn1Data.str then
			self.labBtn1[1]:set_text(tostring(btn1Data.str));
		end
	elseif type == ESystemHintUIType.two then
		systems_func.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
		self.labContent[0]:set_text(tostring(self.content));
		self.labTwoContent1:set_text(tostring(self.content));
		self.labTwoContent2:set_text(tostring(self.content2));
		if btn1Data and btn1Data.str then
			self.labBtn2[1]:set_text(tostring(btn1Data.str));
		end
		if btn2Data and btn2Data.str then
			self.labBtn2[2]:set_text(tostring(btn2Data.str));
		end
	elseif type == ESystemHintUIType.three then
		systems_func.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
		self.labContent[0]:set_text(tostring(self.content));
		self.labTwoContent1:set_text(tostring(self.content));
		self.labTwoContent2:set_text(tostring(self.content2));
		if btn1Data and btn1Data.str then
			self.labBtn3[1]:set_text(tostring(btn1Data.str));
		end
		if btn2Data and btn2Data.str then
			self.labBtn3[2]:set_text(tostring(btn2Data.str));
		end
		if btn3Data and btn3Data.str then
			self.labBtn3[3]:set_text(tostring(btn3Data.str));
		end
	elseif type == ESystemHintUIType.four then
		systems_func.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
		self.labContent[0]:set_text(tostring(self.content));
		self.labTwoContent1:set_text(tostring(self.content));
		self.labTwoContent2:set_text(tostring(self.content2));
		if btn1Data and btn1Data.str then
			self.labBtn4[1]:set_text(tostring(btn1Data.str));
		end
		if btn2Data and btn2Data.str then
			self.labBtn4[2]:set_text(tostring(btn2Data.str));
		end
		if btn3Data and btn3Data.str then
			self.labBtn4[3]:set_text(tostring(btn3Data.str));
		end
		if btn4Data and btn4Data.str then
			self.labBtn4[4]:set_text(tostring(btn4Data.str));
		end
	else
		app.log("提示框类型错误");
		return;
	end
	if self.time then
		local btn = self["labBtn"..self.type];
		local info = self["btn"..self.timeBtn.."Data"];
		btn[self.timeBtn]:set_text(tostring(info.str).."("..self.time.."秒)");
	end
	if self.time then
		self.timeId = timer.create(self.bindfunc["on_time"],1000,-1);
		self.deltaTime = 0;
	end
	if self.btnCha then
		if notClose then
			self.btnCha:set_active(true);
		else
			self.btnCha:set_active(false);
		end
	end
	
	self:ShowUiType(type)
	self:Show();
end

function SystemHintUI:ShowUiType(type)
	if type == ESystemHintUIType.zero then
		--self.ui0:set_active(true);
		self.ui1:set_active(false);
		self.ui2:set_active(false);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
	elseif type == ESystemHintUIType.one then
		--self.ui0:set_active(false);
		self.ui1:set_active(true);
		self.ui2:set_active(false);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
		self.btnCha:set_active(false)
	elseif type == ESystemHintUIType.two then
		--self.ui0:set_active(false);
		self.ui1:set_active(false);
		self.ui2:set_active(true);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
	elseif type == ESystemHintUIType.three then
		--self.ui0:set_active(false);
		self.ui1:set_active(false);
		self.ui2:set_active(false);
		self.ui3:set_active(true);
		self.ui4:set_active(false);
    elseif type == ESystemHintUIType.four then
		--self.ui0:set_active(false);
		self.ui1:set_active(false);
		self.ui2:set_active(false);
		self.ui3:set_active(false);
		self.ui4:set_active(true);
	else
		app.log("提示框类型错误");
		return;
	end
end

function SystemHintUI:Show()
	if self.ui then
		self.ui:set_active(true);
		if self.guide_mode then
			self.ui:set_layer(28, true)
		end
	end
end

function SystemHintUI:Hide()
	if self.ui then
		if SystemHintUI.hObjList ~= nil then 
			local objList = SystemHintUI.hObjList;
			local i,j = 0,0;
			for i = 1,#objList do 
				local lineObjList = objList[i];
				for j = 1,#lineObjList do 
					lineObjList[j]:set_active(false);
					lineObjList[j]:destroy_object();
				end
			end
		end 
		SystemHintUI.hObjList = nil;
		self.ui:set_active(false);
		if self.guide_mode then
			self.ui:set_layer(27, true)
			self.guide_mode = nil
		end
	end
end

function SystemHintUI:DestroyUi()
	if NoticeManager then
		NoticeManager.EndListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
	end
    self:UnregistFunc()
	self:Hide();
    self.ui = nil;
    self.funcSpace = nil;
	self.funcbtn1 = nil;
	self.funcbtn2 = nil;
	self.funcbtn3 = nil;
    self.funcbtn4 = nil;
    self.paramSpace = nil;
    self.parambtn1 = nil;
	self.parambtn2 = nil;
	self.parambtn3 = nil;
    self.parambtn4 = nil;
end

function SystemHintUI:on_guide_camera_change(value)
	if self.noticeValue ~= value then
		self.noticeValue = value

		self:set_guide_layer(value)
	end
end

function SystemHintUI:set_guide_layer(value)
	if self.ui then
		if value then
			self.ui:set_layer(PublicStruct.UnityLayer.guide, true)
		else
			self.ui:set_layer(PublicStruct.UnityLayer.ngui, true)
		end
	end
end

----------------------------------------支付单独UI----------------------------------------------------
SystemHintUI_pay = {
	ui = nil;
	titile1 = "";
	titile2 = "";
	content = "";
	btn1Data = nil;
	btn2Data = nil;
	notClose = nil;
};

function SystemHintUI_pay.str(titile1,titile2,content,btn1Data,btn2Data, notClose)
	SystemHintUI_pay.titile1 = tostring(titile1);
	SystemHintUI_pay.titile2 = tostring(titile2);
	SystemHintUI_pay.content = tostring(content);
	SystemHintUI_pay.btn1Data = btn1Data;
	SystemHintUI_pay.btn2Data = btn2Data;
	SystemHintUI_pay.notClose = notClose;
	if SystemHintUI_pay.ui == nil then
		SystemHintUI_pay._asset_loader = systems_func.loader_create("SystemHintUI_pay_loader")
		SystemHintUI_pay._asset_loader:set_callback("SystemHintUI_pay.on_load")
		SystemHintUI_pay._asset_loader:load("assetbundles/prefabs/ui/public/system_panel_pay.assetbundle");
		SystemHintUI_pay._asset_loader = nil;
	end
end
function SystemHintUI_pay.on_load(pid, fpath, asset_obj, error_info)
	SystemHintUI_pay.ui = systems_func.game_object_create(asset_obj);
	SystemHintUI_pay.ui:set_parent(Root.get_root_ui_2d());
	SystemHintUI_pay.ui:set_local_scale(Utility.SetUIAdaptation());
	SystemHintUI_pay.ui:set_local_position(0,0,0)
	SystemHintUI_pay.ui:set_name("system_hint_ui_pay");
	SystemHintUI_pay.ui:set_local_position(0,0,0);

	SystemHintUI_pay.ui_title1 = ngui.find_label(SystemHintUI_pay.ui,"centre_other/animation/content_di_754_458/lab_title");
	SystemHintUI_pay.ui_title1:set_text(SystemHintUI_pay.titile1);
	SystemHintUI_pay.ui_title2 = ngui.find_label(SystemHintUI_pay.ui,"centre_other/animation/content_di_754_458/lab_title/lab_title2");
	SystemHintUI_pay.ui_title2:set_text(SystemHintUI_pay.titile2);

	SystemHintUI_pay.ui_content = ngui.find_label(SystemHintUI_pay.ui,"centre_other/animation/lab");
	SystemHintUI_pay.ui_content:set_text(SystemHintUI_pay.content);

	SystemHintUI_pay.btnCL = systems_func.ngui_find_button(SystemHintUI_pay.ui,"centre_other/animation/content_di_754_458/btn_cha");
	SystemHintUI_pay.btnCL:set_on_click("SystemHintUI_pay.on_close");

	SystemHintUI_pay.btn1 = systems_func.ngui_find_button(SystemHintUI_pay.ui,"centre_other/animation/two/btn1");
	SystemHintUI_pay.btn1:set_on_click("SystemHintUI_pay.on_1");
	SystemHintUI_pay.ui_btn1_lab = ngui.find_label(SystemHintUI_pay.ui,"centre_other/animation/two/btn1/animation/lab");
	SystemHintUI_pay.ui_btn1_lab:set_text(SystemHintUI_pay.btn1Data.str);

	SystemHintUI_pay.btn2 = systems_func.ngui_find_button(SystemHintUI_pay.ui,"centre_other/animation/two/btn2");
	SystemHintUI_pay.btn2:set_on_click("SystemHintUI_pay.on_2");
	SystemHintUI_pay.ui_btn2_lab = ngui.find_label(SystemHintUI_pay.ui,"centre_other/animation/two/btn2/animation/lab");
	SystemHintUI_pay.ui_btn2_lab:set_text(SystemHintUI_pay.btn2Data.str);
end

function SystemHintUI_pay.on_destroy()
	if SystemHintUI_pay.ui ~= nil then
		SystemHintUI_pay.ui:set_active(false);
	end
	SystemHintUI_pay.ui = nil;
end

function SystemHintUI_pay.on_close()
	SystemHintUI_pay.on_destroy();
end
function SystemHintUI_pay.on_1()
	SystemHintUI_pay.on_close();
	SystemHintUI_pay.btn1Data.func();
end
function SystemHintUI_pay.on_2()
	SystemHintUI_pay.on_close();
	SystemHintUI_pay.btn2Data.func();
end

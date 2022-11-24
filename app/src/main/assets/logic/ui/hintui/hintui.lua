--通用提示框：有4种样式
--没有按钮
--一个按钮
--两个按钮
--三个按钮
HintUI = Class("HintUI",UiBaseClass);

EHintUiType = 
{
	zero = 0,
	one = 1,
	two = 2,
	three = 3,
	four = 4,
}
--[[定义文本内容类型，normal普通文本，hybrid图文混合]]
EHintContentType = 
{
	normal = 1,
	hybrid = 2,
}

function HintUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/panel_hint.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function HintUI:DestroyUi()
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
    UiBaseClass.DestroyUi(self);
end

--显示ui
function HintUI:Show()
    UiBaseClass.Show(self);
	self.mark:set_local_scale(0,0,0);
	local tover = function()
		self.mark:set_local_scale(1,1,1);
	end 
	Tween.addTween(self.mark,0.01,{},nil,0,nil,nil,tover);
    if self.animObj then
    	self.animObj:reset_to_begining();
    	self.animObj:play_foward();
    end
end

--隐藏ui
function HintUI:Hide()
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function HintUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    NoticeManager.BeginListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
end

--注销消息分发回调函数
function HintUI:MsgUnRegist()
    NoticeManager.EndListen(ENUM.NoticeType.GuideCameraChange, self.bindfunc['on_guide_camera_change'])
    UiBaseClass.MsgUnRegist(self);
end

----------------------外部接口---------------------------------
--显示通用提示框
--例子：HintUI.SetAndShow(EHintUiType.three, "xxxxx", {str = "确定",func = self.bindfunc["on_organization"]},{str = "取消",func = self.bindfunc["on_organization"]},{str = "哈哈",func = self.bindfunc["on_organization"]})
-- type  窗口类型 EHintUiType 
-- content 显示文字
-- btn1Data btn2Data btn3Data btn4Data =
--{
-- 	str  按钮上文字
-- 	func 按钮回调
--	param 回调参数
-- 	time 该时间后自动点击该按钮（只能有一个）
--}
function HintUI.SetAndShow(type, content, btn1Data, btn2Data, btn3Data, btn4Data, notClose)
	if HintUI.instance then
		HintUI.instance:SetInfo(type, '', content, nil, btn1Data, btn2Data, btn3Data, btn4Data, nil, nil, notClose)
	else
		HintUI.instance = HintUI:new({type = type, title = '', content = content, nil, btn1Data = btn1Data, btn2Data = btn2Data, btn3Data = btn3Data, btn4Data = btn4Data, notClose=notClose});
	end
end

function HintUI.SetTwoAndShow(type, content1, content2, btn1Data, btn2Data, btn3Data,btn4Data)
	if HintUI.instance then
		HintUI.instance:SetInfo(type, '', content1, nil, btn1Data, btn2Data, btn3Data,btn4Data, content2)
	else
		HintUI.instance = HintUI:new({type = type, title = '', content = content1, content2=content2, nil, btn1Data = btn1Data, btn2Data = btn2Data, btn3Data = btn3Data,btn4Data = btn4Data});
	end
end

function HintUI.SetAndShowNew(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data, btn4Data)
    if HintUI.instance then
		HintUI.instance:SetInfo(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data, btn4Data)
	else
		HintUI.instance = HintUI:new({type = type, title = title, content = content, btnSpace = btnSpace, btn1Data = btn1Data, btn2Data = btn2Data, 
            btn3Data = btn3Data, btn4Data = btn4Data});
	end
end
--[[通用提示框图文混排接口]]
function HintUI.SetAndShowHybrid(type, title, content,btnSpace,btn1Data,btn2Data,btn3Data,btn4Data)
	local contentType = EHintContentType.hybrid
	local allContent = {};
	local strLine = string.split(content,"\n");
	local i,j = 0,0;
	for i = 1,#strLine do 
		local lineContents = {}; 
		table.insert(allContent,lineContents);
		local list = string.split(strLine[i],"|");
		for j = 1,#list do 
			if string.match(list[j],"item:") ~= nil then 
				local contentObj = {type = 2,info = string.split(list[j],":")[2]};
				table.insert(lineContents,contentObj);
			else 
				local contentObj = {type = 1,info = list[j]};
				table.insert(lineContents,contentObj);
			end
		end
	end 
	if HintUI.instance then
		HintUI.instance:SetInfo(type, title, allContent, btnSpace, btn1Data, btn2Data, btn3Data, btn4Data ,nil,contentType)
	else
		HintUI.instance = HintUI:new({type = type, title = title, content = allContent, btnSpace = btnSpace, btn1Data = btn1Data, btn2Data = btn2Data, 
            btn3Data = btn3Data, btn4Data = btn4Data,contentType = contentType});
	end
end 

function HintUI.Instance()
    if HintUI.instance == nil then
        HintUI.instance = HintUI:new({});
    end
end

--显示在引导层
function HintUI.SetGuideMode()
    if HintUI.instance then
    	HintUI.instance.guide_mode = true
    end
end

function HintUI.Close()
	if HintUI.instance then
		HintUI.instance:Hide()
	end
end

function HintUI.IsUIShow()
	if HintUI.instance then
		return HintUI.instance:IsShow()
	end
	return false
end

function HintUI.GetCurShowContent()
	if HintUI.instance and HintUI.instance:IsShow() then
		return HintUI.instance.content
	end
	return nil
end
-------------------------内部接口------------------------------
--btn1Data = {str = "xxx",func = "callback"}
function HintUI:InitData(data)
    UiBaseClass.InitData(self, data);
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
	self.contentType = data.contentType;
	self.notClose = data.notClose;
end

--重新开始
function HintUI:Restart(data)
    UiBaseClass.Restart(self, data);
end

function HintUI:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc["on_btn1_click"] = Utility.bind_callback(self, self.on_btn1_click)
	self.bindfunc["on_btn2_click"] = Utility.bind_callback(self, self.on_btn2_click)
	self.bindfunc["on_btn3_click"] = Utility.bind_callback(self, self.on_btn3_click)
	self.bindfunc["on_btn4_click"] = Utility.bind_callback(self, self.on_btn4_click)
	self.bindfunc["on_space_click"] = Utility.bind_callback(self, self.on_space_click)
	self.bindfunc["on_close_click"] = Utility.bind_callback(self, self.on_close_click)
	self.bindfunc["on_time"] = Utility.bind_callback(self, self.on_time)
	self.bindfunc["on_click_head"] = Utility.bind_callback(self, self.on_click_head);

	self.bindfunc['on_guide_camera_change'] = Utility.bind_callback(self, self.on_guide_camera_change);
end

function HintUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name("hint_ui");
	self.ui:set_local_position(0,0,0);
	
	self.animObj = ngui.find_tween_scale(self.ui, "centre_other/animation");

	self.btnBk = ngui.find_button(self.ui,"sp_mark");
	self.mark = self.ui:get_child_by_name("sp_mark");
	self.btnBk:set_on_click(self.bindfunc["on_space_click"]);
	self.btnCha = ngui.find_button(self.ui,"btn_cha");
	self.btnCha:set_on_click(self.bindfunc["on_close_click"]);
	--self.ui0 = ngui.find_sprite(self.ui,"zero");
	self.ui1 = self.ui:get_child_by_name("one")
	self.ui2 = self.ui:get_child_by_name("two")
	self.ui3 = self.ui:get_child_by_name("three")
	self.ui4 = self.ui:get_child_by_name("four")
	
	self.labTwoContent1 = ngui.find_label(self.ui,"content/cont/lab1");
	self.labTwoContent1:set_active(false);
	self.labTwoContent2 = ngui.find_label(self.ui,"content/cont/lab2");
	self.labTwoContent2:set_active(false);

	self.labContent = {};
	self.labContent[0] = ngui.find_label(self.ui,"content/lab_name");

	self.labTitle = ngui.find_label(self.ui,"lab_title");
	self.labTitle2 = ngui.find_label(self.ui,"lab_title2")
	if HintUI.labelModel == nil then 
		HintUI.labelModel = self.labTwoContent1:clone();
		HintUI.labelModel:set_text("");
	end
	self.btn1 = {};
	self.labBtn1 = {};
	self.btn1[1] = ngui.find_button(self.ui1,"one/btn");
	self.btn1[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.labBtn1[1] = ngui.find_label(self.ui,"one/btn/lab");
	self.btn2 = {};
	self.labBtn2 = {};
	self.btn2[1] = ngui.find_button(self.ui2,"two/btn2");
	self.btn2[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn2[2] = ngui.find_button(self.ui2,"two/btn1");
	self.btn2[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.labBtn2[1] = ngui.find_label(self.ui,"two/btn2/lab");
	self.labBtn2[2] = ngui.find_label(self.ui,"two/btn1/lab");
	self.btn3 = {};
	self.labBtn3 = {};
	self.btn3[1] = ngui.find_button(self.ui3,"three/btn1");
	self.btn3[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn3[2] = ngui.find_button(self.ui3,"three/btn2");
	self.btn3[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.btn3[3] = ngui.find_button(self.ui3,"three/btn3");
	self.btn3[3]:set_on_click(self.bindfunc["on_btn3_click"]);
	self.labBtn3[1] = ngui.find_label(self.ui,"three/btn1/lab");
	self.labBtn3[2] = ngui.find_label(self.ui,"three/btn2/lab");
	self.labBtn3[3] = ngui.find_label(self.ui,"three/btn3/lab");

	self.btn4 = {};
	self.labBtn4 = {};
	self.btn4[1] = ngui.find_button(self.ui4,"four/btn1");
	self.btn4[1]:set_on_click(self.bindfunc["on_btn1_click"]);
	self.btn4[2] = ngui.find_button(self.ui4,"four/btn2");
	self.btn4[2]:set_on_click(self.bindfunc["on_btn2_click"]);
	self.btn4[3] = ngui.find_button(self.ui4,"four/btn3");
	self.btn4[3]:set_on_click(self.bindfunc["on_btn3_click"]);
	self.btn4[4] = ngui.find_button(self.ui4,"four/btn4");
	self.btn4[4]:set_on_click(self.bindfunc["on_btn4_click"]);
	self.labBtn4[1] = ngui.find_label(self.ui,"four/btn1/lab");
	self.labBtn4[2] = ngui.find_label(self.ui,"four/btn2/lab");
	self.labBtn4[3] = ngui.find_label(self.ui,"four/btn3/lab");
	self.labBtn4[4] = ngui.find_label(self.ui,"four/btn4/lab");
    if self.type ~= nil then
	    self:SetInfo(self.type, self.title, self.content, self.btnSpace, self.btn1Data, self.btn2Data, self.btn3Data, self.btn4Data, self.content2,self.contentType ,self.notClose);
    else
        self:Hide()
    end

    if GuideUI and GuideUI.IsShow() then
    	self:set_guide_layer(true)
    end
end

function HintUI:on_btn1_click()
	if self.btn1Data.hide == nil or self.btn1Data.hide == true then 
		self:Hide();
		if self.timeId and self.timeBtn ~= 1 then
			timer.stop(self.timeId);
			self.timeId = nil;
		end
	end 
	local func_type = type(self.funcbtn1);
	if func_type == "string" then
		_G[self.funcbtn1](self.parambtn1);
	end
	if func_type == "function" then
		self.funcbtn1(self.parambtn1);
	end
end

function HintUI:on_btn2_click()
	if self.btn2Data.hide == nil or self.btn2Data.hide == true then 
		self:Hide();
		if self.timeId and self.timeBtn ~= 2 then
			timer.stop(self.timeId);
			self.timeId = nil;
		end
	end 
	local func_type = type(self.funcbtn2);
	if func_type == "string" and _G[self.funcbtn2] then
		_G[self.funcbtn2](self.parambtn2);
	end
	if func_type == "function" then
		self.funcbtn2(self.parambtn2);
	end
end

function HintUI:on_btn3_click()
	if self.btn3Data.hide == nil or self.btn3Data.hide == true then 
		self:Hide();
		if self.timeId and self.timeBtn ~= 3 then
			timer.stop(self.timeId);
			self.timeId = nil;
		end
	end 
	local func_type = type(self.funcbtn3);
	if func_type == "string" then
		_G[self.funcbtn3](self.parambtn3);
	end
	if func_type == "function" then
		self.funcbtn3(self.parambtn3);
	end
end

function HintUI:on_btn4_click()
	if self.btn4Data.hide == nil or self.btn4Data.hide == true then 
		self:Hide();
		if self.timeId and self.timeBtn ~= 4 then
			timer.stop(self.timeId);
			self.timeId = nil;
		end
	end
	local func_type = type(self.funcbtn4);
	if func_type == "string" then
		_G[self.funcbtn4](self.parambtn4);
	end
	if func_type == "function" then
		self.funcbtn4(self.parambtn4);
	end
end

function HintUI:on_space_click()
	if self.type == EHintUiType.zero then
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

function HintUI:on_close_click()
	if self.type == EHintUiType.zero then 
		self:Hide();
	elseif self.type == EHintUiType.one then 
		self:Hide();
	elseif self.type == EHintUiType.two then 
		self:Hide();
	elseif self.type == EHintUiType.three then 
		
	elseif self.type == EHintUiType.four then 
		
	end
end 

function HintUI:on_time()
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
function HintUI:SetInfo(type, title, content, btnSpace, btn1Data, btn2Data, btn3Data,btn4Data, content2,contentType, notClose)
    if self.timeId then
        timer.stop(self.timeId);
        self.timeId = nil
    end
	if HintUI.hObjList ~= nil then 
		local objList = HintUI.hObjList;
		local i,j = 0,0;
		for i = 1,#objList do 
			local lineObjList = objList[i];
			for j = 1,#lineObjList do 
				lineObjList[j]:set_active(false);
				lineObjList[j]:destroy_object();
			end
		end
	end 
	HintUI.hObjList = nil;
	self.type = type;
    self.title = title
	self.content = content;
	self.content2 = content2;
    self.btnSpace = btnSpace
	self.btn1Data = btn1Data;
	self.btn2Data = btn2Data;
	self.btn3Data = btn3Data;
	self.btn4Data = btn4Data;
	self.contentType = contentType;
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

	if self.title == nil or #self.title == 0 then
		self.labTitle:set_active(false)
		self.labTitle2:set_active(false)
	else
		self.labTitle:set_active(true)
		self.labTitle2:set_active(true)
	end

	if(btn1Data)then
		if(type == EHintUiType.zero)then
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
		self.paramSpace = btnSpace.param;
	end
	if(btn2Data)then
		self.funcbtn2 = btn2Data.func;
		self.parambtn2 = btn2Data.param;
		if not self.time then
			self.time = btn2Data.time;
			self.timeBtn = 2;
		end
	end
	if(btn3Data)then
		self.funcbtn3 = btn3Data.func;
		self.parambtn3 = btn3Data.param;
		if not self.time then
			self.time = btn3Data.time;
			self.timeBtn = 3;
		end
	end
	if(btn4Data)then
		self.funcbtn4 = btn4Data.func;
		self.parambtn4 = btn4Data.param;
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
	if contentType == nil or contentType == EHintContentType.normal then 
		if type == EHintUiType.zero then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			self.labContent[0]:set_text(tostring(self.content));
			self.labTwoContent1:set_text(tostring(self.content));
			self.labTwoContent2:set_text(tostring(self.content2));
		elseif type == EHintUiType.one then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			self.labContent[0]:set_text(tostring(self.content));
			self.labTwoContent1:set_text(tostring(self.content));
			self.labTwoContent2:set_text(tostring(self.content2));
			if btn1Data and btn1Data.str then
				self.labBtn1[1]:set_text(tostring(btn1Data.str));
			end
		elseif type == EHintUiType.two then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			self.labContent[0]:set_text(tostring(self.content));
			self.labTwoContent1:set_text(tostring(self.content));
			self.labTwoContent2:set_text(tostring(self.content2));
			if btn1Data and btn1Data.str then
				self.labBtn2[1]:set_text(tostring(btn1Data.str));
			end
			if btn2Data and btn2Data.str then
				self.labBtn2[2]:set_text(tostring(btn2Data.str));
			end
		elseif type == EHintUiType.three then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
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
		elseif type == EHintUiType.four then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
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
	else
		self.labContent[0]:set_text("");
		self.labTwoContent1:set_text("");
		self.labTwoContent2:set_text("");
		local contentLen = #self.content;
		local i = 0;
		local j = 0;
		local objList = {};
		local parent = self.labTwoContent1:get_parent();
		for i = 1,contentLen do 
			local line = content[i];
			local lineObjList = {};
			for j = 1,#line do 
				if line[j].type == 1 then 
					local lab = self:createLabel(line[j].info);
					lab:set_parent(parent);
					table.insert(lineObjList,lab);
				elseif line[j].type == 2 then 
					local tex = self:createIcon(line[j].info);
					tex:set_parent(parent);
					table.insert(lineObjList,tex);
				elseif line[j].type == 3 then 
					local tex = self:createHead(line[j].info);
					tex:set_parent(parent);
					table.insert(lineObjList,tex);
				end 
			end
			table.insert(objList,lineObjList);
		end
		local lineNum = #objList;
		for i = 1,#objList do 
			local lList = objList[i];
			local allW = 0;
			for j = 1, #lList do 
				local sp = ngui.find_sprite(lList[j]:get_game_object(),"sp");
				local w,h = 0,0;
				if sp ~= nil then 
					w,h = 36,36;
				else
					w,h = lList[j]:get_size();
					local sx,sy,sz = lList[j]:get_game_object():get_local_scale();
					w = w * sx;
				end 
				allW = allW + w;
			end
			local lastX = 0;
			for j = 1, #lList do 
				local w,h = lList[j]:get_size();
				local sp = ngui.find_sprite(lList[j]:get_game_object(),"sp");
				if sp ~= nil then 
					w,h = 36,36;
				end
				local sx,sy,sz = lList[j]:get_game_object():get_local_scale();
				if sp ~= nil then 
					sx = 1;
				end
				local x = -allW/2 + w*sx/2 + lastX;
				lList[j]:set_position(x,(lineNum/2 - i + 1)*30,0);
				lastX = lastX + w*sx;
			end
		end 
		HintUI.hObjList = objList;
		if type == EHintUiType.zero then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			
		elseif type == EHintUiType.one then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			
			if btn1Data and btn1Data.str then
				self.labBtn1[1]:set_text(tostring(btn1Data.str));
			end
		elseif type == EHintUiType.two then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			
			if btn1Data and btn1Data.str then
				self.labBtn2[1]:set_text(tostring(btn1Data.str));
			end
			if btn2Data and btn2Data.str then
				self.labBtn2[2]:set_text(tostring(btn2Data.str));
			end
		elseif type == EHintUiType.three then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			
			if btn1Data and btn1Data.str then
				self.labBtn3[1]:set_text(tostring(btn1Data.str));
			end
			if btn2Data and btn2Data.str then
				self.labBtn3[2]:set_text(tostring(btn2Data.str));
			end
			if btn3Data and btn3Data.str then
				self.labBtn3[3]:set_text(tostring(btn3Data.str));
			end
		elseif type == EHintUiType.four then
			PublicFunc.SetSinkText(tostring(self.title), self.labTitle, self.labTitle2)
			
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
	if notClose and self.btnCha then
		self.btnCha:set_active(false);
	end
	
	self:ShowUiType(type)
	self:Show();
end
--[[通用弹出窗口图文混排模式文本创建接口]]
function HintUI:createLabel(msg)
	local lab = HintUI.labelModel:clone();
	lab:set_font_size(24);
	lab:set_color(1,1,1,1);
	lab:set_overflow(2);
	lab:set_text(tostring(msg));
	lab:set_active(true);
	return lab;
end 
--[[通用弹出窗口图文混排模式道具Icon创建接口]]
function HintUI:createIcon(itemID)
	local cf = nil;
	if ConfigManager ~= nil then 
		cf = ConfigManager.Get(EConfigIndex.t_item,tonumber(itemID));
	end 
	if cf ~= nil then 
		local iconPath = cf.small_icon;
		if HintUI.textureModel == nil then 
			HintUI.textureModel = ngui.find_texture(self.ui,"content/Texture");
		end 
		local tex = HintUI.textureModel:clone();
		tex:set_texture(iconPath);
		local wg = ngui.find_widget(tex:get_game_object(),tex:get_name());
		local sw,sh = wg:get_size();
		local gb = tex:get_game_object();
		gb:set_local_scale(36/sw,36/sh,1)
		return tex;
	else 
		local tex = HintUI.textureModel:clone();
		local wg = ngui.find_widget(tex:get_game_object(),tex:get_name());
		local sw,sh = wg:get_size();
		local gb = tex:get_game_object();
		gb:set_local_scale(36/sw,36/sh,1);
		tex:clear_texture();
		return tex;
	end
end 

function HintUI:ShowUiType(type)
	if type == EHintUiType.zero then
		--self.ui0:set_active(true);
		self.ui1:set_active(false);
		self.ui2:set_active(false);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
	elseif type == EHintUiType.one then
		--self.ui0:set_active(false);
		self.ui1:set_active(true);
		self.ui2:set_active(false);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
	elseif type == EHintUiType.two then
		--self.ui0:set_active(false);
		self.ui1:set_active(false);
		self.ui2:set_active(true);
		self.ui3:set_active(false);
		self.ui4:set_active(false);
	elseif type == EHintUiType.three then
		--self.ui0:set_active(false);
		self.ui1:set_active(false);
		self.ui2:set_active(false);
		self.ui3:set_active(true);
		self.ui4:set_active(false);
    elseif type == EHintUiType.four then
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

function HintUI:on_guide_camera_change(value)
	if self.noticeValue ~= value then
		self.noticeValue = value
		self:set_guide_layer(self.noticeValue)
	end
end

function HintUI:set_guide_layer(value)
	if self.ui then
		if value then
			self.ui:set_layer(PublicStruct.UnityLayer.guide, true)
		else
			self.ui:set_layer(PublicStruct.UnityLayer.ngui, true)
		end
	end
end


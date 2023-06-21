FloatTip = Class('FloatTip',UiBaseClass);

FloatTip.msgList = {};
FloatTip.showingMsgList = {};

FloatTip.FloatList = {};
FloatTip.depthCount = 0;
------------外部接口--------------
--[[弹出通用浮动提示,msg是需要弹出的提示内容]]
function FloatTip.Float(msg)
	if FloatTip.showingMsgList[msg] ~= nil then 
		do return end;
	end
	table.insert(FloatTip.FloatList,FloatTip:new(msg));
end

--重新开始
function FloatTip:Restart(data)
    UiBaseClass.Restart(self, data);
    self.msg = data;
	self.do_on_time = false;
	FloatTip.showingMsgList[self.msg] = 1;
end

function FloatTip:InitData(data)
    UiBaseClass.InitData(self, data);
    self.msg = data;
	self.do_on_time = false;
	FloatTip.showingMsgList[self.msg] = 1;
end

function FloatTip:SetText(msg)
	self.vs.lab:set_text(tostring(msg));
	local labw,labh = self.vs.lab:get_size();
	FloatTip.depthCount = FloatTip.depthCount + 1;
	local testUI = ngui.find_panel(self.ui,self.ui:get_name());
	testUI:set_depth(self.initDepth + FloatTip.depthCount);
	-- 底板宽度固定，文本内容控制在一行（18字以内）
	if labw < 1160 and labw ~= 0 then 
		if labw <= 300 then 
			self.vs.bg:set_width(labw+220);
		elseif labw <= 400 then 
			self.vs.bg:set_width(labw+120 + (1 - (labw - 300)/100)*100);
		else 
			self.vs.bg:set_width(labw+120);
		end
	else
		self.vs.bg:set_width(labw+40);
		self.vs.bg:set_height(math.max(labh+30,bgh));
	end 
	timer.create(self.bindfunc['on_time'],500,1);
end 

function FloatTip:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc["on_time"] = Utility.bind_callback(self, FloatTip.on_time);
end

function FloatTip:on_time()
	self.do_on_time = true;
	if self.msg ~= nil then 
		FloatTip.showingMsgList[self.msg] = nil;
	end 
end 

function FloatTip:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('float_tip_ui');
	
    self.vs = {};
	self.vs.ainimation = self.ui:get_child_by_name("ainimation");
    self.vs.bg = ngui.find_sprite(self.vs.ainimation,"sp_effect_bk");
    self.vs.lab = ngui.find_label(self.vs.ainimation,"lab");

	self.initDepth = ngui.find_panel(self.ui, "float_tip_ui"):get_depth();
	self.vs.lab:set_overflow(2);
    self:SetText(self.msg);
end

function FloatTip:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/float_tip/animation_lab.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function FloatTip:DestroyUi()
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
end

function FloatTip.on_ainimation_stop()
	local tip = table.remove(FloatTip.FloatList,1);
	if tip ~= nil then 
		if tip.do_on_time == false then 
			if tip.msg ~= nil then 
				FloatTip.showingMsgList[tip.msg] = nil;
			end 
		end
		tip:DestroyUi();
	end 
	if #FloatTip.FloatList == 0 then 
		FloatTip.depthCount = 0;
	end
end
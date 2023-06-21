TestUI = Class('TestUI', UiBaseClass);

TestUI.rdText = {"哈","都","秒","明","杨","天","霞","风","力","亚","奴","酱","殇","古","偶","萌","美","佳","狂","星","红","痕","幕","邪","众","娥","爱","菲","米","娜","姬","雄","盖","宏","晴","明"}

--重新开始
function TestUI:Restart(data)
    --app.log("TestUI:Restart");
    UiBaseClass.Restart(self, data);
end

function TestUI:InitData(data)
    --app.log("TestUI:InitData");
    UiBaseClass.InitData(self, data);
end

function TestUI:RegistFunc()
	--app.log("TestUI:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_drag_start'] = Utility.bind_callback(self, self.on_drag_start);
	self.bindfunc['on_drag_end'] = Utility.bind_callback(self, self.on_drag_end);
	self.bindfunc['on_drag_move'] = Utility.bind_callback(self, self.on_drag_move);
	self.bindfunc['updateItem'] = Utility.bind_callback(self, self.updateItem);
	self.bindfunc['changeType'] = Utility.bind_callback(self, self.changeType);
	self.bindfunc['decItemData'] = Utility.bind_callback(self, self.decItemData);
	self.bindfunc['addItemData'] = Utility.bind_callback(self, self.addItemData);
	self.bindfunc['dragSpLineStart'] = Utility.bind_callback(self, self.dragSpLineStart);
	self.bindfunc['changeOffset'] = Utility.bind_callback(self, self.changeOffset);
	self.bindfunc['onStopMove'] = Utility.bind_callback(self, self.onStopMove);
end

function TestUI:InitUI(asset_obj)
	app.set_frame_rate(60);
	app.log("TestUI:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('TestUI');
    self.vs = {};
	self.vs.mask = ngui.find_sprite(self.ui,"center_other/sp_mark");
	self.vs.spTouch = ngui.find_sprite(self.ui,"center_other/spItem");
	self.vs.texList = {};
	self.vs.wgList = {};
	self.vs.sproom = ngui.find_sprite(self.ui,"center_other/sproom");
	self.vs.spChange = ngui.find_sprite(self.ui,"center_other/Sprite");
	self.vs.spdec = ngui.find_sprite(self.ui,"center_other/spdec");
	self.vs.spadd = ngui.find_sprite(self.ui,"center_other/spadd");
	self.vs.spslide = ngui.find_sprite(self.ui,"center_other/spLine/spSlide");
	self.vs.spline = ngui.find_sprite(self.ui,"center_other/spLine");
	self.vs.spChange:set_on_ngui_click(self.bindfunc['changeType']);
	self.vs.spdec:set_on_ngui_click(self.bindfunc['decItemData']);
	self.vs.spadd:set_on_ngui_click(self.bindfunc['addItemData']);
	self.vs.spline:set_on_ngui_drag_start(self.bindfunc['dragSpLineStart']);
	self.vs.spline:set_on_ngui_drag_move(self.bindfunc['changeOffset']);
	self.initX = 0;
	self.initY = -360;
	self.labList = self.labList or {};
	self.wgList = self.wgList or {};
	self.labwgList = self.labwgList or {};
	self.texList = self.texList or {};
	self.texwgList = self.texwgList or {};
	self.gbList = self.gbList or {};
	self.indexList = self.indexList or {};
	function self.onTime()
		self.data = TestUI.createData(20);
		self.cycleInitData = {};
		self.cycleInitData.raid = 300;
		self.cycleInitData.farScale = 0.5;
		self.cycleInitData.nearScale = 1.0;
		self.cycleInitData.touchSp = self.vs.spTouch;
		self.cycleInitData.offsetAngle = 0;
		self.cycleInitData.showNum = 3;
		self.cycleInitData.maxNum = #self.data;
		self.cycleInitData.updateItemCall = self.bindfunc['updateItem'];
		self.cycleInitData.type = DragCycleGroupType.List;
		self.cycleInitData.baseItem = self.vs.sproom;
		self.cycleInitData.stopMoveCall = self.bindfunc['onStopMove'];
		self.vs.dragCycleGroup = DragCycleGroup:new(self.cycleInitData)
	end 
	--self.bindfunc['onTime'] = Utility.bind_callback(self, self.onTime);
	--timer.create(self.bindfunc['onTime'],500,1);
	self.onTime();
	--self.vs.dragCycleGroup:set_index(100);
	--self.vs.dragCycleGroup:tweenToIndex(20);
end

function TestUI:updateItem(obj,index,x,depth,scale,color,lineScale)
	local type;
	if self.vs.dragCycleGroup then 
		type = self.vs.dragCycleGroup.type;
	else
		type = self.cycleInitData.type;
	end 
	
	local lab;
	local wg;
	local labwg;
	local tex;
	local texwg;
	local gb;
	local w,h
	local pid = obj:get_pid();
	if type == DragCycleGroupType.List or type == DragCycleGroupType.RList then 
		if self.gbList[pid] == nil then 
			gb = obj:get_game_object();
			wg = ngui.find_widget(gb,gb:get_name());
			lab = ngui.find_label(gb,"labIndex");
			labwg = ngui.find_widget(gb,"labIndex");
			tex = ngui.find_texture(gb,"tex");
			texwg = ngui.find_widget(gb,"tex");
			self.gbList[pid] = gb;
			self.wgList[pid] = wg;
			self.labList[pid] = lab;
			self.labwgList[pid] = labwg;
			self.texList[pid] = tex;
			self.texwgList[pid] = texwg;
		else
			gb = self.gbList[pid];
			wg = self.wgList[pid];
			lab = self.labList[pid];
			labwg = self.labwgList[pid];
			tex = self.texList[pid];
			texwg = self.texwgList[pid];
		end 
		if self.data[index] == nil then 
			obj:set_active(false);
			--lab:set_text(tostring(index));
			self.indexList[pid] = nil;
		else 
			obj:set_active(true);
			if index ~= self.indexList[pid] then 
				tex:set_texture(self.data[index].path,true);
				lab:set_text(tostring(index)..self.data[index].name);
			end 
			--lab:set_text(tostring(lineScale));
			self.indexList[pid] = index;
			wg:set_depth(depth);
			labwg:set_depth(depth+1);
			texwg:set_depth(depth);
			gb:set_local_scale(scale,scale,scale);
			w,h = wg:get_size();
			--obj:set_position(x+self.initX,h*scale/2+self.initY,0);
			obj:set_position(x+self.initX,h/2+self.initY,0);
			tex:set_color(color,color,color,1);
		end 
	else 
		obj:set_active(true);
		if self.gbList[pid] == nil then 
			gb = obj:get_game_object();
			wg = ngui.find_widget(gb,gb:get_name());
			lab = ngui.find_label(gb,"labIndex");
			labwg = ngui.find_widget(gb,"labIndex");
			tex = ngui.find_texture(gb,"tex");
			texwg = ngui.find_widget(gb,"tex");
			self.gbList[pid] = gb;
			self.labList[pid] = lab;
			self.labwgList[pid] = labwg;
			tex = self.texList[pid];
			texwg = self.texwgList[pid];
		else
			gb = self.gbList[pid];
			wg = self.wgList[pid];
			lab = self.labList[pid];
			labwg = self.labwgList[pid];
			tex = self.texList[pid];
			texwg = self.texwgList[pid];
		end 
		--obj:set_texture(self.data[index].path,true);
		lab:set_text("");
		wg:set_depth(depth);
		labwg:set_depth(depth+1);
		texwg:set_depth(depth);
		gb:set_local_scale(scale,scale,scale);
		obj:set_position(x+self.initX,y+self.initY,0);
		obj:set_color(color,color,color,1);
	end
end 

function TestUI.createData(num)
	local i = 0;
	local data = {};
	local path;
	local name;
	for i = 1,num do 
		path = "assetbundles/prefabs/ui/image/backgroud/jjc/jjc_kuang"..tostring(math.random(1,5)).."_2.assetbundle";
		if math.random() > 0.5 then 
			name = TestUI.rdText[math.random(1,#TestUI.rdText)]..TestUI.rdText[math.random(1,#TestUI.rdText)]..TestUI.rdText[math.random(1,#TestUI.rdText)];
		else 
			name = TestUI.rdText[math.random(1,#TestUI.rdText)]..TestUI.rdText[math.random(1,#TestUI.rdText)];
		end
		table.insert(data,{path = path,name = name});
	end
	return data;
end 

function TestUI:changeType()
	local max = #self.data
	local index = math.random(1,max);
	self.vs.dragCycleGroup:tweenToIndex(index);
	--[[if self.vs.dragCycleGroup.type == DragCycleGroupType.List then 
		self.vs.dragCycleGroup:set_type(DragCycleGroupType.RList)
	else 
		self.vs.dragCycleGroup:set_type(DragCycleGroupType.List)
	end--]]
end 

function TestUI:addItemData()
	self.data = self.data or {};
	table.insert(self.data,self.createData(1)[1]);
	self.vs.dragCycleGroup:set_maxNum(#self.data);
end 

function TestUI:decItemData()
	self.data = self.data or {};
	if #self.data > 0 then 
		table.remove(self.data);
	end
	self.vs.dragCycleGroup:set_maxNum(#self.data);
end 

function TestUI:dragSpLineStart(name,x,y,go_obj)
	self.startSlideX = x;
	self.startSlidePx = self.vs.spslide:get_position()
end 

function TestUI:changeOffset(name, x, y, go_obj)
	local distance = x - self.startSlideX;
	local px,py,pz = self.vs.spslide:get_position();
	local sw,sh = self.vs.spline:get_size();
	local disX = math.max(-sw/2,self.startSlidePx+distance);
	disX = math.min(sw/2,disX);
	self.vs.spslide:set_position(disX,py,pz);
	local offset = 360 * (disX + sw/2)/sw - 180;
	self.vs.dragCycleGroup:set_offsetAngle(offset)
end 

function TestUI:onStopMove(index)
	app.log("Stop At Index : "..tostring(index));
end 

function TestUI:Init(data)
	app.log("TestUI:Init");
    self.pathRes = "assetbundles/prefabs/text/ui_test.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function TestUI:DestroyUi()
	app.log("TestUI:DestroyUi");
	if self.vs ~= nil then 
		self.vs.dragCycleGroup:destroy_object();
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
	app.set_frame_rate(30);
end

--显示ui
function TestUI:Show()
	app.log("TestUI:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function TestUI:Hide()
	app.log("TestUI:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function TestUI:MsgRegist()
	app.log("TestUI:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function TestUI:MsgUnRegist()
	app.log("TestUI:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end

--[[
GuildBossReward = Class('GuildBossReward', UiBaseClass);

--重新开始
function GuildBossReward:Restart(data)
    --app.log("GuildBossReward:Restart");
    UiBaseClass.Restart(self, data);
end

function GuildBossReward:InitData(data)
    --app.log("GuildBossReward:InitData");
    UiBaseClass.InitData(self, data);
end

function GuildBossReward:RegistFunc()
	--app.log("GuildBossReward:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['onClickMask'] = Utility.bind_callback(self, self.onClickMask);
end

function GuildBossReward:InitUI(asset_obj)
	app.log("GuildBossReward:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('GuildBossReward');
    self.vs = {};
end


function GuildBossReward:Init(data)
	app.log("GuildBossReward:Init");
    self.pathRes = "assetbundles/prefabs/ui/guild/ui_2821_guild_award.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function GuildBossReward:DestroyUi()
	app.log("GuildBossReward:DestroyUi");
	if self.vs ~= nil then 
		self.vs = nil;
	end 
    UiBaseClass.DestroyUi(self);
end

--显示ui
function GuildBossReward:Show()
	app.log("GuildBossReward:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function GuildBossReward:Hide()
	app.log("GuildBossReward:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function GuildBossReward:MsgRegist()
	app.log("GuildBossReward:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function GuildBossReward:MsgUnRegist()
	app.log("GuildBossReward:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
]]
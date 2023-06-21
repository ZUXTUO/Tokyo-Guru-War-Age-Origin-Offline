TrialScene = Class("TrialScene")

local constPlayerMoveSpeed = 0.1; -- 玩家跑动速度
local constPlayerSize = 1.25; -- 玩家模型缩放
local constLevelSize = 1.25; -- 关卡光幕特效缩放
local constBoxSize = 1.25; -- 宝箱模型缩放
local constBuffSize = 1.25; -- 赫包模型缩放
local startCamerapos = 0; -- 起始摄像机位置
local width = 50; -- 组距离
local moveSpeed = 6; -- 人物移动速度

local _pathRes = {} 
_pathRes[0] = "assetbundles/prefabs/map/061_yuanzheng/yuanzheng.assetbundle";

function TrialScene.GetInstance(parentUIObj)
	if TrialScene.instance == nil then 	
		TrialScene:new(parentUIObj);
	end
	return TrialScene.instance;
end 

function TrialScene:Init(data)
	TrialScene.instance = self;
	--self.loadingId = GLoading.Show(GLoading.EType.ui);
	data = data or {};
	self.name = self._className
    self:InitData(data);
	self:RegistFunc();
	ResourceLoader.LoadAsset(_pathRes[0], self.bindfunc["OnSceneObjectLoaded"], self._className);
end

function TrialScene:InitData(data)
	self.bindfunc = {};
	self.TrialMap = data;
end 

function TrialScene:RegistFunc()
	self.bindfunc["OnSceneObjectLoaded"] = Utility.bind_callback(self, TrialScene.OnSceneObjectLoaded);
	--self.bindfunc["OnUpdate"] = Utility.bind_callback(self,TrialScene.OnUpdate);
end

function TrialScene:UnRegistFunc()
	for k, v in pairs(self.bindfunc) do
		if v ~= nil then
			Utility.unbind_callback(self, v)
		end
	end
end 

function TrialScene:DestroyUi()
	TrialScene.needUpdate = true;
	self:UnRegistFunc();
	if self.modelPlayer then 
		_,_,TrialScene.LastRolePos = self.modelPlayer:get_local_position();
		Tween.removeTween(self.modelPlayer);
	end 
	if self.scene then
		self.scene:set_active(false)
		self.scene:set_parent(nil)
		self.scene = nil
	end
	if self.viewCamera then 
		Tween.removeTween(self.viewCamera);
	end 
	for k,v in pairs(self) do 
		self[k] = nil;
	end
end

function TrialScene.Destroy()
	--app.log("TrialScene.Destroy");
	if TrialScene.instance then 
		TrialScene.instance:DestroyUi();
		camera.enable_dof(false,1,10);
		TrialScene.instance = nil;
	end
end 

function TrialScene:OnSceneObjectLoaded(pid, filepath, asset_obj, error_info)
	--app.log("TrialScene:OnSceneObjectLoaded");
	self:InitAllTrialLevel(asset_obj);
	if TrialScene.needUpdate then 
		if g_dataCenter.trial.allLevelConfig ~= nil and #g_dataCenter.trial.allLevelConfig > 0 then 
			if TrialScene.LastRolePos ~= nil then 
				self.modelPlayer:set_local_position(0,0.075,TrialScene.LastRolePos);
				local x,y,z = self.viewCamera:get_local_position();
				self.viewCamera:set_local_position(TrialScene.LastRolePos,y,z);
			end
			self:UpdateTrailAllLevel();
			self:ActiveLevel(true);
		end 
	end
	--Root.AddLateUpdate(self.bindfunc["OnUpdate"]);
end 

function TrialScene:InitAllTrialLevel(asset_obj)
	self.scene = asset_game_object.create(asset_obj);
	self.scene:set_position(-999,-999,-999);
	self.viewCamera = self.scene:get_child_by_name("viewCamera");
	self.cameraview = camera.find_by_name(self.scene:get_name().."/viewCamera");
	self.screenWidth = app.get_screen_width();
	self.screenHeight = app.get_screen_height();
	self.groups = {};
	self.groups[1] = self.scene:get_child_by_name("group2");
	self.groups[2] = self.scene:get_child_by_name("group3");
	self.groups[3] = self.scene:get_child_by_name("group1");
	self.rolePos = self.scene:get_child_by_name("rolePos");
	self.follows = {};
	self.follows[1] = self.scene:get_child_by_name("layer1");
	self.follows[2] = self.scene:get_child_by_name("layer2");
	self.follows[3] = self.scene:get_child_by_name("layer3");
	self.baseBoxs = {};
	self.baseBoxs[1] = self.scene:get_child_by_name("rolePos/box1");
	self.baseBoxs[2] = self.scene:get_child_by_name("rolePos/box2");
	self.baseBoxs[3] = self.scene:get_child_by_name("rolePos/box3");
	self.baseBoxs[4] = self.scene:get_child_by_name("rolePos/box4");
	self.baseBoxs[5] = self.scene:get_child_by_name("rolePos/box5");
	self.baseBoxs[6] = self.scene:get_child_by_name("rolePos/box6");
	self.baseBoxs[7] = self.scene:get_child_by_name("rolePos/box7");
	self.baseHebaos = {}
	self.baseHebaos[1] = self.scene:get_child_by_name("rolePos/hebao1");
	self.baseHebaos[2] = self.scene:get_child_by_name("rolePos/hebao2");
	self.baseHebaos[3] = self.scene:get_child_by_name("rolePos/hebao3");
	self.baseHebaos[4] = self.scene:get_child_by_name("rolePos/hebao4");
	self.baseHebaos[5] = self.scene:get_child_by_name("rolePos/hebao5");
	self.baseHebaos[6] = self.scene:get_child_by_name("rolePos/hebao6");
	self.baseDirens = {}
	self.baseDirens[1] = self.scene:get_child_by_name("rolePos/diren1");
	self.baseDirens[2] = self.scene:get_child_by_name("rolePos/diren2");
	self.baseDirens[3] = self.scene:get_child_by_name("rolePos/diren3");
	self.baseDirens[4] = self.scene:get_child_by_name("rolePos/diren4");
	self.baseDirens[5] = self.scene:get_child_by_name("rolePos/diren5");
	self.baseDirens[6] = self.scene:get_child_by_name("rolePos/diren6");
	self.numbernode = self.scene:get_child_by_name("rolePos/numbers");
	self.numbers = {}
	self.numbers[1] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number01");
	self.numbers[2] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number02");
	self.numbers[3] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number03");
	self.numbers[4] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number04");
	self.numbers[5] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number05");
	self.numbers[6] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number06");
	self.numbers[7] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number07");
	self.numbers[8] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number08");
	self.numbers[9] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number09");
	self.numbers[10] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number10");
	self.numbers[11] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number11");
	self.numbers[12] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number12");
	self.numbers[13] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number13");
	self.numbers[14] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number14");
	self.numbers[15] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number15");
	self.numbers[16] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number16");
	self.numbers[17] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number17");
	self.numbers[18] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number18");
	self.numbers[19] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number19");
	self.numbers[20] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number20");
	self.numbers[21] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number21");
	self.numbers[22] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number22");
	self.numbers[23] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number23");
	self.numbers[24] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number24");
	self.numbers[25] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number25");
	self.numbers[26] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number26");
	self.numbers[27] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number27");
	self.numbers[28] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number28");
	self.numbers[29] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number29");
	self.numbers[30] = self.scene:get_child_by_name("rolePos/numbers/fx_yuanzheng_number30");
	
	self.modelPlayer = self.scene:get_child_by_name("rolePos/ch_s001_yuanzheng");
	
	self.baseBoxs[1]:set_local_position(0,-100,0);
	self.baseBoxs[2]:set_local_position(0,-100,0);
	self.baseBoxs[3]:set_local_position(0,-100,0);
	self.baseBoxs[4]:set_local_position(0,-100,0);
	self.baseBoxs[5]:set_local_position(0,-100,0);
	self.baseBoxs[6]:set_local_position(0,-100,0);
	self.baseBoxs[7]:set_local_position(0,-100,0);
	self.baseHebaos[1]:set_local_position(0,-100,0);
	self.baseHebaos[2]:set_local_position(0,-100,0);
	self.baseHebaos[3]:set_local_position(0,-100,0);
	self.baseHebaos[4]:set_local_position(0,-100,0);
	self.baseHebaos[5]:set_local_position(0,-100,0);
	self.baseHebaos[6]:set_local_position(0,-100,0);
	self.baseDirens[1]:set_local_position(0,-100,0);
	self.baseDirens[2]:set_local_position(0,-100,0);
	self.baseDirens[3]:set_local_position(0,-100,0);
	self.baseDirens[4]:set_local_position(0,-100,0);
	self.baseDirens[5]:set_local_position(0,-100,0);
	self.baseDirens[6]:set_local_position(0,-100,0);
	
	self.numbernode:set_active(false);
	camera.enable_dof(true,0.6,0.4);
	--GLoading.Hide(GLoading.EType.ui, self.loadingId);
	if self.TrialMap ~= nil then 
		self.TrialMap:onTrialSceneLoadok();
	end
end 

function TrialScene:DataReset()
	TrialScene.LastRolePos = nil;
	local x,y,z = self.viewCamera:get_local_position();
	self.modelPlayer:set_local_position(0,0.075,0);
	self.viewCamera:set_local_position(0,y,z);
	self:UpdateTrailAllLevel();
	self:ActiveLevel();
end 

function TrialScene:DragStart(posX)
	self.StartPosX = posX;
	self.StartX,self.StartY,self.StartZ = self.viewCamera:get_local_position();
end 

function TrialScene:Click(posX,posY)
	--camera.screen_to_viewport_point
	if self.canDrag ~= false then 
		if self.isRuning == true then 
			do return end;
		end 
		local vx,vy = self.cameraview:screen_to_viewport_point(posX,posY,0)
		local x,y,z = self.viewCamera:get_local_position();
		--app.log("posX,posY = "..tostring(posX)..","..tostring(posY).."\nvx,vy= "..tostring(vx)..","..tostring(vy))
		if vy > 0.22222 and vy < 0.66666 then 
			local vpx1,vpx2;
			local wp1x,wp2x,wp1y,wp2y,wp1z,wp2z;
			wp1x,wp1y,wp1z = self.items[self.maxItemId - 1]:get_position();
			wp2x,wp2y,wp2z = self.items[self.maxItemId]:get_position();

			vpx1 = self.cameraview:world_to_viewport_point(wp1x,wp1y,wp1z);
			vpx2 = self.cameraview:world_to_viewport_point(wp2x,wp2y,wp2z);
			local dvpx = vpx2 - vpx1;
			local seeIndex = math.floor(x/2.5);
			local dx = x - seeIndex * 2.5;
			local offsetvpx = dx/2.5 * dvpx;
			local floor = (vx - 0.5 + offsetvpx)/dvpx - math.floor((vx - 0.5 + offsetvpx)/dvpx);
			local index = math.floor((vx - 0.5 + offsetvpx)/dvpx) + seeIndex + 3;
			if floor > 0.1 and floor < 0.6 then 
				--app.log("click index = "..tostring(index).." | targetIndex = "..tostring(g_dataCenter.trial.allInfo.cur_expedition_trial_level));
				if index == g_dataCenter.trial.allInfo.cur_expedition_trial_level then 
					if g_dataCenter.trial.allLevelConfig[g_dataCenter.trial.allInfo.cur_expedition_trial_level].type == 1 
						or g_dataCenter.trial.allInfo.cur_expedition_trial_level == #g_dataCenter.trial.allLevelConfig then 
						self:GotoLevel();
					else 
						self.isRuning = false;
						g_dataCenter.trial:initCurLevel();
					end
				end
			end 
		end
	end 
end 

function TrialScene:DragMove(posX)
	if self.canDrag ~= false then 
		local dx = -(posX - self.StartPosX)/100;
		if self.StartX + dx < -3 then 
			dx = -3 - self.StartX;
		end 
		local max = (#g_dataCenter.trial.allLevelConfig - 5) * 2.5;
		if g_dataCenter.trial.allLevelConfig ~= nil and #g_dataCenter.trial.allLevelConfig > 0 then 
			if self.StartX + dx > max then 
				dx = max - self.StartX;
			end
		end 
		local OnUpdate = function()
			local x,y,z = self.viewCamera:get_local_position();
			if self.lastx ~= nil then 
				self.speedx = x - self.lastx;
			end 
			self.lastx = x;
			local mx,my,mz = self.modelPlayer:get_local_position();
			if mz < 0 then
				mz = - 2.5
			else 
				mz = mz - 2.5;
			end 
			if x > mz and x - mz > 0.25 then 
				if self.TrialMap ~= nil then 
					self.TrialMap:SetArrowBtnState(1);
				end
			elseif x < mz and mz - x > 0.25 then 
				if self.TrialMap ~= nil then 
					if max - mz <= 5.5 and max == x then 
						self.TrialMap:SetArrowBtnState(0);
					else 
						self.TrialMap:SetArrowBtnState(2);
					end 
				end
			else 
				if self.TrialMap ~= nil then 
					self.TrialMap:SetArrowBtnState(0);
				end
			end
			self.isDragMove = true;
			self:OnUpdate();
		end
		Tween.addTween(
			self.viewCamera,
			0.1,
			{["local_position"] = {self.StartX + dx,self.StartY,self.StartZ}},
			Transitions.EASE_OUT,
			0,
			nil,
			OnUpdate,
			nil);
	end 
end 

function TrialScene:DragEnd(posX)
	if self.canDrag ~= false then 
		self.lastx = nil;
		local x,y,z = self.viewCamera:get_local_position();
		self.speedx = self.speedx or 0;
		local tox = x + self.speedx * 10;
		if tox < -2.5 then 
			tox = -2.5;
		end 
		local max = (#g_dataCenter.trial.allLevelConfig - 5) * 2.5;
		if g_dataCenter.trial.allLevelConfig ~= nil and #g_dataCenter.trial.allLevelConfig > 0 then 
			if tox > max then 
				tox = max;
			end 
		end 
		local OnUpdate = function()
			local x,y,z = self.viewCamera:get_local_position();
			if self.lastx ~= nil then 
				self.speedx = x - self.lastx;
			end 
			self.lastx = x;
			local mx,my,mz = self.modelPlayer:get_local_position();
			if mz < 0 then 
				mz = -2.5
			else 
				mz = mz - 2.5;
			end 
			if x > mz and x - mz > 0.25 then 
				if self.TrialMap ~= nil then 
					self.TrialMap:SetArrowBtnState(1);
				end
			elseif x < mz and mz - x > 0.25 then 
				if self.TrialMap ~= nil then 
					if max - mz <= 5.5 and max == x then 
						self.TrialMap:SetArrowBtnState(0);
					else 
						self.TrialMap:SetArrowBtnState(2);
					end 
				end
			else 
				if self.TrialMap ~= nil then 
					self.TrialMap:SetArrowBtnState(0);
				end
			end
			self.isDragMove = true;
			self:OnUpdate();
		end
		if self.speedx ~= nil or self.speedx ~= 0 then 
			Tween.addTween(
			self.viewCamera,
			0.5,
			{["local_position"] = {tox,y,z}},
			Transitions.EASE_OUT,
			0,
			nil,
			OnUpdate,
			nil);
		end
	end 
end 

function TrialScene:OnUpdate()
	local x,y,z = self.viewCamera:get_local_position();
	for i = 1,#self.follows do
		local xi,yi,zi = self.follows[i]:get_local_position();
		self.follows[i]:set_local_position(x,yi,zi);
		self.follows_matuv = self.follows_matuv or {};
		if self.follows_matuv[i] == nil then 
			local uvx,uvy,uvz,uvw = self.follows[i]:get_material_vector_with_name("_MainTex_ST");
			self.follows_matuv[i] = {x = uvx,y = uvy,z = uvz,w = uvw};
		end 
		if i == 1 then 
			self.follows[i]:set_material_vector_with_name("_MainTex_ST",self.follows_matuv[i].x,self.follows_matuv[i].y,x/30,self.follows_matuv[i].w)
			--local uvx,uvy,uvz,uvw = self.follows[i]:get_material_vector_with_name("_MainTex_ST");
			--app.log("uvz = "..tostring(uvz));
		elseif i == 2 then 
			self.follows[i]:set_material_vector_with_name("_MainTex_ST",self.follows_matuv[i].x,self.follows_matuv[i].y,x/60,self.follows_matuv[i].w)
		elseif i == 3 then 
			self.follows[i]:set_material_vector_with_name("_MainTex_ST",self.follows_matuv[i].x,self.follows_matuv[i].y,x/120,self.follows_matuv[i].w)
		end
	end 
	local index = math.floor((x + width/2) / width);
	local groups = self.groups;
    local itarget = math.abs(math.mod(index,#groups));
    if itarget == 0 then 
		groups[#groups]:set_local_position((index-1) * width, 0, 0);
		groups[1]:set_local_position(index * width, 0, 0);
		groups[2]:set_local_position((index+1) * width, 0, 0);
	elseif itarget == #groups - 1 then 
		groups[#groups - 1]:set_local_position((index - 1) * width, 0, 0);
		groups[#groups]:set_local_position(index * width, 0, 0);
		groups[1]:set_local_position((index + 1) * width, 0, 0);
    else
		groups[itarget]:set_local_position((index - 1) * width, 0, 0);
		groups[itarget+1]:set_local_position(index * width, 0, 0);
		groups[itarget+2]:set_local_position((index + 1) * width, 0, 0);
    end 
	if g_dataCenter.trial.allLevelConfig ~= nil and #g_dataCenter.trial.allLevelConfig > 0 then 
		self:UpdateTrailAllLevel();
	end
	self:UpdateTouchTip();
end 

function TrialScene:UpdateTouchTip()
	if self.TrialMap ~= nil and self.TrialMap.vs ~= nil then 
		if self.items[g_dataCenter.trial.allInfo.cur_expedition_trial_level] ~= nil then 
			local item = self.items[g_dataCenter.trial.allInfo.cur_expedition_trial_level];
			local cf = g_dataCenter.trial.allLevelConfig[g_dataCenter.trial.allInfo.cur_expedition_trial_level];
			local rate1 = (self.screenHeight/self.screenWidth)/(9/16)*0.1;
			local rate2 = (self.screenHeight/self.screenWidth)/(9/16)*-0.15;
			if cf.type == 1 then 
				self.TrialMap.vs.spTouchTip1:set_active(true);
				self.TrialMap.vs.spTouchTip2:set_active(false);
				local ix,iy,iz = item:get_position();
				local vx,vy,vz = self.cameraview:world_to_viewport_point(ix - 0.1,iy,iz);
				self.TrialMap.vs.spTouchTip1:set_position(1280 * (vx-0.5),720 * rate1,0);
			else 
				local isFinish = g_dataCenter.trial.allInfo.finish;
				if isFinish == false then 
					self.TrialMap.vs.spTouchTip1:set_active(false);
					self.TrialMap.vs.spTouchTip2:set_active(true);
					local ix,iy,iz = item:get_position();
					local vx,vy,vz = self.cameraview:world_to_viewport_point(ix,iy,iz);
					self.TrialMap.vs.spTouchTip2:set_position(1280 * (vx-0.5),720 * rate2,0);
				else 
					self.TrialMap.vs.spTouchTip1:set_active(false);
					self.TrialMap.vs.spTouchTip2:set_active(false);
				end
			end
		end 
	end
end 

function TrialScene:CameraFollow(endCall)
	local mx,my,mz = self.modelPlayer:get_local_position();
	local x,y,z = self.viewCamera:get_local_position();
	--local toPos = mz;
	--if mz < 3 then 
	local toPos = mz - 2.5;
	--end 
	if mz < 0 then 
		toPos = -2.5;
	end 
	if g_dataCenter.trial.allLevelConfig ~= nil and #g_dataCenter.trial.allLevelConfig > 0 then 
		local max = (#g_dataCenter.trial.allLevelConfig - 5) * 2.5;
		if mz > max then 
			toPos = max;
		end
	end 
	local OnUpdate = function()	
		self:OnUpdate();
	end
	local onEnd = function()
		if endCall then 
			endCall();
		end 
		self.canDrag = true;
	end
	self.TrialMap:SetArrowBtnState(0);
	local moveTime = math.min(math.abs(x - toPos)/moveSpeed,0.5);
	Tween.addTween(
		self.viewCamera,
		moveTime,
		{["local_position"] = {toPos,y,z}},
		Transitions.EASE_OUT,
		0,
		nil,
		OnUpdate,
		onEnd);
end 

function TrialScene:ActiveLevel(canReturn)
	self.isDragMove = false;
	self.canDrag = false;
	--local index = g_dataCenter.trial.allInfo.cur_expedition_trial_level;
	local index = 0;
	if index > 0 then 
		if g_dataCenter.trial.allLevelConfig[g_dataCenter.trial.allInfo.cur_expedition_trial_level].type ~= 1 
			and g_dataCenter.trial.allInfo.cur_expedition_trial_level ~= #g_dataCenter.trial.allLevelConfig then 
			index = index + 1;
		end 
		local isFinish = g_dataCenter.trial.allInfo.finish;
		local toPos = index * 2.5 - 5.5;
		if g_dataCenter.trial.allInfo.cur_expedition_trial_level == 1 then 
			toPos = (index - 1) * 2.5;
		end 
		if isFinish == true then 
			toPos = (index - 1) * 2.5 - 1;
		end 
		local x,y,z = self.modelPlayer:get_local_position();
		local onStart = function()
			self.isRuning = true;
			self.modelPlayer:animator_play("run");
			self:UpdateTouchTip();
		end 
		local OnUpdate = function()		
			self:OnUpdate();
		end 
		local onEnd = function()
			self.isRuning = false;
			self.modelPlayer:set_local_rotation(0,0,0);
			self.modelPlayer:animator_play("stand");
			self:CameraFollow();
		end
		local distance = math.abs(toPos-z);
		local moveTime = distance/moveSpeed;
		if canReturn == true and g_dataCenter.trial.allInfo.cur_expedition_trial_level ~= #g_dataCenter.trial.allLevelConfig then 
			if toPos ~= z and distance < 6 then 
				if toPos > z then 
					self.modelPlayer:set_local_rotation(0,0,0);
					Tween.addTween(self.modelPlayer,moveTime,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,nil,onEnd);
				else
					self.modelPlayer:set_local_rotation(0,180,0);
					Tween.addTween(self.modelPlayer,moveTime,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,nil,onEnd);
				end 
			else 
				Tween.addTween(self.modelPlayer,0,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,nil,onEnd);
			end
		else 
			if toPos > z then 
				if toPos - z < 6 then 
					Tween.addTween(self.modelPlayer,moveTime,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,nil,onEnd);
				else 
					Tween.addTween(self.modelPlayer,0,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,nil,onEnd);
				end
			else 
				self:CameraFollow();
			end
		end
	end
	self.lastSeeIndex = -899;
	self:UpdateTrailAllLevel();
end 

function TrialScene:GotoLevel()
	self.isDragMove = false;
	self.canDrag = false;
	local isFinish = g_dataCenter.trial.allInfo.finish;
	if isFinish == false then 
		local x,y,z = self.modelPlayer:get_local_position();
		local index = g_dataCenter.trial.allInfo.cur_expedition_trial_level;
		local toPos = (index - 1) * 2.5;
		local onStart = function()
			self.isRuning = true;
			self.modelPlayer:animator_play("run");
		end 
		local OnUpdate = function()			
			--self:UpdateTouchTip();
		end 
		local onFollowEndCall = function()
			self.isRuning = false;
			local data,challengeInfo = g_dataCenter.trial:get_levelData()
			if data and data.type == 1 then 
				if challengeInfo == nil then 
					g_dataCenter.trial:initCurLevel();
				else 
					if data.use_cfg_diff ~= 0 then 
						local data,challengeInfo = g_dataCenter.trial:get_levelData();
						if challengeInfo ~= nil then 
							g_dataCenter.trial:set_diff(data.use_cfg_diff);
							TrialChooseRole.PopPanel(0,0);
						else 
							g_dataCenter.trial:set_diff(data.use_cfg_diff)
							self.loadingId = GLoading.Show(GLoading.EType.ui);
							--msg_expedition_trial.get_challenge_info();
						end
					else 	
						TrialChooseDifficult.PopPanel();
					end 
				end 
			else 
				if g_dataCenter.trial.allInfo.cur_expedition_trial_level == #g_dataCenter.trial.allLevelConfig then 
					g_dataCenter.trial:initCurLevel();
				end
			end
		end 
		local onEnd = function()
			self.modelPlayer:animator_play("stand");
			self:CameraFollow(onFollowEndCall);
		end 
		local distance = math.abs(toPos-z);
		local moveTime = distance/moveSpeed;
		if z < toPos then 
			Tween.addTween(self.modelPlayer,moveTime,{["local_position"] = {0,0.075,toPos}},nil,0,onStart,OnUpdate,onEnd);
		else 
			onEnd();
		end
	else
		self.isRuning = false;
		self.canDrag = true;
		FloatTip.Float("今日远征试炼已完成");
	end
end 

function TrialScene:toUpdateTrailAllLevel()
	TrialScene.needUpdate = true;
end 

function TrialScene:UpdateTrailAllLevel()
	local x,y,z = self.viewCamera:get_local_position();
	local seeIndex = math.floor(x/2.5);
	if seeIndex < 0 then 
		seeIndex = 0;
	end 
	self.lastSeeIndex = self.lastSeeIndex or -999;
	if seeIndex ~= self.lastSeeIndex then 
		local cf = {};
		if seeIndex == 0 then 
			cf[1] = g_dataCenter.trial.allLevelConfig[seeIndex + 1];
			cf[2] = g_dataCenter.trial.allLevelConfig[seeIndex + 2];
			cf[3] = g_dataCenter.trial.allLevelConfig[seeIndex + 3];		
			cf[4] = g_dataCenter.trial.allLevelConfig[seeIndex + 4];
			cf[5] = g_dataCenter.trial.allLevelConfig[seeIndex + 5];
			cf[6] = g_dataCenter.trial.allLevelConfig[seeIndex + 6];
			cf[7] = g_dataCenter.trial.allLevelConfig[seeIndex + 7];
			cf[8] = g_dataCenter.trial.allLevelConfig[seeIndex + 8];
			cf[9] = g_dataCenter.trial.allLevelConfig[seeIndex + 9];
		elseif seeIndex == 1 then 
			cf[1] = g_dataCenter.trial.allLevelConfig[seeIndex];
			cf[2] = g_dataCenter.trial.allLevelConfig[seeIndex + 1];
			cf[3] = g_dataCenter.trial.allLevelConfig[seeIndex + 2];		
			cf[4] = g_dataCenter.trial.allLevelConfig[seeIndex + 3];
			cf[5] = g_dataCenter.trial.allLevelConfig[seeIndex + 4];
			cf[6] = g_dataCenter.trial.allLevelConfig[seeIndex + 5];
			cf[7] = g_dataCenter.trial.allLevelConfig[seeIndex + 6];
			cf[8] = g_dataCenter.trial.allLevelConfig[seeIndex + 7];
			cf[9] = g_dataCenter.trial.allLevelConfig[seeIndex + 8];
		elseif seeIndex == 2 then
			cf[1] = g_dataCenter.trial.allLevelConfig[seeIndex - 1];
			cf[2] = g_dataCenter.trial.allLevelConfig[seeIndex];
			cf[3] = g_dataCenter.trial.allLevelConfig[seeIndex + 1];		
			cf[4] = g_dataCenter.trial.allLevelConfig[seeIndex + 2];
			cf[5] = g_dataCenter.trial.allLevelConfig[seeIndex + 3];
			cf[6] = g_dataCenter.trial.allLevelConfig[seeIndex + 4];
			cf[7] = g_dataCenter.trial.allLevelConfig[seeIndex + 5];
			cf[8] = g_dataCenter.trial.allLevelConfig[seeIndex + 6];
			cf[9] = g_dataCenter.trial.allLevelConfig[seeIndex + 7];
		else 
			cf[1] = g_dataCenter.trial.allLevelConfig[seeIndex - 2];
			cf[2] = g_dataCenter.trial.allLevelConfig[seeIndex - 1];
			cf[3] = g_dataCenter.trial.allLevelConfig[seeIndex];		
			cf[4] = g_dataCenter.trial.allLevelConfig[seeIndex + 1];
			cf[5] = g_dataCenter.trial.allLevelConfig[seeIndex + 2];
			cf[6] = g_dataCenter.trial.allLevelConfig[seeIndex + 3];
			cf[7] = g_dataCenter.trial.allLevelConfig[seeIndex + 4];
			cf[8] = g_dataCenter.trial.allLevelConfig[seeIndex + 5];
			cf[9] = g_dataCenter.trial.allLevelConfig[seeIndex + 6];
		end
		self.lastSeeIndex = seeIndex;
		self.cf = cf;
		self.items = self.items or {};
		for i = 1,9 do
			if cf[i] == nil then 
				break;
			end 
			local posIndex = tonumber(cf[i].id) - 1;
			if cf[i].type == 1 then 
				self.maxItemId = tonumber(cf[i].id);
				if self.items[cf[i].id] == nil then 
					self.items[cf[i].id] = self.baseDirens[cf[i].page]:clone(); 					
					self.items[cf[i].id]:set_active(true);
					local fx_scene_fight = self.items[cf[i].id]:get_child_by_name("wanfa/fx_scene_fight");
					local fx_scene_3v3 = self.items[cf[i].id]:get_child_by_name("wanfa/fx_scene_3v3");
					local fx_scene_skull01 = self.items[cf[i].id]:get_child_by_name("wanfa/fx_scene_skull01");
					if fx_scene_fight then 
						fx_scene_fight:set_active(cf[i].fight_type == 1);
					end 
					if fx_scene_3v3 then 
						fx_scene_3v3:set_active(cf[i].fight_type == 2);
					end 
					if fx_scene_skull01 then 
						fx_scene_skull01:set_active(cf[i].fight_type == 3);
					end 
					local numguanqia = self.numbers[cf[i].challengeIndex];
					numguanqia:set_parent(self.items[cf[i].id]);
					numguanqia:set_local_position(0,0,-0.15);
					numguanqia:set_active(true);
				end 
				local fx = self.items[cf[i].id]:get_child_by_name("fx_scene_yuanzheng");
				local numguanqia = self.numbers[cf[i].challengeIndex];
				self.items[cf[i].id]:set_local_position(0,0,posIndex * 2.5 + 1);
				if posIndex >= g_dataCenter.trial.allInfo.cur_expedition_trial_level - 1 then 
					if fx ~= nil then 
						fx:set_local_position(0,0,0);
						numguanqia:set_active(true);
					end
				else
					if fx ~= nil then 
						fx:set_local_position(0,-100,0);
						numguanqia:set_active(false);
					end
				end 
				--local vx,vy,vz = self.cameraview:world_to_viewport_point(self.items[self.cf[i].id]:get_position());
				
				--self.items[self.cf[i].id]:set_local_rotation(0,(60 * (vx - 0.5)),0);
			elseif cf[i].type == 2 then 
				if self.items[cf[i].id] == nil then 
					if tonumber(cf[i].id) == #g_dataCenter.trial.allLevelConfig then 
						self.items[cf[i].id] = self.baseBoxs[cf[i].page+1]:clone();
						self.items[cf[i].id]:set_active(true);
					else 
						self.items[cf[i].id] = self.baseBoxs[cf[i].page]:clone();
						self.items[cf[i].id]:set_active(true);
					end 
				end 
				local boxClose = self.items[cf[i].id]:get_child_by_name("box_close");
				local boxOpen = self.items[cf[i].id]:get_child_by_name("box_open");
				local boxfx = self.items[cf[i].id]:get_child_by_name("fx");
				self.items[cf[i].id]:set_local_position(0,0,posIndex * 2.5 + 1);
				local isFinish = g_dataCenter.trial.allInfo.finish;
				if posIndex >= g_dataCenter.trial.allInfo.cur_expedition_trial_level - 1 then 
					if isFinish == false then 
						self.items[cf[i].id]:set_local_position(0,0,posIndex * 2.5 + 1);
						boxfx:set_active(false);
						boxClose:set_active(true);
						boxOpen:set_active(false);
					else 
						boxfx:set_active(false);
						boxClose:set_active(false);
						boxOpen:set_active(true);
					end
				else 
					self.items[cf[i].id]:set_local_position(0,-100,posIndex * 2.5 + 1);
				end 
			elseif cf[i].type == 3 then 
				if self.items[cf[i].id] == nil then 
					self.items[cf[i].id] = self.baseHebaos[cf[i].page]:clone();
					self.items[cf[i].id]:set_active(true);
				end 
				if posIndex >= g_dataCenter.trial.allInfo.cur_expedition_trial_level - 1 then 
					self.items[cf[i].id]:set_local_position(0,0,posIndex * 2.5 + 1);
				else
					self.items[cf[i].id]:set_local_position(0,-100,posIndex * 2.5 + 1);
				end 
			end
		end
	else
		--for i = 1,9 do
			--if self.cf[i] ~= nil then 
				--if self.cf[i].type == 1 then 
					--local vx,vy,vz = self.cameraview:world_to_viewport_point(self.items[self.cf[i].id]:get_position());
					--self.items[self.cf[i].id]:set_local_rotation(0,(60 * (vx - 0.5)),0);
				--end 
			--end 
		--end
	end
end 
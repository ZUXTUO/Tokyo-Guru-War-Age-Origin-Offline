ButtonClick = Class("ButtonClick")
-----------------------------------外部接口--------------------------------
--ButtonClick:new(data)
--data = 
--{
--	obj 带有uibutton的gameobj
--	isUpdatePress 是否需要按下后一直触发	
--}
--注意：new出来的，记得用delete释放

--设置回调函数
--fn 回调函数
--param 参数
--obj 如果传入成员函数，需要实例对象
function ButtonClick:SetPress(fn, param, obj)
	self.callback = fn;
	self.param = param;
	self.call_obj = obj;
end

function ButtonClick:SetPressDrag(fn, param, obj)
    self.callback_drag = fn;
	self.param_drag = param;
	self.call_obj_drag = obj;
end

------------------------------------内部接口---------------------------------------
function ButtonClick:ButtonClick(data)
	self.bindfunc = { };
	self.gameobj = data.obj;								--具体obj
	if self.gameobj == nil then
		app.log("obj==nil "..debug.traceback());
	end
    self.bWeakFocus = data.weakFocus                        --弹起的响应强度
	self.isUpdatePress = data.isUpdatePress or false;		--是否按下一直触发
	if not data.audioEnum then
		self.audioEnum = ENUM.EUiAudioType.MainBtn;         --按下音效枚举
	elseif data.audioEnum == 0 then
		self.audioEnum = nil;
	else
		self.audioEnum = data.audioEnum;
	end
	self.timerPress = nil;									--按下一直回调的timer
	self.openPress = nil;									--按下多久后开始响应一直回调
	self.call_name = nil;									--回调按下时的名字
	--回调函数以及对象以及参数
	self.callback = nil;
	self.param = nil;
	self.call_obj = nil;
	self.curPressPos = {x=0,y=0};

	self:registFunc();
end
function ButtonClick:Finalize()
	self:unregistFunc();
	if self.timerPress then
		timer.stop(self.timerPress);
		self.timerPress = nil;
	end
	--由于是按钮 所以回调函数的obj不需要释放
end
function ButtonClick:registFunc()
    self.bindfunc["OnPress"] = Utility.bind_callback(self, ButtonClick.OnPress);
    self.bindfunc["UpdatePress"] = Utility.bind_callback(self, ButtonClick.UpdatePress);
    
    self.gameobj:set_on_ngui_press(self.bindfunc["OnPress"]);
    if self.bWeakFocus then
        self.bindfunc["OnPressMove"] = Utility.bind_callback(self, ButtonClick.OnPressMove)
        self.gameobj:set_on_ngui_drag_move(self.bindfunc["OnPressMove"])
    end
end
function ButtonClick:unregistFunc()
    for k, v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end


function ButtonClick:OnPress(name, state, x, y, gameObj)
	self.curPressPos.x = x;
	self.curPressPos.y = y;
	if self.callback then
		if state then
			if self.audioEnum then
				AudioManager.PlayUiAudio(self.audioEnum)
			end
			self.call_name = name;
			if self.call_obj then
				Utility.CallFunc(self.callback,self.call_obj, x, y, state, self.param);
			else
				Utility.CallFunc(self.callback,x, y, state, self.param);
			end
			self.openPress = os.clock() + 0.1;
			self.timerPress = timer.create(self.bindfunc["UpdatePress"], 100, -1);
		else
			if self.timerPress then
				timer.stop(self.timerPress);
				self.timerPress = nil;
			end
            if self.bWeakFocus then
                if self.call_obj then
					Utility.CallFunc(self.callback,self.call_obj,x, y, state, self.param);
				else
					Utility.CallFunc(self.callback,x, y, state, self.param);	
				end
            else
    		    local obj = util.get_ngui_hovered_object();
    		    if obj then
    			    local hit_name = obj:get_name();
    			    if self.call_name == hit_name then
    				    if self.call_obj then
						    Utility.CallFunc(self.callback,self.call_obj, x, y, state, self.param);
					    else
						    Utility.CallFunc(self.callback,x, y, state, self.param);	
					    end
				    else
					    Utility.CallFunc(self.callback);
    			    end
    		    else
    			    Utility.CallFunc(self.callback);
    		    end
            end
		end
	end
end

function ButtonClick:UpdatePress()
	if self.callback and self.isUpdatePress then
		if os.clock() > self.openPress then
			if self.call_obj then
				Utility.CallFunc(self.callback,self.call_obj, self.curPressPos.x, self.curPressPos.y, true, self.param);
			else
				Utility.CallFunc(self.callback,self.curPressPos.x, self.curPressPos.y, true, self.param);	
			end
		end
	end
end

function ButtonClick:OnPressMove(name, x, y, gameObj)
	self.curPressPos.x = x;
	self.curPressPos.y = y;
    if self.callback_drag then
        if self.call_obj_drag then
			Utility.CallFunc(self.callback_drag,self.call_obj_drag, x, y, self.param_drag);
		else
			Utility.CallFunc(self.callback_drag,x, y, self.param_drag);	
		end
    end
end
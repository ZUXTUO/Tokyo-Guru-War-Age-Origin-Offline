if Tween ~= nil then 
	do return end
end 

Tween = {};
Tween.startValueList = {};
Tween.totalTimeList = {};
Tween.curTimeList = {};
Tween.objList = {};
Tween.pauseList = {};
Tween.propList = {};
Tween.transitionList = {};
Tween.startList = {};
Tween.updateList = {};
Tween.completeList = {};
Tween.deleteObjList = {};

Tween.ct = 0;
Transitions = {};


--------------缓动类型枚举---------------

Transitions.LINEAR = "linear";
Transitions.EASE_IN = "easeIn";
Transitions.EASE_OUT = "easeOut";
Transitions.EASE_IN_OUT = "easeInOut";
Transitions.EASE_OUT_IN = "easeOutIn";        
Transitions.EASE_IN_BACK = "easeInBack";
Transitions.EASE_OUT_BACK = "easeOutBack";
Transitions.EASE_IN_OUT_BACK = "easeInOutBack";
Transitions.EASE_OUT_IN_BACK = "easeOutInBack";
Transitions.EASE_IN_ELASTIC = "easeInElastic";
Transitions.EASE_OUT_ELASTIC = "easeOutElastic";
Transitions.EASE_IN_OUT_ELASTIC = "easeInOutElastic";
Transitions.EASE_OUT_IN_ELASTIC = "easeOutInElastic";  
Transitions.EASE_IN_BOUNCE = "easeInBounce";
Transitions.EASE_OUT_BOUNCE = "easeOutBounce";
Transitions.EASE_IN_OUT_BOUNCE = "easeInOutBounce";
Transitions.EASE_OUT_IN_BOUNCE = "easeOutInBounce";		
Transitions.EASE_IN_TO_OUT_ELASTIC = "easeInToOutElastic";

Tween.haveStartEnterFrame = false;

--------------缓动方法注册-----------------
function Transitions.registerDefaults()
	Transitions.sTransitions = {};	
	register(Transitions.LINEAR, Transitions.linear);
	register(Transitions.EASE_IN, Transitions.easeIn);
	register(Transitions.EASE_OUT, Transitions.easeOut);
	register(Transitions.EASE_IN_OUT, Transitions.easeInOut);
	register(Transitions.EASE_OUT_IN, Transitions.easeOutIn);
	register(Transitions.EASE_IN_BACK, Transitions.easeInBack);
	register(Transitions.EASE_OUT_BACK, Transitions.easeOutBack);
	register(Transitions.EASE_IN_OUT_BACK, Transitions.easeInOutBack);
	register(Transitions.EASE_OUT_IN_BACK, Transitions.easeOutInBack);
	register(Transitions.EASE_IN_ELASTIC, Transitions.easeInElastic);
	register(Transitions.EASE_OUT_ELASTIC, Transitions.easeOutElastic);
	register(Transitions.EASE_IN_OUT_ELASTIC, Transitions.easeInOutElastic);
	register(Transitions.EASE_OUT_IN_ELASTIC, Transitions.easeOutInElastic);
	register(Transitions.EASE_IN_BOUNCE, Transitions.easeInBounce);
	register(Transitions.EASE_OUT_BOUNCE, Transitions.easeOutBounce);
	register(Transitions.EASE_IN_OUT_BOUNCE, Transitions.easeInOutBounce);
	register(Transitions.EASE_OUT_IN_BOUNCE, Transitions.easeOutInBounce);
	register(Transitions.EASE_IN_TO_OUT_ELASTIC, Transitions.easeInToOutElastic);
end
-------------通過名稱獲取緩動類型------------------
function getTransition(name)
    if Transitions.sTransitions == nil then 	
		Transitions.registerDefaults();
	end
	return Transitions.sTransitions[name];
end
------------注冊緩動-----------------
function register(name, func)
	if Transitions.sTransitions == nil then     
		Transitions.registerDefaults();
	end
	Transitions.sTransitions[name] = func;
end	
-------------线性缓动-------------
function Transitions.linear(ratio)
    return ratio;
end
-------------立方加速缓动-------------
function Transitions.easeIn(ratio)
    return ratio * ratio * ratio;
end
-------------立方减速缓动-------------
function Transitions.easeOut(ratio)
    local invRatio = ratio - 1.0;
    return invRatio * invRatio * invRatio + 1;
end   

function Transitions.easeInOut(ratio)
    return Transitions.easeCombined(Transitions.easeIn, Transitions.easeOut, ratio);
end

function Transitions.easeOutIn(ratio)		
    return Transitions.easeCombined(Transitions.easeOut, Transitions.easeIn, ratio);
end

function Transitions.easeInBack(ratio)
    local s = 1.70158;
    return math.pow(ratio, 2) * ((s + 1.0)*ratio - s);
end

function Transitions.easeOutBack(ratio)		
    local invRatio = ratio - 1.0;            
    local s = 1.70158;
    return math.pow(invRatio, 2) * ((s + 1.0)*invRatio + s) + 1.0;
end

function Transitions.easeInOutBack(ratio)
    return Transitions.easeCombined(Transitions.easeInBack, Transitions.easeOutBack, ratio);
end
        
function Transitions.easeOutInBack(ratio)		
    return Transitions.easeCombined(Transitions.easeOutBack, Transitions.easeInBack, ratio);
end      

function Transitions.easeInToOutElastic(ratio)
	return Transitions.easeCombined(Transitions.easeIn, Transitions.easeOutElastic, ratio);
end

function Transitions.easeInElastic(ratio)
    if ratio == 0 or ratio == 1 then 
		do return ratio; end
    else	
        local p = 0.3;
        local s = p/4.0;
        local invRatio = ratio - 1;						
        do return -1.0 * math.pow(2.0, 10.0*invRatio) * math.sin((invRatio-s)*(2.0*math.pi)/p); end
    end 
end

function Transitions.easeOutElastic(ratio)
    if ratio == 0 or ratio == 1 then 
		do return ratio; end
    else	
        local p = 0.3;
        local s = p/4.0;                
        do return math.pow(2.0, -10.0*ratio) * math.sin((ratio-s)*(2.0*math.pi)/p) + 1; end
    end  
end
        
function Transitions.easeInOutElastic(ratio)		
    return Transitions.easeCombined(Transitions.easeInElastic, Transitions.easeOutElastic, ratio);
end  
        
function Transitions.easeOutInElastic(ratio)		
    return Transitions.easeCombined(Transitions.easeOutElastic, Transitions.easeInElastic, ratio);
end
        
function Transitions.easeInBounce(ratio)		
    return 1.0 - Transitions.easeOutBounce(1.0 - ratio);
end
        
function Transitions.easeOutBounce(ratio)		
    local s = 7.5625;
    local p = 2.75;
    local l;
    if ratio < (1.0/p) then
        l = s * math.pow(ratio, 2);	
    else				
        if ratio < (2.0/p) then			
            ratio = ratio - 1.5/p;
            l = s * math.pow(ratio, 2) + 0.75;
        else					
            if ratio < 2.5/p then				
                ratio = ratio - 2.25/p;
                l = s * math.pow(ratio, 2) + 0.9375;						
            else						
                ratio = ratio - 2.625/p;
                l =  s * math.pow(ratio, 2) + 0.984375;
            end
        end
    end
    return l;
end	
        
function Transitions.easeInOutBounce(ratio)		
    return Transitions.easeCombined(Transitions.easeInBounce, Transitions.easeOutBounce, ratio);
end  
        
function Transitions.easeOutInBounce(ratio)		
    return Transitions.easeCombined(Transitions.easeOutBounce, Transitions.easeInBounce, ratio);
end

function Transitions.easeCombined(startFunc, endFunc, ratio)
    if ratio < 0.5 then 
		do return 0.5 * startFunc(ratio*2.0); end
    else
		do return 0.5 * endFunc((ratio-0.5)*2.0) + 0.5; end
	end
end	

--緩動的幀刷新
function TweenUpdate()
	local time = app.get_real_time();
	local dt = time - Tween.ct;
	Tween.ct = time;
	local haveTweenObj = false	
	
	for tid,disObj in pairs(Tween.objList) do			
		if Tween.deleteObjList[tid] == nil and Tween.pauseList[tid] == nil then
			haveTweenObj = true;
			--app.log("TweenUpdate pairs");
			--app.log("TweenUpdate tid = "..tid);		
			if Tween.curTimeList[tid] == 0 then
				if Tween.startList[tid] ~= nil then
					if type(Tween.startList[tid]) == "function" then
						Tween.startList[tid]();
						Tween.startList[tid] = nil;
					end
				end
			end		
			Tween.curTimeList[tid] = Tween.curTimeList[tid] + dt;
			if Tween.curTimeList[tid] < 0 then
				--Tween.curTimeList[tid] = Tween.curTimeList[tid] + dt;
			elseif Tween.totalTimeList[tid] - Tween.curTimeList[tid] > 0 then	
				if Tween.startList[tid] ~= nil then
					if type(Tween.startList[tid]) == "function" then
						Tween.startList[tid]();
						Tween.startList[tid] = nil;
					end
				end		
				--Tween.curTimeList[tid] = Tween.curTimeList[tid] + dt;
				local ratio = Tween.curTimeList[tid]/Tween.totalTimeList[tid];			
				local transFunc = Tween.transitionList[tid];
				local progress;
				--app.log("transition = "..trans);
				if transFunc ~= nil then
					--local transFunc = Tween.transFuncList[tid];
					progress = transFunc(ratio);				
					local start = Tween.startValueList[tid];						
					for key,endVar in pairs(Tween.propList[tid]) do
						if key == "local_position" then
							local curX = Transitions.execute(start[key][1],endVar[1],progress);
							local curY = Transitions.execute(start[key][2],endVar[2],progress);
							local curZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_position(curX,curY,curZ);
						elseif key == "position" then 
							local curX = Transitions.execute(start[key][1],endVar[1],progress);
							local curY = Transitions.execute(start[key][2],endVar[2],progress);
							local curZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_position(curX,curY,curZ);
						elseif key == "local_scale" then
							local curScaleX = Transitions.execute(start[key][1],endVar[1],progress);
							local curScaleY = Transitions.execute(start[key][2],endVar[2],progress);
							local curScaleZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_scale(curScaleX,curScaleY,curScaleZ);
						elseif key == "size" then
							local width = Transitions.execute(start[key][1],endVar[1],progress);
							local height = Transitions.execute(start[key][2],endVar[2],progress);
							disObj:set_size(width,height);
						elseif key == "color" then
							local r = Transitions.execute(start[key][1],endVar[1],progress);
							local g = Transitions.execute(start[key][2],endVar[2],progress);
							local b = Transitions.execute(start[key][3],endVar[3],progress);
							local a = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_color(r,g,b,a);
						elseif key == "rotation" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_rotation(rx,ry,rz);
						elseif key == "rotationq" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							local rw = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_rotationq(rx,ry,rz,rw);
						elseif key == "local_rotation" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_rotation(rx,ry,rz);
						elseif key == "local_rotationq" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							local rw = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_local_rotationq(rx,ry,rz,rw);
						elseif type(disObj[key]) == "number" then
							disObj[key] = Transitions.execute(start[key],endVar,progress);
						end
					end
				end
                if Tween.updateList[tid] ~= nil then	
                    local func = Utility.GetRealFunc(Tween.updateList[tid])
				    if func ~= nil then
                        func(progress)
				    end 
				end

			elseif Tween.totalTimeList[tid] - Tween.curTimeList[tid] <= 0 then
				Tween.deleteObjList[tid] = tid;			
				local ratio = 1;			
				local transFunc = Tween.transitionList[tid];
				local progress;
				if transFunc ~= nil then
					progress = transFunc(ratio);				
					local start = Tween.startValueList[tid];						
					for key,endVar in pairs(Tween.propList[tid]) do
						if key == "local_position" then
							local curX = Transitions.execute(start[key][1],endVar[1],progress);
							local curY = Transitions.execute(start[key][2],endVar[2],progress);
							local curZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_position(curX,curY,curZ);
						elseif key == "position" then 
							local curX = Transitions.execute(start[key][1],endVar[1],progress);
							local curY = Transitions.execute(start[key][2],endVar[2],progress);
							local curZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_position(curX,curY,curZ);
						elseif key == "local_scale" then
							local curScaleX = Transitions.execute(start[key][1],endVar[1],progress);
							local curScaleY = Transitions.execute(start[key][2],endVar[2],progress);
							local curScaleZ = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_scale(curScaleX,curScaleY,curScaleZ);
						elseif key == "size" then
							local width = Transitions.execute(start[key][1],endVar[1],progress);
							local height = Transitions.execute(start[key][2],endVar[2],progress);
							disObj:set_size(width,height);
						elseif key == "color" then
							local r = Transitions.execute(start[key][1],endVar[1],progress);
							local g = Transitions.execute(start[key][2],endVar[2],progress);
							local b = Transitions.execute(start[key][3],endVar[3],progress);
							local a = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_color(r,g,b,a);
						elseif key == "rotation" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_rotation(rx,ry,rz);
						elseif key == "rotationq" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							local rw = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_rotationq(rx,ry,rz,rw);
						elseif key == "local_rotation" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							disObj:set_local_rotation(rx,ry,rz);
						elseif key == "local_rotationq" then
							local rx = Transitions.execute(start[key][1],endVar[1],progress);
							local ry = Transitions.execute(start[key][2],endVar[2],progress);
							local rz = Transitions.execute(start[key][3],endVar[3],progress);
							local rw = Transitions.execute(start[key][4],endVar[4],progress);
							disObj:set_local_rotationq(rx,ry,rz,rw);
						elseif type(disObj[key]) == "number" then
							disObj[key] = Transitions.execute(start[key],endVar,progress);
						end
					end
				end
				if Tween.updateList[tid] ~= nil then	
                    local func = Utility.GetRealFunc(Tween.updateList[tid])
				    if func ~= nil then
                        func(progress)
				    end 
				end
				if Tween.completeList[tid] ~= nil then		
					if type(Tween.completeList[tid]) == "function" then 
						Tween.completeList[tid](progress);
					end
				end
			end
		end
	end
	for k,v in pairs(Tween.deleteObjList) do
		Tween.objList[v] = nil;
		Tween.totalTimeList[v] = nil;
		Tween.propList[v] = nil;	
		Tween.startList[v] = nil;			
		Tween.updateList[v] = nil;	
		Tween.completeList[v] = nil;
		Tween.pauseList[v] = nil;
	end
	Tween.deleteObjList = {};
	if haveTweenObj == false then
		--app.log("remove TweenUpdate");
		Root.DelUpdate(TweenUpdate);
		Tween.haveStartEnterFrame = false;
	end
end

function Transitions.execute(startVar,endVar,progress)
	return startVar + progress * (endVar - startVar);
end

	--[[p = {}
		
		p.expCount = 0
		p.view = smgr:load_lib(testpath);
		p.txtExp = sbase.find(p.view,"expText")
		
		function p:get_pid()
			return p.txtExp:get_pid();
		end
		
		function p:tweenToExp(exp)
			
			self.onTweenToExp = function()
				self.txtExp:set_text(tostring(self.expCount));
			end
			
			Tween.addTween(self,1,{expCount = exp},Transitions.EASE_OUT,0,nil,self.onTweenToExp,nil);
		end
	]]--
function Tween.addTween(obj,time,prop,transition,delay,startF,updateF,completeF)	
	if obj == nil then
		do return end;
	end
	local tid = "t"..tostring(obj:get_pid());
	if Tween.deleteObjList[tid] ~= nil then
		Tween.deleteObjList[tid] = nil;
	end
	--Tween.removeTween(obj);
	--app.log("addTween,tid = "..tid);
	Tween.objList[tid] = obj;	
	
	Tween.totalTimeList[tid] = math.max(time,1/60);	
	Tween.propList[tid] = prop;
	local start = {};
	for k,v in pairs(prop) do
		if k == "local_position" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3] = obj:get_local_position();
		elseif k == "position" then 
			start[k] = {};
			start[k][1],start[k][2],start[k][3] = obj:get_position();
		elseif k == "local_scale" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3] = obj:get_local_scale();
		elseif k == "size" then
			start[k] = {};
			start[k][1],start[k][2] = obj:get_size();
		elseif k == "color" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3],start[k][4] = obj:get_color();
		elseif k == "rotation" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3] = obj:get_rotation();
		elseif k == "rotationq" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3],start[k][4] = obj:get_rotationq();
		elseif k == "local_rotation" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3] = obj:get_local_rotation();
		elseif k == "local_rotationq" then
			start[k] = {};
			start[k][1],start[k][2],start[k][3],start[k][4] = obj:get_local_rotationq();
		elseif type(obj[k]) == "number" then
			start[k] = obj[k];
		else
			v = nil;
		end
	end
	Tween.startValueList[tid] = start;
	if transition ~= nil then
		Tween.transitionList[tid] = getTransition(transition);
	else
		Tween.transitionList[tid] = getTransition(Transitions.LINEAR);
	end
	if delay ~= nil then
		Tween.curTimeList[tid] = -delay;
	else
		Tween.curTimeList[tid] = 0;
	end
	Tween.startList[tid] = startF;
	Tween.updateList[tid] = updateF;
	Tween.completeList[tid] = completeF;
	if Tween.haveStartEnterFrame == false then	
		Root.AddUpdate(TweenUpdate);
		Tween.ct = app.get_real_time();
		Tween.haveStartEnterFrame = true;
	end
end
--暫停緩動方法
function Tween.pause(obj)
	local tid = "t"..tostring(obj:get_pid());
	if Tween.objList[tid] ~= nil then 
		Tween.pauseList[tid] = 1;
	end 
end
--繼續緩動方法
function Tween.continue(obj)
	local tid = "t"..tostring(obj:get_pid());
	if Tween.objList[tid] ~= nil then 
		if Tween.pauseList[tid] ~= nil then 
			Tween.pauseList[tid] = nil;
			if Tween.haveStartEnterFrame == false then	
				--app.log("startTween");
				Root.AddUpdate(TweenUpdate);
				Tween.ct = app.get_real_time();
				Tween.haveStartEnterFrame = true;
			end
		end 
	end 
end
--檢查是否正在緩動
function Tween.isTweening(obj)
	local tid = "t"..tostring(obj:get_pid());
	if Tween.objList[tid] ~= nil then 
		return true;
	else
		return false;
	end 
end

--獲取緩動剩余時間
function Tween.getRemainTime(obj)
	local tid = "t"..tostring(obj:get_pid());
	if Tween.objList[tid] ~= nil then 
		return Tween.totalTimeList[tid] - Tween.curTimeList[tid];
	else
	    return 0;
	end
end

--移除緩動
function Tween.removeTween(obj)
	if obj == nil then 
		do return end;
	end 
	local tid = "t"..tostring(obj:get_pid());
	if Tween.objList[tid] ~= nil then	
		Tween.deleteObjList[tid] = tid;
	end
end

--清除全部緩動
function Tween.perge()
	Tween.startValueList = {};
	Tween.totalTimeList = {};
	Tween.curTimeList = {};
	Tween.objList = {};
	Tween.pauseList = {};
	Tween.propList = {};
	Tween.transitionList = {};
	Tween.startList = {};
	Tween.updateList = {};
	Tween.completeList = {};
	Tween.deleteObjList = {};
end	

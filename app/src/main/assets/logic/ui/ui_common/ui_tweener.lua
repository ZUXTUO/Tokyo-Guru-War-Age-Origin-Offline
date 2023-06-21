UITween = {
	EasingType =
	{
		easeLinear,
		easeSwing,
		easeInQuad,
		easeOutQuad,
		easeInOutQuad,
		easeInCubic,
		easeOutCubic,
		easeInOutCubic,
		easeInQuart,
		easeOutQuart,
		easeInOutQuart,
		easeInQuint,
		easeOutQuint,
		easeInOutQuint,
		easeInSine,
		easeOutSine,
		easeInOutSine,
		easeInExpo,
		easeOutExpo,
		easeInOutExpo,
		easeInCirc,
		easeOutCirc,
		easeInOutCirc,
		easeInElastic,
		easeOutElastic,
		easeInOutElastic,
		easeInBack,
		easeOutBack,
		easeInOutBack,
		easeInBounce,
		easeOutBounce,
		easeInOutBounce,
	}
}

function UITween.Ease(EasingType, t, b, c, d)
	local ret = nil
	local isComp = false
	--增加
	if b <= c then
		ret = c * t / d + b;
		if ret >= c then
			ret = c
			isComp = true
		end
	--减少
	else
		ret = b * (1 - t / d);
		if ret <= c then
			ret = c
			isComp = true
		end
	end
	return ret, isComp
end

TweenProgress = Class("TweenProgress")

function TweenProgress.Begin(progress_bar, data)
	data.progress_bar = progress_bar
	return TweenProgress:new(data)
end

function TweenProgress:Init(data)
	self:InitData(data)
end

function TweenProgress:InitData(data)
	self.progress_bar = data.progress_bar;
	self.duration = data.duration or 1;
	-- self.start_delay = data.delay or 0;
	self.begin = data.begin or 0;
	self.eend = data.eend or 1
	self.e_type = data.e_type or UITween.EasingType.easeLinear

	self.up_call = data.up_call or nil
	self.com_call = data.com_call or nil

	self._time = 0;
	self._started = false;
	self._is_running = false
end

function TweenProgress:IsRunning()
	return self._is_running
end

function TweenProgress:Update(deltatime)
	if self._time < self.duration then
		self._is_running = true
		self._time = self._time + deltatime
		-- app.log(string.format("self._time=%s,self.beigin=%s,self.eend=%s,self.duration=%s", tostring(self._time), tostring(self.begin), tostring(self.eend), tostring(self.duration)))
		local value, isComp = UITween.Ease(self.e_type, self._time, self.begin, self.eend, self.duration)
		if self.progress_bar and type(self.progress_bar) == "userdata" then
			if isComp then
				self._time = self.duration
			end
			self.progress_bar:set_value(value)
			--app.log("xx TweenProgress:Update up" .. tostring(value) .. " time=" .. tostring(app.get_time()))
		end
		if self.up_call then
			self.up_call(value)
		end
	else
		-- app.log("xx TweenProgress:Update com" .. tostring(self.duration))
		self._time = self.duration
		if self.com_call and type(self.com_call) == "function" then
			self.com_call()
		end
		self.progress_bar = nil
		self._is_running = false
		-- 删除Update
		Root.DelUpdate(self.Update)
	end
end

function TweenProgress:Play(data)
	--app.log("TweenProgress:Play:"..table.tostring(data))
	if self._is_running then
		return
	else
		self:InitData(data)
		Root.DelUpdate(self.Update)
		Root.AddUpdate(self.Update, self)
	end
end

function TweenProgress:Stop()
	Root.DelUpdate(self.Update)
end

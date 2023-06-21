-- 启动一个定时器(暂定1000ms)，检查ui红点提示状态

ui_timer_check = {
	timerId = nil
}

-- 使用this来简化代码
local this = ui_timer_check

function ui_timer_check.start()
	if not this.timerId then
		this.timerId = timer.create("ui_timer_check.process", 1000, -1)
	end
end


function ui_timer_check.pause()
	if this.timerId then
		timer.pause(this.timerId)
	end
end


function ui_timer_check.resume()
	if this.timerId then
		timer.resume(this.timerId)
	end
end


function ui_timer_check.stop()
	if this.timerId then
		timer.stop(this.timerId)
		this.timerId = nil
	end
end


function ui_timer_check.process()
	-- 已由guide tip完成
end

-- this.start(); -- 启动

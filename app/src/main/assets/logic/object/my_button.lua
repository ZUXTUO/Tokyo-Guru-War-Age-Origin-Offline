--自己的button，将ngui的button封装一层
MyButton = Class("MyButton");
MyButton.temp_func = {} --临时创建g表函数，暂不释放（数量有限）

function MyButton.find_button(obj, path)
	if obj == nil then
		app.log("obj==nil "..debug.traceback());
		return;
	end
	local btn = old_ngui_button(obj, path);
	if btn == nil then
--		app.log_warning("path=="..path.."的按钮找不到"..debug.traceback())
		return nil
	end
	mybtn = MyButton:new(btn);
	return mybtn;
end

function MyButton:set_on_click(func, before_click)
	if not func then
		app.log("MyButton:set_on_click  func为nil"..debug.traceback())
		return
	end

	-- 统一处理点击音效
	before_click = before_click or "MyButton.MainBtn"
	local real_func = Utility.GetRealFunc(func)
	local replace_func = function (t)
		Utility.CallFunc(before_click)
		if real_func then real_func(t) end
	end

	-- 替换原有的bind函数，非bind重新封装一个回调函数
	if not Utility.replace_bind_callback(tostring(func), replace_func) then
		local new_func = "_my_button_"..string.gsub(tostring(func).."_"..before_click, "%.", "_")
		_G[new_func] = replace_func

		MyButton.temp_func[new_func] = new_func
		
		func = new_func
	end

	self.btn:set_on_click(func);
end

function MyButton.NoneAudio()

end

function MyButton.MainBtn(t)
	if AudioManager ~= nil then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);
	end
end

function MyButton.BackBtn(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.BackBtn);
end

function MyButton.CutIn(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.CutIn);
end

function MyButton.CutOut(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.CutOut);
end

function MyButton.DlgOut(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.DlgOut);
end

function MyButton.ChangeRole(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ChangeRole);
end

function MyButton.Flag(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag);
end

function MyButton.SkillComplete(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.SkillComplete);
end

function MyButton.BeginFight(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.BeginFight);
end

function MyButton.GetReward(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.GetReward);
end

function MyButton.GetHero(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.GetHero);
end

function MyButton.VicStar(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.VicStar);
end

function MyButton.ComReward(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward);
end

--打雷声音
function MyButton.Thunder(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.Thunder);
end

--装备升级
function MyButton.LvUpEquip(t)
	--AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpEquip);
	AudioManager.Play3dAudio(ENUM.EUiAudioType.LvUpEquip, AudioManager.GetUiAudioSourceNode(), true)
end

--扭蛋得到东西
function MyButton.RewardGacha(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.RewardGacha);
end

--聊天界面通用声音
function MyButton.ChatNormal(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ChatNormal);
end

--主界面下面一排按钮
function MyButton.MainUiDown(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainUiDown);
end

--主界面右边一排按钮
function MyButton.MainUiRight(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainUiRight);
end

--类似战队界面按钮音效
function MyButton.DragMenu(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.DragMenu);
end

--阵容调整中的角色上阵提示音效
function MyButton.InsertTeam(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.InsertTeam);
end

--章节界面中的章节选择和关卡选择音效
function MyButton.Chapter(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.Chapter);
end

--主界面金木研跳下
function MyButton.ZjmJmy(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ZjmJmy);
end

--主界面安久奈白跳下
function MyButton.ZjmAjnb1(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ZjmAjnb1);
end

--主界面安久奈白跳走
function MyButton.ZjmAjnb2(t)
	AudioManager.PlayUiAudio(ENUM.EUiAudioType.ZjmAjnb2);
end

function MyButton:get_pid(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_pid(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_active(p1,p2,p3,p4,p5,p6,p7,p8)
	if p1 == nil then return end
	return self.btn:set_active(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_name(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_name(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:get_name(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_name(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_position(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_position(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:get_position(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_position(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:get_size(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_size(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:get_game_object(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_game_object(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:get_parent(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:get_parent(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_parent(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_parent(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:clone(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:clone(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:destroy_object(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:destroy_object(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_enable(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_enable(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_event_value(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_event_value(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:reset_on_click(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:reset_on_click(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_ngui_click(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_ngui_click(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_ngui_press(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_ngui_press(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_ngui_drag_start(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_ngui_drag_start(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_ngui_drag_move(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_ngui_drag_move(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_ngui_drag_end(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_ngui_drag_end(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:stop_event_propagation(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:stop_event_propagation(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:reset_event_propagation(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:reset_event_propagation(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_dragdrop_start(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_dragdrop_start(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_on_dragdrop_release(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_on_dragdrop_release(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_is_dragdrop_clone(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_is_dragdrop_clone(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_dragdrop_restriction(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_dragdrop_restriction(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_is_hide_clone(p1,p2,p3,p4,p5,p6,p7,p8)
	return self.btn:set_is_hide_clone(p1,p2,p3,p4,p5,p6,p7,p8);
end

function MyButton:set_sleep_time(time)
	self.sleep_time = time;
end

function MyButton:set_sprite_names(normal,hover,pressed,disabled)
	self.btn:set_sprite_names(normal or "",hover or "",pressed or "",disabled or "")
end
function MyButton:set_enable_tween_color(enableTweenColor)
	self.btn:set_enable_tween_color(enableTweenColor);
end 
--------------------内部接口------------------------------
function MyButton:Init(btn)
	self:initData(btn);
end

function MyButton:initData(btn)
	self.btn = btn;
end

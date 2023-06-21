-- require 'Class'
-- require 'utility'

CheckBox = Class('CheckBox');

CheckBox.Estate = {
	up = 1,
	down = 2,
}
function CheckBox:initData(data)
	self.bindfunc = {};
	self.button = {};
	self.sprite = {};
	self.upName = {};
	self.downName = {};
	self.state = {};
	self.onClickDown = {};
	self.onClickUp = {};
	for k,v in ipairs(data.button) do
		self.button[k] = data.button[k];
		self.sprite[k] = data.sprite[k];
		self.upName[k] = data.upName[k];
		self.downName[k] = data.downName[k];
		self.state[k] = CheckBox.Estate.up;
	end
end

function CheckBox:Init(data)
    self:initData(data)
    self:registFunc();
    self:initUI();
end

function CheckBox:registFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, CheckBox.on_click)
end

function CheckBox:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function CheckBox:initUI()
	for k,v in ipairs(self.button) do
		v:set_event_value("",k);
		v:set_on_click(self.bindfunc["on_click"]);
	end
end

function CheckBox:on_click(t)
	if(#self.button == 1)then
		if(self.state[t.float_value] == CheckBox.Estate.up)then
			self.state[t.float_value] = CheckBox.Estate.down;
			self.sprite[t.float_value]:set_sprite_name(self.downName[t.float_value]);
			if(self.onClickDown[t.float_value] ~= nil)then
				_G[self.onClickDown[t.float_value]](t);
			end
		else
			self.state[t.float_value] = CheckBox.Estate.up;
			self.sprite[t.float_value]:set_sprite_name(self.upName[t.float_value]);
			if(self.onClickUp[t.float_value] ~= nil)then
				_G[self.onClickUp[t.float_value]](t);
			end
		end
	elseif(#self.button > 1)then
		if(self.state[t.float_value] == CheckBox.Estate.up)then
			self.state[t.float_value] = CheckBox.Estate.down;
			self.sprite[t.float_value]:set_sprite_name(self.downName[t.float_value]);
			for k,v in ipairs(self.state) do
				if(k ~= t.float_value)then
					self.state[k] = CheckBox.Estate.up;
					self.sprite[k]:set_sprite_name(self.upName[k]);
				end
			end
			--外部设置按下回调函数
			if(self.onClickDown[t.float_value] ~= nil)then
				_G[self.onClickDown[t.float_value]](t);
			end
		end
	end
end

function CheckBox:SetState(state,numlist)
	if(state == CheckBox.Estate.up)then
		for k,v in ipairs(numlist) do
			self.state[v] = CheckBox.Estate.up;
			self.sprite[v]:set_sprite_name(self.upName[v]);
		end
	elseif(state == CheckBox.Estate.down)then
		for k,v in ipairs(numlist) do
			self.state[v] = CheckBox.Estate.down;
			self.sprite[v]:set_sprite_name(self.downName[v]);
		end
	end
end

function CheckBox:on_click_down(func,number)
	self.onClickDown[number] = func;
end

function CheckBox:on_click_up(func,number)
	self.onClickUp[number] = func;
end

function CheckBox:GetState(num)
	return self.state[num];
end

return CheckBox;


















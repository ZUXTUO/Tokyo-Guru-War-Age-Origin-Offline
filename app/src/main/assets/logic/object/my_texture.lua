--
MyTexture = Class("MyTexture");
MyTexture.temp = {};
setmetatable(MyTexture.temp, {__mode = "k"});

function MyTexture.find_texture(obj, path)
	if obj == nil then
		app.log_warning("find texture:obj 为空."..debug.traceback())
		return nil
	end
	local tex = old_ngui_texture(obj, path);
	if tex == nil then
		app.log_warning("path=="..path.."的texture找不到"..debug.traceback())
		return nil
	end
	local myTex = MyTexture:new(tex);
	MyTexture.temp[myTex] = {last_path=ResourceLoader.last_loaded_path,name=obj:get_name(),find_path=path};
	return myTex;
end

function MyTexture:get_pid()
	if self.spid == nil then 
		self.spid = self.obj:get_pid();
	end
	return self.spid;
end

function MyTexture:set_active(is_active)
	if self.curActive ~= is_active or self.fact ~= Root.update_seq then 
		self.fact = Root.update_seq;
		self.curActive = is_active;
		return self.obj:set_active(is_active);
	else 
		return true;
	end
end

function MyTexture:set_name(name)
	if self.fname ~= Root.update_seq then 
		self.fname = Root.update_seq;
		self.curName = self.obj:get_name();
	end
	if self.curName ~= name then 
		self.curName = name;
		return self.obj:set_name(name);
	else 
		return true;
	end
end

function MyTexture:get_name()
	if self.fname ~= Root.update_seq then 
		self.fname = Root.update_seq;
		self.curName = self.obj:get_name();
	end
	return self.curName;
end

function MyTexture:set_position(x,y,z)
	if self.fpos ~= Root.update_seq then 
		self.fpos = Root.update_seq;
		self.curx,self.cury,self.curz = self.obj:get_position();
	end
	if self.curx ~= x or self.cury ~= y or self.curz ~= z then 
		self.curx = x;
		self.cury = y;
		self.curz = z;
		return self.obj:set_position(x,y,z);
	else 
		return true;
	end
end

function MyTexture:get_position()
	if self.fpos ~= Root.update_seq then 
		self.fpos = Root.update_seq;
		self.curx,self.cury,self.curz = self.obj:get_position();
	end
	return self.curx,self.cury,self.curz;
end

function MyTexture:get_size()
	if self.fsize ~= Root.update_seq then 
		self.fsize = Root.update_seq;
		self.curw,self.curh = self.obj:get_size();
	end
	return self.curw,self.curh;
end

function MyTexture:get_game_object()
	if self.gameobject == nil then 
		self.gameobject = self.obj:get_game_object();
	end 
	return self.gameobject;
end

function MyTexture:get_parent()
	return self.obj:get_parent();
end

function MyTexture:set_enable(bool)
	if self.fenable ~= Root.update_seq then 
		self.fenable = Root.update_seq;
		self.curEnable = self.obj:get_enable();
	end
	if self.curEnable ~= self.senb.enb then 
		self.curEnable = bool;
		self.obj:set_enable(bool);
	end
end

function MyTexture:get_enable()
	if self.fenable ~= Root.update_seq then 
		self.fenable = Root.update_seq;
		self.curEnable = self.obj:get_enable();
	end
	return self.curEnable;
end

function MyTexture:set_parent(parent)
	return self.obj:set_parent(parent);
end

function MyTexture:clone()
	local tex = self.obj:clone();
	local myTex = MyTexture:new(tex);
	MyTexture.temp[myTex] = {last_path=ResourceLoader.last_loaded_path,name=tex:get_name(),find_path=path};
	return myTex;
end

function MyTexture:destroy_object()
	self.gameobject = nil;
	return self.obj:destroy_object();
end

function MyTexture:set_texture(file_path,keepSize)
	self.keepSize = keepSize;
	if type(file_path) == "string" then
		self.filepath = file_path;
		ResourceLoader.LoadTexture(file_path, Utility.create_obj_callback(self,self.on_load,4));
	else
        if file_path then
            if type(file_path) ~= "string" then
                app.log(debug.traceback())
            end
		    return self.obj:set_texture(file_path);
        end
	end
end

function MyTexture:set_callback(callback, para)    
    self.callback = callback
    self.callback_para = para
end

function MyTexture:get_texture()
	return self.obj:get_texture();
end

function MyTexture:clear_texture()
	return self.obj:clear_texture();
end

function MyTexture:set_color(r,g,b,a)
	return self.obj:set_color(r,g,b,a);
end

function MyTexture:get_color()
	return self.obj:get_color();
end

function MyTexture:get_fill_amout()
	return self.obj:get_fill_amout();
end

function MyTexture:set_fill_amout(amout)
	return self.obj:set_fill_amout(amout);
end

function MyTexture:set_fill_direction(direction)
	return self.obj:set_fill_direction(direction);
end

function MyTexture:set_material(material)
	return self.obj:set_material(material);
end

function MyTexture:get_material()
	return self.obj:get_material();
end

function MyTexture:set_shader(shader)
	return self.obj:set_shader(shader);
end

function MyTexture:get_shader()
	return self.obj:get_shader();
end

function MyTexture:Destroy()
	MyTexture.temp[self] = nil;
	-- Utility.unbind_callback(self, self.on_load);
	self.obj = nil;
	self.gameobject = nil;
	self.texture = nil;
	self.isDestroy = true; 
end
----------------------------
function MyTexture:Init(data)
	self.obj = data;
	self.isDestroy = false; 
	-- self.loadCallback = Utility.bind_callback(self,self.on_load);
end

function MyTexture:on_load(pid, filepath, texture_obj, error_info)
	if not self.isDestroy and self.obj and texture_obj then

		-- TODO: kevin res load test.
		-- self.obj:set_texture(texture_obj);
		-- app.log("xyxyxyxyx:"..filepath..".."..table.tostring(texture_obj))
		if self.keepSize == true then 
			self.obj:set_fill_amout(1);
			local w,h = texture_obj.obj:get_size();
			local wg = ngui.find_widget(self.obj:get_game_object(),self.obj:get_name());
			wg:set_size(w,h);
		end 
		if self.filepath == filepath then
			MyTexture.temp[self].filePath = filepath
			self.texture = texture_obj;
			self.obj:set_texture(texture_obj:GetObject());
		end
        if self.callback then
            Utility.CallFunc(self.callback, self.callback_para)
        end
	end
end

function MyTexture:SetTexture(obj)
	self.obj:set_texture(obj)
end

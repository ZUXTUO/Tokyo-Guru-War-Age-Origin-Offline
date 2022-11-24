AssetGameObject = {};
Saved = {}
setmetatable(Saved, {__mode='k'})
setmetatable(Saved, {__mode='v'})
function AssetGameObject.replace_functions(asset_obj)
	do return end;
	local m_index = getmetatable(asset_obj)["__index"];
	if m_index.is_replace_over ~= true then 
		for k,v in pairs(MyAssetGameObject) do 
			m_index["old_"..k] = m_index[k];
			m_index[k] = v;
		end
		m_index.is_replace_over = true;
	end 
end 

MyAssetGameObject = {};

function MyAssetGameObject:is_nil()
	Saved[self] = Saved[self] or {};
	if Saved[self].fnil ~= Root.update_seq then
		Saved[self].fnil = Root.update_seq;
		Saved[self].isnil = self:old_is_nil();
	end
	return Saved[self].isnil;
end

function MyAssetGameObject:destroy_object()
	if Saved[self] ~= nil then 
		Saved[self].w2lmat = nil;
		Saved[self].parent = nil;
		Saved[self].shader = nil;
		Saved[self] = nil;
	end 
	self:old_destroy_object();
end

function MyAssetGameObject:get_pid()
	Saved[self] = Saved[self] or {};
	if Saved[self].pid == nil then 
		Saved[self].pid = self:old_get_pid();
	end
	return Saved[self].pid;
end
function MyAssetGameObject:get_instance_id()
	Saved[self] = Saved[self] or {};
	if Saved[self].instanceid == nil then 
		Saved[self].instanceid = self:old_get_instance_id();
	end
	return Saved[self].instanceid;
end

function MyAssetGameObject:set_name(name)
	Saved[self] = Saved[self] or {};
	if Saved[self].fname ~= Root.update_seq then 
		Saved[self].fname = Root.update_seq;
		Saved[self].name = self:old_get_name();
	end
	if Saved[self].name ~= name then 
		Saved[self].name = name;
		self:old_set_name(name);
	end
end
function MyAssetGameObject:get_name()
	Saved[self] = Saved[self] or {};
	if Saved[self].fname ~= Root.update_seq then 
		Saved[self].fname = Root.update_seq;
		Saved[self].name = self:old_get_name();
	end
	return Saved[self].name;
end
function MyAssetGameObject:set_tag(tag)
	Saved[self] = Saved[self] or {};
	if Saved[self].ftag ~= Root.update_seq then 
		Saved[self].ftag = Root.update_seq;
		Saved[self].tag = self:old_get_tag();
	end
	if Saved[self].tag ~= tag then 
		Saved[self].tag = tag;
		self:old_set_tag(tag);
	end
end
function MyAssetGameObject:get_tag()
	Saved[self] = Saved[self] or {};
	if Saved[self].ftag ~= Root.update_seq then 
		Saved[self].ftag = Root.update_seq;
		Saved[self].tag = self:old_get_tag();
	end
	return Saved[self].tag;
end
function MyAssetGameObject:set_active(active)
	Saved[self] = Saved[self] or {};
	if Saved[self].factive ~= Root.update_seq then 
		Saved[self].factive = Root.update_seq;
		Saved[self].active = self:old_get_active();
	end
	if Saved[self].active ~= active then 
		Saved[self].active = active;
		self:old_set_active(active);
	end
end
function MyAssetGameObject:get_active()
	Saved[self] = Saved[self] or {};
	if Saved[self].factive ~= Root.update_seq then 
		Saved[self].factive = Root.update_seq;
		Saved[self].active = self:old_get_active();
	end
	return Saved[self].active;
end

function MyAssetGameObject:set_local_position(lx,ly,lz)
	Saved[self] = Saved[self] or {};
	if Saved[self].flpos ~= Root.update_seq then 
		Saved[self].flpos = Root.update_seq;
		Saved[self].lx,Saved[self].ly,Saved[self].lz = self:old_get_local_position();
	end
	if Saved[self].lx ~= lx or Saved[self].ly ~= ly or Saved[self].lz ~= lz then 
		Saved[self].lx = lx;
		Saved[self].ly = ly;
		Saved[self].lz = lz;
		self:old_set_local_position(lx,ly,lz);
	end
end
function MyAssetGameObject:get_local_position()
	Saved[self] = Saved[self] or {};
	if Saved[self].flpos ~= Root.update_seq then 
		Saved[self].flpos = Root.update_seq;
		Saved[self].lx,Saved[self].ly,Saved[self].lz = self:old_get_local_position();
	end
	return Saved[self].lx,Saved[self].ly,Saved[self].lz;
end
function MyAssetGameObject:set_local_scale(sx,sy,sz)
	Saved[self] = Saved[self] or {};
	if Saved[self].flscale ~= Root.update_seq then 
		Saved[self].flscale = Root.update_seq;
		Saved[self].lsx,Saved[self].lsy,Saved[self].lsz = self:old_get_local_scale();
	end
	if Saved[self].lsx ~= sx or Saved[self].lsy ~= sy or Saved[self].lsz ~= sz then 
		Saved[self].lsx = sx;
		Saved[self].lsy = sy;
		Saved[self].lsz = sz;
		self:old_set_local_scale(sx,sy,sz);
	end
end
function MyAssetGameObject:get_local_scale()
	Saved[self] = Saved[self] or {};
	if Saved[self].flscale ~= Root.update_seq then 
		Saved[self].flscale = Root.update_seq;
		Saved[self].lsx,Saved[self].lsy,Saved[self].lsz = self:old_get_local_scale();
	end
	return Saved[self].lsx,Saved[self].lsy,Saved[self].lsz;
end
function MyAssetGameObject:set_local_rotation(lrx,lry,lrz)
	Saved[self] = Saved[self] or {};
	if Saved[self].flrota ~= Root.update_seq then 
		Saved[self].flrota = Root.update_seq;
		Saved[self].lrx,Saved[self].lry,Saved[self].lrz = self:old_get_local_rotation();
	end
	if Saved[self].lrx ~= lrx or Saved[self].lry ~= lry or Saved[self].lrz ~= lrz then 
		Saved[self].lrx = lrx;
		Saved[self].lry = lry;
		Saved[self].lrz = lrz;
		self:old_set_local_rotation(lrx,lry,lrz);
	end
end
function MyAssetGameObject:get_local_rotation()
	Saved[self] = Saved[self] or {};
	if Saved[self].flrota ~= Root.update_seq then 
		Saved[self].flrota = Root.update_seq;
		Saved[self].lrx,Saved[self].lry,Saved[self].lrz = self:old_get_local_rotation();
	end
	return Saved[self].lrx,Saved[self].lry,Saved[self].lrz;
end
function MyAssetGameObject:set_local_rotationq(lrqx,lrqy,lrqz,lrqw)
	Saved[self] = Saved[self] or {};
	if Saved[self].flrotaq ~= Root.update_seq then 
		Saved[self].flrotaq = Root.update_seq;
		Saved[self].lrqx,Saved[self].lrqy,Saved[self].lrqz,Saved[self].lrqw = self:old_get_local_rotationq();
	end
	if Saved[self].lrqx ~= lrqx or Saved[self].lrqy ~= lrqy or Saved[self].lrqz ~= lrqz or Saved[self].lrqw ~= lrqw then 
		Saved[self].lrqx = lrqx;
		Saved[self].lrqy = lrqy;
		Saved[self].lrqz = lrqz;
		Saved[self].lrqw = lrqw;
		self:old_set_local_rotationq(lrqx,lrqy,lrqz,lrqw);
	end
end
function MyAssetGameObject:get_local_rotationq()
	Saved[self] = Saved[self] or {};
	if Saved[self].flrotaq ~= Root.update_seq then 
		Saved[self].flrotaq = Root.update_seq;
		Saved[self].lrqx,Saved[self].lrqy,Saved[self].lrqz,Saved[self].lrqw = self:old_get_local_rotationq();
	end
	return Saved[self].lrqx,Saved[self].lrqy,Saved[self].lrqz,Saved[self].lrqw;
end
function MyAssetGameObject:set_position(x,y,z)
	Saved[self] = Saved[self] or {};
	if Saved[self].fpos ~= Root.update_seq then 
		Saved[self].fpos = Root.update_seq;
		Saved[self].x,Saved[self].y,Saved[self].z = self:old_get_position();
	end
	if Saved[self].x ~= x or Saved[self].y ~= y or Saved[self].z ~= z then 
		Saved[self].x = x;
		Saved[self].y = y;
		Saved[self].z = z;
		self:old_set_position(x,y,z);
	end
end
function MyAssetGameObject:get_position()
	Saved[self] = Saved[self] or {};
	if Saved[self].fpos ~= Root.update_seq then 
		Saved[self].fpos = Root.update_seq;
		Saved[self].x,Saved[self].y,Saved[self].z = self:old_get_position();
	end
	return Saved[self].x,Saved[self].y,Saved[self].z;
end
--[[function MyAssetGameObject:set_rotation(rx,ry,rz)
	Saved[self] = Saved[self] or {};
	if Saved[self].frota ~= Root.update_seq then 
		Saved[self].frota = Root.update_seq;
		Saved[self].rx,Saved[self].ry,Saved[self].rz = self:old_get_rotation();
	end
	if Saved[self].rx ~= rx or Saved[self].ry ~= ry or Saved[self].rz ~= rz then 
		Saved[self].rx = rx;
		Saved[self].ry = ry;
		Saved[self].rz = rz;
		self:old_set_rotation(rx,ry,rz);
	end
end
function MyAssetGameObject:get_rotation()
	Saved[self] = Saved[self] or {};
	if Saved[self].frota ~= Root.update_seq then 
		Saved[self].frota = Root.update_seq;
		Saved[self].rx,Saved[self].ry,Saved[self].rz = self:old_get_rotation();
	end
	return Saved[self].rx,Saved[self].ry,Saved[self].rz;
end--]]
function MyAssetGameObject:set_rotationq(rqx,rqy,rqz,rqw)
	Saved[self] = Saved[self] or {};
	if Saved[self].frotaq ~= Root.update_seq then 
		Saved[self].frotaq = Root.update_seq;
		Saved[self].rqx,Saved[self].rqy,Saved[self].rqz,Saved[self].rqw = self:old_get_rotationq();
	end
	if Saved[self].rqx ~= rqx or Saved[self].rqy ~= rqy or Saved[self].rqz ~= rqz or Saved[self].rqw ~= rqw then 
		Saved[self].rqx = rqx;
		Saved[self].rqy = rqy;
		Saved[self].rqz = rqz;
		Saved[self].rqw = rqw;
		self:old_set_rotationq(rqx,rqy,rqz,rqw);
	end
end
function MyAssetGameObject:get_rotationq()
	Saved[self] = Saved[self] or {};
	if Saved[self].frotaq ~= Root.update_seq then 
		Saved[self].frotaq = Root.update_seq;
		Saved[self].rqx,Saved[self].rqy,Saved[self].rqz,Saved[self].rqw = self:old_get_rotationq();
	end
	return Saved[self].rqx,Saved[self].rqy,Saved[self].rqz,Saved[self].rqw;
end
function MyAssetGameObject:get_up()
	Saved[self] = Saved[self] or {};
	if Saved[self].fup ~= Root.update_seq then 
		Saved[self].fup = Root.update_seq;
		Saved[self].upx,Saved[self].upy,Saved[self].upz = self:old_get_up();
	end
	return Saved[self].upx,Saved[self].upy,Saved[self].upz;
end
function MyAssetGameObject:set_up(upx,upy,upz)
	Saved[self] = Saved[self] or {};
	if Saved[self].fup ~= Root.update_seq then 
		Saved[self].fup = Root.update_seq;
		Saved[self].upx,Saved[self].upy,Saved[self].upz = self:old_get_up();
	end
	if Saved[self].upx ~= upx or Saved[self].upy ~= upy or Saved[self].upz ~= upz then 
		Saved[self].upx = upx;
		Saved[self].upy = upy;
		Saved[self].upz = upz;
		self:old_set_up(upx,upy,upz);
	end
end
function MyAssetGameObject:get_forward()
	Saved[self] = Saved[self] or {};
	if Saved[self].fforward ~= Root.update_seq then 
		Saved[self].fforward = Root.update_seq;
		Saved[self].forwardx,Saved[self].forwardy,Saved[self].forwardz = self:old_get_forward();
	end
	return Saved[self].forwardx,Saved[self].forwardy,Saved[self].forwardz;
end
function MyAssetGameObject:set_forward(forwardx,forwardy,forwardz)
	Saved[self] = Saved[self] or {};
	if Saved[self].fforward ~= Root.update_seq then 
		Saved[self].fforward = Root.update_seq;
		Saved[self].forwardx,Saved[self].forwardy,Saved[self].forwardz = self:old_get_forward();
	end
	if Saved[self].forwardx ~= forwardx or Saved[self].forwardy ~= forwardy or Saved[self].forwardz ~= forwardz then 
		Saved[self].forwardx = forwardx;
		Saved[self].forwardy = forwardy;
		Saved[self].forwardz = forwardz;
		self:old_set_forward(forwardx,forwardy,forwardz);
	end
end
function MyAssetGameObject:get_world_to_local_matrix()
	Saved[self] = Saved[self] or {};
	if Saved[self].fw2lmat ~= Root.update_seq then 
		Saved[self].fw2lmat = Root.update_seq;
		Saved[self].w2lmat = self:old_get_world_to_local_matrix();
	end
	return Saved[self].w2lmat;
end
function MyAssetGameObject:get_child_by_name(path)
	Saved[self] = Saved[self] or {};
	local obj = self:old_get_child_by_name(path);
	if obj ~= nil then 
		AssetGameObject.replace_functions(obj);
	end
	return obj;
end
function MyAssetGameObject:get_parent()
	Saved[self] = Saved[self] or {};
	if Saved[self].fparent ~= Root.update_seq then 
		Saved[self].fparent = Root.update_seq;
		Saved[self].parent = self:old_get_parent();
	end
	return Saved[self].parent;
end
function MyAssetGameObject:set_parent(parent)
	Saved[self] = Saved[self] or {};
	if Saved[self].fparent ~= Root.update_seq then 
		Saved[self].fparent = Root.update_seq;
		Saved[self].parent = self:old_get_parent();
	end
	if Saved[self].parent ~= parent then 
		Saved[self].parent = parent;
		self:old_set_parent(parent);
	end
end
function MyAssetGameObject:set_material_render_queue(queue)
	Saved[self] = Saved[self] or {};
	if Saved[self].fmrq ~= Root.update_seq then 
		Saved[self].fmrq = Root.update_seq;
		Saved[self].mrq = self:old_get_material_render_queue();
	end
	if Saved[self].mrq ~= queue then 
		Saved[self].mrq = queue;
		self:old_set_material_render_queue(queue);
	end 
end
function MyAssetGameObject:get_material_render_queue()
	Saved[self] = Saved[self] or {};
	if Saved[self].fmrq ~= Root.update_seq then 
		Saved[self].fmrq = Root.update_seq;
		Saved[self].mrq = self:old_get_material_render_queue();
	end
	return Saved[self].mrq;
end
function MyAssetGameObject:set_shader(shader)
	Saved[self] = Saved[self] or {};
	if Saved[self].fshader ~= Root.update_seq then 
		Saved[self].fshader = Root.update_seq;
		Saved[self].shader = self:old_get_shader();
	end
	if Saved[self].shader ~= shader then 
		Saved[self].shader = shader;
		self:old_set_shader(shader);
	end
end
function MyAssetGameObject:get_shader()
	Saved[self] = Saved[self] or {};
	if Saved[self].fshader ~= Root.update_seq then 
		Saved[self].fshader = Root.update_seq;
		Saved[self].shader = self:old_get_shader();
	end
	return Saved[self].shader;
end
function MyAssetGameObject:set_box_collider_size(bcsx,bcsy,bcsz)
	Saved[self] = Saved[self] or {};
	if Saved[self].fbcs ~= Root.update_seq then 
		Saved[self].fbcs = Root.update_seq;
		Saved[self].bcsx,Saved[self].bcsy,Saved[self].bcsz = self:old_get_box_collider_size();
	end
	if Saved[self].bcsx ~= bcsx or Saved[self].bcsy ~= bcsy or Saved[self].bcsz ~= bcsz then 
		Saved[self].bcsx = bcsx;
		Saved[self].bcsy = bcsy;
		Saved[self].bcsz = bcsz;
		self:old_set_box_collider_size(bcsx,bcsy,bcsz);
	end
end
function MyAssetGameObject:get_box_collider_size()
	Saved[self] = Saved[self] or {};
	if Saved[self].fbcs ~= Root.update_seq then 
		Saved[self].fbcs = Root.update_seq;
		Saved[self].bcsx,Saved[self].bcsy,Saved[self].bcsz = self:old_get_box_collider_size();
	end
	return Saved[self].bcsx,Saved[self].bcsy,Saved[self].bcsz;
end
function MyAssetGameObject:set_capsule_collider_radius(ccr)
	Saved[self] = Saved[self] or {};
	if Saved[self].fccr ~= Root.update_seq then 
		Saved[self].fccr = Root.update_seq;
		Saved[self].ccr = self:old_get_capsule_collider_radius();
	end
	if Saved[self].ccr ~= ccr then 
		Saved[self].ccr = ccr;
		self:old_set_capsule_collider_radius(ccr);
	end
end
function MyAssetGameObject:get_capsule_collider_radius()
	Saved[self] = Saved[self] or {};
	if Saved[self].fccr ~= Root.update_seq then 
		Saved[self].fccr = Root.update_seq;
		Saved[self].ccr = self:old_get_capsule_collider_radius();
	end
	return Saved[self].ccr;
end
function MyAssetGameObject:set_capsule_collider_height(cch)
	Saved[self] = Saved[self] or {};
	if Saved[self].fcch ~= Root.update_seq then 
		Saved[self].fcch = Root.update_seq;
		Saved[self].cch = self:old_get_capsule_collider_height();
	end
	if Saved[self].cch ~= cch then 
		Saved[self].cch = cch;
		self:old_set_capsule_collider_height(cch);
	end
end
function MyAssetGameObject:get_capsule_collider_height()
	Saved[self] = Saved[self] or {};
	if Saved[self].fcch ~= Root.update_seq then 
		Saved[self].fcch = Root.update_seq;
		Saved[self].cch = self:old_get_capsule_collider_height();
	end
	return Saved[self].cch;
end
function MyAssetGameObject:set_root_motion(rmt)
	Saved[self] = Saved[self] or {};
	if Saved[self].frmt ~= Root.update_seq then 
		Saved[self].frmt = Root.update_seq;
		Saved[self].rmt = self:old_get_root_motion();
	end
	if Saved[self].rmt ~= rmt then 
		Saved[self].rmt = rmt;
		self:old_set_root_motion(rmt);
	end
end
function MyAssetGameObject:get_root_motion()
	Saved[self] = Saved[self] or {};
	if Saved[self].frmt ~= Root.update_seq then 
		Saved[self].frmt = Root.update_seq;
		Saved[self].rmt = self:old_get_root_motion();
	end
	return Saved[self].rmt;
end
function MyAssetGameObject:is_grounded()
	Saved[self] = Saved[self] or {};
	if Saved[self].fiis_grounded ~= Root.update_seq then 
		Saved[self].fis_grounded = Root.update_seq;
		Saved[self].is_grounded = self:old_is_grounded();
	end
	return Saved[self].is_grounded;
end
Show3d = Class("Show3d");
Show3d.quotenum = 0;

-- local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d.assetbundle";
local res = "assetbundles/prefabs/map/045_juesezhanshi/role3d_002.assetbundle";

function Show3d.GetResList()
	return {res}
end

function Show3d.SetAndShow(data)
    if Show3d.instance then
		Show3d.instance:UpdateData(data);
	else
		Show3d.instance = Show3d:new(data)
	end
end

function Show3d.SetLoadCallBack(callback)
	local self = Show3d.instance
	if self then
		self.loadOkCallback = callback
		if self.role3d then
			self.role3d:SetLoadCallBack(self.loadOkCallback)
		end
	end
end

function Show3d.Destroy()
	Show3d.quotenum = Show3d.quotenum -1
	--app.log("quotenum============="..tostring(Show3d.quotenum))
	if Show3d.quotenum > 0 then
		return 
	end

    if Show3d.instance then
        Show3d.instance:Hide();
        Show3d.instance:DestroyUi();
        Show3d.instance = nil;
        Show3d.quotenum = 0;
    end
end

function Show3d.GetInstance()
	return Show3d.instance
end

function Show3d.Addquote( )

	Show3d.quotenum = Show3d.quotenum + 1
	-- body
end

function Show3d.SetVisible(bool)
	if Show3d.instance then
		Show3d.instance:SetVisibleRole3d(bool)
	end
end

function Show3d:Init(data)
	self.panel_name = self._className
	self:InitData(data);
	self:RegistFunc();
	self:LoadAsset();
	ResourceManager.AddPermanentReservedRes(res);
end

function Show3d:InitData(data)
	self.pathRes = res;
	self.bindfunc = {};
	if not data then return end
	self.roleData = data.roleData;
	self.role3d_ui_touch = data.role3d_ui_touch;
	self.callback = data.callback;
	self.isGray = data.isGray;
	if data.type == "right" then
		self.type = 3
	elseif data.type == "mid" then
		self.type = 2
	elseif data.type == "left" then
		self.type = 1
	else
		self.type = 1
	end
end

function Show3d:RegistFunc()
	self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
end

--注销回调函数
function Show3d:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v);
        end
    end
end

function Show3d:LoadAsset()
	ResourceLoader.LoadAsset(self.pathRes, self.bindfunc['on_loaded'], self.panel_name);
end

function Show3d:Show()
	if self.ui3d then
		self.ui3d:set_active(true);
	end
end

function Show3d:Hide()
	if self.ui3d then
		self.ui3d:set_active(false);
	end
end

function Show3d:DestroyUi()
    self:UnRegistFunc()
	ResourceLoader.ClearGroupCallBack(self.panel_name)
	if self.ui3d then
		self.ui3d:set_active(false);
		self.ui3d = nil;
	end
	if self.role3d then
		self.role3d:Destroy();
		self.role3d = nil;
	end
	self.visibleRole3d = nil;
end

function Show3d:on_loaded(pid, filepath, asset_obj, error_info)
	if filepath == self.pathRes then
		self:InitUI(asset_obj);
	end
end

function Show3d:InitUI(obj)
	self.ui3d = asset_game_object.create(obj);
	self.ui3d:set_name("role_3d_show");
    -- self.ui3d_root = self.ui3d:get_child_by_name("can_move/P_juesezhanshi_001");
    -- self.ui3d_can_move = self.ui3d:get_child_by_name("can_move");
    -- self.ui3d_not_move = self.ui3d:get_child_by_name("not_move");
    -- local screen_width = app.get_screen_width();
    -- local screen_height = app.get_screen_height();
    -- local x = screen_width/screen_height;
    -- local offset = 1.2*(x*9/16)-1.2;
    -- self.ui3d_can_move:set_local_position(offset,0,0);
    -- self.ui3d_not_move:set_local_position(offset,0,0);

    local midObj = self.ui3d:get_child_by_name("role3d_mid")
    local leftObj = self.ui3d:get_child_by_name("role3d_left")
	app.log("[][]][]][][self.type == "..self.type);
    if self.type == 3 then
    	self.ui3d_root = leftObj:get_child_by_name("can_move")
    	leftObj:set_active(true)
    	midObj:set_active(false)
	    --local x = screen_width/screen_height;
	    --local offset = (x*9/16)-1;
	    local objCamera = leftObj:get_child_by_name("role_camera")
	    local x1, y1, z1 = objCamera:get_local_position()
	    local x, y, z = self.ui3d_root:get_local_position()
        local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)

		local newX = x1 + (x - x1)*scaleModel;
	    self.ui3d_root:set_local_position(2*x1 - newX, y * scaleModel * scaleModel, z);
    elseif self.type == 1 then
    	self.ui3d_root = leftObj:get_child_by_name("can_move")
    	leftObj:set_active(true)
    	midObj:set_active(false)
        local scaleModel = PublicFunc.SetScaleByScreenRate(self.ui3d_root)
	    
	    local objCamera = leftObj:get_child_by_name("role_camera")
	    local x1, y1, z1 = objCamera:get_local_position()
	    local x, y, z = self.ui3d_root:get_local_position()
	    self.ui3d_root:set_local_position(x1 + (x - x1)*scaleModel, y * scaleModel * scaleModel, z);
    elseif self.type == 2 then
    	self.ui3d_root = midObj:get_child_by_name("can_move");
        PublicFunc.SetScaleByScreenRate(self.ui3d_root)

    	leftObj:set_active(false)
    	midObj:set_active(true)
    end

    if not self.ui3d_root then return end
    --self.role3d_ui_touch = ngui.find_sprite(self.ui, "centre_other/animation/left_content/tex_people/sp_people");
    if self.roleData then
        self.role3d = Role3d:new({parent = self.ui3d_root,role_id = self.roleData.number,load_call_back= self.callback,uiSp = self.role3d_ui_touch, isGray = self.isGray});
    else
        self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch});
    end

	self.role3d:SetLoadCallBack(self.loadOkCallback)

	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
end

function Show3d:UpdateData(data)
        if data.roleData and self.roleid == data.roleData.number then
            --app.log("11111111111111111")
            return  
        end
	self.roleData = data.roleData
	self.isGray = data.isGray;
        
        if data.roleData then
            self.roleid = data.roleData.number; 
        else
            self.roleid = 0;
        end
        
	if self.ui3d_root == nil or self.role3d == nil then return end

	if self.roleData then
		local role_id = data.roleData.number;
		self.role3d:ChangeObj(role_id);
		self.role3d:SetGray(self.isGray);
		self:Show();
	else
		self.role3d:Destroy()
		self.role3d = Role3d:new({parent = self.ui3d_root,load_call_back= self.callback,uiSp = self.role3d_ui_touch});
		self.role3d:SetGray(self.isGray);
	end

	self.role3d:SetLoadCallBack(self.loadOkCallback)

	if self.visibleRole3d ~= nil then
		self:SetVisibleRole3d(self.visibleRole3d)
	end
end

function Show3d:SetVisibleRole3d(bVisible)
	self.visibleRole3d = (bVisible == true)
	if self.role3d then
		self.role3d:ShowObj(self.visibleRole3d)
	end
end

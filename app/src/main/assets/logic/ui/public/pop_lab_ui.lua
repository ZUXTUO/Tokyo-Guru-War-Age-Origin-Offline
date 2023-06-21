PopLabUi = Class("PopLabUi");
function PopLabUi:Init(data)
	self.ui = data;    
	self.lab = ngui.find_label(self.ui,"ainimation/lab");
	self.anim = self.ui:get_child_by_name("ainimation");
end

function PopLabUi:SetLab(str)
	self.lab:set_text(tostring(str));
end

function PopLabUi:PlayAnim()
	self.ui:set_active(true);
	self.anim:animated_play("ui_602_3");
end

function PopLabUi:SetPosition(pos)
    local parent = self.ui:get_parent()     
    local x,y,z = parent:inverse_transform_point(pos.x,pos.y,pos.z)

	self.ui:set_local_position(x,y,z);
end

function PopLabUi:set_active(isShow)
    self.ui:set_active(isShow);
    self.anim:set_active(isShow);
end


--------------------------------------------
PopLabMgr = Class('PopLabMgr',UiBaseClass);
----------------------外部接口
-- data = 
-- {
--     	str = xxx,
-- 		world_pos = {x,y,z},
-- }
function PopLabMgr.PushMsg(data)
    if not PopLabMgr.Instance then
        PopLabMgr.Instance = PopLabMgr:new();
        PopLabMgr.Instance:PushLabel(data);
    else
        PopLabMgr.Instance:PushLabel(data);
    end
end

function PopLabMgr.ClearMsg()
    if PopLabMgr.Instance then
        PopLabMgr.Instance.msg_list = {}
        -- for k,v in pairs(PopLabMgr.Instance.playList) do
        --     PopLabMgr.Instance.objPool:DestroyObject(v);
        -- end
    end
end

function PopLabMgr.on_ani_end()
    if not PopLabMgr.Instance then return end
    local obj = PopLabMgr.Instance.playList[1];
    table.remove(PopLabMgr.Instance.playList,1);
    PopLabMgr.Instance.objPool:DestroyObject(obj);
end

function PopLabMgr.on_ani_next()
    if not PopLabMgr.Instance then return end
	PopLabMgr.Instance.isRunning = false;
    PopLabMgr.Instance:ShowNextLabel();
end

--初始化
function PopLabMgr:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/pop_lab.assetbundle";
    UiBaseClass.Init(self, data);
end

--重新开始
function PopLabMgr:Restart(data)
    UiBaseClass.Restart(self, data);
end

--初始化数据
function PopLabMgr:InitData(data)
    UiBaseClass.InitData(self, data);
    self.msg_list = {};
    self.playList = {};
    self.isRunning = false;
end

--析构函数
function PopLabMgr:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.isRunning = false;
    self.msg_list = {};
    self.playList = {};
    self.objPool:Destroy();
end

--注册回调函数
function PopLabMgr:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--初始化UI
function PopLabMgr:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('pop_lab');
    self.objPool = ObjectPool:new({obj=self.ui,class=PopLabUi});
    self:ShowNextLabel();
end

function PopLabMgr:ShowNextLabel()
	if not self.ui then return end;
	if self.isRunning then return end;
	if #self.msg_list == 0 then
		return;
	end
	self.isRunning = true;
	local data = self.msg_list[1];
	table.remove(self.msg_list,1);
	local obj = self.objPool:GetObject();
	obj:SetPosition(data.world_pos);
	obj:SetLab(data.str);
	obj:PlayAnim();
	table.insert(self.playList,obj);
end

function PopLabMgr:PushLabel(data)
	table.insert(self.msg_list,data);
	self:ShowNextLabel();
end


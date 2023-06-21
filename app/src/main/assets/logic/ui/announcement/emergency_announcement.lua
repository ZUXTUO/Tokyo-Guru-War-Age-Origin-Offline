EmergencyAnnouncement = Class('EmergencyAnnouncement',UiBaseClass);
------------外部接口--------------
--[[显示活动公告]]

--AnnouncementData = AnnouncementData or {};

--[[AnnouncementData = 
{
	[1] = {
		type = 0;
		imageName = "";
		content = "    这是一个紧急公告，紧急公告哟！\n    要不要试试紧急公告的厉害？这个公告超级厉害的哟，信不信由你。\n    要不要试试紧急公告的厉害？这个公告超级厉害的哟，信不信由你。";
		Index = 1;
		bImmediately = false;
		startTime = "1467621000";
		endTime = "1467641000";
		displayed = false;
	},
	[2] = {
		type = 1;
		imageName = "assetbundles/prefabs/ui/image/backgroud/gong_gao_xi_tong/sjbaoxiang_beijing1014x374.assetbundle";
		content = "这里是世界宝箱活动公告测试，测试一下ABCDEFGHIJK";
		Index = 2;
		bImmediately = false;
		startTime = "1467621000";
		endTime = "1467641000";
		displayed = false;
	},
	[3] = {
		type = 1;
		imageName = "assetbundles/prefabs/ui/image/backgroud/gong_gao_xi_tong/sjboss_beijing1014x374.assetbundle";
		content = "这里是世界BOSS活动公告测试，测试一下1234567890";
		Index = 3;
		bImmediately = false;
		startTime = "1467621000";
		endTime = "1467641000";
		displayed = false;
	}
}]]

EmergencyAnnouncement.sortFunc = function(a,b)
	return a.Index < b.Index;
end 

function EmergencyAnnouncement.ShowUI()
	--新手引导检查
	if GuideManager.IsGuideRuning() then return end

	if EmergencyAnnouncement.instance ~= nil then 
		do return end;
	end 
	if #AnnouncementData > 1 then 
		table.sort(AnnouncementData,EmergencyAnnouncement.sortFunc);
	end
	local needShow = false;
	for k,v in pairs(AnnouncementData) do 
		if EmergencyAnnouncement.checkCanDisplay(v) then 
			needShow = true;
		end 
	end
	if needShow == true then 
		app.log("show EmergencyAnnouncement");
		EmergencyAnnouncement.instance = EmergencyAnnouncement:new();
	else
		ActivityAnnouncement.ShowUI();
	end 
end

--重新开始
function EmergencyAnnouncement:Restart(data)
    --app.log("EmergencyAnnouncement:Restart");
    UiBaseClass.Restart(self, data);
end

function EmergencyAnnouncement:InitData(data)
    --app.log("EmergencyAnnouncement:InitData");
    UiBaseClass.InitData(self, data);
    self.msg = nil;
end

function EmergencyAnnouncement:RegistFunc()
	--app.log("EmergencyAnnouncement:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_click'] = Utility.bind_callback(self,self.on_click);
end

function EmergencyAnnouncement:ShowAnnouncement(announce)
	announce.displayed = true;
	self.vs.labContent:set_text(announce.content);
end 

function EmergencyAnnouncement:InitUI(asset_obj)
	--app.log("EmergencyAnnouncement:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('EmergencyAnnouncement');
	self.vs = {};
	self.vs.mask = ngui.find_sprite(self.ui,"sp_mark");
	self.vs.btnClose = ngui.find_button(self.ui,"center_other/btn1");
	self.vs.labContent = ngui.find_label(self.ui,"center_other/sco_view/panel/lab_nature");
	self.vs.labContent:set_overflow(3);
	self.vs.btnClose:set_on_click(self.bindfunc["on_click"]);
	for k,v in pairs(AnnouncementData) do 
		if EmergencyAnnouncement.checkCanDisplay(v) then 	
			self:ShowAnnouncement(v);
			do return end;
		end
	end
	self:Hide();
	self:DestroyUi();
	EmergencyAnnouncement.instance = nil;
end
--检查活动公告是否处于需要显示的时间段，以及是否是活动公告
function EmergencyAnnouncement.checkCanDisplay(activity)
	local stt = tonumber(activity.startTime);
	local edt = tonumber(activity.endTime);
	local curTime = system.time();
	if curTime > stt and curTime < edt and activity.type == 0 and activity.displayed == false then 
		return true;
	end
	return false;
end 

function EmergencyAnnouncement:on_click()
	app.log("EmergencyAnnouncement:on_click()");
	for k,v in pairs(AnnouncementData) do 
		if EmergencyAnnouncement.checkCanDisplay(v) then 
			self:ShowAnnouncement(v);
			do return end;
		end
	end
	self:Hide();
	self:DestroyUi();
	EmergencyAnnouncement.instance = nil;
	ActivityAnnouncement.ShowUI();
end

function EmergencyAnnouncement:Init(data)
	--app.log("EmergencyAnnouncement:Init");
    self.pathRes = "assetbundles/prefabs/ui/public/panel_jin_ji_announcement.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function EmergencyAnnouncement:DestroyUi()
	app.log("EmergencyAnnouncement:DestroyUi");
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function EmergencyAnnouncement:Show()
	--app.log("EmergencyAnnouncement:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function EmergencyAnnouncement:Hide()
	--app.log("EmergencyAnnouncement:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function EmergencyAnnouncement:MsgRegist()
	--app.log("EmergencyAnnouncement:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function EmergencyAnnouncement:MsgUnRegist()
	--app.log("EmergencyAnnouncement:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
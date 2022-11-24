ActivityAnnouncement = Class('ActivityAnnouncement',UiBaseClass);
------------外部接口--------------
--[[显示活动公告]]

AnnouncementData = AnnouncementData or {};
--[[	[1] = {
		type = 2;
		imageName = "assetbundles/prefabs/ui/image/backgroud/gong_gao_xi_tong/sjbaoxiang_beijing1014x374.assetbundle";
		content = "这里是世界宝箱活动公告测试，测试一下ABCDEFGHIJK";
		Index = 1;
		bImmediately = false;
		startTime = "1467621000";
		endTime = "1467641000";
		displayed = false;
	},
	[2] = {
		type = 2;
		imageName = "assetbundles/prefabs/ui/image/backgroud/gong_gao_xi_tong/sjboss_beijing1014x374.assetbundle";
		content = "这里是世界BOSS活动公告测试，测试一下1234567890";
		Index = 2;
		bImmediately = false;
		startTime = "1467621000";
		endTime = "1467641000";
		displayed = false;
	}--]]

ActivityAnnouncement.sortFunc = function(a,b)
	return a.Index < b.Index;
end 

function ActivityAnnouncement.ShowUI()
	--GLoading.Show();
	if ActivityAnnouncement.instance ~= nil then 
		do return end;
	end 
	ActivityAnnouncement.loadPathList = {};
	if #AnnouncementData > 1 then 
		table.sort(AnnouncementData,ActivityAnnouncement.sortFunc);
	end
	local needShow = false;
	for k,v in pairs(AnnouncementData) do 
		if ActivityAnnouncement.checkCanDisplay(v) then 
			needShow = true;
		end 
	end
	if needShow == true then 
		app.log("show ActivityAnnouncement");
		ActivityAnnouncement.instance = ActivityAnnouncement:new();
	end 
end

function ActivityAnnouncement.onAssetLoadOk(pid, fpath, texture_obj, error_info)
	local tempList = ActivityAnnouncement.loadPathList;
	local len = #tempList;
	local i = 0;
	local allLoadOk = true;
	for i = 1,len do 
		if tempList[i].path == fpath then 
			tempList[i].loadOk = true;
		end
		if tempList[i].loadOk == true then 
			allLoadOk = false;
		end
	end
	if allLoadOk == true then 
		GLoading.Hide(GLoading.EType.msg);
		ActivityAnnouncement.instance = ActivityAnnouncement:new();
	end
end 

--重新开始
function ActivityAnnouncement:Restart(data)
    --app.log("ActivityAnnouncement:Restart");
    UiBaseClass.Restart(self, data);
end

function ActivityAnnouncement:InitData(data)
    --app.log("ActivityAnnouncement:InitData");
    UiBaseClass.InitData(self, data);
    self.msg = nil;
end

function ActivityAnnouncement:RegistFunc()
	--app.log("ActivityAnnouncement:RegistFunc");
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_other_player_info_receive'] = Utility.bind_callback(self, self.on_other_player_info_receive);
	self.bindfunc['on_click'] = Utility.bind_callback(self,self.on_click);
end

function ActivityAnnouncement:ShowActivity(activity)
	activity.displayed = true;
	self.vs.imageTexture:set_texture(activity.imageName);
	self.vs.labContent:set_text(activity.content);
end 

function ActivityAnnouncement:InitUI(asset_obj)
	--app.log("ActivityAnnouncement:InitUI");
	UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name('ActivityAnnouncement');
	self.vs = {};
	self.vs.imageTexture = ngui.find_texture(self.ui,"center_other/Texture");
	self.vs.btnClose = ngui.find_button(self.ui,"center_other/btn");
	self.vs.btnClose:set_on_click(self.bindfunc["on_click"]);
	self.vs.mask = ngui.find_sprite(self.ui,"sp_mark");
	self.vs.mask:set_on_ngui_click(self.bindfunc["on_click"]);
	self.vs.labContent = ngui.find_label(self.ui,"center_other/sp_bar/lab");
	for k,v in pairs(AnnouncementData) do 
		if ActivityAnnouncement.checkCanDisplay(v) then 	
			self:ShowActivity(v);
			do return end;
		end
	end
	self:Hide();
	self:DestroyUi();
	ActivityAnnouncement.instance = nil;
end
--检查活动公告是否处于需要显示的时间段，以及是否是活动公告
function ActivityAnnouncement.checkCanDisplay(activity)
	local stt = tonumber(activity.startTime);
	local edt = tonumber(activity.endTime);
	local curTime = system.time();
	if curTime > stt and curTime < edt and activity.type == 1 and activity.displayed == false then 
		return true;
	end
	return false;
end 

function ActivityAnnouncement:on_click()
	app.log("ActivityAnnouncement:on_click()");
	for k,v in pairs(AnnouncementData) do 
		if ActivityAnnouncement.checkCanDisplay(v) then 
			self:ShowActivity(v);
			do return end;
		end
	end
	self:Hide();
	self:DestroyUi();
	ActivityAnnouncement.instance = nil;
end

function ActivityAnnouncement:Init(data)
	--app.log("ActivityAnnouncement:Init");
    self.pathRes = "assetbundles/prefabs/ui/public/panel_main_announcement.assetbundle";
	UiBaseClass.Init(self, data);
end

--析构函数
function ActivityAnnouncement:DestroyUi()
	app.log("ActivityAnnouncement:DestroyUi");
	self.vs.imageTexture:destroy_object();
    self.vs = nil;
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function ActivityAnnouncement:Show()
	--app.log("ActivityAnnouncement:Show");
    UiBaseClass.Show(self);
end

--隐藏ui
function ActivityAnnouncement:Hide()
	--app.log("ActivityAnnouncement:Hide");
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function ActivityAnnouncement:MsgRegist()
	--app.log("ActivityAnnouncement:MsgRegist");
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function ActivityAnnouncement:MsgUnRegist()
	--app.log("ActivityAnnouncement:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
end
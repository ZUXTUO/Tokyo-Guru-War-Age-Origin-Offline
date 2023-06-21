CommonFailAward = Class("CommonFailAward", UiBaseClass);

--------------------外部接口-------------------------
--awardsList 物品列表 ｛net_summary_item，net_summary_item，net_summary_item｝最多10个
--tType 1合成失败	不传默认1
function CommonFailAward.Start(awardsList, tType)

    app.log('equip compound discard!')

    do return end

	if CommonFailAward.cls == nil then
		CommonFailAward.cls = CommonFailAward:new({
			awardsList=awardsList, 
			tType=tType,
			});
	end
end


function CommonFailAward.SetFinishCallback(callback, obj)
	if CommonFailAward.cls then
		CommonFailAward.cls.callbackFunc = callback;
		if CommonFailAward.cls.callbackFunc then
			CommonFailAward.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonFailAward.Destroy()
	if CommonFailAward.cls then
		CommonFailAward.cls:DestroyUi();
		CommonFailAward.cls = nil;
	end
end
--------------------内部接口-------------------------
function CommonFailAward:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/fight/ui_818_fight_lose.assetbundle";
	UiBaseClass.Init(self, data);
end

function CommonFailAward:InitData(data)
	UiBaseClass.InitData(self, data);
	--外部数据相关
	self.data = data;
	self.data.tType = self.data.tType or 1;
	--ui相关
	self.uiControl = {};
	--内部变量相关
	--self.callbackFunc
	--self.callbackObj
	CommonClearing.canClose = false;
end

function CommonFailAward:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
end

function CommonFailAward:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("CommonFailAward");

	local control = self.uiControl;
	--标题头
	control.objTitle = self.ui:get_child_by_name("top_other");
	control.objTitleAnim = control.objTitle:get_child_by_name("animation");
	
	control.spTitle1_1 = ngui.find_sprite(control.objTitleAnim, "sp_left");
	control.spTitle1_2 = ngui.find_sprite(control.objTitleAnim, "sp_right");
	control.spTitle2_1 = ngui.find_sprite(control.objTitleAnim, "sp_left1");
	control.spTitle2_2 = ngui.find_sprite(control.objTitleAnim, "sp_right2");
	--合成成功获得新物品
	control.labSuccess = ngui.find_label(self.ui, "CommonFailAward/lab2");
	--道具
	control.objOddNum = self.ui:get_child_by_name("odd_num");
	control.objEvenNum = self.ui:get_child_by_name("even_num");
	control.listOddNum = {};
	control.listEvenNum = {};
	for i = 1, 10 do
		if i <= 9 then
			control.listOddNum[i] = {};
			control.listOddNum[i].objRoot = control.objOddNum:get_child_by_name("kug"..i);
			control.listOddNum[i].spItem = ngui.find_texture(control.listOddNum[i].objRoot, "sp_daoju");
			control.listOddNum[i].spFrame = ngui.find_sprite(control.listOddNum[i].objRoot, "sp_frame");
			control.listOddNum[i].labCount = ngui.find_label(control.listOddNum[i].objRoot, "lab_num2");
			control.listOddNum[i].labName = ngui.find_label(control.listOddNum[i].objRoot, "lab_word");
		end
		control.listEvenNum[i] = {};
		control.listEvenNum[i].objRoot = control.objEvenNum:get_child_by_name("kug"..i);
		control.listEvenNum[i].spItem = ngui.find_texture(control.listEvenNum[i].objRoot, "sp_daoju");
		control.listEvenNum[i].spFrame = ngui.find_sprite(control.listEvenNum[i].objRoot, "sp_frame");
		control.listEvenNum[i].labCount = ngui.find_label(control.listEvenNum[i].objRoot, "lab_num2");
		control.listEvenNum[i].labName = ngui.find_label(control.listEvenNum[i].objRoot, "lab_word");
	end
	local btn = ngui.find_button(self.ui, "mark");
	btn:set_on_click(self.bindfunc["OnClose"]);

	self:UpdateUi();
end

function CommonFailAward:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return;
	end
	--app.log(table.tostring(self));
	local data = self.data;
	local control = self.uiControl;
	--标题头
	-- for i = 1, 2 do
	-- 	if data.tType == 1 then
	-- 		control["spTitle"..i.."_1"]:set_sprite_name("huode");
	-- 		control["spTitle"..i.."_2"]:set_sprite_name("wupin");
	-- 	elseif data.tType == 2 then
	-- 		control["spTitle"..i.."_1"]:set_sprite_name("hecheng");
	-- 		control["spTitle"..i.."_2"]:set_sprite_name("chenggong");
	-- 	end
	-- end
	--合成成功返还
	-- if data.tType == 2 then
	-- 	control.labSuccess:set_active(true);
	-- else
	-- 	control.labSuccess:set_active(false);
	-- end
	--道具
	--判断奇偶数
	local controlData = nil;
	if (#data.awardsList) % 2 == 0 then
		control.objOddNum:set_active(false);
		control.objEvenNum:set_active(true);
		controlData = control.listEvenNum;
	else
		control.objOddNum:set_active(true);
		control.objEvenNum:set_active(false);
		controlData = control.listOddNum;
	end
	--初始化道具
	for i = 1, 10 do
		if controlData[i] and controlData[i].objRoot then
			if i <= #data.awardsList then
				controlData[i].objRoot:set_active(true);
				local tempData = data.awardsList[i];
				local cfData = PublicFunc.IdToConfig(tempData.id);
				if cfData == nil then
					app.log("self.UpdateUi id="..tostring(tempData.id));
					return;
				end
				--道具图标
				controlData[i].spItem:set_texture(cfData.small_icon);
				--品质框
				PublicFunc.SetIconFrameSprite(controlData[i].spFrame, cfData.rarity);
				--数量
				if PropsEnum.IsVaria(tempData.id) then
					controlData[i].labCount:set_active(false);
					controlData[i].labName:set_text(tostring(tempData.count)..tostring(cfData.name));
				else
					controlData[i].labCount:set_active(true);
					controlData[i].labCount:set_text("x"..tostring(tempData.count));
					controlData[i].labName:set_text(tostring(cfData.name));
				end
			else
				controlData[i].objRoot:set_active(false);
			end
		end
	end
end

function CommonFailAward:OnClose(t)
	if not CommonClearing.canClose then
		return;
	end
	--外部数据相关
	if self.data then
		for k, v in pairs(self.data) do
			self.data[k] = nil;
		end
	end
	self.data = nil;
	--ui相关
	if CommonFailAward.cls then
		CommonFailAward.cls:DestroyUi();
		CommonFailAward.cls = nil;
	end
	local control = self.uiControl;
	for i = 1, 10 do
		if i <= 9 then
			if control.listOddNum[i].spItem then
				control.listOddNum[i].spItem:Destroy();
				control.listOddNum[i].spItem = nil;
			end
		end
		if control.listEvenNum[i].spItem then
			control.listEvenNum[i].spItem:Destroy();
			control.listEvenNum[i].spItem = nil;
		end
	end
	self.uiControl = nil;
	--内部变量相关
	local oldCallback = self.callbackFunc;
	local oldCallObj = self.callbackObj;
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
	end
	if oldCallback == self.callbackFunc and oldCallObj == self.callbackObj then
		self.callbackFunc = nil;
		self.callbackObj = nil;
	end
end

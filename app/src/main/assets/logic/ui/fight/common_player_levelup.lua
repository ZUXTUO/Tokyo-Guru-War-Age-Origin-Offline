CommonPlayerLevelup = Class("CommonPlayerLevelup", MultiResUiBaseClass);

-- local timerAdd = 100;
--------------------外部接口-------------------------
--player 玩家对象 参考Player类 player.lua
function CommonPlayerLevelup.Start(player)

    local oldLevel = player.oldData.level or initData.player.level;
    local newLevel = player.level
	if oldLevel == newLevel then
		app.log("CommonPlayerLevelup.Start oldLevel == new level")
		return
	end
	local oldMaxAp = g_dataCenter.player:GetMaxAP(oldLevel);
	local newMaxAp = g_dataCenter.player:GetMaxAP(newLevel);
	local oldAp = g_dataCenter.player:GetOldAP();
	local newAp = g_dataCenter.player:GetAP();
	local oldFv = g_dataCenter.player:GetOldFightValue()
	local fv = g_dataCenter.player:GetFightValue()

	if CommonPlayerLevelup.cls == nil then
		CommonPlayerLevelup.cls = CommonPlayerLevelup:new({
			player={oldData = {level=oldLevel}, 
			level=newLevel, oldMaxAp = oldMaxAp,newMaxAp=newMaxAp,oldAp=oldAp,newAp=newAp, oldFightValue = oldFv, fightValue = fv}, 
			});
	end
end


function CommonPlayerLevelup.SetFinishCallback(callback, obj)
	if CommonPlayerLevelup.cls then
		CommonPlayerLevelup.cls.callbackFunc = callback;
		if CommonPlayerLevelup.cls.callbackFunc then
			CommonPlayerLevelup.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function CommonPlayerLevelup.Destroy()
	if CommonPlayerLevelup.cls then
		CommonPlayerLevelup.cls:DestroyUi()
		CommonPlayerLevelup.cls = nil;
	end
end


local _uiText = 
{
	[1] = '等级提升',
	[2] = '点击屏幕任意位置关闭',
}

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
	[resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_822_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

function CommonPlayerLevelup:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function CommonPlayerLevelup:RestartData(data)
	MultiResUiBaseClass.RestartData(self, data);

	CommonClearing.canClose = false
end

function CommonPlayerLevelup:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self,self.OnClose);
end

function CommonPlayerLevelup:OnClose()
    
	if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    --app.log('CommonPlayerLevelup:OnClose')
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj)
	end
    CommonPlayerLevelup.Destroy()
    -- 通知一下，新手引导可能需要返回主界面进行引导
    NoticeManager.Notice(ENUM.NoticeType.PlayerLevelupUiFinish)
end

function CommonPlayerLevelup.initOpenData()
	if CommonPlayerLevelup.openList == nil then 
		local openList = {};
		local data = ConfigManager._GetConfigTable(EConfigIndex.t_play_vs_data)
		if data then
			for k, v in pairs(data) do
				if v.open_is_show == 1 then
					openList[v.open_level] = openList[v.open_level] or {}
					table.insert(openList[v.open_level], v.name)
				end
			end
		end
		CommonPlayerLevelup.openList = openList;
	end
end 

function CommonPlayerLevelup:InitedAllUI()
	
    self.backui = self.uis[resPaths[resType.Back]]
	self.frontui = self.uis[resPaths[resType.Front]]
    self.frontParentNode = self.backui:get_child_by_name("add_content")
	self.titleSprite= ngui.find_sprite(self.backui, "sp_art_font")
	self.closebtn = ngui.find_button(self.backui, 'mark')
	self.tipCloseLabel = ngui.find_label(self.backui, "txt")
	self.oldLevelLabel = ngui.find_label(self.frontui, 'lab_level/lab_num1')
    self.newLevelLabel = ngui.find_label(self.frontui, 'lab_level/lab_num2')
	self.openfuncTip = self.frontui:get_child_by_name("lab_open")
	self.tipLabel = ngui.find_label(self.openfuncTip, 'lab_num');
	self.maxapOldLabel = ngui.find_label(self.frontui, 'lab_tili/lab_num1')
	self.maxapNewLabel = ngui.find_label(self.frontui, 'lab_tili/lab_num2')
	self.curapOldLabel = ngui.find_label(self.frontui, 'lab_dangqian_tili/lab_num1')
	self.curapNewLabel = ngui.find_label(self.frontui, 'lab_dangqian_tili/lab_num2')

	-- set content
    self.frontui:set_parent(self.frontParentNode)
	self.titleSprite:set_sprite_name("js_dengjitisheng")
    self.closebtn:set_on_click(self.bindfunc["OnClose"])

    local initData = self:GetInitData()

	self.tipCloseLabel:set_text(_uiText[2])
    local oldLevel = initData.player.oldData.level or initData.player.level;
    local newLevel = initData.player.level
    self.oldLevelLabel:set_text(tostring(oldLevel))
    self.newLevelLabel:set_text(tostring(newLevel))
	
	CommonPlayerLevelup.initOpenData();
	
	if CommonPlayerLevelup.openList[newLevel] == nil then 
		self.openfuncTip:set_active(false);
	else 
		self.openfuncTip:set_active(true);

		local openList = CommonPlayerLevelup.openList[newLevel];
		local strArr = {}
		for i = 1, #openList do 
			table.insert(strArr, openList[i])
		end
		self.tipLabel:set_text(table.concat(strArr, "、"));
	end

    
    self.maxapOldLabel:set_text(tostring(initData.player.oldMaxAp))
    self.maxapNewLabel:set_text(tostring(initData.player.newMaxAp))
    self.curapOldLabel:set_text(tostring(initData.player.oldAp))
    self.curapNewLabel:set_text(tostring(initData.player.newAp))

	AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpTeam)
end

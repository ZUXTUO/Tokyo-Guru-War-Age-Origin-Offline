
MobaReadyEnterUI = Class('MobaReadyEnterUI', MultiResUiBaseClass)

-------------------------------------local声明-------------------------------------
local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_4306_ghoul_3v3.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

-------------------------------------类方法-------------------------------------
function MobaReadyEnterUI:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function MobaReadyEnterUI:Restart(data)
	self.dataCenter = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]
	self.randomPos = {}
	local posArray = {1,2,3,4,5,6}
	for i=1, 6 do
		table.insert( self.randomPos, table.remove(posArray, math.random( 1, #posArray )) )
	end
	MultiResUiBaseClass.Restart(self, data);
end

function MobaReadyEnterUI:DestroyUi()
	TimerManager.Remove(self.all_enter_check)
	if self.dataCenter then
		if self.dataCenter:GetStage() ~= 3 then
			--进入失败，恢复主城BGM
			AudioManager.Stop(ENUM.EAudioType._2d, false)
			AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.MainCityBgm, loop=-1}});
		end
		self.dataCenter = nil
	end
	if self.playerList then
		for i, v in pairs(self.playerList) do
			v.uiPlayer:DestroyUi()
			v.fxReady:set_active(false)
		end
		self.playerList = nil
	end

	self.playerData = nil
	self.readyMyself = nil
	
    MultiResUiBaseClass.DestroyUi(self);
	ResourceManager.DelRes(self.pathRes);
end

function MobaReadyEnterUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_start"] = Utility.bind_callback(self, self.on_btn_start);
	self.bindfunc["gc_enter_three_to_three"] = Utility.bind_callback(self, self.gc_enter_three_to_three);
end 

--注册消息分发回调函数
function MobaReadyEnterUI:MsgRegist()
	PublicFunc.msg_regist(msg_three_to_three.gc_enter_three_to_three, self.bindfunc["gc_enter_three_to_three"]);
end

--注销消息分发回调函数
function MobaReadyEnterUI:MsgUnRegist()
	PublicFunc.msg_unregist(msg_three_to_three.gc_enter_three_to_three, self.bindfunc["gc_enter_three_to_three"]);
end

function MobaReadyEnterUI:InitedAllUI()
	local cfg = ConfigManager.Get(EConfigIndex.t_three_to_three_fight, 1)
	self.countDown = cfg.ready_time or 20
	self.playerData = self.dataCenter:GetPlayerMatch()


	self.backui = self.uis[resPaths[resType.Back]]
    self.ui = self.uis[resPaths[resType.Front]]

    self.frontParentNode = self.backui:get_child_by_name("add_content")
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")

	self.tipCloseLabel:set_active(false)
	self.titleSprite:set_sprite_name("js_pipeichenggong")

	self.ui:set_parent(self.frontParentNode)
	self.ui:set_name("ui_moba_ready_enter");

	self.labReadyNum = ngui.find_label(self.ui, "lab_num")
	self.labTime = ngui.find_label(self.ui, "lab_time")
	self.btnStart = ngui.find_button(self.ui, "btn_start")
	self.labWaitTips = ngui.find_label(self.ui, "animation/txt")

	self.btnStart:set_on_click(self.bindfunc["on_btn_start"])

	local fxReadyBase = self.ui:get_child_by_name("fx_ui_4306")
	self.playerList = {}
	for i=1, 6 do
		self.playerList[i] = {}
		local objParent = self.ui:get_child_by_name("grid_player/sp_head_di_item"..i)
		self.playerList[i].uiPlayer = UiPlayerHead:new({parent=objParent})
		self.playerList[i].name = ngui.find_label(objParent, "lab")
		self.playerList[i].fxReady = fxReadyBase:clone()
		self.playerList[i].fxReady:set_parent(objParent)
		-- self.playerList[i].fxReady:set_local_scale(1,1,1)
		self.playerList[i].fxReady:set_local_position(0,0,0)
	end

	TimerManager.Add(self.UpdateTimer, 1000, self.countDown, self) --倒计时

	--BGM检查容错
	local id = AudioManager.Get2dBgmId()
    if id ~= ENUM.EUiAudioBGM.VsWaitingBgm then
        AudioManager.Stop(ENUM.EAudioType._2d, false)
        AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
    end

	self:UpdateUi()
end

function MobaReadyEnterUI:UpdateUi()
	if self.ui == nil then return end

	self.labTime:set_text(tostring(self.countDown))

	local myplayerid = g_dataCenter.player.playerid
	local readyNum = 0
	for i, v in ipairs(self.randomPos) do
		local data = self.playerData[v]
		if data == nil then return end
		if data.image == nil then
			self.playerList[i].uiPlayer:SetRoleId(data.image)
		end
		self.playerList[i].name:set_text(data.name)

		if data.playerid == myplayerid then
			PublicFunc.SetUILabelYellow(self.playerList[i].name) --显示黄色字体
		else
			PublicFunc.SetUILabelWhite(self.playerList[i].name)
		end
		
		if data.enterState == 0 then
			self.playerList[i].fxReady:set_active(false)
		else
			self.playerList[i].fxReady:set_active(true)
			readyNum = readyNum + 1
		end
	end
	self.labReadyNum:set_text(tostring(readyNum).."/6")
	if self.readyMyself then
		self.btnStart:set_active(false)
		self.labWaitTips:set_active(true)
	else
		self.btnStart:set_active(true)
		self.labWaitTips:set_active(false)
	end
end

function MobaReadyEnterUI:UpdateTimer()
	if self.ui == nil then return end

	self.countDown = math.max(0, self.countDown - 1)
	self.labTime:set_text(tostring(self.countDown))
end

function MobaReadyEnterUI:all_enter_check()
	--所有人已确认
	if self.dataCenter:GetStage() == 3 then
		AudioManager.Set2dAudioFilter(ENUM.EUiAudioBGM.VsWaitingBgm, nil, {enable=false,cutoff=450,resq=1}, {enable=false,cutoff=2800,resq=1})
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.VsEnterChoseHero)

		-- 打开选人界面
		uiManager:PushUi(EUI.QingTongJiDiHeroChoseUI)
	end
end


-------------------------------------本地回调-------------------------------------
--进入按钮
function MobaReadyEnterUI:on_btn_start(t)
	msg_three_to_three.cg_enter_three_to_three()
end

function MobaReadyEnterUI:gc_enter_three_to_three(result, playerid)
	if result == 0 then
		self.playerData = self.dataCenter:GetPlayerMatch()
		if playerid == g_dataCenter.player.playerid then
			self.readyMyself = true
		end
		self:UpdateUi()

		TimerManager.Add(self.all_enter_check, 1000, 1, self)
	end
end


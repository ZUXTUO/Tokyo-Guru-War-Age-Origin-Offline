
Ui3v3Matching = Class('Ui3v3Matching', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.resPath = "assetbundles/prefabs/ui/wanfa/qing_tong_ji_di/ui_3v3_matching.assetbundle"

-- 抽取本地的文本，需要替换到配置表
_local.UIText = {
	[1] = "匹配中",
	[2] = "匹配成功",
	[3] = "倒计时 [f2ae1c]%d[-] 秒",
	[4] = "取消匹配",
	[5] = "匹配中...",
}

-- 说明：公用界面，未使用UiManager管理。由调用者自己控制创建及销毁
-------------------------------------外部设置-----------------------------------
-- 设置参数：
-- callback 退出回调函数（回调参数：true匹配成功退出，false取消匹配退出请求）
-- countDown 倒计时长（秒）
-- playerVs 进入匹配的对战玩家
function Ui3v3Matching:SetData(data)
	self.callback = data.callback
	self.countDown = data.countDown
	self.startPlayerVs = data.playerVs
end

-- 设置准备状态
-- true/开始播放动画准备退出界面， false/未准备完毕
function Ui3v3Matching:SetReady(bool)
	self.ready = bool
	if self.ui then
		self:UpdateUi()
	end
	if self.ready then
		--取得所有玩家列表
		self.finishPlayerVs = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_threeToThree]:GetPlayerVs()

		self:PlaceFinishPlayer()
		self:PlayMatchingDone()
	else
		self:PlaceStartPlayer()
	end
end

-------------------------------------类方法-------------------------------------
--初始化
function Ui3v3Matching:Init(data)
	self.pathRes = _local.resPath
	UiBaseClass.Init(self, data);
end

--重新开始
function Ui3v3Matching:Restart(data)
	if data then
		self:SetData(data)
	end
    if UiBaseClass.Restart(self, data) then
	end
end

--初始化数据
function Ui3v3Matching:InitData(data)
	UiBaseClass.InitData(self, data);

	self:ClearData()
end

--清除初始数据
function Ui3v3Matching:ClearData()
	self.countDown = 0	-- 倒计时长
	self.curCount = 0	-- 当前倒计时
	self.ready = false	-- 准备完成，显示完成进度条
	self.callback = nil	-- 成功退出回调函数
	self.timerid = {}
	self.startPlayerVs = nil
    self.finishPlayerVs = nil
end

--释放界面
function Ui3v3Matching:DestroyUi()
	TimerManager.Remove(self.cb_finish_match)
	if self.pnLeftPlayer then
		for i, pnPlayer in pairs(self.pnLeftPlayer) do
			pnPlayer.uiBigCard:DestroyUi()
		end
		self.pnLeftPlayer = nil
	end
	if self.pnRightPlayer then
		for i, pnPlayer in pairs(self.pnRightPlayer) do
			pnPlayer.uiBigCard:DestroyUi()
		end
		self.pnRightPlayer = nil
	end
	--进入
	if self.ready then
		AudioManager.Set2dAudioFilter(ENUM.EUiAudioBGM.VsWaitingBgm, nil, {enable=false,cutoff=450,resq=1}, {enable=false,cutoff=2800,resq=1})
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.VsEnterChoseHero)
	else
		AudioManager.Stop(ENUM.EAudioType._2d, false)
		AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.MainCityBgm, loop=-1}});
	end
    
    self:ClearData()
    self:StopCountDownTimer()
    UiBaseClass.DestroyUi(self);
end

--显示UI
function Ui3v3Matching:Show()
	if UiBaseClass.Show(self) then
		-- self.curCount = self.countDown
		
		-- self:SetReady(false)
		-- self:StartCountDownTimer()
	end
end

--隐藏UI
function Ui3v3Matching:Hide()
	if UiBaseClass.Hide(self) then
		self:StopCountDownTimer()
	end
end

--注册方法
function Ui3v3Matching:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
	self.bindfunc["cb_place_player"] = Utility.bind_callback(self, self.cb_place_player);
	-- self.bindfunc["cb_finish_match"] = Utility.bind_callback(self, self.cb_finish_match);
	self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
	self.bindfunc["on_count_down_timer"] = Utility.bind_callback(self, self.on_count_down_timer);
end 

--撤销注册方法
function Ui3v3Matching:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--初始化UI
function Ui3v3Matching:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_3v3_matching");

    local path = "centre_other/animation/cont_bg/"
	------------------------------ 上部 -----------------------------
    local obj = self.ui:get_child_by_name(path)
    self.spText = ngui.find_sprite(obj, "sp_vs")
    self.labCdTime = ngui.find_label(obj, "lbl_count_down_time")
 --    self.fxLoading = obj:get_child_by_name("fx_ui_loading_vs")
	-- self.fxLoading:set_active(true)

    local pnLeftPlayer = {} 
    path = "centre_other/animation/cont_left/"
    ------------------------------ 左侧 -----------------------------
    for i=1, 3 do
        obj = self.ui:get_child_by_name(path.."cont_big_item"..i)
        pnLeftPlayer[i] = {}
        pnLeftPlayer[i].uiBigCard = UiBigCard:new({parent=obj, infoType=3, showPro=false, showCardName=false})
		pnLeftPlayer[i].uiBigCard:ShowMatching(true)
    end
    self.pnLeftPlayer = pnLeftPlayer

    local pnRightPlayer = {} 
    path = "centre_other/animation/cont_right/"
    ------------------------------ 右侧 -----------------------------
    for i=1, 3 do
        obj = self.ui:get_child_by_name(path.."cont_big_item"..i)
        pnRightPlayer[i] = {}
		pnRightPlayer[i].uiBigCard = UiBigCard:new({parent=obj, infoType=3, showPro=false, showCardName=false})
		pnRightPlayer[i].uiBigCard:ShowMatching(true)
    end
    self.pnRightPlayer = pnRightPlayer
    
    path = "centre_other/animation/"
    ------------------------------ 下部 -----------------------------
    self.btnCancel = ngui.find_button(self.ui, path.."btn")
    self.btnCancel:set_on_click(self.bindfunc["on_cancel_btn"])

	self:UpdateUi()

    if self.ready then
        self:PlayMatchingDone()
    end

    if self.startPlayerVs then
	    self:PlaceStartPlayer()
	end

	if self.finishPlayerVs then
		self:PlaceFinishPlayer()
	end

	self.curCount = self.countDown
	self:StartCountDownTimer()

	-- 更换BGM
	AudioManager.Stop(ENUM.EAudioType._2d, false)
	AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
	AudioManager.Set2dAudioFilter(ENUM.EUiAudioBGM.VsWaitingBgm, nil, {enable=true,cutoff=450,resq=1}, {enable=true,cutoff=2800,resq=1})
end

function Ui3v3Matching:PlaceStartPlayer()
	if self.startPlayerVs == nil or #self.startPlayerVs == 0 then return end
	
	for i, v in pairs(self.startPlayerVs) do
		self:PlacePlayer(i, v)
	end
end

function Ui3v3Matching:PlaceFinishPlayer()
	if self.startPlayerVs == nil or self.finishPlayerVs == 0 then return end

	local addPlayerVs = {}
	local startPlayerVsId = {}
	for i, playerVs in pairs(self.startPlayerVs) do
		startPlayerVsId[playerVs.playerid] = playerVs
	end
	local campFlag = true
	local myPlayerid = g_dataCenter.player.playerid
	local camp1Player = {}
	local camp2Player = {}
	for i, playerVs in pairs(self.finishPlayerVs) do
		if playerVs.playerid == myPlayerid then
			if i > 3 then
				campFlag = false
			end
			break;
		end
	end
	if campFlag then
		for i, playerVs in pairs(self.finishPlayerVs) do
			if startPlayerVsId[playerVs.playerid] == nil then
				table.insert(addPlayerVs, playerVs)
			end
		end
	else
		local camp1Player = {}
		local camp2Player = {}
		for i, playerVs in pairs(self.finishPlayerVs) do
			if i <= 3 then 
				if startPlayerVsId[playerVs.playerid] == nil then
					table.insert(camp2Player, playerVs)
				end
			else
				if startPlayerVsId[playerVs.playerid] == nil then
					table.insert(camp1Player, playerVs)
				end
			end
		end
		for i, playerVs in pairs(camp1Player) do
			table.insert(addPlayerVs, playerVs)
		end
		for i, playerVs in pairs(camp2Player) do
			table.insert(addPlayerVs, playerVs)
		end
	end

	local duration = 10
	local baseIndex = #self.startPlayerVs
	for i, v in ipairs(addPlayerVs) do
		self:PlayPlacePlayer(i + baseIndex, v, duration)
		duration = duration + 500
	end

	self.play_count = #addPlayerVs

	TimerManager.Add(self.cb_finish_match, self.play_count * 500 + 10, 1, self)
end

function Ui3v3Matching:PlayPlacePlayer(index, data, duration)
	local pid = timer.create(self.bindfunc["cb_place_player"], duration, 1)
	self.timerid[pid] = {index, data}
end

function Ui3v3Matching:cb_place_player(pid)
	if self.play_count == nil then return end

	if self.timerid[pid] then
		self:PlacePlayer(self.timerid[pid][1], self.timerid[pid][2])
		self.timerid[pid] = nil
	end
	self.play_count = math.max(0, self.play_count - 1)
end

function Ui3v3Matching:cb_finish_match()
	self:CallbackFunc(true)
end

function Ui3v3Matching:PlacePlayer(index, data)
	if self.ui == nil then return end

    local pnPlayer = nil
	if index <= 3 then
		pnPlayer = self.pnLeftPlayer[index]
	else
		pnPlayer = self.pnRightPlayer[index - 3]
	end

	if pnPlayer then
		pnPlayer.uiBigCard:SetDataNumber(data.image)
		pnPlayer.uiBigCard:SetPlayerName(data.name)
	end
end

-- 播放匹配成功
function Ui3v3Matching:PlayMatchingDone()
	if self.ui then
		-- TODO

		self.labCdTime:set_active(false)
        self.btnCancel:set_active(false)
        -- self.fxLoading:set_active(false)
	end
end

-- 开始倒计时
function Ui3v3Matching:StartCountDownTimer()
	if self.ui then
		self.timer = timer.create(self.bindfunc["on_count_down_timer"], 1000, -1)
		self:UpdateUi()
	end
end

-- 停止倒计时
function Ui3v3Matching:StopCountDownTimer()
	if self.timer then
		timer.stop(self.timer)
		self.timer = nil
	end
end

--刷新界面
function Ui3v3Matching:UpdateUi()
	if self.ui == nil then return end

	-- 刷新倒计时显示 就绪模式
	if self.ready then
		self.spText:set_sprite_name("dz_pipeichenggong")
	else
		self.spText:set_sprite_name("dz_pipeizhong")
		self.labCdTime:set_text(string.format(_local.UIText[3], self.curCount))
	end
end

--回调函数
function Ui3v3Matching:CallbackFunc(bool)
	if self.callback then
		if type(self.callback) == "function" then
	    	self.callback(bool)
	    elseif type(self.callback) == "string" then
	    	Utility.call_func(self.callback, bool)
	    end
	end
end
-------------------------------------本地回调-------------------------------------

--取消匹配按钮
function Ui3v3Matching:on_cancel_btn(t)
	self:CallbackFunc(false)
end

--倒计时回调
function Ui3v3Matching:on_count_down_timer()
	self.curCount = math.max(self.curCount - 1, 0)
	self.labCdTime:set_text(string.format(_local.UIText[3], self.curCount))

	if self.ready or self.curCount == 0 then
		self:StopCountDownTimer()
	end
end


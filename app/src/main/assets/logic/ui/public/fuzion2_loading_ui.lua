Fuzion2Loading = Class("Fuzion2Loading", CommonLoadingUI);

local instance = nil;

local EAnimName = 
{
	["tanchu"] = "ui_loading_daluandou_tanchu",
	-- ["pipei"] = "ui_loading_daluandou_pipei",
	["pipeichenggong"] = "ui_loading_daluandou_pipeichenggong",
	-- ["jiazai"] = "ui_loading_daluandou_jiazai",
	-- ["end"] = "fx_ui_daluandou4",
}

function Fuzion2Loading.GetInstance()
	if not instance then
		instance = Fuzion2Loading:new();
	end
	return instance;
end

local EType =
{
	Match=1,
	Loading=2,
}

function Fuzion2LoadingCallback_TanChu()
	if instance then
		-- instance.animObj:animated_play(EAnimName["pipei"]);
		instance:StartCountDownTimer();
	end
end
-- function Fuzion2LoadingCallback_PiPei()
-- 	if instance then
-- 		instance:StartCountDownTimer();
-- 	end
-- end
function Fuzion2LoadingCallback_PiPeiChengGong()
	if instance then
		-- instance.animObj:animated_play(EAnimName["jiazai"]);
	end
end
function Fuzion2LoadingCallback_End()
	if instance then
		instance:DestroyUi();
	end
end
function Fuzion2LoadingCallback_JiaZai()
	if instance then
	end
end

function Fuzion2Loading:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/loading/ui_loading_daluandou.assetbundle";
    CommonLoadingUI.Init(self, data);
end

function Fuzion2Loading:Restart(data)
    self.type = EType.Match;
	self.curCount = 20	-- 当前倒计时
    if not CommonLoadingUI.Restart(self, data) then
    	return;
    end
end

function Fuzion2Loading:RegistFunc()
    CommonLoadingUI.RegistFunc(self);
	self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
	self.bindfunc["on_count_down_timer"] = Utility.bind_callback(self, self.on_count_down_timer);
	self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match);
	self.bindfunc["gc_match_finish"] = Utility.bind_callback(self, self.gc_match_finish);
end

function Fuzion2Loading:MsgRegist()
    CommonLoadingUI.MsgRegist(self);
	PublicFunc.msg_regist(msg_daluandou2.gc_cancel_match,self.bindfunc["gc_cancel_match"]);
	PublicFunc.msg_regist(msg_daluandou2.gc_match_finish,self.bindfunc["gc_match_finish"]);
end

function Fuzion2Loading:MsgUnRegist()
    CommonLoadingUI.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_daluandou2.gc_cancel_match,self.bindfunc["gc_cancel_match"]);
    PublicFunc.msg_unregist(msg_daluandou2.gc_match_finish,self.bindfunc["gc_match_finish"]);
end

function Fuzion2Loading:InitUI(asset_obj)
    CommonLoadingUI.InitUI(self, asset_obj);
    self.ui:set_name("Fuzion2Loading");

    -- self.tex = ngui.find_texture(self.ui,"centre_other/animation/cont_bg/Texture");
    -- self.tex:set_texture("assetbundles/prefabs/ui/image/backgroud/vs/dz_beijing2.assetbundle");

    self.playerCont = {};
	for i = 1, 10 do
		self.playerCont[i] = { };
		local cont = self.playerCont[i];
		local path = "centre_other/animation/cont_heads/head" .. i .. "/"
		cont.labName = ngui.find_label(self.ui, path .. "lab_name");
		cont.labState = ngui.find_label(self.ui, path .. "lab_load");
		-- cont.objSelf = self.ui:get_child_by_name(path .. "sp_shine");
		-- cont.spPro = ngui.find_sprite(self.ui, path .. "sp_black/sp_pro_blue");
		-- cont.spPro:set_fill_amout(0);
		cont.labPro = ngui.find_label(self.ui,path .. "sp_bk/lab");
		cont.labPro:set_text("");
		-- cont.spLoadOk = ngui.find_sprite(self.ui, path .. "sp_black/sp_load_complete");
		-- cont.spLoadOk:set_active(false);
		-- cont.objPoint = self.ui:get_child_by_name(path .. "cont1/cont_point");
		-- cont.objPoint:set_active(false);
		cont.obj = self.ui:get_child_by_name(path .. "sp_head_di_item");
		cont.head = UiPlayerHead:new( { parent = cont.obj});
	end

	self.animObj = self.ui:get_child_by_name("centre_other/animation");
	self.spTitle1 = ngui.find_sprite(self.ui,"centre_other/animation/sp_art_font1");
	self.spTitle2 = ngui.find_sprite(self.ui,"centre_other/animation/sp_art_font2");
	self.spTitle3 = ngui.find_sprite(self.ui,"centre_other/animation/sp_art_font3");
	self.spTitle4 = ngui.find_sprite(self.ui,"centre_other/animation/sp_art_font4");
	self.btnCancel = ngui.find_button(self.ui,"centre_other/animation/btn_cancel_match");
	self.btnCancel:set_on_click(self.bindfunc["on_cancel_btn"]);
	self.labTime = ngui.find_label(self.ui,"centre_other/animation/lab_count_down_time");
	self.labTime:set_text("");

	self.last_progress = 0;
	if self.type == EType.Match then
		self:UpdateUi();
		self.animObj:animated_play(EAnimName["tanchu"]);

		-- 更换BGM
		AudioManager.Stop(ENUM.EAudioType._2d, false)
		AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.VsWaitingBgm, loop=-1}});
	else
		self:BeginLoading(self.data);
	end
end

function Fuzion2Loading:DestroyUi()
	self:StopCountDownTimer()

    if self.playerCont then
	    for k,v in pairs(self.playerCont) do
	    	v.head:DestroyUi();
	    end
	    self.playerCont = nil;
	end
    CommonLoadingUI.DestroyUi(self);
    instance = nil;
end

--//////////////////////////匹配界面//////////////////////////////
function Fuzion2Loading:UpdateUi()
    if not CommonLoadingUI.UpdateUi(self) then
        return;
    end
	self.btnCancel:set_active(true);
    for i=1,10 do
    	local cont = self.playerCont[i];
		if i==8 then
			local info = g_dataCenter.player;
			cont.labName:set_text("[FFCC00FF]"..info.name.."[-]");
			cont.head:SetRoleId(info.image);
			-- cont.objSelf:set_active(true);
			-- cont.objPoint:set_active(false);
			cont.labState:set_text("");
		else
			cont.labName:set_text("");
			cont.head:SetRoleId(0);
			cont.labState:set_text("匹配中...");
			-- cont.objPoint:set_active(true);
			-- cont.objSelf:set_active(false);
		end
    end
end

-- 开始倒计时
function Fuzion2Loading:StartCountDownTimer()
	if self.ui and self.type == EType.Match then
		self.timer = timer.create(self.bindfunc["on_count_down_timer"], 1000, -1)
		self:UpdateUi()
	end
end

-- 停止倒计时
function Fuzion2Loading:StopCountDownTimer()
	if self.timer then
		timer.stop(self.timer)
		self.timer = nil
	end
end

--/////////////////////loading界面/////////////////////
function Fuzion2Loading:BeginLoading(data)
	CommonLoadingUI.BeginLoading(self,data);
	self.type = EType.Loading;
	self:StopCountDownTimer()
	if not data then
		return;
	end

	self.data = data;
	self.showFighter = data.showFighter;
	if self.showFighter == nil then
		app.log("#lhf#showFighter:"..table.tostring(data).." "..debug.traceback());
		self.showFighter = {};
	end
	for k,v in pairs(self.showFighter) do
		if v.playerid == g_dataCenter.player:GetGID() then
			table.remove(self.showFighter,k);
			table.insert(self.showFighter,8,v);
			break;
		end
	end
	if not self.ui then
		return;
	end
	if not FightScene.is_loading_reconnect then
		self.animObj:animated_play(EAnimName["pipeichenggong"]);
	else
		self.spTitle1:set_active(false);
		self.spTitle2:set_active(false);
		self.spTitle3:set_active(false);
		self.spTitle4:set_active(true);
	end
	self.btnCancel:set_active(false);
	self.labTime:set_text("");
    for i=1, 10 do
		local cont = self.playerCont[i];
		-- if i ~= 8 then
		-- 	cont.obj:animated_play("sp_head_di_item_modi");
		-- end
		if self.showFighter[i] then
			cont.head:SetRoleId(self.showFighter[i].playerImage);
			-- cont.objPoint:set_active(false);
			if self.showFighter[i].playerid == g_dataCenter.player.playerid then
				-- cont.objSelf:set_active(true);
				cont.labName:set_text("[FFCC00FF]"..self.showFighter[i].name.."[-]");
			else
				cont.labName:set_text(self.showFighter[i].name);
				-- cont.objSelf:set_active(false);
			end
		end
	end
end

function Fuzion2Loading:UpdatePercent(playerid, percent)
	CommonLoadingUI.UpdatePercent(self, playerid, percent);
	if not self.ui or not self.showFighter then
		return;
	end
	local info = self.showFighter;
	for i = 1, 10 do
		local cont = self.playerCont[i];
		-- cont.objPoint:set_active(false);
		local percent;
		if info[i].isRobot then
			if info[i].percent <= self.last_progress and info[i].percent < 100 then
				info[i].percent = self.last_progress + math.random(0, 20);
			end
		else
			self.last_progress = info[i].percent or 0;
		end
		percent = info[i].percent or 0;
		if FightScene.is_loading_reconnect then
			if info[i].playerid == g_dataCenter.player.playerid then
			else
				percent = 100;
			end
		end
		percent = math.min(math.floor(percent),100);
		-- cont.spPro:set_fill_amout(percent / 100);
		cont.labState:set_text("");
		if i == 8 then
			cont.labPro:set_text("[FFCC00FF]"..percent.."%[-]")
		else
			cont.labPro:set_text(percent.."%")
			if percent >= 100 then
				-- cont.spLoadOk:set_active(true);
				cont.head:ShowSpeHeadBorder(true);
			elseif percent <= 0 then
				-- cont.spLoadOk:set_active(false);
				cont.head:ShowSpeHeadBorder(false);
			else
				-- cont.spLoadOk:set_active(false);
				cont.head:ShowSpeHeadBorder(false);
			end
		end
	end
end

-- function Fuzion2Loading:End()
-- 	self.animObj:animated_play(EAnimName["end"]);
-- end

-------------------------------------本地回调-------------------------------------
--取消匹配按钮
function Fuzion2Loading:on_cancel_btn(t)
	msg_daluandou2.cg_cancel_match(g_dataCenter.fuzion2.roomid)
end

--倒计时回调
function Fuzion2Loading:on_count_down_timer()
	self.curCount = math.max(self.curCount - 1, 0)
	if self.labTime then
		self.labTime:set_text("倒计时:"..self.curCount.."秒")
	end

	if self.curCount == 0 then
		self:StopCountDownTimer()
	end
end

function Fuzion2Loading:gc_cancel_match()
	self:DestroyUi();
	
    AudioManager.Stop(ENUM.EAudioType._2d, false)
	--恢复主城BGM
	AudioManager.Play2dAudioList({[1]={id=ENUM.EUiAudioBGM.MainCityBgm, loop=-1}});
end

function Fuzion2Loading:gc_match_finish()
	self:StopCountDownTimer()
end
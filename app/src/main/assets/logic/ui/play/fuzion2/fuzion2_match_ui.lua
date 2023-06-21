Funzion2MatchUI = Class("Funzion2MatchUI", UiBaseClass);
-------------------------------------外部设置-----------------------------------
function Funzion2MatchUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fuzion/ui_loading_daluandou2_matching.assetbundle";
    UiBaseClass.Init(self, data);
end

function Funzion2MatchUI:InitData(data)
    UiBaseClass.InitData(self, data);

end

function Funzion2MatchUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
	self.curCount = 20	-- 当前倒计时
end

function Funzion2MatchUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
	self.bindfunc["on_cancel_btn"] = Utility.bind_callback(self, self.on_cancel_btn);
	self.bindfunc["on_count_down_timer"] = Utility.bind_callback(self, self.on_count_down_timer);
	self.bindfunc["gc_cancel_match"] = Utility.bind_callback(self, self.gc_cancel_match);
	self.bindfunc["gc_match_finish"] = Utility.bind_callback(self, self.gc_match_finish);
end

function Funzion2MatchUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_daluandou2.gc_cancel_match,self.bindfunc["gc_cancel_match"]);
	PublicFunc.msg_regist(msg_daluandou2.gc_match_finish,self.bindfunc["gc_match_finish"]);
end

function Funzion2MatchUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_daluandou2.gc_cancel_match,self.bindfunc["gc_cancel_match"]);
    PublicFunc.msg_unregist(msg_daluandou2.gc_match_finish,self.bindfunc["gc_match_finish"]);
end

function Funzion2MatchUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_loading_daluandou2");

    self.playerCont = { }
	for i = 1, 10 do
		self.playerCont[i] = { };
		local cont = self.playerCont[i];
		local path = "centre_other/animation/cont_heads/head (" .. i .. ")/"
		cont.labName = ngui.find_label(self.ui, path .. "cont/lbl_name");
		cont.labState = ngui.find_label(self.ui, path .. "cont/lbl_statu");
		cont.objSelf = self.ui:get_child_by_name(path .. "cont/cont_self");
		cont.spPro = ngui.find_sprite(self.ui, path .. "cont/sp_pro_blue");
		cont.spPro:set_fill_amout(0);
		cont.spLoadOk = ngui.find_sprite(self.ui, path .. "cont/sp_load_complete");
		cont.spLoadOk:set_active(false);
		cont.objPoint = self.ui:get_child_by_name(path .. "cont/cont_point");
		cont.objHead = self.ui:get_child_by_name(path .. "sp_head_di_item");
	end

	self.btnCancel = ngui.find_button(self.ui,"centre_other/animation/btn_cancel_match");
	self.btnCancel:set_on_click(self.bindfunc["on_cancel_btn"]);

	self.labTime = ngui.find_label(self.ui,"centre_other/animation/cont_bg/lbl_count_down_time");

	self:StartCountDownTimer();

    self:UpdateUi();
end

function Funzion2MatchUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    for i=1,10 do
    	local cont = self.playerCont[i];
		if i==8 then
			local info = g_dataCenter.player;
			cont.labName:set_text(info.name);
			cont.head = UiPlayerHead:new({parent = cont.objHead,roleId=info.image});
			cont.objSelf:set_active(true);
			cont.objPoint:set_active(false);
			cont.labState:set_text("");
		else
			cont.labName:set_text("");
			cont.head = UiPlayerHead:new({parent = cont.objHead});
			cont.objPoint:set_active(true);
			cont.objSelf:set_active(false);
		end
    end
end

function Funzion2MatchUI:DestroyUi()
    self:StopCountDownTimer()

    if self.playerCont then
	    for k,v in pairs(self.playerCont) do
	    	v.head:DestroyUi();
	    end
	    self.playerCont = nil;
	end

    UiBaseClass.DestroyUi(self);
end
-- 开始倒计时
function Funzion2MatchUI:StartCountDownTimer()
	if self.ui then
		self.timer = timer.create(self.bindfunc["on_count_down_timer"], 1000, -1)
		self:UpdateUi()
	end
end

-- 停止倒计时
function Funzion2MatchUI:StopCountDownTimer()
	if self.timer then
		timer.stop(self.timer)
		self.timer = nil
	end
end
-------------------------------------本地回调-------------------------------------

--取消匹配按钮
function Funzion2MatchUI:on_cancel_btn(t)
	msg_daluandou2.cg_cancel_match(g_dataCenter.fuzion2.roomid)
end

--倒计时回调
function Funzion2MatchUI:on_count_down_timer()
	self.curCount = math.max(self.curCount - 1, 0)
	if self.labTime then
		self.labTime:set_text("倒计时 "..self.curCount.."s")
	end

	if self.curCount == 0 then
		self:StopCountDownTimer()
	end
end

function Funzion2MatchUI:gc_cancel_match()
	uiManager:PopUi();
end

function Funzion2MatchUI:gc_match_finish()
	-- self:SetReady(true);
	uiManager:PopUi(nil,true);
end

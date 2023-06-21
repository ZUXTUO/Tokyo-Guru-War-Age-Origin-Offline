OtherGuildPanel = Class('OtherGuildPanel',UiBaseClass)

local _local = {}
_local.resPath = "assetbundles/prefabs/ui/rank/ui_404_rank_window.assetbundle"

_local.UIText = {
	[1] = "ID ",
	[2] = "总战力 ",
	[3] = "区域 ",
	[4] = "社长 ",
	[5] = "人数 ",
	[6] = "排名 ",
	[7] = "社长很懒，未发布公告。",
}
--[[显示社团简要信息面板，通过searchid或者已经解析出的查询id，需要服务器返回数据]]
function OtherGuildPanel.ShowGuildbyId(guildId, ranking, allpower)
	if OtherGuildPanel.instance == nil then
		OtherGuildPanel.instance = OtherGuildPanel:new();
	end

	-- 社团信息里已有
	-- local instance = OtherGuildPanel.instance
	-- instance.ranking = ranking;
	-- instance.allpower = allpower;

	guildId = tonumber(guildId) or 0;
	if guildId > 65535 then 
		guildId = Guild.GetVisibleId(guildId);
	end 
	msg_guild.cg_look_for_guild(guildId);
	if OtherGuildPanel.instance ~= nil then 
		OtherGuildPanel.instance.loadingId = GLoading.Show(GLoading.EType.msg)
	end 
end
--[[传入已经有的社团对象来显示社团简要信息面板]]
function OtherGuildPanel.ShowGuild(guild)
	if OtherGuildPanel.instance == nil then
		OtherGuildPanel.instance = OtherGuildPanel:new();
	end
	OtherGuildPanel.instance:SetData(guild)
end 

function OtherGuildPanel.Destroy()
	if OtherGuildPanel.instance then
		OtherGuildPanel.instance:DestroyUi()
		OtherGuildPanel.instance = nil
	end
end

function OtherGuildPanel:Init(data)
    self.pathRes = _local.resPath;
	UiBaseClass.Init(self,data);
end

function OtherGuildPanel:InitData(data)
    UiBaseClass.InitData(self, data);
    --self.msg = nil;
end

function OtherGuildPanel:SetData(data)
	self.guild = data
	self:UpdateUI()
end

--重新开始
function OtherGuildPanel:Restart(data)
    UiBaseClass.Restart(self, data);
end

function OtherGuildPanel:RegistFunc()
    self.bindfunc['on_main_ui_loaded'] = Utility.bind_callback(self, self.on_main_ui_loaded);
	self.bindfunc['load_main_ui'] = Utility.bind_callback(self, self.___LoadUI);
	self.bindfunc['on_other_guild_info_receive'] = Utility.bind_callback(self, self.on_other_guild_info_receive);
	self.bindfunc['on_btn_close_click'] = Utility.bind_callback(self,self.on_btn_close_click);
	self.bindfunc['on_join_click'] = Utility.bind_callback(self,self.on_join_click);
end

function OtherGuildPanel:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_name('other_guild_panel');
	self.ui:set_active(false);
	self.vs = {};
	self.vs.btnClose = ngui.find_button(self.ui,"btn_cha");
	self.vs.btnClose:set_on_click(self.bindfunc['on_btn_close_click']);
	--self.vs.roomframe = self.ui:get_child_by_name("centre_other/animation/sp_frame");
	self.vs.iconTexture = ngui.find_texture(self.ui,"centre_other/animation/texture");
	self.vs.labName = ngui.find_label(self.ui,"centre_other/animation/container/lab_name");
	self.vs.labDesc = ngui.find_label(self.ui,"centre_other/animation/container/lab_describe");
	self.vs.labID = ngui.find_label(self.ui,"centre_other/animation/container/cont/lab1");
	-- self.vs.labArea = ngui.find_label(self.ui,"centre_other/animation/container/cont/lab2");
	self.vs.labLeader = ngui.find_label(self.ui,"centre_other/animation/container/cont/lab2");
	self.vs.labMemNum = ngui.find_label(self.ui,"centre_other/animation/container/cont/lab3");
	self.vs.labRank = ngui.find_label(self.ui,"centre_other/animation/container/cont/lab4");
	self.vs.labAllPower = ngui.find_label(self.ui,"centre_other/animation/container/cont/sp_fight/lab_fight");
	self.vs.btnJoin = ngui.find_button(self.ui,"centre_other/animation/btn_get");
	self.vs.labJoin = ngui.find_label(self.ui, "centre_other/animation/btn_get/animation/lab")
	self.vs.btnJoin:set_on_click(self.bindfunc['on_join_click']);
	self.vs.labName:set_text("");
	self.vs.labDesc:set_text("");
	self.vs.labID:set_text("");
	-- self.vs.labArea:set_text("");
	self.vs.labLeader:set_text("");
	self.vs.labMemNum:set_text("");
	self.vs.labAllPower:set_text("");
	self.vs.labRank:set_text("");
	--self.vs.roomframe:set_active(false);
	if self.guild ~= nil then 
		self:UpdateUI();
	end
end 

function OtherGuildPanel:on_join_click()
	local dataCenter = g_dataCenter.guild;
	if dataCenter.myGuildId ~= nil and dataCenter.myGuildId ~= "0" then 
		FloatTip.Float("您已加入了社团，请先退出社团再加入新的社团")
	else
		if self.guild.id then
			if dataCenter.applyGuildId ~= "0" then
				local cbfunc = function ()
					msg_guild.cg_apply_join(self.guild.id)
					self:Hide();
					self:DestroyUi();
					OtherGuildPanel.Destroy();
				end
				HintUI.SetAndShowNew(EHintUiType.two,"加入社团","点击将取消之前已经提交的社团申请，是否继续？", nil,
					{str = "确定", func = cbfunc},
					{str = "取消"});
			else
				msg_guild.cg_apply_join(self.guild.id)
				self:Hide();
				self:DestroyUi();
				OtherGuildPanel.Destroy();
			end
		end
	end
end 

function OtherGuildPanel:UpdateUI()
	if self.vs == nil or self.guild == nil then 
		do return end;
	end
	local dataCenter = g_dataCenter.guild;
	if dataCenter.myGuildId == self.guild.id then 
		self.vs.btnJoin:set_enable(false);
		PublicFunc.SetUILabelEffectGray(self.vs.labJoin)
	end 
	--self.vs.roomframe:set_active(true);
	self.vs.labName:set_text(self.guild.name);
	self.vs.labLeader:set_text(_local.UIText[4]..PublicFunc.GetColorText(self.guild.leaderName, "green"));
	local content = self.guild.declaration
	if content == "" then content = _local.UIText[7] end
	self.vs.labDesc:set_text(content);
	self.vs.labID:set_text(_local.UIText[1]..PublicFunc.GetColorText(tostring(self.guild.searchid), "green"));
	local strMemNum = tostring(self.guild.membersNum).."/"..tostring(Guild.GetMemberLimit(self.guild))
	self.vs.labMemNum:set_text(_local.UIText[5]..PublicFunc.GetColorText(strMemNum, "green"));
	local config = ConfigManager.Get(EConfigIndex.t_country_info, self.guild.countryid) or {};
	-- self.vs.labArea:set_text(_local.UIText[3]..PublicFunc.GetColorText(tostring(config.name), "green"));
	self.vs.labAllPower:set_text(tostring(self.guild.totalFight));
	self.vs.labRank:set_text(_local.UIText[6]..PublicFunc.GetColorText(tostring(self.guild.rank), "green"));
	local iconPath = ConfigManager.Get(EConfigIndex.t_guild_icon,self.guild.icon).icon;
	self.vs.iconTexture:set_texture(iconPath);
	if dataCenter.myGuildId ~= nil and dataCenter.myGuildId ~= "0" then 
		self.vs.btnJoin:set_active(false);
	end
	self.ui:set_active(true);
end 

function OtherGuildPanel:on_other_guild_info_receive(result,simpleData)
	if result == 0 then 
		self.guild = GuildSimple:new(simpleData);
		self.allpower = simpleData.fightValue
		self:UpdateUI();
		GLoading.Hide(GLoading.EType.msg, self.loadingId);
	else 
		GLoading.Hide(GLoading.EType.msg, self.loadingId);
		self:on_btn_close_click();
		--FloatTip.Float(ConfigManager.Get(EConfigIndex.t_error_code_cn,result));
	end
end 

function OtherGuildPanel:on_btn_close_click()
	self:Hide();
	self:DestroyUi();

	OtherGuildPanel.Destroy()
end

--析构函数
function OtherGuildPanel:DestroyUi()
	self.allpower = nil
	self.ranking = nil
	self.guild = nil

	if self.vs then
		self.vs.iconTexture:Destroy()
    	self.vs = nil
	end
    UiBaseClass.DestroyUi(self);
    --Root.DelUpdate(self.Update, self)
end

--显示ui
function OtherGuildPanel:Show()
    UiBaseClass.Show(self);
end

--隐藏ui
function OtherGuildPanel:Hide()
    UiBaseClass.Hide(self);
end

--注册消息分发回调函数
function OtherGuildPanel:MsgRegist()
    UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_look_for_guild,self.bindfunc["on_other_guild_info_receive"]);
end

--注销消息分发回调函数
function OtherGuildPanel:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_look_for_guild,self.bindfunc["on_other_guild_info_receive"]);
end
--[[
region friend_info_ui.lua
date: 2016-7-12
time: 16:35:44
author: Nation
]]
FriendInfoUI = Class('FriendInfoUI', UiBaseClass);
function FriendInfoUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/friend/ui_008_friend.assetbundle";
    
    UiBaseClass.Init(self, data);
end

function FriendInfoUI:Clear()
	self.btn_close = nil
	self.show_friend = nil
	self.head_info = nil
	self.btn_del_friend = nil
	self.btn_add_blacklist = nil
	self.btn_whisper = nil
	self.lab_name = nil
	self.lab_lv = nil
	self.lab_fight_value = nil
end

function FriendInfoUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function FriendInfoUI:Restart(data)
	self:Clear()
	self.show_friend = data
    UiBaseClass.Restart(self, data);
end

function FriendInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
    self.bindfunc["on_btn_del_friend"] = Utility.bind_callback(self, self.on_btn_del_friend);
    self.bindfunc["on_btn_add_blacklist"] = Utility.bind_callback(self, self.on_btn_add_blacklist);
    self.bindfunc["on_btn_whisper"] = Utility.bind_callback(self, self.on_btn_whisper);
end

function FriendInfoUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

function FriendInfoUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function FriendInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d())
	self.ui:set_local_scale(1,1,1)
    self.ui:set_local_position(0,0,0)
	self.ui:set_name("friend_info_ui")
	self.btn_close = ngui.find_button(self.ui, "center_other/animation/content_di_754_458/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_btn_close"]);
	self.btn_del_friend = ngui.find_button(self.ui, "center_other/animation/content/cont_btn/btn1");
	self.btn_del_friend:set_on_click(self.bindfunc["on_btn_del_friend"]);

	self.btn_add_blacklist = ngui.find_button(self.ui, "center_other/animation/content/cont_btn/btn2");
	self.btn_add_blacklist:set_on_click(self.bindfunc["on_btn_add_blacklist"]);

	self.btn_whisper = ngui.find_button(self.ui, "center_other/animation/content/cont_btn/btn3");
	self.btn_whisper:set_on_click(self.bindfunc["on_btn_whisper"]);
	local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(self.show_friend)
	if not friend_data then
		return
	end

	self.lab_name = ngui.find_label(self.ui, "center_other/animation/content/cont_com/lab_name");
	self.lab_name:set_text(friend_data.name)
	self.lab_lv = ngui.find_label(self.ui, "center_other/animation/content/cont_com/cont_level/lab");
	self.lab_lv:set_text(tostring(friend_data.level));
	self.lab_fight_value = ngui.find_label(self.ui, "center_other/animation/content/sp_fight/lab_fight");
	self.lab_fight_value:set_text(""..friend_data.fight_value)
	self.lab_guild = ngui.find_label(self.ui, "center_other/animation/content/cont_com/cont_guild/lab");
	if friend_data.guild_name ~= "" then
		self.lab_guild:set_text(""..friend_data.guild_name)
	else
		self.lab_guild:set_text("无")
	end
	-- self.lab_country = ngui.find_label(self.ui, "center_other/animation/content/cont_com/cont_area/lab");
	-- if friend_data.country_id == nil or friend_data.country_id == 0 then
	-- 	self.lab_country:set_text("无")
	-- else
	-- 	local name = ConfigManager.Get(EConfigIndex.t_country_info, friend_data.country_id).name;
	-- 	self.lab_country:set_text(name)
	-- end
	local big_card_item_80 = self.ui:get_child_by_name("center_other/animation/content/sp_head_di_item");
	local card_info = CardHuman:new({number=friend_data.image, level=friend_data.level});
	self.head_info = SmallCardUi:new({parent=big_card_item_80, stypes={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}, info=card_info})
end

function FriendInfoUI:Update(dt)
    if not UiBaseClass.Update(self, dt) then
        return
    end
end

function FriendInfoUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function FriendInfoUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return false;
    end
    return true;
end

function FriendInfoUI:on_btn_close()
    uiManager:PopUi()
end

function FriendInfoUI:on_btn_del_friend()
	local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(self.show_friend)
	if not friend_data then
		return
	end
    local btn1 = {str = gs_string_friend["confirm"], 
        func = function()
           	local vecDel = {}
			vecDel[1] = self.show_friend
			msg_friend.cg_del_friend(vecDel)
			uiManager:PopUi()
        end
    };
    local btn2 = {str = gs_string_friend["cancel"]};
    HintUI.SetAndShow(EHintUiType.two, string.format(gs_string_friend["ask_del_single_friend"], friend_data.name), btn1, btn2)
end

function FriendInfoUI:on_btn_add_blacklist()
	local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(self.show_friend)
	if not friend_data then
		return
	end
    local btn1 = {str = gs_string_friend["confirm"], 
        func = function()
           	msg_friend.cg_add_black_list(self.show_friend)
			uiManager:PopUi()
        end
    };
    local btn2 = {str = gs_string_friend["cancel"]};
    HintUI.SetAndShow(EHintUiType.two, string.format(gs_string_friend["ask_add_blacklist"], friend_data.name), btn1, btn2)
end

function FriendInfoUI:on_btn_whisper()
	--uiManager:SetStackSize(1)
	local friend_data = g_dataCenter.friend:GetFriendDataByPlayerGID(self.show_friend)
	if friend_data then
		uiManager:PopUi()
		local data = {
			playerId = friend_data.friend_gid, playerName = friend_data.name, showType = PublicStruct.Chat.whisper,
			vip = friend_data.vip_level, image = friend_data.image,
		}
		ChatUI.SetAndShow(data)
	end
end
--[[endregion]]
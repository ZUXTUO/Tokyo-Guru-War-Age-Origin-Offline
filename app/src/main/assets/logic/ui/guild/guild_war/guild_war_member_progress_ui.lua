
GuildWarMemberProgressUI = Class('GuildWarMemberProgressUI', UiBaseClass)

function GuildWarMemberProgressUI.Start()
    if GuildWarMemberProgressUI.cls == nil then
        GuildWarMemberProgressUI.cls = GuildWarMemberProgressUI:new()
    end
end

function GuildWarMemberProgressUI.End()
    if GuildWarMemberProgressUI.cls then
        GuildWarMemberProgressUI.cls:DestroyUi()
        GuildWarMemberProgressUI.cls = nil
    end
end

---------------------------------------华丽的分隔线--------------------------------------

local _UIText = {
}

function GuildWarMemberProgressUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/guild/guild_war/ui_3807_guild_war.assetbundle"
	UiBaseClass.Init(self, data)
end

function GuildWarMemberProgressUI:InitData(data)
    self.wrapItem = {}
    self.data = nil
	UiBaseClass.InitData(self, data)    
end

function GuildWarMemberProgressUI:DestroyUi()    
	UiBaseClass.DestroyUi(self)    
    self.data = nil
end

-- 注册消息分发回调函数
function GuildWarMemberProgressUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_guild_war.gc_get_guild_deployment_info, self.bindfunc['gc_get_guild_deployment_info']);
end

-- 注销消息分发回调函数
function GuildWarMemberProgressUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_guild_war.gc_get_guild_deployment_info, self.bindfunc['gc_get_guild_deployment_info']);
end


function GuildWarMemberProgressUI:RegistFunc()
	UiBaseClass.RegistFunc(self)
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["gc_get_guild_deployment_info"] = Utility.bind_callback(self,self.gc_get_guild_deployment_info)
end

function GuildWarMemberProgressUI:on_btn_close()
    GuildWarMemberProgressUI.End()
end

function GuildWarMemberProgressUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_war_member_progress")

    local path = "centre_other/animation/"

    local btnClose = ngui.find_button(self.ui, path .. "btn_close")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])    

    self.scrollView = ngui.find_scroll_view(self.ui, path .. "scrollview")
    self.wrapContent = ngui.find_wrap_content(self.ui, path .. "scrollview/wrapcontent")
    self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])
    self.wrapContent:set_max_index(0)
    self:UpdateUi()
end

function GuildWarMemberProgressUI:on_init_item(obj, b, real_id)
    local row = math.abs(real_id) + 1
    --local row = math.abs(b) + 1 

    if self.wrapItem[row] == nil then
        local item = {}
        item.objHead = obj:get_child_by_name("sp_head_di_item")

        item.lblName = ngui.find_label(obj, "sp_name_bg/lbl_name")
        item.lblLevel = ngui.find_label(obj, "lbl_level")

        item.lblJob = ngui.find_label(obj, "lbl1")
        item.lblDefenceNum = ngui.find_label(obj, "lbl2")
        item.lblAttackNum = ngui.find_label(obj, "lbl3")

        item.lblGoldBuff = ngui.find_label(obj, "lbl4")
        item.lblCrystalBuff = ngui.find_label(obj, "lbl5")

        self.wrapItem[row] = item
    end

    local item = self.wrapItem[row]
    local data = self.data[row]
    if data then
        item.lblName:set_text(data.name)
        item.lblLevel:set_text("LV."..tostring(data.level))
        item.lblJob:set_text(Guild.GetJobName(data.post))
        item.lblDefenceNum:set_text(tostring(data.guardTeamCount))
        item.lblAttackNum:set_text(tostring(data.attackTeamCount))
        item.lblGoldBuff:set_text(tostring(data.buyGoldBuffTimes).."/"..tostring(ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1).gold_times))
        item.lblCrystalBuff:set_text(tostring(data.buyCrystalBuffTimes).."/"..tostring(ConfigManager.Get(EConfigIndex.t_guild_war_discrete,1).crystal_times))
        if item.head_info == nil then
            item.head_info = UiPlayerHead:new({parent=item.objHead});
        end
        item.head_info:SetRoleId(tonumber(data.playerImage));
    end
end


function GuildWarMemberProgressUI:UpdateUi()
    if self.data == nil then
        msg_guild_war.cg_get_guild_deployment_info()
    else
        self.wrapContent:set_min_index(1-#self.data)
        self.wrapContent:reset()    
    end
end


function GuildWarMemberProgressUI:gc_get_guild_deployment_info(ret,info)
    self.data = info
    self:UpdateUi();
    -- --TODO ..
    -- self.data =  {
    --     [1] = {
    --         pid = "123123213213",
    --         name = "我是大帅哥",
    --         level = "99",
    --         heroIcon = "",
    --         post = "",
    --         guardTeamCount = 9,
    --         attackTeamCount = 8,
    --         buyGoldBuffTimes = 7,
    --         buyCrystalBuffTimes = 6,
    --     }
    -- }
end
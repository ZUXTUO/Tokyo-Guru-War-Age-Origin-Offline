ArenaAchieveRankFriendUI = Class("ArenaAchieveRankFriendUI", UiBaseClass)

local _local = {}
_local.UIText = {
    [1] = "达到%s的好友",
}

function ArenaAchieveRankFriendUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/wanfa/arena/ui_4408_jjc_tc.assetbundle";
	UiBaseClass.Init(self, data);
end

function ArenaAchieveRankFriendUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function ArenaAchieveRankFriendUI:Restart(data)
	UiBaseClass.Restart(self, data);
end

function ArenaAchieveRankFriendUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close)
end

function ArenaAchieveRankFriendUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_arena_achieve_rank_friend");

    self.uiCards = {}

    local labTitle = ngui.find_label(self.ui, "lab_title2")
    local btnClose = ngui.find_button(self.ui, "btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])
    
    local data = self:GetInitData()
    labTitle:set_text(string.format(_local.UIText[1], data.rank))

    local path = "centre_other/animation/grid/"
    local friends = data.friends or {}
    for i=1, 8 do
        local objParent = self.ui:get_child_by_name(path.."sp_head_di_item"..i)
        local labHeroName = ngui.find_label(objParent, "lab_name")
        
        if friends[i] then
            labHeroName:set_text(friends[i].name)
            if not self.uiCards[i] then
                self.uiCards[i] = UiPlayerHead:new({parent=objParent,roleId=friends[i].image,vip=friends[i].vip_level})
            else
                self.uiCards[i]:SetRoleId(friends[i].image)
                self.uiCard[i]:SetVipLevel(friends[i].vip_level)
            end
        else
            labHeroName:set_active(false)
        end
    end
end

function ArenaAchieveRankFriendUI:DestroyUi()
    if self.uiCards then
        for i, uiCard in pairs(self.uiCards) do
            uiCard:DestroyUi()
        end
        self.uiCards = nil
    end
    UiBaseClass.DestroyUi(self);
end

function ArenaAchieveRankFriendUI:on_btn_close()
    uiManager:PopUi()
end

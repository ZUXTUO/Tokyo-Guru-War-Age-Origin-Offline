EquipItemUI2 = Class("EquipItemUI");

--[[
    obj         item对象
    equip_atlas 装备图集管理池
    huamn_atlas 人物头像管理池
]]
function EquipItemUI2:Init(data)
    self:initData(data);
    self:Restart();
end

function EquipItemUI2:Restart()
    self:registFunc();
end

function EquipItemUI2:registFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, EquipItemUI.on_click);
end

function EquipItemUI2:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function EquipItemUI2:initData(data)
    self.bindfunc = {};
    self.EquipAtlas = data.equip_atlas;
    self.HumanAtlas = data.huamn_atlas;
    self.star = {};
    self.chose = nil;
    self.callback =nil;
    self.info = nil;
    self.recommend = nil;
    self.huamHead = nil;
    self.spHuamHead = nil;
end

function EquipItemUI2:DestroyUi()
    self:unregistFunc();
    self.ui = nil;
    self.star = {};
    self.callback =nil;
    self.chose = nil;
    self.info = nil;
    self.recommend = nil;
    self.huamHead = nil;
    self.spHuamHead = nil;
end

-- 初始化UI
function EquipItemUI2:initItem()
    local btn = ngui.find_button(self.ui,"battle_item");
    btn:reset_on_click();
    btn:set_on_click(self.bindfunc["on_click"]);
    self.sp = ngui.find_sprite(self.ui,"bk/sp_equip");
    self.level = ngui.find_label(self.ui,"lab_level");
    self.name = ngui.find_label(self.ui,"lab_equip_name");
    for i=1,5 do
        self.star[i] = ngui.find_sprite(self.ui,"star/star_di"..i.."/star");
    end
    self.chose = ngui.find_sprite(self.ui,"sp_shine");
    self.chose:set_active(false);
    self.recommend = ngui.find_sprite(self.ui,"sp_recommend");
    -- self.huamHead = ngui.find_sprite(self.ui,"di");
    self.spHuamHead = ngui.find_sprite(self.ui,"di/head");
end

function EquipItemUI2:SetInfo(card_info,obj)
    self.info = card_info;
    self.ui = obj;
    self:initItem();
    for i=1,5 do
        if i > self.info.star then
            self.star[i]:set_active(false);
        else
            self.star[i]:set_active(true);
        end
    end
    self.name:set_text(self.info.name);
    self.level:set_text(tostring(self.info.level));
    self.EquipAtlas:SetIcon(self.sp,self.info.number);
    self.recommend:set_active(false);
    -- TODO:[lhf] 设置拥有者头像
    -- self.huamHead:set_active(false);
end

function EquipItemUI2:on_click()
    if self.callback then
        _G[self.callback](self,self.info);
    end
end

function EquipItemUI2:ChoseItem(is_chose)
    self.chose:set_active(is_chose);
end

function EquipItemUI2:SetCallback(callback)
    self.callback = callback;
end

function EquipItemUI2:Show()
    if self.ui then
        self.ui:set_active(true);
    end
end

function EquipItemUI2:Hide()
    if self.ui then
        self.ui:set_active(false);
    end
end

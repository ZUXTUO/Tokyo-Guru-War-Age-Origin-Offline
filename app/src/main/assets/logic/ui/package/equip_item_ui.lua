EquipItemUI = Class("EquipItemUI");

--[[
    obj         item对象
    -- equip_atlas 装备图集管理池
    -- huamn_atlas 人物头像管理池
]]
function EquipItemUI:Init(data)
    self:InitData(data);
    self:Restart();
end

function EquipItemUI:Restart()
    self:RegistFunc();
    self:initItem();
end

function EquipItemUI:RegistFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, EquipItemUI.on_click);
end

function EquipItemUI:UnRegistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function EquipItemUI:InitData(data)
    self.bindfunc = {};
    self.ui = data.obj;
    -- self.EquipAtlas = data.equip_atlas;
    self.star = {};
    self.chose = nil;
    self.callback =nil;
    self.info = nil;
    self.recommend = nil;
    self.humanHead = nil;
    -- self.spHuamHead = nil;
    self.sp = nil;
    self.level = nil;
    self.name = nil;
    self.spLetter = nil;
end

function EquipItemUI:DestroyUi()
    self:UnRegistFunc();
    self.ui = nil;
    self.star = {};
    self.callback =nil;
    self.callbackParam = nil;
    self.chose = nil;
    self.info = nil;
    self.recommend = nil;
    if self.humanHead then
        self.humanHead:DestroyUi();
        self.humanHead = nil;
    end
    -- if self.spHuamHead then
    --     self.spHuamHead:Destroy();
    -- end
    -- self.spHuamHead = nil;
    if self.sp then
        self.sp:Destroy();
    end
    self.sp = nil;
    self.level = nil;
    self.name = nil;
    self.spLetter = nil;
    self.btn = nil;
end

-- 初始化UI
function EquipItemUI:initItem()
    if not self.ui then return end;
    self.btn = ngui.find_button(self.ui,"sp_di");
    self.btn:reset_on_click();
    self.btn:set_on_click(self.bindfunc["on_click"]);

    if self.sp then
        self.sp:Destroy();
    end
    self.sp = ngui.find_texture(self.ui,"sp_touxiangkuang/sp_equip");
    self.spFrame = ngui.find_sprite(self.ui,"sp_touxiangkuang/sp_frame");
    self.level = ngui.find_label(self.ui,"lab_level");
    self.name = ngui.find_label(self.ui,"lab_equip_name");
    for i=1,5 do
        self.star[i] = ngui.find_sprite(self.ui,"star/star_di"..i.."/sp_star");
    end
    self.chose = ngui.find_sprite(self.ui,"sp_shine");
    self.chose:set_active(false);
    self.spLetter = ngui.find_sprite(self.ui,"sp_letter");

    local obj = self.ui:get_child_by_name("sp_human_di");
    self.humanHead = SmallCardUi:new({obj=obj});
    -- if self.spHuamHead then
    --     self.spHuamHead:Destroy();
    -- end
    -- self.spHuamHead = ngui.find_texture(self.ui,"sp_human_di/sp_human");
    -- self.spHuamFrame = ngui.find_sprite(self.ui,"sp_human_di/sp_frame");

    self.spRecommend = ngui.find_sprite(self.ui,"sp_recommend");
    self.spRecommend:set_active(false);
end

function EquipItemUI:SetInfo(card_info,obj)
    self.info = card_info;
    if obj then
        self.ui = obj;
        self:initItem();
    end
    self:UpdateUi();
end

function EquipItemUI:UpdateUi()
    if not self.ui then return end;
    if self.info then
        for i=1,5 do
            if i > self.info.star then
                self.star[i]:set_active(false);
            else
                self.star[i]:set_active(true);
            end
        end
        self.name:set_text(self.info.name);
        PublicFunc.SetIconFrameSprite(self.spFrame,self.info.rarity);
        self.level:set_text("Lv."..tostring(self.info.level));
        self.sp:set_active(true);
        self.sp:set_texture(self.info.config.small_icon);
        -- self.EquipAtlas:SetIcon(self.sp,self.info.number);
        PublicFunc.SetEquipRaritySprite(self.spLetter,self.info.rarity);
        if self.info.roleid and tonumber(self.info.roleid) ~= 0 then 
            local info = g_dataCenter.package:find_card(1,self.info.roleid);
            self.humanHead:Show();
            self.humanHead:SetData(info);
            self.humanHead:ShowOnlyPic();
            -- self.spHuamHead:set_texture(info.config.small_icon);
            -- self.EquipAtlas:SetIcon(self.spHuamHead,info.number);
            -- PublicFunc.SetIconFrameSprite(self.spHuamFrame,info.rarity);
        else
            self.humanHead:Hide();
        end
    else
        for i=1,5 do
            self.star[i]:set_active(false);
        end
        self.name:set_text("");
        PublicFunc.SetIconFrameSprite(self.spFrame,0);
        self.level:set_text("");
        self.sp:set_active(false);
        PublicFunc.SetEquipRaritySprite(self.spLetter,0);
        self.humanHead:Hide();
    end
end

function EquipItemUI:on_click()
    if self.callback then
        _G[self.callback](self,self.info,self.callbackParam);
    end
end

function EquipItemUI:ChoseItem(is_chose)
    self.chose:set_active(is_chose);
end

function EquipItemUI:SetCallback(callback, param)
    self.callback = callback;
    self.callbackParam = param;
end

function EquipItemUI:SetRecommend(is_recommend)
    self.spRecommend:set_active(is_recommend);
end

function EquipItemUI:Show()
    if self.ui then
        self.ui:set_active(true);
    end
end

function EquipItemUI:Hide()
    if self.ui then
        self.ui:set_active(false);
    end
end
HeroTrialSignBoxUI = Class('HeroTrialSignBoxUI', UiBaseClass);

local _UIText = {
    [1] = "累计完成[00c0ff]%s[-]天挑战可获得"
}

-- 初始化
function HeroTrialSignBoxUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/level/ui_703_level.assetbundle';
    UiBaseClass.Init(self, data)
end

function HeroTrialSignBoxUI:RestartData(data)
    if data then
        self.data = data
    end
end

-- 析构函数
function HeroTrialSignBoxUI:DestroyUi()
    if self.itemUi then
        for k, v in pairs(self.itemUi) do
            v:DestroyUi();
        end
        self.itemUi = nil;
    end
    UiBaseClass.DestroyUi(self)
end

-- 注册回调函数
function HeroTrialSignBoxUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['OnBtnClose'] = Utility.bind_callback(self, HeroTrialSignBoxUI.OnBtnClose);
end

-- 寻找ngui对象
function HeroTrialSignBoxUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('hero_trial_sign_box_ui');

    -- self.labTitle = ngui.find_label(self.ui, "lab_title");
    self.ui:get_child_by_name("cont2"):set_active(false)
    self.ui:get_child_by_name("btn"):set_active(false)
    self.nodeCont1 = self.ui:get_child_by_name("cont1");
    self.labCondition1 = ngui.find_label(self.nodeCont1, "txt");
    self.spAlreadyGet = ngui.find_sprite(self.ui, "sp_art_font");
    self.grid = ngui.find_grid(self.ui, "grid");
    self.itemUi = {};
    for i = 1, 4 do
        local objParent = self.ui:get_child_by_name("new_small_card_item"..i);
        self.itemUi[i] = UiSmallItem:new({obj = nil, parent = objParent, cardInfo = nil, is_enable_goods_tip = true});
    end
    self.btnClose = ngui.find_button(self.ui, "btn_cha");
    self.btnClose:set_on_click(self.bindfunc['OnBtnClose']);
    self:UpdateUi();
end
-- 更新ui
function HeroTrialSignBoxUI:UpdateUi()
    if self.ui == nil then return end

    local config = ConfigManager.Get(EConfigIndex.t_hero_trial_week_awards, self.data.index)
    self.labCondition1:set_text(string.format(_UIText[1], config.day))
    if self.data.got then
        self.spAlreadyGet:set_active(true)
    else
        self.spAlreadyGet:set_active(false)
    end

    for i, itemUi in ipairs(self.itemUi) do
        local data = config.drop_awards[i]
        if data then
            itemUi:SetDataNumber(data.id, data.num)
            itemUi:Show()
        else
            itemUi:Hide()
        end
    end
end

function HeroTrialSignBoxUI:OnBtnClose(t)
    uiManager:PopUi();
end

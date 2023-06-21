
AwardPreviewUI = Class("AwardPreviewUI", UiBaseClass)

function AwardPreviewUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/level/ui_703_level.assetbundle"
	UiBaseClass.Init(self, data)
end

function AwardPreviewUI:InitData(data)
	UiBaseClass.InitData(self, data) 
    self.itemObj = {}
    self.smallItemUi = {}
    self.itemNameUi = {}
    self.awardData = data
end

function AwardPreviewUI:DestroyUi()
	UiBaseClass.DestroyUi(self)    
    for _, v in pairs(self.smallItemUi) do
        if v then
            v:DestroyUi()
            v = nil
        end
    end
    self.smallItemUi = {}
end

function AwardPreviewUI:Restart(data)
    self:InitData(data)
    if UiBaseClass.Restart(self, data) then
        self.awardData = data
    end
end

function AwardPreviewUI:ShowNavigationBar()
    return false
end

function AwardPreviewUI:RegistFunc()
	UiBaseClass.RegistFunc(self)    
    self.bindfunc['on_close'] = Utility.bind_callback(self, self.on_close)    
end

function AwardPreviewUI:on_close()

    uiManager:PopUi()
end

function AwardPreviewUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_preview")

   

    -- local lblInfo = ngui.find_label(self.ui, "lab_donw")
    -- lblInfo:set_active(false)

    -- local btnMark = ngui.find_button(self.ui, "mark")
    -- btnMark:reset_on_click()
    -- btnMark:set_on_click(self.bindfunc["on_close"])
    local resPath = "centre_other/animation/";

    self.cont1 = self.ui:get_child_by_name(resPath.."cont1");
    if self.cont1 then
        self.cont1:set_active(false);
    end
    self.cont2 = self.ui:get_child_by_name(resPath.."cont2");
    if self.cont2 then
        self.cont2:set_active(false);
    end

    self.lab_tittle = ngui.find_label(self.ui, resPath .. "content_di_754_458/lab_title");
    self.lab_tittle:set_text("活动");

    self.close_btn = ngui.find_button(self.ui, resPath .. "btn");
    self.close_btn:reset_on_click();
    self.close_btn:set_on_click(self.bindfunc["on_close"]);
    local close_btn_lab = ngui.find_label(self.ui, resPath .. "btn/lab");
    close_btn_lab:set_text("关闭");
    self.close_btn:set_active(false);

    self.cha_btn = ngui.find_button(self.ui, resPath .. "content_di_754_458/btn_cha");
    self.cha_btn:reset_on_click();
    self.cha_btn:set_on_click(self.bindfunc["on_close"]);

    self.sp_art_font = ngui.find_sprite(self.ui, resPath .. "sp_art_font");
    self.sp_art_font:set_active(false);

    self.sp_star = ngui.find_sprite(self.ui, resPath .. "sp_star");
    self.sp_star:set_active(false);

    self.txt = ngui.find_label(self.ui, resPath .. "txt");
    self.txt:set_active(false);

    self.grid = ngui.find_grid(self.ui, resPath .. "grid");
    for i = 1, 4 do
        local new_small_card_item = self.ui:get_child_by_name(resPath .. "grid/new_small_card_item" .. i);
        local ad = self.awardData[i] 
        if ad and ad.id and ad.id ~= 0 then 
            new_small_card_item:set_active(true);
            self.smallItemUi[i] = UiSmallItem:new({obj = nil, parent = new_small_card_item, cardInfo = nil, delay = 400})
            self.smallItemUi[i]:SetDataNumber(ad.id, ad.count)
        else
            new_small_card_item:set_active(false);
        end
    end

    self.grid:reposition_now();       
end
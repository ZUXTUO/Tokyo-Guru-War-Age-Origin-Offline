MaskRarityUpWnd = Class("MaskRarityUpWnd", MultiResUiBaseClass)

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/mask/ui_906_mask.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _uiText = 
{
    [1] = '点击屏幕任意位置关闭'
}

function MaskRarityUpWnd:Init(data)
    self.pathRes = resPaths

    MultiResUiBaseClass.Init(self, data);
end


function MaskRarityUpWnd:Restart(data)

    self.currentindex = data.index
    self.last_mask_id = data.id

	if UiBaseClass.Restart(self, data) then

	end
end

function MaskRarityUpWnd:RestartData(data)
    CommonClearing.canClose = false
end

function MaskRarityUpWnd:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self);
end

function MaskRarityUpWnd:RegistFunc()
    UiBaseClass.RegistFunc(self);
     self.bindfunc['on_click_close'] = Utility.bind_callback(self, self.on_click_close);
end

--注册消息分发回调函数
function MaskRarityUpWnd:MsgRegist()
    --app.log("MsgRegist===========================")
    UiBaseClass.MsgRegist(self); 
end

--注销消息分发回调函数
function MaskRarityUpWnd:MsgUnRegist()
    --app.log("MsgUnRegist===========================")
    UiBaseClass.MsgUnRegist(self);
end

function MaskRarityUpWnd:InitedAllUI(obj)
    
    local backui = self.uis[resPaths[resType.Back]]
    local tipCloseLabel = ngui.find_label(backui, "txt")
    tipCloseLabel:set_text(_uiText[1])
    local frontParentNode = backui:get_child_by_name("add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    
    self.ui:set_name('ui_mask_raruty_up_wnd');
    self.close = ngui.find_button(backui,"mark")
    self.close:set_on_ngui_click(self.bindfunc['on_click_close'])
    
    local TopTitle = ngui.find_sprite(backui,"sp_art_font")
    TopTitle:set_sprite_name("js_jinjiechenggong")

    self.last_rarity_icon = ngui.find_sprite(backui,"sp_left_effect")
    self.last_rarity_lab = ngui.find_label(backui,"sp_left_effect/lab")

    self.now_rarity_icon = ngui.find_sprite(backui,"sp_right_effect")
    self.now_rarity_lab = ngui.find_label(backui,"sp_right_effect/lab")

    self.last_battle_value = ngui.find_label(backui,"sp_fight/lab_fight")
    
    self.now_battle_value = ngui.find_label(backui,"sp_fight/lab_num")

    --提升属性
    self.up_pro = {}

    for i=1,6 do
        self.up_pro[i] = {}
        self.up_pro[i].obj = backui:get_child_by_name("grid_nature/lab_nature"..i)
        self.up_pro[i].obj:set_active(false)
        self.up_pro[i].title = ngui.find_label(backui,"grid_nature/lab_nature"..i)   --animation/add_content/ui_mask_raruty_up_wnd/sp_fight/lab_num
        self.up_pro[i].last_value = ngui.find_label(backui,"grid_nature/lab_nature"..i.."/lab_num")
        self.up_pro[i].now_value = ngui.find_label(backui,"grid_nature/lab_nature"..i.."/lab")
    end

    self:UpdateUi();

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function MaskRarityUpWnd:UpdateUi()
    local MyMaskData = g_dataCenter.maskitem:get_masklist()
    local CurrentMaskData = MyMaskData[self.currentindex]
    app.log("NowMaskId================="..tostring(CurrentMaskData.number))
    local LastMaskId = self.last_mask_id
    app.log("LastMaskId================"..tostring(LastMaskId))
    local LastMaskData = g_dataCenter.maskitem:get_mask_config(LastMaskId)
    local AddData = g_dataCenter.maskitem:get_now_pro_value(LastMaskId,CurrentMaskData.level)

    --品质
    local now_real_rarity = g_dataCenter.maskitem:get_real_rarity(CurrentMaskData.number)
    local real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity_pz_text(now_real_rarity)

    local last_real_rarity = g_dataCenter.maskitem:get_real_rarity(LastMaskId)
    local last_real_rarity_ui = g_dataCenter.maskitem:get_ui_real_rarity_pz_text(last_real_rarity)

    self.now_rarity_icon:set_sprite_name(real_rarity_ui[1])
    self.now_rarity_lab:set_text(real_rarity_ui[2].." "..real_rarity_ui[3])

    self.last_rarity_icon:set_sprite_name(last_real_rarity_ui[1])
    self.last_rarity_lab:set_text(last_real_rarity_ui[2].." "..last_real_rarity_ui[3])

    for i=1,#AddData do
        self.up_pro[i].obj:set_active(true)
        self.up_pro[i].title:set_text(AddData[i].add_tit)
        self.up_pro[i].last_value:set_text(tostring(AddData[i].now_value))
        self.up_pro[i].now_value:set_text(tostring(AddData[i].add_value))
    end

    local nowvalue = g_dataCenter.player:GetFightValue()
    local lastvale = g_dataCenter.player:GetOldFightValue()
    if lastvale == 0 then
        lastvale = nowvalue
    end

    self.last_battle_value:set_text(tostring(lastvale))
    self.now_battle_value:set_text(tostring(nowvalue))

end

function MaskRarityUpWnd:on_click_close(t)
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    uiManager:PopUi()
end

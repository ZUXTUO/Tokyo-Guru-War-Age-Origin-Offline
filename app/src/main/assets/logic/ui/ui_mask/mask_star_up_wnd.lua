MaskStarUpWnd = Class("MaskStarUpWnd", MultiResUiBaseClass)

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/mask/ui_907_mask.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _uiText = 
{
    [1] = '点击屏幕任意位置关闭'
}

function MaskStarUpWnd:Init(data)
    self.pathRes = resPaths
    
    MultiResUiBaseClass.Init(self, data);
end

function MaskStarUpWnd:Restart(data)

    self.currentindex = data.index
    self.last_mask_id = data.id

	if UiBaseClass.Restart(self, data) then
    
    end
end

function MaskStarUpWnd:RestartData(data)
    CommonClearing.canClose = false
end

function MaskStarUpWnd:DestroyUi()
     MultiResUiBaseClass.DestroyUi(self);
end

function MaskStarUpWnd:RegistFunc()
    UiBaseClass.RegistFunc(self);
     self.bindfunc['on_click_close'] = Utility.bind_callback(self, self.on_click_close);
end

--注册消息分发回调函数
function MaskStarUpWnd:MsgRegist()
    --app.log("MsgRegist===========================")
    UiBaseClass.MsgRegist(self); 
end

--注销消息分发回调函数
function MaskStarUpWnd:MsgUnRegist()
    --app.log("MsgUnRegist===========================")
    UiBaseClass.MsgUnRegist(self);
end

function MaskStarUpWnd:InitedAllUI(obj)
    
    local backui = self.uis[resPaths[resType.Back]]
    local tipCloseLabel = ngui.find_label(backui, "txt")
    tipCloseLabel:set_text(_uiText[1])
    local frontParentNode = backui:get_child_by_name("add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    
    self.ui:set_name('ui_mask_star_up_wnd');
    self.close = ngui.find_button(backui,"mark")
    self.close:set_on_ngui_click(self.bindfunc['on_click_close'])
    
    local TopTitle = ngui.find_sprite(backui,"sp_art_font")
    TopTitle:set_sprite_name("js_tupochenggong")

    self.star_icon = {}
    for i=1,7 do
        self.star_icon[i] = ngui.find_sprite(backui,"grid/sp_prop"..i)
        self.star_icon[i]:set_sprite_name("mjd_yanjing2")
    end

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

    self.last_battle_value = ngui.find_label(backui,"sp_fight/lab_fight")
    
    self.now_battle_value = ngui.find_label(backui,"sp_fight/lab_num")

    self:UpdateUi();

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function MaskStarUpWnd:UpdateUi()
    
    local MyMaskData = g_dataCenter.maskitem:get_masklist()
    local CurrentMaskData = MyMaskData[self.currentindex]
    app.log("NowMaskId================="..tostring(CurrentMaskData.number))
    local LastMaskId = self.last_mask_id
    app.log("LastMaskId================"..tostring(LastMaskId))
    local LastMaskData = g_dataCenter.maskitem:get_mask_config(LastMaskId)
    local AddData = g_dataCenter.maskitem:get_now_pro_star_value(LastMaskId,CurrentMaskData.level)

    local star = g_dataCenter.maskitem:get_mask_config(CurrentMaskData.number).rarity

    for i=1,star do
        self.star_icon[i]:set_sprite_name("mjd_yanjing1")
    end

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

function MaskStarUpWnd:on_click_close(t)
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    uiManager:PopUi()
end

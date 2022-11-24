
UiEquipRarityUpAllResult = Class("UiEquipRarityUpAllResult", MultiResUiBaseClass);


function UiEquipRarityUpAllResult.Start(allCardInfo, ownerCard)
    if UiEquipRarityUpAllResult.cls == nil then
        UiEquipRarityUpAllResult.cls = UiEquipRarityUpAllResult:new({allCardInfo = allCardInfo, ownerCard = ownerCard})
    end
end

function UiEquipRarityUpAllResult.SetFinishCallback(callback, obj)
    if UiEquipRarityUpAllResult.cls then
        UiEquipRarityUpAllResult.cls.callbackFunc = callback
        UiEquipRarityUpAllResult.cls.callbackObj = obj
    end
end

function UiEquipRarityUpAllResult.End()
    if UiEquipRarityUpAllResult.cls then
        UiEquipRarityUpAllResult.cls:DestroyUi()
        UiEquipRarityUpAllResult.cls = nil
    end
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_820_fight.assetbundle',
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle',
}

local _uiText = 
{
	[1] = '点击屏幕任意位置关闭'
}

function UiEquipRarityUpAllResult:Init(data)
	self.pathRes = resPaths
    self.allCardInfo = data.allCardInfo
    self.ownerCard = data.ownerCard

    self.equipCnt = #self.allCardInfo
    self.isAniOver = false
    self.initItemOver = false
    self.isAddEffect = false
	MultiResUiBaseClass.Init(self, data);
end

function UiEquipRarityUpAllResult:RestartData()
    CommonClearing.canClose = false

    MultiResUiBaseClass.RestartData(self)
end

function UiEquipRarityUpAllResult:DestroyUi() 
    if self.equipItem then
        for _, item in pairs(self.equipItem) do
            if item.leftSmallCard then
                item.leftSmallCard:DestroyUi()
                item.leftSmallCard = nil 
            end
            if item.rightSmallCard then
                item.rightSmallCard:DestroyUi()
                item.rightSmallCard = nil 
            end
        end
    end
    self.equipItem = nil
    MultiResUiBaseClass.DestroyUi(self)
end

function UiEquipRarityUpAllResult:RegistFunc()   
    MultiResUiBaseClass.RegistFunc(self)
    self.bindfunc['on_click_mark'] = Utility.bind_callback(self, self.on_click_mark)
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_recive_ani_finish"] = Utility.bind_callback(self, self.on_recive_ani_finish)
end

function UiEquipRarityUpAllResult:UnRegistFunc()
    MultiResUiBaseClass.UnRegistFunc(self);
    PublicFunc.msg_unregist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

function UiEquipRarityUpAllResult:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

function UiEquipRarityUpAllResult:on_click_mark()

    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end
    if self.callbackFunc then
        self.callbackFunc(self.callbackObj)
    end
    UiEquipRarityUpAllResult.End()
end

function UiEquipRarityUpAllResult:InitedAllUI()
    local backui = self.uis[resPaths[resType.Back]]
    self.spBG = ngui.find_sprite(backui,"sp_di");

    local tipCloseLabel = ngui.find_label(backui, "txt")
    tipCloseLabel:set_text(_uiText[1])

    local titleSprite = ngui.find_sprite(backui, 'sp_art_font')
    titleSprite:set_sprite_name("js_shengpinchenggong")

    local frontParentNode = backui:get_child_by_name("add_content")
    local frontui = self.uis[resPaths[resType.Front]]
    frontui:set_parent(frontParentNode)

    local btn = ngui.find_button(backui, 'mark')
    btn:set_on_click(self.bindfunc['on_click_mark'],"MyButton.NoneAudio")

    -- local spMark = ngui.find_sprite(frontui, 'scrollview/sp_mark')
    -- spMark:set_on_ngui_click(self.bindfunc['on_click_mark'],"MyButton.NoneAudio")

    local oldFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_fight')
    local newFightValueLabel = ngui.find_label(frontui, 'sp_fight/lab_num')

    self.effectNode = frontui:get_child_by_name('fx_ui_new_small_card_pinzhi')    

    --local scrollView = ngui.find_scroll_view(frontui, "scrollview/panel")
    self.grid = ngui.find_grid(frontui, "grid")
    local objGrid = self.grid:get_game_object()
    local cloneItem = frontui:get_child_by_name( "grid/cont1")
    cloneItem:set_active(false)
    
    self.equipItem = {}
    for i = 1, self.equipCnt do
        local item = {}
        item.obj = cloneItem:clone()
        item.obj:set_parent(objGrid)     
        item.obj:set_name("item" .. i) 
        item.obj:set_active(true)

        item.leftSmallCard = UiSmallItem:new({parent = item.obj:get_child_by_name('content1/big_card_item_80'), delay = -1})
        item.lblLeftName = ngui.find_label(item.obj, 'content1/lab_name')
        item.rightSmallCard = UiSmallItem:new({parent = item.obj:get_child_by_name('content2/big_card_item_80'), delay = -1})
        item.lblRightName = ngui.find_label(item.obj, 'content2/lab_name')

        local cardInfo = self.allCardInfo[i]
        local oldCardInfo = self:GetOldCardInfo(cardInfo)
        item.leftSmallCard:SetData(oldCardInfo)
        item.lblLeftName:set_text(oldCardInfo.name)
        item.rightSmallCard:SetData(cardInfo)
        item.lblRightName:set_text(cardInfo.name)
        
        self.equipItem[i] = item
    end

    if self.equipCnt <= 2 then
		self.spBG:set_height(320);
	elseif self.equipCnt > 2 and self.equipCnt <= 4 then
		self.spBG:set_height(540);
	end
	self.grid:reposition_now();

    self.initItemOver = true
    self:ShowEffect()

    oldFightValueLabel:set_text(tostring(self.ownerCard:GetOldFightValue()))
    newFightValueLabel:set_text(tostring(self.ownerCard:GetFightValue()))    
    --scrollView:reset_position() 

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function UiEquipRarityUpAllResult:GetOldCardInfo(cardInfo)
    return cardInfo:CloneWithNewNumberLevelRairty(nil, nil, cardInfo.oldRarity)
end

function UiEquipRarityUpAllResult:on_recive_ani_finish()
    self.isAniOver = true
    self:ShowEffect()
end

function UiEquipRarityUpAllResult:ShowEffect()
    if self.isAniOver and self.initItemOver then
        if not self.isAddEffect then
            self.isAddEffect  = true
            for _, item in pairs(self.equipItem) do
                item.rightSmallCard:AddRarityEffect(self.effectNode)
                item.rightSmallCard:SetCommonEffectScale(0.55, 0.55, 0.55)
            end
        end
    end
end
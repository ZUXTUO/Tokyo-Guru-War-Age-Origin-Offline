
UiCommonPropertyChangResult = Class("UiCommonPropertyChangResult", MultiResUiBaseClass);

UiCommonPropertyChangEType = 
{
    EquipStarUp = 1,
    EquipRarityUp = 2,
    HeroRarityUp = 3,
}

-- cardinfo card_equipment
-- eType    UiCommonPropertyChangEType,默认为UiCommonPropertyChangEType.EquipStarUp
function UiCommonPropertyChangResult.Start(cardInfo , eType, ownerCard, oldFightValue)
    if UiCommonPropertyChangResult.inst == nil then
        eType = eType or UiCommonPropertyChangEType.EquipStarUp
        UiCommonPropertyChangResult.inst = UiCommonPropertyChangResult:new({cardInfo = cardInfo, type = eType, ownerCard = ownerCard, oldFightValue = oldFightValue})
    end
end

function UiCommonPropertyChangResult.SetFinishCallback(callback, obj)
    if UiCommonPropertyChangResult.inst then
        UiCommonPropertyChangResult.inst.callbackFunc = callback;
        if UiCommonPropertyChangResult.inst then
            UiCommonPropertyChangResult.inst.callbackObj = obj
        end
    end
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_819_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _UIText= 
{
    [1] = '生命值',
    [2] = '攻击力',
    [3] = '防御力',
    [4] = '点击屏幕任意位置关闭',
}

local EPropertyChangeShowProp = 
{
    {key = 'max_hp', str = _UIText[1]},
    {key = 'atk_power', str = _UIText[2]},
    {key = 'def_power', str = _UIText[3]},
}

function UiCommonPropertyChangResult:Init(data)
	self.pathRes = resPaths    
    self.isAniOver = false
    self.initItemOver = false
    self.isAddEffect = false
	MultiResUiBaseClass.Init(self, data);
end

function UiCommonPropertyChangResult:RestartData()
    CommonClearing.canClose = false

    MultiResUiBaseClass.RestartData(self)
end

function UiCommonPropertyChangResult:DestroyUi()
	if self.smallItems then
		for k,v in pairs(self.smallItems) do
			v:DestroyUi()
		end
        self.smallItems = nil
	end
    MultiResUiBaseClass.DestroyUi(self)
end

function UiCommonPropertyChangResult:RegistFunc()   
    MultiResUiBaseClass.RegistFunc(self)

    self.bindfunc['on_click_mark'] = Utility.bind_callback(self, self.on_click_mark);
end

function UiCommonPropertyChangResult:on_click_mark()

    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    if self.callbackFunc then
        self.callbackFunc(self.callbackObj)
    end

    self:DestroyUi()

    UiCommonPropertyChangResult.inst = nil

    NoticeManager.Notice(ENUM.NoticeType.GetHeroQuaUpShowBack)
end

function UiCommonPropertyChangResult:newSmallItem(type, parent, info)
    local si = nil
    if type == UiCommonPropertyChangEType.HeroRarityUp then
        si = SmallCardUi:new({parent = parent, info = info,
            stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level, SmallCardUi.SType.Rarity, SmallCardUi.SType.Star, SmallCardUi.SType.Qh }})
    else
        si = UiSmallItem:new({parent = parent, cardInfo = info})
    end
    return si
end

function UiCommonPropertyChangResult:InitedAllUI()

    self.backui = self.uis[resPaths[resType.Back]]
    self.frontui = self.uis[resPaths[resType.Front]]

    self.frontParentNode = self.backui:get_child_by_name("add_content")
    self.titleSprite = ngui.find_sprite(self.backui, 'sp_art_font')
    self.oldFightValueLabel = ngui.find_label( self.frontui, 'sp_fight/lab_fight')
    self.newFightValueLabel = ngui.find_label( self.frontui, 'sp_fight/lab_num')
    self.closeBtn = ngui.find_button(self.backui, 'mark')
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.oldParentNode =  self.frontui:get_child_by_name('content1/big_card_item_80')
    self.newParentNode =  self.frontui:get_child_by_name('content2/big_card_item_80')    
    self.effectNode =  self.frontui:get_child_by_name('fx_ui_new_small_card_pinzhi')
    self.oldNameLab = ngui.find_label( self.frontui, 'content1/lab_name')
    self.newNameLabel = ngui.find_label( self.frontui, 'content2/lab_name')
    self.proLabs = {}
    for i = 1,3 do
        self.proLabs[i] = {}
        self.proLabs[i].node =  self.frontui:get_child_by_name('grid_nature/lab_nature' .. tostring(i))
        self.proLabs[i].nameLab = ngui.find_label(self.proLabs[i].node, 'lab_nature' .. tostring(i))
        self.proLabs[i].oldNumLab = ngui.find_label(self.proLabs[i].node, 'lab_num')
        self.proLabs[i].arrawSp = ngui.find_sprite(self.proLabs[i].node, 'sp_arrow')
        self.proLabs[i].newNumLab = ngui.find_label(self.proLabs[i].node, 'lab')
    end
    

    -- set content
    self.tipCloseLabel:set_text(_UIText[4])
    self.frontui:set_parent(self.frontParentNode)
    local initData = self:GetInitData()
    local cardInfo = initData.cardInfo
    local number = nil
    local level = nil
    local rarity = nil
    local preStr = "+";
    if initData.type == UiCommonPropertyChangEType.EquipStarUp then
        number = cardInfo.oldNumber
        self.titleSprite:set_sprite_name("js_jinhuachenggong")
    elseif initData.type == UiCommonPropertyChangEType.EquipRarityUp then
        rarity = cardInfo.oldRarity
        self.titleSprite:set_sprite_name("js_shengpinchenggong")
    elseif initData.type == UiCommonPropertyChangEType.HeroRarityUp then
        number = cardInfo.oldNumber
        self.titleSprite:set_sprite_name("js_juexingchenggong")
        preStr = "";
    else
        return
    end

    local oldCardInfo = nil 
    if initData.type == UiCommonPropertyChangEType.HeroRarityUp then 
        oldCardInfo = cardInfo:CloneWithNewNumber(number)
    else
        oldCardInfo = cardInfo:CloneWithNewNumberLevelRairty(number, level, rarity)
    end

    self.closeBtn:set_on_click(self.bindfunc['on_click_mark'],"MyButton.NoneAudio")

    self.smallItems = {}
    self.smallItems[#self.smallItems] = self:newSmallItem(initData.type, self.oldParentNode, oldCardInfo)
    self.oldNameLab:set_text(oldCardInfo.name)
    self.smallItems[#self.smallItems] = self:newSmallItem(initData.type, self.newParentNode, cardInfo)
    self.initItemOver = true
    self:ShowEffect()
    self.newNameLabel:set_text(cardInfo.name)

    local properyDiff = nil
    if initData.type == UiCommonPropertyChangEType.HeroRarityUp then
        properyDiff = PublicFunc.GetHeroRarityPreProperyDiff(cardInfo, number, {"max_hp", "atk_power", "def_power"}) 
    end
    local i = 1
    for k,v in pairs(EPropertyChangeShowProp) do
        local old = 0
        local new = cardInfo:GetPropertyVal(v.key)
        if properyDiff ~= nil then
            old = PublicFunc.AttrInteger(cardInfo:GetPropertyVal(v.key, false) - properyDiff[v.key])
        else
            old = oldCardInfo:GetPropertyVal(v.key)
        end        
        if new - old > 0 then
            self.proLabs[i].nameLab:set_text(v.str)
            self.proLabs[i].oldNumLab:set_text(preStr .. tostring(old))
            self.proLabs[i].newNumLab:set_text(preStr .. tostring(new))
            i = i + 1
        end
    end
    for ri = i, #self.proLabs do
        self.proLabs[ri].node:set_active(false)
    end

    local showTarget = nil

    if cardInfo._className == CardHuman._className then
        showTarget = cardInfo
    else
        showTarget = initData.ownerCard
    end

    if initData.oldFightValue then
        self.oldFightValueLabel:set_text(tostring(initData.oldFightValue))
    else
        self.oldFightValueLabel:set_text(tostring(showTarget:GetOldFightValue()))
    end
    self.newFightValueLabel:set_text(tostring(showTarget:GetFightValue()))

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

-- 公用动画回调
function UiCommonPropertyChangResult.OnOver()
    if  UiCommonPropertyChangResult.inst then
        UiCommonPropertyChangResult.inst.isAniOver = true
        UiCommonPropertyChangResult.inst:ShowEffect()
    end
    --通用奖励界面，相同的动画
    if CommonAward then
        CommonAward.OnAnimationEnd()
    end
end

function UiCommonPropertyChangResult:ShowEffect()
    local initData = self:GetInitData()
    if initData.type == UiCommonPropertyChangEType.EquipStarUp then
        return
    end
    if self.isAniOver and self.initItemOver then
        if not self.isAddEffect then
            self.isAddEffect  = true
            self.smallItems[#self.smallItems]:AddRarityEffect(self.effectNode)
        end
    end
end

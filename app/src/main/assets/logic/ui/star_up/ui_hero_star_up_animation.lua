UiHeroStarUpAnimation = Class("UiHeroStarUpAnimation", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

--data:   {roleData = cardinfo}
function UiHeroStarUpAnimation.SetAndShow(data)
	if UiHeroStarUpAnimation.instance then
		UiHeroStarUpAnimation.instance:SetData(data);
		UiHeroStarUpAnimation.instance:UpdateUi();
	else
		UiHeroStarUpAnimation.instance = UiHeroStarUpAnimation:new(data);
	end
end

function UiHeroStarUpAnimation.SetTouchCallback(callbackfunc,data)
	if UiHeroStarUpAnimation.instance then
		UiHeroStarUpAnimation.instance:_SetTouchCallback(callbackfunc, data)
	end
end

function UiHeroStarUpAnimation.Destroy()
    if UiHeroStarUpAnimation.instance then
        UiHeroStarUpAnimation.instance:DestroyUi();
        UiHeroStarUpAnimation.instance = nil;
    end
end

-------------------内部接口------------------------
local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_821_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

-- local restrainImgPath = 
-- {
--     ["property_plus"] = 'assetbundles/prefabs/ui/image/backgroud/ying_xiong_ke_zhi/yxkz_kezhi.assetbundle';
--     ["property_reduce"] = 'assetbundles/prefabs/ui/image/backgroud/ying_xiong_ke_zhi/yxkz_mianshang.assetbundle';
-- }

local uiTxt = 
{
    [1] = '生命值',
    [2] = '攻击力',
    [3] = '防御力',
    [4] = '点击屏幕任意位置关闭',
    [7] = '开启新技能',
}

local EPropertyChangeShowProp = 
{
    {key = 'max_hp', str = uiTxt[1]},
    {key = 'atk_power', str = uiTxt[2]},
    {key = 'def_power', str = uiTxt[3]},
}

-- function UiHeroStarUpAnimation:UnlockSkill(star)
--     self.showFuncTitleLabel:set_text(uiTxt[7])

--     local info = PublicFunc.GetUnlockSkillInfo(self.roleData, star)
--     if info == nil then return end

--     local tex = ngui.find_texture(self.ui, 'cont2/Texture')
--     tex:set_texture(info.icon)

--     local lab = ngui.find_label(self.ui, 'cont2/lab_name')
--     lab:set_text(info.name)

--     lab = ngui.find_label(self.ui, "cont2/lab_describe")
--     lab:set_text(info.des)

--     table.insert(self.texObjs, tex)
-- end

-- local star2OpenFun = 
-- {
--     [3] = UiHeroStarUpAnimation.UnlockSkill,
--     [4] = UiHeroStarUpAnimation.UnlockSkill,
--     [5] = UiHeroStarUpAnimation.UnlockSkill,
--     [6] = UiHeroStarUpAnimation.UnlockSkill,
--     [7] = UiHeroStarUpAnimation.UnlockSkill,
-- }

--初始化
function UiHeroStarUpAnimation:Init(data)
	self.pathRes = resPaths
    self:SetData(data);
	MultiResUiBaseClass.Init(self, data);
end

--重新开始
function UiHeroStarUpAnimation:Restart(data)
	if MultiResUiBaseClass.Restart(self, data) then
	--todo 
	end
end

--初始化数据
function UiHeroStarUpAnimation:InitData(data)
	MultiResUiBaseClass.InitData(self, data);

    CommonClearing.canClose = false
    self.closeDelayTime = PublicStruct.Const.UI_CLOSE_DELAY
end

--析构函数
function UiHeroStarUpAnimation:DestroyUi()
    self:Hide();
    self.ui_back = nil;
    MultiResUiBaseClass.DestroyUi(self);
--    if self.textureDiSkill then
--        self.textureDiSkill:Destroy();
--        self.textureDiSkill = nil;
--    end

    -- if self.oldStarCardInfoUi then
    --     self.oldStarCardInfoUi:DestroyUi()
    --     self.oldStarCardInfoUi = nil
    -- end
    -- if self.newStarCardInfoUi then
    --     self.newStarCardInfoUi:DestroyUi()
    --     self.newStarCardInfoUi = nil
    -- end

    if self.skillTexture then
        self.skillTexture:Destroy()
    end
    
end

--显示ui
function UiHeroStarUpAnimation:Show()
    if MultiResUiBaseClass.Show(self) then
	    if not self.ui_back then
            return;
        end
        self.ui_back:set_active(true);
	end
end

--隐藏ui
function UiHeroStarUpAnimation:Hide()
    if MultiResUiBaseClass.Hide(self) then
	    if self.ui_back then
            self.ui_back:set_active(false);
        end
	end
end

--注册回调函数
function UiHeroStarUpAnimation:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc['on_loaded'] = Utility.bind_callback(self, self.on_loaded);
    self.bindfunc['on_touch_back'] = Utility.bind_callback(self, self.on_touch_back);
    self.bindfunc["on_recive_ani_finish"] = Utility.bind_callback(self, self.on_recive_ani_finish);
    self.bindfunc['ChangeNextPage'] = Utility.bind_callback(self, self.ChangeNextPage)
end

--注销回调函数
function UiHeroStarUpAnimation:UnRegistFunc()
    MultiResUiBaseClass.UnRegistFunc(self);

    PublicFunc.msg_unregist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

--注册消息分发回调函数
function UiHeroStarUpAnimation:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);

    PublicFunc.msg_regist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

--注销消息分发回调函数
function UiHeroStarUpAnimation:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
end

--寻找ngui对象
function UiHeroStarUpAnimation:InitedAllUI(asset_obj)

    self.backui = self.uis[resPaths[resType.Back]]
    self.ui = self.uis[resPaths[resType.Front]]
    self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")
    self.markBtn = ngui.find_button(self.backui, "mark");
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.frontParentNode = self.backui:get_child_by_name("add_content")
    -- self.progressbar = ngui.find_progress_bar(self.ui, "background")
    self.propertyChangeNode = self.ui:get_child_by_name("content1")
    self.funcUnlockNode = self.ui:get_child_by_name("content2")
    self.oldFightValueLabel = ngui.find_label(self.ui, "content1/sp_fight/lab_fight")
    self.newFightValueLabel = ngui.find_label(self.ui, "content1/sp_fight/lab_num")
    self.onKeySkillUpNode = self.ui:get_child_by_name("content2/txt1")
    self.newFuncNode = self.ui:get_child_by_name("content2/txt2")
    self.skillNameLabel = ngui.find_label(self.ui, "content2/lab_name")
    self.skillDesLabel = ngui.find_label(self.ui, "content2/lab_describe")
    self.skillTexture = ngui.find_texture(self.ui, "content2/Texture")
    self.starSps = {}
    local maxStar = PublicStruct.Const.HERO_MAX_STAR
    for i = 1, maxStar do
        local sp = ngui.find_sprite(self.ui, "cont_star/sp_star" .. tostring(i))
        if sp then
            table.insert(self.starSps, sp)
        end
    end
    self.propertyShowNodes = {}
    for i = 1, 3 do
        local info = {}
        local node = self.ui:get_child_by_name("content1/grid_nature/lab_nature" .. tostring(i))
        info.node = node
        info.nameLabel = ngui.find_label(node, "lab_nature" .. tostring(i))
        info.oldNumberLabel = ngui.find_label(node, "lab_num")
        info.newNumberLabel = ngui.find_label(node, "lab")
        self.propertyShowNodes[i] = info
    end


    self.tipCloseLabel:set_text(uiTxt[4])
    self.backui:set_name('ui_hero_star_up_animation')
    self.ui:set_parent(self.frontParentNode)
    self.titleSprite:set_sprite_name("js_shengxingchenggong")
    self.markBtn:set_on_click(self.bindfunc['on_touch_back'],"MyButton.NoneAudio");
    local star = self.roleData.rarity
    for i = 1, maxStar do
        local sp = self.starSps[i]
        if sp then
            if i <= star then
                sp:set_sprite_name("js_xing")
            else
                sp:set_sprite_name("js_xing2")
            end
        end
    end
    --self.progressbar:set_value(star/maxStar)
    self.funcUnlockNode:set_active(false)

    self.oldFightValueLabel:set_text(tostring(self.roleData:GetOldFightValue()))
    self.newFightValueLabel:set_text(tostring(self.roleData:GetFightValue()))

    local properyDiff = PublicFunc.GetHeroRarityPreProperyDiff(self.roleData, self.roleData.oldNumber, {"max_hp", "atk_power", "def_power"}) 
    local i = 1
    for k,v in pairs(EPropertyChangeShowProp) do
        local diff = properyDiff[v.key]
        if diff > 0 then
            local new = self.roleData:GetPropertyVal(v.key)
            local old = PublicFunc.AttrInteger(new - diff)
            self.propertyShowNodes[i].nameLabel:set_text(v.str)
            self.propertyShowNodes[i].oldNumberLabel:set_text(tostring(old))
            self.propertyShowNodes[i].newNumberLabel:set_text(tostring(new))
            i = i + 1
        end
    end
    for ri = i, #self.propertyShowNodes do
        self.propertyShowNodes[ri].node:set_active(false)
    end

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
    -- local oldStarHeadParent = self.ui:get_child_by_name('content1/big_card_item_80')
    -- local cardinfo = CardHuman:new({number = self.roleData.oldNumber, level = self.roleData.level});
    -- self.oldStarCardInfoUi = SmallCardUi:new({info = cardinfo, parent = oldStarHeadParent
    --         , stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity , SmallCardUi.SType.Level,SmallCardUi.SType.Star }})

    -- local newStarHeadParent = self.ui:get_child_by_name('content2/big_card_item_80')
    -- self.newStarCardInfoUi = SmallCardUi:new({info = self.roleData, parent = newStarHeadParent
    --         , stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity , SmallCardUi.SType.Level,SmallCardUi.SType.Star }})

    -- local heroNameLab = ngui.find_label(self.ui, 'content1/lab_name')
    -- heroNameLab:set_text(cardinfo.name)
    -- heroNameLab = ngui.find_label(self.ui, 'content2/lab_name')
    -- heroNameLab:set_text(self.roleData.name)

    -- self.showFuncTitleLabel = ngui.find_label(self.ui, 'cont2/txt')
    
    -- if star2OpenFun[star] then
    --     star2OpenFun[star](self, star)
    -- else
    --     local cont2Node = self.ui:get_child_by_name("cont2")
    --     cont2Node:set_active(false)
    -- end

end

function UiHeroStarUpAnimation:on_recive_ani_finish()

    local star = self.roleData.rarity
    if star <= 2 then return end
    self.closeDelayTime = PublicStruct.Const.UI_CLOSE_DELAY + 0.8
    TimerManager.Add(self.bindfunc['ChangeNextPage'], 800, 1)
end

function UiHeroStarUpAnimation:ChangeNextPage()
    local star = self.roleData.rarity
    self.funcUnlockNode:set_active(true)
    self.propertyChangeNode:set_active(false)
    if star == 5 then
        self.onKeySkillUpNode:set_active(true)
    else
        self.onKeySkillUpNode:set_active(false)
    end
    local info = PublicFunc.GetUnlockSkillInfo(self.roleData, star)
    self.skillTexture:set_texture(info.icon)
    self.skillNameLabel:set_text(info.name)
    self.skillDesLabel:set_text(info.des)
end

function UiHeroStarUpAnimation:SetData(data)
    self.roleData = data.roleData;

end

function UiHeroStarUpAnimation:_SetTouchCallback(callbackfunc, data)
	self.callbackfunc = callbackfunc;
	self.callback_data = data;
end

function UiHeroStarUpAnimation:on_touch_back()

    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < self.closeDelayTime then return end

	self:Hide();

	if self.callbackfunc then
		self.callbackfunc(self.callback_data);
	end
    UiHeroStarUpAnimation.Destroy()
    
    NoticeManager.Notice(ENUM.NoticeType.GetHeroStarupShowBack)
end

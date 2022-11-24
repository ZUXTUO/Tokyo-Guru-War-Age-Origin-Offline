

EggHeroGetOne = Class("EggHeroGetOne", MultiResUiBaseClass);
function EggHeroGetOne.Start(data)
	if EggHeroGetOne.instance then
		EggHeroGetOne.instance:SetData(data)
		EggHeroGetOne.instance:UpdateUi();
	else
		EggHeroGetOne.instance = EggHeroGetOne:new(data)
	end
end

function EggHeroGetOne.Destroy()
	if EggHeroGetOne.instance then
        EggHeroGetOne.instance:Hide();
        EggHeroGetOne.instance:DestroyUi();
        EggHeroGetOne.instance = nil;
    end
end

function EggHeroGetOne.SetCallback(func1,obj1,func2,obj2,func3,obj3)
    if EggHeroGetOne.instance then
        EggHeroGetOne.instance.func_again = func1;
        EggHeroGetOne.instance.obj_again = obj1;
        EggHeroGetOne.instance.func_sure = func2;
        EggHeroGetOne.instance.obj_sure = obj2;
        EggHeroGetOne.instance.func_share = func3;
        EggHeroGetOne.instance.obj_share = obj3;
    end
end


----------------------------------------------------------------

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/content_jiesuan_hero1.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local uiText = 
{
    [1] = '  赠送:',
    [2] = '免费',
}

function EggHeroGetOne:Init(data)
	self.pathRes = resPaths;
    self:SetData(data);
	MultiResUiBaseClass.Init(self, data);
end

--重新开始
function EggHeroGetOne:Restart(data)
	if MultiResUiBaseClass.Restart(self, data) then
	--todo 
	end
end

--析构函数
function EggHeroGetOne:DestroyUi()
    
    if self.itemSmallUi then
        self.itemSmallUi:DestroyUi()
        self.itemSmallUi = nil    
    end

    if self.costItemIconTex then
        self.costItemIconTex:Destroy()
        self.costItemIconTex = nil
    end

    MultiResUiBaseClass.DestroyUi(self);
    ResourceManager.DelRes(self.pathRes);
end

--注册回调函数
function EggHeroGetOne:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc['on_share'] = Utility.bind_callback(self, self.on_share);
    self.bindfunc['on_sure'] = Utility.bind_callback(self, self.on_sure);
    self.bindfunc['on_again'] = Utility.bind_callback(self, self.on_again);
    self.bindfunc['on_touch_back'] = Utility.bind_callback(self, self.on_touch_back);
end

--寻找ngui对象
function EggHeroGetOne:InitedAllUI()
    
    self.backui = self.uis[resPaths[resType.Back]]
    self.ui = self.uis[resPaths[resType.Front]]

    self.frontParentNode = self.backui:get_child_by_name("add_content")
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")
    self.btnSure = ngui.find_button(self.ui, "btn_sure");
    self.btnAgain = ngui.find_button(self.ui, "btn_zai_chou");
    self.desLabel = ngui.find_label(self.ui,"txt");
    self.newHeroSp = ngui.find_sprite(self.ui, 'kug1/sp_new')
    self.itemNodeParent = self.ui:get_child_by_name('kug1/big_card_item_80')
    self.soulFxNode = self.ui:get_child_by_name("kug1/fx_ui_zhaomu_smallcard")
    self.soulFxNode2 = self.ui:get_child_by_name('kug1/fx_content_jiesuan_zhuanhuan')
    self.heroAroundFx = self.ui:get_child_by_name('kug1/fx_checkin_month')
    self.nameLabel = ngui.find_label(self.ui, "kug1/lab");
    self.showReBuyCostNode = ngui.find_sprite(self.ui, 'sp_di')
    self.costItemIconTex = ngui.find_texture(self.ui, 'Texture_yaoshi')
    self.costItemNumLab = ngui.find_label(self.ui, 'sp_di/lab')

    -- set content
    self.ui:set_parent(self.frontParentNode)
    self.tipCloseLabel:set_active(false)
    self.titleSprite:set_sprite_name("js_gongxihuode")
    self.btnSure:set_on_click(self.bindfunc['on_sure']);
    self.btnAgain:set_on_click(self.bindfunc['on_again']);
    
    if self.description then
        self.desLabel:set_text(self.description)
    else
        self.desLabel:set_active(false)
    end
    local info = nil
    local isHero = PropsEnum.IsRole(self.vecReward[1].id)
    local isNewHero = self.vecReward[1].id == self.vecItem[1].id
    if isNewHero and isHero then
        self.newHeroSp:set_active(true)

        self.soulFxNode:set_active(false)
        self.soulFxNode2:set_active(false)

        info = CardHuman:new({number = self.vecReward[1].id, level = 1, count = self.vecReward[1].count});
        self.itemSmallUi = SmallCardUi:new({parent = self.itemNodeParent, info = info, as_reward = true,
            stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star}})
    else
        self.newHeroSp:set_active(false)
        if isHero then
            self.soulFxNode:set_active(true)
            self.soulFxNode2:set_active(true)
        else
            self.soulFxNode:set_active(false)
            self.soulFxNode2:set_active(false)
            -- titleLabel:set_text(uiText[4])

            self.heroAroundFx:set_active(false)
        end

        info = CardProp:new({number = self.vecItem[1].id, level = 1, count = self.vecItem[1].count});
        self.itemSmallUi = UiSmallItem:new({cardInfo = info, parent = self.itemNodeParent})
        self.itemSmallUi:SetCount(self.vecItem[1].count)
    end

    
    self.nameLabel:set_text(info.color_name or info.name)
    if self.costItemNum then
        if self.costItemNum == 0 then
            self.costItemNumLab:set_text(uiText[2]) --免费
        else
            if self.costItemOwn then
                self.costItemNumLab:set_text(tostring(self.costItemOwn) .. "/" .. tostring(self.costItemNum))
            else
                self.costItemNumLab:set_text(tostring(self.costItemNum))
            end
        end

        if self.costItemId then
            local config = ConfigManager.Get(EConfigIndex.t_item, self.costItemId)
            self.costItemIconTex:set_texture(config.small_icon)
        end 
    else
        self.showReBuyCostNode:set_active(false)
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.ComReward)
end

--设置数据
function EggHeroGetOne:SetData(data)
    self.canTouch = false;
    self.vecReward = data.vecReward;
    self.vecItem = data.vecItem or self.vecReward;

    self.costItemId = data.costItemId
    self.costItemNum = data.costItemNum
    self.costItemOwn = data.costItemOwn
    self.description = data.description
end

--确定
function EggHeroGetOne:on_sure()
    EggHeroGetOne.Destroy()
    if self.func_sure then
        self.func_sure(self.obj_sure);
    end
end

--分享
function EggHeroGetOne:on_share()
    if self.func_share then
        self.func_share(self.obj_share);
    end
end

--再抽10次
function EggHeroGetOne:on_again()
    --EggHeroGetOne.Destroy()
    self:on_sure();
    if self.func_again then
        self.func_again(self.obj_again)
    end
end

--[[
--点击空白
function EggHeroGetOne:on_touch_back()
    if self.canTouch then
        --播动画
        self.animator1_obj:animator_play("animation_content_jiesuan3");
        --self.animator2_obj:animator_play("fight_font_animation1_xiaoshi");
        self.fx_shan:set_active(false);
        self.canTouch = false;
    end
end
]]
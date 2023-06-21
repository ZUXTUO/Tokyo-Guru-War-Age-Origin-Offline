EggHeroGetTen = Class("EggHeroGetTen", MultiResUiBaseClass);

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/content_jiesuan_hero10.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}


local uiText = 
{
	[2] = '此角色已经拥有,自动转化为[ff0000]%s*%d[-],可用于升星和潜能强化。',
}

--data = 
--{
--    vecReward           --net_summary_item ... , 获得的物品
--    vecItem             --net_summary_item ..., 用于英雄十连抽

--    costItemId          --花费道具id
--    costItemNum         --花费数量
--    costItemOwn        --拥有花费道具数量
--}

function EggHeroGetTen.Start(data)
	if EggHeroGetTen.instance then
		EggHeroGetTen.instance:SetData(data)
		EggHeroGetTen.instance:UpdateUi();
	else
		EggHeroGetTen.instance = EggHeroGetTen:new(data)
	end
end

function EggHeroGetTen.Destroy()
	if EggHeroGetTen.instance then
        EggHeroGetTen.instance:Hide();
        EggHeroGetTen.instance:DestroyUi();
        EggHeroGetTen.instance = nil;
    end
end

function EggHeroGetTen.SetCallback(func1,obj1,func2,obj2,func3,obj3)
    if EggHeroGetTen.instance then
        EggHeroGetTen.instance.func_again = func1;
        EggHeroGetTen.instance.obj_again = obj1;
        EggHeroGetTen.instance.func_sure = func2;
        EggHeroGetTen.instance.obj_sure = obj2;
        EggHeroGetTen.instance.func_share = func3;
        EggHeroGetTen.instance.obj_share = obj3;
    end
end

--当第一个动画播完，回调
function EggHeroGetTen.OnOver(obj)
    local objName = obj:get_name()
    local index = tonumber(string.sub(objName, string.find(objName, "%d"), -1))
    local self = EggHeroGetTen.instance;
    if index and self then

        if self.hasDeadItemName[index] ~= nil then
            return
        end

        self.hasDeadItemName[index] = true

        self.currentPlayingIndex = index

	    if PropsEnum.IsRole(self.vecReward[index].id) then
            local cardInfo = CardHuman:new({number = self.vecReward[index].id, level=1});
            local isNew = self.vecReward[self.currentPlayingIndex].id == self.vecItem[self.currentPlayingIndex].id
            local heroDes = nil
            if not isNew then
                local itemConfig = ConfigManager.Get(EConfigIndex.t_item, self.vecItem[self.currentPlayingIndex].id)
                local name = itemConfig.name
                heroDes = string.format(uiText[2], tostring(name), self.vecItem[self.currentPlayingIndex].count)
            end
            --app.log("EggHeroGetTen.OnOver " .. objName .. ' ' .. debug.traceback())
            EggGetHero.Start(cardInfo, isNew, heroDes)
            EggGetHero.SetFinishCallback(EggHeroGetTen.ShowGetHeroEnd, self)

            self.heroAroundFx[self.currentPlayingIndex]:set_active(true)

            --self.winTitleNode:set_active(false)

            self:Hide()
        else
            self:PlayNextAni()
        end
    end
end

function EggHeroGetTen:Show()
    if self.backui then
        self.backui:set_position(0, 0, 0)
    end
end

function EggHeroGetTen:Hide()
    if self.backui then
        self.backui:set_position(0, 10000, 0)
    end
end

function EggHeroGetTen:ShowGetHeroEnd()
    self:Show()
    --self.winTitleNode:set_active(true)

    if self.vecReward[self.currentPlayingIndex].id ~= self.vecItem[self.currentPlayingIndex].id then
        local cfg = CardProp:new({number=self.vecItem[self.currentPlayingIndex].id,count = self.vecItem[self.currentPlayingIndex].count, 
            dataid = self.vecItem[self.currentPlayingIndex].dataid})
        self.lab_name[self.currentPlayingIndex]:set_text(cfg.color_name or cfg.name);

        if self.item[self.currentPlayingIndex] then
            self.item[self.currentPlayingIndex]:DestroyUi();
        end
        self.item[self.currentPlayingIndex] = UiSmallItem:new({});
        self.item[self.currentPlayingIndex]:SetParent(self.smallItemParent[self.currentPlayingIndex]);
        self.item[self.currentPlayingIndex]:SetData(cfg);
        self.item[self.currentPlayingIndex]:SetCount(self.vecItem[self.currentPlayingIndex].count)
        self.convertFx[self.currentPlayingIndex]:set_active(true);
        timer.create(Utility.create_callback(EggHeroGetTen.PlayNextAni, self),300, 1)
    else
        self:PlayNextAni()
    end
end

function EggHeroGetTen:PlayNextAni()
    if self.currentPlayingIndex == nil then return end

    if self.currentPlayingIndex >= 10 then

        self.isOver = true

        self.btnSure:set_active(true)
        self.btnAgain:set_active(true);
        if self.costItemNum then
            self.costItemIconTex:set_active(true)
            self.showCostNode:set_active(true)
        end
    else
        local nextIndex = self.currentPlayingIndex + 1
        --self.obj[nextIndex]:set_animator_speed('', 1)
        self.obj[nextIndex]:set_active(true)

        self.contentFx[nextIndex]:set_active(true)
        if PropsEnum.IsRole(self.vecReward[nextIndex].id) then
            if self.vecReward[nextIndex].id == self.vecItem[nextIndex].id then
                self.item[nextIndex]:SetAsReward(true) 
            end
        end
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.GetReward)
    end

    self.currentPlayingIndex = nil
end

function EggHeroGetTen:Init(data)
	self.pathRes = resPaths;
    self:SetData(data);
	MultiResUiBaseClass.Init(self, data);
end

--析构函数
function EggHeroGetTen:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self);
    if self.item then
        for i=1,10 do
            if self.item[i] then
                self.item[i]:DestroyUi();
                self.item[i] = nil;
            end
        end
        self.item = nil
    end

    if self.costItemIconTex then
        self.costItemIconTex:Destroy()
        self.costItemIconTex = nil
    end

    ResourceManager.DelRes(self.pathRes);

end


--注册回调函数
function EggHeroGetTen:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc['on_share'] = Utility.bind_callback(self, self.on_share);
    self.bindfunc['on_sure'] = Utility.bind_callback(self, self.on_sure);
    self.bindfunc['on_again'] = Utility.bind_callback(self, self.on_again);
end

--寻找ngui对象
function EggHeroGetTen:InitedAllUI()

    self.hasDeadItemName = {}
    self.backui = self.uis[resPaths[resType.Back]]
    self.ui = self.uis[resPaths[resType.Front]]

    self.frontParentNode = self.backui:get_child_by_name("add_content")
    self.tipCloseLabel = ngui.find_label(self.backui, "txt")
    self.titleSprite = ngui.find_sprite(self.backui, "sp_art_font")
    self.btnSure = ngui.find_button(self.ui, "btn_sure");
    self.btnAgain = ngui.find_button(self.ui, "btn_zai_chou");
    self.btnAgainLab = ngui.find_label(self.ui, "btn_zai_chou/lab")
    self.showCostNode = self.ui:get_child_by_name('sp_di')
    self.costItemIconTex = ngui.find_texture(self.ui, 'Texture_yaoshi')
    self.costItemNumLab = ngui.find_label(self.ui, 'sp_di/lab')
    self.desLab = ngui.find_label(self.ui, 'txt')

    self.lab_name = {};
    self.sp_new = {};
    self.convertFx = {};
    self.contentFx = {}
    self.heroAroundFx = {}
    self.item = {};
    self.obj = {};
    self.smallItemParent = {}
    for i=1,10 do
        self.obj[i] = self.ui:get_child_by_name("ten_list/kug"..i);
        self.smallItemParent[i] = self.obj[i]:get_child_by_name("new_small_card_item")
        self.lab_name[i] = ngui.find_label(self.obj[i], "lab_word");
        self.sp_new[i] = ngui.find_sprite(self.obj[i], "sp_new");
        self.convertFx[i] = self.obj[i]:get_child_by_name("fx_content_jiesuan_zhuanhuan")
        self.convertFx[i]:set_active(false)
        self.contentFx[i] = self.obj[i]:get_child_by_name("fx_ui_zhaomu_smallcard")
        self.contentFx[i]:set_active(false)
        self.heroAroundFx[i] = self.obj[i]:get_child_by_name("fx_checkin_month")
        self.heroAroundFx[i]:set_active(false)

        --self.obj[i]:set_animator_speed('', 0)
        self.obj[i]:set_active(false)
    end

    -- set content
    self.ui:set_parent(self.frontParentNode)
    self.tipCloseLabel:set_active(false)
    self.titleSprite:set_sprite_name("js_gongxihuode")
    self.btnSure:set_on_click(self.bindfunc['on_sure']);
    self.btnSure:set_active(false);
    self.btnAgain:set_on_click(self.bindfunc['on_again']);
    self.btnAgain:set_active(false);
    if self.costItemNum then
        local costString = tostring(self.costItemNum)
        if self.costItemOwn then
            costString = tostring(self.costItemOwn) .. "/" .. costString
        end
        self.costItemNumLab:set_text(costString)

        if self.costItemId then
            local config = ConfigManager.Get(EConfigIndex.t_item, self.costItemId)
            self.costItemIconTex:set_texture(config.small_icon)
        end 
    end
    self.showCostNode:set_active(false)

    if self.description then
        self.desLab:set_text(self.description)
    else
        self.desLab:set_active(false)
    end
    
	self:UpdateUi();
end

--刷新界面
function EggHeroGetTen:UpdateUi()
	if MultiResUiBaseClass.UpdateUi(self) then

        if #self.vecReward ~= 10 or #self.vecItem ~= 10 then
            app.log("EggHeroGetTen item number error")
            self.btnSure:set_active(true)
            self.btnAgain:set_active(true);
            return
        end
        
	    for i=1,10 do
            local cardInfo = nil
            self.vecReward[i].number = self.vecReward[i].id;
            if PropsEnum.IsEquip(self.vecReward[i].id) then
                self.item[i] = UiSmallItem:new({});
                self.item[i]:SetParent(self.smallItemParent[i]);
                cardInfo = CardEquipment:new(self.vecReward[i])
                self.item[i]:SetData(cardInfo)
                self.item[i]:SetCount(self.vecReward[i].count)
            elseif PropsEnum.IsRole(self.vecReward[i].id) then
                self.item[i] = SmallCardUi:new({stypes = { SmallCardUi.SType.Texture ,SmallCardUi.SType.Rarity, SmallCardUi.SType.Star }});
                self.item[i]:SetParent(self.smallItemParent[i]);
                cardInfo = CardHuman:new(self.vecReward[i])
                self.item[i]:SetData(cardInfo);
                self.item[i]:SetTeamPosIcon(0);
            else
                self.item[i] = UiSmallItem:new({});
                self.item[i]:SetParent(self.smallItemParent[i]);
                cardInfo = CardProp:new(self.vecReward[i])
                self.item[i]:SetData(cardInfo)
                self.item[i]:SetCount(self.vecReward[i].count)
            end
            self.lab_name[i]:set_text(cardInfo.color_name or cardInfo.name);
            if self.vecReward[i].id == self.vecItem[i].id then
                if PropsEnum.IsRole(self.vecReward[i].id) then
                    self.sp_new[i]:set_active(true);
                else
                    self.sp_new[i]:set_active(false);
                end
            else
                self.sp_new[i]:set_active(false);
            end

            if self.vecReward[i].id ~= self.vecItem[i].id then
                self.isFirst = true
            end
        end
	end

    self.currentPlayingIndex = 0
    self:PlayNextAni()
end

--设置数据
function EggHeroGetTen:SetData(data)
    self.isOver = false;
    self.isFirst = false;
    self.vecReward = data.vecReward
    self.vecItem = data.vecItem or self.vecReward;

    self.costItemId = data.costItemId
    self.costItemNum = data.costItemNum
    self.costItemOwn = data.costItemOwn
    self.description = data.description
end

--确定
function EggHeroGetTen:on_sure()

    EggHeroGetTen.Destroy()
    if self.func_sure then
        self.func_sure(self.obj_sure);
    end
end

--分享
function EggHeroGetTen:on_share()
    if self.func_share then
        self.func_share(self.obj_share);
    end
end

--再抽10次
function EggHeroGetTen:on_again()
    --EggHeroGetTen.Destroy()
    self:on_sure();
    if self.func_again then
        self.func_again(self.obj_again)
    end
end
--首充ui
UiFirstRecharge = Class('UiFirstRecharge',UiBaseClass);
--------------------------------------------------

UiFirstRecharge.isOpen = false;

local _UIText = {
    [1] = "前往充值",
    [2] = "我要领取",
}

--初始化
function UiFirstRecharge:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/first_recharge/ui_3601_first_recharge.assetbundle';
    UiBaseClass.Init(self, data);
end

--初始化数据
function UiFirstRecharge:InitData(data)
    UiBaseClass.InitData(self, data);
end

--重新开始
function UiFirstRecharge:Restart(data)
    self.sim = {};
    UiBaseClass.Restart(self, data);
end

--析构函数
function UiFirstRecharge:DestroyUi()
    UiBaseClass.DestroyUi(self);
    for k,v in pairs(self.sim) do
        v:DestroyUi();
    end
    self.sim = {};
end

function UiFirstRecharge:Show()
    UiBaseClass.Show(self);
    self:UpdateUi()
end

--注册回调函数
function UiFirstRecharge:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_btn_get'] = Utility.bind_callback(self, self.on_btn_get);
    self.bindfunc['on_btn_close'] = Utility.bind_callback(self, self.on_btn_close);
    self.bindfunc["on_click_head_detail"] = Utility.bind_callback(self, self.on_click_head_detail);

    self.bindfunc['gc_btn_get'] = Utility.bind_callback(self, self.gc_btn_get);
    self.bindfunc['gc_update_flag'] = Utility.bind_callback(self, self.gc_update_flag);
end

--注册消息分发回调函数
function UiFirstRecharge:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_first_recharge_flag,self.bindfunc['gc_update_flag']);
    PublicFunc.msg_regist(player.gc_get_first_recharge_reward,self.bindfunc['gc_btn_get']);
end

--注销消息分发回调函数
function UiFirstRecharge:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_first_recharge_flag,self.bindfunc['gc_update_flag']);
    PublicFunc.msg_unregist(player.gc_get_first_recharge_reward,self.bindfunc['gc_btn_get']);
end

--初始化UI
function UiFirstRecharge:LoadUI()
    UiBaseClass.LoadUI(self);
end

--寻找ngui对象
function UiFirstRecharge:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("ui_first_recharge");

    self.obj_item = {};
    self.fx = {};
    for i=1,4 do
        self.obj_item[i] = self.ui:get_child_by_name("centre_other/animation/texture/new_small_card_item" .. i);
        -- self.fx[i] = ngui.find_sprite(self.ui, "centre_other/animation/texture/new_small_card_item" .. i .. "/fx");
        -- self.fx[i]:set_active(false);
    end

    self.btn_get = ngui.find_button(self.ui, "centre_other/animation/btn_get");
    self.btn_get:set_on_click(self.bindfunc['on_btn_get']);
    self.btn_close = ngui.find_button(self.ui, "mark");
    self.btn_close:set_on_click(self.bindfunc['on_btn_close']);

    self.lab_get = ngui.find_label(self.ui, "centre_other/animation/btn_get/animation/lab");

    self.star_list = {};
    for i=1,6 do
        self.star_list[i] = ngui.find_sprite(self.ui, "centre_other/animation/texture/content/cont_star/sp_star".. i);
    end

    UiFirstRecharge.isOpen = true;
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_FirstRecharge);
	self:UpdateUi();
end

--刷新界面
function UiFirstRecharge:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    local drop_id = ConfigManager.Get(EConfigIndex.t_discrete,83000065).data;
    local cfg = ConfigManager.Get(EConfigIndex.t_drop_something,drop_id);
    for i=1,4 do
        local cardInfo;
        --app.log("i=="..i.."   number=="..cfg[i].goods_show_number.."   count="..cfg[i].goods_number);
        if PropsEnum.IsRole(cfg[i].goods_show_number) then
            cardInfo = CardHuman:new({number = cfg[i].goods_show_number, count = cfg[i].goods_number});
            local role_config = ConfigHelper.GetRole(cardInfo.default_rarity);
            if role_config then
                for k,v in pairs(self.star_list) do
                    v:set_active(tonumber(k) <= role_config.rarity);
                end
            end
        elseif PropsEnum.IsItem(cfg[i].goods_show_number) then
            cardInfo = CardProp:new({number = cfg[i].goods_show_number, count = cfg[i].goods_number});
        elseif PropsEnum.IsEquip(cfg[i].goods_show_number) then
            cardInfo = CardEquipment:new({number = cfg[i].goods_show_number, count = cfg[i].goods_number});
        elseif PropsEnum.IsVaria(cfg[i].goods_show_number) then
            cardInfo = CardProp:new({number = cfg[i].goods_show_number, count = cfg[i].goods_number});
        end
        -- if i == 1 then
        --     cardInfo.rarity = 4;
        -- elseif i == 2 then
        --     cardInfo.rarity = 4;
        -- elseif  i == 3 then
        --     cardInfo.rarity = 3;
        -- end
        -- local cardInfo = CardProp:new({number = cfg[i+1].goods_show_number, count = cfg[i+1].goods_number});
        if not self.sim then
            self.sim = {};
        end
        if self.sim[i] then
            self.sim[i]:DestroyUi();
        end
        if PropsEnum.IsRole(cfg[i].goods_show_number) then
            self.sim[i] = SmallCardUi:new( { parent = self.obj_item[i], info = cardInfo, customUpdateTip = true, sgroup=1, as_reward = true});
            self.sim[i]:SetSpNew(false);
            self.sim[i]:SetCallback(self.bindfunc["on_click_head_detail"]);
        else
            self.sim[i] = UiSmallItem:new({cardInfo = cardInfo, parent = self.obj_item[i],load_callback=function(obj)
                obj:SetCount(obj.cardInfo.count)
            end});
        end
        local isLight = ConfigManager.Get(EConfigIndex.t_first_recharge_reward,i).is_light;
        -- if isLight and isLight == 1 then
        --     self.fx[i]:set_active(true);
        -- else
        --     self.fx[i]:set_active(false);
        -- end
    end

    self.type = g_dataCenter.player:GetFirstRechargeType();
    if self.type == ENUM.ETypeFirstRecharge.noRecharge then
        self.lab_get:set_text(_UIText[1]);
    elseif self.type == ENUM.ETypeFirstRecharge.noGet then
        self.lab_get:set_text(_UIText[2]);
    elseif self.type == ENUM.ETypeFirstRecharge.haveGet then
        self.btn_get:set_active(false);
    end
end

-- function UiFirstRecharge:ShowNavigationBar()
--     return true;
-- end

--充值或领取奖励
function UiFirstRecharge:on_btn_get()
    --没充过值，充值
    if self.type == ENUM.ETypeFirstRecharge.noRecharge then
        uiManager:PushUi(EUI.StoreUI);
    --充过值，领取
    elseif self.type == ENUM.ETypeFirstRecharge.noGet then
        player.cg_get_first_recharge_reward();
    end
end

function UiFirstRecharge:on_click_head_detail( cardUI )
    app.log("--------------- 点击头像" .. tostring(cardUI.cardInfo.number));
    RecruitDetalUI:new(cardUI.cardInfo.number);
end

--关闭
function UiFirstRecharge:on_btn_close()
    uiManager:PopUi();
end

--得到奖励
function UiFirstRecharge:gc_btn_get(result, awards)
    uiManager:PopUi();
    self.awards = awards;
    -- CommonAward.Start({self.awards[1]}, 1);
    -- CommonAward.SetFinishCallback(self.show_item, self);

    local roleId = nil
    for _, v in pairs(self.awards) do
        if PropsEnum.IsRole(v.id) then 
            roleId = v.id
        end
    end
    if roleId ~= nil then 
        local cardInfo = CardHuman:new({number = roleId, level = 1})
        EggGetHero.Start(cardInfo, true);
        EggGetHero.SetFinishCallback(self.show_item, self);
    else
        CommonAward.Start(self.awards, 1)
    end
end

-- function UiFirstRecharge:show_hero()
--     CommonAward.Start({self.awards[#self.awards]}, 1);
--     CommonAward.SetFinishCallback(self.show_item, self);
-- end

function UiFirstRecharge:show_item()
    local temp = {}
    for _, v in pairs(self.awards) do
        if not PropsEnum.IsRole(v.id) then 
            table.insert(temp, v)
        end
    end
    CommonAward.Start(temp, 1);
end

function UiFirstRecharge:gc_update_flag(flag)
    self:UpdateUi();
end

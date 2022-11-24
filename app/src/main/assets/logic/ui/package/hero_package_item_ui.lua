HeroPackageItemUI = Class("HeroPackageItemUI");

--设置数据并刷新
function HeroPackageItemUI:SetInfo(info)
    self.cardInfo = info;
    self:UpdateUi();
end

function HeroPackageItemUI:GetInfo()
    return self.cardInfo
end
--设置点击强化的回调 callback(obj,info,param)
function HeroPackageItemUI:SetOnClick(callback, param)
    if callback == nil then 
        return
    end
    self._clickBtnCallback = callback
    self._param = param
end
--设置装备点击回调
function HeroPackageItemUI:SetOnClickEquip(callback, param)
    if callback == nil then 
        return
    end
    self._clickEquipBtnCallback = callback
    self._equipParam = param
end
--设置头像点击回调
function HeroPackageItemUI:SetOnClickHead(callback, param)
    if callback == nil then 
        return
    end
    self._clickHeadBtnCallback = callback
    self._headParam = param
end
--设置是否有上阵图标
function HeroPackageItemUI:SetIsTeam(is_team)
    if not self.ui then return end;
    if self.spOnTeam then
        self.spOnTeam:set_active(is_team);
    end
    if self.spOnTeamBg then
        self.spOnTeamBg:set_active(is_team);
    end
end
--置灰
function HeroPackageItemUI:SetGrey(is_grey)
    if not self.ui then return end;
    if is_grey then
        self.texHead:set_color(0.5,0.5,0.5,1);
        self.spBg:set_color(0.5,0.5,0.5,1);
    else
        self.texHead:set_color(1,1,1,1);
        self.spBg:set_color(1,1,1,1);
    end
end


--置成黑白
function HeroPackageItemUI:SetBlack( is_black )
    if not self.ui then return end;
    if is_black then
        --self.texHead:set_color(0,0,0,1);
        --self.spBg:set_color(0,0,0,1);
        if self.spMark then
            self.spMask:set_active( true );
        end
        -- self.objStar:set_active( false );
    else
        --self.texHead:set_color(1,1,1,1);
        --self.spBg:set_color(1,1,1,1);
        if self.spMark then
            self.spMask:set_active( false );
        end
        -- self.objStar:set_active( true );
    end
end

function HeroPackageItemUI:Show()
    if not self.ui then return end;
    self.ui:set_active(true);
end
function HeroPackageItemUI:Hide()
    if not self.ui then return end;
    self.ui:set_active(false);
end

--------------------------内部接口--------------------------------
--传入obj 以及 cardhuman
function HeroPackageItemUI:Init(data)
    self:InitData(data);
    self:InitUi();
end

function HeroPackageItemUI:InitData(data)
    self.ui = data.obj;
    self.cardInfo = data.info;
    self.bindfunc = {}

    self:registFunc()
end

function HeroPackageItemUI:registFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click)
    self.bindfunc["on_click_equip"] = Utility.bind_callback(self, self.on_click_equip)
    self.bindfunc["on_click_head"] = Utility.bind_callback(self, self.on_click_head);
end

function HeroPackageItemUI:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function HeroPackageItemUI:InitUi()
    if self.ui == nil then
        return
    end
    self.spBg = ngui.find_sprite(self.ui,"sp_di");
    local obj = self.ui:get_child_by_name("big_card_item_80");
    local data = 
    {
        parent = obj;
        stypes = 
        {
            SmallCardUi.SType.Texture,
            SmallCardUi.SType.Rarity,
            SmallCardUi.SType.Qh,
            SmallCardUi.SType.Star,
            SmallCardUi.SType.Level,
            SmallCardUi.SType.Leader,
        }
    }
    self.objCard = SmallCardUi:new(data);
    self.objCard:SetCallback(self.bindfunc["on_click_head"]);
    self.objInfoRoot = self.ui:get_child_by_name("cont1");
    if self.objInfoRoot then
        --self.labName = ngui.find_label(self.ui,"cont1/sp_shuxing/lab_name");
        --self.spOcc = ngui.find_sprite(self.ui,"cont1/sp_shuxing");
        self.labNameExt = ngui.find_label(self.ui,"cont1/lab_name");

        self.labFightPower = ngui.find_label(self.ui,"cont1/sp_fight/lab_fight");
        self.objFightPower = self.ui:get_child_by_name("cont1/sp_fight");
        self.btnEquip = ngui.find_button(self.ui,"cont1/btn1");
        self.btnEquip:set_on_click(self.bindfunc["on_click_equip"]);
        self.btnQiangHua = ngui.find_button(self.ui,"cont1/btn2");
        self.btnQiangHua:set_on_click(self.bindfunc["on_click"]);
        self.btnLaiYuan = ngui.find_button(self.ui,"cont1/btn3");
        self.btnLaiYuan:set_on_click(self.bindfunc["on_click"]);
        self.btnQiangHua2 = ngui.find_button(self.ui,"cont1/btn4");
        self.btnQiangHua2:set_on_click(self.bindfunc["on_click"]);
        -- self.labBtnQiangHua2 = ngui.find_label(self.ui,"cont1/btn3/animation/lab");
        self.spEquipPoint = ngui.find_sprite(self.ui, "cont1/btn1/animation/sp_point" );
        self.spAttrPoint = ngui.find_sprite(self.ui, "cont1/btn2/animation/sp_point" );
        self.spAttrPoint2 = ngui.find_sprite(self.ui, "cont1/btn3/animation/sp_point" );
        self.spAttrPoint3 = ngui.find_sprite(self.ui, "cont1/btn4/animation/sp_point" );
        self.labGhoulNum = ngui.find_label(self.ui,"cont1/pro_bar/lab_num");
        self.proGhoul = ngui.find_progress_bar(self.ui,"cont1/pro_bar");
    end

    self.rootZhaoMu = self.ui:get_child_by_name("cont2");
    if self.rootZhaoMu then
        --self.labName2 = ngui.find_label(self.ui,"cont2/sp_shuxing/lab_name");
        --self.spOcc2 = ngui.find_sprite(self.ui,"cont2/sp_shuxing");
        self.labName2Ext = ngui.find_label(self.ui,"cont2/lab_name");

        self.btnZhaoMu = ngui.find_button(self.ui,"cont2/btn");
        self.btnZhaoMu:set_on_click(self.bindfunc["on_click"]);
    end

    --更新
    self:UpdateUi();
end

function HeroPackageItemUI:on_click(param)
    if self._clickBtnCallback ~= nil then
        Utility.CallFunc(self._clickBtnCallback,self,self.cardInfo,self._param)
    end
end

function HeroPackageItemUI:on_click_equip()
    if self._clickEquipBtnCallback ~= nil then
        Utility.CallFunc(self._clickEquipBtnCallback,self,self.cardInfo,self._equipParam)
    end
end

function HeroPackageItemUI:on_click_head()
    if self._clickHeadBtnCallback ~= nil then
        Utility.CallFunc(self._clickHeadBtnCallback,self,self.cardInfo,self._headParam)
    end
end

function HeroPackageItemUI:UpdateUi()
    if not self.ui then return end;

    if self.cardInfo then
        -- local useName, addNum = PublicFunc.ProcessNameSplit( self.cardInfo.name );
        -- if addNum > 0 then
        --     useName = useName.."+"..addNum;
        -- end
        local useName = self.cardInfo.name;
        self.objCard:SetData(self.cardInfo);
        if self.rootZhaoMu then
            self.labName2Ext:set_text(useName);
            self.labName2Ext:set_color( 1, 1, 1, 1 );
            --PublicFunc.SetProTypePic(self.spOcc2,self.cardInfo.pro_type, 3);
        end
        if self.objInfoRoot then
            --PublicFunc.SetProTypePic(self.spOcc,self.cardInfo.pro_type, 3);
            self.labNameExt:set_text(useName);
            self.labNameExt:set_color( 1, 1, 1, 1 );
        end
        self.objCard:SetFormationIcon(g_dataCenter.player:IsTeam(self.cardInfo.index));
        self.objCard:SetGray(self.cardInfo.index == 0);

        -- 拥有的英雄
        if self.cardInfo.index ~= 0 then
            self.spBg:set_sprite_name("ty_liebiaokuang3");
            self.spBg:set_color(1,1,1,1);
            if self.rootZhaoMu then
                self.rootZhaoMu:set_active(false);
            end
            if self.objInfoRoot then
                self.objInfoRoot:set_active(true);
                self.labFightPower:set_text(tostring(self.cardInfo:GetFightValue(--[[ENUM.ETeamType.normal]])));
                -- self.labBtnQiangHua2:set_text("强化");
                local open_level = ConfigManager.Get(EConfigIndex.t_play_vs_data,62000006).open_level;
                self.btnLaiYuan:set_active(false);
                if g_dataCenter.player:GetLevel() >= open_level then
                    self.btnQiangHua2:set_active(false);
                    self.btnQiangHua:set_active(true);
                    self.btnEquip:set_active(true);
                else
                    self.btnQiangHua2:set_active(true);
                    self.btnQiangHua:set_active(false);
                    self.btnEquip:set_active(false);
                end
                self.proGhoul:set_active(false);
                self.objFightPower:set_active(true);
                if AppConfig.get_enable_guide_tip() then
                    if self.cardInfo:CanPowerUp() then
                        self.spAttrPoint:set_active(true);
                        self.spAttrPoint3:set_active(true);
                    else
                        self.spAttrPoint:set_active(false);
                        self.spAttrPoint3:set_active(false);
                    end
                    if PublicFunc.ToBoolTip(self.cardInfo:CanLevelUpAnyEquip()) or PublicFunc.ToBoolTip(self.cardInfo:CanStarUpAnyEquip()) then
                        self.spEquipPoint:set_active(true);
                    else
                        self.spEquipPoint:set_active(false);
                    end
                end
            end
        -- 未获得英雄
        else
            local souls = g_dataCenter.package:GetCountByNumber(self.cardInfo.config.hero_soul_item_id);
            local pro_value = souls/self.cardInfo.config.get_soul;
            -- 可招募
            if pro_value >= 1 then
                self.spBg:set_sprite_name("ty_liebiaokuang1");
                self.spBg:set_color(1,1,1,1);
                if self.rootZhaoMu then
                    self.rootZhaoMu:set_active(true);
                end
                if self.objInfoRoot then
                    self.objInfoRoot:set_active(false);
                end
            -- 不可招募
            else
                self.spBg:set_sprite_name("ty_liebiaokuang3");
                self.spBg:set_color(0,0,0,1);
                if self.rootZhaoMu then
                    self.rootZhaoMu:set_active(false);
                end
                if self.objInfoRoot then
                    self.objInfoRoot:set_active(true);
                    self.btnLaiYuan:set_active(true);
                    self.btnQiangHua2:set_active(false);
                    self.btnQiangHua:set_active(false);
                    self.btnEquip:set_active(false);
                    -- self.labBtnQiangHua2:set_text("来源");
                    self.proGhoul:set_active(true);
                    self.proGhoul:set_value(pro_value);
                    self.labGhoulNum:set_text(souls.."/"..self.cardInfo.config.get_soul)
                    self.objFightPower:set_active(false);
                end
            end
        end
    else
        if self.rootZhaoMu then
            self.rootZhaoMu:set_active(false);
        end
        if self.objInfoRoot then
            self.objInfoRoot:set_active(false);
        end
    end
end

function HeroPackageItemUI:Destroy()
    self.ui = nil;
    self.cardInfo = nil;
    -- self.texHead:Destroy();
    -- self.texHead = nil;

    self:unregistFunc()
    self.bindfunc = {}

    if self.objCard then
        self.objCard:DestroyUi()
        self.objCard = nil
    end
end

------------------------ 新手引导接口函数 -----------------------
function HeroPackageItemUI:GetBtnUiByType(type)
    if type == 1 then
        return self.btnEquip:get_game_object()
    elseif type == 2 then
        if self.btnQiangHua:get_game_object():get_active() then
            return self.btnQiangHua:get_game_object()
        else
            return self.btnQiangHua2:get_game_object()
        end
    elseif type == 3 then
        return self.btnZhaoMu:get_game_object()
    else
        return self.ui
    end
end

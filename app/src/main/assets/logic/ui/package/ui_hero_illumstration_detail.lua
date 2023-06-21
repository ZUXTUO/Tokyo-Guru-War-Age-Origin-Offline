HeroIllumstrationDetailUI = Class("HeroIllumstrationDetailUI", UiBaseClass)

local CareerTypePic =
{
    [1] = "yxtj_xingxing1",
    [2] = "yxtj_xingxing2",
    [3] = "yxtj_xingxing3",
}

local _UIText = {
    [1] = "获取",
    [2] = "升星",
    [3] = "收集加成[满级]:",

    [4] = "[F39998FF]生命[-] ",
    [5] = "[F39998FF]攻击[-] ",
    [6] = "[F39998FF]防御[-] ",
    [7] = "收集加成[进度%s/%s]:",
    [8] = "%s星升%s星加成",
    [9] = "满星加成:",
}

local _ChineseNumber = {
    [1] = "一",
    [2] = "二",
    [3] = "三",
    [4] = "四",
    [5] = "五",
    [6] = "六",
    [7] = "七",
    [8] = "八",
    [9] = "九",
}


function HeroIllumstrationDetailUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/card_illumstration/ui_612_hero_photo.assetbundle";
    --self.cardInfo = data
    UiBaseClass.Init(self, data)
end

function HeroIllumstrationDetailUI:Restart(data)
    self.cardInfo = data
    if UiBaseClass.Restart( self, data ) then
    end
end

function HeroIllumstrationDetailUI:RegistFunc()
    UiBaseClass.RegistFunc(self)    
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close)
    self.bindfunc["gotoupstarUi"] = Utility.bind_callback(self, self.gotoupstarUi)
    self.bindfunc["on_click_update_ill"] = Utility.bind_callback(self, self.on_click_update_ill)
    self.bindfunc["gc_illumstration_active"] = Utility.bind_callback( self, self.gc_illumstration_active );
    self.bindfunc["gc_illumstration_update"] = Utility.bind_callback( self, self.gc_illumstration_update );
    self.bindfunc["go_to_acquiring"] = Utility.bind_callback( self, self.go_to_acquiring );
end

function HeroIllumstrationDetailUI:DestroyUi()

    UiBaseClass.DestroyUi(self)
    if self.Rolepic then
        self.Rolepic:DestroyUi()
    end
end

function HeroIllumstrationDetailUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist( msg_cards.gc_illumstration_active, self.bindfunc["gc_illumstration_active"] );
    PublicFunc.msg_regist( msg_cards.gc_illumstration_update, self.bindfunc["gc_illumstration_update"] );
end

function HeroIllumstrationDetailUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist( msg_cards.gc_illumstration_active, self.bindfunc["gc_illumstration_active"] );
    PublicFunc.msg_unregist( msg_cards.gc_illumstration_update, self.bindfunc["gc_illumstration_update"] );
end

function HeroIllumstrationDetailUI:on_close()
    --HeroIllumstrationDetailUI.End()
    uiManager:PopUi()
end

function HeroIllumstrationDetailUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("hero_illumstration_detail")
    local btnClose = ngui.find_button(self.ui, "centre_other/animation/content_di_754_458/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_close"])

    self.playerhead = self.ui:get_child_by_name("centre_other/animation/cont/new_small_card_item")
    self.playername = ngui.find_label(self.ui,"centre_other/animation/cont/lab_name")
    
    self.playerstar = {}
    for i=1,7 do
        self.playerstar[i] = ngui.find_sprite(self.ui,"centre_other/animation/cont/grid_star/sp_star"..i)
        self.playerstar[i]:set_sprite_name(CareerTypePic[3])
    end
    
    self.upstarbtn = ngui.find_button(self.ui,"centre_other/animation/cont/btn_yellow")
    self.upstarbtn:set_on_click(self.bindfunc["gotoupstarUi"])
    
    self.infobtn = ngui.find_button(self.ui,"centre_other/animation/cont/btn_rule")
    self.infobtn:set_on_click(self.bindfunc["go_to_acquiring"])
    
    self.infolab = ngui.find_label(self.ui,"centre_other/animation/cont/lab_title")

    --标题文字
    self.toptitlelab = ngui.find_label(self.ui,"centre_other/animation/content_di_754_458/lab_title/lab_title2")

    self.updatabtn = ngui.find_button(self.ui,"centre_other/animation/cont/btn_blue")
    self.updatalab = ngui.find_label(self.ui,"centre_other/animation/cont/btn_blue/animation/lab")
    self.updatabtn:set_on_click(self.bindfunc["on_click_update_ill"])

    self.probarvaluelab = ngui.find_label(self.ui,"centre_other/animation/cont/pro_bar/lab_num")

    self.spPointRed = ngui.find_sprite(self.ui,"centre_other/animation/cont/btn_blue/animation/sp_point")

    self.probar = ngui.find_progress_bar( self.ui, "centre_other/animation/cont/pro_bar")

    self.max_fx = self.ui:get_child_by_name("centre_other/animation/cont/sp_art_font")
    self.max_fx:set_active(false)

    self.downInfo = {
        --spUpTop = ngui.find_sprite(self.ui, d2Path .. "sp_effect"),
        lblTitle = ngui.find_label(self.ui, "centre_other/animation/cont/lab_title"),
        prop = {
            [1] = {
                lblTitle =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk1/txt"),
                lblValue =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk1/content/lab_num1"),
                spArrow =  ngui.find_sprite(self.ui, "centre_other/animation/cont/cont_nature/sp_bk1/content/sp_arrows"),
                lblValueAdd =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk1/content/lab_num2"),
            },
            [2] = {
                lblTitle =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk2/txt"),
                lblValue =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk2/content/lab_num1"),
                spArrow =  ngui.find_sprite(self.ui, "centre_other/animation/cont/cont_nature/sp_bk2/content/sp_arrows"),
                lblValueAdd =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk2/content/lab_num2"),
            },
            [3] = {
                lblTitle =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk3/txt"),
                lblValue =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk3/content/lab_num1"),
                spArrow =  ngui.find_sprite(self.ui, "centre_other/animation/cont/cont_nature/sp_bk3/content/sp_arrows"),
                lblValueAdd =  ngui.find_label(self.ui, "centre_other/animation/cont/cont_nature/sp_bk3/content/lab_num2"),
            }
        }
    }

    self:setData()
end

function HeroIllumstrationDetailUI:setData()
    self.playername:set_text(self.cardInfo.name)
    self.Rolepic = SmallCardUi:new({parent=self.playerhead,info=self.cardInfo,stypes ={SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity,SmallCardUi.SType.Star}});
    local souls = g_dataCenter.package:GetCountByNumber(self.cardInfo.config.hero_soul_item_id)
    local needSoul = self.cardInfo.config.get_soul
    -- app.log("souls========"..tostring(souls))
    -- app.log("needSoul====="..tostring(needSoul))
    if souls < needSoul then
        --显示获取途径
        self.upstarbtn:set_active(false)
    else
        --显示升星
        self.infobtn:set_active(false)
    end

    self:set_star()
    self:set_probar()
    self:UpdateCardInfo()

    --红点
    if self.cardInfo.illumstration_number == 0 then
        self.spPointRed:set_active(true)
    else
        if self.cardInfo.illumstration_number < self.cardInfo.rarity then
            self.spPointRed:set_active(true)
        else
            self.spPointRed:set_active(false)
        end
    end

end

function HeroIllumstrationDetailUI:go_to_acquiring(t)
    app.log("go_to_acquiring========================")
    local data = {};
    data.item_id = self.cardInfo.config.hero_soul_item_id;
    data.number = self.cardInfo.config.get_soul;
    AcquiringWayUi.Start(data);
end

function HeroIllumstrationDetailUI:set_star()
    local defaultStar = PublicFunc.getRoleCardCurStar( self.cardInfo.default_rarity );
    local currentStar = self.cardInfo.illumstration_number

    for i=1,7 do
        -- if i> defaultStar then
            self.playerstar[i]:set_sprite_name(CareerTypePic[3])
        -- else
        --     self.playerstar[i]:set_sprite_name(CareerTypePic[2])
        -- end
    end
    
    if currentStar == 0 then
        -- for i=1,defaultStar do
        --     if i < defaultStar then
        --         self.playerstar[i]:set_sprite_name(CareerTypePic[2])
        --     else
        --         self.playerstar[i]:set_sprite_name(CareerTypePic[1])
        --     end
        -- end
        --self.toptitlelab1:set_text("档案")
        self.toptitlelab:set_text("激活")
        self.updatalab:set_text("激活")
        self:hide_max_fx()
    else
        for i=1,currentStar do
            if currentStar >= self.cardInfo.rarity then
                self.playerstar[i]:set_sprite_name(CareerTypePic[2])
            else
                if i == currentStar then
                    self.playerstar[i]:set_sprite_name(CareerTypePic[1])
                 else
                    self.playerstar[i]:set_sprite_name(CareerTypePic[2])
                end
            end
        end
        self.toptitlelab:set_text("更新")
        self.updatalab:set_text("更新")

        if ENUM.RoleMaxStarLevel > currentStar then
            self:hide_max_fx()
        else
            self:show_max_fx()
        end
    end
    

    -- for i=1,currentStar do
    --     if currentStar == 0 then
    --         if i == defaultStar then
    --             self.playerstar[i]:set_sprite_name(CareerTypePic[1])
    --         else
    --             self.playerstar[i]:set_sprite_name(CareerTypePic[2])
    --         end
    --     else
    --         if currentStar >= self.cardInfo.rarity then
    --             self.playerstar[i]:set_sprite_name(CareerTypePic[2])
    --         else
    --             if i == defaultStar then
    --                 self.playerstar[i]:set_sprite_name(CareerTypePic[1])
    --              else
    --                 self.staricon[i]:set_sprite_name(CareerTypePic[2])
    --             end
    --         end 
    --     end
    -- end
end

function HeroIllumstrationDetailUI:set_probar()

    local cardInfo = self.cardInfo
    local souls = g_dataCenter.package:GetCountByNumber(cardInfo.config.hero_soul_item_id);
    if cardInfo.index == 0 then
        local pro_value = souls/cardInfo.config.get_soul;
        if pro_value > 1 then
            pro_value = 1;
        end
        self.probar:set_value(pro_value);
        self.probarvaluelab:set_text("[973900FF]"..souls.."[-][000000FF]/"..cardInfo.config.get_soul.."[-]")
    else 
        local pro_value = souls/cardInfo.config.soul_count;
        if pro_value > 1 then
            pro_value = 1;
        end
        self.probar:set_value(pro_value);
        self.probarvaluelab:set_text("[973900FF]"..souls.."[-][000000FF]/"..cardInfo.config.soul_count.."[-]")
    end 
end

function HeroIllumstrationDetailUI:gotoupstarUi()
    uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar, 
             cardInfo = self.cardInfo, is_player = true});
    --self:Hide()
end

function HeroIllumstrationDetailUI:UpdateCardInfo()

    local cardInfo = self.cardInfo
    self:initSelectAddCountInfo(cardInfo)
    --当前没用拥有的英雄，显示内容
    local curAddTxt = "";
    --self.spPointRed:set_active(false);
    --app.log("self.spPointRed deactive");

    local defaultCardInfo = ConfigHelper.GetRole(cardInfo.default_rarity);

    -- self.btnUp:set_active(false)   
    -- self.btnActive:set_active(false)
    -- self.downInfo.spUpTop:set_active(false)

    -- self.objShuiPian:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)
    -- self.probar:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)
    -- self.btnGet:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)

    for i = 1, 3 do
        self.downInfo.prop[i].spArrow:set_active(false)
        self.downInfo.prop[i].lblValue:set_text("")
        self.downInfo.prop[i].lblValueAdd:set_text("")
    end

    if cardInfo.index == 0 then
        --self.lblGet:set_text(_UIText[1])
        curAddTxt = _UIText[3];
        --self.commonInfo.spGetIcon:set_sprite_name("yxtj_weihuode")

        for i = 1, 3 do
            self.downInfo.prop[i].lblTitle:set_active(false)
        end
        self:SetFullStarAddDesc(cardInfo)

        --self.collectStageLab:set_text("进度0/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
    else
        --self.lblGet:set_text(_UIText[2])
        --self.commonInfo.spGetIcon:set_sprite_name("yxtj_yihuode")
        for i = 1, 3 do
            self.downInfo.prop[i].lblTitle:set_active(true)
        end

        for i = 1, 3 do
            if i <= self.illAddInfoDisp.count then
                self.downInfo.prop[i].lblTitle:set_active(true)
                self.downInfo.prop[i].lblTitle:set_text(self.illAddInfoDisp.titleList[i]);
                self.downInfo.prop[i].lblValue:set_text("[00FF73FF]+"..tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.data[i])).."[-]");
            else
                self.downInfo.prop[i].lblTitle:set_active(false)
            end
        end

        if cardInfo.illumstration_number == 0 then
            --self.collectStageLab:set_text("进度0/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
            curAddTxt = string.format(_UIText[7], 0, ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity)
           
            --self.btnActive:set_active(true);
            --self.spPointRed:set_active(true);
            --app.log("self.spPointRed active");
            for i=1,3 do
                self.downInfo.prop[i].spArrow:set_active(true)
                self.downInfo.prop[i].lblValue:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.data[i])));
                self.downInfo.prop[i].lblValueAdd:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.nextData[i])) );
            end
        else 

            --local star_up_number = PublicFunc.getNextStarUpNumber( cardInfo.illumstration_number );
            --self.collectStageLab:set_text("进度"..tostring(cardInfo.illumstration_number + 1 - defaultCardInfo.rarity).."/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
            --if star_up_number > 0 then
            if cardInfo.illumstration_number < ENUM.RoleMaxStarLevel then
                curAddTxt = string.format(_UIText[8], _ChineseNumber[cardInfo.illumstration_number], _ChineseNumber[cardInfo.illumstration_number + 1])
                for i = 1, 3 do
                    if i <= self.illAddInfoDisp.count then
                        self.downInfo.prop[i].spArrow:set_active(true)
                        self.downInfo.prop[i].lblValue:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.data[i])));
                        self.downInfo.prop[i].lblValueAdd:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.nextData[i])) );
                    else
                        self.downInfo.prop[i].spArrow:set_active(false)
                    end
                end

                --self.btnUp:set_active( true );
                if cardInfo.illumstration_number >= cardInfo.rarity then
                    --self.updateBtnBG:set_color( 0, 0, 0, 1 );
                    --self.btnUp:set_event_value( "update", 0 );
                else
                    --self.updateBtnBG:set_color( 1, 1, 1, 1);
                    --self.btnUp:set_event_value( "update", 1 );
                    --self.spPointRed:set_active(true);
                    --app.log("self.spPointRed active");
                end
            else
                curAddTxt = _UIText[9];
                --self.objShuiPian:set_active(false)
                --self.proBar:set_active(false)
                --self.btnGet:set_active(false)
                --self.downInfo.spUpTop:set_active(true)
            end
        end
        
    end
    
    --统一都会显示的就是基础的收集数据，根据当前的数量来判定显示和内容
    self.downInfo.lblTitle:set_text(curAddTxt);

    --信息显示，名字，当前星级，技能，满星加成等等
    -- self.commonInfo.lblHeroName:set_text(cardInfo.name)
    -- self.commonInfo.lblHeroDesc:set_text(cardInfo.describe)
    -- self.commonInfo.scrollview:reset_position()
end

function HeroIllumstrationDetailUI:initSelectAddCountInfo( cardInfo )

    self.illAddInfoDisp = {};
    local data = {};
    local notHave = {};
    local titleList = {};
    local nextData = {};
    local count = 0;
    local defaultStar = PublicFunc.getRoleCardCurStar( cardInfo.default_rarity );
    local hp, atk, def = PublicFunc.getIllumstrationValue( cardInfo.default_rarity, defaultStar );
    local nextHp, nextAtk, nextDef = 0;
    --local star_up_number = PublicFunc.getNextStarUpNumber( cardInfo.illumstration_number );
    if cardInfo.index ~= 0 and cardInfo.illumstration_number >= 0 then
        hp, atk, def = PublicFunc.getIllumstrationValue( cardInfo.number, cardInfo.illumstration_number );
        if cardInfo.illumstration_number + 1 < 8 then
            nextHp, nextAtk, nextDef = PublicFunc.getIllumstrationValue( cardInfo.number, cardInfo.illumstration_number + 1 );
        end
    end
    -- if atk ~= 0 then
        table.insert(data, atk);
        table.insert(nextData, nextAtk);
        table.insert(titleList, "攻击" );
        count = count + 1;
    -- else
    --     table.insert( notHave, "atk" );
    -- end
    
    -- if hp ~= 0 then
        table.insert(data, hp);
        table.insert(nextData, nextHp);
        table.insert(titleList, "生命" );
        count = count + 1;
    -- else
    --     table.insert( notHave, "hp" );
    -- end
    
    -- if def ~= 0 then
        table.insert(data, def);
        table.insert(nextData, nextDef);
        table.insert(titleList, "防御" );
        count = count + 1;
    -- else
    --     table.insert( notHave, "def" );
    -- end

    self.illAddInfoDisp.count = count;
    self.illAddInfoDisp.data = data;
    self.illAddInfoDisp.nextData = nextData;
    self.illAddInfoDisp.titleList = titleList;
end

function HeroIllumstrationDetailUI:SetFullStarAddDesc(cardInfo)
    local addHP, addAtk, addDef = PublicFunc.getIllumstrationValue( cardInfo.number, ENUM.RoleMaxStarLevel);
    local info = {};
    if addHP ~= 0 then
        table.insert(info, {title = _UIText[4], value = PublicFunc.AttrInteger(addHP)});
    end
    if addAtk ~= 0 then
        table.insert(info, {title = _UIText[5], value = PublicFunc.AttrInteger(addAtk)});
    end
    if addDef ~= 0 then
        table.insert(info, {title = _UIText[6], value = PublicFunc.AttrInteger(addDef)});
    end
    for i = 1, 3 do
        if i <= #info then
            self.downInfo.prop[i].lblTitle:set_active(true)
            self.downInfo.prop[i].lblTitle:set_text(info[i].title);
            self.downInfo.prop[i].lblValue:set_text("+"..tostring(info[i].value))
        else
            self.downInfo.prop[i].lblTitle:set_active(false)
        end
    end
end


function HeroIllumstrationDetailUI:on_click_update_ill( )
    --更新按钮事件

    if self.cardInfo.illumstration_number >= self.cardInfo.rarity then
        FloatTip.Float("已提升至当前最高等级");
        do return end
    end

    if self.cardInfo then
        if self.cardInfo.illumstration_number > 0 then
            msg_cards.cg_illumstration_update(self.cardInfo.index );
        else
            msg_cards.cg_illumstration_active(self.cardInfo.index);
        end
    end
end


--图鉴激活回调
function HeroIllumstrationDetailUI:gc_illumstration_active( dataid, illum_number, ret )
    if ret == 1 then
     
        self.cardInfo.illumstration_number = illum_number;
        self:initSelectAddCountInfo( self.cardInfo );
        self:setData();
        --self:RefreshActiveAndUpdateEffect( self.heroList[self.curSelectIndex] )
        --self:UpdateTotalIllumstrationValue();
        AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpNormal)
    else 
        FloatTip.Float("激活出错,错误码："..tostring(ret));
    end
end

--图鉴提升回调
function HeroIllumstrationDetailUI:gc_illumstration_update( dataid, illum_number, ret )
    if ret == 1 then
        self.cardInfo.illumstration_number = illum_number;
        self:initSelectAddCountInfo( self.cardInfo);
        self:setData();
    end
end

function HeroIllumstrationDetailUI:Hide()

    if self.ui then
        --self.ui:set_position(10000,0,0)
        self.ui:set_active(false)
    end
  
end

function HeroIllumstrationDetailUI:Show()

    if self.ui then
        --self.ui:set_position(0,0,0)
        self.ui:set_active(true)
        self:setData()
    end
  
end

function HeroIllumstrationDetailUI:show_max_fx()
    self.max_fx:set_active(true)
    self.updatabtn:set_active(false)
end

function HeroIllumstrationDetailUI:hide_max_fx()
    self.max_fx:set_active(false)
    self.updatabtn:set_active(true)
end
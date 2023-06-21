---fileName:ui_hero_illumstration.lua
---desc:用于英雄图鉴功能的操作
---code by:fengyu
---date:2016-7-1

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
    [8] = "%s星升%s星加成:",
    [9] = "满星加成:",
    [10] = "收集加成:",
}

HeroIllumstrationUI = Class( "HeroIllumstrationUI", UiBaseClass );

function HeroIllumstrationUI:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/card_illumstration/ui_611_hero_photo.assetbundle";
    UiBaseClass.Init( self, data );
end

function HeroIllumstrationUI:Restart( data )
    self.curSelectIndex = 1;
    self.currentpage = data;
    self.curDefaultRarityNumber = nil
    self.loadingUIId = GLoading.Show(GLoading.EType.loading,0);
    if UiBaseClass.Restart( self, data ) then
    end
end

function HeroIllumstrationUI:OnLoadUI()
    --UiBaseClass.PreLoadUIRes( Show3d, Root.empty_func );
end

function HeroIllumstrationUI:RegistFunc()
    UiBaseClass.RegistFunc( self );
    
    self.bindfunc["gc_illumstration_active"] = Utility.bind_callback( self, HeroIllumstrationUI.gc_illumstration_active );
    self.bindfunc["gc_illumstration_update"] = Utility.bind_callback( self, HeroIllumstrationUI.gc_illumstration_update );
    --self.bindfunc["init_item"] = Utility.bind_callback( self, HeroIllumstrationUI.init_item );
    self.bindfunc["playerinfoshow"] = Utility.bind_callback( self, HeroIllumstrationUI.playerinfoshow );
    self.bindfunc["on_click_active_ill"] = Utility.bind_callback( self, HeroIllumstrationUI.on_click_active_ill );
    self.bindfunc["on_click_update_ill"] = Utility.bind_callback( self, HeroIllumstrationUI.on_click_update_ill );
    self.bindfunc["on_collect_hero"] = Utility.bind_callback( self, HeroIllumstrationUI.on_collect_hero );
    self.bindfunc["on_click_detail"] = Utility.bind_callback( self, self.on_click_detail );
    self.bindfunc["on_chose_hero"] = Utility.bind_callback(self,self.on_chose_hero);
    self.bindfunc["on_toggle_change"] = Utility.bind_callback(self,self.on_toggle_change);
    self.bindfunc["on_click_ye"] = Utility.bind_callback(self,self.on_click_ye);

end

function HeroIllumstrationUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function HeroIllumstrationUI:MsgRegist()
    PublicFunc.msg_regist( msg_cards.gc_illumstration_active, self.bindfunc["gc_illumstration_active"] );
    PublicFunc.msg_regist( msg_cards.gc_illumstration_update, self.bindfunc["gc_illumstration_update"] );
    UiBaseClass.MsgRegist(self); 
end

function HeroIllumstrationUI:MsgUnRegist()
    PublicFunc.msg_unregist( msg_cards.gc_illumstration_active, self.bindfunc["gc_illumstration_active"] );
    PublicFunc.msg_unregist( msg_cards.gc_illumstration_update, self.bindfunc["gc_illumstration_update"] );
    UiBaseClass.MsgUnRegist(self);
end

function HeroIllumstrationUI:InitData( data )
    UiBaseClass.InitData( self, data );

    --英雄头像图标
    self.heroIconList = {};
    self.heroList = {};
    self.selectSP = {};
    --用于当前选择英雄的属性加成数量{hp=123, atk=123, def=123}
    self.illAddInfoDisp = {};
end


function HeroIllumstrationUI:DestroyUi()
    -- if self.roleInfo then
    --     self.roleInfo:DestroyUi()
    --     self.roleInfo = nil
    -- end

    if self.heroBigItem then
        self.heroBigItem:DestroyUi()
        self.heroBigItem = nil
    end
    --HeroIllumstrationDetailUI.End()   
    
    if self.choseHero then
        self.choseHero = nil
    end

    Show3d.Destroy();

    if self.heroListUi then
        self.heroListUi:DestroyUi()
        self.heroListUi = nil
    end
    --self.heroListUi = nil;

    for k, icon in pairs( self.heroIconList ) do
        for key, item in pairs( icon ) do
            if item then   
                item:Destroy();
            end
        end
    end

    if self.get_hero_audio ~= nil then
        AudioManager.StopUiAudio(self.get_hero_audio)
        self.get_hero_audio = nil
    end

    self.heroList = {};
    self.heroIconList = {};
    self.selectSP = {};
    --Show3d.Destroy();
    UiBaseClass.DestroyUi( self );
end

function HeroIllumstrationUI:playerinfoshow(t)
    -- if self.roleInfo then
    --     self.roleInfo:SetInfo(self.choseHero, true, self.heroListUi.heroDataList)
    --     self.roleInfo:Show();
    -- else
    --     local data = 
    --     {
    --         info = self.choseHero,
    --         isPlayer = true,
    --         heroDataList = self.heroListUi.heroDataList, -- 传入当前列表数据
    --     }
    --     self.roleInfo = BattleRoleInfoUI:new(data);
    -- end

    local data = 
    {   info = self.choseHero,
        isPlayer = true,
        heroDataList = self.heroListUi.heroDataList,
    }

    uiManager:PushUi(EUI.BattleRoleInfoUI,data)

end

function HeroIllumstrationUI:on_click_detail()
    if self.choseHero then
    --if self.curSelectIndex > 0 and self.heroList[self.curSelectIndex] then
        --HeroIllumstrationDetailUI.Start(self.choseHero)
        uiManager:PushUi(EUI.HeroIllumstrationDetailUI,self.choseHero)
    end
    --end
end

function HeroIllumstrationUI:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    self.ui:set_name( "hero_illumstration_ui" );

    self.haveui = self.ui:get_child_by_name("centre_other/animation/right_content/sp_di/content2")  --已获得英雄
    self.nohaveui = self.ui:get_child_by_name("centre_other/animation/right_content/sp_di/content1")    --未获得英雄

    self.AcquiringWayBtn = ngui.find_button(self.ui,"centre_other/animation/right_content/sp_di/btn_yellow") -- 获取途径按钮
    self.AcquiringWayBtn:set_on_click(self.bindfunc["on_collect_hero"])
    
    self.spPointRed = ngui.find_sprite(self.ui,"centre_other/animation/right_content/sp_di/content1/btn_blue/animation/sp_point")

    self.haveherolab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/lab_hero_num")    --已拥有英雄个数
    self.pinzipic = ngui.find_sprite(self.ui,"centre_other/animation/right_content/sp_di/sp_pinzhi")         --品质
    self.playerinfobtn = ngui.find_button(self.ui,"centre_other/animation/right_content/sp_di/btn_rule")
    self.playerinfobtn:set_on_click(self.bindfunc["playerinfoshow"])

    self.playernamelab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/lab_name")
    self.soundlab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/lab_sound")  --声优文字
    self.desscrolllview = ngui.find_scroll_view(self.ui,"centre_other/animation/right_content/sp_di/content1/scroll_view/panel_list")  --reset_position
    self.deslab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/scroll_view/panel_list/lab_describe")
    self.updatebtn = ngui.find_button(self.ui,"centre_other/animation/right_content/sp_di/content1/btn_blue")
    self.updatelab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/btn_blue/animation/lab") -- 按钮文字
    self.updatebtn:set_on_click(self.bindfunc["on_click_detail"])
    --提升属性文字
    self.titleAddlab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/sp_title/txt")
    self.titleAddlab:set_text(_UIText[10])

    self.shengyoulab = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/lab_sound")

    self.totalAdd = { 
        lblHP = ngui.find_label(self.ui, "centre_other/animation/right_content/sp_di/content1/grid_nature/lab_nature1"),
        lblAttack = ngui.find_label(self.ui, "centre_other/animation/right_content/sp_di/content1/grid_nature/lab_nature2"),
        lblDefense = ngui.find_label(self.ui,"centre_other/animation/right_content/sp_di/content1/grid_nature/lab_nature3"),
    }

    self.changeSelectYe1 = ngui.find_toggle(self.ui,"centre_other/animation/right_content/yeka/yeka1")
    self.changeSelectYe1:set_on_change(self.bindfunc["on_toggle_change"])
    self.changeSelectYe1Btn = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka1")
    self.changeSelectYe1Btn:set_on_click(self.bindfunc["on_click_ye"],"MyButton.Flag")

    self.changeSelectYe2 = ngui.find_toggle(self.ui,"centre_other/animation/right_content/yeka/yeka2")
    self.changeSelectYe2:set_on_change(self.bindfunc["on_toggle_change"])
    self.changeSelectYe2Btn = ngui.find_button(self.ui,"centre_other/animation/right_content/yeka/yeka2")
    self.changeSelectYe2Btn:set_on_click(self.bindfunc["on_click_ye"],"MyButton.Flag")

    --星级
    self.staricon = {}
    for i=1,7 do
        self.staricon[i] = ngui.find_sprite(self.ui,"centre_other/animation/right_content/sp_di/content1/grid_star/sp_star"..i)
        self.staricon[i]:set_sprite_name(CareerTypePic[3])
    end

    self.hero3D = ngui.find_sprite(self.ui,"centre_other/animation/left_content/sp_human")
    self.nohaveherodi = self.ui:get_child_by_name("centre_other/animation/right_content/sp_di/sp_bk")

    --底部列表
    self.down_other = self.ui:get_child_by_name("down_other/animation/panel_list_hero_item")

    --满级特效、
    self.max_fx = self.ui:get_child_by_name("centre_other/animation/right_content/sp_di/content1/sp_art_font")
    self.max_fx:set_active(false)

    if self.heroListUi == nil then
        self.heroListUi = CommonHeroListUI:new({
            parent = self.down_other,
            heroShowType = ENUM.EShowHeroType.All,
            tipType = SmallCardUi.TipType.illumstration,
            callback = {
                update_choose_hero = self.bindfunc["on_chose_hero"],
                cancel_choose_hero = self.bindfunc["on_chose_hero"],
            }
        });

        --app.log("currentpage============"..tostring(self.currentpage))
        if self.currentpage == 2 then
            self.changeSelectYe2:set_value(true)
            self.changeSelectYe1:set_value(false)
            self.heroListUi:UpdateUi(ENUM.EHeroCcgType.SSG);
        elseif self.currentpage == 1 then
            self.changeSelectYe1:set_value(true)
            self.changeSelectYe2:set_value(false)
            self.heroListUi:UpdateUi(ENUM.EHeroCcgType.CCG);
        end
    end 

    Show3d.Addquote()
    GLoading.Hide(GLoading.EType.loading, self.loadingUIId);

    do return end
    -- local leftContPath = "centre_other/animation/left_cont/"
    -- local rightContPath = "centre_other/animation/right_cont/"
    
    -- self.heroWrapper = ngui.find_wrap_content(self.ui, leftContPath .. "scroll_view/panel_list/wrap_content");
    -- self.heroWrapper:set_on_initialize_item(self.bindfunc["init_item"] );
    -- self.scrollview = ngui.find_scroll_view(self.ui, leftContPath .. "scroll_view/panel_list");

    -- self.totalAdd = {
    --     lblHP = ngui.find_label(self.ui, leftContPath .. "sp_bk/lab_life"),
    --     lblAttack = ngui.find_label(self.ui, leftContPath .. "sp_bk/lab_attack"),
    --     lblDefense = ngui.find_label(self.ui, leftContPath .. "sp_bk/lab_defense"),
    -- }

    -- local bkPath = rightContPath .. 'sp_di/sp_bk/'
    -- local btnDetail = ngui.find_button(self.ui, bkPath .. 'btn_rule')
    -- btnDetail:set_on_click(self.bindfunc["on_click_detail"])

    -- self.heroBigItem = UiBigCard:new({
    --     parent = self.ui:get_child_by_name(bkPath .. "cont_big_item"), 
    --     infoType = 1,
    --     showAddButton = false,
    --     showPro = true,
    -- })     

    -- self.commonInfo = {
    --     lblHeroName = ngui.find_label(self.ui, bkPath .. "lab_name"),
    --     lblHeroDesc = ngui.find_label(self.ui, "centre_other/animation/scroll_view/panel_list/txt_describe"),
    --     scrollview = ngui.find_scroll_view(self.ui, "centre_other/animation/scroll_view/panel_list"),
    --     spGetIcon = ngui.find_sprite(self.ui, bkPath .. "cont_big_item/sp_art_font"),
    -- }
    -- --获取
    -- self.btnGet = ngui.find_button(self.ui, rightContPath .. 'sp_di/btn2')
    -- self.btnGet:set_on_click(self.bindfunc["on_collect_hero"])
    -- self.lblGet = ngui.find_label(self.ui, rightContPath .. 'sp_di/btn2/animation/lab')

    -- local d2Path = rightContPath .. 'sp_di2/'
    -- self.downInfo = {
    --     spUpTop = ngui.find_sprite(self.ui, d2Path .. "sp_effect"),
    --     lblTitle = ngui.find_label(self.ui, d2Path .. "txt"),
    --     prop = {
    --         [1] = {
    --             lblTitle =  ngui.find_label(self.ui, d2Path .. "txt_life"),
    --             lblValue =  ngui.find_label(self.ui, d2Path .. "txt_life/lab_life"),
    --             spArrow =  ngui.find_sprite(self.ui, d2Path .. "txt_life/sp_arrows"),
    --             lblValueAdd =  ngui.find_label(self.ui, d2Path .. "txt_life/sp_arrows/lab_jia"),
    --         },
    --         [2] = {
    --             lblTitle =  ngui.find_label(self.ui, d2Path .. "txt_attack"),
    --             lblValue =  ngui.find_label(self.ui, d2Path .. "txt_attack/lab_life"),
    --             spArrow =  ngui.find_sprite(self.ui, d2Path .. "txt_attack/sp_arrows"),
    --             lblValueAdd =  ngui.find_label(self.ui, d2Path .. "txt_attack/sp_arrows/lab_jia"),
    --         },
    --         [3] = {
    --             lblTitle =  ngui.find_label(self.ui, d2Path .. "txt_defense"),
    --             lblValue =  ngui.find_label(self.ui, d2Path .. "txt_defense/lab_life"),
    --             spArrow =  ngui.find_sprite(self.ui, d2Path .. "txt_defense/sp_arrows"),
    --             lblValueAdd =  ngui.find_label(self.ui, d2Path .. "txt_defense/sp_arrows/lab_jia"),
    --         }
    --     }
    -- }

    -- self.objShuiPian = self.ui:get_child_by_name(rightContPath .. "sp_bk/sp_sui_pian")
    -- self.proBar = ngui.find_progress_bar( self.ui, rightContPath .. 'sp_bk/pro_bar')
    -- self.lblProBar = ngui.find_label(self.ui, rightContPath .. 'sp_bk/pro_bar/lab')

    -- --提升
    -- self.btnUp = ngui.find_button(self.ui, d2Path .. 'btn1')
    -- self.btnUp:set_on_click(self.bindfunc["on_click_update_ill"])
    -- --激活
    -- self.btnActive = ngui.find_button(self.ui, d2Path .. 'btn2')
    -- self.btnActive:set_on_click(self.bindfunc["on_click_active_ill"]);

    --self:UpdateUi()
end

function HeroIllumstrationUI:on_toggle_change(value,name)
    
    app.log("value ================="..tostring(value))
    app.log("name =================="..name)

    if value == true and name == "yeka1" then
        self.heroListUi:UpdateUi(ENUM.EHeroCcgType.CCG)
    elseif value == true and name == "yeka2" then
        self.heroListUi:UpdateUi(ENUM.EHeroCcgType.SSG)
    end
end

function HeroIllumstrationUI:on_chose_hero(info)

    --app.log("on_chose_hero"..tostring(info.illumstration_number));
    if info == self.choseHero then
        do return end
    end

    self.desscrolllview:reset_position()
    self.choseHero = info;

    self:setheroinfo(info)
    self:UpdateTotalIllumstrationValue()
    self:bound3d()
end

function HeroIllumstrationUI:reshHeroIllumstrationUI()
    self:setheroinfo(self.choseHero)
    self:UpdateTotalIllumstrationValue()
end

function HeroIllumstrationUI:on_click_ye()

end

function HeroIllumstrationUI:setheroinfo(info)
    --app.log("#illumstration_number"..tostring(info.illumstration_number));

    if info.illumstration_number == 0 then
        self.spPointRed:set_active(true)
    else
        if info.illumstration_number < info.rarity then
            self.spPointRed:set_active(true)
        else
            self.spPointRed:set_active(false)
        end
    end

    self.playernamelab:set_text(info.name)
    self.deslab:set_text(info.describe)
    PublicFunc.SetAptitudeSprite(self.pinzipic,info.config.aptitude, true);
    local allhero = PublicFunc.GetIllumstrationAllHero();
    local allheronum = #allhero
    --local havehero = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, nil, nil, false)
    local havehero = PublicFunc.GetAllHero(ENUM.EShowHeroType.All, nil, nil, false)
    local haveheronum = #havehero
    local flag = self:isHaveHero(info)
    
    if info.index == 0 then
        self.nohaveui:set_active(false)
        self.haveui:set_active(true)
        self.nohaveherodi:set_active(false)
    else
        --app.log("=========================")
        self.haveui:set_active(false)
        self.nohaveui:set_active(true)
        self.nohaveherodi:set_active(true)
    end
    --app.log("#allheronum"..tostring(allheronum));
    self.haveherolab:set_text("拥有角色:[FFED00FF]"..tostring(haveheronum).."/"..tostring(allheronum).."[-]")

    local shengyou = PublicFunc.GetShengyouName(info.model_id)--ConfigManager.Get(EConfigIndex.t_role_shengyou,info.default_rarity).shengyou_name;
    --app.log("shengyou----------------"..shengyou)

    self.shengyoulab:set_text(shengyou)
    --星
    local defaultStar = PublicFunc.getRoleCardCurStar( info.default_rarity );
    local currentStar = info.illumstration_number
    --app.log("currentStar==============="..tostring(currentStar))
    for i=1,7 do
        -- if i > defaultStar then
        self.staricon[i]:set_sprite_name(CareerTypePic[3])
        -- else
        --     self.staricon[i]:set_sprite_name(CareerTypePic[2])
        -- end
    end

    if currentStar == 0 then
        -- for i=1,defaultStar do
        --     if i < defaultStar then
        --         self.staricon[i]:set_sprite_name(CareerTypePic[2])
        --     else
        --         self.staricon[i]:set_sprite_name(CareerTypePic[1])
        --     end
        -- end
        self.updatelab:set_text("激活")
        self:hide_max_fx()
    else
        for i=1,currentStar do
            if currentStar >= info.rarity then
                self.staricon[i]:set_sprite_name(CareerTypePic[2])
            else
                if i == currentStar then
                    self.staricon[i]:set_sprite_name(CareerTypePic[1])
                 else
                    self.staricon[i]:set_sprite_name(CareerTypePic[2])
                end
            end
        end
        self.updatelab:set_text("更新")

        if ENUM.RoleMaxStarLevel > currentStar then
            self:hide_max_fx()
        else
            self:show_max_fx()
        end

    end


end



function HeroIllumstrationUI:bound3d()
    local id = self.choseHero.default_rarity
    local dataid = self:isHaveHero(id)

    if dataid ~= "" then

        local cardinfo = g_dataCenter.package:find_card(1, dataid);
        
         local data = 
        {
            roleData = cardinfo,
            role3d_ui_touch = self.hero3D,
            type = "left",
        }
        --app.log("3d data #########"..tostring(id))
        Show3d.SetAndShow(data)
        self:PlayHeroAudio(cardinfo)
    else
        local cardinfo = CardHuman:new({number=id, isNotCalProperty = true});

        local data = 
        {
            roleData = cardinfo,
            role3d_ui_touch = self.hero3D,
            type = "left",
        }   
        Show3d.SetAndShow(data)
        self:PlayHeroAudio(cardinfo)
    end
end

function HeroIllumstrationUI:PlayHeroAudio(info)
    if info and info.model_id then
        local model_list_cfg = ConfigManager.Get(EConfigIndex.t_model_list, info.model_id);
        if self.get_hero_audio ~= nil then
            AudioManager.StopUiAudio(self.get_hero_audio)
        end
        self.get_hero_audio = nil;
        if model_list_cfg and model_list_cfg.egg_get_audio_id and model_list_cfg.egg_get_audio_id ~= 0 and type(model_list_cfg.egg_get_audio_id) == "table" then
            local count = #model_list_cfg.egg_get_audio_id;
            local n = math.random(1,count)
            --app.log("n===="..n.."   count=="..count.."    id=="..table.tostring(model_list_cfg.egg_get_audio_id))
            self.get_hero_audio = AudioManager.PlayUiAudio(model_list_cfg.egg_get_audio_id[n])
        end
    end
end

function HeroIllumstrationUI:isHaveHero(id)
    
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local dataid = "";
    for k,v in pairs(haveherolist)do
    if v.default_rarity == id then
        dataid = v.index
        break;
    end
    end
        
    return dataid
end

function HeroIllumstrationUI:UpdateUi()
    -- self:UpdateSceneInfo();
    -- self:UpdateTotalIllumstrationValue();
end 

function HeroIllumstrationUI:UpdateSceneInfo()
    self.heroList = PublicFunc.GetIllumstrationAllHero();
    if self.curDefaultRarityNumber then
        for k, v in ipairs(self.heroList) do
            if v.default_rarity == self.curDefaultRarityNumber then  
                self.curSelectIndex = k
                break
            end
        end
    end
    local maxIndex = #self.heroList / 4 - 1;
    if #self.heroList%4 > 0 then
        maxIndex = maxIndex + 1;
    end
    self.heroWrapper:set_min_index(-maxIndex);
    self.heroWrapper:set_max_index(0);
    self.heroWrapper:reset();
    self.scrollview:reset_position();
    --if type then
    --    app.log( "获取队伍战斗提升通知过来了" );
    --end
end

function HeroIllumstrationUI:init_item( obj, b, real_id )
    local heroIndex = 1;
    local rowIndex = math.abs(real_id) + 1;
    local wrapIndex = math.abs( b + 1 );
    for i = 1, 4 do
        local heroIndex = (rowIndex - 1)*4 + i;
        if self.heroList[heroIndex]  then
            --app.log( "初始化英雄数据为空了，index是:"..heroIndex ); 
            if self.heroIconList[wrapIndex] == nil or self.heroIconList[wrapIndex][i] == nil then
                if self.heroIconList[wrapIndex] == nil then
                    self.heroIconList[wrapIndex] = {};
                end
                local objIcon = obj:get_child_by_name( "item"..i );
                self.heroIconList[wrapIndex][i] = HeroIllumstrationItemUI:new({obj = objIcon, info = self.heroList[heroIndex], heroIndex = heroIndex})
                self.heroIconList[wrapIndex][i]:SetOnClick( self.bindfunc["on_click_card"] );
            end
            local cardItemInfo = self.heroIconList[wrapIndex][i];                      
           
			cardItemInfo:Show();
            cardItemInfo:SetInfo({ info = self.heroList[heroIndex], heroIndex = heroIndex } );
			cardItemInfo:refreshSpNewState();
            cardItemInfo.smallcard:SetParam(heroIndex)
            cardItemInfo.smallcard:ChoseItem(self.curSelectIndex == heroIndex) 

            local isHave = true;
            --app.log("heroIndex = "..tostring(heroIndex));
            if self.heroList[heroIndex] ~= nil then 
                if self.heroList[heroIndex].index == 0 then
                    isHave = false;
                end
            else 
                isHave = false;
            end
            cardItemInfo:SetBlack( not isHave, nil );

            --更新右边界面
            if self.curSelectIndex == heroIndex then
                self:UpdateCardInfo()
            end
        else 
			local cardItemInfo = self.heroIconList[wrapIndex][i];
            cardItemInfo:Hide()
		end
    end
end

--图鉴激活回调
function HeroIllumstrationUI:gc_illumstration_active( dataid, illum_number, ret )
    
    if ret == 1 then
        self.choseHero.illumstration_number = illum_number;
    end
 --    if ret == 1 then
 --        local card = nil;
 --        local changeSelectIndex = 0;
 --        for k, v in pairs( self.heroList ) do
 --            if v.index == dataid then
 --                v.illumstration_number = illum_number;
 --                card = v;
 --                changeSelectIndex = k;
 --                break;
 --            end
 --        end
 --        ----数据中心的数据操作
 --        --if illum_number > 0 then
 --        --    g_dataCenter.package:UpdateCardByIllumstration(1, dataid, illum_number);
 --        --end
        
 --        if changeSelectIndex == self.curSelectIndex then
	-- 		self:refreshListItemState();
 --            self:initSelectAddCountInfo( self.heroList[self.curSelectIndex] );
 --            self:refreshAddInfoDisplay( self.heroList[self.curSelectIndex] );
 --            --self:RefreshActiveAndUpdateEffect( self.heroList[self.curSelectIndex] );
 --        else
 --            app.log( "=====fy:wrong, illumstration active hero is not the select hero!" );
 --        end
 --        self:UpdateTotalIllumstrationValue();
 --        AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpNormal)
 --    else 
	-- 	FloatTip.Float("激活出错,错误码："..tostring(ret));
	-- end
end

--图鉴提升回调
function HeroIllumstrationUI:gc_illumstration_update( dataid, illum_number, ret )

    if ret == 1 then
        self.choseHero.illumstration_number = illum_number;
    end

   --  if ret == 1 then
   --      local card = nil;
   --      local changeSelectIndex = 0;
   --      for k, v in pairs( self.heroList ) do
   --          if v.index == dataid then
   --              v.illumstration_number = illum_number;
   --              card = v;
   --              changeSelectIndex = k;
   --              break;
   --          end
   --      end
   --      ----数据中心的数据操作
   --      --if illum_number > 0 then
   --      --    g_dataCenter.package:UpdateCardByIllumstration(1, dataid, illum_number);
   --      --end
        
   --      if changeSelectIndex == self.curSelectIndex then
			-- self:refreshListItemState();
   --          self:initSelectAddCountInfo( self.heroList[self.curSelectIndex] );
   --          self:refreshAddInfoDisplay( self.heroList[self.curSelectIndex] );
   --          --self:RefreshActiveAndUpdateEffect( self.heroList[self.curSelectIndex] );
   --      else
   --          app.log( "=====fy:wrong, illumstration active hero is not the select hero!" );
   --      end
        
   --      self:UpdateTotalIllumstrationValue();
   --  end
end

function HeroIllumstrationUI:refreshListItemState()
	for k,v in pairs(self.heroIconList) do 
		for kk,cardItemInfo in pairs(v) do 
			cardItemInfo:refreshSpNewState();
		end
	end
end 

function HeroIllumstrationUI:on_click_card(obj, cardinfo, index)
    if self.curSelectIndex ~= index then
        self.curSelectIndex = index;
         --选中
        for k, v in pairs(self.heroIconList) do 
		    for _, item in pairs(v) do 
                item.smallcard:ChoseItem(item.smallcard:GetParam() == self.curSelectIndex)
		    end
	    end
        local cardInfo = self.heroList[self.curSelectIndex]
        self.curDefaultRarityNumber = cardInfo.default_rarity

        self:UpdateCardInfo();
    end
end

function HeroIllumstrationUI:UpdateCardInfo()
    local cardInfo = self.heroList[self.curSelectIndex]
    if cardInfo then
		local souls = g_dataCenter.package:GetCountByNumber(cardInfo.config.hero_soul_item_id);
        if self.heroList[self.curSelectIndex].index == 0 then
			local pro_value = souls/cardInfo.config.get_soul;
			if pro_value > 1 then
				pro_value = 1;
			end
			self.proBar:set_value(pro_value);
			self.lblProBar:set_text(souls.."/"..cardInfo.config.get_soul)
		else 
			local pro_value = souls/cardInfo.config.soul_count;
			if pro_value > 1 then
				pro_value = 1;
			end
			self.proBar:set_value(pro_value);
			self.lblProBar:set_text(souls.."/"..cardInfo.config.soul_count)
		end 
               
        --初始换满星加成的显示说明
        self:initSelectAddCountInfo(cardInfo);
        self:refreshAddInfoDisplay(cardInfo);
    end
end

function HeroIllumstrationUI:on_click_active_ill()
    if self.curSelectIndex > 0 and self.heroList[self.curSelectIndex] then
        msg_cards.cg_illumstration_active(self.heroList[self.curSelectIndex].index );
    end
end

function HeroIllumstrationUI:on_click_update_ill( param )
    --更新按钮事件

    do return end
    if param.float_value == 1 then
        if self.curSelectIndex > 0 and self.heroList[self.curSelectIndex] then
            msg_cards.cg_illumstration_update(self.heroList[self.curSelectIndex].index );
        end
    else
        FloatTip.Float("不能提升图鉴，角色星级不够" );
    end
end

--总战力属性加成更新显示
function HeroIllumstrationUI:UpdateTotalIllumstrationValue()
    -- local totalHP, totalAtk, totalDef = PublicFunc.getTotalActiveIllumstration();
    -- local txtHP = "[0BBDF9]" .. _UIText[4] .. "[-]+"..tostring( PublicFunc.AttrInteger(totalHP) );
    -- local txtAtk = "[0BBDF9]" .. _UIText[5] .. "[-]+"..tostring( PublicFunc.AttrInteger(totalAtk) );
    -- local txtDef = "[0BBDF9]" .. _UIText[6] .. "[-]+"..tostring( PublicFunc.AttrInteger(totalDef) );
    self.totalAdd.lblHP:set_text("");
    self.totalAdd.lblAttack:set_text("");
    self.totalAdd.lblDefense:set_text("");
    local cardInfo = self.choseHero

    local addHP, addAtk, addDef = PublicFunc.getIllumstrationValue( cardInfo.number, cardInfo.illumstration_number);

    if addHP ~= 0 then
        local title = _UIText[4]
        local value = PublicFunc.AttrInteger(addHP)
        self.totalAdd.lblHP:set_text(title.."[00FF73FF]+ "..tostring(value).."[-]")
    else
        local title = _UIText[4]
        self.totalAdd.lblHP:set_text(title.."[00FF73FF]+ "..tostring(0).."[-]")
    end
    if addAtk ~= 0 then
        local title = _UIText[5]
        local value = PublicFunc.AttrInteger(addAtk)
        self.totalAdd.lblAttack:set_text(title.."[00FF73FF]+ "..tostring(value).."[-]")
    else
        local title = _UIText[5]
        self.totalAdd.lblAttack:set_text(title.."[00FF73FF]+ "..tostring(0).."[-]")
    end
    if addDef ~= 0 then
        local title = _UIText[6]
        local value = PublicFunc.AttrInteger(addDef)
        self.totalAdd.lblDefense:set_text(title.."[00FF73FF]+ "..tostring(value).."[-]")
    else
        local title = _UIText[6]
        self.totalAdd.lblDefense:set_text(title.."[00FF73FF]+ "..tostring(0).."[-]")
    end

end

function HeroIllumstrationUI:SetFullStarAddDesc(cardInfo)
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

function HeroIllumstrationUI:on_collect_hero()
    local cardInfo = self.choseHero
    -- if self.curSelectIndex > 0 and self.heroList[self.curSelectIndex] then
    --     cardInfo = self.heroList[self.curSelectIndex]
    -- end    
    if cardInfo == nil then
        return
    end

    local data = {};
    data.item_id = cardInfo.config.hero_soul_item_id;
    data.number = cardInfo.config.get_soul;
    AcquiringWayUi.Start(data);

    do return end
    -- if cardInfo.index == 0 then
    --     local souls = g_dataCenter.package:GetCountByNumber(cardInfo.config.hero_soul_item_id)
    --     local needSoul = cardInfo.config.get_soul
    --     --数量不足
    --     if souls < needSoul then
    --         local data = {};
    --         data.item_id = cardInfo.config.hero_soul_item_id;
    --         data.number = cardInfo.config.get_soul;
	   --      AcquiringWayUi.Start(data);
    --     --招募
    --     else
    --         uiManager:PushUi(EUI.HeroPackageUI, {gotoId = cardInfo.number})
    --     end
    -- --升星
    -- else
    --     uiManager:PushUi(EUI.BattleUI, {defToggle = MsgEnum.eactivity_time.eActivityTime_RoleUpgradeStar, 
    --         cardInfo = cardInfo, is_player = true});
    -- end
end

function HeroIllumstrationUI:initSelectAddCountInfo( cardInfo )
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
    if cardInfo.index ~= 0 and cardInfo.illumstration_number > 0 then
        hp, atk, def = PublicFunc.getIllumstrationValue( cardInfo.number, cardInfo.illumstration_number );
        if cardInfo.illumstration_number + 1 < 8 then
            nextHp, nextAtk, nextDef = PublicFunc.getIllumstrationValue( cardInfo.number, cardInfo.illumstration_number + 1 );
        end
    end
    if atk ~= 0 then
        table.insert(data, atk);
        table.insert(nextData, nextAtk);
        table.insert(titleList, "攻击" );
        count = count + 1;
    else
        table.insert( notHave, "atk" );
    end
    
    if hp ~= 0 then
        table.insert(data, hp);
        table.insert(nextData, nextHp);
        table.insert(titleList, "生命" );
        count = count + 1;
    else
        table.insert( notHave, "hp" );
    end
    
    if def ~= 0 then
        table.insert(data, def);
        table.insert(nextData, nextDef);
        table.insert(titleList, "防御" );
        count = count + 1;
    else
        table.insert( notHave, "def" );
    end

    self.illAddInfoDisp.count = count;
    self.illAddInfoDisp.data = data;
    self.illAddInfoDisp.nextData = nextData;
    self.illAddInfoDisp.titleList = titleList;
end

function HeroIllumstrationUI:refreshAddInfoDisplay( cardInfo )

    self.heroBigItem:SetData(cardInfo)
    --self.heroBigItem:HideContent1SomeUi()

    --当前没用拥有的英雄，显示内容
    local curAddTxt = "";
	--self.spPointRed:set_active(false);
	--app.log("self.spPointRed deactive");

	local defaultCardInfo = ConfigHelper.GetRole(cardInfo.default_rarity);

    self.btnUp:set_active(false)   
    self.btnActive:set_active(false)
    self.downInfo.spUpTop:set_active(false)

    self.objShuiPian:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)
    self.proBar:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)
    self.btnGet:set_active(cardInfo.rarity < Const.HERO_MAX_STAR)

    for i = 1, 3 do
        self.downInfo.prop[i].spArrow:set_active(false)
    end

    if cardInfo.index == 0 then
        self.lblGet:set_text(_UIText[1])
        curAddTxt = _UIText[3];
        self.commonInfo.spGetIcon:set_sprite_name("yxtj_weihuode")

        for i = 1, 3 do
            self.downInfo.prop[i].lblTitle:set_active(false)
        end
        self:SetFullStarAddDesc(cardInfo)
        self:hide_max_fx()
    	--self.collectStageLab:set_text("进度0/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
    else
        self.lblGet:set_text(_UIText[2])
        self.commonInfo.spGetIcon:set_sprite_name("yxtj_yihuode")
        for i = 1, 3 do
            self.downInfo.prop[i].lblTitle:set_active(true)
        end

        for i = 1, 3 do
            if i <= self.illAddInfoDisp.count then
                self.downInfo.prop[i].lblTitle:set_active(true)
                self.downInfo.prop[i].lblTitle:set_text(self.illAddInfoDisp.titleList[i]);
                self.downInfo.prop[i].lblValue:set_text("+"..tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.data[i])));
            else
                self.downInfo.prop[i].lblTitle:set_active(false)
            end
        end

        if cardInfo.illumstration_number == 0 then
			--self.collectStageLab:set_text("进度0/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
            curAddTxt = string.format(_UIText[7], 0, ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity)
           
            self.btnActive:set_active(true);
			--self.spPointRed:set_active(true);
			--app.log("self.spPointRed active");
            self:hide_max_fx()
        else 

            --local star_up_number = PublicFunc.getNextStarUpNumber( cardInfo.illumstration_number );
			--self.collectStageLab:set_text("进度"..tostring(cardInfo.illumstration_number + 1 - defaultCardInfo.rarity).."/"..tostring(ENUM.RoleMaxStarLevel + 1 - defaultCardInfo.rarity));
            --if star_up_number > 0 then
            if cardInfo.illumstration_number < ENUM.RoleMaxStarLevel then
                curAddTxt = string.format(_UIText[8], cardInfo.illumstration_number, cardInfo.illumstration_number + 1)
                for i = 1, 3 do
                    if i <= self.illAddInfoDisp.count then
                        self.downInfo.prop[i].spArrow:set_active(true)
                        self.downInfo.prop[i].lblValue:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.data[i])));
                        self.downInfo.prop[i].lblValueAdd:set_text(tostring(PublicFunc.AttrInteger(self.illAddInfoDisp.nextData[i])) );
                    else
                        self.downInfo.prop[i].spArrow:set_active(false)
                    end
                end

                self.btnUp:set_active( true );
                if cardInfo.illumstration_number >= cardInfo.rarity then
                    --self.updateBtnBG:set_color( 0, 0, 0, 1 );
                    self.btnUp:set_event_value( "update", 0 );
                else
                    --self.updateBtnBG:set_color( 1, 1, 1, 1);
                    self.btnUp:set_event_value( "update", 1 );
					--self.spPointRed:set_active(true);
					--app.log("self.spPointRed active");
                end
                self:hide_max_fx()
            else
                curAddTxt = _UIText[9];
                self.objShuiPian:set_active(false)
                self.proBar:set_active(false)
                self.btnGet:set_active(false)
                self.downInfo.spUpTop:set_active(true)
                self:show_max_fx()
            end
        end
        
    end
    
    --统一都会显示的就是基础的收集数据，根据当前的数量来判定显示和内容
    self.downInfo.lblTitle:set_text(curAddTxt);

    --信息显示，名字，当前星级，技能，满星加成等等
    self.commonInfo.lblHeroName:set_text(cardInfo.name)
    self.commonInfo.lblHeroDesc:set_text(cardInfo.describe)
    self.commonInfo.scrollview:reset_position()
end

function HeroIllumstrationUI:Hide()
    if UiBaseClass.Hide(self) then
        --app.log("TrainningInfo.Hide############1")
        if Show3d.GetInstance() then
             Show3d.Destroy();
        end
    end  
end

function HeroIllumstrationUI:Show()
    if UiBaseClass.Show(self) then
        self:reshHeroIllumstrationUI()
        if self.heroListUi then
            self:bound3d()
            self.heroListUi:UpdateCurrHero()
            self.heroListUi:UpdateHeroTips()
        end
    end 
end

function HeroIllumstrationUI:show_max_fx()
    self.max_fx:set_active(true)
    self.updatebtn:set_active(false)
end

function HeroIllumstrationUI:hide_max_fx()
    self.max_fx:set_active(false)
    self.updatebtn:set_active(true)
end


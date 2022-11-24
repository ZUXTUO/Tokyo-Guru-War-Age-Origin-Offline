--flieName:ui_hero_illumstration_item.lua
--desc:用于图鉴功能英雄头像系统的各种功能设置
--code by:fengyu
--date:2016-7-4

HeroIllumstrationItemUI = Class( "HeroIllumstrationItemUI" );

function HeroIllumstrationItemUI:SetInfo( data )
    self.cardInfo = data.info or self.cardInfo;
    self.heroIndex = data.heroIndex or self.heroIndex;
    self:UpdateUi();
end

function HeroIllumstrationItemUI:GetInfo()
    return self.cardInfo;
end

function HeroIllumstrationItemUI:Show()
    if not self.ui then return end;
    self.ui:set_active( true );
end

function HeroIllumstrationItemUI:Hide()
    if not self.ui then return end;
    
    self.ui:set_active( false );
end

function HeroIllumstrationItemUI:Init( data )
    self:InitData( data );
    self:InitUi();
end

function HeroIllumstrationItemUI:InitData( data )
    self.ui = data.obj;
    self.cardInfo = data.info;
    self.heroIndex = data.heroIndex;
    self.bindfunc = {};
    self._clickBtnCallback = nil;
    self:registFunc();
    
end

function HeroIllumstrationItemUI:registFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
end

function HeroIllumstrationItemUI:unregistFunc()
    for k, v in pairs( self.bindfunc ) do
        if v ~= nil then
            Utility.unbind_callback( self, v );
        end
    end
end

function HeroIllumstrationItemUI:InitUi()
    if self.ui == nil then
        return;
    end
    self.clickSP = ngui.find_sprite( self.ui, "sp_left_back" );
    self.clickSP:set_on_ngui_click( self.bindfunc["on_click"] );
    self.parentBG = self.ui:get_child_by_name( "new_small_card_item" );

    self.spAptitude = ngui.find_sprite(self.ui, "sp_pinzhi");
    self.spShine = ngui.find_sprite(self.ui, "sp_shine" );
    self.smallcard = SmallCardUi:new({parent = self.parentBG, uis = {sp_shine = self.spShine }, customUpdateTip = true, info = self.cardInfo,
        stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Star}});    
    
    if self.smallcard then
        --self.headSP = ngui.find_sprite( self.smallcard.ui, "sp_back/human/text_human" );
        --self.headSP = self.smallcard.textureHeadIco;
        self.smallcard:SetCallback(self.bindfunc["on_click"]);
    end
    
    self:UpdateUi();
end

function HeroIllumstrationItemUI:on_click(param)
    if self._clickBtnCallback ~= nil then
        Utility.CallFunc( self._clickBtnCallback, self, self.cardInfo, self.heroIndex );
    end
end

function HeroIllumstrationItemUI:SetOnClick(callback)
    if callback == nil then
        return;
    end
    
    self._clickBtnCallback = callback;
end

function HeroIllumstrationItemUI:UpdateUi()
    self.smallcard:SetData( self.cardInfo );
    PublicFunc.SetAptitudeSprite(self.spAptitude, self.cardInfo.config.aptitude, true)
end

function HeroIllumstrationItemUI:Destroy()
    self.ui = nil;
    self.cardInfo = nil;
    if self.smallcard then
        self.smallcard:DestroyUi();
        self.smallcard = nil;
    end
    
    self:unregistFunc();
    self.bindfunc = {};
end

function HeroIllumstrationItemUI:SetBlack( flag, clickCallback )
    --if self.headSP == nil then
    --    return;
    --end
    self.smallcard:SetGray( flag, clickCallback );
--    if flag then
--        self.smallcard:SetSGroup( {SmallCardUi.SType.Texture, SmallCardUi.SType.Rarity} );
--    end
    if flag then
        PublicFunc.SetUISpriteGray(self.clickSP)
    else
        PublicFunc.SetUISpriteWhite(self.clickSP)
    end
    --self.smallcard:SetBlackForHeadIcon( flag );
    --if flag == true then
    --    --self.smallcard.textureHeadIco:set_color(0,0,0,1);
    --
    --else
    --    --self.smallcard.textureHeadIco:set_color(1,1,1,1);
    --end
end

function HeroIllumstrationItemUI:SetSpNew(isNew)
	self.smallcard:SetSpNew(isNew);
end

function HeroIllumstrationItemUI:refreshSpNewState()
	local cardInfo = self.cardInfo;
	if cardInfo ~= nil then 
		if cardInfo.index ~= 0 then 
			if cardInfo.illumstration_number == 0 then 
				self:SetSpNew(true);
			elseif cardInfo.illumstration_number < cardInfo.rarity then 
				self:SetSpNew(true);
			else 
				self:SetSpNew(false);
			end
		else 
			self:SetSpNew(false);
		end 
	end 
end


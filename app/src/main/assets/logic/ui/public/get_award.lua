

GetAward = Class("GetAward", UiBaseClass)

function GetAward:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/fight/ui_802_fight.assetbundle";
    UiBaseClass.Init(self, data);
end


function GetAward:Restart(data)
    UiBaseClass.Restart(self, data)
end


function GetAward:SetData(data)
    self.data = data
end

function GetAward:InitData(data)
    UiBaseClass.InitData(self, data);
   

    self.curIndex = 1

    self.animator = nil
end

function GetAward:RegistFunc()
    UiBaseClass.RegistFunc(self);
	
    self.bindfunc["OnNextClock"]	   = Utility.bind_callback(self, GetAward.OnNextClock);
end

function GetAward:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

function GetAward:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_name("GetAward");
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_local_position(0,0,0);

    local btnNext = ngui.find_button(self.ui, "GetAward/sp");
    btnNext:set_on_click(self.bindfunc["OnNextClock"]);

    self.iconsprite = ngui.find_sprite(self.ui, "GetAward/sp/centre_other/sp_bk/di/article")
    self.txtlabel = ngui.find_label(self.ui,"GetAward/sp/centre_other/sp_bk/lab")

    self.animator = btnNext:get_game_object()
    
	self:SetUIContent()
end

function GetAward:OnNextClock(param)
    if self.data ~= nil then
        self.curIndex = self.curIndex + 1
        local count = table.maxn(self.data)
        if self.curIndex <= count then
            self:SetUIContent()

            return
        end
    end
    uiManager:PopUi()   
end

function GetAward:SetUIContent()
    if(self.data ~= nil) then
        --app.log('SetUIContent')
        local count = table.maxn(self.data)
        if self.curIndex <= count then
            dataItem = self.data[self.curIndex]
            local id = dataItem.id
            local num = dataItem.num

            local type = PropsEnum.GetItemType(id)
            if type > 0 then

                local cardData;
	            if(PropsEnum.IsRole(id))then
		            cardData = CardHuman:new({number = id,level = 1})
	            elseif(PropsEnum.IsEquip(id))then
		            cardData = CardEquipment:new({number = id})
	            elseif(PropsEnum.IsItem(id))then
		            cardData = CardProp:new({number = id,count = 1})
	            else
		            cardData = CardProp:new({number = id,count = 1})
	            end

                if cardData ~= nil then
                    --self.icon:SetIcon(self.iconsprite,type,id);
                    self.txtlabel:set_text(cardData.name..' X '.. num);
                    self.animator:animator_play("ui_802_fight");
                end

            end

        end
    end
    return false
end

function GetAward:Show()
	UiBaseClass.Show(self)
end

function GetAward:Hide()
	UiBaseClass.Hide(self)
end

function GetAward:DestroyUi()
    UiBaseClass.DestroyUi(self);
end


return GetAward


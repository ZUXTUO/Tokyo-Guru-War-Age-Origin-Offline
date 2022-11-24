CheckinDlgUI = Class("CheckinDlgUI", UiBaseClass);
function CheckinDlgUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/sign/ui_201_checkin.assetbundle";
	UiBaseClass.Init(self, data);
end

--重新开始
function CheckinDlgUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

--初始化数据
function CheckinDlgUI:InitData(data)
	UiBaseClass.InitData(self, data);
    self.cardId   = 0;
	self.cardNum  = 0;
	self.card     = nil;
	self.funcSure = nil;
end

function CheckinDlgUI:DestroyUi()
    self.ui:set_active(false);
    UiBaseClass.DestroyUi(self);
	self.cardId  = 0;
	self.cardNum = 0;
	self.funcSure = nil;
end

function CheckinDlgUI:Show()
	if UiBaseClass.Show(self) then
	--todo 
	end
end

--隐藏ui
function CheckinDlgUI:Hide()
	if UiBaseClass.Hide(self) then
	--todo 
	end
end

function CheckinDlgUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_sure"] = Utility.bind_callback(self, CheckinDlgUI.on_sure)
end

function CheckinDlgUI:UnRegistFunc()
    UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function CheckinDlgUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function CheckinDlgUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
end

--加载UI
function CheckinDlgUI:LoadUI()
	if UiBaseClass.LoadUI(self) then
	--todo 
	end
end


function CheckinDlgUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("checkin_dlg_ui");
	
    self.labName    = ngui.find_label(self.ui,"sp_award_di/sp_di/lab_name");
	self.labDesc    = ngui.find_label(self.ui,"sp_award_di/sp_di/lab_num");
	self.btnSure   	= ngui.find_button(self.ui,"sp_mark");
    self.iconSprite = ngui.find_sprite(self.ui,"sp_award_di/sp_bk/sp_article");
	--self.scaleTween = ngui.find_uitweener(self.ui,"checkin_dlg_ui/Sprite/animation");
	--local go        = asset_game_object.find("checkin_dlg_ui/Sprite/animation/sp_di/sp_pointer");
	--self.card       = SmallCardUi:new();
	--self.card:SetParent(go);
	self.btnSure:set_on_click(self.bindfunc["on_sure"]);

	self:SetInfo(self.cardId,self.cardNum, self.iconPool, self.funcSure);    

end

function CheckinDlgUI:on_sure()
	--self.scaleTween:reset_to_begining();
	self.ui:set_active(false);
	if(self.funcSure ~= nil)then
		_G[self.funcSure]();
	end
end

--对外接口，设置显示的图片与数量，以及“确认”和“取消”按钮的回调函数
function CheckinDlgUI:SetInfo(id,num,iconPool,funcSure)
	self.cardId     = id;
	self.cardNum    = num;
    self.iconPool   = iconPool;
	self.funcSure   = funcSure;
    --app.log_warning("CheckinDlgUI : SetInfo self.cardId = " .. self.cardId)
	--self.funcCancel = funcCancel;
	if(self.ui == nil) then
		return nil;
	end
	local cardData;
	if(PropsEnum.IsRole(self.cardId))then
		cardData = CardHuman:new({number = self.cardId,level = 1})
	elseif(PropsEnum.IsEquip(self.cardId))then
		cardData = CardEquipment:new({number = self.cardId})
	elseif(PropsEnum.IsItem(self.cardId))then
		cardData = CardProp:new({number = self.cardId,count = self.cardNum})
	else
		cardData = CardProp:new({number = self.cardId,count = self.cardNum})
	end
	--self.card:SetData(cardData);
	--self.labDesc:set_text('获得'..cardData.name..'X'..tostring(self.cardNum));

    self.iconPool:SetIcon(self.iconSprite, self.cardId); 

    self.labName:set_text(cardData.name);
    if self.cardNum == 1 then
         self.labDesc:set_text("恭喜获得"..cardData.name);
    else 
         self.labDesc:set_text('X'..tostring(self.cardNum));
    end
   
	self:Show();
end

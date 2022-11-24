
CloneAreward = Class("CloneAreward", MultiResUiBaseClass)

-------------------------------------外部调用-------------------------------------

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/clone/ui_5201_clone_wars.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}


function CloneAreward:Init(data)
    
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function CloneAreward:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function CloneAreward:InitData(data)
    UiBaseClass.InitData(self, data)
    
    self.checkNumb = 0;
end

function CloneAreward:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function CloneAreward:DestroyUi()
    for k,v in pairs(self.ui_small_item)do
	v:DestroyUi()  
    end
    
    self.ui_small_item = {};
    
    self.checkNumb = 0;
    SceneManager.PopScene()
    UiBaseClass.DestroyUi(self);

end

function CloneAreward:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_Open'] = Utility.bind_callback(self, self.on_click_Open);
    self.bindfunc['on_Show_Areward'] = Utility.bind_callback(self, self.on_Show_Areward);
    self.bindfunc['on_back_teamui'] = Utility.bind_callback(self, self.on_back_teamui);
    self.bindfunc['on_close_ui'] = Utility.bind_callback(self, self.on_close_ui);
end


--注册消息分发回调函数
function CloneAreward:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_clone_fight.gc_open_box, self.bindfunc["on_Show_Areward"])
end

--注销消息分发回调函数
function CloneAreward:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_clone_fight.gc_open_box, self.bindfunc["on_Show_Areward"])
    
end


--初始化UI
function CloneAreward:InitedAllUI()
    --UiBaseClass.InitUI(self, asset_obj)
    local backui = self.uis[resPaths[resType.Back]]
    local frontParentNode = backui:get_child_by_name("add_content")
    self.backui = backui
    -- --通用结算按钮
    -- self.buttonBtn = ngui.find_button(backui,"animation_bk/btn_sure")
    -- self.buttonBtn:set_active(false)
    
    self.titleSprite = ngui.find_sprite(backui, 'sp_art_font')
    self.titleSprite:set_sprite_name("js_taofashengli")

    --通用结算文字
    self.buttonText = ngui.find_label(backui, "txt")
    self.buttonText:set_active(false)
    
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    self.ui:set_name('CloneAreward');
    self.box1 = ngui.find_button(self.ui,"center_other/animation/btn_box1")
    self.texture1 = ngui.find_sprite(self.ui,"center_other/animation/btn_box1/sp_box")
    self.box1:set_on_ngui_click(self.bindfunc['on_click_Open'])
    self.box2 = ngui.find_button(self.ui,"center_other/animation/btn_box2")
    self.texture2 = ngui.find_sprite(self.ui,"center_other/animation/btn_box2/sp_box")
    self.box2:set_on_ngui_click(self.bindfunc['on_click_Open'])
    
    --self.backBtn = ngui.find_button(self.ui,"center_other/animation/btn_back")
    --self.backBtn:set_on_click(self.bindfunc['on_back_teamui']);
    --self.backBtn:set_active(false)
    
    self.closeBtn = ngui.find_button(self.ui,"center_other/animation/btn_cha")
    self.closeBtn:set_on_click(self.bindfunc['on_close_ui']);
    self.closeBtn:set_active(false)
    
    self.gem1 = self.ui:get_child_by_name("center_other/animation/btn_box2/cont")
    self.gemnumb1 = ngui.find_label(self.ui,"center_other/animation/btn_box2/lab_num")
    
    self.gem2 = self.ui:get_child_by_name("center_other/animation/btn_box1/cont")
    self.gemnumb2 = ngui.find_label(self.ui,"center_other/animation/btn_box1/lab_num")
    
    self.titletxt = ngui.find_label(self.ui,"center_other/animation/lab_xuan_ze")   --提示文字
    
    self.itemcon = self.ui:get_child_by_name("center_other/animation/cont");
    self.itemcon:set_active(false)
    
    self.gettitletxt = ngui.find_label(self.ui,"center_other/animation/txt")
    self.gettitletxt:set_active(false)
    
    if self.currentItem then
	self.currentItem:set_sprite_name("klz_kaiqibaoxiang")
    end
    
    self.box1_fx = self.ui:get_child_by_name("center_other/animation/btn_box1/fx_ui_5201_kaibaoxiang")
    self.box2_fx = self.ui:get_child_by_name("center_other/animation/btn_box2/fx_ui_5201_kaibaoxiang")

    self.ui_small_item = {};
    
    self.arewarditem = {}
    for i=1,6 do
	self.arewarditem[i] = self.ui:get_child_by_name("center_other/animation/cont/new_small_card_item"..i); 
    end
        
    self:hidegem()
    
end

function CloneAreward:hidegem()
    self.gem1:set_active(false)
    self.gemnumb1:set_active(false)
    
    self.gem2:set_active(false)
    self.gemnumb2:set_active(false)
end

function CloneAreward:on_click_Open(name,x,y,obj)
    self.titletxt:set_active(false)
    msg_clone_fight.cg_open_box( )
    GLoading.Show(GLoading.EType.msg)
    if name == "btn_box1" then
	self.currentItem = self.texture1
	self.currentItemBtn = self.box1
	
	self.currentItemgem = self.gem1
	self.currentItemgemnumb = self.gemnumb1

    self.box1_fx:set_active(true)
	
    elseif name == "btn_box2" then
	self.currentItem = self.texture2
	self.currentItemBtn = self.box2
	
	self.currentItemgem = self.gem2
	self.currentItemgemnumb = self.gemnumb2

    self.box2_fx:set_active(true)
    end
end

function CloneAreward:on_back_teamui()
    --uiManager:PopUi()
    SceneManager.PopScene()
    g_dataCenter.CloneBattle:SetAllrewardlist()
    msg_clone_fight.cg_get_team_info()
end

function CloneAreward:on_close_ui()
   
    --uiManager:PopUi()
    SceneManager.PopScene()
    g_dataCenter.CloneBattle:SetAllrewardlist()
    msg_clone_fight.cg_get_team_info()
end

function CloneAreward:UpdateUi()
   
end

function CloneAreward:on_Show_Areward( )
    
    local callback = function()
	self:Show()    
    end
    
    local data = g_dataCenter.CloneBattle:getrewardlist()
    --app.log("show areward list ##############"..table.tostring(data))
    CommonAward.Start(data, tType)
    CommonAward.SetFinishCallback(callback,self)
    self.currentItem:set_sprite_name("klz_kaiqibaoxiang")
    self.currentItemBtn:set_enable(false)
    
    self.checkNumb = self.checkNumb + 1
    
    self:ShowBtn()
    
    self:setArewardUI()
    self.itemcon:set_active(true)
    self.gettitletxt:set_active(true)
    
    self:Hide()
end


function CloneAreward:ShowBtn( )
    --self.backBtn:set_active(true)
    self.closeBtn:set_active(true)
    
    if self.checkNumb == 1 then
	self.currentItemgem:set_active(true)
	self.currentItemgemnumb:set_active(true)
    end
end

function CloneAreward:setArewardUI()
    
    local data = g_dataCenter.CloneBattle:getallrewardlist()
    for k,v in pairs(data)do
	--self.arewarditem[k]
	--local rewards = ConfigManager.Get(EConfigIndex.t_discrete,v.id).data
	--app.log("data##########"..table.tostring(data))
	--app.log("v.count##########"..tostring(v.count))
	local card_prop = CardProp:new({number = v.id,count = tonumber(v.count)});
	if self.ui_small_item[k] then
	    self.ui_small_item[k]:SetData(card_prop);
	    self.ui_small_item[k]:SetCount(v.count);
	else
	    if self.arewarditem[k] then
		self.ui_small_item[k] = UiSmallItem:new({parent = self.arewarditem[k], cardInfo = card_prop});
		self.ui_small_item[k]:SetCount(v.count);
	    end
	end
    end
    
    --g_dataCenter.CloneBattle:setAllReward(data)
end

function CloneAreward:Show()
    if self.backui then
        self.backui:set_position(0,0,0)
    end
end

function CloneAreward:Hide()
    if self.backui then
        self.backui:set_position(10000,0,0)
    end
end

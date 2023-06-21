EggEquipGetOne = Class("EggEquipGetOne", UiBaseClass);
function EggEquipGetOne.Start(data)
	if EggEquipGetOne.instance then
		EggEquipGetOne.instance:SetData(data)
		EggEquipGetOne.instance:UpdateUi();
	else
		EggEquipGetOne.instance = EggEquipGetOne:new(data)
	end
end

function EggEquipGetOne.Destroy()
	if EggEquipGetOne.instance then
        EggEquipGetOne.instance:Hide();
        EggEquipGetOne.instance:DestroyUi();
        EggEquipGetOne.instance = nil;
    end
end

function EggEquipGetOne.SetCallback(func1,obj1,func2,obj2,func3,obj3)
    if EggEquipGetOne.instance then
        EggEquipGetOne.instance.func_again = func1;
        EggEquipGetOne.instance.obj_again = obj1;
        EggEquipGetOne.instance.func_sure = func2;
        EggEquipGetOne.instance.obj_sure = obj2;
        EggEquipGetOne.instance.func_share = func3;
        EggEquipGetOne.instance.obj_share = obj3;
    end
end

--当第一个动画播完，回调
function EggEquipGetOne.OnOver()
    if EggEquipGetOne.instance then
        EggEquipGetOne.instance.isOver = true
        EggEquipGetOne.instance.btnSure:set_active(true);
        EggEquipGetOne.instance.btnAgain:set_active(true);
        EggEquipGetOne.instance.btnShare:set_active(true);
    end
end

function EggEquipGetOne:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/egg/content_jiesuan_equip1.assetbundle';
    self:SetData(data);
	UiBaseClass.Init(self, data);
end

--初始化数据
function EggEquipGetOne:InitData(data)
	UiBaseClass.InitData(self, data);
end

--重新开始
function EggEquipGetOne:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

--析构函数
function EggEquipGetOne:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.texture_equip:Destroy();
    self.texture_equip = nil;

    ResourceManager.DelRes(self.pathRes);
end


--注册回调函数
function EggEquipGetOne:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_share'] = Utility.bind_callback(self, self.on_share);
    self.bindfunc['on_sure'] = Utility.bind_callback(self, self.on_sure);
    self.bindfunc['on_again'] = Utility.bind_callback(self, self.on_again);
end

--寻找ngui对象
function EggEquipGetOne:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_egg_get_equip_one');
    --do return end
    ---------------寻找label---------------------
    self.btnSure = ngui.find_button(self.ui, "centre_other/animation/btn_que_ding");
    self.btnSure:set_on_click(self.bindfunc['on_sure']);
    self.btnSure:set_active(false);
    self.btnShare = ngui.find_button(self.ui, "centre_other/animation/btn_share");
    self.btnShare:set_on_click(self.bindfunc['on_share']);
    self.btnShare:set_active(false);
    self.btnAgain = ngui.find_button(self.ui, "centre_other/animation/btn_zai_chou");
    self.btnAgain:set_on_click(self.bindfunc['on_again']);
    self.btnAgain:set_active(false);

    self.lab_num = ngui.find_label(self.ui, "centre_other/animation/kug1/lab_word");
    self.sp_frame = ngui.find_sprite(self.ui, "centre_other/animation/kug1/new_small_card_item/sp_frame");
    self.texture_equip = ngui.find_texture(self.ui, "centre_other/animation/kug1/new_small_card_item/sp_daoju");
    self.lab_name = ngui.find_label(self.ui, "centre_other/animation/kug1/new_small_card_item/lab_word");
    
	self:UpdateUi();
end

--刷新界面
function EggEquipGetOne:UpdateUi()
	if UiBaseClass.UpdateUi(self) then
	    local cfg = PublicFunc.IdToConfig(self.vecReward[1].id);
        self.lab_name:set_text(cfg.name);
        self.lab_num:set_text("x"..self.vecReward[1].count);
        PublicFunc.SetIconFrameSprite(self.sp_frame,cfg.rarity);
        self.texture_equip:set_texture(cfg.small_icon);
        --item_manager.texturePadding(self.texture_equip,cfg.small_icon)
	end
end

--设置数据
function EggEquipGetOne:SetData(data)
    self.isOver = false;
    self.vecReward = data.vecReward;
end

--确定
function EggEquipGetOne:on_sure()
    EggEquipGetOne.Destroy()
    if self.func_sure then
        self.func_sure(self.obj_sure);
    end
end

--分享
function EggEquipGetOne:on_share()
    if self.func_share then
        self.func_share(self.obj_share);
    end
end

--再抽10次
function EggEquipGetOne:on_again()
    --EggEquipGetOne.Destroy()
    self:on_sure();
    if self.func_again then
        self.func_again(self.obj_again)
    end
end
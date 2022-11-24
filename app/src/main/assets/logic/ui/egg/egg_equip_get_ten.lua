EggEquipGetTen = Class("EggEquipGetTen", UiBaseClass);
function EggEquipGetTen.Start(data)
	if EggEquipGetTen.instance then
		EggEquipGetTen.instance:SetData(data)
		EggEquipGetTen.instance:Update();
	else
		EggEquipGetTen.instance = EggEquipGetTen:new(data)
	end
end

function EggEquipGetTen.Destroy()
	if EggEquipGetTen.instance then
        EggEquipGetTen.instance:Hide();
        EggEquipGetTen.instance:DestroyUi();
        EggEquipGetTen.instance = nil;
    end
end

function EggEquipGetTen.SetCallback(func1,obj1,func2,obj2,func3,obj3)
    if EggEquipGetTen.instance then
        EggEquipGetTen.instance.func_again = func1;
        EggEquipGetTen.instance.obj_again = obj1;
        EggEquipGetTen.instance.func_sure = func2;
        EggEquipGetTen.instance.obj_sure = obj2;
        EggEquipGetTen.instance.func_share = func3;
        EggEquipGetTen.instance.obj_share = obj3;
    end
end

--当第一个动画播完，回调
function EggEquipGetTen.OnOver()
    if EggEquipGetTen.instance then
        EggEquipGetTen.instance.isOver = true
        EggEquipGetTen.instance.btnSure:set_active(true);
        EggEquipGetTen.instance.btnAgain:set_active(true);
        EggEquipGetTen.instance.btnShare:set_active(true);
    end
end

function EggEquipGetTen:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/egg/content_jiesuan_equip10.assetbundle';
    self:SetData(data);
	UiBaseClass.Init(self, data);
end

--初始化数据
function EggEquipGetTen:InitData(data)
	UiBaseClass.InitData(self, data);
end

--重新开始
function EggEquipGetTen:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end



--析构函数
function EggEquipGetTen:DestroyUi()
    UiBaseClass.DestroyUi(self);

    for i=1,10 do
        self.item[i]:DestroyUi();
        self.item[i] = nil;
    end
    ResourceManager.DelRes(self.pathRes);
end

--注册回调函数
function EggEquipGetTen:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_share'] = Utility.bind_callback(self, self.on_share);
    self.bindfunc['on_sure'] = Utility.bind_callback(self, self.on_sure);
    self.bindfunc['on_again'] = Utility.bind_callback(self, self.on_again);
end

--寻找ngui对象
function EggEquipGetTen:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(Utility.SetUIAdaptation());
    self.ui:set_name('ui_egg_get_equip_ten');
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

    self.item = {};
    self.lab_name = {};
    for i=1,10 do
        local obj = self.ui:get_child_by_name("centre_other/animation/even_num/animation/kug"..i);
        self.item[i] = UiSmallItem:new({});
        self.item[i]:SetParent(obj);
        self.lab_name[i] = ngui.find_label(self.ui,"centre_other/animation/even_num/animation/kug"..i.."/lab_word");
    end
    
	self:Update();
end

--刷新界面
function EggEquipGetTen:Update(dt)
	if UiBaseClass.Update(self, dt) then
        for i=1,10 do
            local cfg;
            self.vecReward[i].number = self.vecReward[i].id;
            if PropsEnum.IsEquip(self.vecReward[i].id) then
                cfg = CardEquipment:new(self.vecReward[i])
            elseif PropsEnum.IsItem(self.vecReward[i].id) then
                cfg = CardProp:new(self.vecReward[i])
            end
            self.item[i]:SetData(cfg);
            if cfg then
                self.lab_name[i]:set_text(cfg.name);
            else
                self.lab_name[i]:set_text("");
            end
        end
    end
end

--设置数据
function EggEquipGetTen:SetData(data)
    self.isOver = false;
    self.vecReward = data.vecReward;
end

--确定
function EggEquipGetTen:on_sure()
    EggEquipGetTen.Destroy()
    if self.func_sure then
        self.func_sure(self.obj_sure);
    end
end

--分享
function EggEquipGetTen:on_share()
    if self.func_share then
        self.func_share(self.obj_share);
    end
end

--再抽10次
function EggEquipGetTen:on_again()
    --EggEquipGetTen.Destroy()
    self:on_sure();
    if self.func_again then
        self.func_again(self.obj_again)
    end
end
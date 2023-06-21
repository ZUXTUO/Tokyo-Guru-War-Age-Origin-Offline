EggHunXiaAwardUI = Class("EggHunXiaAwardUI", UiBaseClass);

local instance = nil;

function EggHunXiaAwardUI.Start(data)
	if instance then
		instance:SetData(data)
		instance:UpdateUi();
	else
		instance = EggHunXiaAwardUI:new(data)
	end
end

function EggHunXiaAwardUI.Destroy()
	if instance then
        instance:Hide();
        instance:DestroyUi();
        instance = nil;
    end
end

function EggHunXiaAwardUI.SetCallback(func1,obj1,func2,obj2,func3,obj3)
    if instance then
        instance.func_again = func1;
        instance.obj_again = obj1;
        instance.func_sure = func2;
        instance.obj_sure = obj2;
        instance.func_share = func3;
        instance.obj_share = obj3;
    end
end

function EggHunXiaAwardUI.OnOver()
	if not instance then
		return;
	end
	local self = instance;
    self.animOverId = nil;
	local vecReward = self.RewardGroud[self.groupIndex];
	local vecItem = self.ItemGroud[self.groupIndex];
	if PropsEnum.IsRole(vecReward[self.awardIndex].id) then
		local cardInfo = CardHuman:new({number = vecReward[self.awardIndex].id, level=1});
		local isNew = vecReward[self.awardIndex].id == vecItem[self.awardIndex].id
		local heroDes = nil
		if not isNew then
			local itemConfig = ConfigManager.Get(EConfigIndex.t_item, vecItem[self.awardIndex].id)
			local name = itemConfig.name
			heroDes = string.format('此角色已经拥有,自动转化为[ff0000]%s*%d[-],可用于升星和潜能强化。', tostring(name), vecItem[self.awardIndex].count)
		end
        EggGetHero.Start(cardInfo, isNew, heroDes)
        EggGetHero.SetFinishCallback(self.ShowGetHeroEnd, self)
        self:Hide();
    else
        self:PlayNextAwardAni();
    end
end

function EggHunXiaAwardUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/content_jiesuan_hero7.assetbundle";
    UiBaseClass.Init(self, data);
end

function EggHunXiaAwardUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self:SetData(data);
end

function EggHunXiaAwardUI:Restart(data)
    if not UiBaseClass.Restart(self, data) then
        return;
    end
end

function EggHunXiaAwardUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_sure'] = Utility.bind_callback(self, self.on_sure);
    self.bindfunc['on_again'] = Utility.bind_callback(self, self.on_again);
    self.bindfunc['on_share'] = Utility.bind_callback(self, self.on_share);
    self.bindfunc["on_mark"] = Utility.bind_callback(self, self.on_mark);
    self.bindfunc["onStopMove"] = Utility.bind_callback(self, self.onStopMove);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
end

function EggHunXiaAwardUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("content_jiesuan_hero7");

    self.btnAgain = ngui.find_button(self.ui,"centre_other/animation/btn_zai_chou");
    self.btnAgain:set_on_click(self.bindfunc["on_again"]);
    self.labBtnAgain = ngui.find_label(self.ui,"centre_other/animation/btn_zai_chou/animation/lab");
    self.btnSure = ngui.find_button(self.ui,"centre_other/animation/btn_sure");
    self.btnSure:set_on_click(self.bindfunc["on_sure"]);
    local btnMark = ngui.find_button(self.ui,"mark");
    btnMark:set_on_click(self.bindfunc["on_mark"]);
    self.objCost = self.ui:get_child_by_name("centre_other/animation/sp_di");
    self.labCost = ngui.find_label(self.objCost,"lab");
    self.labDes = ngui.find_label(self.ui,"centre_other/animation/txt");
    self.texCost = ngui.find_texture(self.objCost,"Texture_yaoshi");
    local config = ConfigManager.Get(EConfigIndex.t_item, IdConfig.RedCrystal);
    self.texCost:set_texture(config.small_icon);

    self.awardObj = self.ui:get_child_by_name("centre_other/animation/cont1");
    self.awardList = self:init_item(self.awardObj);

    self.cont = {};
    self.dragCycleRoot = self.ui:get_child_by_name("centre_other/animation/sco_view");
    self.dragCycleGroup = ngui.find_enchance_scroll_view(self.ui,"centre_other/animation/sco_view/panel");
    self.dragCycleGroup:set_on_stop_move(self.bindfunc["onStopMove"]);
    self.dragCycleGroup:set_on_initialize_item(self.bindfunc["on_init_item"]);

    self.pointRoot = self.ui:get_child_by_name("centre_other/animation/cont_yeqian");
    self.listPoint = {};
    for i=1,5 do
    	self.listPoint[i] = {};
    	self.listPoint[i].objLiang = self.pointRoot:get_child_by_name("yeqian"..i.."/sp_liang");
    	self.listPoint[i].objHui = self.pointRoot:get_child_by_name("yeqian"..i.."/sp_hui");
    end

    self:UpdateUi();
end

function EggHunXiaAwardUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end

    if self.itemCost then
    	self.labCost:set_text(""..self.itemCost);
    else
    	self.labCost:set_text("");
    end
    if self.des then
    	self.labDes:set_text(""..self.des);
    else
    	self.labDes:set_text("");
    end
    self:UpdateAwardItem();
    self.dragCycleRoot:set_active(false);
    self.pointRoot:set_active(false);
    self.btnAgain:set_active(false);
    self.btnSure:set_active(false);
    self.objCost:set_active(false);
    self.awardObj:set_active(true);
end

function EggHunXiaAwardUI:Show()
    self.ui:set_position(0, 0, 0)
end

function EggHunXiaAwardUI:Hide()
    self.ui:set_position(0, 10000, 0)
end

function EggHunXiaAwardUI:ShowGetHeroEnd()
    self:Show()
	local vecReward = self.RewardGroud[self.groupIndex];
	local vecItem = self.ItemGroud[self.groupIndex];
    if vecReward[self.awardIndex].id ~= vecItem[self.awardIndex].id then
    	local cont = self.awardList[self.awardIndex];
    	vecItem[self.awardIndex].number = vecItem[self.awardIndex].id;
        local cfg = CardProp:new(vecItem[self.awardIndex]);
        cont.labName:set_text(cfg.name);
        if cont.card then
            cont.card:Hide();
        end
        if not cont.item then
        	cont.item = UiSmallItem:new({});
        	cont.item:SetParent(cont.obj);
        end
        cont.item:Show();
        cont.item:SetData(cfg);
        cont.item:SetCount(vecItem[self.awardIndex].count)
        cont.fx2:set_active(true);
        timer.create(Utility.create_callback(self.PlayNextAwardAni, self),300, 1)
    else
        self:PlayNextAwardAni()
    end
end

function EggHunXiaAwardUI:UpdateAwardItem()
    local RewardGroud = self.RewardGroud[self.groupIndex];
    for i=1,7 do
    	local cont = self.awardList[i];
    	local reward = RewardGroud[i];
    	local item = self.ItemGroud[self.groupIndex][i];
    	if reward.id ~= 0 then
    		self:SetAwardItem(cont, reward, item);
    	end
    	cont.root:set_active(false);
    end
    self.awardIndex = 0;
    self.isSkip = false;
    self:PlayNextAwardAni();
end

function EggHunXiaAwardUI:SetAwardItem(cont, reward,  item)
	reward.number = reward.id;
	if cont.item then
		cont.item:Hide();
	end
	if cont.card then
		cont.card:Hide();
	end
    if PropsEnum.IsEquip(reward.id) then
    	if not cont.item then
    		cont.item = UiSmallItem:new({});
    		cont.item:SetParent(cont.obj);
    	end
    	cont.item:Show();
        cont.item:SetData(CardEquipment:new(reward))
        cont.item:SetCount(reward.count)
    elseif PropsEnum.IsRole(reward.id) then
    	if not cont.card then
    		local data = {}
    		data.stypes = 
    		{ 
    		SmallCardUi.SType.Texture,
    		SmallCardUi.SType.Rarity
    		};
    		cont.card = SmallCardUi:new(data);
    		cont.card:SetParent(cont.obj);
    	end
    	cont.card:Show();
        cont.card:SetData(CardHuman:new(reward));
        cont.card:SetTeamPosIcon(0);
    else
    	if not cont.item then
    		cont.item = UiSmallItem:new({});
    		cont.item:SetParent(cont.obj);
    	end
    	cont.item:Show();
        cont.item:SetData(CardProp:new(reward))
        cont.item:SetCount(reward.count)
    end
    local cfg = PublicFunc.IdToConfig(reward.id);
    cont.labName:set_text(cfg.name);
    if reward.id == item.id then
        if PropsEnum.IsRole(reward.id) then
            cont.spNew:set_active(true);
        else
            cont.spNew:set_active(false);
        end
    else
        cont.spNew:set_active(false);
    end
end

function EggHunXiaAwardUI:PlayNextAwardAni()
	if self.awardIndex >= 7 then
		self.isAwardAniOver = true;
        self.animOverId = timer.create(self.bindfunc["on_mark"],1000,1);
	else
		self.awardIndex = self.awardIndex + 1;
		local cont = self.awardList[self.awardIndex]
		if self.awardIndex == 7 and self.RewardGroud[self.groupIndex][self.awardIndex].id == 0 then
			self.isAwardAniOver = true;
		else
			cont.root:set_active(true);
            if self.isSkip then
                self.animOverId = timer.create("EggHunXiaAwardUI.OnOver",10,1);
            else
                self.animOverId = timer.create("EggHunXiaAwardUI.OnOver",300,1);
            end
        end
	end
end

function EggHunXiaAwardUI:DestroyUi()
    if self.awardList then
        for k,v in pairs(self.awardList) do
            if v.item then
                v.item:DestroyUi();
            end
            if v.card then
                v.card:DestroyUi();
            end
        end
        self.awardList = nil;
    end
    if self.cont then
        for k,v in pairs(self.cont) do
            if v.item then
                v.item:DestroyUi();
            end
            if v.card then
                v.card:DestroyUi();
            end
        end
        self.cont = nil;
    end
    if self.animOverId then
        timer.stop(self.animOverId);
        self.animOverId = nil;
    end
    if self.texCost then
        self.texCost:Destroy();
        self.texCost = nil;
    end
    UiBaseClass.DestroyUi(self);
end

function EggHunXiaAwardUI:SetData(data)
	self.RewardGroud = {};
	local cnt = 0;
	self.RewardGroud[1] = {};
	for k,v in ipairs(data.vecReward or {}) do
		cnt = cnt + 1;
		if cnt > 7 then
			self.RewardGroud[#self.RewardGroud+1] = {};
			cnt = 1;
		end
		local num = #self.RewardGroud;
		self.RewardGroud[num] = self.RewardGroud[num] or {};
		table.insert(self.RewardGroud[num], v);
	end
	self.ItemGroud = {};
	cnt = 0;
	self.ItemGroud[1] = {};
	for k,v in ipairs(data.vecItem or {}) do
		cnt = cnt + 1;
		if cnt > 7 then
			self.ItemGroud[#self.ItemGroud+1] = {};
			cnt = 1;
		end
		local num = #self.ItemGroud;
		self.ItemGroud[num] = self.ItemGroud[num] or {};
		table.insert(self.ItemGroud[num], v);
	end
	self.itemCost = data.costItemNum;
	self.des = data.description;
	self.isShowEnd = false;
	self.groupIndex = 1;
end
--确定
function EggHunXiaAwardUI:on_sure()

    EggHunXiaAwardUI.Destroy()
    if self.func_sure then
        self.func_sure(self.obj_sure);
    end
end
--分享
function EggHunXiaAwardUI:on_share()
    if self.func_share then
        self.func_share(self.obj_share);
    end
end
--再抽5次
function EggHunXiaAwardUI:on_again()
    self:on_sure();
    if self.func_again then
        self.func_again(self.obj_again)
    end
end

function EggHunXiaAwardUI:on_mark()
    if self.animOverId then
        timer.stop(self.animOverId);
        self.animOverId = nil
    end
	if self.isAwardAniOver then
		if self.groupIndex < #self.RewardGroud then
			self.groupIndex = self.groupIndex + 1;
			self.isAwardAniOver = false;
			self:UpdateAwardItem();
			self.dragCycleRoot:set_active(false);
			self.pointRoot:set_active(false);
			self.btnAgain:set_active(false);
			self.btnSure:set_active(false);
			self.objCost:set_active(false);
			self.awardObj:set_active(true);
		else
			self.dragCycleRoot:set_active(true);
			self.btnAgain:set_active(true);
			self.btnSure:set_active(true);
			self.objCost:set_active(true);
			self.awardObj:set_active(false);
			if #self.ItemGroud == 1 then
                self.labBtnAgain:set_text("再抽1次");
				self.pointRoot:set_active(false);
			else
				self.pointRoot:set_active(true);
                self.labBtnAgain:set_text("再抽5次");
			end
            local num = #(self.ItemGroud or {});
			self.dragCycleGroup:set_maxNum(num);
			self.dragCycleGroup:refresh_list();
            self.dragCycleGroup:set_index(num);
            self:onStopMove(num);
		end
    else
        self.isSkip = true;
        self:PlayNextAwardAni();
	end
end

function EggHunXiaAwardUI:onStopMove(index)
	for k,v in pairs(self.listPoint) do
		v.objLiang:set_active(k == index);
		v.objHui:set_active(k ~= index);
	end
end

function EggHunXiaAwardUI:on_init_item(obj, index)
    local b = obj:get_instance_id();
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self:update_init_item(self.cont[b], index);
end

function EggHunXiaAwardUI:init_item(obj)
    local cont = {}
    for i=1,7 do
    	cont[i] = {};
    	cont[i].root = obj:get_child_by_name("kug"..i);
    	cont[i].spNew = ngui.find_sprite(cont[i].root,"sp_new");
    	cont[i].labName = ngui.find_label(cont[i].root,"lab_word");
    	cont[i].obj = cont[i].root:get_child_by_name("big_card_item_80");
    	cont[i].fx1 = cont[i].root:get_child_by_name("fx_content_jiesuan1");
    	cont[i].fx2 = cont[i].root:get_child_by_name("fx1");
    	cont[i].fx2:set_active(false);
    end
    return cont;
end

function EggHunXiaAwardUI:update_init_item(cont, index)
	local award = self.ItemGroud;
	if not award[index] then
		return;
	end
	for k,v in ipairs(award[index]) do
		if v.id ~= 0 then
			cont[k].root:set_active(true);
			self:SetAwardItem(cont[k], v, v);
		else
			cont[k].root:set_active(false);
		end
	end
end

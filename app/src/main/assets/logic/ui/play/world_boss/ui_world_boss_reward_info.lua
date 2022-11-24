
--[[fileName:ui/play/world_boss/ui_world_boss_reward_info.lua]]
--[[desc:显示世界boss奖励查看的ui对应的逻辑]]

UiWorldBossReward = Class( "UiWorldBossReward", UiBaseClass );

local countItmeNum = 4;

function UiWorldBossReward:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3003_world_boss.assetbundle";
    UiBaseClass.Init( self, data );
end

function UiWorldBossReward:InitData( data )
    UiBaseClass.InitData( self, data );
end

function UiWorldBossReward:Restart( data )
    UiBaseClass.Restart( self, data );
end

function UiWorldBossReward:DestroyUi()
    UiBaseClass.DestroyUi( self );
    if self.cont then
        for k,v in pairs(self.cont) do
            for kk,vv in pairs(v.items) do
                vv:DestroyUi();
            end
        end
        self.cont = nil;
    end
end

function UiWorldBossReward:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    self.ui:set_name( "ui_world_boss_reward_info" );

    local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
    btnClose:set_on_click(self.bindfunc["onClose"]);
    self.btnAllGet = ngui.find_button(self.ui,"centre_other/animation/btn_get");
    self.btnAllGet:set_on_click(self.bindfunc["onGetAll"]);

    self.scorll = ngui.find_scroll_view(self.ui,"centre_other/animation/sco_view/panel");
    self.cont = {};
    self.wrap = ngui.find_wrap_content(self.ui,"centre_other/animation/sco_view/panel/wrap_content");
    self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);
    
    self:UpdateUi();
end

function UiWorldBossReward:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["onClose"] = Utility.bind_callback( self, self.onClose );
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["onGetAll"] = Utility.bind_callback(self, self.onGetAll);
    self.bindfunc["onGetOne"] = Utility.bind_callback(self, self.onGetOne);
    self.bindfunc["gc_get_world_boss_server_reward"] = Utility.bind_callback(self, self.gc_get_world_boss_server_reward);
end

function UiWorldBossReward:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_world_boss.gc_get_world_boss_server_reward,self.bindfunc["gc_get_world_boss_server_reward"]);
end

function UiWorldBossReward:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_world_boss.gc_get_world_boss_server_reward,self.bindfunc["gc_get_world_boss_server_reward"]);
end

function UiWorldBossReward:UpdateUi()
    if not UiBaseClass.UpdateUi( self ) then
        return;
    end
    
    local _,curBossLv = g_dataCenter.worldBoss:GetBossInfo();
    local cfgEnum = EConfigIndex.t_world_boss_server_reward;
    local listNum = ConfigManager.GetDataCount(cfgEnum);
    self.rewardListCfg = {};
    for i=1,listNum do
        local cfg = ConfigManager.Get(cfgEnum,i);
        if cfg.need_boss_level < curBossLv then
            table.insert(self.rewardListCfg, cfg);
        end
    end
    self.bCanGetAll = false;

    self.wrap:set_min_index(1-#self.rewardListCfg);
    self.wrap:set_max_index(0);
    self.wrap:reset();
    self.scorll:reset_position();
    self:UpdateGetAllBtn();
end

function UiWorldBossReward:UpdateGetAllBtn()
    if self.bCanGetAll then
        PublicFunc.SetButtonShowMode(self.btnAllGet, 1);
        self.btnAllGet:set_enable(true);
    else
        PublicFunc.SetButtonShowMode(self.btnAllGet, 3);
        self.btnAllGet:set_enable(false);
    end
end

function UiWorldBossReward:onClose()
    uiManager:PopUi();
end

function UiWorldBossReward:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    if Utility.isEmpty(self.cont[b]) then
        self.cont[b] = self:init_item(obj)
    end
    self.cont[b].b = b;
    self.cont[b].index = index;
    self:update_item(self.cont[b], index);
end

function UiWorldBossReward:init_item(obj)
    local cont = {}
    cont.labLv = ngui.find_label(obj,"sp_ling/lab_num");
    cont.btnGet = ngui.find_button(obj,"btn_get");
    cont.btnGet:set_on_click(self.bindfunc["onGetOne"]);
    cont.spGot = ngui.find_sprite(obj,"sp_art_font");
    cont.items = {};
    for i=1,countItmeNum do
        local o = obj:get_child_by_name("grid/small_card_item"..i);
        cont.items[i] = UiSmallItem:new({parent=o});
    end
    return cont;
end

function UiWorldBossReward:update_item(cont, index)
    local cfg = self.rewardListCfg[index];
    local isGet = g_dataCenter.worldBoss:GetRewardFlag(index);
    if isGet then
        cont.btnGet:set_active(false);
        cont.spGot:set_active(true);
    else
        self.bCanGetAll = true;
        self:UpdateGetAllBtn();
        cont.btnGet:set_active(true);
        cont.btnGet:set_event_value("",index);
        cont.spGot:set_active(false);
    end
    cont.labLv:set_text(tostring(cfg.need_boss_level));
    for i=1,countItmeNum do
        local reward = cfg.reward[i];
        if reward then
            cont.items[i]:Show();
            cont.items[i]:SetDataNumber(reward.id, reward.num);
        else
            cont.items[i]:Hide();
        end
    end
end

function UiWorldBossReward:onGetAll()
    if self.bCanGetAll then
        msg_world_boss.cg_get_world_boss_server_reward(0, true);
    end
end

function UiWorldBossReward:onGetOne(t)
    local index = t.float_value;
    msg_world_boss.cg_get_world_boss_server_reward(index, false);
end

function UiWorldBossReward:gc_get_world_boss_server_reward(rst, reward)
    CommonAward.Start(reward);
    self.bCanGetAll = false;
    for k,v in pairs(self.cont) do
        self:update_item(v, v.index);
    end
    self:UpdateGetAllBtn();
end

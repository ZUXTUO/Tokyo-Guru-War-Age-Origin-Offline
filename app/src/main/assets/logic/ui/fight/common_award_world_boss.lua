CommonAwardWroldBoss = Class('CommonAwardWroldBoss', MultiResUiBaseClass)

local instance = nil;
local EDamageLv = 
{
    [1] = "sjboss_s",
    [2] = "sjboss_a",
    [3] = "sjboss_b",
}

-- 伤害量，排名，普通奖励{net_summary_item ...}，击杀奖励{net_summary_item ...}
function CommonAwardWroldBoss.Start(damageNum)
    if instance == nil then
        local damageLv,commonAward = g_dataCenter.worldBoss:GetDamageLv(g_dataCenter.player.level, damageNum);
        local rankNum = g_dataCenter.worldBoss:IsHaveOwn();
        local damage = g_dataCenter.worldBoss.demage;
        instance = CommonAwardWroldBoss:new({
            damageLv = damageLv,
            damageNum = damage,
            rankNum = rankNum,
            singleDamage = damageNum,
            commonAward = commonAward,
        })
    end
end

function CommonAwardWroldBoss.SetFinishCallback(callback, obj)
    if instance then
		instance.callbackFunc = callback;
		if instance.callbackFunc then
			instance.callbackObj = obj;
		end
    else    
        app.log("类未初始化 请先调用start"..debug.traceback());
    end
end

function CommonAwardWroldBoss.Destroy()
    if instance then
        instance:DestroyUi()
        instance = nil
    end
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_831_fight_worldboss.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local uiString = 
{
    [1] = '未上榜';
}

function CommonAwardWroldBoss:Init(data)
	self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data);
end

function CommonAwardWroldBoss:DestroyUi()
    if self.contAward then
        for k,v in ipairs(self.contAward) do
            v:DestroyUi()
        end
        self.contAward = nil
    end
    MultiResUiBaseClass.DestroyUi(self)
end

function CommonAwardWroldBoss:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClickGetAwardBtn"] = Utility.bind_callback(self,self.OnClickGetAwardBtn);
end

function CommonAwardWroldBoss:OnClickGetAwardBtn()
    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    CommonAwardWroldBoss.Destroy()

    if self.callbackFunc then
        self.callbackFunc(self.callbackObj)
    end
end

function CommonAwardWroldBoss:RestartData()
    CommonClearing.canClose = false

    MultiResUiBaseClass.RestartData(self)
end

function CommonAwardWroldBoss:InitedAllUI()
    local backui = self.uis[resPaths[resType.Back]]
    backui:set_parent(Root.get_root_ui_2d())
    local btnMark = ngui.find_button(backui, "mark")
    btnMark:set_on_click(self.bindfunc["OnClickGetAwardBtn"], "MyButton.NoneAudio")

    local sp_title = ngui.find_sprite(backui, "center_other/animation/sp_art_font")
    sp_title:set_sprite_name("js_zhandoujieshu")
    local attachObj = backui:get_child_by_name("center_other/animation/add_content")

    local frontui = self.uis[resPaths[resType.Front]]
    frontui:set_parent(attachObj)
    self.ui = frontui;

    self.spFightLv = ngui.find_sprite(self.ui,"animation/sp_point1/sp_rating");
    self.labSingleDamage = ngui.find_label(self.ui,"animation/sp_point2/lab_rank");
    self.labAllDamage = ngui.find_label(self.ui,"animation/sp_point3/lab_rank");
    self.labRank = ngui.find_label(self.ui,"animation/sp_point4/lab_rank");

    self.objAward = self.ui:get_child_by_name("animation/sp_point5");
    self.contAward = {};
    for i=1,5 do
        local obj = self.ui:get_child_by_name("animation/sp_point5/new_small_card_item"..i);
        self.contAward[i] = UiSmallItem:new({parent=obj});
    end

    self:UpdateUi();
end

function CommonAwardWroldBoss:UpdateUi()
    local initData = self:GetInitData()

    self.spFightLv:set_sprite_name(EDamageLv[initData.damageLv]);
    self.labSingleDamage:set_text(tostring(initData.singleDamage));
    self.labAllDamage:set_text(tostring(initData.damageNum));
    if initData.rankNum == 0 then
        self.labRank:set_text("未上榜");
    else
        self.labRank:set_text(tostring(initData.rankNum));
    end

    if initData.singleDamage == 0 then
        self.objAward:set_active(false);
    else
        self.objAward:set_active(true);
        local list = initData.commonAward;
        for i=1,5 do
            if list[i] then
                self.contAward[i]:Show();
                self.contAward[i]:SetDataNumber(list[i].id,list[i].num);
            else
                self.contAward[i]:Hide();
            end
        end
    end
end
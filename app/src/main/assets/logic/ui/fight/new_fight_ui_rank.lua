NewFightUiRank = Class('NewFightUiRank', UiBaseClass);
--初始化
--data =
--{
--  parent = nil    ui挂接的父节点
--  rankInfo = {{name="",damage=0},{name="",demage=0}}  排行榜信息 必须是排好序的排行榜
--  rankPlaces = 1  自己当前上榜排名
--  demage = 1000   你自己的伤害
--}
function NewFightUiRank:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_rank.assetbundle";
    UiBaseClass.Init(self, data);
end

local showRankNum = 5

--初始化数据
function NewFightUiRank:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.showLock = false;
    self._isBuffShow = false;
end

--注册回调函数
function NewFightUiRank:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['OnInOut'] = Utility.bind_callback(self, self.OnInOut);
end

--初始化UI
function NewFightUiRank:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    if self.data.parent then
        self.ui:set_parent(self.data.parent);
        --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
        self.data.parent = nil;
    else
        self.ui:set_parent(Root.get_root_ui_2d_fight());
    end
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0); 
    --ui初始化
    self.control = {}
    --左边语音以及伤害记录面板
    local leftOther = self.control;
    leftOther.objAnim = self.ui:get_child_by_name("animation");
    --leftOther.objHurt = self.ui:get_child_by_name("animation/cont2");
    leftOther.txtTitle = ngui.find_label(self.ui, "txt");
    for i = 1, showRankNum do
        leftOther["objPlaces"..i] = self.ui:get_child_by_name("cont"..i);
        leftOther["labPlaces"..i.."Name"] = ngui.find_label(leftOther["objPlaces"..i], "lab2");
        leftOther["labPlaces"..i.."Value"] = ngui.find_label(leftOther["objPlaces"..i], "lab3");
    end
    leftOther["labOwnValue"] = ngui.find_label(self.ui, "lab_num");
    leftOther["labOwnValue"]:set_text("[00C0FFFF]您的伤害[-]你的伤害 "..tostring(0));
    leftOther["txtOwnPlaces"] = ngui.find_label(self.ui, "lab_rank");
    leftOther["txtOwnPlaces"]:set_text("");
    leftOther["labOwnNotPlaces"] = ngui.find_label(self.ui, "txt_weishangbang");
    leftOther["spArrows"] = ngui.find_sprite(self.ui, "sp_arrows");
    leftOther["btnOut"] = ngui.find_button(self.ui, "btn_empty");
    leftOther["btnOut"]:set_on_click(self.bindfunc['OnInOut']);
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_WorldBoss then
        self:UpdateRank(g_dataCenter.worldBoss.rankInfo, g_dataCenter.worldBoss.demage, g_dataCenter.worldBoss:IsHaveOwn());
    elseif  FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_GuildBoss then
        self:UpdateRank(g_dataCenter.guildBoss.curRankInfo, g_dataCenter.guildBoss.damage, g_dataCenter.guildBoss:IsHaveOwn());
    end
    self.isOut = false;

    self.objBuff = self.ui:get_child_by_name("animation/sp_bk");
    self:UpdateBuffState(self._isBuffShow);
end
--析构函数
function NewFightUiRank:DestroyUi()
    self._isBuffShow = false;
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end
--排行榜更新
function NewFightUiRank:UpdateRank(rankInfo, demage, rankPlaces, singleDamage)
    self.data.rankInfo = rankInfo or self.data.rankInfo or {};
    self.data.demage = demage or self.data.demage or 0;
    self.data.rankPlaces = rankPlaces or self.data.rankPlaces or 0;
    local leftOther = self.control;
    if not self.ui then
        return;
    end
    local worldBossData = self.data;
    for i = 1, showRankNum do
        if worldBossData.rankInfo then
            local nSize = #worldBossData.rankInfo;
            if worldBossData.rankInfo[nSize - i + 1] then
                leftOther["objPlaces"..i]:set_active(true);
                leftOther["labPlaces"..i.."Name"]:set_text(tostring(worldBossData.rankInfo[i].name));
                leftOther["labPlaces"..i.."Value"]:set_text(tostring(worldBossData.rankInfo[i].damage));
            else
                leftOther["objPlaces"..i]:set_active(false);
            end
        else
            leftOther["objPlaces"..i]:set_active(false);
        end
    end
    --app.log(table.tostring(worldBossData));
    leftOther["labOwnValue"]:set_text("[00C0FFFF]您的伤害[-] "..tostring(self.data.demage));
    local isHave = self.data.rankPlaces;
    if isHave > 0 then
        leftOther["txtOwnPlaces"]:set_text("[00C0FFFF]排名[-] " .. tostring(isHave));
        --leftOther["labOwnPlaces"]:set_text(tostring(isHave));
        leftOther["labOwnNotPlaces"]:set_active(false);
    else
        leftOther["txtOwnPlaces"]:set_text("");
        --leftOther["labOwnPlaces"]:set_text("");
        leftOther["labOwnNotPlaces"]:set_active(true);
    end
end

function NewFightUiRank:UpdateBuffState(isActive)
    self._isBuffShow = isActive;
    if self.objBuff then
        self.objBuff:set_active(isActive);
    end
end

function NewFightUiRank:OnInOut()
    local leftOther = self.control;
    self.isOut = not self.isOut;
    if self.isOut then
        leftOther.objAnim:animated_play("fight_stboss_out");
        leftOther["spArrows"]:get_game_object():set_local_rotation(0, 0, 180);
    else
        leftOther.objAnim:animated_play("fight_stboss_jin");
        leftOther["spArrows"]:get_game_object():set_local_rotation(0, 0, 0);
    end
end
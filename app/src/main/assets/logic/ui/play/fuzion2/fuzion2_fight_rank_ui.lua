Fuzion2FightRankUI = Class("Fuzion2FightRankUI", UiBaseClass);

function Fuzion2FightRankUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/new_fight_ui_daluandou.assetbundle";
    UiBaseClass.Init(self, data);
end

function Fuzion2FightRankUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function Fuzion2FightRankUI:SetData(playerList)
    self.playerList = {};
    for k,v in pairs(playerList) do
        table.insert(self.playerList,v);
    end
    local mygid = g_dataCenter.player:GetGID();
    table.sort(self.playerList,function (a,b)
        if a.surviveTime == 0 and b.surviveTime ~= 0 then
            return true;
        elseif a.surviveTime ~= 0 and b.surviveTime == 0 then
            return false;
        end
        if a.surviveTime > b.surviveTime then
            return true;
        elseif a.surviveTime < b.surviveTime then
            return false;
        end
        if a.kill > b.kill then
            return true;
        elseif a.kill < b.kill then
            return false;
        end
        if a.dead < b.dead then
            return true;
        elseif a.dead > b.dead then
            return false;
        end
        if a.playerid ~= mygid and b.playerid == mygid then
            return true;
        end
        return false;
    end)
    self:UpdateUi();
end

function Fuzion2FightRankUI:SetKillNum(num)
    self.killNum = num;
    if self.labKillNum then
        self.labKillNum:set_text(tostring(num));
    end
end

function Fuzion2FightRankUI:SetDeadNum(num)
    self.deadNum = num;
    if self.labDeadNum then
        self.labDeadNum:set_text(tostring(num));
    end
end

function Fuzion2FightRankUI:SetSurviveNum(num, total)
    self.surviveNum = {num,total};
    if self.labSurviveNum then
        self.labSurviveNum:set_text(tostring(num).."/"..tostring(total));
    end
end

function Fuzion2FightRankUI:SetRank(num)
    self.rank = num;
    if self.labRank then
        self.labRank:set_text("第"..tostring(num).."名");
    end
end


function Fuzion2FightRankUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function Fuzion2FightRankUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
end

function Fuzion2FightRankUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

function Fuzion2FightRankUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function Fuzion2FightRankUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("Fuzion2FightRankUI");

    self.cont = {};
    for i=1,10 do
        local obj = self.ui:get_child_by_name("animation/cont/cont"..i);
        self:on_init_item(obj, i,i-1);
    end

    local btn = ngui.find_button(self.ui,"animation/btn_empty");
    btn:set_on_click(self.bindfunc["on_click"]);

    self.labRank = ngui.find_label(self.ui,"animation/cont_rank/lab_num");
    self.labKillNum = ngui.find_label(self.ui,"animation/cont_rank/lab_kill");
    self.labDeadNum = ngui.find_label(self.ui,"animation/cont_rank/lab_escape");
    self.labSurviveNum = ngui.find_label(self.ui,"animation/cont_rank/lab_score");

    self.objArrows = self.ui:get_child_by_name("animation/sp_arrows");

    self.anim = self.ui:get_child_by_name("animation");
    self.isOpen = true;

    self:UpdateUi();
end

function Fuzion2FightRankUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
	if not self.playerList then return end;
    for i=1,10 do
        self:on_init_item(self.cont[i].root, i,i-1);
    end
    self.labRank:set_text("第10名")
    self.labKillNum:set_text("0")
    self.labDeadNum:set_text("0")
    self.labSurviveNum:set_text("10/10");
    if self.killNum then
        self:SetKillNum(self.killNum);
    end
    if self.deadNum then
        self:SetDeadNum(self.deadNum);
    end
    if self.surviveNum then
        self:SetSurviveNum(self.surviveNum[1], self.surviveNum[2]);
    end
    if self.rank then
        self:SetRank(self.rank);
    end
end

function Fuzion2FightRankUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function Fuzion2FightRankUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local cont = self.cont[b] or {};
    if Utility.isEmpty(cont) then
        -- cont.labRank = ngui.find_label(obj,"lab_name");
        cont.root = obj;
        cont.labName = ngui.find_label(obj,"lab2");
        cont.labKill = ngui.find_label(obj,"lab3");
        cont.labTime = ngui.find_label(obj,"lab4");
        self.cont[b] = cont;
    end
    local playerInfo = self.playerList[index];
    if playerInfo then
        cont.root:set_active(true);
    else
        cont.root:set_active(false);
        return;
    end

    if playerInfo.name then
        cont.labName:set_text(tostring(playerInfo.name));
    else
        cont.labName:set_text("");
    end
    if playerInfo.kill then
        cont.labKill:set_text(tostring(playerInfo.kill).."杀");
    else
        cont.labKill:set_text("");
    end
    if playerInfo.surviveTime and playerInfo.surviveTime ~= 0 then
        cont.labTime:set_text(PublicFunc.FormatLeftSeconds(playerInfo.surviveTime,false));
    else
        cont.labTime:set_text("存活");
    end
    if playerInfo.surviveTime == 0 then
        cont.labName:set_color(1,1,1,1);
        cont.labKill:set_color(1,1,1,1);
    else
        cont.labName:set_color(0.5,0.5,0.5,1);
        cont.labKill:set_color(0.5,0.5,0.5,1);
    end
end

function Fuzion2FightRankUI:on_click()
    if self.isOpen then
        self.isOpen = false;
        self.anim:animated_play("fight_rank")
        self.objArrows:set_local_rotation(0,0,180);
    else
        self.isOpen = true;
        self.anim:animated_play("fight_rank_jin")
        self.objArrows:set_local_rotation(0,0,0);
    end
end

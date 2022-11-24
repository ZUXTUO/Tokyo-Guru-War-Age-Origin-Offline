FightFuzionTopUI = Class("FightFuzionTopUI", UiBaseClass);

function FightFuzionTopUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/new_fight/ui_1004_da_luan_dou.assetbundle";
    UiBaseClass.Init(self, data);
end

function FightFuzionTopUI:InitData(data)
    UiBaseClass.InitData(self, data);
    self.rank =  nil;
    self.killNum = nil;
    self.deadNum = nil;
    self.surviveNum = nil;
end

function FightFuzionTopUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function FightFuzionTopUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("FightFuzionTopUI");

    self.labRank = ngui.find_label(self.ui,"defense_house/lab_num");
    self.labKillNum = ngui.find_label(self.ui,"defense_house/lab_kill");
    self.labDeadNum = ngui.find_label(self.ui,"defense_house/lab_escape");
    self.labSurviveNum = ngui.find_label(self.ui,"defense_house/lab_score");

    self.labRank:set_text("");
    self.labKillNum:set_text("0");
    self.labDeadNum:set_text("0");
    self.labSurviveNum:set_text("0/0");
    
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

function FightFuzionTopUI:SetKillNum(num)
    self.killNum = num;
    if self.labKillNum then
        self.labKillNum:set_text(tostring(num));
    end
end

function FightFuzionTopUI:SetDeadNum(num)
    self.deadNum = num;
    if self.labDeadNum then
        self.labDeadNum:set_text(tostring(num));
    end
end

function FightFuzionTopUI:SetSurviveNum(num, total)
    self.surviveNum = {num,total};
    if self.labSurviveNum then
        self.labSurviveNum:set_text(tostring(num).."/"..tostring(total));
    end
end

function FightFuzionTopUI:SetRank(num)
    self.rank = num;
    if self.labRank then
        self.labRank:set_text("第"..tostring(num).."名");
    end
end

function FightFuzionTopUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end
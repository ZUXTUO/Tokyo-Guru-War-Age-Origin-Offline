UiJiaoTangQiDaoChoseHero = Class('UiJiaoTangQiDaoChoseHero',FormationUi);
function UiJiaoTangQiDaoChoseHero:GetData()
    local tempHeroId = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetTempChoseHero();
    local hero_id;
    if tempHeroId then
        hero_id = tempHeroId;
    else
        if g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1) ~= "0" then
            hero_id = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:GetQidaoHero(1);
        else
            hero_id = nil;
        end
    end
    return hero_id;
end

function UiJiaoTangQiDaoChoseHero:Restart()
    self:SetPlayerGID();
    UiBaseClass.Restart(self);
end

function UiJiaoTangQiDaoChoseHero:SetPlayerGID()
    self.playerGID = g_dataCenter.player:GetGID();
    self.heroMaxNum = 1;
    self.heroType = 0;
    self.player = g_dataCenter.player;
    self.package = g_dataCenter.package;
    self.teamInfo = {};
    self.teamInfo[1] = self:GetData();
    self:UpdateUi();
end

function UiJiaoTangQiDaoChoseHero:RegistFunc()
    FormationUi.RegistFunc(self)
end

function UiJiaoTangQiDaoChoseHero:MsgRegist()
end

function UiJiaoTangQiDaoChoseHero:MsgUnRegist()
end

function UiJiaoTangQiDaoChoseHero:CheckChangeTeam()
    local flg = false;
    local defHero = self:GetData();
    if defHero ~= self.teamInfo[1] then
        flg = true;
    end
    return flg;
end

function UiJiaoTangQiDaoChoseHero:CheckDefaultTeam()
end

function UiJiaoTangQiDaoChoseHero:on_save(end_callback)
    -- if self.teamInfo[1] == nil then
    --     local btn1 = {str="确定",
    --         func=function ()
    --             local param_type = type(end_callback);
    --             if param_type == "string" or param_type == "function" then
    --                 Utility.CallFunc(end_callback);
    --             end
    --         end
    --     };
    --     HintUI.SetAndShow(1,"队长位置不能空缺！",btn1);
    --     return;
    -- end

    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetTempChoseHero(self.teamInfo[1]); 
    g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_JiaoTangQiDao]:SetQidaoHero(1,self.teamInfo[1]);

    local param_type = type(end_callback);
    if param_type == "string" or param_type == "function" then
        Utility.CallFunc(end_callback);
    end
end

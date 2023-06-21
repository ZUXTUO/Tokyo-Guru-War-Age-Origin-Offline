QingTongJiDiFightUI = Class("QingTongJiDiFightUI",UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_3v3.assetbundle";

function QingTongJiDiFightUI.GetResList()
    return {res}
end

function QingTongJiDiFightUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function QingTongJiDiFightUI:InitData(data)
    UiBaseClass.InitData(self,data);
    self.parent = data.parent;
    self.killCnt = data.killCnt or 0
    self.deadCnt = data.deadCnt or 0
    self.getSoul = data.getSoul or 0
    self.loseSoul = data.loseSoul or 0
    self.curGetSoul = -1
    self.curLoseSoul = -1
    self.systemId = MsgEnum.eactivity_time.eActivityTime_threeToThree;
    self.dataCenter = g_dataCenter.activity[self.systemId];
    self.maxVal = self.dataCenter:GetMaxSoul()
    self.showLock = false;
    self.leftSide = self.dataCenter:IsPlayerLeftSide()
end

function QingTongJiDiFightUI:Restart(data)
	UiBaseClass.Restart(self,data);
end

function QingTongJiDiFightUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

function QingTongJiDiFightUI:InitUI(obj)
    self.ui = asset_game_object.create(obj);
    self.ui:set_parent(self.parent)
    self.ui:set_local_scale(1,1,1);
    self.ui:set_local_position(0,0,0);

    self.redLab = ngui.find_label(self.ui, 'lab_blue')
    self.buleLab = ngui.find_label(self.ui, 'lab_red')

    self.nodeSoulLeft = self.ui:get_child_by_name("pro_di_left")
    self.nodeSoulRight = self.ui:get_child_by_name("pro_di_right")

    self.proBarLeft = ngui.find_progress_bar(self.nodeSoulLeft, "pro_di_left")
    self.proBarRight = ngui.find_progress_bar(self.nodeSoulRight, "pro_di_right")
    self.labValueLeft = ngui.find_label(self.nodeSoulLeft, "pro_di_left/lab")
    self.labValueRight = ngui.find_label(self.nodeSoulRight, "pro_di_right/lab")

    -- self.fxLeftGetSoul = self.nodeSoulLeft:get_child_by_name("fx_new_fight_ui_3v3_hunzhi_xishou")
    -- self.fxLeftMaxSoul = self.nodeSoulLeft:get_child_by_name("fx_new_fight_ui_3v3_hunzhi_man")
    -- self.fxRightGetSoul = self.nodeSoulRight:get_child_by_name("fx_new_fight_ui_3v3_hunzhi_xishou")
    -- self.fxRightMaxSoul = self.nodeSoulRight:get_child_by_name("fx_new_fight_ui_3v3_hunzhi_man")

    self:UpdateUi()
end

function QingTongJiDiFightUI:GetProbarPos(campFlag)
    local x, y, z = 0, 0, 0
    if campFlag == 1 then
        if not self.posLeft then
            local ui_camera = Root.get_ui_camera();
            x,y,z = self.nodeSoulLeft:get_position()
            x,y,z = ui_camera:world_to_screen_point(x,y,z)
            x,y = PublicFunc.TouchPtToNguiPoint(x,y)
            self.posLeft = {x,y}
        end
        x, y = self.posLeft[1], self.posLeft[2]
    elseif campFlag == 2 then
        if not self.posRight then
            local ui_camera = Root.get_ui_camera();
            x,y,z = self.nodeSoulRight:get_position()
            x,y,z = ui_camera:world_to_screen_point(x,y,z)
            x,y = PublicFunc.TouchPtToNguiPoint(x,y)
            self.posRight = {x,y}
        end
        x, y = self.posRight[1], self.posRight[2]
    end
    return x, y, 0
end

function QingTongJiDiFightUI:UpdateData(data)
    self:UpdateUi();
end

function QingTongJiDiFightUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then return end
    
    --self.lab:set_text(string.format('%d/:%d', self.killCnt, self.deadCnt))
    if self.leftSide then
        self.redLab:set_text(tostring(self.killCnt))
        self.buleLab:set_text(tostring(self.deadCnt))
    else
        self.redLab:set_text(tostring(self.deadCnt))
        self.buleLab:set_text(tostring(self.killCnt))
    end

    if self.getSoul ~= self.curGetSoul then
        self.proBarLeft:set_value(self.getSoul / self.maxVal)
        self.labValueLeft:set_text(math.floor(self.getSoul * 100 / self.maxVal).."%")
        self.curGetSoul = self.getSoul
        
        -- if self.curGetSoul == self.maxVal then
        --     self.fxLeftMaxSoul:set_active(false)
        --     self.fxLeftMaxSoul:set_active(true)
        -- else
        --     self.fxLeftGetSoul:set_active(false)
        --     self.fxLeftGetSoul:set_active(true)
        -- end
    end
    if self.loseSoul ~= self.curLoseSoul then
        self.proBarRight:set_value(self.loseSoul / self.maxVal)
        self.labValueRight:set_text(math.floor(self.loseSoul * 100 / self.maxVal).."%")
        self.curLoseSoul = self.loseSoul
        
        -- if self.curLoseSoul == self.maxVal then
        --     self.fxRightMaxSoul:set_active(false)
        --     self.fxRightMaxSoul:set_active(true)
        -- else
        --     self.fxRightGetSoul:set_active(false)
        --     self.fxRightGetSoul:set_active(true)
        -- end
    end
end

function QingTongJiDiFightUI:UpdateScoreData(killCnt, deadCnt)
    self.killCnt = killCnt or 0
    self.deadCnt = deadCnt or 0
    self:UpdateUi()
end

function QingTongJiDiFightUI:UpdateSoulData(getSoul, loseSoul)
    self.getSoul = getSoul or 0
    self.loseSoul = loseSoul or 0
    self:UpdateUi()
end
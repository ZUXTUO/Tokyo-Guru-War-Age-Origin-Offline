Fuzion2RankUI = Class("Fuzion2RankUI", MultiResUiBaseClass);

-------------------------------------外部方法-------------------------------------
function Fuzion2RankUI.Start(data)
	if Fuzion2RankUI.cls == nil then
		Fuzion2RankUI.cls = Fuzion2RankUI:new()
	end
    Fuzion2RankUI.cls:Show();
    if data then
        Fuzion2RankUI.cls:SetData(data);
    end
    return Fuzion2RankUI.cls;
end

function Fuzion2RankUI.SetFinishCallback(callback, obj)
	if Fuzion2RankUI.cls then
        Fuzion2RankUI.cls:SetCallback(callback, obj);
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end
function Fuzion2RankUI.Destroy()
    if Fuzion2RankUI.cls then
        Fuzion2RankUI.cls:DestroyUi();
        Fuzion2RankUI.cls = nil;
    end
end
-------------------------------------类方法-------------------------------------
function Fuzion2RankUI:Init(data)
    self.pathRes = 
    {
    "assetbundles/prefabs/ui/fuzion/ui_2902_fuzion.assetbundle",
    "assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle",
    }
    MultiResUiBaseClass.Init(self, data);
end

function Fuzion2RankUI:InitData(data)
    MultiResUiBaseClass.InitData(self, data);
end

function Fuzion2RankUI:SetData(playerList)
    self.playerList = {};
    for k,v in pairs(playerList) do
        table.insert(self.playerList,v);
    end
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
        return false;
    end)
    self:UpdateUi();
end

function Fuzion2RankUI:Restart(data)
    if MultiResUiBaseClass.Restart(self, data) then
    end
end

function Fuzion2RankUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item);
    self.bindfunc["on_click"] = Utility.bind_callback(self, self.on_click);
end

function Fuzion2RankUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
end

function Fuzion2RankUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self);
end

function Fuzion2RankUI:InitedAllUI()
    MultiResUiBaseClass.InitedAllUI(self);
    local title = ngui.find_sprite(self.uis[self.pathRes[2]],"center_other/animation/sp_art_font");
    title:set_sprite_name("js_zhandoujieshu");
    local parent = self.uis[self.pathRes[2]]:get_child_by_name("center_other/animation/add_content");
    self.uis[self.pathRes[1]]:set_parent(parent);
    self.ui = self.uis[self.pathRes[1]];
    self.ui:set_name("ui_6102_daluandou");

    self.cont = {};
    -- self.scroll = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view/panel_list");
    -- self.wrap = ngui.find_wrap_content(self.ui,"centre_other/animation/scroll_view/panel_list/wrap_content");
    -- self.wrap:set_on_initialize_item(self.bindfunc["on_init_item"]);
    -- self.wrap:set_min_index(-9);
    -- self.wrap:set_max_index(0);
    for i=1,5 do
        local obj = self.ui:get_child_by_name("left_grid/cont_item"..i);
        self:on_init_item(obj, i,i-1);
    end
    for i=1,5 do
        local obj = self.ui:get_child_by_name("right_gird/cont_item"..i);
        self:on_init_item(obj, i+5,i-1+5);
    end

    self.btn = ngui.find_button(self.uis[self.pathRes[2]],"mark");
    self.btn:set_on_click(self.bindfunc["on_click"], "MyButton.NoneAudio");
    -- self.title = self.ui:get_child_by_name("centre_other/animation/sp_title");

    self:SetCallback(self.callbackFunc,self.callbackObj);

    self:UpdateUi();
end

function Fuzion2RankUI:UpdateUi()
    if not MultiResUiBaseClass.UpdateUi(self) then
        return;
    end
	if not self.playerList then return end;
    for i=1,10 do
        self:on_init_item(nil, i, i-1);
    end
    -- self.wrap:reset();
    -- self.scroll:reset_position();
end

function Fuzion2RankUI:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self);
end

function Fuzion2RankUI:on_init_item(obj, b, real_id)
    local index = math.abs(real_id)+1;
    local cont = self.cont[b] or {};
    if Utility.isEmpty(cont) then
        -- cont.labRank = ngui.find_label(obj,"lab_name");
        cont.labArea = ngui.find_label(obj,"lab_qu");
        cont.labName = ngui.find_label(obj,"lab_name");
        cont.labKill = ngui.find_label(obj,"lab_num");
        cont.labTime = ngui.find_label(obj,"lab_time");
        cont.labLevel = ngui.find_label(obj,"lab_level");
        cont.spSelf = ngui.find_sprite(obj,"sp_art_font");
        local objHead = obj:get_child_by_name("sp_head_di_item");
        cont.Head = UiPlayerHead:new({parent=objHead});
        self.cont[b] = cont;
    end
    local playerInfo = self.playerList[index] or {};
    -- cont.labRank:set_text(tostring(index))
    if playerInfo.area then
        local info = ConfigManager.Get(EConfigIndex.t_country_info,playerInfo.area);
        if info then
            cont.labArea:set_text(info.name)
        else
            cont.labArea:set_text("");
        end
    else
        cont.labArea:set_text("");
    end
    if playerInfo.surviveTime and playerInfo.surviveTime ~= 0 then
        cont.labTime:set_text("存活时间 [FCD901FF]"..PublicFunc.FormatLeftSeconds(playerInfo.surviveTime,false));
    else
        cont.labTime:set_text("存活");
    end
    if playerInfo.name then
        cont.labName:set_text(tostring(playerInfo.name));
    else
        cont.labName:set_text("");
    end
    if playerInfo.kill then
        cont.labKill:set_text("击败 [FCD901FF]"..tostring(playerInfo.kill));
    else
        cont.labKill:set_text("");
    end
    if playerInfo.heroLevel then
        cont.labLevel:set_text(tostring(playerInfo.heroLevel));
    else
        cont.labLevel:set_text("");
    end
    if playerInfo.playerid == g_dataCenter.player:GetGID() then
        cont.spSelf:set_active(true);
    else
        cont.spSelf:set_active(false);
    end
    if playerInfo.playerImage then
        cont.Head:SetRoleId(playerInfo.playerImage);
        cont.Head:Show();
    else
        cont.Head:Hide();
    end
end

function Fuzion2RankUI:SetCallback(func,obj)
    self.callbackFunc = func;
    if self.callbackFunc then
        self.callbackObj = obj;
    end
    if not self.ui then return end;
    if func then
        self.btn:set_active(true);
        -- self.title:set_active(true);
    else
        self.btn:set_active(false);
        -- self.title:set_active(false);
    end
end

function Fuzion2RankUI:on_click()
    Utility.CallFunc(self.callbackFunc,self.callbackObj);
end

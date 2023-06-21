NewFightUiTask = Class('NewFightUiTask', UiBaseClass);
-----------------------------------外部接口----------------------------------
--data=
--{
--  strWave = ""        波次   不传就为隐藏
--  content1 = {txt="", lab=""}  第一个标签 txt前段文字 lab后段文字
--  content2 = {lab=""}  第二个标签 txt前段文字 lab后段文字
--  content3 = {lab=""}  第三个标签 txt前段文字 lab后段文字
--  content4 = {lab=""}  第四个标签 txt前段文字 lab后段文字
--  content5 = {lab=""}  第五个标签 txt前段文字 lab后段文字
--  content6 = {lab=""}  第六个标签 txt前段文字 lab后段文字
--}
--clear 是否清空原来的data
function NewFightUiTask:SetData(data, clear)
    if clear then
        self.data = data;
    else
        for k, v in pairs(data) do
            self.data[k] = v;
        end
    end
    self:UpdateUi();
end
--------------------------------内部接口-------------------------------------
--初始化
function NewFightUiTask:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_task.assetbundle";
    UiBaseClass.Init(self, data);
end

--初始化数据
function NewFightUiTask:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.showLock = false;
end

--初始化UI
function NewFightUiTask:InitUI(asset_obj)
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
    local topOther = self.control;
    --上方包含条
    topOther.objContRoot = self.ui:get_child_by_name("cont");
    --topOther.spTitleBk = ngui.find_sprite(topOther.objContRoot,"sp_title_di");
    topOther.labWave = ngui.find_label(topOther.objContRoot, "lab");
    for i = 1, 6 do
        topOther["objCont"..i] = topOther.objContRoot:get_child_by_name("content"..i);
        topOther["txtCont"..i] = ngui.find_label(topOther["objCont"..i], "txt");
        topOther["labCont"..i] = ngui.find_label(topOther["objCont"..i], "lab_num");
    end
    --更新ui
    self:UpdateUi();
end
--析构函数
function NewFightUiTask:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
end
--更新ui
function NewFightUiTask:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
        local topOther = self.control;
        local data = self.data;
        -- if data.isHideBk then
        --     topOther.spTitleBk:set_active(false);
        -- else
        --     topOther.spTitleBk:set_active(true);
        -- end
        data.strWave = data.strWave or "";
        topOther.labWave:set_text(tostring(data.strWave));

        for i = 1, 6 do
            if data["content"..i] and data["content"..i].lab then
                topOther["objCont"..i]:set_active(true);
                if i == 1 then
                    topOther["txtCont"..i]:set_text(tostring(data["content"..i].txt));
                end
                topOther["labCont"..i]:set_text(tostring(data["content"..i].lab));
            else
                topOther["objCont"..i]:set_active(false);
            end
        end
    end
end
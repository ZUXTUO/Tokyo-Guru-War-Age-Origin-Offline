
FightMonsterGuide = Class('FightMonsterGuide', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/panel_guaiwu_zhishi.assetbundle"

function FightMonsterGuide.GetResList()
    return {res}
end

function FightMonsterGuide:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function FightMonsterGuide:Restart(data)
    UiBaseClass.Restart(self, data)

    self:ResetData()
end

function FightMonsterGuide:ResetData()
    self.clonePool = {};
    self.usePool = {};
    --超过好多距离就开始提示
    local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_monsterGuideDiff);
    if cf then
        self.attackDiff = cf.data;
    else
        self.attackDiff = 5;
    end
    cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_monsterGuideCount);
    if cf then
        self.smallMonsterCount = cf.data;
    else
        self.smallMonsterCount = 5;
    end
    --玩家跟箭头之间的ui距离
    self.playerDiff = 250;

    self.smallMonster = 0;
end

function FightMonsterGuide:RegistFunc()
    UiBaseClass.RegistFunc(self)
end

function FightMonsterGuide:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.cloneCnt = self.ui:get_child_by_name("cont");
    self.cloneCnt:set_active(false);
end

function FightMonsterGuide:GetOneGuide(name, isSmall)
    if #self.clonePool <= 0 then
        local cloneObj = {}
        cloneObj.obj = self.cloneCnt:clone();
        cloneObj.obj:set_parent(self.ui);
        cloneObj.obj:set_local_position(0, 0, 0);
        cloneObj.obj:set_active(false);
        cloneObj.isShow = false;
        cloneObj.spArrow = ngui.find_sprite(cloneObj.obj, "sp_jiantou");
        cloneObj.spArrowAngle = 0;
        cloneObj.spIcon = ngui.find_sprite(cloneObj.obj, "sp");
        cloneObj.spIconName = nil;
        table.insert(self.clonePool, cloneObj);
    end
    local temp = self.clonePool[#self.clonePool];
    temp.isSmall = isSmall;
    if isSmall then
        self.smallMonster = self.smallMonster + 1;
    end
    self.clonePool[#self.clonePool] = nil;
    self.usePool[name] = temp;
    return temp;
end

function FightMonsterGuide:DestroyUi()
    self.clonePool = {};
    self.usePool = {};
    self.smallMonster = 0;
end


function FightMonsterGuide:Update(dt)
    local captain = g_dataCenter.fight_info:GetCaptain();
    if captain == nil  or captain:IsDead() then
        return;
    end
    -- app.log("1  usePool="..table.tostring(self.usePool));
    --先回收没用的对象
    local isReturn = false;
    local tempEntity = nil;
    for k, v in pairs(self.usePool) do
        tempEntity = ObjectManager.GetObjectByName(k);
        --怪不存在了或者死了  回收
        if tempEntity == nil or tempEntity:IsDead() then
            isReturn = true;
        else
            --距离太近了  回收
            if captain:GetDistanceToEntity(tempEntity) < self.attackDiff then
                isReturn = true;
            end
        end
        if isReturn then
            table.insert(self.clonePool, self.usePool[k]);
            self.usePool[k].obj:set_active(false);
            self.usePool[k].isShow = false;
            if self.usePool[k].isSmall then
                self.smallMonster = self.smallMonster - 1;
            end
            self.usePool[k] = nil;
        --不回收就更新怪物信息
        else
            self:UpdateMonster(tempEntity, v);
        end
    end
    -- app.log("2    usePool="..table.tostring(self.usePool));
    local monsterList = g_dataCenter.fight_info:GetMonsterList(EFightInfoFlag.flag_b);
    local isSoldier = false;
    local cloneObj = nil;
    for k, v in pairs(monsterList) do
        if self.usePool[k] == nil then
            tempEntity = ObjectManager.GetObjectByName(k);
            if tempEntity and not tempEntity:IsDead() then
                isSoldier = tempEntity:IsSoldier();
                -- app.log(tostring(k).."...."..tostring(captain:GetDistanceToEntity(tempEntity)).."...."..tostring(self.attackDiff));
                if captain:GetDistanceToEntity(tempEntity) >= self.attackDiff then
                    --小兵限制数量
                    if isSoldier then
                        if self.smallMonster < self.smallMonsterCount then
                            cloneObj = self:GetOneGuide(k, tempEntity:IsSoldier());
                            self:UpdateMonster(tempEntity, cloneObj);
                        end
                    else
                        cloneObj = self:GetOneGuide(k, tempEntity:IsSoldier());
                        self:UpdateMonster(tempEntity, cloneObj);
                    end
                end
            end
        end
    end
    -- app.log("3    usePool="..table.tostring(self.usePool));
end

function FightMonsterGuide:UpdateMonster(entity, cloneObj)
    local captain = g_dataCenter.fight_info:GetCaptain();
    if captain == nil  or captain:IsDead() then
        return;
    end
    cloneObj.obj:set_name(tostring(entity:GetName()));
    --是否显示
    if not cloneObj.isShow then
        cloneObj.obj:set_active(true);
        cloneObj.isShow = true;
    end
    --是否显示图片
    local iconName = ""
    if entity:IsBoss() then
        iconName = "zjm_zhishi1";
    elseif entity:IsSuper() then
        iconName = "zjm_zhishi2";
    end
    
    local cap_x, cap_y = self:GetUiPos(captain);
    local entity_x, entity_y = self:GetUiPos(entity);
    --算角度
    local ang = self:GetAngle(cap_x, cap_y, entity_x, entity_y);
    --加10算作角度的偏移差
    ang = ang + 10;
    -- app.log(tostring(entity:GetName())..".."..tostring(cap_x)..".."..
    --     tostring(cap_y)..".."..tostring(entity_x)..".."..tostring(entity_y).."....."..tostring(ang));
    cloneObj.obj:set_local_rotation(0, 0, ang);
    if iconName ~= cloneObj.spIconName then
        cloneObj.spIcon:set_sprite_name(iconName);
        cloneObj.spIconName = iconName;
    end
    if cloneObj.spIconName ~= "" then
        cloneObj.spIcon:get_game_object():set_local_rotation(0, 0, -ang);
    end
    --设距离
    -- local posx, posy = algorthm.GetPointLine(0, 0, self.playerDiff, entity_x - cap_x, entity_y - cap_y);
    local posx, posy = algorthm.GetRoundPoint(0, 0, self.playerDiff, ang - 90);
    cloneObj.obj:set_local_position(posx, posy, 0);
end

function FightMonsterGuide:GetUiPos(entity)
    -- local fight_camera = CameraManager.GetSceneCamera();
    -- local ui_camera = Root.get_ui_camera();
    local x, y, z = entity:GetPositionXYZ(false);
    -- local view_x, view_y, view_z = fight_camera:world_to_screen_point(x, y, z);
    -- return view_x, view_y;
    return x, z;
end

function FightMonsterGuide:GetAngle(cap_x, cap_y, entity_x, entity_y)
    local ang = algorthm.GetAngle(cap_x, cap_y, entity_x, entity_y);
    local fight_camera = CameraManager.GetSceneCameraObj();
    local rx, ry, rz = fight_camera:get_local_rotation();
    if ry >= 0 then
        ang = (ry + ang) - 180;
    else
        ang = (ry + ang) + 180;
    end
    return ang;
end



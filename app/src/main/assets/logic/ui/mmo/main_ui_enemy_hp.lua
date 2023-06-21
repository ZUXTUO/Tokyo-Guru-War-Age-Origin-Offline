
MainUIEnemyHp = Class('MainUIEnemyHp', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/panel_haemal_strand.assetbundle"

----------------------------------------------------外部接口----------------------------------
function MainUIEnemyHp.GetResList()
    return {res}
end

function MainUIEnemyHp:SetShowEntityName(entityName)
    local oldEntityName = self.showEntityName;
    self.showEntityName = entityName;
    if oldEntityName ~= entityName then
        self:UpdateUi();
    end
    self:Show();
end


----------------------------------------------------内部接口----------------------------------

function MainUIEnemyHp:Init(data)
    self.pathRes = res;
	UiBaseClass.Init(self, data);
end

function MainUIEnemyHp:Restart(data)
    UiBaseClass.Restart(self, data);
    self:ResetData();
end

function MainUIEnemyHp:ResetData()
    
end

function MainUIEnemyHp:RegistFunc()
    UiBaseClass.RegistFunc(self);
    --self.bindfunc['OnClickOpenAndClose'] = Utility.bind_callback(self, self.OnClickOpenAndClose);

end

function MainUIEnemyHp:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);

    self.proHp = ngui.find_progress_bar(self.ui, "sp_monster_di");
    self.spBoss = ngui.find_sprite(self.ui, "sp_boss");
    self.labName = ngui.find_label(self.ui, "lab_name");
    --self.labName2 = ngui.find_label(self.ui, "lab_name2");
    self.labLevel = ngui.find_label(self.ui, "lab_level");
    --self.labLevel:set_active(false);

    local sp = ngui.find_texture(self.ui, 'buff1')
    sp:set_active(false)
    sp = ngui.find_texture(self.ui, 'buff2')
    sp:set_active(false)


    self:Hide(false);
end

function MainUIEnemyHp:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.showEntityName = nil;
end

function MainUIEnemyHp:UpdateUi()
    if not UiBaseClass.UpdateUi(self) or not self.showEntityName then
        return;
    end
    local entity = ObjectManager.GetObjectByName(self.showEntityName);
    if not entity then
        return;
    end
    local max_hp = entity:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
    local cur_hp = entity:GetPropertyVal(ENUM.EHeroAttribute.cur_hp);
    self.proHp:set_value(cur_hp / max_hp);
    local labName = self.labName;
    if entity:IsBoss() then
--        labName = self.labName;
--        self.labName:set_active(true);
--        if self.labName2 then
--            self.labName2:set_active(false);
--        end
        self.spBoss:set_active(true);
    else
--        labName = self.labName2;
--        self.labName:set_active(false);
--        if self.labName2 then
--            self.labName2:set_active(true);
--        end
        self.spBoss:set_active(false);
    end
    if labName then
        if entity.owner_player_name then
            if entity:IsCaptain() then
                labName:set_text(entity.owner_player_name);
            else
                labName:set_text("【"..entity.owner_player_name.."】".."的伙伴");
            end
        else
            labName:set_text(tostring(entity.config.name));
        end
    end
    if self.showLevel ~= entity.level then
        self.labLevel:set_text('Lv.'.. tostring(entity.level))
    end
end

--帧更新
function MainUIEnemyHp:Update(dt)
    if not UiBaseClass.Update(self, dt) then
        return;
    end
    local entity = ObjectManager.GetObjectByName(self.showEntityName);
    if not entity or entity:IsDead() then
        self:Hide();
        return;
    end
    local max_hp = entity:GetPropertyVal(ENUM.EHeroAttribute.max_hp);
    local cur_hp = entity:GetPropertyVal(ENUM.EHeroAttribute.cur_hp);
    self.proHp:set_value(cur_hp / max_hp);
end

-- function MainUIEnemyHp:Hide() 
--     app.log("......."..debug.traceback());
--     UiBaseClass.Hide(self);
-- end
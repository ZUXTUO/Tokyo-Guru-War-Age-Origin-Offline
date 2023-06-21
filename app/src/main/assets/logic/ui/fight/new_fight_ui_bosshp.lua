NewFightUiBosshp = Class('NewFightUiBosshp', UiBaseClass);
-------------------------------------------------外部接口--------------------------------
--初始化
--data=
--{
--  parent=nil      父节点
--  tType=1         类型 1为雕像血条 2为boss血条
--  name=""         对象的名字
--  once=false      只可以控制一次显示隐藏
--}
function NewFightUiBosshp:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/fight/new_fight_ui_bosshp.assetbundle";
    UiBaseClass.Init(self, data);
end
-- 显示boss血条
function NewFightUiBosshp:ShowBlood(isShow)
    if  not self.ui then
        return;
    end
    --如果被强制不显示  调用不起效果
    if self.isHideBlood then
        return;
    end
    if self.data.once and self.isOnce then
        return;
    end
    --死了就不显示了
    local role = ObjectManager.GetObjectByName(self.data.name);
    if role and role:IsDead() then
        return;
    end
    local tType = self.data.tType;
    local centerControl = self.control;
    for i = 1, 2 do
        if i == tType then
            centerControl["objRoot"..i]:set_active(isShow);
        else
            centerControl["objRoot"..i]:set_active(false);
        end     
    end
end
-- 强制隐藏显示 影响ShowBossBlood的调用
function NewFightUiBosshp:HideBossBlood(isHide)
    self.isHideBlood = isHide;
end

-- 设置显示对象
-- tType=1         类型 1为雕像血条 2为boss血条
-- name 对象名
function NewFightUiBosshp:SetShowObj(tType, name)
    if self.data.once and self.isOnce then
        return;
    end
    if name then
        self.isDead = false;
        local role = ObjectManager.GetObjectByName(name);
        if role then
            local centerControl = self.control;
            if centerControl then
                local cur_hp = PublicFunc.AttrInteger(role:GetPropertyVal(ENUM.EHeroAttribute.cur_hp));
                local max_hp = PublicFunc.AttrInteger(role:GetPropertyVal(ENUM.EHeroAttribute.max_hp));
                if tType == 1 then
                    centerControl.baoWeiZhan.labBossHp:set_text(tostring(cur_hp.."/"..max_hp));
                    centerControl.baoWeiZhan.labBossName:set_text(tostring(role.config.name));
                elseif tType == 2 then
                    centerControl.text_boss_name:set_text(tostring(role.config.name));
                    -- 暂时屏蔽
                    -- centerControl.text_boss_hp:set_text(tostring(cur_hp.."/"..max_hp));
                    centerControl.text_boss_hp:set_text("");
                    centerControl.lab_level:set_text('Lv.' .. tostring(role.level))
                end
            end
        end    
    end
    self.data.tType = tType;
    self.data.name = name;
end

-------------------------------------------------内部接口--------------------------------
--初始化数据
function NewFightUiBosshp:InitData(data)
    UiBaseClass.InitData(self, data);
    self.data = data;
    self.isHideBlood = nil;
    self.isDead = nil;
    self.showLock = false;
    self.isOnce = false;
	self.isShowLevel = true;
    self.indexList = nil 
    self.backProgressBarStep = 0.01
end

--注册回调函数
function NewFightUiBosshp:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--初始化UI
function NewFightUiBosshp:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    -- if self.data.parent then
    --     self.ui:set_parent(self.data.parent);
    --     --设置了父节点后需要马上将这个父节点去掉引用  不然会引起其他地方释放不到资源
    --     self.data.parent = nil;
    -- else
    --     self.ui:set_parent(Root.get_root_ui_2d_fight());
    -- end
    -- self.ui:set_local_scale(1,1,1);
    -- self.ui:set_local_position(0,0,0); 
    --ui初始化
    self.control = {}
    local centerControl = self.control;
    --雕像血条
    centerControl.objRoot1 = self.ui:get_child_by_name("pro_di");
    centerControl.objRoot1:set_active(false)
    centerControl.baoWeiZhan = {};
    centerControl.baoWeiZhan.proBossHp = ngui.find_progress_bar(centerControl.objRoot1, centerControl.objRoot1:get_name());
    centerControl.baoWeiZhan.labBossHp = ngui.find_label(centerControl.objRoot1,"lab_num");
    centerControl.baoWeiZhan.labBossName = ngui.find_label(centerControl.objRoot1, "txt_name");
    --boss血条
    centerControl.objRoot2 = self.ui:get_child_by_name("ui_frame");
    centerControl.objRoot2:set_active(false)
    centerControl.pro_boss_blood = ngui.find_progress_bar(centerControl.objRoot2, "sp_back");
    centerControl.sp_boss_blood = ngui.find_sprite(centerControl.objRoot2, "sp_xuetiao");
    centerControl.text_boss_name = ngui.find_label(centerControl.objRoot2, "lab_name");
    centerControl.text_boss_hp = ngui.find_label(centerControl.objRoot2, "lab_num");
    centerControl.text_boss_hp:set_font_size(17);
    centerControl.pro_boss_blood_bk = ngui.find_progress_bar(centerControl.objRoot2, "sp_back1");
    centerControl.sp_boss_blood_bk = ngui.find_sprite(centerControl.objRoot2, "sp_xuetiao1");
    centerControl.pro_boss_bk = ngui.find_progress_bar(centerControl.objRoot2, "sp_back2");
    centerControl.sp_boss_bk = ngui.find_sprite(centerControl.objRoot2, "sp_xuetiao2");
    centerControl.lab_boss = ngui.find_label(centerControl.objRoot2, "lab_freme");
    centerControl.lab_level = ngui.find_label(centerControl.objRoot2, "lab_level");

    self:SetShowObj(self.data.tType, self.data.name);
    self:ShowBlood(true);

    -- 关卡boss血条不显示等级
    if FightScene.GetPlayMethodType() == nil and self.data.tType == 2 then
        self.isShowLevel = false
    end

	self:SetLevelActive(self.isShowLevel)
    self.isOnce = true;
    --完了后更新一次
    self:Update();
end

function NewFightUiBosshp:SetLevelActive(value)
	self.isShowLevel = value
	if  self.control and self.control.lab_level then
		self.control.lab_level:set_active(self.isShowLevel)
	end	
end
--析构函数
function NewFightUiBosshp:DestroyUi()
    UiBaseClass.DestroyUi(self);
    if type(self.control) == "table" then
        for k, v in pairs(self.control) do
            self.control[k] = nil;
        end
    end
    self.data = nil;
end

function NewFightUiBosshp:Update(dt)
    if UiBaseClass.Update(self, dt) then
        if self.data.tType == 1 then
            self:UpdateBaoWeiZhanBossHp(dt);
        elseif self.data.tType == 2 then
            self:UpdateBossBlood(dt);
        end
    end
end

function NewFightUiBosshp:PlayBossDeadEffect(frameCount, callback)
    if not self.ui then return end
    self.isPlayBossDeadEffect = true

    local centerControl = self.control
    centerControl.objRoot2:set_active(true);

    local cur_value = centerControl.pro_boss_blood_bk:get_value();

    self.backProgressBarStep = cur_value / frameCount --45

    --app.log("#hyg#PlayBossDeadEffect " .. tostring(self.backProgressBarStep))

    self._playBossDeadEffectEndCallback = callback
end

function NewFightUiBosshp:BossDeadEffectEnd()
    if self.isPlayBossDeadEffect ~= true then return end

    --app.log("#hyg#BossDeadEffectEnd")
    self.isPlayBossDeadEffect = nil
    self.control.objRoot2:set_active(false);
    if self._playBossDeadEffectEndCallback then
        self._playBossDeadEffectEndCallback(self)
        self._playBossDeadEffectEndCallback = nil
    end
end

-----------------------------------BOSS血条----------------------------
-- 血条渐近更新
function NewFightUiBosshp:UpdateBossBlood(dt)
    if not self.ui then
        return;
    end
    if self.data.name and (not self.isDead or self.isPlayBossDeadEffect) then
        local centerControl = self.control;
        local entity = ObjectManager.GetObjectByName(self.data.name);
        if entity then
            local max_blood = PublicFunc.AttrInteger(entity:GetPropertyVal('max_hp'));
            local cur_blood = PublicFunc.AttrInteger(entity:GetPropertyVal('cur_hp'));
            --几管血
            local maxCount = self:GetMaxBloodCount(max_blood)
            local one_blood = max_blood / maxCount

            local cont, value = math.modf((cur_blood - 0.01) / one_blood);
            local cur_value = centerControl.pro_boss_blood_bk:get_value();
            --app.log(tostring(max_blood).."  "..tostring(cur_blood).."  "..tostring(one_blood).."  "..tostring(cont).."  "..tostring(value).."  "..tostring(cur_value))
            centerControl.lab_boss:set_text("x" .. cont + 1)
            value = tonumber(string.format("%.3f",value));

            --绿黄橙 - 绿黄橙 ... - 红
            local index, nextIndex = self:GetIndexByBloodCount(cont + 1, maxCount)            
            centerControl.sp_boss_blood:set_sprite_name("zjm_xuetiao_xg_" .. index)
            centerControl.sp_boss_blood_bk:set_sprite_name("zjm_xuetiao_xg_" .. index)
            if nextIndex == nil then
                centerControl.pro_boss_bk:set_value(0)
            else
                centerControl.pro_boss_bk:set_value(1)
                centerControl.sp_boss_bk:set_sprite_name("zjm_xuetiao_xg_" .. nextIndex)
            end

            centerControl.pro_boss_blood:set_value(value);
            --暂时屏蔽
            -- centerControl.text_boss_hp:set_text(""..cur_blood.."/"..max_blood)
            centerControl.text_boss_hp:set_text("");
            self.curBloodNum = self.curBloodNum or cont;
            if value == cur_value then
                centerControl.pro_boss_blood_bk:set_value(value);
            elseif value - cur_value > 0.01 then
                if self.curBloodNum > cont then
                    centerControl.pro_boss_blood_bk:set_value(1);
                else
                    centerControl.pro_boss_blood_bk:set_value(value);
                end
            else
                if cur_value - self.backProgressBarStep < value or self.curBloodNum < cont then
                    centerControl.pro_boss_blood_bk:set_value(value);
                else
                    centerControl.pro_boss_blood_bk:set_value(cur_value - self.backProgressBarStep);
                end
            end
            -- 记录当前是第几管血
            self.curBloodNum = cont;
            --死了boss血条消失
            if cur_blood <= 0 then
                if not self.isPlayBossDeadEffect then
                    centerControl.objRoot2:set_active(false);
                end
                self.isDead = true;
            end
            if cur_value <= 0.005 then
                self:BossDeadEffectEnd()
            end
        else
            centerControl.objRoot2:set_active(false);
        end
    end
end
------------------------雕像血条-------------------------------
function NewFightUiBosshp:UpdateBaoWeiZhanBossHp(dt)
    if not self.ui then
        return;
    end
    --app.log("name="..tostring(self.data.name));
    if self.data.name then
        local centerControl = self.control;
        local entity = ObjectManager.GetObjectByName(self.data.name);
        local cur_hp = 0;
        local max_hp = 1;
        if entity then
            max_hp = PublicFunc.AttrInteger(entity:GetPropertyVal(ENUM.EHeroAttribute.max_hp));
            cur_hp = PublicFunc.AttrInteger(entity:GetPropertyVal(ENUM.EHeroAttribute.cur_hp));
        end
        centerControl.baoWeiZhan.proBossHp:set_value(cur_hp/max_hp);
        centerControl.baoWeiZhan.labBossHp:set_text(tostring(cur_hp.."/"..max_hp));
    end
end

--[[由最大血量来确定几管血]]
function NewFightUiBosshp:GetMaxBloodCount(maxHp)
    local config = ConfigManager._GetConfigTable(EConfigIndex.t_boss_hp_show)
    for _, v in ipairs(config) do
        if maxHp >= v.hp_start and maxHp <= v.hp_end then
            return v.hp_show_count 
        elseif maxHp >= v.hp_start and v.hp_end == 0 then
            return v.hp_show_count 
        end
    end
    app.log('t_boss_hp_show  ===> config error!')
end

--[[血条颜色循环]]
function NewFightUiBosshp:GetIndexByBloodCount(cont, maxCount)
    if cont > 1 then
        if self.indexList == nil then
            --绿黄橙
            self.indexList = {}
            for i = 1, 20 do 
                table.insert(self.indexList, 5)
                table.insert(self.indexList, 4)
                table.insert(self.indexList, 3)
            end
        end
        local index = self.indexList[maxCount - cont + 1]   -- (1 --> maxCount)
        local nextIndex = nil
        if index == 3 then
            nextIndex = 5
        else
            nextIndex = index - 1 
        end
        --下一个显示红色
        if cont == 2 then
            nextIndex = 2
        end
        return index, nextIndex
    --红
    elseif cont == 1 then
        return 2, nil
    end    
end
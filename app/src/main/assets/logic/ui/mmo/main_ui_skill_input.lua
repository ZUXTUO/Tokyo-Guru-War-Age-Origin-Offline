
MainUISkillInput = Class('MainUISkillInput', UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/right_down_other.assetbundle"

function MainUISkillInput.GetResList()
    return {res};
end

function MainUISkillInput:Init(data)
    self.pathRes = res
	UiBaseClass.Init(self, data);
end

function MainUISkillInput:Restart(data)
    self:ResetData()
    UiBaseClass.Restart(self, data)
end

function MainUISkillInput:DestroyUi()
    
    if self.ui == nil then
        return
    end
    local info = nil;
    for i = 1, 4 do
        info = self.ui_control["click_btn" .. i];
        if info then
            delete(info);
            self.ui_control["click_btn" .. i] = nil;
        end
    end

    self:DestroyTexture()

    self.sp_skill_point = nil;
    self.sp_skill_di = nil;
    self.sp_skill_cancel = nil;
    self.btnChange = nil;
    
    UiBaseClass.DestroyUi(self)
end

function MainUISkillInput:DestroyTexture()
    local normalAtk = self.ui_control["normalAttackSkill"]
    if normalAtk then
        if normalAtk.Destroy then
            normalAtk:Destroy();
        end
        self.ui_control["normalAttackSkill"] = nil;
    end

    local icon_name = "";
    for i = 0, 3 do
        icon_name = "skillShield"..i
        local shield_icon = self.ui_control[icon_name]
        if shield_icon then
            if shield_icon.Destroy then
                shield_icon:Destroy()
            end
            self.ui_control[icon_name] = nil;
        end

        icon_name = "skill_icon_"..i
        local skill_icon = self.ui_control[icon_name]
        if skill_icon then
            if skill_icon.Destroy then
                skill_icon:Destroy();
            end
            self.ui_control[icon_name] = nil;
        end
    end

end

function MainUISkillInput:ResetData()
    self.index_guangquan = 0
    self.index_btn_change_guangquan = 0
    self.skill_cd = { }
    self.indexGrayCount = {}

    self.last_skill_x = 0
    self.last_skill_y = 0
    self.last_skill_angle = 0
    self.RockerMoveDis = 0
    self.isCancelSkill = false;
    self.cancelSkillBeginTime = 0
    self.isHoldInCancelSkill = false
    self.skillApertureStep = 0;
    self.selectList = {};
end

function MainUISkillInput:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)

    self.ui:set_name("main_ui_skill_input")

    -- if self.ui:get_active_inhierarchy() == false then
    --     return        
    -- end

    self.sp_btn1_guangquan = {}
    self.tweencolor_btn1 = {}
    self.tweenscale_btn1 = {}

    self.sp_btn_change_guangquan = {}
    self.tweencolor_btn_change = {}
    self.tweenscale_btn_change = {}
	for i=1,3 do
		self.sp_btn1_guangquan[i] = ngui.find_sprite(self.ui, "btn_sp1/sp_guangquan"..i);
		self.sp_btn1_guangquan[i]:set_active(false);
		self.tweencolor_btn1[i] = ngui.find_tween_color(self.ui,"btn_sp1/sp_guangquan"..i);
		self.tweenscale_btn1[i] = ngui.find_tween_scale(self.ui,"btn_sp1/sp_guangquan"..i);

        -- self.sp_btn_change_guangquan[i] = ngui.find_sprite(self.ui, "btn_change/sp_guangquan"..i);
        -- self.sp_btn_change_guangquan[i]:set_active(false);
        -- self.tweencolor_btn_change[i] = ngui.find_tween_color(self.ui,"btn_change/sp_guangquan"..i);
        -- self.tweenscale_btn_change[i] = ngui.find_tween_scale(self.ui,"btn_change/sp_guangquan"..i);
	end
    local btn1 = ngui.find_button(self.ui, "btn_sp1")
    btn1:set_on_ngui_press(self.bindfunc['NormalAttack'])

    self.ui_control = {}
    for i = 1, 4 do
        if i+1 > 2 then
            self.ui_control["lab_overlap"..i] = ngui.find_label(self.ui, "btn_sp"..(i+1).."/lab")
            self.ui_control["sp_overlap_pointer1" .. i] = ngui.find_sprite(self.ui, "btn_sp"..(i+1).."/content/sp1");
            self.ui_control["sp_overlap_pointer1" .. i]:set_active(false);
            self.ui_control["sp_overlap_pointer2_spr" .. i] = ngui.find_sprite(self.ui, "btn_sp"..(i+1).."/content/animation/sp2");
            self.ui_control["sp_overlap_pointer2_spr" .. i]:set_active(false);
            self.ui_control["sp_overlap_pointer2" .. i] = self.ui:get_child_by_name("btn_sp"..(i+1).."/content/animation");
            self.ui_control["sp_overlap_pointer2" .. i]:set_active(false);
            self.ui_control["show_overlap_pointer" .. i] = false
        end
        self.ui_control["pro_btn"..i] = ngui.find_progress_bar(self.ui, "btn_sp" ..(i + 1));
        self.ui_control["btn" .. i] = ngui.find_button(self.ui, "btn_sp" ..(i + 1));
        -- if i == 1 then
            -- self.ui_control["click_btn" .. i] = ButtonClick:new({obj = self.ui_control["btn" .. i], weakFocus=true, audioEnum = 0});
        -- else
            self.ui_control["click_btn" .. i] = ButtonClick:new({obj = self.ui_control["btn" .. i], weakFocus=true, audioEnum = 0});
            self.ui_control["click_btn" .. i]:SetPressDrag(self.DragSkill, i, self);
        -- end
        self.ui_control["click_btn" .. i]:SetPress(self.UseSkill, i, self);
        self.ui_control["sp_mark" .. i] = ngui.find_sprite(self.ui, "btn_sp" ..(i + 1) .. "/sp_zhezhao" ..(i + 1));
        self.ui_control["sp_mark" .. i]:set_active(false);
        self.ui_control["lab" .. i] = ngui.find_label(self.ui, "btn_sp" ..(i + 1) .. "/lab" ..(i + 1));
        self.ui_control["lab" .. i]:set_text("");
        local cdfx = ngui.find_sprite_animation(self.ui, "btn_sp" ..(i + 1).."/fx/sp_fx_skill")
        self.ui_control["cd_fx"..i] = cdfx
        if cdfx then
            cdfx:set_active(false);
        end
        local clickfx = self.ui:get_child_by_name("btn_sp" ..(i + 1).."/fx/fx_button_skill_end");
        self.ui_control["click_fx"..i] = clickfx
        if clickfx then
            clickfx:set_active(false);
        end
        --PublicFunc.SetNodeActive("btn_sp" ..(i + 1).."/fx", false)
        PublicFunc.SetNodeActive(self.ui, "btn_sp" ..(i + 1).."/animation2", false)
        PublicFunc.SetNodeActive(self.ui, "btn_sp" ..(i + 1).."/animation3", false)

        self.ui_control["sp_light"..i] = ngui.find_sprite(self.ui, "btn_sp" ..(i + 1).."/sp_light");
        if self.ui_control["sp_light"..i] then
            self.ui_control["sp_light"..i]:set_active(false);
        end
    end

    self.ui_control["normalAttackSkill"] = ngui.find_texture(self.ui, "btn_sp1/sp_xx");
    self.ui_control["normalAttackSkill"]:set_texture("assetbundles/prefabs/ui/image/icon/zhan_dou/90_90/jinzhi.assetbundle");
    self.ui_control["normalAttackSkillIcon"] = ngui.find_sprite(self.ui, "btn_sp1/sp1")
    self.ui_control["skill_icon_0"] = ngui.find_texture(self.ui, "btn_sp2/animation/sp2");

    self.ui_control["skillShield0"] = ngui.find_button(self.ui, "btn_sp2");--/sp_xx");
    -- self.ui_control["skillShield0"]:set_texture("assetbundles/prefabs/ui/image/icon/skill/90_90/jinzhi.assetbundle");
    -- self.ui_control["skillShield0"]:set_active(false);
    --技能
    for i = 1, 3 do
        self.ui_control["skill_icon_"..i] = ngui.find_texture(self.ui, "btn_sp"..(i+2).."/animation/sp"..(i+2));
        self.ui_control["skillShield"..i] = ngui.find_texture(self.ui, "btn_sp"..(i+2).."/sp_xx");
        self.ui_control["skillShield"..i]:set_texture("assetbundles/prefabs/ui/image/icon/zhan_dou/90_90/jinzhi.assetbundle");
        self.ui_control["skillShield"..i]:set_active(false);
        self.ui_control["spLock"..i] = ngui.find_sprite(self.ui, "btn_sp" ..(i+2).."/sp_lock");
        if self.ui_control["spLock"..i] then
            self.ui_control["spLock"..i]:set_active(false);
        end
    end
    --战斗中
    self.ui_control["spFighting"] = ngui.find_sprite(self.ui, "btn_sp2/sp_fighting");
    self.ui_control["spFighting"]:set_active(false);

    self.sp_skill_point = ngui.find_sprite(self.ui, "sp_button")
	self.sp_skill_point:set_active(false)
    self.sp_skill_di = ngui.find_sprite(self.ui, "sp_yaogan")
	self.sp_skill_di:set_active(false)
    self.sp_skill_cancel = ngui.find_sprite(self.ui,"sp_skill_cancel")
    self.sp_skill_cancel:set_active(false)
    self.max_skill_di_dis = 70


    self:HurdleSkillShield()

    local myCaptain = FightManager.GetMyCaptain()
    if myCaptain then
        self:ReFillCD(myCaptain)
        self:ReFillRationEffect(myCaptain)
        self:UpdateSkillOverlap(myCaptain)
    end
    self:UpdateSkillIcon(myCaptain)

    -- self.btnChange = ngui.find_button(self.ui, 'btn_change');
    -- self.btnChange:set_on_click(self.bindfunc["ChangeTarget"]);

    if self._initData == nil then
        app.log('-=============== ' .. debug.traceback())
    end

    -- 全部关闭
    --if self._initData.openSwitch then
    --    self.btnChange:set_active(true);
    --else
        -- self.btnChange:set_active(false);
    --end
end

function MainUISkillInput:RegistFunc()
    UiBaseClass.RegistFunc(self)

    self.bindfunc['NormalAttack'] = Utility.bind_callback(self, self.NormalAttack)
    self.bindfunc['ClickTrusteeship'] = Utility.bind_callback(self, self.ClickTrusteeship)
    self.bindfunc['ChangeTarget'] = Utility.bind_callback(self, self.ChangeTarget)
end

function MainUISkillInput:ClickTrusteeship(t)
    if t then
        g_dataCenter.autoPathFinding:StopPathFind();
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.MainBtn);

    ObjectManager.ChangeCaptainFightMode(t)
end

function MainUISkillInput:ChangeTarget(t)

    if self.index_btn_change_guangquan == 3 then
            self.index_btn_change_guangquan = 1;
    else
        self.index_btn_change_guangquan = self.index_btn_change_guangquan + 1;
    end
    self.sp_btn_change_guangquan[self.index_btn_change_guangquan]:set_active(true);
    self.tweencolor_btn_change[self.index_btn_change_guangquan]:reset_to_begining();
    self.tweenscale_btn_change[self.index_btn_change_guangquan]:reset_to_begining();
    self.tweencolor_btn_change[self.index_btn_change_guangquan]:play_foward();
    self.tweenscale_btn_change[self.index_btn_change_guangquan]:play_foward();
    self:SortAllObj();
    local findOk = true;
    for i = 1, #self.allObjName do
        local curName = self.allObjName[i];
        if self.selectList[curName] ~= 1 then
            findOk = false;
            break;
        end
    end
    if findOk then
        self.selectList = {};
    end
    --app.log("findOk="..tostring(findOk).."..."..table.tostring(self.allObjName).."   select="..table.tostring(self.selectList))
    for i = 1, #self.allObjName do
        local curName = self.allObjName[i];
        if not self.selectList[curName] then
            local curObj = ObjectManager.GetObjectByName(curName);
            local captain = g_dataCenter.fight_info:GetCaptain()
            if captain and curObj then
                app.log(curName.."......"..tostring(curObj.config.name))
                captain:SetAttackTarget(curObj, true);
                if captain:GetName() == FightManager.GetMyCaptainName() then
                    FightScene.SetCurtRimLightObj(curObj)
                end
                self.selectList[curName] = 1;
            end
            break;
        end
    end
end

function MainUISkillInput:ClearSelectList()
    self.selectList = {};
end

function MainUISkillInput:SortAllObj()
    self.allObjName = {};
    local info = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_changeTargetRadius);
    if not info then
        return;
    end
    local captain = g_dataCenter.fight_info:GetCaptain();
    if not captain then
        return;
    end
    local obj_list = captain:SearchAllEnemyOnAround(info.data);
    if not obj_list then
        return
    end
    for k, v in pairs(obj_list) do
        table.insert(self.allObjName, v:GetName());
    end
    --BOSS，精英，敌方玩家队长，敌方玩家队员，小怪。
    local sortFunc = function(a, b)
        local aObj = ObjectManager.GetObjectByName(a);
        local bObj = ObjectManager.GetObjectByName(b);
        --相同的boss必须返回false
        if (aObj:IsBoss() and bObj:IsBoss()) or bObj:IsBoss() then
            return false;
        elseif aObj:IsBoss() then
            return true;
        end
        --相同的精英必须返回false
        if (aObj:IsSuper() and bObj:IsSuper()) or bObj:IsSuper() then
            return false;
        elseif aObj:IsSuper() then
            return true;
        end
        --相同的队长必须返回false
        if (aObj:IsCaptain() and bObj:IsCaptain()) or bObj:IsCaptain() then
            return false;
        elseif aObj:IsCaptain() then
            return true;
        end
        --相同的队员必须返回false
        if (aObj:IsHero() and bObj:IsHero()) or bObj:IsHero() then
            return false;
        elseif aObj:IsHero() then
            return true;
        end
        --所有小怪全部返回false
        return false;
    end
    table.sort(self.allObjName, sortFunc);
end
function MainUISkillInput:ClearSkillRefInfo()
    if self.use_skill_ref_info then
        if self.use_skill_ref_info.type == 1 then
            self:UseSkill(self.use_skill_ref_info.x, self.use_skill_ref_info.y, false, self.use_skill_ref_info.param, self.use_skill_ref_info.obj_gid)
        elseif self.use_skill_ref_info.type == 2 then
            self:NormalAttack(self.use_skill_ref_info.name, false, self.use_skill_ref_info.x, self.use_skill_ref_info.y, self.use_skill_ref_info.gameObj, self.use_skill_ref_info.obj_gid)
        end
    end
end

function MainUISkillInput:NormalAttack(name, state, x, y, gameObj, touch_id, obj_gid)
    local obj = nil;
    if obj_gid then
        obj = ObjectManager.GetObjectByGID(obj_gid)
    else
        obj = FightManager.GetMyCaptain();
    end
    self.use_skill_ref = self.use_skill_ref or 0
    if state then
        if self.use_skill_ref ~= 0 then
            if self.use_skill_ref_info.type == 1 then
                self:UseSkill(self.use_skill_ref_info.x, self.use_skill_ref_info.y, false, self.use_skill_ref_info.param)
            elseif self.use_skill_ref_info.type == 2 then
                self:NormalAttack(self.use_skill_ref_info.name, false, self.use_skill_ref_info.x, self.use_skill_ref_info.y, self.use_skill_ref_info.gameObj)
            end
            self.use_skill_ref = 0;
        end
        self.use_skill_ref = self.use_skill_ref + 1
        self.use_skill_ref_info = self.use_skill_ref_info or {}
        self.use_skill_ref_info.type = 2;
        self.use_skill_ref_info.x = x;
        self.use_skill_ref_info.y = y;
        self.use_skill_ref_info.name = name
        self.use_skill_ref_info.gameObj = gameObj;
        if obj then
            self.use_skill_ref_info.obj_gid = obj:GetGID()
        else
            self.use_skill_ref_info.obj_gid = nil
        end
    else
        if self.use_skill_ref_info.type ~= 2 then
            return;
        end
        self.use_skill_ref = self.use_skill_ref - 1
        if self.use_skill_ref < 0 then
            self.use_skill_ref = 0;
        end
        self.use_skill_ref_info.type = 0
    end
    --如果是非手动则不允许使用
    if g_dataCenter.player:CaptionIsAutoFight() then
        return
    end
    --关卡强制不能使用普攻技能
    if not FightScene.GetHudleSkillEnable(1) then
        return;
    end
	if(not obj)then
		return
	end
    if state == true then
        local skill = obj:GetSkill(1)
        local skillDistance = skill:GetDistance()
        obj.last_skill_aperture = -1
        --[[obj.tipApertureEffect = 0
        obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[0], true, obj:GetBindObj(3), 0, 0, 0, skillDistance, skillDistance, obj, nil, nil);
        ]]
        local bCancel, cancel_skill = obj:CancelSkillAllCan(-1)
        local bUseNewSkill = false
        if not bCancel then
            bUseNewSkill = true
        end
        if bUseNewSkill --[[and not obj._skillAfterNormalSkill]] then
            obj.stopAttack = false;
            obj:KeepNormalAttack(true);
            obj.real_use_normal_attack = true;
            --[[if obj.currSkillEx and (obj.currSkillEx:IsComboSkill() == true) and (obj.lastSkillComplete == false) then
                if obj.after_comb_event then
                    obj.after_comb_event = false
                    obj:UseComboSkill()
                    obj.can_combo = false
                elseif obj.can_combo then
                    obj.bComboEx = true
                    obj.can_combo = false
                end
            end]]
            if obj.can_combo and obj.currSkillEx and (obj.lastSkillComplete == false) and (obj.currSkillEx:IsComboSkill() == true) then
                if obj.after_comb_event then
                    obj.after_comb_event = false
                    obj:UseComboSkill()
                    obj.can_combo = false
                else
                    obj.bComboEx = true
                    obj.can_combo = false
                end
            else
                if obj:GetExternalArea("canSkillChange") == true then
                    local change_by_normal1 = obj:GetExternalArea("canSkillChangeByNormal1")
                    local change_by_normal2 = obj:GetExternalArea("canSkillChangeByNormal2")
                    local change_by_normal3 = obj:GetExternalArea("canSkillChangeByNormal3")
                    local change_by_normal4 = obj:GetExternalArea("canSkillChangeByNormal4")
                    local change_by_normal5 = obj:GetExternalArea("canSkillChangeByNormal5")
                    if (not change_by_normal1 and not change_by_normal2 and not change_by_normal3 and
                        not change_by_normal4 and not change_by_normal5 ) then
                        obj:SetExternalArea("skillChange", true)
                        obj:GetAniCtrler().lock = false
                    end
                else
                    if not obj.last_used_skill then
                        obj._skillAfterCanChange = true
                    else
                        local skill = obj:GetSkillBySkillID(obj.last_used_skill)
                        if (not skill) or (skill:GetSkillType() ~= eSkillType.Normal) then
                            obj._skillAfterCanChange = true
                        end
                    end
                end
            end
            local reset_skill = false
            if obj.currSkillEx then
                if (obj.currSkillEx:GetSkillType() ~= eSkillType.Normal) then
                    reset_skill = true
                end
            else
                reset_skill = true
            end
            if reset_skill then
                obj:SetCurSkillIndex(obj.normalAttackIndex);
            end
            local normal_skill = obj:GetSkill(obj.normalAttackIndex)
            if normal_skill and normal_skill:CheckCD() == eUseSkillRst.OK then
                obj.new_attack_state_check = true;
                obj:SetHandleState(EHandleState.Attack);
                -- 通知战斗管理器
                if FightScene.GetFightManager().OnNormalAttack then
                    FightScene.GetFightManager():OnNormalAttack()
                end
            end
        end

		if self.index_guangquan == 3 then
			self.index_guangquan = 1;
		else
			self.index_guangquan = self.index_guangquan + 1;
		end
		self.sp_btn1_guangquan[self.index_guangquan]:set_active(true);
		self.tweencolor_btn1[self.index_guangquan]:reset_to_begining();
		self.tweenscale_btn1[self.index_guangquan]:reset_to_begining();
		self.tweencolor_btn1[self.index_guangquan]:play_foward();
		self.tweenscale_btn1[self.index_guangquan]:play_foward();
    else
        obj.stopAttack = true;
        obj:KeepNormalAttack(false);
        obj.real_use_normal_attack = false;
        --[[if obj.tipApertureEffect == 0 then
            obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[obj.tipApertureEffect], false)
        end]]
        obj.last_skill_aperture = -1
        if obj.tipApertureEffect then
            self:ClearSkillAperture(obj)
            obj.tipApertureEffect = nil
        end
    end
end

function MainUISkillInput:CheckCancelSkill(x, y, state, param)
    local sp_x,sp_y,sp_z = PublicFunc.GetUiWorldPosition(self.sp_skill_cancel);
    local width = self.sp_skill_cancel:get_width();
    local height = self.sp_skill_cancel:get_height();
    local top = sp_y+height/2;
    local down = sp_y-height/2;
    local right = sp_x+width/2;
    local left = sp_x-width/2;
    local move_x = x - self.last_skill_x;
    local move_y = y - self.last_skill_y;
    local screen_width = app.get_screen_width();
    local screen_height = app.get_screen_height();
    local pX,pY,pZ = PublicFunc.GetUiWorldPosition(self.ui_control["btn" .. param]);
    --local pX,pY,pZ = FightUI.ui_control["btn" .. param]:get_position();
    pX = pX + move_x* 1280/screen_width;
    pY = pY + move_y* 720/screen_height;
    local obj = FightManager.GetMyCaptain();
    if obj and top >= pY and down <= pY and right >= pX and left <= pX then
        return true;
    else
        return false;
    end
end

function MainUISkillInput:UpdateCancelSkill(x, y, state, param)
    self.isCancelSkill = self:CheckCancelSkill(x, y, state, param)
end

function MainUISkillInput:UseSkill(x, y, state, param, obj_gid)
    --关卡强制不能使用
    if not FightScene.GetHudleSkillEnable(param + 1) then
        return;
    end
    
    local obj = nil;
    if obj_gid then
        obj = ObjectManager.GetObjectByGID(obj_gid)
    else
        obj = FightManager.GetMyCaptain();
    end
    self.use_skill_ref = self.use_skill_ref or 0
    if state then
        if self.use_skill_ref ~= 0 then
            if self.use_skill_ref_info.type == 1 then
                self:UseSkill(self.use_skill_ref_info.x, self.use_skill_ref_info.y, false, self.use_skill_ref_info.param)
            elseif self.use_skill_ref_info.type == 2 then
                self:NormalAttack(self.use_skill_ref_info.name, false, self.use_skill_ref_info.x, self.use_skill_ref_info.y, self.use_skill_ref_info.gameObj)
            end
        end
        self.use_skill_ref = self.use_skill_ref + 1
        self.use_skill_ref_info = self.use_skill_ref_info or {}
        self.use_skill_ref_info.type = 1;
        self.use_skill_ref_info.x = x;
        self.use_skill_ref_info.y = y;
        self.use_skill_ref_info.param = param;
        if obj then
            self.use_skill_ref_info.obj_gid = obj:GetGID()
        else
            self.use_skill_ref_info.obj_gid = nil
        end
    else
        GetMainUI():SetRightMoveDis(0)
        if self.use_skill_ref_info.type ~= 1 or self.use_skill_ref_info.param ~= param then
            return
        end
        self.use_skill_ref = self.use_skill_ref - 1
        if self.use_skill_ref < 0 then
            self.use_skill_ref = 0;
        end
        self.use_skill_ref_info.type = 0
    end
    --技能tips
    self:ShowSkillTips(x, y, state, param);
    --检测技能使用条件
    if g_dataCenter.player:CaptionIsAutoFight() then
        self:AIUseSkill(x, y, state, param)
        return ;
    end

    self:UpdateCancelSkill(x, y, state, param);
 
    local  value = param;
    if value == 1 then
        value = PublicStruct.Const.SPECIAL_HURDLE_SKILL - PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+1;
    end
    if state == false then
        -- [[技能取消功能]]
        self.sp_skill_cancel:set_active(false);
        if self.isCancelSkill then
            --app.log("技能取消");
            self:CancelSkillEffect();
            self.isCancelSkill = false
            return;
        end
        -------------------------------------
        if obj then
            obj.bComboEx = false
            local pos = obj:GetPosition();
            local skill = nil
            if value == 1 then
                skill = obj:GetRecoverSkill()
            else
                skill = obj:GetSkill(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
            end
            local bUseNewSkill = true
            if value ~=  1 then
                local bCancel, cancel_skill = obj:CancelSkillAllCan(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
                if bCancel then
                    if cancel_skill == skill then
                        bUseNewSkill = false
                    end
                end
            else
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld --[[or FightScene.GetPlayMethodType() == nil]] then
                    for k, v in ipairs(g_dataCenter.fight_info.control_hero_list) do
                        local hero = ObjectManager.GetObjectByName(v)
                        if hero then
                            skill = hero:GetRecoverSkill()
                            --[[obj:SetCurSkillIndex(skill._arrIndex)
                            obj:PlaySkill()]]
                            SkillManager.UseSkill(hero, skill)
                        end
                    end
                else
                    --[[obj:SetCurSkillIndex(skill._arrIndex)
                    obj:PlaySkill()]]
                    if self:CheckUseSkill(param) then
                        SkillManager.UseSkill(obj, skill)
                    end
                end
                bUseNewSkill = false
            end
            if not bUseNewSkill or self:CheckUseSkill(param) then
                local use_skill_condition = ((obj.lastSkillComplete == true or obj:GetExternalArea("skillChange") == true) and obj:GetIsSkillUseByAIHFSM() ==  false)
                if bUseNewSkill then
                    if skill and skill:GetSkillType() == eSkillType.ImmediatelyNoStateSkill and not skill:IsWorking() and use_skill_condition then
                        local skill_index = obj.old_skill_index
                        obj:SetCurSkillIndex(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
                        obj:PlaySkill()
                        if skill_index and skill_index ~= -1 then
                            obj:SetCurSkillIndex(skill_index)
                        end
                    else
                        if not obj:IsBeControlOrOutOfControlState() and skill then
                            obj:SetCurSkillIndex(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1, self.last_skill_angle);
                            obj:KeepNormalAttack(false);
                            obj.stopAttack = true;
                            if bCancel then
                                obj.isFirstAttack = true
                            end
                            obj.new_attack_state_check = true;
                            local retState, retDestination, retTarget, retNeedChangeTarget = obj:CheckAttackState()
                            if  obj:GetExternalArea("canSkillChange") == true then
                                if retState == ESTATE.Attack or retState == ESTATE.Run then
                                    obj:SetExternalArea("skillChange", true)
                                    obj:GetAniCtrler().lock = false
                                end
                            else
                                obj._skillAfterCanChange = true
                            end
                            --[[if curSkill and curSkill:GetSkillType() == eSkillType.Normal and not obj.lastSkillComplete then
                                obj._skillAfterNormalSkill = true
                            end]]
                            if retState == ESTATE.Attack or retState == ESTATE.Run then
                                obj.new_attack_state_check = true;
                                obj:SetHandleState(EHandleState.Attack);
                            end
                        end
                    end
                end
                -- 通知战斗管理器
                if FightScene.GetFightManager().OnSkill then
                    FightScene.GetFightManager():OnSkill(param)
                end
            end
            
        end
    else
        if obj then
            obj.new_attack_state_check = true;
            local skill = obj:GetSkill(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
            local retState, retDestination, retTarget, retNeedChangeTarget = obj:CheckAttackState(true, skill)
            --[[if retTarget then
                app.log("retNeedChangeTarget="..tostring(retNeedChangeTarget).." retTarget="..tostring(retTarget.name))
            else
                app.log("retNeedChangeTarget="..tostring(retNeedChangeTarget).." retTarget="..tostring(retTarget))
            end]]
            if retNeedChangeTarget then
                obj:SetAttackTarget(retTarget, true)
            end
        end
    end
    --提示特效
    if obj then
        if state == true then
            if value > 1 then
                self.delay_show_apertrue = {}
                self.delay_show_apertrue.skill_value = value
                self.delay_show_apertrue.obj_gid = obj:GetGID()
                self.delay_show_apertrue.sklll_param = param
                self.delay_show_apertrue.begin_time = PublicFunc.QueryCurTime()
                self.delay_show_apertrue.x = x
                self.delay_show_apertrue.y = y
                self.last_skill_x = x
                self.last_skill_y = y
                self.begin_drag = false;
                self.last_skill_angle = 0
                self.skillApertureStep = 0
                obj.last_skill_aperture = -1
                obj.aperture_manager.lastMovePos = {}
                if obj then
                    local skill = obj:GetSkill(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
                    if skill ~= nil and (not skill:IsDisenable()) then
                        local skillApertureType = skill:GetApertureType()
                        local skillDistance = skill:GetDistance()
                        local skillExtraDistance = skill:GetExtraDistance()
                        if obj.aperture_manager then
                            if skillApertureType == 4 then
                                local position = obj:GetPosition(true)
                                obj.aperture_manager:SetOpenData(obj.aperture_manager.apertureType[5], position.x, position.y+0.01, position.z, skillDistance, 1)
                            elseif skillApertureType == 5 then
                                local position = obj:GetPosition(true)
                                local target = obj:GetAttackTarget()
                                local dir
                                if target then
                                    local targetPos = target:GetPosition(true)
                                    dir = {}
                                    dir.x = targetPos.x - position.x;
                                    dir.y = 0
                                    dir.z = targetPos.z - position.z;
                                    dir.x, dir.y, dir.z = util.v3_normalized(dir.x, dir.y, dir.z);
                                else
                                    dir = obj:GetForWard()
                                end
                                obj.aperture_manager:SetOpenData(obj.aperture_manager.apertureType[5], position.x, position.y+0.01, position.z, skillDistance-skillExtraDistance, 1, true, dir)
                            end
                        end
                    end
                end
            end
        else
            self.sp_skill_point:set_active(false)
            self.sp_skill_di:set_active(false)
            local obj = FightManager.GetMyCaptain()
            if self.delay_show_apertrue then
                self.delay_show_apertrue = nil
            end
            if obj and obj.tipApertureEffect then
                self:ClearSkillAperture(obj)
                self.skillApertureStep = 0
                obj.last_skill_aperture = -1
                obj.tipApertureEffect = nil
                self.tipButtonIndex = nil
                self.cancelSkillBeginTime = 0
                self.isHoldInCancelSkill = false
            end
        end
    end
    --朝向特效
    if param and param > 1 then
        if state == true then
            self.ui_control["click_fx" .. param]:set_active(false);
        else
            self.ui_control["click_fx" .. param]:set_active(true);
        end
    end
end

function MainUISkillInput:AIUseSkill(x, y, state, param)
    if state then
        local obj = FightManager.GetMyCaptain();
        if obj then
            if param == 1 then
                if FightScene.UseAddHpSkill then
                    AIC_UseAddHPSkill(obj);
                else
                    local captain = g_dataCenter.fight_info:GetCaptain()
                    if captain and captain:CanAndNeedUseSkill(PublicStruct.Const.SPECIAL_HURDLE_SKILL) then
                        FloatTip.Float("自动战斗中无法使用")
                    end
                end
            else
                obj:SetAINextSkillID(param+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
            end
        end
    end
end

function MainUISkillInput:ShowSkillTips(x, y, state, param)
    if state == true then
        -- if param then
        --     param = PublicStruct.Const.SPECIAL_HURDLE_SKILL - PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+1;
        -- end
        if param > 1 then
            local obj = FightManager.GetMyCaptain()
            if obj then
                local skill = obj:GetSkill(param+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
                if skill ~= nil then
                    last_skilltips_x = x;
                    last_skilltips_y = y;
                    --技能特效
                    local atk_power
                    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync and obj.mmo_card then
                        atk_power = obj.mmo_card:GetPropertyVal(ENUM.EHeroAttribute.atk_power);
                    else
                        atk_power = obj:GetPropertyVal(ENUM.EHeroAttribute.atk_power);
                    end

                    SkillTips.EnableSkillTips(true, skill._skillData.id, skill._skillLevel, atk_power, x, y, 500);
                end
            end
        end
    else
        SkillTips.EnableSkillTips(false);
    end
end

function MainUISkillInput:CheckUseSkill(index)
    local obj = FightManager.GetMyCaptain()
    if not obj then
        return false
    end
    --关卡强制不能使用
    if not FightScene.GetHudleSkillEnable(index + 1) then
        return false;
    end
    --英雄星级加锁
    if index ~= 1 then
        local skill = obj:GetSkillByUIIndex(index)
        if skill == nil then
            return false;
        end
        --[[if PublicFunc.SetSkillLock(obj.config, nil, index + 2) then
            return false;
        end]]
    else
        --战斗中不能使用加血
        if FightScene.GetFightManager() and not FightScene.GetFightManager().canRecoverInFight then
            if PublicStruct.Fight_Sync_Type ~= ENUM.EFightSyncType.StateSync --[[and FightScene.GetPlayMethodType() ~= nil]] then
                if g_dataCenter.fight_info:IsInFight() and FightScene.UseAddHpSkill then
                    return false;
                end
            end
        end
    end
    --技能cd
    if self:IsSkillCd(index) then
        return false;
    end
    return true;
end

function MainUISkillInput:IsSkillCd(index)
    if self.skill_cd[index] then
        return true;
    end
    return false;
end

function MainUISkillInput:ClearSkillAperture(obj)
    if obj and obj.aperture_manager then
        if obj.tipApertureEffect == 0 then
            local newType = nil
            if self.skillApertureStep == 1 then
                newType = obj.aperture_manager.apertureType[13]
            elseif self.skillApertureStep == 2 then
                newType = obj.aperture_manager.apertureType[14]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType = obj.aperture_manager.apertureType[0]
            end
            if newType then
                obj.aperture_manager:SetOpenNotMove(newType, false)
            end
        elseif obj.tipApertureEffect == 1 then
            local newType1 = nil
            local newType2 = nil
             if self.skillApertureStep == 1 then
                newType1 = obj.aperture_manager.apertureType[13]
                newType2 = obj.aperture_manager.apertureType[15]
            elseif self.skillApertureStep == 2 then
                newType1 = obj.aperture_manager.apertureType[14]
                newType2 = obj.aperture_manager.apertureType[16]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType1 = obj.aperture_manager.apertureType[0]
                newType2 = obj.aperture_manager.apertureType[1]
            end
            if newType1 and newType2 then
                obj.aperture_manager:SetOpenNotMove(newType1, false)
                obj.aperture_manager:SetOpenNotMove(newType2, false)
            end
        elseif obj.tipApertureEffect == 2 then
            local newType = nil
            if self.skillApertureStep == 1 then
                newType = obj.aperture_manager.apertureType[17]
            elseif self.skillApertureStep == 2 then
                newType = obj.aperture_manager.apertureType[18]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType = obj.aperture_manager.apertureType[2]
            end
            if newType then
                obj.aperture_manager:SetOpenNotMove(newType, false)
            end
        elseif obj.tipApertureEffect == 3 then
            local newType = nil
            if self.skillApertureStep == 1 then
                newType = obj.aperture_manager.apertureType[19]
            elseif self.skillApertureStep == 2 then
                newType = obj.aperture_manager.apertureType[20]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType = obj.aperture_manager.apertureType[3]
            end
            if newType then
                obj.aperture_manager:SetOpenNotMove(newType, false)
            end
        elseif obj.tipApertureEffect == 4 then
            local newType1 = nil
            local newType2 = nil
            if self.skillApertureStep == 1 then
                newType1 = obj.aperture_manager.apertureType[13]
                newType2 = obj.aperture_manager.apertureType[23]
            elseif self.skillApertureStep == 2 then
                newType1 = obj.aperture_manager.apertureType[14]
                newType2 = obj.aperture_manager.apertureType[24]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType1 = obj.aperture_manager.apertureType[0]
                newType2 = obj.aperture_manager.apertureType[5]
            end
            if newType1 and newType2 then
                obj.aperture_manager:SetOpenNotMove(newType1, false)
                obj.aperture_manager:Stop(newType2)
            end
        elseif obj.tipApertureEffect == 5 then
            local newType1 = nil
            local newType2 = nil
            local newType3 = nil
            if self.skillApertureStep == 1 then
                newType1 = obj.aperture_manager.apertureType[13]
                newType2 = obj.aperture_manager.apertureType[15]
                newType3 = obj.aperture_manager.apertureType[23]
            elseif self.skillApertureStep == 2 then
                newType1 = obj.aperture_manager.apertureType[14]
                newType2 = obj.aperture_manager.apertureType[16]
                newType3 = obj.aperture_manager.apertureType[24]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType1 = obj.aperture_manager.apertureType[0]
                newType2 = obj.aperture_manager.apertureType[1]
                newType3 = obj.aperture_manager.apertureType[5]
            end
            if newType1 and newType2 and newType3 then
                obj.aperture_manager:SetOpenNotMove(newType1, false)
                obj.aperture_manager:SetOpenNotMove(newType2, false)
                obj.aperture_manager:Stop(newType3)
            end
        elseif obj.tipApertureEffect == 6 then
            local newType = nil
            if self.skillApertureStep == 1 then
                newType = obj.aperture_manager.apertureType[17]
            elseif self.skillApertureStep == 2 then
                newType = obj.aperture_manager.apertureType[18]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType = obj.aperture_manager.apertureType[2]
            end
            if newType then
                obj.aperture_manager:SetOpenNotMove(newType, false)
            end
        elseif obj.tipApertureEffect == 7 then
            local newType = nil
            if self.skillApertureStep == 1 then
                newType = obj.aperture_manager.apertureType[26]
            elseif self.skillApertureStep == 2 then
                newType = obj.aperture_manager.apertureType[27]
            elseif self.skillApertureStep == 3 or self.skillApertureStep == 0 then
                newType = obj.aperture_manager.apertureType[25]
            end
            if newType then
                obj.aperture_manager:SetOpenNotMove(newType, false)
            end
        end
    end
    if self.skillApertureStep == 3 then
        self.skillApertureStep = 0
    end
end
--step 1:正常->白  2：白->红  3:红->正常
function MainUISkillInput:ChangeSkillAperture(obj, step)
    self.delay_show_apertrue = nil
    self:ClearSkillAperture(obj)
    self.skillApertureStep = step
    if not obj or not obj.aperture_manager then
        return
    end
    --app.log_warning("skillApertureStep="..self.skillApertureStep.." tipApertureEffect="..tostring(obj.tipApertureEffect))
    
    local skillApertureType = obj.tipApertureEffect
    if skillApertureType == 0 then
        local newType = nil
        if self.skillApertureStep == 1 then
            newType = obj.aperture_manager.apertureType[13]
        elseif self.skillApertureStep == 2 then
            newType = obj.aperture_manager.apertureType[14]
        elseif self.skillApertureStep == 3 then
            newType = obj.aperture_manager.apertureType[0]
        end
        if newType then
            obj.aperture_manager:SetOpenNotMove(newType, true, obj:GetBindObj(3), 0, 0, 0, self.skillDistance, self.skillDistance, obj, nil, true, nil);
        end
    elseif skillApertureType == 1 then
        local newType1 = nil
        local newType2 = nil
         if self.skillApertureStep == 1 then
            newType1 = obj.aperture_manager.apertureType[13]
            newType2 = obj.aperture_manager.apertureType[15]
        elseif self.skillApertureStep == 2 then
            newType1 = obj.aperture_manager.apertureType[14]
            newType2 = obj.aperture_manager.apertureType[16]
        elseif self.skillApertureStep == 3 then
            newType1 = obj.aperture_manager.apertureType[0]
            newType2 = obj.aperture_manager.apertureType[1]
        end
        if newType1 and newType2 then
            obj.aperture_manager:SetOpenNotMove(newType1, true, obj:GetBindObj(3), 0, 0.01, 0, self.skillDistance, self.skillDistance, obj, nil, true, nil);
            obj.aperture_manager:SetOpenNotMove(newType2, true, obj:GetBindObj(3), 0, 0.01, 0, self.skillExtraDistance, self.skillExtraDistance, obj, nil, true, nil);
        end
    elseif skillApertureType == 2 then
        local newType = nil
        if self.skillApertureStep == 1 then
            newType = obj.aperture_manager.apertureType[17]
        elseif self.skillApertureStep == 2 then
            newType = obj.aperture_manager.apertureType[18]
        elseif self.skillApertureStep == 3 then
            newType = obj.aperture_manager.apertureType[2]
        end
        if newType then
            obj.aperture_manager:SetOpenNotMove(newType, true, nil, 0, 0.01, 0, 1, self.skillDistance, nil, nil, true, obj:GetForWard())
            obj.last_skill_aperture = newType
            if self.last_skill_angle ~= 0 then
                obj.aperture_manager:SetNotMoveAngle(self.last_skill_angle, obj.last_skill_aperture)
            end
        end
    elseif skillApertureType == 3 then
        local newType = nil
        if self.skillApertureStep == 1 then
            newType = obj.aperture_manager.apertureType[19]
        elseif self.skillApertureStep == 2 then
            newType = obj.aperture_manager.apertureType[20]
        elseif self.skillApertureStep == 3 then
            newType = obj.aperture_manager.apertureType[3]
        end
        if newType then
            obj.aperture_manager:SetOpenNotMove(newType, true, nil, 0, 0.01, 0, self.skillDistance, self.skillDistance, nil, nil, true, obj:GetForWard())
            obj.last_skill_aperture = newType
            if self.last_skill_angle ~= 0 then
                obj.aperture_manager:SetNotMoveAngle(self.last_skill_angle, obj.last_skill_aperture)
            end
        end
    elseif skillApertureType == 4 then
        local newType1 = nil
        local newType2 = nil
        if self.skillApertureStep == 1 then
            newType1 = obj.aperture_manager.apertureType[13]
            newType2 = obj.aperture_manager.apertureType[23]
        elseif self.skillApertureStep == 2 then
            newType1 = obj.aperture_manager.apertureType[14]
            newType2 = obj.aperture_manager.apertureType[24]
        elseif self.skillApertureStep == 3 then
            newType1 = obj.aperture_manager.apertureType[0]
            newType2 = obj.aperture_manager.apertureType[5]
        end
        if newType1 and newType2 then
            obj.aperture_manager:SetOpenNotMove(newType1, true, obj:GetBindObj(3), 0, 0.01, 0, self.skillDistance, self.skillDistance, obj, nil, true, nil);
            local position = obj:GetPosition(true)
            obj.aperture_manager:Open(newType2, position.x, position.y+0.01, position.z, self.skillExtraDistance, self.skillDistance, 1)
        end
    elseif skillApertureType == 5 then
        local newType1 = nil
        local newType2 = nil
        local newType3 = nil
        if self.skillApertureStep == 1 then
            newType1 = obj.aperture_manager.apertureType[13]
            newType2 = obj.aperture_manager.apertureType[15]
            newType3 = obj.aperture_manager.apertureType[23]
        elseif self.skillApertureStep == 2 then
            newType1 = obj.aperture_manager.apertureType[14]
            newType2 = obj.aperture_manager.apertureType[16]
            newType3 = obj.aperture_manager.apertureType[24]
        elseif self.skillApertureStep == 3 then
            newType1 = obj.aperture_manager.apertureType[0]
            newType2 = obj.aperture_manager.apertureType[1]
            newType3 = obj.aperture_manager.apertureType[5]
        end
        if newType1 and newType2 and newType3 then
            local position = obj:GetPosition(true)
            obj.aperture_manager:SetOpenNotMove(newType1, true, obj:GetBindObj(3), 0, 0.01, 0, self.skillDistance, self.skillDistance, obj, nil, true, nil);
            obj.aperture_manager:SetOpenNotMove(newType2, true, obj:GetBindObj(3), 0, 0.01, 0, self.skillDistance-self.skillExtraDistance*2, self.skillDistance-self.skillExtraDistance*2, obj, nil, true, nil);
            obj.aperture_manager:Open(newType3, position.x, position.y+0.01, position.z, self.skillExtraDistance, self.skillDistance-self.skillExtraDistance, 1, true, self.last_skill_angle)
        end
    elseif skillApertureType == 6 then
        local newType = nil
        if self.skillApertureStep == 1 then
            newType = obj.aperture_manager.apertureType[17]
        elseif self.skillApertureStep == 2 then
            newType = obj.aperture_manager.apertureType[18]
        elseif self.skillApertureStep == 3 then
            newType = obj.aperture_manager.apertureType[2]
        end
        if newType then
            obj.aperture_manager:SetOpenNotMove(newType, true, nil, 0, 0.01, 0, 1, self.skillDistance, obj, true, true, obj:GetForWard())
            obj.last_skill_aperture = newType
            if self.last_skill_angle ~= 0 then
                obj.aperture_manager:SetNotMoveAngle(self.last_skill_angle, obj.last_skill_aperture)
            end
        end
    elseif skillApertureType == 7 then
        local newType = nil
        if self.skillApertureStep == 1 then
            newType = obj.aperture_manager.apertureType[26]
        elseif self.skillApertureStep == 2 then
            newType = obj.aperture_manager.apertureType[27]
        elseif self.skillApertureStep == 3 then
            newType = obj.aperture_manager.apertureType[25]
        end
        if newType then
            obj.aperture_manager:SetOpenNotMove(newType, true, nil, 0, 0.01, 0, self.skillDistance, self.skillDistance, nil, nil, true, obj:GetForWard())
            obj.last_skill_aperture = newType
            if self.last_skill_angle ~= 0 then
                obj.aperture_manager:SetNotMoveAngle(self.last_skill_angle, obj.last_skill_aperture)
            end
        end
    end
end

function MainUISkillInput:DragSkill(x, y, param)

    if g_dataCenter.player:CaptionIsAutoFight() then
        return false;
    end

    --检测技能使用条件
    if not self:CheckUseSkill(param) then
        return;
    end
    self:UpdateCancelSkill(x, y, nil, param);
    local move_x = x - self.last_skill_x;
    local move_y = y - self.last_skill_y;
    local dis = math.sqrt(move_x * move_x + move_y * move_y);
    --移动后关闭技能tips
    local screenWidth = app.get_screen_width();
    local moveDiff = screenWidth / 1280 * 10;
    if dis > moveDiff then
        self:ShowSkillTips(x, y, false);
    end
    local mainui = GetMainUI()
    if dis > mainui.right_dis_check  then
        dis = mainui.right_dis_check
    end
    GetMainUI():SetRightMoveDis(dis)
    self.sp_skill_cancel:set_active(true);
    local obj = FightManager.GetMyCaptain()
    if self.isCancelSkill and obj then
        if self.cancelSkillBeginTime == 0 then
            self:ChangeSkillAperture(obj, 1)
            self.cancelSkillBeginTime = PublicFunc.QueryCurTime();
        end
        if PublicFunc.QueryDeltaTime(self.cancelSkillBeginTime) > 1000 then
            if not self.isHoldInCancelSkill then
                self:ChangeSkillAperture(obj, 2)
                self.isHoldInCancelSkill = true;
            end
        end
    else
        if self.cancelSkillBeginTime > 0 and obj then
            self.cancelSkillBeginTime = 0;
            self.isHoldInCancelSkill = false;
            self:ChangeSkillAperture(obj, 3)
        end
    end
    if ((math.abs(move_x) > 10 or math.abs(move_y) > 10) or self.begin_drag) and (not g_dataCenter.setting:Getintelligence()) then
        self.begin_drag = true
        if self.delay_show_apertrue then
            self:ShowDelayApertrue()
        end
        if obj then
            local rotation = obj:GetRotation()
            local skill;
            if param == 1 then
                skill = obj:GetSkill(PublicStruct.Const.SPECIAL_HURDLE_SKILL - PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX+1)
            else
                skill = obj:GetSkill(param+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
            end

            local cameraObj = CameraManager.GetSceneCameraObj();
            local ui_camera = Root.get_ui_camera();
            --if skill:IsCanManualDir() then
                if self.sp_skill_point then
                    if not self.sp_skill_point:get_game_object():get_active() then
                        self.sp_skill_point:set_active(true)
                    end
                    if ui_camera then
                        local dis = math.sqrt(move_x * move_x + move_y * move_y);
                        if dis > self.max_skill_di_dis then
                            dis = self.max_skill_di_dis;
                        end
                        local dx, dy, dz = util.v3_normalized(move_x, move_y, 0);
                        local pX = self.last_skill_x + dx*dis
                        local pY = self.last_skill_y + dy*dis
                        local sX, sY, sZ = ui_camera:screen_to_world_point(pX, pY, 0);
                        self.sp_skill_point:get_game_object():set_position(sX, sY, 0)
                    end
                end
                if self.sp_skill_di and (not self.sp_skill_di:get_game_object():get_active()) then
                    local sX, sY, sZ = ui_camera:screen_to_world_point(self.last_skill_x, self.last_skill_y, 0);
                    self.sp_skill_di:get_game_object():set_position(sX, sY, 0)
                    self.sp_skill_di:set_active(true)
                end

                if cameraObj then
                    local angle = math.atan2(move_y, move_x) * 180 / math.pi;
                    local angle_x, angle_y, angle_z = cameraObj:get_local_rotation();
                    self.last_skill_angle = -angle + (angle_y + 90);
                    if obj.last_skill_aperture and obj.last_skill_aperture ~= -1 and obj.aperture_manager and skill:IsCanManualDir() then
                        obj.aperture_manager:SetNotMoveAngle(self.last_skill_angle, obj.last_skill_aperture)
                    end
                    if obj.aperture_manager and obj.aperture_manager:IsOpen(1) then
                        obj.aperture_manager:SetMoveAngle(self.last_skill_angle)
                    end
                else
                    app.log("MainUISkillInput: Camera error.")
                end
            --end
        end
    end
end

function MainUISkillInput:ReFillCD(obj)
    if self.ui == nil or self.skill_cd == nil then return end
    for k, v in pairs(self.skill_cd) do
        self.skill_cd[k] = nil;
        self.ui_control["sp_mark" .. k]:set_active(false);
        self.ui_control["lab" .. k]:set_text("");
        self.ui_control["cd_fx" .. k]:set_active(false);
        self:GraySkillIcon(k, false)
    end
    for i=1, MAX_SKILL_CNT do
		if obj._arrSkill[i] ~= nil then  
            local uiIndex = obj._arrSkill[i]._uiIndex
			if uiIndex and uiIndex > 0 and PublicFunc.QueryCurTime() < obj._arrSkill[i]._skillCDEnd then
                self.skill_cd[uiIndex] = {cd_time = obj._arrSkill[i]._skillCDEnd, max_time = obj._arrSkill[i]:GetLastCD()/1000};
                self.ui_control["sp_mark" .. uiIndex]:set_active(true);
                self.ui_control["lab" .. uiIndex]:set_text("");
                self.ui_control["cd_fx" .. uiIndex]:set_active(false);
                self:GraySkillIcon(uiIndex, true)
            end
		end
	end
end

function MainUISkillInput:ReFillRationEffect(obj)
    if self.ui == nil then return end

    for i=2, 4 do
        self.ui_control["sp_light"..i]:set_active(false);
    end
    for i=PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX, MAX_SKILL_CNT do
		if obj._arrSkill[i] ~= nil then
			if obj._arrSkill[i]:GetCDType() == ESkillCDType.WaitBuff and obj._arrSkill[i]:IsWorking() then
                if self.ui_control["sp_light"..(i-2)] then
                    self.ui_control["sp_light"..(i-2)]:set_active(true)
                end
            end
		end
	end
end

function MainUISkillInput:UpdateSkillIcon(obj)
    if self.ui == nil then return end

    for i=1, 3 do
        if obj then
            self.ui_control["btn" .. i+1]:set_active(true);
            local skill = obj:GetSkill(i+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX)
            if skill then
                local _skillInfo = ConfigManager.Get(EConfigIndex.t_skill_info,skill._skillData.id).small_icon;
                self.ui_control["skill_icon_"..i]:set_texture(_skillInfo);
                self.ui_control["spLock"..i]:set_active(false)
                if not FightScene.GetHudleSkillEnable(i+2) or skill:IsDisenable() then
                    self:EnableSkillBtn(i+2, false);
                else
                    self:EnableSkillBtn(i+2, true);
                end
            else
                app.log(tostring(obj.config.id).."obj.config.spe_skill======"..tostring(obj.config.spe_skill))
                if obj.config.spe_skill and obj.config.spe_skill[i] and obj.config.spe_skill[i][1] then
                    local info = ConfigManager.Get(EConfigIndex.t_skill_info, obj.config.spe_skill[i][1])
                    if info then
                        self.ui_control["skill_icon_"..i]:set_texture(info.small_icon);
                    end
                end
                self.ui_control["spLock"..i]:set_active(true)
                self:EnableSkillBtn(i+2, true);
                self:GraySkillIcon(i+1, true)
            end

            -- 序章战斗有锁定状态，特殊处理
            local enable = true
            if FightScene.GetFightManager().GetEnableSkillIndex then
                local enableSkillIndex = FightScene.GetFightManager():GetEnableSkillIndex()
                if enableSkillIndex <= i then
                    self.ui_control["btn" .. i+1]:set_active(false);
                end
            end
        else
            self.ui_control["btn" .. i+1]:set_active(false);
        end
        --技能图标加锁 没有锁的话 禁用
        --[[if not PublicFunc.SetSkillLock(obj.config, self.ui_control["spLock"..i], i + 3) then
            --是否禁用

        else
            --有锁了 取消禁用标志

        end]]
    end
    local _,skill_id = FightScene.GetHudleSkillEnable(2); 
    local skill_info = ConfigManager.Get(EConfigIndex.t_skill_info, skill_id);
    if skill_info then
        self.ui_control["skill_icon_0"]:set_texture(skill_info.small_icon);
    end
end

-- 这个只管进场景的时候是否屏蔽
-- 禁用技能按钮:index==1:普功，2加血3下4中5上
--enable == true 可用， false 禁用
function MainUISkillInput:EnableSkillBtn(index,enable)
    --普攻技能无法做循环判断  所以要特殊处理
    if index == 1 then
        self.ui_control["normalAttackSkill"]:set_active(not enable);
        return;
    end
    --技能
    for i = 0, 3 do
        if i + 2 == index then
            if index == 2 then
                self.ui_control["skillShield"..i]:set_active(enable);
            else
                self.ui_control["skillShield"..i]:set_active(not enable);
            end
            break;
        end
    end
    self:GraySkillIcon(index - 1, not enable)
end

--关卡技能屏蔽的初始化
function MainUISkillInput:HurdleSkillShield()
    local cf = ConfigHelper.GetHurdleConfig(FightScene.GetCurHurdleID());
    if cf then
        self:EnableSkillBtn(1, FightScene.GetHudleSkillEnable(1));
        self:EnableSkillBtn(2, FightScene.GetHudleSkillEnable(2));
        --技能跟锁至只能存在一个  所以他的刷新在UpdateSkillIcon中
    end
end

function MainUISkillInput:UpdateSkillOverlap(obj)
    if self.ui == nil then return end
    obj = obj or g_dataCenter.fight_info:GetCaptain()
    if obj then
        for i=1, 3 do
            local skill = obj:GetSkill(i+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX)
            local bShow = false
            local bPassive = false
            if skill then
                local attention_buff = skill:GetSkillAttentionBuff()
                if attention_buff then
                    bShow = true
                    local overlap = obj:GetBuffOverlap(attention_buff[1], attention_buff[2]);
                    local maxoverlap = GetBuffConfigData(attention_buff[1], attention_buff[2]).maxoverlap
                    self.ui_control["lab_overlap"..i+1]:set_active(true)
                    self.ui_control["lab_overlap"..i+1]:set_text(""..overlap)
                    if overlap < maxoverlap and attention_buff[3] and attention_buff[4] then
                        local buff = obj:GetBuffManager():GetBuff(attention_buff[3], attention_buff[4])
                        if buff and buff:IsALive() then
                            local trigger = buff:GetFirstTrigger(eBuffTriggerActiveType.Interval)
                            if trigger then
                                local lastUpdateTime = trigger:GetLastUpdateTime()
                                local intervalTime = trigger:GetIntervalTime()
                                if lastUpdateTime and intervalTime then
                                    if lastUpdateTime == 0 then
                                        lastUpdateTime = PublicFunc.QueryCurTime()
                                    end
                                    self.ui_control["sp_overlap_pointer1"..i+1]:set_active(true)
                                    self.ui_control["sp_overlap_pointer2"..i+1]:set_active(true)
                                    self.ui_control["sp_overlap_pointer2_spr"..i+1]:set_active(true)
                                    self.ui_control["show_overlap_pointer"..i+1] = true
                                    self.ui_control["show_overlap_pointer_update_time"..i+1] = lastUpdateTime
                                    self.ui_control["show_overlap_pointer_interval_time"..i+1] = intervalTime
                                    self.ui_control["show_overlap_pointer_buffid"..i+1] = attention_buff[1]
                                    self.ui_control["show_overlap_pointer_bufflv"..i+1] = attention_buff[2]
                                    self.ui_control["show_overlap_pointer_maxoverlap"..i+1] = maxoverlap
                                    bPassive = true
                                end

                            end
                        end
                    end
                    --app.log("buffid="..attention_buff[1].." lv="..attention_buff[2].." cnt="..overlap.." "..debug.traceback())
                end
                if not bShow then
                    self.ui_control["lab_overlap"..i+1]:set_active(false)
                end
                if not bPassive then
                    self.ui_control["sp_overlap_pointer1"..i+1]:set_active(false)
                    self.ui_control["sp_overlap_pointer2"..i+1]:set_active(false)
                    self.ui_control["sp_overlap_pointer2_spr"..i+1]:set_active(false)
                    self.ui_control["show_overlap_pointer"..i+1] = false
                end
            end
        end
    else
        for i=1, 3 do
            self.ui_control["lab_overlap"..i+1]:set_active(false)
            self.ui_control["sp_overlap_pointer1"..i+1]:set_active(false)
            self.ui_control["sp_overlap_pointer2"..i+1]:set_active(false)
            self.ui_control["sp_overlap_pointer2_spr"..i+1]:set_active(false)
            self.ui_control["show_overlap_pointer"..i+1] = false
        end
    end
end

function MainUISkillInput:Update(dt)

    if not self.ui then
        return
    end
    if self.isCancelSkill then
        local obj = FightManager.GetMyCaptain()
        if obj then
            if PublicFunc.QueryDeltaTime(self.cancelSkillBeginTime) > 1000 then
                if not self.isHoldInCancelSkill then
                    self:ChangeSkillAperture(obj, 2)
                    self.isHoldInCancelSkill = true;
                end
            end
        end
    end
    local curState = g_dataCenter.fight_info:IsInFight()
    -- 更新技能cd
    if self.skill_cd then
        for k, v in pairs(self.skill_cd) do
            if PublicFunc.QueryCurTime() >= v.cd_time then
                self.skill_cd[k] = nil;
                self.ui_control["sp_mark" .. k]:set_active(false);
                self.ui_control["lab" .. k]:set_text("");
                self.ui_control["cd_fx" .. k]:set_active(true);
                self.ui_control["cd_fx" .. k]:reset_to_beginning()
                self:GraySkillIcon(k, false)
                AudioManager.PlayUiAudio(ENUM.EUiAudioType.SkillComplete);
            else
                local mod_time = PublicFunc.QueryDeltaTime(v.cd_time)/1000;
                if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_openWorld --[[or FightScene.GetPlayMethodType() == nil]] then
                    self.ui_control["lab" .. k]:set_text(tostring(math.ceil(mod_time)));
                else
                    self.ui_control["lab" .. k]:set_text(tostring(math.ceil(mod_time)));
                end
                self.ui_control["pro_btn"..k]:set_value(mod_time / v.max_time);
            end
        end
    end

    for i=1, 3 do
        if self.ui_control["show_overlap_pointer"..i+1] then
            local passTime = PublicFunc.QueryDeltaTime(self.ui_control["show_overlap_pointer_update_time"..i+1])
            local value = passTime/self.ui_control["show_overlap_pointer_interval_time"..i+1]
            value = value - math.floor(value)
            value = value*360
            self.ui_control["sp_overlap_pointer2"..i+1]:set_rotation(0,0,-value)

           --[[ local overlap = obj:GetBuffOverlap(self.ui_control["show_overlap_pointer_buffid"..i+1], self.ui_control["show_overlap_pointer_bufflv"..i+1]);
            if overlap == self.ui_control["show_overlap_pointer_maxoverlap"..i+1] then
                self.ui_control["sp_overlap_pointer1"..i+1]:set_active(false)
                self.ui_control["sp_overlap_pointer2"..i+1]:set_active(false)
            else
                self.ui_control["sp_overlap_pointer1"..i+1]:set_active(true)
                self.ui_control["sp_overlap_pointer2"..i+1]:set_active(true)
            end]]
        end
    end
    if self.begin_move then
        if GetMainUI() and GetMainUI():GetJoystick() then
            GetMainUI():GetJoystick():TouchMove("left_touch_ui", self.begin_move_x, self.begin_move_y, nil)
        end
    end
    if self.delay_show_apertrue then
        if PublicFunc.QueryDeltaTime(self.delay_show_apertrue.begin_time) > 300 then
            self:ShowDelayApertrue()
        end
    end
end

function MainUISkillInput:ShowDelayApertrue()
    local value = self.delay_show_apertrue.skill_value
    local param = self.delay_show_apertrue.sklll_param
    local x = self.delay_show_apertrue.x
    local y = self.delay_show_apertrue.y
    local obj = ObjectManager.GetObjectByGID(self.delay_show_apertrue.obj_gid)
    if obj and obj == FightManager.GetMyCaptain() then
        local skill = obj:GetSkill(value+PublicStruct.Const.MAX_NORMAL_ATTACK_INDEX-1)
        if skill ~= nil and (not skill:IsDisenable()) then
            --self.last_skill_x = x
            --self.last_skill_y = y
            --self.begin_drag = false;
            --self.last_skill_angle = 0
            --obj.last_skill_aperture = -1
            local skillApertureType = skill:GetApertureType()
            local skillDistance = skill:GetDistance()
            self.skillDistance = skillDistance
            local skillExtraDistance = skill:GetExtraDistance()
            self.skillExtraDistance = skillExtraDistance
            obj.tipApertureEffect = skillApertureType
            self.tipButtonIndex = param
            local now_dir = nil
            local cur_target = obj:GetAttackTarget()
            local target_pos = nil
            if cur_target then
                target_pos = cur_target:GetPosition()
                local cur_pos = obj:GetPosition()
                local dx = target_pos.x - cur_pos.x
                local dy = 0
                local dz = target_pos.z - cur_pos.z
                now_dir = {}
                now_dir.x, now_dir.y, now_dir.z = util.v3_normalized(dx, dy, dz);
            end
            if obj.aperture_manager then
                if skillApertureType == 0 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[skillApertureType], true, obj:GetBindObj(3), 0, 0, 0, skillDistance, skillDistance, obj, nil, true, nil);
                elseif skillApertureType == 1 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[0], true, obj:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, obj, nil, true, nil);
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[1], true, obj:GetBindObj(3), 0, 0.01, 0, skillExtraDistance, skillExtraDistance, obj, nil, true, nil);
                elseif skillApertureType == 2 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[skillApertureType], true, nil, 0, 0.01, 0, 1, skillDistance, nil, nil, true, now_dir)
                    obj.last_skill_aperture = obj.aperture_manager.apertureType[skillApertureType]
                elseif skillApertureType == 3 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[skillApertureType], true, nil, 0, 0.01, 0, skillDistance, skillDistance, nil, nil, true, now_dir)
                    obj.last_skill_aperture = obj.aperture_manager.apertureType[skillApertureType]
                elseif skillApertureType == 4 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[0], true, obj:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, obj, nil, true, nil);
                    local position = obj:GetPosition(true)
                    local x,y,z
                    if target_pos then
                        local dis = algorthm.GetDistance(target_pos.x, target_pos.z, position.x, position.z)
                        if dis > skillDistance-skillExtraDistance then
                            local dx = target_pos.x - position.x
                            local dy = 0
                            local dz = target_pos.z - position.z
                            dx, dy, dz = util.v3_normalized(dx, dy, dz);
                            x = position.x + dx*(skillDistance-skillExtraDistance)
                            y = position.y + 0.01
                            z = position.z + dz*(skillDistance-skillExtraDistance)
                        else
                            x = target_pos.x
                            y = target_pos.y + 0.01
                            z = target_pos.z
                        end
                    else
                        x = position.x
                        y = position.y + 0.01
                        z = position.z
                    end
                    obj.aperture_manager:Open(obj.aperture_manager.apertureType[5], x, y, z, skillExtraDistance, skillDistance, 1)
                elseif skillApertureType == 5 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[0], true, obj:GetBindObj(3), 0, 0.01, 0, skillDistance, skillDistance, obj, nil, true, nil);
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[1], true, obj:GetBindObj(3), 0, 0.01, 0, skillDistance-skillExtraDistance*2, skillDistance-skillExtraDistance*2, obj, nil, true, nil);
                    local position = obj:GetPosition(true)
                    local target = obj:GetAttackTarget()
                    local dir
                    if target then
                        local targetPos = target:GetPosition(true)
                        dir = {}
                        dir.x = targetPos.x - position.x;
                        dir.y = 0
                        dir.z = targetPos.z - position.z;
                        dir.x, dir.y, dir.z = util.v3_normalized(dir.x, dir.y, dir.z);
                    else
                        dir = obj:GetForWard()
                    end
                    obj.aperture_manager:Open(obj.aperture_manager.apertureType[5], position.x, position.y+0.01, position.z, skillExtraDistance, skillDistance-skillExtraDistance, 1, true, dir)
                elseif skillApertureType == 6 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[2], true, nil, 0, 0.01, 0, 1, skillDistance, obj, true, true, obj:GetForWard())
                    obj.last_skill_aperture = obj.aperture_manager.apertureType[2]
                elseif skillApertureType == 7 then
                    obj.aperture_manager:SetOpenNotMove(obj.aperture_manager.apertureType[25], true, nil, 0, 0.01, 0, skillDistance, skillDistance, nil, nil, true, now_dir)
                    obj.last_skill_aperture = obj.aperture_manager.apertureType[25]
                end
            end
        end
    end
    self.delay_show_apertrue = nil       
end

function MainUISkillInput:OnHide()
    if self.ui then
        self:ResetFxState()
    end
end

function MainUISkillInput:ResetFxState()
    for i=1,4 do
        self.ui_control["cd_fx" .. i]:set_active(false);
        self.ui_control["click_fx"..i]:set_active(false)
    end
end

-- index    0 普攻
--          2 技能1
--          3 技能2
--          4 技能3
function MainUISkillInput:GraySkillIcon(index, is)
    if index == nil then
        app.log("#skillinput#GraySkillIcon " .. debug.traceback())
        return
    end
    self:UpIndexGrayCount(index, is)
    local is = self:IndexIsGray(index)
    if index == 0 then
        local tex = self.ui_control["normalAttackSkillIcon"]
        if is then
            tex:set_color(0, 0, 0, 1)
        else
            tex:set_color(1, 1, 1, 1)
        end
    end
    if index >= 2 and index <= 4 then
        local tex = self.ui_control["skill_icon_"..index - 1]
        if tex then
            if is then
                tex:set_color(0, 0, 0, 1)
            else
                tex:set_color(1, 1, 1, 1)
            end
        end
    end
end

function MainUISkillInput:IndexIsGray(index)
    local count = self.indexGrayCount[index] or 0
    return count > 0
end

function MainUISkillInput:UpIndexGrayCount(index, is)
    
    local count = self.indexGrayCount[index] or 0

    if is then
        count = count + 1
    else
        count = count - 1
    end

    if count < 0 then
        count = 0
    end
    self.indexGrayCount[index] = count
end

--开始技能cd
--index 第几个技能
--time 时间
function MainUISkillInput:SkillStartCd(index, endFrame, time)
    if index and index >= 1 and index <= 4 then
        self.skill_cd[index] = {cd_time = endFrame, max_time = time};
        self.ui_control["sp_mark" .. index]:set_active(true);
        self.ui_control["lab" .. index]:set_text(tostring(time));
        self.ui_control["cd_fx" .. index]:set_active(false);
        self:GraySkillIcon(index, true)

        if self.tipButtonIndex and self.tipButtonIndex == index then
            self.sp_skill_point:set_active(false)
            self.sp_skill_di:set_active(false)
            local obj = FightManager.GetMyCaptain()
            self.delay_show_apertrue = nil
            if obj and obj.tipApertureEffect then
                self:ClearSkillAperture(obj)
                obj.tipApertureEffect = nil
                self.tipButtonIndex = nil
                self.cancelSkillBeginTime = 0
                self.skillApertureStep = 0;
                self.isHoldInCancelSkill = false
            end
        end
    end
end

function MainUISkillInput:SkillStopCD(index)
    if self.ui == nil then return end

    if index and index >= 1 and index <= 4 then
        self.skill_cd[index] = nil;
        self.ui_control["sp_mark" .. index]:set_active(false);
        self.ui_control["lab" .. index]:set_text("");
        self:GraySkillIcon(index, false)

        local cdfx = self.ui_control["cd_fx" .. index]
        if cdfx then
            cdfx:set_active(true);
            cdfx:reset_to_beginning();
        end
    end
end

function MainUISkillInput:CheckFightState()
    if PublicStruct.Fight_Sync_Type == ENUM.EFightSyncType.StateSync --[[or FightScene.GetPlayMethodType() == nil]] then
        self.ui_control["spFighting"]:set_active(false);
        return
    end
    -- TEMP: 大乱斗战斗加血状态临时处理
    if FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion or
       FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_fuzion2 or
       FightScene.GetPlayMethodType() == MsgEnum.eactivity_time.eActivityTime_threeToThree then
        self.ui_control["spFighting"]:set_active(false);
        return
    end
    local curState = g_dataCenter.fight_info:IsInFight()

    if self.ui_control["spFighting"] and FightScene.UseAddHpSkill then
        if curState then
            self.ui_control["spFighting"]:set_active(true);
        else
            self.ui_control["spFighting"]:set_active(false);
        end
    end
end

--关闭打开旋转特效
--index第几个技能
--enable打开或者关闭
function MainUISkillInput:EnableRationEffect(index, enable)
    if self.ui == nil then return end
    if index >= 2 and index <= 4 then
        self.ui_control["sp_light"..index]:set_active(enable);
    end
end
--取消英雄技能特效
function MainUISkillInput:CancelSkillEffect()
    if self.sp_skill_point then
        self.sp_skill_point:set_active(false)
    end
    if self.sp_skill_di then
        self.sp_skill_di:set_active(false)
    end
    if self.sp_skill_cancel then
        self.sp_skill_cancel:set_active(false);
    end
    local obj = FightManager.GetMyCaptain();
    self.delay_show_apertrue = nil
    if obj and obj.tipApertureEffect then
        self:ClearSkillAperture(obj)
        obj.tipApertureEffect = nil
        self.cancelSkillBeginTime = 0
        self.skillApertureStep = 0;
        self.isHoldInCancelSkill = false
    end
end

function OnSpecialKeyWUp()
    --[[if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():NormalAttack("1", true, 0, 0, nil, -1, nil)
        GetMainUI():GetSkillInput():NormalAttack("1", false, 0, 0, nil, -1, nil)
    end]]
    if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():UseSkill(0, 0, false, 2, nil)
        --[[GetMainUI():GetSkillInput().begin_move = false
        GetMainUI():GetSkillInput().begin_move_x = 96
        GetMainUI():GetSkillInput().begin_move_y = 175]]

    end
    --[[if GetMainUI() and GetMainUI():GetJoystick() then
        GetMainUI():GetJoystick():TouchBegin("left_touch_ui", false, 96, 175, nil)
    end]]
end

function OnSpecialKeyWDown()
    if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():UseSkill(0, 0, true, 2, nil) 
        --[[GetMainUI():GetSkillInput().begin_move = true
        GetMainUI():GetSkillInput().begin_move_x = 96
        GetMainUI():GetSkillInput().begin_move_y = 175]]
        
    end
    --[[if GetMainUI() and GetMainUI():GetJoystick() then
        GetMainUI():GetJoystick():TouchBegin("left_touch_ui", true, 96, 175, nil)
    end]]
end
function OnSpecialKeyEUp()
    if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():UseSkill(0, 0, false, 3, nil)
    end
end

function OnSpecialKeyEDown()
    if GetMainUI() and GetMainUI():GetSkillInput() then
        GetMainUI():GetSkillInput():UseSkill(0, 0, true, 3, nil) 
    end
end




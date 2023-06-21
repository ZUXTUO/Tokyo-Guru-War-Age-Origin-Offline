Fuzion2TeamUI = Class("Fuzion2TeamUI", UiBaseClass);

local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_jjc.assetbundle"

function Fuzion2TeamUI.GetResList()
    return {res}
end

function Fuzion2TeamUI:Init(data)
    self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function Fuzion2TeamUI:InitData(data)
    UiBaseClass.InitData(self, data);
end

function Fuzion2TeamUI:Restart(data)
    if UiBaseClass.Restart(self, data) then
    end
end

function Fuzion2TeamUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_update_fighter_data"] = Utility.bind_callback(self, self.on_update_fighter_data);
end

function Fuzion2TeamUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    NoticeManager.BeginListen(ENUM.NoticeType.FuzionFighterData, self.bindfunc['on_update_fighter_data'])
end

function Fuzion2TeamUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function Fuzion2TeamUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("Fuzion2TeamUI");

    if self.pos then
        self.ui:set_local_position(self.pos.x, self.pos.y, self.pos.z);
    else
        self.ui:set_local_position(0, 0, 0);
    end
    local right = self.ui:get_child_by_name("right_head_cont");
    right:set_active(false);
    local obj = self.ui:get_child_by_name("left_head_cont/sp_bk");
    obj:set_active(false);
    local objBk = self.ui:get_child_by_name("left_head_cont/sp_di");
    objBk:set_active(false);

    self.role_id_head = {}
    self.listRole = {}
    for i = 1, 3 do
        self.listRole[i] = {};
        local roleInfo = self.listRole[i];
        roleInfo.objRoot = self.ui:get_child_by_name("left_head_cont/cont_black_di"..i);
        local objSkill = roleInfo.objRoot:get_child_by_name("sp_white_bk");
        objSkill:set_active(false);
        roleInfo.objRoot:set_collider_enable(false);
        roleInfo.btnHead = ngui.find_button(roleInfo.objRoot, "cont_black_di"..i);
        roleInfo.toggleHead = ngui.find_toggle(roleInfo.objRoot, "cont_black_di"..i);
        roleInfo.proHp = ngui.find_progress_bar(roleInfo.objRoot, "pro_xuetiao");
        roleInfo.beAttackedTipSp = ngui.find_sprite(roleInfo.objRoot, "sp_shine")
        roleInfo.beAttackedTipSp:set_active(false)
        roleInfo.spMark = ngui.find_sprite(roleInfo.objRoot, "sp_mark");
        roleInfo.spMark:set_active(false);
        roleInfo.spMark2 = ngui.find_sprite(roleInfo.objRoot, "sp_black_di");
        roleInfo.spMark2:set_active(false);
        roleInfo.labTime = ngui.find_label(roleInfo.objRoot, "lab_time");
        roleInfo.labTime:set_color(1, 1, 1, 1);
        roleInfo.labTime:set_text("");
        roleInfo.headParent = roleInfo.objRoot:get_child_by_name("big_card_item_80")
        roleInfo.headSmallCard = SmallCardUi:new({parent = roleInfo.headParent, stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star, SmallCardUi.SType.Rarity}})
        roleInfo.headSmallCard:EnableButtonFunc(false)

        if self._initData.isOpenChange == false then
            ngui.find_sprite(roleInfo.objRoot, 'sp_small_di/sp_effect'):set_active(false)
            ngui.find_sprite(roleInfo.objRoot, 'sp_big_di/sp_effect'):set_active(false)
        end
    end

    self:UpdateHeadData()
end

function Fuzion2TeamUI:UpdateHeadData()
    if not self.ui then
        return;
    end

    local data = self:GetCurHero();
    if not data then
    	return;
    end

    for i = 1,3 do
        local roleInfo = self.listRole[i];
        if not roleInfo.btnHead then
            break
        end
        local id = data.HeroList[i];
        if not id then
            roleInfo.btnHead:set_active(false);
        else
            roleInfo.btnHead:set_active(true);
            if not roleInfo.Info then
            	roleInfo.Info = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Hero,id);
                if not roleInfo.Info then 
                    roleInfo.Info = g_dataCenter.package:find_card(ENUM.EPackageType.Hero,id);
                end
                roleInfo.headSmallCard:SetData(roleInfo.Info)
            end
            local dead = data.dead or 0;
            if i == (dead + 1) then
            	roleInfo.spMark:set_active(false)
            	roleInfo.toggleHead:set_value(true)
            else
            	if i==#data.HeroList and i == dead then
            		GetMainUI():InitTouchMoveCamera();
            		GetMainUI():InitViewer();
            		GetMainUI():RemoveComponent(EMMOMainUICOM.MainUIJoystick);
            		GetMainUI():RemoveComponent(EMMOMainUICOM.MainUISkillInput);
            	end
            	roleInfo.toggleHead:set_value(false)
            	if i < (dead+1) then
            		roleInfo.labTime:set_color(1, 0, 0, 1);
            		roleInfo.labTime:set_text("已阵亡");
            		roleInfo.spMark:set_active(true)
                    roleInfo.headSmallCard:SetGray(true)
            		roleInfo.proHp:set_value(0);
            	else
            		local maxHp = roleInfo.Info:GetPropertyVal('max_hp');
            		roleInfo.proHp:set_value(1);
            	end
            end
        end
    end
end

function Fuzion2TeamUI:Update(dt)
    if not UiBaseClass.Update(self,dt) then
        return;
    end
    local data = self:GetCurHero();
    local entity = FightScene.GetFightManager().heroList[data.herogid]
    if entity and data then
    	local cur_blood = entity:GetPropertyVal('cur_hp');
    	if cur_blood > 0 then
    		local dead = data.dead or 0;
    		local roleInfo = self.listRole[dead+1];
    		local curHp = entity:GetPropertyVal(ENUM.EHeroAttribute.cur_hp)
    		local maxHp = entity:GetPropertyVal('max_hp');
    		local value = curHp / maxHp;
            if roleInfo then
                roleInfo.proHp:set_value(tostring(value));
                roleInfo.Info = entity;
            end
    	end
    end

    for _, data in pairs(self:GetHeroList()) do
        local entity = FightScene.GetFightManager().heroList[data.herogid];
        if entity then
            local cur_blood = entity:GetPropertyVal('cur_hp');
            if cur_blood <= 0 then
                GetMainUI():GetMinimap():DeletePeople(entity);
            end
        end
    end
end

function Fuzion2TeamUI:GetCurHero()
    return self.curHeroInfo;
end

function Fuzion2TeamUI:GetHeroList()
    return self.playerList;
end

-- list = 
-- {
--     herogid=
-- }
function Fuzion2TeamUI:SetPlayerList(list)
    self.playerList = list;
end

-- info = 
-- {
--     HeroList = {number,number}
--     dead 
--     herogid
-- }
function Fuzion2TeamUI:SetCurHeroInfo(info)
    self.curHeroInfo = info;
end

function Fuzion2TeamUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
end

-------------------------------------网络回调-------------------------------------
--战斗者数据变化
function Fuzion2TeamUI:on_update_fighter_data()
    self:UpdateHeadData()

    -- TODO: 击杀UI展示
end

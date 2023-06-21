MMOFightUIClick = Class("MMOFightUIClick",UiBaseClass)

local res = "assetbundles/prefabs/ui/fight/panel_mark.assetbundle"

function MMOFightUIClick.GetResList()
    return {res}
end

function MMOFightUIClick:Init(data)
	self.pathRes = res;
    UiBaseClass.Init(self, data);
end

function MMOFightUIClick:InitData(data)
	UiBaseClass.InitData(self, data);
	self.fightManager = FightScene.GetFightManager();
    self.is_open_click_move = data.is_open_click_move
end

function MMOFightUIClick:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_touch_screen"] = Utility.bind_callback(self,self.on_touch_screen);
end

function MMOFightUIClick:InitUI(asset_obj)
	UiBaseClass.InitUI(self,asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d_fight());

	self.btn_mark = ngui.find_sprite(self.ui, "sp_mark");
    self.btn_mark:set_on_ngui_click(self.bindfunc['on_touch_screen']);

    local panel = ngui.find_panel(self.ui, self.ui:get_name())
    panel:set_depth(0)
end

function MMOFightUIClick:on_touch_screen(name,x,y,game_obj)
    local bit_table = {}
    bit_table[1]=PublicStruct.UnityLayer.npc
    bit_table[2]=PublicStruct.UnityLayer.player
    bit_table[3]=PublicStruct.UnityLayer.monster
    if self.is_open_click_move then
        bit_table[4]=PublicStruct.UnityLayer.terrain;
    end
	local layer_mask = PublicFunc.GetBitLShift(bit_table)
    local result, hitinfo = util.raycase_out_object(x,y,2000,layer_mask);
    if result == true then
        local name = hitinfo.game_object:get_name();
        local info = ObjectManager.GetObjectByName(name);
        local captain = g_dataCenter.fight_info:GetCaptain();
        --点地
        if not info then 
            if captain and captain:CheckStateValid(EHandleState.Move) and captain:GetAI() ~= FightScene.GetFightManager():GetMainHeroAutoFightAI() then
                if captain.aperture_manager then
                    captain.aperture_manager:SetOpenNotMove(captain.aperture_manager.clickEffect, true, 
                        SceneManager.GetCurrentScene().fightScene, hitinfo.x, hitinfo.y+0.5, hitinfo.z, nil, nil, nil, nil, true, nil);
                end
                TouchManager.SetMovePos(hitinfo.x, hitinfo.y, hitinfo.z);
                captain:SetHandleState(EHandleState.ClickMove);
            end
            return 
        end
        if info:IsNpc() then
            self.fightManager:MoveCaptainToNpc(info);
        else
            if not info:IsItem() and info:IsEnemy() then
                
                if captain then
                    captain:SetAttackTarget(info)
                end
            end
            --app.log("select"..name)
        end
        --将切换目标的功能选择队列清空
        if GetMainUI() and GetMainUI():GetSkillInput() then
            GetMainUI():GetSkillInput():ClearSelectList();
        end
    end
end

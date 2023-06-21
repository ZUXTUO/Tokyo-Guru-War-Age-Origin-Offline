--[[摧毁木桶战斗ui]]
CuiHuiMuTongFightUI = 
{
};

local pathRes = "assetbundles/prefabs/ui/wanfa/equipment_base/ui_913_develop_equip.assetbundle";

local ui = nil;
local lab_killNum = nil;
local sp_di = nil;

function CuiHuiMuTongFightUI.Start()
	CuiHuiMuTongFightUI.Load();
end

function CuiHuiMuTongFightUI.Load()
	ResourceLoader.LoadAsset(pathRes, CuiHuiMuTongFightUI.OnLoaded);
end

function CuiHuiMuTongFightUI.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		CuiHuiMuTongFightUI.InitUI(asset_obj);
	end
end

function CuiHuiMuTongFightUI.InitUI(obj)
    ui = asset_game_object.create(obj);
    ui:set_name("ui_cui_hui_mu_tong");
    ui:set_parent(Root.get_root_ui_2d_fight());
    ui:set_local_scale(1, 1, 1);
    ui:set_local_position(0, 0, 0);

    lab_killNum = ngui.find_label(ui,"lab_kill");
    sp_di = ngui.find_sprite(ui,"sp_di");
    sp_di:set_active(false);
    CuiHuiMuTongFightUI.UpdateUI();
end

function CuiHuiMuTongFightUI.GetProgress(cond)
	if cond == 0 or cond == nil then
		return nil; 
	end

	for k, v in pairs(cond) do
		local cur,max = FightCondition.GetProgress(k, v)
		if cur then
			return cur,max;
		end
	end
end

function CuiHuiMuTongFightUI.UpdateUI()
	local fmgr = FightScene.GetFightManager();
	local win_cond = fmgr.passCondition.win.check;
	local cur,max = CuiHuiMuTongFightUI.GetProgress(win_cond);
	if lab_killNum then
		lab_killNum:set_text(string.format("%s/%s",tostring(cur),tostring(max)));
	end
end

function CuiHuiMuTongFightUI.Destroy()
	ui = nil;
	lab_killNum = nil;
	sp_di = nil;
end

local pathRes = "assetbundles/prefabs/ui/fight/zhuangbeiku/time_time.assetbundle";
FightClock = {};

function FightClock.Start()
    FightClock.LoadAsset()
end

function FightClock.LoadAsset()
    ResourceLoader.LoadAsset(pathRes, FightClock.OnLoaded, nil);
end

function FightClock.OnLoaded(pid, filepath, asset_obj, error_info)
    if filepath == pathRes then
        FightClock.InitUI(asset_obj);
    end
end

function FightClock.InitUI(obj)
    FightClock.ui = asset_game_object.create(obj);
    FightClock.ui:set_name("fight_clock");
    FightClock.ui:set_parent(Root.get_root_ui_2d_fight());
    FightClock.ui:set_local_scale(1, 1, 1);
    FightClock.ui:set_local_position(0, 0, 0);

	FightClock.lbl_time = ngui.find_label(FightClock.ui, "lab_revive_time");
	FightClock.timeTimer = timer.create("FightClock.CountTime", 1000, -1);
end

-- 一秒更新一次
function FightClock.CountTime()
    if FightClock.lbl_time == nil then return end;
    local str = TimeAnalysis.analysisSec_2(FightManager.GetFightTime());
    FightClock.lbl_time:set_text(str);
end

function FightClock.Destroy()
	FightClock.lbl_time = nil;
end

--[[高速狙击战斗ui]]
GaoSuJuJiFightUI = {};
local pathRes = "assetbundles/prefabs/ui/wanfa/ghoul_assault/ui_805_fight.assetbundle";

local ui = nil;

local winTitle = nil;
local loseTitle = nil;
local labTitle = nil;
local labTime = nil;
local labDes = nil;
local odd_root = nil;
local odd_awards = {};
local even_root = nil;
local even_awards = {};
local btnLeave = nil;
local btnContinue = nil;
local btnTempLeave = nil;

local gaoSuJujiData = nil;
local _PlayMethod = nil;
local time = 0;
local wait_time = 3;
local timer_id = nil;

function GaoSuJuJiFightUI.Start()
	GaoSuJuJiFightUI.Load();
end

function GaoSuJuJiFightUI.Load()
    ResourceLoader.LoadAsset(pathRes, GaoSuJuJiFightUI.OnLoaded);
end

function GaoSuJuJiFightUI.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		GaoSuJuJiFightUI.InitUI(asset_obj);
	end
end

function GaoSuJuJiFightUI.InitUI(obj)
    ui = asset_game_object.create(obj);
    ui:set_parent(Root.get_root_ui_2d());
    ui:set_local_scale(1, 1, 1);
    ui:set_local_position(0, 0, 0);
    ui:set_active(false);

    winTitle = ui:get_child_by_name("stage_clear");
    winTitle:set_active(false)
    loseTitle= ui:get_child_by_name("battle_failure");
    loseTitle:set_active(false)

    btnLeave = ngui.find_button(ui,"centre_other/animation/btn_leave");
    btnLeave:set_on_click("GaoSuJuJiFightUI.on_over_game");
    btnTempLeave = ngui.find_button(ui,"centre_other/animation/btn_zan_leave");
    btnTempLeave:set_on_click("GaoSuJuJiFightUI.on_leave_game");
    btnContinue = ngui.find_button(ui,"centre_other/animation/btn_going");
    btnContinue:set_on_click("GaoSuJuJiFightUI.on_challenge");

    labTitle = ngui.find_label(ui,"centre_other/animation/lab_num");
    labWinTitle = ngui.find_label(ui,"centre_other/animation/lab_win");
    labDes = ngui.find_label(ui,"centre_other/animation/txt");
    labTime = ngui.find_label(ui,"centre_other/animation/txt_donw");

    odd_root = ngui.find_sprite(ui,"centre_other/animation/txt_huo_de/odd_num");
    for i=1,3 do
    	local path = "centre_other/animation/txt_huo_de/odd_num/kug"..i.."/";
    	odd_awards[i] = {};
        odd_awards[i].obj = ngui.find_sprite(ui,"centre_other/animation/txt_huo_de/odd_num/kug"..i);
    	odd_awards[i].name = ngui.find_label(ui,path.."lab_name");
    	odd_awards[i].num = ngui.find_label(ui,path.."small_card_item/sp_back/lab");
    	odd_awards[i].sp = ngui.find_texture(ui,path.."small_card_item/sp_back/human/texture");
    	odd_awards[i].frame = ngui.find_sprite(ui,path.."small_card_item/sp_back/sp_frame");
    	local mark = ngui.find_sprite(ui,path.."small_card_item/sp_back/sp_mark");
    	mark:set_active(false);
    	local shine = ngui.find_sprite(ui,path.."small_card_item/sp_back/human/sp_shine");
    	shine:set_active(false);
    end

    even_root = ngui.find_sprite(ui,"centre_other/animation/txt_huo_de/even_num");
    for i=1,4 do
    	local path = "centre_other/animation/txt_huo_de/even_num/kug"..i.."/";
    	even_awards[i] = {};
        even_awards[i].obj = ngui.find_sprite(ui,"centre_other/animation/txt_huo_de/even_num/kug"..i);
        even_awards[i].name = ngui.find_label(ui,path.."lab_name");
    	even_awards[i].num = ngui.find_label(ui,path.."small_card_item/sp_back/lab");
    	even_awards[i].sp = ngui.find_texture(ui,path.."small_card_item/sp_back/human/texture");
    	even_awards[i].frame = ngui.find_sprite(ui,path.."small_card_item/sp_back/sp_frame");
    	local mark = ngui.find_sprite(ui,path.."small_card_item/sp_back/sp_mark");
    	mark:set_active(false);
    	local shine = ngui.find_sprite(ui,path.."small_card_item/sp_back/human/sp_shine");
    	shine:set_active(false);
    end

	_PlayMethod = FightScene.GetStartUpEnv():GetPlayMethod();
	gaoSuJujiData = g_dataCenter.activity[_PlayMethod];

end

function GaoSuJuJiFightUI.on_leave_game()
    FightScene.GetFightManager():FightOver(true);
end

function GaoSuJuJiFightUI.on_over_game()
   FightScene.ExitFightScene();
end

function GaoSuJuJiFightUI.Show(isWin,isFinish,awards,groud,wave)
    if not ui then
        return;
    end
	if isWin then
		if isFinish then
            labTime:set_active(false);
			winTitle:set_active(true);
            labWinTitle:set_active(true);
            labTitle:set_active(false);
            labDes:set_active(false);
            btnContinue:set_active(false);
            btnLeave:set_active(true);
            btnTempLeave:set_active(false);
		else
            btnContinue:set_active(true);
            btnLeave:set_active(false);
            btnTempLeave:set_active(true);
            labWinTitle:set_active(false);
            labDes:set_active(false);
            labTime:set_active(true);
            labTime:set_text(wait_time.."秒后自动继续挑战");
            labTitle:set_active(true);
            -- labTitle:set_text(string.format("恭喜通过第%s-%s波",tostring(groud),tostring(wave)));
            labTitle:set_text(string.format("恭喜通过第%s波",tostring(groud)));
            timer_id = timer.create("GaoSuJuJiFightUI.on_challenge",1000,wait_time);
		end
	else
        btnContinue:set_active(false);
        btnLeave:set_active(true);
        btnTempLeave:set_active(false);
        loseTitle:set_active(true);
        labWinTitle:set_active(false);
		labDes:set_active(true);
        labTime:set_active(false);
        labTitle:set_active(true);
		-- labTitle:set_text(string.format("通过第%s-%s波失败",tostring(groud),tostring(wave)));
        labTitle:set_text(string.format("通过第%s波失败",tostring(groud)));
	end

    --道具
    --判断奇偶数
    local controlData = nil;
    if (#awards) % 2 == 0 then
        odd_root:set_active(false);
        even_root:set_active(true);
        controlData = even_awards;
    else
        odd_root:set_active(true);
        even_root:set_active(false);
        controlData = odd_awards;
    end
    if #awards == 1 then
        awards = {[2]=awards[1]};
    end
    if #awards == 2 then
        awards = {[2]=awards[1],[3]=awards[2]};
    end
    --初始化道具
    for i = 1, 4 do
        if controlData[i] and controlData[i].obj then
            if awards[i] then
                controlData[i].obj:set_active(true);
                local tempData = awards[i];
                local cfData = PublicFunc.IdToConfig(tempData.id);
                if cfData == nil then
                    app.log("CommonAward.UpdateUi id="..tostring(tempData.id));
                    return;
                end
                --道具图标
                -- item_manager.texturePadding(controlData[i].sp, cfData.small_icon);
                controlData[i].sp:set_texture( cfData.small_icon);
                --品质框
                PublicFunc.SetIconFrameSprite(controlData[i].frame, cfData.rarity);
                --数量
                if PropsEnum.IsVaria(tempData.id) then
                    controlData[i].num:set_active(false);
                    controlData[i].name:set_text(tostring(tempData.count)..tostring(cfData.name));
                else
                    controlData[i].num:set_active(true);
                    controlData[i].num:set_text("x"..tostring(tempData.count));
                    controlData[i].name:set_text(tostring(cfData.name));
                end
            else
                controlData[i].obj:set_active(false);
            end
        end
    end

	ui:set_active(true);
end

function GaoSuJuJiFightUI.on_challenge(t)
    time = time + 1
    if ui and time <= wait_time then
        labTime:set_text(tostring(wait_time-time).."秒后自动继续挑战");
    end
    if type(t) == "table" or time >= wait_time then
        time = 0;
        if timer_id then
            timer.stop(timer_id);
            timer_id = nil;
        end
        if ui then
            ui:set_active(false);
        end
        FightScene.GetFightManager():OnStart();
    end
end

function GaoSuJuJiFightUI.Destroy()
    if ui then
        ui:set_active(false);
        ui = nil
    end
    if timer_id then
        timer.stop(timer_id);
        timer_id = nil;
    end
    for k,v in pairs(odd_awards) do
        v.sp:Destroy();
    end
    odd_awards = {};
    for k,v in pairs(even_awards) do
        v.sp:Destroy();
    end
    even_awards = {};
    winTitle = nil;
    loseTitle = nil;
    labTitle = nil;
    labTime = nil;
    labDes = nil;
    odd_root = nil;
    even_root = nil;
    btnLeave = nil;
    btnContinue = nil;
    btnTempLeave = nil;
    gaoSuJujiData = nil;
    _PlayMethod = nil;
    time = 0;
end

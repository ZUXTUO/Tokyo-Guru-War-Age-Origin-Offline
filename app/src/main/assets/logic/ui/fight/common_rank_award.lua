--[[

CommonRankAward = {};

local pathRes = "assetbundles/prefabs/ui/wanfa/world_boss/ui_3002_world_boss.assetbundle";
--------------------外部接口-------------------------
--kill = {name = "", str = "", award = {net_summary_item, net_summary_item, net_summary_item} } 击杀奖励以及标题
--rankAward = {{name = "", award = {net_summary_item, net_summary_item, net_summary_item} }, ....}
--ownAward = {hurtStr = "", rankStr = "", image = 1, award = {net_summary_item}}
function CommonRankAward.Start(kill, rankAward, ownAward)
	if CommonRankAward.ui == nil then
		CommonRankAward.Init(kill, rankAward, ownAward);
		CommonRankAward.LoadAsset();
	end
end


function CommonRankAward.SetFinishCallback(callback, obj)
	CommonRankAward.callbackFunc = callback;
	if CommonRankAward.callbackFunc then
		CommonRankAward.callbackObj = obj;
	end
end

--------------------内部接口-------------------------
function CommonRankAward.Init(kill, rankAward, ownAward)
	--外部数据相关
	CommonRankAward.data = {};
	CommonRankAward.data.kill = kill;
	CommonRankAward.data.rankAward = rankAward;
	CommonRankAward.data.ownAward = ownAward;
	--ui相关
	CommonRankAward.ui = nil;
	CommonRankAward.uiControl = {};
	--内部变量相关
	--CommonRankAward.callbackFunc
	--CommonRankAward.callbackObj
	CommonRankAward.btnList = {}
	CommonRankAward.textureList = {};
end

function CommonRankAward.LoadAsset()
	ResourceLoader.LoadAsset(pathRes, CommonRankAward.on_load);
end

function CommonRankAward.on_load(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		CommonRankAward.InitUi(asset_obj)
	end
end

function CommonRankAward.InitUi(asset)
	CommonRankAward.ui = asset_game_object.create(asset);
	CommonRankAward.ui:set_parent(Root.get_root_ui_2d());
	CommonRankAward.ui:set_local_scale(Utility.SetUIAdaptation());
	CommonRankAward.ui:set_name("CommonRankAward");

	local control = CommonRankAward.uiControl;
	control.objLeftOther = CommonRankAward.ui:get_child_by_name("left_other");

	CommonRankAward.allItem = {};
	--击杀奖励
	control.objKill = control.objLeftOther:get_child_by_name("sp_di_big1");
	control.labKillName = ngui.find_label(control.objKill, "lab_name");
	control.labKill = ngui.find_label(control.objKill, "lab_jiang_li");
	control.listKill = {};
	control.listKill.objRoot = control.objKill:get_child_by_name("rank_cont");
	CommonRankAward.allItem.killItem = {};
	for i = 1, 3 do
		control.listKill["objGood"..i] = control.listKill.objRoot:get_child_by_name("small_card_item"..i);
	end
	--排名奖励
	control.objRank = CommonRankAward.ui:get_child_by_name("panel");
	control.viewRank = ngui.find_scroll_view(control.objRank, "panel");
	control.wrapRank = ngui.find_wrap_content(control.objRank, "wrap_content");
	control.wrapRank:set_on_initialize_item("CommonRankAward.OnInitItem");
	control.listRank = {}
	--自己的奖励
	control.objOwnAward = CommonRankAward.ui:get_child_by_name("right_other");
	control.labHurt = ngui.find_label(control.objOwnAward, "lab1");
	control.labRank = ngui.find_label(control.objOwnAward, "lab2");
	CommonRankAward.textureList["textureHuman"] = ngui.find_texture(control.objOwnAward, "texture_human");
	control.listOwnAward = {}
	CommonRankAward.allItem.ownItem = {};
	for i = 1, 8 do
		control.listOwnAward[i] = {};
		local ownAward = control.listOwnAward[i];
		ownAward.objRoot = control.objOwnAward:get_child_by_name("small_card_item"..i);
	end
	control.btnGetAward = ngui.find_button(control.objOwnAward, "btn_get");
	control.btnGetAward:set_on_click("CommonRankAward.OnClose");
	--更新
	CommonRankAward.UpdateUi();
end

function CommonRankAward.UpdateUi()
	if CommonRankAward.ui == nil then
		return;
	end
	--app.log(table.tostring(CommonRankAward));
	local data = CommonRankAward.data;
	local control = CommonRankAward.uiControl;
	--击杀奖励
	if type(data.kill) == "table" then
		control.objKill:set_active(true);
		if data.kill.name then
			control.labKillName:set_text(data.kill.name);
		else
			control.labKillName:set_text("");
		end
		if data.kill.str then
			control.labKill:set_text(tostring(data.kill.str));
		else
			control.labKill:set_text("");
		end
		if type(data.kill.award) == "table" then
			control.listKill.objRoot:set_active(true);
			for i = 1, 3 do 
				local award = data.kill.award[i];
				if award then
					local temp = CommonRankAward.allItem.killItem[i];
					if temp == nil then
						if PropsEnum.IsRole(award.id) then
							temp = SmallCardUi:new();
						else
							temp = UiSmallItem:new();
						end
						temp:SetParent(control.listKill["objGood"..i]);
						CommonRankAward.allItem.killItem[i] = temp;
					end
					temp:SetDataNumber(award.id, award.count);
				else
					control.listKill["objGood"..i]:set_active(false);
				end
			end
		else
			control.listKill.objRoot:set_active(false);
		end
	else
		control.objKill:set_active(false);
	end
	--排行奖励
	if type(data.rankAward) == "table" then
		control.objRank:set_active(true);
		control.wrapRank:set_min_index(1 - #data.rankAward);
		control.wrapRank:set_max_index(0);
		control.wrapRank:reset();
		control.viewRank:reset_position();
	else
		control.objRank:set_active(false);
	end
	--自己所获得奖励
	if type(data.ownAward) == "table" then
		control.objOwnAward:set_active(true);
		control.labHurt:set_text(tostring(data.ownAward.hurtStr));
		control.labRank:set_text(tostring(data.ownAward.rankStr));
		--头像
		PublicFunc.SetPlayerImage(CommonRankAward.textureList["textureHuman"], data.ownAward.image, 3);
		--奖励
		if type(data.ownAward.award) == "table" then
			for i = 1, 8 do
				local ownAward = control.listOwnAward[i];
				if data.ownAward.award[i] then
					local award = data.ownAward.award[i];
					ownAward.objRoot:set_active(true);
					local temp = CommonRankAward.allItem.ownItem[i];
					if temp == nil then
						if PropsEnum.IsRole(award.id) then
							temp = SmallCardUi:new();
						else
							temp = UiSmallItem:new();
						end
						temp:SetParent(ownAward.objRoot);
						CommonRankAward.allItem.ownItem[i] = temp;
					end
					temp:SetDataNumber(award.id, award.count);
				else
					ownAward.objRoot:set_active(false);
				end
			end
		end
	else
		control.objOwnAward:set_active(false);
	end
end

function CommonRankAward.OnClose(t)
	local control = CommonRankAward.uiControl;
	--特殊情况先回调 因为这可能牵扯到衔接动画
	local oldCallback = CommonRankAward.callbackFunc;
	local oldCallObj = CommonRankAward.callbackObj;
	if CommonRankAward.callbackFunc then
		CommonRankAward.callbackFunc(CommonRankAward.callbackObj);
	end
	if oldCallback == CommonRankAward.callbackFunc and oldCallObj == CommonRankAward.callbackObj then
		CommonRankAward.callbackFunc = nil;
		CommonRankAward.callbackObj = nil;
	end
	CommonRankAward.Destroy();
end

function CommonRankAward.Destroy()
	--外部数据相关
	if CommonRankAward.data then
		for k, v in pairs(CommonRankAward.data) do
			CommonRankAward.data[k] = nil;
		end
		CommonRankAward.data = nil;
	end
	--ui相关
	for k, v in pairs(CommonRankAward.allItem.killItem) do
		v:DestroyUi();
	end
	CommonRankAward.allItem.killItem = {};
	for k, v in pairs(CommonRankAward.allItem.ownItem) do
		v:DestroyUi();
	end
	CommonRankAward.allItem.ownItem = {};
	for k, v in pairs(CommonRankAward.allItem.rankItem) do
		for m, n in pairs(v.awardItem) do
			n:DestroyUi();
		end
	end
	CommonRankAward.allItem.rankItem.awardItem = {};
	if CommonRankAward.ui then
		CommonRankAward.ui:set_active(false);
		CommonRankAward.ui = nil;
	end
	CommonRankAward.uiControl = nil;
	CommonRankAward.allItem = {};
	--内部变量相关
	for k, v in pairs(CommonRankAward.textureList) do
		v:Destroy();
		CommonRankAward.textureList[k] = nil;
	end
	for k, v in pairs(CommonRankAward.btnList) do
		if type(k) == "number" then
			for m, n in pairs(v) do
				delete(v);
			end
		else
			delete(v)
		end
	end
	CommonRankAward.btnList = nil;
end

function CommonRankAward.OnInitItem(obj, b, real_id)
	local index = math.abs(real_id) + 1;
	local data = CommonRankAward.data.rankAward;
	if not data or not data[index] then
		return;
	end
	--app.log("obj="..tostring(obj:get_name()).." b="..tostring(b).." real_id="..tostring(real_id));

	local objIndex = tonumber(string.sub(obj:get_name(), -1));
	--名次
	CommonRankAward.allItem.rankItem = CommonRankAward.allItem.rankItem or {};
	local temp = CommonRankAward.allItem.rankItem[b];
	if temp == nil then
		temp = {};
		temp.objTitle = obj:get_child_by_name("rank_cont");
		temp.labTitle = ngui.find_label(temp.objTitle, "lab_ranking");
		temp.spTitle = ngui.find_sprite(temp.objTitle, "sp_under_kill");
		temp.btnName1 = ngui.find_button(obj, "btn_name1");
		temp.btnName2 = ngui.find_button(obj, "btn_name2");
		temp.labName1 = ngui.find_label(temp.btnName1:get_game_object(), "lab_name");
		temp.labName2 = ngui.find_label(temp.btnName2:get_game_object(), "lab_name");
		for i = 1, 3 do
			temp.objRoot = temp.objRoot or {};
			temp.objRoot[i] = obj:get_child_by_name("small_card_item"..i);
		end
		temp.awardItem = {};
		CommonRankAward.allItem.rankItem[b] = temp;
	end
	local objTitle = temp.objTitle
	local labTitle = temp.labTitle
	local spTitle = temp.spTitle
	if index > 3 then
		spTitle:set_active(false);
		labTitle:set_text("NO."..tostring(index));
	else
		spTitle:set_active(true);
		spTitle:set_sprite_name("sjb_b"..index);
		labTitle:set_text("");
	end
	
	--名字
	local btnName1 = temp.btnName1
	local btnName2 = temp.btnName2
	
	local labName = temp.labName1
	if data[index].name == g_dataCenter.player.name then
		btnName1:set_active(false);
		btnName2:set_active(true);
		labName = temp.labName2;
	else
		btnName1:set_active(true);
		btnName2:set_active(false);
		labName = temp.labName1;
	end
	
	labName:set_text(tostring(data[index].name));
	--奖励
	for i = 1, 3 do
		local objRoot = temp.objRoot[i]
		if type(data[index].award[i]) == "table" then
			local awardInfo = data[index].award[i];
			if temp.awardItem[i] == nil then
				if PropsEnum.IsRole(awardInfo.id) then
					temp.awardItem[i] = SmallCardUi:new();
				else
					temp.awardItem[i] = UiSmallItem:new();
				end
				temp.awardItem[i]:SetParent(objRoot);
			end
			temp.awardItem[i]:SetDataNumber(awardInfo.id, awardInfo.count);
		else
			objRoot:set_active(false);
		end
	end
	
end

]]
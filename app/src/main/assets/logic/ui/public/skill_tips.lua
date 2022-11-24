-- require "class"

SkillTips = 
{
	--isShow = true,
	--showX = 0,
	--showY = 0,
	--skillid = 0,
}
local _lab = {
	[1] = "等级:";
	[2] = "类型:";
	[3] = "主动技能";
	[4] = "被动技能";
}
--------------------------------外部接口--------------------------------------
--开关一个tip
--show 是否显示
--skillid 技能id
--atk_power 攻击力
--x,y 显示位置 当前对象所在位置
--delay 延迟时间
function SkillTips.EnableSkillTips(show, skillid, skilllevel, atk_power, x, y, delay, role_id, skill_type, showSimpleDes)
	--app.log("x="..tostring(x).." y="..tostring(y))
	SkillTips.isShow = show;
	if show then
		SkillTips.skillid = skillid;
        SkillTips.skilllevel = skilllevel;
		SkillTips.atk_power = atk_power;
		SkillTips.skillType = skill_type or 0;
		SkillTips.role_id = role_id;
		SkillTips.showSimpleDes = showSimpleDes;
		--获取当前屏幕宽高
		local curWidth = app.get_screen_width();
		local curHeight = app.get_screen_height();
		SkillTips.showX = x / curWidth * 1280;
		SkillTips.showY = y / curHeight * 720;
		if delay == 0 or delay == nil then
			SkillTips.Init();
		else
			if SkillTips.timerState then
				timer.stop(SkillTips.timerState)
			end
			SkillTips.timerState = timer.create("SkillTips.DelayInit", delay, 1);
		end
    else
        SkillTips.Show(show);
	end
end

----------------------------------------------------内部使用-------------------------------------------
-- local pathRes = "assetbundles/prefabs/ui/public/content_skill_tips.assetbundle"
local pathRes = "assetbundles/prefabs/ui/public/content_skill_item.assetbundle"
function SkillTips.Init()
	if SkillTips.ui == nil then
		SkillTips.LoadAsset();
	else
		SkillTips.UpdateShow();
	end
end

function SkillTips.DelayInit()
    if SkillTips.isShow then
	    SkillTips.Init();
    end
end

function SkillTips.LoadAsset()
    ResourceLoader.LoadAsset(pathRes, SkillTips.OnLoaded);
end

function SkillTips.OnLoaded(pid, filepath, asset_obj, error_info)
	if filepath == pathRes then
		SkillTips.InitUi(asset_obj)
	end
end

function SkillTips.Destroy()
	SkillTips.ui = nil;
	SkillTips.isShow = false;
	SkillTips.showX = 0;
	SkillTips.showY = 0;
	SkillTips.skillid = 0;
    SkillTips.skilllevel = 0;
	if SkillTips.controlList then
		for k, v in pairs(SkillTips.controlList) do
			SkillTips.controlList[k] = nil;
		end
	end
	SkillTips.controlList = {};
end

function SkillTips.InitUi(asset_obj)
	SkillTips.ui = asset_game_object.create(asset_obj);
    SkillTips.ui:set_name("SkillTips");
    SkillTips.ui:set_parent(Root.get_root_ui_2d());
    SkillTips.ui:set_local_scale(1, 1, 1);
    SkillTips.ui:set_local_position(0, 0, 0);


    SkillTips.controlList = {};
    local list = SkillTips.controlList;

    list.btn_cha = ngui.find_button(SkillTips.ui, "btn_cha");
    if list.btn_cha then
    	list.btn_cha:set_active(false);
    end

    list.skill_icon = ngui.find_texture(SkillTips.ui, "cont_equip/sp_skill1/Texture");

    list.labRank = ngui.find_label(SkillTips.ui,"cont_equip/sp_skill1/lab");
    --技能名称
    list.labName = ngui.find_label(SkillTips.ui, "lab_name");
    --等级
    list.labLevel = ngui.find_label(SkillTips.ui, "lab_level");
    -- 类型
    list.labType = ngui.find_label(SkillTips.ui, "lab_type");
    --技能描述
    list.labDes = ngui.find_label(SkillTips.ui, "lab_describe");
    --获取界面宽高
    list.spDi = ngui.find_sprite(SkillTips.ui, "sp_di");
	list.diWidth = list.spDi:get_width();
    list.diHeight = 200; --list.spDi:get_height();
    
	SkillTips.UpdateShow();
end

--更新显示
function SkillTips.UpdateShow()
	local data = PublicFunc.GetSkillCfg(SkillTips.role_id, SkillTips.skillType, SkillTips.skillid);
	local list = SkillTips.controlList;
	if data == nil or SkillTips.ui == nil then
		return;
	end
    SkillTips.ui:set_active(SkillTips.isShow);
    --是否显示简要描述
    local simpleDes = nil;
    if SkillTips.showSimpleDes then
    	simpleDes = data.simple_describe;
    end
	--更新名字描述
	list.labName:set_text(tostring(data.name));
	if SkillTips.skillType == ENUM.SkillType.passive then
		list.labDes:set_text(tostring(PublicFunc.FormatPassiveSkillString(simpleDes,SkillTips.skillid,SkillTips.role_id,nil, SkillTips.skilllevel)));
		list.labType:set_text(_lab[2] .. _lab[4]);
	elseif SkillTips.skillType == ENUM.SkillType.halo then
		list.labDes:set_text(tostring(PublicFunc.FormatHaloSkillString(simpleDes,SkillTips.skillid,SkillTips.role_id,nil, SkillTips.skilllevel)));
		list.labType:set_text(_lab[2] .. _lab[4]);
	else
		list.labDes:set_text(tostring(PublicFunc.FormatSkillString(simpleDes, SkillTips.skillid, nil, SkillTips.skilllevel, SkillTips.atk_power)));
		list.labType:set_text(_lab[2] .. _lab[3]);
	end
	list.labLevel:set_text(_lab[1] .. SkillTips.skilllevel);
	if data.rank then
		list.labRank:set_text(PublicFunc.GetPassiveSkillRankText(data.rank));
	else
		list.labRank:set_text("");
	end

	list.skill_icon:set_texture(data.small_icon);

	--设置位置
	--设计屏幕当前宽高
	local curWidth = 1280;
	local halfWidth = curWidth * 0.5;
	local curHeight = 720;
	local halfHeight = curHeight * 0.5;
	--得到点击位置  在设计分辨率下的位置
	local showScreenX,showScreenY = SkillTips.showX, SkillTips.showY;
	--减去固定等距
	local fixDiff = 20;
	if showScreenX < halfWidth then
		showScreenX = showScreenX + fixDiff + list.diWidth * 0.5;
	else
		showScreenX = showScreenX - fixDiff - list.diWidth * 0.5;
	end
	if showScreenY < halfHeight then
		showScreenY = showScreenY + fixDiff + list.diHeight * 0.5;
	else
		showScreenY = showScreenY - fixDiff - list.diHeight * 0.5;
	end
	--将屏幕坐标转换为ui坐标
	local sp_x = showScreenX - halfWidth;
	local sp_y = showScreenY - halfHeight;
	SkillTips.ui:set_local_position(sp_x,  sp_y, 0);
end

function SkillTips.Show(show)
    show = show or false
	if SkillTips.ui then
		SkillTips.ui:set_active(show);
	end
end


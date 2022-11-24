AllSkillLevelUpUI = Class("AllSkillLevelUpUI", MultiResUiBaseClass);

local _instance = nil;
local _old_info = nil;
local _new_info = nil;
local _defRarity = nil;
local _old_power = 0;
local _new_power = 0;

function AllSkillLevelUpUI.InitInfo(old_info,new_info,old_power,new_power,defRarity)
	if old_info then
		_old_info = old_info;
	end
	if new_info then
		_new_info = new_info;
	end
	if old_power then
		_old_power = old_power;
	end
	if new_power then
		_new_power = new_power;
	end
	if defRarity then
		_defRarity = defRarity
	end
end

function AllSkillLevelUpUI.Start(old_info,new_info,old_power,new_power,defRarity)
	AllSkillLevelUpUI.InitInfo(old_info,new_info,old_power,new_power,defRarity);
	if _instance == nil then
		_instance = uiManager:PushUi(EUI.AllSkillLevelUpUI);
	end
end

function AllSkillLevelUpUI.SetFinishCallback(callback, obj)
	if _instance then
		_instance.callbackFunc = callback;
		if _instance.callbackFunc then
			_instance.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start"..debug.traceback());
	end
end

function AllSkillLevelUpUI.Destroy()
	if _instance then
		uiManager:RemoveUi(EUI.AllSkillLevelUpUI)
		_instance = nil;
		_old_info = nil;
		_new_info = nil;
		_defRarity = nil;
	end
end
--------------------内部接口-------------------------
local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = "assetbundles/prefabs/ui/new_fight/ui_826_fight.assetbundle";
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _uiText = 
{
	[1] = '点击屏幕任意位置关闭'
}

function AllSkillLevelUpUI:Init(data)
    self.pathRes = resPaths;
    MultiResUiBaseClass.Init(self, data);
end

function AllSkillLevelUpUI:RestartData()
    CommonClearing.canClose = false

    MultiResUiBaseClass.RestartData(self)
end

function AllSkillLevelUpUI:RegistFunc()
    MultiResUiBaseClass.RegistFunc(self);
    self.bindfunc["OnClose"] = Utility.bind_callback(self, self.OnClose);
end

function AllSkillLevelUpUI:InitedAllUI()
	local backui = self.uis[resPaths[resType.Back]]
	self.spBG = ngui.find_sprite(backui,"sp_di");
    local frontParentNode = backui:get_child_by_name("add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    self.ui:set_name("ui_826_fight");

	local markButton = ngui.find_button(backui, "mark")
	markButton:set_on_click(self.bindfunc["OnClose"],"MyButton.NoneAudio");
	local tipCloseLabel = ngui.find_label(backui, "txt")
	tipCloseLabel:set_text(_uiText[1])
	local spTitle = ngui.find_sprite(backui,"sp_art_font");
	spTitle:set_sprite_name("js_jinengshengji")

    self.grid = ngui.find_grid(self.ui,"grid");
    self.skillList = {};
    for i=1,8 do
    	self.skillList[i] = {};
    	self.skillList[i].obj = self.ui:get_child_by_name("grid/cont_skill"..i);
    	self.skillList[i].labOldLv = ngui.find_label(self.ui,"grid/cont_skill"..i.."/lab_level");
    	self.skillList[i].labNewLv = ngui.find_label(self.ui,"grid/cont_skill"..i.."/lab_level/lab");
    	self.skillList[i].tex = ngui.find_texture(self.ui,"grid/cont_skill"..i.."/Texture");
    	self.skillList[i].labName = ngui.find_label(self.ui,"grid/cont_skill"..i.."/lab_name");
    	self.skillList[i].sp = ngui.find_sprite(self.ui,"grid/cont_skill"..i.."/sp_art_font");
    end
    self.labOldFightPower = ngui.find_label(self.ui,"sp_fight/lab_fight");
    self.labNewFightPower = ngui.find_label(self.ui,"sp_fight/lab_num");

    self.offset = 0
    self.changeHeight = true
    self.showMoreInfo = false
    if  #_new_info > 8 then
        self.showMoreInfo = true
    end

    self:UpdateUi();
end

function AllSkillLevelUpUI:UpdateUi()
    if not MultiResUiBaseClass.UpdateUi(self) then
        return;
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
    local num = 0;
    for i= 1, 8 do
    	local new = _new_info[i + self.offset];
    	repeat
    		if new == nil then
				self.skillList[i].obj:set_active(false);
    			break;
    		end
	    	local id = new.id;
    		local old = self:GetOldSkill(id);
    		if old == nil then
				self.skillList[i].obj:set_active(false);
    			break;
    		end
	    	local ntype = new.ntype-1;
		    local skillData = PublicFunc.GetSkillCfg(_defRarity, ntype, id);
			if skillData == nil then
				self.skillList[i].obj:set_active(false);
				break;
			end
			num = num + 1;
			self.skillList[i].obj:set_active(true);
			self.skillList[i].labName:set_text(skillData.name);
			self.skillList[i].tex:set_texture(skillData.small_icon);
			self.skillList[i].labOldLv:set_text(tostring(old.level));
			self.skillList[i].labNewLv:set_text(tostring(new.level));
			-- self.skillList[i].sp:set_sprite_name(PublicFunc.GetPassiveSkillRankText(skillData.rank));
			if skillData.rank then
				self.skillList[i].sp:set_active(true)
				self.skillList[i].sp:set_sprite_name(PublicFunc.GetPassiveSkillRankText(skillData.rank));
			else
				self.skillList[i].sp:set_active(false)
			end
		until true
	end
    -- if self.changeHeight then
	--     if num <= 2 then
	-- 	    self.spBG:set_height(260);
	--     elseif num > 2 and num <= 4 then
	-- 	    self.spBG:set_height(360);
	--     elseif num > 4 and num <= 6 then
	-- 	    self.spBG:set_height(514);
	--     end
    -- end
	self.grid:reposition_now();
	self.labOldFightPower:set_text(tostring(_old_power));
	self.labNewFightPower:set_text(tostring(_new_power));
end

function AllSkillLevelUpUI:GetOldSkill(id)
	for k,v in pairs(_old_info) do
		if v.id == id then
			return v;
		end
	end
end

function AllSkillLevelUpUI:OnClose()

	if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    if self.showMoreInfo then
        self.showMoreInfo = false
        self.offset = 8     
        self.changeHeight = false   
        self:UpdateUi()
    else
	    AllSkillLevelUpUI.Destroy();
    end
end

function AllSkillLevelUpUI:DestroyUi()
    MultiResUiBaseClass.DestroyUi(self);
end
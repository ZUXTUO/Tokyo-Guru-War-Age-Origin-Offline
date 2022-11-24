--	file:	fetters_ui.lua
--	author: zzc
--	create: 2015-10-15
--	

FettersUI = Class("FettersUI",UiBaseClass);

local _localdata = {};

_localdata.UIText = {
	[1] = "详情",
	[2] = "加成",
	[3] = "下一级加成",
	[4] = "升级条件",
	[5] = "条件：获得[00ff00]%s[-]后激活",
	[6] = "条件：[00ff00]%s[-]达到%s星",
	[7] = "连协已达到最高等级",
	[8] = "连协未激活",
	[9] = "已达最高等级",
}

--[[ 根据初始英雄编号获取玩家拥有的对应英雄
参数：
	roleSet		玩家拥有的英雄集合
	initNumber	初始英雄编号
--]] 
function FettersUI.FindRoleByInitRarity(roleSet, initNumber)
	for k, v in pairs(roleSet) do
		if v.config.default_rarity == initNumber then
			return v;
		end
	end
end

--[[预留，初始化]]
function FettersUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/fetters/ui_1701_fetter.assetbundle";
    self:loadData(data)
	UiBaseClass.Init(self, data);
end

--[[初始化内部变量]]
function FettersUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

-- 界面加载前加载card数据
function FettersUI:loadData(info)
	self.roleData = info;

	local roleSet = g_dataCenter.package:GetCard(ENUM.EPackageType.Hero);
	local roleInitNum = self.roleData.config.default_rarity;
	local fettersData = {};
	for k, v in pairs(ConfigManager.Get(EConfigIndex.t_fetters,roleInitNum) or {}) do
		-- 增加开关控制显示项
		if v.enable == 1 then
			-- 是否已经拥有羁绊的英雄
			local role = FettersUI.FindRoleByInitRarity(roleSet, v.fetters_id);
			if role then
				table.insert(fettersData, {id=role.number, star=role.rarity, config=v});
			else
				table.insert(fettersData, {id=v.fetters_id, star=0, config=v});
			end
		end
	end

	self.fettersData = fettersData;
end

--[[注册回调方法]]
function FettersUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_role_click"] = Utility.bind_callback(self, FettersUI.on_role_click);
	self.bindfunc["on_close"] = Utility.bind_callback(self, FettersUI.on_close);
	self.bindfunc["on_rule_btn"] = Utility.bind_callback(self, FettersUI.on_rule_btn);
end

-- 切换了选中的羁绊对象
function FettersUI:on_role_click(t)
	local index = t.float_value - 1;
	for i=1,6 do
		self.roleSpArr[i].shine:set_active(false);
	end
	self:Refresh(index);
end

--[[初始化界面]]
function FettersUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self,asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_fetters");

	local btnClose = ngui.find_button(self.ui,"centre_other/animation/btn_fork");
	btnClose:set_on_click(self.bindfunc["on_close"]);

	local btnRule = ngui.find_button(self.ui, "top_other/animation/panel/btn_rule")
	btnRule:set_on_click(self.bindfunc["on_rule_btn"])

	local leftPath = "centre_other/animation/left_content/anmition/";
	local rightPath = "centre_other/right_content/";

	self.lab_des = ngui.find_label(self.ui, rightPath .. "sp_title1/lab_word");
	self.lab_title = ngui.find_label(self.ui, rightPath .. "sp_title1/txt_title");
	self.lab_plus1 = ngui.find_label(self.ui, rightPath .. "sp_title2/word_content/lab_word1");
	self.lab_plus2 = ngui.find_label(self.ui, rightPath .. "sp_title2/word_content/lab_word2");
	self.lab_plus_no = ngui.find_label(self.ui, rightPath .. "sp_title2/lab_not_activate");
	self.lab_next_plus1 = ngui.find_label(self.ui, rightPath .. "sp_title3/word_content/lab_word1");
	self.lab_next_plus2 = ngui.find_label(self.ui, rightPath .. "sp_title3/word_content/lab_word2");
	self.lab_next_plus_no = ngui.find_label(self.ui, rightPath .. "sp_title3/lab_not_activate");
	self.lab_up_condition = ngui.find_label(self.ui, rightPath .. "lab_tiao_jian");

	self.lab_plus_no:set_text(_localdata.UIText[8])
	self.lab_next_plus_no:set_text(_localdata.UIText[9])
	self.lab_title:set_text(_localdata.UIText[1])

	local roleSpArr = {};
	for i = 1, 6 do
		local btnPath = leftPath .. "btn_frame" .. i;
		if i ~= 1 then
			local roleBtn = ngui.find_button(self.ui, btnPath);
			-- roleBtn = ngui.find_button(self.ui, leftPath .. "btn_frame" .. i);
			roleBtn:set_on_click(self.bindfunc["on_role_click"]);
			roleBtn:set_event_value("", i);
		end

		roleSpArr[i] = {};
		roleSpArr[i].frame = ngui.find_sprite(self.ui, btnPath .. "/sp_di/sp_frame");
		roleSpArr[i].icon = ngui.find_sprite(self.ui, btnPath .. "/sp_di/sp_human");
		roleSpArr[i].shine = ngui.find_sprite(self.ui, btnPath .. "/sp_di/sp_red_frame");
		roleSpArr[i].shine:set_active(false);
		roleSpArr[i].sp = ngui.find_sprite(self.ui, btnPath .. "/sp_red_mark");
		roleSpArr[i].star = {};
		for j = 1, 5 do
			roleSpArr[i].star[j] = ngui.find_sprite(self.ui, btnPath .. "/sp_di/contain_star/sp_star" .. j .. "/sp");
			roleSpArr[i].star[j]:set_active(false);
		end
		
		if i > 1 then
			roleSpArr[i].mask = ngui.find_sprite(self.ui, btnPath .. "/mask");
		end
	end

	-- 刷新左侧界面
	for i = 1, 6 do
		local star = 0;
		local icon = nil;
		if i == 1 then
			star = self.roleData.rarity;
			icon = self.roleData.config.small_icon;
		else
			local data = self.fettersData[i -1];
			if data then
				star = data.star;
				icon = ConfigHelper.GetRole(data.id).small_icon;
			end
		end
		-- 加载遮罩层
		if roleSpArr[i].mask then
			roleSpArr[i].mask:set_active(star == 0);
		end
		if roleSpArr[i].sp then
			roleSpArr[i].sp:set_active(star == 0);
		end
		for j = 1, star do
			roleSpArr[i].star[j]:set_active(true);
		end
		-- 加载icon，加载边框
		if icon then
			PublicFunc.Set120Icon(roleSpArr[i].icon, icon)
		end
	end

	self.roleSpArr = roleSpArr;	-- 使用了图集，保存引用

	self:Refresh(1);

end

-- 刷新所有属性
function FettersUI:Refresh(index)
	if self.ui == nil then return end;
	if index == nil or index < 1 then return end

	-- 刷新右侧界面
	local data = self.fettersData[index];
	if data then
		self.roleSpArr[index+1].shine:set_active(true);
		-- 详情说明（随机出现一句）
		local desStr = "";
		if type(data.config.des) == "string" then
			desStr = data.config.des;
		elseif type(data.config.des) == "table" then
			desStr = data.config.des[math.random(1, #data.config.des)] or "";
		end
		self.lab_des:set_text(desStr);
		-- self.lab_title:set_text(_localdata.UIText[1])
		
		-- 当前加成
		if data.star == 0 then
			self.lab_plus_no:set_active(true);
			self.lab_plus1:set_active(false);
			self.lab_plus2:set_active(false);
		else
			self.lab_plus_no:set_active(false);
			self.lab_plus1:set_active(true);
			self.lab_plus2:set_active(true);

			local plusStr = {};
			local prefix = nil;
			for k, v in pairs(data.config) do
				if type(v) == "table" and k ~= "des" then
					prefix = gs_string_property_name[ENUM.EHeroAttribute[k]] or "";
					table.insert(plusStr, 
						prefix .. "[00ff00]+" .. v["star" .. data.star] * 100 .. "%[-]");
				end
			end
			for i = 1, 2 do
				self['lab_plus' .. i]:set_text( plusStr[i] or "" );
			end
		end
		
		-- 下一级加成
		if data.star < 5 then
			self.lab_next_plus_no:set_active(false);
			self.lab_next_plus1:set_active(true);
			self.lab_next_plus2:set_active(true);
			local plusStr = {};
			local prefix = nil;
			for k, v in pairs(data.config) do
				if type(v) == "table" and k ~= "des" then
					prefix = gs_string_property_name[ENUM.EHeroAttribute[k]] or "";
					table.insert(plusStr, 
						prefix .. "[00ff00]+" .. v["star" .. (data.star+1)] * 100 .. "%[-]");
				end
			end
			for i = 1, 2 do
				self['lab_next_plus' .. i]:set_text( plusStr[i] or "" );
			end
		else
			self.lab_next_plus_no:set_active(true);
			self.lab_next_plus1:set_active(false);
			self.lab_next_plus2:set_active(false);
		end

		local config = ConfigHelper.GetRole(data.id);
		-- 升级条件
		if data.star == 0 then
			self.lab_up_condition:set_text(string.format(_localdata.UIText[5], config.name));
		elseif data.star < 5 then
			self.lab_up_condition:set_text(string.format(_localdata.UIText[6], config.name, data.star+1));
		else
			self.lab_up_condition:set_text(_localdata.UIText[7]);
		end
	-- 不显示文本
	else
		self.lab_des:set_text("");
		self.lab_plus_no:set_active(false);
		self.lab_plus1:set_active(false);
		self.lab_plus2:set_active(false);
		self.lab_next_plus_no:set_active(false);
		self.lab_next_plus1:set_active(false);
		self.lab_next_plus2:set_active(false);
		self.lab_up_condition:set_text("")
	end
end

function FettersUI:on_close()
	uiManager:PopUi();
end

function FettersUI:on_rule_btn()
	UiRuleDes.Start(ENUM.ERuleDesType.LianXie)
end

--[[预留，恢复]]
function FettersUI:Restart(data)
	-- 先加载数据
	self:loadData(data)
	UiBaseClass.Restart(self,data);
end

--[[预留，进战斗后删除调用]]
function FettersUI:DestroyUi()
    if self.ui ~= nil then
		self.lab_des = nil;
		self.lab_plus1 = nil;
		self.lab_plus2 = nil;
		self.lab_plus_no = nil;
		self.lab_next_plus1 = nil;
		self.lab_next_plus2 = nil;
		self.lab_next_plus_no = nil;
		self.lab_up_condition = nil;

		self.roleData = nil;
		self.fettersData = nil;
	end
	UiBaseClass.DestroyUi(self);
end
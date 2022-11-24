--保卫喰场战斗界面
UiFightBaoWeiCanChang = Class('UiFightBaoWeiCanChang', UiBaseClass);

-----------------外部接口---------------------------------
--显示保卫喰场战斗界面
function UiFightBaoWeiCanChang.Start(isHurdle)
	if isHurdle == nil then
		isHurdle = false
	end
	if(not UiFightBaoWeiCanChang.fightUi)then
		UiFightBaoWeiCanChang.fightUi = UiFightBaoWeiCanChang:new();
	else
		UiFightBaoWeiCanChang.fightUi:Show();
	end

	UiFightBaoWeiCanChang.fightUi:SetIsHurdle(isHurdle)
end

--param:data = {score = xxx, killMonster = xxx}
function UiFightBaoWeiCanChang.SetData(data)
	if not UiFightBaoWeiCanChang.fightUi then return end
	UiFightBaoWeiCanChang.fightUi.oldScore = data.oldScore
	UiFightBaoWeiCanChang.fightUi.score = data.score;
	UiFightBaoWeiCanChang.fightUi.killMonster = data.killMonster;
	UiFightBaoWeiCanChang.fightUi.escapeMonster = data.escapeMonster;
	UiFightBaoWeiCanChang.fightUi.ObjName = data.ObjName
	UiFightBaoWeiCanChang.fightUi:UpdateUi();
end

--摧毁战斗界面
function UiFightBaoWeiCanChang.DestroyFightUi()
	if(UiFightBaoWeiCanChang.fightUi)then
		UiFightBaoWeiCanChang.fightUi:DestroyUi();
		UiFightBaoWeiCanChang.fightUi = nil;
	end
end

-----------------内部接口---------------------------------

local uiText = 
{
	[1] ='[00C0FFFF]总分[-] %d',
}

local goldAnimations = 
{
	{aniName = "goldcoin01", dummyNode = "goldcoin_position01"},
	{aniName = "goldcoin02", dummyNode = "goldcoin_position02"},
	{aniName = "goldcoin03", dummyNode = "goldcoin_position03"}
}

function UiFightBaoWeiCanChang:SetIsHurdle(is)
	self._isHurdle = is

	if self.ui and self._isHurdle then
		self:Hide()
		local optionTipCom = GetMainUI():GetOptionTipUI()
		if optionTipCom then
			optionTipCom:ShowGaoSuJuJiInfo()
		end
	end
end

function UiFightBaoWeiCanChang:Init(data)
	self.pathRes = 'assetbundles/prefabs/ui/wanfa/defense_house/ui_1003_bao_wei_can_chang.assetbundle';
    UiBaseClass.Init(self, data);
end

function UiFightBaoWeiCanChang:Restart(data)
    UiBaseClass.Restart(self, data);
end

function UiFightBaoWeiCanChang:InitData(data)
	UiBaseClass.InitData(self, data);

	self.score = 0
	self.oldScore = 0
	self.killMonster = 0
	self.escapeMonster = 0
	--self.hasShowGoldNum = 0
end

--析构函数
function UiFightBaoWeiCanChang:DestroyUi()

	self._isHurdle = nil

    UiBaseClass.DestroyUi(self);
end


function UiFightBaoWeiCanChang:RegistFunc()
	UiBaseClass.RegistFunc(self);
end

--注册消息分发回调函数
function UiFightBaoWeiCanChang:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiFightBaoWeiCanChang:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

function UiFightBaoWeiCanChang:LoadUI()
	UiBaseClass.LoadUI(self);
end

function UiFightBaoWeiCanChang:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj);
	self.ui:set_parent(Root.get_root_ui_2d_fight());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_fight_bao_wei_can_chang");
	
	--do return end
	---------------------按钮及回调事件绑定------------------------
	
	self.labScore = ngui.find_label(self.ui,"defense_house/txt_score");
	self.labScore:set_text(string.format(uiText[1], 0));
	
	self.labSkillMonster = ngui.find_label(self.ui,"defense_house/lab_kill");
	self.labSkillMonster:set_text(tostring(0));

	local parentWidget = ngui.find_widget(self.ui, "defense_house")
	local bx, by, bz = parentWidget:get_position()
	local cx, cy, cz = self.labScore:get_position()

	self.animationNode = self.ui:get_child_by_name("defense_house")

	self.targetPos = {x = bx + cx, y = by + cy, z = bz + cz}
	
	-- self.labEscapeMonster = ngui.find_label(self.ui,"defense_house/lab_escape");
	-- self.labEscapeMonster:set_text(tostring(0));

	self.goldProp = g_dataCenter.activity[MsgEnum.eactivity_time.eActivityTime_baoWeiCanChang]:GetGoldProb()

	self:SetIsHurdle(self._isHurdle)
	
	self:UpdateUi();
end

function UiFightBaoWeiCanChang:UpdateUi()
	if self.ui then
		--if self.score and self.killMonster then
			if self._isHurdle then
				local optionTipCom = GetMainUI():GetOptionTipUI()
				if optionTipCom then
					optionTipCom:UpdateGaoSuJuJiInfo(self.score, self.killMonster, self.escapeMonster)
				end
			else
				--self.labScore:set_text(tostring(self.score));
				local oldGold = math.floor(self.goldProp * self.oldScore)
				local gold = math.floor(self.goldProp * self.score)
				--app.log("#hyg# gaosujuji score = " .. tostring(self.score) .. ' ' .. tostring(self.goldProportion) .. ' ' .. tostring(gold))
				self.labScore:set_text(tostring(gold))
				self.labSkillMonster:set_text(tostring(self.killMonster));
				if gold > oldGold then
					self.PlayObtainGoldEffect(oldGold, gold)
				end
			end
		--end
	end
end

function UiFightBaoWeiCanChang.PlayObtainGoldEffect(old, new)

	local self = UiFightBaoWeiCanChang.fightUi
	if self == nil then return end
	
	self.labScore:set_text(tostring(old))

	local objName = self.ObjName
	local obj = GetObj(objName)
	if obj == nil then return end

	local captain = FightManager.GetMyCaptain()
	if captain == nil then return end

	local diff = new - old
	if diff < 1 then return end

	local showNums = 6
	if obj.config.type > ENUM.EMonsterType.SoldierRnage then
		showNums = 10
	end

	if showNums > diff then
		showNums = diff
	end

	local orix, oriy, oriz = obj:GetPositionXYZ()

	local onceNum = math.floor(diff/showNums)
	for i = 1, showNums do
		local currentNum = 0
		if i < showNums then
			currentNum = old + i * onceNum
		else
			currentNum = new
		end

		OGM.GetGameObject("assetbundles/prefabs/fx/fx_scene/fx_goldcoin01/fx_goldcoin01.assetbundle", function(gObject)

			local obj_Id = gObject:GetId()
			local go = gObject:GetGameObject()

			go:set_position(orix, oriy, oriz)

			local angle = math.random(0, 360)
			go:set_local_rotation(0, angle, 0)

			local aniInfo = goldAnimations[math.random(1, #goldAnimations)]
			local aniNode = go:get_child_by_name("goldcoin")
			aniNode:animated_play(aniInfo.aniName)

			TimerManager.Add( function ()

				local gObject = OGM.GetGObject(obj_Id)
				if gObject  == nil then return end
				local go = gObject:GetGameObject()				

				local dummyNode = go:get_child_by_name(aniInfo.dummyNode)
				local dummyX, dummyY, dummZ = dummyNode:get_local_position()
				local qx,qy,qz,qw = util.quaternion_euler(0, angle, 0)
				dummyX, dummyY, dummZ = util.quaternion_multiply_v3(qx,qy,qz,qw, dummyX, dummyY, dummZ)

				Tween.addTween(go, 0.6, {}, Transitions.EASE_IN, 0, nil,
				function(progress)

					local gObject = OGM.GetGObject(obj_Id)
					if gObject  == nil then return end
					local go = gObject:GetGameObject()

					local captain = FightManager.GetMyCaptain()
					if captain == nil then return end

					local cx, cy, cz = captain:GetPositionXYZ()
					cy = cy + 1
					cx, cy, cz = cx - dummyX, cy - dummyY, cz - dummZ

					go:set_position(
						algorthm.NumberLerp(orix, cx, progress), 
						algorthm.NumberLerp(oriy, cy, progress), 
						algorthm.NumberLerp(oriz, cz, progress))
				end,
				function(progress)
					OGM.UnUse(obj_Id)

					local self = UiFightBaoWeiCanChang.fightUi
					if self then
						self.labScore:set_text(tostring(currentNum))
						
						--self.animationNode:animated_stop("new_fight_ui_xiao_chou1")
						self.animationNode:animated_play("ui_1003_bao_wei_can_chang_defense_house")
					end
				end
				)
			end
			, 1200, 1)

		end, 1)

	end
	
end

RoleUpexpUI = Class("RoleUpexpUI", UiBaseClass);
RoleUpexpUI.PRESS_TIME = 0.3

local _local = { }
_local.UIText = {
	[1] = "英雄等级不能超过玩家等级",
	[2] = "经验药水不足！",
	[4] = "使用药水将达到最大等级经验值，是否继续？",
	[5] = "确定",
	[6] = "取消",
	[7] = "购买需要战队等级达到%s级",
	[8] = "购买成功",
}

function RoleUpexpUI:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/package/ui_602_level_up.assetbundle";
	UiBaseClass.Init(self, data);
end

function RoleUpexpUI:InitData(data)
	UiBaseClass.InitData(self, data);
	if data == nil then return end;

	self.loaded_callback = data.loaded_callback
 
	if data.info then self.roleData = data.info end
	 
	self.level_up_fx_objs = { }

	self.expCfg = { IdConfig.ExpMedi1, IdConfig.ExpMedi2, IdConfig.ExpMedi3, IdConfig.ExpMedi4, IdConfig.ExpMedi5, IdConfig.ExpMedi6 };
	self.expData = { };
	for i = 1, 6 do
		local item = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item, self.expCfg[i]) or { };
		self.expData[self.expCfg[i]] = { id = item.index or 0, cfgId = self.expCfg[i], have = item.count or 0, use = 0, info = item };
	end

	local config = CardHuman.GetLevelConfig(self.roleData.number, self.roleData.level, self.roleData.config);
	self.temp_level = self.roleData.level;
	self.curr_exp = tonumber(self.roleData.cur_exp) or 0;

	-- 当前等级
	self.curr_temp_level = self.roleData.level
	self.need_update_ui = false
	-- t = { curr_exp = 0,up_exp = 100,lv = 10}
	self.up_level_log = { }
	self.hero_upe_level_log = Queue:new()
	self.eat_all_exp = 0
	self.last_eat_time = 0
	self.press_begin_time = 0
	self.use_count = 0
	-- animation
	self.duration = 0.15;
	self.times = 0;
	self.time = 0;
	self.is_runall = false;
end

function RoleUpexpUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
		--self:InitData(data)
		--self:UpdateUi()
	end
end

function RoleUpexpUI:LoadData(data)
	if data then
		self.roleData = data.info
	end
end

-- 切换英雄，保存数据
function RoleUpexpUI:SetInfo(info, isPlayer)
	if info == nil then
		return
	end
	self:LoadData( { info = info })
	self:UpdateUi()
	--避免切换英雄时动画还在播放
	self.hero_upe_level_log:clear()
end

function RoleUpexpUI:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close);
	self.bindfunc["OnBuyItem"] = Utility.bind_callback(self, self.OnBuyItem);
	self.bindfunc["on_btn_add"] = Utility.bind_callback(self, self.on_btn_add)
	self.bindfunc["OnEatExp"] = Utility.bind_callback(self, self.OnEatExp)
	self.bindfunc["OnBtnExpUpOneStep"] = Utility.bind_callback(self, self.OnBtnExpUpOneStep)
	self.bindfunc["on_send_buy_item"]  = Utility.bind_callback(self,self.on_send_buy_item)
    self.bindfunc["on_level_up_key"]  = Utility.bind_callback(self,self.on_level_up_key)
	self.bindfunc["UpdateUi"] = Utility.bind_callback(self, self.UpdateUi)
end

function RoleUpexpUI:MsgRegist()
	UiBaseClass.MsgRegist(self)
	PublicFunc.msg_regist(msg_cards.gc_eat_exp, self.bindfunc["OnEatExp"])
	PublicFunc.msg_regist(player.gc_buy_item, self.bindfunc["OnBuyItem"])
end

function RoleUpexpUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self)
	PublicFunc.msg_unregist(msg_cards.gc_eat_exp, self.bindfunc["OnEatExp"])
	PublicFunc.msg_unregist(player.gc_buy_item, self.bindfunc["OnBuyItem"])
end

function RoleUpexpUI:SetCardInfo(tUserdata, tInfo)
	local lbl_name = tUserdata.lbl_name
	local sp_nature = tUserdata.sp_nature
	local sp_type_di = tUserdata.sp_type_di
	local sp_type = tUserdata.sp_type
	local sp_zhiye = tUserdata.sp_zhiye
	local lbl_zhiye = tUserdata.lbl_zhiye
	if lbl_name then
		lbl_name:set_text(tInfo.name)
	end
	if sp_nature then
		PublicFunc.SetAptitudeSprite(sp_nature, tInfo.rarity);
	end
	if sp_type_di then
		PublicFunc.SetRestraintSprite(sp_type_di, tInfo.config.restraint);
	end
	if sp_type then
		PublicFunc.SetRestraintSpriteBk(sp_type, tInfo.config.restraint);
	end
	if sp_zhiye then
		PublicFunc.SetProTypePic(sp_zhiye, tInfo.pro_type, 3)
	end
	if lbl_zhiye then
		PublicFunc.SetProType(lbl_zhiye, tInfo.pro_type);
	end
end

function RoleUpexpUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("role_up_exp_ui");

    --一键升级
    self.btnLevelUpKey = ngui.find_button(self.ui, "centre_other/animation/btn")
    self.btnLevelUpKey:set_on_click(self.bindfunc["on_level_up_key"])
    self.objTopEffect = self.ui:get_child_by_name("centre_other/animation/sp_effect")
 
	self.lbl_eat_count = ngui.find_label(self.ui, "centre_other/animation/ainimation_num/lab")
	self.lbl_eat_count:set_text("")
	self.lbl_exp = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/pro_di/lab_num")
    self.objEffectExp = self.ui:get_child_by_name("centre_other/animation/sp_bk1/pro_di/fx_ui_602_level_up")
    self.objEffectExp:set_active(false)

	self.pro_exp = ngui.find_progress_bar(self.ui, "centre_other/animation/sp_bk1/pro_di")
	--self.btn_level_up = ngui.find_button(self.ui, "centre_other/animation/btn")
	--self.btn_level_up:set_on_click(self.bindfunc["OnBtnExpUpOneStep"])
	self.lbl_level = ngui.find_label(self.ui, "centre_other/animation/sp_bk1/lab_num")
	--PublicFunc.SetUILabelGreen(self.lbl_level)

	--[[self.labFightValue = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/content1/sp_bk/lab_fight")
	self.labAttactValue = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/content2/sp_bk/lab_fight")
	self.labDefenceValue = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/content3/sp_bk/lab_fight")
	self.labMaxHpValue = ngui.find_label(self.ui, "centre_other/animation/sp_bk2/content4/sp_bk/lab_fight")]]

	self.ui_exps = self.ui_exps or { }
	local index = 1

	local funcSort = function(A, B) return A < B end
	
	for k, v in pairs_key(self.expData, funcSort) do
		self.ui_exps[k] = {
			item = self.ui:get_child_by_name("centre_other/animation/sp_bk2/sp_di" .. index .. "/new_small_card_item"),
			lbl_exp = ngui.find_label(self.ui,"centre_other/animation/sp_bk2/sp_di" .. index .. "/lab_num"),
			fx = self.ui:get_child_by_name("centre_other/animation/sp_bk2/sp_di" .. index .. "/fx_ui_602_level_up_xiaohaocailiao"),
		}
		self.ui_exps[k].fx:set_active(false)
		index = index + 1
		local expData = v
		local cfg = ConfigManager.Get(EConfigIndex.t_item, expData.cfgId)
		self.ui_exps[k].lbl_exp:set_text("Exp" .. PublicFunc.GetColorText('+' ..tostring(cfg.exp or 0), "new_green"))
		self.ui_exps[k].item_info = UiSmallItem:new( {
			parent = self.ui_exps[k].item,
			info = CardProp:new( { number = expData.cfgId, }),
			load_callback = function(obj)
				obj:SetBtnAdd(self.expData[obj.cardInfo.number].have <= 0, self.bindfunc["on_btn_add"], "", obj.cardInfo.number)
				obj:SetIsOnPress(true):SetOnPress( function(name, state, x, y, gameObject, obj)
					self.is_pressed = state
					if true == state then
						self.selected_number = obj.cardInfo.number
						self.press_begin_time = app.get_time()
					else
						if app.get_time() - self.press_begin_time >= RoleUpexpUI.PRESS_TIME then
							self:OnPressUp(obj.cardInfo.number)
						end
					end
				end )
				obj:SetOnClicked( function(t)
					self:_EatExp(t.float_value)
					self:OnPressUp(obj.cardInfo.number)
				end , "", obj.cardInfo.number)
			end
		} )
	end

	self:UpdateUi();
	Root.AddUpdate(self.Update, self);
end
 

function RoleUpexpUI:PlayLevelUp(bool)
	-- do return end
	if bool then
		AudioManager.PlayUiAudio(ENUM.EUiAudioType.LvUpHero)
		local ui = uiManager:GetCurScene();
		if ui.PlayLevelUpEffect then
			ui:PlayLevelUpEffect();
		end
		-- local fix = self.level_up_fx:clone()
		-- fix:set_parent(self.level_up_fx_parent)
		-- fix:set_active(true)
		-- self.t_fixs = self.t_fixs or { }
		-- table.insert(self.t_fixs, { fix = fix, time = app.get_time() })
	else
		-- if self.t_fixs and type(self.t_fixs) == type { } then
		-- 	for _, v in pairs(self.t_fixs) do
		-- 		v.fix:set_active(false)
		-- 	end
		-- end
		-- self.t_fixs = { }
	end
end

function RoleUpexpUI:OnBuyItem(result)
	if result == 0 then
		FloatTip.Float(_local.UIText[8]);
		
		self:UpdatePropInfoUi()
		self:UpdateItemPoint()
	end
end

function RoleUpexpUI:UpdateUi()
	if self.ui == nil then return end
	if self.loaded_callback then
		self.loaded_callback(self)
		self.loaded_callback = nil
	end

	self.eat_all_exp = 0
	self.roleData = g_dataCenter.package:find_card(ENUM.EPackageType.Hero, self.roleData.index)

	self.roleData = 
	{
		index = 1,
		level = GameInfoForThis.Level,
		cur_exp = GameInfoForThis.Exp,
		upexp = 1,
	}

	self.temp_level = self.roleData.level;
	self.curr_exp = tonumber(self.roleData.cur_exp) or 0;

	self.last_temp_level = self.roleData.level
	-- 当前等级
	self.curr_temp_level = self.roleData.level
	-- self.need_update_ui = false

	local ismax = self.temp_level == g_dataCenter.player:GetLevel()

	-- 通知右侧经验值更新
	self:UpdateExpPartUi()
	self:UpdatePropInfoUi()
	self:UpdateEatCountUi()
	self:UpdateLevelUi(self.roleData.level)

	-- 更新战斗力，攻击/防御/生命
	--[[self.labFightValue:set_text(tostring(self.roleData:GetFightValue()))
	self.labAttactValue:set_text(tostring(self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power)))
	self.labDefenceValue:set_text(tostring(self.roleData:GetPropertyVal(ENUM.EHeroAttribute.def_power)))
	self.labMaxHpValue:set_text(tostring(self.roleData:GetPropertyVal(ENUM.EHeroAttribute.max_hp)))]]

    if self.heroContact and self.heroContact:IsShow() then
        self.heroContact:SetInfo(self.roleData, self.isPlayer)
    end

    self.btnLevelUpKey:set_active(false)
    self.objTopEffect:set_active(false)
    if self.roleData.level >= ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_playerMaxLevel).data then
        self.objTopEffect:set_active(true)
    else
        if g_dataCenter.player.level >= ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteID_role_key_level_up_open_level).data then
            self.btnLevelUpKey:set_active(true)
        end
    end

	self:UpdateItemPoint()
end


--内部小红点
function RoleUpexpUI:UpdateItemPoint()
	--[[
	local canLvlUp = self.roleData:FormationCanLevelUp()
	for _, number in pairs(self.expCfg) do
		local smallItem = self.ui_exps[number].item_info
		if smallItem then
			if canLvlUp then
				if PropsEnum.GetValue(number) == 0 then
					smallItem:SetTipPoint(false)
				else
					smallItem:SetTipPoint(true)
				end
			else
				smallItem:SetTipPoint(false)
			end
		end
	end
	]]
end


-- 更新使用数量
function RoleUpexpUI:UpdateEatCountUi()
	if self.use_count < 1 then
		self.use_count = 0
		self.lbl_eat_count:set_text("")
	else
		if self.use_count > 1 then
			self.lbl_eat_count:set_text("+" .. tostring(self.use_count))
		end
	end

end
-- 更新经验值UI
function RoleUpexpUI:UpdateExpPartUi(lv, exp, exp_max, pro_exp)
	local _lv, _exp, _exp_max, _pro_exp = lv, exp, exp_max, pro_exp
	if _lv and _exp and _exp_max and _pro_exp then
		_exp = _exp --PublicFunc.NumberToStringByCfg(_exp)
		_exp_max = _exp_max --PublicFunc.NumberToStringByCfg(_exp_max)
	else
		--local levelConfig = CardHuman.GetLevelConfig(self.roleData.number, self.roleData.level, self.roleData.config)
		--_lv, _exp, _exp_max, _pro_exp = self.roleData.level, self.roleData.cur_exp, levelConfig.upexp, self.roleData.cur_exp / self.roleData.upexp
		_lv, _exp, _exp_max, _pro_exp = self.roleData.level, self.roleData.cur_exp, 0, self.roleData.cur_exp / self.roleData.upexp
	end
	--顶级
	if _exp_max == 0 then
		self.lbl_exp:set_text("MAX")	
	else
		self.lbl_exp:set_text("[973900]" .._exp .. '[-][000000]/' .. _exp_max .. "[-]")
	end
	
	self.pro_exp:set_value(_pro_exp);
	self.temp_progress_value = _pro_exp
end
 

function RoleUpexpUI:UpdateLevelUi(lv)
	self.lbl_level:set_text(tostring(lv))
end


function RoleUpexpUI:OnPressUp(number)
	-- 发送给服务器
	self.press_begin_time = 0
	if self.use_count <= 0 then
		return
	end
	local select_data = self.expData[number]
	if select_data then
 	  --app.log("OnPressUp use_count=" .. tostring(self.use_count).."  "..debug.traceback())
		msg_cards.cg_eat_exp(Socket.socketServer, self.roleData.index, select_data.id, self.use_count);
		self.use_count = 0
		self.selected_number = 0
		self:UpdateEatCountUi()
	end
end

function RoleUpexpUI:CalcUpLevel()
	while
		(self.eat_all_exp > 0)
	do
		local level_cfg = CardHuman.GetLevelConfig(self.roleData.number, self.curr_temp_level, self.roleData.config)
		local t_log = { }
		if level_cfg then
			-- 够升级
			if self.eat_all_exp + self.curr_exp >= level_cfg.upexp then
				--app.log("self.eat_all_exp1 before=" .. tostring(self.eat_all_exp) .. " self.curr_temp_level=" .. tostring(self.curr_temp_level) .. " self.curr_exp=" .. tostring(self.curr_exp) .. " level_cfg.upexp=" .. tostring(level_cfg.upexp))
				self.eat_all_exp = self.eat_all_exp - (level_cfg.upexp - self.curr_exp)
				--app.log("self.eat_all_exp1 before1=" .. tostring(self.eat_all_exp) .. " self.curr_temp_level=" .. tostring(self.curr_temp_level) .. " self.curr_exp=" .. tostring(self.curr_exp) .. " level_cfg.upexp=" .. tostring(level_cfg.upexp))
				if self.curr_temp_level == g_dataCenter.player:GetLevel() then
					self.curr_exp = level_cfg.upexp - 1		
					t_log = {
						curr_exp = self.curr_exp,
						up_exp = level_cfg.upexp,
						begin = self.curr_exp / level_cfg.upexp,
						eend = 1,
						lv = self.curr_temp_level,
						level_up = true,
						total_exp = self.eat_all_exp
					}
					self.hero_upe_level_log:push(t_log)
					--app.log("push max:"..table.tostring(t_log))
					break;			
				else					
					self.curr_exp = 0--level_cfg.upexp
					self.curr_temp_level = self.curr_temp_level + 1
				end
				
				--self.eat_all_exp = self.eat_all_exp -(level_cfg.upexp - self.curr_exp)
				t_log = {
					curr_exp = self.curr_exp,
					up_exp = level_cfg.upexp,
					begin = self.curr_exp / level_cfg.upexp,
					eend = 1,
					lv = self.curr_temp_level,
					level_up = true,
					total_exp = self.eat_all_exp
				}
				
				
				-- app.log("self.eat_all_exp1 after=" .. tostring(self.eat_all_exp) .. " self.curr_temp_level=" .. tostring(self.curr_temp_level) .. " self.curr_exp=" .. tostring(self.curr_exp) .. " level_cfg.upexp=" .. tostring(level_cfg.upexp))

			else
				local begin = self.curr_exp / level_cfg.upexp
				self.curr_exp = self.curr_exp + self.eat_all_exp

				self.eat_all_exp = 0
				t_log = {
					curr_exp = self.curr_exp,
					up_exp = level_cfg.upexp,
					begin = begin,
					eend = self.curr_exp / level_cfg.upexp,
					lv = self.curr_temp_level,
					level_up = false,
					total_exp = self.eat_all_exp
				}
				--app.log("self.eat_all_exp2 =" .. tostring(self.eat_all_exp) .. " self.curr_temp_level=" .. tostring(self.curr_temp_level) .. " self.curr_exp=" .. tostring(self.curr_exp) .. " level_cfg.upexp=" .. tostring(level_cfg.upexp))
			end

			self.hero_upe_level_log:push(t_log)
			 --app.log("push:"..table.tostring(t_log))
		else
			-- app.log("没有等级配置.." .. tostring(self.roleData.number) .. " level=" .. tostring(self.curr_temp_level))
			break
		end
	end
end

-- 计算是否能升级 满经验((up_exp-1)/up_exp) 满等级提示
function RoleUpexpUI:CanLevelUp()
	self.calc_eat_all_exp = self.calc_eat_all_exp + expData.info.exp
end

function RoleUpexpUI:_EatExp(number)
	if not number then
		app.log("RoleUpexpUI:_EatExp  failure number is nil")
		return
	end
	 
	local expData = self.expData[number]
	if not expData then
		return
	end
	if expData.have < 1 then
		self:CalcUpLevel()
		 --self.is_pressed = false
		-- self.ui_exps[expData.info.number].item_info:SetIsOnPress(false)
		self.is_pressed = false
		return
	end
	 --self.ui_exps[expData.info.number].item_info:SetIsOnPress(true)
	local do_eat_exp = function()
		if not self.ui then return end
		expData.have = expData.have - 1
		self.use_count = self.use_count + 1

		--吃药特效
		local stop_fx = function(obj,n)
			if not self.ui then return end
			if obj.ui_exps[n].item_fx_time_id then
				obj.ui_exps[n].fx:set_active(false)
				obj.ui_exps[n].item_fx_time_id = nil
				obj.ui_exps[n].is_play_fx = false
                self.objEffectExp:set_active(false)
			end
		end
		if not self.ui_exps[number].is_play_fx   then
			self.ui_exps[number].item_fx_time_id = timer.create(Utility.create_callback_ex(stop_fx,true,nil,self,number),1200,1);
			self.ui_exps[number].is_play_fx = true;
			self.ui_exps[number].fx:set_active(true)
            self.objEffectExp:set_active(true)
		end

		self.ui_exps[expData.info.number].item_info:SetCount(expData.have)
		self.eat_all_exp = self.eat_all_exp + expData.info.exp

		self:CalcUpLevel()

		if expData.have < 1 then
			self.ui_exps[expData.info.number].item_info:SetBtnAddShow(true)
			self.ui_exps[expData.info.number].item_info:SetTipPoint(false)
		end
	end


	local level_cfg = CardHuman.GetLevelConfig(self.roleData.number, self.curr_temp_level, self.roleData.config)
	if not level_cfg then return end
	local get_need_exp = function(level)
		local player_level = g_dataCenter.player:GetLevel()
		local exp = 0
		local curr_exp = self.curr_exp
		while level <= player_level do
			level_cfg = CardHuman.GetLevelConfig(self.roleData.number, level, self.roleData.config)
			exp = exp + level_cfg.upexp
			curr_exp = 0
			level = level + 1
		end
	    --app.log("self.curr_temp_level=" .. tostring(level) .. " player_level=" .. tostring(player_level) .. " exp=" .. tostring(exp))
		return exp
	end

	if level_cfg.upexp == 0 then
		FloatTip.Float("角色已经满级啦")
		self.is_pressed = false
		return
	end

	if self.curr_exp == level_cfg.upexp - 1  and (self.curr_temp_level == g_dataCenter.player:GetLevel()  or self.roleData.level == g_dataCenter.player:GetLevel()) then
		FloatTip.Float("角色等级不能超过战队等级")
		self.is_pressed = false
		return
	end
   --app.log(tostring(self.curr_exp).."ddd"..tostring(get_need_exp(self.curr_temp_level)))

	local calc_eat_all_exp = expData.info.exp + self.curr_exp
	if calc_eat_all_exp then
		if calc_eat_all_exp > get_need_exp(self.curr_temp_level) then
			self.is_pressed = false

		    --app.log("经验将达到上限上限" .. tostring(calc_eat_all_exp) .. "xxx" .. tostring(get_need_exp(self.curr_temp_level)))
			--[[HintUI.SetAndShow(EHintUiType.two,
			_local.UIText[4],
			{
				str = _local.UIText[5],
				func = function()
					-- app.log("xxxxxx1")
					do_eat_exp()
					self:OnPressUp(number)
				end
			} ,
			{
				str = _local.UIText[6],
				func = function()
					-- app.log("xxxxxx12")
				end
			} );]]

			do_eat_exp()
			self:OnPressUp(number)
			return
		end
	end

	do_eat_exp()
end 


function RoleUpexpUI:Update(deltatime)
	if true == self.is_pressed and type(self.selected_number) == "number" then
		if app.get_time() - self.press_begin_time < RoleUpexpUI.PRESS_TIME then
			return
		end
		if app.get_time() - self.last_eat_time >= 0.1 then
			self:_EatExp(self.selected_number)
			-- 吃经验数字
			self:UpdateEatCountUi()
		end
	end
	 

	if self.hero_upe_level_log:len() > 0 and(self.tp == nil or not self.tp._is_running) then
		local nv = self.hero_upe_level_log:pop()
		if nv then
			local tp_data = {
				progress_bar = self.pro_exp,
				duration = (nv.eend - nv.begin) / 1 * 0.005,
				begin = nv.begin,
				eend = nv.eend,
				up_call = function(value)
					local curr_exp = math.ceil(value * nv.up_exp)
					if curr_exp > nv.up_exp then
						curr_exp = nv.up_exp
					end
					if value ~= 1 then
                        self.lbl_exp:set_text("[973900]" ..curr_exp .. '[-][000000]/' .. nv.up_exp .. "[-]")
					end
				end,
				com_call = function()
					-- self:enable_levelup_ani(true)
					if nv.level_up == true then
						self:PlayLevelUp(true)
					end
					self:UpdateLevelUi(nv.lv)
					self.left_exp = nv.curr_exp
					self.up_exp = nv.up_exp
					if self.left_exp < self.up_exp then
						self.pro_exp:set_value(self.left_exp / self.up_exp)
                        self.lbl_exp:set_text("[973900]" ..self.left_exp .. '[-][000000]/' .. nv.up_exp .. "[-]")
					end
					--app.log(string.format("self.left_exp:%s self.up_exp:%s,nv.level:%s,card_number=%s.", self.left_exp, self.up_exp, nv.lv, self.roleData.number))

					--意外刷新导致计数错误
					-- if self.hero_upe_level_log:len() <= 0 and true == self.need_update_ui then
					-- 	self.need_update_ui = false
					-- 	self:UpdateUi()
					-- end
				end
			}

			if tp_data.eend - tp_data.begin < 0.05 then
				tp_data.com_call()
			else
				if not self.tp then
					self.tp = TweenProgress:new(tp_data)
				end
				self.tp:Play(tp_data)
			end
		end
	else

	end
end


function RoleUpexpUI:UpdatePropInfoUi()
	if not self.ui then return end

	for i = 1, 6 do
		local item = g_dataCenter.package:find_card_for_num(ENUM.EPackageType.Item, self.expCfg[i]) or { };
		self.expData[self.expCfg[i]] = { id = item.index or 0, cfgId = self.expCfg[i], have = item.count or 0, use = 0, info = item };
	end
	for k, v in pairs(self.ui_exps) do
		if v.item_info then
			v.item_info:SetBtnAdd(self.expData[k].have <= 0, self.bindfunc["on_btn_add"], "", self.expData[k].cfgId)
			-- v.item_info:UpdateUi()
			v.item_info:SetCount(self.expData[k].have)
		end
	end
end
 

-- 服务器结果刷新
function RoleUpexpUI:OnEatExp(result)
	if self.ui == nil then return end
	--do return end
	-- 服务器返回结果是只做记录，等动画完成后才刷新界面
	self.need_update_ui = true
	--if self.hero_upe_level_log:len() <= 0 then
		self:UpdateUi()
	--end
end

function RoleUpexpUI:OnBtnExpUpOneStep(t)
	--TODO
	-- local data = {

	-- }
	-- self.expupOnestepUi = HeroExpUpOneStepUI:new(data)
end

function RoleUpexpUI:IsShow()
	return UiBaseClass.IsShow(self)
end

function RoleUpexpUI:Show(data)
	if UiBaseClass.Show(self) then
		self:PlayLevelUp(false)
		self:UpdateUi()
	end
end

function RoleUpexpUI:Hide()
	if UiBaseClass.Hide(self) then
		self:PlayLevelUp(false)
		self.hero_upe_level_log:clear()
	end
end

function RoleUpexpUI:on_btn_add(t)
	local number = t.float_value
	local expData = self.expData[number];
	if expData then
		local buy_cfg = ConfigManager.Get(EConfigIndex.t_item_buy_limit, number)
		if buy_cfg and g_dataCenter.player:GetLevel() < buy_cfg.team_level then
			FloatTip.Float(string.format(_local.UIText[7], buy_cfg.team_level))
			return
		end
		
		if self.clsBuyBatch == nil then
            self.clsBuyBatch = BuyBatchUi:new()
        end

		local config = ConfigManager.Get(EConfigIndex.t_item, expData.cfgId);
		local info = {}
        info.itemId = expData.cfgId
        info.costCount = config.need_crystal
        info.costId = IdConfig.Crystal
        self.clsBuyBatch:Show()
        self.clsBuyBatch:SetData(info)
        self.clsBuyBatch:SetCallback(self.bindfunc["on_send_buy_item"], data)
	end
end

function RoleUpexpUI:on_send_buy_item(data, result)
    player.cg_buy_item(result.itemId, result.totalCount);
end

function RoleUpexpUI:OnBtnContact(t)
    if self.heroContact then
        self.heroContact:Show()
    else
        local data = 
        {
            parent = self.ui,
            info = self.roleData,
            loading = self.loading,
            isPlayer = self.isPlayer,
        }
        self.heroContact = HeroContactUI:new(data);
    end	 
end

function RoleUpexpUI:DestroyUi()
    if self.heroContact then
        self.heroContact:DestroyUi();
        self.heroContact = nil
    end
    Root.DelUpdate(self.Update, self)

	if self.clsBuyBatch then
		self.clsBuyBatch:DestroyUi()
		self.clsBuyBatch = nil
	end

	self:MsgUnRegist()
	self:UnRegistFunc()
	 
	if self.ui then
		self.ui:set_active(false)
		self.ui = nil
	end

	self.roleData = nil;
	self.expData = nil;
	self.r_uuid = 0;
	if self.tp then
		self.tp:Stop()
	end
	self.hero_upe_level_log:clear()
	self:PlayLevelUp(false)

    RoleLevelUpKeyUI.End()
	UiBaseClass.DestroyUi(self)
end

function RoleUpexpUI:on_level_up_key()
    RoleLevelUpKeyUI.Start(self.roleData)
end

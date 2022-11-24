

-- --region fuzion_battle_info_ui.lua
-- --Author : zzc
-- --Date   : 2016/1/14

-- --endregion

-- -------------------------------- 已废弃 -----------------------------


-- FuzionBattleInfoUI = Class('FuzionBattleInfoUI', MultiResUiBaseClass)

-- -------------------------------------local声明-------------------------------------
-- local resType = 
-- {
--     Front = 1,
--     Back = 2,
-- }

-- local resPaths = 
-- {
--     [resType.Front] = 'assetbundles/prefabs/ui/fuzion/ui_2903_fuzion.assetbundle';
--     [resType.Back] = 'assetbundles/prefabs/ui/fight/jiesuan_item1.assetbundle';
-- }

-- local rankNumSpriteName = 
-- {
--     [1] = 'jjc_diyi',
--     [2] = 'jjc_dier',
--     [3] = 'jjc_disan',
--     [4] = 'jjc_disi',
-- }

-- ---- 抽取本地的文本，需要替换到配置表
-- --_local.UIText = {
-- --	[1] = "",
-- --	[2] = "",
-- --}

-- -- 按击杀以及被击杀排序
-- local function _SortFighterFunc(fighterData)
--     for i, v in ipairs(fighterData) do
--         v.order = v.kill * 100 + (100 - v.dead)
--     end
--     table.sort(fighterData, function (a, b)
--         if a == nil or b == nil then return false end
--         return a.order > b.order
--     end)

--     if fighterData[1].kill == 0 and fighterData[1].dead == 0 then
--     	-- 特殊处理，都是第4名
--     	local fighter = nil
--     	for i=1, #fighterData do
--     		fighter = fighterData[i]
--     		fighter._rank = 4
--     	end
--     else
-- 		-- 排名顺序
-- 	    local lastOrder = -1
-- 		local rankIndex = 0
-- 		local fighter = nil
-- 	    for i=1, #fighterData do
-- 	    	fighter = fighterData[i]
-- 	    	if lastOrder ~= fighter.order then
-- 	    		if rankIndex == 0 then rankIndex = 1
-- 	    		else rankIndex = rankIndex + 1
-- 	    		end
-- 	    		lastOrder = fighter.order
-- 	    	end
-- 	    	fighter._rank = rankIndex
-- 		end
--     end  
-- end

-- -------------------------------------外部方法-------------------------------------
-- function FuzionBattleInfoUI.Start(data)
-- 	if FuzionBattleInfoUI.cls == nil then
-- 		FuzionBattleInfoUI.cls = FuzionBattleInfoUI:new(data)
-- 	end
-- end

-- function FuzionBattleInfoUI.SetFinishCallback(callback, obj)
-- 	if FuzionBattleInfoUI.cls then
-- 		FuzionBattleInfoUI.cls.callbackFunc = callback;
-- 		if FuzionBattleInfoUI.cls.callbackFunc then
-- 			FuzionBattleInfoUI.cls.callbackObj = obj;
-- 		end
-- 	else
-- 		app.log("类未初始化 请先调用start"..debug.traceback());
-- 	end
-- end

-- -------------------------------------类方法-------------------------------------
-- --初始化
-- function FuzionBattleInfoUI:Init(data)
-- 	self.pathRes = resPaths
-- 	MultiResUiBaseClass.Init(self, data);
-- end

-- --重新开始
-- function FuzionBattleInfoUI:Restart(data)
--     MultiResUiBaseClass.Restart(self, data)
-- end

-- --初始化数据
-- function FuzionBattleInfoUI:InitData(data)
-- 	MultiResUiBaseClass.InitData(self, data);

-- 	self.fighterData = {}

-- --    local data = 
-- --    {
-- --        [1] = 
-- --        {
-- --            herocid = 30002001,
-- --            name = 'test',
-- --            kill = 1, 
-- --            dead = 1,
-- --            _rank = 1,
-- --            playerid = '',
-- --        },
-- --        [2] = 
-- --        {
-- --            herocid = 30002001,
-- --            name = 'test',
-- --            kill = 2, 
-- --            dead = 1,
-- --            _rank = 2,
-- --            playerid = '',
-- --        },
-- --        [3] = 
-- --        {
-- --            herocid = 30002001,
-- --            name = 'test',
-- --            kill = 4, 
-- --            dead = 1,
-- --            _rank = 3,
-- --            playerid = '',
-- --        },
-- --        [4] = 
-- --        {
-- --            herocid = 30002001,
-- --            name = 'test',
-- --            kill = 4, 
-- --            dead = 1,
-- --            _rank = 4,
-- --            playerid = '',
-- --        },
-- --    }

-- 	for k, v in pairs(g_dataCenter.fuzion.fighterList) do
--     --for k, v in pairs(data) do
--         table.insert(self.fighterData, v);
--     end
-- 	_SortFighterFunc(self.fighterData)
-- end

-- --释放界面
-- function FuzionBattleInfoUI:DestroyUi()
--     MultiResUiBaseClass.DestroyUi(self);

--     if self.itemArray then
--     	for i, v in pairs(self.itemArray) do
--     		v.smallCardUi:DestroyUi()
--     	end
--     	self.itemArray = nil
--     end

--     AudioManager.StopUiAudio(81010000)
-- end

-- --显示UI
-- function FuzionBattleInfoUI:Show()
-- 	if MultiResUiBaseClass.Show(self) then
-- 	end
-- end

-- --隐藏UI
-- function FuzionBattleInfoUI:Hide()
-- 	if MultiResUiBaseClass.Hide(self) then
-- 	end
-- end

-- --注册方法
-- function FuzionBattleInfoUI:RegistFunc()
--     MultiResUiBaseClass.RegistFunc(self);
	
-- 	self.bindfunc["OnClose"] = Utility.bind_callback(self, self.OnClose);
-- end 

-- --撤销注册方法
-- function FuzionBattleInfoUI:UnRegistFunc()
--     MultiResUiBaseClass.UnRegistFunc(self);
-- end

-- --注册消息分发回调函数
-- function FuzionBattleInfoUI:MsgRegist()
-- 	MultiResUiBaseClass.MsgRegist(self);
-- end

-- --注销消息分发回调函数
-- function FuzionBattleInfoUI:MsgUnRegist()
-- 	MultiResUiBaseClass.MsgUnRegist(self);
-- end

-- --初始化UI
-- function FuzionBattleInfoUI:InitedAllUI()

--     local backui = self.uis[ resPaths[resType.Back] ]
-- 	local node = backui:get_child_by_name('animation_lose')
--     node:set_active(false)

--     local titlesp = ngui.find_sprite(backui, 'animation_win/cont1/sp_left')
--     titlesp:set_sprite_name('js_zhandoujiesu')

-- 	---------------------按钮及回调事件绑定------------------------
-- 	self.back = ngui.find_button(backui,"mark");
-- 	self.back:set_on_click(self.bindfunc["OnClose"]);

--     self.ui = self.uis[ resPaths[resType.Front] ]

--     backui:set_parent(self.ui)
--     self.ui:set_active(false)
--     self.ui:set_active(true)

-- 	self.ui:set_name("fuzion_battle_info_ui");

-- 	self.enterTime = system.time()
	
-- 	local basePath = ""
-- --	------------------------------ 顶部 -----------------------------
-- --	self.mask = ngui.find_sprite(self.ui, "fuzion_battle_info_ui/mark")
-- --	self.mask:set_on_ngui_click(self.bindfunc["OnClose"])


-- 	------------------------------ 中部 -----------------------------
-- 	basePath = "centre_other/animation"

-- 	local itemArray = {}
-- 	for i = 1, 4 do
-- 		itemArray[i] = {}
-- --		itemArray[i].frame = ngui.find_sprite(self.ui, basePath.."/content"..i.."/sp_frame")
-- --		itemArray[i].texture = ngui.find_texture(self.ui, basePath.."/content"..i.."/sp_frame/Texture")
-- --		itemArray[i].select = ngui.find_sprite(self.ui, basePath.."/content"..i.."/sp_shine")
-- 		itemArray[i].name = ngui.find_label(self.ui, basePath.."/item"..i.."/lab_name")
-- 		itemArray[i].kill = ngui.find_label(self.ui, basePath.."/item"..i.."/content_skill/sp_skill/lab")
-- 		itemArray[i].dead = ngui.find_label(self.ui, basePath.."/item"..i.."/content_skill/sp_die/lab")
--         itemArray[i].rankLab = ngui.find_label(self.ui, basePath.."/item"..i.."/lab1")
--         itemArray[i].rankSp = ngui.find_sprite(self.ui, basePath.."/item"..i.."/sp_win_diban")
--         itemArray[i].bkSp = ngui.find_sprite(self.ui, basePath.."/item"..i.."/sp_di")
--         local sp = ngui.find_sprite(self.ui, basePath.."/item"..i.."/sp_win")
--         if sp then
--             sp:set_active(false)
--         end

--         local headParent = self.ui:get_child_by_name(basePath.."/item"..i.."/frame1")
--         itemArray[i].smallCardUi = SmallCardUi:new({parent = headParent, 
--             stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity } });

-- --		itemArray[i].rank1 = ngui.find_sprite(self.ui, basePath.."/content"..i.."/choose1")
-- --		itemArray[i].rank2 = ngui.find_sprite(self.ui, basePath.."/content"..i.."/choose2")
-- --		itemArray[i].rank3 = ngui.find_sprite(self.ui, basePath.."/content"..i.."/choose3")
-- --		itemArray[i].rank4 = ngui.find_sprite(self.ui, basePath.."/content"..i.."/choose4")

-- --		itemArray[i].select:set_active(false)
-- 	end
-- 	self.itemArray = itemArray

-- 	self:UpdateUi()
-- end

-- --刷新界面
-- function FuzionBattleInfoUI:UpdateUi()
-- 	if self.ui == nil then return end
	
-- 	for i = 1, 4 do
-- 		local info = self.fighterData[i]
-- 		if info then
-- --			local config = gd_role[info.herocid]
-- 			local config = ConfigHelper.GetRole(info.herocid)
-- 			self.itemArray[i].name:set_text(info.name)
-- 			self.itemArray[i].kill:set_text(tostring(info.kill))
-- 			self.itemArray[i].dead:set_text(tostring(info.dead))
-- --			self.itemArray[i].texture:set_texture(config.small_icon)
-- --			for j = 1, 4 do
-- --				self.itemArray[i]["rank"..j]:set_active(info._rank == j)
-- --			end
            
--             self.itemArray[i].rankSp:set_sprite_name(rankNumSpriteName[info._rank])
--             local lab = self.itemArray[i].rankLab
--             if info._rank == 4 then
--                 lab:set_active(true)
--                 lab:set_text(tostring(info._rank))
--             else
--                 lab:set_active(false)
--             end

--             self.itemArray[i].smallCardUi:SetData(CardHuman:new({number=info.herocid}))

-- 			if g_dataCenter.player.playerid == info.playerid then
-- 				--self.itemArray[i].select:set_active(true)
--                 --self.itemArray[i].smallCardUi:ChoseItem(true)
--                 self.itemArray[i].bkSp:set_sprite_name('js_ditiao1')
-- 			else
-- 				--self.itemArray[i].select:set_active(false)
--                 --self.itemArray[i].smallCardUi:ChoseItem(false)
--                 self.itemArray[i].bkSp:set_sprite_name('js_ditiao2')
-- 			end
-- 		end
-- 	end
-- 	AudioManager.PlayUiAudio(81010000)
-- end

-- -------------------------------------本地回调-------------------------------------
-- function FuzionBattleInfoUI:OnClose()
-- 	-- 2秒后才能关闭
-- 	if system.time() < self.enterTime + 2 then return end

-- 	if FuzionBattleInfoUI.cls then
-- 		FuzionBattleInfoUI.cls:DestroyUi()
-- 		FuzionBattleInfoUI.cls = nil
-- 	end

-- 	-- 判断该场是否有奖励
-- 	local myData = g_dataCenter.fuzion:GetMyData()
-- 	local validcnt = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_fuzionDayAwardCount).data;

-- 	-- 没有奖励
-- 	if myData.fightcnt > validcnt then
-- 		if self.callbackFunc then
-- 			self.callbackFunc(self.callbackObj);
-- 		end
-- 	-- 有奖励
-- 	else
-- 		local award = g_dataCenter.fuzion.showReward
-- 		if award and #award > 0 then
-- 			CommonAward.Start(award);
-- 			CommonAward.SetFinishCallback(self.callbackFunc, self.callbackObj);
-- 		end
-- 		-- local player = g_dataCenter.player
-- 		-- local rankIndex = 1
-- 		-- for i, v in pairs(self.fighterData) do
-- 		-- 	if player.playerid == v.playerid then
-- 		-- 		rankIndex = v._rank;
-- 		-- 		break
-- 		-- 	end
--   --   	end
-- 		-- local config = ConfigManager.Get(EConfigIndex.t_daluandou_point_reward,player.level)
-- 		-- local award = {}
-- 		-- -- 金币
-- 		-- table.insert(award, {id=2,count=config["gold_reward_rank"..rankIndex] or 0})
-- 		-- -- 战魂
-- 		-- table.insert(award, {id=IdConfig.FightSoul,count=config["fightsoul_reward_rank"..rankIndex] or 0})
-- 		-- -- 积分
-- 		-- CommonAward.Start(award);
-- 		-- CommonAward.SetFinishCallback(self.callbackFunc, self.callbackObj);
-- 	end
-- end
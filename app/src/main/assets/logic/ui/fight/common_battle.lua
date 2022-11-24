CommonBattle = Class("CommonBattle", MultiResUiBaseClass)

local _UIText = {
    --[1] = "玩家%s",
    [2] = "排名 [FCD901]%s[-]",   
    [3] = "点击屏幕任意位置关闭"
}

--------------------外部接口-------------------------
-- battleName 战斗名字 
-- players 玩家列表 结构如下
-- {
-- left = {player=玩家类（参考player.lua）, cards =｛CardHuman类 ...}		左
-- right = {player=玩家类（参考player.lua）, cards =｛CardHuman类 ... }		右
-- }
-- fightResult 战斗结果 如果传入nil 则不显示战斗结果
-- {
-- isWin = true;			是否赢了(nil表示平局)
-- leftCount = 3;			左比分
-- rightCount = 1;			右比分
-- leftEquipSouls = 1;		左装备魂值
-- rightEquipSouls = 1;	    右装备魂值
-- }

function CommonBattle.Start(battleName, players, fightResult)
	if CommonBattle.cls == nil then
		-- 将战斗结果统一转换为bool类型
		if fightResult then
			if fightResult.isWin == EPlayMethodLeaveType.success then
				fightResult.isWin = true
			elseif fightResult.isWin == EPlayMethodLeaveType.failed then
				fightResult.isWin = false
			end
		end
        if CommonBattle.cls == nil then
		    CommonBattle.cls = CommonBattle:new({
			    players = players,
			    fightResult = fightResult,
		    })
        end
	end

	ChatUI.Destroy()
end

function CommonBattle.SetFinishCallback(callback, obj)
	if CommonBattle.cls then
		CommonBattle.cls.callbackFunc = callback;
		if callback then
			CommonBattle.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start" .. debug.traceback());
	end
end

function CommonBattle.Destroy()
	if CommonBattle.cls then
		CommonBattle.cls:DestroyUi()
		CommonBattle.cls = nil
	end
end

--------------------内部接口-------------------------

function CommonBattle:DestroyUi()
    if self.smallCard then
        for k, v in pairs(self.smallCard) do
            v:DestroyUi()
        end
        self.smallCard = nil
    end
    if self.smallItem then
        for k, v in pairs(self.smallItem) do
            v:DestroyUi()
        end
        self.smallItem = nil
    end
    
	MultiResUiBaseClass.DestroyUi(self)
end

function CommonBattle:on_close(t)
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
	end

    local data = self:GetInitData()
    local fightWin = 0 -- 0失败 1胜利
    if data and data.fightResult then
        fightWin = data.fightResult.isWin and 1 or 0
    end
    --结算界面退出通知一下新手引导
    NoticeManager.Notice(ENUM.NoticeType.GetBattleShowBack, fightWin)

	CommonBattle.Destroy()
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = '';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

function CommonBattle:Init(data)
    if data.fightResult.isWin == true then
        resPaths[resType.Front] = "assetbundles/prefabs/ui/loading/fight_settle_jjc_win.assetbundle"
    else
        resPaths[resType.Front] = "assetbundles/prefabs/ui/loading/fight_settle_jjc_lose.assetbundle"
    end
    self.pathRes = resPaths
	MultiResUiBaseClass.Init(self, data)
end

function CommonBattle:InitData(data)
	MultiResUiBaseClass.InitData(self, data);
	-- 外部数据相关
	self.fightResult = data.fightResult
    self.players = data.players
	CommonClearing.canClose = false;
end

function CommonBattle:RegistFunc()
	MultiResUiBaseClass.RegistFunc(self);
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
    self.bindfunc["on_recive_ani_finish"] = Utility.bind_callback(self, self.on_recive_ani_finish);
end

--注销回调函数
function CommonBattle:UnRegistFunc()
    MultiResUiBaseClass.UnRegistFunc(self);
    PublicFunc.msg_unregist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

--注册消息分发回调函数
function CommonBattle:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(CommonClearing.CanClose, self.bindfunc["on_recive_ani_finish"])
end

function CommonBattle:InitedAllUI(asset_obj)
    --MultiResUiBaseClass.InitUI(self, asset_obj)	

    self.backui = self.uis[resPaths[resType.Back]]
    local frontParentNode = self.backui:get_child_by_name("add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    self.ui:set_name("CommonBattle")

    local spTitle = ngui.find_sprite(self.backui, "sp_art_font")
    if self.fightResult.isWin == true then
        spTitle:set_sprite_name("js_shengli")
    else
        spTitle:set_sprite_name("js_shibai")
    end
    local lblClick = ngui.find_label(self.backui, "txt")
    lblClick:set_text(_UIText[3])

	AudioManager.Stop(nil, true);

    local path = "" 
	if self.fightResult.isWin then
        path = "animation/" 
		AudioManager.PlayUiAudio(81010000)
	else
        path = "animation/"
		AudioManager.PlayUiAudio(81010001)
	end

    local btnClose = ngui.find_button(self.backui, "mark")
    btnClose:set_on_click(self.bindfunc["on_close"])

    if self.fightResult.isWin then
        self.objRankNumber = self.ui:get_child_by_name(path .. "sp_di1/sp_arrow")
        self.lblRankNumber = ngui.find_label(self.ui, path .. "sp_di1/sp_arrow/lab")
    
        self.objUpTopRank = self.ui:get_child_by_name(path .. "sp_di1/sp_high")
        --self.lblUpTopRank = ngui.find_label(self.ui, path .. "sp_y/lab_num")
        self.objEffect = self.ui:get_child_by_name(path .. "sp_di1/fx_fight_settle_jjc_win")
    end

    self.lblName = ngui.find_label(self.ui, path .. "sp_di1/txt_name")
    self.lblRank = ngui.find_label(self.ui, path .. "sp_di1/txt_rank")

    self.smallCard = {}
    for i = 1, 3 do
        self.smallCard[i] = SmallCardUi:new(
        {   
            parent = self.ui:get_child_by_name(path .. "sp_di2/big_card_item_80" .. i ),
            info = nil,
            tipType = SmallCardUi.TipType.NotShow,
            sgroup = 4	
        }) 
    end

    self.nodeAward = self.ui:get_child_by_name(path .. "txt_award")
    self.nodeAward:set_active(false)

	self:UpdateUi();
	CommonClearing.OnUiLoadFinish(ECommonEnd.eCommonEnd_battle);
end

function CommonBattle:UpdateUi()
	if not MultiResUiBaseClass.UpdateUi(self) then
        return
    end
    
    if self.fightResult.isWin then
        self.objRankNumber:set_active(false)
        self.objUpTopRank:set_active(false)
        self.objEffect:set_active(false)
    end
    self.lblRank:set_active(false)

    --竞技场
    local info = self.fightResult.arenaInfo
    if info ~= nil then
        self.lblRank:set_active(true)
        self.lblRank:set_text(string.format(_UIText[2], tostring(info.myRank)))

        if self.fightResult.isWin then
            --名次变化排名
            if info.rankChange and info.rankChange > 0 then
                self.objRankNumber:set_active(true)
                self.lblRankNumber:set_text("+" .. tostring(info.rankChange))
            end
            if info.upTopRank then
                self.objUpTopRank:set_active(true)
                --self.lblUpTopRank:set_text(tostring(info.upTopRank))
            end
        end
    end

    --奖励
    local awards = self.fightResult.awards
    if awards and #awards > 0 then
        self.nodeAward:set_active(true)
        self.smallItem = {}
        for i = 1, 5 do
            if awards[i] then
                self.smallItem[i] = UiSmallItem:new(
                {   
                    parent = self.nodeAward:get_child_by_name("big_card_item_80" .. i ),
                    cardInfo = nil,
                    delay = -1,
                }) 
                self.smallItem[i]:SetDataNumber(awards[i].id, awards[i].num)
            end
        end
    end

    local left = self.players.left
    self.lblName:set_text(tostring(left.player.name))

    for k, v in pairs(self.smallCard) do
        if left.cards[k] then
            v:Show()
            v:SetData(left.cards[k])
        else    
            v:Hide()
        end
    end
end

function CommonBattle:on_recive_ani_finish()
    local info = self.fightResult.arenaInfo
    if self.objEffect and info and info.upTopRank then
        self.objEffect:set_active(true)
    end
end
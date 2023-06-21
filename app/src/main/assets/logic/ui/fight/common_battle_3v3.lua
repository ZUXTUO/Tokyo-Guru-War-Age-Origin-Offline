CommonBattle3v3 = Class("CommonBattle3v3", UiBaseClass)


local _UIText = {
    [1] = "玩家:%s",
    [2] = "排名:%s",
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

function CommonBattle3v3.Start(battleName, players, fightResult)
	if CommonBattle3v3.cls == nil then
		-- 将战斗结果统一转换为bool类型
		if fightResult then
			if fightResult.isWin == EPlayMethodLeaveType.success then
				fightResult.isWin = true
			elseif fightResult.isWin == EPlayMethodLeaveType.failed then
				fightResult.isWin = false
			end
		end
        if CommonBattle3v3.cls == nil then
		    CommonBattle3v3.cls = CommonBattle3v3:new({
			    players = players,
			    fightResult = fightResult,
		    })
        end
	end

	ChatUI.Destroy()
end

function CommonBattle3v3.SetFinishCallback(callback, obj)
	if CommonBattle3v3.cls then
		CommonBattle3v3.cls.callbackFunc = callback;
		if callback then
			CommonBattle3v3.cls.callbackObj = obj;
		end
	else
		app.log("类未初始化 请先调用start" .. debug.traceback());
	end
end

function CommonBattle3v3.Destroy()
	if CommonBattle3v3.cls then
		CommonBattle3v3.cls:DestroyUi()
		CommonBattle3v3.cls = nil
	end
end

--------------------内部接口-------------------------

function CommonBattle3v3:DestroyUi()
    for _, v in pairs(self.panel) do
        if v and v.player then
            for _, vv in pairs(v.player) do
                if vv and vv.smallCard then
                    vv.smallCard:DestroyUi()
                    vv.smallCard = nil
                end
            end
        end
    end
    self.panel = nil
	UiBaseClass.DestroyUi(self)
end

function CommonBattle3v3:on_close(t)
	if self.callbackFunc then
		self.callbackFunc(self.callbackObj);
	end
	CommonBattle3v3.Destroy()
end

local resType = 
{
    Main = 1,
    battle = 2,
}

local __Position = 
{
    Up = 1,
    Down = 2,
}

local __spriteName = {
    ["win"] = "zb_win",
    ["fail"] = "zb_lose",
}

function CommonBattle3v3:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/loading/fight_settle_3v3.assetbundle"
    --平局
    if data.fightResult.isWin == nil then
        self.pathRes = "assetbundles/prefabs/ui/loading/fight_settle_3v3_pingju.assetbundle"
    end
	UiBaseClass.Init(self, data)
end

function CommonBattle3v3:InitData(data)
	UiBaseClass.InitData(self, data);
	-- 外部数据相关
	self.fightResult = data.fightResult
    self.players = data.players
	CommonClearing.canClose = false;
end

function CommonBattle3v3:RegistFunc()
	UiBaseClass.RegistFunc(self);
	self.bindfunc["on_close"] = Utility.bind_callback(self, self.on_close);
end

function CommonBattle3v3:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)    
    self.ui:set_name("CommonBattle3v3")  
   
    local path = "centre_other/animation/"
    local btnClose = ngui.find_button(self.ui, 'sp_mark')
    btnClose:set_on_click(self.bindfunc["on_close"])

	AudioManager.Stop(nil, true);
	if self.fightResult.isWin then
		AudioManager.PlayUiAudio(81010000)
	else
		AudioManager.PlayUiAudio(81010001)
	end
    
    self.panel = {}
    local pathConnfig = {
        [__Position.Up] = path .. "cont_red/",
        [__Position.Down] = path .. "cont_blue/",
    }
    for k, path in ipairs(pathConnfig) do
        local temp = {
            spResult = nil,
            lblScore = ngui.find_label(self.ui, path .. "sp_arrow/lab"),
            player = {},
        }
        if self.fightResult.isWin ~= nil then
            temp.spResult = ngui.find_sprite(self.ui, path .. "sp_art_font")
        end

        for i = 1,3 do
            local pPath = path .. "txt_name" .. i
            temp.player[i] = {
                lblName = ngui.find_label(self.ui, pPath),
                lblKill = ngui.find_label(self.ui, pPath .. "/sp1/lab"),
                lblDead = ngui.find_label(self.ui, pPath .. "/sp2/lab"),
                lblSD = ngui.find_label(self.ui, pPath .. "/txt/lab"),
                smallCard = SmallCardUi:new(
                {   
                    parent = self.ui:get_child_by_name(pPath .. "/big_card_item_80"),
                    info = nil,
                    tipType = SmallCardUi.TipType.NotShow,
                    stypes = {SmallCardUi.SType.Texture}	
                }) 
            }
        end
        self.panel[k] = temp
    end

	self:UpdateUi();

	CommonClearing.OnUiLoadFinish(ECommonEnd.eCommonEnd_battle);
end

function CommonBattle3v3:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
        return
    end

    local upUi = self.panel[__Position.Up]
    local downUi = self.panel[__Position.Down]

    if upUi.spResult and downUi.spResult then
        if self.fightResult.isWin then
            upUi.spResult:set_sprite_name(__spriteName["win"])
            downUi.spResult:set_sprite_name(__spriteName["fail"])
        else
            upUi.spResult:set_sprite_name(__spriteName["fail"])
            downUi.spResult:set_sprite_name(__spriteName["win"])
        end    
    end  
    --得分
    upUi.lblScore:set_text(tostring(self.fightResult.leftCount))
    downUi.lblScore:set_text(tostring(self.fightResult.rightCount))

    local __dataConfig = {
        {ui = upUi, data = self.players.left},
        {ui = downUi, data = self.players.right}
    }

    local myPlayerName = g_dataCenter.player:GetName()

    for _, v in pairs(__dataConfig) do
        local ui = v.ui
        local data = v.data

        for k, player in pairs(ui.player) do
            local cardData = data.cards[k]
            if cardData then
                local ext = cardData.__extData
                player.lblName:set_text(ext.name)
                player.lblKill:set_text(tostring(ext.kill_num))
                player.lblDead:set_text(tostring(ext.dead_num))
                player.lblSD:set_text(tostring(ext.add_point))

                player.smallCard:Show() 
                player.smallCard:SetData(cardData)

                if ext.name == myPlayerName then
                    PublicFunc.SetUILabelYellow(player.lblName) --显示黄色字体
                else
                    PublicFunc.SetUILabelWhite(player.lblName)
                end
            else
                player.smallCard:Hide() 
            end
        end   
    end
end
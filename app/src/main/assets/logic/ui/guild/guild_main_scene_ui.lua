GuildMainSceneUI = Class("GuildMainSceneUI", MultiResUiBaseClass);

local _UIText = {
    [1] = "[00F6FF]社团[F2A00C]%s[-]级开启[-]",
    [2] = "您被移出了社团",
    [3] = "确定",
    [4] = "暂未开放",
    [5] = "社团公告",
    [6] = "[点击修改公告]",
    [7] = "社长很懒，什么都没有写",
}
local _GuildNoticeInterval = 10

local _Item = {
    EditNotice = 0,
    GuildShop = 1,
    GuildNotice = 2,
    GuildWar = 3,
    GuildTech = 4, 
    GuildRank = 5, 
    GuildHall = 6, 
    GuildBoss = 7,
    GuildLS = 8,
    GuildRedPacket = 9,
    GuildTasks = 10,
}

local _FILE_NAME = "guild_scene"
local resType = 
{
    Main = 1,
    Scene3d = 2,
}

function GuildMainSceneUI:Init(data)
    self.pathRes = {
        [resType.Main] = "assetbundles/prefabs/ui/guild/panel_bk.assetbundle",
        [resType.Scene3d] = "assetbundles/prefabs/map/057_shetuanzhujiemian/70000057_shetuanzhujiemian.assetbundle"
    }
	MultiResUiBaseClass.Init(self, data)
end

function GuildMainSceneUI:InitData(data)
	MultiResUiBaseClass.InitData(self, data) 
    self.lastPosX = nil
end

function GuildMainSceneUI:DestroyUi()
    self.lastPosX = nil

    self.objAnchors = {}
    self.uiItems = {}

	MultiResUiBaseClass.DestroyUi(self)    
end

function GuildMainSceneUI:Restart(data)
    self.lastPosX = nil
    self.timingSecs = 0
    self.touchBeginX  = nil
	MultiResUiBaseClass.Restart(self, data) 
end

function GuildMainSceneUI:RegistFunc()
	MultiResUiBaseClass.RegistFunc(self)
    self.bindfunc['on_back'] = Utility.bind_callback(self,self.on_back)
    self.bindfunc['on_rule'] = Utility.bind_callback(self,self.on_rule)
    self.bindfunc['on_guild_btn_click'] = Utility.bind_callback(self, self.on_guild_btn_click)
    self.bindfunc['on_show_notice'] = Utility.bind_callback(self,self.on_show_notice)

    self.bindfunc['on_sync_my_guild_data'] = Utility.bind_callback(self,self.on_sync_my_guild_data)
	self.bindfunc['on_update_guild_data'] = Utility.bind_callback(self,self.on_update_guild_data)
	self.bindfunc['on_quit_guild'] = Utility.bind_callback(self,self.on_quit_guild)

    self.bindfunc['on_touch_begin'] = Utility.bind_callback(self,self.on_touch_begin)
    self.bindfunc['on_touch_move'] = Utility.bind_callback(self,self.on_touch_move)
    self.bindfunc['on_tween_update'] = Utility.bind_callback(self,self.on_tween_update)
end

function GuildMainSceneUI:MsgRegist()
    MultiResUiBaseClass.MsgRegist(self)
	PublicFunc.msg_regist(msg_guild.gc_sync_my_guild_data, self.bindfunc["on_sync_my_guild_data"])
	PublicFunc.msg_regist(msg_guild.gc_quit_guild, self.bindfunc["on_quit_guild"])
	PublicFunc.msg_regist(msg_guild.gc_update_guild_data, self.bindfunc["on_update_guild_data"])
	PublicFunc.msg_regist(msg_guild.gc_sync_my_guild, self.bindfunc["on_quit_guild"])

    PublicFunc.msg_regist("guild_set_declaration_success", self.bindfunc['on_show_notice'])
end

function GuildMainSceneUI:MsgUnRegist()
    MultiResUiBaseClass.MsgUnRegist(self)
	PublicFunc.msg_unregist(msg_guild.gc_sync_my_guild_data, self.bindfunc["on_sync_my_guild_data"])
	PublicFunc.msg_unregist(msg_guild.gc_quit_guild, self.bindfunc["on_quit_guild"])
	PublicFunc.msg_unregist(msg_guild.gc_update_guild_data, self.bindfunc["on_update_guild_data"])
	PublicFunc.msg_unregist(msg_guild.gc_sync_my_guild, self.bindfunc["on_quit_guild"])

    PublicFunc.msg_unregist("guild_set_declaration_success", self.bindfunc['on_show_notice'])
end

function GuildMainSceneUI:on_back()
    uiManager:ClearStack()
	uiManager:PopUi()
end

function GuildMainSceneUI:on_rule()
    UiRuleDes.Start(ENUM.ERuleDesType.GongHui)
end

function GuildMainSceneUI:Show()  
    self:UpdateInfo()
    MultiResUiBaseClass.Show(self)
end

function GuildMainSceneUI:Hide() 
    MultiResUiBaseClass.Hide(self)
end

function GuildMainSceneUI:GetUIByType(resType)
    return self.uis[self.pathRes[resType]]
end

function GuildMainSceneUI:InitedAllUI(asset_obj)
    self.ui = self:GetUIByType(resType.Main) 
	self.ui:set_name("ui_guild_main_scene")    
    local spClickMask = ngui.find_sprite(self.ui, "sp_mark")    
    spClickMask:set_on_ngui_press(self.bindfunc['on_touch_begin'])
    spClickMask:set_on_ngui_drag_move(self.bindfunc['on_touch_move']) 

    --local btnBack = ngui.find_button(self.ui, "btn_back")
    --btnBack:set_on_click(self.bindfunc["on_back"])
    --local btnRule = ngui.find_button(self.ui, "btn_rule")
    --btnRule:set_on_click(self.bindfunc["on_rule"])

    self.objAnchors = {}
    self.uiItems = {}
    for i = 1, 10 do
        local path = "btn" .. i
        local isShow = self:IsShowItem(i)
        local _obj = self.ui:get_child_by_name(path)
        _obj:set_active(isShow)
        if isShow then
            self.objAnchors[i] = _obj
        end
        
        local temp = {}
        temp.isShow = isShow
        --temp.spPoint = ngui.find_sprite(self.ui, path .. "/animation/sp_point")
                
        local btn = nil
        if i ~= _Item.GuildNotice then
            temp.lblLevel = ngui.find_label(self.ui, path .. "/animation/lab_xx")
            temp.spLevelBg = ngui.find_sprite(self.ui, path .. "/animation/sp_bk")
            temp.spLevelBg:set_active(false)
            btn = ngui.find_button(self.ui, path .. "/animation/sprite_background")
        else
            --社团公告
            temp.lblLevel = ngui.find_label(self.ui, path .. "/animation/sp_di/lab_xx")
            self.lblNoticeContent = ngui.find_label(self.ui, path .. "/animation/sp_di/lab_content")
            self.lblNoticeContent:set_text("")

            local btnEditNotice = ngui.find_button(self.ui, path .. "/animation/sp_di/btn_empty")
            btnEditNotice:set_event_value("", _Item.EditNotice)
            btnEditNotice:set_on_click(self.bindfunc["on_guild_btn_click"])
            btnEditNotice:set_on_ngui_press(self.bindfunc['on_touch_begin'])
            btnEditNotice:set_on_ngui_drag_move(self.bindfunc['on_touch_move']) 

            self.spNoticeBtn = ngui.find_sprite(self.ui, path .. "/btn/animation/sprite_background")
            self.lblNoticeBtn = ngui.find_label(self.ui, path .. "/btn/animation/lab")
            
            self.objBtnAni = self.ui:get_child_by_name(path .. "/btn/animation")
            self.objNotice = self.ui:get_child_by_name(path .. "/animation")
            self:SetNoticeEffect(true)

            btn = ngui.find_button(self.ui, path .. "/btn")
        end
        temp.lblLevel:set_active(false)
        self.uiItems[i] = temp

        btn:set_event_value("", i)
        btn:set_on_click(self.bindfunc["on_guild_btn_click"])
        btn:set_on_ngui_press(self.bindfunc['on_touch_begin'])
        btn:set_on_ngui_drag_move(self.bindfunc['on_touch_move']) 
    end

    self.objBtnAdjustList = {}
    for i = 1, 10 do
        self.objBtnAdjustList[i] = self.ui:get_child_by_name("btn" .. i)        
    end

    self:Init3dSceneUi()

    if g_dataCenter.guild:IsPulledDetail() then
		self:UpdateInfo()
        local newDay = self:LoadSetting()
        --弹公告
        if newDay then
            local detail = g_dataCenter.guild.detail
            if detail and detail.declaration and detail.declaration ~= "" then
                HintUI.SetAndShowNew(EHintUiType.zero, _UIText[5], detail.declaration)
            end
        end
        -- 数据有变化，重新拉一次
        if g_dataCenter.guild:CheckDataChange() then
            self.loadingId = GLoading.Show(GLoading.EType.ui)
            msg_guild.cg_request_my_guild_data()
        end
	-- 发API 拉取公会数据
	else
		self.loadingId = GLoading.Show(GLoading.EType.ui)
		msg_guild.cg_request_my_guild_data()
	end 
end

function GuildMainSceneUI:Update(dt)
    if not MultiResUiBaseClass.Update(self, dt) then return end
    if self.objNotice == nil then
        return
    end
    self.timingSecs = self.timingSecs + dt
    if self.timingSecs >= _GuildNoticeInterval then
        self.timingSecs = 0
        local isActive = self.objNotice:get_active()
        self:SetNoticeEffect(not isActive)
    end
end

function GuildMainSceneUI:UpdateInfo()
    if not self.ui then return end
	if not g_dataCenter.guild:IsPulledDetail() then
		return
	end
    for k, v in pairs(self.uiItems) do
        if v.isShow then
            v.lblLevel:set_active(false)
            if v.spLevelBg then
                v.spLevelBg:set_active(false)
            end
            local haveLimit, level = self:CheckLevelLimit(k)
            if haveLimit then
                if level then
                    v.lblLevel:set_active(true)
                    v.spLevelBg:set_active(true)
                    v.lblLevel:set_text(string.format(_UIText[1], level))
                end
            else
                --[点击修改公告]
                if k == _Item.GuildNotice then
                    local myData = g_dataCenter.guild:GetMyMemberData()
	                if myData and myData.job ~= ENUM.EGuildJob.Member then
                        v.lblLevel:set_active(true)
                        v.lblLevel:set_text(_UIText[6])
                    end
                end
            end
        end
    end
    self:UpdateNoticeContent()
    self:UpdateBtnPositioin()
end

function GuildMainSceneUI:UpdateNoticeContent()
    local content = ""
    if not g_dataCenter.guild:IsPulledDetail() or self:CheckLevelLimit(_Item.GuildNotice) then
        self.lblNoticeContent:set_text(content)
        return
    end
    local detail = g_dataCenter.guild.detail
    if detail and detail.declaration and detail.declaration ~= "" then
        content = detail.declaration
    else
        content = _UIText[7]
    end
    self.lblNoticeContent:set_text(content)
end

function GuildMainSceneUI:on_guild_btn_click(t)
    local index = t.float_value
    if not g_dataCenter.guild:IsPulledDetail() then
        return
    end

    local _checkIndex = index
    if _checkIndex == _Item.EditNotice then
        _checkIndex = _Item.GuildNotice
    end
    local haveLimit, level = self:CheckLevelLimit(_checkIndex) 
    if haveLimit then
        if level then
            FloatTip.Float(string.format(_UIText[1], level))
        else
		    FloatTip.Float(_UIText[4])
        end
	    return
    end

    if index == _Item.GuildShop then
        g_dataCenter.shopInfo:OpenShop(ENUM.ShopID.Guild)

    elseif index == _Item.EditNotice then
        local myData = g_dataCenter.guild:GetMyMemberData()
	    if myData and myData.job ~= ENUM.EGuildJob.Member then
		    uiManager:PushUi(EUI.GuildSetDeclarationUI)
	    end

    elseif index == _Item.GuildNotice then
        self:on_show_notice()

    elseif index == _Item.GuildWar then
        uiManager:PushUi(EUI.GuildWarMapUI)

    elseif index == _Item.GuildTech then
        uiManager:PushUi(EUI.GuildScienceUI)

    elseif index == _Item.GuildRank then
		uiManager:PushUi(EUI.RankUI, {startRank = RANK_TYPE.GROUP})
	
    elseif index == _Item.GuildHall then
		uiManager:PushUi(EUI.GuildHallUI)

    elseif index == _Item.GuildBoss then
        uiManager:PushUi(EUI.UiGuildBoss)

    elseif index == _Item.GuildLS then
	    uiManager:PushUi(EUI.GuildFindLsUI)

    elseif index == _Item.GuildRedPacket then

    elseif index == _Item.GuildTasks then

    end
end

function GuildMainSceneUI:on_show_notice(flag)
    if self.objNotice == nil then
        return
    end
    if flag == nil then
        local isActive = self.objNotice:get_active()
        self:SetNoticeEffect(not isActive)
    else
        self:SetNoticeEffect(flag)
    end
end

function GuildMainSceneUI:SetNoticeEffect(isShow)
    self.objNotice:set_active(isShow)
    self.timingSecs = 0
    if isShow then
        self.objBtnAni:animated_play("panel_bk_btn2_btn_dianji")
        self.objNotice:animated_play("panel_bk_btn2_sp_di_dianji")

        self.spNoticeBtn:set_sprite_name("st_gonggao_anniu2")
        self.lblNoticeBtn:set_active(false)
    else
        self.spNoticeBtn:set_sprite_name("st_gonggao_anniu1")
        self.lblNoticeBtn:set_active(true)
    end
end

function GuildMainSceneUI:on_sync_my_guild_data()
	GLoading.Hide(GLoading.EType.ui, self.loadingId)
	self:UpdateInfo()
end

--[[公会数据变更]]
function GuildMainSceneUI:on_update_guild_data()
	self:UpdateInfo()
end

--[[公会设置变更]]
--function GuildMainSceneUI:on_update_guild_config()
--	self:UpdateInfo()
--end

--[[退出公会]]
function GuildMainSceneUI:on_quit_guild(oldId, id)
	--被踢出公会的消息
	if id and tonumber(id) ~= 0 then return end

	--退出当前界面到主界面
	self:on_back()

	--被踢给出提示（非主动退出公会或者主动解散公会）
	if not PublicFunc.is_lock_msg(msg_guild.cg_quit_guild) 
		and not PublicFunc.is_lock_msg(msg_guild.cg_guild_operation, 3) then
		HintUI.SetAndShow(EHintUiType.one, _UIText[2], {str = _UIText[3]})
	end
end

----------------------------------------------------------------------------------------------------

function GuildMainSceneUI:CheckLevelLimit(index)
    local curLevel = self:GetGuildLevel()
    if curLevel == nil then
        return true, nil
    end
    local levelLimit = g_dataCenter.guild:GetLimitLevel(index)
    --app.log('============> index = ' .. index .. ' curLevel = ' .. tostring(curLevel)  .. ' levelLimit = ' .. tostring(levelLimit))
    if curLevel ~= nil and levelLimit ~= nil and curLevel < levelLimit then
        return true, levelLimit
	end
    return false
end

function GuildMainSceneUI:IsShowItem(index)
	local config = ConfigManager.Get(EConfigIndex.t_guild_scene, index)
	return config.is_show == 1
end

function GuildMainSceneUI:GetGuildLevel()
    if g_dataCenter.guild.detail then
        return g_dataCenter.guild.detail.level
    end
    return nil
end

----------------------------------------------------------------------------------------------------

--[[加载配置]]
function GuildMainSceneUI:LoadSetting()    
    self.setting = {}
    if file.exist(_FILE_NAME) == true then
		local fileHandle = file.open_read(_FILE_NAME)
		local content = fileHandle:read_all_text()
		fileHandle:close();
		if content then
			local t = loadstring("return " ..content);
			if t then
				self.setting = t();
			end
		end
	end
    local year, month, day, hour, min, sec = TimeAnalysis.ConvertToYearMonDay(system.time())
    local date = year .. ''.. month .. '' .. day
    --检查日期
    if self.setting.date ~=  date then
        self.setting = {
            date = date,   
        }
        self:SaveSetting()
        return true
    end
    return false
end

--[[保存配置]]
function GuildMainSceneUI:SaveSetting()
	local fileHandle = file.open(_FILE_NAME, 2);
	fileHandle:write_string(table.toLuaString(self.setting));
	fileHandle:close();
end

------------------------------------------------------------------------------
local _totalLayer = 18

function GuildMainSceneUI:Init3dSceneUi()
    local ui3d = self:GetUIByType(resType.Scene3d) 
    ui3d:set_parent(nil)
    local uiName = "guild_scene_show_3d"
	ui3d:set_name(uiName)
    ui3d:set_local_scale(1, 1, 1)

    self.objMoveLayer = {} 
    for i = 1, _totalLayer do
        self.objMoveLayer[i] = ui3d:get_child_by_name(string.format("layer0%02d", i))
    end  

    --按钮
    self.objBtnList = {}
    for i = 1, 10 do
       self.objBtnList[i] = ui3d:get_child_by_name("btn" .. i)
    end
    self.sceneCamera3D = camera.find_by_name(uiName .. "Camera")

    self:MoveToShowGuildBossItem()
end

local _limitMaxX = -1540
local _limitMinX = -1815
local _touchMulti = -0.08
local _layerPos = {}
local _touchMoveXList = {}

function GuildMainSceneUI:SetLayerPos()
    --初始位置
    for i = 1, _totalLayer do
        local _x, _y, _z = self:GetLocalPositionByLayer(i)
        _layerPos[i] = {x = _x, y = _y, z = _z}
    end
    local pos = _layerPos[1]
    self.layer1X, self.layer1Y, self.layer1Z = pos.x , pos.y, pos.z
end

function GuildMainSceneUI:on_touch_begin(name, state, x, y, goObj)
    if state == true then
        self.touchBeginX = x
        self:SetLayerPos()
        _touchMoveXList = {}
    else
        self.touchBeginX = nil
        --边界拉回
        local x,y,z = self:GetLocalPositionByLayer(1)
        if x > _limitMaxX then 
            self:AddTweenAnimation(0.3, _limitMaxX)
        elseif x < _limitMinX then
            self:AddTweenAnimation(0.3, _limitMinX)
        else
            local count =  #_touchMoveXList
            if count > 1 then 
                local dx = _touchMoveXList[count] - _touchMoveXList[count-1]
                local targetX = x - dx * _touchMulti * 5
                if targetX > _limitMaxX then 
                    targetX = _limitMaxX
                elseif targetX < _limitMinX then 
                    targetX = _limitMinX
                end 
                self:AddTweenAnimation(0.5, targetX)
            end 
        end 
    end
end

function GuildMainSceneUI:on_touch_move(name, x, y, goObj)
    if self.touchBeginX == nil then
        return
    end
    table.insert(_touchMoveXList, x)
    if #_touchMoveXList > 3 then 
        table.remove(_touchMoveXList, 1)
    end 
    local targetX = self.layer1X + (self.touchBeginX - x) * _touchMulti

    --边界逼近及缓动
    if targetX >= _limitMaxX then
        targetX = math.atan(targetX - _limitMaxX) * 0.8/(math.pi * 0.5) + _limitMaxX
    elseif targetX <= _limitMinX then
        targetX = -math.atan(_limitMinX - targetX) * 0.8/(math.pi * 0.5) + _limitMinX
    end 
    self:AddTweenAnimation(0.15, targetX)
end

function GuildMainSceneUI:AddTweenAnimation(time, targetX)
    if targetX == nil or self.layer1Y == nil or self.layer1Z == nil then
        return
    end
    Tween.addTween(self.objMoveLayer[1], time,
        {["local_position"] = {targetX, self.layer1Y, self.layer1Z}}, Transitions.EASE_OUT, 0, nil, self.bindfunc['on_tween_update']);
end

function GuildMainSceneUI:GetLocalPositionByLayer(layer)
    return self.objMoveLayer[layer]:get_local_position()
end

function GuildMainSceneUI:MoveToShowGuildBossItem()
    self:SetLayerPos()
    self:AddTweenAnimation(0.01, self.layer1X - 20)
end

local _moveRatio = {
    [1] = 1,
    [2] = 0.14,
    [3] = 0.13,

    [4] = 0.12,
    [5] = 0.11,
    [6] = 0.10,
    [7] = 0.09,
    [8] = 0.08,

    [9] = 0.07,
    [10] = 0.06,

    [11] = 0.05,
    [12] = 0.04,
    [13] = 0.03,

    [14] = 0.03,
    [15] = 0.025,

    [16] = 0.02,
    [17] = 0.025,
    [18] = 0.017,
}
function GuildMainSceneUI:on_tween_update()
    local x, y, z = self:GetLocalPositionByLayer(1)
    local diffX = x - self.layer1X
    for i = 2, _totalLayer do
        local pos = _layerPos[i]
        self.objMoveLayer[i]:set_local_position(pos.x + diffX * _moveRatio[i], pos.y, pos.z)
    end
    self:UpdateBtnPositioin()
end

function GuildMainSceneUI:UpdateBtnPositioin()
    --更新ui位置
    for k, v in pairs(self.objBtnAdjustList) do
        local isSuc, rx, ry, rz = self:SceneWorldPosToUIWorldPos(self.sceneCamera3D, self.objBtnList[k]:get_position())
        v:set_position(rx, ry, rz)  
    end
end

function GuildMainSceneUI:SceneWorldPosToUIWorldPos(sceneCamera, x, y, z)
    local uiCamera = Root.get_ui_camera();
    local isSuc, ux, uy, uz = false, 0, 0, 0
    if sceneCamera ~= nil and uiCamera ~= nil then
        local sx, sy, sz = sceneCamera:world_to_screen_point(x, y, z)
        ux, uy, uz = uiCamera:screen_to_world_point(sx, sy, 0);
        isSuc = true
    else
        app.log('camera == nil or ui_camera == nil')
    end
    return isSuc, ux, uy, uz
end
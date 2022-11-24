FuzionFightUI = Class('FuzionFightUI', UiBaseClass);


local buffIds = 
{
    EFuzionBuffIds.EKnown,
    EFuzionBuffIds.EUnknown,
    EFuzionBuffIds.EInternal
}

--------------------------local声明------------------------
-- 按击杀以及被击杀排序
local function _SortFighterFunc(fighterData)
    for i, v in ipairs(fighterData) do
        v.order = v.kill * 100 + (100 - v.dead)
    end
    table.sort(fighterData, function (a, b)
        if a == nil or b == nil then return false end
        return a.order > b.order
    end)
end

--------------------------类方法------------------------
--初始化
function FuzionFightUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/new_fight/new_fight_ui_daluandou.assetbundle';
    UiBaseClass.Init(self, data)
end

--重新开始
function FuzionFightUI:Restart(data)
    UiBaseClass.Restart(self, data)
end

--初始化数据
function FuzionFightUI:InitData(data)
    UiBaseClass.InitData(self, data)

    self.parent = data.parent
    self.playerid = g_dataCenter.player.playerid

    local fightManager = FightScene.GetFightManager()
    self.fighterEntity = fightManager.heroList
    self.fighterList = g_dataCenter.fuzion.fighterList;
    self:UpdateFightData()
    self.showLock = false;
    self.heroBuffData = {}
end

--析构函数
function FuzionFightUI:DestroyUi()
    UiBaseClass.DestroyUi(self)

    self.fighterList = nil
    self.fighterData = nil

    if self.headArray then
        for k,v in ipairs(self.headArray) do
            v.smallCard:DestroyUi()
            for tk,tv in ipairs(v.buffIcons) do
                tv.tex:Destroy()
            end
            
        end
        
        self.headArray = nil
    end
end

--注册回调函数
function FuzionFightUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['on_update_fighter_data'] = Utility.bind_callback(self, self.on_update_fighter_data);
    NoticeManager.BeginListen(ENUM.NoticeType.FuzionFighterData, self.bindfunc['on_update_fighter_data'])

    self.bindfunc['OnBuffAttach'] = Utility.bind_callback(self, self.OnBuffAttach);
    self.bindfunc['OnBuffDetach'] = Utility.bind_callback(self, self.OnBuffDetach);
end

function FuzionFightUI:MsgRegist()

    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(BuffManager.AttachBuff, self.bindfunc['OnBuffAttach'])
    PublicFunc.msg_regist(BuffManager.DetachBuff, self.bindfunc['OnBuffDetach'])
end

function FuzionFightUI:MsgUnRegist()

    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(BuffManager.AttachBuff, self.bindfunc['OnBuffAttach'])
    PublicFunc.msg_unregist(BuffManager.DetachBuff, self.bindfunc['OnBuffDetach'])
end


function FuzionFightUI:OnBuffAttach(obj, bufGid)
    local gid = obj:GetGID()
    
    local buff = obj:GetBuffManager():GetBuffByGid(bufGid)
    if table.index_of(buffIds, buff:GetBuffID()) > 0 then
        self.heroBuffData[gid] = self.heroBuffData[gid] or {}
        table.insert(self.heroBuffData[gid], bufGid)

--        app.log('buff attach ' .. tostring(buff:GetBuffID()) .. ' ' .. obj:GetName())
    end
end

function FuzionFightUI:OnBuffDetach(obj, bufGid)
    local gid = obj:GetGID()

    if self.heroBuffData[gid] ~= nil then
        local index = table.index_of(self.heroBuffData[gid], bufGid)
        if index > 0 then
            table.remove(self.heroBuffData[gid], index)

--            local buff = obj:GetBuffManager():GetBuffByGid(bufGid)
--            app.log('buff detach ' .. tostring(buff:GetBuffID()) .. ' ' .. obj:GetName())
        end
        if table.get_num(self.heroBuffData[gid]) < 1 then
            self.heroBuffData[gid] = nil
        end
    end
end

function FuzionFightUI:InitUI(asset_obj)
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(self.parent)
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_local_position(0,0,0);

    self.ui:set_name('fuzion_fight_ui');

    local path =""
    local headArray = {}
    for i=1, 4 do
        headArray[i] = {}

        local node = self.ui:get_child_by_name('sp_bk'.. tostring(i))
         headArray[i].node = node
        headArray[i].buffIcons = {}
        headArray[i].buffIcons[1] = {tex = ngui.find_texture(node, 'buff1'), sp = ngui.find_sprite(node, 'buff1/sp_mark'), path = nil}
        headArray[i].buffIcons[2] = {tex = ngui.find_texture(node, 'buff2'), sp = ngui.find_sprite(node, 'buff2/sp_mark'), path = nil}
        for k,v in ipairs(headArray[i].buffIcons) do
            v.tex:set_active(false)
        end
        
        headArray[i].hpProgressBar = ngui.find_progress_bar(node, 'pro_xuetiao')
        local headParent = node:get_child_by_name('big_card_item_80')

        --local entity, data = self:GetFighterEntityByIndex(i)
        --local cardInfo = CardHuman:new({number=data.herocid})
        headArray[i].headParent = headParent--SmallCardUi:new({parent = headParent, info = cardInfo, stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Rarity}})
        headArray[i].killLab = ngui.find_label(node,'content1/lab')
        headArray[i].beKilledLab = ngui.find_label(node, 'content2/lab')
        headArray[i].selectSp = ngui.find_sprite(node, 'sp_shine')
        headArray[i].deadTimeLab = ngui.find_label(node, 'lab_die')

--        path = "yeka/btn"..i
--        headArray[i].btn = ngui.find_sprite(self.ui, path)
--        headArray[i].texture = ngui.find_sprite(self.ui, path.."/texture_human")
--        headArray[i].spMask = ngui.find_sprite(self.ui, path.."/people_zhezhao")
--        headArray[i].frame = ngui.find_sprite(self.ui, path.."/sp_frame")
--        headArray[i].progressHP = ngui.find_progress_bar(self.ui, path.."/pro_xuetiao")
--        headArray[i].select = ngui.find_sprite(self.ui, path.."/sp_effect")
--        headArray[i].labTime = ngui.find_label(self.ui, path.."/lab_time")
--        headArray[i].spPoint = ngui.find_sprite(self.ui, path.."/sp_bk")
--        headArray[i].labPoint = ngui.find_label(self.ui, path.."/sp_bk/lab_num")
--        headArray[i].labKillNum = ngui.find_label(self.ui, path.."/cont/sp_di/content1/lab")
--        headArray[i].labDeadNum = ngui.find_label(self.ui, path.."/cont/sp_di/content2/lab")
--        headArray[i].labLevel = ngui.find_label(self.ui, path.."/sp_level_bk/lab")
--        headArray[i].labRankNum = ngui.find_label(self.ui, path.."/sp_bk_di/lab")
--        headArray[i].spLevel = ngui.find_sprite(self.ui, path.."/sp_level_bk")

--        -- 不要求显示等级（fighter也没有等级数据）
--        headArray[i].spLevel:set_active(false)

--        headArray[i].labPoint:set_text("")  -- 没有积分
--        headArray[i].labTime:set_text("")
--        headArray[i].labKillNum:set_text(tostring(0))
--        headArray[i].labDeadNum:set_text(tostring(0))
--        headArray[i].labRankNum:set_text(tostring(i))
    end

    self.headArray = headArray;

	self:UpdateUi();
end

-- 根据gid获取fighter数据
function FuzionFightUI:GetFighterDataByGid(gid)
    for i, v in ipairs(self.fighterData) do
        if v.herogid == gid then
            return v, i;
        end
    end
end

-- 根据index获取entity数据
function FuzionFightUI:GetFighterEntityByIndex(index)
    local data = self.fighterData[index]
    if data then
        for gid, entity in pairs(self.fighterEntity) do
            if data.herogid == gid then
                return entity, data;
            end
        end
    end
end

-- 更新击杀、死亡、排名数据
function FuzionFightUI:UpdateFightData()
    self.fighterData = {};
    for k, v in pairs(self.fighterList or {}) do
        table.insert(self.fighterData, v);
    end

    _SortFighterFunc(self.fighterData)
end

--更新状态
function FuzionFightUI:Update(dt)
    if self.ui == nil then return end

    for i, v in pairs(self.headArray) do
        local entity, data = self:GetFighterEntityByIndex(i)
        if entity and data then

            v.node:set_active(true)

            if v.smallCard == nil then
                
                v.smallCard = SmallCardUi:new({parent = v.headParent, level = data.heroLevel, stypes = { SmallCardUi.SType.Texture,SmallCardUi.SType.Rarity}})
            end

            local oldCardInfo = v.smallCard:GetCardInfo()
            if oldCardInfo == nil or oldCardInfo.number ~= data.herocid then
                local cardInfo = CardHuman:new({number=data.herocid})
                v.smallCard:SetData(cardInfo)
            end

            local max_blood = entity:GetPropertyVal('max_hp');
            local cur_blood = entity:GetPropertyVal('cur_hp');

            local real_value = cur_blood / max_blood
            v.hpProgressBar:set_value(real_value)

            --设置buff图标
            local gid = entity:GetGID()
            local buffData = self.heroBuffData[gid]
            if buffData then
                local iconIndex = 1
                for i=1,2 do
                    local icon = v.buffIcons[iconIndex]
                    local buffgid = buffData[i]
                    local buff = entity:GetBuffManager():GetBuffByGid(buffgid)
                    if buff then
                        iconIndex = iconIndex + 1
                        icon.tex:set_active(true)
                        local path = buff:GetIcon()--'assetbundles/prefabs/ui/image/icon/skill/90_90/anjiunaibai_1.assetbundle'
                        if path and icon.path ~= path then
                            icon.tex:set_texture(path)
                            icon.path = path

                        end

                        local d = buff:GetDuration()
                        local am = 0
                        if d <= 0 then
                            am = 0
                        else
                            local pass = buff:GetDEltaTime()
                            if pass > d then pass = d end
                            am = (d - pass)/d
                        end
                        icon.sp:set_fill_amout(am)
                    else
                        icon.tex:set_active(false)
                    end
                end
            else
                for k,v in ipairs(v.buffIcons) do
                    v.tex:set_active(false)
                end                
            end


            v.killLab:set_text(tostring(data.kill))
            v.beKilledLab:set_text(tostring(data.dead))

            v.selectSp:set_active(self.playerid == data.playerid)

            if cur_blood > 0 then
                v.smallCard:SetGray(false)
                v.deadTimeLab:set_active(false)
            else
                v.smallCard:SetGray(true)
                local duration = PublicFunc.GetDurationByEndTime(data.reliveTime)

                v.deadTimeLab:set_active(true)
                v.deadTimeLab:set_text(tostring(duration))
            end

            
--            -- 更新排名头像
--            local config = ConfigHelper.GetRole(data.herocid)
--            PublicFunc.Set120Icon(v.texture, config.small_icon)
--            -- 更新等级
--            --v.labLevel:set_text(tostring(data.heroLevel))
--            -- 击杀数量
--            v.labKillNum:set_text(tostring(data.kill))
--            -- 死亡次数
--            v.labDeadNum:set_text(tostring(data.dead))
--            -- 选中玩家
--            v.select:set_active(self.playerid == data.playerid)
--            -- 死亡状态
--            if cur_blood > 0 then
--                v.spMask:set_active(false)
--                v.labTime:set_text("")
--            else
--                v.spMask:set_active(true)
--                -- 复活倒计时
--                local duration = PublicFunc.GetDurationByEndTime(data.reliveTime)
--                v.labTime:set_text(tostring(duration))
--            end

        else
            v.node:set_active(false)
        end
    end
end

--刷新界面
function FuzionFightUI:UpdateUi()
	if not UiBaseClass.UpdateUi(self) then
		return
	end

end

-------------------------------------网络回调-------------------------------------
--战斗者数据变化
function FuzionFightUI:on_update_fighter_data()
    self:UpdateFightData()

    -- TODO: 击杀UI展示
end


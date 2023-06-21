Fuzion2FightUI = Class('Fuzion2FightUI', UiBaseClass);


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
function Fuzion2FightUI:Init(data)
    self.pathRes = 'assetbundles/prefabs/ui/new_fight/new_fight_ui_10v10.assetbundle';
    UiBaseClass.Init(self, data)
end

--重新开始
function Fuzion2FightUI:Restart(data)
    UiBaseClass.Restart(self, data)
end

--初始化数据
function Fuzion2FightUI:InitData(data)
    UiBaseClass.InitData(self, data)

    self.parent = data.parent
    self.playerid = g_dataCenter.player.playerid

    local fightManager = FightScene.GetFightManager()
    self.fighterEntity = fightManager.heroList
    self.fighterList = g_dataCenter.fuzion2.playerList;
    self:UpdateFightData()
    self.showLock = false;
    self.heroBuffData = {}
end

--析构函数
function Fuzion2FightUI:DestroyUi()
	if self.rankUI then
		self.rankUI:DestroyUi();
		self.rankUI = nil;
	end

    self.fighterList = nil
    self.fighterData = nil

    UiBaseClass.DestroyUi(self)
end

--注册回调函数
function Fuzion2FightUI:RegistFunc()
    UiBaseClass.RegistFunc(self)
    self.bindfunc['on_update_fighter_data'] = Utility.bind_callback(self, self.on_update_fighter_data);
    NoticeManager.BeginListen(ENUM.NoticeType.FuzionFighterData, self.bindfunc['on_update_fighter_data'])

    self.bindfunc['OnBuffAttach'] = Utility.bind_callback(self, self.OnBuffAttach);
    self.bindfunc['OnBuffDetach'] = Utility.bind_callback(self, self.OnBuffDetach);
    self.bindfunc["on_rank"] = Utility.bind_callback(self, self.on_rank);
end

function Fuzion2FightUI:MsgRegist()

    UiBaseClass.MsgRegist(self)

    PublicFunc.msg_regist(BuffManager.AttachBuff, self.bindfunc['OnBuffAttach'])
    PublicFunc.msg_regist(BuffManager.DetachBuff, self.bindfunc['OnBuffDetach'])
end

function Fuzion2FightUI:MsgUnRegist()

    UiBaseClass.MsgUnRegist(self)

    PublicFunc.msg_unregist(BuffManager.AttachBuff, self.bindfunc['OnBuffAttach'])
    PublicFunc.msg_unregist(BuffManager.DetachBuff, self.bindfunc['OnBuffDetach'])
end


function Fuzion2FightUI:OnBuffAttach(obj, bufGid)
    local gid = obj:GetGID()
    
    local buff = obj:GetBuffManager():GetBuffByGid(bufGid)
    if table.index_of(buffIds, buff:GetBuffID()) > 0 then
        self.heroBuffData[gid] = self.heroBuffData[gid] or {}
        table.insert(self.heroBuffData[gid], bufGid)

       -- app.log('buff attach ' .. tostring(buff:GetBuffID()) .. ' ' .. obj:GetName())
    end
end

function Fuzion2FightUI:OnBuffDetach(obj, bufGid)
    local gid = obj:GetGID()

    if self.heroBuffData[gid] ~= nil then
        local index = table.index_of(self.heroBuffData[gid], bufGid)
        if index > 0 then
            table.remove(self.heroBuffData[gid], index)

           -- local buff = obj:GetBuffManager():GetBuffByGid(bufGid)
           -- app.log('buff detach ' .. tostring(buff:GetBuffID()) .. ' ' .. obj:GetName())
        end
        if table.get_num(self.heroBuffData[gid]) < 1 then
            self.heroBuffData[gid] = nil
        end
    end
end

function Fuzion2FightUI:InitUI(asset_obj)
    self.ui = asset_game_object.create(asset_obj);
    self.ui:set_parent(self.parent)
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_local_position(0,0,0);

    self.ui:set_name('fuzion_fight_ui');

    self.playerIcon = {};
    for i=1,10 do
    	self.playerIcon[i] = {};
    	self.playerIcon[i].root = self.ui:get_child_by_name("content/sp_frame ("..(i-1)..")");
    	self.playerIcon[i].head = ngui.find_sprite(self.playerIcon[i].root,"sp_human");
    	self.playerIcon[i].fork = self.playerIcon[i].root:get_child_by_name("sp_cha");
    	self.playerIcon[i].shine = self.playerIcon[i].root:get_child_by_name("sp_shine");
    	self.playerIcon[i].mark = self.playerIcon[i].root:get_child_by_name("sp_mark");
    	self.playerIcon[i].lab = ngui.find_label(self.playerIcon[i].root,"lab");
    end

    self.heroList = {};
    for i=1,3 do
    	self.heroList[i] = {};
    	self.heroList[i].obj = self.ui:get_child_by_name("cont/big_card_item_80"..i);
    	local data = {};
    	data.parent = self.heroList[i].obj;
    	data.stypes = {SmallCardUi.SType.Texture,}
    	self.heroList[i].card = SmallCardUi:new(data);
    end

    local btnRank = ngui.find_sprite(self.ui,"sp_yuan");
    btnRank:set_on_ngui_press(self.bindfunc["on_rank"]);

    self.labKillNum = ngui.find_label(self.ui,"sp_di/content_skill/sp_skill/lab");
    self.labDeadNum = ngui.find_label(self.ui,"sp_di/content_skill/sp_die/lab");

	self:UpdateUi();
    self:UpdateFightData()
end

function Fuzion2FightUI:on_rank(name,istouch,x,y)
	if istouch then
		if not self.rankUI then
			self.rankUI = Fuzion2RankUI.Start()
		end
		self.rankUI:SetData(self.fighterList);
		self.rankUI:Show();
    else
		self.rankUI:Hide();
    end
end

-- 根据gid获取fighter数据
function Fuzion2FightUI:GetFighterDataByGid(gid)
    for i, v in ipairs(self.fighterData) do
        if v.playerid == gid then
            return v, i;
        end
    end
end

-- 根据index获取entity数据
function Fuzion2FightUI:GetFighterEntityByIndex(index)
    local data = self.fighterData[index]
    if data then
    	return self.fighterEntity[data.herogid], data;
    end
end

-- 更新击杀、死亡、排名数据
function Fuzion2FightUI:UpdateFightData()
    self.fighterData = {};
    for k, v in pairs(self.fighterList or {}) do
        table.insert(self.fighterData, v);
    end
    if not self.ui then return end;
    local playerInfo = g_dataCenter.fuzion2:GetMyPlayerData();
    -- 击杀数量
    self.labKillNum:set_text(tostring(playerInfo.kill))
    -- 死亡次数
    self.labDeadNum:set_text(tostring(playerInfo.dead))

    -- _SortFighterFunc(self.fighterData)
    for i, v in pairs(self.playerIcon) do
        local entity, data = self:GetFighterEntityByIndex(i)
        if entity and data then
            local deadTimes = data.dead or 0;
            local role_index = deadTimes + 1;
            v.root:set_active(true);
            local cardInfo = nil;
            if role_index <= #data.HeroList then
                cardInfo = PropsEnum.GetConfig(data.HeroList[role_index]);
                v.lab:set_text(tostring(role_index));
                v.fork:set_active(false);
                v.head:set_sprite_name(cardInfo.small_icon);
            else
                cardInfo = PropsEnum.GetConfig(data.HeroList[#data.HeroList]);
                v.fork:set_active(true);
                v.lab:set_text("");
            end
            v.shine:set_active(self.playerid == data.playerid)
        else
            v.root:set_active(false);
        end
    end

    local data = g_dataCenter.fuzion2:GetMyPlayerData()
    if data then
        for i, v in pairs(self.heroList) do
            local id = data.HeroList[i];
            if id then
                v.obj:set_active(true);
                if not v.card:GetCardInfo() or id ~= v.card:GetCardInfo().number then
                    local cardInfo = CardHuman:new({number=id});
                    v.card:SetData(cardInfo);
                end
                local dead = data.dead or 0;
                if i == (dead + 1) then
                    v.obj:set_local_scale(1,1,1);
                    v.card:SetGray(false);
                else
                    if i==#data.HeroList and i == dead then
                        GetMainUI():InitTouchMoveCamera();
                        GetMainUI():InitViewer();
                        GetMainUI():RemoveComponent(EMMOMainUICOM.MainUIJoystick);
                        GetMainUI():RemoveComponent(EMMOMainUICOM.MainUISkillInput);
                        v.obj:set_local_scale(1,1,1);
                    else
                        v.obj:set_local_scale(0.7,0.7,0.7);
                    end
                    if i <= (dead+1) then
                        v.card:SetGray(true);
                    end
                end
            else
                v.obj:set_active(false);
            end
        end
    end
end

--更新状态
function Fuzion2FightUI:Update(dt)
    if self.ui == nil then return end

    for i, v in pairs(self.playerIcon) do
        local entity, data = self:GetFighterEntityByIndex(i)
        if entity and data then
        	-- local deadTimes = data.dead or 0;
        	-- local role_index = deadTimes + 1;
        	-- v.root:set_active(true);
        	-- local cardInfo = nil;
        	-- if role_index <= #data.HeroList then
        	-- 	cardInfo = PropsEnum.GetConfig(data.HeroList[role_index]);
        	-- 	v.lab:set_text(tostring(role_index));
        	-- 	v.fork:set_active(false);
        	-- 	v.head:set_sprite_name(cardInfo.small_icon);
        	-- else
        	-- 	cardInfo = PropsEnum.GetConfig(data.HeroList[#data.HeroList]);
        	-- 	v.fork:set_active(true);
        	-- 	v.lab:set_text("");
        	-- end
        	-- v.shine:set_active(self.playerid == data.playerid)

            --设置buff图标
            -- local gid = entity:GetGID()
            -- local buffData = self.heroBuffData[gid]
            -- if buffData then
            --     local iconIndex = 1
            --     for i=1,2 do
            --         local icon = v.buffIcons[iconIndex]
            --         local buffgid = buffData[i]
            --         local buff = entity:GetBuffManager():GetBuffByGid(buffgid)
            --         if buff then
            --             iconIndex = iconIndex + 1
            --             icon.tex:set_active(true)
            --             local path = buff:GetIcon()--'assetbundles/prefabs/ui/image/icon/skill/90_90/anjiunaibai_1.assetbundle'
            --             if path and icon.path ~= path then
            --                 icon.tex:set_texture(path)
            --                 icon.path = path

            --             end

            --             local d = buff:GetDuration()
            --             local am = 0
            --             if d <= 0 then
            --                 am = 0
            --             else
            --                 local pass = buff:GetDEltaTime()
            --                 if pass > d then pass = d end
            --                 am = (d - pass)/d
            --             end
            --             icon.sp:set_fill_amout(am)
            --         else
            --             icon.tex:set_active(false)
            --         end
            --     end
            -- else
            --     for k,v in ipairs(v.buffIcons) do
            --         v.tex:set_active(false)
            --     end                
            -- end


            -- v.killLab:set_text(tostring(data.kill))
            -- v.beKilledLab:set_text(tostring(data.dead))

            -- v.selectSp:set_active(self.playerid == data.playerid)
            local cur_blood = entity:GetPropertyVal('cur_hp');
            if cur_blood > 0 then
                -- v.smallCard:SetGray(false)
                -- v.deadTimeLab:set_active(false)
            else
                -- v.smallCard:SetGray(true)
                -- local duration = PublicFunc.GetDurationByEndTime(data.reliveTime)

                -- v.deadTimeLab:set_active(true)
                -- v.deadTimeLab:set_text(tostring(duration))
                GetMainUI():GetMinimap():DeletePeople(entity);
            end

            
           -- -- 更新排名头像
           -- local config = ConfigHelper.GetRole(data.herocid)
           -- PublicFunc.Set120Icon(v.texture, config.small_icon)
           -- -- 更新等级
           -- --v.labLevel:set_text(tostring(data.heroLevel))
           -- -- 击杀数量
           -- v.labKillNum:set_text(tostring(data.kill))
           -- -- 死亡次数
           -- v.labDeadNum:set_text(tostring(data.dead))
           -- -- 选中玩家
           -- v.select:set_active(self.playerid == data.playerid)
           -- -- 死亡状态
           -- if cur_blood > 0 then
           --     v.spMask:set_active(false)
           --     v.labTime:set_text("")
           -- else
           --     v.spMask:set_active(true)
           --     -- 复活倒计时
           --     local duration = PublicFunc.GetDurationByEndTime(data.reliveTime)
           --     v.labTime:set_text(tostring(duration))
           -- end

        -- else
            -- v.root:set_active(false);
        end
    end

end

-------------------------------------网络回调-------------------------------------
--战斗者数据变化
function Fuzion2FightUI:on_update_fighter_data()
    self:UpdateFightData()

    -- TODO: 击杀UI展示
end

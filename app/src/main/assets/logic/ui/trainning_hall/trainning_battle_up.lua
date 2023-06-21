
Trainningbattleup = Class("Trainningbattleup", MultiResUiBaseClass)

-------------------------------------外部调用-------------------------------------
function Trainningbattleup:GetNavigationAdvPlane()
    return true;
end
function Trainningbattleup:ShowNavigationBar()
    return true
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_825_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _uiText = 
{
	[1] = '点击屏幕任意位置关闭'
}

function Trainningbattleup:Init(data)
    self.Trainningbattleup = data
    --self.pathRes = "assetbundles/prefabs/ui/zhandui/ui_4606_zhandui.assetbundle"
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function Trainningbattleup:Restart(data)

    if UiBaseClass.Restart(self, data) then
	
    end
end

function Trainningbattleup:RestartData(data)
    CommonClearing.canClose = false
end

function Trainningbattleup:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainningbattleup:DestroyUi()
    

    
    MultiResUiBaseClass.DestroyUi(self);

end

function Trainningbattleup:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_close'] = Utility.bind_callback(self, self.on_click_close);
    self.bindfunc['upheroinfo'] = Utility.bind_callback(self, self.upheroinfo);
    self.bindfunc["rushUI"] = Utility.bind_callback(self, self.rushUI);

end


--注册消息分发回调函数
function Trainningbattleup:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_training_group_advance, self.bindfunc["upheroinfo"])
end

--注销消息分发回调函数
function Trainningbattleup:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_training_group_advance, self.bindfunc["upheroinfo"])
end


--初始化UI
function Trainningbattleup:InitedAllUI()
    --UiBaseClass.InitUI(self, asset_obj)
    
    local backui = self.uis[resPaths[resType.Back]]
    local tipCloseLabel = ngui.find_label(backui, "txt")
    tipCloseLabel:set_text(_uiText[1])
    local frontParentNode = backui:get_child_by_name("add_content")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
    
    self.ui:set_name('Trainningbattleup');
    self.close = ngui.find_button(backui,"mark")
    self.close:set_on_ngui_click(self.bindfunc['on_click_close'])
    
    local TopTitle = ngui.find_sprite(backui,"sp_art_font")
    TopTitle:set_sprite_name("js_jinjiechenggong")
    
    --self.title = ngui.find_label(self.ui,"center_other/animation/sp_di/lab_titile")
    --self.uplvl = ngui.find_label(self.ui,"center_other/animation/sp_di/lab_lv")
    --self.proup = ngui.find_label(self.ui,"center_other/animation/sp_di/lab_text")
    
    self.lab_title = ngui.find_label(self.ui,"lab_level")
    self.lab_title2 = ngui.find_label(self.ui,"lab_level/lab")
    --self.lab2 = ngui.find_label(self.ui,"center_other/animation/sp_di/lab2")
    self.prolabTit1 = ngui.find_label(self.ui,"grid_nature/lab_nature1")
    self.prolaboldvalue1 = ngui.find_label(self.ui,"grid_nature/lab_nature1/lab_num")
    self.prolabvalue1 = ngui.find_label(self.ui,"grid_nature/lab_nature1/lab")
    
    self.prolabTit2 = ngui.find_label(self.ui,"grid_nature/lab_nature2")
    self.prolaboldvalue2 = ngui.find_label(self.ui,"grid_nature/lab_nature2/lab_num")
    self.prolabvalue2 = ngui.find_label(self.ui,"grid_nature/lab_nature2/lab")
    
    self.prolabTit3 = ngui.find_label(self.ui,"grid_nature/lab_nature3")
    self.prolaboldvalue3 = ngui.find_label(self.ui,"grid_nature/lab_nature3/lab_num")
    self.prolabvalue3 = ngui.find_label(self.ui,"grid_nature/lab_nature3/lab")
    
    -- self.oldfightvalue = ngui.find_label(self.ui,"sp_fight/lab_fight")
    -- self.newfightvalue = ngui.find_label(self.ui,"sp_fight/lab_num")

    --self:setData()

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function Trainningbattleup:on_click_close()

    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    uiManager:PopUi()
end

function Trainningbattleup:UpdateUi()
    
end

function Trainningbattleup:upheroinfo(gid,newLevel)
    --local data = g_dataCenter.trainning:get_BattleLvl()
    --app.log("gid #########"..tostring(gid).."#######"..tostring(newLevel))

    self.upshuxingList = {};
	
    --local battledata = g_dataCenter.trainning:get_BattleLvl()[gid]
    local battleLvl = newLevel - 1
    local nextbattlelvl = newLevel
    
    local adv_pro = "t_".."training_hall_grouping_adv_prop_"..tostring(gid)
    local adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);
    local next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],nextbattlelvl);
    
    -- self.newfightvaluet = tostring(g_dataCenter.player:GetFightValue())
    -- self.oldfightvaluet = tostring(g_dataCenter.player:GetOldFightValue())
    --app.log("next_adv_data==========="..table.tostring(next_adv_data))

    if next_adv_data == nil then
        --do return end
        next_adv_data = ConfigManager.Get(EConfigIndex[adv_pro],battleLvl);

        local add_hp = adv_data.add_hp
        local next_add_hp = next_adv_data.add_hp
        
        if 0 < next_add_hp then
            local tit = {"生命：",add_hp,next_add_hp}
            table.insert(self.upshuxingList,tit)
        end
        
        local atk_power = adv_data.atk_power
        local next_atk_power = next_adv_data.atk_power
        
        if 0 < next_atk_power then
            local tit = {"攻击：",atk_power,next_atk_power}
            table.insert(self.upshuxingList,tit)
        end
        
        local def_power = adv_data.def_power
        local next_def_power = next_adv_data.def_power
        
        if 0 < next_def_power then
            local tit = {"防御：",def_power,next_def_power}
            table.insert(self.upshuxingList,tit)
        end
        
        local crit_rate = adv_data.crit_rate
        local next_crit_rate = next_adv_data.crit_rate
        
         if 0 < next_crit_rate then
        local tit = {"暴击率：",crit_rate,next_crit_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local anti_crite = adv_data.anti_crite
        local next_anti_crite = next_adv_data.anti_crite
        
         if 0 < next_anti_crite then
        local tit = {"免爆率：",anti_crite,next_anti_crite}
        table.insert(self.upshuxingList,tit)
        end
        
        local crit_hurt = adv_data.crit_hurt
        local next_crit_hurt = next_adv_data.crit_hurt
        
         if 0 < next_crit_hurt then
        local tit = {"暴击伤害加成：",crit_hurt,next_crit_hurt}
        table.insert(self.upshuxingList,tit)
        end
        
        local broken_rate = adv_data.broken_rate
        local next_broken_rate = next_adv_data.broken_rate
        
         if 0 < next_broken_rate then
        local tit = {"破击率：",broken_rate,next_broken_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local parry_rate = adv_data.parry_rate
        local next_parry_rate = next_adv_data.parry_rate
        
         if 0 < next_parry_rate then
        local tit = {"格挡率：",parry_rate,next_parry_rate}
        table.insert(self.upshuxingList,tit)
        end
        
        local parry_plus = adv_data.parry_plus
        local next_parry_plus = next_adv_data.parry_plus
        
         if 0 < next_parry_plus then
        local tit = {"格挡伤害加成：",parry_plus,next_parry_plus}
        table.insert(self.upshuxingList,tit)
        end
    else

        local add_hp = adv_data.add_hp
        local next_add_hp = next_adv_data.add_hp
        
        if add_hp ~= next_add_hp then
        	local tit = {"生命：",add_hp,next_add_hp}
        	table.insert(self.upshuxingList,tit)
        end
    	
        local atk_power = adv_data.atk_power
        local next_atk_power = next_adv_data.atk_power
        
        if atk_power ~= next_atk_power then
        	local tit = {"攻击：",atk_power,next_atk_power}
        	table.insert(self.upshuxingList,tit)
        end
        
        local def_power = adv_data.def_power
        local next_def_power = next_adv_data.def_power
        
        if def_power ~= next_def_power then
        	local tit = {"防御：",def_power,next_def_power}
        	table.insert(self.upshuxingList,tit)
        end
        
        local crit_rate = adv_data.crit_rate
        local next_crit_rate = next_adv_data.crit_rate
        
         if crit_rate ~= next_crit_rate then
    	local tit = {"暴击率：",crit_rate,next_crit_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local anti_crite = adv_data.anti_crite
        local next_anti_crite = next_adv_data.anti_crite
        
         if anti_crite ~= next_anti_crite then
    	local tit = {"免爆率：",anti_crite,next_anti_crite}
    	table.insert(self.upshuxingList,tit)
        end
        
        local crit_hurt = adv_data.crit_hurt
        local next_crit_hurt = next_adv_data.crit_hurt
        
         if crit_hurt ~= next_crit_hurt then
    	local tit = {"暴击伤害加成：",crit_hurt,next_crit_hurt}
    	table.insert(self.upshuxingList,tit)
        end
        
        local broken_rate = adv_data.broken_rate
        local next_broken_rate = next_adv_data.broken_rate
        
         if broken_rate ~= next_broken_rate then
    	local tit = {"破击率：",broken_rate,next_broken_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local parry_rate = adv_data.parry_rate
        local next_parry_rate = next_adv_data.parry_rate
        
         if parry_rate ~= next_parry_rate then
    	local tit = {"格挡率：",parry_rate,next_parry_rate}
    	table.insert(self.upshuxingList,tit)
        end
        
        local parry_plus = adv_data.parry_plus
        local next_parry_plus = next_adv_data.parry_plus
        
         if parry_plus ~= next_parry_plus then
    	local tit = {"格挡伤害加成：",parry_plus,next_parry_plus}
    	table.insert(self.upshuxingList,tit)
        end
    end
    
    self.newLevel = newLevel
    
    --app.log("self.upshuxingList#########"..table.tostring(self.upshuxingList))
    
    --for k,v in pairs()
    
    self.titletext = {};
        
    self.protext = {};

    self.oldprotext = {};
    
    for k,v in pairs(self.upshuxingList) do
    	--self.titletext = self.titletext..v[1].."[0DC60DFF]".."+"..tostring(PublicFunc.AttrInteger(v[3]-v[2])).."[-]".."\n"
    	self.titletext[k] = v[1]
    	self.protext[k] = tostring(PublicFunc.AttrInteger(v[3]-v[2]))
        self.oldprotext[k] = tostring(PublicFunc.AttrInteger(v[2]))
    end

    -- self.oldfightvalue:set_text(self.oldfightvaluet)
    -- self.newfightvalue:set_text(self.newfightvaluet)
    
    --app.log("self.titletext#########"..table.tostring(self.titletext))
    
    if self.prolabTit3 then
	self.lab_title:set_text("Lv."..tostring(self.newLevel-1))
	self.lab_title2:set_text("Lv."..tostring(self.newLevel))
	--self.lab2:set_text(self.titletext)
	--self.prolabTit:set_text()
	if self.titletext[1] then
	    self.prolabTit1:set_text(self.titletext[1])
	else
	    self.prolabTit1:set_text("")
	end
	if self.titletext[2] then
	    self.prolabTit2:set_text(self.titletext[2])
	else
	    self.prolabTit2:set_text("")
	end
	if self.titletext[3] then
	    self.prolabTit3:set_text(self.titletext[3])
	else
	    self.prolabTit3:set_text("")
	end
	
	if self.protext[1] then
	    self.prolabvalue1:set_text(self.protext[1])
	else
	    self.prolabvalue1:set_text("")
	end
	
	if self.protext[2] then
	    self.prolabvalue2:set_text(self.protext[2])
	else
	    self.prolabvalue2:set_text("")
	end
	
	if self.protext[3] then
	    self.prolabvalue3:set_text(self.protext[3])
	else
	    self.prolabvalue3:set_text("")
	end

    if self.oldprotext[1] then
        self.prolaboldvalue1:set_text(self.oldprotext[1])
    else
        self.prolaboldvalue1:set_text("")
    end

    if self.oldprotext[2] then
        self.prolaboldvalue2:set_text(self.oldprotext[2])
    else
        self.prolaboldvalue2:set_text("")
    end

    if self.oldprotext[3] then
        self.prolaboldvalue3:set_text(self.oldprotext[3])
    else
        self.prolaboldvalue3:set_text("")
    end
	
    else
	self.timeid = timer.create(self.bindfunc["rushUI"],300,-1)
    end
end

function Trainningbattleup:rushUI()
    if self.prolabTit3 then
    	self.lab_title:set_text("Lv."..tostring(self.newLevel-1))
    	self.lab_title2:set_text("Lv."..tostring(self.newLevel))
    	--self.lab2:set_text(self.titletext)
    	--self.prolabTit:set_text()
    	if self.titletext[1] then
    	    self.prolabTit1:set_text(self.titletext[1])
    	else
    	    self.prolabTit1:set_text("")
    	end
    	if self.titletext[2] then
    	    self.prolabTit2:set_text(self.titletext[2])
    	else
    	    self.prolabTit2:set_text("")
    	end
    	if self.titletext[3] then
    	    self.prolabTit3:set_text(self.titletext[3])
    	else
    	    self.prolabTit3:set_text("")
    	end
    	
    	if self.protext[1] then
    	    self.prolabvalue1:set_text(self.protext[1])
    	else
    	    self.prolabvalue1:set_text("")
    	end
    	
    	if self.protext[2] then
    	    self.prolabvalue2:set_text(self.protext[2])
    	else
    	    self.prolabvalue2:set_text("")
    	end
    	
    	if self.protext[3] then
    	    self.prolabvalue3:set_text(self.protext[3])
    	else
    	    self.prolabvalue3:set_text("")
    	end

        if self.oldprotext[1] then
            self.prolaboldvalue1:set_text(self.oldprotext[1])
        else
            self.prolaboldvalue1:set_text("")
        end

        if self.oldprotext[2] then
            self.prolaboldvalue2:set_text(self.oldprotext[2])
        else
            self.prolaboldvalue2:set_text("")
        end

        if self.oldprotext[3] then
            self.prolaboldvalue3:set_text(self.oldprotext[3])
        else
            self.prolaboldvalue3:set_text("")
        end

        -- self.oldfightvalue:set_text(self.oldfightvaluet)
        -- self.newfightvalue:set_text(self.newfightvaluet)

    	if self.timeid then
    	    timer.stop(self.timeid)
    	    self.timeid = nil;
    	end
    end    
end



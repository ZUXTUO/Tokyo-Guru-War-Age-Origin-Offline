
Trainninguplv = Class("Trainninguplv", MultiResUiBaseClass)

-------------------------------------外部调用-------------------------------------
function Trainninguplv:GetNavigationAdvPlane()
    return true;
end
function Trainninguplv:ShowNavigationBar()
    return true
end

local resType = 
{
    Front = 1,
    Back = 2,
}

local resPaths = 
{
    [resType.Front] = 'assetbundles/prefabs/ui/new_fight/ui_824_fight.assetbundle';
    [resType.Back] = 'assetbundles/prefabs/ui/new_fight/panel_jiesuan_item.assetbundle';
}

local _uiText = 
{
	[1] = '点击屏幕任意位置关闭'
}

function Trainninguplv:Init(data)
    self.Trainninguplv = data
    self.pathRes = resPaths
    MultiResUiBaseClass.Init(self, data);
end

function Trainninguplv:RestartData(data)
    CommonClearing.canClose = false
end

function Trainninguplv:InitData(data)
    
    self.AllHerolist =  ConfigManager._GetConfigTable(EConfigIndex.t_training_hall_grouping);
    UiBaseClass.InitData(self, data)
end

function Trainninguplv:OnLoadUI()
    UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function Trainninguplv:DestroyUi()
    

    
    MultiResUiBaseClass.DestroyUi(self);

end

function Trainninguplv:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc['on_click_close'] = Utility.bind_callback(self, self.on_click_close);
    self.bindfunc['upheroinfo'] = Utility.bind_callback(self, self.upheroinfo);
    self.bindfunc['rushUI'] = Utility.bind_callback(self, self.rushUI);
    
end


--注册消息分发回调函数
function Trainninguplv:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_training_hall_hero_advance, self.bindfunc["upheroinfo"])
end

--注销消息分发回调函数
function Trainninguplv:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_training_hall_hero_advance, self.bindfunc["upheroinfo"])
end


--初始化UI
function Trainninguplv:InitedAllUI()
    
    local backui = self.uis[resPaths[resType.Back]]
    local tipCloseLabel = ngui.find_label(backui, "txt")
    tipCloseLabel:set_text(_uiText[1])
    local frontParentNode = backui:get_child_by_name("add_content")
    self.titileSPrite = ngui.find_sprite(backui, "sp_art_font")
    self.ui = self.uis[resPaths[resType.Front]]
    self.ui:set_parent(frontParentNode)
        
    self.ui:set_name('Trainninguplv');

    self.close = ngui.find_button(backui,"mark")
    self.close:set_on_ngui_click(self.bindfunc['on_click_close'])
    
    self.titileSPrite:set_sprite_name("js_jinjiexunlian")
    self.title = ngui.find_label(self.ui,"lab_chenghao")

    self.infotxt = ngui.find_label(self.ui,"lab_nature1")
    self.infotext = ngui.find_label(self.ui,"lab_nature1/lab_num")
    self.infotext1 = ngui.find_label(self.ui,"lab_nature1/lab")
    --self.infotext:set_text("格挡伤害")
    --app.log("initUI##############################################")

    self.oldfighttxt = ngui.find_label(self.ui,"sp_fight/lab_fight")
    self.newfighttxt = ngui.find_label(self.ui,"sp_fight/lab_num")

    self.infotxt2 = ngui.find_label(self.ui,"lab_nature2")
    self.infotxt2:set_active(false)
    self.infotxt3 = ngui.find_label(self.ui,"lab_nature3")
    self.infotxt3:set_active(false)

    AudioManager.PlayUiAudio(ENUM.EUiAudioType.StarUpHero)
end

function Trainninguplv:on_click_close()

    if not CommonClearing.canClose or app.get_time() - CommonClearing.reciCanCloseTime < PublicStruct.Const.UI_CLOSE_DELAY then return end

    uiManager:PopUi()
end

function Trainninguplv:upheroinfo(id)
    
    local data_id = id
    local cardinfo = g_dataCenter.package:find_card(1, data_id);
    self.currentroleinfo = cardinfo
    
    for k,v in pairs(self.AllHerolist)do
	for kk,vv in pairs(v)do
	    if vv[2] == cardinfo.default_rarity then
		self.currentline = k; --行
		self.currentindex = kk; -- 列
	    end
	end
    end
    
    self:setData()
end

function Trainninguplv:setData()
    
    local lvlindex = self.currentroleinfo.trainingHallLevel
    local currentexp = self.currentroleinfo.trainingHallLevelExp
    --app.log(" lvlindex ######### "..tostring(lvlindex))
    --app.log(" currentexp ######### "..tostring(currentexp))

    self.oldfightvalue = tostring(self.currentroleinfo.oldFight_value)
    self.newfightvalue = tostring(self.currentroleinfo.fight_value)
    
    local currentNeedexp = self.AllHerolist[self.currentline][self.currentindex]          
    local currentNeedexpdata = currentNeedexp.att_lv    
    
    local pzname = "t_"..currentNeedexpdata 
    local titlelvl = "t_"..currentNeedexp.att_adv
    
    local lvl = ConfigManager.Get(EConfigIndex[pzname],lvlindex).adv_level;
    
    --app.log("titlelvl######################"..titlelvl)
    --app.log("lvl######################"..tostring(lvl))
    
    local prodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl-1);
    local nextprodata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
    
    --app.log("prodata#########"..table.tostring(prodata))
    --app.log("nextprodata#########"..table.tostring(nextprodata))
    
    local proname = "";
    local nextvalue = 0;
    local curValue = 0;
    if prodata and nextprodata then
                
	for k,v in pairs(nextprodata)do
	    --app.log("#########"..tostring(v).."kkkkk##########"..tostring(k))
	    if v ~= 0 then
		if k == 2 then
		    proname = "暴击:"
		    nextvalue = v--
		    curValue = prodata[2]
		elseif k == 3 then
		    proname = "免爆:"
		    nextvalue = v
		    curValue = prodata[3]
		elseif k == 4 then
		    proname = "暴伤:"
		    nextvalue = v
		    curValue = prodata[4]
		elseif k == 5 then
		    proname = "破击:"
		    nextvalue = v
		    curValue = prodata[5]
		elseif k == 6 then
		    proname = "格挡:"
		    nextvalue = v
		    curValue = prodata[6]
		elseif k == 7 then
		    proname = "格挡伤害:"
		    nextvalue = v
		    curValue = prodata[7]
		end
	    end
	end
    
    end
    
    --self.pronameinfotext = proname.."提升：+"..tostring(nextvalue - curValue)
    self.pronameinfotxt = proname
    self.pronameinfotext = tostring(curValue)
    self.pronameinfotext1 = tostring(nextvalue)
    
    --app.log("setData ##############################################"..self.pronameinfotext)
    if self.infotext then
    	--self.infotext:set_text(proname.."提升：+"..tostring(nextvalue - curValue))
        self.infotxt:set_text(proname)
    	self.infotext:set_text(tostring(curValue))
    	self.infotext1:set_text(tostring(nextvalue))

        self.oldfighttxt:set_text(self.oldfightvalue)
        self.newfighttxt:set_text(self.newfightvalue)
    else
	   self.timeid = timer.create(self.bindfunc["rushUI"],500,-1)
    end
    
    local titlelvl = "t_"..currentNeedexp.att_adv
    --app.log("###titlelvl#############"..titlelvl.."    @#"..tostring(lvl))
    local titledata = ConfigManager.Get(EConfigIndex[titlelvl],lvl);
    
    self.titleName = titledata.adv_name
    
    if self.title then
	   self.title:set_text(titledata.adv_name)
    end
end

function Trainninguplv:rushUI()
    if self.infotext then
        self.infotxt:set_text(self.pronameinfotxt)
    	self.infotext:set_text(self.pronameinfotext)
    	self.infotext1:set_text(self.pronameinfotext1)
        self.oldfighttxt:set_text(self.oldfightvalue)
        self.newfighttxt:set_text(self.newfightvalue)
    	if self.timeid then
    	    timer.stop(self.timeid)
    	    self.timeid = nil;
    	end
    end
    
    if self.title then
	   self.title:set_text(self.titleName)
    end
    
end

function Trainninguplv:UpdateUi()
    
end




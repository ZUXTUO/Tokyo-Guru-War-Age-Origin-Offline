UiSet = Class('UiSet', UiBaseClass);

function UiSet:Init()
	self.pathRes = "assetbundles/prefabs/ui/set_ui/xin_main2.assetbundle"
	UiBaseClass.Init(self, data);
end

function UiSet:Restart()

     FightSetUI.Start();
	if UiBaseClass.Restart(self, data) then
	--todo 
	end
end

--初始化数据
function UiSet:InitData(data)
    UiBaseClass.InitData(self, data);
    self.musicOpen = g_dataCenter.setting:GetMusic();
    self.soundOpen = g_dataCenter.setting:GetSound();
    self.intelligenceOpen = g_dataCenter.setting:Getintelligence();
    self.oldMusicOpen = g_dataCenter.setting:GetMusic();
    self.oldSoundOpen = g_dataCenter.setting:GetSound();
    --self.huazhivalue = tonumber(g_dataCenter.setting:GetHuazhiValue());
    self.roleData = {};
    self.scard = {};
    --app.log("valuexxxxxxx1111111111111111111111"..tostring(self.huazhivalue))
end

function UiSet:DestroyUi()
    UiBaseClass.DestroyUi(self);
    -- for k,v in pairs(self.scard) do
    --     self.scard[k]:DestroyUi();
    --     self.scard[k] = nil;
    -- end
    if self.uiPlayer then
        self.uiPlayer:DestroyUi();
    end
end

function UiSet:Show()
	if UiBaseClass.Show(self) then
	--todo 
	end
end

function UiSet:Hide()
    if UiBaseClass.Hide(self) then
	--todo 
	end
end

function UiSet:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_music_open"] = Utility.bind_callback(self, self.on_music_open)
    self.bindfunc["on_sound_open"] = Utility.bind_callback(self, self.on_sound_open)
    self.bindfunc["on_intelligence_open"] = Utility.bind_callback(self, self.on_intelligence_open)
    self.bindfunc["on_huazhi_change"] = Utility.bind_callback(self, self.on_huazhi_change)
    self.bindfunc["on_renshu_change"] = Utility.bind_callback(self, self.on_renshu_change)
    self.bindfunc["on_back"] = Utility.bind_callback(self, self.on_back)
    self.bindfunc["on_exit"] = Utility.bind_callback(self, self.on_exit)
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, self.on_btn_close)      --关闭
    self.bindfunc["on_btn_logout"] = Utility.bind_callback(self, self.on_btn_logout)    --退出
    self.bindfunc["on_btn_set"] = Utility.bind_callback(self, self.on_btn_set); -- 设置
    self.bindfunc["on_btn_right"] = Utility.bind_callback(self,self.on_btn_right)       --客户
    
    self.bindfunc["on_btn_bangding"] = Utility.bind_callback(self,self.on_btn_bangding) -- 绑定
    self.bindfunc["on_btn_lingqu"] = Utility.bind_callback(self,self.on_btn_lingqu) -- 领取
    self.bindfunc["on_btn_fuwu"] = Utility.bind_callback(self,self.on_btn_fuwu) -- 服务
    self.bindfunc["on_btn_yingshi"] = Utility.bind_callback(self,self.on_btn_yingshi) -- 隐私
    self.bindfunc["on_btn_xieyi"] = Utility.bind_callback(self,self.on_btn_xieyi) -- 协议

    self.bindfunc["on_ChangeHeadBtn"] = Utility.bind_callback(self,self.on_ChangeHeadBtn) -- 点击更换头像按钮
	self.bindfunc["on_playerHeadChange"] = Utility.bind_callback(self,self.on_playerHeadChange) -- 玩家头像变更事件
	self.bindfunc["on_ChangeNameBtn"] = Utility.bind_callback(self,self.on_ChangeNameBtn)  --战队名称变更事件
        self.bindfunc["on_ChangeName"] = Utility.bind_callback(self,self.on_ChangeName)
end

function UiSet:UnRegistFunc()
	UiBaseClass.UnRegistFunc(self);
end

--注册消息分发回调函数
function UiSet:MsgRegist()
	UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiSet:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
end

--加载UI
function UiSet:LoadUI()
	if UiBaseClass.LoadUI(self) then
	--todo 
	end
end

function UiSet:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_parent(Root.get_root_ui_2d());
	self.ui:set_local_scale(Utility.SetUIAdaptation());
	self.ui:set_name("ui_set");

	self.btn_close = ngui.find_button(self.ui,"centre_other/animation/btn_cha");
	self.btn_close:set_on_click(self.bindfunc["on_btn_close"]);
        
        self.playerHead = self.ui:get_child_by_name("centre_other/animation/content/sp_di1/sp_head_di_item");
        self.uiPlayer = UiPlayerHead:new({parent=self.playerHead,vip = g_dataCenter.player.vip})
        self.uiPlayer:SetRoleId(g_dataCenter.player:GetImage())
        --self.uiPlayer:SetVipLevel(g_dataCenter.player.vip)

        --self.herocard1 = self.ui:get_child_by_name("centre_other/animation/content/sp_di/content_head/big_card_item_801");
        --self.herocard2 = self.ui:get_child_by_name("centre_other/animation/content/sp_di/content_head/big_card_item_801");
        --self.herocard3 = self.ui:get_child_by_name("centre_other/animation/content/sp_di/content_head/big_card_item_801");
        
                
        --PublicFunc.SetPlayerImage(self.SmallCardUI, g_dataCenter.player.image)
        --self.d_p_name = ngui.find_label(self.ui,"ui_set/centre_other/animation/content/sp_di1/lab_name")
        --if self.d_p_name then
        --    self.d_p_name:set_active(false);
        --end
        --姓名
        self.playername = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/sp_bk/lab_name")
        --self.playername:set_active(true)
        --等级
        self.playerlvl = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/lab_level")
        --经验
        self.playerexp = ngui.find_progress_bar(self.ui,"centre_other/animation/content/sp_di1/pro_di")
        --经验LAB
        self.playerexplab = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/pro_di/lab_num")
        --月卡
        self.playeryeuCard = ngui.find_texture(self.ui,"centre_other/animation/content/sp_di1/texture_yueka")
        --VIP卡
        self.playervipCard = ngui.find_texture(self.ui,"centre_other/animation/content/sp_di1/texture_vip")
        
        --self.playervipcon = ngui.find_sprite(self.ui,"centre_other/animation/content/sp_di1/sp_bk/sp_v")
        
        --self.playervip = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/sp_bk/sp_v/lab")
        
        --帐号ID
        self.playerfamily = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/cont1/lab")
        --社团
        self.playerRoleId = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/cont3/lab")
        -- 国家
        self.country_id = ngui.find_label(self.ui, "centre_other/animation/content/sp_di2/cont2/lab");
        --英雄等级上限
        --self.heroMaxLvl = ngui.find_label(self.ui,"centre_other/animation/content/sp_di2/cont2/lab")
        --总战力
        self.AllPower = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/sp_fight/lab_fight")
        --金币
        self.glodlab = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/cont_zichan/sp_bk1/lab")
        --钻石
        self.Diamondslab = ngui.find_label(self.ui,"centre_other/animation/content/sp_di1/cont_zichan/sp_bk2/lab")
        --更换头像按钮
        self.changeHeadBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di1/sp_head_di_item/btn_lab_change");
        self.changeHeadBtn:set_on_click(self.bindfunc["on_ChangeHeadBtn"])
        --修改战队名字
        self.changeNameBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di1/btn1");
        self.changeNameBtn:set_on_click(self.bindfunc["on_ChangeNameBtn"])
        
		--音乐开关
        -- self.MusicBtn = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka/yeka_music/animation/sp_close")
        -- self.MusicBtn:set_on_change(self.bindfunc["on_music_open"])
        --音效开关
        -- self.SoundBtn = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka/yeka_effect/animation/sp_close")
        -- self.SoundBtn:set_on_change(self.bindfunc["on_sound_open"])
        --智能施法
        -- self.intelligenceBtn = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka/yeka_smart/animation/sp_close")
        -- self.intelligenceBtn:set_on_change(self.bindfunc["on_intelligence_open"])
        --画质
        -- self.huazhi1 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_pinzhi/yeka/txt1")
        -- self.huazhi1:set_on_change(self.bindfunc["on_huazhi_change"])
        
        -- self.huazhi2 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_pinzhi/yeka/txt2")
        -- self.huazhi2:set_on_change(self.bindfunc["on_huazhi_change"])
        
        -- self.huazhi3 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_pinzhi/yeka/txt3")
        -- self.huazhi3:set_on_change(self.bindfunc["on_huazhi_change"])
        
        --self.huazhiText = ngui.find_label(self.ui,"centre_other/animation/content2/sp_di/pro_back_music/lab_num_image")
        --人数
        -- self.renshu1 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_num_people/yeka/txt1")
        -- self.renshu1:set_on_change(self.bindfunc["on_renshu_change"])
        
        -- self.renshu2 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_num_people/yeka/txt2")
        -- self.renshu2:set_on_change(self.bindfunc["on_renshu_change"])
        
        -- self.renshu3 = ngui.find_toggle(self.ui,"centre_other/animation/content2/sp_di/yeka_num_people/yeka/txt3")
        -- self.renshu3:set_on_change(self.bindfunc["on_renshu_change"])


        self.btn_grid = ngui.find_grid(self.ui,"centre_other/animation/content/sp_di3/grid")

        --联系客服--》实名按钮
        self.lxkfBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di3/btn3")
        self.lxkfBtn:set_on_click(self.bindfunc["on_btn_right"]);
        --[[阿里需要屏掉实名按钮]]
        --if AppConfig.get_check_uc() then
            self.lxkfBtn:set_active(false);
        --else
            --self.lxkfBtn:set_active(true);
        --end
        --绑定帐号
        self.bdzhBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di3/btn2")
        self.bdzhBtn:set_on_click(self.bindfunc["on_btn_bangding"])
        --领取  ---------- 公告
        self.linqBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di3/btn1")
        self.linqBtn:set_on_click(self.bindfunc["on_btn_lingqu"])
        --服务条款
        self.fwtkBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di3/btn4")
        self.fwtkBtn:set_active(false)
        -- self.fwtkBtn:set_on_click(self.bindfunc["on_btn_fuwu"])
        --self.fwtk_lab = ngui.find_label(self.ui, "centre_other/animation/content/cont/sp_down_di/txt1");
        --self.fwtk_lab:set_on_ngui_click(self.bindfunc["on_btn_fuwu"]);
        -- 协议
        self.yszcBtn = ngui.find_button(self.ui,"centre_other/animation/content/sp_di3/btn5")
        self.yszcBtn:set_on_click(self.bindfunc["on_btn_xieyi"])
        --self.yszc_lab = ngui.find_label(self.ui, "centre_other/animation/content/cont/sp_down_di/txt3");
        --self.yszc_lab:set_on_ngui_click(self.bindfunc["on_btn_yingshi"]);

        --隐私政策
        --self.yhxy_lab = ngui.find_label(self.ui, "centre_other/animation/content/cont/sp_down_di/txt2")
        --self.yhxy_lab:set_on_ngui_click(self.bindfunc["on_btn_yingshi"]);

        --退出登录
        self.quitBtn = ngui.find_button(self.ui,"centre_other/animation/btn2")
        
        --暂时屏蔽退出按钮
        self.quitBtn:set_on_click(self.bindfunc["on_btn_logout"]);

        self.setBtn = ngui.find_button(self.ui, "centre_other/animation/btn1");
        self.setBtn:set_on_click(self.bindfunc["on_btn_set"]);


        self.btn_grid:reposition_now()
        --暂时隐藏
        --self.sp_down_di = self.ui:get_child_by_name("centre_other/animation/content/cont/sp_down_di")
        --self.sp_down_di:set_active(false)
	self:UpdateUi();
end

function UiSet:on_ChangeNameBtn()
    --app.log("#show ChangerNameUI##################")
    uiManager:PushUi(EUI.SetUiReName);
end

function UiSet:on_ChangeName( name )
    if name and name ~= "" then
        self.playername:set_text(name)
        self.glodlab:set_text(tostring(g_dataCenter.player.gold))
        self.Diamondslab:set_text(tostring(g_dataCenter.player.crystal))
    end
end

function UiSet:on_ChangeHeadBtn()
	ChangeHeadPanel.ShowUI();
end 

function UiSet:on_playerHeadChange(heroNumber)
	if heroNumber and heroNumber ~= 0 then 
		-- self.SmallCardUI:SetDataNumber(tonumber(heroNumber));
        self.uiPlayer:SetRoleId(g_dataCenter.player.image);
	end 
end 

--注册消息分发回调函数
function UiSet:MsgRegist()
	--app.log("FloatTip:MsgRegist");
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(player.gc_change_player_image,self.bindfunc["on_playerHeadChange"]);
    PublicFunc.msg_regist(player.gc_change_name,self.bindfunc["on_ChangeName"]);
end

--注销消息分发回调函数
function UiSet:MsgUnRegist()
	--app.log("FloatTip:MsgUnRegist");
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(player.gc_change_player_image,self.bindfunc["on_playerHeadChange"]);
    PublicFunc.msg_unregist(player.gc_change_name,self.bindfunc["on_ChangeName"]);
end

function UiSet:on_btn_right()
    --UiAnn.Start(UiAnn.Type.KeFu)
    --app.log("1111111111111111111111111111111111111");
    UiAnn.Start(UiAnn.Type.RealNameAuth,nil,LoginReNameUI.uiann_call_back)
end

--绑定
function UiSet:on_btn_bangding()
  
    UiAnn.Start(UiAnn.Type.KeFu)
    do return end;
    self:Hide();
    uiManager:PushUi(EUI.LoginInGame);   
end
--公告
function UiSet:on_btn_lingqu()
    --app.log("222222222222222222222222222222222222222");
    --UiAnn.Start(UiAnn.Type.GongGao)
    notice_bg.Start(); 
end
--服务
function UiSet:on_btn_fuwu()

    
    UiAnn.Start(UiAnn.Type.FuWu) 
end
--隐私
function UiSet:on_btn_yingshi()
    UiAnn.Start(UiAnn.Type.YinShi) 
end

--用户协议
function UiSet:on_btn_xieyi()
    UiAnn.Start(UiAnn.Type.RegAgreeMent) 
end

function UiSet:UpdateUi()
    if UiBaseClass.UpdateUi(self) then
        --app.log("33333333333333333333333333")
        self.playername:set_text(g_dataCenter.player.name)
        local level = g_dataCenter.player.level;
        self.playerlvl:set_text("等级:"..level)
        
        local exp = g_dataCenter.player.exp; 
        --local curNeedExp = ConfigManager.Get(EConfigIndex.t_player_level,level).exp;
        local curNeedExp = 0;
        self.playerexp:set_value(exp/curNeedExp)
        
        if level == 100 then
            self.playerexplab:set_text("[974d04]".."等级已达到顶级".."[-]")
            self.playerexp:set_value(1/1)
        else

        --app.log("exp ==================="..tostring(exp))
            self.playerexplab:set_text("[974d04]"..tostring(exp).."[-][544793]/"..tostring(curNeedExp).."[-]")
        end
        
        PublicFunc.SetUISpriteGray(self.playervipCard)
        
        local YueKa = g_dataCenter.player.IsYueKa
        --小月卡
        if YueKa > 0 then
            self.playeryeuCard:set_color(1,1,1,1)
        else
            self.playeryeuCard:set_color(0,0,0,1)
        end
        --大月卡
        local vip = g_dataCenter.player.IsYueKa1
        if vip > 0 then
            self.playervipCard:set_color(1,1,1,1)   --0,0,0,1 灰色
        else
            self.playervipCard:set_color(0,0,0,1)
        end
        
        
        local vvip = g_dataCenter.player.vip
        
        --app.log("vip ###################"..tostring(vvip))
        if vvip > 0 then
            --self.playervipcon:set_active(true)
            --self.playervip:set_text(tostring(vvip))
        else
            --self.playervipcon:set_active(false)
            --self.playervip:set_text(tostring(0))
        end
        
        self.playerRoleId:set_text(tostring(g_dataCenter.player:GetShowPlayerID()));
        
        --判断是否有社团
        if g_dataCenter.guild:IsJoinedGuild() then
            self.playerfamily:set_text(g_dataCenter.guild:GetMyGuildName())
        else
            self.playerfamily:set_text("无")
        end
        
        --self.heroMaxLvl:set_text(tostring(level));

        if not g_dataCenter.player.country_id then
             self.country_id:set_text("");
        else
--            app.log("g_dataCenter.player.country_id####"..tostring(g_dataCenter.player.country_id))
            local country_id = g_dataCenter.player.country_id
            if country_id > 0 then
                local country_name = ConfigManager.Get(EConfigIndex.t_country_info,country_id).name
                self.country_id:set_text(country_name);
            else
                self.country_id:set_text("无");
            end
        end
        self.AllPower:set_text(tostring(math.floor(g_dataCenter.player:GetFightValue()))) 
        --for i = 1, 3 do
        --    if (curTeam ~= nil) then
        --        if (curTeam[i]) then
        --            local cardinfo = g_dataCenter.package:find_card(1, curTeam[i]);  fight_value
        --            --app.log("cardinfo="..table.tostring(cardinfo))
        --            if (cardinfo ~= nil) then
        --                self.roleData[i] = g_dataCenter.package:find_card_for_num(1, cardinfo.number);
        --                if not self.scard[i] then
        --                    self.scard[i] = SmallCardUi:new( { parent = self["herocard" .. i], info = self.roleData[i],
        --                                                      stypes = {SmallCardUi.SType.Texture,SmallCardUi.SType.Level,SmallCardUi.SType.Star} });
        --                end
        --            end
        --        end
        --    else
        --        app.log("当前队伍为空");
        --    end
        --end 
        --local gold = g_dataCenter.player.gold;
        --local crystal = g_dataCenter.player.crystal;

        self.glodlab:set_text(tostring(g_dataCenter.player.gold))
        self.Diamondslab:set_text(tostring(g_dataCenter.player.crystal))
        
        local data = g_dataCenter.setting;
        -- self.MusicBtn:set_value(g_dataCenter.setting:GetMusic())
        -- self.SoundBtn:set_value(g_dataCenter.setting:GetSound())
        -- self.intelligenceBtn:set_value(g_dataCenter.setting:Getintelligence())
        
        
        local Huazhivalue = tonumber(g_dataCenter.setting:GetHuazhiValue())
        local Renshuvalue = tonumber(g_dataCenter.setting:GetRenshuValue())
        --app.log("3333333333333333333333333333333333333333"..tostring(Renshuvalue));
        -- self:GetHuazhiText(Huazhivalue)
        -- self:GetRenshuText(Renshuvalue)
        --self.huazhi:set_value(value)
        --
        --self.huazhiText:set_text(self:GetHuazhiText(value))
        
    end
end

function UiSet:GetHuazhiText(value)
    --local Text = "中"
    --app.log("value333333333333333333333333333333333"..tostring(value));
    if value == 1 then
        --app.log("11111111111111")
        self.huazhi1:set_value(true)
    elseif value ==2 then
        --app.log("11111111111111")
        self.huazhi2:set_value(true)
    elseif value ==3 then
        --app.log("11111111111111")
        self.huazhi3:set_value(true)
    end
    
    --return Text
end

function UiSet:GetRenshuText(value)
    if value == 1 then
        self.renshu1:set_value(true)
    elseif value ==2 then
        self.renshu2:set_value(true)
    elseif value ==3 then
        self.renshu3:set_value(true)
    end
end

function UiSet:ShowNavigationBar()
    return false
end

function UiSet:Show()
    --app.log("11111111111111111111111")
    if UiBaseClass.Show(self) then
        --app.log("222222222222222222")
        self:UpdateUi()
    end
end

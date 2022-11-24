local is_single = true;   -- 是否是单机模式

UiBase = Class('UiBase', UiBaseClass);
-- pathRes._3d_bg001 = "assetbundles/prefabs/3dui/3d_bg001/3d_bg001.assetbundle";
-- pathRes.panel_roll_item = "assetbundles/prefabs/ui/main/panel_roll_item.assetbundle";

local _local = { }
_local.UIText = {
    [1] = "级开启",-- XX级开启
}

function UiBase:Init(data)
	self.pathRes = "assetbundles/prefabs/ui/main/xin_main.assetbundle";
	UiBaseClass.Init(self, data);
end

function UiBase:InitData(data)
	UiBaseClass.InitData(self, data);
    self.is_out = false;
    self.roleData = { };
    self.index = 1;
    self.scard = {};
end

function UiBase:Restart(data)
	if UiBaseClass.Restart(self, data) then
	--todo 
    end
end

function UiBase:DestroyUi()
    UiBaseClass.DestroyUi(self);
    self.back = nil;
    self.fx_ui = nil;
    self.panel_roll_item = nil;
    self.is_out = false;
    self.index = 1;
    if self.renderTexture then
        self.renderTexture:Destroy();
        self.renderTexture = nil;
    end
    if self.chatUi then
        self.chatUi:DestroyUi();
        self.chatUi = nil;
    end
    if self.ui_setting then
        self.ui_setting:DestroyUi();
        self.ui_setting = nil;
    end
    if self.ui_daily_task then
        self.ui_daily_task:DestroyUi();
        self.ui_daily_task = nil;
    end
    if self.ui_develop_guide then
        self.ui_develop_guide:DestroyUi();
        self.ui_develop_guide = nil;
    end
    if self.texture_back then
        self.texture_back:Destroy();
        self.texture_back = nil;
    end
    if self.texture then
        self.texture:Destroy();
        self.texture = nil;
    end
    if self.texture1 then
        self.texture1:Destroy();
        self.texture1 = nil;
    end
    for k,v in pairs(self.scard) do
        self.scard[k]:DestroyUi();
        self.scard[k] = nil;
    end
end

function UiBase:Show()
    if UiBaseClass.Show(self) then
	    if self.back then
            self.back:set_active(true);
        end
        if self.chatIsShow then
            self:on_chat();
        end
        self:UpdateUi();
	end
end

function UiBase:Hide()
    if UiBaseClass.Hide(self) then
	    if self.back then
            self.back:set_active(false);
        end

        if self.fx_ui then
            self.fx_ui:set_active(false);
        end

        if self.ui_setting then
            self.ui_setting:DestroyUi();
            self.ui_setting = nil;
        end
        if self.ui_daily_task then
            self.ui_daily_task:DestroyUi();
            self.ui_daily_task = nil;
        end

        if self.ui_develop_guide then
            self.ui_develop_guide:DestroyUi();
            self.ui_develop_guide = nil;
        end

        if self.chatUi then
            self.chatUi:DestroyUi();
        end

        if self.panel_roll_item then
            self.panel_roll_item:set_active(false);
        end
        self.anim_left_other:animated_stop("xin_main_left")
	end
end

function UiBase:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["on_drama"] = Utility.bind_callback(self, UiBase.on_drama)
    self.bindfunc["on_vs"] = Utility.bind_callback(self, UiBase.on_vs)
    self.bindfunc["on_organization"] = Utility.bind_callback(self, UiBase.on_organization)
    self.bindfunc["on_play_method"] = Utility.bind_callback(self, UiBase.on_play_method)
    self.bindfunc["on_lottery"] = Utility.bind_callback(self, UiBase.on_lottery)
    self.bindfunc["on_role"] = Utility.bind_callback(self, UiBase.on_role)
    self.bindfunc["on_equipment"] = Utility.bind_callback(self, UiBase.on_equipment)
    self.bindfunc["on_compound"] = Utility.bind_callback(self, UiBase.on_compound)
    self.bindfunc["on_sell"] = Utility.bind_callback(self, UiBase.on_sell)
    self.bindfunc["on_rank_list"] = Utility.bind_callback(self, UiBase.on_rank_list)
    self.bindfunc["on_friend"] = Utility.bind_callback(self, UiBase.on_friend)
    self.bindfunc["on_mail"] = Utility.bind_callback(self, UiBase.on_mail)
    self.bindfunc["on_setting"] = Utility.bind_callback(self, UiBase.on_setting)
    self.bindfunc["on_task"] = Utility.bind_callback(self, UiBase.on_task)
    self.bindfunc["on_sign_in"] = Utility.bind_callback(self, UiBase.on_sign_in)
    self.bindfunc["on_activity"] = Utility.bind_callback(self, UiBase.on_activity)
    self.bindfunc["on_service"] = Utility.bind_callback(self, UiBase.on_service)
    self.bindfunc["on_card1"] = Utility.bind_callback(self, UiBase.on_card1)
    self.bindfunc["on_card2"] = Utility.bind_callback(self, UiBase.on_card2)
    self.bindfunc["on_card3"] = Utility.bind_callback(self, UiBase.on_card3)
    self.bindfunc["on_more"] = Utility.bind_callback(self, UiBase.on_more)
    self.bindfunc["on_chat"] = Utility.bind_callback(self, UiBase.on_chat)
    self.bindfunc["on_left"] = Utility.bind_callback(self, UiBase.on_left)
    self.bindfunc["on_right"] = Utility.bind_callback(self, UiBase.on_right)
    self.bindfunc["on_arena"] = Utility.bind_callback(self, UiBase.on_arena)
    self.bindfunc["on_chat_callback"] = Utility.bind_callback(self, UiBase.on_chat_callback)

    self.bindfunc["gc_task"] = Utility.bind_callback(self, UiBase.gc_task)
    self.bindfunc["on_level_up"] = Utility.bind_callback(self, UiBase.on_level_up)
    self.bindfunc["on_strong"] = Utility.bind_callback(self, UiBase.on_strong)

    NoticeManager.BeginListen(ENUM.NoticeType.PlayerLevelUp, self.bindfunc["on_level_up"])
end

function UiBase:UnRegistFunc()
    NoticeManager.EndListen(ENUM.NoticeType.PlayerLevelUp, self.bindfunc["on_level_up"])
    UiBaseClass.UnRegistFunc(self);
end

--初始化UI
function UiBase:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_parent(Root.get_root_ui_2d());
    self.ui:set_local_scale(1, 1, 1);
    self.ui:set_name("ui_basic");
    -- Root.get_3d_ui_camera():set_active(true);
    -- do return end
    ---------图片----------
    -- 弹出右边栏按钮图片
    self.spMore = ngui.find_sprite(self.ui, "right_other/panel/right/btn_more/sp_more");
    self.spMore1 = ngui.find_sprite(self.ui, "right_other/panel/right/btn_more/sp_more1");
    self.spMore1:set_active(false);


    self.texture_back = ngui.find_texture(self.ui, "texture");
    self.texture_back:set_active(false);

    self.texture = ngui.find_texture(self.ui, "tex_people");
    self.texture:set_active(false);

    self.texture1 = ngui.find_texture(self.ui, "texture1");
    self.texture1:set_active(true);
    -- if self.roleData[1] then
    -- self.renderTexture = RenderTexture:new({texture = self.texture:get_game_object(),role_id = self.roleData[1].number});
    -- else
    -- self.renderTexture = RenderTexture:new({texture = self.texture:get_game_object(),});
    -- end
    -- self.rightyMark = ngui.find_sprite(self.ui,"right_other/panel/mark");
    -- self.rightMark:set_active(false);

    ---------------------按钮及回调事件绑定------------------------
    ---------左边6个按钮--------
    -- 故事冒险
    self.btnDrama = ngui.find_button(self.ui, "left_other/animation/panel_list/scroll_view/btn_drama");
    self.btnDrama:set_on_click(self.bindfunc["on_drama"]);
    -- 对战
    self.btnVs = ngui.find_button(self.ui, "left_other/animation/panel_list/scroll_view/btn_vs");
    self.btnVs:set_on_click(self.bindfunc["on_vs"]);
    -- 组织帮派1
    self.btnOrganization1 = ngui.find_button(self.ui, "left_other/animation/panel_list/scroll_view/btn_organization1");
    self.btnOrganization1:set_on_click(self.bindfunc["on_organization"]);
    self.maskGo = asset_game_object.find("left_other/animation/panel_list/scroll_view/btn_organization1/organization");
    self.lab_org_open_level = ngui.find_label(self.ui, "left_other/animation/panel_list/scroll_view/btn_organization1/organization/lab");
    local openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data
    self.lab_org_open_level:set_text(openLevel .. _local.UIText[1]);
    local notOpen =(openLevel > g_dataCenter.player.level);
    -- 功能未开启
    self.maskGo:set_active(notOpen);
    -- local sp = ngui.find_sprite(self.ui,"left_other/panel_list/scroll_view/btn_organization1/sp_organization")
    -- sp:set_active(false)
    self.btnEgg = ngui.find_button(self.ui, "left_other/animation/panel_list/scroll_view/btn_egg");
    self.btnEgg:set_on_click(self.bindfunc["on_lottery"]);

    -- 玩法
    self.btnPlayMethod = ngui.find_button(self.ui, "left_other/animation/panel_list/scroll_view/btn_play_method");
    self.btnPlayMethod:set_on_click(self.bindfunc["on_play_method"]);
    -- 组织帮派2
    -- self.btnOrganization2 = ngui.find_button(self.ui,"left_other/panel_list/scroll_view/btn_organization2");
    -- self.btnOrganization2:set_on_click(self.bindfunc["on_lottery"]);
    -- 竞技场放到这里
    -- self.btnOrganization2:set_on_click(self.bindfunc["on_arena"]);
    -- 聊天
    self.btnChat = ngui.find_button(self.ui, "left_other/animation/panel_arrows/btn_chat");
    self.btnChat:set_on_click(self.bindfunc["on_chat"]);
    ---------右边3个按钮--------
    -- 任务
    self.btnTask = ngui.find_button(self.ui, "right_top_other/animation/btn_task");
    self.btnTask:set_on_click(self.bindfunc["on_task"]);
    -- 签到
    self.btnSign = ngui.find_button(self.ui, "right_top_other/animation/btn_sign");
    self.btnSign:set_on_click(self.bindfunc["on_sign_in"]);
    -- 活动
    self.btnActivity = ngui.find_button(self.ui, "right_top_other/animation/btn_activity");
    self.btnActivity:set_on_click(self.bindfunc["on_activity"]);
    -- 客服
    self.btnService = ngui.find_button(self.ui, "right_top_other/animation/btn_service");
    self.btnService:set_on_click(self.bindfunc["on_service"]);

    ---------更多的按钮-----------
    -- 角色
    self.btnRole = ngui.find_button(self.ui, "right_other/panel/right/btn_role");
    self.btnRole:set_on_click(self.bindfunc["on_role"]);
    -- 装备
    self.btnEquipment = ngui.find_button(self.ui, "right_other/panel/right/btn_equipment");
    self.btnEquipment:set_on_click(self.bindfunc["on_equipment"]);
    -- 合成
    self.btnCompound = ngui.find_button(self.ui, "right_other/panel/right/btn_compound");
    self.btnCompound:set_on_click(self.bindfunc["on_compound"]);
    -- 出售
    self.btnSell = ngui.find_button(self.ui, "right_other/panel/right/btn_sell");
    self.btnSell:set_on_click(self.bindfunc["on_sell"]);
    self.btnSell:set_enable(false);
    -- 排行榜
    self.btnRankList = ngui.find_button(self.ui, "right_other/panel/right/btn_rank_list");
    self.btnRankList:set_on_click(self.bindfunc["on_rank_list"]);
    --self.btnRankList:set_enable(false);
    -- 更多
    self.btnMore = ngui.find_button(self.ui, "right_other/panel/right/btn_more");
    self.btnMore:set_on_click(self.bindfunc["on_more"], "MyButton.NoneAudio");
    -- 好友
    self.btnFriend = ngui.find_button(self.ui, "right_other/panel/right/btn_friend");
    self.btnFriend:set_on_click(self.bindfunc["on_friend"]);
    self.btnFriend:set_enable(false);
    -- 邮件
    self.btnMail = ngui.find_button(self.ui, "right_other/panel/right/btn_mail");
    self.btnMail:set_on_click(self.bindfunc["on_mail"]);
    -- 设置
    self.btnSet = ngui.find_button(self.ui, "right_other/panel/right/btn_set");
    self.btnSet:set_on_click(self.bindfunc["on_setting"]);

    --变强
    self.btnStrong = ngui.find_button(self.ui, "right_other/panel/right/btn_strong");
    self.btnStrong:set_on_click(self.bindfunc["on_strong"]);


    -- 1号卡牌
    self.btnCard1 = ngui.find_button(self.ui, "center_down_other/animation/head1/animation/big_card_item");
    self.btnCard1:set_on_click(self.bindfunc["on_card1"]);
    self.obj_card1 = self.btnCard1:get_game_object();
    -- 2号卡牌
    self.btnCard2 = ngui.find_button(self.ui, "center_down_other/animation/head2/animation/big_card_item");
    self.btnCard2:set_on_click(self.bindfunc["on_card2"]);
    self.obj_card2 = self.btnCard2:get_game_object();
    -- 3号卡牌
    self.btnCard3 = ngui.find_button(self.ui, "center_down_other/animation/head3/animation/big_card_item");
    self.btnCard3:set_on_click(self.bindfunc["on_card3"]);
    self.obj_card3 = self.btnCard3:get_game_object();

    -- self.btn_left_arrow = MyButton.find_button(self.ui,"center_down_other/left_btn_arrows");
    -- self.btn_left_arrow:set_on_click(self.bindfunc["on_left"]);

    -- self.btn_right_arrow = MyButton.find_button(self.ui,"center_down_other/right_btn_arrows");
    -- self.btn_right_arrow:set_on_click(self.bindfunc["on_right"]);
    self.anim_left_other = ngui.find_sprite(self.ui, "left_other/animation"):get_game_object();
    self.anim_right_top_other = ngui.find_sprite(self.ui, "right_top_other/animation"):get_game_object();
    self.anim_center_down_other = ngui.find_sprite(self.ui, "center_down_other/animation"):get_game_object();
    self.anim_right_other = ngui.find_sprite(self.ui, "right_other/panel/right"):get_game_object();


    self.scroll_view = ngui.find_scroll_view(self.ui, "left_other/animation/panel_list")
    self:UpdateUi()

    --[[为了显示小红点提示，在主界面来请求数据]]
    -- 7日签到，月签到数据
    msg_checkin.cg_get_checkin_info()
    -- 请求活动状态
    msg_activity.cg_activity_request_state()
    -- 登录数据
    msg_activity.cg_login_request_my_data()
    -- 闯关数据
    msg_activity.cg_hurdle_request_my_data()
    -- 升级奖励
    LevelUpReward.GetInstance():RequestInitData()
    --:set_value(0.125,0.5,0.5,2)
    --Root.get_ui_camera():get_motion_blur_effect():set_enable(true)
    self:PlayLeftAnimation()
end

function UiBase:OnAnimationBack()
    self.anim_left_other:animated_stop("xin_main_left")
    self.scroll_view:set_enable(true)
end

function UiBase:PlayLeftAnimation()
    self.scroll_view:set_enable(false)
    self.anim_left_other:set_animated_enabled(true)
    self.anim_left_other:animated_play("xin_main_left");
    timer.create(Utility.create_callback(self.OnAnimationBack, self), 1550, 1)
end

function UiBase:UpdateUi()
	if UiBaseClass.UpdateUi(self) then
        -- self.anim_left_other:animated_play("xin_main_left");
        -- self.anim_right_top_other:animated_play("xin_main_right1");
        -- self.anim_center_down_other:animated_play("xin_main_right2");
        --self:PlayLeftAnimation()

        local curTeam = g_dataCenter.player:GetDefTeam();
        for i = 1, 3 do
            if (curTeam ~= nil) then
                if (curTeam[i]) then
                    local cardinfo = g_dataCenter.package:find_card(1, curTeam[i]);
                    if (cardinfo ~= nil) then
                        self.roleData[i] = g_dataCenter.package:find_card_for_num(1, cardinfo.number);
                        -- self["spCard"..i]:set_active(true);
                        -- --self.humanPool:SetIcon(self["spCard"..i],cardinfo.number);
                        -- self["labLevelCard"..i]:set_active(true);
                        -- self["labLevelCard"..i]:set_text("Lv."..tostring(cardinfo.level));
                        if not self.scard[i] then
                            self.scard[i] = SmallCardUi:new( { obj = self["obj_card" .. i], info = cardinfo, res_group=self.panel_name });
                            self.scard[i]:SetCallback(self.bindfunc["on_card" .. i])
                            self.scard[i]:SetTeamPosIcon(i);
                        else
                            self.scard[i]:SetData(cardinfo,self["obj_card" .. i]);
                        end
                    else
                        if not self.scard[i] then
                            self.scard[i] = SmallCardUi:new( { obj = self["obj_card" .. i], res_group=self.panel_name });
                            self.scard[i]:SetCallback(self.bindfunc["on_card" .. i])
                            self.scard[i]:SetAddIcon(true);
                        else
                            self.scard[i]:SetData(nil,self["obj_card" .. i]);
                        end
                        -- self["spCard"..i]:set_active(false);
                        -- self["labLevelCard"..i]:set_active(false);
                    end
                else
                    if not self.scard[i] then
                            self.scard[i] = SmallCardUi:new( { obj = self["obj_card" .. i], res_group=self.panel_name });
                            self.scard[i]:SetCallback(self.bindfunc["on_card" .. i])
                            self.scard[i]:SetAddIcon(true);
                        else
                            self.scard[i]:SetData(nil,self["obj_card" .. i]);
                        end
                    -- self["spCard"..i]:set_active(false);
                    -- self["labLevelCard"..i]:set_active(false);
                    -- app.log("第"..i.."张卡片为空"..tostring(curTeam[i]));
                end
            else
                app.log("当前队伍为空");
            end
        end 

    end

    -- if self.roleData[self.index] then
    -- self.renderTexture:ChangeObj(self.roleData[self.index].number);
    -- end
end

function UiBase:UpdateSceneInfo(info_type)
    if info_type == ENUM.EUPDATEINFO.role then
        if self.ui then
            self:UpdateUi();
        end
    end
end


BattleRoleInfoUI = Class( "BattleRoleInfoUI", UiBaseClass );

local _UIText = {
	[1] = "[ff0000]角色%s星解锁[-]",
	[2] = "等级：",
}

function BattleRoleInfoUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/package/ui_602_7.assetbundle";
    UiBaseClass.Init(self, data);
end

function BattleRoleInfoUI:InitData(data)
    UiBaseClass.InitData(self, data);

    --self:UpdateRoleData(data.info)
    -- self.isPlayer = data.isPlayer;
    -- self.heroDataList = data.heroDataList
    -- if self.heroDataList == nil then
    --     self.heroDataList = self.isPlayer and PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, nil, nil, false) or {}
    -- end
    -- self.heroIndex = 0
    -- for i, v in pairs(self.heroDataList) do
    --     if v.number == self.roleData.number then
    --         self.heroIndex = i
    --         break;
    --     end
    -- end
end

function BattleRoleInfoUI:OnLoadUI()
    --UiBaseClass.PreLoadUIRes(Show3d, Root.empty_func)
end

function BattleRoleInfoUI:Restart( data )
    self:UpdateRoleData(data.info)
    self.roleData = data.info
    self.isPlayer = data.isPlayer;
    self.heroDataList = data.heroDataList
    if self.heroDataList == nil then
        --self.heroDataList = self.isPlayer and PublicFunc.GetAllHero(ENUM.EShowHeroType.Have, nil, nil, false) or {}
        self.heroDataList = self.isPlayer and PublicFunc.GetAllHero(ENUM.EShowHeroType.All, nil, nil, false) or {}
    end
    self.heroIndex = 0
    for i, v in pairs(self.heroDataList) do
        if v.number == self.roleData.number then
            self.heroIndex = i
            break;
        end
    end

    if UiBaseClass.Restart( self, data ) then
    end
end


-- function BattleRoleInfoUI:SetInfo(info, is_player, heroDataList)
--     self:UpdateRoleData(info)
--     self.isPlayer = is_player;
--     if heroDataList then
--         self.heroDataList = heroDataList
--     end
--     self.heroIndex = 0
--     for i, v in pairs(self.heroDataList) do
--         if v.number == self.roleData.number then
--             self.heroIndex = i
--             break;
--         end
--     end

--     self:UpdateUi()
-- end

function BattleRoleInfoUI:Show()
    if UiBaseClass.Show(self) then
        self:UpdateUi();
    end
end

function BattleRoleInfoUI:RegistFunc()
    UiBaseClass.RegistFunc(self);
    self.bindfunc["UpdateUi"] = Utility.bind_callback(self, BattleRoleInfoUI.UpdateUi);
    self.bindfunc["on_btn_close"] = Utility.bind_callback(self, BattleRoleInfoUI.close_btn);
    self.bindfunc["on_press_skill"] = Utility.bind_callback(self, BattleRoleInfoUI.on_press_skill);
    self.bindfunc["on_btn_left"] = Utility.bind_callback(self, BattleRoleInfoUI.on_btn_left);
    self.bindfunc["on_btn_right"] = Utility.bind_callback(self, BattleRoleInfoUI.on_btn_right);
    self.bindfunc["on_btn_showoff"] = Utility.bind_callback(self, BattleRoleInfoUI.on_btn_showoff);
    self.bindfunc["on_piece_add"] = Utility.bind_callback(self, BattleRoleInfoUI.on_piece_add);
end

-- 注册消息分发回调函数
function BattleRoleInfoUI:MsgRegist()
    UiBaseClass.MsgRegist(self);
    PublicFunc.msg_regist(msg_cards.gc_change_souls, self.bindfunc['UpdateUi']);
    PublicFunc.msg_regist(msg_cards.gc_eat_exp, self.bindfunc["UpdateUi"])
    PublicFunc.msg_regist(msg_cards.gc_skill_level_up_rst, self.bindfunc['UpdateUi']);
end

-- 注销消息分发回调函数
function BattleRoleInfoUI:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    PublicFunc.msg_unregist(msg_cards.gc_change_souls, self.bindfunc['UpdateUi']);
    PublicFunc.msg_unregist(msg_cards.gc_eat_exp, self.bindfunc["UpdateUi"])
    PublicFunc.msg_unregist(msg_cards.gc_skill_level_up_rst, self.bindfunc['UpdateUi']);
end

function BattleRoleInfoUI:close_btn()
    uiManager:PopUi();
end

function BattleRoleInfoUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("battle_base_info")

    local btnClose = ngui.find_button(self.ui, "centre_other/animation/content_di_1004_564/btn_cha")
    btnClose:set_on_click(self.bindfunc["on_btn_close"])

    local path = "centre_other/animation/left_content/"
    --------------------------- 基础 ---------------------------
    -- self.labHeroLevel = ngui.find_label(self.ui, path.."lab_level")
    -- self.labHeroAptitude = ngui.find_label(self.ui, path.."cont2/lab")
    -- self.spHeroAptitude = ngui.find_sprite(self.ui, path.."sp_di/sp_pinjie")
    -- self.labHeroRestraint = ngui.find_label(self.ui, path.."cont3/lab")
    -- self.spHeroJob = ngui.find_sprite(self.ui, path.."sp_di/sp_art_font")
    -- self.labHeroName = ngui.find_label(self.ui, path.."sp_di/lab_name")
    -- self.spStarArray = {}
    -- for i=1, Const.HERO_MAX_STAR do
    --     self.spStarArray[i] = ngui.find_sprite(self.ui, path.."sp_di/grid/sp_star"..i)
    -- end
    local objBigCard = self.ui:get_child_by_name(path.."cont_big_item")
    -- self.spBigCard = ngui.find_sprite(objBigCard, "sp_bk1")
    -- TEMP 暂时使用UiBigCard，具体需要UE定
    self.uiHeroCard = UiBigCard:new({parent=objBigCard, infoType=1, showCardName=true, showAddButton=false, enableClick=false})

    self.btnLeft = ngui.find_button(self.ui, path.."btn_left_arrows")
    self.btnRight = ngui.find_button(self.ui, path.."btn_right_arrows")

    self.btnLeft:set_on_click(self.bindfunc["on_btn_left"])
    self.btnRight:set_on_click(self.bindfunc["on_btn_right"])

    local nodePiece = self.ui:get_child_by_name(path.."pro_di")
    local btnPieceAdd = ngui.find_button(nodePiece, "btn_add")
    self.proPiece = ngui.find_progress_bar(nodePiece, "pro_di")
    self.labPieceNum = ngui.find_label(nodePiece, "lab_num")
    self.btnShowOff = ngui.find_button(self.ui, path.."btn")
    self.btnShowOff:set_on_click(self.bindfunc["on_btn_showoff"])

    btnPieceAdd:set_on_click(self.bindfunc["on_piece_add"])
    --self.btnShowOff:set_on_click(self.bindfunc["on_btn_showoff"])

    self.scrollView = ngui.find_scroll_view(self.ui, "centre_other/animation/panel_nature/scrollview_data")
    self.tableView = ngui.find_table(self.ui,"centre_other/animation/panel_nature/scrollview_data/table")
            --centre_other/animation/panel_nature/scrollview_data/table/sp_bk1/nature_grid
    path = "centre_other/animation/panel_nature/scrollview_data/table/sp_bk1/"
    --------------------------- 属性 ---------------------------
    self.nodeSpbk1 = self.ui:get_child_by_name(path)
    self.nodeFightValue = self.ui:get_child_by_name(path.."cont/sp_fight")
    self.labFightValue = ngui.find_label(self.ui, path.."cont/sp_fight/lab_fight")  

    self.labLevel = ngui.find_label(self.ui, path.."cont_level/lab")
    self.propertyList = {}  --table/sp_bk1/nature_grid/cont1/txt
    local nodeProperty = self.ui:get_child_by_name(path.."nature_grid")
    for i=1, 9 do
        self.propertyList[i] = {}
        self.propertyList[i].name = ngui.find_label(nodeProperty, "cont"..i.."/txt")
        self.propertyList[i].value = ngui.find_label(nodeProperty, "cont"..i.."/lab")
        self.propertyList[i].name:set_text("")
        self.propertyList[i].value:set_text("")
    end

    path = "centre_other/animation/panel_nature/scrollview_data/table/sp_bk2/"
    --------------------------- 类型 ---------------------------
    self.labSimpleWord = ngui.find_label(self.ui, path.."lab")


    path = "centre_other/animation/panel_nature/scrollview_data/table/sp_bk3/"
    --------------------------- 连协 ---------------------------
    self.fetterSpbk = ngui.find_sprite(self.ui, "centre_other/animation/panel_nature/scrollview_data/table/sp_bk3")
    self.fetterList = {}
    self.fetterItemHeight = 0
    self.fetterSpbkHeight = self.fetterSpbk:get_height()
    for i=1, 6 do
        self.fetterList[i] = {}
        self.fetterList[i].title = ngui.find_label(self.ui, path.."cont"..i.."/txt")
        self.fetterList[i].content = ngui.find_label(self.ui, path.."cont"..i.."/lab")
        self.fetterList[i].cont = ngui.find_sprite(self.ui, path.."cont"..i)
        self.fetterList[i].title:set_text("")
        self.fetterList[i].content:set_text("")

        if self.fetterItemHeight == 0 then
            local w, h = self.fetterList[i].title:get_size()
            self.fetterItemHeight = h
        end
    end


    path = "centre_other/animation/panel_nature/scrollview_data/table/sp_bk4/grid/"
    --------------------------- 技能 ---------------------------
    self.skillList = {}
    for i=1, 8 do
        self.skillList[i] = {}
        local objSpSkill = self.ui:get_child_by_name(path.."cont_skill"..i)
        self.skillList[i].icon = ngui.find_texture(objSpSkill, "Texture")
        self.skillList[i].name = ngui.find_label(objSpSkill, "lab_name")
        self.skillList[i].leveltitle = ngui.find_label(objSpSkill, "txt_level")
        self.skillList[i].level = ngui.find_label(objSpSkill, "lab_level")
        self.skillList[i].rank = ngui.find_sprite(objSpSkill, "sp_art_font")
        local skillBtn = ngui.find_button(objSpSkill, objSpSkill:get_name())
        self.skillList[i].clsBClk = ButtonClick:new({obj = skillBtn, weakFocus=true});
    end


    path = "centre_other/animation/panel_nature/scrollview_data/table/sp_bk5/"
    --------------------------- 简介 ---------------------------
    -- self.labIntroduction = ngui.find_label(self.ui, path.."lab")
 
    self:UpdateUi();
end

function BattleRoleInfoUI:DestroyUi()
    if self.uiHeroCard then
        self.uiHeroCard:DestroyUi();
        self.uiHeroCard = nil;
    end
    if self.skillList then
        for i, v in ipairs(self.skillList) do
            v.icon:Destroy()
            delete(v.clsBClk);
        end
        self.skillList = nil
    end
    self.fetterList = nil
    self.propertyList = nil

    UiBaseClass.DestroyUi(self)
end

function BattleRoleInfoUI:on_press_skill(x, y, state, param)
    --app.log("param==================="..table.tostring(param))
    local skill_level = param.level;
    if param.skillType == 1 then
        SkillTips.EnableSkillTips(state, param.id, skill_level, self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 150, self.roleData.config.default_rarity, 1);
    elseif param.skillType == 2 then
        SkillTips.EnableSkillTips(state, param.id, skill_level, self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 150, self.roleData.config.default_rarity, 2);
    else
        SkillTips.EnableSkillTips(state, param.id, skill_level, self.roleData:GetPropertyVal(ENUM.EHeroAttribute.atk_power), x, y, 150)
    end
end

function BattleRoleInfoUI:on_btn_left(t)
    self.heroIndex = self.heroIndex - 1
    if self.heroIndex < 1 then
        self.heroIndex = #self.heroDataList
    end
    self:UpdateRoleData(self.heroDataList[self.heroIndex])
    self:UpdateUi()
end

function BattleRoleInfoUI:on_btn_right(t)
    self.heroIndex = self.heroIndex + 1
    if self.heroIndex > #self.heroDataList then
        self.heroIndex = 1
    end
    self:UpdateRoleData(self.heroDataList[self.heroIndex])
    self:UpdateUi()
end

function BattleRoleInfoUI:on_btn_showoff(t)
    -- 炫耀一下  TODO
    FloatTip.Float("敬请期待！");
end

function BattleRoleInfoUI:on_piece_add(t)
    local data = {};
    data.item_id = self.roleData.config.hero_soul_item_id;
    data.number = self.roleData.config.get_soul;
    AcquiringWayUi.Start(data);
    self:close_btn()
end

function BattleRoleInfoUI:UpdateRoleData(roleData)
    --app.log("roleData............."..table.tostring(roleData))
    if roleData then
        self.roleData = roleData
        self.havedRole = g_dataCenter.package:HavedHeroCard(self.roleData.config.default_rarity)
    end
end

function BattleRoleInfoUI:UpdateBaseInfo()
    -- self.labHeroLevel:set_text("LV."..self.roleData.level)
    -- self.labHeroAptitude:set_text(PublicFunc.GetAptitudeText(self.roleData.config.aptitude))
    -- PublicFunc.SetAptitudeSprite(self.spHeroAptitude, self.roleData.config.aptitude, true)
    --app.log("    "..tostring(self.roleData.config.restraint))
    -- self.labHeroRestraint:set_text(PublicFunc.GetRestraintStr(self.roleData.config.restraint))
    -- PublicFunc.SetProTypePic(self.spHeroJob, self.roleData.config.pro_type, 3)
    -- for i=1, Const.HERO_MAX_STAR do
    --     PublicFunc.SetCardStarSprite(self.spStarArray[i], self.roleData.rarity >= i)
    -- end
    -- self.labHeroName:set_text(self.roleData.name)

    if self.havedRole or not self.isPlayer then
        if self.isPlayer then
            self.btnShowOff:set_active(true)
        else
            self.btnShowOff:set_active(false)
        end
        self.proPiece:set_active(false)
        self.uiHeroCard:SetGray(false)
        self.uiHeroCard:HideContent1SomeUi(true)
        --图片恢复正常
        -- for i=1, Const.HERO_MAX_STAR do
        --     PublicFunc.SetUISpriteWhite(self.spStarArray[i])
        -- end
        -- PublicFunc.SetUISpriteWhite(self.spHeroAptitude)
        -- PublicFunc.SetUISpriteWhite(self.spHeroJob)
        -- PublicFunc.SetUISpriteWhite(self.spBigCard)
        -- PublicFunc.SetUISpriteWhite(self.labHeroName)
        self.tableView:reposition_now()
    else
        self.btnShowOff:set_active(false)
        self.proPiece:set_active(true)
        self.uiHeroCard:SetGray(true)
        self.uiHeroCard:HideContent1SomeUi(false)

        local souls = g_dataCenter.package:GetCountByNumber(self.roleData.config.hero_soul_item_id);
        local need_souls = self.roleData.config.get_soul
        self.labPieceNum:set_text(souls.."/"..need_souls)
        self.proPiece:set_value(souls/need_souls)

        --图片变灰
        -- for i=1, Const.HERO_MAX_STAR do
        --     PublicFunc.SetUISpriteGray(self.spStarArray[i])
        -- end
        -- PublicFunc.SetUISpriteGray(self.spHeroAptitude)
        -- PublicFunc.SetUISpriteGray(self.spHeroJob)
        -- PublicFunc.SetUISpriteGray(self.spBigCard)
        -- PublicFunc.SetUISpriteGray(self.labHeroName)
    end
end

function BattleRoleInfoUI:UpdateFetterInfo()
    local data = PublicFunc.GetContactDescData(self.roleData)
    if data then
        local delta = 0
        for i, v in ipairs(self.fetterList) do
            if data[i] then
                v.title:set_active(true)
                v.content:set_active(true)

                v.title:set_text(data[i].name)
                v.content:set_text(data[i].desc)
                v.cont:set_active(true)
                local w, h = v.content:get_size()
                --app.log("h================="..tostring(h))
                delta = delta + (h - self.fetterItemHeight)
            else
                -- v.title:set_active(false)
                -- v.content:set_active(false)
                local w, h = v.content:get_size()
                delta = delta + (h - self.fetterItemHeight - self.fetterItemHeight/2 - self.fetterItemHeight)
                v.cont:set_active(false)
            end
        end

        --app.log("delta================="..tostring(delta))
        --app.log("fetterSpbkHeight================="..tostring(self.fetterSpbkHeight))
        -- 根据内容行数适配底板高度
        self.fetterSpbk:set_height(self.fetterSpbkHeight+delta)
        self.scrollView:reset_position()
    end
end


function BattleRoleInfoUI:UpdateSkillInfo()
    local data = PublicFunc.GetHeroSkillData(self.roleData)
    for i, v in ipairs(self.skillList) do
        if data[i] then
            -- 被动技能
            local config = PublicFunc.GetSkillCfg(self.roleData.config.default_rarity, data[i].skillType, data[i].id);
            v.icon:set_texture(config.small_icon)
            v.name:set_text(config.name)
            --app.log("rank==================="..tostring(config.rank))
            if config.rank then
                v.rank:set_sprite_name(PublicFunc.GetPassiveSkillRankText(config.rank));
            else
                v.rank:set_sprite_name("");
            end
            v.clsBClk:SetPress(self.bindfunc["on_press_skill"], data[i]);

            if data[i].enable then
                v.icon:set_color(1,1,1,1)
                v.leveltitle:set_text("等级")
                v.level:set_text(tostring(data[i].level))
            else
                if i > 3 then
                    local curStar = PublicFunc.getRoleCardCurStar( self.roleData.number )
                    if i > curStar+1 then
                        v.icon:set_color(0,0,0,1)
                        v.leveltitle:set_text(string.format(_UIText[1], i-1))
                        v.level:set_text("")
                    else
                        v.icon:set_color(1,1,1,1)
                        v.leveltitle:set_text("等级")
                        v.level:set_text("1")
                    end
                else
                    v.icon:set_color(1,1,1,1)
                    v.leveltitle:set_text("等级")
                    v.level:set_text("1")
                end
            end
        end
    end
end


function BattleRoleInfoUI:UpdateHeroAttribute()
    local data = PublicFunc.GetPropertyShowValue(self.roleData)
    
    --if self.havedRole or not self.isPlayer then
        self.nodeSpbk1:set_active(true)

        --self.labFightValue:set_text(tostring(self.roleData:GetFightValue()))
        --self.labLevel:set_text(tostring(self.roleData.level))
        for i, v in ipairs(self.propertyList) do
            if data[i] then
                v.name:set_text(data[i][1])
                v.value:set_text(data[i][2])
            end
        end
    --else
        --self.nodeSpbk1:set_active(false)
    --end
end

function BattleRoleInfoUI:UpdateUi()
    if not self:IsShow() then return end
    if not self.roleData then return end

    self:UpdateBaseInfo()
    self:UpdateHeroAttribute()
    self:UpdateFetterInfo()
    self:UpdateSkillInfo()

    if #self.heroDataList > 1 then
        self.btnLeft:set_active(true)
        self.btnRight:set_active(true)
    else
        self.btnLeft:set_active(false)
        self.btnRight:set_active(false)
    end

    self.uiHeroCard:SetData(self.roleData)
    local config = ConfigHelper.GetRole(self.roleData.number)
    -- self.labIntroduction:set_text(tostring(config.describe))
    self.labSimpleWord:set_text(tostring(config.simple_describe))

    --app.log("reset_position")
    
end

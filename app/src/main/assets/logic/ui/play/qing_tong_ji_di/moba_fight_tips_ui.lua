
MobaFightTipsUi = Class("MobaFightTipsUi",UiBaseClass)

local res = "assetbundles/prefabs/ui/new_fight/new_fight_ui_fight.assetbundle"


function MobaFightTipsUi.GetResList()
    return {res}
end

function MobaFightTipsUi:Init(data)
    self.pathRes = res

    self.seqMsg = {}
    self.showRuning = false
    self.leftSide = true
	UiBaseClass.Init(self, data);
end

function MobaFightTipsUi:InitData(data)
    UiBaseClass.InitData(self,data);
end

function MobaFightTipsUi:InitUI(obj)
    UiBaseClass.InitUI(self, obj)

    self.spBg = ngui.find_sprite(self.ui, "sp_bk")
    self.spEffect1 = ngui.find_sprite(self.ui, "sp_bk/sp_effect1")
    self.spEffect2 = ngui.find_sprite(self.ui, "sp_bk/sp_effect2")
    self.labContent = ngui.find_label(self.ui, "sp_bk/lab")
    self.leftSpBorder = ngui.find_sprite(self.ui, "sp_left_head")
    self.rightSpBorder = ngui.find_sprite(self.ui, "sp_right_head")
    self.leftTexture = ngui.find_texture(self.ui, "sp_left_head/Texture")
    self.rightTexture = ngui.find_texture(self.ui, "sp_right_head/Texture")

    self.aniObj = self.ui:get_child_by_name("animation")
    self.anifxX = self.ui:get_child_by_name("sp_bk/fx")
    self.anifxX:set_active(false)

    self.fx_ui_red = {}
    self.fx_ui_blue = {}
    self.fx_ui_red[1] = self.aniObj:get_child_by_name("fx_ui_sansha")
    self.fx_ui_red[2] = self.aniObj:get_child_by_name("fx_ui_dashatesha")
    self.fx_ui_red[3] = self.aniObj:get_child_by_name("fx_ui_chaoshen")
    self.fx_ui_blue[1] = self.aniObj:get_child_by_name("fx_ui_sansha_lan")
    self.fx_ui_blue[2] = self.aniObj:get_child_by_name("fx_ui_dashatesha_lan")
    self.fx_ui_blue[3] = self.aniObj:get_child_by_name("fx_ui_chaoshen_lan")

    self.fx_ui_jisha = self.aniObj:get_child_by_name("fx_ui_jisha")
    
    self:ShowNext()
end

function MobaFightTipsUi:DestroyUi()
    UiBaseClass.DestroyUi(self)
end

function MobaFightTipsUi:SetLeftSide( leftSide )
    self.leftSide = leftSide
end

function MobaFightTipsUi:ShowNext()
    if self.ui == nil then return end
    if self.showRuning then return end

    if #self.seqMsg > 0 then
        local msg = table.remove(self.seqMsg, 1)
        self.spBg:set_active(true)
        self:ShowMsg(msg)
    else
        self.spBg:set_active(false)
    end
end

--msg:{left_rid=nil, right_rid=nil, content="", camp=阵营, kill_count=, dead_tower=}
function MobaFightTipsUi:AddMsg(msg)
    table.insert(self.seqMsg, msg)
    self:ShowNext()
end

function MobaFightTipsUi:ShowMsg(msg)
    -- local redTemplate = "[ff0000]%s[-]"
    -- local blueTemplate = "[0000ff]%s[-]"
    local template = "%s"

    local showBlue = true
    if (msg.camp == 1 and self.leftSide == false) or
       (msg.camp == 2 and self.leftSide == true) then
        showBlue = false
    end
    
    if msg.left_rid == nil then
        self.leftSpBorder:set_active(false)
    else
        self.leftSpBorder:set_active(true)
        if showBlue then
            self.leftSpBorder:set_sprite_name("zd_js_touxiang1")
        else
            self.leftSpBorder:set_sprite_name("zd_js_touxiang4")
        end

        local config = PublicFunc.IdToConfig(msg.left_rid)
        if config and config.icon90 and type(config.icon90) == "string" then
            self.leftTexture:set_texture(config.icon90)
        else
            self.leftTexture:clear_texture()
        end
    end

    if msg.right_rid == nil then
        self.rightSpBorder:set_active(false)
    else
        self.rightSpBorder:set_active(true)
        if showBlue then
            self.rightSpBorder:set_sprite_name("zd_js_touxiang3")
        else
            self.rightSpBorder:set_sprite_name("zd_js_touxiang2")
        end

        local config = PublicFunc.IdToConfig(msg.right_rid)
        if config and config.icon90 and type(config.icon90) == "string" then
            self.rightTexture:set_texture(config.icon90)
        else
            self.rightTexture:clear_texture()
        end
    end

    -- if showBlue then
    --     template = blueTemplate
    -- else
    --     template = redTemplate
    -- end

    self.labContent:set_text(string.format(template, msg.content))

    self.showRuning = true

    -- self.fx_ui_red[1]:set_active(false)
    -- self.fx_ui_red[2]:set_active(false)
    -- self.fx_ui_red[3]:set_active(false)
    -- self.fx_ui_blue[1]:set_active(false)
    -- self.fx_ui_blue[2]:set_active(false)
    -- self.fx_ui_blue[3]:set_active(false)

    local fx_ui_group = nil
    if showBlue then
        fx_ui_group = self.fx_ui_blue
        self.spBg:set_sprite_name("zd_js_diban1")
    else
        fx_ui_group = self.fx_ui_red
        self.spBg:set_sprite_name("zd_js_diban2")
    end

    local kill_count = msg.kill_count or 0
    if kill_count > 1 then
        if showBlue then
            if kill_count == 2 then
                self.spEffect1:set_sprite_name("zd_hwl1")
                self.spEffect2:set_sprite_name("zd_hwlx1")
            elseif kill_count == 3 then
                self.spEffect1:set_sprite_name("zd_hwl2")
                self.spEffect2:set_sprite_name("zd_hwlx1")
            elseif kill_count == 4 then
                self.spEffect1:set_sprite_name("zd_hwl3")
                self.spEffect2:set_sprite_name("zd_hwlx2")
            else
                self.spEffect1:set_sprite_name("zd_hwl4")
                self.spEffect2:set_sprite_name("zd_hwlx2")
            end
        else
            if kill_count == 2 then
                self.spEffect1:set_sprite_name("zd_hwh1")
                self.spEffect2:set_sprite_name("zd_hwhx1")
            elseif kill_count == 3 then
                self.spEffect1:set_sprite_name("zd_hwh2")
                self.spEffect2:set_sprite_name("zd_hwhx1")
            elseif kill_count == 4 then
                self.spEffect1:set_sprite_name("zd_hwh3")
                self.spEffect2:set_sprite_name("zd_hwhx2")
            else
                self.spEffect1:set_sprite_name("zd_hwh4")
                self.spEffect2:set_sprite_name("zd_hwhx2")
            end
        end
    else
        self.spEffect1:set_sprite_name("")
        self.spEffect2:set_sprite_name("")
    end

    local dead_tower = msg.dead_tower
    if kill_count >= 5 then
        if self.aniObj:animated_is_playing("fx_ui_new_fight_ui_fight4") then
            self.aniObj:animated_stop("fx_ui_new_fight_ui_fight4")
        end
        self.aniObj:animated_play("fx_ui_new_fight_ui_fight4")

        if kill_count >= 8 then
            fx_ui_group[3]:set_active(false)
            fx_ui_group[3]:set_active(true)
        else
            fx_ui_group[2]:set_active(false)
            fx_ui_group[2]:set_active(true)
        end

        self.anifxX:set_active(true)
        self.fx_ui_jisha:set_active(false)
        -- app.log("#moba# kill_count>=5 "..kill_count)
    elseif kill_count >= 2 then
        if self.aniObj:animated_is_playing("fx_ui_new_fight_ui_fight3") then
            self.aniObj:animated_stop("fx_ui_new_fight_ui_fight3")
        end
        self.aniObj:animated_play("fx_ui_new_fight_ui_fight3")

        fx_ui_group[1]:set_active(false)
        fx_ui_group[1]:set_active(true)

        self.anifxX:set_active(false)
        self.fx_ui_jisha:set_active(false)
        -- app.log("#moba# kill_count>=2 "..kill_count)
    elseif kill_count == 1 then
    --击杀
        if self.aniObj:animated_is_playing("fx_ui_new_fight_ui_fight2") then
            self.aniObj:animated_stop("fx_ui_new_fight_ui_fight2")
        end
        self.aniObj:animated_play("fx_ui_new_fight_ui_fight2")

        self.anifxX:set_active(false)
        self.fx_ui_jisha:set_active(true)
        -- app.log("#moba# kill_count==1 ")
    elseif dead_tower then
    --击杀tower
        if self.aniObj:animated_is_playing("fx_ui_new_fight_ui_fight2") then
            self.aniObj:animated_stop("fx_ui_new_fight_ui_fight2")
        end
        self.aniObj:animated_play("fx_ui_new_fight_ui_fight2")

        self.anifxX:set_active(false)
        self.fx_ui_jisha:set_active(true)
        -- app.log("#moba# dead_tower ")
    else
    --团灭
        if self.aniObj:animated_is_playing("fx_ui_new_fight_ui_fight2") then
            self.aniObj:animated_stop("fx_ui_new_fight_ui_fight2")
        end
        self.aniObj:animated_play("fx_ui_new_fight_ui_fight2")

        self.anifxX:set_active(false)
        self.fx_ui_jisha:set_active(false)
        -- app.log("#moba# tuanmie ")
    end
end

function FightKillTipsAniCallback(obj, value)
    if GetMainUI() == nil then return end

    --检查播放下一个动画
    local cls = GetMainUI():GetMobaFightTips()
    if cls and cls.showRuning then
        cls.showRuning = false
        cls:ShowNext()
    end
end
HeroIllumstrationMain = Class("HeroIllumstrationMain", UiBaseClass)
--SSG
-- 17 30022200  16 30006000 15 30027300 14 30016200 13 30003200 12 30002100 11 30060100 10 30028300 9 30018200 8 30007200
-- 7  30012200   6 30025300  5 30005000 4  30054300  3 30029300  2 30004200  1 30019000 
--CCG
--
-- 11 30058000   10 30011200  9 30026200 8  30024200  7 30023200  6 30008200  5 30010200  4 30001100 3 30020300 2 30059000 1 30021200
local _UIText = {
    [1] = "获取",
    [2] = "升星",
    [3] = "收集加成[满级]:",

    [4] = "生命 ",
    [5] = "攻击 ",
    [6] = "防御 ",
    [7] = "收集加成[进度%s/%s]:",
    [8] = "%s星升%s星加成:",
    [9] = "满星加成:",
}

local HeroPic =
{
    [30022200] = "17",
    [30006000] = "16",
    [30027300] = "15",
    [30016200] = "14",
    [30003200] = "13",
    [30002100] = "12",
    [30060100] = "11",
    [30028300] = "10",
    [30018200] = "9",
    [30007200] = "8",
    [30012200] = "7",
    [30025300] = "6",
    [30005000] = "5",
    [30054300] = "4",
    [30029300] = "3",
    [30004200] = "2",
    [30019000] = "1",
    [30058100] = "11",
    [30011200] = "10",
    [30026200] = "9",
    [30024200] = "8",
    [30023200] = "7",
    [30008200] = "6",
    [30010200] = "5",
    [30001100] = "4",
    [30020300] = "3",
    [30059100] = "2",
    [30021200] = "1",
}

function HeroIllumstrationMain:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/card_illumstration/ui_610_hero_photo.assetbundle";
    UiBaseClass.Init(self, data)
end

function HeroIllumstrationMain:Restart(data)
    self.currentpage = 1;
    self.isMove = "right";
    if UiBaseClass.Restart( self, data ) then
    end
end

function HeroIllumstrationMain:RegistFunc()
    UiBaseClass.RegistFunc(self)    
    self.bindfunc["open_HeroIllumstrationUi"] = Utility.bind_callback(self, self.open_HeroIllumstrationUi)
    self.bindfunc["star_move"] = Utility.bind_callback(self, self.star_move)
    self.bindfunc["end_move"] = Utility.bind_callback(self, self.end_move)
    self.bindfunc["begin_move"] = Utility.bind_callback(self, self.begin_move)
    self.bindfunc["left_btn"] = Utility.bind_callback(self, self.left_btn)
    self.bindfunc["right_btn"] = Utility.bind_callback(self, self.right_btn)
    self.bindfunc["on_toggle_change"] = Utility.bind_callback(self, self.on_toggle_change)
    self.bindfunc["share_ui_button"] = Utility.bind_callback(self,self.share_ui_button)
end

function HeroIllumstrationMain:DestroyUi()
    self.currentpage = 1
    UiBaseClass.DestroyUi(self)
end

function HeroIllumstrationMain:MsgRegist()
    UiBaseClass.MsgRegist(self);
    
end

function HeroIllumstrationMain:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
    
end

function HeroIllumstrationMain:on_close()
    --HeroIllumstrationDetailUI.End()
    uiManager:PopUi()
end

function HeroIllumstrationMain:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name("hero_illumstration_main")
    self.joinbtn = ngui.find_button(self.ui,"down_other/animation/panel/btn")
    self.joinbtn:set_on_click(self.bindfunc["open_HeroIllumstrationUi"])

    self.sharebtn = ngui.find_button(self.ui,"down_other/animation/panel/btn_flaunt")
    self.sharebtn:set_on_click(self.bindfunc["share_ui_button"])
    --食人魔
    self.chanzhongherolist = {}
    for i=1,17 do
        self.chanzhongherolist[i] = ngui.find_texture(self.ui,"centre_other/animation/scroll_view/panel_list/grid/cont1/texture"..i)
        self.chanzhongherolist[i]:set_color(0,0,0,1)
    end
    --警察
    self.ccgherolist = {}
    for i=1,11 do
        self.ccgherolist[i] = ngui.find_texture(self.ui,"centre_other/animation/scroll_view/panel_list/grid/cont2/texture"..i)
        self.ccgherolist[i]:set_color(0,0,0,1)
    end

    self.ui_bg = ngui.find_texture(self.ui,"texture")
    self.ui_bg:set_texture("assetbundles/prefabs/ui/image/backgroud/da_luan_dou/dld_beijing.assetbundle")

    self.grid = ngui.find_grid(self.ui,"centre_other/animation/scroll_view/panel_list/grid");
    
    self.scroll_view = ngui.find_scroll_view(self.ui,"centre_other/animation/scroll_view/panel_list")
    self.beginpos ={}
    self.beginpos[1],self.beginpos[2],self.beginpos[3] = self.scroll_view:get_position()

    --app.log("beginpos============"..tostring(self.beginpos[1]))

    --self.leftbtn = ngui.find_button(self.ui,"centre_other/animation/panel_btn/btn_left_arrows")
    --self.leftbtn:set_on_click(self.bindfunc["left_btn"])

    --self.rightbtn = ngui.find_button(self.ui,"centre_other/animation/panel_btn/btn_right_arrows")
    --self.rightbtn:set_on_click(self.bindfunc["right_btn"])

    -- if self.currentpage == 1 then
    --     self.rightbtn:set_active(true)
    --     self.leftbtn:set_active(false)
    -- else
    --     self.rightbtn:set_active(false)
    --     self.leftbtn:set_active(true)
    -- end

    -- self.mark = ngui.find_sprite(self.ui,"centre_other/animation/scroll_view/sp_mark")
    -- self.mark:set_on_ngui_drag_start(self.bindfunc["star_move"])
    -- self.mark:set_on_ngui_drag_move(self.bindfunc["begin_move"])
    -- self.mark:set_on_ngui_drag_end(self.bindfunc["end_move"])

    --self.allprolab = ngui.find_label(self.ui,"down_other/animation/panel/lab")
    self.lblHP = ngui.find_label(self.ui,"down_other/animation/panel/grid_nature/lab1")
    self.lblAttack = ngui.find_label(self.ui,"down_other/animation/panel/grid_nature/lab2")
    self.lblDefense = ngui.find_label(self.ui,"down_other/animation/panel/grid_nature/lab3")
    
    self.yeka1 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yeka_ccg/sp")
    self.yeka1:set_sprite_name("yxtj_yeqian2")
    self.yeka2 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yela_cz/sp")
    self.yeka2:set_sprite_name("yxtj_yeqian1")

    self.yekabg1 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yeka_ccg/sp_bk")
    self.yekabg2 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yela_cz/sp_bk")

    self.yekalab1 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yeka_ccg/sp_art_font")
    self.yekalab2 = ngui.find_sprite(self.ui,"left_down_other/panel/animation/yela_cz/sp_art_font")


    self.changeSelectYe = ngui.find_toggle(self.ui,"left_down_other/panel/animation")
    self.changeSelectYe:set_on_change(self.bindfunc["on_toggle_change"])
    
    self:setData()
end

function HeroIllumstrationMain:on_toggle_change(value,name)
    app.log("value============="..tostring(value))
    --app.log("name=============="..name)
    if value == true then
        self.scroll_view:move_relative(1280,0,0)
        -- self.yeka1:set_depth(117)
        -- self.yekabg1:set_depth(118)
        -- self.yekabg1:set_sprite_name("yxtj_yeqian3")
        -- self.yekabg2:set_sprite_name("yxtj_yeqian4")
        -- self.yekalab2:set_depth(118)

        self.yeka2:set_depth(212)
        self.yeka1:set_depth(209)
        self.yekabg2:set_depth(213)
        self.yekabg1:set_depth(210)
        self.yekabg1:set_sprite_name("yxtj_yeqian3")
        self.yekalab2:set_depth(214)
        self.yekalab1:set_depth(211)
        self.yekalab1:set_sprite_name("yxtj_ccg1")
        self.yekalab2:set_sprite_name("yxtj_cz2")
        self.yekabg2:set_sprite_name("yxtj_yeqian4")

        self.currentpage = 2
    else
        self.scroll_view:move_relative(-1280,0,0)
        self.yeka1:set_depth(212)
        self.yeka2:set_depth(209)
        self.yekabg1:set_depth(213)
        self.yekabg2:set_depth(210)
        self.yekabg2:set_sprite_name("yxtj_yeqian3")
        self.yekalab1:set_depth(214)
        self.yekalab2:set_sprite_name("yxtj_cz1")
        self.yekalab2:set_depth(211)
        self.yekalab1:set_sprite_name("yxtj_ccg2")
        self.yekabg1:set_sprite_name("yxtj_yeqian4")
        self.currentpage = 1
    end
    AudioManager.PlayUiAudio(ENUM.EUiAudioType.Flag)
    --app.log("currentpage============"..tostring(self.currentpage))
end

-- function HeroIllumstrationMain:Update(dt)
--     if UiBaseClass.Update(self, dt) then    
--         app.log("11111111111111111111111111111111111111111")
--     end
-- end

function HeroIllumstrationMain:open_HeroIllumstrationUi()
    uiManager:PushUi( EUI.HeroIllumstrationUI ,self.currentpage);
end

function HeroIllumstrationMain:share_ui_button()
    share_ui_button.Start(1,2)
end

function HeroIllumstrationMain:star_move(name,x,y)
    self.beginpos[1],self.beginpos[2],self.beginpos[3] = self.scroll_view:get_position()
    --app.log("xxxxxxxxxxx star"..tostring(self.beginpos[1]))
end

function HeroIllumstrationMain:begin_move(name,x,y)
    
    self.movepos = x
    -- app.log("xxxxxxxxxxx x"..tostring(x))
    -- app.log("xxxxxxxxxxx lastmovepos"..tostring(self.lastmovepos))
    if self.lastmovepos then 
        if self.lastmovepos - self.movepos >= 0 then
            self.moveline = "left"
        else
            self.moveline = "right"
        end

        self.lastmovepos = x
    else
        self.lastmovepos = x
    end
end

function HeroIllumstrationMain:end_move(name,x,y)
    self.endpos = {}
    self.endpos[1],self.endpos[2],self.endpos[3] = self.scroll_view:get_position()

    -- app.log("xxxxxxxxxxx moveline"..self.moveline)
    -- app.log("xxxxxxxxxxx isMove"..self.isMove)
    -- app.log("xxxxxxxxxxx begin"..tostring(self.beginpos[1]))
    
    if self.isMove == "left" and self.moveline == "left" then
        do return end
    end

    if self.isMove == "right" and self.moveline == "right" then
        do return end
    end

    if self.beginpos[1] == 0 or self.beginpos[1] == -1 then
        self.currentpage = 2
        self.isMove = "left"
    elseif self.beginpos[1] == -1280 or self.beginpos[1] == -1281 then
        self.currentpage = 1
        self.isMove = "right"
    end

    -- app.log("currentpage==============="..tostring(self.currentpage))

    self:showBtn()

end

function HeroIllumstrationMain:showBtn()
     if self.currentpage == 1 then
        self.rightbtn:set_active(true)
        self.leftbtn:set_active(false)
    else
        self.rightbtn:set_active(false)
        self.leftbtn:set_active(true)
    end
end

function HeroIllumstrationMain:left_btn(t)
    if self.currentpage == 1 then
        do return end
    end

    self.scroll_view:move_relative(1280,0,0)
    self.currentpage = 1 
    self.isMove = "right"
    self:showBtn()
end

function HeroIllumstrationMain:right_btn(t)
    if self.currentpage == 2 then
        do return end
    end
    self.scroll_view:move_relative(-1280,0,0)
    self.currentpage = 2
    self.isMove = "left"
    self:showBtn()
end

function HeroIllumstrationMain:TimeSetPage()

end

function HeroIllumstrationMain:setData()
    --local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.Have);
    local haveherolist = PublicFunc.GetAllHero(ENUM.EShowHeroType.All);
    local haveCCGnumberlist = {}
    local haveSSGnumberlist = {}
    for k,v in pairs(haveherolist) do

        if v.ccgType ==1 then
            table.insert(haveCCGnumberlist,v.default_rarity)
        elseif v.ccgType == 2 then
            table.insert(haveSSGnumberlist,v.default_rarity)
        end
    end

    --app.log("haveCCGnumberlist=============="..table.tostring(haveCCGnumberlist))

    --app.log("haveSSGnumberlist=============="..table.tostring(haveSSGnumberlist))

    for k,v in pairs(haveSSGnumberlist) do
        local index = tonumber(v)
        local number = tonumber(HeroPic[index])
        --app.log("number============="..tostring(number))
        if number then
            self.chanzhongherolist[number]:set_color(1,1,1,1)
        end
    end

    for k,v in pairs(haveCCGnumberlist) do
        local index = tonumber(v)
        local number = tonumber(HeroPic[index])
        --app.log("number============="..tostring(number))
        if number then
            self.ccgherolist[number]:set_color(1,1,1,1)
        end
    end

    self:UpdateTotalIllumstrationValue()
end

--总战力属性加成更新显示
function HeroIllumstrationMain:UpdateTotalIllumstrationValue()
    local totalHP, totalAtk, totalDef = PublicFunc.getTotalActiveIllumstration();
    local txtHP = "[F39998FF]" .. _UIText[4] .. "[-][00FF73FF]+"..tostring( PublicFunc.AttrInteger(totalHP) .."[-]");
    local txtAtk = "[F39998FF]" .. _UIText[5] .. "[-][00FF73FF]+"..tostring( PublicFunc.AttrInteger(totalAtk).."[-]" );
    local txtDef = "[F39998FF]" .. _UIText[6] .. "[-][00FF73FF]+"..tostring( PublicFunc.AttrInteger(totalDef) .."[-]");
    self.lblHP:set_text(txtHP);
    self.lblAttack:set_text(txtAtk);
    self.lblDefense:set_text(txtDef);
    --self.allprolab:set_text("收集总加成:".."  "..txtHP.."  "..txtAtk.."  "..txtDef)

end

function HeroIllumstrationMain:Show()
    if UiBaseClass.Show(self) then
        self:UpdateTotalIllumstrationValue()
    end 
end
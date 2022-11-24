--fileName:logic/ui/screen_play_ui/screen_play_translate.lua
--desc:传送对话框ui
--code by:feng yu
--date:2016-8-19


ScreenPlayTranslate = Class( "ScreenPlayTranslate", UiBaseClass );

--Globle function 
function ScreenPlayTranslate.ShowTalk( data )
    if ScreenPlayTranslate.showTalkUi == nil then
        ScreenPlayTranslate.showTalkUi = ScreenPlayTranslate:new( data );
    else
        ScreenPlayTranslate.showTalkUi:SetAndShow( data );
    end
end

function ScreenPlayTranslate.DestroyTalk()
    if ScreenPlayTranslate.showTalkUi then
        ScreenPlayTranslate.showTalkUi:DestroyUi();
        ScreenPlayTranslate.showTalkUi = nil;
    end
end

function ScreenPlayTranslate.GetInstance()
    return ScreenPlayTranslate.showTalkUi
end

function ScreenPlayTranslate:Init( data )
    self.pathRes = "assetbundles/prefabs/ui/drama/ui_701_drama.assetbundle";
    UiBaseClass.Init(self, data);
end

function ScreenPlayTranslate:InitData( data )
    UiBaseClass.InitData( self, data );
    self.msg = data.msg or "配置错误";
    self.icon_path = data.icon_path;
    self.npcid = data.npcid or 0;
    self.show_cancel = data.show_cancel
end

function ScreenPlayTranslate:DestroyUi()
    
    if self.textureLeftIcon then
        self.textureLeftIcon:Destroy();
        self.textureLeftIcon = nil;
    end
    
    if self.textureRightIcon then
        self.textureRightIcon:Destroy();
        self.textureRightIcon = nil;
    end
    self:Hide();

    UiBaseClass.DestroyUi( self );
    ScreenPlayTranslate.showTalkUi = nil;
end

function ScreenPlayTranslate:Show()
    UiBaseClass.Show( self );
end

function ScreenPlayTranslate:Hide()
    UiBaseClass.Hide( self );
end

function ScreenPlayTranslate:RegistFunc()
    UiBaseClass.RegistFunc( self );
    self.bindfunc["on_leave"] = Utility.bind_callback( self, ScreenPlayTranslate.on_leave );
    self.bindfunc["on_next"] = Utility.bind_callback( self, ScreenPlayTranslate.on_next );
end

function ScreenPlayTranslate:InitUI( asset_obj )
    UiBaseClass.InitUI( self, asset_obj );
    self.ui:set_parent( Root.get_root_ui_2d() );
    self.ui:set_name( "screenplay_translate" );
    self.ui:set_local_scale( Utility.SetUIAdaptation() );
    
    ---------图片----------
    --左侧人物头像sp
    self.textureLeftIcon = ngui.find_texture(self.ui,"texture_left");
    self.textureRightIcon = ngui.find_texture(self.ui,"texture_right");
    self.textureRightIcon:set_active(false);
    self.spTitle = ngui.find_sprite(self.ui, "sp_title");
    self.labName1 = ngui.find_label(self.ui, "centre_other/animation/content/sp_title/lab_name1");
    self.labName2 = ngui.find_label(self.ui, "centre_other/animation/content/sp_title/lab_name2");
    self.labDlg = ngui.find_label(self.ui, "lab_describe");
    self.objRight = self.ui:get_child_by_name("texture_right");
    self.labRightName = ngui.find_label(self.ui,"content/texture_right/sp_title/lab_name");
    self.labRightDlg = ngui.find_label(self.ui,"content/texture_right/lab_describe");
    self.spRightTitle = ngui.find_sprite(self.ui, "content/texture_left/sp_title");
    --跳过按钮
    -- self.btnSkip = ngui.find_button(self.ui,"btn");
    -- self.btnSkip:set_active(false);
    --点击屏幕，进入下一段对话
    self.spNext = ngui.find_sprite(self.ui,"sp_mark");
    self.spNext:set_on_ngui_click(self.bindfunc["on_next"]);
    
    --取消按鈕
    self.btnCancel = ngui.find_button(self.ui, "btn_cancel");
    self.btnCancel:set_on_click(self.bindfunc["on_next"]);
    local lab = ngui.find_label( self.ui, "btn_cancel/animation/lab" );
    lab:set_text( "取消" );
    --确定按钮
    self.btnLeave = ngui.find_button( self.ui, "btn_sure" );
    self.labLeave = ngui.find_label( self.ui, "btn_sure/animation/lab" );
    self.labLeave:set_text( "确定" );

    self.btnCancel:set_active(false)
    self.btnLeave:set_active(false)

    self.aniObj = self.ui:get_child_by_name("animation")
    
    self:UpdateUi();
end

function ScreenPlayTranslate:on_next()
    self:DestroyUi();
end

function ScreenPlayTranslate:on_leave()
    self:DestroyUi();
    FightScene.GetFightManager():FightOver(true);
end

function ScreenPlayTranslate:UpdateUi()
    if self.ui == nil then return end;
    if self.show_cancel == false then
        self.btnLeave:set_on_click( self.bindfunc["on_next"] );
    else
        self.btnLeave:set_on_click( self.bindfunc["on_leave"] );
    end
    local path = self.icon_path;
    if path and path ~= 0 then
        self.textureLeftIcon:set_texture( path );
    end
    self.labName1:set_active( true );
    self.labName2:set_active( true );
    self.labDlg:set_active( true );
    local dispMsg = "";
    local name = "";
    local npcCfg = ConfigManager.Get( EConfigIndex.t_npc_data, self.npcid );
    if npcCfg then
        name = npcCfg.npc_name;
    end
    local parseMsg = loadstring( self.msg );
    local index1, index2 = string.find( self.msg, "%." );
    if index1 and index2 then
        local str1 = string.sub( self.msg, 1, index1 -1 );
        local str2 = string.sub( self.msg, index2 + 1, string.len( self.msg ) );
        dispMsg = gs_screenplay[str2] or "gs_screenplay配置错误:"..str2;
    end
    self.labDlg:set_text( dispMsg );
    PublicFunc.SetSinkText(name, self.labName1, self.labName2)
    self.spTitle:set_active(name ~= " ");

    self.aniObj:animator_play("ui_701_drama_duihua_diban")
end

function ScreenPlayTranslate:SetAndShow( data )
    if self.ui then
        self.msg = data.msg or "配置错误";
        self.icon_path = data.icon_path;
        self.npcid = data.npcid or 0;
        self.show_cancel = data.show_cancel
        self:UpdateUi();
        self:Show();
    end
end

function ScreenPlayTranslate:OnAnimCallback(obj, value)
    if value == "1" then
        self.aniObj:animator_play("ui_701_drama_duihua_left")
    else
        self.btnCancel:set_active(true)
        self.btnLeave:set_active(true)
    end
end

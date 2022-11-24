UiSceneChange = Class('UiSceneChange',UiBaseClass);

--入场
function UiSceneChange.Enter(scene, param)
    if not UiSceneChange.instace then
        UiSceneChange.instace = UiSceneChange:new({ani_type=1,scene=scene,param=param});
    else
        UiSceneChange.instace.obj_animation:set_animator_enable(true)
        UiSceneChange.instace:PlayAnimation(1);
    end
    NoticeManager.Notice(ENUM.NoticeType.SceneChangeEnter)
end

--退场
function UiSceneChange.Exit()
    if not UiSceneChange.instace then
        UiSceneChange.instace = UiSceneChange:new({ani_type=2});
    else
        UiSceneChange.instace.obj_animation:set_animator_enable(true)
        UiSceneChange.instace:PlayAnimation(2);
    end
end

function UiSceneChange.SetEnterCallback(callback, param)
    UiSceneChange._enterCallback = callback;
    UiSceneChange._enterParam = param;
end

function UiSceneChange.SetExitCallback(callback, param)
    UiSceneChange._exitCallback = callback;
    UiSceneChange._exitParam = param;
end
 
function UiSceneChange.EnterCallback()
    if not UiSceneChange._enterCallback then return end
    
    Utility.CallFunc(UiSceneChange._enterCallback,UiSceneChange._enterParam);

    UiSceneChange.instace.obj_animation:set_animator_enable(false)    
end

function UiSceneChange.ExitCallback()
    if UiSceneChange.instace then 
        UiSceneChange.instace:Hide()
    end
    if not UiSceneChange._exitCallback then return end

    Utility.CallFunc(UiSceneChange._exitCallback,UiSceneChange._exitParam);
end

function UiSceneChange.HideInstace()
    if UiSceneChange.instace then
        UiSceneChange.instace:Hide();
    end
end

function UiSceneChange.Destroy()
    if UiSceneChange.instace then
        --UiSceneChange.instace:DestroyUi();
        --UiSceneChange.instace = nil;
        UiSceneChange._enterCallback = nil;
        UiSceneChange._exitCallback = nil;
    end
end

--------------------------------------------------
--初始化
function UiSceneChange:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/loading/panel_transitions.assetbundle";
    self:SetData(data);
    UiBaseClass.Init(self);
end

--注册回调函数
function UiSceneChange:RegistFunc()
    UiBaseClass.RegistFunc(self);
end

--注册消息分发回调函数
function UiSceneChange:MsgRegist()
    UiBaseClass.MsgRegist(self);
end

--注销消息分发回调函数
function UiSceneChange:MsgUnRegist()
    UiBaseClass.MsgUnRegist(self);
end

--加载UI
function UiSceneChange:LoadUI()
    app.log("start ani load time: "..app.get_time())

    UiBaseClass.LoadUI(self);
    local load_type = 0;
    if self.scene and  self.param and self.param.levelData then
        load_type = self.param.levelData.isVs;
    end

    UiLevelLoadingNew.PreLoadAssets(load_type)
end

--初始化UI
function UiSceneChange:InitUI(asset_obj)
    
    app.log("ani load time : "..app.get_time())   

    UiBaseClass.InitUI(self, asset_obj)
    self.ui:set_name('ui_scene_change');

    self.obj_animation = asset_game_object.find("uiroot/ui_2d/ui_scene_change/animation");
    self:UpdateUi();
end

function UiSceneChange:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return
    end
    if self.ani_type then
        self:PlayAnimation(self.ani_type);
    end
end

--ani_type==1:进场（挡住屏幕）    type==2:退场（不挡屏幕）
function UiSceneChange:PlayAnimation(ani_type)
    self:Show();
    if ani_type == 1 then
        if self.obj_animation == nil then
            return 
            --app.log("xxxxxxxxxxxxxx"..debug.traceback());
        end
        --self.obj_animation:set_animator_speed("panel_transitions",0.5);
        self.obj_animation:animator_play("panel_transitions");
    elseif ani_type == 2 then
        if self.obj_animation == nil then
            return 
            --app.log("xxxxxxxxxxxxxx"..debug.traceback());
        end
        --self.obj_animation:set_animator_speed("panel_transitions_come",0.5);
        self.obj_animation:animator_play("panel_transitions_come");
    end
end

function UiSceneChange:SetData(data)
    self.ani_type = data.ani_type;
    self.scene = data.scene;
    self.param = data.param;
end

function UiSceneChange:DestroyUi()
    self.scene = nil;
    self.param = nil;
    UiBaseClass.DestroyUi(self)
end
PrologueFightManager = Class('PrologueFightManager' , FightManager)

function PrologueFightManager.InitInstance()
    PublicStruct.Fight_Sync_Type = ENUM.EFightSyncType.Single
	FightManager.InitInstance(PrologueFightManager)
	return PrologueFightManager;
end

function PrologueFightManager:InitData()
    FightManager.InitData(self)
    -- self.quittype = 1;
end

function PrologueFightManager:OnUiInitFinish()
	app.opt_enable_net_dispatch(true);

    CameraManager.SetSceneCameraActive(false)  --隐藏战斗摄像机
end

function PrologueFightManager:GetUIAssetFileList(out_file_list)
    FightManager.GetUIAssetFileList(self, out_file_list)

end


function PrologueFightManager:LoadSceneObject()
	self:LoadUI()
end

function PrologueFightManager:Start()
    FightManager.Start(self)
end

function PrologueFightManager:RegistFunc()
    FightManager.RegistFunc(self)
end

function PrologueFightManager:MsgRegist()

end

function PrologueFightManager:MsgUnRegist()
   
end

function PrologueFightManager:Update()

end

-- function PrologueFightManager:GetUIAssetFileList(out_file_list)
--     FightManager.GetUIAssetFileList(self, out_file_list)

--     PrologueFightManager.pre_load_file_list = PrologueFightManager.pre_load_file_list  or {
--         --     --序章界面预加载
--         "assetbundles/prefabs/ui/level/ui_710_xuzhang.assetbundle",
--     }

--     for k, v in ipairs(PrologueFightManager.pre_load_file_list) do
--         out_file_list[v] = v
--     end

  
-- end

-- function PrologueFightManager:GetOtherAssetFileList(out_file_list)
--     FightManager.GetOtherAssetFileList(self, out_file_list)
-- end

function PrologueFightManager:OnBeginDestroy()
    
end

TriggerFunc = TriggerFunc or {};

function TriggerFunc.BossShow(callback,param)
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.ShowAllMonster(nil,{[2]=0});
    TriggerFunc.ShowAllHero(nil,{[2]=0});
    TriggerFunc.ShowAllItem(nil,{[2]=0});
    TriggerFunc.ShowAllUI(nil,{[2]=0});
    TriggerFunc.CreateShowBoss(nil,param);
    -- TriggerFunc.MoveCameraToBossCamera(function ()
    	TriggerFunc.ShowFigthCameraObj(nil,{[2]=0})
    	TriggerFunc.PlayBossAnim(nil,{[2]=param.anim_id})
        TriggerFunc.BossAppearVoice(nil, param)
    -- end,{[2]=1,[3]="easeInOut"});
end

function TriggerFunc.BossAnimEnd(callback,param)
    TriggerFunc.ShowFigthCameraObj(nil,{[2]=1});
    -- TriggerFunc.SetCamera(nil,{
    --     pos={TriggerFunc.entityCameraObj:get_position()},
    --     rot={TriggerFunc.entityCameraObj:get_rotation()},
    --     });
    -- TriggerFunc.MoveBackCamera(function ()
        TriggerFunc.ShowBoss(nil, {boss=TriggerFunc.bossEntity:GetCardInfo().number,isShow=true});
    	TriggerFunc.DeleteShowBoss();
	    
	    TriggerFunc.ShowAllMonster(nil,{[2]=1});
	    TriggerFunc.ShowAllHero(nil,{[2]=1});
	    TriggerFunc.ShowAllItem(nil,{[2]=1});

        TriggerFunc.SetAllAI(nil,{[2]=1});

	    TriggerFunc.ShowAllUI(nil,{[2]=1});
	    if callback then
	        callback();
	    end
    -- end,{[2]=0,});
end

function TriggerFunc.EndPose(callback, param)
    TriggerFunc.Wait( function ()
        TriggerFunc.PlayTransitionUI( function ()
                TriggerFunc.SetAllAI(nil,{[2]=0});
                TriggerFunc.ShowAllMonster(nil,{[2]=0});
                TriggerFunc.ShowAllHero(nil,{[2]=0});
                TriggerFunc.ShowAllItem(nil,{[2]=0});
                TriggerFunc.CreateTeam(nil, param);
                TriggerFunc.ShowFigthCameraObj(nil,{[2]=0});
                TriggerFunc.PlayTeamEnd(callback,param);
                TriggerFunc.PlayEndSound(nil,nil);
                TriggerFunc.HideSceneEffect(nil);
        end ,nil);
    end ,{[2]=1});
end

function TriggerFunc.EndPoseFinish(callback,param)
    TriggerFunc.StopTeamEndAnim(callback,param);
end

function TriggerFunc.BossDead(callback, param)
    TriggerFunc.SetAllAI(nil,{[2]=0});
    --TriggerFunc.BossDeadVoice(nil, nil)
    TriggerFunc.PlayBossDeadAnim(callback,param);
end

function TriggerFunc.BaseDead(callback, param)
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.PlayBaseDeadAnim(callback,param);
end

function TriggerFunc.BeginAnim(callback,param)
    TriggerFunc.ShowAllUI(nil,{[2]=0});
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.PlayFightStartUI(function ()
        TriggerFunc.ShowAllUI(callback,{[2]=1})
        TriggerFunc.SetAllAI(nil,{[2]=1});
    end);
    TriggerFunc.RecordSceneCameraInfo();
    TriggerFunc.SetCamera(nil,{pos_name="begin_camera",lookat=1});
    TriggerFunc.Wait( function ()
        TriggerFunc.MoveBackCamera( nil,param)
    end ,{[2]=0.3});
end

function TriggerFunc.BeginAnimOnlyCamera(callback,param)
    TriggerFunc.ShowAllUI(nil,{[2]=0});
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.RecordSceneCameraInfo();
    TriggerFunc.SetCamera(nil,{pos_name="begin_camera",lookat=1});
    TriggerFunc.Wait( function ()
        TriggerFunc.MoveBackCamera( function ()
            TriggerFunc.ShowAllUI(callback,{[2]=1})
            TriggerFunc.SetAllAI(nil,{[2]=1});
        end,param)
    end ,{[2]=0.3});
end

function TriggerFunc.BeginAnimOnlyNumber(callback,param)
    TriggerFunc.ShowAllUI(nil,{[2]=0});
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.PlayFightStartUI(function ()
        TriggerFunc.ShowAllUI(callback,{[2]=1})
        TriggerFunc.SetAllAI(nil,{[2]=1});
    end);
end

function TriggerFunc.ScreenPlay(callback,param)
    TriggerFunc.SetAllAI(nil,{[2]=0});
    TriggerFunc.ShowAllUI(nil,{[2]=0});
    TriggerFunc.ShowAllMonster(nil,{[2]=0});
    TriggerFunc.ShowAllHero(nil,{[2]=0});
    TriggerFunc.ShowAllItem(nil,{[2]=0});
    TriggerFunc.ShowFigthCameraObj(nil,{[2]=0});
    TriggerFunc.PlayScreenplay(callback,param);
end

function TriggerFunc.ScreenPlayOver(callback,param)
    TriggerFunc.ShowAllUI(nil,{[2]=1});
    TriggerFunc.ShowAllMonster(nil,{[2]=1});
    TriggerFunc.ShowAllHero(nil,{[2]=1});
    TriggerFunc.ShowAllItem(nil,{[2]=1});

    TriggerFunc.SetAllAI(nil,{[2]=1});

    TriggerFunc.ShowFigthCameraObj(nil,{[2]=1});
    if callback then
        callback();
    end
end


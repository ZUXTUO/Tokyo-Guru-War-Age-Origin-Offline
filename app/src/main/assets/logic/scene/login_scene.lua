--
-- Created by IntelliJ IDEA.
-- User: pokong
-- Date: 2016/1/30
-- Time: 16:28
-- To change this template use File | Settings | File Templates.
--

login_scene = {};

function login_scene.Start()
    -- GameBegin.reload();
    --SceneLoading.start("assetbundles/prefabs/map/044_denglujiemian/70000044_denglujiemian.assetbundle","70000044_denglujiemian",login_scene.OnLoadScene);
    SceneLoading.start("assetbundles/prefabs/map/ssg_scene000/ssg_scene000.assetbundle","ssg_scene000",login_scene.OnLoadScene);
end

function login_scene.OnLoadScene()
    if GameBegin then
        login_bg.Start(Root.game_start);
    end
end



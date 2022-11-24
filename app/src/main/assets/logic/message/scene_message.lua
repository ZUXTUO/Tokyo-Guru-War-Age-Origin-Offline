--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/6
-- Time: 14:52
-- To change this template use File | Settings | File Templates.
--

SceneMessage = {};

--[[//设置加载场景时的侦听调用
	//回调传出参数 loading(float progress);
	//回调传出参数 loaded(void);
	//回调传出参数 detail_loading(float progress);
	//回调传出参数 detail_loaded(void);
	void set_listener(stringornil loading, stringornil loaded, stringornil detail_loading, stringornil detail_loaded);]]
function SceneMessage.set_listener(loading, loaded, detail_loading, detail_loaded)
	scene.set_listener_v5(loading, loaded, detail_loading, detail_loaded);
end

--[[//加载场景, 需要传入场景文件的路经
	void load(string filepath);]]
function SceneMessage.load(filepath,scenename)
	if filepath == nil or filepath == "" or scenename == nil or scenename == "" then return end;
	--[[公司日志：切换场景]]
	SystemLog.SceneSwitch(scenename,os.time());

	scene.load_v5(filepath,scenename);
	ResourceRecord.Add(filepath)
end

return SceneMessage;


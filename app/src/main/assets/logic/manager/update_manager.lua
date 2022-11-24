--
-- Created by IntelliJ IDEA.
-- User: PoKong_OS
-- Date: 2015/3/4
-- Time: 10:28
-- To change this template use File | Settings | File Templates.
--

UpdateManager = {};

--[[
-- 	//设置文件check_op网络相关侦听处理函数
	//网络连接成功处理 on_connect();
	//网络连接关闭 on_close();
	//网络连接错误处理 on_error();
	//文件服验证错误 on_device_error(string message, string url);
	//文件服务返回待更新文件信息 on_op_version(table{all_fsize=int, table{oid=int, path=string, fsize=int, type=int}, ...} );
	void set_op_listener(string on_connect, string on_close, string on_error, string on_device_error, string on_op_version);]]
function UpdateManager.set_op_listener(on_connect,on_close,on_error,on_device_error,on_op_version)
	gupdate.set_op_listener(
		on_connect,
		on_close,
		on_error,
		on_device_error,
		on_op_version
	);
end

--[[//异步连接文件服
	void async_connect(string ip, int port);]]
function UpdateManager.async_connect(ip, port)
	gupdate.async_connect(ip, port);
end

--[[//设置设备号
	void set_device_id(int deviceId);]]
function UpdateManager.set_device_id(deviceId)
	if deviceId == nil then return end;
	gupdate.set_device_id(deviceId);
end

--[[//开始检查并下载文件
	void check_op(int current_op_id);]]
function UpdateManager.check_op(current_op_id)
	if current_op_id == nil then return end;
	gupdate.check_op(current_op_id);
end

--[[//添加下载
void add_down(int priority, string on_downing, string on_complete, string filepath);]]
function UpdateManager.add_down(priority, on_downing, on_complete, filepath)
	gupdate.add_down(priority, on_downing, on_complete, filepath);
end

--[[//添加下载
void add_down_group(int priority, string on_downing, string on_complete, auto L);]]
function UpdateManager.add_down_group(priority, on_downing, on_complete, L)
	gupdate.add_down_group(priority, on_downing, on_complete, L);
end


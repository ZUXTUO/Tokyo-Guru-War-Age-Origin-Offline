AssociatedFilesMgr = 
{
	_AssociatedFilesList = {}, -- [filePath] = {[1]={path,FileType},[2]={path,FileType},}
	_AssociatedFileCache = {}, -- [obj] = cache （弱引用）
	_MainFileCallback = {},  -- [filePath] = func,
	_WaitAssociatedList = {}, -- [filePath] = {callback,callback},
};
local self = AssociatedFilesMgr;
local EFileType = 
{
	Asset = 1,
	Texture = 2,
	Animator = 3,

}

local LoadFunc = 
{
	[EFileType.Asset] = {ResourceLoader.LoadAsset,ResourceLoader._LoadAsset},
	[EFileType.Texture] = {ResourceLoader.LoadTexture,ResourceLoader._LoadTexture},
	[EFileType.Animator] = {ResourceLoader.LoadAncontroller,ResourceLoader._LoadAncontroller},
};

function AssociatedFilesMgr.Init()
	local cfg = ConfigManager._GetConfigTable(EConfigIndex.t_model_list);
	for k,model_info in pairs(cfg) do
		local animPath = PublicFunc.GetModelAnimFilePath(k);
		if type(animPath) == "string" then
			local modelName = model_info.file;
			local filePath = string.format('assetbundles/prefabs/character/%s/%s_fbx.assetbundle', modelName, modelName);
			self._AssociatedFilesList[filePath] = {{path=animPath,type=3},};
		end
	end
	-- app.log("#lhf#self._AssociatedFilesList:"..table.tostring(self._AssociatedFilesList));
end

function AssociatedFilesMgr.Load(file_type, main_path, callback, group, unloadRawFile)
	list = self._AssociatedFilesList[main_path];
	-- 有关联文件
	if list then
		for i,info in pairs(list) do
			LoadFunc[info.type][1](info.path, self.LoadCallback, group, unloadRawFile);
			-- app.log("#lhf#加载关联文件.file:"..table.tostring(info));
		end
	end
	self._MainFileCallback[main_path] = self._MainFileCallback[main_path] or{};
	table.insert(self._MainFileCallback[main_path], callback);
	if #self._MainFileCallback[main_path] <= 1 then
		LoadFunc[file_type][2](main_path, self.LoadCallback, group, unloadRawFile);
	end
end

function AssociatedFilesMgr.LoadCallback(pid, fpath, asset_obj, error_info)
	list = self._AssociatedFilesList[fpath];
	-- app.log("#lhf#加载文件.file:"..tostring(fpath));
	-- 有关联文件
	if list then
		for i,info in pairs(list) do
			local obj = ResourceManager.GetResourceObject(info.path)
			if not obj then
				-- app.log("#lhf#加载文件("..fpath..")有关联文件未加载.file:"..info.path);
				if self._WaitAssociatedList[info.path] == nil then
					self._WaitAssociatedList[info.path] = {};
				end
				for k,func in ipairs(self._MainFileCallback[fpath]) do
					local data = 
					{
						pid = pid,
						fpath = fpath,
						asset_obj = asset_obj,
						error_info = error_info,
						callback = func,
					}
					table.insert(self._WaitAssociatedList[info.path],data);
				end
				return;
			end
		end
	end
	for k,func in ipairs(self._MainFileCallback[fpath]) do
		if func == self.LoadCallback then
			for k,v in pairs(self._WaitAssociatedList[fpath] or {}) do
				ResourceLoader.HandleCallBack(v.callback, v.pid, v.fpath, v.asset_obj, v.error_info);
			end
			self._WaitAssociatedList[fpath] = nil;
		else
			ResourceLoader.HandleCallBack(func, pid, fpath, asset_obj, error_info);
		end
	end
	self._MainFileCallback[fpath] = nil;
end

AssociatedFilesMgr.Init();
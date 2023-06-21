-- 引导提示管理类
local GuideTipMgr = {
	enable = true,	 
	debug = true, 
}

local function log(str)
	if GuideTipMgr.debug then
		app.log(str)
	end
end
local function UpdateTipActiveUI(gtEnum)
	--log("GuideTipMgr 1UpdateTipActive"..tostring(gtEnum))
	local uManager = uiManager
	if not uManager then 
		--log("GuideTipMgr 6UpdateTipActive"..tostring(gtEnum))
		return 
	end
	local data = GuideTipData.GetDataByDtEnum(gtEnum)
	if data and data.uiId and data.uiNode then
		--log("GuideTipMgr 2UpdateTipActive"..tostring(gtEnum).. " uiId ="..tostring(data.uiId))
		 local scene = uManager:FindUI(data.uiId)
		 if scene and scene.ui then
		 	local uiSprite = nil;
		 	if type(data.uiNode) == "table" then
		 		uiSprite = data.uiNode.funcs(data.uiNode.param);
		 	else
		 		uiSprite = ngui.find_sprite(scene.ui,data.uiNode)
		 	end
		 	local state = false
	 		if GuideTipData.GetRedCount(gtEnum) > 0 then
	 			state = true
	 		else
	 			state = false		 			
	 		end
		 	--log("GuideTipMgr 3UpdateTipActive"..tostring(gtEnum))
		 	if uiSprite then		 		
		 		uiSprite:set_active(state)
		 		--log("GuideTipMgr 4UpdateTipActive"..tostring(gtEnum).." 	"..tostring(state))
		 	else
--		 		log("GuideTipMgr no -4UpdateTipActive"..tostring(gtEnum).." 	"..tostring(state).."	"..tostring(data.uiNode))
		 	end ;
		 else
		 		--log("GuideTipMgr -3UpdateTipActive"..tostring(gtEnum))
		 end
	else
--		log("GuideTipMgr -5UpdateTipActive"..tostring(gtEnum))
	end
end

local function _func_red(enumid)		
	--log("GuideTipMgr 1_func_red "..tostring(enumid))			
	local _gtData = GuideTipData.GetDataByDtEnum(enumid)
	if not _gtData then
		app.log("未找到当前id的小红点...."..tostring(enumid));
		return;
	end
	if _gtData.funcs and _gtData.fail_care_notice == nil then
		app.log("小红点系统的子节点不能没有所关心的通知...."..tostring(enumid));
		return;
	end
	--log("GuideTipMgr 2_func_red "..tostring(enumid))			
	--app.log("start "..tostring(enumid));
	local result = {}
	if _gtData.funcs then
		--log("GuideTipMgr 3_func_red "..tostring(enumid))
		--注意这里成功的话就是Gt_Enum_Wait_Notice.Success   失败则是一个table表 包含失败的多个功能的错误码
		result = _gtData.funcs(_gtData.param);
		GuideTipData.SetTempRef(enumid, result, nil, enumid);
	end
	--app.log("end  "..tostring(enumid).."..."..table.tostring(GuideTipData.GetFailCondition()))
end

function Guide_PrintAll(id)
	if id then
		local data = GuideTipData.GetDataByDtEnum(id)
		if data then
			app.log(tostring(id)..".."..table.tostring(data.temp_ref)..".."..table.tostring(data.failCondition));
		end
	else
		local data = GuideTipData.GetData()
		for k, v in pairs(data) do
			app.log(tostring(k)..".."..table.tostring(v.temp_ref)..".."..table.tostring(v.failCondition));
		end
	end
	
end

local function initAll()
--	log("GuideTipMgr.initAll")
	local data = GuideTipData.GetData()
	if data then
		for k, v in pairs(data) do
			_func_red(k)
		end
	end	
	-- log("GuideTipMgr initAll after" .. table.tostring(GuideTipData.GetData()))
	--PrintAll();
end
local uiidToGtenum = {};
local function UpdateUiByCareid(id)
	--在主场景才刷新界面小红点
	if FightScene.GetPlayMethodType() ~= MsgEnum.eactivity_time.eActivityTime_MainCity then
		return;
	end
	local euiid = id or uiManager:GetCurSceneID()
	if euiid and uiidToGtenum[euiid] then
		for gtEnum,gtData in pairs(uiidToGtenum[euiid]) do
			UpdateTipActiveUI(gtEnum);
		end
	end
end

--@param nType 1 uiId,2小红点ID，3强制执行数据逻辑
--@param id 如果nType=1，则id为UIManager中EUI_ID(如果id为空则刷新UiManager中栈顶),如果nType=2,则为guide_tip_enum中枚举id
local function NoticeUpdate(nType,id)
	-- app.log("NoticeUpdate nType="..tostring(nType).." id="..tostring(id).." isForced="..tostring(isForced)..debug.traceback())
	--isForced = true
	if nType == nil or nType == 1 then
		UpdateUiByCareid(id);
	elseif nType == 2 then
		_func_red(id);
		UpdateUiByCareid();
	end
	
end

local gNoticeCare = 
{

}
function GuideTipMgr.Init()
    if not AppConfig.get_enable_guide_tip() then
        app.log("guide tip is closed!!!!")
        return
    end
    GuideTipMgr.isInit = true;
--	log("GuideTipMgr.Init")
	--初始化通知关心列表
	local data = GuideTipData.GetData();
	for k, v in pairs(data) do
		
		if type(v.fail_care_notice) == "table" then
			for m, n in pairs(v.fail_care_notice) do
				if not gNoticeCare[n] then
					gNoticeCare[n] = {};
				end
				gNoticeCare[n][k] = 1;
			end
		end
		if not uiidToGtenum[v.uiId] then
			uiidToGtenum[v.uiId] = {}
		end
		uiidToGtenum[v.uiId][k] = 1;
	end
	--app.log("care_notitce...."..table.tostring(gNoticeCare));
    --初始化第一次数据
	--初始化
	GuideTipMgr.updateList = {};
	initAll()
	GuideTipMgr.updateFrame = 0;
	GuideTipMgr.maxUpdateFrame = 30;
	Root.AddUpdate(GuideTipMgr.Update)
    --注册事件监听
	NoticeManager.BeginListen(ENUM.NoticeType.CardItemChange, GuideTipData.OnItemChange);
	--初始化时间通知
	local initTime = GuideTipData.GetInitTipsTime();
	for k, v in pairs(initTime) do
		if g_dataCenter.activity[v] and g_dataCenter.activity[v].InitTipsTime then
			g_dataCenter.activity[v]:InitTipsTime();
		end
	end
end

local updateCount = 20;

function GuideTipMgr.Update(dt)
	GuideTipMgr.updateFrame = GuideTipMgr.updateFrame + 1;
	if GuideTipMgr.updateFrame >= GuideTipMgr.maxUpdateFrame then
		GuideTipMgr.updateFrame = 0;
		for k, v in pairs(GuideTipMgr.updateList) do
			updateCount = updateCount - 1;
			if updateCount < 0 then
				updateCount = 20;
				break;
			end
			--app.log("update....."..tostring(k));
			NoticeUpdate(2, k);
			GuideTipMgr.updateList[k] = nil;
		end
	end
end

--非外部接口哈  不得擅自使用
function GuideTipMgr.Notice(enumid)
	GuideTipMgr.updateList[enumid] = 1;
	--app.log(tostring(enumid).."........"..debug.traceback())
end

--mgr初始化
function GGuideTipMgrInit()
	GuideTipMgr.Init();
end
--通知ui更新
function GNoticeGuideTipUiUpdate(uiId)
	--未初始化就不通知了
	if not GuideTipMgr.isInit then
		return;
	end
	NoticeUpdate(1, uiId);
end
--强制设置状态
function GGuideTipForceSetState(enumid, state)
	local _gtData = GuideTipData.GetDataByDtEnum(enumid)
	if not _gtData then
		app.log("服务器枚举传递错误 "..tostring(enumid));
		return;
	end
	local redPoint = GuideTipData.GetRedPointState();
	if not redPoint[enumid] then
		app.log("客户端配置错误 此红点不是上线服务器推动状态 "..tostring(enumid));
		return;
	end
	if redPoint[enumid].obj then
		redPoint[enumid].funcs(redPoint[enumid].obj, state == 1);
	else
		redPoint[enumid].funcs(state == 1);
	end
	-- GuideTipData.SetState(enumid, state);
	-- UpdateTipActiveUI(enumid);
end
------------------------------------------------------外部调用------------------
--waitNotice 参见Gt_Enum_Wait_Notice枚举
--enumid 只有在你确定只更新指定功能的时候才采用此id  参见Gt_Enum枚举
function GNoticeGuideTip(waitNotice, enumid)
	--app.log(tostring(waitNotice)..".........."..tostring(enumid));
	--未初始化就不通知了
	if not GuideTipMgr.isInit then
		return;
	end
	if waitNotice == nil then
		app.log("waitNotice=nil traceback="..debug.traceback());
		return;
	end
	if waitNotice == Gt_Enum_Wait_Notice.Time or 
		waitNotice == Gt_Enum_Wait_Notice.Forced 
		then
		if enumid == nil then
			app.log("小红点系统：时间刷新以及强制刷新通知必须制定对应的系统功能 waitNotice="..tostring(waitNotice)..debug.traceback());
			return;
		end
	end
	-- app.log("GNoticeGuideTip.."..tostring(waitNotice)..debug.traceback())
	--先检查因为此通知失败的对象
	GuideTipData.CheckFailCondition(waitNotice, enumid, function(k)
			GuideTipMgr.Notice(k);
		end);
	local careList = gNoticeCare[waitNotice];
	if type(careList) == "table" then
		if enumid then
			if careList[enumid] then
				GuideTipMgr.Notice(enumid);
			else
				app.log(string.format("此id=%d不关注此通知notice=%d", enumid, waitNotice)..debug.traceback());
				return;
			end
		else
			for k, v in pairs(careList) do
				if GuideTipData.GetRedCount(k) > 0 then
					GuideTipMgr.Notice(k);
				end
			end
		end
	else
		app.log("无关心此通知的小红点  notice="..tostring(waitNotice)..debug.traceback());
	end
end
--强制刷新 请慎用
--只有采用一些特殊功能才会使用此接口
--enumid参见Gt_Enum枚举
function GGuideTipForceRefresh(enumid)
	--未初始化就不通知了
	if not GuideTipMgr.isInit then
		return;
	end
	GuideTipMgr.Notice(enumid);
end

--region guild_log_ui.lua
--author : zzc
--date   : 2016/07/21

-- 社团日志界面
GuildLogUI = Class('GuildLogUI', UiBaseClass)

-------------------------------------local声明-------------------------------------
local _local = {}
_local.uipath = "assetbundles/prefabs/ui/guild/ui_2806_guild_journal.assetbundle"

_local.UIText = {
	[1]	 = 	"[fde517]%s[-]创建了社团",
	[2]	 = 	"[fde517]%s[-]加入社团",
	[3]	 = 	"[fde517]%s[-]退出社团",
	[4]	 = 	"[fde517]%s %s[-]批准了[fde517]%s[-]加入社团",
	[5]	 = 	"[fde517]%s[-]被[fde517]%s %s[-]移出社团",
	[6]	 = 	"[fde517]%s %s[-]将[fde517]%s[-]任命为[fde517]%s[-]",
	[7]	 = 	"[fde517]%s[-]将[fde517]%s[-]传递给了[fde517]%s[-]",
	[8]	 = 	"[fde517]%s %s[-]修改社团名为:[fde517]%s[-]",
	[9]	 = 	"[fde517]%s %s[-]修改了社团公告",
	[10] =	"[fde517]%s %s[-]发送了全体邮件",
	[11] =	"[fde517]%s[-]在[fde517]%s[-]中捐献了[fde517]%s%s[-]，使其获得了经验值[fde517]%s[-]",
	[12] =	"[fde517]%s[-]在[fde517]社团BOSS[-]中伤害排名第一",
	[13] =	"[fde517]%s[-]在[fde517]社团BOSS[-]中最后一击完美击杀了BOSS",
	[14] =	"[fde517]%s[-]在[fde517]%s[-]中获得手气最佳",
	[15] =	"[fde517]%s %s[-]修改入社申请战队等级:[fde517]%s[-]",
	[16] =	"[fde517]%s %s[-]修改入社申请审核条件:[fde517]%s[-]",
	[17] =	"[fde517]社团等级[-]提升至[fde517]%s[-]",
	[18] =	"[fde517]%s[-]开启",
	[19] =	"[fde517]%s[-]等级提升至[fde517]%s[-]",
	[20] =	"[fde517]%s[-]对社团BOSS[fde517]%s[-]完成了最后一击，击杀时间%s年%s月%s日",

	[90] = "%02d月%02d日", --月日
	[91] = "%02d:%02d",    --时分

	[201] = "社团实验室-社团人数增加",
	[202] = "社团实验室-精英人数增加",
	[203] = "BOSS研究院-伤害加成",
	[204] = "BOSS研究院-免费复活",
	[205] = "社团等级-社团经验",

	[301] = "金币",
	[302] = "钻石",

	[401] = "社团红包-金币红包",
	[402] = "社团红包-钻石红包",
	[403] = "社团红包-神器红包",
	
	[501] = "无限制",
	[502] = "%s级",

	[601] = "允许任何人加入",
	[602] = "需要批准",
	[603] = "禁止加入",

	[701] = "社团BOSS",
	[702] = "社团副本",
	[703] = "社团红包",
}

_local.MaxType = 20

-------------------------------------类方法-------------------------------------
function GuildLogUI:Init(data)
    self.pathRes = _local.uipath;
	self.params = {}
	for i=1, _local.MaxType do
		self.params[i] = {content=_local.UIText[i], type={}}
	end
	-- 参数类型: 0原始 1职位 2社团科技 3捐献货币类型 4社团红包 5等级条件 6审核条件 7社团功能 
	self.params[1].type = {0}
	self.params[2].type = {0}
	self.params[3].type = {0}
	self.params[4].type = {1,0,0}
	self.params[5].type = {0,1,0}
	self.params[6].type = {1,0,0,1}
	self.params[7].type = {0,1,0}
	self.params[8].type = {1,0,0}
	self.params[9].type = {1,0}
	self.params[10].type = {1,0}
	self.params[11].type = {0,2,3,0,0}
	self.params[12].type = {0}
	self.params[13].type = {0}
	self.params[14].type = {0,4}
	self.params[15].type = {1,0,5}
	self.params[16].type = {1,0,6}
	self.params[17].type = {0}
	self.params[18].type = {7}
	self.params[19].type = {2,0}
	self.params[20].type = {0,0,0,0,0}

	self.openLevel = ConfigManager.Get(EConfigIndex.t_discrete,MsgEnum.ediscrete_id.eDiscreteId_guildEnableLevel).data

	UiBaseClass.Init(self, data);
end

function GuildLogUI:Restart(data)
	if UiBaseClass.Restart(self, data) then
		if not g_dataCenter.guild:IsLoadLogData() then
			msg_guild.cg_request_all_log()
		end
	end
end

function GuildLogUI:InitData(data)
	UiBaseClass.InitData(self, data);
end

function GuildLogUI:RegistFunc()
    UiBaseClass.RegistFunc(self);

    self.bindfunc["on_init_item"] = Utility.bind_callback(self, self.on_init_item)
    self.bindfunc["on_update_log_data"] = Utility.bind_callback(self, self.on_update_log_data)
end

function GuildLogUI:MsgRegist()
	UiBaseClass.MsgRegist(self);
	PublicFunc.msg_regist(msg_guild.gc_add_guild_log, self.bindfunc["on_update_log_data"])
	PublicFunc.msg_regist(msg_guild.gc_request_all_log, self.bindfunc["on_update_log_data"])
end

function GuildLogUI:MsgUnRegist()
	UiBaseClass.MsgUnRegist(self);
	PublicFunc.msg_unregist(msg_guild.gc_add_guild_log, self.bindfunc["on_update_log_data"])
	PublicFunc.msg_unregist(msg_guild.gc_request_all_log, self.bindfunc["on_update_log_data"])
end

function GuildLogUI:InitUI(asset_obj)
	UiBaseClass.InitUI(self, asset_obj)
	self.ui:set_name("ui_guild_log");

	self.items = {}

	-- test begin
	-- self.logData = {}
	-- data = {} 
	-- table.insert(data, {time=system.time(), ntype=1, params={"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=2, params={"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=3, params={"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=4, params={1,"傻婆率","帅帅胡"}})
	-- table.insert(data, {time=system.time(), ntype=5, params={"帅帅胡",1,"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=6, params={1,"傻婆率","帅帅胡",2}})
	-- table.insert(data, {time=system.time(), ntype=7, params={"傻婆率",1,"帅帅胡"}})
	-- table.insert(data, {time=system.time(), ntype=8, params={1,"傻婆率","天堂"}})
	-- table.insert(data, {time=system.time(), ntype=9, params={1,"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=10, params={1,"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=11, params={"傻婆率",1,1,100,200}})
	-- table.insert(data, {time=system.time(), ntype=12, params={"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=13, params={"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=14, params={"傻婆率",1}})
	-- table.insert(data, {time=system.time(), ntype=15, params={1,"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=16, params={1,"傻婆率"}})
	-- table.insert(data, {time=system.time(), ntype=17, params={2}})
	-- table.insert(data, {time=system.time(), ntype=18, params={2}})
	-- table.insert(data, {time=system.time(), ntype=19, params={2,2}})
	-- for i = 1, 500 do
	-- 	local log = {}
	-- 	log.time = system.time() - i * 1200
	-- 	log.ntype = 2
	-- 	log.params = {"我是测试玩家"}
	-- 	table.insert(data, log)
	-- end
	-- for i, v in ipairs(data) do
	-- 	table.insert(self.logData, self:GetFormatLog(v))
	-- end
	-- test end

	self:UpdateLogData()

	local path = "center_other/animation/scro_view/"
	------------------------------ 中部 -----------------------------
	-- self.scrollView = ngui.find_scroll_view(self.ui, path.."panel")
	-- self.wrapContent = ngui.find_wrap_content(self.ui, path.."panel/wrap_content")
	-- self.wrapContent:set_on_initialize_item(self.bindfunc["on_init_item"])

	-- self.labContent = ngui.find_label(self.ui, path.."panel/lab_word")

	self.conts = {}
	for i=1, 3 do
		self.conts[i] = {}
		self.conts[i].self = self.ui:get_child_by_name(path.."panel/cont"..i)
		self.conts[i].labTime = ngui.find_label(self.conts[i].self, "lab_time")
		self.conts[i].labContent = ngui.find_label(self.conts[i].self, "lab_word")
	end


	local path = "center_other/animation/scro_view/panel/"
	self.ui_wrap_list = ngui.find_wrap_list(self.ui, path.."wrap_cont")
    self.ui_wrap_list:set_on_initialize_item(self.bindfunc["on_init_item"])

	
    self:UpdateList()
end

function GuildLogUI:UpdateLogData()
	local logData = {}
	for i, v in ipairs(g_dataCenter.guild:GetLogData() or {}) do
		local log = self:GetFormatLog(v)
		if log then
			table.insert(logData, log)
		end
	end
	-- local logData = self.logData -- test

	local dayData = {}
	local dateStr = nil
	for i, log in ipairs(logData) do
		if dateStr ~= log.dateStr then
			dateStr = log.dateStr

			strArray = {}
			table.insert(dayData, strArray)
			table.insert(strArray, log.dateStr)
		end
		table.insert(strArray, log.timeStr.." "..log.contentStr)
	end 

	local formatData = {}
	for i, day in ipairs(dayData) do
		local data = {}
		data.title = day[1]
		table.remove(day, 1)
		data.content = table.concat(day, "\n")
		table.insert(formatData, data)
	end

	self.formatData = formatData
end

function GuildLogUI:DestroyUi()
	if self.items then
		self.items = nil
	end
	if self.conts then
		self.conts = nil
	end	
	self.formatData = nil

    UiBaseClass.DestroyUi(self);
end

--得到一条格式化的日志数据
function GuildLogUI:GetFormatLog(data)
	local result = {}
	-- 格式化日期
	local t = os.date("*t", data.time)
	result.time = data.time
	result.dateStr = string.format(_local.UIText[90], t.month, t.day)
	result.timeStr = string.format(_local.UIText[91], t.hour, t.min)
	result.contentStr = ""

	-- 容错检查
	if data.ntype > _local.MaxType then return nil end

-- 类型编号	说明	文本模板
-- 1	创建社团	%s（玩家名字）创建了社团
-- 2	加入社团	%s（玩家名字）加入社团
-- 3	退出社团	%s（玩家名字）退出社团
-- 4	审核加入	%s（职位）%s（玩家名字）批准了%s（玩家名字）加入社团
-- 5	踢出社团	%s（玩家名字）被%s（职位）%s（玩家名字）移出社团
-- 6	职位变更	%s（职位）%s（玩家名字）将%s（玩家名字）任命为%s（职位）
-- 7	职位继承	%s（玩家名字）将%s（职位）传递给了%s（玩家名字）
-- 8	修改社团名字	%s（职位）%s（玩家名字）修改社团名为:%s（社团名字）
-- 9	修改社团公告	%s（职位）%s（玩家名字）修改了社团公告
-- 10	发送社团邮件	%s（职位）%s（玩家名字）发送了全体邮件
-- 11	社团科技捐献	%s（玩家名字）在%s（1社团实验室-社团人数增加，2社团实验室-精英人数增加，3BOSS研究所-伤害加成提升，4BOSS研究所-免费复活增加，5社团等级-社团经验）中捐献了%s（1金币，2钻石，）%s（数量），使其获得了经验值%s（经验值）
-- 12	社团BOSS排名第一	%s（玩家名字）在社团BOSS中伤害排名第一
-- 13	社团BOSS最后一击	%s（玩家名字）在社团BOSS中最后一击完美击杀了BOSS
-- 14	社团红包领取	%s（玩家名字）在%s（1社团红包-金币红包，2社团红包-钻石红包，3社团红包-神器红包）中获得手气最佳
-- 15	入社等级变更	%s（职位）%s（玩家名字）修改入社申请战队等级:%s（1无限制、2指定值）
-- 16	入社审核变更	%s（职位）%s（玩家名字）修改入社申请审核条件:%s（1允许任何人加入、2需要批准、3禁止加入）
-- 17	社团等级提升	社团等级提升至%s（数值）
-- 18	社团功能开启	%s（1社团BOSS、2社团副本、3社团红包）开启
-- 19	社团科技提升	%s（1社团实验室-社团人数增加、2社团实验室-精英人数增加、3BOSS研究院-伤害加成、4BOSS研究院-免费复活）等级提升至%s（数值）
-- 20	击杀社团BOSS	%s对社团boss%s完成了最后一击，成功击杀社团boss，击杀时间%s年%s月%s日

	local params = self.params[data.ntype]
	local values = {}
	local temp = nil
	-- 参数类型: 0原始 1职位 2社团科技 3捐献货币类型 4社团红包 5等级条件 6审核条件 7社团功能 
	for i, ptype in ipairs(params.type) do
		temp = data.params[i] or ""
		if ptype == 1 then
			temp = tonumber(temp) or 0
			temp = Guild.GetJobName(temp)
		elseif ptype == 2 then
			temp = tonumber(temp) or 0
			temp = _local.UIText[200 + temp] or temp
		elseif ptype == 3 then
			temp = tonumber(temp) or 0
			temp = _local.UIText[300 + temp] or temp
		elseif ptype == 4 then
			temp = tonumber(temp) or 0
			temp = _local.UIText[400 + temp] or temp
		elseif ptype == 5 then
			temp = tonumber(temp) or 0
			if temp < self.openLevel then
				temp = _local.UIText[501]
			else
				temp = string.format(_local.UIText[502], temp)
			end
		elseif ptype == 6 then
			temp = tonumber(temp) or 0
			temp = _local.UIText[601 + temp] or temp
		elseif ptype == 7 then
			temp = tonumber(temp) or 0
			temp = _local.UIText[700 + temp] or temp
		end
		table.insert(values, temp)
	end

	-- 格式化内容
	result.contentStr = string.format(params.content, unpack(values))

	return result
end

--刷新列表
function GuildLogUI:UpdateList()
	if self.ui == nil then return end

	self.ui_wrap_list:set_min_index(0)
    self.ui_wrap_list:set_max_index(#self.formatData - 1)
    self.ui_wrap_list:reset()
end

function GuildLogUI:LoadItem(item, index)
	item.index = index

	local data = self.formatData[index]
	if data then
		item.title:set_text(data.title)
		item.content:set_text(data.content)
	end
end

-------------------------------------本地回调-------------------------------------
function GuildLogUI:on_init_item(obj, b, real_id)
	local index = math.abs(real_id) + 1;

	local item = self.items[b]
    if not item then
		item = {}
		item.title = ngui.find_label(obj, "lab_time")
		item.content = ngui.find_label(obj, "lab_word")
		
		self.items[b] = item
	end

	self:LoadItem(item, index)
end

-------------------------------------网络回调-------------------------------------
--社团日志变更
function GuildLogUI:on_update_log_data()
	self:UpdateLogData()
	self:UpdateList()
end

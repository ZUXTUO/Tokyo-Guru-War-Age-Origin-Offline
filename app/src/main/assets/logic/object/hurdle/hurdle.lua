Hurdle = Class('Hurdle')
--[[
curGroup -- 当前打到第几章了
groupList -- 章节列表
struct hurdle_net
{
	uint hurdleid;				// 关卡编号
	int8 star_num;				// 通关星数
	int8 period_post_times;		// 每日通关次数
	string award_collected_info;// 奖励领取情况
}
]]
EHurdleType = 
{
	eHurdleType_normal = 0,			--普通关卡
	eHurdleType_elite = 1,			--精英关卡
	eHurdleType_max = 2,
}
local maxBoxCount = {[0]=3, [1]=1}
function Hurdle:Init()
	--[[groupList = {[groupid] = {[hurdleid] = hurdle_net,}}]]
	self.groupList = {}			-- 章节列表
	for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
		self.groupList[i] = {};
	end
	self.groupAward = {};		-- 章节奖励
	self.curGroup = {}			-- 当前打到第几章了
	self.group_anim_id = {}		-- 当前动画章节id
	self.realCurGroup = {}		-- 实际上当前能打的最新章节   考虑到等级不够的情况

	self.configGroup = {}		--配置表筛选列表
	self.configNoKeyGroup = {}	--无key筛选列表
	--排序的章节列表
	self.sectionList = {};
	self.secidToIndex = {};
	--未领取的宝箱奖励
	self.notGetGroupBoxAwards = {[0] = {}, [1] = {}};
	self.notGetHurdleBoxAwards = {[0] = {}, [1] = {}};
	--关卡章节星数记录
	self.curTotalStar = {total = 0};
	self.curTotalStar[EHurdleType.eHurdleType_normal] = {total=0,};
	self.curTotalStar[EHurdleType.eHurdleType_elite] = {total=0,};
	--掉落id排序好的物品索引
	self.dropIdList = {};
	--进行一些配置表初始化
	self:InitConfigData();
	return self
end

function Hurdle:InitConfigData()
	self:GetSortSection(EHurdleType.eHurdleType_normal);
	self:GetSortSection(EHurdleType.eHurdleType_elite);
end

--获取服务器上当前章节
function Hurdle:GetServerCurGroup(hurdleType)
	hurdleType = hurdleType or EHurdleType.eHurdleType_normal;
	return self.curGroup[hurdleType];
end


--[[设置当前章]]
function Hurdle:SetCurGroup(groupid, group_anim_id)
	self.curGroup = {}
	for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
		self.curGroup[i] = groupid[i+1];
		self.group_anim_id[i] = group_anim_id[i+1];
	end
end

function Hurdle:GetCurGroup(hurdleType)
	hurdleType = hurdleType or EHurdleType.eHurdleType_normal;
	local curGroupid = self.curGroup[hurdleType];
	--当前id是播动画的id   需要判断下等级
	if curGroupid == self.group_anim_id[hurdleType] then
		if not self:CheckAnimIdCanFight(hurdleType) then
			return self:GetPreGroupId(self.group_anim_id[hurdleType]);
		end	
	end
	return self.curGroup[hurdleType];
end

function Hurdle:CheckAnimIdCanFight(hurdleType)
	if self.group_anim_id[hurdleType] == 0 then
		return true;
	end
	local playerLevel = g_dataCenter.player:GetLevel();
	local levelList = self:GetGroupHurdleConfigList_NoKey(self.group_anim_id[hurdleType]);
	if not levelList == nil then
		if playerLevel < levelList[1].need_level then
			return false;
		end
		local hurdleInfo = levelList[1];
    	if hurdleType == EHurdleType.eHurdleType_elite then
    	    if hurdleInfo.type_param > 0 then
    	        local otherInfo = self:GetHurdleByHurdleid(hurdleInfo.type_param);
            	if not otherInfo then
                	return false;
            	end
        	end
    	end
	end
	return true;
end

function Hurdle:CheckAnimIdRedPoint(hurdleType)
	if self.group_anim_id[hurdleType] == 0 then
		return false;
	end
	local playerLevel = g_dataCenter.player:GetLevel();
	local levelList = self:GetGroupHurdleConfigList_NoKey(self.group_anim_id[hurdleType]);
	if playerLevel < levelList[1].need_level then
		return false;
	end
	return true;
end

function Hurdle:GetPreGroupId(groupid)
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cf then
		return 0;
	end
	local groupList = self:GetSortSection(cf.group_type);
	local index = self:SectionIdToIndex(groupid);
	if index == 1 then
		return 0;
	end
	return groupList[index - 1].id;
end

--[[更新章里面关卡的信息]]
function Hurdle:UpdateGroupHurdleInfo(groupid, info, group_award_collected_info)
	local hurdleType = nil;
	local starCount = 0;
	for k, v in ipairs(info) do
		local cfg = ConfigHelper.GetHurdleConfig(v.hurdleid);
		if cfg then
			starCount = starCount + v.star_num;
			hurdleType = cfg.hurdle_type;
			self.groupList[hurdleType][groupid]	= self.groupList[hurdleType][groupid] or {};
			self.groupList[hurdleType][groupid][v.hurdleid] = v;
			if cfg.box_dropid > 0 and v.box_state ~= 1 then
				self.notGetHurdleBoxAwards[hurdleType][groupid] = self.notGetHurdleBoxAwards[hurdleType][groupid] or {};
				self.notGetHurdleBoxAwards[hurdleType][groupid][v.hurdleid] = 1;
			end
			--第一次发过来的时候将完成条件用位与的方式取出来 然后存进去  以后就再也不需要解析了
			local flags = v.finish_flags;
			v.finish_flags = {};
			for i = 1, 3 do
				v.finish_flags[i] = PublicFunc.GetBitValue(flags, i);
			end
		end
	end
	self.groupAward[groupid] = group_award_collected_info;
	local groupCfg = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	local hurdleType = groupCfg.group_type;
	self.curTotalStar[hurdleType][groupid] = starCount;
	self.curTotalStar[hurdleType].total = self.curTotalStar[hurdleType].total + starCount;
	self.curTotalStar.total = self.curTotalStar.total + starCount;
	for i = 1, maxBoxCount[groupCfg.group_type] do
		if groupCfg["award"..i.."_star"] ~= 0 and
			self:IsCanGetGroupAwards(groupid, i) and (not self:IsAlreadyGetGroupAwards(groupid, i)) then
			self.notGetGroupBoxAwards[groupCfg.group_type][groupid] = self.notGetGroupBoxAwards[groupCfg.group_type][groupid] or {}
			self.notGetGroupBoxAwards[groupCfg.group_type][groupid][i] = 1;
		end
	end
end
--更新关卡里面的星数
function Hurdle:UpdateHurdleStar(hurdleid, star, flags)
	local cf = ConfigHelper.GetHurdleConfig(hurdleid);
	if cf then
		local groupid = cf.groupid;
		local hurdleType = cf.hurdle_type;
		if not self.curTotalStar[hurdleType][groupid] then
			self.curTotalStar[hurdleType][groupid] = 0;
		end
		local info = self:GetHurdleByHurdleid(hurdleid);
		if info then
			if info.star_num < star then
				local addStar = star - info.star_num;
				self.curTotalStar[hurdleType][groupid] = self.curTotalStar[hurdleType][groupid] + addStar;
				self.curTotalStar[hurdleType].total = self.curTotalStar[hurdleType].total + addStar;
				self.curTotalStar.total = self.curTotalStar.total + addStar;
				self:SetPlayStarAnim(hurdleid, info.star_num);
				info.star_num = star;
				info.finish_flags = flags;
				GNoticeGuideTip(Gt_Enum_Wait_Notice.Hurdle_StarChange);
			end
			info.period_post_times = info.period_post_times + 1;
			
		else
			info = self:PassHurdle(hurdleid, star, flags);
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Hurdle_StarChange);
			GNoticeGuideTip(Gt_Enum_Wait_Notice.Hurdle_Pass);
			local addStar = star;
			self.curTotalStar[hurdleType][groupid] = self.curTotalStar[hurdleType][groupid] + addStar;
			self.curTotalStar[hurdleType].total = self.curTotalStar[hurdleType].total + addStar;
			self.curTotalStar.total = self.curTotalStar.total + addStar;
			self:SetPlayStarAnim(hurdleid, 0);
		end
		local bGroup = false;
		local groupid = cf.groupid;
		for i = 1, maxBoxCount[cf.hurdle_type] do
			if self:IsCanGetGroupAwards(groupid, i) and (not self:IsAlreadyGetGroupAwards(groupid, i)) then
				self.notGetGroupBoxAwards[cf.hurdle_type][groupid] = self.notGetGroupBoxAwards[cf.hurdle_type][groupid] or {}
				self.notGetGroupBoxAwards[cf.hurdle_type][groupid][i] = 1;
				bGroup = true;
			end
		end
		--app.log("........."..table.tostring(self.groupList[cf.groupid][hurdleid].period_post_times));
	end
end

--[[更新章奖励领取信息]]
function Hurdle:UpdateGroupAwardInfo(id, index)
	self.groupAward[id] = self.groupAward[id] or {}
	table.insert(self.groupAward[id], index);
	local groupCfg = ConfigManager.Get(EConfigIndex.t_hurdle_group, id);
	self.notGetGroupBoxAwards[groupCfg.group_type][id][index] = nil;
	if table.get_num(self.notGetGroupBoxAwards[groupCfg.group_type][id]) == 0 then
		self.notGetGroupBoxAwards[groupCfg.group_type][id] = nil;
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Hurdle_GroupAwards);
end
--判断章节奖励是否可以领取
function Hurdle:IsCanGetGroupAwards(groupid, index)
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	local totalStar = self:GetGroupStarNum(groupid);
	if cf["award"..index.."_star"] > 0 and totalStar >= cf["award"..index.."_star"] then
		return true, totalStar, cf["award"..index.."_star"];
	end
	return false, totalStar, cf["award"..index.."_star"];
end
--[[判断章节奖励是否已经领取]]
function Hurdle:IsAlreadyGetGroupAwards(groupid, index)
	if self.groupAward[groupid] then
		for k, v in pairs(self.groupAward[groupid]) do
			if v == index then
				return true;
			end
		end
	end
	return false;
end
--获取章节奖励的掉落id
function Hurdle:GetGroupDropId(groupid, index)
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cf then
		return 0;
	end
	return cf["award"..index.."_dropid"];
end

--根据关卡id获取关卡相关数据
function Hurdle:GetHurdleByHurdleid(hurdleid) 
	local cf = ConfigHelper.GetHurdleConfig(hurdleid);
	if cf and self.groupList[cf.hurdle_type] and self.groupList[cf.hurdle_type][cf.groupid] then
		return self.groupList[cf.hurdle_type][cf.groupid][hurdleid];
	end
end
--新闯关一个关卡
function Hurdle:PassHurdle(hurdleid, star, flags)
	local cf = ConfigHelper.GetHurdleConfig(hurdleid);
	if cf then
		if not self.groupList[cf.hurdle_type][cf.groupid] then
			self.groupList[cf.hurdle_type][cf.groupid] = {};	
		end
		if not self.groupList[cf.hurdle_type][cf.groupid][hurdleid] then
			self.groupList[cf.hurdle_type][cf.groupid][hurdleid] = {}
		end

		local info = self.groupList[cf.hurdle_type][cf.groupid][hurdleid];
		info.hurdleid = hurdleid;
		info.star_num = star;
		info.finish_flags = flags;
		info.period_post_times = 1;
		info.box_state = 0;
		info.reset_times = 0;
		if cf.box_dropid > 0 then
			self.notGetHurdleBoxAwards[cf.hurdle_type][cf.groupid] = self.notGetHurdleBoxAwards[cf.hurdle_type][cf.groupid] or {};
			self.notGetHurdleBoxAwards[cf.hurdle_type][cf.groupid][hurdleid] = 1;
		end
		return info;
	end
end

--[[获取某章当前星数]]
function Hurdle:GetGroupStarNum(groupid)
	local groupCfg = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not groupCfg then
		return;
	end
	return self.curTotalStar[groupCfg.group_type][groupid] or 0;
end
--获取总星数
--hurdleType 参见EHurdleType     传-1为取所有类型关卡的总星数
function Hurdle:GetTotalStarNum(hurdleType)
	if self.curTotalStar[hurdleType] then
		return self.curTotalStar[hurdleType].total;
	elseif hurdleType == -1 then
		return self.curTotalStar.total;
	else
		app.log("参数传递错误 "..tostring(hurdleType));
	end
end

--[[返回一张没有key的表]]
function Hurdle:GetGroupHurdleConfigList_NoKey(groupid)
	return self.configGroup[groupid];
	--[[
	if not PublicStruct.ShuZhiCeShi and self.configGroup[groupid] then
		return self.configGroup[groupid];
	else
		self.configGroup[groupid] = {};
		local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
		--得到第一个关卡id
		local temp = 0;
		if cf.group_type == EHurdleType.eHurdleType_normal then
			temp = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_normalHurdleFirstId).data;
		elseif cf.group_type == EHurdleType.eHurdleType_elite then
			temp = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_eliteHurdleFirstId).data;
		end
		--循环找到此章节
		while true do
			local cf = ConfigHelper.GetHurdleConfig(temp);
			if not cf then
				break;
			end
			if cf.groupid == groupid then
				break;
			end
			temp = cf.next_hurdleid;
		end
		--得到此章节的关卡
		while true do
			local cf = ConfigHelper.GetHurdleConfig(temp);
			if not cf then
				break;
			end
			if cf.groupid ~= groupid then
				break;
			end
			table.insert(self.configGroup[groupid], cf);
			temp = cf.next_hurdleid;
		end
		return self.configGroup[groupid];
	end
	]]
end

--返回完成关卡的道具种类
function Hurdle:GetDropByShowNumber(dropID)
	if self.dropIdList[dropID] then
		return self.dropIdList[dropID];
	else
		local drop = ConfigManager.Get(EConfigIndex.t_drop_something,dropID);
		if drop == nil then
			return nil;
		end
		self.dropIdList[dropID] = {}
		local result = self.dropIdList[dropID];
		local showNumberToIndex = {}
		for i = 1, #drop do
			local v = drop[i];
			if v.goods_show_number == 0 then
				-- app.log("有掉落配置没有配置显示编号： 掉落编号="..dropID.."  索引="..tostring(i));
			else
				if not showNumberToIndex[v.goods_show_number] then
					table.insert(result, {});
					showNumberToIndex[v.goods_show_number] = #result;
				end
				table.insert(result[showNumberToIndex[v.goods_show_number]], v);
			end
		end
		local function SortRairy(a, b)
			local itema = ConfigManager.Get(EConfigIndex.t_item, a[1].goods_id);
			local itemb = ConfigManager.Get(EConfigIndex.t_item, b[1].goods_id);
			if itema.sort_number > itemb.sort_number then
				return true;
			end
			if itema.sort_number < itemb.sort_number then
				return false;
			end
			if itema.id < itemb.id then
				return true;
			end
			return false;
		end
		table.sort(result, SortRairy);
		return result;
	end
end

--[[获取某个章里面的最新可挑战关卡id]]
function Hurdle:GetCurFightLevelID(groupid)
	groupid = groupid or self:GetCurGroup(EHurdleType.eHurdleType_normal);
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group,groupid)
	if not cf then
		return 0;
	end
	local curGroupIndex = self:SectionIdToIndex(self.curGroup[cf.group_type]);
	local getGroupIndex = self:SectionIdToIndex(groupid);
	if getGroupIndex > curGroupIndex then
		return 0;
	end

	local nType = cf.group_type;
	local levelList = self:GetGroupHurdleConfigList_NoKey(groupid);
	--app.log("1......."..table.tostring(levelList));
	for i = 1, #levelList do
		local levelInfo = levelList[i];
		if self.groupList[nType][groupid] == nil or self.groupList[nType][groupid][levelInfo.hurdleid] == nil then
			return levelInfo.hurdleid;
		elseif i == #levelList then
			return levelInfo.hurdleid;
		end
	end
	return 0;
end
--获取关卡里面最新挑战过的关卡
function Hurdle:GetMaxFightLevel(nType)
	nType = nType or EHurdleType.eHurdleType_normal;
	local groupid = self:GetCurGroup(nType);
	if groupid == nil then
		app.log("参数传递错误  "..tostring(nType));
		return;	
	end

	local bFind = false;
	local groupList = self:GetSortSection(nType)

	for i = #groupList, 1, -1 do
		if bFind or groupList[i].id == groupid then
			bFind = true;
			local levelList = self:GetGroupHurdleConfigList_NoKey(groupList[i].id);
			for j = #levelList, 1, -1 do
				if self.groupList[nType][groupList[i].id] and self.groupList[nType][groupList[i].id][levelList[j].hurdleid] then
					return levelList[j].hurdleid;
				end
			end
		end
	end
	return 0;
end

function Hurdle:GetSortSection(nType)

	nType = nType or EHurdleType.eHurdleType_normal;
	if self.sectionList[nType] == nil or PublicStruct.ShuZhiCeShi then
		return self:SortSectionList(nType);
	else
		return self.sectionList[nType];
	end
end

--章节list排序
function Hurdle:SortSectionList(nType)

	self.sectionList[nType] = {};
	local firstHurdleId = 0;
	local firstGroupId = 0;
	if nType == EHurdleType.eHurdleType_normal then
		firstHurdleId = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_normalHurdleFirstId).data;
	elseif nType == EHurdleType.eHurdleType_elite then
		firstHurdleId = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteID_eliteHurdleFirstId).data;
	end
	firstGroupId = ConfigHelper.GetHurdleConfig(firstHurdleId).groupid;
	while true do
		local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, firstGroupId);
		if not cf then
			break;
		end
		table.insert(self.sectionList[nType], cf);
		firstGroupId = cf.next_id;
		self.secidToIndex[cf.id] = #self.sectionList[nType];
	end
    --app.log("list="..table.tostring(self.sectionList));
    return self.sectionList[nType];
end
--重置挑战次数
function Hurdle:ResetAllHurdleCount()
	for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
		for k, v in pairs(self.groupList[i]) do
			for m, n in pairs(v) do
				n.period_post_times = 0;
				n.reset_times = 0;
			end
		end
	end
end
--领取关卡宝箱
function Hurdle:GetHurdleBox(hurdleid)
	local info = self:GetHurdleByHurdleid(hurdleid);
	if info then
		info.box_state = 1;
	end
	local cfg = ConfigHelper.GetHurdleConfig(hurdleid);
	local hurdleType = cfg.hurdle_type;
	self.notGetHurdleBoxAwards[hurdleType][cfg.groupid][hurdleid] = nil;
	if  table.get_num(self.notGetHurdleBoxAwards[hurdleType][cfg.groupid]) == 0 then
		self.notGetHurdleBoxAwards[hurdleType][cfg.groupid] = nil;
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Hurdle_BoxAwards);
end
--判断某个章节是否通过
function Hurdle:IsPassGroup(groupid)
	for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
		if self.groupList[i][groupid] then
			local count = table.get_num(self.groupList[i][groupid]);
			local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
			if count >= cf.hurdle_count then
				return true;
			end
		end
	end
	return false;
end
--判断关卡是否通过
function Hurdle:IsPassHurdle(hurdleid)
	local info = self:GetHurdleByHurdleid(hurdleid);
	return info ~= nil;
end
--判断章节是否开启
function Hurdle:IsOpenGroup(groupid)

	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cf then
		return false;
	end
	local curGroup = self:GetCurGroup(cf.group_type);
	--是正在打的章节  肯定开了啊
	if curGroup == groupid then
		return true;
	end
	local sort = self:GetSortSection(cf.group_type);
	local isOpen = false;
	--从第一个章节开始遍历   先找到最大章节表示此章节未开启  先找到此章节表示此章节已通过
	for k, v in ipairs(sort) do
		if curGroup == v.id then
			isOpen = false;
			break;
		elseif groupid == v.id then
			isOpen = true;
			break;
		end
	end
	return isOpen;
end

function Hurdle:GetGroupList()
	return self.groupList[EHurdleType.eHurdleType_normal];
end

function Hurdle:ResetHurdleCount(hurdleid)
	local info = self:GetHurdleByHurdleid(hurdleid)
	if info then
		info.period_post_times = 0;
		info.reset_times = info.reset_times + 1;
	end
end

--判断宝箱是否开启过
function Hurdle:IsOpenHurdleBox(hurdleid)
	local info = self:GetHurdleByHurdleid(hurdleid)
	if info and info.box_state == 1 then
		return true;
	end
	return false;
end
--判断关卡宝箱是否有奖励可以领取
function Hurdle:IsGetHurdleBox(hurdleid)
	local cf = ConfigHelper.GetHurdleConfig(hurdleid)
	if not cf then
		return false;
	end
	if self.notGetHurdleBoxAwards[cf.hurdle_type][cf.groupid] and 
		self.notGetHurdleBoxAwards[cf.hurdle_type][cf.groupid][hurdleid] then
		return true;
	else
		return false;
	end
end
--判断章节宝箱是否有奖励可以领取
function Hurdle:IsGetGroupAwards(groupid, index)
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cf then
		return false;
	end
	if self.notGetGroupBoxAwards[cf.group_type][groupid] and 
		self.notGetGroupBoxAwards[cf.group_type][groupid][index] then
		return true;
	else
		return false;
	end
end
--判断某个关卡是否可以挑战
function Hurdle:IsCanFight(hurdleid)
	local cf = ConfigHelper.GetHurdleConfig(hurdleid);
	if not cf then
		return false;
	end
	if g_dataCenter.player:GetLevel() < cf.need_level then
		return false;
	end

	local maxHurdleId = self:GetCurFightLevelID(cf.groupid);
	if maxHurdleId == hurdleid then
		return true;
	end
	if maxHurdleId == 0 then
		return false;
	end
	local sort = self:GetGroupHurdleConfigList_NoKey(cf.groupid);
	local isOpen = false;
	--从此章节的第一个关卡开始遍历   先找到最大关卡表示此关卡不能打  先找到此关卡表示此关卡已通过
	for k, v in ipairs(sort) do
		if maxHurdleId == v.hurdleid then
			isOpen = false;
			break;
		elseif hurdleid == v.hurdleid then
			isOpen = true;
			break;
		end
	end
	return isOpen;
end
--关卡重置一套接口
function Hurdle.HurdleReset(hurdleid, callback, obj, param)
	Hurdle.callback = callback;
	Hurdle.obj = obj;
	Hurdle.param = param;
	local info = g_dataCenter.hurdle:GetHurdleByHurdleid(hurdleid);
	if info then
		-- local maxResetCount = ConfigManager.Get(EConfigIndex.t_vip_data, g_dataCenter.player.vip).hurdle_reset_count;
		local maxResetCount = 0;
		local vip_data = g_dataCenter.player:GetVipData();
		if vip_data then
			maxResetCount = vip_data.hurdle_reset_count;
		end
		local costCrystal = 0;
		local cf = ConfigManager.Get(EConfigIndex.t_hurdle_reset, info.reset_times+1);
		if cf then
			costCrystal = cf.cost_crystal;
		end
		if info.reset_times >= maxResetCount then
			HintUI.SetAndShowNew(EHintUiType.one,
				gs_misc['str_69'],
				string.format(gs_misc['str_71'], g_dataCenter.player.vip),nil,
				{str = gs_misc['str_72'],
				func = function() 
					--打开vip特权界面
					uiManager:PushUi(EUI.VipPackingUI);
					--需要关闭扫荡界面
					CommonRaids.Destroy();
				end});
		else
			HintUI.SetAndShowNew(EHintUiType.one,
				gs_misc['str_69'],
				string.format(gs_misc['str_70'], costCrystal, info.reset_times),nil,
				{str = gs_misc['str_44'],
				func = function() 
					PublicFunc.msg_regist(msg_hurdle.gc_reset_hurdle, Hurdle.ResetResult);
					msg_hurdle.cg_reset_hurdle(hurdleid);
				end});
		end
	end
end

function Hurdle.ResetResult(hurdleid)
	PublicFunc.msg_unregist(msg_hurdle.gc_reset_hurdle, Hurdle.ResetResult);
	if Hurdle.callback then
		if Hurdle.obj then
			Hurdle.callback(Hurdle.obj, Hurdle.param, hurdleid);
		else
			Hurdle.callback(Hurdle.param, hurdleid);
		end
	end
end
--增加

--获取关卡的当前挑战次数和最大次数
function Hurdle:GetHurdleTimes(hurdleid)
	local cf = ConfigHelper.GetHurdleConfig(hurdleid);
	if not cf then
		return 0, 0;
	end
	local curTimes = 0;
	local info = self:GetHurdleByHurdleid(hurdleid);
	if info then
		curTimes = info.period_post_times;
	end
	return curTimes, cf.max_count;
end

--添加关卡挑战次数
function Hurdle:AddHurdleTimes(hurdleid, times)
	local info = self:GetHurdleByHurdleid(hurdleid);
	if info then
		info.period_post_times = info.period_post_times + times;
	end
end
--判断某个页签是否有宝箱奖励未领
function Hurdle:IsHurdleTypeNotGetBoxAwards(hurdleType)
	if hurdleType == nil then
		for i = EHurdleType.eHurdleType_normal, EHurdleType.eHurdleType_max-1 do
			if table.get_num(self.notGetGroupBoxAwards[i]) > 0 or table.get_num(self.notGetHurdleBoxAwards[i]) > 0 then
				return Gt_Enum_Wait_Notice.Success;
			end
		end
	else
		if table.get_num(self.notGetGroupBoxAwards[hurdleType]) > 0 or table.get_num(self.notGetHurdleBoxAwards[hurdleType]) > 0 then
			return Gt_Enum_Wait_Notice.Success;
		end
	end
	local result = {};
	result[Gt_Enum_Wait_Notice.Hurdle_StarChange] = 1;
	result[Gt_Enum_Wait_Notice.Hurdle_Pass] = 1;
	return result;
end
--判断章节是否有奖励未领取
function Hurdle:IsGroupNotGetBox(groupid)
	local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if table.get_num(self.notGetGroupBoxAwards[cfg.group_type][groupid]) > 0 or table.get_num(self.notGetHurdleBoxAwards[cfg.group_type][groupid]) > 0 then
		return true;
	end
	return false;
end
--判断此章节前面或者后面的所有章节是否有红点
function Hurdle:IsAllGroupNotGetBox(groupid, forward)
	local cfg = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cfg then
		return false;
	end
	local list = self:GetSortSection(cfg.group_type);
	local index = self:SectionIdToIndex(groupid);
	if forward then
		for i = 1, index-1 do
			if self:IsGroupNotGetBox(list[i].id) then
				return true;
			end
		end
	else
		for i = index+1, #list do
			if self:IsGroupNotGetBox(list[i].id) then
				return true;
			end
		end
	end
	return false;
end

function Hurdle:SectionIdToIndex(groupid)
	return self.secidToIndex[groupid];
end

--精英关卡是否开启
function Hurdle:IsEliteOpen()
	local cf = ConfigManager.Get(EConfigIndex.t_discrete, MsgEnum.ediscrete_id.eDiscreteId_hurdleToggle);
    --没有配置关卡就检测等级
    if cf.data == 0 then
        if PublicFunc.FuncIsOpen(MsgEnum.eactivity_time.eActivityTime_EliteLevel) then
            return true;
        else
            return false;
        end
    elseif self:IsPassHurdle(cf.data) then
        return true;
    else
        return false;
    end
end
--设置需要播星星动画
function Hurdle:SetPlayStarAnim(hurdleid, index)
	self.playStarHurdleid = hurdleid;
	self.playStarIndex = index;
end
function Hurdle:GetPlayStarAnim()
	-- return 60001000, 1;
	return self.playStarHurdleid, self.playStarIndex;
end

function Hurdle:SetGroupAnimId(hurdleType, group_anim_id)
	self.group_anim_id[hurdleType] = group_anim_id;
end

function Hurdle:GetGroupAnimId(hurdleType)
	return self.group_anim_id[hurdleType];
end

function Hurdle:IsHaveNewGroupAnim(groupid)
	local cf = ConfigManager.Get(EConfigIndex.t_hurdle_group, groupid);
	if not cf then
		return false;
	end
    if groupid == self:GetGroupAnimId(cf.group_type) then
		return true;
    end
	return false;
end
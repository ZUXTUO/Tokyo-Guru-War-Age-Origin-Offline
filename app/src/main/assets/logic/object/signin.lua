Signin = Class("Signin");

function Signin:Init(  )
	self:InitData();
end

function Signin:InitData(  )
	self.m_red_point = false;
	self.m_is_open = false;
	self.m_red_point_states = {};

	self.m_red_point_back = false;
	self.m_is_open_back = false;
	self.m_red_point_states_back = {};
	
	self.m_start_time = 0;
	self.m_end_time = 0;
	self.m_vecData = {};

	self.m_is_total = false;
	self.m_is_get_total = 0;
	self.m_c_score = 0;
	self.m_timeLeft = 0;

	self.m_state = 0;
	self.m_type = 0;
	self.m_day = 0;
	self.m_states = {};
	self.m_is_checking = false;
end

function Signin:SetMonthChecking( state, t_type, day, states )
	self.m_state = state;
	self.m_type = t_type;
	self.m_day = day;
	self.m_states = states;
	self.m_is_checking = true;
end

function Signin:GetIsMonth(  )
	return self.m_state, self.m_type, self.m_day, self.m_states, self.m_is_checking;
end

function Signin:SetTotal( is_get_total, c_score, timeLeft )
	self.m_is_get_total = is_get_total;
	self.m_c_score = c_score;
	self.m_timeLeft = timeLeft;
	self.m_is_total = true;
end

function Signin:GetTotal( )
	return self.m_is_get_total, self.m_c_score, self.m_timeLeft, self.m_is_total;
end

function Signin:SetTime( start_time, end_time )
	self.m_start_time = start_time;
	self.m_end_time = end_time;
end

function Signin:GetTime( )
	return self.m_start_time, self.m_end_time;
end

function Signin:SetVecDataByType1Type2( type1, type2, vecData )
	if not self.m_vecData[type1] then
		self.m_vecData[type1] = {};
	end
	self.m_vecData[type1][type2] = vecData;
end

function Signin:GetVecDataByType1Type2( type1, type2 )
	if self.m_vecData[type1] then
		do return self.m_vecData[type1][type2]; end
	end
	do return nil; end
end

function Signin:SetRedPoint( state )
	self.m_red_point = state;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn30);
end

function Signin:GetRedPoint( )
	-- return self.m_red_point;
	local isState = false;
	for k,v in pairs(self.m_red_point_states) do
		if v.state == 1 then
			isState = true;
			break;
		end
	end
	self.m_red_point = isState;
	return self.m_red_point;
end

function Signin:SetIsOpen( state )
	self.m_is_open = state;
	PublicFunc.msg_dispatch(msg_sign_in.gc_set_point);
end

function Signin:GetIsOpen( )
	return self.m_is_open;
end

function Signin:SetRedPointStatesByDataList( type1, type2, taskList )
	local vecRedPointStates = {};
	for k,v in pairs(taskList) do
		table.insert(vecRedPointStates, {id = v.task_id, type_1 = type1, type_2 = type2, state = v.task_state});
	end
	self:SetRedPointStates(vecRedPointStates);
end

function Signin:SetRedPointStates( vecRedPointStates )
	for k,v in pairs(vecRedPointStates) do
		self.m_red_point_states[v.id] = v;
	end
	
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn7);
end

function Signin:GetRedPointStateByType1( type1 )
	local isState = false;
	for k,v in pairs(self.m_red_point_states) do
		if type1 == v.type_1 and v.state == 1 then
			isState = true;
			break;
		end
	end
	return isState;
end

function Signin:GetRedPointStateByType1AndType2( type1, type2 )
	local isState = false;
	for k,v in pairs(self.m_red_point_states) do
		if type1 == v.type_1 and type2 == v.type_2 and v.state == 1 then
			isState = true;
			break;
		end
	end
	return isState;
end

------------------------- 节日七天乐 _back-----------------------------
function Signin:SetRedPoint_back( state )
	self.m_red_point_back = state;
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn30);
end

function Signin:GetRedPoint_back( )
	-- return self.m_red_point;
	local isState = false;
	for k,v in pairs(self.m_red_point_states_back) do
		if v.state == 1 then
			isState = true;
			break;
		end
	end
	self.m_red_point_back = isState;
	return self.m_red_point_back;
end

function Signin:SetIsOpen_back( state )
	self.m_is_open_back = state;
	PublicFunc.msg_dispatch(msg_sign_in.gc_set_point);
	PublicFunc.msg_dispatch(msg_sign_in.gc_set_point_back);
end

function Signin:GetIsOpen_back( )
	return g_dataCenter.activityReward:GetActivityIsOpenByActivityid(ENUM.Activity.activityType_sign_in_7_holiday);
end

function Signin:SetRedPointStatesByDataList_back( type1, type2, taskList )
	local vecRedPointStates = {};
	for k,v in pairs(taskList) do
		table.insert(vecRedPointStates, {id = v.task_id, type_1 = type1, type_2 = type2, state = v.task_state});
	end
	self:SetRedPointStates_back(vecRedPointStates);
end

function Signin:SetRedPointStates_back( vecRedPointStates )
	for k,v in pairs(vecRedPointStates) do
		self.m_red_point_states_back[v.id] = v;
	end
	GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced, Gt_Enum.EMain_SignIn7_back);
end

function Signin:GetRedPointStateByType1_back( type1 )
	local isState = false;
	for k,v in pairs(self.m_red_point_states_back) do
		if type1 == v.type_1 and v.state == 1 then
			isState = true;
			break;
		end
	end
	return isState;
end

function Signin:GetRedPointStateByType1AndType2_back( type1, type2 )
	local isState = false;
	for k,v in pairs(self.m_red_point_states_back) do
		if type1 == v.type_1 and type2 == v.type_2 and v.state == 1 then
			isState = true;
			break;
		end
	end
	return isState;
end
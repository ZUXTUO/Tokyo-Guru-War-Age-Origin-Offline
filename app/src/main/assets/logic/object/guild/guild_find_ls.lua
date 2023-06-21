-- 社团寻找神戴利斯

GuildFindLs = Class('GuildFindLs')

-- 参考<SGuildMemberData>
function GuildFindLs:Init()
    
    self.joinnumber = 0
    self.OpenDatainfo = {}
    self.AllDatainfot = {}
    self.myReportList = {}
    return self
end

--玩家开箱数据
function GuildFindLs:setOpenData(list)
    self.OpenDatainfo = list
end

--开箱记录
function GuildFindLs:setAllData(list)
   self.AllDatainfot = list
end

function GuildFindLs:addReport(list)
    self.myReportList = list
end

function GuildFindLs:getMyReportList()
    return  self.myReportList
end

function GuildFindLs:getOpenData()
    return  self.OpenDatainfo
end

function GuildFindLs:getAllDataInfo()
    return self.AllDatainfot
end

function GuildFindLs:checkNumber()
    local MaxNumInfo = ConfigManager.Get(EConfigIndex.t_activity_time,60055126).number_restriction
    local MaxNum = MaxNumInfo.d
    if self.joinnumber >= MaxNum then
        return false
    else
        return true
    end
end

function GuildFindLs:setNumber(jointime)

    self.joinnumber = jointime
    local MaxNumInfo = ConfigManager.Get(EConfigIndex.t_activity_time,60055126).number_restriction
    local MaxNum = MaxNumInfo.d
    if self.joinnumber >= MaxNum then
        GNoticeGuideTip(Gt_Enum_Wait_Notice.Forced,Gt_Enum.EMain_Guild_Find_Ls);
    end
end

function GuildFindLs:getNumber()
   return  self.joinnumber
end

function GuildFindLs:clearOpendatainfo()
    self.OpenDatainfo = {}
end

function GuildFindLs:addNumber()
    self.joinnumber = self.joinnumber + 1
end


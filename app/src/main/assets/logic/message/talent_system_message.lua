
local isLocalData = true

msg_talent = msg_talent or {}

--[[天赋升级]]
function msg_talent.cg_talent_upgrade(id)
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_talent.cg_talent_upgrade(Socket.socketServer, id)
end

--[[重置天赋]]
function msg_talent.cg_reset_talent()
    --if not Socket.socketServer then return end
    GLoading.Show(GLoading.EType.msg)
    nmsg_talent.cg_reset_talent(Socket.socketServer)
end

--------------------------------- 服务器 -------------------------------------------
--[[    
    struct TalentInfo
    {
	    int id;			//天赋id
	    int level;		//天赋等级		
    }
]]
--[[已开启的天赋数据]]
function msg_talent.gc_talent_info(infos)
    g_dataCenter.talentSystem:SetTalentInfo(infos)
end

--[[天赋升级返回]]
function msg_talent.gc_talent_upgrade(result, info)
    GLoading.Hide(GLoading.EType.msg)    
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    g_dataCenter.talentSystem:TalentUpgradeSuccess(info)
    PublicFunc.msg_dispatch(msg_talent.gc_talent_upgrade)
end

function msg_talent.gc_reset_talent(result)
    GLoading.Hide(GLoading.EType.msg)    
    if tonumber(result) ~= 0 then
        PublicFunc.GetErrorString(result)
        return
    end
    g_dataCenter.talentSystem:ResetSuccess()
    PublicFunc.msg_dispatch(msg_talent.gc_reset_talent)
end
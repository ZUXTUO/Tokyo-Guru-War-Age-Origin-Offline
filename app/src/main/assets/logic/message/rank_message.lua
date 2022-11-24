msg_rank = msg_rank or { }
-- 客户端到服务器
function msg_rank.cg_rank(rankType, count)
    if Socket.socketServer then
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_rank.cg_rank(robot_s, "..tostring(rankType)..", "..tostring(count)..")")
        end
        nmsg_rank.cg_rank(Socket.socketServer, rankType, count);
    end
end
-- 服务器到客户端
function msg_rank.gc_rank(ret, rank_type, my_rank, ranklist)
app.log('======== msg_rank.gc_rank '..table.tostring({ret, rank_type, my_rank, ranklist}))
    if not rank_type or not my_rank or not ranklist then
        return;
    end
    local t = { my_rank = RankPlayer:new(my_rank), list = {} }
    for i, v in ipairs(ranklist) do
        table.insert(t.list, RankPlayer:new(v))
    end
    g_dataCenter.rankInfo:SetData(tonumber(rank_type), t)
    -- if uiManager:GetCurScene().UpdateUi then
    --     uiManager:GetCurScene():UpdateUi();
    -- end
    PublicFunc.msg_dispatch(msg_rank.gc_rank, rank_type, my_rank, ranklist);
end

function msg_rank.cg_my_rank(rankType)
	if Socket.socketServer then
        if AppConfig.script_recording then
            PublicFunc.RecordingScript("nmsg_rank.cg_my_rank(robot_s, "..tostring(rankType)..")")
        end
        nmsg_rank.cg_my_rank(Socket.socketServer, rankType);
    end
end

function msg_rank.gc_my_rank(rank_type,ranking)
	if not rank_type or not ranking then
        return;
    end
	PublicFunc.msg_dispatch(msg_rank.gc_my_rank, rank_type, ranking);
end

return msg_rank;


ResourceRecord = {
    allAsset = {},
    sendRecord = {},
}

local this = ResourceRecord
local _NeedSendCnt = 40
local _NeedSendTime = 60
local _Status = {
    normal = 1,
    send = 2,
}

function ResourceRecord.Clear()
    this.allAsset = {}
    this.sendRecord = {}
end

function ResourceRecord.Add(path)
    if (not AppConfig.is_upload_resource_record) or (not AppConfig.is_upload_resource_record()) then
        return
    end
    if path == nil or path == '' or this.allAsset[path] ~= nil then
        return
    end
    this.allAsset[path] = path
    this.sendRecord[path] = this.CreateRecord(path)

    this.CheckNeedUpload()
    if not TimerManager.IsRunning(this.Upload) then
        TimerManager.Add(this.Upload, _NeedSendTime * 1000, -1)
    end
end

function ResourceRecord.GetScenceId()
    local env = FightScene.GetStartUpEnv()
    if env and env.levelData then
        return env.levelData.scene_id
    end
    return ''
end

function ResourceRecord.CreateRecord(path)
    local temp = {}
    temp.client_version = AppConfig.get_package_version()

    local p = g_dataCenter.player
    temp.playerid = p:GetGID()
    temp.level = p:GetLevel()
    temp.vip = p:GetVip()
    temp.cur_scene = this.GetScenceId()
    temp.resource = path
    temp.status = _Status.normal
    return temp
end

function ResourceRecord.CheckNeedUpload()
    local cnt = 0
    for k, v in pairs(this.sendRecord) do
        if v.status == _Status.normal then
            cnt = cnt + 1
        end
    end
    if cnt >= _NeedSendCnt then
        this.Upload()
    end
end

function ResourceRecord.Upload()
    local list = {}
    for k, v in pairs(this.sendRecord) do
        if v.status == _Status.normal then
            v.status = _Status.send
            table.insert(list, v)
        end
    end
    if #list > 0 then
        player.cg_resource_record(list)
    end
end

function ResourceRecord.ClearUploadRecord()
    for k, v in pairs(this.sendRecord) do
        if v.status == _Status.send then
            this.sendRecord[k] = nil
        end
    end
end
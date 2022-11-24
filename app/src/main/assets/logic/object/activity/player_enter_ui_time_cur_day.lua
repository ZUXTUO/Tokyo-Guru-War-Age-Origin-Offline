
PlayerEnterUITimesCurDay = 
{
    playerEnterTimesSaveFile = "playerEnterTimesSaveFile.data",
    playerRunGameTimesSaveFile = "playerRunGameTimesSaveFile.data",
}

local HasEnterUIData = nil
local HasEnterGameDate = nil

function PlayerEnterUITimesCurDay.LoadEnterUITimesData()
    if HasEnterUIData == nil then
        HasEnterUIData = {}
        local file_handler = file.open(PlayerEnterUITimesCurDay.playerEnterTimesSaveFile,4);
        if file_handler then
            local conent = file_handler:read_all_text()
            if content ~= '' then
                local k = loadstring(conent)
                if k then
                    local saveTable = k()
                    if type(saveTable) == 'table' then
                        HasEnterUIData = saveTable
                    end
                end
            end
            file_handler:close();
        end
    end
end

function PlayerEnterUITimesCurDay.LoadBeginGameTimesData()
    if HasEnterGameDate == nil then
        HasEnterGameDate = {}
        local file_handler = file.open(PlayerEnterUITimesCurDay.playerRunGameTimesSaveFile,4);
        if file_handler then
            local conent = file_handler:read_all_text()
            if content ~= '' then
                local k = loadstring(conent)
                if k then
                    local saveTable = k()
                    if type(saveTable) == 'table' then
                        HasEnterGameDate = saveTable
                    end
                end
            end
            file_handler:close();
        end
    end
end

PlayerEnterUITimesCurDay.LoadEnterUITimesData()
PlayerEnterUITimesCurDay.LoadBeginGameTimesData()

function PlayerEnterUITimesCurDay.HasEnterUI(uiName)
    if HasEnterUIData[uiName] ~= nil then
        local t = os.date("*t",system.time())
	--app.log("ttttttt...,..==="..table.tostring(t))
	--app.log("HasEnterUIData########"..tostring(HasEnterUIData[uiName]))
        if t.yday == HasEnterUIData[uiName] then
            if t.hour >= 3 then
                return true
            else
                return false
            end
        end
    end
    return false
end



function PlayerEnterUITimesCurDay.EnterUI(uiName)
    local t = os.date("*t",system.time())
    local oldDay = HasEnterUIData[uiName]
    HasEnterUIData[uiName] = t.yday

    if oldDay ~= t.yday then
        local file_handler = file.open(PlayerEnterUITimesCurDay.playerEnterTimesSaveFile,4);
        if file_handler then
            file_handler:write_string(table.tostringEx(HasEnterUIData));
	        file_handler:close();
        end
    end
end

function PlayerEnterUITimesCurDay.HasEnterUITo12(uiName)
    if HasEnterGameDate[uiName] ~= nil then
        local t = os.date("*t",os.time())
        if t.yday == HasEnterGameDate[uiName] then
            return true        
        end
    end
    return false
end

function PlayerEnterUITimesCurDay.RunGame(uiName)

    local t = os.date("*t",system.time())
    local oldDay = HasEnterGameDate[uiName]
    app.log("t.yday..............."..tostring(t.yday))
    HasEnterGameDate[uiName] = t.yday

    if oldDay ~= t.yday then
        local file_handler = file.open(PlayerEnterUITimesCurDay.playerRunGameTimesSaveFile,4);
        if file_handler then
            file_handler:write_string(table.tostringEx(HasEnterGameDate));
            file_handler:close();
        end
    end
end
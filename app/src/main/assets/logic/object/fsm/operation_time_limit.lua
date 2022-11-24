

OperationTimeLimit = 
{
    defaultTimeInterval = 0.3,
}

function AI_GetCurrentTimeFloat()
    return app.get_time()
end

OperationTimeLimit.offSetList = {};

function OperationTimeLimit.IsFrequently(obj, operatorName, timeInterval)
    local hfsmData = obj:GetHFSMData()

    if  hfsmData.ignoreOperatorLimit then
        return false
    end

    if hfsmData[operatorName] == nil then
		OperationTimeLimit.offSetList[operatorName] = OperationTimeLimit.offSetList[operatorName] or 0;
        hfsmData[operatorName] = {}
		hfsmData[operatorName].checkOffset = OperationTimeLimit.offSetList[operatorName];
		hfsmData[operatorName].checkCount = 0;
		OperationTimeLimit.offSetList[operatorName] = OperationTimeLimit.offSetList[operatorName] + 1;
		if OperationTimeLimit.offSetList[operatorName] >= 10 then 
			OperationTimeLimit.offSetList[operatorName] = 0;
		end
    end
	hfsmData[operatorName].checkCount = hfsmData[operatorName].checkCount + 1;
	if hfsmData[operatorName].checkCount > hfsmData[operatorName].checkOffset then 
		hfsmData[operatorName].checkOffset = hfsmData[operatorName].checkOffset + 10;
		return false
	else
		return true; 
	end 
    --timeInterval = timeInterval or OperationTimeLimit.defaultTimeInterval
    --local now = AI_GetCurrentTimeFloat()
    --app.log("IsFrequently " .. tostring(now - hfsmData[operatorName]))
    --if now - hfsmData[operatorName].checkTime >= timeInterval then
    --    hfsmData[operatorName] = now
    --    return false
    --end
    --return true
end
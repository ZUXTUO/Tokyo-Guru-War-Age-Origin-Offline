
RecommendMgr = Class("RecommendMgr")

function RecommendMgr.Inst()
    if RecommendMgr._inst == nil then
        RecommendMgr._inst = RecommendMgr:new()
    end
    return RecommendMgr._inst
end

function RecommendMgr:Init()
   self.allChecker = {}
   self.recommendAction = {} 
   self.started = false

   table.insert(self.allChecker, EquipRecommendChecker:new())
end

function RecommendMgr:Start()

    if self.started == true then
        return
    end

    self.started = true

    self:Clear()

    for ck,cv in ipairs(self.allChecker) do
        cv:Start()
    end

    self.updateBindFunc = Utility.bind_callback(self, RecommendMgr.Update)
    if self.updateTimer == nil then 
        self.updateTimer = timer.create(self.updateBindFunc, 300 ,-1);
    end

    self:CheckRecommand(0)
end

function RecommendMgr:Stop()
    if self.started == false then
        return
    end

    self.started = false
    self:Clear()

    for ck,cv in ipairs(self.allChecker) do
        cv:Stop(dt)
    end

   if self.updateTimer ~= nil then 
        timer.stop(self.updateTimer)
        self.updateTimer = nil
   end
   if self.updateBindFunc then
        Utility.unbind_callback(self, self.updateBindFunc)
        self.updateBindFunc = nil
   end
end

function RecommendMgr:Clear()
   self.recommendAction = {} 
   self.lastEndTime = 0

    if self.currentAction then
        self.currentAction:Stop()
        self.currentAction = nil
    end

    self.lastUpdateCheckerTime = 0
end

function RecommendMgr:AddRecommendAction(action)
    table.insert(self.recommendAction, action)
end

function RecommendMgr:Update(dt)

    if self.started ~= true then
        return
    end

    --self:CheckRecommand(dt)
    self:UpdateRecommandUI(dt)
end

function RecommendMgr:CheckRecommand(dt)

    if system.time() - self.lastUpdateCheckerTime < 1 then
        return
    end
    self.lastUpdateCheckerTime = system.time()
    for ck,cv in ipairs(self.allChecker) do
        cv:Update(dt)
    end
end

function RecommendMgr:UpdateRecommandUI(dt)
    if self.currentAction and self.currentAction:IsEnd() then
        self.currentAction:Stop()
        self.currentAction = nil

        self.lastEndTime = app.get_time()
    end

    if #self.recommendAction > 0 and self.currentAction == nil and app.get_time() - self.lastEndTime > 2 then
        local nxtAction = self.recommendAction[1]
        table.remove(self.recommendAction, 1)

        local card = g_dataCenter.package:find_card(ENUM.EPackageType.Equipment,nxtAction:GetEquipDataid())
        if card then
            self.currentAction = nxtAction
            self.currentAction:Start()
        end

    end

    if self.currentAction then
        self.currentAction:Update(dt)
    end
end

GmCheat = Class("GmCheat")


function GmCheat:Init()
    self.playLimit = true
end

--[[开启或关闭玩法限制]]
function GmCheat:changePlayLimit()
    if self.playLimit == true then
        self.playLimit = false
    else 
        self.playLimit = true
    end
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Athletic_3V3);
end

--[[获得玩法限制状态]]
function GmCheat:getPlayLimit()
    return self.playLimit
end

--[[无玩法限制]]
function GmCheat:noPlayLimit()
    return self.playLimit == false
end
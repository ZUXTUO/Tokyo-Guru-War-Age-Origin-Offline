
GmCheat = Class("GmCheat")


function GmCheat:Init()
    self.playLimit = true
end

--[[������ر��淨����]]
function GmCheat:changePlayLimit()
    if self.playLimit == true then
        self.playLimit = false
    else 
        self.playLimit = true
    end
    GNoticeGuideTip(Gt_Enum_Wait_Notice.Time, Gt_Enum.EMain_Athletic_3V3);
end

--[[����淨����״̬]]
function GmCheat:getPlayLimit()
    return self.playLimit
end

--[[���淨����]]
function GmCheat:noPlayLimit()
    return self.playLimit == false
end
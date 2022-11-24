FightEndTransitionUI = Class("FightEndTransitionUI", UiBaseClass);

local instace = nil;

function FightEndTransitionUI.Show()
	if instace == nil then
		instace = FightEndTransitionUI:new();
	end
	-- instace:Play();
end

function FightEndTransitionUI.SetEndCallback(func, param)
	if instace then
		instace:SetCallback(func,param);
	end
end

function FightEndTransitionUI.EndCallback()
	instace:DestroyUi();
	instace = nil;
end

function FightEndTransitionUI:Init(data)
    self.pathRes = "assetbundles/prefabs/ui/public/fight_end_transition.assetbundle";
    UiBaseClass.Init(self, data);
end

function FightEndTransitionUI:InitUI(asset_obj)
    UiBaseClass.InitUI(self, asset_obj);
    self.ui:set_name("FightEndTransitionUI");

    self:UpdateUi();
end

function FightEndTransitionUI:UpdateUi()
    if not UiBaseClass.UpdateUi(self) then
        return;
    end
    -- if self.bPlay then
    --     self:Play();
    -- end
end

-- function FightEndTransitionUI:Play()
-- 	if self.ui then
-- 		self.bPlay = false;
-- 	else
-- 		self.bPlay = true;
-- 	end
-- end

function FightEndTransitionUI:SetCallback(func, param)
	self.funcCallback = func;
	self.funcCallbackParam = param;
end

function FightEndTransitionUI:DestroyUi()
    UiBaseClass.DestroyUi(self);
    Utility.CallFunc(self.funcCallback, self.funcCallbackParam);
end
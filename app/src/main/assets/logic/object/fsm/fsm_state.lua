--region NewFile_1.lua
--Author : kevin
--Date   : 2015/7/15
--此文件由[BabeLua]插件自动生成

FSMState = Class("FSMState")

function FSMState:FSMState()
    self.subFSM = nil
    self.stateTemplate = nil
end

function FSMState:Enter()
	self:OnEnter()
end 

function FSMState:Update()
	self:OnUpdate()
end

function FSMState:Exit() 
	self:OnExit()
end

--endregion

--一般闯关
RPGFightManager = Class("RPGFightManager", FightManager)

function RPGFightManager.InitInstance()
	FightManager.InitInstance(RPGFightManager)
	return RPGFightManager;
end
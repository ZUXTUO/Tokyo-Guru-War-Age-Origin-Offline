-----------------------高光效果------------------

ShineObj = Class("ShineObj")
----------外部接口---------
--启动高光
--shineValue 高光阀值
--shineReduce 衰减量
function ShineObj:Start(shineValue, shineReduce)
	self.curShine = shineValue;
	self.shineReduce = shineReduce or 1;
	self.isStart = true;
end

function ShineObj:SetSelect(flag)
	if flag then
		-- self.obj:set_material_float_with_name("_RimInten", 5);
		self.obj:set_material_color_with_name("_OutLineColor", 1, 0, 0, 1);
		-- self.obj:set_material_float_with_name("_RimThres", 0.5);
		self.obj:set_material_float_with_name("_EnableOutLine", 1);
	else
		-- self.obj:set_material_float_with_name("_RimInten", self.oldRimInten);
		self.obj:set_material_color_with_name("_OutLineColor", self.oldRimColor.r, self.oldRimColor.g, self.oldRimColor.b, self.oldRimColor.a);
		-- self.obj:set_material_float_with_name("_RimThres", self.oldRimThres);
		self.obj:set_material_float_with_name("_EnableOutLine", 0);
	end
end


--------内部接口----------
function ShineObj:Init(data)
	self.isStart = false;
	self.obj = data.obj;
	--self.timerBind = Utility.bind_callback(self, ShineObj.TimeUpdate);
	--self.timer = timer.create(self.timerBind, 10, -1);
	self.curShine = 1;
	self.entityName = data.name;
	--初始化值
	self.oldViewInten = self.obj:get_material_float_with_name("_ViewInten");
	self.oldRimInten = self.obj:get_material_float_with_name("_RimInten");
	self.oldRimThres = self.obj:get_material_float_with_name("_RimThres");
	self.oldRimColor = {};
	self.oldRimColor.r, self.oldRimColor.g, self.oldRimColor.b, self.oldRimColor.a = self.obj:get_material_color_with_name("_OutLineColor");
end

function ShineObj:Destroy()
	 --Utility.unbind_callback(self, self.timerBind)
	 --timer.stop(self.timer);
	 --self.timer = nil;
end

function ShineObj:TimeUpdate()
	if self.isStart then
		self.curShine = self.curShine - self.shineReduce;
		if self.curShine < self.oldViewInten then
			self.curShine = self.oldViewInten;
			self.isStart = false;
			local entity = ObjectManager.GetObjectByName(self.entityName);
			if entity then
				if entity:IsBasis() or entity:IsBoss() or  FightScene.GetCurRimLightName() == self.entityName then
					entity:ShowRimLight(entity.oldShowRimLight);
				end
			end
		end
		self.obj:set_material_float_with_name("_ViewInten", self.curShine);
	end
end



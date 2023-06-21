-- require 'Class'
-- require 'utility'

ScrollView = Class('ScrollView');

function ScrollView:initData(data)
	self.bindfunc = {};
	self.cellWidth = data.cellWidth;			 --元素宽
	self.cellHeight = data.cellHeight;           --元素高
	self.col = data.col;					     --列数
	self.grid = data.grid;						 --父节点
	self.childsInfo = Utility.clone(data.childsInfo);           --所有子节点信息
	self.activeChildsInfo = Utility.clone(data.childsInfo);    --激活的子节点的信息
end

function ScrollView:Init(data)
    self:initData(data)
    self:registFunc();
    self:initUI();
end

function ScrollView:registFunc()
    self.bindfunc["on_click"] = Utility.bind_callback(self, ScrollView.on_click)
end

function ScrollView:unregistFunc()
    for k,v in pairs(self.bindfunc) do
        if v ~= nil then
            Utility.unbind_callback(self, v)
        end
    end
end

function ScrollView:initUI()
	--初始化所有子节点，v.item为子控件(一般为btn)，设置坐标
	for k,v in ipairs(self.activeChildsInfo) do
		v.item:set_parent(self.grid);
		v.item:set_local_scale(1,1,1);
		local row,col = self:GetRowAndCol(k,self.col);
		v.item:set_local_position((col-1)*self.cellWidth,-(row-1)*self.cellHeight,0);
	end
end

--排序,传入排序规则（字符串）
function ScrollView:Sort(sortType,isBigToSmall)
	if(isBigToSmall == false)then
		table.sort(self.activeChildsInfo,function(a,b) return a[sortType] < b[sortType] end);
		table.sort(self.childsInfo,function(a,b) return a[sortType] < b[sortType] end);
	else
		table.sort(self.activeChildsInfo,function(a,b) return a[sortType] > b[sortType] end);
		table.sort(self.childsInfo,function(a,b) return a[sortType] > b[sortType] end);
	end
	--table.sort(self.childsInfo,function(a,b) return a[sortType] > b[sortType] end);
	for k,v in ipairs(self.activeChildsInfo) do
		local row,col = self:GetRowAndCol(k,self.col);
		v.item:set_local_position((col-1)*self.cellWidth,-(row-1)*self.cellHeight,0);
	end
end

--筛选,filtrateInfo为一个表：type为child属性字符串，value为child属性值
function ScrollView:Filtrate(filtrateInfo)
	--先将所有子节点设置为激活状态
	for k,v in ipairs(self.childsInfo) do
		v.item:set_active(true);
	end
	self.activeChildsInfo = {};
	--找出符合筛选条件的子节点，打上标记，并且设置为不激活
	local mark = {}
	for m=1,#filtrateInfo do
		for k,v in ipairs(self.childsInfo) do
			if(v[filtrateInfo[m].type] == filtrateInfo[m].value)then
				v.item:set_active(false);
				mark[k] = false;
			end
		end
	end
	
	--将未打标记的子节点选出，存进一个表中
	local i = 1;
	for k,v in ipairs(self.childsInfo) do
		if(mark[k] == false)then
			app.log_warning(k.."is false");
		else
			self.activeChildsInfo[i] = v;
			i = i + 1;
		end
	end
	
	--将这个表中的子节点重排位置
	for k,v in ipairs(self.activeChildsInfo) do
		local row,col = self:GetRowAndCol(k,self.col);
		v.item:set_local_position((col-1)*self.cellWidth,-(row-1)*self.cellHeight,0);
	end
end

function ScrollView:AddChild()
	

end

function ScrollView:setCellWidthHeight(data)
	self.cellWidth = data.cellWidth;			 --元素宽
	self.cellHeight = data.cellHeight;           --元素高
end

function ScrollView:GetRowAndCol(index,col)
	local row = (index-1)/col - (index-1)/col%1 + 1;
	local col = (index-1)%col + 1;
	return row,col;
end

return ScrollView











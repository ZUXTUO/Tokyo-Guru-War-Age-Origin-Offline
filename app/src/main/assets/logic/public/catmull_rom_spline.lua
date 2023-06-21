--获取两个2D点距离
function g_distance(p0,p1)
    return math.sqrt(math.pow((p0.x - p1.x),2) + math.pow((p0.y - p1.y),2));
end
--获取两个2D点的中间点
function g_interpolate(p0,p1,rate)
    local newPoint = {};
    newPoint.x = p0.x + rate*(p1.x - p0.x);
    newPoint.y = p0.y + rate*(p1.y - p0.y);
    return newPoint;
end

function g_distance3D(p0,p1)
	return math.sqrt(math.pow((p0.x - p1.x),2) + math.pow((p0.y - p1.y),2) + math.pow(((p0.z or 0) - (p1.z or 0)),2));
end 

function g_interpolate3D(p0,p1,rate)
	local newPoint = {};
    newPoint.x = p0.x + rate*(p1.x - p0.x);
    newPoint.y = p0.y + rate*(p1.y - p0.y);
	if p0.z ~= nil then 
		newPoint.z = p0.z + rate*(p1.z - p0.z);
	end
    return newPoint;
end 

CatmullRomSpline = {};

function g_interpolateShift(p0,p1,s1,s2,maxDis)
	local newPoint = {};
    newPoint.x = p0.x + s1*(p1.x - p0.x);
    newPoint.y = p0.y + s1*(p1.y - p0.y);
	if p0.y > p1.y and p0.x > p1.x or p0.y > p1.y and p0.x < p1.x then 
		s2 = -s2;
	end 
	local dis = g_distance(p0,p1)*s2;
	if maxDis ~= nil then 
		if math.abs(dis) > maxDis then 
			dis = maxDis * dis/math.abs(dis);
		end
	end 
	local A = p1.y - p0.y;
	local B = p0.x - p1.x;
	local C = p1.x*p0.y - p0.x*p1.y;
	local A0 = -B;
	local B0 = A;
	local C0 = -A0*newPoint.x - B0*newPoint.y;
	local k;
	local x,y;
	if math.abs(-A0) >= 0 and B0 == 0 then 
		x = 0;
		y = dis;
	else
		k = -A0/B0;
		x = math.sqrt((dis * dis)/(k*k + 1));
		if dis < 0 then 
			x = -x;
		end 
		y = x * k;
	end 
	newPoint.x = newPoint.x + x;
	newPoint.y = newPoint.y + y;
    return newPoint;
end 
--[[计算叉积]]
function g_mult(a,b,c)  
    return (a.x-c.x)*(b.y-c.y)-(b.x-c.x)*(a.y-c.y);  
end
  
--计算两条线段是否相交，aa, bb为一条线段两端点 cc, dd为另一条线段的两端点 相交返回true, 不相交返回false  
function g_intersect(aa,bb,cc,dd)  
    if math.max(aa.x, bb.x)< math.min(cc.x, dd.x) then
        do return false end 
    elseif math.max(aa.y, bb.y)< math.min(cc.y, dd.y) then
        do return false end 
    elseif math.max(cc.x, dd.x)<math.min(aa.x, bb.x) then
        do return false end 
    elseif math.max(cc.y, dd.y)<math.min(aa.y, bb.y) then
        do return false end 
    elseif g_mult(cc, bb, aa)*g_mult(bb, dd, aa)<0 then
        do return false end 
    elseif g_mult(aa, dd, cc)*g_mult(dd, bb, cc)<0 then
        do return false end 
    end 
    return true;  
end
--[[计算2D三点夹角]]
function g_includedAngle(b,a,c) 
	local AB={b.x-a.x, b.y-a.y} 
	local AC={c.x-a.x, c.y-a.y}
	local cosA = (AB[1]*AC[1]+AB[2]*AC[2])/(g_distance(a,b)*g_distance(a,c))
	return math.acos(cosA);
end

function g_checkClockwise(p1,p2,p3)
	local check = (p2.x-p1.x)*(p3.y-p2.y)-(p2.y-p1.y)*(p3.x-p2.x);
	if check > 0 then 
		return false;
	elseif check < 0 then 
		return true;
	else 
		return true;
	end
end 

--[[创建曲线点集合，point(n)需要通过的点的集合，space(m)生成的点在曲线上的距离，cha(s)拟合曲线的精度,运算量：O(n)*O(s)+O(m+s)]]
function CatmullRomSpline.createPath(point,space,cha,dx,dy,rcheck)
	cha = cha or 20;
	dx = dx or 0;
	dy = dy or 0;
	local path = {};
	local temp = {};
	if #point < 2 then 
		return;
	end
	local len = #point;
	if rcheck == true then 
		local tmp = {};
		table.insert(tmp,point[1]);
		for i = 1,#point - 2 do 
			local a = g_includedAngle(point[i],point[i+1],point[i+2]);
			local isClockwise = g_checkClockwise(point[i],point[i+1],point[i+2]);
			if a <= math.pi/2 + math.pi/6 and a >= 0 then 
				local ca = math.max(math.cos(a),0.3);
				local rt1,rt2,rt3,rt4;
				if isClockwise then 
					rt1 = 1 - 0.300;
					rt2 = -0.300 * ca;
					rt3 = 0.300;
					rt4 = -0.300 * ca;
				else 
					rt1 = 1 - 0.300;
					rt2 = 0.300 * ca;
					rt3 = 0.300;
					rt4 = 0.300 * ca;
				end
				table.insert(tmp,g_interpolateShift(point[i],point[i+1],rt1,rt2,40));
				table.insert(tmp,point[i+1]);
				table.insert(tmp,g_interpolateShift(point[i+1],point[i+2],rt3,rt4,40));
			else 
				table.insert(tmp,point[i+1]);
			end
		end 
		table.insert(tmp,point[#point]);
		point = tmp;
	end 
	len = #point;
	table.insert(point,g_interpolate(point[len-1],point[len],1.5));
	table.insert(point,1,g_interpolate(point[2],point[1],1.5));
	for index = 2,#point - 2 do 
		local p0 = point[index - 1];
		local p1 = point[index];
		local p2 = point[index + 1];
		local p3 = point[index + 2];
		local t;
		local tt;
		local ttt;
		local pi;
		for i = 1,cha do 
			t = i/cha;
			tt = t * t;
			ttt = tt * t;
			pi = {};
			pi.x = (0.5 * (2 * p1.x + (p2.x - p0.x) * t + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * tt + (3 * p1.x - p0.x - 3 * p2.x + p3.x) * ttt));  
			pi.y = (0.5 * (2 * p1.y + (p2.y - p0.y) * t + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * tt + (3 * p1.y - p0.y - 3 * p2.y + p3.y) * ttt));  
			table.insert(temp,pi);
		end
	end
	local disList = {};
	local len = 0;
	local dis = 0;
	local lastLen = 0;
	local moveLen = 0;
	local allNum = #temp;
	local pt;
	for i = 1,#temp-1 do 
		dis = g_distance(temp[i],temp[i+1]);
		lastLen = len;
		len = len + dis;
		if len > lastLen then 
			while(moveLen < len) do 
				pt = g_interpolate(temp[i],temp[i+1],(moveLen - lastLen)/(len - lastLen));
				pt.x = pt.x + dx;
				pt.y = pt.y + dy;
				table.insert(path,pt);
				moveLen = moveLen + space;
			end
		end 
	end
	pt = g_interpolate(temp[allNum-1],temp[allNum],(moveLen - lastLen)/(len - lastLen));
	pt.x = pt.x + dx;
	pt.y = pt.y + dy;
	table.insert(path,pt);
	return path;
end


--[[
样条之埃尔米特（Hermite）
埃尔米特（Charles Hermite，1822—1901） 法国数学家。巴黎综合工科学校毕业。曾任法兰西学院、巴黎高等师范学校、巴黎大学教授。法兰西科学院院士。在函数论、高等代数、微分方程等方面都有重要发现。1858年利用椭圆函数首先得出五次方程的解。1873年证明了自然对数的底e的超越性。在现代数学各分支中以他姓氏命名的概念（表示某种对称性）很多，如“埃尔米特二次型”、“埃尔米特算子”等。
这种算法是CatmullRom演变而成。
--]]
Hermite = {};
--[[
创建曲线点集合，
point(n)需要通过的点的集合，
space(m)生成的点在曲线上的距离，
cha(s)拟合曲线的精度，
dx,dy计算出的点的初始偏移量，
m_alpha曲线胖瘦控制量，0标准，大于0胖，小于0瘦，
运算量：O(n)*O(s)+O(m+s)
]]
function Hermite.createPath(point,space,cha,dx,dy,m_alpha)
	cha = cha or 20;
	dx = dx or 0;
	dy = dy or 0;
	m_alpha = m_alpha or 0;
	local path = {};
	local temp = {};
	if #point < 2 then 
		return;
	end
	local len = #point;
	table.insert(point,g_interpolate3D(point[len-1],point[len],1.5));
	table.insert(point,1,g_interpolate3D(point[2],point[1],1.5));
	for index = 2,#point - 2 do 
		local p0 = point[index - 1];
		local p1 = point[index];
		local p2 = point[index + 1];
		local p3 = point[index + 2];
		local u;
		local u_2;
		local u_3;
		local alpha = 1-m_alpha;
		local pi;
		local m_wight1;
		local m_wight2;
		local m_wight3;
		local m_wight1;
		for i = 1,cha do 
			u = i/cha;
			u_2 = u * u;
			u_3 = u_2 * u;
			pi = {};
			m_wight1 = -(u_3 - (2 * u_2) + u) * alpha/2;
			m_wight2 = (2 * u_3) - (3 * u_2) + 1 - (u_3 - u_2) * alpha/2;
			m_wight3 = (-2 * u_3) + (3 * u_2) + (u_3 - (2 * u_2) + u) * alpha/2;
			m_wight4 = (u_3 - u_2) * alpha/2;
			pi.x = m_wight1 * p0.x + m_wight2 * p1.x + m_wight3 * p2.x + m_wight4 * p3.x;
			pi.y = m_wight1 * p0.y + m_wight2 * p1.y + m_wight3 * p2.y + m_wight4 * p3.y;
			if p0.z ~= nil then 
				pi.z = m_wight1 * p0.z + m_wight2 * p1.z + m_wight3 * p2.z + m_wight4 * p3.z;
			end
			table.insert(temp,pi);
		end
	end
	local disList = {};
	local len = 0;
	local dis = 0;
	local lastLen = 0;
	local moveLen = 0;
	local allNum = #temp;
	local pt;
	for i = 1,#temp-1 do 
		dis = g_distance3D(temp[i],temp[i+1]);
		lastLen = len;
		len = len + dis;
		if len > lastLen then 
			while(moveLen < len) do 
				pt = g_interpolate3D(temp[i],temp[i+1],(moveLen - lastLen)/(len - lastLen));
				pt.x = pt.x + dx;
				pt.y = pt.y + dy;
				table.insert(path,pt);
				moveLen = moveLen + space;
			end
		end 
	end
	pt = g_interpolate(temp[allNum-1],temp[allNum],(moveLen - lastLen)/(len - lastLen));
	pt.x = pt.x + dx;
	pt.y = pt.y + dy;
	table.insert(path,pt);
	return path;
end

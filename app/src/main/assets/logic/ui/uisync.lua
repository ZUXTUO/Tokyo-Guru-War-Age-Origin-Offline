--module( 'UISync',package.seeall )

local m_update = { }
UISync = {}
--通知系统要刷新一个UI
function UISync.Sync( ui )
	--将这个要更新的UI记录下来
	if ui then
		m_update[ui] = true
	end
end

function UISync.Update( )
	--遍历要更新的UI,依次更新
	local a = 0
	for k,v in pairs(m_update) do
		k:Update()
		a = a+1
	end	
	if a>0 then 
		m_update = {}
	end
end

Root.AddUpdate(

	--[[UI刷新]]
	UISync.Update);

return UISync
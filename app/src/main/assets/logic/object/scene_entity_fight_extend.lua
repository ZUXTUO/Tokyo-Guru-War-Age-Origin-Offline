-- function SceneEntity:SetOwnerPlayer(player_id)
-- 	self.ownerPlayer = player_id
-- end


function SceneEntity:SetBornPoint(bx, by, bz)
	self.bornPoint = {x=bx, y=by, z=bz}
end

function SceneEntity:GetBornPoint()
	return self.bornPoint
end
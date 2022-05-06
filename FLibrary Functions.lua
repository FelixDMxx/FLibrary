local functions = {}

functions.teleportPartToPart = function(tppart,part,offset)
    tppart.CFrame = part.CFrame * offset
end

functions.getNearestPartFromPartsTable = function(part,table)
	local nearest = nil
	for i,v in pairs(table) do
		if nearest == nil or (part.Position - v.Position).Magnitude < (part.Position - nearest.Position).Magnitude then
			nearest = v
		end
	end
	
	return nearest
end

return functions
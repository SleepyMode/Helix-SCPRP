
local CHAR = ix.meta.character

function CHAR:HasClearance(clearance)
	return self:GetClearance() >= clearance
end
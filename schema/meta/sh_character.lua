
local CHAR = ix.meta.character

function CHAR:HasClearance(clearance)
	return self:GetClearance() >= clearance
end

if (SERVER) then
	function CHAR:ChatNotify(message)
		Schema:ChatNotify(self:GetPlayer(), message)
	end
end

local PLAYER = FindMetaTable("Player")

function PLAYER:HasClearance(clearance)
	local character = self:GetCharacter()

	if (character) then
		return character:GetClearance() >= clearance
	end

	return false
end

if (SERVER) then
	function PLAYER:ChatNotify(message)
		Schema:ChatNotify(self, message)
	end
end
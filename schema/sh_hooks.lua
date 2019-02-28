
local Schema = Schema

function Schema:OnCharacterCreated(client, character)
	local class = character:GetClass() and ix.class.list[character:GetClass()]

	if (class and class.clearance) then
		character:SetClearance(class.clearance)
	end
end

function Schema:CanPlayerUseSpeakers(client)
	if (client:Team() == FACTION_ADMIN or client:Team() == FACTION_COUNCIL) then
		return true
	end
end
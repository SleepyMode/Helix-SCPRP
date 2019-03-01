
local Schema = Schema

function Schema:GetSalaryAmount(client, faction)
	local pay = faction.pay
	local character = client:GetCharacter()
	local clearance = character:GetClearance()

	if (clearance > 1) then
		return pay * clearance * 2.5
	end
end

function Schema:OnCharacterCreated(client, character)
	if (character:GetFaction() == FACTION_MTF) then
		character:SetAttrib("end", 100)
		character:SetAttrib("stm", 100)
		character:SetAttrib("str", 100)
	end
end
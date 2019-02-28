
local Schema = Schema

function Schema:GetSalaryAmount(client, faction)
	local pay = faction.pay
	local character = client:GetCharacter()
	local clearance = character:GetClearance()

	if (clearance > 1) then
		return pay * clearance * 2.5
	end
end
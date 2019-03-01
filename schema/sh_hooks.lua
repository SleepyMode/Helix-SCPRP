
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

function Schema:InitializedPlugins()
	-- Register TFA ammunition
	ix.ammo.Register("tfa_ammo_357")
	ix.ammo.Register("tfa_ammo_ar2")
	ix.ammo.Register("tfa_ammo_buckshot")
	ix.ammo.Register("tfa_ammo_pistol")
	ix.ammo.Register("tfa_ammo_smg")
	ix.ammo.Register("tfa_ammo_sniper_rounds")
	ix.ammo.Register("tfa_ammo_winchester")
end

function Schema:CanPlayerUseBusiness(client, uniqueID)
	return false
end
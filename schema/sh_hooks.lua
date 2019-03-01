
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
	local function registerAmmo(ammoType)
		local plugin = ix.plugin.list["ammosave"]

		if (plugin) then
			local ammoList = plugin.ammoList

			if (ammoList) then
				table.insert(ammoList, ammoType)
			end
		end
	end

	-- Register TFA ammunition
	registerAmmo("tfa_ammo_357")
	registerAmmo("tfa_ammo_ar2")
	registerAmmo("tfa_ammo_buckshot")
	registerAmmo("tfa_ammo_pistol")
	registerAmmo("tfa_ammo_smg")
	registerAmmo("tfa_ammo_sniper_rounds")
	registerAmmo("tfa_ammo_winchester")
end
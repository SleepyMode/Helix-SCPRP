
local PLUGIN = PLUGIN

PLUGIN.name = "Administrative Utilities"
PLUGIN.author = "SleepyMode"
PLUGIN.description = "Adds utility administrative commands to help staff."

ix.command.Add("CharListBodyGroups", {
	description = "Lists all valid bodygroups for a characters' current model.",
	adminOnly = true,
	arguments = ix.type.character,
	OnRun = function(self, client, target)
		local ply = target:GetPlayer()

		client:ChatNotify("Available bodygroups for \"" .. ply:GetModel() .. "\":")

		for i = 0, ply:GetNumBodyGroups() - 1 do
			if (ply:GetBodygroupCount(i) > 1) then
				client:ChatNotify(i.." = "..target:GetBodygroupName(i).."(0-"..(target:GetBodygroupCount(i) - 1)..")")
			end
		end
	end
})

ix.command.Add("GetAllWhitelists", {
	description = "Whitelists you to all currently available whitelists.",
	privilege = "Manage Character Whitelist",
	superAdminOnly = true,
	OnRun = function(self, client)
		for k, v in pairs(ix.faction.indices) do
			client:SetWhitelisted(k, true)
		end

		for k, v in pairs(player.GetAll()) do
			v:Notify(client:Name() .. " has whitelisted himself to all factions.")
		end
	end
})
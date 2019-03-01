
local PLUGIN = PLUGIN

PLUGIN.name = "Group Features"
PLUGIN.author = "SleepyMode"
PLUGIN.description = "Adds different things to different usergroups."

PLUGIN.usergroups = {
	["supporter"] = {
		label = {
			text = "Supporter",
			color = Color(65, 105, 225)
		},
		flags = "pet"
	},
	["admin"] = {
		label = {
			text = "Staff Member",
			color = Color(42, 75, 141)
		},
		flags = "pet"
	},
	["superadmin"] = {
		label = {
			text = "Staff Member",
			color = Color(42, 75, 141)
		},
		flags = "pet"
	},
	["founder"] = {
		label = {
			text = "Staff Member",
			color = Color(42, 75, 141)
		},
		flags = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
	}
}

if (CLIENT) then
	function PLUGIN:PopulatePlayerTooltip(client, tooltip)
		local usergroup = client:GetUserGroup()

		if (self.usergroups[usergroup] and self.usergroups[usergroup].label) then
			local rankLabel = tooltip:AddRow("rankLabel")
			rankLabel:SetText(self.usergroups[usergroup].label.text)
			rankLabel.Paint = function(_, width, height)
				surface.SetDrawColor(ColorAlpha(self.usergroups[usergroup].label.color, 22))
				surface.DrawRect(0, 0, width, height)
			end
			rankLabel:SizeToContents()
		end
	end
end

if (SERVER) then
	function PLUGIN:CharacterHasFlags(client, flags)
		local usergroup = client:GetUserGroup()

		if (self.usergroups[usergroup] and self.usergroups[usergroup].flags) then
			local flagList = self.usergroups[usergroup].flags

			for i = 1, #flags do
				if (flagList:find(flags[i], 1, true)) then
					return true
				end
			end
		end
	end

	function PLUGIN:PostPlayerLoadout(client)
		local usergroup = client:GetUserGroup()

		if (self.usergroups[usergroup] and self.usergroups[usergroup].flags) then
			for i = 1, #self.usergroups[usergroup].flags do
				local flag = self.usergroups[usergroup].flags[i]
				local info = ix.flag.list[flag]

				if (info and info.callback) then
					info.callback(client, true)
				end
			end
		end
	end
end
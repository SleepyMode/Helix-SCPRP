
ix.command.Add("CharSetClearance", {
	description = "Sets the clearance level of a given character.",
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.number
	},
	OnRun = function(self, client, target, clearance)
		target:SetClearance(clearance)

		ix.util.Notify(string.format("%s has set the clearance level of %s to %d.", client:GetName(), target:GetName(), clearance))
	end
})

ix.command.Add("AlarmToggle", {
	description = "Toggles the alarm on the map.",
	adminOnly = true,
	OnRun = function(self, client)
		if (game.GetMap() != "rp_scp_neb_b1") then
			client:Notify("The current map is not supported.")
			return
		end

		if (hook.Run("CanPlayerToggleAlarm", client) == false) then
			client:Notify("You may not toggle the alarm at this time.")
			return
		end

		for k,v in pairs(ents.FindByName("alarm_toggle")) do
			v:Fire("Trigger", "", 0)
		end

		ix.log.Add(client, "alarmToggle")
	end
})
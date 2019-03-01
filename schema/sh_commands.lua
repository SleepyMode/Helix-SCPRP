
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
	privilege = "SCP RP - Toggle Alarm",
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

ix.command.Add("TriggerEvent", {
	description = "Triggers a map event.",
	privilege = "SCP RP - Trigger Map Event",
	argumetns = {
		bit.bor(ix.type.number, ix.type.optional)
	},
	OnRun = function(self, client, eventID)
		if (game.GetMap() != "rp_scp_neb_b1") then
			client:Notify("The current map is not supported.")
			return
		end

		if (!Schema.mapEvents[eventID or 0]) then
			for k, v in pairs(Schema.mapEvents) do
				client:ChatNotify("%s [%d] - %s", k, v.name, v.description)
			end
		end

		Schema:TriggerMapEvent(k)
		ix.log.Add(client, "mapEventTrigger", eventID)
	end
})
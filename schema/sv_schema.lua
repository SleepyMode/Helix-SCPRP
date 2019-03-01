
local Schema = Schema

Schema.mapEvents = {}

function Schema:RegisterMapEvent(eventID, data)
	if (self.mapEvents[eventID]) then
		print("[Helix - Map Events] Attempted to register duplicate event ID. Not adding!")
		return
	end

	if (!data.OnRun) then
		print("[Helix - Map Events] Attempted to event without callback. Not adding!")
		return
	end

	if (!data.name) then
		data.name = "Unknown"
	end

	if (!data.description) then
		data.description = "Unknown"
	end

	self.mapEvents[eventID] = data
end

function Schema:TriggerMapEvent(eventID)
	self.mapEvents[eventID].OnRun()
end

function Schema:ChatNotify(client, message)
	ix.chat.Send(nil, "notice", message, false, client)
end

--[[-------------------------------------------------------------------------
Map Events
---------------------------------------------------------------------------]]
Schema:RegisterMapEvent(1, {
	name = "Toggle Lights",
	description = "Toggles all lights around the map.",
	OnRun = function()
		-- TODO: Toggle Lights
	end
})

--[[-------------------------------------------------------------------------
Log Types
---------------------------------------------------------------------------]]
ix.log.AddType("alarmToggle", function(client, ...)
	local arg = {...}

	return L("%s has toggled the alarm.", client:Name())
end, FLAG_DANGER)

ix.log.AddType("mapEventTrigger", function(client, ...)
	local arg = {...}

	return L("%s has toggled map event %s[%d]", Schema.mapEvents[arg[1]].name, arg[1])
end, FLAG_DANGER)
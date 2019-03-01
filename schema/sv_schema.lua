
local Schema = Schema

ix.log.AddType("alarmToggle", function(client, ...)
	local arg = {...}
	return L("%s has toggled the alarm.", client:Name())
end, FLAG_DANGER)
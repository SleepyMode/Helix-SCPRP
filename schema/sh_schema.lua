
Schema.name = "SCP RP"
Schema.author = "SleepyMode"
Schema.description = "A roleplaying game set in the SCP Universe."

ix.util.Include("sh_config.lua")
ix.util.Include("sh_commands.lua")

ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

ix.util.IncludeDir("meta")

ix.char.RegisterVar("clearance", {
	bNoDisplay 	= true,
	default 	= -1
})

CAMI.RegisterPrivilege({
	Name = "SCP RP - Toggle Alarm",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "SCP RP - Trigger Map Event",
	MinAccess = "admin"
})

function Schema:PlayerHasClearance(client, clearance)
	local character = client:GetCharacter()

	if (character) then
		return character:GetClearance() >= clearance
	end

	return false
end

do
	local CLASS = {}
	CLASS.color = Color(150, 125, 175)
	CLASS.format = "%s broadcasts on the site's speakers: \"<:: %s ::>\""

	function CLASS:CanSay(speaker, text)
		if (!speaker:Alive() or hook.Run("CanPlayerUseSpeakers", speaker) != true) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("speakers", CLASS)
end
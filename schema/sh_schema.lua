
Schema.name = "SCP RP"
Schema.author = "SleepyMode"
Schema.description = "A schema set in the SCP Universe."

ix.util.Include("sh_config.lua")
ix.util.Include("sh_commands.lua")

ix.util.Include("sh_hooks.lua")



ix.char.RegisterVar("clearance", {
	bNoDisplay 	= true,
	default 	= -1
})

function Schema:PlayerHasClearance(client, clearance)
	local character = client:GetCharacter()

	if (character) then
		return character:GetClearance() >= clearance
	end

	return false
end
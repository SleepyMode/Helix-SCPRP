
local Schema = Schema

function Schema:ShouldShowPlayerOnScoreboard(client)
	if (client:Team() == FACTION_MTF) then
		return false
	end
end
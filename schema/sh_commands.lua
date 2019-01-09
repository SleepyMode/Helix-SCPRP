
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

local PLUGIN = PLUGIN

PLUGIN.name = "Additional Commands"
PLUGIN.author = "SleepyMode"
PLUGIN.description = "Adds additional, utility commands."

if (SERVER) then
	ix.util.AddNetworkString("ixOpenPage")

	function PLUGIN:OpenPage(client, url)
		net.Start("ixOpenPage")
			net.WriteString(url)
		net.Send(client)
	end
else
	net.Receive("ixOpenPage", function(len)
		gui.OpenURL(net.ReadString())
	end)
end

ix.command.Add("Content", {
	description = "Opens the content page in the browser.",
	OnRun = function(self, client)
		PLUGIN:OpenPage(client, "https://steamcommunity.com/sharedfiles/filedetails/?id=1657400792")
	end
})

local PLUGIN = PLUGIN

PLUGIN.name = "Administrative Utilities"
PLUGIN.author = "SleepyMode"
PLUGIN.description = "Adds utility administrative commands to help staff."

function PLUGIN:InitializedPlugins()
	properties.Add("chartransfer", {
		MenuLabel = "Faction Transfer",
		Order = 8,
		MenuIcon = "icon16/group.png",
		PrependSpacer = true,

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "PlyTransfer"))) then return false end

			return true
		end,

		Action = function(self, ent)

		end,

		RequestTransfer = function(self, ent, faction)
			self:MsgStart()
				net.WriteEntity(ent)
				net.WriteString(faction)
			self:MsgEnd()
		end,

		MenuOpen = function(self, option, ent, trace)
			local subMenu = option:AddSubMenu()

			for k, v in SortedPairs(ix.faction.indices) do
				local option = subMenu:AddOption(k, function()
					self:RequestTransfer(ent, v.name)
				end)

				option:SetChecked(ent:GetFaction() == k)
			end
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()
			local faction = net.ReadString()

			if (!self:Filter(ent, player)) then return end

			player:ConCommand("ix", "PlyTransfer", ent:Name(), faction)
		end
	})

	properties.Add("respawnstay", {
		MenuLabel = "Respawn in Place",
		MenuIcon = "icon16/arrow_down.png",
		Order = 7,

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "RespawnStay")) then return false end

			return ent:Alive()
		end,

		Action = function(self, ent)
			self:MsgStart()
				net.WriteEntity(ent)
			self:MsgEnd()
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()

			if (!self:Filter(ent, player)) then return end

			player:ConCommand("ix", "RespawnStay")
		end
	})

	properties.Add("setarmor", {
		MenuLabel = "Set Armor",
		MenuIcon = "icon16/shield.png",
		Order = 5,

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "PlySetArmor")) then return false end

			return ent:Alive()
		end,

		Action = function(self, ent)
		end,

		ArmorSet = function(self, ent, amount)
			self:MsgStart()
				net.WriteEntity(ent)
				net.WriteUInt(amount, 8)
			self:MsgEnd()
		end,

		MenuOpen = function(self, option, ent, trace)
			local subMenu = option:AddSubMenu()
			local maxArmor = ent:GetMaxArmor()

			if (maxArmor) then
				for i = maxArmor or 100, 0, (math.floor(-maxArmor or 25) / 4) do
					subMenu:AddOption(tostring(i), function()
						self:ArmorSet(ent, i)
					end)
				end
			else
				for i = 100, 0, -25 do
					subMenu:AddOption(tostring(i), function()
						self:ArmorSet(ent, i)
					end)
				end
			end
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()
			local amount = net.ReadUInt(8)

			if (!self:Filter(ent, player)) then return end

			player:ConCommand("ix", "PlySetArmor", amount)
		end
	})

	properties.Add("sethealth", {
		MenuLabel = "Set Health",
		MenuIcon = "icon16/heart.png",
		Order = 4,

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "PlySetHP")) then return false end

			return ent:Alive()
		end,

		Action = function(self, ent)
		end,

		HealthSet = function(self, ent, amount)
			self:MsgStart()
				net.WriteEntity(ent)
				net.WriteUInt(amount, 8)
			self:MsgEnd()
		end,

		MenuOpen = function(self, option, ent, trace)
			local subMenu = option:AddSubMenu()

			for i = ent:GetMaxHealth(), 0, math.floor(-ent:GetMaxHealth() / 4) do
				subMenu:AddOption(tostring(i), function()
					self:HealthSet(ent, i)
				end)
			end
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()
			local amount = net.ReadUInt(8)

			if (!self:Filter(ent, player)) then return end

			player:ConCommand("ix", "PlySetHP", ent:Name(), amount)
		end
	})

	properties.Add("playerskin", {
		MenuLabel = "#skin",
		Order = 3,
		MenuIcon = "icon16/picture_edit.png",

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "CharSetSkin")) then return false end
			if (!ent:SkinCount()) then return false end

			return ent:SkinCount() > 1
		end,

		MenuOpen = function(self, option, ent, tr)
			local subMenu = option:AddSubMenu()
			local num = ent:SkinCount()

			for i = 0, num - 1 do
				local option = subMenu:AddOption("Skin " .. i, function()
					self:SetSkin(ent, i)
				end)

				if (ent:GetSkin() == i) then
					option:SetChecked(true)
				end
			end
		end,

		Action = function(self, ent)

		end,

		SetSkin = function(self, ent, id)
			self:MsgStart()
			net.WriteEntity(ent)
			net.WriteUInt(id, 8)
			self:MsgEnd()
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()
			local skinid = net.ReadUInt(8)
			local model = ent:GetModel()
			local targetSkins = ent:GetCharacter():GetData("skin") or {}

			if (!self:Filter(ent, player)) then return end

			targetSkins[model] = skinid

			ent:SetSkin(skinid)
			ent:GetCharacter():SetData("skin", targetSkins)
		end
	})

	properties.Add("playerbodygroup", {
		MenuLabel = "#bodygroups",
		MenuIcon = "icon16/link_edit.png",
		Order = 2,

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "CharSetBodygroup")) then return false end

			local options = ent:GetBodyGroups()
			if (!options) then return false end

			for k, v in pairs(options) do
				if (v.num > 1) then return true end
			end

			return false
		end,

		Action = function(self, ent)
		end,

		SetBodyGroup = function(self, ent, body, id)
			self:MsgStart()
				net.WriteEntity(ent)
				net.WriteUInt(body, 8)
				net.WriteUInt(id, 8)
			self:MsgEnd()
		end,

		MenuOpen = function(self, option, ent, trace)
			local options = ent:GetBodyGroups()
			local subMenu = option:AddSubMenu()

			for k, v in pairs(options) do
				if (v.num <= 1) then continue end

				if (v.num == 2) then
					local current = ent:GetBodygroup(v.id)
					local opposite = 1

					if (current == opposite) then
						opposite = 0
					end

					local option = subMenu:AddOption(v.name, function()
						self:SetBodyGroup(ent, v.id, opposite)
					end)

					if (current == 1) then
						option:SetChecked(true)
					end
				else
					local groups = subMenu:AddSubMenu(v.name)

					for i = 1, v.num do
						local modelname = "model #" .. i

						if (v.submodels and v.submodels[i - 1] ~= "") then
							modelname = v.submodels[i - 1]
						end

						local option = groups:AddOption(modelname, function()
							self:SetBodyGroup(ent, v.id, i - 1)
						end)

						if (ent:GetBodygroup(v.id) == i - 1) then
							option:SetChecked(true)
						end
					end
				end
			end
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()
			local group = net.ReadUInt(8)
			local id = net.ReadUInt(8)
			local model = ent:GetModel()
			local targetBodyGroups = ent:GetCharacter():GetData("groups") or {}

			if (!self:Filter(ent, player)) then return end

			targetBodyGroups[model] = targetBodyGroups[model] or {}
			targetBodyGroups[model][tostring(group)] = id

			ent:GetCharacter():SetData("groups", targetBodyGroups)
			ent:SetBodygroup(group, id)
		end
	})

	properties.Add("getinfo", {
		MenuLabel = "Get Information",
		Order = 1,
		MenuIcon = "icon16/information.png",

		Filter = function(self, ent, player)
			if (!IsValid(ent)) then return false end
			if (!ent:IsPlayer()) then return false end
			if (!ix.command.HasAccess(player, "PlyGetInfo")) then return false end

			return true
		end,

		Action = function(self, ent)
			self:MsgStart()
				net.WriteEntity(ent)
			self:MsgEnd()
		end,

		Receive = function(self, length, player)
			local ent = net.ReadEntity()

			if (!self:Filter(ent, player)) then return end
			player:ConCommand("ix", "PlyGetInfo", ent:Name())
		end
	})
end

ix.command.Add("CharListBodyGroups", {
	description = "Lists all valid bodygroups for a characters' current model.",
	adminOnly = true,
	arguments = ix.type.character,
	OnRun = function(self, client, target)
		local ply = target:GetPlayer()

		client:ChatNotify("Available bodygroups for \"" .. ply:GetModel() .. "\":")

		for i = 0, ply:GetNumBodyGroups() - 1 do
			if (ply:GetBodygroupCount(i) > 1) then
				client:ChatNotify(i.." = "..target:GetBodygroupName(i).."(0-"..(target:GetBodygroupCount(i) - 1)..")")
			end
		end
	end
})

ix.command.Add("GetAllWhitelists", {
	description = "Whitelists you to all currently available whitelists.",
	privilege = "Manage Character Whitelist",
	superAdminOnly = true,
	OnRun = function(self, client)
		for k, v in pairs(ix.faction.indices) do
			client:SetWhitelisted(k, true)
		end

		for k, v in pairs(player.GetAll()) do
			v:Notify(client:Name() .. " has whitelisted himself to all factions.")
		end
	end
})

ix.command.Add("PlyGetInfo", {
	description = "Gets the target player's information.",
	adminOnly = true,
	arguments = ix.type.player,
	OnRun = function(self, client, target)
		client:Notify("Character Name: " .. target:Name())
		client:Notify("Steam Name: " .. target:SteamName())
		client:Notify("SteamID: " .. target:SteamID())

		client:Notify("Health: " .. target:Health())
		client:Notify("Armor: " .. target:Armor())
	end
})
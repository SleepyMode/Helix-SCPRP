
ITEM.name = "Armor Base"
ITEM.description = "The base for all armored clothing."

ITEM.width = 1
ITEM.height = 1
ITEM.category = "Armor"
ITEM.model = Model("models/gibs/hgibs.mdl")

ITEM.maxArmor = 80
ITEM.base = "base_outfit"

ITEM:PostHook("Equip", function(item)
	if (item:GetData("armorLeft") == nil) then
		item:SetData("armorLeft", self.maxArmor)
	end

	item.player:SetArmor(item.player:Armor() + item:GetData("armorLeft"))
end)

ITEM:PostHook("EquipUn", function(item)
	item.player:SetArmor(item.player:Armor() - item:GetData("armorLeft", 0))
end)
scoreboard objectives add loadout.settings dummy "\u00A7aLoadoutSettings"

execute in overworld run forceload add -30000000 1602
execute in overworld run setblock -30000000 0 1602 yellow_shulker_box

execute unless score inventory loadout.settings = inventory loadout.settings run scoreboard players set inventory loadout.settings 1
execute unless score hotbar loadout.settings = hotbar loadout.settings run scoreboard players set hotbar loadout.settings 1
execute unless score offhand loadout.settings = offhand loadout.settings run scoreboard players set offhand loadout.settings 1
execute unless score armor loadout.settings = armor loadout.settings run scoreboard players set armor loadout.settings 1
execute unless score selected loadout.settings = selected loadout.settings run scoreboard players set selected loadout.settings 1
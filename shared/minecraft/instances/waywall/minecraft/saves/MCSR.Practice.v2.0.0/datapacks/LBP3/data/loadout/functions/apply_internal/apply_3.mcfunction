# Load and apply all storage items into the players inventory
execute unless score armor loadout.settings matches 0 in overworld run data modify block -30000000 0 1602 Items set from storage loadout.3 armor
execute unless score armor loadout.settings matches 0 in overworld run loot replace entity @s armor.feet 4 mine -30000000 0 1602 air{drop_contents:1b}

execute unless score hotbar loadout.settings matches 0 in overworld run data modify block -30000000 0 1602 Items set from storage loadout.3 hotbar
execute unless score hotbar loadout.settings matches 0 in overworld run loot replace entity @s hotbar.0 9 mine -30000000 0 1602 air{drop_contents:1b}

execute unless score inventory loadout.settings matches 0 in overworld run data modify block -30000000 0 1602 Items set from storage loadout.3 inventory
execute unless score inventory loadout.settings matches 0 in overworld run loot replace entity @s inventory.0 27 mine -30000000 0 1602 air{drop_contents:1b}

execute unless score offhand loadout.settings matches 0 in overworld run data modify block -30000000 0 1602 Items set from storage loadout.3 offhand
execute unless score offhand loadout.settings matches 0 in overworld run loot replace entity @s weapon.offhand 1 mine -30000000 0 1602 air{drop_contents:1b}
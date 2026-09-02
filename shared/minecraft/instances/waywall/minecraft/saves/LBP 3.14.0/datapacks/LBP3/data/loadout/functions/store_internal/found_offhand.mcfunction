# Add 106 to the slot number so it will fit inside a shulker box:
execute store result storage loadout.global whole_inventory[-1].Slot byte 1 run scoreboard players add #slot loadout.settings 106

# Move item into the offhand section:
execute if score selected loadout.settings matches 1 run data modify storage loadout.1 offhand append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 2 run data modify storage loadout.2 offhand append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 3 run data modify storage loadout.3 offhand append from storage loadout.global whole_inventory[-1]
data remove storage loadout.global whole_inventory[-1]

# Get the slot number for the next item:
execute store result score #slot loadout.settings run data get storage loadout.global whole_inventory[-1].Slot
scoreboard players remove #slot_count loadout.settings 1
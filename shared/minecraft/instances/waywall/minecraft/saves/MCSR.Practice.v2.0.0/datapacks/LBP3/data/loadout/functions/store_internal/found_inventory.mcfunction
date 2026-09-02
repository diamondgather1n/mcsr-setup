# Remove 9 from the slot number so it will fit inside a shulker box:
execute store result storage loadout.global whole_inventory[-1].Slot byte 1 run scoreboard players remove #slot loadout.settings 9

# Move item into the inventory section:
execute if score selected loadout.settings matches 1 run data modify storage loadout.1 inventory append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 2 run data modify storage loadout.2 inventory append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 3 run data modify storage loadout.3 inventory append from storage loadout.global whole_inventory[-1]
data remove storage loadout.global whole_inventory[-1]

# Get the slot number for the next item and repeat:
execute store result score #slot loadout.settings run data get storage loadout.global whole_inventory[-1].Slot
scoreboard players remove #slot_count loadout.settings 1
function loadout:store_internal/check_inventory
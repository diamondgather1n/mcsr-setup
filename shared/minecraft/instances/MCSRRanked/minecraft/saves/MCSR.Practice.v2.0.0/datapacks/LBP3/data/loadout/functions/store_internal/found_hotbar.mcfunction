# Move item into the hotbar section:
execute if score selected loadout.settings matches 1 run data modify storage loadout.1 hotbar append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 2 run data modify storage loadout.2 hotbar append from storage loadout.global whole_inventory[-1]
execute if score selected loadout.settings matches 3 run data modify storage loadout.3 hotbar append from storage loadout.global whole_inventory[-1]
data remove storage loadout.global whole_inventory[-1]

# Get the slot number for the next item and repeat:
execute store result score #slot loadout.settings run data get storage loadout.global whole_inventory[-1].Slot
scoreboard players remove #slot_count loadout.settings 1
function loadout:store_internal/check_hotbar
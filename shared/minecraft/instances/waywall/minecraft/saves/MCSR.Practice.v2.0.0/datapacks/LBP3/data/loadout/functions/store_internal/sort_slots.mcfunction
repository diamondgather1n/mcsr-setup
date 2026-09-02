# Get the last slot number in preparation:
execute store result score #slot loadout.settings run data get storage loadout.global whole_inventory[-1].Slot
execute store result score #slot_count loadout.settings run data get storage loadout.global whole_inventory

# Check all the sections in turn, sorting them (slots always appear in order, processing in reverse order for more optimal list iteration):
function loadout:store_internal/check_offhand
function loadout:store_internal/check_armor
function loadout:store_internal/check_inventory
function loadout:store_internal/check_hotbar
# Copy player inventory data to storage and sort into sections so they can be loaded.

# Reset sections:
execute if score selected loadout.settings matches 1 run function loadout:store_internal/reset_1
execute if score selected loadout.settings matches 2 run function loadout:store_internal/reset_2
execute if score selected loadout.settings matches 3 run function loadout:store_internal/reset_3

# Copy whole inventory data:
data modify storage loadout.global whole_inventory set from entity @s Inventory

# Sort the slots into sections:
function loadout:store_internal/sort_slots
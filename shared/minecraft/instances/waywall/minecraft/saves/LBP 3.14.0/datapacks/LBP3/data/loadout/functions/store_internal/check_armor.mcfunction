# Check whether slot number matches an armor slot:
execute if score #slot loadout.settings matches 100..103 run function loadout:store_internal/found_armor
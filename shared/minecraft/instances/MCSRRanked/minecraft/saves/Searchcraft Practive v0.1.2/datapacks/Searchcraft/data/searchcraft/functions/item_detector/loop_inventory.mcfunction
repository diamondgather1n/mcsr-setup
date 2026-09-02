execute store success score detected item_detector run data modify storage searchcraft:item_detector inv[0].id set from storage searchcraft:item_detector items[0].id

execute if score detected item_detector matches 0 store result score count item_detector run data get storage searchcraft:item_detector inv[0].Count
execute if score detected item_detector matches 0 run scoreboard players operation actual_count item_detector += count item_detector

data remove storage searchcraft:item_detector inv[0]
execute if data storage searchcraft:item_detector inv[0] run function searchcraft:item_detector/loop_inventory
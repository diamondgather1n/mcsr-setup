scoreboard players reset actual_count item_detector
execute store result score min_count item_detector run data get storage searchcraft:item_detector items[0].Count

data modify storage searchcraft:item_detector inv set from entity @p Inventory
data remove storage searchcraft:item_detector inv[{tag:{dnd:1b}}]
execute if data storage searchcraft:item_detector inv[0] run function searchcraft:item_detector/loop_inventory

execute if score actual_count item_detector >= min_count item_detector run scoreboard players add goals_reached item_detector 1
data remove storage searchcraft:item_detector items[0]
execute if data storage searchcraft:item_detector items[0] run function searchcraft:item_detector/loop_items
#execute unless score exact_match item_detector matches 1 if score actual_count item_detector > min_count item_detector run function searchcraft:item_detector/init
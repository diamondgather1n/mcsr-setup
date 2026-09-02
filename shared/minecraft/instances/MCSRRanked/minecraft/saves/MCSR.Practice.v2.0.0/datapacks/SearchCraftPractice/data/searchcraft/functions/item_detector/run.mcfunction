scoreboard players reset goals_reached item_detector
data modify storage searchcraft:item_detector items set from storage searchcraft:recipes recipes_enabled[{selected:1b}].goals
execute if data storage searchcraft:item_detector items[0] run function searchcraft:item_detector/loop_items

execute if score goals_reached item_detector = goals item_detector run function searchcraft:item_detector/detected
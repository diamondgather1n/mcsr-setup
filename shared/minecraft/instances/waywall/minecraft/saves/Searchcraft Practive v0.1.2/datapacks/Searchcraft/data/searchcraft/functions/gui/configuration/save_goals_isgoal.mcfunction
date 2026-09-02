data modify storage searchcraft:recipes item_match set from storage searchcraft:recipes recipes[{selected:1b}].goals[-1]
execute store success score success gui run data modify storage searchcraft:recipes item_match.id set from storage searchcraft:recipes goals_temp[0].id
execute if score success gui matches 0 run function searchcraft:gui/configuration/save_goals_stack

scoreboard players operation slot gui -= slot_offset gui
execute store result storage searchcraft:recipes goals_temp[0].Slot byte 1 run scoreboard players get slot gui
data modify storage searchcraft:recipes recipes[{selected:1b}].goals append from storage searchcraft:recipes goals_temp[0]
data remove storage searchcraft:recipes item_match
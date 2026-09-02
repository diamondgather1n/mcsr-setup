execute store result score count1 gui run data get storage searchcraft:recipes item_match.Count
#execute store result score slot gui run data get storage searchcraft:recipes item_match.Slot
execute store result score count2 gui run data get storage searchcraft:recipes goals_temp[0].Count
scoreboard players operation count1 gui += count2 gui
execute store result storage searchcraft:recipes goals_temp[0].Count byte 1 run scoreboard players get count1 gui
#execute store result storage searchcraft:recipes goals_temp[0].Slot byte 1 run scoreboard players get slot gui
data remove storage searchcraft:recipes recipes[{selected:1b}].goals[-1]
scoreboard players add slot_offset gui 1
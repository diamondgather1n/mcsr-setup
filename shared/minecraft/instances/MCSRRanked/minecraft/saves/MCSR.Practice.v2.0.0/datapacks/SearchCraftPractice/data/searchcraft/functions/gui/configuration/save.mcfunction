data modify storage searchcraft:recipes recipes[{selected:1b}].resources set from block -65 63 376 Items

data modify storage searchcraft:recipes goals_temp set from block -65 63 377 Items
data modify storage searchcraft:recipes recipes[{selected:1b}].goals set value []

scoreboard players reset slot_offset gui
execute if data storage searchcraft:recipes goals_temp[0] run function searchcraft:gui/configuration/save_goals

#data modify storage searchcraft:recipes recipes[{selected:1b}].goals set from block -65 63 377 Items
#data remove storage searchcraft:recipes recipes[{selected:1b}].goals[{tag:{bg:1b}}]

#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[0].Slot set value 0b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[1].Slot set value 1b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[2].Slot set value 2b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[3].Slot set value 3b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[4].Slot set value 4b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[5].Slot set value 5b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[6].Slot set value 6b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[7].Slot set value 7b
#data modify storage searchcraft:recipes recipes[{selected:1b}].goals[8].Slot set value 8b

execute unless data storage searchcraft:recipes recipes[{selected:1b}].enabled run data modify storage searchcraft:recipes recipes[{selected:1b}].enabled set value 1b

gamemode adventure @a

execute at @a run playsound minecraft:block.anvil.use master @a ~ ~ ~ 1 2

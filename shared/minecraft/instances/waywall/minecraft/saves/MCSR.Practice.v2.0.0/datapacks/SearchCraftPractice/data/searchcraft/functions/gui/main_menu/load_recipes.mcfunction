# copy goals to goal_temp
data modify storage searchcraft:recipes goals_temp set from storage searchcraft:recipes R[0].goals

# assign slots
scoreboard players operation slot gui = column gui
execute store result storage searchcraft:recipes goals_temp[0].Slot int 1 run scoreboard players get slot gui
scoreboard players operation slot gui += 9 c
execute store result storage searchcraft:recipes goals_temp[1].Slot int 1 run scoreboard players get slot gui

# load enabled / disabled
execute store result score enabled gui run data get storage searchcraft:recipes R[0].enabled
execute if score enabled gui matches 0 run data modify storage searchcraft:recipes chest_bottom append value {id:"minecraft:gray_dye",Count:1b,tag:{display:{Name:'{"text":"Disabled","italic":"false","color":"red"}'}}}
execute if score enabled gui matches 1 run data modify storage searchcraft:recipes chest_bottom append value {id:"minecraft:lime_dye",Count:1b,tag:{display:{Name:'{"text":"Enabled","italic":"false","color":"green"}'}}}

scoreboard players remove column gui 1
execute store result storage searchcraft:recipes chest_bottom[-1].Slot byte 1 run scoreboard players get slot gui
execute store result storage searchcraft:recipes chest_bottom[-1].tag.index byte 1 run scoreboard players get column gui
scoreboard players add column gui 1

scoreboard players operation slot gui += 9 c
execute store result storage searchcraft:recipes goals_temp[2].Slot int 1 run scoreboard players get slot gui

# append goals_temp to chest_top
data modify storage searchcraft:recipes chest_top append from storage searchcraft:recipes goals_temp[0]
data modify storage searchcraft:recipes chest_top append from storage searchcraft:recipes goals_temp[1]
data modify storage searchcraft:recipes chest_top append from storage searchcraft:recipes goals_temp[2]

# repeat
#data modify storage searchcraft:recipes L append from storage searchcraft:recipes R[0]
data remove storage searchcraft:recipes R[0]
scoreboard players add column gui 1
execute if score column gui matches ..7 if data storage searchcraft:recipes R[0] run function searchcraft:gui/main_menu/load_recipes

gamemode adventure @a
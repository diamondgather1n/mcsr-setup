schedule function lobby:qgames/jump/jump_start 1t

scoreboard players add @p jumpCurrent 1
title @a actionbar ["",{"text":"Score: ","color":"#FFC53C"},{"score":{"name":"@p","objective":"jumpCurrent"},"color":"#FFC53C"}]

playsound minecraft:block.note_block.bell ambient @a ~ ~ ~ 0.5 0.2
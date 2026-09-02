scoreboard players add tick timer.temp 1
function practice:logger/update_timestamp
scoreboard players remove tick timer.temp 1

tellraw @a ["[",{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true},".",{"nbt":"miliseconds","storage":"timer","interpret":true},"] ",{"text":"Barter finish","color":"#f7821b"},": ",{"score":{"name":"@s","objective":"current_barter"}}]

scoreboard players reset @s current_barter

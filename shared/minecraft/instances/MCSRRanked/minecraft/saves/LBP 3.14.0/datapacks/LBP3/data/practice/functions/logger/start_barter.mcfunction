function practice:logger/update_timestamp

scoreboard players add barter_count current_barter 1
scoreboard players operation @s current_barter = barter_count current_barter

tellraw @a ["[",{"score":{"name":"minutes","objective":"timer.temp"}},":",{"nbt":"seconds","storage":"timer","interpret":true},".",{"nbt":"miliseconds","storage":"timer","interpret":true},"] ",{"text":"Barter Start","color":"#fcdc26"},": ",{"score":{"name":"@s","objective":"current_barter"}}]
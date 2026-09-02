execute store result score @s practice.barters run data get entity @s Brain.memories.minecraft:admiring_item.ttl
execute if score logger practice matches 1.. if score @s practice.barters matches 120 run function practice:logger/start_barter
execute if score logger practice matches 1.. if score @s practice.barters matches 1 run function practice:logger/finish_barter
execute if score @s practice.barters matches 1 run scoreboard players add total_barters practice.barters 1

scoreboard players reset @s practice.barters
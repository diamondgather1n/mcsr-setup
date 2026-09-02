# Count gold ingots on the ground
execute store result score @s practice.gold run data get entity @s Item.Count
scoreboard players operation total_gold practice.gold += @s practice.gold
execute at @s store result score @s practice.piglins if entity @e[type=piglin, tag=bastion_mob, distance=..1]
scoreboard players operation total_piglins practice.piglins > @s practice.piglins
scoreboard players reset @s practice.piglins
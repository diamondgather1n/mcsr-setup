execute positioned ~-8 ~2 ~11 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-11 ~6 ~7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-7 ~6 ~8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-9 ~7 ~9 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-11 ~2 ~7 as @e[type=piglin, tag=bastion_mob, dx=4, dy=4, dz=4] run data modify entity @s CustomName set value '{"text":"walls/side_wall_0","color":"yellow"}'
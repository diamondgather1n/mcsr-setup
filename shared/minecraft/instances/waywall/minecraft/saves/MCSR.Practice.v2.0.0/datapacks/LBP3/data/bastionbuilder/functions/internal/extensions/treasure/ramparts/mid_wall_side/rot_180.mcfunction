execute positioned ~-12 ~1 ~-3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-15 ~9 ~-7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-11 ~28 ~-5 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-11 ~28 ~-9 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-13 ~28 ~-7 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-11 ~29 ~-6 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~-11 ~29 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-15 ~1 ~-9 as @e[type=piglin, tag=bastion_mob, dx=4, dy=27, dz=6] run data modify entity @s CustomName set value '{"text":"ramparts/mid_wall_side","color":"yellow"}'
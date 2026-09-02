execute positioned ~5 ~1 ~-13 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~29 ~-11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~6 ~29 ~-12 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~8 ~29 ~-12 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~6 ~29 ~-11 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~8 ~29 ~-13 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~4 ~1 ~-13 as @e[type=piglin, tag=bastion_mob, dx=4, dy=28, dz=2] run data modify entity @s CustomName set value '{"text":"ramparts/mid_wall_main","color":"yellow"}'
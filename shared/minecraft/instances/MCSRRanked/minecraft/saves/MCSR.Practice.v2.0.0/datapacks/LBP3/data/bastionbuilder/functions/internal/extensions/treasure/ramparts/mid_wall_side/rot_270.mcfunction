execute positioned ~3 ~1 ~-12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~9 ~-15 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~5 ~28 ~-11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~9 ~28 ~-11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~7 ~28 ~-13 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~6 ~29 ~-11 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~29 ~-11 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~1 ~-15 as @e[type=piglin, tag=bastion_mob, dx=6, dy=27, dz=4] run data modify entity @s CustomName set value '{"text":"ramparts/mid_wall_side","color":"yellow"}'
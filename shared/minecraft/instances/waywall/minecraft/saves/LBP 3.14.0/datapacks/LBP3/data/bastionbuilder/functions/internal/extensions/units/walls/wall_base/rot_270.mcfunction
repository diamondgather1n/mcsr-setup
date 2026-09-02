execute positioned ~3 ~3 ~-2 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~10 ~6 ~-4 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~8 ~7 ~-5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~8 ~-4 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~3 ~12 ~-13 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~14 ~19 ~-11 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~12 ~19 ~-12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~5 ~4 ~-2 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~5 ~4 ~-3 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~3 ~-13 as @e[type=piglin, tag=bastion_mob, dx=11, dy=16, dz=11] run data modify entity @s CustomName set value '{"text":"walls/wall_base","color":"yellow"}'
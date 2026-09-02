execute positioned ~2 ~3 ~3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~6 ~10 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~5 ~7 ~8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~8 ~7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~13 ~12 ~3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~19 ~14 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~12 ~19 ~12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~2 ~4 ~5 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~3 ~4 ~5 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~2 ~3 ~3 as @e[type=piglin, tag=bastion_mob, dx=11, dy=16, dz=11] run data modify entity @s CustomName set value '{"text":"walls/wall_base","color":"yellow"}'
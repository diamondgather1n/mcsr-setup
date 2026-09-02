execute positioned ~6 ~4 ~-13 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~6 ~17 ~-7 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~7 ~17 ~-8 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~11 ~17 ~-8 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~9 ~17 ~-9 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~5 ~19 ~-3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~ ~13 ~2 run function bastionbuilder:internal/place/bridge/rampart_plates/plate_0/rot_270
execute positioned ~7 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~8 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~12 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~5 ~4 ~-13 as @e[type=piglin, tag=bastion_mob, dx=6, dy=15, dz=10] run data modify entity @s CustomName set value '{"text":"ramparts/rampart_1","color":"yellow"}'
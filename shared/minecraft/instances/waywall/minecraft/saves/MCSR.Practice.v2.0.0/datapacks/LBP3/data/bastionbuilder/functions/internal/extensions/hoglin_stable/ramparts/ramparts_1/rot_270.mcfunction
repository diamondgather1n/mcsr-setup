execute positioned ~6 ~4 ~-10 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~3 ~6 ~-7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~11 ~-3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~12 ~11 ~-3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~9 ~17 ~-7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~17 ~-9 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~7 ~17 ~-10 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~19 ~-4 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~ ~13 ~2 run function bastionbuilder:internal/place/hoglin_stable/rampart_plates/rampart_plate_1/rot_270
execute positioned ~7 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~8 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~11 ~17 ~-7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~4 ~-10 as @e[type=piglin, tag=bastion_mob, dx=9, dy=15, dz=7] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_1","color":"yellow"}'
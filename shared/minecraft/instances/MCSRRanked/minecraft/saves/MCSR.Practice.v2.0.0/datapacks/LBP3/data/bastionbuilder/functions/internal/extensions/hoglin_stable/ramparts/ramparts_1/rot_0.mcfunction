execute positioned ~10 ~4 ~6 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~6 ~3 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~3 ~11 ~11 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~3 ~11 ~12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~17 ~9 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~9 ~17 ~11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~10 ~17 ~7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~19 ~11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-2 ~13 ~ run function bastionbuilder:internal/place/hoglin_stable/rampart_plates/rampart_plate_1/rot_0
execute positioned ~7 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~8 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~11 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~4 ~3 as @e[type=piglin, tag=bastion_mob, dx=7, dy=15, dz=9] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_1","color":"yellow"}'
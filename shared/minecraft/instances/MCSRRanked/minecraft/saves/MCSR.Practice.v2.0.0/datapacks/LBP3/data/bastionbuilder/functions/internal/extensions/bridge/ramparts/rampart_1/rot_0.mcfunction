execute positioned ~13 ~4 ~6 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~7 ~17 ~6 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~8 ~17 ~7 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~8 ~17 ~11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~9 ~17 ~9 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~3 ~19 ~5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-2 ~13 ~ run function bastionbuilder:internal/place/bridge/rampart_plates/plate_0/rot_0
execute positioned ~7 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~8 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~12 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~4 ~5 as @e[type=piglin, tag=bastion_mob, dx=10, dy=15, dz=6] run data modify entity @s CustomName set value '{"text":"ramparts/rampart_1","color":"yellow"}'
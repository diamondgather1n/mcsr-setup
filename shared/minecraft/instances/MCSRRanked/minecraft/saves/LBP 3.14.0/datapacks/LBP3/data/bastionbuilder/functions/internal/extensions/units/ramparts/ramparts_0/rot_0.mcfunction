execute positioned ~7 ~17 ~9 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~8 ~17 ~5 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~9 ~17 ~12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~10 ~17 ~9 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~7 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~8 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~7 ~17 ~12 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~7 ~17 ~5 as @e[type=piglin, tag=bastion_mob, dx=3, dy=0, dz=7] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_0","color":"yellow"}'
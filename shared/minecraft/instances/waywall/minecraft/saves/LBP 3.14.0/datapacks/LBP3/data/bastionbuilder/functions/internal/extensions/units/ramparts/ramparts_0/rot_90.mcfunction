execute positioned ~-9 ~17 ~7 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-5 ~17 ~8 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-12 ~17 ~9 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-9 ~17 ~10 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-7 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~-8 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~-12 ~17 ~7 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-12 ~17 ~7 as @e[type=piglin, tag=bastion_mob, dx=7, dy=0, dz=3] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_0","color":"yellow"}'
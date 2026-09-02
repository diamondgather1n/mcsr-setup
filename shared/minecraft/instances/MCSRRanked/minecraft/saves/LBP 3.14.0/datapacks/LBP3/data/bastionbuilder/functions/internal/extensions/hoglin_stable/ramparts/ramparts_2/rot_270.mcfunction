execute positioned ~13 ~3 ~-7 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~11 ~3 ~-9 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~12 ~3 ~-11 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~13 ~3 ~-12 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~9 ~13 ~-3 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~11 ~3 ~-11 as @e[type=piglin, tag=bastion_mob, dx=2, dy=0, dz=4] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_2","color":"yellow"}'
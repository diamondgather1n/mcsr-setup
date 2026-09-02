execute positioned ~-7 ~3 ~-13 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-9 ~3 ~-11 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-11 ~3 ~-12 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-12 ~3 ~-13 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~-3 ~13 ~-9 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-11 ~3 ~-13 as @e[type=piglin, tag=bastion_mob, dx=4, dy=0, dz=2] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_2","color":"yellow"}'
execute positioned ~7 ~3 ~-7 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~7 ~3 ~-10 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~4 ~3 ~-6 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~7 ~3 ~-10 as @e[type=piglin, tag=bastion_mob, dx=0, dy=0, dz=3] run data modify entity @s CustomName set value '{"text":"ramparts/ramparts_3","color":"yellow"}'
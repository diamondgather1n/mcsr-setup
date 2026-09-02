execute positioned ~-9 ~3 ~14 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-6 ~5 ~13 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-7 ~13 ~3 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-9 ~3 ~13 as @e[type=piglin, tag=bastion_mob, dx=3, dy=2, dz=1] run data modify entity @s CustomName set value '{"text":"ramparts/rampart_0","color":"yellow"}'
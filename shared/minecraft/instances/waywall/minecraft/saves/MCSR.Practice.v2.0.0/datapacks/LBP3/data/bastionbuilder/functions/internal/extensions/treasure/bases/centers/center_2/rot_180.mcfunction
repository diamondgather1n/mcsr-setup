execute positioned ~-1 ~2 ~-1 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~-4 ~2 ~-6 run function bastionbuilder:internal/place/mobs/piglin
execute positioned ~-1 ~2 ~-4 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~-4 ~2 ~-6 as @e[type=piglin, tag=bastion_mob, dx=3, dy=0, dz=5] run data modify entity @s CustomName set value '{"text":"bases/centers/center_2","color":"yellow"}'
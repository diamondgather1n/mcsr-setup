execute positioned ~5 ~3 ~3 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~5 ~3 ~4 run function bastionbuilder:internal/place/mobs/piglin_melee
execute positioned ~2 ~3 ~6 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute positioned ~4 ~3 ~6 run function bastionbuilder:internal/utils/chest_loot/mark_chest
execute if score id_piglins bastion.settings matches 1.. positioned ~5 ~3 ~3 as @e[type=piglin, tag=bastion_mob, dx=0, dy=0, dz=1] run data modify entity @s CustomName set value '{"text":"bases/centers/center_1","color":"yellow"}'
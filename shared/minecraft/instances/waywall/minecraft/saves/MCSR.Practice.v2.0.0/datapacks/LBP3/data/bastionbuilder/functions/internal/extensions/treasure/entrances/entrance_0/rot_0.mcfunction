execute positioned ~3 ~3 ~7 run function bastionbuilder:internal/place/mobs/piglin

execute if score id_piglins bastion.settings matches 1.. positioned ~3 ~3 ~7 as @e[type=piglin, tag=bastion_mob, dx=0, dy=0, dz=0] run data modify entity @s CustomName set value '{"text":"entrances/entrance_0","color":"yellow"}'
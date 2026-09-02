function bastionbuilder:internal/utils/save_settings
gamerule doMobLoot false
gamerule doTileDrops false
tag @e[type=magma_cube] add bastion_mob
execute as @e[tag=bastion_mob] at @s run tp ~ -100 ~
kill @e[tag=bastion_mob]
kill @e[type=area_effect_cloud, tag=bastion_chest]
kill @e[type=area_effect_cloud, tag=lava_fix_bridge]
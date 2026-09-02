clear @p
gamemode survival @p
fill -174 93 30 -164 84 -6 air replace dirt
fill -174 93 30 -164 84 -6 air replace soul_sand

setblock -169 87 -9 minecraft:redstone_block

# Item giving
execute as @p at @p if score @p bridgeType matches 1 run give @p dirt 64
execute as @p at @p if score @p bridgeType matches 2 run give @p soul_sand 64
execute as @p at @p if score @p bridgeType matches 3 run give @p soul_sand 64
execute as @p at @p if score @p bridgeType matches 3 run replaceitem entity @p armor.feet iron_boots{Enchantments:[{lvl:1,id:soul_speed}]}
execute as @p at @p if score @p bridgeType matches 4 run give @p soul_sand 64
execute as @p at @p if score @p bridgeType matches 4 run replaceitem entity @p armor.feet iron_boots{Enchantments:[{lvl:2,id:soul_speed}]}
execute as @p at @p if score @p bridgeType matches 5 run give @p soul_sand 64
execute as @p at @p if score @p bridgeType matches 5 run replaceitem entity @p armor.feet iron_boots{Enchantments:[{lvl:3,id:soul_speed}]}

# Clear items and teleport
kill @e[type=item]
tp @p -169 88 27 180 0

playsound minecraft:block.note_block.harp player @a[tag=sound] ~ ~ ~ 100 0.7

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1

# Reset timer
scoreboard players set timer timer 0
scoreboard players set timer settings 1

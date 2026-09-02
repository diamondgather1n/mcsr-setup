setblock -130 89 23 minecraft:air

kill @e[type=boat]
clear @p
gamemode adventure @p

tp @p -153 90 29 90 0

playsound minecraft:entity.item_frame.add_item player @a[tag=sound] ~ ~ ~ 100 0.2

effect give @a minecraft:instant_health 10 10 true
effect give @a minecraft:saturation 1 1
